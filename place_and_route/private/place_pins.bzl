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

"""Pin Placement openROAD commands"""

load("@rules_hdl//pdk:open_road_configuration.bzl", "get_open_road_configuration")
load("//place_and_route:open_road.bzl", "OpenRoadInfo", "merge_open_road_info", "openroad_command", "timing_setup_commands")
load("//synthesis:build_defs.bzl", "SynthesisInfo")

def place_pins(ctx, open_road_info):
    """Places pins around the die area.

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

    tapcell_command = "tapcell -distance {tapcell_distance} -tapcell_master {tapcell}".format(
        tapcell = open_road_configuration.tap_cell,
        tapcell_distance = open_road_configuration.tapcell_distance,
        endcap = open_road_configuration.endcap_cell,
    )

    if open_road_configuration.tapcell_tcl:
        inputs = inputs + [
            open_road_configuration.tapcell_tcl,
        ]
        tapcell_command = "source {}".format(open_road_configuration.tapcell_tcl.path)

    open_road_commands = timing_setup_command_struct.commands + [
        "remove_buffers",
        "place_pins -hor_layers {hor_layers} -ver_layers {ver_layers}".format(
            hor_layers = open_road_configuration.pin_horizontal_metal_layer,
            ver_layers = open_road_configuration.pin_vertical_metal_layer,
        ),
        tapcell_command,
    ]

    command_output = openroad_command(
        ctx,
        inputs = inputs,
        commands = open_road_commands,
        input_db = open_road_info.output_db,
        step_name = "place_pins",
    )

    place_pins_open_road_info = OpenRoadInfo(
        commands = open_road_commands,
        input_files = depset(inputs),
        output_db = command_output.db,
        logs = depset([command_output.log_file]),
    )

    return merge_open_road_info(open_road_info, place_pins_open_road_info)
