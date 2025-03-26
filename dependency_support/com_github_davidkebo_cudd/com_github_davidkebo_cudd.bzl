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

"""Registers Bazel workspaces for the cudd libraries."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def com_github_davidkebo_cudd():
    maybe(
        http_archive,
        name = "com_github_davidkebo_cudd",
        urls = [
            "https://github.com/davidkebo/cudd/raw/refs/heads/main/cudd_versions/cudd-3.0.0.tar.gz",
        ],
        strip_prefix = "cudd-3.0.0",
        sha256 = "b8e966b4562c96a03e7fbea239729587d7b395d53cadcc39a7203b49cf7eeb69",
        build_file = "//dependency_support/com_github_davidkebo_cudd:bundled.BUILD.bazel",
    )
