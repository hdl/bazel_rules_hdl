#!/usr/bin/env python3
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


import pathlib
import subprocess

LICENSE = []
with open(__file__) as f:
    while True:
        l = next(f)
        if not l.startswith("#!"):
            break
    while l.startswith('#'):
        LICENSE.append(l[1:])
        l = next(f)

PDKS = {
    "asap7": {
        "libraries": ["sc7p5t_rev28"],
        "pnr": {
            "core_padding_microns": 2,
            "die_height_microns": 400,
            "die_width_microns": 400,
            "skip_detailed_routing": False,
        }
    },
    "sky130": {
        "libraries": ['sc_hd'],
        "pnr": {
            "core_padding_microns": 2,
            "die_height_microns": 200,
            "die_width_microns": 100,
            "skip_detailed_routing": False,
        }
    },
}

FILE_DIR = pathlib.Path(__file__).parent

MODULES = [
    "and",
    "xand",
    "add",
    "mul",
]

PLACEMENT = [
    "straight",
    "loopback",
    "diagonal",
]

for MOD_NAME in MODULES:
    with open(FILE_DIR / MOD_NAME / f"top_{MOD_NAME}.sv", "w", encoding="utf-8") as top_file:
        top_file.write(''.join('//'+l for l in LICENSE))
        top_file.write(f"""
module top_{MOD_NAME} (
  input wire clk,
  input wire [7:0] a,
  input wire [7:0] b,
  output reg [7:0] x
);

  reg [7:0] a_;
  reg [7:0] b_;
  wire [7:0] i_;

  always_ff @ (posedge clk)
    a_ <= a;

  always_ff @ (posedge clk)
    b_ <= b;

  always_ff @ (posedge clk)
    x <= i_;

  mod_{MOD_NAME} mod (.a(a_), .b(b_), .x(i_));

endmodule
""")

    build_file_name = FILE_DIR / MOD_NAME / f"BUILD"
    print("Writing ", build_file_name, "...")
    with open(build_file_name, "w", encoding="utf-8") as build_file:
        build_file.write(''.join('#'+l for l in LICENSE))
        build_file.write(f'''
""" Benchmark for {MOD_NAME} """

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
        "top_{MOD_NAME}.sv",
        "mod_{MOD_NAME}.sv",
    ],
)

build_test(
    name = "rtl_build_test",
    targets = [
        ":rtl",
    ],
)
''')

        for PDK_NAME, PDK_CONFIG in PDKS.items():
            for LIB in PDK_CONFIG['libraries']:
                build_file.write(f"""
# Run for {MOD_NAME} on {PDK_NAME} with {LIB}
[
    basic_asic_flow(
        name = 'basic-' + cell_name,
        cells = cell_target,
        extra_args = dict(
            place_and_route = dict(
                core_padding_microns = {PDK_CONFIG['pnr']['core_padding_microns']},
                die_height_microns = {PDK_CONFIG['pnr']['die_height_microns']},
                die_width_microns = {PDK_CONFIG['pnr']['die_width_microns']},
                sdc = "@rules_hdl//benchmarks/basic:common/{PDK_NAME}.sdc",
                skip_detailed_routing = {PDK_CONFIG['pnr']['skip_detailed_routing']},
                exec_properties = dict(
                    mem = '16g',
                ),
            ),
        ),
        target = ":rtl",
        top = "top_{MOD_NAME}",
    )
    for cell_name, cell_target in for_each_{PDK_NAME}_cells("{LIB}")
]
""")

                for PLACE in PLACEMENT:
                    build_file.write(f"""
# Run for {MOD_NAME} on {PDK_NAME} with {LIB} using {PLACE} placement.
[
    basic_asic_flow(
        name = "{PLACE}-" + cell_name,
        cells = cell_target,
        extra_args = dict(
            place_and_route = dict(
                sdc = "@rules_hdl//benchmarks/basic:common/{PDK_NAME}.sdc",
                manual_placement_script = "@rules_hdl//benchmarks/basic:common/place.{PLACE}.tcl",
                skip_detailed_routing = {PDK_CONFIG['pnr']['skip_detailed_routing']},
                core_padding_microns = {PDK_CONFIG['pnr']['core_padding_microns']},
                die_height_microns = {PDK_CONFIG['pnr']['die_height_microns']},
                die_width_microns = {PDK_CONFIG['pnr']['die_width_microns']},
                exec_properties = dict(
                    mem = '16g',
                ),
            ),
        ),
        target = ":rtl",
        top = "top_{MOD_NAME}",
    )
    for cell_name, cell_target in for_each_{PDK_NAME}_cells("{LIB}")
]
""")

    subprocess.check_call(f"buildifier {build_file_name}", shell=True)
