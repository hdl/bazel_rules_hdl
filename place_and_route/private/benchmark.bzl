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

load("//place_and_route:open_road.bzl", "OpenRoadInfo", "merge_open_road_info", "openroad_command")

def benchmark(ctx, open_road_info):
    """Benchmarks and reports metrics for a placed design.

    Returns:
        OpenRoadInfo: the openROAD info provider containing required input files and
            and commands run.
    Args:
       ctx: Bazel rule ctx
       open_road_info: OpenRoadInfo provider from a previous step.

    """

    open_road_commands = [
        "report_power",
        "report_wns",
        "report_tns",
        "report_checks -path_delay min_max -format full_clock_expanded -fields {input_pin slew capacitance} -digits 3",
        "report_check_types -max_slew -max_capacitance -max_fanout -violators",
        "report_design_area",
        "report_cell_usage",
    ]

    cmd_outputs = []

    if ctx.attr.create_die_shot:
        image_file = ctx.actions.declare_file(ctx.label.name + "_die.png")
        open_road_commands.append("save_image -width 2048 {out}".format(out = image_file.path))
        cmd_outputs.append(image_file)

    command_output = openroad_command(
        ctx,
        commands = open_road_commands,
        input_db = open_road_info.output_db,
        inputs = [],
        step_name = "benchmark",
        outputs = cmd_outputs,
    )

    benchmark_report = ctx.actions.declare_file(ctx.label.name + "_report.textproto")
    benchmark_path = benchmark_report.path

    cmds = [
        "echo \"# proto-file: synthesis/performance_power_area.proto\" >> {out};".format(out = benchmark_path),
        "echo \"# proto-message: hdl.ppa.PerformancePowerAreaProto\n\" >> {out};".format(out = benchmark_path),
    ]
    prefix = "metric=$(cat {log} | awk ".format(log = command_output.log_file.path)
    suffix = "; echo \"{field} $metric\" >> {out};"
    awk_cmds = [
        ("worst_slack_max:", "'/wns/ {{ print $2 }}')"),
        ("total_negative_slack_max:", "'/tns/ {{ print $2 }}')"),
        ("power_total {", "'')"),
        ("  internal_package_watts:", "'/^Total / {{ intern_power=$2 }} END {{ print intern_power }}')"),
        ("  switching_package_watts:", "'/^Total / {{ switch_power=$3 }} END {{ print switch_power }}')"),
        ("  total_package_watts:", "'/^Total / {{ total_power=$5 }} END {{ print total_power }}')"),
        ("}", "'')"),
        ("area_micro_meters_squared:", "'/Design area/ {{ print $3 }}')"),
        ("area_utilization_percentage:", "-F '[ %]' '/Design area/ {{ print $5 }}')"),
        ("num_combinational_gates:", "'/combinational cell/ {{ print 0 + $4 }}')"),
        ("num_flops:", "'/Sequential cell/ {{ print 0 + $3 }}')"),
        ("num_buffers:", "'/Buffer/ {{ buffer=$2; exit }} END {{ print 0 + buffers }}')"),
        ("num_timing_buffers:", "'/Timing Repair/ {{ print 0 + $4 }}')"),
    ]
    cmds.extend([prefix + cmd + suffix.format(field = field, out = benchmark_path) for field, cmd in awk_cmds])

    ctx.actions.run_shell(
        outputs = [benchmark_report],
        command = "".join(cmds),
        mnemonic = "BenchmarkingDesign",
        inputs = [command_output.log_file],
    )

    current_action_open_road_info = OpenRoadInfo(
        commands = open_road_commands,
        input_files = depset(),
        output_db = command_output.db,
        benchmark_report = benchmark_report,
        logs = depset([command_output.log_file] + cmd_outputs),
    )

    return merge_open_road_info(open_road_info, current_action_open_road_info)
