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

"""Registers Bazel workspaces for the spdlog libraries."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def com_github_ivmai_cudd():
    maybe(
        http_archive,
        name = "com_github_ivmai_cudd",
        urls = [
            "https://github.com/ivmai/cudd/archive/f54f533303640afd5dbe47a05ebeabb3066f2a25.zip",
        ],
        strip_prefix = "cudd-f54f533303640afd5dbe47a05ebeabb3066f2a25",
        sha256 = "",
        build_file = Label("//dependency_support/com_github_ivmai_cudd:bundled.BUILD.bazel"),
    )
