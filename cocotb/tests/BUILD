# Copyright 2023 Antmicro
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

load("@rules_hdl_pip_deps//:requirements.bzl", "requirement")
load("//cocotb:cocotb.bzl", "cocotb_test")
load("//verilog:providers.bzl", "verilog_library")

verilog_library(
    name = "counter",
    srcs = ["counter.v"],
)

cocotb_test(
    name = "cocotb_counter",
    defines = {"INIT_CNT": "100"},
    hdl_toplevel = "counter",
    hdl_toplevel_lang = "verilog",
    parameters = {"COUNTER_WIDTH": "8"},
    seed = "1234567890",
    test_module = ["cocotb_counter.py"],
    verilog_sources = [
        ":counter",
        "wavedump.v",
    ],
    deps = [requirement("cocotb")],
)
