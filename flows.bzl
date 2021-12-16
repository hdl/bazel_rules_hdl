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
        "arguments" : "Extra arguments to pass when running this step as part of a larger flow",
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
            executable_type = step[FlowStepInfo].executable_type,
            arguments = step[FlowStepInfo].arguments,
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

def _flow_to_step_impl(ctx):
    flow_script = ctx.actions.declare_file(ctx.attr.name + ".sh")
    runfiles = ctx.runfiles(files = [flow_script])

    step_runfiles = []
    free_inputs = []
    flow_outputs = []
    commands = [script_prefix]

    for step in ctx.attr.steps:
        for i in step[FlowStepInfo].inputs:
            if i not in free_inputs and i not in flow_outputs:
                # INPUT_name is free if no previous step has written OUTPUT_name
                free_inputs.append(i)

        step_exec = "${{RUNFILES}}/{}".format(step[DefaultInfo].executable.short_path)
        step_runfiles.append(step[DefaultInfo].runfiles)
        step_command = " ".join([step_exec] + step[FlowStepInfo].arguments)
        commands.append(step_command)

        for o in step[FlowStepInfo].outputs:
            if o not in flow_outputs:
                flow_outputs.append(o)
                # Now that OUTPUT_name has been written, INPUT_name is no longer free.
                # Read INPUT_name from OUTPUT_name from this point forward.
                commands.append("INPUT_{name}=${{OUTPUT_{name}}}".format(name = o.upper()))

        ctx.actions.write(output = flow_script, content = "\n".join(commands) + "\n", executable = True)

        return [
            FlowStepInfo(
                inputs = free_inputs,
                outputs = flow_outputs,
                executable_type = "flow",
                arguments = [],
            ),
            DefaultInfo(
                executable = flow_script,
                runfiles = runfiles.merge_all(step_runfiles)
            ),
        ]

# Collapse a sequence of flow steps into a single-step executable.
flow_to_step = rule(
    implementation = _flow_to_step_impl,
    attrs = {
        "flow": attr.label_list(
            doc = "List of steps in the flow",
            providers = [DefaultInfo, FlowStepInfo],
            mandatory = True,
            ),
        }
)
