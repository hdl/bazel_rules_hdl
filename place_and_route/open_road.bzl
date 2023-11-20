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

load("@rules_hdl//pdk:open_road_configuration.bzl", "get_open_road_configuration")
load("//synthesis:build_defs.bzl", "SynthesisInfo")

OpenRoadInfo = provider(
    "Provider to support running openroad outside of bazel",
    fields = [
        "commands",
        "input_files",
        "output_db",
        "routed_def",
        "verilog_based_power_results",
        "verilog_based_area_results",
        "general_routing_power_results",
        "general_routing_area_results",
        "logs",
    ],
)

def timing_setup_commands(ctx):
    """Create command list for timing setup information.

    Args:
        ctx: Bazel Context

    Returns:
        Struct with params inputs and commands. Both return values are lists.
    """
    inputs = []
    commands = []

    netlist_target = ctx.attr.synthesized_rtl
    liberty = netlist_target[SynthesisInfo].standard_cell_info.default_corner.liberty
    open_road_configuration = get_open_road_configuration(ctx.attr.synthesized_rtl[SynthesisInfo])
    rc_script = open_road_configuration.rc_script_configuration

    # Liberty Setup
    inputs.append(liberty)
    commands.append("read_liberty {liberty_file}".format(
        liberty_file = liberty.path,
    ))

    # SDC/Clock Setup
    clock_commands_struct = clock_commands(ctx)
    commands.extend(clock_commands_struct.commands)
    inputs.extend(clock_commands_struct.inputs)

    # RC Layer Value Setup
    if rc_script:
        inputs.append(rc_script)
        commands.append("source {}".format(rc_script.path))

    commands.extend([
        "set_wire_rc -signal -layer \"{signal_layer}\"".format(
            signal_layer = open_road_configuration.wire_rc_signal_metal_layer,
        ),
        "set_wire_rc -clock  -layer \"{clock_layer}\"".format(
            clock_layer = open_road_configuration.wire_rc_clock_metal_layer,
        ),
    ])

    return struct(inputs = inputs, commands = commands)

def placement_padding_commands(ctx):
    """Generate placement padding commands

    Args:
        ctx: Bazel Context

    Returns:
        Struct with params inputs and commands. Both return values are lists.
    """
    open_road_configuration = get_open_road_configuration(ctx.attr.synthesized_rtl[SynthesisInfo])
    placement_padding = open_road_configuration.placement_padding_tcl

    commands = ["set_placement_padding -global -left 2 -right 2"]
    inputs = []
    if placement_padding:
        commands = ["source {}".format(placement_padding.path)]
        inputs = [placement_padding]

    return struct(inputs = inputs, commands = commands)

def clock_commands(ctx):
    """Generate clock arguments based on bazel configuration.

    Generates a struct of required file inputs and open road comamnd lists.

    Args:
        ctx: Bazel Context

    Returns:
        Struct with params inputs and commands. Both return values are lists.
    """
    sdc = ctx.file.sdc

    if sdc:
        return struct(inputs = [sdc], commands = ["read_sdc {}".format(sdc.path)])

    # If no name is passed, the clock is assumed to be named "clk".
    if ctx.attr.clock_period:
        return struct(
            inputs = [],
            commands = [
                "create_clock [get_ports clk] -period {period}".format(
                    period = ctx.attr.clock_period,
                ),
            ],
        )

    return struct(
        inputs = [],
        commands = [
            "create_clock [get_ports {clock_name}] -period {period}".format(
                period = ctx.attr.clocks[clock_name],
                clock_name = clock_name,
            )
            for clock_name in ctx.attr.clocks
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
    verilog_based_power_results = _merge_right(left, right, "verilog_based_power_results")
    verilog_based_area_results = _merge_right(left, right, "verilog_based_area_results")
    general_routing_power_results = _merge_right(left, right, "general_routing_power_results")
    general_routing_area_results = _merge_right(left, right, "general_routing_area_results")

    return OpenRoadInfo(
        commands = left.commands + right.commands,
        input_files = depset([], transitive = [left.input_files, right.input_files]),
        logs = depset([], transitive = [left.logs, right.logs]),
        output_db = right.output_db,
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
            "-threads",
            "max",
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
        mnemonic = "OpenROAD",
        toolchain = None,
    )

    return struct(db = output_db, log_file = log_file)
