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

"""
The structure for adding a third_party dependency is to create a folder in this
directory that will contain the build rules and workspace rules required to import
it.
"""

load("@rules_hdl//dependency_support/at_clifford_icestorm:at_clifford_icestorm.bzl", "at_clifford_icestorm")
load("@rules_hdl//dependency_support/at_clifford_yosys:at_clifford_yosys.bzl", "at_clifford_yosys")
load("@rules_hdl//dependency_support/bazel_skylib:bazel_skylib.bzl", "bazel_skylib")
load("@rules_hdl//dependency_support/boost:boost.bzl", "boost")
load("@rules_hdl//dependency_support/com_github_fmtlib_fmt:com_github_fmtlib_fmt.bzl", "com_github_fmtlib_fmt")
load("@rules_hdl//dependency_support/com_github_gabime_spdlog:com_github_gabime_spdlog.bzl", "com_github_gabime_spdlog")
load("@rules_hdl//dependency_support/com_github_libbacktrace:com_github_libbacktrace.bzl", "com_github_libbacktrace")
load("@rules_hdl//dependency_support/com_github_ninja_build_ninja:com_github_ninja_build_ninja.bzl", "com_github_ninja_build_ninja")
load("@rules_hdl//dependency_support/com_github_quantamhd_lemon:com_github_quantamhd_lemon.bzl", "com_github_quantamhd_lemon")
load("@rules_hdl//dependency_support/com_github_westes_flex:com_github_westes_flex.bzl", "com_github_westes_flex")
load("@rules_hdl//dependency_support/com_github_yosyshq_nextpnr:com_github_yosyshq_nextpnr.bzl", "com_github_yosyshq_nextpnr")
load("@rules_hdl//dependency_support/com_github_yosyshq_prjtrellis:com_github_yosyshq_prjtrellis.bzl", "com_github_yosyshq_prjtrellis")
load("@rules_hdl//dependency_support/com_github_yosyshq_prjtrellis_db:com_github_yosyshq_prjtrellis_db.bzl", "com_github_yosyshq_prjtrellis_db")
load("@rules_hdl//dependency_support/com_google_absl:com_google_absl.bzl", "com_google_absl")
load("@rules_hdl//dependency_support/com_google_googletest:com_google_googletest.bzl", "com_google_googletest")
load("@rules_hdl//dependency_support/com_google_ortools:com_google_ortools.bzl", "com_google_ortools")
load("@rules_hdl//dependency_support/com_google_protobuf:com_google_protobuf.bzl", "com_google_protobuf")
load("@rules_hdl//dependency_support/com_google_skywater_pdk:com_google_skywater_pdk.bzl", "com_google_skywater_pdk")
load("@rules_hdl//dependency_support/com_icarus_iverilog:com_icarus_iverilog.bzl", "com_icarus_iverilog")
load("@rules_hdl//dependency_support/com_opencircuitdesign_magic:com_opencircuitdesign_magic.bzl", "com_opencircuitdesign_magic")
load("@rules_hdl//dependency_support/com_opencircuitdesign_netgen:com_opencircuitdesign_netgen.bzl", "com_opencircuitdesign_netgen")
load("@rules_hdl//dependency_support/edu_berkeley_abc:edu_berkeley_abc.bzl", "edu_berkeley_abc")
load("@rules_hdl//dependency_support/net_invisible_island_ncurses:net_invisible_island_ncurses.bzl", "net_invisible_island_ncurses")
load("@rules_hdl//dependency_support/net_sourceforge_ngspice:net_sourceforge_ngspice.bzl", "net_sourceforge_ngspice")
load("@rules_hdl//dependency_support/net_zlib:net_zlib.bzl", "net_zlib")
load("@rules_hdl//dependency_support/org_fftw:org_fftw.bzl", "org_fftw")
load("@rules_hdl//dependency_support/org_gnu_bison:org_gnu_bison.bzl", "org_gnu_bison")
load("@rules_hdl//dependency_support/org_gnu_glpk:org_gnu_glpk.bzl", "org_gnu_glpk")
load("@rules_hdl//dependency_support/org_gnu_gnulib:org_gnu_gnulib.bzl", "org_gnu_gnulib")
load("@rules_hdl//dependency_support/org_gnu_gperf:org_gnu_gperf.bzl", "org_gnu_gperf")
load("@rules_hdl//dependency_support/org_gnu_m4:org_gnu_m4.bzl", "org_gnu_m4")
load("@rules_hdl//dependency_support/org_gnu_readline:org_gnu_readline.bzl", "org_gnu_readline")
load("@rules_hdl//dependency_support/org_llvm_openmp:org_llvm_openmp.bzl", "org_llvm_openmp")
load("@rules_hdl//dependency_support/org_nixos_patchelf:org_nixos_patchelf.bzl", "org_nixos_patchelf")
load("@rules_hdl//dependency_support/org_pcre_ftp:org_pcre_ftp.bzl", "org_pcre_ftp")
load("@rules_hdl//dependency_support/org_sourceware_bzip2:org_sourceware_bzip2.bzl", "org_sourceware_bzip2")
load("@rules_hdl//dependency_support/org_sourceware_libffi:org_sourceware_libffi.bzl", "org_sourceware_libffi")
load("@rules_hdl//dependency_support/org_swig:org_swig.bzl", "org_swig")
load("@rules_hdl//dependency_support/org_theopenroadproject:org_theopenroadproject.bzl", "org_theopenroadproject")
load("@rules_hdl//dependency_support/org_theopenroadproject_asap7_pdk_r1p7:org_theopenroadproject_asap7_pdk_r1p7.bzl", "org_theopenroadproject_asap7_pdk_r1p7")
load("@rules_hdl//dependency_support/org_theopenroadproject_asap7sc6t_26:org_theopenroadproject_asap7sc6t_26.bzl", "org_theopenroadproject_asap7sc6t_26")
load("@rules_hdl//dependency_support/org_theopenroadproject_asap7sc7p5t_27:org_theopenroadproject_asap7sc7p5t_27.bzl", "org_theopenroadproject_asap7sc7p5t_27")
load("@rules_hdl//dependency_support/org_theopenroadproject_asap7sc7p5t_28:org_theopenroadproject_asap7sc7p5t_28.bzl", "org_theopenroadproject_asap7sc7p5t_28")
load("@rules_hdl//dependency_support/pybind11:pybind11.bzl", "pybind11")
load("@rules_hdl//dependency_support/tk_tcl:tk_tcl.bzl", "tk_tcl")
load("@rules_hdl//dependency_support/verilator:verilator.bzl", "verilator")

def dependency_support():
    """ Registers dependencies """
    at_clifford_icestorm()
    at_clifford_yosys()
    bazel_skylib()
    boost()
    com_github_fmtlib_fmt()
    com_github_gabime_spdlog()
    com_github_libbacktrace()
    com_github_ninja_build_ninja()
    com_github_quantamhd_lemon()
    com_github_westes_flex()
    com_github_yosyshq_nextpnr()
    com_github_yosyshq_prjtrellis()
    com_github_yosyshq_prjtrellis_db()
    com_google_absl()
    com_google_googletest()
    com_google_protobuf()
    com_google_ortools()
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
    org_gnu_glpk()
    org_gnu_gnulib()
    org_gnu_gperf()
    org_gnu_m4()
    org_gnu_readline()
    org_llvm_openmp()
    org_nixos_patchelf()
    org_pcre_ftp()
    org_sourceware_bzip2()
    org_sourceware_libffi()
    org_swig()
    org_theopenroadproject()
    org_theopenroadproject_asap7_pdk_r1p7()
    org_theopenroadproject_asap7sc6t_26()
    org_theopenroadproject_asap7sc7p5t_27()
    org_theopenroadproject_asap7sc7p5t_28()
    pybind11()
    tk_tcl()
    verilator()
