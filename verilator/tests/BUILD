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

load("@rules_cc//cc:defs.bzl", "cc_test")
load("//verilator:defs.bzl", "verilator_cc_binary", "verilator_cc_library", "verilator_lint", "verilator_run")
load("//verilog:defs.bzl", "verilog_library")

package(
    default_applicable_licenses = ["//:package_license"],
    default_visibility = ["//visibility:private"],
)

verilog_library(
    name = "adder",
    srcs = [
        "adder.sv",
    ],
)

verilator_cc_library(
    name = "adder_verilator",
    module = ":adder",
    module_top = "adder",
)

cc_test(
    name = "adder_test",
    srcs = ["adder_test.cc"],
    deps = [
        ":adder_verilator",
        "@com_google_googletest//:gtest",
        "@com_google_googletest//:gtest_main",
    ],
)

verilog_library(
    name = "load_and_count",
    srcs = [
        "load_and_count.sv",
    ],
    data = [
        "test_data.dat",
    ],
)

verilator_cc_library(
    name = "load_and_count_verilator",
    module = ":load_and_count",
    module_top = "load_and_count",
)

cc_test(
    name = "load_and_count_test",
    srcs = [
        "load_and_count_test.cc",
    ],
    deps = [
        ":load_and_count_verilator",
        "@com_google_googletest//:gtest",
        "@com_google_googletest//:gtest_main",
    ],
)

verilog_library(
    name = "nested_module_0",
    srcs = [
        "nested_module_0.sv",
    ],
)

verilog_library(
    name = "nested_module_1",
    srcs = [
        "nested_module_1.sv",
    ],
    deps = [
        ":nested_module_0",
    ],
)

verilog_library(
    name = "nested_module_2",
    srcs = [
        "nested_module_2.sv",
    ],
    deps = [
        ":nested_module_1",
    ],
)

verilator_cc_library(
    name = "nested_module_2_verilator",
    module = ":nested_module_2",
    module_top = "nested_module_2",
    vopts = [
        "--Wno-fatal",
    ],
)

cc_test(
    name = "nested_module_test",
    srcs = [
        "nested_module_test.cc",
    ],
    deps = [
        ":nested_module_2_verilator",
        "@com_google_googletest//:gtest",
        "@com_google_googletest//:gtest_main",
    ],
)

verilog_library(
    name = "tb",
    srcs = [
        "tb.sv",
    ],
    deps = [
        ":adder",
    ],
)

verilator_cc_binary(
    name = "tb_binary",
    coverage = "all",
    module = ":tb",
    module_top = "tb",
    trace = True,
    vopts = [
        "--timing",
    ],
)

verilator_run(
    name = "tb_run",
    binary = ":tb_binary",
)

verilog_library(
    name = "load_and_count_tb",
    srcs = [
        "load_and_count_tb.sv",
    ],
    deps = [
        ":load_and_count",
    ],
)

verilator_cc_binary(
    name = "load_and_count_tb_binary",
    coverage = "all",
    module = ":load_and_count_tb",
    module_top = "tb",
    trace = True,
    vopts = [
        "--timing",
    ],
)

verilator_run(
    name = "load_and_count_tb_run",
    binary = ":load_and_count_tb_binary",
)

verilator_lint(
    name = "nested_module_2_verilator_lint",
    module = ":nested_module_2",
    module_top = "nested_module_2",
    vopts = [
        "-Wall",
        "-Wno-fatal",
    ],
)

verilator_lint(
    name = "nested_module_2_verilator_lint_waived",
    config_files = [
        "nested_module_2.vlt",
    ],
    module = ":nested_module_2",
    module_top = "nested_module_2",
    vopts = [
        "-Wall",
    ],
)
