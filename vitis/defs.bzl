"""Defs for generating verilog using HLS"""

HlsFileInfo = provider(
    "HLS files required by vitis",
    fields = {
        "files": "a list of files",
    },
)

def _vitis_hls_files_aspect_impl(target, ctx):
    """Filter out the vitis header deps."""
    files = []

    for f in target[CcInfo].compilation_context.headers.to_list():
        if "vitis/v" not in f.dirname:
            files.append(f)

    if hasattr(ctx.rule.attr, "srcs"):
        for src in ctx.rule.attr.srcs:
            for f in src.files.to_list():
                if f not in files and "vitis/v" not in f.dirname:
                    files.append(f)

    if hasattr(ctx.rule.attr, "deps"):
        for dep in ctx.rule.attr.deps:
            files = files + dep[HlsFileInfo].files

    return [HlsFileInfo(files = files)]

vitis_hls_files_aspect = aspect(
    implementation = _vitis_hls_files_aspect_impl,
    attr_aspects = ["deps"],
)

def _vitis_generate_impl(ctx):
    all_files = []
    cflags = "-D__SYNTHESIS__=1 --std=c++17"
    for dep in ctx.attr.deps:
        for file in dep[HlsFileInfo].files:
            external_path = "/".join([file.root.path, file.owner.workspace_root]) if file.root.path else file.owner.workspace_root
            cflags += " -I" + external_path

    source_file_str = ""
    for dep in ctx.attr.deps:
        for file in dep[HlsFileInfo].files:
            all_files.append(file)
            source_file_str += "add_file " + file.path + " -cflags \"" + cflags + "\"\n"

    vitis_tcl = ctx.actions.declare_file("{}_run_hls.tcl".format(ctx.label.name))
    vitis_log = ctx.actions.declare_file("{}_hls.log".format(ctx.label.name))

    substitutions = {
        "{{PROJECT_NAME}}": ctx.label.name,
        "{{SOURCE_FILES}}": source_file_str,
        "{{TOP_LEVEL_FUNCTION}}": ctx.attr.top_func,
        "{{PART_NUMBER}}": ctx.attr.part_number,
        "{{CLOCK_PERIOD}}": ctx.attr.clock_period,
    }

    ctx.actions.expand_template(
        template = ctx.file._vitis_generate_template,
        output = vitis_tcl,
        substitutions = substitutions,
    )

    vitis_command = "source " + ctx.file.xilinx_env.path + " && "
    if ctx.attr.use_vivado_hls:
        vitis_command += "vivado_hls " + vitis_tcl.path
    else:
        vitis_command += "vitis_hls " + vitis_tcl.path
    vitis_command += " -l " + vitis_log.path
    vitis_command += " && tar -czvf " + ctx.outputs.out.path + " -C "
    vitis_command += ctx.label.name + "/sol1/impl/verilog ."

    outputs = [vitis_log, ctx.outputs.out]

    if ctx.attr.use_vivado_hls:
        progress_message = "Running with vivado_hls: {}".format(ctx.label.name)
    else:
        progress_message = "Running with vitis_hls: {}".format(ctx.label.name)

    ctx.actions.run_shell(
        outputs = outputs,
        inputs = all_files + [vitis_tcl, ctx.file.xilinx_env],
        progress_message = progress_message,
        command = vitis_command,
    )

    return [
        DefaultInfo(files = depset(outputs)),
    ]

vitis_generate = rule(
    implementation = _vitis_generate_impl,
    attrs = {
        "top_func": attr.string(doc = "The name of the top level function.", mandatory = True),
        "clock_period": attr.string(doc = "The clock period for the module.", mandatory = True),
        "part_number": attr.string(doc = "The part number to use. Default is ZCU111", default = "xczu28dr-ffvg1517-2-e"),
        "deps": attr.label_list(doc = "The file to generate from", aspects = [vitis_hls_files_aspect], mandatory = True),
        "out": attr.output(doc = "The generated verilog files", mandatory = True),
        "use_vivado_hls": attr.bool(doc = "Use vivado HLS instead of vitis hls.", default = False),
        "_vitis_generate_template": attr.label(
            doc = "The tcl template to run with vitis.",
            default = "@rules_hdl//vitis:vitis_generate.tcl.template",
            allow_single_file = [".template"],
        ),
        "xilinx_env": attr.label(
            doc = "Environment variables for xilinx tools.",
            allow_single_file = [".sh"],
            mandatory = True,
        ),
    },
)
