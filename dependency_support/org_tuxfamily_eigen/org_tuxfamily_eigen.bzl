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

"""Loads the Eigen C++ template library for linear algebra."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def org_tuxfamily_eigen():
    maybe(
        http_archive,
        name = "org_tuxfamily_eigen",
        build_file = Label("//dependency_support/org_tuxfamily_eigen:bundled.BUILD.bazel"),
        sha256 = "3aebfcf3ca04d34c958bef6de7f80a4639b002989e5281b113b2cf4eb78b3f9b",
        strip_prefix = "eigen-4fd5d1477b22",
        urls = [
            "https://github.com/retone/deps/releases/download/na3/eigen-4fd5d1477b22.tar.bz2",
        ],
    )
