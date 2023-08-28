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

"""These build rules run automated GDS write on an implemented design"""

load("@rules_hdl//pdk:open_road_configuration.bzl", "assert_has_open_road_configuration", "get_open_road_configuration")
load("//place_and_route:open_road.bzl", "OpenRoadInfo")
load("//synthesis:build_defs.bzl", "SynthesisInfo")

def _gds_write_impl(ctx):
    # Throws an error if there is no OpenROAD configuration
    assert_has_open_road_configuration(ctx.attr.implemented_rtl[SynthesisInfo])
    open_road_configuration = get_open_road_configuration(ctx.attr.implemented_rtl[SynthesisInfo])

    final_gds = ctx.actions.declare_file("{}.gds".format(ctx.attr.name))

    # KLayout technology file
    tech_lef = ctx.attr.implemented_rtl[SynthesisInfo].standard_cell_info.tech_lef

    # Cell definitions LEFs
    cell_lef = ctx.attr.implemented_rtl[SynthesisInfo].standard_cell_info.cell_lef_definitions

    # Additional LEF files
    additional_lef = ctx.files.input_lef

    # Platform GDS files
    platform_gds = ctx.attr.implemented_rtl[SynthesisInfo].standard_cell_info.platform_gds

    # Additional GDS files
    additional_gds = ctx.files.input_gds

    all_lefs = cell_lef + additional_lef + [tech_lef]
    all_gds = platform_gds + additional_gds

    lef_args = " "
    for file in all_lefs:
        lef_args += " --input-lef {}".format(file.path)
    gds_args = " "
    for file in all_gds:
        gds_args += " --input-gds {}".format(file.path)
    gds_allow_empty_args = ""
    if ctx.attr.gds_allow_empty:
        gds_allow_empty_args = " --gds-allow-empty {}".format(ctx.attr.gds_allow_empty)

    klayout_lyt = open_road_configuration.klayout_tech_file.files.to_list()[0]
    if ctx.file.klayout_lyt:
        klayout_lyt = ctx.file.klayout_lyt

    ctx.actions.run_shell(
        outputs = [
            final_gds,
        ],
        inputs = depset(
            ctx.files.input_lef +
            ctx.files.input_gds +
            cell_lef +
            platform_gds +
            [
                ctx.attr.implemented_rtl[OpenRoadInfo].routed_def,
                klayout_lyt,
                tech_lef,
            ],
        ),
        command = "python {}".format(ctx.executable._gds_write.path) +
                  " --design-name {}".format(ctx.attr.implemented_rtl[SynthesisInfo].top_module) +
                  " --input-def {}".format(ctx.attr.implemented_rtl[OpenRoadInfo].routed_def.path) +
                  lef_args +
                  gds_args +
                  " --tech-file {}".format(klayout_lyt.path) +
                  gds_allow_empty_args +
                  " --out {}".format(final_gds.path),
        tools = depset([ctx.executable._gds_write]),
    )

    return [DefaultInfo(files = depset([final_gds]))]

gds_write = rule(
    implementation = _gds_write_impl,
    attrs = {
        "implemented_rtl": attr.label(mandatory = True, providers = [OpenRoadInfo, SynthesisInfo]),
        "klayout_lyt": attr.label(allow_single_file = True),
        "input_lef": attr.label_list(allow_files = True),
        "input_gds": attr.label_list(allow_files = True),
        "gds_allow_empty": attr.string(),
        "_gds_write": attr.label(
            cfg = "exec",
            executable = True,
            allow_files = True,
            default = Label("//gds_write:def2stream"),
        ),
    },
)
