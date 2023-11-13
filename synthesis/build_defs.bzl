# Copyright 2021 Google LLC
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

"""Rules for synthesizing (System)Verilog code."""

load("@rules_hdl//pdk:build_defs.bzl", "StandardCellInfo")
load("//verilog:providers.bzl", "VerilogInfo")

# There are no rules to generate this provider, but it does provide the mechansim to build
# rules based on surelog in the open source world.
UhdmInfo = provider(
    "Surelog/UHDM based RTL representation",
    fields = {
        "uhdm": "UHDM file representing the rtl circuit",
    },
)

ExternalSynthesisInfo = provider(
    "Surelog/UHDM based RTL representation",
    fields = {
        "env": "Map of env variables",
        "yosys_script": "yosys script file",
        "inputs": "File inputs",
        "verilog_files": "Verilog Inputs",
        "uhdm_files": "UHDM files",
    },
)

# Args:
#    standard_cell_info: The StandardCellInfo provider this target was synthesized against.
#    synthesized_netlist: The structural verilog syntheized with standard_cell_info
#    top_module: The name of the top level module of the synthesized netlist
#    log_file: Log output file from the synthesis step.
SynthesisInfo = provider(
    "Information about the synthesis target",
    fields = ["standard_cell_info", "synthesized_netlist", "top_module", "log_file"],
)

def _transitive_srcs(deps):
    return depset(
        [],
        transitive = [dep[VerilogInfo].dag for dep in deps],
    )

def _create_flist(ctx, flist_tag, files, short_path = False):
    flist = ctx.actions.declare_file("{}_{}.flist".format(flist_tag, ctx.attr.name))
    if short_path:
        ctx.actions.write(flist, "\n".join([f.short_path for f in files]) + "\n")
    else:
        ctx.actions.write(flist, "\n".join([f.path for f in files]) + "\n")
    return flist

def _synthesize_design_impl(ctx):
    transitive_srcs = _transitive_srcs([dep for dep in ctx.attr.deps if VerilogInfo in dep])
    verilog_srcs = [verilog_info_struct.srcs for verilog_info_struct in transitive_srcs.to_list()]
    verilog_files = [src for sub_tuple in verilog_srcs for src in sub_tuple]

    verilog_flist = _create_flist(
        ctx,
        flist_tag = "verilog",
        files = verilog_files,
    )

    uhdm_files = depset(
        [],
        transitive = [dep[UhdmInfo].uhdm for dep in ctx.attr.deps if UhdmInfo in dep],
    ).to_list()

    uhdm_flist = _create_flist(
        ctx,
        flist_tag = "uhdm",
        files = uhdm_files,
    )

    output_file_name = "{}_synth_output.v".format(ctx.attr.name)
    if ctx.attr.output_file_name:
        output_file_name = ctx.attr.output_file_name
    output_file = ctx.actions.declare_file(output_file_name)
    default_liberty_file = ctx.attr.standard_cells[StandardCellInfo].default_corner.liberty

    synth_tcl = ctx.file.synth_tcl

    inputs = []
    inputs.extend(verilog_files)
    inputs.append(verilog_flist)
    inputs.append(uhdm_flist)
    inputs.extend(uhdm_files)
    inputs.append(synth_tcl)
    inputs.append(default_liberty_file)

    (tool_inputs, input_manifests) = ctx.resolve_tools(tools = [ctx.attr.yosys_tool])

    yosys_runfiles_dir = ctx.executable.yosys_tool.path + ".runfiles"

    log_file = ctx.actions.declare_file("{}_yosys_output.log".format(ctx.attr.name))

    args = ctx.actions.args()
    args.add("-q")  # quiet mode only errors printed to stderr
    args.add("-q")  # second q don't print warnings
    args.add("-Q")  # Don't print header
    args.add_all("-l", [log_file])  # put output in log file
    args.add_all("-c", [synth_tcl])  # run synthesis tcl script

    dont_use_args = ""
    or_config = ctx.attr.standard_cells[StandardCellInfo].open_road_configuration
    if or_config:
        for dont_use_pattern in or_config.do_not_use_cell_list:
            dont_use_args += " -dont_use {} ".format(dont_use_pattern)

    script_env_files = {
        "FLIST": verilog_flist,
        "UHDM_FLIST": uhdm_flist,
        "TOP": ctx.attr.top_module,
        "OUTPUT": output_file,
        "LIBERTY": default_liberty_file,
        "DONT_USE_ARGS": dont_use_args,
    }

    if ctx.attr.target_clock_period_pico_seconds:
        script_env_files["CLOCK_PERIOD"] = str(ctx.attr.target_clock_period_pico_seconds)

    env = {
        "YOSYS_DATDIR": yosys_runfiles_dir + "/at_clifford_yosys/techlibs/",
        "ABC": yosys_runfiles_dir + "/edu_berkeley_abc/abc",
    }

    for k, v in script_env_files.items():
        if type(v) == "File":
            env[k] = v.path
        else:
            env[k] = v

    ctx.actions.run(
        outputs = [output_file, log_file],
        inputs = inputs + tool_inputs.to_list(),
        arguments = [args],
        executable = ctx.executable.yosys_tool,
        tools = tool_inputs,
        input_manifests = input_manifests,
        env = env,
        mnemonic = "SynthesizingRTL",
	toolchain = None,
    )

    return [
        DefaultInfo(
            runfiles = ctx.runfiles(files = [output_file, log_file]),
            files = depset([output_file, log_file]),
        ),
        SynthesisInfo(
            standard_cell_info = ctx.attr.standard_cells[StandardCellInfo],
            synthesized_netlist = output_file,
            top_module = ctx.attr.top_module,
            log_file = log_file,
        ),
        ExternalSynthesisInfo(
            env = script_env_files,
            yosys_script = synth_tcl,
            inputs = inputs,
            verilog_files = verilog_files,
            uhdm_files = uhdm_files,
        ),
    ]

def _synthesize_binary_impl(ctx):
    script = ""
    external_info = ctx.attr.synthesize_rtl_rule[ExternalSynthesisInfo]

    env = dict(external_info.env)
    env["FLIST"] = _create_flist(
        ctx,
        flist_tag = "verilog",
        files = external_info.verilog_files,
        short_path = True,
    )

    env["UHDM_FLIST"] = _create_flist(
        ctx,
        flist_tag = "uhdm",
        files = external_info.uhdm_files,
        short_path = True,
    )

    env["OUTPUT"] = "/tmp/{}.v".format(ctx.attr.name)

    script += "#!/bin/bash\n"

    for k, v in env.items():
        script += "export {}='{}'\n".format(k, v.short_path if type(v) == "File" else v)

    yosys_runfiles_dir = ctx.executable.yosys_tool.short_path + ".runfiles"

    script += "export YOSYS_DATDIR='{}/at_clifford_yosys/techlibs/'\n".format(yosys_runfiles_dir)
    yosys = ctx.attr.yosys_tool[DefaultInfo]
    script += "${{PREFIX_COMMAND}} {} -c {}\n".format(ctx.executable.yosys_tool.short_path, external_info.yosys_script.short_path)

    binary = ctx.actions.declare_file("{}_synth_binary.sh".format(ctx.attr.name))
    ctx.actions.write(binary, script, is_executable = True)

    return [
        DefaultInfo(
            executable = binary,
            runfiles = yosys.default_runfiles.merge_all(
                [
                    ctx.runfiles(external_info.inputs),
                    ctx.runfiles([env["UHDM_FLIST"], env["FLIST"]]),
                ],
            ),
        ),
    ]

synthesis_binary = rule(
    implementation = _synthesize_binary_impl,
    attrs = {
        "synthesize_rtl_rule": attr.label(providers = [ExternalSynthesisInfo]),
        "yosys_tool": attr.label(
            default = Label("@at_clifford_yosys//:yosys"),
            executable = True,
            cfg = "target",
        ),
    },
    executable = True,
)

synthesize_rtl = rule(
    implementation = _synthesize_design_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = True),
        "standard_cells": attr.label(
            providers = [StandardCellInfo],
            default = "@com_google_skywater_pdk_sky130_fd_sc_hd//:sky130_fd_sc_hd",
        ),
        "deps": attr.label_list(providers = [[VerilogInfo], [UhdmInfo]]),
        "top_module": attr.string(default = "top"),
        "yosys_tool": attr.label(
            default = Label("@at_clifford_yosys//:yosys"),
            executable = True,
            cfg = "exec",
        ),
        "synth_tcl": attr.label(
            default = Label("//synthesis:synth.tcl"),
            allow_single_file = True,
            doc = "Tcl synthesis script compatible with the environment-variable API of synth.tcl",
        ),
        "target_clock_period_pico_seconds": attr.int(doc = "target clock period in picoseconds"),
        "output_file_name": attr.string(doc = "The output file name."),
    },
)

def _benchmark_synth_impl(ctx):
    """Implementation of the 'benchmark_synth' rule.

    Computes and prints various metrics about a synth target.

    Args:
      ctx: The current rule's context object.
    Returns:
      DefaultInfo provider
    """
    synth_info = ctx.attr.synth_target[SynthesisInfo]

    synth_log = synth_info.log_file.short_path
    grep = "zgrep" if ("log.gz" in synth_log) else "grep"
    cmd1 = "{grep} Chip.area {log}".format(grep = grep, log = synth_log)
    cmd2 = "{grep} Longest.topological.path {log}".format(grep = grep, log = synth_log)
    cmd3 = "{grep} Flop.count {log}".format(grep = grep, log = synth_log)
    cmd4 = "{grep} ^Liberty: {log}".format(grep = grep, log = synth_log)
    cmd5 = "{grep} CPU:.user {log}".format(grep = grep, log = synth_log)

    executable_file = ctx.actions.declare_file(ctx.label.name + ".sh")

    runfiles = ctx.runfiles(files = [
        synth_info.log_file,
    ])

    ctx.actions.write(
        output = executable_file,
        content = "\n".join([
            "#!/bin/bash",
            "set -e",
            cmd1,
            cmd2,
            cmd3,
            cmd4,
            cmd5,
            "exit 0",
        ]),
        is_executable = True,
    )

    return [
        DefaultInfo(
            runfiles = runfiles,
            files = depset(
                direct = [executable_file],
                transitive = [],
            ),
            executable = executable_file,
        ),
    ]

benchmark_synth_attrs = {
    "synth_target": attr.label(
        doc = "The synth target to benchmark.",
        providers = [SynthesisInfo, DefaultInfo],
    ),
}

benchmark_synth = rule(
    doc = """Computes and prints various metrics about a synth target.

Example:
    ```
    benchmark_synth(
        name = "picorv32_benchmark_synth",
        synth_target = ":picorv32_synth",
    )
    ```
    """,
    implementation = _benchmark_synth_impl,
    attrs = benchmark_synth_attrs,
    executable = True,
)
