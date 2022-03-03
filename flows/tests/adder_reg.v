//Copyright 2022 Google LLC
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


module adder_reg(
  input        clk,
  input [7:0]  x,
  input [7:0]  y,
  input        carry_in,
  output       carry_output_bit,
  output [7:0] sum
);

  reg [8:0]    full_sum_reg;
  reg [7:0]    x_reg;
  reg [7:0]    y_reg;
  reg          carry_in_reg;

  assign carry_output_bit = full_sum_reg[8];
  assign sum = full_sum_reg[7:0];

  always @(posedge clk)
    begin
      x_reg <= x;
      y_reg <= y;
      carry_in_reg <= carry_in;
      full_sum_reg <= x_reg + y_reg + carry_in_reg;
    end

endmodule
