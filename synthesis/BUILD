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

# rules_pkg won't work before Bazel 4 because it depends on the json API.
# load("@rules_pkg//:pkg.bzl", "pkg_tar")
load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")

exports_files(["synth.tcl"])

pkg_tar(
    name = "yosys",
    srcs = ["@at_clifford_yosys//:yosys"],
    include_runfiles = True,
    strip_prefix = "/../",
)
