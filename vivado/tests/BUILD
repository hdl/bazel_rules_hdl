# Copyright 2023 bazel_rules_hdl Authors
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

load("@rules_python//python:defs.bzl", "py_binary")
load("//verilator:defs.bzl", "verilator_cc_library")
load("//verilog:providers.bzl", "verilog_library")
load(
    "//vivado:defs.bzl",
    "vivado_create_ip",
    "vivado_create_project",
    "vivado_flow",
    "xsim_test",
)

package(
    default_applicable_licenses = ["//:package_license"],
    default_visibility = ["//visibility:private"],
)

verilog_library(
    name = "johnson_counter",
    srcs = [
        "johnson_counter.sv",
        "test.mem",
    ],
)

verilator_cc_library(
    name = "johnson_counter_verilator",
    module = ":johnson_counter",
    module_top = "johnson_counter",
)

cc_test(
    name = "johnson_counter_test",
    srcs = ["johnson_counter_test.cc"],
    deps = [
        ":johnson_counter_verilator",
        "@com_google_googletest//:gtest_main",
    ],
)

verilog_library(
    name = "xsim_smoke_tb",
    srcs = ["xsim_smoke_tb.sv"],
)

xsim_test(
    name = "xsim_smoke_test",
    module = ":xsim_smoke_tb",
    module_top = "xsim_smoke_tb",
    part_number = "xczu28dr-ffvg1517-2-e",
    tags = ["manual"],
    with_waveform = True,
    xilinx_env = ":xilinx_env.sh",
)

verilog_library(
    name = "johnson_counter_top",
    srcs = [
        "io_constraints.xdc",
        "johnson_counter_top.sv",
        "zcu111_gpio.tcl",
    ],
    deps = [
        ":johnson_counter",
    ],
)

vivado_flow(
    name = "johnson_counter_vivado",
    module = ":johnson_counter_top",
    module_top = "johnson_counter_top",
    part_number = "xczu28dr-ffvg1517-2-e",
    tags = ["manual"],
    xilinx_env = ":xilinx_env.sh",
)

py_binary(
    name = "gen_values",
    srcs = ["gen_values.py"],
)

genrule(
    name = "test_mem",
    outs = ["test.mem"],
    cmd = "$(location :gen_values) > $(OUTS)",
    tools = [":gen_values"],
)

verilog_library(
    name = "weights_replay",
    srcs = [
        "test.mem",
        "weights_replay.sv",
    ],
)

verilator_cc_library(
    name = "weights_replay_verilator",
    module = ":weights_replay",
    module_top = "weights_replay",
    vopts = ["-D__VERILATOR__"],
)

cc_test(
    name = "weights_replay_test",
    srcs = ["weights_replay_test.cc"],
    data = [
        "test.mem",
    ],
    deps = [
        ":weights_replay_verilator",
        "@com_google_googletest//:gtest_main",
    ],
)

verilog_library(
    name = "weights_replay_top",
    srcs = [
        "weights_replay_top.sv",
        "zcu111_weights.tcl",
    ],
)

vivado_create_ip(
    name = "weights_replay_ip",
    encrypt = True,
    ip_library = "test",
    ip_vendor = "test_vendor",
    ip_version = "0.1",
    module = ":weights_replay",
    module_top = "weights_replay",
    part_number = "xczu28dr-ffvg1517-2-e",
    tags = ["manual"],
    xilinx_env = ":xilinx_env.sh",
)

vivado_flow(
    name = "weights_replay_vivado",
    ip_blocks = [
        ":weights_replay_ip",
    ],
    module = ":weights_replay_top",
    module_top = "weights_replay_top",
    part_number = "xczu28dr-ffvg1517-2-e",
    tags = ["manual"],
    xilinx_env = ":xilinx_env.sh",
)

vivado_create_project(
    name = "weights_replay_project",
    ip_blocks = [
        ":weights_replay_ip",
    ],
    module = ":weights_replay_top",
    module_top = "weights_replay_top",
    part_number = "xczu28dr-ffvg1517-2-e",
    tags = ["manual"],
    xilinx_env = ":xilinx_env.sh",
)

verilog_library(
    name = "weights_ram",
    srcs = [
        "weights_ram.sv",
    ],
)

vivado_create_ip(
    name = "weights_ram_ip",
    encrypt = False,
    ip_library = "test",
    ip_vendor = "test_vendor",
    ip_version = "0.1",
    module = ":weights_ram",
    module_top = "weights_ram",
    part_number = "xczu28dr-ffvg1517-2-e",
    tags = ["manual"],
    xilinx_env = ":xilinx_env.sh",
)

verilog_library(
    name = "weights_replay_and_save_bd",
    srcs = [
        "weights_replay_and_save_bd.tcl",
    ],
)

vivado_create_ip(
    name = "weights_replay_and_save_ip",
    ip_blocks = [
        ":weights_replay_ip",
        ":weights_ram_ip",
    ],
    ip_library = "test",
    ip_vendor = "test_vendor",
    ip_version = "0.1",
    module = ":weights_replay_and_save_bd",
    module_top = "weights_replay_and_save",
    part_number = "xczu28dr-ffvg1517-2-e",
    tags = ["manual"],
    xilinx_env = ":xilinx_env.sh",
)

verilog_library(
    name = "weights_replay_and_save_tb",
    srcs = [
        "weights_replay_and_save_tb.sv",
    ],
)

xsim_test(
    name = "weights_replay_and_save_xsim",
    ip_blocks = [
        ":weights_replay_and_save_ip",
    ],
    module = ":weights_replay_and_save_tb",
    module_top = "weights_replay_and_save_tb",
    part_number = "xczu28dr-ffvg1517-2-e",
    tags = ["manual"],
    xilinx_env = ":xilinx_env.sh",
)

verilog_library(
    name = "weights_replay_and_save_wrapper",
    srcs = [
        "weights_replay_and_save_wrapper.sv",
    ],
)

vivado_create_project(
    name = "weights_replay_and_save_project",
    ip_blocks = [
        ":weights_replay_and_save_ip",
    ],
    module = ":weights_replay_and_save_wrapper",
    module_top = "weights_replay_and_save_wrapper",
    part_number = "xczu28dr-ffvg1517-2-e",
    tags = ["manual"],
    xilinx_env = ":xilinx_env.sh",
)
