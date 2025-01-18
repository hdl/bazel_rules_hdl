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

"""Registers Bazel workspaces for the Boost C++ libraries."""

load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def org_theopenroadproject():
    maybe(
        new_git_repository,
        name = "org_theopenroadproject",
        commit = "f6da0454e350e93c62264f7b7c95029e1ad2b9fd",
        # TODO: Convert to http_archive whenever there is an archive
        # which contains submodules.
        # https://github.com/dear-github/dear-github/issues/214
        init_submodules = True,
        remote = "https://github.com/The-OpenROAD-Project/OpenROAD.git",
        build_file = Label("//dependency_support/org_theopenroadproject:bundled.BUILD.bazel"),
        shallow_since = "1709242873 -0800",
        patches = [
            Label("@rules_hdl//dependency_support/org_theopenroadproject:0001-logging-change-to-support-silence.patch"),
            Label("@rules_hdl//dependency_support/org_theopenroadproject:0002-ortools-quotes.patch"),
        ],
        patch_args = ["-p1"],
    )
