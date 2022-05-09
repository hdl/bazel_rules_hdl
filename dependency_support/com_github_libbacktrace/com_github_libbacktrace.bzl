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

def com_github_libbacktrace():
    maybe(
        http_archive,
        name = "com_github_libbacktrace",
        urls = [
            "https://github.com/ianlancetaylor/libbacktrace/archive/4d2dd0b172f2c9192f83ba93425f868f2a13c553.zip",
        ],
        strip_prefix = "libbacktrace-4d2dd0b172f2c9192f83ba93425f868f2a13c553",
        sha256 = "90d224a18c0a0c0f1f22fe73b89ebebd4f1ee368e55d646718b7f3b294a52705",
        build_file = Label("@rules_hdl//dependency_support/com_github_libbacktrace:bundled.BUILD.bazel"),
    )
