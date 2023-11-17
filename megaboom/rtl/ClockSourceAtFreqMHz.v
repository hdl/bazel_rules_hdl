
module ClockSourceAtFreqMHz #(parameter PERIOD="") (
    input power,
    input gate,
    output clk);
  timeunit 1ns/1ps;
  reg clk_i = 1'b0;
  always #(PERIOD/2.0) clk_i = ~clk_i & (power & ~gate);
  assign clk = clk_i;
endmodule
