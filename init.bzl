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

""" initializes the bazel_rules_hdl workspace """

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")
load("@rules_python//python:pip.bzl", "pip_install")
load("//dependency_support/boost:init_boost.bzl", "init_boost")
load("//dependency_support/pybind11:init_pybind11.bzl", "init_pybind11")

def init(python_interpreter = None, python_interpreter_target = None):
    """Initializes the bazel_rules_hdl workspace.

    If @bazel_rules_hdl is imported into another Bazel workspace, that workspace
    must call `init` to allow @bazel_rules_hdl to set itself up.

    `python_interpreter` and `python_interpreter_target` are passed to
    @bazel_rules_hdl's instance of `pip_install`. They can normally be set to
    the default None value, but if the outside workspace has a custom Python
    toolchain configured, these must be set, otherwise @bazel_rules_hdl will
    not use the right Python toolchain when installing pip dependencies.

    Args:
      python_interpreter: Path to external Python interpreter to use with
      `pip_install`. This can be an absolute path or relative to the host's
      `PATH` environment variable.
      python_interpreter_target: Bazel target of a Python interpreter to build
      to use with `pip_install`. Using `python_interpreter_target` makes it
      possible to have a hermetic Python toolchain. `python_interpreter_target`
      takes precedence over `python_interpreter` if both are set.
    """
    pip_install(
        name = "rules_hdl_pip_deps",
        requirements = "@rules_hdl//dependency_support:pip_requirements.txt",
        python_interpreter = python_interpreter,
        python_interpreter_target = python_interpreter_target,
    )

    init_boost()
    init_pybind11()

    bazel_skylib_workspace()
