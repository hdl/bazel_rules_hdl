// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Arbiter_19(
  input        io_in_0_valid,
  input  [5:0] io_in_0_bits,
  input        io_in_1_valid,
  input  [5:0] io_in_1_bits,
               io_in_2_bits,
  output       io_in_2_ready,
  output [5:0] io_out_bits
);

  assign io_in_2_ready = ~(io_in_0_valid | io_in_1_valid);
  assign io_out_bits = io_in_0_valid ? io_in_0_bits : io_in_1_valid ? io_in_1_bits : io_in_2_bits;
endmodule

