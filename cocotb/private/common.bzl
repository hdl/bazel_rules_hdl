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

"""Shared implementation for cocotb test rules."""

load("@bazel_skylib//lib:paths.bzl", "paths")
load("@rules_python//python:defs.bzl", "PyInfo")
load("//verilog:defs.bzl", "VerilogInfo")

## Helpers for parsing arguments

def _list_to_argstring(data, argname, attr = None, operation = None):
    result = " --{}".format(argname) if data else ""
    for value in data:
        elem = value if attr == None else getattr(value, attr)
        elem = elem if operation == None else operation(elem)
        result += " {}".format(elem)
    return result

def _repeated_argstring(data, argname):
    return "".join([" --{}={}".format(argname, value) for value in data])

def _dict_to_argstring(data, argname):
    result = " --{}".format(argname) if data else ""
    for key, value in data.items():
        result += " {}={}".format(key, value)
    return result

def _files_to_argstring(data, argname):
    return _list_to_argstring(data, argname, "short_path")

def _pymodules_to_argstring(data, argname):
    remove_py = lambda s: s.removesuffix(".py")
    return _list_to_argstring(data, argname, "basename", remove_py)

def _remove_duplicates_from_list(data):
    result = []
    for e in data:
        if e not in result:
            result.append(e)
    return result

# Helpers for collecting information from context

def _collect_verilog_files(ctx):
    verilog_info = depset(
        [],
        transitive = [library[VerilogInfo].dag for library in ctx.attr.verilog_libraries],
    ).to_list()

    return (
        depset([src for entry in verilog_info for src in entry.srcs]),
        depset([hdr for entry in verilog_info for hdr in entry.hdrs]),
        depset([data for entry in verilog_info for data in entry.data]),
    )

def _collect_vhdl_files(ctx):
    return depset(direct = ctx.files.vhdl_sources)

def _collect_python_transitive_imports(ctx):
    return depset(transitive = [
        dep[PyInfo].imports
        for dep in ctx.attr.deps
        if PyInfo in dep
    ])

def _collect_python_direct_imports(ctx):
    return depset(direct = [module.dirname for module in ctx.files.test_module])

def _collect_transitive_files(ctx):
    py_toolchain = ctx.toolchains["@rules_python//python:toolchain_type"].py3_runtime
    return depset(
        direct = [py_toolchain.interpreter],
        transitive = [dep[PyInfo].transitive_sources for dep in ctx.attr.deps] +
                     [ctx.attr.cocotb_wrapper[PyInfo].transitive_sources] +
                     [py_toolchain.files],
    )

def _collect_transitive_runfiles(ctx):
    return ctx.runfiles().merge_all(
        [dep.default_runfiles for dep in ctx.attr.deps] +
        [dep.default_runfiles for dep in ctx.attr.sim_tools] +
        [ctx.attr.cocotb_wrapper.default_runfiles],
    )

# Helpers for preparing test script and its environment

def _get_pythonpath_to_set(ctx):
    direct_imports = _collect_python_direct_imports(ctx).to_list()
    transitive_imports = [
        "../" + path
        for path in _collect_python_transitive_imports(ctx).to_list()
    ]
    imports = _remove_duplicates_from_list(transitive_imports + direct_imports)
    return ":".join(imports)

def _get_path_to_set(ctx):
    path_elements = []
    for dep in ctx.attr.sim_tools:
        if dep[DefaultInfo].files_to_run.executable:
            short_path = dep[DefaultInfo].files_to_run.executable.short_path
            path_elements.append("$PWD/" + short_path.rpartition("/")[0])
    return ":".join(_remove_duplicates_from_list(path_elements))

def _get_build_args(ctx, verilog_files, verilog_headers, vhdl_files):
    vhdl_sources_args = _files_to_argstring(vhdl_files, "vhdl_sources")
    verilog_sources_args = _files_to_argstring(verilog_files, "verilog_sources")

    includes = _remove_duplicates_from_list([paths.dirname(header.short_path) or "." for header in verilog_headers])
    includes_args = _list_to_argstring(includes, "includes")

    # Use the --option=value form so argparse does not interpret simulator
    # flags such as "-Wno-*" as options belonging to this wrapper.
    build_args = _repeated_argstring(ctx.attr.build_args, "build_args")
    defines_args = _dict_to_argstring(ctx.attr.defines, "defines")

    return (
        " --hdl_library {}".format(ctx.attr.hdl_library) +
        verilog_sources_args +
        vhdl_sources_args +
        includes_args +
        build_args +
        defines_args
    )

def _get_test_command(ctx, build_args = "", build_dir = None, wrapper_args = []):
    testcase_args = _repeated_argstring(ctx.attr.testcase, "testcase")
    gpi_interfaces_args = _repeated_argstring(ctx.attr.gpi_interfaces, "gpi_interfaces")
    test_args = _repeated_argstring(ctx.attr.test_args, "test_args")
    plus_args = _repeated_argstring(ctx.attr.plus_args, "plusargs")
    extra_env_args = _list_to_argstring(ctx.attr.extra_env, "extra_env")

    parameters_args = _dict_to_argstring(ctx.attr.parameters, "parameters")
    verbose_args = " --verbose" if ctx.attr.verbose else ""
    waves_args = " --waves" if ctx.attr.waves != "none" else ""
    seed_args = " --seed {}".format(ctx.attr.seed) if ctx.attr.seed != "" else ""

    test_module_args = _pymodules_to_argstring(ctx.files.test_module, "test_module")
    python_interpreter = ctx.toolchains["@rules_python//python:toolchain_type"].py3_runtime.interpreter.short_path
    build_dir_arg = " --build_dir \"$PWD/{}\"".format(build_dir) if build_dir else ""
    wrapper_args_string = " " + " ".join(wrapper_args) if wrapper_args else ""
    simulator_path = _get_path_to_set(ctx)
    path_env = "PATH={}:$PATH ".format(simulator_path) if simulator_path else ""

    command = (
        path_env +
        str(python_interpreter) +
        " {}".format(ctx.executable.cocotb_wrapper.short_path) +
        " --hdl_toplevel {}".format(ctx.attr.hdl_toplevel) +
        " --hdl_toplevel_lang {}".format(ctx.attr.hdl_toplevel_lang) +
        build_args +
        testcase_args +
        gpi_interfaces_args +
        test_args +
        plus_args +
        extra_env_args +
        parameters_args +
        verbose_args +
        waves_args +
        seed_args +
        test_module_args +
        build_dir_arg +
        wrapper_args_string
    )
    return command

def _create_cocotb_test(ctx, hdl_files, build_args = "", build_dir = None, wrapper_args = [], extra_files = [], extra_runfiles = []):
    runner_script = ctx.actions.declare_file(ctx.label.name + "_cocotb_runner.sh")
    ctx.actions.write(
        output = runner_script,
        content = _get_test_command(
            ctx,
            build_args = build_args,
            build_dir = build_dir,
            wrapper_args = wrapper_args,
        ),
    )

    runfiles = ctx.runfiles(
        files = ctx.files.cocotb_wrapper +
                hdl_files +
                ctx.files.test_module +
                extra_files,
        transitive_files = _collect_transitive_files(ctx),
    ).merge(
        _collect_transitive_runfiles(ctx),
    ).merge_all(extra_runfiles)

    env = {"PYTHONPATH": _get_pythonpath_to_set(ctx)}
    return [
        DefaultInfo(executable = runner_script, runfiles = runfiles),
        testing.TestEnvironment(env),
    ]

def create_cocotb_test(ctx, wrapper_args = []):
    """Create a cocotb test that builds its simulator at test time.

    Args:
      ctx: Rule context for the cocotb test.
      wrapper_args: Additional command-line arguments for the cocotb wrapper, as a list.

    Returns:
      Providers for the executable test runner and its test environment.
    """
    verilog_files, verilog_headers, verilog_data = _collect_verilog_files(ctx)
    verilog_files = verilog_files.to_list()
    verilog_headers = verilog_headers.to_list()
    verilog_data = verilog_data.to_list()
    vhdl_files = _collect_vhdl_files(ctx).to_list()

    return _create_cocotb_test(
        ctx,
        hdl_files = verilog_files + verilog_headers + verilog_data + vhdl_files,
        build_args = _get_build_args(ctx, verilog_files, verilog_headers, vhdl_files),
        wrapper_args = wrapper_args,
    )

def create_prebuilt_cocotb_test(ctx, build_dir, wrapper_args = [], extra_files = [], extra_runfiles = []):
    """Create a cocotb test that runs a simulator built by Bazel.

    Args:
      ctx: Rule context for the cocotb test.
      build_dir: Runfiles-relative directory containing the built simulator.
      wrapper_args: Additional command-line arguments for the cocotb wrapper, as a list.
      extra_files: Additional files required by the simulator at runtime.
      extra_runfiles: Additional runfiles objects required by the simulator.

    Returns:
      Providers for the executable test runner and its test environment.
    """
    _, _, verilog_data = _collect_verilog_files(ctx)
    return _create_cocotb_test(
        ctx,
        hdl_files = verilog_data.to_list(),
        build_dir = build_dir,
        wrapper_args = wrapper_args,
        extra_files = extra_files,
        extra_runfiles = extra_runfiles,
    )

COCOTB_TEST_ATTRS = {
    "build_args": attr.string_list(
        doc = "Extra build arguments for the simulator",
        default = [],
    ),
    "defines": attr.string_dict(
        doc = "Defines to set",
        default = {},
    ),
    "deps": attr.label_list(
        doc = "The list of python libraries to be linked in to the simulation target",
        default = [Label("@rules_hdl_pip_deps_to_vendor//cocotb")],
        providers = [PyInfo],
    ),
    "extra_env": attr.string_list(
        doc = "Extra environment variables to set",
        default = [],
    ),
    "gpi_interfaces": attr.string_list(
        doc = "List of GPI interfaces to use, with the first one being the entry point",
        default = [],
    ),
    "hdl_library": attr.string(
        doc = "The library name to compile into",
        default = "top",
    ),
    "hdl_toplevel": attr.string(
        doc = "The name of the HDL toplevel module",
        mandatory = True,
    ),
    "hdl_toplevel_lang": attr.string(
        doc = "Language of the HDL toplevel module",
        default = "verilog",
    ),
    "parameters": attr.string_dict(
        doc = "Verilog parameters or VHDL generics",
        default = {},
    ),
    "plus_args": attr.string_list(
        doc = "'plusargs' to set for the simulator",
        default = [],
    ),
    "seed": attr.string(
        doc = "A specific random seed to use",
        default = "",
    ),
    "test_args": attr.string_list(
        doc = "Extra arguments for the simulator",
        default = [],
    ),
    "test_module": attr.label_list(
        doc = "Name(s) of the Python module(s) containing the tests to run",
        allow_files = [".py"],
        allow_empty = False,
        mandatory = True,
    ),
    "testcase": attr.string_list(
        doc = "Name(s) of a specific testcase(s) to run. If not set, run all testcases found in *test_module*",
        default = [],
    ),
    "verbose": attr.bool(
        doc = "Enable verbose messages",
        default = False,
    ),
    "verilog_libraries": attr.label_list(
        doc = "Verilog libraries to build",
        providers = [VerilogInfo],
        default = [],
    ),
    "vhdl_sources": attr.label_list(
        doc = "VHDL source files to build",
        allow_files = [".vhd", ".vhdl"],
        default = [],
    ),
    "waves": attr.string(
        doc = "Waveform format. Use 'none' to disable signal traces.",
        default = "fst",
        values = ["none", "vcd", "fst"],
    ),
}
