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

"""Reimplementing place-and-route using composable and externalizable pieces"""

load("//flows:flows.bzl", "FlowStepInfo", "script_prefix")

def _openroad_step_impl(ctx):
    openroad_executable = ctx.attr._openroad.files_to_run.executable
    openroad_wrapper = ctx.actions.declare_file(ctx.attr.name)
    runfiles = ctx.runfiles(files = [ctx.file.script, openroad_executable, openroad_wrapper])

    openroad_args = [
        "-no_init",
        "-no_splash",
        "-exit",
        "${RUNFILES}/" + ctx.file.script.short_path,
    ]

    commands = [script_prefix]
    # TODO(amfv): Compute TCL_LIBRARY properly instead of hardcoding it.
    commands.append("export TCL_LIBRARY=${RUNFILES}/../tk_tcl/library")

    exec_openroad = """{openroad} {args} "$@"\n""".format(
        openroad = "${RUNFILES}/" + openroad_executable.short_path,
        args = " ".join(openroad_args)
    )
    commands.append(exec_openroad)

    ctx.actions.write(output = openroad_wrapper,
                      content = "\n".join(commands) + "\n",
                      is_executable = True)

    return [
        FlowStepInfo(
            inputs = ctx.attr.inputs,
            outputs = ctx.attr.outputs,
            executable_type = "openroad",
            arguments = [], # ["-quiet"], # Run quietly when part of a larger flow.
        ),
        DefaultInfo(
            executable = openroad_wrapper,
            runfiles = runfiles.merge(ctx.attr._openroad[DefaultInfo].default_runfiles),
        ),
    ]

openroad_step = rule(
    implementation = _openroad_step_impl,
    attrs = {
        "_openroad": attr.label(
            default = Label("@org_theopenroadproject//:openroad"),
            executable = True,
            cfg = "exec",
        ),
        "script": attr.label(
            doc = "OpenROAD Tcl script implementing this step.",
            allow_single_file = [".tcl"],
            mandatory = True,

        ),
        "inputs": attr.string_list(
            doc = "Name of logical inputs to the Tcl script",
        ),
        "outputs": attr.string_list(
            doc = "Name of logical outputs of the Tcl script",
        ),
    },
    executable = True,
)
