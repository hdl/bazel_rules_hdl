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

"""Loads the Netgen general-purpose netlist management system."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def com_opencircuitdesign_netgen():
    maybe(
        http_archive,
        name = "com_opencircuitdesign_netgen",
        urls = [
            "https://github.com/RTimothyEdwards/netgen/archive/50b0e9cb6572cfa2f96d49556d13e4c445986e0f.zip",  # 2020-08-28
        ],
        strip_prefix = "netgen-50b0e9cb6572cfa2f96d49556d13e4c445986e0f",
        sha256 = "2472de7d55f6266be3389e150571e48952a7613f6cb284a59eb46adfde770061",
        build_file = Label("@rules_hdl//dependency_support/com_opencircuitdesign_netgen:bundled.BUILD.bazel"),
    )
