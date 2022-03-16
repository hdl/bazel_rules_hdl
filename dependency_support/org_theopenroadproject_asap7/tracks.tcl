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

set multiplier 4

make_tracks Pad -x_offset [expr 0.116 * $multiplier] -x_pitch [expr 0.08  * $multiplier] -y_offset [expr 0.116 * $multiplier] -y_pitch [expr 0.08 * $multiplier]
make_tracks M9  -x_offset [expr 0.116 * $multiplier] -x_pitch [expr 0.08  * $multiplier] -y_offset [expr 0.116 * $multiplier] -y_pitch [expr 0.08 * $multiplier]
make_tracks M8  -x_offset [expr 0.116 * $multiplier] -x_pitch [expr 0.08  * $multiplier] -y_offset [expr 0.116 * $multiplier] -y_pitch [expr 0.08 * $multiplier]
make_tracks M7  -x_offset [expr 0.016 * $multiplier] -x_pitch [expr 0.064 * $multiplier] -y_offset [expr 0.016 * $multiplier] -y_pitch [expr 0.064 * $multiplier]
make_tracks M6  -x_offset [expr 0.012 * $multiplier] -x_pitch [expr 0.048 * $multiplier] -y_offset [expr 0.016 * $multiplier] -y_pitch [expr 0.064 * $multiplier]
make_tracks M5  -x_offset [expr 0.012 * $multiplier] -x_pitch [expr 0.048 * $multiplier] -y_offset [expr 0.012 * $multiplier] -y_pitch [expr 0.048 * $multiplier]
make_tracks M4  -x_offset [expr 0.009 * $multiplier] -x_pitch [expr 0.036 * $multiplier] -y_offset [expr 0.012 * $multiplier] -y_pitch [expr 0.048 * $multiplier]
make_tracks M3  -x_offset [expr 0.009 * $multiplier] -x_pitch [expr 0.036 * $multiplier] -y_offset [expr 0.009 * $multiplier] -y_pitch [expr 0.036 * $multiplier]

# Creating multiple sub tracks for metal M2 for off grid routing purposes.
make_tracks M2  -x_offset [expr 0.009 * $multiplier] -x_pitch [expr 0.036 * $multiplier] -y_offset [expr (0.045 - 0.000) * $multiplier] -y_pitch [expr 0.270 * $multiplier]
make_tracks M2  -x_offset [expr 0.009 * $multiplier] -x_pitch [expr 0.036 * $multiplier] -y_offset [expr (0.081 - 0.000) * $multiplier] -y_pitch [expr 0.270 * $multiplier]
make_tracks M2  -x_offset [expr 0.009 * $multiplier] -x_pitch [expr 0.036 * $multiplier] -y_offset [expr (0.117 - 0.000) * $multiplier] -y_pitch [expr 0.270 * $multiplier]
make_tracks M2  -x_offset [expr 0.009 * $multiplier] -x_pitch [expr 0.036 * $multiplier] -y_offset [expr (0.153 - 0.000) * $multiplier] -y_pitch [expr 0.270 * $multiplier]
make_tracks M2  -x_offset [expr 0.009 * $multiplier] -x_pitch [expr 0.036 * $multiplier] -y_offset [expr (0.189 - 0.000) * $multiplier] -y_pitch [expr 0.270 * $multiplier]
make_tracks M2  -x_offset [expr 0.009 * $multiplier] -x_pitch [expr 0.036 * $multiplier] -y_offset [expr (0.225 - 0.000) * $multiplier] -y_pitch [expr 0.270 * $multiplier]
make_tracks M2  -x_offset [expr 0.009 * $multiplier] -x_pitch [expr 0.036 * $multiplier] -y_offset [expr (0.270 - 0.000) * $multiplier] -y_pitch [expr 0.270 * $multiplier]

make_tracks M1  -x_offset [expr 0.009 * $multiplier] -x_pitch [expr 0.036 * $multiplier] -y_offset [expr 0.009 * $multiplier] -y_pitch [expr 0.036 * $multiplier]
