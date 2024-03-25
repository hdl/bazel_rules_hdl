# Copyright 2024 Google LLC
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

"""Benchmark OpenROAD commands"""

load("//place_and_route:open_road.bzl", "OpenRoadInfo", "merge_open_road_info", "openroad_command", "timing_setup_commands")

def benchmark(ctx, open_road_info):
    """Benchmarks and reports metrics for a placed design.

    Returns:
        OpenRoadInfo: the openROAD info provider containing required input files and
            and commands run.
    Args:
       ctx: Bazel rule ctx
       open_road_info: OpenRoadInfo provider from a previous step.

    """

    timing_setup_command_struct = timing_setup_commands(ctx)

    inputs = timing_setup_command_struct.inputs

    open_road_commands = timing_setup_command_struct.commands + [
        "report_power",
        "report_wns",
        "report_tns",
        "report_checks -path_delay min_max -format full_clock_expanded -fields {input_pin slew capacitance} -digits 3",
        "report_check_types -max_slew -max_capacitance -max_fanout -violators",
        "report_design_area",
        "report_cell_usage",
    ]

    command_output = openroad_command(
        ctx,
        commands = open_road_commands,
        input_db = open_road_info.output_db,
        inputs = inputs,
        step_name = "benchmark",
    )

    benchmark_file = ctx.actions.declare_file(ctx.label.name + "_report.textproto")
    benchmark_path = benchmark_file.path

    prefix = "metric=$(cat {log} | awk ".format(log = command_output.log_file.path)
    suffix = "; echo \"{name}: $metric\" >> {out};"
    awk_cmds = {
        "area_micro_meters_squared": "'/Design area/ {{ print $3 }}')",
        "area_utilization_percentage": "-F '[ %]' '/Design area/ {{ print $5 }}')",
        "num_buffers": "'/Buffer/ {{ buffers=$2; exit }} END {{ print buffers }}')",
        "num_combinational_gates": "'/Complex combinational cells:/ {{ print $4 }}')",
        "num_flops": "'/Sequential cells:/ {{ print $3 }}')",
        "num_timing_buffers": "'/Timing Repair/ {{ print $4 }}')",
        "total_internal_package_power_watts": "'/Total/ {{ intern_power=$2 }} END {{ print intern_power }}')",
        "total_negative_slack_max": "'/tns/ {{ print $2 }}')",
        "total_switching_package_power_watts": "'/Total/ {{ switch_power=$3 }} END {{ print switch_power }}')",
        "total_total_package_power_watts": "'/Total/ {{ total_power=$5 }} END {{ print total_power }}')",
        "worst_slack_max": "'/wns/ {{ print $2 }}')",
    }

    cmds = [
        "echo \"# proto-file: synthesis/performance_power_area_result.proto\" >> {out};".format(out = benchmark_path),
        "echo \"# proto-message: bazel_rules_hdl.ppa.PerformancePowerAreaResultProto\n\" >> {out};".format(out = benchmark_path),
    ]
    cmds.extend([prefix + cmd + suffix.format(name = name, out = benchmark_path) for name, cmd in awk_cmds.items()])

    ctx.actions.run_shell(
        outputs = [benchmark_file],
        command = "".join(cmds),
        mnemonic = "BenchmarkingDesign",
        inputs = [command_output.log_file],
    )

    current_action_open_road_info = OpenRoadInfo(
        commands = open_road_commands,
        input_files = depset(inputs),
        output_db = command_output.db,
        logs = depset([command_output.log_file, benchmark_file]),
    )

    return merge_open_road_info(open_road_info, current_action_open_road_info)
