# Copyright 2024 Google LLC
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

"""vlsiffra-hdl-library - Library of adders."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def com_github_mithro_vlsiffra_hdl_library():
    maybe(
        http_archive,
        name = "com_github_mithro_vlsiffra_hdl_library",
        urls = [
            "https://github.com/mithro/vlsiffra-hdl-library/archive/279bd99dcdb1cb0faf024d42ede842ca5ef56409.tar.gz",
        ],
        strip_prefix = "vlsiffra-hdl-library-1.3.1",
        sha256 = "6a294f362d839ec3626e627eba9024963c9fefae04c66efea7e7131fba2baa0b",
        build_file = Label("@rules_hdl//dependency_support/com_github_mithro_vlsiffra_hdl_library:bundled.BUILD.bazel"),
    )
