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

"""Global Routing openROAD commands"""

load("//place_and_route:open_road.bzl", "OpenRoadInfo", "merge_open_road_info", "openroad_command")
load("//synthesis:build_defs.bzl", "SynthesisInfo")
load("//place_and_route/private:report_area.bzl", "generate_area_results")
load("//pdk:open_road_configuration.bzl", "get_open_road_configuration")

def _generate_power_results(output_file, liberty):
    return [
        "set power_result [sta::design_power [sta::parse_corner {}]]",
        "set fp [open \"{output_file}\" w+]".format(
            output_file = output_file.path,
        ),
        "puts $fp \"total_package_power_watts: [lindex $power_result 3]\"",
        "puts $fp \"corner: \\\"{corner}\\\"\"".format(
            corner = liberty.basename[:-(len(liberty.extension) + 1)],
        ),
        "puts $fp \"power_maginitude: \\\"[sta::unit_scale_abreviation \"power\"]\\\"\"",
        "close $fp",
    ]

def _global_routing_layer_adjustments(adjustments):
    adjustment_command = "{"
    for layer, value in adjustments.items():
        adjustment_command += "{{{metal_layer} {adjustment}}}".format(
            metal_layer = layer,
            adjustment = value,
        )
        adjustment_command += " "
    adjustment_command += "}"
    return adjustment_command

def global_routing(ctx, open_road_info):
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

    route_guide = ctx.actions.declare_file("{}.route_guide".format(ctx.attr.name))
    power_results = ctx.actions.declare_file("{}_power_results.textproto".format(ctx.attr.name))
    area_results = ctx.actions.declare_file("{}_area_results.textproto".format(ctx.attr.name))

    open_road_configuration = get_open_road_configuration(ctx.attr.synthesized_rtl[SynthesisInfo])

    open_road_commands = [
        "read_liberty {liberty_file}".format(
            liberty_file = liberty.path,
        ),
        "create_clock [get_ports clk] -period {period}".format(
            period = ctx.attr.clock_period,
        ),
        """
foreach layer_adjustment {global_routing_layer_adjustments} {{
    lassign $layer_adjustment layer adjustment
    set_global_routing_layer_adjustment $layer $adjustment
}}
        """.format(
            global_routing_layer_adjustments = _global_routing_layer_adjustments(open_road_configuration.global_routing_layer_adjustments),
        ),
        "set_routing_layers -signal \"{global_routing_layers}\" -clock \"{global_routing_clock_layers}\"".format(
            global_routing_layers = open_road_configuration.global_routing_signal_layers,
            global_routing_clock_layers = open_road_configuration.global_routing_clock_layers,
        ),
        "global_route -guide_file \"{route_guide}\" -congestion_iterations 100".format(
            route_guide = route_guide.path,
        ),
        "estimate_parasitics -global_routing",
        "report_checks -path_delay min_max -format full_clock_expanded -fields {input_pin slew capacitance} -digits 3",
        "report_wns",
        "report_tns",
        "report_check_types -max_slew -max_capacitance -max_fanout -violators",
        "report_power",
        "report_floating_nets -verbose",
        "report_design_area",
        "report_units",
        "set_power_activity -input -activity 1 -duty 0.5",
    ]
    open_road_commands.extend(_generate_power_results(power_results, liberty))
    open_road_commands.extend(generate_area_results(area_results))

    inputs = [
        liberty,
    ]

    command_output = openroad_command(
        ctx,
        commands = open_road_commands,
        input_db = open_road_info.output_db,
        inputs = inputs,
        outputs = [
            route_guide,
            power_results,
            area_results,
        ],
        step_name = "global_routing",
    )

    current_action_open_road_info = OpenRoadInfo(
        commands = open_road_commands,
        input_files = depset(inputs),
        output_db = command_output.db,
        logs = depset([command_output.log_file]),
        routing_guide = route_guide,
        power_results = power_results,
        area_results = area_results,
    )

    return merge_open_road_info(open_road_info, current_action_open_road_info)
