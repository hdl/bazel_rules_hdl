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

workspace(name = "rules_hdl")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

load("//toolchains/cpython:cpython_toolchain.bzl", "register_cpython_repository")
register_cpython_repository()
register_toolchains("//toolchains/cpython:cpython_toolchain")

maybe(
    http_archive,
    name = "rules_python",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.1.0/rules_python-0.1.0.tar.gz",
    sha256 = "b6d46438523a3ec0f3cead544190ee13223a52f6a6765a29eae7b7cc24cc83a0",
)

# Third Party
load("//dependency_support:dependency_support.bzl", "dependency_support")
dependency_support()
# Third Party

load("//:init.bzl", "init")
init(python_interpreter_target = "@rules_hdl_cpython//:install/bin/python3",)
