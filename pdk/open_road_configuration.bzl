# Copyright 2021 Google LLC
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

"""Rules for defining OpenROAD configuration for various PDKs"""

OpenRoadPdkInfo = provider(
    "provider for openROAD configuration for a pdk",
    fields = {
        "cell_site": "LEF standard cell site name to use for floorplanning",
        "tracks_file": "Track setup script",
        "endcap_cell": "The endcap cell to use in place and route",
        "tap_cell": "The tap cell to use in the place and route.",
        "pin_horizontal_metal_layer": "",
        "pin_vertical_metal_layer": "",
        "tapcell_distance": "Number of sites ",
        "wire_rc_signal_metal_layer": "The metal layer to pull RC information for signal nets",
        "wire_rc_clock_metal_layer": "The metal layer to pull RC information for clock nets",
        "pdn_config": "PDN config",
        "global_placement_cell_pad": "Global placement cell padding to aide in routing",
        "do_not_use_cell_list": "Do not use cells in timing repair. This supports wild card * cell names",
        "cts_buffer_cell": "Clock Tree Buffer cell",
        "fill_cells": "Metal fill cells",
        "global_routing_layer_adjustments": "Global routing adjustment layers",
        "global_routing_clock_layers": "Clock routing layers",
        "global_routing_signal_layers": "Signal routing layers",
        "tie_low_port": "Tie low port",
        "tie_high_port": "Tie high port",
        "tie_separation": "Tie sepearation value",
        "rc_script_configuration": "RC script for the various metal layers",
        "tapcell_tcl": "TCL file that sets tapcell options. This overrides other tapcell attributes in this rule.",
        "placement_padding_tcl": "TCL Script for handling the placement padding of cells",
        "check_placement": "Check the placement in the placement script",
        "detailed_routing_configuration": "optional detailed routing configuration",
        "density_fill_config": "optional path to file with metal fill configuration",
        "klayout_tech_file": "KLayout technology file for GDS write",
    },
)

DetailedRoutingInfo = provider(
    "Detailed routing info params for OpenROAD",
    fields = ["bottom_routing_layer", "top_routing_layer", "via_in_pin_bottom_layer", "via_in_pin_top_layer", "enable_via_gen"],
)

def _open_road_pdk_configuration_impl(ctx):
    return [
        OpenRoadPdkInfo(
            cell_site = ctx.attr.cell_site,
            tracks_file = ctx.file.tracks_file,
            tap_cell = ctx.attr.tap_cell,
            pin_vertical_metal_layer = ctx.attr.pin_vertical_metal_layer,
            pin_horizontal_metal_layer = ctx.attr.pin_horizontal_metal_layer,
            tapcell_distance = ctx.attr.tapcell_distance,
            endcap_cell = ctx.attr.endcap_cell,
            pdn_config = ctx.file.pdn_config,
            wire_rc_signal_metal_layer = ctx.attr.wire_rc_signal_metal_layer,
            wire_rc_clock_metal_layer = ctx.attr.wire_rc_clock_metal_layer,
            global_placement_cell_pad = ctx.attr.global_placement_cell_pad,
            do_not_use_cell_list = ctx.attr.do_not_use_cell_list,
            cts_buffer_cell = ctx.attr.cts_buffer_cell,
            fill_cells = ctx.attr.fill_cells,
            global_routing_layer_adjustments = ctx.attr.global_routing_layer_adjustments,
            global_routing_clock_layers = ctx.attr.global_routing_clock_layers,
            global_routing_signal_layers = ctx.attr.global_routing_signal_layers,
            tie_low_port = ctx.attr.tie_low_port,
            tie_high_port = ctx.attr.tie_high_port,
            tie_separation = ctx.attr.tie_separation,
            rc_script_configuration = ctx.file.rc_script_configuration,
            tapcell_tcl = ctx.file.tapcell_tcl,
            placement_padding_tcl = ctx.file.placement_padding_tcl,
            check_placement = ctx.attr.check_placement,
            detailed_routing_configuration = ctx.attr.detailed_routing_configuration,
            density_fill_config = ctx.attr.density_fill_config,
            klayout_tech_file = ctx.attr.klayout_tech_file,
        ),
    ]

open_road_pdk_configuration = rule(
    implementation = _open_road_pdk_configuration_impl,
    attrs = {
        "cell_site": attr.string(mandatory = True, doc = "LEF standard cell site name."),
        "tracks_file": attr.label(mandatory = True, allow_single_file = True, doc = "Track setup script."),
        "pdn_config": attr.label(mandatory = True, allow_single_file = True, doc = "PDN Config."),
        "tap_cell": attr.string(),
        "pin_horizontal_metal_layer": attr.string(mandatory = True),
        "pin_vertical_metal_layer": attr.string(mandatory = True),
        "tapcell_distance": attr.int(),
        "endcap_cell": attr.string(),
        "wire_rc_signal_metal_layer": attr.string(mandatory = True),
        "wire_rc_clock_metal_layer": attr.string(mandatory = True),
        "global_placement_cell_pad": attr.int(mandatory = True),
        "do_not_use_cell_list": attr.string_list(mandatory = True, doc = "This value can be an empty list if all cells should be used in P&R"),
        "cts_buffer_cell": attr.string(mandatory = True, doc = "Clock Tree Buffer cell"),
        "fill_cells": attr.string_list(mandatory = True),
        "global_routing_layer_adjustments": attr.string_dict(mandatory = True),
        "global_routing_clock_layers": attr.string(mandatory = True),
        "global_routing_signal_layers": attr.string(mandatory = True),
        "tie_low_port": attr.string(mandatory = True),
        "tie_high_port": attr.string(mandatory = True),
        "tie_separation": attr.int(mandatory = True),
        "rc_script_configuration": attr.label(allow_single_file = True),
        "tapcell_tcl": attr.label(allow_single_file = True, doc = "TCL file that sets tapcell options. This overrides other tapcell attributes in this rule."),
        "placement_padding_tcl": attr.label(allow_single_file = True, doc = "TCL Script for handling the placement padding of cells"),
        "check_placement": attr.bool(mandatory = False, default = True),
        "detailed_routing_configuration": attr.label(providers = [DetailedRoutingInfo]),
        "density_fill_config": attr.label(allow_single_file = True),
        "klayout_tech_file": attr.label(mandatory = True, allow_single_file = True),
    },
)

def detailed_routing_configuration_impl(ctx):
    return [DetailedRoutingInfo(
        bottom_routing_layer = ctx.attr.bottom_routing_layer,
        top_routing_layer = ctx.attr.top_routing_layer,
        via_in_pin_bottom_layer = ctx.attr.via_in_pin_bottom_layer,
        via_in_pin_top_layer = ctx.attr.via_in_pin_top_layer,
        enable_via_gen = ctx.attr.enable_via_gen,
    )]

detailed_routing_configuration = rule(
    implementation = detailed_routing_configuration_impl,
    attrs = {
        "bottom_routing_layer": attr.string(mandatory = True, doc = "Minimum routing layer name"),
        "top_routing_layer": attr.string(mandatory = True, doc = "Maximum routing layer name"),
        "via_in_pin_bottom_layer": attr.string(doc = "via in pin bottom layer"),
        "via_in_pin_top_layer": attr.string(doc = "via in pin top layer"),
        "enable_via_gen": attr.bool(default = True),
    },
    provides = [DetailedRoutingInfo],
)

def assert_has_open_road_configuration(synthesis_info):
    """Asserts if PDK is missing openROAD configuration.

    Args:
        synthesis_info: bazel rule context.
    """
    if not get_open_road_configuration(synthesis_info):
        fail("The PDK used for synthesis does not have an OpenROAD configuration.")

def get_open_road_configuration(synthesis_info):
    """Returns the openROAD configuration for the synthesized netlist.

    Args:
        synthesis_info: SynthesisInfo provider to extract openROAD configuration from.

    Returns:
        OpenRoadPdkInfo: The openroad pdk information.
    """

    standard_cell_info = synthesis_info.standard_cell_info

    if not standard_cell_info:
        fail("This rule is missing the standard cell info attached to the synthesized verilog.")

    return standard_cell_info.open_road_configuration
