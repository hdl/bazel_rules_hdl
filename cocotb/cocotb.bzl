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

"""Public cocotb test macro with simulator-specific dispatch."""

load(":icarus/cocotb.bzl", "cocotb_test_icarus")
load(":verilator/cocotb.bzl", "cocotb_test_verilator")

def cocotb_test(name, sim = "icarus", **kwargs):
    """Create a cocotb test using the selected simulator implementation.

    Args:
      name: Name of the test target.
      sim: Simulator implementation to use. Supported values are `icarus` and
        `verilator`.
      **kwargs: Arguments forwarded to the simulator-specific cocotb test rule.

    Returns:
      The result of the simulator-specific cocotb test macro.
    """
    if sim == "icarus":
        return cocotb_test_icarus(name = name, **kwargs)
    if sim == "verilator":
        return cocotb_test_verilator(name = name, **kwargs)

    fail("Unsupported cocotb simulator '{}'; expected 'icarus' or 'verilator'".format(sim))
