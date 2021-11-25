# Copyright 2020-2021 Google LLC
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

"""Registers Bazel workspaces for the GNU readline library."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def org_gnu_readline():
    maybe(
        http_archive,
        name = "org_gnu_readline",
        urls = [
            "https://ftp.gnu.org/gnu/readline/readline-8.0.tar.gz",
            "http://ftp.vim.org/ftp/gnu/readline/readline-8.0.tar.gz",
            "http://ftp.swin.edu.au/gnu/readline/readline-8.0.tar.gz",
        ],
        sha256 = "e339f51971478d369f8a053a330a190781acb9864cf4c541060f12078948e461",
        strip_prefix = "readline-8.0",
        build_file = Label("@rules_hdl//dependency_support/org_gnu_readline:bundled.BUILD.bazel"),
        patches = [
            Label("@rules_hdl//dependency_support/org_gnu_readline:missing_include.patch"),
        ],
    )
