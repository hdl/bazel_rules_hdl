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

"""Standard cell options for the ASAP7 7nm predictive PDK."""

load("@rules_hdl//pdk:build_defs.bzl", "StandardCellOptionsInfo", "check_for_each_cells_args")

ASAP7_OPTIONS = StandardCellOptionsInfo(
    libraries = [
        "sc6t_rev26",
        "sc7p5t_rev27",
        "sc7p5t_rev28",
    ],
    vts = [
        "rvt",  # Regular VT -- Slowest
        "lvt",  # Low VT
        "slvt",  # Super low VT -- Fastest
    ],
    corners = [
        "ff",
        "tt",
        "ss",
    ],
    volts = [
        # ???
    ],
    temps = [
        # ???
    ],
)

def for_each_asap7_cells(libname, include_vts = None, include_corners = None, include_volts = None, include_temps = None):
    """Generate a list of each standard cell library name.

    Args:
        libname: Libaray name like 'h169l3p48'.
        include_vts: 'all' or list of vts ('rvt', 'lvt', 'slvt') to include in the output.
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
                ('asap7-sc7p5t_rev27_rvt-ccs_ss', '@org_theopenroadproject_asap7sc7p5t_27//:asap7-sc7p5t_rev27_rvt-ccs_ss'),
                ('asap7-sc7p5t_rev27_lvt-ccs_ss', '@org_theopenroadproject_asap7sc7p5t_27//:asap7-sc7p5t_rev27_lvt-ccs_ss'),
                ...
            ]
            ```
    Use this to create bazel rules for every standard cell version like shown below;
        ```
        load("//hardware/tools/open_road/asap7:build_info.bzl", "for_each_asap7_cells")
        [
            extract_lef_and_liberty(
                name = cell_name+"-data",
                standard_cell = cell_target,
            )
            for cell_name, cell_target in for_each_asap7_cells('sc7p5t_rev28', include_corners=['25c'])
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
    check_for_each_cells_args(kwargs, ASAP7_OPTIONS)

    # Iterate over all the options, skipping values not found in the include_XXX arguments.
    output = []
    for vt in ASAP7_OPTIONS.vts:
        if vt not in kwargs["include_vts"]:
            continue

        for corner in ASAP7_OPTIONS.corners:
            if corner not in kwargs["include_corners"]:
                continue

            # No voltage or temps for ASAP7

            # asap7-sc7p5t_rev27_rvt_4x
            cell_name = "asap7-{n}_{v}-ccs_{c}".format(
                n = libname,
                v = vt,
                c = corner,
            )

            libname_short = libname.replace("rev", "")

            # "@org_theopenroadproject_asap7sc7p5t_27//:asap7-sc7p5t_rev27_rvt-ccs_ss
            cell_target = "@org_theopenroadproject_asap7{}//:{}".format(libname_short, cell_name)
            output.append((cell_name, cell_target))
    return output
