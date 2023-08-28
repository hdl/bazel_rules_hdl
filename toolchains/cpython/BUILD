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

load("@bazel_tools//tools/python:toolchain.bzl", "py_runtime_pair")
load("@rules_python//python:defs.bzl", "py_runtime")

py_runtime(
    name = "cpython_runtime",
    files = ["@rules_hdl_cpython//:all"],
    interpreter = "@rules_hdl_cpython//:install/bin/python3",
    python_version = "PY3",
)

py_runtime_pair(
    name = "cpython_runtime_pair",
    py3_runtime = ":cpython_runtime",
)

toolchain(
    name = "cpython_toolchain",
    toolchain = ":cpython_runtime_pair",
    toolchain_type = "@bazel_tools//tools/python:toolchain_type",
)
