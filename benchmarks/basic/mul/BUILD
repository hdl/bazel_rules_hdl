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

""" Benchmark for mul """

load("@bazel_skylib//rules:build_test.bzl", "build_test")
load("@rules_hdl//dependency_support/com_google_skywater_pdk:cells_info.bzl", "for_each_sky130_cells")
load("@rules_hdl//dependency_support/org_theopenroadproject_asap7_pdk_r1p7:cells_info.bzl", "for_each_asap7_cells")
load("//flows:basic_asic.bzl", "basic_asic_flow")
load("//verilog:providers.bzl", "verilog_library")

package(
    default_applicable_licenses = ["//:package_license"],
    default_visibility = ["//visibility:private"],
)

verilog_library(
    name = "rtl",
    srcs = [
        "mod_mul.sv",
        "top_mul.sv",
    ],
)

build_test(
    name = "rtl_build_test",
    targets = [
        ":rtl",
    ],
)

# Run for mul on asap7 with sc7p5t_rev28
[
    basic_asic_flow(
        name = "basic-" + cell_name,
        cells = cell_target,
        extra_args = dict(
            place_and_route = dict(
                core_padding_microns = 2,
                die_height_microns = 400,
                die_width_microns = 400,
                sdc = "@rules_hdl//benchmarks/basic:common/asap7.sdc",
                skip_detailed_routing = False,
            ),
        ),
        target = ":rtl",
        top = "top_mul",
    )
    for cell_name, cell_target in for_each_asap7_cells("sc7p5t_rev28")
]

# Run for mul on asap7 with sc7p5t_rev28 using straight placement.
[
    basic_asic_flow(
        name = "straight-" + cell_name,
        cells = cell_target,
        extra_args = dict(
            place_and_route = dict(
                core_padding_microns = 2,
                die_height_microns = 400,
                die_width_microns = 400,
                manual_placement_script = "@rules_hdl//benchmarks/basic:common/place.straight.tcl",
                sdc = "@rules_hdl//benchmarks/basic:common/asap7.sdc",
                skip_detailed_routing = False,
            ),
        ),
        target = ":rtl",
        top = "top_mul",
    )
    for cell_name, cell_target in for_each_asap7_cells("sc7p5t_rev28")
]

# Run for mul on asap7 with sc7p5t_rev28 using loopback placement.
[
    basic_asic_flow(
        name = "loopback-" + cell_name,
        cells = cell_target,
        extra_args = dict(
            place_and_route = dict(
                core_padding_microns = 2,
                die_height_microns = 400,
                die_width_microns = 400,
                manual_placement_script = "@rules_hdl//benchmarks/basic:common/place.loopback.tcl",
                sdc = "@rules_hdl//benchmarks/basic:common/asap7.sdc",
                skip_detailed_routing = False,
            ),
        ),
        target = ":rtl",
        top = "top_mul",
    )
    for cell_name, cell_target in for_each_asap7_cells("sc7p5t_rev28")
]

# Run for mul on asap7 with sc7p5t_rev28 using diagonal placement.
[
    basic_asic_flow(
        name = "diagonal-" + cell_name,
        cells = cell_target,
        extra_args = dict(
            place_and_route = dict(
                core_padding_microns = 2,
                die_height_microns = 400,
                die_width_microns = 400,
                manual_placement_script = "@rules_hdl//benchmarks/basic:common/place.diagonal.tcl",
                sdc = "@rules_hdl//benchmarks/basic:common/asap7.sdc",
                skip_detailed_routing = False,
            ),
        ),
        target = ":rtl",
        top = "top_mul",
    )
    for cell_name, cell_target in for_each_asap7_cells("sc7p5t_rev28")
]

# Run for mul on sky130 with sc_hd
[
    basic_asic_flow(
        name = "basic-" + cell_name,
        cells = cell_target,
        extra_args = dict(
            place_and_route = dict(
                core_padding_microns = 2,
                die_height_microns = 200,
                die_width_microns = 100,
                sdc = "@rules_hdl//benchmarks/basic:common/sky130.sdc",
                skip_detailed_routing = False,
            ),
        ),
        target = ":rtl",
        top = "top_mul",
    )
    for cell_name, cell_target in for_each_sky130_cells("sc_hd")
]

# Run for mul on sky130 with sc_hd using straight placement.
[
    basic_asic_flow(
        name = "straight-" + cell_name,
        cells = cell_target,
        extra_args = dict(
            place_and_route = dict(
                core_padding_microns = 2,
                die_height_microns = 200,
                die_width_microns = 100,
                manual_placement_script = "@rules_hdl//benchmarks/basic:common/place.straight.tcl",
                sdc = "@rules_hdl//benchmarks/basic:common/sky130.sdc",
                skip_detailed_routing = False,
            ),
        ),
        target = ":rtl",
        top = "top_mul",
    )
    for cell_name, cell_target in for_each_sky130_cells("sc_hd")
]

# Run for mul on sky130 with sc_hd using loopback placement.
[
    basic_asic_flow(
        name = "loopback-" + cell_name,
        cells = cell_target,
        extra_args = dict(
            place_and_route = dict(
                core_padding_microns = 2,
                die_height_microns = 200,
                die_width_microns = 100,
                manual_placement_script = "@rules_hdl//benchmarks/basic:common/place.loopback.tcl",
                sdc = "@rules_hdl//benchmarks/basic:common/sky130.sdc",
                skip_detailed_routing = False,
            ),
        ),
        target = ":rtl",
        top = "top_mul",
    )
    for cell_name, cell_target in for_each_sky130_cells("sc_hd")
]

# Run for mul on sky130 with sc_hd using diagonal placement.
[
    basic_asic_flow(
        name = "diagonal-" + cell_name,
        cells = cell_target,
        extra_args = dict(
            place_and_route = dict(
                core_padding_microns = 2,
                die_height_microns = 200,
                die_width_microns = 100,
                manual_placement_script = "@rules_hdl//benchmarks/basic:common/place.diagonal.tcl",
                sdc = "@rules_hdl//benchmarks/basic:common/sky130.sdc",
                skip_detailed_routing = False,
            ),
        ),
        target = ":rtl",
        top = "top_mul",
    )
    for cell_name, cell_target in for_each_sky130_cells("sc_hd")
]
