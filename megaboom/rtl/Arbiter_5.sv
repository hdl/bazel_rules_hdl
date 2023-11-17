// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Arbiter_5(
  input         io_in_0_valid,
  input  [19:0] io_in_0_bits_uop_br_mask,
  input  [4:0]  io_in_0_bits_uop_ldq_idx,
                io_in_0_bits_uop_stq_idx,
                io_in_0_bits_uop_mem_cmd,
  input  [1:0]  io_in_0_bits_uop_mem_size,
  input         io_in_0_bits_uop_mem_signed,
                io_in_0_bits_uop_is_amo,
                io_in_0_bits_uop_uses_ldq,
                io_in_0_bits_uop_uses_stq,
  input  [39:0] io_in_0_bits_addr,
  input         io_in_0_bits_is_hella,
  input  [7:0]  io_in_0_bits_way_en,
  input  [4:0]  io_in_0_bits_sdq_id,
  input         io_in_1_valid,
  input  [19:0] io_in_1_bits_uop_br_mask,
  input  [4:0]  io_in_1_bits_uop_ldq_idx,
                io_in_1_bits_uop_stq_idx,
                io_in_1_bits_uop_mem_cmd,
  input  [1:0]  io_in_1_bits_uop_mem_size,
  input         io_in_1_bits_uop_mem_signed,
                io_in_1_bits_uop_is_amo,
                io_in_1_bits_uop_uses_ldq,
                io_in_1_bits_uop_uses_stq,
  input  [39:0] io_in_1_bits_addr,
  input         io_in_1_bits_is_hella,
  input  [7:0]  io_in_1_bits_way_en,
  input  [4:0]  io_in_1_bits_sdq_id,
  input         io_in_2_valid,
  input  [19:0] io_in_2_bits_uop_br_mask,
  input  [4:0]  io_in_2_bits_uop_ldq_idx,
                io_in_2_bits_uop_stq_idx,
                io_in_2_bits_uop_mem_cmd,
  input  [1:0]  io_in_2_bits_uop_mem_size,
  input         io_in_2_bits_uop_mem_signed,
                io_in_2_bits_uop_is_amo,
                io_in_2_bits_uop_uses_ldq,
                io_in_2_bits_uop_uses_stq,
  input  [39:0] io_in_2_bits_addr,
  input         io_in_2_bits_is_hella,
  input  [7:0]  io_in_2_bits_way_en,
  input  [4:0]  io_in_2_bits_sdq_id,
  input         io_in_3_valid,
  input  [19:0] io_in_3_bits_uop_br_mask,
  input  [4:0]  io_in_3_bits_uop_ldq_idx,
                io_in_3_bits_uop_stq_idx,
                io_in_3_bits_uop_mem_cmd,
  input  [1:0]  io_in_3_bits_uop_mem_size,
  input         io_in_3_bits_uop_mem_signed,
                io_in_3_bits_uop_is_amo,
                io_in_3_bits_uop_uses_ldq,
                io_in_3_bits_uop_uses_stq,
  input  [39:0] io_in_3_bits_addr,
  input         io_in_3_bits_is_hella,
  input  [7:0]  io_in_3_bits_way_en,
  input  [4:0]  io_in_3_bits_sdq_id,
  input         io_in_4_valid,
  input  [19:0] io_in_4_bits_uop_br_mask,
  input  [4:0]  io_in_4_bits_uop_ldq_idx,
                io_in_4_bits_uop_stq_idx,
                io_in_4_bits_uop_mem_cmd,
  input  [1:0]  io_in_4_bits_uop_mem_size,
  input         io_in_4_bits_uop_mem_signed,
                io_in_4_bits_uop_is_amo,
                io_in_4_bits_uop_uses_ldq,
                io_in_4_bits_uop_uses_stq,
  input  [39:0] io_in_4_bits_addr,
  input         io_in_4_bits_is_hella,
  input  [7:0]  io_in_4_bits_way_en,
  input  [4:0]  io_in_4_bits_sdq_id,
  input         io_in_5_valid,
  input  [19:0] io_in_5_bits_uop_br_mask,
  input  [4:0]  io_in_5_bits_uop_ldq_idx,
                io_in_5_bits_uop_stq_idx,
                io_in_5_bits_uop_mem_cmd,
  input  [1:0]  io_in_5_bits_uop_mem_size,
  input         io_in_5_bits_uop_mem_signed,
                io_in_5_bits_uop_is_amo,
                io_in_5_bits_uop_uses_ldq,
                io_in_5_bits_uop_uses_stq,
  input  [39:0] io_in_5_bits_addr,
  input         io_in_5_bits_is_hella,
  input  [7:0]  io_in_5_bits_way_en,
  input  [4:0]  io_in_5_bits_sdq_id,
  input         io_in_6_valid,
  input  [19:0] io_in_6_bits_uop_br_mask,
  input  [4:0]  io_in_6_bits_uop_ldq_idx,
                io_in_6_bits_uop_stq_idx,
                io_in_6_bits_uop_mem_cmd,
  input  [1:0]  io_in_6_bits_uop_mem_size,
  input         io_in_6_bits_uop_mem_signed,
                io_in_6_bits_uop_is_amo,
                io_in_6_bits_uop_uses_ldq,
                io_in_6_bits_uop_uses_stq,
  input  [39:0] io_in_6_bits_addr,
  input         io_in_6_bits_is_hella,
  input  [7:0]  io_in_6_bits_way_en,
  input  [4:0]  io_in_6_bits_sdq_id,
  input         io_in_7_valid,
  input  [19:0] io_in_7_bits_uop_br_mask,
  input  [4:0]  io_in_7_bits_uop_ldq_idx,
                io_in_7_bits_uop_stq_idx,
                io_in_7_bits_uop_mem_cmd,
  input  [1:0]  io_in_7_bits_uop_mem_size,
  input         io_in_7_bits_uop_mem_signed,
                io_in_7_bits_uop_is_amo,
                io_in_7_bits_uop_uses_ldq,
                io_in_7_bits_uop_uses_stq,
  input  [39:0] io_in_7_bits_addr,
  input         io_in_7_bits_is_hella,
  input  [7:0]  io_in_7_bits_way_en,
  input  [4:0]  io_in_7_bits_sdq_id,
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
  output [19:0] io_out_bits_uop_br_mask,
  output [4:0]  io_out_bits_uop_ldq_idx,
                io_out_bits_uop_stq_idx,
                io_out_bits_uop_mem_cmd,
  output [1:0]  io_out_bits_uop_mem_size,
  output        io_out_bits_uop_mem_signed,
                io_out_bits_uop_is_amo,
                io_out_bits_uop_uses_ldq,
                io_out_bits_uop_uses_stq,
  output [39:0] io_out_bits_addr,
  output        io_out_bits_is_hella,
  output [7:0]  io_out_bits_way_en,
  output [4:0]  io_out_bits_sdq_id
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
  assign io_out_bits_uop_br_mask = io_in_0_valid ? io_in_0_bits_uop_br_mask : io_in_1_valid ? io_in_1_bits_uop_br_mask : io_in_2_valid ? io_in_2_bits_uop_br_mask : io_in_3_valid ? io_in_3_bits_uop_br_mask : io_in_4_valid ? io_in_4_bits_uop_br_mask : io_in_5_valid ? io_in_5_bits_uop_br_mask : io_in_6_valid ? io_in_6_bits_uop_br_mask : io_in_7_bits_uop_br_mask;
  assign io_out_bits_uop_ldq_idx = io_in_0_valid ? io_in_0_bits_uop_ldq_idx : io_in_1_valid ? io_in_1_bits_uop_ldq_idx : io_in_2_valid ? io_in_2_bits_uop_ldq_idx : io_in_3_valid ? io_in_3_bits_uop_ldq_idx : io_in_4_valid ? io_in_4_bits_uop_ldq_idx : io_in_5_valid ? io_in_5_bits_uop_ldq_idx : io_in_6_valid ? io_in_6_bits_uop_ldq_idx : io_in_7_bits_uop_ldq_idx;
  assign io_out_bits_uop_stq_idx = io_in_0_valid ? io_in_0_bits_uop_stq_idx : io_in_1_valid ? io_in_1_bits_uop_stq_idx : io_in_2_valid ? io_in_2_bits_uop_stq_idx : io_in_3_valid ? io_in_3_bits_uop_stq_idx : io_in_4_valid ? io_in_4_bits_uop_stq_idx : io_in_5_valid ? io_in_5_bits_uop_stq_idx : io_in_6_valid ? io_in_6_bits_uop_stq_idx : io_in_7_bits_uop_stq_idx;
  assign io_out_bits_uop_mem_cmd = io_in_0_valid ? io_in_0_bits_uop_mem_cmd : io_in_1_valid ? io_in_1_bits_uop_mem_cmd : io_in_2_valid ? io_in_2_bits_uop_mem_cmd : io_in_3_valid ? io_in_3_bits_uop_mem_cmd : io_in_4_valid ? io_in_4_bits_uop_mem_cmd : io_in_5_valid ? io_in_5_bits_uop_mem_cmd : io_in_6_valid ? io_in_6_bits_uop_mem_cmd : io_in_7_bits_uop_mem_cmd;
  assign io_out_bits_uop_mem_size = io_in_0_valid ? io_in_0_bits_uop_mem_size : io_in_1_valid ? io_in_1_bits_uop_mem_size : io_in_2_valid ? io_in_2_bits_uop_mem_size : io_in_3_valid ? io_in_3_bits_uop_mem_size : io_in_4_valid ? io_in_4_bits_uop_mem_size : io_in_5_valid ? io_in_5_bits_uop_mem_size : io_in_6_valid ? io_in_6_bits_uop_mem_size : io_in_7_bits_uop_mem_size;
  assign io_out_bits_uop_mem_signed = io_in_0_valid ? io_in_0_bits_uop_mem_signed : io_in_1_valid ? io_in_1_bits_uop_mem_signed : io_in_2_valid ? io_in_2_bits_uop_mem_signed : io_in_3_valid ? io_in_3_bits_uop_mem_signed : io_in_4_valid ? io_in_4_bits_uop_mem_signed : io_in_5_valid ? io_in_5_bits_uop_mem_signed : io_in_6_valid ? io_in_6_bits_uop_mem_signed : io_in_7_bits_uop_mem_signed;
  assign io_out_bits_uop_is_amo = io_in_0_valid ? io_in_0_bits_uop_is_amo : io_in_1_valid ? io_in_1_bits_uop_is_amo : io_in_2_valid ? io_in_2_bits_uop_is_amo : io_in_3_valid ? io_in_3_bits_uop_is_amo : io_in_4_valid ? io_in_4_bits_uop_is_amo : io_in_5_valid ? io_in_5_bits_uop_is_amo : io_in_6_valid ? io_in_6_bits_uop_is_amo : io_in_7_bits_uop_is_amo;
  assign io_out_bits_uop_uses_ldq = io_in_0_valid ? io_in_0_bits_uop_uses_ldq : io_in_1_valid ? io_in_1_bits_uop_uses_ldq : io_in_2_valid ? io_in_2_bits_uop_uses_ldq : io_in_3_valid ? io_in_3_bits_uop_uses_ldq : io_in_4_valid ? io_in_4_bits_uop_uses_ldq : io_in_5_valid ? io_in_5_bits_uop_uses_ldq : io_in_6_valid ? io_in_6_bits_uop_uses_ldq : io_in_7_bits_uop_uses_ldq;
  assign io_out_bits_uop_uses_stq = io_in_0_valid ? io_in_0_bits_uop_uses_stq : io_in_1_valid ? io_in_1_bits_uop_uses_stq : io_in_2_valid ? io_in_2_bits_uop_uses_stq : io_in_3_valid ? io_in_3_bits_uop_uses_stq : io_in_4_valid ? io_in_4_bits_uop_uses_stq : io_in_5_valid ? io_in_5_bits_uop_uses_stq : io_in_6_valid ? io_in_6_bits_uop_uses_stq : io_in_7_bits_uop_uses_stq;
  assign io_out_bits_addr = io_in_0_valid ? io_in_0_bits_addr : io_in_1_valid ? io_in_1_bits_addr : io_in_2_valid ? io_in_2_bits_addr : io_in_3_valid ? io_in_3_bits_addr : io_in_4_valid ? io_in_4_bits_addr : io_in_5_valid ? io_in_5_bits_addr : io_in_6_valid ? io_in_6_bits_addr : io_in_7_bits_addr;
  assign io_out_bits_is_hella = io_in_0_valid ? io_in_0_bits_is_hella : io_in_1_valid ? io_in_1_bits_is_hella : io_in_2_valid ? io_in_2_bits_is_hella : io_in_3_valid ? io_in_3_bits_is_hella : io_in_4_valid ? io_in_4_bits_is_hella : io_in_5_valid ? io_in_5_bits_is_hella : io_in_6_valid ? io_in_6_bits_is_hella : io_in_7_bits_is_hella;
  assign io_out_bits_way_en = io_in_0_valid ? io_in_0_bits_way_en : io_in_1_valid ? io_in_1_bits_way_en : io_in_2_valid ? io_in_2_bits_way_en : io_in_3_valid ? io_in_3_bits_way_en : io_in_4_valid ? io_in_4_bits_way_en : io_in_5_valid ? io_in_5_bits_way_en : io_in_6_valid ? io_in_6_bits_way_en : io_in_7_bits_way_en;
  assign io_out_bits_sdq_id = io_in_0_valid ? io_in_0_bits_sdq_id : io_in_1_valid ? io_in_1_bits_sdq_id : io_in_2_valid ? io_in_2_bits_sdq_id : io_in_3_valid ? io_in_3_bits_sdq_id : io_in_4_valid ? io_in_4_bits_sdq_id : io_in_5_valid ? io_in_5_bits_sdq_id : io_in_6_valid ? io_in_6_bits_sdq_id : io_in_7_bits_sdq_id;
endmodule

