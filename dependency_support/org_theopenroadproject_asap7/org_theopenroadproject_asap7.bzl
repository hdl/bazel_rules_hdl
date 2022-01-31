# Copyright 2022 Google LLC
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

"""Registers Bazel workspaces for the Boost C++ libraries."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def org_theopenroadproject_asap7():
    maybe(
        http_archive,
        name = "org_theopenroadproject_asap7",
        urls = [
            "https://github.com/The-OpenROAD-Project/asap7/archive/157c92cfd2567a98c5f794fb10c2dd0713516374.tar.gz",
        ],
        strip_prefix = "asap7-157c92cfd2567a98c5f794fb10c2dd0713516374",
        sha256 = "bfa76681ee0f1b109cb73415728cf3d7508ce0be88ac491962e8a0016033a683",
        build_file = Label("@rules_hdl//dependency_support/org_theopenroadproject_asap7:bundled.BUILD.bazel"),
    )
