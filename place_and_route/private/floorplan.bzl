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

"""Floorplaning openROAD commands"""

load("@rules_hdl//pdk:open_road_configuration.bzl", "get_open_road_configuration")
load("//place_and_route:open_road.bzl", "OpenRoadInfo", "openroad_command")
load("//place_and_route:private/report_area.bzl", "generate_area_results")
load("//place_and_route:private/report_power.bzl", "generate_power_results")
load("//synthesis:build_defs.bzl", "SynthesisInfo")

def _initialize_floorplan_command(ctx):
    open_road_configuration = get_open_road_configuration(ctx.attr.synthesized_rtl[SynthesisInfo])

    if ctx.attr.die_width_microns and ctx.attr.die_height_microns:
        return "initialize_floorplan -site \"{site}\" -die_area {die_area} -core_area {core_area}".format(
            die_area = "\"0 0 {width} {height}\"".format(
                width = ctx.attr.die_width_microns,
                height = ctx.attr.die_height_microns,
            ),
            core_area = "\"{lx} {ly} {ux} {uy}\"".format(
                lx = ctx.attr.core_padding_microns,
                ly = ctx.attr.core_padding_microns,
                ux = ctx.attr.die_width_microns - ctx.attr.core_padding_microns,
                uy = ctx.attr.die_height_microns - ctx.attr.core_padding_microns,
            ),
            site = open_road_configuration.cell_site,
        )

    if ctx.attr.target_die_utilization_percentage:
        utilization = ctx.attr.target_die_utilization_percentage  #TODO(bazel): When bazel 4.0.0 is avaliable use float command
        return "initialize_floorplan -site \"{site}\" -utilization {utilization} -core_space {core_space}".format(
            utilization = utilization,
            core_space = ctx.attr.core_padding_microns,
            site = open_road_configuration.cell_site,
        )

    fail("either (die_width_microns and die_height_microns) or `utilization` must be set")

def init_floor_plan(ctx):
    """Initializes the floor plan based on user ctx args.

    Returns:
        OpenRoadInfo: the openROAD info provider containing required input files and
            and commands run.
    Args:
       ctx: Bazel rule ctx

    """
    netlist_target = ctx.attr.synthesized_rtl
    open_road_configuration = get_open_road_configuration(netlist_target[SynthesisInfo])
    netlist = netlist_target[SynthesisInfo].synthesized_netlist
    top_module = netlist_target[SynthesisInfo].top_module
    liberty = netlist_target[SynthesisInfo].standard_cell_info.default_corner.liberty
    tech_lef = netlist_target[SynthesisInfo].standard_cell_info.tech_lef
    std_cell_lef = netlist_target[SynthesisInfo].standard_cell_info.cell_lef_definitions
    verilog_based_power_results = ctx.actions.declare_file("{}_verilog_based_power_results.textproto".format(ctx.attr.name))
    verilog_based_area_results = ctx.actions.declare_file("{}_verilog_based_area_results.textproto".format(ctx.attr.name))
    tieoneport = open_road_configuration.tie_high_port
    tiezeroport = open_road_configuration.tie_low_port

    open_road_commands = [
        "read_lef {tech_lef}".format(
            tech_lef = tech_lef.path,
        ),
    ]
    for file in std_cell_lef:
        open_road_commands.append("read_lef {}".format(file.path))
    open_road_commands.extend([
        "read_liberty {liberty}".format(
            liberty = liberty.path,
        ),
        "read_verilog {verilog}".format(
            verilog = netlist.path,
        ),
        "link_design {top_module}".format(
            top_module = top_module,
        ),
        _initialize_floorplan_command(ctx),
        "source {tracks_file}".format(
            tracks_file = open_road_configuration.tracks_file.path,
        ),
        "remove_buffers",
        "insert_tiecells {port} -prefix \"TIE_ONE_\"".format(
            port = tieoneport,
        ),
        "insert_tiecells {port} -prefix \"TIE_ZERO_\"".format(
            port = tiezeroport,
        ),
    ])
    open_road_commands.extend(generate_power_results(ctx, verilog_based_power_results))
    open_road_commands.extend(generate_area_results(verilog_based_area_results))

    input_open_road_files = [
        netlist,
        liberty,
        tech_lef,
        open_road_configuration.tracks_file,
    ] + std_cell_lef

    command_output = openroad_command(
        ctx,
        commands = open_road_commands,
        inputs = input_open_road_files,
        step_name = "floorplan",
        outputs = [
            verilog_based_power_results,
            verilog_based_area_results,
        ],
    )

    return OpenRoadInfo(
        commands = open_road_commands,
        output_db = command_output.db,
        logs = depset([command_output.log_file]),
        input_files = depset(direct = input_open_road_files),
        verilog_based_power_results = verilog_based_power_results,
        verilog_based_area_results = verilog_based_area_results,
    )
