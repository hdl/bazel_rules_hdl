# Copyright 2021 Google LLC
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

"""Loads the pcre library"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def org_pcre_ftp():
    maybe(
        http_archive,
        name = "org_pcre_ftp",
        urls = [
            "https://ftp.exim.org/pub/pcre/pcre-8.44.tar.gz",
        ],
        strip_prefix = "pcre-8.44",
        sha256 = "aecafd4af3bd0f3935721af77b889d9024b2e01d96b58471bd91a3063fb47728",
        build_file = Label("@rules_hdl//dependency_support:org_pcre_ftp/bundled.BUILD.bazel"),
    )
