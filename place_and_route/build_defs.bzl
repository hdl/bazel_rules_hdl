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

"""These build rules run automated place and route on a synthesized netlist"""

load("@rules_hdl//pdk:open_road_configuration.bzl", "assert_has_open_road_configuration")
load("//place_and_route:private/clock_tree_synthesis.bzl", "clock_tree_synthesis")
load("//place_and_route:private/detailed_routing.bzl", "detailed_routing")
load("//place_and_route:private/floorplan.bzl", "init_floor_plan")
load("//place_and_route:private/global_placement.bzl", "global_placement")
load("//place_and_route:private/global_routing.bzl", "global_routing")
load("//place_and_route:private/pdn_gen.bzl", "pdn_gen")
load("//place_and_route:private/place_pins.bzl", "place_pins")
load("//place_and_route:private/resize.bzl", "resize")
load("//synthesis:build_defs.bzl", "SynthesisInfo")

def _place_and_route_impl(ctx):
    # Throws an error if there is no OpenROAD configuration
    assert_has_open_road_configuration(ctx.attr.synthesized_rtl[SynthesisInfo])

    output_files = []

    open_road_provider = init_floor_plan(ctx)
    open_road_provider = place_pins(ctx, open_road_provider)
    open_road_provider = pdn_gen(ctx, open_road_provider)
    open_road_provider = global_placement(ctx, open_road_provider)
    open_road_provider = resize(ctx, open_road_provider)
    open_road_provider = clock_tree_synthesis(ctx, open_road_provider)
    open_road_provider = global_routing(ctx, open_road_provider)
    if not ctx.attr.skip_detailed_routing:
        open_road_provider = detailed_routing(ctx, open_road_provider)
        output_files.append(open_road_provider.routed_def)

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
        "synthesized_rtl": attr.label(mandatory = True, providers = [SynthesisInfo]),
        "_openroad": attr.label(
            default = Label("@org_theopenroadproject//:openroad"),
            executable = True,
            cfg = "exec",
        ),
        "skip_detailed_routing": attr.bool(
            default = False,
            doc = "Whether to skip detailed routing. This step is slow and is only required if requiring a fully manufacturable routed_def.",
        ),
        "local_detailed_routing_execution": attr.bool(
            default = False,
            doc = "Whether to run detailed routing on a remote executor. If the detailed routing exceeds 15 minutes flip this setting.",
        ),
        "clock_period": attr.string(
            doc = """
          The amount of time a single clock period lasts. Bazel doesn't support floats so enter the clock period as a decimal in string form.
          The units currently depend on the PDK you're targeting. The default PDK is sky130 and it uses nano seconds for ASAP7 it is pico seconds.
          """,
        ),
        "sdc": attr.label(allow_single_file = True),
        "clocks": attr.string_dict(),
        "die_width_microns": attr.int(),
        "die_height_microns": attr.int(),
        "core_padding_microns": attr.int(mandatory = True),
        "target_die_utilization_percentage": attr.string(doc = "string float value from 0-100 which sets the die area based on an estimated die area target utilization"),
        "placement_density": attr.string(default = "0.69", doc = "When performing global placement this is how densely our cells should be packaged on the die parameter is (0-1]"),
        "density_fill_config": attr.label(allow_single_file = True),
    },
)
