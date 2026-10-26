# Copyright 2026 bazel_rules_hdl Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Verilator-specific cocotb test rule."""

load("@bazel_skylib//lib:paths.bzl", "paths")
load("@bazel_tools//tools/cpp:toolchain_utils.bzl", "find_cpp_toolchain")
load("@rules_cc//cc:defs.bzl", "CcInfo")
load("@rules_cc//cc/common:cc_common.bzl", "cc_common")
load("//cocotb:private/common.bzl", "COCOTB_TEST_ATTRS", "create_prebuilt_cocotb_test")
load("//verilator:defs.bzl", "verilator_build_binary")
load("//verilog:defs.bzl", "VerilogInfo")

def _wave_config(wave_format):
    return {
        "fst": struct(
            defines = ["VM_TRACE=1", "VM_TRACE_FST=1"],
            trace = True,
            trace_format = "fst",
        ),
        "none": struct(
            defines = ["VM_TRACE=0"],
            trace = False,
            trace_format = None,
        ),
        "vcd": struct(
            defines = ["VM_TRACE=1"],
            trace = True,
            trace_format = "vcd",
        ),
    }[wave_format]

def _find_single_file(files, suffix):
    matches = [file for file in files if file.path.endswith(suffix)]

    if not matches:
        fail("No file ending in '{}' was found".format(suffix))

    if len(matches) > 1:
        fail("Expected one file ending in '{}', but found {}: {}".format(
            suffix,
            len(matches),
            [file.path for file in matches],
        ))

    return matches[0]

def _cocotb_vpi_cc_info(ctx, dynamic_libraries):
    cc_toolchain = find_cpp_toolchain(ctx)
    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
        requested_features = ctx.features,
        unsupported_features = ctx.disabled_features,
    )
    libraries_to_link = [
        cc_common.create_library_to_link(
            actions = ctx.actions,
            feature_configuration = feature_configuration,
            cc_toolchain = cc_toolchain,
            dynamic_library = dynamic_library,
        )
        for dynamic_library in dynamic_libraries
    ]
    linker_input = cc_common.create_linker_input(
        owner = ctx.label,
        libraries = depset(libraries_to_link),
        user_link_flags = ["-rdynamic", "-latomic", "-ldl"],
    )
    return CcInfo(
        compilation_context = cc_common.create_compilation_context(),
        linking_context = cc_common.create_linking_context(
            linker_inputs = depset([linker_input]),
        ),
    )

def _cocotb_verilator_support_impl(ctx):
    cocotb_files = ctx.attr._cocotb_files[DefaultInfo].files.to_list()
    cocotb_main = _find_single_file(
        cocotb_files,
        "/site-packages/cocotb/share/lib/verilator/verilator.cpp",
    )
    cocotb_libraries = [
        _find_single_file(
            cocotb_files,
            "/site-packages/cocotb/libs/{}".format(library),
        )
        for library in ["libcocotbvpi_verilator.so", "libgpi.so"]
    ]
    return [
        DefaultInfo(files = depset([cocotb_main] + cocotb_libraries)),
        _cocotb_vpi_cc_info(ctx, cocotb_libraries),
    ]

cocotb_verilator_support = rule(
    implementation = _cocotb_verilator_support_impl,
    attrs = {
        "_cc_toolchain": attr.label(
            default = Label("@bazel_tools//tools/cpp:current_cc_toolchain"),
        ),
        "_cocotb_files": attr.label(
            default = Label("@rules_hdl_pip_deps_to_vendor//cocotb:extracted_whl_files"),
        ),
    },
    provides = [CcInfo],
    toolchains = ["@bazel_tools//tools/cpp:toolchain_type"],
    fragments = ["cpp"],
)

def _build_cocotb_verilator_simulator(ctx):
    if ctx.files.vhdl_sources:
        fail("cocotb_test_verilator does not support VHDL sources")
    if not ctx.attr.verilog_libraries:
        fail("cocotb_test_verilator requires at least one verilog_library")

    cocotb_support = ctx.attr._cocotb_support
    cocotb_support_files = cocotb_support[DefaultInfo].files.to_list()
    cocotb_main = _find_single_file(
        cocotb_support_files,
        "/site-packages/cocotb/share/lib/verilator/verilator.cpp",
    )
    cocotb_libraries = [
        file
        for file in cocotb_support_files
        if file.extension == "so"
    ]

    user_vopts = list(ctx.attr.build_args)
    user_vopts.extend([
        "-D{}={}".format(key, ctx.attr.defines[key])
        for key in sorted(ctx.attr.defines.keys())
    ])
    user_vopts.extend([
        "-G{}={}".format(key, ctx.attr.parameters[key])
        for key in sorted(ctx.attr.parameters.keys())
    ])
    wave_config = _wave_config(ctx.attr.waves)
    linked = verilator_build_binary(
        ctx,
        verilog_dags = [library[VerilogInfo].dag for library in ctx.attr.verilog_libraries],
        module_top = ctx.attr.hdl_toplevel,
        extra_srcs = [cocotb_main],
        extra_deps = [cocotb_support],
        extra_runfiles = cocotb_libraries,
        trace = wave_config.trace,
        trace_format = wave_config.trace_format,
        opts = ["--vpi", "--public-flat-rw"],
        user_vopts = user_vopts,
        prefix = "Vtop",
        defines = wave_config.defines,
    )[0]

    simulator = ctx.actions.declare_file(
        ctx.label.name + "_prebuilt/" + ctx.attr.hdl_toplevel,
    )
    ctx.actions.symlink(
        output = simulator,
        target_file = linked.files.to_list()[0],
        is_executable = True,
    )
    return simulator, linked.default_runfiles

def _cocotb_test_verilator_impl(ctx):
    simulator, simulator_runfiles = _build_cocotb_verilator_simulator(ctx)
    wrapper_args = ["${TEST_TMPDIR:+--results_xml=$TEST_TMPDIR/results.xml}"]
    if ctx.attr.waves != "none":
        wrapper_args.append("${TEST_UNDECLARED_OUTPUTS_DIR:+--test_dir=$TEST_UNDECLARED_OUTPUTS_DIR}")
    return create_prebuilt_cocotb_test(
        ctx,
        build_dir = paths.dirname(simulator.short_path),
        wrapper_args = wrapper_args,
        extra_files = [simulator],
        extra_runfiles = [simulator_runfiles],
    )

_cocotb_test_verilator_attrs = dict(COCOTB_TEST_ATTRS)
_cocotb_test_verilator_attrs.update({
    "cocotb_wrapper": attr.label(
        cfg = "exec",
        executable = True,
        default = Label("//cocotb:cocotb_wrapper_verilator"),
    ),
    "copts": attr.string_list(
        doc = "Additional C++ compilation flags",
        default = [],
    ),
    "sim_tools": attr.label_list(
        doc = "Runtime simulator tools; empty for the prebuilt Verilator flow",
        default = [],
    ),
    "_cc_toolchain": attr.label(
        default = Label("@bazel_tools//tools/cpp:current_cc_toolchain"),
    ),
    "_cocotb_support": attr.label(
        default = Label("//cocotb:cocotb_verilator_support"),
        providers = [CcInfo],
    ),
    "_copy_tree": attr.label(
        cfg = "exec",
        executable = True,
        default = Label("//common:copy_tree"),
    ),
    "_process_wrapper": attr.label(
        cfg = "exec",
        executable = True,
        default = Label("//verilator/private:verilator_process_wrapper"),
    ),
})

_cocotb_test_verilator_test = rule(
    implementation = _cocotb_test_verilator_impl,
    attrs = _cocotb_test_verilator_attrs,
    toolchains = [
        "@bazel_tools//tools/cpp:toolchain_type",
        "@rules_hdl//verilator:toolchain_type",
        "@rules_python//python:toolchain_type",
    ],
    fragments = ["cpp"],
    test = True,
)

def cocotb_test_verilator(name, **kwargs):
    """Create a Verilator-backed cocotb test."""
    return _cocotb_test_verilator_test(name = name, **kwargs)
