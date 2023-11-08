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
load("//flows:asap7.bzl", "asap7_targets")
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

build_test(
    name = "build-verilog_counter",
    targets = [
        ":verilog_counter",
        ":verilog_counter-synth",
        ":verilog_counter-synth_sta",
        ":verilog_counter-place_and_route",
        ":verilog_counter-gds",
    ],
)

# ASAP7 7.5 track rev 28
asap7_targets(
    name = "verilog_counter-asap7-sc7p5t_rev28_rvt",
    rev = 28,
    target = "verilog_counter",
    tracks = "7p5t",
    vt = "rvt",
)

asap7_targets(
    name = "verilog_counter-asap7-sc7p5t_rev28_lvt",
    rev = 28,
    target = "verilog_counter",
    tracks = "7p5t",
    vt = "lvt",
)

asap7_targets(
    name = "verilog_counter-asap7-sc7p5t_rev28_slvt",
    rev = 28,
    target = "verilog_counter",
    tracks = "7p5t",
    vt = "slvt",
)

# ASAP7 7.5 track rev 27
asap7_targets(
    name = "verilog_counter-asap7-sc7p5t_rev27_rvt",
    rev = 27,
    target = "verilog_counter",
    tracks = "7p5t",
    vt = "rvt",
)

asap7_targets(
    name = "verilog_counter-asap7-sc7p5t_rev27_lvt",
    has_gds = False,  # No GDS for rev27 LVT
    rev = 27,
    target = "verilog_counter",
    tracks = "7p5t",
    vt = "lvt",
)

asap7_targets(
    name = "verilog_counter-asap7-sc7p5t_rev27_slvt",
    has_gds = False,  # No GDS for rev27 LVT
    rev = 27,
    target = "verilog_counter",
    tracks = "7p5t",
    vt = "slvt",
)

# ASAP7 7.5 track rev 27 4x scaled version
# FIXME: Enable the 4x scaled 7.5 track config.
#asap7_targets(
#    name = "verilog_counter-asap7-sc7p5t_rev27_rvt_4x",
#    size = 2000,
#    has_gds = False,  # No GDS for the 4x cells
#    rev = 27,
#    target = "verilog_counter",
#    tracks = "7p5t",
#    vt = "rvt_4x",
#)

# ASAP7 6 track rev 26
# FIXME: Enable the 6 track config.
#asap7_targets(
#    name = "verilog_counter-asap7-6t_rev26_rvt",
#    rev = 26,
#    target = "verilog_counter",
#    tracks = "6t",
#    vt = "rvt",
#)
#
#asap7_targets(
#    name = "verilog_counter-asap7-6t_rev26_lvt",
#    rev = 26,
#    target = "verilog_counter",
#    tracks = "6t",
#    vt = "lvt",
#)
#
#asap7_targets(
#    name = "verilog_counter-asap7-6t_rev26_slvt",
#    rev = 26,
#    target = "verilog_counter",
#    tracks = "6t",
#    vt = "slvt",
#)
