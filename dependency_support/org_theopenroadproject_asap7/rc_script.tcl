# Copyright 2022 Google LLC
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

set_layer_rc -layer M1 -capacitance 6.33956E-02 -resistance 1.3889e-01
set_layer_rc -layer M2 -capacitance 8.02750E-02 -resistance 2.4222e-02
set_layer_rc -layer M3 -capacitance 1.23273E-01 -resistance 2.4222e-02
set_layer_rc -layer M4 -capacitance 1.29902E-01 -resistance 1.6778e-02
set_layer_rc -layer M5 -capacitance 1.19552E-01 -resistance 1.4677e-02
set_layer_rc -layer M6 -capacitance 1.23114E-01 -resistance 1.0371e-02
set_layer_rc -layer M7 -capacitance 1.05408E-01 -resistance 9.6720e-03
set_layer_rc -layer M8 -capacitance 1.1822e-01 -resistance 7.4310e-03
set_layer_rc -layer M9 -capacitance 1.3497e-01 -resistance 6.8740e-03

set_layer_rc -via V1 -resistance 1.00E-02
set_layer_rc -via V2 -resistance 1.00E-02
set_layer_rc -via V3 -resistance 1.00E-02
set_layer_rc -via V4 -resistance 1.00E-02
set_layer_rc -via V5 -resistance 1.00E-02
set_layer_rc -via V6 -resistance 1.00E-02
set_layer_rc -via V7 -resistance 1.00E-02
set_layer_rc -via V8 -resistance 1.00E-02
set_layer_rc -via V9 -resistance 1.00E-02

set_wire_rc -layer M3
