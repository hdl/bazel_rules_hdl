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

"""Loads the Magic VLSI layout tool."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def com_opencircuitdesign_magic():
    maybe(
        http_archive,
        name = "com_opencircuitdesign_magic",
        urls = [
            "https://github.com/RTimothyEdwards/magic/archive/0df5f6d0731024da457eeb42cb88725d93572920.zip",  # 2020-08-24
        ],
        strip_prefix = "magic-0df5f6d0731024da457eeb42cb88725d93572920",
        sha256 = "1bc9966e5118c3d312e2dfebadb6f01ca343fbf1f0847e1434300972a4ca91f9",
        build_file = Label("@rules_hdl//dependency_support/com_opencircuitdesign_magic:bundled.BUILD.bazel"),
        patches = [
            Label("@rules_hdl//dependency_support/com_opencircuitdesign_magic:magic_wrapper.patch"),
            Label("@rules_hdl//dependency_support/com_opencircuitdesign_magic:use_bash.patch"),
        ],
    )
