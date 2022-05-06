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

"""Loads the Swig library."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def org_swig():
    maybe(
        http_archive,
        name = "org_swig",
        urls = [
            "https://downloads.sourceforge.net/swig/swig-4.0.0.tar.gz",
        ],
        strip_prefix = "swig-4.0.0",
        sha256 = "e8a39cd6437e342cdcbd5af27a9bf11b62dc9efec9248065debcb8276fcbb925",
        build_file = Label("@rules_hdl//dependency_support/org_swig:bundled.BUILD.bazel"),
    )
