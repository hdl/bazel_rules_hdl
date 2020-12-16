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
load("//dependency_support/at_clifford_icestorm:at_clifford_icestorm.bzl", "at_clifford_icestorm")
load("//dependency_support/at_clifford_yosys:at_clifford_yosys.bzl", "at_clifford_yosys")
load("//dependency_support/com_icarus_iverilog:com_icarus_iverilog.bzl", "com_icarus_iverilog")
load("//dependency_support/com_github_westes_flex:com_github_westes_flex.bzl", "com_github_westes_flex")
load("//dependency_support/com_google_absl:com_google_absl.bzl", "com_google_absl")
load("//dependency_support/com_google_googletest:com_google_googletest.bzl", "com_google_googletest")
load("//dependency_support/com_google_skywater_pdk:com_google_skywater_pdk.bzl", "com_google_skywater_pdk")
load("//dependency_support/com_opencircuitdesign_magic:com_opencircuitdesign_magic.bzl", "com_opencircuitdesign_magic")
load("//dependency_support/com_opencircuitdesign_netgen:com_opencircuitdesign_netgen.bzl", "com_opencircuitdesign_netgen")
load("//dependency_support/edu_berkeley_abc:edu_berkeley_abc.bzl", "edu_berkeley_abc")
load("//dependency_support/net_invisible_island_ncurses:net_invisible_island_ncurses.bzl", "net_invisible_island_ncurses")
load("//dependency_support/net_sourceforge_ngspice:net_sourceforge_ngspice.bzl", "net_sourceforge_ngspice")
load("//dependency_support/net_zlib:net_zlib.bzl", "net_zlib")
load("//dependency_support/org_fftw:org_fftw.bzl", "org_fftw")
load("//dependency_support/org_gnu_bison:org_gnu_bison.bzl", "org_gnu_bison")
load("//dependency_support/org_gnu_gperf:org_gnu_gperf.bzl", "org_gnu_gperf")
load("//dependency_support/org_gnu_m4:org_gnu_m4.bzl", "org_gnu_m4")
load("//dependency_support/org_gnu_readline:org_gnu_readline.bzl", "org_gnu_readline")
load("//dependency_support/org_sourceware_bzip2:org_sourceware_bzip2.bzl", "org_sourceware_bzip2")

def dependency_support():
  at_clifford_icestorm()
  at_clifford_yosys()
  com_github_westes_flex()
  com_google_absl()
  com_google_googletest()
  com_google_skywater_pdk()
  com_icarus_iverilog()
  com_opencircuitdesign_magic()
  com_opencircuitdesign_netgen()
  edu_berkeley_abc()
  net_invisible_island_ncurses()
  net_sourceforge_ngspice()
  net_zlib()
  org_fftw()
  org_gnu_bison()
  org_gnu_gperf()
  org_gnu_m4()
  org_gnu_readline()
  org_sourceware_bzip2()
