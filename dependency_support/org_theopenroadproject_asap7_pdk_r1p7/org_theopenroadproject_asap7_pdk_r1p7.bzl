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

def org_theopenroadproject_asap7_pdk_r1p7():
    maybe(
        http_archive,
        name = "org_theopenroadproject_asap7_pdk_r1p7",
        urls = [
            "https://github.com/The-OpenROAD-Project/asap7_pdk_r1p7/archive/1ff7649bbf423207f6f70293dc1cf630cd477365.tar.gz",
        ],
        strip_prefix = "asap7_pdk_r1p7-1ff7649bbf423207f6f70293dc1cf630cd477365",
        sha256 = "b5847f93e55debb49d03ec581e22eb301109ff90c9ad19d35ae1223c70250391",
        build_file = Label("@rules_hdl//dependency_support/org_theopenroadproject_asap7_pdk_r1p7:bundled.BUILD.bazel"),
    )
