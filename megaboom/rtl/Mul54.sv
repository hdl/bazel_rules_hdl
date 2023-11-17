// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Mul54(
  input          clock,
                 io_val_s0,
                 io_latch_a_s0,
  input  [53:0]  io_a_s0,
  input          io_latch_b_s0,
  input  [53:0]  io_b_s0,
  input  [104:0] io_c_s2,
  output [104:0] io_result_s3
);

  reg         val_s1;
  reg         val_s2;
  reg [53:0]  reg_a_s1;
  reg [53:0]  reg_b_s1;
  reg [53:0]  reg_a_s2;
  reg [53:0]  reg_b_s2;
  reg [104:0] reg_result_s3;
  always @(posedge clock) begin
    val_s1 <= io_val_s0;
    val_s2 <= val_s1;
    if (io_val_s0 & io_latch_a_s0)
      reg_a_s1 <= io_a_s0;
    if (io_val_s0 & io_latch_b_s0)
      reg_b_s1 <= io_b_s0;
    if (val_s1) begin
      reg_a_s2 <= reg_a_s1;
      reg_b_s2 <= reg_b_s1;
    end
    if (val_s2)
      reg_result_s3 <= {51'h0, reg_a_s2} * {51'h0, reg_b_s2} + io_c_s2;
  end // always @(posedge)
  assign io_result_s3 = reg_result_s3;
endmodule

