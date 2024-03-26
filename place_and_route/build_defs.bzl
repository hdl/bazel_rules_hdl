# Copyright 2024 Google LLC
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

"""These build rules run automated place and route on a synthesized netlist"""

load("@rules_hdl//pdk:open_road_configuration.bzl", "assert_has_open_road_configuration")
load("//place_and_route:private/benchmark.bzl", "benchmark")
load("//place_and_route:private/clock_tree_synthesis.bzl", "clock_tree_synthesis")
load("//place_and_route:private/detailed_routing.bzl", "detailed_routing")
load("//place_and_route:private/export_def.bzl", "export_def")
load("//place_and_route:private/floorplan.bzl", "init_floor_plan")
load("//place_and_route:private/global_placement.bzl", "global_placement")
load("//place_and_route:private/global_routing.bzl", "global_routing")
load("//place_and_route:private/pdn_gen.bzl", "pdn_gen")
load("//place_and_route:private/place_pins.bzl", "place_pins")
load("//place_and_route:private/repair.bzl", "repair")
load("//place_and_route:private/resize.bzl", "resize")
load("//synthesis:build_defs.bzl", "SynthesisInfo")

PLACE_AND_ROUTE_STEPS = [
    ("init_floor_plan", init_floor_plan, "pre_pnr"),
    ("place_pins", place_pins, ""),
    ("pdn_gen", pdn_gen, ""),
    ("global_placement", global_placement, "global_placement"),
    ("repair", repair, ""),
    ("resize", resize, ""),
    ("clock_tree_synthesis", clock_tree_synthesis, ""),
    ("global_routing", global_routing, "post_pnr"),
    ("detailed_routing", detailed_routing, "post_detailed_route"),
]

def _place_and_route_impl(ctx):
    # Throws an error if there is no OpenROAD configuration
    assert_has_open_road_configuration(ctx.attr.synthesized_rtl[SynthesisInfo])

    output_files = []
    open_road_provider = None
    for step_name, impl, export_def_name in PLACE_AND_ROUTE_STEPS:
        open_road_provider = impl(ctx) if step_name == "init_floor_plan" else impl(ctx, open_road_provider)
        if export_def_name != "":
            open_road_provider, output_def = export_def(ctx, open_road_provider, export_def_name)
            output_files.append(output_def)
        if step_name == ctx.attr.stop_after_step:
            break
    open_road_provider = benchmark(ctx, open_road_provider)

    output_files.append(open_road_provider.output_db)
    output_files.extend(open_road_provider.logs.to_list())

    if open_road_provider.verilog_based_power_results != None:
        output_files.append(open_road_provider.verilog_based_power_results)
    if open_road_provider.verilog_based_area_results != None:
        output_files.append(open_road_provider.verilog_based_area_results)
    if open_road_provider.general_routing_power_results != None:
        output_files.append(open_road_provider.general_routing_power_results)
    if open_road_provider.general_routing_area_results != None:
        output_files.append(open_road_provider.general_routing_area_results)

    command_file = ctx.actions.declare_file("{}_commands.tcl".format(ctx.attr.name))
    ctx.actions.write(command_file, content = "\n".join(open_road_provider.commands))
    output_files.append(command_file)

    return [
        DefaultInfo(files = depset(output_files)),
        ctx.attr.synthesized_rtl[SynthesisInfo],
        open_road_provider,
    ]

place_and_route = rule(
    implementation = _place_and_route_impl,
    attrs = {
        "clock_period": attr.string(
            doc = """
          The amount of time a single clock period lasts. Bazel doesn't support floats so enter the clock period as a decimal in string form.
          The units currently depend on the PDK you're targeting. The default PDK is sky130 and it uses nano seconds for ASAP7 it is pico seconds.
          """,
        ),
        "clocks": attr.string_dict(),
        "core_padding_microns": attr.int(
            mandatory = True,
        ),
        "density_fill_config": attr.label(
            allow_single_file = True,
        ),
        "die_height_microns": attr.int(),
        "die_width_microns": attr.int(),
        "enable_improve_placement": attr.bool(
            default = True,
            doc = "Enable/Disable improve_placement pass.",
        ),
        "local_detailed_routing_execution": attr.bool(
            default = False,
            doc = "Whether to run detailed routing on a remote executor. If the detailed routing exceeds 15 minutes flip this setting.",
        ),
        "min_pin_distance": attr.string(
            doc = "The minimum distance in microns between pins around the outside of the block.",
        ),
        "pin_placement_script": attr.label(
            allow_single_file = [".tcl"],
            doc = "See https://openroad.readthedocs.io/en/latest/main/src/ppl/README.html for syntax",
        ),
        "placement_density": attr.string(
            default = "0.69",
            doc = "When performing global placement this is how densely our cells should be packaged on the die parameter is (0-1]",
        ),
        "sdc": attr.label(
            allow_single_file = True,
        ),
        "sink_clustering_max_diameter": attr.int(
            doc = "Clock tree synthesis sink group desired diamater in microns",
        ),
        "sink_clustering_size": attr.int(
            doc = "Clock tree synthesis sink group size",
        ),
        "stop_after_step": attr.string(
            doc = """
            Stops the flow after the specified step. Leaving unspecified will run all pnr steps.
            """,
            values = [step[0] for step in PLACE_AND_ROUTE_STEPS],
        ),
        "synthesized_rtl": attr.label(
            mandatory = True,
            providers = [SynthesisInfo],
        ),
        "target_die_utilization_percentage": attr.string(
            doc = "string float value from 0-100 which sets the die area based on an estimated die area target utilization",
        ),
        "_openroad": attr.label(
            default = Label("@org_theopenroadproject//:openroad"),
            executable = True,
            cfg = "exec",
        ),
    },
)
