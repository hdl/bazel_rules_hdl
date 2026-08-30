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

"""Functions for DSIM."""

load("//verilog:defs.bzl", "VerilogInfo")

_RUNFILES = ["dat", "mem"]

def _dsim_run(ctx):
    transitive_srcs = depset([], transitive = [ctx.attr.module[VerilogInfo].dag]).to_list()

    all_srcs = [verilog_info_struct.srcs for verilog_info_struct in transitive_srcs]
    all_hdrs = [verilog_info_struct.hdrs for verilog_info_struct in transitive_srcs]
    all_data = [verilog_info_struct.data for verilog_info_struct in transitive_srcs]

    all_files = [src for sub_tuple in (all_srcs + all_data) for src in sub_tuple]
    all_hdrs = [hdr for sub_tuple in all_hdrs for hdr in sub_tuple]

    # Filter out data files.
    runfiles = []
    verilog_files = []
    for file in all_files:
        if file.extension in _RUNFILES:
            runfiles.append(file)
        else:
            verilog_files.append(file)

    # FIXME: Some libraries provide .v/.sv files that are in fact header files
    # append them to the list of header files to collect their directories
    # for +include+ as well.

    # Include directories
    include_dirs = depset([f.dirname for f in (verilog_files + all_hdrs)]).to_list()

    # Log file
    dsim_log = ctx.actions.declare_file("{}.log".format(ctx.label.name))

    # Build DSim command
    command = "source " + ctx.file.dsim_env.path + " && "
    command += "dsim"
    command += " -l " + dsim_log.path

    for opt in ctx.attr.opts:
        command += " " + opt

    for pth in include_dirs:
        command += " +incdir+" + pth

    for verilog_file in verilog_files:
        command += " " + verilog_file.path

    inputs = [ctx.file.dsim_env] + verilog_files + all_hdrs
    outputs = [dsim_log] + ctx.outputs.outs
    generated_files = [dsim_log]

    # Coverage file
    if ctx.attr.enable_code_coverage:
        dsim_cov = ctx.actions.declare_file("{}.db".format(ctx.label.name))
        command += " -cov-db " + dsim_cov.path
        if ctx.attr.code_coverage_type in ["toggle", "all"]:
            command += " +acc+b "
        command += " -code-cov " + ctx.attr.code_coverage_type
        if ctx.attr.code_coverage_scope != "":
            scope_file = ctx.actions.declare_file("{}.scope".format(ctx.label.name))
            ctx.actions.write(
                output = scope_file,
                content = "path {} +".format(ctx.attr.code_coverage_scope),
            )
            command += " -code-cov-scope-specs {}".format(scope_file.path)
            inputs.append(scope_file)
        outputs.append(dsim_cov)
        generated_files.append(dsim_cov)

        if ctx.attr.code_coverage_report:
            dsim_report = ctx.actions.declare_directory("{}_report".format(ctx.label.name))
            command += " && dcreport -out_dir {} {}".format(dsim_report.path, dsim_cov.path)
            outputs.append(dsim_report)
            generated_files.append(dsim_report)

    ctx.actions.run_shell(
        outputs = outputs,
        inputs = inputs,
        progress_message = "Running DSIM: {}".format(ctx.label.name),
        command = command,
    )

    return [
        DefaultInfo(
            files = depset(generated_files),
            runfiles = ctx.runfiles(files = runfiles),
        ),
    ]

dsim_run = rule(
    implementation = _dsim_run,
    attrs = {
        "code_coverage_report": attr.bool(
            doc = "Run dcreport after dsim run",
            default = False,
        ),
        "code_coverage_scope": attr.string(
            doc = "Select coverage scope using hierarchical path",
            default = "",
        ),
        "code_coverage_type": attr.string(
            doc = "Select coverage type: block, expression, toggle or all",
            default = "all",
        ),
        "dsim_env": attr.label(
            doc = "A shell script to source the DSIM environment and " +
                  "point to license server",
            mandatory = True,
            allow_single_file = [".sh"],
        ),
        "enable_code_coverage": attr.bool(
            doc = "Gather simulation coverage",
            default = False,
        ),
        "module": attr.label(
            doc = "The top level build.",
            providers = [VerilogInfo],
            mandatory = True,
        ),
        "module_top": attr.string(
            doc = "The name of the top level verilog module.",
            mandatory = True,
        ),
        "opts": attr.string_list(
            doc = "Additional command line options to pass to DSIM",
            default = [],
        ),
        "outs": attr.output_list(
            doc = "List of simulation products",
        ),
    },
)
