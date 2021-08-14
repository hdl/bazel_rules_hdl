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


load("//synthesis:build_defs.bzl", "synthesize_rtl")
load("//verilog:providers.bzl", "verilog_library")

synthesize_rtl(
  name = "verilog_adder_synthesized",
  deps = [
    ":verilog_adder",
  ],
  top_module = "adder",
)

verilog_library(
  name = "verilog_adder",
  srcs = [
    "verilog_adder.v",
  ]
)
