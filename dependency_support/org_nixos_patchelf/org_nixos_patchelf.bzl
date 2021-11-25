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

"""Loads patchelf, a utility for modifying ELF executables and libraries."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def org_nixos_patchelf():
    maybe(
        http_archive,
        name = "org_nixos_patchelf",
        urls = [
            "https://github.com/NixOS/patchelf/archive/f34751b88bd07d7f44f5cd3200fb4122bf916c7e.zip",  # 2021-01-08
        ],
        strip_prefix = "patchelf-f34751b88bd07d7f44f5cd3200fb4122bf916c7e",
        sha256 = "5ed94d15c44c13c1fa6a78b2f5ca499e465fd9171e4a1daf194e8523c04a9339",
        build_file = Label("@rules_hdl//dependency_support/org_nixos_patchelf:bundled.BUILD.bazel"),
    )
