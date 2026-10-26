# Copyright 2026 bazel_rules_hdl Authors
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

"""Icarus-specific cocotb test rule."""

load("//cocotb:private/common.bzl", "COCOTB_TEST_ATTRS", "create_cocotb_test")

def _cocotb_test_icarus_impl(ctx):
    if ctx.attr.waves == "vcd":
        fail("Icarus only supports FST waveform output; set waves = 'fst' or 'none'")
    wrapper_args = []
    if ctx.attr.waves == "fst":
        wrapper_args.append("${TEST_UNDECLARED_OUTPUTS_DIR:+--plusargs=+dumpfile_path=$TEST_UNDECLARED_OUTPUTS_DIR/dump.fst}")
    return create_cocotb_test(ctx, wrapper_args = wrapper_args)

_cocotb_test_icarus_attrs = dict(COCOTB_TEST_ATTRS)
_cocotb_test_icarus_attrs.update({
    "cocotb_wrapper": attr.label(
        cfg = "exec",
        executable = True,
        default = Label("//cocotb:cocotb_wrapper_icarus"),
    ),
    "sim_tools": attr.label_list(
        doc = "Icarus executables used by cocotb",
        default = [
            Label("@com_icarus_iverilog//:iverilog"),
            Label("@com_icarus_iverilog//:vvp"),
        ],
    ),
})

_cocotb_test_icarus_test = rule(
    implementation = _cocotb_test_icarus_impl,
    attrs = _cocotb_test_icarus_attrs,
    toolchains = ["@rules_python//python:toolchain_type"],
    test = True,
)

def cocotb_test_icarus(name, **kwargs):
    """Create an Icarus-backed cocotb test."""
    return _cocotb_test_icarus_test(name = name, **kwargs)
