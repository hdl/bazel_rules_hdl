# Copyright 2021-2022 Google LLC
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

load("@bazel_skylib//rules:build_test.bzl", "build_test")
load("@rules_hdl//dependency_support/com_google_skywater_pdk:cells_info.bzl", "for_each_sky130_cells")
load("@rules_hdl//dependency_support/org_theopenroadproject_asap7_pdk_r1p7:cells_info.bzl", "for_each_asap7_cells")
load("//flows:basic_asic.bzl", "basic_asic_flow")
load("//gds_write:build_defs.bzl", "gds_write")
load("//place_and_route:build_defs.bzl", "place_and_route")
load("//static_timing:build_defs.bzl", "run_opensta")
load("//synthesis:build_defs.bzl", "synthesize_rtl")
load("//verilog:providers.bzl", "verilog_library")

package(
    default_applicable_licenses = ["//:package_license"],
    default_visibility = ["//visibility:private"],
)

##########################################################################
# Basic tests of individual steps in the ASIC flow.
##########################################################################
BASIC_TESTS = [
    "verilog_adder",
    "verilog_counter",
]

# Basic `verilog_library` test
[
    verilog_library(
        name = test_name,
        srcs = [
            test_name + ".v",
        ],
    )
    for test_name in BASIC_TESTS
]

# Basic `synthesize_rtl` test
[
    synthesize_rtl(
        name = test_name + "-synth",
        top_module = test_name,
        deps = [
            ":" + test_name,
        ],
    )
    for test_name in BASIC_TESTS
]

# Basic `run_opensta` test (on output of `synthesize_rtl`)
[
    run_opensta(
        name = test_name + "-synth_sta",
        synth_target = ":" + test_name + "-synth",
    )
    for test_name in BASIC_TESTS
]

# Basic `place_and_route` test (on output of `synthesize_rtl`)
place_and_route(
    name = "verilog_adder-place_and_route",
    clock_period = None,  # Combinational only design
    core_padding_microns = 20,
    die_height_microns = 200,
    die_width_microns = 200,
    placement_density = "0.7",
    synthesized_rtl = ":verilog_adder-synth",
)

place_and_route(
    name = "verilog_counter-place_and_route",
    clock_period = "10",
    core_padding_microns = 20,
    die_height_microns = 200,
    die_width_microns = 200,
    placement_density = "0.7",
    sdc = "constraint.sdc",
    synthesized_rtl = ":verilog_counter-synth",
)

# Basic `gds_write` test (on output of `place_and_route`)
[
    gds_write(
        name = test_name + "-gds",
        implemented_rtl = ":" + test_name + "-place_and_route",
    )
    for test_name in BASIC_TESTS
]

# Make sure that all the basic tests above actually build
[
    build_test(
        name = "build-" + test_name,
        targets = [
            ":" + test_name,
            ":" + test_name + "-synth",
            ":" + test_name + "-synth_sta",
            ":" + test_name + "-place_and_route",
            ":" + test_name + "-gds",
        ],
    )
    for test_name in BASIC_TESTS
]

##########################################################################
# Basic tests which run for each standard cell library.
##########################################################################

EXTRA_ARGS = {
    "verilog_counter": {
        "place_and_route": dict(
            sdc = "constraint.sdc",
        ),
    },
    "verilog_adder": {
        "place_and_route": dict(
            clock_period = None,  # Combinational only design
        ),
    },
}

# SkyWater 130nm PDK
# ------------------------------------------------------------------------
# Skywater 130nm PDK - High Density standard cells
[
    [
        basic_asic_flow(
            name = test_name + "-" + cell_name,
            size = 200,
            cells = cell_target,
            extra_args = EXTRA_ARGS[test_name],
            target = ":" + test_name,
            top = test_name,
        )
        for cell_name, cell_target in for_each_sky130_cells("sc_hd")
    ]
    for test_name in BASIC_TESTS
]

# FIXME: Add other ('sc_hs', 'sc_ms', 'sc_ls', ...)
# Skywater 130nm PDK - XXXXX standard cells

# ASAP7 predictive 7nm PDK
# ------------------------------------------------------------------------

# FIXME: Add ASAP7 7nm PDK - 6 track rev 26 standard cells

# ASAP 7nm PDK - 7.5 track rev 27 standard cells
[
    [
        basic_asic_flow(
            name = test_name + "-" + cell_name,
            cells = cell_target,
            extra_args = EXTRA_ARGS[test_name],
            gds = False,  # No GDS for the rev 27 cells
            target = ":" + test_name,
            top = test_name,
        )
        for cell_name, cell_target in for_each_asap7_cells("sc7p5t_rev27")
    ]
    for test_name in BASIC_TESTS
]

# ASAP 7nm PDK - 7.5 track rev 28 standard cells
[
    [
        basic_asic_flow(
            name = test_name + "-" + cell_name,
            size = 20,
            cells = cell_target,
            extra_args = EXTRA_ARGS[test_name],
            target = ":" + test_name,
            top = test_name,
        )
        for cell_name, cell_target in for_each_asap7_cells("sc7p5t_rev28")
    ]
    for test_name in BASIC_TESTS
]

# "Special" ASAP7 7.5 track rev 27 4x scaled version
[
    basic_asic_flow(
        name = test_name + "-asap7-sc7p5t_rev27_rvt_4x",
        size = 2000,
        cells = "@org_theopenroadproject_asap7sc7p5t_27//:asap7-sc7p5t_rev27_rvt_4x-ccs_ss",
        extra_args = EXTRA_ARGS[test_name],
        gds = False,  # No GDS for the 4x cells
        target = ":" + test_name,
        top = test_name,
    )
    for test_name in BASIC_TESTS
]
