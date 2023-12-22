//Copyright 2021 Google LLC
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.


module verilog_adder(
  input [7:0] x,
  input [7:0] y,
  input carry_in,
  output carry_output_bit,
  output [7:0] sum,
);
  assign {carry_output_bit, sum} = x + y + carry_in;
endmodule
