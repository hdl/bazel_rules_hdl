# Copyright 2023 Google LLC
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

"""Export to def openROAD commands"""

load("//place_and_route:open_road.bzl", "OpenRoadInfo", "merge_open_road_info", "openroad_command")

def export_def(ctx, open_road_info, suffix):
    """Export to def.

    Returns:
        OpenRoadInfo: the openROAD info provider containing required input files and
            and commands run.
    Args:
       ctx: Bazel rule ctx
       open_road_info: OpenRoadInfo provider from a previous step.
       suffix: Suffix to use for thr def file.

    """

    inputs = []

    outputs = []
    output_def = ctx.actions.declare_file("{}__{}.def".format(ctx.attr.name, suffix))
    outputs.append(output_def)

    open_road_commands = []
    write_def_command = "write_def {}".format(output_def.path)
    open_road_commands.append(write_def_command)

    command_output = openroad_command(
        ctx,
        inputs = inputs,
        outputs = outputs,
        commands = open_road_commands,
        input_db = open_road_info.output_db,
        step_name = "export_def_" + suffix,
    )

    def_open_road_info = OpenRoadInfo(
        commands = open_road_commands,
        input_files = depset(inputs),
        output_db = command_output.db,
        logs = depset([command_output.log_file]),
    )

    return merge_open_road_info(open_road_info, def_open_road_info), output_def
