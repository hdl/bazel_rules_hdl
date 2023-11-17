// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Arbiter_10(
  input        io_in_0_valid,
  input  [5:0] io_in_0_bits_req_0_idx,
  input        io_in_1_valid,
  input  [5:0] io_in_1_bits_req_0_idx,
  input        io_in_2_valid,
  input  [5:0] io_in_2_bits_req_0_idx,
  input        io_in_3_valid,
  input  [5:0] io_in_3_bits_req_0_idx,
  input        io_in_4_valid,
  input  [5:0] io_in_4_bits_req_0_idx,
               io_in_4_bits_req_1_idx,
  input        io_in_5_valid,
  input  [5:0] io_in_5_bits_req_0_idx,
  input        io_out_ready,
  output       io_in_0_ready,
               io_in_1_ready,
               io_in_2_ready,
               io_in_3_ready,
               io_in_4_ready,
               io_in_5_ready,
               io_out_valid,
  output [5:0] io_out_bits_req_0_idx,
               io_out_bits_req_1_idx
);

  wire _grant_T = io_in_0_valid | io_in_1_valid;
  wire _grant_T_1 = _grant_T | io_in_2_valid;
  wire _grant_T_2 = _grant_T_1 | io_in_3_valid;
  wire _io_out_valid_T = _grant_T_2 | io_in_4_valid;
  assign io_in_0_ready = io_out_ready;
  assign io_in_1_ready = ~io_in_0_valid & io_out_ready;
  assign io_in_2_ready = ~_grant_T & io_out_ready;
  assign io_in_3_ready = ~_grant_T_1 & io_out_ready;
  assign io_in_4_ready = ~_grant_T_2 & io_out_ready;
  assign io_in_5_ready = ~_io_out_valid_T & io_out_ready;
  assign io_out_valid = _io_out_valid_T | io_in_5_valid;
  assign io_out_bits_req_0_idx = io_in_0_valid ? io_in_0_bits_req_0_idx : io_in_1_valid ? io_in_1_bits_req_0_idx : io_in_2_valid ? io_in_2_bits_req_0_idx : io_in_3_valid ? io_in_3_bits_req_0_idx : io_in_4_valid ? io_in_4_bits_req_0_idx : io_in_5_bits_req_0_idx;
  assign io_out_bits_req_1_idx = io_in_0_valid | io_in_1_valid | io_in_2_valid | io_in_3_valid | ~io_in_4_valid ? 6'h0 : io_in_4_bits_req_1_idx;
endmodule

