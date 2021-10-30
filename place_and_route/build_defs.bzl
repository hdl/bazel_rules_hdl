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

load("//synthesis:build_defs.bzl", "SynthesisInfo")
load("//pdk:open_road_configuration.bzl", "assert_has_open_road_configuration")
load("//place_and_route:private/floorplan.bzl", "init_floor_plan")
load("//place_and_route:private/place_pins.bzl", "place_pins")
load("//place_and_route:private/pdn_gen.bzl", "pdn_gen")
load("//place_and_route:private/global_placement.bzl", "global_placement")
load("//place_and_route:private/resize.bzl", "resize")
load("//place_and_route:private/clock_tree_synthesis.bzl", "clock_tree_synthesis")
load("//place_and_route:private/global_routing.bzl", "global_routing")
load("//place_and_route:private/detailed_routing.bzl", "detailed_routing")

def _place_and_route_impl(ctx):
    # Throws an error if there is no OpenROAD configuration
    assert_has_open_road_configuration(ctx.attr.synthesized_rtl[SynthesisInfo])

    open_road_provider = init_floor_plan(ctx)
    open_road_provider = place_pins(ctx, open_road_provider)
    open_road_provider = pdn_gen(ctx, open_road_provider)
    open_road_provider = global_placement(ctx, open_road_provider)
    open_road_provider = resize(ctx, open_road_provider)
    open_road_provider = clock_tree_synthesis(ctx, open_road_provider)
    open_road_provider = global_routing(ctx, open_road_provider)
    open_road_provider = detailed_routing(ctx, open_road_provider)
    return [
        DefaultInfo(
            files = depset(
                [open_road_provider.output_db, open_road_provider.routed_def, open_road_provider.power_results, open_road_provider.area_results] +
                open_road_provider.logs.to_list(),
            ),
        ),
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
        "local_detailed_routing_execution": attr.bool(
            default = False,
            doc = "Whether to run detailed routing on a remote executor. If the detailed routing exceeds 15 minutes flip this setting.",
        ),
        "clock_period": attr.string(
          mandatory = True,
          doc = """
          The amount of time a single clock period lasts. Bazel doesn't support floats so enter the clock period as a decimal in string form.
          The units currently depend on the PDK you're targeting. The default PDK is sky130 and it uses nano seconds for ASAP7 it is pico seconds.
          """
        ),
        "die_width_microns": attr.int(),
        "die_height_microns": attr.int(),
        "core_padding_microns": attr.int(mandatory = True),
        "target_die_utilization_percentage": attr.string(doc = "string float value from 0-100 which sets the die area based on an estimated die area target utilization"),
        "placement_density": attr.string(default = "0.69", doc = "When performing global placement this is how densely our cells should be packaged on the die parameter is (0-1]"),
    },
)
