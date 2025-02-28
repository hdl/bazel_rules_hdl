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

"""Loads the Flex lexer generator, used by iverilog."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def com_github_westes_flex():
    maybe(
        http_archive,
        name = "rules_flex",
        sha256 = "04f709d84237b63b6f7dce17be69e460589e546fdc6caca924ed7e53de42a3a8",
        urls = ["https://github.com/jmillikin/rules_flex/releases/download/v0.3.1/rules_flex-v0.3.1.tar.xz"],
    )
