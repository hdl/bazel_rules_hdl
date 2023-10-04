# Copyright 2023 Google LLC
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

load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def com_google_ortools():
    maybe(
        http_archive,
        name = "com_google_ortools",
        strip_prefix = "or-tools-9.7",
        urls = ["https://github.com/google/or-tools/archive/refs/tags/v9.7.tar.gz"],
        sha256 = "054d9517fc6c83f15150c93ef1c2c674ffd7d4a0d1fdc78f6ef8bc3e25c2e339",
    )
    maybe(
        new_git_repository,
        name = "scip",
        build_file = "@com_google_ortools//bazel:scip.BUILD",
        patches = ["@com_google_ortools//bazel:scip.patch"],
        patch_args = ["-p1"],
        tag = "v803",
        remote = "https://github.com/scipopt/scip.git",
    )
    maybe(
        http_archive,
        name = "bliss",
        build_file = "@com_google_ortools//bazel:bliss.BUILD",
        patches = ["@com_google_ortools//bazel:bliss-0.73.patch"],
        sha256 = "f57bf32804140cad58b1240b804e0dbd68f7e6bf67eba8e0c0fa3a62fd7f0f84",
        url = "https://github.com/google/or-tools/releases/download/v9.0/bliss-0.73.zip",
        #url = "http://www.tcs.hut.fi/Software/bliss/bliss-0.73.zip",
    )
    maybe(
        new_git_repository,
        name = "eigen",
        tag = "3.4.0",
        remote = "https://gitlab.com/libeigen/eigen.git",
        build_file_content = """
cc_library(
    name = 'eigen3',
    srcs = [],
    includes = ['.'],
    hdrs = glob(['Eigen/**']),
    visibility = ['//visibility:public'],
)
""",
    )
