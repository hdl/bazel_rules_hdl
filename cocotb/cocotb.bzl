# Copyright 2023 Antmicro
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

"""Rules for running tests using Cocotb framework"""

load("@rules_python//python:defs.bzl", "PyInfo")
load("//verilog:providers.bzl", "VerilogInfo")

## Helpers for parsing arguments

def _list_to_argstring(data, argname, attr = None, operation = None):
    result = " --{}".format(argname) if data else ""
    for value in data:
        elem = value if attr == None else getattr(value, attr)
        elem = elem if operation == None else operation(elem)
        result += " {}".format(elem)
    return result

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
    transitive_srcs_list = [
        dep
        for dep in ctx.attr.verilog_sources
        if VerilogInfo in dep
    ]
    transitive_srcs_depset = depset(
        [],
        transitive = [dep[VerilogInfo].dag for dep in transitive_srcs_list],
    )
    verilog_srcs = [
        verilog_info_struct.srcs
        for verilog_info_struct in transitive_srcs_depset.to_list()
    ]

    return depset(
        [src for sub_tuple in verilog_srcs for src in sub_tuple] +
        ctx.files.verilog_sources,
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
    py_toolchain = ctx.toolchains["@bazel_tools//tools/python:toolchain_type"].py3_runtime
    return depset(
        direct = [py_toolchain.interpreter],
        transitive = [dep[PyInfo].transitive_sources for dep in ctx.attr.deps] +
                     [ctx.attr.cocotb_wrapper[PyInfo].transitive_sources] +
                     [py_toolchain.files],
    )

def _collect_transitive_runfiles(ctx):
    return ctx.runfiles().merge_all(
        [dep.default_runfiles for dep in ctx.attr.deps] +
        [dep.default_runfiles for dep in ctx.attr.sim],
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
    sim_paths = _remove_duplicates_from_list([dep.label.workspace_root for dep in ctx.attr.sim])
    path = ":".join(["$PWD/" + str(p) for p in sim_paths])
    return path

def _get_test_command(ctx, verilog_files, vhdl_files):
    vhdl_sources_args = _files_to_argstring(vhdl_files, "vhdl_sources")
    verilog_sources_args = _files_to_argstring(verilog_files, "verilog_sources")

    includes_args = _list_to_argstring(ctx.attr.includes, "includes")
    testcase_args = _list_to_argstring(ctx.attr.testcase, "testcase")
    build_args = _list_to_argstring(ctx.attr.build_args, "build_args")
    gpi_interfaces_args = _list_to_argstring(ctx.attr.gpi_interfaces, "gpi_interfaces")
    test_args = _list_to_argstring(ctx.attr.test_args, "test_args")
    plus_args = _list_to_argstring(ctx.attr.plus_args, "plus_args")
    extra_env_args = _list_to_argstring(ctx.attr.extra_env, "extra_env")

    defines_args = _dict_to_argstring(ctx.attr.defines, "defines")
    parameters_args = _dict_to_argstring(ctx.attr.parameters, "parameters")
    verbose_args = " --verbose" if ctx.attr.verbose else ""
    waves_args = " --waves" if ctx.attr.waves else ""
    seed_args = " --seed {}".format(ctx.attr.seed) if ctx.attr.seed != "" else ""

    test_module_args = _pymodules_to_argstring(ctx.files.test_module, "test_module")

    command = (
        "PATH={}:$PATH ".format(_get_path_to_set(ctx)) +
        "python {}".format(ctx.executable.cocotb_wrapper.short_path) +
        " --sim {}".format(ctx.attr.sim_name) +
        " --hdl_library {}".format(ctx.attr.hdl_library) +
        " --hdl_toplevel {}".format(ctx.attr.hdl_toplevel) +
        " --hdl_toplevel_lang {}".format(ctx.attr.hdl_toplevel_lang) +
        verilog_sources_args +
        vhdl_sources_args +
        includes_args +
        testcase_args +
        build_args +
        gpi_interfaces_args +
        test_args +
        plus_args +
        extra_env_args +
        defines_args +
        parameters_args +
        verbose_args +
        waves_args +
        seed_args +
        test_module_args
    )

    return command

def _cocotb_test_impl(ctx):
    verilog_files = _collect_verilog_files(ctx).to_list()
    vhdl_files = _collect_vhdl_files(ctx).to_list()

    # create test script
    runner_script = ctx.actions.declare_file("cocotb_runner.sh")
    ctx.actions.write(
        output = runner_script,
        content = _get_test_command(ctx, verilog_files, vhdl_files),
    )

    # specify dependencies for the script
    runfiles = ctx.runfiles(
        files = ctx.files.cocotb_wrapper +
                verilog_files +
                vhdl_files +
                ctx.files.test_module,
        transitive_files = _collect_transitive_files(ctx),
    ).merge(
        _collect_transitive_runfiles(ctx),
    )

    # specify PYTHONPATH for the script
    env = {"PYTHONPATH": _get_pythonpath_to_set(ctx)}

    # return the information about testing script and its dependencies
    return [
        DefaultInfo(executable = runner_script, runfiles = runfiles),
        testing.TestEnvironment(env),
    ]

_cocotb_test_attrs = {
    "sim": attr.label_list(
        doc = "Simulator to use",
        default = [
            Label("@com_icarus_iverilog//:iverilog"),
            Label("@com_icarus_iverilog//:vvp"),
        ],
    ),
    "sim_name": attr.string(
        doc = "Simulator name used in Cocotb",
        default = "icarus",
        values = ["ghdl", "icarus", "questa", "verilator", "vcs"],
    ),
    "hdl_library": attr.string(
        doc = "The library name to compile into",
        default = "top",
    ),
    "verilog_sources": attr.label_list(
        doc = "Verilog source files to build",
        providers = [VerilogInfo],
        allow_files = True,
        default = [],
    ),
    "vhdl_sources": attr.label_list(
        doc = "VHDL source files to build",
        allow_files = [".vhd", ".vhdl"],
        default = [],
    ),
    "includes": attr.string_list(
        doc = "Verilog include directories",
        default = [],
    ),
    "defines": attr.string_dict(
        doc = "Defines to set",
        default = {},
    ),
    "parameters": attr.string_dict(
        doc = "Verilog parameters or VHDL generics",
        default = {},
    ),
    "build_args": attr.string_list(
        doc = "Extra build arguments for the simulator",
        default = [],
    ),
    "hdl_toplevel": attr.string(
        doc = "The name of the HDL toplevel module",
        mandatory = True,
    ),
    "verbose": attr.bool(
        doc = "Enable verbose messages",
        default = False,
    ),
    "test_module": attr.label_list(
        doc = "Name(s) of the Python module(s) containing the tests to run",
        allow_files = [".py"],
        allow_empty = False,
        mandatory = True,
    ),
    "hdl_toplevel_lang": attr.string(
        doc = "Language of the HDL toplevel module",
        mandatory = True,
    ),
    "gpi_interfaces": attr.string_list(
        doc = "List of GPI interfaces to use, with the first one being the entry point",
        default = [],
    ),
    "testcase": attr.string_list(
        doc = "Name(s) of a specific testcase(s) to run. If not set, run all testcases found in *test_module*",
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
    "plus_args": attr.string_list(
        doc = "'plusargs' to set for the simulator",
        default = [],
    ),
    "extra_env": attr.string_list(
        doc = "Extra environment variables to set",
        default = [],
    ),
    "waves": attr.bool(
        doc = "Record signal traces",
        default = True,
    ),
    "deps": attr.label_list(
        doc = "The list of python libraries to be linked in to the simulation target",
        providers = [PyInfo],
    ),
    "cocotb_wrapper": attr.label(
        cfg = "exec",
        executable = True,
        doc = "Cocotb wrapper script",
        default = Label("//cocotb:cocotb_wrapper"),
    ),
}

cocotb_test = rule(
    implementation = _cocotb_test_impl,
    attrs = _cocotb_test_attrs,
    toolchains = ["@bazel_tools//tools/python:toolchain_type"],
    test = True,
)
