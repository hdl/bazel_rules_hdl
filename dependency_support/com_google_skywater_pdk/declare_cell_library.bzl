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

"""Internal helper function that is used by the BUILD files for each
cell library workspace to set things up."""

load("@rules_hdl//dependency_support/com_google_skywater_pdk:build_defs.bzl", "skywater_cell_library", "skywater_corner")
load("@rules_hdl//dependency_support/com_google_skywater_pdk:cells_info.bzl", "sky130_cell_normalize")
load("//pdk:build_defs.bzl", "ADDER_TYPES")
load(":cell_libraries.bzl", "CELL_LIBRARIES")

def declare_cell_library(workspace_name, name):
    """This should be called from the BUILD file of a cell library workspace. It sets up the targets for the generated files of the given library.

    Args:
      workspace_name: The name of the skywater workspace
      name: The name of the top level standard cell library
    """
    native.filegroup(
        name = "spice_models",
        srcs = native.glob(["**/*.spice"]),
        visibility = ["//visibility:public"],
    )
    library = CELL_LIBRARIES[name]

    common_args = dict(
        srcs = native.glob(
            include = [
                "cells/**/*.lef",
                "cells/**/*.gds",
            ],
            # There are two types of lefs in the PDK. One for magic a layout
            # tool that requires some different properties set in the LEF that
            # are not always suitable for the downstream tools like OpenROAD
            # and yosys. We're basically just choosing that we want the normal
            # lefs instead of the magic ones.
            #
            # Currently this repo doesn't integrate magic into the flow. At
            # some point it will, and we'll need to somehow have both lefs, or
            # fix the lefs upstream. Just know that you may at some point in the
            # future need to modify this.
            exclude = [
                "cells/**/*.magic.lef",
            ],
        ),
        visibility = ["//visibility:public"],
        tech_lef = "tech/{}.tlef".format(name) if library.get("library_type", None) != "ip_library" else None,
    )

    corners = library.get("corners", {})
    all_corners = []
    for corner in corners:
        target_name = sky130_cell_normalize(name, corner).replace("sky130_fd_", "")
        corner_name = "corner-" + target_name
        all_corners.append(corner_name)

        # boolean values indicating ccsnoise and leakage information in this
        # corner.
        ccsnoise = "ccsnoise" in corners[corner]
        leakage = "leakage" in corners[corner]

        # Create the corner configuration
        skywater_corner(
            name = corner_name,
            corner = corner,
            visibility = ["//visibility:private"],
            srcs = native.glob([
                "cells/**/*.lib.json",
                "timing/*.lib.json",
            ]),
            standard_cell_name = name,
            with_ccsnoise = ccsnoise,
            with_leakage = leakage,
            standard_cell_root = "external/{}".format(workspace_name),
        )

        # Library with only just a single corner.
        corner_args = dict(
            process_corners = [":" + corner_name],
            default_corner = corner,
            **common_args
        )
        for add in ADDER_TYPES:
            if add == "opt":
                continue
            skywater_cell_library(
                name = target_name + "-" + add,
                openroad_configuration = str(library.get("open_road_configuration", None)) + "-" + add,
                **corner_args
            )
        native.alias(
            name = target_name + "-opt",
            actual = ":" + target_name + "-fa",
            visibility = ["//visibility:public"],
        )

    # Multi-corner library
    common_args = dict(
        process_corners = [":{}".format(corner) for corner in all_corners],
        default_corner = library.get("default_corner", ""),
        **common_args
    )
    for add in ADDER_TYPES:
        if add == "opt":
            continue
        skywater_cell_library(
            name = name + "-" + add,
            openroad_configuration = str(library.get("open_road_configuration", None)) + "-" + add,
            **common_args
        )

    # Map the "optimal" configuration to the full adder.
    native.alias(
        name = name + "-opt",
        actual = ":" + name + "-fa",
        visibility = ["//visibility:public"],
    )
    native.alias(
        name = name,
        actual = ":" + name + "-fa",
        visibility = ["//visibility:public"],
    )
