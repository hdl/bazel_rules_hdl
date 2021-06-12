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

"""Loads the m4 macro processor, used by Bison."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def org_gnu_m4():
    maybe(
        http_archive,
        name = "org_gnu_m4",
        urls = [
            "https://ftp.acc.umu.se/mirror/gnu.org/gnu/m4/m4-1.4.19.tar.xz",
            "https://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.xz",
        ],
        strip_prefix = "m4-1.4.19",
        sha256 = "63aede5c6d33b6d9b13511cd0be2cac046f2e70fd0a07aa9573a04a82783af96",
        build_file = Label("//dependency_support:org_gnu_m4/bundled.BUILD.bazel"),
        patches = [
            "@rules_hdl//dependency_support/org_gnu_m4:no_freadahead.patch",
            "@rules_hdl//dependency_support/org_gnu_m4:no_posix_spawn_file_actions_addchdir.patch",
        ],
    )
