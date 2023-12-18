# Copyright 2020 Google LLC
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

"""Loads the Yosys framework for Verilog synthesis."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def at_clifford_yosys():
    maybe(
        http_archive,
        name = "at_clifford_yosys",
        urls = [
            "https://github.com/YosysHQ/yosys/archive/8f07a0d8404f63349d8d3111217b73c9eafbd667.zip",
        ],
        sha256 = "46a9a4d969770fa20a2fd12c8e83307a597126609645c9655c370c0c365da344",
        strip_prefix = "yosys-8f07a0d8404f63349d8d3111217b73c9eafbd667",
        build_file = Label("@rules_hdl//dependency_support:at_clifford_yosys/bundled.BUILD.bazel"),
        patches = [
            Label("@rules_hdl//dependency_support:at_clifford_yosys/yosys.patch"),
        ],
    )
