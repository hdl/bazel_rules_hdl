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

    est_parasitic_cmd = "estimate_parasitics -placement"
    if ctx.attr.stop_after_step in ["global_routing", "detailed_routing"]:
        est_parasitic_cmd = "estimate_parasitics -global_routing"

    open_road_commands = [
        est_parasitic_cmd,
        "set_power_activity -input -activity {} -duty 0.5".format(ctx.attr.power_switching_activity),
        "report_power",
        "report_wns",
        "report_tns",
        "report_checks -path_delay min_max -format full_clock_expanded -fields {input_pin slew capacitance} -digits 3",
        "report_check_types -max_slew -max_capacitance -max_fanout -violators",
        "report_design_area",
        "report_cell_usage",
        "report_clock_min_period",
        "report_clock_properties",
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
        "echo \"# proto-file: synthesis/power_performance_area.proto\" >> {out};".format(out = benchmark_path),
        "echo \"# proto-message: hdl.ppa.PowerPerformanceAreaProto\n\" >> {out};".format(out = benchmark_path),
    ]
    awk_cmds = [
        "area=$(cat {log} | awk '/Design area/ {{ print $3 }}');",
        "util_fraction=$(cat {log} | awk -F '[ %]' '/Design area/ {{ printf(\"%.3f\", $5 / 100.0); }}');",
        "combos=$(cat {log} | awk '/combinational cell/ {{ print $4 }}');",
        "combos_area=$(cat {log} | awk '/combinational cell/ {{ print $5 }}');",
        "seq=$(cat {log} | awk '/Sequential cell/ {{ print $3 }}');",
        "seq_area=$(cat {log} | awk '/Sequential cell/ {{ print $4 }}');",
        "buffs=$(cat {log} | awk '/Buffer/ {{ buffer=$2; exit }} END {{ print buffers }}');",
        "buffs_area=$(cat {log} | awk '/Buffer/ {{ buffer=$2; exit }} END {{ print buffers }}');",
        "tbuffs=$(cat {log} | awk '/Timing Repair Buffer/ {{ print $4 }}');",
        "tbuffs_area=$(cat {log} | awk '/Timing Repair Buffer/ {{ print $4 }}');",
        "inverters=$(cat {log} | awk '/Inverter/ {{ print $2 }}');",
        "inverters_area=$(cat {log} | awk '/Inverter/ {{ print $2 }}');",
        "wns_ps=$(cat {log} | awk '/wns/ {{ printf(\"%.0f\", $2 * 1000); }}');",
        "tns_ps=$(cat {log} | awk '/tns/ {{ printf(\"%.0f\", $2 * 1000); }}');",
        # Fixed: Match any clock name (not just "clk") in the clock properties table
        # The table has format: "clock_name    period    waveform_start  waveform_end"
        "period=$(cat {log} | awk '/Period.*Waveform/ {{ in_table=1; next }} in_table && /^-+$/ {{ next }} in_table && /^[a-zA-Z_][a-zA-Z0-9_]*[ \\t]+[0-9]/ {{ printf(\"%.0f\", $2 * 1000); exit }}');",
        "cpl=$(cat {log} | awk '/period_min/ {{ cpl=$4; exit }} END {{ printf(\"%.0f\", cpl * 1000); }}');",
        # Fixed: Convert fmax from MHz to GHz (OpenROAD reports in MHz, proto expects GHz)
        # Log format: "clock_name period_min = X.XX fmax = Y.YY"
        # where fmax is in MHz, so divide by 1000 to get GHz
        "fmax=$(cat {log} | awk '/fmax/ {{ fmax=$7; exit }} END {{ printf(\"%.3f\", fmax / 1000.0) }}');",
        "tot_pow=$(cat {log} | awk '/^Total / {{ total_power=$5 }} END {{ print total_power }}');",
        "int_pow=$(cat {log} | awk '/^Total / {{ intern_power=$2 }} END {{ print intern_power }}');",
        "leak_pow=$(cat {log} | awk '/^Total / {{ leak_power=$4 }} END {{ print leak_power }}');",
        "swi_pow=$(cat {log} | awk '/^Total / {{ switch_power=$3 }} END {{ print switch_power }}');",
    ]
    cmds.extend([cmd.format(log = command_output.log_file.path) for cmd in awk_cmds])
    textproto = proto.encode_text(
        struct(
            area = struct(
                cell_area_um2 = "${area:=0}",
                cell_utilization_fraction = "${util_fraction:=0}",
                area_sequentials_um2 = "${seq_area:=0}",
                area_combinationals_um2 = "${combos_area:=0}",
                area_buffers_um2 = "${buffs_area:=0}",
                area_timing_buffers_um2 = "${tbuffs_area:=0}",
                area_inverters_um2 = "${inverters_area:=0}",
                num_total_cells = "$((${combos:=0} + ${seq:=0} + ${buffs:=0} + ${tbuffs:=0} + ${inverters:=0}))",
                num_sequential = "${seq:=0}",
                num_combinational = "${combos:=0}",
                num_buffers = "${buffs:=0}",
                num_timing_buffers = "${tbuffs:=0}",
                num_inverters = "${inverters:=0}",
            ),
            performance = struct(
                clock_period_ps = "${period:=0}",
                critical_path_ps = "${cpl:=0}",
                fmax_ghz = "${fmax:=0}",
                setup_wns_ps = "${wns_ps:=0}",
                setup_tns_ps = "${tns_ps:=0}",
            ),
            power = struct(
                total = struct(
                    internal_watts = "$int_pow",
                    switching_watts = "$swi_pow",
                    leakage_watts = "$leak_pow",
                    total_watts = "$tot_pow",
                ),
                estimation_method = "\"{} probabilistic switching fraction\"".format(ctx.attr.power_switching_activity),
            ),
        ),
    )
    cmds.append("echo \"{textproto}\" >> {out}".format(textproto = textproto, out = benchmark_path))

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
