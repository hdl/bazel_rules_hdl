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

"""Has metadata about the cell libraries in the PDK.

This is used by the Bazel rules to set up the proper workspaces and targets."""

# The following is a list of cell libraries in the PDK. Each cell library has the
# git commit to use and a list of process corners.
#
# This list is manually curated and needs to be updated when upgrading to newer
# cell library versions.
CELL_LIBRARIES = {
    "sky130_fd_io": {
        "commit": "7ec511f1a4689e174c63b3964d1ba8da9a3565e5",  # v0.2.1, 2020-12-09
        "shallow_since": "1606239275 -0800",
    },
    "sky130_fd_pr": {
        "commit": "f62031a1be9aefe902d6d54cddd6f59b57627436",  # v0.20.1, 2020-12-09
        "shallow_since": "1605038979 -0800",
    },
    "sky130_fd_sc_hd": {
        "commit": "ac7fb61f06e6470b94e8afdf7c25268f62fbd7b1",  # v0.0.2, 2020-12-04
        "shallow_since": "1605028103 -0800",
        "corners": {
            "ff_100C_1v65": ["basic"],
            "ff_100C_1v95": ["basic"],
            "ff_n40C_1v56": ["basic"],
            "ff_n40C_1v65": ["basic"],
            "ff_n40C_1v76": ["basic"],
            "ff_n40C_1v95": ["basic", "ccsnoise"],
            "ss_100C_1v40": ["basic"],
            "ss_100C_1v60": ["basic"],
            "ss_n40C_1v28": ["basic"],
            "ss_n40C_1v35": ["basic"],
            "ss_n40C_1v40": ["basic"],
            "ss_n40C_1v44": ["basic"],
            "ss_n40C_1v60": ["basic", "ccsnoise"],
            "ss_n40C_1v76": ["basic"],
            "tt_025C_1v80": ["basic"],
            "tt_100C_1v80": ["basic"],
        },
        "default_corner": "ff_100C_1v95",
    },
    "sky130_fd_sc_hdll": {
        "commit": "0694bd23893de20f5233ef024acf6cca1e750ac6",  # v0.1.1, 2020-12-04
        "shallow_since": "1604475910 -0800",
        "corners": {
            "ff_100C_1v65": ["basic"],
            "ff_100C_1v95": ["basic"],
            "ff_n40C_1v56": ["basic"],
            "ff_n40C_1v65": ["basic"],
            "ff_n40C_1v95": ["basic", "ccsnoise"],
            "ss_100C_1v60": ["basic"],
            "ss_n40C_1v28": ["basic"],
            "ss_n40C_1v44": ["basic"],
            "ss_n40C_1v60": ["basic", "ccsnoise"],
            "ss_n40C_1v76": ["basic"],
            "tt_025C_1v80": ["basic"],
        },
        "default_corner": "ff_100C_1v95",
    },
    "sky130_fd_sc_hs": {
        "commit": "1d051f49bfe4e2fe9108d702a8bc2e9c081005a4",  # v0.0.2, 2020-12-04
        "shallow_since": "1605574092 -0800",
        "corners": {
            "ff_100C_1v95": ["basic"],
            "ff_150C_1v95": ["basic"],
            "ff_n40C_1v56": ["basic"],
            "ff_n40C_1v76": ["basic"],
            "ff_n40C_1v95": ["basic", "ccsnoise"],
            "ss_100C_1v60": ["basic"],
            "ss_150C_1v60": ["basic"],
            "ss_n40C_1v28": ["basic"],
            "ss_n40C_1v44": ["basic"],
            "ss_n40C_1v60": ["basic", "ccsnoise"],
            "tt_025C_1v20": ["basic"],
            "tt_025C_1v35": ["basic"],
            "tt_025C_1v44": ["basic"],
            "tt_025C_1v50": ["basic"],
            "tt_025C_1v62": ["basic"],
            "tt_025C_1v68": ["basic"],
            "tt_025C_1v80": ["basic", "ccsnoise"],
            "tt_025C_1v89": ["basic"],
            "tt_025C_2v10": ["basic"],
            "tt_100C_1v80": ["basic"],
            "tt_150C_1v80": ["basic"],
        },
        "default_corner": "ff_100C_1v95",
    },
    "sky130_fd_sc_hvl": {
        "commit": "4fd4f858d16c558a6a488b200649e909bb4dd800",  # v0.0.3, 2020-12-04
        "shallow_since": "1604476031 -0800",
        "corners": {
            "ff_085C_5v50": ["basic"],
            "ff_085C_5v50_lv1v95": ["basic"],
            "ff_100C_5v50": ["basic"],
            "ff_100C_5v50_lowhv1v65_lv1v95": ["basic"],
            "ff_100C_5v50_lv1v95": ["basic"],
            "ff_150C_5v50": ["basic"],
            "ff_150C_5v50_lv1v95": ["basic"],
            "ff_n40C_4v40": ["basic"],
            "ff_n40C_4v40_lv1v95": ["basic"],
            "ff_n40C_4v95": ["basic"],
            "ff_n40C_4v95_lv1v95": ["basic"],
            "ff_n40C_5v50": ["basic", "ccsnoise"],
            "ff_n40C_5v50_lowhv1v65_lv1v95": ["basic"],
            "ff_n40C_5v50_lv1v95": ["basic", "ccsnoise"],
            "hvff_lvss_100C_5v50_lowhv1v65_lv1v60": ["basic"],
            "hvff_lvss_100C_5v50_lv1v40": ["basic"],
            "hvff_lvss_100C_5v50_lv1v60": ["basic"],
            "hvff_lvss_n40C_5v50_lowhv1v65_lv1v60": ["basic"],
            "hvff_lvss_n40C_5v50_lv1v35": ["basic"],
            "hvff_lvss_n40C_5v50_lv1v60": ["basic"],
            "hvss_lvff_100C_1v65": ["basic"],
            "hvss_lvff_100C_1v95": ["basic"],
            "hvss_lvff_100C_1v95_lowhv1v65": ["basic"],
            "hvss_lvff_100C_5v50_lowhv1v65_lv1v95": ["basic"],
            "hvss_lvff_n40C_1v65": ["basic"],
            "hvss_lvff_n40C_1v95": ["basic"],
            "hvss_lvff_n40C_1v95_lowhv1v65": ["basic"],
            "hvss_lvff_n40C_5v50_lowhv1v65_lv1v95": ["basic"],
            "ss_100C_1v65": ["basic"],
            "ss_100C_1v65_lv1v40": ["basic"],
            "ss_100C_1v65_lv1v60": ["basic"],
            "ss_100C_1v95": ["basic"],
            "ss_100C_2v40_lowhv1v65_lv1v60": ["basic"],
            "ss_100C_2v70_lowhv1v65_lv1v60": ["basic"],
            "ss_100C_3v00": ["basic"],
            "ss_100C_3v00_lowhv1v65_lv1v60": ["basic"],
            "ss_100C_5v50_lowhv1v65_lv1v60": ["basic"],
            "ss_150C_1v65": ["basic"],
            "ss_150C_1v65_lv1v60": ["basic"],
            "ss_150C_3v00_lowhv1v65_lv1v60": ["basic"],
            "ss_n40C_1v32": ["basic"],
            "ss_n40C_1v32_lv1v28": ["basic"],
            "ss_n40C_1v49": ["basic"],
            "ss_n40C_1v49_lv1v44": ["basic"],
            "ss_n40C_1v65": ["basic", "ccsnoise"],
            "ss_n40C_1v65_lv1v35": ["basic"],
            "ss_n40C_1v65_lv1v40": ["basic"],
            "ss_n40C_1v65_lv1v60": ["basic", "ccsnoise"],
            "ss_n40C_1v95": ["basic"],
            "ss_n40C_5v50_lowhv1v65_lv1v60": ["basic"],
            "tt_025C_2v64_lv1v80": ["basic"],
            "tt_025C_2v97_lv1v80": ["basic"],
            "tt_025C_3v30": ["basic"],
            "tt_025C_3v30_lv1v80": ["basic"],
            "tt_100C_3v30": ["basic"],
            "tt_100C_3v30_lv1v80": ["basic"],
            "tt_150C_3v30_lv1v80": ["basic"],
        },
        "default_corner": "ss_100C_1v95",
    },
    "sky130_fd_sc_lp": {
        "commit": "e2c1e0646999163d35ea7b2521c3ec5c28633e63",  # v0.0.2, 2020-12-04
        "shallow_since": "1604476084 -0800",
        "corners": {
            "ff_100C_1v95": ["basic"],
            "ff_125C_3v15": ["basic"],
            "ff_140C_1v95": ["basic"],
            "ff_150C_2v05": ["basic"],
            "ff_n40C_1v56": ["basic"],
            "ff_n40C_1v76": ["basic"],
            "ff_n40C_1v95": ["basic"],
            "ff_n40C_2v05": ["basic"],
            "ss_100C_1v60": ["basic"],
            "ss_140C_1v65": ["basic"],
            "ss_150C_1v65": ["basic"],
            "ss_n40C_1v55": ["basic"],
            "ss_n40C_1v60": ["basic"],
            "ss_n40C_1v65": ["basic"],
        },
        "default_corner": "ff_100C_1v95",
    },
    "sky130_fd_sc_ls": {
        "commit": "4f549e30dd91a1c264f8895e07b2872fe410a8c2",  # v0.1.1, 2020-12-04
        "shallow_since": "1604476021 -0800",
        "corners": {
            "ff_085C_1v95": ["basic"],
            "ff_100C_1v65_dest1v76_destvpb1v76_ka1v76": ["basic"],
            "ff_100C_1v95": ["basic"],
            "ff_150C_1v95": ["basic"],
            "ff_n40C_1v56": ["basic"],
            "ff_n40C_1v65_dest1v76_destvpb1v76_ka1v76": ["basic"],
            "ff_n40C_1v76": ["basic"],
            "ff_n40C_1v95": ["basic", "ccsnoise"],
            "ss_100C_1v40": ["basic"],
            "ss_100C_1v60": ["basic"],
            "ss_150C_1v60": ["basic"],
            "ss_n40C_1v28": ["basic"],
            "ss_n40C_1v35": ["basic"],
            "ss_n40C_1v40": ["basic"],
            "ss_n40C_1v44": ["basic"],
            "ss_n40C_1v60": ["basic", "ccsnoise"],
            "ss_n40C_1v76": ["basic"],
            "tt_025C_1v80": ["basic", "ccsnoise"],
            "tt_100C_1v80": ["basic"],
        },
        "default_corner": "ff_100C_1v95",
    },
    "sky130_fd_sc_ms": {
        "commit": "ae1b7f68821505cf2d93d9d44cce5ece22710fad",  # v0.0.2, 2020-12-04
        "shallow_since": "1605631186 -0800",
        "corners": {
            "ff_085C_1v95": ["leakage"],
            "ff_100C_1v65": ["basic"],
            "ff_100C_1v95": ["basic", "leakage"],
            "ff_150C_1v95": ["basic"],
            "ff_n40C_1v56": ["basic"],
            "ff_n40C_1v65_ka1v76": ["basic"],
            "ff_n40C_1v76": ["basic"],
            "ff_n40C_1v95": ["basic", "ccsnoise", "leakage"],
            "ss_100C_1v60": ["basic"],
            "ss_150C_1v60": ["basic"],
            "ss_n40C_1v28": ["basic"],
            "ss_n40C_1v44": ["basic"],
            "ss_n40C_1v60": ["basic", "ccsnoise"],
            "tt_025C_1v80": ["basic", "ccsnoise"],
            "tt_100C_1v80": ["basic"],
        },
        "default_corner": "ff_100C_1v95",
    },
}
