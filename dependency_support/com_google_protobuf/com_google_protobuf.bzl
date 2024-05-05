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

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def com_google_protobuf():
    maybe(
        http_archive,
        name = "com_google_protobuf",
        urls = ["https://github.com/protocolbuffers/protobuf/releases/download/v23.3/protobuf-23.3.tar.gz"],
        strip_prefix = "protobuf-23.3",
        integrity = "sha256-Ol9HrTqhAZLFV3/whrJLlzmjaTfDTOq225EqFqPvf44=",
        patch_args = ["-p1"],
        patches = ["@com_google_ortools//patches:protobuf-v23.3.patch"],
    )
