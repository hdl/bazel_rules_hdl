# Copyright 2020 The XLS Authors
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

"""Loads the ABC system for sequential synthesis and verification, used by yosys."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def net_zlib():
    maybe(
        http_archive,
        name = "net_zlib",
        sha256 = "72af66d44fcc14c22013b46b814d5d2514673dda3d115e64b690c1ad636e7b17",
        strip_prefix = "zlib-1.3.1",
        urls = [
            "https://github.com/madler/zlib/archive/v1.3.1.zip",
        ],
        build_file = "@rules_hdl//dependency_support/net_zlib:bundled.BUILD.bazel",
    )
