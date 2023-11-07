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
            "https://github.com/The-OpenROAD-Project/asap7/archive/cd13de4e603913291ec6b8401ab63ec481178a5a.tar.gz",
        ],
        strip_prefix = "asap7-cd13de4e603913291ec6b8401ab63ec481178a5a",
        sha256 = "1820b732362852ec9658695c7509dd81eda571bb6b64def48ff92e2fab78fbe8",
        build_file = Label("@rules_hdl//dependency_support/org_theopenroadproject_asap7:bundled.BUILD.bazel"),
    )
