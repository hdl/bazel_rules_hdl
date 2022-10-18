"""These build rules run a full hardware tools flow"""

load("@rules_hdl//pdk:build_defs.bzl", "StandardCellInfo")

def _extract_lef_and_liberty_impl(ctx):
    standard_cell = ctx.attr.standard_cell[StandardCellInfo]
    open_road_configuration = standard_cell.open_road_configuration

    content = []

    for file in standard_cell.cell_lef_definitions:
        content.append("cell_lef_paths: \"{}\"".format(file.short_path))

    content.append("tech_lef_path: \"{}\"".format(standard_cell.tech_lef.short_path))

    content.append("liberty_path: \"{}\"".format(standard_cell.default_corner.liberty.short_path))

    content.append("tracks_file_path: \"{}\"".format(
        open_road_configuration.tracks_file.short_path,
    ))

    content.append("pin_horizontal_metal_layer: \"{}\"".format(
        open_road_configuration.pin_horizontal_metal_layer,
    ))

    content.append("pin_vertical_metal_layer: \"{}\"".format(
        open_road_configuration.pin_vertical_metal_layer,
    ))

    if open_road_configuration.tap_cell:
        content.append("tap_cell: \"{}\"".format(open_road_configuration.tap_cell))

    if open_road_configuration.tapcell_distance:
        content.append("tapcell_distance: {}".format(open_road_configuration.tapcell_distance))

    if open_road_configuration.endcap_cell:
        content.append("endcap_cell: \"{}\"".format(open_road_configuration.endcap_cell))

    if open_road_configuration.tapcell_tcl:
        content.append("tapcell_tcl_path: \"{}\"".format(
            open_road_configuration.tapcell_tcl.short_path,
        ))

    if open_road_configuration.placement_padding_tcl:
        content.append("placement_padding_tcl_path: \"{}\"".format(
            open_road_configuration.placement_padding_tcl.short_path,
        ))

    content.append("pdn_config_path: \"{}\"".format(open_road_configuration.pdn_config.short_path))

    content.append("wire_rc_signal_metal_layer: \"{}\"".format(
        open_road_configuration.wire_rc_signal_metal_layer,
    ))

    content.append("wire_rc_clock_metal_layer: \"{}\"".format(
        open_road_configuration.wire_rc_clock_metal_layer,
    ))

    content.append("global_placement_cell_pad: {}".format(
        open_road_configuration.global_placement_cell_pad,
    ))

    for do_not_use_cell in open_road_configuration.do_not_use_cell_list:
        content.append("do_not_use_cell_list: \"{}\"".format(do_not_use_cell))

    content.append("tie_separation: {}".format(open_road_configuration.tie_separation))

    content.append("tie_high_port: \"{}\"".format(open_road_configuration.tie_high_port))

    content.append("tie_low_port: \"{}\"".format(open_road_configuration.tie_low_port))

    if open_road_configuration.rc_script_configuration:
        content.append("rc_script_configuration_path: \"{}\"".format(
            open_road_configuration.rc_script_configuration.short_path,
        ))

    content.append("cts_buffer_cell: \"{}\"".format(open_road_configuration.cts_buffer_cell))

    for fill_cell in open_road_configuration.fill_cells:
        content.append("fill_cells: \"{}\"".format(fill_cell))

    for layer, value in open_road_configuration.global_routing_layer_adjustments.items():
        content.append(
            "global_routing_layer_adjustments: {{ key: \"{layer}\" value: {value} }}".format(
                layer = layer,
                value = value,
            ),
        )

    content.append("global_routing_signal_layers: \"{}\"".format(
        open_road_configuration.global_routing_signal_layers,
    ))

    content.append("global_routing_clock_layers: \"{}\"".format(
        open_road_configuration.global_routing_clock_layers,
    ))

    content.append("cell_site: \"{}\"".format(open_road_configuration.cell_site))

    pdk_info_textproto = ctx.actions.declare_file("{}_pdk_info.textproto".format(ctx.attr.name))
    ctx.actions.write(pdk_info_textproto, "\n".join(content))

    out_files = [
        standard_cell.tech_lef,
        standard_cell.default_corner.liberty,
        open_road_configuration.tracks_file,
        open_road_configuration.pdn_config,
        pdk_info_textproto,
    ] + standard_cell.cell_lef_definitions

    if open_road_configuration.rc_script_configuration:
        out_files.append(open_road_configuration.rc_script_configuration)

    return DefaultInfo(
        files = depset(out_files),
        runfiles = ctx.runfiles(files = out_files),
    )

extract_lef_and_liberty = rule(
    implementation = _extract_lef_and_liberty_impl,
    attrs = {
        "standard_cell": attr.label(providers = [StandardCellInfo]),
    },
)
