# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writxing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def register_cpython_repository():
    http_archive(
        name = "rules_hdl_cpython",
        strip_prefix = "python",
        urls = [
            # This is a re-packaged version of binaries from https://github.com/indygreg/python-build-standalone/releases
            # It's repackaged because Bazel doesn't support .tar.zst files that are uploaded there.
            "https://github.com/retone/deps/releases/download/na7/cpython-3.8.6-x86_64-unknown-linux-gnu-pgo-20201020T0627.tar.xz"
        ],
        sha256 = "8571da2a8e3a19fda593bccc6d252fc01f7f567ea4c2a4e5c7d083036ed2c507",
        build_file = "@rules_hdl//toolchains/cpython:cpython.BUILD",
    )
