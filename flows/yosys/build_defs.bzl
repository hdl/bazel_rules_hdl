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

"""Reimplementing place-and-route using composable and externalizable pieces"""

load("@rules_hdl//pdk:build_defs.bzl", "StandardCellInfo")
load("//flows:flows.bzl", "FlowStepInfo", "script_prefix")

def _yosys_synth_file_step_impl(ctx):
    yosys_executable = ctx.attr._yosys.files_to_run.executable
    yosys_runfiles = ctx.attr._yosys[DefaultInfo].default_runfiles

    yosys_wrapper = ctx.actions.declare_file(ctx.attr.name)

    standard_cells = ctx.attr.standard_cells[StandardCellInfo]

    liberty = standard_cells.default_corner.liberty

    synth_tcl = ctx.file.synth_tcl

    cell_runfiles = ctx.runfiles(files = [synth_tcl, liberty, yosys_wrapper])

    yosys_args = [
        "-q",  # quiet mode only errors printed to stderr
        "-q",  # second q don't print warnings
        "-Q",  # Don't print header
        "-T",  # Don't print footer
        "-c ${RUNFILES}/" + synth_tcl.short_path,
    ]

    commands = [script_prefix]
    commands.append("export LIBERTY=${RUNFILES}/" + liberty.short_path)

    # TODO(amfv): Compute Yosys data environment variables properly instead of hardcoding them.
    commands.extend([
        "export YOSYS_DATDIR=${RUNFILES}/../at_clifford_yosys/techlibs/",
        "export ABC=${RUNFILES}/../edu_berkeley_abc/abc",
    ])

    exec_yosys = """{yosys} {args} "$@"\n""".format(
        yosys = "${RUNFILES}/" + yosys_executable.short_path,
        args = " ".join(yosys_args),
    )

    commands.append(exec_yosys)

    ctx.actions.write(
        output = yosys_wrapper,
        content = "\n".join(commands) + "\n",
        is_executable = True,
    )

    return [
        FlowStepInfo(
            inputs = ["rtl"],
            outputs = ["netlist"],
            constants = ["top"],  # , "clock_period"],
            executable_type = "yosys",
            arguments = [],
        ),
        DefaultInfo(
            executable = yosys_wrapper,
            # TODO(amfv): Switch to runfiles.merge_all once our minimum Bazel version provides it.
            runfiles = cell_runfiles.merge(yosys_runfiles),
        ),
    ]

yosys_synth_file_step = rule(
    implementation = _yosys_synth_file_step_impl,
    attrs = {
        "_yosys": attr.label(
            default = Label("@at_clifford_yosys//:yosys"),
            executable = True,
            cfg = "exec",
        ),
        "standard_cells": attr.label(
            doc = "Standard cells to use in yosys synthesis step",
            providers = [StandardCellInfo],
        ),
        "synth_tcl": attr.label(
            default = Label("//flows/yosys:synth.tcl"),
            allow_single_file = True,
            doc = "Tcl script controlling Yosys synthesis, using the Flow Step API environment variables",
        ),
    },
)
