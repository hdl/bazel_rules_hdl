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

"""Resize openROAD commands"""

load("@rules_hdl//pdk:open_road_configuration.bzl", "get_open_road_configuration")
load("//place_and_route:open_road.bzl", "OpenRoadInfo", "format_openroad_do_not_use_list", "merge_open_road_info", "openroad_command", "placement_padding_commands", "timing_setup_commands")
load("//synthesis:build_defs.bzl", "SynthesisInfo")

def resize(ctx, open_road_info):
    """Performs resizing operation of the standard cells.

    Returns:
        OpenRoadInfo: the openROAD info provider containing required input files and
            and commands run.
    Args:
       ctx: Bazel rule ctx
       open_road_info: OpenRoadInfo provider from a previous step.

    """
    open_road_configuration = get_open_road_configuration(ctx.attr.synthesized_rtl[SynthesisInfo])

    timing_setup_command_struct = timing_setup_commands(ctx)
    placement_padding_struct = placement_padding_commands(ctx)

    inputs = timing_setup_command_struct.inputs + placement_padding_struct.inputs

    open_road_commands = timing_setup_command_struct.commands + [
        format_openroad_do_not_use_list(open_road_configuration.do_not_use_cell_list),
        "estimate_parasitics -placement",
        "buffer_ports",
        "repair_design",
        "repair_tie_fanout -separation {separation} \"{high_cell}\"".format(
            separation = open_road_configuration.tie_separation,
            high_cell = open_road_configuration.tie_high_port,
        ),
        "repair_tie_fanout -separation {separation} \"{low_cell}\"".format(
            separation = open_road_configuration.tie_separation,
            low_cell = open_road_configuration.tie_low_port,
        ),
    ] + placement_padding_struct.commands + [
        "detailed_placement",
        "improve_placement",
        "optimize_mirroring",
        "check_placement -verbose",
        "report_checks -path_delay min_max -format full_clock_expanded -fields {input_pin slew capacitance} -digits 3",
        "report_check_types -max_slew -max_capacitance -max_fanout -violators",
    ]

    command_output = openroad_command(
        ctx,
        commands = open_road_commands,
        input_db = open_road_info.output_db,
        inputs = inputs,
        step_name = "resizing",
    )

    current_action_open_road_info = OpenRoadInfo(
        commands = open_road_commands,
        input_files = depset(inputs),
        output_db = command_output.db,
        logs = depset([command_output.log_file]),
    )

    return merge_open_road_info(open_road_info, current_action_open_road_info)
