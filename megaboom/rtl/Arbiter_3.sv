// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Arbiter_3(
  input         io_in_0_valid,
  input  [5:0]  io_in_0_bits_idx,
  input  [7:0]  io_in_0_bits_way_en,
  input  [19:0] io_in_0_bits_tag,
  input         io_in_1_valid,
  input  [5:0]  io_in_1_bits_idx,
  input  [7:0]  io_in_1_bits_way_en,
  input  [19:0] io_in_1_bits_tag,
  input         io_in_2_valid,
  input  [5:0]  io_in_2_bits_idx,
  input  [7:0]  io_in_2_bits_way_en,
  input  [19:0] io_in_2_bits_tag,
  input         io_in_3_valid,
  input  [5:0]  io_in_3_bits_idx,
  input  [7:0]  io_in_3_bits_way_en,
  input  [19:0] io_in_3_bits_tag,
  input         io_in_4_valid,
  input  [5:0]  io_in_4_bits_idx,
  input  [7:0]  io_in_4_bits_way_en,
  input  [19:0] io_in_4_bits_tag,
  input         io_in_5_valid,
  input  [5:0]  io_in_5_bits_idx,
  input  [7:0]  io_in_5_bits_way_en,
  input  [19:0] io_in_5_bits_tag,
  input         io_in_6_valid,
  input  [5:0]  io_in_6_bits_idx,
  input  [7:0]  io_in_6_bits_way_en,
  input  [19:0] io_in_6_bits_tag,
  input         io_in_7_valid,
  input  [5:0]  io_in_7_bits_idx,
  input  [7:0]  io_in_7_bits_way_en,
  input  [19:0] io_in_7_bits_tag,
  input         io_out_ready,
  output        io_in_0_ready,
                io_in_1_ready,
                io_in_2_ready,
                io_in_3_ready,
                io_in_4_ready,
                io_in_5_ready,
                io_in_6_ready,
                io_in_7_ready,
                io_out_valid,
  output [5:0]  io_out_bits_idx,
  output [7:0]  io_out_bits_way_en,
  output [19:0] io_out_bits_tag
);

  wire _grant_T = io_in_0_valid | io_in_1_valid;
  wire _grant_T_1 = _grant_T | io_in_2_valid;
  wire _grant_T_2 = _grant_T_1 | io_in_3_valid;
  wire _grant_T_3 = _grant_T_2 | io_in_4_valid;
  wire _grant_T_4 = _grant_T_3 | io_in_5_valid;
  wire _io_out_valid_T = _grant_T_4 | io_in_6_valid;
  assign io_in_0_ready = io_out_ready;
  assign io_in_1_ready = ~io_in_0_valid & io_out_ready;
  assign io_in_2_ready = ~_grant_T & io_out_ready;
  assign io_in_3_ready = ~_grant_T_1 & io_out_ready;
  assign io_in_4_ready = ~_grant_T_2 & io_out_ready;
  assign io_in_5_ready = ~_grant_T_3 & io_out_ready;
  assign io_in_6_ready = ~_grant_T_4 & io_out_ready;
  assign io_in_7_ready = ~_io_out_valid_T & io_out_ready;
  assign io_out_valid = _io_out_valid_T | io_in_7_valid;
  assign io_out_bits_idx = io_in_0_valid ? io_in_0_bits_idx : io_in_1_valid ? io_in_1_bits_idx : io_in_2_valid ? io_in_2_bits_idx : io_in_3_valid ? io_in_3_bits_idx : io_in_4_valid ? io_in_4_bits_idx : io_in_5_valid ? io_in_5_bits_idx : io_in_6_valid ? io_in_6_bits_idx : io_in_7_bits_idx;
  assign io_out_bits_way_en = io_in_0_valid ? io_in_0_bits_way_en : io_in_1_valid ? io_in_1_bits_way_en : io_in_2_valid ? io_in_2_bits_way_en : io_in_3_valid ? io_in_3_bits_way_en : io_in_4_valid ? io_in_4_bits_way_en : io_in_5_valid ? io_in_5_bits_way_en : io_in_6_valid ? io_in_6_bits_way_en : io_in_7_bits_way_en;
  assign io_out_bits_tag = io_in_0_valid ? io_in_0_bits_tag : io_in_1_valid ? io_in_1_bits_tag : io_in_2_valid ? io_in_2_bits_tag : io_in_3_valid ? io_in_3_bits_tag : io_in_4_valid ? io_in_4_bits_tag : io_in_5_valid ? io_in_5_bits_tag : io_in_6_valid ? io_in_6_bits_tag : io_in_7_bits_tag;
endmodule

