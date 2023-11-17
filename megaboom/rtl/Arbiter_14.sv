// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Arbiter_14(
  input         io_in_0_valid,
  input  [31:0] io_in_0_bits_address,
  input         io_in_1_valid,
  input  [31:0] io_in_1_bits_address,
  input         io_out_ready,
  output        io_in_0_ready,
                io_in_1_ready,
                io_out_valid,
  output [31:0] io_out_bits_address
);

  assign io_in_0_ready = io_out_ready;
  assign io_in_1_ready = ~io_in_0_valid & io_out_ready;
  assign io_out_valid = io_in_0_valid | io_in_1_valid;
  assign io_out_bits_address = io_in_0_valid ? io_in_0_bits_address : io_in_1_bits_address;
endmodule

