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

"""Clock Tree Synthesis openROAD commands"""

load("//place_and_route:open_road.bzl", "OpenRoadInfo", "format_openroad_do_not_use_list", "merge_open_road_info", "openroad_command")
load("//synthesis:build_defs.bzl", "SynthesisInfo")
load("@rules_hdl//pdk:open_road_configuration.bzl", "get_open_road_configuration")

def clock_tree_synthesis(ctx, open_road_info):
    """Performs clock tree synthesis.

    Returns:
        OpenRoadInfo: the openROAD info provider containing required input files and
            and commands run.
    Args:
       ctx: Bazel rule ctx
       open_road_info: OpenRoadInfo provider from a previous step.

    """
    netlist_target = ctx.attr.synthesized_rtl
    liberty = netlist_target[SynthesisInfo].standard_cell_info.default_corner.liberty
    open_road_configuration = get_open_road_configuration(ctx.attr.synthesized_rtl[SynthesisInfo])
    rc_script = open_road_configuration.rc_script_configuration

    inputs = [
        liberty,
    ]

    if rc_script:
        inputs.append(rc_script)

    open_road_commands = [
        "read_liberty {liberty_file}".format(
            liberty_file = liberty.path,
        ),
        "source {}".format(rc_script.path) if rc_script else "",
        "remove_buffers",
        "set_wire_rc -signal -layer \"{}\"".format(open_road_configuration.wire_rc_signal_metal_layer),
        "set_wire_rc -clock  -layer \"{}\"".format(open_road_configuration.wire_rc_clock_metal_layer),
        format_openroad_do_not_use_list(open_road_configuration.do_not_use_cell_list),
        "configure_cts_characterization",
        "estimate_parasitics -placement",
        "repair_clock_inverters",
        "clock_tree_synthesis -root_buf \"{cts_buffer}\" -buf_list \"{cts_buffer}\" -sink_clustering_enable".format(
            cts_buffer = open_road_configuration.cts_buffer_cell,
        ),
        "repair_clock_nets",
        "estimate_parasitics -placement",
        "set_propagated_clock [all_clocks]",
        "repair_timing",
        "detailed_placement",
        "report_checks -path_delay min_max -format full_clock_expanded -fields {input_pin slew capacitance} -digits 3",
        "detailed_placement",
        "filler_placement \"{filler_cells}\"".format(
            filler_cells = " ".join(open_road_configuration.fill_cells),
        ),
        "check_placement",
    ]

    command_output = openroad_command(
        ctx,
        commands = open_road_commands,
        input_db = open_road_info.output_db,
        inputs = inputs,
        step_name = "clock_tree_synthesis",
    )

    current_action_open_road_info = OpenRoadInfo(
        commands = open_road_commands,
        input_files = depset(inputs),
        output_db = command_output.db,
        logs = depset([command_output.log_file]),
    )

    return merge_open_road_info(open_road_info, current_action_open_road_info)
