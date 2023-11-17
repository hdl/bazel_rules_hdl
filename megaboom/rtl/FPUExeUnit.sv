// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module FPUExeUnit(
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
                io_ll_iresp_ready,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input  [2:0]  io_fcsr_rm,
  output [9:0]  io_fu_types,
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
  output [4:0]  io_fresp_bits_fflags_bits_flags,
  output        io_ll_iresp_valid,
  output [6:0]  io_ll_iresp_bits_uop_uopc,
  output [19:0] io_ll_iresp_bits_uop_br_mask,
  output [6:0]  io_ll_iresp_bits_uop_rob_idx,
  output [4:0]  io_ll_iresp_bits_uop_stq_idx,
  output [6:0]  io_ll_iresp_bits_uop_pdst,
  output        io_ll_iresp_bits_uop_is_amo,
                io_ll_iresp_bits_uop_uses_stq,
  output [1:0]  io_ll_iresp_bits_uop_dst_rtype,
  output [64:0] io_ll_iresp_bits_data,
  output        io_ll_iresp_bits_predicated
);

  wire        _resp_arb_io_in_0_ready;
  wire        _resp_arb_io_in_1_ready;
  wire        _fp_sdq_io_enq_ready;
  wire        _fp_sdq_io_deq_valid;
  wire [6:0]  _fp_sdq_io_deq_bits_uop_uopc;
  wire [19:0] _fp_sdq_io_deq_bits_uop_br_mask;
  wire [6:0]  _fp_sdq_io_deq_bits_uop_rob_idx;
  wire [4:0]  _fp_sdq_io_deq_bits_uop_stq_idx;
  wire [6:0]  _fp_sdq_io_deq_bits_uop_pdst;
  wire        _fp_sdq_io_deq_bits_uop_is_amo;
  wire        _fp_sdq_io_deq_bits_uop_uses_stq;
  wire [1:0]  _fp_sdq_io_deq_bits_uop_dst_rtype;
  wire        _fp_sdq_io_deq_bits_uop_fp_val;
  wire [64:0] _fp_sdq_io_deq_bits_data;
  wire        _fp_sdq_io_deq_bits_predicated;
  wire        _fp_sdq_io_deq_bits_fflags_valid;
  wire [6:0]  _fp_sdq_io_deq_bits_fflags_bits_uop_rob_idx;
  wire [4:0]  _fp_sdq_io_deq_bits_fflags_bits_flags;
  wire        _fp_sdq_io_empty;
  wire        _queue_io_enq_ready;
  wire        _queue_io_deq_valid;
  wire [6:0]  _queue_io_deq_bits_uop_uopc;
  wire [19:0] _queue_io_deq_bits_uop_br_mask;
  wire [6:0]  _queue_io_deq_bits_uop_rob_idx;
  wire [4:0]  _queue_io_deq_bits_uop_stq_idx;
  wire [6:0]  _queue_io_deq_bits_uop_pdst;
  wire        _queue_io_deq_bits_uop_is_amo;
  wire        _queue_io_deq_bits_uop_uses_stq;
  wire [1:0]  _queue_io_deq_bits_uop_dst_rtype;
  wire        _queue_io_deq_bits_uop_fp_val;
  wire [64:0] _queue_io_deq_bits_data;
  wire        _queue_io_deq_bits_predicated;
  wire        _queue_io_deq_bits_fflags_valid;
  wire [6:0]  _queue_io_deq_bits_fflags_bits_uop_rob_idx;
  wire [4:0]  _queue_io_deq_bits_fflags_bits_flags;
  wire        _queue_io_empty;
  wire        _FDivSqrtUnit_io_req_ready;
  wire        _FDivSqrtUnit_io_resp_valid;
  wire [6:0]  _FDivSqrtUnit_io_resp_bits_uop_rob_idx;
  wire [6:0]  _FDivSqrtUnit_io_resp_bits_uop_pdst;
  wire        _FDivSqrtUnit_io_resp_bits_uop_is_amo;
  wire        _FDivSqrtUnit_io_resp_bits_uop_uses_ldq;
  wire        _FDivSqrtUnit_io_resp_bits_uop_uses_stq;
  wire [1:0]  _FDivSqrtUnit_io_resp_bits_uop_dst_rtype;
  wire        _FDivSqrtUnit_io_resp_bits_uop_fp_val;
  wire [64:0] _FDivSqrtUnit_io_resp_bits_data;
  wire        _FDivSqrtUnit_io_resp_bits_fflags_valid;
  wire [6:0]  _FDivSqrtUnit_io_resp_bits_fflags_bits_uop_rob_idx;
  wire [4:0]  _FDivSqrtUnit_io_resp_bits_fflags_bits_flags;
  wire        _FPUUnit_io_resp_valid;
  wire [6:0]  _FPUUnit_io_resp_bits_uop_uopc;
  wire [9:0]  _FPUUnit_io_resp_bits_uop_fu_code;
  wire [19:0] _FPUUnit_io_resp_bits_uop_br_mask;
  wire [6:0]  _FPUUnit_io_resp_bits_uop_rob_idx;
  wire [4:0]  _FPUUnit_io_resp_bits_uop_stq_idx;
  wire [6:0]  _FPUUnit_io_resp_bits_uop_pdst;
  wire        _FPUUnit_io_resp_bits_uop_is_amo;
  wire        _FPUUnit_io_resp_bits_uop_uses_ldq;
  wire        _FPUUnit_io_resp_bits_uop_uses_stq;
  wire [1:0]  _FPUUnit_io_resp_bits_uop_dst_rtype;
  wire        _FPUUnit_io_resp_bits_uop_fp_val;
  wire [64:0] _FPUUnit_io_resp_bits_data;
  wire        _FPUUnit_io_resp_bits_fflags_valid;
  wire [6:0]  _FPUUnit_io_resp_bits_fflags_bits_uop_rob_idx;
  wire [4:0]  _FPUUnit_io_resp_bits_fflags_bits_flags;
  wire        _fp_sdq_io_enq_valid_T_5 = io_req_valid & io_req_bits_uop_uopc == 7'h2 & (io_brupdate_b1_mispredict_mask & io_req_bits_uop_br_mask) == 20'h0;
  wire        fp_sdq_io_enq_bits_data_unrecoded_rawIn__isInf = (&(io_req_bits_rs2_data[63:62])) & ~(io_req_bits_rs2_data[61]);
  wire        fp_sdq_io_enq_bits_data_unrecoded_isSubnormal = $signed({1'h0, io_req_bits_rs2_data[63:52]}) < 13'sh402;
  wire [52:0] _fp_sdq_io_enq_bits_data_unrecoded_denormFract_T_1 = {1'h0, |(io_req_bits_rs2_data[63:61]), io_req_bits_rs2_data[51:1]} >> 6'h1 - io_req_bits_rs2_data[57:52];
  wire [51:0] fp_sdq_io_enq_bits_data_unrecoded_fractOut = fp_sdq_io_enq_bits_data_unrecoded_isSubnormal ? _fp_sdq_io_enq_bits_data_unrecoded_denormFract_T_1[51:0] : fp_sdq_io_enq_bits_data_unrecoded_rawIn__isInf ? 52'h0 : io_req_bits_rs2_data[51:0];
  wire [1:0]  _fp_sdq_io_enq_bits_data_prevUnrecoded_rawIn_isSpecial_T = {io_req_bits_rs2_data[52], io_req_bits_rs2_data[30]};
  wire        fp_sdq_io_enq_bits_data_prevUnrecoded_rawIn__isInf = (&_fp_sdq_io_enq_bits_data_prevUnrecoded_rawIn_isSpecial_T) & ~(io_req_bits_rs2_data[29]);
  wire        fp_sdq_io_enq_bits_data_prevUnrecoded_isSubnormal = $signed({1'h0, io_req_bits_rs2_data[52], io_req_bits_rs2_data[30:23]}) < 10'sh82;
  wire [23:0] _fp_sdq_io_enq_bits_data_prevUnrecoded_denormFract_T_1 = {1'h0, |{io_req_bits_rs2_data[52], io_req_bits_rs2_data[30:29]}, io_req_bits_rs2_data[22:1]} >> 5'h1 - io_req_bits_rs2_data[27:23];
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
    .io_resp_bits_uop_uopc                (_FPUUnit_io_resp_bits_uop_uopc),
    .io_resp_bits_uop_fu_code             (_FPUUnit_io_resp_bits_uop_fu_code),
    .io_resp_bits_uop_br_mask             (_FPUUnit_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_rob_idx             (_FPUUnit_io_resp_bits_uop_rob_idx),
    .io_resp_bits_uop_stq_idx             (_FPUUnit_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_pdst                (_FPUUnit_io_resp_bits_uop_pdst),
    .io_resp_bits_uop_is_amo              (_FPUUnit_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq            (_FPUUnit_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq            (_FPUUnit_io_resp_bits_uop_uses_stq),
    .io_resp_bits_uop_dst_rtype           (_FPUUnit_io_resp_bits_uop_dst_rtype),
    .io_resp_bits_uop_fp_val              (_FPUUnit_io_resp_bits_uop_fp_val),
    .io_resp_bits_data                    (_FPUUnit_io_resp_bits_data),
    .io_resp_bits_fflags_valid            (_FPUUnit_io_resp_bits_fflags_valid),
    .io_resp_bits_fflags_bits_uop_rob_idx (_FPUUnit_io_resp_bits_fflags_bits_uop_rob_idx),
    .io_resp_bits_fflags_bits_flags       (_FPUUnit_io_resp_bits_fflags_bits_flags)
  );
  FDivSqrtUnit FDivSqrtUnit (
    .clock                                (clock),
    .reset                                (reset),
    .io_req_valid                         (io_req_valid & io_req_bits_uop_fu_code[7]),
    .io_req_bits_uop_uopc                 (io_req_bits_uop_uopc),
    .io_req_bits_uop_br_mask              (io_req_bits_uop_br_mask),
    .io_req_bits_uop_imm_packed           (io_req_bits_uop_imm_packed),
    .io_req_bits_uop_rob_idx              (io_req_bits_uop_rob_idx),
    .io_req_bits_uop_pdst                 (io_req_bits_uop_pdst),
    .io_req_bits_uop_is_amo               (io_req_bits_uop_is_amo),
    .io_req_bits_uop_uses_ldq             (io_req_bits_uop_uses_ldq),
    .io_req_bits_uop_uses_stq             (io_req_bits_uop_uses_stq),
    .io_req_bits_uop_dst_rtype            (io_req_bits_uop_dst_rtype),
    .io_req_bits_uop_fp_val               (io_req_bits_uop_fp_val),
    .io_req_bits_rs1_data                 (io_req_bits_rs1_data),
    .io_req_bits_rs2_data                 (io_req_bits_rs2_data),
    .io_req_bits_kill                     (io_req_bits_kill),
    .io_resp_ready                        (~_FPUUnit_io_resp_valid),
    .io_brupdate_b1_resolve_mask          (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask       (io_brupdate_b1_mispredict_mask),
    .io_fcsr_rm                           (io_fcsr_rm),
    .io_req_ready                         (_FDivSqrtUnit_io_req_ready),
    .io_resp_valid                        (_FDivSqrtUnit_io_resp_valid),
    .io_resp_bits_uop_rob_idx             (_FDivSqrtUnit_io_resp_bits_uop_rob_idx),
    .io_resp_bits_uop_pdst                (_FDivSqrtUnit_io_resp_bits_uop_pdst),
    .io_resp_bits_uop_is_amo              (_FDivSqrtUnit_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq            (_FDivSqrtUnit_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq            (_FDivSqrtUnit_io_resp_bits_uop_uses_stq),
    .io_resp_bits_uop_dst_rtype           (_FDivSqrtUnit_io_resp_bits_uop_dst_rtype),
    .io_resp_bits_uop_fp_val              (_FDivSqrtUnit_io_resp_bits_uop_fp_val),
    .io_resp_bits_data                    (_FDivSqrtUnit_io_resp_bits_data),
    .io_resp_bits_fflags_valid            (_FDivSqrtUnit_io_resp_bits_fflags_valid),
    .io_resp_bits_fflags_bits_uop_rob_idx (_FDivSqrtUnit_io_resp_bits_fflags_bits_uop_rob_idx),
    .io_resp_bits_fflags_bits_flags       (_FDivSqrtUnit_io_resp_bits_fflags_bits_flags)
  );
  BranchKillableQueue_10 queue (
    .clock                               (clock),
    .reset                               (reset),
    .io_enq_valid                        (_FPUUnit_io_resp_valid & _FPUUnit_io_resp_bits_uop_fu_code[9] & _FPUUnit_io_resp_bits_uop_uopc != 7'h2),
    .io_enq_bits_uop_uopc                (_FPUUnit_io_resp_bits_uop_uopc),
    .io_enq_bits_uop_br_mask             (_FPUUnit_io_resp_bits_uop_br_mask),
    .io_enq_bits_uop_rob_idx             (_FPUUnit_io_resp_bits_uop_rob_idx),
    .io_enq_bits_uop_stq_idx             (_FPUUnit_io_resp_bits_uop_stq_idx),
    .io_enq_bits_uop_pdst                (_FPUUnit_io_resp_bits_uop_pdst),
    .io_enq_bits_uop_is_amo              (_FPUUnit_io_resp_bits_uop_is_amo),
    .io_enq_bits_uop_uses_stq            (_FPUUnit_io_resp_bits_uop_uses_stq),
    .io_enq_bits_uop_dst_rtype           (_FPUUnit_io_resp_bits_uop_dst_rtype),
    .io_enq_bits_uop_fp_val              (_FPUUnit_io_resp_bits_uop_fp_val),
    .io_enq_bits_data                    (_FPUUnit_io_resp_bits_data),
    .io_enq_bits_fflags_valid            (_FPUUnit_io_resp_bits_fflags_valid),
    .io_enq_bits_fflags_bits_uop_rob_idx (_FPUUnit_io_resp_bits_fflags_bits_uop_rob_idx),
    .io_enq_bits_fflags_bits_flags       (_FPUUnit_io_resp_bits_fflags_bits_flags),
    .io_deq_ready                        (_resp_arb_io_in_0_ready),
    .io_brupdate_b1_resolve_mask         (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask      (io_brupdate_b1_mispredict_mask),
    .io_flush                            (io_req_bits_kill),
    .io_enq_ready                        (_queue_io_enq_ready),
    .io_deq_valid                        (_queue_io_deq_valid),
    .io_deq_bits_uop_uopc                (_queue_io_deq_bits_uop_uopc),
    .io_deq_bits_uop_br_mask             (_queue_io_deq_bits_uop_br_mask),
    .io_deq_bits_uop_rob_idx             (_queue_io_deq_bits_uop_rob_idx),
    .io_deq_bits_uop_stq_idx             (_queue_io_deq_bits_uop_stq_idx),
    .io_deq_bits_uop_pdst                (_queue_io_deq_bits_uop_pdst),
    .io_deq_bits_uop_is_amo              (_queue_io_deq_bits_uop_is_amo),
    .io_deq_bits_uop_uses_stq            (_queue_io_deq_bits_uop_uses_stq),
    .io_deq_bits_uop_dst_rtype           (_queue_io_deq_bits_uop_dst_rtype),
    .io_deq_bits_uop_fp_val              (_queue_io_deq_bits_uop_fp_val),
    .io_deq_bits_data                    (_queue_io_deq_bits_data),
    .io_deq_bits_predicated              (_queue_io_deq_bits_predicated),
    .io_deq_bits_fflags_valid            (_queue_io_deq_bits_fflags_valid),
    .io_deq_bits_fflags_bits_uop_rob_idx (_queue_io_deq_bits_fflags_bits_uop_rob_idx),
    .io_deq_bits_fflags_bits_flags       (_queue_io_deq_bits_fflags_bits_flags),
    .io_empty                            (_queue_io_empty)
  );
  BranchKillableQueue_11 fp_sdq (
    .clock                               (clock),
    .reset                               (reset),
    .io_enq_valid                        (_fp_sdq_io_enq_valid_T_5),
    .io_enq_bits_uop_uopc                (io_req_bits_uop_uopc),
    .io_enq_bits_uop_br_mask             (io_req_bits_uop_br_mask),
    .io_enq_bits_uop_rob_idx             (io_req_bits_uop_rob_idx),
    .io_enq_bits_uop_stq_idx             (io_req_bits_uop_stq_idx),
    .io_enq_bits_uop_pdst                (io_req_bits_uop_pdst),
    .io_enq_bits_uop_is_amo              (io_req_bits_uop_is_amo),
    .io_enq_bits_uop_uses_stq            (io_req_bits_uop_uses_stq),
    .io_enq_bits_uop_dst_rtype           (io_req_bits_uop_dst_rtype),
    .io_enq_bits_uop_fp_val              (io_req_bits_uop_fp_val),
    .io_enq_bits_data                    ({1'h0, io_req_bits_rs2_data[64], (fp_sdq_io_enq_bits_data_unrecoded_isSubnormal ? 11'h0 : io_req_bits_rs2_data[62:52] + 11'h3FF) | {11{(&(io_req_bits_rs2_data[63:62])) & io_req_bits_rs2_data[61] | fp_sdq_io_enq_bits_data_unrecoded_rawIn__isInf}}, fp_sdq_io_enq_bits_data_unrecoded_fractOut[51:32], (&(io_req_bits_rs2_data[63:61])) ? {io_req_bits_rs2_data[31], (fp_sdq_io_enq_bits_data_prevUnrecoded_isSubnormal ? 8'h0 : io_req_bits_rs2_data[30:23] + 8'h7F) | {8{(&_fp_sdq_io_enq_bits_data_prevUnrecoded_rawIn_isSpecial_T) & io_req_bits_rs2_data[29] | fp_sdq_io_enq_bits_data_prevUnrecoded_rawIn__isInf}}, fp_sdq_io_enq_bits_data_prevUnrecoded_isSubnormal ? _fp_sdq_io_enq_bits_data_prevUnrecoded_denormFract_T_1[22:0] : fp_sdq_io_enq_bits_data_prevUnrecoded_rawIn__isInf ? 23'h0 : io_req_bits_rs2_data[22:0]} : fp_sdq_io_enq_bits_data_unrecoded_fractOut[31:0]}),
    .io_deq_ready                        (_resp_arb_io_in_1_ready),
    .io_brupdate_b1_resolve_mask         (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask      (io_brupdate_b1_mispredict_mask),
    .io_flush                            (io_req_bits_kill),
    .io_enq_ready                        (_fp_sdq_io_enq_ready),
    .io_deq_valid                        (_fp_sdq_io_deq_valid),
    .io_deq_bits_uop_uopc                (_fp_sdq_io_deq_bits_uop_uopc),
    .io_deq_bits_uop_br_mask             (_fp_sdq_io_deq_bits_uop_br_mask),
    .io_deq_bits_uop_rob_idx             (_fp_sdq_io_deq_bits_uop_rob_idx),
    .io_deq_bits_uop_stq_idx             (_fp_sdq_io_deq_bits_uop_stq_idx),
    .io_deq_bits_uop_pdst                (_fp_sdq_io_deq_bits_uop_pdst),
    .io_deq_bits_uop_is_amo              (_fp_sdq_io_deq_bits_uop_is_amo),
    .io_deq_bits_uop_uses_stq            (_fp_sdq_io_deq_bits_uop_uses_stq),
    .io_deq_bits_uop_dst_rtype           (_fp_sdq_io_deq_bits_uop_dst_rtype),
    .io_deq_bits_uop_fp_val              (_fp_sdq_io_deq_bits_uop_fp_val),
    .io_deq_bits_data                    (_fp_sdq_io_deq_bits_data),
    .io_deq_bits_predicated              (_fp_sdq_io_deq_bits_predicated),
    .io_deq_bits_fflags_valid            (_fp_sdq_io_deq_bits_fflags_valid),
    .io_deq_bits_fflags_bits_uop_rob_idx (_fp_sdq_io_deq_bits_fflags_bits_uop_rob_idx),
    .io_deq_bits_fflags_bits_flags       (_fp_sdq_io_deq_bits_fflags_bits_flags),
    .io_empty                            (_fp_sdq_io_empty)
  );
  Arbiter_16 resp_arb (
    .io_in_0_valid                        (_queue_io_deq_valid),
    .io_in_0_bits_uop_uopc                (_queue_io_deq_bits_uop_uopc),
    .io_in_0_bits_uop_br_mask             (_queue_io_deq_bits_uop_br_mask),
    .io_in_0_bits_uop_rob_idx             (_queue_io_deq_bits_uop_rob_idx),
    .io_in_0_bits_uop_stq_idx             (_queue_io_deq_bits_uop_stq_idx),
    .io_in_0_bits_uop_pdst                (_queue_io_deq_bits_uop_pdst),
    .io_in_0_bits_uop_is_amo              (_queue_io_deq_bits_uop_is_amo),
    .io_in_0_bits_uop_uses_stq            (_queue_io_deq_bits_uop_uses_stq),
    .io_in_0_bits_uop_dst_rtype           (_queue_io_deq_bits_uop_dst_rtype),
    .io_in_0_bits_uop_fp_val              (_queue_io_deq_bits_uop_fp_val),
    .io_in_0_bits_data                    (_queue_io_deq_bits_data),
    .io_in_0_bits_predicated              (_queue_io_deq_bits_predicated),
    .io_in_0_bits_fflags_valid            (_queue_io_deq_bits_fflags_valid),
    .io_in_0_bits_fflags_bits_uop_rob_idx (_queue_io_deq_bits_fflags_bits_uop_rob_idx),
    .io_in_0_bits_fflags_bits_flags       (_queue_io_deq_bits_fflags_bits_flags),
    .io_in_1_valid                        (_fp_sdq_io_deq_valid),
    .io_in_1_bits_uop_uopc                (_fp_sdq_io_deq_bits_uop_uopc),
    .io_in_1_bits_uop_br_mask             (_fp_sdq_io_deq_bits_uop_br_mask),
    .io_in_1_bits_uop_rob_idx             (_fp_sdq_io_deq_bits_uop_rob_idx),
    .io_in_1_bits_uop_stq_idx             (_fp_sdq_io_deq_bits_uop_stq_idx),
    .io_in_1_bits_uop_pdst                (_fp_sdq_io_deq_bits_uop_pdst),
    .io_in_1_bits_uop_is_amo              (_fp_sdq_io_deq_bits_uop_is_amo),
    .io_in_1_bits_uop_uses_stq            (_fp_sdq_io_deq_bits_uop_uses_stq),
    .io_in_1_bits_uop_dst_rtype           (_fp_sdq_io_deq_bits_uop_dst_rtype),
    .io_in_1_bits_uop_fp_val              (_fp_sdq_io_deq_bits_uop_fp_val),
    .io_in_1_bits_data                    (_fp_sdq_io_deq_bits_data),
    .io_in_1_bits_predicated              (_fp_sdq_io_deq_bits_predicated),
    .io_in_1_bits_fflags_valid            (_fp_sdq_io_deq_bits_fflags_valid),
    .io_in_1_bits_fflags_bits_uop_rob_idx (_fp_sdq_io_deq_bits_fflags_bits_uop_rob_idx),
    .io_in_1_bits_fflags_bits_flags       (_fp_sdq_io_deq_bits_fflags_bits_flags),
    .io_out_ready                         (io_ll_iresp_ready),
    .io_in_0_ready                        (_resp_arb_io_in_0_ready),
    .io_in_1_ready                        (_resp_arb_io_in_1_ready),
    .io_out_valid                         (io_ll_iresp_valid),
    .io_out_bits_uop_uopc                 (io_ll_iresp_bits_uop_uopc),
    .io_out_bits_uop_br_mask              (io_ll_iresp_bits_uop_br_mask),
    .io_out_bits_uop_rob_idx              (io_ll_iresp_bits_uop_rob_idx),
    .io_out_bits_uop_stq_idx              (io_ll_iresp_bits_uop_stq_idx),
    .io_out_bits_uop_pdst                 (io_ll_iresp_bits_uop_pdst),
    .io_out_bits_uop_is_amo               (io_ll_iresp_bits_uop_is_amo),
    .io_out_bits_uop_uses_stq             (io_ll_iresp_bits_uop_uses_stq),
    .io_out_bits_uop_dst_rtype            (io_ll_iresp_bits_uop_dst_rtype),
    .io_out_bits_uop_fp_val               (/* unused */),
    .io_out_bits_data                     (io_ll_iresp_bits_data),
    .io_out_bits_predicated               (io_ll_iresp_bits_predicated),
    .io_out_bits_fflags_valid             (/* unused */),
    .io_out_bits_fflags_bits_uop_rob_idx  (/* unused */),
    .io_out_bits_fflags_bits_flags        (/* unused */)
  );
  assign io_fu_types = {_queue_io_empty & _fp_sdq_io_empty, 1'h0, ~(~_FDivSqrtUnit_io_req_ready | io_req_valid & io_req_bits_uop_fu_code[7]), 7'h40};
  assign io_fresp_valid = (_FPUUnit_io_resp_valid | _FDivSqrtUnit_io_resp_valid) & ~(_FPUUnit_io_resp_valid & _FPUUnit_io_resp_bits_uop_fu_code[9]);
  assign io_fresp_bits_uop_rob_idx = _FPUUnit_io_resp_valid ? _FPUUnit_io_resp_bits_uop_rob_idx : _FDivSqrtUnit_io_resp_bits_uop_rob_idx;
  assign io_fresp_bits_uop_pdst = _FPUUnit_io_resp_valid ? _FPUUnit_io_resp_bits_uop_pdst : _FDivSqrtUnit_io_resp_bits_uop_pdst;
  assign io_fresp_bits_uop_is_amo = _FPUUnit_io_resp_valid ? _FPUUnit_io_resp_bits_uop_is_amo : _FDivSqrtUnit_io_resp_bits_uop_is_amo;
  assign io_fresp_bits_uop_uses_ldq = _FPUUnit_io_resp_valid ? _FPUUnit_io_resp_bits_uop_uses_ldq : _FDivSqrtUnit_io_resp_bits_uop_uses_ldq;
  assign io_fresp_bits_uop_uses_stq = _FPUUnit_io_resp_valid ? _FPUUnit_io_resp_bits_uop_uses_stq : _FDivSqrtUnit_io_resp_bits_uop_uses_stq;
  assign io_fresp_bits_uop_dst_rtype = _FPUUnit_io_resp_valid ? _FPUUnit_io_resp_bits_uop_dst_rtype : _FDivSqrtUnit_io_resp_bits_uop_dst_rtype;
  assign io_fresp_bits_uop_fp_val = _FPUUnit_io_resp_valid ? _FPUUnit_io_resp_bits_uop_fp_val : _FDivSqrtUnit_io_resp_bits_uop_fp_val;
  assign io_fresp_bits_data = _FPUUnit_io_resp_valid ? _FPUUnit_io_resp_bits_data : _FDivSqrtUnit_io_resp_bits_data;
  assign io_fresp_bits_fflags_valid = _FPUUnit_io_resp_valid ? _FPUUnit_io_resp_bits_fflags_valid : _FDivSqrtUnit_io_resp_bits_fflags_valid;
  assign io_fresp_bits_fflags_bits_uop_rob_idx = _FPUUnit_io_resp_valid ? _FPUUnit_io_resp_bits_fflags_bits_uop_rob_idx : _FDivSqrtUnit_io_resp_bits_fflags_bits_uop_rob_idx;
  assign io_fresp_bits_fflags_bits_flags = _FPUUnit_io_resp_valid ? _FPUUnit_io_resp_bits_fflags_bits_flags : _FDivSqrtUnit_io_resp_bits_fflags_bits_flags;
endmodule

