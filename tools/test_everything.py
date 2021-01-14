#!/usr/bin/env python3
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

'''This script builds and tests everything that rules_hdl has.

This is what the CI builds do, and the script also works locally. Run it with
`tools/test_everything.py`.'''

import os
import subprocess
import sys

ALL_TARGETS = [
  '//...',
  '@at_clifford_icestorm//...',
  '@at_clifford_yosys//...',
  '@com_github_westes_flex//...',
  '@com_github_yosyshq_nextpnr//...',
  '@com_github_yosyshq_prjtrellis//...',
  '@com_github_yosyshq_prjtrellis_db//...',
  '@com_google_skywater_pdk//...',
  '@com_google_skywater_pdk_sky130_fd_sc_ms//...',
  '@com_google_skywater_pdk_sky130_fd_sc_ls//...',
  '@com_google_skywater_pdk_sky130_fd_sc_lp//...',
  '@com_google_skywater_pdk_sky130_fd_sc_hvl//...',
  '@com_google_skywater_pdk_sky130_fd_sc_hs//...',
  '@com_google_skywater_pdk_sky130_fd_sc_hdll//...',
  '@com_google_skywater_pdk_sky130_fd_sc_hd//...',
  '@com_google_skywater_pdk_sky130_fd_pr//...',
  '@com_google_skywater_pdk_sky130_fd_io//...',
  '@com_icarus_iverilog//...',
  '@com_opencircuitdesign_magic//...',
  '@com_opencircuitdesign_netgen//...',
  '@edu_berkeley_abc//...',
  '@net_sourceforge_ngspice//...',
  '@net_zlib//...',
  '@org_fftw//...',
  '@org_gnu_bison//...',
  '@org_gnu_gperf//...',
  '@org_gnu_m4//...',
  '@org_gnu_readline//...',
  '@org_sourceware_bzip2//...',
  '@org_sourceware_libffi//...',
  '@org_tuxfamily_eigen//...',
  '@pybind11//...',
  '@tk_tcl//...',
]

for action in ['build', 'test']:
  command = ' '.join([
    'bazel', action, os.environ.get('EXTRA_BAZEL_ARGS', ''), os.environ.get('EXTRA_%s_BAZEL_ARGS' % action.upper(), '')
  ] + ALL_TARGETS)
  print(command)
  return_code = subprocess.call(command, shell=True)
  if return_code != 0:
    sys.exit(return_code)
