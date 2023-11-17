// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BasicDispatcher(
  input         io_ren_uops_0_valid,
  input  [6:0]  io_ren_uops_0_bits_uopc,
  input         io_ren_uops_0_bits_is_rvc,
  input  [2:0]  io_ren_uops_0_bits_iq_type,
  input  [9:0]  io_ren_uops_0_bits_fu_code,
  input         io_ren_uops_0_bits_is_br,
                io_ren_uops_0_bits_is_jalr,
                io_ren_uops_0_bits_is_jal,
                io_ren_uops_0_bits_is_sfb,
  input  [19:0] io_ren_uops_0_bits_br_mask,
  input  [4:0]  io_ren_uops_0_bits_br_tag,
  input  [5:0]  io_ren_uops_0_bits_ftq_idx,
  input         io_ren_uops_0_bits_edge_inst,
  input  [5:0]  io_ren_uops_0_bits_pc_lob,
  input         io_ren_uops_0_bits_taken,
  input  [19:0] io_ren_uops_0_bits_imm_packed,
  input  [6:0]  io_ren_uops_0_bits_rob_idx,
  input  [4:0]  io_ren_uops_0_bits_ldq_idx,
                io_ren_uops_0_bits_stq_idx,
  input  [6:0]  io_ren_uops_0_bits_pdst,
                io_ren_uops_0_bits_prs1,
                io_ren_uops_0_bits_prs2,
                io_ren_uops_0_bits_prs3,
  input         io_ren_uops_0_bits_prs1_busy,
                io_ren_uops_0_bits_prs2_busy,
                io_ren_uops_0_bits_prs3_busy,
                io_ren_uops_0_bits_exception,
                io_ren_uops_0_bits_bypassable,
  input  [4:0]  io_ren_uops_0_bits_mem_cmd,
  input  [1:0]  io_ren_uops_0_bits_mem_size,
  input         io_ren_uops_0_bits_mem_signed,
                io_ren_uops_0_bits_is_fence,
                io_ren_uops_0_bits_is_fencei,
                io_ren_uops_0_bits_is_amo,
                io_ren_uops_0_bits_uses_ldq,
                io_ren_uops_0_bits_uses_stq,
                io_ren_uops_0_bits_ldst_val,
  input  [1:0]  io_ren_uops_0_bits_dst_rtype,
                io_ren_uops_0_bits_lrs1_rtype,
                io_ren_uops_0_bits_lrs2_rtype,
  input         io_ren_uops_0_bits_fp_val,
                io_ren_uops_1_valid,
  input  [6:0]  io_ren_uops_1_bits_uopc,
  input         io_ren_uops_1_bits_is_rvc,
  input  [2:0]  io_ren_uops_1_bits_iq_type,
  input  [9:0]  io_ren_uops_1_bits_fu_code,
  input         io_ren_uops_1_bits_is_br,
                io_ren_uops_1_bits_is_jalr,
                io_ren_uops_1_bits_is_jal,
                io_ren_uops_1_bits_is_sfb,
  input  [19:0] io_ren_uops_1_bits_br_mask,
  input  [4:0]  io_ren_uops_1_bits_br_tag,
  input  [5:0]  io_ren_uops_1_bits_ftq_idx,
  input         io_ren_uops_1_bits_edge_inst,
  input  [5:0]  io_ren_uops_1_bits_pc_lob,
  input         io_ren_uops_1_bits_taken,
  input  [19:0] io_ren_uops_1_bits_imm_packed,
  input  [6:0]  io_ren_uops_1_bits_rob_idx,
  input  [4:0]  io_ren_uops_1_bits_ldq_idx,
                io_ren_uops_1_bits_stq_idx,
  input  [6:0]  io_ren_uops_1_bits_pdst,
                io_ren_uops_1_bits_prs1,
                io_ren_uops_1_bits_prs2,
                io_ren_uops_1_bits_prs3,
  input         io_ren_uops_1_bits_prs1_busy,
                io_ren_uops_1_bits_prs2_busy,
                io_ren_uops_1_bits_prs3_busy,
                io_ren_uops_1_bits_exception,
                io_ren_uops_1_bits_bypassable,
  input  [4:0]  io_ren_uops_1_bits_mem_cmd,
  input  [1:0]  io_ren_uops_1_bits_mem_size,
  input         io_ren_uops_1_bits_mem_signed,
                io_ren_uops_1_bits_is_fence,
                io_ren_uops_1_bits_is_fencei,
                io_ren_uops_1_bits_is_amo,
                io_ren_uops_1_bits_uses_ldq,
                io_ren_uops_1_bits_uses_stq,
                io_ren_uops_1_bits_ldst_val,
  input  [1:0]  io_ren_uops_1_bits_dst_rtype,
                io_ren_uops_1_bits_lrs1_rtype,
                io_ren_uops_1_bits_lrs2_rtype,
  input         io_ren_uops_1_bits_fp_val,
                io_ren_uops_2_valid,
  input  [6:0]  io_ren_uops_2_bits_uopc,
  input         io_ren_uops_2_bits_is_rvc,
  input  [2:0]  io_ren_uops_2_bits_iq_type,
  input  [9:0]  io_ren_uops_2_bits_fu_code,
  input         io_ren_uops_2_bits_is_br,
                io_ren_uops_2_bits_is_jalr,
                io_ren_uops_2_bits_is_jal,
                io_ren_uops_2_bits_is_sfb,
  input  [19:0] io_ren_uops_2_bits_br_mask,
  input  [4:0]  io_ren_uops_2_bits_br_tag,
  input  [5:0]  io_ren_uops_2_bits_ftq_idx,
  input         io_ren_uops_2_bits_edge_inst,
  input  [5:0]  io_ren_uops_2_bits_pc_lob,
  input         io_ren_uops_2_bits_taken,
  input  [19:0] io_ren_uops_2_bits_imm_packed,
  input  [6:0]  io_ren_uops_2_bits_rob_idx,
  input  [4:0]  io_ren_uops_2_bits_ldq_idx,
                io_ren_uops_2_bits_stq_idx,
  input  [6:0]  io_ren_uops_2_bits_pdst,
                io_ren_uops_2_bits_prs1,
                io_ren_uops_2_bits_prs2,
                io_ren_uops_2_bits_prs3,
  input         io_ren_uops_2_bits_prs1_busy,
                io_ren_uops_2_bits_prs2_busy,
                io_ren_uops_2_bits_prs3_busy,
                io_ren_uops_2_bits_exception,
                io_ren_uops_2_bits_bypassable,
  input  [4:0]  io_ren_uops_2_bits_mem_cmd,
  input  [1:0]  io_ren_uops_2_bits_mem_size,
  input         io_ren_uops_2_bits_mem_signed,
                io_ren_uops_2_bits_is_fence,
                io_ren_uops_2_bits_is_fencei,
                io_ren_uops_2_bits_is_amo,
                io_ren_uops_2_bits_uses_ldq,
                io_ren_uops_2_bits_uses_stq,
                io_ren_uops_2_bits_ldst_val,
  input  [1:0]  io_ren_uops_2_bits_dst_rtype,
                io_ren_uops_2_bits_lrs1_rtype,
                io_ren_uops_2_bits_lrs2_rtype,
  input         io_ren_uops_2_bits_fp_val,
                io_ren_uops_3_valid,
  input  [6:0]  io_ren_uops_3_bits_uopc,
  input         io_ren_uops_3_bits_is_rvc,
  input  [2:0]  io_ren_uops_3_bits_iq_type,
  input  [9:0]  io_ren_uops_3_bits_fu_code,
  input         io_ren_uops_3_bits_is_br,
                io_ren_uops_3_bits_is_jalr,
                io_ren_uops_3_bits_is_jal,
                io_ren_uops_3_bits_is_sfb,
  input  [19:0] io_ren_uops_3_bits_br_mask,
  input  [4:0]  io_ren_uops_3_bits_br_tag,
  input  [5:0]  io_ren_uops_3_bits_ftq_idx,
  input         io_ren_uops_3_bits_edge_inst,
  input  [5:0]  io_ren_uops_3_bits_pc_lob,
  input         io_ren_uops_3_bits_taken,
  input  [19:0] io_ren_uops_3_bits_imm_packed,
  input  [6:0]  io_ren_uops_3_bits_rob_idx,
  input  [4:0]  io_ren_uops_3_bits_ldq_idx,
                io_ren_uops_3_bits_stq_idx,
  input  [6:0]  io_ren_uops_3_bits_pdst,
                io_ren_uops_3_bits_prs1,
                io_ren_uops_3_bits_prs2,
                io_ren_uops_3_bits_prs3,
  input         io_ren_uops_3_bits_prs1_busy,
                io_ren_uops_3_bits_prs2_busy,
                io_ren_uops_3_bits_prs3_busy,
                io_ren_uops_3_bits_exception,
                io_ren_uops_3_bits_bypassable,
  input  [4:0]  io_ren_uops_3_bits_mem_cmd,
  input  [1:0]  io_ren_uops_3_bits_mem_size,
  input         io_ren_uops_3_bits_mem_signed,
                io_ren_uops_3_bits_is_fence,
                io_ren_uops_3_bits_is_fencei,
                io_ren_uops_3_bits_is_amo,
                io_ren_uops_3_bits_uses_ldq,
                io_ren_uops_3_bits_uses_stq,
                io_ren_uops_3_bits_ldst_val,
  input  [1:0]  io_ren_uops_3_bits_dst_rtype,
                io_ren_uops_3_bits_lrs1_rtype,
                io_ren_uops_3_bits_lrs2_rtype,
  input         io_ren_uops_3_bits_fp_val,
                io_dis_uops_2_0_ready,
                io_dis_uops_2_1_ready,
                io_dis_uops_2_2_ready,
                io_dis_uops_2_3_ready,
                io_dis_uops_1_0_ready,
                io_dis_uops_1_1_ready,
                io_dis_uops_1_2_ready,
                io_dis_uops_1_3_ready,
                io_dis_uops_0_0_ready,
                io_dis_uops_0_1_ready,
                io_dis_uops_0_2_ready,
                io_dis_uops_0_3_ready,
  output        io_ren_uops_0_ready,
                io_ren_uops_1_ready,
                io_ren_uops_2_ready,
                io_ren_uops_3_ready,
                io_dis_uops_2_0_valid,
  output [6:0]  io_dis_uops_2_0_bits_uopc,
  output [9:0]  io_dis_uops_2_0_bits_fu_code,
  output [19:0] io_dis_uops_2_0_bits_br_mask,
                io_dis_uops_2_0_bits_imm_packed,
  output [6:0]  io_dis_uops_2_0_bits_rob_idx,
  output [4:0]  io_dis_uops_2_0_bits_stq_idx,
  output [6:0]  io_dis_uops_2_0_bits_pdst,
                io_dis_uops_2_0_bits_prs1,
                io_dis_uops_2_0_bits_prs2,
                io_dis_uops_2_0_bits_prs3,
  output        io_dis_uops_2_0_bits_prs1_busy,
                io_dis_uops_2_0_bits_prs2_busy,
                io_dis_uops_2_0_bits_prs3_busy,
                io_dis_uops_2_0_bits_exception,
  output [4:0]  io_dis_uops_2_0_bits_mem_cmd,
  output        io_dis_uops_2_0_bits_is_fence,
                io_dis_uops_2_0_bits_is_fencei,
                io_dis_uops_2_0_bits_is_amo,
                io_dis_uops_2_0_bits_uses_ldq,
                io_dis_uops_2_0_bits_uses_stq,
  output [1:0]  io_dis_uops_2_0_bits_dst_rtype,
  output        io_dis_uops_2_0_bits_fp_val,
                io_dis_uops_2_1_valid,
  output [6:0]  io_dis_uops_2_1_bits_uopc,
  output [9:0]  io_dis_uops_2_1_bits_fu_code,
  output [19:0] io_dis_uops_2_1_bits_br_mask,
                io_dis_uops_2_1_bits_imm_packed,
  output [6:0]  io_dis_uops_2_1_bits_rob_idx,
  output [4:0]  io_dis_uops_2_1_bits_stq_idx,
  output [6:0]  io_dis_uops_2_1_bits_pdst,
                io_dis_uops_2_1_bits_prs1,
                io_dis_uops_2_1_bits_prs2,
                io_dis_uops_2_1_bits_prs3,
  output        io_dis_uops_2_1_bits_prs1_busy,
                io_dis_uops_2_1_bits_prs2_busy,
                io_dis_uops_2_1_bits_prs3_busy,
                io_dis_uops_2_1_bits_exception,
  output [4:0]  io_dis_uops_2_1_bits_mem_cmd,
  output        io_dis_uops_2_1_bits_is_fence,
                io_dis_uops_2_1_bits_is_fencei,
                io_dis_uops_2_1_bits_is_amo,
                io_dis_uops_2_1_bits_uses_ldq,
                io_dis_uops_2_1_bits_uses_stq,
  output [1:0]  io_dis_uops_2_1_bits_dst_rtype,
  output        io_dis_uops_2_1_bits_fp_val,
                io_dis_uops_2_2_valid,
  output [6:0]  io_dis_uops_2_2_bits_uopc,
  output [9:0]  io_dis_uops_2_2_bits_fu_code,
  output [19:0] io_dis_uops_2_2_bits_br_mask,
                io_dis_uops_2_2_bits_imm_packed,
  output [6:0]  io_dis_uops_2_2_bits_rob_idx,
  output [4:0]  io_dis_uops_2_2_bits_stq_idx,
  output [6:0]  io_dis_uops_2_2_bits_pdst,
                io_dis_uops_2_2_bits_prs1,
                io_dis_uops_2_2_bits_prs2,
                io_dis_uops_2_2_bits_prs3,
  output        io_dis_uops_2_2_bits_prs1_busy,
                io_dis_uops_2_2_bits_prs2_busy,
                io_dis_uops_2_2_bits_prs3_busy,
                io_dis_uops_2_2_bits_exception,
  output [4:0]  io_dis_uops_2_2_bits_mem_cmd,
  output        io_dis_uops_2_2_bits_is_fence,
                io_dis_uops_2_2_bits_is_fencei,
                io_dis_uops_2_2_bits_is_amo,
                io_dis_uops_2_2_bits_uses_ldq,
                io_dis_uops_2_2_bits_uses_stq,
  output [1:0]  io_dis_uops_2_2_bits_dst_rtype,
  output        io_dis_uops_2_2_bits_fp_val,
                io_dis_uops_2_3_valid,
  output [6:0]  io_dis_uops_2_3_bits_uopc,
  output [9:0]  io_dis_uops_2_3_bits_fu_code,
  output [19:0] io_dis_uops_2_3_bits_br_mask,
                io_dis_uops_2_3_bits_imm_packed,
  output [6:0]  io_dis_uops_2_3_bits_rob_idx,
  output [4:0]  io_dis_uops_2_3_bits_stq_idx,
  output [6:0]  io_dis_uops_2_3_bits_pdst,
                io_dis_uops_2_3_bits_prs1,
                io_dis_uops_2_3_bits_prs2,
                io_dis_uops_2_3_bits_prs3,
  output        io_dis_uops_2_3_bits_prs1_busy,
                io_dis_uops_2_3_bits_prs2_busy,
                io_dis_uops_2_3_bits_prs3_busy,
                io_dis_uops_2_3_bits_exception,
  output [4:0]  io_dis_uops_2_3_bits_mem_cmd,
  output        io_dis_uops_2_3_bits_is_fence,
                io_dis_uops_2_3_bits_is_fencei,
                io_dis_uops_2_3_bits_is_amo,
                io_dis_uops_2_3_bits_uses_ldq,
                io_dis_uops_2_3_bits_uses_stq,
  output [1:0]  io_dis_uops_2_3_bits_dst_rtype,
  output        io_dis_uops_2_3_bits_fp_val,
                io_dis_uops_1_0_valid,
  output [6:0]  io_dis_uops_1_0_bits_uopc,
  output        io_dis_uops_1_0_bits_is_rvc,
  output [9:0]  io_dis_uops_1_0_bits_fu_code,
  output        io_dis_uops_1_0_bits_is_br,
                io_dis_uops_1_0_bits_is_jalr,
                io_dis_uops_1_0_bits_is_jal,
                io_dis_uops_1_0_bits_is_sfb,
  output [19:0] io_dis_uops_1_0_bits_br_mask,
  output [4:0]  io_dis_uops_1_0_bits_br_tag,
  output [5:0]  io_dis_uops_1_0_bits_ftq_idx,
  output        io_dis_uops_1_0_bits_edge_inst,
  output [5:0]  io_dis_uops_1_0_bits_pc_lob,
  output        io_dis_uops_1_0_bits_taken,
  output [19:0] io_dis_uops_1_0_bits_imm_packed,
  output [6:0]  io_dis_uops_1_0_bits_rob_idx,
  output [4:0]  io_dis_uops_1_0_bits_ldq_idx,
                io_dis_uops_1_0_bits_stq_idx,
  output [6:0]  io_dis_uops_1_0_bits_pdst,
                io_dis_uops_1_0_bits_prs1,
                io_dis_uops_1_0_bits_prs2,
                io_dis_uops_1_0_bits_prs3,
  output        io_dis_uops_1_0_bits_prs1_busy,
                io_dis_uops_1_0_bits_prs2_busy,
                io_dis_uops_1_0_bits_exception,
                io_dis_uops_1_0_bits_bypassable,
  output [4:0]  io_dis_uops_1_0_bits_mem_cmd,
  output [1:0]  io_dis_uops_1_0_bits_mem_size,
  output        io_dis_uops_1_0_bits_mem_signed,
                io_dis_uops_1_0_bits_is_fence,
                io_dis_uops_1_0_bits_is_fencei,
                io_dis_uops_1_0_bits_is_amo,
                io_dis_uops_1_0_bits_uses_ldq,
                io_dis_uops_1_0_bits_uses_stq,
                io_dis_uops_1_0_bits_ldst_val,
  output [1:0]  io_dis_uops_1_0_bits_dst_rtype,
                io_dis_uops_1_0_bits_lrs1_rtype,
                io_dis_uops_1_0_bits_lrs2_rtype,
  output        io_dis_uops_1_0_bits_fp_val,
                io_dis_uops_1_1_valid,
  output [6:0]  io_dis_uops_1_1_bits_uopc,
  output        io_dis_uops_1_1_bits_is_rvc,
  output [9:0]  io_dis_uops_1_1_bits_fu_code,
  output        io_dis_uops_1_1_bits_is_br,
                io_dis_uops_1_1_bits_is_jalr,
                io_dis_uops_1_1_bits_is_jal,
                io_dis_uops_1_1_bits_is_sfb,
  output [19:0] io_dis_uops_1_1_bits_br_mask,
  output [4:0]  io_dis_uops_1_1_bits_br_tag,
  output [5:0]  io_dis_uops_1_1_bits_ftq_idx,
  output        io_dis_uops_1_1_bits_edge_inst,
  output [5:0]  io_dis_uops_1_1_bits_pc_lob,
  output        io_dis_uops_1_1_bits_taken,
  output [19:0] io_dis_uops_1_1_bits_imm_packed,
  output [6:0]  io_dis_uops_1_1_bits_rob_idx,
  output [4:0]  io_dis_uops_1_1_bits_ldq_idx,
                io_dis_uops_1_1_bits_stq_idx,
  output [6:0]  io_dis_uops_1_1_bits_pdst,
                io_dis_uops_1_1_bits_prs1,
                io_dis_uops_1_1_bits_prs2,
                io_dis_uops_1_1_bits_prs3,
  output        io_dis_uops_1_1_bits_prs1_busy,
                io_dis_uops_1_1_bits_prs2_busy,
                io_dis_uops_1_1_bits_exception,
                io_dis_uops_1_1_bits_bypassable,
  output [4:0]  io_dis_uops_1_1_bits_mem_cmd,
  output [1:0]  io_dis_uops_1_1_bits_mem_size,
  output        io_dis_uops_1_1_bits_mem_signed,
                io_dis_uops_1_1_bits_is_fence,
                io_dis_uops_1_1_bits_is_fencei,
                io_dis_uops_1_1_bits_is_amo,
                io_dis_uops_1_1_bits_uses_ldq,
                io_dis_uops_1_1_bits_uses_stq,
                io_dis_uops_1_1_bits_ldst_val,
  output [1:0]  io_dis_uops_1_1_bits_dst_rtype,
                io_dis_uops_1_1_bits_lrs1_rtype,
                io_dis_uops_1_1_bits_lrs2_rtype,
  output        io_dis_uops_1_1_bits_fp_val,
                io_dis_uops_1_2_valid,
  output [6:0]  io_dis_uops_1_2_bits_uopc,
  output        io_dis_uops_1_2_bits_is_rvc,
  output [9:0]  io_dis_uops_1_2_bits_fu_code,
  output        io_dis_uops_1_2_bits_is_br,
                io_dis_uops_1_2_bits_is_jalr,
                io_dis_uops_1_2_bits_is_jal,
                io_dis_uops_1_2_bits_is_sfb,
  output [19:0] io_dis_uops_1_2_bits_br_mask,
  output [4:0]  io_dis_uops_1_2_bits_br_tag,
  output [5:0]  io_dis_uops_1_2_bits_ftq_idx,
  output        io_dis_uops_1_2_bits_edge_inst,
  output [5:0]  io_dis_uops_1_2_bits_pc_lob,
  output        io_dis_uops_1_2_bits_taken,
  output [19:0] io_dis_uops_1_2_bits_imm_packed,
  output [6:0]  io_dis_uops_1_2_bits_rob_idx,
  output [4:0]  io_dis_uops_1_2_bits_ldq_idx,
                io_dis_uops_1_2_bits_stq_idx,
  output [6:0]  io_dis_uops_1_2_bits_pdst,
                io_dis_uops_1_2_bits_prs1,
                io_dis_uops_1_2_bits_prs2,
                io_dis_uops_1_2_bits_prs3,
  output        io_dis_uops_1_2_bits_prs1_busy,
                io_dis_uops_1_2_bits_prs2_busy,
                io_dis_uops_1_2_bits_exception,
                io_dis_uops_1_2_bits_bypassable,
  output [4:0]  io_dis_uops_1_2_bits_mem_cmd,
  output [1:0]  io_dis_uops_1_2_bits_mem_size,
  output        io_dis_uops_1_2_bits_mem_signed,
                io_dis_uops_1_2_bits_is_fence,
                io_dis_uops_1_2_bits_is_fencei,
                io_dis_uops_1_2_bits_is_amo,
                io_dis_uops_1_2_bits_uses_ldq,
                io_dis_uops_1_2_bits_uses_stq,
                io_dis_uops_1_2_bits_ldst_val,
  output [1:0]  io_dis_uops_1_2_bits_dst_rtype,
                io_dis_uops_1_2_bits_lrs1_rtype,
                io_dis_uops_1_2_bits_lrs2_rtype,
  output        io_dis_uops_1_2_bits_fp_val,
                io_dis_uops_1_3_valid,
  output [6:0]  io_dis_uops_1_3_bits_uopc,
  output        io_dis_uops_1_3_bits_is_rvc,
  output [9:0]  io_dis_uops_1_3_bits_fu_code,
  output        io_dis_uops_1_3_bits_is_br,
                io_dis_uops_1_3_bits_is_jalr,
                io_dis_uops_1_3_bits_is_jal,
                io_dis_uops_1_3_bits_is_sfb,
  output [19:0] io_dis_uops_1_3_bits_br_mask,
  output [4:0]  io_dis_uops_1_3_bits_br_tag,
  output [5:0]  io_dis_uops_1_3_bits_ftq_idx,
  output        io_dis_uops_1_3_bits_edge_inst,
  output [5:0]  io_dis_uops_1_3_bits_pc_lob,
  output        io_dis_uops_1_3_bits_taken,
  output [19:0] io_dis_uops_1_3_bits_imm_packed,
  output [6:0]  io_dis_uops_1_3_bits_rob_idx,
  output [4:0]  io_dis_uops_1_3_bits_ldq_idx,
                io_dis_uops_1_3_bits_stq_idx,
  output [6:0]  io_dis_uops_1_3_bits_pdst,
                io_dis_uops_1_3_bits_prs1,
                io_dis_uops_1_3_bits_prs2,
                io_dis_uops_1_3_bits_prs3,
  output        io_dis_uops_1_3_bits_prs1_busy,
                io_dis_uops_1_3_bits_prs2_busy,
                io_dis_uops_1_3_bits_exception,
                io_dis_uops_1_3_bits_bypassable,
  output [4:0]  io_dis_uops_1_3_bits_mem_cmd,
  output [1:0]  io_dis_uops_1_3_bits_mem_size,
  output        io_dis_uops_1_3_bits_mem_signed,
                io_dis_uops_1_3_bits_is_fence,
                io_dis_uops_1_3_bits_is_fencei,
                io_dis_uops_1_3_bits_is_amo,
                io_dis_uops_1_3_bits_uses_ldq,
                io_dis_uops_1_3_bits_uses_stq,
                io_dis_uops_1_3_bits_ldst_val,
  output [1:0]  io_dis_uops_1_3_bits_dst_rtype,
                io_dis_uops_1_3_bits_lrs1_rtype,
                io_dis_uops_1_3_bits_lrs2_rtype,
  output        io_dis_uops_1_3_bits_fp_val,
                io_dis_uops_0_0_valid,
  output [6:0]  io_dis_uops_0_0_bits_uopc,
  output        io_dis_uops_0_0_bits_is_rvc,
  output [9:0]  io_dis_uops_0_0_bits_fu_code,
  output        io_dis_uops_0_0_bits_is_br,
                io_dis_uops_0_0_bits_is_jalr,
                io_dis_uops_0_0_bits_is_jal,
                io_dis_uops_0_0_bits_is_sfb,
  output [19:0] io_dis_uops_0_0_bits_br_mask,
  output [4:0]  io_dis_uops_0_0_bits_br_tag,
  output [5:0]  io_dis_uops_0_0_bits_ftq_idx,
  output        io_dis_uops_0_0_bits_edge_inst,
  output [5:0]  io_dis_uops_0_0_bits_pc_lob,
  output        io_dis_uops_0_0_bits_taken,
  output [19:0] io_dis_uops_0_0_bits_imm_packed,
  output [6:0]  io_dis_uops_0_0_bits_rob_idx,
  output [4:0]  io_dis_uops_0_0_bits_ldq_idx,
                io_dis_uops_0_0_bits_stq_idx,
  output [6:0]  io_dis_uops_0_0_bits_pdst,
                io_dis_uops_0_0_bits_prs1,
                io_dis_uops_0_0_bits_prs2,
                io_dis_uops_0_0_bits_prs3,
  output        io_dis_uops_0_0_bits_prs1_busy,
                io_dis_uops_0_0_bits_prs2_busy,
                io_dis_uops_0_0_bits_exception,
                io_dis_uops_0_0_bits_bypassable,
  output [4:0]  io_dis_uops_0_0_bits_mem_cmd,
  output [1:0]  io_dis_uops_0_0_bits_mem_size,
  output        io_dis_uops_0_0_bits_mem_signed,
                io_dis_uops_0_0_bits_is_fence,
                io_dis_uops_0_0_bits_is_fencei,
                io_dis_uops_0_0_bits_is_amo,
                io_dis_uops_0_0_bits_uses_ldq,
                io_dis_uops_0_0_bits_uses_stq,
                io_dis_uops_0_0_bits_ldst_val,
  output [1:0]  io_dis_uops_0_0_bits_dst_rtype,
                io_dis_uops_0_0_bits_lrs1_rtype,
                io_dis_uops_0_0_bits_lrs2_rtype,
  output        io_dis_uops_0_0_bits_fp_val,
                io_dis_uops_0_1_valid,
  output [6:0]  io_dis_uops_0_1_bits_uopc,
  output        io_dis_uops_0_1_bits_is_rvc,
  output [9:0]  io_dis_uops_0_1_bits_fu_code,
  output        io_dis_uops_0_1_bits_is_br,
                io_dis_uops_0_1_bits_is_jalr,
                io_dis_uops_0_1_bits_is_jal,
                io_dis_uops_0_1_bits_is_sfb,
  output [19:0] io_dis_uops_0_1_bits_br_mask,
  output [4:0]  io_dis_uops_0_1_bits_br_tag,
  output [5:0]  io_dis_uops_0_1_bits_ftq_idx,
  output        io_dis_uops_0_1_bits_edge_inst,
  output [5:0]  io_dis_uops_0_1_bits_pc_lob,
  output        io_dis_uops_0_1_bits_taken,
  output [19:0] io_dis_uops_0_1_bits_imm_packed,
  output [6:0]  io_dis_uops_0_1_bits_rob_idx,
  output [4:0]  io_dis_uops_0_1_bits_ldq_idx,
                io_dis_uops_0_1_bits_stq_idx,
  output [6:0]  io_dis_uops_0_1_bits_pdst,
                io_dis_uops_0_1_bits_prs1,
                io_dis_uops_0_1_bits_prs2,
                io_dis_uops_0_1_bits_prs3,
  output        io_dis_uops_0_1_bits_prs1_busy,
                io_dis_uops_0_1_bits_prs2_busy,
                io_dis_uops_0_1_bits_exception,
                io_dis_uops_0_1_bits_bypassable,
  output [4:0]  io_dis_uops_0_1_bits_mem_cmd,
  output [1:0]  io_dis_uops_0_1_bits_mem_size,
  output        io_dis_uops_0_1_bits_mem_signed,
                io_dis_uops_0_1_bits_is_fence,
                io_dis_uops_0_1_bits_is_fencei,
                io_dis_uops_0_1_bits_is_amo,
                io_dis_uops_0_1_bits_uses_ldq,
                io_dis_uops_0_1_bits_uses_stq,
                io_dis_uops_0_1_bits_ldst_val,
  output [1:0]  io_dis_uops_0_1_bits_dst_rtype,
                io_dis_uops_0_1_bits_lrs1_rtype,
                io_dis_uops_0_1_bits_lrs2_rtype,
  output        io_dis_uops_0_1_bits_fp_val,
                io_dis_uops_0_2_valid,
  output [6:0]  io_dis_uops_0_2_bits_uopc,
  output        io_dis_uops_0_2_bits_is_rvc,
  output [9:0]  io_dis_uops_0_2_bits_fu_code,
  output        io_dis_uops_0_2_bits_is_br,
                io_dis_uops_0_2_bits_is_jalr,
                io_dis_uops_0_2_bits_is_jal,
                io_dis_uops_0_2_bits_is_sfb,
  output [19:0] io_dis_uops_0_2_bits_br_mask,
  output [4:0]  io_dis_uops_0_2_bits_br_tag,
  output [5:0]  io_dis_uops_0_2_bits_ftq_idx,
  output        io_dis_uops_0_2_bits_edge_inst,
  output [5:0]  io_dis_uops_0_2_bits_pc_lob,
  output        io_dis_uops_0_2_bits_taken,
  output [19:0] io_dis_uops_0_2_bits_imm_packed,
  output [6:0]  io_dis_uops_0_2_bits_rob_idx,
  output [4:0]  io_dis_uops_0_2_bits_ldq_idx,
                io_dis_uops_0_2_bits_stq_idx,
  output [6:0]  io_dis_uops_0_2_bits_pdst,
                io_dis_uops_0_2_bits_prs1,
                io_dis_uops_0_2_bits_prs2,
                io_dis_uops_0_2_bits_prs3,
  output        io_dis_uops_0_2_bits_prs1_busy,
                io_dis_uops_0_2_bits_prs2_busy,
                io_dis_uops_0_2_bits_exception,
                io_dis_uops_0_2_bits_bypassable,
  output [4:0]  io_dis_uops_0_2_bits_mem_cmd,
  output [1:0]  io_dis_uops_0_2_bits_mem_size,
  output        io_dis_uops_0_2_bits_mem_signed,
                io_dis_uops_0_2_bits_is_fence,
                io_dis_uops_0_2_bits_is_fencei,
                io_dis_uops_0_2_bits_is_amo,
                io_dis_uops_0_2_bits_uses_ldq,
                io_dis_uops_0_2_bits_uses_stq,
                io_dis_uops_0_2_bits_ldst_val,
  output [1:0]  io_dis_uops_0_2_bits_dst_rtype,
                io_dis_uops_0_2_bits_lrs1_rtype,
                io_dis_uops_0_2_bits_lrs2_rtype,
  output        io_dis_uops_0_2_bits_fp_val,
                io_dis_uops_0_3_valid,
  output [6:0]  io_dis_uops_0_3_bits_uopc,
  output        io_dis_uops_0_3_bits_is_rvc,
  output [9:0]  io_dis_uops_0_3_bits_fu_code,
  output        io_dis_uops_0_3_bits_is_br,
                io_dis_uops_0_3_bits_is_jalr,
                io_dis_uops_0_3_bits_is_jal,
                io_dis_uops_0_3_bits_is_sfb,
  output [19:0] io_dis_uops_0_3_bits_br_mask,
  output [4:0]  io_dis_uops_0_3_bits_br_tag,
  output [5:0]  io_dis_uops_0_3_bits_ftq_idx,
  output        io_dis_uops_0_3_bits_edge_inst,
  output [5:0]  io_dis_uops_0_3_bits_pc_lob,
  output        io_dis_uops_0_3_bits_taken,
  output [19:0] io_dis_uops_0_3_bits_imm_packed,
  output [6:0]  io_dis_uops_0_3_bits_rob_idx,
  output [4:0]  io_dis_uops_0_3_bits_ldq_idx,
                io_dis_uops_0_3_bits_stq_idx,
  output [6:0]  io_dis_uops_0_3_bits_pdst,
                io_dis_uops_0_3_bits_prs1,
                io_dis_uops_0_3_bits_prs2,
                io_dis_uops_0_3_bits_prs3,
  output        io_dis_uops_0_3_bits_prs1_busy,
                io_dis_uops_0_3_bits_prs2_busy,
                io_dis_uops_0_3_bits_exception,
                io_dis_uops_0_3_bits_bypassable,
  output [4:0]  io_dis_uops_0_3_bits_mem_cmd,
  output [1:0]  io_dis_uops_0_3_bits_mem_size,
  output        io_dis_uops_0_3_bits_mem_signed,
                io_dis_uops_0_3_bits_is_fence,
                io_dis_uops_0_3_bits_is_fencei,
                io_dis_uops_0_3_bits_is_amo,
                io_dis_uops_0_3_bits_uses_ldq,
                io_dis_uops_0_3_bits_uses_stq,
                io_dis_uops_0_3_bits_ldst_val,
  output [1:0]  io_dis_uops_0_3_bits_dst_rtype,
                io_dis_uops_0_3_bits_lrs1_rtype,
                io_dis_uops_0_3_bits_lrs2_rtype,
  output        io_dis_uops_0_3_bits_fp_val
);

  assign io_ren_uops_0_ready = io_dis_uops_0_0_ready & io_dis_uops_1_0_ready & io_dis_uops_2_0_ready;
  assign io_ren_uops_1_ready = io_dis_uops_0_1_ready & io_dis_uops_1_1_ready & io_dis_uops_2_1_ready;
  assign io_ren_uops_2_ready = io_dis_uops_0_2_ready & io_dis_uops_1_2_ready & io_dis_uops_2_2_ready;
  assign io_ren_uops_3_ready = io_dis_uops_0_3_ready & io_dis_uops_1_3_ready & io_dis_uops_2_3_ready;
  assign io_dis_uops_2_0_valid = io_ren_uops_0_valid & io_ren_uops_0_bits_iq_type[2];
  assign io_dis_uops_2_0_bits_uopc = io_ren_uops_0_bits_uopc;
  assign io_dis_uops_2_0_bits_fu_code = io_ren_uops_0_bits_fu_code;
  assign io_dis_uops_2_0_bits_br_mask = io_ren_uops_0_bits_br_mask;
  assign io_dis_uops_2_0_bits_imm_packed = io_ren_uops_0_bits_imm_packed;
  assign io_dis_uops_2_0_bits_rob_idx = io_ren_uops_0_bits_rob_idx;
  assign io_dis_uops_2_0_bits_stq_idx = io_ren_uops_0_bits_stq_idx;
  assign io_dis_uops_2_0_bits_pdst = io_ren_uops_0_bits_pdst;
  assign io_dis_uops_2_0_bits_prs1 = io_ren_uops_0_bits_prs1;
  assign io_dis_uops_2_0_bits_prs2 = io_ren_uops_0_bits_prs2;
  assign io_dis_uops_2_0_bits_prs3 = io_ren_uops_0_bits_prs3;
  assign io_dis_uops_2_0_bits_prs1_busy = io_ren_uops_0_bits_prs1_busy;
  assign io_dis_uops_2_0_bits_prs2_busy = io_ren_uops_0_bits_prs2_busy;
  assign io_dis_uops_2_0_bits_prs3_busy = io_ren_uops_0_bits_prs3_busy;
  assign io_dis_uops_2_0_bits_exception = io_ren_uops_0_bits_exception;
  assign io_dis_uops_2_0_bits_mem_cmd = io_ren_uops_0_bits_mem_cmd;
  assign io_dis_uops_2_0_bits_is_fence = io_ren_uops_0_bits_is_fence;
  assign io_dis_uops_2_0_bits_is_fencei = io_ren_uops_0_bits_is_fencei;
  assign io_dis_uops_2_0_bits_is_amo = io_ren_uops_0_bits_is_amo;
  assign io_dis_uops_2_0_bits_uses_ldq = io_ren_uops_0_bits_uses_ldq;
  assign io_dis_uops_2_0_bits_uses_stq = io_ren_uops_0_bits_uses_stq;
  assign io_dis_uops_2_0_bits_dst_rtype = io_ren_uops_0_bits_dst_rtype;
  assign io_dis_uops_2_0_bits_fp_val = io_ren_uops_0_bits_fp_val;
  assign io_dis_uops_2_1_valid = io_ren_uops_1_valid & io_ren_uops_1_bits_iq_type[2];
  assign io_dis_uops_2_1_bits_uopc = io_ren_uops_1_bits_uopc;
  assign io_dis_uops_2_1_bits_fu_code = io_ren_uops_1_bits_fu_code;
  assign io_dis_uops_2_1_bits_br_mask = io_ren_uops_1_bits_br_mask;
  assign io_dis_uops_2_1_bits_imm_packed = io_ren_uops_1_bits_imm_packed;
  assign io_dis_uops_2_1_bits_rob_idx = io_ren_uops_1_bits_rob_idx;
  assign io_dis_uops_2_1_bits_stq_idx = io_ren_uops_1_bits_stq_idx;
  assign io_dis_uops_2_1_bits_pdst = io_ren_uops_1_bits_pdst;
  assign io_dis_uops_2_1_bits_prs1 = io_ren_uops_1_bits_prs1;
  assign io_dis_uops_2_1_bits_prs2 = io_ren_uops_1_bits_prs2;
  assign io_dis_uops_2_1_bits_prs3 = io_ren_uops_1_bits_prs3;
  assign io_dis_uops_2_1_bits_prs1_busy = io_ren_uops_1_bits_prs1_busy;
  assign io_dis_uops_2_1_bits_prs2_busy = io_ren_uops_1_bits_prs2_busy;
  assign io_dis_uops_2_1_bits_prs3_busy = io_ren_uops_1_bits_prs3_busy;
  assign io_dis_uops_2_1_bits_exception = io_ren_uops_1_bits_exception;
  assign io_dis_uops_2_1_bits_mem_cmd = io_ren_uops_1_bits_mem_cmd;
  assign io_dis_uops_2_1_bits_is_fence = io_ren_uops_1_bits_is_fence;
  assign io_dis_uops_2_1_bits_is_fencei = io_ren_uops_1_bits_is_fencei;
  assign io_dis_uops_2_1_bits_is_amo = io_ren_uops_1_bits_is_amo;
  assign io_dis_uops_2_1_bits_uses_ldq = io_ren_uops_1_bits_uses_ldq;
  assign io_dis_uops_2_1_bits_uses_stq = io_ren_uops_1_bits_uses_stq;
  assign io_dis_uops_2_1_bits_dst_rtype = io_ren_uops_1_bits_dst_rtype;
  assign io_dis_uops_2_1_bits_fp_val = io_ren_uops_1_bits_fp_val;
  assign io_dis_uops_2_2_valid = io_ren_uops_2_valid & io_ren_uops_2_bits_iq_type[2];
  assign io_dis_uops_2_2_bits_uopc = io_ren_uops_2_bits_uopc;
  assign io_dis_uops_2_2_bits_fu_code = io_ren_uops_2_bits_fu_code;
  assign io_dis_uops_2_2_bits_br_mask = io_ren_uops_2_bits_br_mask;
  assign io_dis_uops_2_2_bits_imm_packed = io_ren_uops_2_bits_imm_packed;
  assign io_dis_uops_2_2_bits_rob_idx = io_ren_uops_2_bits_rob_idx;
  assign io_dis_uops_2_2_bits_stq_idx = io_ren_uops_2_bits_stq_idx;
  assign io_dis_uops_2_2_bits_pdst = io_ren_uops_2_bits_pdst;
  assign io_dis_uops_2_2_bits_prs1 = io_ren_uops_2_bits_prs1;
  assign io_dis_uops_2_2_bits_prs2 = io_ren_uops_2_bits_prs2;
  assign io_dis_uops_2_2_bits_prs3 = io_ren_uops_2_bits_prs3;
  assign io_dis_uops_2_2_bits_prs1_busy = io_ren_uops_2_bits_prs1_busy;
  assign io_dis_uops_2_2_bits_prs2_busy = io_ren_uops_2_bits_prs2_busy;
  assign io_dis_uops_2_2_bits_prs3_busy = io_ren_uops_2_bits_prs3_busy;
  assign io_dis_uops_2_2_bits_exception = io_ren_uops_2_bits_exception;
  assign io_dis_uops_2_2_bits_mem_cmd = io_ren_uops_2_bits_mem_cmd;
  assign io_dis_uops_2_2_bits_is_fence = io_ren_uops_2_bits_is_fence;
  assign io_dis_uops_2_2_bits_is_fencei = io_ren_uops_2_bits_is_fencei;
  assign io_dis_uops_2_2_bits_is_amo = io_ren_uops_2_bits_is_amo;
  assign io_dis_uops_2_2_bits_uses_ldq = io_ren_uops_2_bits_uses_ldq;
  assign io_dis_uops_2_2_bits_uses_stq = io_ren_uops_2_bits_uses_stq;
  assign io_dis_uops_2_2_bits_dst_rtype = io_ren_uops_2_bits_dst_rtype;
  assign io_dis_uops_2_2_bits_fp_val = io_ren_uops_2_bits_fp_val;
  assign io_dis_uops_2_3_valid = io_ren_uops_3_valid & io_ren_uops_3_bits_iq_type[2];
  assign io_dis_uops_2_3_bits_uopc = io_ren_uops_3_bits_uopc;
  assign io_dis_uops_2_3_bits_fu_code = io_ren_uops_3_bits_fu_code;
  assign io_dis_uops_2_3_bits_br_mask = io_ren_uops_3_bits_br_mask;
  assign io_dis_uops_2_3_bits_imm_packed = io_ren_uops_3_bits_imm_packed;
  assign io_dis_uops_2_3_bits_rob_idx = io_ren_uops_3_bits_rob_idx;
  assign io_dis_uops_2_3_bits_stq_idx = io_ren_uops_3_bits_stq_idx;
  assign io_dis_uops_2_3_bits_pdst = io_ren_uops_3_bits_pdst;
  assign io_dis_uops_2_3_bits_prs1 = io_ren_uops_3_bits_prs1;
  assign io_dis_uops_2_3_bits_prs2 = io_ren_uops_3_bits_prs2;
  assign io_dis_uops_2_3_bits_prs3 = io_ren_uops_3_bits_prs3;
  assign io_dis_uops_2_3_bits_prs1_busy = io_ren_uops_3_bits_prs1_busy;
  assign io_dis_uops_2_3_bits_prs2_busy = io_ren_uops_3_bits_prs2_busy;
  assign io_dis_uops_2_3_bits_prs3_busy = io_ren_uops_3_bits_prs3_busy;
  assign io_dis_uops_2_3_bits_exception = io_ren_uops_3_bits_exception;
  assign io_dis_uops_2_3_bits_mem_cmd = io_ren_uops_3_bits_mem_cmd;
  assign io_dis_uops_2_3_bits_is_fence = io_ren_uops_3_bits_is_fence;
  assign io_dis_uops_2_3_bits_is_fencei = io_ren_uops_3_bits_is_fencei;
  assign io_dis_uops_2_3_bits_is_amo = io_ren_uops_3_bits_is_amo;
  assign io_dis_uops_2_3_bits_uses_ldq = io_ren_uops_3_bits_uses_ldq;
  assign io_dis_uops_2_3_bits_uses_stq = io_ren_uops_3_bits_uses_stq;
  assign io_dis_uops_2_3_bits_dst_rtype = io_ren_uops_3_bits_dst_rtype;
  assign io_dis_uops_2_3_bits_fp_val = io_ren_uops_3_bits_fp_val;
  assign io_dis_uops_1_0_valid = io_ren_uops_0_valid & io_ren_uops_0_bits_iq_type[0];
  assign io_dis_uops_1_0_bits_uopc = io_ren_uops_0_bits_uopc;
  assign io_dis_uops_1_0_bits_is_rvc = io_ren_uops_0_bits_is_rvc;
  assign io_dis_uops_1_0_bits_fu_code = io_ren_uops_0_bits_fu_code;
  assign io_dis_uops_1_0_bits_is_br = io_ren_uops_0_bits_is_br;
  assign io_dis_uops_1_0_bits_is_jalr = io_ren_uops_0_bits_is_jalr;
  assign io_dis_uops_1_0_bits_is_jal = io_ren_uops_0_bits_is_jal;
  assign io_dis_uops_1_0_bits_is_sfb = io_ren_uops_0_bits_is_sfb;
  assign io_dis_uops_1_0_bits_br_mask = io_ren_uops_0_bits_br_mask;
  assign io_dis_uops_1_0_bits_br_tag = io_ren_uops_0_bits_br_tag;
  assign io_dis_uops_1_0_bits_ftq_idx = io_ren_uops_0_bits_ftq_idx;
  assign io_dis_uops_1_0_bits_edge_inst = io_ren_uops_0_bits_edge_inst;
  assign io_dis_uops_1_0_bits_pc_lob = io_ren_uops_0_bits_pc_lob;
  assign io_dis_uops_1_0_bits_taken = io_ren_uops_0_bits_taken;
  assign io_dis_uops_1_0_bits_imm_packed = io_ren_uops_0_bits_imm_packed;
  assign io_dis_uops_1_0_bits_rob_idx = io_ren_uops_0_bits_rob_idx;
  assign io_dis_uops_1_0_bits_ldq_idx = io_ren_uops_0_bits_ldq_idx;
  assign io_dis_uops_1_0_bits_stq_idx = io_ren_uops_0_bits_stq_idx;
  assign io_dis_uops_1_0_bits_pdst = io_ren_uops_0_bits_pdst;
  assign io_dis_uops_1_0_bits_prs1 = io_ren_uops_0_bits_prs1;
  assign io_dis_uops_1_0_bits_prs2 = io_ren_uops_0_bits_prs2;
  assign io_dis_uops_1_0_bits_prs3 = io_ren_uops_0_bits_prs3;
  assign io_dis_uops_1_0_bits_prs1_busy = io_ren_uops_0_bits_prs1_busy;
  assign io_dis_uops_1_0_bits_prs2_busy = io_ren_uops_0_bits_prs2_busy;
  assign io_dis_uops_1_0_bits_exception = io_ren_uops_0_bits_exception;
  assign io_dis_uops_1_0_bits_bypassable = io_ren_uops_0_bits_bypassable;
  assign io_dis_uops_1_0_bits_mem_cmd = io_ren_uops_0_bits_mem_cmd;
  assign io_dis_uops_1_0_bits_mem_size = io_ren_uops_0_bits_mem_size;
  assign io_dis_uops_1_0_bits_mem_signed = io_ren_uops_0_bits_mem_signed;
  assign io_dis_uops_1_0_bits_is_fence = io_ren_uops_0_bits_is_fence;
  assign io_dis_uops_1_0_bits_is_fencei = io_ren_uops_0_bits_is_fencei;
  assign io_dis_uops_1_0_bits_is_amo = io_ren_uops_0_bits_is_amo;
  assign io_dis_uops_1_0_bits_uses_ldq = io_ren_uops_0_bits_uses_ldq;
  assign io_dis_uops_1_0_bits_uses_stq = io_ren_uops_0_bits_uses_stq;
  assign io_dis_uops_1_0_bits_ldst_val = io_ren_uops_0_bits_ldst_val;
  assign io_dis_uops_1_0_bits_dst_rtype = io_ren_uops_0_bits_dst_rtype;
  assign io_dis_uops_1_0_bits_lrs1_rtype = io_ren_uops_0_bits_lrs1_rtype;
  assign io_dis_uops_1_0_bits_lrs2_rtype = io_ren_uops_0_bits_lrs2_rtype;
  assign io_dis_uops_1_0_bits_fp_val = io_ren_uops_0_bits_fp_val;
  assign io_dis_uops_1_1_valid = io_ren_uops_1_valid & io_ren_uops_1_bits_iq_type[0];
  assign io_dis_uops_1_1_bits_uopc = io_ren_uops_1_bits_uopc;
  assign io_dis_uops_1_1_bits_is_rvc = io_ren_uops_1_bits_is_rvc;
  assign io_dis_uops_1_1_bits_fu_code = io_ren_uops_1_bits_fu_code;
  assign io_dis_uops_1_1_bits_is_br = io_ren_uops_1_bits_is_br;
  assign io_dis_uops_1_1_bits_is_jalr = io_ren_uops_1_bits_is_jalr;
  assign io_dis_uops_1_1_bits_is_jal = io_ren_uops_1_bits_is_jal;
  assign io_dis_uops_1_1_bits_is_sfb = io_ren_uops_1_bits_is_sfb;
  assign io_dis_uops_1_1_bits_br_mask = io_ren_uops_1_bits_br_mask;
  assign io_dis_uops_1_1_bits_br_tag = io_ren_uops_1_bits_br_tag;
  assign io_dis_uops_1_1_bits_ftq_idx = io_ren_uops_1_bits_ftq_idx;
  assign io_dis_uops_1_1_bits_edge_inst = io_ren_uops_1_bits_edge_inst;
  assign io_dis_uops_1_1_bits_pc_lob = io_ren_uops_1_bits_pc_lob;
  assign io_dis_uops_1_1_bits_taken = io_ren_uops_1_bits_taken;
  assign io_dis_uops_1_1_bits_imm_packed = io_ren_uops_1_bits_imm_packed;
  assign io_dis_uops_1_1_bits_rob_idx = io_ren_uops_1_bits_rob_idx;
  assign io_dis_uops_1_1_bits_ldq_idx = io_ren_uops_1_bits_ldq_idx;
  assign io_dis_uops_1_1_bits_stq_idx = io_ren_uops_1_bits_stq_idx;
  assign io_dis_uops_1_1_bits_pdst = io_ren_uops_1_bits_pdst;
  assign io_dis_uops_1_1_bits_prs1 = io_ren_uops_1_bits_prs1;
  assign io_dis_uops_1_1_bits_prs2 = io_ren_uops_1_bits_prs2;
  assign io_dis_uops_1_1_bits_prs3 = io_ren_uops_1_bits_prs3;
  assign io_dis_uops_1_1_bits_prs1_busy = io_ren_uops_1_bits_prs1_busy;
  assign io_dis_uops_1_1_bits_prs2_busy = io_ren_uops_1_bits_prs2_busy;
  assign io_dis_uops_1_1_bits_exception = io_ren_uops_1_bits_exception;
  assign io_dis_uops_1_1_bits_bypassable = io_ren_uops_1_bits_bypassable;
  assign io_dis_uops_1_1_bits_mem_cmd = io_ren_uops_1_bits_mem_cmd;
  assign io_dis_uops_1_1_bits_mem_size = io_ren_uops_1_bits_mem_size;
  assign io_dis_uops_1_1_bits_mem_signed = io_ren_uops_1_bits_mem_signed;
  assign io_dis_uops_1_1_bits_is_fence = io_ren_uops_1_bits_is_fence;
  assign io_dis_uops_1_1_bits_is_fencei = io_ren_uops_1_bits_is_fencei;
  assign io_dis_uops_1_1_bits_is_amo = io_ren_uops_1_bits_is_amo;
  assign io_dis_uops_1_1_bits_uses_ldq = io_ren_uops_1_bits_uses_ldq;
  assign io_dis_uops_1_1_bits_uses_stq = io_ren_uops_1_bits_uses_stq;
  assign io_dis_uops_1_1_bits_ldst_val = io_ren_uops_1_bits_ldst_val;
  assign io_dis_uops_1_1_bits_dst_rtype = io_ren_uops_1_bits_dst_rtype;
  assign io_dis_uops_1_1_bits_lrs1_rtype = io_ren_uops_1_bits_lrs1_rtype;
  assign io_dis_uops_1_1_bits_lrs2_rtype = io_ren_uops_1_bits_lrs2_rtype;
  assign io_dis_uops_1_1_bits_fp_val = io_ren_uops_1_bits_fp_val;
  assign io_dis_uops_1_2_valid = io_ren_uops_2_valid & io_ren_uops_2_bits_iq_type[0];
  assign io_dis_uops_1_2_bits_uopc = io_ren_uops_2_bits_uopc;
  assign io_dis_uops_1_2_bits_is_rvc = io_ren_uops_2_bits_is_rvc;
  assign io_dis_uops_1_2_bits_fu_code = io_ren_uops_2_bits_fu_code;
  assign io_dis_uops_1_2_bits_is_br = io_ren_uops_2_bits_is_br;
  assign io_dis_uops_1_2_bits_is_jalr = io_ren_uops_2_bits_is_jalr;
  assign io_dis_uops_1_2_bits_is_jal = io_ren_uops_2_bits_is_jal;
  assign io_dis_uops_1_2_bits_is_sfb = io_ren_uops_2_bits_is_sfb;
  assign io_dis_uops_1_2_bits_br_mask = io_ren_uops_2_bits_br_mask;
  assign io_dis_uops_1_2_bits_br_tag = io_ren_uops_2_bits_br_tag;
  assign io_dis_uops_1_2_bits_ftq_idx = io_ren_uops_2_bits_ftq_idx;
  assign io_dis_uops_1_2_bits_edge_inst = io_ren_uops_2_bits_edge_inst;
  assign io_dis_uops_1_2_bits_pc_lob = io_ren_uops_2_bits_pc_lob;
  assign io_dis_uops_1_2_bits_taken = io_ren_uops_2_bits_taken;
  assign io_dis_uops_1_2_bits_imm_packed = io_ren_uops_2_bits_imm_packed;
  assign io_dis_uops_1_2_bits_rob_idx = io_ren_uops_2_bits_rob_idx;
  assign io_dis_uops_1_2_bits_ldq_idx = io_ren_uops_2_bits_ldq_idx;
  assign io_dis_uops_1_2_bits_stq_idx = io_ren_uops_2_bits_stq_idx;
  assign io_dis_uops_1_2_bits_pdst = io_ren_uops_2_bits_pdst;
  assign io_dis_uops_1_2_bits_prs1 = io_ren_uops_2_bits_prs1;
  assign io_dis_uops_1_2_bits_prs2 = io_ren_uops_2_bits_prs2;
  assign io_dis_uops_1_2_bits_prs3 = io_ren_uops_2_bits_prs3;
  assign io_dis_uops_1_2_bits_prs1_busy = io_ren_uops_2_bits_prs1_busy;
  assign io_dis_uops_1_2_bits_prs2_busy = io_ren_uops_2_bits_prs2_busy;
  assign io_dis_uops_1_2_bits_exception = io_ren_uops_2_bits_exception;
  assign io_dis_uops_1_2_bits_bypassable = io_ren_uops_2_bits_bypassable;
  assign io_dis_uops_1_2_bits_mem_cmd = io_ren_uops_2_bits_mem_cmd;
  assign io_dis_uops_1_2_bits_mem_size = io_ren_uops_2_bits_mem_size;
  assign io_dis_uops_1_2_bits_mem_signed = io_ren_uops_2_bits_mem_signed;
  assign io_dis_uops_1_2_bits_is_fence = io_ren_uops_2_bits_is_fence;
  assign io_dis_uops_1_2_bits_is_fencei = io_ren_uops_2_bits_is_fencei;
  assign io_dis_uops_1_2_bits_is_amo = io_ren_uops_2_bits_is_amo;
  assign io_dis_uops_1_2_bits_uses_ldq = io_ren_uops_2_bits_uses_ldq;
  assign io_dis_uops_1_2_bits_uses_stq = io_ren_uops_2_bits_uses_stq;
  assign io_dis_uops_1_2_bits_ldst_val = io_ren_uops_2_bits_ldst_val;
  assign io_dis_uops_1_2_bits_dst_rtype = io_ren_uops_2_bits_dst_rtype;
  assign io_dis_uops_1_2_bits_lrs1_rtype = io_ren_uops_2_bits_lrs1_rtype;
  assign io_dis_uops_1_2_bits_lrs2_rtype = io_ren_uops_2_bits_lrs2_rtype;
  assign io_dis_uops_1_2_bits_fp_val = io_ren_uops_2_bits_fp_val;
  assign io_dis_uops_1_3_valid = io_ren_uops_3_valid & io_ren_uops_3_bits_iq_type[0];
  assign io_dis_uops_1_3_bits_uopc = io_ren_uops_3_bits_uopc;
  assign io_dis_uops_1_3_bits_is_rvc = io_ren_uops_3_bits_is_rvc;
  assign io_dis_uops_1_3_bits_fu_code = io_ren_uops_3_bits_fu_code;
  assign io_dis_uops_1_3_bits_is_br = io_ren_uops_3_bits_is_br;
  assign io_dis_uops_1_3_bits_is_jalr = io_ren_uops_3_bits_is_jalr;
  assign io_dis_uops_1_3_bits_is_jal = io_ren_uops_3_bits_is_jal;
  assign io_dis_uops_1_3_bits_is_sfb = io_ren_uops_3_bits_is_sfb;
  assign io_dis_uops_1_3_bits_br_mask = io_ren_uops_3_bits_br_mask;
  assign io_dis_uops_1_3_bits_br_tag = io_ren_uops_3_bits_br_tag;
  assign io_dis_uops_1_3_bits_ftq_idx = io_ren_uops_3_bits_ftq_idx;
  assign io_dis_uops_1_3_bits_edge_inst = io_ren_uops_3_bits_edge_inst;
  assign io_dis_uops_1_3_bits_pc_lob = io_ren_uops_3_bits_pc_lob;
  assign io_dis_uops_1_3_bits_taken = io_ren_uops_3_bits_taken;
  assign io_dis_uops_1_3_bits_imm_packed = io_ren_uops_3_bits_imm_packed;
  assign io_dis_uops_1_3_bits_rob_idx = io_ren_uops_3_bits_rob_idx;
  assign io_dis_uops_1_3_bits_ldq_idx = io_ren_uops_3_bits_ldq_idx;
  assign io_dis_uops_1_3_bits_stq_idx = io_ren_uops_3_bits_stq_idx;
  assign io_dis_uops_1_3_bits_pdst = io_ren_uops_3_bits_pdst;
  assign io_dis_uops_1_3_bits_prs1 = io_ren_uops_3_bits_prs1;
  assign io_dis_uops_1_3_bits_prs2 = io_ren_uops_3_bits_prs2;
  assign io_dis_uops_1_3_bits_prs3 = io_ren_uops_3_bits_prs3;
  assign io_dis_uops_1_3_bits_prs1_busy = io_ren_uops_3_bits_prs1_busy;
  assign io_dis_uops_1_3_bits_prs2_busy = io_ren_uops_3_bits_prs2_busy;
  assign io_dis_uops_1_3_bits_exception = io_ren_uops_3_bits_exception;
  assign io_dis_uops_1_3_bits_bypassable = io_ren_uops_3_bits_bypassable;
  assign io_dis_uops_1_3_bits_mem_cmd = io_ren_uops_3_bits_mem_cmd;
  assign io_dis_uops_1_3_bits_mem_size = io_ren_uops_3_bits_mem_size;
  assign io_dis_uops_1_3_bits_mem_signed = io_ren_uops_3_bits_mem_signed;
  assign io_dis_uops_1_3_bits_is_fence = io_ren_uops_3_bits_is_fence;
  assign io_dis_uops_1_3_bits_is_fencei = io_ren_uops_3_bits_is_fencei;
  assign io_dis_uops_1_3_bits_is_amo = io_ren_uops_3_bits_is_amo;
  assign io_dis_uops_1_3_bits_uses_ldq = io_ren_uops_3_bits_uses_ldq;
  assign io_dis_uops_1_3_bits_uses_stq = io_ren_uops_3_bits_uses_stq;
  assign io_dis_uops_1_3_bits_ldst_val = io_ren_uops_3_bits_ldst_val;
  assign io_dis_uops_1_3_bits_dst_rtype = io_ren_uops_3_bits_dst_rtype;
  assign io_dis_uops_1_3_bits_lrs1_rtype = io_ren_uops_3_bits_lrs1_rtype;
  assign io_dis_uops_1_3_bits_lrs2_rtype = io_ren_uops_3_bits_lrs2_rtype;
  assign io_dis_uops_1_3_bits_fp_val = io_ren_uops_3_bits_fp_val;
  assign io_dis_uops_0_0_valid = io_ren_uops_0_valid & io_ren_uops_0_bits_iq_type[1];
  assign io_dis_uops_0_0_bits_uopc = io_ren_uops_0_bits_uopc;
  assign io_dis_uops_0_0_bits_is_rvc = io_ren_uops_0_bits_is_rvc;
  assign io_dis_uops_0_0_bits_fu_code = io_ren_uops_0_bits_fu_code;
  assign io_dis_uops_0_0_bits_is_br = io_ren_uops_0_bits_is_br;
  assign io_dis_uops_0_0_bits_is_jalr = io_ren_uops_0_bits_is_jalr;
  assign io_dis_uops_0_0_bits_is_jal = io_ren_uops_0_bits_is_jal;
  assign io_dis_uops_0_0_bits_is_sfb = io_ren_uops_0_bits_is_sfb;
  assign io_dis_uops_0_0_bits_br_mask = io_ren_uops_0_bits_br_mask;
  assign io_dis_uops_0_0_bits_br_tag = io_ren_uops_0_bits_br_tag;
  assign io_dis_uops_0_0_bits_ftq_idx = io_ren_uops_0_bits_ftq_idx;
  assign io_dis_uops_0_0_bits_edge_inst = io_ren_uops_0_bits_edge_inst;
  assign io_dis_uops_0_0_bits_pc_lob = io_ren_uops_0_bits_pc_lob;
  assign io_dis_uops_0_0_bits_taken = io_ren_uops_0_bits_taken;
  assign io_dis_uops_0_0_bits_imm_packed = io_ren_uops_0_bits_imm_packed;
  assign io_dis_uops_0_0_bits_rob_idx = io_ren_uops_0_bits_rob_idx;
  assign io_dis_uops_0_0_bits_ldq_idx = io_ren_uops_0_bits_ldq_idx;
  assign io_dis_uops_0_0_bits_stq_idx = io_ren_uops_0_bits_stq_idx;
  assign io_dis_uops_0_0_bits_pdst = io_ren_uops_0_bits_pdst;
  assign io_dis_uops_0_0_bits_prs1 = io_ren_uops_0_bits_prs1;
  assign io_dis_uops_0_0_bits_prs2 = io_ren_uops_0_bits_prs2;
  assign io_dis_uops_0_0_bits_prs3 = io_ren_uops_0_bits_prs3;
  assign io_dis_uops_0_0_bits_prs1_busy = io_ren_uops_0_bits_prs1_busy;
  assign io_dis_uops_0_0_bits_prs2_busy = io_ren_uops_0_bits_prs2_busy;
  assign io_dis_uops_0_0_bits_exception = io_ren_uops_0_bits_exception;
  assign io_dis_uops_0_0_bits_bypassable = io_ren_uops_0_bits_bypassable;
  assign io_dis_uops_0_0_bits_mem_cmd = io_ren_uops_0_bits_mem_cmd;
  assign io_dis_uops_0_0_bits_mem_size = io_ren_uops_0_bits_mem_size;
  assign io_dis_uops_0_0_bits_mem_signed = io_ren_uops_0_bits_mem_signed;
  assign io_dis_uops_0_0_bits_is_fence = io_ren_uops_0_bits_is_fence;
  assign io_dis_uops_0_0_bits_is_fencei = io_ren_uops_0_bits_is_fencei;
  assign io_dis_uops_0_0_bits_is_amo = io_ren_uops_0_bits_is_amo;
  assign io_dis_uops_0_0_bits_uses_ldq = io_ren_uops_0_bits_uses_ldq;
  assign io_dis_uops_0_0_bits_uses_stq = io_ren_uops_0_bits_uses_stq;
  assign io_dis_uops_0_0_bits_ldst_val = io_ren_uops_0_bits_ldst_val;
  assign io_dis_uops_0_0_bits_dst_rtype = io_ren_uops_0_bits_dst_rtype;
  assign io_dis_uops_0_0_bits_lrs1_rtype = io_ren_uops_0_bits_lrs1_rtype;
  assign io_dis_uops_0_0_bits_lrs2_rtype = io_ren_uops_0_bits_lrs2_rtype;
  assign io_dis_uops_0_0_bits_fp_val = io_ren_uops_0_bits_fp_val;
  assign io_dis_uops_0_1_valid = io_ren_uops_1_valid & io_ren_uops_1_bits_iq_type[1];
  assign io_dis_uops_0_1_bits_uopc = io_ren_uops_1_bits_uopc;
  assign io_dis_uops_0_1_bits_is_rvc = io_ren_uops_1_bits_is_rvc;
  assign io_dis_uops_0_1_bits_fu_code = io_ren_uops_1_bits_fu_code;
  assign io_dis_uops_0_1_bits_is_br = io_ren_uops_1_bits_is_br;
  assign io_dis_uops_0_1_bits_is_jalr = io_ren_uops_1_bits_is_jalr;
  assign io_dis_uops_0_1_bits_is_jal = io_ren_uops_1_bits_is_jal;
  assign io_dis_uops_0_1_bits_is_sfb = io_ren_uops_1_bits_is_sfb;
  assign io_dis_uops_0_1_bits_br_mask = io_ren_uops_1_bits_br_mask;
  assign io_dis_uops_0_1_bits_br_tag = io_ren_uops_1_bits_br_tag;
  assign io_dis_uops_0_1_bits_ftq_idx = io_ren_uops_1_bits_ftq_idx;
  assign io_dis_uops_0_1_bits_edge_inst = io_ren_uops_1_bits_edge_inst;
  assign io_dis_uops_0_1_bits_pc_lob = io_ren_uops_1_bits_pc_lob;
  assign io_dis_uops_0_1_bits_taken = io_ren_uops_1_bits_taken;
  assign io_dis_uops_0_1_bits_imm_packed = io_ren_uops_1_bits_imm_packed;
  assign io_dis_uops_0_1_bits_rob_idx = io_ren_uops_1_bits_rob_idx;
  assign io_dis_uops_0_1_bits_ldq_idx = io_ren_uops_1_bits_ldq_idx;
  assign io_dis_uops_0_1_bits_stq_idx = io_ren_uops_1_bits_stq_idx;
  assign io_dis_uops_0_1_bits_pdst = io_ren_uops_1_bits_pdst;
  assign io_dis_uops_0_1_bits_prs1 = io_ren_uops_1_bits_prs1;
  assign io_dis_uops_0_1_bits_prs2 = io_ren_uops_1_bits_prs2;
  assign io_dis_uops_0_1_bits_prs3 = io_ren_uops_1_bits_prs3;
  assign io_dis_uops_0_1_bits_prs1_busy = io_ren_uops_1_bits_prs1_busy;
  assign io_dis_uops_0_1_bits_prs2_busy = io_ren_uops_1_bits_prs2_busy;
  assign io_dis_uops_0_1_bits_exception = io_ren_uops_1_bits_exception;
  assign io_dis_uops_0_1_bits_bypassable = io_ren_uops_1_bits_bypassable;
  assign io_dis_uops_0_1_bits_mem_cmd = io_ren_uops_1_bits_mem_cmd;
  assign io_dis_uops_0_1_bits_mem_size = io_ren_uops_1_bits_mem_size;
  assign io_dis_uops_0_1_bits_mem_signed = io_ren_uops_1_bits_mem_signed;
  assign io_dis_uops_0_1_bits_is_fence = io_ren_uops_1_bits_is_fence;
  assign io_dis_uops_0_1_bits_is_fencei = io_ren_uops_1_bits_is_fencei;
  assign io_dis_uops_0_1_bits_is_amo = io_ren_uops_1_bits_is_amo;
  assign io_dis_uops_0_1_bits_uses_ldq = io_ren_uops_1_bits_uses_ldq;
  assign io_dis_uops_0_1_bits_uses_stq = io_ren_uops_1_bits_uses_stq;
  assign io_dis_uops_0_1_bits_ldst_val = io_ren_uops_1_bits_ldst_val;
  assign io_dis_uops_0_1_bits_dst_rtype = io_ren_uops_1_bits_dst_rtype;
  assign io_dis_uops_0_1_bits_lrs1_rtype = io_ren_uops_1_bits_lrs1_rtype;
  assign io_dis_uops_0_1_bits_lrs2_rtype = io_ren_uops_1_bits_lrs2_rtype;
  assign io_dis_uops_0_1_bits_fp_val = io_ren_uops_1_bits_fp_val;
  assign io_dis_uops_0_2_valid = io_ren_uops_2_valid & io_ren_uops_2_bits_iq_type[1];
  assign io_dis_uops_0_2_bits_uopc = io_ren_uops_2_bits_uopc;
  assign io_dis_uops_0_2_bits_is_rvc = io_ren_uops_2_bits_is_rvc;
  assign io_dis_uops_0_2_bits_fu_code = io_ren_uops_2_bits_fu_code;
  assign io_dis_uops_0_2_bits_is_br = io_ren_uops_2_bits_is_br;
  assign io_dis_uops_0_2_bits_is_jalr = io_ren_uops_2_bits_is_jalr;
  assign io_dis_uops_0_2_bits_is_jal = io_ren_uops_2_bits_is_jal;
  assign io_dis_uops_0_2_bits_is_sfb = io_ren_uops_2_bits_is_sfb;
  assign io_dis_uops_0_2_bits_br_mask = io_ren_uops_2_bits_br_mask;
  assign io_dis_uops_0_2_bits_br_tag = io_ren_uops_2_bits_br_tag;
  assign io_dis_uops_0_2_bits_ftq_idx = io_ren_uops_2_bits_ftq_idx;
  assign io_dis_uops_0_2_bits_edge_inst = io_ren_uops_2_bits_edge_inst;
  assign io_dis_uops_0_2_bits_pc_lob = io_ren_uops_2_bits_pc_lob;
  assign io_dis_uops_0_2_bits_taken = io_ren_uops_2_bits_taken;
  assign io_dis_uops_0_2_bits_imm_packed = io_ren_uops_2_bits_imm_packed;
  assign io_dis_uops_0_2_bits_rob_idx = io_ren_uops_2_bits_rob_idx;
  assign io_dis_uops_0_2_bits_ldq_idx = io_ren_uops_2_bits_ldq_idx;
  assign io_dis_uops_0_2_bits_stq_idx = io_ren_uops_2_bits_stq_idx;
  assign io_dis_uops_0_2_bits_pdst = io_ren_uops_2_bits_pdst;
  assign io_dis_uops_0_2_bits_prs1 = io_ren_uops_2_bits_prs1;
  assign io_dis_uops_0_2_bits_prs2 = io_ren_uops_2_bits_prs2;
  assign io_dis_uops_0_2_bits_prs3 = io_ren_uops_2_bits_prs3;
  assign io_dis_uops_0_2_bits_prs1_busy = io_ren_uops_2_bits_prs1_busy;
  assign io_dis_uops_0_2_bits_prs2_busy = io_ren_uops_2_bits_prs2_busy;
  assign io_dis_uops_0_2_bits_exception = io_ren_uops_2_bits_exception;
  assign io_dis_uops_0_2_bits_bypassable = io_ren_uops_2_bits_bypassable;
  assign io_dis_uops_0_2_bits_mem_cmd = io_ren_uops_2_bits_mem_cmd;
  assign io_dis_uops_0_2_bits_mem_size = io_ren_uops_2_bits_mem_size;
  assign io_dis_uops_0_2_bits_mem_signed = io_ren_uops_2_bits_mem_signed;
  assign io_dis_uops_0_2_bits_is_fence = io_ren_uops_2_bits_is_fence;
  assign io_dis_uops_0_2_bits_is_fencei = io_ren_uops_2_bits_is_fencei;
  assign io_dis_uops_0_2_bits_is_amo = io_ren_uops_2_bits_is_amo;
  assign io_dis_uops_0_2_bits_uses_ldq = io_ren_uops_2_bits_uses_ldq;
  assign io_dis_uops_0_2_bits_uses_stq = io_ren_uops_2_bits_uses_stq;
  assign io_dis_uops_0_2_bits_ldst_val = io_ren_uops_2_bits_ldst_val;
  assign io_dis_uops_0_2_bits_dst_rtype = io_ren_uops_2_bits_dst_rtype;
  assign io_dis_uops_0_2_bits_lrs1_rtype = io_ren_uops_2_bits_lrs1_rtype;
  assign io_dis_uops_0_2_bits_lrs2_rtype = io_ren_uops_2_bits_lrs2_rtype;
  assign io_dis_uops_0_2_bits_fp_val = io_ren_uops_2_bits_fp_val;
  assign io_dis_uops_0_3_valid = io_ren_uops_3_valid & io_ren_uops_3_bits_iq_type[1];
  assign io_dis_uops_0_3_bits_uopc = io_ren_uops_3_bits_uopc;
  assign io_dis_uops_0_3_bits_is_rvc = io_ren_uops_3_bits_is_rvc;
  assign io_dis_uops_0_3_bits_fu_code = io_ren_uops_3_bits_fu_code;
  assign io_dis_uops_0_3_bits_is_br = io_ren_uops_3_bits_is_br;
  assign io_dis_uops_0_3_bits_is_jalr = io_ren_uops_3_bits_is_jalr;
  assign io_dis_uops_0_3_bits_is_jal = io_ren_uops_3_bits_is_jal;
  assign io_dis_uops_0_3_bits_is_sfb = io_ren_uops_3_bits_is_sfb;
  assign io_dis_uops_0_3_bits_br_mask = io_ren_uops_3_bits_br_mask;
  assign io_dis_uops_0_3_bits_br_tag = io_ren_uops_3_bits_br_tag;
  assign io_dis_uops_0_3_bits_ftq_idx = io_ren_uops_3_bits_ftq_idx;
  assign io_dis_uops_0_3_bits_edge_inst = io_ren_uops_3_bits_edge_inst;
  assign io_dis_uops_0_3_bits_pc_lob = io_ren_uops_3_bits_pc_lob;
  assign io_dis_uops_0_3_bits_taken = io_ren_uops_3_bits_taken;
  assign io_dis_uops_0_3_bits_imm_packed = io_ren_uops_3_bits_imm_packed;
  assign io_dis_uops_0_3_bits_rob_idx = io_ren_uops_3_bits_rob_idx;
  assign io_dis_uops_0_3_bits_ldq_idx = io_ren_uops_3_bits_ldq_idx;
  assign io_dis_uops_0_3_bits_stq_idx = io_ren_uops_3_bits_stq_idx;
  assign io_dis_uops_0_3_bits_pdst = io_ren_uops_3_bits_pdst;
  assign io_dis_uops_0_3_bits_prs1 = io_ren_uops_3_bits_prs1;
  assign io_dis_uops_0_3_bits_prs2 = io_ren_uops_3_bits_prs2;
  assign io_dis_uops_0_3_bits_prs3 = io_ren_uops_3_bits_prs3;
  assign io_dis_uops_0_3_bits_prs1_busy = io_ren_uops_3_bits_prs1_busy;
  assign io_dis_uops_0_3_bits_prs2_busy = io_ren_uops_3_bits_prs2_busy;
  assign io_dis_uops_0_3_bits_exception = io_ren_uops_3_bits_exception;
  assign io_dis_uops_0_3_bits_bypassable = io_ren_uops_3_bits_bypassable;
  assign io_dis_uops_0_3_bits_mem_cmd = io_ren_uops_3_bits_mem_cmd;
  assign io_dis_uops_0_3_bits_mem_size = io_ren_uops_3_bits_mem_size;
  assign io_dis_uops_0_3_bits_mem_signed = io_ren_uops_3_bits_mem_signed;
  assign io_dis_uops_0_3_bits_is_fence = io_ren_uops_3_bits_is_fence;
  assign io_dis_uops_0_3_bits_is_fencei = io_ren_uops_3_bits_is_fencei;
  assign io_dis_uops_0_3_bits_is_amo = io_ren_uops_3_bits_is_amo;
  assign io_dis_uops_0_3_bits_uses_ldq = io_ren_uops_3_bits_uses_ldq;
  assign io_dis_uops_0_3_bits_uses_stq = io_ren_uops_3_bits_uses_stq;
  assign io_dis_uops_0_3_bits_ldst_val = io_ren_uops_3_bits_ldst_val;
  assign io_dis_uops_0_3_bits_dst_rtype = io_ren_uops_3_bits_dst_rtype;
  assign io_dis_uops_0_3_bits_lrs1_rtype = io_ren_uops_3_bits_lrs1_rtype;
  assign io_dis_uops_0_3_bits_lrs2_rtype = io_ren_uops_3_bits_lrs2_rtype;
  assign io_dis_uops_0_3_bits_fp_val = io_ren_uops_3_bits_fp_val;
endmodule

