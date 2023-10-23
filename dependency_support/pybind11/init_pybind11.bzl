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

""" pybind11 """

load("@pybind11_bazel//:python_configure.bzl", "python_configure")

def init_pybind11(python_interpreter_target = None):
    python_configure(
        name = "local_config_python",
        python_version = "3",
        python_interpreter_target = python_interpreter_target,
    )
