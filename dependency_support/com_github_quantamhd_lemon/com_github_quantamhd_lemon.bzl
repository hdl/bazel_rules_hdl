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

"""Lemon package"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def com_github_quantamhd_lemon():
    maybe(
        http_archive,
        name = "com_github_quantamhd_lemon",
        urls = [
            "https://github.com/QuantamHD/lemon/archive/refs/tags/1.3.1.tar.gz",
        ],
        strip_prefix = "lemon-1.3.1",
        sha256 = "a7f28821431b76505966e9a34c94c180130f6162ed2fc59ade8a685b5d5dcfeb",
        build_file = Label("@rules_hdl//dependency_support/com_github_quantamhd_lemon:bundled.BUILD.bazel"),
        patches = [
            Label("@rules_hdl//dependency_support/com_github_quantamhd_lemon:lemon.patch"),
        ],
        patch_args = [
            "-p1",
        ],
    )
