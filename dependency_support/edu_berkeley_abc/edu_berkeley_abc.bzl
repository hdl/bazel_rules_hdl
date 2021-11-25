# Copyright 2020 The XLS Authors
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

"""Loads the ABC system for sequential synthesis and verification, used by yosys."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def edu_berkeley_abc():
    maybe(
        http_archive,
        name = "edu_berkeley_abc",
        urls = [
            "https://github.com/berkeley-abc/abc/archive/06094ade87fbec6000619bf007aaad596e8bc0a2.tar.gz",  # 2012-12-16
        ],
        strip_prefix = "abc-06094ade87fbec6000619bf007aaad596e8bc0a2",
        sha256 = "cfb3d803f74441a94b8dfb6961460a31d9321b34042cfecbce35f59440c41dd2",
        build_file = Label("@rules_hdl//dependency_support:edu_berkeley_abc/bundled.BUILD.bazel"),
    )
