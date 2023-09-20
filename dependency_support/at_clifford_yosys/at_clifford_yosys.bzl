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
            "https://github.com/YosysHQ/yosys/archive/35a05686c4e9987441ac298f5d631f1785e272fd.zip",
        ],
        sha256 = "766da0b9f7e0aeb61ea6ab3d504e2a5328fc21d60f936d0e74f0af7c97120ba4",
        strip_prefix = "yosys-35a05686c4e9987441ac298f5d631f1785e272fd",
        build_file = Label("@rules_hdl//dependency_support:at_clifford_yosys/bundled.BUILD.bazel"),
        patches = [
            Label("@rules_hdl//dependency_support:at_clifford_yosys/yosys.patch"),
        ],
    )
