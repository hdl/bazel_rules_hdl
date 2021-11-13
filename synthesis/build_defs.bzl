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

load("//pdk:build_defs.bzl", "StandardCellInfo")
load("//verilog:providers.bzl", "VerilogInfo")

# Args:
#    standard_cell_info: The StandardCellInfo provider this target was synthesized against.
#    synthesized_netlist: The structural verilog syntheized with standard_cell_info
#    top_module: The name of the top level module of the synthesized netlist
SynthesisInfo = provider("Information about the synthesis target", fields = ["standard_cell_info", "synthesized_netlist", "top_module"])

def _transitive_srcs(deps):
    return depset(
        [],
        transitive = [dep[VerilogInfo].dag for dep in deps],
    )

def _synthesize_design_impl(ctx):
    transitive_srcs = _transitive_srcs(ctx.attr.deps)
    verilog_srcs = [verilog_info_struct.srcs for verilog_info_struct in transitive_srcs.to_list()]

    verilog_files = [src for sub_tuple in verilog_srcs for src in sub_tuple]
    verilog_flist = ctx.actions.declare_file("{}.flist".format(ctx.attr.name))
    ctx.actions.write(verilog_flist, "\n".join([f.path for f in verilog_files]) + "\n")

    output_file = ctx.actions.declare_file("{}_synth_output.v".format(ctx.attr.name))
    default_liberty_file = ctx.attr.standard_cells[StandardCellInfo].default_corner.liberty

    synth_tcl = ctx.file.synth_tcl

    inputs = []
    inputs.extend(verilog_files)
    inputs.append(verilog_flist)
    inputs.append(synth_tcl)

    (tool_inputs, input_manifests) = ctx.resolve_tools(tools = [ctx.attr.yosys_tool])

    yosys_runfiles_dir = ctx.executable.yosys_tool.path + ".runfiles"

    log_file = ctx.actions.declare_file("{}_yosys_output.log".format(ctx.attr.name))

    args = ctx.actions.args()
    args.add("-q")  # quiet mode only errors printed to stderr
    args.add("-q")  # second q don't print warnings
    args.add("-Q")  # Don't print header
    args.add("-T")  # Don't print footer
    args.add_all("-l", [log_file])  # put output in log file
    args.add_all("-c", [synth_tcl])  # run synthesis tcl script

    ctx.actions.run(
        outputs = [output_file, log_file],
        inputs = inputs + tool_inputs.to_list() + [default_liberty_file],
        arguments = [args],
        executable = ctx.executable.yosys_tool,
        tools = tool_inputs,
        input_manifests = input_manifests,
        env = {
            "FLIST": verilog_flist.path,
            "TOP": ctx.attr.top_module,
            "OUTPUT": output_file.path,
            "LIBERTY": default_liberty_file.path,
            "YOSYS_DATDIR": yosys_runfiles_dir + "/at_clifford_yosys/techlibs/",
            "ABC": yosys_runfiles_dir + "/edu_berkeley_abc/abc",
        },
        mnemonic = "SythesizingRTL",
    )

    return [
        DefaultInfo(files = depset([output_file, log_file])),
        SynthesisInfo(
            standard_cell_info = ctx.attr.standard_cells[StandardCellInfo],
            synthesized_netlist = output_file,
            top_module = ctx.attr.top_module,
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
        "deps": attr.label_list(providers = [VerilogInfo]),
        "top_module": attr.string(default = "top"),
        "yosys_tool": attr.label(
            default = Label("@at_clifford_yosys//:yosys"),
            executable = True,
            cfg = "exec",
        ),
        "synth_tcl": attr.label(
            default = Label("//synthesis:synth.tcl"),
            allow_single_file = True,
        ),
    },
)
