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

def org_theopenroadproject_asap7sc7p5t_28():
    maybe(
        http_archive,
        name = "org_theopenroadproject_asap7sc7p5t_28",
        urls = [
            "https://github.com/The-OpenROAD-Project/asap7sc7p5t_28/archive/d88477438935a5a388bd6294f682dc405c93c5d2.tar.gz",
        ],
        strip_prefix = "asap7sc7p5t_28-d88477438935a5a388bd6294f682dc405c93c5d2",
        sha256 = "7f028a41425b8d736958cae994b3c1722d4bef2c0d28f6bf507b9ac8138ecc41",
        build_file = Label("@rules_hdl//dependency_support/org_theopenroadproject_asap7sc7p5t_28:bundled.BUILD.bazel"),
    )
