// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module FPUExeUnit_1(
  input         clock,
                reset,
                io_req_valid,
  input  [6:0]  io_req_bits_uop_uopc,
  input  [9:0]  io_req_bits_uop_fu_code,
  input  [19:0] io_req_bits_uop_br_mask,
                io_req_bits_uop_imm_packed,
  input  [6:0]  io_req_bits_uop_rob_idx,
  input  [4:0]  io_req_bits_uop_stq_idx,
  input  [6:0]  io_req_bits_uop_pdst,
  input         io_req_bits_uop_is_amo,
                io_req_bits_uop_uses_ldq,
                io_req_bits_uop_uses_stq,
  input  [1:0]  io_req_bits_uop_dst_rtype,
  input         io_req_bits_uop_fp_val,
  input  [64:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
                io_req_bits_rs3_data,
  input         io_req_bits_kill,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input  [2:0]  io_fcsr_rm,
  output        io_fresp_valid,
  output [6:0]  io_fresp_bits_uop_rob_idx,
                io_fresp_bits_uop_pdst,
  output        io_fresp_bits_uop_is_amo,
                io_fresp_bits_uop_uses_ldq,
                io_fresp_bits_uop_uses_stq,
  output [1:0]  io_fresp_bits_uop_dst_rtype,
  output        io_fresp_bits_uop_fp_val,
  output [64:0] io_fresp_bits_data,
  output        io_fresp_bits_fflags_valid,
  output [6:0]  io_fresp_bits_fflags_bits_uop_rob_idx,
  output [4:0]  io_fresp_bits_fflags_bits_flags
);

  wire       _FPUUnit_io_resp_valid;
  wire [9:0] _FPUUnit_io_resp_bits_uop_fu_code;
  wire       _FPUUnit_io_resp_bits_fflags_valid;
  wire [6:0] _FPUUnit_io_resp_bits_fflags_bits_uop_rob_idx;
  wire [4:0] _FPUUnit_io_resp_bits_fflags_bits_flags;
  FPUUnit FPUUnit (
    .clock                                (clock),
    .reset                                (reset),
    .io_req_valid                         (io_req_valid & (io_req_bits_uop_fu_code[6] | io_req_bits_uop_fu_code[9])),
    .io_req_bits_uop_uopc                 (io_req_bits_uop_uopc),
    .io_req_bits_uop_fu_code              (io_req_bits_uop_fu_code),
    .io_req_bits_uop_br_mask              (io_req_bits_uop_br_mask),
    .io_req_bits_uop_imm_packed           (io_req_bits_uop_imm_packed),
    .io_req_bits_uop_rob_idx              (io_req_bits_uop_rob_idx),
    .io_req_bits_uop_stq_idx              (io_req_bits_uop_stq_idx),
    .io_req_bits_uop_pdst                 (io_req_bits_uop_pdst),
    .io_req_bits_uop_is_amo               (io_req_bits_uop_is_amo),
    .io_req_bits_uop_uses_ldq             (io_req_bits_uop_uses_ldq),
    .io_req_bits_uop_uses_stq             (io_req_bits_uop_uses_stq),
    .io_req_bits_uop_dst_rtype            (io_req_bits_uop_dst_rtype),
    .io_req_bits_uop_fp_val               (io_req_bits_uop_fp_val),
    .io_req_bits_rs1_data                 (io_req_bits_rs1_data),
    .io_req_bits_rs2_data                 (io_req_bits_rs2_data),
    .io_req_bits_rs3_data                 (io_req_bits_rs3_data),
    .io_req_bits_kill                     (io_req_bits_kill),
    .io_brupdate_b1_resolve_mask          (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask       (io_brupdate_b1_mispredict_mask),
    .io_fcsr_rm                           (io_fcsr_rm),
    .io_resp_valid                        (_FPUUnit_io_resp_valid),
    .io_resp_bits_uop_uopc                (/* unused */),
    .io_resp_bits_uop_fu_code             (_FPUUnit_io_resp_bits_uop_fu_code),
    .io_resp_bits_uop_br_mask             (/* unused */),
    .io_resp_bits_uop_rob_idx             (io_fresp_bits_uop_rob_idx),
    .io_resp_bits_uop_stq_idx             (/* unused */),
    .io_resp_bits_uop_pdst                (io_fresp_bits_uop_pdst),
    .io_resp_bits_uop_is_amo              (io_fresp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq            (io_fresp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq            (io_fresp_bits_uop_uses_stq),
    .io_resp_bits_uop_dst_rtype           (io_fresp_bits_uop_dst_rtype),
    .io_resp_bits_uop_fp_val              (io_fresp_bits_uop_fp_val),
    .io_resp_bits_data                    (io_fresp_bits_data),
    .io_resp_bits_fflags_valid            (_FPUUnit_io_resp_bits_fflags_valid),
    .io_resp_bits_fflags_bits_uop_rob_idx (_FPUUnit_io_resp_bits_fflags_bits_uop_rob_idx),
    .io_resp_bits_fflags_bits_flags       (_FPUUnit_io_resp_bits_fflags_bits_flags)
  );
  assign io_fresp_valid = _FPUUnit_io_resp_valid & ~(_FPUUnit_io_resp_valid & _FPUUnit_io_resp_bits_uop_fu_code[9]);
  assign io_fresp_bits_fflags_valid = _FPUUnit_io_resp_valid & _FPUUnit_io_resp_bits_fflags_valid;
  assign io_fresp_bits_fflags_bits_uop_rob_idx = _FPUUnit_io_resp_valid ? _FPUUnit_io_resp_bits_fflags_bits_uop_rob_idx : 7'h0;
  assign io_fresp_bits_fflags_bits_flags = _FPUUnit_io_resp_valid ? _FPUUnit_io_resp_bits_fflags_bits_flags : 5'h0;
endmodule

