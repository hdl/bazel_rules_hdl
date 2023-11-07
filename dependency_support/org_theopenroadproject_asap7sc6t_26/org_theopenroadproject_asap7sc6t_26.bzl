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

def org_theopenroadproject_asap7sc6t_26():
    maybe(
        http_archive,
        name = "org_theopenroadproject_asap7sc6t_26",
        urls = [
            "https://github.com/The-OpenROAD-Project/asap7sc6t_26/archive/f572bf760c8bdc853cbafd0742790aba0780089c.tar.gz",
        ],
        strip_prefix = "asap7sc6t_26-f572bf760c8bdc853cbafd0742790aba0780089c",
        sha256 = "4bfe15775eaab3a5cc443d444ef82bf7b9c818ba2ed948ce3d9cc6a4cfa1c36c",
        build_file = Label("@rules_hdl//dependency_support/org_theopenroadproject_asap7sc6t_26:bundled.BUILD.bazel"),
    )
