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

"""Loads the Skywater open source process design kit."""

load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load(":cell_libraries.bzl", "CELL_LIBRARIES")

def _build_file(workspace_name, library_name):
    library = CELL_LIBRARIES[library_name]
    return """
load("@rules_hdl//dependency_support/com_google_skywater_pdk:declare_cell_library.bzl", "declare_cell_library")
declare_cell_library("{}", "{}")
""".format(workspace_name, library_name)

def com_google_skywater_pdk():
    maybe(
        http_archive,
        name = "com_google_skywater_pdk",
        urls = [
            "https://github.com/google/skywater-pdk/archive/3d7617a1acb92ea883539bcf22a632d6361a5de4.tar.gz",  # 2020-12-04
        ],
        strip_prefix = "skywater-pdk-3d7617a1acb92ea883539bcf22a632d6361a5de4",
        sha256 = "49e5b03c26131a03eb038697d396a6ebf14058d78196f5d95c2bbdb0bdc8f32e",
        build_file = Label("//dependency_support/com_google_skywater_pdk:bundled.BUILD.bazel"),
    )

    for library_name in CELL_LIBRARIES:
        library = CELL_LIBRARIES[library_name]
        workspace_name = "com_google_skywater_pdk_" + library_name
        maybe(
            new_git_repository,
            name = workspace_name,
            commit = library["commit"],
            remote = "https://foss-eda-tools.googlesource.com/skywater-pdk/libs/%s.git" % library_name,
            shallow_since = library["shallow_since"],
            build_file_content = _build_file(workspace_name, library_name),
        )
