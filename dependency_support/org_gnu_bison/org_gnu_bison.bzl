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
        sha256 = "10ce41f150ccfbfddc9d2394ee680eb984dc8a3dfea613afd013cfb22ea7445c",
        urls = ["https://github.com/jmillikin/rules_m4/releases/download/v0.2.3/rules_m4-v0.2.3.tar.xz"],
    )

    maybe(
        http_archive,
        name = "rules_bison",
        sha256 = "2279183430e438b2dc77cacd7b1dbb63438971b2411406570f1ddd920b7c9145",
        urls = ["https://github.com/jmillikin/rules_bison/releases/download/v0.2.2/rules_bison-v0.2.2.tar.xz"],
    )
