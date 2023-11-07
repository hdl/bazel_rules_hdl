"""ASAP7 PDK rules."""

load("@rules_hdl//pdk:build_defs.bzl", "CornerInfo", "StandardCellInfo")
load("@rules_hdl//pdk:open_road_configuration.bzl", "OpenRoadPdkInfo")


def asap7_srams_files(name=None, rev=None, tracks=None, has_gds=True):
    if rev not in ["26", "27", "28"]:
        fail("Invalid rev {}".format(repr(rev)))
    if tracks not in ["7p5t", "6t"]:
        fail("Invalid rev {}".format(repr(tracks)))

    args = {
        'rev': str(rev),
        'tracks': str(tracks),
    }

    # Layouts for GDS generation
    # ------------------------------------------------------------------------
    if has_gds:
        native.filegroup(
            name = "asap7-srams-sc{tracks}_rev{rev}-gds".format(**args),
            srcs = native.glob(["asap7sc{tracks}_{rev}/GDS/asap7sc{tracks}_{rev}*_SRAM_*.gds".format(**args)]),
        )

    # Timing information (in compressed Liberty format) for synthesis and static
    # timing analysis (STA).
    # ------------------------------------------------------------------------
    native.filegroup(
        name = "asap7-srams-sc{tracks}_rev{rev}-libgz".format(**args),
        srcs = native.glob(["asap7sc{tracks}_{rev}/LIB/CCS/*SRAM*.lib.gz".format(**args)]),
    )

    # Verilog models for digital simulation and logical equivalence
    # ------------------------------------------------------------------------
    native.filegroup(
        name = "asap7-srams-sc{tracks}_rev{rev}-v".format(**args),
        srcs = native.glob(["asap7sc{tracks}_{rev}/Verilog/asap7sc{tracks}_*_SRAM_*.v".format(**args)]),
    )

    # CDL models for LVS checking
    # ------------------------------------------------------------------------
    native.filegroup(
        name = "asap7-srams-sc{tracks}_rev{rev}-lvs".format(**args),
        srcs = ["asap7sc{tracks}_{rev}/CDL/LVS/asap7sc{tracks}_{rev}_*SRAM*.cdl".format(**args)],
    )

    # CDL models for Spice simulation
    # ------------------------------------------------------------------------
    native.filegroup(
        name = "asap7-srams-sc{tracks}_rev{rev}-spice".format(**args),
        srcs = ["asap7sc{tracks}_{rev}/CDL/xAct3D_extracted/asap7sc{tracks}_{rev}_*SRAM*.sp".format(**args)],
    )

    # Place and route
    # ------------------------------------------------------------------------
    native.filegroup(
        name = "asap7-srams-sc{tracks}_rev{rev}-lef".format(**args),
        srcs = ["asap7sc{tracks}_{rev}/LEF/asap7sc{tracks}_{rev}*_SRAM_*.lef".format(**args)],
    )


def asap7_cells_files(name=None, rev=None, tracks=None, vt=None, has_gds=True):
    if rev not in ["26", "27", "28"]:
        fail("Invalid rev {}".format(repr(rev)))
    if tracks not in ["7p5t", "6t"]:
        fail("Invalid tracks {}".format(repr(tracks)))
    if vt not in ["lvt", "rvt", "slvt"]:
        fail("Invalid vt {}".format(repr(vt)))

    args = {
        'rev': rev,
        'tracks': tracks,
        'vt_long': vt,
        'vt_upper': vt.upper(),
        'vt_short': {'rvt': 'R', 'lvt': 'L', 'slvt': 'SL'}[vt],
    }

    # Layouts for GDS generation
    # ------------------------------------------------------------------------
    if has_gds:
        native.filegroup(
            name = "asap7-cells-sc{tracks}_rev{rev}_{vt_long}-gds".format(**args),
            srcs = native.glob(["asap7sc{tracks}_{rev}/GDS/asap7sc{tracks}_{rev}_{vt_short}*.gds".format(**args)]),
        )

    # Timing information (in compressed Liberty format) for synthesis and static
    # timing analysis (STA).
    # ------------------------------------------------------------------------
    native.filegroup(
        name = "asap7-cells-sc{tracks}_rev{rev}_{vt_long}-libgz".format(**args),
        srcs = native.glob(["asap7sc{tracks}_{rev}/LIB/CCS/*_{vt_upper}_*.lib.gz".format(**args)]),
    )

    # Verilog models for digital simulation and logical equivalence
    # ------------------------------------------------------------------------
    native.filegroup(
        name = "asap7-cells-sc{tracks}_rev{rev}_{vt_long}-v".format(**args),
        srcs = native.glob(["asap7sc{tracks}_{rev}/Verilog/asap7sc{tracks}_*_{vt_upper}_*.v".format(**args)]),
    )

    # CDL models for LVS checking
    # ------------------------------------------------------------------------
    native.filegroup(
        name = "asap7-cells-sc{tracks}_rev{rev}_{vt_long}-lvs".format(**args),
        srcs = native.glob(["asap7sc{tracks}_{rev}/CDL/LVS/asap7sc{tracks}_{rev}_{vt_short}.cdl".format(**args)]),
    )

    # CDL models for Spice simulation
    # ------------------------------------------------------------------------
    native.filegroup(
        name = "asap7-cells-sc{tracks}_rev{rev}_{vt_long}-spice".format(**args),
        srcs = native.glob(["asap7sc{tracks}_{rev}/CDL/xAct3D_extracted/asap7sc{tracks}_{rev}_{vt_short}.sp".format(**args)]),
    )

    # Place and route
    # ------------------------------------------------------------------------
    native.filegroup(
        name = "asap7-cells-sc{tracks}_rev{rev}_{vt_long}-lef".format(**args),
        srcs = native.glob(["asap7sc{tracks}_{rev}/LEF/asap7sc{tracks}_{rev}_{vt_short}_1x*.lef".format(**args)]),
    )

    # Library configuration
    # ------------------------------------------------------------------------
    asap7_cell_library(
        name = "asap7-sc{tracks}_rev{rev}_{vt_long}".format(**args),
        srcs = [
            ":asap7-cells-sc{tracks}_rev{rev}_{vt_long}-libgz".format(**args),
            #":asap7-srams-sc{tracks}_rev{rev}-libgz".format(**args),
        ],
        cell_lef = ":asap7-cells-sc{tracks}_rev{rev}_{vt_long}-lef".format(**args),
        platform_gds = ":asap7-cells-sc{tracks}_rev{rev}_{vt_long}-gds".format(**args),
        default_corner_delay_model = "ccs",
        default_corner_swing = "SS",
        openroad_configuration = ":open_road-asap7-sc{tracks}_rev{rev}_{vt_long}".format(**args),
        tech_lef = ":asap7-misc-sc{tracks}_rev{rev}-lef".format(**args),
        visibility = [
            "//visibility:public",
        ]
    )


def _asap7_cell_library_impl(ctx):
    liberty_files = [file for file in ctx.files.srcs if file.extension == "gz"]
    liberty_files = [file for file in liberty_files if "_{}_".format(ctx.attr.default_corner_delay_model) in file.basename]
    liberty_files = [file for file in liberty_files if "SRAM" not in file.basename]

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
        #TODO(b/212480812): Support multiple VTs in a single design.
        "openroad_configuration": attr.label(providers = [OpenRoadPdkInfo]),
        "cell_lef": attr.label(allow_single_file = True, mandatory = True, doc = "The lef file for the standard cells"),
        "platform_gds": attr.label(allow_single_file = True, mandatory = False, doc = "Platform GDS files"),
        "_combine_liberty": attr.label(
            default = Label("@rules_hdl//pdk/liberty:combine_liberty"),
            executable = True,
            cfg = "exec",
        ),
    },
)
