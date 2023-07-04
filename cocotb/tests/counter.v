// Copyright 2023 Antmicro
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

`timescale 1us/1us

module counter #(
    parameter COUNTER_WIDTH = 32
) (
    input wire clk,
    input wire rst,
    output reg[COUNTER_WIDTH-1:0] cnt
);

`ifndef INIT_CNT
`define INIT_CNT 0
`endif

initial begin
  cnt = `INIT_CNT;
end

always @(posedge clk) begin
    if (rst)
        cnt <= `INIT_CNT;
    else
        cnt <= cnt + 1;
end

endmodule
