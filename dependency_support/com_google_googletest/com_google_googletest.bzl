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

def com_google_googletest():
    maybe(
        http_archive,
        name = "com_google_googletest",
        urls = ["https://github.com/google/googletest/archive/0eea2e9fc63461761dea5f2f517bd6af2ca024fa.zip"],  # 2020-04-30
        strip_prefix = "googletest-0eea2e9fc63461761dea5f2f517bd6af2ca024fa",
        sha256 = "9463ff914d7c3db02de6bd40a3c412a74e979e3c76eaa89920a49ff8488d6d69",
    )
