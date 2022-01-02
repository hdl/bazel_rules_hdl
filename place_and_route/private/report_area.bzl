# Copyright 2021 Google LLC
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

"""Report Area Commands"""

def generate_area_results(output_file):
    """Returns a list of openroad commands that will calculate the design area and write it to a text proto.

    Design area is defined as the sum of the area of all the instances/standard-cells in a design.

    Args:
        output_file: The output textproto.
    """
    nl = "\\n"
    return "\n".join([
        "set design_area [sta::format_area [rsz::design_area] 0]",
        "set fp [open \"{output_file}\" w+]".format(
            output_file = output_file.path,
        ),
        "puts $fp \"area_micro_meters_squared: ${design_area}\"",
        "close $fp",
    ])
