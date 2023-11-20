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

load("@rules_cc//cc:defs.bzl", "cc_import")
load("@rules_python//python:defs.bzl", "py_binary")

package(
    default_applicable_licenses = ["//:package_license"],
    default_visibility = ["//visibility:private"],
)

py_binary(
    name = "print_libpython_path",
    srcs = ["print_libpython_path.py"],
    python_version = "PY3",
    srcs_version = "PY3",
)

genrule(
    name = "embdedded_python_interpreter_so",
    outs = ["embedded_python_interpreter.so"],
    # The .so file for the Python runtime has a name that is not known at
    # analysis time. Because Bazel needs to know the name of the .so file
    # at analysis time we use a genrule to copy the .so file to a known path.
    # This causes problems with linking though, because the .so file has a
    # SONAME entry which causes the linker to create an executable that points
    # to the path named in SONAME rather than embdedded_python_interpreter.so.
    # To force the linker to make an executable that points to the right shared
    # library, the .so file is rewritten so that the SONAME field has the right
    # path in it.
    cmd = "cp \"$$($(location :print_libpython_path))\" $@ && $(location @org_nixos_patchelf//:patchelf) --set-soname embedded_python_interpreter.so $@",
    exec_tools = [
        ":print_libpython_path",
        "@org_nixos_patchelf//:patchelf",
    ],
)

# C binaries that embed a Python interpreter can depend on this library to get
# access to the Python symbols. This target uses libpython from the Python
# interpreter that is used by Bazel.
cc_import(
    name = "embedded_python_interpreter",
    shared_library = "embedded_python_interpreter.so",
    visibility = ["//visibility:public"],
)
