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

"""Global placement openROAD commands"""

load("@rules_hdl//pdk:open_road_configuration.bzl", "get_open_road_configuration")
load("//place_and_route:open_road.bzl", "OpenRoadInfo", "merge_open_road_info", "openroad_command", "timing_setup_commands")
load("//synthesis:build_defs.bzl", "SynthesisInfo")

def global_placement(ctx, open_road_info):
    """Performs the global placement of the standard cells.

    Returns:
        OpenRoadInfo: the openROAD info provider containing required input files and
            and commands run.
    Args:
       ctx: Bazel rule ctx
       open_road_info: OpenRoadInfo provider from a previous step.

    """
    open_road_configuration = get_open_road_configuration(ctx.attr.synthesized_rtl[SynthesisInfo])
    timing_setup_command_struct = timing_setup_commands(ctx)

    inputs = timing_setup_command_struct.inputs

    open_road_commands = timing_setup_command_struct.commands + [
        "global_placement -timing_driven -routability_driven -density {density} -pad_left {pad_left} -pad_right {pad_right}".format(
            density = ctx.attr.placement_density,  #TODO(bazel): When bazel 4.0.0 is avaliable use float command
            pad_left = open_road_configuration.global_placement_cell_pad,
            pad_right = open_road_configuration.global_placement_cell_pad,
        ),
        "remove_buffers",
    ]

    command_output = openroad_command(
        ctx,
        commands = open_road_commands,
        input_db = open_road_info.output_db,
        step_name = "global_placement",
        inputs = inputs,
    )

    global_place_open_road_info = OpenRoadInfo(
        commands = open_road_commands,
        input_files = depset(inputs),
        output_db = command_output.db,
        logs = depset([command_output.log_file]),
    )

    return merge_open_road_info(open_road_info, global_place_open_road_info)
