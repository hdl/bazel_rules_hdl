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

def declare_cell_library(library_name):
    """This should be called from the BUILD file of a cell library
    workspace. It sets up the targets for the generated files of
    the given library."""
    native.exports_files(native.glob(["**/*"]))
    native.filegroup(
        name = "spice_models",
        srcs = native.glob(["**/*.spice"]),
        visibility = ["//visibility:public"],
    )
    library = CELL_LIBRARIES[library_name]
    corners = library.get("corners", {})
    for corner in corners:
        corner_types = library["corners"][corner]
        for corner_type in corner_types:
            out_path = "timing/%s__%s%s.lib" % (library_name, corner, _FILE_SUFFIX_BY_CORNER_TYPE[corner_type])
            native.genrule(
                name = "timing_%s_%s" % (corner, corner_type),
                visibility = ["//visibility:public"],
                outs = [out_path],
                srcs = native.glob(["**/*"]),
                message = "Generating %s timing files, %s corner %s" % (library_name, corner_type, corner),
                cmd = "$(location @com_google_skywater_pdk//:liberty) %s \"external/com_google_skywater_pdk_%s\" %s > /dev/null && mv \"external/com_google_skywater_pdk_%s/%s\" $@" % (_GENERATOR_ARGUMENT_BY_CORNER_TYPE[corner_type], library_name, corner, library_name, out_path),
                tools = ["@com_google_skywater_pdk//:liberty"],
            )
        native.filegroup(
            name = "timing_%s_all" % corner,
            visibility = ["//visibility:public"],
            srcs = [":timing_%s_%s" % (corner, corner_type) for corner_type in corner_types]
        )
    native.filegroup(
        name = "timing_all",
        visibility = ["//visibility:public"],
        srcs = [":timing_%s_all" % corner for corner in corners],
    )
