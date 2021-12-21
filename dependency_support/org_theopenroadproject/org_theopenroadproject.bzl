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
        commit = "0e03065d0e9fb1416933c704e43593c11191c80b",
        init_submodules = True,
        remote = "https://github.com/The-OpenROAD-Project/OpenROAD.git",
        build_file = Label("@rules_hdl//dependency_support/org_theopenroadproject:bundled.BUILD.bazel"),
        patches = [
            Label("@rules_hdl//dependency_support/org_theopenroadproject:0001-logging-change-to-support-silence.patch"),
        ],
        patch_args = [
            "-p1",
        ],
        shallow_since = "1640117028 -0800",
    )
