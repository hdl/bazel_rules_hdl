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

"""Detailed Routing openROAD commands"""

load("//place_and_route:open_road.bzl", "OpenRoadInfo", "merge_open_road_info", "openroad_command", "timing_setup_commands")
load("@rules_hdl//pdk:open_road_configuration.bzl", "DetailedRoutingInfo", "get_open_road_configuration")
load("//synthesis:build_defs.bzl", "SynthesisInfo")

def detailed_routing(ctx, open_road_info):
    """Performs detailed routing.

    Returns:
        OpenRoadInfo: the openROAD info provider containing required input files and
            and commands run.
    Args:
       ctx: Bazel rule ctx
       open_road_info: OpenRoadInfo provider from a previous step.

    """

    timing_setup_command_struct = timing_setup_commands(ctx)
    inputs = timing_setup_command_struct.inputs

    output_drc = ctx.actions.declare_file("{}_output_drc".format(ctx.attr.name))
    routed_def = ctx.actions.declare_file("{}_detail_routed.def".format(ctx.attr.name))

    open_road_configuration = get_open_road_configuration(ctx.attr.synthesized_rtl[SynthesisInfo])

    detailed_routing_configs = None
    if open_road_configuration.detailed_routing_configuration:
        detailed_routing_configs = open_road_configuration.detailed_routing_configuration[DetailedRoutingInfo]

    detailed_routing_args = ""
    if detailed_routing_configs:
        if detailed_routing_configs.bottom_routing_layer:
            detailed_routing_args += " -bottom_routing_layer " + detailed_routing_configs.bottom_routing_layer
        if detailed_routing_configs.top_routing_layer:
            detailed_routing_args += " -top_routing_layer " + detailed_routing_configs.top_routing_layer
        if detailed_routing_configs.via_in_pin_bottom_layer:
            detailed_routing_args += " -via_in_pin_bottom_layer " + detailed_routing_configs.via_in_pin_bottom_layer
        if detailed_routing_configs.via_in_pin_top_layer:
            detailed_routing_args += " -via_in_pin_top_layer " + detailed_routing_configs.via_in_pin_top_layer
        if detailed_routing_configs.enable_via_gen:
            detailed_routing_args += " -disable_via_gen "

    open_road_commands = timing_setup_command_struct.commands
    open_road_commands.append("detailed_route -output_drc {} {}".format(output_drc.path, detailed_routing_args))
    density_fill_config = None
    if open_road_configuration.density_fill_config:
       density_fill_config = open_road_configuration.density_fill_config.files.to_list()[0]
    if ctx.file.density_fill_config:
       density_fill_config = ctx.file.density_fill_config

    if density_fill_config:
        open_road_commands.append("set db [ord::get_db]")
        open_road_commands.append("set chip [$db getChip]")
        open_road_commands.append("set block [$chip getBlock]")
        open_road_commands.append("set obstructions [$block getObstructions]")

        open_road_commands.append("foreach obstruction $obstructions {\n" +
                                  "    odb::dbObstruction_destroy $obstruction" +
                                  "\n}")
        open_road_commands.append("density_fill -rules {}".format(density_fill_config.path))
        inputs.append(density_fill_config)
    open_road_commands.append("write_def {}".format(routed_def.path))

    execution_requirements = {}
    if ctx.attr.local_detailed_routing_execution:
        execution_requirements["no-remote-exec"] = ""

    command_output = openroad_command(
        ctx,
        commands = open_road_commands,
        input_db = open_road_info.output_db,
        inputs = inputs,
        outputs = [
            routed_def,
            output_drc,
        ],
        execution_requirements = execution_requirements,
        step_name = "detailed_routing",
    )

    current_action_open_road_info = OpenRoadInfo(
        commands = open_road_commands,
        input_files = depset(inputs),
        output_db = command_output.db,
        logs = depset([command_output.log_file]),
        routed_def = routed_def,
    )

    return merge_open_road_info(open_road_info, current_action_open_road_info)
