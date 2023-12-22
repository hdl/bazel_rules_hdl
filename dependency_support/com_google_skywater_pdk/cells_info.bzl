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

"""Standard cell options for SkyWater 130nm PDK."""

load("@rules_hdl//dependency_support/com_google_skywater_pdk:cell_libraries.bzl", "CELL_LIBRARIES")
load("@rules_hdl//pdk:build_defs.bzl", "StandardCellOptionsInfo", "check_for_each_cells_args", "temp_normalize", "voltage_normalize")

SKY130_OPTIONS = StandardCellOptionsInfo(
    libraries = [
        "sc_hd",
        #"sc_hdll",
        #"sc_hs",
        #"sc_ms",
        #"sc_ls",
        #"sc_lp",
        #"sc_hvl",
    ],
    vts = [],
    corners = list(sorted({
        cname.split("_")[0]: None
        for libname in CELL_LIBRARIES
        for cname in CELL_LIBRARIES[libname]["corners"]
    }.keys())),
    volts = list(sorted({
        voltage_normalize(cname.split("_")[2]): None
        for libname in CELL_LIBRARIES
        for cname in CELL_LIBRARIES[libname]["corners"]
    }.keys())),
    temps = list(sorted({
        temp_normalize(cname.split("_")[1]): None
        for libname in CELL_LIBRARIES
        for cname in CELL_LIBRARIES[libname]["corners"]
    }.keys())),
)

def sky130_cell_normalize(libname, corner_def):
    """Normalize a corner name.

    Args:
        libname: Name of the standard cell library (like `sc_hd`).
        corner_def: Skywater corner definitions (like `ff_100C_1v65`).

    Returns:
        The normalize name like `sky130-sc_hd-ff-0v123_m40c`

    """
    bits = corner_def.split("_")
    corner, temp, voltage = bits[:3]
    v_extra = ''
    if len(bits) > 3:
        v_extra += '_'
        if bits[3].startswith('lowhv'):
            v_extra += voltage_normalize(bits.pop(3)[6:])+'t'
        if len(bits) > 3 and bits[3].startswith('lv'):
            v_extra += 't'+voltage_normalize(bits.pop(3)[3:])
    if len(bits) > 3:
        fail("Found extra bits in corner definition {} (from '{}')".format(bits[3:], corner_def))

    temp = temp_normalize(temp)
    voltage = voltage_normalize(voltage)

    return "sky130-{n}-{c}-{v}_{t}".format(
        n = libname,
        c = corner,
        v = voltage+v_extra,
        t = temp,
    )

def for_each_sky130_cells(libname, include_vts = None, include_corners = None, include_volts = None, include_temps = None):
    """Generate a list of each standard cell library name.

    Args:
        libname: Libaray name like 'sc_hd'.
        include_vts: Unused for sky130.
        include_corners: 'all' or list of corners ('ff', 'tt', 'ss') to include in the output.
        include_volts: 'all' or list of voltages (in '0p55v' form) to include in the output.
        include_temps: 'all' or list of temperatures (in 'm40c' or '125c' form) to include in the output.

    Returns:
        A list of tuples containing a unique name for the cell library
        (suitable for usage in rule names) and the bazel target for the cell
        library.

        Example:
            ```
            [
                ("sky130-sc_hd-ff-0p605_125c", "@com_google_skywater_pdk_sky130_fd_sc_hd//:sky130-sc_hd-ff-0p605_125c"),
                ("sky130-sc_hd-ff-0p605_m40c", "@com_google_skywater_pdk_sky130_fd_sc_hd//:sky130-sc_hd-ff-0p605_m40c"),
                ....
            ]
            ```

    Use this to create bazel rules for every standard cell version like shown below;
        ```
        load("@rules_hdl//dependency_support/com_google_skywater_pdk:build_info.bzl", "for_each_sky130_cells")
        [
            extract_lef_and_liberty(
                name = cell_name + "-data",
                standard_cell = cell_target,
            )
            for cell_name, cell_target in for_each_sky130_cells('sc_hd', include_corners=['25c'])
        ]
        ```
    """
    kwargs = {
        "libname": libname,
        "include_vts": include_vts,
        "include_corners": include_corners,
        "include_volts": include_volts,
        "include_temps": include_temps,
    }
    check_for_each_cells_args(kwargs, SKY130_OPTIONS)

    # Iterate over all the options, skipping values not found in the include_XXX arguments.
    corners = {}
    for corner_def in CELL_LIBRARIES["sky130_fd_" + libname]["corners"]:
        corner, temp, voltage = corner_def.split("_", 3)

        temp = temp_normalize(temp)

        if "_" in voltage:
            voltage = voltage.split("_")[0]
        voltage = voltage_normalize(voltage)

        if corner not in kwargs["include_corners"]:
            continue

        if voltage not in kwargs["include_volts"]:
            continue

        if temp not in kwargs["include_temps"]:
            continue

        cell_name = sky130_cell_normalize(libname, corner_def)
        cell_target = "@com_google_skywater_pdk_sky130_fd_{l}//:{c}".format(l = libname, c = cell_name)
        corners[cell_name] = cell_target

    return list(sorted(corners.items()))
