# Copyright 2023 Antmicro
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

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles


@cocotb.test()
async def counter_test(dut):
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    dut.rst.setimmediatevalue(1)
    await RisingEdge(dut.clk)
    dut.rst.value = 0

    reset_value = int(dut.cnt.value)

    CYCLES_TO_WAIT = 10
    await ClockCycles(dut.clk, CYCLES_TO_WAIT)
    assert dut.cnt.value == reset_value + CYCLES_TO_WAIT - 1
