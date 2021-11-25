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

def net_sourceforge_ngspice():
    maybe(
        new_git_repository,
        name = "net_sourceforge_ngspice",
        commit = "371ad3496c684c620e9ad6fb34f6a4bca10f7bac",  # ngspice-33, 2020-12-03
        remote = "git://git.code.sf.net/p/ngspice/ngspice",
        shallow_since = "1603013722 +0200",
        build_file = Label("@rules_hdl//dependency_support/net_sourceforge_ngspice:bundled.BUILD.bazel"),
    )
