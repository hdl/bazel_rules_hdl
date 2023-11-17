// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Arbiter_1(
  input          io_in_0_valid,
  input  [2:0]   io_in_0_bits_id,
  input  [1:0]   io_in_0_bits_offset,
  input  [127:0] io_in_0_bits_data,
  input          io_in_1_valid,
  input  [2:0]   io_in_1_bits_id,
  input  [1:0]   io_in_1_bits_offset,
  input  [127:0] io_in_1_bits_data,
  input          io_in_2_valid,
  input  [2:0]   io_in_2_bits_id,
  input  [1:0]   io_in_2_bits_offset,
  input  [127:0] io_in_2_bits_data,
  input          io_in_3_valid,
  input  [2:0]   io_in_3_bits_id,
  input  [1:0]   io_in_3_bits_offset,
  input  [127:0] io_in_3_bits_data,
  input          io_in_4_valid,
  input  [2:0]   io_in_4_bits_id,
  input  [1:0]   io_in_4_bits_offset,
  input  [127:0] io_in_4_bits_data,
  input          io_in_5_valid,
  input  [2:0]   io_in_5_bits_id,
  input  [1:0]   io_in_5_bits_offset,
  input  [127:0] io_in_5_bits_data,
  input          io_in_6_valid,
  input  [2:0]   io_in_6_bits_id,
  input  [1:0]   io_in_6_bits_offset,
  input  [127:0] io_in_6_bits_data,
  input          io_in_7_valid,
  input  [2:0]   io_in_7_bits_id,
  input  [1:0]   io_in_7_bits_offset,
  input  [127:0] io_in_7_bits_data,
  output         io_in_1_ready,
                 io_in_2_ready,
                 io_in_3_ready,
                 io_in_4_ready,
                 io_in_5_ready,
                 io_in_6_ready,
                 io_in_7_ready,
                 io_out_valid,
  output [2:0]   io_out_bits_id,
  output [1:0]   io_out_bits_offset,
  output [127:0] io_out_bits_data
);

  wire _grant_T = io_in_0_valid | io_in_1_valid;
  wire _grant_T_1 = _grant_T | io_in_2_valid;
  wire _grant_T_2 = _grant_T_1 | io_in_3_valid;
  wire _grant_T_3 = _grant_T_2 | io_in_4_valid;
  wire _grant_T_4 = _grant_T_3 | io_in_5_valid;
  wire _io_out_valid_T = _grant_T_4 | io_in_6_valid;
  assign io_in_1_ready = ~io_in_0_valid;
  assign io_in_2_ready = ~_grant_T;
  assign io_in_3_ready = ~_grant_T_1;
  assign io_in_4_ready = ~_grant_T_2;
  assign io_in_5_ready = ~_grant_T_3;
  assign io_in_6_ready = ~_grant_T_4;
  assign io_in_7_ready = ~_io_out_valid_T;
  assign io_out_valid = _io_out_valid_T | io_in_7_valid;
  assign io_out_bits_id = io_in_0_valid ? io_in_0_bits_id : io_in_1_valid ? io_in_1_bits_id : io_in_2_valid ? io_in_2_bits_id : io_in_3_valid ? io_in_3_bits_id : io_in_4_valid ? io_in_4_bits_id : io_in_5_valid ? io_in_5_bits_id : io_in_6_valid ? io_in_6_bits_id : io_in_7_bits_id;
  assign io_out_bits_offset = io_in_0_valid ? io_in_0_bits_offset : io_in_1_valid ? io_in_1_bits_offset : io_in_2_valid ? io_in_2_bits_offset : io_in_3_valid ? io_in_3_bits_offset : io_in_4_valid ? io_in_4_bits_offset : io_in_5_valid ? io_in_5_bits_offset : io_in_6_valid ? io_in_6_bits_offset : io_in_7_bits_offset;
  assign io_out_bits_data = io_in_0_valid ? io_in_0_bits_data : io_in_1_valid ? io_in_1_bits_data : io_in_2_valid ? io_in_2_bits_data : io_in_3_valid ? io_in_3_bits_data : io_in_4_valid ? io_in_4_bits_data : io_in_5_valid ? io_in_5_bits_data : io_in_6_valid ? io_in_6_bits_data : io_in_7_bits_data;
endmodule

