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

load("//gds_write:build_defs.bzl", "gds_write")
load("//place_and_route:build_defs.bzl", "place_and_route")
load("//static_timing:build_defs.bzl", "run_opensta")
load("//synthesis:build_defs.bzl", "synthesize_rtl")
load("//verilog:providers.bzl", "verilog_library")

synthesize_rtl(
    name = "verilog_adder_synthesized",
    top_module = "adder",
    deps = [
        ":verilog_adder",
    ],
)

verilog_library(
    name = "verilog_adder",
    srcs = [
        "verilog_adder.v",
    ],
)

##########################################################################
# Verilog counter
##########################################################################
verilog_library(
    name = "verilog_counter",
    srcs = [
        "counter.v",
    ],
)

# generic

synthesize_rtl(
    name = "verilog_counter-synth",
    top_module = "counter",
    deps = [
        ":verilog_counter",
    ],
)

run_opensta(
    name = "verilog_counter-synth_sta",
    synth_target = ":verilog_counter-synth",
)

place_and_route(
    name = "verilog_counter-place_and_route",
    clock_period = "10",
    core_padding_microns = 20,
    die_height_microns = 200,
    die_width_microns = 200,
    placement_density = "0.7",
    synthesized_rtl = ":verilog_counter-synth",
)

gds_write(
    name = "verilog_counter-gds",
    implemented_rtl = ":verilog_counter-place_and_route",
)

##########################################################################
# ASAP7 7.5 track rev 28
##########################################################################

# asap7-sc7p5t_rev28_rvt
# ------------------------------------------------------------------------

synthesize_rtl(
    name = "verilog_counter-asap7-sc7p5t_rev28_rvt-synth",
    standard_cells = "@org_theopenroadproject_asap7//:asap7-sc7p5t_rev28_rvt",
    target_clock_period_pico_seconds = 10000,
    top_module = "counter",
    deps = [
        ":verilog_counter",
    ],
)

run_opensta(
    name = "verilog_counter-asap7-sc7p5t_rev28_rvt-synth_sta",
    synth_target = ":verilog_counter-asap7-sc7p5t_rev28_rvt-synth",
)

place_and_route(
    name = "verilog_counter-asap7-sc7p5t_rev28_rvt-place_and_route",
    core_padding_microns = 1,
    die_height_microns = 20,
    die_width_microns = 20,
    placement_density = "0.65",
    sdc = "constraint.sdc",
    synthesized_rtl = ":verilog_counter-asap7-sc7p5t_rev28_rvt-synth",
)

gds_write(
    name = "verilog_counter-asap7-sc7p5t_rev28_rvt-gds",
    implemented_rtl = ":verilog_counter-asap7-sc7p5t_rev28_rvt-place_and_route",
)

# asap7-sc7p5t_rev28_lvt

synthesize_rtl(
    name = "verilog_counter-asap7-sc7p5t_rev28_lvt-synth",
    standard_cells = "@org_theopenroadproject_asap7//:asap7-sc7p5t_rev28_lvt",
    target_clock_period_pico_seconds = 10000,
    top_module = "counter",
    deps = [
        ":verilog_counter",
    ],
)

run_opensta(
    name = "verilog_counter-asap7-sc7p5t_rev28_lvt-synth_sta",
    synth_target = ":verilog_counter-asap7-sc7p5t_rev28_lvt-synth",
)

place_and_route(
    name = "verilog_counter-asap7-sc7p5t_rev28_lvt-place_and_route",
    core_padding_microns = 1,
    die_height_microns = 20,
    die_width_microns = 20,
    placement_density = "0.65",
    sdc = "constraint.sdc",
    synthesized_rtl = ":verilog_counter-asap7-sc7p5t_rev28_lvt-synth",
)

gds_write(
    name = "verilog_counter-asap7-sc7p5t_rev28_lvt-gds",
    implemented_rtl = ":verilog_counter-asap7-sc7p5t_rev28_lvt-place_and_route",
)

# asap7-sc7p5t_rev28_slvt

synthesize_rtl(
    name = "verilog_counter-asap7-sc7p5t_rev28_slvt-synth",
    standard_cells = "@org_theopenroadproject_asap7//:asap7-sc7p5t_rev28_slvt",
    target_clock_period_pico_seconds = 10000,
    top_module = "counter",
    deps = [
        ":verilog_counter",
    ],
)

run_opensta(
    name = "verilog_counter-asap7-sc7p5t_rev28_slvt-synth_sta",
    synth_target = ":verilog_counter-asap7-sc7p5t_rev28_slvt-synth",
)

place_and_route(
    name = "verilog_counter-asap7-sc7p5t_rev28_slvt-place_and_route",
    core_padding_microns = 1,
    die_height_microns = 20,
    die_width_microns = 20,
    placement_density = "0.65",
    sdc = "constraint.sdc",
    synthesized_rtl = ":verilog_counter-asap7-sc7p5t_rev28_slvt-synth",
)

gds_write(
    name = "verilog_counter-asap7-sc7p5t_rev28_slvt-gds",
    implemented_rtl = ":verilog_counter-asap7-sc7p5t_rev28_slvt-place_and_route",
)

##########################################################################
# ASAP7 7.5 track rev 27
##########################################################################

# asap7-sc7p5t_rev27_rvt
# ------------------------------------------------------------------------

synthesize_rtl(
    name = "verilog_counter-asap7-sc7p5t_rev27_rvt-synth",
    standard_cells = "@org_theopenroadproject_asap7//:asap7-sc7p5t_rev27_rvt",
    target_clock_period_pico_seconds = 10000,
    top_module = "counter",
    deps = [
        ":verilog_counter",
    ],
)

run_opensta(
    name = "verilog_counter-asap7-sc7p5t_rev27_rvt-synth_sta",
    synth_target = ":verilog_counter-asap7-sc7p5t_rev27_rvt-synth",
)

place_and_route(
    name = "verilog_counter-asap7-sc7p5t_rev27_rvt-place_and_route",
    core_padding_microns = 1,
    die_height_microns = 20,
    die_width_microns = 20,
    placement_density = "0.65",
    sdc = "constraint.sdc",
    synthesized_rtl = ":verilog_counter-asap7-sc7p5t_rev27_rvt-synth",
)

gds_write(
    name = "verilog_counter-asap7-sc7p5t_rev27_rvt-gds",
    implemented_rtl = ":verilog_counter-asap7-sc7p5t_rev27_rvt-place_and_route",
)

# asap7-sc7p5t_rev27_lvt

synthesize_rtl(
    name = "verilog_counter-asap7-sc7p5t_rev27_lvt-synth",
    standard_cells = "@org_theopenroadproject_asap7//:asap7-sc7p5t_rev27_lvt",
    target_clock_period_pico_seconds = 10000,
    top_module = "counter",
    deps = [
        ":verilog_counter",
    ],
)

run_opensta(
    name = "verilog_counter-asap7-sc7p5t_rev27_lvt-synth_sta",
    synth_target = ":verilog_counter-asap7-sc7p5t_rev27_lvt-synth",
)

place_and_route(
    name = "verilog_counter-asap7-sc7p5t_rev27_lvt-place_and_route",
    core_padding_microns = 1,
    die_height_microns = 20,
    die_width_microns = 20,
    placement_density = "0.65",
    sdc = "constraint.sdc",
    synthesized_rtl = ":verilog_counter-asap7-sc7p5t_rev27_lvt-synth",
)

gds_write(
    name = "verilog_counter-asap7-sc7p5t_rev27_lvt-gds",
    implemented_rtl = ":verilog_counter-asap7-sc7p5t_rev27_lvt-place_and_route",
)

# asap7-sc7p5t_rev27_slvt

synthesize_rtl(
    name = "verilog_counter-asap7-sc7p5t_rev27_slvt-synth",
    standard_cells = "@org_theopenroadproject_asap7//:asap7-sc7p5t_rev27_slvt",
    target_clock_period_pico_seconds = 10000,
    top_module = "counter",
    deps = [
        ":verilog_counter",
    ],
)

run_opensta(
    name = "verilog_counter-asap7-sc7p5t_rev27_slvt-synth_sta",
    synth_target = ":verilog_counter-asap7-sc7p5t_rev27_slvt-synth",
)

place_and_route(
    name = "verilog_counter-asap7-sc7p5t_rev27_slvt-place_and_route",
    core_padding_microns = 1,
    die_height_microns = 20,
    die_width_microns = 20,
    placement_density = "0.65",
    sdc = "constraint.sdc",
    synthesized_rtl = ":verilog_counter-asap7-sc7p5t_rev27_slvt-synth",
)

gds_write(
    name = "verilog_counter-asap7-sc7p5t_rev27_slvt-gds",
    implemented_rtl = ":verilog_counter-asap7-sc7p5t_rev27_slvt-place_and_route",
)

##########################################################################
# ASAP7 7.5 track rev 27 4x scaled version
##########################################################################

# asap7-sc7p5t_rev27_rvt_4x
# ------------------------------------------------------------------------

synthesize_rtl(
    name = "verilog_counter-asap7-sc7p5t_rev27_rvt_4x-synth",
    standard_cells = "@org_theopenroadproject_asap7//:asap7-sc7p5t_rev27_rvt_4x",
    target_clock_period_pico_seconds = 10000,
    top_module = "counter",
    deps = [
        ":verilog_counter",
    ],
)

run_opensta(
    name = "verilog_counter-asap7-sc7p5t_rev27_rvt_4x-synth_sta",
    synth_target = ":verilog_counter-asap7-sc7p5t_rev27_rvt_4x-synth",
)

place_and_route(
    name = "verilog_counter-asap7-sc7p5t_rev27_rvt_4x-place_and_route",
    core_padding_microns = 1,
    die_height_microns = 200,
    die_width_microns = 200,
    placement_density = "0.65",
    sdc = "constraint.sdc",
    synthesized_rtl = ":verilog_counter-asap7-sc7p5t_rev27_rvt_4x-synth",
)

##########################################################################
# ASAP7 6 track rev 26
##########################################################################

# asap7-sc6t_rev26_rvt
# ------------------------------------------------------------------------

synthesize_rtl(
    name = "verilog_counter-asap7-sc6t_rev26_rvt-synth",
    standard_cells = "@org_theopenroadproject_asap7//:asap7-sc6t_rev26_rvt",
    target_clock_period_pico_seconds = 10000,
    top_module = "counter",
    deps = [
        ":verilog_counter",
    ],
)

run_opensta(
    name = "verilog_counter-asap7-sc6t_rev26_rvt-synth_sta",
    synth_target = ":verilog_counter-asap7-sc6t_rev26_rvt-synth",
)

place_and_route(
    name = "verilog_counter-asap7-sc6t_rev26_rvt-place_and_route",
    core_padding_microns = 1,
    die_height_microns = 20,
    die_width_microns = 20,
    placement_density = "0.65",
    sdc = "constraint.sdc",
    synthesized_rtl = ":verilog_counter-asap7-sc6t_rev26_rvt-synth",
)

gds_write(
    name = "verilog_counter-asap7-sc6t_rev26_rvt-gds",
    implemented_rtl = ":verilog_counter-asap7-sc6t_rev26_rvt-place_and_route",
)

# asap7-sc6t_rev26_lvt

synthesize_rtl(
    name = "verilog_counter-asap7-sc6t_rev26_lvt-synth",
    standard_cells = "@org_theopenroadproject_asap7//:asap7-sc6t_rev26_lvt",
    target_clock_period_pico_seconds = 10000,
    top_module = "counter",
    deps = [
        ":verilog_counter",
    ],
)

run_opensta(
    name = "verilog_counter-asap7-sc6t_rev26_lvt-synth_sta",
    synth_target = ":verilog_counter-asap7-sc6t_rev26_lvt-synth",
)

place_and_route(
    name = "verilog_counter-asap7-sc6t_rev26_lvt-place_and_route",
    core_padding_microns = 1,
    die_height_microns = 20,
    die_width_microns = 20,
    placement_density = "0.65",
    sdc = "constraint.sdc",
    synthesized_rtl = ":verilog_counter-asap7-sc6t_rev26_lvt-synth",
)

gds_write(
    name = "verilog_counter-asap7-sc6t_rev26_lvt-gds",
    implemented_rtl = ":verilog_counter-asap7-sc6t_rev26_lvt-place_and_route",
)

# asap7-sc6t_rev26_slvt

synthesize_rtl(
    name = "verilog_counter-asap7-sc6t_rev26_slvt-synth",
    standard_cells = "@org_theopenroadproject_asap7//:asap7-sc6t_rev26_slvt",
    target_clock_period_pico_seconds = 10000,
    top_module = "counter",
    deps = [
        ":verilog_counter",
    ],
)

run_opensta(
    name = "verilog_counter-asap7-sc6t_rev26_slvt-synth_sta",
    synth_target = ":verilog_counter-asap7-sc6t_rev26_slvt-synth",
)

place_and_route(
    name = "verilog_counter-asap7-sc6t_rev26_slvt-place_and_route",
    core_padding_microns = 1,
    die_height_microns = 20,
    die_width_microns = 20,
    placement_density = "0.65",
    sdc = "constraint.sdc",
    synthesized_rtl = ":verilog_counter-asap7-sc6t_rev26_slvt-synth",
)
