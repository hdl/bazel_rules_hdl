# Copyright 2022 Google LLC
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

"""Rules for running openSTA on synthesized Verilog."""

load("//synthesis:defs.bzl", "SynthesisInfo")

def _run_opensta_impl(ctx):
    """Implementation of the 'run_opensta' rule.

    Runs opensta on a synthesized netlist.

    Args:
      ctx: The current rule's context object.
    Returns:
      DefaultInfo provider
    """
    synth_info = ctx.attr.synth_target[SynthesisInfo]

    netlist = synth_info.synthesized_netlist
    default_liberty_file = synth_info.standard_cell_info.default_corner.liberty
    additional_liberty_files = [corner.liberty for corner in synth_info.standard_cell_info.corners]
    if default_liberty_file in additional_liberty_files:
        additional_liberty_files.remove(default_liberty_file)

    opensta_runfiles_dir = ctx.executable._opensta.path + ".runfiles"

    sta_tcl = ctx.file.sta_tcl
    sta_log = ctx.actions.declare_file("{}_sta.log".format(ctx.attr.name))

    env = {
        "ADDITIONAL_LIBERTIES": ",".join([f.path for f in additional_liberty_files]),
        "LIBERTY": default_liberty_file.path,
        "LOGFILE": sta_log.path,
        "NETLIST": netlist.path,
        "TCL_LIBRARY": opensta_runfiles_dir + "/+_repo_rules+tk_tcl/library",
        "TOP": synth_info.top_module,
    }

    ctx.actions.run(
        outputs = [sta_log],
        inputs = [default_liberty_file, sta_tcl, netlist] + additional_liberty_files,
        arguments = ["-exit", sta_tcl.path],
        executable = ctx.executable._opensta,
        env = env,
        mnemonic = "RunningSTA",
        toolchain = None,
    )

    return [
        DefaultInfo(
            files = depset(
                direct = [sta_log],
                transitive = [],
            ),
        ),
    ]

run_opensta_attrs = {
    "sta_tcl": attr.label(
        default = Label("//static_timing:sta.tcl"),
        allow_single_file = True,
        doc = "Tcl opensta script compatible with the environment-variable API of sta.tcl",
    ),
    "synth_target": attr.label(
        doc = "The synth target to benchmark.",
        providers = [SynthesisInfo],
    ),
    "_opensta": attr.label(
        default = Label("@org_theopenroadproject//:opensta"),
        executable = True,
        cfg = "exec",
    ),
}

run_opensta = rule(
    doc = """Find longest path in a synthesized netlist using openSTA.

Example:
    ```
    run_opensta(
        name = "picorv32_benchmark_sta",
        synth_target = ":picorv32_synth",
    )
    ```
    """,
    implementation = _run_opensta_impl,
    attrs = run_opensta_attrs,
)
