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

"""Report Power Commands"""

load("//synthesis:build_defs.bzl", "SynthesisInfo")

def generate_power_results(ctx, output_file):
    netlist_target = ctx.attr.synthesized_rtl
    liberty = netlist_target[SynthesisInfo].standard_cell_info.default_corner.liberty

    return [
        "report_power",
        "set power_result [sta::design_power [sta::parse_corner {}]]",
        "set fp [open \"{output_file}\" w+]".format(
            output_file = output_file.path,
        ),
        "puts $fp \"total_package_power_watts: [lindex $power_result 3]\"",
        "puts $fp \"corner: \\\"{corner}\\\"\"".format(
            corner = liberty.basename[:-(len(liberty.extension) + 1)],
        ),
        "puts $fp \"power_maginitude: \\\"[sta::unit_scale_abbreviation \"power\"]\\\"\"",
        "close $fp",
    ]
