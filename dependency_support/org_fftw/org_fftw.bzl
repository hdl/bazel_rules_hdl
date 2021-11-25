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

"""Loads the FFTW fast fourier transform library."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def org_fftw():
    maybe(
        http_archive,
        name = "org_fftw",
        urls = [
            "http://www.fftw.org/fftw-3.3.8.tar.gz",  # 2020-08-29
        ],
        strip_prefix = "fftw-3.3.8",
        sha256 = "6113262f6e92c5bd474f2875fa1b01054c4ad5040f6b0da7c03c98821d9ae303",
        build_file = Label("@rules_hdl//dependency_support/org_fftw:bundled.BUILD.bazel"),
    )
