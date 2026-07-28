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

"""Common provider types"""

WaveformInfo = provider(
    doc = "Waveform collected during a simulation run",
    fields = {
        "fsdb_files": "FSDB waveform files",
        "vcd_files": "VCD waveform files",
        "vpd_files": "VPD waveform files",
    },
)

LogInfo = provider(
    doc = "A textual log file provider",
    fields = {
        "files": "Log files",
    },
)
