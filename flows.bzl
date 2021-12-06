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

"""General utilities for describing and implementing hardware development flows."""

load("@bazel_skylib//lib:dicts.bzl", "dicts")

# Flow step targets are bazel executable targets that also provide FlowStepInfo.
#
# They obey the following contract:
# If you set the following environment variables:
# RUNFILES=root of a directory tree with the runfiles of the step executable.
# INPUT_<input_i.upper()>=path to each input file read by this step
# OUTPUT_<output_i.upper()>=patch to each output file written by this step
# bazel run :step -- <extra arguments>
# will run the flow step, generating the outputs from the inputs.
# Any extra arguments after -- in the bazel run command will be passed to the
# underlying executable implementing the step.
FlowStepInfo = provider(
    "Provider that captures metadata about an individual flow step",
    fields = {
        "inputs" : "Uppercase strings naming logical file inputs of a flow step.",
        "outputs" : "Uppercase strings naming logical file outputs of a flow step.",
        "executable_type" : "Type of executable implementing this flow step (e.g. openroad, yosys, etc.).",
    }
)

script_prefix = """
#!/bin/bash
export RUNFILES="${RUNFILES:-$0.runfiles}"
"""

def _bind_step_inputs_impl(ctx):
    bind_names = ctx.attr.input_names
    bind_files = ctx.attr.input_files
    if len(bind_names) != len(bind_files):
        fail("input_names ", bind_names, "and input_files ", bind_files, "lists should have the same length")

    bindings = dict(pairs=zip(bind_names, bind_files))

    step = ctx.attr.step

    step_inputs = step[FlowStepInfo].inputs
    used_bindings = {n: f for (n, f) in bindings.items() if n in step_inputs}
    new_inputs = [i for i in step_inputs if i not in used_bindings.keys()]

    env_bindings = [
        "export INPUT_{}=${{RUNFILES}}/{}".format (n,f.short_path)
        for (n,f) in used_bindings.items()
    ]

    step_executable = step[DefaultInfo].executable
    exec_step = """${{RUNFILES}}/{} "$@"\n""".format(step_executable.short_path)

    bind_script = ctx.actions.declare_file("{}.sh".format(ctx.attr.name))
    ctx.actions.write(output=bind_script,
                      content = "\n".join([script_prefix] + env_bindings + [exec_step]),
                      is_executable = True)

    new_runfiles = ctx.runfiles(files = [step_executable] + used_bindings.values())

    return [
        FlowStepInfo(
            inputs = new_inputs,
            outputs = step[FlowStepInfo].outputs,
            executable_type = step[FlowStepInfo].executable_type
        ),
        DefaultInfo(
            executable = bind_script,
            runfiles = step[DefaultInfo].runfiles.merge(new_runfiles),
        ),
    ]

# bind_step_inputs specializes a flow step by binding some named step inputs
# to specific files.
bind_step_inputs = rule(
    implementation = _bind_step_inputs_impl,
    attrs = {
        "step" : attr.label(
            doc = "Base step with inputs to bind",
            executable = True,
            providers = [DefaultInfo, FlowStepInfo],
            mandatory = True,
            cfg = "exec",
            ),
        "input_names" : attr.string_list(
            doc = "Names of logical step inputs to bind. May include extra inputs",
            ),
        "input_files" : attr.label_list(
            allow_files = True,
            doc = "Files to use with the bound inputs. Must have the same length as input_names",
        ),
    }
)
