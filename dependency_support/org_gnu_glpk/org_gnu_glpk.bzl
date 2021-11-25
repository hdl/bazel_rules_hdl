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

"""Loads the FFTW fast fourier transform library."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def org_gnu_glpk():
    maybe(
        http_archive,
        name = "org_gnu_glpk",
        urls = [
            "http://ftp.gnu.org/gnu/glpk/glpk-4.47.tar.gz",
        ],
        strip_prefix = "glpk-4.47",
        sha256 = "c35438e3ba74a8d85236810e6b84879272c87cfa7473b4075201e2967839f48d",
        build_file = Label("@rules_hdl//dependency_support/org_gnu_glpk:bundled.BUILD.bazel"),
        patches = [
            Label("@rules_hdl//dependency_support/org_gnu_glpk:glpk.patch"),
        ],
    )
