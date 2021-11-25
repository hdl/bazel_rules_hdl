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

"""Registers Bazel workspaces for the fmtlib libraries."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def com_github_fmtlib_fmt():
    maybe(
        http_archive,
        name = "com_github_fmtlib_fmt",
        urls = [
            "https://github.com/fmtlib/fmt/archive/refs/tags/8.0.1.tar.gz",
        ],
        strip_prefix = "fmt-8.0.1",
        sha256 = "b06ca3130158c625848f3fb7418f235155a4d389b2abc3a6245fb01cb0eb1e01",
        build_file = Label("@rules_hdl//dependency_support/com_github_fmtlib_fmt:bundled.BUILD.bazel"),
    )
