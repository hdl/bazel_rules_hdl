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
# OUTPUT_<output_i.upper()>=path to each output file written by this step
# CONSTANT_<constant_i.upper()>=string constants used by this step
# bazel run :step -- <extra arguments>
# will run the flow step, generating the outputs from the inputs.
# Any extra arguments after -- in the bazel run command will be passed to the
# underlying executable implementing the step.
FlowStepInfo = provider(
    "Provider that captures metadata about an individual flow step",
    fields = {
        "inputs": "Lowercase strings naming logical file inputs of a flow step.",
        "outputs": "Lowercase strings naming logical file outputs of a flow step.",
        "constants": "Lowercase strings naming string constants used by a flow step.",
        "executable_type": "Type of executable implementing this flow step (e.g. openroad, yosys, etc.).",
        "arguments": "Extra arguments to pass when running this step as part of a larger flow",
    },
)

script_prefix = """
#!/bin/bash
export RUNFILES="${RUNFILES:-$0.runfiles/rules_hdl}"
"""

tcl_script_prefix = "set runfiles_dir $::env(RUNFILES)"

def _bind_step_inputs_impl(ctx):
    bind_names = ctx.attr.input_names
    bind_files = ctx.attr.input_files
    if len(bind_names) != len(bind_files):
        fail("input_names ", bind_names, "and input_files ", bind_files, "lists should have the same length")

    bindings = dict(zip(bind_names, bind_files))

    step = ctx.attr.step

    step_inputs = step[FlowStepInfo].inputs
    used_bindings = {n: f for (n, f) in bindings.items() if n in step_inputs}
    new_inputs = [i for i in step_inputs if i not in used_bindings.keys()]

    env_bindings = [
        "export INPUT_{}=${{RUNFILES}}/{}".format(n, f.short_path)
        for (n, f) in used_bindings.items()
    ]

    step_executable = step[DefaultInfo].executable
    exec_step = """${{RUNFILES}}/{} "$@"\n""".format(step_executable.short_path)

    bind_script = ctx.actions.declare_file(ctx.attr.name)
    ctx.actions.write(
        output = bind_script,
        content = "\n".join([script_prefix] + env_bindings + [exec_step]),
        is_executable = True,
    )

    new_runfiles = ctx.runfiles(files = [step_executable] + used_bindings.values())

    return [
        FlowStepInfo(
            inputs = new_inputs,
            outputs = step[FlowStepInfo].outputs,
            constants = step[FlowStepInfo].constants,
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
        "step": attr.label(
            doc = "Base step with inputs to bind",
            executable = True,
            providers = [DefaultInfo, FlowStepInfo],
            mandatory = True,
            cfg = "exec",
        ),
        "input_names": attr.string_list(
            doc = "Names of logical step inputs to bind. May include extra inputs",
        ),
        "input_files": attr.label_list(
            allow_files = True,
            doc = "Files to use with the bound inputs. Must have the same length as input_names",
        ),
    },
)

def _flow_binary_impl(ctx):
    flow_script = ctx.actions.declare_file(ctx.attr.name)
    flow_runfiles = ctx.runfiles(files = [flow_script])

    free_inputs = []
    flow_outputs = []
    commands = [script_prefix]

    for step in ctx.attr.flow:
        for i in step[FlowStepInfo].inputs:
            if i not in free_inputs and i not in flow_outputs:
                # INPUT_name is free if no previous step has written OUTPUT_name
                free_inputs.append(i)

        step_exec = "${{RUNFILES}}/{}".format(step[DefaultInfo].files_to_run.executable.short_path)
        flow_runfiles = flow_runfiles.merge(step[DefaultInfo].default_runfiles)
        step_command = " ".join([step_exec] + step[FlowStepInfo].arguments)
        commands.append(step_command)

        for o in step[FlowStepInfo].outputs:
            if o not in flow_outputs:
                flow_outputs.append(o)

                # Now that OUTPUT_name has been written, INPUT_name is no longer free.
                # Read INPUT_name from OUTPUT_name from this point forward.
                commands.append("export INPUT_{name}=${{OUTPUT_{name}}}".format(name = o.upper()))

    ctx.actions.write(output = flow_script, content = "\n".join(commands) + "\n", is_executable = True)

    return [
        FlowStepInfo(
            inputs = free_inputs,
            outputs = flow_outputs,
            executable_type = "flow",
            arguments = [],
        ),
        DefaultInfo(
            executable = flow_script,
            runfiles = flow_runfiles,
        ),
    ]

# Collapse a sequence of flow steps into a single-step executable.
flow_binary = rule(
    implementation = _flow_binary_impl,
    attrs = {
        "flow": attr.label_list(
            doc = "List of steps in the flow",
            providers = [DefaultInfo, FlowStepInfo],
            mandatory = True,
        ),
    },
    executable = True,
)

def _run_step_with_inputs(ctx, step, inputs_dict, outputs_step_dict):
    # inputs and output manifests are for the runfiles of the step executable.
    (tool_inputs, input_manifests) = ctx.resolve_tools(tools = [step])

    # The inputs_env and inputs handle the named inputs of the step.
    inputs = []
    inputs_env = {}

    for i in step[FlowStepInfo].inputs:
        f = inputs_dict.get(i)
        if f == None:
            fail("Required input", i, "not found in input dictionary", inputs_dict)
        inputs.append(f)
        inputs_env["INPUT_" + i.upper()] = f.path

    outputs = []
    outputs_dict = {}
    outputs_env = {}
    for o in step[FlowStepInfo].outputs:
        f = outputs_step_dict.get((step.label.name, o))
        if f == None:
            # TODO(amfv): Figure out if implicitly treating the logical name as an extension
            # is actually a good idea. I think it works for the output DB, but...
            f = ctx.actions.declare_file(step.label.name + "." + o)

        outputs.append(f)
        outputs_dict[o] = f
        outputs_env["OUTPUT_" + o.upper()] = f.path

    constants_env = {}
    for c in step[FlowStepInfo].constants:
        s = ctx.attr.constants.get(c)
        if s == None:
            fail("Required constant", c, "not found in constants dictionary", ctx.attr.constants)
        constants_env["CONSTANT_" + c.upper()] = s

    ctx.actions.run_shell(
        outputs = outputs,
        inputs = inputs,
        command = step[DefaultInfo].files_to_run.executable.path,
        tools = tool_inputs,
        arguments = step[FlowStepInfo].arguments,
        mnemonic = step[FlowStepInfo].executable_type,
        env = dicts.add(constants_env, inputs_env, outputs_env),
        input_manifests = input_manifests,
        toolchain = None,
    )

    return dicts.add(inputs_dict, outputs_dict)

def target_to_file(target):
    all_files = target.files.to_list()
    if len(all_files) != 1:
        fail("Input target", target, "should provide exactly one file instead of", all_files)

    return all_files[0]

def _run_flow_impl(ctx):
    if len(ctx.attr.output_names) != len(ctx.outputs.output_files):
        fail(
            "output_names ",
            ctx.attr.output_names,
            "and output_files ",
            ctx.attr.output_files,
            "lists should have the same length",
        )

    outputs_dict = dict(zip(ctx.attr.output_names, ctx.outputs.output_files))

    unhandled_outputs = []
    unhandled_outputs.extend(ctx.attr.output_names)

    outputs_step_dict = {}
    for rstep in reversed(ctx.attr.flow):
        for o in rstep[FlowStepInfo].outputs:
            if o in unhandled_outputs:
                outputs_step_dict[(rstep.label.name, o)] = outputs_dict[o]
                unhandled_outputs.remove(o)

    if unhandled_outputs:
        fail("no step of the flow produces these outputs:", unhandled_outputs)

    if len(ctx.attr.input_names) != len(ctx.attr.input_files):
        fail(
            "input_names ",
            ctx.attr.input_names,
            "and input_files ",
            ctx.attr.input_files,
            "lists should have the same length",
        )

    input_files = [target_to_file(target) for target in ctx.attr.input_files]

    inputs_dict = dict(zip(ctx.attr.input_names, input_files))

    for step in ctx.attr.flow:
        inputs_dict = _run_step_with_inputs(ctx, step, inputs_dict, outputs_step_dict)

    return [DefaultInfo()]

run_flow = rule(
    implementation = _run_flow_impl,
    attrs = {
        "flow": attr.label_list(
            doc = "List of steps in the flow",
            providers = [DefaultInfo, FlowStepInfo],
            mandatory = True,
        ),
        "input_names": attr.string_list(
            doc = "Names of initial flow inputs",
        ),
        "input_files": attr.label_list(
            allow_files = True,
            doc = "Files to use with the named inputs. Must have the same length as input_names",
        ),
        "output_names": attr.string_list(
            doc = "Names of final flow outputs",
        ),
        "output_files": attr.output_list(
            doc = "Files to store final output values",
        ),
        "constants": attr.string_dict(
            doc = "String constants to use when running the flow",
        ),
    },
)
