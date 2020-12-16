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


# The structure for adding a third_party dependency is to create a folder in this
# directory that will contain the build rules and workspace rules required to import
# it.
load("//dependency_support/at_clifford_yosys:at_clifford_yosys.bzl", "at_clifford_yosys")
load("//dependency_support/com_github_westes_flex:com_github_westes_flex.bzl", "com_github_westes_flex")
load("//dependency_support/com_google_skywater_pdk:com_google_skywater_pdk.bzl", "com_google_skywater_pdk")
load("//dependency_support/org_fftw:org_fftw.bzl", "org_fftw")
load("//dependency_support/org_gnu_bison:org_gnu_bison.bzl", "org_gnu_bison")
load("//dependency_support/org_gnu_m4:org_gnu_m4.bzl", "org_gnu_m4")


def dependency_support():
  at_clifford_yosys()
  com_github_westes_flex()
  com_google_skywater_pdk()
  org_fftw()
  org_gnu_bison()
  org_gnu_m4()
