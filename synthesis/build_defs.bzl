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

def _create_flist(ctx, flist_tag, files):
    flist = ctx.actions.declare_file("{}_{}.flist".format(flist_tag, ctx.attr.name))
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

    output_file = ctx.actions.declare_file("{}_synth_output.v".format(ctx.attr.name))
    default_liberty_file = ctx.attr.standard_cells[StandardCellInfo].default_corner.liberty

    synth_tcl = ctx.file.synth_tcl

    inputs = []
    inputs.extend(verilog_files)
    inputs.append(verilog_flist)
    inputs.append(uhdm_flist)
    inputs.extend(uhdm_files)
    inputs.append(synth_tcl)

    (tool_inputs, input_manifests) = ctx.resolve_tools(tools = [ctx.attr.yosys_tool])

    yosys_runfiles_dir = ctx.executable.yosys_tool.path + ".runfiles"

    log_file = ctx.actions.declare_file("{}_yosys_output.log".format(ctx.attr.name))

    args = ctx.actions.args()
    args.add("-q")  # quiet mode only errors printed to stderr
    args.add("-q")  # second q don't print warnings
    args.add("-Q")  # Don't print header
    args.add_all("-l", [log_file])  # put output in log file
    args.add_all("-c", [synth_tcl])  # run synthesis tcl script

    env = {
        "FLIST": verilog_flist.path,
        "UHDM_FLIST": uhdm_flist.path,
        "TOP": ctx.attr.top_module,
        "OUTPUT": output_file.path,
        "LIBERTY": default_liberty_file.path,
        "YOSYS_DATDIR": yosys_runfiles_dir + "/at_clifford_yosys/techlibs/",
        "ABC": yosys_runfiles_dir + "/edu_berkeley_abc/abc",
    }

    if ctx.attr.target_clock_period_pico_seconds:
        env["CLOCK_PERIOD"] = str(ctx.attr.target_clock_period_pico_seconds)

    ctx.actions.run(
        outputs = [output_file, log_file],
        inputs = inputs + tool_inputs.to_list() + [default_liberty_file],
        arguments = [args],
        executable = ctx.executable.yosys_tool,
        tools = tool_inputs,
        input_manifests = input_manifests,
        env = env,
        mnemonic = "SynthesizingRTL",
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
    ]

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
