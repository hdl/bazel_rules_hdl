# Copyright 2020-2021 Google LLC
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

"""Providers for PDKs to be used by downstream synthesis.
"""

StandardCellInfo = provider(
    "Contains information about the standard cells used for synthesis",
    fields = {
        "corners": "list of CornerInfos for the PDK",
        "default_corner": "A default corner info defined for the PDK.",
        "tech_lef": "Tech LEF file for the PDK",
        "cell_lef_definitions": "list of Abstract LEFs files for each standard cell.",
        "platform_gds": "list of Platform GDS files.",
        "parasitic_extraction_benchmark": "Optional calibration file for OpenRCX.",
        "open_road_configuration": "OpenROAD PDK configuration.",
    },
)

CornerInfo = provider(
    "Contains information about standard cells at different corners",
    fields = {
        "liberty": "A file that points to the liberty file for this corner",
        "with_ccsnoise": "boolean Indicates that this is a ccsnoise model.",
        "with_leakage": "boolean Indicates wheter leakage is included in model",
        "corner_name": "Name of the process corner",
    },
)
