// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module IssueUnitCollapsing_1(
  input         clock,
                reset,
                io_dis_uops_0_valid,
  input  [6:0]  io_dis_uops_0_bits_uopc,
  input         io_dis_uops_0_bits_is_rvc,
  input  [9:0]  io_dis_uops_0_bits_fu_code,
  input         io_dis_uops_0_bits_is_br,
                io_dis_uops_0_bits_is_jalr,
                io_dis_uops_0_bits_is_jal,
                io_dis_uops_0_bits_is_sfb,
  input  [19:0] io_dis_uops_0_bits_br_mask,
  input  [4:0]  io_dis_uops_0_bits_br_tag,
  input  [5:0]  io_dis_uops_0_bits_ftq_idx,
  input         io_dis_uops_0_bits_edge_inst,
  input  [5:0]  io_dis_uops_0_bits_pc_lob,
  input         io_dis_uops_0_bits_taken,
  input  [19:0] io_dis_uops_0_bits_imm_packed,
  input  [6:0]  io_dis_uops_0_bits_rob_idx,
  input  [4:0]  io_dis_uops_0_bits_ldq_idx,
                io_dis_uops_0_bits_stq_idx,
  input  [6:0]  io_dis_uops_0_bits_pdst,
                io_dis_uops_0_bits_prs1,
                io_dis_uops_0_bits_prs2,
                io_dis_uops_0_bits_prs3,
  input         io_dis_uops_0_bits_prs1_busy,
                io_dis_uops_0_bits_prs2_busy,
                io_dis_uops_0_bits_exception,
                io_dis_uops_0_bits_bypassable,
  input  [4:0]  io_dis_uops_0_bits_mem_cmd,
  input  [1:0]  io_dis_uops_0_bits_mem_size,
  input         io_dis_uops_0_bits_mem_signed,
                io_dis_uops_0_bits_is_fence,
                io_dis_uops_0_bits_is_fencei,
                io_dis_uops_0_bits_is_amo,
                io_dis_uops_0_bits_uses_ldq,
                io_dis_uops_0_bits_uses_stq,
                io_dis_uops_0_bits_ldst_val,
  input  [1:0]  io_dis_uops_0_bits_dst_rtype,
                io_dis_uops_0_bits_lrs1_rtype,
                io_dis_uops_0_bits_lrs2_rtype,
  input         io_dis_uops_0_bits_fp_val,
                io_dis_uops_1_valid,
  input  [6:0]  io_dis_uops_1_bits_uopc,
  input         io_dis_uops_1_bits_is_rvc,
  input  [9:0]  io_dis_uops_1_bits_fu_code,
  input         io_dis_uops_1_bits_is_br,
                io_dis_uops_1_bits_is_jalr,
                io_dis_uops_1_bits_is_jal,
                io_dis_uops_1_bits_is_sfb,
  input  [19:0] io_dis_uops_1_bits_br_mask,
  input  [4:0]  io_dis_uops_1_bits_br_tag,
  input  [5:0]  io_dis_uops_1_bits_ftq_idx,
  input         io_dis_uops_1_bits_edge_inst,
  input  [5:0]  io_dis_uops_1_bits_pc_lob,
  input         io_dis_uops_1_bits_taken,
  input  [19:0] io_dis_uops_1_bits_imm_packed,
  input  [6:0]  io_dis_uops_1_bits_rob_idx,
  input  [4:0]  io_dis_uops_1_bits_ldq_idx,
                io_dis_uops_1_bits_stq_idx,
  input  [6:0]  io_dis_uops_1_bits_pdst,
                io_dis_uops_1_bits_prs1,
                io_dis_uops_1_bits_prs2,
                io_dis_uops_1_bits_prs3,
  input         io_dis_uops_1_bits_prs1_busy,
                io_dis_uops_1_bits_prs2_busy,
                io_dis_uops_1_bits_exception,
                io_dis_uops_1_bits_bypassable,
  input  [4:0]  io_dis_uops_1_bits_mem_cmd,
  input  [1:0]  io_dis_uops_1_bits_mem_size,
  input         io_dis_uops_1_bits_mem_signed,
                io_dis_uops_1_bits_is_fence,
                io_dis_uops_1_bits_is_fencei,
                io_dis_uops_1_bits_is_amo,
                io_dis_uops_1_bits_uses_ldq,
                io_dis_uops_1_bits_uses_stq,
                io_dis_uops_1_bits_ldst_val,
  input  [1:0]  io_dis_uops_1_bits_dst_rtype,
                io_dis_uops_1_bits_lrs1_rtype,
                io_dis_uops_1_bits_lrs2_rtype,
  input         io_dis_uops_1_bits_fp_val,
                io_dis_uops_2_valid,
  input  [6:0]  io_dis_uops_2_bits_uopc,
  input         io_dis_uops_2_bits_is_rvc,
  input  [9:0]  io_dis_uops_2_bits_fu_code,
  input         io_dis_uops_2_bits_is_br,
                io_dis_uops_2_bits_is_jalr,
                io_dis_uops_2_bits_is_jal,
                io_dis_uops_2_bits_is_sfb,
  input  [19:0] io_dis_uops_2_bits_br_mask,
  input  [4:0]  io_dis_uops_2_bits_br_tag,
  input  [5:0]  io_dis_uops_2_bits_ftq_idx,
  input         io_dis_uops_2_bits_edge_inst,
  input  [5:0]  io_dis_uops_2_bits_pc_lob,
  input         io_dis_uops_2_bits_taken,
  input  [19:0] io_dis_uops_2_bits_imm_packed,
  input  [6:0]  io_dis_uops_2_bits_rob_idx,
  input  [4:0]  io_dis_uops_2_bits_ldq_idx,
                io_dis_uops_2_bits_stq_idx,
  input  [6:0]  io_dis_uops_2_bits_pdst,
                io_dis_uops_2_bits_prs1,
                io_dis_uops_2_bits_prs2,
                io_dis_uops_2_bits_prs3,
  input         io_dis_uops_2_bits_prs1_busy,
                io_dis_uops_2_bits_prs2_busy,
                io_dis_uops_2_bits_exception,
                io_dis_uops_2_bits_bypassable,
  input  [4:0]  io_dis_uops_2_bits_mem_cmd,
  input  [1:0]  io_dis_uops_2_bits_mem_size,
  input         io_dis_uops_2_bits_mem_signed,
                io_dis_uops_2_bits_is_fence,
                io_dis_uops_2_bits_is_fencei,
                io_dis_uops_2_bits_is_amo,
                io_dis_uops_2_bits_uses_ldq,
                io_dis_uops_2_bits_uses_stq,
                io_dis_uops_2_bits_ldst_val,
  input  [1:0]  io_dis_uops_2_bits_dst_rtype,
                io_dis_uops_2_bits_lrs1_rtype,
                io_dis_uops_2_bits_lrs2_rtype,
  input         io_dis_uops_2_bits_fp_val,
                io_dis_uops_3_valid,
  input  [6:0]  io_dis_uops_3_bits_uopc,
  input         io_dis_uops_3_bits_is_rvc,
  input  [9:0]  io_dis_uops_3_bits_fu_code,
  input         io_dis_uops_3_bits_is_br,
                io_dis_uops_3_bits_is_jalr,
                io_dis_uops_3_bits_is_jal,
                io_dis_uops_3_bits_is_sfb,
  input  [19:0] io_dis_uops_3_bits_br_mask,
  input  [4:0]  io_dis_uops_3_bits_br_tag,
  input  [5:0]  io_dis_uops_3_bits_ftq_idx,
  input         io_dis_uops_3_bits_edge_inst,
  input  [5:0]  io_dis_uops_3_bits_pc_lob,
  input         io_dis_uops_3_bits_taken,
  input  [19:0] io_dis_uops_3_bits_imm_packed,
  input  [6:0]  io_dis_uops_3_bits_rob_idx,
  input  [4:0]  io_dis_uops_3_bits_ldq_idx,
                io_dis_uops_3_bits_stq_idx,
  input  [6:0]  io_dis_uops_3_bits_pdst,
                io_dis_uops_3_bits_prs1,
                io_dis_uops_3_bits_prs2,
                io_dis_uops_3_bits_prs3,
  input         io_dis_uops_3_bits_prs1_busy,
                io_dis_uops_3_bits_prs2_busy,
                io_dis_uops_3_bits_exception,
                io_dis_uops_3_bits_bypassable,
  input  [4:0]  io_dis_uops_3_bits_mem_cmd,
  input  [1:0]  io_dis_uops_3_bits_mem_size,
  input         io_dis_uops_3_bits_mem_signed,
                io_dis_uops_3_bits_is_fence,
                io_dis_uops_3_bits_is_fencei,
                io_dis_uops_3_bits_is_amo,
                io_dis_uops_3_bits_uses_ldq,
                io_dis_uops_3_bits_uses_stq,
                io_dis_uops_3_bits_ldst_val,
  input  [1:0]  io_dis_uops_3_bits_dst_rtype,
                io_dis_uops_3_bits_lrs1_rtype,
                io_dis_uops_3_bits_lrs2_rtype,
  input         io_dis_uops_3_bits_fp_val,
                io_wakeup_ports_0_valid,
  input  [6:0]  io_wakeup_ports_0_bits_pdst,
  input         io_wakeup_ports_1_valid,
  input  [6:0]  io_wakeup_ports_1_bits_pdst,
  input         io_wakeup_ports_2_valid,
  input  [6:0]  io_wakeup_ports_2_bits_pdst,
  input         io_wakeup_ports_3_valid,
  input  [6:0]  io_wakeup_ports_3_bits_pdst,
  input         io_wakeup_ports_4_valid,
  input  [6:0]  io_wakeup_ports_4_bits_pdst,
  input         io_wakeup_ports_5_valid,
  input  [6:0]  io_wakeup_ports_5_bits_pdst,
  input         io_wakeup_ports_6_valid,
  input  [6:0]  io_wakeup_ports_6_bits_pdst,
  input         io_wakeup_ports_7_valid,
  input  [6:0]  io_wakeup_ports_7_bits_pdst,
  input         io_wakeup_ports_8_valid,
  input  [6:0]  io_wakeup_ports_8_bits_pdst,
  input         io_wakeup_ports_9_valid,
  input  [6:0]  io_wakeup_ports_9_bits_pdst,
  input         io_spec_ld_wakeup_0_valid,
  input  [6:0]  io_spec_ld_wakeup_0_bits,
  input         io_spec_ld_wakeup_1_valid,
  input  [6:0]  io_spec_ld_wakeup_1_bits,
  input  [9:0]  io_fu_types_0,
                io_fu_types_1,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input         io_flush_pipeline,
                io_ld_miss,
  output        io_dis_uops_0_ready,
                io_dis_uops_1_ready,
                io_dis_uops_2_ready,
                io_dis_uops_3_ready,
                io_iss_valids_0,
                io_iss_valids_1,
  output [6:0]  io_iss_uops_0_uopc,
  output [9:0]  io_iss_uops_0_fu_code,
  output        io_iss_uops_0_iw_p1_poisoned,
                io_iss_uops_0_iw_p2_poisoned,
  output [19:0] io_iss_uops_0_br_mask,
                io_iss_uops_0_imm_packed,
  output [6:0]  io_iss_uops_0_rob_idx,
  output [4:0]  io_iss_uops_0_ldq_idx,
                io_iss_uops_0_stq_idx,
  output [6:0]  io_iss_uops_0_pdst,
                io_iss_uops_0_prs1,
                io_iss_uops_0_prs2,
  output [4:0]  io_iss_uops_0_mem_cmd,
  output [1:0]  io_iss_uops_0_mem_size,
  output        io_iss_uops_0_mem_signed,
                io_iss_uops_0_is_fence,
                io_iss_uops_0_is_amo,
                io_iss_uops_0_uses_ldq,
                io_iss_uops_0_uses_stq,
  output [1:0]  io_iss_uops_0_lrs1_rtype,
                io_iss_uops_0_lrs2_rtype,
  output        io_iss_uops_0_fp_val,
  output [6:0]  io_iss_uops_1_uopc,
  output [9:0]  io_iss_uops_1_fu_code,
  output        io_iss_uops_1_iw_p1_poisoned,
                io_iss_uops_1_iw_p2_poisoned,
  output [19:0] io_iss_uops_1_br_mask,
                io_iss_uops_1_imm_packed,
  output [6:0]  io_iss_uops_1_rob_idx,
  output [4:0]  io_iss_uops_1_ldq_idx,
                io_iss_uops_1_stq_idx,
  output [6:0]  io_iss_uops_1_pdst,
                io_iss_uops_1_prs1,
                io_iss_uops_1_prs2,
  output [4:0]  io_iss_uops_1_mem_cmd,
  output [1:0]  io_iss_uops_1_mem_size,
  output        io_iss_uops_1_mem_signed,
                io_iss_uops_1_is_fence,
                io_iss_uops_1_is_amo,
                io_iss_uops_1_uses_ldq,
                io_iss_uops_1_uses_stq,
  output [1:0]  io_iss_uops_1_lrs1_rtype,
                io_iss_uops_1_lrs2_rtype,
  output        io_iss_uops_1_fp_val
);

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
  wire [1:0]  _GEN_23_1to0;
  wire        _slots_23_io_valid;
  wire        _slots_23_io_will_be_valid;
  wire        _slots_23_io_request;
  wire [6:0]  _slots_23_io_out_uop_uopc;
  wire        _slots_23_io_out_uop_is_rvc;
  wire [9:0]  _slots_23_io_out_uop_fu_code;
  wire [1:0]  _slots_23_io_out_uop_iw_state;
  wire        _slots_23_io_out_uop_iw_p1_poisoned;
  wire        _slots_23_io_out_uop_iw_p2_poisoned;
  wire        _slots_23_io_out_uop_is_br;
  wire        _slots_23_io_out_uop_is_jalr;
  wire        _slots_23_io_out_uop_is_jal;
  wire        _slots_23_io_out_uop_is_sfb;
  wire [19:0] _slots_23_io_out_uop_br_mask;
  wire [4:0]  _slots_23_io_out_uop_br_tag;
  wire [5:0]  _slots_23_io_out_uop_ftq_idx;
  wire        _slots_23_io_out_uop_edge_inst;
  wire [5:0]  _slots_23_io_out_uop_pc_lob;
  wire        _slots_23_io_out_uop_taken;
  wire [19:0] _slots_23_io_out_uop_imm_packed;
  wire [6:0]  _slots_23_io_out_uop_rob_idx;
  wire [4:0]  _slots_23_io_out_uop_ldq_idx;
  wire [4:0]  _slots_23_io_out_uop_stq_idx;
  wire [6:0]  _slots_23_io_out_uop_pdst;
  wire [6:0]  _slots_23_io_out_uop_prs1;
  wire [6:0]  _slots_23_io_out_uop_prs2;
  wire [6:0]  _slots_23_io_out_uop_prs3;
  wire        _slots_23_io_out_uop_prs1_busy;
  wire        _slots_23_io_out_uop_prs2_busy;
  wire        _slots_23_io_out_uop_prs3_busy;
  wire        _slots_23_io_out_uop_ppred_busy;
  wire        _slots_23_io_out_uop_bypassable;
  wire [4:0]  _slots_23_io_out_uop_mem_cmd;
  wire [1:0]  _slots_23_io_out_uop_mem_size;
  wire        _slots_23_io_out_uop_mem_signed;
  wire        _slots_23_io_out_uop_is_fence;
  wire        _slots_23_io_out_uop_is_amo;
  wire        _slots_23_io_out_uop_uses_ldq;
  wire        _slots_23_io_out_uop_uses_stq;
  wire        _slots_23_io_out_uop_ldst_val;
  wire [1:0]  _slots_23_io_out_uop_dst_rtype;
  wire [1:0]  _slots_23_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_23_io_out_uop_lrs2_rtype;
  wire        _slots_23_io_out_uop_fp_val;
  wire [6:0]  _slots_23_io_uop_uopc;
  wire [9:0]  _slots_23_io_uop_fu_code;
  wire        _slots_23_io_uop_iw_p1_poisoned;
  wire        _slots_23_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_23_io_uop_br_mask;
  wire [19:0] _slots_23_io_uop_imm_packed;
  wire [6:0]  _slots_23_io_uop_rob_idx;
  wire [4:0]  _slots_23_io_uop_ldq_idx;
  wire [4:0]  _slots_23_io_uop_stq_idx;
  wire [6:0]  _slots_23_io_uop_pdst;
  wire [6:0]  _slots_23_io_uop_prs1;
  wire [6:0]  _slots_23_io_uop_prs2;
  wire [4:0]  _slots_23_io_uop_mem_cmd;
  wire [1:0]  _slots_23_io_uop_mem_size;
  wire        _slots_23_io_uop_mem_signed;
  wire        _slots_23_io_uop_is_fence;
  wire        _slots_23_io_uop_is_amo;
  wire        _slots_23_io_uop_uses_ldq;
  wire        _slots_23_io_uop_uses_stq;
  wire [1:0]  _slots_23_io_uop_lrs1_rtype;
  wire [1:0]  _slots_23_io_uop_lrs2_rtype;
  wire        _slots_23_io_uop_fp_val;
  wire        _slots_22_io_valid;
  wire        _slots_22_io_will_be_valid;
  wire        _slots_22_io_request;
  wire [6:0]  _slots_22_io_out_uop_uopc;
  wire        _slots_22_io_out_uop_is_rvc;
  wire [9:0]  _slots_22_io_out_uop_fu_code;
  wire [1:0]  _slots_22_io_out_uop_iw_state;
  wire        _slots_22_io_out_uop_iw_p1_poisoned;
  wire        _slots_22_io_out_uop_iw_p2_poisoned;
  wire        _slots_22_io_out_uop_is_br;
  wire        _slots_22_io_out_uop_is_jalr;
  wire        _slots_22_io_out_uop_is_jal;
  wire        _slots_22_io_out_uop_is_sfb;
  wire [19:0] _slots_22_io_out_uop_br_mask;
  wire [4:0]  _slots_22_io_out_uop_br_tag;
  wire [5:0]  _slots_22_io_out_uop_ftq_idx;
  wire        _slots_22_io_out_uop_edge_inst;
  wire [5:0]  _slots_22_io_out_uop_pc_lob;
  wire        _slots_22_io_out_uop_taken;
  wire [19:0] _slots_22_io_out_uop_imm_packed;
  wire [6:0]  _slots_22_io_out_uop_rob_idx;
  wire [4:0]  _slots_22_io_out_uop_ldq_idx;
  wire [4:0]  _slots_22_io_out_uop_stq_idx;
  wire [6:0]  _slots_22_io_out_uop_pdst;
  wire [6:0]  _slots_22_io_out_uop_prs1;
  wire [6:0]  _slots_22_io_out_uop_prs2;
  wire [6:0]  _slots_22_io_out_uop_prs3;
  wire        _slots_22_io_out_uop_prs1_busy;
  wire        _slots_22_io_out_uop_prs2_busy;
  wire        _slots_22_io_out_uop_prs3_busy;
  wire        _slots_22_io_out_uop_ppred_busy;
  wire        _slots_22_io_out_uop_bypassable;
  wire [4:0]  _slots_22_io_out_uop_mem_cmd;
  wire [1:0]  _slots_22_io_out_uop_mem_size;
  wire        _slots_22_io_out_uop_mem_signed;
  wire        _slots_22_io_out_uop_is_fence;
  wire        _slots_22_io_out_uop_is_amo;
  wire        _slots_22_io_out_uop_uses_ldq;
  wire        _slots_22_io_out_uop_uses_stq;
  wire        _slots_22_io_out_uop_ldst_val;
  wire [1:0]  _slots_22_io_out_uop_dst_rtype;
  wire [1:0]  _slots_22_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_22_io_out_uop_lrs2_rtype;
  wire        _slots_22_io_out_uop_fp_val;
  wire [6:0]  _slots_22_io_uop_uopc;
  wire [9:0]  _slots_22_io_uop_fu_code;
  wire        _slots_22_io_uop_iw_p1_poisoned;
  wire        _slots_22_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_22_io_uop_br_mask;
  wire [19:0] _slots_22_io_uop_imm_packed;
  wire [6:0]  _slots_22_io_uop_rob_idx;
  wire [4:0]  _slots_22_io_uop_ldq_idx;
  wire [4:0]  _slots_22_io_uop_stq_idx;
  wire [6:0]  _slots_22_io_uop_pdst;
  wire [6:0]  _slots_22_io_uop_prs1;
  wire [6:0]  _slots_22_io_uop_prs2;
  wire [4:0]  _slots_22_io_uop_mem_cmd;
  wire [1:0]  _slots_22_io_uop_mem_size;
  wire        _slots_22_io_uop_mem_signed;
  wire        _slots_22_io_uop_is_fence;
  wire        _slots_22_io_uop_is_amo;
  wire        _slots_22_io_uop_uses_ldq;
  wire        _slots_22_io_uop_uses_stq;
  wire [1:0]  _slots_22_io_uop_lrs1_rtype;
  wire [1:0]  _slots_22_io_uop_lrs2_rtype;
  wire        _slots_22_io_uop_fp_val;
  wire        _slots_21_io_valid;
  wire        _slots_21_io_will_be_valid;
  wire        _slots_21_io_request;
  wire [6:0]  _slots_21_io_out_uop_uopc;
  wire        _slots_21_io_out_uop_is_rvc;
  wire [9:0]  _slots_21_io_out_uop_fu_code;
  wire [1:0]  _slots_21_io_out_uop_iw_state;
  wire        _slots_21_io_out_uop_iw_p1_poisoned;
  wire        _slots_21_io_out_uop_iw_p2_poisoned;
  wire        _slots_21_io_out_uop_is_br;
  wire        _slots_21_io_out_uop_is_jalr;
  wire        _slots_21_io_out_uop_is_jal;
  wire        _slots_21_io_out_uop_is_sfb;
  wire [19:0] _slots_21_io_out_uop_br_mask;
  wire [4:0]  _slots_21_io_out_uop_br_tag;
  wire [5:0]  _slots_21_io_out_uop_ftq_idx;
  wire        _slots_21_io_out_uop_edge_inst;
  wire [5:0]  _slots_21_io_out_uop_pc_lob;
  wire        _slots_21_io_out_uop_taken;
  wire [19:0] _slots_21_io_out_uop_imm_packed;
  wire [6:0]  _slots_21_io_out_uop_rob_idx;
  wire [4:0]  _slots_21_io_out_uop_ldq_idx;
  wire [4:0]  _slots_21_io_out_uop_stq_idx;
  wire [6:0]  _slots_21_io_out_uop_pdst;
  wire [6:0]  _slots_21_io_out_uop_prs1;
  wire [6:0]  _slots_21_io_out_uop_prs2;
  wire [6:0]  _slots_21_io_out_uop_prs3;
  wire        _slots_21_io_out_uop_prs1_busy;
  wire        _slots_21_io_out_uop_prs2_busy;
  wire        _slots_21_io_out_uop_prs3_busy;
  wire        _slots_21_io_out_uop_ppred_busy;
  wire        _slots_21_io_out_uop_bypassable;
  wire [4:0]  _slots_21_io_out_uop_mem_cmd;
  wire [1:0]  _slots_21_io_out_uop_mem_size;
  wire        _slots_21_io_out_uop_mem_signed;
  wire        _slots_21_io_out_uop_is_fence;
  wire        _slots_21_io_out_uop_is_amo;
  wire        _slots_21_io_out_uop_uses_ldq;
  wire        _slots_21_io_out_uop_uses_stq;
  wire        _slots_21_io_out_uop_ldst_val;
  wire [1:0]  _slots_21_io_out_uop_dst_rtype;
  wire [1:0]  _slots_21_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_21_io_out_uop_lrs2_rtype;
  wire        _slots_21_io_out_uop_fp_val;
  wire [6:0]  _slots_21_io_uop_uopc;
  wire [9:0]  _slots_21_io_uop_fu_code;
  wire        _slots_21_io_uop_iw_p1_poisoned;
  wire        _slots_21_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_21_io_uop_br_mask;
  wire [19:0] _slots_21_io_uop_imm_packed;
  wire [6:0]  _slots_21_io_uop_rob_idx;
  wire [4:0]  _slots_21_io_uop_ldq_idx;
  wire [4:0]  _slots_21_io_uop_stq_idx;
  wire [6:0]  _slots_21_io_uop_pdst;
  wire [6:0]  _slots_21_io_uop_prs1;
  wire [6:0]  _slots_21_io_uop_prs2;
  wire [4:0]  _slots_21_io_uop_mem_cmd;
  wire [1:0]  _slots_21_io_uop_mem_size;
  wire        _slots_21_io_uop_mem_signed;
  wire        _slots_21_io_uop_is_fence;
  wire        _slots_21_io_uop_is_amo;
  wire        _slots_21_io_uop_uses_ldq;
  wire        _slots_21_io_uop_uses_stq;
  wire [1:0]  _slots_21_io_uop_lrs1_rtype;
  wire [1:0]  _slots_21_io_uop_lrs2_rtype;
  wire        _slots_21_io_uop_fp_val;
  wire        _slots_20_io_valid;
  wire        _slots_20_io_will_be_valid;
  wire        _slots_20_io_request;
  wire [6:0]  _slots_20_io_out_uop_uopc;
  wire        _slots_20_io_out_uop_is_rvc;
  wire [9:0]  _slots_20_io_out_uop_fu_code;
  wire [1:0]  _slots_20_io_out_uop_iw_state;
  wire        _slots_20_io_out_uop_iw_p1_poisoned;
  wire        _slots_20_io_out_uop_iw_p2_poisoned;
  wire        _slots_20_io_out_uop_is_br;
  wire        _slots_20_io_out_uop_is_jalr;
  wire        _slots_20_io_out_uop_is_jal;
  wire        _slots_20_io_out_uop_is_sfb;
  wire [19:0] _slots_20_io_out_uop_br_mask;
  wire [4:0]  _slots_20_io_out_uop_br_tag;
  wire [5:0]  _slots_20_io_out_uop_ftq_idx;
  wire        _slots_20_io_out_uop_edge_inst;
  wire [5:0]  _slots_20_io_out_uop_pc_lob;
  wire        _slots_20_io_out_uop_taken;
  wire [19:0] _slots_20_io_out_uop_imm_packed;
  wire [6:0]  _slots_20_io_out_uop_rob_idx;
  wire [4:0]  _slots_20_io_out_uop_ldq_idx;
  wire [4:0]  _slots_20_io_out_uop_stq_idx;
  wire [6:0]  _slots_20_io_out_uop_pdst;
  wire [6:0]  _slots_20_io_out_uop_prs1;
  wire [6:0]  _slots_20_io_out_uop_prs2;
  wire [6:0]  _slots_20_io_out_uop_prs3;
  wire        _slots_20_io_out_uop_prs1_busy;
  wire        _slots_20_io_out_uop_prs2_busy;
  wire        _slots_20_io_out_uop_prs3_busy;
  wire        _slots_20_io_out_uop_ppred_busy;
  wire        _slots_20_io_out_uop_bypassable;
  wire [4:0]  _slots_20_io_out_uop_mem_cmd;
  wire [1:0]  _slots_20_io_out_uop_mem_size;
  wire        _slots_20_io_out_uop_mem_signed;
  wire        _slots_20_io_out_uop_is_fence;
  wire        _slots_20_io_out_uop_is_amo;
  wire        _slots_20_io_out_uop_uses_ldq;
  wire        _slots_20_io_out_uop_uses_stq;
  wire        _slots_20_io_out_uop_ldst_val;
  wire [1:0]  _slots_20_io_out_uop_dst_rtype;
  wire [1:0]  _slots_20_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_20_io_out_uop_lrs2_rtype;
  wire        _slots_20_io_out_uop_fp_val;
  wire [6:0]  _slots_20_io_uop_uopc;
  wire [9:0]  _slots_20_io_uop_fu_code;
  wire        _slots_20_io_uop_iw_p1_poisoned;
  wire        _slots_20_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_20_io_uop_br_mask;
  wire [19:0] _slots_20_io_uop_imm_packed;
  wire [6:0]  _slots_20_io_uop_rob_idx;
  wire [4:0]  _slots_20_io_uop_ldq_idx;
  wire [4:0]  _slots_20_io_uop_stq_idx;
  wire [6:0]  _slots_20_io_uop_pdst;
  wire [6:0]  _slots_20_io_uop_prs1;
  wire [6:0]  _slots_20_io_uop_prs2;
  wire [4:0]  _slots_20_io_uop_mem_cmd;
  wire [1:0]  _slots_20_io_uop_mem_size;
  wire        _slots_20_io_uop_mem_signed;
  wire        _slots_20_io_uop_is_fence;
  wire        _slots_20_io_uop_is_amo;
  wire        _slots_20_io_uop_uses_ldq;
  wire        _slots_20_io_uop_uses_stq;
  wire [1:0]  _slots_20_io_uop_lrs1_rtype;
  wire [1:0]  _slots_20_io_uop_lrs2_rtype;
  wire        _slots_20_io_uop_fp_val;
  wire        _slots_19_io_valid;
  wire        _slots_19_io_will_be_valid;
  wire        _slots_19_io_request;
  wire [6:0]  _slots_19_io_out_uop_uopc;
  wire        _slots_19_io_out_uop_is_rvc;
  wire [9:0]  _slots_19_io_out_uop_fu_code;
  wire [1:0]  _slots_19_io_out_uop_iw_state;
  wire        _slots_19_io_out_uop_iw_p1_poisoned;
  wire        _slots_19_io_out_uop_iw_p2_poisoned;
  wire        _slots_19_io_out_uop_is_br;
  wire        _slots_19_io_out_uop_is_jalr;
  wire        _slots_19_io_out_uop_is_jal;
  wire        _slots_19_io_out_uop_is_sfb;
  wire [19:0] _slots_19_io_out_uop_br_mask;
  wire [4:0]  _slots_19_io_out_uop_br_tag;
  wire [5:0]  _slots_19_io_out_uop_ftq_idx;
  wire        _slots_19_io_out_uop_edge_inst;
  wire [5:0]  _slots_19_io_out_uop_pc_lob;
  wire        _slots_19_io_out_uop_taken;
  wire [19:0] _slots_19_io_out_uop_imm_packed;
  wire [6:0]  _slots_19_io_out_uop_rob_idx;
  wire [4:0]  _slots_19_io_out_uop_ldq_idx;
  wire [4:0]  _slots_19_io_out_uop_stq_idx;
  wire [6:0]  _slots_19_io_out_uop_pdst;
  wire [6:0]  _slots_19_io_out_uop_prs1;
  wire [6:0]  _slots_19_io_out_uop_prs2;
  wire [6:0]  _slots_19_io_out_uop_prs3;
  wire        _slots_19_io_out_uop_prs1_busy;
  wire        _slots_19_io_out_uop_prs2_busy;
  wire        _slots_19_io_out_uop_prs3_busy;
  wire        _slots_19_io_out_uop_ppred_busy;
  wire        _slots_19_io_out_uop_bypassable;
  wire [4:0]  _slots_19_io_out_uop_mem_cmd;
  wire [1:0]  _slots_19_io_out_uop_mem_size;
  wire        _slots_19_io_out_uop_mem_signed;
  wire        _slots_19_io_out_uop_is_fence;
  wire        _slots_19_io_out_uop_is_amo;
  wire        _slots_19_io_out_uop_uses_ldq;
  wire        _slots_19_io_out_uop_uses_stq;
  wire        _slots_19_io_out_uop_ldst_val;
  wire [1:0]  _slots_19_io_out_uop_dst_rtype;
  wire [1:0]  _slots_19_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_19_io_out_uop_lrs2_rtype;
  wire        _slots_19_io_out_uop_fp_val;
  wire [6:0]  _slots_19_io_uop_uopc;
  wire [9:0]  _slots_19_io_uop_fu_code;
  wire        _slots_19_io_uop_iw_p1_poisoned;
  wire        _slots_19_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_19_io_uop_br_mask;
  wire [19:0] _slots_19_io_uop_imm_packed;
  wire [6:0]  _slots_19_io_uop_rob_idx;
  wire [4:0]  _slots_19_io_uop_ldq_idx;
  wire [4:0]  _slots_19_io_uop_stq_idx;
  wire [6:0]  _slots_19_io_uop_pdst;
  wire [6:0]  _slots_19_io_uop_prs1;
  wire [6:0]  _slots_19_io_uop_prs2;
  wire [4:0]  _slots_19_io_uop_mem_cmd;
  wire [1:0]  _slots_19_io_uop_mem_size;
  wire        _slots_19_io_uop_mem_signed;
  wire        _slots_19_io_uop_is_fence;
  wire        _slots_19_io_uop_is_amo;
  wire        _slots_19_io_uop_uses_ldq;
  wire        _slots_19_io_uop_uses_stq;
  wire [1:0]  _slots_19_io_uop_lrs1_rtype;
  wire [1:0]  _slots_19_io_uop_lrs2_rtype;
  wire        _slots_19_io_uop_fp_val;
  wire        _slots_18_io_valid;
  wire        _slots_18_io_will_be_valid;
  wire        _slots_18_io_request;
  wire [6:0]  _slots_18_io_out_uop_uopc;
  wire        _slots_18_io_out_uop_is_rvc;
  wire [9:0]  _slots_18_io_out_uop_fu_code;
  wire [1:0]  _slots_18_io_out_uop_iw_state;
  wire        _slots_18_io_out_uop_iw_p1_poisoned;
  wire        _slots_18_io_out_uop_iw_p2_poisoned;
  wire        _slots_18_io_out_uop_is_br;
  wire        _slots_18_io_out_uop_is_jalr;
  wire        _slots_18_io_out_uop_is_jal;
  wire        _slots_18_io_out_uop_is_sfb;
  wire [19:0] _slots_18_io_out_uop_br_mask;
  wire [4:0]  _slots_18_io_out_uop_br_tag;
  wire [5:0]  _slots_18_io_out_uop_ftq_idx;
  wire        _slots_18_io_out_uop_edge_inst;
  wire [5:0]  _slots_18_io_out_uop_pc_lob;
  wire        _slots_18_io_out_uop_taken;
  wire [19:0] _slots_18_io_out_uop_imm_packed;
  wire [6:0]  _slots_18_io_out_uop_rob_idx;
  wire [4:0]  _slots_18_io_out_uop_ldq_idx;
  wire [4:0]  _slots_18_io_out_uop_stq_idx;
  wire [6:0]  _slots_18_io_out_uop_pdst;
  wire [6:0]  _slots_18_io_out_uop_prs1;
  wire [6:0]  _slots_18_io_out_uop_prs2;
  wire [6:0]  _slots_18_io_out_uop_prs3;
  wire        _slots_18_io_out_uop_prs1_busy;
  wire        _slots_18_io_out_uop_prs2_busy;
  wire        _slots_18_io_out_uop_prs3_busy;
  wire        _slots_18_io_out_uop_ppred_busy;
  wire        _slots_18_io_out_uop_bypassable;
  wire [4:0]  _slots_18_io_out_uop_mem_cmd;
  wire [1:0]  _slots_18_io_out_uop_mem_size;
  wire        _slots_18_io_out_uop_mem_signed;
  wire        _slots_18_io_out_uop_is_fence;
  wire        _slots_18_io_out_uop_is_amo;
  wire        _slots_18_io_out_uop_uses_ldq;
  wire        _slots_18_io_out_uop_uses_stq;
  wire        _slots_18_io_out_uop_ldst_val;
  wire [1:0]  _slots_18_io_out_uop_dst_rtype;
  wire [1:0]  _slots_18_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_18_io_out_uop_lrs2_rtype;
  wire        _slots_18_io_out_uop_fp_val;
  wire [6:0]  _slots_18_io_uop_uopc;
  wire [9:0]  _slots_18_io_uop_fu_code;
  wire        _slots_18_io_uop_iw_p1_poisoned;
  wire        _slots_18_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_18_io_uop_br_mask;
  wire [19:0] _slots_18_io_uop_imm_packed;
  wire [6:0]  _slots_18_io_uop_rob_idx;
  wire [4:0]  _slots_18_io_uop_ldq_idx;
  wire [4:0]  _slots_18_io_uop_stq_idx;
  wire [6:0]  _slots_18_io_uop_pdst;
  wire [6:0]  _slots_18_io_uop_prs1;
  wire [6:0]  _slots_18_io_uop_prs2;
  wire [4:0]  _slots_18_io_uop_mem_cmd;
  wire [1:0]  _slots_18_io_uop_mem_size;
  wire        _slots_18_io_uop_mem_signed;
  wire        _slots_18_io_uop_is_fence;
  wire        _slots_18_io_uop_is_amo;
  wire        _slots_18_io_uop_uses_ldq;
  wire        _slots_18_io_uop_uses_stq;
  wire [1:0]  _slots_18_io_uop_lrs1_rtype;
  wire [1:0]  _slots_18_io_uop_lrs2_rtype;
  wire        _slots_18_io_uop_fp_val;
  wire        _slots_17_io_valid;
  wire        _slots_17_io_will_be_valid;
  wire        _slots_17_io_request;
  wire [6:0]  _slots_17_io_out_uop_uopc;
  wire        _slots_17_io_out_uop_is_rvc;
  wire [9:0]  _slots_17_io_out_uop_fu_code;
  wire [1:0]  _slots_17_io_out_uop_iw_state;
  wire        _slots_17_io_out_uop_iw_p1_poisoned;
  wire        _slots_17_io_out_uop_iw_p2_poisoned;
  wire        _slots_17_io_out_uop_is_br;
  wire        _slots_17_io_out_uop_is_jalr;
  wire        _slots_17_io_out_uop_is_jal;
  wire        _slots_17_io_out_uop_is_sfb;
  wire [19:0] _slots_17_io_out_uop_br_mask;
  wire [4:0]  _slots_17_io_out_uop_br_tag;
  wire [5:0]  _slots_17_io_out_uop_ftq_idx;
  wire        _slots_17_io_out_uop_edge_inst;
  wire [5:0]  _slots_17_io_out_uop_pc_lob;
  wire        _slots_17_io_out_uop_taken;
  wire [19:0] _slots_17_io_out_uop_imm_packed;
  wire [6:0]  _slots_17_io_out_uop_rob_idx;
  wire [4:0]  _slots_17_io_out_uop_ldq_idx;
  wire [4:0]  _slots_17_io_out_uop_stq_idx;
  wire [6:0]  _slots_17_io_out_uop_pdst;
  wire [6:0]  _slots_17_io_out_uop_prs1;
  wire [6:0]  _slots_17_io_out_uop_prs2;
  wire [6:0]  _slots_17_io_out_uop_prs3;
  wire        _slots_17_io_out_uop_prs1_busy;
  wire        _slots_17_io_out_uop_prs2_busy;
  wire        _slots_17_io_out_uop_prs3_busy;
  wire        _slots_17_io_out_uop_ppred_busy;
  wire        _slots_17_io_out_uop_bypassable;
  wire [4:0]  _slots_17_io_out_uop_mem_cmd;
  wire [1:0]  _slots_17_io_out_uop_mem_size;
  wire        _slots_17_io_out_uop_mem_signed;
  wire        _slots_17_io_out_uop_is_fence;
  wire        _slots_17_io_out_uop_is_amo;
  wire        _slots_17_io_out_uop_uses_ldq;
  wire        _slots_17_io_out_uop_uses_stq;
  wire        _slots_17_io_out_uop_ldst_val;
  wire [1:0]  _slots_17_io_out_uop_dst_rtype;
  wire [1:0]  _slots_17_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_17_io_out_uop_lrs2_rtype;
  wire        _slots_17_io_out_uop_fp_val;
  wire [6:0]  _slots_17_io_uop_uopc;
  wire [9:0]  _slots_17_io_uop_fu_code;
  wire        _slots_17_io_uop_iw_p1_poisoned;
  wire        _slots_17_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_17_io_uop_br_mask;
  wire [19:0] _slots_17_io_uop_imm_packed;
  wire [6:0]  _slots_17_io_uop_rob_idx;
  wire [4:0]  _slots_17_io_uop_ldq_idx;
  wire [4:0]  _slots_17_io_uop_stq_idx;
  wire [6:0]  _slots_17_io_uop_pdst;
  wire [6:0]  _slots_17_io_uop_prs1;
  wire [6:0]  _slots_17_io_uop_prs2;
  wire [4:0]  _slots_17_io_uop_mem_cmd;
  wire [1:0]  _slots_17_io_uop_mem_size;
  wire        _slots_17_io_uop_mem_signed;
  wire        _slots_17_io_uop_is_fence;
  wire        _slots_17_io_uop_is_amo;
  wire        _slots_17_io_uop_uses_ldq;
  wire        _slots_17_io_uop_uses_stq;
  wire [1:0]  _slots_17_io_uop_lrs1_rtype;
  wire [1:0]  _slots_17_io_uop_lrs2_rtype;
  wire        _slots_17_io_uop_fp_val;
  wire        _slots_16_io_valid;
  wire        _slots_16_io_will_be_valid;
  wire        _slots_16_io_request;
  wire [6:0]  _slots_16_io_out_uop_uopc;
  wire        _slots_16_io_out_uop_is_rvc;
  wire [9:0]  _slots_16_io_out_uop_fu_code;
  wire [1:0]  _slots_16_io_out_uop_iw_state;
  wire        _slots_16_io_out_uop_iw_p1_poisoned;
  wire        _slots_16_io_out_uop_iw_p2_poisoned;
  wire        _slots_16_io_out_uop_is_br;
  wire        _slots_16_io_out_uop_is_jalr;
  wire        _slots_16_io_out_uop_is_jal;
  wire        _slots_16_io_out_uop_is_sfb;
  wire [19:0] _slots_16_io_out_uop_br_mask;
  wire [4:0]  _slots_16_io_out_uop_br_tag;
  wire [5:0]  _slots_16_io_out_uop_ftq_idx;
  wire        _slots_16_io_out_uop_edge_inst;
  wire [5:0]  _slots_16_io_out_uop_pc_lob;
  wire        _slots_16_io_out_uop_taken;
  wire [19:0] _slots_16_io_out_uop_imm_packed;
  wire [6:0]  _slots_16_io_out_uop_rob_idx;
  wire [4:0]  _slots_16_io_out_uop_ldq_idx;
  wire [4:0]  _slots_16_io_out_uop_stq_idx;
  wire [6:0]  _slots_16_io_out_uop_pdst;
  wire [6:0]  _slots_16_io_out_uop_prs1;
  wire [6:0]  _slots_16_io_out_uop_prs2;
  wire [6:0]  _slots_16_io_out_uop_prs3;
  wire        _slots_16_io_out_uop_prs1_busy;
  wire        _slots_16_io_out_uop_prs2_busy;
  wire        _slots_16_io_out_uop_prs3_busy;
  wire        _slots_16_io_out_uop_ppred_busy;
  wire        _slots_16_io_out_uop_bypassable;
  wire [4:0]  _slots_16_io_out_uop_mem_cmd;
  wire [1:0]  _slots_16_io_out_uop_mem_size;
  wire        _slots_16_io_out_uop_mem_signed;
  wire        _slots_16_io_out_uop_is_fence;
  wire        _slots_16_io_out_uop_is_amo;
  wire        _slots_16_io_out_uop_uses_ldq;
  wire        _slots_16_io_out_uop_uses_stq;
  wire        _slots_16_io_out_uop_ldst_val;
  wire [1:0]  _slots_16_io_out_uop_dst_rtype;
  wire [1:0]  _slots_16_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_16_io_out_uop_lrs2_rtype;
  wire        _slots_16_io_out_uop_fp_val;
  wire [6:0]  _slots_16_io_uop_uopc;
  wire [9:0]  _slots_16_io_uop_fu_code;
  wire        _slots_16_io_uop_iw_p1_poisoned;
  wire        _slots_16_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_16_io_uop_br_mask;
  wire [19:0] _slots_16_io_uop_imm_packed;
  wire [6:0]  _slots_16_io_uop_rob_idx;
  wire [4:0]  _slots_16_io_uop_ldq_idx;
  wire [4:0]  _slots_16_io_uop_stq_idx;
  wire [6:0]  _slots_16_io_uop_pdst;
  wire [6:0]  _slots_16_io_uop_prs1;
  wire [6:0]  _slots_16_io_uop_prs2;
  wire [4:0]  _slots_16_io_uop_mem_cmd;
  wire [1:0]  _slots_16_io_uop_mem_size;
  wire        _slots_16_io_uop_mem_signed;
  wire        _slots_16_io_uop_is_fence;
  wire        _slots_16_io_uop_is_amo;
  wire        _slots_16_io_uop_uses_ldq;
  wire        _slots_16_io_uop_uses_stq;
  wire [1:0]  _slots_16_io_uop_lrs1_rtype;
  wire [1:0]  _slots_16_io_uop_lrs2_rtype;
  wire        _slots_16_io_uop_fp_val;
  wire        _slots_15_io_valid;
  wire        _slots_15_io_will_be_valid;
  wire        _slots_15_io_request;
  wire [6:0]  _slots_15_io_out_uop_uopc;
  wire        _slots_15_io_out_uop_is_rvc;
  wire [9:0]  _slots_15_io_out_uop_fu_code;
  wire [1:0]  _slots_15_io_out_uop_iw_state;
  wire        _slots_15_io_out_uop_iw_p1_poisoned;
  wire        _slots_15_io_out_uop_iw_p2_poisoned;
  wire        _slots_15_io_out_uop_is_br;
  wire        _slots_15_io_out_uop_is_jalr;
  wire        _slots_15_io_out_uop_is_jal;
  wire        _slots_15_io_out_uop_is_sfb;
  wire [19:0] _slots_15_io_out_uop_br_mask;
  wire [4:0]  _slots_15_io_out_uop_br_tag;
  wire [5:0]  _slots_15_io_out_uop_ftq_idx;
  wire        _slots_15_io_out_uop_edge_inst;
  wire [5:0]  _slots_15_io_out_uop_pc_lob;
  wire        _slots_15_io_out_uop_taken;
  wire [19:0] _slots_15_io_out_uop_imm_packed;
  wire [6:0]  _slots_15_io_out_uop_rob_idx;
  wire [4:0]  _slots_15_io_out_uop_ldq_idx;
  wire [4:0]  _slots_15_io_out_uop_stq_idx;
  wire [6:0]  _slots_15_io_out_uop_pdst;
  wire [6:0]  _slots_15_io_out_uop_prs1;
  wire [6:0]  _slots_15_io_out_uop_prs2;
  wire [6:0]  _slots_15_io_out_uop_prs3;
  wire        _slots_15_io_out_uop_prs1_busy;
  wire        _slots_15_io_out_uop_prs2_busy;
  wire        _slots_15_io_out_uop_prs3_busy;
  wire        _slots_15_io_out_uop_ppred_busy;
  wire        _slots_15_io_out_uop_bypassable;
  wire [4:0]  _slots_15_io_out_uop_mem_cmd;
  wire [1:0]  _slots_15_io_out_uop_mem_size;
  wire        _slots_15_io_out_uop_mem_signed;
  wire        _slots_15_io_out_uop_is_fence;
  wire        _slots_15_io_out_uop_is_amo;
  wire        _slots_15_io_out_uop_uses_ldq;
  wire        _slots_15_io_out_uop_uses_stq;
  wire        _slots_15_io_out_uop_ldst_val;
  wire [1:0]  _slots_15_io_out_uop_dst_rtype;
  wire [1:0]  _slots_15_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_15_io_out_uop_lrs2_rtype;
  wire        _slots_15_io_out_uop_fp_val;
  wire [6:0]  _slots_15_io_uop_uopc;
  wire [9:0]  _slots_15_io_uop_fu_code;
  wire        _slots_15_io_uop_iw_p1_poisoned;
  wire        _slots_15_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_15_io_uop_br_mask;
  wire [19:0] _slots_15_io_uop_imm_packed;
  wire [6:0]  _slots_15_io_uop_rob_idx;
  wire [4:0]  _slots_15_io_uop_ldq_idx;
  wire [4:0]  _slots_15_io_uop_stq_idx;
  wire [6:0]  _slots_15_io_uop_pdst;
  wire [6:0]  _slots_15_io_uop_prs1;
  wire [6:0]  _slots_15_io_uop_prs2;
  wire [4:0]  _slots_15_io_uop_mem_cmd;
  wire [1:0]  _slots_15_io_uop_mem_size;
  wire        _slots_15_io_uop_mem_signed;
  wire        _slots_15_io_uop_is_fence;
  wire        _slots_15_io_uop_is_amo;
  wire        _slots_15_io_uop_uses_ldq;
  wire        _slots_15_io_uop_uses_stq;
  wire [1:0]  _slots_15_io_uop_lrs1_rtype;
  wire [1:0]  _slots_15_io_uop_lrs2_rtype;
  wire        _slots_15_io_uop_fp_val;
  wire        _slots_14_io_valid;
  wire        _slots_14_io_will_be_valid;
  wire        _slots_14_io_request;
  wire [6:0]  _slots_14_io_out_uop_uopc;
  wire        _slots_14_io_out_uop_is_rvc;
  wire [9:0]  _slots_14_io_out_uop_fu_code;
  wire [1:0]  _slots_14_io_out_uop_iw_state;
  wire        _slots_14_io_out_uop_iw_p1_poisoned;
  wire        _slots_14_io_out_uop_iw_p2_poisoned;
  wire        _slots_14_io_out_uop_is_br;
  wire        _slots_14_io_out_uop_is_jalr;
  wire        _slots_14_io_out_uop_is_jal;
  wire        _slots_14_io_out_uop_is_sfb;
  wire [19:0] _slots_14_io_out_uop_br_mask;
  wire [4:0]  _slots_14_io_out_uop_br_tag;
  wire [5:0]  _slots_14_io_out_uop_ftq_idx;
  wire        _slots_14_io_out_uop_edge_inst;
  wire [5:0]  _slots_14_io_out_uop_pc_lob;
  wire        _slots_14_io_out_uop_taken;
  wire [19:0] _slots_14_io_out_uop_imm_packed;
  wire [6:0]  _slots_14_io_out_uop_rob_idx;
  wire [4:0]  _slots_14_io_out_uop_ldq_idx;
  wire [4:0]  _slots_14_io_out_uop_stq_idx;
  wire [6:0]  _slots_14_io_out_uop_pdst;
  wire [6:0]  _slots_14_io_out_uop_prs1;
  wire [6:0]  _slots_14_io_out_uop_prs2;
  wire [6:0]  _slots_14_io_out_uop_prs3;
  wire        _slots_14_io_out_uop_prs1_busy;
  wire        _slots_14_io_out_uop_prs2_busy;
  wire        _slots_14_io_out_uop_prs3_busy;
  wire        _slots_14_io_out_uop_ppred_busy;
  wire        _slots_14_io_out_uop_bypassable;
  wire [4:0]  _slots_14_io_out_uop_mem_cmd;
  wire [1:0]  _slots_14_io_out_uop_mem_size;
  wire        _slots_14_io_out_uop_mem_signed;
  wire        _slots_14_io_out_uop_is_fence;
  wire        _slots_14_io_out_uop_is_amo;
  wire        _slots_14_io_out_uop_uses_ldq;
  wire        _slots_14_io_out_uop_uses_stq;
  wire        _slots_14_io_out_uop_ldst_val;
  wire [1:0]  _slots_14_io_out_uop_dst_rtype;
  wire [1:0]  _slots_14_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_14_io_out_uop_lrs2_rtype;
  wire        _slots_14_io_out_uop_fp_val;
  wire [6:0]  _slots_14_io_uop_uopc;
  wire [9:0]  _slots_14_io_uop_fu_code;
  wire        _slots_14_io_uop_iw_p1_poisoned;
  wire        _slots_14_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_14_io_uop_br_mask;
  wire [19:0] _slots_14_io_uop_imm_packed;
  wire [6:0]  _slots_14_io_uop_rob_idx;
  wire [4:0]  _slots_14_io_uop_ldq_idx;
  wire [4:0]  _slots_14_io_uop_stq_idx;
  wire [6:0]  _slots_14_io_uop_pdst;
  wire [6:0]  _slots_14_io_uop_prs1;
  wire [6:0]  _slots_14_io_uop_prs2;
  wire [4:0]  _slots_14_io_uop_mem_cmd;
  wire [1:0]  _slots_14_io_uop_mem_size;
  wire        _slots_14_io_uop_mem_signed;
  wire        _slots_14_io_uop_is_fence;
  wire        _slots_14_io_uop_is_amo;
  wire        _slots_14_io_uop_uses_ldq;
  wire        _slots_14_io_uop_uses_stq;
  wire [1:0]  _slots_14_io_uop_lrs1_rtype;
  wire [1:0]  _slots_14_io_uop_lrs2_rtype;
  wire        _slots_14_io_uop_fp_val;
  wire        _slots_13_io_valid;
  wire        _slots_13_io_will_be_valid;
  wire        _slots_13_io_request;
  wire [6:0]  _slots_13_io_out_uop_uopc;
  wire        _slots_13_io_out_uop_is_rvc;
  wire [9:0]  _slots_13_io_out_uop_fu_code;
  wire [1:0]  _slots_13_io_out_uop_iw_state;
  wire        _slots_13_io_out_uop_iw_p1_poisoned;
  wire        _slots_13_io_out_uop_iw_p2_poisoned;
  wire        _slots_13_io_out_uop_is_br;
  wire        _slots_13_io_out_uop_is_jalr;
  wire        _slots_13_io_out_uop_is_jal;
  wire        _slots_13_io_out_uop_is_sfb;
  wire [19:0] _slots_13_io_out_uop_br_mask;
  wire [4:0]  _slots_13_io_out_uop_br_tag;
  wire [5:0]  _slots_13_io_out_uop_ftq_idx;
  wire        _slots_13_io_out_uop_edge_inst;
  wire [5:0]  _slots_13_io_out_uop_pc_lob;
  wire        _slots_13_io_out_uop_taken;
  wire [19:0] _slots_13_io_out_uop_imm_packed;
  wire [6:0]  _slots_13_io_out_uop_rob_idx;
  wire [4:0]  _slots_13_io_out_uop_ldq_idx;
  wire [4:0]  _slots_13_io_out_uop_stq_idx;
  wire [6:0]  _slots_13_io_out_uop_pdst;
  wire [6:0]  _slots_13_io_out_uop_prs1;
  wire [6:0]  _slots_13_io_out_uop_prs2;
  wire [6:0]  _slots_13_io_out_uop_prs3;
  wire        _slots_13_io_out_uop_prs1_busy;
  wire        _slots_13_io_out_uop_prs2_busy;
  wire        _slots_13_io_out_uop_prs3_busy;
  wire        _slots_13_io_out_uop_ppred_busy;
  wire        _slots_13_io_out_uop_bypassable;
  wire [4:0]  _slots_13_io_out_uop_mem_cmd;
  wire [1:0]  _slots_13_io_out_uop_mem_size;
  wire        _slots_13_io_out_uop_mem_signed;
  wire        _slots_13_io_out_uop_is_fence;
  wire        _slots_13_io_out_uop_is_amo;
  wire        _slots_13_io_out_uop_uses_ldq;
  wire        _slots_13_io_out_uop_uses_stq;
  wire        _slots_13_io_out_uop_ldst_val;
  wire [1:0]  _slots_13_io_out_uop_dst_rtype;
  wire [1:0]  _slots_13_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_13_io_out_uop_lrs2_rtype;
  wire        _slots_13_io_out_uop_fp_val;
  wire [6:0]  _slots_13_io_uop_uopc;
  wire [9:0]  _slots_13_io_uop_fu_code;
  wire        _slots_13_io_uop_iw_p1_poisoned;
  wire        _slots_13_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_13_io_uop_br_mask;
  wire [19:0] _slots_13_io_uop_imm_packed;
  wire [6:0]  _slots_13_io_uop_rob_idx;
  wire [4:0]  _slots_13_io_uop_ldq_idx;
  wire [4:0]  _slots_13_io_uop_stq_idx;
  wire [6:0]  _slots_13_io_uop_pdst;
  wire [6:0]  _slots_13_io_uop_prs1;
  wire [6:0]  _slots_13_io_uop_prs2;
  wire [4:0]  _slots_13_io_uop_mem_cmd;
  wire [1:0]  _slots_13_io_uop_mem_size;
  wire        _slots_13_io_uop_mem_signed;
  wire        _slots_13_io_uop_is_fence;
  wire        _slots_13_io_uop_is_amo;
  wire        _slots_13_io_uop_uses_ldq;
  wire        _slots_13_io_uop_uses_stq;
  wire [1:0]  _slots_13_io_uop_lrs1_rtype;
  wire [1:0]  _slots_13_io_uop_lrs2_rtype;
  wire        _slots_13_io_uop_fp_val;
  wire        _slots_12_io_valid;
  wire        _slots_12_io_will_be_valid;
  wire        _slots_12_io_request;
  wire [6:0]  _slots_12_io_out_uop_uopc;
  wire        _slots_12_io_out_uop_is_rvc;
  wire [9:0]  _slots_12_io_out_uop_fu_code;
  wire [1:0]  _slots_12_io_out_uop_iw_state;
  wire        _slots_12_io_out_uop_iw_p1_poisoned;
  wire        _slots_12_io_out_uop_iw_p2_poisoned;
  wire        _slots_12_io_out_uop_is_br;
  wire        _slots_12_io_out_uop_is_jalr;
  wire        _slots_12_io_out_uop_is_jal;
  wire        _slots_12_io_out_uop_is_sfb;
  wire [19:0] _slots_12_io_out_uop_br_mask;
  wire [4:0]  _slots_12_io_out_uop_br_tag;
  wire [5:0]  _slots_12_io_out_uop_ftq_idx;
  wire        _slots_12_io_out_uop_edge_inst;
  wire [5:0]  _slots_12_io_out_uop_pc_lob;
  wire        _slots_12_io_out_uop_taken;
  wire [19:0] _slots_12_io_out_uop_imm_packed;
  wire [6:0]  _slots_12_io_out_uop_rob_idx;
  wire [4:0]  _slots_12_io_out_uop_ldq_idx;
  wire [4:0]  _slots_12_io_out_uop_stq_idx;
  wire [6:0]  _slots_12_io_out_uop_pdst;
  wire [6:0]  _slots_12_io_out_uop_prs1;
  wire [6:0]  _slots_12_io_out_uop_prs2;
  wire [6:0]  _slots_12_io_out_uop_prs3;
  wire        _slots_12_io_out_uop_prs1_busy;
  wire        _slots_12_io_out_uop_prs2_busy;
  wire        _slots_12_io_out_uop_prs3_busy;
  wire        _slots_12_io_out_uop_ppred_busy;
  wire        _slots_12_io_out_uop_bypassable;
  wire [4:0]  _slots_12_io_out_uop_mem_cmd;
  wire [1:0]  _slots_12_io_out_uop_mem_size;
  wire        _slots_12_io_out_uop_mem_signed;
  wire        _slots_12_io_out_uop_is_fence;
  wire        _slots_12_io_out_uop_is_amo;
  wire        _slots_12_io_out_uop_uses_ldq;
  wire        _slots_12_io_out_uop_uses_stq;
  wire        _slots_12_io_out_uop_ldst_val;
  wire [1:0]  _slots_12_io_out_uop_dst_rtype;
  wire [1:0]  _slots_12_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_12_io_out_uop_lrs2_rtype;
  wire        _slots_12_io_out_uop_fp_val;
  wire [6:0]  _slots_12_io_uop_uopc;
  wire [9:0]  _slots_12_io_uop_fu_code;
  wire        _slots_12_io_uop_iw_p1_poisoned;
  wire        _slots_12_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_12_io_uop_br_mask;
  wire [19:0] _slots_12_io_uop_imm_packed;
  wire [6:0]  _slots_12_io_uop_rob_idx;
  wire [4:0]  _slots_12_io_uop_ldq_idx;
  wire [4:0]  _slots_12_io_uop_stq_idx;
  wire [6:0]  _slots_12_io_uop_pdst;
  wire [6:0]  _slots_12_io_uop_prs1;
  wire [6:0]  _slots_12_io_uop_prs2;
  wire [4:0]  _slots_12_io_uop_mem_cmd;
  wire [1:0]  _slots_12_io_uop_mem_size;
  wire        _slots_12_io_uop_mem_signed;
  wire        _slots_12_io_uop_is_fence;
  wire        _slots_12_io_uop_is_amo;
  wire        _slots_12_io_uop_uses_ldq;
  wire        _slots_12_io_uop_uses_stq;
  wire [1:0]  _slots_12_io_uop_lrs1_rtype;
  wire [1:0]  _slots_12_io_uop_lrs2_rtype;
  wire        _slots_12_io_uop_fp_val;
  wire        _slots_11_io_valid;
  wire        _slots_11_io_will_be_valid;
  wire        _slots_11_io_request;
  wire [6:0]  _slots_11_io_out_uop_uopc;
  wire        _slots_11_io_out_uop_is_rvc;
  wire [9:0]  _slots_11_io_out_uop_fu_code;
  wire [1:0]  _slots_11_io_out_uop_iw_state;
  wire        _slots_11_io_out_uop_iw_p1_poisoned;
  wire        _slots_11_io_out_uop_iw_p2_poisoned;
  wire        _slots_11_io_out_uop_is_br;
  wire        _slots_11_io_out_uop_is_jalr;
  wire        _slots_11_io_out_uop_is_jal;
  wire        _slots_11_io_out_uop_is_sfb;
  wire [19:0] _slots_11_io_out_uop_br_mask;
  wire [4:0]  _slots_11_io_out_uop_br_tag;
  wire [5:0]  _slots_11_io_out_uop_ftq_idx;
  wire        _slots_11_io_out_uop_edge_inst;
  wire [5:0]  _slots_11_io_out_uop_pc_lob;
  wire        _slots_11_io_out_uop_taken;
  wire [19:0] _slots_11_io_out_uop_imm_packed;
  wire [6:0]  _slots_11_io_out_uop_rob_idx;
  wire [4:0]  _slots_11_io_out_uop_ldq_idx;
  wire [4:0]  _slots_11_io_out_uop_stq_idx;
  wire [6:0]  _slots_11_io_out_uop_pdst;
  wire [6:0]  _slots_11_io_out_uop_prs1;
  wire [6:0]  _slots_11_io_out_uop_prs2;
  wire [6:0]  _slots_11_io_out_uop_prs3;
  wire        _slots_11_io_out_uop_prs1_busy;
  wire        _slots_11_io_out_uop_prs2_busy;
  wire        _slots_11_io_out_uop_prs3_busy;
  wire        _slots_11_io_out_uop_ppred_busy;
  wire        _slots_11_io_out_uop_bypassable;
  wire [4:0]  _slots_11_io_out_uop_mem_cmd;
  wire [1:0]  _slots_11_io_out_uop_mem_size;
  wire        _slots_11_io_out_uop_mem_signed;
  wire        _slots_11_io_out_uop_is_fence;
  wire        _slots_11_io_out_uop_is_amo;
  wire        _slots_11_io_out_uop_uses_ldq;
  wire        _slots_11_io_out_uop_uses_stq;
  wire        _slots_11_io_out_uop_ldst_val;
  wire [1:0]  _slots_11_io_out_uop_dst_rtype;
  wire [1:0]  _slots_11_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_11_io_out_uop_lrs2_rtype;
  wire        _slots_11_io_out_uop_fp_val;
  wire [6:0]  _slots_11_io_uop_uopc;
  wire [9:0]  _slots_11_io_uop_fu_code;
  wire        _slots_11_io_uop_iw_p1_poisoned;
  wire        _slots_11_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_11_io_uop_br_mask;
  wire [19:0] _slots_11_io_uop_imm_packed;
  wire [6:0]  _slots_11_io_uop_rob_idx;
  wire [4:0]  _slots_11_io_uop_ldq_idx;
  wire [4:0]  _slots_11_io_uop_stq_idx;
  wire [6:0]  _slots_11_io_uop_pdst;
  wire [6:0]  _slots_11_io_uop_prs1;
  wire [6:0]  _slots_11_io_uop_prs2;
  wire [4:0]  _slots_11_io_uop_mem_cmd;
  wire [1:0]  _slots_11_io_uop_mem_size;
  wire        _slots_11_io_uop_mem_signed;
  wire        _slots_11_io_uop_is_fence;
  wire        _slots_11_io_uop_is_amo;
  wire        _slots_11_io_uop_uses_ldq;
  wire        _slots_11_io_uop_uses_stq;
  wire [1:0]  _slots_11_io_uop_lrs1_rtype;
  wire [1:0]  _slots_11_io_uop_lrs2_rtype;
  wire        _slots_11_io_uop_fp_val;
  wire        _slots_10_io_valid;
  wire        _slots_10_io_will_be_valid;
  wire        _slots_10_io_request;
  wire [6:0]  _slots_10_io_out_uop_uopc;
  wire        _slots_10_io_out_uop_is_rvc;
  wire [9:0]  _slots_10_io_out_uop_fu_code;
  wire [1:0]  _slots_10_io_out_uop_iw_state;
  wire        _slots_10_io_out_uop_iw_p1_poisoned;
  wire        _slots_10_io_out_uop_iw_p2_poisoned;
  wire        _slots_10_io_out_uop_is_br;
  wire        _slots_10_io_out_uop_is_jalr;
  wire        _slots_10_io_out_uop_is_jal;
  wire        _slots_10_io_out_uop_is_sfb;
  wire [19:0] _slots_10_io_out_uop_br_mask;
  wire [4:0]  _slots_10_io_out_uop_br_tag;
  wire [5:0]  _slots_10_io_out_uop_ftq_idx;
  wire        _slots_10_io_out_uop_edge_inst;
  wire [5:0]  _slots_10_io_out_uop_pc_lob;
  wire        _slots_10_io_out_uop_taken;
  wire [19:0] _slots_10_io_out_uop_imm_packed;
  wire [6:0]  _slots_10_io_out_uop_rob_idx;
  wire [4:0]  _slots_10_io_out_uop_ldq_idx;
  wire [4:0]  _slots_10_io_out_uop_stq_idx;
  wire [6:0]  _slots_10_io_out_uop_pdst;
  wire [6:0]  _slots_10_io_out_uop_prs1;
  wire [6:0]  _slots_10_io_out_uop_prs2;
  wire [6:0]  _slots_10_io_out_uop_prs3;
  wire        _slots_10_io_out_uop_prs1_busy;
  wire        _slots_10_io_out_uop_prs2_busy;
  wire        _slots_10_io_out_uop_prs3_busy;
  wire        _slots_10_io_out_uop_ppred_busy;
  wire        _slots_10_io_out_uop_bypassable;
  wire [4:0]  _slots_10_io_out_uop_mem_cmd;
  wire [1:0]  _slots_10_io_out_uop_mem_size;
  wire        _slots_10_io_out_uop_mem_signed;
  wire        _slots_10_io_out_uop_is_fence;
  wire        _slots_10_io_out_uop_is_amo;
  wire        _slots_10_io_out_uop_uses_ldq;
  wire        _slots_10_io_out_uop_uses_stq;
  wire        _slots_10_io_out_uop_ldst_val;
  wire [1:0]  _slots_10_io_out_uop_dst_rtype;
  wire [1:0]  _slots_10_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_10_io_out_uop_lrs2_rtype;
  wire        _slots_10_io_out_uop_fp_val;
  wire [6:0]  _slots_10_io_uop_uopc;
  wire [9:0]  _slots_10_io_uop_fu_code;
  wire        _slots_10_io_uop_iw_p1_poisoned;
  wire        _slots_10_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_10_io_uop_br_mask;
  wire [19:0] _slots_10_io_uop_imm_packed;
  wire [6:0]  _slots_10_io_uop_rob_idx;
  wire [4:0]  _slots_10_io_uop_ldq_idx;
  wire [4:0]  _slots_10_io_uop_stq_idx;
  wire [6:0]  _slots_10_io_uop_pdst;
  wire [6:0]  _slots_10_io_uop_prs1;
  wire [6:0]  _slots_10_io_uop_prs2;
  wire [4:0]  _slots_10_io_uop_mem_cmd;
  wire [1:0]  _slots_10_io_uop_mem_size;
  wire        _slots_10_io_uop_mem_signed;
  wire        _slots_10_io_uop_is_fence;
  wire        _slots_10_io_uop_is_amo;
  wire        _slots_10_io_uop_uses_ldq;
  wire        _slots_10_io_uop_uses_stq;
  wire [1:0]  _slots_10_io_uop_lrs1_rtype;
  wire [1:0]  _slots_10_io_uop_lrs2_rtype;
  wire        _slots_10_io_uop_fp_val;
  wire        _slots_9_io_valid;
  wire        _slots_9_io_will_be_valid;
  wire        _slots_9_io_request;
  wire [6:0]  _slots_9_io_out_uop_uopc;
  wire        _slots_9_io_out_uop_is_rvc;
  wire [9:0]  _slots_9_io_out_uop_fu_code;
  wire [1:0]  _slots_9_io_out_uop_iw_state;
  wire        _slots_9_io_out_uop_iw_p1_poisoned;
  wire        _slots_9_io_out_uop_iw_p2_poisoned;
  wire        _slots_9_io_out_uop_is_br;
  wire        _slots_9_io_out_uop_is_jalr;
  wire        _slots_9_io_out_uop_is_jal;
  wire        _slots_9_io_out_uop_is_sfb;
  wire [19:0] _slots_9_io_out_uop_br_mask;
  wire [4:0]  _slots_9_io_out_uop_br_tag;
  wire [5:0]  _slots_9_io_out_uop_ftq_idx;
  wire        _slots_9_io_out_uop_edge_inst;
  wire [5:0]  _slots_9_io_out_uop_pc_lob;
  wire        _slots_9_io_out_uop_taken;
  wire [19:0] _slots_9_io_out_uop_imm_packed;
  wire [6:0]  _slots_9_io_out_uop_rob_idx;
  wire [4:0]  _slots_9_io_out_uop_ldq_idx;
  wire [4:0]  _slots_9_io_out_uop_stq_idx;
  wire [6:0]  _slots_9_io_out_uop_pdst;
  wire [6:0]  _slots_9_io_out_uop_prs1;
  wire [6:0]  _slots_9_io_out_uop_prs2;
  wire [6:0]  _slots_9_io_out_uop_prs3;
  wire        _slots_9_io_out_uop_prs1_busy;
  wire        _slots_9_io_out_uop_prs2_busy;
  wire        _slots_9_io_out_uop_prs3_busy;
  wire        _slots_9_io_out_uop_ppred_busy;
  wire        _slots_9_io_out_uop_bypassable;
  wire [4:0]  _slots_9_io_out_uop_mem_cmd;
  wire [1:0]  _slots_9_io_out_uop_mem_size;
  wire        _slots_9_io_out_uop_mem_signed;
  wire        _slots_9_io_out_uop_is_fence;
  wire        _slots_9_io_out_uop_is_amo;
  wire        _slots_9_io_out_uop_uses_ldq;
  wire        _slots_9_io_out_uop_uses_stq;
  wire        _slots_9_io_out_uop_ldst_val;
  wire [1:0]  _slots_9_io_out_uop_dst_rtype;
  wire [1:0]  _slots_9_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_9_io_out_uop_lrs2_rtype;
  wire        _slots_9_io_out_uop_fp_val;
  wire [6:0]  _slots_9_io_uop_uopc;
  wire [9:0]  _slots_9_io_uop_fu_code;
  wire        _slots_9_io_uop_iw_p1_poisoned;
  wire        _slots_9_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_9_io_uop_br_mask;
  wire [19:0] _slots_9_io_uop_imm_packed;
  wire [6:0]  _slots_9_io_uop_rob_idx;
  wire [4:0]  _slots_9_io_uop_ldq_idx;
  wire [4:0]  _slots_9_io_uop_stq_idx;
  wire [6:0]  _slots_9_io_uop_pdst;
  wire [6:0]  _slots_9_io_uop_prs1;
  wire [6:0]  _slots_9_io_uop_prs2;
  wire [4:0]  _slots_9_io_uop_mem_cmd;
  wire [1:0]  _slots_9_io_uop_mem_size;
  wire        _slots_9_io_uop_mem_signed;
  wire        _slots_9_io_uop_is_fence;
  wire        _slots_9_io_uop_is_amo;
  wire        _slots_9_io_uop_uses_ldq;
  wire        _slots_9_io_uop_uses_stq;
  wire [1:0]  _slots_9_io_uop_lrs1_rtype;
  wire [1:0]  _slots_9_io_uop_lrs2_rtype;
  wire        _slots_9_io_uop_fp_val;
  wire        _slots_8_io_valid;
  wire        _slots_8_io_will_be_valid;
  wire        _slots_8_io_request;
  wire [6:0]  _slots_8_io_out_uop_uopc;
  wire        _slots_8_io_out_uop_is_rvc;
  wire [9:0]  _slots_8_io_out_uop_fu_code;
  wire [1:0]  _slots_8_io_out_uop_iw_state;
  wire        _slots_8_io_out_uop_iw_p1_poisoned;
  wire        _slots_8_io_out_uop_iw_p2_poisoned;
  wire        _slots_8_io_out_uop_is_br;
  wire        _slots_8_io_out_uop_is_jalr;
  wire        _slots_8_io_out_uop_is_jal;
  wire        _slots_8_io_out_uop_is_sfb;
  wire [19:0] _slots_8_io_out_uop_br_mask;
  wire [4:0]  _slots_8_io_out_uop_br_tag;
  wire [5:0]  _slots_8_io_out_uop_ftq_idx;
  wire        _slots_8_io_out_uop_edge_inst;
  wire [5:0]  _slots_8_io_out_uop_pc_lob;
  wire        _slots_8_io_out_uop_taken;
  wire [19:0] _slots_8_io_out_uop_imm_packed;
  wire [6:0]  _slots_8_io_out_uop_rob_idx;
  wire [4:0]  _slots_8_io_out_uop_ldq_idx;
  wire [4:0]  _slots_8_io_out_uop_stq_idx;
  wire [6:0]  _slots_8_io_out_uop_pdst;
  wire [6:0]  _slots_8_io_out_uop_prs1;
  wire [6:0]  _slots_8_io_out_uop_prs2;
  wire [6:0]  _slots_8_io_out_uop_prs3;
  wire        _slots_8_io_out_uop_prs1_busy;
  wire        _slots_8_io_out_uop_prs2_busy;
  wire        _slots_8_io_out_uop_prs3_busy;
  wire        _slots_8_io_out_uop_ppred_busy;
  wire        _slots_8_io_out_uop_bypassable;
  wire [4:0]  _slots_8_io_out_uop_mem_cmd;
  wire [1:0]  _slots_8_io_out_uop_mem_size;
  wire        _slots_8_io_out_uop_mem_signed;
  wire        _slots_8_io_out_uop_is_fence;
  wire        _slots_8_io_out_uop_is_amo;
  wire        _slots_8_io_out_uop_uses_ldq;
  wire        _slots_8_io_out_uop_uses_stq;
  wire        _slots_8_io_out_uop_ldst_val;
  wire [1:0]  _slots_8_io_out_uop_dst_rtype;
  wire [1:0]  _slots_8_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_8_io_out_uop_lrs2_rtype;
  wire        _slots_8_io_out_uop_fp_val;
  wire [6:0]  _slots_8_io_uop_uopc;
  wire [9:0]  _slots_8_io_uop_fu_code;
  wire        _slots_8_io_uop_iw_p1_poisoned;
  wire        _slots_8_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_8_io_uop_br_mask;
  wire [19:0] _slots_8_io_uop_imm_packed;
  wire [6:0]  _slots_8_io_uop_rob_idx;
  wire [4:0]  _slots_8_io_uop_ldq_idx;
  wire [4:0]  _slots_8_io_uop_stq_idx;
  wire [6:0]  _slots_8_io_uop_pdst;
  wire [6:0]  _slots_8_io_uop_prs1;
  wire [6:0]  _slots_8_io_uop_prs2;
  wire [4:0]  _slots_8_io_uop_mem_cmd;
  wire [1:0]  _slots_8_io_uop_mem_size;
  wire        _slots_8_io_uop_mem_signed;
  wire        _slots_8_io_uop_is_fence;
  wire        _slots_8_io_uop_is_amo;
  wire        _slots_8_io_uop_uses_ldq;
  wire        _slots_8_io_uop_uses_stq;
  wire [1:0]  _slots_8_io_uop_lrs1_rtype;
  wire [1:0]  _slots_8_io_uop_lrs2_rtype;
  wire        _slots_8_io_uop_fp_val;
  wire        _slots_7_io_valid;
  wire        _slots_7_io_will_be_valid;
  wire        _slots_7_io_request;
  wire [6:0]  _slots_7_io_out_uop_uopc;
  wire        _slots_7_io_out_uop_is_rvc;
  wire [9:0]  _slots_7_io_out_uop_fu_code;
  wire [1:0]  _slots_7_io_out_uop_iw_state;
  wire        _slots_7_io_out_uop_iw_p1_poisoned;
  wire        _slots_7_io_out_uop_iw_p2_poisoned;
  wire        _slots_7_io_out_uop_is_br;
  wire        _slots_7_io_out_uop_is_jalr;
  wire        _slots_7_io_out_uop_is_jal;
  wire        _slots_7_io_out_uop_is_sfb;
  wire [19:0] _slots_7_io_out_uop_br_mask;
  wire [4:0]  _slots_7_io_out_uop_br_tag;
  wire [5:0]  _slots_7_io_out_uop_ftq_idx;
  wire        _slots_7_io_out_uop_edge_inst;
  wire [5:0]  _slots_7_io_out_uop_pc_lob;
  wire        _slots_7_io_out_uop_taken;
  wire [19:0] _slots_7_io_out_uop_imm_packed;
  wire [6:0]  _slots_7_io_out_uop_rob_idx;
  wire [4:0]  _slots_7_io_out_uop_ldq_idx;
  wire [4:0]  _slots_7_io_out_uop_stq_idx;
  wire [6:0]  _slots_7_io_out_uop_pdst;
  wire [6:0]  _slots_7_io_out_uop_prs1;
  wire [6:0]  _slots_7_io_out_uop_prs2;
  wire [6:0]  _slots_7_io_out_uop_prs3;
  wire        _slots_7_io_out_uop_prs1_busy;
  wire        _slots_7_io_out_uop_prs2_busy;
  wire        _slots_7_io_out_uop_prs3_busy;
  wire        _slots_7_io_out_uop_ppred_busy;
  wire        _slots_7_io_out_uop_bypassable;
  wire [4:0]  _slots_7_io_out_uop_mem_cmd;
  wire [1:0]  _slots_7_io_out_uop_mem_size;
  wire        _slots_7_io_out_uop_mem_signed;
  wire        _slots_7_io_out_uop_is_fence;
  wire        _slots_7_io_out_uop_is_amo;
  wire        _slots_7_io_out_uop_uses_ldq;
  wire        _slots_7_io_out_uop_uses_stq;
  wire        _slots_7_io_out_uop_ldst_val;
  wire [1:0]  _slots_7_io_out_uop_dst_rtype;
  wire [1:0]  _slots_7_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_7_io_out_uop_lrs2_rtype;
  wire        _slots_7_io_out_uop_fp_val;
  wire [6:0]  _slots_7_io_uop_uopc;
  wire [9:0]  _slots_7_io_uop_fu_code;
  wire        _slots_7_io_uop_iw_p1_poisoned;
  wire        _slots_7_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_7_io_uop_br_mask;
  wire [19:0] _slots_7_io_uop_imm_packed;
  wire [6:0]  _slots_7_io_uop_rob_idx;
  wire [4:0]  _slots_7_io_uop_ldq_idx;
  wire [4:0]  _slots_7_io_uop_stq_idx;
  wire [6:0]  _slots_7_io_uop_pdst;
  wire [6:0]  _slots_7_io_uop_prs1;
  wire [6:0]  _slots_7_io_uop_prs2;
  wire [4:0]  _slots_7_io_uop_mem_cmd;
  wire [1:0]  _slots_7_io_uop_mem_size;
  wire        _slots_7_io_uop_mem_signed;
  wire        _slots_7_io_uop_is_fence;
  wire        _slots_7_io_uop_is_amo;
  wire        _slots_7_io_uop_uses_ldq;
  wire        _slots_7_io_uop_uses_stq;
  wire [1:0]  _slots_7_io_uop_lrs1_rtype;
  wire [1:0]  _slots_7_io_uop_lrs2_rtype;
  wire        _slots_7_io_uop_fp_val;
  wire        _slots_6_io_valid;
  wire        _slots_6_io_will_be_valid;
  wire        _slots_6_io_request;
  wire [6:0]  _slots_6_io_out_uop_uopc;
  wire        _slots_6_io_out_uop_is_rvc;
  wire [9:0]  _slots_6_io_out_uop_fu_code;
  wire [1:0]  _slots_6_io_out_uop_iw_state;
  wire        _slots_6_io_out_uop_iw_p1_poisoned;
  wire        _slots_6_io_out_uop_iw_p2_poisoned;
  wire        _slots_6_io_out_uop_is_br;
  wire        _slots_6_io_out_uop_is_jalr;
  wire        _slots_6_io_out_uop_is_jal;
  wire        _slots_6_io_out_uop_is_sfb;
  wire [19:0] _slots_6_io_out_uop_br_mask;
  wire [4:0]  _slots_6_io_out_uop_br_tag;
  wire [5:0]  _slots_6_io_out_uop_ftq_idx;
  wire        _slots_6_io_out_uop_edge_inst;
  wire [5:0]  _slots_6_io_out_uop_pc_lob;
  wire        _slots_6_io_out_uop_taken;
  wire [19:0] _slots_6_io_out_uop_imm_packed;
  wire [6:0]  _slots_6_io_out_uop_rob_idx;
  wire [4:0]  _slots_6_io_out_uop_ldq_idx;
  wire [4:0]  _slots_6_io_out_uop_stq_idx;
  wire [6:0]  _slots_6_io_out_uop_pdst;
  wire [6:0]  _slots_6_io_out_uop_prs1;
  wire [6:0]  _slots_6_io_out_uop_prs2;
  wire [6:0]  _slots_6_io_out_uop_prs3;
  wire        _slots_6_io_out_uop_prs1_busy;
  wire        _slots_6_io_out_uop_prs2_busy;
  wire        _slots_6_io_out_uop_prs3_busy;
  wire        _slots_6_io_out_uop_ppred_busy;
  wire        _slots_6_io_out_uop_bypassable;
  wire [4:0]  _slots_6_io_out_uop_mem_cmd;
  wire [1:0]  _slots_6_io_out_uop_mem_size;
  wire        _slots_6_io_out_uop_mem_signed;
  wire        _slots_6_io_out_uop_is_fence;
  wire        _slots_6_io_out_uop_is_amo;
  wire        _slots_6_io_out_uop_uses_ldq;
  wire        _slots_6_io_out_uop_uses_stq;
  wire        _slots_6_io_out_uop_ldst_val;
  wire [1:0]  _slots_6_io_out_uop_dst_rtype;
  wire [1:0]  _slots_6_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_6_io_out_uop_lrs2_rtype;
  wire        _slots_6_io_out_uop_fp_val;
  wire [6:0]  _slots_6_io_uop_uopc;
  wire [9:0]  _slots_6_io_uop_fu_code;
  wire        _slots_6_io_uop_iw_p1_poisoned;
  wire        _slots_6_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_6_io_uop_br_mask;
  wire [19:0] _slots_6_io_uop_imm_packed;
  wire [6:0]  _slots_6_io_uop_rob_idx;
  wire [4:0]  _slots_6_io_uop_ldq_idx;
  wire [4:0]  _slots_6_io_uop_stq_idx;
  wire [6:0]  _slots_6_io_uop_pdst;
  wire [6:0]  _slots_6_io_uop_prs1;
  wire [6:0]  _slots_6_io_uop_prs2;
  wire [4:0]  _slots_6_io_uop_mem_cmd;
  wire [1:0]  _slots_6_io_uop_mem_size;
  wire        _slots_6_io_uop_mem_signed;
  wire        _slots_6_io_uop_is_fence;
  wire        _slots_6_io_uop_is_amo;
  wire        _slots_6_io_uop_uses_ldq;
  wire        _slots_6_io_uop_uses_stq;
  wire [1:0]  _slots_6_io_uop_lrs1_rtype;
  wire [1:0]  _slots_6_io_uop_lrs2_rtype;
  wire        _slots_6_io_uop_fp_val;
  wire        _slots_5_io_valid;
  wire        _slots_5_io_will_be_valid;
  wire        _slots_5_io_request;
  wire [6:0]  _slots_5_io_out_uop_uopc;
  wire        _slots_5_io_out_uop_is_rvc;
  wire [9:0]  _slots_5_io_out_uop_fu_code;
  wire [1:0]  _slots_5_io_out_uop_iw_state;
  wire        _slots_5_io_out_uop_iw_p1_poisoned;
  wire        _slots_5_io_out_uop_iw_p2_poisoned;
  wire        _slots_5_io_out_uop_is_br;
  wire        _slots_5_io_out_uop_is_jalr;
  wire        _slots_5_io_out_uop_is_jal;
  wire        _slots_5_io_out_uop_is_sfb;
  wire [19:0] _slots_5_io_out_uop_br_mask;
  wire [4:0]  _slots_5_io_out_uop_br_tag;
  wire [5:0]  _slots_5_io_out_uop_ftq_idx;
  wire        _slots_5_io_out_uop_edge_inst;
  wire [5:0]  _slots_5_io_out_uop_pc_lob;
  wire        _slots_5_io_out_uop_taken;
  wire [19:0] _slots_5_io_out_uop_imm_packed;
  wire [6:0]  _slots_5_io_out_uop_rob_idx;
  wire [4:0]  _slots_5_io_out_uop_ldq_idx;
  wire [4:0]  _slots_5_io_out_uop_stq_idx;
  wire [6:0]  _slots_5_io_out_uop_pdst;
  wire [6:0]  _slots_5_io_out_uop_prs1;
  wire [6:0]  _slots_5_io_out_uop_prs2;
  wire [6:0]  _slots_5_io_out_uop_prs3;
  wire        _slots_5_io_out_uop_prs1_busy;
  wire        _slots_5_io_out_uop_prs2_busy;
  wire        _slots_5_io_out_uop_prs3_busy;
  wire        _slots_5_io_out_uop_ppred_busy;
  wire        _slots_5_io_out_uop_bypassable;
  wire [4:0]  _slots_5_io_out_uop_mem_cmd;
  wire [1:0]  _slots_5_io_out_uop_mem_size;
  wire        _slots_5_io_out_uop_mem_signed;
  wire        _slots_5_io_out_uop_is_fence;
  wire        _slots_5_io_out_uop_is_amo;
  wire        _slots_5_io_out_uop_uses_ldq;
  wire        _slots_5_io_out_uop_uses_stq;
  wire        _slots_5_io_out_uop_ldst_val;
  wire [1:0]  _slots_5_io_out_uop_dst_rtype;
  wire [1:0]  _slots_5_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_5_io_out_uop_lrs2_rtype;
  wire        _slots_5_io_out_uop_fp_val;
  wire [6:0]  _slots_5_io_uop_uopc;
  wire [9:0]  _slots_5_io_uop_fu_code;
  wire        _slots_5_io_uop_iw_p1_poisoned;
  wire        _slots_5_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_5_io_uop_br_mask;
  wire [19:0] _slots_5_io_uop_imm_packed;
  wire [6:0]  _slots_5_io_uop_rob_idx;
  wire [4:0]  _slots_5_io_uop_ldq_idx;
  wire [4:0]  _slots_5_io_uop_stq_idx;
  wire [6:0]  _slots_5_io_uop_pdst;
  wire [6:0]  _slots_5_io_uop_prs1;
  wire [6:0]  _slots_5_io_uop_prs2;
  wire [4:0]  _slots_5_io_uop_mem_cmd;
  wire [1:0]  _slots_5_io_uop_mem_size;
  wire        _slots_5_io_uop_mem_signed;
  wire        _slots_5_io_uop_is_fence;
  wire        _slots_5_io_uop_is_amo;
  wire        _slots_5_io_uop_uses_ldq;
  wire        _slots_5_io_uop_uses_stq;
  wire [1:0]  _slots_5_io_uop_lrs1_rtype;
  wire [1:0]  _slots_5_io_uop_lrs2_rtype;
  wire        _slots_5_io_uop_fp_val;
  wire        _slots_4_io_valid;
  wire        _slots_4_io_will_be_valid;
  wire        _slots_4_io_request;
  wire [6:0]  _slots_4_io_out_uop_uopc;
  wire        _slots_4_io_out_uop_is_rvc;
  wire [9:0]  _slots_4_io_out_uop_fu_code;
  wire [1:0]  _slots_4_io_out_uop_iw_state;
  wire        _slots_4_io_out_uop_iw_p1_poisoned;
  wire        _slots_4_io_out_uop_iw_p2_poisoned;
  wire        _slots_4_io_out_uop_is_br;
  wire        _slots_4_io_out_uop_is_jalr;
  wire        _slots_4_io_out_uop_is_jal;
  wire        _slots_4_io_out_uop_is_sfb;
  wire [19:0] _slots_4_io_out_uop_br_mask;
  wire [4:0]  _slots_4_io_out_uop_br_tag;
  wire [5:0]  _slots_4_io_out_uop_ftq_idx;
  wire        _slots_4_io_out_uop_edge_inst;
  wire [5:0]  _slots_4_io_out_uop_pc_lob;
  wire        _slots_4_io_out_uop_taken;
  wire [19:0] _slots_4_io_out_uop_imm_packed;
  wire [6:0]  _slots_4_io_out_uop_rob_idx;
  wire [4:0]  _slots_4_io_out_uop_ldq_idx;
  wire [4:0]  _slots_4_io_out_uop_stq_idx;
  wire [6:0]  _slots_4_io_out_uop_pdst;
  wire [6:0]  _slots_4_io_out_uop_prs1;
  wire [6:0]  _slots_4_io_out_uop_prs2;
  wire [6:0]  _slots_4_io_out_uop_prs3;
  wire        _slots_4_io_out_uop_prs1_busy;
  wire        _slots_4_io_out_uop_prs2_busy;
  wire        _slots_4_io_out_uop_prs3_busy;
  wire        _slots_4_io_out_uop_ppred_busy;
  wire        _slots_4_io_out_uop_bypassable;
  wire [4:0]  _slots_4_io_out_uop_mem_cmd;
  wire [1:0]  _slots_4_io_out_uop_mem_size;
  wire        _slots_4_io_out_uop_mem_signed;
  wire        _slots_4_io_out_uop_is_fence;
  wire        _slots_4_io_out_uop_is_amo;
  wire        _slots_4_io_out_uop_uses_ldq;
  wire        _slots_4_io_out_uop_uses_stq;
  wire        _slots_4_io_out_uop_ldst_val;
  wire [1:0]  _slots_4_io_out_uop_dst_rtype;
  wire [1:0]  _slots_4_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_4_io_out_uop_lrs2_rtype;
  wire        _slots_4_io_out_uop_fp_val;
  wire [6:0]  _slots_4_io_uop_uopc;
  wire [9:0]  _slots_4_io_uop_fu_code;
  wire        _slots_4_io_uop_iw_p1_poisoned;
  wire        _slots_4_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_4_io_uop_br_mask;
  wire [19:0] _slots_4_io_uop_imm_packed;
  wire [6:0]  _slots_4_io_uop_rob_idx;
  wire [4:0]  _slots_4_io_uop_ldq_idx;
  wire [4:0]  _slots_4_io_uop_stq_idx;
  wire [6:0]  _slots_4_io_uop_pdst;
  wire [6:0]  _slots_4_io_uop_prs1;
  wire [6:0]  _slots_4_io_uop_prs2;
  wire [4:0]  _slots_4_io_uop_mem_cmd;
  wire [1:0]  _slots_4_io_uop_mem_size;
  wire        _slots_4_io_uop_mem_signed;
  wire        _slots_4_io_uop_is_fence;
  wire        _slots_4_io_uop_is_amo;
  wire        _slots_4_io_uop_uses_ldq;
  wire        _slots_4_io_uop_uses_stq;
  wire [1:0]  _slots_4_io_uop_lrs1_rtype;
  wire [1:0]  _slots_4_io_uop_lrs2_rtype;
  wire        _slots_4_io_uop_fp_val;
  wire        _slots_3_io_valid;
  wire        _slots_3_io_will_be_valid;
  wire        _slots_3_io_request;
  wire [6:0]  _slots_3_io_out_uop_uopc;
  wire        _slots_3_io_out_uop_is_rvc;
  wire [9:0]  _slots_3_io_out_uop_fu_code;
  wire [1:0]  _slots_3_io_out_uop_iw_state;
  wire        _slots_3_io_out_uop_iw_p1_poisoned;
  wire        _slots_3_io_out_uop_iw_p2_poisoned;
  wire        _slots_3_io_out_uop_is_br;
  wire        _slots_3_io_out_uop_is_jalr;
  wire        _slots_3_io_out_uop_is_jal;
  wire        _slots_3_io_out_uop_is_sfb;
  wire [19:0] _slots_3_io_out_uop_br_mask;
  wire [4:0]  _slots_3_io_out_uop_br_tag;
  wire [5:0]  _slots_3_io_out_uop_ftq_idx;
  wire        _slots_3_io_out_uop_edge_inst;
  wire [5:0]  _slots_3_io_out_uop_pc_lob;
  wire        _slots_3_io_out_uop_taken;
  wire [19:0] _slots_3_io_out_uop_imm_packed;
  wire [6:0]  _slots_3_io_out_uop_rob_idx;
  wire [4:0]  _slots_3_io_out_uop_ldq_idx;
  wire [4:0]  _slots_3_io_out_uop_stq_idx;
  wire [6:0]  _slots_3_io_out_uop_pdst;
  wire [6:0]  _slots_3_io_out_uop_prs1;
  wire [6:0]  _slots_3_io_out_uop_prs2;
  wire [6:0]  _slots_3_io_out_uop_prs3;
  wire        _slots_3_io_out_uop_prs1_busy;
  wire        _slots_3_io_out_uop_prs2_busy;
  wire        _slots_3_io_out_uop_prs3_busy;
  wire        _slots_3_io_out_uop_ppred_busy;
  wire        _slots_3_io_out_uop_bypassable;
  wire [4:0]  _slots_3_io_out_uop_mem_cmd;
  wire [1:0]  _slots_3_io_out_uop_mem_size;
  wire        _slots_3_io_out_uop_mem_signed;
  wire        _slots_3_io_out_uop_is_fence;
  wire        _slots_3_io_out_uop_is_amo;
  wire        _slots_3_io_out_uop_uses_ldq;
  wire        _slots_3_io_out_uop_uses_stq;
  wire        _slots_3_io_out_uop_ldst_val;
  wire [1:0]  _slots_3_io_out_uop_dst_rtype;
  wire [1:0]  _slots_3_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_3_io_out_uop_lrs2_rtype;
  wire        _slots_3_io_out_uop_fp_val;
  wire [6:0]  _slots_3_io_uop_uopc;
  wire [9:0]  _slots_3_io_uop_fu_code;
  wire        _slots_3_io_uop_iw_p1_poisoned;
  wire        _slots_3_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_3_io_uop_br_mask;
  wire [19:0] _slots_3_io_uop_imm_packed;
  wire [6:0]  _slots_3_io_uop_rob_idx;
  wire [4:0]  _slots_3_io_uop_ldq_idx;
  wire [4:0]  _slots_3_io_uop_stq_idx;
  wire [6:0]  _slots_3_io_uop_pdst;
  wire [6:0]  _slots_3_io_uop_prs1;
  wire [6:0]  _slots_3_io_uop_prs2;
  wire [4:0]  _slots_3_io_uop_mem_cmd;
  wire [1:0]  _slots_3_io_uop_mem_size;
  wire        _slots_3_io_uop_mem_signed;
  wire        _slots_3_io_uop_is_fence;
  wire        _slots_3_io_uop_is_amo;
  wire        _slots_3_io_uop_uses_ldq;
  wire        _slots_3_io_uop_uses_stq;
  wire [1:0]  _slots_3_io_uop_lrs1_rtype;
  wire [1:0]  _slots_3_io_uop_lrs2_rtype;
  wire        _slots_3_io_uop_fp_val;
  wire        _slots_2_io_valid;
  wire        _slots_2_io_will_be_valid;
  wire        _slots_2_io_request;
  wire [6:0]  _slots_2_io_out_uop_uopc;
  wire        _slots_2_io_out_uop_is_rvc;
  wire [9:0]  _slots_2_io_out_uop_fu_code;
  wire [1:0]  _slots_2_io_out_uop_iw_state;
  wire        _slots_2_io_out_uop_iw_p1_poisoned;
  wire        _slots_2_io_out_uop_iw_p2_poisoned;
  wire        _slots_2_io_out_uop_is_br;
  wire        _slots_2_io_out_uop_is_jalr;
  wire        _slots_2_io_out_uop_is_jal;
  wire        _slots_2_io_out_uop_is_sfb;
  wire [19:0] _slots_2_io_out_uop_br_mask;
  wire [4:0]  _slots_2_io_out_uop_br_tag;
  wire [5:0]  _slots_2_io_out_uop_ftq_idx;
  wire        _slots_2_io_out_uop_edge_inst;
  wire [5:0]  _slots_2_io_out_uop_pc_lob;
  wire        _slots_2_io_out_uop_taken;
  wire [19:0] _slots_2_io_out_uop_imm_packed;
  wire [6:0]  _slots_2_io_out_uop_rob_idx;
  wire [4:0]  _slots_2_io_out_uop_ldq_idx;
  wire [4:0]  _slots_2_io_out_uop_stq_idx;
  wire [6:0]  _slots_2_io_out_uop_pdst;
  wire [6:0]  _slots_2_io_out_uop_prs1;
  wire [6:0]  _slots_2_io_out_uop_prs2;
  wire [6:0]  _slots_2_io_out_uop_prs3;
  wire        _slots_2_io_out_uop_prs1_busy;
  wire        _slots_2_io_out_uop_prs2_busy;
  wire        _slots_2_io_out_uop_prs3_busy;
  wire        _slots_2_io_out_uop_ppred_busy;
  wire        _slots_2_io_out_uop_bypassable;
  wire [4:0]  _slots_2_io_out_uop_mem_cmd;
  wire [1:0]  _slots_2_io_out_uop_mem_size;
  wire        _slots_2_io_out_uop_mem_signed;
  wire        _slots_2_io_out_uop_is_fence;
  wire        _slots_2_io_out_uop_is_amo;
  wire        _slots_2_io_out_uop_uses_ldq;
  wire        _slots_2_io_out_uop_uses_stq;
  wire        _slots_2_io_out_uop_ldst_val;
  wire [1:0]  _slots_2_io_out_uop_dst_rtype;
  wire [1:0]  _slots_2_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_2_io_out_uop_lrs2_rtype;
  wire        _slots_2_io_out_uop_fp_val;
  wire [6:0]  _slots_2_io_uop_uopc;
  wire [9:0]  _slots_2_io_uop_fu_code;
  wire        _slots_2_io_uop_iw_p1_poisoned;
  wire        _slots_2_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_2_io_uop_br_mask;
  wire [19:0] _slots_2_io_uop_imm_packed;
  wire [6:0]  _slots_2_io_uop_rob_idx;
  wire [4:0]  _slots_2_io_uop_ldq_idx;
  wire [4:0]  _slots_2_io_uop_stq_idx;
  wire [6:0]  _slots_2_io_uop_pdst;
  wire [6:0]  _slots_2_io_uop_prs1;
  wire [6:0]  _slots_2_io_uop_prs2;
  wire [4:0]  _slots_2_io_uop_mem_cmd;
  wire [1:0]  _slots_2_io_uop_mem_size;
  wire        _slots_2_io_uop_mem_signed;
  wire        _slots_2_io_uop_is_fence;
  wire        _slots_2_io_uop_is_amo;
  wire        _slots_2_io_uop_uses_ldq;
  wire        _slots_2_io_uop_uses_stq;
  wire [1:0]  _slots_2_io_uop_lrs1_rtype;
  wire [1:0]  _slots_2_io_uop_lrs2_rtype;
  wire        _slots_2_io_uop_fp_val;
  wire        _slots_1_io_valid;
  wire        _slots_1_io_will_be_valid;
  wire        _slots_1_io_request;
  wire [6:0]  _slots_1_io_out_uop_uopc;
  wire        _slots_1_io_out_uop_is_rvc;
  wire [9:0]  _slots_1_io_out_uop_fu_code;
  wire [1:0]  _slots_1_io_out_uop_iw_state;
  wire        _slots_1_io_out_uop_iw_p1_poisoned;
  wire        _slots_1_io_out_uop_iw_p2_poisoned;
  wire        _slots_1_io_out_uop_is_br;
  wire        _slots_1_io_out_uop_is_jalr;
  wire        _slots_1_io_out_uop_is_jal;
  wire        _slots_1_io_out_uop_is_sfb;
  wire [19:0] _slots_1_io_out_uop_br_mask;
  wire [4:0]  _slots_1_io_out_uop_br_tag;
  wire [5:0]  _slots_1_io_out_uop_ftq_idx;
  wire        _slots_1_io_out_uop_edge_inst;
  wire [5:0]  _slots_1_io_out_uop_pc_lob;
  wire        _slots_1_io_out_uop_taken;
  wire [19:0] _slots_1_io_out_uop_imm_packed;
  wire [6:0]  _slots_1_io_out_uop_rob_idx;
  wire [4:0]  _slots_1_io_out_uop_ldq_idx;
  wire [4:0]  _slots_1_io_out_uop_stq_idx;
  wire [6:0]  _slots_1_io_out_uop_pdst;
  wire [6:0]  _slots_1_io_out_uop_prs1;
  wire [6:0]  _slots_1_io_out_uop_prs2;
  wire [6:0]  _slots_1_io_out_uop_prs3;
  wire        _slots_1_io_out_uop_prs1_busy;
  wire        _slots_1_io_out_uop_prs2_busy;
  wire        _slots_1_io_out_uop_prs3_busy;
  wire        _slots_1_io_out_uop_ppred_busy;
  wire        _slots_1_io_out_uop_bypassable;
  wire [4:0]  _slots_1_io_out_uop_mem_cmd;
  wire [1:0]  _slots_1_io_out_uop_mem_size;
  wire        _slots_1_io_out_uop_mem_signed;
  wire        _slots_1_io_out_uop_is_fence;
  wire        _slots_1_io_out_uop_is_amo;
  wire        _slots_1_io_out_uop_uses_ldq;
  wire        _slots_1_io_out_uop_uses_stq;
  wire        _slots_1_io_out_uop_ldst_val;
  wire [1:0]  _slots_1_io_out_uop_dst_rtype;
  wire [1:0]  _slots_1_io_out_uop_lrs1_rtype;
  wire [1:0]  _slots_1_io_out_uop_lrs2_rtype;
  wire        _slots_1_io_out_uop_fp_val;
  wire [6:0]  _slots_1_io_uop_uopc;
  wire [9:0]  _slots_1_io_uop_fu_code;
  wire        _slots_1_io_uop_iw_p1_poisoned;
  wire        _slots_1_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_1_io_uop_br_mask;
  wire [19:0] _slots_1_io_uop_imm_packed;
  wire [6:0]  _slots_1_io_uop_rob_idx;
  wire [4:0]  _slots_1_io_uop_ldq_idx;
  wire [4:0]  _slots_1_io_uop_stq_idx;
  wire [6:0]  _slots_1_io_uop_pdst;
  wire [6:0]  _slots_1_io_uop_prs1;
  wire [6:0]  _slots_1_io_uop_prs2;
  wire [4:0]  _slots_1_io_uop_mem_cmd;
  wire [1:0]  _slots_1_io_uop_mem_size;
  wire        _slots_1_io_uop_mem_signed;
  wire        _slots_1_io_uop_is_fence;
  wire        _slots_1_io_uop_is_amo;
  wire        _slots_1_io_uop_uses_ldq;
  wire        _slots_1_io_uop_uses_stq;
  wire [1:0]  _slots_1_io_uop_lrs1_rtype;
  wire [1:0]  _slots_1_io_uop_lrs2_rtype;
  wire        _slots_1_io_uop_fp_val;
  wire        _slots_0_io_valid;
  wire        _slots_0_io_will_be_valid;
  wire        _slots_0_io_request;
  wire [6:0]  _slots_0_io_uop_uopc;
  wire [9:0]  _slots_0_io_uop_fu_code;
  wire        _slots_0_io_uop_iw_p1_poisoned;
  wire        _slots_0_io_uop_iw_p2_poisoned;
  wire [19:0] _slots_0_io_uop_br_mask;
  wire [19:0] _slots_0_io_uop_imm_packed;
  wire [6:0]  _slots_0_io_uop_rob_idx;
  wire [4:0]  _slots_0_io_uop_ldq_idx;
  wire [4:0]  _slots_0_io_uop_stq_idx;
  wire [6:0]  _slots_0_io_uop_pdst;
  wire [6:0]  _slots_0_io_uop_prs1;
  wire [6:0]  _slots_0_io_uop_prs2;
  wire [4:0]  _slots_0_io_uop_mem_cmd;
  wire [1:0]  _slots_0_io_uop_mem_size;
  wire        _slots_0_io_uop_mem_signed;
  wire        _slots_0_io_uop_is_fence;
  wire        _slots_0_io_uop_is_amo;
  wire        _slots_0_io_uop_uses_ldq;
  wire        _slots_0_io_uop_uses_stq;
  wire [1:0]  _slots_0_io_uop_lrs1_rtype;
  wire [1:0]  _slots_0_io_uop_lrs2_rtype;
  wire        _slots_0_io_uop_fp_val;
  wire        _GEN = io_dis_uops_0_bits_uopc == 7'h2;
  wire        _GEN_0 = _GEN & ~(|io_dis_uops_0_bits_lrs2_rtype) | io_dis_uops_0_bits_uopc == 7'h43;
  wire [1:0]  _GEN_7496 = _GEN_0 ? 2'h2 : 2'h1;
  wire        _GEN_1 = _GEN_0 | ~(_GEN & (|io_dis_uops_0_bits_lrs2_rtype));
  wire [1:0]  _GEN_7445 = _GEN_1 ? io_dis_uops_0_bits_lrs2_rtype : 2'h2;
  wire        _GEN_7471 = _GEN_1 & io_dis_uops_0_bits_prs2_busy;
  wire        _GEN_2 = io_dis_uops_1_bits_uopc == 7'h2;
  wire        _GEN_3 = _GEN_2 & ~(|io_dis_uops_1_bits_lrs2_rtype) | io_dis_uops_1_bits_uopc == 7'h43;
  wire [1:0]  _GEN_7 = _GEN_3 ? 2'h2 : 2'h1;
  wire        _GEN_4 = _GEN_3 | ~(_GEN_2 & (|io_dis_uops_1_bits_lrs2_rtype));
  wire [1:0]  _GEN_8 = _GEN_4 ? io_dis_uops_1_bits_lrs2_rtype : 2'h2;
  wire        _GEN_9 = _GEN_4 & io_dis_uops_1_bits_prs2_busy;
  wire        _GEN_5 = io_dis_uops_2_bits_uopc == 7'h2;
  wire        _GEN_6 = _GEN_5 & ~(|io_dis_uops_2_bits_lrs2_rtype) | io_dis_uops_2_bits_uopc == 7'h43;
  wire        _GEN_10 = _GEN_6 | ~(_GEN_5 & (|io_dis_uops_2_bits_lrs2_rtype));
  wire [1:0]  _GEN_13 = _GEN_10 ? io_dis_uops_2_bits_lrs2_rtype : 2'h2;
  wire        _GEN_14 = _GEN_10 & io_dis_uops_2_bits_prs2_busy;
  wire        _GEN_11 = io_dis_uops_3_bits_uopc == 7'h2;
  wire        _GEN_12 = _GEN_11 & ~(|io_dis_uops_3_bits_lrs2_rtype) | io_dis_uops_3_bits_uopc == 7'h43;
  wire        _GEN_15 = _GEN_12 | ~(_GEN_11 & (|io_dis_uops_3_bits_lrs2_rtype));
  wire        _GEN_16 = _slots_1_io_request & (|(_slots_1_io_uop_fu_code & io_fu_types_0));
  wire [9:0]  _can_allocate_T = _slots_0_io_uop_fu_code & io_fu_types_0;
  wire        _GEN_17 = _slots_0_io_request & (|_can_allocate_T);
  wire        _GEN_18 = _slots_1_io_request & ~(_GEN_16 & ~_GEN_17) & (|(_slots_1_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_19 = _slots_0_io_request & ~_GEN_17;
  wire [9:0]  _can_allocate_T_1 = _slots_0_io_uop_fu_code & io_fu_types_1;
  wire        _GEN_20 = _GEN_19 & (|_can_allocate_T_1);
  wire        _GEN_21 = _GEN_18 & ~_GEN_20;
  wire        _GEN_7915 = _GEN_16 & ~_GEN_17;
  wire        issue_slots_1_grant = _GEN_21 | _GEN_7915;
  wire        _GEN_22 = _slots_2_io_request & (|(_slots_2_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_23 = _GEN_16 | _GEN_17;
  wire        _GEN_24 = _slots_2_io_request & ~(_GEN_22 & ~_GEN_23) & (|(_slots_2_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_26 = _GEN_18 | _GEN_20;
  wire        _GEN_28 = _GEN_24 & ~_GEN_26;
  wire        _GEN_8077 = _GEN_22 & ~_GEN_23;
  wire        issue_slots_2_grant = _GEN_28 | _GEN_8077;
  wire        _GEN_7835 = _GEN_19 & (|_can_allocate_T_1);
  wire        _GEN_7754 = _slots_0_io_request & (|_can_allocate_T);
  wire        issue_slots_0_grant = _GEN_7835 | _GEN_7754;
  wire        _GEN_30 = _slots_4_io_request & (|(_slots_4_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_32 = _slots_3_io_request & (|(_slots_3_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_34 = _GEN_22 | _GEN_23;
  wire        _GEN_36 = _GEN_32 | _GEN_34;
  wire        _GEN_38 = _slots_4_io_request & ~(_GEN_30 & ~_GEN_36) & (|(_slots_4_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_40 = _slots_3_io_request & ~(_GEN_32 & ~_GEN_34) & (|(_slots_3_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_42 = _GEN_24 | _GEN_26;
  wire        _GEN_44 = _GEN_40 | _GEN_42;
  wire        _GEN_46 = _GEN_38 & ~_GEN_44;
  wire        _GEN_8401 = _GEN_30 & ~_GEN_36;
  wire        issue_slots_4_grant = _GEN_46 | _GEN_8401;
  wire        _GEN_48 = _slots_5_io_request & (|(_slots_5_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_50 = _GEN_30 | _GEN_36;
  wire        _GEN_52 = _slots_5_io_request & ~(_GEN_48 & ~_GEN_50) & (|(_slots_5_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_54 = _GEN_38 | _GEN_44;
  wire        _GEN_56 = _GEN_52 & ~_GEN_54;
  wire        _GEN_8563 = _GEN_48 & ~_GEN_50;
  wire        issue_slots_5_grant = _GEN_56 | _GEN_8563;
  wire        _GEN_58 = _GEN_40 & ~_GEN_42;
  wire        _GEN_8239 = _GEN_32 & ~_GEN_34;
  wire        issue_slots_3_grant = _GEN_58 | _GEN_8239;
  wire        _GEN_60 = _slots_7_io_request & (|(_slots_7_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_62 = _slots_6_io_request & (|(_slots_6_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_64 = _GEN_48 | _GEN_50;
  wire        _GEN_66 = _GEN_62 | _GEN_64;
  wire        _GEN_67 = _slots_7_io_request & ~(_GEN_60 & ~_GEN_66) & (|(_slots_7_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_68 = _slots_6_io_request & ~(_GEN_62 & ~_GEN_64) & (|(_slots_6_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_69 = _GEN_52 | _GEN_54;
  wire        _GEN_70 = _GEN_68 | _GEN_69;
  wire        _GEN_71 = _GEN_67 & ~_GEN_70;
  wire        _GEN_8887 = _GEN_60 & ~_GEN_66;
  wire        issue_slots_7_grant = _GEN_71 | _GEN_8887;
  wire        _GEN_72 = _slots_8_io_request & (|(_slots_8_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_73 = _GEN_60 | _GEN_66;
  wire        _GEN_74 = _slots_8_io_request & ~(_GEN_72 & ~_GEN_73) & (|(_slots_8_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_75 = _GEN_67 | _GEN_70;
  wire        _GEN_76 = _GEN_74 & ~_GEN_75;
  wire        _GEN_9049 = _GEN_72 & ~_GEN_73;
  wire        issue_slots_8_grant = _GEN_76 | _GEN_9049;
  wire        _GEN_77 = _GEN_68 & ~_GEN_69;
  wire        _GEN_8725 = _GEN_62 & ~_GEN_64;
  wire        issue_slots_6_grant = _GEN_77 | _GEN_8725;
  wire        _GEN_78 = _slots_10_io_request & (|(_slots_10_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_79 = _slots_9_io_request & (|(_slots_9_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_80 = _GEN_72 | _GEN_73;
  wire        _GEN_81 = _GEN_79 | _GEN_80;
  wire        _GEN_82 = _slots_10_io_request & ~(_GEN_78 & ~_GEN_81) & (|(_slots_10_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_83 = _slots_9_io_request & ~(_GEN_79 & ~_GEN_80) & (|(_slots_9_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_84 = _GEN_74 | _GEN_75;
  wire        _GEN_85 = _GEN_83 | _GEN_84;
  wire        _GEN_86 = _GEN_82 & ~_GEN_85;
  wire        _GEN_9373 = _GEN_78 & ~_GEN_81;
  wire        issue_slots_10_grant = _GEN_86 | _GEN_9373;
  wire        _GEN_87 = _slots_11_io_request & (|(_slots_11_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_88 = _GEN_78 | _GEN_81;
  wire        _GEN_89 = _slots_11_io_request & ~(_GEN_87 & ~_GEN_88) & (|(_slots_11_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_90 = _GEN_82 | _GEN_85;
  wire        _GEN_91 = _GEN_89 & ~_GEN_90;
  wire        _GEN_9535 = _GEN_87 & ~_GEN_88;
  wire        issue_slots_11_grant = _GEN_91 | _GEN_9535;
  wire        _GEN_92 = _GEN_83 & ~_GEN_84;
  wire        _GEN_9211 = _GEN_79 & ~_GEN_80;
  wire        issue_slots_9_grant = _GEN_92 | _GEN_9211;
  wire        _GEN_93 = _slots_13_io_request & (|(_slots_13_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_94 = _slots_12_io_request & (|(_slots_12_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_95 = _GEN_87 | _GEN_88;
  wire        _GEN_96 = _GEN_94 | _GEN_95;
  wire        _GEN_97 = _slots_13_io_request & ~(_GEN_93 & ~_GEN_96) & (|(_slots_13_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_98 = _slots_12_io_request & ~(_GEN_94 & ~_GEN_95) & (|(_slots_12_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_99 = _GEN_89 | _GEN_90;
  wire        _GEN_100 = _GEN_98 | _GEN_99;
  wire        _GEN_101 = _GEN_97 & ~_GEN_100;
  wire        _GEN_9859 = _GEN_93 & ~_GEN_96;
  wire        issue_slots_13_grant = _GEN_101 | _GEN_9859;
  wire        _GEN_102 = _slots_14_io_request & (|(_slots_14_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_103 = _GEN_93 | _GEN_96;
  wire        _GEN_104 = _slots_14_io_request & ~(_GEN_102 & ~_GEN_103) & (|(_slots_14_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_105 = _GEN_97 | _GEN_100;
  wire        _GEN_106 = _GEN_104 & ~_GEN_105;
  wire        _GEN_10021 = _GEN_102 & ~_GEN_103;
  wire        issue_slots_14_grant = _GEN_106 | _GEN_10021;
  wire        _GEN_107 = _GEN_98 & ~_GEN_99;
  wire        _GEN_9697 = _GEN_94 & ~_GEN_95;
  wire        issue_slots_12_grant = _GEN_107 | _GEN_9697;
  wire        _GEN_108 = _slots_16_io_request & (|(_slots_16_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_109 = _slots_15_io_request & (|(_slots_15_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_110 = _GEN_102 | _GEN_103;
  wire        _GEN_111 = _GEN_109 | _GEN_110;
  wire        _GEN_112 = _slots_16_io_request & ~(_GEN_108 & ~_GEN_111) & (|(_slots_16_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_113 = _slots_15_io_request & ~(_GEN_109 & ~_GEN_110) & (|(_slots_15_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_114 = _GEN_104 | _GEN_105;
  wire        _GEN_115 = _GEN_113 | _GEN_114;
  wire        _GEN_116 = _GEN_112 & ~_GEN_115;
  wire        _GEN_10345 = _GEN_108 & ~_GEN_111;
  wire        issue_slots_16_grant = _GEN_116 | _GEN_10345;
  wire        _GEN_117 = _slots_17_io_request & (|(_slots_17_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_118 = _GEN_108 | _GEN_111;
  wire        _GEN_119 = _slots_17_io_request & ~(_GEN_117 & ~_GEN_118) & (|(_slots_17_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_120 = _GEN_112 | _GEN_115;
  wire        _GEN_121 = _GEN_119 & ~_GEN_120;
  wire        _GEN_10507 = _GEN_117 & ~_GEN_118;
  wire        issue_slots_17_grant = _GEN_121 | _GEN_10507;
  wire        _GEN_122 = _GEN_113 & ~_GEN_114;
  wire        _GEN_10183 = _GEN_109 & ~_GEN_110;
  wire        issue_slots_15_grant = _GEN_122 | _GEN_10183;
  wire        _GEN_123 = _slots_19_io_request & (|(_slots_19_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_124 = _slots_18_io_request & (|(_slots_18_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_125 = _GEN_117 | _GEN_118;
  wire        _GEN_126 = _GEN_124 | _GEN_125;
  wire        _GEN_127 = _slots_19_io_request & ~(_GEN_123 & ~_GEN_126) & (|(_slots_19_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_128 = _slots_18_io_request & ~(_GEN_124 & ~_GEN_125) & (|(_slots_18_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_129 = _GEN_119 | _GEN_120;
  wire        _GEN_130 = _GEN_128 | _GEN_129;
  wire        _GEN_131 = _GEN_127 & ~_GEN_130;
  wire        _GEN_10831 = _GEN_123 & ~_GEN_126;
  wire        issue_slots_19_grant = _GEN_131 | _GEN_10831;
  wire        _GEN_132 = _slots_20_io_request & (|(_slots_20_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_133 = _GEN_123 | _GEN_126;
  wire        _GEN_134 = _slots_20_io_request & ~(_GEN_132 & ~_GEN_133) & (|(_slots_20_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_135 = _GEN_127 | _GEN_130;
  wire        _GEN_136 = _GEN_134 & ~_GEN_135;
  wire        _GEN_10993 = _GEN_132 & ~_GEN_133;
  wire        issue_slots_20_grant = _GEN_136 | _GEN_10993;
  wire        _GEN_137 = _GEN_128 & ~_GEN_129;
  wire        _GEN_10669 = _GEN_124 & ~_GEN_125;
  wire        issue_slots_18_grant = _GEN_137 | _GEN_10669;
  wire        _GEN_138 = _slots_22_io_request & (|(_slots_22_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_139 = _slots_21_io_request & (|(_slots_21_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_140 = _GEN_132 | _GEN_133;
  wire        _GEN_141 = _GEN_139 | _GEN_140;
  wire        _GEN_142 = _slots_22_io_request & ~(_GEN_138 & ~_GEN_141) & (|(_slots_22_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_143 = _slots_21_io_request & ~(_GEN_139 & ~_GEN_140) & (|(_slots_21_io_uop_fu_code & io_fu_types_1));
  wire        _GEN_144 = _GEN_134 | _GEN_135;
  wire        _GEN_145 = _GEN_143 | _GEN_144;
  wire        _GEN_146 = _GEN_142 & ~_GEN_145;
  wire        _GEN_11317 = _GEN_138 & ~_GEN_141;
  wire        issue_slots_22_grant = _GEN_146 | _GEN_11317;
  wire        _GEN_147 = _slots_23_io_request & (|(_slots_23_io_uop_fu_code & io_fu_types_0));
  wire        _GEN_148 = _GEN_138 | _GEN_141;
  wire        _GEN_149 = _slots_23_io_request & ~(_GEN_147 & ~_GEN_148) & (|(_slots_23_io_uop_fu_code & io_fu_types_1)) & ~(_GEN_142 | _GEN_145);
  wire        _GEN_11479 = _GEN_147 & ~_GEN_148;
  wire        issue_slots_23_grant = _GEN_149 | _GEN_11479;
  wire        _GEN_150 = _GEN_143 & ~_GEN_144;
  wire        _GEN_11155 = _GEN_139 & ~_GEN_140;
  wire        issue_slots_21_grant = _GEN_150 | _GEN_11155;
  wire [3:0]  _GEN_23_0 = _slots_0_io_valid & ~_slots_1_io_valid ? 4'h1 : _slots_1_io_valid ? {3'h0, ~_slots_0_io_valid} : {2'h0, ~_slots_0_io_valid, 1'h0};
  assign _GEN_23_1to0 = _GEN_23_0[1:0];
  assign _GEN_25 = _GEN_23_1to0 == 2'h0 & ~_slots_2_io_valid ? 4'h1 : _GEN_23_0[3] | _slots_2_io_valid ? _GEN_23_0 : {_GEN_23_0[2:0], 1'h0};
  assign _GEN_27 = _GEN_25 == 4'h0 & ~_slots_3_io_valid ? 4'h1 : _GEN_25[3] | _slots_3_io_valid ? _GEN_25 : {_GEN_25[2:0], 1'h0};
  assign _GEN_29 = _GEN_27 == 4'h0 & ~_slots_4_io_valid ? 4'h1 : _GEN_27[3] | _slots_4_io_valid ? _GEN_27 : {_GEN_27[2:0], 1'h0};
  assign _GEN_31 = _GEN_29 == 4'h0 & ~_slots_5_io_valid ? 4'h1 : _GEN_29[3] | _slots_5_io_valid ? _GEN_29 : {_GEN_29[2:0], 1'h0};
  assign _GEN_33 = _GEN_31 == 4'h0 & ~_slots_6_io_valid ? 4'h1 : _GEN_31[3] | _slots_6_io_valid ? _GEN_31 : {_GEN_31[2:0], 1'h0};
  assign _GEN_35 = _GEN_33 == 4'h0 & ~_slots_7_io_valid ? 4'h1 : _GEN_33[3] | _slots_7_io_valid ? _GEN_33 : {_GEN_33[2:0], 1'h0};
  assign _GEN_37 = _GEN_35 == 4'h0 & ~_slots_8_io_valid ? 4'h1 : _GEN_35[3] | _slots_8_io_valid ? _GEN_35 : {_GEN_35[2:0], 1'h0};
  assign _GEN_39 = _GEN_37 == 4'h0 & ~_slots_9_io_valid ? 4'h1 : _GEN_37[3] | _slots_9_io_valid ? _GEN_37 : {_GEN_37[2:0], 1'h0};
  assign _GEN_41 = _GEN_39 == 4'h0 & ~_slots_10_io_valid ? 4'h1 : _GEN_39[3] | _slots_10_io_valid ? _GEN_39 : {_GEN_39[2:0], 1'h0};
  assign _GEN_43 = _GEN_41 == 4'h0 & ~_slots_11_io_valid ? 4'h1 : _GEN_41[3] | _slots_11_io_valid ? _GEN_41 : {_GEN_41[2:0], 1'h0};
  assign _GEN_45 = _GEN_43 == 4'h0 & ~_slots_12_io_valid ? 4'h1 : _GEN_43[3] | _slots_12_io_valid ? _GEN_43 : {_GEN_43[2:0], 1'h0};
  assign _GEN_47 = _GEN_45 == 4'h0 & ~_slots_13_io_valid ? 4'h1 : _GEN_45[3] | _slots_13_io_valid ? _GEN_45 : {_GEN_45[2:0], 1'h0};
  assign _GEN_49 = _GEN_47 == 4'h0 & ~_slots_14_io_valid ? 4'h1 : _GEN_47[3] | _slots_14_io_valid ? _GEN_47 : {_GEN_47[2:0], 1'h0};
  assign _GEN_51 = _GEN_49 == 4'h0 & ~_slots_15_io_valid ? 4'h1 : _GEN_49[3] | _slots_15_io_valid ? _GEN_49 : {_GEN_49[2:0], 1'h0};
  assign _GEN_53 = _GEN_51 == 4'h0 & ~_slots_16_io_valid ? 4'h1 : _GEN_51[3] | _slots_16_io_valid ? _GEN_51 : {_GEN_51[2:0], 1'h0};
  assign _GEN_55 = _GEN_53 == 4'h0 & ~_slots_17_io_valid ? 4'h1 : _GEN_53[3] | _slots_17_io_valid ? _GEN_53 : {_GEN_53[2:0], 1'h0};
  assign _GEN_57 = _GEN_55 == 4'h0 & ~_slots_18_io_valid ? 4'h1 : _GEN_55[3] | _slots_18_io_valid ? _GEN_55 : {_GEN_55[2:0], 1'h0};
  assign _GEN_59 = _GEN_57 == 4'h0 & ~_slots_19_io_valid ? 4'h1 : _GEN_57[3] | _slots_19_io_valid ? _GEN_57 : {_GEN_57[2:0], 1'h0};
  assign _GEN_61 = _GEN_59 == 4'h0 & ~_slots_20_io_valid ? 4'h1 : _GEN_59[3] | _slots_20_io_valid ? _GEN_59 : {_GEN_59[2:0], 1'h0};
  assign _GEN_63 = _GEN_61 == 4'h0 & ~_slots_21_io_valid ? 4'h1 : _GEN_61[3] | _slots_21_io_valid ? _GEN_61 : {_GEN_61[2:0], 1'h0};
  assign _GEN_65 = _GEN_63 == 4'h0 & ~_slots_22_io_valid ? 4'h1 : _GEN_63[3] | _slots_22_io_valid ? _GEN_63 : {_GEN_63[2:0], 1'h0};
  wire [3:0]  _GEN_67_0 = _GEN_65 == 4'h0 & ~_slots_23_io_valid ? 4'h1 : _GEN_65[3] | _slots_23_io_valid ? _GEN_65 : {_GEN_65[2:0], 1'h0};
  wire [3:0]  _GEN_69_0 = _GEN_67_0 == 4'h0 & ~io_dis_uops_0_valid ? 4'h1 : _GEN_67_0[3] | io_dis_uops_0_valid ? _GEN_67_0 : {_GEN_67_0[2:0], 1'h0};
  wire [3:0]  _GEN_71_0 = _GEN_69_0 == 4'h0 & ~io_dis_uops_1_valid ? 4'h1 : _GEN_69_0[3] | io_dis_uops_1_valid ? _GEN_69_0 : {_GEN_69_0[2:0], 1'h0};
  wire        will_be_valid_24 = io_dis_uops_0_valid & ~io_dis_uops_0_bits_exception & ~io_dis_uops_0_bits_is_fence & ~io_dis_uops_0_bits_is_fencei;
  wire        will_be_valid_25 = io_dis_uops_1_valid & ~io_dis_uops_1_bits_exception & ~io_dis_uops_1_bits_is_fence & ~io_dis_uops_1_bits_is_fencei;
  wire        will_be_valid_26 = io_dis_uops_2_valid & ~io_dis_uops_2_bits_exception & ~io_dis_uops_2_bits_is_fence & ~io_dis_uops_2_bits_is_fencei;
  wire        _GEN_151 = _GEN_23_1to0 == 2'h2;
  wire        _GEN_152 = _GEN_25 == 4'h4;
  wire        _GEN_153 = _GEN_27 == 4'h8;
  wire        issue_slots_0_in_uop_valid = _GEN_153 ? _slots_4_io_will_be_valid : _GEN_152 ? _slots_3_io_will_be_valid : _GEN_151 ? _slots_2_io_will_be_valid : ~_slots_0_io_valid & _slots_1_io_will_be_valid;
  wire        _GEN_154 = _GEN_25 == 4'h2;
  wire        _GEN_155 = _GEN_27 == 4'h4;
  wire        _GEN_156 = _GEN_29 == 4'h8;
  wire        issue_slots_1_in_uop_valid = _GEN_156 ? _slots_5_io_will_be_valid : _GEN_155 ? _slots_4_io_will_be_valid : _GEN_154 ? _slots_3_io_will_be_valid : _GEN_23_1to0 == 2'h1 & _slots_2_io_will_be_valid;
  wire        _GEN_157 = _GEN_27 == 4'h2;
  wire        _GEN_158 = _GEN_29 == 4'h4;
  wire        _GEN_159 = _GEN_31 == 4'h8;
  wire        issue_slots_2_in_uop_valid = _GEN_159 ? _slots_6_io_will_be_valid : _GEN_158 ? _slots_5_io_will_be_valid : _GEN_157 ? _slots_4_io_will_be_valid : _GEN_25 == 4'h1 & _slots_3_io_will_be_valid;
  wire        _GEN_160 = _GEN_29 == 4'h2;
  wire        _GEN_161 = _GEN_31 == 4'h4;
  wire        _GEN_162 = _GEN_33 == 4'h8;
  wire        issue_slots_3_in_uop_valid = _GEN_162 ? _slots_7_io_will_be_valid : _GEN_161 ? _slots_6_io_will_be_valid : _GEN_160 ? _slots_5_io_will_be_valid : _GEN_27 == 4'h1 & _slots_4_io_will_be_valid;
  wire        _GEN_163 = _GEN_31 == 4'h2;
  wire        _GEN_164 = _GEN_33 == 4'h4;
  wire        _GEN_165 = _GEN_35 == 4'h8;
  wire        issue_slots_4_in_uop_valid = _GEN_165 ? _slots_8_io_will_be_valid : _GEN_164 ? _slots_7_io_will_be_valid : _GEN_163 ? _slots_6_io_will_be_valid : _GEN_29 == 4'h1 & _slots_5_io_will_be_valid;
  wire        _GEN_166 = _GEN_33 == 4'h2;
  wire        _GEN_167 = _GEN_35 == 4'h4;
  wire        _GEN_168 = _GEN_37 == 4'h8;
  wire        issue_slots_5_in_uop_valid = _GEN_168 ? _slots_9_io_will_be_valid : _GEN_167 ? _slots_8_io_will_be_valid : _GEN_166 ? _slots_7_io_will_be_valid : _GEN_31 == 4'h1 & _slots_6_io_will_be_valid;
  wire        _GEN_169 = _GEN_35 == 4'h2;
  wire        _GEN_170 = _GEN_37 == 4'h4;
  wire        _GEN_171 = _GEN_39 == 4'h8;
  wire        issue_slots_6_in_uop_valid = _GEN_171 ? _slots_10_io_will_be_valid : _GEN_170 ? _slots_9_io_will_be_valid : _GEN_169 ? _slots_8_io_will_be_valid : _GEN_33 == 4'h1 & _slots_7_io_will_be_valid;
  wire        _GEN_172 = _GEN_37 == 4'h2;
  wire        _GEN_173 = _GEN_39 == 4'h4;
  wire        _GEN_174 = _GEN_41 == 4'h8;
  wire        issue_slots_7_in_uop_valid = _GEN_174 ? _slots_11_io_will_be_valid : _GEN_173 ? _slots_10_io_will_be_valid : _GEN_172 ? _slots_9_io_will_be_valid : _GEN_35 == 4'h1 & _slots_8_io_will_be_valid;
  wire        _GEN_175 = _GEN_39 == 4'h2;
  wire        _GEN_176 = _GEN_41 == 4'h4;
  wire        _GEN_177 = _GEN_43 == 4'h8;
  wire        issue_slots_8_in_uop_valid = _GEN_177 ? _slots_12_io_will_be_valid : _GEN_176 ? _slots_11_io_will_be_valid : _GEN_175 ? _slots_10_io_will_be_valid : _GEN_37 == 4'h1 & _slots_9_io_will_be_valid;
  wire        _GEN_178 = _GEN_41 == 4'h2;
  wire        _GEN_179 = _GEN_43 == 4'h4;
  wire        _GEN_180 = _GEN_45 == 4'h8;
  wire        issue_slots_9_in_uop_valid = _GEN_180 ? _slots_13_io_will_be_valid : _GEN_179 ? _slots_12_io_will_be_valid : _GEN_178 ? _slots_11_io_will_be_valid : _GEN_39 == 4'h1 & _slots_10_io_will_be_valid;
  wire        _GEN_181 = _GEN_43 == 4'h2;
  wire        _GEN_182 = _GEN_45 == 4'h4;
  wire        _GEN_183 = _GEN_47 == 4'h8;
  wire        issue_slots_10_in_uop_valid = _GEN_183 ? _slots_14_io_will_be_valid : _GEN_182 ? _slots_13_io_will_be_valid : _GEN_181 ? _slots_12_io_will_be_valid : _GEN_41 == 4'h1 & _slots_11_io_will_be_valid;
  wire        _GEN_184 = _GEN_45 == 4'h2;
  wire        _GEN_185 = _GEN_47 == 4'h4;
  wire        _GEN_186 = _GEN_49 == 4'h8;
  wire        issue_slots_11_in_uop_valid = _GEN_186 ? _slots_15_io_will_be_valid : _GEN_185 ? _slots_14_io_will_be_valid : _GEN_184 ? _slots_13_io_will_be_valid : _GEN_43 == 4'h1 & _slots_12_io_will_be_valid;
  wire        _GEN_187 = _GEN_47 == 4'h2;
  wire        _GEN_188 = _GEN_49 == 4'h4;
  wire        _GEN_189 = _GEN_51 == 4'h8;
  wire        issue_slots_12_in_uop_valid = _GEN_189 ? _slots_16_io_will_be_valid : _GEN_188 ? _slots_15_io_will_be_valid : _GEN_187 ? _slots_14_io_will_be_valid : _GEN_45 == 4'h1 & _slots_13_io_will_be_valid;
  wire        _GEN_190 = _GEN_49 == 4'h2;
  wire        _GEN_191 = _GEN_51 == 4'h4;
  wire        _GEN_192 = _GEN_53 == 4'h8;
  wire        issue_slots_13_in_uop_valid = _GEN_192 ? _slots_17_io_will_be_valid : _GEN_191 ? _slots_16_io_will_be_valid : _GEN_190 ? _slots_15_io_will_be_valid : _GEN_47 == 4'h1 & _slots_14_io_will_be_valid;
  wire        _GEN_193 = _GEN_51 == 4'h2;
  wire        _GEN_194 = _GEN_53 == 4'h4;
  wire        _GEN_195 = _GEN_55 == 4'h8;
  wire        issue_slots_14_in_uop_valid = _GEN_195 ? _slots_18_io_will_be_valid : _GEN_194 ? _slots_17_io_will_be_valid : _GEN_193 ? _slots_16_io_will_be_valid : _GEN_49 == 4'h1 & _slots_15_io_will_be_valid;
  wire        _GEN_196 = _GEN_53 == 4'h2;
  wire        _GEN_197 = _GEN_55 == 4'h4;
  wire        _GEN_198 = _GEN_57 == 4'h8;
  wire        issue_slots_15_in_uop_valid = _GEN_198 ? _slots_19_io_will_be_valid : _GEN_197 ? _slots_18_io_will_be_valid : _GEN_196 ? _slots_17_io_will_be_valid : _GEN_51 == 4'h1 & _slots_16_io_will_be_valid;
  wire        _GEN_199 = _GEN_55 == 4'h2;
  wire        _GEN_200 = _GEN_57 == 4'h4;
  wire        _GEN_201 = _GEN_59 == 4'h8;
  wire        issue_slots_16_in_uop_valid = _GEN_201 ? _slots_20_io_will_be_valid : _GEN_200 ? _slots_19_io_will_be_valid : _GEN_199 ? _slots_18_io_will_be_valid : _GEN_53 == 4'h1 & _slots_17_io_will_be_valid;
  wire        _GEN_202 = _GEN_57 == 4'h2;
  wire        _GEN_203 = _GEN_59 == 4'h4;
  wire        _GEN_204 = _GEN_61 == 4'h8;
  wire        issue_slots_17_in_uop_valid = _GEN_204 ? _slots_21_io_will_be_valid : _GEN_203 ? _slots_20_io_will_be_valid : _GEN_202 ? _slots_19_io_will_be_valid : _GEN_55 == 4'h1 & _slots_18_io_will_be_valid;
  wire        _GEN_205 = _GEN_59 == 4'h2;
  wire        _GEN_206 = _GEN_61 == 4'h4;
  wire        _GEN_207 = _GEN_63 == 4'h8;
  wire        issue_slots_18_in_uop_valid = _GEN_207 ? _slots_22_io_will_be_valid : _GEN_206 ? _slots_21_io_will_be_valid : _GEN_205 ? _slots_20_io_will_be_valid : _GEN_57 == 4'h1 & _slots_19_io_will_be_valid;
  wire        _GEN_208 = _GEN_61 == 4'h2;
  wire        _GEN_209 = _GEN_63 == 4'h4;
  wire        _GEN_210 = _GEN_65 == 4'h8;
  wire        issue_slots_19_in_uop_valid = _GEN_210 ? _slots_23_io_will_be_valid : _GEN_209 ? _slots_22_io_will_be_valid : _GEN_208 ? _slots_21_io_will_be_valid : _GEN_59 == 4'h1 & _slots_20_io_will_be_valid;
  wire        _GEN_211 = _GEN_63 == 4'h2;
  wire        _GEN_212 = _GEN_65 == 4'h4;
  wire        _GEN_213 = _GEN_67_0 == 4'h8;
  wire        issue_slots_20_in_uop_valid = _GEN_213 ? will_be_valid_24 : _GEN_212 ? _slots_23_io_will_be_valid : _GEN_211 ? _slots_22_io_will_be_valid : _GEN_61 == 4'h1 & _slots_21_io_will_be_valid;
  wire        _GEN_214 = _GEN_65 == 4'h2;
  wire        _GEN_215 = _GEN_67_0 == 4'h4;
  wire        _GEN_216 = _GEN_69_0 == 4'h8;
  wire        issue_slots_21_in_uop_valid = _GEN_216 ? will_be_valid_25 : _GEN_215 ? will_be_valid_24 : _GEN_214 ? _slots_23_io_will_be_valid : _GEN_63 == 4'h1 & _slots_22_io_will_be_valid;
  wire        _GEN_217 = _GEN_216 | _GEN_215;
  wire        _GEN_218 = _GEN_67_0 == 4'h2;
  wire        _GEN_219 = _GEN_69_0 == 4'h4;
  wire        _GEN_220 = _GEN_71_0 == 4'h8;
  wire        issue_slots_22_in_uop_valid = _GEN_220 ? will_be_valid_26 : _GEN_219 ? will_be_valid_25 : _GEN_218 ? will_be_valid_24 : _GEN_65 == 4'h1 & _slots_23_io_will_be_valid;
  wire        _GEN_221 = _GEN_220 | _GEN_219 | _GEN_218;
  wire        _GEN_222 = _GEN_69_0 == 4'h2;
  wire        _GEN_223 = _GEN_71_0 == 4'h4;
  wire        _GEN_224 = (_GEN_71_0 == 4'h0 & ~io_dis_uops_2_valid ? 4'h1 : _GEN_71_0[3] | io_dis_uops_2_valid ? _GEN_71_0 : {_GEN_71_0[2:0], 1'h0}) == 4'h8;
  wire        issue_slots_23_in_uop_valid = _GEN_224 ? io_dis_uops_3_valid & ~io_dis_uops_3_bits_exception & ~io_dis_uops_3_bits_is_fence & ~io_dis_uops_3_bits_is_fencei : _GEN_223 ? will_be_valid_26 : _GEN_222 ? will_be_valid_25 : _GEN_67_0 == 4'h1 & will_be_valid_24;
  reg         io_dis_uops_0_ready_REG;
  reg         io_dis_uops_1_ready_REG;
  reg         io_dis_uops_2_ready_REG;
  reg         io_dis_uops_3_ready_REG;
  wire [4:0]  num_available =
    {1'h0, {1'h0, {1'h0, {1'h0, ~_slots_0_io_will_be_valid & ~issue_slots_0_in_uop_valid} + {1'h0, (~_slots_1_io_will_be_valid | ~_slots_0_io_valid) & ~issue_slots_1_in_uop_valid} + {1'h0, (~_slots_2_io_will_be_valid | (|_GEN_23_1to0)) & ~issue_slots_2_in_uop_valid}} + {1'h0, {1'h0, (~_slots_3_io_will_be_valid | (|_GEN_25)) & ~issue_slots_3_in_uop_valid} + {1'h0, (~_slots_4_io_will_be_valid | (|_GEN_27)) & ~issue_slots_4_in_uop_valid} + {1'h0, (~_slots_5_io_will_be_valid | (|_GEN_29)) & ~issue_slots_5_in_uop_valid}}} + {1'h0, {1'h0, {1'h0, (~_slots_6_io_will_be_valid | (|_GEN_31)) & ~issue_slots_6_in_uop_valid} + {1'h0, (~_slots_7_io_will_be_valid | (|_GEN_33)) & ~issue_slots_7_in_uop_valid} + {1'h0, (~_slots_8_io_will_be_valid | (|_GEN_35)) & ~issue_slots_8_in_uop_valid}} + {1'h0, {1'h0, (~_slots_9_io_will_be_valid | (|_GEN_37)) & ~issue_slots_9_in_uop_valid} + {1'h0, (~_slots_10_io_will_be_valid | (|_GEN_39)) & ~issue_slots_10_in_uop_valid} + {1'h0, (~_slots_11_io_will_be_valid | (|_GEN_41)) & ~issue_slots_11_in_uop_valid}}}}
    + {1'h0, {1'h0, {1'h0, {1'h0, (~_slots_12_io_will_be_valid | (|_GEN_43)) & ~issue_slots_12_in_uop_valid} + {1'h0, (~_slots_13_io_will_be_valid | (|_GEN_45)) & ~issue_slots_13_in_uop_valid} + {1'h0, (~_slots_14_io_will_be_valid | (|_GEN_47)) & ~issue_slots_14_in_uop_valid}} + {1'h0, {1'h0, (~_slots_15_io_will_be_valid | (|_GEN_49)) & ~issue_slots_15_in_uop_valid} + {1'h0, (~_slots_16_io_will_be_valid | (|_GEN_51)) & ~issue_slots_16_in_uop_valid} + {1'h0, (~_slots_17_io_will_be_valid | (|_GEN_53)) & ~issue_slots_17_in_uop_valid}}} + {1'h0, {1'h0, {1'h0, (~_slots_18_io_will_be_valid | (|_GEN_55)) & ~issue_slots_18_in_uop_valid} + {1'h0, (~_slots_19_io_will_be_valid | (|_GEN_57)) & ~issue_slots_19_in_uop_valid} + {1'h0, (~_slots_20_io_will_be_valid | (|_GEN_59)) & ~issue_slots_20_in_uop_valid}} + {1'h0, {1'h0, (~_slots_21_io_will_be_valid | (|_GEN_61)) & ~issue_slots_21_in_uop_valid} + {1'h0, (~_slots_22_io_will_be_valid | (|_GEN_63)) & ~issue_slots_22_in_uop_valid} + {1'h0, (~_slots_23_io_will_be_valid | (|_GEN_65)) & ~issue_slots_23_in_uop_valid}}}};
  always @(posedge clock) begin
    io_dis_uops_0_ready_REG <= |num_available;
    io_dis_uops_1_ready_REG <= |(num_available[4:1]);
    io_dis_uops_2_ready_REG <= num_available > 5'h2;
    io_dis_uops_3_ready_REG <= |(num_available[4:2]);
  end // always @(posedge)
  IssueSlot_32 slots_0 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_0_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (1'h0),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_0_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_153 ? _slots_4_io_out_uop_uopc : _GEN_152 ? _slots_3_io_out_uop_uopc : _GEN_151 ? _slots_2_io_out_uop_uopc : _slots_1_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_153 ? _slots_4_io_out_uop_is_rvc : _GEN_152 ? _slots_3_io_out_uop_is_rvc : _GEN_151 ? _slots_2_io_out_uop_is_rvc : _slots_1_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_153 ? _slots_4_io_out_uop_fu_code : _GEN_152 ? _slots_3_io_out_uop_fu_code : _GEN_151 ? _slots_2_io_out_uop_fu_code : _slots_1_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_153 ? _slots_4_io_out_uop_iw_state : _GEN_152 ? _slots_3_io_out_uop_iw_state : _GEN_151 ? _slots_2_io_out_uop_iw_state : _slots_1_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_153 ? _slots_4_io_out_uop_iw_p1_poisoned : _GEN_152 ? _slots_3_io_out_uop_iw_p1_poisoned : _GEN_151 ? _slots_2_io_out_uop_iw_p1_poisoned : _slots_1_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_153 ? _slots_4_io_out_uop_iw_p2_poisoned : _GEN_152 ? _slots_3_io_out_uop_iw_p2_poisoned : _GEN_151 ? _slots_2_io_out_uop_iw_p2_poisoned : _slots_1_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_153 ? _slots_4_io_out_uop_is_br : _GEN_152 ? _slots_3_io_out_uop_is_br : _GEN_151 ? _slots_2_io_out_uop_is_br : _slots_1_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_153 ? _slots_4_io_out_uop_is_jalr : _GEN_152 ? _slots_3_io_out_uop_is_jalr : _GEN_151 ? _slots_2_io_out_uop_is_jalr : _slots_1_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_153 ? _slots_4_io_out_uop_is_jal : _GEN_152 ? _slots_3_io_out_uop_is_jal : _GEN_151 ? _slots_2_io_out_uop_is_jal : _slots_1_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_153 ? _slots_4_io_out_uop_is_sfb : _GEN_152 ? _slots_3_io_out_uop_is_sfb : _GEN_151 ? _slots_2_io_out_uop_is_sfb : _slots_1_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_153 ? _slots_4_io_out_uop_br_mask : _GEN_152 ? _slots_3_io_out_uop_br_mask : _GEN_151 ? _slots_2_io_out_uop_br_mask : _slots_1_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_153 ? _slots_4_io_out_uop_br_tag : _GEN_152 ? _slots_3_io_out_uop_br_tag : _GEN_151 ? _slots_2_io_out_uop_br_tag : _slots_1_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_153 ? _slots_4_io_out_uop_ftq_idx : _GEN_152 ? _slots_3_io_out_uop_ftq_idx : _GEN_151 ? _slots_2_io_out_uop_ftq_idx : _slots_1_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_153 ? _slots_4_io_out_uop_edge_inst : _GEN_152 ? _slots_3_io_out_uop_edge_inst : _GEN_151 ? _slots_2_io_out_uop_edge_inst : _slots_1_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_153 ? _slots_4_io_out_uop_pc_lob : _GEN_152 ? _slots_3_io_out_uop_pc_lob : _GEN_151 ? _slots_2_io_out_uop_pc_lob : _slots_1_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_153 ? _slots_4_io_out_uop_taken : _GEN_152 ? _slots_3_io_out_uop_taken : _GEN_151 ? _slots_2_io_out_uop_taken : _slots_1_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_153 ? _slots_4_io_out_uop_imm_packed : _GEN_152 ? _slots_3_io_out_uop_imm_packed : _GEN_151 ? _slots_2_io_out_uop_imm_packed : _slots_1_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_153 ? _slots_4_io_out_uop_rob_idx : _GEN_152 ? _slots_3_io_out_uop_rob_idx : _GEN_151 ? _slots_2_io_out_uop_rob_idx : _slots_1_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_153 ? _slots_4_io_out_uop_ldq_idx : _GEN_152 ? _slots_3_io_out_uop_ldq_idx : _GEN_151 ? _slots_2_io_out_uop_ldq_idx : _slots_1_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_153 ? _slots_4_io_out_uop_stq_idx : _GEN_152 ? _slots_3_io_out_uop_stq_idx : _GEN_151 ? _slots_2_io_out_uop_stq_idx : _slots_1_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_153 ? _slots_4_io_out_uop_pdst : _GEN_152 ? _slots_3_io_out_uop_pdst : _GEN_151 ? _slots_2_io_out_uop_pdst : _slots_1_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_153 ? _slots_4_io_out_uop_prs1 : _GEN_152 ? _slots_3_io_out_uop_prs1 : _GEN_151 ? _slots_2_io_out_uop_prs1 : _slots_1_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_153 ? _slots_4_io_out_uop_prs2 : _GEN_152 ? _slots_3_io_out_uop_prs2 : _GEN_151 ? _slots_2_io_out_uop_prs2 : _slots_1_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_153 ? _slots_4_io_out_uop_prs3 : _GEN_152 ? _slots_3_io_out_uop_prs3 : _GEN_151 ? _slots_2_io_out_uop_prs3 : _slots_1_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_153 ? _slots_4_io_out_uop_prs1_busy : _GEN_152 ? _slots_3_io_out_uop_prs1_busy : _GEN_151 ? _slots_2_io_out_uop_prs1_busy : _slots_1_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_153 ? _slots_4_io_out_uop_prs2_busy : _GEN_152 ? _slots_3_io_out_uop_prs2_busy : _GEN_151 ? _slots_2_io_out_uop_prs2_busy : _slots_1_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_153 ? _slots_4_io_out_uop_prs3_busy : _GEN_152 ? _slots_3_io_out_uop_prs3_busy : _GEN_151 ? _slots_2_io_out_uop_prs3_busy : _slots_1_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_153 ? _slots_4_io_out_uop_ppred_busy : _GEN_152 ? _slots_3_io_out_uop_ppred_busy : _GEN_151 ? _slots_2_io_out_uop_ppred_busy : _slots_1_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_153 ? _slots_4_io_out_uop_bypassable : _GEN_152 ? _slots_3_io_out_uop_bypassable : _GEN_151 ? _slots_2_io_out_uop_bypassable : _slots_1_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_153 ? _slots_4_io_out_uop_mem_cmd : _GEN_152 ? _slots_3_io_out_uop_mem_cmd : _GEN_151 ? _slots_2_io_out_uop_mem_cmd : _slots_1_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_153 ? _slots_4_io_out_uop_mem_size : _GEN_152 ? _slots_3_io_out_uop_mem_size : _GEN_151 ? _slots_2_io_out_uop_mem_size : _slots_1_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_153 ? _slots_4_io_out_uop_mem_signed : _GEN_152 ? _slots_3_io_out_uop_mem_signed : _GEN_151 ? _slots_2_io_out_uop_mem_signed : _slots_1_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_153 ? _slots_4_io_out_uop_is_fence : _GEN_152 ? _slots_3_io_out_uop_is_fence : _GEN_151 ? _slots_2_io_out_uop_is_fence : _slots_1_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_153 ? _slots_4_io_out_uop_is_amo : _GEN_152 ? _slots_3_io_out_uop_is_amo : _GEN_151 ? _slots_2_io_out_uop_is_amo : _slots_1_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_153 ? _slots_4_io_out_uop_uses_ldq : _GEN_152 ? _slots_3_io_out_uop_uses_ldq : _GEN_151 ? _slots_2_io_out_uop_uses_ldq : _slots_1_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_153 ? _slots_4_io_out_uop_uses_stq : _GEN_152 ? _slots_3_io_out_uop_uses_stq : _GEN_151 ? _slots_2_io_out_uop_uses_stq : _slots_1_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_153 ? _slots_4_io_out_uop_ldst_val : _GEN_152 ? _slots_3_io_out_uop_ldst_val : _GEN_151 ? _slots_2_io_out_uop_ldst_val : _slots_1_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_153 ? _slots_4_io_out_uop_dst_rtype : _GEN_152 ? _slots_3_io_out_uop_dst_rtype : _GEN_151 ? _slots_2_io_out_uop_dst_rtype : _slots_1_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_153 ? _slots_4_io_out_uop_lrs1_rtype : _GEN_152 ? _slots_3_io_out_uop_lrs1_rtype : _GEN_151 ? _slots_2_io_out_uop_lrs1_rtype : _slots_1_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_153 ? _slots_4_io_out_uop_lrs2_rtype : _GEN_152 ? _slots_3_io_out_uop_lrs2_rtype : _GEN_151 ? _slots_2_io_out_uop_lrs2_rtype : _slots_1_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_153 ? _slots_4_io_out_uop_fp_val : _GEN_152 ? _slots_3_io_out_uop_fp_val : _GEN_151 ? _slots_2_io_out_uop_fp_val : _slots_1_io_out_uop_fp_val),
    .io_valid                       (_slots_0_io_valid),
    .io_will_be_valid               (_slots_0_io_will_be_valid),
    .io_request                     (_slots_0_io_request),
    .io_out_uop_uopc                (/* unused */),
    .io_out_uop_is_rvc              (/* unused */),
    .io_out_uop_fu_code             (/* unused */),
    .io_out_uop_iw_state            (/* unused */),
    .io_out_uop_iw_p1_poisoned      (/* unused */),
    .io_out_uop_iw_p2_poisoned      (/* unused */),
    .io_out_uop_is_br               (/* unused */),
    .io_out_uop_is_jalr             (/* unused */),
    .io_out_uop_is_jal              (/* unused */),
    .io_out_uop_is_sfb              (/* unused */),
    .io_out_uop_br_mask             (/* unused */),
    .io_out_uop_br_tag              (/* unused */),
    .io_out_uop_ftq_idx             (/* unused */),
    .io_out_uop_edge_inst           (/* unused */),
    .io_out_uop_pc_lob              (/* unused */),
    .io_out_uop_taken               (/* unused */),
    .io_out_uop_imm_packed          (/* unused */),
    .io_out_uop_rob_idx             (/* unused */),
    .io_out_uop_ldq_idx             (/* unused */),
    .io_out_uop_stq_idx             (/* unused */),
    .io_out_uop_pdst                (/* unused */),
    .io_out_uop_prs1                (/* unused */),
    .io_out_uop_prs2                (/* unused */),
    .io_out_uop_prs3                (/* unused */),
    .io_out_uop_prs1_busy           (/* unused */),
    .io_out_uop_prs2_busy           (/* unused */),
    .io_out_uop_prs3_busy           (/* unused */),
    .io_out_uop_ppred_busy          (/* unused */),
    .io_out_uop_bypassable          (/* unused */),
    .io_out_uop_mem_cmd             (/* unused */),
    .io_out_uop_mem_size            (/* unused */),
    .io_out_uop_mem_signed          (/* unused */),
    .io_out_uop_is_fence            (/* unused */),
    .io_out_uop_is_amo              (/* unused */),
    .io_out_uop_uses_ldq            (/* unused */),
    .io_out_uop_uses_stq            (/* unused */),
    .io_out_uop_ldst_val            (/* unused */),
    .io_out_uop_dst_rtype           (/* unused */),
    .io_out_uop_lrs1_rtype          (/* unused */),
    .io_out_uop_lrs2_rtype          (/* unused */),
    .io_out_uop_fp_val              (/* unused */),
    .io_uop_uopc                    (_slots_0_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_0_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_0_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_0_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_0_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_0_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_0_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_0_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_0_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_0_io_uop_pdst),
    .io_uop_prs1                    (_slots_0_io_uop_prs1),
    .io_uop_prs2                    (_slots_0_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_0_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_0_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_0_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_0_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_0_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_0_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_0_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_0_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_0_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_0_io_uop_fp_val)
  );
  IssueSlot_32 slots_1 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_1_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (~_slots_0_io_valid),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_1_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_156 ? _slots_5_io_out_uop_uopc : _GEN_155 ? _slots_4_io_out_uop_uopc : _GEN_154 ? _slots_3_io_out_uop_uopc : _slots_2_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_156 ? _slots_5_io_out_uop_is_rvc : _GEN_155 ? _slots_4_io_out_uop_is_rvc : _GEN_154 ? _slots_3_io_out_uop_is_rvc : _slots_2_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_156 ? _slots_5_io_out_uop_fu_code : _GEN_155 ? _slots_4_io_out_uop_fu_code : _GEN_154 ? _slots_3_io_out_uop_fu_code : _slots_2_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_156 ? _slots_5_io_out_uop_iw_state : _GEN_155 ? _slots_4_io_out_uop_iw_state : _GEN_154 ? _slots_3_io_out_uop_iw_state : _slots_2_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_156 ? _slots_5_io_out_uop_iw_p1_poisoned : _GEN_155 ? _slots_4_io_out_uop_iw_p1_poisoned : _GEN_154 ? _slots_3_io_out_uop_iw_p1_poisoned : _slots_2_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_156 ? _slots_5_io_out_uop_iw_p2_poisoned : _GEN_155 ? _slots_4_io_out_uop_iw_p2_poisoned : _GEN_154 ? _slots_3_io_out_uop_iw_p2_poisoned : _slots_2_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_156 ? _slots_5_io_out_uop_is_br : _GEN_155 ? _slots_4_io_out_uop_is_br : _GEN_154 ? _slots_3_io_out_uop_is_br : _slots_2_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_156 ? _slots_5_io_out_uop_is_jalr : _GEN_155 ? _slots_4_io_out_uop_is_jalr : _GEN_154 ? _slots_3_io_out_uop_is_jalr : _slots_2_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_156 ? _slots_5_io_out_uop_is_jal : _GEN_155 ? _slots_4_io_out_uop_is_jal : _GEN_154 ? _slots_3_io_out_uop_is_jal : _slots_2_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_156 ? _slots_5_io_out_uop_is_sfb : _GEN_155 ? _slots_4_io_out_uop_is_sfb : _GEN_154 ? _slots_3_io_out_uop_is_sfb : _slots_2_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_156 ? _slots_5_io_out_uop_br_mask : _GEN_155 ? _slots_4_io_out_uop_br_mask : _GEN_154 ? _slots_3_io_out_uop_br_mask : _slots_2_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_156 ? _slots_5_io_out_uop_br_tag : _GEN_155 ? _slots_4_io_out_uop_br_tag : _GEN_154 ? _slots_3_io_out_uop_br_tag : _slots_2_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_156 ? _slots_5_io_out_uop_ftq_idx : _GEN_155 ? _slots_4_io_out_uop_ftq_idx : _GEN_154 ? _slots_3_io_out_uop_ftq_idx : _slots_2_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_156 ? _slots_5_io_out_uop_edge_inst : _GEN_155 ? _slots_4_io_out_uop_edge_inst : _GEN_154 ? _slots_3_io_out_uop_edge_inst : _slots_2_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_156 ? _slots_5_io_out_uop_pc_lob : _GEN_155 ? _slots_4_io_out_uop_pc_lob : _GEN_154 ? _slots_3_io_out_uop_pc_lob : _slots_2_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_156 ? _slots_5_io_out_uop_taken : _GEN_155 ? _slots_4_io_out_uop_taken : _GEN_154 ? _slots_3_io_out_uop_taken : _slots_2_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_156 ? _slots_5_io_out_uop_imm_packed : _GEN_155 ? _slots_4_io_out_uop_imm_packed : _GEN_154 ? _slots_3_io_out_uop_imm_packed : _slots_2_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_156 ? _slots_5_io_out_uop_rob_idx : _GEN_155 ? _slots_4_io_out_uop_rob_idx : _GEN_154 ? _slots_3_io_out_uop_rob_idx : _slots_2_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_156 ? _slots_5_io_out_uop_ldq_idx : _GEN_155 ? _slots_4_io_out_uop_ldq_idx : _GEN_154 ? _slots_3_io_out_uop_ldq_idx : _slots_2_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_156 ? _slots_5_io_out_uop_stq_idx : _GEN_155 ? _slots_4_io_out_uop_stq_idx : _GEN_154 ? _slots_3_io_out_uop_stq_idx : _slots_2_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_156 ? _slots_5_io_out_uop_pdst : _GEN_155 ? _slots_4_io_out_uop_pdst : _GEN_154 ? _slots_3_io_out_uop_pdst : _slots_2_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_156 ? _slots_5_io_out_uop_prs1 : _GEN_155 ? _slots_4_io_out_uop_prs1 : _GEN_154 ? _slots_3_io_out_uop_prs1 : _slots_2_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_156 ? _slots_5_io_out_uop_prs2 : _GEN_155 ? _slots_4_io_out_uop_prs2 : _GEN_154 ? _slots_3_io_out_uop_prs2 : _slots_2_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_156 ? _slots_5_io_out_uop_prs3 : _GEN_155 ? _slots_4_io_out_uop_prs3 : _GEN_154 ? _slots_3_io_out_uop_prs3 : _slots_2_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_156 ? _slots_5_io_out_uop_prs1_busy : _GEN_155 ? _slots_4_io_out_uop_prs1_busy : _GEN_154 ? _slots_3_io_out_uop_prs1_busy : _slots_2_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_156 ? _slots_5_io_out_uop_prs2_busy : _GEN_155 ? _slots_4_io_out_uop_prs2_busy : _GEN_154 ? _slots_3_io_out_uop_prs2_busy : _slots_2_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_156 ? _slots_5_io_out_uop_prs3_busy : _GEN_155 ? _slots_4_io_out_uop_prs3_busy : _GEN_154 ? _slots_3_io_out_uop_prs3_busy : _slots_2_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_156 ? _slots_5_io_out_uop_ppred_busy : _GEN_155 ? _slots_4_io_out_uop_ppred_busy : _GEN_154 ? _slots_3_io_out_uop_ppred_busy : _slots_2_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_156 ? _slots_5_io_out_uop_bypassable : _GEN_155 ? _slots_4_io_out_uop_bypassable : _GEN_154 ? _slots_3_io_out_uop_bypassable : _slots_2_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_156 ? _slots_5_io_out_uop_mem_cmd : _GEN_155 ? _slots_4_io_out_uop_mem_cmd : _GEN_154 ? _slots_3_io_out_uop_mem_cmd : _slots_2_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_156 ? _slots_5_io_out_uop_mem_size : _GEN_155 ? _slots_4_io_out_uop_mem_size : _GEN_154 ? _slots_3_io_out_uop_mem_size : _slots_2_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_156 ? _slots_5_io_out_uop_mem_signed : _GEN_155 ? _slots_4_io_out_uop_mem_signed : _GEN_154 ? _slots_3_io_out_uop_mem_signed : _slots_2_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_156 ? _slots_5_io_out_uop_is_fence : _GEN_155 ? _slots_4_io_out_uop_is_fence : _GEN_154 ? _slots_3_io_out_uop_is_fence : _slots_2_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_156 ? _slots_5_io_out_uop_is_amo : _GEN_155 ? _slots_4_io_out_uop_is_amo : _GEN_154 ? _slots_3_io_out_uop_is_amo : _slots_2_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_156 ? _slots_5_io_out_uop_uses_ldq : _GEN_155 ? _slots_4_io_out_uop_uses_ldq : _GEN_154 ? _slots_3_io_out_uop_uses_ldq : _slots_2_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_156 ? _slots_5_io_out_uop_uses_stq : _GEN_155 ? _slots_4_io_out_uop_uses_stq : _GEN_154 ? _slots_3_io_out_uop_uses_stq : _slots_2_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_156 ? _slots_5_io_out_uop_ldst_val : _GEN_155 ? _slots_4_io_out_uop_ldst_val : _GEN_154 ? _slots_3_io_out_uop_ldst_val : _slots_2_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_156 ? _slots_5_io_out_uop_dst_rtype : _GEN_155 ? _slots_4_io_out_uop_dst_rtype : _GEN_154 ? _slots_3_io_out_uop_dst_rtype : _slots_2_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_156 ? _slots_5_io_out_uop_lrs1_rtype : _GEN_155 ? _slots_4_io_out_uop_lrs1_rtype : _GEN_154 ? _slots_3_io_out_uop_lrs1_rtype : _slots_2_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_156 ? _slots_5_io_out_uop_lrs2_rtype : _GEN_155 ? _slots_4_io_out_uop_lrs2_rtype : _GEN_154 ? _slots_3_io_out_uop_lrs2_rtype : _slots_2_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_156 ? _slots_5_io_out_uop_fp_val : _GEN_155 ? _slots_4_io_out_uop_fp_val : _GEN_154 ? _slots_3_io_out_uop_fp_val : _slots_2_io_out_uop_fp_val),
    .io_valid                       (_slots_1_io_valid),
    .io_will_be_valid               (_slots_1_io_will_be_valid),
    .io_request                     (_slots_1_io_request),
    .io_out_uop_uopc                (_slots_1_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_1_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_1_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_1_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_1_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_1_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_1_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_1_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_1_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_1_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_1_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_1_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_1_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_1_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_1_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_1_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_1_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_1_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_1_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_1_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_1_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_1_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_1_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_1_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_1_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_1_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_1_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_1_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_1_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_1_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_1_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_1_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_1_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_1_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_1_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_1_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_1_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_1_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_1_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_1_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_1_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_1_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_1_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_1_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_1_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_1_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_1_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_1_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_1_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_1_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_1_io_uop_pdst),
    .io_uop_prs1                    (_slots_1_io_uop_prs1),
    .io_uop_prs2                    (_slots_1_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_1_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_1_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_1_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_1_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_1_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_1_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_1_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_1_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_1_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_1_io_uop_fp_val)
  );
  IssueSlot_32 slots_2 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_2_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_23_1to0),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_2_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_159 ? _slots_6_io_out_uop_uopc : _GEN_158 ? _slots_5_io_out_uop_uopc : _GEN_157 ? _slots_4_io_out_uop_uopc : _slots_3_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_159 ? _slots_6_io_out_uop_is_rvc : _GEN_158 ? _slots_5_io_out_uop_is_rvc : _GEN_157 ? _slots_4_io_out_uop_is_rvc : _slots_3_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_159 ? _slots_6_io_out_uop_fu_code : _GEN_158 ? _slots_5_io_out_uop_fu_code : _GEN_157 ? _slots_4_io_out_uop_fu_code : _slots_3_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_159 ? _slots_6_io_out_uop_iw_state : _GEN_158 ? _slots_5_io_out_uop_iw_state : _GEN_157 ? _slots_4_io_out_uop_iw_state : _slots_3_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_159 ? _slots_6_io_out_uop_iw_p1_poisoned : _GEN_158 ? _slots_5_io_out_uop_iw_p1_poisoned : _GEN_157 ? _slots_4_io_out_uop_iw_p1_poisoned : _slots_3_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_159 ? _slots_6_io_out_uop_iw_p2_poisoned : _GEN_158 ? _slots_5_io_out_uop_iw_p2_poisoned : _GEN_157 ? _slots_4_io_out_uop_iw_p2_poisoned : _slots_3_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_159 ? _slots_6_io_out_uop_is_br : _GEN_158 ? _slots_5_io_out_uop_is_br : _GEN_157 ? _slots_4_io_out_uop_is_br : _slots_3_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_159 ? _slots_6_io_out_uop_is_jalr : _GEN_158 ? _slots_5_io_out_uop_is_jalr : _GEN_157 ? _slots_4_io_out_uop_is_jalr : _slots_3_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_159 ? _slots_6_io_out_uop_is_jal : _GEN_158 ? _slots_5_io_out_uop_is_jal : _GEN_157 ? _slots_4_io_out_uop_is_jal : _slots_3_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_159 ? _slots_6_io_out_uop_is_sfb : _GEN_158 ? _slots_5_io_out_uop_is_sfb : _GEN_157 ? _slots_4_io_out_uop_is_sfb : _slots_3_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_159 ? _slots_6_io_out_uop_br_mask : _GEN_158 ? _slots_5_io_out_uop_br_mask : _GEN_157 ? _slots_4_io_out_uop_br_mask : _slots_3_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_159 ? _slots_6_io_out_uop_br_tag : _GEN_158 ? _slots_5_io_out_uop_br_tag : _GEN_157 ? _slots_4_io_out_uop_br_tag : _slots_3_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_159 ? _slots_6_io_out_uop_ftq_idx : _GEN_158 ? _slots_5_io_out_uop_ftq_idx : _GEN_157 ? _slots_4_io_out_uop_ftq_idx : _slots_3_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_159 ? _slots_6_io_out_uop_edge_inst : _GEN_158 ? _slots_5_io_out_uop_edge_inst : _GEN_157 ? _slots_4_io_out_uop_edge_inst : _slots_3_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_159 ? _slots_6_io_out_uop_pc_lob : _GEN_158 ? _slots_5_io_out_uop_pc_lob : _GEN_157 ? _slots_4_io_out_uop_pc_lob : _slots_3_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_159 ? _slots_6_io_out_uop_taken : _GEN_158 ? _slots_5_io_out_uop_taken : _GEN_157 ? _slots_4_io_out_uop_taken : _slots_3_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_159 ? _slots_6_io_out_uop_imm_packed : _GEN_158 ? _slots_5_io_out_uop_imm_packed : _GEN_157 ? _slots_4_io_out_uop_imm_packed : _slots_3_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_159 ? _slots_6_io_out_uop_rob_idx : _GEN_158 ? _slots_5_io_out_uop_rob_idx : _GEN_157 ? _slots_4_io_out_uop_rob_idx : _slots_3_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_159 ? _slots_6_io_out_uop_ldq_idx : _GEN_158 ? _slots_5_io_out_uop_ldq_idx : _GEN_157 ? _slots_4_io_out_uop_ldq_idx : _slots_3_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_159 ? _slots_6_io_out_uop_stq_idx : _GEN_158 ? _slots_5_io_out_uop_stq_idx : _GEN_157 ? _slots_4_io_out_uop_stq_idx : _slots_3_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_159 ? _slots_6_io_out_uop_pdst : _GEN_158 ? _slots_5_io_out_uop_pdst : _GEN_157 ? _slots_4_io_out_uop_pdst : _slots_3_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_159 ? _slots_6_io_out_uop_prs1 : _GEN_158 ? _slots_5_io_out_uop_prs1 : _GEN_157 ? _slots_4_io_out_uop_prs1 : _slots_3_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_159 ? _slots_6_io_out_uop_prs2 : _GEN_158 ? _slots_5_io_out_uop_prs2 : _GEN_157 ? _slots_4_io_out_uop_prs2 : _slots_3_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_159 ? _slots_6_io_out_uop_prs3 : _GEN_158 ? _slots_5_io_out_uop_prs3 : _GEN_157 ? _slots_4_io_out_uop_prs3 : _slots_3_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_159 ? _slots_6_io_out_uop_prs1_busy : _GEN_158 ? _slots_5_io_out_uop_prs1_busy : _GEN_157 ? _slots_4_io_out_uop_prs1_busy : _slots_3_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_159 ? _slots_6_io_out_uop_prs2_busy : _GEN_158 ? _slots_5_io_out_uop_prs2_busy : _GEN_157 ? _slots_4_io_out_uop_prs2_busy : _slots_3_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_159 ? _slots_6_io_out_uop_prs3_busy : _GEN_158 ? _slots_5_io_out_uop_prs3_busy : _GEN_157 ? _slots_4_io_out_uop_prs3_busy : _slots_3_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_159 ? _slots_6_io_out_uop_ppred_busy : _GEN_158 ? _slots_5_io_out_uop_ppred_busy : _GEN_157 ? _slots_4_io_out_uop_ppred_busy : _slots_3_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_159 ? _slots_6_io_out_uop_bypassable : _GEN_158 ? _slots_5_io_out_uop_bypassable : _GEN_157 ? _slots_4_io_out_uop_bypassable : _slots_3_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_159 ? _slots_6_io_out_uop_mem_cmd : _GEN_158 ? _slots_5_io_out_uop_mem_cmd : _GEN_157 ? _slots_4_io_out_uop_mem_cmd : _slots_3_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_159 ? _slots_6_io_out_uop_mem_size : _GEN_158 ? _slots_5_io_out_uop_mem_size : _GEN_157 ? _slots_4_io_out_uop_mem_size : _slots_3_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_159 ? _slots_6_io_out_uop_mem_signed : _GEN_158 ? _slots_5_io_out_uop_mem_signed : _GEN_157 ? _slots_4_io_out_uop_mem_signed : _slots_3_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_159 ? _slots_6_io_out_uop_is_fence : _GEN_158 ? _slots_5_io_out_uop_is_fence : _GEN_157 ? _slots_4_io_out_uop_is_fence : _slots_3_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_159 ? _slots_6_io_out_uop_is_amo : _GEN_158 ? _slots_5_io_out_uop_is_amo : _GEN_157 ? _slots_4_io_out_uop_is_amo : _slots_3_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_159 ? _slots_6_io_out_uop_uses_ldq : _GEN_158 ? _slots_5_io_out_uop_uses_ldq : _GEN_157 ? _slots_4_io_out_uop_uses_ldq : _slots_3_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_159 ? _slots_6_io_out_uop_uses_stq : _GEN_158 ? _slots_5_io_out_uop_uses_stq : _GEN_157 ? _slots_4_io_out_uop_uses_stq : _slots_3_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_159 ? _slots_6_io_out_uop_ldst_val : _GEN_158 ? _slots_5_io_out_uop_ldst_val : _GEN_157 ? _slots_4_io_out_uop_ldst_val : _slots_3_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_159 ? _slots_6_io_out_uop_dst_rtype : _GEN_158 ? _slots_5_io_out_uop_dst_rtype : _GEN_157 ? _slots_4_io_out_uop_dst_rtype : _slots_3_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_159 ? _slots_6_io_out_uop_lrs1_rtype : _GEN_158 ? _slots_5_io_out_uop_lrs1_rtype : _GEN_157 ? _slots_4_io_out_uop_lrs1_rtype : _slots_3_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_159 ? _slots_6_io_out_uop_lrs2_rtype : _GEN_158 ? _slots_5_io_out_uop_lrs2_rtype : _GEN_157 ? _slots_4_io_out_uop_lrs2_rtype : _slots_3_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_159 ? _slots_6_io_out_uop_fp_val : _GEN_158 ? _slots_5_io_out_uop_fp_val : _GEN_157 ? _slots_4_io_out_uop_fp_val : _slots_3_io_out_uop_fp_val),
    .io_valid                       (_slots_2_io_valid),
    .io_will_be_valid               (_slots_2_io_will_be_valid),
    .io_request                     (_slots_2_io_request),
    .io_out_uop_uopc                (_slots_2_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_2_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_2_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_2_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_2_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_2_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_2_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_2_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_2_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_2_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_2_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_2_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_2_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_2_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_2_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_2_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_2_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_2_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_2_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_2_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_2_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_2_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_2_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_2_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_2_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_2_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_2_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_2_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_2_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_2_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_2_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_2_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_2_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_2_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_2_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_2_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_2_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_2_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_2_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_2_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_2_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_2_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_2_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_2_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_2_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_2_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_2_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_2_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_2_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_2_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_2_io_uop_pdst),
    .io_uop_prs1                    (_slots_2_io_uop_prs1),
    .io_uop_prs2                    (_slots_2_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_2_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_2_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_2_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_2_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_2_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_2_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_2_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_2_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_2_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_2_io_uop_fp_val)
  );
  IssueSlot_32 slots_3 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_3_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_25),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_3_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_162 ? _slots_7_io_out_uop_uopc : _GEN_161 ? _slots_6_io_out_uop_uopc : _GEN_160 ? _slots_5_io_out_uop_uopc : _slots_4_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_162 ? _slots_7_io_out_uop_is_rvc : _GEN_161 ? _slots_6_io_out_uop_is_rvc : _GEN_160 ? _slots_5_io_out_uop_is_rvc : _slots_4_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_162 ? _slots_7_io_out_uop_fu_code : _GEN_161 ? _slots_6_io_out_uop_fu_code : _GEN_160 ? _slots_5_io_out_uop_fu_code : _slots_4_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_162 ? _slots_7_io_out_uop_iw_state : _GEN_161 ? _slots_6_io_out_uop_iw_state : _GEN_160 ? _slots_5_io_out_uop_iw_state : _slots_4_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_162 ? _slots_7_io_out_uop_iw_p1_poisoned : _GEN_161 ? _slots_6_io_out_uop_iw_p1_poisoned : _GEN_160 ? _slots_5_io_out_uop_iw_p1_poisoned : _slots_4_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_162 ? _slots_7_io_out_uop_iw_p2_poisoned : _GEN_161 ? _slots_6_io_out_uop_iw_p2_poisoned : _GEN_160 ? _slots_5_io_out_uop_iw_p2_poisoned : _slots_4_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_162 ? _slots_7_io_out_uop_is_br : _GEN_161 ? _slots_6_io_out_uop_is_br : _GEN_160 ? _slots_5_io_out_uop_is_br : _slots_4_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_162 ? _slots_7_io_out_uop_is_jalr : _GEN_161 ? _slots_6_io_out_uop_is_jalr : _GEN_160 ? _slots_5_io_out_uop_is_jalr : _slots_4_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_162 ? _slots_7_io_out_uop_is_jal : _GEN_161 ? _slots_6_io_out_uop_is_jal : _GEN_160 ? _slots_5_io_out_uop_is_jal : _slots_4_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_162 ? _slots_7_io_out_uop_is_sfb : _GEN_161 ? _slots_6_io_out_uop_is_sfb : _GEN_160 ? _slots_5_io_out_uop_is_sfb : _slots_4_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_162 ? _slots_7_io_out_uop_br_mask : _GEN_161 ? _slots_6_io_out_uop_br_mask : _GEN_160 ? _slots_5_io_out_uop_br_mask : _slots_4_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_162 ? _slots_7_io_out_uop_br_tag : _GEN_161 ? _slots_6_io_out_uop_br_tag : _GEN_160 ? _slots_5_io_out_uop_br_tag : _slots_4_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_162 ? _slots_7_io_out_uop_ftq_idx : _GEN_161 ? _slots_6_io_out_uop_ftq_idx : _GEN_160 ? _slots_5_io_out_uop_ftq_idx : _slots_4_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_162 ? _slots_7_io_out_uop_edge_inst : _GEN_161 ? _slots_6_io_out_uop_edge_inst : _GEN_160 ? _slots_5_io_out_uop_edge_inst : _slots_4_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_162 ? _slots_7_io_out_uop_pc_lob : _GEN_161 ? _slots_6_io_out_uop_pc_lob : _GEN_160 ? _slots_5_io_out_uop_pc_lob : _slots_4_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_162 ? _slots_7_io_out_uop_taken : _GEN_161 ? _slots_6_io_out_uop_taken : _GEN_160 ? _slots_5_io_out_uop_taken : _slots_4_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_162 ? _slots_7_io_out_uop_imm_packed : _GEN_161 ? _slots_6_io_out_uop_imm_packed : _GEN_160 ? _slots_5_io_out_uop_imm_packed : _slots_4_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_162 ? _slots_7_io_out_uop_rob_idx : _GEN_161 ? _slots_6_io_out_uop_rob_idx : _GEN_160 ? _slots_5_io_out_uop_rob_idx : _slots_4_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_162 ? _slots_7_io_out_uop_ldq_idx : _GEN_161 ? _slots_6_io_out_uop_ldq_idx : _GEN_160 ? _slots_5_io_out_uop_ldq_idx : _slots_4_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_162 ? _slots_7_io_out_uop_stq_idx : _GEN_161 ? _slots_6_io_out_uop_stq_idx : _GEN_160 ? _slots_5_io_out_uop_stq_idx : _slots_4_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_162 ? _slots_7_io_out_uop_pdst : _GEN_161 ? _slots_6_io_out_uop_pdst : _GEN_160 ? _slots_5_io_out_uop_pdst : _slots_4_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_162 ? _slots_7_io_out_uop_prs1 : _GEN_161 ? _slots_6_io_out_uop_prs1 : _GEN_160 ? _slots_5_io_out_uop_prs1 : _slots_4_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_162 ? _slots_7_io_out_uop_prs2 : _GEN_161 ? _slots_6_io_out_uop_prs2 : _GEN_160 ? _slots_5_io_out_uop_prs2 : _slots_4_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_162 ? _slots_7_io_out_uop_prs3 : _GEN_161 ? _slots_6_io_out_uop_prs3 : _GEN_160 ? _slots_5_io_out_uop_prs3 : _slots_4_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_162 ? _slots_7_io_out_uop_prs1_busy : _GEN_161 ? _slots_6_io_out_uop_prs1_busy : _GEN_160 ? _slots_5_io_out_uop_prs1_busy : _slots_4_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_162 ? _slots_7_io_out_uop_prs2_busy : _GEN_161 ? _slots_6_io_out_uop_prs2_busy : _GEN_160 ? _slots_5_io_out_uop_prs2_busy : _slots_4_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_162 ? _slots_7_io_out_uop_prs3_busy : _GEN_161 ? _slots_6_io_out_uop_prs3_busy : _GEN_160 ? _slots_5_io_out_uop_prs3_busy : _slots_4_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_162 ? _slots_7_io_out_uop_ppred_busy : _GEN_161 ? _slots_6_io_out_uop_ppred_busy : _GEN_160 ? _slots_5_io_out_uop_ppred_busy : _slots_4_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_162 ? _slots_7_io_out_uop_bypassable : _GEN_161 ? _slots_6_io_out_uop_bypassable : _GEN_160 ? _slots_5_io_out_uop_bypassable : _slots_4_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_162 ? _slots_7_io_out_uop_mem_cmd : _GEN_161 ? _slots_6_io_out_uop_mem_cmd : _GEN_160 ? _slots_5_io_out_uop_mem_cmd : _slots_4_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_162 ? _slots_7_io_out_uop_mem_size : _GEN_161 ? _slots_6_io_out_uop_mem_size : _GEN_160 ? _slots_5_io_out_uop_mem_size : _slots_4_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_162 ? _slots_7_io_out_uop_mem_signed : _GEN_161 ? _slots_6_io_out_uop_mem_signed : _GEN_160 ? _slots_5_io_out_uop_mem_signed : _slots_4_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_162 ? _slots_7_io_out_uop_is_fence : _GEN_161 ? _slots_6_io_out_uop_is_fence : _GEN_160 ? _slots_5_io_out_uop_is_fence : _slots_4_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_162 ? _slots_7_io_out_uop_is_amo : _GEN_161 ? _slots_6_io_out_uop_is_amo : _GEN_160 ? _slots_5_io_out_uop_is_amo : _slots_4_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_162 ? _slots_7_io_out_uop_uses_ldq : _GEN_161 ? _slots_6_io_out_uop_uses_ldq : _GEN_160 ? _slots_5_io_out_uop_uses_ldq : _slots_4_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_162 ? _slots_7_io_out_uop_uses_stq : _GEN_161 ? _slots_6_io_out_uop_uses_stq : _GEN_160 ? _slots_5_io_out_uop_uses_stq : _slots_4_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_162 ? _slots_7_io_out_uop_ldst_val : _GEN_161 ? _slots_6_io_out_uop_ldst_val : _GEN_160 ? _slots_5_io_out_uop_ldst_val : _slots_4_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_162 ? _slots_7_io_out_uop_dst_rtype : _GEN_161 ? _slots_6_io_out_uop_dst_rtype : _GEN_160 ? _slots_5_io_out_uop_dst_rtype : _slots_4_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_162 ? _slots_7_io_out_uop_lrs1_rtype : _GEN_161 ? _slots_6_io_out_uop_lrs1_rtype : _GEN_160 ? _slots_5_io_out_uop_lrs1_rtype : _slots_4_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_162 ? _slots_7_io_out_uop_lrs2_rtype : _GEN_161 ? _slots_6_io_out_uop_lrs2_rtype : _GEN_160 ? _slots_5_io_out_uop_lrs2_rtype : _slots_4_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_162 ? _slots_7_io_out_uop_fp_val : _GEN_161 ? _slots_6_io_out_uop_fp_val : _GEN_160 ? _slots_5_io_out_uop_fp_val : _slots_4_io_out_uop_fp_val),
    .io_valid                       (_slots_3_io_valid),
    .io_will_be_valid               (_slots_3_io_will_be_valid),
    .io_request                     (_slots_3_io_request),
    .io_out_uop_uopc                (_slots_3_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_3_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_3_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_3_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_3_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_3_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_3_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_3_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_3_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_3_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_3_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_3_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_3_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_3_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_3_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_3_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_3_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_3_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_3_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_3_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_3_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_3_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_3_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_3_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_3_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_3_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_3_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_3_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_3_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_3_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_3_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_3_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_3_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_3_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_3_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_3_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_3_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_3_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_3_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_3_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_3_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_3_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_3_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_3_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_3_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_3_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_3_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_3_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_3_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_3_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_3_io_uop_pdst),
    .io_uop_prs1                    (_slots_3_io_uop_prs1),
    .io_uop_prs2                    (_slots_3_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_3_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_3_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_3_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_3_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_3_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_3_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_3_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_3_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_3_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_3_io_uop_fp_val)
  );
  IssueSlot_32 slots_4 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_4_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_27),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_4_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_165 ? _slots_8_io_out_uop_uopc : _GEN_164 ? _slots_7_io_out_uop_uopc : _GEN_163 ? _slots_6_io_out_uop_uopc : _slots_5_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_165 ? _slots_8_io_out_uop_is_rvc : _GEN_164 ? _slots_7_io_out_uop_is_rvc : _GEN_163 ? _slots_6_io_out_uop_is_rvc : _slots_5_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_165 ? _slots_8_io_out_uop_fu_code : _GEN_164 ? _slots_7_io_out_uop_fu_code : _GEN_163 ? _slots_6_io_out_uop_fu_code : _slots_5_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_165 ? _slots_8_io_out_uop_iw_state : _GEN_164 ? _slots_7_io_out_uop_iw_state : _GEN_163 ? _slots_6_io_out_uop_iw_state : _slots_5_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_165 ? _slots_8_io_out_uop_iw_p1_poisoned : _GEN_164 ? _slots_7_io_out_uop_iw_p1_poisoned : _GEN_163 ? _slots_6_io_out_uop_iw_p1_poisoned : _slots_5_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_165 ? _slots_8_io_out_uop_iw_p2_poisoned : _GEN_164 ? _slots_7_io_out_uop_iw_p2_poisoned : _GEN_163 ? _slots_6_io_out_uop_iw_p2_poisoned : _slots_5_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_165 ? _slots_8_io_out_uop_is_br : _GEN_164 ? _slots_7_io_out_uop_is_br : _GEN_163 ? _slots_6_io_out_uop_is_br : _slots_5_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_165 ? _slots_8_io_out_uop_is_jalr : _GEN_164 ? _slots_7_io_out_uop_is_jalr : _GEN_163 ? _slots_6_io_out_uop_is_jalr : _slots_5_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_165 ? _slots_8_io_out_uop_is_jal : _GEN_164 ? _slots_7_io_out_uop_is_jal : _GEN_163 ? _slots_6_io_out_uop_is_jal : _slots_5_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_165 ? _slots_8_io_out_uop_is_sfb : _GEN_164 ? _slots_7_io_out_uop_is_sfb : _GEN_163 ? _slots_6_io_out_uop_is_sfb : _slots_5_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_165 ? _slots_8_io_out_uop_br_mask : _GEN_164 ? _slots_7_io_out_uop_br_mask : _GEN_163 ? _slots_6_io_out_uop_br_mask : _slots_5_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_165 ? _slots_8_io_out_uop_br_tag : _GEN_164 ? _slots_7_io_out_uop_br_tag : _GEN_163 ? _slots_6_io_out_uop_br_tag : _slots_5_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_165 ? _slots_8_io_out_uop_ftq_idx : _GEN_164 ? _slots_7_io_out_uop_ftq_idx : _GEN_163 ? _slots_6_io_out_uop_ftq_idx : _slots_5_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_165 ? _slots_8_io_out_uop_edge_inst : _GEN_164 ? _slots_7_io_out_uop_edge_inst : _GEN_163 ? _slots_6_io_out_uop_edge_inst : _slots_5_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_165 ? _slots_8_io_out_uop_pc_lob : _GEN_164 ? _slots_7_io_out_uop_pc_lob : _GEN_163 ? _slots_6_io_out_uop_pc_lob : _slots_5_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_165 ? _slots_8_io_out_uop_taken : _GEN_164 ? _slots_7_io_out_uop_taken : _GEN_163 ? _slots_6_io_out_uop_taken : _slots_5_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_165 ? _slots_8_io_out_uop_imm_packed : _GEN_164 ? _slots_7_io_out_uop_imm_packed : _GEN_163 ? _slots_6_io_out_uop_imm_packed : _slots_5_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_165 ? _slots_8_io_out_uop_rob_idx : _GEN_164 ? _slots_7_io_out_uop_rob_idx : _GEN_163 ? _slots_6_io_out_uop_rob_idx : _slots_5_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_165 ? _slots_8_io_out_uop_ldq_idx : _GEN_164 ? _slots_7_io_out_uop_ldq_idx : _GEN_163 ? _slots_6_io_out_uop_ldq_idx : _slots_5_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_165 ? _slots_8_io_out_uop_stq_idx : _GEN_164 ? _slots_7_io_out_uop_stq_idx : _GEN_163 ? _slots_6_io_out_uop_stq_idx : _slots_5_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_165 ? _slots_8_io_out_uop_pdst : _GEN_164 ? _slots_7_io_out_uop_pdst : _GEN_163 ? _slots_6_io_out_uop_pdst : _slots_5_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_165 ? _slots_8_io_out_uop_prs1 : _GEN_164 ? _slots_7_io_out_uop_prs1 : _GEN_163 ? _slots_6_io_out_uop_prs1 : _slots_5_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_165 ? _slots_8_io_out_uop_prs2 : _GEN_164 ? _slots_7_io_out_uop_prs2 : _GEN_163 ? _slots_6_io_out_uop_prs2 : _slots_5_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_165 ? _slots_8_io_out_uop_prs3 : _GEN_164 ? _slots_7_io_out_uop_prs3 : _GEN_163 ? _slots_6_io_out_uop_prs3 : _slots_5_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_165 ? _slots_8_io_out_uop_prs1_busy : _GEN_164 ? _slots_7_io_out_uop_prs1_busy : _GEN_163 ? _slots_6_io_out_uop_prs1_busy : _slots_5_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_165 ? _slots_8_io_out_uop_prs2_busy : _GEN_164 ? _slots_7_io_out_uop_prs2_busy : _GEN_163 ? _slots_6_io_out_uop_prs2_busy : _slots_5_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_165 ? _slots_8_io_out_uop_prs3_busy : _GEN_164 ? _slots_7_io_out_uop_prs3_busy : _GEN_163 ? _slots_6_io_out_uop_prs3_busy : _slots_5_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_165 ? _slots_8_io_out_uop_ppred_busy : _GEN_164 ? _slots_7_io_out_uop_ppred_busy : _GEN_163 ? _slots_6_io_out_uop_ppred_busy : _slots_5_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_165 ? _slots_8_io_out_uop_bypassable : _GEN_164 ? _slots_7_io_out_uop_bypassable : _GEN_163 ? _slots_6_io_out_uop_bypassable : _slots_5_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_165 ? _slots_8_io_out_uop_mem_cmd : _GEN_164 ? _slots_7_io_out_uop_mem_cmd : _GEN_163 ? _slots_6_io_out_uop_mem_cmd : _slots_5_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_165 ? _slots_8_io_out_uop_mem_size : _GEN_164 ? _slots_7_io_out_uop_mem_size : _GEN_163 ? _slots_6_io_out_uop_mem_size : _slots_5_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_165 ? _slots_8_io_out_uop_mem_signed : _GEN_164 ? _slots_7_io_out_uop_mem_signed : _GEN_163 ? _slots_6_io_out_uop_mem_signed : _slots_5_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_165 ? _slots_8_io_out_uop_is_fence : _GEN_164 ? _slots_7_io_out_uop_is_fence : _GEN_163 ? _slots_6_io_out_uop_is_fence : _slots_5_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_165 ? _slots_8_io_out_uop_is_amo : _GEN_164 ? _slots_7_io_out_uop_is_amo : _GEN_163 ? _slots_6_io_out_uop_is_amo : _slots_5_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_165 ? _slots_8_io_out_uop_uses_ldq : _GEN_164 ? _slots_7_io_out_uop_uses_ldq : _GEN_163 ? _slots_6_io_out_uop_uses_ldq : _slots_5_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_165 ? _slots_8_io_out_uop_uses_stq : _GEN_164 ? _slots_7_io_out_uop_uses_stq : _GEN_163 ? _slots_6_io_out_uop_uses_stq : _slots_5_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_165 ? _slots_8_io_out_uop_ldst_val : _GEN_164 ? _slots_7_io_out_uop_ldst_val : _GEN_163 ? _slots_6_io_out_uop_ldst_val : _slots_5_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_165 ? _slots_8_io_out_uop_dst_rtype : _GEN_164 ? _slots_7_io_out_uop_dst_rtype : _GEN_163 ? _slots_6_io_out_uop_dst_rtype : _slots_5_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_165 ? _slots_8_io_out_uop_lrs1_rtype : _GEN_164 ? _slots_7_io_out_uop_lrs1_rtype : _GEN_163 ? _slots_6_io_out_uop_lrs1_rtype : _slots_5_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_165 ? _slots_8_io_out_uop_lrs2_rtype : _GEN_164 ? _slots_7_io_out_uop_lrs2_rtype : _GEN_163 ? _slots_6_io_out_uop_lrs2_rtype : _slots_5_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_165 ? _slots_8_io_out_uop_fp_val : _GEN_164 ? _slots_7_io_out_uop_fp_val : _GEN_163 ? _slots_6_io_out_uop_fp_val : _slots_5_io_out_uop_fp_val),
    .io_valid                       (_slots_4_io_valid),
    .io_will_be_valid               (_slots_4_io_will_be_valid),
    .io_request                     (_slots_4_io_request),
    .io_out_uop_uopc                (_slots_4_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_4_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_4_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_4_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_4_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_4_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_4_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_4_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_4_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_4_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_4_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_4_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_4_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_4_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_4_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_4_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_4_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_4_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_4_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_4_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_4_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_4_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_4_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_4_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_4_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_4_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_4_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_4_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_4_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_4_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_4_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_4_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_4_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_4_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_4_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_4_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_4_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_4_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_4_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_4_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_4_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_4_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_4_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_4_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_4_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_4_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_4_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_4_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_4_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_4_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_4_io_uop_pdst),
    .io_uop_prs1                    (_slots_4_io_uop_prs1),
    .io_uop_prs2                    (_slots_4_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_4_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_4_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_4_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_4_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_4_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_4_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_4_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_4_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_4_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_4_io_uop_fp_val)
  );
  IssueSlot_32 slots_5 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_5_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_29),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_5_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_168 ? _slots_9_io_out_uop_uopc : _GEN_167 ? _slots_8_io_out_uop_uopc : _GEN_166 ? _slots_7_io_out_uop_uopc : _slots_6_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_168 ? _slots_9_io_out_uop_is_rvc : _GEN_167 ? _slots_8_io_out_uop_is_rvc : _GEN_166 ? _slots_7_io_out_uop_is_rvc : _slots_6_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_168 ? _slots_9_io_out_uop_fu_code : _GEN_167 ? _slots_8_io_out_uop_fu_code : _GEN_166 ? _slots_7_io_out_uop_fu_code : _slots_6_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_168 ? _slots_9_io_out_uop_iw_state : _GEN_167 ? _slots_8_io_out_uop_iw_state : _GEN_166 ? _slots_7_io_out_uop_iw_state : _slots_6_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_168 ? _slots_9_io_out_uop_iw_p1_poisoned : _GEN_167 ? _slots_8_io_out_uop_iw_p1_poisoned : _GEN_166 ? _slots_7_io_out_uop_iw_p1_poisoned : _slots_6_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_168 ? _slots_9_io_out_uop_iw_p2_poisoned : _GEN_167 ? _slots_8_io_out_uop_iw_p2_poisoned : _GEN_166 ? _slots_7_io_out_uop_iw_p2_poisoned : _slots_6_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_168 ? _slots_9_io_out_uop_is_br : _GEN_167 ? _slots_8_io_out_uop_is_br : _GEN_166 ? _slots_7_io_out_uop_is_br : _slots_6_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_168 ? _slots_9_io_out_uop_is_jalr : _GEN_167 ? _slots_8_io_out_uop_is_jalr : _GEN_166 ? _slots_7_io_out_uop_is_jalr : _slots_6_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_168 ? _slots_9_io_out_uop_is_jal : _GEN_167 ? _slots_8_io_out_uop_is_jal : _GEN_166 ? _slots_7_io_out_uop_is_jal : _slots_6_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_168 ? _slots_9_io_out_uop_is_sfb : _GEN_167 ? _slots_8_io_out_uop_is_sfb : _GEN_166 ? _slots_7_io_out_uop_is_sfb : _slots_6_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_168 ? _slots_9_io_out_uop_br_mask : _GEN_167 ? _slots_8_io_out_uop_br_mask : _GEN_166 ? _slots_7_io_out_uop_br_mask : _slots_6_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_168 ? _slots_9_io_out_uop_br_tag : _GEN_167 ? _slots_8_io_out_uop_br_tag : _GEN_166 ? _slots_7_io_out_uop_br_tag : _slots_6_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_168 ? _slots_9_io_out_uop_ftq_idx : _GEN_167 ? _slots_8_io_out_uop_ftq_idx : _GEN_166 ? _slots_7_io_out_uop_ftq_idx : _slots_6_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_168 ? _slots_9_io_out_uop_edge_inst : _GEN_167 ? _slots_8_io_out_uop_edge_inst : _GEN_166 ? _slots_7_io_out_uop_edge_inst : _slots_6_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_168 ? _slots_9_io_out_uop_pc_lob : _GEN_167 ? _slots_8_io_out_uop_pc_lob : _GEN_166 ? _slots_7_io_out_uop_pc_lob : _slots_6_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_168 ? _slots_9_io_out_uop_taken : _GEN_167 ? _slots_8_io_out_uop_taken : _GEN_166 ? _slots_7_io_out_uop_taken : _slots_6_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_168 ? _slots_9_io_out_uop_imm_packed : _GEN_167 ? _slots_8_io_out_uop_imm_packed : _GEN_166 ? _slots_7_io_out_uop_imm_packed : _slots_6_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_168 ? _slots_9_io_out_uop_rob_idx : _GEN_167 ? _slots_8_io_out_uop_rob_idx : _GEN_166 ? _slots_7_io_out_uop_rob_idx : _slots_6_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_168 ? _slots_9_io_out_uop_ldq_idx : _GEN_167 ? _slots_8_io_out_uop_ldq_idx : _GEN_166 ? _slots_7_io_out_uop_ldq_idx : _slots_6_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_168 ? _slots_9_io_out_uop_stq_idx : _GEN_167 ? _slots_8_io_out_uop_stq_idx : _GEN_166 ? _slots_7_io_out_uop_stq_idx : _slots_6_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_168 ? _slots_9_io_out_uop_pdst : _GEN_167 ? _slots_8_io_out_uop_pdst : _GEN_166 ? _slots_7_io_out_uop_pdst : _slots_6_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_168 ? _slots_9_io_out_uop_prs1 : _GEN_167 ? _slots_8_io_out_uop_prs1 : _GEN_166 ? _slots_7_io_out_uop_prs1 : _slots_6_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_168 ? _slots_9_io_out_uop_prs2 : _GEN_167 ? _slots_8_io_out_uop_prs2 : _GEN_166 ? _slots_7_io_out_uop_prs2 : _slots_6_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_168 ? _slots_9_io_out_uop_prs3 : _GEN_167 ? _slots_8_io_out_uop_prs3 : _GEN_166 ? _slots_7_io_out_uop_prs3 : _slots_6_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_168 ? _slots_9_io_out_uop_prs1_busy : _GEN_167 ? _slots_8_io_out_uop_prs1_busy : _GEN_166 ? _slots_7_io_out_uop_prs1_busy : _slots_6_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_168 ? _slots_9_io_out_uop_prs2_busy : _GEN_167 ? _slots_8_io_out_uop_prs2_busy : _GEN_166 ? _slots_7_io_out_uop_prs2_busy : _slots_6_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_168 ? _slots_9_io_out_uop_prs3_busy : _GEN_167 ? _slots_8_io_out_uop_prs3_busy : _GEN_166 ? _slots_7_io_out_uop_prs3_busy : _slots_6_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_168 ? _slots_9_io_out_uop_ppred_busy : _GEN_167 ? _slots_8_io_out_uop_ppred_busy : _GEN_166 ? _slots_7_io_out_uop_ppred_busy : _slots_6_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_168 ? _slots_9_io_out_uop_bypassable : _GEN_167 ? _slots_8_io_out_uop_bypassable : _GEN_166 ? _slots_7_io_out_uop_bypassable : _slots_6_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_168 ? _slots_9_io_out_uop_mem_cmd : _GEN_167 ? _slots_8_io_out_uop_mem_cmd : _GEN_166 ? _slots_7_io_out_uop_mem_cmd : _slots_6_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_168 ? _slots_9_io_out_uop_mem_size : _GEN_167 ? _slots_8_io_out_uop_mem_size : _GEN_166 ? _slots_7_io_out_uop_mem_size : _slots_6_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_168 ? _slots_9_io_out_uop_mem_signed : _GEN_167 ? _slots_8_io_out_uop_mem_signed : _GEN_166 ? _slots_7_io_out_uop_mem_signed : _slots_6_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_168 ? _slots_9_io_out_uop_is_fence : _GEN_167 ? _slots_8_io_out_uop_is_fence : _GEN_166 ? _slots_7_io_out_uop_is_fence : _slots_6_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_168 ? _slots_9_io_out_uop_is_amo : _GEN_167 ? _slots_8_io_out_uop_is_amo : _GEN_166 ? _slots_7_io_out_uop_is_amo : _slots_6_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_168 ? _slots_9_io_out_uop_uses_ldq : _GEN_167 ? _slots_8_io_out_uop_uses_ldq : _GEN_166 ? _slots_7_io_out_uop_uses_ldq : _slots_6_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_168 ? _slots_9_io_out_uop_uses_stq : _GEN_167 ? _slots_8_io_out_uop_uses_stq : _GEN_166 ? _slots_7_io_out_uop_uses_stq : _slots_6_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_168 ? _slots_9_io_out_uop_ldst_val : _GEN_167 ? _slots_8_io_out_uop_ldst_val : _GEN_166 ? _slots_7_io_out_uop_ldst_val : _slots_6_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_168 ? _slots_9_io_out_uop_dst_rtype : _GEN_167 ? _slots_8_io_out_uop_dst_rtype : _GEN_166 ? _slots_7_io_out_uop_dst_rtype : _slots_6_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_168 ? _slots_9_io_out_uop_lrs1_rtype : _GEN_167 ? _slots_8_io_out_uop_lrs1_rtype : _GEN_166 ? _slots_7_io_out_uop_lrs1_rtype : _slots_6_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_168 ? _slots_9_io_out_uop_lrs2_rtype : _GEN_167 ? _slots_8_io_out_uop_lrs2_rtype : _GEN_166 ? _slots_7_io_out_uop_lrs2_rtype : _slots_6_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_168 ? _slots_9_io_out_uop_fp_val : _GEN_167 ? _slots_8_io_out_uop_fp_val : _GEN_166 ? _slots_7_io_out_uop_fp_val : _slots_6_io_out_uop_fp_val),
    .io_valid                       (_slots_5_io_valid),
    .io_will_be_valid               (_slots_5_io_will_be_valid),
    .io_request                     (_slots_5_io_request),
    .io_out_uop_uopc                (_slots_5_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_5_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_5_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_5_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_5_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_5_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_5_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_5_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_5_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_5_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_5_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_5_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_5_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_5_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_5_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_5_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_5_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_5_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_5_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_5_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_5_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_5_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_5_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_5_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_5_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_5_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_5_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_5_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_5_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_5_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_5_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_5_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_5_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_5_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_5_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_5_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_5_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_5_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_5_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_5_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_5_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_5_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_5_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_5_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_5_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_5_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_5_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_5_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_5_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_5_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_5_io_uop_pdst),
    .io_uop_prs1                    (_slots_5_io_uop_prs1),
    .io_uop_prs2                    (_slots_5_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_5_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_5_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_5_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_5_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_5_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_5_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_5_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_5_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_5_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_5_io_uop_fp_val)
  );
  IssueSlot_32 slots_6 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_6_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_31),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_6_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_171 ? _slots_10_io_out_uop_uopc : _GEN_170 ? _slots_9_io_out_uop_uopc : _GEN_169 ? _slots_8_io_out_uop_uopc : _slots_7_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_171 ? _slots_10_io_out_uop_is_rvc : _GEN_170 ? _slots_9_io_out_uop_is_rvc : _GEN_169 ? _slots_8_io_out_uop_is_rvc : _slots_7_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_171 ? _slots_10_io_out_uop_fu_code : _GEN_170 ? _slots_9_io_out_uop_fu_code : _GEN_169 ? _slots_8_io_out_uop_fu_code : _slots_7_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_171 ? _slots_10_io_out_uop_iw_state : _GEN_170 ? _slots_9_io_out_uop_iw_state : _GEN_169 ? _slots_8_io_out_uop_iw_state : _slots_7_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_171 ? _slots_10_io_out_uop_iw_p1_poisoned : _GEN_170 ? _slots_9_io_out_uop_iw_p1_poisoned : _GEN_169 ? _slots_8_io_out_uop_iw_p1_poisoned : _slots_7_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_171 ? _slots_10_io_out_uop_iw_p2_poisoned : _GEN_170 ? _slots_9_io_out_uop_iw_p2_poisoned : _GEN_169 ? _slots_8_io_out_uop_iw_p2_poisoned : _slots_7_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_171 ? _slots_10_io_out_uop_is_br : _GEN_170 ? _slots_9_io_out_uop_is_br : _GEN_169 ? _slots_8_io_out_uop_is_br : _slots_7_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_171 ? _slots_10_io_out_uop_is_jalr : _GEN_170 ? _slots_9_io_out_uop_is_jalr : _GEN_169 ? _slots_8_io_out_uop_is_jalr : _slots_7_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_171 ? _slots_10_io_out_uop_is_jal : _GEN_170 ? _slots_9_io_out_uop_is_jal : _GEN_169 ? _slots_8_io_out_uop_is_jal : _slots_7_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_171 ? _slots_10_io_out_uop_is_sfb : _GEN_170 ? _slots_9_io_out_uop_is_sfb : _GEN_169 ? _slots_8_io_out_uop_is_sfb : _slots_7_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_171 ? _slots_10_io_out_uop_br_mask : _GEN_170 ? _slots_9_io_out_uop_br_mask : _GEN_169 ? _slots_8_io_out_uop_br_mask : _slots_7_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_171 ? _slots_10_io_out_uop_br_tag : _GEN_170 ? _slots_9_io_out_uop_br_tag : _GEN_169 ? _slots_8_io_out_uop_br_tag : _slots_7_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_171 ? _slots_10_io_out_uop_ftq_idx : _GEN_170 ? _slots_9_io_out_uop_ftq_idx : _GEN_169 ? _slots_8_io_out_uop_ftq_idx : _slots_7_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_171 ? _slots_10_io_out_uop_edge_inst : _GEN_170 ? _slots_9_io_out_uop_edge_inst : _GEN_169 ? _slots_8_io_out_uop_edge_inst : _slots_7_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_171 ? _slots_10_io_out_uop_pc_lob : _GEN_170 ? _slots_9_io_out_uop_pc_lob : _GEN_169 ? _slots_8_io_out_uop_pc_lob : _slots_7_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_171 ? _slots_10_io_out_uop_taken : _GEN_170 ? _slots_9_io_out_uop_taken : _GEN_169 ? _slots_8_io_out_uop_taken : _slots_7_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_171 ? _slots_10_io_out_uop_imm_packed : _GEN_170 ? _slots_9_io_out_uop_imm_packed : _GEN_169 ? _slots_8_io_out_uop_imm_packed : _slots_7_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_171 ? _slots_10_io_out_uop_rob_idx : _GEN_170 ? _slots_9_io_out_uop_rob_idx : _GEN_169 ? _slots_8_io_out_uop_rob_idx : _slots_7_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_171 ? _slots_10_io_out_uop_ldq_idx : _GEN_170 ? _slots_9_io_out_uop_ldq_idx : _GEN_169 ? _slots_8_io_out_uop_ldq_idx : _slots_7_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_171 ? _slots_10_io_out_uop_stq_idx : _GEN_170 ? _slots_9_io_out_uop_stq_idx : _GEN_169 ? _slots_8_io_out_uop_stq_idx : _slots_7_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_171 ? _slots_10_io_out_uop_pdst : _GEN_170 ? _slots_9_io_out_uop_pdst : _GEN_169 ? _slots_8_io_out_uop_pdst : _slots_7_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_171 ? _slots_10_io_out_uop_prs1 : _GEN_170 ? _slots_9_io_out_uop_prs1 : _GEN_169 ? _slots_8_io_out_uop_prs1 : _slots_7_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_171 ? _slots_10_io_out_uop_prs2 : _GEN_170 ? _slots_9_io_out_uop_prs2 : _GEN_169 ? _slots_8_io_out_uop_prs2 : _slots_7_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_171 ? _slots_10_io_out_uop_prs3 : _GEN_170 ? _slots_9_io_out_uop_prs3 : _GEN_169 ? _slots_8_io_out_uop_prs3 : _slots_7_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_171 ? _slots_10_io_out_uop_prs1_busy : _GEN_170 ? _slots_9_io_out_uop_prs1_busy : _GEN_169 ? _slots_8_io_out_uop_prs1_busy : _slots_7_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_171 ? _slots_10_io_out_uop_prs2_busy : _GEN_170 ? _slots_9_io_out_uop_prs2_busy : _GEN_169 ? _slots_8_io_out_uop_prs2_busy : _slots_7_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_171 ? _slots_10_io_out_uop_prs3_busy : _GEN_170 ? _slots_9_io_out_uop_prs3_busy : _GEN_169 ? _slots_8_io_out_uop_prs3_busy : _slots_7_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_171 ? _slots_10_io_out_uop_ppred_busy : _GEN_170 ? _slots_9_io_out_uop_ppred_busy : _GEN_169 ? _slots_8_io_out_uop_ppred_busy : _slots_7_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_171 ? _slots_10_io_out_uop_bypassable : _GEN_170 ? _slots_9_io_out_uop_bypassable : _GEN_169 ? _slots_8_io_out_uop_bypassable : _slots_7_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_171 ? _slots_10_io_out_uop_mem_cmd : _GEN_170 ? _slots_9_io_out_uop_mem_cmd : _GEN_169 ? _slots_8_io_out_uop_mem_cmd : _slots_7_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_171 ? _slots_10_io_out_uop_mem_size : _GEN_170 ? _slots_9_io_out_uop_mem_size : _GEN_169 ? _slots_8_io_out_uop_mem_size : _slots_7_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_171 ? _slots_10_io_out_uop_mem_signed : _GEN_170 ? _slots_9_io_out_uop_mem_signed : _GEN_169 ? _slots_8_io_out_uop_mem_signed : _slots_7_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_171 ? _slots_10_io_out_uop_is_fence : _GEN_170 ? _slots_9_io_out_uop_is_fence : _GEN_169 ? _slots_8_io_out_uop_is_fence : _slots_7_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_171 ? _slots_10_io_out_uop_is_amo : _GEN_170 ? _slots_9_io_out_uop_is_amo : _GEN_169 ? _slots_8_io_out_uop_is_amo : _slots_7_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_171 ? _slots_10_io_out_uop_uses_ldq : _GEN_170 ? _slots_9_io_out_uop_uses_ldq : _GEN_169 ? _slots_8_io_out_uop_uses_ldq : _slots_7_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_171 ? _slots_10_io_out_uop_uses_stq : _GEN_170 ? _slots_9_io_out_uop_uses_stq : _GEN_169 ? _slots_8_io_out_uop_uses_stq : _slots_7_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_171 ? _slots_10_io_out_uop_ldst_val : _GEN_170 ? _slots_9_io_out_uop_ldst_val : _GEN_169 ? _slots_8_io_out_uop_ldst_val : _slots_7_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_171 ? _slots_10_io_out_uop_dst_rtype : _GEN_170 ? _slots_9_io_out_uop_dst_rtype : _GEN_169 ? _slots_8_io_out_uop_dst_rtype : _slots_7_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_171 ? _slots_10_io_out_uop_lrs1_rtype : _GEN_170 ? _slots_9_io_out_uop_lrs1_rtype : _GEN_169 ? _slots_8_io_out_uop_lrs1_rtype : _slots_7_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_171 ? _slots_10_io_out_uop_lrs2_rtype : _GEN_170 ? _slots_9_io_out_uop_lrs2_rtype : _GEN_169 ? _slots_8_io_out_uop_lrs2_rtype : _slots_7_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_171 ? _slots_10_io_out_uop_fp_val : _GEN_170 ? _slots_9_io_out_uop_fp_val : _GEN_169 ? _slots_8_io_out_uop_fp_val : _slots_7_io_out_uop_fp_val),
    .io_valid                       (_slots_6_io_valid),
    .io_will_be_valid               (_slots_6_io_will_be_valid),
    .io_request                     (_slots_6_io_request),
    .io_out_uop_uopc                (_slots_6_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_6_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_6_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_6_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_6_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_6_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_6_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_6_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_6_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_6_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_6_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_6_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_6_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_6_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_6_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_6_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_6_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_6_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_6_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_6_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_6_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_6_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_6_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_6_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_6_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_6_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_6_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_6_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_6_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_6_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_6_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_6_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_6_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_6_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_6_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_6_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_6_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_6_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_6_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_6_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_6_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_6_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_6_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_6_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_6_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_6_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_6_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_6_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_6_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_6_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_6_io_uop_pdst),
    .io_uop_prs1                    (_slots_6_io_uop_prs1),
    .io_uop_prs2                    (_slots_6_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_6_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_6_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_6_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_6_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_6_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_6_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_6_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_6_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_6_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_6_io_uop_fp_val)
  );
  IssueSlot_32 slots_7 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_7_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_33),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_7_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_174 ? _slots_11_io_out_uop_uopc : _GEN_173 ? _slots_10_io_out_uop_uopc : _GEN_172 ? _slots_9_io_out_uop_uopc : _slots_8_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_174 ? _slots_11_io_out_uop_is_rvc : _GEN_173 ? _slots_10_io_out_uop_is_rvc : _GEN_172 ? _slots_9_io_out_uop_is_rvc : _slots_8_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_174 ? _slots_11_io_out_uop_fu_code : _GEN_173 ? _slots_10_io_out_uop_fu_code : _GEN_172 ? _slots_9_io_out_uop_fu_code : _slots_8_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_174 ? _slots_11_io_out_uop_iw_state : _GEN_173 ? _slots_10_io_out_uop_iw_state : _GEN_172 ? _slots_9_io_out_uop_iw_state : _slots_8_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_174 ? _slots_11_io_out_uop_iw_p1_poisoned : _GEN_173 ? _slots_10_io_out_uop_iw_p1_poisoned : _GEN_172 ? _slots_9_io_out_uop_iw_p1_poisoned : _slots_8_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_174 ? _slots_11_io_out_uop_iw_p2_poisoned : _GEN_173 ? _slots_10_io_out_uop_iw_p2_poisoned : _GEN_172 ? _slots_9_io_out_uop_iw_p2_poisoned : _slots_8_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_174 ? _slots_11_io_out_uop_is_br : _GEN_173 ? _slots_10_io_out_uop_is_br : _GEN_172 ? _slots_9_io_out_uop_is_br : _slots_8_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_174 ? _slots_11_io_out_uop_is_jalr : _GEN_173 ? _slots_10_io_out_uop_is_jalr : _GEN_172 ? _slots_9_io_out_uop_is_jalr : _slots_8_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_174 ? _slots_11_io_out_uop_is_jal : _GEN_173 ? _slots_10_io_out_uop_is_jal : _GEN_172 ? _slots_9_io_out_uop_is_jal : _slots_8_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_174 ? _slots_11_io_out_uop_is_sfb : _GEN_173 ? _slots_10_io_out_uop_is_sfb : _GEN_172 ? _slots_9_io_out_uop_is_sfb : _slots_8_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_174 ? _slots_11_io_out_uop_br_mask : _GEN_173 ? _slots_10_io_out_uop_br_mask : _GEN_172 ? _slots_9_io_out_uop_br_mask : _slots_8_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_174 ? _slots_11_io_out_uop_br_tag : _GEN_173 ? _slots_10_io_out_uop_br_tag : _GEN_172 ? _slots_9_io_out_uop_br_tag : _slots_8_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_174 ? _slots_11_io_out_uop_ftq_idx : _GEN_173 ? _slots_10_io_out_uop_ftq_idx : _GEN_172 ? _slots_9_io_out_uop_ftq_idx : _slots_8_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_174 ? _slots_11_io_out_uop_edge_inst : _GEN_173 ? _slots_10_io_out_uop_edge_inst : _GEN_172 ? _slots_9_io_out_uop_edge_inst : _slots_8_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_174 ? _slots_11_io_out_uop_pc_lob : _GEN_173 ? _slots_10_io_out_uop_pc_lob : _GEN_172 ? _slots_9_io_out_uop_pc_lob : _slots_8_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_174 ? _slots_11_io_out_uop_taken : _GEN_173 ? _slots_10_io_out_uop_taken : _GEN_172 ? _slots_9_io_out_uop_taken : _slots_8_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_174 ? _slots_11_io_out_uop_imm_packed : _GEN_173 ? _slots_10_io_out_uop_imm_packed : _GEN_172 ? _slots_9_io_out_uop_imm_packed : _slots_8_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_174 ? _slots_11_io_out_uop_rob_idx : _GEN_173 ? _slots_10_io_out_uop_rob_idx : _GEN_172 ? _slots_9_io_out_uop_rob_idx : _slots_8_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_174 ? _slots_11_io_out_uop_ldq_idx : _GEN_173 ? _slots_10_io_out_uop_ldq_idx : _GEN_172 ? _slots_9_io_out_uop_ldq_idx : _slots_8_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_174 ? _slots_11_io_out_uop_stq_idx : _GEN_173 ? _slots_10_io_out_uop_stq_idx : _GEN_172 ? _slots_9_io_out_uop_stq_idx : _slots_8_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_174 ? _slots_11_io_out_uop_pdst : _GEN_173 ? _slots_10_io_out_uop_pdst : _GEN_172 ? _slots_9_io_out_uop_pdst : _slots_8_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_174 ? _slots_11_io_out_uop_prs1 : _GEN_173 ? _slots_10_io_out_uop_prs1 : _GEN_172 ? _slots_9_io_out_uop_prs1 : _slots_8_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_174 ? _slots_11_io_out_uop_prs2 : _GEN_173 ? _slots_10_io_out_uop_prs2 : _GEN_172 ? _slots_9_io_out_uop_prs2 : _slots_8_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_174 ? _slots_11_io_out_uop_prs3 : _GEN_173 ? _slots_10_io_out_uop_prs3 : _GEN_172 ? _slots_9_io_out_uop_prs3 : _slots_8_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_174 ? _slots_11_io_out_uop_prs1_busy : _GEN_173 ? _slots_10_io_out_uop_prs1_busy : _GEN_172 ? _slots_9_io_out_uop_prs1_busy : _slots_8_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_174 ? _slots_11_io_out_uop_prs2_busy : _GEN_173 ? _slots_10_io_out_uop_prs2_busy : _GEN_172 ? _slots_9_io_out_uop_prs2_busy : _slots_8_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_174 ? _slots_11_io_out_uop_prs3_busy : _GEN_173 ? _slots_10_io_out_uop_prs3_busy : _GEN_172 ? _slots_9_io_out_uop_prs3_busy : _slots_8_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_174 ? _slots_11_io_out_uop_ppred_busy : _GEN_173 ? _slots_10_io_out_uop_ppred_busy : _GEN_172 ? _slots_9_io_out_uop_ppred_busy : _slots_8_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_174 ? _slots_11_io_out_uop_bypassable : _GEN_173 ? _slots_10_io_out_uop_bypassable : _GEN_172 ? _slots_9_io_out_uop_bypassable : _slots_8_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_174 ? _slots_11_io_out_uop_mem_cmd : _GEN_173 ? _slots_10_io_out_uop_mem_cmd : _GEN_172 ? _slots_9_io_out_uop_mem_cmd : _slots_8_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_174 ? _slots_11_io_out_uop_mem_size : _GEN_173 ? _slots_10_io_out_uop_mem_size : _GEN_172 ? _slots_9_io_out_uop_mem_size : _slots_8_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_174 ? _slots_11_io_out_uop_mem_signed : _GEN_173 ? _slots_10_io_out_uop_mem_signed : _GEN_172 ? _slots_9_io_out_uop_mem_signed : _slots_8_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_174 ? _slots_11_io_out_uop_is_fence : _GEN_173 ? _slots_10_io_out_uop_is_fence : _GEN_172 ? _slots_9_io_out_uop_is_fence : _slots_8_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_174 ? _slots_11_io_out_uop_is_amo : _GEN_173 ? _slots_10_io_out_uop_is_amo : _GEN_172 ? _slots_9_io_out_uop_is_amo : _slots_8_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_174 ? _slots_11_io_out_uop_uses_ldq : _GEN_173 ? _slots_10_io_out_uop_uses_ldq : _GEN_172 ? _slots_9_io_out_uop_uses_ldq : _slots_8_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_174 ? _slots_11_io_out_uop_uses_stq : _GEN_173 ? _slots_10_io_out_uop_uses_stq : _GEN_172 ? _slots_9_io_out_uop_uses_stq : _slots_8_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_174 ? _slots_11_io_out_uop_ldst_val : _GEN_173 ? _slots_10_io_out_uop_ldst_val : _GEN_172 ? _slots_9_io_out_uop_ldst_val : _slots_8_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_174 ? _slots_11_io_out_uop_dst_rtype : _GEN_173 ? _slots_10_io_out_uop_dst_rtype : _GEN_172 ? _slots_9_io_out_uop_dst_rtype : _slots_8_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_174 ? _slots_11_io_out_uop_lrs1_rtype : _GEN_173 ? _slots_10_io_out_uop_lrs1_rtype : _GEN_172 ? _slots_9_io_out_uop_lrs1_rtype : _slots_8_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_174 ? _slots_11_io_out_uop_lrs2_rtype : _GEN_173 ? _slots_10_io_out_uop_lrs2_rtype : _GEN_172 ? _slots_9_io_out_uop_lrs2_rtype : _slots_8_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_174 ? _slots_11_io_out_uop_fp_val : _GEN_173 ? _slots_10_io_out_uop_fp_val : _GEN_172 ? _slots_9_io_out_uop_fp_val : _slots_8_io_out_uop_fp_val),
    .io_valid                       (_slots_7_io_valid),
    .io_will_be_valid               (_slots_7_io_will_be_valid),
    .io_request                     (_slots_7_io_request),
    .io_out_uop_uopc                (_slots_7_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_7_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_7_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_7_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_7_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_7_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_7_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_7_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_7_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_7_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_7_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_7_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_7_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_7_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_7_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_7_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_7_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_7_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_7_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_7_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_7_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_7_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_7_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_7_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_7_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_7_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_7_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_7_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_7_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_7_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_7_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_7_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_7_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_7_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_7_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_7_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_7_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_7_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_7_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_7_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_7_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_7_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_7_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_7_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_7_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_7_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_7_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_7_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_7_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_7_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_7_io_uop_pdst),
    .io_uop_prs1                    (_slots_7_io_uop_prs1),
    .io_uop_prs2                    (_slots_7_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_7_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_7_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_7_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_7_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_7_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_7_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_7_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_7_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_7_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_7_io_uop_fp_val)
  );
  IssueSlot_32 slots_8 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_8_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_35),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_8_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_177 ? _slots_12_io_out_uop_uopc : _GEN_176 ? _slots_11_io_out_uop_uopc : _GEN_175 ? _slots_10_io_out_uop_uopc : _slots_9_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_177 ? _slots_12_io_out_uop_is_rvc : _GEN_176 ? _slots_11_io_out_uop_is_rvc : _GEN_175 ? _slots_10_io_out_uop_is_rvc : _slots_9_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_177 ? _slots_12_io_out_uop_fu_code : _GEN_176 ? _slots_11_io_out_uop_fu_code : _GEN_175 ? _slots_10_io_out_uop_fu_code : _slots_9_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_177 ? _slots_12_io_out_uop_iw_state : _GEN_176 ? _slots_11_io_out_uop_iw_state : _GEN_175 ? _slots_10_io_out_uop_iw_state : _slots_9_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_177 ? _slots_12_io_out_uop_iw_p1_poisoned : _GEN_176 ? _slots_11_io_out_uop_iw_p1_poisoned : _GEN_175 ? _slots_10_io_out_uop_iw_p1_poisoned : _slots_9_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_177 ? _slots_12_io_out_uop_iw_p2_poisoned : _GEN_176 ? _slots_11_io_out_uop_iw_p2_poisoned : _GEN_175 ? _slots_10_io_out_uop_iw_p2_poisoned : _slots_9_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_177 ? _slots_12_io_out_uop_is_br : _GEN_176 ? _slots_11_io_out_uop_is_br : _GEN_175 ? _slots_10_io_out_uop_is_br : _slots_9_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_177 ? _slots_12_io_out_uop_is_jalr : _GEN_176 ? _slots_11_io_out_uop_is_jalr : _GEN_175 ? _slots_10_io_out_uop_is_jalr : _slots_9_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_177 ? _slots_12_io_out_uop_is_jal : _GEN_176 ? _slots_11_io_out_uop_is_jal : _GEN_175 ? _slots_10_io_out_uop_is_jal : _slots_9_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_177 ? _slots_12_io_out_uop_is_sfb : _GEN_176 ? _slots_11_io_out_uop_is_sfb : _GEN_175 ? _slots_10_io_out_uop_is_sfb : _slots_9_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_177 ? _slots_12_io_out_uop_br_mask : _GEN_176 ? _slots_11_io_out_uop_br_mask : _GEN_175 ? _slots_10_io_out_uop_br_mask : _slots_9_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_177 ? _slots_12_io_out_uop_br_tag : _GEN_176 ? _slots_11_io_out_uop_br_tag : _GEN_175 ? _slots_10_io_out_uop_br_tag : _slots_9_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_177 ? _slots_12_io_out_uop_ftq_idx : _GEN_176 ? _slots_11_io_out_uop_ftq_idx : _GEN_175 ? _slots_10_io_out_uop_ftq_idx : _slots_9_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_177 ? _slots_12_io_out_uop_edge_inst : _GEN_176 ? _slots_11_io_out_uop_edge_inst : _GEN_175 ? _slots_10_io_out_uop_edge_inst : _slots_9_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_177 ? _slots_12_io_out_uop_pc_lob : _GEN_176 ? _slots_11_io_out_uop_pc_lob : _GEN_175 ? _slots_10_io_out_uop_pc_lob : _slots_9_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_177 ? _slots_12_io_out_uop_taken : _GEN_176 ? _slots_11_io_out_uop_taken : _GEN_175 ? _slots_10_io_out_uop_taken : _slots_9_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_177 ? _slots_12_io_out_uop_imm_packed : _GEN_176 ? _slots_11_io_out_uop_imm_packed : _GEN_175 ? _slots_10_io_out_uop_imm_packed : _slots_9_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_177 ? _slots_12_io_out_uop_rob_idx : _GEN_176 ? _slots_11_io_out_uop_rob_idx : _GEN_175 ? _slots_10_io_out_uop_rob_idx : _slots_9_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_177 ? _slots_12_io_out_uop_ldq_idx : _GEN_176 ? _slots_11_io_out_uop_ldq_idx : _GEN_175 ? _slots_10_io_out_uop_ldq_idx : _slots_9_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_177 ? _slots_12_io_out_uop_stq_idx : _GEN_176 ? _slots_11_io_out_uop_stq_idx : _GEN_175 ? _slots_10_io_out_uop_stq_idx : _slots_9_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_177 ? _slots_12_io_out_uop_pdst : _GEN_176 ? _slots_11_io_out_uop_pdst : _GEN_175 ? _slots_10_io_out_uop_pdst : _slots_9_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_177 ? _slots_12_io_out_uop_prs1 : _GEN_176 ? _slots_11_io_out_uop_prs1 : _GEN_175 ? _slots_10_io_out_uop_prs1 : _slots_9_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_177 ? _slots_12_io_out_uop_prs2 : _GEN_176 ? _slots_11_io_out_uop_prs2 : _GEN_175 ? _slots_10_io_out_uop_prs2 : _slots_9_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_177 ? _slots_12_io_out_uop_prs3 : _GEN_176 ? _slots_11_io_out_uop_prs3 : _GEN_175 ? _slots_10_io_out_uop_prs3 : _slots_9_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_177 ? _slots_12_io_out_uop_prs1_busy : _GEN_176 ? _slots_11_io_out_uop_prs1_busy : _GEN_175 ? _slots_10_io_out_uop_prs1_busy : _slots_9_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_177 ? _slots_12_io_out_uop_prs2_busy : _GEN_176 ? _slots_11_io_out_uop_prs2_busy : _GEN_175 ? _slots_10_io_out_uop_prs2_busy : _slots_9_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_177 ? _slots_12_io_out_uop_prs3_busy : _GEN_176 ? _slots_11_io_out_uop_prs3_busy : _GEN_175 ? _slots_10_io_out_uop_prs3_busy : _slots_9_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_177 ? _slots_12_io_out_uop_ppred_busy : _GEN_176 ? _slots_11_io_out_uop_ppred_busy : _GEN_175 ? _slots_10_io_out_uop_ppred_busy : _slots_9_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_177 ? _slots_12_io_out_uop_bypassable : _GEN_176 ? _slots_11_io_out_uop_bypassable : _GEN_175 ? _slots_10_io_out_uop_bypassable : _slots_9_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_177 ? _slots_12_io_out_uop_mem_cmd : _GEN_176 ? _slots_11_io_out_uop_mem_cmd : _GEN_175 ? _slots_10_io_out_uop_mem_cmd : _slots_9_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_177 ? _slots_12_io_out_uop_mem_size : _GEN_176 ? _slots_11_io_out_uop_mem_size : _GEN_175 ? _slots_10_io_out_uop_mem_size : _slots_9_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_177 ? _slots_12_io_out_uop_mem_signed : _GEN_176 ? _slots_11_io_out_uop_mem_signed : _GEN_175 ? _slots_10_io_out_uop_mem_signed : _slots_9_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_177 ? _slots_12_io_out_uop_is_fence : _GEN_176 ? _slots_11_io_out_uop_is_fence : _GEN_175 ? _slots_10_io_out_uop_is_fence : _slots_9_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_177 ? _slots_12_io_out_uop_is_amo : _GEN_176 ? _slots_11_io_out_uop_is_amo : _GEN_175 ? _slots_10_io_out_uop_is_amo : _slots_9_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_177 ? _slots_12_io_out_uop_uses_ldq : _GEN_176 ? _slots_11_io_out_uop_uses_ldq : _GEN_175 ? _slots_10_io_out_uop_uses_ldq : _slots_9_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_177 ? _slots_12_io_out_uop_uses_stq : _GEN_176 ? _slots_11_io_out_uop_uses_stq : _GEN_175 ? _slots_10_io_out_uop_uses_stq : _slots_9_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_177 ? _slots_12_io_out_uop_ldst_val : _GEN_176 ? _slots_11_io_out_uop_ldst_val : _GEN_175 ? _slots_10_io_out_uop_ldst_val : _slots_9_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_177 ? _slots_12_io_out_uop_dst_rtype : _GEN_176 ? _slots_11_io_out_uop_dst_rtype : _GEN_175 ? _slots_10_io_out_uop_dst_rtype : _slots_9_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_177 ? _slots_12_io_out_uop_lrs1_rtype : _GEN_176 ? _slots_11_io_out_uop_lrs1_rtype : _GEN_175 ? _slots_10_io_out_uop_lrs1_rtype : _slots_9_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_177 ? _slots_12_io_out_uop_lrs2_rtype : _GEN_176 ? _slots_11_io_out_uop_lrs2_rtype : _GEN_175 ? _slots_10_io_out_uop_lrs2_rtype : _slots_9_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_177 ? _slots_12_io_out_uop_fp_val : _GEN_176 ? _slots_11_io_out_uop_fp_val : _GEN_175 ? _slots_10_io_out_uop_fp_val : _slots_9_io_out_uop_fp_val),
    .io_valid                       (_slots_8_io_valid),
    .io_will_be_valid               (_slots_8_io_will_be_valid),
    .io_request                     (_slots_8_io_request),
    .io_out_uop_uopc                (_slots_8_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_8_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_8_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_8_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_8_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_8_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_8_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_8_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_8_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_8_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_8_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_8_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_8_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_8_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_8_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_8_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_8_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_8_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_8_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_8_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_8_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_8_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_8_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_8_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_8_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_8_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_8_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_8_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_8_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_8_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_8_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_8_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_8_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_8_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_8_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_8_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_8_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_8_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_8_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_8_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_8_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_8_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_8_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_8_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_8_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_8_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_8_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_8_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_8_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_8_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_8_io_uop_pdst),
    .io_uop_prs1                    (_slots_8_io_uop_prs1),
    .io_uop_prs2                    (_slots_8_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_8_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_8_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_8_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_8_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_8_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_8_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_8_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_8_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_8_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_8_io_uop_fp_val)
  );
  IssueSlot_32 slots_9 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_9_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_37),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_9_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_180 ? _slots_13_io_out_uop_uopc : _GEN_179 ? _slots_12_io_out_uop_uopc : _GEN_178 ? _slots_11_io_out_uop_uopc : _slots_10_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_180 ? _slots_13_io_out_uop_is_rvc : _GEN_179 ? _slots_12_io_out_uop_is_rvc : _GEN_178 ? _slots_11_io_out_uop_is_rvc : _slots_10_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_180 ? _slots_13_io_out_uop_fu_code : _GEN_179 ? _slots_12_io_out_uop_fu_code : _GEN_178 ? _slots_11_io_out_uop_fu_code : _slots_10_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_180 ? _slots_13_io_out_uop_iw_state : _GEN_179 ? _slots_12_io_out_uop_iw_state : _GEN_178 ? _slots_11_io_out_uop_iw_state : _slots_10_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_180 ? _slots_13_io_out_uop_iw_p1_poisoned : _GEN_179 ? _slots_12_io_out_uop_iw_p1_poisoned : _GEN_178 ? _slots_11_io_out_uop_iw_p1_poisoned : _slots_10_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_180 ? _slots_13_io_out_uop_iw_p2_poisoned : _GEN_179 ? _slots_12_io_out_uop_iw_p2_poisoned : _GEN_178 ? _slots_11_io_out_uop_iw_p2_poisoned : _slots_10_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_180 ? _slots_13_io_out_uop_is_br : _GEN_179 ? _slots_12_io_out_uop_is_br : _GEN_178 ? _slots_11_io_out_uop_is_br : _slots_10_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_180 ? _slots_13_io_out_uop_is_jalr : _GEN_179 ? _slots_12_io_out_uop_is_jalr : _GEN_178 ? _slots_11_io_out_uop_is_jalr : _slots_10_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_180 ? _slots_13_io_out_uop_is_jal : _GEN_179 ? _slots_12_io_out_uop_is_jal : _GEN_178 ? _slots_11_io_out_uop_is_jal : _slots_10_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_180 ? _slots_13_io_out_uop_is_sfb : _GEN_179 ? _slots_12_io_out_uop_is_sfb : _GEN_178 ? _slots_11_io_out_uop_is_sfb : _slots_10_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_180 ? _slots_13_io_out_uop_br_mask : _GEN_179 ? _slots_12_io_out_uop_br_mask : _GEN_178 ? _slots_11_io_out_uop_br_mask : _slots_10_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_180 ? _slots_13_io_out_uop_br_tag : _GEN_179 ? _slots_12_io_out_uop_br_tag : _GEN_178 ? _slots_11_io_out_uop_br_tag : _slots_10_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_180 ? _slots_13_io_out_uop_ftq_idx : _GEN_179 ? _slots_12_io_out_uop_ftq_idx : _GEN_178 ? _slots_11_io_out_uop_ftq_idx : _slots_10_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_180 ? _slots_13_io_out_uop_edge_inst : _GEN_179 ? _slots_12_io_out_uop_edge_inst : _GEN_178 ? _slots_11_io_out_uop_edge_inst : _slots_10_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_180 ? _slots_13_io_out_uop_pc_lob : _GEN_179 ? _slots_12_io_out_uop_pc_lob : _GEN_178 ? _slots_11_io_out_uop_pc_lob : _slots_10_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_180 ? _slots_13_io_out_uop_taken : _GEN_179 ? _slots_12_io_out_uop_taken : _GEN_178 ? _slots_11_io_out_uop_taken : _slots_10_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_180 ? _slots_13_io_out_uop_imm_packed : _GEN_179 ? _slots_12_io_out_uop_imm_packed : _GEN_178 ? _slots_11_io_out_uop_imm_packed : _slots_10_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_180 ? _slots_13_io_out_uop_rob_idx : _GEN_179 ? _slots_12_io_out_uop_rob_idx : _GEN_178 ? _slots_11_io_out_uop_rob_idx : _slots_10_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_180 ? _slots_13_io_out_uop_ldq_idx : _GEN_179 ? _slots_12_io_out_uop_ldq_idx : _GEN_178 ? _slots_11_io_out_uop_ldq_idx : _slots_10_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_180 ? _slots_13_io_out_uop_stq_idx : _GEN_179 ? _slots_12_io_out_uop_stq_idx : _GEN_178 ? _slots_11_io_out_uop_stq_idx : _slots_10_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_180 ? _slots_13_io_out_uop_pdst : _GEN_179 ? _slots_12_io_out_uop_pdst : _GEN_178 ? _slots_11_io_out_uop_pdst : _slots_10_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_180 ? _slots_13_io_out_uop_prs1 : _GEN_179 ? _slots_12_io_out_uop_prs1 : _GEN_178 ? _slots_11_io_out_uop_prs1 : _slots_10_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_180 ? _slots_13_io_out_uop_prs2 : _GEN_179 ? _slots_12_io_out_uop_prs2 : _GEN_178 ? _slots_11_io_out_uop_prs2 : _slots_10_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_180 ? _slots_13_io_out_uop_prs3 : _GEN_179 ? _slots_12_io_out_uop_prs3 : _GEN_178 ? _slots_11_io_out_uop_prs3 : _slots_10_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_180 ? _slots_13_io_out_uop_prs1_busy : _GEN_179 ? _slots_12_io_out_uop_prs1_busy : _GEN_178 ? _slots_11_io_out_uop_prs1_busy : _slots_10_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_180 ? _slots_13_io_out_uop_prs2_busy : _GEN_179 ? _slots_12_io_out_uop_prs2_busy : _GEN_178 ? _slots_11_io_out_uop_prs2_busy : _slots_10_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_180 ? _slots_13_io_out_uop_prs3_busy : _GEN_179 ? _slots_12_io_out_uop_prs3_busy : _GEN_178 ? _slots_11_io_out_uop_prs3_busy : _slots_10_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_180 ? _slots_13_io_out_uop_ppred_busy : _GEN_179 ? _slots_12_io_out_uop_ppred_busy : _GEN_178 ? _slots_11_io_out_uop_ppred_busy : _slots_10_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_180 ? _slots_13_io_out_uop_bypassable : _GEN_179 ? _slots_12_io_out_uop_bypassable : _GEN_178 ? _slots_11_io_out_uop_bypassable : _slots_10_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_180 ? _slots_13_io_out_uop_mem_cmd : _GEN_179 ? _slots_12_io_out_uop_mem_cmd : _GEN_178 ? _slots_11_io_out_uop_mem_cmd : _slots_10_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_180 ? _slots_13_io_out_uop_mem_size : _GEN_179 ? _slots_12_io_out_uop_mem_size : _GEN_178 ? _slots_11_io_out_uop_mem_size : _slots_10_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_180 ? _slots_13_io_out_uop_mem_signed : _GEN_179 ? _slots_12_io_out_uop_mem_signed : _GEN_178 ? _slots_11_io_out_uop_mem_signed : _slots_10_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_180 ? _slots_13_io_out_uop_is_fence : _GEN_179 ? _slots_12_io_out_uop_is_fence : _GEN_178 ? _slots_11_io_out_uop_is_fence : _slots_10_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_180 ? _slots_13_io_out_uop_is_amo : _GEN_179 ? _slots_12_io_out_uop_is_amo : _GEN_178 ? _slots_11_io_out_uop_is_amo : _slots_10_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_180 ? _slots_13_io_out_uop_uses_ldq : _GEN_179 ? _slots_12_io_out_uop_uses_ldq : _GEN_178 ? _slots_11_io_out_uop_uses_ldq : _slots_10_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_180 ? _slots_13_io_out_uop_uses_stq : _GEN_179 ? _slots_12_io_out_uop_uses_stq : _GEN_178 ? _slots_11_io_out_uop_uses_stq : _slots_10_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_180 ? _slots_13_io_out_uop_ldst_val : _GEN_179 ? _slots_12_io_out_uop_ldst_val : _GEN_178 ? _slots_11_io_out_uop_ldst_val : _slots_10_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_180 ? _slots_13_io_out_uop_dst_rtype : _GEN_179 ? _slots_12_io_out_uop_dst_rtype : _GEN_178 ? _slots_11_io_out_uop_dst_rtype : _slots_10_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_180 ? _slots_13_io_out_uop_lrs1_rtype : _GEN_179 ? _slots_12_io_out_uop_lrs1_rtype : _GEN_178 ? _slots_11_io_out_uop_lrs1_rtype : _slots_10_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_180 ? _slots_13_io_out_uop_lrs2_rtype : _GEN_179 ? _slots_12_io_out_uop_lrs2_rtype : _GEN_178 ? _slots_11_io_out_uop_lrs2_rtype : _slots_10_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_180 ? _slots_13_io_out_uop_fp_val : _GEN_179 ? _slots_12_io_out_uop_fp_val : _GEN_178 ? _slots_11_io_out_uop_fp_val : _slots_10_io_out_uop_fp_val),
    .io_valid                       (_slots_9_io_valid),
    .io_will_be_valid               (_slots_9_io_will_be_valid),
    .io_request                     (_slots_9_io_request),
    .io_out_uop_uopc                (_slots_9_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_9_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_9_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_9_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_9_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_9_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_9_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_9_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_9_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_9_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_9_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_9_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_9_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_9_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_9_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_9_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_9_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_9_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_9_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_9_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_9_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_9_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_9_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_9_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_9_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_9_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_9_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_9_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_9_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_9_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_9_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_9_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_9_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_9_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_9_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_9_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_9_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_9_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_9_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_9_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_9_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_9_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_9_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_9_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_9_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_9_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_9_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_9_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_9_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_9_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_9_io_uop_pdst),
    .io_uop_prs1                    (_slots_9_io_uop_prs1),
    .io_uop_prs2                    (_slots_9_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_9_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_9_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_9_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_9_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_9_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_9_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_9_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_9_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_9_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_9_io_uop_fp_val)
  );
  IssueSlot_32 slots_10 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_10_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_39),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_10_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_183 ? _slots_14_io_out_uop_uopc : _GEN_182 ? _slots_13_io_out_uop_uopc : _GEN_181 ? _slots_12_io_out_uop_uopc : _slots_11_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_183 ? _slots_14_io_out_uop_is_rvc : _GEN_182 ? _slots_13_io_out_uop_is_rvc : _GEN_181 ? _slots_12_io_out_uop_is_rvc : _slots_11_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_183 ? _slots_14_io_out_uop_fu_code : _GEN_182 ? _slots_13_io_out_uop_fu_code : _GEN_181 ? _slots_12_io_out_uop_fu_code : _slots_11_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_183 ? _slots_14_io_out_uop_iw_state : _GEN_182 ? _slots_13_io_out_uop_iw_state : _GEN_181 ? _slots_12_io_out_uop_iw_state : _slots_11_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_183 ? _slots_14_io_out_uop_iw_p1_poisoned : _GEN_182 ? _slots_13_io_out_uop_iw_p1_poisoned : _GEN_181 ? _slots_12_io_out_uop_iw_p1_poisoned : _slots_11_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_183 ? _slots_14_io_out_uop_iw_p2_poisoned : _GEN_182 ? _slots_13_io_out_uop_iw_p2_poisoned : _GEN_181 ? _slots_12_io_out_uop_iw_p2_poisoned : _slots_11_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_183 ? _slots_14_io_out_uop_is_br : _GEN_182 ? _slots_13_io_out_uop_is_br : _GEN_181 ? _slots_12_io_out_uop_is_br : _slots_11_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_183 ? _slots_14_io_out_uop_is_jalr : _GEN_182 ? _slots_13_io_out_uop_is_jalr : _GEN_181 ? _slots_12_io_out_uop_is_jalr : _slots_11_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_183 ? _slots_14_io_out_uop_is_jal : _GEN_182 ? _slots_13_io_out_uop_is_jal : _GEN_181 ? _slots_12_io_out_uop_is_jal : _slots_11_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_183 ? _slots_14_io_out_uop_is_sfb : _GEN_182 ? _slots_13_io_out_uop_is_sfb : _GEN_181 ? _slots_12_io_out_uop_is_sfb : _slots_11_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_183 ? _slots_14_io_out_uop_br_mask : _GEN_182 ? _slots_13_io_out_uop_br_mask : _GEN_181 ? _slots_12_io_out_uop_br_mask : _slots_11_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_183 ? _slots_14_io_out_uop_br_tag : _GEN_182 ? _slots_13_io_out_uop_br_tag : _GEN_181 ? _slots_12_io_out_uop_br_tag : _slots_11_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_183 ? _slots_14_io_out_uop_ftq_idx : _GEN_182 ? _slots_13_io_out_uop_ftq_idx : _GEN_181 ? _slots_12_io_out_uop_ftq_idx : _slots_11_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_183 ? _slots_14_io_out_uop_edge_inst : _GEN_182 ? _slots_13_io_out_uop_edge_inst : _GEN_181 ? _slots_12_io_out_uop_edge_inst : _slots_11_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_183 ? _slots_14_io_out_uop_pc_lob : _GEN_182 ? _slots_13_io_out_uop_pc_lob : _GEN_181 ? _slots_12_io_out_uop_pc_lob : _slots_11_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_183 ? _slots_14_io_out_uop_taken : _GEN_182 ? _slots_13_io_out_uop_taken : _GEN_181 ? _slots_12_io_out_uop_taken : _slots_11_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_183 ? _slots_14_io_out_uop_imm_packed : _GEN_182 ? _slots_13_io_out_uop_imm_packed : _GEN_181 ? _slots_12_io_out_uop_imm_packed : _slots_11_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_183 ? _slots_14_io_out_uop_rob_idx : _GEN_182 ? _slots_13_io_out_uop_rob_idx : _GEN_181 ? _slots_12_io_out_uop_rob_idx : _slots_11_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_183 ? _slots_14_io_out_uop_ldq_idx : _GEN_182 ? _slots_13_io_out_uop_ldq_idx : _GEN_181 ? _slots_12_io_out_uop_ldq_idx : _slots_11_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_183 ? _slots_14_io_out_uop_stq_idx : _GEN_182 ? _slots_13_io_out_uop_stq_idx : _GEN_181 ? _slots_12_io_out_uop_stq_idx : _slots_11_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_183 ? _slots_14_io_out_uop_pdst : _GEN_182 ? _slots_13_io_out_uop_pdst : _GEN_181 ? _slots_12_io_out_uop_pdst : _slots_11_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_183 ? _slots_14_io_out_uop_prs1 : _GEN_182 ? _slots_13_io_out_uop_prs1 : _GEN_181 ? _slots_12_io_out_uop_prs1 : _slots_11_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_183 ? _slots_14_io_out_uop_prs2 : _GEN_182 ? _slots_13_io_out_uop_prs2 : _GEN_181 ? _slots_12_io_out_uop_prs2 : _slots_11_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_183 ? _slots_14_io_out_uop_prs3 : _GEN_182 ? _slots_13_io_out_uop_prs3 : _GEN_181 ? _slots_12_io_out_uop_prs3 : _slots_11_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_183 ? _slots_14_io_out_uop_prs1_busy : _GEN_182 ? _slots_13_io_out_uop_prs1_busy : _GEN_181 ? _slots_12_io_out_uop_prs1_busy : _slots_11_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_183 ? _slots_14_io_out_uop_prs2_busy : _GEN_182 ? _slots_13_io_out_uop_prs2_busy : _GEN_181 ? _slots_12_io_out_uop_prs2_busy : _slots_11_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_183 ? _slots_14_io_out_uop_prs3_busy : _GEN_182 ? _slots_13_io_out_uop_prs3_busy : _GEN_181 ? _slots_12_io_out_uop_prs3_busy : _slots_11_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_183 ? _slots_14_io_out_uop_ppred_busy : _GEN_182 ? _slots_13_io_out_uop_ppred_busy : _GEN_181 ? _slots_12_io_out_uop_ppred_busy : _slots_11_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_183 ? _slots_14_io_out_uop_bypassable : _GEN_182 ? _slots_13_io_out_uop_bypassable : _GEN_181 ? _slots_12_io_out_uop_bypassable : _slots_11_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_183 ? _slots_14_io_out_uop_mem_cmd : _GEN_182 ? _slots_13_io_out_uop_mem_cmd : _GEN_181 ? _slots_12_io_out_uop_mem_cmd : _slots_11_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_183 ? _slots_14_io_out_uop_mem_size : _GEN_182 ? _slots_13_io_out_uop_mem_size : _GEN_181 ? _slots_12_io_out_uop_mem_size : _slots_11_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_183 ? _slots_14_io_out_uop_mem_signed : _GEN_182 ? _slots_13_io_out_uop_mem_signed : _GEN_181 ? _slots_12_io_out_uop_mem_signed : _slots_11_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_183 ? _slots_14_io_out_uop_is_fence : _GEN_182 ? _slots_13_io_out_uop_is_fence : _GEN_181 ? _slots_12_io_out_uop_is_fence : _slots_11_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_183 ? _slots_14_io_out_uop_is_amo : _GEN_182 ? _slots_13_io_out_uop_is_amo : _GEN_181 ? _slots_12_io_out_uop_is_amo : _slots_11_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_183 ? _slots_14_io_out_uop_uses_ldq : _GEN_182 ? _slots_13_io_out_uop_uses_ldq : _GEN_181 ? _slots_12_io_out_uop_uses_ldq : _slots_11_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_183 ? _slots_14_io_out_uop_uses_stq : _GEN_182 ? _slots_13_io_out_uop_uses_stq : _GEN_181 ? _slots_12_io_out_uop_uses_stq : _slots_11_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_183 ? _slots_14_io_out_uop_ldst_val : _GEN_182 ? _slots_13_io_out_uop_ldst_val : _GEN_181 ? _slots_12_io_out_uop_ldst_val : _slots_11_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_183 ? _slots_14_io_out_uop_dst_rtype : _GEN_182 ? _slots_13_io_out_uop_dst_rtype : _GEN_181 ? _slots_12_io_out_uop_dst_rtype : _slots_11_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_183 ? _slots_14_io_out_uop_lrs1_rtype : _GEN_182 ? _slots_13_io_out_uop_lrs1_rtype : _GEN_181 ? _slots_12_io_out_uop_lrs1_rtype : _slots_11_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_183 ? _slots_14_io_out_uop_lrs2_rtype : _GEN_182 ? _slots_13_io_out_uop_lrs2_rtype : _GEN_181 ? _slots_12_io_out_uop_lrs2_rtype : _slots_11_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_183 ? _slots_14_io_out_uop_fp_val : _GEN_182 ? _slots_13_io_out_uop_fp_val : _GEN_181 ? _slots_12_io_out_uop_fp_val : _slots_11_io_out_uop_fp_val),
    .io_valid                       (_slots_10_io_valid),
    .io_will_be_valid               (_slots_10_io_will_be_valid),
    .io_request                     (_slots_10_io_request),
    .io_out_uop_uopc                (_slots_10_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_10_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_10_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_10_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_10_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_10_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_10_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_10_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_10_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_10_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_10_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_10_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_10_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_10_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_10_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_10_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_10_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_10_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_10_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_10_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_10_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_10_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_10_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_10_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_10_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_10_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_10_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_10_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_10_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_10_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_10_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_10_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_10_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_10_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_10_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_10_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_10_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_10_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_10_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_10_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_10_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_10_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_10_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_10_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_10_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_10_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_10_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_10_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_10_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_10_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_10_io_uop_pdst),
    .io_uop_prs1                    (_slots_10_io_uop_prs1),
    .io_uop_prs2                    (_slots_10_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_10_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_10_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_10_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_10_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_10_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_10_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_10_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_10_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_10_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_10_io_uop_fp_val)
  );
  IssueSlot_32 slots_11 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_11_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_41),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_11_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_186 ? _slots_15_io_out_uop_uopc : _GEN_185 ? _slots_14_io_out_uop_uopc : _GEN_184 ? _slots_13_io_out_uop_uopc : _slots_12_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_186 ? _slots_15_io_out_uop_is_rvc : _GEN_185 ? _slots_14_io_out_uop_is_rvc : _GEN_184 ? _slots_13_io_out_uop_is_rvc : _slots_12_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_186 ? _slots_15_io_out_uop_fu_code : _GEN_185 ? _slots_14_io_out_uop_fu_code : _GEN_184 ? _slots_13_io_out_uop_fu_code : _slots_12_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_186 ? _slots_15_io_out_uop_iw_state : _GEN_185 ? _slots_14_io_out_uop_iw_state : _GEN_184 ? _slots_13_io_out_uop_iw_state : _slots_12_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_186 ? _slots_15_io_out_uop_iw_p1_poisoned : _GEN_185 ? _slots_14_io_out_uop_iw_p1_poisoned : _GEN_184 ? _slots_13_io_out_uop_iw_p1_poisoned : _slots_12_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_186 ? _slots_15_io_out_uop_iw_p2_poisoned : _GEN_185 ? _slots_14_io_out_uop_iw_p2_poisoned : _GEN_184 ? _slots_13_io_out_uop_iw_p2_poisoned : _slots_12_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_186 ? _slots_15_io_out_uop_is_br : _GEN_185 ? _slots_14_io_out_uop_is_br : _GEN_184 ? _slots_13_io_out_uop_is_br : _slots_12_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_186 ? _slots_15_io_out_uop_is_jalr : _GEN_185 ? _slots_14_io_out_uop_is_jalr : _GEN_184 ? _slots_13_io_out_uop_is_jalr : _slots_12_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_186 ? _slots_15_io_out_uop_is_jal : _GEN_185 ? _slots_14_io_out_uop_is_jal : _GEN_184 ? _slots_13_io_out_uop_is_jal : _slots_12_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_186 ? _slots_15_io_out_uop_is_sfb : _GEN_185 ? _slots_14_io_out_uop_is_sfb : _GEN_184 ? _slots_13_io_out_uop_is_sfb : _slots_12_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_186 ? _slots_15_io_out_uop_br_mask : _GEN_185 ? _slots_14_io_out_uop_br_mask : _GEN_184 ? _slots_13_io_out_uop_br_mask : _slots_12_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_186 ? _slots_15_io_out_uop_br_tag : _GEN_185 ? _slots_14_io_out_uop_br_tag : _GEN_184 ? _slots_13_io_out_uop_br_tag : _slots_12_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_186 ? _slots_15_io_out_uop_ftq_idx : _GEN_185 ? _slots_14_io_out_uop_ftq_idx : _GEN_184 ? _slots_13_io_out_uop_ftq_idx : _slots_12_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_186 ? _slots_15_io_out_uop_edge_inst : _GEN_185 ? _slots_14_io_out_uop_edge_inst : _GEN_184 ? _slots_13_io_out_uop_edge_inst : _slots_12_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_186 ? _slots_15_io_out_uop_pc_lob : _GEN_185 ? _slots_14_io_out_uop_pc_lob : _GEN_184 ? _slots_13_io_out_uop_pc_lob : _slots_12_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_186 ? _slots_15_io_out_uop_taken : _GEN_185 ? _slots_14_io_out_uop_taken : _GEN_184 ? _slots_13_io_out_uop_taken : _slots_12_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_186 ? _slots_15_io_out_uop_imm_packed : _GEN_185 ? _slots_14_io_out_uop_imm_packed : _GEN_184 ? _slots_13_io_out_uop_imm_packed : _slots_12_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_186 ? _slots_15_io_out_uop_rob_idx : _GEN_185 ? _slots_14_io_out_uop_rob_idx : _GEN_184 ? _slots_13_io_out_uop_rob_idx : _slots_12_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_186 ? _slots_15_io_out_uop_ldq_idx : _GEN_185 ? _slots_14_io_out_uop_ldq_idx : _GEN_184 ? _slots_13_io_out_uop_ldq_idx : _slots_12_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_186 ? _slots_15_io_out_uop_stq_idx : _GEN_185 ? _slots_14_io_out_uop_stq_idx : _GEN_184 ? _slots_13_io_out_uop_stq_idx : _slots_12_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_186 ? _slots_15_io_out_uop_pdst : _GEN_185 ? _slots_14_io_out_uop_pdst : _GEN_184 ? _slots_13_io_out_uop_pdst : _slots_12_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_186 ? _slots_15_io_out_uop_prs1 : _GEN_185 ? _slots_14_io_out_uop_prs1 : _GEN_184 ? _slots_13_io_out_uop_prs1 : _slots_12_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_186 ? _slots_15_io_out_uop_prs2 : _GEN_185 ? _slots_14_io_out_uop_prs2 : _GEN_184 ? _slots_13_io_out_uop_prs2 : _slots_12_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_186 ? _slots_15_io_out_uop_prs3 : _GEN_185 ? _slots_14_io_out_uop_prs3 : _GEN_184 ? _slots_13_io_out_uop_prs3 : _slots_12_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_186 ? _slots_15_io_out_uop_prs1_busy : _GEN_185 ? _slots_14_io_out_uop_prs1_busy : _GEN_184 ? _slots_13_io_out_uop_prs1_busy : _slots_12_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_186 ? _slots_15_io_out_uop_prs2_busy : _GEN_185 ? _slots_14_io_out_uop_prs2_busy : _GEN_184 ? _slots_13_io_out_uop_prs2_busy : _slots_12_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_186 ? _slots_15_io_out_uop_prs3_busy : _GEN_185 ? _slots_14_io_out_uop_prs3_busy : _GEN_184 ? _slots_13_io_out_uop_prs3_busy : _slots_12_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_186 ? _slots_15_io_out_uop_ppred_busy : _GEN_185 ? _slots_14_io_out_uop_ppred_busy : _GEN_184 ? _slots_13_io_out_uop_ppred_busy : _slots_12_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_186 ? _slots_15_io_out_uop_bypassable : _GEN_185 ? _slots_14_io_out_uop_bypassable : _GEN_184 ? _slots_13_io_out_uop_bypassable : _slots_12_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_186 ? _slots_15_io_out_uop_mem_cmd : _GEN_185 ? _slots_14_io_out_uop_mem_cmd : _GEN_184 ? _slots_13_io_out_uop_mem_cmd : _slots_12_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_186 ? _slots_15_io_out_uop_mem_size : _GEN_185 ? _slots_14_io_out_uop_mem_size : _GEN_184 ? _slots_13_io_out_uop_mem_size : _slots_12_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_186 ? _slots_15_io_out_uop_mem_signed : _GEN_185 ? _slots_14_io_out_uop_mem_signed : _GEN_184 ? _slots_13_io_out_uop_mem_signed : _slots_12_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_186 ? _slots_15_io_out_uop_is_fence : _GEN_185 ? _slots_14_io_out_uop_is_fence : _GEN_184 ? _slots_13_io_out_uop_is_fence : _slots_12_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_186 ? _slots_15_io_out_uop_is_amo : _GEN_185 ? _slots_14_io_out_uop_is_amo : _GEN_184 ? _slots_13_io_out_uop_is_amo : _slots_12_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_186 ? _slots_15_io_out_uop_uses_ldq : _GEN_185 ? _slots_14_io_out_uop_uses_ldq : _GEN_184 ? _slots_13_io_out_uop_uses_ldq : _slots_12_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_186 ? _slots_15_io_out_uop_uses_stq : _GEN_185 ? _slots_14_io_out_uop_uses_stq : _GEN_184 ? _slots_13_io_out_uop_uses_stq : _slots_12_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_186 ? _slots_15_io_out_uop_ldst_val : _GEN_185 ? _slots_14_io_out_uop_ldst_val : _GEN_184 ? _slots_13_io_out_uop_ldst_val : _slots_12_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_186 ? _slots_15_io_out_uop_dst_rtype : _GEN_185 ? _slots_14_io_out_uop_dst_rtype : _GEN_184 ? _slots_13_io_out_uop_dst_rtype : _slots_12_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_186 ? _slots_15_io_out_uop_lrs1_rtype : _GEN_185 ? _slots_14_io_out_uop_lrs1_rtype : _GEN_184 ? _slots_13_io_out_uop_lrs1_rtype : _slots_12_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_186 ? _slots_15_io_out_uop_lrs2_rtype : _GEN_185 ? _slots_14_io_out_uop_lrs2_rtype : _GEN_184 ? _slots_13_io_out_uop_lrs2_rtype : _slots_12_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_186 ? _slots_15_io_out_uop_fp_val : _GEN_185 ? _slots_14_io_out_uop_fp_val : _GEN_184 ? _slots_13_io_out_uop_fp_val : _slots_12_io_out_uop_fp_val),
    .io_valid                       (_slots_11_io_valid),
    .io_will_be_valid               (_slots_11_io_will_be_valid),
    .io_request                     (_slots_11_io_request),
    .io_out_uop_uopc                (_slots_11_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_11_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_11_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_11_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_11_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_11_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_11_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_11_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_11_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_11_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_11_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_11_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_11_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_11_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_11_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_11_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_11_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_11_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_11_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_11_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_11_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_11_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_11_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_11_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_11_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_11_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_11_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_11_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_11_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_11_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_11_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_11_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_11_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_11_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_11_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_11_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_11_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_11_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_11_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_11_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_11_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_11_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_11_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_11_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_11_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_11_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_11_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_11_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_11_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_11_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_11_io_uop_pdst),
    .io_uop_prs1                    (_slots_11_io_uop_prs1),
    .io_uop_prs2                    (_slots_11_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_11_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_11_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_11_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_11_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_11_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_11_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_11_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_11_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_11_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_11_io_uop_fp_val)
  );
  IssueSlot_32 slots_12 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_12_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_43),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_12_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_189 ? _slots_16_io_out_uop_uopc : _GEN_188 ? _slots_15_io_out_uop_uopc : _GEN_187 ? _slots_14_io_out_uop_uopc : _slots_13_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_189 ? _slots_16_io_out_uop_is_rvc : _GEN_188 ? _slots_15_io_out_uop_is_rvc : _GEN_187 ? _slots_14_io_out_uop_is_rvc : _slots_13_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_189 ? _slots_16_io_out_uop_fu_code : _GEN_188 ? _slots_15_io_out_uop_fu_code : _GEN_187 ? _slots_14_io_out_uop_fu_code : _slots_13_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_189 ? _slots_16_io_out_uop_iw_state : _GEN_188 ? _slots_15_io_out_uop_iw_state : _GEN_187 ? _slots_14_io_out_uop_iw_state : _slots_13_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_189 ? _slots_16_io_out_uop_iw_p1_poisoned : _GEN_188 ? _slots_15_io_out_uop_iw_p1_poisoned : _GEN_187 ? _slots_14_io_out_uop_iw_p1_poisoned : _slots_13_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_189 ? _slots_16_io_out_uop_iw_p2_poisoned : _GEN_188 ? _slots_15_io_out_uop_iw_p2_poisoned : _GEN_187 ? _slots_14_io_out_uop_iw_p2_poisoned : _slots_13_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_189 ? _slots_16_io_out_uop_is_br : _GEN_188 ? _slots_15_io_out_uop_is_br : _GEN_187 ? _slots_14_io_out_uop_is_br : _slots_13_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_189 ? _slots_16_io_out_uop_is_jalr : _GEN_188 ? _slots_15_io_out_uop_is_jalr : _GEN_187 ? _slots_14_io_out_uop_is_jalr : _slots_13_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_189 ? _slots_16_io_out_uop_is_jal : _GEN_188 ? _slots_15_io_out_uop_is_jal : _GEN_187 ? _slots_14_io_out_uop_is_jal : _slots_13_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_189 ? _slots_16_io_out_uop_is_sfb : _GEN_188 ? _slots_15_io_out_uop_is_sfb : _GEN_187 ? _slots_14_io_out_uop_is_sfb : _slots_13_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_189 ? _slots_16_io_out_uop_br_mask : _GEN_188 ? _slots_15_io_out_uop_br_mask : _GEN_187 ? _slots_14_io_out_uop_br_mask : _slots_13_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_189 ? _slots_16_io_out_uop_br_tag : _GEN_188 ? _slots_15_io_out_uop_br_tag : _GEN_187 ? _slots_14_io_out_uop_br_tag : _slots_13_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_189 ? _slots_16_io_out_uop_ftq_idx : _GEN_188 ? _slots_15_io_out_uop_ftq_idx : _GEN_187 ? _slots_14_io_out_uop_ftq_idx : _slots_13_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_189 ? _slots_16_io_out_uop_edge_inst : _GEN_188 ? _slots_15_io_out_uop_edge_inst : _GEN_187 ? _slots_14_io_out_uop_edge_inst : _slots_13_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_189 ? _slots_16_io_out_uop_pc_lob : _GEN_188 ? _slots_15_io_out_uop_pc_lob : _GEN_187 ? _slots_14_io_out_uop_pc_lob : _slots_13_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_189 ? _slots_16_io_out_uop_taken : _GEN_188 ? _slots_15_io_out_uop_taken : _GEN_187 ? _slots_14_io_out_uop_taken : _slots_13_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_189 ? _slots_16_io_out_uop_imm_packed : _GEN_188 ? _slots_15_io_out_uop_imm_packed : _GEN_187 ? _slots_14_io_out_uop_imm_packed : _slots_13_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_189 ? _slots_16_io_out_uop_rob_idx : _GEN_188 ? _slots_15_io_out_uop_rob_idx : _GEN_187 ? _slots_14_io_out_uop_rob_idx : _slots_13_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_189 ? _slots_16_io_out_uop_ldq_idx : _GEN_188 ? _slots_15_io_out_uop_ldq_idx : _GEN_187 ? _slots_14_io_out_uop_ldq_idx : _slots_13_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_189 ? _slots_16_io_out_uop_stq_idx : _GEN_188 ? _slots_15_io_out_uop_stq_idx : _GEN_187 ? _slots_14_io_out_uop_stq_idx : _slots_13_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_189 ? _slots_16_io_out_uop_pdst : _GEN_188 ? _slots_15_io_out_uop_pdst : _GEN_187 ? _slots_14_io_out_uop_pdst : _slots_13_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_189 ? _slots_16_io_out_uop_prs1 : _GEN_188 ? _slots_15_io_out_uop_prs1 : _GEN_187 ? _slots_14_io_out_uop_prs1 : _slots_13_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_189 ? _slots_16_io_out_uop_prs2 : _GEN_188 ? _slots_15_io_out_uop_prs2 : _GEN_187 ? _slots_14_io_out_uop_prs2 : _slots_13_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_189 ? _slots_16_io_out_uop_prs3 : _GEN_188 ? _slots_15_io_out_uop_prs3 : _GEN_187 ? _slots_14_io_out_uop_prs3 : _slots_13_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_189 ? _slots_16_io_out_uop_prs1_busy : _GEN_188 ? _slots_15_io_out_uop_prs1_busy : _GEN_187 ? _slots_14_io_out_uop_prs1_busy : _slots_13_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_189 ? _slots_16_io_out_uop_prs2_busy : _GEN_188 ? _slots_15_io_out_uop_prs2_busy : _GEN_187 ? _slots_14_io_out_uop_prs2_busy : _slots_13_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_189 ? _slots_16_io_out_uop_prs3_busy : _GEN_188 ? _slots_15_io_out_uop_prs3_busy : _GEN_187 ? _slots_14_io_out_uop_prs3_busy : _slots_13_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_189 ? _slots_16_io_out_uop_ppred_busy : _GEN_188 ? _slots_15_io_out_uop_ppred_busy : _GEN_187 ? _slots_14_io_out_uop_ppred_busy : _slots_13_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_189 ? _slots_16_io_out_uop_bypassable : _GEN_188 ? _slots_15_io_out_uop_bypassable : _GEN_187 ? _slots_14_io_out_uop_bypassable : _slots_13_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_189 ? _slots_16_io_out_uop_mem_cmd : _GEN_188 ? _slots_15_io_out_uop_mem_cmd : _GEN_187 ? _slots_14_io_out_uop_mem_cmd : _slots_13_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_189 ? _slots_16_io_out_uop_mem_size : _GEN_188 ? _slots_15_io_out_uop_mem_size : _GEN_187 ? _slots_14_io_out_uop_mem_size : _slots_13_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_189 ? _slots_16_io_out_uop_mem_signed : _GEN_188 ? _slots_15_io_out_uop_mem_signed : _GEN_187 ? _slots_14_io_out_uop_mem_signed : _slots_13_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_189 ? _slots_16_io_out_uop_is_fence : _GEN_188 ? _slots_15_io_out_uop_is_fence : _GEN_187 ? _slots_14_io_out_uop_is_fence : _slots_13_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_189 ? _slots_16_io_out_uop_is_amo : _GEN_188 ? _slots_15_io_out_uop_is_amo : _GEN_187 ? _slots_14_io_out_uop_is_amo : _slots_13_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_189 ? _slots_16_io_out_uop_uses_ldq : _GEN_188 ? _slots_15_io_out_uop_uses_ldq : _GEN_187 ? _slots_14_io_out_uop_uses_ldq : _slots_13_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_189 ? _slots_16_io_out_uop_uses_stq : _GEN_188 ? _slots_15_io_out_uop_uses_stq : _GEN_187 ? _slots_14_io_out_uop_uses_stq : _slots_13_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_189 ? _slots_16_io_out_uop_ldst_val : _GEN_188 ? _slots_15_io_out_uop_ldst_val : _GEN_187 ? _slots_14_io_out_uop_ldst_val : _slots_13_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_189 ? _slots_16_io_out_uop_dst_rtype : _GEN_188 ? _slots_15_io_out_uop_dst_rtype : _GEN_187 ? _slots_14_io_out_uop_dst_rtype : _slots_13_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_189 ? _slots_16_io_out_uop_lrs1_rtype : _GEN_188 ? _slots_15_io_out_uop_lrs1_rtype : _GEN_187 ? _slots_14_io_out_uop_lrs1_rtype : _slots_13_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_189 ? _slots_16_io_out_uop_lrs2_rtype : _GEN_188 ? _slots_15_io_out_uop_lrs2_rtype : _GEN_187 ? _slots_14_io_out_uop_lrs2_rtype : _slots_13_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_189 ? _slots_16_io_out_uop_fp_val : _GEN_188 ? _slots_15_io_out_uop_fp_val : _GEN_187 ? _slots_14_io_out_uop_fp_val : _slots_13_io_out_uop_fp_val),
    .io_valid                       (_slots_12_io_valid),
    .io_will_be_valid               (_slots_12_io_will_be_valid),
    .io_request                     (_slots_12_io_request),
    .io_out_uop_uopc                (_slots_12_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_12_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_12_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_12_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_12_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_12_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_12_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_12_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_12_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_12_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_12_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_12_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_12_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_12_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_12_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_12_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_12_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_12_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_12_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_12_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_12_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_12_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_12_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_12_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_12_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_12_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_12_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_12_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_12_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_12_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_12_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_12_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_12_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_12_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_12_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_12_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_12_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_12_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_12_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_12_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_12_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_12_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_12_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_12_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_12_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_12_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_12_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_12_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_12_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_12_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_12_io_uop_pdst),
    .io_uop_prs1                    (_slots_12_io_uop_prs1),
    .io_uop_prs2                    (_slots_12_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_12_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_12_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_12_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_12_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_12_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_12_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_12_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_12_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_12_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_12_io_uop_fp_val)
  );
  IssueSlot_32 slots_13 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_13_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_45),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_13_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_192 ? _slots_17_io_out_uop_uopc : _GEN_191 ? _slots_16_io_out_uop_uopc : _GEN_190 ? _slots_15_io_out_uop_uopc : _slots_14_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_192 ? _slots_17_io_out_uop_is_rvc : _GEN_191 ? _slots_16_io_out_uop_is_rvc : _GEN_190 ? _slots_15_io_out_uop_is_rvc : _slots_14_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_192 ? _slots_17_io_out_uop_fu_code : _GEN_191 ? _slots_16_io_out_uop_fu_code : _GEN_190 ? _slots_15_io_out_uop_fu_code : _slots_14_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_192 ? _slots_17_io_out_uop_iw_state : _GEN_191 ? _slots_16_io_out_uop_iw_state : _GEN_190 ? _slots_15_io_out_uop_iw_state : _slots_14_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_192 ? _slots_17_io_out_uop_iw_p1_poisoned : _GEN_191 ? _slots_16_io_out_uop_iw_p1_poisoned : _GEN_190 ? _slots_15_io_out_uop_iw_p1_poisoned : _slots_14_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_192 ? _slots_17_io_out_uop_iw_p2_poisoned : _GEN_191 ? _slots_16_io_out_uop_iw_p2_poisoned : _GEN_190 ? _slots_15_io_out_uop_iw_p2_poisoned : _slots_14_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_192 ? _slots_17_io_out_uop_is_br : _GEN_191 ? _slots_16_io_out_uop_is_br : _GEN_190 ? _slots_15_io_out_uop_is_br : _slots_14_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_192 ? _slots_17_io_out_uop_is_jalr : _GEN_191 ? _slots_16_io_out_uop_is_jalr : _GEN_190 ? _slots_15_io_out_uop_is_jalr : _slots_14_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_192 ? _slots_17_io_out_uop_is_jal : _GEN_191 ? _slots_16_io_out_uop_is_jal : _GEN_190 ? _slots_15_io_out_uop_is_jal : _slots_14_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_192 ? _slots_17_io_out_uop_is_sfb : _GEN_191 ? _slots_16_io_out_uop_is_sfb : _GEN_190 ? _slots_15_io_out_uop_is_sfb : _slots_14_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_192 ? _slots_17_io_out_uop_br_mask : _GEN_191 ? _slots_16_io_out_uop_br_mask : _GEN_190 ? _slots_15_io_out_uop_br_mask : _slots_14_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_192 ? _slots_17_io_out_uop_br_tag : _GEN_191 ? _slots_16_io_out_uop_br_tag : _GEN_190 ? _slots_15_io_out_uop_br_tag : _slots_14_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_192 ? _slots_17_io_out_uop_ftq_idx : _GEN_191 ? _slots_16_io_out_uop_ftq_idx : _GEN_190 ? _slots_15_io_out_uop_ftq_idx : _slots_14_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_192 ? _slots_17_io_out_uop_edge_inst : _GEN_191 ? _slots_16_io_out_uop_edge_inst : _GEN_190 ? _slots_15_io_out_uop_edge_inst : _slots_14_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_192 ? _slots_17_io_out_uop_pc_lob : _GEN_191 ? _slots_16_io_out_uop_pc_lob : _GEN_190 ? _slots_15_io_out_uop_pc_lob : _slots_14_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_192 ? _slots_17_io_out_uop_taken : _GEN_191 ? _slots_16_io_out_uop_taken : _GEN_190 ? _slots_15_io_out_uop_taken : _slots_14_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_192 ? _slots_17_io_out_uop_imm_packed : _GEN_191 ? _slots_16_io_out_uop_imm_packed : _GEN_190 ? _slots_15_io_out_uop_imm_packed : _slots_14_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_192 ? _slots_17_io_out_uop_rob_idx : _GEN_191 ? _slots_16_io_out_uop_rob_idx : _GEN_190 ? _slots_15_io_out_uop_rob_idx : _slots_14_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_192 ? _slots_17_io_out_uop_ldq_idx : _GEN_191 ? _slots_16_io_out_uop_ldq_idx : _GEN_190 ? _slots_15_io_out_uop_ldq_idx : _slots_14_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_192 ? _slots_17_io_out_uop_stq_idx : _GEN_191 ? _slots_16_io_out_uop_stq_idx : _GEN_190 ? _slots_15_io_out_uop_stq_idx : _slots_14_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_192 ? _slots_17_io_out_uop_pdst : _GEN_191 ? _slots_16_io_out_uop_pdst : _GEN_190 ? _slots_15_io_out_uop_pdst : _slots_14_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_192 ? _slots_17_io_out_uop_prs1 : _GEN_191 ? _slots_16_io_out_uop_prs1 : _GEN_190 ? _slots_15_io_out_uop_prs1 : _slots_14_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_192 ? _slots_17_io_out_uop_prs2 : _GEN_191 ? _slots_16_io_out_uop_prs2 : _GEN_190 ? _slots_15_io_out_uop_prs2 : _slots_14_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_192 ? _slots_17_io_out_uop_prs3 : _GEN_191 ? _slots_16_io_out_uop_prs3 : _GEN_190 ? _slots_15_io_out_uop_prs3 : _slots_14_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_192 ? _slots_17_io_out_uop_prs1_busy : _GEN_191 ? _slots_16_io_out_uop_prs1_busy : _GEN_190 ? _slots_15_io_out_uop_prs1_busy : _slots_14_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_192 ? _slots_17_io_out_uop_prs2_busy : _GEN_191 ? _slots_16_io_out_uop_prs2_busy : _GEN_190 ? _slots_15_io_out_uop_prs2_busy : _slots_14_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_192 ? _slots_17_io_out_uop_prs3_busy : _GEN_191 ? _slots_16_io_out_uop_prs3_busy : _GEN_190 ? _slots_15_io_out_uop_prs3_busy : _slots_14_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_192 ? _slots_17_io_out_uop_ppred_busy : _GEN_191 ? _slots_16_io_out_uop_ppred_busy : _GEN_190 ? _slots_15_io_out_uop_ppred_busy : _slots_14_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_192 ? _slots_17_io_out_uop_bypassable : _GEN_191 ? _slots_16_io_out_uop_bypassable : _GEN_190 ? _slots_15_io_out_uop_bypassable : _slots_14_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_192 ? _slots_17_io_out_uop_mem_cmd : _GEN_191 ? _slots_16_io_out_uop_mem_cmd : _GEN_190 ? _slots_15_io_out_uop_mem_cmd : _slots_14_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_192 ? _slots_17_io_out_uop_mem_size : _GEN_191 ? _slots_16_io_out_uop_mem_size : _GEN_190 ? _slots_15_io_out_uop_mem_size : _slots_14_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_192 ? _slots_17_io_out_uop_mem_signed : _GEN_191 ? _slots_16_io_out_uop_mem_signed : _GEN_190 ? _slots_15_io_out_uop_mem_signed : _slots_14_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_192 ? _slots_17_io_out_uop_is_fence : _GEN_191 ? _slots_16_io_out_uop_is_fence : _GEN_190 ? _slots_15_io_out_uop_is_fence : _slots_14_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_192 ? _slots_17_io_out_uop_is_amo : _GEN_191 ? _slots_16_io_out_uop_is_amo : _GEN_190 ? _slots_15_io_out_uop_is_amo : _slots_14_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_192 ? _slots_17_io_out_uop_uses_ldq : _GEN_191 ? _slots_16_io_out_uop_uses_ldq : _GEN_190 ? _slots_15_io_out_uop_uses_ldq : _slots_14_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_192 ? _slots_17_io_out_uop_uses_stq : _GEN_191 ? _slots_16_io_out_uop_uses_stq : _GEN_190 ? _slots_15_io_out_uop_uses_stq : _slots_14_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_192 ? _slots_17_io_out_uop_ldst_val : _GEN_191 ? _slots_16_io_out_uop_ldst_val : _GEN_190 ? _slots_15_io_out_uop_ldst_val : _slots_14_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_192 ? _slots_17_io_out_uop_dst_rtype : _GEN_191 ? _slots_16_io_out_uop_dst_rtype : _GEN_190 ? _slots_15_io_out_uop_dst_rtype : _slots_14_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_192 ? _slots_17_io_out_uop_lrs1_rtype : _GEN_191 ? _slots_16_io_out_uop_lrs1_rtype : _GEN_190 ? _slots_15_io_out_uop_lrs1_rtype : _slots_14_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_192 ? _slots_17_io_out_uop_lrs2_rtype : _GEN_191 ? _slots_16_io_out_uop_lrs2_rtype : _GEN_190 ? _slots_15_io_out_uop_lrs2_rtype : _slots_14_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_192 ? _slots_17_io_out_uop_fp_val : _GEN_191 ? _slots_16_io_out_uop_fp_val : _GEN_190 ? _slots_15_io_out_uop_fp_val : _slots_14_io_out_uop_fp_val),
    .io_valid                       (_slots_13_io_valid),
    .io_will_be_valid               (_slots_13_io_will_be_valid),
    .io_request                     (_slots_13_io_request),
    .io_out_uop_uopc                (_slots_13_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_13_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_13_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_13_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_13_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_13_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_13_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_13_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_13_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_13_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_13_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_13_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_13_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_13_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_13_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_13_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_13_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_13_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_13_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_13_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_13_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_13_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_13_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_13_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_13_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_13_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_13_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_13_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_13_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_13_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_13_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_13_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_13_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_13_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_13_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_13_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_13_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_13_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_13_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_13_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_13_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_13_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_13_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_13_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_13_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_13_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_13_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_13_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_13_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_13_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_13_io_uop_pdst),
    .io_uop_prs1                    (_slots_13_io_uop_prs1),
    .io_uop_prs2                    (_slots_13_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_13_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_13_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_13_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_13_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_13_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_13_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_13_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_13_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_13_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_13_io_uop_fp_val)
  );
  IssueSlot_32 slots_14 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_14_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_47),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_14_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_195 ? _slots_18_io_out_uop_uopc : _GEN_194 ? _slots_17_io_out_uop_uopc : _GEN_193 ? _slots_16_io_out_uop_uopc : _slots_15_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_195 ? _slots_18_io_out_uop_is_rvc : _GEN_194 ? _slots_17_io_out_uop_is_rvc : _GEN_193 ? _slots_16_io_out_uop_is_rvc : _slots_15_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_195 ? _slots_18_io_out_uop_fu_code : _GEN_194 ? _slots_17_io_out_uop_fu_code : _GEN_193 ? _slots_16_io_out_uop_fu_code : _slots_15_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_195 ? _slots_18_io_out_uop_iw_state : _GEN_194 ? _slots_17_io_out_uop_iw_state : _GEN_193 ? _slots_16_io_out_uop_iw_state : _slots_15_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_195 ? _slots_18_io_out_uop_iw_p1_poisoned : _GEN_194 ? _slots_17_io_out_uop_iw_p1_poisoned : _GEN_193 ? _slots_16_io_out_uop_iw_p1_poisoned : _slots_15_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_195 ? _slots_18_io_out_uop_iw_p2_poisoned : _GEN_194 ? _slots_17_io_out_uop_iw_p2_poisoned : _GEN_193 ? _slots_16_io_out_uop_iw_p2_poisoned : _slots_15_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_195 ? _slots_18_io_out_uop_is_br : _GEN_194 ? _slots_17_io_out_uop_is_br : _GEN_193 ? _slots_16_io_out_uop_is_br : _slots_15_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_195 ? _slots_18_io_out_uop_is_jalr : _GEN_194 ? _slots_17_io_out_uop_is_jalr : _GEN_193 ? _slots_16_io_out_uop_is_jalr : _slots_15_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_195 ? _slots_18_io_out_uop_is_jal : _GEN_194 ? _slots_17_io_out_uop_is_jal : _GEN_193 ? _slots_16_io_out_uop_is_jal : _slots_15_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_195 ? _slots_18_io_out_uop_is_sfb : _GEN_194 ? _slots_17_io_out_uop_is_sfb : _GEN_193 ? _slots_16_io_out_uop_is_sfb : _slots_15_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_195 ? _slots_18_io_out_uop_br_mask : _GEN_194 ? _slots_17_io_out_uop_br_mask : _GEN_193 ? _slots_16_io_out_uop_br_mask : _slots_15_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_195 ? _slots_18_io_out_uop_br_tag : _GEN_194 ? _slots_17_io_out_uop_br_tag : _GEN_193 ? _slots_16_io_out_uop_br_tag : _slots_15_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_195 ? _slots_18_io_out_uop_ftq_idx : _GEN_194 ? _slots_17_io_out_uop_ftq_idx : _GEN_193 ? _slots_16_io_out_uop_ftq_idx : _slots_15_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_195 ? _slots_18_io_out_uop_edge_inst : _GEN_194 ? _slots_17_io_out_uop_edge_inst : _GEN_193 ? _slots_16_io_out_uop_edge_inst : _slots_15_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_195 ? _slots_18_io_out_uop_pc_lob : _GEN_194 ? _slots_17_io_out_uop_pc_lob : _GEN_193 ? _slots_16_io_out_uop_pc_lob : _slots_15_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_195 ? _slots_18_io_out_uop_taken : _GEN_194 ? _slots_17_io_out_uop_taken : _GEN_193 ? _slots_16_io_out_uop_taken : _slots_15_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_195 ? _slots_18_io_out_uop_imm_packed : _GEN_194 ? _slots_17_io_out_uop_imm_packed : _GEN_193 ? _slots_16_io_out_uop_imm_packed : _slots_15_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_195 ? _slots_18_io_out_uop_rob_idx : _GEN_194 ? _slots_17_io_out_uop_rob_idx : _GEN_193 ? _slots_16_io_out_uop_rob_idx : _slots_15_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_195 ? _slots_18_io_out_uop_ldq_idx : _GEN_194 ? _slots_17_io_out_uop_ldq_idx : _GEN_193 ? _slots_16_io_out_uop_ldq_idx : _slots_15_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_195 ? _slots_18_io_out_uop_stq_idx : _GEN_194 ? _slots_17_io_out_uop_stq_idx : _GEN_193 ? _slots_16_io_out_uop_stq_idx : _slots_15_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_195 ? _slots_18_io_out_uop_pdst : _GEN_194 ? _slots_17_io_out_uop_pdst : _GEN_193 ? _slots_16_io_out_uop_pdst : _slots_15_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_195 ? _slots_18_io_out_uop_prs1 : _GEN_194 ? _slots_17_io_out_uop_prs1 : _GEN_193 ? _slots_16_io_out_uop_prs1 : _slots_15_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_195 ? _slots_18_io_out_uop_prs2 : _GEN_194 ? _slots_17_io_out_uop_prs2 : _GEN_193 ? _slots_16_io_out_uop_prs2 : _slots_15_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_195 ? _slots_18_io_out_uop_prs3 : _GEN_194 ? _slots_17_io_out_uop_prs3 : _GEN_193 ? _slots_16_io_out_uop_prs3 : _slots_15_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_195 ? _slots_18_io_out_uop_prs1_busy : _GEN_194 ? _slots_17_io_out_uop_prs1_busy : _GEN_193 ? _slots_16_io_out_uop_prs1_busy : _slots_15_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_195 ? _slots_18_io_out_uop_prs2_busy : _GEN_194 ? _slots_17_io_out_uop_prs2_busy : _GEN_193 ? _slots_16_io_out_uop_prs2_busy : _slots_15_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_195 ? _slots_18_io_out_uop_prs3_busy : _GEN_194 ? _slots_17_io_out_uop_prs3_busy : _GEN_193 ? _slots_16_io_out_uop_prs3_busy : _slots_15_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_195 ? _slots_18_io_out_uop_ppred_busy : _GEN_194 ? _slots_17_io_out_uop_ppred_busy : _GEN_193 ? _slots_16_io_out_uop_ppred_busy : _slots_15_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_195 ? _slots_18_io_out_uop_bypassable : _GEN_194 ? _slots_17_io_out_uop_bypassable : _GEN_193 ? _slots_16_io_out_uop_bypassable : _slots_15_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_195 ? _slots_18_io_out_uop_mem_cmd : _GEN_194 ? _slots_17_io_out_uop_mem_cmd : _GEN_193 ? _slots_16_io_out_uop_mem_cmd : _slots_15_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_195 ? _slots_18_io_out_uop_mem_size : _GEN_194 ? _slots_17_io_out_uop_mem_size : _GEN_193 ? _slots_16_io_out_uop_mem_size : _slots_15_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_195 ? _slots_18_io_out_uop_mem_signed : _GEN_194 ? _slots_17_io_out_uop_mem_signed : _GEN_193 ? _slots_16_io_out_uop_mem_signed : _slots_15_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_195 ? _slots_18_io_out_uop_is_fence : _GEN_194 ? _slots_17_io_out_uop_is_fence : _GEN_193 ? _slots_16_io_out_uop_is_fence : _slots_15_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_195 ? _slots_18_io_out_uop_is_amo : _GEN_194 ? _slots_17_io_out_uop_is_amo : _GEN_193 ? _slots_16_io_out_uop_is_amo : _slots_15_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_195 ? _slots_18_io_out_uop_uses_ldq : _GEN_194 ? _slots_17_io_out_uop_uses_ldq : _GEN_193 ? _slots_16_io_out_uop_uses_ldq : _slots_15_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_195 ? _slots_18_io_out_uop_uses_stq : _GEN_194 ? _slots_17_io_out_uop_uses_stq : _GEN_193 ? _slots_16_io_out_uop_uses_stq : _slots_15_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_195 ? _slots_18_io_out_uop_ldst_val : _GEN_194 ? _slots_17_io_out_uop_ldst_val : _GEN_193 ? _slots_16_io_out_uop_ldst_val : _slots_15_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_195 ? _slots_18_io_out_uop_dst_rtype : _GEN_194 ? _slots_17_io_out_uop_dst_rtype : _GEN_193 ? _slots_16_io_out_uop_dst_rtype : _slots_15_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_195 ? _slots_18_io_out_uop_lrs1_rtype : _GEN_194 ? _slots_17_io_out_uop_lrs1_rtype : _GEN_193 ? _slots_16_io_out_uop_lrs1_rtype : _slots_15_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_195 ? _slots_18_io_out_uop_lrs2_rtype : _GEN_194 ? _slots_17_io_out_uop_lrs2_rtype : _GEN_193 ? _slots_16_io_out_uop_lrs2_rtype : _slots_15_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_195 ? _slots_18_io_out_uop_fp_val : _GEN_194 ? _slots_17_io_out_uop_fp_val : _GEN_193 ? _slots_16_io_out_uop_fp_val : _slots_15_io_out_uop_fp_val),
    .io_valid                       (_slots_14_io_valid),
    .io_will_be_valid               (_slots_14_io_will_be_valid),
    .io_request                     (_slots_14_io_request),
    .io_out_uop_uopc                (_slots_14_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_14_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_14_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_14_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_14_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_14_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_14_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_14_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_14_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_14_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_14_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_14_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_14_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_14_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_14_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_14_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_14_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_14_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_14_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_14_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_14_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_14_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_14_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_14_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_14_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_14_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_14_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_14_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_14_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_14_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_14_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_14_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_14_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_14_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_14_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_14_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_14_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_14_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_14_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_14_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_14_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_14_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_14_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_14_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_14_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_14_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_14_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_14_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_14_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_14_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_14_io_uop_pdst),
    .io_uop_prs1                    (_slots_14_io_uop_prs1),
    .io_uop_prs2                    (_slots_14_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_14_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_14_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_14_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_14_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_14_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_14_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_14_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_14_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_14_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_14_io_uop_fp_val)
  );
  IssueSlot_32 slots_15 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_15_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_49),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_15_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_198 ? _slots_19_io_out_uop_uopc : _GEN_197 ? _slots_18_io_out_uop_uopc : _GEN_196 ? _slots_17_io_out_uop_uopc : _slots_16_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_198 ? _slots_19_io_out_uop_is_rvc : _GEN_197 ? _slots_18_io_out_uop_is_rvc : _GEN_196 ? _slots_17_io_out_uop_is_rvc : _slots_16_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_198 ? _slots_19_io_out_uop_fu_code : _GEN_197 ? _slots_18_io_out_uop_fu_code : _GEN_196 ? _slots_17_io_out_uop_fu_code : _slots_16_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_198 ? _slots_19_io_out_uop_iw_state : _GEN_197 ? _slots_18_io_out_uop_iw_state : _GEN_196 ? _slots_17_io_out_uop_iw_state : _slots_16_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_198 ? _slots_19_io_out_uop_iw_p1_poisoned : _GEN_197 ? _slots_18_io_out_uop_iw_p1_poisoned : _GEN_196 ? _slots_17_io_out_uop_iw_p1_poisoned : _slots_16_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_198 ? _slots_19_io_out_uop_iw_p2_poisoned : _GEN_197 ? _slots_18_io_out_uop_iw_p2_poisoned : _GEN_196 ? _slots_17_io_out_uop_iw_p2_poisoned : _slots_16_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_198 ? _slots_19_io_out_uop_is_br : _GEN_197 ? _slots_18_io_out_uop_is_br : _GEN_196 ? _slots_17_io_out_uop_is_br : _slots_16_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_198 ? _slots_19_io_out_uop_is_jalr : _GEN_197 ? _slots_18_io_out_uop_is_jalr : _GEN_196 ? _slots_17_io_out_uop_is_jalr : _slots_16_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_198 ? _slots_19_io_out_uop_is_jal : _GEN_197 ? _slots_18_io_out_uop_is_jal : _GEN_196 ? _slots_17_io_out_uop_is_jal : _slots_16_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_198 ? _slots_19_io_out_uop_is_sfb : _GEN_197 ? _slots_18_io_out_uop_is_sfb : _GEN_196 ? _slots_17_io_out_uop_is_sfb : _slots_16_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_198 ? _slots_19_io_out_uop_br_mask : _GEN_197 ? _slots_18_io_out_uop_br_mask : _GEN_196 ? _slots_17_io_out_uop_br_mask : _slots_16_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_198 ? _slots_19_io_out_uop_br_tag : _GEN_197 ? _slots_18_io_out_uop_br_tag : _GEN_196 ? _slots_17_io_out_uop_br_tag : _slots_16_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_198 ? _slots_19_io_out_uop_ftq_idx : _GEN_197 ? _slots_18_io_out_uop_ftq_idx : _GEN_196 ? _slots_17_io_out_uop_ftq_idx : _slots_16_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_198 ? _slots_19_io_out_uop_edge_inst : _GEN_197 ? _slots_18_io_out_uop_edge_inst : _GEN_196 ? _slots_17_io_out_uop_edge_inst : _slots_16_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_198 ? _slots_19_io_out_uop_pc_lob : _GEN_197 ? _slots_18_io_out_uop_pc_lob : _GEN_196 ? _slots_17_io_out_uop_pc_lob : _slots_16_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_198 ? _slots_19_io_out_uop_taken : _GEN_197 ? _slots_18_io_out_uop_taken : _GEN_196 ? _slots_17_io_out_uop_taken : _slots_16_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_198 ? _slots_19_io_out_uop_imm_packed : _GEN_197 ? _slots_18_io_out_uop_imm_packed : _GEN_196 ? _slots_17_io_out_uop_imm_packed : _slots_16_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_198 ? _slots_19_io_out_uop_rob_idx : _GEN_197 ? _slots_18_io_out_uop_rob_idx : _GEN_196 ? _slots_17_io_out_uop_rob_idx : _slots_16_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_198 ? _slots_19_io_out_uop_ldq_idx : _GEN_197 ? _slots_18_io_out_uop_ldq_idx : _GEN_196 ? _slots_17_io_out_uop_ldq_idx : _slots_16_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_198 ? _slots_19_io_out_uop_stq_idx : _GEN_197 ? _slots_18_io_out_uop_stq_idx : _GEN_196 ? _slots_17_io_out_uop_stq_idx : _slots_16_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_198 ? _slots_19_io_out_uop_pdst : _GEN_197 ? _slots_18_io_out_uop_pdst : _GEN_196 ? _slots_17_io_out_uop_pdst : _slots_16_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_198 ? _slots_19_io_out_uop_prs1 : _GEN_197 ? _slots_18_io_out_uop_prs1 : _GEN_196 ? _slots_17_io_out_uop_prs1 : _slots_16_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_198 ? _slots_19_io_out_uop_prs2 : _GEN_197 ? _slots_18_io_out_uop_prs2 : _GEN_196 ? _slots_17_io_out_uop_prs2 : _slots_16_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_198 ? _slots_19_io_out_uop_prs3 : _GEN_197 ? _slots_18_io_out_uop_prs3 : _GEN_196 ? _slots_17_io_out_uop_prs3 : _slots_16_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_198 ? _slots_19_io_out_uop_prs1_busy : _GEN_197 ? _slots_18_io_out_uop_prs1_busy : _GEN_196 ? _slots_17_io_out_uop_prs1_busy : _slots_16_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_198 ? _slots_19_io_out_uop_prs2_busy : _GEN_197 ? _slots_18_io_out_uop_prs2_busy : _GEN_196 ? _slots_17_io_out_uop_prs2_busy : _slots_16_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_198 ? _slots_19_io_out_uop_prs3_busy : _GEN_197 ? _slots_18_io_out_uop_prs3_busy : _GEN_196 ? _slots_17_io_out_uop_prs3_busy : _slots_16_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_198 ? _slots_19_io_out_uop_ppred_busy : _GEN_197 ? _slots_18_io_out_uop_ppred_busy : _GEN_196 ? _slots_17_io_out_uop_ppred_busy : _slots_16_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_198 ? _slots_19_io_out_uop_bypassable : _GEN_197 ? _slots_18_io_out_uop_bypassable : _GEN_196 ? _slots_17_io_out_uop_bypassable : _slots_16_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_198 ? _slots_19_io_out_uop_mem_cmd : _GEN_197 ? _slots_18_io_out_uop_mem_cmd : _GEN_196 ? _slots_17_io_out_uop_mem_cmd : _slots_16_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_198 ? _slots_19_io_out_uop_mem_size : _GEN_197 ? _slots_18_io_out_uop_mem_size : _GEN_196 ? _slots_17_io_out_uop_mem_size : _slots_16_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_198 ? _slots_19_io_out_uop_mem_signed : _GEN_197 ? _slots_18_io_out_uop_mem_signed : _GEN_196 ? _slots_17_io_out_uop_mem_signed : _slots_16_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_198 ? _slots_19_io_out_uop_is_fence : _GEN_197 ? _slots_18_io_out_uop_is_fence : _GEN_196 ? _slots_17_io_out_uop_is_fence : _slots_16_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_198 ? _slots_19_io_out_uop_is_amo : _GEN_197 ? _slots_18_io_out_uop_is_amo : _GEN_196 ? _slots_17_io_out_uop_is_amo : _slots_16_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_198 ? _slots_19_io_out_uop_uses_ldq : _GEN_197 ? _slots_18_io_out_uop_uses_ldq : _GEN_196 ? _slots_17_io_out_uop_uses_ldq : _slots_16_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_198 ? _slots_19_io_out_uop_uses_stq : _GEN_197 ? _slots_18_io_out_uop_uses_stq : _GEN_196 ? _slots_17_io_out_uop_uses_stq : _slots_16_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_198 ? _slots_19_io_out_uop_ldst_val : _GEN_197 ? _slots_18_io_out_uop_ldst_val : _GEN_196 ? _slots_17_io_out_uop_ldst_val : _slots_16_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_198 ? _slots_19_io_out_uop_dst_rtype : _GEN_197 ? _slots_18_io_out_uop_dst_rtype : _GEN_196 ? _slots_17_io_out_uop_dst_rtype : _slots_16_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_198 ? _slots_19_io_out_uop_lrs1_rtype : _GEN_197 ? _slots_18_io_out_uop_lrs1_rtype : _GEN_196 ? _slots_17_io_out_uop_lrs1_rtype : _slots_16_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_198 ? _slots_19_io_out_uop_lrs2_rtype : _GEN_197 ? _slots_18_io_out_uop_lrs2_rtype : _GEN_196 ? _slots_17_io_out_uop_lrs2_rtype : _slots_16_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_198 ? _slots_19_io_out_uop_fp_val : _GEN_197 ? _slots_18_io_out_uop_fp_val : _GEN_196 ? _slots_17_io_out_uop_fp_val : _slots_16_io_out_uop_fp_val),
    .io_valid                       (_slots_15_io_valid),
    .io_will_be_valid               (_slots_15_io_will_be_valid),
    .io_request                     (_slots_15_io_request),
    .io_out_uop_uopc                (_slots_15_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_15_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_15_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_15_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_15_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_15_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_15_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_15_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_15_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_15_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_15_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_15_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_15_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_15_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_15_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_15_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_15_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_15_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_15_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_15_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_15_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_15_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_15_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_15_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_15_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_15_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_15_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_15_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_15_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_15_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_15_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_15_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_15_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_15_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_15_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_15_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_15_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_15_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_15_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_15_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_15_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_15_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_15_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_15_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_15_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_15_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_15_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_15_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_15_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_15_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_15_io_uop_pdst),
    .io_uop_prs1                    (_slots_15_io_uop_prs1),
    .io_uop_prs2                    (_slots_15_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_15_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_15_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_15_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_15_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_15_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_15_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_15_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_15_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_15_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_15_io_uop_fp_val)
  );
  IssueSlot_32 slots_16 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_16_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_51),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_16_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_201 ? _slots_20_io_out_uop_uopc : _GEN_200 ? _slots_19_io_out_uop_uopc : _GEN_199 ? _slots_18_io_out_uop_uopc : _slots_17_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_201 ? _slots_20_io_out_uop_is_rvc : _GEN_200 ? _slots_19_io_out_uop_is_rvc : _GEN_199 ? _slots_18_io_out_uop_is_rvc : _slots_17_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_201 ? _slots_20_io_out_uop_fu_code : _GEN_200 ? _slots_19_io_out_uop_fu_code : _GEN_199 ? _slots_18_io_out_uop_fu_code : _slots_17_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_201 ? _slots_20_io_out_uop_iw_state : _GEN_200 ? _slots_19_io_out_uop_iw_state : _GEN_199 ? _slots_18_io_out_uop_iw_state : _slots_17_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_201 ? _slots_20_io_out_uop_iw_p1_poisoned : _GEN_200 ? _slots_19_io_out_uop_iw_p1_poisoned : _GEN_199 ? _slots_18_io_out_uop_iw_p1_poisoned : _slots_17_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_201 ? _slots_20_io_out_uop_iw_p2_poisoned : _GEN_200 ? _slots_19_io_out_uop_iw_p2_poisoned : _GEN_199 ? _slots_18_io_out_uop_iw_p2_poisoned : _slots_17_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_201 ? _slots_20_io_out_uop_is_br : _GEN_200 ? _slots_19_io_out_uop_is_br : _GEN_199 ? _slots_18_io_out_uop_is_br : _slots_17_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_201 ? _slots_20_io_out_uop_is_jalr : _GEN_200 ? _slots_19_io_out_uop_is_jalr : _GEN_199 ? _slots_18_io_out_uop_is_jalr : _slots_17_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_201 ? _slots_20_io_out_uop_is_jal : _GEN_200 ? _slots_19_io_out_uop_is_jal : _GEN_199 ? _slots_18_io_out_uop_is_jal : _slots_17_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_201 ? _slots_20_io_out_uop_is_sfb : _GEN_200 ? _slots_19_io_out_uop_is_sfb : _GEN_199 ? _slots_18_io_out_uop_is_sfb : _slots_17_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_201 ? _slots_20_io_out_uop_br_mask : _GEN_200 ? _slots_19_io_out_uop_br_mask : _GEN_199 ? _slots_18_io_out_uop_br_mask : _slots_17_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_201 ? _slots_20_io_out_uop_br_tag : _GEN_200 ? _slots_19_io_out_uop_br_tag : _GEN_199 ? _slots_18_io_out_uop_br_tag : _slots_17_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_201 ? _slots_20_io_out_uop_ftq_idx : _GEN_200 ? _slots_19_io_out_uop_ftq_idx : _GEN_199 ? _slots_18_io_out_uop_ftq_idx : _slots_17_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_201 ? _slots_20_io_out_uop_edge_inst : _GEN_200 ? _slots_19_io_out_uop_edge_inst : _GEN_199 ? _slots_18_io_out_uop_edge_inst : _slots_17_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_201 ? _slots_20_io_out_uop_pc_lob : _GEN_200 ? _slots_19_io_out_uop_pc_lob : _GEN_199 ? _slots_18_io_out_uop_pc_lob : _slots_17_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_201 ? _slots_20_io_out_uop_taken : _GEN_200 ? _slots_19_io_out_uop_taken : _GEN_199 ? _slots_18_io_out_uop_taken : _slots_17_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_201 ? _slots_20_io_out_uop_imm_packed : _GEN_200 ? _slots_19_io_out_uop_imm_packed : _GEN_199 ? _slots_18_io_out_uop_imm_packed : _slots_17_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_201 ? _slots_20_io_out_uop_rob_idx : _GEN_200 ? _slots_19_io_out_uop_rob_idx : _GEN_199 ? _slots_18_io_out_uop_rob_idx : _slots_17_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_201 ? _slots_20_io_out_uop_ldq_idx : _GEN_200 ? _slots_19_io_out_uop_ldq_idx : _GEN_199 ? _slots_18_io_out_uop_ldq_idx : _slots_17_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_201 ? _slots_20_io_out_uop_stq_idx : _GEN_200 ? _slots_19_io_out_uop_stq_idx : _GEN_199 ? _slots_18_io_out_uop_stq_idx : _slots_17_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_201 ? _slots_20_io_out_uop_pdst : _GEN_200 ? _slots_19_io_out_uop_pdst : _GEN_199 ? _slots_18_io_out_uop_pdst : _slots_17_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_201 ? _slots_20_io_out_uop_prs1 : _GEN_200 ? _slots_19_io_out_uop_prs1 : _GEN_199 ? _slots_18_io_out_uop_prs1 : _slots_17_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_201 ? _slots_20_io_out_uop_prs2 : _GEN_200 ? _slots_19_io_out_uop_prs2 : _GEN_199 ? _slots_18_io_out_uop_prs2 : _slots_17_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_201 ? _slots_20_io_out_uop_prs3 : _GEN_200 ? _slots_19_io_out_uop_prs3 : _GEN_199 ? _slots_18_io_out_uop_prs3 : _slots_17_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_201 ? _slots_20_io_out_uop_prs1_busy : _GEN_200 ? _slots_19_io_out_uop_prs1_busy : _GEN_199 ? _slots_18_io_out_uop_prs1_busy : _slots_17_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_201 ? _slots_20_io_out_uop_prs2_busy : _GEN_200 ? _slots_19_io_out_uop_prs2_busy : _GEN_199 ? _slots_18_io_out_uop_prs2_busy : _slots_17_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_201 ? _slots_20_io_out_uop_prs3_busy : _GEN_200 ? _slots_19_io_out_uop_prs3_busy : _GEN_199 ? _slots_18_io_out_uop_prs3_busy : _slots_17_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_201 ? _slots_20_io_out_uop_ppred_busy : _GEN_200 ? _slots_19_io_out_uop_ppred_busy : _GEN_199 ? _slots_18_io_out_uop_ppred_busy : _slots_17_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_201 ? _slots_20_io_out_uop_bypassable : _GEN_200 ? _slots_19_io_out_uop_bypassable : _GEN_199 ? _slots_18_io_out_uop_bypassable : _slots_17_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_201 ? _slots_20_io_out_uop_mem_cmd : _GEN_200 ? _slots_19_io_out_uop_mem_cmd : _GEN_199 ? _slots_18_io_out_uop_mem_cmd : _slots_17_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_201 ? _slots_20_io_out_uop_mem_size : _GEN_200 ? _slots_19_io_out_uop_mem_size : _GEN_199 ? _slots_18_io_out_uop_mem_size : _slots_17_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_201 ? _slots_20_io_out_uop_mem_signed : _GEN_200 ? _slots_19_io_out_uop_mem_signed : _GEN_199 ? _slots_18_io_out_uop_mem_signed : _slots_17_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_201 ? _slots_20_io_out_uop_is_fence : _GEN_200 ? _slots_19_io_out_uop_is_fence : _GEN_199 ? _slots_18_io_out_uop_is_fence : _slots_17_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_201 ? _slots_20_io_out_uop_is_amo : _GEN_200 ? _slots_19_io_out_uop_is_amo : _GEN_199 ? _slots_18_io_out_uop_is_amo : _slots_17_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_201 ? _slots_20_io_out_uop_uses_ldq : _GEN_200 ? _slots_19_io_out_uop_uses_ldq : _GEN_199 ? _slots_18_io_out_uop_uses_ldq : _slots_17_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_201 ? _slots_20_io_out_uop_uses_stq : _GEN_200 ? _slots_19_io_out_uop_uses_stq : _GEN_199 ? _slots_18_io_out_uop_uses_stq : _slots_17_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_201 ? _slots_20_io_out_uop_ldst_val : _GEN_200 ? _slots_19_io_out_uop_ldst_val : _GEN_199 ? _slots_18_io_out_uop_ldst_val : _slots_17_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_201 ? _slots_20_io_out_uop_dst_rtype : _GEN_200 ? _slots_19_io_out_uop_dst_rtype : _GEN_199 ? _slots_18_io_out_uop_dst_rtype : _slots_17_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_201 ? _slots_20_io_out_uop_lrs1_rtype : _GEN_200 ? _slots_19_io_out_uop_lrs1_rtype : _GEN_199 ? _slots_18_io_out_uop_lrs1_rtype : _slots_17_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_201 ? _slots_20_io_out_uop_lrs2_rtype : _GEN_200 ? _slots_19_io_out_uop_lrs2_rtype : _GEN_199 ? _slots_18_io_out_uop_lrs2_rtype : _slots_17_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_201 ? _slots_20_io_out_uop_fp_val : _GEN_200 ? _slots_19_io_out_uop_fp_val : _GEN_199 ? _slots_18_io_out_uop_fp_val : _slots_17_io_out_uop_fp_val),
    .io_valid                       (_slots_16_io_valid),
    .io_will_be_valid               (_slots_16_io_will_be_valid),
    .io_request                     (_slots_16_io_request),
    .io_out_uop_uopc                (_slots_16_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_16_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_16_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_16_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_16_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_16_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_16_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_16_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_16_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_16_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_16_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_16_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_16_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_16_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_16_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_16_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_16_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_16_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_16_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_16_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_16_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_16_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_16_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_16_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_16_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_16_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_16_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_16_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_16_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_16_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_16_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_16_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_16_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_16_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_16_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_16_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_16_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_16_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_16_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_16_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_16_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_16_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_16_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_16_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_16_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_16_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_16_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_16_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_16_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_16_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_16_io_uop_pdst),
    .io_uop_prs1                    (_slots_16_io_uop_prs1),
    .io_uop_prs2                    (_slots_16_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_16_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_16_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_16_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_16_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_16_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_16_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_16_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_16_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_16_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_16_io_uop_fp_val)
  );
  IssueSlot_32 slots_17 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_17_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_53),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_17_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_204 ? _slots_21_io_out_uop_uopc : _GEN_203 ? _slots_20_io_out_uop_uopc : _GEN_202 ? _slots_19_io_out_uop_uopc : _slots_18_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_204 ? _slots_21_io_out_uop_is_rvc : _GEN_203 ? _slots_20_io_out_uop_is_rvc : _GEN_202 ? _slots_19_io_out_uop_is_rvc : _slots_18_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_204 ? _slots_21_io_out_uop_fu_code : _GEN_203 ? _slots_20_io_out_uop_fu_code : _GEN_202 ? _slots_19_io_out_uop_fu_code : _slots_18_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_204 ? _slots_21_io_out_uop_iw_state : _GEN_203 ? _slots_20_io_out_uop_iw_state : _GEN_202 ? _slots_19_io_out_uop_iw_state : _slots_18_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_204 ? _slots_21_io_out_uop_iw_p1_poisoned : _GEN_203 ? _slots_20_io_out_uop_iw_p1_poisoned : _GEN_202 ? _slots_19_io_out_uop_iw_p1_poisoned : _slots_18_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_204 ? _slots_21_io_out_uop_iw_p2_poisoned : _GEN_203 ? _slots_20_io_out_uop_iw_p2_poisoned : _GEN_202 ? _slots_19_io_out_uop_iw_p2_poisoned : _slots_18_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_204 ? _slots_21_io_out_uop_is_br : _GEN_203 ? _slots_20_io_out_uop_is_br : _GEN_202 ? _slots_19_io_out_uop_is_br : _slots_18_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_204 ? _slots_21_io_out_uop_is_jalr : _GEN_203 ? _slots_20_io_out_uop_is_jalr : _GEN_202 ? _slots_19_io_out_uop_is_jalr : _slots_18_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_204 ? _slots_21_io_out_uop_is_jal : _GEN_203 ? _slots_20_io_out_uop_is_jal : _GEN_202 ? _slots_19_io_out_uop_is_jal : _slots_18_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_204 ? _slots_21_io_out_uop_is_sfb : _GEN_203 ? _slots_20_io_out_uop_is_sfb : _GEN_202 ? _slots_19_io_out_uop_is_sfb : _slots_18_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_204 ? _slots_21_io_out_uop_br_mask : _GEN_203 ? _slots_20_io_out_uop_br_mask : _GEN_202 ? _slots_19_io_out_uop_br_mask : _slots_18_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_204 ? _slots_21_io_out_uop_br_tag : _GEN_203 ? _slots_20_io_out_uop_br_tag : _GEN_202 ? _slots_19_io_out_uop_br_tag : _slots_18_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_204 ? _slots_21_io_out_uop_ftq_idx : _GEN_203 ? _slots_20_io_out_uop_ftq_idx : _GEN_202 ? _slots_19_io_out_uop_ftq_idx : _slots_18_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_204 ? _slots_21_io_out_uop_edge_inst : _GEN_203 ? _slots_20_io_out_uop_edge_inst : _GEN_202 ? _slots_19_io_out_uop_edge_inst : _slots_18_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_204 ? _slots_21_io_out_uop_pc_lob : _GEN_203 ? _slots_20_io_out_uop_pc_lob : _GEN_202 ? _slots_19_io_out_uop_pc_lob : _slots_18_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_204 ? _slots_21_io_out_uop_taken : _GEN_203 ? _slots_20_io_out_uop_taken : _GEN_202 ? _slots_19_io_out_uop_taken : _slots_18_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_204 ? _slots_21_io_out_uop_imm_packed : _GEN_203 ? _slots_20_io_out_uop_imm_packed : _GEN_202 ? _slots_19_io_out_uop_imm_packed : _slots_18_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_204 ? _slots_21_io_out_uop_rob_idx : _GEN_203 ? _slots_20_io_out_uop_rob_idx : _GEN_202 ? _slots_19_io_out_uop_rob_idx : _slots_18_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_204 ? _slots_21_io_out_uop_ldq_idx : _GEN_203 ? _slots_20_io_out_uop_ldq_idx : _GEN_202 ? _slots_19_io_out_uop_ldq_idx : _slots_18_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_204 ? _slots_21_io_out_uop_stq_idx : _GEN_203 ? _slots_20_io_out_uop_stq_idx : _GEN_202 ? _slots_19_io_out_uop_stq_idx : _slots_18_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_204 ? _slots_21_io_out_uop_pdst : _GEN_203 ? _slots_20_io_out_uop_pdst : _GEN_202 ? _slots_19_io_out_uop_pdst : _slots_18_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_204 ? _slots_21_io_out_uop_prs1 : _GEN_203 ? _slots_20_io_out_uop_prs1 : _GEN_202 ? _slots_19_io_out_uop_prs1 : _slots_18_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_204 ? _slots_21_io_out_uop_prs2 : _GEN_203 ? _slots_20_io_out_uop_prs2 : _GEN_202 ? _slots_19_io_out_uop_prs2 : _slots_18_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_204 ? _slots_21_io_out_uop_prs3 : _GEN_203 ? _slots_20_io_out_uop_prs3 : _GEN_202 ? _slots_19_io_out_uop_prs3 : _slots_18_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_204 ? _slots_21_io_out_uop_prs1_busy : _GEN_203 ? _slots_20_io_out_uop_prs1_busy : _GEN_202 ? _slots_19_io_out_uop_prs1_busy : _slots_18_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_204 ? _slots_21_io_out_uop_prs2_busy : _GEN_203 ? _slots_20_io_out_uop_prs2_busy : _GEN_202 ? _slots_19_io_out_uop_prs2_busy : _slots_18_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_204 ? _slots_21_io_out_uop_prs3_busy : _GEN_203 ? _slots_20_io_out_uop_prs3_busy : _GEN_202 ? _slots_19_io_out_uop_prs3_busy : _slots_18_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_204 ? _slots_21_io_out_uop_ppred_busy : _GEN_203 ? _slots_20_io_out_uop_ppred_busy : _GEN_202 ? _slots_19_io_out_uop_ppred_busy : _slots_18_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_204 ? _slots_21_io_out_uop_bypassable : _GEN_203 ? _slots_20_io_out_uop_bypassable : _GEN_202 ? _slots_19_io_out_uop_bypassable : _slots_18_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_204 ? _slots_21_io_out_uop_mem_cmd : _GEN_203 ? _slots_20_io_out_uop_mem_cmd : _GEN_202 ? _slots_19_io_out_uop_mem_cmd : _slots_18_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_204 ? _slots_21_io_out_uop_mem_size : _GEN_203 ? _slots_20_io_out_uop_mem_size : _GEN_202 ? _slots_19_io_out_uop_mem_size : _slots_18_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_204 ? _slots_21_io_out_uop_mem_signed : _GEN_203 ? _slots_20_io_out_uop_mem_signed : _GEN_202 ? _slots_19_io_out_uop_mem_signed : _slots_18_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_204 ? _slots_21_io_out_uop_is_fence : _GEN_203 ? _slots_20_io_out_uop_is_fence : _GEN_202 ? _slots_19_io_out_uop_is_fence : _slots_18_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_204 ? _slots_21_io_out_uop_is_amo : _GEN_203 ? _slots_20_io_out_uop_is_amo : _GEN_202 ? _slots_19_io_out_uop_is_amo : _slots_18_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_204 ? _slots_21_io_out_uop_uses_ldq : _GEN_203 ? _slots_20_io_out_uop_uses_ldq : _GEN_202 ? _slots_19_io_out_uop_uses_ldq : _slots_18_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_204 ? _slots_21_io_out_uop_uses_stq : _GEN_203 ? _slots_20_io_out_uop_uses_stq : _GEN_202 ? _slots_19_io_out_uop_uses_stq : _slots_18_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_204 ? _slots_21_io_out_uop_ldst_val : _GEN_203 ? _slots_20_io_out_uop_ldst_val : _GEN_202 ? _slots_19_io_out_uop_ldst_val : _slots_18_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_204 ? _slots_21_io_out_uop_dst_rtype : _GEN_203 ? _slots_20_io_out_uop_dst_rtype : _GEN_202 ? _slots_19_io_out_uop_dst_rtype : _slots_18_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_204 ? _slots_21_io_out_uop_lrs1_rtype : _GEN_203 ? _slots_20_io_out_uop_lrs1_rtype : _GEN_202 ? _slots_19_io_out_uop_lrs1_rtype : _slots_18_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_204 ? _slots_21_io_out_uop_lrs2_rtype : _GEN_203 ? _slots_20_io_out_uop_lrs2_rtype : _GEN_202 ? _slots_19_io_out_uop_lrs2_rtype : _slots_18_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_204 ? _slots_21_io_out_uop_fp_val : _GEN_203 ? _slots_20_io_out_uop_fp_val : _GEN_202 ? _slots_19_io_out_uop_fp_val : _slots_18_io_out_uop_fp_val),
    .io_valid                       (_slots_17_io_valid),
    .io_will_be_valid               (_slots_17_io_will_be_valid),
    .io_request                     (_slots_17_io_request),
    .io_out_uop_uopc                (_slots_17_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_17_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_17_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_17_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_17_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_17_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_17_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_17_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_17_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_17_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_17_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_17_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_17_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_17_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_17_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_17_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_17_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_17_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_17_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_17_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_17_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_17_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_17_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_17_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_17_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_17_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_17_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_17_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_17_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_17_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_17_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_17_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_17_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_17_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_17_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_17_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_17_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_17_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_17_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_17_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_17_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_17_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_17_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_17_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_17_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_17_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_17_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_17_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_17_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_17_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_17_io_uop_pdst),
    .io_uop_prs1                    (_slots_17_io_uop_prs1),
    .io_uop_prs2                    (_slots_17_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_17_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_17_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_17_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_17_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_17_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_17_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_17_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_17_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_17_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_17_io_uop_fp_val)
  );
  IssueSlot_32 slots_18 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_18_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_55),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_18_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_207 ? _slots_22_io_out_uop_uopc : _GEN_206 ? _slots_21_io_out_uop_uopc : _GEN_205 ? _slots_20_io_out_uop_uopc : _slots_19_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_207 ? _slots_22_io_out_uop_is_rvc : _GEN_206 ? _slots_21_io_out_uop_is_rvc : _GEN_205 ? _slots_20_io_out_uop_is_rvc : _slots_19_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_207 ? _slots_22_io_out_uop_fu_code : _GEN_206 ? _slots_21_io_out_uop_fu_code : _GEN_205 ? _slots_20_io_out_uop_fu_code : _slots_19_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_207 ? _slots_22_io_out_uop_iw_state : _GEN_206 ? _slots_21_io_out_uop_iw_state : _GEN_205 ? _slots_20_io_out_uop_iw_state : _slots_19_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_207 ? _slots_22_io_out_uop_iw_p1_poisoned : _GEN_206 ? _slots_21_io_out_uop_iw_p1_poisoned : _GEN_205 ? _slots_20_io_out_uop_iw_p1_poisoned : _slots_19_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_207 ? _slots_22_io_out_uop_iw_p2_poisoned : _GEN_206 ? _slots_21_io_out_uop_iw_p2_poisoned : _GEN_205 ? _slots_20_io_out_uop_iw_p2_poisoned : _slots_19_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_207 ? _slots_22_io_out_uop_is_br : _GEN_206 ? _slots_21_io_out_uop_is_br : _GEN_205 ? _slots_20_io_out_uop_is_br : _slots_19_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_207 ? _slots_22_io_out_uop_is_jalr : _GEN_206 ? _slots_21_io_out_uop_is_jalr : _GEN_205 ? _slots_20_io_out_uop_is_jalr : _slots_19_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_207 ? _slots_22_io_out_uop_is_jal : _GEN_206 ? _slots_21_io_out_uop_is_jal : _GEN_205 ? _slots_20_io_out_uop_is_jal : _slots_19_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_207 ? _slots_22_io_out_uop_is_sfb : _GEN_206 ? _slots_21_io_out_uop_is_sfb : _GEN_205 ? _slots_20_io_out_uop_is_sfb : _slots_19_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_207 ? _slots_22_io_out_uop_br_mask : _GEN_206 ? _slots_21_io_out_uop_br_mask : _GEN_205 ? _slots_20_io_out_uop_br_mask : _slots_19_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_207 ? _slots_22_io_out_uop_br_tag : _GEN_206 ? _slots_21_io_out_uop_br_tag : _GEN_205 ? _slots_20_io_out_uop_br_tag : _slots_19_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_207 ? _slots_22_io_out_uop_ftq_idx : _GEN_206 ? _slots_21_io_out_uop_ftq_idx : _GEN_205 ? _slots_20_io_out_uop_ftq_idx : _slots_19_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_207 ? _slots_22_io_out_uop_edge_inst : _GEN_206 ? _slots_21_io_out_uop_edge_inst : _GEN_205 ? _slots_20_io_out_uop_edge_inst : _slots_19_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_207 ? _slots_22_io_out_uop_pc_lob : _GEN_206 ? _slots_21_io_out_uop_pc_lob : _GEN_205 ? _slots_20_io_out_uop_pc_lob : _slots_19_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_207 ? _slots_22_io_out_uop_taken : _GEN_206 ? _slots_21_io_out_uop_taken : _GEN_205 ? _slots_20_io_out_uop_taken : _slots_19_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_207 ? _slots_22_io_out_uop_imm_packed : _GEN_206 ? _slots_21_io_out_uop_imm_packed : _GEN_205 ? _slots_20_io_out_uop_imm_packed : _slots_19_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_207 ? _slots_22_io_out_uop_rob_idx : _GEN_206 ? _slots_21_io_out_uop_rob_idx : _GEN_205 ? _slots_20_io_out_uop_rob_idx : _slots_19_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_207 ? _slots_22_io_out_uop_ldq_idx : _GEN_206 ? _slots_21_io_out_uop_ldq_idx : _GEN_205 ? _slots_20_io_out_uop_ldq_idx : _slots_19_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_207 ? _slots_22_io_out_uop_stq_idx : _GEN_206 ? _slots_21_io_out_uop_stq_idx : _GEN_205 ? _slots_20_io_out_uop_stq_idx : _slots_19_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_207 ? _slots_22_io_out_uop_pdst : _GEN_206 ? _slots_21_io_out_uop_pdst : _GEN_205 ? _slots_20_io_out_uop_pdst : _slots_19_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_207 ? _slots_22_io_out_uop_prs1 : _GEN_206 ? _slots_21_io_out_uop_prs1 : _GEN_205 ? _slots_20_io_out_uop_prs1 : _slots_19_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_207 ? _slots_22_io_out_uop_prs2 : _GEN_206 ? _slots_21_io_out_uop_prs2 : _GEN_205 ? _slots_20_io_out_uop_prs2 : _slots_19_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_207 ? _slots_22_io_out_uop_prs3 : _GEN_206 ? _slots_21_io_out_uop_prs3 : _GEN_205 ? _slots_20_io_out_uop_prs3 : _slots_19_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_207 ? _slots_22_io_out_uop_prs1_busy : _GEN_206 ? _slots_21_io_out_uop_prs1_busy : _GEN_205 ? _slots_20_io_out_uop_prs1_busy : _slots_19_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_207 ? _slots_22_io_out_uop_prs2_busy : _GEN_206 ? _slots_21_io_out_uop_prs2_busy : _GEN_205 ? _slots_20_io_out_uop_prs2_busy : _slots_19_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_207 ? _slots_22_io_out_uop_prs3_busy : _GEN_206 ? _slots_21_io_out_uop_prs3_busy : _GEN_205 ? _slots_20_io_out_uop_prs3_busy : _slots_19_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_207 ? _slots_22_io_out_uop_ppred_busy : _GEN_206 ? _slots_21_io_out_uop_ppred_busy : _GEN_205 ? _slots_20_io_out_uop_ppred_busy : _slots_19_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_207 ? _slots_22_io_out_uop_bypassable : _GEN_206 ? _slots_21_io_out_uop_bypassable : _GEN_205 ? _slots_20_io_out_uop_bypassable : _slots_19_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_207 ? _slots_22_io_out_uop_mem_cmd : _GEN_206 ? _slots_21_io_out_uop_mem_cmd : _GEN_205 ? _slots_20_io_out_uop_mem_cmd : _slots_19_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_207 ? _slots_22_io_out_uop_mem_size : _GEN_206 ? _slots_21_io_out_uop_mem_size : _GEN_205 ? _slots_20_io_out_uop_mem_size : _slots_19_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_207 ? _slots_22_io_out_uop_mem_signed : _GEN_206 ? _slots_21_io_out_uop_mem_signed : _GEN_205 ? _slots_20_io_out_uop_mem_signed : _slots_19_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_207 ? _slots_22_io_out_uop_is_fence : _GEN_206 ? _slots_21_io_out_uop_is_fence : _GEN_205 ? _slots_20_io_out_uop_is_fence : _slots_19_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_207 ? _slots_22_io_out_uop_is_amo : _GEN_206 ? _slots_21_io_out_uop_is_amo : _GEN_205 ? _slots_20_io_out_uop_is_amo : _slots_19_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_207 ? _slots_22_io_out_uop_uses_ldq : _GEN_206 ? _slots_21_io_out_uop_uses_ldq : _GEN_205 ? _slots_20_io_out_uop_uses_ldq : _slots_19_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_207 ? _slots_22_io_out_uop_uses_stq : _GEN_206 ? _slots_21_io_out_uop_uses_stq : _GEN_205 ? _slots_20_io_out_uop_uses_stq : _slots_19_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_207 ? _slots_22_io_out_uop_ldst_val : _GEN_206 ? _slots_21_io_out_uop_ldst_val : _GEN_205 ? _slots_20_io_out_uop_ldst_val : _slots_19_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_207 ? _slots_22_io_out_uop_dst_rtype : _GEN_206 ? _slots_21_io_out_uop_dst_rtype : _GEN_205 ? _slots_20_io_out_uop_dst_rtype : _slots_19_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_207 ? _slots_22_io_out_uop_lrs1_rtype : _GEN_206 ? _slots_21_io_out_uop_lrs1_rtype : _GEN_205 ? _slots_20_io_out_uop_lrs1_rtype : _slots_19_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_207 ? _slots_22_io_out_uop_lrs2_rtype : _GEN_206 ? _slots_21_io_out_uop_lrs2_rtype : _GEN_205 ? _slots_20_io_out_uop_lrs2_rtype : _slots_19_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_207 ? _slots_22_io_out_uop_fp_val : _GEN_206 ? _slots_21_io_out_uop_fp_val : _GEN_205 ? _slots_20_io_out_uop_fp_val : _slots_19_io_out_uop_fp_val),
    .io_valid                       (_slots_18_io_valid),
    .io_will_be_valid               (_slots_18_io_will_be_valid),
    .io_request                     (_slots_18_io_request),
    .io_out_uop_uopc                (_slots_18_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_18_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_18_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_18_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_18_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_18_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_18_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_18_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_18_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_18_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_18_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_18_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_18_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_18_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_18_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_18_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_18_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_18_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_18_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_18_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_18_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_18_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_18_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_18_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_18_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_18_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_18_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_18_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_18_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_18_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_18_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_18_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_18_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_18_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_18_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_18_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_18_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_18_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_18_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_18_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_18_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_18_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_18_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_18_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_18_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_18_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_18_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_18_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_18_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_18_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_18_io_uop_pdst),
    .io_uop_prs1                    (_slots_18_io_uop_prs1),
    .io_uop_prs2                    (_slots_18_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_18_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_18_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_18_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_18_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_18_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_18_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_18_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_18_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_18_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_18_io_uop_fp_val)
  );
  IssueSlot_32 slots_19 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_19_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_57),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_19_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_210 ? _slots_23_io_out_uop_uopc : _GEN_209 ? _slots_22_io_out_uop_uopc : _GEN_208 ? _slots_21_io_out_uop_uopc : _slots_20_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_210 ? _slots_23_io_out_uop_is_rvc : _GEN_209 ? _slots_22_io_out_uop_is_rvc : _GEN_208 ? _slots_21_io_out_uop_is_rvc : _slots_20_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_210 ? _slots_23_io_out_uop_fu_code : _GEN_209 ? _slots_22_io_out_uop_fu_code : _GEN_208 ? _slots_21_io_out_uop_fu_code : _slots_20_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_210 ? _slots_23_io_out_uop_iw_state : _GEN_209 ? _slots_22_io_out_uop_iw_state : _GEN_208 ? _slots_21_io_out_uop_iw_state : _slots_20_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (_GEN_210 ? _slots_23_io_out_uop_iw_p1_poisoned : _GEN_209 ? _slots_22_io_out_uop_iw_p1_poisoned : _GEN_208 ? _slots_21_io_out_uop_iw_p1_poisoned : _slots_20_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (_GEN_210 ? _slots_23_io_out_uop_iw_p2_poisoned : _GEN_209 ? _slots_22_io_out_uop_iw_p2_poisoned : _GEN_208 ? _slots_21_io_out_uop_iw_p2_poisoned : _slots_20_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_210 ? _slots_23_io_out_uop_is_br : _GEN_209 ? _slots_22_io_out_uop_is_br : _GEN_208 ? _slots_21_io_out_uop_is_br : _slots_20_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_210 ? _slots_23_io_out_uop_is_jalr : _GEN_209 ? _slots_22_io_out_uop_is_jalr : _GEN_208 ? _slots_21_io_out_uop_is_jalr : _slots_20_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_210 ? _slots_23_io_out_uop_is_jal : _GEN_209 ? _slots_22_io_out_uop_is_jal : _GEN_208 ? _slots_21_io_out_uop_is_jal : _slots_20_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_210 ? _slots_23_io_out_uop_is_sfb : _GEN_209 ? _slots_22_io_out_uop_is_sfb : _GEN_208 ? _slots_21_io_out_uop_is_sfb : _slots_20_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_210 ? _slots_23_io_out_uop_br_mask : _GEN_209 ? _slots_22_io_out_uop_br_mask : _GEN_208 ? _slots_21_io_out_uop_br_mask : _slots_20_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_210 ? _slots_23_io_out_uop_br_tag : _GEN_209 ? _slots_22_io_out_uop_br_tag : _GEN_208 ? _slots_21_io_out_uop_br_tag : _slots_20_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_210 ? _slots_23_io_out_uop_ftq_idx : _GEN_209 ? _slots_22_io_out_uop_ftq_idx : _GEN_208 ? _slots_21_io_out_uop_ftq_idx : _slots_20_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_210 ? _slots_23_io_out_uop_edge_inst : _GEN_209 ? _slots_22_io_out_uop_edge_inst : _GEN_208 ? _slots_21_io_out_uop_edge_inst : _slots_20_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_210 ? _slots_23_io_out_uop_pc_lob : _GEN_209 ? _slots_22_io_out_uop_pc_lob : _GEN_208 ? _slots_21_io_out_uop_pc_lob : _slots_20_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_210 ? _slots_23_io_out_uop_taken : _GEN_209 ? _slots_22_io_out_uop_taken : _GEN_208 ? _slots_21_io_out_uop_taken : _slots_20_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_210 ? _slots_23_io_out_uop_imm_packed : _GEN_209 ? _slots_22_io_out_uop_imm_packed : _GEN_208 ? _slots_21_io_out_uop_imm_packed : _slots_20_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_210 ? _slots_23_io_out_uop_rob_idx : _GEN_209 ? _slots_22_io_out_uop_rob_idx : _GEN_208 ? _slots_21_io_out_uop_rob_idx : _slots_20_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_210 ? _slots_23_io_out_uop_ldq_idx : _GEN_209 ? _slots_22_io_out_uop_ldq_idx : _GEN_208 ? _slots_21_io_out_uop_ldq_idx : _slots_20_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_210 ? _slots_23_io_out_uop_stq_idx : _GEN_209 ? _slots_22_io_out_uop_stq_idx : _GEN_208 ? _slots_21_io_out_uop_stq_idx : _slots_20_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_210 ? _slots_23_io_out_uop_pdst : _GEN_209 ? _slots_22_io_out_uop_pdst : _GEN_208 ? _slots_21_io_out_uop_pdst : _slots_20_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_210 ? _slots_23_io_out_uop_prs1 : _GEN_209 ? _slots_22_io_out_uop_prs1 : _GEN_208 ? _slots_21_io_out_uop_prs1 : _slots_20_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_210 ? _slots_23_io_out_uop_prs2 : _GEN_209 ? _slots_22_io_out_uop_prs2 : _GEN_208 ? _slots_21_io_out_uop_prs2 : _slots_20_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_210 ? _slots_23_io_out_uop_prs3 : _GEN_209 ? _slots_22_io_out_uop_prs3 : _GEN_208 ? _slots_21_io_out_uop_prs3 : _slots_20_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_210 ? _slots_23_io_out_uop_prs1_busy : _GEN_209 ? _slots_22_io_out_uop_prs1_busy : _GEN_208 ? _slots_21_io_out_uop_prs1_busy : _slots_20_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_210 ? _slots_23_io_out_uop_prs2_busy : _GEN_209 ? _slots_22_io_out_uop_prs2_busy : _GEN_208 ? _slots_21_io_out_uop_prs2_busy : _slots_20_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (_GEN_210 ? _slots_23_io_out_uop_prs3_busy : _GEN_209 ? _slots_22_io_out_uop_prs3_busy : _GEN_208 ? _slots_21_io_out_uop_prs3_busy : _slots_20_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (_GEN_210 ? _slots_23_io_out_uop_ppred_busy : _GEN_209 ? _slots_22_io_out_uop_ppred_busy : _GEN_208 ? _slots_21_io_out_uop_ppred_busy : _slots_20_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_210 ? _slots_23_io_out_uop_bypassable : _GEN_209 ? _slots_22_io_out_uop_bypassable : _GEN_208 ? _slots_21_io_out_uop_bypassable : _slots_20_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_210 ? _slots_23_io_out_uop_mem_cmd : _GEN_209 ? _slots_22_io_out_uop_mem_cmd : _GEN_208 ? _slots_21_io_out_uop_mem_cmd : _slots_20_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_210 ? _slots_23_io_out_uop_mem_size : _GEN_209 ? _slots_22_io_out_uop_mem_size : _GEN_208 ? _slots_21_io_out_uop_mem_size : _slots_20_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_210 ? _slots_23_io_out_uop_mem_signed : _GEN_209 ? _slots_22_io_out_uop_mem_signed : _GEN_208 ? _slots_21_io_out_uop_mem_signed : _slots_20_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_210 ? _slots_23_io_out_uop_is_fence : _GEN_209 ? _slots_22_io_out_uop_is_fence : _GEN_208 ? _slots_21_io_out_uop_is_fence : _slots_20_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_210 ? _slots_23_io_out_uop_is_amo : _GEN_209 ? _slots_22_io_out_uop_is_amo : _GEN_208 ? _slots_21_io_out_uop_is_amo : _slots_20_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_210 ? _slots_23_io_out_uop_uses_ldq : _GEN_209 ? _slots_22_io_out_uop_uses_ldq : _GEN_208 ? _slots_21_io_out_uop_uses_ldq : _slots_20_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_210 ? _slots_23_io_out_uop_uses_stq : _GEN_209 ? _slots_22_io_out_uop_uses_stq : _GEN_208 ? _slots_21_io_out_uop_uses_stq : _slots_20_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_210 ? _slots_23_io_out_uop_ldst_val : _GEN_209 ? _slots_22_io_out_uop_ldst_val : _GEN_208 ? _slots_21_io_out_uop_ldst_val : _slots_20_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_210 ? _slots_23_io_out_uop_dst_rtype : _GEN_209 ? _slots_22_io_out_uop_dst_rtype : _GEN_208 ? _slots_21_io_out_uop_dst_rtype : _slots_20_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_210 ? _slots_23_io_out_uop_lrs1_rtype : _GEN_209 ? _slots_22_io_out_uop_lrs1_rtype : _GEN_208 ? _slots_21_io_out_uop_lrs1_rtype : _slots_20_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_210 ? _slots_23_io_out_uop_lrs2_rtype : _GEN_209 ? _slots_22_io_out_uop_lrs2_rtype : _GEN_208 ? _slots_21_io_out_uop_lrs2_rtype : _slots_20_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_210 ? _slots_23_io_out_uop_fp_val : _GEN_209 ? _slots_22_io_out_uop_fp_val : _GEN_208 ? _slots_21_io_out_uop_fp_val : _slots_20_io_out_uop_fp_val),
    .io_valid                       (_slots_19_io_valid),
    .io_will_be_valid               (_slots_19_io_will_be_valid),
    .io_request                     (_slots_19_io_request),
    .io_out_uop_uopc                (_slots_19_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_19_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_19_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_19_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_19_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_19_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_19_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_19_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_19_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_19_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_19_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_19_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_19_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_19_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_19_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_19_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_19_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_19_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_19_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_19_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_19_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_19_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_19_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_19_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_19_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_19_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_19_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_19_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_19_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_19_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_19_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_19_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_19_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_19_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_19_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_19_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_19_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_19_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_19_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_19_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_19_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_19_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_19_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_19_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_19_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_19_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_19_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_19_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_19_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_19_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_19_io_uop_pdst),
    .io_uop_prs1                    (_slots_19_io_uop_prs1),
    .io_uop_prs2                    (_slots_19_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_19_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_19_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_19_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_19_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_19_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_19_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_19_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_19_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_19_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_19_io_uop_fp_val)
  );
  IssueSlot_32 slots_20 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_20_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_59),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_20_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_213 ? io_dis_uops_0_bits_uopc : _GEN_212 ? _slots_23_io_out_uop_uopc : _GEN_211 ? _slots_22_io_out_uop_uopc : _slots_21_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_213 ? io_dis_uops_0_bits_is_rvc : _GEN_212 ? _slots_23_io_out_uop_is_rvc : _GEN_211 ? _slots_22_io_out_uop_is_rvc : _slots_21_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_213 ? io_dis_uops_0_bits_fu_code : _GEN_212 ? _slots_23_io_out_uop_fu_code : _GEN_211 ? _slots_22_io_out_uop_fu_code : _slots_21_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_213 ? _GEN_7496 : _GEN_212 ? _slots_23_io_out_uop_iw_state : _GEN_211 ? _slots_22_io_out_uop_iw_state : _slots_21_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (~_GEN_213 & (_GEN_212 ? _slots_23_io_out_uop_iw_p1_poisoned : _GEN_211 ? _slots_22_io_out_uop_iw_p1_poisoned : _slots_21_io_out_uop_iw_p1_poisoned)),
    .io_in_uop_bits_iw_p2_poisoned  (~_GEN_213 & (_GEN_212 ? _slots_23_io_out_uop_iw_p2_poisoned : _GEN_211 ? _slots_22_io_out_uop_iw_p2_poisoned : _slots_21_io_out_uop_iw_p2_poisoned)),
    .io_in_uop_bits_is_br           (_GEN_213 ? io_dis_uops_0_bits_is_br : _GEN_212 ? _slots_23_io_out_uop_is_br : _GEN_211 ? _slots_22_io_out_uop_is_br : _slots_21_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_213 ? io_dis_uops_0_bits_is_jalr : _GEN_212 ? _slots_23_io_out_uop_is_jalr : _GEN_211 ? _slots_22_io_out_uop_is_jalr : _slots_21_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_213 ? io_dis_uops_0_bits_is_jal : _GEN_212 ? _slots_23_io_out_uop_is_jal : _GEN_211 ? _slots_22_io_out_uop_is_jal : _slots_21_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_213 ? io_dis_uops_0_bits_is_sfb : _GEN_212 ? _slots_23_io_out_uop_is_sfb : _GEN_211 ? _slots_22_io_out_uop_is_sfb : _slots_21_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_213 ? io_dis_uops_0_bits_br_mask : _GEN_212 ? _slots_23_io_out_uop_br_mask : _GEN_211 ? _slots_22_io_out_uop_br_mask : _slots_21_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_213 ? io_dis_uops_0_bits_br_tag : _GEN_212 ? _slots_23_io_out_uop_br_tag : _GEN_211 ? _slots_22_io_out_uop_br_tag : _slots_21_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_213 ? io_dis_uops_0_bits_ftq_idx : _GEN_212 ? _slots_23_io_out_uop_ftq_idx : _GEN_211 ? _slots_22_io_out_uop_ftq_idx : _slots_21_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_213 ? io_dis_uops_0_bits_edge_inst : _GEN_212 ? _slots_23_io_out_uop_edge_inst : _GEN_211 ? _slots_22_io_out_uop_edge_inst : _slots_21_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_213 ? io_dis_uops_0_bits_pc_lob : _GEN_212 ? _slots_23_io_out_uop_pc_lob : _GEN_211 ? _slots_22_io_out_uop_pc_lob : _slots_21_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_213 ? io_dis_uops_0_bits_taken : _GEN_212 ? _slots_23_io_out_uop_taken : _GEN_211 ? _slots_22_io_out_uop_taken : _slots_21_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_213 ? io_dis_uops_0_bits_imm_packed : _GEN_212 ? _slots_23_io_out_uop_imm_packed : _GEN_211 ? _slots_22_io_out_uop_imm_packed : _slots_21_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_213 ? io_dis_uops_0_bits_rob_idx : _GEN_212 ? _slots_23_io_out_uop_rob_idx : _GEN_211 ? _slots_22_io_out_uop_rob_idx : _slots_21_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_213 ? io_dis_uops_0_bits_ldq_idx : _GEN_212 ? _slots_23_io_out_uop_ldq_idx : _GEN_211 ? _slots_22_io_out_uop_ldq_idx : _slots_21_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_213 ? io_dis_uops_0_bits_stq_idx : _GEN_212 ? _slots_23_io_out_uop_stq_idx : _GEN_211 ? _slots_22_io_out_uop_stq_idx : _slots_21_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_213 ? io_dis_uops_0_bits_pdst : _GEN_212 ? _slots_23_io_out_uop_pdst : _GEN_211 ? _slots_22_io_out_uop_pdst : _slots_21_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_213 ? io_dis_uops_0_bits_prs1 : _GEN_212 ? _slots_23_io_out_uop_prs1 : _GEN_211 ? _slots_22_io_out_uop_prs1 : _slots_21_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_213 ? io_dis_uops_0_bits_prs2 : _GEN_212 ? _slots_23_io_out_uop_prs2 : _GEN_211 ? _slots_22_io_out_uop_prs2 : _slots_21_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_213 ? io_dis_uops_0_bits_prs3 : _GEN_212 ? _slots_23_io_out_uop_prs3 : _GEN_211 ? _slots_22_io_out_uop_prs3 : _slots_21_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_213 ? io_dis_uops_0_bits_prs1_busy : _GEN_212 ? _slots_23_io_out_uop_prs1_busy : _GEN_211 ? _slots_22_io_out_uop_prs1_busy : _slots_21_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_213 ? _GEN_7471 : _GEN_212 ? _slots_23_io_out_uop_prs2_busy : _GEN_211 ? _slots_22_io_out_uop_prs2_busy : _slots_21_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (~_GEN_213 & (_GEN_212 ? _slots_23_io_out_uop_prs3_busy : _GEN_211 ? _slots_22_io_out_uop_prs3_busy : _slots_21_io_out_uop_prs3_busy)),
    .io_in_uop_bits_ppred_busy      (~_GEN_213 & (_GEN_212 ? _slots_23_io_out_uop_ppred_busy : _GEN_211 ? _slots_22_io_out_uop_ppred_busy : _slots_21_io_out_uop_ppred_busy)),
    .io_in_uop_bits_bypassable      (_GEN_213 ? io_dis_uops_0_bits_bypassable : _GEN_212 ? _slots_23_io_out_uop_bypassable : _GEN_211 ? _slots_22_io_out_uop_bypassable : _slots_21_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_213 ? io_dis_uops_0_bits_mem_cmd : _GEN_212 ? _slots_23_io_out_uop_mem_cmd : _GEN_211 ? _slots_22_io_out_uop_mem_cmd : _slots_21_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_213 ? io_dis_uops_0_bits_mem_size : _GEN_212 ? _slots_23_io_out_uop_mem_size : _GEN_211 ? _slots_22_io_out_uop_mem_size : _slots_21_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_213 ? io_dis_uops_0_bits_mem_signed : _GEN_212 ? _slots_23_io_out_uop_mem_signed : _GEN_211 ? _slots_22_io_out_uop_mem_signed : _slots_21_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_213 ? io_dis_uops_0_bits_is_fence : _GEN_212 ? _slots_23_io_out_uop_is_fence : _GEN_211 ? _slots_22_io_out_uop_is_fence : _slots_21_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_213 ? io_dis_uops_0_bits_is_amo : _GEN_212 ? _slots_23_io_out_uop_is_amo : _GEN_211 ? _slots_22_io_out_uop_is_amo : _slots_21_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_213 ? io_dis_uops_0_bits_uses_ldq : _GEN_212 ? _slots_23_io_out_uop_uses_ldq : _GEN_211 ? _slots_22_io_out_uop_uses_ldq : _slots_21_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_213 ? io_dis_uops_0_bits_uses_stq : _GEN_212 ? _slots_23_io_out_uop_uses_stq : _GEN_211 ? _slots_22_io_out_uop_uses_stq : _slots_21_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_213 ? io_dis_uops_0_bits_ldst_val : _GEN_212 ? _slots_23_io_out_uop_ldst_val : _GEN_211 ? _slots_22_io_out_uop_ldst_val : _slots_21_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_213 ? io_dis_uops_0_bits_dst_rtype : _GEN_212 ? _slots_23_io_out_uop_dst_rtype : _GEN_211 ? _slots_22_io_out_uop_dst_rtype : _slots_21_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_213 ? io_dis_uops_0_bits_lrs1_rtype : _GEN_212 ? _slots_23_io_out_uop_lrs1_rtype : _GEN_211 ? _slots_22_io_out_uop_lrs1_rtype : _slots_21_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_213 ? _GEN_7445 : _GEN_212 ? _slots_23_io_out_uop_lrs2_rtype : _GEN_211 ? _slots_22_io_out_uop_lrs2_rtype : _slots_21_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_213 ? io_dis_uops_0_bits_fp_val : _GEN_212 ? _slots_23_io_out_uop_fp_val : _GEN_211 ? _slots_22_io_out_uop_fp_val : _slots_21_io_out_uop_fp_val),
    .io_valid                       (_slots_20_io_valid),
    .io_will_be_valid               (_slots_20_io_will_be_valid),
    .io_request                     (_slots_20_io_request),
    .io_out_uop_uopc                (_slots_20_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_20_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_20_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_20_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_20_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_20_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_20_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_20_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_20_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_20_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_20_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_20_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_20_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_20_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_20_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_20_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_20_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_20_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_20_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_20_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_20_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_20_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_20_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_20_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_20_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_20_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_20_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_20_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_20_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_20_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_20_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_20_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_20_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_20_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_20_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_20_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_20_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_20_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_20_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_20_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_20_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_20_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_20_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_20_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_20_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_20_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_20_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_20_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_20_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_20_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_20_io_uop_pdst),
    .io_uop_prs1                    (_slots_20_io_uop_prs1),
    .io_uop_prs2                    (_slots_20_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_20_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_20_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_20_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_20_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_20_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_20_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_20_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_20_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_20_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_20_io_uop_fp_val)
  );
  IssueSlot_32 slots_21 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_21_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_61),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_21_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_216 ? io_dis_uops_1_bits_uopc : _GEN_215 ? io_dis_uops_0_bits_uopc : _GEN_214 ? _slots_23_io_out_uop_uopc : _slots_22_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_216 ? io_dis_uops_1_bits_is_rvc : _GEN_215 ? io_dis_uops_0_bits_is_rvc : _GEN_214 ? _slots_23_io_out_uop_is_rvc : _slots_22_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_216 ? io_dis_uops_1_bits_fu_code : _GEN_215 ? io_dis_uops_0_bits_fu_code : _GEN_214 ? _slots_23_io_out_uop_fu_code : _slots_22_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_216 ? _GEN_7 : _GEN_215 ? _GEN_7496 : _GEN_214 ? _slots_23_io_out_uop_iw_state : _slots_22_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (~_GEN_217 & (_GEN_214 ? _slots_23_io_out_uop_iw_p1_poisoned : _slots_22_io_out_uop_iw_p1_poisoned)),
    .io_in_uop_bits_iw_p2_poisoned  (~_GEN_217 & (_GEN_214 ? _slots_23_io_out_uop_iw_p2_poisoned : _slots_22_io_out_uop_iw_p2_poisoned)),
    .io_in_uop_bits_is_br           (_GEN_216 ? io_dis_uops_1_bits_is_br : _GEN_215 ? io_dis_uops_0_bits_is_br : _GEN_214 ? _slots_23_io_out_uop_is_br : _slots_22_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_216 ? io_dis_uops_1_bits_is_jalr : _GEN_215 ? io_dis_uops_0_bits_is_jalr : _GEN_214 ? _slots_23_io_out_uop_is_jalr : _slots_22_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_216 ? io_dis_uops_1_bits_is_jal : _GEN_215 ? io_dis_uops_0_bits_is_jal : _GEN_214 ? _slots_23_io_out_uop_is_jal : _slots_22_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_216 ? io_dis_uops_1_bits_is_sfb : _GEN_215 ? io_dis_uops_0_bits_is_sfb : _GEN_214 ? _slots_23_io_out_uop_is_sfb : _slots_22_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_216 ? io_dis_uops_1_bits_br_mask : _GEN_215 ? io_dis_uops_0_bits_br_mask : _GEN_214 ? _slots_23_io_out_uop_br_mask : _slots_22_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_216 ? io_dis_uops_1_bits_br_tag : _GEN_215 ? io_dis_uops_0_bits_br_tag : _GEN_214 ? _slots_23_io_out_uop_br_tag : _slots_22_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_216 ? io_dis_uops_1_bits_ftq_idx : _GEN_215 ? io_dis_uops_0_bits_ftq_idx : _GEN_214 ? _slots_23_io_out_uop_ftq_idx : _slots_22_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_216 ? io_dis_uops_1_bits_edge_inst : _GEN_215 ? io_dis_uops_0_bits_edge_inst : _GEN_214 ? _slots_23_io_out_uop_edge_inst : _slots_22_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_216 ? io_dis_uops_1_bits_pc_lob : _GEN_215 ? io_dis_uops_0_bits_pc_lob : _GEN_214 ? _slots_23_io_out_uop_pc_lob : _slots_22_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_216 ? io_dis_uops_1_bits_taken : _GEN_215 ? io_dis_uops_0_bits_taken : _GEN_214 ? _slots_23_io_out_uop_taken : _slots_22_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_216 ? io_dis_uops_1_bits_imm_packed : _GEN_215 ? io_dis_uops_0_bits_imm_packed : _GEN_214 ? _slots_23_io_out_uop_imm_packed : _slots_22_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_216 ? io_dis_uops_1_bits_rob_idx : _GEN_215 ? io_dis_uops_0_bits_rob_idx : _GEN_214 ? _slots_23_io_out_uop_rob_idx : _slots_22_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_216 ? io_dis_uops_1_bits_ldq_idx : _GEN_215 ? io_dis_uops_0_bits_ldq_idx : _GEN_214 ? _slots_23_io_out_uop_ldq_idx : _slots_22_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_216 ? io_dis_uops_1_bits_stq_idx : _GEN_215 ? io_dis_uops_0_bits_stq_idx : _GEN_214 ? _slots_23_io_out_uop_stq_idx : _slots_22_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_216 ? io_dis_uops_1_bits_pdst : _GEN_215 ? io_dis_uops_0_bits_pdst : _GEN_214 ? _slots_23_io_out_uop_pdst : _slots_22_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_216 ? io_dis_uops_1_bits_prs1 : _GEN_215 ? io_dis_uops_0_bits_prs1 : _GEN_214 ? _slots_23_io_out_uop_prs1 : _slots_22_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_216 ? io_dis_uops_1_bits_prs2 : _GEN_215 ? io_dis_uops_0_bits_prs2 : _GEN_214 ? _slots_23_io_out_uop_prs2 : _slots_22_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_216 ? io_dis_uops_1_bits_prs3 : _GEN_215 ? io_dis_uops_0_bits_prs3 : _GEN_214 ? _slots_23_io_out_uop_prs3 : _slots_22_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_216 ? io_dis_uops_1_bits_prs1_busy : _GEN_215 ? io_dis_uops_0_bits_prs1_busy : _GEN_214 ? _slots_23_io_out_uop_prs1_busy : _slots_22_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_216 ? _GEN_9 : _GEN_215 ? _GEN_7471 : _GEN_214 ? _slots_23_io_out_uop_prs2_busy : _slots_22_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (~_GEN_217 & (_GEN_214 ? _slots_23_io_out_uop_prs3_busy : _slots_22_io_out_uop_prs3_busy)),
    .io_in_uop_bits_ppred_busy      (~_GEN_217 & (_GEN_214 ? _slots_23_io_out_uop_ppred_busy : _slots_22_io_out_uop_ppred_busy)),
    .io_in_uop_bits_bypassable      (_GEN_216 ? io_dis_uops_1_bits_bypassable : _GEN_215 ? io_dis_uops_0_bits_bypassable : _GEN_214 ? _slots_23_io_out_uop_bypassable : _slots_22_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_216 ? io_dis_uops_1_bits_mem_cmd : _GEN_215 ? io_dis_uops_0_bits_mem_cmd : _GEN_214 ? _slots_23_io_out_uop_mem_cmd : _slots_22_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_216 ? io_dis_uops_1_bits_mem_size : _GEN_215 ? io_dis_uops_0_bits_mem_size : _GEN_214 ? _slots_23_io_out_uop_mem_size : _slots_22_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_216 ? io_dis_uops_1_bits_mem_signed : _GEN_215 ? io_dis_uops_0_bits_mem_signed : _GEN_214 ? _slots_23_io_out_uop_mem_signed : _slots_22_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_216 ? io_dis_uops_1_bits_is_fence : _GEN_215 ? io_dis_uops_0_bits_is_fence : _GEN_214 ? _slots_23_io_out_uop_is_fence : _slots_22_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_216 ? io_dis_uops_1_bits_is_amo : _GEN_215 ? io_dis_uops_0_bits_is_amo : _GEN_214 ? _slots_23_io_out_uop_is_amo : _slots_22_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_216 ? io_dis_uops_1_bits_uses_ldq : _GEN_215 ? io_dis_uops_0_bits_uses_ldq : _GEN_214 ? _slots_23_io_out_uop_uses_ldq : _slots_22_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_216 ? io_dis_uops_1_bits_uses_stq : _GEN_215 ? io_dis_uops_0_bits_uses_stq : _GEN_214 ? _slots_23_io_out_uop_uses_stq : _slots_22_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_216 ? io_dis_uops_1_bits_ldst_val : _GEN_215 ? io_dis_uops_0_bits_ldst_val : _GEN_214 ? _slots_23_io_out_uop_ldst_val : _slots_22_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_216 ? io_dis_uops_1_bits_dst_rtype : _GEN_215 ? io_dis_uops_0_bits_dst_rtype : _GEN_214 ? _slots_23_io_out_uop_dst_rtype : _slots_22_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_216 ? io_dis_uops_1_bits_lrs1_rtype : _GEN_215 ? io_dis_uops_0_bits_lrs1_rtype : _GEN_214 ? _slots_23_io_out_uop_lrs1_rtype : _slots_22_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_216 ? _GEN_8 : _GEN_215 ? _GEN_7445 : _GEN_214 ? _slots_23_io_out_uop_lrs2_rtype : _slots_22_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_216 ? io_dis_uops_1_bits_fp_val : _GEN_215 ? io_dis_uops_0_bits_fp_val : _GEN_214 ? _slots_23_io_out_uop_fp_val : _slots_22_io_out_uop_fp_val),
    .io_valid                       (_slots_21_io_valid),
    .io_will_be_valid               (_slots_21_io_will_be_valid),
    .io_request                     (_slots_21_io_request),
    .io_out_uop_uopc                (_slots_21_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_21_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_21_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_21_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_21_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_21_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_21_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_21_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_21_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_21_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_21_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_21_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_21_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_21_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_21_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_21_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_21_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_21_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_21_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_21_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_21_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_21_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_21_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_21_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_21_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_21_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_21_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_21_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_21_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_21_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_21_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_21_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_21_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_21_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_21_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_21_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_21_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_21_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_21_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_21_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_21_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_21_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_21_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_21_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_21_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_21_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_21_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_21_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_21_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_21_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_21_io_uop_pdst),
    .io_uop_prs1                    (_slots_21_io_uop_prs1),
    .io_uop_prs2                    (_slots_21_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_21_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_21_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_21_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_21_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_21_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_21_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_21_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_21_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_21_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_21_io_uop_fp_val)
  );
  IssueSlot_32 slots_22 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_22_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_63),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_22_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_220 ? io_dis_uops_2_bits_uopc : _GEN_219 ? io_dis_uops_1_bits_uopc : _GEN_218 ? io_dis_uops_0_bits_uopc : _slots_23_io_out_uop_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_220 ? io_dis_uops_2_bits_is_rvc : _GEN_219 ? io_dis_uops_1_bits_is_rvc : _GEN_218 ? io_dis_uops_0_bits_is_rvc : _slots_23_io_out_uop_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_220 ? io_dis_uops_2_bits_fu_code : _GEN_219 ? io_dis_uops_1_bits_fu_code : _GEN_218 ? io_dis_uops_0_bits_fu_code : _slots_23_io_out_uop_fu_code),
    .io_in_uop_bits_iw_state        (_GEN_220 ? (_GEN_6 ? 2'h2 : 2'h1) : _GEN_219 ? _GEN_7 : _GEN_218 ? _GEN_7496 : _slots_23_io_out_uop_iw_state),
    .io_in_uop_bits_iw_p1_poisoned  (~_GEN_221 & _slots_23_io_out_uop_iw_p1_poisoned),
    .io_in_uop_bits_iw_p2_poisoned  (~_GEN_221 & _slots_23_io_out_uop_iw_p2_poisoned),
    .io_in_uop_bits_is_br           (_GEN_220 ? io_dis_uops_2_bits_is_br : _GEN_219 ? io_dis_uops_1_bits_is_br : _GEN_218 ? io_dis_uops_0_bits_is_br : _slots_23_io_out_uop_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_220 ? io_dis_uops_2_bits_is_jalr : _GEN_219 ? io_dis_uops_1_bits_is_jalr : _GEN_218 ? io_dis_uops_0_bits_is_jalr : _slots_23_io_out_uop_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_220 ? io_dis_uops_2_bits_is_jal : _GEN_219 ? io_dis_uops_1_bits_is_jal : _GEN_218 ? io_dis_uops_0_bits_is_jal : _slots_23_io_out_uop_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_220 ? io_dis_uops_2_bits_is_sfb : _GEN_219 ? io_dis_uops_1_bits_is_sfb : _GEN_218 ? io_dis_uops_0_bits_is_sfb : _slots_23_io_out_uop_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_220 ? io_dis_uops_2_bits_br_mask : _GEN_219 ? io_dis_uops_1_bits_br_mask : _GEN_218 ? io_dis_uops_0_bits_br_mask : _slots_23_io_out_uop_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_220 ? io_dis_uops_2_bits_br_tag : _GEN_219 ? io_dis_uops_1_bits_br_tag : _GEN_218 ? io_dis_uops_0_bits_br_tag : _slots_23_io_out_uop_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_220 ? io_dis_uops_2_bits_ftq_idx : _GEN_219 ? io_dis_uops_1_bits_ftq_idx : _GEN_218 ? io_dis_uops_0_bits_ftq_idx : _slots_23_io_out_uop_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_220 ? io_dis_uops_2_bits_edge_inst : _GEN_219 ? io_dis_uops_1_bits_edge_inst : _GEN_218 ? io_dis_uops_0_bits_edge_inst : _slots_23_io_out_uop_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_220 ? io_dis_uops_2_bits_pc_lob : _GEN_219 ? io_dis_uops_1_bits_pc_lob : _GEN_218 ? io_dis_uops_0_bits_pc_lob : _slots_23_io_out_uop_pc_lob),
    .io_in_uop_bits_taken           (_GEN_220 ? io_dis_uops_2_bits_taken : _GEN_219 ? io_dis_uops_1_bits_taken : _GEN_218 ? io_dis_uops_0_bits_taken : _slots_23_io_out_uop_taken),
    .io_in_uop_bits_imm_packed      (_GEN_220 ? io_dis_uops_2_bits_imm_packed : _GEN_219 ? io_dis_uops_1_bits_imm_packed : _GEN_218 ? io_dis_uops_0_bits_imm_packed : _slots_23_io_out_uop_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_220 ? io_dis_uops_2_bits_rob_idx : _GEN_219 ? io_dis_uops_1_bits_rob_idx : _GEN_218 ? io_dis_uops_0_bits_rob_idx : _slots_23_io_out_uop_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_220 ? io_dis_uops_2_bits_ldq_idx : _GEN_219 ? io_dis_uops_1_bits_ldq_idx : _GEN_218 ? io_dis_uops_0_bits_ldq_idx : _slots_23_io_out_uop_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_220 ? io_dis_uops_2_bits_stq_idx : _GEN_219 ? io_dis_uops_1_bits_stq_idx : _GEN_218 ? io_dis_uops_0_bits_stq_idx : _slots_23_io_out_uop_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_220 ? io_dis_uops_2_bits_pdst : _GEN_219 ? io_dis_uops_1_bits_pdst : _GEN_218 ? io_dis_uops_0_bits_pdst : _slots_23_io_out_uop_pdst),
    .io_in_uop_bits_prs1            (_GEN_220 ? io_dis_uops_2_bits_prs1 : _GEN_219 ? io_dis_uops_1_bits_prs1 : _GEN_218 ? io_dis_uops_0_bits_prs1 : _slots_23_io_out_uop_prs1),
    .io_in_uop_bits_prs2            (_GEN_220 ? io_dis_uops_2_bits_prs2 : _GEN_219 ? io_dis_uops_1_bits_prs2 : _GEN_218 ? io_dis_uops_0_bits_prs2 : _slots_23_io_out_uop_prs2),
    .io_in_uop_bits_prs3            (_GEN_220 ? io_dis_uops_2_bits_prs3 : _GEN_219 ? io_dis_uops_1_bits_prs3 : _GEN_218 ? io_dis_uops_0_bits_prs3 : _slots_23_io_out_uop_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_220 ? io_dis_uops_2_bits_prs1_busy : _GEN_219 ? io_dis_uops_1_bits_prs1_busy : _GEN_218 ? io_dis_uops_0_bits_prs1_busy : _slots_23_io_out_uop_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_220 ? _GEN_14 : _GEN_219 ? _GEN_9 : _GEN_218 ? _GEN_7471 : _slots_23_io_out_uop_prs2_busy),
    .io_in_uop_bits_prs3_busy       (~_GEN_221 & _slots_23_io_out_uop_prs3_busy),
    .io_in_uop_bits_ppred_busy      (~_GEN_221 & _slots_23_io_out_uop_ppred_busy),
    .io_in_uop_bits_bypassable      (_GEN_220 ? io_dis_uops_2_bits_bypassable : _GEN_219 ? io_dis_uops_1_bits_bypassable : _GEN_218 ? io_dis_uops_0_bits_bypassable : _slots_23_io_out_uop_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_220 ? io_dis_uops_2_bits_mem_cmd : _GEN_219 ? io_dis_uops_1_bits_mem_cmd : _GEN_218 ? io_dis_uops_0_bits_mem_cmd : _slots_23_io_out_uop_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_220 ? io_dis_uops_2_bits_mem_size : _GEN_219 ? io_dis_uops_1_bits_mem_size : _GEN_218 ? io_dis_uops_0_bits_mem_size : _slots_23_io_out_uop_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_220 ? io_dis_uops_2_bits_mem_signed : _GEN_219 ? io_dis_uops_1_bits_mem_signed : _GEN_218 ? io_dis_uops_0_bits_mem_signed : _slots_23_io_out_uop_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_220 ? io_dis_uops_2_bits_is_fence : _GEN_219 ? io_dis_uops_1_bits_is_fence : _GEN_218 ? io_dis_uops_0_bits_is_fence : _slots_23_io_out_uop_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_220 ? io_dis_uops_2_bits_is_amo : _GEN_219 ? io_dis_uops_1_bits_is_amo : _GEN_218 ? io_dis_uops_0_bits_is_amo : _slots_23_io_out_uop_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_220 ? io_dis_uops_2_bits_uses_ldq : _GEN_219 ? io_dis_uops_1_bits_uses_ldq : _GEN_218 ? io_dis_uops_0_bits_uses_ldq : _slots_23_io_out_uop_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_220 ? io_dis_uops_2_bits_uses_stq : _GEN_219 ? io_dis_uops_1_bits_uses_stq : _GEN_218 ? io_dis_uops_0_bits_uses_stq : _slots_23_io_out_uop_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_220 ? io_dis_uops_2_bits_ldst_val : _GEN_219 ? io_dis_uops_1_bits_ldst_val : _GEN_218 ? io_dis_uops_0_bits_ldst_val : _slots_23_io_out_uop_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_220 ? io_dis_uops_2_bits_dst_rtype : _GEN_219 ? io_dis_uops_1_bits_dst_rtype : _GEN_218 ? io_dis_uops_0_bits_dst_rtype : _slots_23_io_out_uop_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_220 ? io_dis_uops_2_bits_lrs1_rtype : _GEN_219 ? io_dis_uops_1_bits_lrs1_rtype : _GEN_218 ? io_dis_uops_0_bits_lrs1_rtype : _slots_23_io_out_uop_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_220 ? _GEN_13 : _GEN_219 ? _GEN_8 : _GEN_218 ? _GEN_7445 : _slots_23_io_out_uop_lrs2_rtype),
    .io_in_uop_bits_fp_val          (_GEN_220 ? io_dis_uops_2_bits_fp_val : _GEN_219 ? io_dis_uops_1_bits_fp_val : _GEN_218 ? io_dis_uops_0_bits_fp_val : _slots_23_io_out_uop_fp_val),
    .io_valid                       (_slots_22_io_valid),
    .io_will_be_valid               (_slots_22_io_will_be_valid),
    .io_request                     (_slots_22_io_request),
    .io_out_uop_uopc                (_slots_22_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_22_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_22_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_22_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_22_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_22_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_22_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_22_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_22_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_22_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_22_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_22_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_22_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_22_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_22_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_22_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_22_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_22_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_22_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_22_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_22_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_22_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_22_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_22_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_22_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_22_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_22_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_22_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_22_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_22_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_22_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_22_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_22_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_22_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_22_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_22_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_22_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_22_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_22_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_22_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_22_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_22_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_22_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_22_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_22_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_22_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_22_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_22_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_22_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_22_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_22_io_uop_pdst),
    .io_uop_prs1                    (_slots_22_io_uop_prs1),
    .io_uop_prs2                    (_slots_22_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_22_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_22_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_22_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_22_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_22_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_22_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_22_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_22_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_22_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_22_io_uop_fp_val)
  );
  IssueSlot_32 slots_23 (
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_23_grant),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|_GEN_65),
    .io_ldspec_miss                 (io_ld_miss),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_wakeup_ports_2_valid        (io_wakeup_ports_2_valid),
    .io_wakeup_ports_2_bits_pdst    (io_wakeup_ports_2_bits_pdst),
    .io_wakeup_ports_3_valid        (io_wakeup_ports_3_valid),
    .io_wakeup_ports_3_bits_pdst    (io_wakeup_ports_3_bits_pdst),
    .io_wakeup_ports_4_valid        (io_wakeup_ports_4_valid),
    .io_wakeup_ports_4_bits_pdst    (io_wakeup_ports_4_bits_pdst),
    .io_wakeup_ports_5_valid        (io_wakeup_ports_5_valid),
    .io_wakeup_ports_5_bits_pdst    (io_wakeup_ports_5_bits_pdst),
    .io_wakeup_ports_6_valid        (io_wakeup_ports_6_valid),
    .io_wakeup_ports_6_bits_pdst    (io_wakeup_ports_6_bits_pdst),
    .io_wakeup_ports_7_valid        (io_wakeup_ports_7_valid),
    .io_wakeup_ports_7_bits_pdst    (io_wakeup_ports_7_bits_pdst),
    .io_wakeup_ports_8_valid        (io_wakeup_ports_8_valid),
    .io_wakeup_ports_8_bits_pdst    (io_wakeup_ports_8_bits_pdst),
    .io_wakeup_ports_9_valid        (io_wakeup_ports_9_valid),
    .io_wakeup_ports_9_bits_pdst    (io_wakeup_ports_9_bits_pdst),
    .io_spec_ld_wakeup_0_valid      (io_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_spec_ld_wakeup_1_bits),
    .io_in_uop_valid                (issue_slots_23_in_uop_valid),
    .io_in_uop_bits_uopc            (_GEN_224 ? io_dis_uops_3_bits_uopc : _GEN_223 ? io_dis_uops_2_bits_uopc : _GEN_222 ? io_dis_uops_1_bits_uopc : io_dis_uops_0_bits_uopc),
    .io_in_uop_bits_is_rvc          (_GEN_224 ? io_dis_uops_3_bits_is_rvc : _GEN_223 ? io_dis_uops_2_bits_is_rvc : _GEN_222 ? io_dis_uops_1_bits_is_rvc : io_dis_uops_0_bits_is_rvc),
    .io_in_uop_bits_fu_code         (_GEN_224 ? io_dis_uops_3_bits_fu_code : _GEN_223 ? io_dis_uops_2_bits_fu_code : _GEN_222 ? io_dis_uops_1_bits_fu_code : io_dis_uops_0_bits_fu_code),
    .io_in_uop_bits_iw_state        ((_GEN_224 ? _GEN_12 : _GEN_223 ? _GEN_6 : _GEN_222 ? _GEN_3 : _GEN_0) ? 2'h2 : 2'h1),
    .io_in_uop_bits_iw_p1_poisoned  (1'h0),
    .io_in_uop_bits_iw_p2_poisoned  (1'h0),
    .io_in_uop_bits_is_br           (_GEN_224 ? io_dis_uops_3_bits_is_br : _GEN_223 ? io_dis_uops_2_bits_is_br : _GEN_222 ? io_dis_uops_1_bits_is_br : io_dis_uops_0_bits_is_br),
    .io_in_uop_bits_is_jalr         (_GEN_224 ? io_dis_uops_3_bits_is_jalr : _GEN_223 ? io_dis_uops_2_bits_is_jalr : _GEN_222 ? io_dis_uops_1_bits_is_jalr : io_dis_uops_0_bits_is_jalr),
    .io_in_uop_bits_is_jal          (_GEN_224 ? io_dis_uops_3_bits_is_jal : _GEN_223 ? io_dis_uops_2_bits_is_jal : _GEN_222 ? io_dis_uops_1_bits_is_jal : io_dis_uops_0_bits_is_jal),
    .io_in_uop_bits_is_sfb          (_GEN_224 ? io_dis_uops_3_bits_is_sfb : _GEN_223 ? io_dis_uops_2_bits_is_sfb : _GEN_222 ? io_dis_uops_1_bits_is_sfb : io_dis_uops_0_bits_is_sfb),
    .io_in_uop_bits_br_mask         (_GEN_224 ? io_dis_uops_3_bits_br_mask : _GEN_223 ? io_dis_uops_2_bits_br_mask : _GEN_222 ? io_dis_uops_1_bits_br_mask : io_dis_uops_0_bits_br_mask),
    .io_in_uop_bits_br_tag          (_GEN_224 ? io_dis_uops_3_bits_br_tag : _GEN_223 ? io_dis_uops_2_bits_br_tag : _GEN_222 ? io_dis_uops_1_bits_br_tag : io_dis_uops_0_bits_br_tag),
    .io_in_uop_bits_ftq_idx         (_GEN_224 ? io_dis_uops_3_bits_ftq_idx : _GEN_223 ? io_dis_uops_2_bits_ftq_idx : _GEN_222 ? io_dis_uops_1_bits_ftq_idx : io_dis_uops_0_bits_ftq_idx),
    .io_in_uop_bits_edge_inst       (_GEN_224 ? io_dis_uops_3_bits_edge_inst : _GEN_223 ? io_dis_uops_2_bits_edge_inst : _GEN_222 ? io_dis_uops_1_bits_edge_inst : io_dis_uops_0_bits_edge_inst),
    .io_in_uop_bits_pc_lob          (_GEN_224 ? io_dis_uops_3_bits_pc_lob : _GEN_223 ? io_dis_uops_2_bits_pc_lob : _GEN_222 ? io_dis_uops_1_bits_pc_lob : io_dis_uops_0_bits_pc_lob),
    .io_in_uop_bits_taken           (_GEN_224 ? io_dis_uops_3_bits_taken : _GEN_223 ? io_dis_uops_2_bits_taken : _GEN_222 ? io_dis_uops_1_bits_taken : io_dis_uops_0_bits_taken),
    .io_in_uop_bits_imm_packed      (_GEN_224 ? io_dis_uops_3_bits_imm_packed : _GEN_223 ? io_dis_uops_2_bits_imm_packed : _GEN_222 ? io_dis_uops_1_bits_imm_packed : io_dis_uops_0_bits_imm_packed),
    .io_in_uop_bits_rob_idx         (_GEN_224 ? io_dis_uops_3_bits_rob_idx : _GEN_223 ? io_dis_uops_2_bits_rob_idx : _GEN_222 ? io_dis_uops_1_bits_rob_idx : io_dis_uops_0_bits_rob_idx),
    .io_in_uop_bits_ldq_idx         (_GEN_224 ? io_dis_uops_3_bits_ldq_idx : _GEN_223 ? io_dis_uops_2_bits_ldq_idx : _GEN_222 ? io_dis_uops_1_bits_ldq_idx : io_dis_uops_0_bits_ldq_idx),
    .io_in_uop_bits_stq_idx         (_GEN_224 ? io_dis_uops_3_bits_stq_idx : _GEN_223 ? io_dis_uops_2_bits_stq_idx : _GEN_222 ? io_dis_uops_1_bits_stq_idx : io_dis_uops_0_bits_stq_idx),
    .io_in_uop_bits_pdst            (_GEN_224 ? io_dis_uops_3_bits_pdst : _GEN_223 ? io_dis_uops_2_bits_pdst : _GEN_222 ? io_dis_uops_1_bits_pdst : io_dis_uops_0_bits_pdst),
    .io_in_uop_bits_prs1            (_GEN_224 ? io_dis_uops_3_bits_prs1 : _GEN_223 ? io_dis_uops_2_bits_prs1 : _GEN_222 ? io_dis_uops_1_bits_prs1 : io_dis_uops_0_bits_prs1),
    .io_in_uop_bits_prs2            (_GEN_224 ? io_dis_uops_3_bits_prs2 : _GEN_223 ? io_dis_uops_2_bits_prs2 : _GEN_222 ? io_dis_uops_1_bits_prs2 : io_dis_uops_0_bits_prs2),
    .io_in_uop_bits_prs3            (_GEN_224 ? io_dis_uops_3_bits_prs3 : _GEN_223 ? io_dis_uops_2_bits_prs3 : _GEN_222 ? io_dis_uops_1_bits_prs3 : io_dis_uops_0_bits_prs3),
    .io_in_uop_bits_prs1_busy       (_GEN_224 ? io_dis_uops_3_bits_prs1_busy : _GEN_223 ? io_dis_uops_2_bits_prs1_busy : _GEN_222 ? io_dis_uops_1_bits_prs1_busy : io_dis_uops_0_bits_prs1_busy),
    .io_in_uop_bits_prs2_busy       (_GEN_224 ? _GEN_15 & io_dis_uops_3_bits_prs2_busy : _GEN_223 ? _GEN_14 : _GEN_222 ? _GEN_9 : _GEN_7471),
    .io_in_uop_bits_prs3_busy       (1'h0),
    .io_in_uop_bits_ppred_busy      (1'h0),
    .io_in_uop_bits_bypassable      (_GEN_224 ? io_dis_uops_3_bits_bypassable : _GEN_223 ? io_dis_uops_2_bits_bypassable : _GEN_222 ? io_dis_uops_1_bits_bypassable : io_dis_uops_0_bits_bypassable),
    .io_in_uop_bits_mem_cmd         (_GEN_224 ? io_dis_uops_3_bits_mem_cmd : _GEN_223 ? io_dis_uops_2_bits_mem_cmd : _GEN_222 ? io_dis_uops_1_bits_mem_cmd : io_dis_uops_0_bits_mem_cmd),
    .io_in_uop_bits_mem_size        (_GEN_224 ? io_dis_uops_3_bits_mem_size : _GEN_223 ? io_dis_uops_2_bits_mem_size : _GEN_222 ? io_dis_uops_1_bits_mem_size : io_dis_uops_0_bits_mem_size),
    .io_in_uop_bits_mem_signed      (_GEN_224 ? io_dis_uops_3_bits_mem_signed : _GEN_223 ? io_dis_uops_2_bits_mem_signed : _GEN_222 ? io_dis_uops_1_bits_mem_signed : io_dis_uops_0_bits_mem_signed),
    .io_in_uop_bits_is_fence        (_GEN_224 ? io_dis_uops_3_bits_is_fence : _GEN_223 ? io_dis_uops_2_bits_is_fence : _GEN_222 ? io_dis_uops_1_bits_is_fence : io_dis_uops_0_bits_is_fence),
    .io_in_uop_bits_is_amo          (_GEN_224 ? io_dis_uops_3_bits_is_amo : _GEN_223 ? io_dis_uops_2_bits_is_amo : _GEN_222 ? io_dis_uops_1_bits_is_amo : io_dis_uops_0_bits_is_amo),
    .io_in_uop_bits_uses_ldq        (_GEN_224 ? io_dis_uops_3_bits_uses_ldq : _GEN_223 ? io_dis_uops_2_bits_uses_ldq : _GEN_222 ? io_dis_uops_1_bits_uses_ldq : io_dis_uops_0_bits_uses_ldq),
    .io_in_uop_bits_uses_stq        (_GEN_224 ? io_dis_uops_3_bits_uses_stq : _GEN_223 ? io_dis_uops_2_bits_uses_stq : _GEN_222 ? io_dis_uops_1_bits_uses_stq : io_dis_uops_0_bits_uses_stq),
    .io_in_uop_bits_ldst_val        (_GEN_224 ? io_dis_uops_3_bits_ldst_val : _GEN_223 ? io_dis_uops_2_bits_ldst_val : _GEN_222 ? io_dis_uops_1_bits_ldst_val : io_dis_uops_0_bits_ldst_val),
    .io_in_uop_bits_dst_rtype       (_GEN_224 ? io_dis_uops_3_bits_dst_rtype : _GEN_223 ? io_dis_uops_2_bits_dst_rtype : _GEN_222 ? io_dis_uops_1_bits_dst_rtype : io_dis_uops_0_bits_dst_rtype),
    .io_in_uop_bits_lrs1_rtype      (_GEN_224 ? io_dis_uops_3_bits_lrs1_rtype : _GEN_223 ? io_dis_uops_2_bits_lrs1_rtype : _GEN_222 ? io_dis_uops_1_bits_lrs1_rtype : io_dis_uops_0_bits_lrs1_rtype),
    .io_in_uop_bits_lrs2_rtype      (_GEN_224 ? (_GEN_15 ? io_dis_uops_3_bits_lrs2_rtype : 2'h2) : _GEN_223 ? _GEN_13 : _GEN_222 ? _GEN_8 : _GEN_7445),
    .io_in_uop_bits_fp_val          (_GEN_224 ? io_dis_uops_3_bits_fp_val : _GEN_223 ? io_dis_uops_2_bits_fp_val : _GEN_222 ? io_dis_uops_1_bits_fp_val : io_dis_uops_0_bits_fp_val),
    .io_valid                       (_slots_23_io_valid),
    .io_will_be_valid               (_slots_23_io_will_be_valid),
    .io_request                     (_slots_23_io_request),
    .io_out_uop_uopc                (_slots_23_io_out_uop_uopc),
    .io_out_uop_is_rvc              (_slots_23_io_out_uop_is_rvc),
    .io_out_uop_fu_code             (_slots_23_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_23_io_out_uop_iw_state),
    .io_out_uop_iw_p1_poisoned      (_slots_23_io_out_uop_iw_p1_poisoned),
    .io_out_uop_iw_p2_poisoned      (_slots_23_io_out_uop_iw_p2_poisoned),
    .io_out_uop_is_br               (_slots_23_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_23_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_23_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_23_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_23_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_23_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_23_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_23_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_23_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_23_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_23_io_out_uop_imm_packed),
    .io_out_uop_rob_idx             (_slots_23_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_23_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_23_io_out_uop_stq_idx),
    .io_out_uop_pdst                (_slots_23_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_23_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_23_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_23_io_out_uop_prs3),
    .io_out_uop_prs1_busy           (_slots_23_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_23_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_23_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_23_io_out_uop_ppred_busy),
    .io_out_uop_bypassable          (_slots_23_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_23_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_23_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_23_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_23_io_out_uop_is_fence),
    .io_out_uop_is_amo              (_slots_23_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_23_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_23_io_out_uop_uses_stq),
    .io_out_uop_ldst_val            (_slots_23_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_23_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_23_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_23_io_out_uop_lrs2_rtype),
    .io_out_uop_fp_val              (_slots_23_io_out_uop_fp_val),
    .io_uop_uopc                    (_slots_23_io_uop_uopc),
    .io_uop_is_rvc                  (/* unused */),
    .io_uop_fu_code                 (_slots_23_io_uop_fu_code),
    .io_uop_iw_p1_poisoned          (_slots_23_io_uop_iw_p1_poisoned),
    .io_uop_iw_p2_poisoned          (_slots_23_io_uop_iw_p2_poisoned),
    .io_uop_is_br                   (/* unused */),
    .io_uop_is_jalr                 (/* unused */),
    .io_uop_is_jal                  (/* unused */),
    .io_uop_is_sfb                  (/* unused */),
    .io_uop_br_mask                 (_slots_23_io_uop_br_mask),
    .io_uop_br_tag                  (/* unused */),
    .io_uop_ftq_idx                 (/* unused */),
    .io_uop_edge_inst               (/* unused */),
    .io_uop_pc_lob                  (/* unused */),
    .io_uop_taken                   (/* unused */),
    .io_uop_imm_packed              (_slots_23_io_uop_imm_packed),
    .io_uop_rob_idx                 (_slots_23_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_23_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_23_io_uop_stq_idx),
    .io_uop_pdst                    (_slots_23_io_uop_pdst),
    .io_uop_prs1                    (_slots_23_io_uop_prs1),
    .io_uop_prs2                    (_slots_23_io_uop_prs2),
    .io_uop_bypassable              (/* unused */),
    .io_uop_mem_cmd                 (_slots_23_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_23_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_23_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_23_io_uop_is_fence),
    .io_uop_is_amo                  (_slots_23_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_23_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_23_io_uop_uses_stq),
    .io_uop_ldst_val                (/* unused */),
    .io_uop_dst_rtype               (/* unused */),
    .io_uop_lrs1_rtype              (_slots_23_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_23_io_uop_lrs2_rtype),
    .io_uop_fp_val                  (_slots_23_io_uop_fp_val)
  );
  assign io_dis_uops_0_ready = io_dis_uops_0_ready_REG;
  assign io_dis_uops_1_ready = io_dis_uops_1_ready_REG;
  assign io_dis_uops_2_ready = io_dis_uops_2_ready_REG;
  assign io_dis_uops_3_ready = io_dis_uops_3_ready_REG;
  assign io_iss_valids_0 = _GEN_11479 | _GEN_11317 | _GEN_11155 | _GEN_10993 | _GEN_10831 | _GEN_10669 | _GEN_10507 | _GEN_10345 | _GEN_10183 | _GEN_10021 | _GEN_9859 | _GEN_9697 | _GEN_9535 | _GEN_9373 | _GEN_9211 | _GEN_9049 | _GEN_8887 | _GEN_8725 | _GEN_8563 | _GEN_8401 | _GEN_8239 | _GEN_8077 | _GEN_7915 | _GEN_7754;
  assign io_iss_valids_1 = _GEN_149 | _GEN_146 | _GEN_150 | _GEN_136 | _GEN_131 | _GEN_137 | _GEN_121 | _GEN_116 | _GEN_122 | _GEN_106 | _GEN_101 | _GEN_107 | _GEN_91 | _GEN_86 | _GEN_92 | _GEN_76 | _GEN_71 | _GEN_77 | _GEN_56 | _GEN_46 | _GEN_58 | _GEN_28 | _GEN_21 | _GEN_7835;
  assign io_iss_uops_0_uopc = _GEN_11479 ? _slots_23_io_uop_uopc : _GEN_11317 ? _slots_22_io_uop_uopc : _GEN_11155 ? _slots_21_io_uop_uopc : _GEN_10993 ? _slots_20_io_uop_uopc : _GEN_10831 ? _slots_19_io_uop_uopc : _GEN_10669 ? _slots_18_io_uop_uopc : _GEN_10507 ? _slots_17_io_uop_uopc : _GEN_10345 ? _slots_16_io_uop_uopc : _GEN_10183 ? _slots_15_io_uop_uopc : _GEN_10021 ? _slots_14_io_uop_uopc : _GEN_9859 ? _slots_13_io_uop_uopc : _GEN_9697 ? _slots_12_io_uop_uopc : _GEN_9535 ? _slots_11_io_uop_uopc : _GEN_9373 ? _slots_10_io_uop_uopc : _GEN_9211 ? _slots_9_io_uop_uopc : _GEN_9049 ? _slots_8_io_uop_uopc : _GEN_8887 ? _slots_7_io_uop_uopc : _GEN_8725 ? _slots_6_io_uop_uopc : _GEN_8563 ? _slots_5_io_uop_uopc : _GEN_8401 ? _slots_4_io_uop_uopc : _GEN_8239 ? _slots_3_io_uop_uopc : _GEN_8077 ? _slots_2_io_uop_uopc : _GEN_7915 ? _slots_1_io_uop_uopc : _GEN_7754 ? _slots_0_io_uop_uopc : 7'h0;
  assign io_iss_uops_0_fu_code = _GEN_11479 ? _slots_23_io_uop_fu_code : _GEN_11317 ? _slots_22_io_uop_fu_code : _GEN_11155 ? _slots_21_io_uop_fu_code : _GEN_10993 ? _slots_20_io_uop_fu_code : _GEN_10831 ? _slots_19_io_uop_fu_code : _GEN_10669 ? _slots_18_io_uop_fu_code : _GEN_10507 ? _slots_17_io_uop_fu_code : _GEN_10345 ? _slots_16_io_uop_fu_code : _GEN_10183 ? _slots_15_io_uop_fu_code : _GEN_10021 ? _slots_14_io_uop_fu_code : _GEN_9859 ? _slots_13_io_uop_fu_code : _GEN_9697 ? _slots_12_io_uop_fu_code : _GEN_9535 ? _slots_11_io_uop_fu_code : _GEN_9373 ? _slots_10_io_uop_fu_code : _GEN_9211 ? _slots_9_io_uop_fu_code : _GEN_9049 ? _slots_8_io_uop_fu_code : _GEN_8887 ? _slots_7_io_uop_fu_code : _GEN_8725 ? _slots_6_io_uop_fu_code : _GEN_8563 ? _slots_5_io_uop_fu_code : _GEN_8401 ? _slots_4_io_uop_fu_code : _GEN_8239 ? _slots_3_io_uop_fu_code : _GEN_8077 ? _slots_2_io_uop_fu_code : _GEN_7915 ? _slots_1_io_uop_fu_code : _GEN_7754 ? _slots_0_io_uop_fu_code : 10'h0;
  assign io_iss_uops_0_iw_p1_poisoned = _GEN_11479 ? _slots_23_io_uop_iw_p1_poisoned : _GEN_11317 ? _slots_22_io_uop_iw_p1_poisoned : _GEN_11155 ? _slots_21_io_uop_iw_p1_poisoned : _GEN_10993 ? _slots_20_io_uop_iw_p1_poisoned : _GEN_10831 ? _slots_19_io_uop_iw_p1_poisoned : _GEN_10669 ? _slots_18_io_uop_iw_p1_poisoned : _GEN_10507 ? _slots_17_io_uop_iw_p1_poisoned : _GEN_10345 ? _slots_16_io_uop_iw_p1_poisoned : _GEN_10183 ? _slots_15_io_uop_iw_p1_poisoned : _GEN_10021 ? _slots_14_io_uop_iw_p1_poisoned : _GEN_9859 ? _slots_13_io_uop_iw_p1_poisoned : _GEN_9697 ? _slots_12_io_uop_iw_p1_poisoned : _GEN_9535 ? _slots_11_io_uop_iw_p1_poisoned : _GEN_9373 ? _slots_10_io_uop_iw_p1_poisoned : _GEN_9211 ? _slots_9_io_uop_iw_p1_poisoned : _GEN_9049 ? _slots_8_io_uop_iw_p1_poisoned : _GEN_8887 ? _slots_7_io_uop_iw_p1_poisoned : _GEN_8725 ? _slots_6_io_uop_iw_p1_poisoned : _GEN_8563 ? _slots_5_io_uop_iw_p1_poisoned : _GEN_8401 ? _slots_4_io_uop_iw_p1_poisoned : _GEN_8239 ? _slots_3_io_uop_iw_p1_poisoned : _GEN_8077 ? _slots_2_io_uop_iw_p1_poisoned : _GEN_7915 ? _slots_1_io_uop_iw_p1_poisoned : _GEN_7754 & _slots_0_io_uop_iw_p1_poisoned;
  assign io_iss_uops_0_iw_p2_poisoned = _GEN_11479 ? _slots_23_io_uop_iw_p2_poisoned : _GEN_11317 ? _slots_22_io_uop_iw_p2_poisoned : _GEN_11155 ? _slots_21_io_uop_iw_p2_poisoned : _GEN_10993 ? _slots_20_io_uop_iw_p2_poisoned : _GEN_10831 ? _slots_19_io_uop_iw_p2_poisoned : _GEN_10669 ? _slots_18_io_uop_iw_p2_poisoned : _GEN_10507 ? _slots_17_io_uop_iw_p2_poisoned : _GEN_10345 ? _slots_16_io_uop_iw_p2_poisoned : _GEN_10183 ? _slots_15_io_uop_iw_p2_poisoned : _GEN_10021 ? _slots_14_io_uop_iw_p2_poisoned : _GEN_9859 ? _slots_13_io_uop_iw_p2_poisoned : _GEN_9697 ? _slots_12_io_uop_iw_p2_poisoned : _GEN_9535 ? _slots_11_io_uop_iw_p2_poisoned : _GEN_9373 ? _slots_10_io_uop_iw_p2_poisoned : _GEN_9211 ? _slots_9_io_uop_iw_p2_poisoned : _GEN_9049 ? _slots_8_io_uop_iw_p2_poisoned : _GEN_8887 ? _slots_7_io_uop_iw_p2_poisoned : _GEN_8725 ? _slots_6_io_uop_iw_p2_poisoned : _GEN_8563 ? _slots_5_io_uop_iw_p2_poisoned : _GEN_8401 ? _slots_4_io_uop_iw_p2_poisoned : _GEN_8239 ? _slots_3_io_uop_iw_p2_poisoned : _GEN_8077 ? _slots_2_io_uop_iw_p2_poisoned : _GEN_7915 ? _slots_1_io_uop_iw_p2_poisoned : _GEN_7754 & _slots_0_io_uop_iw_p2_poisoned;
  assign io_iss_uops_0_br_mask = _GEN_11479 ? _slots_23_io_uop_br_mask : _GEN_11317 ? _slots_22_io_uop_br_mask : _GEN_11155 ? _slots_21_io_uop_br_mask : _GEN_10993 ? _slots_20_io_uop_br_mask : _GEN_10831 ? _slots_19_io_uop_br_mask : _GEN_10669 ? _slots_18_io_uop_br_mask : _GEN_10507 ? _slots_17_io_uop_br_mask : _GEN_10345 ? _slots_16_io_uop_br_mask : _GEN_10183 ? _slots_15_io_uop_br_mask : _GEN_10021 ? _slots_14_io_uop_br_mask : _GEN_9859 ? _slots_13_io_uop_br_mask : _GEN_9697 ? _slots_12_io_uop_br_mask : _GEN_9535 ? _slots_11_io_uop_br_mask : _GEN_9373 ? _slots_10_io_uop_br_mask : _GEN_9211 ? _slots_9_io_uop_br_mask : _GEN_9049 ? _slots_8_io_uop_br_mask : _GEN_8887 ? _slots_7_io_uop_br_mask : _GEN_8725 ? _slots_6_io_uop_br_mask : _GEN_8563 ? _slots_5_io_uop_br_mask : _GEN_8401 ? _slots_4_io_uop_br_mask : _GEN_8239 ? _slots_3_io_uop_br_mask : _GEN_8077 ? _slots_2_io_uop_br_mask : _GEN_7915 ? _slots_1_io_uop_br_mask : _GEN_7754 ? _slots_0_io_uop_br_mask : 20'h0;
  assign io_iss_uops_0_imm_packed = _GEN_11479 ? _slots_23_io_uop_imm_packed : _GEN_11317 ? _slots_22_io_uop_imm_packed : _GEN_11155 ? _slots_21_io_uop_imm_packed : _GEN_10993 ? _slots_20_io_uop_imm_packed : _GEN_10831 ? _slots_19_io_uop_imm_packed : _GEN_10669 ? _slots_18_io_uop_imm_packed : _GEN_10507 ? _slots_17_io_uop_imm_packed : _GEN_10345 ? _slots_16_io_uop_imm_packed : _GEN_10183 ? _slots_15_io_uop_imm_packed : _GEN_10021 ? _slots_14_io_uop_imm_packed : _GEN_9859 ? _slots_13_io_uop_imm_packed : _GEN_9697 ? _slots_12_io_uop_imm_packed : _GEN_9535 ? _slots_11_io_uop_imm_packed : _GEN_9373 ? _slots_10_io_uop_imm_packed : _GEN_9211 ? _slots_9_io_uop_imm_packed : _GEN_9049 ? _slots_8_io_uop_imm_packed : _GEN_8887 ? _slots_7_io_uop_imm_packed : _GEN_8725 ? _slots_6_io_uop_imm_packed : _GEN_8563 ? _slots_5_io_uop_imm_packed : _GEN_8401 ? _slots_4_io_uop_imm_packed : _GEN_8239 ? _slots_3_io_uop_imm_packed : _GEN_8077 ? _slots_2_io_uop_imm_packed : _GEN_7915 ? _slots_1_io_uop_imm_packed : _GEN_7754 ? _slots_0_io_uop_imm_packed : 20'h0;
  assign io_iss_uops_0_rob_idx = _GEN_11479 ? _slots_23_io_uop_rob_idx : _GEN_11317 ? _slots_22_io_uop_rob_idx : _GEN_11155 ? _slots_21_io_uop_rob_idx : _GEN_10993 ? _slots_20_io_uop_rob_idx : _GEN_10831 ? _slots_19_io_uop_rob_idx : _GEN_10669 ? _slots_18_io_uop_rob_idx : _GEN_10507 ? _slots_17_io_uop_rob_idx : _GEN_10345 ? _slots_16_io_uop_rob_idx : _GEN_10183 ? _slots_15_io_uop_rob_idx : _GEN_10021 ? _slots_14_io_uop_rob_idx : _GEN_9859 ? _slots_13_io_uop_rob_idx : _GEN_9697 ? _slots_12_io_uop_rob_idx : _GEN_9535 ? _slots_11_io_uop_rob_idx : _GEN_9373 ? _slots_10_io_uop_rob_idx : _GEN_9211 ? _slots_9_io_uop_rob_idx : _GEN_9049 ? _slots_8_io_uop_rob_idx : _GEN_8887 ? _slots_7_io_uop_rob_idx : _GEN_8725 ? _slots_6_io_uop_rob_idx : _GEN_8563 ? _slots_5_io_uop_rob_idx : _GEN_8401 ? _slots_4_io_uop_rob_idx : _GEN_8239 ? _slots_3_io_uop_rob_idx : _GEN_8077 ? _slots_2_io_uop_rob_idx : _GEN_7915 ? _slots_1_io_uop_rob_idx : _GEN_7754 ? _slots_0_io_uop_rob_idx : 7'h0;
  assign io_iss_uops_0_ldq_idx = _GEN_11479 ? _slots_23_io_uop_ldq_idx : _GEN_11317 ? _slots_22_io_uop_ldq_idx : _GEN_11155 ? _slots_21_io_uop_ldq_idx : _GEN_10993 ? _slots_20_io_uop_ldq_idx : _GEN_10831 ? _slots_19_io_uop_ldq_idx : _GEN_10669 ? _slots_18_io_uop_ldq_idx : _GEN_10507 ? _slots_17_io_uop_ldq_idx : _GEN_10345 ? _slots_16_io_uop_ldq_idx : _GEN_10183 ? _slots_15_io_uop_ldq_idx : _GEN_10021 ? _slots_14_io_uop_ldq_idx : _GEN_9859 ? _slots_13_io_uop_ldq_idx : _GEN_9697 ? _slots_12_io_uop_ldq_idx : _GEN_9535 ? _slots_11_io_uop_ldq_idx : _GEN_9373 ? _slots_10_io_uop_ldq_idx : _GEN_9211 ? _slots_9_io_uop_ldq_idx : _GEN_9049 ? _slots_8_io_uop_ldq_idx : _GEN_8887 ? _slots_7_io_uop_ldq_idx : _GEN_8725 ? _slots_6_io_uop_ldq_idx : _GEN_8563 ? _slots_5_io_uop_ldq_idx : _GEN_8401 ? _slots_4_io_uop_ldq_idx : _GEN_8239 ? _slots_3_io_uop_ldq_idx : _GEN_8077 ? _slots_2_io_uop_ldq_idx : _GEN_7915 ? _slots_1_io_uop_ldq_idx : _GEN_7754 ? _slots_0_io_uop_ldq_idx : 5'h0;
  assign io_iss_uops_0_stq_idx = _GEN_11479 ? _slots_23_io_uop_stq_idx : _GEN_11317 ? _slots_22_io_uop_stq_idx : _GEN_11155 ? _slots_21_io_uop_stq_idx : _GEN_10993 ? _slots_20_io_uop_stq_idx : _GEN_10831 ? _slots_19_io_uop_stq_idx : _GEN_10669 ? _slots_18_io_uop_stq_idx : _GEN_10507 ? _slots_17_io_uop_stq_idx : _GEN_10345 ? _slots_16_io_uop_stq_idx : _GEN_10183 ? _slots_15_io_uop_stq_idx : _GEN_10021 ? _slots_14_io_uop_stq_idx : _GEN_9859 ? _slots_13_io_uop_stq_idx : _GEN_9697 ? _slots_12_io_uop_stq_idx : _GEN_9535 ? _slots_11_io_uop_stq_idx : _GEN_9373 ? _slots_10_io_uop_stq_idx : _GEN_9211 ? _slots_9_io_uop_stq_idx : _GEN_9049 ? _slots_8_io_uop_stq_idx : _GEN_8887 ? _slots_7_io_uop_stq_idx : _GEN_8725 ? _slots_6_io_uop_stq_idx : _GEN_8563 ? _slots_5_io_uop_stq_idx : _GEN_8401 ? _slots_4_io_uop_stq_idx : _GEN_8239 ? _slots_3_io_uop_stq_idx : _GEN_8077 ? _slots_2_io_uop_stq_idx : _GEN_7915 ? _slots_1_io_uop_stq_idx : _GEN_7754 ? _slots_0_io_uop_stq_idx : 5'h0;
  assign io_iss_uops_0_pdst = _GEN_11479 ? _slots_23_io_uop_pdst : _GEN_11317 ? _slots_22_io_uop_pdst : _GEN_11155 ? _slots_21_io_uop_pdst : _GEN_10993 ? _slots_20_io_uop_pdst : _GEN_10831 ? _slots_19_io_uop_pdst : _GEN_10669 ? _slots_18_io_uop_pdst : _GEN_10507 ? _slots_17_io_uop_pdst : _GEN_10345 ? _slots_16_io_uop_pdst : _GEN_10183 ? _slots_15_io_uop_pdst : _GEN_10021 ? _slots_14_io_uop_pdst : _GEN_9859 ? _slots_13_io_uop_pdst : _GEN_9697 ? _slots_12_io_uop_pdst : _GEN_9535 ? _slots_11_io_uop_pdst : _GEN_9373 ? _slots_10_io_uop_pdst : _GEN_9211 ? _slots_9_io_uop_pdst : _GEN_9049 ? _slots_8_io_uop_pdst : _GEN_8887 ? _slots_7_io_uop_pdst : _GEN_8725 ? _slots_6_io_uop_pdst : _GEN_8563 ? _slots_5_io_uop_pdst : _GEN_8401 ? _slots_4_io_uop_pdst : _GEN_8239 ? _slots_3_io_uop_pdst : _GEN_8077 ? _slots_2_io_uop_pdst : _GEN_7915 ? _slots_1_io_uop_pdst : _GEN_7754 ? _slots_0_io_uop_pdst : 7'h0;
  assign io_iss_uops_0_prs1 = _GEN_11479 ? _slots_23_io_uop_prs1 : _GEN_11317 ? _slots_22_io_uop_prs1 : _GEN_11155 ? _slots_21_io_uop_prs1 : _GEN_10993 ? _slots_20_io_uop_prs1 : _GEN_10831 ? _slots_19_io_uop_prs1 : _GEN_10669 ? _slots_18_io_uop_prs1 : _GEN_10507 ? _slots_17_io_uop_prs1 : _GEN_10345 ? _slots_16_io_uop_prs1 : _GEN_10183 ? _slots_15_io_uop_prs1 : _GEN_10021 ? _slots_14_io_uop_prs1 : _GEN_9859 ? _slots_13_io_uop_prs1 : _GEN_9697 ? _slots_12_io_uop_prs1 : _GEN_9535 ? _slots_11_io_uop_prs1 : _GEN_9373 ? _slots_10_io_uop_prs1 : _GEN_9211 ? _slots_9_io_uop_prs1 : _GEN_9049 ? _slots_8_io_uop_prs1 : _GEN_8887 ? _slots_7_io_uop_prs1 : _GEN_8725 ? _slots_6_io_uop_prs1 : _GEN_8563 ? _slots_5_io_uop_prs1 : _GEN_8401 ? _slots_4_io_uop_prs1 : _GEN_8239 ? _slots_3_io_uop_prs1 : _GEN_8077 ? _slots_2_io_uop_prs1 : _GEN_7915 ? _slots_1_io_uop_prs1 : _GEN_7754 ? _slots_0_io_uop_prs1 : 7'h0;
  assign io_iss_uops_0_prs2 = _GEN_11479 ? _slots_23_io_uop_prs2 : _GEN_11317 ? _slots_22_io_uop_prs2 : _GEN_11155 ? _slots_21_io_uop_prs2 : _GEN_10993 ? _slots_20_io_uop_prs2 : _GEN_10831 ? _slots_19_io_uop_prs2 : _GEN_10669 ? _slots_18_io_uop_prs2 : _GEN_10507 ? _slots_17_io_uop_prs2 : _GEN_10345 ? _slots_16_io_uop_prs2 : _GEN_10183 ? _slots_15_io_uop_prs2 : _GEN_10021 ? _slots_14_io_uop_prs2 : _GEN_9859 ? _slots_13_io_uop_prs2 : _GEN_9697 ? _slots_12_io_uop_prs2 : _GEN_9535 ? _slots_11_io_uop_prs2 : _GEN_9373 ? _slots_10_io_uop_prs2 : _GEN_9211 ? _slots_9_io_uop_prs2 : _GEN_9049 ? _slots_8_io_uop_prs2 : _GEN_8887 ? _slots_7_io_uop_prs2 : _GEN_8725 ? _slots_6_io_uop_prs2 : _GEN_8563 ? _slots_5_io_uop_prs2 : _GEN_8401 ? _slots_4_io_uop_prs2 : _GEN_8239 ? _slots_3_io_uop_prs2 : _GEN_8077 ? _slots_2_io_uop_prs2 : _GEN_7915 ? _slots_1_io_uop_prs2 : _GEN_7754 ? _slots_0_io_uop_prs2 : 7'h0;
  assign io_iss_uops_0_mem_cmd = _GEN_11479 ? _slots_23_io_uop_mem_cmd : _GEN_11317 ? _slots_22_io_uop_mem_cmd : _GEN_11155 ? _slots_21_io_uop_mem_cmd : _GEN_10993 ? _slots_20_io_uop_mem_cmd : _GEN_10831 ? _slots_19_io_uop_mem_cmd : _GEN_10669 ? _slots_18_io_uop_mem_cmd : _GEN_10507 ? _slots_17_io_uop_mem_cmd : _GEN_10345 ? _slots_16_io_uop_mem_cmd : _GEN_10183 ? _slots_15_io_uop_mem_cmd : _GEN_10021 ? _slots_14_io_uop_mem_cmd : _GEN_9859 ? _slots_13_io_uop_mem_cmd : _GEN_9697 ? _slots_12_io_uop_mem_cmd : _GEN_9535 ? _slots_11_io_uop_mem_cmd : _GEN_9373 ? _slots_10_io_uop_mem_cmd : _GEN_9211 ? _slots_9_io_uop_mem_cmd : _GEN_9049 ? _slots_8_io_uop_mem_cmd : _GEN_8887 ? _slots_7_io_uop_mem_cmd : _GEN_8725 ? _slots_6_io_uop_mem_cmd : _GEN_8563 ? _slots_5_io_uop_mem_cmd : _GEN_8401 ? _slots_4_io_uop_mem_cmd : _GEN_8239 ? _slots_3_io_uop_mem_cmd : _GEN_8077 ? _slots_2_io_uop_mem_cmd : _GEN_7915 ? _slots_1_io_uop_mem_cmd : _GEN_7754 ? _slots_0_io_uop_mem_cmd : 5'h0;
  assign io_iss_uops_0_mem_size = _GEN_11479 ? _slots_23_io_uop_mem_size : _GEN_11317 ? _slots_22_io_uop_mem_size : _GEN_11155 ? _slots_21_io_uop_mem_size : _GEN_10993 ? _slots_20_io_uop_mem_size : _GEN_10831 ? _slots_19_io_uop_mem_size : _GEN_10669 ? _slots_18_io_uop_mem_size : _GEN_10507 ? _slots_17_io_uop_mem_size : _GEN_10345 ? _slots_16_io_uop_mem_size : _GEN_10183 ? _slots_15_io_uop_mem_size : _GEN_10021 ? _slots_14_io_uop_mem_size : _GEN_9859 ? _slots_13_io_uop_mem_size : _GEN_9697 ? _slots_12_io_uop_mem_size : _GEN_9535 ? _slots_11_io_uop_mem_size : _GEN_9373 ? _slots_10_io_uop_mem_size : _GEN_9211 ? _slots_9_io_uop_mem_size : _GEN_9049 ? _slots_8_io_uop_mem_size : _GEN_8887 ? _slots_7_io_uop_mem_size : _GEN_8725 ? _slots_6_io_uop_mem_size : _GEN_8563 ? _slots_5_io_uop_mem_size : _GEN_8401 ? _slots_4_io_uop_mem_size : _GEN_8239 ? _slots_3_io_uop_mem_size : _GEN_8077 ? _slots_2_io_uop_mem_size : _GEN_7915 ? _slots_1_io_uop_mem_size : _GEN_7754 ? _slots_0_io_uop_mem_size : 2'h0;
  assign io_iss_uops_0_mem_signed = _GEN_11479 ? _slots_23_io_uop_mem_signed : _GEN_11317 ? _slots_22_io_uop_mem_signed : _GEN_11155 ? _slots_21_io_uop_mem_signed : _GEN_10993 ? _slots_20_io_uop_mem_signed : _GEN_10831 ? _slots_19_io_uop_mem_signed : _GEN_10669 ? _slots_18_io_uop_mem_signed : _GEN_10507 ? _slots_17_io_uop_mem_signed : _GEN_10345 ? _slots_16_io_uop_mem_signed : _GEN_10183 ? _slots_15_io_uop_mem_signed : _GEN_10021 ? _slots_14_io_uop_mem_signed : _GEN_9859 ? _slots_13_io_uop_mem_signed : _GEN_9697 ? _slots_12_io_uop_mem_signed : _GEN_9535 ? _slots_11_io_uop_mem_signed : _GEN_9373 ? _slots_10_io_uop_mem_signed : _GEN_9211 ? _slots_9_io_uop_mem_signed : _GEN_9049 ? _slots_8_io_uop_mem_signed : _GEN_8887 ? _slots_7_io_uop_mem_signed : _GEN_8725 ? _slots_6_io_uop_mem_signed : _GEN_8563 ? _slots_5_io_uop_mem_signed : _GEN_8401 ? _slots_4_io_uop_mem_signed : _GEN_8239 ? _slots_3_io_uop_mem_signed : _GEN_8077 ? _slots_2_io_uop_mem_signed : _GEN_7915 ? _slots_1_io_uop_mem_signed : _GEN_7754 & _slots_0_io_uop_mem_signed;
  assign io_iss_uops_0_is_fence = _GEN_11479 ? _slots_23_io_uop_is_fence : _GEN_11317 ? _slots_22_io_uop_is_fence : _GEN_11155 ? _slots_21_io_uop_is_fence : _GEN_10993 ? _slots_20_io_uop_is_fence : _GEN_10831 ? _slots_19_io_uop_is_fence : _GEN_10669 ? _slots_18_io_uop_is_fence : _GEN_10507 ? _slots_17_io_uop_is_fence : _GEN_10345 ? _slots_16_io_uop_is_fence : _GEN_10183 ? _slots_15_io_uop_is_fence : _GEN_10021 ? _slots_14_io_uop_is_fence : _GEN_9859 ? _slots_13_io_uop_is_fence : _GEN_9697 ? _slots_12_io_uop_is_fence : _GEN_9535 ? _slots_11_io_uop_is_fence : _GEN_9373 ? _slots_10_io_uop_is_fence : _GEN_9211 ? _slots_9_io_uop_is_fence : _GEN_9049 ? _slots_8_io_uop_is_fence : _GEN_8887 ? _slots_7_io_uop_is_fence : _GEN_8725 ? _slots_6_io_uop_is_fence : _GEN_8563 ? _slots_5_io_uop_is_fence : _GEN_8401 ? _slots_4_io_uop_is_fence : _GEN_8239 ? _slots_3_io_uop_is_fence : _GEN_8077 ? _slots_2_io_uop_is_fence : _GEN_7915 ? _slots_1_io_uop_is_fence : _GEN_7754 & _slots_0_io_uop_is_fence;
  assign io_iss_uops_0_is_amo = _GEN_11479 ? _slots_23_io_uop_is_amo : _GEN_11317 ? _slots_22_io_uop_is_amo : _GEN_11155 ? _slots_21_io_uop_is_amo : _GEN_10993 ? _slots_20_io_uop_is_amo : _GEN_10831 ? _slots_19_io_uop_is_amo : _GEN_10669 ? _slots_18_io_uop_is_amo : _GEN_10507 ? _slots_17_io_uop_is_amo : _GEN_10345 ? _slots_16_io_uop_is_amo : _GEN_10183 ? _slots_15_io_uop_is_amo : _GEN_10021 ? _slots_14_io_uop_is_amo : _GEN_9859 ? _slots_13_io_uop_is_amo : _GEN_9697 ? _slots_12_io_uop_is_amo : _GEN_9535 ? _slots_11_io_uop_is_amo : _GEN_9373 ? _slots_10_io_uop_is_amo : _GEN_9211 ? _slots_9_io_uop_is_amo : _GEN_9049 ? _slots_8_io_uop_is_amo : _GEN_8887 ? _slots_7_io_uop_is_amo : _GEN_8725 ? _slots_6_io_uop_is_amo : _GEN_8563 ? _slots_5_io_uop_is_amo : _GEN_8401 ? _slots_4_io_uop_is_amo : _GEN_8239 ? _slots_3_io_uop_is_amo : _GEN_8077 ? _slots_2_io_uop_is_amo : _GEN_7915 ? _slots_1_io_uop_is_amo : _GEN_7754 & _slots_0_io_uop_is_amo;
  assign io_iss_uops_0_uses_ldq = _GEN_11479 ? _slots_23_io_uop_uses_ldq : _GEN_11317 ? _slots_22_io_uop_uses_ldq : _GEN_11155 ? _slots_21_io_uop_uses_ldq : _GEN_10993 ? _slots_20_io_uop_uses_ldq : _GEN_10831 ? _slots_19_io_uop_uses_ldq : _GEN_10669 ? _slots_18_io_uop_uses_ldq : _GEN_10507 ? _slots_17_io_uop_uses_ldq : _GEN_10345 ? _slots_16_io_uop_uses_ldq : _GEN_10183 ? _slots_15_io_uop_uses_ldq : _GEN_10021 ? _slots_14_io_uop_uses_ldq : _GEN_9859 ? _slots_13_io_uop_uses_ldq : _GEN_9697 ? _slots_12_io_uop_uses_ldq : _GEN_9535 ? _slots_11_io_uop_uses_ldq : _GEN_9373 ? _slots_10_io_uop_uses_ldq : _GEN_9211 ? _slots_9_io_uop_uses_ldq : _GEN_9049 ? _slots_8_io_uop_uses_ldq : _GEN_8887 ? _slots_7_io_uop_uses_ldq : _GEN_8725 ? _slots_6_io_uop_uses_ldq : _GEN_8563 ? _slots_5_io_uop_uses_ldq : _GEN_8401 ? _slots_4_io_uop_uses_ldq : _GEN_8239 ? _slots_3_io_uop_uses_ldq : _GEN_8077 ? _slots_2_io_uop_uses_ldq : _GEN_7915 ? _slots_1_io_uop_uses_ldq : _GEN_7754 & _slots_0_io_uop_uses_ldq;
  assign io_iss_uops_0_uses_stq = _GEN_11479 ? _slots_23_io_uop_uses_stq : _GEN_11317 ? _slots_22_io_uop_uses_stq : _GEN_11155 ? _slots_21_io_uop_uses_stq : _GEN_10993 ? _slots_20_io_uop_uses_stq : _GEN_10831 ? _slots_19_io_uop_uses_stq : _GEN_10669 ? _slots_18_io_uop_uses_stq : _GEN_10507 ? _slots_17_io_uop_uses_stq : _GEN_10345 ? _slots_16_io_uop_uses_stq : _GEN_10183 ? _slots_15_io_uop_uses_stq : _GEN_10021 ? _slots_14_io_uop_uses_stq : _GEN_9859 ? _slots_13_io_uop_uses_stq : _GEN_9697 ? _slots_12_io_uop_uses_stq : _GEN_9535 ? _slots_11_io_uop_uses_stq : _GEN_9373 ? _slots_10_io_uop_uses_stq : _GEN_9211 ? _slots_9_io_uop_uses_stq : _GEN_9049 ? _slots_8_io_uop_uses_stq : _GEN_8887 ? _slots_7_io_uop_uses_stq : _GEN_8725 ? _slots_6_io_uop_uses_stq : _GEN_8563 ? _slots_5_io_uop_uses_stq : _GEN_8401 ? _slots_4_io_uop_uses_stq : _GEN_8239 ? _slots_3_io_uop_uses_stq : _GEN_8077 ? _slots_2_io_uop_uses_stq : _GEN_7915 ? _slots_1_io_uop_uses_stq : _GEN_7754 & _slots_0_io_uop_uses_stq;
  assign io_iss_uops_0_lrs1_rtype = _GEN_11479 ? _slots_23_io_uop_lrs1_rtype : _GEN_11317 ? _slots_22_io_uop_lrs1_rtype : _GEN_11155 ? _slots_21_io_uop_lrs1_rtype : _GEN_10993 ? _slots_20_io_uop_lrs1_rtype : _GEN_10831 ? _slots_19_io_uop_lrs1_rtype : _GEN_10669 ? _slots_18_io_uop_lrs1_rtype : _GEN_10507 ? _slots_17_io_uop_lrs1_rtype : _GEN_10345 ? _slots_16_io_uop_lrs1_rtype : _GEN_10183 ? _slots_15_io_uop_lrs1_rtype : _GEN_10021 ? _slots_14_io_uop_lrs1_rtype : _GEN_9859 ? _slots_13_io_uop_lrs1_rtype : _GEN_9697 ? _slots_12_io_uop_lrs1_rtype : _GEN_9535 ? _slots_11_io_uop_lrs1_rtype : _GEN_9373 ? _slots_10_io_uop_lrs1_rtype : _GEN_9211 ? _slots_9_io_uop_lrs1_rtype : _GEN_9049 ? _slots_8_io_uop_lrs1_rtype : _GEN_8887 ? _slots_7_io_uop_lrs1_rtype : _GEN_8725 ? _slots_6_io_uop_lrs1_rtype : _GEN_8563 ? _slots_5_io_uop_lrs1_rtype : _GEN_8401 ? _slots_4_io_uop_lrs1_rtype : _GEN_8239 ? _slots_3_io_uop_lrs1_rtype : _GEN_8077 ? _slots_2_io_uop_lrs1_rtype : _GEN_7915 ? _slots_1_io_uop_lrs1_rtype : _GEN_7754 ? _slots_0_io_uop_lrs1_rtype : 2'h2;
  assign io_iss_uops_0_lrs2_rtype = _GEN_11479 ? _slots_23_io_uop_lrs2_rtype : _GEN_11317 ? _slots_22_io_uop_lrs2_rtype : _GEN_11155 ? _slots_21_io_uop_lrs2_rtype : _GEN_10993 ? _slots_20_io_uop_lrs2_rtype : _GEN_10831 ? _slots_19_io_uop_lrs2_rtype : _GEN_10669 ? _slots_18_io_uop_lrs2_rtype : _GEN_10507 ? _slots_17_io_uop_lrs2_rtype : _GEN_10345 ? _slots_16_io_uop_lrs2_rtype : _GEN_10183 ? _slots_15_io_uop_lrs2_rtype : _GEN_10021 ? _slots_14_io_uop_lrs2_rtype : _GEN_9859 ? _slots_13_io_uop_lrs2_rtype : _GEN_9697 ? _slots_12_io_uop_lrs2_rtype : _GEN_9535 ? _slots_11_io_uop_lrs2_rtype : _GEN_9373 ? _slots_10_io_uop_lrs2_rtype : _GEN_9211 ? _slots_9_io_uop_lrs2_rtype : _GEN_9049 ? _slots_8_io_uop_lrs2_rtype : _GEN_8887 ? _slots_7_io_uop_lrs2_rtype : _GEN_8725 ? _slots_6_io_uop_lrs2_rtype : _GEN_8563 ? _slots_5_io_uop_lrs2_rtype : _GEN_8401 ? _slots_4_io_uop_lrs2_rtype : _GEN_8239 ? _slots_3_io_uop_lrs2_rtype : _GEN_8077 ? _slots_2_io_uop_lrs2_rtype : _GEN_7915 ? _slots_1_io_uop_lrs2_rtype : _GEN_7754 ? _slots_0_io_uop_lrs2_rtype : 2'h2;
  assign io_iss_uops_0_fp_val = _GEN_11479 ? _slots_23_io_uop_fp_val : _GEN_11317 ? _slots_22_io_uop_fp_val : _GEN_11155 ? _slots_21_io_uop_fp_val : _GEN_10993 ? _slots_20_io_uop_fp_val : _GEN_10831 ? _slots_19_io_uop_fp_val : _GEN_10669 ? _slots_18_io_uop_fp_val : _GEN_10507 ? _slots_17_io_uop_fp_val : _GEN_10345 ? _slots_16_io_uop_fp_val : _GEN_10183 ? _slots_15_io_uop_fp_val : _GEN_10021 ? _slots_14_io_uop_fp_val : _GEN_9859 ? _slots_13_io_uop_fp_val : _GEN_9697 ? _slots_12_io_uop_fp_val : _GEN_9535 ? _slots_11_io_uop_fp_val : _GEN_9373 ? _slots_10_io_uop_fp_val : _GEN_9211 ? _slots_9_io_uop_fp_val : _GEN_9049 ? _slots_8_io_uop_fp_val : _GEN_8887 ? _slots_7_io_uop_fp_val : _GEN_8725 ? _slots_6_io_uop_fp_val : _GEN_8563 ? _slots_5_io_uop_fp_val : _GEN_8401 ? _slots_4_io_uop_fp_val : _GEN_8239 ? _slots_3_io_uop_fp_val : _GEN_8077 ? _slots_2_io_uop_fp_val : _GEN_7915 ? _slots_1_io_uop_fp_val : _GEN_7754 & _slots_0_io_uop_fp_val;
  assign io_iss_uops_1_uopc = _GEN_149 ? _slots_23_io_uop_uopc : _GEN_146 ? _slots_22_io_uop_uopc : _GEN_150 ? _slots_21_io_uop_uopc : _GEN_136 ? _slots_20_io_uop_uopc : _GEN_131 ? _slots_19_io_uop_uopc : _GEN_137 ? _slots_18_io_uop_uopc : _GEN_121 ? _slots_17_io_uop_uopc : _GEN_116 ? _slots_16_io_uop_uopc : _GEN_122 ? _slots_15_io_uop_uopc : _GEN_106 ? _slots_14_io_uop_uopc : _GEN_101 ? _slots_13_io_uop_uopc : _GEN_107 ? _slots_12_io_uop_uopc : _GEN_91 ? _slots_11_io_uop_uopc : _GEN_86 ? _slots_10_io_uop_uopc : _GEN_92 ? _slots_9_io_uop_uopc : _GEN_76 ? _slots_8_io_uop_uopc : _GEN_71 ? _slots_7_io_uop_uopc : _GEN_77 ? _slots_6_io_uop_uopc : _GEN_56 ? _slots_5_io_uop_uopc : _GEN_46 ? _slots_4_io_uop_uopc : _GEN_58 ? _slots_3_io_uop_uopc : _GEN_28 ? _slots_2_io_uop_uopc : _GEN_21 ? _slots_1_io_uop_uopc : _GEN_7835 ? _slots_0_io_uop_uopc : 7'h0;
  assign io_iss_uops_1_fu_code = _GEN_149 ? _slots_23_io_uop_fu_code : _GEN_146 ? _slots_22_io_uop_fu_code : _GEN_150 ? _slots_21_io_uop_fu_code : _GEN_136 ? _slots_20_io_uop_fu_code : _GEN_131 ? _slots_19_io_uop_fu_code : _GEN_137 ? _slots_18_io_uop_fu_code : _GEN_121 ? _slots_17_io_uop_fu_code : _GEN_116 ? _slots_16_io_uop_fu_code : _GEN_122 ? _slots_15_io_uop_fu_code : _GEN_106 ? _slots_14_io_uop_fu_code : _GEN_101 ? _slots_13_io_uop_fu_code : _GEN_107 ? _slots_12_io_uop_fu_code : _GEN_91 ? _slots_11_io_uop_fu_code : _GEN_86 ? _slots_10_io_uop_fu_code : _GEN_92 ? _slots_9_io_uop_fu_code : _GEN_76 ? _slots_8_io_uop_fu_code : _GEN_71 ? _slots_7_io_uop_fu_code : _GEN_77 ? _slots_6_io_uop_fu_code : _GEN_56 ? _slots_5_io_uop_fu_code : _GEN_46 ? _slots_4_io_uop_fu_code : _GEN_58 ? _slots_3_io_uop_fu_code : _GEN_28 ? _slots_2_io_uop_fu_code : _GEN_21 ? _slots_1_io_uop_fu_code : _GEN_7835 ? _slots_0_io_uop_fu_code : 10'h0;
  assign io_iss_uops_1_iw_p1_poisoned = _GEN_149 ? _slots_23_io_uop_iw_p1_poisoned : _GEN_146 ? _slots_22_io_uop_iw_p1_poisoned : _GEN_150 ? _slots_21_io_uop_iw_p1_poisoned : _GEN_136 ? _slots_20_io_uop_iw_p1_poisoned : _GEN_131 ? _slots_19_io_uop_iw_p1_poisoned : _GEN_137 ? _slots_18_io_uop_iw_p1_poisoned : _GEN_121 ? _slots_17_io_uop_iw_p1_poisoned : _GEN_116 ? _slots_16_io_uop_iw_p1_poisoned : _GEN_122 ? _slots_15_io_uop_iw_p1_poisoned : _GEN_106 ? _slots_14_io_uop_iw_p1_poisoned : _GEN_101 ? _slots_13_io_uop_iw_p1_poisoned : _GEN_107 ? _slots_12_io_uop_iw_p1_poisoned : _GEN_91 ? _slots_11_io_uop_iw_p1_poisoned : _GEN_86 ? _slots_10_io_uop_iw_p1_poisoned : _GEN_92 ? _slots_9_io_uop_iw_p1_poisoned : _GEN_76 ? _slots_8_io_uop_iw_p1_poisoned : _GEN_71 ? _slots_7_io_uop_iw_p1_poisoned : _GEN_77 ? _slots_6_io_uop_iw_p1_poisoned : _GEN_56 ? _slots_5_io_uop_iw_p1_poisoned : _GEN_46 ? _slots_4_io_uop_iw_p1_poisoned : _GEN_58 ? _slots_3_io_uop_iw_p1_poisoned : _GEN_28 ? _slots_2_io_uop_iw_p1_poisoned : _GEN_21 ? _slots_1_io_uop_iw_p1_poisoned : _GEN_7835 & _slots_0_io_uop_iw_p1_poisoned;
  assign io_iss_uops_1_iw_p2_poisoned = _GEN_149 ? _slots_23_io_uop_iw_p2_poisoned : _GEN_146 ? _slots_22_io_uop_iw_p2_poisoned : _GEN_150 ? _slots_21_io_uop_iw_p2_poisoned : _GEN_136 ? _slots_20_io_uop_iw_p2_poisoned : _GEN_131 ? _slots_19_io_uop_iw_p2_poisoned : _GEN_137 ? _slots_18_io_uop_iw_p2_poisoned : _GEN_121 ? _slots_17_io_uop_iw_p2_poisoned : _GEN_116 ? _slots_16_io_uop_iw_p2_poisoned : _GEN_122 ? _slots_15_io_uop_iw_p2_poisoned : _GEN_106 ? _slots_14_io_uop_iw_p2_poisoned : _GEN_101 ? _slots_13_io_uop_iw_p2_poisoned : _GEN_107 ? _slots_12_io_uop_iw_p2_poisoned : _GEN_91 ? _slots_11_io_uop_iw_p2_poisoned : _GEN_86 ? _slots_10_io_uop_iw_p2_poisoned : _GEN_92 ? _slots_9_io_uop_iw_p2_poisoned : _GEN_76 ? _slots_8_io_uop_iw_p2_poisoned : _GEN_71 ? _slots_7_io_uop_iw_p2_poisoned : _GEN_77 ? _slots_6_io_uop_iw_p2_poisoned : _GEN_56 ? _slots_5_io_uop_iw_p2_poisoned : _GEN_46 ? _slots_4_io_uop_iw_p2_poisoned : _GEN_58 ? _slots_3_io_uop_iw_p2_poisoned : _GEN_28 ? _slots_2_io_uop_iw_p2_poisoned : _GEN_21 ? _slots_1_io_uop_iw_p2_poisoned : _GEN_7835 & _slots_0_io_uop_iw_p2_poisoned;
  assign io_iss_uops_1_br_mask = _GEN_149 ? _slots_23_io_uop_br_mask : _GEN_146 ? _slots_22_io_uop_br_mask : _GEN_150 ? _slots_21_io_uop_br_mask : _GEN_136 ? _slots_20_io_uop_br_mask : _GEN_131 ? _slots_19_io_uop_br_mask : _GEN_137 ? _slots_18_io_uop_br_mask : _GEN_121 ? _slots_17_io_uop_br_mask : _GEN_116 ? _slots_16_io_uop_br_mask : _GEN_122 ? _slots_15_io_uop_br_mask : _GEN_106 ? _slots_14_io_uop_br_mask : _GEN_101 ? _slots_13_io_uop_br_mask : _GEN_107 ? _slots_12_io_uop_br_mask : _GEN_91 ? _slots_11_io_uop_br_mask : _GEN_86 ? _slots_10_io_uop_br_mask : _GEN_92 ? _slots_9_io_uop_br_mask : _GEN_76 ? _slots_8_io_uop_br_mask : _GEN_71 ? _slots_7_io_uop_br_mask : _GEN_77 ? _slots_6_io_uop_br_mask : _GEN_56 ? _slots_5_io_uop_br_mask : _GEN_46 ? _slots_4_io_uop_br_mask : _GEN_58 ? _slots_3_io_uop_br_mask : _GEN_28 ? _slots_2_io_uop_br_mask : _GEN_21 ? _slots_1_io_uop_br_mask : _GEN_7835 ? _slots_0_io_uop_br_mask : 20'h0;
  assign io_iss_uops_1_imm_packed = _GEN_149 ? _slots_23_io_uop_imm_packed : _GEN_146 ? _slots_22_io_uop_imm_packed : _GEN_150 ? _slots_21_io_uop_imm_packed : _GEN_136 ? _slots_20_io_uop_imm_packed : _GEN_131 ? _slots_19_io_uop_imm_packed : _GEN_137 ? _slots_18_io_uop_imm_packed : _GEN_121 ? _slots_17_io_uop_imm_packed : _GEN_116 ? _slots_16_io_uop_imm_packed : _GEN_122 ? _slots_15_io_uop_imm_packed : _GEN_106 ? _slots_14_io_uop_imm_packed : _GEN_101 ? _slots_13_io_uop_imm_packed : _GEN_107 ? _slots_12_io_uop_imm_packed : _GEN_91 ? _slots_11_io_uop_imm_packed : _GEN_86 ? _slots_10_io_uop_imm_packed : _GEN_92 ? _slots_9_io_uop_imm_packed : _GEN_76 ? _slots_8_io_uop_imm_packed : _GEN_71 ? _slots_7_io_uop_imm_packed : _GEN_77 ? _slots_6_io_uop_imm_packed : _GEN_56 ? _slots_5_io_uop_imm_packed : _GEN_46 ? _slots_4_io_uop_imm_packed : _GEN_58 ? _slots_3_io_uop_imm_packed : _GEN_28 ? _slots_2_io_uop_imm_packed : _GEN_21 ? _slots_1_io_uop_imm_packed : _GEN_7835 ? _slots_0_io_uop_imm_packed : 20'h0;
  assign io_iss_uops_1_rob_idx = _GEN_149 ? _slots_23_io_uop_rob_idx : _GEN_146 ? _slots_22_io_uop_rob_idx : _GEN_150 ? _slots_21_io_uop_rob_idx : _GEN_136 ? _slots_20_io_uop_rob_idx : _GEN_131 ? _slots_19_io_uop_rob_idx : _GEN_137 ? _slots_18_io_uop_rob_idx : _GEN_121 ? _slots_17_io_uop_rob_idx : _GEN_116 ? _slots_16_io_uop_rob_idx : _GEN_122 ? _slots_15_io_uop_rob_idx : _GEN_106 ? _slots_14_io_uop_rob_idx : _GEN_101 ? _slots_13_io_uop_rob_idx : _GEN_107 ? _slots_12_io_uop_rob_idx : _GEN_91 ? _slots_11_io_uop_rob_idx : _GEN_86 ? _slots_10_io_uop_rob_idx : _GEN_92 ? _slots_9_io_uop_rob_idx : _GEN_76 ? _slots_8_io_uop_rob_idx : _GEN_71 ? _slots_7_io_uop_rob_idx : _GEN_77 ? _slots_6_io_uop_rob_idx : _GEN_56 ? _slots_5_io_uop_rob_idx : _GEN_46 ? _slots_4_io_uop_rob_idx : _GEN_58 ? _slots_3_io_uop_rob_idx : _GEN_28 ? _slots_2_io_uop_rob_idx : _GEN_21 ? _slots_1_io_uop_rob_idx : _GEN_7835 ? _slots_0_io_uop_rob_idx : 7'h0;
  assign io_iss_uops_1_ldq_idx = _GEN_149 ? _slots_23_io_uop_ldq_idx : _GEN_146 ? _slots_22_io_uop_ldq_idx : _GEN_150 ? _slots_21_io_uop_ldq_idx : _GEN_136 ? _slots_20_io_uop_ldq_idx : _GEN_131 ? _slots_19_io_uop_ldq_idx : _GEN_137 ? _slots_18_io_uop_ldq_idx : _GEN_121 ? _slots_17_io_uop_ldq_idx : _GEN_116 ? _slots_16_io_uop_ldq_idx : _GEN_122 ? _slots_15_io_uop_ldq_idx : _GEN_106 ? _slots_14_io_uop_ldq_idx : _GEN_101 ? _slots_13_io_uop_ldq_idx : _GEN_107 ? _slots_12_io_uop_ldq_idx : _GEN_91 ? _slots_11_io_uop_ldq_idx : _GEN_86 ? _slots_10_io_uop_ldq_idx : _GEN_92 ? _slots_9_io_uop_ldq_idx : _GEN_76 ? _slots_8_io_uop_ldq_idx : _GEN_71 ? _slots_7_io_uop_ldq_idx : _GEN_77 ? _slots_6_io_uop_ldq_idx : _GEN_56 ? _slots_5_io_uop_ldq_idx : _GEN_46 ? _slots_4_io_uop_ldq_idx : _GEN_58 ? _slots_3_io_uop_ldq_idx : _GEN_28 ? _slots_2_io_uop_ldq_idx : _GEN_21 ? _slots_1_io_uop_ldq_idx : _GEN_7835 ? _slots_0_io_uop_ldq_idx : 5'h0;
  assign io_iss_uops_1_stq_idx = _GEN_149 ? _slots_23_io_uop_stq_idx : _GEN_146 ? _slots_22_io_uop_stq_idx : _GEN_150 ? _slots_21_io_uop_stq_idx : _GEN_136 ? _slots_20_io_uop_stq_idx : _GEN_131 ? _slots_19_io_uop_stq_idx : _GEN_137 ? _slots_18_io_uop_stq_idx : _GEN_121 ? _slots_17_io_uop_stq_idx : _GEN_116 ? _slots_16_io_uop_stq_idx : _GEN_122 ? _slots_15_io_uop_stq_idx : _GEN_106 ? _slots_14_io_uop_stq_idx : _GEN_101 ? _slots_13_io_uop_stq_idx : _GEN_107 ? _slots_12_io_uop_stq_idx : _GEN_91 ? _slots_11_io_uop_stq_idx : _GEN_86 ? _slots_10_io_uop_stq_idx : _GEN_92 ? _slots_9_io_uop_stq_idx : _GEN_76 ? _slots_8_io_uop_stq_idx : _GEN_71 ? _slots_7_io_uop_stq_idx : _GEN_77 ? _slots_6_io_uop_stq_idx : _GEN_56 ? _slots_5_io_uop_stq_idx : _GEN_46 ? _slots_4_io_uop_stq_idx : _GEN_58 ? _slots_3_io_uop_stq_idx : _GEN_28 ? _slots_2_io_uop_stq_idx : _GEN_21 ? _slots_1_io_uop_stq_idx : _GEN_7835 ? _slots_0_io_uop_stq_idx : 5'h0;
  assign io_iss_uops_1_pdst = _GEN_149 ? _slots_23_io_uop_pdst : _GEN_146 ? _slots_22_io_uop_pdst : _GEN_150 ? _slots_21_io_uop_pdst : _GEN_136 ? _slots_20_io_uop_pdst : _GEN_131 ? _slots_19_io_uop_pdst : _GEN_137 ? _slots_18_io_uop_pdst : _GEN_121 ? _slots_17_io_uop_pdst : _GEN_116 ? _slots_16_io_uop_pdst : _GEN_122 ? _slots_15_io_uop_pdst : _GEN_106 ? _slots_14_io_uop_pdst : _GEN_101 ? _slots_13_io_uop_pdst : _GEN_107 ? _slots_12_io_uop_pdst : _GEN_91 ? _slots_11_io_uop_pdst : _GEN_86 ? _slots_10_io_uop_pdst : _GEN_92 ? _slots_9_io_uop_pdst : _GEN_76 ? _slots_8_io_uop_pdst : _GEN_71 ? _slots_7_io_uop_pdst : _GEN_77 ? _slots_6_io_uop_pdst : _GEN_56 ? _slots_5_io_uop_pdst : _GEN_46 ? _slots_4_io_uop_pdst : _GEN_58 ? _slots_3_io_uop_pdst : _GEN_28 ? _slots_2_io_uop_pdst : _GEN_21 ? _slots_1_io_uop_pdst : _GEN_7835 ? _slots_0_io_uop_pdst : 7'h0;
  assign io_iss_uops_1_prs1 = _GEN_149 ? _slots_23_io_uop_prs1 : _GEN_146 ? _slots_22_io_uop_prs1 : _GEN_150 ? _slots_21_io_uop_prs1 : _GEN_136 ? _slots_20_io_uop_prs1 : _GEN_131 ? _slots_19_io_uop_prs1 : _GEN_137 ? _slots_18_io_uop_prs1 : _GEN_121 ? _slots_17_io_uop_prs1 : _GEN_116 ? _slots_16_io_uop_prs1 : _GEN_122 ? _slots_15_io_uop_prs1 : _GEN_106 ? _slots_14_io_uop_prs1 : _GEN_101 ? _slots_13_io_uop_prs1 : _GEN_107 ? _slots_12_io_uop_prs1 : _GEN_91 ? _slots_11_io_uop_prs1 : _GEN_86 ? _slots_10_io_uop_prs1 : _GEN_92 ? _slots_9_io_uop_prs1 : _GEN_76 ? _slots_8_io_uop_prs1 : _GEN_71 ? _slots_7_io_uop_prs1 : _GEN_77 ? _slots_6_io_uop_prs1 : _GEN_56 ? _slots_5_io_uop_prs1 : _GEN_46 ? _slots_4_io_uop_prs1 : _GEN_58 ? _slots_3_io_uop_prs1 : _GEN_28 ? _slots_2_io_uop_prs1 : _GEN_21 ? _slots_1_io_uop_prs1 : _GEN_7835 ? _slots_0_io_uop_prs1 : 7'h0;
  assign io_iss_uops_1_prs2 = _GEN_149 ? _slots_23_io_uop_prs2 : _GEN_146 ? _slots_22_io_uop_prs2 : _GEN_150 ? _slots_21_io_uop_prs2 : _GEN_136 ? _slots_20_io_uop_prs2 : _GEN_131 ? _slots_19_io_uop_prs2 : _GEN_137 ? _slots_18_io_uop_prs2 : _GEN_121 ? _slots_17_io_uop_prs2 : _GEN_116 ? _slots_16_io_uop_prs2 : _GEN_122 ? _slots_15_io_uop_prs2 : _GEN_106 ? _slots_14_io_uop_prs2 : _GEN_101 ? _slots_13_io_uop_prs2 : _GEN_107 ? _slots_12_io_uop_prs2 : _GEN_91 ? _slots_11_io_uop_prs2 : _GEN_86 ? _slots_10_io_uop_prs2 : _GEN_92 ? _slots_9_io_uop_prs2 : _GEN_76 ? _slots_8_io_uop_prs2 : _GEN_71 ? _slots_7_io_uop_prs2 : _GEN_77 ? _slots_6_io_uop_prs2 : _GEN_56 ? _slots_5_io_uop_prs2 : _GEN_46 ? _slots_4_io_uop_prs2 : _GEN_58 ? _slots_3_io_uop_prs2 : _GEN_28 ? _slots_2_io_uop_prs2 : _GEN_21 ? _slots_1_io_uop_prs2 : _GEN_7835 ? _slots_0_io_uop_prs2 : 7'h0;
  assign io_iss_uops_1_mem_cmd = _GEN_149 ? _slots_23_io_uop_mem_cmd : _GEN_146 ? _slots_22_io_uop_mem_cmd : _GEN_150 ? _slots_21_io_uop_mem_cmd : _GEN_136 ? _slots_20_io_uop_mem_cmd : _GEN_131 ? _slots_19_io_uop_mem_cmd : _GEN_137 ? _slots_18_io_uop_mem_cmd : _GEN_121 ? _slots_17_io_uop_mem_cmd : _GEN_116 ? _slots_16_io_uop_mem_cmd : _GEN_122 ? _slots_15_io_uop_mem_cmd : _GEN_106 ? _slots_14_io_uop_mem_cmd : _GEN_101 ? _slots_13_io_uop_mem_cmd : _GEN_107 ? _slots_12_io_uop_mem_cmd : _GEN_91 ? _slots_11_io_uop_mem_cmd : _GEN_86 ? _slots_10_io_uop_mem_cmd : _GEN_92 ? _slots_9_io_uop_mem_cmd : _GEN_76 ? _slots_8_io_uop_mem_cmd : _GEN_71 ? _slots_7_io_uop_mem_cmd : _GEN_77 ? _slots_6_io_uop_mem_cmd : _GEN_56 ? _slots_5_io_uop_mem_cmd : _GEN_46 ? _slots_4_io_uop_mem_cmd : _GEN_58 ? _slots_3_io_uop_mem_cmd : _GEN_28 ? _slots_2_io_uop_mem_cmd : _GEN_21 ? _slots_1_io_uop_mem_cmd : _GEN_7835 ? _slots_0_io_uop_mem_cmd : 5'h0;
  assign io_iss_uops_1_mem_size = _GEN_149 ? _slots_23_io_uop_mem_size : _GEN_146 ? _slots_22_io_uop_mem_size : _GEN_150 ? _slots_21_io_uop_mem_size : _GEN_136 ? _slots_20_io_uop_mem_size : _GEN_131 ? _slots_19_io_uop_mem_size : _GEN_137 ? _slots_18_io_uop_mem_size : _GEN_121 ? _slots_17_io_uop_mem_size : _GEN_116 ? _slots_16_io_uop_mem_size : _GEN_122 ? _slots_15_io_uop_mem_size : _GEN_106 ? _slots_14_io_uop_mem_size : _GEN_101 ? _slots_13_io_uop_mem_size : _GEN_107 ? _slots_12_io_uop_mem_size : _GEN_91 ? _slots_11_io_uop_mem_size : _GEN_86 ? _slots_10_io_uop_mem_size : _GEN_92 ? _slots_9_io_uop_mem_size : _GEN_76 ? _slots_8_io_uop_mem_size : _GEN_71 ? _slots_7_io_uop_mem_size : _GEN_77 ? _slots_6_io_uop_mem_size : _GEN_56 ? _slots_5_io_uop_mem_size : _GEN_46 ? _slots_4_io_uop_mem_size : _GEN_58 ? _slots_3_io_uop_mem_size : _GEN_28 ? _slots_2_io_uop_mem_size : _GEN_21 ? _slots_1_io_uop_mem_size : _GEN_7835 ? _slots_0_io_uop_mem_size : 2'h0;
  assign io_iss_uops_1_mem_signed = _GEN_149 ? _slots_23_io_uop_mem_signed : _GEN_146 ? _slots_22_io_uop_mem_signed : _GEN_150 ? _slots_21_io_uop_mem_signed : _GEN_136 ? _slots_20_io_uop_mem_signed : _GEN_131 ? _slots_19_io_uop_mem_signed : _GEN_137 ? _slots_18_io_uop_mem_signed : _GEN_121 ? _slots_17_io_uop_mem_signed : _GEN_116 ? _slots_16_io_uop_mem_signed : _GEN_122 ? _slots_15_io_uop_mem_signed : _GEN_106 ? _slots_14_io_uop_mem_signed : _GEN_101 ? _slots_13_io_uop_mem_signed : _GEN_107 ? _slots_12_io_uop_mem_signed : _GEN_91 ? _slots_11_io_uop_mem_signed : _GEN_86 ? _slots_10_io_uop_mem_signed : _GEN_92 ? _slots_9_io_uop_mem_signed : _GEN_76 ? _slots_8_io_uop_mem_signed : _GEN_71 ? _slots_7_io_uop_mem_signed : _GEN_77 ? _slots_6_io_uop_mem_signed : _GEN_56 ? _slots_5_io_uop_mem_signed : _GEN_46 ? _slots_4_io_uop_mem_signed : _GEN_58 ? _slots_3_io_uop_mem_signed : _GEN_28 ? _slots_2_io_uop_mem_signed : _GEN_21 ? _slots_1_io_uop_mem_signed : _GEN_7835 & _slots_0_io_uop_mem_signed;
  assign io_iss_uops_1_is_fence = _GEN_149 ? _slots_23_io_uop_is_fence : _GEN_146 ? _slots_22_io_uop_is_fence : _GEN_150 ? _slots_21_io_uop_is_fence : _GEN_136 ? _slots_20_io_uop_is_fence : _GEN_131 ? _slots_19_io_uop_is_fence : _GEN_137 ? _slots_18_io_uop_is_fence : _GEN_121 ? _slots_17_io_uop_is_fence : _GEN_116 ? _slots_16_io_uop_is_fence : _GEN_122 ? _slots_15_io_uop_is_fence : _GEN_106 ? _slots_14_io_uop_is_fence : _GEN_101 ? _slots_13_io_uop_is_fence : _GEN_107 ? _slots_12_io_uop_is_fence : _GEN_91 ? _slots_11_io_uop_is_fence : _GEN_86 ? _slots_10_io_uop_is_fence : _GEN_92 ? _slots_9_io_uop_is_fence : _GEN_76 ? _slots_8_io_uop_is_fence : _GEN_71 ? _slots_7_io_uop_is_fence : _GEN_77 ? _slots_6_io_uop_is_fence : _GEN_56 ? _slots_5_io_uop_is_fence : _GEN_46 ? _slots_4_io_uop_is_fence : _GEN_58 ? _slots_3_io_uop_is_fence : _GEN_28 ? _slots_2_io_uop_is_fence : _GEN_21 ? _slots_1_io_uop_is_fence : _GEN_7835 & _slots_0_io_uop_is_fence;
  assign io_iss_uops_1_is_amo = _GEN_149 ? _slots_23_io_uop_is_amo : _GEN_146 ? _slots_22_io_uop_is_amo : _GEN_150 ? _slots_21_io_uop_is_amo : _GEN_136 ? _slots_20_io_uop_is_amo : _GEN_131 ? _slots_19_io_uop_is_amo : _GEN_137 ? _slots_18_io_uop_is_amo : _GEN_121 ? _slots_17_io_uop_is_amo : _GEN_116 ? _slots_16_io_uop_is_amo : _GEN_122 ? _slots_15_io_uop_is_amo : _GEN_106 ? _slots_14_io_uop_is_amo : _GEN_101 ? _slots_13_io_uop_is_amo : _GEN_107 ? _slots_12_io_uop_is_amo : _GEN_91 ? _slots_11_io_uop_is_amo : _GEN_86 ? _slots_10_io_uop_is_amo : _GEN_92 ? _slots_9_io_uop_is_amo : _GEN_76 ? _slots_8_io_uop_is_amo : _GEN_71 ? _slots_7_io_uop_is_amo : _GEN_77 ? _slots_6_io_uop_is_amo : _GEN_56 ? _slots_5_io_uop_is_amo : _GEN_46 ? _slots_4_io_uop_is_amo : _GEN_58 ? _slots_3_io_uop_is_amo : _GEN_28 ? _slots_2_io_uop_is_amo : _GEN_21 ? _slots_1_io_uop_is_amo : _GEN_7835 & _slots_0_io_uop_is_amo;
  assign io_iss_uops_1_uses_ldq = _GEN_149 ? _slots_23_io_uop_uses_ldq : _GEN_146 ? _slots_22_io_uop_uses_ldq : _GEN_150 ? _slots_21_io_uop_uses_ldq : _GEN_136 ? _slots_20_io_uop_uses_ldq : _GEN_131 ? _slots_19_io_uop_uses_ldq : _GEN_137 ? _slots_18_io_uop_uses_ldq : _GEN_121 ? _slots_17_io_uop_uses_ldq : _GEN_116 ? _slots_16_io_uop_uses_ldq : _GEN_122 ? _slots_15_io_uop_uses_ldq : _GEN_106 ? _slots_14_io_uop_uses_ldq : _GEN_101 ? _slots_13_io_uop_uses_ldq : _GEN_107 ? _slots_12_io_uop_uses_ldq : _GEN_91 ? _slots_11_io_uop_uses_ldq : _GEN_86 ? _slots_10_io_uop_uses_ldq : _GEN_92 ? _slots_9_io_uop_uses_ldq : _GEN_76 ? _slots_8_io_uop_uses_ldq : _GEN_71 ? _slots_7_io_uop_uses_ldq : _GEN_77 ? _slots_6_io_uop_uses_ldq : _GEN_56 ? _slots_5_io_uop_uses_ldq : _GEN_46 ? _slots_4_io_uop_uses_ldq : _GEN_58 ? _slots_3_io_uop_uses_ldq : _GEN_28 ? _slots_2_io_uop_uses_ldq : _GEN_21 ? _slots_1_io_uop_uses_ldq : _GEN_7835 & _slots_0_io_uop_uses_ldq;
  assign io_iss_uops_1_uses_stq = _GEN_149 ? _slots_23_io_uop_uses_stq : _GEN_146 ? _slots_22_io_uop_uses_stq : _GEN_150 ? _slots_21_io_uop_uses_stq : _GEN_136 ? _slots_20_io_uop_uses_stq : _GEN_131 ? _slots_19_io_uop_uses_stq : _GEN_137 ? _slots_18_io_uop_uses_stq : _GEN_121 ? _slots_17_io_uop_uses_stq : _GEN_116 ? _slots_16_io_uop_uses_stq : _GEN_122 ? _slots_15_io_uop_uses_stq : _GEN_106 ? _slots_14_io_uop_uses_stq : _GEN_101 ? _slots_13_io_uop_uses_stq : _GEN_107 ? _slots_12_io_uop_uses_stq : _GEN_91 ? _slots_11_io_uop_uses_stq : _GEN_86 ? _slots_10_io_uop_uses_stq : _GEN_92 ? _slots_9_io_uop_uses_stq : _GEN_76 ? _slots_8_io_uop_uses_stq : _GEN_71 ? _slots_7_io_uop_uses_stq : _GEN_77 ? _slots_6_io_uop_uses_stq : _GEN_56 ? _slots_5_io_uop_uses_stq : _GEN_46 ? _slots_4_io_uop_uses_stq : _GEN_58 ? _slots_3_io_uop_uses_stq : _GEN_28 ? _slots_2_io_uop_uses_stq : _GEN_21 ? _slots_1_io_uop_uses_stq : _GEN_7835 & _slots_0_io_uop_uses_stq;
  assign io_iss_uops_1_lrs1_rtype = _GEN_149 ? _slots_23_io_uop_lrs1_rtype : _GEN_146 ? _slots_22_io_uop_lrs1_rtype : _GEN_150 ? _slots_21_io_uop_lrs1_rtype : _GEN_136 ? _slots_20_io_uop_lrs1_rtype : _GEN_131 ? _slots_19_io_uop_lrs1_rtype : _GEN_137 ? _slots_18_io_uop_lrs1_rtype : _GEN_121 ? _slots_17_io_uop_lrs1_rtype : _GEN_116 ? _slots_16_io_uop_lrs1_rtype : _GEN_122 ? _slots_15_io_uop_lrs1_rtype : _GEN_106 ? _slots_14_io_uop_lrs1_rtype : _GEN_101 ? _slots_13_io_uop_lrs1_rtype : _GEN_107 ? _slots_12_io_uop_lrs1_rtype : _GEN_91 ? _slots_11_io_uop_lrs1_rtype : _GEN_86 ? _slots_10_io_uop_lrs1_rtype : _GEN_92 ? _slots_9_io_uop_lrs1_rtype : _GEN_76 ? _slots_8_io_uop_lrs1_rtype : _GEN_71 ? _slots_7_io_uop_lrs1_rtype : _GEN_77 ? _slots_6_io_uop_lrs1_rtype : _GEN_56 ? _slots_5_io_uop_lrs1_rtype : _GEN_46 ? _slots_4_io_uop_lrs1_rtype : _GEN_58 ? _slots_3_io_uop_lrs1_rtype : _GEN_28 ? _slots_2_io_uop_lrs1_rtype : _GEN_21 ? _slots_1_io_uop_lrs1_rtype : _GEN_7835 ? _slots_0_io_uop_lrs1_rtype : 2'h2;
  assign io_iss_uops_1_lrs2_rtype = _GEN_149 ? _slots_23_io_uop_lrs2_rtype : _GEN_146 ? _slots_22_io_uop_lrs2_rtype : _GEN_150 ? _slots_21_io_uop_lrs2_rtype : _GEN_136 ? _slots_20_io_uop_lrs2_rtype : _GEN_131 ? _slots_19_io_uop_lrs2_rtype : _GEN_137 ? _slots_18_io_uop_lrs2_rtype : _GEN_121 ? _slots_17_io_uop_lrs2_rtype : _GEN_116 ? _slots_16_io_uop_lrs2_rtype : _GEN_122 ? _slots_15_io_uop_lrs2_rtype : _GEN_106 ? _slots_14_io_uop_lrs2_rtype : _GEN_101 ? _slots_13_io_uop_lrs2_rtype : _GEN_107 ? _slots_12_io_uop_lrs2_rtype : _GEN_91 ? _slots_11_io_uop_lrs2_rtype : _GEN_86 ? _slots_10_io_uop_lrs2_rtype : _GEN_92 ? _slots_9_io_uop_lrs2_rtype : _GEN_76 ? _slots_8_io_uop_lrs2_rtype : _GEN_71 ? _slots_7_io_uop_lrs2_rtype : _GEN_77 ? _slots_6_io_uop_lrs2_rtype : _GEN_56 ? _slots_5_io_uop_lrs2_rtype : _GEN_46 ? _slots_4_io_uop_lrs2_rtype : _GEN_58 ? _slots_3_io_uop_lrs2_rtype : _GEN_28 ? _slots_2_io_uop_lrs2_rtype : _GEN_21 ? _slots_1_io_uop_lrs2_rtype : _GEN_7835 ? _slots_0_io_uop_lrs2_rtype : 2'h2;
  assign io_iss_uops_1_fp_val = _GEN_149 ? _slots_23_io_uop_fp_val : _GEN_146 ? _slots_22_io_uop_fp_val : _GEN_150 ? _slots_21_io_uop_fp_val : _GEN_136 ? _slots_20_io_uop_fp_val : _GEN_131 ? _slots_19_io_uop_fp_val : _GEN_137 ? _slots_18_io_uop_fp_val : _GEN_121 ? _slots_17_io_uop_fp_val : _GEN_116 ? _slots_16_io_uop_fp_val : _GEN_122 ? _slots_15_io_uop_fp_val : _GEN_106 ? _slots_14_io_uop_fp_val : _GEN_101 ? _slots_13_io_uop_fp_val : _GEN_107 ? _slots_12_io_uop_fp_val : _GEN_91 ? _slots_11_io_uop_fp_val : _GEN_86 ? _slots_10_io_uop_fp_val : _GEN_92 ? _slots_9_io_uop_fp_val : _GEN_76 ? _slots_8_io_uop_fp_val : _GEN_71 ? _slots_7_io_uop_fp_val : _GEN_77 ? _slots_6_io_uop_fp_val : _GEN_56 ? _slots_5_io_uop_fp_val : _GEN_46 ? _slots_4_io_uop_fp_val : _GEN_58 ? _slots_3_io_uop_fp_val : _GEN_28 ? _slots_2_io_uop_fp_val : _GEN_21 ? _slots_1_io_uop_fp_val : _GEN_7835 & _slots_0_io_uop_fp_val;
endmodule

