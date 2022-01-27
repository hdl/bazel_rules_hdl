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

def _assemble_openroad_step(
        ctx,
        wrapper_name,
        script_file,
        step_runfiles,
        inputs = [],
        outputs = ["db"],
        constants = []):
    openroad_executable = ctx.attr._openroad.files_to_run.executable
    openroad_wrapper = ctx.actions.declare_file(wrapper_name)
    runfiles = ctx.runfiles(files = [script_file, openroad_executable, openroad_wrapper])

    openroad_args = [
        "-no_init",
        "-no_splash",
        "-exit",
        "${RUNFILES}/" + script_file.short_path,
    ]

    commands = [script_prefix]

    # TODO(amfv): Compute TCL_LIBRARY properly instead of hardcoding it.
    commands.append("export TCL_LIBRARY=${RUNFILES}/../tk_tcl/library")

    exec_openroad = """{openroad} {args} "$@"\n""".format(
        openroad = "${RUNFILES}/" + openroad_executable.short_path,
        args = " ".join(openroad_args),
    )
    commands.append(exec_openroad)

    ctx.actions.write(
        output = openroad_wrapper,
        content = "\n".join(commands) + "\n",
        is_executable = True,
    )

    openroad_runfiles = ctx.attr._openroad[DefaultInfo].default_runfiles

    return [
        FlowStepInfo(
            inputs = inputs,
            outputs = outputs,
            constants = constants,
            executable_type = "openroad",
            arguments = [],  # ["-quiet"], # Run quietly when part of a larger flow.
        ),
        DefaultInfo(
            executable = openroad_wrapper,
            # TODO(amfv): Switch to runfiles.merge_all once our minimum Bazel version provides it.
            runfiles = runfiles.merge(step_runfiles).merge(openroad_runfiles),
        ),
    ]

def _openroad_step_impl(ctx):
    return _assemble_openroad_step(
        ctx,
        ctx.attr.name,
        ctx.file.script,
        ctx.runfiles(),
        inputs = ctx.attr.inputs,
        outputs = ctx.attr.outputs,
        constants = ctx.attr.constants,
    )

# Rule for creating a generic openroad step that consumes inputs and produces outputs
# as files (without using any Bazel providers).
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
            doc = "Names of logical inputs to the Tcl script",
        ),
        "outputs": attr.string_list(
            doc = "Names of logical outputs of the Tcl script",
        ),
        "constants": attr.string_list(
            doc = "Names of strings constants used by the Tcl script",
        ),
    },
    executable = True,
)
