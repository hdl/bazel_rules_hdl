load("//pdk:open_road_configuration.bzl", "open_road_pdk_configuration")

package(
    default_applicable_licenses = ["//:package_license"],
    default_visibility = ["//visibility:private"],
)

exports_files([
    "pdk.patch",
    "fill.json",  # Imported from OpenROAD-flow-scripts on 24.07.2023 at 6ec980e1d49a1a8dcdd1e25ed81255b4bb8285c8 from: https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts/blob/6ec980e1d49a1a8dcdd1e25ed81255b4bb8285c8/flow/platforms/sky130hd/fill.json
    "sky130hd.lyt",  # Imported from OpenROAD-flow-scripts on 24.07.2023 at 6ec980e1d49a1a8dcdd1e25ed81255b4bb8285c8 from: https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts/blob/6ec980e1d49a1a8dcdd1e25ed81255b4bb8285c8/flow/platforms/sky130hd/sky130hd.lyt
])

open_road_pdk_configuration(
    name = "open_road_sky130_fd_sc_hd",
    cell_site = "unithd",
    cts_buffer_cell = "sky130_fd_sc_hd__clkbuf_1",
    density_fill_config = "fill.json",
    do_not_use_cell_list = [
        "sky130_fd_sc_hd__probe_p_*",
        "sky130_fd_sc_hd__probec_p_*",
    ],
    endcap_cell = "sky130_fd_sc_hd__decap_4",
    fill_cells = [
        "sky130_fd_sc_hd__fill_*",
    ],
    global_placement_cell_pad = 4,
    global_routing_clock_layers = "met3-met5",
    global_routing_layer_adjustments = {
        "met1": "0.5",
        "met2": "0.5",
        "met3": "0.5",
        "met4": "0.5",
        "met5": "0.5",
    },
    global_routing_signal_layers = "met1-met5",
    klayout_tech_file = "sky130hd.lyt",
    pdn_config = "pdn_config.pdn",
    pin_horizontal_metal_layer = "met3",
    pin_vertical_metal_layer = "met2",
    tap_cell = "sky130_fd_sc_hd__tapvpwrvgnd_1",
    tapcell_distance = 14,
    tie_high_port = "sky130_fd_sc_hd__conb_1/HI",
    tie_low_port = "sky130_fd_sc_hd__conb_1/LO",
    tie_separation = 5,
    tracks_file = "tracks.tcl",
    visibility = [
        "//visibility:public",
    ],
    wire_rc_clock_metal_layer = "met5",
    wire_rc_signal_metal_layer = "met2",
)
