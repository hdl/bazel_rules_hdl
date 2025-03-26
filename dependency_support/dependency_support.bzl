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

load("//dependency_support/at_clifford_icestorm:at_clifford_icestorm.bzl", "at_clifford_icestorm")
load("//dependency_support/at_clifford_yosys:at_clifford_yosys.bzl", "at_clifford_yosys")
load("//dependency_support/bazel_skylib:bazel_skylib.bzl", "bazel_skylib")
load("//dependency_support/boost:boost.bzl", "boost")
load("//dependency_support/com_github_davidkebo_cudd:com_github_davidkebo_cudd.bzl", "com_github_davidkebo_cudd")
load("//dependency_support/com_github_fmtlib_fmt:com_github_fmtlib_fmt.bzl", "com_github_fmtlib_fmt")
load("//dependency_support/com_github_gabime_spdlog:com_github_gabime_spdlog.bzl", "com_github_gabime_spdlog")
load("//dependency_support/com_github_libbacktrace:com_github_libbacktrace.bzl", "com_github_libbacktrace")
load("//dependency_support/com_github_ninja_build_ninja:com_github_ninja_build_ninja.bzl", "com_github_ninja_build_ninja")
load("//dependency_support/com_github_quantamhd_lemon:com_github_quantamhd_lemon.bzl", "com_github_quantamhd_lemon")
load("//dependency_support/com_github_westes_flex:com_github_westes_flex.bzl", "com_github_westes_flex")
load("//dependency_support/com_github_yosyshq_nextpnr:com_github_yosyshq_nextpnr.bzl", "com_github_yosyshq_nextpnr")
load("//dependency_support/com_github_yosyshq_prjtrellis:com_github_yosyshq_prjtrellis.bzl", "com_github_yosyshq_prjtrellis")
load("//dependency_support/com_github_yosyshq_prjtrellis_db:com_github_yosyshq_prjtrellis_db.bzl", "com_github_yosyshq_prjtrellis_db")
load("//dependency_support/com_google_absl:com_google_absl.bzl", "com_google_absl")
load("//dependency_support/com_google_googletest:com_google_googletest.bzl", "com_google_googletest")
load("//dependency_support/com_google_ortools:com_google_ortools.bzl", "com_google_ortools")
load("//dependency_support/com_google_protobuf:com_google_protobuf.bzl", "com_google_protobuf")
load("//dependency_support/com_google_skywater_pdk:com_google_skywater_pdk.bzl", "com_google_skywater_pdk")
load("//dependency_support/com_icarus_iverilog:com_icarus_iverilog.bzl", "com_icarus_iverilog")
load("//dependency_support/com_opencircuitdesign_magic:com_opencircuitdesign_magic.bzl", "com_opencircuitdesign_magic")
load("//dependency_support/com_opencircuitdesign_netgen:com_opencircuitdesign_netgen.bzl", "com_opencircuitdesign_netgen")
load("//dependency_support/edu_berkeley_abc:edu_berkeley_abc.bzl", "edu_berkeley_abc")
load("//dependency_support/net_invisible_island_ncurses:net_invisible_island_ncurses.bzl", "net_invisible_island_ncurses")
load("//dependency_support/net_sourceforge_ngspice:net_sourceforge_ngspice.bzl", "net_sourceforge_ngspice")
load("//dependency_support/net_zlib:net_zlib.bzl", "net_zlib")
load("//dependency_support/org_fftw:org_fftw.bzl", "org_fftw")
load("//dependency_support/org_gnu_bison:org_gnu_bison.bzl", "org_gnu_bison")
load("//dependency_support/org_gnu_glpk:org_gnu_glpk.bzl", "org_gnu_glpk")
load("//dependency_support/org_gnu_gnulib:org_gnu_gnulib.bzl", "org_gnu_gnulib")
load("//dependency_support/org_gnu_gperf:org_gnu_gperf.bzl", "org_gnu_gperf")
load("//dependency_support/org_gnu_readline:org_gnu_readline.bzl", "org_gnu_readline")
load("//dependency_support/org_llvm_openmp:org_llvm_openmp.bzl", "org_llvm_openmp")
load("//dependency_support/org_nixos_patchelf:org_nixos_patchelf.bzl", "org_nixos_patchelf")
load("//dependency_support/org_pcre_ftp:org_pcre_ftp.bzl", "org_pcre_ftp")
load("//dependency_support/org_sourceware_bzip2:org_sourceware_bzip2.bzl", "org_sourceware_bzip2")
load("//dependency_support/org_sourceware_libffi:org_sourceware_libffi.bzl", "org_sourceware_libffi")
load("//dependency_support/org_swig:org_swig.bzl", "org_swig")
load("//dependency_support/org_theopenroadproject:org_theopenroadproject.bzl", "org_theopenroadproject")
load("//dependency_support/org_theopenroadproject_asap7_pdk_r1p7:org_theopenroadproject_asap7_pdk_r1p7.bzl", "org_theopenroadproject_asap7_pdk_r1p7")
load("//dependency_support/org_theopenroadproject_asap7sc6t_26:org_theopenroadproject_asap7sc6t_26.bzl", "org_theopenroadproject_asap7sc6t_26")
load("//dependency_support/org_theopenroadproject_asap7sc7p5t_27:org_theopenroadproject_asap7sc7p5t_27.bzl", "org_theopenroadproject_asap7sc7p5t_27")
load("//dependency_support/org_theopenroadproject_asap7sc7p5t_28:org_theopenroadproject_asap7sc7p5t_28.bzl", "org_theopenroadproject_asap7sc7p5t_28")
load("//dependency_support/rules_license:rules_license.bzl", "rules_license")
load("//dependency_support/tk_tcl:tk_tcl.bzl", "tk_tcl")
load("//dependency_support/verilator:verilator.bzl", "verilator")

# buildifier: disable=unnamed-macro
def dependency_support(register_toolchains = True):
    """Registers dependencies

    Args:
        register_toolchains (bool, optional): Register rules_hdl toolchains.
    """
    at_clifford_icestorm()
    at_clifford_yosys()
    bazel_skylib()
    boost()
    com_github_fmtlib_fmt()
    com_github_gabime_spdlog()
    com_github_davidkebo_cudd()
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
    rules_license()
    tk_tcl()
    verilator()

    if register_toolchains:
        native.register_toolchains(str(Label("//verilator:verilator_toolchain")))
