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

load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def org_gnu_readline():
    maybe(
        new_git_repository,
        name = "org_gnu_readline",
        commit = "8e6ccd0373d77b86ed37a9a7d232ccfea3d6670c",  # 8.0, 2020-08-24
        remote = "https://git.savannah.gnu.org/git/readline.git",
        shallow_since = "1546871421 -0500",
        build_file = Label("//dependency_support/org_gnu_readline:bundled.BUILD.bazel"),
        patches = [
            "@rules_hdl//dependency_support/org_gnu_readline:missing_include.patch",
        ],
    )
