// Copyright 2024 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module top_add (
  input wire clk,
  input wire [7:0] a,
  input wire [7:0] b,
  output reg [7:0] x
);

  reg [7:0] a_;
  reg [7:0] b_;
  wire [7:0] i_;

  always_ff @ (posedge clk)
    a_ <= a;

  always_ff @ (posedge clk)
    b_ <= b;

  always_ff @ (posedge clk)
    x <= i_;

  mod_add mod (.a(a_), .b(b_), .x(i_));

endmodule
