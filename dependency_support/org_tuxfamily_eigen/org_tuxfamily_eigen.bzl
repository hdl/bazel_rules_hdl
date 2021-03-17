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

load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def org_tuxfamily_eigen():
    maybe(
        new_git_repository,
        name = "org_tuxfamily_eigen",
        build_file = Label("//dependency_support/org_tuxfamily_eigen:bundled.BUILD.bazel"),
        commit = "eb71e5db988d4a23e619ed054efd3eb751cdd026",  # 2021-03-17
        remote = "https://gitlab.com/libeigen/eigen.git",
        shallow_since = "1615946824 +0100",
    )
