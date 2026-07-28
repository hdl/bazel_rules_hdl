# Copyright 2024 Antmicro
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

"""Providers for Verilator run targets"""

VerilatedBinaryInfo = provider(
    doc = "A verilated binary supplementary info",
    fields = {
        "coverage": "Coverage collection settings",
        "trace": "Trace (waveform collection) enable",
    },
)

RawCoverageInfo = provider(
    doc = "Raw coverage data written by a verilated model",
    fields = {
        "files": "Coverage data files",
    },
)

CoverageInfo = provider(
    doc = "Coverage data converted using 'verilator_convert' utility",
    fields = {
        "files": "Coverage info files",
    },
)
