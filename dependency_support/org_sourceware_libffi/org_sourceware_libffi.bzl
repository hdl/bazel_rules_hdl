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

"""Loads the libffi library, used by Yosys."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def org_sourceware_libffi():
    maybe(
        http_archive,
        name = "org_sourceware_libffi",
        urls = [
            "https://github.com/libffi/libffi/releases/download/v3.4.6/libffi-3.4.6.tar.gz",
        ],
        strip_prefix = "libffi-3.4.6",
        sha256 = "b0dea9df23c863a7a50e825440f3ebffabd65df1497108e5d437747843895a4e",
        build_file = Label("@rules_hdl//dependency_support:org_sourceware_libffi/bundled.BUILD.bazel"),
    )
