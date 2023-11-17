// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Arbiter_6(
  input         io_in_0_valid,
  input  [19:0] io_in_0_bits_uop_br_mask,
  input  [4:0]  io_in_0_bits_uop_ldq_idx,
                io_in_0_bits_uop_stq_idx,
  input         io_in_0_bits_uop_is_amo,
                io_in_0_bits_uop_uses_ldq,
                io_in_0_bits_uop_uses_stq,
  input  [63:0] io_in_0_bits_data,
  input         io_in_0_bits_is_hella,
                io_in_1_valid,
  input  [19:0] io_in_1_bits_uop_br_mask,
  input  [4:0]  io_in_1_bits_uop_ldq_idx,
                io_in_1_bits_uop_stq_idx,
  input         io_in_1_bits_uop_is_amo,
                io_in_1_bits_uop_uses_ldq,
                io_in_1_bits_uop_uses_stq,
  input  [63:0] io_in_1_bits_data,
  input         io_in_1_bits_is_hella,
                io_in_2_valid,
  input  [19:0] io_in_2_bits_uop_br_mask,
  input  [4:0]  io_in_2_bits_uop_ldq_idx,
                io_in_2_bits_uop_stq_idx,
  input         io_in_2_bits_uop_is_amo,
                io_in_2_bits_uop_uses_ldq,
                io_in_2_bits_uop_uses_stq,
  input  [63:0] io_in_2_bits_data,
  input         io_in_2_bits_is_hella,
                io_in_3_valid,
  input  [19:0] io_in_3_bits_uop_br_mask,
  input  [4:0]  io_in_3_bits_uop_ldq_idx,
                io_in_3_bits_uop_stq_idx,
  input         io_in_3_bits_uop_is_amo,
                io_in_3_bits_uop_uses_ldq,
                io_in_3_bits_uop_uses_stq,
  input  [63:0] io_in_3_bits_data,
  input         io_in_3_bits_is_hella,
                io_in_4_valid,
  input  [19:0] io_in_4_bits_uop_br_mask,
  input  [4:0]  io_in_4_bits_uop_ldq_idx,
                io_in_4_bits_uop_stq_idx,
  input         io_in_4_bits_uop_is_amo,
                io_in_4_bits_uop_uses_ldq,
                io_in_4_bits_uop_uses_stq,
  input  [63:0] io_in_4_bits_data,
  input         io_in_4_bits_is_hella,
                io_in_5_valid,
  input  [19:0] io_in_5_bits_uop_br_mask,
  input  [4:0]  io_in_5_bits_uop_ldq_idx,
                io_in_5_bits_uop_stq_idx,
  input         io_in_5_bits_uop_is_amo,
                io_in_5_bits_uop_uses_ldq,
                io_in_5_bits_uop_uses_stq,
  input  [63:0] io_in_5_bits_data,
  input         io_in_5_bits_is_hella,
                io_in_6_valid,
  input  [19:0] io_in_6_bits_uop_br_mask,
  input  [4:0]  io_in_6_bits_uop_ldq_idx,
                io_in_6_bits_uop_stq_idx,
  input         io_in_6_bits_uop_is_amo,
                io_in_6_bits_uop_uses_ldq,
                io_in_6_bits_uop_uses_stq,
  input  [63:0] io_in_6_bits_data,
  input         io_in_6_bits_is_hella,
                io_in_7_valid,
  input  [19:0] io_in_7_bits_uop_br_mask,
  input  [4:0]  io_in_7_bits_uop_ldq_idx,
                io_in_7_bits_uop_stq_idx,
  input         io_in_7_bits_uop_is_amo,
                io_in_7_bits_uop_uses_ldq,
                io_in_7_bits_uop_uses_stq,
  input  [63:0] io_in_7_bits_data,
  input         io_in_7_bits_is_hella,
                io_in_8_valid,
  input  [19:0] io_in_8_bits_uop_br_mask,
  input  [4:0]  io_in_8_bits_uop_ldq_idx,
                io_in_8_bits_uop_stq_idx,
  input         io_in_8_bits_uop_is_amo,
                io_in_8_bits_uop_uses_ldq,
                io_in_8_bits_uop_uses_stq,
  input  [63:0] io_in_8_bits_data,
  input         io_in_8_bits_is_hella,
                io_out_ready,
  output        io_in_0_ready,
                io_in_1_ready,
                io_in_2_ready,
                io_in_3_ready,
                io_in_4_ready,
                io_in_5_ready,
                io_in_6_ready,
                io_in_7_ready,
                io_in_8_ready,
                io_out_valid,
  output [19:0] io_out_bits_uop_br_mask,
  output [4:0]  io_out_bits_uop_ldq_idx,
                io_out_bits_uop_stq_idx,
  output        io_out_bits_uop_is_amo,
                io_out_bits_uop_uses_ldq,
                io_out_bits_uop_uses_stq,
  output [63:0] io_out_bits_data,
  output        io_out_bits_is_hella
);

  wire _grant_T = io_in_0_valid | io_in_1_valid;
  wire _grant_T_1 = _grant_T | io_in_2_valid;
  wire _grant_T_2 = _grant_T_1 | io_in_3_valid;
  wire _grant_T_3 = _grant_T_2 | io_in_4_valid;
  wire _grant_T_4 = _grant_T_3 | io_in_5_valid;
  wire _grant_T_5 = _grant_T_4 | io_in_6_valid;
  wire _io_out_valid_T = _grant_T_5 | io_in_7_valid;
  assign io_in_0_ready = io_out_ready;
  assign io_in_1_ready = ~io_in_0_valid & io_out_ready;
  assign io_in_2_ready = ~_grant_T & io_out_ready;
  assign io_in_3_ready = ~_grant_T_1 & io_out_ready;
  assign io_in_4_ready = ~_grant_T_2 & io_out_ready;
  assign io_in_5_ready = ~_grant_T_3 & io_out_ready;
  assign io_in_6_ready = ~_grant_T_4 & io_out_ready;
  assign io_in_7_ready = ~_grant_T_5 & io_out_ready;
  assign io_in_8_ready = ~_io_out_valid_T & io_out_ready;
  assign io_out_valid = _io_out_valid_T | io_in_8_valid;
  assign io_out_bits_uop_br_mask = io_in_0_valid ? io_in_0_bits_uop_br_mask : io_in_1_valid ? io_in_1_bits_uop_br_mask : io_in_2_valid ? io_in_2_bits_uop_br_mask : io_in_3_valid ? io_in_3_bits_uop_br_mask : io_in_4_valid ? io_in_4_bits_uop_br_mask : io_in_5_valid ? io_in_5_bits_uop_br_mask : io_in_6_valid ? io_in_6_bits_uop_br_mask : io_in_7_valid ? io_in_7_bits_uop_br_mask : io_in_8_bits_uop_br_mask;
  assign io_out_bits_uop_ldq_idx = io_in_0_valid ? io_in_0_bits_uop_ldq_idx : io_in_1_valid ? io_in_1_bits_uop_ldq_idx : io_in_2_valid ? io_in_2_bits_uop_ldq_idx : io_in_3_valid ? io_in_3_bits_uop_ldq_idx : io_in_4_valid ? io_in_4_bits_uop_ldq_idx : io_in_5_valid ? io_in_5_bits_uop_ldq_idx : io_in_6_valid ? io_in_6_bits_uop_ldq_idx : io_in_7_valid ? io_in_7_bits_uop_ldq_idx : io_in_8_bits_uop_ldq_idx;
  assign io_out_bits_uop_stq_idx = io_in_0_valid ? io_in_0_bits_uop_stq_idx : io_in_1_valid ? io_in_1_bits_uop_stq_idx : io_in_2_valid ? io_in_2_bits_uop_stq_idx : io_in_3_valid ? io_in_3_bits_uop_stq_idx : io_in_4_valid ? io_in_4_bits_uop_stq_idx : io_in_5_valid ? io_in_5_bits_uop_stq_idx : io_in_6_valid ? io_in_6_bits_uop_stq_idx : io_in_7_valid ? io_in_7_bits_uop_stq_idx : io_in_8_bits_uop_stq_idx;
  assign io_out_bits_uop_is_amo = io_in_0_valid ? io_in_0_bits_uop_is_amo : io_in_1_valid ? io_in_1_bits_uop_is_amo : io_in_2_valid ? io_in_2_bits_uop_is_amo : io_in_3_valid ? io_in_3_bits_uop_is_amo : io_in_4_valid ? io_in_4_bits_uop_is_amo : io_in_5_valid ? io_in_5_bits_uop_is_amo : io_in_6_valid ? io_in_6_bits_uop_is_amo : io_in_7_valid ? io_in_7_bits_uop_is_amo : io_in_8_bits_uop_is_amo;
  assign io_out_bits_uop_uses_ldq = io_in_0_valid ? io_in_0_bits_uop_uses_ldq : io_in_1_valid ? io_in_1_bits_uop_uses_ldq : io_in_2_valid ? io_in_2_bits_uop_uses_ldq : io_in_3_valid ? io_in_3_bits_uop_uses_ldq : io_in_4_valid ? io_in_4_bits_uop_uses_ldq : io_in_5_valid ? io_in_5_bits_uop_uses_ldq : io_in_6_valid ? io_in_6_bits_uop_uses_ldq : io_in_7_valid ? io_in_7_bits_uop_uses_ldq : io_in_8_bits_uop_uses_ldq;
  assign io_out_bits_uop_uses_stq = io_in_0_valid ? io_in_0_bits_uop_uses_stq : io_in_1_valid ? io_in_1_bits_uop_uses_stq : io_in_2_valid ? io_in_2_bits_uop_uses_stq : io_in_3_valid ? io_in_3_bits_uop_uses_stq : io_in_4_valid ? io_in_4_bits_uop_uses_stq : io_in_5_valid ? io_in_5_bits_uop_uses_stq : io_in_6_valid ? io_in_6_bits_uop_uses_stq : io_in_7_valid ? io_in_7_bits_uop_uses_stq : io_in_8_bits_uop_uses_stq;
  assign io_out_bits_data = io_in_0_valid ? io_in_0_bits_data : io_in_1_valid ? io_in_1_bits_data : io_in_2_valid ? io_in_2_bits_data : io_in_3_valid ? io_in_3_bits_data : io_in_4_valid ? io_in_4_bits_data : io_in_5_valid ? io_in_5_bits_data : io_in_6_valid ? io_in_6_bits_data : io_in_7_valid ? io_in_7_bits_data : io_in_8_bits_data;
  assign io_out_bits_is_hella = io_in_0_valid ? io_in_0_bits_is_hella : io_in_1_valid ? io_in_1_bits_is_hella : io_in_2_valid ? io_in_2_bits_is_hella : io_in_3_valid ? io_in_3_bits_is_hella : io_in_4_valid ? io_in_4_bits_is_hella : io_in_5_valid ? io_in_5_bits_is_hella : io_in_6_valid ? io_in_6_bits_is_hella : io_in_7_valid ? io_in_7_bits_is_hella : io_in_8_bits_is_hella;
endmodule

