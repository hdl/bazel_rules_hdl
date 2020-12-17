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

"""Loads the Pybind11 Python<->C++ FFI library."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def pybind11():
    maybe(
        http_archive,
        name = "pybind11_bazel",
        strip_prefix = "pybind11_bazel-34206c29f891dbd5f6f5face7b91664c2ff7185c",
        urls = ["https://github.com/pybind/pybind11_bazel/archive/34206c29f891dbd5f6f5face7b91664c2ff7185c.zip"],
        sha256 = "8d0b776ea5b67891f8585989d54aa34869fc12f14bf33f1dc7459458dd222e95",
    )

    # maybe(
    #     http_archive,
    #     name = "pybind11",
    #     build_file = "@pybind11_bazel//:pybind11.BUILD",
    #     strip_prefix = "pybind11-59a2ac2745d8a57ac94c6accced73620d59fb844",
    #     urls = ["https://github.com/pybind/pybind11/archive/59a2ac2745d8a57ac94c6accced73620d59fb844.tar.gz"],
    #     sha256 = "3276f79ae507ae578501ffc2833f8e9082092eb99e59763a77d08c3fdea35bec",
    # )
