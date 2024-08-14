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
load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")
load("@rules_bison//bison:bison.bzl", "bison_register_toolchains")
load("@rules_flex//flex:flex.bzl", "flex_register_toolchains")
load("@rules_m4//m4:m4.bzl", "m4_register_toolchains")
load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies")
load("@rules_proto//proto:toolchains.bzl", "rules_proto_toolchains")
load("//dependency_support:requirements.bzl", install_pip_deps = "install_deps")
load("//dependency_support/boost:init_boost.bzl", "init_boost")

def init(python_interpreter = None, python_interpreter_target = None):
    """Initializes the bazel_rules_hdl workspace.

    If @bazel_rules_hdl is imported into another Bazel workspace, that workspace
    must call `init` to allow @bazel_rules_hdl to set itself up.

    `python_interpreter` and `python_interpreter_target` are passed to
    @bazel_rules_hdl's vendored requirements.bzl `install_deps`. If unspecified,
    this project's default toolchain will be used. If the outside workspace has
    a custom Python toolchain configured, these should be set, otherwise
    @bazel_rules_hdl will not use the right Python toolchain when installing
    pip dependencies.

    Args:
      python_interpreter: Path to external Python interpreter to use with
        `install_deps` for PyPI dependencies. This can be an absolute path or
        relative to the host's `PATH` environment variable.
      python_interpreter_target: Bazel target of a Python interpreter to build
        to use with `install_deps` for PyPI dependencies. Using
        `python_interpreter_target` makes it possible to have a hermetic
        Python toolchain. `python_interpreter_target` takes precedence over
        `python_interpreter` if both are set.
    """

    rules_proto_dependencies()
    rules_proto_toolchains()

    install_deps_kwargs = {}
    if python_interpreter:
        install_deps_kwargs["python_interpreter"] = python_interpreter
    if python_interpreter_target:
        install_deps_kwargs["python_interpreter_target"] = python_interpreter_target
    install_pip_deps(**install_deps_kwargs)

    init_boost()

    protobuf_deps()

    bazel_skylib_workspace()

    m4_register_toolchains(version = "1.4.18")
    bison_register_toolchains(version = "3.3.2")
    flex_register_toolchains(version = "2.6.4")
