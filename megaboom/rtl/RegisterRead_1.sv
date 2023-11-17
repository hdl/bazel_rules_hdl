// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RegisterRead_1(
  input         clock,
                reset,
                io_iss_valids_0,
                io_iss_valids_1,
                io_iss_valids_2,
                io_iss_valids_3,
                io_iss_valids_4,
                io_iss_valids_5,
  input  [6:0]  io_iss_uops_0_uopc,
  input  [9:0]  io_iss_uops_0_fu_code,
  input  [19:0] io_iss_uops_0_br_mask,
                io_iss_uops_0_imm_packed,
  input  [6:0]  io_iss_uops_0_rob_idx,
  input  [4:0]  io_iss_uops_0_ldq_idx,
                io_iss_uops_0_stq_idx,
  input  [6:0]  io_iss_uops_0_pdst,
                io_iss_uops_0_prs1,
                io_iss_uops_0_prs2,
  input  [4:0]  io_iss_uops_0_mem_cmd,
  input  [1:0]  io_iss_uops_0_mem_size,
  input         io_iss_uops_0_mem_signed,
                io_iss_uops_0_is_fence,
                io_iss_uops_0_is_amo,
                io_iss_uops_0_uses_ldq,
                io_iss_uops_0_uses_stq,
  input  [1:0]  io_iss_uops_0_lrs1_rtype,
                io_iss_uops_0_lrs2_rtype,
  input         io_iss_uops_0_fp_val,
  input  [6:0]  io_iss_uops_1_uopc,
  input  [9:0]  io_iss_uops_1_fu_code,
  input  [19:0] io_iss_uops_1_br_mask,
                io_iss_uops_1_imm_packed,
  input  [6:0]  io_iss_uops_1_rob_idx,
  input  [4:0]  io_iss_uops_1_ldq_idx,
                io_iss_uops_1_stq_idx,
  input  [6:0]  io_iss_uops_1_pdst,
                io_iss_uops_1_prs1,
                io_iss_uops_1_prs2,
  input  [4:0]  io_iss_uops_1_mem_cmd,
  input  [1:0]  io_iss_uops_1_mem_size,
  input         io_iss_uops_1_mem_signed,
                io_iss_uops_1_is_fence,
                io_iss_uops_1_is_amo,
                io_iss_uops_1_uses_ldq,
                io_iss_uops_1_uses_stq,
  input  [1:0]  io_iss_uops_1_lrs1_rtype,
                io_iss_uops_1_lrs2_rtype,
  input         io_iss_uops_1_fp_val,
  input  [6:0]  io_iss_uops_2_uopc,
  input         io_iss_uops_2_is_rvc,
  input  [9:0]  io_iss_uops_2_fu_code,
  input         io_iss_uops_2_is_br,
                io_iss_uops_2_is_jalr,
                io_iss_uops_2_is_jal,
                io_iss_uops_2_is_sfb,
  input  [19:0] io_iss_uops_2_br_mask,
  input  [4:0]  io_iss_uops_2_br_tag,
  input  [5:0]  io_iss_uops_2_ftq_idx,
  input         io_iss_uops_2_edge_inst,
  input  [5:0]  io_iss_uops_2_pc_lob,
  input         io_iss_uops_2_taken,
  input  [19:0] io_iss_uops_2_imm_packed,
  input  [6:0]  io_iss_uops_2_rob_idx,
  input  [4:0]  io_iss_uops_2_ldq_idx,
                io_iss_uops_2_stq_idx,
  input  [6:0]  io_iss_uops_2_pdst,
                io_iss_uops_2_prs1,
                io_iss_uops_2_prs2,
  input         io_iss_uops_2_bypassable,
  input  [4:0]  io_iss_uops_2_mem_cmd,
  input         io_iss_uops_2_is_amo,
                io_iss_uops_2_uses_stq,
  input  [1:0]  io_iss_uops_2_dst_rtype,
                io_iss_uops_2_lrs1_rtype,
                io_iss_uops_2_lrs2_rtype,
  input         io_iss_uops_2_fp_val,
  input  [6:0]  io_iss_uops_3_uopc,
  input         io_iss_uops_3_is_rvc,
  input  [9:0]  io_iss_uops_3_fu_code,
  input         io_iss_uops_3_is_br,
                io_iss_uops_3_is_jalr,
                io_iss_uops_3_is_jal,
                io_iss_uops_3_is_sfb,
  input  [19:0] io_iss_uops_3_br_mask,
  input  [4:0]  io_iss_uops_3_br_tag,
  input  [5:0]  io_iss_uops_3_ftq_idx,
  input         io_iss_uops_3_edge_inst,
  input  [5:0]  io_iss_uops_3_pc_lob,
  input         io_iss_uops_3_taken,
  input  [19:0] io_iss_uops_3_imm_packed,
  input  [6:0]  io_iss_uops_3_rob_idx,
  input  [4:0]  io_iss_uops_3_ldq_idx,
                io_iss_uops_3_stq_idx,
  input  [6:0]  io_iss_uops_3_pdst,
                io_iss_uops_3_prs1,
                io_iss_uops_3_prs2,
  input         io_iss_uops_3_bypassable,
  input  [4:0]  io_iss_uops_3_mem_cmd,
  input         io_iss_uops_3_is_amo,
                io_iss_uops_3_uses_stq,
  input  [1:0]  io_iss_uops_3_dst_rtype,
                io_iss_uops_3_lrs1_rtype,
                io_iss_uops_3_lrs2_rtype,
  input  [6:0]  io_iss_uops_4_uopc,
  input         io_iss_uops_4_is_rvc,
  input  [9:0]  io_iss_uops_4_fu_code,
  input         io_iss_uops_4_is_br,
                io_iss_uops_4_is_jalr,
                io_iss_uops_4_is_jal,
                io_iss_uops_4_is_sfb,
  input  [19:0] io_iss_uops_4_br_mask,
  input  [4:0]  io_iss_uops_4_br_tag,
  input  [5:0]  io_iss_uops_4_ftq_idx,
  input         io_iss_uops_4_edge_inst,
  input  [5:0]  io_iss_uops_4_pc_lob,
  input         io_iss_uops_4_taken,
  input  [19:0] io_iss_uops_4_imm_packed,
  input  [6:0]  io_iss_uops_4_rob_idx,
  input  [4:0]  io_iss_uops_4_ldq_idx,
                io_iss_uops_4_stq_idx,
  input  [6:0]  io_iss_uops_4_pdst,
                io_iss_uops_4_prs1,
                io_iss_uops_4_prs2,
  input         io_iss_uops_4_bypassable,
  input  [4:0]  io_iss_uops_4_mem_cmd,
  input         io_iss_uops_4_is_amo,
                io_iss_uops_4_uses_stq,
  input  [1:0]  io_iss_uops_4_dst_rtype,
                io_iss_uops_4_lrs1_rtype,
                io_iss_uops_4_lrs2_rtype,
  input  [6:0]  io_iss_uops_5_uopc,
  input         io_iss_uops_5_is_rvc,
  input  [9:0]  io_iss_uops_5_fu_code,
  input         io_iss_uops_5_is_br,
                io_iss_uops_5_is_jalr,
                io_iss_uops_5_is_jal,
                io_iss_uops_5_is_sfb,
  input  [19:0] io_iss_uops_5_br_mask,
  input  [4:0]  io_iss_uops_5_br_tag,
  input  [5:0]  io_iss_uops_5_ftq_idx,
  input         io_iss_uops_5_edge_inst,
  input  [5:0]  io_iss_uops_5_pc_lob,
  input         io_iss_uops_5_taken,
  input  [19:0] io_iss_uops_5_imm_packed,
  input  [6:0]  io_iss_uops_5_rob_idx,
  input  [4:0]  io_iss_uops_5_ldq_idx,
                io_iss_uops_5_stq_idx,
  input  [6:0]  io_iss_uops_5_pdst,
                io_iss_uops_5_prs1,
                io_iss_uops_5_prs2,
  input         io_iss_uops_5_bypassable,
  input  [4:0]  io_iss_uops_5_mem_cmd,
  input         io_iss_uops_5_is_amo,
                io_iss_uops_5_uses_stq,
  input  [1:0]  io_iss_uops_5_dst_rtype,
                io_iss_uops_5_lrs1_rtype,
                io_iss_uops_5_lrs2_rtype,
  input  [63:0] io_rf_read_ports_0_data,
                io_rf_read_ports_1_data,
                io_rf_read_ports_2_data,
                io_rf_read_ports_3_data,
                io_rf_read_ports_4_data,
                io_rf_read_ports_5_data,
                io_rf_read_ports_6_data,
                io_rf_read_ports_7_data,
                io_rf_read_ports_8_data,
                io_rf_read_ports_9_data,
                io_rf_read_ports_10_data,
                io_rf_read_ports_11_data,
  input         io_bypass_0_valid,
  input  [6:0]  io_bypass_0_bits_uop_pdst,
  input  [1:0]  io_bypass_0_bits_uop_dst_rtype,
  input  [63:0] io_bypass_0_bits_data,
  input         io_bypass_1_valid,
  input  [6:0]  io_bypass_1_bits_uop_pdst,
  input  [1:0]  io_bypass_1_bits_uop_dst_rtype,
  input  [63:0] io_bypass_1_bits_data,
  input         io_bypass_2_valid,
  input  [6:0]  io_bypass_2_bits_uop_pdst,
  input  [1:0]  io_bypass_2_bits_uop_dst_rtype,
  input  [63:0] io_bypass_2_bits_data,
  input         io_bypass_3_valid,
  input  [6:0]  io_bypass_3_bits_uop_pdst,
  input  [1:0]  io_bypass_3_bits_uop_dst_rtype,
  input  [63:0] io_bypass_3_bits_data,
  input         io_bypass_4_valid,
  input  [6:0]  io_bypass_4_bits_uop_pdst,
  input  [1:0]  io_bypass_4_bits_uop_dst_rtype,
  input  [63:0] io_bypass_4_bits_data,
  input         io_bypass_5_valid,
  input  [6:0]  io_bypass_5_bits_uop_pdst,
  input  [1:0]  io_bypass_5_bits_uop_dst_rtype,
  input  [63:0] io_bypass_5_bits_data,
  input         io_kill,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  output [6:0]  io_rf_read_ports_0_addr,
                io_rf_read_ports_1_addr,
                io_rf_read_ports_2_addr,
                io_rf_read_ports_3_addr,
                io_rf_read_ports_4_addr,
                io_rf_read_ports_5_addr,
                io_rf_read_ports_6_addr,
                io_rf_read_ports_7_addr,
                io_rf_read_ports_8_addr,
                io_rf_read_ports_9_addr,
                io_rf_read_ports_10_addr,
                io_rf_read_ports_11_addr,
  output        io_exe_reqs_0_valid,
  output [6:0]  io_exe_reqs_0_bits_uop_uopc,
  output [9:0]  io_exe_reqs_0_bits_uop_fu_code,
  output        io_exe_reqs_0_bits_uop_ctrl_is_load,
                io_exe_reqs_0_bits_uop_ctrl_is_sta,
                io_exe_reqs_0_bits_uop_ctrl_is_std,
  output [19:0] io_exe_reqs_0_bits_uop_br_mask,
                io_exe_reqs_0_bits_uop_imm_packed,
  output [6:0]  io_exe_reqs_0_bits_uop_rob_idx,
  output [4:0]  io_exe_reqs_0_bits_uop_ldq_idx,
                io_exe_reqs_0_bits_uop_stq_idx,
  output [6:0]  io_exe_reqs_0_bits_uop_pdst,
  output [4:0]  io_exe_reqs_0_bits_uop_mem_cmd,
  output [1:0]  io_exe_reqs_0_bits_uop_mem_size,
  output        io_exe_reqs_0_bits_uop_mem_signed,
                io_exe_reqs_0_bits_uop_is_fence,
                io_exe_reqs_0_bits_uop_is_amo,
                io_exe_reqs_0_bits_uop_uses_ldq,
                io_exe_reqs_0_bits_uop_uses_stq,
                io_exe_reqs_0_bits_uop_fp_val,
  output [63:0] io_exe_reqs_0_bits_rs1_data,
                io_exe_reqs_0_bits_rs2_data,
  output        io_exe_reqs_1_valid,
  output [6:0]  io_exe_reqs_1_bits_uop_uopc,
  output [9:0]  io_exe_reqs_1_bits_uop_fu_code,
  output        io_exe_reqs_1_bits_uop_ctrl_is_load,
                io_exe_reqs_1_bits_uop_ctrl_is_sta,
                io_exe_reqs_1_bits_uop_ctrl_is_std,
  output [19:0] io_exe_reqs_1_bits_uop_br_mask,
                io_exe_reqs_1_bits_uop_imm_packed,
  output [6:0]  io_exe_reqs_1_bits_uop_rob_idx,
  output [4:0]  io_exe_reqs_1_bits_uop_ldq_idx,
                io_exe_reqs_1_bits_uop_stq_idx,
  output [6:0]  io_exe_reqs_1_bits_uop_pdst,
  output [4:0]  io_exe_reqs_1_bits_uop_mem_cmd,
  output [1:0]  io_exe_reqs_1_bits_uop_mem_size,
  output        io_exe_reqs_1_bits_uop_mem_signed,
                io_exe_reqs_1_bits_uop_is_fence,
                io_exe_reqs_1_bits_uop_is_amo,
                io_exe_reqs_1_bits_uop_uses_ldq,
                io_exe_reqs_1_bits_uop_uses_stq,
                io_exe_reqs_1_bits_uop_fp_val,
  output [63:0] io_exe_reqs_1_bits_rs1_data,
                io_exe_reqs_1_bits_rs2_data,
  output        io_exe_reqs_2_valid,
  output [6:0]  io_exe_reqs_2_bits_uop_uopc,
  output        io_exe_reqs_2_bits_uop_is_rvc,
  output [9:0]  io_exe_reqs_2_bits_uop_fu_code,
  output [3:0]  io_exe_reqs_2_bits_uop_ctrl_br_type,
  output [1:0]  io_exe_reqs_2_bits_uop_ctrl_op1_sel,
  output [2:0]  io_exe_reqs_2_bits_uop_ctrl_op2_sel,
                io_exe_reqs_2_bits_uop_ctrl_imm_sel,
  output [3:0]  io_exe_reqs_2_bits_uop_ctrl_op_fcn,
  output        io_exe_reqs_2_bits_uop_ctrl_fcn_dw,
                io_exe_reqs_2_bits_uop_is_br,
                io_exe_reqs_2_bits_uop_is_jalr,
                io_exe_reqs_2_bits_uop_is_jal,
                io_exe_reqs_2_bits_uop_is_sfb,
  output [19:0] io_exe_reqs_2_bits_uop_br_mask,
  output [4:0]  io_exe_reqs_2_bits_uop_br_tag,
  output [5:0]  io_exe_reqs_2_bits_uop_ftq_idx,
  output        io_exe_reqs_2_bits_uop_edge_inst,
  output [5:0]  io_exe_reqs_2_bits_uop_pc_lob,
  output        io_exe_reqs_2_bits_uop_taken,
  output [19:0] io_exe_reqs_2_bits_uop_imm_packed,
  output [6:0]  io_exe_reqs_2_bits_uop_rob_idx,
  output [4:0]  io_exe_reqs_2_bits_uop_ldq_idx,
                io_exe_reqs_2_bits_uop_stq_idx,
  output [6:0]  io_exe_reqs_2_bits_uop_pdst,
                io_exe_reqs_2_bits_uop_prs1,
  output        io_exe_reqs_2_bits_uop_bypassable,
                io_exe_reqs_2_bits_uop_is_amo,
                io_exe_reqs_2_bits_uop_uses_stq,
  output [1:0]  io_exe_reqs_2_bits_uop_dst_rtype,
  output        io_exe_reqs_2_bits_uop_fp_val,
  output [63:0] io_exe_reqs_2_bits_rs1_data,
                io_exe_reqs_2_bits_rs2_data,
  output        io_exe_reqs_3_valid,
  output [6:0]  io_exe_reqs_3_bits_uop_uopc,
  output        io_exe_reqs_3_bits_uop_is_rvc,
  output [9:0]  io_exe_reqs_3_bits_uop_fu_code,
  output [3:0]  io_exe_reqs_3_bits_uop_ctrl_br_type,
  output [1:0]  io_exe_reqs_3_bits_uop_ctrl_op1_sel,
  output [2:0]  io_exe_reqs_3_bits_uop_ctrl_op2_sel,
                io_exe_reqs_3_bits_uop_ctrl_imm_sel,
  output [3:0]  io_exe_reqs_3_bits_uop_ctrl_op_fcn,
  output        io_exe_reqs_3_bits_uop_ctrl_fcn_dw,
  output [2:0]  io_exe_reqs_3_bits_uop_ctrl_csr_cmd,
  output        io_exe_reqs_3_bits_uop_is_br,
                io_exe_reqs_3_bits_uop_is_jalr,
                io_exe_reqs_3_bits_uop_is_jal,
                io_exe_reqs_3_bits_uop_is_sfb,
  output [19:0] io_exe_reqs_3_bits_uop_br_mask,
  output [4:0]  io_exe_reqs_3_bits_uop_br_tag,
  output [5:0]  io_exe_reqs_3_bits_uop_ftq_idx,
  output        io_exe_reqs_3_bits_uop_edge_inst,
  output [5:0]  io_exe_reqs_3_bits_uop_pc_lob,
  output        io_exe_reqs_3_bits_uop_taken,
  output [19:0] io_exe_reqs_3_bits_uop_imm_packed,
  output [6:0]  io_exe_reqs_3_bits_uop_rob_idx,
  output [4:0]  io_exe_reqs_3_bits_uop_ldq_idx,
                io_exe_reqs_3_bits_uop_stq_idx,
  output [6:0]  io_exe_reqs_3_bits_uop_pdst,
                io_exe_reqs_3_bits_uop_prs1,
  output        io_exe_reqs_3_bits_uop_bypassable,
                io_exe_reqs_3_bits_uop_is_amo,
                io_exe_reqs_3_bits_uop_uses_stq,
  output [1:0]  io_exe_reqs_3_bits_uop_dst_rtype,
  output [63:0] io_exe_reqs_3_bits_rs1_data,
                io_exe_reqs_3_bits_rs2_data,
  output        io_exe_reqs_4_valid,
  output [6:0]  io_exe_reqs_4_bits_uop_uopc,
  output        io_exe_reqs_4_bits_uop_is_rvc,
  output [9:0]  io_exe_reqs_4_bits_uop_fu_code,
  output [3:0]  io_exe_reqs_4_bits_uop_ctrl_br_type,
  output [1:0]  io_exe_reqs_4_bits_uop_ctrl_op1_sel,
  output [2:0]  io_exe_reqs_4_bits_uop_ctrl_op2_sel,
                io_exe_reqs_4_bits_uop_ctrl_imm_sel,
  output [3:0]  io_exe_reqs_4_bits_uop_ctrl_op_fcn,
  output        io_exe_reqs_4_bits_uop_ctrl_fcn_dw,
                io_exe_reqs_4_bits_uop_is_br,
                io_exe_reqs_4_bits_uop_is_jalr,
                io_exe_reqs_4_bits_uop_is_jal,
                io_exe_reqs_4_bits_uop_is_sfb,
  output [19:0] io_exe_reqs_4_bits_uop_br_mask,
  output [4:0]  io_exe_reqs_4_bits_uop_br_tag,
  output [5:0]  io_exe_reqs_4_bits_uop_ftq_idx,
  output        io_exe_reqs_4_bits_uop_edge_inst,
  output [5:0]  io_exe_reqs_4_bits_uop_pc_lob,
  output        io_exe_reqs_4_bits_uop_taken,
  output [19:0] io_exe_reqs_4_bits_uop_imm_packed,
  output [6:0]  io_exe_reqs_4_bits_uop_rob_idx,
  output [4:0]  io_exe_reqs_4_bits_uop_ldq_idx,
                io_exe_reqs_4_bits_uop_stq_idx,
  output [6:0]  io_exe_reqs_4_bits_uop_pdst,
                io_exe_reqs_4_bits_uop_prs1,
  output        io_exe_reqs_4_bits_uop_bypassable,
                io_exe_reqs_4_bits_uop_is_amo,
                io_exe_reqs_4_bits_uop_uses_stq,
  output [1:0]  io_exe_reqs_4_bits_uop_dst_rtype,
  output [63:0] io_exe_reqs_4_bits_rs1_data,
                io_exe_reqs_4_bits_rs2_data,
  output        io_exe_reqs_5_valid,
  output [6:0]  io_exe_reqs_5_bits_uop_uopc,
  output        io_exe_reqs_5_bits_uop_is_rvc,
  output [9:0]  io_exe_reqs_5_bits_uop_fu_code,
  output [3:0]  io_exe_reqs_5_bits_uop_ctrl_br_type,
  output [1:0]  io_exe_reqs_5_bits_uop_ctrl_op1_sel,
  output [2:0]  io_exe_reqs_5_bits_uop_ctrl_op2_sel,
                io_exe_reqs_5_bits_uop_ctrl_imm_sel,
  output [3:0]  io_exe_reqs_5_bits_uop_ctrl_op_fcn,
  output        io_exe_reqs_5_bits_uop_ctrl_fcn_dw,
  output [2:0]  io_exe_reqs_5_bits_uop_ctrl_csr_cmd,
  output        io_exe_reqs_5_bits_uop_is_br,
                io_exe_reqs_5_bits_uop_is_jalr,
                io_exe_reqs_5_bits_uop_is_jal,
                io_exe_reqs_5_bits_uop_is_sfb,
  output [19:0] io_exe_reqs_5_bits_uop_br_mask,
  output [4:0]  io_exe_reqs_5_bits_uop_br_tag,
  output [5:0]  io_exe_reqs_5_bits_uop_ftq_idx,
  output        io_exe_reqs_5_bits_uop_edge_inst,
  output [5:0]  io_exe_reqs_5_bits_uop_pc_lob,
  output        io_exe_reqs_5_bits_uop_taken,
  output [19:0] io_exe_reqs_5_bits_uop_imm_packed,
  output [6:0]  io_exe_reqs_5_bits_uop_rob_idx,
  output [4:0]  io_exe_reqs_5_bits_uop_ldq_idx,
                io_exe_reqs_5_bits_uop_stq_idx,
  output [6:0]  io_exe_reqs_5_bits_uop_pdst,
                io_exe_reqs_5_bits_uop_prs1,
  output        io_exe_reqs_5_bits_uop_bypassable,
                io_exe_reqs_5_bits_uop_is_amo,
                io_exe_reqs_5_bits_uop_uses_stq,
  output [1:0]  io_exe_reqs_5_bits_uop_dst_rtype,
  output [63:0] io_exe_reqs_5_bits_rs1_data,
                io_exe_reqs_5_bits_rs2_data
);

  wire        _rrd_decode_unit_5_io_rrd_valid;
  wire [6:0]  _rrd_decode_unit_5_io_rrd_uop_uopc;
  wire        _rrd_decode_unit_5_io_rrd_uop_is_rvc;
  wire [9:0]  _rrd_decode_unit_5_io_rrd_uop_fu_code;
  wire [3:0]  _rrd_decode_unit_5_io_rrd_uop_ctrl_br_type;
  wire [1:0]  _rrd_decode_unit_5_io_rrd_uop_ctrl_op1_sel;
  wire [2:0]  _rrd_decode_unit_5_io_rrd_uop_ctrl_op2_sel;
  wire [2:0]  _rrd_decode_unit_5_io_rrd_uop_ctrl_imm_sel;
  wire [3:0]  _rrd_decode_unit_5_io_rrd_uop_ctrl_op_fcn;
  wire        _rrd_decode_unit_5_io_rrd_uop_ctrl_fcn_dw;
  wire [2:0]  _rrd_decode_unit_5_io_rrd_uop_ctrl_csr_cmd;
  wire        _rrd_decode_unit_5_io_rrd_uop_is_br;
  wire        _rrd_decode_unit_5_io_rrd_uop_is_jalr;
  wire        _rrd_decode_unit_5_io_rrd_uop_is_jal;
  wire        _rrd_decode_unit_5_io_rrd_uop_is_sfb;
  wire [19:0] _rrd_decode_unit_5_io_rrd_uop_br_mask;
  wire [4:0]  _rrd_decode_unit_5_io_rrd_uop_br_tag;
  wire [5:0]  _rrd_decode_unit_5_io_rrd_uop_ftq_idx;
  wire        _rrd_decode_unit_5_io_rrd_uop_edge_inst;
  wire [5:0]  _rrd_decode_unit_5_io_rrd_uop_pc_lob;
  wire        _rrd_decode_unit_5_io_rrd_uop_taken;
  wire [19:0] _rrd_decode_unit_5_io_rrd_uop_imm_packed;
  wire [6:0]  _rrd_decode_unit_5_io_rrd_uop_rob_idx;
  wire [4:0]  _rrd_decode_unit_5_io_rrd_uop_ldq_idx;
  wire [4:0]  _rrd_decode_unit_5_io_rrd_uop_stq_idx;
  wire [6:0]  _rrd_decode_unit_5_io_rrd_uop_pdst;
  wire [6:0]  _rrd_decode_unit_5_io_rrd_uop_prs1;
  wire [6:0]  _rrd_decode_unit_5_io_rrd_uop_prs2;
  wire        _rrd_decode_unit_5_io_rrd_uop_bypassable;
  wire        _rrd_decode_unit_5_io_rrd_uop_is_amo;
  wire        _rrd_decode_unit_5_io_rrd_uop_uses_stq;
  wire [1:0]  _rrd_decode_unit_5_io_rrd_uop_dst_rtype;
  wire [1:0]  _rrd_decode_unit_5_io_rrd_uop_lrs1_rtype;
  wire [1:0]  _rrd_decode_unit_5_io_rrd_uop_lrs2_rtype;
  wire        _rrd_decode_unit_4_io_rrd_valid;
  wire [6:0]  _rrd_decode_unit_4_io_rrd_uop_uopc;
  wire        _rrd_decode_unit_4_io_rrd_uop_is_rvc;
  wire [9:0]  _rrd_decode_unit_4_io_rrd_uop_fu_code;
  wire [3:0]  _rrd_decode_unit_4_io_rrd_uop_ctrl_br_type;
  wire [1:0]  _rrd_decode_unit_4_io_rrd_uop_ctrl_op1_sel;
  wire [2:0]  _rrd_decode_unit_4_io_rrd_uop_ctrl_op2_sel;
  wire [2:0]  _rrd_decode_unit_4_io_rrd_uop_ctrl_imm_sel;
  wire [3:0]  _rrd_decode_unit_4_io_rrd_uop_ctrl_op_fcn;
  wire        _rrd_decode_unit_4_io_rrd_uop_ctrl_fcn_dw;
  wire        _rrd_decode_unit_4_io_rrd_uop_is_br;
  wire        _rrd_decode_unit_4_io_rrd_uop_is_jalr;
  wire        _rrd_decode_unit_4_io_rrd_uop_is_jal;
  wire        _rrd_decode_unit_4_io_rrd_uop_is_sfb;
  wire [19:0] _rrd_decode_unit_4_io_rrd_uop_br_mask;
  wire [4:0]  _rrd_decode_unit_4_io_rrd_uop_br_tag;
  wire [5:0]  _rrd_decode_unit_4_io_rrd_uop_ftq_idx;
  wire        _rrd_decode_unit_4_io_rrd_uop_edge_inst;
  wire [5:0]  _rrd_decode_unit_4_io_rrd_uop_pc_lob;
  wire        _rrd_decode_unit_4_io_rrd_uop_taken;
  wire [19:0] _rrd_decode_unit_4_io_rrd_uop_imm_packed;
  wire [6:0]  _rrd_decode_unit_4_io_rrd_uop_rob_idx;
  wire [4:0]  _rrd_decode_unit_4_io_rrd_uop_ldq_idx;
  wire [4:0]  _rrd_decode_unit_4_io_rrd_uop_stq_idx;
  wire [6:0]  _rrd_decode_unit_4_io_rrd_uop_pdst;
  wire [6:0]  _rrd_decode_unit_4_io_rrd_uop_prs1;
  wire [6:0]  _rrd_decode_unit_4_io_rrd_uop_prs2;
  wire        _rrd_decode_unit_4_io_rrd_uop_bypassable;
  wire        _rrd_decode_unit_4_io_rrd_uop_is_amo;
  wire        _rrd_decode_unit_4_io_rrd_uop_uses_stq;
  wire [1:0]  _rrd_decode_unit_4_io_rrd_uop_dst_rtype;
  wire [1:0]  _rrd_decode_unit_4_io_rrd_uop_lrs1_rtype;
  wire [1:0]  _rrd_decode_unit_4_io_rrd_uop_lrs2_rtype;
  wire        _rrd_decode_unit_3_io_rrd_valid;
  wire [6:0]  _rrd_decode_unit_3_io_rrd_uop_uopc;
  wire        _rrd_decode_unit_3_io_rrd_uop_is_rvc;
  wire [9:0]  _rrd_decode_unit_3_io_rrd_uop_fu_code;
  wire [3:0]  _rrd_decode_unit_3_io_rrd_uop_ctrl_br_type;
  wire [1:0]  _rrd_decode_unit_3_io_rrd_uop_ctrl_op1_sel;
  wire [2:0]  _rrd_decode_unit_3_io_rrd_uop_ctrl_op2_sel;
  wire [2:0]  _rrd_decode_unit_3_io_rrd_uop_ctrl_imm_sel;
  wire [3:0]  _rrd_decode_unit_3_io_rrd_uop_ctrl_op_fcn;
  wire        _rrd_decode_unit_3_io_rrd_uop_ctrl_fcn_dw;
  wire [2:0]  _rrd_decode_unit_3_io_rrd_uop_ctrl_csr_cmd;
  wire        _rrd_decode_unit_3_io_rrd_uop_is_br;
  wire        _rrd_decode_unit_3_io_rrd_uop_is_jalr;
  wire        _rrd_decode_unit_3_io_rrd_uop_is_jal;
  wire        _rrd_decode_unit_3_io_rrd_uop_is_sfb;
  wire [19:0] _rrd_decode_unit_3_io_rrd_uop_br_mask;
  wire [4:0]  _rrd_decode_unit_3_io_rrd_uop_br_tag;
  wire [5:0]  _rrd_decode_unit_3_io_rrd_uop_ftq_idx;
  wire        _rrd_decode_unit_3_io_rrd_uop_edge_inst;
  wire [5:0]  _rrd_decode_unit_3_io_rrd_uop_pc_lob;
  wire        _rrd_decode_unit_3_io_rrd_uop_taken;
  wire [19:0] _rrd_decode_unit_3_io_rrd_uop_imm_packed;
  wire [6:0]  _rrd_decode_unit_3_io_rrd_uop_rob_idx;
  wire [4:0]  _rrd_decode_unit_3_io_rrd_uop_ldq_idx;
  wire [4:0]  _rrd_decode_unit_3_io_rrd_uop_stq_idx;
  wire [6:0]  _rrd_decode_unit_3_io_rrd_uop_pdst;
  wire [6:0]  _rrd_decode_unit_3_io_rrd_uop_prs1;
  wire [6:0]  _rrd_decode_unit_3_io_rrd_uop_prs2;
  wire        _rrd_decode_unit_3_io_rrd_uop_bypassable;
  wire        _rrd_decode_unit_3_io_rrd_uop_is_amo;
  wire        _rrd_decode_unit_3_io_rrd_uop_uses_stq;
  wire [1:0]  _rrd_decode_unit_3_io_rrd_uop_dst_rtype;
  wire [1:0]  _rrd_decode_unit_3_io_rrd_uop_lrs1_rtype;
  wire [1:0]  _rrd_decode_unit_3_io_rrd_uop_lrs2_rtype;
  wire        _rrd_decode_unit_2_io_rrd_valid;
  wire [6:0]  _rrd_decode_unit_2_io_rrd_uop_uopc;
  wire        _rrd_decode_unit_2_io_rrd_uop_is_rvc;
  wire [9:0]  _rrd_decode_unit_2_io_rrd_uop_fu_code;
  wire [3:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_br_type;
  wire [1:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_op1_sel;
  wire [2:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_op2_sel;
  wire [2:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_imm_sel;
  wire [3:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_op_fcn;
  wire        _rrd_decode_unit_2_io_rrd_uop_ctrl_fcn_dw;
  wire        _rrd_decode_unit_2_io_rrd_uop_is_br;
  wire        _rrd_decode_unit_2_io_rrd_uop_is_jalr;
  wire        _rrd_decode_unit_2_io_rrd_uop_is_jal;
  wire        _rrd_decode_unit_2_io_rrd_uop_is_sfb;
  wire [19:0] _rrd_decode_unit_2_io_rrd_uop_br_mask;
  wire [4:0]  _rrd_decode_unit_2_io_rrd_uop_br_tag;
  wire [5:0]  _rrd_decode_unit_2_io_rrd_uop_ftq_idx;
  wire        _rrd_decode_unit_2_io_rrd_uop_edge_inst;
  wire [5:0]  _rrd_decode_unit_2_io_rrd_uop_pc_lob;
  wire        _rrd_decode_unit_2_io_rrd_uop_taken;
  wire [19:0] _rrd_decode_unit_2_io_rrd_uop_imm_packed;
  wire [6:0]  _rrd_decode_unit_2_io_rrd_uop_rob_idx;
  wire [4:0]  _rrd_decode_unit_2_io_rrd_uop_ldq_idx;
  wire [4:0]  _rrd_decode_unit_2_io_rrd_uop_stq_idx;
  wire [6:0]  _rrd_decode_unit_2_io_rrd_uop_pdst;
  wire [6:0]  _rrd_decode_unit_2_io_rrd_uop_prs1;
  wire [6:0]  _rrd_decode_unit_2_io_rrd_uop_prs2;
  wire        _rrd_decode_unit_2_io_rrd_uop_bypassable;
  wire        _rrd_decode_unit_2_io_rrd_uop_is_amo;
  wire        _rrd_decode_unit_2_io_rrd_uop_uses_stq;
  wire [1:0]  _rrd_decode_unit_2_io_rrd_uop_dst_rtype;
  wire [1:0]  _rrd_decode_unit_2_io_rrd_uop_lrs1_rtype;
  wire [1:0]  _rrd_decode_unit_2_io_rrd_uop_lrs2_rtype;
  wire        _rrd_decode_unit_2_io_rrd_uop_fp_val;
  wire        _rrd_decode_unit_1_io_rrd_valid;
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_uopc;
  wire [9:0]  _rrd_decode_unit_1_io_rrd_uop_fu_code;
  wire        _rrd_decode_unit_1_io_rrd_uop_ctrl_is_load;
  wire        _rrd_decode_unit_1_io_rrd_uop_ctrl_is_sta;
  wire        _rrd_decode_unit_1_io_rrd_uop_ctrl_is_std;
  wire [19:0] _rrd_decode_unit_1_io_rrd_uop_br_mask;
  wire [19:0] _rrd_decode_unit_1_io_rrd_uop_imm_packed;
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_rob_idx;
  wire [4:0]  _rrd_decode_unit_1_io_rrd_uop_ldq_idx;
  wire [4:0]  _rrd_decode_unit_1_io_rrd_uop_stq_idx;
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_pdst;
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_prs1;
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_prs2;
  wire [4:0]  _rrd_decode_unit_1_io_rrd_uop_mem_cmd;
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_mem_size;
  wire        _rrd_decode_unit_1_io_rrd_uop_mem_signed;
  wire        _rrd_decode_unit_1_io_rrd_uop_is_fence;
  wire        _rrd_decode_unit_1_io_rrd_uop_is_amo;
  wire        _rrd_decode_unit_1_io_rrd_uop_uses_ldq;
  wire        _rrd_decode_unit_1_io_rrd_uop_uses_stq;
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_lrs1_rtype;
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_lrs2_rtype;
  wire        _rrd_decode_unit_1_io_rrd_uop_fp_val;
  wire        _rrd_decode_unit_io_rrd_valid;
  wire [6:0]  _rrd_decode_unit_io_rrd_uop_uopc;
  wire [9:0]  _rrd_decode_unit_io_rrd_uop_fu_code;
  wire        _rrd_decode_unit_io_rrd_uop_ctrl_is_load;
  wire        _rrd_decode_unit_io_rrd_uop_ctrl_is_sta;
  wire        _rrd_decode_unit_io_rrd_uop_ctrl_is_std;
  wire [19:0] _rrd_decode_unit_io_rrd_uop_br_mask;
  wire [19:0] _rrd_decode_unit_io_rrd_uop_imm_packed;
  wire [6:0]  _rrd_decode_unit_io_rrd_uop_rob_idx;
  wire [4:0]  _rrd_decode_unit_io_rrd_uop_ldq_idx;
  wire [4:0]  _rrd_decode_unit_io_rrd_uop_stq_idx;
  wire [6:0]  _rrd_decode_unit_io_rrd_uop_pdst;
  wire [6:0]  _rrd_decode_unit_io_rrd_uop_prs1;
  wire [6:0]  _rrd_decode_unit_io_rrd_uop_prs2;
  wire [4:0]  _rrd_decode_unit_io_rrd_uop_mem_cmd;
  wire [1:0]  _rrd_decode_unit_io_rrd_uop_mem_size;
  wire        _rrd_decode_unit_io_rrd_uop_mem_signed;
  wire        _rrd_decode_unit_io_rrd_uop_is_fence;
  wire        _rrd_decode_unit_io_rrd_uop_is_amo;
  wire        _rrd_decode_unit_io_rrd_uop_uses_ldq;
  wire        _rrd_decode_unit_io_rrd_uop_uses_stq;
  wire [1:0]  _rrd_decode_unit_io_rrd_uop_lrs1_rtype;
  wire [1:0]  _rrd_decode_unit_io_rrd_uop_lrs2_rtype;
  wire        _rrd_decode_unit_io_rrd_uop_fp_val;
  reg         exe_reg_valids_0;
  reg         exe_reg_valids_1;
  reg         exe_reg_valids_2;
  reg         exe_reg_valids_3;
  reg         exe_reg_valids_4;
  reg         exe_reg_valids_5;
  reg  [6:0]  exe_reg_uops_0_uopc;
  reg  [9:0]  exe_reg_uops_0_fu_code;
  reg         exe_reg_uops_0_ctrl_is_load;
  reg         exe_reg_uops_0_ctrl_is_sta;
  reg         exe_reg_uops_0_ctrl_is_std;
  reg  [19:0] exe_reg_uops_0_br_mask;
  reg  [19:0] exe_reg_uops_0_imm_packed;
  reg  [6:0]  exe_reg_uops_0_rob_idx;
  reg  [4:0]  exe_reg_uops_0_ldq_idx;
  reg  [4:0]  exe_reg_uops_0_stq_idx;
  reg  [6:0]  exe_reg_uops_0_pdst;
  reg  [4:0]  exe_reg_uops_0_mem_cmd;
  reg  [1:0]  exe_reg_uops_0_mem_size;
  reg         exe_reg_uops_0_mem_signed;
  reg         exe_reg_uops_0_is_fence;
  reg         exe_reg_uops_0_is_amo;
  reg         exe_reg_uops_0_uses_ldq;
  reg         exe_reg_uops_0_uses_stq;
  reg         exe_reg_uops_0_fp_val;
  reg  [6:0]  exe_reg_uops_1_uopc;
  reg  [9:0]  exe_reg_uops_1_fu_code;
  reg         exe_reg_uops_1_ctrl_is_load;
  reg         exe_reg_uops_1_ctrl_is_sta;
  reg         exe_reg_uops_1_ctrl_is_std;
  reg  [19:0] exe_reg_uops_1_br_mask;
  reg  [19:0] exe_reg_uops_1_imm_packed;
  reg  [6:0]  exe_reg_uops_1_rob_idx;
  reg  [4:0]  exe_reg_uops_1_ldq_idx;
  reg  [4:0]  exe_reg_uops_1_stq_idx;
  reg  [6:0]  exe_reg_uops_1_pdst;
  reg  [4:0]  exe_reg_uops_1_mem_cmd;
  reg  [1:0]  exe_reg_uops_1_mem_size;
  reg         exe_reg_uops_1_mem_signed;
  reg         exe_reg_uops_1_is_fence;
  reg         exe_reg_uops_1_is_amo;
  reg         exe_reg_uops_1_uses_ldq;
  reg         exe_reg_uops_1_uses_stq;
  reg         exe_reg_uops_1_fp_val;
  reg  [6:0]  exe_reg_uops_2_uopc;
  reg         exe_reg_uops_2_is_rvc;
  reg  [9:0]  exe_reg_uops_2_fu_code;
  reg  [3:0]  exe_reg_uops_2_ctrl_br_type;
  reg  [1:0]  exe_reg_uops_2_ctrl_op1_sel;
  reg  [2:0]  exe_reg_uops_2_ctrl_op2_sel;
  reg  [2:0]  exe_reg_uops_2_ctrl_imm_sel;
  reg  [3:0]  exe_reg_uops_2_ctrl_op_fcn;
  reg         exe_reg_uops_2_ctrl_fcn_dw;
  reg         exe_reg_uops_2_is_br;
  reg         exe_reg_uops_2_is_jalr;
  reg         exe_reg_uops_2_is_jal;
  reg         exe_reg_uops_2_is_sfb;
  reg  [19:0] exe_reg_uops_2_br_mask;
  reg  [4:0]  exe_reg_uops_2_br_tag;
  reg  [5:0]  exe_reg_uops_2_ftq_idx;
  reg         exe_reg_uops_2_edge_inst;
  reg  [5:0]  exe_reg_uops_2_pc_lob;
  reg         exe_reg_uops_2_taken;
  reg  [19:0] exe_reg_uops_2_imm_packed;
  reg  [6:0]  exe_reg_uops_2_rob_idx;
  reg  [4:0]  exe_reg_uops_2_ldq_idx;
  reg  [4:0]  exe_reg_uops_2_stq_idx;
  reg  [6:0]  exe_reg_uops_2_pdst;
  reg  [6:0]  exe_reg_uops_2_prs1;
  reg         exe_reg_uops_2_bypassable;
  reg         exe_reg_uops_2_is_amo;
  reg         exe_reg_uops_2_uses_stq;
  reg  [1:0]  exe_reg_uops_2_dst_rtype;
  reg         exe_reg_uops_2_fp_val;
  reg  [6:0]  exe_reg_uops_3_uopc;
  reg         exe_reg_uops_3_is_rvc;
  reg  [9:0]  exe_reg_uops_3_fu_code;
  reg  [3:0]  exe_reg_uops_3_ctrl_br_type;
  reg  [1:0]  exe_reg_uops_3_ctrl_op1_sel;
  reg  [2:0]  exe_reg_uops_3_ctrl_op2_sel;
  reg  [2:0]  exe_reg_uops_3_ctrl_imm_sel;
  reg  [3:0]  exe_reg_uops_3_ctrl_op_fcn;
  reg         exe_reg_uops_3_ctrl_fcn_dw;
  reg  [2:0]  exe_reg_uops_3_ctrl_csr_cmd;
  reg         exe_reg_uops_3_is_br;
  reg         exe_reg_uops_3_is_jalr;
  reg         exe_reg_uops_3_is_jal;
  reg         exe_reg_uops_3_is_sfb;
  reg  [19:0] exe_reg_uops_3_br_mask;
  reg  [4:0]  exe_reg_uops_3_br_tag;
  reg  [5:0]  exe_reg_uops_3_ftq_idx;
  reg         exe_reg_uops_3_edge_inst;
  reg  [5:0]  exe_reg_uops_3_pc_lob;
  reg         exe_reg_uops_3_taken;
  reg  [19:0] exe_reg_uops_3_imm_packed;
  reg  [6:0]  exe_reg_uops_3_rob_idx;
  reg  [4:0]  exe_reg_uops_3_ldq_idx;
  reg  [4:0]  exe_reg_uops_3_stq_idx;
  reg  [6:0]  exe_reg_uops_3_pdst;
  reg  [6:0]  exe_reg_uops_3_prs1;
  reg         exe_reg_uops_3_bypassable;
  reg         exe_reg_uops_3_is_amo;
  reg         exe_reg_uops_3_uses_stq;
  reg  [1:0]  exe_reg_uops_3_dst_rtype;
  reg  [6:0]  exe_reg_uops_4_uopc;
  reg         exe_reg_uops_4_is_rvc;
  reg  [9:0]  exe_reg_uops_4_fu_code;
  reg  [3:0]  exe_reg_uops_4_ctrl_br_type;
  reg  [1:0]  exe_reg_uops_4_ctrl_op1_sel;
  reg  [2:0]  exe_reg_uops_4_ctrl_op2_sel;
  reg  [2:0]  exe_reg_uops_4_ctrl_imm_sel;
  reg  [3:0]  exe_reg_uops_4_ctrl_op_fcn;
  reg         exe_reg_uops_4_ctrl_fcn_dw;
  reg         exe_reg_uops_4_is_br;
  reg         exe_reg_uops_4_is_jalr;
  reg         exe_reg_uops_4_is_jal;
  reg         exe_reg_uops_4_is_sfb;
  reg  [19:0] exe_reg_uops_4_br_mask;
  reg  [4:0]  exe_reg_uops_4_br_tag;
  reg  [5:0]  exe_reg_uops_4_ftq_idx;
  reg         exe_reg_uops_4_edge_inst;
  reg  [5:0]  exe_reg_uops_4_pc_lob;
  reg         exe_reg_uops_4_taken;
  reg  [19:0] exe_reg_uops_4_imm_packed;
  reg  [6:0]  exe_reg_uops_4_rob_idx;
  reg  [4:0]  exe_reg_uops_4_ldq_idx;
  reg  [4:0]  exe_reg_uops_4_stq_idx;
  reg  [6:0]  exe_reg_uops_4_pdst;
  reg  [6:0]  exe_reg_uops_4_prs1;
  reg         exe_reg_uops_4_bypassable;
  reg         exe_reg_uops_4_is_amo;
  reg         exe_reg_uops_4_uses_stq;
  reg  [1:0]  exe_reg_uops_4_dst_rtype;
  reg  [6:0]  exe_reg_uops_5_uopc;
  reg         exe_reg_uops_5_is_rvc;
  reg  [9:0]  exe_reg_uops_5_fu_code;
  reg  [3:0]  exe_reg_uops_5_ctrl_br_type;
  reg  [1:0]  exe_reg_uops_5_ctrl_op1_sel;
  reg  [2:0]  exe_reg_uops_5_ctrl_op2_sel;
  reg  [2:0]  exe_reg_uops_5_ctrl_imm_sel;
  reg  [3:0]  exe_reg_uops_5_ctrl_op_fcn;
  reg         exe_reg_uops_5_ctrl_fcn_dw;
  reg  [2:0]  exe_reg_uops_5_ctrl_csr_cmd;
  reg         exe_reg_uops_5_is_br;
  reg         exe_reg_uops_5_is_jalr;
  reg         exe_reg_uops_5_is_jal;
  reg         exe_reg_uops_5_is_sfb;
  reg  [19:0] exe_reg_uops_5_br_mask;
  reg  [4:0]  exe_reg_uops_5_br_tag;
  reg  [5:0]  exe_reg_uops_5_ftq_idx;
  reg         exe_reg_uops_5_edge_inst;
  reg  [5:0]  exe_reg_uops_5_pc_lob;
  reg         exe_reg_uops_5_taken;
  reg  [19:0] exe_reg_uops_5_imm_packed;
  reg  [6:0]  exe_reg_uops_5_rob_idx;
  reg  [4:0]  exe_reg_uops_5_ldq_idx;
  reg  [4:0]  exe_reg_uops_5_stq_idx;
  reg  [6:0]  exe_reg_uops_5_pdst;
  reg  [6:0]  exe_reg_uops_5_prs1;
  reg         exe_reg_uops_5_bypassable;
  reg         exe_reg_uops_5_is_amo;
  reg         exe_reg_uops_5_uses_stq;
  reg  [1:0]  exe_reg_uops_5_dst_rtype;
  reg  [63:0] exe_reg_rs1_data_0;
  reg  [63:0] exe_reg_rs1_data_1;
  reg  [63:0] exe_reg_rs1_data_2;
  reg  [63:0] exe_reg_rs1_data_3;
  reg  [63:0] exe_reg_rs1_data_4;
  reg  [63:0] exe_reg_rs1_data_5;
  reg  [63:0] exe_reg_rs2_data_0;
  reg  [63:0] exe_reg_rs2_data_1;
  reg  [63:0] exe_reg_rs2_data_2;
  reg  [63:0] exe_reg_rs2_data_3;
  reg  [63:0] exe_reg_rs2_data_4;
  reg  [63:0] exe_reg_rs2_data_5;
  reg         rrd_valids_0;
  reg  [6:0]  rrd_uops_0_uopc;
  reg  [9:0]  rrd_uops_0_fu_code;
  reg         rrd_uops_0_ctrl_is_load;
  reg         rrd_uops_0_ctrl_is_sta;
  reg         rrd_uops_0_ctrl_is_std;
  reg  [19:0] rrd_uops_0_br_mask;
  reg  [19:0] rrd_uops_0_imm_packed;
  reg  [6:0]  rrd_uops_0_rob_idx;
  reg  [4:0]  rrd_uops_0_ldq_idx;
  reg  [4:0]  rrd_uops_0_stq_idx;
  reg  [6:0]  rrd_uops_0_pdst;
  reg  [6:0]  rrd_uops_0_prs1;
  reg  [6:0]  rrd_uops_0_prs2;
  reg  [4:0]  rrd_uops_0_mem_cmd;
  reg  [1:0]  rrd_uops_0_mem_size;
  reg         rrd_uops_0_mem_signed;
  reg         rrd_uops_0_is_fence;
  reg         rrd_uops_0_is_amo;
  reg         rrd_uops_0_uses_ldq;
  reg         rrd_uops_0_uses_stq;
  reg  [1:0]  rrd_uops_0_lrs1_rtype;
  reg  [1:0]  rrd_uops_0_lrs2_rtype;
  reg         rrd_uops_0_fp_val;
  reg         rrd_valids_1;
  reg  [6:0]  rrd_uops_1_uopc;
  reg  [9:0]  rrd_uops_1_fu_code;
  reg         rrd_uops_1_ctrl_is_load;
  reg         rrd_uops_1_ctrl_is_sta;
  reg         rrd_uops_1_ctrl_is_std;
  reg  [19:0] rrd_uops_1_br_mask;
  reg  [19:0] rrd_uops_1_imm_packed;
  reg  [6:0]  rrd_uops_1_rob_idx;
  reg  [4:0]  rrd_uops_1_ldq_idx;
  reg  [4:0]  rrd_uops_1_stq_idx;
  reg  [6:0]  rrd_uops_1_pdst;
  reg  [6:0]  rrd_uops_1_prs1;
  reg  [6:0]  rrd_uops_1_prs2;
  reg  [4:0]  rrd_uops_1_mem_cmd;
  reg  [1:0]  rrd_uops_1_mem_size;
  reg         rrd_uops_1_mem_signed;
  reg         rrd_uops_1_is_fence;
  reg         rrd_uops_1_is_amo;
  reg         rrd_uops_1_uses_ldq;
  reg         rrd_uops_1_uses_stq;
  reg  [1:0]  rrd_uops_1_lrs1_rtype;
  reg  [1:0]  rrd_uops_1_lrs2_rtype;
  reg         rrd_uops_1_fp_val;
  reg         rrd_valids_2;
  reg  [6:0]  rrd_uops_2_uopc;
  reg         rrd_uops_2_is_rvc;
  reg  [9:0]  rrd_uops_2_fu_code;
  reg  [3:0]  rrd_uops_2_ctrl_br_type;
  reg  [1:0]  rrd_uops_2_ctrl_op1_sel;
  reg  [2:0]  rrd_uops_2_ctrl_op2_sel;
  reg  [2:0]  rrd_uops_2_ctrl_imm_sel;
  reg  [3:0]  rrd_uops_2_ctrl_op_fcn;
  reg         rrd_uops_2_ctrl_fcn_dw;
  reg         rrd_uops_2_is_br;
  reg         rrd_uops_2_is_jalr;
  reg         rrd_uops_2_is_jal;
  reg         rrd_uops_2_is_sfb;
  reg  [19:0] rrd_uops_2_br_mask;
  reg  [4:0]  rrd_uops_2_br_tag;
  reg  [5:0]  rrd_uops_2_ftq_idx;
  reg         rrd_uops_2_edge_inst;
  reg  [5:0]  rrd_uops_2_pc_lob;
  reg         rrd_uops_2_taken;
  reg  [19:0] rrd_uops_2_imm_packed;
  reg  [6:0]  rrd_uops_2_rob_idx;
  reg  [4:0]  rrd_uops_2_ldq_idx;
  reg  [4:0]  rrd_uops_2_stq_idx;
  reg  [6:0]  rrd_uops_2_pdst;
  reg  [6:0]  rrd_uops_2_prs1;
  reg  [6:0]  rrd_uops_2_prs2;
  reg         rrd_uops_2_bypassable;
  reg         rrd_uops_2_is_amo;
  reg         rrd_uops_2_uses_stq;
  reg  [1:0]  rrd_uops_2_dst_rtype;
  reg  [1:0]  rrd_uops_2_lrs1_rtype;
  reg  [1:0]  rrd_uops_2_lrs2_rtype;
  reg         rrd_uops_2_fp_val;
  reg         rrd_valids_3;
  reg  [6:0]  rrd_uops_3_uopc;
  reg         rrd_uops_3_is_rvc;
  reg  [9:0]  rrd_uops_3_fu_code;
  reg  [3:0]  rrd_uops_3_ctrl_br_type;
  reg  [1:0]  rrd_uops_3_ctrl_op1_sel;
  reg  [2:0]  rrd_uops_3_ctrl_op2_sel;
  reg  [2:0]  rrd_uops_3_ctrl_imm_sel;
  reg  [3:0]  rrd_uops_3_ctrl_op_fcn;
  reg         rrd_uops_3_ctrl_fcn_dw;
  reg  [2:0]  rrd_uops_3_ctrl_csr_cmd;
  reg         rrd_uops_3_is_br;
  reg         rrd_uops_3_is_jalr;
  reg         rrd_uops_3_is_jal;
  reg         rrd_uops_3_is_sfb;
  reg  [19:0] rrd_uops_3_br_mask;
  reg  [4:0]  rrd_uops_3_br_tag;
  reg  [5:0]  rrd_uops_3_ftq_idx;
  reg         rrd_uops_3_edge_inst;
  reg  [5:0]  rrd_uops_3_pc_lob;
  reg         rrd_uops_3_taken;
  reg  [19:0] rrd_uops_3_imm_packed;
  reg  [6:0]  rrd_uops_3_rob_idx;
  reg  [4:0]  rrd_uops_3_ldq_idx;
  reg  [4:0]  rrd_uops_3_stq_idx;
  reg  [6:0]  rrd_uops_3_pdst;
  reg  [6:0]  rrd_uops_3_prs1;
  reg  [6:0]  rrd_uops_3_prs2;
  reg         rrd_uops_3_bypassable;
  reg         rrd_uops_3_is_amo;
  reg         rrd_uops_3_uses_stq;
  reg  [1:0]  rrd_uops_3_dst_rtype;
  reg  [1:0]  rrd_uops_3_lrs1_rtype;
  reg  [1:0]  rrd_uops_3_lrs2_rtype;
  reg         rrd_valids_4;
  reg  [6:0]  rrd_uops_4_uopc;
  reg         rrd_uops_4_is_rvc;
  reg  [9:0]  rrd_uops_4_fu_code;
  reg  [3:0]  rrd_uops_4_ctrl_br_type;
  reg  [1:0]  rrd_uops_4_ctrl_op1_sel;
  reg  [2:0]  rrd_uops_4_ctrl_op2_sel;
  reg  [2:0]  rrd_uops_4_ctrl_imm_sel;
  reg  [3:0]  rrd_uops_4_ctrl_op_fcn;
  reg         rrd_uops_4_ctrl_fcn_dw;
  reg         rrd_uops_4_is_br;
  reg         rrd_uops_4_is_jalr;
  reg         rrd_uops_4_is_jal;
  reg         rrd_uops_4_is_sfb;
  reg  [19:0] rrd_uops_4_br_mask;
  reg  [4:0]  rrd_uops_4_br_tag;
  reg  [5:0]  rrd_uops_4_ftq_idx;
  reg         rrd_uops_4_edge_inst;
  reg  [5:0]  rrd_uops_4_pc_lob;
  reg         rrd_uops_4_taken;
  reg  [19:0] rrd_uops_4_imm_packed;
  reg  [6:0]  rrd_uops_4_rob_idx;
  reg  [4:0]  rrd_uops_4_ldq_idx;
  reg  [4:0]  rrd_uops_4_stq_idx;
  reg  [6:0]  rrd_uops_4_pdst;
  reg  [6:0]  rrd_uops_4_prs1;
  reg  [6:0]  rrd_uops_4_prs2;
  reg         rrd_uops_4_bypassable;
  reg         rrd_uops_4_is_amo;
  reg         rrd_uops_4_uses_stq;
  reg  [1:0]  rrd_uops_4_dst_rtype;
  reg  [1:0]  rrd_uops_4_lrs1_rtype;
  reg  [1:0]  rrd_uops_4_lrs2_rtype;
  reg         rrd_valids_5;
  reg  [6:0]  rrd_uops_5_uopc;
  reg         rrd_uops_5_is_rvc;
  reg  [9:0]  rrd_uops_5_fu_code;
  reg  [3:0]  rrd_uops_5_ctrl_br_type;
  reg  [1:0]  rrd_uops_5_ctrl_op1_sel;
  reg  [2:0]  rrd_uops_5_ctrl_op2_sel;
  reg  [2:0]  rrd_uops_5_ctrl_imm_sel;
  reg  [3:0]  rrd_uops_5_ctrl_op_fcn;
  reg         rrd_uops_5_ctrl_fcn_dw;
  reg  [2:0]  rrd_uops_5_ctrl_csr_cmd;
  reg         rrd_uops_5_is_br;
  reg         rrd_uops_5_is_jalr;
  reg         rrd_uops_5_is_jal;
  reg         rrd_uops_5_is_sfb;
  reg  [19:0] rrd_uops_5_br_mask;
  reg  [4:0]  rrd_uops_5_br_tag;
  reg  [5:0]  rrd_uops_5_ftq_idx;
  reg         rrd_uops_5_edge_inst;
  reg  [5:0]  rrd_uops_5_pc_lob;
  reg         rrd_uops_5_taken;
  reg  [19:0] rrd_uops_5_imm_packed;
  reg  [6:0]  rrd_uops_5_rob_idx;
  reg  [4:0]  rrd_uops_5_ldq_idx;
  reg  [4:0]  rrd_uops_5_stq_idx;
  reg  [6:0]  rrd_uops_5_pdst;
  reg  [6:0]  rrd_uops_5_prs1;
  reg  [6:0]  rrd_uops_5_prs2;
  reg         rrd_uops_5_bypassable;
  reg         rrd_uops_5_is_amo;
  reg         rrd_uops_5_uses_stq;
  reg  [1:0]  rrd_uops_5_dst_rtype;
  reg  [1:0]  rrd_uops_5_lrs1_rtype;
  reg  [1:0]  rrd_uops_5_lrs2_rtype;
  reg         rrd_rs1_data_0_REG;
  reg         rrd_rs2_data_0_REG;
  reg         rrd_rs1_data_1_REG;
  reg         rrd_rs2_data_1_REG;
  reg         rrd_rs1_data_2_REG;
  reg         rrd_rs2_data_2_REG;
  reg         rrd_rs1_data_3_REG;
  reg         rrd_rs2_data_3_REG;
  reg         rrd_rs1_data_4_REG;
  reg         rrd_rs2_data_4_REG;
  reg         rrd_rs1_data_5_REG;
  reg         rrd_rs2_data_5_REG;
  wire        rrd_kill = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_0_br_mask));
  wire        rrd_kill_1 = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_1_br_mask));
  wire        rrd_kill_2 = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_2_br_mask));
  wire        rrd_kill_3 = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_3_br_mask));
  wire        rrd_kill_4 = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_4_br_mask));
  wire        rrd_kill_5 = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_5_br_mask));
  wire        _GEN = io_bypass_0_bits_uop_dst_rtype != 2'h2;
  wire        _GEN_0 = io_bypass_0_bits_uop_dst_rtype == 2'h0;
  wire        _GEN_1 = rrd_uops_0_lrs1_rtype == 2'h0;
  wire        _GEN_2 = rrd_uops_0_lrs2_rtype == 2'h0;
  wire        _GEN_3 = io_bypass_1_bits_uop_dst_rtype != 2'h2;
  wire        _GEN_4 = io_bypass_1_bits_uop_dst_rtype == 2'h0;
  wire        _GEN_5 = io_bypass_2_bits_uop_dst_rtype != 2'h2;
  wire        _GEN_6 = io_bypass_2_bits_uop_dst_rtype == 2'h0;
  wire        _GEN_7 = io_bypass_3_bits_uop_dst_rtype != 2'h2;
  wire        _GEN_8 = io_bypass_3_bits_uop_dst_rtype == 2'h0;
  wire        _GEN_9 = io_bypass_4_bits_uop_dst_rtype != 2'h2;
  wire        _GEN_10 = io_bypass_4_bits_uop_dst_rtype == 2'h0;
  wire        _GEN_11 = io_bypass_5_bits_uop_dst_rtype != 2'h2;
  wire        _GEN_12 = io_bypass_5_bits_uop_dst_rtype == 2'h0;
  wire        _GEN_13 = rrd_uops_1_lrs1_rtype == 2'h0;
  wire        _GEN_14 = rrd_uops_1_lrs2_rtype == 2'h0;
  wire        _GEN_15 = rrd_uops_2_lrs1_rtype == 2'h0;
  wire        _GEN_16 = rrd_uops_2_lrs2_rtype == 2'h0;
  wire        _GEN_17 = rrd_uops_3_lrs1_rtype == 2'h0;
  wire        _GEN_18 = rrd_uops_3_lrs2_rtype == 2'h0;
  wire        _GEN_19 = rrd_uops_4_lrs1_rtype == 2'h0;
  wire        _GEN_20 = rrd_uops_4_lrs2_rtype == 2'h0;
  wire        _GEN_21 = rrd_uops_5_lrs1_rtype == 2'h0;
  wire        _GEN_22 = rrd_uops_5_lrs2_rtype == 2'h0;
  always @(posedge clock) begin
    exe_reg_valids_0 <= ~(reset | rrd_kill) & rrd_valids_0;
    exe_reg_valids_1 <= ~(reset | rrd_kill_1) & rrd_valids_1;
    exe_reg_valids_2 <= ~(reset | rrd_kill_2) & rrd_valids_2;
    exe_reg_valids_3 <= ~(reset | rrd_kill_3) & rrd_valids_3;
    exe_reg_valids_4 <= ~(reset | rrd_kill_4) & rrd_valids_4;
    exe_reg_valids_5 <= ~(reset | rrd_kill_5) & rrd_valids_5;
    if (rrd_kill) begin
      exe_reg_uops_0_uopc <= 7'h0;
      exe_reg_uops_0_fu_code <= 10'h0;
      exe_reg_uops_0_imm_packed <= 20'h0;
      exe_reg_uops_0_rob_idx <= 7'h0;
      exe_reg_uops_0_ldq_idx <= 5'h0;
      exe_reg_uops_0_stq_idx <= 5'h0;
      exe_reg_uops_0_pdst <= 7'h0;
      exe_reg_uops_0_mem_cmd <= 5'h0;
      exe_reg_uops_0_mem_size <= 2'h0;
    end
    else begin
      exe_reg_uops_0_uopc <= rrd_uops_0_uopc;
      exe_reg_uops_0_fu_code <= rrd_uops_0_fu_code;
      exe_reg_uops_0_imm_packed <= rrd_uops_0_imm_packed;
      exe_reg_uops_0_rob_idx <= rrd_uops_0_rob_idx;
      exe_reg_uops_0_ldq_idx <= rrd_uops_0_ldq_idx;
      exe_reg_uops_0_stq_idx <= rrd_uops_0_stq_idx;
      exe_reg_uops_0_pdst <= rrd_uops_0_pdst;
      exe_reg_uops_0_mem_cmd <= rrd_uops_0_mem_cmd;
      exe_reg_uops_0_mem_size <= rrd_uops_0_mem_size;
    end
    exe_reg_uops_0_ctrl_is_load <= ~rrd_kill & rrd_uops_0_ctrl_is_load;
    exe_reg_uops_0_ctrl_is_sta <= ~rrd_kill & rrd_uops_0_ctrl_is_sta;
    exe_reg_uops_0_ctrl_is_std <= ~rrd_kill & rrd_uops_0_ctrl_is_std;
    exe_reg_uops_0_br_mask <= rrd_uops_0_br_mask & ~io_brupdate_b1_resolve_mask;
    exe_reg_uops_0_mem_signed <= ~rrd_kill & rrd_uops_0_mem_signed;
    exe_reg_uops_0_is_fence <= ~rrd_kill & rrd_uops_0_is_fence;
    exe_reg_uops_0_is_amo <= ~rrd_kill & rrd_uops_0_is_amo;
    exe_reg_uops_0_uses_ldq <= ~rrd_kill & rrd_uops_0_uses_ldq;
    exe_reg_uops_0_uses_stq <= ~rrd_kill & rrd_uops_0_uses_stq;
    exe_reg_uops_0_fp_val <= ~rrd_kill & rrd_uops_0_fp_val;
    if (rrd_kill_1) begin
      exe_reg_uops_1_uopc <= 7'h0;
      exe_reg_uops_1_fu_code <= 10'h0;
      exe_reg_uops_1_imm_packed <= 20'h0;
      exe_reg_uops_1_rob_idx <= 7'h0;
      exe_reg_uops_1_ldq_idx <= 5'h0;
      exe_reg_uops_1_stq_idx <= 5'h0;
      exe_reg_uops_1_pdst <= 7'h0;
      exe_reg_uops_1_mem_cmd <= 5'h0;
      exe_reg_uops_1_mem_size <= 2'h0;
    end
    else begin
      exe_reg_uops_1_uopc <= rrd_uops_1_uopc;
      exe_reg_uops_1_fu_code <= rrd_uops_1_fu_code;
      exe_reg_uops_1_imm_packed <= rrd_uops_1_imm_packed;
      exe_reg_uops_1_rob_idx <= rrd_uops_1_rob_idx;
      exe_reg_uops_1_ldq_idx <= rrd_uops_1_ldq_idx;
      exe_reg_uops_1_stq_idx <= rrd_uops_1_stq_idx;
      exe_reg_uops_1_pdst <= rrd_uops_1_pdst;
      exe_reg_uops_1_mem_cmd <= rrd_uops_1_mem_cmd;
      exe_reg_uops_1_mem_size <= rrd_uops_1_mem_size;
    end
    exe_reg_uops_1_ctrl_is_load <= ~rrd_kill_1 & rrd_uops_1_ctrl_is_load;
    exe_reg_uops_1_ctrl_is_sta <= ~rrd_kill_1 & rrd_uops_1_ctrl_is_sta;
    exe_reg_uops_1_ctrl_is_std <= ~rrd_kill_1 & rrd_uops_1_ctrl_is_std;
    exe_reg_uops_1_br_mask <= rrd_uops_1_br_mask & ~io_brupdate_b1_resolve_mask;
    exe_reg_uops_1_mem_signed <= ~rrd_kill_1 & rrd_uops_1_mem_signed;
    exe_reg_uops_1_is_fence <= ~rrd_kill_1 & rrd_uops_1_is_fence;
    exe_reg_uops_1_is_amo <= ~rrd_kill_1 & rrd_uops_1_is_amo;
    exe_reg_uops_1_uses_ldq <= ~rrd_kill_1 & rrd_uops_1_uses_ldq;
    exe_reg_uops_1_uses_stq <= ~rrd_kill_1 & rrd_uops_1_uses_stq;
    exe_reg_uops_1_fp_val <= ~rrd_kill_1 & rrd_uops_1_fp_val;
    if (rrd_kill_2) begin
      exe_reg_uops_2_uopc <= 7'h0;
      exe_reg_uops_2_fu_code <= 10'h0;
      exe_reg_uops_2_ctrl_br_type <= 4'h0;
      exe_reg_uops_2_ctrl_op1_sel <= 2'h0;
      exe_reg_uops_2_ctrl_op2_sel <= 3'h0;
      exe_reg_uops_2_ctrl_imm_sel <= 3'h0;
      exe_reg_uops_2_ctrl_op_fcn <= 4'h0;
      exe_reg_uops_2_br_tag <= 5'h0;
      exe_reg_uops_2_ftq_idx <= 6'h0;
      exe_reg_uops_2_pc_lob <= 6'h0;
      exe_reg_uops_2_imm_packed <= 20'h0;
      exe_reg_uops_2_rob_idx <= 7'h0;
      exe_reg_uops_2_ldq_idx <= 5'h0;
      exe_reg_uops_2_stq_idx <= 5'h0;
      exe_reg_uops_2_pdst <= 7'h0;
      exe_reg_uops_2_prs1 <= 7'h0;
      exe_reg_uops_2_dst_rtype <= 2'h2;
    end
    else begin
      exe_reg_uops_2_uopc <= rrd_uops_2_uopc;
      exe_reg_uops_2_fu_code <= rrd_uops_2_fu_code;
      exe_reg_uops_2_ctrl_br_type <= rrd_uops_2_ctrl_br_type;
      exe_reg_uops_2_ctrl_op1_sel <= rrd_uops_2_ctrl_op1_sel;
      exe_reg_uops_2_ctrl_op2_sel <= rrd_uops_2_ctrl_op2_sel;
      exe_reg_uops_2_ctrl_imm_sel <= rrd_uops_2_ctrl_imm_sel;
      exe_reg_uops_2_ctrl_op_fcn <= rrd_uops_2_ctrl_op_fcn;
      exe_reg_uops_2_br_tag <= rrd_uops_2_br_tag;
      exe_reg_uops_2_ftq_idx <= rrd_uops_2_ftq_idx;
      exe_reg_uops_2_pc_lob <= rrd_uops_2_pc_lob;
      exe_reg_uops_2_imm_packed <= rrd_uops_2_imm_packed;
      exe_reg_uops_2_rob_idx <= rrd_uops_2_rob_idx;
      exe_reg_uops_2_ldq_idx <= rrd_uops_2_ldq_idx;
      exe_reg_uops_2_stq_idx <= rrd_uops_2_stq_idx;
      exe_reg_uops_2_pdst <= rrd_uops_2_pdst;
      exe_reg_uops_2_prs1 <= rrd_uops_2_prs1;
      exe_reg_uops_2_dst_rtype <= rrd_uops_2_dst_rtype;
    end
    exe_reg_uops_2_is_rvc <= ~rrd_kill_2 & rrd_uops_2_is_rvc;
    exe_reg_uops_2_ctrl_fcn_dw <= ~rrd_kill_2 & rrd_uops_2_ctrl_fcn_dw;
    exe_reg_uops_2_is_br <= ~rrd_kill_2 & rrd_uops_2_is_br;
    exe_reg_uops_2_is_jalr <= ~rrd_kill_2 & rrd_uops_2_is_jalr;
    exe_reg_uops_2_is_jal <= ~rrd_kill_2 & rrd_uops_2_is_jal;
    exe_reg_uops_2_is_sfb <= ~rrd_kill_2 & rrd_uops_2_is_sfb;
    exe_reg_uops_2_br_mask <= rrd_uops_2_br_mask & ~io_brupdate_b1_resolve_mask;
    exe_reg_uops_2_edge_inst <= ~rrd_kill_2 & rrd_uops_2_edge_inst;
    exe_reg_uops_2_taken <= ~rrd_kill_2 & rrd_uops_2_taken;
    exe_reg_uops_2_bypassable <= ~rrd_kill_2 & rrd_uops_2_bypassable;
    exe_reg_uops_2_is_amo <= ~rrd_kill_2 & rrd_uops_2_is_amo;
    exe_reg_uops_2_uses_stq <= ~rrd_kill_2 & rrd_uops_2_uses_stq;
    exe_reg_uops_2_fp_val <= ~rrd_kill_2 & rrd_uops_2_fp_val;
    if (rrd_kill_3) begin
      exe_reg_uops_3_uopc <= 7'h0;
      exe_reg_uops_3_fu_code <= 10'h0;
      exe_reg_uops_3_ctrl_br_type <= 4'h0;
      exe_reg_uops_3_ctrl_op1_sel <= 2'h0;
      exe_reg_uops_3_ctrl_op2_sel <= 3'h0;
      exe_reg_uops_3_ctrl_imm_sel <= 3'h0;
      exe_reg_uops_3_ctrl_op_fcn <= 4'h0;
      exe_reg_uops_3_ctrl_csr_cmd <= 3'h0;
      exe_reg_uops_3_br_tag <= 5'h0;
      exe_reg_uops_3_ftq_idx <= 6'h0;
      exe_reg_uops_3_pc_lob <= 6'h0;
      exe_reg_uops_3_imm_packed <= 20'h0;
      exe_reg_uops_3_rob_idx <= 7'h0;
      exe_reg_uops_3_ldq_idx <= 5'h0;
      exe_reg_uops_3_stq_idx <= 5'h0;
      exe_reg_uops_3_pdst <= 7'h0;
      exe_reg_uops_3_prs1 <= 7'h0;
      exe_reg_uops_3_dst_rtype <= 2'h2;
    end
    else begin
      exe_reg_uops_3_uopc <= rrd_uops_3_uopc;
      exe_reg_uops_3_fu_code <= rrd_uops_3_fu_code;
      exe_reg_uops_3_ctrl_br_type <= rrd_uops_3_ctrl_br_type;
      exe_reg_uops_3_ctrl_op1_sel <= rrd_uops_3_ctrl_op1_sel;
      exe_reg_uops_3_ctrl_op2_sel <= rrd_uops_3_ctrl_op2_sel;
      exe_reg_uops_3_ctrl_imm_sel <= rrd_uops_3_ctrl_imm_sel;
      exe_reg_uops_3_ctrl_op_fcn <= rrd_uops_3_ctrl_op_fcn;
      exe_reg_uops_3_ctrl_csr_cmd <= rrd_uops_3_ctrl_csr_cmd;
      exe_reg_uops_3_br_tag <= rrd_uops_3_br_tag;
      exe_reg_uops_3_ftq_idx <= rrd_uops_3_ftq_idx;
      exe_reg_uops_3_pc_lob <= rrd_uops_3_pc_lob;
      exe_reg_uops_3_imm_packed <= rrd_uops_3_imm_packed;
      exe_reg_uops_3_rob_idx <= rrd_uops_3_rob_idx;
      exe_reg_uops_3_ldq_idx <= rrd_uops_3_ldq_idx;
      exe_reg_uops_3_stq_idx <= rrd_uops_3_stq_idx;
      exe_reg_uops_3_pdst <= rrd_uops_3_pdst;
      exe_reg_uops_3_prs1 <= rrd_uops_3_prs1;
      exe_reg_uops_3_dst_rtype <= rrd_uops_3_dst_rtype;
    end
    exe_reg_uops_3_is_rvc <= ~rrd_kill_3 & rrd_uops_3_is_rvc;
    exe_reg_uops_3_ctrl_fcn_dw <= ~rrd_kill_3 & rrd_uops_3_ctrl_fcn_dw;
    exe_reg_uops_3_is_br <= ~rrd_kill_3 & rrd_uops_3_is_br;
    exe_reg_uops_3_is_jalr <= ~rrd_kill_3 & rrd_uops_3_is_jalr;
    exe_reg_uops_3_is_jal <= ~rrd_kill_3 & rrd_uops_3_is_jal;
    exe_reg_uops_3_is_sfb <= ~rrd_kill_3 & rrd_uops_3_is_sfb;
    exe_reg_uops_3_br_mask <= rrd_uops_3_br_mask & ~io_brupdate_b1_resolve_mask;
    exe_reg_uops_3_edge_inst <= ~rrd_kill_3 & rrd_uops_3_edge_inst;
    exe_reg_uops_3_taken <= ~rrd_kill_3 & rrd_uops_3_taken;
    exe_reg_uops_3_bypassable <= ~rrd_kill_3 & rrd_uops_3_bypassable;
    exe_reg_uops_3_is_amo <= ~rrd_kill_3 & rrd_uops_3_is_amo;
    exe_reg_uops_3_uses_stq <= ~rrd_kill_3 & rrd_uops_3_uses_stq;
    if (rrd_kill_4) begin
      exe_reg_uops_4_uopc <= 7'h0;
      exe_reg_uops_4_fu_code <= 10'h0;
      exe_reg_uops_4_ctrl_br_type <= 4'h0;
      exe_reg_uops_4_ctrl_op1_sel <= 2'h0;
      exe_reg_uops_4_ctrl_op2_sel <= 3'h0;
      exe_reg_uops_4_ctrl_imm_sel <= 3'h0;
      exe_reg_uops_4_ctrl_op_fcn <= 4'h0;
      exe_reg_uops_4_br_tag <= 5'h0;
      exe_reg_uops_4_ftq_idx <= 6'h0;
      exe_reg_uops_4_pc_lob <= 6'h0;
      exe_reg_uops_4_imm_packed <= 20'h0;
      exe_reg_uops_4_rob_idx <= 7'h0;
      exe_reg_uops_4_ldq_idx <= 5'h0;
      exe_reg_uops_4_stq_idx <= 5'h0;
      exe_reg_uops_4_pdst <= 7'h0;
      exe_reg_uops_4_prs1 <= 7'h0;
      exe_reg_uops_4_dst_rtype <= 2'h2;
    end
    else begin
      exe_reg_uops_4_uopc <= rrd_uops_4_uopc;
      exe_reg_uops_4_fu_code <= rrd_uops_4_fu_code;
      exe_reg_uops_4_ctrl_br_type <= rrd_uops_4_ctrl_br_type;
      exe_reg_uops_4_ctrl_op1_sel <= rrd_uops_4_ctrl_op1_sel;
      exe_reg_uops_4_ctrl_op2_sel <= rrd_uops_4_ctrl_op2_sel;
      exe_reg_uops_4_ctrl_imm_sel <= rrd_uops_4_ctrl_imm_sel;
      exe_reg_uops_4_ctrl_op_fcn <= rrd_uops_4_ctrl_op_fcn;
      exe_reg_uops_4_br_tag <= rrd_uops_4_br_tag;
      exe_reg_uops_4_ftq_idx <= rrd_uops_4_ftq_idx;
      exe_reg_uops_4_pc_lob <= rrd_uops_4_pc_lob;
      exe_reg_uops_4_imm_packed <= rrd_uops_4_imm_packed;
      exe_reg_uops_4_rob_idx <= rrd_uops_4_rob_idx;
      exe_reg_uops_4_ldq_idx <= rrd_uops_4_ldq_idx;
      exe_reg_uops_4_stq_idx <= rrd_uops_4_stq_idx;
      exe_reg_uops_4_pdst <= rrd_uops_4_pdst;
      exe_reg_uops_4_prs1 <= rrd_uops_4_prs1;
      exe_reg_uops_4_dst_rtype <= rrd_uops_4_dst_rtype;
    end
    exe_reg_uops_4_is_rvc <= ~rrd_kill_4 & rrd_uops_4_is_rvc;
    exe_reg_uops_4_ctrl_fcn_dw <= ~rrd_kill_4 & rrd_uops_4_ctrl_fcn_dw;
    exe_reg_uops_4_is_br <= ~rrd_kill_4 & rrd_uops_4_is_br;
    exe_reg_uops_4_is_jalr <= ~rrd_kill_4 & rrd_uops_4_is_jalr;
    exe_reg_uops_4_is_jal <= ~rrd_kill_4 & rrd_uops_4_is_jal;
    exe_reg_uops_4_is_sfb <= ~rrd_kill_4 & rrd_uops_4_is_sfb;
    exe_reg_uops_4_br_mask <= rrd_uops_4_br_mask & ~io_brupdate_b1_resolve_mask;
    exe_reg_uops_4_edge_inst <= ~rrd_kill_4 & rrd_uops_4_edge_inst;
    exe_reg_uops_4_taken <= ~rrd_kill_4 & rrd_uops_4_taken;
    exe_reg_uops_4_bypassable <= ~rrd_kill_4 & rrd_uops_4_bypassable;
    exe_reg_uops_4_is_amo <= ~rrd_kill_4 & rrd_uops_4_is_amo;
    exe_reg_uops_4_uses_stq <= ~rrd_kill_4 & rrd_uops_4_uses_stq;
    if (rrd_kill_5) begin
      exe_reg_uops_5_uopc <= 7'h0;
      exe_reg_uops_5_fu_code <= 10'h0;
      exe_reg_uops_5_ctrl_br_type <= 4'h0;
      exe_reg_uops_5_ctrl_op1_sel <= 2'h0;
      exe_reg_uops_5_ctrl_op2_sel <= 3'h0;
      exe_reg_uops_5_ctrl_imm_sel <= 3'h0;
      exe_reg_uops_5_ctrl_op_fcn <= 4'h0;
      exe_reg_uops_5_ctrl_csr_cmd <= 3'h0;
      exe_reg_uops_5_br_tag <= 5'h0;
      exe_reg_uops_5_ftq_idx <= 6'h0;
      exe_reg_uops_5_pc_lob <= 6'h0;
      exe_reg_uops_5_imm_packed <= 20'h0;
      exe_reg_uops_5_rob_idx <= 7'h0;
      exe_reg_uops_5_ldq_idx <= 5'h0;
      exe_reg_uops_5_stq_idx <= 5'h0;
      exe_reg_uops_5_pdst <= 7'h0;
      exe_reg_uops_5_prs1 <= 7'h0;
      exe_reg_uops_5_dst_rtype <= 2'h2;
    end
    else begin
      exe_reg_uops_5_uopc <= rrd_uops_5_uopc;
      exe_reg_uops_5_fu_code <= rrd_uops_5_fu_code;
      exe_reg_uops_5_ctrl_br_type <= rrd_uops_5_ctrl_br_type;
      exe_reg_uops_5_ctrl_op1_sel <= rrd_uops_5_ctrl_op1_sel;
      exe_reg_uops_5_ctrl_op2_sel <= rrd_uops_5_ctrl_op2_sel;
      exe_reg_uops_5_ctrl_imm_sel <= rrd_uops_5_ctrl_imm_sel;
      exe_reg_uops_5_ctrl_op_fcn <= rrd_uops_5_ctrl_op_fcn;
      exe_reg_uops_5_ctrl_csr_cmd <= rrd_uops_5_ctrl_csr_cmd;
      exe_reg_uops_5_br_tag <= rrd_uops_5_br_tag;
      exe_reg_uops_5_ftq_idx <= rrd_uops_5_ftq_idx;
      exe_reg_uops_5_pc_lob <= rrd_uops_5_pc_lob;
      exe_reg_uops_5_imm_packed <= rrd_uops_5_imm_packed;
      exe_reg_uops_5_rob_idx <= rrd_uops_5_rob_idx;
      exe_reg_uops_5_ldq_idx <= rrd_uops_5_ldq_idx;
      exe_reg_uops_5_stq_idx <= rrd_uops_5_stq_idx;
      exe_reg_uops_5_pdst <= rrd_uops_5_pdst;
      exe_reg_uops_5_prs1 <= rrd_uops_5_prs1;
      exe_reg_uops_5_dst_rtype <= rrd_uops_5_dst_rtype;
    end
    exe_reg_uops_5_is_rvc <= ~rrd_kill_5 & rrd_uops_5_is_rvc;
    exe_reg_uops_5_ctrl_fcn_dw <= ~rrd_kill_5 & rrd_uops_5_ctrl_fcn_dw;
    exe_reg_uops_5_is_br <= ~rrd_kill_5 & rrd_uops_5_is_br;
    exe_reg_uops_5_is_jalr <= ~rrd_kill_5 & rrd_uops_5_is_jalr;
    exe_reg_uops_5_is_jal <= ~rrd_kill_5 & rrd_uops_5_is_jal;
    exe_reg_uops_5_is_sfb <= ~rrd_kill_5 & rrd_uops_5_is_sfb;
    exe_reg_uops_5_br_mask <= rrd_uops_5_br_mask & ~io_brupdate_b1_resolve_mask;
    exe_reg_uops_5_edge_inst <= ~rrd_kill_5 & rrd_uops_5_edge_inst;
    exe_reg_uops_5_taken <= ~rrd_kill_5 & rrd_uops_5_taken;
    exe_reg_uops_5_bypassable <= ~rrd_kill_5 & rrd_uops_5_bypassable;
    exe_reg_uops_5_is_amo <= ~rrd_kill_5 & rrd_uops_5_is_amo;
    exe_reg_uops_5_uses_stq <= ~rrd_kill_5 & rrd_uops_5_uses_stq;
    if (io_bypass_0_valid & rrd_uops_0_prs1 == io_bypass_0_bits_uop_pdst & _GEN & _GEN_0 & _GEN_1 & (|rrd_uops_0_prs1))
      exe_reg_rs1_data_0 <= io_bypass_0_bits_data;
    else if (io_bypass_1_valid & rrd_uops_0_prs1 == io_bypass_1_bits_uop_pdst & _GEN_3 & _GEN_4 & _GEN_1 & (|rrd_uops_0_prs1))
      exe_reg_rs1_data_0 <= io_bypass_1_bits_data;
    else if (io_bypass_2_valid & rrd_uops_0_prs1 == io_bypass_2_bits_uop_pdst & _GEN_5 & _GEN_6 & _GEN_1 & (|rrd_uops_0_prs1))
      exe_reg_rs1_data_0 <= io_bypass_2_bits_data;
    else if (io_bypass_3_valid & rrd_uops_0_prs1 == io_bypass_3_bits_uop_pdst & _GEN_7 & _GEN_8 & _GEN_1 & (|rrd_uops_0_prs1))
      exe_reg_rs1_data_0 <= io_bypass_3_bits_data;
    else if (io_bypass_4_valid & rrd_uops_0_prs1 == io_bypass_4_bits_uop_pdst & _GEN_9 & _GEN_10 & _GEN_1 & (|rrd_uops_0_prs1))
      exe_reg_rs1_data_0 <= io_bypass_4_bits_data;
    else if (io_bypass_5_valid & rrd_uops_0_prs1 == io_bypass_5_bits_uop_pdst & _GEN_11 & _GEN_12 & _GEN_1 & (|rrd_uops_0_prs1))
      exe_reg_rs1_data_0 <= io_bypass_5_bits_data;
    else if (rrd_rs1_data_0_REG)
      exe_reg_rs1_data_0 <= 64'h0;
    else
      exe_reg_rs1_data_0 <= io_rf_read_ports_0_data;
    if (io_bypass_0_valid & rrd_uops_1_prs1 == io_bypass_0_bits_uop_pdst & _GEN & _GEN_0 & _GEN_13 & (|rrd_uops_1_prs1))
      exe_reg_rs1_data_1 <= io_bypass_0_bits_data;
    else if (io_bypass_1_valid & rrd_uops_1_prs1 == io_bypass_1_bits_uop_pdst & _GEN_3 & _GEN_4 & _GEN_13 & (|rrd_uops_1_prs1))
      exe_reg_rs1_data_1 <= io_bypass_1_bits_data;
    else if (io_bypass_2_valid & rrd_uops_1_prs1 == io_bypass_2_bits_uop_pdst & _GEN_5 & _GEN_6 & _GEN_13 & (|rrd_uops_1_prs1))
      exe_reg_rs1_data_1 <= io_bypass_2_bits_data;
    else if (io_bypass_3_valid & rrd_uops_1_prs1 == io_bypass_3_bits_uop_pdst & _GEN_7 & _GEN_8 & _GEN_13 & (|rrd_uops_1_prs1))
      exe_reg_rs1_data_1 <= io_bypass_3_bits_data;
    else if (io_bypass_4_valid & rrd_uops_1_prs1 == io_bypass_4_bits_uop_pdst & _GEN_9 & _GEN_10 & _GEN_13 & (|rrd_uops_1_prs1))
      exe_reg_rs1_data_1 <= io_bypass_4_bits_data;
    else if (io_bypass_5_valid & rrd_uops_1_prs1 == io_bypass_5_bits_uop_pdst & _GEN_11 & _GEN_12 & _GEN_13 & (|rrd_uops_1_prs1))
      exe_reg_rs1_data_1 <= io_bypass_5_bits_data;
    else if (rrd_rs1_data_1_REG)
      exe_reg_rs1_data_1 <= 64'h0;
    else
      exe_reg_rs1_data_1 <= io_rf_read_ports_2_data;
    if (io_bypass_0_valid & rrd_uops_2_prs1 == io_bypass_0_bits_uop_pdst & _GEN & _GEN_0 & _GEN_15 & (|rrd_uops_2_prs1))
      exe_reg_rs1_data_2 <= io_bypass_0_bits_data;
    else if (io_bypass_1_valid & rrd_uops_2_prs1 == io_bypass_1_bits_uop_pdst & _GEN_3 & _GEN_4 & _GEN_15 & (|rrd_uops_2_prs1))
      exe_reg_rs1_data_2 <= io_bypass_1_bits_data;
    else if (io_bypass_2_valid & rrd_uops_2_prs1 == io_bypass_2_bits_uop_pdst & _GEN_5 & _GEN_6 & _GEN_15 & (|rrd_uops_2_prs1))
      exe_reg_rs1_data_2 <= io_bypass_2_bits_data;
    else if (io_bypass_3_valid & rrd_uops_2_prs1 == io_bypass_3_bits_uop_pdst & _GEN_7 & _GEN_8 & _GEN_15 & (|rrd_uops_2_prs1))
      exe_reg_rs1_data_2 <= io_bypass_3_bits_data;
    else if (io_bypass_4_valid & rrd_uops_2_prs1 == io_bypass_4_bits_uop_pdst & _GEN_9 & _GEN_10 & _GEN_15 & (|rrd_uops_2_prs1))
      exe_reg_rs1_data_2 <= io_bypass_4_bits_data;
    else if (io_bypass_5_valid & rrd_uops_2_prs1 == io_bypass_5_bits_uop_pdst & _GEN_11 & _GEN_12 & _GEN_15 & (|rrd_uops_2_prs1))
      exe_reg_rs1_data_2 <= io_bypass_5_bits_data;
    else if (rrd_rs1_data_2_REG)
      exe_reg_rs1_data_2 <= 64'h0;
    else
      exe_reg_rs1_data_2 <= io_rf_read_ports_4_data;
    if (io_bypass_0_valid & rrd_uops_3_prs1 == io_bypass_0_bits_uop_pdst & _GEN & _GEN_0 & _GEN_17 & (|rrd_uops_3_prs1))
      exe_reg_rs1_data_3 <= io_bypass_0_bits_data;
    else if (io_bypass_1_valid & rrd_uops_3_prs1 == io_bypass_1_bits_uop_pdst & _GEN_3 & _GEN_4 & _GEN_17 & (|rrd_uops_3_prs1))
      exe_reg_rs1_data_3 <= io_bypass_1_bits_data;
    else if (io_bypass_2_valid & rrd_uops_3_prs1 == io_bypass_2_bits_uop_pdst & _GEN_5 & _GEN_6 & _GEN_17 & (|rrd_uops_3_prs1))
      exe_reg_rs1_data_3 <= io_bypass_2_bits_data;
    else if (io_bypass_3_valid & rrd_uops_3_prs1 == io_bypass_3_bits_uop_pdst & _GEN_7 & _GEN_8 & _GEN_17 & (|rrd_uops_3_prs1))
      exe_reg_rs1_data_3 <= io_bypass_3_bits_data;
    else if (io_bypass_4_valid & rrd_uops_3_prs1 == io_bypass_4_bits_uop_pdst & _GEN_9 & _GEN_10 & _GEN_17 & (|rrd_uops_3_prs1))
      exe_reg_rs1_data_3 <= io_bypass_4_bits_data;
    else if (io_bypass_5_valid & rrd_uops_3_prs1 == io_bypass_5_bits_uop_pdst & _GEN_11 & _GEN_12 & _GEN_17 & (|rrd_uops_3_prs1))
      exe_reg_rs1_data_3 <= io_bypass_5_bits_data;
    else if (rrd_rs1_data_3_REG)
      exe_reg_rs1_data_3 <= 64'h0;
    else
      exe_reg_rs1_data_3 <= io_rf_read_ports_6_data;
    if (io_bypass_0_valid & rrd_uops_4_prs1 == io_bypass_0_bits_uop_pdst & _GEN & _GEN_0 & _GEN_19 & (|rrd_uops_4_prs1))
      exe_reg_rs1_data_4 <= io_bypass_0_bits_data;
    else if (io_bypass_1_valid & rrd_uops_4_prs1 == io_bypass_1_bits_uop_pdst & _GEN_3 & _GEN_4 & _GEN_19 & (|rrd_uops_4_prs1))
      exe_reg_rs1_data_4 <= io_bypass_1_bits_data;
    else if (io_bypass_2_valid & rrd_uops_4_prs1 == io_bypass_2_bits_uop_pdst & _GEN_5 & _GEN_6 & _GEN_19 & (|rrd_uops_4_prs1))
      exe_reg_rs1_data_4 <= io_bypass_2_bits_data;
    else if (io_bypass_3_valid & rrd_uops_4_prs1 == io_bypass_3_bits_uop_pdst & _GEN_7 & _GEN_8 & _GEN_19 & (|rrd_uops_4_prs1))
      exe_reg_rs1_data_4 <= io_bypass_3_bits_data;
    else if (io_bypass_4_valid & rrd_uops_4_prs1 == io_bypass_4_bits_uop_pdst & _GEN_9 & _GEN_10 & _GEN_19 & (|rrd_uops_4_prs1))
      exe_reg_rs1_data_4 <= io_bypass_4_bits_data;
    else if (io_bypass_5_valid & rrd_uops_4_prs1 == io_bypass_5_bits_uop_pdst & _GEN_11 & _GEN_12 & _GEN_19 & (|rrd_uops_4_prs1))
      exe_reg_rs1_data_4 <= io_bypass_5_bits_data;
    else if (rrd_rs1_data_4_REG)
      exe_reg_rs1_data_4 <= 64'h0;
    else
      exe_reg_rs1_data_4 <= io_rf_read_ports_8_data;
    if (io_bypass_0_valid & rrd_uops_5_prs1 == io_bypass_0_bits_uop_pdst & _GEN & _GEN_0 & _GEN_21 & (|rrd_uops_5_prs1))
      exe_reg_rs1_data_5 <= io_bypass_0_bits_data;
    else if (io_bypass_1_valid & rrd_uops_5_prs1 == io_bypass_1_bits_uop_pdst & _GEN_3 & _GEN_4 & _GEN_21 & (|rrd_uops_5_prs1))
      exe_reg_rs1_data_5 <= io_bypass_1_bits_data;
    else if (io_bypass_2_valid & rrd_uops_5_prs1 == io_bypass_2_bits_uop_pdst & _GEN_5 & _GEN_6 & _GEN_21 & (|rrd_uops_5_prs1))
      exe_reg_rs1_data_5 <= io_bypass_2_bits_data;
    else if (io_bypass_3_valid & rrd_uops_5_prs1 == io_bypass_3_bits_uop_pdst & _GEN_7 & _GEN_8 & _GEN_21 & (|rrd_uops_5_prs1))
      exe_reg_rs1_data_5 <= io_bypass_3_bits_data;
    else if (io_bypass_4_valid & rrd_uops_5_prs1 == io_bypass_4_bits_uop_pdst & _GEN_9 & _GEN_10 & _GEN_21 & (|rrd_uops_5_prs1))
      exe_reg_rs1_data_5 <= io_bypass_4_bits_data;
    else if (io_bypass_5_valid & rrd_uops_5_prs1 == io_bypass_5_bits_uop_pdst & _GEN_11 & _GEN_12 & _GEN_21 & (|rrd_uops_5_prs1))
      exe_reg_rs1_data_5 <= io_bypass_5_bits_data;
    else if (rrd_rs1_data_5_REG)
      exe_reg_rs1_data_5 <= 64'h0;
    else
      exe_reg_rs1_data_5 <= io_rf_read_ports_10_data;
    if (io_bypass_0_valid & rrd_uops_0_prs2 == io_bypass_0_bits_uop_pdst & _GEN & _GEN_0 & _GEN_2 & (|rrd_uops_0_prs2))
      exe_reg_rs2_data_0 <= io_bypass_0_bits_data;
    else if (io_bypass_1_valid & rrd_uops_0_prs2 == io_bypass_1_bits_uop_pdst & _GEN_3 & _GEN_4 & _GEN_2 & (|rrd_uops_0_prs2))
      exe_reg_rs2_data_0 <= io_bypass_1_bits_data;
    else if (io_bypass_2_valid & rrd_uops_0_prs2 == io_bypass_2_bits_uop_pdst & _GEN_5 & _GEN_6 & _GEN_2 & (|rrd_uops_0_prs2))
      exe_reg_rs2_data_0 <= io_bypass_2_bits_data;
    else if (io_bypass_3_valid & rrd_uops_0_prs2 == io_bypass_3_bits_uop_pdst & _GEN_7 & _GEN_8 & _GEN_2 & (|rrd_uops_0_prs2))
      exe_reg_rs2_data_0 <= io_bypass_3_bits_data;
    else if (io_bypass_4_valid & rrd_uops_0_prs2 == io_bypass_4_bits_uop_pdst & _GEN_9 & _GEN_10 & _GEN_2 & (|rrd_uops_0_prs2))
      exe_reg_rs2_data_0 <= io_bypass_4_bits_data;
    else if (io_bypass_5_valid & rrd_uops_0_prs2 == io_bypass_5_bits_uop_pdst & _GEN_11 & _GEN_12 & _GEN_2 & (|rrd_uops_0_prs2))
      exe_reg_rs2_data_0 <= io_bypass_5_bits_data;
    else if (rrd_rs2_data_0_REG)
      exe_reg_rs2_data_0 <= 64'h0;
    else
      exe_reg_rs2_data_0 <= io_rf_read_ports_1_data;
    if (io_bypass_0_valid & rrd_uops_1_prs2 == io_bypass_0_bits_uop_pdst & _GEN & _GEN_0 & _GEN_14 & (|rrd_uops_1_prs2))
      exe_reg_rs2_data_1 <= io_bypass_0_bits_data;
    else if (io_bypass_1_valid & rrd_uops_1_prs2 == io_bypass_1_bits_uop_pdst & _GEN_3 & _GEN_4 & _GEN_14 & (|rrd_uops_1_prs2))
      exe_reg_rs2_data_1 <= io_bypass_1_bits_data;
    else if (io_bypass_2_valid & rrd_uops_1_prs2 == io_bypass_2_bits_uop_pdst & _GEN_5 & _GEN_6 & _GEN_14 & (|rrd_uops_1_prs2))
      exe_reg_rs2_data_1 <= io_bypass_2_bits_data;
    else if (io_bypass_3_valid & rrd_uops_1_prs2 == io_bypass_3_bits_uop_pdst & _GEN_7 & _GEN_8 & _GEN_14 & (|rrd_uops_1_prs2))
      exe_reg_rs2_data_1 <= io_bypass_3_bits_data;
    else if (io_bypass_4_valid & rrd_uops_1_prs2 == io_bypass_4_bits_uop_pdst & _GEN_9 & _GEN_10 & _GEN_14 & (|rrd_uops_1_prs2))
      exe_reg_rs2_data_1 <= io_bypass_4_bits_data;
    else if (io_bypass_5_valid & rrd_uops_1_prs2 == io_bypass_5_bits_uop_pdst & _GEN_11 & _GEN_12 & _GEN_14 & (|rrd_uops_1_prs2))
      exe_reg_rs2_data_1 <= io_bypass_5_bits_data;
    else if (rrd_rs2_data_1_REG)
      exe_reg_rs2_data_1 <= 64'h0;
    else
      exe_reg_rs2_data_1 <= io_rf_read_ports_3_data;
    if (io_bypass_0_valid & rrd_uops_2_prs2 == io_bypass_0_bits_uop_pdst & _GEN & _GEN_0 & _GEN_16 & (|rrd_uops_2_prs2))
      exe_reg_rs2_data_2 <= io_bypass_0_bits_data;
    else if (io_bypass_1_valid & rrd_uops_2_prs2 == io_bypass_1_bits_uop_pdst & _GEN_3 & _GEN_4 & _GEN_16 & (|rrd_uops_2_prs2))
      exe_reg_rs2_data_2 <= io_bypass_1_bits_data;
    else if (io_bypass_2_valid & rrd_uops_2_prs2 == io_bypass_2_bits_uop_pdst & _GEN_5 & _GEN_6 & _GEN_16 & (|rrd_uops_2_prs2))
      exe_reg_rs2_data_2 <= io_bypass_2_bits_data;
    else if (io_bypass_3_valid & rrd_uops_2_prs2 == io_bypass_3_bits_uop_pdst & _GEN_7 & _GEN_8 & _GEN_16 & (|rrd_uops_2_prs2))
      exe_reg_rs2_data_2 <= io_bypass_3_bits_data;
    else if (io_bypass_4_valid & rrd_uops_2_prs2 == io_bypass_4_bits_uop_pdst & _GEN_9 & _GEN_10 & _GEN_16 & (|rrd_uops_2_prs2))
      exe_reg_rs2_data_2 <= io_bypass_4_bits_data;
    else if (io_bypass_5_valid & rrd_uops_2_prs2 == io_bypass_5_bits_uop_pdst & _GEN_11 & _GEN_12 & _GEN_16 & (|rrd_uops_2_prs2))
      exe_reg_rs2_data_2 <= io_bypass_5_bits_data;
    else if (rrd_rs2_data_2_REG)
      exe_reg_rs2_data_2 <= 64'h0;
    else
      exe_reg_rs2_data_2 <= io_rf_read_ports_5_data;
    if (io_bypass_0_valid & rrd_uops_3_prs2 == io_bypass_0_bits_uop_pdst & _GEN & _GEN_0 & _GEN_18 & (|rrd_uops_3_prs2))
      exe_reg_rs2_data_3 <= io_bypass_0_bits_data;
    else if (io_bypass_1_valid & rrd_uops_3_prs2 == io_bypass_1_bits_uop_pdst & _GEN_3 & _GEN_4 & _GEN_18 & (|rrd_uops_3_prs2))
      exe_reg_rs2_data_3 <= io_bypass_1_bits_data;
    else if (io_bypass_2_valid & rrd_uops_3_prs2 == io_bypass_2_bits_uop_pdst & _GEN_5 & _GEN_6 & _GEN_18 & (|rrd_uops_3_prs2))
      exe_reg_rs2_data_3 <= io_bypass_2_bits_data;
    else if (io_bypass_3_valid & rrd_uops_3_prs2 == io_bypass_3_bits_uop_pdst & _GEN_7 & _GEN_8 & _GEN_18 & (|rrd_uops_3_prs2))
      exe_reg_rs2_data_3 <= io_bypass_3_bits_data;
    else if (io_bypass_4_valid & rrd_uops_3_prs2 == io_bypass_4_bits_uop_pdst & _GEN_9 & _GEN_10 & _GEN_18 & (|rrd_uops_3_prs2))
      exe_reg_rs2_data_3 <= io_bypass_4_bits_data;
    else if (io_bypass_5_valid & rrd_uops_3_prs2 == io_bypass_5_bits_uop_pdst & _GEN_11 & _GEN_12 & _GEN_18 & (|rrd_uops_3_prs2))
      exe_reg_rs2_data_3 <= io_bypass_5_bits_data;
    else if (rrd_rs2_data_3_REG)
      exe_reg_rs2_data_3 <= 64'h0;
    else
      exe_reg_rs2_data_3 <= io_rf_read_ports_7_data;
    if (io_bypass_0_valid & rrd_uops_4_prs2 == io_bypass_0_bits_uop_pdst & _GEN & _GEN_0 & _GEN_20 & (|rrd_uops_4_prs2))
      exe_reg_rs2_data_4 <= io_bypass_0_bits_data;
    else if (io_bypass_1_valid & rrd_uops_4_prs2 == io_bypass_1_bits_uop_pdst & _GEN_3 & _GEN_4 & _GEN_20 & (|rrd_uops_4_prs2))
      exe_reg_rs2_data_4 <= io_bypass_1_bits_data;
    else if (io_bypass_2_valid & rrd_uops_4_prs2 == io_bypass_2_bits_uop_pdst & _GEN_5 & _GEN_6 & _GEN_20 & (|rrd_uops_4_prs2))
      exe_reg_rs2_data_4 <= io_bypass_2_bits_data;
    else if (io_bypass_3_valid & rrd_uops_4_prs2 == io_bypass_3_bits_uop_pdst & _GEN_7 & _GEN_8 & _GEN_20 & (|rrd_uops_4_prs2))
      exe_reg_rs2_data_4 <= io_bypass_3_bits_data;
    else if (io_bypass_4_valid & rrd_uops_4_prs2 == io_bypass_4_bits_uop_pdst & _GEN_9 & _GEN_10 & _GEN_20 & (|rrd_uops_4_prs2))
      exe_reg_rs2_data_4 <= io_bypass_4_bits_data;
    else if (io_bypass_5_valid & rrd_uops_4_prs2 == io_bypass_5_bits_uop_pdst & _GEN_11 & _GEN_12 & _GEN_20 & (|rrd_uops_4_prs2))
      exe_reg_rs2_data_4 <= io_bypass_5_bits_data;
    else if (rrd_rs2_data_4_REG)
      exe_reg_rs2_data_4 <= 64'h0;
    else
      exe_reg_rs2_data_4 <= io_rf_read_ports_9_data;
    if (io_bypass_0_valid & rrd_uops_5_prs2 == io_bypass_0_bits_uop_pdst & _GEN & _GEN_0 & _GEN_22 & (|rrd_uops_5_prs2))
      exe_reg_rs2_data_5 <= io_bypass_0_bits_data;
    else if (io_bypass_1_valid & rrd_uops_5_prs2 == io_bypass_1_bits_uop_pdst & _GEN_3 & _GEN_4 & _GEN_22 & (|rrd_uops_5_prs2))
      exe_reg_rs2_data_5 <= io_bypass_1_bits_data;
    else if (io_bypass_2_valid & rrd_uops_5_prs2 == io_bypass_2_bits_uop_pdst & _GEN_5 & _GEN_6 & _GEN_22 & (|rrd_uops_5_prs2))
      exe_reg_rs2_data_5 <= io_bypass_2_bits_data;
    else if (io_bypass_3_valid & rrd_uops_5_prs2 == io_bypass_3_bits_uop_pdst & _GEN_7 & _GEN_8 & _GEN_22 & (|rrd_uops_5_prs2))
      exe_reg_rs2_data_5 <= io_bypass_3_bits_data;
    else if (io_bypass_4_valid & rrd_uops_5_prs2 == io_bypass_4_bits_uop_pdst & _GEN_9 & _GEN_10 & _GEN_22 & (|rrd_uops_5_prs2))
      exe_reg_rs2_data_5 <= io_bypass_4_bits_data;
    else if (io_bypass_5_valid & rrd_uops_5_prs2 == io_bypass_5_bits_uop_pdst & _GEN_11 & _GEN_12 & _GEN_22 & (|rrd_uops_5_prs2))
      exe_reg_rs2_data_5 <= io_bypass_5_bits_data;
    else if (rrd_rs2_data_5_REG)
      exe_reg_rs2_data_5 <= 64'h0;
    else
      exe_reg_rs2_data_5 <= io_rf_read_ports_11_data;
    rrd_valids_0 <= _rrd_decode_unit_io_rrd_valid & (io_brupdate_b1_mispredict_mask & _rrd_decode_unit_io_rrd_uop_br_mask) == 20'h0;
    rrd_uops_0_uopc <= _rrd_decode_unit_io_rrd_uop_uopc;
    rrd_uops_0_fu_code <= _rrd_decode_unit_io_rrd_uop_fu_code;
    rrd_uops_0_ctrl_is_load <= _rrd_decode_unit_io_rrd_uop_ctrl_is_load;
    rrd_uops_0_ctrl_is_sta <= _rrd_decode_unit_io_rrd_uop_ctrl_is_sta;
    rrd_uops_0_ctrl_is_std <= _rrd_decode_unit_io_rrd_uop_ctrl_is_std;
    rrd_uops_0_br_mask <= _rrd_decode_unit_io_rrd_uop_br_mask & ~io_brupdate_b1_resolve_mask;
    rrd_uops_0_imm_packed <= _rrd_decode_unit_io_rrd_uop_imm_packed;
    rrd_uops_0_rob_idx <= _rrd_decode_unit_io_rrd_uop_rob_idx;
    rrd_uops_0_ldq_idx <= _rrd_decode_unit_io_rrd_uop_ldq_idx;
    rrd_uops_0_stq_idx <= _rrd_decode_unit_io_rrd_uop_stq_idx;
    rrd_uops_0_pdst <= _rrd_decode_unit_io_rrd_uop_pdst;
    rrd_uops_0_prs1 <= _rrd_decode_unit_io_rrd_uop_prs1;
    rrd_uops_0_prs2 <= _rrd_decode_unit_io_rrd_uop_prs2;
    rrd_uops_0_mem_cmd <= _rrd_decode_unit_io_rrd_uop_mem_cmd;
    rrd_uops_0_mem_size <= _rrd_decode_unit_io_rrd_uop_mem_size;
    rrd_uops_0_mem_signed <= _rrd_decode_unit_io_rrd_uop_mem_signed;
    rrd_uops_0_is_fence <= _rrd_decode_unit_io_rrd_uop_is_fence;
    rrd_uops_0_is_amo <= _rrd_decode_unit_io_rrd_uop_is_amo;
    rrd_uops_0_uses_ldq <= _rrd_decode_unit_io_rrd_uop_uses_ldq;
    rrd_uops_0_uses_stq <= _rrd_decode_unit_io_rrd_uop_uses_stq;
    rrd_uops_0_lrs1_rtype <= _rrd_decode_unit_io_rrd_uop_lrs1_rtype;
    rrd_uops_0_lrs2_rtype <= _rrd_decode_unit_io_rrd_uop_lrs2_rtype;
    rrd_uops_0_fp_val <= _rrd_decode_unit_io_rrd_uop_fp_val;
    rrd_valids_1 <= _rrd_decode_unit_1_io_rrd_valid & (io_brupdate_b1_mispredict_mask & _rrd_decode_unit_1_io_rrd_uop_br_mask) == 20'h0;
    rrd_uops_1_uopc <= _rrd_decode_unit_1_io_rrd_uop_uopc;
    rrd_uops_1_fu_code <= _rrd_decode_unit_1_io_rrd_uop_fu_code;
    rrd_uops_1_ctrl_is_load <= _rrd_decode_unit_1_io_rrd_uop_ctrl_is_load;
    rrd_uops_1_ctrl_is_sta <= _rrd_decode_unit_1_io_rrd_uop_ctrl_is_sta;
    rrd_uops_1_ctrl_is_std <= _rrd_decode_unit_1_io_rrd_uop_ctrl_is_std;
    rrd_uops_1_br_mask <= _rrd_decode_unit_1_io_rrd_uop_br_mask & ~io_brupdate_b1_resolve_mask;
    rrd_uops_1_imm_packed <= _rrd_decode_unit_1_io_rrd_uop_imm_packed;
    rrd_uops_1_rob_idx <= _rrd_decode_unit_1_io_rrd_uop_rob_idx;
    rrd_uops_1_ldq_idx <= _rrd_decode_unit_1_io_rrd_uop_ldq_idx;
    rrd_uops_1_stq_idx <= _rrd_decode_unit_1_io_rrd_uop_stq_idx;
    rrd_uops_1_pdst <= _rrd_decode_unit_1_io_rrd_uop_pdst;
    rrd_uops_1_prs1 <= _rrd_decode_unit_1_io_rrd_uop_prs1;
    rrd_uops_1_prs2 <= _rrd_decode_unit_1_io_rrd_uop_prs2;
    rrd_uops_1_mem_cmd <= _rrd_decode_unit_1_io_rrd_uop_mem_cmd;
    rrd_uops_1_mem_size <= _rrd_decode_unit_1_io_rrd_uop_mem_size;
    rrd_uops_1_mem_signed <= _rrd_decode_unit_1_io_rrd_uop_mem_signed;
    rrd_uops_1_is_fence <= _rrd_decode_unit_1_io_rrd_uop_is_fence;
    rrd_uops_1_is_amo <= _rrd_decode_unit_1_io_rrd_uop_is_amo;
    rrd_uops_1_uses_ldq <= _rrd_decode_unit_1_io_rrd_uop_uses_ldq;
    rrd_uops_1_uses_stq <= _rrd_decode_unit_1_io_rrd_uop_uses_stq;
    rrd_uops_1_lrs1_rtype <= _rrd_decode_unit_1_io_rrd_uop_lrs1_rtype;
    rrd_uops_1_lrs2_rtype <= _rrd_decode_unit_1_io_rrd_uop_lrs2_rtype;
    rrd_uops_1_fp_val <= _rrd_decode_unit_1_io_rrd_uop_fp_val;
    rrd_valids_2 <= _rrd_decode_unit_2_io_rrd_valid & (io_brupdate_b1_mispredict_mask & _rrd_decode_unit_2_io_rrd_uop_br_mask) == 20'h0;
    rrd_uops_2_uopc <= _rrd_decode_unit_2_io_rrd_uop_uopc;
    rrd_uops_2_is_rvc <= _rrd_decode_unit_2_io_rrd_uop_is_rvc;
    rrd_uops_2_fu_code <= _rrd_decode_unit_2_io_rrd_uop_fu_code;
    rrd_uops_2_ctrl_br_type <= _rrd_decode_unit_2_io_rrd_uop_ctrl_br_type;
    rrd_uops_2_ctrl_op1_sel <= _rrd_decode_unit_2_io_rrd_uop_ctrl_op1_sel;
    rrd_uops_2_ctrl_op2_sel <= _rrd_decode_unit_2_io_rrd_uop_ctrl_op2_sel;
    rrd_uops_2_ctrl_imm_sel <= _rrd_decode_unit_2_io_rrd_uop_ctrl_imm_sel;
    rrd_uops_2_ctrl_op_fcn <= _rrd_decode_unit_2_io_rrd_uop_ctrl_op_fcn;
    rrd_uops_2_ctrl_fcn_dw <= _rrd_decode_unit_2_io_rrd_uop_ctrl_fcn_dw;
    rrd_uops_2_is_br <= _rrd_decode_unit_2_io_rrd_uop_is_br;
    rrd_uops_2_is_jalr <= _rrd_decode_unit_2_io_rrd_uop_is_jalr;
    rrd_uops_2_is_jal <= _rrd_decode_unit_2_io_rrd_uop_is_jal;
    rrd_uops_2_is_sfb <= _rrd_decode_unit_2_io_rrd_uop_is_sfb;
    rrd_uops_2_br_mask <= _rrd_decode_unit_2_io_rrd_uop_br_mask & ~io_brupdate_b1_resolve_mask;
    rrd_uops_2_br_tag <= _rrd_decode_unit_2_io_rrd_uop_br_tag;
    rrd_uops_2_ftq_idx <= _rrd_decode_unit_2_io_rrd_uop_ftq_idx;
    rrd_uops_2_edge_inst <= _rrd_decode_unit_2_io_rrd_uop_edge_inst;
    rrd_uops_2_pc_lob <= _rrd_decode_unit_2_io_rrd_uop_pc_lob;
    rrd_uops_2_taken <= _rrd_decode_unit_2_io_rrd_uop_taken;
    rrd_uops_2_imm_packed <= _rrd_decode_unit_2_io_rrd_uop_imm_packed;
    rrd_uops_2_rob_idx <= _rrd_decode_unit_2_io_rrd_uop_rob_idx;
    rrd_uops_2_ldq_idx <= _rrd_decode_unit_2_io_rrd_uop_ldq_idx;
    rrd_uops_2_stq_idx <= _rrd_decode_unit_2_io_rrd_uop_stq_idx;
    rrd_uops_2_pdst <= _rrd_decode_unit_2_io_rrd_uop_pdst;
    rrd_uops_2_prs1 <= _rrd_decode_unit_2_io_rrd_uop_prs1;
    rrd_uops_2_prs2 <= _rrd_decode_unit_2_io_rrd_uop_prs2;
    rrd_uops_2_bypassable <= _rrd_decode_unit_2_io_rrd_uop_bypassable;
    rrd_uops_2_is_amo <= _rrd_decode_unit_2_io_rrd_uop_is_amo;
    rrd_uops_2_uses_stq <= _rrd_decode_unit_2_io_rrd_uop_uses_stq;
    rrd_uops_2_dst_rtype <= _rrd_decode_unit_2_io_rrd_uop_dst_rtype;
    rrd_uops_2_lrs1_rtype <= _rrd_decode_unit_2_io_rrd_uop_lrs1_rtype;
    rrd_uops_2_lrs2_rtype <= _rrd_decode_unit_2_io_rrd_uop_lrs2_rtype;
    rrd_uops_2_fp_val <= _rrd_decode_unit_2_io_rrd_uop_fp_val;
    rrd_valids_3 <= _rrd_decode_unit_3_io_rrd_valid & (io_brupdate_b1_mispredict_mask & _rrd_decode_unit_3_io_rrd_uop_br_mask) == 20'h0;
    rrd_uops_3_uopc <= _rrd_decode_unit_3_io_rrd_uop_uopc;
    rrd_uops_3_is_rvc <= _rrd_decode_unit_3_io_rrd_uop_is_rvc;
    rrd_uops_3_fu_code <= _rrd_decode_unit_3_io_rrd_uop_fu_code;
    rrd_uops_3_ctrl_br_type <= _rrd_decode_unit_3_io_rrd_uop_ctrl_br_type;
    rrd_uops_3_ctrl_op1_sel <= _rrd_decode_unit_3_io_rrd_uop_ctrl_op1_sel;
    rrd_uops_3_ctrl_op2_sel <= _rrd_decode_unit_3_io_rrd_uop_ctrl_op2_sel;
    rrd_uops_3_ctrl_imm_sel <= _rrd_decode_unit_3_io_rrd_uop_ctrl_imm_sel;
    rrd_uops_3_ctrl_op_fcn <= _rrd_decode_unit_3_io_rrd_uop_ctrl_op_fcn;
    rrd_uops_3_ctrl_fcn_dw <= _rrd_decode_unit_3_io_rrd_uop_ctrl_fcn_dw;
    rrd_uops_3_ctrl_csr_cmd <= _rrd_decode_unit_3_io_rrd_uop_ctrl_csr_cmd;
    rrd_uops_3_is_br <= _rrd_decode_unit_3_io_rrd_uop_is_br;
    rrd_uops_3_is_jalr <= _rrd_decode_unit_3_io_rrd_uop_is_jalr;
    rrd_uops_3_is_jal <= _rrd_decode_unit_3_io_rrd_uop_is_jal;
    rrd_uops_3_is_sfb <= _rrd_decode_unit_3_io_rrd_uop_is_sfb;
    rrd_uops_3_br_mask <= _rrd_decode_unit_3_io_rrd_uop_br_mask & ~io_brupdate_b1_resolve_mask;
    rrd_uops_3_br_tag <= _rrd_decode_unit_3_io_rrd_uop_br_tag;
    rrd_uops_3_ftq_idx <= _rrd_decode_unit_3_io_rrd_uop_ftq_idx;
    rrd_uops_3_edge_inst <= _rrd_decode_unit_3_io_rrd_uop_edge_inst;
    rrd_uops_3_pc_lob <= _rrd_decode_unit_3_io_rrd_uop_pc_lob;
    rrd_uops_3_taken <= _rrd_decode_unit_3_io_rrd_uop_taken;
    rrd_uops_3_imm_packed <= _rrd_decode_unit_3_io_rrd_uop_imm_packed;
    rrd_uops_3_rob_idx <= _rrd_decode_unit_3_io_rrd_uop_rob_idx;
    rrd_uops_3_ldq_idx <= _rrd_decode_unit_3_io_rrd_uop_ldq_idx;
    rrd_uops_3_stq_idx <= _rrd_decode_unit_3_io_rrd_uop_stq_idx;
    rrd_uops_3_pdst <= _rrd_decode_unit_3_io_rrd_uop_pdst;
    rrd_uops_3_prs1 <= _rrd_decode_unit_3_io_rrd_uop_prs1;
    rrd_uops_3_prs2 <= _rrd_decode_unit_3_io_rrd_uop_prs2;
    rrd_uops_3_bypassable <= _rrd_decode_unit_3_io_rrd_uop_bypassable;
    rrd_uops_3_is_amo <= _rrd_decode_unit_3_io_rrd_uop_is_amo;
    rrd_uops_3_uses_stq <= _rrd_decode_unit_3_io_rrd_uop_uses_stq;
    rrd_uops_3_dst_rtype <= _rrd_decode_unit_3_io_rrd_uop_dst_rtype;
    rrd_uops_3_lrs1_rtype <= _rrd_decode_unit_3_io_rrd_uop_lrs1_rtype;
    rrd_uops_3_lrs2_rtype <= _rrd_decode_unit_3_io_rrd_uop_lrs2_rtype;
    rrd_valids_4 <= _rrd_decode_unit_4_io_rrd_valid & (io_brupdate_b1_mispredict_mask & _rrd_decode_unit_4_io_rrd_uop_br_mask) == 20'h0;
    rrd_uops_4_uopc <= _rrd_decode_unit_4_io_rrd_uop_uopc;
    rrd_uops_4_is_rvc <= _rrd_decode_unit_4_io_rrd_uop_is_rvc;
    rrd_uops_4_fu_code <= _rrd_decode_unit_4_io_rrd_uop_fu_code;
    rrd_uops_4_ctrl_br_type <= _rrd_decode_unit_4_io_rrd_uop_ctrl_br_type;
    rrd_uops_4_ctrl_op1_sel <= _rrd_decode_unit_4_io_rrd_uop_ctrl_op1_sel;
    rrd_uops_4_ctrl_op2_sel <= _rrd_decode_unit_4_io_rrd_uop_ctrl_op2_sel;
    rrd_uops_4_ctrl_imm_sel <= _rrd_decode_unit_4_io_rrd_uop_ctrl_imm_sel;
    rrd_uops_4_ctrl_op_fcn <= _rrd_decode_unit_4_io_rrd_uop_ctrl_op_fcn;
    rrd_uops_4_ctrl_fcn_dw <= _rrd_decode_unit_4_io_rrd_uop_ctrl_fcn_dw;
    rrd_uops_4_is_br <= _rrd_decode_unit_4_io_rrd_uop_is_br;
    rrd_uops_4_is_jalr <= _rrd_decode_unit_4_io_rrd_uop_is_jalr;
    rrd_uops_4_is_jal <= _rrd_decode_unit_4_io_rrd_uop_is_jal;
    rrd_uops_4_is_sfb <= _rrd_decode_unit_4_io_rrd_uop_is_sfb;
    rrd_uops_4_br_mask <= _rrd_decode_unit_4_io_rrd_uop_br_mask & ~io_brupdate_b1_resolve_mask;
    rrd_uops_4_br_tag <= _rrd_decode_unit_4_io_rrd_uop_br_tag;
    rrd_uops_4_ftq_idx <= _rrd_decode_unit_4_io_rrd_uop_ftq_idx;
    rrd_uops_4_edge_inst <= _rrd_decode_unit_4_io_rrd_uop_edge_inst;
    rrd_uops_4_pc_lob <= _rrd_decode_unit_4_io_rrd_uop_pc_lob;
    rrd_uops_4_taken <= _rrd_decode_unit_4_io_rrd_uop_taken;
    rrd_uops_4_imm_packed <= _rrd_decode_unit_4_io_rrd_uop_imm_packed;
    rrd_uops_4_rob_idx <= _rrd_decode_unit_4_io_rrd_uop_rob_idx;
    rrd_uops_4_ldq_idx <= _rrd_decode_unit_4_io_rrd_uop_ldq_idx;
    rrd_uops_4_stq_idx <= _rrd_decode_unit_4_io_rrd_uop_stq_idx;
    rrd_uops_4_pdst <= _rrd_decode_unit_4_io_rrd_uop_pdst;
    rrd_uops_4_prs1 <= _rrd_decode_unit_4_io_rrd_uop_prs1;
    rrd_uops_4_prs2 <= _rrd_decode_unit_4_io_rrd_uop_prs2;
    rrd_uops_4_bypassable <= _rrd_decode_unit_4_io_rrd_uop_bypassable;
    rrd_uops_4_is_amo <= _rrd_decode_unit_4_io_rrd_uop_is_amo;
    rrd_uops_4_uses_stq <= _rrd_decode_unit_4_io_rrd_uop_uses_stq;
    rrd_uops_4_dst_rtype <= _rrd_decode_unit_4_io_rrd_uop_dst_rtype;
    rrd_uops_4_lrs1_rtype <= _rrd_decode_unit_4_io_rrd_uop_lrs1_rtype;
    rrd_uops_4_lrs2_rtype <= _rrd_decode_unit_4_io_rrd_uop_lrs2_rtype;
    rrd_valids_5 <= _rrd_decode_unit_5_io_rrd_valid & (io_brupdate_b1_mispredict_mask & _rrd_decode_unit_5_io_rrd_uop_br_mask) == 20'h0;
    rrd_uops_5_uopc <= _rrd_decode_unit_5_io_rrd_uop_uopc;
    rrd_uops_5_is_rvc <= _rrd_decode_unit_5_io_rrd_uop_is_rvc;
    rrd_uops_5_fu_code <= _rrd_decode_unit_5_io_rrd_uop_fu_code;
    rrd_uops_5_ctrl_br_type <= _rrd_decode_unit_5_io_rrd_uop_ctrl_br_type;
    rrd_uops_5_ctrl_op1_sel <= _rrd_decode_unit_5_io_rrd_uop_ctrl_op1_sel;
    rrd_uops_5_ctrl_op2_sel <= _rrd_decode_unit_5_io_rrd_uop_ctrl_op2_sel;
    rrd_uops_5_ctrl_imm_sel <= _rrd_decode_unit_5_io_rrd_uop_ctrl_imm_sel;
    rrd_uops_5_ctrl_op_fcn <= _rrd_decode_unit_5_io_rrd_uop_ctrl_op_fcn;
    rrd_uops_5_ctrl_fcn_dw <= _rrd_decode_unit_5_io_rrd_uop_ctrl_fcn_dw;
    rrd_uops_5_ctrl_csr_cmd <= _rrd_decode_unit_5_io_rrd_uop_ctrl_csr_cmd;
    rrd_uops_5_is_br <= _rrd_decode_unit_5_io_rrd_uop_is_br;
    rrd_uops_5_is_jalr <= _rrd_decode_unit_5_io_rrd_uop_is_jalr;
    rrd_uops_5_is_jal <= _rrd_decode_unit_5_io_rrd_uop_is_jal;
    rrd_uops_5_is_sfb <= _rrd_decode_unit_5_io_rrd_uop_is_sfb;
    rrd_uops_5_br_mask <= _rrd_decode_unit_5_io_rrd_uop_br_mask & ~io_brupdate_b1_resolve_mask;
    rrd_uops_5_br_tag <= _rrd_decode_unit_5_io_rrd_uop_br_tag;
    rrd_uops_5_ftq_idx <= _rrd_decode_unit_5_io_rrd_uop_ftq_idx;
    rrd_uops_5_edge_inst <= _rrd_decode_unit_5_io_rrd_uop_edge_inst;
    rrd_uops_5_pc_lob <= _rrd_decode_unit_5_io_rrd_uop_pc_lob;
    rrd_uops_5_taken <= _rrd_decode_unit_5_io_rrd_uop_taken;
    rrd_uops_5_imm_packed <= _rrd_decode_unit_5_io_rrd_uop_imm_packed;
    rrd_uops_5_rob_idx <= _rrd_decode_unit_5_io_rrd_uop_rob_idx;
    rrd_uops_5_ldq_idx <= _rrd_decode_unit_5_io_rrd_uop_ldq_idx;
    rrd_uops_5_stq_idx <= _rrd_decode_unit_5_io_rrd_uop_stq_idx;
    rrd_uops_5_pdst <= _rrd_decode_unit_5_io_rrd_uop_pdst;
    rrd_uops_5_prs1 <= _rrd_decode_unit_5_io_rrd_uop_prs1;
    rrd_uops_5_prs2 <= _rrd_decode_unit_5_io_rrd_uop_prs2;
    rrd_uops_5_bypassable <= _rrd_decode_unit_5_io_rrd_uop_bypassable;
    rrd_uops_5_is_amo <= _rrd_decode_unit_5_io_rrd_uop_is_amo;
    rrd_uops_5_uses_stq <= _rrd_decode_unit_5_io_rrd_uop_uses_stq;
    rrd_uops_5_dst_rtype <= _rrd_decode_unit_5_io_rrd_uop_dst_rtype;
    rrd_uops_5_lrs1_rtype <= _rrd_decode_unit_5_io_rrd_uop_lrs1_rtype;
    rrd_uops_5_lrs2_rtype <= _rrd_decode_unit_5_io_rrd_uop_lrs2_rtype;
    rrd_rs1_data_0_REG <= io_iss_uops_0_prs1 == 7'h0;
    rrd_rs2_data_0_REG <= io_iss_uops_0_prs2 == 7'h0;
    rrd_rs1_data_1_REG <= io_iss_uops_1_prs1 == 7'h0;
    rrd_rs2_data_1_REG <= io_iss_uops_1_prs2 == 7'h0;
    rrd_rs1_data_2_REG <= io_iss_uops_2_prs1 == 7'h0;
    rrd_rs2_data_2_REG <= io_iss_uops_2_prs2 == 7'h0;
    rrd_rs1_data_3_REG <= io_iss_uops_3_prs1 == 7'h0;
    rrd_rs2_data_3_REG <= io_iss_uops_3_prs2 == 7'h0;
    rrd_rs1_data_4_REG <= io_iss_uops_4_prs1 == 7'h0;
    rrd_rs2_data_4_REG <= io_iss_uops_4_prs2 == 7'h0;
    rrd_rs1_data_5_REG <= io_iss_uops_5_prs1 == 7'h0;
    rrd_rs2_data_5_REG <= io_iss_uops_5_prs2 == 7'h0;
  end // always @(posedge)
  RegisterReadDecode_2 rrd_decode_unit (
    .io_iss_valid            (io_iss_valids_0),
    .io_iss_uop_uopc         (io_iss_uops_0_uopc),
    .io_iss_uop_fu_code      (io_iss_uops_0_fu_code),
    .io_iss_uop_br_mask      (io_iss_uops_0_br_mask),
    .io_iss_uop_imm_packed   (io_iss_uops_0_imm_packed),
    .io_iss_uop_rob_idx      (io_iss_uops_0_rob_idx),
    .io_iss_uop_ldq_idx      (io_iss_uops_0_ldq_idx),
    .io_iss_uop_stq_idx      (io_iss_uops_0_stq_idx),
    .io_iss_uop_pdst         (io_iss_uops_0_pdst),
    .io_iss_uop_prs1         (io_iss_uops_0_prs1),
    .io_iss_uop_prs2         (io_iss_uops_0_prs2),
    .io_iss_uop_mem_cmd      (io_iss_uops_0_mem_cmd),
    .io_iss_uop_mem_size     (io_iss_uops_0_mem_size),
    .io_iss_uop_mem_signed   (io_iss_uops_0_mem_signed),
    .io_iss_uop_is_fence     (io_iss_uops_0_is_fence),
    .io_iss_uop_is_amo       (io_iss_uops_0_is_amo),
    .io_iss_uop_uses_ldq     (io_iss_uops_0_uses_ldq),
    .io_iss_uop_uses_stq     (io_iss_uops_0_uses_stq),
    .io_iss_uop_lrs1_rtype   (io_iss_uops_0_lrs1_rtype),
    .io_iss_uop_lrs2_rtype   (io_iss_uops_0_lrs2_rtype),
    .io_iss_uop_fp_val       (io_iss_uops_0_fp_val),
    .io_rrd_valid            (_rrd_decode_unit_io_rrd_valid),
    .io_rrd_uop_uopc         (_rrd_decode_unit_io_rrd_uop_uopc),
    .io_rrd_uop_fu_code      (_rrd_decode_unit_io_rrd_uop_fu_code),
    .io_rrd_uop_ctrl_is_load (_rrd_decode_unit_io_rrd_uop_ctrl_is_load),
    .io_rrd_uop_ctrl_is_sta  (_rrd_decode_unit_io_rrd_uop_ctrl_is_sta),
    .io_rrd_uop_ctrl_is_std  (_rrd_decode_unit_io_rrd_uop_ctrl_is_std),
    .io_rrd_uop_br_mask      (_rrd_decode_unit_io_rrd_uop_br_mask),
    .io_rrd_uop_imm_packed   (_rrd_decode_unit_io_rrd_uop_imm_packed),
    .io_rrd_uop_rob_idx      (_rrd_decode_unit_io_rrd_uop_rob_idx),
    .io_rrd_uop_ldq_idx      (_rrd_decode_unit_io_rrd_uop_ldq_idx),
    .io_rrd_uop_stq_idx      (_rrd_decode_unit_io_rrd_uop_stq_idx),
    .io_rrd_uop_pdst         (_rrd_decode_unit_io_rrd_uop_pdst),
    .io_rrd_uop_prs1         (_rrd_decode_unit_io_rrd_uop_prs1),
    .io_rrd_uop_prs2         (_rrd_decode_unit_io_rrd_uop_prs2),
    .io_rrd_uop_mem_cmd      (_rrd_decode_unit_io_rrd_uop_mem_cmd),
    .io_rrd_uop_mem_size     (_rrd_decode_unit_io_rrd_uop_mem_size),
    .io_rrd_uop_mem_signed   (_rrd_decode_unit_io_rrd_uop_mem_signed),
    .io_rrd_uop_is_fence     (_rrd_decode_unit_io_rrd_uop_is_fence),
    .io_rrd_uop_is_amo       (_rrd_decode_unit_io_rrd_uop_is_amo),
    .io_rrd_uop_uses_ldq     (_rrd_decode_unit_io_rrd_uop_uses_ldq),
    .io_rrd_uop_uses_stq     (_rrd_decode_unit_io_rrd_uop_uses_stq),
    .io_rrd_uop_lrs1_rtype   (_rrd_decode_unit_io_rrd_uop_lrs1_rtype),
    .io_rrd_uop_lrs2_rtype   (_rrd_decode_unit_io_rrd_uop_lrs2_rtype),
    .io_rrd_uop_fp_val       (_rrd_decode_unit_io_rrd_uop_fp_val)
  );
  RegisterReadDecode_2 rrd_decode_unit_1 (
    .io_iss_valid            (io_iss_valids_1),
    .io_iss_uop_uopc         (io_iss_uops_1_uopc),
    .io_iss_uop_fu_code      (io_iss_uops_1_fu_code),
    .io_iss_uop_br_mask      (io_iss_uops_1_br_mask),
    .io_iss_uop_imm_packed   (io_iss_uops_1_imm_packed),
    .io_iss_uop_rob_idx      (io_iss_uops_1_rob_idx),
    .io_iss_uop_ldq_idx      (io_iss_uops_1_ldq_idx),
    .io_iss_uop_stq_idx      (io_iss_uops_1_stq_idx),
    .io_iss_uop_pdst         (io_iss_uops_1_pdst),
    .io_iss_uop_prs1         (io_iss_uops_1_prs1),
    .io_iss_uop_prs2         (io_iss_uops_1_prs2),
    .io_iss_uop_mem_cmd      (io_iss_uops_1_mem_cmd),
    .io_iss_uop_mem_size     (io_iss_uops_1_mem_size),
    .io_iss_uop_mem_signed   (io_iss_uops_1_mem_signed),
    .io_iss_uop_is_fence     (io_iss_uops_1_is_fence),
    .io_iss_uop_is_amo       (io_iss_uops_1_is_amo),
    .io_iss_uop_uses_ldq     (io_iss_uops_1_uses_ldq),
    .io_iss_uop_uses_stq     (io_iss_uops_1_uses_stq),
    .io_iss_uop_lrs1_rtype   (io_iss_uops_1_lrs1_rtype),
    .io_iss_uop_lrs2_rtype   (io_iss_uops_1_lrs2_rtype),
    .io_iss_uop_fp_val       (io_iss_uops_1_fp_val),
    .io_rrd_valid            (_rrd_decode_unit_1_io_rrd_valid),
    .io_rrd_uop_uopc         (_rrd_decode_unit_1_io_rrd_uop_uopc),
    .io_rrd_uop_fu_code      (_rrd_decode_unit_1_io_rrd_uop_fu_code),
    .io_rrd_uop_ctrl_is_load (_rrd_decode_unit_1_io_rrd_uop_ctrl_is_load),
    .io_rrd_uop_ctrl_is_sta  (_rrd_decode_unit_1_io_rrd_uop_ctrl_is_sta),
    .io_rrd_uop_ctrl_is_std  (_rrd_decode_unit_1_io_rrd_uop_ctrl_is_std),
    .io_rrd_uop_br_mask      (_rrd_decode_unit_1_io_rrd_uop_br_mask),
    .io_rrd_uop_imm_packed   (_rrd_decode_unit_1_io_rrd_uop_imm_packed),
    .io_rrd_uop_rob_idx      (_rrd_decode_unit_1_io_rrd_uop_rob_idx),
    .io_rrd_uop_ldq_idx      (_rrd_decode_unit_1_io_rrd_uop_ldq_idx),
    .io_rrd_uop_stq_idx      (_rrd_decode_unit_1_io_rrd_uop_stq_idx),
    .io_rrd_uop_pdst         (_rrd_decode_unit_1_io_rrd_uop_pdst),
    .io_rrd_uop_prs1         (_rrd_decode_unit_1_io_rrd_uop_prs1),
    .io_rrd_uop_prs2         (_rrd_decode_unit_1_io_rrd_uop_prs2),
    .io_rrd_uop_mem_cmd      (_rrd_decode_unit_1_io_rrd_uop_mem_cmd),
    .io_rrd_uop_mem_size     (_rrd_decode_unit_1_io_rrd_uop_mem_size),
    .io_rrd_uop_mem_signed   (_rrd_decode_unit_1_io_rrd_uop_mem_signed),
    .io_rrd_uop_is_fence     (_rrd_decode_unit_1_io_rrd_uop_is_fence),
    .io_rrd_uop_is_amo       (_rrd_decode_unit_1_io_rrd_uop_is_amo),
    .io_rrd_uop_uses_ldq     (_rrd_decode_unit_1_io_rrd_uop_uses_ldq),
    .io_rrd_uop_uses_stq     (_rrd_decode_unit_1_io_rrd_uop_uses_stq),
    .io_rrd_uop_lrs1_rtype   (_rrd_decode_unit_1_io_rrd_uop_lrs1_rtype),
    .io_rrd_uop_lrs2_rtype   (_rrd_decode_unit_1_io_rrd_uop_lrs2_rtype),
    .io_rrd_uop_fp_val       (_rrd_decode_unit_1_io_rrd_uop_fp_val)
  );
  RegisterReadDecode_4 rrd_decode_unit_2 (
    .io_iss_valid            (io_iss_valids_2),
    .io_iss_uop_uopc         (io_iss_uops_2_uopc),
    .io_iss_uop_is_rvc       (io_iss_uops_2_is_rvc),
    .io_iss_uop_fu_code      (io_iss_uops_2_fu_code),
    .io_iss_uop_is_br        (io_iss_uops_2_is_br),
    .io_iss_uop_is_jalr      (io_iss_uops_2_is_jalr),
    .io_iss_uop_is_jal       (io_iss_uops_2_is_jal),
    .io_iss_uop_is_sfb       (io_iss_uops_2_is_sfb),
    .io_iss_uop_br_mask      (io_iss_uops_2_br_mask),
    .io_iss_uop_br_tag       (io_iss_uops_2_br_tag),
    .io_iss_uop_ftq_idx      (io_iss_uops_2_ftq_idx),
    .io_iss_uop_edge_inst    (io_iss_uops_2_edge_inst),
    .io_iss_uop_pc_lob       (io_iss_uops_2_pc_lob),
    .io_iss_uop_taken        (io_iss_uops_2_taken),
    .io_iss_uop_imm_packed   (io_iss_uops_2_imm_packed),
    .io_iss_uop_rob_idx      (io_iss_uops_2_rob_idx),
    .io_iss_uop_ldq_idx      (io_iss_uops_2_ldq_idx),
    .io_iss_uop_stq_idx      (io_iss_uops_2_stq_idx),
    .io_iss_uop_pdst         (io_iss_uops_2_pdst),
    .io_iss_uop_prs1         (io_iss_uops_2_prs1),
    .io_iss_uop_prs2         (io_iss_uops_2_prs2),
    .io_iss_uop_bypassable   (io_iss_uops_2_bypassable),
    .io_iss_uop_mem_cmd      (io_iss_uops_2_mem_cmd),
    .io_iss_uop_is_amo       (io_iss_uops_2_is_amo),
    .io_iss_uop_uses_stq     (io_iss_uops_2_uses_stq),
    .io_iss_uop_dst_rtype    (io_iss_uops_2_dst_rtype),
    .io_iss_uop_lrs1_rtype   (io_iss_uops_2_lrs1_rtype),
    .io_iss_uop_lrs2_rtype   (io_iss_uops_2_lrs2_rtype),
    .io_iss_uop_fp_val       (io_iss_uops_2_fp_val),
    .io_rrd_valid            (_rrd_decode_unit_2_io_rrd_valid),
    .io_rrd_uop_uopc         (_rrd_decode_unit_2_io_rrd_uop_uopc),
    .io_rrd_uop_is_rvc       (_rrd_decode_unit_2_io_rrd_uop_is_rvc),
    .io_rrd_uop_fu_code      (_rrd_decode_unit_2_io_rrd_uop_fu_code),
    .io_rrd_uop_ctrl_br_type (_rrd_decode_unit_2_io_rrd_uop_ctrl_br_type),
    .io_rrd_uop_ctrl_op1_sel (_rrd_decode_unit_2_io_rrd_uop_ctrl_op1_sel),
    .io_rrd_uop_ctrl_op2_sel (_rrd_decode_unit_2_io_rrd_uop_ctrl_op2_sel),
    .io_rrd_uop_ctrl_imm_sel (_rrd_decode_unit_2_io_rrd_uop_ctrl_imm_sel),
    .io_rrd_uop_ctrl_op_fcn  (_rrd_decode_unit_2_io_rrd_uop_ctrl_op_fcn),
    .io_rrd_uop_ctrl_fcn_dw  (_rrd_decode_unit_2_io_rrd_uop_ctrl_fcn_dw),
    .io_rrd_uop_is_br        (_rrd_decode_unit_2_io_rrd_uop_is_br),
    .io_rrd_uop_is_jalr      (_rrd_decode_unit_2_io_rrd_uop_is_jalr),
    .io_rrd_uop_is_jal       (_rrd_decode_unit_2_io_rrd_uop_is_jal),
    .io_rrd_uop_is_sfb       (_rrd_decode_unit_2_io_rrd_uop_is_sfb),
    .io_rrd_uop_br_mask      (_rrd_decode_unit_2_io_rrd_uop_br_mask),
    .io_rrd_uop_br_tag       (_rrd_decode_unit_2_io_rrd_uop_br_tag),
    .io_rrd_uop_ftq_idx      (_rrd_decode_unit_2_io_rrd_uop_ftq_idx),
    .io_rrd_uop_edge_inst    (_rrd_decode_unit_2_io_rrd_uop_edge_inst),
    .io_rrd_uop_pc_lob       (_rrd_decode_unit_2_io_rrd_uop_pc_lob),
    .io_rrd_uop_taken        (_rrd_decode_unit_2_io_rrd_uop_taken),
    .io_rrd_uop_imm_packed   (_rrd_decode_unit_2_io_rrd_uop_imm_packed),
    .io_rrd_uop_rob_idx      (_rrd_decode_unit_2_io_rrd_uop_rob_idx),
    .io_rrd_uop_ldq_idx      (_rrd_decode_unit_2_io_rrd_uop_ldq_idx),
    .io_rrd_uop_stq_idx      (_rrd_decode_unit_2_io_rrd_uop_stq_idx),
    .io_rrd_uop_pdst         (_rrd_decode_unit_2_io_rrd_uop_pdst),
    .io_rrd_uop_prs1         (_rrd_decode_unit_2_io_rrd_uop_prs1),
    .io_rrd_uop_prs2         (_rrd_decode_unit_2_io_rrd_uop_prs2),
    .io_rrd_uop_bypassable   (_rrd_decode_unit_2_io_rrd_uop_bypassable),
    .io_rrd_uop_is_amo       (_rrd_decode_unit_2_io_rrd_uop_is_amo),
    .io_rrd_uop_uses_stq     (_rrd_decode_unit_2_io_rrd_uop_uses_stq),
    .io_rrd_uop_dst_rtype    (_rrd_decode_unit_2_io_rrd_uop_dst_rtype),
    .io_rrd_uop_lrs1_rtype   (_rrd_decode_unit_2_io_rrd_uop_lrs1_rtype),
    .io_rrd_uop_lrs2_rtype   (_rrd_decode_unit_2_io_rrd_uop_lrs2_rtype),
    .io_rrd_uop_fp_val       (_rrd_decode_unit_2_io_rrd_uop_fp_val)
  );
  RegisterReadDecode_5 rrd_decode_unit_3 (
    .io_iss_valid            (io_iss_valids_3),
    .io_iss_uop_uopc         (io_iss_uops_3_uopc),
    .io_iss_uop_is_rvc       (io_iss_uops_3_is_rvc),
    .io_iss_uop_fu_code      (io_iss_uops_3_fu_code),
    .io_iss_uop_is_br        (io_iss_uops_3_is_br),
    .io_iss_uop_is_jalr      (io_iss_uops_3_is_jalr),
    .io_iss_uop_is_jal       (io_iss_uops_3_is_jal),
    .io_iss_uop_is_sfb       (io_iss_uops_3_is_sfb),
    .io_iss_uop_br_mask      (io_iss_uops_3_br_mask),
    .io_iss_uop_br_tag       (io_iss_uops_3_br_tag),
    .io_iss_uop_ftq_idx      (io_iss_uops_3_ftq_idx),
    .io_iss_uop_edge_inst    (io_iss_uops_3_edge_inst),
    .io_iss_uop_pc_lob       (io_iss_uops_3_pc_lob),
    .io_iss_uop_taken        (io_iss_uops_3_taken),
    .io_iss_uop_imm_packed   (io_iss_uops_3_imm_packed),
    .io_iss_uop_rob_idx      (io_iss_uops_3_rob_idx),
    .io_iss_uop_ldq_idx      (io_iss_uops_3_ldq_idx),
    .io_iss_uop_stq_idx      (io_iss_uops_3_stq_idx),
    .io_iss_uop_pdst         (io_iss_uops_3_pdst),
    .io_iss_uop_prs1         (io_iss_uops_3_prs1),
    .io_iss_uop_prs2         (io_iss_uops_3_prs2),
    .io_iss_uop_bypassable   (io_iss_uops_3_bypassable),
    .io_iss_uop_mem_cmd      (io_iss_uops_3_mem_cmd),
    .io_iss_uop_is_amo       (io_iss_uops_3_is_amo),
    .io_iss_uop_uses_stq     (io_iss_uops_3_uses_stq),
    .io_iss_uop_dst_rtype    (io_iss_uops_3_dst_rtype),
    .io_iss_uop_lrs1_rtype   (io_iss_uops_3_lrs1_rtype),
    .io_iss_uop_lrs2_rtype   (io_iss_uops_3_lrs2_rtype),
    .io_rrd_valid            (_rrd_decode_unit_3_io_rrd_valid),
    .io_rrd_uop_uopc         (_rrd_decode_unit_3_io_rrd_uop_uopc),
    .io_rrd_uop_is_rvc       (_rrd_decode_unit_3_io_rrd_uop_is_rvc),
    .io_rrd_uop_fu_code      (_rrd_decode_unit_3_io_rrd_uop_fu_code),
    .io_rrd_uop_ctrl_br_type (_rrd_decode_unit_3_io_rrd_uop_ctrl_br_type),
    .io_rrd_uop_ctrl_op1_sel (_rrd_decode_unit_3_io_rrd_uop_ctrl_op1_sel),
    .io_rrd_uop_ctrl_op2_sel (_rrd_decode_unit_3_io_rrd_uop_ctrl_op2_sel),
    .io_rrd_uop_ctrl_imm_sel (_rrd_decode_unit_3_io_rrd_uop_ctrl_imm_sel),
    .io_rrd_uop_ctrl_op_fcn  (_rrd_decode_unit_3_io_rrd_uop_ctrl_op_fcn),
    .io_rrd_uop_ctrl_fcn_dw  (_rrd_decode_unit_3_io_rrd_uop_ctrl_fcn_dw),
    .io_rrd_uop_ctrl_csr_cmd (_rrd_decode_unit_3_io_rrd_uop_ctrl_csr_cmd),
    .io_rrd_uop_is_br        (_rrd_decode_unit_3_io_rrd_uop_is_br),
    .io_rrd_uop_is_jalr      (_rrd_decode_unit_3_io_rrd_uop_is_jalr),
    .io_rrd_uop_is_jal       (_rrd_decode_unit_3_io_rrd_uop_is_jal),
    .io_rrd_uop_is_sfb       (_rrd_decode_unit_3_io_rrd_uop_is_sfb),
    .io_rrd_uop_br_mask      (_rrd_decode_unit_3_io_rrd_uop_br_mask),
    .io_rrd_uop_br_tag       (_rrd_decode_unit_3_io_rrd_uop_br_tag),
    .io_rrd_uop_ftq_idx      (_rrd_decode_unit_3_io_rrd_uop_ftq_idx),
    .io_rrd_uop_edge_inst    (_rrd_decode_unit_3_io_rrd_uop_edge_inst),
    .io_rrd_uop_pc_lob       (_rrd_decode_unit_3_io_rrd_uop_pc_lob),
    .io_rrd_uop_taken        (_rrd_decode_unit_3_io_rrd_uop_taken),
    .io_rrd_uop_imm_packed   (_rrd_decode_unit_3_io_rrd_uop_imm_packed),
    .io_rrd_uop_rob_idx      (_rrd_decode_unit_3_io_rrd_uop_rob_idx),
    .io_rrd_uop_ldq_idx      (_rrd_decode_unit_3_io_rrd_uop_ldq_idx),
    .io_rrd_uop_stq_idx      (_rrd_decode_unit_3_io_rrd_uop_stq_idx),
    .io_rrd_uop_pdst         (_rrd_decode_unit_3_io_rrd_uop_pdst),
    .io_rrd_uop_prs1         (_rrd_decode_unit_3_io_rrd_uop_prs1),
    .io_rrd_uop_prs2         (_rrd_decode_unit_3_io_rrd_uop_prs2),
    .io_rrd_uop_bypassable   (_rrd_decode_unit_3_io_rrd_uop_bypassable),
    .io_rrd_uop_is_amo       (_rrd_decode_unit_3_io_rrd_uop_is_amo),
    .io_rrd_uop_uses_stq     (_rrd_decode_unit_3_io_rrd_uop_uses_stq),
    .io_rrd_uop_dst_rtype    (_rrd_decode_unit_3_io_rrd_uop_dst_rtype),
    .io_rrd_uop_lrs1_rtype   (_rrd_decode_unit_3_io_rrd_uop_lrs1_rtype),
    .io_rrd_uop_lrs2_rtype   (_rrd_decode_unit_3_io_rrd_uop_lrs2_rtype)
  );
  RegisterReadDecode_6 rrd_decode_unit_4 (
    .io_iss_valid            (io_iss_valids_4),
    .io_iss_uop_uopc         (io_iss_uops_4_uopc),
    .io_iss_uop_is_rvc       (io_iss_uops_4_is_rvc),
    .io_iss_uop_fu_code      (io_iss_uops_4_fu_code),
    .io_iss_uop_is_br        (io_iss_uops_4_is_br),
    .io_iss_uop_is_jalr      (io_iss_uops_4_is_jalr),
    .io_iss_uop_is_jal       (io_iss_uops_4_is_jal),
    .io_iss_uop_is_sfb       (io_iss_uops_4_is_sfb),
    .io_iss_uop_br_mask      (io_iss_uops_4_br_mask),
    .io_iss_uop_br_tag       (io_iss_uops_4_br_tag),
    .io_iss_uop_ftq_idx      (io_iss_uops_4_ftq_idx),
    .io_iss_uop_edge_inst    (io_iss_uops_4_edge_inst),
    .io_iss_uop_pc_lob       (io_iss_uops_4_pc_lob),
    .io_iss_uop_taken        (io_iss_uops_4_taken),
    .io_iss_uop_imm_packed   (io_iss_uops_4_imm_packed),
    .io_iss_uop_rob_idx      (io_iss_uops_4_rob_idx),
    .io_iss_uop_ldq_idx      (io_iss_uops_4_ldq_idx),
    .io_iss_uop_stq_idx      (io_iss_uops_4_stq_idx),
    .io_iss_uop_pdst         (io_iss_uops_4_pdst),
    .io_iss_uop_prs1         (io_iss_uops_4_prs1),
    .io_iss_uop_prs2         (io_iss_uops_4_prs2),
    .io_iss_uop_bypassable   (io_iss_uops_4_bypassable),
    .io_iss_uop_mem_cmd      (io_iss_uops_4_mem_cmd),
    .io_iss_uop_is_amo       (io_iss_uops_4_is_amo),
    .io_iss_uop_uses_stq     (io_iss_uops_4_uses_stq),
    .io_iss_uop_dst_rtype    (io_iss_uops_4_dst_rtype),
    .io_iss_uop_lrs1_rtype   (io_iss_uops_4_lrs1_rtype),
    .io_iss_uop_lrs2_rtype   (io_iss_uops_4_lrs2_rtype),
    .io_rrd_valid            (_rrd_decode_unit_4_io_rrd_valid),
    .io_rrd_uop_uopc         (_rrd_decode_unit_4_io_rrd_uop_uopc),
    .io_rrd_uop_is_rvc       (_rrd_decode_unit_4_io_rrd_uop_is_rvc),
    .io_rrd_uop_fu_code      (_rrd_decode_unit_4_io_rrd_uop_fu_code),
    .io_rrd_uop_ctrl_br_type (_rrd_decode_unit_4_io_rrd_uop_ctrl_br_type),
    .io_rrd_uop_ctrl_op1_sel (_rrd_decode_unit_4_io_rrd_uop_ctrl_op1_sel),
    .io_rrd_uop_ctrl_op2_sel (_rrd_decode_unit_4_io_rrd_uop_ctrl_op2_sel),
    .io_rrd_uop_ctrl_imm_sel (_rrd_decode_unit_4_io_rrd_uop_ctrl_imm_sel),
    .io_rrd_uop_ctrl_op_fcn  (_rrd_decode_unit_4_io_rrd_uop_ctrl_op_fcn),
    .io_rrd_uop_ctrl_fcn_dw  (_rrd_decode_unit_4_io_rrd_uop_ctrl_fcn_dw),
    .io_rrd_uop_ctrl_csr_cmd (/* unused */),
    .io_rrd_uop_is_br        (_rrd_decode_unit_4_io_rrd_uop_is_br),
    .io_rrd_uop_is_jalr      (_rrd_decode_unit_4_io_rrd_uop_is_jalr),
    .io_rrd_uop_is_jal       (_rrd_decode_unit_4_io_rrd_uop_is_jal),
    .io_rrd_uop_is_sfb       (_rrd_decode_unit_4_io_rrd_uop_is_sfb),
    .io_rrd_uop_br_mask      (_rrd_decode_unit_4_io_rrd_uop_br_mask),
    .io_rrd_uop_br_tag       (_rrd_decode_unit_4_io_rrd_uop_br_tag),
    .io_rrd_uop_ftq_idx      (_rrd_decode_unit_4_io_rrd_uop_ftq_idx),
    .io_rrd_uop_edge_inst    (_rrd_decode_unit_4_io_rrd_uop_edge_inst),
    .io_rrd_uop_pc_lob       (_rrd_decode_unit_4_io_rrd_uop_pc_lob),
    .io_rrd_uop_taken        (_rrd_decode_unit_4_io_rrd_uop_taken),
    .io_rrd_uop_imm_packed   (_rrd_decode_unit_4_io_rrd_uop_imm_packed),
    .io_rrd_uop_rob_idx      (_rrd_decode_unit_4_io_rrd_uop_rob_idx),
    .io_rrd_uop_ldq_idx      (_rrd_decode_unit_4_io_rrd_uop_ldq_idx),
    .io_rrd_uop_stq_idx      (_rrd_decode_unit_4_io_rrd_uop_stq_idx),
    .io_rrd_uop_pdst         (_rrd_decode_unit_4_io_rrd_uop_pdst),
    .io_rrd_uop_prs1         (_rrd_decode_unit_4_io_rrd_uop_prs1),
    .io_rrd_uop_prs2         (_rrd_decode_unit_4_io_rrd_uop_prs2),
    .io_rrd_uop_bypassable   (_rrd_decode_unit_4_io_rrd_uop_bypassable),
    .io_rrd_uop_is_amo       (_rrd_decode_unit_4_io_rrd_uop_is_amo),
    .io_rrd_uop_uses_stq     (_rrd_decode_unit_4_io_rrd_uop_uses_stq),
    .io_rrd_uop_dst_rtype    (_rrd_decode_unit_4_io_rrd_uop_dst_rtype),
    .io_rrd_uop_lrs1_rtype   (_rrd_decode_unit_4_io_rrd_uop_lrs1_rtype),
    .io_rrd_uop_lrs2_rtype   (_rrd_decode_unit_4_io_rrd_uop_lrs2_rtype)
  );
  RegisterReadDecode_6 rrd_decode_unit_5 (
    .io_iss_valid            (io_iss_valids_5),
    .io_iss_uop_uopc         (io_iss_uops_5_uopc),
    .io_iss_uop_is_rvc       (io_iss_uops_5_is_rvc),
    .io_iss_uop_fu_code      (io_iss_uops_5_fu_code),
    .io_iss_uop_is_br        (io_iss_uops_5_is_br),
    .io_iss_uop_is_jalr      (io_iss_uops_5_is_jalr),
    .io_iss_uop_is_jal       (io_iss_uops_5_is_jal),
    .io_iss_uop_is_sfb       (io_iss_uops_5_is_sfb),
    .io_iss_uop_br_mask      (io_iss_uops_5_br_mask),
    .io_iss_uop_br_tag       (io_iss_uops_5_br_tag),
    .io_iss_uop_ftq_idx      (io_iss_uops_5_ftq_idx),
    .io_iss_uop_edge_inst    (io_iss_uops_5_edge_inst),
    .io_iss_uop_pc_lob       (io_iss_uops_5_pc_lob),
    .io_iss_uop_taken        (io_iss_uops_5_taken),
    .io_iss_uop_imm_packed   (io_iss_uops_5_imm_packed),
    .io_iss_uop_rob_idx      (io_iss_uops_5_rob_idx),
    .io_iss_uop_ldq_idx      (io_iss_uops_5_ldq_idx),
    .io_iss_uop_stq_idx      (io_iss_uops_5_stq_idx),
    .io_iss_uop_pdst         (io_iss_uops_5_pdst),
    .io_iss_uop_prs1         (io_iss_uops_5_prs1),
    .io_iss_uop_prs2         (io_iss_uops_5_prs2),
    .io_iss_uop_bypassable   (io_iss_uops_5_bypassable),
    .io_iss_uop_mem_cmd      (io_iss_uops_5_mem_cmd),
    .io_iss_uop_is_amo       (io_iss_uops_5_is_amo),
    .io_iss_uop_uses_stq     (io_iss_uops_5_uses_stq),
    .io_iss_uop_dst_rtype    (io_iss_uops_5_dst_rtype),
    .io_iss_uop_lrs1_rtype   (io_iss_uops_5_lrs1_rtype),
    .io_iss_uop_lrs2_rtype   (io_iss_uops_5_lrs2_rtype),
    .io_rrd_valid            (_rrd_decode_unit_5_io_rrd_valid),
    .io_rrd_uop_uopc         (_rrd_decode_unit_5_io_rrd_uop_uopc),
    .io_rrd_uop_is_rvc       (_rrd_decode_unit_5_io_rrd_uop_is_rvc),
    .io_rrd_uop_fu_code      (_rrd_decode_unit_5_io_rrd_uop_fu_code),
    .io_rrd_uop_ctrl_br_type (_rrd_decode_unit_5_io_rrd_uop_ctrl_br_type),
    .io_rrd_uop_ctrl_op1_sel (_rrd_decode_unit_5_io_rrd_uop_ctrl_op1_sel),
    .io_rrd_uop_ctrl_op2_sel (_rrd_decode_unit_5_io_rrd_uop_ctrl_op2_sel),
    .io_rrd_uop_ctrl_imm_sel (_rrd_decode_unit_5_io_rrd_uop_ctrl_imm_sel),
    .io_rrd_uop_ctrl_op_fcn  (_rrd_decode_unit_5_io_rrd_uop_ctrl_op_fcn),
    .io_rrd_uop_ctrl_fcn_dw  (_rrd_decode_unit_5_io_rrd_uop_ctrl_fcn_dw),
    .io_rrd_uop_ctrl_csr_cmd (_rrd_decode_unit_5_io_rrd_uop_ctrl_csr_cmd),
    .io_rrd_uop_is_br        (_rrd_decode_unit_5_io_rrd_uop_is_br),
    .io_rrd_uop_is_jalr      (_rrd_decode_unit_5_io_rrd_uop_is_jalr),
    .io_rrd_uop_is_jal       (_rrd_decode_unit_5_io_rrd_uop_is_jal),
    .io_rrd_uop_is_sfb       (_rrd_decode_unit_5_io_rrd_uop_is_sfb),
    .io_rrd_uop_br_mask      (_rrd_decode_unit_5_io_rrd_uop_br_mask),
    .io_rrd_uop_br_tag       (_rrd_decode_unit_5_io_rrd_uop_br_tag),
    .io_rrd_uop_ftq_idx      (_rrd_decode_unit_5_io_rrd_uop_ftq_idx),
    .io_rrd_uop_edge_inst    (_rrd_decode_unit_5_io_rrd_uop_edge_inst),
    .io_rrd_uop_pc_lob       (_rrd_decode_unit_5_io_rrd_uop_pc_lob),
    .io_rrd_uop_taken        (_rrd_decode_unit_5_io_rrd_uop_taken),
    .io_rrd_uop_imm_packed   (_rrd_decode_unit_5_io_rrd_uop_imm_packed),
    .io_rrd_uop_rob_idx      (_rrd_decode_unit_5_io_rrd_uop_rob_idx),
    .io_rrd_uop_ldq_idx      (_rrd_decode_unit_5_io_rrd_uop_ldq_idx),
    .io_rrd_uop_stq_idx      (_rrd_decode_unit_5_io_rrd_uop_stq_idx),
    .io_rrd_uop_pdst         (_rrd_decode_unit_5_io_rrd_uop_pdst),
    .io_rrd_uop_prs1         (_rrd_decode_unit_5_io_rrd_uop_prs1),
    .io_rrd_uop_prs2         (_rrd_decode_unit_5_io_rrd_uop_prs2),
    .io_rrd_uop_bypassable   (_rrd_decode_unit_5_io_rrd_uop_bypassable),
    .io_rrd_uop_is_amo       (_rrd_decode_unit_5_io_rrd_uop_is_amo),
    .io_rrd_uop_uses_stq     (_rrd_decode_unit_5_io_rrd_uop_uses_stq),
    .io_rrd_uop_dst_rtype    (_rrd_decode_unit_5_io_rrd_uop_dst_rtype),
    .io_rrd_uop_lrs1_rtype   (_rrd_decode_unit_5_io_rrd_uop_lrs1_rtype),
    .io_rrd_uop_lrs2_rtype   (_rrd_decode_unit_5_io_rrd_uop_lrs2_rtype)
  );
  assign io_rf_read_ports_0_addr = io_iss_uops_0_prs1;
  assign io_rf_read_ports_1_addr = io_iss_uops_0_prs2;
  assign io_rf_read_ports_2_addr = io_iss_uops_1_prs1;
  assign io_rf_read_ports_3_addr = io_iss_uops_1_prs2;
  assign io_rf_read_ports_4_addr = io_iss_uops_2_prs1;
  assign io_rf_read_ports_5_addr = io_iss_uops_2_prs2;
  assign io_rf_read_ports_6_addr = io_iss_uops_3_prs1;
  assign io_rf_read_ports_7_addr = io_iss_uops_3_prs2;
  assign io_rf_read_ports_8_addr = io_iss_uops_4_prs1;
  assign io_rf_read_ports_9_addr = io_iss_uops_4_prs2;
  assign io_rf_read_ports_10_addr = io_iss_uops_5_prs1;
  assign io_rf_read_ports_11_addr = io_iss_uops_5_prs2;
  assign io_exe_reqs_0_valid = exe_reg_valids_0;
  assign io_exe_reqs_0_bits_uop_uopc = exe_reg_uops_0_uopc;
  assign io_exe_reqs_0_bits_uop_fu_code = exe_reg_uops_0_fu_code;
  assign io_exe_reqs_0_bits_uop_ctrl_is_load = exe_reg_uops_0_ctrl_is_load;
  assign io_exe_reqs_0_bits_uop_ctrl_is_sta = exe_reg_uops_0_ctrl_is_sta;
  assign io_exe_reqs_0_bits_uop_ctrl_is_std = exe_reg_uops_0_ctrl_is_std;
  assign io_exe_reqs_0_bits_uop_br_mask = exe_reg_uops_0_br_mask;
  assign io_exe_reqs_0_bits_uop_imm_packed = exe_reg_uops_0_imm_packed;
  assign io_exe_reqs_0_bits_uop_rob_idx = exe_reg_uops_0_rob_idx;
  assign io_exe_reqs_0_bits_uop_ldq_idx = exe_reg_uops_0_ldq_idx;
  assign io_exe_reqs_0_bits_uop_stq_idx = exe_reg_uops_0_stq_idx;
  assign io_exe_reqs_0_bits_uop_pdst = exe_reg_uops_0_pdst;
  assign io_exe_reqs_0_bits_uop_mem_cmd = exe_reg_uops_0_mem_cmd;
  assign io_exe_reqs_0_bits_uop_mem_size = exe_reg_uops_0_mem_size;
  assign io_exe_reqs_0_bits_uop_mem_signed = exe_reg_uops_0_mem_signed;
  assign io_exe_reqs_0_bits_uop_is_fence = exe_reg_uops_0_is_fence;
  assign io_exe_reqs_0_bits_uop_is_amo = exe_reg_uops_0_is_amo;
  assign io_exe_reqs_0_bits_uop_uses_ldq = exe_reg_uops_0_uses_ldq;
  assign io_exe_reqs_0_bits_uop_uses_stq = exe_reg_uops_0_uses_stq;
  assign io_exe_reqs_0_bits_uop_fp_val = exe_reg_uops_0_fp_val;
  assign io_exe_reqs_0_bits_rs1_data = exe_reg_rs1_data_0;
  assign io_exe_reqs_0_bits_rs2_data = exe_reg_rs2_data_0;
  assign io_exe_reqs_1_valid = exe_reg_valids_1;
  assign io_exe_reqs_1_bits_uop_uopc = exe_reg_uops_1_uopc;
  assign io_exe_reqs_1_bits_uop_fu_code = exe_reg_uops_1_fu_code;
  assign io_exe_reqs_1_bits_uop_ctrl_is_load = exe_reg_uops_1_ctrl_is_load;
  assign io_exe_reqs_1_bits_uop_ctrl_is_sta = exe_reg_uops_1_ctrl_is_sta;
  assign io_exe_reqs_1_bits_uop_ctrl_is_std = exe_reg_uops_1_ctrl_is_std;
  assign io_exe_reqs_1_bits_uop_br_mask = exe_reg_uops_1_br_mask;
  assign io_exe_reqs_1_bits_uop_imm_packed = exe_reg_uops_1_imm_packed;
  assign io_exe_reqs_1_bits_uop_rob_idx = exe_reg_uops_1_rob_idx;
  assign io_exe_reqs_1_bits_uop_ldq_idx = exe_reg_uops_1_ldq_idx;
  assign io_exe_reqs_1_bits_uop_stq_idx = exe_reg_uops_1_stq_idx;
  assign io_exe_reqs_1_bits_uop_pdst = exe_reg_uops_1_pdst;
  assign io_exe_reqs_1_bits_uop_mem_cmd = exe_reg_uops_1_mem_cmd;
  assign io_exe_reqs_1_bits_uop_mem_size = exe_reg_uops_1_mem_size;
  assign io_exe_reqs_1_bits_uop_mem_signed = exe_reg_uops_1_mem_signed;
  assign io_exe_reqs_1_bits_uop_is_fence = exe_reg_uops_1_is_fence;
  assign io_exe_reqs_1_bits_uop_is_amo = exe_reg_uops_1_is_amo;
  assign io_exe_reqs_1_bits_uop_uses_ldq = exe_reg_uops_1_uses_ldq;
  assign io_exe_reqs_1_bits_uop_uses_stq = exe_reg_uops_1_uses_stq;
  assign io_exe_reqs_1_bits_uop_fp_val = exe_reg_uops_1_fp_val;
  assign io_exe_reqs_1_bits_rs1_data = exe_reg_rs1_data_1;
  assign io_exe_reqs_1_bits_rs2_data = exe_reg_rs2_data_1;
  assign io_exe_reqs_2_valid = exe_reg_valids_2;
  assign io_exe_reqs_2_bits_uop_uopc = exe_reg_uops_2_uopc;
  assign io_exe_reqs_2_bits_uop_is_rvc = exe_reg_uops_2_is_rvc;
  assign io_exe_reqs_2_bits_uop_fu_code = exe_reg_uops_2_fu_code;
  assign io_exe_reqs_2_bits_uop_ctrl_br_type = exe_reg_uops_2_ctrl_br_type;
  assign io_exe_reqs_2_bits_uop_ctrl_op1_sel = exe_reg_uops_2_ctrl_op1_sel;
  assign io_exe_reqs_2_bits_uop_ctrl_op2_sel = exe_reg_uops_2_ctrl_op2_sel;
  assign io_exe_reqs_2_bits_uop_ctrl_imm_sel = exe_reg_uops_2_ctrl_imm_sel;
  assign io_exe_reqs_2_bits_uop_ctrl_op_fcn = exe_reg_uops_2_ctrl_op_fcn;
  assign io_exe_reqs_2_bits_uop_ctrl_fcn_dw = exe_reg_uops_2_ctrl_fcn_dw;
  assign io_exe_reqs_2_bits_uop_is_br = exe_reg_uops_2_is_br;
  assign io_exe_reqs_2_bits_uop_is_jalr = exe_reg_uops_2_is_jalr;
  assign io_exe_reqs_2_bits_uop_is_jal = exe_reg_uops_2_is_jal;
  assign io_exe_reqs_2_bits_uop_is_sfb = exe_reg_uops_2_is_sfb;
  assign io_exe_reqs_2_bits_uop_br_mask = exe_reg_uops_2_br_mask;
  assign io_exe_reqs_2_bits_uop_br_tag = exe_reg_uops_2_br_tag;
  assign io_exe_reqs_2_bits_uop_ftq_idx = exe_reg_uops_2_ftq_idx;
  assign io_exe_reqs_2_bits_uop_edge_inst = exe_reg_uops_2_edge_inst;
  assign io_exe_reqs_2_bits_uop_pc_lob = exe_reg_uops_2_pc_lob;
  assign io_exe_reqs_2_bits_uop_taken = exe_reg_uops_2_taken;
  assign io_exe_reqs_2_bits_uop_imm_packed = exe_reg_uops_2_imm_packed;
  assign io_exe_reqs_2_bits_uop_rob_idx = exe_reg_uops_2_rob_idx;
  assign io_exe_reqs_2_bits_uop_ldq_idx = exe_reg_uops_2_ldq_idx;
  assign io_exe_reqs_2_bits_uop_stq_idx = exe_reg_uops_2_stq_idx;
  assign io_exe_reqs_2_bits_uop_pdst = exe_reg_uops_2_pdst;
  assign io_exe_reqs_2_bits_uop_prs1 = exe_reg_uops_2_prs1;
  assign io_exe_reqs_2_bits_uop_bypassable = exe_reg_uops_2_bypassable;
  assign io_exe_reqs_2_bits_uop_is_amo = exe_reg_uops_2_is_amo;
  assign io_exe_reqs_2_bits_uop_uses_stq = exe_reg_uops_2_uses_stq;
  assign io_exe_reqs_2_bits_uop_dst_rtype = exe_reg_uops_2_dst_rtype;
  assign io_exe_reqs_2_bits_uop_fp_val = exe_reg_uops_2_fp_val;
  assign io_exe_reqs_2_bits_rs1_data = exe_reg_rs1_data_2;
  assign io_exe_reqs_2_bits_rs2_data = exe_reg_rs2_data_2;
  assign io_exe_reqs_3_valid = exe_reg_valids_3;
  assign io_exe_reqs_3_bits_uop_uopc = exe_reg_uops_3_uopc;
  assign io_exe_reqs_3_bits_uop_is_rvc = exe_reg_uops_3_is_rvc;
  assign io_exe_reqs_3_bits_uop_fu_code = exe_reg_uops_3_fu_code;
  assign io_exe_reqs_3_bits_uop_ctrl_br_type = exe_reg_uops_3_ctrl_br_type;
  assign io_exe_reqs_3_bits_uop_ctrl_op1_sel = exe_reg_uops_3_ctrl_op1_sel;
  assign io_exe_reqs_3_bits_uop_ctrl_op2_sel = exe_reg_uops_3_ctrl_op2_sel;
  assign io_exe_reqs_3_bits_uop_ctrl_imm_sel = exe_reg_uops_3_ctrl_imm_sel;
  assign io_exe_reqs_3_bits_uop_ctrl_op_fcn = exe_reg_uops_3_ctrl_op_fcn;
  assign io_exe_reqs_3_bits_uop_ctrl_fcn_dw = exe_reg_uops_3_ctrl_fcn_dw;
  assign io_exe_reqs_3_bits_uop_ctrl_csr_cmd = exe_reg_uops_3_ctrl_csr_cmd;
  assign io_exe_reqs_3_bits_uop_is_br = exe_reg_uops_3_is_br;
  assign io_exe_reqs_3_bits_uop_is_jalr = exe_reg_uops_3_is_jalr;
  assign io_exe_reqs_3_bits_uop_is_jal = exe_reg_uops_3_is_jal;
  assign io_exe_reqs_3_bits_uop_is_sfb = exe_reg_uops_3_is_sfb;
  assign io_exe_reqs_3_bits_uop_br_mask = exe_reg_uops_3_br_mask;
  assign io_exe_reqs_3_bits_uop_br_tag = exe_reg_uops_3_br_tag;
  assign io_exe_reqs_3_bits_uop_ftq_idx = exe_reg_uops_3_ftq_idx;
  assign io_exe_reqs_3_bits_uop_edge_inst = exe_reg_uops_3_edge_inst;
  assign io_exe_reqs_3_bits_uop_pc_lob = exe_reg_uops_3_pc_lob;
  assign io_exe_reqs_3_bits_uop_taken = exe_reg_uops_3_taken;
  assign io_exe_reqs_3_bits_uop_imm_packed = exe_reg_uops_3_imm_packed;
  assign io_exe_reqs_3_bits_uop_rob_idx = exe_reg_uops_3_rob_idx;
  assign io_exe_reqs_3_bits_uop_ldq_idx = exe_reg_uops_3_ldq_idx;
  assign io_exe_reqs_3_bits_uop_stq_idx = exe_reg_uops_3_stq_idx;
  assign io_exe_reqs_3_bits_uop_pdst = exe_reg_uops_3_pdst;
  assign io_exe_reqs_3_bits_uop_prs1 = exe_reg_uops_3_prs1;
  assign io_exe_reqs_3_bits_uop_bypassable = exe_reg_uops_3_bypassable;
  assign io_exe_reqs_3_bits_uop_is_amo = exe_reg_uops_3_is_amo;
  assign io_exe_reqs_3_bits_uop_uses_stq = exe_reg_uops_3_uses_stq;
  assign io_exe_reqs_3_bits_uop_dst_rtype = exe_reg_uops_3_dst_rtype;
  assign io_exe_reqs_3_bits_rs1_data = exe_reg_rs1_data_3;
  assign io_exe_reqs_3_bits_rs2_data = exe_reg_rs2_data_3;
  assign io_exe_reqs_4_valid = exe_reg_valids_4;
  assign io_exe_reqs_4_bits_uop_uopc = exe_reg_uops_4_uopc;
  assign io_exe_reqs_4_bits_uop_is_rvc = exe_reg_uops_4_is_rvc;
  assign io_exe_reqs_4_bits_uop_fu_code = exe_reg_uops_4_fu_code;
  assign io_exe_reqs_4_bits_uop_ctrl_br_type = exe_reg_uops_4_ctrl_br_type;
  assign io_exe_reqs_4_bits_uop_ctrl_op1_sel = exe_reg_uops_4_ctrl_op1_sel;
  assign io_exe_reqs_4_bits_uop_ctrl_op2_sel = exe_reg_uops_4_ctrl_op2_sel;
  assign io_exe_reqs_4_bits_uop_ctrl_imm_sel = exe_reg_uops_4_ctrl_imm_sel;
  assign io_exe_reqs_4_bits_uop_ctrl_op_fcn = exe_reg_uops_4_ctrl_op_fcn;
  assign io_exe_reqs_4_bits_uop_ctrl_fcn_dw = exe_reg_uops_4_ctrl_fcn_dw;
  assign io_exe_reqs_4_bits_uop_is_br = exe_reg_uops_4_is_br;
  assign io_exe_reqs_4_bits_uop_is_jalr = exe_reg_uops_4_is_jalr;
  assign io_exe_reqs_4_bits_uop_is_jal = exe_reg_uops_4_is_jal;
  assign io_exe_reqs_4_bits_uop_is_sfb = exe_reg_uops_4_is_sfb;
  assign io_exe_reqs_4_bits_uop_br_mask = exe_reg_uops_4_br_mask;
  assign io_exe_reqs_4_bits_uop_br_tag = exe_reg_uops_4_br_tag;
  assign io_exe_reqs_4_bits_uop_ftq_idx = exe_reg_uops_4_ftq_idx;
  assign io_exe_reqs_4_bits_uop_edge_inst = exe_reg_uops_4_edge_inst;
  assign io_exe_reqs_4_bits_uop_pc_lob = exe_reg_uops_4_pc_lob;
  assign io_exe_reqs_4_bits_uop_taken = exe_reg_uops_4_taken;
  assign io_exe_reqs_4_bits_uop_imm_packed = exe_reg_uops_4_imm_packed;
  assign io_exe_reqs_4_bits_uop_rob_idx = exe_reg_uops_4_rob_idx;
  assign io_exe_reqs_4_bits_uop_ldq_idx = exe_reg_uops_4_ldq_idx;
  assign io_exe_reqs_4_bits_uop_stq_idx = exe_reg_uops_4_stq_idx;
  assign io_exe_reqs_4_bits_uop_pdst = exe_reg_uops_4_pdst;
  assign io_exe_reqs_4_bits_uop_prs1 = exe_reg_uops_4_prs1;
  assign io_exe_reqs_4_bits_uop_bypassable = exe_reg_uops_4_bypassable;
  assign io_exe_reqs_4_bits_uop_is_amo = exe_reg_uops_4_is_amo;
  assign io_exe_reqs_4_bits_uop_uses_stq = exe_reg_uops_4_uses_stq;
  assign io_exe_reqs_4_bits_uop_dst_rtype = exe_reg_uops_4_dst_rtype;
  assign io_exe_reqs_4_bits_rs1_data = exe_reg_rs1_data_4;
  assign io_exe_reqs_4_bits_rs2_data = exe_reg_rs2_data_4;
  assign io_exe_reqs_5_valid = exe_reg_valids_5;
  assign io_exe_reqs_5_bits_uop_uopc = exe_reg_uops_5_uopc;
  assign io_exe_reqs_5_bits_uop_is_rvc = exe_reg_uops_5_is_rvc;
  assign io_exe_reqs_5_bits_uop_fu_code = exe_reg_uops_5_fu_code;
  assign io_exe_reqs_5_bits_uop_ctrl_br_type = exe_reg_uops_5_ctrl_br_type;
  assign io_exe_reqs_5_bits_uop_ctrl_op1_sel = exe_reg_uops_5_ctrl_op1_sel;
  assign io_exe_reqs_5_bits_uop_ctrl_op2_sel = exe_reg_uops_5_ctrl_op2_sel;
  assign io_exe_reqs_5_bits_uop_ctrl_imm_sel = exe_reg_uops_5_ctrl_imm_sel;
  assign io_exe_reqs_5_bits_uop_ctrl_op_fcn = exe_reg_uops_5_ctrl_op_fcn;
  assign io_exe_reqs_5_bits_uop_ctrl_fcn_dw = exe_reg_uops_5_ctrl_fcn_dw;
  assign io_exe_reqs_5_bits_uop_ctrl_csr_cmd = exe_reg_uops_5_ctrl_csr_cmd;
  assign io_exe_reqs_5_bits_uop_is_br = exe_reg_uops_5_is_br;
  assign io_exe_reqs_5_bits_uop_is_jalr = exe_reg_uops_5_is_jalr;
  assign io_exe_reqs_5_bits_uop_is_jal = exe_reg_uops_5_is_jal;
  assign io_exe_reqs_5_bits_uop_is_sfb = exe_reg_uops_5_is_sfb;
  assign io_exe_reqs_5_bits_uop_br_mask = exe_reg_uops_5_br_mask;
  assign io_exe_reqs_5_bits_uop_br_tag = exe_reg_uops_5_br_tag;
  assign io_exe_reqs_5_bits_uop_ftq_idx = exe_reg_uops_5_ftq_idx;
  assign io_exe_reqs_5_bits_uop_edge_inst = exe_reg_uops_5_edge_inst;
  assign io_exe_reqs_5_bits_uop_pc_lob = exe_reg_uops_5_pc_lob;
  assign io_exe_reqs_5_bits_uop_taken = exe_reg_uops_5_taken;
  assign io_exe_reqs_5_bits_uop_imm_packed = exe_reg_uops_5_imm_packed;
  assign io_exe_reqs_5_bits_uop_rob_idx = exe_reg_uops_5_rob_idx;
  assign io_exe_reqs_5_bits_uop_ldq_idx = exe_reg_uops_5_ldq_idx;
  assign io_exe_reqs_5_bits_uop_stq_idx = exe_reg_uops_5_stq_idx;
  assign io_exe_reqs_5_bits_uop_pdst = exe_reg_uops_5_pdst;
  assign io_exe_reqs_5_bits_uop_prs1 = exe_reg_uops_5_prs1;
  assign io_exe_reqs_5_bits_uop_bypassable = exe_reg_uops_5_bypassable;
  assign io_exe_reqs_5_bits_uop_is_amo = exe_reg_uops_5_is_amo;
  assign io_exe_reqs_5_bits_uop_uses_stq = exe_reg_uops_5_uses_stq;
  assign io_exe_reqs_5_bits_uop_dst_rtype = exe_reg_uops_5_dst_rtype;
  assign io_exe_reqs_5_bits_rs1_data = exe_reg_rs1_data_5;
  assign io_exe_reqs_5_bits_rs2_data = exe_reg_rs2_data_5;
endmodule

