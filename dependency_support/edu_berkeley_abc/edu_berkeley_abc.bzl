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
            "https://github.com/berkeley-abc/abc/archive/c25bf7346698296580fbc5ff53a2c6c4ff5323da.tar.gz",
        ],
        strip_prefix = "abc-c25bf7346698296580fbc5ff53a2c6c4ff5323da",
        sha256 = "53398456e263fbb937fe6d8f0aa827e00145cc33d1f44b5a24efcd0f80b0ccc2",
        build_file = Label("//dependency_support:edu_berkeley_abc/bundled.BUILD.bazel"),
    )
