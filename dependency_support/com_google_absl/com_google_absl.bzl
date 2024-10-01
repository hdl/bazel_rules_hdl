# Copyright 2020 Google LLC
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

"""Registers Bazel workspaces for the GNU readline library."""

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def com_google_absl():
    maybe(
        http_archive,
        name = "com_google_absl",
        urls = ["https://github.com/abseil/abseil-cpp/archive/refs/tags/20240116.2.tar.gz"],
        strip_prefix = "abseil-cpp-20240116.2",
        sha256 = "733726b8c3a6d39a4120d7e45ea8b41a434cdacde401cba500f14236c49b39dc",
        patches = ["@com_google_ortools//patches:abseil-cpp-20240116.2.patch"],
        patch_args = ["-p1"],
    )
