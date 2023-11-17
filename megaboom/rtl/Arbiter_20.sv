// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Arbiter_20(
  input         io_in_0_valid,
                io_in_0_bits_valid,
  input  [26:0] io_in_0_bits_bits_addr,
  input         io_in_1_valid,
  input  [26:0] io_in_1_bits_bits_addr,
  input         io_in_1_bits_bits_need_gpa,
                io_in_1_bits_bits_vstage1,
                io_in_1_bits_bits_stage2,
                io_out_ready,
  output        io_in_0_ready,
                io_in_1_ready,
                io_out_valid,
                io_out_bits_valid,
  output [26:0] io_out_bits_bits_addr,
  output        io_out_bits_bits_need_gpa,
                io_out_bits_bits_vstage1,
                io_out_bits_bits_stage2,
  output [1:0]  io_chosen
);

  assign io_in_0_ready = io_out_ready;
  assign io_in_1_ready = ~io_in_0_valid & io_out_ready;
  assign io_out_valid = io_in_0_valid | io_in_1_valid;
  assign io_out_bits_valid = io_in_0_valid ? io_in_0_bits_valid : io_in_1_valid;
  assign io_out_bits_bits_addr = io_in_0_valid ? io_in_0_bits_bits_addr : io_in_1_valid ? io_in_1_bits_bits_addr : 27'h0;
  assign io_out_bits_bits_need_gpa = ~io_in_0_valid & io_in_1_valid & io_in_1_bits_bits_need_gpa;
  assign io_out_bits_bits_vstage1 = ~io_in_0_valid & io_in_1_valid & io_in_1_bits_bits_vstage1;
  assign io_out_bits_bits_stage2 = ~io_in_0_valid & io_in_1_valid & io_in_1_bits_bits_stage2;
  assign io_chosen = io_in_0_valid ? 2'h0 : io_in_1_valid ? 2'h1 : 2'h2;
endmodule

