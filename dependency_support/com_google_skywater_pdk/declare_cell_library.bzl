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

load(":cell_libraries.bzl", "CELL_LIBRARIES")
load("@rules_hdl//pdk/skywater130:build_defs.bzl", "skywater_cell_library", "skywater_corner")

_FILE_SUFFIX_BY_CORNER_TYPE = {
    "basic": "",
    "ccsnoise": "_ccsnoise",
    "leakage": "_pwrlkg",
}

_GENERATOR_ARGUMENT_BY_CORNER_TYPE = {
    "basic": "",
    "ccsnoise": "--ccsnoise",
    "leakage": "--leakage",
}

def declare_cell_library(workspace_name, library_name):
    """This should be called from the BUILD file of a cell library
    workspace. It sets up the targets for the generated files of
    the given library."""
    native.filegroup(
        name = "spice_models",
        srcs = native.glob(["**/*.spice"]),
        visibility = ["//visibility:public"],
    )
    library = CELL_LIBRARIES[library_name]
    corners = library.get("corners", {})
    for corner in corners:
        ccsnoise = "ccsnoise" in corners[corner]
        leakage = ccsnoise
        skywater_corner(
            name = "{}".format(corner),
            visibility = ["//visibility:private"],
            srcs = native.glob([
                "cells/**/*.lib.json",
                "timing/*.lib.json",
            ]),
            standard_cell_name = library_name,
            ccsnoise = ccsnoise,
            leakage = leakage,
            standard_cell_root = "external/{}".format(workspace_name),
        )
    skywater_cell_library(
        name = library_name,
        process_corners = [":{}".format(corner) for corner in corners],
        default_corner = library.get("default_corner", ""),
    )
