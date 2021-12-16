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

"""File encapsulating the open road command"""

load("//:flows.bzl", "FlowStepInfo", "script_prefix")

OpenRoadInfo = provider(
    "Provider to support running openroad outside of bazel",
    fields = [
        "commands",
        "input_files",
        "output_db",
        "routing_guide",
        "routed_def",
        "verilog_based_power_results",
        "verilog_based_area_results",
        "general_routing_power_results",
        "general_routing_area_results",
        "logs",
    ],
)

def format_openroad_do_not_use_list(do_not_use_list):
    if do_not_use_list:
        return "set_dont_use {{ {cell_patterns} }}".format(
            cell_patterns = " ".join(do_not_use_list),
        )

    return "set_dont_use {}"

def _merge_right(left, right, attr):
    if hasattr(right, attr):
        return getattr(right, attr)

    if hasattr(left, attr):
        return getattr(left, attr)

    return None

def merge_open_road_info(left, right):
    """Merges OpenRoadInfo providers.

    This function is useful when chaining openROAD commands when you want to chain the output of one command
    into another.

    The right's output_db takes precendece.

    Args:
        left: OpenRoadInfo
        right: OpenRoadInfo

    Returns:
        OpenRoadInfo: merged left and right OpenRoadInfo provider
    """
    routed_def = _merge_right(left, right, "routed_def")
    routing_guide = _merge_right(left, right, "routing_guide")
    verilog_based_power_results = _merge_right(left, right, "verilog_based_power_results")
    verilog_based_area_results = _merge_right(left, right, "verilog_based_area_results")
    general_routing_power_results = _merge_right(left, right, "general_routing_power_results")
    general_routing_area_results = _merge_right(left, right, "general_routing_area_results")

    return OpenRoadInfo(
        commands = left.commands + right.commands,
        input_files = depset([], transitive = [left.input_files, right.input_files]),
        logs = depset([], transitive = [left.logs, right.logs]),
        output_db = right.output_db,
        routing_guide = routing_guide,
        routed_def = routed_def,
        verilog_based_power_results = verilog_based_power_results,
        verilog_based_area_results = verilog_based_area_results,
        general_routing_power_results = general_routing_power_results,
        general_routing_area_results = general_routing_area_results,
    )

def openroad_command(ctx, commands, input_db = None, step_name = None, inputs = [], outputs = [], execution_requirements = {}):
    """Runs the openroad binary on a command script.

    This function will insert write_db commands at the end of execution by default.

    If an input_db parameter is provided a read_db command will be inserted as the first command
    of openroad.

    Returns:
        output_db: An OpenDB file as the result of the commands run.

    Args:
        ctx: the bazel ctx from a rule.
        commands: either a list of commands, or a string to be run as the command file for openroad
        input_db: An OpenDB bazel File that will be read as the first action of openroad
        step_name: gives this step a name and all output files are prefixed with this step_name
        inputs: A list of all files that are required by your commands. It does not need to include the input_db file.
        outputs: openroad command outpus
        execution_requirements: the remote executor tags.
    """

    input_hash = hash(" ".join([file.path for file in inputs]))
    command_hash = hash("\n".join(commands))

    output_db = None
    if step_name:
        output_db = ctx.actions.declare_file("{}__{}.db".format(ctx.attr.name, step_name))
    else:
        output_db = ctx.actions.declare_file("{}{}.db".format(input_hash, command_hash))

    real_commands = []
    if input_db:
        real_commands.append("read_db {}".format(input_db.path))
    real_commands.extend(commands)
    real_commands.append("write_db {}".format(output_db.path))

    # This is here to make it easy to append to the input arguments of the run command.
    # Otherwise it would fail when no input_db is provided.
    input_db_dependency = [input_db] if input_db else []

    file_name = "{}_script.tcl".format(output_db.basename[:-(len(output_db.extension) + 1)])
    command_file = ctx.actions.declare_file(file_name)
    ctx.actions.write(command_file, content = "\n".join(real_commands))

    (tool_inputs, input_manifests) = ctx.resolve_tools(tools = [ctx.attr._openroad])
    openroad_runfiles_dir = ctx.executable._openroad.path + ".runfiles"

    log_file = ctx.actions.declare_file(
        "{}.log".format(
            output_db.basename[:-(len(output_db.extension) + 1)],
        ),
    )

    ctx.actions.run(
        outputs = [output_db, log_file] + outputs,
        inputs = inputs + [command_file] + input_db_dependency,
        arguments = [
            "-no_init",
            "-no_splash",
            "-exit",
            "-log",
            log_file.path,
            "-quiet",
            command_file.path,
        ],
        executable = ctx.executable._openroad,
        tools = tool_inputs,
        input_manifests = input_manifests,
        env = {
            "TCL_LIBRARY": openroad_runfiles_dir + "/tk_tcl/library",
        },
        execution_requirements = execution_requirements,
    )

    return struct(db = output_db, log_file = log_file)

def _openroad_step_impl(ctx):
    openroad_executable = ctx.attr._openroad.files_to_run.executable
    openroad_wrapper = ctx.actions.declare_file(ctx.attr.name)
    runfiles = ctx.runfiles(files = [ctx.file.script, openroad_executable, openroad_wrapper])

    openroad_args = [
        "-no_init",
        "-no_splash",
        "-exit",
        "${RUNFILES}/" + ctx.file.script.short_path,
    ]

    commands = [script_prefix]
    commands.append("TCL_LIBRARY=${RUNFILES}/tk_tcl/library")

    exec_openroad = """{openroad} {args} "$@"\n""".format(
        openroad = "${RUNFILES}/" + openroad_executable.short_path,
        args = " ".join(openroad_args)
    )
    commands.append(exec_openroad)

    ctx.actions.write(output = openroad_wrapper,
                      content = "\n".join(commands) + "\n",
                      is_executable = True)

    return [
        FlowStepInfo(
            inputs = ctx.attr.inputs,
            outputs = ctx.attr.outputs,
            executable_type = "openroad",
            arguments = ["-quiet"], # Run quietly when part of a larger flow.
        ),
        DefaultInfo(
            executable = openroad_wrapper,
            runfiles = runfiles.merge(ctx.attr._openroad[DefaultInfo].default_runfiles),
        ),
    ]

openroad_step = rule(
    implementation = _openroad_step_impl,
    attrs = {
        "_openroad": attr.label(
            default = Label("@org_theopenroadproject//:openroad"),
            executable = True,
            cfg = "exec",
        ),
        "script": attr.label(
            doc = "OpenROAD Tcl script implementing this step.",
            allow_single_file = [".tcl"],
            mandatory = True,

        ),
        "inputs": attr.string_list(
            doc = "Name of logical inputs to the Tcl script",
        ),
        "outputs": attr.string_list(
            doc = "Name of logical outputs of the Tcl script",
        ),
    },
    executable = True,
)
