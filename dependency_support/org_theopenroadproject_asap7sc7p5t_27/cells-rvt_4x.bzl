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
"""
Special 4x scaled version of the ASAP7 "rev 27" 7.5 track standard cell
library using regular VT transistors.
"""
##########################################################################

# Layouts for GDS generation
# ------------------------------------------------------------------------
# No GDS layouts for 4x cells

# Timing information (in compressed Liberty format) for synthesis and static
# timing analysis (STA).
# ------------------------------------------------------------------------
alias(
    name = "asap7-cells-sc7p5t_rev27_rvt_4x-lib7z",
    actual = ":asap7-cells-sc7p5t_rev27_rvt-lib7z",
)

# Verilog models for digital simulation and logical equivalence
# ------------------------------------------------------------------------
alias(
    name = "asap7-cells-sc7p5t_rev27_rvt_4x-v",
    actual = ":asap7-cells-sc7p5t_rev27_rvt-v",
)

# CDL models for LVS checking
# ------------------------------------------------------------------------
alias(
    name = "asap7-cells-sc7p5t_rev27_rvt_4x-lvs",
    actual = ":asap7-cells-sc7p5t_rev27_rvt-lvs",
)

# CDL models for Spice simulation
# ------------------------------------------------------------------------
alias(
    name = "asap7-cells-sc7p5t_rev27_rvt_4x-spice",
    actual = ":asap7-cells-sc7p5t_rev27_rvt-spice",
)

# Place and route
# ------------------------------------------------------------------------
filegroup(
    name = "asap7-cells-sc7p5t_rev27_rvt_4x-lef",
    srcs = ["LEF/scaled/asap7sc7p5t_27_R_4x_201211.lef"],
)

# Library configuration
# ------------------------------------------------------------------------
asap7_cell_library(
    name = "asap7-sc7p5t_rev27_rvt_4x",
    srcs = [
        ":asap7-cells-sc7p5t_rev27_rvt_4x-lib7z",
        #	":asap7-srams-sc7p5t_rev27_4x-lib7z",
    ],
    cell_lef = ":asap7-cells-sc7p5t_rev27_rvt_4x-lef",
    #    platform_gds = ":asap7-cells-sc7p5t_rev27_rvt_4x-gds",
    default_corner_delay_model = "ccs",
    default_corner_swing = "SS",
    openroad_configuration = ":open_road-asap7-sc7p5t_rev27_rvt_4x",
    tech_lef = ":asap7-misc-sc7p5t_rev27_4x-lef",
    visibility = [
        "//visibility:public",
    ],
)

# OpenROAD configuration
# ------------------------------------------------------------------------
open_road_pdk_configuration(
    name = "open_road-asap7-sc7p5t_rev27_rvt_4x",
    cell_site = "asap7sc7p5t",
    check_placement = False,
    cts_buffer_cell = "BUFx4_ASAP7_75t_R",
    do_not_use_cell_list = [
        "*x1_ASAP7*",
        "*x1p*_ASAP7*",
        "*xp*_ASAP7*",
        "SDF*",
        "ICG*",
        "DFFH*",
    ],
    endcap_cell = "TAPCELL_ASAP7_75t_R",
    fill_cells = [
        "FILLERxp5_ASAP7_75t_R",
        "DECAPx1_ASAP7_75t_R",
        "DECAPx2_ASAP7_75t_R",
        "DECAPx4_ASAP7_75t_R",
        "DECAPx6_ASAP7_75t_R",
        "DECAPx10_ASAP7_75t_R",
    ],
    global_placement_cell_pad = 2,
    global_routing_clock_layers = "M2-M7",
    global_routing_layer_adjustments = {
        "M2": "0.5",
        "M3": "0.5",
        "M4": "0.5",
        "M5": "0.5",
        "M6": "0.5",
        "M7": "0.5",
    },
    global_routing_signal_layers = "M2-M7",
    klayout_tech_file = "@rules_hdl//dependency_support/org_theopenroadproject_asap7_pdk_r1p7:asap7.lyt",
    pdn_config = "@rules_hdl//dependency_support/org_theopenroadproject_asap7_pdk_r1p7:pdn_config_4x.pdn",
    pin_horizontal_metal_layer = "M4",
    pin_vertical_metal_layer = "M5",
    rc_script_configuration = "@rules_hdl//dependency_support/org_theopenroadproject_asap7_pdk_r1p7:rc_script.tcl",
    tap_cell = "TAPCELL_ASAP7_75t_R",
    tapcell_distance = 25 * 4,  # We are using the by 4 variants of these cells.
    tie_high_port = "TIEHIx1_ASAP7_75t_R/H",
    tie_low_port = "TIELOx1_ASAP7_75t_R/L",
    tie_separation = 0,
    tracks_file = "@rules_hdl//dependency_support/org_theopenroadproject_asap7_pdk_r1p7:tracks.tcl",
    wire_rc_clock_metal_layer = "M5",
    wire_rc_signal_metal_layer = "M2",
)

##########################################################################
##########################################################################
