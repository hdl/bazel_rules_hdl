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

"""Registers Bazel workspaces for the Boost C++ libraries."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def org_theopenroadproject_asap7sc7p5t_27():
    maybe(
        http_archive,
        name = "org_theopenroadproject_asap7sc7p5t_27",
        urls = [
            "https://github.com/The-OpenROAD-Project/asap7sc7p5t_27/archive/900f55ed8bef025f39edcc8b8be5e04a2c55c15a.tar.gz",
        ],
        strip_prefix = "asap7sc7p5t_27-900f55ed8bef025f39edcc8b8be5e04a2c55c15a",
        sha256 = "db5531736a34f34e919488468e8ee09ae87495ff8a6188fad375d68c19e10e20",
        build_file = Label("@rules_hdl//dependency_support/org_theopenroadproject_asap7sc7p5t_27:bundled.BUILD.bazel"),
    )
