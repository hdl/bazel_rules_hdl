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

    open_road_commands = timing_setup_command_struct.commands + [
        "detailed_route -output_drc {}".format(output_drc.path),
        "write_def {}".format(
            routed_def.path,
        ),
    ]

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
