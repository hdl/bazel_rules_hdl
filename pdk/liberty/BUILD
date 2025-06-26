# Copyright 2022 Google LLC
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

"""ASAP7 PDK Package"""

load("@rules_hdl_pip_deps//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", "py_binary", "py_library", "py_test")

package(
    default_applicable_licenses = ["//:package_license"],
    default_visibility = ["//visibility:private"],
)

py_binary(
    name = "combine_liberty",
    srcs = [
        "combine_liberty.py",
    ],
    python_version = "PY3",
    srcs_version = "PY3",
    visibility = ["//visibility:public"],
    deps = [
        ":liberty_utility",
        requirement("absl-py"),
    ],
)

py_library(
    name = "liberty_utility",
    srcs = [
        "liberty_utility.py",
    ],
    deps = [
        ":cell_parser",
    ],
)

py_test(
    name = "liberty_utility_test",
    srcs = [
        "liberty_utility_test.py",
    ],
    python_version = "PY3",
    deps = [
        ":liberty_utility",
    ],
)

py_library(
    name = "cell_parser",
    srcs = [
        "cell_parser.py",
    ],
)

py_test(
    name = "cell_parser_test",
    srcs = [
        "cell_parser_test.py",
    ],
    python_version = "PY3",
    deps = [
        ":cell_parser",
    ],
)
