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

"""Skywater 130 PDK support rules.

These rules generate PDK providers for downstream tools.
"""

load("@rules_hdl//pdk:build_defs.bzl", "CornerInfo", "StandardCellInfo")
load("@rules_hdl//pdk:open_road_configuration.bzl", "OpenRoadPdkInfo")

def _skywater_corner_impl(ctx):
    # Choose user supplied root, or default to build directory.
    standard_cell_root = ctx.attr.standard_cell_root

    # Choose the build target name as the corner first unless overwritten.
    corner = ctx.attr.corner if ctx.attr.corner else ctx.attr.name

    corner_suffix = ""

    args = ctx.actions.args()

    if ctx.attr.with_leakage:
        corner_suffix = "_pwrlkg"
        args.add("--leakage")

    if ctx.attr.with_ccsnoise:
        corner_suffix = "_ccsnoise"
        args.add("--ccsnoise")

    timing_output = ctx.actions.declare_file("timing/{}__{}{}.lib".format(
        ctx.attr.standard_cell_name,
        corner,
        corner_suffix,
    ))

    args.add_all("-o", [timing_output.dirname])
    args.add(standard_cell_root)
    args.add(corner)

    ctx.actions.run(
        outputs = [timing_output],
        inputs = ctx.files.srcs,
        arguments = [args],
        executable = ctx.executable._liberty_tool,
    )

    return [
        DefaultInfo(files = depset([timing_output])),
        CornerInfo(
            liberty = timing_output,
            with_ccsnoise = ctx.attr.with_ccsnoise,
            with_leakage = ctx.attr.with_leakage,
            corner_name = corner,
        ),
    ]

def _skywater_cell_library_impl(ctx):
    corners = dict([(dep[CornerInfo].corner_name, dep[CornerInfo]) for dep in ctx.attr.process_corners])

    open_road_configuration = None
    if ctx.attr.openroad_configuration:
        open_road_configuration = ctx.attr.openroad_configuration[OpenRoadPdkInfo]

    cell_lef_files = [lef_file for lef_file in ctx.files.srcs if lef_file.extension == "lef"]

    tech_lef = None
    if ctx.attr.tech_lef:
        tech_lef = ctx.file.tech_lef

    default_corner = corners.get(ctx.attr.default_corner, None)
    default_lib_depset = []
    if default_corner:
        default_lib_depset = [default_corner.liberty]

    return [
        DefaultInfo(files = depset(default_lib_depset)),
        StandardCellInfo(
            corners = corners,
            default_corner = default_corner,
            open_road_configuration = open_road_configuration,
            tech_lef = tech_lef,
            cell_lef_definitions = cell_lef_files,
        ),
    ]

skywater_cell_library = rule(
    implementation = _skywater_cell_library_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = True),
        "process_corners": attr.label_list(
            providers = [CornerInfo],
        ),
        "tech_lef": attr.label(allow_single_file = True, doc = "The tech lef file for these standard cells"),
        "default_corner": attr.string(mandatory = True),
        "openroad_configuration": attr.label(providers = [OpenRoadPdkInfo]),
    },
)

skywater_corner = rule(
    implementation = _skywater_corner_impl,
    attrs = {
        "srcs": attr.label_list(
            allow_files = True,
            allow_empty = False,
        ),
        "corner": attr.string(
            default = "",
            doc = "The selected process corner to generate liberty files for.",
        ),
        "standard_cell_root": attr.string(
            default = "",
            doc = "The root directory of the standard cell variants.",
            mandatory = True,
        ),
        "with_ccsnoise": attr.bool(
            default = False,
            doc = "Wheter to generate ccsnoise.",
        ),
        "standard_cell_name": attr.string(
            mandatory = True,
            doc = "The name of the standar cell variant ex. sky130_fd_sc_hd",
        ),
        "with_leakage": attr.bool(
            default = False,
            doc = "Wheter to generate leakage",
        ),
        "_liberty_tool": attr.label(
            default = Label("@com_google_skywater_pdk//:liberty"),
            executable = True,
            cfg = "exec",
        ),
    },
)
