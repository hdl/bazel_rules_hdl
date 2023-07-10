"""ASAP7 PDK rules."""

load("@rules_hdl//pdk:build_defs.bzl", "CornerInfo", "StandardCellInfo")
load("@rules_hdl//pdk:open_road_configuration.bzl", "OpenRoadPdkInfo")

def _asap7_cell_library_impl(ctx):
    liberty_files = [file for file in ctx.files.srcs if file.extension == "gz"]
    liberty_files = [file for file in liberty_files if "_{}_".format(ctx.attr.default_corner_delay_model) in file.basename]
    liberty_files = [file for file in liberty_files if "SRAM" not in file.basename]
    liberty_files = [file for file in liberty_files if ctx.attr.cell_type in file.basename]

    uncompressed_files = []
    for file in liberty_files:
        uncompressed_file = ctx.actions.declare_file(file.basename[:-len(".gz")])
        ctx.actions.run_shell(
            outputs = [
                uncompressed_file,
            ],
            inputs = [
                file,
            ],
            command = "gunzip --to-stdout {compressed_file} > {uncompressed_file}".format(
                compressed_file = file.path,
                uncompressed_file = uncompressed_file.path,
            ),
        )

        uncompressed_files.append(uncompressed_file)

    default_corner_libraries = [file for file in uncompressed_files if "_{}_".format(ctx.attr.default_corner_swing) in file.basename]

    default_output_liberty = ctx.actions.declare_file("{}_{}.lib".format(ctx.attr.name, ctx.attr.default_corner_swing))

    args = ctx.actions.args()
    for file in default_corner_libraries:
        args.add("--liberty_files", file)
    args.add("--output", default_output_liberty)

    ctx.actions.run(
        outputs = [default_output_liberty],
        inputs = default_corner_libraries,
        arguments = [args],
        executable = ctx.executable._combine_liberty,
    )

    open_road_configuration = None
    if ctx.attr.openroad_configuration:
        open_road_configuration = ctx.attr.openroad_configuration[OpenRoadPdkInfo]

    return [
        DefaultInfo(files = depset([default_output_liberty] + default_corner_libraries)),
        StandardCellInfo(
            corners = [],
            cell_lef_definitions = [ctx.file.cell_lef],
            tech_lef = ctx.file.tech_lef,
            platform_gds = ctx.files.platform_gds,
            default_corner = CornerInfo(
                liberty = default_output_liberty,
            ),
            open_road_configuration = open_road_configuration,
        ),
    ]

asap7_cell_library = rule(
    implementation = _asap7_cell_library_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = True),
        "tech_lef": attr.label(allow_single_file = True, mandatory = True, doc = "The tech lef file for these standard cells"),
        "default_corner_swing": attr.string(mandatory = True, values = ["SS", "FF", "TT"]),
        "default_corner_delay_model": attr.string(mandatory = True, values = ["ccs", "ccsn", "ccsa"]),
        "cell_type": attr.string(mandatory = True, values = ["RVT", "LVT", "SLVT"]),
        #TODO(b/212480812): Support multiple VTs in a single design.
        "openroad_configuration": attr.label(providers = [OpenRoadPdkInfo]),
        "cell_lef": attr.label(allow_single_file = True, mandatory = True, doc = "The lef file for the standard cells"),
        "platform_gds": attr.label(allow_single_file = True, mandatory = True, doc = "Platform GDS files"),
        "_combine_liberty": attr.label(
            default = Label("@rules_hdl//pdk/liberty:combine_liberty"),
            executable = True,
            cfg = "exec",
        ),
    },
)
