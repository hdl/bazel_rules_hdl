// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Arbiter_16(
  input         io_in_0_valid,
  input  [6:0]  io_in_0_bits_uop_uopc,
  input  [19:0] io_in_0_bits_uop_br_mask,
  input  [6:0]  io_in_0_bits_uop_rob_idx,
  input  [4:0]  io_in_0_bits_uop_stq_idx,
  input  [6:0]  io_in_0_bits_uop_pdst,
  input         io_in_0_bits_uop_is_amo,
                io_in_0_bits_uop_uses_stq,
  input  [1:0]  io_in_0_bits_uop_dst_rtype,
  input         io_in_0_bits_uop_fp_val,
  input  [64:0] io_in_0_bits_data,
  input         io_in_0_bits_predicated,
                io_in_0_bits_fflags_valid,
  input  [6:0]  io_in_0_bits_fflags_bits_uop_rob_idx,
  input  [4:0]  io_in_0_bits_fflags_bits_flags,
  input         io_in_1_valid,
  input  [6:0]  io_in_1_bits_uop_uopc,
  input  [19:0] io_in_1_bits_uop_br_mask,
  input  [6:0]  io_in_1_bits_uop_rob_idx,
  input  [4:0]  io_in_1_bits_uop_stq_idx,
  input  [6:0]  io_in_1_bits_uop_pdst,
  input         io_in_1_bits_uop_is_amo,
                io_in_1_bits_uop_uses_stq,
  input  [1:0]  io_in_1_bits_uop_dst_rtype,
  input         io_in_1_bits_uop_fp_val,
  input  [64:0] io_in_1_bits_data,
  input         io_in_1_bits_predicated,
                io_in_1_bits_fflags_valid,
  input  [6:0]  io_in_1_bits_fflags_bits_uop_rob_idx,
  input  [4:0]  io_in_1_bits_fflags_bits_flags,
  input         io_out_ready,
  output        io_in_0_ready,
                io_in_1_ready,
                io_out_valid,
  output [6:0]  io_out_bits_uop_uopc,
  output [19:0] io_out_bits_uop_br_mask,
  output [6:0]  io_out_bits_uop_rob_idx,
  output [4:0]  io_out_bits_uop_stq_idx,
  output [6:0]  io_out_bits_uop_pdst,
  output        io_out_bits_uop_is_amo,
                io_out_bits_uop_uses_stq,
  output [1:0]  io_out_bits_uop_dst_rtype,
  output        io_out_bits_uop_fp_val,
  output [64:0] io_out_bits_data,
  output        io_out_bits_predicated,
                io_out_bits_fflags_valid,
  output [6:0]  io_out_bits_fflags_bits_uop_rob_idx,
  output [4:0]  io_out_bits_fflags_bits_flags
);

  assign io_in_0_ready = io_out_ready;
  assign io_in_1_ready = ~io_in_0_valid & io_out_ready;
  assign io_out_valid = io_in_0_valid | io_in_1_valid;
  assign io_out_bits_uop_uopc = io_in_0_valid ? io_in_0_bits_uop_uopc : io_in_1_bits_uop_uopc;
  assign io_out_bits_uop_br_mask = io_in_0_valid ? io_in_0_bits_uop_br_mask : io_in_1_bits_uop_br_mask;
  assign io_out_bits_uop_rob_idx = io_in_0_valid ? io_in_0_bits_uop_rob_idx : io_in_1_bits_uop_rob_idx;
  assign io_out_bits_uop_stq_idx = io_in_0_valid ? io_in_0_bits_uop_stq_idx : io_in_1_bits_uop_stq_idx;
  assign io_out_bits_uop_pdst = io_in_0_valid ? io_in_0_bits_uop_pdst : io_in_1_bits_uop_pdst;
  assign io_out_bits_uop_is_amo = io_in_0_valid ? io_in_0_bits_uop_is_amo : io_in_1_bits_uop_is_amo;
  assign io_out_bits_uop_uses_stq = io_in_0_valid ? io_in_0_bits_uop_uses_stq : io_in_1_bits_uop_uses_stq;
  assign io_out_bits_uop_dst_rtype = io_in_0_valid ? io_in_0_bits_uop_dst_rtype : io_in_1_bits_uop_dst_rtype;
  assign io_out_bits_uop_fp_val = io_in_0_valid ? io_in_0_bits_uop_fp_val : io_in_1_bits_uop_fp_val;
  assign io_out_bits_data = io_in_0_valid ? io_in_0_bits_data : io_in_1_bits_data;
  assign io_out_bits_predicated = io_in_0_valid ? io_in_0_bits_predicated : io_in_1_bits_predicated;
  assign io_out_bits_fflags_valid = io_in_0_valid ? io_in_0_bits_fflags_valid : io_in_1_bits_fflags_valid;
  assign io_out_bits_fflags_bits_uop_rob_idx = io_in_0_valid ? io_in_0_bits_fflags_bits_uop_rob_idx : io_in_1_bits_fflags_bits_uop_rob_idx;
  assign io_out_bits_fflags_bits_flags = io_in_0_valid ? io_in_0_bits_fflags_bits_flags : io_in_1_bits_fflags_bits_flags;
endmodule

