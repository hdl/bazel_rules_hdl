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

http_archive(
    name = "com_grail_bazel_toolchain",
    sha256 = "77c368349e1a90e6e133c7a16743c622856a0e6b4c9935d7d40ece53cf9d3576",
    strip_prefix = "bazel-toolchain-7e7c7cf1f965f348861085183d79b6a241764390",
    urls = ["https://github.com/grailbio/bazel-toolchain/archive/7e7c7cf1f965f348861085183d79b6a241764390.tar.gz"],
)

http_archive(
    name = "bazel_skylib",
    sha256 = "74d544d96f4a5bb630d465ca8bbcfe231e3594e5aae57e1edbf17a6eb3ca2506",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
    ],
)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

# This sysroot is used by github.com/vsco/bazel-toolchains.
# Disabled for now waiting on https://github.com/pybind/pybind11_bazel/pull/29
# py_bind11 relies on installed linux headers which a custom sysroot disables.
# Once hermetic python is supported this should no longer be an issue.
# http_archive(
#     name = "org_chromium_sysroot_linux_x64",
#     build_file_content = """
# filegroup(
#   name = "sysroot",
#   srcs = glob(["*/**"]),
#   visibility = ["//visibility:public"],
# )
# """,
#     sha256 = "73d828bf653f8f8548be704ce1ded4d195bf2bf937fc5426dd5636a9940d1969",
#     urls = ["https://commondatastorage.googleapis.com/chrome-linux-sysroot/toolchain/3c248ba4290a5ad07085b7af07e6785bf1ae5b66/debian_stretch_amd64_sysroot.tar.xz"],
# )

load("@com_grail_bazel_toolchain//toolchain:deps.bzl", "bazel_toolchain_dependencies")

bazel_toolchain_dependencies()

load("@com_grail_bazel_toolchain//toolchain:rules.bzl", "llvm_toolchain")

llvm_toolchain(
    name = "llvm_toolchain",
    llvm_version = "10.0.1",
    sha256 = {
        "linux": "02a73cfa031dfe073ba8d6c608baf795aa2ddc78eed1b3e08f3739b803545046",
    },
    strip_prefix = {
        "linux": "clang+llvm-10.0.1-x86_64-pc-linux-gnu",
    },
    urls = {
        "linux": [
            # Use a custom built Clang+LLVM binrary distribution that is more portable than
            # the official builds because it's built against an older glibc and does not have
            # dynamic library dependencies to tinfo, gcc_s or stdlibc++.
            #
            # For more details, see the files under toolchains/clang.
            "https://github.com/retone/deps/releases/download/na5/clang+llvm-10.0.1-x86_64-pc-linux-gnu.tar.xz",
        ],
    },
    # Disabled for now waiting on https://github.com/pybind/pybind11_bazel/pull/29
    # sysroot = {
    #     "linux": "@org_chromium_sysroot_linux_x64//:sysroot",
    # },
)

maybe(
    http_archive,
    name = "rules_python",
    sha256 = "b6d46438523a3ec0f3cead544190ee13223a52f6a6765a29eae7b7cc24cc83a0",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.1.0/rules_python-0.1.0.tar.gz",
)

maybe(
    http_archive,
    name = "rules_pkg",
    sha256 = "a89e203d3cf264e564fcb96b6e06dd70bc0557356eb48400ce4b5d97c2c3720d",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.5.1/rules_pkg-0.5.1.tar.gz",
        "https://github.com/bazelbuild/rules_pkg/releases/download/0.5.1/rules_pkg-0.5.1.tar.gz",
    ],
)

load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")

rules_pkg_dependencies()

load("@rules_pkg//toolchains:rpmbuild.bzl", "rpmbuild_register_toolchains")

rpmbuild_register_toolchains()

# Third Party
load("//dependency_support:dependency_support.bzl", "dependency_support")

dependency_support()
# Third Party

load("//:init.bzl", "init")

init(python_interpreter_target = "@rules_hdl_cpython//:install/bin/python3")
