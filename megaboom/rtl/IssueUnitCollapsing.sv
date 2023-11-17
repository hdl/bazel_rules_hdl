// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module IssueUnitCollapsing(
  input         clock,
                reset,
                io_dis_uops_0_valid,
  input  [6:0]  io_dis_uops_0_bits_uopc,
  input  [9:0]  io_dis_uops_0_bits_fu_code,
  input  [19:0] io_dis_uops_0_bits_br_mask,
                io_dis_uops_0_bits_imm_packed,
  input  [6:0]  io_dis_uops_0_bits_rob_idx,
  input  [4:0]  io_dis_uops_0_bits_stq_idx,
  input  [6:0]  io_dis_uops_0_bits_pdst,
                io_dis_uops_0_bits_prs1,
                io_dis_uops_0_bits_prs2,
                io_dis_uops_0_bits_prs3,
  input         io_dis_uops_0_bits_prs1_busy,
                io_dis_uops_0_bits_prs2_busy,
                io_dis_uops_0_bits_prs3_busy,
                io_dis_uops_0_bits_exception,
  input  [4:0]  io_dis_uops_0_bits_mem_cmd,
  input         io_dis_uops_0_bits_is_fence,
                io_dis_uops_0_bits_is_fencei,
                io_dis_uops_0_bits_is_amo,
                io_dis_uops_0_bits_uses_ldq,
                io_dis_uops_0_bits_uses_stq,
  input  [1:0]  io_dis_uops_0_bits_dst_rtype,
  input         io_dis_uops_0_bits_fp_val,
                io_dis_uops_1_valid,
  input  [6:0]  io_dis_uops_1_bits_uopc,
  input  [9:0]  io_dis_uops_1_bits_fu_code,
  input  [19:0] io_dis_uops_1_bits_br_mask,
                io_dis_uops_1_bits_imm_packed,
  input  [6:0]  io_dis_uops_1_bits_rob_idx,
  input  [4:0]  io_dis_uops_1_bits_stq_idx,
  input  [6:0]  io_dis_uops_1_bits_pdst,
                io_dis_uops_1_bits_prs1,
                io_dis_uops_1_bits_prs2,
                io_dis_uops_1_bits_prs3,
  input         io_dis_uops_1_bits_prs1_busy,
                io_dis_uops_1_bits_prs2_busy,
                io_dis_uops_1_bits_prs3_busy,
                io_dis_uops_1_bits_exception,
  input  [4:0]  io_dis_uops_1_bits_mem_cmd,
  input         io_dis_uops_1_bits_is_fence,
                io_dis_uops_1_bits_is_fencei,
                io_dis_uops_1_bits_is_amo,
                io_dis_uops_1_bits_uses_ldq,
                io_dis_uops_1_bits_uses_stq,
  input  [1:0]  io_dis_uops_1_bits_dst_rtype,
  input         io_dis_uops_1_bits_fp_val,
                io_dis_uops_2_valid,
  input  [6:0]  io_dis_uops_2_bits_uopc,
  input  [9:0]  io_dis_uops_2_bits_fu_code,
  input  [19:0] io_dis_uops_2_bits_br_mask,
                io_dis_uops_2_bits_imm_packed,
  input  [6:0]  io_dis_uops_2_bits_rob_idx,
  input  [4:0]  io_dis_uops_2_bits_stq_idx,
  input  [6:0]  io_dis_uops_2_bits_pdst,
                io_dis_uops_2_bits_prs1,
                io_dis_uops_2_bits_prs2,
                io_dis_uops_2_bits_prs3,
  input         io_dis_uops_2_bits_prs1_busy,
                io_dis_uops_2_bits_prs2_busy,
                io_dis_uops_2_bits_prs3_busy,
                io_dis_uops_2_bits_exception,
  input  [4:0]  io_dis_uops_2_bits_mem_cmd,
  input         io_dis_uops_2_bits_is_fence,
                io_dis_uops_2_bits_is_fencei,
                io_dis_uops_2_bits_is_amo,
                io_dis_uops_2_bits_uses_ldq,
                io_dis_uops_2_bits_uses_stq,
  input  [1:0]  io_dis_uops_2_bits_dst_rtype,
  input         io_dis_uops_2_bits_fp_val,
                io_dis_uops_3_valid,
  input  [6:0]  io_dis_uops_3_bits_uopc,
  input  [9:0]  io_dis_uops_3_bits_fu_code,
  input  [19:0] io_dis_uops_3_bits_br_mask,
                io_dis_uops_3_bits_imm_packed,
  input  [6:0]  io_dis_uops_3_bits_rob_idx,
  input  [4:0]  io_dis_uops_3_bits_stq_idx,
  input  [6:0]  io_dis_uops_3_bits_pdst,
                io_dis_uops_3_bits_prs1,
                io_dis_uops_3_bits_prs2,
                io_dis_uops_3_bits_prs3,
  input         io_dis_uops_3_bits_prs1_busy,
                io_dis_uops_3_bits_prs2_busy,
                io_dis_uops_3_bits_prs3_busy,
                io_dis_uops_3_bits_exception,
  input  [4:0]  io_dis_uops_3_bits_mem_cmd,
  input         io_dis_uops_3_bits_is_fence,
                io_dis_uops_3_bits_is_fencei,
                io_dis_uops_3_bits_is_amo,
                io_dis_uops_3_bits_uses_ldq,
                io_dis_uops_3_bits_uses_stq,
  input  [1:0]  io_dis_uops_3_bits_dst_rtype,
  input         io_dis_uops_3_bits_fp_val,
                io_wakeup_ports_0_valid,
  input  [6:0]  io_wakeup_ports_0_bits_pdst,
  input         io_wakeup_ports_1_valid,
  input  [6:0]  io_wakeup_ports_1_bits_pdst,
  input         io_wakeup_ports_2_valid,
  input  [6:0]  io_wakeup_ports_2_bits_pdst,
  input         io_wakeup_ports_3_valid,
  input  [6:0]  io_wakeup_ports_3_bits_pdst,
  input  [9:0]  io_fu_types_0,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input         io_flush_pipeline,
  output        io_dis_uops_0_ready,
                io_dis_uops_1_ready,
                io_dis_uops_2_ready,
                io_dis_uops_3_ready,
                io_iss_valids_0,
                io_iss_valids_1,
  output [6:0]  io_iss_uops_0_uopc,
  output [9:0]  io_iss_uops_0_fu_code,
  output [19:0] io_iss_uops_0_br_mask,
                io_iss_uops_0_imm_packed,
  output [6:0]  io_iss_uops_0_rob_idx,
  output [4:0]  io_iss_uops_0_stq_idx,
  output [6:0]  io_iss_uops_0_pdst,
                io_iss_uops_0_prs1,
                io_iss_uops_0_prs2,
                io_iss_uops_0_prs3,
  output [4:0]  io_iss_uops_0_mem_cmd,
  output        io_iss_uops_0_is_amo,
                io_iss_uops_0_uses_ldq,
                io_iss_uops_0_uses_stq,
  output [1:0]  io_iss_uops_0_dst_rtype,
  output        io_iss_uops_0_fp_val,
  output [6:0]  io_iss_uops_1_uopc,
  output [9:0]  io_iss_uops_1_fu_code,
  output [19:0] io_iss_uops_1_br_mask,
                io_iss_uops_1_imm_packed,
  output [6:0]  io_iss_uops_1_rob_idx,
  output [4:0]  io_iss_uops_1_stq_idx,
  output [6:0]  io_iss_uops_1_pdst,
                io_iss_uops_1_prs1,
                io_iss_uops_1_prs2,
                io_iss_uops_1_prs3,
  output [4:0]  io_iss_uops_1_mem_cmd,
  output        io_iss_uops_1_is_amo,
                io_iss_uops_1_uses_ldq,
                io_iss_uops_1_uses_stq,
  output [1:0]  io_iss_uops_1_dst_rtype,
  output        io_iss_uops_1_fp_val
);

  wire [3:0]  _GEN_69;
  wire [3:0]  _GEN_67;
  wire [3:0]  _GEN_65;
  wire [3:0]  _GEN_63;
  wire [3:0]  _GEN_61;
  wire [3:0]  _GEN_59;
  wire [3:0]  _GEN_57;
  wire [3:0]  _GEN_55;
  wire [3:0]  _GEN_53;
  wire [3:0]  _GEN_51;
  wire [3:0]  _GEN_49;
  wire [3:0]  _GEN_47;
  wire [3:0]  _GEN_45;
  wire [3:0]  _GEN_43;
  wire [3:0]  _GEN_41;
  wire [3:0]  _GEN_39;
  wire [3:0]  _GEN_37;
  wire [3:0]  _GEN_35;
  wire [3:0]  _GEN_33;
  wire [3:0]  _GEN_31;
  wire [3:0]  _GEN_29;
  wire [3:0]  _GEN_27;
  wire [3:0]  _GEN_25;
  wire [3:0]  _GEN_23;
  wire [3:0]  _GEN_21;
  wire [3:0]  _GEN_19;
  wire [3:0]  _GEN_17;
  wire [3:0]  _GEN_15;
  wire [3:0]  _GEN_13;
  wire [1:0]  _GEN_11_1to0;
  wire        _slots_31_io_valid;
  wire        _slots_31_io_will_be_valid;
  wire        _slots_31_io_request;
  wire [6:0]  _slots_31_io_out_uop_uopc;
  wire [9:0]  _slots_31_io_out_uop_fu_code;
  wire [1:0]  _slots_31_io_out_uop_iw_state;
  wire [19:0] _slots_31_io_out_uop_br_mask;
  wire [19:0] _slots_31_io_out_uop_imm_packed;
  wire [6:0]  _slots_31_io_out_uop_rob_idx;
  wire [4:0]  _slots_31_io_out_uop_stq_idx;
  wire [6:0]  _slots_31_io_out_uop_pdst;
  wire [6:0]  _slots_31_io_out_uop_prs1;
  wire [6:0]  _slots_31_io_out_uop_prs2;
  wire [6:0]  _slots_31_io_out_uop_prs3;
  wire        _slots_31_io_out_uop_prs1_busy;
  wire        _slots_31_io_out_uop_prs2_busy;
  wire        _slots_31_io_out_uop_prs3_busy;
  wire        _slots_31_io_out_uop_ppred_busy;
  wire [4:0]  _slots_31_io_out_uop_mem_cmd;
  wire        _slots_31_io_out_uop_is_amo;
  wire        _slots_31_io_out_uop_uses_ldq;
  wire        _slots_31_io_out_uop_uses_stq;
  wire [1:0]  _slots_31_io_out_uop_dst_rtype;
  wire        _slots_31_io_out_uop_fp_val;
  wire [6:0]  _slots_31_io_uop_uopc;
  wire [9:0]  _slots_31_io_uop_fu_code;
  wire [19:0] _slots_31_io_uop_br_mask;
  wire [19:0] _slots_31_io_uop_imm_packed;
  wire [6:0]  _slots_31_io_uop_rob_idx;
  wire [4:0]  _slots_31_io_uop_stq_idx;
  wire [6:0]  _slots_31_io_uop_pdst;
  wire [6:0]  _slots_31_io_uop_prs1;
  wire [6:0]  _slots_31_io_uop_prs2;
  wire [6:0]  _slots_31_io_uop_prs3;
  wire [4:0]  _slots_31_io_uop_mem_cmd;
  wire        _slots_31_io_uop_is_amo;
  wire        _slots_31_io_uop_uses_ldq;
  wire        _slots_31_io_uop_uses_stq;
  wire [1:0]  _slots_31_io_uop_dst_rtype;
  wire        _slots_31_io_uop_fp_val;
  wire        _slots_30_io_valid;
  wire        _slots_30_io_will_be_valid;
  wire        _slots_30_io_request;
  wire [6:0]  _slots_30_io_out_uop_uopc;
  wire [9:0]  _slots_30_io_out_uop_fu_code;
  wire [1:0]  _slots_30_io_out_uop_iw_state;
  wire [19:0] _slots_30_io_out_uop_br_mask;
  wire [19:0] _slots_30_io_out_uop_imm_packed;
  wire [6:0]  _slots_30_io_out_uop_rob_idx;
  wire [4:0]  _slots_30_io_out_uop_stq_idx;
  wire [6:0]  _slots_30_io_out_uop_pdst;
  wire [6:0]  _slots_30_io_out_uop_prs1;
  wire [6:0]  _slots_30_io_out_uop_prs2;
  wire [6:0]  _slots_30_io_out_uop_prs3;
  wire        _slots_30_io_out_uop_prs1_busy;
  wire        _slots_30_io_out_uop_prs2_busy;
  wire        _slots_30_io_out_uop_prs3_busy;
  wire        _slots_30_io_out_uop_ppred_busy;
  wire [4:0]  _slots_30_io_out_uop_mem_cmd;
  wire        _slots_30_io_out_uop_is_amo;
  wire        _slots_30_io_out_uop_uses_ldq;
  wire        _slots_30_io_out_uop_uses_stq;
  wire [1:0]  _slots_30_io_out_uop_dst_rtype;
  wire        _slots_30_io_out_uop_fp_val;
  wire [6:0]  _slots_30_io_uop_uopc;
  wire [9:0]  _slots_30_io_uop_fu_code;
  wire [19:0] _slots_30_io_uop_br_mask;
  wire [19:0] _slots_30_io_uop_imm_packed;
  wire [6:0]  _slots_30_io_uop_rob_idx;
  wire [4:0]  _slots_30_io_uop_stq_idx;
  wire [6:0]  _slots_30_io_uop_pdst;
  wire [6:0]  _slots_30_io_uop_prs1;
  wire [6:0]  _slots_30_io_uop_prs2;
  wire [6:0]  _slots_30_io_uop_prs3;
  wire [4:0]  _slots_30_io_uop_mem_cmd;
  wire        _slots_30_io_uop_is_amo;
  wire        _slots_30_io_uop_uses_ldq;
  wire        _slots_30_io_uop_uses_stq;
  wire [1:0]  _slots_30_io_uop_dst_rtype;
  wire        _slots_30_io_uop_fp_val;
  wire        _slots_29_io_valid;
  wire        _slots_29_io_will_be_valid;
  wire        _slots_29_io_request;
  wire [6:0]  _slots_29_io_out_uop_uopc;
  wire [9:0]  _slots_29_io_out_uop_fu_code;
  wire [1:0]  _slots_29_io_out_uop_iw_state;
  wire [19:0] _slots_29_io_out_uop_br_mask;
  wire [19:0] _slots_29_io_out_uop_imm_packed;
  wire [6:0]  _slots_29_io_out_uop_rob_idx;
  wire [4:0]  _slots_29_io_out_uop_stq_idx;
  wire [6:0]  _slots_29_io_out_uop_pdst;
  wire [6:0]  _slots_29_io_out_uop_prs1;
  wire [6:0]  _slots_29_io_out_uop_prs2;
  wire [6:0]  _slots_29_io_out_uop_prs3;
  wire        _slots_29_io_out_uop_prs1_busy;
  wire        _slots_29_io_out_uop_prs2_busy;
  wire        _slots_29_io_out_uop_prs3_busy;
  wire        _slots_29_io_out_uop_ppred_busy;
  wire [4:0]  _slots_29_io_out_uop_mem_cmd;
  wire        _slots_29_io_out_uop_is_amo;
  wire        _slots_29_io_out_uop_uses_ldq;
  wire        _slots_29_io_out_uop_uses_stq;
  wire [1:0]  _slots_29_io_out_uop_dst_rtype;
  wire        _slots_29_io_out_uop_fp_val;
  wire [6:0]  _slots_29_io_uop_uopc;
  wire [9:0]  _slots_29_io_uop_fu_code;
  wire [19:0] _slots_29_io_uop_br_mask;
  wire [19:0] _slots_29_io_uop_imm_packed;
  wire [6:0]  _slots_29_io_uop_rob_idx;
  wire [4:0]  _slots_29_io_uop_stq_idx;
  wire [6:0]  _slots_29_io_uop_pdst;
  wire [6:0]  _slots_29_io_uop_prs1;
  wire [6:0]  _slots_29_io_uop_prs2;
  wire [6:0]  _slots_29_io_uop_prs3;
  wire [4:0]  _slots_29_io_uop_mem_cmd;
  wire        _slots_29_io_uop_is_amo;
  wire        _slots_29_io_uop_uses_ldq;
  wire        _slots_29_io_uop_uses_stq;
  wire [1:0]  _slots_29_io_uop_dst_rtype;
  wire        _slots_29_io_uop_fp_val;
  wire        _slots_28_io_valid;
  wire        _slots_28_io_will_be_valid;
  wire        _slots_28_io_request;
  wire [6:0]  _slots_28_io_out_uop_uopc;
  wire [9:0]  _slots_28_io_out_uop_fu_code;
  wire [1:0]  _slots_28_io_out_uop_iw_state;
  wire [19:0] _slots_28_io_out_uop_br_mask;
  wire [19:0] _slots_28_io_out_uop_imm_packed;
  wire [6:0]  _slots_28_io_out_uop_rob_idx;
  wire [4:0]  _slots_28_io_out_uop_stq_idx;
  wire [6:0]  _slots_28_io_out_uop_pdst;
  wire [6:0]  _slots_28_io_out_uop_prs1;
  wire [6:0]  _slots_28_io_out_uop_prs2;
  wire [6:0]  _slots_28_io_out_uop_prs3;
  wire        _slots_28_io_out_uop_prs1_busy;
  wire        _slots_28_io_out_uop_prs2_busy;
  wire        _slots_28_io_out_uop_prs3_busy;
  wire        _slots_28_io_out_uop_ppred_busy;
  wire [4:0]  _slots_28_io_out_uop_mem_cmd;
  wire        _slots_28_io_out_uop_is_amo;
  wire        _slots_28_io_out_uop_uses_ldq;
  wire        _slots_28_io_out_uop_uses_stq;
  wire [1:0]  _slots_28_io_out_uop_dst_rtype;
  wire        _slots_28_io_out_uop_fp_val;
  wire [6:0]  _slots_28_io_uop_uopc;
  wire [9:0]  _slots_28_io_uop_fu_code;
  wire [19:0] _slots_28_io_uop_br_mask;
  wire [19:0] _slots_28_io_uop_imm_packed;
  wire [6:0]  _slots_28_io_uop_rob_idx;
  wire [4:0]  _slots_28_io_uop_stq_idx;
  wire [6:0]  _slots_28_io_uop_pdst;
  wire [6:0]  _slots_28_io_uop_prs1;
  wire [6:0]  _slots_28_io_uop_prs2;
  wire [6:0]  _slots_28_io_uop_prs3;
  wire [4:0]  _slots_28_io_uop_mem_cmd;
  wire        _slots_28_io_uop_is_amo;
  wire        _slots_28_io_uop_uses_ldq;
  wire        _slots_28_io_uop_uses_stq;
  wire [1:0]  _slots_28_io_uop_dst_rtype;
  wire        _slots_28_io_uop_fp_val;
  wire        _slots_27_io_valid;
  wire        _slots_27_io_will_be_valid;
  wire        _slots_27_io_request;
  wire [6:0]  _slots_27_io_out_uop_uopc;
  wire [9:0]  _slots_27_io_out_uop_fu_code;
  wire [1:0]  _slots_27_io_out_uop_iw_state;
  wire [19:0] _slots_27_io_out_uop_br_mask;
  wire [19:0] _slots_27_io_out_uop_imm_packed;
  wire [6:0]  _slots_27_io_out_uop_rob_idx;
  wire [4:0]  _slots_27_io_out_uop_stq_idx;
  wire [6:0]  _slots_27_io_out_uop_pdst;
  wire [6:0]  _slots_27_io_out_uop_prs1;
  wire [6:0]  _slots_27_io_out_uop_prs2;
  wire [6:0]  _slots_27_io_out_uop_prs3;
  wire        _slots_27_io_out_uop_prs1_busy;
  wire        _slots_27_io_out_uop_prs2_busy;
  wire        _slots_27_io_out_uop_prs3_busy;
  wire        _slots_27_io_out_uop_ppred_busy;
  wire [4:0]  _slots_27_io_out_uop_mem_cmd;
  wire        _slots_27_io_out_uop_is_amo;
  wire        _slots_27_io_out_uop_uses_ldq;
  wire        _slots_27_io_out_uop_uses_stq;
  wire [1:0]  _slots_27_io_out_uop_dst_rtype;
  wire        _slots_27_io_out_uop_fp_val;
  wire [6:0]  _slots_27_io_uop_uopc;
  wire [9:0]  _slots_27_io_uop_fu_code;
  wire [19:0] _slots_27_io_uop_br_mask;
  wire [19:0] _slots_27_io_uop_imm_packed;
  wire [6:0]  _slots_27_io_uop_rob_idx;
  wire [4:0]  _slots_27_io_uop_stq_idx;
  wire [6:0]  _slots_27_io_uop_pdst;
  wire [6:0]  _slots_27_io_uop_prs1;
  wire [6:0]  _slots_27_io_uop_prs2;
  wire [6:0]  _slots_27_io_uop_prs3;
  wire [4:0]  _slots_27_io_uop_mem_cmd;
  wire        _slots_27_io_uop_is_amo;
  wire        _slots_27_io_uop_uses_ldq;
  wire        _slots_27_io_uop_uses_stq;
  wire [1:0]  _slots_27_io_uop_dst_rtype;
  wire        _slots_27_io_uop_fp_val;
  wire        _slots_26_io_valid;
  wire        _slots_26_io_will_be_valid;
  wire        _slots_26_io_request;
  wire [6:0]  _slots_26_io_out_uop_uopc;
  wire [9:0]  _slots_26_io_out_uop_fu_code;
  wire [1:0]  _slots_26_io_out_uop_iw_state;
  wire [19:0] _slots_26_io_out_uop_br_mask;
  wire [19:0] _slots_26_io_out_uop_imm_packed;
  wire [6:0]  _slots_26_io_out_uop_rob_idx;
  wire [4:0]  _slots_26_io_out_uop_stq_idx;
  wire [6:0]  _slots_26_io_out_uop_pdst;
  wire [6:0]  _slots_26_io_out_uop_prs1;
  wire [6:0]  _slots_26_io_out_uop_prs2;
  wire [6:0]  _slots_26_io_out_uop_prs3;
  wire        _slots_26_io_out_uop_prs1_busy;
  wire        _slots_26_io_out_uop_prs2_busy;
  wire        _slots_26_io_out_uop_prs3_busy;
  wire        _slots_26_io_out_uop_ppred_busy;
  wire [4:0]  _slots_26_io_out_uop_mem_cmd;
  wire        _slots_26_io_out_uop_is_amo;
  wire        _slots_26_io_out_uop_uses_ldq;
  wire        _slots_26_io_out_uop_uses_stq;
  wire [1:0]  _slots_26_io_out_uop_dst_rtype;
  wire        _slots_26_io_out_uop_fp_val;
  wire [6:0]  _slots_26_io_uop_uopc;
  wire [9:0]  _slots_26_io_uop_fu_code;
  wire [19:0] _slots_26_io_uop_br_mask;
  wire [19:0] _slots_26_io_uop_imm_packed;
  wire [6:0]  _slots_26_io_uop_rob_idx;
  wire [4:0]  _slots_26_io_uop_stq_idx;
  wire [6:0]  _slots_26_io_uop_pdst;
  wire [6:0]  _slots_26_io_uop_prs1;
  wire [6:0]  _slots_26_io_uop_prs2;
  wire [6:0]  _slots_26_io_uop_prs3;
  wire [4:0]  _slots_26_io_uop_mem_cmd;
  wire        _slots_26_io_uop_is_amo;
  wire        _slots_26_io_uop_uses_ldq;
  wire        _slots_26_io_uop_uses_stq;
  wire [1:0]  _slots_26_io_uop_dst_rtype;
  wire        _slots_26_io_uop_fp_val;
  wire        _slots_25_io_valid;
  wire        _slots_25_io_will_be_valid;
  wire        _slots_25_io_request;
  wire [6:0]  _slots_25_io_out_uop_uopc;
  wire [9:0]  _slots_25_io_out_uop_fu_code;
  wire [1:0]  _slots_25_io_out_uop_iw_state;
  wire [19:0] _slots_25_io_out_uop_br_mask;
  wire [19:0] _slots_25_io_out_uop_imm_packed;
  wire [6:0]  _slots_25_io_out_uop_rob_idx;
  wire [4:0]  _slots_25_io_out_uop_stq_idx;
  wire [6:0]  _slots_25_io_out_uop_pdst;
  wire [6:0]  _slots_25_io_out_uop_prs1;
  wire [6:0]  _slots_25_io_out_uop_prs2;
  wire [6:0]  _slots_25_io_out_uop_prs3;
  wire        _slots_25_io_out_uop_prs1_busy;
  wire        _slots_25_io_out_uop_prs2_busy;
  wire        _slots_25_io_out_uop_prs3_busy;
  wire        _slots_25_io_out_uop_ppred_busy;
  wire [4:0]  _slots_25_io_out_uop_mem_cmd;
  wire        _slots_25_io_out_uop_is_amo;
  wire        _slots_25_io_out_uop_uses_ldq;
  wire        _slots_25_io_out_uop_uses_stq;
  wire [1:0]  _slots_25_io_out_uop_dst_rtype;
  wire        _slots_25_io_out_uop_fp_val;
  wire [6:0]  _slots_25_io_uop_uopc;
  wire [9:0]  _slots_25_io_uop_fu_code;
  wire [19:0] _slots_25_io_uop_br_mask;
  wire [19:0] _slots_25_io_uop_imm_packed;
  wire [6:0]  _slots_25_io_uop_rob_idx;
  wire [4:0]  _slots_25_io_uop_stq_idx;
  wire [6:0]  _slots_25_io_uop_pdst;
  wire [6:0]  _slots_25_io_uop_prs1;
  wire [6:0]  _slots_25_io_uop_prs2;
  wire [6:0]  _slots_25_io_uop_prs3;
  wire [4:0]  _slots_25_io_uop_mem_cmd;
  wire        _slots_25_io_uop_is_amo;
  wire        _slots_25_io_uop_uses_ldq;
  wire        _slots_25_io_uop_uses_stq;
  wire [1:0]  _slots_25_io_uop_dst_rtype;
  wire        _slots_25_io_uop_fp_val;
  wire        _slots_24_io_valid;
  wire        _slots_24_io_will_be_valid;
  wire        _slots_24_io_request;
  wire [6:0]  _slots_24_io_out_uop_uopc;
  wire [9:0]  _slots_24_io_out_uop_fu_code;
  wire [1:0]  _slots_24_io_out_uop_iw_state;
  wire [19:0] _slots_24_io_out_uop_br_mask;
  wire [19:0] _slots_24_io_out_uop_imm_packed;
  wire [6:0]  _slots_24_io_out_uop_rob_idx;
  wire [4:0]  _slots_24_io_out_uop_stq_idx;
  wire [6:0]  _slots_24_io_out_uop_pdst;
  wire [6:0]  _slots_24_io_out_uop_prs1;
  wire [6:0]  _slots_24_io_out_uop_prs2;
  wire [6:0]  _slots_24_io_out_uop_prs3;
  wire        _slots_24_io_out_uop_prs1_busy;
  wire        _slots_24_io_out_uop_prs2_busy;
  wire        _slots_24_io_out_uop_prs3_busy;
  wire        _slots_24_io_out_uop_ppred_busy;
  wire [4:0]  _slots_24_io_out_uop_mem_cmd;
  wire        _slots_24_io_out_uop_is_amo;
  wire        _slots_24_io_out_uop_uses_ldq;
  wire        _slots_24_io_out_uop_uses_stq;
  wire [1:0]  _slots_24_io_out_uop_dst_rtype;
  wire        _slots_24_io_out_uop_fp_val;
  wire [6:0]  _slots_24_io_uop_uopc;
  wire [9:0]  _slots_24_io_uop_fu_code;
  wire [19:0] _slots_24_io_uop_br_mask;
  wire [19:0] _slots_24_io_uop_imm_packed;
  wire [6:0]  _slots_24_io_uop_rob_idx;
  wire [4:0]  _slots_24_io_uop_stq_idx;
  wire [6:0]  _slots_24_io_uop_pdst;
  wire [6:0]  _slots_24_io_uop_prs1;
  wire [6:0]  _slots_24_io_uop_prs2;
  wire [6:0]  _slots_24_io_uop_prs3;
  wire [4:0]  _slots_24_io_uop_mem_cmd;
  wire        _slots_24_io_uop_is_amo;
  wire        _slots_24_io_uop_uses_ldq;
  wire        _slots_24_io_uop_uses_stq;
  wire [1:0]  _slots_24_io_uop_dst_rtype;
  wire        _slots_24_io_uop_fp_val;
  wire        _slots_23_io_valid;
  wire        _slots_23_io_will_be_valid;
  wire        _slots_23_io_request;
  wire [6:0]  _slots_23_io_out_uop_uopc;
  wire [9:0]  _slots_23_io_out_uop_fu_code;
  wire [1:0]  _slots_23_io_out_uop_iw_state;
  wire [19:0] _slots_23_io_out_uop_br_mask;
  wire [19:0] _slots_23_io_out_uop_imm_packed;
  wire [6:0]  _slots_23_io_out_uop_rob_idx;
  wire [4:0]  _slots_23_io_out_uop_stq_idx;
  wire [6:0]  _slots_23_io_out_uop_pdst;
  wire [6:0]  _slots_23_io_out_uop_prs1;
  wire [6:0]  _slots_23_io_out_uop_prs2;
  wire [6:0]  _slots_23_io_out_uop_prs3;
  wire        _slots_23_io_out_uop_prs1_busy;
  wire        _slots_23_io_out_uop_prs2_busy;
  wire        _slots_23_io_out_uop_prs3_busy;
  wire        _slots_23_io_out_uop_ppred_busy;
  wire [4:0]  _slots_23_io_out_uop_mem_cmd;
  wire        _slots_23_io_out_uop_is_amo;
  wire        _slots_23_io_out_uop_uses_ldq;
  wire        _slots_23_io_out_uop_uses_stq;
  wire [1:0]  _slots_23_io_out_uop_dst_rtype;
  wire        _slots_23_io_out_uop_fp_val;
  wire [6:0]  _slots_23_io_uop_uopc;
  wire [9:0]  _slots_23_io_uop_fu_code;
  wire [19:0] _slots_23_io_uop_br_mask;
  wire [19:0] _slots_23_io_uop_imm_packed;
  wire [6:0]  _slots_23_io_uop_rob_idx;
  wire [4:0]  _slots_23_io_uop_stq_idx;
  wire [6:0]  _slots_23_io_uop_pdst;
  wire [6:0]  _slots_23_io_uop_prs1;
  wire [6:0]  _slots_23_io_uop_prs2;
  wire [6:0]  _slots_23_io_uop_prs3;
  wire [4:0]  _slots_23_io_uop_mem_cmd;
  wire        _slots_23_io_uop_is_amo;
  wire        _slots_23_io_uop_uses_ldq;
  wire        _slots_23_io_uop_uses_stq;
  wire [1:0]  _slots_23_io_uop_dst_rtype;
  wire        _slots_23_io_uop_fp_val;
  wire        _slots_22_io_valid;
  wire        _slots_22_io_will_be_valid;
  wire        _slots_22_io_request;
  wire [6:0]  _slots_22_io_out_uop_uopc;
  wire [9:0]  _slots_22_io_out_uop_fu_code;
  wire [1:0]  _slots_22_io_out_uop_iw_state;
  wire [19:0] _slots_22_io_out_uop_br_mask;
  wire [19:0] _slots_22_io_out_uop_imm_packed;
  wire [6:0]  _slots_22_io_out_uop_rob_idx;
  wire [4:0]  _slots_22_io_out_uop_stq_idx;
  wire [6:0]  _slots_22_io_out_uop_pdst;
  wire [6:0]  _slots_22_io_out_uop_prs1;
  wire [6:0]  _slots_22_io_out_uop_prs2;
  wire [6:0]  _slots_22_io_out_uop_prs3;
  wire        _slots_22_io_out_uop_prs1_busy;
  wire        _slots_22_io_out_uop_prs2_busy;
  wire        _slots_22_io_out_uop_prs3_busy;
  wire        _slots_22_io_out_uop_ppred_busy;
  wire [4:0]  _slots_22_io_out_uop_mem_cmd;
  wire        _slots_22_io_out_uop_is_amo;
  wire        _slots_22_io_out_uop_uses_ldq;
  wire        _slots_22_io_out_uop_uses_stq;
  wire [1:0]  _slots_22_io_out_uop_dst_rtype;
  wire        _slots_22_io_out_uop_fp_val;
  wire [6:0]  _slots_22_io_uop_uopc;
  wire [9:0]  _slots_22_io_uop_fu_code;
  wire [19:0] _slots_22_io_uop_br_mask;
  wire [19:0] _slots_22_io_uop_imm_packed;
  wire [6:0]  _slots_22_io_uop_rob_idx;
  wire [4:0]  _slots_22_io_uop_stq_idx;
  wire [6:0]  _slots_22_io_uop_pdst;
  wire [6:0]  _slots_22_io_uop_prs1;
  wire [6:0]  _slots_22_io_uop_prs2;
  wire [6:0]  _slots_22_io_uop_prs3;
  wire [4:0]  _slots_22_io_uop_mem_cmd;
  wire        _slots_22_io_uop_is_amo;
  wire        _slots_22_io_uop_uses_ldq;
  wire        _slots_22_io_uop_uses_stq;
  wire [1:0]  _slots_22_io_uop_dst_rtype;
  wire        _slots_22_io_uop_fp_val;
  wire        _slots_21_io_valid;
  wire        _slots_21_io_will_be_valid;
  wire        _slots_21_io_request;
  wire [6:0]  _slots_21_io_out_uop_uopc;
  wire [9:0]  _slots_21_io_out_uop_fu_code;
  wire [1:0]  _slots_21_io_out_uop_iw_state;
  wire [19:0] _slots_21_io_out_uop_br_mask;
  wire [19:0] _slots_21_io_out_uop_imm_packed;
  wire [6:0]  _slots_21_io_out_uop_rob_idx;
  wire [4:0]  _slots_21_io_out_uop_stq_idx;
  wire [6:0]  _slots_21_io_out_uop_pdst;
  wire [6:0]  _slots_21_io_out_uop_prs1;
  wire [6:0]  _slots_21_io_out_uop_prs2;
  wire [6:0]  _slots_21_io_out_uop_prs3;
  wire        _slots_21_io_out_uop_prs1_busy;
  wire        _slots_21_io_out_uop_prs2_busy;
  wire        _slots_21_io_out_uop_prs3_busy;
  wire        _slots_21_io_out_uop_ppred_busy;
  wire [4:0]  _slots_21_io_out_uop_mem_cmd;
  wire        _slots_21_io_out_uop_is_amo;
  wire        _slots_21_io_out_uop_uses_ldq;
  wire        _slots_21_io_out_uop_uses_stq;
  wire [1:0]  _slots_21_io_out_uop_dst_rtype;
  wire        _slots_21_io_out_uop_fp_val;
  wire [6:0]  _slots_21_io_uop_uopc;
  wire [9:0]  _slots_21_io_uop_fu_code;
  wire [19:0] _slots_21_io_uop_br_mask;
  wire [19:0] _slots_21_io_uop_imm_packed;
  wire [6:0]  _slots_21_io_uop_rob_idx;
  wire [4:0]  _slots_21_io_uop_stq_idx;
  wire [6:0]  _slots_21_io_uop_pdst;
  wire [6:0]  _slots_21_io_uop_prs1;
  wire [6:0]  _slots_21_io_uop_prs2;
  wire [6:0]  _slots_21_io_uop_prs3;
  wire [4:0]  _slots_21_io_uop_mem_cmd;
  wire        _slots_21_io_uop_is_amo;
  wire        _slots_21_io_uop_uses_ldq;
  wire        _slots_21_io_uop_uses_stq;
  wire [1:0]  _slots_21_io_uop_dst_rtype;
  wire        _slots_21_io_uop_fp_val;
  wire        _slots_20_io_valid;
  wire        _slots_20_io_will_be_valid;
  wire        _slots_20_io_request;
  wire [6:0]  _slots_20_io_out_uop_uopc;
  wire [9:0]  _slots_20_io_out_uop_fu_code;
  wire [1:0]  _slots_20_io_out_uop_iw_state;
  wire [19:0] _slots_20_io_out_uop_br_mask;
  wire [19:0] _slots_20_io_out_uop_imm_packed;
  wire [6:0]  _slots_20_io_out_uop_rob_idx;
  wire [4:0]  _slots_20_io_out_uop_stq_idx;
  wire [6:0]  _slots_20_io_out_uop_pdst;
  wire [6:0]  _slots_20_io_out_uop_prs1;
  wire [6:0]  _slots_20_io_out_uop_prs2;
  wire [6:0]  _slots_20_io_out_uop_prs3;
  wire        _slots_20_io_out_uop_prs1_busy;
  wire        _slots_20_io_out_uop_prs2_busy;
  wire        _slots_20_io_out_uop_prs3_busy;
  wire        _slots_20_io_out_uop_ppred_busy;
  wire [4:0]  _slots_20_io_out_uop_mem_cmd;
  wire        _slots_20_io_out_uop_is_amo;
  wire        _slots_20_io_out_uop_uses_ldq;
  wire        _slots_20_io_out_uop_uses_stq;
  wire [1:0]  _slots_20_io_out_uop_dst_rtype;
  wire        _slots_20_io_out_uop_fp_val;
  wire [6:0]  _slots_20_io_uop_uopc;
  wire [9:0]  _slots_20_io_uop_fu_code;
  wire [19:0] _slots_20_io_uop_br_mask;
  wire [19:0] _slots_20_io_uop_imm_packed;
  wire [6:0]  _slots_20_io_uop_rob_idx;
  wire [4:0]  _slots_20_io_uop_stq_idx;
  wire [6:0]  _slots_20_io_uop_pdst;
  wire [6:0]  _slots_20_io_uop_prs1;
  wire [6:0]  _slots_20_io_uop_prs2;
  wire [6:0]  _slots_20_io_uop_prs3;
  wire [4:0]  _slots_20_io_uop_mem_cmd;
  wire        _slots_20_io_uop_is_amo;
  wire        _slots_20_io_uop_uses_ldq;
  wire        _slots_20_io_uop_uses_stq;
  wire [1:0]  _slots_20_io_uop_dst_rtype;
  wire        _slots_20_io_uop_fp_val;
  wire        _slots_19_io_valid;
  wire        _slots_19_io_will_be_valid;
  wire        _slots_19_io_request;
  wire [6:0]  _slots_19_io_out_uop_uopc;
  wire [9:0]  _slots_19_io_out_uop_fu_code;
  wire [1:0]  _slots_19_io_out_uop_iw_state;
  wire [19:0] _slots_19_io_out_uop_br_mask;
  wire [19:0] _slots_19_io_out_uop_imm_packed;
  wire [6:0]  _slots_19_io_out_uop_rob_idx;
  wire [4:0]  _slots_19_io_out_uop_stq_idx;
  wire [6:0]  _slots_19_io_out_uop_pdst;
  wire [6:0]  _slots_19_io_out_uop_prs1;
  wire [6:0]  _slots_19_io_out_uop_prs2;
  wire [6:0]  _slots_19_io_out_uop_prs3;
  wire        _slots_19_io_out_uop_prs1_busy;
  wire        _slots_19_io_out_uop_prs2_busy;
  wire        _slots_19_io_out_uop_prs3_busy;
  wire        _slots_19_io_out_uop_ppred_busy;
  wire [4:0]  _slots_19_io_out_uop_mem_cmd;
  wire        _slots_19_io_out_uop_is_amo;
  wire        _slots_19_io_out_uop_uses_ldq;
  wire        _slots_19_io_out_uop_uses_stq;
  wire [1:0]  _slots_19_io_out_uop_dst_rtype;
  wire        _slots_19_io_out_uop_fp_val;
  wire [6:0]  _slots_19_io_uop_uopc;
  wire [9:0]  _slots_19_io_uop_fu_code;
  wire [19:0] _slots_19_io_uop_br_mask;
  wire [19:0] _slots_19_io_uop_imm_packed;
  wire [6:0]  _slots_19_io_uop_rob_idx;
  wire [4:0]  _slots_19_io_uop_stq_idx;
  wire [6:0]  _slots_19_io_uop_pdst;
  wire [6:0]  _slots_19_io_uop_prs1;
  wire [6:0]  _slots_19_io_uop_prs2;
  wire [6:0]  _slots_19_io_uop_prs3;
  wire [4:0]  _slots_19_io_uop_mem_cmd;
  wire        _slots_19_io_uop_is_amo;
  wire        _slots_19_io_uop_uses_ldq;
  wire        _slots_19_io_uop_uses_stq;
  wire [1:0]  _slots_19_io_uop_dst_rtype;
  wire        _slots_19_io_uop_fp_val;
  wire        _slots_18_io_valid;
  wire        _slots_18_io_will_be_valid;
  wire        _slots_18_io_request;
  wire [6:0]  _slots_18_io_out_uop_uopc;
  wire [9:0]  _slots_18_io_out_uop_fu_code;
  wire [1:0]  _slots_18_io_out_uop_iw_state;
  wire [19:0] _slots_18_io_out_uop_br_mask;
  wire [19:0] _slots_18_io_out_uop_imm_packed;
  wire [6:0]  _slots_18_io_out_uop_rob_idx;
  wire [4:0]  _slots_18_io_out_uop_stq_idx;
  wire [6:0]  _slots_18_io_out_uop_pdst;
  wire [6:0]  _slots_18_io_out_uop_prs1;
  wire [6:0]  _slots_18_io_out_uop_prs2;
  wire [6:0]  _slots_18_io_out_uop_prs3;
  wire        _slots_18_io_out_uop_prs1_busy;
  wire        _slots_18_io_out_uop_prs2_busy;
  wire        _slots_18_io_out_uop_prs3_busy;
  wire        _slots_18_io_out_uop_ppred_busy;
  wire [4:0]  _slots_18_io_out_uop_mem_cmd;
  wire        _slots_18_io_out_uop_is_amo;
  wire        _slots_18_io_out_uop_uses_ldq;
  wire        _slots_18_io_out_uop_uses_stq;
  wire [1:0]  _slots_18_io_out_uop_dst_rtype;
  wire        _slots_18_io_out_uop_fp_val;
  wire [6:0]  _slots_18_io_uop_uopc;
  wire [9:0]  _slots_18_io_uop_fu_code;
  wire [19:0] _slots_18_io_uop_br_mask;
  wire [19:0] _slots_18_io_uop_imm_packed;
  wire [6:0]  _slots_18_io_uop_rob_idx;
  wire [4:0]  _slots_18_io_uop_stq_idx;
  wire [6:0]  _slots_18_io_uop_pdst;
  wire [6:0]  _slots_18_io_uop_prs1;
  wire [6:0]  _slots_18_io_uop_prs2;
  wire [6:0]  _slots_18_io_uop_prs3;
  wire [4:0]  _slots_18_io_uop_mem_cmd;
  wire        _slots_18_io_uop_is_amo;
  wire        _slots_18_io_uop_uses_ldq;
  wire        _slots_18_io_uop_uses_stq;
  wire [1:0]  _slots_18_io_uop_dst_rtype;
  wire        _slots_18_io_uop_fp_val;
  wire        _slots_17_io_valid;
  wire        _slots_17_io_will_be_valid;
  wire        _slots_17_io_request;
  wire [6:0]  _slots_17_io_out_uop_uopc;
  wire [9:0]  _slots_17_io_out_uop_fu_code;
  wire [1:0]  _slots_17_io_out_uop_iw_state;
  wire [19:0] _slots_17_io_out_uop_br_mask;
  wire [19:0] _slots_17_io_out_uop_imm_packed;
  wire [6:0]  _slots_17_io_out_uop_rob_idx;
  wire [4:0]  _slots_17_io_out_uop_stq_idx;
  wire [6:0]  _slots_17_io_out_uop_pdst;
  wire [6:0]  _slots_17_io_out_uop_prs1;
  wire [6:0]  _slots_17_io_out_uop_prs2;
  wire [6:0]  _slots_17_io_out_uop_prs3;
  wire        _slots_17_io_out_uop_prs1_busy;
  wire        _slots_17_io_out_uop_prs2_busy;
  wire        _slots_17_io_out_uop_prs3_busy;
  wire        _slots_17_io_out_uop_ppred_busy;
  wire [4:0]  _slots_17_io_out_uop_mem_cmd;
  wire        _slots_17_io_out_uop_is_amo;
  wire        _slots_17_io_out_uop_uses_ldq;
  wire        _slots_17_io_out_uop_uses_stq;
  wire [1:0]  _slots_17_io_out_uop_dst_rtype;
  wire        _slots_17_io_out_uop_fp_val;
  wire [6:0]  _slots_17_io_uop_uopc;
  wire [9:0]  _slots_17_io_uop_fu_code;
  wire [19:0] _slots_17_io_uop_br_mask;
  wire [19:0] _slots_17_io_uop_imm_packed;
  wire [6:0]  _slots_17_io_uop_rob_idx;
  wire [4:0]  _slots_17_io_uop_stq_idx;
  wire [6:0]  _slots_17_io_uop_pdst;
  wire [6:0]  _slots_17_io_uop_prs1;
  wire [6:0]  _slots_17_io_uop_prs2;
  wire [6:0]  _slots_17_io_uop_prs3;
  wire [4:0]  _slots_17_io_uop_mem_cmd;
  wire        _slots_17_io_uop_is_amo;
  wire        _slots_17_io_uop_uses_ldq;
  wire        _slots_17_io_uop_uses_stq;
  wire [1:0]  _slots_17_io_uop_dst_rtype;
  wire        _slots_17_io_uop_fp_val;
  wire        _slots_16_io_valid;
  wire        _slots_16_io_will_be_valid;
  wire        _slots_16_io_request;
  wire [6:0]  _slots_16_io_out_uop_uopc;
  wire [9:0]  _slots_16_io_out_uop_fu_code;
  wire [1:0]  _slots_16_io_out_uop_iw_state;
  wire [19:0] _slots_16_io_out_uop_br_mask;
  wire [19:0] _slots_16_io_out_uop_imm_packed;
  wire [6:0]  _slots_16_io_out_uop_rob_idx;
  wire [4:0]  _slots_16_io_out_uop_stq_idx;
  wire [6:0]  _slots_16_io_out_uop_pdst;
  wire [6:0]  _slots_16_io_out_uop_prs1;
  wire [6:0]  _slots_16_io_out_uop_prs2;
  wire [6:0]  _slots_16_io_out_uop_prs3;
  wire        _slots_16_io_out_uop_prs1_busy;
  wire        _slots_16_io_out_uop_prs2_busy;
  wire        _slots_16_io_out_uop_prs3_busy;
  wire        _slots_16_io_out_uop_ppred_busy;
  wire [4:0]  _slots_16_io_out_uop_mem_cmd;
  wire        _slots_16_io_out_uop_is_amo;
  wire        _slots_16_io_out_uop_uses_ldq;
  wire        _slots_16_io_out_uop_uses_stq;
  wire [1:0]  _slots_16_io_out_uop_dst_rtype;
  wire        _slots_16_io_out_uop_fp_val;
  wire [6:0]  _slots_16_io_uop_uopc;
  wire [9:0]  _slots_16_io_uop_fu_code;
  wire [19:0] _slots_16_io_uop_br_mask;
  wire [19:0] _slots_16_io_uop_imm_packed;
  wire [6:0]  _slots_16_io_uop_rob_idx;
  wire [4:0]  _slots_16_io_uop_stq_idx;
  wire [6:0]  _slots_16_io_uop_pdst;
  wire [6:0]  _slots_16_io_uop_prs1;
  wire [6:0]  _slots_16_io_uop_prs2;
  wire [6:0]  _slots_16_io_uop_prs3;
  wire [4:0]  _slots_16_io_uop_mem_cmd;
  wire        _slots_16_io_uop_is_amo;
  wire        _slots_16_io_uop_uses_ldq;
  wire        _slots_16_io_uop_uses_stq;
  wire [1:0]  _slots_16_io_uop_dst_rtype;
  wire        _slots_16_io_uop_fp_val;
  wire        _slots_15_io_valid;
  wire        _slots_15_io_will_be_valid;
  wire        _slots_15_io_request;
  wire [6:0]  _slots_15_io_out_uop_uopc;
  wire [9:0]  _slots_15_io_out_uop_fu_code;
  wire [1:0]  _slots_15_io_out_uop_iw_state;
  wire [19:0] _slots_15_io_out_uop_br_mask;
  wire [19:0] _slots_15_io_out_uop_imm_packed;
  wire [6:0]  _slots_15_io_out_uop_rob_idx;
  wire [4:0]  _slots_15_io_out_uop_stq_idx;
  wire [6:0]  _slots_15_io_out_uop_pdst;
  wire [6:0]  _slots_15_io_out_uop_prs1;
  wire [6:0]  _slots_15_io_out_uop_prs2;
  wire [6:0]  _slots_15_io_out_uop_prs3;
  wire        _slots_15_io_out_uop_prs1_busy;
  wire        _slots_15_io_out_uop_prs2_busy;
  wire        _slots_15_io_out_uop_prs3_busy;
  wire        _slots_15_io_out_uop_ppred_busy;
  wire [4:0]  _slots_15_io_out_uop_mem_cmd;
  wire        _slots_15_io_out_uop_is_amo;
  wire        _slots_15_io_out_uop_uses_ldq;
  wire        _slots_15_io_out_uop_uses_stq;
  wire [1:0]  _slots_15_io_out_uop_dst_rtype;
  wire        _slots_15_io_out_uop_fp_val;
  wire [6:0]  _slots_15_io_uop_uopc;
  wire [9:0]  _slots_15_io_uop_fu_code;
  wire [19:0] _slots_15_io_uop_br_mask;
  wire [19:0] _slots_15_io_uop_imm_packed;
  wire [6:0]  _slots_15_io_uop_rob_idx;
  wire [4:0]  _slots_15_io_uop_stq_idx;
  wire [6:0]  _slots_15_io_uop_pdst;
  wire [6:0]  _slots_15_io_uop_prs1;
  wire [6:0]  _slots_15_io_uop_prs2;
  wire [6:0]  _slots_15_io_uop_prs3;
  wire [4:0]  _slots_15_io_uop_mem_cmd;
  wire        _slots_15_io_uop_is_amo;
  wire        _slots_15_io_uop_uses_ldq;
  wire        _slots_15_io_uop_uses_stq;
  wire [1:0]  _slots_15_io_uop_dst_rtype;
  wire        _slots_15_io_uop_fp_val;
  wire        _slots_14_io_valid;
  wire        _slots_14_io_will_be_valid;
  wire        _slots_14_io_request;
  wire [6:0]  _slots_14_io_out_uop_uopc;
  wire [9:0]  _slots_14_io_out_uop_fu_code;
  wire [1:0]  _slots_14_io_out_uop_iw_state;
  wire [19:0] _slots_14_io_out_uop_br_mask;
  wire [19:0] _slots_14_io_out_uop_imm_packed;
  wire [6:0]  _slots_14_io_out_uop_rob_idx;
  wire [4:0]  _slots_14_io_out_uop_stq_idx;
  wire [6:0]  _slots_14_io_out_uop_pdst;
  wire [6:0]  _slots_14_io_out_uop_prs1;
  wire [6:0]  _slots_14_io_out_uop_prs2;
  wire [6:0]  _slots_14_io_out_uop_prs3;
  wire        _slots_14_io_out_uop_prs1_busy;
  wire        _slots_14_io_out_uop_prs2_busy;
  wire        _slots_14_io_out_uop_prs3_busy;
  wire        _slots_14_io_out_uop_ppred_busy;
  wire [4:0]  _slots_14_io_out_uop_mem_cmd;
  wire        _slots_14_io_out_uop_is_amo;
  wire        _slots_14_io_out_uop_uses_ldq;
  wire        _slots_14_io_out_uop_uses_stq;
  wire [1:0]  _slots_14_io_out_uop_dst_rtype;
  wire        _slots_14_io_out_uop_fp_val;
  wire [6:0]  _slots_14_io_uop_uopc;
  wire [9:0]  _slots_14_io_uop_fu_code;
  wire [19:0] _slots_14_io_uop_br_mask;
  wire [19:0] _slots_14_io_uop_imm_packed;
  wire [6:0]  _slots_14_io_uop_rob_idx;
  wire [4:0]  _slots_14_io_uop_stq_idx;
  wire [6:0]  _slots_14_io_uop_pdst;
  wire [6:0]  _slots_14_io_uop_prs1;
  wire [6:0]  _slots_14_io_uop_prs2;
  wire [6:0]  _slots_14_io_uop_prs3;
  wire [4:0]  _slots_14_io_uop_mem_cmd;
  wire        _slots_14_io_uop_is_amo;
  wire        _slots_14_io_uop_uses_ldq;
  wire        _slots_14_io_uop_uses_stq;
  wire [1:0]  _slots_14_io_uop_dst_rtype;
  wire        _slots_14_io_uop_fp_val;
  wire        _slots_13_io_valid;
  wire        _slots_13_io_will_be_valid;
  wire        _slots_13_io_request;
  wire [6:0]  _slots_13_io_out_uop_uopc;
  wire [9:0]  _slots_13_io_out_uop_fu_code;
  wire [1:0]  _slots_13_io_out_uop_iw_state;
  wire [19:0] _slots_13_io_out_uop_br_mask;
  wire [19:0] _slots_13_io_out_uop_imm_packed;
  wire [6:0]  _slots_13_io_out_uop_rob_idx;
  wire [4:0]  _slots_13_io_out_uop_stq_idx;
  wire [6:0]  _slots_13_io_out_uop_pdst;
  wire [6:0]  _slots_13_io_out_uop_prs1;
  wire [6:0]  _slots_13_io_out_uop_prs2;
  wire [6:0]  _slots_13_io_out_uop_prs3;
  wire        _slots_13_io_out_uop_prs1_busy;
  wire        _slots_13_io_out_uop_prs2_busy;
  wire        _slots_13_io_out_uop_prs3_busy;
  wire        _slots_13_io_out_uop_ppred_busy;
  wire [4:0]  _slots_13_io_out_uop_mem_cmd;
  wire        _slots_13_io_out_uop_is_amo;
  wire        _slots_13_io_out_uop_uses_ldq;
  wire        _slots_13_io_out_uop_uses_stq;
  wire [1:0]  _slots_13_io_out_uop_dst_rtype;
  wire        _slots_13_io_out_uop_fp_val;
  wire [6:0]  _slots_13_io_uop_uopc;
  wire [9:0]  _slots_13_io_uop_fu_code;
  wire [19:0] _slots_13_io_uop_br_mask;
  wire [19:0] _slots_13_io_uop_imm_packed;
  wire [6:0]  _slots_13_io_uop_rob_idx;
  wire [4:0]  _slots_13_io_uop_stq_idx;
  wire [6:0]  _slots_13_io_uop_pdst;
  wire [6:0]  _slots_13_io_uop_prs1;
  wire [6:0]  _slots_13_io_uop_prs2;
  wire [6:0]  _slots_13_io_uop_prs3;
  wire [4:0]  _slots_13_io_uop_mem_cmd;
  wire        _slots_13_io_uop_is_amo;
  wire        _slots_13_io_uop_uses_ldq;
  wire        _slots_13_io_uop_uses_stq;
  wire [1:0]  _slots_13_io_uop_dst_rtype;
  wire        _slots_13_io_uop_fp_val;
  wire        _slots_12_io_valid;
  wire        _slots_12_io_will_be_valid;
  wire        _slots_12_io_request;
  wire [6:0]  _slots_12_io_out_uop_uopc;
  wire [9:0]  _slots_12_io_out_uop_fu_code;
  wire [1:0]  _slots_12_io_out_uop_iw_state;
  wire [19:0] _slots_12_io_out_uop_br_mask;
  wire [19:0] _slots_12_io_out_uop_imm_packed;
  wire [6:0]  _slots_12_io_out_uop_rob_idx;
  wire [4:0]  _slots_12_io_out_uop_stq_idx;
  wire [6:0]  _slots_12_io_out_uop_pdst;
  wire [6:0]  _slots_12_io_out_uop_prs1;
  wire [6:0]  _slots_12_io_out_uop_prs2;
  wire [6:0]  _slots_12_io_out_uop_prs3;
  wire        _slots_12_io_out_uop_prs1_busy;
  wire        _slots_12_io_out_uop_prs2_busy;
  wire        _slots_12_io_out_uop_prs3_busy;
  wire        _slots_12_io_out_uop_ppred_busy;
  wire [4:0]  _slots_12_io_out_uop_mem_cmd;
  wire        _slots_12_io_out_uop_is_amo;
  wire        _slots_12_io_out_uop_uses_ldq;
  wire        _slots_12_io_out_uop_uses_stq;
  wire [1:0]  _slots_12_io_out_uop_dst_rtype;
  wire        _slots_12_io_out_uop_fp_val;
  wire [6:0]  _slots_12_io_uop_uopc;
  wire [9:0]  _slots_12_io_uop_fu_code;
  wire [19:0] _slots_12_io_uop_br_mask;
  wire [19:0] _slots_12_io_uop_imm_packed;
  wire [6:0]  _slots_12_io_uop_rob_idx;
  wire [4:0]  _slots_12_io_uop_stq_idx;
  wire [6:0]  _slots_12_io_uop_pdst;
  wire [6:0]  _slots_12_io_uop_prs1;
  wire [6:0]  _slots_12_io_uop_prs2;
  wire [6:0]  _slots_12_io_uop_prs3;
  wire [4:0]  _slots_12_io_uop_mem_cmd;
  wire        _slots_12_io_uop_is_amo;
  wire        _slots_12_io_uop_uses_ldq;
  wire        _slots_12_io_uop_uses_stq;
  wire [1:0]  _slots_12_io_uop_dst_rtype;
  wire        _slots_12_io_uop_fp_val;
  wire        _slots_11_io_valid;
  wire        _slots_11_io_will_be_valid;
  wire        _slots_11_io_request;
  wire [6:0]  _slots_11_io_out_uop_uopc;
  wire [9:0]  _slots_11_io_out_uop_fu_code;
  wire [1:0]  _slots_11_io_out_uop_iw_state;
  wire [19:0] _slots_11_io_out_uop_br_mask;
  wire [19:0] _slots_11_io_out_uop_imm_packed;
  wire [6:0]  _slots_11_io_out_uop_rob_idx;
  wire [4:0]  _slots_11_io_out_uop_stq_idx;
  wire [6:0]  _slots_11_io_out_uop_pdst;
  wire [6:0]  _slots_11_io_out_uop_prs1;
  wire [6:0]  _slots_11_io_out_uop_prs2;
  wire [6:0]  _slots_11_io_out_uop_prs3;
  wire        _slots_11_io_out_uop_prs1_busy;
  wire        _slots_11_io_out_uop_prs2_busy;
  wire        _slots_11_io_out_uop_prs3_busy;
  wire        _slots_11_io_out_uop_ppred_busy;
  wire [4:0]  _slots_11_io_out_uop_mem_cmd;
  wire        _slots_11_io_out_uop_is_amo;
  wire        _slots_11_io_out_uop_uses_ldq;
  wire        _slots_11_io_out_uop_uses_stq;
  wire [1:0]  _slots_11_io_out_uop_dst_rtype;
  wire        _slots_11_io_out_uop_fp_val;
  wire [6:0]  _slots_11_io_uop_uopc;
  wire [9:0]  _slots_11_io_uop_fu_code;
  wire [19:0] _slots_11_io_uop_br_mask;
  wire [19:0] _slots_11_io_uop_imm_packed;
  wire [6:0]  _slots_11_io_uop_rob_idx;
  wire [4:0]  _slots_11_io_uop_stq_idx;
  wire [6:0]  _slots_11_io_uop_pdst;
  wire [6:0]  _slots_11_io_uop_prs1;
  wire [6:0]  _slots_11_io_uop_prs2;
  wire [6:0]  _slots_11_io_uop_prs3;
  wire [4:0]  _slots_11_io_uop_mem_cmd;
  wire        _slots_11_io_uop_is_amo;
  wire        _slots_11_io_uop_uses_ldq;
  wire        _slots_11_io_uop_uses_stq;
  wire [1:0]  _slots_11_io_uop_dst_rtype;
  wire        _slots_11_io_uop_fp_val;
  wire        _slots_10_io_valid;
  wire        _slots_10_io_will_be_valid;
  wire        _slots_10_io_request;
  wire [6:0]  _slots_10_io_out_uop_uopc;
  wire [9:0]  _slots_10_io_out_uop_fu_code;
  wire [1:0]  _slots_10_io_out_uop_iw_state;
  wire [19:0] _slots_10_io_out_uop_br_mask;
  wire [19:0] _slots_10_io_out_uop_imm_packed;
  wire [6:0]  _slots_10_io_out_uop_rob_idx;
  wire [4:0]  _slots_10_io_out_uop_stq_idx;
  wire [6:0]  _slots_10_io_out_uop_pdst;
  wire [6:0]  _slots_10_io_out_uop_prs1;
  wire [6:0]  _slots_10_io_out_uop_prs2;
  wire [6:0]  _slots_10_io_out_uop_prs3;
  wire        _slots_10_io_out_uop_prs1_busy;
  wire        _slots_10_io_out_uop_prs2_busy;
  wire        _slots_10_io_out_uop_prs3_busy;
  wire        _slots_10_io_out_uop_ppred_busy;
  wire [4:0]  _slots_10_io_out_uop_mem_cmd;
  wire        _slots_10_io_out_uop_is_amo;
  wire        _slots_10_io_out_uop_uses_ldq;
  wire        _slots_10_io_out_uop_uses_stq;
  wire [1:0]  _slots_10_io_out_uop_dst_rtype;
  wire        _slots_10_io_out_uop_fp_val;
  wire [6:0]  _slots_10_io_uop_uopc;
  wire [9:0]  _slots_10_io_uop_fu_code;
  wire [19:0] _slots_10_io_uop_br_mask;
  wire [19:0] _slots_10_io_uop_imm_packed;
  wire [6:0]  _slots_10_io_uop_rob_idx;
  wire [4:0]  _slots_10_io_uop_stq_idx;
  wire [6:0]  _slots_10_io_uop_pdst;
  wire [6:0]  _slots_10_io_uop_prs1;
  wire [6:0]  _slots_10_io_uop_prs2;
  wire [6:0]  _slots_10_io_uop_prs3;
  wire [4:0]  _slots_10_io_uop_mem_cmd;
  wire        _slots_10_io_uop_is_amo;
  wire        _slots_10_io_uop_uses_ldq;
  wire        _slots_10_io_uop_uses_stq;
  wire [1:0]  _slots_10_io_uop_dst_rtype;
  wire        _slots_10_io_uop_fp_val;
  wire        _slots_9_io_valid;
  wire        _slots_9_io_will_be_valid;
  wire        _slots_9_io_request;
  wire [6:0]  _slots_9_io_out_uop_uopc;
  wire [9:0]  _slots_9_io_out_uop_fu_code;
  wire [1:0]  _slots_9_io_out_uop_iw_state;
  wire [19:0] _slots_9_io_out_uop_br_mask;
  wire [19:0] _slots_9_io_out_uop_imm_packed;
  wire [6:0]  _slots_9_io_out_uop_rob_idx;
  wire [4:0]  _slots_9_io_out_uop_stq_idx;
  wire [6:0]  _slots_9_io_out_uop_pdst;
  wire [6:0]  _slots_9_io_out_uop_prs1;
  wire [6:0]  _slots_9_io_out_uop_prs2;
  wire [6:0]  _slots_9_io_out_uop_prs3;
  wire        _slots_9_io_out_uop_prs1_busy;
  wire        _slots_9_io_out_uop_prs2_busy;
  wire        _slots_9_io_out_uop_prs3_busy;
  wire        _slots_9_io_out_uop_ppred_busy;
  wire [4:0]  _slots_9_io_out_uop_mem_cmd;
  wire        _slots_9_io_out_uop_is_amo;
  wire        _slots_9_io_out_uop_uses_ldq;
  wire        _slots_9_io_out_uop_uses_stq;
  wire [1:0]  _slots_9_io_out_uop_dst_rtype;
  wire        _slots_9_io_out_uop_fp_val;
  wire [6:0]  _slots_9_io_uop_uopc;
  wire [9:0]  _slots_9_io_uop_fu_code;
  wire [19:0] _slots_9_io_uop_br_mask;
  wire [19:0] _slots_9_io_uop_imm_packed;
  wire [6:0]  _slots_9_io_uop_rob_idx;
  wire [4:0]  _slots_9_io_uop_stq_idx;
  wire [6:0]  _slots_9_io_uop_pdst;
  wire [6:0]  _slots_9_io_uop_prs1;
  wire [6:0]  _slots_9_io_uop_prs2;
  wire [6:0]  _slots_9_io_uop_prs3;
  wire [4:0]  _slots_9_io_uop_mem_cmd;
  wire        _slots_9_io_uop_is_amo;
  wire        _slots_9_io_uop_uses_ldq;
  wire        _slots_9_io_uop_uses_stq;
  wire [1:0]  _slots_9_io_uop_dst_rtype;
  wire        _slots_9_io_uop_fp_val;
  wire        _slots_8_io_valid;
  wire        _slots_8_io_will_be_valid;
  wire        _slots_8_io_request;
  wire [6:0]  _slots_8_io_out_uop_uopc;
  wire [9:0]  _slots_8_io_out_uop_fu_code;
  wire [1:0]  _slots_8_io_out_uop_iw_state;
  wire [19:0] _slots_8_io_out_uop_br_mask;
  wire [19:0] _slots_8_io_out_uop_imm_packed;
  wire [6:0]  _slots_8_io_out_uop_rob_idx;
  wire [4:0]  _slots_8_io_out_uop_stq_idx;
  wire [6:0]  _slots_8_io_out_uop_pdst;
  wire [6:0]  _slots_8_io_out_uop_prs1;
  wire [6:0]  _slots_8_io_out_uop_prs2;
  wire [6:0]  _slots_8_io_out_uop_prs3;
  wire        _slots_8_io_out_uop_prs1_busy;
  wire        _slots_8_io_out_uop_prs2_busy;
  wire        _slots_8_io_out_uop_prs3_busy;
  wire        _slots_8_io_out_uop_ppred_busy;
  wire [4:0]  _slots_8_io_out_uop_mem_cmd;
  wire        _slots_8_io_out_uop_is_amo;
  wire        _slots_8_io_out_uop_uses_ldq;
  wire        _slots_8_io_out_uop_uses_stq;
  wire [1:0]  _slots_8_io_out_uop_dst_rtype;
  wire        _slots_8_io_out_uop_fp_val;
  wire [6:0]  _slots_8_io_uop_uopc;
  wire [9:0]  _slots_8_io_uop_fu_code;
  wire [19:0] _slots_8_io_uop_br_mask;
  wire [19:0] _slots_8_io_uop_imm_packed;
  wire [6:0]  _slots_8_io_uop_rob_idx;
  wire [4:0]  _slots_8_io_uop_stq_idx;
  wire [6:0]  _slots_8_io_uop_pdst;
  wire [6:0]  _slots_8_io_uop_prs1;
  wire [6:0]  _slots_8_io_uop_prs2;
  wire [6:0]  _slots_8_io_uop_prs3;
  wire [4:0]  _slots_8_io_uop_mem_cmd;
  wire        _slots_8_io_uop_is_amo;
  wire        _slots_8_io_uop_uses_ldq;
  wire        _slots_8_io_uop_uses_stq;
  wire [1:0]  _slots_8_io_uop_dst_rtype;
  wire        _slots_8_io_uop_fp_val;
  wire        _slots_7_io_valid;
  wire        _slots_7_io_will_be_valid;
  wire        _slots_7_io_request;
  wire [6:0]  _slots_7_io_out_uop_uopc;
  wire [9:0]  _slots_7_io_out_uop_fu_code;
  wire [1:0]  _slots_7_io_out_uop_iw_state;
  wire [19:0] _slots_7_io_out_uop_br_mask;
  wire [19:0] _slots_7_io_out_uop_imm_packed;
  wire [6:0]  _slots_7_io_out_uop_rob_idx;
  wire [4:0]  _slots_7_io_out_uop_stq_idx;
  wire [6:0]  _slots_7_io_out_uop_pdst;
  wire [6:0]  _slots_7_io_out_uop_prs1;
  wire [6:0]  _slots_7_io_out_uop_prs2;
  wire [6:0]  _slots_7_io_out_uop_prs3;
  wire        _slots_7_io_out_uop_prs1_busy;
  wire        _slots_7_io_out_uop_prs2_busy;
  wire        _slots_7_io_out_uop_prs3_busy;
  wire        _slots_7_io_out_uop_ppred_busy;
  wire [4:0]  _slots_7_io_out_uop_mem_cmd;
  wire        _slots_7_io_out_uop_is_amo;
  wire        _slots_7_io_out_uop_uses_ldq;
  wire        _slots_7_io_out_uop_uses_stq;
  wire [1:0]  _slots_7_io_out_uop_dst_rtype;
  wire        _slots_7_io_out_uop_fp_val;
  wire [6:0]  _slots_7_io_uop_uopc;
  wire [9:0]  _slots_7_io_uop_fu_code;
  wire [19:0] _slots_7_io_uop_br_mask;
  wire [19:0] _slots_7_io_uop_imm_packed;
  wire [6:0]  _slots_7_io_uop_rob_idx;
  wire [4:0]  _slots_7_io_uop_stq_idx;
  wire [6:0]  _slots_7_io_uop_pdst;
  wire [6:0]  _slots_7_io_uop_prs1;
  wire [6:0]  _slots_7_io_uop_prs2;
  wire [6:0]  _slots_7_io_uop_prs3;
  wire [4:0]  _slots_7_io_uop_mem_cmd;
  wire        _slots_7_io_uop_is_amo;
  wire        _slots_7_io_uop_uses_ldq;
  wire        _slots_7_io_uop_uses_stq;
  wire [1:0]  _slots_7_io_uop_dst_rtype;
  wire        _slots_7_io_uop_fp_val;
  wire        _slots_6_io_valid;
  wire        _slots_6_io_will_be_valid;
  wire        _slots_6_io_request;
  wire [6:0]  _slots_6_io_out_uop_uopc;
  wire [9:0]  _slots_6_io_out_uop_fu_code;
  wire [1:0]  _slots_6_io_out_uop_iw_state;
  wire [19:0] _slots_6_io_out_uop_br_mask;
  wire [19:0] _slots_6_io_out_uop_imm_packed;
  wire [6:0]  _slots_6_io_out_uop_rob_idx;
  wire [4:0]  _slots_6_io_out_uop_stq_idx;
  wire [6:0]  _slots_6_io_out_uop_pdst;
  wire [6:0]  _slots_6_io_out_uop_prs1;
  wire [6:0]  _slots_6_io_out_uop_prs2;
  wire [6:0]  _slots_6_io_out_uop_prs3;
  wire        _slots_6_io_out_uop_prs1_busy;
  wire        _slots_6_io_out_uop_prs2_busy;
  wire        _slots_6_io_out_uop_prs3_busy;
  wire        _slots_6_io_out_uop_ppred_busy;
  wire [4:0]  _slots_6_io_out_uop_mem_cmd;
  wire        _slots_6_io_out_uop_is_amo;
  wire        _slots_6_io_out_uop_uses_ldq;
  wire        _slots_6_io_out_uop_uses_stq;
  wire [1:0]  _slots_6_io_out_uop_dst_rtype;
  wire        _slots_6_io_out_uop_fp_val;
  wire [6:0]  _slots_6_io_uop_uopc;
  wire [9:0]  _slots_6_io_uop_fu_code;
  wire [19:0] _slots_6_io_uop_br_mask;
  wire [19:0] _slots_6_io_uop_imm_packed;
  wire [6:0]  _slots_6_io_uop_rob_idx;
  wire [4:0]  _slots_6_io_uop_stq_idx;
  wire [6:0]  _slots_6_io_uop_pdst;
  wire [6:0]  _slots_6_io_uop_prs1;
  wire [6:0]  _slots_6_io_uop_prs2;
  wire [6:0]  _slots_6_io_uop_prs3;
  wire [4:0]  _slots_6_io_uop_mem_cmd;
  wire        _slots_6_io_uop_is_amo;
  wire        _slots_6_io_uop_uses_ldq;
  wire        _slots_6_io_uop_uses_stq;
  wire [1:0]  _slots_6_io_uop_dst_rtype;
  wire        _slots_6_io_uop_fp_val;
  wire        _slots_5_io_valid;
  wire        _slots_5_io_will_be_valid;
  wire        _slots_5_io_request;
  wire [6:0]  _slots_5_io_out_uop_uopc;
  wire [9:0]  _slots_5_io_out_uop_fu_code;
  wire [1:0]  _slots_5_io_out_uop_iw_state;
  wire [19:0] _slots_5_io_out_uop_br_mask;
  wire [19:0] _slots_5_io_out_uop_imm_packed;
  wire [6:0]  _slots_5_io_out_uop_rob_idx;
  wire [4:0]  _slots_5_io_out_uop_stq_idx;
  wire [6:0]  _slots_5_io_out_uop_pdst;
  wire [6:0]  _slots_5_io_out_uop_prs1;
  wire [6:0]  _slots_5_io_out_uop_prs2;
  wire [6:0]  _slots_5_io_out_uop_prs3;
  wire        _slots_5_io_out_uop_prs1_busy;
  wire        _slots_5_io_out_uop_prs2_busy;
  wire        _slots_5_io_out_uop_prs3_busy;
  wire        _slots_5_io_out_uop_ppred_busy;
  wire [4:0]  _slots_5_io_out_uop_mem_cmd;
  wire        _slots_5_io_out_uop_is_amo;
  wire        _slots_5_io_out_uop_uses_ldq;
  wire        _slots_5_io_out_uop_uses_stq;
  wire [1:0]  _slots_5_io_out_uop_dst_rtype;
  wire        _slots_5_io_out_uop_fp_val;
  wire [6:0]  _slots_5_io_uop_uopc;
  wire [9:0]  _slots_5_io_uop_fu_code;
  wire [19:0] _slots_5_io_uop_br_mask;
  wire [19:0] _slots_5_io_uop_imm_packed;
  wire [6:0]  _slots_5_io_uop_rob_idx;
  wire [4:0]  _slots_5_io_uop_stq_idx;
  wire [6:0]  _slots_5_io_uop_pdst;
  wire [6:0]  _slots_5_io_uop_prs1;
  wire [6:0]  _slots_5_io_uop_prs2;
  wire [6:0]  _slots_5_io_uop_prs3;
  wire [4:0]  _slots_5_io_uop_mem_cmd;
  wire        _slots_5_io_uop_is_amo;
  wire        _slots_5_io_uop_uses_ldq;
  wire        _slots_5_io_uop_uses_stq;
  wire [1:0]  _slots_5_io_uop_dst_rtype;
  wire        _slots_5_io_uop_fp_val;
  wire        _slots_4_io_valid;
  wire        _slots_4_io_will_be_valid;
  wire        _slots_4_io_request;
  wire [6:0]  _slots_4_io_out_uop_uopc;
  wire [9:0]  _slots_4_io_out_uop_fu_code;
  wire [1:0]  _slots_4_io_out_uop_iw_state;
  wire [19:0] _slots_4_io_out_uop_br_mask;
  wire [19:0] _slots_4_io_out_uop_imm_packed;
  wire [6:0]  _slots_4_io_out_uop_rob_idx;
  wire [4:0]  _slots_4_io_out_uop_stq_idx;
  wire [6:0]  _slots_4_io_out_uop_pdst;
  wire [6:0]  _slots_4_io_out_uop_prs1;
  wire [6:0]  _slots_4_io_out_uop_prs2;
  wire [6:0]  _slots_4_io_out_uop_prs3;
  wire        _slots_4_io_out_uop_prs1_busy;
  wire        _slots_4_io_out_uop_prs2_busy;
  wire        _slots_4_io_out_uop_prs3_busy;
  wire        _slots_4_io_out_uop_ppred_busy;
  wire [4:0]  _slots_4_io_out_uop_mem_cmd;
  wire        _slots_4_io_out_uop_is_amo;
  wire        _slots_4_io_out_uop_uses_ldq;
  wire        _slots_4_io_out_uop_uses_stq;
  wire [1:0]  _slots_4_io_out_uop_dst_rtype;
  wire        _slots_4_io_out_uop_fp_val;
  wire [6:0]  _slots_4_io_uop_uopc;
  wire [9:0]  _slots_4_io_uop_fu_code;
  wire [19:0] _slots_4_io_uop_br_mask;
  wire [19:0] _slots_4_io_uop_imm_packed;
  wire [6:0]  _slots_4_io_uop_rob_idx;
  wire [4:0]  _slots_4_io_uop_stq_idx;
  wire [6:0]  _slots_4_io_uop_pdst;
  wire [6:0]  _slots_4_io_uop_prs1;
  wire [6:0]  _slots_4_io_uop_prs2;
  wire [6:0]  _slots_4_io_uop_prs3;
  wire [4:0]  _slots_4_io_uop_mem_cmd;
  wire        _slots_4_io_uop_is_amo;
  wire        _slots_4_io_uop_uses_ldq;
  wire        _slots_4_io_uop_uses_stq;
  wire [1:0]  _slots_4_io_uop_dst_rtype;
  wire        _slots_4_io_uop_fp_val;
  wire        _slots_3_io_valid;
  wire        _slots_3_io_will_be_valid;
  wire        _slots_3_io_request;
  wire [6:0]  _slots_3_io_out_uop_uopc;
  wire [9:0]  _slots_3_io_out_uop_fu_code;
  wire [1:0]  _slots_3_io_out_uop_iw_state;
  wire [19:0] _slots_3_io_out_uop_br_mask;
  wire [19:0] _slots_3_io_out_uop_imm_packed;
  wire [6:0]  _slots_3_io_out_uop_rob_idx;
  wire [4:0]  _slots_3_io_out_uop_stq_idx;
  wire [6:0]  _slots_3_io_out_uop_pdst;
  wire [6:0]  _slots_3_io_out_uop_prs1;
  wire [6:0]  _slots_3_io_out_uop_prs2;
  wire [6:0]  _slots_3_io_out_uop_prs3;
  wire        _slots_3_io_out_uop_prs1_busy;
  wire        _slots_3_io_out_uop_prs2_busy;
  wire        _slots_3_io_out_uop_prs3_busy;
  wire        _slots_3_io_out_uop_ppred_busy;
  wire [4:0]  _slots_3_io_out_uop_mem_cmd;
  wire        _slots_3_io_out_uop_is_amo;
  wire        _slots_3_io_out_uop_uses_ldq;
  wire        _slots_3_io_out_uop_uses_stq;
  wire [1:0]  _slots_3_io_out_uop_dst_rtype;
  wire        _slots_3_io_out_uop_fp_val;
  wire [6:0]  _slots_3_io_uop_uopc;
  wire [9:0]  _slots_3_io_uop_fu_code;
  wire [19:0] _slots_3_io_uop_br_mask;
  wire [19:0] _slots_3_io_uop_imm_packed;
  wire [6:0]  _slots_3_io_uop_rob_idx;
  wire [4:0]  _slots_3_io_uop_stq_idx;
  wire [6:0]  _slots_3_io_uop_pdst;
  wire [6:0]  _slots_3_io_uop_prs1;
  wire [6:0]  _slots_3_io_uop_prs2;
  wire [6:0]  _slots_3_io_uop_prs3;
  wire [4:0]  _slots_3_io_uop_mem_cmd;
  wire        _slots_3_io_uop_is_amo;
  wire        _slots_3_io_uop_uses_ldq;
  wire        _slots_3_io_uop_uses_stq;
  wire [1:0]  _slots_3_io_uop_dst_rtype;
  wire        _slots_3_io_uop_fp_val;
  wire        _slots_2_io_valid;
  wire        _slots_2_io_will_be_valid;
  wire        _slots_2_io_request;
  wire [6:0]  _slots_2_io_out_uop_uopc;
  wire [9:0]  _slots_2_io_out_uop_fu_code;
  wire [1:0]  _slots_2_io_out_uop_iw_state;
  wire [19:0] _slots_2_io_out_uop_br_mask;
  wire [19:0] _slots_2_io_out_uop_imm_packed;
  wire [6:0]  _slots_2_io_out_uop_rob_idx;
  wire [4:0]  _slots_2_io_out_uop_stq_idx;
  wire [6:0]  _slots_2_io_out_uop_pdst;
  wire [6:0]  _slots_2_io_out_uop_prs1;
  wire [6:0]  _slots_2_io_out_uop_prs2;
  wire [6:0]  _slots_2_io_out_uop_prs3;
  wire        _slots_2_io_out_uop_prs1_busy;
  wire        _slots_2_io_out_uop_prs2_busy;
  wire        _slots_2_io_out_uop_prs3_busy;
  wire        _slots_2_io_out_uop_ppred_busy;
  wire [4:0]  _slots_2_io_out_uop_mem_cmd;
  wire        _slots_2_io_out_uop_is_amo;
  wire        _slots_2_io_out_uop_uses_ldq;
  wire        _slots_2_io_out_uop_uses_stq;
  wire [1:0]  _slots_2_io_out_uop_dst_rtype;
  wire        _slots_2_io_out_uop_fp_val;
  wire [6:0]  _slots_2_io_uop_uopc;
  wire [9:0]  _slots_2_io_uop_fu_code;
  wire [19:0] _slots_2_io_uop_br_mask;
  wire [19:0] _slots_2_io_uop_imm_packed;
  wire [6:0]  _slots_2_io_uop_rob_idx;
  wire [4:0]  _slots_2_io_uop_stq_idx;
  wire [6:0]  _slots_2_io_uop_pdst;
  wire [6:0]  _slots_2_io_uop_prs1;
  wire [6:0]  _slots_2_io_uop_prs2;
  wire [6:0]  _slots_2_io_uop_prs3;
  wire [4:0]  _slots_2_io_uop_mem_cmd;
  wire        _slots_2_io_uop_is_amo;
  wire        _slots_2_io_uop_uses_ldq;
  wire        _slots_2_io_uop_uses_stq;
  wire [1:0]  _slots_2_io_uop_dst_rtype;
  wire        _slots_2_io_uop_fp_val;
  wire        _slots_1_io_valid;
  wire        _slots_1_io_will_be_valid;
  wire        _slots_1_io_request;
  wire [6:0]  _slots_1_io_out_uop_uopc;
  wire [9:0]  _slots_1_io_out_uop_fu_code;
  wire [1:0]  _slots_1_io_out_uop_iw_state;
  wire [19:0] _slots_1_io_out_uop_br_mask;
  wire [19:0] _slots_1_io_out_uop_imm_packed;
  wire [6:0]  _slots_1_io_out_uop_rob_idx;
  wire [4:0]  _slots_1_io_out_uop_stq_idx;
  wire [6:0]  _slots_1_io_out_uop_pdst;
  wire [6:0]  _slots_1_io_out_uop_prs1;
  wire [6:0]  _slots_1_io_out_uop_prs2;
  wire [6:0]  _slots_1_io_out_uop_prs3;
  wire        _slots_1_io_out_uop_prs1_busy;
  wire        _slots_1_io_out_uop_prs2_busy;
  wire        _slots_1_io_out_uop_prs3_busy;
  wire        _slots_1_io_out_uop_ppred_busy;
  wire [4:0]  _slots_1_io_out_uop_mem_cmd;
  wire        _slots_1_io_out_uop_is_amo;
  wire        _slots_1_io_out_uop_uses_ldq;
  wire        _slots_1_io_out_uop_uses_stq;
  wire [1:0]  _slots_1_io_out_uop_dst_rtype;
  wire        _slots_1_io_out_uop_fp_val;
  wire [6:0]  _slots_1_io_uop_uopc;
  wire [9:0]  _slots_1_io_uop_fu_code;
  wire [19:0] _slots_1_io_uop_br_mask;
  wire [19:0] _slots_1_io_uop_imm_packed;
  wire [6:0]  _slots_1_io_uop_rob_idx;
  wire [4:0]  _slots_1_io_uop_stq_idx;
  wire [6:0]  _slots_1_io_uop_pdst;
  wire [6:0]  _slots_1_io_uop_prs1;
  wire [6:0]  _slots_1_io_uop_prs2;
  wire [6:0]  _slots_1_io_uop_prs3;
  wire [4:0]  _slots_1_io_uop_mem_cmd;
  wire        _slots_1_io_uop_is_amo;
  wire        _slots_1_io_uop_uses_ldq;
  wire        _slots_1_io_uop_uses_stq;
  wire [1:0]  _slots_1_io_uop_dst_rtype;
  wire        _slots_1_io_uop_fp_val;
  wire        _slots_0_io_valid;
  wire        _slots_0_io_will_be_valid;
  wire        _slots_0_io_request;
  wire [6:0]  _slots_0_io_uop_uopc;
  wire [9:0]  _slots_0_io_uop_fu_code;
  wire [19:0] _slots_0_io_uop_br_mask;
  wire [19:0] _slots_0_io_uop_imm_packed;
  wire [6:0]  _slots_0_io_uop_rob_idx;
  wire [4:0]  _slots_0_io_uop_stq_idx;
  wire [6:0]  _slots_0_io_uop_pdst;
  wire [6:0]  _slots_0_io_uop_prs1;
  wire [6:0]  _slots_0_io_uop_prs2;
  wire [6:0]  _slots_0_io_uop_prs3;
  wire [4:0]  _slots_0_io_uop_mem_cmd;
  wire        _slots_0_io_uop_is_amo;
  wire        _slots_0_io_uop_uses_ldq;
  wire        _slots_0_io_uop_uses_stq;
  wire [1:0]  _slots_0_io_uop_dst_rtype;
  wire        _slots_0_io_uop_fp_val;
  wire        _GEN_10036 = io_dis_uops_0_bits_uopc != 7'h2 & io_dis_uops_0_bits_prs1_busy;
  wire        _GEN_3 = io_dis_uops_1_bits_uopc != 7'h2 & io_dis_uops_1_bits_prs1_busy;
  wire        _GEN_5 = io_dis_uops_2_bits_uopc != 7'h2 & io_dis_uops_2_bits_prs1_busy;
  wire [9:0]  _can_allocate_T = _slots_0_io_uop_fu_code & io_fu_types_0;
  wire        _GEN = _slots_0_io_request & (|_can_allocate_T);
  wire        _GEN_0 = _slots_0_io_request & ~_GEN;
  wire        _GEN_10399 = _GEN_0 & _slots_0_io_uop_fu_code[6];
  wire        _GEN_10318 = _slots_0_io_request & (|_can_allocate_T);
  wire        issue_slots_0_grant = _GEN_10399 | _GEN_10318;
  wire        _GEN_1 = _slots_1_io_request & (|(_slots_1_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_2 = _slots_1_io_request & ~(_GEN_1 & ~_GEN) & _slots_1_io_uop_fu_code[6];
  wire        _GEN_4 = _GEN_0 & _slots_0_io_uop_fu_code[6];
  wire        _GEN_6 = _GEN_2 & ~_GEN_4;
  wire        _GEN_10479 = _GEN_1 & ~_GEN;
  wire        issue_slots_1_grant = _GEN_6 | _GEN_10479;
  wire        _GEN_7 = _slots_2_io_request & (|(_slots_2_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_8 = _GEN_1 | _GEN;
  wire        _GEN_9 = _slots_2_io_request & ~(_GEN_7 & ~_GEN_8) & _slots_2_io_uop_fu_code[6];
  wire        _GEN_10 = _GEN_2 | _GEN_4;
  wire        _GEN_11 = _GEN_9 & ~_GEN_10;
  wire        _GEN_10641 = _GEN_7 & ~_GEN_8;
  wire        issue_slots_2_grant = _GEN_11 | _GEN_10641;
  wire        _GEN_12 = _slots_3_io_request & (|(_slots_3_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_14 = _GEN_7 | _GEN_8;
  wire        _GEN_16 = _slots_3_io_request & ~(_GEN_12 & ~_GEN_14) & _slots_3_io_uop_fu_code[6];
  wire        _GEN_18 = _GEN_9 | _GEN_10;
  wire        _GEN_20 = _GEN_16 & ~_GEN_18;
  wire        _GEN_10803 = _GEN_12 & ~_GEN_14;
  wire        issue_slots_3_grant = _GEN_20 | _GEN_10803;
  wire        _GEN_22 = _slots_4_io_request & (|(_slots_4_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_24 = _GEN_12 | _GEN_14;
  wire        _GEN_26 = _slots_4_io_request & ~(_GEN_22 & ~_GEN_24) & _slots_4_io_uop_fu_code[6];
  wire        _GEN_28 = _GEN_16 | _GEN_18;
  wire        _GEN_30 = _GEN_26 & ~_GEN_28;
  wire        _GEN_10965 = _GEN_22 & ~_GEN_24;
  wire        issue_slots_4_grant = _GEN_30 | _GEN_10965;
  wire        _GEN_32 = _slots_5_io_request & (|(_slots_5_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_34 = _GEN_22 | _GEN_24;
  wire        _GEN_36 = _slots_5_io_request & ~(_GEN_32 & ~_GEN_34) & _slots_5_io_uop_fu_code[6];
  wire        _GEN_38 = _GEN_26 | _GEN_28;
  wire        _GEN_40 = _GEN_36 & ~_GEN_38;
  wire        _GEN_11127 = _GEN_32 & ~_GEN_34;
  wire        issue_slots_5_grant = _GEN_40 | _GEN_11127;
  wire        _GEN_42 = _slots_6_io_request & (|(_slots_6_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_44 = _GEN_32 | _GEN_34;
  wire        _GEN_46 = _slots_6_io_request & ~(_GEN_42 & ~_GEN_44) & _slots_6_io_uop_fu_code[6];
  wire        _GEN_48 = _GEN_36 | _GEN_38;
  wire        _GEN_50 = _GEN_46 & ~_GEN_48;
  wire        _GEN_11289 = _GEN_42 & ~_GEN_44;
  wire        issue_slots_6_grant = _GEN_50 | _GEN_11289;
  wire        _GEN_52 = _slots_7_io_request & (|(_slots_7_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_54 = _GEN_42 | _GEN_44;
  wire        _GEN_56 = _slots_7_io_request & ~(_GEN_52 & ~_GEN_54) & _slots_7_io_uop_fu_code[6];
  wire        _GEN_58 = _GEN_46 | _GEN_48;
  wire        _GEN_60 = _GEN_56 & ~_GEN_58;
  wire        _GEN_11451 = _GEN_52 & ~_GEN_54;
  wire        issue_slots_7_grant = _GEN_60 | _GEN_11451;
  wire        _GEN_62 = _slots_8_io_request & (|(_slots_8_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_64 = _GEN_52 | _GEN_54;
  wire        _GEN_66 = _slots_8_io_request & ~(_GEN_62 & ~_GEN_64) & _slots_8_io_uop_fu_code[6];
  wire        _GEN_68 = _GEN_56 | _GEN_58;
  wire        _GEN_70 = _GEN_66 & ~_GEN_68;
  wire        _GEN_11613 = _GEN_62 & ~_GEN_64;
  wire        issue_slots_8_grant = _GEN_70 | _GEN_11613;
  wire        _GEN_71 = _slots_9_io_request & (|(_slots_9_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_72 = _GEN_62 | _GEN_64;
  wire        _GEN_73 = _slots_9_io_request & ~(_GEN_71 & ~_GEN_72) & _slots_9_io_uop_fu_code[6];
  wire        _GEN_74 = _GEN_66 | _GEN_68;
  wire        _GEN_75 = _GEN_73 & ~_GEN_74;
  wire        _GEN_11775 = _GEN_71 & ~_GEN_72;
  wire        issue_slots_9_grant = _GEN_75 | _GEN_11775;
  wire        _GEN_76 = _slots_10_io_request & (|(_slots_10_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_77 = _GEN_71 | _GEN_72;
  wire        _GEN_78 = _slots_10_io_request & ~(_GEN_76 & ~_GEN_77) & _slots_10_io_uop_fu_code[6];
  wire        _GEN_79 = _GEN_73 | _GEN_74;
  wire        _GEN_80 = _GEN_78 & ~_GEN_79;
  wire        _GEN_11937 = _GEN_76 & ~_GEN_77;
  wire        issue_slots_10_grant = _GEN_80 | _GEN_11937;
  wire        _GEN_81 = _slots_11_io_request & (|(_slots_11_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_82 = _GEN_76 | _GEN_77;
  wire        _GEN_83 = _slots_11_io_request & ~(_GEN_81 & ~_GEN_82) & _slots_11_io_uop_fu_code[6];
  wire        _GEN_84 = _GEN_78 | _GEN_79;
  wire        _GEN_85 = _GEN_83 & ~_GEN_84;
  wire        _GEN_12099 = _GEN_81 & ~_GEN_82;
  wire        issue_slots_11_grant = _GEN_85 | _GEN_12099;
  wire        _GEN_86 = _slots_12_io_request & (|(_slots_12_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_87 = _GEN_81 | _GEN_82;
  wire        _GEN_88 = _slots_12_io_request & ~(_GEN_86 & ~_GEN_87) & _slots_12_io_uop_fu_code[6];
  wire        _GEN_89 = _GEN_83 | _GEN_84;
  wire        _GEN_90 = _GEN_88 & ~_GEN_89;
  wire        _GEN_12261 = _GEN_86 & ~_GEN_87;
  wire        issue_slots_12_grant = _GEN_90 | _GEN_12261;
  wire        _GEN_91 = _slots_13_io_request & (|(_slots_13_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_92 = _GEN_86 | _GEN_87;
  wire        _GEN_93 = _slots_13_io_request & ~(_GEN_91 & ~_GEN_92) & _slots_13_io_uop_fu_code[6];
  wire        _GEN_94 = _GEN_88 | _GEN_89;
  wire        _GEN_95 = _GEN_93 & ~_GEN_94;
  wire        _GEN_12423 = _GEN_91 & ~_GEN_92;
  wire        issue_slots_13_grant = _GEN_95 | _GEN_12423;
  wire        _GEN_96 = _slots_14_io_request & (|(_slots_14_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_97 = _GEN_91 | _GEN_92;
  wire        _GEN_98 = _slots_14_io_request & ~(_GEN_96 & ~_GEN_97) & _slots_14_io_uop_fu_code[6];
  wire        _GEN_99 = _GEN_93 | _GEN_94;
  wire        _GEN_100 = _GEN_98 & ~_GEN_99;
  wire        _GEN_12585 = _GEN_96 & ~_GEN_97;
  wire        issue_slots_14_grant = _GEN_100 | _GEN_12585;
  wire        _GEN_101 = _slots_15_io_request & (|(_slots_15_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_102 = _GEN_96 | _GEN_97;
  wire        _GEN_103 = _slots_15_io_request & ~(_GEN_101 & ~_GEN_102) & _slots_15_io_uop_fu_code[6];
  wire        _GEN_104 = _GEN_98 | _GEN_99;
  wire        _GEN_105 = _GEN_103 & ~_GEN_104;
  wire        _GEN_12747 = _GEN_101 & ~_GEN_102;
  wire        issue_slots_15_grant = _GEN_105 | _GEN_12747;
  wire        _GEN_106 = _slots_16_io_request & (|(_slots_16_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_107 = _GEN_101 | _GEN_102;
  wire        _GEN_108 = _slots_16_io_request & ~(_GEN_106 & ~_GEN_107) & _slots_16_io_uop_fu_code[6];
  wire        _GEN_109 = _GEN_103 | _GEN_104;
  wire        _GEN_110 = _GEN_108 & ~_GEN_109;
  wire        _GEN_12909 = _GEN_106 & ~_GEN_107;
  wire        issue_slots_16_grant = _GEN_110 | _GEN_12909;
  wire        _GEN_111 = _slots_17_io_request & (|(_slots_17_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_112 = _GEN_106 | _GEN_107;
  wire        _GEN_113 = _slots_17_io_request & ~(_GEN_111 & ~_GEN_112) & _slots_17_io_uop_fu_code[6];
  wire        _GEN_114 = _GEN_108 | _GEN_109;
  wire        _GEN_115 = _GEN_113 & ~_GEN_114;
  wire        _GEN_13071 = _GEN_111 & ~_GEN_112;
  wire        issue_slots_17_grant = _GEN_115 | _GEN_13071;
  wire        _GEN_116 = _slots_18_io_request & (|(_slots_18_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_117 = _GEN_111 | _GEN_112;
  wire        _GEN_118 = _slots_18_io_request & ~(_GEN_116 & ~_GEN_117) & _slots_18_io_uop_fu_code[6];
  wire        _GEN_119 = _GEN_113 | _GEN_114;
  wire        _GEN_120 = _GEN_118 & ~_GEN_119;
  wire        _GEN_13233 = _GEN_116 & ~_GEN_117;
  wire        issue_slots_18_grant = _GEN_120 | _GEN_13233;
  wire        _GEN_121 = _slots_19_io_request & (|(_slots_19_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_122 = _GEN_116 | _GEN_117;
  wire        _GEN_123 = _slots_19_io_request & ~(_GEN_121 & ~_GEN_122) & _slots_19_io_uop_fu_code[6];
  wire        _GEN_124 = _GEN_118 | _GEN_119;
  wire        _GEN_125 = _GEN_123 & ~_GEN_124;
  wire        _GEN_13395 = _GEN_121 & ~_GEN_122;
  wire        issue_slots_19_grant = _GEN_125 | _GEN_13395;
  wire        _GEN_126 = _slots_20_io_request & (|(_slots_20_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_127 = _GEN_121 | _GEN_122;
  wire        _GEN_128 = _slots_20_io_request & ~(_GEN_126 & ~_GEN_127) & _slots_20_io_uop_fu_code[6];
  wire        _GEN_129 = _GEN_123 | _GEN_124;
  wire        _GEN_130 = _GEN_128 & ~_GEN_129;
  wire        _GEN_13557 = _GEN_126 & ~_GEN_127;
  wire        issue_slots_20_grant = _GEN_130 | _GEN_13557;
  wire        _GEN_131 = _slots_21_io_request & (|(_slots_21_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_132 = _GEN_126 | _GEN_127;
  wire        _GEN_133 = _slots_21_io_request & ~(_GEN_131 & ~_GEN_132) & _slots_21_io_uop_fu_code[6];
  wire        _GEN_134 = _GEN_128 | _GEN_129;
  wire        _GEN_135 = _GEN_133 & ~_GEN_134;
  wire        _GEN_13719 = _GEN_131 & ~_GEN_132;
  wire        issue_slots_21_grant = _GEN_135 | _GEN_13719;
  wire        _GEN_136 = _slots_22_io_request & (|(_slots_22_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_137 = _GEN_131 | _GEN_132;
  wire        _GEN_138 = _slots_22_io_request & ~(_GEN_136 & ~_GEN_137) & _slots_22_io_uop_fu_code[6];
  wire        _GEN_139 = _GEN_133 | _GEN_134;
  wire        _GEN_140 = _GEN_138 & ~_GEN_139;
  wire        _GEN_13881 = _GEN_136 & ~_GEN_137;
  wire        issue_slots_22_grant = _GEN_140 | _GEN_13881;
  wire        _GEN_141 = _slots_23_io_request & (|(_slots_23_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_142 = _GEN_136 | _GEN_137;
  wire        _GEN_143 = _slots_23_io_request & ~(_GEN_141 & ~_GEN_142) & _slots_23_io_uop_fu_code[6];
  wire        _GEN_144 = _GEN_138 | _GEN_139;
  wire        _GEN_145 = _GEN_143 & ~_GEN_144;
  wire        _GEN_14043 = _GEN_141 & ~_GEN_142;
  wire        issue_slots_23_grant = _GEN_145 | _GEN_14043;
  wire        _GEN_146 = _slots_24_io_request & (|(_slots_24_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_147 = _GEN_141 | _GEN_142;
  wire        _GEN_148 = _slots_24_io_request & ~(_GEN_146 & ~_GEN_147) & _slots_24_io_uop_fu_code[6];
  wire        _GEN_149 = _GEN_143 | _GEN_144;
  wire        _GEN_150 = _GEN_148 & ~_GEN_149;
  wire        _GEN_14205 = _GEN_146 & ~_GEN_147;
  wire        issue_slots_24_grant = _GEN_150 | _GEN_14205;
  wire        _GEN_151 = _slots_25_io_request & (|(_slots_25_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_152 = _GEN_146 | _GEN_147;
  wire        _GEN_153 = _slots_25_io_request & ~(_GEN_151 & ~_GEN_152) & _slots_25_io_uop_fu_code[6];
  wire        _GEN_154 = _GEN_148 | _GEN_149;
  wire        _GEN_155 = _GEN_153 & ~_GEN_154;
  wire        _GEN_14367 = _GEN_151 & ~_GEN_152;
  wire        issue_slots_25_grant = _GEN_155 | _GEN_14367;
  wire        _GEN_156 = _slots_26_io_request & (|(_slots_26_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_157 = _GEN_151 | _GEN_152;
  wire        _GEN_158 = _slots_26_io_request & ~(_GEN_156 & ~_GEN_157) & _slots_26_io_uop_fu_code[6];
  wire        _GEN_159 = _GEN_153 | _GEN_154;
  wire        _GEN_160 = _GEN_158 & ~_GEN_159;
  wire        _GEN_14529 = _GEN_156 & ~_GEN_157;
  wire        issue_slots_26_grant = _GEN_160 | _GEN_14529;
  wire        _GEN_161 = _slots_27_io_request & (|(_slots_27_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_162 = _GEN_156 | _GEN_157;
  wire        _GEN_163 = _slots_27_io_request & ~(_GEN_161 & ~_GEN_162) & _slots_27_io_uop_fu_code[6];
  wire        _GEN_164 = _GEN_158 | _GEN_159;
  wire        _GEN_165 = _GEN_163 & ~_GEN_164;
  wire        _GEN_14691 = _GEN_161 & ~_GEN_162;
  wire        issue_slots_27_grant = _GEN_165 | _GEN_14691;
  wire        _GEN_166 = _slots_28_io_request & (|(_slots_28_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_167 = _GEN_161 | _GEN_162;
  wire        _GEN_168 = _slots_28_io_request & ~(_GEN_166 & ~_GEN_167) & _slots_28_io_uop_fu_code[6];
  wire        _GEN_169 = _GEN_163 | _GEN_164;
  wire        _GEN_170 = _GEN_168 & ~_GEN_169;
  wire        _GEN_14853 = _GEN_166 & ~_GEN_167;
  wire        issue_slots_28_grant = _GEN_170 | _GEN_14853;
  wire        _GEN_171 = _slots_29_io_request & (|(_slots_29_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_172 = _GEN_166 | _GEN_167;
  wire        _GEN_173 = _slots_29_io_request & ~(_GEN_171 & ~_GEN_172) & _slots_29_io_uop_fu_code[6];
  wire        _GEN_174 = _GEN_168 | _GEN_169;
  wire        _GEN_175 = _GEN_173 & ~_GEN_174;
  wire        _GEN_15015 = _GEN_171 & ~_GEN_172;
  wire        issue_slots_29_grant = _GEN_175 | _GEN_15015;
  wire        _GEN_176 = _slots_30_io_request & (|(_slots_30_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_177 = _GEN_171 | _GEN_172;
  wire        _GEN_178 = _slots_30_io_request & ~(_GEN_176 & ~_GEN_177) & _slots_30_io_uop_fu_code[6];
  wire        _GEN_179 = _GEN_173 | _GEN_174;
  wire        _GEN_180 = _GEN_178 & ~_GEN_179;
  wire        _GEN_15177 = _GEN_176 & ~_GEN_177;
  wire        issue_slots_30_grant = _GEN_180 | _GEN_15177;
  wire        _GEN_181 = _slots_31_io_request & (|(_slots_31_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_182 = _GEN_176 | _GEN_177;
  wire        _GEN_183 = _slots_31_io_request & ~(_GEN_181 & ~_GEN_182) & _slots_31_io_uop_fu_code[6] & ~(_GEN_178 | _GEN_179);
  wire        _GEN_15339 = _GEN_181 & ~_GEN_182;
  wire        issue_slots_31_grant = _GEN_183 | _GEN_15339;
  wire [3:0]  _GEN_11_0 = _slots_0_io_valid & ~_slots_1_io_valid ? 4'h1 : _slots_1_io_valid ? {3'h0, ~_slots_0_io_valid} : {2'h0, ~_slots_0_io_valid, 1'h0};
  assign _GEN_11_1to0 = _GEN_11_0[1:0];
  assign _GEN_13 = _GEN_11_1to0 == 2'h0 & ~_slots_2_io_valid ? 4'h1 : _GEN_11_0[3] | _slots_2_io_valid ? _GEN_11_0 : {_GEN_11_0[2:0], 1'h0};
  assign _GEN_15 = _GEN_13 == 4'h0 & ~_slots_3_io_valid ? 4'h1 : _GEN_13[3] | _slots_3_io_valid ? _GEN_13 : {_GEN_13[2:0], 1'h0};
  assign _GEN_17 = _GEN_15 == 4'h0 & ~_slots_4_io_valid ? 4'h1 : _GEN_15[3] | _slots_4_io_valid ? _GEN_15 : {_GEN_15[2:0], 1'h0};
  assign _GEN_19 = _GEN_17 == 4'h0 & ~_slots_5_io_valid ? 4'h1 : _GEN_17[3] | _slots_5_io_valid ? _GEN_17 : {_GEN_17[2:0], 1'h0};
  assign _GEN_21 = _GEN_19 == 4'h0 & ~_slots_6_io_valid ? 4'h1 : _GEN_19[3] | _slots_6_io_valid ? _GEN_19 : {_GEN_19[2:0], 1'h0};
  assign _GEN_23 = _GEN_21 == 4'h0 & ~_slots_7_io_valid ? 4'h1 : _GEN_21[3] | _slots_7_io_valid ? _GEN_21 : {_GEN_21[2:0], 1'h0};
  assign _GEN_25 = _GEN_23 == 4'h0 & ~_slots_8_io_valid ? 4'h1 : _GEN_23[3] | _slots_8_io_valid ? _GEN_23 : {_GEN_23[2:0], 1'h0};
  assign _GEN_27 = _GEN_25 == 4'h0 & ~_slots_9_io_valid ? 4'h1 : _GEN_25[3] | _slots_9_io_valid ? _GEN_25 : {_GEN_25[2:0], 1'h0};
  assign _GEN_29 = _GEN_27 == 4'h0 & ~_slots_10_io_valid ? 4'h1 : _GEN_27[3] | _slots_10_io_valid ? _GEN_27 : {_GEN_27[2:0], 1'h0};
  assign _GEN_31 = _GEN_29 == 4'h0 & ~_slots_11_io_valid ? 4'h1 : _GEN_29[3] | _slots_11_io_valid ? _GEN_29 : {_GEN_29[2:0], 1'h0};
  assign _GEN_33 = _GEN_31 == 4'h0 & ~_slots_12_io_valid ? 4'h1 : _GEN_31[3] | _slots_12_io_valid ? _GEN_31 : {_GEN_31[2:0], 1'h0};
  assign _GEN_35 = _GEN_33 == 4'h0 & ~_slots_13_io_valid ? 4'h1 : _GEN_33[3] | _slots_13_io_valid ? _GEN_33 : {_GEN_33[2:0], 1'h0};
  assign _GEN_37 = _GEN_35 == 4'h0 & ~_slots_14_io_valid ? 4'h1 : _GEN_35[3] | _slots_14_io_valid ? _GEN_35 : {_GEN_35[2:0], 1'h0};
  assign _GEN_39 = _GEN_37 == 4'h0 & ~_slots_15_io_valid ? 4'h1 : _GEN_37[3] | _slots_15_io_valid ? _GEN_37 : {_GEN_37[2:0], 1'h0};
  assign _GEN_41 = _GEN_39 == 4'h0 & ~_slots_16_io_valid ? 4'h1 : _GEN_39[3] | _slots_16_io_valid ? _GEN_39 : {_GEN_39[2:0], 1'h0};
  assign _GEN_43 = _GEN_41 == 4'h0 & ~_slots_17_io_valid ? 4'h1 : _GEN_41[3] | _slots_17_io_valid ? _GEN_41 : {_GEN_41[2:0], 1'h0};
  assign _GEN_45 = _GEN_43 == 4'h0 & ~_slots_18_io_valid ? 4'h1 : _GEN_43[3] | _slots_18_io_valid ? _GEN_43 : {_GEN_43[2:0], 1'h0};
  assign _GEN_47 = _GEN_45 == 4'h0 & ~_slots_19_io_valid ? 4'h1 : _GEN_45[3] | _slots_19_io_valid ? _GEN_45 : {_GEN_45[2:0], 1'h0};
  assign _GEN_49 = _GEN_47 == 4'h0 & ~_slots_20_io_valid ? 4'h1 : _GEN_47[3] | _slots_20_io_valid ? _GEN_47 : {_GEN_47[2:0], 1'h0};
  assign _GEN_51 = _GEN_49 == 4'h0 & ~_slots_21_io_valid ? 4'h1 : _GEN_49[3] | _slots_21_io_valid ? _GEN_49 : {_GEN_49[2:0], 1'h0};
  assign _GEN_53 = _GEN_51 == 4'h0 & ~_slots_22_io_valid ? 4'h1 : _GEN_51[3] | _slots_22_io_valid ? _GEN_51 : {_GEN_51[2:0], 1'h0};
  assign _GEN_55 = _GEN_53 == 4'h0 & ~_slots_23_io_valid ? 4'h1 : _GEN_53[3] | _slots_23_io_valid ? _GEN_53 : {_GEN_53[2:0], 1'h0};
  assign _GEN_57 = _GEN_55 == 4'h0 & ~_slots_24_io_valid ? 4'h1 : _GEN_55[3] | _slots_24_io_valid ? _GEN_55 : {_GEN_55[2:0], 1'h0};
  assign _GEN_59 = _GEN_57 == 4'h0 & ~_slots_25_io_valid ? 4'h1 : _GEN_57[3] | _slots_25_io_valid ? _GEN_57 : {_GEN_57[2:0], 1'h0};
  assign _GEN_61 = _GEN_59 == 4'h0 & ~_slots_26_io_valid ? 4'h1 : _GEN_59[3] | _slots_26_io_valid ? _GEN_59 : {_GEN_59[2:0], 1'h0};
  assign _GEN_63 = _GEN_61 == 4'h0 & ~_slots_27_io_valid ? 4'h1 : _GEN_61[3] | _slots_27_io_valid ? _GEN_61 : {_GEN_61[2:0], 1'h0};
  assign _GEN_65 = _GEN_63 == 4'h0 & ~_slots_28_io_valid ? 4'h1 : _GEN_63[3] | _slots_28_io_valid ? _GEN_63 : {_GEN_63[2:0], 1'h0};
  assign _GEN_67 = _GEN_65 == 4'h0 & ~_slots_29_io_valid ? 4'h1 : _GEN_65[3] | _slots_29_io_valid ? _GEN_65 : {_GEN_65[2:0], 1'h0};
  assign _GEN_69 = _GEN_67 == 4'h0 & ~_slots_30_io_valid ? 4'h1 : _GEN_67[3] | _slots_30_io_valid ? _GEN_67 : {_GEN_67[2:0], 1'h0};
  wire [3:0]  _GEN_71_0 = _GEN_69 == 4'h0 & ~_slots_31_io_valid ? 4'h1 : _GEN_69[3] | _slots_31_io_valid ? _GEN_69 : {_GEN_69[2:0], 1'h0};
  wire [3:0]  _GEN_73_0 = _GEN_71_0 == 4'h0 & ~io_dis_uops_0_valid ? 4'h1 : _GEN_71_0[3] | io_dis_uops_0_valid ? _GEN_71_0 : {_GEN_71_0[2:0], 1'h0};
  wire [3:0]  _GEN_75_0 = _GEN_73_0 == 4'h0 & ~io_dis_uops_1_valid ? 4'h1 : _GEN_73_0[3] | io_dis_uops_1_valid ? _GEN_73_0 : {_GEN_73_0[2:0], 1'h0};
  wire        will_be_valid_32 = io_dis_uops_0_valid & ~io_dis_uops_0_bits_exception & ~io_dis_uops_0_bits_is_fence & ~io_dis_uops_0_bits_is_fencei;
  wire        will_be_valid_33 = io_dis_uops_1_valid & ~io_dis_uops_1_bits_exception & ~io_dis_uops_1_bits_is_fence & ~io_dis_uops_1_bits_is_fencei;
  wire        will_be_valid_34 = io_dis_uops_2_valid & ~io_dis_uops_2_bits_exception & ~io_dis_uops_2_bits_is_fence & ~io_dis_uops_2_bits_is_fencei;
  wire        _GEN_184 = _GEN_11_1to0 == 2'h2;
  wire        _GEN_185 = _GEN_13 == 4'h4;
  wire        _GEN_186 = _GEN_15 == 4'h8;
  wire        issue_slots_0_in_uop_valid = _GEN_186 ? _slots_4_io_will_be_valid : _GEN_185 ? _slots_3_io_will_be_valid : _GEN_184 ? _slots_2_io_will_be_valid : ~_slots_0_io_valid & _slots_1_io_will_be_valid;
  wire        _GEN_187 = _GEN_13 == 4'h2;
  wire        _GEN_188 = _GEN_15 == 4'h4;
  wire        _GEN_189 = _GEN_17 == 4'h8;
  wire        issue_slots_1_in_uop_valid = _GEN_189 ? _slots_5_io_will_be_valid : _GEN_188 ? _slots_4_io_will_be_valid : _GEN_187 ? _slots_3_io_will_be_valid : _GEN_11_1to0 == 2'h1 & _slots_2_io_will_be_valid;
  wire        _GEN_190 = _GEN_15 == 4'h2;
  wire        _GEN_191 = _GEN_17 == 4'h4;
  wire        _GEN_192 = _GEN_19 == 4'h8;
  wire        issue_slots_2_in_uop_valid = _GEN_192 ? _slots_6_io_will_be_valid : _GEN_191 ? _slots_5_io_will_be_valid : _GEN_190 ? _slots_4_io_will_be_valid : _GEN_13 == 4'h1 & _slots_3_io_will_be_valid;
  wire        _GEN_193 = _GEN_17 == 4'h2;
  wire        _GEN_194 = _GEN_19 == 4'h4;
  wire        _GEN_195 = _GEN_21 == 4'h8;
  wire        issue_slots_3_in_uop_valid = _GEN_195 ? _slots_7_io_will_be_valid : _GEN_194 ? _slots_6_io_will_be_valid : _GEN_193 ? _slots_5_io_will_be_valid : _GEN_15 == 4'h1 & _slots_4_io_will_be_valid;
  wire        _GEN_196 = _GEN_19 == 4'h2;
  wire        _GEN_197 = _GEN_21 == 4'h4;
  wire        _GEN_198 = _GEN_23 == 4'h8;
  wire        issue_slots_4_in_uop_valid = _GEN_198 ? _slots_8_io_will_be_valid : _GEN_197 ? _slots_7_io_will_be_valid : _GEN_196 ? _slots_6_io_will_be_valid : _GEN_17 == 4'h1 & _slots_5_io_will_be_valid;
  wire        _GEN_199 = _GEN_21 == 4'h2;
  wire        _GEN_200 = _GEN_23 == 4'h4;
  wire        _GEN_201 = _GEN_25 == 4'h8;
  wire        issue_slots_5_in_uop_valid = _GEN_201 ? _slots_9_io_will_be_valid : _GEN_200 ? _slots_8_io_will_be_valid : _GEN_199 ? _slots_7_io_will_be_valid : _GEN_19 == 4'h1 & _slots_6_io_will_be_valid;
  wire        _GEN_202 = _GEN_23 == 4'h2;
  wire        _GEN_203 = _GEN_25 == 4'h4;
  wire        _GEN_204 = _GEN_27 == 4'h8;
  wire        issue_slots_6_in_uop_valid = _GEN_204 ? _slots_10_io_will_be_valid : _GEN_203 ? _slots_9_io_will_be_valid : _GEN_202 ? _slots_8_io_will_be_valid : _GEN_21 == 4'h1 & _slots_7_io_will_be_valid;
  wire        _GEN_205 = _GEN_25 == 4'h2;
  wire        _GEN_206 = _GEN_27 == 4'h4;
  wire        _GEN_207 = _GEN_29 == 4'h8;
  wire        issue_slots_7_in_uop_valid = _GEN_207 ? _slots_11_io_will_be_valid : _GEN_206 ? _slots_10_io_will_be_valid : _GEN_205 ? _slots_9_io_will_be_valid : _GEN_23 == 4'h1 & _slots_8_io_will_be_valid;
  wire        _GEN_208 = _GEN_27 == 4'h2;
  wire        _GEN_209 = _GEN_29 == 4'h4;
  wire        _GEN_210 = _GEN_31 == 4'h8;
  wire        issue_slots_8_in_uop_valid = _GEN_210 ? _slots_12_io_will_be_valid : _GEN_209 ? _slots_11_io_will_be_valid : _GEN_208 ? _slots_10_io_will_be_valid : _GEN_25 == 4'h1 & _slots_9_io_will_be_valid;
  wire        _GEN_211 = _GEN_29 == 4'h2;
  wire        _GEN_212 = _GEN_31 == 4'h4;
  wire        _GEN_213 = _GEN_33 == 4'h8;
  wire        issue_slots_9_in_uop_valid = _GEN_213 ? _slots_13_io_will_be_valid : _GEN_212 ? _slots_12_io_will_be_valid : _GEN_211 ? _slots_11_io_will_be_valid : _GEN_27 == 4'h1 & _slots_10_io_will_be_valid;
  wire        _GEN_214 = _GEN_31 == 4'h2;
  wire        _GEN_215 = _GEN_33 == 4'h4;
  wire        _GEN_216 = _GEN_35 == 4'h8;
  wire        issue_slots_10_in_uop_valid = _GEN_216 ? _slots_14_io_will_be_valid : _GEN_215 ? _slots_13_io_will_be_valid : _GEN_214 ? _slots_12_io_will_be_valid : _GEN_29 == 4'h1 & _slots_11_io_will_be_valid;
  wire        _GEN_217 = _GEN_33 == 4'h2;
  wire        _GEN_218 = _GEN_35 == 4'h4;
  wire        _GEN_219 = _GEN_37 == 4'h8;
  wire        issue_slots_11_in_uop_valid = _GEN_219 ? _slots_15_io_will_be_valid : _GEN_218 ? _slots_14_io_will_be_valid : _GEN_217 ? _slots_13_io_will_be_valid : _GEN_31 == 4'h1 & _slots_12_io_will_be_valid;
  wire        _GEN_220 = _GEN_35 == 4'h2;
  wire        _GEN_221 = _GEN_37 == 4'h4;
  wire        _GEN_222 = _GEN_39 == 4'h8;
  wire        issue_slots_12_in_uop_valid = _GEN_222 ? _slots_16_io_will_be_valid : _GEN_221 ? _slots_15_io_will_be_valid : _GEN_220 ? _slots_14_io_will_be_valid : _GEN_33 == 4'h1 & _slots_13_io_will_be_valid;
  wire        _GEN_223 = _GEN_37 == 4'h2;
  wire        _GEN_224 = _GEN_39 == 4'h4;
  wire        _GEN_225 = _GEN_41 == 4'h8;
  wire        issue_slots_13_in_uop_valid = _GEN_225 ? _slots_17_io_will_be_valid : _GEN_224 ? _slots_16_io_will_be_valid : _GEN_223 ? _slots_15_io_will_be_valid : _GEN_35 == 4'h1 & _slots_14_io_will_be_valid;
  wire        _GEN_226 = _GEN_39 == 4'h2;
  wire        _GEN_227 = _GEN_41 == 4'h4;
  wire        _GEN_228 = _GEN_43 == 4'h8;
  wire        issue_slots_14_in_uop_valid = _GEN_228 ? _slots_18_io_will_be_valid : _GEN_227 ? _slots_17_io_will_be_valid : _GEN_226 ? _slots_16_io_will_be_valid : _GEN_37 == 4'h1 & _slots_15_io_will_be_valid;
  wire        _GEN_229 = _GEN_41 == 4'h2;
  wire        _GEN_230 = _GEN_43 == 4'h4;
  wire        _GEN_231 = _GEN_45 == 4'h8;
  wire        issue_slots_15_in_uop_valid = _GEN_231 ? _slots_19_io_will_be_valid : _GEN_230 ? _slots_18_io_will_be_valid : _GEN_229 ? _slots_17_io_will_be_valid : _GEN_39 == 4'h1 & _slots_16_io_will_be_valid;
  wire        _GEN_232 = _GEN_43 == 4'h2;
  wire        _GEN_233 = _GEN_45 == 4'h4;
  wire        _GEN_234 = _GEN_47 == 4'h8;
  wire        issue_slots_16_in_uop_valid = _GEN_234 ? _slots_20_io_will_be_valid : _GEN_233 ? _slots_19_io_will_be_valid : _GEN_232 ? _slots_18_io_will_be_valid : _GEN_41 == 4'h1 & _slots_17_io_will_be_valid;
  wire        _GEN_235 = _GEN_45 == 4'h2;
  wire        _GEN_236 = _GEN_47 == 4'h4;
  wire        _GEN_237 = _GEN_49 == 4'h8;
  wire        issue_slots_17_in_uop_valid = _GEN_237 ? _slots_21_io_will_be_valid : _GEN_236 ? _slots_20_io_will_be_valid : _GEN_235 ? _slots_19_io_will_be_valid : _GEN_43 == 4'h1 & _slots_18_io_will_be_valid;
  wire        _GEN_238 = _GEN_47 == 4'h2;
  wire        _GEN_239 = _GEN_49 == 4'h4;
  wire        _GEN_240 = _GEN_51 == 4'h8;
  wire        issue_slots_18_in_uop_valid = _GEN_240 ? _slots_22_io_will_be_valid : _GEN_239 ? _slots_21_io_will_be_valid : _GEN_238 ? _slots_20_io_will_be_valid : _GEN_45 == 4'h1 & _slots_19_io_will_be_valid;
  wire        _GEN_241 = _GEN_49 == 4'h2;
  wire        _GEN_242 = _GEN_51 == 4'h4;
  wire        _GEN_243 = _GEN_53 == 4'h8;
  wire        issue_slots_19_in_uop_valid = _GEN_243 ? _slots_23_io_will_be_valid : _GEN_242 ? _slots_22_io_will_be_valid : _GEN_241 ? _slots_21_io_will_be_valid : _GEN_47 == 4'h1 & _slots_20_io_will_be_valid;
  wire        _GEN_244 = _GEN_51 == 4'h2;
  wire        _GEN_245 = _GEN_53 == 4'h4;
  wire        _GEN_246 = _GEN_55 == 4'h8;
  wire        issue_slots_20_in_uop_valid = _GEN_246 ? _slots_24_io_will_be_valid : _GEN_245 ? _slots_23_io_will_be_valid : _GEN_244 ? _slots_22_io_will_be_valid : _GEN_49 == 4'h1 & _slots_21_io_will_be_valid;
  wire        _GEN_247 = _GEN_53 == 4'h2;
  wire        _GEN_248 = _GEN_55 == 4'h4;
  wire        _GEN_249 = _GEN_57 == 4'h8;
  wire        issue_slots_21_in_uop_valid = _GEN_249 ? _slots_25_io_will_be_valid : _GEN_248 ? _slots_24_io_will_be_valid : _GEN_247 ? _slots_23_io_will_be_valid : _GEN_51 == 4'h1 & _slots_22_io_will_be_valid;
  wire        _GEN_250 = _GEN_55 == 4'h2;
  wire        _GEN_251 = _GEN_57 == 4'h4;
  wire        _GEN_252 = _GEN_59 == 4'h8;
  wire        issue_slots_22_in_uop_valid = _GEN_252 ? _slots_26_io_will_be_valid : _GEN_251 ? _slots_25_io_will_be_valid : _GEN_250 ? _slots_24_io_will_be_valid : _GEN_53 == 4'h1 & _slots_23_io_will_be_valid;
  wire        _GEN_253 = _GEN_57 == 4'h2;
  wire        _GEN_254 = _GEN_59 == 4'h4;
  wire        _GEN_255 = _GEN_61 == 4'h8;
  wire        issue_slots_23_in_uop_valid = _GEN_255 ? _slots_27_io_will_be_valid : _GEN_254 ? _slots_26_io_will_be_valid : _GEN_253 ? _slots_25_io_will_be_valid : _GEN_55 == 4'h1 & _slots_24_io_will_be_valid;
  wire        _GEN_256 = _GEN_59 == 4'h2;
  wire        _GEN_257 = _GEN_61 == 4'h4;
  wire        _GEN_258 = _GEN_63 == 4'h8;
  wire        issue_slots_24_in_uop_valid = _GEN_258 ? _slots_28_io_will_be_valid : _GEN_257 ? _slots_27_io_will_be_valid : _GEN_256 ? _slots_26_io_will_be_valid : _GEN_57 == 4'h1 & _slots_25_io_will_be_valid;
  wire        _GEN_259 = _GEN_61 == 4'h2;
  wire        _GEN_260 = _GEN_63 == 4'h4;
  wire        _GEN_261 = _GEN_65 == 4'h8;
  wire        issue_slots_25_in_uop_valid = _GEN_261 ? _slots_29_io_will_be_valid : _GEN_260 ? _slots_28_io_will_be_valid : _GEN_259 ? _slots_27_io_will_be_valid : _GEN_59 == 4'h1 & _slots_26_io_will_be_valid;
  wire        _GEN_262 = _GEN_63 == 4'h2;
  wire        _GEN_263 = _GEN_65 == 4'h4;
  wire        _GEN_264 = _GEN_67 == 4'h8;
  wire        issue_slots_26_in_uop_valid = _GEN_264 ? _slots_30_io_will_be_valid : _GEN_263 ? _slots_29_io_will_be_valid : _GEN_262 ? _slots_28_io_will_be_valid : _GEN_61 == 4'h1 & _slots_27_io_will_be_valid;
  wire        _GEN_265 = _GEN_65 == 4'h2;
  wire        _GEN_266 = _GEN_67 == 4'h4;
  wire        _GEN_267 = _GEN_69 == 4'h8;
  wire        issue_slots_27_in_uop_valid = _GEN_267 ? _slots_31_io_will_be_valid : _GEN_266 ? _slots_30_io_will_be_valid : _GEN_265 ? _slots_29_io_will_be_valid : _GEN_63 == 4'h1 & _slots_28_io_will_be_valid;
  wire        _GEN_268 = _GEN_67 == 4'h2;
  wire        _GEN_269 = _GEN_69 == 4'h4;
  wire        _GEN_270 = _GEN_71_0 == 4'h8;
  wire        issue_slots_28_in_uop_valid = _GEN_270 ? will_be_valid_32 : _GEN_269 ? _slots_31_io_will_be_valid : _GEN_268 ? _slots_30_io_will_be_valid : _GEN_65 == 4'h1 & _slots_29_io_will_be_valid;
  wire        _GEN_271 = _GEN_69 == 4'h2;
  wire        _GEN_272 = _GEN_71_0 == 4'h4;
  wire        _GEN_273 = _GEN_73_0 == 4'h8;
  wire        issue_slots_29_in_uop_valid = _GEN_273 ? will_be_valid_33 : _GEN_272 ? will_be_valid_32 : _GEN_271 ? _slots_31_io_will_be_valid : _GEN_67 == 4'h1 & _slots_30_io_will_be_valid;
  wire        _GEN_274 = _GEN_273 | _GEN_272;
  wire        _GEN_275 = _GEN_71_0 == 4'h2;
  wire        _GEN_276 = _GEN_73_0 == 4'h4;
  wire        _GEN_277 = _GEN_75_0 == 4'h8;
  wire        issue_slots_30_in_uop_valid = _GEN_277 ? will_be_valid_34 : _GEN_276 ? will_be_valid_33 : _GEN_275 ? will_be_valid_32 : _GEN_69 == 4'h1 & _slots_31_io_will_be_valid;
  wire        _GEN_278 = _GEN_277 | _GEN_276 | _GEN_275;
  wire        _GEN_279 = _GEN_73_0 == 4'h2;
  wire        _GEN_280 = _GEN_75_0 == 4'h4;
  wire        _GEN_281 = (_GEN_75_0 == 4'h0 & ~io_dis_uops_2_valid ? 4'h1 : _GEN_75_0[3] | io_dis_uops_2_valid ? _GEN_75_0 : {_GEN_75_0[2:0], 1'h0}) == 4'h8;
  wire        issue_slots_31_in_uop_valid = _GEN_281 ? io_dis_uops_3_valid & ~io_dis_uops_3_bits_exception & ~io_dis_uops_3_bits_is_fence & ~io_dis_uops_3_bits_is_fencei : _GEN_280 ? will_be_valid_34 : _GEN_279 ? will_be_valid_33 : _GEN_71_0 == 4'h1 & will_be_valid_32;
  reg         io_dis_uops_0_ready_REG;
  reg         io_dis_uops_1_ready_REG;
  reg         io_dis_uops_2_ready_REG;
  reg         io_dis_uops_3_ready_REG;
  wire [5:0]  num_available =
    {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, ~_slots_0_io_will_be_valid & ~issue_slots_0_in_uop_valid} + {1'h0, (~_slots_1_io_will_be_valid | ~_slots_0_io_valid) & ~issue_slots_1_in_uop_valid}} + {1'h0, {1'h0, (~_slots_2_io_will_be_valid | (|_GEN_11_1to0)) & ~issue_slots_2_in_uop_valid} + {1'h0, (~_slots_3_io_will_be_valid | (|_GEN_13)) & ~issue_slots_3_in_uop_valid}}} + {1'h0, {1'h0, {1'h0, (~_slots_4_io_will_be_valid | (|_GEN_15)) & ~issue_slots_4_in_uop_valid} + {1'h0, (~_slots_5_io_will_be_valid | (|_GEN_17)) & ~issue_slots_5_in_uop_valid}} + {1'h0, {1'h0, (~_slots_6_io_will_be_valid | (|_GEN_19)) & ~issue_slots_6_in_uop_valid} + {1'h0, (~_slots_7_io_will_be_valid | (|_GEN_21)) & ~issue_slots_7_in_uop_valid}}}} + {1'h0, {1'h0, {1'h0, {1'h0, (~_slots_8_io_will_be_valid | (|_GEN_23)) & ~issue_slots_8_in_uop_valid} + {1'h0, (~_slots_9_io_will_be_valid | (|_GEN_25)) & ~issue_slots_9_in_uop_valid}} + {1'h0, {1'h0, (~_slots_10_io_will_be_valid | (|_GEN_27)) & ~issue_slots_10_in_uop_valid} + {1'h0, (~_slots_11_io_will_be_valid | (|_GEN_29)) & ~issue_slots_11_in_uop_valid}}} + {1'h0, {1'h0, {1'h0, (~_slots_12_io_will_be_valid | (|_GEN_31)) & ~issue_slots_12_in_uop_valid} + {1'h0, (~_slots_13_io_will_be_valid | (|_GEN_33)) & ~issue_slots_13_in_uop_valid}} + {1'h0, {1'h0, (~_slots_14_io_will_be_valid | (|_GEN_35)) & ~issue_slots_14_in_uop_valid} + {1'h0, (~_slots_15_io_will_be_valid | (|_GEN_37)) & ~issue_slots_15_in_uop_valid}}}}}
    + {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, (~_slots_16_io_will_be_valid | (|_GEN_39)) & ~issue_slots_16_in_uop_valid} + {1'h0, (~_slots_17_io_will_be_valid | (|_GEN_41)) & ~issue_slots_17_in_uop_valid}} + {1'h0, {1'h0, (~_slots_18_io_will_be_valid | (|_GEN_43)) & ~issue_slots_18_in_uop_valid} + {1'h0, (~_slots_19_io_will_be_valid | (|_GEN_45)) & ~issue_slots_19_in_uop_valid}}} + {1'h0, {1'h0, {1'h0, (~_slots_20_io_will_be_valid | (|_GEN_47)) & ~issue_slots_20_in_uop_valid} + {1'h0, (~_slots_21_io_will_be_valid | (|_GEN_49)) & ~issue_slots_21_in_uop_valid}} + {1'h0, {1'h0, (~_slots_22_io_will_be_valid | (|_GEN_51)) & ~issue_slots_22_in_uop_valid} + {1'h0, (~_slots_23_io_will_be_valid | (|_GEN_53)) & ~issue_slots_23_in_uop_valid}}}} + {1'h0, {1'h0, {1'h0, {1'h0, (~_slots_24_io_will_be_valid | (|_GEN_55)) & ~issue_slots_24_in_uop_valid} + {1'h0, (~_slots_25_io_will_be_valid | (|_GEN_57)) & ~issue_slots_25_in_uop_valid}} + {1'h0, {1'h0, (~_slots_26_io_will_be_valid | (|_GEN_59)) & ~issue_slots_26_in_uop_valid} + {1'h0, (~_slots_27_io_will_be_valid | (|_GEN_61)) & ~issue_slots_27_in_uop_valid}}} + {1'h0, {1'h0, {1'h0, (~_slots_28_io_will_be_valid | (|_GEN_63)) & ~issue_slots_28_in_uop_valid} + {1'h0, (~_slots_29_io_will_be_valid | (|_GEN_65)) & ~issue_slots_29_in_uop_valid}} + {1'h0, {1'h0, (~_slots_30_io_will_be_valid | (|_GEN_67)) & ~issue_slots_30_in_uop_valid} + {1'h0, (~_slots_31_io_will_be_valid | (|_GEN_69)) & ~issue_slots_31_in_uop_valid}}}}};
  always @(posedge clock) begin
    io_dis_uops_0_ready_REG <= |num_available;
    io_dis_uops_1_ready_REG <= |(num_available[5:1]);
    io_dis_uops_2_ready_REG <= num_available > 6'h2;
    io_dis_uops_3_ready_REG <= |(num_available[5:2]);
  end // always @(posedge)
  IssueSlot slots_0 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_0_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (1'h0),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_0_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_186 ? _slots_4_io_out_uop_uopc : _GEN_185 ? _slots_3_io_out_uop_uopc : _GEN_184 ? _slots_2_io_out_uop_uopc : _slots_1_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_186 ? _slots_4_io_out_uop_fu_code : _GEN_185 ? _slots_3_io_out_uop_fu_code : _GEN_184 ? _slots_2_io_out_uop_fu_code : _slots_1_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_186 ? _slots_4_io_out_uop_iw_state : _GEN_185 ? _slots_3_io_out_uop_iw_state : _GEN_184 ? _slots_2_io_out_uop_iw_state : _slots_1_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_186 ? _slots_4_io_out_uop_br_mask : _GEN_185 ? _slots_3_io_out_uop_br_mask : _GEN_184 ? _slots_2_io_out_uop_br_mask : _slots_1_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_186 ? _slots_4_io_out_uop_imm_packed : _GEN_185 ? _slots_3_io_out_uop_imm_packed : _GEN_184 ? _slots_2_io_out_uop_imm_packed : _slots_1_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_186 ? _slots_4_io_out_uop_rob_idx : _GEN_185 ? _slots_3_io_out_uop_rob_idx : _GEN_184 ? _slots_2_io_out_uop_rob_idx : _slots_1_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_186 ? _slots_4_io_out_uop_stq_idx : _GEN_185 ? _slots_3_io_out_uop_stq_idx : _GEN_184 ? _slots_2_io_out_uop_stq_idx : _slots_1_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_186 ? _slots_4_io_out_uop_pdst : _GEN_185 ? _slots_3_io_out_uop_pdst : _GEN_184 ? _slots_2_io_out_uop_pdst : _slots_1_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_186 ? _slots_4_io_out_uop_prs1 : _GEN_185 ? _slots_3_io_out_uop_prs1 : _GEN_184 ? _slots_2_io_out_uop_prs1 : _slots_1_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_186 ? _slots_4_io_out_uop_prs2 : _GEN_185 ? _slots_3_io_out_uop_prs2 : _GEN_184 ? _slots_2_io_out_uop_prs2 : _slots_1_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_186 ? _slots_4_io_out_uop_prs3 : _GEN_185 ? _slots_3_io_out_uop_prs3 : _GEN_184 ? _slots_2_io_out_uop_prs3 : _slots_1_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_186 ? _slots_4_io_out_uop_prs1_busy : _GEN_185 ? _slots_3_io_out_uop_prs1_busy : _GEN_184 ? _slots_2_io_out_uop_prs1_busy : _slots_1_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_186 ? _slots_4_io_out_uop_prs2_busy : _GEN_185 ? _slots_3_io_out_uop_prs2_busy : _GEN_184 ? _slots_2_io_out_uop_prs2_busy : _slots_1_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_186 ? _slots_4_io_out_uop_prs3_busy : _GEN_185 ? _slots_3_io_out_uop_prs3_busy : _GEN_184 ? _slots_2_io_out_uop_prs3_busy : _slots_1_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_186 ? _slots_4_io_out_uop_ppred_busy : _GEN_185 ? _slots_3_io_out_uop_ppred_busy : _GEN_184 ? _slots_2_io_out_uop_ppred_busy : _slots_1_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_186 ? _slots_4_io_out_uop_mem_cmd : _GEN_185 ? _slots_3_io_out_uop_mem_cmd : _GEN_184 ? _slots_2_io_out_uop_mem_cmd : _slots_1_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_186 ? _slots_4_io_out_uop_is_amo : _GEN_185 ? _slots_3_io_out_uop_is_amo : _GEN_184 ? _slots_2_io_out_uop_is_amo : _slots_1_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_186 ? _slots_4_io_out_uop_uses_ldq : _GEN_185 ? _slots_3_io_out_uop_uses_ldq : _GEN_184 ? _slots_2_io_out_uop_uses_ldq : _slots_1_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_186 ? _slots_4_io_out_uop_uses_stq : _GEN_185 ? _slots_3_io_out_uop_uses_stq : _GEN_184 ? _slots_2_io_out_uop_uses_stq : _slots_1_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_186 ? _slots_4_io_out_uop_dst_rtype : _GEN_185 ? _slots_3_io_out_uop_dst_rtype : _GEN_184 ? _slots_2_io_out_uop_dst_rtype : _slots_1_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_186 ? _slots_4_io_out_uop_fp_val : _GEN_185 ? _slots_3_io_out_uop_fp_val : _GEN_184 ? _slots_2_io_out_uop_fp_val : _slots_1_io_out_uop_fp_val),
    .io_valid                       (_slots_0_io_valid),
    .io_will_be_valid               (_slots_0_io_will_be_valid),
    .io_request                     (_slots_0_io_request),
    .io_out_uop_uopc                (/* unused */),
    .io_out_uop_fu_code             (/* unused */),
    .io_out_uop_iw_state            (/* unused */),
    .io_out_uop_br_mask             (/* unused */),
    .io_out_uop_imm_packed          (/* unused */),
    .io_out_uop_rob_idx             (/* unused */),
    .io_out_uop_stq_idx             (/* unused */),
    .io_out_uop_pdst                (/* unused */),
    .io_out_uop_prs1                (/* unused */),
    .io_out_uop_prs2                (/* unused */),
    .io_out_uop_prs3                (/* unused */),
    .io_out_uop_prs1_busy           (/* unused */),
    .io_out_uop_prs2_busy           (/* unused */),
    .io_out_uop_prs3_busy           (/* unused */),
    .io_out_uop_ppred_busy          (/* unused */),
    .io_out_uop_mem_cmd             (/* unused */),
    .io_out_uop_is_amo              (/* unused */),
    .io_out_uop_uses_ldq            (/* unused */),
    .io_out_uop_uses_stq            (/* unused */),
    .io_out_uop_dst_rtype           (/* unused */),
    .io_out_uop_fp_val              (/* unused */),
    .io_uop_uopc                    (_slots_0_io_uop_uopc),
    .io_uop_fu_code                 (_slots_0_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_0_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_0_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_0_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_0_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_0_io_uop_pdst),
    .io_uop_prs1                    (_slots_0_io_uop_prs1),
    .io_uop_prs2                    (_slots_0_io_uop_prs2),
    .io_uop_prs3                    (_slots_0_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_0_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_0_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_0_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_0_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_0_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_0_io_uop_fp_val)
  );
  IssueSlot slots_1 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_1_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (~_slots_0_io_valid),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_1_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_189 ? _slots_5_io_out_uop_uopc : _GEN_188 ? _slots_4_io_out_uop_uopc : _GEN_187 ? _slots_3_io_out_uop_uopc : _slots_2_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_189 ? _slots_5_io_out_uop_fu_code : _GEN_188 ? _slots_4_io_out_uop_fu_code : _GEN_187 ? _slots_3_io_out_uop_fu_code : _slots_2_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_189 ? _slots_5_io_out_uop_iw_state : _GEN_188 ? _slots_4_io_out_uop_iw_state : _GEN_187 ? _slots_3_io_out_uop_iw_state : _slots_2_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_189 ? _slots_5_io_out_uop_br_mask : _GEN_188 ? _slots_4_io_out_uop_br_mask : _GEN_187 ? _slots_3_io_out_uop_br_mask : _slots_2_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_189 ? _slots_5_io_out_uop_imm_packed : _GEN_188 ? _slots_4_io_out_uop_imm_packed : _GEN_187 ? _slots_3_io_out_uop_imm_packed : _slots_2_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_189 ? _slots_5_io_out_uop_rob_idx : _GEN_188 ? _slots_4_io_out_uop_rob_idx : _GEN_187 ? _slots_3_io_out_uop_rob_idx : _slots_2_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_189 ? _slots_5_io_out_uop_stq_idx : _GEN_188 ? _slots_4_io_out_uop_stq_idx : _GEN_187 ? _slots_3_io_out_uop_stq_idx : _slots_2_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_189 ? _slots_5_io_out_uop_pdst : _GEN_188 ? _slots_4_io_out_uop_pdst : _GEN_187 ? _slots_3_io_out_uop_pdst : _slots_2_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_189 ? _slots_5_io_out_uop_prs1 : _GEN_188 ? _slots_4_io_out_uop_prs1 : _GEN_187 ? _slots_3_io_out_uop_prs1 : _slots_2_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_189 ? _slots_5_io_out_uop_prs2 : _GEN_188 ? _slots_4_io_out_uop_prs2 : _GEN_187 ? _slots_3_io_out_uop_prs2 : _slots_2_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_189 ? _slots_5_io_out_uop_prs3 : _GEN_188 ? _slots_4_io_out_uop_prs3 : _GEN_187 ? _slots_3_io_out_uop_prs3 : _slots_2_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_189 ? _slots_5_io_out_uop_prs1_busy : _GEN_188 ? _slots_4_io_out_uop_prs1_busy : _GEN_187 ? _slots_3_io_out_uop_prs1_busy : _slots_2_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_189 ? _slots_5_io_out_uop_prs2_busy : _GEN_188 ? _slots_4_io_out_uop_prs2_busy : _GEN_187 ? _slots_3_io_out_uop_prs2_busy : _slots_2_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_189 ? _slots_5_io_out_uop_prs3_busy : _GEN_188 ? _slots_4_io_out_uop_prs3_busy : _GEN_187 ? _slots_3_io_out_uop_prs3_busy : _slots_2_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_189 ? _slots_5_io_out_uop_ppred_busy : _GEN_188 ? _slots_4_io_out_uop_ppred_busy : _GEN_187 ? _slots_3_io_out_uop_ppred_busy : _slots_2_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_189 ? _slots_5_io_out_uop_mem_cmd : _GEN_188 ? _slots_4_io_out_uop_mem_cmd : _GEN_187 ? _slots_3_io_out_uop_mem_cmd : _slots_2_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_189 ? _slots_5_io_out_uop_is_amo : _GEN_188 ? _slots_4_io_out_uop_is_amo : _GEN_187 ? _slots_3_io_out_uop_is_amo : _slots_2_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_189 ? _slots_5_io_out_uop_uses_ldq : _GEN_188 ? _slots_4_io_out_uop_uses_ldq : _GEN_187 ? _slots_3_io_out_uop_uses_ldq : _slots_2_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_189 ? _slots_5_io_out_uop_uses_stq : _GEN_188 ? _slots_4_io_out_uop_uses_stq : _GEN_187 ? _slots_3_io_out_uop_uses_stq : _slots_2_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_189 ? _slots_5_io_out_uop_dst_rtype : _GEN_188 ? _slots_4_io_out_uop_dst_rtype : _GEN_187 ? _slots_3_io_out_uop_dst_rtype : _slots_2_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_189 ? _slots_5_io_out_uop_fp_val : _GEN_188 ? _slots_4_io_out_uop_fp_val : _GEN_187 ? _slots_3_io_out_uop_fp_val : _slots_2_io_out_uop_fp_val),
    .io_valid                       (_slots_1_io_valid),
    .io_will_be_valid               (_slots_1_io_will_be_valid),
    .io_request                     (_slots_1_io_request),
    .io_out_uop_uopc                (_slots_1_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_1_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_1_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_1_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_1_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_1_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_1_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_1_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_1_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_1_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_1_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_1_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_1_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_1_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_1_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_1_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_1_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_1_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_1_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_1_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_1_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_1_io_uop_uopc),
    .io_uop_fu_code                 (_slots_1_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_1_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_1_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_1_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_1_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_1_io_uop_pdst),
    .io_uop_prs1                    (_slots_1_io_uop_prs1),
    .io_uop_prs2                    (_slots_1_io_uop_prs2),
    .io_uop_prs3                    (_slots_1_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_1_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_1_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_1_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_1_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_1_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_1_io_uop_fp_val)
  );
  IssueSlot slots_2 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_2_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_11_1to0),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_2_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_192 ? _slots_6_io_out_uop_uopc : _GEN_191 ? _slots_5_io_out_uop_uopc : _GEN_190 ? _slots_4_io_out_uop_uopc : _slots_3_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_192 ? _slots_6_io_out_uop_fu_code : _GEN_191 ? _slots_5_io_out_uop_fu_code : _GEN_190 ? _slots_4_io_out_uop_fu_code : _slots_3_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_192 ? _slots_6_io_out_uop_iw_state : _GEN_191 ? _slots_5_io_out_uop_iw_state : _GEN_190 ? _slots_4_io_out_uop_iw_state : _slots_3_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_192 ? _slots_6_io_out_uop_br_mask : _GEN_191 ? _slots_5_io_out_uop_br_mask : _GEN_190 ? _slots_4_io_out_uop_br_mask : _slots_3_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_192 ? _slots_6_io_out_uop_imm_packed : _GEN_191 ? _slots_5_io_out_uop_imm_packed : _GEN_190 ? _slots_4_io_out_uop_imm_packed : _slots_3_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_192 ? _slots_6_io_out_uop_rob_idx : _GEN_191 ? _slots_5_io_out_uop_rob_idx : _GEN_190 ? _slots_4_io_out_uop_rob_idx : _slots_3_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_192 ? _slots_6_io_out_uop_stq_idx : _GEN_191 ? _slots_5_io_out_uop_stq_idx : _GEN_190 ? _slots_4_io_out_uop_stq_idx : _slots_3_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_192 ? _slots_6_io_out_uop_pdst : _GEN_191 ? _slots_5_io_out_uop_pdst : _GEN_190 ? _slots_4_io_out_uop_pdst : _slots_3_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_192 ? _slots_6_io_out_uop_prs1 : _GEN_191 ? _slots_5_io_out_uop_prs1 : _GEN_190 ? _slots_4_io_out_uop_prs1 : _slots_3_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_192 ? _slots_6_io_out_uop_prs2 : _GEN_191 ? _slots_5_io_out_uop_prs2 : _GEN_190 ? _slots_4_io_out_uop_prs2 : _slots_3_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_192 ? _slots_6_io_out_uop_prs3 : _GEN_191 ? _slots_5_io_out_uop_prs3 : _GEN_190 ? _slots_4_io_out_uop_prs3 : _slots_3_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_192 ? _slots_6_io_out_uop_prs1_busy : _GEN_191 ? _slots_5_io_out_uop_prs1_busy : _GEN_190 ? _slots_4_io_out_uop_prs1_busy : _slots_3_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_192 ? _slots_6_io_out_uop_prs2_busy : _GEN_191 ? _slots_5_io_out_uop_prs2_busy : _GEN_190 ? _slots_4_io_out_uop_prs2_busy : _slots_3_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_192 ? _slots_6_io_out_uop_prs3_busy : _GEN_191 ? _slots_5_io_out_uop_prs3_busy : _GEN_190 ? _slots_4_io_out_uop_prs3_busy : _slots_3_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_192 ? _slots_6_io_out_uop_ppred_busy : _GEN_191 ? _slots_5_io_out_uop_ppred_busy : _GEN_190 ? _slots_4_io_out_uop_ppred_busy : _slots_3_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_192 ? _slots_6_io_out_uop_mem_cmd : _GEN_191 ? _slots_5_io_out_uop_mem_cmd : _GEN_190 ? _slots_4_io_out_uop_mem_cmd : _slots_3_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_192 ? _slots_6_io_out_uop_is_amo : _GEN_191 ? _slots_5_io_out_uop_is_amo : _GEN_190 ? _slots_4_io_out_uop_is_amo : _slots_3_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_192 ? _slots_6_io_out_uop_uses_ldq : _GEN_191 ? _slots_5_io_out_uop_uses_ldq : _GEN_190 ? _slots_4_io_out_uop_uses_ldq : _slots_3_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_192 ? _slots_6_io_out_uop_uses_stq : _GEN_191 ? _slots_5_io_out_uop_uses_stq : _GEN_190 ? _slots_4_io_out_uop_uses_stq : _slots_3_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_192 ? _slots_6_io_out_uop_dst_rtype : _GEN_191 ? _slots_5_io_out_uop_dst_rtype : _GEN_190 ? _slots_4_io_out_uop_dst_rtype : _slots_3_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_192 ? _slots_6_io_out_uop_fp_val : _GEN_191 ? _slots_5_io_out_uop_fp_val : _GEN_190 ? _slots_4_io_out_uop_fp_val : _slots_3_io_out_uop_fp_val),
    .io_valid                       (_slots_2_io_valid),
    .io_will_be_valid               (_slots_2_io_will_be_valid),
    .io_request                     (_slots_2_io_request),
    .io_out_uop_uopc                (_slots_2_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_2_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_2_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_2_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_2_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_2_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_2_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_2_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_2_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_2_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_2_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_2_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_2_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_2_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_2_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_2_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_2_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_2_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_2_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_2_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_2_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_2_io_uop_uopc),
    .io_uop_fu_code                 (_slots_2_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_2_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_2_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_2_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_2_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_2_io_uop_pdst),
    .io_uop_prs1                    (_slots_2_io_uop_prs1),
    .io_uop_prs2                    (_slots_2_io_uop_prs2),
    .io_uop_prs3                    (_slots_2_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_2_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_2_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_2_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_2_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_2_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_2_io_uop_fp_val)
  );
  IssueSlot slots_3 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_3_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_13),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_3_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_195 ? _slots_7_io_out_uop_uopc : _GEN_194 ? _slots_6_io_out_uop_uopc : _GEN_193 ? _slots_5_io_out_uop_uopc : _slots_4_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_195 ? _slots_7_io_out_uop_fu_code : _GEN_194 ? _slots_6_io_out_uop_fu_code : _GEN_193 ? _slots_5_io_out_uop_fu_code : _slots_4_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_195 ? _slots_7_io_out_uop_iw_state : _GEN_194 ? _slots_6_io_out_uop_iw_state : _GEN_193 ? _slots_5_io_out_uop_iw_state : _slots_4_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_195 ? _slots_7_io_out_uop_br_mask : _GEN_194 ? _slots_6_io_out_uop_br_mask : _GEN_193 ? _slots_5_io_out_uop_br_mask : _slots_4_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_195 ? _slots_7_io_out_uop_imm_packed : _GEN_194 ? _slots_6_io_out_uop_imm_packed : _GEN_193 ? _slots_5_io_out_uop_imm_packed : _slots_4_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_195 ? _slots_7_io_out_uop_rob_idx : _GEN_194 ? _slots_6_io_out_uop_rob_idx : _GEN_193 ? _slots_5_io_out_uop_rob_idx : _slots_4_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_195 ? _slots_7_io_out_uop_stq_idx : _GEN_194 ? _slots_6_io_out_uop_stq_idx : _GEN_193 ? _slots_5_io_out_uop_stq_idx : _slots_4_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_195 ? _slots_7_io_out_uop_pdst : _GEN_194 ? _slots_6_io_out_uop_pdst : _GEN_193 ? _slots_5_io_out_uop_pdst : _slots_4_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_195 ? _slots_7_io_out_uop_prs1 : _GEN_194 ? _slots_6_io_out_uop_prs1 : _GEN_193 ? _slots_5_io_out_uop_prs1 : _slots_4_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_195 ? _slots_7_io_out_uop_prs2 : _GEN_194 ? _slots_6_io_out_uop_prs2 : _GEN_193 ? _slots_5_io_out_uop_prs2 : _slots_4_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_195 ? _slots_7_io_out_uop_prs3 : _GEN_194 ? _slots_6_io_out_uop_prs3 : _GEN_193 ? _slots_5_io_out_uop_prs3 : _slots_4_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_195 ? _slots_7_io_out_uop_prs1_busy : _GEN_194 ? _slots_6_io_out_uop_prs1_busy : _GEN_193 ? _slots_5_io_out_uop_prs1_busy : _slots_4_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_195 ? _slots_7_io_out_uop_prs2_busy : _GEN_194 ? _slots_6_io_out_uop_prs2_busy : _GEN_193 ? _slots_5_io_out_uop_prs2_busy : _slots_4_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_195 ? _slots_7_io_out_uop_prs3_busy : _GEN_194 ? _slots_6_io_out_uop_prs3_busy : _GEN_193 ? _slots_5_io_out_uop_prs3_busy : _slots_4_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_195 ? _slots_7_io_out_uop_ppred_busy : _GEN_194 ? _slots_6_io_out_uop_ppred_busy : _GEN_193 ? _slots_5_io_out_uop_ppred_busy : _slots_4_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_195 ? _slots_7_io_out_uop_mem_cmd : _GEN_194 ? _slots_6_io_out_uop_mem_cmd : _GEN_193 ? _slots_5_io_out_uop_mem_cmd : _slots_4_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_195 ? _slots_7_io_out_uop_is_amo : _GEN_194 ? _slots_6_io_out_uop_is_amo : _GEN_193 ? _slots_5_io_out_uop_is_amo : _slots_4_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_195 ? _slots_7_io_out_uop_uses_ldq : _GEN_194 ? _slots_6_io_out_uop_uses_ldq : _GEN_193 ? _slots_5_io_out_uop_uses_ldq : _slots_4_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_195 ? _slots_7_io_out_uop_uses_stq : _GEN_194 ? _slots_6_io_out_uop_uses_stq : _GEN_193 ? _slots_5_io_out_uop_uses_stq : _slots_4_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_195 ? _slots_7_io_out_uop_dst_rtype : _GEN_194 ? _slots_6_io_out_uop_dst_rtype : _GEN_193 ? _slots_5_io_out_uop_dst_rtype : _slots_4_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_195 ? _slots_7_io_out_uop_fp_val : _GEN_194 ? _slots_6_io_out_uop_fp_val : _GEN_193 ? _slots_5_io_out_uop_fp_val : _slots_4_io_out_uop_fp_val),
    .io_valid                       (_slots_3_io_valid),
    .io_will_be_valid               (_slots_3_io_will_be_valid),
    .io_request                     (_slots_3_io_request),
    .io_out_uop_uopc                (_slots_3_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_3_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_3_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_3_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_3_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_3_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_3_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_3_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_3_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_3_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_3_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_3_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_3_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_3_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_3_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_3_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_3_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_3_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_3_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_3_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_3_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_3_io_uop_uopc),
    .io_uop_fu_code                 (_slots_3_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_3_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_3_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_3_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_3_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_3_io_uop_pdst),
    .io_uop_prs1                    (_slots_3_io_uop_prs1),
    .io_uop_prs2                    (_slots_3_io_uop_prs2),
    .io_uop_prs3                    (_slots_3_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_3_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_3_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_3_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_3_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_3_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_3_io_uop_fp_val)
  );
  IssueSlot slots_4 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_4_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_15),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_4_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_198 ? _slots_8_io_out_uop_uopc : _GEN_197 ? _slots_7_io_out_uop_uopc : _GEN_196 ? _slots_6_io_out_uop_uopc : _slots_5_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_198 ? _slots_8_io_out_uop_fu_code : _GEN_197 ? _slots_7_io_out_uop_fu_code : _GEN_196 ? _slots_6_io_out_uop_fu_code : _slots_5_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_198 ? _slots_8_io_out_uop_iw_state : _GEN_197 ? _slots_7_io_out_uop_iw_state : _GEN_196 ? _slots_6_io_out_uop_iw_state : _slots_5_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_198 ? _slots_8_io_out_uop_br_mask : _GEN_197 ? _slots_7_io_out_uop_br_mask : _GEN_196 ? _slots_6_io_out_uop_br_mask : _slots_5_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_198 ? _slots_8_io_out_uop_imm_packed : _GEN_197 ? _slots_7_io_out_uop_imm_packed : _GEN_196 ? _slots_6_io_out_uop_imm_packed : _slots_5_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_198 ? _slots_8_io_out_uop_rob_idx : _GEN_197 ? _slots_7_io_out_uop_rob_idx : _GEN_196 ? _slots_6_io_out_uop_rob_idx : _slots_5_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_198 ? _slots_8_io_out_uop_stq_idx : _GEN_197 ? _slots_7_io_out_uop_stq_idx : _GEN_196 ? _slots_6_io_out_uop_stq_idx : _slots_5_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_198 ? _slots_8_io_out_uop_pdst : _GEN_197 ? _slots_7_io_out_uop_pdst : _GEN_196 ? _slots_6_io_out_uop_pdst : _slots_5_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_198 ? _slots_8_io_out_uop_prs1 : _GEN_197 ? _slots_7_io_out_uop_prs1 : _GEN_196 ? _slots_6_io_out_uop_prs1 : _slots_5_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_198 ? _slots_8_io_out_uop_prs2 : _GEN_197 ? _slots_7_io_out_uop_prs2 : _GEN_196 ? _slots_6_io_out_uop_prs2 : _slots_5_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_198 ? _slots_8_io_out_uop_prs3 : _GEN_197 ? _slots_7_io_out_uop_prs3 : _GEN_196 ? _slots_6_io_out_uop_prs3 : _slots_5_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_198 ? _slots_8_io_out_uop_prs1_busy : _GEN_197 ? _slots_7_io_out_uop_prs1_busy : _GEN_196 ? _slots_6_io_out_uop_prs1_busy : _slots_5_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_198 ? _slots_8_io_out_uop_prs2_busy : _GEN_197 ? _slots_7_io_out_uop_prs2_busy : _GEN_196 ? _slots_6_io_out_uop_prs2_busy : _slots_5_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_198 ? _slots_8_io_out_uop_prs3_busy : _GEN_197 ? _slots_7_io_out_uop_prs3_busy : _GEN_196 ? _slots_6_io_out_uop_prs3_busy : _slots_5_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_198 ? _slots_8_io_out_uop_ppred_busy : _GEN_197 ? _slots_7_io_out_uop_ppred_busy : _GEN_196 ? _slots_6_io_out_uop_ppred_busy : _slots_5_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_198 ? _slots_8_io_out_uop_mem_cmd : _GEN_197 ? _slots_7_io_out_uop_mem_cmd : _GEN_196 ? _slots_6_io_out_uop_mem_cmd : _slots_5_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_198 ? _slots_8_io_out_uop_is_amo : _GEN_197 ? _slots_7_io_out_uop_is_amo : _GEN_196 ? _slots_6_io_out_uop_is_amo : _slots_5_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_198 ? _slots_8_io_out_uop_uses_ldq : _GEN_197 ? _slots_7_io_out_uop_uses_ldq : _GEN_196 ? _slots_6_io_out_uop_uses_ldq : _slots_5_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_198 ? _slots_8_io_out_uop_uses_stq : _GEN_197 ? _slots_7_io_out_uop_uses_stq : _GEN_196 ? _slots_6_io_out_uop_uses_stq : _slots_5_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_198 ? _slots_8_io_out_uop_dst_rtype : _GEN_197 ? _slots_7_io_out_uop_dst_rtype : _GEN_196 ? _slots_6_io_out_uop_dst_rtype : _slots_5_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_198 ? _slots_8_io_out_uop_fp_val : _GEN_197 ? _slots_7_io_out_uop_fp_val : _GEN_196 ? _slots_6_io_out_uop_fp_val : _slots_5_io_out_uop_fp_val),
    .io_valid                       (_slots_4_io_valid),
    .io_will_be_valid               (_slots_4_io_will_be_valid),
    .io_request                     (_slots_4_io_request),
    .io_out_uop_uopc                (_slots_4_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_4_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_4_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_4_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_4_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_4_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_4_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_4_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_4_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_4_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_4_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_4_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_4_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_4_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_4_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_4_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_4_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_4_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_4_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_4_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_4_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_4_io_uop_uopc),
    .io_uop_fu_code                 (_slots_4_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_4_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_4_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_4_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_4_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_4_io_uop_pdst),
    .io_uop_prs1                    (_slots_4_io_uop_prs1),
    .io_uop_prs2                    (_slots_4_io_uop_prs2),
    .io_uop_prs3                    (_slots_4_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_4_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_4_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_4_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_4_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_4_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_4_io_uop_fp_val)
  );
  IssueSlot slots_5 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_5_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_17),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_5_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_201 ? _slots_9_io_out_uop_uopc : _GEN_200 ? _slots_8_io_out_uop_uopc : _GEN_199 ? _slots_7_io_out_uop_uopc : _slots_6_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_201 ? _slots_9_io_out_uop_fu_code : _GEN_200 ? _slots_8_io_out_uop_fu_code : _GEN_199 ? _slots_7_io_out_uop_fu_code : _slots_6_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_201 ? _slots_9_io_out_uop_iw_state : _GEN_200 ? _slots_8_io_out_uop_iw_state : _GEN_199 ? _slots_7_io_out_uop_iw_state : _slots_6_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_201 ? _slots_9_io_out_uop_br_mask : _GEN_200 ? _slots_8_io_out_uop_br_mask : _GEN_199 ? _slots_7_io_out_uop_br_mask : _slots_6_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_201 ? _slots_9_io_out_uop_imm_packed : _GEN_200 ? _slots_8_io_out_uop_imm_packed : _GEN_199 ? _slots_7_io_out_uop_imm_packed : _slots_6_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_201 ? _slots_9_io_out_uop_rob_idx : _GEN_200 ? _slots_8_io_out_uop_rob_idx : _GEN_199 ? _slots_7_io_out_uop_rob_idx : _slots_6_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_201 ? _slots_9_io_out_uop_stq_idx : _GEN_200 ? _slots_8_io_out_uop_stq_idx : _GEN_199 ? _slots_7_io_out_uop_stq_idx : _slots_6_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_201 ? _slots_9_io_out_uop_pdst : _GEN_200 ? _slots_8_io_out_uop_pdst : _GEN_199 ? _slots_7_io_out_uop_pdst : _slots_6_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_201 ? _slots_9_io_out_uop_prs1 : _GEN_200 ? _slots_8_io_out_uop_prs1 : _GEN_199 ? _slots_7_io_out_uop_prs1 : _slots_6_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_201 ? _slots_9_io_out_uop_prs2 : _GEN_200 ? _slots_8_io_out_uop_prs2 : _GEN_199 ? _slots_7_io_out_uop_prs2 : _slots_6_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_201 ? _slots_9_io_out_uop_prs3 : _GEN_200 ? _slots_8_io_out_uop_prs3 : _GEN_199 ? _slots_7_io_out_uop_prs3 : _slots_6_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_201 ? _slots_9_io_out_uop_prs1_busy : _GEN_200 ? _slots_8_io_out_uop_prs1_busy : _GEN_199 ? _slots_7_io_out_uop_prs1_busy : _slots_6_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_201 ? _slots_9_io_out_uop_prs2_busy : _GEN_200 ? _slots_8_io_out_uop_prs2_busy : _GEN_199 ? _slots_7_io_out_uop_prs2_busy : _slots_6_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_201 ? _slots_9_io_out_uop_prs3_busy : _GEN_200 ? _slots_8_io_out_uop_prs3_busy : _GEN_199 ? _slots_7_io_out_uop_prs3_busy : _slots_6_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_201 ? _slots_9_io_out_uop_ppred_busy : _GEN_200 ? _slots_8_io_out_uop_ppred_busy : _GEN_199 ? _slots_7_io_out_uop_ppred_busy : _slots_6_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_201 ? _slots_9_io_out_uop_mem_cmd : _GEN_200 ? _slots_8_io_out_uop_mem_cmd : _GEN_199 ? _slots_7_io_out_uop_mem_cmd : _slots_6_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_201 ? _slots_9_io_out_uop_is_amo : _GEN_200 ? _slots_8_io_out_uop_is_amo : _GEN_199 ? _slots_7_io_out_uop_is_amo : _slots_6_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_201 ? _slots_9_io_out_uop_uses_ldq : _GEN_200 ? _slots_8_io_out_uop_uses_ldq : _GEN_199 ? _slots_7_io_out_uop_uses_ldq : _slots_6_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_201 ? _slots_9_io_out_uop_uses_stq : _GEN_200 ? _slots_8_io_out_uop_uses_stq : _GEN_199 ? _slots_7_io_out_uop_uses_stq : _slots_6_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_201 ? _slots_9_io_out_uop_dst_rtype : _GEN_200 ? _slots_8_io_out_uop_dst_rtype : _GEN_199 ? _slots_7_io_out_uop_dst_rtype : _slots_6_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_201 ? _slots_9_io_out_uop_fp_val : _GEN_200 ? _slots_8_io_out_uop_fp_val : _GEN_199 ? _slots_7_io_out_uop_fp_val : _slots_6_io_out_uop_fp_val),
    .io_valid                       (_slots_5_io_valid),
    .io_will_be_valid               (_slots_5_io_will_be_valid),
    .io_request                     (_slots_5_io_request),
    .io_out_uop_uopc                (_slots_5_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_5_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_5_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_5_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_5_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_5_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_5_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_5_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_5_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_5_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_5_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_5_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_5_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_5_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_5_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_5_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_5_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_5_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_5_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_5_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_5_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_5_io_uop_uopc),
    .io_uop_fu_code                 (_slots_5_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_5_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_5_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_5_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_5_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_5_io_uop_pdst),
    .io_uop_prs1                    (_slots_5_io_uop_prs1),
    .io_uop_prs2                    (_slots_5_io_uop_prs2),
    .io_uop_prs3                    (_slots_5_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_5_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_5_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_5_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_5_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_5_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_5_io_uop_fp_val)
  );
  IssueSlot slots_6 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_6_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_19),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_6_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_204 ? _slots_10_io_out_uop_uopc : _GEN_203 ? _slots_9_io_out_uop_uopc : _GEN_202 ? _slots_8_io_out_uop_uopc : _slots_7_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_204 ? _slots_10_io_out_uop_fu_code : _GEN_203 ? _slots_9_io_out_uop_fu_code : _GEN_202 ? _slots_8_io_out_uop_fu_code : _slots_7_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_204 ? _slots_10_io_out_uop_iw_state : _GEN_203 ? _slots_9_io_out_uop_iw_state : _GEN_202 ? _slots_8_io_out_uop_iw_state : _slots_7_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_204 ? _slots_10_io_out_uop_br_mask : _GEN_203 ? _slots_9_io_out_uop_br_mask : _GEN_202 ? _slots_8_io_out_uop_br_mask : _slots_7_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_204 ? _slots_10_io_out_uop_imm_packed : _GEN_203 ? _slots_9_io_out_uop_imm_packed : _GEN_202 ? _slots_8_io_out_uop_imm_packed : _slots_7_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_204 ? _slots_10_io_out_uop_rob_idx : _GEN_203 ? _slots_9_io_out_uop_rob_idx : _GEN_202 ? _slots_8_io_out_uop_rob_idx : _slots_7_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_204 ? _slots_10_io_out_uop_stq_idx : _GEN_203 ? _slots_9_io_out_uop_stq_idx : _GEN_202 ? _slots_8_io_out_uop_stq_idx : _slots_7_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_204 ? _slots_10_io_out_uop_pdst : _GEN_203 ? _slots_9_io_out_uop_pdst : _GEN_202 ? _slots_8_io_out_uop_pdst : _slots_7_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_204 ? _slots_10_io_out_uop_prs1 : _GEN_203 ? _slots_9_io_out_uop_prs1 : _GEN_202 ? _slots_8_io_out_uop_prs1 : _slots_7_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_204 ? _slots_10_io_out_uop_prs2 : _GEN_203 ? _slots_9_io_out_uop_prs2 : _GEN_202 ? _slots_8_io_out_uop_prs2 : _slots_7_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_204 ? _slots_10_io_out_uop_prs3 : _GEN_203 ? _slots_9_io_out_uop_prs3 : _GEN_202 ? _slots_8_io_out_uop_prs3 : _slots_7_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_204 ? _slots_10_io_out_uop_prs1_busy : _GEN_203 ? _slots_9_io_out_uop_prs1_busy : _GEN_202 ? _slots_8_io_out_uop_prs1_busy : _slots_7_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_204 ? _slots_10_io_out_uop_prs2_busy : _GEN_203 ? _slots_9_io_out_uop_prs2_busy : _GEN_202 ? _slots_8_io_out_uop_prs2_busy : _slots_7_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_204 ? _slots_10_io_out_uop_prs3_busy : _GEN_203 ? _slots_9_io_out_uop_prs3_busy : _GEN_202 ? _slots_8_io_out_uop_prs3_busy : _slots_7_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_204 ? _slots_10_io_out_uop_ppred_busy : _GEN_203 ? _slots_9_io_out_uop_ppred_busy : _GEN_202 ? _slots_8_io_out_uop_ppred_busy : _slots_7_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_204 ? _slots_10_io_out_uop_mem_cmd : _GEN_203 ? _slots_9_io_out_uop_mem_cmd : _GEN_202 ? _slots_8_io_out_uop_mem_cmd : _slots_7_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_204 ? _slots_10_io_out_uop_is_amo : _GEN_203 ? _slots_9_io_out_uop_is_amo : _GEN_202 ? _slots_8_io_out_uop_is_amo : _slots_7_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_204 ? _slots_10_io_out_uop_uses_ldq : _GEN_203 ? _slots_9_io_out_uop_uses_ldq : _GEN_202 ? _slots_8_io_out_uop_uses_ldq : _slots_7_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_204 ? _slots_10_io_out_uop_uses_stq : _GEN_203 ? _slots_9_io_out_uop_uses_stq : _GEN_202 ? _slots_8_io_out_uop_uses_stq : _slots_7_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_204 ? _slots_10_io_out_uop_dst_rtype : _GEN_203 ? _slots_9_io_out_uop_dst_rtype : _GEN_202 ? _slots_8_io_out_uop_dst_rtype : _slots_7_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_204 ? _slots_10_io_out_uop_fp_val : _GEN_203 ? _slots_9_io_out_uop_fp_val : _GEN_202 ? _slots_8_io_out_uop_fp_val : _slots_7_io_out_uop_fp_val),
    .io_valid                       (_slots_6_io_valid),
    .io_will_be_valid               (_slots_6_io_will_be_valid),
    .io_request                     (_slots_6_io_request),
    .io_out_uop_uopc                (_slots_6_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_6_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_6_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_6_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_6_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_6_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_6_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_6_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_6_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_6_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_6_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_6_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_6_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_6_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_6_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_6_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_6_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_6_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_6_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_6_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_6_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_6_io_uop_uopc),
    .io_uop_fu_code                 (_slots_6_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_6_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_6_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_6_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_6_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_6_io_uop_pdst),
    .io_uop_prs1                    (_slots_6_io_uop_prs1),
    .io_uop_prs2                    (_slots_6_io_uop_prs2),
    .io_uop_prs3                    (_slots_6_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_6_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_6_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_6_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_6_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_6_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_6_io_uop_fp_val)
  );
  IssueSlot slots_7 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_7_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_21),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_7_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_207 ? _slots_11_io_out_uop_uopc : _GEN_206 ? _slots_10_io_out_uop_uopc : _GEN_205 ? _slots_9_io_out_uop_uopc : _slots_8_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_207 ? _slots_11_io_out_uop_fu_code : _GEN_206 ? _slots_10_io_out_uop_fu_code : _GEN_205 ? _slots_9_io_out_uop_fu_code : _slots_8_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_207 ? _slots_11_io_out_uop_iw_state : _GEN_206 ? _slots_10_io_out_uop_iw_state : _GEN_205 ? _slots_9_io_out_uop_iw_state : _slots_8_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_207 ? _slots_11_io_out_uop_br_mask : _GEN_206 ? _slots_10_io_out_uop_br_mask : _GEN_205 ? _slots_9_io_out_uop_br_mask : _slots_8_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_207 ? _slots_11_io_out_uop_imm_packed : _GEN_206 ? _slots_10_io_out_uop_imm_packed : _GEN_205 ? _slots_9_io_out_uop_imm_packed : _slots_8_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_207 ? _slots_11_io_out_uop_rob_idx : _GEN_206 ? _slots_10_io_out_uop_rob_idx : _GEN_205 ? _slots_9_io_out_uop_rob_idx : _slots_8_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_207 ? _slots_11_io_out_uop_stq_idx : _GEN_206 ? _slots_10_io_out_uop_stq_idx : _GEN_205 ? _slots_9_io_out_uop_stq_idx : _slots_8_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_207 ? _slots_11_io_out_uop_pdst : _GEN_206 ? _slots_10_io_out_uop_pdst : _GEN_205 ? _slots_9_io_out_uop_pdst : _slots_8_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_207 ? _slots_11_io_out_uop_prs1 : _GEN_206 ? _slots_10_io_out_uop_prs1 : _GEN_205 ? _slots_9_io_out_uop_prs1 : _slots_8_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_207 ? _slots_11_io_out_uop_prs2 : _GEN_206 ? _slots_10_io_out_uop_prs2 : _GEN_205 ? _slots_9_io_out_uop_prs2 : _slots_8_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_207 ? _slots_11_io_out_uop_prs3 : _GEN_206 ? _slots_10_io_out_uop_prs3 : _GEN_205 ? _slots_9_io_out_uop_prs3 : _slots_8_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_207 ? _slots_11_io_out_uop_prs1_busy : _GEN_206 ? _slots_10_io_out_uop_prs1_busy : _GEN_205 ? _slots_9_io_out_uop_prs1_busy : _slots_8_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_207 ? _slots_11_io_out_uop_prs2_busy : _GEN_206 ? _slots_10_io_out_uop_prs2_busy : _GEN_205 ? _slots_9_io_out_uop_prs2_busy : _slots_8_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_207 ? _slots_11_io_out_uop_prs3_busy : _GEN_206 ? _slots_10_io_out_uop_prs3_busy : _GEN_205 ? _slots_9_io_out_uop_prs3_busy : _slots_8_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_207 ? _slots_11_io_out_uop_ppred_busy : _GEN_206 ? _slots_10_io_out_uop_ppred_busy : _GEN_205 ? _slots_9_io_out_uop_ppred_busy : _slots_8_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_207 ? _slots_11_io_out_uop_mem_cmd : _GEN_206 ? _slots_10_io_out_uop_mem_cmd : _GEN_205 ? _slots_9_io_out_uop_mem_cmd : _slots_8_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_207 ? _slots_11_io_out_uop_is_amo : _GEN_206 ? _slots_10_io_out_uop_is_amo : _GEN_205 ? _slots_9_io_out_uop_is_amo : _slots_8_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_207 ? _slots_11_io_out_uop_uses_ldq : _GEN_206 ? _slots_10_io_out_uop_uses_ldq : _GEN_205 ? _slots_9_io_out_uop_uses_ldq : _slots_8_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_207 ? _slots_11_io_out_uop_uses_stq : _GEN_206 ? _slots_10_io_out_uop_uses_stq : _GEN_205 ? _slots_9_io_out_uop_uses_stq : _slots_8_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_207 ? _slots_11_io_out_uop_dst_rtype : _GEN_206 ? _slots_10_io_out_uop_dst_rtype : _GEN_205 ? _slots_9_io_out_uop_dst_rtype : _slots_8_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_207 ? _slots_11_io_out_uop_fp_val : _GEN_206 ? _slots_10_io_out_uop_fp_val : _GEN_205 ? _slots_9_io_out_uop_fp_val : _slots_8_io_out_uop_fp_val),
    .io_valid                       (_slots_7_io_valid),
    .io_will_be_valid               (_slots_7_io_will_be_valid),
    .io_request                     (_slots_7_io_request),
    .io_out_uop_uopc                (_slots_7_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_7_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_7_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_7_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_7_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_7_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_7_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_7_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_7_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_7_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_7_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_7_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_7_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_7_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_7_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_7_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_7_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_7_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_7_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_7_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_7_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_7_io_uop_uopc),
    .io_uop_fu_code                 (_slots_7_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_7_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_7_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_7_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_7_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_7_io_uop_pdst),
    .io_uop_prs1                    (_slots_7_io_uop_prs1),
    .io_uop_prs2                    (_slots_7_io_uop_prs2),
    .io_uop_prs3                    (_slots_7_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_7_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_7_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_7_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_7_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_7_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_7_io_uop_fp_val)
  );
  IssueSlot slots_8 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_8_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_23),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_8_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_210 ? _slots_12_io_out_uop_uopc : _GEN_209 ? _slots_11_io_out_uop_uopc : _GEN_208 ? _slots_10_io_out_uop_uopc : _slots_9_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_210 ? _slots_12_io_out_uop_fu_code : _GEN_209 ? _slots_11_io_out_uop_fu_code : _GEN_208 ? _slots_10_io_out_uop_fu_code : _slots_9_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_210 ? _slots_12_io_out_uop_iw_state : _GEN_209 ? _slots_11_io_out_uop_iw_state : _GEN_208 ? _slots_10_io_out_uop_iw_state : _slots_9_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_210 ? _slots_12_io_out_uop_br_mask : _GEN_209 ? _slots_11_io_out_uop_br_mask : _GEN_208 ? _slots_10_io_out_uop_br_mask : _slots_9_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_210 ? _slots_12_io_out_uop_imm_packed : _GEN_209 ? _slots_11_io_out_uop_imm_packed : _GEN_208 ? _slots_10_io_out_uop_imm_packed : _slots_9_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_210 ? _slots_12_io_out_uop_rob_idx : _GEN_209 ? _slots_11_io_out_uop_rob_idx : _GEN_208 ? _slots_10_io_out_uop_rob_idx : _slots_9_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_210 ? _slots_12_io_out_uop_stq_idx : _GEN_209 ? _slots_11_io_out_uop_stq_idx : _GEN_208 ? _slots_10_io_out_uop_stq_idx : _slots_9_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_210 ? _slots_12_io_out_uop_pdst : _GEN_209 ? _slots_11_io_out_uop_pdst : _GEN_208 ? _slots_10_io_out_uop_pdst : _slots_9_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_210 ? _slots_12_io_out_uop_prs1 : _GEN_209 ? _slots_11_io_out_uop_prs1 : _GEN_208 ? _slots_10_io_out_uop_prs1 : _slots_9_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_210 ? _slots_12_io_out_uop_prs2 : _GEN_209 ? _slots_11_io_out_uop_prs2 : _GEN_208 ? _slots_10_io_out_uop_prs2 : _slots_9_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_210 ? _slots_12_io_out_uop_prs3 : _GEN_209 ? _slots_11_io_out_uop_prs3 : _GEN_208 ? _slots_10_io_out_uop_prs3 : _slots_9_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_210 ? _slots_12_io_out_uop_prs1_busy : _GEN_209 ? _slots_11_io_out_uop_prs1_busy : _GEN_208 ? _slots_10_io_out_uop_prs1_busy : _slots_9_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_210 ? _slots_12_io_out_uop_prs2_busy : _GEN_209 ? _slots_11_io_out_uop_prs2_busy : _GEN_208 ? _slots_10_io_out_uop_prs2_busy : _slots_9_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_210 ? _slots_12_io_out_uop_prs3_busy : _GEN_209 ? _slots_11_io_out_uop_prs3_busy : _GEN_208 ? _slots_10_io_out_uop_prs3_busy : _slots_9_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_210 ? _slots_12_io_out_uop_ppred_busy : _GEN_209 ? _slots_11_io_out_uop_ppred_busy : _GEN_208 ? _slots_10_io_out_uop_ppred_busy : _slots_9_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_210 ? _slots_12_io_out_uop_mem_cmd : _GEN_209 ? _slots_11_io_out_uop_mem_cmd : _GEN_208 ? _slots_10_io_out_uop_mem_cmd : _slots_9_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_210 ? _slots_12_io_out_uop_is_amo : _GEN_209 ? _slots_11_io_out_uop_is_amo : _GEN_208 ? _slots_10_io_out_uop_is_amo : _slots_9_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_210 ? _slots_12_io_out_uop_uses_ldq : _GEN_209 ? _slots_11_io_out_uop_uses_ldq : _GEN_208 ? _slots_10_io_out_uop_uses_ldq : _slots_9_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_210 ? _slots_12_io_out_uop_uses_stq : _GEN_209 ? _slots_11_io_out_uop_uses_stq : _GEN_208 ? _slots_10_io_out_uop_uses_stq : _slots_9_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_210 ? _slots_12_io_out_uop_dst_rtype : _GEN_209 ? _slots_11_io_out_uop_dst_rtype : _GEN_208 ? _slots_10_io_out_uop_dst_rtype : _slots_9_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_210 ? _slots_12_io_out_uop_fp_val : _GEN_209 ? _slots_11_io_out_uop_fp_val : _GEN_208 ? _slots_10_io_out_uop_fp_val : _slots_9_io_out_uop_fp_val),
    .io_valid                       (_slots_8_io_valid),
    .io_will_be_valid               (_slots_8_io_will_be_valid),
    .io_request                     (_slots_8_io_request),
    .io_out_uop_uopc                (_slots_8_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_8_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_8_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_8_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_8_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_8_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_8_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_8_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_8_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_8_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_8_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_8_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_8_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_8_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_8_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_8_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_8_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_8_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_8_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_8_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_8_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_8_io_uop_uopc),
    .io_uop_fu_code                 (_slots_8_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_8_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_8_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_8_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_8_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_8_io_uop_pdst),
    .io_uop_prs1                    (_slots_8_io_uop_prs1),
    .io_uop_prs2                    (_slots_8_io_uop_prs2),
    .io_uop_prs3                    (_slots_8_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_8_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_8_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_8_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_8_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_8_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_8_io_uop_fp_val)
  );
  IssueSlot slots_9 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_9_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_25),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_9_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_213 ? _slots_13_io_out_uop_uopc : _GEN_212 ? _slots_12_io_out_uop_uopc : _GEN_211 ? _slots_11_io_out_uop_uopc : _slots_10_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_213 ? _slots_13_io_out_uop_fu_code : _GEN_212 ? _slots_12_io_out_uop_fu_code : _GEN_211 ? _slots_11_io_out_uop_fu_code : _slots_10_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_213 ? _slots_13_io_out_uop_iw_state : _GEN_212 ? _slots_12_io_out_uop_iw_state : _GEN_211 ? _slots_11_io_out_uop_iw_state : _slots_10_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_213 ? _slots_13_io_out_uop_br_mask : _GEN_212 ? _slots_12_io_out_uop_br_mask : _GEN_211 ? _slots_11_io_out_uop_br_mask : _slots_10_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_213 ? _slots_13_io_out_uop_imm_packed : _GEN_212 ? _slots_12_io_out_uop_imm_packed : _GEN_211 ? _slots_11_io_out_uop_imm_packed : _slots_10_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_213 ? _slots_13_io_out_uop_rob_idx : _GEN_212 ? _slots_12_io_out_uop_rob_idx : _GEN_211 ? _slots_11_io_out_uop_rob_idx : _slots_10_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_213 ? _slots_13_io_out_uop_stq_idx : _GEN_212 ? _slots_12_io_out_uop_stq_idx : _GEN_211 ? _slots_11_io_out_uop_stq_idx : _slots_10_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_213 ? _slots_13_io_out_uop_pdst : _GEN_212 ? _slots_12_io_out_uop_pdst : _GEN_211 ? _slots_11_io_out_uop_pdst : _slots_10_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_213 ? _slots_13_io_out_uop_prs1 : _GEN_212 ? _slots_12_io_out_uop_prs1 : _GEN_211 ? _slots_11_io_out_uop_prs1 : _slots_10_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_213 ? _slots_13_io_out_uop_prs2 : _GEN_212 ? _slots_12_io_out_uop_prs2 : _GEN_211 ? _slots_11_io_out_uop_prs2 : _slots_10_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_213 ? _slots_13_io_out_uop_prs3 : _GEN_212 ? _slots_12_io_out_uop_prs3 : _GEN_211 ? _slots_11_io_out_uop_prs3 : _slots_10_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_213 ? _slots_13_io_out_uop_prs1_busy : _GEN_212 ? _slots_12_io_out_uop_prs1_busy : _GEN_211 ? _slots_11_io_out_uop_prs1_busy : _slots_10_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_213 ? _slots_13_io_out_uop_prs2_busy : _GEN_212 ? _slots_12_io_out_uop_prs2_busy : _GEN_211 ? _slots_11_io_out_uop_prs2_busy : _slots_10_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_213 ? _slots_13_io_out_uop_prs3_busy : _GEN_212 ? _slots_12_io_out_uop_prs3_busy : _GEN_211 ? _slots_11_io_out_uop_prs3_busy : _slots_10_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_213 ? _slots_13_io_out_uop_ppred_busy : _GEN_212 ? _slots_12_io_out_uop_ppred_busy : _GEN_211 ? _slots_11_io_out_uop_ppred_busy : _slots_10_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_213 ? _slots_13_io_out_uop_mem_cmd : _GEN_212 ? _slots_12_io_out_uop_mem_cmd : _GEN_211 ? _slots_11_io_out_uop_mem_cmd : _slots_10_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_213 ? _slots_13_io_out_uop_is_amo : _GEN_212 ? _slots_12_io_out_uop_is_amo : _GEN_211 ? _slots_11_io_out_uop_is_amo : _slots_10_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_213 ? _slots_13_io_out_uop_uses_ldq : _GEN_212 ? _slots_12_io_out_uop_uses_ldq : _GEN_211 ? _slots_11_io_out_uop_uses_ldq : _slots_10_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_213 ? _slots_13_io_out_uop_uses_stq : _GEN_212 ? _slots_12_io_out_uop_uses_stq : _GEN_211 ? _slots_11_io_out_uop_uses_stq : _slots_10_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_213 ? _slots_13_io_out_uop_dst_rtype : _GEN_212 ? _slots_12_io_out_uop_dst_rtype : _GEN_211 ? _slots_11_io_out_uop_dst_rtype : _slots_10_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_213 ? _slots_13_io_out_uop_fp_val : _GEN_212 ? _slots_12_io_out_uop_fp_val : _GEN_211 ? _slots_11_io_out_uop_fp_val : _slots_10_io_out_uop_fp_val),
    .io_valid                       (_slots_9_io_valid),
    .io_will_be_valid               (_slots_9_io_will_be_valid),
    .io_request                     (_slots_9_io_request),
    .io_out_uop_uopc                (_slots_9_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_9_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_9_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_9_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_9_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_9_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_9_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_9_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_9_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_9_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_9_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_9_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_9_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_9_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_9_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_9_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_9_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_9_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_9_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_9_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_9_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_9_io_uop_uopc),
    .io_uop_fu_code                 (_slots_9_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_9_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_9_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_9_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_9_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_9_io_uop_pdst),
    .io_uop_prs1                    (_slots_9_io_uop_prs1),
    .io_uop_prs2                    (_slots_9_io_uop_prs2),
    .io_uop_prs3                    (_slots_9_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_9_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_9_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_9_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_9_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_9_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_9_io_uop_fp_val)
  );
  IssueSlot slots_10 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_10_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_27),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_10_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_216 ? _slots_14_io_out_uop_uopc : _GEN_215 ? _slots_13_io_out_uop_uopc : _GEN_214 ? _slots_12_io_out_uop_uopc : _slots_11_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_216 ? _slots_14_io_out_uop_fu_code : _GEN_215 ? _slots_13_io_out_uop_fu_code : _GEN_214 ? _slots_12_io_out_uop_fu_code : _slots_11_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_216 ? _slots_14_io_out_uop_iw_state : _GEN_215 ? _slots_13_io_out_uop_iw_state : _GEN_214 ? _slots_12_io_out_uop_iw_state : _slots_11_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_216 ? _slots_14_io_out_uop_br_mask : _GEN_215 ? _slots_13_io_out_uop_br_mask : _GEN_214 ? _slots_12_io_out_uop_br_mask : _slots_11_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_216 ? _slots_14_io_out_uop_imm_packed : _GEN_215 ? _slots_13_io_out_uop_imm_packed : _GEN_214 ? _slots_12_io_out_uop_imm_packed : _slots_11_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_216 ? _slots_14_io_out_uop_rob_idx : _GEN_215 ? _slots_13_io_out_uop_rob_idx : _GEN_214 ? _slots_12_io_out_uop_rob_idx : _slots_11_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_216 ? _slots_14_io_out_uop_stq_idx : _GEN_215 ? _slots_13_io_out_uop_stq_idx : _GEN_214 ? _slots_12_io_out_uop_stq_idx : _slots_11_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_216 ? _slots_14_io_out_uop_pdst : _GEN_215 ? _slots_13_io_out_uop_pdst : _GEN_214 ? _slots_12_io_out_uop_pdst : _slots_11_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_216 ? _slots_14_io_out_uop_prs1 : _GEN_215 ? _slots_13_io_out_uop_prs1 : _GEN_214 ? _slots_12_io_out_uop_prs1 : _slots_11_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_216 ? _slots_14_io_out_uop_prs2 : _GEN_215 ? _slots_13_io_out_uop_prs2 : _GEN_214 ? _slots_12_io_out_uop_prs2 : _slots_11_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_216 ? _slots_14_io_out_uop_prs3 : _GEN_215 ? _slots_13_io_out_uop_prs3 : _GEN_214 ? _slots_12_io_out_uop_prs3 : _slots_11_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_216 ? _slots_14_io_out_uop_prs1_busy : _GEN_215 ? _slots_13_io_out_uop_prs1_busy : _GEN_214 ? _slots_12_io_out_uop_prs1_busy : _slots_11_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_216 ? _slots_14_io_out_uop_prs2_busy : _GEN_215 ? _slots_13_io_out_uop_prs2_busy : _GEN_214 ? _slots_12_io_out_uop_prs2_busy : _slots_11_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_216 ? _slots_14_io_out_uop_prs3_busy : _GEN_215 ? _slots_13_io_out_uop_prs3_busy : _GEN_214 ? _slots_12_io_out_uop_prs3_busy : _slots_11_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_216 ? _slots_14_io_out_uop_ppred_busy : _GEN_215 ? _slots_13_io_out_uop_ppred_busy : _GEN_214 ? _slots_12_io_out_uop_ppred_busy : _slots_11_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_216 ? _slots_14_io_out_uop_mem_cmd : _GEN_215 ? _slots_13_io_out_uop_mem_cmd : _GEN_214 ? _slots_12_io_out_uop_mem_cmd : _slots_11_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_216 ? _slots_14_io_out_uop_is_amo : _GEN_215 ? _slots_13_io_out_uop_is_amo : _GEN_214 ? _slots_12_io_out_uop_is_amo : _slots_11_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_216 ? _slots_14_io_out_uop_uses_ldq : _GEN_215 ? _slots_13_io_out_uop_uses_ldq : _GEN_214 ? _slots_12_io_out_uop_uses_ldq : _slots_11_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_216 ? _slots_14_io_out_uop_uses_stq : _GEN_215 ? _slots_13_io_out_uop_uses_stq : _GEN_214 ? _slots_12_io_out_uop_uses_stq : _slots_11_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_216 ? _slots_14_io_out_uop_dst_rtype : _GEN_215 ? _slots_13_io_out_uop_dst_rtype : _GEN_214 ? _slots_12_io_out_uop_dst_rtype : _slots_11_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_216 ? _slots_14_io_out_uop_fp_val : _GEN_215 ? _slots_13_io_out_uop_fp_val : _GEN_214 ? _slots_12_io_out_uop_fp_val : _slots_11_io_out_uop_fp_val),
    .io_valid                       (_slots_10_io_valid),
    .io_will_be_valid               (_slots_10_io_will_be_valid),
    .io_request                     (_slots_10_io_request),
    .io_out_uop_uopc                (_slots_10_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_10_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_10_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_10_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_10_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_10_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_10_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_10_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_10_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_10_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_10_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_10_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_10_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_10_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_10_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_10_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_10_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_10_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_10_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_10_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_10_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_10_io_uop_uopc),
    .io_uop_fu_code                 (_slots_10_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_10_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_10_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_10_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_10_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_10_io_uop_pdst),
    .io_uop_prs1                    (_slots_10_io_uop_prs1),
    .io_uop_prs2                    (_slots_10_io_uop_prs2),
    .io_uop_prs3                    (_slots_10_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_10_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_10_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_10_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_10_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_10_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_10_io_uop_fp_val)
  );
  IssueSlot slots_11 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_11_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_29),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_11_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_219 ? _slots_15_io_out_uop_uopc : _GEN_218 ? _slots_14_io_out_uop_uopc : _GEN_217 ? _slots_13_io_out_uop_uopc : _slots_12_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_219 ? _slots_15_io_out_uop_fu_code : _GEN_218 ? _slots_14_io_out_uop_fu_code : _GEN_217 ? _slots_13_io_out_uop_fu_code : _slots_12_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_219 ? _slots_15_io_out_uop_iw_state : _GEN_218 ? _slots_14_io_out_uop_iw_state : _GEN_217 ? _slots_13_io_out_uop_iw_state : _slots_12_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_219 ? _slots_15_io_out_uop_br_mask : _GEN_218 ? _slots_14_io_out_uop_br_mask : _GEN_217 ? _slots_13_io_out_uop_br_mask : _slots_12_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_219 ? _slots_15_io_out_uop_imm_packed : _GEN_218 ? _slots_14_io_out_uop_imm_packed : _GEN_217 ? _slots_13_io_out_uop_imm_packed : _slots_12_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_219 ? _slots_15_io_out_uop_rob_idx : _GEN_218 ? _slots_14_io_out_uop_rob_idx : _GEN_217 ? _slots_13_io_out_uop_rob_idx : _slots_12_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_219 ? _slots_15_io_out_uop_stq_idx : _GEN_218 ? _slots_14_io_out_uop_stq_idx : _GEN_217 ? _slots_13_io_out_uop_stq_idx : _slots_12_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_219 ? _slots_15_io_out_uop_pdst : _GEN_218 ? _slots_14_io_out_uop_pdst : _GEN_217 ? _slots_13_io_out_uop_pdst : _slots_12_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_219 ? _slots_15_io_out_uop_prs1 : _GEN_218 ? _slots_14_io_out_uop_prs1 : _GEN_217 ? _slots_13_io_out_uop_prs1 : _slots_12_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_219 ? _slots_15_io_out_uop_prs2 : _GEN_218 ? _slots_14_io_out_uop_prs2 : _GEN_217 ? _slots_13_io_out_uop_prs2 : _slots_12_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_219 ? _slots_15_io_out_uop_prs3 : _GEN_218 ? _slots_14_io_out_uop_prs3 : _GEN_217 ? _slots_13_io_out_uop_prs3 : _slots_12_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_219 ? _slots_15_io_out_uop_prs1_busy : _GEN_218 ? _slots_14_io_out_uop_prs1_busy : _GEN_217 ? _slots_13_io_out_uop_prs1_busy : _slots_12_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_219 ? _slots_15_io_out_uop_prs2_busy : _GEN_218 ? _slots_14_io_out_uop_prs2_busy : _GEN_217 ? _slots_13_io_out_uop_prs2_busy : _slots_12_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_219 ? _slots_15_io_out_uop_prs3_busy : _GEN_218 ? _slots_14_io_out_uop_prs3_busy : _GEN_217 ? _slots_13_io_out_uop_prs3_busy : _slots_12_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_219 ? _slots_15_io_out_uop_ppred_busy : _GEN_218 ? _slots_14_io_out_uop_ppred_busy : _GEN_217 ? _slots_13_io_out_uop_ppred_busy : _slots_12_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_219 ? _slots_15_io_out_uop_mem_cmd : _GEN_218 ? _slots_14_io_out_uop_mem_cmd : _GEN_217 ? _slots_13_io_out_uop_mem_cmd : _slots_12_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_219 ? _slots_15_io_out_uop_is_amo : _GEN_218 ? _slots_14_io_out_uop_is_amo : _GEN_217 ? _slots_13_io_out_uop_is_amo : _slots_12_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_219 ? _slots_15_io_out_uop_uses_ldq : _GEN_218 ? _slots_14_io_out_uop_uses_ldq : _GEN_217 ? _slots_13_io_out_uop_uses_ldq : _slots_12_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_219 ? _slots_15_io_out_uop_uses_stq : _GEN_218 ? _slots_14_io_out_uop_uses_stq : _GEN_217 ? _slots_13_io_out_uop_uses_stq : _slots_12_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_219 ? _slots_15_io_out_uop_dst_rtype : _GEN_218 ? _slots_14_io_out_uop_dst_rtype : _GEN_217 ? _slots_13_io_out_uop_dst_rtype : _slots_12_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_219 ? _slots_15_io_out_uop_fp_val : _GEN_218 ? _slots_14_io_out_uop_fp_val : _GEN_217 ? _slots_13_io_out_uop_fp_val : _slots_12_io_out_uop_fp_val),
    .io_valid                       (_slots_11_io_valid),
    .io_will_be_valid               (_slots_11_io_will_be_valid),
    .io_request                     (_slots_11_io_request),
    .io_out_uop_uopc                (_slots_11_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_11_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_11_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_11_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_11_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_11_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_11_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_11_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_11_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_11_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_11_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_11_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_11_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_11_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_11_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_11_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_11_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_11_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_11_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_11_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_11_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_11_io_uop_uopc),
    .io_uop_fu_code                 (_slots_11_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_11_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_11_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_11_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_11_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_11_io_uop_pdst),
    .io_uop_prs1                    (_slots_11_io_uop_prs1),
    .io_uop_prs2                    (_slots_11_io_uop_prs2),
    .io_uop_prs3                    (_slots_11_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_11_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_11_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_11_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_11_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_11_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_11_io_uop_fp_val)
  );
  IssueSlot slots_12 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_12_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_31),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_12_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_222 ? _slots_16_io_out_uop_uopc : _GEN_221 ? _slots_15_io_out_uop_uopc : _GEN_220 ? _slots_14_io_out_uop_uopc : _slots_13_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_222 ? _slots_16_io_out_uop_fu_code : _GEN_221 ? _slots_15_io_out_uop_fu_code : _GEN_220 ? _slots_14_io_out_uop_fu_code : _slots_13_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_222 ? _slots_16_io_out_uop_iw_state : _GEN_221 ? _slots_15_io_out_uop_iw_state : _GEN_220 ? _slots_14_io_out_uop_iw_state : _slots_13_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_222 ? _slots_16_io_out_uop_br_mask : _GEN_221 ? _slots_15_io_out_uop_br_mask : _GEN_220 ? _slots_14_io_out_uop_br_mask : _slots_13_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_222 ? _slots_16_io_out_uop_imm_packed : _GEN_221 ? _slots_15_io_out_uop_imm_packed : _GEN_220 ? _slots_14_io_out_uop_imm_packed : _slots_13_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_222 ? _slots_16_io_out_uop_rob_idx : _GEN_221 ? _slots_15_io_out_uop_rob_idx : _GEN_220 ? _slots_14_io_out_uop_rob_idx : _slots_13_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_222 ? _slots_16_io_out_uop_stq_idx : _GEN_221 ? _slots_15_io_out_uop_stq_idx : _GEN_220 ? _slots_14_io_out_uop_stq_idx : _slots_13_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_222 ? _slots_16_io_out_uop_pdst : _GEN_221 ? _slots_15_io_out_uop_pdst : _GEN_220 ? _slots_14_io_out_uop_pdst : _slots_13_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_222 ? _slots_16_io_out_uop_prs1 : _GEN_221 ? _slots_15_io_out_uop_prs1 : _GEN_220 ? _slots_14_io_out_uop_prs1 : _slots_13_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_222 ? _slots_16_io_out_uop_prs2 : _GEN_221 ? _slots_15_io_out_uop_prs2 : _GEN_220 ? _slots_14_io_out_uop_prs2 : _slots_13_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_222 ? _slots_16_io_out_uop_prs3 : _GEN_221 ? _slots_15_io_out_uop_prs3 : _GEN_220 ? _slots_14_io_out_uop_prs3 : _slots_13_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_222 ? _slots_16_io_out_uop_prs1_busy : _GEN_221 ? _slots_15_io_out_uop_prs1_busy : _GEN_220 ? _slots_14_io_out_uop_prs1_busy : _slots_13_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_222 ? _slots_16_io_out_uop_prs2_busy : _GEN_221 ? _slots_15_io_out_uop_prs2_busy : _GEN_220 ? _slots_14_io_out_uop_prs2_busy : _slots_13_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_222 ? _slots_16_io_out_uop_prs3_busy : _GEN_221 ? _slots_15_io_out_uop_prs3_busy : _GEN_220 ? _slots_14_io_out_uop_prs3_busy : _slots_13_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_222 ? _slots_16_io_out_uop_ppred_busy : _GEN_221 ? _slots_15_io_out_uop_ppred_busy : _GEN_220 ? _slots_14_io_out_uop_ppred_busy : _slots_13_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_222 ? _slots_16_io_out_uop_mem_cmd : _GEN_221 ? _slots_15_io_out_uop_mem_cmd : _GEN_220 ? _slots_14_io_out_uop_mem_cmd : _slots_13_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_222 ? _slots_16_io_out_uop_is_amo : _GEN_221 ? _slots_15_io_out_uop_is_amo : _GEN_220 ? _slots_14_io_out_uop_is_amo : _slots_13_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_222 ? _slots_16_io_out_uop_uses_ldq : _GEN_221 ? _slots_15_io_out_uop_uses_ldq : _GEN_220 ? _slots_14_io_out_uop_uses_ldq : _slots_13_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_222 ? _slots_16_io_out_uop_uses_stq : _GEN_221 ? _slots_15_io_out_uop_uses_stq : _GEN_220 ? _slots_14_io_out_uop_uses_stq : _slots_13_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_222 ? _slots_16_io_out_uop_dst_rtype : _GEN_221 ? _slots_15_io_out_uop_dst_rtype : _GEN_220 ? _slots_14_io_out_uop_dst_rtype : _slots_13_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_222 ? _slots_16_io_out_uop_fp_val : _GEN_221 ? _slots_15_io_out_uop_fp_val : _GEN_220 ? _slots_14_io_out_uop_fp_val : _slots_13_io_out_uop_fp_val),
    .io_valid                       (_slots_12_io_valid),
    .io_will_be_valid               (_slots_12_io_will_be_valid),
    .io_request                     (_slots_12_io_request),
    .io_out_uop_uopc                (_slots_12_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_12_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_12_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_12_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_12_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_12_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_12_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_12_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_12_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_12_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_12_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_12_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_12_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_12_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_12_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_12_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_12_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_12_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_12_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_12_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_12_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_12_io_uop_uopc),
    .io_uop_fu_code                 (_slots_12_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_12_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_12_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_12_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_12_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_12_io_uop_pdst),
    .io_uop_prs1                    (_slots_12_io_uop_prs1),
    .io_uop_prs2                    (_slots_12_io_uop_prs2),
    .io_uop_prs3                    (_slots_12_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_12_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_12_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_12_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_12_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_12_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_12_io_uop_fp_val)
  );
  IssueSlot slots_13 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_13_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_33),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_13_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_225 ? _slots_17_io_out_uop_uopc : _GEN_224 ? _slots_16_io_out_uop_uopc : _GEN_223 ? _slots_15_io_out_uop_uopc : _slots_14_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_225 ? _slots_17_io_out_uop_fu_code : _GEN_224 ? _slots_16_io_out_uop_fu_code : _GEN_223 ? _slots_15_io_out_uop_fu_code : _slots_14_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_225 ? _slots_17_io_out_uop_iw_state : _GEN_224 ? _slots_16_io_out_uop_iw_state : _GEN_223 ? _slots_15_io_out_uop_iw_state : _slots_14_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_225 ? _slots_17_io_out_uop_br_mask : _GEN_224 ? _slots_16_io_out_uop_br_mask : _GEN_223 ? _slots_15_io_out_uop_br_mask : _slots_14_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_225 ? _slots_17_io_out_uop_imm_packed : _GEN_224 ? _slots_16_io_out_uop_imm_packed : _GEN_223 ? _slots_15_io_out_uop_imm_packed : _slots_14_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_225 ? _slots_17_io_out_uop_rob_idx : _GEN_224 ? _slots_16_io_out_uop_rob_idx : _GEN_223 ? _slots_15_io_out_uop_rob_idx : _slots_14_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_225 ? _slots_17_io_out_uop_stq_idx : _GEN_224 ? _slots_16_io_out_uop_stq_idx : _GEN_223 ? _slots_15_io_out_uop_stq_idx : _slots_14_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_225 ? _slots_17_io_out_uop_pdst : _GEN_224 ? _slots_16_io_out_uop_pdst : _GEN_223 ? _slots_15_io_out_uop_pdst : _slots_14_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_225 ? _slots_17_io_out_uop_prs1 : _GEN_224 ? _slots_16_io_out_uop_prs1 : _GEN_223 ? _slots_15_io_out_uop_prs1 : _slots_14_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_225 ? _slots_17_io_out_uop_prs2 : _GEN_224 ? _slots_16_io_out_uop_prs2 : _GEN_223 ? _slots_15_io_out_uop_prs2 : _slots_14_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_225 ? _slots_17_io_out_uop_prs3 : _GEN_224 ? _slots_16_io_out_uop_prs3 : _GEN_223 ? _slots_15_io_out_uop_prs3 : _slots_14_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_225 ? _slots_17_io_out_uop_prs1_busy : _GEN_224 ? _slots_16_io_out_uop_prs1_busy : _GEN_223 ? _slots_15_io_out_uop_prs1_busy : _slots_14_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_225 ? _slots_17_io_out_uop_prs2_busy : _GEN_224 ? _slots_16_io_out_uop_prs2_busy : _GEN_223 ? _slots_15_io_out_uop_prs2_busy : _slots_14_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_225 ? _slots_17_io_out_uop_prs3_busy : _GEN_224 ? _slots_16_io_out_uop_prs3_busy : _GEN_223 ? _slots_15_io_out_uop_prs3_busy : _slots_14_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_225 ? _slots_17_io_out_uop_ppred_busy : _GEN_224 ? _slots_16_io_out_uop_ppred_busy : _GEN_223 ? _slots_15_io_out_uop_ppred_busy : _slots_14_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_225 ? _slots_17_io_out_uop_mem_cmd : _GEN_224 ? _slots_16_io_out_uop_mem_cmd : _GEN_223 ? _slots_15_io_out_uop_mem_cmd : _slots_14_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_225 ? _slots_17_io_out_uop_is_amo : _GEN_224 ? _slots_16_io_out_uop_is_amo : _GEN_223 ? _slots_15_io_out_uop_is_amo : _slots_14_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_225 ? _slots_17_io_out_uop_uses_ldq : _GEN_224 ? _slots_16_io_out_uop_uses_ldq : _GEN_223 ? _slots_15_io_out_uop_uses_ldq : _slots_14_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_225 ? _slots_17_io_out_uop_uses_stq : _GEN_224 ? _slots_16_io_out_uop_uses_stq : _GEN_223 ? _slots_15_io_out_uop_uses_stq : _slots_14_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_225 ? _slots_17_io_out_uop_dst_rtype : _GEN_224 ? _slots_16_io_out_uop_dst_rtype : _GEN_223 ? _slots_15_io_out_uop_dst_rtype : _slots_14_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_225 ? _slots_17_io_out_uop_fp_val : _GEN_224 ? _slots_16_io_out_uop_fp_val : _GEN_223 ? _slots_15_io_out_uop_fp_val : _slots_14_io_out_uop_fp_val),
    .io_valid                       (_slots_13_io_valid),
    .io_will_be_valid               (_slots_13_io_will_be_valid),
    .io_request                     (_slots_13_io_request),
    .io_out_uop_uopc                (_slots_13_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_13_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_13_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_13_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_13_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_13_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_13_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_13_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_13_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_13_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_13_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_13_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_13_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_13_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_13_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_13_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_13_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_13_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_13_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_13_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_13_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_13_io_uop_uopc),
    .io_uop_fu_code                 (_slots_13_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_13_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_13_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_13_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_13_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_13_io_uop_pdst),
    .io_uop_prs1                    (_slots_13_io_uop_prs1),
    .io_uop_prs2                    (_slots_13_io_uop_prs2),
    .io_uop_prs3                    (_slots_13_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_13_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_13_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_13_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_13_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_13_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_13_io_uop_fp_val)
  );
  IssueSlot slots_14 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_14_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_35),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_14_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_228 ? _slots_18_io_out_uop_uopc : _GEN_227 ? _slots_17_io_out_uop_uopc : _GEN_226 ? _slots_16_io_out_uop_uopc : _slots_15_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_228 ? _slots_18_io_out_uop_fu_code : _GEN_227 ? _slots_17_io_out_uop_fu_code : _GEN_226 ? _slots_16_io_out_uop_fu_code : _slots_15_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_228 ? _slots_18_io_out_uop_iw_state : _GEN_227 ? _slots_17_io_out_uop_iw_state : _GEN_226 ? _slots_16_io_out_uop_iw_state : _slots_15_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_228 ? _slots_18_io_out_uop_br_mask : _GEN_227 ? _slots_17_io_out_uop_br_mask : _GEN_226 ? _slots_16_io_out_uop_br_mask : _slots_15_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_228 ? _slots_18_io_out_uop_imm_packed : _GEN_227 ? _slots_17_io_out_uop_imm_packed : _GEN_226 ? _slots_16_io_out_uop_imm_packed : _slots_15_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_228 ? _slots_18_io_out_uop_rob_idx : _GEN_227 ? _slots_17_io_out_uop_rob_idx : _GEN_226 ? _slots_16_io_out_uop_rob_idx : _slots_15_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_228 ? _slots_18_io_out_uop_stq_idx : _GEN_227 ? _slots_17_io_out_uop_stq_idx : _GEN_226 ? _slots_16_io_out_uop_stq_idx : _slots_15_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_228 ? _slots_18_io_out_uop_pdst : _GEN_227 ? _slots_17_io_out_uop_pdst : _GEN_226 ? _slots_16_io_out_uop_pdst : _slots_15_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_228 ? _slots_18_io_out_uop_prs1 : _GEN_227 ? _slots_17_io_out_uop_prs1 : _GEN_226 ? _slots_16_io_out_uop_prs1 : _slots_15_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_228 ? _slots_18_io_out_uop_prs2 : _GEN_227 ? _slots_17_io_out_uop_prs2 : _GEN_226 ? _slots_16_io_out_uop_prs2 : _slots_15_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_228 ? _slots_18_io_out_uop_prs3 : _GEN_227 ? _slots_17_io_out_uop_prs3 : _GEN_226 ? _slots_16_io_out_uop_prs3 : _slots_15_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_228 ? _slots_18_io_out_uop_prs1_busy : _GEN_227 ? _slots_17_io_out_uop_prs1_busy : _GEN_226 ? _slots_16_io_out_uop_prs1_busy : _slots_15_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_228 ? _slots_18_io_out_uop_prs2_busy : _GEN_227 ? _slots_17_io_out_uop_prs2_busy : _GEN_226 ? _slots_16_io_out_uop_prs2_busy : _slots_15_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_228 ? _slots_18_io_out_uop_prs3_busy : _GEN_227 ? _slots_17_io_out_uop_prs3_busy : _GEN_226 ? _slots_16_io_out_uop_prs3_busy : _slots_15_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_228 ? _slots_18_io_out_uop_ppred_busy : _GEN_227 ? _slots_17_io_out_uop_ppred_busy : _GEN_226 ? _slots_16_io_out_uop_ppred_busy : _slots_15_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_228 ? _slots_18_io_out_uop_mem_cmd : _GEN_227 ? _slots_17_io_out_uop_mem_cmd : _GEN_226 ? _slots_16_io_out_uop_mem_cmd : _slots_15_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_228 ? _slots_18_io_out_uop_is_amo : _GEN_227 ? _slots_17_io_out_uop_is_amo : _GEN_226 ? _slots_16_io_out_uop_is_amo : _slots_15_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_228 ? _slots_18_io_out_uop_uses_ldq : _GEN_227 ? _slots_17_io_out_uop_uses_ldq : _GEN_226 ? _slots_16_io_out_uop_uses_ldq : _slots_15_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_228 ? _slots_18_io_out_uop_uses_stq : _GEN_227 ? _slots_17_io_out_uop_uses_stq : _GEN_226 ? _slots_16_io_out_uop_uses_stq : _slots_15_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_228 ? _slots_18_io_out_uop_dst_rtype : _GEN_227 ? _slots_17_io_out_uop_dst_rtype : _GEN_226 ? _slots_16_io_out_uop_dst_rtype : _slots_15_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_228 ? _slots_18_io_out_uop_fp_val : _GEN_227 ? _slots_17_io_out_uop_fp_val : _GEN_226 ? _slots_16_io_out_uop_fp_val : _slots_15_io_out_uop_fp_val),
    .io_valid                       (_slots_14_io_valid),
    .io_will_be_valid               (_slots_14_io_will_be_valid),
    .io_request                     (_slots_14_io_request),
    .io_out_uop_uopc                (_slots_14_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_14_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_14_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_14_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_14_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_14_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_14_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_14_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_14_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_14_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_14_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_14_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_14_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_14_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_14_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_14_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_14_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_14_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_14_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_14_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_14_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_14_io_uop_uopc),
    .io_uop_fu_code                 (_slots_14_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_14_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_14_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_14_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_14_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_14_io_uop_pdst),
    .io_uop_prs1                    (_slots_14_io_uop_prs1),
    .io_uop_prs2                    (_slots_14_io_uop_prs2),
    .io_uop_prs3                    (_slots_14_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_14_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_14_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_14_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_14_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_14_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_14_io_uop_fp_val)
  );
  IssueSlot slots_15 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_15_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_37),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_15_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_231 ? _slots_19_io_out_uop_uopc : _GEN_230 ? _slots_18_io_out_uop_uopc : _GEN_229 ? _slots_17_io_out_uop_uopc : _slots_16_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_231 ? _slots_19_io_out_uop_fu_code : _GEN_230 ? _slots_18_io_out_uop_fu_code : _GEN_229 ? _slots_17_io_out_uop_fu_code : _slots_16_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_231 ? _slots_19_io_out_uop_iw_state : _GEN_230 ? _slots_18_io_out_uop_iw_state : _GEN_229 ? _slots_17_io_out_uop_iw_state : _slots_16_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_231 ? _slots_19_io_out_uop_br_mask : _GEN_230 ? _slots_18_io_out_uop_br_mask : _GEN_229 ? _slots_17_io_out_uop_br_mask : _slots_16_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_231 ? _slots_19_io_out_uop_imm_packed : _GEN_230 ? _slots_18_io_out_uop_imm_packed : _GEN_229 ? _slots_17_io_out_uop_imm_packed : _slots_16_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_231 ? _slots_19_io_out_uop_rob_idx : _GEN_230 ? _slots_18_io_out_uop_rob_idx : _GEN_229 ? _slots_17_io_out_uop_rob_idx : _slots_16_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_231 ? _slots_19_io_out_uop_stq_idx : _GEN_230 ? _slots_18_io_out_uop_stq_idx : _GEN_229 ? _slots_17_io_out_uop_stq_idx : _slots_16_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_231 ? _slots_19_io_out_uop_pdst : _GEN_230 ? _slots_18_io_out_uop_pdst : _GEN_229 ? _slots_17_io_out_uop_pdst : _slots_16_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_231 ? _slots_19_io_out_uop_prs1 : _GEN_230 ? _slots_18_io_out_uop_prs1 : _GEN_229 ? _slots_17_io_out_uop_prs1 : _slots_16_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_231 ? _slots_19_io_out_uop_prs2 : _GEN_230 ? _slots_18_io_out_uop_prs2 : _GEN_229 ? _slots_17_io_out_uop_prs2 : _slots_16_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_231 ? _slots_19_io_out_uop_prs3 : _GEN_230 ? _slots_18_io_out_uop_prs3 : _GEN_229 ? _slots_17_io_out_uop_prs3 : _slots_16_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_231 ? _slots_19_io_out_uop_prs1_busy : _GEN_230 ? _slots_18_io_out_uop_prs1_busy : _GEN_229 ? _slots_17_io_out_uop_prs1_busy : _slots_16_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_231 ? _slots_19_io_out_uop_prs2_busy : _GEN_230 ? _slots_18_io_out_uop_prs2_busy : _GEN_229 ? _slots_17_io_out_uop_prs2_busy : _slots_16_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_231 ? _slots_19_io_out_uop_prs3_busy : _GEN_230 ? _slots_18_io_out_uop_prs3_busy : _GEN_229 ? _slots_17_io_out_uop_prs3_busy : _slots_16_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_231 ? _slots_19_io_out_uop_ppred_busy : _GEN_230 ? _slots_18_io_out_uop_ppred_busy : _GEN_229 ? _slots_17_io_out_uop_ppred_busy : _slots_16_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_231 ? _slots_19_io_out_uop_mem_cmd : _GEN_230 ? _slots_18_io_out_uop_mem_cmd : _GEN_229 ? _slots_17_io_out_uop_mem_cmd : _slots_16_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_231 ? _slots_19_io_out_uop_is_amo : _GEN_230 ? _slots_18_io_out_uop_is_amo : _GEN_229 ? _slots_17_io_out_uop_is_amo : _slots_16_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_231 ? _slots_19_io_out_uop_uses_ldq : _GEN_230 ? _slots_18_io_out_uop_uses_ldq : _GEN_229 ? _slots_17_io_out_uop_uses_ldq : _slots_16_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_231 ? _slots_19_io_out_uop_uses_stq : _GEN_230 ? _slots_18_io_out_uop_uses_stq : _GEN_229 ? _slots_17_io_out_uop_uses_stq : _slots_16_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_231 ? _slots_19_io_out_uop_dst_rtype : _GEN_230 ? _slots_18_io_out_uop_dst_rtype : _GEN_229 ? _slots_17_io_out_uop_dst_rtype : _slots_16_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_231 ? _slots_19_io_out_uop_fp_val : _GEN_230 ? _slots_18_io_out_uop_fp_val : _GEN_229 ? _slots_17_io_out_uop_fp_val : _slots_16_io_out_uop_fp_val),
    .io_valid                       (_slots_15_io_valid),
    .io_will_be_valid               (_slots_15_io_will_be_valid),
    .io_request                     (_slots_15_io_request),
    .io_out_uop_uopc                (_slots_15_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_15_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_15_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_15_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_15_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_15_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_15_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_15_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_15_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_15_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_15_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_15_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_15_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_15_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_15_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_15_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_15_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_15_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_15_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_15_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_15_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_15_io_uop_uopc),
    .io_uop_fu_code                 (_slots_15_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_15_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_15_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_15_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_15_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_15_io_uop_pdst),
    .io_uop_prs1                    (_slots_15_io_uop_prs1),
    .io_uop_prs2                    (_slots_15_io_uop_prs2),
    .io_uop_prs3                    (_slots_15_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_15_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_15_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_15_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_15_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_15_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_15_io_uop_fp_val)
  );
  IssueSlot slots_16 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_16_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_39),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_16_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_234 ? _slots_20_io_out_uop_uopc : _GEN_233 ? _slots_19_io_out_uop_uopc : _GEN_232 ? _slots_18_io_out_uop_uopc : _slots_17_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_234 ? _slots_20_io_out_uop_fu_code : _GEN_233 ? _slots_19_io_out_uop_fu_code : _GEN_232 ? _slots_18_io_out_uop_fu_code : _slots_17_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_234 ? _slots_20_io_out_uop_iw_state : _GEN_233 ? _slots_19_io_out_uop_iw_state : _GEN_232 ? _slots_18_io_out_uop_iw_state : _slots_17_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_234 ? _slots_20_io_out_uop_br_mask : _GEN_233 ? _slots_19_io_out_uop_br_mask : _GEN_232 ? _slots_18_io_out_uop_br_mask : _slots_17_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_234 ? _slots_20_io_out_uop_imm_packed : _GEN_233 ? _slots_19_io_out_uop_imm_packed : _GEN_232 ? _slots_18_io_out_uop_imm_packed : _slots_17_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_234 ? _slots_20_io_out_uop_rob_idx : _GEN_233 ? _slots_19_io_out_uop_rob_idx : _GEN_232 ? _slots_18_io_out_uop_rob_idx : _slots_17_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_234 ? _slots_20_io_out_uop_stq_idx : _GEN_233 ? _slots_19_io_out_uop_stq_idx : _GEN_232 ? _slots_18_io_out_uop_stq_idx : _slots_17_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_234 ? _slots_20_io_out_uop_pdst : _GEN_233 ? _slots_19_io_out_uop_pdst : _GEN_232 ? _slots_18_io_out_uop_pdst : _slots_17_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_234 ? _slots_20_io_out_uop_prs1 : _GEN_233 ? _slots_19_io_out_uop_prs1 : _GEN_232 ? _slots_18_io_out_uop_prs1 : _slots_17_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_234 ? _slots_20_io_out_uop_prs2 : _GEN_233 ? _slots_19_io_out_uop_prs2 : _GEN_232 ? _slots_18_io_out_uop_prs2 : _slots_17_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_234 ? _slots_20_io_out_uop_prs3 : _GEN_233 ? _slots_19_io_out_uop_prs3 : _GEN_232 ? _slots_18_io_out_uop_prs3 : _slots_17_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_234 ? _slots_20_io_out_uop_prs1_busy : _GEN_233 ? _slots_19_io_out_uop_prs1_busy : _GEN_232 ? _slots_18_io_out_uop_prs1_busy : _slots_17_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_234 ? _slots_20_io_out_uop_prs2_busy : _GEN_233 ? _slots_19_io_out_uop_prs2_busy : _GEN_232 ? _slots_18_io_out_uop_prs2_busy : _slots_17_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_234 ? _slots_20_io_out_uop_prs3_busy : _GEN_233 ? _slots_19_io_out_uop_prs3_busy : _GEN_232 ? _slots_18_io_out_uop_prs3_busy : _slots_17_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_234 ? _slots_20_io_out_uop_ppred_busy : _GEN_233 ? _slots_19_io_out_uop_ppred_busy : _GEN_232 ? _slots_18_io_out_uop_ppred_busy : _slots_17_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_234 ? _slots_20_io_out_uop_mem_cmd : _GEN_233 ? _slots_19_io_out_uop_mem_cmd : _GEN_232 ? _slots_18_io_out_uop_mem_cmd : _slots_17_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_234 ? _slots_20_io_out_uop_is_amo : _GEN_233 ? _slots_19_io_out_uop_is_amo : _GEN_232 ? _slots_18_io_out_uop_is_amo : _slots_17_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_234 ? _slots_20_io_out_uop_uses_ldq : _GEN_233 ? _slots_19_io_out_uop_uses_ldq : _GEN_232 ? _slots_18_io_out_uop_uses_ldq : _slots_17_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_234 ? _slots_20_io_out_uop_uses_stq : _GEN_233 ? _slots_19_io_out_uop_uses_stq : _GEN_232 ? _slots_18_io_out_uop_uses_stq : _slots_17_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_234 ? _slots_20_io_out_uop_dst_rtype : _GEN_233 ? _slots_19_io_out_uop_dst_rtype : _GEN_232 ? _slots_18_io_out_uop_dst_rtype : _slots_17_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_234 ? _slots_20_io_out_uop_fp_val : _GEN_233 ? _slots_19_io_out_uop_fp_val : _GEN_232 ? _slots_18_io_out_uop_fp_val : _slots_17_io_out_uop_fp_val),
    .io_valid                       (_slots_16_io_valid),
    .io_will_be_valid               (_slots_16_io_will_be_valid),
    .io_request                     (_slots_16_io_request),
    .io_out_uop_uopc                (_slots_16_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_16_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_16_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_16_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_16_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_16_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_16_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_16_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_16_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_16_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_16_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_16_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_16_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_16_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_16_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_16_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_16_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_16_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_16_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_16_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_16_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_16_io_uop_uopc),
    .io_uop_fu_code                 (_slots_16_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_16_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_16_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_16_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_16_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_16_io_uop_pdst),
    .io_uop_prs1                    (_slots_16_io_uop_prs1),
    .io_uop_prs2                    (_slots_16_io_uop_prs2),
    .io_uop_prs3                    (_slots_16_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_16_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_16_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_16_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_16_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_16_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_16_io_uop_fp_val)
  );
  IssueSlot slots_17 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_17_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_41),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_17_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_237 ? _slots_21_io_out_uop_uopc : _GEN_236 ? _slots_20_io_out_uop_uopc : _GEN_235 ? _slots_19_io_out_uop_uopc : _slots_18_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_237 ? _slots_21_io_out_uop_fu_code : _GEN_236 ? _slots_20_io_out_uop_fu_code : _GEN_235 ? _slots_19_io_out_uop_fu_code : _slots_18_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_237 ? _slots_21_io_out_uop_iw_state : _GEN_236 ? _slots_20_io_out_uop_iw_state : _GEN_235 ? _slots_19_io_out_uop_iw_state : _slots_18_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_237 ? _slots_21_io_out_uop_br_mask : _GEN_236 ? _slots_20_io_out_uop_br_mask : _GEN_235 ? _slots_19_io_out_uop_br_mask : _slots_18_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_237 ? _slots_21_io_out_uop_imm_packed : _GEN_236 ? _slots_20_io_out_uop_imm_packed : _GEN_235 ? _slots_19_io_out_uop_imm_packed : _slots_18_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_237 ? _slots_21_io_out_uop_rob_idx : _GEN_236 ? _slots_20_io_out_uop_rob_idx : _GEN_235 ? _slots_19_io_out_uop_rob_idx : _slots_18_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_237 ? _slots_21_io_out_uop_stq_idx : _GEN_236 ? _slots_20_io_out_uop_stq_idx : _GEN_235 ? _slots_19_io_out_uop_stq_idx : _slots_18_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_237 ? _slots_21_io_out_uop_pdst : _GEN_236 ? _slots_20_io_out_uop_pdst : _GEN_235 ? _slots_19_io_out_uop_pdst : _slots_18_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_237 ? _slots_21_io_out_uop_prs1 : _GEN_236 ? _slots_20_io_out_uop_prs1 : _GEN_235 ? _slots_19_io_out_uop_prs1 : _slots_18_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_237 ? _slots_21_io_out_uop_prs2 : _GEN_236 ? _slots_20_io_out_uop_prs2 : _GEN_235 ? _slots_19_io_out_uop_prs2 : _slots_18_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_237 ? _slots_21_io_out_uop_prs3 : _GEN_236 ? _slots_20_io_out_uop_prs3 : _GEN_235 ? _slots_19_io_out_uop_prs3 : _slots_18_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_237 ? _slots_21_io_out_uop_prs1_busy : _GEN_236 ? _slots_20_io_out_uop_prs1_busy : _GEN_235 ? _slots_19_io_out_uop_prs1_busy : _slots_18_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_237 ? _slots_21_io_out_uop_prs2_busy : _GEN_236 ? _slots_20_io_out_uop_prs2_busy : _GEN_235 ? _slots_19_io_out_uop_prs2_busy : _slots_18_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_237 ? _slots_21_io_out_uop_prs3_busy : _GEN_236 ? _slots_20_io_out_uop_prs3_busy : _GEN_235 ? _slots_19_io_out_uop_prs3_busy : _slots_18_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_237 ? _slots_21_io_out_uop_ppred_busy : _GEN_236 ? _slots_20_io_out_uop_ppred_busy : _GEN_235 ? _slots_19_io_out_uop_ppred_busy : _slots_18_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_237 ? _slots_21_io_out_uop_mem_cmd : _GEN_236 ? _slots_20_io_out_uop_mem_cmd : _GEN_235 ? _slots_19_io_out_uop_mem_cmd : _slots_18_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_237 ? _slots_21_io_out_uop_is_amo : _GEN_236 ? _slots_20_io_out_uop_is_amo : _GEN_235 ? _slots_19_io_out_uop_is_amo : _slots_18_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_237 ? _slots_21_io_out_uop_uses_ldq : _GEN_236 ? _slots_20_io_out_uop_uses_ldq : _GEN_235 ? _slots_19_io_out_uop_uses_ldq : _slots_18_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_237 ? _slots_21_io_out_uop_uses_stq : _GEN_236 ? _slots_20_io_out_uop_uses_stq : _GEN_235 ? _slots_19_io_out_uop_uses_stq : _slots_18_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_237 ? _slots_21_io_out_uop_dst_rtype : _GEN_236 ? _slots_20_io_out_uop_dst_rtype : _GEN_235 ? _slots_19_io_out_uop_dst_rtype : _slots_18_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_237 ? _slots_21_io_out_uop_fp_val : _GEN_236 ? _slots_20_io_out_uop_fp_val : _GEN_235 ? _slots_19_io_out_uop_fp_val : _slots_18_io_out_uop_fp_val),
    .io_valid                       (_slots_17_io_valid),
    .io_will_be_valid               (_slots_17_io_will_be_valid),
    .io_request                     (_slots_17_io_request),
    .io_out_uop_uopc                (_slots_17_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_17_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_17_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_17_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_17_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_17_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_17_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_17_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_17_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_17_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_17_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_17_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_17_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_17_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_17_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_17_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_17_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_17_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_17_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_17_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_17_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_17_io_uop_uopc),
    .io_uop_fu_code                 (_slots_17_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_17_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_17_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_17_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_17_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_17_io_uop_pdst),
    .io_uop_prs1                    (_slots_17_io_uop_prs1),
    .io_uop_prs2                    (_slots_17_io_uop_prs2),
    .io_uop_prs3                    (_slots_17_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_17_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_17_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_17_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_17_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_17_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_17_io_uop_fp_val)
  );
  IssueSlot slots_18 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_18_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_43),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_18_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_240 ? _slots_22_io_out_uop_uopc : _GEN_239 ? _slots_21_io_out_uop_uopc : _GEN_238 ? _slots_20_io_out_uop_uopc : _slots_19_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_240 ? _slots_22_io_out_uop_fu_code : _GEN_239 ? _slots_21_io_out_uop_fu_code : _GEN_238 ? _slots_20_io_out_uop_fu_code : _slots_19_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_240 ? _slots_22_io_out_uop_iw_state : _GEN_239 ? _slots_21_io_out_uop_iw_state : _GEN_238 ? _slots_20_io_out_uop_iw_state : _slots_19_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_240 ? _slots_22_io_out_uop_br_mask : _GEN_239 ? _slots_21_io_out_uop_br_mask : _GEN_238 ? _slots_20_io_out_uop_br_mask : _slots_19_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_240 ? _slots_22_io_out_uop_imm_packed : _GEN_239 ? _slots_21_io_out_uop_imm_packed : _GEN_238 ? _slots_20_io_out_uop_imm_packed : _slots_19_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_240 ? _slots_22_io_out_uop_rob_idx : _GEN_239 ? _slots_21_io_out_uop_rob_idx : _GEN_238 ? _slots_20_io_out_uop_rob_idx : _slots_19_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_240 ? _slots_22_io_out_uop_stq_idx : _GEN_239 ? _slots_21_io_out_uop_stq_idx : _GEN_238 ? _slots_20_io_out_uop_stq_idx : _slots_19_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_240 ? _slots_22_io_out_uop_pdst : _GEN_239 ? _slots_21_io_out_uop_pdst : _GEN_238 ? _slots_20_io_out_uop_pdst : _slots_19_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_240 ? _slots_22_io_out_uop_prs1 : _GEN_239 ? _slots_21_io_out_uop_prs1 : _GEN_238 ? _slots_20_io_out_uop_prs1 : _slots_19_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_240 ? _slots_22_io_out_uop_prs2 : _GEN_239 ? _slots_21_io_out_uop_prs2 : _GEN_238 ? _slots_20_io_out_uop_prs2 : _slots_19_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_240 ? _slots_22_io_out_uop_prs3 : _GEN_239 ? _slots_21_io_out_uop_prs3 : _GEN_238 ? _slots_20_io_out_uop_prs3 : _slots_19_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_240 ? _slots_22_io_out_uop_prs1_busy : _GEN_239 ? _slots_21_io_out_uop_prs1_busy : _GEN_238 ? _slots_20_io_out_uop_prs1_busy : _slots_19_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_240 ? _slots_22_io_out_uop_prs2_busy : _GEN_239 ? _slots_21_io_out_uop_prs2_busy : _GEN_238 ? _slots_20_io_out_uop_prs2_busy : _slots_19_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_240 ? _slots_22_io_out_uop_prs3_busy : _GEN_239 ? _slots_21_io_out_uop_prs3_busy : _GEN_238 ? _slots_20_io_out_uop_prs3_busy : _slots_19_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_240 ? _slots_22_io_out_uop_ppred_busy : _GEN_239 ? _slots_21_io_out_uop_ppred_busy : _GEN_238 ? _slots_20_io_out_uop_ppred_busy : _slots_19_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_240 ? _slots_22_io_out_uop_mem_cmd : _GEN_239 ? _slots_21_io_out_uop_mem_cmd : _GEN_238 ? _slots_20_io_out_uop_mem_cmd : _slots_19_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_240 ? _slots_22_io_out_uop_is_amo : _GEN_239 ? _slots_21_io_out_uop_is_amo : _GEN_238 ? _slots_20_io_out_uop_is_amo : _slots_19_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_240 ? _slots_22_io_out_uop_uses_ldq : _GEN_239 ? _slots_21_io_out_uop_uses_ldq : _GEN_238 ? _slots_20_io_out_uop_uses_ldq : _slots_19_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_240 ? _slots_22_io_out_uop_uses_stq : _GEN_239 ? _slots_21_io_out_uop_uses_stq : _GEN_238 ? _slots_20_io_out_uop_uses_stq : _slots_19_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_240 ? _slots_22_io_out_uop_dst_rtype : _GEN_239 ? _slots_21_io_out_uop_dst_rtype : _GEN_238 ? _slots_20_io_out_uop_dst_rtype : _slots_19_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_240 ? _slots_22_io_out_uop_fp_val : _GEN_239 ? _slots_21_io_out_uop_fp_val : _GEN_238 ? _slots_20_io_out_uop_fp_val : _slots_19_io_out_uop_fp_val),
    .io_valid                       (_slots_18_io_valid),
    .io_will_be_valid               (_slots_18_io_will_be_valid),
    .io_request                     (_slots_18_io_request),
    .io_out_uop_uopc                (_slots_18_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_18_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_18_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_18_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_18_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_18_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_18_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_18_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_18_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_18_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_18_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_18_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_18_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_18_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_18_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_18_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_18_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_18_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_18_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_18_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_18_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_18_io_uop_uopc),
    .io_uop_fu_code                 (_slots_18_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_18_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_18_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_18_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_18_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_18_io_uop_pdst),
    .io_uop_prs1                    (_slots_18_io_uop_prs1),
    .io_uop_prs2                    (_slots_18_io_uop_prs2),
    .io_uop_prs3                    (_slots_18_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_18_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_18_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_18_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_18_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_18_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_18_io_uop_fp_val)
  );
  IssueSlot slots_19 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_19_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_45),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_19_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_243 ? _slots_23_io_out_uop_uopc : _GEN_242 ? _slots_22_io_out_uop_uopc : _GEN_241 ? _slots_21_io_out_uop_uopc : _slots_20_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_243 ? _slots_23_io_out_uop_fu_code : _GEN_242 ? _slots_22_io_out_uop_fu_code : _GEN_241 ? _slots_21_io_out_uop_fu_code : _slots_20_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_243 ? _slots_23_io_out_uop_iw_state : _GEN_242 ? _slots_22_io_out_uop_iw_state : _GEN_241 ? _slots_21_io_out_uop_iw_state : _slots_20_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_243 ? _slots_23_io_out_uop_br_mask : _GEN_242 ? _slots_22_io_out_uop_br_mask : _GEN_241 ? _slots_21_io_out_uop_br_mask : _slots_20_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_243 ? _slots_23_io_out_uop_imm_packed : _GEN_242 ? _slots_22_io_out_uop_imm_packed : _GEN_241 ? _slots_21_io_out_uop_imm_packed : _slots_20_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_243 ? _slots_23_io_out_uop_rob_idx : _GEN_242 ? _slots_22_io_out_uop_rob_idx : _GEN_241 ? _slots_21_io_out_uop_rob_idx : _slots_20_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_243 ? _slots_23_io_out_uop_stq_idx : _GEN_242 ? _slots_22_io_out_uop_stq_idx : _GEN_241 ? _slots_21_io_out_uop_stq_idx : _slots_20_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_243 ? _slots_23_io_out_uop_pdst : _GEN_242 ? _slots_22_io_out_uop_pdst : _GEN_241 ? _slots_21_io_out_uop_pdst : _slots_20_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_243 ? _slots_23_io_out_uop_prs1 : _GEN_242 ? _slots_22_io_out_uop_prs1 : _GEN_241 ? _slots_21_io_out_uop_prs1 : _slots_20_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_243 ? _slots_23_io_out_uop_prs2 : _GEN_242 ? _slots_22_io_out_uop_prs2 : _GEN_241 ? _slots_21_io_out_uop_prs2 : _slots_20_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_243 ? _slots_23_io_out_uop_prs3 : _GEN_242 ? _slots_22_io_out_uop_prs3 : _GEN_241 ? _slots_21_io_out_uop_prs3 : _slots_20_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_243 ? _slots_23_io_out_uop_prs1_busy : _GEN_242 ? _slots_22_io_out_uop_prs1_busy : _GEN_241 ? _slots_21_io_out_uop_prs1_busy : _slots_20_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_243 ? _slots_23_io_out_uop_prs2_busy : _GEN_242 ? _slots_22_io_out_uop_prs2_busy : _GEN_241 ? _slots_21_io_out_uop_prs2_busy : _slots_20_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_243 ? _slots_23_io_out_uop_prs3_busy : _GEN_242 ? _slots_22_io_out_uop_prs3_busy : _GEN_241 ? _slots_21_io_out_uop_prs3_busy : _slots_20_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_243 ? _slots_23_io_out_uop_ppred_busy : _GEN_242 ? _slots_22_io_out_uop_ppred_busy : _GEN_241 ? _slots_21_io_out_uop_ppred_busy : _slots_20_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_243 ? _slots_23_io_out_uop_mem_cmd : _GEN_242 ? _slots_22_io_out_uop_mem_cmd : _GEN_241 ? _slots_21_io_out_uop_mem_cmd : _slots_20_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_243 ? _slots_23_io_out_uop_is_amo : _GEN_242 ? _slots_22_io_out_uop_is_amo : _GEN_241 ? _slots_21_io_out_uop_is_amo : _slots_20_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_243 ? _slots_23_io_out_uop_uses_ldq : _GEN_242 ? _slots_22_io_out_uop_uses_ldq : _GEN_241 ? _slots_21_io_out_uop_uses_ldq : _slots_20_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_243 ? _slots_23_io_out_uop_uses_stq : _GEN_242 ? _slots_22_io_out_uop_uses_stq : _GEN_241 ? _slots_21_io_out_uop_uses_stq : _slots_20_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_243 ? _slots_23_io_out_uop_dst_rtype : _GEN_242 ? _slots_22_io_out_uop_dst_rtype : _GEN_241 ? _slots_21_io_out_uop_dst_rtype : _slots_20_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_243 ? _slots_23_io_out_uop_fp_val : _GEN_242 ? _slots_22_io_out_uop_fp_val : _GEN_241 ? _slots_21_io_out_uop_fp_val : _slots_20_io_out_uop_fp_val),
    .io_valid                       (_slots_19_io_valid),
    .io_will_be_valid               (_slots_19_io_will_be_valid),
    .io_request                     (_slots_19_io_request),
    .io_out_uop_uopc                (_slots_19_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_19_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_19_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_19_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_19_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_19_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_19_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_19_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_19_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_19_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_19_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_19_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_19_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_19_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_19_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_19_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_19_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_19_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_19_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_19_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_19_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_19_io_uop_uopc),
    .io_uop_fu_code                 (_slots_19_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_19_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_19_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_19_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_19_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_19_io_uop_pdst),
    .io_uop_prs1                    (_slots_19_io_uop_prs1),
    .io_uop_prs2                    (_slots_19_io_uop_prs2),
    .io_uop_prs3                    (_slots_19_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_19_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_19_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_19_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_19_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_19_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_19_io_uop_fp_val)
  );
  IssueSlot slots_20 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_20_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_47),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_20_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_246 ? _slots_24_io_out_uop_uopc : _GEN_245 ? _slots_23_io_out_uop_uopc : _GEN_244 ? _slots_22_io_out_uop_uopc : _slots_21_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_246 ? _slots_24_io_out_uop_fu_code : _GEN_245 ? _slots_23_io_out_uop_fu_code : _GEN_244 ? _slots_22_io_out_uop_fu_code : _slots_21_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_246 ? _slots_24_io_out_uop_iw_state : _GEN_245 ? _slots_23_io_out_uop_iw_state : _GEN_244 ? _slots_22_io_out_uop_iw_state : _slots_21_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_246 ? _slots_24_io_out_uop_br_mask : _GEN_245 ? _slots_23_io_out_uop_br_mask : _GEN_244 ? _slots_22_io_out_uop_br_mask : _slots_21_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_246 ? _slots_24_io_out_uop_imm_packed : _GEN_245 ? _slots_23_io_out_uop_imm_packed : _GEN_244 ? _slots_22_io_out_uop_imm_packed : _slots_21_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_246 ? _slots_24_io_out_uop_rob_idx : _GEN_245 ? _slots_23_io_out_uop_rob_idx : _GEN_244 ? _slots_22_io_out_uop_rob_idx : _slots_21_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_246 ? _slots_24_io_out_uop_stq_idx : _GEN_245 ? _slots_23_io_out_uop_stq_idx : _GEN_244 ? _slots_22_io_out_uop_stq_idx : _slots_21_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_246 ? _slots_24_io_out_uop_pdst : _GEN_245 ? _slots_23_io_out_uop_pdst : _GEN_244 ? _slots_22_io_out_uop_pdst : _slots_21_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_246 ? _slots_24_io_out_uop_prs1 : _GEN_245 ? _slots_23_io_out_uop_prs1 : _GEN_244 ? _slots_22_io_out_uop_prs1 : _slots_21_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_246 ? _slots_24_io_out_uop_prs2 : _GEN_245 ? _slots_23_io_out_uop_prs2 : _GEN_244 ? _slots_22_io_out_uop_prs2 : _slots_21_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_246 ? _slots_24_io_out_uop_prs3 : _GEN_245 ? _slots_23_io_out_uop_prs3 : _GEN_244 ? _slots_22_io_out_uop_prs3 : _slots_21_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_246 ? _slots_24_io_out_uop_prs1_busy : _GEN_245 ? _slots_23_io_out_uop_prs1_busy : _GEN_244 ? _slots_22_io_out_uop_prs1_busy : _slots_21_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_246 ? _slots_24_io_out_uop_prs2_busy : _GEN_245 ? _slots_23_io_out_uop_prs2_busy : _GEN_244 ? _slots_22_io_out_uop_prs2_busy : _slots_21_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_246 ? _slots_24_io_out_uop_prs3_busy : _GEN_245 ? _slots_23_io_out_uop_prs3_busy : _GEN_244 ? _slots_22_io_out_uop_prs3_busy : _slots_21_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_246 ? _slots_24_io_out_uop_ppred_busy : _GEN_245 ? _slots_23_io_out_uop_ppred_busy : _GEN_244 ? _slots_22_io_out_uop_ppred_busy : _slots_21_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_246 ? _slots_24_io_out_uop_mem_cmd : _GEN_245 ? _slots_23_io_out_uop_mem_cmd : _GEN_244 ? _slots_22_io_out_uop_mem_cmd : _slots_21_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_246 ? _slots_24_io_out_uop_is_amo : _GEN_245 ? _slots_23_io_out_uop_is_amo : _GEN_244 ? _slots_22_io_out_uop_is_amo : _slots_21_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_246 ? _slots_24_io_out_uop_uses_ldq : _GEN_245 ? _slots_23_io_out_uop_uses_ldq : _GEN_244 ? _slots_22_io_out_uop_uses_ldq : _slots_21_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_246 ? _slots_24_io_out_uop_uses_stq : _GEN_245 ? _slots_23_io_out_uop_uses_stq : _GEN_244 ? _slots_22_io_out_uop_uses_stq : _slots_21_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_246 ? _slots_24_io_out_uop_dst_rtype : _GEN_245 ? _slots_23_io_out_uop_dst_rtype : _GEN_244 ? _slots_22_io_out_uop_dst_rtype : _slots_21_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_246 ? _slots_24_io_out_uop_fp_val : _GEN_245 ? _slots_23_io_out_uop_fp_val : _GEN_244 ? _slots_22_io_out_uop_fp_val : _slots_21_io_out_uop_fp_val),
    .io_valid                       (_slots_20_io_valid),
    .io_will_be_valid               (_slots_20_io_will_be_valid),
    .io_request                     (_slots_20_io_request),
    .io_out_uop_uopc                (_slots_20_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_20_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_20_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_20_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_20_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_20_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_20_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_20_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_20_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_20_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_20_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_20_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_20_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_20_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_20_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_20_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_20_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_20_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_20_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_20_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_20_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_20_io_uop_uopc),
    .io_uop_fu_code                 (_slots_20_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_20_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_20_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_20_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_20_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_20_io_uop_pdst),
    .io_uop_prs1                    (_slots_20_io_uop_prs1),
    .io_uop_prs2                    (_slots_20_io_uop_prs2),
    .io_uop_prs3                    (_slots_20_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_20_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_20_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_20_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_20_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_20_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_20_io_uop_fp_val)
  );
  IssueSlot slots_21 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_21_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_49),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_21_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_249 ? _slots_25_io_out_uop_uopc : _GEN_248 ? _slots_24_io_out_uop_uopc : _GEN_247 ? _slots_23_io_out_uop_uopc : _slots_22_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_249 ? _slots_25_io_out_uop_fu_code : _GEN_248 ? _slots_24_io_out_uop_fu_code : _GEN_247 ? _slots_23_io_out_uop_fu_code : _slots_22_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_249 ? _slots_25_io_out_uop_iw_state : _GEN_248 ? _slots_24_io_out_uop_iw_state : _GEN_247 ? _slots_23_io_out_uop_iw_state : _slots_22_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_249 ? _slots_25_io_out_uop_br_mask : _GEN_248 ? _slots_24_io_out_uop_br_mask : _GEN_247 ? _slots_23_io_out_uop_br_mask : _slots_22_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_249 ? _slots_25_io_out_uop_imm_packed : _GEN_248 ? _slots_24_io_out_uop_imm_packed : _GEN_247 ? _slots_23_io_out_uop_imm_packed : _slots_22_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_249 ? _slots_25_io_out_uop_rob_idx : _GEN_248 ? _slots_24_io_out_uop_rob_idx : _GEN_247 ? _slots_23_io_out_uop_rob_idx : _slots_22_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_249 ? _slots_25_io_out_uop_stq_idx : _GEN_248 ? _slots_24_io_out_uop_stq_idx : _GEN_247 ? _slots_23_io_out_uop_stq_idx : _slots_22_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_249 ? _slots_25_io_out_uop_pdst : _GEN_248 ? _slots_24_io_out_uop_pdst : _GEN_247 ? _slots_23_io_out_uop_pdst : _slots_22_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_249 ? _slots_25_io_out_uop_prs1 : _GEN_248 ? _slots_24_io_out_uop_prs1 : _GEN_247 ? _slots_23_io_out_uop_prs1 : _slots_22_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_249 ? _slots_25_io_out_uop_prs2 : _GEN_248 ? _slots_24_io_out_uop_prs2 : _GEN_247 ? _slots_23_io_out_uop_prs2 : _slots_22_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_249 ? _slots_25_io_out_uop_prs3 : _GEN_248 ? _slots_24_io_out_uop_prs3 : _GEN_247 ? _slots_23_io_out_uop_prs3 : _slots_22_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_249 ? _slots_25_io_out_uop_prs1_busy : _GEN_248 ? _slots_24_io_out_uop_prs1_busy : _GEN_247 ? _slots_23_io_out_uop_prs1_busy : _slots_22_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_249 ? _slots_25_io_out_uop_prs2_busy : _GEN_248 ? _slots_24_io_out_uop_prs2_busy : _GEN_247 ? _slots_23_io_out_uop_prs2_busy : _slots_22_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_249 ? _slots_25_io_out_uop_prs3_busy : _GEN_248 ? _slots_24_io_out_uop_prs3_busy : _GEN_247 ? _slots_23_io_out_uop_prs3_busy : _slots_22_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_249 ? _slots_25_io_out_uop_ppred_busy : _GEN_248 ? _slots_24_io_out_uop_ppred_busy : _GEN_247 ? _slots_23_io_out_uop_ppred_busy : _slots_22_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_249 ? _slots_25_io_out_uop_mem_cmd : _GEN_248 ? _slots_24_io_out_uop_mem_cmd : _GEN_247 ? _slots_23_io_out_uop_mem_cmd : _slots_22_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_249 ? _slots_25_io_out_uop_is_amo : _GEN_248 ? _slots_24_io_out_uop_is_amo : _GEN_247 ? _slots_23_io_out_uop_is_amo : _slots_22_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_249 ? _slots_25_io_out_uop_uses_ldq : _GEN_248 ? _slots_24_io_out_uop_uses_ldq : _GEN_247 ? _slots_23_io_out_uop_uses_ldq : _slots_22_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_249 ? _slots_25_io_out_uop_uses_stq : _GEN_248 ? _slots_24_io_out_uop_uses_stq : _GEN_247 ? _slots_23_io_out_uop_uses_stq : _slots_22_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_249 ? _slots_25_io_out_uop_dst_rtype : _GEN_248 ? _slots_24_io_out_uop_dst_rtype : _GEN_247 ? _slots_23_io_out_uop_dst_rtype : _slots_22_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_249 ? _slots_25_io_out_uop_fp_val : _GEN_248 ? _slots_24_io_out_uop_fp_val : _GEN_247 ? _slots_23_io_out_uop_fp_val : _slots_22_io_out_uop_fp_val),
    .io_valid                       (_slots_21_io_valid),
    .io_will_be_valid               (_slots_21_io_will_be_valid),
    .io_request                     (_slots_21_io_request),
    .io_out_uop_uopc                (_slots_21_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_21_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_21_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_21_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_21_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_21_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_21_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_21_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_21_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_21_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_21_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_21_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_21_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_21_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_21_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_21_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_21_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_21_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_21_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_21_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_21_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_21_io_uop_uopc),
    .io_uop_fu_code                 (_slots_21_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_21_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_21_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_21_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_21_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_21_io_uop_pdst),
    .io_uop_prs1                    (_slots_21_io_uop_prs1),
    .io_uop_prs2                    (_slots_21_io_uop_prs2),
    .io_uop_prs3                    (_slots_21_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_21_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_21_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_21_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_21_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_21_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_21_io_uop_fp_val)
  );
  IssueSlot slots_22 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_22_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_51),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_22_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_252 ? _slots_26_io_out_uop_uopc : _GEN_251 ? _slots_25_io_out_uop_uopc : _GEN_250 ? _slots_24_io_out_uop_uopc : _slots_23_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_252 ? _slots_26_io_out_uop_fu_code : _GEN_251 ? _slots_25_io_out_uop_fu_code : _GEN_250 ? _slots_24_io_out_uop_fu_code : _slots_23_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_252 ? _slots_26_io_out_uop_iw_state : _GEN_251 ? _slots_25_io_out_uop_iw_state : _GEN_250 ? _slots_24_io_out_uop_iw_state : _slots_23_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_252 ? _slots_26_io_out_uop_br_mask : _GEN_251 ? _slots_25_io_out_uop_br_mask : _GEN_250 ? _slots_24_io_out_uop_br_mask : _slots_23_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_252 ? _slots_26_io_out_uop_imm_packed : _GEN_251 ? _slots_25_io_out_uop_imm_packed : _GEN_250 ? _slots_24_io_out_uop_imm_packed : _slots_23_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_252 ? _slots_26_io_out_uop_rob_idx : _GEN_251 ? _slots_25_io_out_uop_rob_idx : _GEN_250 ? _slots_24_io_out_uop_rob_idx : _slots_23_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_252 ? _slots_26_io_out_uop_stq_idx : _GEN_251 ? _slots_25_io_out_uop_stq_idx : _GEN_250 ? _slots_24_io_out_uop_stq_idx : _slots_23_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_252 ? _slots_26_io_out_uop_pdst : _GEN_251 ? _slots_25_io_out_uop_pdst : _GEN_250 ? _slots_24_io_out_uop_pdst : _slots_23_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_252 ? _slots_26_io_out_uop_prs1 : _GEN_251 ? _slots_25_io_out_uop_prs1 : _GEN_250 ? _slots_24_io_out_uop_prs1 : _slots_23_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_252 ? _slots_26_io_out_uop_prs2 : _GEN_251 ? _slots_25_io_out_uop_prs2 : _GEN_250 ? _slots_24_io_out_uop_prs2 : _slots_23_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_252 ? _slots_26_io_out_uop_prs3 : _GEN_251 ? _slots_25_io_out_uop_prs3 : _GEN_250 ? _slots_24_io_out_uop_prs3 : _slots_23_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_252 ? _slots_26_io_out_uop_prs1_busy : _GEN_251 ? _slots_25_io_out_uop_prs1_busy : _GEN_250 ? _slots_24_io_out_uop_prs1_busy : _slots_23_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_252 ? _slots_26_io_out_uop_prs2_busy : _GEN_251 ? _slots_25_io_out_uop_prs2_busy : _GEN_250 ? _slots_24_io_out_uop_prs2_busy : _slots_23_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_252 ? _slots_26_io_out_uop_prs3_busy : _GEN_251 ? _slots_25_io_out_uop_prs3_busy : _GEN_250 ? _slots_24_io_out_uop_prs3_busy : _slots_23_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_252 ? _slots_26_io_out_uop_ppred_busy : _GEN_251 ? _slots_25_io_out_uop_ppred_busy : _GEN_250 ? _slots_24_io_out_uop_ppred_busy : _slots_23_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_252 ? _slots_26_io_out_uop_mem_cmd : _GEN_251 ? _slots_25_io_out_uop_mem_cmd : _GEN_250 ? _slots_24_io_out_uop_mem_cmd : _slots_23_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_252 ? _slots_26_io_out_uop_is_amo : _GEN_251 ? _slots_25_io_out_uop_is_amo : _GEN_250 ? _slots_24_io_out_uop_is_amo : _slots_23_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_252 ? _slots_26_io_out_uop_uses_ldq : _GEN_251 ? _slots_25_io_out_uop_uses_ldq : _GEN_250 ? _slots_24_io_out_uop_uses_ldq : _slots_23_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_252 ? _slots_26_io_out_uop_uses_stq : _GEN_251 ? _slots_25_io_out_uop_uses_stq : _GEN_250 ? _slots_24_io_out_uop_uses_stq : _slots_23_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_252 ? _slots_26_io_out_uop_dst_rtype : _GEN_251 ? _slots_25_io_out_uop_dst_rtype : _GEN_250 ? _slots_24_io_out_uop_dst_rtype : _slots_23_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_252 ? _slots_26_io_out_uop_fp_val : _GEN_251 ? _slots_25_io_out_uop_fp_val : _GEN_250 ? _slots_24_io_out_uop_fp_val : _slots_23_io_out_uop_fp_val),
    .io_valid                       (_slots_22_io_valid),
    .io_will_be_valid               (_slots_22_io_will_be_valid),
    .io_request                     (_slots_22_io_request),
    .io_out_uop_uopc                (_slots_22_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_22_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_22_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_22_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_22_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_22_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_22_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_22_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_22_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_22_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_22_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_22_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_22_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_22_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_22_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_22_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_22_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_22_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_22_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_22_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_22_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_22_io_uop_uopc),
    .io_uop_fu_code                 (_slots_22_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_22_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_22_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_22_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_22_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_22_io_uop_pdst),
    .io_uop_prs1                    (_slots_22_io_uop_prs1),
    .io_uop_prs2                    (_slots_22_io_uop_prs2),
    .io_uop_prs3                    (_slots_22_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_22_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_22_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_22_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_22_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_22_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_22_io_uop_fp_val)
  );
  IssueSlot slots_23 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_23_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_53),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_23_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_255 ? _slots_27_io_out_uop_uopc : _GEN_254 ? _slots_26_io_out_uop_uopc : _GEN_253 ? _slots_25_io_out_uop_uopc : _slots_24_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_255 ? _slots_27_io_out_uop_fu_code : _GEN_254 ? _slots_26_io_out_uop_fu_code : _GEN_253 ? _slots_25_io_out_uop_fu_code : _slots_24_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_255 ? _slots_27_io_out_uop_iw_state : _GEN_254 ? _slots_26_io_out_uop_iw_state : _GEN_253 ? _slots_25_io_out_uop_iw_state : _slots_24_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_255 ? _slots_27_io_out_uop_br_mask : _GEN_254 ? _slots_26_io_out_uop_br_mask : _GEN_253 ? _slots_25_io_out_uop_br_mask : _slots_24_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_255 ? _slots_27_io_out_uop_imm_packed : _GEN_254 ? _slots_26_io_out_uop_imm_packed : _GEN_253 ? _slots_25_io_out_uop_imm_packed : _slots_24_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_255 ? _slots_27_io_out_uop_rob_idx : _GEN_254 ? _slots_26_io_out_uop_rob_idx : _GEN_253 ? _slots_25_io_out_uop_rob_idx : _slots_24_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_255 ? _slots_27_io_out_uop_stq_idx : _GEN_254 ? _slots_26_io_out_uop_stq_idx : _GEN_253 ? _slots_25_io_out_uop_stq_idx : _slots_24_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_255 ? _slots_27_io_out_uop_pdst : _GEN_254 ? _slots_26_io_out_uop_pdst : _GEN_253 ? _slots_25_io_out_uop_pdst : _slots_24_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_255 ? _slots_27_io_out_uop_prs1 : _GEN_254 ? _slots_26_io_out_uop_prs1 : _GEN_253 ? _slots_25_io_out_uop_prs1 : _slots_24_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_255 ? _slots_27_io_out_uop_prs2 : _GEN_254 ? _slots_26_io_out_uop_prs2 : _GEN_253 ? _slots_25_io_out_uop_prs2 : _slots_24_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_255 ? _slots_27_io_out_uop_prs3 : _GEN_254 ? _slots_26_io_out_uop_prs3 : _GEN_253 ? _slots_25_io_out_uop_prs3 : _slots_24_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_255 ? _slots_27_io_out_uop_prs1_busy : _GEN_254 ? _slots_26_io_out_uop_prs1_busy : _GEN_253 ? _slots_25_io_out_uop_prs1_busy : _slots_24_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_255 ? _slots_27_io_out_uop_prs2_busy : _GEN_254 ? _slots_26_io_out_uop_prs2_busy : _GEN_253 ? _slots_25_io_out_uop_prs2_busy : _slots_24_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_255 ? _slots_27_io_out_uop_prs3_busy : _GEN_254 ? _slots_26_io_out_uop_prs3_busy : _GEN_253 ? _slots_25_io_out_uop_prs3_busy : _slots_24_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_255 ? _slots_27_io_out_uop_ppred_busy : _GEN_254 ? _slots_26_io_out_uop_ppred_busy : _GEN_253 ? _slots_25_io_out_uop_ppred_busy : _slots_24_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_255 ? _slots_27_io_out_uop_mem_cmd : _GEN_254 ? _slots_26_io_out_uop_mem_cmd : _GEN_253 ? _slots_25_io_out_uop_mem_cmd : _slots_24_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_255 ? _slots_27_io_out_uop_is_amo : _GEN_254 ? _slots_26_io_out_uop_is_amo : _GEN_253 ? _slots_25_io_out_uop_is_amo : _slots_24_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_255 ? _slots_27_io_out_uop_uses_ldq : _GEN_254 ? _slots_26_io_out_uop_uses_ldq : _GEN_253 ? _slots_25_io_out_uop_uses_ldq : _slots_24_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_255 ? _slots_27_io_out_uop_uses_stq : _GEN_254 ? _slots_26_io_out_uop_uses_stq : _GEN_253 ? _slots_25_io_out_uop_uses_stq : _slots_24_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_255 ? _slots_27_io_out_uop_dst_rtype : _GEN_254 ? _slots_26_io_out_uop_dst_rtype : _GEN_253 ? _slots_25_io_out_uop_dst_rtype : _slots_24_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_255 ? _slots_27_io_out_uop_fp_val : _GEN_254 ? _slots_26_io_out_uop_fp_val : _GEN_253 ? _slots_25_io_out_uop_fp_val : _slots_24_io_out_uop_fp_val),
    .io_valid                       (_slots_23_io_valid),
    .io_will_be_valid               (_slots_23_io_will_be_valid),
    .io_request                     (_slots_23_io_request),
    .io_out_uop_uopc                (_slots_23_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_23_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_23_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_23_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_23_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_23_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_23_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_23_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_23_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_23_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_23_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_23_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_23_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_23_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_23_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_23_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_23_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_23_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_23_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_23_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_23_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_23_io_uop_uopc),
    .io_uop_fu_code                 (_slots_23_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_23_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_23_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_23_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_23_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_23_io_uop_pdst),
    .io_uop_prs1                    (_slots_23_io_uop_prs1),
    .io_uop_prs2                    (_slots_23_io_uop_prs2),
    .io_uop_prs3                    (_slots_23_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_23_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_23_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_23_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_23_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_23_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_23_io_uop_fp_val)
  );
  IssueSlot slots_24 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_24_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_55),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_24_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_258 ? _slots_28_io_out_uop_uopc : _GEN_257 ? _slots_27_io_out_uop_uopc : _GEN_256 ? _slots_26_io_out_uop_uopc : _slots_25_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_258 ? _slots_28_io_out_uop_fu_code : _GEN_257 ? _slots_27_io_out_uop_fu_code : _GEN_256 ? _slots_26_io_out_uop_fu_code : _slots_25_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_258 ? _slots_28_io_out_uop_iw_state : _GEN_257 ? _slots_27_io_out_uop_iw_state : _GEN_256 ? _slots_26_io_out_uop_iw_state : _slots_25_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_258 ? _slots_28_io_out_uop_br_mask : _GEN_257 ? _slots_27_io_out_uop_br_mask : _GEN_256 ? _slots_26_io_out_uop_br_mask : _slots_25_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_258 ? _slots_28_io_out_uop_imm_packed : _GEN_257 ? _slots_27_io_out_uop_imm_packed : _GEN_256 ? _slots_26_io_out_uop_imm_packed : _slots_25_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_258 ? _slots_28_io_out_uop_rob_idx : _GEN_257 ? _slots_27_io_out_uop_rob_idx : _GEN_256 ? _slots_26_io_out_uop_rob_idx : _slots_25_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_258 ? _slots_28_io_out_uop_stq_idx : _GEN_257 ? _slots_27_io_out_uop_stq_idx : _GEN_256 ? _slots_26_io_out_uop_stq_idx : _slots_25_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_258 ? _slots_28_io_out_uop_pdst : _GEN_257 ? _slots_27_io_out_uop_pdst : _GEN_256 ? _slots_26_io_out_uop_pdst : _slots_25_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_258 ? _slots_28_io_out_uop_prs1 : _GEN_257 ? _slots_27_io_out_uop_prs1 : _GEN_256 ? _slots_26_io_out_uop_prs1 : _slots_25_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_258 ? _slots_28_io_out_uop_prs2 : _GEN_257 ? _slots_27_io_out_uop_prs2 : _GEN_256 ? _slots_26_io_out_uop_prs2 : _slots_25_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_258 ? _slots_28_io_out_uop_prs3 : _GEN_257 ? _slots_27_io_out_uop_prs3 : _GEN_256 ? _slots_26_io_out_uop_prs3 : _slots_25_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_258 ? _slots_28_io_out_uop_prs1_busy : _GEN_257 ? _slots_27_io_out_uop_prs1_busy : _GEN_256 ? _slots_26_io_out_uop_prs1_busy : _slots_25_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_258 ? _slots_28_io_out_uop_prs2_busy : _GEN_257 ? _slots_27_io_out_uop_prs2_busy : _GEN_256 ? _slots_26_io_out_uop_prs2_busy : _slots_25_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_258 ? _slots_28_io_out_uop_prs3_busy : _GEN_257 ? _slots_27_io_out_uop_prs3_busy : _GEN_256 ? _slots_26_io_out_uop_prs3_busy : _slots_25_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_258 ? _slots_28_io_out_uop_ppred_busy : _GEN_257 ? _slots_27_io_out_uop_ppred_busy : _GEN_256 ? _slots_26_io_out_uop_ppred_busy : _slots_25_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_258 ? _slots_28_io_out_uop_mem_cmd : _GEN_257 ? _slots_27_io_out_uop_mem_cmd : _GEN_256 ? _slots_26_io_out_uop_mem_cmd : _slots_25_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_258 ? _slots_28_io_out_uop_is_amo : _GEN_257 ? _slots_27_io_out_uop_is_amo : _GEN_256 ? _slots_26_io_out_uop_is_amo : _slots_25_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_258 ? _slots_28_io_out_uop_uses_ldq : _GEN_257 ? _slots_27_io_out_uop_uses_ldq : _GEN_256 ? _slots_26_io_out_uop_uses_ldq : _slots_25_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_258 ? _slots_28_io_out_uop_uses_stq : _GEN_257 ? _slots_27_io_out_uop_uses_stq : _GEN_256 ? _slots_26_io_out_uop_uses_stq : _slots_25_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_258 ? _slots_28_io_out_uop_dst_rtype : _GEN_257 ? _slots_27_io_out_uop_dst_rtype : _GEN_256 ? _slots_26_io_out_uop_dst_rtype : _slots_25_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_258 ? _slots_28_io_out_uop_fp_val : _GEN_257 ? _slots_27_io_out_uop_fp_val : _GEN_256 ? _slots_26_io_out_uop_fp_val : _slots_25_io_out_uop_fp_val),
    .io_valid                       (_slots_24_io_valid),
    .io_will_be_valid               (_slots_24_io_will_be_valid),
    .io_request                     (_slots_24_io_request),
    .io_out_uop_uopc                (_slots_24_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_24_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_24_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_24_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_24_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_24_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_24_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_24_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_24_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_24_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_24_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_24_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_24_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_24_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_24_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_24_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_24_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_24_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_24_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_24_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_24_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_24_io_uop_uopc),
    .io_uop_fu_code                 (_slots_24_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_24_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_24_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_24_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_24_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_24_io_uop_pdst),
    .io_uop_prs1                    (_slots_24_io_uop_prs1),
    .io_uop_prs2                    (_slots_24_io_uop_prs2),
    .io_uop_prs3                    (_slots_24_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_24_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_24_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_24_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_24_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_24_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_24_io_uop_fp_val)
  );
  IssueSlot slots_25 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_25_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_57),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_25_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_261 ? _slots_29_io_out_uop_uopc : _GEN_260 ? _slots_28_io_out_uop_uopc : _GEN_259 ? _slots_27_io_out_uop_uopc : _slots_26_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_261 ? _slots_29_io_out_uop_fu_code : _GEN_260 ? _slots_28_io_out_uop_fu_code : _GEN_259 ? _slots_27_io_out_uop_fu_code : _slots_26_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_261 ? _slots_29_io_out_uop_iw_state : _GEN_260 ? _slots_28_io_out_uop_iw_state : _GEN_259 ? _slots_27_io_out_uop_iw_state : _slots_26_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_261 ? _slots_29_io_out_uop_br_mask : _GEN_260 ? _slots_28_io_out_uop_br_mask : _GEN_259 ? _slots_27_io_out_uop_br_mask : _slots_26_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_261 ? _slots_29_io_out_uop_imm_packed : _GEN_260 ? _slots_28_io_out_uop_imm_packed : _GEN_259 ? _slots_27_io_out_uop_imm_packed : _slots_26_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_261 ? _slots_29_io_out_uop_rob_idx : _GEN_260 ? _slots_28_io_out_uop_rob_idx : _GEN_259 ? _slots_27_io_out_uop_rob_idx : _slots_26_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_261 ? _slots_29_io_out_uop_stq_idx : _GEN_260 ? _slots_28_io_out_uop_stq_idx : _GEN_259 ? _slots_27_io_out_uop_stq_idx : _slots_26_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_261 ? _slots_29_io_out_uop_pdst : _GEN_260 ? _slots_28_io_out_uop_pdst : _GEN_259 ? _slots_27_io_out_uop_pdst : _slots_26_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_261 ? _slots_29_io_out_uop_prs1 : _GEN_260 ? _slots_28_io_out_uop_prs1 : _GEN_259 ? _slots_27_io_out_uop_prs1 : _slots_26_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_261 ? _slots_29_io_out_uop_prs2 : _GEN_260 ? _slots_28_io_out_uop_prs2 : _GEN_259 ? _slots_27_io_out_uop_prs2 : _slots_26_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_261 ? _slots_29_io_out_uop_prs3 : _GEN_260 ? _slots_28_io_out_uop_prs3 : _GEN_259 ? _slots_27_io_out_uop_prs3 : _slots_26_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_261 ? _slots_29_io_out_uop_prs1_busy : _GEN_260 ? _slots_28_io_out_uop_prs1_busy : _GEN_259 ? _slots_27_io_out_uop_prs1_busy : _slots_26_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_261 ? _slots_29_io_out_uop_prs2_busy : _GEN_260 ? _slots_28_io_out_uop_prs2_busy : _GEN_259 ? _slots_27_io_out_uop_prs2_busy : _slots_26_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_261 ? _slots_29_io_out_uop_prs3_busy : _GEN_260 ? _slots_28_io_out_uop_prs3_busy : _GEN_259 ? _slots_27_io_out_uop_prs3_busy : _slots_26_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_261 ? _slots_29_io_out_uop_ppred_busy : _GEN_260 ? _slots_28_io_out_uop_ppred_busy : _GEN_259 ? _slots_27_io_out_uop_ppred_busy : _slots_26_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_261 ? _slots_29_io_out_uop_mem_cmd : _GEN_260 ? _slots_28_io_out_uop_mem_cmd : _GEN_259 ? _slots_27_io_out_uop_mem_cmd : _slots_26_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_261 ? _slots_29_io_out_uop_is_amo : _GEN_260 ? _slots_28_io_out_uop_is_amo : _GEN_259 ? _slots_27_io_out_uop_is_amo : _slots_26_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_261 ? _slots_29_io_out_uop_uses_ldq : _GEN_260 ? _slots_28_io_out_uop_uses_ldq : _GEN_259 ? _slots_27_io_out_uop_uses_ldq : _slots_26_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_261 ? _slots_29_io_out_uop_uses_stq : _GEN_260 ? _slots_28_io_out_uop_uses_stq : _GEN_259 ? _slots_27_io_out_uop_uses_stq : _slots_26_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_261 ? _slots_29_io_out_uop_dst_rtype : _GEN_260 ? _slots_28_io_out_uop_dst_rtype : _GEN_259 ? _slots_27_io_out_uop_dst_rtype : _slots_26_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_261 ? _slots_29_io_out_uop_fp_val : _GEN_260 ? _slots_28_io_out_uop_fp_val : _GEN_259 ? _slots_27_io_out_uop_fp_val : _slots_26_io_out_uop_fp_val),
    .io_valid                       (_slots_25_io_valid),
    .io_will_be_valid               (_slots_25_io_will_be_valid),
    .io_request                     (_slots_25_io_request),
    .io_out_uop_uopc                (_slots_25_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_25_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_25_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_25_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_25_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_25_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_25_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_25_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_25_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_25_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_25_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_25_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_25_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_25_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_25_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_25_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_25_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_25_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_25_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_25_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_25_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_25_io_uop_uopc),
    .io_uop_fu_code                 (_slots_25_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_25_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_25_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_25_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_25_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_25_io_uop_pdst),
    .io_uop_prs1                    (_slots_25_io_uop_prs1),
    .io_uop_prs2                    (_slots_25_io_uop_prs2),
    .io_uop_prs3                    (_slots_25_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_25_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_25_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_25_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_25_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_25_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_25_io_uop_fp_val)
  );
  IssueSlot slots_26 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_26_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_59),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_26_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_264 ? _slots_30_io_out_uop_uopc : _GEN_263 ? _slots_29_io_out_uop_uopc : _GEN_262 ? _slots_28_io_out_uop_uopc : _slots_27_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_264 ? _slots_30_io_out_uop_fu_code : _GEN_263 ? _slots_29_io_out_uop_fu_code : _GEN_262 ? _slots_28_io_out_uop_fu_code : _slots_27_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_264 ? _slots_30_io_out_uop_iw_state : _GEN_263 ? _slots_29_io_out_uop_iw_state : _GEN_262 ? _slots_28_io_out_uop_iw_state : _slots_27_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_264 ? _slots_30_io_out_uop_br_mask : _GEN_263 ? _slots_29_io_out_uop_br_mask : _GEN_262 ? _slots_28_io_out_uop_br_mask : _slots_27_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_264 ? _slots_30_io_out_uop_imm_packed : _GEN_263 ? _slots_29_io_out_uop_imm_packed : _GEN_262 ? _slots_28_io_out_uop_imm_packed : _slots_27_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_264 ? _slots_30_io_out_uop_rob_idx : _GEN_263 ? _slots_29_io_out_uop_rob_idx : _GEN_262 ? _slots_28_io_out_uop_rob_idx : _slots_27_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_264 ? _slots_30_io_out_uop_stq_idx : _GEN_263 ? _slots_29_io_out_uop_stq_idx : _GEN_262 ? _slots_28_io_out_uop_stq_idx : _slots_27_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_264 ? _slots_30_io_out_uop_pdst : _GEN_263 ? _slots_29_io_out_uop_pdst : _GEN_262 ? _slots_28_io_out_uop_pdst : _slots_27_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_264 ? _slots_30_io_out_uop_prs1 : _GEN_263 ? _slots_29_io_out_uop_prs1 : _GEN_262 ? _slots_28_io_out_uop_prs1 : _slots_27_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_264 ? _slots_30_io_out_uop_prs2 : _GEN_263 ? _slots_29_io_out_uop_prs2 : _GEN_262 ? _slots_28_io_out_uop_prs2 : _slots_27_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_264 ? _slots_30_io_out_uop_prs3 : _GEN_263 ? _slots_29_io_out_uop_prs3 : _GEN_262 ? _slots_28_io_out_uop_prs3 : _slots_27_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_264 ? _slots_30_io_out_uop_prs1_busy : _GEN_263 ? _slots_29_io_out_uop_prs1_busy : _GEN_262 ? _slots_28_io_out_uop_prs1_busy : _slots_27_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_264 ? _slots_30_io_out_uop_prs2_busy : _GEN_263 ? _slots_29_io_out_uop_prs2_busy : _GEN_262 ? _slots_28_io_out_uop_prs2_busy : _slots_27_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_264 ? _slots_30_io_out_uop_prs3_busy : _GEN_263 ? _slots_29_io_out_uop_prs3_busy : _GEN_262 ? _slots_28_io_out_uop_prs3_busy : _slots_27_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_264 ? _slots_30_io_out_uop_ppred_busy : _GEN_263 ? _slots_29_io_out_uop_ppred_busy : _GEN_262 ? _slots_28_io_out_uop_ppred_busy : _slots_27_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_264 ? _slots_30_io_out_uop_mem_cmd : _GEN_263 ? _slots_29_io_out_uop_mem_cmd : _GEN_262 ? _slots_28_io_out_uop_mem_cmd : _slots_27_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_264 ? _slots_30_io_out_uop_is_amo : _GEN_263 ? _slots_29_io_out_uop_is_amo : _GEN_262 ? _slots_28_io_out_uop_is_amo : _slots_27_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_264 ? _slots_30_io_out_uop_uses_ldq : _GEN_263 ? _slots_29_io_out_uop_uses_ldq : _GEN_262 ? _slots_28_io_out_uop_uses_ldq : _slots_27_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_264 ? _slots_30_io_out_uop_uses_stq : _GEN_263 ? _slots_29_io_out_uop_uses_stq : _GEN_262 ? _slots_28_io_out_uop_uses_stq : _slots_27_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_264 ? _slots_30_io_out_uop_dst_rtype : _GEN_263 ? _slots_29_io_out_uop_dst_rtype : _GEN_262 ? _slots_28_io_out_uop_dst_rtype : _slots_27_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_264 ? _slots_30_io_out_uop_fp_val : _GEN_263 ? _slots_29_io_out_uop_fp_val : _GEN_262 ? _slots_28_io_out_uop_fp_val : _slots_27_io_out_uop_fp_val),
    .io_valid                       (_slots_26_io_valid),
    .io_will_be_valid               (_slots_26_io_will_be_valid),
    .io_request                     (_slots_26_io_request),
    .io_out_uop_uopc                (_slots_26_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_26_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_26_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_26_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_26_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_26_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_26_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_26_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_26_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_26_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_26_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_26_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_26_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_26_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_26_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_26_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_26_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_26_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_26_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_26_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_26_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_26_io_uop_uopc),
    .io_uop_fu_code                 (_slots_26_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_26_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_26_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_26_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_26_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_26_io_uop_pdst),
    .io_uop_prs1                    (_slots_26_io_uop_prs1),
    .io_uop_prs2                    (_slots_26_io_uop_prs2),
    .io_uop_prs3                    (_slots_26_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_26_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_26_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_26_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_26_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_26_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_26_io_uop_fp_val)
  );
  IssueSlot slots_27 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_27_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_61),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_27_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_267 ? _slots_31_io_out_uop_uopc : _GEN_266 ? _slots_30_io_out_uop_uopc : _GEN_265 ? _slots_29_io_out_uop_uopc : _slots_28_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_267 ? _slots_31_io_out_uop_fu_code : _GEN_266 ? _slots_30_io_out_uop_fu_code : _GEN_265 ? _slots_29_io_out_uop_fu_code : _slots_28_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_267 ? _slots_31_io_out_uop_iw_state : _GEN_266 ? _slots_30_io_out_uop_iw_state : _GEN_265 ? _slots_29_io_out_uop_iw_state : _slots_28_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_267 ? _slots_31_io_out_uop_br_mask : _GEN_266 ? _slots_30_io_out_uop_br_mask : _GEN_265 ? _slots_29_io_out_uop_br_mask : _slots_28_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_267 ? _slots_31_io_out_uop_imm_packed : _GEN_266 ? _slots_30_io_out_uop_imm_packed : _GEN_265 ? _slots_29_io_out_uop_imm_packed : _slots_28_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_267 ? _slots_31_io_out_uop_rob_idx : _GEN_266 ? _slots_30_io_out_uop_rob_idx : _GEN_265 ? _slots_29_io_out_uop_rob_idx : _slots_28_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_267 ? _slots_31_io_out_uop_stq_idx : _GEN_266 ? _slots_30_io_out_uop_stq_idx : _GEN_265 ? _slots_29_io_out_uop_stq_idx : _slots_28_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_267 ? _slots_31_io_out_uop_pdst : _GEN_266 ? _slots_30_io_out_uop_pdst : _GEN_265 ? _slots_29_io_out_uop_pdst : _slots_28_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_267 ? _slots_31_io_out_uop_prs1 : _GEN_266 ? _slots_30_io_out_uop_prs1 : _GEN_265 ? _slots_29_io_out_uop_prs1 : _slots_28_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_267 ? _slots_31_io_out_uop_prs2 : _GEN_266 ? _slots_30_io_out_uop_prs2 : _GEN_265 ? _slots_29_io_out_uop_prs2 : _slots_28_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_267 ? _slots_31_io_out_uop_prs3 : _GEN_266 ? _slots_30_io_out_uop_prs3 : _GEN_265 ? _slots_29_io_out_uop_prs3 : _slots_28_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_267 ? _slots_31_io_out_uop_prs1_busy : _GEN_266 ? _slots_30_io_out_uop_prs1_busy : _GEN_265 ? _slots_29_io_out_uop_prs1_busy : _slots_28_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_267 ? _slots_31_io_out_uop_prs2_busy : _GEN_266 ? _slots_30_io_out_uop_prs2_busy : _GEN_265 ? _slots_29_io_out_uop_prs2_busy : _slots_28_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_267 ? _slots_31_io_out_uop_prs3_busy : _GEN_266 ? _slots_30_io_out_uop_prs3_busy : _GEN_265 ? _slots_29_io_out_uop_prs3_busy : _slots_28_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_267 ? _slots_31_io_out_uop_ppred_busy : _GEN_266 ? _slots_30_io_out_uop_ppred_busy : _GEN_265 ? _slots_29_io_out_uop_ppred_busy : _slots_28_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_267 ? _slots_31_io_out_uop_mem_cmd : _GEN_266 ? _slots_30_io_out_uop_mem_cmd : _GEN_265 ? _slots_29_io_out_uop_mem_cmd : _slots_28_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_267 ? _slots_31_io_out_uop_is_amo : _GEN_266 ? _slots_30_io_out_uop_is_amo : _GEN_265 ? _slots_29_io_out_uop_is_amo : _slots_28_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_267 ? _slots_31_io_out_uop_uses_ldq : _GEN_266 ? _slots_30_io_out_uop_uses_ldq : _GEN_265 ? _slots_29_io_out_uop_uses_ldq : _slots_28_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_267 ? _slots_31_io_out_uop_uses_stq : _GEN_266 ? _slots_30_io_out_uop_uses_stq : _GEN_265 ? _slots_29_io_out_uop_uses_stq : _slots_28_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_267 ? _slots_31_io_out_uop_dst_rtype : _GEN_266 ? _slots_30_io_out_uop_dst_rtype : _GEN_265 ? _slots_29_io_out_uop_dst_rtype : _slots_28_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_267 ? _slots_31_io_out_uop_fp_val : _GEN_266 ? _slots_30_io_out_uop_fp_val : _GEN_265 ? _slots_29_io_out_uop_fp_val : _slots_28_io_out_uop_fp_val),
    .io_valid                       (_slots_27_io_valid),
    .io_will_be_valid               (_slots_27_io_will_be_valid),
    .io_request                     (_slots_27_io_request),
    .io_out_uop_uopc                (_slots_27_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_27_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_27_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_27_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_27_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_27_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_27_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_27_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_27_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_27_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_27_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_27_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_27_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_27_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_27_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_27_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_27_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_27_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_27_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_27_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_27_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_27_io_uop_uopc),
    .io_uop_fu_code                 (_slots_27_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_27_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_27_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_27_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_27_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_27_io_uop_pdst),
    .io_uop_prs1                    (_slots_27_io_uop_prs1),
    .io_uop_prs2                    (_slots_27_io_uop_prs2),
    .io_uop_prs3                    (_slots_27_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_27_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_27_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_27_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_27_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_27_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_27_io_uop_fp_val)
  );
  IssueSlot slots_28 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_28_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_63),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_28_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_270 ? io_dis_uops_0_bits_uopc : _GEN_269 ? _slots_31_io_out_uop_uopc : _GEN_268 ? _slots_30_io_out_uop_uopc : _slots_29_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_270 ? io_dis_uops_0_bits_fu_code : _GEN_269 ? _slots_31_io_out_uop_fu_code : _GEN_268 ? _slots_30_io_out_uop_fu_code : _slots_29_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_270 ? 2'h1 : _GEN_269 ? _slots_31_io_out_uop_iw_state : _GEN_268 ? _slots_30_io_out_uop_iw_state : _slots_29_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_270 ? io_dis_uops_0_bits_br_mask : _GEN_269 ? _slots_31_io_out_uop_br_mask : _GEN_268 ? _slots_30_io_out_uop_br_mask : _slots_29_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_270 ? io_dis_uops_0_bits_imm_packed : _GEN_269 ? _slots_31_io_out_uop_imm_packed : _GEN_268 ? _slots_30_io_out_uop_imm_packed : _slots_29_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_270 ? io_dis_uops_0_bits_rob_idx : _GEN_269 ? _slots_31_io_out_uop_rob_idx : _GEN_268 ? _slots_30_io_out_uop_rob_idx : _slots_29_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_270 ? io_dis_uops_0_bits_stq_idx : _GEN_269 ? _slots_31_io_out_uop_stq_idx : _GEN_268 ? _slots_30_io_out_uop_stq_idx : _slots_29_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_270 ? io_dis_uops_0_bits_pdst : _GEN_269 ? _slots_31_io_out_uop_pdst : _GEN_268 ? _slots_30_io_out_uop_pdst : _slots_29_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_270 ? io_dis_uops_0_bits_prs1 : _GEN_269 ? _slots_31_io_out_uop_prs1 : _GEN_268 ? _slots_30_io_out_uop_prs1 : _slots_29_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_270 ? io_dis_uops_0_bits_prs2 : _GEN_269 ? _slots_31_io_out_uop_prs2 : _GEN_268 ? _slots_30_io_out_uop_prs2 : _slots_29_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_270 ? io_dis_uops_0_bits_prs3 : _GEN_269 ? _slots_31_io_out_uop_prs3 : _GEN_268 ? _slots_30_io_out_uop_prs3 : _slots_29_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_270 ? _GEN_10036 : _GEN_269 ? _slots_31_io_out_uop_prs1_busy : _GEN_268 ? _slots_30_io_out_uop_prs1_busy : _slots_29_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_270 ? io_dis_uops_0_bits_prs2_busy : _GEN_269 ? _slots_31_io_out_uop_prs2_busy : _GEN_268 ? _slots_30_io_out_uop_prs2_busy : _slots_29_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_270 ? io_dis_uops_0_bits_prs3_busy : _GEN_269 ? _slots_31_io_out_uop_prs3_busy : _GEN_268 ? _slots_30_io_out_uop_prs3_busy : _slots_29_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (~_GEN_270 & (_GEN_269 ? _slots_31_io_out_uop_ppred_busy : _GEN_268 ? _slots_30_io_out_uop_ppred_busy : _slots_29_io_out_uop_ppred_busy)),
    .io_in_uop_bits_mem_cmd         (_GEN_270 ? io_dis_uops_0_bits_mem_cmd : _GEN_269 ? _slots_31_io_out_uop_mem_cmd : _GEN_268 ? _slots_30_io_out_uop_mem_cmd : _slots_29_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_270 ? io_dis_uops_0_bits_is_amo : _GEN_269 ? _slots_31_io_out_uop_is_amo : _GEN_268 ? _slots_30_io_out_uop_is_amo : _slots_29_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_270 ? io_dis_uops_0_bits_uses_ldq : _GEN_269 ? _slots_31_io_out_uop_uses_ldq : _GEN_268 ? _slots_30_io_out_uop_uses_ldq : _slots_29_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_270 ? io_dis_uops_0_bits_uses_stq : _GEN_269 ? _slots_31_io_out_uop_uses_stq : _GEN_268 ? _slots_30_io_out_uop_uses_stq : _slots_29_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_270 ? io_dis_uops_0_bits_dst_rtype : _GEN_269 ? _slots_31_io_out_uop_dst_rtype : _GEN_268 ? _slots_30_io_out_uop_dst_rtype : _slots_29_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_270 ? io_dis_uops_0_bits_fp_val : _GEN_269 ? _slots_31_io_out_uop_fp_val : _GEN_268 ? _slots_30_io_out_uop_fp_val : _slots_29_io_out_uop_fp_val),
    .io_valid                       (_slots_28_io_valid),
    .io_will_be_valid               (_slots_28_io_will_be_valid),
    .io_request                     (_slots_28_io_request),
    .io_out_uop_uopc                (_slots_28_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_28_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_28_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_28_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_28_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_28_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_28_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_28_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_28_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_28_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_28_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_28_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_28_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_28_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_28_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_28_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_28_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_28_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_28_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_28_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_28_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_28_io_uop_uopc),
    .io_uop_fu_code                 (_slots_28_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_28_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_28_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_28_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_28_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_28_io_uop_pdst),
    .io_uop_prs1                    (_slots_28_io_uop_prs1),
    .io_uop_prs2                    (_slots_28_io_uop_prs2),
    .io_uop_prs3                    (_slots_28_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_28_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_28_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_28_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_28_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_28_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_28_io_uop_fp_val)
  );
  IssueSlot slots_29 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_29_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_65),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_29_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_273 ? io_dis_uops_1_bits_uopc : _GEN_272 ? io_dis_uops_0_bits_uopc : _GEN_271 ? _slots_31_io_out_uop_uopc : _slots_30_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_273 ? io_dis_uops_1_bits_fu_code : _GEN_272 ? io_dis_uops_0_bits_fu_code : _GEN_271 ? _slots_31_io_out_uop_fu_code : _slots_30_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_274 ? 2'h1 : _GEN_271 ? _slots_31_io_out_uop_iw_state : _slots_30_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_273 ? io_dis_uops_1_bits_br_mask : _GEN_272 ? io_dis_uops_0_bits_br_mask : _GEN_271 ? _slots_31_io_out_uop_br_mask : _slots_30_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_273 ? io_dis_uops_1_bits_imm_packed : _GEN_272 ? io_dis_uops_0_bits_imm_packed : _GEN_271 ? _slots_31_io_out_uop_imm_packed : _slots_30_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_273 ? io_dis_uops_1_bits_rob_idx : _GEN_272 ? io_dis_uops_0_bits_rob_idx : _GEN_271 ? _slots_31_io_out_uop_rob_idx : _slots_30_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_273 ? io_dis_uops_1_bits_stq_idx : _GEN_272 ? io_dis_uops_0_bits_stq_idx : _GEN_271 ? _slots_31_io_out_uop_stq_idx : _slots_30_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_273 ? io_dis_uops_1_bits_pdst : _GEN_272 ? io_dis_uops_0_bits_pdst : _GEN_271 ? _slots_31_io_out_uop_pdst : _slots_30_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_273 ? io_dis_uops_1_bits_prs1 : _GEN_272 ? io_dis_uops_0_bits_prs1 : _GEN_271 ? _slots_31_io_out_uop_prs1 : _slots_30_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_273 ? io_dis_uops_1_bits_prs2 : _GEN_272 ? io_dis_uops_0_bits_prs2 : _GEN_271 ? _slots_31_io_out_uop_prs2 : _slots_30_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_273 ? io_dis_uops_1_bits_prs3 : _GEN_272 ? io_dis_uops_0_bits_prs3 : _GEN_271 ? _slots_31_io_out_uop_prs3 : _slots_30_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_273 ? _GEN_3 : _GEN_272 ? _GEN_10036 : _GEN_271 ? _slots_31_io_out_uop_prs1_busy : _slots_30_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_273 ? io_dis_uops_1_bits_prs2_busy : _GEN_272 ? io_dis_uops_0_bits_prs2_busy : _GEN_271 ? _slots_31_io_out_uop_prs2_busy : _slots_30_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_273 ? io_dis_uops_1_bits_prs3_busy : _GEN_272 ? io_dis_uops_0_bits_prs3_busy : _GEN_271 ? _slots_31_io_out_uop_prs3_busy : _slots_30_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (~_GEN_274 & (_GEN_271 ? _slots_31_io_out_uop_ppred_busy : _slots_30_io_out_uop_ppred_busy)),
    .io_in_uop_bits_mem_cmd         (_GEN_273 ? io_dis_uops_1_bits_mem_cmd : _GEN_272 ? io_dis_uops_0_bits_mem_cmd : _GEN_271 ? _slots_31_io_out_uop_mem_cmd : _slots_30_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_273 ? io_dis_uops_1_bits_is_amo : _GEN_272 ? io_dis_uops_0_bits_is_amo : _GEN_271 ? _slots_31_io_out_uop_is_amo : _slots_30_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_273 ? io_dis_uops_1_bits_uses_ldq : _GEN_272 ? io_dis_uops_0_bits_uses_ldq : _GEN_271 ? _slots_31_io_out_uop_uses_ldq : _slots_30_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_273 ? io_dis_uops_1_bits_uses_stq : _GEN_272 ? io_dis_uops_0_bits_uses_stq : _GEN_271 ? _slots_31_io_out_uop_uses_stq : _slots_30_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_273 ? io_dis_uops_1_bits_dst_rtype : _GEN_272 ? io_dis_uops_0_bits_dst_rtype : _GEN_271 ? _slots_31_io_out_uop_dst_rtype : _slots_30_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_273 ? io_dis_uops_1_bits_fp_val : _GEN_272 ? io_dis_uops_0_bits_fp_val : _GEN_271 ? _slots_31_io_out_uop_fp_val : _slots_30_io_out_uop_fp_val),
    .io_valid                       (_slots_29_io_valid),
    .io_will_be_valid               (_slots_29_io_will_be_valid),
    .io_request                     (_slots_29_io_request),
    .io_out_uop_uopc                (_slots_29_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_29_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_29_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_29_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_29_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_29_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_29_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_29_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_29_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_29_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_29_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_29_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_29_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_29_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_29_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_29_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_29_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_29_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_29_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_29_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_29_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_29_io_uop_uopc),
    .io_uop_fu_code                 (_slots_29_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_29_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_29_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_29_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_29_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_29_io_uop_pdst),
    .io_uop_prs1                    (_slots_29_io_uop_prs1),
    .io_uop_prs2                    (_slots_29_io_uop_prs2),
    .io_uop_prs3                    (_slots_29_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_29_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_29_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_29_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_29_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_29_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_29_io_uop_fp_val)
  );
  IssueSlot slots_30 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_30_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_67),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_30_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_277 ? io_dis_uops_2_bits_uopc : _GEN_276 ? io_dis_uops_1_bits_uopc : _GEN_275 ? io_dis_uops_0_bits_uopc : _slots_31_io_out_uop_uopc),
    .io_in_uop_bits_fu_code         (_GEN_277 ? io_dis_uops_2_bits_fu_code : _GEN_276 ? io_dis_uops_1_bits_fu_code : _GEN_275 ? io_dis_uops_0_bits_fu_code : _slots_31_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_278 ? 2'h1 : _slots_31_io_out_uop_iw_state),
    .io_in_uop_bits_br_mask         (_GEN_277 ? io_dis_uops_2_bits_br_mask : _GEN_276 ? io_dis_uops_1_bits_br_mask : _GEN_275 ? io_dis_uops_0_bits_br_mask : _slots_31_io_out_uop_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_277 ? io_dis_uops_2_bits_imm_packed : _GEN_276 ? io_dis_uops_1_bits_imm_packed : _GEN_275 ? io_dis_uops_0_bits_imm_packed : _slots_31_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_277 ? io_dis_uops_2_bits_rob_idx : _GEN_276 ? io_dis_uops_1_bits_rob_idx : _GEN_275 ? io_dis_uops_0_bits_rob_idx : _slots_31_io_out_uop_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_277 ? io_dis_uops_2_bits_stq_idx : _GEN_276 ? io_dis_uops_1_bits_stq_idx : _GEN_275 ? io_dis_uops_0_bits_stq_idx : _slots_31_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_277 ? io_dis_uops_2_bits_pdst : _GEN_276 ? io_dis_uops_1_bits_pdst : _GEN_275 ? io_dis_uops_0_bits_pdst : _slots_31_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_277 ? io_dis_uops_2_bits_prs1 : _GEN_276 ? io_dis_uops_1_bits_prs1 : _GEN_275 ? io_dis_uops_0_bits_prs1 : _slots_31_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_277 ? io_dis_uops_2_bits_prs2 : _GEN_276 ? io_dis_uops_1_bits_prs2 : _GEN_275 ? io_dis_uops_0_bits_prs2 : _slots_31_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_277 ? io_dis_uops_2_bits_prs3 : _GEN_276 ? io_dis_uops_1_bits_prs3 : _GEN_275 ? io_dis_uops_0_bits_prs3 : _slots_31_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_277 ? _GEN_5 : _GEN_276 ? _GEN_3 : _GEN_275 ? _GEN_10036 : _slots_31_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_277 ? io_dis_uops_2_bits_prs2_busy : _GEN_276 ? io_dis_uops_1_bits_prs2_busy : _GEN_275 ? io_dis_uops_0_bits_prs2_busy : _slots_31_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_277 ? io_dis_uops_2_bits_prs3_busy : _GEN_276 ? io_dis_uops_1_bits_prs3_busy : _GEN_275 ? io_dis_uops_0_bits_prs3_busy : _slots_31_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (~_GEN_278 & _slots_31_io_out_uop_ppred_busy),
    .io_in_uop_bits_mem_cmd         (_GEN_277 ? io_dis_uops_2_bits_mem_cmd : _GEN_276 ? io_dis_uops_1_bits_mem_cmd : _GEN_275 ? io_dis_uops_0_bits_mem_cmd : _slots_31_io_out_uop_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_277 ? io_dis_uops_2_bits_is_amo : _GEN_276 ? io_dis_uops_1_bits_is_amo : _GEN_275 ? io_dis_uops_0_bits_is_amo : _slots_31_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_277 ? io_dis_uops_2_bits_uses_ldq : _GEN_276 ? io_dis_uops_1_bits_uses_ldq : _GEN_275 ? io_dis_uops_0_bits_uses_ldq : _slots_31_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_277 ? io_dis_uops_2_bits_uses_stq : _GEN_276 ? io_dis_uops_1_bits_uses_stq : _GEN_275 ? io_dis_uops_0_bits_uses_stq : _slots_31_io_out_uop_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_277 ? io_dis_uops_2_bits_dst_rtype : _GEN_276 ? io_dis_uops_1_bits_dst_rtype : _GEN_275 ? io_dis_uops_0_bits_dst_rtype : _slots_31_io_out_uop_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_277 ? io_dis_uops_2_bits_fp_val : _GEN_276 ? io_dis_uops_1_bits_fp_val : _GEN_275 ? io_dis_uops_0_bits_fp_val : _slots_31_io_out_uop_fp_val),
    .io_valid                       (_slots_30_io_valid),
    .io_will_be_valid               (_slots_30_io_will_be_valid),
    .io_request                     (_slots_30_io_request),
    .io_out_uop_uopc                (_slots_30_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_30_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_30_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_30_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_30_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_30_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_30_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_30_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_30_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_30_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_30_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_30_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_30_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_30_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_30_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_30_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_30_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_30_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_30_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_30_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_30_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_30_io_uop_uopc),
    .io_uop_fu_code                 (_slots_30_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_30_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_30_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_30_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_30_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_30_io_uop_pdst),
    .io_uop_prs1                    (_slots_30_io_uop_prs1),
    .io_uop_prs2                    (_slots_30_io_uop_prs2),
    .io_uop_prs3                    (_slots_30_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_30_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_30_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_30_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_30_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_30_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_30_io_uop_fp_val)
  );
  IssueSlot slots_31 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_31_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_69),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_in_uop_valid                (issue_slots_31_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_281 ? io_dis_uops_3_bits_uopc : _GEN_280 ? io_dis_uops_2_bits_uopc : _GEN_279 ? io_dis_uops_1_bits_uopc : io_dis_uops_0_bits_uopc),
    .io_in_uop_bits_fu_code         (_GEN_281 ? io_dis_uops_3_bits_fu_code : _GEN_280 ? io_dis_uops_2_bits_fu_code : _GEN_279 ? io_dis_uops_1_bits_fu_code : io_dis_uops_0_bits_fu_code),
    .io_in_uop_bits_iw_state        (2'h1),
    .io_in_uop_bits_br_mask         (_GEN_281 ? io_dis_uops_3_bits_br_mask : _GEN_280 ? io_dis_uops_2_bits_br_mask : _GEN_279 ? io_dis_uops_1_bits_br_mask : io_dis_uops_0_bits_br_mask),
    .io_in_uop_bits_imm_packed      (_GEN_281 ? io_dis_uops_3_bits_imm_packed : _GEN_280 ? io_dis_uops_2_bits_imm_packed : _GEN_279 ? io_dis_uops_1_bits_imm_packed : io_dis_uops_0_bits_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_281 ? io_dis_uops_3_bits_rob_idx : _GEN_280 ? io_dis_uops_2_bits_rob_idx : _GEN_279 ? io_dis_uops_1_bits_rob_idx : io_dis_uops_0_bits_rob_idx),
    .io_in_uop_bits_stq_idx         (_GEN_281 ? io_dis_uops_3_bits_stq_idx : _GEN_280 ? io_dis_uops_2_bits_stq_idx : _GEN_279 ? io_dis_uops_1_bits_stq_idx : io_dis_uops_0_bits_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_281 ? io_dis_uops_3_bits_pdst : _GEN_280 ? io_dis_uops_2_bits_pdst : _GEN_279 ? io_dis_uops_1_bits_pdst : io_dis_uops_0_bits_pdst),
    .io_in_uop_bits_prs1            (_GEN_281 ? io_dis_uops_3_bits_prs1 : _GEN_280 ? io_dis_uops_2_bits_prs1 : _GEN_279 ? io_dis_uops_1_bits_prs1 : io_dis_uops_0_bits_prs1),
    .io_in_uop_bits_prs2            (_GEN_281 ? io_dis_uops_3_bits_prs2 : _GEN_280 ? io_dis_uops_2_bits_prs2 : _GEN_279 ? io_dis_uops_1_bits_prs2 : io_dis_uops_0_bits_prs2),
    .io_in_uop_bits_prs3            (_GEN_281 ? io_dis_uops_3_bits_prs3 : _GEN_280 ? io_dis_uops_2_bits_prs3 : _GEN_279 ? io_dis_uops_1_bits_prs3 : io_dis_uops_0_bits_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_281 ? io_dis_uops_3_bits_uopc != 7'h2 & io_dis_uops_3_bits_prs1_busy : _GEN_280 ? _GEN_5 : _GEN_279 ? _GEN_3 : _GEN_10036),
    .io_in_uop_bits_prs2_busy       (_GEN_281 ? io_dis_uops_3_bits_prs2_busy : _GEN_280 ? io_dis_uops_2_bits_prs2_busy : _GEN_279 ? io_dis_uops_1_bits_prs2_busy : io_dis_uops_0_bits_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_281 ? io_dis_uops_3_bits_prs3_busy : _GEN_280 ? io_dis_uops_2_bits_prs3_busy : _GEN_279 ? io_dis_uops_1_bits_prs3_busy : io_dis_uops_0_bits_prs3_busy),
    .io_in_uop_bits_ppred_busy      (1'h0),
    .io_in_uop_bits_mem_cmd         (_GEN_281 ? io_dis_uops_3_bits_mem_cmd : _GEN_280 ? io_dis_uops_2_bits_mem_cmd : _GEN_279 ? io_dis_uops_1_bits_mem_cmd : io_dis_uops_0_bits_mem_cmd),
    .io_in_uop_bits_is_amo          (_GEN_281 ? io_dis_uops_3_bits_is_amo : _GEN_280 ? io_dis_uops_2_bits_is_amo : _GEN_279 ? io_dis_uops_1_bits_is_amo : io_dis_uops_0_bits_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_281 ? io_dis_uops_3_bits_uses_ldq : _GEN_280 ? io_dis_uops_2_bits_uses_ldq : _GEN_279 ? io_dis_uops_1_bits_uses_ldq : io_dis_uops_0_bits_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_281 ? io_dis_uops_3_bits_uses_stq : _GEN_280 ? io_dis_uops_2_bits_uses_stq : _GEN_279 ? io_dis_uops_1_bits_uses_stq : io_dis_uops_0_bits_uses_stq),
    .io_in_uop_bits_dst_rtype       (_GEN_281 ? io_dis_uops_3_bits_dst_rtype : _GEN_280 ? io_dis_uops_2_bits_dst_rtype : _GEN_279 ? io_dis_uops_1_bits_dst_rtype : io_dis_uops_0_bits_dst_rtype),
    .io_in_uop_bits_fp_val          (_GEN_281 ? io_dis_uops_3_bits_fp_val : _GEN_280 ? io_dis_uops_2_bits_fp_val : _GEN_279 ? io_dis_uops_1_bits_fp_val : io_dis_uops_0_bits_fp_val),
    .io_valid                       (_slots_31_io_valid),
    .io_will_be_valid               (_slots_31_io_will_be_valid),
    .io_request                     (_slots_31_io_request),
    .io_out_uop_uopc                (_slots_31_io_out_uop_uopc),
    .io_out_uop_fu_code             (_slots_31_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_31_io_out_uop_iw_state),
    .io_out_uop_br_mask             (_slots_31_io_out_uop_br_mask),
    .io_out_uop_imm_packed          (_slots_31_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_31_io_out_uop_rob_idx),
    .io_out_uop_stq_idx             (_slots_31_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_31_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_31_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_31_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_31_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_31_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_31_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_31_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_31_io_out_uop_ppred_busy),
    .io_out_uop_mem_cmd             (_slots_31_io_out_uop_mem_cmd),
    .io_out_uop_is_amo              (_slots_31_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_31_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_31_io_out_uop_uses_stq),
    .io_out_uop_dst_rtype           (_slots_31_io_out_uop_dst_rtype),
    .io_out_uop_fp_val              (_slots_31_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_31_io_uop_uopc),
    .io_uop_fu_code                 (_slots_31_io_uop_fu_code),
    .io_uop_br_mask                 (_slots_31_io_uop_br_mask),
    .io_uop_imm_packed              (_slots_31_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_31_io_uop_rob_idx),
    .io_uop_stq_idx                 (_slots_31_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_31_io_uop_pdst),
    .io_uop_prs1                    (_slots_31_io_uop_prs1),
    .io_uop_prs2                    (_slots_31_io_uop_prs2),
    .io_uop_prs3                    (_slots_31_io_uop_prs3),
    .io_uop_mem_cmd                 (_slots_31_io_uop_mem_cmd),
    .io_uop_is_amo                  (_slots_31_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_31_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_31_io_uop_uses_stq),
    .io_uop_dst_rtype               (_slots_31_io_uop_dst_rtype),
    .io_uop_fp_val                  (_slots_31_io_uop_fp_val)
  );
  assign io_dis_uops_0_ready = io_dis_uops_0_ready_REG;
  assign io_dis_uops_1_ready = io_dis_uops_1_ready_REG;
  assign io_dis_uops_2_ready = io_dis_uops_2_ready_REG;
  assign io_dis_uops_3_ready = io_dis_uops_3_ready_REG;
  assign io_iss_valids_0 = _GEN_15339 | _GEN_15177 | _GEN_15015 | _GEN_14853 | _GEN_14691 | _GEN_14529 | _GEN_14367 | _GEN_14205 | _GEN_14043 | _GEN_13881 | _GEN_13719 | _GEN_13557 | _GEN_13395 | _GEN_13233 | _GEN_13071 | _GEN_12909 | _GEN_12747 | _GEN_12585 | _GEN_12423 | _GEN_12261 | _GEN_12099 | _GEN_11937 | _GEN_11775 | _GEN_11613 | _GEN_11451 | _GEN_11289 | _GEN_11127 | _GEN_10965 | _GEN_10803 | _GEN_10641 | _GEN_10479 | _GEN_10318;
  assign io_iss_valids_1 = _GEN_183 | _GEN_180 | _GEN_175 | _GEN_170 | _GEN_165 | _GEN_160 | _GEN_155 | _GEN_150 | _GEN_145 | _GEN_140 | _GEN_135 | _GEN_130 | _GEN_125 | _GEN_120 | _GEN_115 | _GEN_110 | _GEN_105 | _GEN_100 | _GEN_95 | _GEN_90 | _GEN_85 | _GEN_80 | _GEN_75 | _GEN_70 | _GEN_60 | _GEN_50 | _GEN_40 | _GEN_30 | _GEN_20 | _GEN_11 | _GEN_6 | _GEN_10399;
  assign io_iss_uops_0_uopc = _GEN_15339 ? _slots_31_io_uop_uopc : _GEN_15177 ? _slots_30_io_uop_uopc : _GEN_15015 ? _slots_29_io_uop_uopc : _GEN_14853 ? _slots_28_io_uop_uopc : _GEN_14691 ? _slots_27_io_uop_uopc : _GEN_14529 ? _slots_26_io_uop_uopc : _GEN_14367 ? _slots_25_io_uop_uopc : _GEN_14205 ? _slots_24_io_uop_uopc : _GEN_14043 ? _slots_23_io_uop_uopc : _GEN_13881 ? _slots_22_io_uop_uopc : _GEN_13719 ? _slots_21_io_uop_uopc : _GEN_13557 ? _slots_20_io_uop_uopc : _GEN_13395 ? _slots_19_io_uop_uopc : _GEN_13233 ? _slots_18_io_uop_uopc : _GEN_13071 ? _slots_17_io_uop_uopc : _GEN_12909 ? _slots_16_io_uop_uopc : _GEN_12747 ? _slots_15_io_uop_uopc : _GEN_12585 ? _slots_14_io_uop_uopc : _GEN_12423 ? _slots_13_io_uop_uopc : _GEN_12261 ? _slots_12_io_uop_uopc : _GEN_12099 ? _slots_11_io_uop_uopc : _GEN_11937 ? _slots_10_io_uop_uopc : _GEN_11775 ? _slots_9_io_uop_uopc : _GEN_11613 ? _slots_8_io_uop_uopc : _GEN_11451 ? _slots_7_io_uop_uopc : _GEN_11289 ? _slots_6_io_uop_uopc : _GEN_11127 ? _slots_5_io_uop_uopc : _GEN_10965 ? _slots_4_io_uop_uopc : _GEN_10803 ? _slots_3_io_uop_uopc : _GEN_10641 ? _slots_2_io_uop_uopc : _GEN_10479 ? _slots_1_io_uop_uopc : _GEN_10318 ? _slots_0_io_uop_uopc : 7'h0;
  assign io_iss_uops_0_fu_code = _GEN_15339 ? _slots_31_io_uop_fu_code : _GEN_15177 ? _slots_30_io_uop_fu_code : _GEN_15015 ? _slots_29_io_uop_fu_code : _GEN_14853 ? _slots_28_io_uop_fu_code : _GEN_14691 ? _slots_27_io_uop_fu_code : _GEN_14529 ? _slots_26_io_uop_fu_code : _GEN_14367 ? _slots_25_io_uop_fu_code : _GEN_14205 ? _slots_24_io_uop_fu_code : _GEN_14043 ? _slots_23_io_uop_fu_code : _GEN_13881 ? _slots_22_io_uop_fu_code : _GEN_13719 ? _slots_21_io_uop_fu_code : _GEN_13557 ? _slots_20_io_uop_fu_code : _GEN_13395 ? _slots_19_io_uop_fu_code : _GEN_13233 ? _slots_18_io_uop_fu_code : _GEN_13071 ? _slots_17_io_uop_fu_code : _GEN_12909 ? _slots_16_io_uop_fu_code : _GEN_12747 ? _slots_15_io_uop_fu_code : _GEN_12585 ? _slots_14_io_uop_fu_code : _GEN_12423 ? _slots_13_io_uop_fu_code : _GEN_12261 ? _slots_12_io_uop_fu_code : _GEN_12099 ? _slots_11_io_uop_fu_code : _GEN_11937 ? _slots_10_io_uop_fu_code : _GEN_11775 ? _slots_9_io_uop_fu_code : _GEN_11613 ? _slots_8_io_uop_fu_code : _GEN_11451 ? _slots_7_io_uop_fu_code : _GEN_11289 ? _slots_6_io_uop_fu_code : _GEN_11127 ? _slots_5_io_uop_fu_code : _GEN_10965 ? _slots_4_io_uop_fu_code : _GEN_10803 ? _slots_3_io_uop_fu_code : _GEN_10641 ? _slots_2_io_uop_fu_code : _GEN_10479 ? _slots_1_io_uop_fu_code : _GEN_10318 ? _slots_0_io_uop_fu_code : 10'h0;
  assign io_iss_uops_0_br_mask = _GEN_15339 ? _slots_31_io_uop_br_mask : _GEN_15177 ? _slots_30_io_uop_br_mask : _GEN_15015 ? _slots_29_io_uop_br_mask : _GEN_14853 ? _slots_28_io_uop_br_mask : _GEN_14691 ? _slots_27_io_uop_br_mask : _GEN_14529 ? _slots_26_io_uop_br_mask : _GEN_14367 ? _slots_25_io_uop_br_mask : _GEN_14205 ? _slots_24_io_uop_br_mask : _GEN_14043 ? _slots_23_io_uop_br_mask : _GEN_13881 ? _slots_22_io_uop_br_mask : _GEN_13719 ? _slots_21_io_uop_br_mask : _GEN_13557 ? _slots_20_io_uop_br_mask : _GEN_13395 ? _slots_19_io_uop_br_mask : _GEN_13233 ? _slots_18_io_uop_br_mask : _GEN_13071 ? _slots_17_io_uop_br_mask : _GEN_12909 ? _slots_16_io_uop_br_mask : _GEN_12747 ? _slots_15_io_uop_br_mask : _GEN_12585 ? _slots_14_io_uop_br_mask : _GEN_12423 ? _slots_13_io_uop_br_mask : _GEN_12261 ? _slots_12_io_uop_br_mask : _GEN_12099 ? _slots_11_io_uop_br_mask : _GEN_11937 ? _slots_10_io_uop_br_mask : _GEN_11775 ? _slots_9_io_uop_br_mask : _GEN_11613 ? _slots_8_io_uop_br_mask : _GEN_11451 ? _slots_7_io_uop_br_mask : _GEN_11289 ? _slots_6_io_uop_br_mask : _GEN_11127 ? _slots_5_io_uop_br_mask : _GEN_10965 ? _slots_4_io_uop_br_mask : _GEN_10803 ? _slots_3_io_uop_br_mask : _GEN_10641 ? _slots_2_io_uop_br_mask : _GEN_10479 ? _slots_1_io_uop_br_mask : _GEN_10318 ? _slots_0_io_uop_br_mask : 20'h0;
  assign io_iss_uops_0_imm_packed = _GEN_15339 ? _slots_31_io_uop_imm_packed : _GEN_15177 ? _slots_30_io_uop_imm_packed : _GEN_15015 ? _slots_29_io_uop_imm_packed : _GEN_14853 ? _slots_28_io_uop_imm_packed : _GEN_14691 ? _slots_27_io_uop_imm_packed : _GEN_14529 ? _slots_26_io_uop_imm_packed : _GEN_14367 ? _slots_25_io_uop_imm_packed : _GEN_14205 ? _slots_24_io_uop_imm_packed : _GEN_14043 ? _slots_23_io_uop_imm_packed : _GEN_13881 ? _slots_22_io_uop_imm_packed : _GEN_13719 ? _slots_21_io_uop_imm_packed : _GEN_13557 ? _slots_20_io_uop_imm_packed : _GEN_13395 ? _slots_19_io_uop_imm_packed : _GEN_13233 ? _slots_18_io_uop_imm_packed : _GEN_13071 ? _slots_17_io_uop_imm_packed : _GEN_12909 ? _slots_16_io_uop_imm_packed : _GEN_12747 ? _slots_15_io_uop_imm_packed : _GEN_12585 ? _slots_14_io_uop_imm_packed : _GEN_12423 ? _slots_13_io_uop_imm_packed : _GEN_12261 ? _slots_12_io_uop_imm_packed : _GEN_12099 ? _slots_11_io_uop_imm_packed : _GEN_11937 ? _slots_10_io_uop_imm_packed : _GEN_11775 ? _slots_9_io_uop_imm_packed : _GEN_11613 ? _slots_8_io_uop_imm_packed : _GEN_11451 ? _slots_7_io_uop_imm_packed : _GEN_11289 ? _slots_6_io_uop_imm_packed : _GEN_11127 ? _slots_5_io_uop_imm_packed : _GEN_10965 ? _slots_4_io_uop_imm_packed : _GEN_10803 ? _slots_3_io_uop_imm_packed : _GEN_10641 ? _slots_2_io_uop_imm_packed : _GEN_10479 ? _slots_1_io_uop_imm_packed : _GEN_10318 ? _slots_0_io_uop_imm_packed : 20'h0;
  assign io_iss_uops_0_rob_idx = _GEN_15339 ? _slots_31_io_uop_rob_idx : _GEN_15177 ? _slots_30_io_uop_rob_idx : _GEN_15015 ? _slots_29_io_uop_rob_idx : _GEN_14853 ? _slots_28_io_uop_rob_idx : _GEN_14691 ? _slots_27_io_uop_rob_idx : _GEN_14529 ? _slots_26_io_uop_rob_idx : _GEN_14367 ? _slots_25_io_uop_rob_idx : _GEN_14205 ? _slots_24_io_uop_rob_idx : _GEN_14043 ? _slots_23_io_uop_rob_idx : _GEN_13881 ? _slots_22_io_uop_rob_idx : _GEN_13719 ? _slots_21_io_uop_rob_idx : _GEN_13557 ? _slots_20_io_uop_rob_idx : _GEN_13395 ? _slots_19_io_uop_rob_idx : _GEN_13233 ? _slots_18_io_uop_rob_idx : _GEN_13071 ? _slots_17_io_uop_rob_idx : _GEN_12909 ? _slots_16_io_uop_rob_idx : _GEN_12747 ? _slots_15_io_uop_rob_idx : _GEN_12585 ? _slots_14_io_uop_rob_idx : _GEN_12423 ? _slots_13_io_uop_rob_idx : _GEN_12261 ? _slots_12_io_uop_rob_idx : _GEN_12099 ? _slots_11_io_uop_rob_idx : _GEN_11937 ? _slots_10_io_uop_rob_idx : _GEN_11775 ? _slots_9_io_uop_rob_idx : _GEN_11613 ? _slots_8_io_uop_rob_idx : _GEN_11451 ? _slots_7_io_uop_rob_idx : _GEN_11289 ? _slots_6_io_uop_rob_idx : _GEN_11127 ? _slots_5_io_uop_rob_idx : _GEN_10965 ? _slots_4_io_uop_rob_idx : _GEN_10803 ? _slots_3_io_uop_rob_idx : _GEN_10641 ? _slots_2_io_uop_rob_idx : _GEN_10479 ? _slots_1_io_uop_rob_idx : _GEN_10318 ? _slots_0_io_uop_rob_idx : 7'h0;
  assign io_iss_uops_0_stq_idx = _GEN_15339 ? _slots_31_io_uop_stq_idx : _GEN_15177 ? _slots_30_io_uop_stq_idx : _GEN_15015 ? _slots_29_io_uop_stq_idx : _GEN_14853 ? _slots_28_io_uop_stq_idx : _GEN_14691 ? _slots_27_io_uop_stq_idx : _GEN_14529 ? _slots_26_io_uop_stq_idx : _GEN_14367 ? _slots_25_io_uop_stq_idx : _GEN_14205 ? _slots_24_io_uop_stq_idx : _GEN_14043 ? _slots_23_io_uop_stq_idx : _GEN_13881 ? _slots_22_io_uop_stq_idx : _GEN_13719 ? _slots_21_io_uop_stq_idx : _GEN_13557 ? _slots_20_io_uop_stq_idx : _GEN_13395 ? _slots_19_io_uop_stq_idx : _GEN_13233 ? _slots_18_io_uop_stq_idx : _GEN_13071 ? _slots_17_io_uop_stq_idx : _GEN_12909 ? _slots_16_io_uop_stq_idx : _GEN_12747 ? _slots_15_io_uop_stq_idx : _GEN_12585 ? _slots_14_io_uop_stq_idx : _GEN_12423 ? _slots_13_io_uop_stq_idx : _GEN_12261 ? _slots_12_io_uop_stq_idx : _GEN_12099 ? _slots_11_io_uop_stq_idx : _GEN_11937 ? _slots_10_io_uop_stq_idx : _GEN_11775 ? _slots_9_io_uop_stq_idx : _GEN_11613 ? _slots_8_io_uop_stq_idx : _GEN_11451 ? _slots_7_io_uop_stq_idx : _GEN_11289 ? _slots_6_io_uop_stq_idx : _GEN_11127 ? _slots_5_io_uop_stq_idx : _GEN_10965 ? _slots_4_io_uop_stq_idx : _GEN_10803 ? _slots_3_io_uop_stq_idx : _GEN_10641 ? _slots_2_io_uop_stq_idx : _GEN_10479 ? _slots_1_io_uop_stq_idx : _GEN_10318 ? _slots_0_io_uop_stq_idx : 5'h0;
  assign io_iss_uops_0_pdst = _GEN_15339 ? _slots_31_io_uop_pdst : _GEN_15177 ? _slots_30_io_uop_pdst : _GEN_15015 ? _slots_29_io_uop_pdst : _GEN_14853 ? _slots_28_io_uop_pdst : _GEN_14691 ? _slots_27_io_uop_pdst : _GEN_14529 ? _slots_26_io_uop_pdst : _GEN_14367 ? _slots_25_io_uop_pdst : _GEN_14205 ? _slots_24_io_uop_pdst : _GEN_14043 ? _slots_23_io_uop_pdst : _GEN_13881 ? _slots_22_io_uop_pdst : _GEN_13719 ? _slots_21_io_uop_pdst : _GEN_13557 ? _slots_20_io_uop_pdst : _GEN_13395 ? _slots_19_io_uop_pdst : _GEN_13233 ? _slots_18_io_uop_pdst : _GEN_13071 ? _slots_17_io_uop_pdst : _GEN_12909 ? _slots_16_io_uop_pdst : _GEN_12747 ? _slots_15_io_uop_pdst : _GEN_12585 ? _slots_14_io_uop_pdst : _GEN_12423 ? _slots_13_io_uop_pdst : _GEN_12261 ? _slots_12_io_uop_pdst : _GEN_12099 ? _slots_11_io_uop_pdst : _GEN_11937 ? _slots_10_io_uop_pdst : _GEN_11775 ? _slots_9_io_uop_pdst : _GEN_11613 ? _slots_8_io_uop_pdst : _GEN_11451 ? _slots_7_io_uop_pdst : _GEN_11289 ? _slots_6_io_uop_pdst : _GEN_11127 ? _slots_5_io_uop_pdst : _GEN_10965 ? _slots_4_io_uop_pdst : _GEN_10803 ? _slots_3_io_uop_pdst : _GEN_10641 ? _slots_2_io_uop_pdst : _GEN_10479 ? _slots_1_io_uop_pdst : _GEN_10318 ? _slots_0_io_uop_pdst : 7'h0;
  assign io_iss_uops_0_prs1 = _GEN_15339 ? _slots_31_io_uop_prs1 : _GEN_15177 ? _slots_30_io_uop_prs1 : _GEN_15015 ? _slots_29_io_uop_prs1 : _GEN_14853 ? _slots_28_io_uop_prs1 : _GEN_14691 ? _slots_27_io_uop_prs1 : _GEN_14529 ? _slots_26_io_uop_prs1 : _GEN_14367 ? _slots_25_io_uop_prs1 : _GEN_14205 ? _slots_24_io_uop_prs1 : _GEN_14043 ? _slots_23_io_uop_prs1 : _GEN_13881 ? _slots_22_io_uop_prs1 : _GEN_13719 ? _slots_21_io_uop_prs1 : _GEN_13557 ? _slots_20_io_uop_prs1 : _GEN_13395 ? _slots_19_io_uop_prs1 : _GEN_13233 ? _slots_18_io_uop_prs1 : _GEN_13071 ? _slots_17_io_uop_prs1 : _GEN_12909 ? _slots_16_io_uop_prs1 : _GEN_12747 ? _slots_15_io_uop_prs1 : _GEN_12585 ? _slots_14_io_uop_prs1 : _GEN_12423 ? _slots_13_io_uop_prs1 : _GEN_12261 ? _slots_12_io_uop_prs1 : _GEN_12099 ? _slots_11_io_uop_prs1 : _GEN_11937 ? _slots_10_io_uop_prs1 : _GEN_11775 ? _slots_9_io_uop_prs1 : _GEN_11613 ? _slots_8_io_uop_prs1 : _GEN_11451 ? _slots_7_io_uop_prs1 : _GEN_11289 ? _slots_6_io_uop_prs1 : _GEN_11127 ? _slots_5_io_uop_prs1 : _GEN_10965 ? _slots_4_io_uop_prs1 : _GEN_10803 ? _slots_3_io_uop_prs1 : _GEN_10641 ? _slots_2_io_uop_prs1 : _GEN_10479 ? _slots_1_io_uop_prs1 : _GEN_10318 ? _slots_0_io_uop_prs1 : 7'h0;
  assign io_iss_uops_0_prs2 = _GEN_15339 ? _slots_31_io_uop_prs2 : _GEN_15177 ? _slots_30_io_uop_prs2 : _GEN_15015 ? _slots_29_io_uop_prs2 : _GEN_14853 ? _slots_28_io_uop_prs2 : _GEN_14691 ? _slots_27_io_uop_prs2 : _GEN_14529 ? _slots_26_io_uop_prs2 : _GEN_14367 ? _slots_25_io_uop_prs2 : _GEN_14205 ? _slots_24_io_uop_prs2 : _GEN_14043 ? _slots_23_io_uop_prs2 : _GEN_13881 ? _slots_22_io_uop_prs2 : _GEN_13719 ? _slots_21_io_uop_prs2 : _GEN_13557 ? _slots_20_io_uop_prs2 : _GEN_13395 ? _slots_19_io_uop_prs2 : _GEN_13233 ? _slots_18_io_uop_prs2 : _GEN_13071 ? _slots_17_io_uop_prs2 : _GEN_12909 ? _slots_16_io_uop_prs2 : _GEN_12747 ? _slots_15_io_uop_prs2 : _GEN_12585 ? _slots_14_io_uop_prs2 : _GEN_12423 ? _slots_13_io_uop_prs2 : _GEN_12261 ? _slots_12_io_uop_prs2 : _GEN_12099 ? _slots_11_io_uop_prs2 : _GEN_11937 ? _slots_10_io_uop_prs2 : _GEN_11775 ? _slots_9_io_uop_prs2 : _GEN_11613 ? _slots_8_io_uop_prs2 : _GEN_11451 ? _slots_7_io_uop_prs2 : _GEN_11289 ? _slots_6_io_uop_prs2 : _GEN_11127 ? _slots_5_io_uop_prs2 : _GEN_10965 ? _slots_4_io_uop_prs2 : _GEN_10803 ? _slots_3_io_uop_prs2 : _GEN_10641 ? _slots_2_io_uop_prs2 : _GEN_10479 ? _slots_1_io_uop_prs2 : _GEN_10318 ? _slots_0_io_uop_prs2 : 7'h0;
  assign io_iss_uops_0_prs3 = _GEN_15339 ? _slots_31_io_uop_prs3 : _GEN_15177 ? _slots_30_io_uop_prs3 : _GEN_15015 ? _slots_29_io_uop_prs3 : _GEN_14853 ? _slots_28_io_uop_prs3 : _GEN_14691 ? _slots_27_io_uop_prs3 : _GEN_14529 ? _slots_26_io_uop_prs3 : _GEN_14367 ? _slots_25_io_uop_prs3 : _GEN_14205 ? _slots_24_io_uop_prs3 : _GEN_14043 ? _slots_23_io_uop_prs3 : _GEN_13881 ? _slots_22_io_uop_prs3 : _GEN_13719 ? _slots_21_io_uop_prs3 : _GEN_13557 ? _slots_20_io_uop_prs3 : _GEN_13395 ? _slots_19_io_uop_prs3 : _GEN_13233 ? _slots_18_io_uop_prs3 : _GEN_13071 ? _slots_17_io_uop_prs3 : _GEN_12909 ? _slots_16_io_uop_prs3 : _GEN_12747 ? _slots_15_io_uop_prs3 : _GEN_12585 ? _slots_14_io_uop_prs3 : _GEN_12423 ? _slots_13_io_uop_prs3 : _GEN_12261 ? _slots_12_io_uop_prs3 : _GEN_12099 ? _slots_11_io_uop_prs3 : _GEN_11937 ? _slots_10_io_uop_prs3 : _GEN_11775 ? _slots_9_io_uop_prs3 : _GEN_11613 ? _slots_8_io_uop_prs3 : _GEN_11451 ? _slots_7_io_uop_prs3 : _GEN_11289 ? _slots_6_io_uop_prs3 : _GEN_11127 ? _slots_5_io_uop_prs3 : _GEN_10965 ? _slots_4_io_uop_prs3 : _GEN_10803 ? _slots_3_io_uop_prs3 : _GEN_10641 ? _slots_2_io_uop_prs3 : _GEN_10479 ? _slots_1_io_uop_prs3 : _GEN_10318 ? _slots_0_io_uop_prs3 : 7'h0;
  assign io_iss_uops_0_mem_cmd = _GEN_15339 ? _slots_31_io_uop_mem_cmd : _GEN_15177 ? _slots_30_io_uop_mem_cmd : _GEN_15015 ? _slots_29_io_uop_mem_cmd : _GEN_14853 ? _slots_28_io_uop_mem_cmd : _GEN_14691 ? _slots_27_io_uop_mem_cmd : _GEN_14529 ? _slots_26_io_uop_mem_cmd : _GEN_14367 ? _slots_25_io_uop_mem_cmd : _GEN_14205 ? _slots_24_io_uop_mem_cmd : _GEN_14043 ? _slots_23_io_uop_mem_cmd : _GEN_13881 ? _slots_22_io_uop_mem_cmd : _GEN_13719 ? _slots_21_io_uop_mem_cmd : _GEN_13557 ? _slots_20_io_uop_mem_cmd : _GEN_13395 ? _slots_19_io_uop_mem_cmd : _GEN_13233 ? _slots_18_io_uop_mem_cmd : _GEN_13071 ? _slots_17_io_uop_mem_cmd : _GEN_12909 ? _slots_16_io_uop_mem_cmd : _GEN_12747 ? _slots_15_io_uop_mem_cmd : _GEN_12585 ? _slots_14_io_uop_mem_cmd : _GEN_12423 ? _slots_13_io_uop_mem_cmd : _GEN_12261 ? _slots_12_io_uop_mem_cmd : _GEN_12099 ? _slots_11_io_uop_mem_cmd : _GEN_11937 ? _slots_10_io_uop_mem_cmd : _GEN_11775 ? _slots_9_io_uop_mem_cmd : _GEN_11613 ? _slots_8_io_uop_mem_cmd : _GEN_11451 ? _slots_7_io_uop_mem_cmd : _GEN_11289 ? _slots_6_io_uop_mem_cmd : _GEN_11127 ? _slots_5_io_uop_mem_cmd : _GEN_10965 ? _slots_4_io_uop_mem_cmd : _GEN_10803 ? _slots_3_io_uop_mem_cmd : _GEN_10641 ? _slots_2_io_uop_mem_cmd : _GEN_10479 ? _slots_1_io_uop_mem_cmd : _GEN_10318 ? _slots_0_io_uop_mem_cmd : 5'h0;
  assign io_iss_uops_0_is_amo = _GEN_15339 ? _slots_31_io_uop_is_amo : _GEN_15177 ? _slots_30_io_uop_is_amo : _GEN_15015 ? _slots_29_io_uop_is_amo : _GEN_14853 ? _slots_28_io_uop_is_amo : _GEN_14691 ? _slots_27_io_uop_is_amo : _GEN_14529 ? _slots_26_io_uop_is_amo : _GEN_14367 ? _slots_25_io_uop_is_amo : _GEN_14205 ? _slots_24_io_uop_is_amo : _GEN_14043 ? _slots_23_io_uop_is_amo : _GEN_13881 ? _slots_22_io_uop_is_amo : _GEN_13719 ? _slots_21_io_uop_is_amo : _GEN_13557 ? _slots_20_io_uop_is_amo : _GEN_13395 ? _slots_19_io_uop_is_amo : _GEN_13233 ? _slots_18_io_uop_is_amo : _GEN_13071 ? _slots_17_io_uop_is_amo : _GEN_12909 ? _slots_16_io_uop_is_amo : _GEN_12747 ? _slots_15_io_uop_is_amo : _GEN_12585 ? _slots_14_io_uop_is_amo : _GEN_12423 ? _slots_13_io_uop_is_amo : _GEN_12261 ? _slots_12_io_uop_is_amo : _GEN_12099 ? _slots_11_io_uop_is_amo : _GEN_11937 ? _slots_10_io_uop_is_amo : _GEN_11775 ? _slots_9_io_uop_is_amo : _GEN_11613 ? _slots_8_io_uop_is_amo : _GEN_11451 ? _slots_7_io_uop_is_amo : _GEN_11289 ? _slots_6_io_uop_is_amo : _GEN_11127 ? _slots_5_io_uop_is_amo : _GEN_10965 ? _slots_4_io_uop_is_amo : _GEN_10803 ? _slots_3_io_uop_is_amo : _GEN_10641 ? _slots_2_io_uop_is_amo : _GEN_10479 ? _slots_1_io_uop_is_amo : _GEN_10318 & _slots_0_io_uop_is_amo;
  assign io_iss_uops_0_uses_ldq = _GEN_15339 ? _slots_31_io_uop_uses_ldq : _GEN_15177 ? _slots_30_io_uop_uses_ldq : _GEN_15015 ? _slots_29_io_uop_uses_ldq : _GEN_14853 ? _slots_28_io_uop_uses_ldq : _GEN_14691 ? _slots_27_io_uop_uses_ldq : _GEN_14529 ? _slots_26_io_uop_uses_ldq : _GEN_14367 ? _slots_25_io_uop_uses_ldq : _GEN_14205 ? _slots_24_io_uop_uses_ldq : _GEN_14043 ? _slots_23_io_uop_uses_ldq : _GEN_13881 ? _slots_22_io_uop_uses_ldq : _GEN_13719 ? _slots_21_io_uop_uses_ldq : _GEN_13557 ? _slots_20_io_uop_uses_ldq : _GEN_13395 ? _slots_19_io_uop_uses_ldq : _GEN_13233 ? _slots_18_io_uop_uses_ldq : _GEN_13071 ? _slots_17_io_uop_uses_ldq : _GEN_12909 ? _slots_16_io_uop_uses_ldq : _GEN_12747 ? _slots_15_io_uop_uses_ldq : _GEN_12585 ? _slots_14_io_uop_uses_ldq : _GEN_12423 ? _slots_13_io_uop_uses_ldq : _GEN_12261 ? _slots_12_io_uop_uses_ldq : _GEN_12099 ? _slots_11_io_uop_uses_ldq : _GEN_11937 ? _slots_10_io_uop_uses_ldq : _GEN_11775 ? _slots_9_io_uop_uses_ldq : _GEN_11613 ? _slots_8_io_uop_uses_ldq : _GEN_11451 ? _slots_7_io_uop_uses_ldq : _GEN_11289 ? _slots_6_io_uop_uses_ldq : _GEN_11127 ? _slots_5_io_uop_uses_ldq : _GEN_10965 ? _slots_4_io_uop_uses_ldq : _GEN_10803 ? _slots_3_io_uop_uses_ldq : _GEN_10641 ? _slots_2_io_uop_uses_ldq : _GEN_10479 ? _slots_1_io_uop_uses_ldq : _GEN_10318 & _slots_0_io_uop_uses_ldq;
  assign io_iss_uops_0_uses_stq = _GEN_15339 ? _slots_31_io_uop_uses_stq : _GEN_15177 ? _slots_30_io_uop_uses_stq : _GEN_15015 ? _slots_29_io_uop_uses_stq : _GEN_14853 ? _slots_28_io_uop_uses_stq : _GEN_14691 ? _slots_27_io_uop_uses_stq : _GEN_14529 ? _slots_26_io_uop_uses_stq : _GEN_14367 ? _slots_25_io_uop_uses_stq : _GEN_14205 ? _slots_24_io_uop_uses_stq : _GEN_14043 ? _slots_23_io_uop_uses_stq : _GEN_13881 ? _slots_22_io_uop_uses_stq : _GEN_13719 ? _slots_21_io_uop_uses_stq : _GEN_13557 ? _slots_20_io_uop_uses_stq : _GEN_13395 ? _slots_19_io_uop_uses_stq : _GEN_13233 ? _slots_18_io_uop_uses_stq : _GEN_13071 ? _slots_17_io_uop_uses_stq : _GEN_12909 ? _slots_16_io_uop_uses_stq : _GEN_12747 ? _slots_15_io_uop_uses_stq : _GEN_12585 ? _slots_14_io_uop_uses_stq : _GEN_12423 ? _slots_13_io_uop_uses_stq : _GEN_12261 ? _slots_12_io_uop_uses_stq : _GEN_12099 ? _slots_11_io_uop_uses_stq : _GEN_11937 ? _slots_10_io_uop_uses_stq : _GEN_11775 ? _slots_9_io_uop_uses_stq : _GEN_11613 ? _slots_8_io_uop_uses_stq : _GEN_11451 ? _slots_7_io_uop_uses_stq : _GEN_11289 ? _slots_6_io_uop_uses_stq : _GEN_11127 ? _slots_5_io_uop_uses_stq : _GEN_10965 ? _slots_4_io_uop_uses_stq : _GEN_10803 ? _slots_3_io_uop_uses_stq : _GEN_10641 ? _slots_2_io_uop_uses_stq : _GEN_10479 ? _slots_1_io_uop_uses_stq : _GEN_10318 & _slots_0_io_uop_uses_stq;
  assign io_iss_uops_0_dst_rtype = _GEN_15339 ? _slots_31_io_uop_dst_rtype : _GEN_15177 ? _slots_30_io_uop_dst_rtype : _GEN_15015 ? _slots_29_io_uop_dst_rtype : _GEN_14853 ? _slots_28_io_uop_dst_rtype : _GEN_14691 ? _slots_27_io_uop_dst_rtype : _GEN_14529 ? _slots_26_io_uop_dst_rtype : _GEN_14367 ? _slots_25_io_uop_dst_rtype : _GEN_14205 ? _slots_24_io_uop_dst_rtype : _GEN_14043 ? _slots_23_io_uop_dst_rtype : _GEN_13881 ? _slots_22_io_uop_dst_rtype : _GEN_13719 ? _slots_21_io_uop_dst_rtype : _GEN_13557 ? _slots_20_io_uop_dst_rtype : _GEN_13395 ? _slots_19_io_uop_dst_rtype : _GEN_13233 ? _slots_18_io_uop_dst_rtype : _GEN_13071 ? _slots_17_io_uop_dst_rtype : _GEN_12909 ? _slots_16_io_uop_dst_rtype : _GEN_12747 ? _slots_15_io_uop_dst_rtype : _GEN_12585 ? _slots_14_io_uop_dst_rtype : _GEN_12423 ? _slots_13_io_uop_dst_rtype : _GEN_12261 ? _slots_12_io_uop_dst_rtype : _GEN_12099 ? _slots_11_io_uop_dst_rtype : _GEN_11937 ? _slots_10_io_uop_dst_rtype : _GEN_11775 ? _slots_9_io_uop_dst_rtype : _GEN_11613 ? _slots_8_io_uop_dst_rtype : _GEN_11451 ? _slots_7_io_uop_dst_rtype : _GEN_11289 ? _slots_6_io_uop_dst_rtype : _GEN_11127 ? _slots_5_io_uop_dst_rtype : _GEN_10965 ? _slots_4_io_uop_dst_rtype : _GEN_10803 ? _slots_3_io_uop_dst_rtype : _GEN_10641 ? _slots_2_io_uop_dst_rtype : _GEN_10479 ? _slots_1_io_uop_dst_rtype : _GEN_10318 ? _slots_0_io_uop_dst_rtype : 2'h2;
  assign io_iss_uops_0_fp_val = _GEN_15339 ? _slots_31_io_uop_fp_val : _GEN_15177 ? _slots_30_io_uop_fp_val : _GEN_15015 ? _slots_29_io_uop_fp_val : _GEN_14853 ? _slots_28_io_uop_fp_val : _GEN_14691 ? _slots_27_io_uop_fp_val : _GEN_14529 ? _slots_26_io_uop_fp_val : _GEN_14367 ? _slots_25_io_uop_fp_val : _GEN_14205 ? _slots_24_io_uop_fp_val : _GEN_14043 ? _slots_23_io_uop_fp_val : _GEN_13881 ? _slots_22_io_uop_fp_val : _GEN_13719 ? _slots_21_io_uop_fp_val : _GEN_13557 ? _slots_20_io_uop_fp_val : _GEN_13395 ? _slots_19_io_uop_fp_val : _GEN_13233 ? _slots_18_io_uop_fp_val : _GEN_13071 ? _slots_17_io_uop_fp_val : _GEN_12909 ? _slots_16_io_uop_fp_val : _GEN_12747 ? _slots_15_io_uop_fp_val : _GEN_12585 ? _slots_14_io_uop_fp_val : _GEN_12423 ? _slots_13_io_uop_fp_val : _GEN_12261 ? _slots_12_io_uop_fp_val : _GEN_12099 ? _slots_11_io_uop_fp_val : _GEN_11937 ? _slots_10_io_uop_fp_val : _GEN_11775 ? _slots_9_io_uop_fp_val : _GEN_11613 ? _slots_8_io_uop_fp_val : _GEN_11451 ? _slots_7_io_uop_fp_val : _GEN_11289 ? _slots_6_io_uop_fp_val : _GEN_11127 ? _slots_5_io_uop_fp_val : _GEN_10965 ? _slots_4_io_uop_fp_val : _GEN_10803 ? _slots_3_io_uop_fp_val : _GEN_10641 ? _slots_2_io_uop_fp_val : _GEN_10479 ? _slots_1_io_uop_fp_val : _GEN_10318 & _slots_0_io_uop_fp_val;
  assign io_iss_uops_1_uopc = _GEN_183 ? _slots_31_io_uop_uopc : _GEN_180 ? _slots_30_io_uop_uopc : _GEN_175 ? _slots_29_io_uop_uopc : _GEN_170 ? _slots_28_io_uop_uopc : _GEN_165 ? _slots_27_io_uop_uopc : _GEN_160 ? _slots_26_io_uop_uopc : _GEN_155 ? _slots_25_io_uop_uopc : _GEN_150 ? _slots_24_io_uop_uopc : _GEN_145 ? _slots_23_io_uop_uopc : _GEN_140 ? _slots_22_io_uop_uopc : _GEN_135 ? _slots_21_io_uop_uopc : _GEN_130 ? _slots_20_io_uop_uopc : _GEN_125 ? _slots_19_io_uop_uopc : _GEN_120 ? _slots_18_io_uop_uopc : _GEN_115 ? _slots_17_io_uop_uopc : _GEN_110 ? _slots_16_io_uop_uopc : _GEN_105 ? _slots_15_io_uop_uopc : _GEN_100 ? _slots_14_io_uop_uopc : _GEN_95 ? _slots_13_io_uop_uopc : _GEN_90 ? _slots_12_io_uop_uopc : _GEN_85 ? _slots_11_io_uop_uopc : _GEN_80 ? _slots_10_io_uop_uopc : _GEN_75 ? _slots_9_io_uop_uopc : _GEN_70 ? _slots_8_io_uop_uopc : _GEN_60 ? _slots_7_io_uop_uopc : _GEN_50 ? _slots_6_io_uop_uopc : _GEN_40 ? _slots_5_io_uop_uopc : _GEN_30 ? _slots_4_io_uop_uopc : _GEN_20 ? _slots_3_io_uop_uopc : _GEN_11 ? _slots_2_io_uop_uopc : _GEN_6 ? _slots_1_io_uop_uopc : _GEN_10399 ? _slots_0_io_uop_uopc : 7'h0;
  assign io_iss_uops_1_fu_code = _GEN_183 ? _slots_31_io_uop_fu_code : _GEN_180 ? _slots_30_io_uop_fu_code : _GEN_175 ? _slots_29_io_uop_fu_code : _GEN_170 ? _slots_28_io_uop_fu_code : _GEN_165 ? _slots_27_io_uop_fu_code : _GEN_160 ? _slots_26_io_uop_fu_code : _GEN_155 ? _slots_25_io_uop_fu_code : _GEN_150 ? _slots_24_io_uop_fu_code : _GEN_145 ? _slots_23_io_uop_fu_code : _GEN_140 ? _slots_22_io_uop_fu_code : _GEN_135 ? _slots_21_io_uop_fu_code : _GEN_130 ? _slots_20_io_uop_fu_code : _GEN_125 ? _slots_19_io_uop_fu_code : _GEN_120 ? _slots_18_io_uop_fu_code : _GEN_115 ? _slots_17_io_uop_fu_code : _GEN_110 ? _slots_16_io_uop_fu_code : _GEN_105 ? _slots_15_io_uop_fu_code : _GEN_100 ? _slots_14_io_uop_fu_code : _GEN_95 ? _slots_13_io_uop_fu_code : _GEN_90 ? _slots_12_io_uop_fu_code : _GEN_85 ? _slots_11_io_uop_fu_code : _GEN_80 ? _slots_10_io_uop_fu_code : _GEN_75 ? _slots_9_io_uop_fu_code : _GEN_70 ? _slots_8_io_uop_fu_code : _GEN_60 ? _slots_7_io_uop_fu_code : _GEN_50 ? _slots_6_io_uop_fu_code : _GEN_40 ? _slots_5_io_uop_fu_code : _GEN_30 ? _slots_4_io_uop_fu_code : _GEN_20 ? _slots_3_io_uop_fu_code : _GEN_11 ? _slots_2_io_uop_fu_code : _GEN_6 ? _slots_1_io_uop_fu_code : _GEN_10399 ? _slots_0_io_uop_fu_code : 10'h0;
  assign io_iss_uops_1_br_mask = _GEN_183 ? _slots_31_io_uop_br_mask : _GEN_180 ? _slots_30_io_uop_br_mask : _GEN_175 ? _slots_29_io_uop_br_mask : _GEN_170 ? _slots_28_io_uop_br_mask : _GEN_165 ? _slots_27_io_uop_br_mask : _GEN_160 ? _slots_26_io_uop_br_mask : _GEN_155 ? _slots_25_io_uop_br_mask : _GEN_150 ? _slots_24_io_uop_br_mask : _GEN_145 ? _slots_23_io_uop_br_mask : _GEN_140 ? _slots_22_io_uop_br_mask : _GEN_135 ? _slots_21_io_uop_br_mask : _GEN_130 ? _slots_20_io_uop_br_mask : _GEN_125 ? _slots_19_io_uop_br_mask : _GEN_120 ? _slots_18_io_uop_br_mask : _GEN_115 ? _slots_17_io_uop_br_mask : _GEN_110 ? _slots_16_io_uop_br_mask : _GEN_105 ? _slots_15_io_uop_br_mask : _GEN_100 ? _slots_14_io_uop_br_mask : _GEN_95 ? _slots_13_io_uop_br_mask : _GEN_90 ? _slots_12_io_uop_br_mask : _GEN_85 ? _slots_11_io_uop_br_mask : _GEN_80 ? _slots_10_io_uop_br_mask : _GEN_75 ? _slots_9_io_uop_br_mask : _GEN_70 ? _slots_8_io_uop_br_mask : _GEN_60 ? _slots_7_io_uop_br_mask : _GEN_50 ? _slots_6_io_uop_br_mask : _GEN_40 ? _slots_5_io_uop_br_mask : _GEN_30 ? _slots_4_io_uop_br_mask : _GEN_20 ? _slots_3_io_uop_br_mask : _GEN_11 ? _slots_2_io_uop_br_mask : _GEN_6 ? _slots_1_io_uop_br_mask : _GEN_10399 ? _slots_0_io_uop_br_mask : 20'h0;
  assign io_iss_uops_1_imm_packed = _GEN_183 ? _slots_31_io_uop_imm_packed : _GEN_180 ? _slots_30_io_uop_imm_packed : _GEN_175 ? _slots_29_io_uop_imm_packed : _GEN_170 ? _slots_28_io_uop_imm_packed : _GEN_165 ? _slots_27_io_uop_imm_packed : _GEN_160 ? _slots_26_io_uop_imm_packed : _GEN_155 ? _slots_25_io_uop_imm_packed : _GEN_150 ? _slots_24_io_uop_imm_packed : _GEN_145 ? _slots_23_io_uop_imm_packed : _GEN_140 ? _slots_22_io_uop_imm_packed : _GEN_135 ? _slots_21_io_uop_imm_packed : _GEN_130 ? _slots_20_io_uop_imm_packed : _GEN_125 ? _slots_19_io_uop_imm_packed : _GEN_120 ? _slots_18_io_uop_imm_packed : _GEN_115 ? _slots_17_io_uop_imm_packed : _GEN_110 ? _slots_16_io_uop_imm_packed : _GEN_105 ? _slots_15_io_uop_imm_packed : _GEN_100 ? _slots_14_io_uop_imm_packed : _GEN_95 ? _slots_13_io_uop_imm_packed : _GEN_90 ? _slots_12_io_uop_imm_packed : _GEN_85 ? _slots_11_io_uop_imm_packed : _GEN_80 ? _slots_10_io_uop_imm_packed : _GEN_75 ? _slots_9_io_uop_imm_packed : _GEN_70 ? _slots_8_io_uop_imm_packed : _GEN_60 ? _slots_7_io_uop_imm_packed : _GEN_50 ? _slots_6_io_uop_imm_packed : _GEN_40 ? _slots_5_io_uop_imm_packed : _GEN_30 ? _slots_4_io_uop_imm_packed : _GEN_20 ? _slots_3_io_uop_imm_packed : _GEN_11 ? _slots_2_io_uop_imm_packed : _GEN_6 ? _slots_1_io_uop_imm_packed : _GEN_10399 ? _slots_0_io_uop_imm_packed : 20'h0;
  assign io_iss_uops_1_rob_idx = _GEN_183 ? _slots_31_io_uop_rob_idx : _GEN_180 ? _slots_30_io_uop_rob_idx : _GEN_175 ? _slots_29_io_uop_rob_idx : _GEN_170 ? _slots_28_io_uop_rob_idx : _GEN_165 ? _slots_27_io_uop_rob_idx : _GEN_160 ? _slots_26_io_uop_rob_idx : _GEN_155 ? _slots_25_io_uop_rob_idx : _GEN_150 ? _slots_24_io_uop_rob_idx : _GEN_145 ? _slots_23_io_uop_rob_idx : _GEN_140 ? _slots_22_io_uop_rob_idx : _GEN_135 ? _slots_21_io_uop_rob_idx : _GEN_130 ? _slots_20_io_uop_rob_idx : _GEN_125 ? _slots_19_io_uop_rob_idx : _GEN_120 ? _slots_18_io_uop_rob_idx : _GEN_115 ? _slots_17_io_uop_rob_idx : _GEN_110 ? _slots_16_io_uop_rob_idx : _GEN_105 ? _slots_15_io_uop_rob_idx : _GEN_100 ? _slots_14_io_uop_rob_idx : _GEN_95 ? _slots_13_io_uop_rob_idx : _GEN_90 ? _slots_12_io_uop_rob_idx : _GEN_85 ? _slots_11_io_uop_rob_idx : _GEN_80 ? _slots_10_io_uop_rob_idx : _GEN_75 ? _slots_9_io_uop_rob_idx : _GEN_70 ? _slots_8_io_uop_rob_idx : _GEN_60 ? _slots_7_io_uop_rob_idx : _GEN_50 ? _slots_6_io_uop_rob_idx : _GEN_40 ? _slots_5_io_uop_rob_idx : _GEN_30 ? _slots_4_io_uop_rob_idx : _GEN_20 ? _slots_3_io_uop_rob_idx : _GEN_11 ? _slots_2_io_uop_rob_idx : _GEN_6 ? _slots_1_io_uop_rob_idx : _GEN_10399 ? _slots_0_io_uop_rob_idx : 7'h0;
  assign io_iss_uops_1_stq_idx = _GEN_183 ? _slots_31_io_uop_stq_idx : _GEN_180 ? _slots_30_io_uop_stq_idx : _GEN_175 ? _slots_29_io_uop_stq_idx : _GEN_170 ? _slots_28_io_uop_stq_idx : _GEN_165 ? _slots_27_io_uop_stq_idx : _GEN_160 ? _slots_26_io_uop_stq_idx : _GEN_155 ? _slots_25_io_uop_stq_idx : _GEN_150 ? _slots_24_io_uop_stq_idx : _GEN_145 ? _slots_23_io_uop_stq_idx : _GEN_140 ? _slots_22_io_uop_stq_idx : _GEN_135 ? _slots_21_io_uop_stq_idx : _GEN_130 ? _slots_20_io_uop_stq_idx : _GEN_125 ? _slots_19_io_uop_stq_idx : _GEN_120 ? _slots_18_io_uop_stq_idx : _GEN_115 ? _slots_17_io_uop_stq_idx : _GEN_110 ? _slots_16_io_uop_stq_idx : _GEN_105 ? _slots_15_io_uop_stq_idx : _GEN_100 ? _slots_14_io_uop_stq_idx : _GEN_95 ? _slots_13_io_uop_stq_idx : _GEN_90 ? _slots_12_io_uop_stq_idx : _GEN_85 ? _slots_11_io_uop_stq_idx : _GEN_80 ? _slots_10_io_uop_stq_idx : _GEN_75 ? _slots_9_io_uop_stq_idx : _GEN_70 ? _slots_8_io_uop_stq_idx : _GEN_60 ? _slots_7_io_uop_stq_idx : _GEN_50 ? _slots_6_io_uop_stq_idx : _GEN_40 ? _slots_5_io_uop_stq_idx : _GEN_30 ? _slots_4_io_uop_stq_idx : _GEN_20 ? _slots_3_io_uop_stq_idx : _GEN_11 ? _slots_2_io_uop_stq_idx : _GEN_6 ? _slots_1_io_uop_stq_idx : _GEN_10399 ? _slots_0_io_uop_stq_idx : 5'h0;
  assign io_iss_uops_1_pdst = _GEN_183 ? _slots_31_io_uop_pdst : _GEN_180 ? _slots_30_io_uop_pdst : _GEN_175 ? _slots_29_io_uop_pdst : _GEN_170 ? _slots_28_io_uop_pdst : _GEN_165 ? _slots_27_io_uop_pdst : _GEN_160 ? _slots_26_io_uop_pdst : _GEN_155 ? _slots_25_io_uop_pdst : _GEN_150 ? _slots_24_io_uop_pdst : _GEN_145 ? _slots_23_io_uop_pdst : _GEN_140 ? _slots_22_io_uop_pdst : _GEN_135 ? _slots_21_io_uop_pdst : _GEN_130 ? _slots_20_io_uop_pdst : _GEN_125 ? _slots_19_io_uop_pdst : _GEN_120 ? _slots_18_io_uop_pdst : _GEN_115 ? _slots_17_io_uop_pdst : _GEN_110 ? _slots_16_io_uop_pdst : _GEN_105 ? _slots_15_io_uop_pdst : _GEN_100 ? _slots_14_io_uop_pdst : _GEN_95 ? _slots_13_io_uop_pdst : _GEN_90 ? _slots_12_io_uop_pdst : _GEN_85 ? _slots_11_io_uop_pdst : _GEN_80 ? _slots_10_io_uop_pdst : _GEN_75 ? _slots_9_io_uop_pdst : _GEN_70 ? _slots_8_io_uop_pdst : _GEN_60 ? _slots_7_io_uop_pdst : _GEN_50 ? _slots_6_io_uop_pdst : _GEN_40 ? _slots_5_io_uop_pdst : _GEN_30 ? _slots_4_io_uop_pdst : _GEN_20 ? _slots_3_io_uop_pdst : _GEN_11 ? _slots_2_io_uop_pdst : _GEN_6 ? _slots_1_io_uop_pdst : _GEN_10399 ? _slots_0_io_uop_pdst : 7'h0;
  assign io_iss_uops_1_prs1 = _GEN_183 ? _slots_31_io_uop_prs1 : _GEN_180 ? _slots_30_io_uop_prs1 : _GEN_175 ? _slots_29_io_uop_prs1 : _GEN_170 ? _slots_28_io_uop_prs1 : _GEN_165 ? _slots_27_io_uop_prs1 : _GEN_160 ? _slots_26_io_uop_prs1 : _GEN_155 ? _slots_25_io_uop_prs1 : _GEN_150 ? _slots_24_io_uop_prs1 : _GEN_145 ? _slots_23_io_uop_prs1 : _GEN_140 ? _slots_22_io_uop_prs1 : _GEN_135 ? _slots_21_io_uop_prs1 : _GEN_130 ? _slots_20_io_uop_prs1 : _GEN_125 ? _slots_19_io_uop_prs1 : _GEN_120 ? _slots_18_io_uop_prs1 : _GEN_115 ? _slots_17_io_uop_prs1 : _GEN_110 ? _slots_16_io_uop_prs1 : _GEN_105 ? _slots_15_io_uop_prs1 : _GEN_100 ? _slots_14_io_uop_prs1 : _GEN_95 ? _slots_13_io_uop_prs1 : _GEN_90 ? _slots_12_io_uop_prs1 : _GEN_85 ? _slots_11_io_uop_prs1 : _GEN_80 ? _slots_10_io_uop_prs1 : _GEN_75 ? _slots_9_io_uop_prs1 : _GEN_70 ? _slots_8_io_uop_prs1 : _GEN_60 ? _slots_7_io_uop_prs1 : _GEN_50 ? _slots_6_io_uop_prs1 : _GEN_40 ? _slots_5_io_uop_prs1 : _GEN_30 ? _slots_4_io_uop_prs1 : _GEN_20 ? _slots_3_io_uop_prs1 : _GEN_11 ? _slots_2_io_uop_prs1 : _GEN_6 ? _slots_1_io_uop_prs1 : _GEN_10399 ? _slots_0_io_uop_prs1 : 7'h0;
  assign io_iss_uops_1_prs2 = _GEN_183 ? _slots_31_io_uop_prs2 : _GEN_180 ? _slots_30_io_uop_prs2 : _GEN_175 ? _slots_29_io_uop_prs2 : _GEN_170 ? _slots_28_io_uop_prs2 : _GEN_165 ? _slots_27_io_uop_prs2 : _GEN_160 ? _slots_26_io_uop_prs2 : _GEN_155 ? _slots_25_io_uop_prs2 : _GEN_150 ? _slots_24_io_uop_prs2 : _GEN_145 ? _slots_23_io_uop_prs2 : _GEN_140 ? _slots_22_io_uop_prs2 : _GEN_135 ? _slots_21_io_uop_prs2 : _GEN_130 ? _slots_20_io_uop_prs2 : _GEN_125 ? _slots_19_io_uop_prs2 : _GEN_120 ? _slots_18_io_uop_prs2 : _GEN_115 ? _slots_17_io_uop_prs2 : _GEN_110 ? _slots_16_io_uop_prs2 : _GEN_105 ? _slots_15_io_uop_prs2 : _GEN_100 ? _slots_14_io_uop_prs2 : _GEN_95 ? _slots_13_io_uop_prs2 : _GEN_90 ? _slots_12_io_uop_prs2 : _GEN_85 ? _slots_11_io_uop_prs2 : _GEN_80 ? _slots_10_io_uop_prs2 : _GEN_75 ? _slots_9_io_uop_prs2 : _GEN_70 ? _slots_8_io_uop_prs2 : _GEN_60 ? _slots_7_io_uop_prs2 : _GEN_50 ? _slots_6_io_uop_prs2 : _GEN_40 ? _slots_5_io_uop_prs2 : _GEN_30 ? _slots_4_io_uop_prs2 : _GEN_20 ? _slots_3_io_uop_prs2 : _GEN_11 ? _slots_2_io_uop_prs2 : _GEN_6 ? _slots_1_io_uop_prs2 : _GEN_10399 ? _slots_0_io_uop_prs2 : 7'h0;
  assign io_iss_uops_1_prs3 = _GEN_183 ? _slots_31_io_uop_prs3 : _GEN_180 ? _slots_30_io_uop_prs3 : _GEN_175 ? _slots_29_io_uop_prs3 : _GEN_170 ? _slots_28_io_uop_prs3 : _GEN_165 ? _slots_27_io_uop_prs3 : _GEN_160 ? _slots_26_io_uop_prs3 : _GEN_155 ? _slots_25_io_uop_prs3 : _GEN_150 ? _slots_24_io_uop_prs3 : _GEN_145 ? _slots_23_io_uop_prs3 : _GEN_140 ? _slots_22_io_uop_prs3 : _GEN_135 ? _slots_21_io_uop_prs3 : _GEN_130 ? _slots_20_io_uop_prs3 : _GEN_125 ? _slots_19_io_uop_prs3 : _GEN_120 ? _slots_18_io_uop_prs3 : _GEN_115 ? _slots_17_io_uop_prs3 : _GEN_110 ? _slots_16_io_uop_prs3 : _GEN_105 ? _slots_15_io_uop_prs3 : _GEN_100 ? _slots_14_io_uop_prs3 : _GEN_95 ? _slots_13_io_uop_prs3 : _GEN_90 ? _slots_12_io_uop_prs3 : _GEN_85 ? _slots_11_io_uop_prs3 : _GEN_80 ? _slots_10_io_uop_prs3 : _GEN_75 ? _slots_9_io_uop_prs3 : _GEN_70 ? _slots_8_io_uop_prs3 : _GEN_60 ? _slots_7_io_uop_prs3 : _GEN_50 ? _slots_6_io_uop_prs3 : _GEN_40 ? _slots_5_io_uop_prs3 : _GEN_30 ? _slots_4_io_uop_prs3 : _GEN_20 ? _slots_3_io_uop_prs3 : _GEN_11 ? _slots_2_io_uop_prs3 : _GEN_6 ? _slots_1_io_uop_prs3 : _GEN_10399 ? _slots_0_io_uop_prs3 : 7'h0;
  assign io_iss_uops_1_mem_cmd = _GEN_183 ? _slots_31_io_uop_mem_cmd : _GEN_180 ? _slots_30_io_uop_mem_cmd : _GEN_175 ? _slots_29_io_uop_mem_cmd : _GEN_170 ? _slots_28_io_uop_mem_cmd : _GEN_165 ? _slots_27_io_uop_mem_cmd : _GEN_160 ? _slots_26_io_uop_mem_cmd : _GEN_155 ? _slots_25_io_uop_mem_cmd : _GEN_150 ? _slots_24_io_uop_mem_cmd : _GEN_145 ? _slots_23_io_uop_mem_cmd : _GEN_140 ? _slots_22_io_uop_mem_cmd : _GEN_135 ? _slots_21_io_uop_mem_cmd : _GEN_130 ? _slots_20_io_uop_mem_cmd : _GEN_125 ? _slots_19_io_uop_mem_cmd : _GEN_120 ? _slots_18_io_uop_mem_cmd : _GEN_115 ? _slots_17_io_uop_mem_cmd : _GEN_110 ? _slots_16_io_uop_mem_cmd : _GEN_105 ? _slots_15_io_uop_mem_cmd : _GEN_100 ? _slots_14_io_uop_mem_cmd : _GEN_95 ? _slots_13_io_uop_mem_cmd : _GEN_90 ? _slots_12_io_uop_mem_cmd : _GEN_85 ? _slots_11_io_uop_mem_cmd : _GEN_80 ? _slots_10_io_uop_mem_cmd : _GEN_75 ? _slots_9_io_uop_mem_cmd : _GEN_70 ? _slots_8_io_uop_mem_cmd : _GEN_60 ? _slots_7_io_uop_mem_cmd : _GEN_50 ? _slots_6_io_uop_mem_cmd : _GEN_40 ? _slots_5_io_uop_mem_cmd : _GEN_30 ? _slots_4_io_uop_mem_cmd : _GEN_20 ? _slots_3_io_uop_mem_cmd : _GEN_11 ? _slots_2_io_uop_mem_cmd : _GEN_6 ? _slots_1_io_uop_mem_cmd : _GEN_10399 ? _slots_0_io_uop_mem_cmd : 5'h0;
  assign io_iss_uops_1_is_amo = _GEN_183 ? _slots_31_io_uop_is_amo : _GEN_180 ? _slots_30_io_uop_is_amo : _GEN_175 ? _slots_29_io_uop_is_amo : _GEN_170 ? _slots_28_io_uop_is_amo : _GEN_165 ? _slots_27_io_uop_is_amo : _GEN_160 ? _slots_26_io_uop_is_amo : _GEN_155 ? _slots_25_io_uop_is_amo : _GEN_150 ? _slots_24_io_uop_is_amo : _GEN_145 ? _slots_23_io_uop_is_amo : _GEN_140 ? _slots_22_io_uop_is_amo : _GEN_135 ? _slots_21_io_uop_is_amo : _GEN_130 ? _slots_20_io_uop_is_amo : _GEN_125 ? _slots_19_io_uop_is_amo : _GEN_120 ? _slots_18_io_uop_is_amo : _GEN_115 ? _slots_17_io_uop_is_amo : _GEN_110 ? _slots_16_io_uop_is_amo : _GEN_105 ? _slots_15_io_uop_is_amo : _GEN_100 ? _slots_14_io_uop_is_amo : _GEN_95 ? _slots_13_io_uop_is_amo : _GEN_90 ? _slots_12_io_uop_is_amo : _GEN_85 ? _slots_11_io_uop_is_amo : _GEN_80 ? _slots_10_io_uop_is_amo : _GEN_75 ? _slots_9_io_uop_is_amo : _GEN_70 ? _slots_8_io_uop_is_amo : _GEN_60 ? _slots_7_io_uop_is_amo : _GEN_50 ? _slots_6_io_uop_is_amo : _GEN_40 ? _slots_5_io_uop_is_amo : _GEN_30 ? _slots_4_io_uop_is_amo : _GEN_20 ? _slots_3_io_uop_is_amo : _GEN_11 ? _slots_2_io_uop_is_amo : _GEN_6 ? _slots_1_io_uop_is_amo : _GEN_10399 & _slots_0_io_uop_is_amo;
  assign io_iss_uops_1_uses_ldq = _GEN_183 ? _slots_31_io_uop_uses_ldq : _GEN_180 ? _slots_30_io_uop_uses_ldq : _GEN_175 ? _slots_29_io_uop_uses_ldq : _GEN_170 ? _slots_28_io_uop_uses_ldq : _GEN_165 ? _slots_27_io_uop_uses_ldq : _GEN_160 ? _slots_26_io_uop_uses_ldq : _GEN_155 ? _slots_25_io_uop_uses_ldq : _GEN_150 ? _slots_24_io_uop_uses_ldq : _GEN_145 ? _slots_23_io_uop_uses_ldq : _GEN_140 ? _slots_22_io_uop_uses_ldq : _GEN_135 ? _slots_21_io_uop_uses_ldq : _GEN_130 ? _slots_20_io_uop_uses_ldq : _GEN_125 ? _slots_19_io_uop_uses_ldq : _GEN_120 ? _slots_18_io_uop_uses_ldq : _GEN_115 ? _slots_17_io_uop_uses_ldq : _GEN_110 ? _slots_16_io_uop_uses_ldq : _GEN_105 ? _slots_15_io_uop_uses_ldq : _GEN_100 ? _slots_14_io_uop_uses_ldq : _GEN_95 ? _slots_13_io_uop_uses_ldq : _GEN_90 ? _slots_12_io_uop_uses_ldq : _GEN_85 ? _slots_11_io_uop_uses_ldq : _GEN_80 ? _slots_10_io_uop_uses_ldq : _GEN_75 ? _slots_9_io_uop_uses_ldq : _GEN_70 ? _slots_8_io_uop_uses_ldq : _GEN_60 ? _slots_7_io_uop_uses_ldq : _GEN_50 ? _slots_6_io_uop_uses_ldq : _GEN_40 ? _slots_5_io_uop_uses_ldq : _GEN_30 ? _slots_4_io_uop_uses_ldq : _GEN_20 ? _slots_3_io_uop_uses_ldq : _GEN_11 ? _slots_2_io_uop_uses_ldq : _GEN_6 ? _slots_1_io_uop_uses_ldq : _GEN_10399 & _slots_0_io_uop_uses_ldq;
  assign io_iss_uops_1_uses_stq = _GEN_183 ? _slots_31_io_uop_uses_stq : _GEN_180 ? _slots_30_io_uop_uses_stq : _GEN_175 ? _slots_29_io_uop_uses_stq : _GEN_170 ? _slots_28_io_uop_uses_stq : _GEN_165 ? _slots_27_io_uop_uses_stq : _GEN_160 ? _slots_26_io_uop_uses_stq : _GEN_155 ? _slots_25_io_uop_uses_stq : _GEN_150 ? _slots_24_io_uop_uses_stq : _GEN_145 ? _slots_23_io_uop_uses_stq : _GEN_140 ? _slots_22_io_uop_uses_stq : _GEN_135 ? _slots_21_io_uop_uses_stq : _GEN_130 ? _slots_20_io_uop_uses_stq : _GEN_125 ? _slots_19_io_uop_uses_stq : _GEN_120 ? _slots_18_io_uop_uses_stq : _GEN_115 ? _slots_17_io_uop_uses_stq : _GEN_110 ? _slots_16_io_uop_uses_stq : _GEN_105 ? _slots_15_io_uop_uses_stq : _GEN_100 ? _slots_14_io_uop_uses_stq : _GEN_95 ? _slots_13_io_uop_uses_stq : _GEN_90 ? _slots_12_io_uop_uses_stq : _GEN_85 ? _slots_11_io_uop_uses_stq : _GEN_80 ? _slots_10_io_uop_uses_stq : _GEN_75 ? _slots_9_io_uop_uses_stq : _GEN_70 ? _slots_8_io_uop_uses_stq : _GEN_60 ? _slots_7_io_uop_uses_stq : _GEN_50 ? _slots_6_io_uop_uses_stq : _GEN_40 ? _slots_5_io_uop_uses_stq : _GEN_30 ? _slots_4_io_uop_uses_stq : _GEN_20 ? _slots_3_io_uop_uses_stq : _GEN_11 ? _slots_2_io_uop_uses_stq : _GEN_6 ? _slots_1_io_uop_uses_stq : _GEN_10399 & _slots_0_io_uop_uses_stq;
  assign io_iss_uops_1_dst_rtype = _GEN_183 ? _slots_31_io_uop_dst_rtype : _GEN_180 ? _slots_30_io_uop_dst_rtype : _GEN_175 ? _slots_29_io_uop_dst_rtype : _GEN_170 ? _slots_28_io_uop_dst_rtype : _GEN_165 ? _slots_27_io_uop_dst_rtype : _GEN_160 ? _slots_26_io_uop_dst_rtype : _GEN_155 ? _slots_25_io_uop_dst_rtype : _GEN_150 ? _slots_24_io_uop_dst_rtype : _GEN_145 ? _slots_23_io_uop_dst_rtype : _GEN_140 ? _slots_22_io_uop_dst_rtype : _GEN_135 ? _slots_21_io_uop_dst_rtype : _GEN_130 ? _slots_20_io_uop_dst_rtype : _GEN_125 ? _slots_19_io_uop_dst_rtype : _GEN_120 ? _slots_18_io_uop_dst_rtype : _GEN_115 ? _slots_17_io_uop_dst_rtype : _GEN_110 ? _slots_16_io_uop_dst_rtype : _GEN_105 ? _slots_15_io_uop_dst_rtype : _GEN_100 ? _slots_14_io_uop_dst_rtype : _GEN_95 ? _slots_13_io_uop_dst_rtype : _GEN_90 ? _slots_12_io_uop_dst_rtype : _GEN_85 ? _slots_11_io_uop_dst_rtype : _GEN_80 ? _slots_10_io_uop_dst_rtype : _GEN_75 ? _slots_9_io_uop_dst_rtype : _GEN_70 ? _slots_8_io_uop_dst_rtype : _GEN_60 ? _slots_7_io_uop_dst_rtype : _GEN_50 ? _slots_6_io_uop_dst_rtype : _GEN_40 ? _slots_5_io_uop_dst_rtype : _GEN_30 ? _slots_4_io_uop_dst_rtype : _GEN_20 ? _slots_3_io_uop_dst_rtype : _GEN_11 ? _slots_2_io_uop_dst_rtype : _GEN_6 ? _slots_1_io_uop_dst_rtype : _GEN_10399 ? _slots_0_io_uop_dst_rtype : 2'h2;
  assign io_iss_uops_1_fp_val = _GEN_183 ? _slots_31_io_uop_fp_val : _GEN_180 ? _slots_30_io_uop_fp_val : _GEN_175 ? _slots_29_io_uop_fp_val : _GEN_170 ? _slots_28_io_uop_fp_val : _GEN_165 ? _slots_27_io_uop_fp_val : _GEN_160 ? _slots_26_io_uop_fp_val : _GEN_155 ? _slots_25_io_uop_fp_val : _GEN_150 ? _slots_24_io_uop_fp_val : _GEN_145 ? _slots_23_io_uop_fp_val : _GEN_140 ? _slots_22_io_uop_fp_val : _GEN_135 ? _slots_21_io_uop_fp_val : _GEN_130 ? _slots_20_io_uop_fp_val : _GEN_125 ? _slots_19_io_uop_fp_val : _GEN_120 ? _slots_18_io_uop_fp_val : _GEN_115 ? _slots_17_io_uop_fp_val : _GEN_110 ? _slots_16_io_uop_fp_val : _GEN_105 ? _slots_15_io_uop_fp_val : _GEN_100 ? _slots_14_io_uop_fp_val : _GEN_95 ? _slots_13_io_uop_fp_val : _GEN_90 ? _slots_12_io_uop_fp_val : _GEN_85 ? _slots_11_io_uop_fp_val : _GEN_80 ? _slots_10_io_uop_fp_val : _GEN_75 ? _slots_9_io_uop_fp_val : _GEN_70 ? _slots_8_io_uop_fp_val : _GEN_60 ? _slots_7_io_uop_fp_val : _GEN_50 ? _slots_6_io_uop_fp_val : _GEN_40 ? _slots_5_io_uop_fp_val : _GEN_30 ? _slots_4_io_uop_fp_val : _GEN_20 ? _slots_3_io_uop_fp_val : _GEN_11 ? _slots_2_io_uop_fp_val : _GEN_6 ? _slots_1_io_uop_fp_val : _GEN_10399 & _slots_0_io_uop_fp_val;
endmodule

