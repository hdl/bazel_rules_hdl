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
            "https://github.com/berkeley-abc/abc/archive/0d579a430d57e5b864a62407aac2da0faba7c3b0.tar.gz",
        ],
        strip_prefix = "abc-0d579a430d57e5b864a62407aac2da0faba7c3b0",
        sha256 = "9ea3d8b7a104a2394e8967c93b3faaa12c3444a8901c11786494119b8088a1d9",
        build_file = Label("@rules_hdl//dependency_support:edu_berkeley_abc/bundled.BUILD.bazel"),
    )
