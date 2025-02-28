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

"""Loads the Bison parser generator."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def org_gnu_bison():
    maybe(
        http_archive,
        name = "rules_m4",
        sha256 = "e62cc7f358a2de3e6f30159039277e0dd58e2918d9769d1cb5a965f1c322e6cd",
        urls = ["https://github.com/jmillikin/rules_m4/releases/download/v0.2.4/rules_m4-v0.2.4.tar.xz"],
    )

    maybe(
        http_archive,
        name = "rules_bison",
        sha256 = "d3897d735c013c220fb6daefe8d46dc527a7756da9c2743951efac2f02da6d99",
        urls = ["https://github.com/jmillikin/rules_bison/releases/download/v0.3.1/rules_bison-v0.3.1.tar.xz"],
    )
