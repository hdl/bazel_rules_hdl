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

"""Registers Bazel workspaces for the GNU readline library."""

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def com_google_protobuf():
    maybe(
        git_repository,
        name = "com_google_protobuf",
        tag = "v23.3",
        patches = ["@com_google_ortools//patches:protobuf-v23.3.patch"],
        patch_args = ["-p1"],
        remote = "https://github.com/protocolbuffers/protobuf.git",
    )
