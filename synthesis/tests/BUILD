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

load("//synthesis:build_defs.bzl", "synthesize_rtl")
load("//static_timing:build_defs.bzl", "run_opensta")
load("//place_and_route:build_defs.bzl", "place_and_route")
load("//gds_write:build_defs.bzl", "gds_write")
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

place_and_route(
    name = "counter_place_and_route",
    clock_period = "10",
    core_padding_microns = 20,
    die_height_microns = 200,
    die_width_microns = 200,
    placement_density = "0.7",
    synthesized_rtl = ":verilog_counter_synth",
)

gds_write(
    name = "counter_asic",
    implemented_rtl = ":counter_place_and_route",
)

run_opensta(
    name = "verilog_counter_synth_sta",
    synth_target = ":verilog_counter_synth",
)

synthesize_rtl(
    name = "verilog_counter_synth",
    top_module = "counter",
    deps = [
        ":verilog_counter",
    ],
)

run_opensta(
    name = "verilog_counter_asap7_synth_sta",
    synth_target = ":verilog_counter_asap7_synth",
)

synthesize_rtl(
    name = "verilog_counter_asap7_synth",
    standard_cells = "@org_theopenroadproject_asap7//:asap7_rvt_1x",
    top_module = "counter",
    deps = [
        ":verilog_counter",
    ],
)

verilog_library(
    name = "verilog_counter",
    srcs = [
        "counter.v",
    ],
)
