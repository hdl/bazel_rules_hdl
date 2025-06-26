# Copyright 2024 Google LLC
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
load("//verilog:defs.bzl", "VerilogInfo", "make_dag_entry", "make_verilog_info")

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
        "inputs": "File inputs",
        "uhdm_files": "UHDM files",
        "verilog_files": "Verilog Inputs",
        "yosys_script": "yosys script file",
    },
)

SynthesisInfo = provider(
    "Information about the synthesis target",
    fields = {
        "log_file": "Log output file from the synthesis step.",
        "standard_cell_info": "The StandardCellInfo provider this target was synthesized against.",
        "synthesized_netlist": "he structural verilog syntheized with standard_cell_info",
        "top_module": "The name of the top level module of the synthesized netlist",
    },
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
    verilog_data = [verilog_info_struct.data for verilog_info_struct in transitive_srcs.to_list()]
    verilog_files = [src for sub_tuple in (verilog_srcs + verilog_data) for src in sub_tuple]
    verilog_hdrs = [verilog_info_struct.hdrs for verilog_info_struct in transitive_srcs.to_list()]
    verilog_hdr_files = [hdr for sub_tuple in verilog_hdrs for hdr in sub_tuple]

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
    additional_liberty_files = [corner.liberty for corner in ctx.attr.standard_cells[StandardCellInfo].corners]
    if default_liberty_file in additional_liberty_files:
        additional_liberty_files.remove(default_liberty_file)

    synth_tcl = ctx.file.synth_tcl
    abc_script = ctx.file.abc_script

    inputs = []
    inputs.extend(verilog_files)
    inputs.extend(verilog_hdr_files)
    inputs.append(verilog_flist)
    inputs.append(uhdm_flist)
    inputs.extend(uhdm_files)
    inputs.append(synth_tcl)
    inputs.append(abc_script)
    inputs.append(default_liberty_file)
    inputs.extend(additional_liberty_files)

    if ctx.file.early_techmap:
        inputs.append(ctx.file.early_techmap)

    yosys_runfiles_dir = ctx.executable.yosys_tool.path + ".runfiles"

    log_file = ctx.actions.declare_file("{}_yosys_output.log".format(ctx.attr.name))

    constr = ctx.actions.declare_file("{}_abc_constraints.constr".format(ctx.attr.name))
    constr_contents = ""
    default_driver_cell = getattr(ctx.attr.standard_cells[StandardCellInfo], "default_input_driver_cell", "")
    if default_driver_cell:
        constr_contents = "set_driving_cell {}\n".format(default_driver_cell)
    default_load = getattr(ctx.attr.standard_cells[StandardCellInfo], "default_output_load", "")
    if default_load:
        constr_contents += "set_load {}\n".format(default_load)

    ctx.actions.write(constr, constr_contents)
    inputs.append(constr)

    args = ctx.actions.args()
    args.add("-q")  # quiet mode only errors printed to stderr
    args.add("-Q")  # Don't print header
    args.add_all("-l", [log_file])  # put output in log file
    args.add_all("-c", [synth_tcl])  # run synthesis tcl script
    if ctx.attr.extra_tcl_command:
        args.add("-p", ctx.attr.extra_tcl_command)
    if ctx.attr.autoidx_seed:
        args.add("--autoidx", ctx.attr.autoidx_seed)
    if ctx.attr.hash_seed:
        args.add("--hash-seed", ctx.attr.hash_seed)

    dont_use_args = ""
    or_config = ctx.attr.standard_cells[StandardCellInfo].open_road_configuration
    if or_config:
        for dont_use_pattern in or_config.do_not_use_cell_list:
            dont_use_args += " -dont_use {} ".format(dont_use_pattern)

    if ctx.attr.verilog_defines:
        for define in ctx.attr.verilog_defines:
            args.add(define)

    standard_cell_black_box = ctx.actions.declare_file("{}_stdcells_blackbox.v".format(ctx.attr.name))
    script_env_files = {
        "ABC_SCRIPT": abc_script,
        "ADDITIONAL_LIBERTIES": additional_liberty_files,
        "CONSTR": constr,
        "DONT_USE_ARGS": dont_use_args,
        "FLIST": verilog_flist,
        "LIBERTY": default_liberty_file,
        "OUTPUT": output_file,
        "STANDARD_CELL_BLACK_BOX": standard_cell_black_box,
        "TOP": ctx.attr.top_module,
        "UHDM_FLIST": uhdm_flist,
    }

    if ctx.attr.target_clock_period_pico_seconds:
        script_env_files["CLOCK_PERIOD"] = str(ctx.attr.target_clock_period_pico_seconds)

    if or_config.tie_low_port:
        script_env_files["TIELO_CELL_AND_PORT"] = str(or_config.tie_low_port)

    if or_config.tie_high_port:
        script_env_files["TIEHI_CELL_AND_PORT"] = str(or_config.tie_high_port)

    ha_fa_mapping = or_config.ha_fa_mapping
    if ha_fa_mapping:
        ha_fa_mapping_path = ha_fa_mapping[DefaultInfo].files.to_list()[0].path
        script_env_files["ADDER_MAPPING"] = str(ha_fa_mapping_path)
        inputs.append(ha_fa_mapping[DefaultInfo].files.to_list()[0])

    env = {
        "ABC": yosys_runfiles_dir + "/+_repo_rules+edu_berkeley_abc/abc",
        "YOSYS_DATDIR": yosys_runfiles_dir + "/+_repo_rules+at_clifford_yosys/techlibs/",
    }

    if ctx.file.early_techmap:
        script_env_files["EARLY_TECHMAP"] = ctx.file.early_techmap

    for k, v in script_env_files.items():
        if type(v) == "File":
            env[k] = v.path
        elif type(v) == "list" and all([type(f) == "File" for f in v]):
            env[k] = ",".join([f.path for f in v])  # List of File to comma-joined file paths.
        else:
            env[k] = v

    ctx.actions.run(
        outputs = [output_file, log_file, standard_cell_black_box],
        inputs = inputs,
        arguments = [args],
        executable = ctx.executable.yosys_tool,
        env = env,
        mnemonic = "SynthesizingRTL",
        toolchain = None,
    )

    benchmark_file = _benchmark_synth(ctx, log_file)

    return [
        DefaultInfo(
            runfiles = ctx.runfiles(files = [output_file, log_file, benchmark_file]),
            files = depset([output_file, log_file, benchmark_file]),
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
        make_verilog_info(
            new_entries = [make_dag_entry(
                label = ctx.label,
                srcs = [output_file],
                hdrs = [],
                data = [],
                deps = [],
                tags = [],
            )],
        ),
    ]

def _benchmark_synth(ctx, synth_log_file):
    """Computes and prints various metrics from the synthesis log.

    Args:
      ctx: The current rule's context object.
      synth_log_file: Output log file from Yosys for parsing.
    Returns:
      Benchmark file with metrics.
    """
    benchmark_file = ctx.actions.declare_file(ctx.label.name + "_report.textproto")
    benchmark_path = benchmark_file.path

    cat = "zcat" if ("log.gz" in synth_log_file.path) else "cat"

    cmds = [
        "echo \"# proto-file: synthesis/power_performance_area.proto\" >> {out};".format(out = benchmark_path),
        "echo \"# proto-message: hdl.ppa.PowerPerformanceAreaProto\n\" >> {out};".format(out = benchmark_path),
    ]
    awk_cmds = [
        "area=$({cat} {log} | awk '/Chip area for/ {{ print $6; }}');",
        "cells=$({cat} {log} | tac | awk '/Number of cells/ {{ print $4; exit }}');",
        "flops=$({cat} {log} | awk '/Flop count:/ {{ print $3 }}');",
        "ltp=$({cat} {log} | awk -F '[=)]' '/Longest topological path/ {{ print $2}}');",
    ]
    cmds.extend([cmd.format(cat = cat, log = synth_log_file.path) for cmd in awk_cmds])
    textproto = proto.encode_text(
        struct(
            area = struct(
                cell_area_um2 = "$area",
                num_total_cells = "$cells",
                num_sequential = "$flops",
            ),
            performance = struct(longest_topological_path = "$ltp"),
        ),
    )
    cmds.append("echo \"{textproto}\" >> {out}".format(textproto = textproto, out = benchmark_path))

    ctx.actions.run_shell(
        outputs = [benchmark_file],
        command = "".join(cmds),
        mnemonic = "BenchmarkingSynthesis",
        inputs = [synth_log_file],
    )
    return benchmark_file

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

    script += "#!/usr/bin/env bash\n"

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
        "synthesize_rtl_rule": attr.label(
            providers = [ExternalSynthesisInfo],
        ),
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
        "abc_script": attr.label(
            default = Label("//synthesis:abc.script"),
            allow_single_file = True,
            doc = "ABC script",
        ),
        "adder_mapping": attr.label(
            allow_single_file = True,
            doc = "Verilog file that maps yosys adder to PDK adders.",
        ),
        "autoidx_seed": attr.int(
            mandatory = False,
            doc = "Controls the starting point for the autoidx pass; introduces additional variability into the synthesis logic.",
        ),
        "deps": attr.label_list(
            providers = [[VerilogInfo], [UhdmInfo]],
        ),
        "early_techmap": attr.label(
            allow_single_file = True,
            doc = "verilog/system verilog file for early techmap process",
            mandatory = False,
        ),
        "extra_tcl_command": attr.string(
            default = "",
        ),
        "hash_seed": attr.int(
            mandatory = False,
            doc = "Salts the hashes used in Yosys for (e.g.) iteration order; introduces additional variability into the synthesis logic.",
        ),
        "output_file_name": attr.string(
            doc = "The output file name.",
        ),
        "srcs": attr.label_list(
            allow_files = True,
        ),
        "standard_cells": attr.label(
            providers = [StandardCellInfo],
            default = "@com_google_skywater_pdk_sky130_fd_sc_hd//:sky130_fd_sc_hd",
        ),
        "synth_tcl": attr.label(
            default = Label("//synthesis:synth.tcl"),
            allow_single_file = True,
            doc = "Tcl synthesis script compatible with the environment-variable API of synth.tcl",
        ),
        "target_clock_period_pico_seconds": attr.int(
            doc = "target clock period in picoseconds",
        ),
        "top_module": attr.string(
            default = "top",
        ),
        "verilog_defines": attr.string_list(
            doc = "Verilog defines to pass to the synthesis tool.",
        ),
        "yosys_tool": attr.label(
            default = Label("@at_clifford_yosys//:yosys"),
            executable = True,
            cfg = "exec",
        ),
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
            "#!/usr/bin/env bash",
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
