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
""" ASAP7 "rev 26" 6 track standard cell library with SRAM blocks. """
##########################################################################

asap7_srams_files(
    name = "asap7-srams-sc6t_rev26",
    rev = "26",
    tracks = "6t",
)

# FIXME: Where is the 1x techlef?
#filegroup(
#    name = "asap7-misc-sc6t_rev26-lef",
#    srcs = ["techlef_misc/asap7sc6t_tech_4x_210831.lef"],
#)
alias(
    name = "asap7-misc-sc6t_rev26-lef",
    actual = "@org_theopenroadproject_asap7sc7p5t_28//:asap7-misc-sc7p5t_rev28-lef",
)

filegroup(
    name = "asap7-misc-sc6t_rev26_4x-lef",
    srcs = ["techlef_misc/asap7sc6t_tech_4x_210831.lef"],
)
