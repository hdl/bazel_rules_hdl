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

def com_github_ninja_build_ninja():
    maybe(
        http_archive,
        name = "com_github_ninja_build_ninja",
        urls = [
            "https://github.com/ninja-build/ninja/archive/55f54511d35716c43637dee2bcb5fbc7839f967b.zip",
        ],
        strip_prefix = "ninja-55f54511d35716c43637dee2bcb5fbc7839f967b",
        sha256 = "99b70ac3bd7d5c303a5b770888342af22b701d2a5cbc26da0912f79ebd6bd458",
        build_file = Label("@rules_hdl//dependency_support/com_github_ninja_build_ninja:bundled.BUILD.bazel"),
    )
