# Copyright 2021 Google LLC
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

def com_github_gabime_spdlog():
    maybe(
        http_archive,
        name = "com_github_gabime_spdlog",
        urls = [
            "https://github.com/gabime/spdlog/archive/refs/tags/v1.9.2.tar.gz",
        ],
        strip_prefix = "spdlog-1.9.2",
        sha256 = "6fff9215f5cb81760be4cc16d033526d1080427d236e86d70bb02994f85e3d38",
        build_file = Label("@rules_hdl//dependency_support/com_github_gabime_spdlog:bundled.BUILD.bazel"),
    )
