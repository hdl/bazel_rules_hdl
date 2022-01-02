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

load("//place_and_route:open_road.bzl", "OpenRoadInfo", "format_openroad_do_not_use_list", "merge_open_road_info", "openroad_command")
load("//synthesis:build_defs.bzl", "SynthesisInfo")
load("//pdk:open_road_configuration.bzl", "get_open_road_configuration")

def resize(ctx, open_road_info):
    """Performs resizing operation of the standard cells.

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

    open_road_commands = [
        "read_liberty {liberty_file}".format(
            liberty_file = liberty.path,
        ),
        "create_clock [get_ports clk] -period {period}".format(
            period = ctx.attr.clock_period,
        ),
        "set_wire_rc -signal -layer \"{signal_layer}\"".format(
            signal_layer = open_road_configuration.wire_rc_signal_metal_layer,
        ),
        "set_wire_rc -clock  -layer \"{clock_layer}\"".format(
            clock_layer = open_road_configuration.wire_rc_clock_metal_layer,
        ),
        format_openroad_do_not_use_list(open_road_configuration.do_not_use_cell_list),
        "estimate_parasitics -placement",
        "repair_design",
        "repair_tie_fanout -separation {separation} \"{high_cell}\"".format(
            separation = open_road_configuration.tie_separation,
            high_cell = open_road_configuration.tie_high_port,
        ),
        "repair_tie_fanout -separation {separation} \"{low_cell}\"".format(
            separation = open_road_configuration.tie_separation,
            low_cell = open_road_configuration.tie_high_port,
        ),
        "set_placement_padding -global -left 2 -right 2",
        "detailed_placement",
        "optimize_mirroring",
        "check_placement -verbose",
        "report_checks -path_delay min_max -format full_clock_expanded -fields {input_pin slew capacitance} -digits 3",
        "report_check_types -max_slew -max_capacitance -max_fanout -violators",
    ]

    inputs = [
        liberty,
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
