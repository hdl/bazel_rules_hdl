"""Defines rules for the Xilinx tool, vivado."""

load("//verilog:providers.bzl", "VerilogInfo")
load("//vivado:providers.bzl", "VivadoIPBlockInfo", "VivadoPlacementCheckpointInfo", "VivadoRoutingCheckpointInfo", "VivadoSynthCheckpointInfo")

def run_tcl_template(ctx, template, substitutions, xilinx_env, input_files, output_files, post_processing_command = ""):
    """Runs a tcl template in vivado.

    Args:
        ctx: Context from a rule.
        template: The template file to use.
        substitutions: The substitutions to apply to the template.
        xilinx_env: A shell script to source the vivado environment with.
        input_files: A list of input files that vivado needs to run.
        output_files: A list of expected outputs from the tcl script running on vivado.
        post_processing_command: A bash command to run after vivado.

    Returns:
        DefaultInfo - The files that were created.
    """
    vivado_tcl = ctx.actions.declare_file("{}_run_vivado.tcl".format(ctx.label.name))
    vivado_log = ctx.actions.declare_file("{}.log".format(ctx.label.name))
    vivado_journal = ctx.actions.declare_file("{}.jou".format(ctx.label.name))

    ctx.actions.expand_template(
        template = template,
        output = vivado_tcl,
        substitutions = substitutions,
    )

    vivado_command = "source " + xilinx_env.path + " && "
    vivado_command += "vivado -mode batch -source " + vivado_tcl.path
    vivado_command += " -log " + vivado_log.path
    vivado_command += " -journal " + vivado_journal.path + "; "
    vivado_command += post_processing_command

    outputs = output_files + [vivado_log, vivado_journal]

    ctx.actions.run_shell(
        outputs = outputs,
        inputs = input_files + [vivado_tcl, xilinx_env],
        progress_message = "Running on vivado: {}".format(ctx.label.name),
        command = vivado_command,
    )

    return [
        DefaultInfo(files = depset(outputs)),
        vivado_log,
        vivado_journal,
    ]

def get_content_from_files(all_files):
    """Get all tcl content from these files.

    Args:
        all_files: All files needed

    Returns:
      hdl_source_content: A string to load any hdl files in xilinx tools.
      constraints_content: A string to load any constraints in xilinx tools.
      tcl_content: A string to load any other tcl in xilinx tools.
    """
    hdl_source_content = ""
    constraints_content = ""
    tcl_content = ""

    for file in all_files:
        if file.extension == "v":
            hdl_source_content += "read_verilog -library xil_defaultlib " + file.path + "\n"
        elif file.extension == "sv":
            hdl_source_content += "read_verilog -library xil_defaultlib -sv " + file.path + "\n"
        elif file.extension in ["vhd", "vhdl"]:
            hdl_source_content += "read_vhdl " + file.path + "\n"
        elif file.extension == "tcl":
            tcl_content += "source " + file.path + "\n"
        elif file.extension == "xdc":
            constraints_content += "read_xdc " + file.path + "\n"
        else:
            # Use import files instead to make sure generic files like coef and txt are added to the project.
            hdl_source_content += "import_files " + file.path + "\n"

    return hdl_source_content, constraints_content, tcl_content

def generate_file_load_tcl(module):
    """Generate the strings needed for tcl.

    Look at all the sources for a verilog module and make the needed commands
    to get xilinx tools to load all the files needed.

    Args:
      module: The top level verilog module

    Returns:
      all_files: All file objects that the module depends on.
      hdl_source_content: A string to load any hdl files in xilinx tools.
      constraints_content: A string to load any constraints in xilinx tools.
      tcl_content: A string to load any other tcl in xilinx tools.
    """
    transitive_srcs = depset([], transitive = [module[VerilogInfo].dag])
    all_srcs = [verilog_info_struct.srcs for verilog_info_struct in transitive_srcs.to_list()]
    all_files = [src for sub_tuple in all_srcs for src in sub_tuple]

    hdl_source_content, constraints_content, tcl_content = get_content_from_files(all_files)

    return [
        all_files,
        hdl_source_content,
        constraints_content,
        tcl_content,
    ]

def generate_ip_block_tcl(ip_blocks):
    """Generate the tcl for including an IP repo.

    Args:
        ip_blocks: A list of ip blocks to include that provide VivadoIPBlockInfo.

    Returns:
        The tcl to include the paths to the ip blocks.
    """
    ip_tcl = "set_property ip_repo_paths [list "
    for ip_block in ip_blocks:
        for repo in ip_block[VivadoIPBlockInfo].repo:
            ip_tcl += "{} ".format(repo.path)
    ip_tcl += "] [current_project]\n"
    for ip_block in ip_blocks:
        ip_tcl += "create_ip -name {} -vendor {} -library {} -version {} -module_name {}\n".format(
            ip_block[VivadoIPBlockInfo].module_top,
            ip_block[VivadoIPBlockInfo].vendor,
            ip_block[VivadoIPBlockInfo].library,
            ip_block[VivadoIPBlockInfo].version,
            ip_block[VivadoIPBlockInfo].module_top + "_ip",
        )
    ip_tcl += "update_ip_catalog\n"
    return ip_tcl

def create_and_synth(
        ctx,
        with_synth,
        synth_checkpoint = None,
        timing_summary_report = None,
        util_report = None,
        synth_strategy = None):
    """Create a project and optionally synthesize.

    Due to IP issues, it makes sense to do synthesis in project mode.
    This function can also be used to generate a vivado project from the input sources.

    Args:
        ctx: Context from a rule
        with_synth: A flag indicating if synthesis should be run too.
        synth_checkpoint: Optionally define the output synthesis checkpoint. Not used when creating a project only.
        timing_summary_report: Optionally define the timing summary report output. Not used when creating a project only.
        util_report: Optionally define the utilization report output. Not used when creating a project only.
        synth_strategy: Optionally define the synthesis strategy to use. Not used when creating a project only.

    Returns:
        DefaultInfo - Files generated by the project.
    """
    all_files, hdl_source_content, constraints_content, tcl_content = generate_file_load_tcl(ctx.attr.module)

    ip_block_tcl = generate_ip_block_tcl(ctx.attr.ip_blocks)

    project_dir = ctx.actions.declare_directory(ctx.label.name)

    if with_synth:
        synth_path = synth_checkpoint.path
        timing_path = timing_summary_report.path
        util_path = util_report.path
        with_synth_str = "1"
        synth_strategy_str = synth_strategy
        outputs = [project_dir, synth_checkpoint, timing_summary_report, util_report]
    else:
        synth_path = ""
        timing_path = ""
        util_path = ""
        with_synth_str = "0"
        synth_strategy_str = ""
        outputs = [project_dir]

    substitutions = {
        "{{PART_NUMBER}}": ctx.attr.part_number,
        "{{HDL_SOURCE_CONTENT}}": hdl_source_content,
        "{{TCL_CONTENT}}": tcl_content,
        "{{CONSTRAINTS_CONTENT}}": constraints_content,
        "{{MODULE_TOP}}": ctx.attr.module_top,
        "{{PROJECT_DIR}}": project_dir.path,
        "{{SYNTH_STRATEGY}}": synth_strategy_str,
        "{{SYNTH_CHECKPOINT}}": synth_path,
        "{{TIMING_SUMMARY_REPORT}}": timing_path,
        "{{UTILIZATION_REPORT}}": util_path,
        "{{IP_BLOCK_TCL}}": ip_block_tcl,
        "{{JOBS}}": "{}".format(ctx.attr.jobs),
        "{{WITH_SYNTH}}": with_synth_str,
    }

    ip_block_dirs = []
    for ip_block in ctx.attr.ip_blocks:
        ip_block_dirs += ip_block[VivadoIPBlockInfo].repo

    return run_tcl_template(
        ctx,
        ctx.file.create_project_tcl_template,
        substitutions,
        ctx.file.xilinx_env,
        all_files + ip_block_dirs,
        outputs,
    )

def _vivado_create_project_impl(ctx):
    default_info = create_and_synth(ctx, 0)
    return [default_info[0]]

vivado_create_project = rule(
    implementation = _vivado_create_project_impl,
    attrs = {
        "module": attr.label(
            doc = "The top level build.",
            providers = [VerilogInfo],
            mandatory = True,
        ),
        "module_top": attr.string(
            doc = "The name of the top level verilog module.",
            mandatory = True,
        ),
        "part_number": attr.string(
            doc = "The targeted xilinx part.",
            mandatory = True,
        ),
        "ip_blocks": attr.label_list(
            doc = "Ip blocks to include in this design.",
            providers = [VivadoIPBlockInfo],
            default = [],
        ),
        "xilinx_env": attr.label(
            doc = "A shell script to source the vivado environment and " +
                  "point to license server",
            mandatory = True,
            allow_single_file = [".sh"],
        ),
        "jobs": attr.int(
            doc = "Jobs to pass to vivado which defines the amount of parallelism.",
            default = 4,
        ),
        "create_project_tcl_template": attr.label(
            doc = "The create project tcl template",
            default = "@rules_hdl//vivado:create_project.tcl.template",
            allow_single_file = [".template"],
        ),
    },
)

def _vivado_synthesize_impl(ctx):
    synth_checkpoint = ctx.actions.declare_file("{}.dcp".format(ctx.label.name))
    timing_summary_report = ctx.actions.declare_file("{}_timing.rpt".format(ctx.label.name))
    util_report = ctx.actions.declare_file("{}_util.rpt".format(ctx.label.name))

    default_info = create_and_synth(
        ctx,
        1,
        synth_checkpoint,
        timing_summary_report,
        util_report,
        ctx.attr.synth_strategy,
    )

    return [
        default_info[0],
        VivadoSynthCheckpointInfo(checkpoint = synth_checkpoint),
    ]

vivado_synthesize = rule(
    implementation = _vivado_synthesize_impl,
    attrs = {
        "module": attr.label(
            doc = "The top level build.",
            providers = [VerilogInfo],
            mandatory = True,
        ),
        "module_top": attr.string(
            doc = "The name of the top level verilog module.",
            mandatory = True,
        ),
        "part_number": attr.string(
            doc = "The targeted xilinx part.",
            mandatory = True,
        ),
        "synth_strategy": attr.string(
            doc = "The synthesis strategy to use.",
            default = "Vivado Synthesis Defaults",
        ),
        "ip_blocks": attr.label_list(
            doc = "Ip blocks to include in this design.",
            providers = [VivadoIPBlockInfo],
            default = [],
        ),
        "xilinx_env": attr.label(
            doc = "A shell script to source the vivado environment and " +
                  "point to license server",
            mandatory = True,
            allow_single_file = [".sh"],
        ),
        "jobs": attr.int(
            doc = "Jobs to pass to vivado which defines the amount of parallelism.",
            default = 4,
        ),
        "create_project_tcl_template": attr.label(
            doc = "The create project tcl template",
            default = "@rules_hdl//vivado:create_project.tcl.template",
            allow_single_file = [".template"],
        ),
    },
    provides = [
        DefaultInfo,
        VivadoSynthCheckpointInfo,
    ],
)

def _vivado_synthesis_optimize_impl(ctx):
    synth_checkpoint = ctx.actions.declare_file("{}.dcp".format(ctx.label.name))
    timing_summary_report = ctx.actions.declare_file("{}_timing.rpt".format(ctx.label.name))
    util_report = ctx.actions.declare_file("{}_util.rpt".format(ctx.label.name))
    drc_report = ctx.actions.declare_file("{}_drc.rpt".format(ctx.label.name))

    checkpoint_in = ctx.attr.checkpoint[VivadoSynthCheckpointInfo].checkpoint

    substitutions = {
        "{{THREADS}}": "{}".format(ctx.attr.threads),
        "{{CHECKPOINT_IN}}": checkpoint_in.path,
        "{{OPT_DIRECTIVE}}": ctx.attr.opt_directive,
        "{{TIMING_REPORT}}": timing_summary_report.path,
        "{{UTIL_REPORT}}": util_report.path,
        "{{DRC_REPORT}}": drc_report.path,
        "{{CHECKPOINT_OUT}}": synth_checkpoint.path,
    }

    outputs = [synth_checkpoint, timing_summary_report, util_report, drc_report]

    default_info = run_tcl_template(
        ctx,
        ctx.file.synthesis_optimize_template,
        substitutions,
        ctx.file.xilinx_env,
        [checkpoint_in],
        outputs,
    )

    return [
        default_info[0],
        VivadoSynthCheckpointInfo(checkpoint = synth_checkpoint),
    ]

vivado_synthesis_optimize = rule(
    implementation = _vivado_synthesis_optimize_impl,
    attrs = {
        "checkpoint": attr.label(
            doc = "Synthesis checkpoint.",
            providers = [VivadoSynthCheckpointInfo],
            mandatory = True,
        ),
        "xilinx_env": attr.label(
            doc = "A shell script to source the vivado environment and " +
                  "point to license server",
            mandatory = True,
            allow_single_file = [".sh"],
        ),
        "opt_directive": attr.string(
            doc = "The optimization directive.",
            default = "Explore",
        ),
        "threads": attr.int(
            doc = "Threads to pass to vivado which defines the amount of parallelism.",
            default = 8,
        ),
        "synthesis_optimize_template": attr.label(
            doc = "The synthesis optimzation tcl template",
            default = "@rules_hdl//vivado:synth_optimize.tcl.template",
            allow_single_file = [".template"],
        ),
    },
    provides = [
        DefaultInfo,
        VivadoSynthCheckpointInfo,
    ],
)

def _vivado_placement_impl(ctx):
    placement_checkpoint = ctx.actions.declare_file("{}.dcp".format(ctx.label.name))
    timing_summary_report = ctx.actions.declare_file("{}_timing.rpt".format(ctx.label.name))
    util_report = ctx.actions.declare_file("{}_util.rpt".format(ctx.label.name))

    checkpoint_in = ctx.attr.checkpoint[VivadoSynthCheckpointInfo].checkpoint

    substitutions = {
        "{{THREADS}}": "{}".format(ctx.attr.threads),
        "{{CHECKPOINT_IN}}": checkpoint_in.path,
        "{{PLACEMENT_DIRECTIVE}}": ctx.attr.placement_directive,
        "{{TIMING_REPORT}}": timing_summary_report.path,
        "{{UTIL_REPORT}}": util_report.path,
        "{{CHECKPOINT_OUT}}": placement_checkpoint.path,
    }

    outputs = [placement_checkpoint, timing_summary_report, util_report]

    default_info = run_tcl_template(
        ctx,
        ctx.file.placement_template,
        substitutions,
        ctx.file.xilinx_env,
        [checkpoint_in],
        outputs,
    )

    return [
        default_info[0],
        VivadoPlacementCheckpointInfo(checkpoint = placement_checkpoint),
    ]

vivado_placement = rule(
    implementation = _vivado_placement_impl,
    attrs = {
        "checkpoint": attr.label(
            doc = "Synthesis checkpoint.",
            providers = [VivadoSynthCheckpointInfo],
            mandatory = True,
        ),
        "xilinx_env": attr.label(
            doc = "A shell script to source the vivado environment and " +
                  "point to license server",
            mandatory = True,
            allow_single_file = [".sh"],
        ),
        "placement_directive": attr.string(
            doc = "The optimization directive.",
            default = "Explore",
        ),
        "threads": attr.int(
            doc = "Threads to pass to vivado which defines the amount of parallelism.",
            default = 8,
        ),
        "placement_template": attr.label(
            doc = "The placement tcl template",
            default = "@rules_hdl//vivado:placement.tcl.template",
            allow_single_file = [".template"],
        ),
    },
    provides = [
        DefaultInfo,
        VivadoPlacementCheckpointInfo,
    ],
)

def _vivado_place_optimize_impl(ctx):
    placement_checkpoint = ctx.actions.declare_file("{}.dcp".format(ctx.label.name))
    timing_summary_report = ctx.actions.declare_file("{}_timing.rpt".format(ctx.label.name))
    util_report = ctx.actions.declare_file("{}_util.rpt".format(ctx.label.name))

    checkpoint_in = ctx.attr.checkpoint[VivadoPlacementCheckpointInfo].checkpoint

    substitutions = {
        "{{THREADS}}": "{}".format(ctx.attr.threads),
        "{{CHECKPOINT_IN}}": checkpoint_in.path,
        "{{PHYS_OPT_DIRECTIVE}}": ctx.attr.phys_opt_directive,
        "{{TIMING_REPORT}}": timing_summary_report.path,
        "{{UTIL_REPORT}}": util_report.path,
        "{{CHECKPOINT_OUT}}": placement_checkpoint.path,
    }

    outputs = [placement_checkpoint, timing_summary_report, util_report]

    default_info = run_tcl_template(
        ctx,
        ctx.file.place_optimize_template,
        substitutions,
        ctx.file.xilinx_env,
        [checkpoint_in],
        outputs,
    )

    return [
        default_info[0],
        VivadoPlacementCheckpointInfo(checkpoint = placement_checkpoint),
    ]

vivado_place_optimize = rule(
    implementation = _vivado_place_optimize_impl,
    attrs = {
        "checkpoint": attr.label(
            doc = "Placement checkpoint.",
            providers = [VivadoPlacementCheckpointInfo],
            mandatory = True,
        ),
        "xilinx_env": attr.label(
            doc = "A shell script to source the vivado environment and " +
                  "point to license server",
            mandatory = True,
            allow_single_file = [".sh"],
        ),
        "phys_opt_directive": attr.string(
            doc = "The optimization directive.",
            default = "AggressiveExplore",
        ),
        "threads": attr.int(
            doc = "Threads to pass to vivado which defines the amount of parallelism.",
            default = 8,
        ),
        "place_optimize_template": attr.label(
            doc = "The placement tcl template",
            default = "@rules_hdl//vivado:place_optimize.tcl.template",
            allow_single_file = [".template"],
        ),
    },
    provides = [
        DefaultInfo,
        VivadoPlacementCheckpointInfo,
    ],
)

def _vivado_routing_impl(ctx):
    route_checkpoint = ctx.actions.declare_file("{}.dcp".format(ctx.label.name))
    timing_summary_report = ctx.actions.declare_file("{}_timing.rpt".format(ctx.label.name))
    util_report = ctx.actions.declare_file("{}_util.rpt".format(ctx.label.name))
    status_report = ctx.actions.declare_file("{}_status.rpt".format(ctx.label.name))
    io_report = ctx.actions.declare_file("{}_io.rpt".format(ctx.label.name))
    power_report = ctx.actions.declare_file("{}_power.rpt".format(ctx.label.name))
    design_analysis_report = ctx.actions.declare_file("{}_design_analysis.rpt".format(ctx.label.name))

    checkpoint_in = ctx.attr.checkpoint[VivadoPlacementCheckpointInfo].checkpoint

    substitutions = {
        "{{THREADS}}": "{}".format(ctx.attr.threads),
        "{{CHECKPOINT_IN}}": checkpoint_in.path,
        "{{ROUTE_DIRECTIVE}}": ctx.attr.route_directive,
        "{{TIMING_REPORT}}": timing_summary_report.path,
        "{{UTIL_REPORT}}": util_report.path,
        "{{STATUS_REPORT}}": status_report.path,
        "{{IO_REPORT}}": io_report.path,
        "{{POWER_REPORT}}": power_report.path,
        "{{DESIGN_ANALYSIS_REPORT}}": design_analysis_report.path,
        "{{CHECKPOINT_OUT}}": route_checkpoint.path,
    }

    outputs = [
        route_checkpoint,
        timing_summary_report,
        util_report,
        status_report,
        io_report,
        power_report,
        design_analysis_report,
    ]

    default_info = run_tcl_template(
        ctx,
        ctx.file.route_template,
        substitutions,
        ctx.file.xilinx_env,
        [checkpoint_in],
        outputs,
    )

    return [
        default_info[0],
        VivadoRoutingCheckpointInfo(checkpoint = route_checkpoint),
    ]

vivado_routing = rule(
    implementation = _vivado_routing_impl,
    attrs = {
        "checkpoint": attr.label(
            doc = "Placement checkpoint.",
            providers = [VivadoPlacementCheckpointInfo],
            mandatory = True,
        ),
        "xilinx_env": attr.label(
            doc = "A shell script to source the vivado environment and " +
                  "point to license server",
            mandatory = True,
            allow_single_file = [".sh"],
        ),
        "route_directive": attr.string(
            doc = "The routing directive.",
            default = "Explore",
        ),
        "threads": attr.int(
            doc = "Threads to pass to vivado which defines the amount of parallelism.",
            default = 8,
        ),
        "route_template": attr.label(
            doc = "The placement tcl template",
            default = "@rules_hdl//vivado:route.tcl.template",
            allow_single_file = [".template"],
        ),
    },
    provides = [
        DefaultInfo,
        VivadoRoutingCheckpointInfo,
    ],
)

def _vivado_write_bitstream_impl(ctx):
    bitstream = ctx.actions.declare_file("{}.bit".format(ctx.label.name))

    checkpoint_in = ctx.attr.checkpoint[VivadoRoutingCheckpointInfo].checkpoint

    outputs = [bitstream]

    if ctx.attr.with_xsa:
        with_xsa_str = "1"
        xsa_out = ctx.actions.declare_file("{}.xsa".format(ctx.label.name))
        xsa_path = xsa_out.path
        outputs.append(xsa_out)
    else:
        with_xsa_str = "0"
        xsa_path = "nothing.xsa"

    substitutions = {
        "{{THREADS}}": "{}".format(ctx.attr.threads),
        "{{CHECKPOINT_IN}}": checkpoint_in.path,
        "{{BITSTREAM}}": bitstream.path,
        "{{WRITE_XSA}}": with_xsa_str,
        "{{XSA_PATH}}": xsa_path,
    }

    default_info = run_tcl_template(
        ctx,
        ctx.file.write_bitstream_template,
        substitutions,
        ctx.file.xilinx_env,
        [checkpoint_in],
        outputs,
    )
    return [default_info[0]]

vivado_write_bitstream = rule(
    implementation = _vivado_write_bitstream_impl,
    attrs = {
        "checkpoint": attr.label(
            doc = "Routed checkpoint.",
            providers = [VivadoRoutingCheckpointInfo],
            mandatory = True,
        ),
        "xilinx_env": attr.label(
            doc = "A shell script to source the vivado environment and " +
                  "point to license server",
            mandatory = True,
            allow_single_file = [".sh"],
        ),
        "threads": attr.int(
            doc = "Threads to pass to vivado which defines the amount of parallelism.",
            default = 8,
        ),
        "with_xsa": attr.bool(
            doc = "Generate xsa too",
            default = False,
        ),
        "write_bitstream_template": attr.label(
            doc = "The write bitstream tcl template",
            default = "@rules_hdl//vivado:write_bitstream.tcl.template",
            allow_single_file = [".template"],
        ),
    },
    provides = [
        DefaultInfo,
    ],
)

def vivado_flow(name, module, module_top, part_number, xilinx_env, tags = [], ip_blocks = [], with_xsa = False):
    """Runs the entire bitstream flow as a convenience macro.

    Args:
        name: The name to use when calling the rules.
        module: The verilog library to use as the top level.
        module_top: The name of the top level module.
        part_number: The part number to target.
        xilinx_env: The shell script to setup the Xilinx/vivado environment.
        tags: Optional tags to use for the rules.
        ip_blocks: Optional ip blocks to include in a design.
        with_xsa: Also generate the xsa file.
    """
    vivado_synthesize(
        name = "{}_synth".format(name),
        module = module,
        module_top = module_top,
        part_number = part_number,
        xilinx_env = xilinx_env,
        tags = tags,
        ip_blocks = ip_blocks,
    )

    vivado_synthesis_optimize(
        name = "{}_synth_opt".format(name),
        checkpoint = ":{}_synth".format(name),
        xilinx_env = xilinx_env,
        tags = tags,
    )

    vivado_placement(
        name = "{}_placement".format(name),
        checkpoint = "{}_synth_opt".format(name),
        xilinx_env = xilinx_env,
        tags = tags,
    )

    vivado_place_optimize(
        name = "{}_place_opt".format(name),
        checkpoint = "{}_placement".format(name),
        xilinx_env = xilinx_env,
        tags = tags,
    )

    vivado_routing(
        name = "{}_route".format(name),
        checkpoint = "{}_place_opt".format(name),
        xilinx_env = xilinx_env,
        tags = tags,
    )

    vivado_write_bitstream(
        name = name,
        checkpoint = "{}_route".format(name),
        xilinx_env = xilinx_env,
        tags = tags,
        with_xsa = with_xsa,
    )

def _xsim_test_impl(ctx):
    all_files, hdl_source_content, constraints_content, tcl_content = generate_file_load_tcl(ctx.attr.module)

    ip_block_tcl = generate_ip_block_tcl(ctx.attr.ip_blocks)
    ip_block_dirs = []
    for ip_block in ctx.attr.ip_blocks:
        ip_block_dirs += ip_block[VivadoIPBlockInfo].repo

    project_dir = ctx.actions.declare_directory("{}_prj".format(ctx.label.name))
    if (ctx.attr.with_waveform):
        with_waveform_str = "1"
        wave_db = ctx.actions.declare_file("{}.wdb".format(ctx.label.name))
        wave_db_path = wave_db.path
        outputs = [project_dir, wave_db]
    else:
        with_waveform_str = "0"
        wave_db_path = ""
        outputs = [project_dir]

    substitutions = {
        "{{PART_NUMBER}}": ctx.attr.part_number,
        "{{HDL_SOURCE_CONTENT}}": hdl_source_content,
        "{{IP_BLOCK_TCL}}": ip_block_tcl,
        "{{TCL_CONTENT}}": tcl_content,
        "{{CONSTRAINTS_CONTENT}}": constraints_content,
        "{{MODULE_TOP}}": ctx.attr.module_top,
        "{{PROJECT_DIR}}": project_dir.path,
        "{{WITH_WAVEFORM}}": with_waveform_str,
        "{{WAVE_DB}}": wave_db_path,
    }

    _, vivado_log, vivado_journal = run_tcl_template(
        ctx,
        ctx.file.xsim_test_template,
        substitutions,
        ctx.file.xilinx_env,
        all_files + ip_block_dirs,
        outputs,
    )

    outputs.append(vivado_log)
    outputs.append(vivado_journal)

    log_runfiles = ctx.runfiles(files = [vivado_log])

    error_parser = "if grep -q Error {}; then\n".format(vivado_log.short_path)
    error_parser += "cat {}\n".format(vivado_log.short_path)
    error_parser += "exit 64\n"
    error_parser += "fi"

    ctx.actions.write(
        output = ctx.outputs.executable,
        content = error_parser,
        is_executable = True,
    )

    return [
        DefaultInfo(
            files = depset(outputs),
            runfiles = log_runfiles,
            executable = ctx.outputs.executable,
        ),
    ]

xsim_test = rule(
    implementation = _xsim_test_impl,
    doc = "Use the vivado tool xsim to test.",
    test = True,
    attrs = {
        "module": attr.label(
            doc = "The top level build.",
            providers = [VerilogInfo],
            mandatory = True,
        ),
        "module_top": attr.string(
            doc = "The name of the top level verilog module.",
            mandatory = True,
        ),
        "ip_blocks": attr.label_list(
            doc = "Ip blocks to include in this design.",
            providers = [VivadoIPBlockInfo],
            default = [],
        ),
        "part_number": attr.string(
            doc = "The targeted xilinx part.",
            mandatory = True,
        ),
        "with_waveform": attr.bool(
            doc = "Generate with a waveform",
            default = False,
        ),
        "xilinx_env": attr.label(
            doc = "A shell script to source the vivado environment and " +
                  "point to license server",
            mandatory = True,
            allow_single_file = [".sh"],
        ),
        "xsim_test_template": attr.label(
            doc = "The tcl template to run on vivado.",
            default = "@rules_hdl//vivado:xsim_test.tcl.template",
            allow_single_file = [".template"],
        ),
    },
)

def generate_encrypt_tcl(ctx, all_files, keyfile_path, ip_dir_src):
    """Generate the commands to encrypt all sources.

    Args:
      ctx: The context
      all_files: All files to encrypt
      keyfile_path: Path to the key file used to encrypt.
      ip_dir_src: The location of ip source directory.

    Returns:
      encrypt_content: A string to encrypt all sources.
      encrypted_files: The output files to be encrypted.
      post_processing_command: A command to fix up the ip sources.
    """
    encrypt_content = ""
    post_processing_command = ""
    encrypted_files = []
    for file in all_files:
        if file.extension in ["v", "sv"]:
            language = "verilog"
        elif file.extension in ["vhd", "vhdl"]:
            language = "vhdl"
        else:
            continue
        enc_extension = ".enc.{}".format(file.extension)
        enc_filename = "{}{}".format(file.basename.split(".")[0], enc_extension)
        encrypt_content += "encrypt -key {} -lang {} -ext {} {}\n".format(keyfile_path, language, enc_extension, file.path)
        enc_file = ctx.actions.declare_file(enc_filename)
        encrypted_files.append(enc_file)
        source_file = "{}/{}".format(file.dirname, enc_file.basename)
        post_processing_command += "cp {} {}; ".format(source_file, enc_file.path)
        post_processing_command += "cp {} {}/{}; ".format(source_file, ip_dir_src, file.basename)

    return [
        encrypt_content,
        encrypted_files,
        post_processing_command,
    ]

def _vivado_create_ip_impl(ctx):
    all_files, hdl_source_content, constraints_content, tcl_content = generate_file_load_tcl(ctx.attr.module)

    xci_name = ctx.label.name
    ip_dir = ctx.actions.declare_directory(ctx.label.name)
    ip_block_tcl = generate_ip_block_tcl(ctx.attr.ip_blocks)

    outputs = [ip_dir]

    post_processing_command = ""
    encrypt_content = ""
    ip_src_dir = "{}/src/".format(ip_dir.path)
    if ctx.attr.encrypt:
        encrypt_content, encrypted_files, post_processing_command = generate_encrypt_tcl(
            ctx,
            all_files,
            ctx.file.keyfile.path,
            ip_src_dir,
        )
        outputs += encrypted_files

    substitutions = {
        "{{PART_NUMBER}}": ctx.attr.part_number,
        "{{HDL_SOURCE_CONTENT}}": hdl_source_content,
        "{{TCL_CONTENT}}": tcl_content,
        "{{CONSTRAINTS_CONTENT}}": constraints_content,
        "{{MODULE_TOP}}": ctx.attr.module_top,
        "{{PROJECT_DIR}}": "./",
        "{{IP_OUTPUT_DIR}}": ip_dir.path,
        "{{IP_VERSION}}": ctx.attr.ip_version,
        "{{IP_BLOCK_TCL}}": ip_block_tcl,
        "{{JOBS}}": "{}".format(ctx.attr.jobs),
        "{{ENCRYPT_CONTENT}}": encrypt_content,
        "{{IP_VENDOR}}": ctx.attr.ip_vendor,
        "{{IP_LIBRARY}}": ctx.attr.ip_library,
        "{{XCI_NAME}}": xci_name,
    }

    ip_block_dirs = []
    for ip_block in ctx.attr.ip_blocks:
        ip_block_dirs += ip_block[VivadoIPBlockInfo].repo
    ip_block_outputs = run_tcl_template(
        ctx,
        ctx.file.create_ip_block_template,
        substitutions,
        ctx.file.xilinx_env,
        all_files + [ctx.file.keyfile] + ip_block_dirs,
        outputs,
        post_processing_command,
    )

    return [
        ip_block_outputs[0],
        VivadoIPBlockInfo(repo = [ip_dir] + ip_block_dirs, vendor = ctx.attr.ip_vendor, library = ctx.attr.ip_library, version = ctx.attr.ip_version, module_top = ctx.attr.module_top),
    ]

vivado_create_ip = rule(
    implementation = _vivado_create_ip_impl,
    doc = "Use vivado to package a module into an IP core",
    attrs = {
        "module": attr.label(
            doc = "The top level build.",
            providers = [VerilogInfo],
            mandatory = True,
        ),
        "module_top": attr.string(
            doc = "The name of the top level verilog module.",
            mandatory = True,
        ),
        "ip_blocks": attr.label_list(
            doc = "Ip blocks to include in this design.",
            providers = [VivadoIPBlockInfo],
            default = [],
        ),
        "part_number": attr.string(
            doc = "The targeted xilinx part.",
            mandatory = True,
        ),
        "ip_version": attr.string(
            doc = "The version of this ip core.",
            mandatory = True,
        ),
        "ip_library": attr.string(
            doc = "The version of this ip core.",
            mandatory = True,
        ),
        "ip_vendor": attr.string(
            doc = "The version of this ip core.",
            mandatory = True,
        ),
        "encrypt": attr.bool(
            doc = "Encrypt the sources. Note: This requires a license. See: https://support.xilinx.com/s/article/68071?language=en_US",
            default = False,
        ),
        "jobs": attr.int(
            doc = "Jobs to pass to vivado which defines the amount of parallelism.",
            default = 4,
        ),
        "xilinx_env": attr.label(
            doc = "A shell script to source the vivado environment and " +
                  "point to license server",
            mandatory = True,
            allow_single_file = [".sh"],
        ),
        "create_ip_block_template": attr.label(
            doc = "The create project tcl template",
            default = "@rules_hdl//vivado:create_ip_block.tcl.template",
            allow_single_file = [".template"],
        ),
        "keyfile": attr.label(
            doc = "The keyfile to use when optionally encrypting",
            default = "@rules_hdl//vivado:xilinx_keyfile.txt",
            allow_single_file = [".txt"],
        ),
    },
    provides = [
        DefaultInfo,
        VivadoIPBlockInfo,
    ],
)
