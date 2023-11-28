# Copyright 2023 Google LLC
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

##########################################################################
""" ASAP7 "rev 28" 7.5 track standard cell library with SRAM blocks. """
##########################################################################

asap7_srams_files(
    name = "asap7-srams-sc7p5t_rev28",
    rev = "28",
    tracks = "7p5t",
)

filegroup(
    name = "asap7-misc-sc7p5t_rev28-lef",
    srcs = ["techlef_misc/asap7_tech_1x_201209.lef"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "asap7-misc-sc7p5t_rev28_4x-lef",
    srcs = ["techlef_misc/asap7_tech_4x_201209.lef"],
)

# Default rev28 cell library is the RVT library using slow-slow corner with CCS
# modeling.
alias(
    name = "asap7-sc7p5t_rev28",
    actual = ":asap7-sc7p5t_rev28_rvt-ccs_ss",
    visibility = ["//visibility:public"],
)
