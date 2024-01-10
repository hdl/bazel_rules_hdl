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

""" ASAP7 "rev 27" 7.5 track standard cell library using Low VT transistors """

# ------------------------------------------------------------------------
asap7_cells_files(
    name = "asap7-cells-sc7p5t_rev27_lvt",
    has_gds = False,
    rev = "27",
    tracks = "7p5t",
    vt = "lvt",
)

_sc7p5t_rev27_lvt_open_road_pdk_configuration_common = dict(
    cell_site = "asap7sc7p5t",
    cts_buffer_cell = "BUFx4_ASAP7_75t_L",
    do_not_use_cell_list = [
        "*x1_ASAP7*",
        "*x1p*_ASAP7*",
        "*xp*_ASAP7*",
        "SDF*",
        "ICG*",
        "DFFH*",
    ],
    endcap_cell = "TAPCELL_ASAP7_75t_L",
    fill_cells = [
        "FILLERxp5_ASAP7_75t_L",
        "DECAPx1_ASAP7_75t_L",
        "DECAPx2_ASAP7_75t_L",
        "DECAPx4_ASAP7_75t_L",
        "DECAPx6_ASAP7_75t_L",
        "DECAPx10_ASAP7_75t_L",
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
    pdn_config = "@rules_hdl//dependency_support/org_theopenroadproject_asap7_pdk_r1p7:pdn_config_1x.pdn",
    pin_horizontal_metal_layer = "M4",
    pin_vertical_metal_layer = "M5",
    rc_script_configuration = "@rules_hdl//dependency_support/org_theopenroadproject_asap7_pdk_r1p7:rc_script_1x.tcl",
    tap_cell = "TAPCELL_ASAP7_75t_L",
    tapcell_distance = 25,
    tie_high_port = "TIEHIx1_ASAP7_75t_L/H",
    tie_low_port = "TIELOx1_ASAP7_75t_L/L",
    tie_separation = 0,
    tracks_file = "@rules_hdl//dependency_support/org_theopenroadproject_asap7_pdk_r1p7:tracks_1x.tcl",
    visibility = ["//visibility:public"],
    wire_rc_clock_metal_layer = "M5",
    wire_rc_signal_metal_layer = "M2",
)

make_open_road_pdk_configuration(
    name = "open_road-asap7-sc7p5t_rev27_lvt-nofa",
    common = _sc7p5t_rev27_lvt_open_road_pdk_configuration_common,
)

make_open_road_pdk_configuration(
    name = "open_road-asap7-sc7p5t_rev27_lvt-fa",
    common = _sc7p5t_rev27_lvt_open_road_pdk_configuration_common,
    ha_fa_mapping = "@rules_hdl//dependency_support/org_theopenroadproject_asap7_pdk_r1p7:cell_adders_L.v",
)

# FIXME: Add in the adder mappers
[
    alias(
        name = "open_road-asap7-sc7p5t_rev27_lvt-" + add,
        actual = ":open_road-asap7-sc7p5t_rev27_lvt-fa",
        visibility = ["//visibility:public"],
    )
    for add in ADDER_MAPPINGS
]

# Map the "optimal" configuration to the full adder
alias(
    name = "open_road-asap7-sc7p5t_rev27_lvt-opt",
    actual = ":open_road-asap7-sc7p5t_rev27_lvt-fa",
    visibility = ["//visibility:public"],
)
