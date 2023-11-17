// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BoomCore(
  input         clock,
                reset,
                io_hartid,
                io_interrupts_debug,
                io_interrupts_mtip,
                io_interrupts_msip,
                io_interrupts_meip,
                io_interrupts_seip,
                io_ifu_fetchpacket_valid,
                io_ifu_fetchpacket_bits_uops_0_valid,
  input  [31:0] io_ifu_fetchpacket_bits_uops_0_bits_inst,
  input         io_ifu_fetchpacket_bits_uops_0_bits_is_rvc,
                io_ifu_fetchpacket_bits_uops_0_bits_ctrl_is_load,
                io_ifu_fetchpacket_bits_uops_0_bits_ctrl_is_sta,
                io_ifu_fetchpacket_bits_uops_0_bits_is_sfb,
  input  [5:0]  io_ifu_fetchpacket_bits_uops_0_bits_ftq_idx,
  input         io_ifu_fetchpacket_bits_uops_0_bits_edge_inst,
  input  [5:0]  io_ifu_fetchpacket_bits_uops_0_bits_pc_lob,
  input         io_ifu_fetchpacket_bits_uops_0_bits_taken,
                io_ifu_fetchpacket_bits_uops_0_bits_xcpt_pf_if,
                io_ifu_fetchpacket_bits_uops_0_bits_xcpt_ae_if,
                io_ifu_fetchpacket_bits_uops_0_bits_bp_debug_if,
                io_ifu_fetchpacket_bits_uops_0_bits_bp_xcpt_if,
                io_ifu_fetchpacket_bits_uops_1_valid,
  input  [31:0] io_ifu_fetchpacket_bits_uops_1_bits_inst,
  input         io_ifu_fetchpacket_bits_uops_1_bits_is_rvc,
                io_ifu_fetchpacket_bits_uops_1_bits_ctrl_is_load,
                io_ifu_fetchpacket_bits_uops_1_bits_ctrl_is_sta,
                io_ifu_fetchpacket_bits_uops_1_bits_is_sfb,
  input  [5:0]  io_ifu_fetchpacket_bits_uops_1_bits_ftq_idx,
  input         io_ifu_fetchpacket_bits_uops_1_bits_edge_inst,
  input  [5:0]  io_ifu_fetchpacket_bits_uops_1_bits_pc_lob,
  input         io_ifu_fetchpacket_bits_uops_1_bits_taken,
                io_ifu_fetchpacket_bits_uops_1_bits_xcpt_pf_if,
                io_ifu_fetchpacket_bits_uops_1_bits_xcpt_ae_if,
                io_ifu_fetchpacket_bits_uops_1_bits_bp_debug_if,
                io_ifu_fetchpacket_bits_uops_1_bits_bp_xcpt_if,
                io_ifu_fetchpacket_bits_uops_2_valid,
  input  [31:0] io_ifu_fetchpacket_bits_uops_2_bits_inst,
  input         io_ifu_fetchpacket_bits_uops_2_bits_is_rvc,
                io_ifu_fetchpacket_bits_uops_2_bits_ctrl_is_load,
                io_ifu_fetchpacket_bits_uops_2_bits_ctrl_is_sta,
                io_ifu_fetchpacket_bits_uops_2_bits_is_sfb,
  input  [5:0]  io_ifu_fetchpacket_bits_uops_2_bits_ftq_idx,
  input         io_ifu_fetchpacket_bits_uops_2_bits_edge_inst,
  input  [5:0]  io_ifu_fetchpacket_bits_uops_2_bits_pc_lob,
  input         io_ifu_fetchpacket_bits_uops_2_bits_taken,
                io_ifu_fetchpacket_bits_uops_2_bits_xcpt_pf_if,
                io_ifu_fetchpacket_bits_uops_2_bits_xcpt_ae_if,
                io_ifu_fetchpacket_bits_uops_2_bits_bp_debug_if,
                io_ifu_fetchpacket_bits_uops_2_bits_bp_xcpt_if,
                io_ifu_fetchpacket_bits_uops_3_valid,
  input  [31:0] io_ifu_fetchpacket_bits_uops_3_bits_inst,
  input         io_ifu_fetchpacket_bits_uops_3_bits_is_rvc,
                io_ifu_fetchpacket_bits_uops_3_bits_ctrl_is_load,
                io_ifu_fetchpacket_bits_uops_3_bits_ctrl_is_sta,
                io_ifu_fetchpacket_bits_uops_3_bits_is_sfb,
  input  [5:0]  io_ifu_fetchpacket_bits_uops_3_bits_ftq_idx,
  input         io_ifu_fetchpacket_bits_uops_3_bits_edge_inst,
  input  [5:0]  io_ifu_fetchpacket_bits_uops_3_bits_pc_lob,
  input         io_ifu_fetchpacket_bits_uops_3_bits_taken,
                io_ifu_fetchpacket_bits_uops_3_bits_xcpt_pf_if,
                io_ifu_fetchpacket_bits_uops_3_bits_xcpt_ae_if,
                io_ifu_fetchpacket_bits_uops_3_bits_bp_debug_if,
                io_ifu_fetchpacket_bits_uops_3_bits_bp_xcpt_if,
                io_ifu_get_pc_0_entry_cfi_idx_valid,
  input  [2:0]  io_ifu_get_pc_0_entry_cfi_idx_bits,
  input  [4:0]  io_ifu_get_pc_0_entry_ras_idx,
  input         io_ifu_get_pc_0_entry_start_bank,
  input  [39:0] io_ifu_get_pc_0_pc,
                io_ifu_get_pc_0_com_pc,
  input         io_ifu_get_pc_0_next_val,
  input  [39:0] io_ifu_get_pc_0_next_pc,
  input  [2:0]  io_ifu_get_pc_1_entry_cfi_idx_bits,
  input  [7:0]  io_ifu_get_pc_1_entry_br_mask,
  input         io_ifu_get_pc_1_entry_cfi_is_call,
                io_ifu_get_pc_1_entry_cfi_is_ret,
                io_ifu_get_pc_1_entry_start_bank,
  input  [63:0] io_ifu_get_pc_1_ghist_old_history,
  input         io_ifu_get_pc_1_ghist_current_saw_branch_not_taken,
                io_ifu_get_pc_1_ghist_new_saw_branch_not_taken,
                io_ifu_get_pc_1_ghist_new_saw_branch_taken,
  input  [4:0]  io_ifu_get_pc_1_ghist_ras_idx,
  input  [39:0] io_ifu_get_pc_1_pc,
  input         io_lsu_exe_0_iresp_valid,
  input  [6:0]  io_lsu_exe_0_iresp_bits_uop_rob_idx,
                io_lsu_exe_0_iresp_bits_uop_pdst,
  input         io_lsu_exe_0_iresp_bits_uop_is_amo,
                io_lsu_exe_0_iresp_bits_uop_uses_stq,
  input  [1:0]  io_lsu_exe_0_iresp_bits_uop_dst_rtype,
  input  [63:0] io_lsu_exe_0_iresp_bits_data,
  input         io_lsu_exe_0_fresp_valid,
  input  [6:0]  io_lsu_exe_0_fresp_bits_uop_uopc,
  input  [19:0] io_lsu_exe_0_fresp_bits_uop_br_mask,
  input  [6:0]  io_lsu_exe_0_fresp_bits_uop_rob_idx,
  input  [4:0]  io_lsu_exe_0_fresp_bits_uop_stq_idx,
  input  [6:0]  io_lsu_exe_0_fresp_bits_uop_pdst,
  input  [1:0]  io_lsu_exe_0_fresp_bits_uop_mem_size,
  input         io_lsu_exe_0_fresp_bits_uop_is_amo,
                io_lsu_exe_0_fresp_bits_uop_uses_stq,
  input  [1:0]  io_lsu_exe_0_fresp_bits_uop_dst_rtype,
  input         io_lsu_exe_0_fresp_bits_uop_fp_val,
  input  [64:0] io_lsu_exe_0_fresp_bits_data,
  input         io_lsu_exe_1_iresp_valid,
  input  [6:0]  io_lsu_exe_1_iresp_bits_uop_rob_idx,
                io_lsu_exe_1_iresp_bits_uop_pdst,
  input         io_lsu_exe_1_iresp_bits_uop_is_amo,
                io_lsu_exe_1_iresp_bits_uop_uses_stq,
  input  [1:0]  io_lsu_exe_1_iresp_bits_uop_dst_rtype,
  input  [63:0] io_lsu_exe_1_iresp_bits_data,
  input         io_lsu_exe_1_fresp_valid,
  input  [6:0]  io_lsu_exe_1_fresp_bits_uop_uopc,
  input  [19:0] io_lsu_exe_1_fresp_bits_uop_br_mask,
  input  [6:0]  io_lsu_exe_1_fresp_bits_uop_rob_idx,
  input  [4:0]  io_lsu_exe_1_fresp_bits_uop_stq_idx,
  input  [6:0]  io_lsu_exe_1_fresp_bits_uop_pdst,
  input  [1:0]  io_lsu_exe_1_fresp_bits_uop_mem_size,
  input         io_lsu_exe_1_fresp_bits_uop_is_amo,
                io_lsu_exe_1_fresp_bits_uop_uses_stq,
  input  [1:0]  io_lsu_exe_1_fresp_bits_uop_dst_rtype,
  input         io_lsu_exe_1_fresp_bits_uop_fp_val,
  input  [64:0] io_lsu_exe_1_fresp_bits_data,
  input  [4:0]  io_lsu_dis_ldq_idx_0,
                io_lsu_dis_ldq_idx_1,
                io_lsu_dis_ldq_idx_2,
                io_lsu_dis_ldq_idx_3,
                io_lsu_dis_stq_idx_0,
                io_lsu_dis_stq_idx_1,
                io_lsu_dis_stq_idx_2,
                io_lsu_dis_stq_idx_3,
  input         io_lsu_ldq_full_0,
                io_lsu_ldq_full_1,
                io_lsu_ldq_full_2,
                io_lsu_ldq_full_3,
                io_lsu_stq_full_0,
                io_lsu_stq_full_1,
                io_lsu_stq_full_2,
                io_lsu_stq_full_3,
                io_lsu_fp_stdata_ready,
                io_lsu_clr_bsy_0_valid,
  input  [6:0]  io_lsu_clr_bsy_0_bits,
  input         io_lsu_clr_bsy_1_valid,
  input  [6:0]  io_lsu_clr_bsy_1_bits,
  input         io_lsu_clr_bsy_2_valid,
  input  [6:0]  io_lsu_clr_bsy_2_bits,
  input         io_lsu_spec_ld_wakeup_0_valid,
  input  [6:0]  io_lsu_spec_ld_wakeup_0_bits,
  input         io_lsu_spec_ld_wakeup_1_valid,
  input  [6:0]  io_lsu_spec_ld_wakeup_1_bits,
  input         io_lsu_ld_miss,
                io_lsu_fencei_rdy,
                io_lsu_lxcpt_valid,
  input  [19:0] io_lsu_lxcpt_bits_uop_br_mask,
  input  [6:0]  io_lsu_lxcpt_bits_uop_rob_idx,
  input  [4:0]  io_lsu_lxcpt_bits_cause,
  input  [39:0] io_lsu_lxcpt_bits_badvaddr,
  output        io_ifu_fetchpacket_ready,
  output [5:0]  io_ifu_get_pc_0_ftq_idx,
                io_ifu_get_pc_1_ftq_idx,
  output        io_ifu_sfence_valid,
                io_ifu_sfence_bits_rs1,
                io_ifu_sfence_bits_rs2,
  output [38:0] io_ifu_sfence_bits_addr,
  output [5:0]  io_ifu_brupdate_b2_uop_ftq_idx,
                io_ifu_brupdate_b2_uop_pc_lob,
  output        io_ifu_brupdate_b2_mispredict,
                io_ifu_brupdate_b2_taken,
                io_ifu_redirect_flush,
                io_ifu_redirect_val,
  output [39:0] io_ifu_redirect_pc,
  output [5:0]  io_ifu_redirect_ftq_idx,
  output [63:0] io_ifu_redirect_ghist_old_history,
  output        io_ifu_redirect_ghist_current_saw_branch_not_taken,
                io_ifu_redirect_ghist_new_saw_branch_not_taken,
                io_ifu_redirect_ghist_new_saw_branch_taken,
  output [4:0]  io_ifu_redirect_ghist_ras_idx,
  output        io_ifu_commit_valid,
  output [39:0] io_ifu_commit_bits,
  output        io_ifu_flush_icache,
  output [3:0]  io_ptw_ptbr_mode,
  output [43:0] io_ptw_ptbr_ppn,
  output        io_ptw_sfence_valid,
                io_ptw_sfence_bits_rs1,
                io_ptw_sfence_bits_rs2,
  output [38:0] io_ptw_sfence_bits_addr,
  output        io_ptw_status_debug,
  output [1:0]  io_ptw_status_dprv,
                io_ptw_status_prv,
  output        io_ptw_status_mxr,
                io_ptw_status_sum,
                io_ptw_pmp_0_cfg_l,
  output [1:0]  io_ptw_pmp_0_cfg_a,
  output        io_ptw_pmp_0_cfg_x,
                io_ptw_pmp_0_cfg_w,
                io_ptw_pmp_0_cfg_r,
  output [29:0] io_ptw_pmp_0_addr,
  output [31:0] io_ptw_pmp_0_mask,
  output        io_ptw_pmp_1_cfg_l,
  output [1:0]  io_ptw_pmp_1_cfg_a,
  output        io_ptw_pmp_1_cfg_x,
                io_ptw_pmp_1_cfg_w,
                io_ptw_pmp_1_cfg_r,
  output [29:0] io_ptw_pmp_1_addr,
  output [31:0] io_ptw_pmp_1_mask,
  output        io_ptw_pmp_2_cfg_l,
  output [1:0]  io_ptw_pmp_2_cfg_a,
  output        io_ptw_pmp_2_cfg_x,
                io_ptw_pmp_2_cfg_w,
                io_ptw_pmp_2_cfg_r,
  output [29:0] io_ptw_pmp_2_addr,
  output [31:0] io_ptw_pmp_2_mask,
  output        io_ptw_pmp_3_cfg_l,
  output [1:0]  io_ptw_pmp_3_cfg_a,
  output        io_ptw_pmp_3_cfg_x,
                io_ptw_pmp_3_cfg_w,
                io_ptw_pmp_3_cfg_r,
  output [29:0] io_ptw_pmp_3_addr,
  output [31:0] io_ptw_pmp_3_mask,
  output        io_ptw_pmp_4_cfg_l,
  output [1:0]  io_ptw_pmp_4_cfg_a,
  output        io_ptw_pmp_4_cfg_x,
                io_ptw_pmp_4_cfg_w,
                io_ptw_pmp_4_cfg_r,
  output [29:0] io_ptw_pmp_4_addr,
  output [31:0] io_ptw_pmp_4_mask,
  output        io_ptw_pmp_5_cfg_l,
  output [1:0]  io_ptw_pmp_5_cfg_a,
  output        io_ptw_pmp_5_cfg_x,
                io_ptw_pmp_5_cfg_w,
                io_ptw_pmp_5_cfg_r,
  output [29:0] io_ptw_pmp_5_addr,
  output [31:0] io_ptw_pmp_5_mask,
  output        io_ptw_pmp_6_cfg_l,
  output [1:0]  io_ptw_pmp_6_cfg_a,
  output        io_ptw_pmp_6_cfg_x,
                io_ptw_pmp_6_cfg_w,
                io_ptw_pmp_6_cfg_r,
  output [29:0] io_ptw_pmp_6_addr,
  output [31:0] io_ptw_pmp_6_mask,
  output        io_ptw_pmp_7_cfg_l,
  output [1:0]  io_ptw_pmp_7_cfg_a,
  output        io_ptw_pmp_7_cfg_x,
                io_ptw_pmp_7_cfg_w,
                io_ptw_pmp_7_cfg_r,
  output [29:0] io_ptw_pmp_7_addr,
  output [31:0] io_ptw_pmp_7_mask,
  output        io_lsu_exe_0_req_valid,
                io_lsu_exe_0_req_bits_uop_ctrl_is_load,
                io_lsu_exe_0_req_bits_uop_ctrl_is_sta,
                io_lsu_exe_0_req_bits_uop_ctrl_is_std,
  output [19:0] io_lsu_exe_0_req_bits_uop_br_mask,
  output [6:0]  io_lsu_exe_0_req_bits_uop_rob_idx,
  output [4:0]  io_lsu_exe_0_req_bits_uop_ldq_idx,
                io_lsu_exe_0_req_bits_uop_stq_idx,
  output [6:0]  io_lsu_exe_0_req_bits_uop_pdst,
  output [4:0]  io_lsu_exe_0_req_bits_uop_mem_cmd,
  output [1:0]  io_lsu_exe_0_req_bits_uop_mem_size,
  output        io_lsu_exe_0_req_bits_uop_mem_signed,
                io_lsu_exe_0_req_bits_uop_is_fence,
                io_lsu_exe_0_req_bits_uop_is_amo,
                io_lsu_exe_0_req_bits_uop_uses_ldq,
                io_lsu_exe_0_req_bits_uop_uses_stq,
                io_lsu_exe_0_req_bits_uop_fp_val,
  output [63:0] io_lsu_exe_0_req_bits_data,
  output [39:0] io_lsu_exe_0_req_bits_addr,
  output        io_lsu_exe_0_req_bits_mxcpt_valid,
                io_lsu_exe_0_req_bits_sfence_valid,
                io_lsu_exe_0_req_bits_sfence_bits_rs1,
                io_lsu_exe_0_req_bits_sfence_bits_rs2,
  output [38:0] io_lsu_exe_0_req_bits_sfence_bits_addr,
  output        io_lsu_exe_1_req_valid,
                io_lsu_exe_1_req_bits_uop_ctrl_is_load,
                io_lsu_exe_1_req_bits_uop_ctrl_is_sta,
                io_lsu_exe_1_req_bits_uop_ctrl_is_std,
  output [19:0] io_lsu_exe_1_req_bits_uop_br_mask,
  output [6:0]  io_lsu_exe_1_req_bits_uop_rob_idx,
  output [4:0]  io_lsu_exe_1_req_bits_uop_ldq_idx,
                io_lsu_exe_1_req_bits_uop_stq_idx,
  output [6:0]  io_lsu_exe_1_req_bits_uop_pdst,
  output [4:0]  io_lsu_exe_1_req_bits_uop_mem_cmd,
  output [1:0]  io_lsu_exe_1_req_bits_uop_mem_size,
  output        io_lsu_exe_1_req_bits_uop_mem_signed,
                io_lsu_exe_1_req_bits_uop_is_fence,
                io_lsu_exe_1_req_bits_uop_is_amo,
                io_lsu_exe_1_req_bits_uop_uses_ldq,
                io_lsu_exe_1_req_bits_uop_uses_stq,
                io_lsu_exe_1_req_bits_uop_fp_val,
  output [63:0] io_lsu_exe_1_req_bits_data,
  output [39:0] io_lsu_exe_1_req_bits_addr,
  output        io_lsu_exe_1_req_bits_mxcpt_valid,
                io_lsu_exe_1_req_bits_sfence_valid,
                io_lsu_exe_1_req_bits_sfence_bits_rs1,
                io_lsu_exe_1_req_bits_sfence_bits_rs2,
  output [38:0] io_lsu_exe_1_req_bits_sfence_bits_addr,
  output        io_lsu_dis_uops_0_valid,
  output [6:0]  io_lsu_dis_uops_0_bits_uopc,
  output        io_lsu_dis_uops_0_bits_ctrl_is_load,
                io_lsu_dis_uops_0_bits_ctrl_is_sta,
  output [19:0] io_lsu_dis_uops_0_bits_br_mask,
  output [6:0]  io_lsu_dis_uops_0_bits_rob_idx,
  output [4:0]  io_lsu_dis_uops_0_bits_ldq_idx,
                io_lsu_dis_uops_0_bits_stq_idx,
  output [6:0]  io_lsu_dis_uops_0_bits_pdst,
  output        io_lsu_dis_uops_0_bits_exception,
  output [4:0]  io_lsu_dis_uops_0_bits_mem_cmd,
  output [1:0]  io_lsu_dis_uops_0_bits_mem_size,
  output        io_lsu_dis_uops_0_bits_mem_signed,
                io_lsu_dis_uops_0_bits_is_fence,
                io_lsu_dis_uops_0_bits_is_amo,
                io_lsu_dis_uops_0_bits_uses_ldq,
                io_lsu_dis_uops_0_bits_uses_stq,
  output [1:0]  io_lsu_dis_uops_0_bits_dst_rtype,
  output        io_lsu_dis_uops_0_bits_fp_val,
                io_lsu_dis_uops_1_valid,
  output [6:0]  io_lsu_dis_uops_1_bits_uopc,
  output        io_lsu_dis_uops_1_bits_ctrl_is_load,
                io_lsu_dis_uops_1_bits_ctrl_is_sta,
  output [19:0] io_lsu_dis_uops_1_bits_br_mask,
  output [6:0]  io_lsu_dis_uops_1_bits_rob_idx,
  output [4:0]  io_lsu_dis_uops_1_bits_ldq_idx,
                io_lsu_dis_uops_1_bits_stq_idx,
  output [6:0]  io_lsu_dis_uops_1_bits_pdst,
  output        io_lsu_dis_uops_1_bits_exception,
  output [4:0]  io_lsu_dis_uops_1_bits_mem_cmd,
  output [1:0]  io_lsu_dis_uops_1_bits_mem_size,
  output        io_lsu_dis_uops_1_bits_mem_signed,
                io_lsu_dis_uops_1_bits_is_fence,
                io_lsu_dis_uops_1_bits_is_amo,
                io_lsu_dis_uops_1_bits_uses_ldq,
                io_lsu_dis_uops_1_bits_uses_stq,
  output [1:0]  io_lsu_dis_uops_1_bits_dst_rtype,
  output        io_lsu_dis_uops_1_bits_fp_val,
                io_lsu_dis_uops_2_valid,
  output [6:0]  io_lsu_dis_uops_2_bits_uopc,
  output        io_lsu_dis_uops_2_bits_ctrl_is_load,
                io_lsu_dis_uops_2_bits_ctrl_is_sta,
  output [19:0] io_lsu_dis_uops_2_bits_br_mask,
  output [6:0]  io_lsu_dis_uops_2_bits_rob_idx,
  output [4:0]  io_lsu_dis_uops_2_bits_ldq_idx,
                io_lsu_dis_uops_2_bits_stq_idx,
  output [6:0]  io_lsu_dis_uops_2_bits_pdst,
  output        io_lsu_dis_uops_2_bits_exception,
  output [4:0]  io_lsu_dis_uops_2_bits_mem_cmd,
  output [1:0]  io_lsu_dis_uops_2_bits_mem_size,
  output        io_lsu_dis_uops_2_bits_mem_signed,
                io_lsu_dis_uops_2_bits_is_fence,
                io_lsu_dis_uops_2_bits_is_amo,
                io_lsu_dis_uops_2_bits_uses_ldq,
                io_lsu_dis_uops_2_bits_uses_stq,
  output [1:0]  io_lsu_dis_uops_2_bits_dst_rtype,
  output        io_lsu_dis_uops_2_bits_fp_val,
                io_lsu_dis_uops_3_valid,
  output [6:0]  io_lsu_dis_uops_3_bits_uopc,
  output        io_lsu_dis_uops_3_bits_ctrl_is_load,
                io_lsu_dis_uops_3_bits_ctrl_is_sta,
  output [19:0] io_lsu_dis_uops_3_bits_br_mask,
  output [6:0]  io_lsu_dis_uops_3_bits_rob_idx,
  output [4:0]  io_lsu_dis_uops_3_bits_ldq_idx,
                io_lsu_dis_uops_3_bits_stq_idx,
  output [6:0]  io_lsu_dis_uops_3_bits_pdst,
  output        io_lsu_dis_uops_3_bits_exception,
  output [4:0]  io_lsu_dis_uops_3_bits_mem_cmd,
  output [1:0]  io_lsu_dis_uops_3_bits_mem_size,
  output        io_lsu_dis_uops_3_bits_mem_signed,
                io_lsu_dis_uops_3_bits_is_fence,
                io_lsu_dis_uops_3_bits_is_amo,
                io_lsu_dis_uops_3_bits_uses_ldq,
                io_lsu_dis_uops_3_bits_uses_stq,
  output [1:0]  io_lsu_dis_uops_3_bits_dst_rtype,
  output        io_lsu_dis_uops_3_bits_fp_val,
                io_lsu_fp_stdata_valid,
  output [19:0] io_lsu_fp_stdata_bits_uop_br_mask,
  output [6:0]  io_lsu_fp_stdata_bits_uop_rob_idx,
  output [4:0]  io_lsu_fp_stdata_bits_uop_stq_idx,
  output [63:0] io_lsu_fp_stdata_bits_data,
  output        io_lsu_commit_valids_0,
                io_lsu_commit_valids_1,
                io_lsu_commit_valids_2,
                io_lsu_commit_valids_3,
                io_lsu_commit_uops_0_uses_ldq,
                io_lsu_commit_uops_0_uses_stq,
                io_lsu_commit_uops_1_uses_ldq,
                io_lsu_commit_uops_1_uses_stq,
                io_lsu_commit_uops_2_uses_ldq,
                io_lsu_commit_uops_2_uses_stq,
                io_lsu_commit_uops_3_uses_ldq,
                io_lsu_commit_uops_3_uses_stq,
                io_lsu_commit_load_at_rob_head,
                io_lsu_fence_dmem,
  output [19:0] io_lsu_brupdate_b1_resolve_mask,
                io_lsu_brupdate_b1_mispredict_mask,
  output [4:0]  io_lsu_brupdate_b2_uop_ldq_idx,
                io_lsu_brupdate_b2_uop_stq_idx,
  output        io_lsu_brupdate_b2_mispredict,
  output [6:0]  io_lsu_rob_head_idx,
  output        io_lsu_exception
);

  wire        dis_stalls_3;
  wire        _ftq_arb_io_in_2_ready;
  wire [63:0] _csr_io_rw_rdata;
  wire        _csr_io_decode_0_fp_illegal;
  wire        _csr_io_decode_0_read_illegal;
  wire        _csr_io_decode_0_write_illegal;
  wire        _csr_io_decode_0_write_flush;
  wire        _csr_io_decode_0_system_illegal;
  wire        _csr_io_decode_1_fp_illegal;
  wire        _csr_io_decode_1_read_illegal;
  wire        _csr_io_decode_1_write_illegal;
  wire        _csr_io_decode_1_write_flush;
  wire        _csr_io_decode_1_system_illegal;
  wire        _csr_io_decode_2_fp_illegal;
  wire        _csr_io_decode_2_read_illegal;
  wire        _csr_io_decode_2_write_illegal;
  wire        _csr_io_decode_2_write_flush;
  wire        _csr_io_decode_2_system_illegal;
  wire        _csr_io_decode_3_fp_illegal;
  wire        _csr_io_decode_3_read_illegal;
  wire        _csr_io_decode_3_write_illegal;
  wire        _csr_io_decode_3_write_flush;
  wire        _csr_io_decode_3_system_illegal;
  wire        _csr_io_csr_stall;
  wire        _csr_io_singleStep;
  wire        _csr_io_status_debug;
  wire [39:0] _csr_io_evec;
  wire [2:0]  _csr_io_fcsr_rm;
  wire        _csr_io_interrupt;
  wire [63:0] _csr_io_interrupt_cause;
  wire [63:0] _csr_io_customCSRs_0_value;
  wire [6:0]  _rob_io_rob_tail_idx;
  wire [6:0]  _rob_io_rob_head_idx;
  wire        _rob_io_commit_valids_0;
  wire        _rob_io_commit_valids_1;
  wire        _rob_io_commit_valids_2;
  wire        _rob_io_commit_valids_3;
  wire        _rob_io_commit_arch_valids_0;
  wire        _rob_io_commit_arch_valids_1;
  wire        _rob_io_commit_arch_valids_2;
  wire        _rob_io_commit_arch_valids_3;
  wire [5:0]  _rob_io_commit_uops_0_ftq_idx;
  wire [6:0]  _rob_io_commit_uops_0_pdst;
  wire [6:0]  _rob_io_commit_uops_0_stale_pdst;
  wire        _rob_io_commit_uops_0_is_fencei;
  wire [5:0]  _rob_io_commit_uops_0_ldst;
  wire        _rob_io_commit_uops_0_ldst_val;
  wire [1:0]  _rob_io_commit_uops_0_dst_rtype;
  wire [5:0]  _rob_io_commit_uops_1_ftq_idx;
  wire [6:0]  _rob_io_commit_uops_1_pdst;
  wire [6:0]  _rob_io_commit_uops_1_stale_pdst;
  wire        _rob_io_commit_uops_1_is_fencei;
  wire [5:0]  _rob_io_commit_uops_1_ldst;
  wire        _rob_io_commit_uops_1_ldst_val;
  wire [1:0]  _rob_io_commit_uops_1_dst_rtype;
  wire [5:0]  _rob_io_commit_uops_2_ftq_idx;
  wire [6:0]  _rob_io_commit_uops_2_pdst;
  wire [6:0]  _rob_io_commit_uops_2_stale_pdst;
  wire        _rob_io_commit_uops_2_is_fencei;
  wire [5:0]  _rob_io_commit_uops_2_ldst;
  wire        _rob_io_commit_uops_2_ldst_val;
  wire [1:0]  _rob_io_commit_uops_2_dst_rtype;
  wire [5:0]  _rob_io_commit_uops_3_ftq_idx;
  wire [6:0]  _rob_io_commit_uops_3_pdst;
  wire [6:0]  _rob_io_commit_uops_3_stale_pdst;
  wire        _rob_io_commit_uops_3_is_fencei;
  wire [5:0]  _rob_io_commit_uops_3_ldst;
  wire        _rob_io_commit_uops_3_ldst_val;
  wire [1:0]  _rob_io_commit_uops_3_dst_rtype;
  wire        _rob_io_commit_fflags_valid;
  wire [4:0]  _rob_io_commit_fflags_bits;
  wire        _rob_io_commit_rbk_valids_0;
  wire        _rob_io_commit_rbk_valids_1;
  wire        _rob_io_commit_rbk_valids_2;
  wire        _rob_io_commit_rbk_valids_3;
  wire        _rob_io_commit_rollback;
  wire        _rob_io_com_xcpt_valid;
  wire [5:0]  _rob_io_com_xcpt_bits_ftq_idx;
  wire        _rob_io_com_xcpt_bits_edge_inst;
  wire [5:0]  _rob_io_com_xcpt_bits_pc_lob;
  wire [63:0] _rob_io_com_xcpt_bits_cause;
  wire [63:0] _rob_io_com_xcpt_bits_badvaddr;
  wire        _rob_io_flush_valid;
  wire [5:0]  _rob_io_flush_bits_ftq_idx;
  wire        _rob_io_flush_bits_edge_inst;
  wire        _rob_io_flush_bits_is_rvc;
  wire [5:0]  _rob_io_flush_bits_pc_lob;
  wire [2:0]  _rob_io_flush_bits_flush_typ;
  wire        _rob_io_empty;
  wire        _rob_io_ready;
  wire        _rob_io_flush_frontend;
  wire [6:0]  _iregister_read_io_rf_read_ports_0_addr;
  wire [6:0]  _iregister_read_io_rf_read_ports_1_addr;
  wire [6:0]  _iregister_read_io_rf_read_ports_2_addr;
  wire [6:0]  _iregister_read_io_rf_read_ports_3_addr;
  wire [6:0]  _iregister_read_io_rf_read_ports_4_addr;
  wire [6:0]  _iregister_read_io_rf_read_ports_5_addr;
  wire [6:0]  _iregister_read_io_rf_read_ports_6_addr;
  wire [6:0]  _iregister_read_io_rf_read_ports_7_addr;
  wire [6:0]  _iregister_read_io_rf_read_ports_8_addr;
  wire [6:0]  _iregister_read_io_rf_read_ports_9_addr;
  wire [6:0]  _iregister_read_io_rf_read_ports_10_addr;
  wire [6:0]  _iregister_read_io_rf_read_ports_11_addr;
  wire        _iregister_read_io_exe_reqs_0_valid;
  wire [6:0]  _iregister_read_io_exe_reqs_0_bits_uop_uopc;
  wire [9:0]  _iregister_read_io_exe_reqs_0_bits_uop_fu_code;
  wire        _iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_load;
  wire        _iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_sta;
  wire        _iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_std;
  wire [19:0] _iregister_read_io_exe_reqs_0_bits_uop_br_mask;
  wire [19:0] _iregister_read_io_exe_reqs_0_bits_uop_imm_packed;
  wire [6:0]  _iregister_read_io_exe_reqs_0_bits_uop_rob_idx;
  wire [4:0]  _iregister_read_io_exe_reqs_0_bits_uop_ldq_idx;
  wire [4:0]  _iregister_read_io_exe_reqs_0_bits_uop_stq_idx;
  wire [6:0]  _iregister_read_io_exe_reqs_0_bits_uop_pdst;
  wire [4:0]  _iregister_read_io_exe_reqs_0_bits_uop_mem_cmd;
  wire [1:0]  _iregister_read_io_exe_reqs_0_bits_uop_mem_size;
  wire        _iregister_read_io_exe_reqs_0_bits_uop_mem_signed;
  wire        _iregister_read_io_exe_reqs_0_bits_uop_is_fence;
  wire        _iregister_read_io_exe_reqs_0_bits_uop_is_amo;
  wire        _iregister_read_io_exe_reqs_0_bits_uop_uses_ldq;
  wire        _iregister_read_io_exe_reqs_0_bits_uop_uses_stq;
  wire        _iregister_read_io_exe_reqs_0_bits_uop_fp_val;
  wire [63:0] _iregister_read_io_exe_reqs_0_bits_rs1_data;
  wire [63:0] _iregister_read_io_exe_reqs_0_bits_rs2_data;
  wire        _iregister_read_io_exe_reqs_1_valid;
  wire [6:0]  _iregister_read_io_exe_reqs_1_bits_uop_uopc;
  wire [9:0]  _iregister_read_io_exe_reqs_1_bits_uop_fu_code;
  wire        _iregister_read_io_exe_reqs_1_bits_uop_ctrl_is_load;
  wire        _iregister_read_io_exe_reqs_1_bits_uop_ctrl_is_sta;
  wire        _iregister_read_io_exe_reqs_1_bits_uop_ctrl_is_std;
  wire [19:0] _iregister_read_io_exe_reqs_1_bits_uop_br_mask;
  wire [19:0] _iregister_read_io_exe_reqs_1_bits_uop_imm_packed;
  wire [6:0]  _iregister_read_io_exe_reqs_1_bits_uop_rob_idx;
  wire [4:0]  _iregister_read_io_exe_reqs_1_bits_uop_ldq_idx;
  wire [4:0]  _iregister_read_io_exe_reqs_1_bits_uop_stq_idx;
  wire [6:0]  _iregister_read_io_exe_reqs_1_bits_uop_pdst;
  wire [4:0]  _iregister_read_io_exe_reqs_1_bits_uop_mem_cmd;
  wire [1:0]  _iregister_read_io_exe_reqs_1_bits_uop_mem_size;
  wire        _iregister_read_io_exe_reqs_1_bits_uop_mem_signed;
  wire        _iregister_read_io_exe_reqs_1_bits_uop_is_fence;
  wire        _iregister_read_io_exe_reqs_1_bits_uop_is_amo;
  wire        _iregister_read_io_exe_reqs_1_bits_uop_uses_ldq;
  wire        _iregister_read_io_exe_reqs_1_bits_uop_uses_stq;
  wire        _iregister_read_io_exe_reqs_1_bits_uop_fp_val;
  wire [63:0] _iregister_read_io_exe_reqs_1_bits_rs1_data;
  wire [63:0] _iregister_read_io_exe_reqs_1_bits_rs2_data;
  wire        _iregister_read_io_exe_reqs_2_valid;
  wire [6:0]  _iregister_read_io_exe_reqs_2_bits_uop_uopc;
  wire        _iregister_read_io_exe_reqs_2_bits_uop_is_rvc;
  wire [9:0]  _iregister_read_io_exe_reqs_2_bits_uop_fu_code;
  wire [3:0]  _iregister_read_io_exe_reqs_2_bits_uop_ctrl_br_type;
  wire [1:0]  _iregister_read_io_exe_reqs_2_bits_uop_ctrl_op1_sel;
  wire [2:0]  _iregister_read_io_exe_reqs_2_bits_uop_ctrl_op2_sel;
  wire [2:0]  _iregister_read_io_exe_reqs_2_bits_uop_ctrl_imm_sel;
  wire [3:0]  _iregister_read_io_exe_reqs_2_bits_uop_ctrl_op_fcn;
  wire        _iregister_read_io_exe_reqs_2_bits_uop_ctrl_fcn_dw;
  wire        _iregister_read_io_exe_reqs_2_bits_uop_is_br;
  wire        _iregister_read_io_exe_reqs_2_bits_uop_is_jalr;
  wire        _iregister_read_io_exe_reqs_2_bits_uop_is_jal;
  wire        _iregister_read_io_exe_reqs_2_bits_uop_is_sfb;
  wire [19:0] _iregister_read_io_exe_reqs_2_bits_uop_br_mask;
  wire [4:0]  _iregister_read_io_exe_reqs_2_bits_uop_br_tag;
  wire [5:0]  _iregister_read_io_exe_reqs_2_bits_uop_ftq_idx;
  wire        _iregister_read_io_exe_reqs_2_bits_uop_edge_inst;
  wire [5:0]  _iregister_read_io_exe_reqs_2_bits_uop_pc_lob;
  wire        _iregister_read_io_exe_reqs_2_bits_uop_taken;
  wire [19:0] _iregister_read_io_exe_reqs_2_bits_uop_imm_packed;
  wire [6:0]  _iregister_read_io_exe_reqs_2_bits_uop_rob_idx;
  wire [4:0]  _iregister_read_io_exe_reqs_2_bits_uop_ldq_idx;
  wire [4:0]  _iregister_read_io_exe_reqs_2_bits_uop_stq_idx;
  wire [6:0]  _iregister_read_io_exe_reqs_2_bits_uop_pdst;
  wire [6:0]  _iregister_read_io_exe_reqs_2_bits_uop_prs1;
  wire        _iregister_read_io_exe_reqs_2_bits_uop_bypassable;
  wire        _iregister_read_io_exe_reqs_2_bits_uop_is_amo;
  wire        _iregister_read_io_exe_reqs_2_bits_uop_uses_stq;
  wire [1:0]  _iregister_read_io_exe_reqs_2_bits_uop_dst_rtype;
  wire        _iregister_read_io_exe_reqs_2_bits_uop_fp_val;
  wire [63:0] _iregister_read_io_exe_reqs_2_bits_rs1_data;
  wire [63:0] _iregister_read_io_exe_reqs_2_bits_rs2_data;
  wire        _iregister_read_io_exe_reqs_3_valid;
  wire [6:0]  _iregister_read_io_exe_reqs_3_bits_uop_uopc;
  wire        _iregister_read_io_exe_reqs_3_bits_uop_is_rvc;
  wire [9:0]  _iregister_read_io_exe_reqs_3_bits_uop_fu_code;
  wire [3:0]  _iregister_read_io_exe_reqs_3_bits_uop_ctrl_br_type;
  wire [1:0]  _iregister_read_io_exe_reqs_3_bits_uop_ctrl_op1_sel;
  wire [2:0]  _iregister_read_io_exe_reqs_3_bits_uop_ctrl_op2_sel;
  wire [2:0]  _iregister_read_io_exe_reqs_3_bits_uop_ctrl_imm_sel;
  wire [3:0]  _iregister_read_io_exe_reqs_3_bits_uop_ctrl_op_fcn;
  wire        _iregister_read_io_exe_reqs_3_bits_uop_ctrl_fcn_dw;
  wire [2:0]  _iregister_read_io_exe_reqs_3_bits_uop_ctrl_csr_cmd;
  wire        _iregister_read_io_exe_reqs_3_bits_uop_is_br;
  wire        _iregister_read_io_exe_reqs_3_bits_uop_is_jalr;
  wire        _iregister_read_io_exe_reqs_3_bits_uop_is_jal;
  wire        _iregister_read_io_exe_reqs_3_bits_uop_is_sfb;
  wire [19:0] _iregister_read_io_exe_reqs_3_bits_uop_br_mask;
  wire [4:0]  _iregister_read_io_exe_reqs_3_bits_uop_br_tag;
  wire [5:0]  _iregister_read_io_exe_reqs_3_bits_uop_ftq_idx;
  wire        _iregister_read_io_exe_reqs_3_bits_uop_edge_inst;
  wire [5:0]  _iregister_read_io_exe_reqs_3_bits_uop_pc_lob;
  wire        _iregister_read_io_exe_reqs_3_bits_uop_taken;
  wire [19:0] _iregister_read_io_exe_reqs_3_bits_uop_imm_packed;
  wire [6:0]  _iregister_read_io_exe_reqs_3_bits_uop_rob_idx;
  wire [4:0]  _iregister_read_io_exe_reqs_3_bits_uop_ldq_idx;
  wire [4:0]  _iregister_read_io_exe_reqs_3_bits_uop_stq_idx;
  wire [6:0]  _iregister_read_io_exe_reqs_3_bits_uop_pdst;
  wire [6:0]  _iregister_read_io_exe_reqs_3_bits_uop_prs1;
  wire        _iregister_read_io_exe_reqs_3_bits_uop_bypassable;
  wire        _iregister_read_io_exe_reqs_3_bits_uop_is_amo;
  wire        _iregister_read_io_exe_reqs_3_bits_uop_uses_stq;
  wire [1:0]  _iregister_read_io_exe_reqs_3_bits_uop_dst_rtype;
  wire [63:0] _iregister_read_io_exe_reqs_3_bits_rs1_data;
  wire [63:0] _iregister_read_io_exe_reqs_3_bits_rs2_data;
  wire        _iregister_read_io_exe_reqs_4_valid;
  wire [6:0]  _iregister_read_io_exe_reqs_4_bits_uop_uopc;
  wire        _iregister_read_io_exe_reqs_4_bits_uop_is_rvc;
  wire [9:0]  _iregister_read_io_exe_reqs_4_bits_uop_fu_code;
  wire [3:0]  _iregister_read_io_exe_reqs_4_bits_uop_ctrl_br_type;
  wire [1:0]  _iregister_read_io_exe_reqs_4_bits_uop_ctrl_op1_sel;
  wire [2:0]  _iregister_read_io_exe_reqs_4_bits_uop_ctrl_op2_sel;
  wire [2:0]  _iregister_read_io_exe_reqs_4_bits_uop_ctrl_imm_sel;
  wire [3:0]  _iregister_read_io_exe_reqs_4_bits_uop_ctrl_op_fcn;
  wire        _iregister_read_io_exe_reqs_4_bits_uop_ctrl_fcn_dw;
  wire        _iregister_read_io_exe_reqs_4_bits_uop_is_br;
  wire        _iregister_read_io_exe_reqs_4_bits_uop_is_jalr;
  wire        _iregister_read_io_exe_reqs_4_bits_uop_is_jal;
  wire        _iregister_read_io_exe_reqs_4_bits_uop_is_sfb;
  wire [19:0] _iregister_read_io_exe_reqs_4_bits_uop_br_mask;
  wire [4:0]  _iregister_read_io_exe_reqs_4_bits_uop_br_tag;
  wire [5:0]  _iregister_read_io_exe_reqs_4_bits_uop_ftq_idx;
  wire        _iregister_read_io_exe_reqs_4_bits_uop_edge_inst;
  wire [5:0]  _iregister_read_io_exe_reqs_4_bits_uop_pc_lob;
  wire        _iregister_read_io_exe_reqs_4_bits_uop_taken;
  wire [19:0] _iregister_read_io_exe_reqs_4_bits_uop_imm_packed;
  wire [6:0]  _iregister_read_io_exe_reqs_4_bits_uop_rob_idx;
  wire [4:0]  _iregister_read_io_exe_reqs_4_bits_uop_ldq_idx;
  wire [4:0]  _iregister_read_io_exe_reqs_4_bits_uop_stq_idx;
  wire [6:0]  _iregister_read_io_exe_reqs_4_bits_uop_pdst;
  wire [6:0]  _iregister_read_io_exe_reqs_4_bits_uop_prs1;
  wire        _iregister_read_io_exe_reqs_4_bits_uop_bypassable;
  wire        _iregister_read_io_exe_reqs_4_bits_uop_is_amo;
  wire        _iregister_read_io_exe_reqs_4_bits_uop_uses_stq;
  wire [1:0]  _iregister_read_io_exe_reqs_4_bits_uop_dst_rtype;
  wire [63:0] _iregister_read_io_exe_reqs_4_bits_rs1_data;
  wire [63:0] _iregister_read_io_exe_reqs_4_bits_rs2_data;
  wire        _iregister_read_io_exe_reqs_5_valid;
  wire [6:0]  _iregister_read_io_exe_reqs_5_bits_uop_uopc;
  wire        _iregister_read_io_exe_reqs_5_bits_uop_is_rvc;
  wire [9:0]  _iregister_read_io_exe_reqs_5_bits_uop_fu_code;
  wire [3:0]  _iregister_read_io_exe_reqs_5_bits_uop_ctrl_br_type;
  wire [1:0]  _iregister_read_io_exe_reqs_5_bits_uop_ctrl_op1_sel;
  wire [2:0]  _iregister_read_io_exe_reqs_5_bits_uop_ctrl_op2_sel;
  wire [2:0]  _iregister_read_io_exe_reqs_5_bits_uop_ctrl_imm_sel;
  wire [3:0]  _iregister_read_io_exe_reqs_5_bits_uop_ctrl_op_fcn;
  wire        _iregister_read_io_exe_reqs_5_bits_uop_ctrl_fcn_dw;
  wire [2:0]  _iregister_read_io_exe_reqs_5_bits_uop_ctrl_csr_cmd;
  wire        _iregister_read_io_exe_reqs_5_bits_uop_is_br;
  wire        _iregister_read_io_exe_reqs_5_bits_uop_is_jalr;
  wire        _iregister_read_io_exe_reqs_5_bits_uop_is_jal;
  wire        _iregister_read_io_exe_reqs_5_bits_uop_is_sfb;
  wire [19:0] _iregister_read_io_exe_reqs_5_bits_uop_br_mask;
  wire [4:0]  _iregister_read_io_exe_reqs_5_bits_uop_br_tag;
  wire [5:0]  _iregister_read_io_exe_reqs_5_bits_uop_ftq_idx;
  wire        _iregister_read_io_exe_reqs_5_bits_uop_edge_inst;
  wire [5:0]  _iregister_read_io_exe_reqs_5_bits_uop_pc_lob;
  wire        _iregister_read_io_exe_reqs_5_bits_uop_taken;
  wire [19:0] _iregister_read_io_exe_reqs_5_bits_uop_imm_packed;
  wire [6:0]  _iregister_read_io_exe_reqs_5_bits_uop_rob_idx;
  wire [4:0]  _iregister_read_io_exe_reqs_5_bits_uop_ldq_idx;
  wire [4:0]  _iregister_read_io_exe_reqs_5_bits_uop_stq_idx;
  wire [6:0]  _iregister_read_io_exe_reqs_5_bits_uop_pdst;
  wire [6:0]  _iregister_read_io_exe_reqs_5_bits_uop_prs1;
  wire        _iregister_read_io_exe_reqs_5_bits_uop_bypassable;
  wire        _iregister_read_io_exe_reqs_5_bits_uop_is_amo;
  wire        _iregister_read_io_exe_reqs_5_bits_uop_uses_stq;
  wire [1:0]  _iregister_read_io_exe_reqs_5_bits_uop_dst_rtype;
  wire [63:0] _iregister_read_io_exe_reqs_5_bits_rs1_data;
  wire [63:0] _iregister_read_io_exe_reqs_5_bits_rs2_data;
  wire        _ll_wbarb_io_in_1_ready;
  wire        _ll_wbarb_io_out_valid;
  wire [6:0]  _ll_wbarb_io_out_bits_uop_rob_idx;
  wire [6:0]  _ll_wbarb_io_out_bits_uop_pdst;
  wire        _ll_wbarb_io_out_bits_uop_is_amo;
  wire        _ll_wbarb_io_out_bits_uop_uses_stq;
  wire [1:0]  _ll_wbarb_io_out_bits_uop_dst_rtype;
  wire [63:0] _ll_wbarb_io_out_bits_data;
  wire        _ll_wbarb_io_out_bits_predicated;
  wire [63:0] _iregfile_io_read_ports_0_data;
  wire [63:0] _iregfile_io_read_ports_1_data;
  wire [63:0] _iregfile_io_read_ports_2_data;
  wire [63:0] _iregfile_io_read_ports_3_data;
  wire [63:0] _iregfile_io_read_ports_4_data;
  wire [63:0] _iregfile_io_read_ports_5_data;
  wire [63:0] _iregfile_io_read_ports_6_data;
  wire [63:0] _iregfile_io_read_ports_7_data;
  wire [63:0] _iregfile_io_read_ports_8_data;
  wire [63:0] _iregfile_io_read_ports_9_data;
  wire [63:0] _iregfile_io_read_ports_10_data;
  wire [63:0] _iregfile_io_read_ports_11_data;
  wire        _dispatcher_io_ren_uops_0_ready;
  wire        _dispatcher_io_ren_uops_1_ready;
  wire        _dispatcher_io_ren_uops_2_ready;
  wire        _dispatcher_io_ren_uops_3_ready;
  wire        _dispatcher_io_dis_uops_2_0_valid;
  wire [6:0]  _dispatcher_io_dis_uops_2_0_bits_uopc;
  wire [9:0]  _dispatcher_io_dis_uops_2_0_bits_fu_code;
  wire [19:0] _dispatcher_io_dis_uops_2_0_bits_br_mask;
  wire [19:0] _dispatcher_io_dis_uops_2_0_bits_imm_packed;
  wire [6:0]  _dispatcher_io_dis_uops_2_0_bits_rob_idx;
  wire [4:0]  _dispatcher_io_dis_uops_2_0_bits_stq_idx;
  wire [6:0]  _dispatcher_io_dis_uops_2_0_bits_pdst;
  wire [6:0]  _dispatcher_io_dis_uops_2_0_bits_prs1;
  wire [6:0]  _dispatcher_io_dis_uops_2_0_bits_prs2;
  wire [6:0]  _dispatcher_io_dis_uops_2_0_bits_prs3;
  wire        _dispatcher_io_dis_uops_2_0_bits_prs1_busy;
  wire        _dispatcher_io_dis_uops_2_0_bits_prs2_busy;
  wire        _dispatcher_io_dis_uops_2_0_bits_prs3_busy;
  wire        _dispatcher_io_dis_uops_2_0_bits_exception;
  wire [4:0]  _dispatcher_io_dis_uops_2_0_bits_mem_cmd;
  wire        _dispatcher_io_dis_uops_2_0_bits_is_fence;
  wire        _dispatcher_io_dis_uops_2_0_bits_is_fencei;
  wire        _dispatcher_io_dis_uops_2_0_bits_is_amo;
  wire        _dispatcher_io_dis_uops_2_0_bits_uses_ldq;
  wire        _dispatcher_io_dis_uops_2_0_bits_uses_stq;
  wire [1:0]  _dispatcher_io_dis_uops_2_0_bits_dst_rtype;
  wire        _dispatcher_io_dis_uops_2_0_bits_fp_val;
  wire        _dispatcher_io_dis_uops_2_1_valid;
  wire [6:0]  _dispatcher_io_dis_uops_2_1_bits_uopc;
  wire [9:0]  _dispatcher_io_dis_uops_2_1_bits_fu_code;
  wire [19:0] _dispatcher_io_dis_uops_2_1_bits_br_mask;
  wire [19:0] _dispatcher_io_dis_uops_2_1_bits_imm_packed;
  wire [6:0]  _dispatcher_io_dis_uops_2_1_bits_rob_idx;
  wire [4:0]  _dispatcher_io_dis_uops_2_1_bits_stq_idx;
  wire [6:0]  _dispatcher_io_dis_uops_2_1_bits_pdst;
  wire [6:0]  _dispatcher_io_dis_uops_2_1_bits_prs1;
  wire [6:0]  _dispatcher_io_dis_uops_2_1_bits_prs2;
  wire [6:0]  _dispatcher_io_dis_uops_2_1_bits_prs3;
  wire        _dispatcher_io_dis_uops_2_1_bits_prs1_busy;
  wire        _dispatcher_io_dis_uops_2_1_bits_prs2_busy;
  wire        _dispatcher_io_dis_uops_2_1_bits_prs3_busy;
  wire        _dispatcher_io_dis_uops_2_1_bits_exception;
  wire [4:0]  _dispatcher_io_dis_uops_2_1_bits_mem_cmd;
  wire        _dispatcher_io_dis_uops_2_1_bits_is_fence;
  wire        _dispatcher_io_dis_uops_2_1_bits_is_fencei;
  wire        _dispatcher_io_dis_uops_2_1_bits_is_amo;
  wire        _dispatcher_io_dis_uops_2_1_bits_uses_ldq;
  wire        _dispatcher_io_dis_uops_2_1_bits_uses_stq;
  wire [1:0]  _dispatcher_io_dis_uops_2_1_bits_dst_rtype;
  wire        _dispatcher_io_dis_uops_2_1_bits_fp_val;
  wire        _dispatcher_io_dis_uops_2_2_valid;
  wire [6:0]  _dispatcher_io_dis_uops_2_2_bits_uopc;
  wire [9:0]  _dispatcher_io_dis_uops_2_2_bits_fu_code;
  wire [19:0] _dispatcher_io_dis_uops_2_2_bits_br_mask;
  wire [19:0] _dispatcher_io_dis_uops_2_2_bits_imm_packed;
  wire [6:0]  _dispatcher_io_dis_uops_2_2_bits_rob_idx;
  wire [4:0]  _dispatcher_io_dis_uops_2_2_bits_stq_idx;
  wire [6:0]  _dispatcher_io_dis_uops_2_2_bits_pdst;
  wire [6:0]  _dispatcher_io_dis_uops_2_2_bits_prs1;
  wire [6:0]  _dispatcher_io_dis_uops_2_2_bits_prs2;
  wire [6:0]  _dispatcher_io_dis_uops_2_2_bits_prs3;
  wire        _dispatcher_io_dis_uops_2_2_bits_prs1_busy;
  wire        _dispatcher_io_dis_uops_2_2_bits_prs2_busy;
  wire        _dispatcher_io_dis_uops_2_2_bits_prs3_busy;
  wire        _dispatcher_io_dis_uops_2_2_bits_exception;
  wire [4:0]  _dispatcher_io_dis_uops_2_2_bits_mem_cmd;
  wire        _dispatcher_io_dis_uops_2_2_bits_is_fence;
  wire        _dispatcher_io_dis_uops_2_2_bits_is_fencei;
  wire        _dispatcher_io_dis_uops_2_2_bits_is_amo;
  wire        _dispatcher_io_dis_uops_2_2_bits_uses_ldq;
  wire        _dispatcher_io_dis_uops_2_2_bits_uses_stq;
  wire [1:0]  _dispatcher_io_dis_uops_2_2_bits_dst_rtype;
  wire        _dispatcher_io_dis_uops_2_2_bits_fp_val;
  wire        _dispatcher_io_dis_uops_2_3_valid;
  wire [6:0]  _dispatcher_io_dis_uops_2_3_bits_uopc;
  wire [9:0]  _dispatcher_io_dis_uops_2_3_bits_fu_code;
  wire [19:0] _dispatcher_io_dis_uops_2_3_bits_br_mask;
  wire [19:0] _dispatcher_io_dis_uops_2_3_bits_imm_packed;
  wire [6:0]  _dispatcher_io_dis_uops_2_3_bits_rob_idx;
  wire [4:0]  _dispatcher_io_dis_uops_2_3_bits_stq_idx;
  wire [6:0]  _dispatcher_io_dis_uops_2_3_bits_pdst;
  wire [6:0]  _dispatcher_io_dis_uops_2_3_bits_prs1;
  wire [6:0]  _dispatcher_io_dis_uops_2_3_bits_prs2;
  wire [6:0]  _dispatcher_io_dis_uops_2_3_bits_prs3;
  wire        _dispatcher_io_dis_uops_2_3_bits_prs1_busy;
  wire        _dispatcher_io_dis_uops_2_3_bits_prs2_busy;
  wire        _dispatcher_io_dis_uops_2_3_bits_prs3_busy;
  wire        _dispatcher_io_dis_uops_2_3_bits_exception;
  wire [4:0]  _dispatcher_io_dis_uops_2_3_bits_mem_cmd;
  wire        _dispatcher_io_dis_uops_2_3_bits_is_fence;
  wire        _dispatcher_io_dis_uops_2_3_bits_is_fencei;
  wire        _dispatcher_io_dis_uops_2_3_bits_is_amo;
  wire        _dispatcher_io_dis_uops_2_3_bits_uses_ldq;
  wire        _dispatcher_io_dis_uops_2_3_bits_uses_stq;
  wire [1:0]  _dispatcher_io_dis_uops_2_3_bits_dst_rtype;
  wire        _dispatcher_io_dis_uops_2_3_bits_fp_val;
  wire        _dispatcher_io_dis_uops_1_0_valid;
  wire [6:0]  _dispatcher_io_dis_uops_1_0_bits_uopc;
  wire        _dispatcher_io_dis_uops_1_0_bits_is_rvc;
  wire [9:0]  _dispatcher_io_dis_uops_1_0_bits_fu_code;
  wire        _dispatcher_io_dis_uops_1_0_bits_is_br;
  wire        _dispatcher_io_dis_uops_1_0_bits_is_jalr;
  wire        _dispatcher_io_dis_uops_1_0_bits_is_jal;
  wire        _dispatcher_io_dis_uops_1_0_bits_is_sfb;
  wire [19:0] _dispatcher_io_dis_uops_1_0_bits_br_mask;
  wire [4:0]  _dispatcher_io_dis_uops_1_0_bits_br_tag;
  wire [5:0]  _dispatcher_io_dis_uops_1_0_bits_ftq_idx;
  wire        _dispatcher_io_dis_uops_1_0_bits_edge_inst;
  wire [5:0]  _dispatcher_io_dis_uops_1_0_bits_pc_lob;
  wire        _dispatcher_io_dis_uops_1_0_bits_taken;
  wire [19:0] _dispatcher_io_dis_uops_1_0_bits_imm_packed;
  wire [6:0]  _dispatcher_io_dis_uops_1_0_bits_rob_idx;
  wire [4:0]  _dispatcher_io_dis_uops_1_0_bits_ldq_idx;
  wire [4:0]  _dispatcher_io_dis_uops_1_0_bits_stq_idx;
  wire [6:0]  _dispatcher_io_dis_uops_1_0_bits_pdst;
  wire [6:0]  _dispatcher_io_dis_uops_1_0_bits_prs1;
  wire [6:0]  _dispatcher_io_dis_uops_1_0_bits_prs2;
  wire [6:0]  _dispatcher_io_dis_uops_1_0_bits_prs3;
  wire        _dispatcher_io_dis_uops_1_0_bits_prs1_busy;
  wire        _dispatcher_io_dis_uops_1_0_bits_prs2_busy;
  wire        _dispatcher_io_dis_uops_1_0_bits_exception;
  wire        _dispatcher_io_dis_uops_1_0_bits_bypassable;
  wire [4:0]  _dispatcher_io_dis_uops_1_0_bits_mem_cmd;
  wire [1:0]  _dispatcher_io_dis_uops_1_0_bits_mem_size;
  wire        _dispatcher_io_dis_uops_1_0_bits_mem_signed;
  wire        _dispatcher_io_dis_uops_1_0_bits_is_fence;
  wire        _dispatcher_io_dis_uops_1_0_bits_is_fencei;
  wire        _dispatcher_io_dis_uops_1_0_bits_is_amo;
  wire        _dispatcher_io_dis_uops_1_0_bits_uses_ldq;
  wire        _dispatcher_io_dis_uops_1_0_bits_uses_stq;
  wire        _dispatcher_io_dis_uops_1_0_bits_ldst_val;
  wire [1:0]  _dispatcher_io_dis_uops_1_0_bits_dst_rtype;
  wire [1:0]  _dispatcher_io_dis_uops_1_0_bits_lrs1_rtype;
  wire [1:0]  _dispatcher_io_dis_uops_1_0_bits_lrs2_rtype;
  wire        _dispatcher_io_dis_uops_1_0_bits_fp_val;
  wire        _dispatcher_io_dis_uops_1_1_valid;
  wire [6:0]  _dispatcher_io_dis_uops_1_1_bits_uopc;
  wire        _dispatcher_io_dis_uops_1_1_bits_is_rvc;
  wire [9:0]  _dispatcher_io_dis_uops_1_1_bits_fu_code;
  wire        _dispatcher_io_dis_uops_1_1_bits_is_br;
  wire        _dispatcher_io_dis_uops_1_1_bits_is_jalr;
  wire        _dispatcher_io_dis_uops_1_1_bits_is_jal;
  wire        _dispatcher_io_dis_uops_1_1_bits_is_sfb;
  wire [19:0] _dispatcher_io_dis_uops_1_1_bits_br_mask;
  wire [4:0]  _dispatcher_io_dis_uops_1_1_bits_br_tag;
  wire [5:0]  _dispatcher_io_dis_uops_1_1_bits_ftq_idx;
  wire        _dispatcher_io_dis_uops_1_1_bits_edge_inst;
  wire [5:0]  _dispatcher_io_dis_uops_1_1_bits_pc_lob;
  wire        _dispatcher_io_dis_uops_1_1_bits_taken;
  wire [19:0] _dispatcher_io_dis_uops_1_1_bits_imm_packed;
  wire [6:0]  _dispatcher_io_dis_uops_1_1_bits_rob_idx;
  wire [4:0]  _dispatcher_io_dis_uops_1_1_bits_ldq_idx;
  wire [4:0]  _dispatcher_io_dis_uops_1_1_bits_stq_idx;
  wire [6:0]  _dispatcher_io_dis_uops_1_1_bits_pdst;
  wire [6:0]  _dispatcher_io_dis_uops_1_1_bits_prs1;
  wire [6:0]  _dispatcher_io_dis_uops_1_1_bits_prs2;
  wire [6:0]  _dispatcher_io_dis_uops_1_1_bits_prs3;
  wire        _dispatcher_io_dis_uops_1_1_bits_prs1_busy;
  wire        _dispatcher_io_dis_uops_1_1_bits_prs2_busy;
  wire        _dispatcher_io_dis_uops_1_1_bits_exception;
  wire        _dispatcher_io_dis_uops_1_1_bits_bypassable;
  wire [4:0]  _dispatcher_io_dis_uops_1_1_bits_mem_cmd;
  wire [1:0]  _dispatcher_io_dis_uops_1_1_bits_mem_size;
  wire        _dispatcher_io_dis_uops_1_1_bits_mem_signed;
  wire        _dispatcher_io_dis_uops_1_1_bits_is_fence;
  wire        _dispatcher_io_dis_uops_1_1_bits_is_fencei;
  wire        _dispatcher_io_dis_uops_1_1_bits_is_amo;
  wire        _dispatcher_io_dis_uops_1_1_bits_uses_ldq;
  wire        _dispatcher_io_dis_uops_1_1_bits_uses_stq;
  wire        _dispatcher_io_dis_uops_1_1_bits_ldst_val;
  wire [1:0]  _dispatcher_io_dis_uops_1_1_bits_dst_rtype;
  wire [1:0]  _dispatcher_io_dis_uops_1_1_bits_lrs1_rtype;
  wire [1:0]  _dispatcher_io_dis_uops_1_1_bits_lrs2_rtype;
  wire        _dispatcher_io_dis_uops_1_1_bits_fp_val;
  wire        _dispatcher_io_dis_uops_1_2_valid;
  wire [6:0]  _dispatcher_io_dis_uops_1_2_bits_uopc;
  wire        _dispatcher_io_dis_uops_1_2_bits_is_rvc;
  wire [9:0]  _dispatcher_io_dis_uops_1_2_bits_fu_code;
  wire        _dispatcher_io_dis_uops_1_2_bits_is_br;
  wire        _dispatcher_io_dis_uops_1_2_bits_is_jalr;
  wire        _dispatcher_io_dis_uops_1_2_bits_is_jal;
  wire        _dispatcher_io_dis_uops_1_2_bits_is_sfb;
  wire [19:0] _dispatcher_io_dis_uops_1_2_bits_br_mask;
  wire [4:0]  _dispatcher_io_dis_uops_1_2_bits_br_tag;
  wire [5:0]  _dispatcher_io_dis_uops_1_2_bits_ftq_idx;
  wire        _dispatcher_io_dis_uops_1_2_bits_edge_inst;
  wire [5:0]  _dispatcher_io_dis_uops_1_2_bits_pc_lob;
  wire        _dispatcher_io_dis_uops_1_2_bits_taken;
  wire [19:0] _dispatcher_io_dis_uops_1_2_bits_imm_packed;
  wire [6:0]  _dispatcher_io_dis_uops_1_2_bits_rob_idx;
  wire [4:0]  _dispatcher_io_dis_uops_1_2_bits_ldq_idx;
  wire [4:0]  _dispatcher_io_dis_uops_1_2_bits_stq_idx;
  wire [6:0]  _dispatcher_io_dis_uops_1_2_bits_pdst;
  wire [6:0]  _dispatcher_io_dis_uops_1_2_bits_prs1;
  wire [6:0]  _dispatcher_io_dis_uops_1_2_bits_prs2;
  wire [6:0]  _dispatcher_io_dis_uops_1_2_bits_prs3;
  wire        _dispatcher_io_dis_uops_1_2_bits_prs1_busy;
  wire        _dispatcher_io_dis_uops_1_2_bits_prs2_busy;
  wire        _dispatcher_io_dis_uops_1_2_bits_exception;
  wire        _dispatcher_io_dis_uops_1_2_bits_bypassable;
  wire [4:0]  _dispatcher_io_dis_uops_1_2_bits_mem_cmd;
  wire [1:0]  _dispatcher_io_dis_uops_1_2_bits_mem_size;
  wire        _dispatcher_io_dis_uops_1_2_bits_mem_signed;
  wire        _dispatcher_io_dis_uops_1_2_bits_is_fence;
  wire        _dispatcher_io_dis_uops_1_2_bits_is_fencei;
  wire        _dispatcher_io_dis_uops_1_2_bits_is_amo;
  wire        _dispatcher_io_dis_uops_1_2_bits_uses_ldq;
  wire        _dispatcher_io_dis_uops_1_2_bits_uses_stq;
  wire        _dispatcher_io_dis_uops_1_2_bits_ldst_val;
  wire [1:0]  _dispatcher_io_dis_uops_1_2_bits_dst_rtype;
  wire [1:0]  _dispatcher_io_dis_uops_1_2_bits_lrs1_rtype;
  wire [1:0]  _dispatcher_io_dis_uops_1_2_bits_lrs2_rtype;
  wire        _dispatcher_io_dis_uops_1_2_bits_fp_val;
  wire        _dispatcher_io_dis_uops_1_3_valid;
  wire [6:0]  _dispatcher_io_dis_uops_1_3_bits_uopc;
  wire        _dispatcher_io_dis_uops_1_3_bits_is_rvc;
  wire [9:0]  _dispatcher_io_dis_uops_1_3_bits_fu_code;
  wire        _dispatcher_io_dis_uops_1_3_bits_is_br;
  wire        _dispatcher_io_dis_uops_1_3_bits_is_jalr;
  wire        _dispatcher_io_dis_uops_1_3_bits_is_jal;
  wire        _dispatcher_io_dis_uops_1_3_bits_is_sfb;
  wire [19:0] _dispatcher_io_dis_uops_1_3_bits_br_mask;
  wire [4:0]  _dispatcher_io_dis_uops_1_3_bits_br_tag;
  wire [5:0]  _dispatcher_io_dis_uops_1_3_bits_ftq_idx;
  wire        _dispatcher_io_dis_uops_1_3_bits_edge_inst;
  wire [5:0]  _dispatcher_io_dis_uops_1_3_bits_pc_lob;
  wire        _dispatcher_io_dis_uops_1_3_bits_taken;
  wire [19:0] _dispatcher_io_dis_uops_1_3_bits_imm_packed;
  wire [6:0]  _dispatcher_io_dis_uops_1_3_bits_rob_idx;
  wire [4:0]  _dispatcher_io_dis_uops_1_3_bits_ldq_idx;
  wire [4:0]  _dispatcher_io_dis_uops_1_3_bits_stq_idx;
  wire [6:0]  _dispatcher_io_dis_uops_1_3_bits_pdst;
  wire [6:0]  _dispatcher_io_dis_uops_1_3_bits_prs1;
  wire [6:0]  _dispatcher_io_dis_uops_1_3_bits_prs2;
  wire [6:0]  _dispatcher_io_dis_uops_1_3_bits_prs3;
  wire        _dispatcher_io_dis_uops_1_3_bits_prs1_busy;
  wire        _dispatcher_io_dis_uops_1_3_bits_prs2_busy;
  wire        _dispatcher_io_dis_uops_1_3_bits_exception;
  wire        _dispatcher_io_dis_uops_1_3_bits_bypassable;
  wire [4:0]  _dispatcher_io_dis_uops_1_3_bits_mem_cmd;
  wire [1:0]  _dispatcher_io_dis_uops_1_3_bits_mem_size;
  wire        _dispatcher_io_dis_uops_1_3_bits_mem_signed;
  wire        _dispatcher_io_dis_uops_1_3_bits_is_fence;
  wire        _dispatcher_io_dis_uops_1_3_bits_is_fencei;
  wire        _dispatcher_io_dis_uops_1_3_bits_is_amo;
  wire        _dispatcher_io_dis_uops_1_3_bits_uses_ldq;
  wire        _dispatcher_io_dis_uops_1_3_bits_uses_stq;
  wire        _dispatcher_io_dis_uops_1_3_bits_ldst_val;
  wire [1:0]  _dispatcher_io_dis_uops_1_3_bits_dst_rtype;
  wire [1:0]  _dispatcher_io_dis_uops_1_3_bits_lrs1_rtype;
  wire [1:0]  _dispatcher_io_dis_uops_1_3_bits_lrs2_rtype;
  wire        _dispatcher_io_dis_uops_1_3_bits_fp_val;
  wire        _dispatcher_io_dis_uops_0_0_valid;
  wire [6:0]  _dispatcher_io_dis_uops_0_0_bits_uopc;
  wire        _dispatcher_io_dis_uops_0_0_bits_is_rvc;
  wire [9:0]  _dispatcher_io_dis_uops_0_0_bits_fu_code;
  wire        _dispatcher_io_dis_uops_0_0_bits_is_br;
  wire        _dispatcher_io_dis_uops_0_0_bits_is_jalr;
  wire        _dispatcher_io_dis_uops_0_0_bits_is_jal;
  wire        _dispatcher_io_dis_uops_0_0_bits_is_sfb;
  wire [19:0] _dispatcher_io_dis_uops_0_0_bits_br_mask;
  wire [4:0]  _dispatcher_io_dis_uops_0_0_bits_br_tag;
  wire [5:0]  _dispatcher_io_dis_uops_0_0_bits_ftq_idx;
  wire        _dispatcher_io_dis_uops_0_0_bits_edge_inst;
  wire [5:0]  _dispatcher_io_dis_uops_0_0_bits_pc_lob;
  wire        _dispatcher_io_dis_uops_0_0_bits_taken;
  wire [19:0] _dispatcher_io_dis_uops_0_0_bits_imm_packed;
  wire [6:0]  _dispatcher_io_dis_uops_0_0_bits_rob_idx;
  wire [4:0]  _dispatcher_io_dis_uops_0_0_bits_ldq_idx;
  wire [4:0]  _dispatcher_io_dis_uops_0_0_bits_stq_idx;
  wire [6:0]  _dispatcher_io_dis_uops_0_0_bits_pdst;
  wire [6:0]  _dispatcher_io_dis_uops_0_0_bits_prs1;
  wire [6:0]  _dispatcher_io_dis_uops_0_0_bits_prs2;
  wire [6:0]  _dispatcher_io_dis_uops_0_0_bits_prs3;
  wire        _dispatcher_io_dis_uops_0_0_bits_prs1_busy;
  wire        _dispatcher_io_dis_uops_0_0_bits_prs2_busy;
  wire        _dispatcher_io_dis_uops_0_0_bits_exception;
  wire        _dispatcher_io_dis_uops_0_0_bits_bypassable;
  wire [4:0]  _dispatcher_io_dis_uops_0_0_bits_mem_cmd;
  wire [1:0]  _dispatcher_io_dis_uops_0_0_bits_mem_size;
  wire        _dispatcher_io_dis_uops_0_0_bits_mem_signed;
  wire        _dispatcher_io_dis_uops_0_0_bits_is_fence;
  wire        _dispatcher_io_dis_uops_0_0_bits_is_fencei;
  wire        _dispatcher_io_dis_uops_0_0_bits_is_amo;
  wire        _dispatcher_io_dis_uops_0_0_bits_uses_ldq;
  wire        _dispatcher_io_dis_uops_0_0_bits_uses_stq;
  wire        _dispatcher_io_dis_uops_0_0_bits_ldst_val;
  wire [1:0]  _dispatcher_io_dis_uops_0_0_bits_dst_rtype;
  wire [1:0]  _dispatcher_io_dis_uops_0_0_bits_lrs1_rtype;
  wire [1:0]  _dispatcher_io_dis_uops_0_0_bits_lrs2_rtype;
  wire        _dispatcher_io_dis_uops_0_0_bits_fp_val;
  wire        _dispatcher_io_dis_uops_0_1_valid;
  wire [6:0]  _dispatcher_io_dis_uops_0_1_bits_uopc;
  wire        _dispatcher_io_dis_uops_0_1_bits_is_rvc;
  wire [9:0]  _dispatcher_io_dis_uops_0_1_bits_fu_code;
  wire        _dispatcher_io_dis_uops_0_1_bits_is_br;
  wire        _dispatcher_io_dis_uops_0_1_bits_is_jalr;
  wire        _dispatcher_io_dis_uops_0_1_bits_is_jal;
  wire        _dispatcher_io_dis_uops_0_1_bits_is_sfb;
  wire [19:0] _dispatcher_io_dis_uops_0_1_bits_br_mask;
  wire [4:0]  _dispatcher_io_dis_uops_0_1_bits_br_tag;
  wire [5:0]  _dispatcher_io_dis_uops_0_1_bits_ftq_idx;
  wire        _dispatcher_io_dis_uops_0_1_bits_edge_inst;
  wire [5:0]  _dispatcher_io_dis_uops_0_1_bits_pc_lob;
  wire        _dispatcher_io_dis_uops_0_1_bits_taken;
  wire [19:0] _dispatcher_io_dis_uops_0_1_bits_imm_packed;
  wire [6:0]  _dispatcher_io_dis_uops_0_1_bits_rob_idx;
  wire [4:0]  _dispatcher_io_dis_uops_0_1_bits_ldq_idx;
  wire [4:0]  _dispatcher_io_dis_uops_0_1_bits_stq_idx;
  wire [6:0]  _dispatcher_io_dis_uops_0_1_bits_pdst;
  wire [6:0]  _dispatcher_io_dis_uops_0_1_bits_prs1;
  wire [6:0]  _dispatcher_io_dis_uops_0_1_bits_prs2;
  wire [6:0]  _dispatcher_io_dis_uops_0_1_bits_prs3;
  wire        _dispatcher_io_dis_uops_0_1_bits_prs1_busy;
  wire        _dispatcher_io_dis_uops_0_1_bits_prs2_busy;
  wire        _dispatcher_io_dis_uops_0_1_bits_exception;
  wire        _dispatcher_io_dis_uops_0_1_bits_bypassable;
  wire [4:0]  _dispatcher_io_dis_uops_0_1_bits_mem_cmd;
  wire [1:0]  _dispatcher_io_dis_uops_0_1_bits_mem_size;
  wire        _dispatcher_io_dis_uops_0_1_bits_mem_signed;
  wire        _dispatcher_io_dis_uops_0_1_bits_is_fence;
  wire        _dispatcher_io_dis_uops_0_1_bits_is_fencei;
  wire        _dispatcher_io_dis_uops_0_1_bits_is_amo;
  wire        _dispatcher_io_dis_uops_0_1_bits_uses_ldq;
  wire        _dispatcher_io_dis_uops_0_1_bits_uses_stq;
  wire        _dispatcher_io_dis_uops_0_1_bits_ldst_val;
  wire [1:0]  _dispatcher_io_dis_uops_0_1_bits_dst_rtype;
  wire [1:0]  _dispatcher_io_dis_uops_0_1_bits_lrs1_rtype;
  wire [1:0]  _dispatcher_io_dis_uops_0_1_bits_lrs2_rtype;
  wire        _dispatcher_io_dis_uops_0_1_bits_fp_val;
  wire        _dispatcher_io_dis_uops_0_2_valid;
  wire [6:0]  _dispatcher_io_dis_uops_0_2_bits_uopc;
  wire        _dispatcher_io_dis_uops_0_2_bits_is_rvc;
  wire [9:0]  _dispatcher_io_dis_uops_0_2_bits_fu_code;
  wire        _dispatcher_io_dis_uops_0_2_bits_is_br;
  wire        _dispatcher_io_dis_uops_0_2_bits_is_jalr;
  wire        _dispatcher_io_dis_uops_0_2_bits_is_jal;
  wire        _dispatcher_io_dis_uops_0_2_bits_is_sfb;
  wire [19:0] _dispatcher_io_dis_uops_0_2_bits_br_mask;
  wire [4:0]  _dispatcher_io_dis_uops_0_2_bits_br_tag;
  wire [5:0]  _dispatcher_io_dis_uops_0_2_bits_ftq_idx;
  wire        _dispatcher_io_dis_uops_0_2_bits_edge_inst;
  wire [5:0]  _dispatcher_io_dis_uops_0_2_bits_pc_lob;
  wire        _dispatcher_io_dis_uops_0_2_bits_taken;
  wire [19:0] _dispatcher_io_dis_uops_0_2_bits_imm_packed;
  wire [6:0]  _dispatcher_io_dis_uops_0_2_bits_rob_idx;
  wire [4:0]  _dispatcher_io_dis_uops_0_2_bits_ldq_idx;
  wire [4:0]  _dispatcher_io_dis_uops_0_2_bits_stq_idx;
  wire [6:0]  _dispatcher_io_dis_uops_0_2_bits_pdst;
  wire [6:0]  _dispatcher_io_dis_uops_0_2_bits_prs1;
  wire [6:0]  _dispatcher_io_dis_uops_0_2_bits_prs2;
  wire [6:0]  _dispatcher_io_dis_uops_0_2_bits_prs3;
  wire        _dispatcher_io_dis_uops_0_2_bits_prs1_busy;
  wire        _dispatcher_io_dis_uops_0_2_bits_prs2_busy;
  wire        _dispatcher_io_dis_uops_0_2_bits_exception;
  wire        _dispatcher_io_dis_uops_0_2_bits_bypassable;
  wire [4:0]  _dispatcher_io_dis_uops_0_2_bits_mem_cmd;
  wire [1:0]  _dispatcher_io_dis_uops_0_2_bits_mem_size;
  wire        _dispatcher_io_dis_uops_0_2_bits_mem_signed;
  wire        _dispatcher_io_dis_uops_0_2_bits_is_fence;
  wire        _dispatcher_io_dis_uops_0_2_bits_is_fencei;
  wire        _dispatcher_io_dis_uops_0_2_bits_is_amo;
  wire        _dispatcher_io_dis_uops_0_2_bits_uses_ldq;
  wire        _dispatcher_io_dis_uops_0_2_bits_uses_stq;
  wire        _dispatcher_io_dis_uops_0_2_bits_ldst_val;
  wire [1:0]  _dispatcher_io_dis_uops_0_2_bits_dst_rtype;
  wire [1:0]  _dispatcher_io_dis_uops_0_2_bits_lrs1_rtype;
  wire [1:0]  _dispatcher_io_dis_uops_0_2_bits_lrs2_rtype;
  wire        _dispatcher_io_dis_uops_0_2_bits_fp_val;
  wire        _dispatcher_io_dis_uops_0_3_valid;
  wire [6:0]  _dispatcher_io_dis_uops_0_3_bits_uopc;
  wire        _dispatcher_io_dis_uops_0_3_bits_is_rvc;
  wire [9:0]  _dispatcher_io_dis_uops_0_3_bits_fu_code;
  wire        _dispatcher_io_dis_uops_0_3_bits_is_br;
  wire        _dispatcher_io_dis_uops_0_3_bits_is_jalr;
  wire        _dispatcher_io_dis_uops_0_3_bits_is_jal;
  wire        _dispatcher_io_dis_uops_0_3_bits_is_sfb;
  wire [19:0] _dispatcher_io_dis_uops_0_3_bits_br_mask;
  wire [4:0]  _dispatcher_io_dis_uops_0_3_bits_br_tag;
  wire [5:0]  _dispatcher_io_dis_uops_0_3_bits_ftq_idx;
  wire        _dispatcher_io_dis_uops_0_3_bits_edge_inst;
  wire [5:0]  _dispatcher_io_dis_uops_0_3_bits_pc_lob;
  wire        _dispatcher_io_dis_uops_0_3_bits_taken;
  wire [19:0] _dispatcher_io_dis_uops_0_3_bits_imm_packed;
  wire [6:0]  _dispatcher_io_dis_uops_0_3_bits_rob_idx;
  wire [4:0]  _dispatcher_io_dis_uops_0_3_bits_ldq_idx;
  wire [4:0]  _dispatcher_io_dis_uops_0_3_bits_stq_idx;
  wire [6:0]  _dispatcher_io_dis_uops_0_3_bits_pdst;
  wire [6:0]  _dispatcher_io_dis_uops_0_3_bits_prs1;
  wire [6:0]  _dispatcher_io_dis_uops_0_3_bits_prs2;
  wire [6:0]  _dispatcher_io_dis_uops_0_3_bits_prs3;
  wire        _dispatcher_io_dis_uops_0_3_bits_prs1_busy;
  wire        _dispatcher_io_dis_uops_0_3_bits_prs2_busy;
  wire        _dispatcher_io_dis_uops_0_3_bits_exception;
  wire        _dispatcher_io_dis_uops_0_3_bits_bypassable;
  wire [4:0]  _dispatcher_io_dis_uops_0_3_bits_mem_cmd;
  wire [1:0]  _dispatcher_io_dis_uops_0_3_bits_mem_size;
  wire        _dispatcher_io_dis_uops_0_3_bits_mem_signed;
  wire        _dispatcher_io_dis_uops_0_3_bits_is_fence;
  wire        _dispatcher_io_dis_uops_0_3_bits_is_fencei;
  wire        _dispatcher_io_dis_uops_0_3_bits_is_amo;
  wire        _dispatcher_io_dis_uops_0_3_bits_uses_ldq;
  wire        _dispatcher_io_dis_uops_0_3_bits_uses_stq;
  wire        _dispatcher_io_dis_uops_0_3_bits_ldst_val;
  wire [1:0]  _dispatcher_io_dis_uops_0_3_bits_dst_rtype;
  wire [1:0]  _dispatcher_io_dis_uops_0_3_bits_lrs1_rtype;
  wire [1:0]  _dispatcher_io_dis_uops_0_3_bits_lrs2_rtype;
  wire        _dispatcher_io_dis_uops_0_3_bits_fp_val;
  wire        _int_issue_unit_io_dis_uops_0_ready;
  wire        _int_issue_unit_io_dis_uops_1_ready;
  wire        _int_issue_unit_io_dis_uops_2_ready;
  wire        _int_issue_unit_io_dis_uops_3_ready;
  wire        _int_issue_unit_io_iss_valids_0;
  wire        _int_issue_unit_io_iss_valids_1;
  wire        _int_issue_unit_io_iss_valids_2;
  wire        _int_issue_unit_io_iss_valids_3;
  wire [6:0]  _int_issue_unit_io_iss_uops_0_uopc;
  wire        _int_issue_unit_io_iss_uops_0_is_rvc;
  wire [9:0]  _int_issue_unit_io_iss_uops_0_fu_code;
  wire        _int_issue_unit_io_iss_uops_0_iw_p1_poisoned;
  wire        _int_issue_unit_io_iss_uops_0_iw_p2_poisoned;
  wire        _int_issue_unit_io_iss_uops_0_is_br;
  wire        _int_issue_unit_io_iss_uops_0_is_jalr;
  wire        _int_issue_unit_io_iss_uops_0_is_jal;
  wire        _int_issue_unit_io_iss_uops_0_is_sfb;
  wire [19:0] _int_issue_unit_io_iss_uops_0_br_mask;
  wire [4:0]  _int_issue_unit_io_iss_uops_0_br_tag;
  wire [5:0]  _int_issue_unit_io_iss_uops_0_ftq_idx;
  wire        _int_issue_unit_io_iss_uops_0_edge_inst;
  wire [5:0]  _int_issue_unit_io_iss_uops_0_pc_lob;
  wire        _int_issue_unit_io_iss_uops_0_taken;
  wire [19:0] _int_issue_unit_io_iss_uops_0_imm_packed;
  wire [6:0]  _int_issue_unit_io_iss_uops_0_rob_idx;
  wire [4:0]  _int_issue_unit_io_iss_uops_0_ldq_idx;
  wire [4:0]  _int_issue_unit_io_iss_uops_0_stq_idx;
  wire [6:0]  _int_issue_unit_io_iss_uops_0_pdst;
  wire [6:0]  _int_issue_unit_io_iss_uops_0_prs1;
  wire [6:0]  _int_issue_unit_io_iss_uops_0_prs2;
  wire        _int_issue_unit_io_iss_uops_0_bypassable;
  wire [4:0]  _int_issue_unit_io_iss_uops_0_mem_cmd;
  wire        _int_issue_unit_io_iss_uops_0_is_amo;
  wire        _int_issue_unit_io_iss_uops_0_uses_stq;
  wire        _int_issue_unit_io_iss_uops_0_ldst_val;
  wire [1:0]  _int_issue_unit_io_iss_uops_0_dst_rtype;
  wire [1:0]  _int_issue_unit_io_iss_uops_0_lrs1_rtype;
  wire [1:0]  _int_issue_unit_io_iss_uops_0_lrs2_rtype;
  wire        _int_issue_unit_io_iss_uops_0_fp_val;
  wire [6:0]  _int_issue_unit_io_iss_uops_1_uopc;
  wire        _int_issue_unit_io_iss_uops_1_is_rvc;
  wire [9:0]  _int_issue_unit_io_iss_uops_1_fu_code;
  wire        _int_issue_unit_io_iss_uops_1_iw_p1_poisoned;
  wire        _int_issue_unit_io_iss_uops_1_iw_p2_poisoned;
  wire        _int_issue_unit_io_iss_uops_1_is_br;
  wire        _int_issue_unit_io_iss_uops_1_is_jalr;
  wire        _int_issue_unit_io_iss_uops_1_is_jal;
  wire        _int_issue_unit_io_iss_uops_1_is_sfb;
  wire [19:0] _int_issue_unit_io_iss_uops_1_br_mask;
  wire [4:0]  _int_issue_unit_io_iss_uops_1_br_tag;
  wire [5:0]  _int_issue_unit_io_iss_uops_1_ftq_idx;
  wire        _int_issue_unit_io_iss_uops_1_edge_inst;
  wire [5:0]  _int_issue_unit_io_iss_uops_1_pc_lob;
  wire        _int_issue_unit_io_iss_uops_1_taken;
  wire [19:0] _int_issue_unit_io_iss_uops_1_imm_packed;
  wire [6:0]  _int_issue_unit_io_iss_uops_1_rob_idx;
  wire [4:0]  _int_issue_unit_io_iss_uops_1_ldq_idx;
  wire [4:0]  _int_issue_unit_io_iss_uops_1_stq_idx;
  wire [6:0]  _int_issue_unit_io_iss_uops_1_pdst;
  wire [6:0]  _int_issue_unit_io_iss_uops_1_prs1;
  wire [6:0]  _int_issue_unit_io_iss_uops_1_prs2;
  wire        _int_issue_unit_io_iss_uops_1_bypassable;
  wire [4:0]  _int_issue_unit_io_iss_uops_1_mem_cmd;
  wire        _int_issue_unit_io_iss_uops_1_is_amo;
  wire        _int_issue_unit_io_iss_uops_1_uses_stq;
  wire        _int_issue_unit_io_iss_uops_1_ldst_val;
  wire [1:0]  _int_issue_unit_io_iss_uops_1_dst_rtype;
  wire [1:0]  _int_issue_unit_io_iss_uops_1_lrs1_rtype;
  wire [1:0]  _int_issue_unit_io_iss_uops_1_lrs2_rtype;
  wire [6:0]  _int_issue_unit_io_iss_uops_2_uopc;
  wire        _int_issue_unit_io_iss_uops_2_is_rvc;
  wire [9:0]  _int_issue_unit_io_iss_uops_2_fu_code;
  wire        _int_issue_unit_io_iss_uops_2_iw_p1_poisoned;
  wire        _int_issue_unit_io_iss_uops_2_iw_p2_poisoned;
  wire        _int_issue_unit_io_iss_uops_2_is_br;
  wire        _int_issue_unit_io_iss_uops_2_is_jalr;
  wire        _int_issue_unit_io_iss_uops_2_is_jal;
  wire        _int_issue_unit_io_iss_uops_2_is_sfb;
  wire [19:0] _int_issue_unit_io_iss_uops_2_br_mask;
  wire [4:0]  _int_issue_unit_io_iss_uops_2_br_tag;
  wire [5:0]  _int_issue_unit_io_iss_uops_2_ftq_idx;
  wire        _int_issue_unit_io_iss_uops_2_edge_inst;
  wire [5:0]  _int_issue_unit_io_iss_uops_2_pc_lob;
  wire        _int_issue_unit_io_iss_uops_2_taken;
  wire [19:0] _int_issue_unit_io_iss_uops_2_imm_packed;
  wire [6:0]  _int_issue_unit_io_iss_uops_2_rob_idx;
  wire [4:0]  _int_issue_unit_io_iss_uops_2_ldq_idx;
  wire [4:0]  _int_issue_unit_io_iss_uops_2_stq_idx;
  wire [6:0]  _int_issue_unit_io_iss_uops_2_pdst;
  wire [6:0]  _int_issue_unit_io_iss_uops_2_prs1;
  wire [6:0]  _int_issue_unit_io_iss_uops_2_prs2;
  wire        _int_issue_unit_io_iss_uops_2_bypassable;
  wire [4:0]  _int_issue_unit_io_iss_uops_2_mem_cmd;
  wire        _int_issue_unit_io_iss_uops_2_is_amo;
  wire        _int_issue_unit_io_iss_uops_2_uses_stq;
  wire        _int_issue_unit_io_iss_uops_2_ldst_val;
  wire [1:0]  _int_issue_unit_io_iss_uops_2_dst_rtype;
  wire [1:0]  _int_issue_unit_io_iss_uops_2_lrs1_rtype;
  wire [1:0]  _int_issue_unit_io_iss_uops_2_lrs2_rtype;
  wire [6:0]  _int_issue_unit_io_iss_uops_3_uopc;
  wire        _int_issue_unit_io_iss_uops_3_is_rvc;
  wire [9:0]  _int_issue_unit_io_iss_uops_3_fu_code;
  wire        _int_issue_unit_io_iss_uops_3_iw_p1_poisoned;
  wire        _int_issue_unit_io_iss_uops_3_iw_p2_poisoned;
  wire        _int_issue_unit_io_iss_uops_3_is_br;
  wire        _int_issue_unit_io_iss_uops_3_is_jalr;
  wire        _int_issue_unit_io_iss_uops_3_is_jal;
  wire        _int_issue_unit_io_iss_uops_3_is_sfb;
  wire [19:0] _int_issue_unit_io_iss_uops_3_br_mask;
  wire [4:0]  _int_issue_unit_io_iss_uops_3_br_tag;
  wire [5:0]  _int_issue_unit_io_iss_uops_3_ftq_idx;
  wire        _int_issue_unit_io_iss_uops_3_edge_inst;
  wire [5:0]  _int_issue_unit_io_iss_uops_3_pc_lob;
  wire        _int_issue_unit_io_iss_uops_3_taken;
  wire [19:0] _int_issue_unit_io_iss_uops_3_imm_packed;
  wire [6:0]  _int_issue_unit_io_iss_uops_3_rob_idx;
  wire [4:0]  _int_issue_unit_io_iss_uops_3_ldq_idx;
  wire [4:0]  _int_issue_unit_io_iss_uops_3_stq_idx;
  wire [6:0]  _int_issue_unit_io_iss_uops_3_pdst;
  wire [6:0]  _int_issue_unit_io_iss_uops_3_prs1;
  wire [6:0]  _int_issue_unit_io_iss_uops_3_prs2;
  wire        _int_issue_unit_io_iss_uops_3_bypassable;
  wire [4:0]  _int_issue_unit_io_iss_uops_3_mem_cmd;
  wire        _int_issue_unit_io_iss_uops_3_is_amo;
  wire        _int_issue_unit_io_iss_uops_3_uses_stq;
  wire        _int_issue_unit_io_iss_uops_3_ldst_val;
  wire [1:0]  _int_issue_unit_io_iss_uops_3_dst_rtype;
  wire [1:0]  _int_issue_unit_io_iss_uops_3_lrs1_rtype;
  wire [1:0]  _int_issue_unit_io_iss_uops_3_lrs2_rtype;
  wire        _mem_issue_unit_io_dis_uops_0_ready;
  wire        _mem_issue_unit_io_dis_uops_1_ready;
  wire        _mem_issue_unit_io_dis_uops_2_ready;
  wire        _mem_issue_unit_io_dis_uops_3_ready;
  wire        _mem_issue_unit_io_iss_valids_0;
  wire        _mem_issue_unit_io_iss_valids_1;
  wire [6:0]  _mem_issue_unit_io_iss_uops_0_uopc;
  wire [9:0]  _mem_issue_unit_io_iss_uops_0_fu_code;
  wire        _mem_issue_unit_io_iss_uops_0_iw_p1_poisoned;
  wire        _mem_issue_unit_io_iss_uops_0_iw_p2_poisoned;
  wire [19:0] _mem_issue_unit_io_iss_uops_0_br_mask;
  wire [19:0] _mem_issue_unit_io_iss_uops_0_imm_packed;
  wire [6:0]  _mem_issue_unit_io_iss_uops_0_rob_idx;
  wire [4:0]  _mem_issue_unit_io_iss_uops_0_ldq_idx;
  wire [4:0]  _mem_issue_unit_io_iss_uops_0_stq_idx;
  wire [6:0]  _mem_issue_unit_io_iss_uops_0_pdst;
  wire [6:0]  _mem_issue_unit_io_iss_uops_0_prs1;
  wire [6:0]  _mem_issue_unit_io_iss_uops_0_prs2;
  wire [4:0]  _mem_issue_unit_io_iss_uops_0_mem_cmd;
  wire [1:0]  _mem_issue_unit_io_iss_uops_0_mem_size;
  wire        _mem_issue_unit_io_iss_uops_0_mem_signed;
  wire        _mem_issue_unit_io_iss_uops_0_is_fence;
  wire        _mem_issue_unit_io_iss_uops_0_is_amo;
  wire        _mem_issue_unit_io_iss_uops_0_uses_ldq;
  wire        _mem_issue_unit_io_iss_uops_0_uses_stq;
  wire [1:0]  _mem_issue_unit_io_iss_uops_0_lrs1_rtype;
  wire [1:0]  _mem_issue_unit_io_iss_uops_0_lrs2_rtype;
  wire        _mem_issue_unit_io_iss_uops_0_fp_val;
  wire [6:0]  _mem_issue_unit_io_iss_uops_1_uopc;
  wire [9:0]  _mem_issue_unit_io_iss_uops_1_fu_code;
  wire        _mem_issue_unit_io_iss_uops_1_iw_p1_poisoned;
  wire        _mem_issue_unit_io_iss_uops_1_iw_p2_poisoned;
  wire [19:0] _mem_issue_unit_io_iss_uops_1_br_mask;
  wire [19:0] _mem_issue_unit_io_iss_uops_1_imm_packed;
  wire [6:0]  _mem_issue_unit_io_iss_uops_1_rob_idx;
  wire [4:0]  _mem_issue_unit_io_iss_uops_1_ldq_idx;
  wire [4:0]  _mem_issue_unit_io_iss_uops_1_stq_idx;
  wire [6:0]  _mem_issue_unit_io_iss_uops_1_pdst;
  wire [6:0]  _mem_issue_unit_io_iss_uops_1_prs1;
  wire [6:0]  _mem_issue_unit_io_iss_uops_1_prs2;
  wire [4:0]  _mem_issue_unit_io_iss_uops_1_mem_cmd;
  wire [1:0]  _mem_issue_unit_io_iss_uops_1_mem_size;
  wire        _mem_issue_unit_io_iss_uops_1_mem_signed;
  wire        _mem_issue_unit_io_iss_uops_1_is_fence;
  wire        _mem_issue_unit_io_iss_uops_1_is_amo;
  wire        _mem_issue_unit_io_iss_uops_1_uses_ldq;
  wire        _mem_issue_unit_io_iss_uops_1_uses_stq;
  wire [1:0]  _mem_issue_unit_io_iss_uops_1_lrs1_rtype;
  wire [1:0]  _mem_issue_unit_io_iss_uops_1_lrs2_rtype;
  wire        _mem_issue_unit_io_iss_uops_1_fp_val;
  wire        _fp_rename_stage_io_ren_stalls_0;
  wire        _fp_rename_stage_io_ren_stalls_1;
  wire        _fp_rename_stage_io_ren_stalls_2;
  wire        _fp_rename_stage_io_ren_stalls_3;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_0_pdst;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_0_prs1;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_0_prs2;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_0_prs3;
  wire        _fp_rename_stage_io_ren2_uops_0_prs1_busy;
  wire        _fp_rename_stage_io_ren2_uops_0_prs2_busy;
  wire        _fp_rename_stage_io_ren2_uops_0_prs3_busy;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_0_stale_pdst;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_1_pdst;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_1_prs1;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_1_prs2;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_1_prs3;
  wire        _fp_rename_stage_io_ren2_uops_1_prs1_busy;
  wire        _fp_rename_stage_io_ren2_uops_1_prs2_busy;
  wire        _fp_rename_stage_io_ren2_uops_1_prs3_busy;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_1_stale_pdst;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_2_pdst;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_2_prs1;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_2_prs2;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_2_prs3;
  wire        _fp_rename_stage_io_ren2_uops_2_prs1_busy;
  wire        _fp_rename_stage_io_ren2_uops_2_prs2_busy;
  wire        _fp_rename_stage_io_ren2_uops_2_prs3_busy;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_2_stale_pdst;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_3_pdst;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_3_prs1;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_3_prs2;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_3_prs3;
  wire        _fp_rename_stage_io_ren2_uops_3_prs1_busy;
  wire        _fp_rename_stage_io_ren2_uops_3_prs2_busy;
  wire        _fp_rename_stage_io_ren2_uops_3_prs3_busy;
  wire [6:0]  _fp_rename_stage_io_ren2_uops_3_stale_pdst;
  wire        _rename_stage_io_ren_stalls_0;
  wire        _rename_stage_io_ren_stalls_1;
  wire        _rename_stage_io_ren_stalls_2;
  wire        _rename_stage_io_ren_stalls_3;
  wire        _rename_stage_io_ren2_mask_0;
  wire        _rename_stage_io_ren2_mask_1;
  wire        _rename_stage_io_ren2_mask_2;
  wire        _rename_stage_io_ren2_mask_3;
  wire [6:0]  _rename_stage_io_ren2_uops_0_uopc;
  wire        _rename_stage_io_ren2_uops_0_is_rvc;
  wire [2:0]  _rename_stage_io_ren2_uops_0_iq_type;
  wire [9:0]  _rename_stage_io_ren2_uops_0_fu_code;
  wire        _rename_stage_io_ren2_uops_0_is_br;
  wire        _rename_stage_io_ren2_uops_0_is_jalr;
  wire        _rename_stage_io_ren2_uops_0_is_jal;
  wire        _rename_stage_io_ren2_uops_0_is_sfb;
  wire [19:0] _rename_stage_io_ren2_uops_0_br_mask;
  wire [4:0]  _rename_stage_io_ren2_uops_0_br_tag;
  wire [5:0]  _rename_stage_io_ren2_uops_0_ftq_idx;
  wire        _rename_stage_io_ren2_uops_0_edge_inst;
  wire [5:0]  _rename_stage_io_ren2_uops_0_pc_lob;
  wire        _rename_stage_io_ren2_uops_0_taken;
  wire [19:0] _rename_stage_io_ren2_uops_0_imm_packed;
  wire [6:0]  _rename_stage_io_ren2_uops_0_pdst;
  wire [6:0]  _rename_stage_io_ren2_uops_0_prs1;
  wire [6:0]  _rename_stage_io_ren2_uops_0_prs2;
  wire        _rename_stage_io_ren2_uops_0_prs1_busy;
  wire        _rename_stage_io_ren2_uops_0_prs2_busy;
  wire [6:0]  _rename_stage_io_ren2_uops_0_stale_pdst;
  wire        _rename_stage_io_ren2_uops_0_exception;
  wire [63:0] _rename_stage_io_ren2_uops_0_exc_cause;
  wire        _rename_stage_io_ren2_uops_0_bypassable;
  wire [4:0]  _rename_stage_io_ren2_uops_0_mem_cmd;
  wire [1:0]  _rename_stage_io_ren2_uops_0_mem_size;
  wire        _rename_stage_io_ren2_uops_0_mem_signed;
  wire        _rename_stage_io_ren2_uops_0_is_fence;
  wire        _rename_stage_io_ren2_uops_0_is_fencei;
  wire        _rename_stage_io_ren2_uops_0_is_amo;
  wire        _rename_stage_io_ren2_uops_0_uses_ldq;
  wire        _rename_stage_io_ren2_uops_0_uses_stq;
  wire        _rename_stage_io_ren2_uops_0_is_sys_pc2epc;
  wire        _rename_stage_io_ren2_uops_0_is_unique;
  wire        _rename_stage_io_ren2_uops_0_flush_on_commit;
  wire [5:0]  _rename_stage_io_ren2_uops_0_ldst;
  wire [5:0]  _rename_stage_io_ren2_uops_0_lrs1;
  wire        _rename_stage_io_ren2_uops_0_ldst_val;
  wire [1:0]  _rename_stage_io_ren2_uops_0_dst_rtype;
  wire [1:0]  _rename_stage_io_ren2_uops_0_lrs1_rtype;
  wire [1:0]  _rename_stage_io_ren2_uops_0_lrs2_rtype;
  wire        _rename_stage_io_ren2_uops_0_frs3_en;
  wire        _rename_stage_io_ren2_uops_0_fp_val;
  wire [6:0]  _rename_stage_io_ren2_uops_1_uopc;
  wire        _rename_stage_io_ren2_uops_1_is_rvc;
  wire [2:0]  _rename_stage_io_ren2_uops_1_iq_type;
  wire [9:0]  _rename_stage_io_ren2_uops_1_fu_code;
  wire        _rename_stage_io_ren2_uops_1_is_br;
  wire        _rename_stage_io_ren2_uops_1_is_jalr;
  wire        _rename_stage_io_ren2_uops_1_is_jal;
  wire        _rename_stage_io_ren2_uops_1_is_sfb;
  wire [19:0] _rename_stage_io_ren2_uops_1_br_mask;
  wire [4:0]  _rename_stage_io_ren2_uops_1_br_tag;
  wire [5:0]  _rename_stage_io_ren2_uops_1_ftq_idx;
  wire        _rename_stage_io_ren2_uops_1_edge_inst;
  wire [5:0]  _rename_stage_io_ren2_uops_1_pc_lob;
  wire        _rename_stage_io_ren2_uops_1_taken;
  wire [19:0] _rename_stage_io_ren2_uops_1_imm_packed;
  wire [6:0]  _rename_stage_io_ren2_uops_1_pdst;
  wire [6:0]  _rename_stage_io_ren2_uops_1_prs1;
  wire [6:0]  _rename_stage_io_ren2_uops_1_prs2;
  wire        _rename_stage_io_ren2_uops_1_prs1_busy;
  wire        _rename_stage_io_ren2_uops_1_prs2_busy;
  wire [6:0]  _rename_stage_io_ren2_uops_1_stale_pdst;
  wire        _rename_stage_io_ren2_uops_1_exception;
  wire [63:0] _rename_stage_io_ren2_uops_1_exc_cause;
  wire        _rename_stage_io_ren2_uops_1_bypassable;
  wire [4:0]  _rename_stage_io_ren2_uops_1_mem_cmd;
  wire [1:0]  _rename_stage_io_ren2_uops_1_mem_size;
  wire        _rename_stage_io_ren2_uops_1_mem_signed;
  wire        _rename_stage_io_ren2_uops_1_is_fence;
  wire        _rename_stage_io_ren2_uops_1_is_fencei;
  wire        _rename_stage_io_ren2_uops_1_is_amo;
  wire        _rename_stage_io_ren2_uops_1_uses_ldq;
  wire        _rename_stage_io_ren2_uops_1_uses_stq;
  wire        _rename_stage_io_ren2_uops_1_is_sys_pc2epc;
  wire        _rename_stage_io_ren2_uops_1_is_unique;
  wire        _rename_stage_io_ren2_uops_1_flush_on_commit;
  wire [5:0]  _rename_stage_io_ren2_uops_1_ldst;
  wire [5:0]  _rename_stage_io_ren2_uops_1_lrs1;
  wire        _rename_stage_io_ren2_uops_1_ldst_val;
  wire [1:0]  _rename_stage_io_ren2_uops_1_dst_rtype;
  wire [1:0]  _rename_stage_io_ren2_uops_1_lrs1_rtype;
  wire [1:0]  _rename_stage_io_ren2_uops_1_lrs2_rtype;
  wire        _rename_stage_io_ren2_uops_1_frs3_en;
  wire        _rename_stage_io_ren2_uops_1_fp_val;
  wire [6:0]  _rename_stage_io_ren2_uops_2_uopc;
  wire        _rename_stage_io_ren2_uops_2_is_rvc;
  wire [2:0]  _rename_stage_io_ren2_uops_2_iq_type;
  wire [9:0]  _rename_stage_io_ren2_uops_2_fu_code;
  wire        _rename_stage_io_ren2_uops_2_is_br;
  wire        _rename_stage_io_ren2_uops_2_is_jalr;
  wire        _rename_stage_io_ren2_uops_2_is_jal;
  wire        _rename_stage_io_ren2_uops_2_is_sfb;
  wire [19:0] _rename_stage_io_ren2_uops_2_br_mask;
  wire [4:0]  _rename_stage_io_ren2_uops_2_br_tag;
  wire [5:0]  _rename_stage_io_ren2_uops_2_ftq_idx;
  wire        _rename_stage_io_ren2_uops_2_edge_inst;
  wire [5:0]  _rename_stage_io_ren2_uops_2_pc_lob;
  wire        _rename_stage_io_ren2_uops_2_taken;
  wire [19:0] _rename_stage_io_ren2_uops_2_imm_packed;
  wire [6:0]  _rename_stage_io_ren2_uops_2_pdst;
  wire [6:0]  _rename_stage_io_ren2_uops_2_prs1;
  wire [6:0]  _rename_stage_io_ren2_uops_2_prs2;
  wire        _rename_stage_io_ren2_uops_2_prs1_busy;
  wire        _rename_stage_io_ren2_uops_2_prs2_busy;
  wire [6:0]  _rename_stage_io_ren2_uops_2_stale_pdst;
  wire        _rename_stage_io_ren2_uops_2_exception;
  wire [63:0] _rename_stage_io_ren2_uops_2_exc_cause;
  wire        _rename_stage_io_ren2_uops_2_bypassable;
  wire [4:0]  _rename_stage_io_ren2_uops_2_mem_cmd;
  wire [1:0]  _rename_stage_io_ren2_uops_2_mem_size;
  wire        _rename_stage_io_ren2_uops_2_mem_signed;
  wire        _rename_stage_io_ren2_uops_2_is_fence;
  wire        _rename_stage_io_ren2_uops_2_is_fencei;
  wire        _rename_stage_io_ren2_uops_2_is_amo;
  wire        _rename_stage_io_ren2_uops_2_uses_ldq;
  wire        _rename_stage_io_ren2_uops_2_uses_stq;
  wire        _rename_stage_io_ren2_uops_2_is_sys_pc2epc;
  wire        _rename_stage_io_ren2_uops_2_is_unique;
  wire        _rename_stage_io_ren2_uops_2_flush_on_commit;
  wire [5:0]  _rename_stage_io_ren2_uops_2_ldst;
  wire [5:0]  _rename_stage_io_ren2_uops_2_lrs1;
  wire        _rename_stage_io_ren2_uops_2_ldst_val;
  wire [1:0]  _rename_stage_io_ren2_uops_2_dst_rtype;
  wire [1:0]  _rename_stage_io_ren2_uops_2_lrs1_rtype;
  wire [1:0]  _rename_stage_io_ren2_uops_2_lrs2_rtype;
  wire        _rename_stage_io_ren2_uops_2_frs3_en;
  wire        _rename_stage_io_ren2_uops_2_fp_val;
  wire [6:0]  _rename_stage_io_ren2_uops_3_uopc;
  wire        _rename_stage_io_ren2_uops_3_is_rvc;
  wire [2:0]  _rename_stage_io_ren2_uops_3_iq_type;
  wire [9:0]  _rename_stage_io_ren2_uops_3_fu_code;
  wire        _rename_stage_io_ren2_uops_3_is_br;
  wire        _rename_stage_io_ren2_uops_3_is_jalr;
  wire        _rename_stage_io_ren2_uops_3_is_jal;
  wire        _rename_stage_io_ren2_uops_3_is_sfb;
  wire [19:0] _rename_stage_io_ren2_uops_3_br_mask;
  wire [4:0]  _rename_stage_io_ren2_uops_3_br_tag;
  wire [5:0]  _rename_stage_io_ren2_uops_3_ftq_idx;
  wire        _rename_stage_io_ren2_uops_3_edge_inst;
  wire [5:0]  _rename_stage_io_ren2_uops_3_pc_lob;
  wire        _rename_stage_io_ren2_uops_3_taken;
  wire [19:0] _rename_stage_io_ren2_uops_3_imm_packed;
  wire [6:0]  _rename_stage_io_ren2_uops_3_pdst;
  wire [6:0]  _rename_stage_io_ren2_uops_3_prs1;
  wire [6:0]  _rename_stage_io_ren2_uops_3_prs2;
  wire        _rename_stage_io_ren2_uops_3_prs1_busy;
  wire        _rename_stage_io_ren2_uops_3_prs2_busy;
  wire [6:0]  _rename_stage_io_ren2_uops_3_stale_pdst;
  wire        _rename_stage_io_ren2_uops_3_exception;
  wire [63:0] _rename_stage_io_ren2_uops_3_exc_cause;
  wire        _rename_stage_io_ren2_uops_3_bypassable;
  wire [4:0]  _rename_stage_io_ren2_uops_3_mem_cmd;
  wire [1:0]  _rename_stage_io_ren2_uops_3_mem_size;
  wire        _rename_stage_io_ren2_uops_3_mem_signed;
  wire        _rename_stage_io_ren2_uops_3_is_fence;
  wire        _rename_stage_io_ren2_uops_3_is_fencei;
  wire        _rename_stage_io_ren2_uops_3_is_amo;
  wire        _rename_stage_io_ren2_uops_3_uses_ldq;
  wire        _rename_stage_io_ren2_uops_3_uses_stq;
  wire        _rename_stage_io_ren2_uops_3_is_sys_pc2epc;
  wire        _rename_stage_io_ren2_uops_3_is_unique;
  wire        _rename_stage_io_ren2_uops_3_flush_on_commit;
  wire [5:0]  _rename_stage_io_ren2_uops_3_ldst;
  wire [5:0]  _rename_stage_io_ren2_uops_3_lrs1;
  wire        _rename_stage_io_ren2_uops_3_ldst_val;
  wire [1:0]  _rename_stage_io_ren2_uops_3_dst_rtype;
  wire [1:0]  _rename_stage_io_ren2_uops_3_lrs1_rtype;
  wire [1:0]  _rename_stage_io_ren2_uops_3_lrs2_rtype;
  wire        _rename_stage_io_ren2_uops_3_frs3_en;
  wire        _rename_stage_io_ren2_uops_3_fp_val;
  wire [4:0]  _dec_brmask_logic_io_br_tag_0;
  wire [4:0]  _dec_brmask_logic_io_br_tag_1;
  wire [4:0]  _dec_brmask_logic_io_br_tag_2;
  wire [4:0]  _dec_brmask_logic_io_br_tag_3;
  wire [19:0] _dec_brmask_logic_io_br_mask_0;
  wire [19:0] _dec_brmask_logic_io_br_mask_1;
  wire [19:0] _dec_brmask_logic_io_br_mask_2;
  wire [19:0] _dec_brmask_logic_io_br_mask_3;
  wire        _dec_brmask_logic_io_is_full_0;
  wire        _dec_brmask_logic_io_is_full_1;
  wire        _dec_brmask_logic_io_is_full_2;
  wire        _dec_brmask_logic_io_is_full_3;
  wire [6:0]  _decode_units_3_io_deq_uop_uopc;
  wire        _decode_units_3_io_deq_uop_is_rvc;
  wire [2:0]  _decode_units_3_io_deq_uop_iq_type;
  wire [9:0]  _decode_units_3_io_deq_uop_fu_code;
  wire        _decode_units_3_io_deq_uop_ctrl_is_load;
  wire        _decode_units_3_io_deq_uop_ctrl_is_sta;
  wire        _decode_units_3_io_deq_uop_is_br;
  wire        _decode_units_3_io_deq_uop_is_jalr;
  wire        _decode_units_3_io_deq_uop_is_jal;
  wire        _decode_units_3_io_deq_uop_is_sfb;
  wire [5:0]  _decode_units_3_io_deq_uop_ftq_idx;
  wire        _decode_units_3_io_deq_uop_edge_inst;
  wire [5:0]  _decode_units_3_io_deq_uop_pc_lob;
  wire        _decode_units_3_io_deq_uop_taken;
  wire [19:0] _decode_units_3_io_deq_uop_imm_packed;
  wire        _decode_units_3_io_deq_uop_exception;
  wire [63:0] _decode_units_3_io_deq_uop_exc_cause;
  wire        _decode_units_3_io_deq_uop_bypassable;
  wire [4:0]  _decode_units_3_io_deq_uop_mem_cmd;
  wire [1:0]  _decode_units_3_io_deq_uop_mem_size;
  wire        _decode_units_3_io_deq_uop_mem_signed;
  wire        _decode_units_3_io_deq_uop_is_fence;
  wire        _decode_units_3_io_deq_uop_is_fencei;
  wire        _decode_units_3_io_deq_uop_is_amo;
  wire        _decode_units_3_io_deq_uop_uses_ldq;
  wire        _decode_units_3_io_deq_uop_uses_stq;
  wire        _decode_units_3_io_deq_uop_is_sys_pc2epc;
  wire        _decode_units_3_io_deq_uop_is_unique;
  wire        _decode_units_3_io_deq_uop_flush_on_commit;
  wire [5:0]  _decode_units_3_io_deq_uop_ldst;
  wire [5:0]  _decode_units_3_io_deq_uop_lrs1;
  wire [5:0]  _decode_units_3_io_deq_uop_lrs2;
  wire [5:0]  _decode_units_3_io_deq_uop_lrs3;
  wire        _decode_units_3_io_deq_uop_ldst_val;
  wire [1:0]  _decode_units_3_io_deq_uop_dst_rtype;
  wire [1:0]  _decode_units_3_io_deq_uop_lrs1_rtype;
  wire [1:0]  _decode_units_3_io_deq_uop_lrs2_rtype;
  wire        _decode_units_3_io_deq_uop_frs3_en;
  wire        _decode_units_3_io_deq_uop_fp_val;
  wire [31:0] _decode_units_3_io_csr_decode_inst;
  wire [6:0]  _decode_units_2_io_deq_uop_uopc;
  wire        _decode_units_2_io_deq_uop_is_rvc;
  wire [2:0]  _decode_units_2_io_deq_uop_iq_type;
  wire [9:0]  _decode_units_2_io_deq_uop_fu_code;
  wire        _decode_units_2_io_deq_uop_ctrl_is_load;
  wire        _decode_units_2_io_deq_uop_ctrl_is_sta;
  wire        _decode_units_2_io_deq_uop_is_br;
  wire        _decode_units_2_io_deq_uop_is_jalr;
  wire        _decode_units_2_io_deq_uop_is_jal;
  wire        _decode_units_2_io_deq_uop_is_sfb;
  wire [5:0]  _decode_units_2_io_deq_uop_ftq_idx;
  wire        _decode_units_2_io_deq_uop_edge_inst;
  wire [5:0]  _decode_units_2_io_deq_uop_pc_lob;
  wire        _decode_units_2_io_deq_uop_taken;
  wire [19:0] _decode_units_2_io_deq_uop_imm_packed;
  wire        _decode_units_2_io_deq_uop_exception;
  wire [63:0] _decode_units_2_io_deq_uop_exc_cause;
  wire        _decode_units_2_io_deq_uop_bypassable;
  wire [4:0]  _decode_units_2_io_deq_uop_mem_cmd;
  wire [1:0]  _decode_units_2_io_deq_uop_mem_size;
  wire        _decode_units_2_io_deq_uop_mem_signed;
  wire        _decode_units_2_io_deq_uop_is_fence;
  wire        _decode_units_2_io_deq_uop_is_fencei;
  wire        _decode_units_2_io_deq_uop_is_amo;
  wire        _decode_units_2_io_deq_uop_uses_ldq;
  wire        _decode_units_2_io_deq_uop_uses_stq;
  wire        _decode_units_2_io_deq_uop_is_sys_pc2epc;
  wire        _decode_units_2_io_deq_uop_is_unique;
  wire        _decode_units_2_io_deq_uop_flush_on_commit;
  wire [5:0]  _decode_units_2_io_deq_uop_ldst;
  wire [5:0]  _decode_units_2_io_deq_uop_lrs1;
  wire [5:0]  _decode_units_2_io_deq_uop_lrs2;
  wire [5:0]  _decode_units_2_io_deq_uop_lrs3;
  wire        _decode_units_2_io_deq_uop_ldst_val;
  wire [1:0]  _decode_units_2_io_deq_uop_dst_rtype;
  wire [1:0]  _decode_units_2_io_deq_uop_lrs1_rtype;
  wire [1:0]  _decode_units_2_io_deq_uop_lrs2_rtype;
  wire        _decode_units_2_io_deq_uop_frs3_en;
  wire        _decode_units_2_io_deq_uop_fp_val;
  wire [31:0] _decode_units_2_io_csr_decode_inst;
  wire [6:0]  _decode_units_1_io_deq_uop_uopc;
  wire        _decode_units_1_io_deq_uop_is_rvc;
  wire [2:0]  _decode_units_1_io_deq_uop_iq_type;
  wire [9:0]  _decode_units_1_io_deq_uop_fu_code;
  wire        _decode_units_1_io_deq_uop_ctrl_is_load;
  wire        _decode_units_1_io_deq_uop_ctrl_is_sta;
  wire        _decode_units_1_io_deq_uop_is_br;
  wire        _decode_units_1_io_deq_uop_is_jalr;
  wire        _decode_units_1_io_deq_uop_is_jal;
  wire        _decode_units_1_io_deq_uop_is_sfb;
  wire [5:0]  _decode_units_1_io_deq_uop_ftq_idx;
  wire        _decode_units_1_io_deq_uop_edge_inst;
  wire [5:0]  _decode_units_1_io_deq_uop_pc_lob;
  wire        _decode_units_1_io_deq_uop_taken;
  wire [19:0] _decode_units_1_io_deq_uop_imm_packed;
  wire        _decode_units_1_io_deq_uop_exception;
  wire [63:0] _decode_units_1_io_deq_uop_exc_cause;
  wire        _decode_units_1_io_deq_uop_bypassable;
  wire [4:0]  _decode_units_1_io_deq_uop_mem_cmd;
  wire [1:0]  _decode_units_1_io_deq_uop_mem_size;
  wire        _decode_units_1_io_deq_uop_mem_signed;
  wire        _decode_units_1_io_deq_uop_is_fence;
  wire        _decode_units_1_io_deq_uop_is_fencei;
  wire        _decode_units_1_io_deq_uop_is_amo;
  wire        _decode_units_1_io_deq_uop_uses_ldq;
  wire        _decode_units_1_io_deq_uop_uses_stq;
  wire        _decode_units_1_io_deq_uop_is_sys_pc2epc;
  wire        _decode_units_1_io_deq_uop_is_unique;
  wire        _decode_units_1_io_deq_uop_flush_on_commit;
  wire [5:0]  _decode_units_1_io_deq_uop_ldst;
  wire [5:0]  _decode_units_1_io_deq_uop_lrs1;
  wire [5:0]  _decode_units_1_io_deq_uop_lrs2;
  wire [5:0]  _decode_units_1_io_deq_uop_lrs3;
  wire        _decode_units_1_io_deq_uop_ldst_val;
  wire [1:0]  _decode_units_1_io_deq_uop_dst_rtype;
  wire [1:0]  _decode_units_1_io_deq_uop_lrs1_rtype;
  wire [1:0]  _decode_units_1_io_deq_uop_lrs2_rtype;
  wire        _decode_units_1_io_deq_uop_frs3_en;
  wire        _decode_units_1_io_deq_uop_fp_val;
  wire [31:0] _decode_units_1_io_csr_decode_inst;
  wire [6:0]  _decode_units_0_io_deq_uop_uopc;
  wire        _decode_units_0_io_deq_uop_is_rvc;
  wire [2:0]  _decode_units_0_io_deq_uop_iq_type;
  wire [9:0]  _decode_units_0_io_deq_uop_fu_code;
  wire        _decode_units_0_io_deq_uop_ctrl_is_load;
  wire        _decode_units_0_io_deq_uop_ctrl_is_sta;
  wire        _decode_units_0_io_deq_uop_is_br;
  wire        _decode_units_0_io_deq_uop_is_jalr;
  wire        _decode_units_0_io_deq_uop_is_jal;
  wire        _decode_units_0_io_deq_uop_is_sfb;
  wire [5:0]  _decode_units_0_io_deq_uop_ftq_idx;
  wire        _decode_units_0_io_deq_uop_edge_inst;
  wire [5:0]  _decode_units_0_io_deq_uop_pc_lob;
  wire        _decode_units_0_io_deq_uop_taken;
  wire [19:0] _decode_units_0_io_deq_uop_imm_packed;
  wire        _decode_units_0_io_deq_uop_exception;
  wire [63:0] _decode_units_0_io_deq_uop_exc_cause;
  wire        _decode_units_0_io_deq_uop_bypassable;
  wire [4:0]  _decode_units_0_io_deq_uop_mem_cmd;
  wire [1:0]  _decode_units_0_io_deq_uop_mem_size;
  wire        _decode_units_0_io_deq_uop_mem_signed;
  wire        _decode_units_0_io_deq_uop_is_fence;
  wire        _decode_units_0_io_deq_uop_is_fencei;
  wire        _decode_units_0_io_deq_uop_is_amo;
  wire        _decode_units_0_io_deq_uop_uses_ldq;
  wire        _decode_units_0_io_deq_uop_uses_stq;
  wire        _decode_units_0_io_deq_uop_is_sys_pc2epc;
  wire        _decode_units_0_io_deq_uop_is_unique;
  wire        _decode_units_0_io_deq_uop_flush_on_commit;
  wire [5:0]  _decode_units_0_io_deq_uop_ldst;
  wire [5:0]  _decode_units_0_io_deq_uop_lrs1;
  wire [5:0]  _decode_units_0_io_deq_uop_lrs2;
  wire [5:0]  _decode_units_0_io_deq_uop_lrs3;
  wire        _decode_units_0_io_deq_uop_ldst_val;
  wire [1:0]  _decode_units_0_io_deq_uop_dst_rtype;
  wire [1:0]  _decode_units_0_io_deq_uop_lrs1_rtype;
  wire [1:0]  _decode_units_0_io_deq_uop_lrs2_rtype;
  wire        _decode_units_0_io_deq_uop_frs3_en;
  wire        _decode_units_0_io_deq_uop_fp_val;
  wire [31:0] _decode_units_0_io_csr_decode_inst;
  wire        _FpPipeline_io_dis_uops_0_ready;
  wire        _FpPipeline_io_dis_uops_1_ready;
  wire        _FpPipeline_io_dis_uops_2_ready;
  wire        _FpPipeline_io_dis_uops_3_ready;
  wire        _FpPipeline_io_from_int_ready;
  wire        _FpPipeline_io_to_int_valid;
  wire [6:0]  _FpPipeline_io_to_int_bits_uop_rob_idx;
  wire [6:0]  _FpPipeline_io_to_int_bits_uop_pdst;
  wire        _FpPipeline_io_to_int_bits_uop_is_amo;
  wire        _FpPipeline_io_to_int_bits_uop_uses_stq;
  wire [1:0]  _FpPipeline_io_to_int_bits_uop_dst_rtype;
  wire [63:0] _FpPipeline_io_to_int_bits_data;
  wire        _FpPipeline_io_to_int_bits_predicated;
  wire        _FpPipeline_io_wakeups_0_valid;
  wire [6:0]  _FpPipeline_io_wakeups_0_bits_uop_rob_idx;
  wire [6:0]  _FpPipeline_io_wakeups_0_bits_uop_pdst;
  wire [1:0]  _FpPipeline_io_wakeups_0_bits_uop_dst_rtype;
  wire        _FpPipeline_io_wakeups_0_bits_uop_fp_val;
  wire        _FpPipeline_io_wakeups_0_bits_predicated;
  wire        _FpPipeline_io_wakeups_0_bits_fflags_valid;
  wire [6:0]  _FpPipeline_io_wakeups_0_bits_fflags_bits_uop_rob_idx;
  wire [4:0]  _FpPipeline_io_wakeups_0_bits_fflags_bits_flags;
  wire        _FpPipeline_io_wakeups_1_valid;
  wire [6:0]  _FpPipeline_io_wakeups_1_bits_uop_rob_idx;
  wire [6:0]  _FpPipeline_io_wakeups_1_bits_uop_pdst;
  wire [1:0]  _FpPipeline_io_wakeups_1_bits_uop_dst_rtype;
  wire        _FpPipeline_io_wakeups_1_bits_uop_fp_val;
  wire        _FpPipeline_io_wakeups_2_valid;
  wire [6:0]  _FpPipeline_io_wakeups_2_bits_uop_rob_idx;
  wire [6:0]  _FpPipeline_io_wakeups_2_bits_uop_pdst;
  wire [1:0]  _FpPipeline_io_wakeups_2_bits_uop_dst_rtype;
  wire        _FpPipeline_io_wakeups_2_bits_uop_fp_val;
  wire        _FpPipeline_io_wakeups_2_bits_fflags_valid;
  wire [6:0]  _FpPipeline_io_wakeups_2_bits_fflags_bits_uop_rob_idx;
  wire [4:0]  _FpPipeline_io_wakeups_2_bits_fflags_bits_flags;
  wire        _FpPipeline_io_wakeups_3_valid;
  wire [6:0]  _FpPipeline_io_wakeups_3_bits_uop_rob_idx;
  wire [6:0]  _FpPipeline_io_wakeups_3_bits_uop_pdst;
  wire [1:0]  _FpPipeline_io_wakeups_3_bits_uop_dst_rtype;
  wire        _FpPipeline_io_wakeups_3_bits_uop_fp_val;
  wire        _FpPipeline_io_wakeups_3_bits_fflags_valid;
  wire [6:0]  _FpPipeline_io_wakeups_3_bits_fflags_bits_uop_rob_idx;
  wire [4:0]  _FpPipeline_io_wakeups_3_bits_fflags_bits_flags;
  wire [9:0]  _alu_exe_unit_3_io_fu_types;
  wire        _alu_exe_unit_3_io_iresp_valid;
  wire [6:0]  _alu_exe_unit_3_io_iresp_bits_uop_rob_idx;
  wire [6:0]  _alu_exe_unit_3_io_iresp_bits_uop_pdst;
  wire        _alu_exe_unit_3_io_iresp_bits_uop_bypassable;
  wire        _alu_exe_unit_3_io_iresp_bits_uop_is_amo;
  wire        _alu_exe_unit_3_io_iresp_bits_uop_uses_stq;
  wire [1:0]  _alu_exe_unit_3_io_iresp_bits_uop_dst_rtype;
  wire [64:0] _alu_exe_unit_3_io_iresp_bits_data;
  wire        _alu_exe_unit_3_io_bypass_0_valid;
  wire [6:0]  _alu_exe_unit_3_io_bypass_0_bits_uop_pdst;
  wire [1:0]  _alu_exe_unit_3_io_bypass_0_bits_uop_dst_rtype;
  wire [64:0] _alu_exe_unit_3_io_bypass_0_bits_data;
  wire        _alu_exe_unit_3_io_brinfo_uop_is_rvc;
  wire [19:0] _alu_exe_unit_3_io_brinfo_uop_br_mask;
  wire [4:0]  _alu_exe_unit_3_io_brinfo_uop_br_tag;
  wire [5:0]  _alu_exe_unit_3_io_brinfo_uop_ftq_idx;
  wire        _alu_exe_unit_3_io_brinfo_uop_edge_inst;
  wire [5:0]  _alu_exe_unit_3_io_brinfo_uop_pc_lob;
  wire [6:0]  _alu_exe_unit_3_io_brinfo_uop_rob_idx;
  wire [4:0]  _alu_exe_unit_3_io_brinfo_uop_ldq_idx;
  wire [4:0]  _alu_exe_unit_3_io_brinfo_uop_stq_idx;
  wire        _alu_exe_unit_3_io_brinfo_valid;
  wire        _alu_exe_unit_3_io_brinfo_mispredict;
  wire        _alu_exe_unit_3_io_brinfo_taken;
  wire [2:0]  _alu_exe_unit_3_io_brinfo_cfi_type;
  wire [1:0]  _alu_exe_unit_3_io_brinfo_pc_sel;
  wire [20:0] _alu_exe_unit_3_io_brinfo_target_offset;
  wire        _alu_exe_unit_2_io_iresp_valid;
  wire [6:0]  _alu_exe_unit_2_io_iresp_bits_uop_rob_idx;
  wire [6:0]  _alu_exe_unit_2_io_iresp_bits_uop_pdst;
  wire        _alu_exe_unit_2_io_iresp_bits_uop_bypassable;
  wire        _alu_exe_unit_2_io_iresp_bits_uop_is_amo;
  wire        _alu_exe_unit_2_io_iresp_bits_uop_uses_stq;
  wire [1:0]  _alu_exe_unit_2_io_iresp_bits_uop_dst_rtype;
  wire [64:0] _alu_exe_unit_2_io_iresp_bits_data;
  wire        _alu_exe_unit_2_io_bypass_0_valid;
  wire [6:0]  _alu_exe_unit_2_io_bypass_0_bits_uop_pdst;
  wire [1:0]  _alu_exe_unit_2_io_bypass_0_bits_uop_dst_rtype;
  wire [64:0] _alu_exe_unit_2_io_bypass_0_bits_data;
  wire        _alu_exe_unit_2_io_bypass_1_valid;
  wire [6:0]  _alu_exe_unit_2_io_bypass_1_bits_uop_pdst;
  wire [1:0]  _alu_exe_unit_2_io_bypass_1_bits_uop_dst_rtype;
  wire [64:0] _alu_exe_unit_2_io_bypass_1_bits_data;
  wire        _alu_exe_unit_2_io_bypass_2_valid;
  wire [6:0]  _alu_exe_unit_2_io_bypass_2_bits_uop_pdst;
  wire [1:0]  _alu_exe_unit_2_io_bypass_2_bits_uop_dst_rtype;
  wire [64:0] _alu_exe_unit_2_io_bypass_2_bits_data;
  wire        _alu_exe_unit_2_io_brinfo_uop_is_rvc;
  wire [19:0] _alu_exe_unit_2_io_brinfo_uop_br_mask;
  wire [4:0]  _alu_exe_unit_2_io_brinfo_uop_br_tag;
  wire [5:0]  _alu_exe_unit_2_io_brinfo_uop_ftq_idx;
  wire        _alu_exe_unit_2_io_brinfo_uop_edge_inst;
  wire [5:0]  _alu_exe_unit_2_io_brinfo_uop_pc_lob;
  wire [6:0]  _alu_exe_unit_2_io_brinfo_uop_rob_idx;
  wire [4:0]  _alu_exe_unit_2_io_brinfo_uop_ldq_idx;
  wire [4:0]  _alu_exe_unit_2_io_brinfo_uop_stq_idx;
  wire        _alu_exe_unit_2_io_brinfo_valid;
  wire        _alu_exe_unit_2_io_brinfo_mispredict;
  wire        _alu_exe_unit_2_io_brinfo_taken;
  wire [2:0]  _alu_exe_unit_2_io_brinfo_cfi_type;
  wire [1:0]  _alu_exe_unit_2_io_brinfo_pc_sel;
  wire [20:0] _alu_exe_unit_2_io_brinfo_target_offset;
  wire        _alu_exe_unit_1_io_iresp_valid;
  wire [2:0]  _alu_exe_unit_1_io_iresp_bits_uop_ctrl_csr_cmd;
  wire [11:0] _alu_exe_unit_1_io_iresp_bits_uop_csr_addr;
  wire [6:0]  _alu_exe_unit_1_io_iresp_bits_uop_rob_idx;
  wire [6:0]  _alu_exe_unit_1_io_iresp_bits_uop_pdst;
  wire        _alu_exe_unit_1_io_iresp_bits_uop_bypassable;
  wire        _alu_exe_unit_1_io_iresp_bits_uop_is_amo;
  wire        _alu_exe_unit_1_io_iresp_bits_uop_uses_stq;
  wire [1:0]  _alu_exe_unit_1_io_iresp_bits_uop_dst_rtype;
  wire [64:0] _alu_exe_unit_1_io_iresp_bits_data;
  wire        _alu_exe_unit_1_io_bypass_0_valid;
  wire [6:0]  _alu_exe_unit_1_io_bypass_0_bits_uop_pdst;
  wire [1:0]  _alu_exe_unit_1_io_bypass_0_bits_uop_dst_rtype;
  wire [64:0] _alu_exe_unit_1_io_bypass_0_bits_data;
  wire        _alu_exe_unit_1_io_brinfo_uop_is_rvc;
  wire [19:0] _alu_exe_unit_1_io_brinfo_uop_br_mask;
  wire [4:0]  _alu_exe_unit_1_io_brinfo_uop_br_tag;
  wire [5:0]  _alu_exe_unit_1_io_brinfo_uop_ftq_idx;
  wire        _alu_exe_unit_1_io_brinfo_uop_edge_inst;
  wire [5:0]  _alu_exe_unit_1_io_brinfo_uop_pc_lob;
  wire [6:0]  _alu_exe_unit_1_io_brinfo_uop_rob_idx;
  wire [4:0]  _alu_exe_unit_1_io_brinfo_uop_ldq_idx;
  wire [4:0]  _alu_exe_unit_1_io_brinfo_uop_stq_idx;
  wire        _alu_exe_unit_1_io_brinfo_valid;
  wire        _alu_exe_unit_1_io_brinfo_mispredict;
  wire        _alu_exe_unit_1_io_brinfo_taken;
  wire [2:0]  _alu_exe_unit_1_io_brinfo_cfi_type;
  wire [1:0]  _alu_exe_unit_1_io_brinfo_pc_sel;
  wire [20:0] _alu_exe_unit_1_io_brinfo_target_offset;
  wire [9:0]  _alu_exe_unit_io_fu_types;
  wire        _alu_exe_unit_io_iresp_valid;
  wire [6:0]  _alu_exe_unit_io_iresp_bits_uop_rob_idx;
  wire [6:0]  _alu_exe_unit_io_iresp_bits_uop_pdst;
  wire        _alu_exe_unit_io_iresp_bits_uop_bypassable;
  wire        _alu_exe_unit_io_iresp_bits_uop_is_amo;
  wire        _alu_exe_unit_io_iresp_bits_uop_uses_stq;
  wire [1:0]  _alu_exe_unit_io_iresp_bits_uop_dst_rtype;
  wire [64:0] _alu_exe_unit_io_iresp_bits_data;
  wire        _alu_exe_unit_io_ll_fresp_valid;
  wire [6:0]  _alu_exe_unit_io_ll_fresp_bits_uop_uopc;
  wire [19:0] _alu_exe_unit_io_ll_fresp_bits_uop_br_mask;
  wire [6:0]  _alu_exe_unit_io_ll_fresp_bits_uop_rob_idx;
  wire [4:0]  _alu_exe_unit_io_ll_fresp_bits_uop_stq_idx;
  wire [6:0]  _alu_exe_unit_io_ll_fresp_bits_uop_pdst;
  wire        _alu_exe_unit_io_ll_fresp_bits_uop_is_amo;
  wire        _alu_exe_unit_io_ll_fresp_bits_uop_uses_stq;
  wire [1:0]  _alu_exe_unit_io_ll_fresp_bits_uop_dst_rtype;
  wire        _alu_exe_unit_io_ll_fresp_bits_uop_fp_val;
  wire [64:0] _alu_exe_unit_io_ll_fresp_bits_data;
  wire        _alu_exe_unit_io_ll_fresp_bits_predicated;
  wire        _alu_exe_unit_io_ll_fresp_bits_fflags_valid;
  wire [6:0]  _alu_exe_unit_io_ll_fresp_bits_fflags_bits_uop_rob_idx;
  wire [4:0]  _alu_exe_unit_io_ll_fresp_bits_fflags_bits_flags;
  wire        _alu_exe_unit_io_bypass_0_valid;
  wire [6:0]  _alu_exe_unit_io_bypass_0_bits_uop_pdst;
  wire [1:0]  _alu_exe_unit_io_bypass_0_bits_uop_dst_rtype;
  wire [64:0] _alu_exe_unit_io_bypass_0_bits_data;
  wire        _alu_exe_unit_io_brinfo_uop_is_rvc;
  wire [19:0] _alu_exe_unit_io_brinfo_uop_br_mask;
  wire [4:0]  _alu_exe_unit_io_brinfo_uop_br_tag;
  wire [5:0]  _alu_exe_unit_io_brinfo_uop_ftq_idx;
  wire        _alu_exe_unit_io_brinfo_uop_edge_inst;
  wire [5:0]  _alu_exe_unit_io_brinfo_uop_pc_lob;
  wire [6:0]  _alu_exe_unit_io_brinfo_uop_rob_idx;
  wire [4:0]  _alu_exe_unit_io_brinfo_uop_ldq_idx;
  wire [4:0]  _alu_exe_unit_io_brinfo_uop_stq_idx;
  wire        _alu_exe_unit_io_brinfo_valid;
  wire        _alu_exe_unit_io_brinfo_mispredict;
  wire        _alu_exe_unit_io_brinfo_taken;
  wire [2:0]  _alu_exe_unit_io_brinfo_cfi_type;
  wire [1:0]  _alu_exe_unit_io_brinfo_pc_sel;
  wire [39:0] _alu_exe_unit_io_brinfo_jalr_target;
  wire [20:0] _alu_exe_unit_io_brinfo_target_offset;
  wire        _memExeUnit_1_io_ll_iresp_valid;
  wire [6:0]  _memExeUnit_1_io_ll_iresp_bits_uop_rob_idx;
  wire [6:0]  _memExeUnit_1_io_ll_iresp_bits_uop_pdst;
  wire        _memExeUnit_1_io_ll_iresp_bits_uop_is_amo;
  wire        _memExeUnit_1_io_ll_iresp_bits_uop_uses_stq;
  wire [1:0]  _memExeUnit_1_io_ll_iresp_bits_uop_dst_rtype;
  wire [64:0] _memExeUnit_1_io_ll_iresp_bits_data;
  wire        _memExeUnit_1_io_ll_fresp_valid;
  wire [6:0]  _memExeUnit_1_io_ll_fresp_bits_uop_rob_idx;
  wire [6:0]  _memExeUnit_1_io_ll_fresp_bits_uop_pdst;
  wire [1:0]  _memExeUnit_1_io_ll_fresp_bits_uop_mem_size;
  wire [1:0]  _memExeUnit_1_io_ll_fresp_bits_uop_dst_rtype;
  wire        _memExeUnit_1_io_ll_fresp_bits_uop_fp_val;
  wire [64:0] _memExeUnit_1_io_ll_fresp_bits_data;
  wire        _memExeUnit_1_io_lsu_io_req_bits_sfence_valid;
  wire        _memExeUnit_1_io_lsu_io_req_bits_sfence_bits_rs1;
  wire        _memExeUnit_1_io_lsu_io_req_bits_sfence_bits_rs2;
  wire [38:0] _memExeUnit_1_io_lsu_io_req_bits_sfence_bits_addr;
  wire        _memExeUnit_io_ll_iresp_valid;
  wire [6:0]  _memExeUnit_io_ll_iresp_bits_uop_rob_idx;
  wire [6:0]  _memExeUnit_io_ll_iresp_bits_uop_pdst;
  wire        _memExeUnit_io_ll_iresp_bits_uop_is_amo;
  wire        _memExeUnit_io_ll_iresp_bits_uop_uses_stq;
  wire [1:0]  _memExeUnit_io_ll_iresp_bits_uop_dst_rtype;
  wire [64:0] _memExeUnit_io_ll_iresp_bits_data;
  wire        _memExeUnit_io_ll_fresp_valid;
  wire [6:0]  _memExeUnit_io_ll_fresp_bits_uop_uopc;
  wire [19:0] _memExeUnit_io_ll_fresp_bits_uop_br_mask;
  wire [6:0]  _memExeUnit_io_ll_fresp_bits_uop_rob_idx;
  wire [4:0]  _memExeUnit_io_ll_fresp_bits_uop_stq_idx;
  wire [6:0]  _memExeUnit_io_ll_fresp_bits_uop_pdst;
  wire [1:0]  _memExeUnit_io_ll_fresp_bits_uop_mem_size;
  wire        _memExeUnit_io_ll_fresp_bits_uop_is_amo;
  wire        _memExeUnit_io_ll_fresp_bits_uop_uses_stq;
  wire [1:0]  _memExeUnit_io_ll_fresp_bits_uop_dst_rtype;
  wire        _memExeUnit_io_ll_fresp_bits_uop_fp_val;
  wire [64:0] _memExeUnit_io_ll_fresp_bits_data;
  wire        _memExeUnit_io_lsu_io_req_bits_sfence_valid;
  wire        _memExeUnit_io_lsu_io_req_bits_sfence_bits_rs1;
  wire        _memExeUnit_io_lsu_io_req_bits_sfence_bits_rs2;
  wire [38:0] _memExeUnit_io_lsu_io_req_bits_sfence_bits_addr;
  reg  [5:0]  casez_tmp;
  reg  [5:0]  casez_tmp_0;
  reg         casez_tmp_1;
  reg  [5:0]  casez_tmp_2;
  reg         brinfos_0_uop_is_rvc;
  reg  [19:0] brinfos_0_uop_br_mask;
  reg  [4:0]  brinfos_0_uop_br_tag;
  reg  [5:0]  brinfos_0_uop_ftq_idx;
  reg         brinfos_0_uop_edge_inst;
  reg  [5:0]  brinfos_0_uop_pc_lob;
  reg  [6:0]  brinfos_0_uop_rob_idx;
  reg  [4:0]  brinfos_0_uop_ldq_idx;
  reg  [4:0]  brinfos_0_uop_stq_idx;
  reg         brinfos_0_valid;
  reg         brinfos_0_mispredict;
  reg         brinfos_0_taken;
  reg  [2:0]  brinfos_0_cfi_type;
  reg  [1:0]  brinfos_0_pc_sel;
  reg  [20:0] brinfos_0_target_offset;
  reg         brinfos_1_uop_is_rvc;
  reg  [19:0] brinfos_1_uop_br_mask;
  reg  [4:0]  brinfos_1_uop_br_tag;
  reg  [5:0]  brinfos_1_uop_ftq_idx;
  reg         brinfos_1_uop_edge_inst;
  reg  [5:0]  brinfos_1_uop_pc_lob;
  reg  [6:0]  brinfos_1_uop_rob_idx;
  reg  [4:0]  brinfos_1_uop_ldq_idx;
  reg  [4:0]  brinfos_1_uop_stq_idx;
  reg         brinfos_1_valid;
  reg         brinfos_1_mispredict;
  reg         brinfos_1_taken;
  reg  [2:0]  brinfos_1_cfi_type;
  reg  [1:0]  brinfos_1_pc_sel;
  reg  [20:0] brinfos_1_target_offset;
  reg         brinfos_2_uop_is_rvc;
  reg  [19:0] brinfos_2_uop_br_mask;
  reg  [4:0]  brinfos_2_uop_br_tag;
  reg  [5:0]  brinfos_2_uop_ftq_idx;
  reg         brinfos_2_uop_edge_inst;
  reg  [5:0]  brinfos_2_uop_pc_lob;
  reg  [6:0]  brinfos_2_uop_rob_idx;
  reg  [4:0]  brinfos_2_uop_ldq_idx;
  reg  [4:0]  brinfos_2_uop_stq_idx;
  reg         brinfos_2_valid;
  reg         brinfos_2_mispredict;
  reg         brinfos_2_taken;
  reg  [2:0]  brinfos_2_cfi_type;
  reg  [1:0]  brinfos_2_pc_sel;
  reg  [20:0] brinfos_2_target_offset;
  reg         brinfos_3_uop_is_rvc;
  reg  [19:0] brinfos_3_uop_br_mask;
  reg  [4:0]  brinfos_3_uop_br_tag;
  reg  [5:0]  brinfos_3_uop_ftq_idx;
  reg         brinfos_3_uop_edge_inst;
  reg  [5:0]  brinfos_3_uop_pc_lob;
  reg  [6:0]  brinfos_3_uop_rob_idx;
  reg  [4:0]  brinfos_3_uop_ldq_idx;
  reg  [4:0]  brinfos_3_uop_stq_idx;
  reg         brinfos_3_valid;
  reg         brinfos_3_mispredict;
  reg         brinfos_3_taken;
  reg  [2:0]  brinfos_3_cfi_type;
  reg  [1:0]  brinfos_3_pc_sel;
  reg  [20:0] brinfos_3_target_offset;
  reg         b2_uop_is_rvc;
  reg  [19:0] b2_uop_br_mask;
  reg  [4:0]  b2_uop_br_tag;
  reg  [5:0]  b2_uop_ftq_idx;
  reg         b2_uop_edge_inst;
  reg  [5:0]  b2_uop_pc_lob;
  reg  [6:0]  b2_uop_rob_idx;
  reg  [4:0]  b2_uop_ldq_idx;
  reg  [4:0]  b2_uop_stq_idx;
  reg         b2_mispredict;
  reg         b2_taken;
  reg  [2:0]  b2_cfi_type;
  reg  [1:0]  b2_pc_sel;
  reg  [39:0] b2_jalr_target;
  reg  [20:0] b2_target_offset;
  wire [31:0] _GEN = {27'h0, brinfos_0_uop_br_tag};
  wire [31:0] _b1_resolve_mask_T = {31'h0, brinfos_0_valid} << _GEN;
  wire [31:0] _GEN_0 = {27'h0, brinfos_1_uop_br_tag};
  wire [31:0] _b1_resolve_mask_T_1 = {31'h0, brinfos_1_valid} << _GEN_0;
  wire [31:0] _GEN_1 = {27'h0, brinfos_2_uop_br_tag};
  wire [31:0] _b1_resolve_mask_T_2 = {31'h0, brinfos_2_valid} << _GEN_1;
  wire [31:0] _GEN_2 = {27'h0, brinfos_3_uop_br_tag};
  wire [31:0] _b1_resolve_mask_T_3 = {31'h0, brinfos_3_valid} << _GEN_2;
  wire [19:0] _b1_resolve_mask_T_6 = _b1_resolve_mask_T[19:0] | _b1_resolve_mask_T_1[19:0] | _b1_resolve_mask_T_2[19:0] | _b1_resolve_mask_T_3[19:0];
  wire        _use_this_mispredict_T_1 = brinfos_0_valid & brinfos_0_mispredict;
  wire [31:0] _b1_mispredict_mask_T_1 = {31'h0, _use_this_mispredict_T_1} << _GEN;
  wire        _use_this_mispredict_T_9 = brinfos_1_valid & brinfos_1_mispredict;
  wire [31:0] _b1_mispredict_mask_T_3 = {31'h0, _use_this_mispredict_T_9} << _GEN_0;
  wire        _use_this_mispredict_T_17 = brinfos_2_valid & brinfos_2_mispredict;
  wire [31:0] _b1_mispredict_mask_T_5 = {31'h0, _use_this_mispredict_T_17} << _GEN_1;
  wire        _use_this_mispredict_T_25 = brinfos_3_valid & brinfos_3_mispredict;
  wire [31:0] _b1_mispredict_mask_T_7 = {31'h0, _use_this_mispredict_T_25} << _GEN_2;
  wire [19:0] _b1_mispredict_mask_T_10 = _b1_mispredict_mask_T_1[19:0] | _b1_mispredict_mask_T_3[19:0] | _b1_mispredict_mask_T_5[19:0] | _b1_mispredict_mask_T_7[19:0];
  wire        use_this_mispredict_1 = ~_use_this_mispredict_T_1 | _use_this_mispredict_T_9 & (brinfos_1_uop_rob_idx < brinfos_0_uop_rob_idx ^ brinfos_1_uop_rob_idx < _rob_io_rob_head_idx ^ brinfos_0_uop_rob_idx < _rob_io_rob_head_idx);
  wire        _GEN_3 = _use_this_mispredict_T_1 | _use_this_mispredict_T_9;
  wire [6:0]  _GEN_4 = use_this_mispredict_1 ? brinfos_1_uop_rob_idx : brinfos_0_uop_rob_idx;
  wire        use_this_mispredict_2 = ~_GEN_3 | _use_this_mispredict_T_17 & (brinfos_2_uop_rob_idx < _GEN_4 ^ brinfos_2_uop_rob_idx < _rob_io_rob_head_idx ^ _GEN_4 < _rob_io_rob_head_idx);
  wire        _GEN_5 = _GEN_3 | _use_this_mispredict_T_17;
  wire [6:0]  _GEN_6 = use_this_mispredict_2 ? brinfos_2_uop_rob_idx : _GEN_4;
  wire        use_this_mispredict_3 = ~_GEN_5 | _use_this_mispredict_T_25 & (brinfos_3_uop_rob_idx < _GEN_6 ^ brinfos_3_uop_rob_idx < _rob_io_rob_head_idx ^ _GEN_6 < _rob_io_rob_head_idx);
  reg  [39:0] b2_jalr_target_REG;
  reg  [3:0]  dec_finished_mask;
  wire        dec_valids_0 = io_ifu_fetchpacket_valid & io_ifu_fetchpacket_bits_uops_0_valid & ~(dec_finished_mask[0]);
  reg         io_ifu_flush_icache_REG;
  wire        dec_valids_1 = io_ifu_fetchpacket_valid & io_ifu_fetchpacket_bits_uops_1_valid & ~(dec_finished_mask[1]);
  reg         io_ifu_flush_icache_REG_1;
  wire        dec_valids_2 = io_ifu_fetchpacket_valid & io_ifu_fetchpacket_bits_uops_2_valid & ~(dec_finished_mask[2]);
  reg         io_ifu_flush_icache_REG_2;
  wire        dec_valids_3 = io_ifu_fetchpacket_valid & io_ifu_fetchpacket_bits_uops_3_valid & ~(dec_finished_mask[3]);
  reg         io_ifu_flush_icache_REG_3;
  reg         REG;
  reg  [2:0]  flush_typ;
  reg  [39:0] io_ifu_redirect_pc_REG;
  reg  [39:0] io_ifu_redirect_pc_REG_1;
  reg  [5:0]  flush_pc_REG;
  reg         flush_pc_REG_1;
  wire [39:0] _flush_pc_T_6 = {io_ifu_get_pc_0_pc[39:6], 6'h0} + {34'h0, flush_pc_REG} - {38'h0, flush_pc_REG_1, 1'h0};
  reg         flush_pc_next_REG;
  reg  [5:0]  io_ifu_redirect_ftq_idx_REG;
  reg         REG_1;
  wire        _GEN_5_0 = b2_mispredict & ~REG_1;
  wire [39:0] _GEN_7 = {io_ifu_get_pc_1_pc[39:6], b2_uop_pc_lob};
  wire [39:0] _npc_T_2 = _GEN_7 + {37'h0, b2_uop_is_rvc | b2_uop_edge_inst ? 3'h2 : 3'h4};
  wire        _next_ghist_T = b2_cfi_type == 3'h1;
  wire        use_same_ghist = _next_ghist_T & ~b2_taken & {io_ifu_get_pc_1_pc[39:6], 6'h0} == {_npc_T_2[39:3], 3'h0};
  wire [2:0]  cfi_idx = b2_uop_pc_lob[3:1] ^ {io_ifu_get_pc_1_entry_start_bank, 2'h0};
  wire        _next_ghist_T_3 = io_ifu_get_pc_1_entry_cfi_idx_bits == cfi_idx;
  wire [7:0]  next_ghist_cfi_idx_oh = 8'h1 << cfi_idx;
  wire [6:0]  _GEN_8 = next_ghist_cfi_idx_oh[6:0] | next_ghist_cfi_idx_oh[7:1];
  wire [5:0]  _GEN_9 = _GEN_8[5:0] | next_ghist_cfi_idx_oh[7:2];
  wire [4:0]  _GEN_10 = _GEN_9[4:0] | next_ghist_cfi_idx_oh[7:3];
  wire [3:0]  _GEN_11 = _GEN_10[3:0] | next_ghist_cfi_idx_oh[7:4];
  wire [2:0]  _GEN_12 = _GEN_11[2:0] | next_ghist_cfi_idx_oh[7:5];
  wire [1:0]  _GEN_13 = _GEN_12[1:0] | next_ghist_cfi_idx_oh[7:6];
  wire [7:0]  _next_ghist_not_taken_branches_T_17 = ~(_next_ghist_T & b2_taken ? next_ghist_cfi_idx_oh : 8'h0);
  wire        next_ghist_cfi_in_bank_0 = b2_taken & ~(cfi_idx[2]);
  wire        next_ghist_ignore_second_bank = next_ghist_cfi_in_bank_0 | (&(io_ifu_get_pc_1_pc[5:3]));
  wire        next_ghist_first_bank_saw_not_taken = (|(io_ifu_get_pc_1_entry_br_mask[3:0] & {_GEN_11[3], _GEN_12[2], _GEN_13[1], _GEN_13[0] | (&cfi_idx)} & _next_ghist_not_taken_branches_T_17[3:0])) | io_ifu_get_pc_1_ghist_current_saw_branch_not_taken;
  wire [63:0] _GEN_14 = {io_ifu_get_pc_1_ghist_old_history[62:0], 1'h0};
  wire [63:0] _GEN_15 = {io_ifu_get_pc_1_ghist_old_history[62:0], 1'h1};
  wire        _next_ghist_new_history_old_history_T_5 = _next_ghist_T & next_ghist_cfi_in_bank_0;
  wire [62:0] _GEN_16 = {io_ifu_get_pc_1_ghist_old_history[61:0], 1'h0};
  wire [62:0] _GEN_17 = {io_ifu_get_pc_1_ghist_old_history[61:0], 1'h1};
  wire        _io_ifu_redirect_flush_output = REG | _GEN_5_0 | _rob_io_flush_frontend | (|_b1_mispredict_mask_T_10);
  wire        _io_ifu_commit_valid_T = _rob_io_commit_valids_0 | _rob_io_commit_valids_1;
  always @(*) begin
    casez (2'h3 - (_rob_io_commit_valids_3 ? 2'h0 : _rob_io_commit_valids_2 ? 2'h1 : {1'h1, ~_rob_io_commit_valids_1}))
      2'b00:
        casez_tmp = _rob_io_commit_uops_0_ftq_idx;
      2'b01:
        casez_tmp = _rob_io_commit_uops_1_ftq_idx;
      2'b10:
        casez_tmp = _rob_io_commit_uops_2_ftq_idx;
      default:
        casez_tmp = _rob_io_commit_uops_3_ftq_idx;
    endcase
  end // always @(*)
  reg         io_ifu_sfence_REG_valid;
  reg         io_ifu_sfence_REG_bits_rs1;
  reg         io_ifu_sfence_REG_bits_rs2;
  reg  [38:0] io_ifu_sfence_REG_bits_addr;
  reg         REG_3;
  reg         io_ifu_sfence_REG_1_valid;
  reg         io_ifu_sfence_REG_1_bits_rs1;
  reg         io_ifu_sfence_REG_1_bits_rs2;
  reg  [38:0] io_ifu_sfence_REG_1_bits_addr;
  wire        _io_ifu_sfence_valid_output = REG_3 ? io_ifu_sfence_REG_1_valid : io_ifu_sfence_REG_valid;
  wire        _io_ifu_sfence_bits_rs1_output = REG_3 ? io_ifu_sfence_REG_1_bits_rs1 : io_ifu_sfence_REG_bits_rs1;
  wire        _io_ifu_sfence_bits_rs2_output = REG_3 ? io_ifu_sfence_REG_1_bits_rs2 : io_ifu_sfence_REG_bits_rs2;
  wire [38:0] _io_ifu_sfence_bits_addr_output = REG_3 ? io_ifu_sfence_REG_1_bits_addr : io_ifu_sfence_REG_bits_addr;
  reg         jmp_pc_req_valid;
  reg  [5:0]  jmp_pc_req_bits;
  wire        dec_xcpts_2 = _decode_units_2_io_deq_uop_exception & dec_valids_2;
  wire        dec_xcpts_1 = _decode_units_1_io_deq_uop_exception & dec_valids_1;
  wire        dec_xcpts_0 = _decode_units_0_io_deq_uop_exception & dec_valids_0;
  always @(*) begin
    casez (dec_xcpts_0 ? 2'h0 : dec_xcpts_1 ? 2'h1 : {1'h1, ~dec_xcpts_2})
      2'b00:
        casez_tmp_0 = _decode_units_0_io_deq_uop_ftq_idx;
      2'b01:
        casez_tmp_0 = _decode_units_1_io_deq_uop_ftq_idx;
      2'b10:
        casez_tmp_0 = _decode_units_2_io_deq_uop_ftq_idx;
      default:
        casez_tmp_0 = _decode_units_3_io_deq_uop_ftq_idx;
    endcase
  end // always @(*)
  wire        dec_xcpt_stall = (dec_xcpts_0 | dec_xcpts_1 | dec_xcpts_2 | _decode_units_3_io_deq_uop_exception & dec_valids_3) & ~_ftq_arb_io_in_2_ready;
  wire        wait_for_empty_pipeline_0 = (_rename_stage_io_ren2_uops_0_is_unique | _csr_io_customCSRs_0_value[3]) & (~_rob_io_empty | ~io_lsu_fencei_rdy);
  wire        dis_stalls_0 = _rename_stage_io_ren2_mask_0 & (~_rob_io_ready | _rename_stage_io_ren_stalls_0 | _fp_rename_stage_io_ren_stalls_0 | io_lsu_ldq_full_0 & _rename_stage_io_ren2_uops_0_uses_ldq | io_lsu_stq_full_0 & _rename_stage_io_ren2_uops_0_uses_stq | ~_dispatcher_io_ren_uops_0_ready | wait_for_empty_pipeline_0 | (|_b1_mispredict_mask_T_10) | b2_mispredict | _io_ifu_redirect_flush_output);
  wire        wait_for_empty_pipeline_1 = (_rename_stage_io_ren2_uops_1_is_unique | _csr_io_customCSRs_0_value[3]) & (~_rob_io_empty | ~io_lsu_fencei_rdy | _rename_stage_io_ren2_mask_0);
  wire        dis_prior_slot_unique_1 = _rename_stage_io_ren2_mask_0 & _rename_stage_io_ren2_uops_0_is_unique;
  wire        dis_stalls_1 = dis_stalls_0 | _rename_stage_io_ren2_mask_1 & (~_rob_io_ready | _rename_stage_io_ren_stalls_1 | _fp_rename_stage_io_ren_stalls_1 | io_lsu_ldq_full_1 & _rename_stage_io_ren2_uops_1_uses_ldq | io_lsu_stq_full_1 & _rename_stage_io_ren2_uops_1_uses_stq | ~_dispatcher_io_ren_uops_1_ready | wait_for_empty_pipeline_1 | dis_prior_slot_unique_1 | (|_b1_mispredict_mask_T_10) | b2_mispredict | _io_ifu_redirect_flush_output);
  wire        dis_prior_slot_valid_2 = _rename_stage_io_ren2_mask_0 | _rename_stage_io_ren2_mask_1;
  wire        wait_for_empty_pipeline_2 = (_rename_stage_io_ren2_uops_2_is_unique | _csr_io_customCSRs_0_value[3]) & (~_rob_io_empty | ~io_lsu_fencei_rdy | dis_prior_slot_valid_2);
  wire        dis_prior_slot_unique_2 = dis_prior_slot_unique_1 | _rename_stage_io_ren2_mask_1 & _rename_stage_io_ren2_uops_1_is_unique;
  wire        dis_stalls_2 = dis_stalls_1 | _rename_stage_io_ren2_mask_2 & (~_rob_io_ready | _rename_stage_io_ren_stalls_2 | _fp_rename_stage_io_ren_stalls_2 | io_lsu_ldq_full_2 & _rename_stage_io_ren2_uops_2_uses_ldq | io_lsu_stq_full_2 & _rename_stage_io_ren2_uops_2_uses_stq | ~_dispatcher_io_ren_uops_2_ready | wait_for_empty_pipeline_2 | dis_prior_slot_unique_2 | (|_b1_mispredict_mask_T_10) | b2_mispredict | _io_ifu_redirect_flush_output);
  wire        wait_for_empty_pipeline_3 = (_rename_stage_io_ren2_uops_3_is_unique | _csr_io_customCSRs_0_value[3]) & (~_rob_io_empty | ~io_lsu_fencei_rdy | dis_prior_slot_valid_2 | _rename_stage_io_ren2_mask_2);
  assign dis_stalls_3 = dis_stalls_2 | _rename_stage_io_ren2_mask_3 & (~_rob_io_ready | _rename_stage_io_ren_stalls_3 | _fp_rename_stage_io_ren_stalls_3 | io_lsu_ldq_full_3 & _rename_stage_io_ren2_uops_3_uses_ldq | io_lsu_stq_full_3 & _rename_stage_io_ren2_uops_3_uses_stq | ~_dispatcher_io_ren_uops_3_ready | wait_for_empty_pipeline_3 | dis_prior_slot_unique_2 | _rename_stage_io_ren2_mask_2 & _rename_stage_io_ren2_uops_2_is_unique | (|_b1_mispredict_mask_T_10) | b2_mispredict | _io_ifu_redirect_flush_output);
  wire        dec_stalls_0 = dec_valids_0 & (dis_stalls_3 | _rob_io_commit_rollback | dec_xcpt_stall | _dec_brmask_logic_io_is_full_0 | (|_b1_mispredict_mask_T_10) | b2_mispredict | _io_ifu_redirect_flush_output);
  wire        dec_stalls_1 = dec_stalls_0 | dec_valids_1 & (dis_stalls_3 | _rob_io_commit_rollback | dec_xcpt_stall | _dec_brmask_logic_io_is_full_1 | (|_b1_mispredict_mask_T_10) | b2_mispredict | _io_ifu_redirect_flush_output);
  wire        dec_stalls_2 = dec_stalls_1 | dec_valids_2 & (dis_stalls_3 | _rob_io_commit_rollback | dec_xcpt_stall | _dec_brmask_logic_io_is_full_2 | (|_b1_mispredict_mask_T_10) | b2_mispredict | _io_ifu_redirect_flush_output);
  wire        dec_fire_0 = dec_valids_0 & ~dec_stalls_0;
  wire        dec_fire_1 = dec_valids_1 & ~dec_stalls_1;
  wire        dec_fire_2 = dec_valids_2 & ~dec_stalls_2;
  wire        dec_ready = dec_valids_3 & ~(dec_stalls_2 | dec_valids_3 & (dis_stalls_3 | _rob_io_commit_rollback | dec_xcpt_stall | _dec_brmask_logic_io_is_full_3 | (|_b1_mispredict_mask_T_10) | b2_mispredict | _io_ifu_redirect_flush_output));
  reg         dec_brmask_logic_io_flush_pipeline_REG;
  wire        _dis_uops_0_prs1_busy_T_2 = _rename_stage_io_ren2_uops_0_lrs1_rtype == 2'h1;
  wire        _dis_uops_0_prs1_busy_T = _rename_stage_io_ren2_uops_0_lrs1_rtype == 2'h0;
  wire        _dis_uops_0_prs2_busy_T_2 = _rename_stage_io_ren2_uops_0_lrs2_rtype == 2'h1;
  wire        _dis_uops_0_stale_pdst_T = _rename_stage_io_ren2_uops_0_dst_rtype == 2'h1;
  wire [6:0]  dis_uops_0_pdst = _dis_uops_0_stale_pdst_T ? _fp_rename_stage_io_ren2_uops_0_pdst : _rename_stage_io_ren2_uops_0_dst_rtype == 2'h0 ? _rename_stage_io_ren2_uops_0_pdst : 7'h0;
  wire        _dis_uops_1_prs1_busy_T_2 = _rename_stage_io_ren2_uops_1_lrs1_rtype == 2'h1;
  wire        _dis_uops_1_prs1_busy_T = _rename_stage_io_ren2_uops_1_lrs1_rtype == 2'h0;
  wire        _dis_uops_1_prs2_busy_T_2 = _rename_stage_io_ren2_uops_1_lrs2_rtype == 2'h1;
  wire        _dis_uops_1_stale_pdst_T = _rename_stage_io_ren2_uops_1_dst_rtype == 2'h1;
  wire [6:0]  dis_uops_1_pdst = _dis_uops_1_stale_pdst_T ? _fp_rename_stage_io_ren2_uops_1_pdst : _rename_stage_io_ren2_uops_1_dst_rtype == 2'h0 ? _rename_stage_io_ren2_uops_1_pdst : 7'h0;
  wire        _dis_uops_2_prs1_busy_T_2 = _rename_stage_io_ren2_uops_2_lrs1_rtype == 2'h1;
  wire        _dis_uops_2_prs1_busy_T = _rename_stage_io_ren2_uops_2_lrs1_rtype == 2'h0;
  wire        _dis_uops_2_prs2_busy_T_2 = _rename_stage_io_ren2_uops_2_lrs2_rtype == 2'h1;
  wire        _dis_uops_2_stale_pdst_T = _rename_stage_io_ren2_uops_2_dst_rtype == 2'h1;
  wire [6:0]  dis_uops_2_pdst = _dis_uops_2_stale_pdst_T ? _fp_rename_stage_io_ren2_uops_2_pdst : _rename_stage_io_ren2_uops_2_dst_rtype == 2'h0 ? _rename_stage_io_ren2_uops_2_pdst : 7'h0;
  wire        _dis_uops_3_prs1_busy_T_2 = _rename_stage_io_ren2_uops_3_lrs1_rtype == 2'h1;
  wire        _dis_uops_3_prs1_busy_T = _rename_stage_io_ren2_uops_3_lrs1_rtype == 2'h0;
  wire        _dis_uops_3_prs2_busy_T_2 = _rename_stage_io_ren2_uops_3_lrs2_rtype == 2'h1;
  wire        _dis_uops_3_stale_pdst_T = _rename_stage_io_ren2_uops_3_dst_rtype == 2'h1;
  wire [6:0]  dis_uops_3_pdst = _dis_uops_3_stale_pdst_T ? _fp_rename_stage_io_ren2_uops_3_pdst : _rename_stage_io_ren2_uops_3_dst_rtype == 2'h0 ? _rename_stage_io_ren2_uops_3_pdst : 7'h0;
  wire        dis_fire_0 = _rename_stage_io_ren2_mask_0 & ~dis_stalls_0;
  wire        dis_fire_1 = _rename_stage_io_ren2_mask_1 & ~dis_stalls_1;
  wire        dis_fire_2 = _rename_stage_io_ren2_mask_2 & ~dis_stalls_2;
  wire        dis_fire_3 = _rename_stage_io_ren2_mask_3 & ~dis_stalls_3;
  always @(*) begin
    casez (dis_fire_0 ? 2'h0 : dis_fire_1 ? 2'h1 : {1'h1, ~dis_fire_2})
      2'b00:
        casez_tmp_1 = _rename_stage_io_ren2_uops_0_is_sys_pc2epc;
      2'b01:
        casez_tmp_1 = _rename_stage_io_ren2_uops_1_is_sys_pc2epc;
      2'b10:
        casez_tmp_1 = _rename_stage_io_ren2_uops_2_is_sys_pc2epc;
      default:
        casez_tmp_1 = _rename_stage_io_ren2_uops_3_is_sys_pc2epc;
    endcase
  end // always @(*)
  reg         REG_4;
  reg  [5:0]  io_ifu_commit_bits_REG;
  always @(*) begin
    casez (_rename_stage_io_ren2_mask_0 ? 2'h0 : _rename_stage_io_ren2_mask_1 ? 2'h1 : {1'h1, ~_rename_stage_io_ren2_mask_2})
      2'b00:
        casez_tmp_2 = _rename_stage_io_ren2_uops_0_ftq_idx;
      2'b01:
        casez_tmp_2 = _rename_stage_io_ren2_uops_1_ftq_idx;
      2'b10:
        casez_tmp_2 = _rename_stage_io_ren2_uops_2_ftq_idx;
      default:
        casez_tmp_2 = _rename_stage_io_ren2_uops_3_ftq_idx;
    endcase
  end // always @(*)
  wire        _iregfile_io_write_ports_0_wport_valid_T = _ll_wbarb_io_out_bits_uop_dst_rtype == 2'h0;
  wire        int_iss_wakeups_0_valid = _ll_wbarb_io_out_valid & _iregfile_io_write_ports_0_wport_valid_T;
  wire        _iregfile_io_write_ports_1_wport_valid_T = _memExeUnit_1_io_ll_iresp_bits_uop_dst_rtype == 2'h0;
  wire        int_iss_wakeups_1_valid = _memExeUnit_1_io_ll_iresp_valid & _iregfile_io_write_ports_1_wport_valid_T;
  wire        _rob_io_debug_wb_valids_2_T = _alu_exe_unit_io_iresp_bits_uop_dst_rtype != 2'h2;
  wire        _iregister_read_io_iss_valids_2_T = _int_issue_unit_io_iss_uops_0_iw_p1_poisoned | _int_issue_unit_io_iss_uops_0_iw_p2_poisoned;
  wire        fast_wakeup_valid = _int_issue_unit_io_iss_valids_0 & _int_issue_unit_io_iss_uops_0_bypassable & _int_issue_unit_io_iss_uops_0_dst_rtype == 2'h0 & _int_issue_unit_io_iss_uops_0_ldst_val & ~(io_lsu_ld_miss & _iregister_read_io_iss_valids_2_T);
  wire        slow_wakeup_valid = _alu_exe_unit_io_iresp_valid & _rob_io_debug_wb_valids_2_T & ~_alu_exe_unit_io_iresp_bits_uop_bypassable & ~(|_alu_exe_unit_io_iresp_bits_uop_dst_rtype);
  wire        _rob_io_debug_wb_valids_3_T = _alu_exe_unit_1_io_iresp_bits_uop_dst_rtype != 2'h2;
  wire        _iregister_read_io_iss_valids_3_T = _int_issue_unit_io_iss_uops_1_iw_p1_poisoned | _int_issue_unit_io_iss_uops_1_iw_p2_poisoned;
  wire        fast_wakeup_1_valid = _int_issue_unit_io_iss_valids_1 & _int_issue_unit_io_iss_uops_1_bypassable & _int_issue_unit_io_iss_uops_1_dst_rtype == 2'h0 & _int_issue_unit_io_iss_uops_1_ldst_val & ~(io_lsu_ld_miss & _iregister_read_io_iss_valids_3_T);
  wire        slow_wakeup_1_valid = _alu_exe_unit_1_io_iresp_valid & _rob_io_debug_wb_valids_3_T & ~_alu_exe_unit_1_io_iresp_bits_uop_bypassable & ~(|_alu_exe_unit_1_io_iresp_bits_uop_dst_rtype);
  wire        _rob_io_debug_wb_valids_4_T = _alu_exe_unit_2_io_iresp_bits_uop_dst_rtype != 2'h2;
  wire        _iregister_read_io_iss_valids_4_T = _int_issue_unit_io_iss_uops_2_iw_p1_poisoned | _int_issue_unit_io_iss_uops_2_iw_p2_poisoned;
  wire        fast_wakeup_2_valid = _int_issue_unit_io_iss_valids_2 & _int_issue_unit_io_iss_uops_2_bypassable & _int_issue_unit_io_iss_uops_2_dst_rtype == 2'h0 & _int_issue_unit_io_iss_uops_2_ldst_val & ~(io_lsu_ld_miss & _iregister_read_io_iss_valids_4_T);
  wire        slow_wakeup_2_valid = _alu_exe_unit_2_io_iresp_valid & _rob_io_debug_wb_valids_4_T & ~_alu_exe_unit_2_io_iresp_bits_uop_bypassable & ~(|_alu_exe_unit_2_io_iresp_bits_uop_dst_rtype);
  wire        _rob_io_debug_wb_valids_5_T = _alu_exe_unit_3_io_iresp_bits_uop_dst_rtype != 2'h2;
  wire        _iregister_read_io_iss_valids_5_T = _int_issue_unit_io_iss_uops_3_iw_p1_poisoned | _int_issue_unit_io_iss_uops_3_iw_p2_poisoned;
  wire        fast_wakeup_3_valid = _int_issue_unit_io_iss_valids_3 & _int_issue_unit_io_iss_uops_3_bypassable & _int_issue_unit_io_iss_uops_3_dst_rtype == 2'h0 & _int_issue_unit_io_iss_uops_3_ldst_val & ~(io_lsu_ld_miss & _iregister_read_io_iss_valids_5_T);
  wire        slow_wakeup_3_valid = _alu_exe_unit_3_io_iresp_valid & _rob_io_debug_wb_valids_5_T & ~_alu_exe_unit_3_io_iresp_bits_uop_bypassable & ~(|_alu_exe_unit_3_io_iresp_bits_uop_dst_rtype);
  reg  [4:0]  saturating_loads_counter;
  reg         pause_mem_REG;
  wire        pause_mem = pause_mem_REG & (&saturating_loads_counter);
  reg  [9:0]  REG_5;
  reg  [9:0]  REG_6;
  reg         mem_issue_unit_io_flush_pipeline_REG;
  reg         int_issue_unit_io_flush_pipeline_REG;
  reg         iregister_read_io_kill_REG;
  reg  [2:0]  csr_io_retire_REG;
  reg         csr_io_exception_REG;
  reg  [5:0]  csr_io_pc_REG;
  reg         csr_io_pc_REG_1;
  reg  [63:0] csr_io_cause_REG;
  reg  [39:0] csr_io_tval_REG;
  reg         io_lsu_exception_REG;
  reg         REG_7;
  reg         alu_exe_unit_io_req_bits_kill_REG;
  reg         alu_exe_unit_io_req_bits_kill_REG_1;
  reg         alu_exe_unit_io_req_bits_kill_REG_2;
  reg         alu_exe_unit_io_req_bits_kill_REG_3;
  wire [6:0]  dis_uops_0_rob_idx = {_rob_io_rob_tail_idx[6:2], 2'h0};
  wire [6:0]  dis_uops_1_rob_idx = {_rob_io_rob_tail_idx[6:2], 2'h1};
  wire [6:0]  dis_uops_2_rob_idx = {_rob_io_rob_tail_idx[6:2], 2'h2};
  wire [6:0]  dis_uops_3_rob_idx = {_rob_io_rob_tail_idx[6:2], 2'h3};
  wire        loads_saturating = _mem_issue_unit_io_iss_valids_0 & _mem_issue_unit_io_iss_uops_0_uses_ldq;
  always @(posedge clock) begin
    brinfos_0_uop_is_rvc <= _alu_exe_unit_io_brinfo_uop_is_rvc;
    brinfos_0_uop_br_mask <= _alu_exe_unit_io_brinfo_uop_br_mask;
    brinfos_0_uop_br_tag <= _alu_exe_unit_io_brinfo_uop_br_tag;
    brinfos_0_uop_ftq_idx <= _alu_exe_unit_io_brinfo_uop_ftq_idx;
    brinfos_0_uop_edge_inst <= _alu_exe_unit_io_brinfo_uop_edge_inst;
    brinfos_0_uop_pc_lob <= _alu_exe_unit_io_brinfo_uop_pc_lob;
    brinfos_0_uop_rob_idx <= _alu_exe_unit_io_brinfo_uop_rob_idx;
    brinfos_0_uop_ldq_idx <= _alu_exe_unit_io_brinfo_uop_ldq_idx;
    brinfos_0_uop_stq_idx <= _alu_exe_unit_io_brinfo_uop_stq_idx;
    brinfos_0_valid <= _alu_exe_unit_io_brinfo_valid & ~_rob_io_flush_valid;
    brinfos_0_mispredict <= _alu_exe_unit_io_brinfo_mispredict;
    brinfos_0_taken <= _alu_exe_unit_io_brinfo_taken;
    brinfos_0_cfi_type <= _alu_exe_unit_io_brinfo_cfi_type;
    brinfos_0_pc_sel <= _alu_exe_unit_io_brinfo_pc_sel;
    brinfos_0_target_offset <= _alu_exe_unit_io_brinfo_target_offset;
    brinfos_1_uop_is_rvc <= _alu_exe_unit_1_io_brinfo_uop_is_rvc;
    brinfos_1_uop_br_mask <= _alu_exe_unit_1_io_brinfo_uop_br_mask;
    brinfos_1_uop_br_tag <= _alu_exe_unit_1_io_brinfo_uop_br_tag;
    brinfos_1_uop_ftq_idx <= _alu_exe_unit_1_io_brinfo_uop_ftq_idx;
    brinfos_1_uop_edge_inst <= _alu_exe_unit_1_io_brinfo_uop_edge_inst;
    brinfos_1_uop_pc_lob <= _alu_exe_unit_1_io_brinfo_uop_pc_lob;
    brinfos_1_uop_rob_idx <= _alu_exe_unit_1_io_brinfo_uop_rob_idx;
    brinfos_1_uop_ldq_idx <= _alu_exe_unit_1_io_brinfo_uop_ldq_idx;
    brinfos_1_uop_stq_idx <= _alu_exe_unit_1_io_brinfo_uop_stq_idx;
    brinfos_1_valid <= _alu_exe_unit_1_io_brinfo_valid & ~_rob_io_flush_valid;
    brinfos_1_mispredict <= _alu_exe_unit_1_io_brinfo_mispredict;
    brinfos_1_taken <= _alu_exe_unit_1_io_brinfo_taken;
    brinfos_1_cfi_type <= _alu_exe_unit_1_io_brinfo_cfi_type;
    brinfos_1_pc_sel <= _alu_exe_unit_1_io_brinfo_pc_sel;
    brinfos_1_target_offset <= _alu_exe_unit_1_io_brinfo_target_offset;
    brinfos_2_uop_is_rvc <= _alu_exe_unit_2_io_brinfo_uop_is_rvc;
    brinfos_2_uop_br_mask <= _alu_exe_unit_2_io_brinfo_uop_br_mask;
    brinfos_2_uop_br_tag <= _alu_exe_unit_2_io_brinfo_uop_br_tag;
    brinfos_2_uop_ftq_idx <= _alu_exe_unit_2_io_brinfo_uop_ftq_idx;
    brinfos_2_uop_edge_inst <= _alu_exe_unit_2_io_brinfo_uop_edge_inst;
    brinfos_2_uop_pc_lob <= _alu_exe_unit_2_io_brinfo_uop_pc_lob;
    brinfos_2_uop_rob_idx <= _alu_exe_unit_2_io_brinfo_uop_rob_idx;
    brinfos_2_uop_ldq_idx <= _alu_exe_unit_2_io_brinfo_uop_ldq_idx;
    brinfos_2_uop_stq_idx <= _alu_exe_unit_2_io_brinfo_uop_stq_idx;
    brinfos_2_valid <= _alu_exe_unit_2_io_brinfo_valid & ~_rob_io_flush_valid;
    brinfos_2_mispredict <= _alu_exe_unit_2_io_brinfo_mispredict;
    brinfos_2_taken <= _alu_exe_unit_2_io_brinfo_taken;
    brinfos_2_cfi_type <= _alu_exe_unit_2_io_brinfo_cfi_type;
    brinfos_2_pc_sel <= _alu_exe_unit_2_io_brinfo_pc_sel;
    brinfos_2_target_offset <= _alu_exe_unit_2_io_brinfo_target_offset;
    brinfos_3_uop_is_rvc <= _alu_exe_unit_3_io_brinfo_uop_is_rvc;
    brinfos_3_uop_br_mask <= _alu_exe_unit_3_io_brinfo_uop_br_mask;
    brinfos_3_uop_br_tag <= _alu_exe_unit_3_io_brinfo_uop_br_tag;
    brinfos_3_uop_ftq_idx <= _alu_exe_unit_3_io_brinfo_uop_ftq_idx;
    brinfos_3_uop_edge_inst <= _alu_exe_unit_3_io_brinfo_uop_edge_inst;
    brinfos_3_uop_pc_lob <= _alu_exe_unit_3_io_brinfo_uop_pc_lob;
    brinfos_3_uop_rob_idx <= _alu_exe_unit_3_io_brinfo_uop_rob_idx;
    brinfos_3_uop_ldq_idx <= _alu_exe_unit_3_io_brinfo_uop_ldq_idx;
    brinfos_3_uop_stq_idx <= _alu_exe_unit_3_io_brinfo_uop_stq_idx;
    brinfos_3_valid <= _alu_exe_unit_3_io_brinfo_valid & ~_rob_io_flush_valid;
    brinfos_3_mispredict <= _alu_exe_unit_3_io_brinfo_mispredict;
    brinfos_3_taken <= _alu_exe_unit_3_io_brinfo_taken;
    brinfos_3_cfi_type <= _alu_exe_unit_3_io_brinfo_cfi_type;
    brinfos_3_pc_sel <= _alu_exe_unit_3_io_brinfo_pc_sel;
    brinfos_3_target_offset <= _alu_exe_unit_3_io_brinfo_target_offset;
    if (use_this_mispredict_3) begin
      b2_uop_is_rvc <= brinfos_3_uop_is_rvc;
      b2_uop_br_tag <= brinfos_3_uop_br_tag;
      b2_uop_ftq_idx <= brinfos_3_uop_ftq_idx;
      b2_uop_edge_inst <= brinfos_3_uop_edge_inst;
      b2_uop_pc_lob <= brinfos_3_uop_pc_lob;
      b2_uop_rob_idx <= brinfos_3_uop_rob_idx;
      b2_uop_ldq_idx <= brinfos_3_uop_ldq_idx;
      b2_uop_stq_idx <= brinfos_3_uop_stq_idx;
      b2_taken <= brinfos_3_taken;
      b2_cfi_type <= brinfos_3_cfi_type;
      b2_pc_sel <= brinfos_3_pc_sel;
      b2_target_offset <= brinfos_3_target_offset;
    end
    else if (use_this_mispredict_2) begin
      b2_uop_is_rvc <= brinfos_2_uop_is_rvc;
      b2_uop_br_tag <= brinfos_2_uop_br_tag;
      b2_uop_ftq_idx <= brinfos_2_uop_ftq_idx;
      b2_uop_edge_inst <= brinfos_2_uop_edge_inst;
      b2_uop_pc_lob <= brinfos_2_uop_pc_lob;
      b2_uop_rob_idx <= brinfos_2_uop_rob_idx;
      b2_uop_ldq_idx <= brinfos_2_uop_ldq_idx;
      b2_uop_stq_idx <= brinfos_2_uop_stq_idx;
      b2_taken <= brinfos_2_taken;
      b2_cfi_type <= brinfos_2_cfi_type;
      b2_pc_sel <= brinfos_2_pc_sel;
      b2_target_offset <= brinfos_2_target_offset;
    end
    else if (use_this_mispredict_1) begin
      b2_uop_is_rvc <= brinfos_1_uop_is_rvc;
      b2_uop_br_tag <= brinfos_1_uop_br_tag;
      b2_uop_ftq_idx <= brinfos_1_uop_ftq_idx;
      b2_uop_edge_inst <= brinfos_1_uop_edge_inst;
      b2_uop_pc_lob <= brinfos_1_uop_pc_lob;
      b2_uop_rob_idx <= brinfos_1_uop_rob_idx;
      b2_uop_ldq_idx <= brinfos_1_uop_ldq_idx;
      b2_uop_stq_idx <= brinfos_1_uop_stq_idx;
      b2_taken <= brinfos_1_taken;
      b2_cfi_type <= brinfos_1_cfi_type;
      b2_pc_sel <= brinfos_1_pc_sel;
      b2_target_offset <= brinfos_1_target_offset;
    end
    else begin
      b2_uop_is_rvc <= brinfos_0_uop_is_rvc;
      b2_uop_br_tag <= brinfos_0_uop_br_tag;
      b2_uop_ftq_idx <= brinfos_0_uop_ftq_idx;
      b2_uop_edge_inst <= brinfos_0_uop_edge_inst;
      b2_uop_pc_lob <= brinfos_0_uop_pc_lob;
      b2_uop_rob_idx <= brinfos_0_uop_rob_idx;
      b2_uop_ldq_idx <= brinfos_0_uop_ldq_idx;
      b2_uop_stq_idx <= brinfos_0_uop_stq_idx;
      b2_taken <= brinfos_0_taken;
      b2_cfi_type <= brinfos_0_cfi_type;
      b2_pc_sel <= brinfos_0_pc_sel;
      b2_target_offset <= brinfos_0_target_offset;
    end
    b2_uop_br_mask <= (use_this_mispredict_3 ? brinfos_3_uop_br_mask : use_this_mispredict_2 ? brinfos_2_uop_br_mask : use_this_mispredict_1 ? brinfos_1_uop_br_mask : brinfos_0_uop_br_mask) & ~_b1_resolve_mask_T_6;
    b2_mispredict <= _GEN_5 | _use_this_mispredict_T_25;
    b2_jalr_target <= b2_jalr_target_REG;
    b2_jalr_target_REG <= _alu_exe_unit_io_brinfo_jalr_target;
    io_ifu_flush_icache_REG <= dec_valids_0 & _decode_units_0_io_deq_uop_is_jalr & _csr_io_status_debug;
    io_ifu_flush_icache_REG_1 <= dec_valids_1 & _decode_units_1_io_deq_uop_is_jalr & _csr_io_status_debug;
    io_ifu_flush_icache_REG_2 <= dec_valids_2 & _decode_units_2_io_deq_uop_is_jalr & _csr_io_status_debug;
    io_ifu_flush_icache_REG_3 <= dec_valids_3 & _decode_units_3_io_deq_uop_is_jalr & _csr_io_status_debug;
    REG <= _rob_io_flush_valid;
    flush_typ <= _rob_io_flush_bits_flush_typ;
    io_ifu_redirect_pc_REG <= _csr_io_evec;
    io_ifu_redirect_pc_REG_1 <= io_ifu_redirect_pc_REG;
    flush_pc_REG <= _rob_io_flush_bits_pc_lob;
    flush_pc_REG_1 <= _rob_io_flush_bits_edge_inst;
    flush_pc_next_REG <= _rob_io_flush_bits_is_rvc;
    io_ifu_redirect_ftq_idx_REG <= _rob_io_flush_bits_ftq_idx;
    REG_1 <= _rob_io_flush_valid;
    io_ifu_sfence_REG_valid <= _memExeUnit_io_lsu_io_req_bits_sfence_valid;
    io_ifu_sfence_REG_bits_rs1 <= _memExeUnit_io_lsu_io_req_bits_sfence_bits_rs1;
    io_ifu_sfence_REG_bits_rs2 <= _memExeUnit_io_lsu_io_req_bits_sfence_bits_rs2;
    io_ifu_sfence_REG_bits_addr <= _memExeUnit_io_lsu_io_req_bits_sfence_bits_addr;
    REG_3 <= _memExeUnit_1_io_lsu_io_req_bits_sfence_valid;
    io_ifu_sfence_REG_1_valid <= _memExeUnit_1_io_lsu_io_req_bits_sfence_valid;
    io_ifu_sfence_REG_1_bits_rs1 <= _memExeUnit_1_io_lsu_io_req_bits_sfence_bits_rs1;
    io_ifu_sfence_REG_1_bits_rs2 <= _memExeUnit_1_io_lsu_io_req_bits_sfence_bits_rs2;
    io_ifu_sfence_REG_1_bits_addr <= _memExeUnit_1_io_lsu_io_req_bits_sfence_bits_addr;
    jmp_pc_req_valid <= _int_issue_unit_io_iss_valids_0 & _int_issue_unit_io_iss_uops_0_fu_code == 10'h2;
    jmp_pc_req_bits <= _int_issue_unit_io_iss_uops_0_ftq_idx;
    dec_brmask_logic_io_flush_pipeline_REG <= _rob_io_flush_valid;
    REG_4 <= (dis_fire_0 | dis_fire_1 | dis_fire_2 | dis_fire_3) & casez_tmp_1;
    io_ifu_commit_bits_REG <= casez_tmp_2;
    pause_mem_REG <= loads_saturating;
    REG_5 <= {5'h1F, ~(_int_issue_unit_io_iss_valids_2 & _int_issue_unit_io_iss_uops_2_fu_code[4]), 4'hF};
    REG_6 <= {5'h1F, ~(_int_issue_unit_io_iss_valids_3 & _int_issue_unit_io_iss_uops_3_fu_code[4]), 4'hF};
    mem_issue_unit_io_flush_pipeline_REG <= _rob_io_flush_valid;
    int_issue_unit_io_flush_pipeline_REG <= _rob_io_flush_valid;
    iregister_read_io_kill_REG <= _rob_io_flush_valid;
    csr_io_retire_REG <= {1'h0, {1'h0, _rob_io_commit_arch_valids_0} + {1'h0, _rob_io_commit_arch_valids_1}} + {1'h0, {1'h0, _rob_io_commit_arch_valids_2} + {1'h0, _rob_io_commit_arch_valids_3}};
    csr_io_exception_REG <= _rob_io_com_xcpt_valid;
    csr_io_pc_REG <= _rob_io_com_xcpt_bits_pc_lob;
    csr_io_pc_REG_1 <= _rob_io_com_xcpt_bits_edge_inst;
    csr_io_cause_REG <= _rob_io_com_xcpt_bits_cause;
    csr_io_tval_REG <= {_rob_io_com_xcpt_bits_badvaddr[63:39] == 25'h0 | (&(_rob_io_com_xcpt_bits_badvaddr[63:39])) ? _rob_io_com_xcpt_bits_badvaddr[39] : ~(_rob_io_com_xcpt_bits_badvaddr[38]), _rob_io_com_xcpt_bits_badvaddr[38:0]};
    io_lsu_exception_REG <= _rob_io_flush_valid;
    REG_7 <= _rob_io_flush_valid;
    alu_exe_unit_io_req_bits_kill_REG <= _rob_io_flush_valid;
    alu_exe_unit_io_req_bits_kill_REG_1 <= _rob_io_flush_valid;
    alu_exe_unit_io_req_bits_kill_REG_2 <= _rob_io_flush_valid;
    alu_exe_unit_io_req_bits_kill_REG_3 <= _rob_io_flush_valid;
    if (reset) begin
      dec_finished_mask <= 4'h0;
      saturating_loads_counter <= 5'h0;
    end
    else begin
      if (dec_ready | _io_ifu_redirect_flush_output)
        dec_finished_mask <= 4'h0;
      else
        dec_finished_mask <= {dec_ready, dec_fire_2, dec_fire_1, dec_fire_0} | dec_finished_mask;
      if (loads_saturating)
        saturating_loads_counter <= saturating_loads_counter + 5'h1;
      else
        saturating_loads_counter <= 5'h0;
    end
  end // always @(posedge)
  ALUExeUnit memExeUnit (
    .clock                               (clock),
    .reset                               (reset),
    .io_req_valid                        (_iregister_read_io_exe_reqs_0_valid),
    .io_req_bits_uop_uopc                (_iregister_read_io_exe_reqs_0_bits_uop_uopc),
    .io_req_bits_uop_fu_code             (_iregister_read_io_exe_reqs_0_bits_uop_fu_code),
    .io_req_bits_uop_ctrl_is_load        (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_load),
    .io_req_bits_uop_ctrl_is_sta         (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_sta),
    .io_req_bits_uop_ctrl_is_std         (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_std),
    .io_req_bits_uop_br_mask             (_iregister_read_io_exe_reqs_0_bits_uop_br_mask),
    .io_req_bits_uop_imm_packed          (_iregister_read_io_exe_reqs_0_bits_uop_imm_packed),
    .io_req_bits_uop_rob_idx             (_iregister_read_io_exe_reqs_0_bits_uop_rob_idx),
    .io_req_bits_uop_ldq_idx             (_iregister_read_io_exe_reqs_0_bits_uop_ldq_idx),
    .io_req_bits_uop_stq_idx             (_iregister_read_io_exe_reqs_0_bits_uop_stq_idx),
    .io_req_bits_uop_pdst                (_iregister_read_io_exe_reqs_0_bits_uop_pdst),
    .io_req_bits_uop_mem_cmd             (_iregister_read_io_exe_reqs_0_bits_uop_mem_cmd),
    .io_req_bits_uop_mem_size            (_iregister_read_io_exe_reqs_0_bits_uop_mem_size),
    .io_req_bits_uop_mem_signed          (_iregister_read_io_exe_reqs_0_bits_uop_mem_signed),
    .io_req_bits_uop_is_fence            (_iregister_read_io_exe_reqs_0_bits_uop_is_fence),
    .io_req_bits_uop_is_amo              (_iregister_read_io_exe_reqs_0_bits_uop_is_amo),
    .io_req_bits_uop_uses_ldq            (_iregister_read_io_exe_reqs_0_bits_uop_uses_ldq),
    .io_req_bits_uop_uses_stq            (_iregister_read_io_exe_reqs_0_bits_uop_uses_stq),
    .io_req_bits_uop_fp_val              (_iregister_read_io_exe_reqs_0_bits_uop_fp_val),
    .io_req_bits_rs1_data                ({1'h0, _iregister_read_io_exe_reqs_0_bits_rs1_data}),
    .io_req_bits_rs2_data                ({1'h0, _iregister_read_io_exe_reqs_0_bits_rs2_data}),
    .io_brupdate_b1_resolve_mask         (_b1_resolve_mask_T_6),
    .io_brupdate_b1_mispredict_mask      (_b1_mispredict_mask_T_10),
    .io_lsu_io_iresp_valid               (io_lsu_exe_0_iresp_valid),
    .io_lsu_io_iresp_bits_uop_rob_idx    (io_lsu_exe_0_iresp_bits_uop_rob_idx),
    .io_lsu_io_iresp_bits_uop_pdst       (io_lsu_exe_0_iresp_bits_uop_pdst),
    .io_lsu_io_iresp_bits_uop_is_amo     (io_lsu_exe_0_iresp_bits_uop_is_amo),
    .io_lsu_io_iresp_bits_uop_uses_stq   (io_lsu_exe_0_iresp_bits_uop_uses_stq),
    .io_lsu_io_iresp_bits_uop_dst_rtype  (io_lsu_exe_0_iresp_bits_uop_dst_rtype),
    .io_lsu_io_iresp_bits_data           (io_lsu_exe_0_iresp_bits_data),
    .io_lsu_io_fresp_valid               (io_lsu_exe_0_fresp_valid),
    .io_lsu_io_fresp_bits_uop_uopc       (io_lsu_exe_0_fresp_bits_uop_uopc),
    .io_lsu_io_fresp_bits_uop_br_mask    (io_lsu_exe_0_fresp_bits_uop_br_mask),
    .io_lsu_io_fresp_bits_uop_rob_idx    (io_lsu_exe_0_fresp_bits_uop_rob_idx),
    .io_lsu_io_fresp_bits_uop_stq_idx    (io_lsu_exe_0_fresp_bits_uop_stq_idx),
    .io_lsu_io_fresp_bits_uop_pdst       (io_lsu_exe_0_fresp_bits_uop_pdst),
    .io_lsu_io_fresp_bits_uop_mem_size   (io_lsu_exe_0_fresp_bits_uop_mem_size),
    .io_lsu_io_fresp_bits_uop_is_amo     (io_lsu_exe_0_fresp_bits_uop_is_amo),
    .io_lsu_io_fresp_bits_uop_uses_stq   (io_lsu_exe_0_fresp_bits_uop_uses_stq),
    .io_lsu_io_fresp_bits_uop_dst_rtype  (io_lsu_exe_0_fresp_bits_uop_dst_rtype),
    .io_lsu_io_fresp_bits_uop_fp_val     (io_lsu_exe_0_fresp_bits_uop_fp_val),
    .io_lsu_io_fresp_bits_data           (io_lsu_exe_0_fresp_bits_data),
    .io_ll_iresp_valid                   (_memExeUnit_io_ll_iresp_valid),
    .io_ll_iresp_bits_uop_rob_idx        (_memExeUnit_io_ll_iresp_bits_uop_rob_idx),
    .io_ll_iresp_bits_uop_pdst           (_memExeUnit_io_ll_iresp_bits_uop_pdst),
    .io_ll_iresp_bits_uop_is_amo         (_memExeUnit_io_ll_iresp_bits_uop_is_amo),
    .io_ll_iresp_bits_uop_uses_stq       (_memExeUnit_io_ll_iresp_bits_uop_uses_stq),
    .io_ll_iresp_bits_uop_dst_rtype      (_memExeUnit_io_ll_iresp_bits_uop_dst_rtype),
    .io_ll_iresp_bits_data               (_memExeUnit_io_ll_iresp_bits_data),
    .io_ll_fresp_valid                   (_memExeUnit_io_ll_fresp_valid),
    .io_ll_fresp_bits_uop_uopc           (_memExeUnit_io_ll_fresp_bits_uop_uopc),
    .io_ll_fresp_bits_uop_br_mask        (_memExeUnit_io_ll_fresp_bits_uop_br_mask),
    .io_ll_fresp_bits_uop_rob_idx        (_memExeUnit_io_ll_fresp_bits_uop_rob_idx),
    .io_ll_fresp_bits_uop_stq_idx        (_memExeUnit_io_ll_fresp_bits_uop_stq_idx),
    .io_ll_fresp_bits_uop_pdst           (_memExeUnit_io_ll_fresp_bits_uop_pdst),
    .io_ll_fresp_bits_uop_mem_size       (_memExeUnit_io_ll_fresp_bits_uop_mem_size),
    .io_ll_fresp_bits_uop_is_amo         (_memExeUnit_io_ll_fresp_bits_uop_is_amo),
    .io_ll_fresp_bits_uop_uses_stq       (_memExeUnit_io_ll_fresp_bits_uop_uses_stq),
    .io_ll_fresp_bits_uop_dst_rtype      (_memExeUnit_io_ll_fresp_bits_uop_dst_rtype),
    .io_ll_fresp_bits_uop_fp_val         (_memExeUnit_io_ll_fresp_bits_uop_fp_val),
    .io_ll_fresp_bits_data               (_memExeUnit_io_ll_fresp_bits_data),
    .io_lsu_io_req_valid                 (io_lsu_exe_0_req_valid),
    .io_lsu_io_req_bits_uop_ctrl_is_load (io_lsu_exe_0_req_bits_uop_ctrl_is_load),
    .io_lsu_io_req_bits_uop_ctrl_is_sta  (io_lsu_exe_0_req_bits_uop_ctrl_is_sta),
    .io_lsu_io_req_bits_uop_ctrl_is_std  (io_lsu_exe_0_req_bits_uop_ctrl_is_std),
    .io_lsu_io_req_bits_uop_br_mask      (io_lsu_exe_0_req_bits_uop_br_mask),
    .io_lsu_io_req_bits_uop_rob_idx      (io_lsu_exe_0_req_bits_uop_rob_idx),
    .io_lsu_io_req_bits_uop_ldq_idx      (io_lsu_exe_0_req_bits_uop_ldq_idx),
    .io_lsu_io_req_bits_uop_stq_idx      (io_lsu_exe_0_req_bits_uop_stq_idx),
    .io_lsu_io_req_bits_uop_pdst         (io_lsu_exe_0_req_bits_uop_pdst),
    .io_lsu_io_req_bits_uop_mem_cmd      (io_lsu_exe_0_req_bits_uop_mem_cmd),
    .io_lsu_io_req_bits_uop_mem_size     (io_lsu_exe_0_req_bits_uop_mem_size),
    .io_lsu_io_req_bits_uop_mem_signed   (io_lsu_exe_0_req_bits_uop_mem_signed),
    .io_lsu_io_req_bits_uop_is_fence     (io_lsu_exe_0_req_bits_uop_is_fence),
    .io_lsu_io_req_bits_uop_is_amo       (io_lsu_exe_0_req_bits_uop_is_amo),
    .io_lsu_io_req_bits_uop_uses_ldq     (io_lsu_exe_0_req_bits_uop_uses_ldq),
    .io_lsu_io_req_bits_uop_uses_stq     (io_lsu_exe_0_req_bits_uop_uses_stq),
    .io_lsu_io_req_bits_uop_fp_val       (io_lsu_exe_0_req_bits_uop_fp_val),
    .io_lsu_io_req_bits_data             (io_lsu_exe_0_req_bits_data),
    .io_lsu_io_req_bits_addr             (io_lsu_exe_0_req_bits_addr),
    .io_lsu_io_req_bits_mxcpt_valid      (io_lsu_exe_0_req_bits_mxcpt_valid),
    .io_lsu_io_req_bits_sfence_valid     (_memExeUnit_io_lsu_io_req_bits_sfence_valid),
    .io_lsu_io_req_bits_sfence_bits_rs1  (_memExeUnit_io_lsu_io_req_bits_sfence_bits_rs1),
    .io_lsu_io_req_bits_sfence_bits_rs2  (_memExeUnit_io_lsu_io_req_bits_sfence_bits_rs2),
    .io_lsu_io_req_bits_sfence_bits_addr (_memExeUnit_io_lsu_io_req_bits_sfence_bits_addr)
  );
  ALUExeUnit memExeUnit_1 (
    .clock                               (clock),
    .reset                               (reset),
    .io_req_valid                        (_iregister_read_io_exe_reqs_1_valid),
    .io_req_bits_uop_uopc                (_iregister_read_io_exe_reqs_1_bits_uop_uopc),
    .io_req_bits_uop_fu_code             (_iregister_read_io_exe_reqs_1_bits_uop_fu_code),
    .io_req_bits_uop_ctrl_is_load        (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_is_load),
    .io_req_bits_uop_ctrl_is_sta         (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_is_sta),
    .io_req_bits_uop_ctrl_is_std         (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_is_std),
    .io_req_bits_uop_br_mask             (_iregister_read_io_exe_reqs_1_bits_uop_br_mask),
    .io_req_bits_uop_imm_packed          (_iregister_read_io_exe_reqs_1_bits_uop_imm_packed),
    .io_req_bits_uop_rob_idx             (_iregister_read_io_exe_reqs_1_bits_uop_rob_idx),
    .io_req_bits_uop_ldq_idx             (_iregister_read_io_exe_reqs_1_bits_uop_ldq_idx),
    .io_req_bits_uop_stq_idx             (_iregister_read_io_exe_reqs_1_bits_uop_stq_idx),
    .io_req_bits_uop_pdst                (_iregister_read_io_exe_reqs_1_bits_uop_pdst),
    .io_req_bits_uop_mem_cmd             (_iregister_read_io_exe_reqs_1_bits_uop_mem_cmd),
    .io_req_bits_uop_mem_size            (_iregister_read_io_exe_reqs_1_bits_uop_mem_size),
    .io_req_bits_uop_mem_signed          (_iregister_read_io_exe_reqs_1_bits_uop_mem_signed),
    .io_req_bits_uop_is_fence            (_iregister_read_io_exe_reqs_1_bits_uop_is_fence),
    .io_req_bits_uop_is_amo              (_iregister_read_io_exe_reqs_1_bits_uop_is_amo),
    .io_req_bits_uop_uses_ldq            (_iregister_read_io_exe_reqs_1_bits_uop_uses_ldq),
    .io_req_bits_uop_uses_stq            (_iregister_read_io_exe_reqs_1_bits_uop_uses_stq),
    .io_req_bits_uop_fp_val              (_iregister_read_io_exe_reqs_1_bits_uop_fp_val),
    .io_req_bits_rs1_data                ({1'h0, _iregister_read_io_exe_reqs_1_bits_rs1_data}),
    .io_req_bits_rs2_data                ({1'h0, _iregister_read_io_exe_reqs_1_bits_rs2_data}),
    .io_brupdate_b1_resolve_mask         (_b1_resolve_mask_T_6),
    .io_brupdate_b1_mispredict_mask      (_b1_mispredict_mask_T_10),
    .io_lsu_io_iresp_valid               (io_lsu_exe_1_iresp_valid),
    .io_lsu_io_iresp_bits_uop_rob_idx    (io_lsu_exe_1_iresp_bits_uop_rob_idx),
    .io_lsu_io_iresp_bits_uop_pdst       (io_lsu_exe_1_iresp_bits_uop_pdst),
    .io_lsu_io_iresp_bits_uop_is_amo     (io_lsu_exe_1_iresp_bits_uop_is_amo),
    .io_lsu_io_iresp_bits_uop_uses_stq   (io_lsu_exe_1_iresp_bits_uop_uses_stq),
    .io_lsu_io_iresp_bits_uop_dst_rtype  (io_lsu_exe_1_iresp_bits_uop_dst_rtype),
    .io_lsu_io_iresp_bits_data           (io_lsu_exe_1_iresp_bits_data),
    .io_lsu_io_fresp_valid               (io_lsu_exe_1_fresp_valid),
    .io_lsu_io_fresp_bits_uop_uopc       (io_lsu_exe_1_fresp_bits_uop_uopc),
    .io_lsu_io_fresp_bits_uop_br_mask    (io_lsu_exe_1_fresp_bits_uop_br_mask),
    .io_lsu_io_fresp_bits_uop_rob_idx    (io_lsu_exe_1_fresp_bits_uop_rob_idx),
    .io_lsu_io_fresp_bits_uop_stq_idx    (io_lsu_exe_1_fresp_bits_uop_stq_idx),
    .io_lsu_io_fresp_bits_uop_pdst       (io_lsu_exe_1_fresp_bits_uop_pdst),
    .io_lsu_io_fresp_bits_uop_mem_size   (io_lsu_exe_1_fresp_bits_uop_mem_size),
    .io_lsu_io_fresp_bits_uop_is_amo     (io_lsu_exe_1_fresp_bits_uop_is_amo),
    .io_lsu_io_fresp_bits_uop_uses_stq   (io_lsu_exe_1_fresp_bits_uop_uses_stq),
    .io_lsu_io_fresp_bits_uop_dst_rtype  (io_lsu_exe_1_fresp_bits_uop_dst_rtype),
    .io_lsu_io_fresp_bits_uop_fp_val     (io_lsu_exe_1_fresp_bits_uop_fp_val),
    .io_lsu_io_fresp_bits_data           (io_lsu_exe_1_fresp_bits_data),
    .io_ll_iresp_valid                   (_memExeUnit_1_io_ll_iresp_valid),
    .io_ll_iresp_bits_uop_rob_idx        (_memExeUnit_1_io_ll_iresp_bits_uop_rob_idx),
    .io_ll_iresp_bits_uop_pdst           (_memExeUnit_1_io_ll_iresp_bits_uop_pdst),
    .io_ll_iresp_bits_uop_is_amo         (_memExeUnit_1_io_ll_iresp_bits_uop_is_amo),
    .io_ll_iresp_bits_uop_uses_stq       (_memExeUnit_1_io_ll_iresp_bits_uop_uses_stq),
    .io_ll_iresp_bits_uop_dst_rtype      (_memExeUnit_1_io_ll_iresp_bits_uop_dst_rtype),
    .io_ll_iresp_bits_data               (_memExeUnit_1_io_ll_iresp_bits_data),
    .io_ll_fresp_valid                   (_memExeUnit_1_io_ll_fresp_valid),
    .io_ll_fresp_bits_uop_uopc           (/* unused */),
    .io_ll_fresp_bits_uop_br_mask        (/* unused */),
    .io_ll_fresp_bits_uop_rob_idx        (_memExeUnit_1_io_ll_fresp_bits_uop_rob_idx),
    .io_ll_fresp_bits_uop_stq_idx        (/* unused */),
    .io_ll_fresp_bits_uop_pdst           (_memExeUnit_1_io_ll_fresp_bits_uop_pdst),
    .io_ll_fresp_bits_uop_mem_size       (_memExeUnit_1_io_ll_fresp_bits_uop_mem_size),
    .io_ll_fresp_bits_uop_is_amo         (/* unused */),
    .io_ll_fresp_bits_uop_uses_stq       (/* unused */),
    .io_ll_fresp_bits_uop_dst_rtype      (_memExeUnit_1_io_ll_fresp_bits_uop_dst_rtype),
    .io_ll_fresp_bits_uop_fp_val         (_memExeUnit_1_io_ll_fresp_bits_uop_fp_val),
    .io_ll_fresp_bits_data               (_memExeUnit_1_io_ll_fresp_bits_data),
    .io_lsu_io_req_valid                 (io_lsu_exe_1_req_valid),
    .io_lsu_io_req_bits_uop_ctrl_is_load (io_lsu_exe_1_req_bits_uop_ctrl_is_load),
    .io_lsu_io_req_bits_uop_ctrl_is_sta  (io_lsu_exe_1_req_bits_uop_ctrl_is_sta),
    .io_lsu_io_req_bits_uop_ctrl_is_std  (io_lsu_exe_1_req_bits_uop_ctrl_is_std),
    .io_lsu_io_req_bits_uop_br_mask      (io_lsu_exe_1_req_bits_uop_br_mask),
    .io_lsu_io_req_bits_uop_rob_idx      (io_lsu_exe_1_req_bits_uop_rob_idx),
    .io_lsu_io_req_bits_uop_ldq_idx      (io_lsu_exe_1_req_bits_uop_ldq_idx),
    .io_lsu_io_req_bits_uop_stq_idx      (io_lsu_exe_1_req_bits_uop_stq_idx),
    .io_lsu_io_req_bits_uop_pdst         (io_lsu_exe_1_req_bits_uop_pdst),
    .io_lsu_io_req_bits_uop_mem_cmd      (io_lsu_exe_1_req_bits_uop_mem_cmd),
    .io_lsu_io_req_bits_uop_mem_size     (io_lsu_exe_1_req_bits_uop_mem_size),
    .io_lsu_io_req_bits_uop_mem_signed   (io_lsu_exe_1_req_bits_uop_mem_signed),
    .io_lsu_io_req_bits_uop_is_fence     (io_lsu_exe_1_req_bits_uop_is_fence),
    .io_lsu_io_req_bits_uop_is_amo       (io_lsu_exe_1_req_bits_uop_is_amo),
    .io_lsu_io_req_bits_uop_uses_ldq     (io_lsu_exe_1_req_bits_uop_uses_ldq),
    .io_lsu_io_req_bits_uop_uses_stq     (io_lsu_exe_1_req_bits_uop_uses_stq),
    .io_lsu_io_req_bits_uop_fp_val       (io_lsu_exe_1_req_bits_uop_fp_val),
    .io_lsu_io_req_bits_data             (io_lsu_exe_1_req_bits_data),
    .io_lsu_io_req_bits_addr             (io_lsu_exe_1_req_bits_addr),
    .io_lsu_io_req_bits_mxcpt_valid      (io_lsu_exe_1_req_bits_mxcpt_valid),
    .io_lsu_io_req_bits_sfence_valid     (_memExeUnit_1_io_lsu_io_req_bits_sfence_valid),
    .io_lsu_io_req_bits_sfence_bits_rs1  (_memExeUnit_1_io_lsu_io_req_bits_sfence_bits_rs1),
    .io_lsu_io_req_bits_sfence_bits_rs2  (_memExeUnit_1_io_lsu_io_req_bits_sfence_bits_rs2),
    .io_lsu_io_req_bits_sfence_bits_addr (_memExeUnit_1_io_lsu_io_req_bits_sfence_bits_addr)
  );
  ALUExeUnit_2 alu_exe_unit (
    .clock                                    (clock),
    .reset                                    (reset),
    .io_req_valid                             (_iregister_read_io_exe_reqs_2_valid),
    .io_req_bits_uop_uopc                     (_iregister_read_io_exe_reqs_2_bits_uop_uopc),
    .io_req_bits_uop_is_rvc                   (_iregister_read_io_exe_reqs_2_bits_uop_is_rvc),
    .io_req_bits_uop_fu_code                  (_iregister_read_io_exe_reqs_2_bits_uop_fu_code),
    .io_req_bits_uop_ctrl_br_type             (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_br_type),
    .io_req_bits_uop_ctrl_op1_sel             (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_op1_sel),
    .io_req_bits_uop_ctrl_op2_sel             (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_op2_sel),
    .io_req_bits_uop_ctrl_imm_sel             (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_imm_sel),
    .io_req_bits_uop_ctrl_op_fcn              (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_op_fcn),
    .io_req_bits_uop_ctrl_fcn_dw              (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_fcn_dw),
    .io_req_bits_uop_is_br                    (_iregister_read_io_exe_reqs_2_bits_uop_is_br),
    .io_req_bits_uop_is_jalr                  (_iregister_read_io_exe_reqs_2_bits_uop_is_jalr),
    .io_req_bits_uop_is_jal                   (_iregister_read_io_exe_reqs_2_bits_uop_is_jal),
    .io_req_bits_uop_is_sfb                   (_iregister_read_io_exe_reqs_2_bits_uop_is_sfb),
    .io_req_bits_uop_br_mask                  (_iregister_read_io_exe_reqs_2_bits_uop_br_mask),
    .io_req_bits_uop_br_tag                   (_iregister_read_io_exe_reqs_2_bits_uop_br_tag),
    .io_req_bits_uop_ftq_idx                  (_iregister_read_io_exe_reqs_2_bits_uop_ftq_idx),
    .io_req_bits_uop_edge_inst                (_iregister_read_io_exe_reqs_2_bits_uop_edge_inst),
    .io_req_bits_uop_pc_lob                   (_iregister_read_io_exe_reqs_2_bits_uop_pc_lob),
    .io_req_bits_uop_taken                    (_iregister_read_io_exe_reqs_2_bits_uop_taken),
    .io_req_bits_uop_imm_packed               (_iregister_read_io_exe_reqs_2_bits_uop_imm_packed),
    .io_req_bits_uop_rob_idx                  (_iregister_read_io_exe_reqs_2_bits_uop_rob_idx),
    .io_req_bits_uop_ldq_idx                  (_iregister_read_io_exe_reqs_2_bits_uop_ldq_idx),
    .io_req_bits_uop_stq_idx                  (_iregister_read_io_exe_reqs_2_bits_uop_stq_idx),
    .io_req_bits_uop_pdst                     (_iregister_read_io_exe_reqs_2_bits_uop_pdst),
    .io_req_bits_uop_prs1                     (_iregister_read_io_exe_reqs_2_bits_uop_prs1),
    .io_req_bits_uop_bypassable               (_iregister_read_io_exe_reqs_2_bits_uop_bypassable),
    .io_req_bits_uop_is_amo                   (_iregister_read_io_exe_reqs_2_bits_uop_is_amo),
    .io_req_bits_uop_uses_stq                 (_iregister_read_io_exe_reqs_2_bits_uop_uses_stq),
    .io_req_bits_uop_dst_rtype                (_iregister_read_io_exe_reqs_2_bits_uop_dst_rtype),
    .io_req_bits_uop_fp_val                   (_iregister_read_io_exe_reqs_2_bits_uop_fp_val),
    .io_req_bits_rs1_data                     ({1'h0, _iregister_read_io_exe_reqs_2_bits_rs1_data}),
    .io_req_bits_rs2_data                     ({1'h0, _iregister_read_io_exe_reqs_2_bits_rs2_data}),
    .io_req_bits_kill                         (alu_exe_unit_io_req_bits_kill_REG),
    .io_ll_fresp_ready                        (_FpPipeline_io_from_int_ready),
    .io_brupdate_b1_resolve_mask              (_b1_resolve_mask_T_6),
    .io_brupdate_b1_mispredict_mask           (_b1_mispredict_mask_T_10),
    .io_get_ftq_pc_entry_cfi_idx_valid        (io_ifu_get_pc_0_entry_cfi_idx_valid),
    .io_get_ftq_pc_entry_cfi_idx_bits         (io_ifu_get_pc_0_entry_cfi_idx_bits),
    .io_get_ftq_pc_entry_start_bank           (io_ifu_get_pc_0_entry_start_bank),
    .io_get_ftq_pc_pc                         (io_ifu_get_pc_0_pc),
    .io_get_ftq_pc_next_val                   (io_ifu_get_pc_0_next_val),
    .io_get_ftq_pc_next_pc                    (io_ifu_get_pc_0_next_pc),
    .io_fcsr_rm                               (_csr_io_fcsr_rm),
    .io_fu_types                              (_alu_exe_unit_io_fu_types),
    .io_iresp_valid                           (_alu_exe_unit_io_iresp_valid),
    .io_iresp_bits_uop_rob_idx                (_alu_exe_unit_io_iresp_bits_uop_rob_idx),
    .io_iresp_bits_uop_pdst                   (_alu_exe_unit_io_iresp_bits_uop_pdst),
    .io_iresp_bits_uop_bypassable             (_alu_exe_unit_io_iresp_bits_uop_bypassable),
    .io_iresp_bits_uop_is_amo                 (_alu_exe_unit_io_iresp_bits_uop_is_amo),
    .io_iresp_bits_uop_uses_stq               (_alu_exe_unit_io_iresp_bits_uop_uses_stq),
    .io_iresp_bits_uop_dst_rtype              (_alu_exe_unit_io_iresp_bits_uop_dst_rtype),
    .io_iresp_bits_data                       (_alu_exe_unit_io_iresp_bits_data),
    .io_ll_fresp_valid                        (_alu_exe_unit_io_ll_fresp_valid),
    .io_ll_fresp_bits_uop_uopc                (_alu_exe_unit_io_ll_fresp_bits_uop_uopc),
    .io_ll_fresp_bits_uop_br_mask             (_alu_exe_unit_io_ll_fresp_bits_uop_br_mask),
    .io_ll_fresp_bits_uop_rob_idx             (_alu_exe_unit_io_ll_fresp_bits_uop_rob_idx),
    .io_ll_fresp_bits_uop_stq_idx             (_alu_exe_unit_io_ll_fresp_bits_uop_stq_idx),
    .io_ll_fresp_bits_uop_pdst                (_alu_exe_unit_io_ll_fresp_bits_uop_pdst),
    .io_ll_fresp_bits_uop_is_amo              (_alu_exe_unit_io_ll_fresp_bits_uop_is_amo),
    .io_ll_fresp_bits_uop_uses_stq            (_alu_exe_unit_io_ll_fresp_bits_uop_uses_stq),
    .io_ll_fresp_bits_uop_dst_rtype           (_alu_exe_unit_io_ll_fresp_bits_uop_dst_rtype),
    .io_ll_fresp_bits_uop_fp_val              (_alu_exe_unit_io_ll_fresp_bits_uop_fp_val),
    .io_ll_fresp_bits_data                    (_alu_exe_unit_io_ll_fresp_bits_data),
    .io_ll_fresp_bits_predicated              (_alu_exe_unit_io_ll_fresp_bits_predicated),
    .io_ll_fresp_bits_fflags_valid            (_alu_exe_unit_io_ll_fresp_bits_fflags_valid),
    .io_ll_fresp_bits_fflags_bits_uop_rob_idx (_alu_exe_unit_io_ll_fresp_bits_fflags_bits_uop_rob_idx),
    .io_ll_fresp_bits_fflags_bits_flags       (_alu_exe_unit_io_ll_fresp_bits_fflags_bits_flags),
    .io_bypass_0_valid                        (_alu_exe_unit_io_bypass_0_valid),
    .io_bypass_0_bits_uop_pdst                (_alu_exe_unit_io_bypass_0_bits_uop_pdst),
    .io_bypass_0_bits_uop_dst_rtype           (_alu_exe_unit_io_bypass_0_bits_uop_dst_rtype),
    .io_bypass_0_bits_data                    (_alu_exe_unit_io_bypass_0_bits_data),
    .io_brinfo_uop_is_rvc                     (_alu_exe_unit_io_brinfo_uop_is_rvc),
    .io_brinfo_uop_br_mask                    (_alu_exe_unit_io_brinfo_uop_br_mask),
    .io_brinfo_uop_br_tag                     (_alu_exe_unit_io_brinfo_uop_br_tag),
    .io_brinfo_uop_ftq_idx                    (_alu_exe_unit_io_brinfo_uop_ftq_idx),
    .io_brinfo_uop_edge_inst                  (_alu_exe_unit_io_brinfo_uop_edge_inst),
    .io_brinfo_uop_pc_lob                     (_alu_exe_unit_io_brinfo_uop_pc_lob),
    .io_brinfo_uop_rob_idx                    (_alu_exe_unit_io_brinfo_uop_rob_idx),
    .io_brinfo_uop_ldq_idx                    (_alu_exe_unit_io_brinfo_uop_ldq_idx),
    .io_brinfo_uop_stq_idx                    (_alu_exe_unit_io_brinfo_uop_stq_idx),
    .io_brinfo_valid                          (_alu_exe_unit_io_brinfo_valid),
    .io_brinfo_mispredict                     (_alu_exe_unit_io_brinfo_mispredict),
    .io_brinfo_taken                          (_alu_exe_unit_io_brinfo_taken),
    .io_brinfo_cfi_type                       (_alu_exe_unit_io_brinfo_cfi_type),
    .io_brinfo_pc_sel                         (_alu_exe_unit_io_brinfo_pc_sel),
    .io_brinfo_jalr_target                    (_alu_exe_unit_io_brinfo_jalr_target),
    .io_brinfo_target_offset                  (_alu_exe_unit_io_brinfo_target_offset)
  );
  ALUExeUnit_3 alu_exe_unit_1 (
    .clock                          (clock),
    .reset                          (reset),
    .io_req_valid                   (_iregister_read_io_exe_reqs_3_valid),
    .io_req_bits_uop_uopc           (_iregister_read_io_exe_reqs_3_bits_uop_uopc),
    .io_req_bits_uop_is_rvc         (_iregister_read_io_exe_reqs_3_bits_uop_is_rvc),
    .io_req_bits_uop_fu_code        (_iregister_read_io_exe_reqs_3_bits_uop_fu_code),
    .io_req_bits_uop_ctrl_br_type   (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_br_type),
    .io_req_bits_uop_ctrl_op1_sel   (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_op1_sel),
    .io_req_bits_uop_ctrl_op2_sel   (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_op2_sel),
    .io_req_bits_uop_ctrl_imm_sel   (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_imm_sel),
    .io_req_bits_uop_ctrl_op_fcn    (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_op_fcn),
    .io_req_bits_uop_ctrl_fcn_dw    (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_fcn_dw),
    .io_req_bits_uop_ctrl_csr_cmd   (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_csr_cmd),
    .io_req_bits_uop_is_br          (_iregister_read_io_exe_reqs_3_bits_uop_is_br),
    .io_req_bits_uop_is_jalr        (_iregister_read_io_exe_reqs_3_bits_uop_is_jalr),
    .io_req_bits_uop_is_jal         (_iregister_read_io_exe_reqs_3_bits_uop_is_jal),
    .io_req_bits_uop_is_sfb         (_iregister_read_io_exe_reqs_3_bits_uop_is_sfb),
    .io_req_bits_uop_br_mask        (_iregister_read_io_exe_reqs_3_bits_uop_br_mask),
    .io_req_bits_uop_br_tag         (_iregister_read_io_exe_reqs_3_bits_uop_br_tag),
    .io_req_bits_uop_ftq_idx        (_iregister_read_io_exe_reqs_3_bits_uop_ftq_idx),
    .io_req_bits_uop_edge_inst      (_iregister_read_io_exe_reqs_3_bits_uop_edge_inst),
    .io_req_bits_uop_pc_lob         (_iregister_read_io_exe_reqs_3_bits_uop_pc_lob),
    .io_req_bits_uop_taken          (_iregister_read_io_exe_reqs_3_bits_uop_taken),
    .io_req_bits_uop_imm_packed     (_iregister_read_io_exe_reqs_3_bits_uop_imm_packed),
    .io_req_bits_uop_rob_idx        (_iregister_read_io_exe_reqs_3_bits_uop_rob_idx),
    .io_req_bits_uop_ldq_idx        (_iregister_read_io_exe_reqs_3_bits_uop_ldq_idx),
    .io_req_bits_uop_stq_idx        (_iregister_read_io_exe_reqs_3_bits_uop_stq_idx),
    .io_req_bits_uop_pdst           (_iregister_read_io_exe_reqs_3_bits_uop_pdst),
    .io_req_bits_uop_prs1           (_iregister_read_io_exe_reqs_3_bits_uop_prs1),
    .io_req_bits_uop_bypassable     (_iregister_read_io_exe_reqs_3_bits_uop_bypassable),
    .io_req_bits_uop_is_amo         (_iregister_read_io_exe_reqs_3_bits_uop_is_amo),
    .io_req_bits_uop_uses_stq       (_iregister_read_io_exe_reqs_3_bits_uop_uses_stq),
    .io_req_bits_uop_dst_rtype      (_iregister_read_io_exe_reqs_3_bits_uop_dst_rtype),
    .io_req_bits_rs1_data           ({1'h0, _iregister_read_io_exe_reqs_3_bits_rs1_data}),
    .io_req_bits_rs2_data           ({1'h0, _iregister_read_io_exe_reqs_3_bits_rs2_data}),
    .io_req_bits_kill               (alu_exe_unit_io_req_bits_kill_REG_1),
    .io_brupdate_b1_resolve_mask    (_b1_resolve_mask_T_6),
    .io_brupdate_b1_mispredict_mask (_b1_mispredict_mask_T_10),
    .io_iresp_valid                 (_alu_exe_unit_1_io_iresp_valid),
    .io_iresp_bits_uop_ctrl_csr_cmd (_alu_exe_unit_1_io_iresp_bits_uop_ctrl_csr_cmd),
    .io_iresp_bits_uop_csr_addr     (_alu_exe_unit_1_io_iresp_bits_uop_csr_addr),
    .io_iresp_bits_uop_rob_idx      (_alu_exe_unit_1_io_iresp_bits_uop_rob_idx),
    .io_iresp_bits_uop_pdst         (_alu_exe_unit_1_io_iresp_bits_uop_pdst),
    .io_iresp_bits_uop_bypassable   (_alu_exe_unit_1_io_iresp_bits_uop_bypassable),
    .io_iresp_bits_uop_is_amo       (_alu_exe_unit_1_io_iresp_bits_uop_is_amo),
    .io_iresp_bits_uop_uses_stq     (_alu_exe_unit_1_io_iresp_bits_uop_uses_stq),
    .io_iresp_bits_uop_dst_rtype    (_alu_exe_unit_1_io_iresp_bits_uop_dst_rtype),
    .io_iresp_bits_data             (_alu_exe_unit_1_io_iresp_bits_data),
    .io_bypass_0_valid              (_alu_exe_unit_1_io_bypass_0_valid),
    .io_bypass_0_bits_uop_pdst      (_alu_exe_unit_1_io_bypass_0_bits_uop_pdst),
    .io_bypass_0_bits_uop_dst_rtype (_alu_exe_unit_1_io_bypass_0_bits_uop_dst_rtype),
    .io_bypass_0_bits_data          (_alu_exe_unit_1_io_bypass_0_bits_data),
    .io_brinfo_uop_is_rvc           (_alu_exe_unit_1_io_brinfo_uop_is_rvc),
    .io_brinfo_uop_br_mask          (_alu_exe_unit_1_io_brinfo_uop_br_mask),
    .io_brinfo_uop_br_tag           (_alu_exe_unit_1_io_brinfo_uop_br_tag),
    .io_brinfo_uop_ftq_idx          (_alu_exe_unit_1_io_brinfo_uop_ftq_idx),
    .io_brinfo_uop_edge_inst        (_alu_exe_unit_1_io_brinfo_uop_edge_inst),
    .io_brinfo_uop_pc_lob           (_alu_exe_unit_1_io_brinfo_uop_pc_lob),
    .io_brinfo_uop_rob_idx          (_alu_exe_unit_1_io_brinfo_uop_rob_idx),
    .io_brinfo_uop_ldq_idx          (_alu_exe_unit_1_io_brinfo_uop_ldq_idx),
    .io_brinfo_uop_stq_idx          (_alu_exe_unit_1_io_brinfo_uop_stq_idx),
    .io_brinfo_valid                (_alu_exe_unit_1_io_brinfo_valid),
    .io_brinfo_mispredict           (_alu_exe_unit_1_io_brinfo_mispredict),
    .io_brinfo_taken                (_alu_exe_unit_1_io_brinfo_taken),
    .io_brinfo_cfi_type             (_alu_exe_unit_1_io_brinfo_cfi_type),
    .io_brinfo_pc_sel               (_alu_exe_unit_1_io_brinfo_pc_sel),
    .io_brinfo_target_offset        (_alu_exe_unit_1_io_brinfo_target_offset)
  );
  ALUExeUnit_4 alu_exe_unit_2 (
    .clock                          (clock),
    .reset                          (reset),
    .io_req_valid                   (_iregister_read_io_exe_reqs_4_valid),
    .io_req_bits_uop_uopc           (_iregister_read_io_exe_reqs_4_bits_uop_uopc),
    .io_req_bits_uop_is_rvc         (_iregister_read_io_exe_reqs_4_bits_uop_is_rvc),
    .io_req_bits_uop_fu_code        (_iregister_read_io_exe_reqs_4_bits_uop_fu_code),
    .io_req_bits_uop_ctrl_br_type   (_iregister_read_io_exe_reqs_4_bits_uop_ctrl_br_type),
    .io_req_bits_uop_ctrl_op1_sel   (_iregister_read_io_exe_reqs_4_bits_uop_ctrl_op1_sel),
    .io_req_bits_uop_ctrl_op2_sel   (_iregister_read_io_exe_reqs_4_bits_uop_ctrl_op2_sel),
    .io_req_bits_uop_ctrl_imm_sel   (_iregister_read_io_exe_reqs_4_bits_uop_ctrl_imm_sel),
    .io_req_bits_uop_ctrl_op_fcn    (_iregister_read_io_exe_reqs_4_bits_uop_ctrl_op_fcn),
    .io_req_bits_uop_ctrl_fcn_dw    (_iregister_read_io_exe_reqs_4_bits_uop_ctrl_fcn_dw),
    .io_req_bits_uop_is_br          (_iregister_read_io_exe_reqs_4_bits_uop_is_br),
    .io_req_bits_uop_is_jalr        (_iregister_read_io_exe_reqs_4_bits_uop_is_jalr),
    .io_req_bits_uop_is_jal         (_iregister_read_io_exe_reqs_4_bits_uop_is_jal),
    .io_req_bits_uop_is_sfb         (_iregister_read_io_exe_reqs_4_bits_uop_is_sfb),
    .io_req_bits_uop_br_mask        (_iregister_read_io_exe_reqs_4_bits_uop_br_mask),
    .io_req_bits_uop_br_tag         (_iregister_read_io_exe_reqs_4_bits_uop_br_tag),
    .io_req_bits_uop_ftq_idx        (_iregister_read_io_exe_reqs_4_bits_uop_ftq_idx),
    .io_req_bits_uop_edge_inst      (_iregister_read_io_exe_reqs_4_bits_uop_edge_inst),
    .io_req_bits_uop_pc_lob         (_iregister_read_io_exe_reqs_4_bits_uop_pc_lob),
    .io_req_bits_uop_taken          (_iregister_read_io_exe_reqs_4_bits_uop_taken),
    .io_req_bits_uop_imm_packed     (_iregister_read_io_exe_reqs_4_bits_uop_imm_packed),
    .io_req_bits_uop_rob_idx        (_iregister_read_io_exe_reqs_4_bits_uop_rob_idx),
    .io_req_bits_uop_ldq_idx        (_iregister_read_io_exe_reqs_4_bits_uop_ldq_idx),
    .io_req_bits_uop_stq_idx        (_iregister_read_io_exe_reqs_4_bits_uop_stq_idx),
    .io_req_bits_uop_pdst           (_iregister_read_io_exe_reqs_4_bits_uop_pdst),
    .io_req_bits_uop_prs1           (_iregister_read_io_exe_reqs_4_bits_uop_prs1),
    .io_req_bits_uop_bypassable     (_iregister_read_io_exe_reqs_4_bits_uop_bypassable),
    .io_req_bits_uop_is_amo         (_iregister_read_io_exe_reqs_4_bits_uop_is_amo),
    .io_req_bits_uop_uses_stq       (_iregister_read_io_exe_reqs_4_bits_uop_uses_stq),
    .io_req_bits_uop_dst_rtype      (_iregister_read_io_exe_reqs_4_bits_uop_dst_rtype),
    .io_req_bits_rs1_data           ({1'h0, _iregister_read_io_exe_reqs_4_bits_rs1_data}),
    .io_req_bits_rs2_data           ({1'h0, _iregister_read_io_exe_reqs_4_bits_rs2_data}),
    .io_req_bits_kill               (alu_exe_unit_io_req_bits_kill_REG_2),
    .io_brupdate_b1_resolve_mask    (_b1_resolve_mask_T_6),
    .io_brupdate_b1_mispredict_mask (_b1_mispredict_mask_T_10),
    .io_iresp_valid                 (_alu_exe_unit_2_io_iresp_valid),
    .io_iresp_bits_uop_rob_idx      (_alu_exe_unit_2_io_iresp_bits_uop_rob_idx),
    .io_iresp_bits_uop_pdst         (_alu_exe_unit_2_io_iresp_bits_uop_pdst),
    .io_iresp_bits_uop_bypassable   (_alu_exe_unit_2_io_iresp_bits_uop_bypassable),
    .io_iresp_bits_uop_is_amo       (_alu_exe_unit_2_io_iresp_bits_uop_is_amo),
    .io_iresp_bits_uop_uses_stq     (_alu_exe_unit_2_io_iresp_bits_uop_uses_stq),
    .io_iresp_bits_uop_dst_rtype    (_alu_exe_unit_2_io_iresp_bits_uop_dst_rtype),
    .io_iresp_bits_data             (_alu_exe_unit_2_io_iresp_bits_data),
    .io_bypass_0_valid              (_alu_exe_unit_2_io_bypass_0_valid),
    .io_bypass_0_bits_uop_pdst      (_alu_exe_unit_2_io_bypass_0_bits_uop_pdst),
    .io_bypass_0_bits_uop_dst_rtype (_alu_exe_unit_2_io_bypass_0_bits_uop_dst_rtype),
    .io_bypass_0_bits_data          (_alu_exe_unit_2_io_bypass_0_bits_data),
    .io_bypass_1_valid              (_alu_exe_unit_2_io_bypass_1_valid),
    .io_bypass_1_bits_uop_pdst      (_alu_exe_unit_2_io_bypass_1_bits_uop_pdst),
    .io_bypass_1_bits_uop_dst_rtype (_alu_exe_unit_2_io_bypass_1_bits_uop_dst_rtype),
    .io_bypass_1_bits_data          (_alu_exe_unit_2_io_bypass_1_bits_data),
    .io_bypass_2_valid              (_alu_exe_unit_2_io_bypass_2_valid),
    .io_bypass_2_bits_uop_pdst      (_alu_exe_unit_2_io_bypass_2_bits_uop_pdst),
    .io_bypass_2_bits_uop_dst_rtype (_alu_exe_unit_2_io_bypass_2_bits_uop_dst_rtype),
    .io_bypass_2_bits_data          (_alu_exe_unit_2_io_bypass_2_bits_data),
    .io_brinfo_uop_is_rvc           (_alu_exe_unit_2_io_brinfo_uop_is_rvc),
    .io_brinfo_uop_br_mask          (_alu_exe_unit_2_io_brinfo_uop_br_mask),
    .io_brinfo_uop_br_tag           (_alu_exe_unit_2_io_brinfo_uop_br_tag),
    .io_brinfo_uop_ftq_idx          (_alu_exe_unit_2_io_brinfo_uop_ftq_idx),
    .io_brinfo_uop_edge_inst        (_alu_exe_unit_2_io_brinfo_uop_edge_inst),
    .io_brinfo_uop_pc_lob           (_alu_exe_unit_2_io_brinfo_uop_pc_lob),
    .io_brinfo_uop_rob_idx          (_alu_exe_unit_2_io_brinfo_uop_rob_idx),
    .io_brinfo_uop_ldq_idx          (_alu_exe_unit_2_io_brinfo_uop_ldq_idx),
    .io_brinfo_uop_stq_idx          (_alu_exe_unit_2_io_brinfo_uop_stq_idx),
    .io_brinfo_valid                (_alu_exe_unit_2_io_brinfo_valid),
    .io_brinfo_mispredict           (_alu_exe_unit_2_io_brinfo_mispredict),
    .io_brinfo_taken                (_alu_exe_unit_2_io_brinfo_taken),
    .io_brinfo_cfi_type             (_alu_exe_unit_2_io_brinfo_cfi_type),
    .io_brinfo_pc_sel               (_alu_exe_unit_2_io_brinfo_pc_sel),
    .io_brinfo_target_offset        (_alu_exe_unit_2_io_brinfo_target_offset)
  );
  ALUExeUnit_5 alu_exe_unit_3 (
    .clock                          (clock),
    .reset                          (reset),
    .io_req_valid                   (_iregister_read_io_exe_reqs_5_valid),
    .io_req_bits_uop_uopc           (_iregister_read_io_exe_reqs_5_bits_uop_uopc),
    .io_req_bits_uop_is_rvc         (_iregister_read_io_exe_reqs_5_bits_uop_is_rvc),
    .io_req_bits_uop_fu_code        (_iregister_read_io_exe_reqs_5_bits_uop_fu_code),
    .io_req_bits_uop_ctrl_br_type   (_iregister_read_io_exe_reqs_5_bits_uop_ctrl_br_type),
    .io_req_bits_uop_ctrl_op1_sel   (_iregister_read_io_exe_reqs_5_bits_uop_ctrl_op1_sel),
    .io_req_bits_uop_ctrl_op2_sel   (_iregister_read_io_exe_reqs_5_bits_uop_ctrl_op2_sel),
    .io_req_bits_uop_ctrl_imm_sel   (_iregister_read_io_exe_reqs_5_bits_uop_ctrl_imm_sel),
    .io_req_bits_uop_ctrl_op_fcn    (_iregister_read_io_exe_reqs_5_bits_uop_ctrl_op_fcn),
    .io_req_bits_uop_ctrl_fcn_dw    (_iregister_read_io_exe_reqs_5_bits_uop_ctrl_fcn_dw),
    .io_req_bits_uop_ctrl_csr_cmd   (_iregister_read_io_exe_reqs_5_bits_uop_ctrl_csr_cmd),
    .io_req_bits_uop_is_br          (_iregister_read_io_exe_reqs_5_bits_uop_is_br),
    .io_req_bits_uop_is_jalr        (_iregister_read_io_exe_reqs_5_bits_uop_is_jalr),
    .io_req_bits_uop_is_jal         (_iregister_read_io_exe_reqs_5_bits_uop_is_jal),
    .io_req_bits_uop_is_sfb         (_iregister_read_io_exe_reqs_5_bits_uop_is_sfb),
    .io_req_bits_uop_br_mask        (_iregister_read_io_exe_reqs_5_bits_uop_br_mask),
    .io_req_bits_uop_br_tag         (_iregister_read_io_exe_reqs_5_bits_uop_br_tag),
    .io_req_bits_uop_ftq_idx        (_iregister_read_io_exe_reqs_5_bits_uop_ftq_idx),
    .io_req_bits_uop_edge_inst      (_iregister_read_io_exe_reqs_5_bits_uop_edge_inst),
    .io_req_bits_uop_pc_lob         (_iregister_read_io_exe_reqs_5_bits_uop_pc_lob),
    .io_req_bits_uop_taken          (_iregister_read_io_exe_reqs_5_bits_uop_taken),
    .io_req_bits_uop_imm_packed     (_iregister_read_io_exe_reqs_5_bits_uop_imm_packed),
    .io_req_bits_uop_rob_idx        (_iregister_read_io_exe_reqs_5_bits_uop_rob_idx),
    .io_req_bits_uop_ldq_idx        (_iregister_read_io_exe_reqs_5_bits_uop_ldq_idx),
    .io_req_bits_uop_stq_idx        (_iregister_read_io_exe_reqs_5_bits_uop_stq_idx),
    .io_req_bits_uop_pdst           (_iregister_read_io_exe_reqs_5_bits_uop_pdst),
    .io_req_bits_uop_prs1           (_iregister_read_io_exe_reqs_5_bits_uop_prs1),
    .io_req_bits_uop_bypassable     (_iregister_read_io_exe_reqs_5_bits_uop_bypassable),
    .io_req_bits_uop_is_amo         (_iregister_read_io_exe_reqs_5_bits_uop_is_amo),
    .io_req_bits_uop_uses_stq       (_iregister_read_io_exe_reqs_5_bits_uop_uses_stq),
    .io_req_bits_uop_dst_rtype      (_iregister_read_io_exe_reqs_5_bits_uop_dst_rtype),
    .io_req_bits_rs1_data           ({1'h0, _iregister_read_io_exe_reqs_5_bits_rs1_data}),
    .io_req_bits_rs2_data           ({1'h0, _iregister_read_io_exe_reqs_5_bits_rs2_data}),
    .io_req_bits_kill               (alu_exe_unit_io_req_bits_kill_REG_3),
    .io_brupdate_b1_resolve_mask    (_b1_resolve_mask_T_6),
    .io_brupdate_b1_mispredict_mask (_b1_mispredict_mask_T_10),
    .io_fu_types                    (_alu_exe_unit_3_io_fu_types),
    .io_iresp_valid                 (_alu_exe_unit_3_io_iresp_valid),
    .io_iresp_bits_uop_rob_idx      (_alu_exe_unit_3_io_iresp_bits_uop_rob_idx),
    .io_iresp_bits_uop_pdst         (_alu_exe_unit_3_io_iresp_bits_uop_pdst),
    .io_iresp_bits_uop_bypassable   (_alu_exe_unit_3_io_iresp_bits_uop_bypassable),
    .io_iresp_bits_uop_is_amo       (_alu_exe_unit_3_io_iresp_bits_uop_is_amo),
    .io_iresp_bits_uop_uses_stq     (_alu_exe_unit_3_io_iresp_bits_uop_uses_stq),
    .io_iresp_bits_uop_dst_rtype    (_alu_exe_unit_3_io_iresp_bits_uop_dst_rtype),
    .io_iresp_bits_data             (_alu_exe_unit_3_io_iresp_bits_data),
    .io_bypass_0_valid              (_alu_exe_unit_3_io_bypass_0_valid),
    .io_bypass_0_bits_uop_pdst      (_alu_exe_unit_3_io_bypass_0_bits_uop_pdst),
    .io_bypass_0_bits_uop_dst_rtype (_alu_exe_unit_3_io_bypass_0_bits_uop_dst_rtype),
    .io_bypass_0_bits_data          (_alu_exe_unit_3_io_bypass_0_bits_data),
    .io_brinfo_uop_is_rvc           (_alu_exe_unit_3_io_brinfo_uop_is_rvc),
    .io_brinfo_uop_br_mask          (_alu_exe_unit_3_io_brinfo_uop_br_mask),
    .io_brinfo_uop_br_tag           (_alu_exe_unit_3_io_brinfo_uop_br_tag),
    .io_brinfo_uop_ftq_idx          (_alu_exe_unit_3_io_brinfo_uop_ftq_idx),
    .io_brinfo_uop_edge_inst        (_alu_exe_unit_3_io_brinfo_uop_edge_inst),
    .io_brinfo_uop_pc_lob           (_alu_exe_unit_3_io_brinfo_uop_pc_lob),
    .io_brinfo_uop_rob_idx          (_alu_exe_unit_3_io_brinfo_uop_rob_idx),
    .io_brinfo_uop_ldq_idx          (_alu_exe_unit_3_io_brinfo_uop_ldq_idx),
    .io_brinfo_uop_stq_idx          (_alu_exe_unit_3_io_brinfo_uop_stq_idx),
    .io_brinfo_valid                (_alu_exe_unit_3_io_brinfo_valid),
    .io_brinfo_mispredict           (_alu_exe_unit_3_io_brinfo_mispredict),
    .io_brinfo_taken                (_alu_exe_unit_3_io_brinfo_taken),
    .io_brinfo_cfi_type             (_alu_exe_unit_3_io_brinfo_cfi_type),
    .io_brinfo_pc_sel               (_alu_exe_unit_3_io_brinfo_pc_sel),
    .io_brinfo_target_offset        (_alu_exe_unit_3_io_brinfo_target_offset)
  );
  FpPipeline FpPipeline (
    .clock                                     (clock),
    .reset                                     (reset),
    .io_brupdate_b1_resolve_mask               (_b1_resolve_mask_T_6),
    .io_brupdate_b1_mispredict_mask            (_b1_mispredict_mask_T_10),
    .io_flush_pipeline                         (REG_7),
    .io_fcsr_rm                                (_csr_io_fcsr_rm),
    .io_dis_uops_0_valid                       (_dispatcher_io_dis_uops_2_0_valid),
    .io_dis_uops_0_bits_uopc                   (_dispatcher_io_dis_uops_2_0_bits_uopc),
    .io_dis_uops_0_bits_fu_code                (_dispatcher_io_dis_uops_2_0_bits_fu_code),
    .io_dis_uops_0_bits_br_mask                (_dispatcher_io_dis_uops_2_0_bits_br_mask),
    .io_dis_uops_0_bits_imm_packed             (_dispatcher_io_dis_uops_2_0_bits_imm_packed),
    .io_dis_uops_0_bits_rob_idx                (_dispatcher_io_dis_uops_2_0_bits_rob_idx),
    .io_dis_uops_0_bits_stq_idx                (_dispatcher_io_dis_uops_2_0_bits_stq_idx),
    .io_dis_uops_0_bits_pdst                   (_dispatcher_io_dis_uops_2_0_bits_pdst),
    .io_dis_uops_0_bits_prs1                   (_dispatcher_io_dis_uops_2_0_bits_prs1),
    .io_dis_uops_0_bits_prs2                   (_dispatcher_io_dis_uops_2_0_bits_prs2),
    .io_dis_uops_0_bits_prs3                   (_dispatcher_io_dis_uops_2_0_bits_prs3),
    .io_dis_uops_0_bits_prs1_busy              (_dispatcher_io_dis_uops_2_0_bits_prs1_busy),
    .io_dis_uops_0_bits_prs2_busy              (_dispatcher_io_dis_uops_2_0_bits_prs2_busy),
    .io_dis_uops_0_bits_prs3_busy              (_dispatcher_io_dis_uops_2_0_bits_prs3_busy),
    .io_dis_uops_0_bits_exception              (_dispatcher_io_dis_uops_2_0_bits_exception),
    .io_dis_uops_0_bits_mem_cmd                (_dispatcher_io_dis_uops_2_0_bits_mem_cmd),
    .io_dis_uops_0_bits_is_fence               (_dispatcher_io_dis_uops_2_0_bits_is_fence),
    .io_dis_uops_0_bits_is_fencei              (_dispatcher_io_dis_uops_2_0_bits_is_fencei),
    .io_dis_uops_0_bits_is_amo                 (_dispatcher_io_dis_uops_2_0_bits_is_amo),
    .io_dis_uops_0_bits_uses_ldq               (_dispatcher_io_dis_uops_2_0_bits_uses_ldq),
    .io_dis_uops_0_bits_uses_stq               (_dispatcher_io_dis_uops_2_0_bits_uses_stq),
    .io_dis_uops_0_bits_dst_rtype              (_dispatcher_io_dis_uops_2_0_bits_dst_rtype),
    .io_dis_uops_0_bits_fp_val                 (_dispatcher_io_dis_uops_2_0_bits_fp_val),
    .io_dis_uops_1_valid                       (_dispatcher_io_dis_uops_2_1_valid),
    .io_dis_uops_1_bits_uopc                   (_dispatcher_io_dis_uops_2_1_bits_uopc),
    .io_dis_uops_1_bits_fu_code                (_dispatcher_io_dis_uops_2_1_bits_fu_code),
    .io_dis_uops_1_bits_br_mask                (_dispatcher_io_dis_uops_2_1_bits_br_mask),
    .io_dis_uops_1_bits_imm_packed             (_dispatcher_io_dis_uops_2_1_bits_imm_packed),
    .io_dis_uops_1_bits_rob_idx                (_dispatcher_io_dis_uops_2_1_bits_rob_idx),
    .io_dis_uops_1_bits_stq_idx                (_dispatcher_io_dis_uops_2_1_bits_stq_idx),
    .io_dis_uops_1_bits_pdst                   (_dispatcher_io_dis_uops_2_1_bits_pdst),
    .io_dis_uops_1_bits_prs1                   (_dispatcher_io_dis_uops_2_1_bits_prs1),
    .io_dis_uops_1_bits_prs2                   (_dispatcher_io_dis_uops_2_1_bits_prs2),
    .io_dis_uops_1_bits_prs3                   (_dispatcher_io_dis_uops_2_1_bits_prs3),
    .io_dis_uops_1_bits_prs1_busy              (_dispatcher_io_dis_uops_2_1_bits_prs1_busy),
    .io_dis_uops_1_bits_prs2_busy              (_dispatcher_io_dis_uops_2_1_bits_prs2_busy),
    .io_dis_uops_1_bits_prs3_busy              (_dispatcher_io_dis_uops_2_1_bits_prs3_busy),
    .io_dis_uops_1_bits_exception              (_dispatcher_io_dis_uops_2_1_bits_exception),
    .io_dis_uops_1_bits_mem_cmd                (_dispatcher_io_dis_uops_2_1_bits_mem_cmd),
    .io_dis_uops_1_bits_is_fence               (_dispatcher_io_dis_uops_2_1_bits_is_fence),
    .io_dis_uops_1_bits_is_fencei              (_dispatcher_io_dis_uops_2_1_bits_is_fencei),
    .io_dis_uops_1_bits_is_amo                 (_dispatcher_io_dis_uops_2_1_bits_is_amo),
    .io_dis_uops_1_bits_uses_ldq               (_dispatcher_io_dis_uops_2_1_bits_uses_ldq),
    .io_dis_uops_1_bits_uses_stq               (_dispatcher_io_dis_uops_2_1_bits_uses_stq),
    .io_dis_uops_1_bits_dst_rtype              (_dispatcher_io_dis_uops_2_1_bits_dst_rtype),
    .io_dis_uops_1_bits_fp_val                 (_dispatcher_io_dis_uops_2_1_bits_fp_val),
    .io_dis_uops_2_valid                       (_dispatcher_io_dis_uops_2_2_valid),
    .io_dis_uops_2_bits_uopc                   (_dispatcher_io_dis_uops_2_2_bits_uopc),
    .io_dis_uops_2_bits_fu_code                (_dispatcher_io_dis_uops_2_2_bits_fu_code),
    .io_dis_uops_2_bits_br_mask                (_dispatcher_io_dis_uops_2_2_bits_br_mask),
    .io_dis_uops_2_bits_imm_packed             (_dispatcher_io_dis_uops_2_2_bits_imm_packed),
    .io_dis_uops_2_bits_rob_idx                (_dispatcher_io_dis_uops_2_2_bits_rob_idx),
    .io_dis_uops_2_bits_stq_idx                (_dispatcher_io_dis_uops_2_2_bits_stq_idx),
    .io_dis_uops_2_bits_pdst                   (_dispatcher_io_dis_uops_2_2_bits_pdst),
    .io_dis_uops_2_bits_prs1                   (_dispatcher_io_dis_uops_2_2_bits_prs1),
    .io_dis_uops_2_bits_prs2                   (_dispatcher_io_dis_uops_2_2_bits_prs2),
    .io_dis_uops_2_bits_prs3                   (_dispatcher_io_dis_uops_2_2_bits_prs3),
    .io_dis_uops_2_bits_prs1_busy              (_dispatcher_io_dis_uops_2_2_bits_prs1_busy),
    .io_dis_uops_2_bits_prs2_busy              (_dispatcher_io_dis_uops_2_2_bits_prs2_busy),
    .io_dis_uops_2_bits_prs3_busy              (_dispatcher_io_dis_uops_2_2_bits_prs3_busy),
    .io_dis_uops_2_bits_exception              (_dispatcher_io_dis_uops_2_2_bits_exception),
    .io_dis_uops_2_bits_mem_cmd                (_dispatcher_io_dis_uops_2_2_bits_mem_cmd),
    .io_dis_uops_2_bits_is_fence               (_dispatcher_io_dis_uops_2_2_bits_is_fence),
    .io_dis_uops_2_bits_is_fencei              (_dispatcher_io_dis_uops_2_2_bits_is_fencei),
    .io_dis_uops_2_bits_is_amo                 (_dispatcher_io_dis_uops_2_2_bits_is_amo),
    .io_dis_uops_2_bits_uses_ldq               (_dispatcher_io_dis_uops_2_2_bits_uses_ldq),
    .io_dis_uops_2_bits_uses_stq               (_dispatcher_io_dis_uops_2_2_bits_uses_stq),
    .io_dis_uops_2_bits_dst_rtype              (_dispatcher_io_dis_uops_2_2_bits_dst_rtype),
    .io_dis_uops_2_bits_fp_val                 (_dispatcher_io_dis_uops_2_2_bits_fp_val),
    .io_dis_uops_3_valid                       (_dispatcher_io_dis_uops_2_3_valid),
    .io_dis_uops_3_bits_uopc                   (_dispatcher_io_dis_uops_2_3_bits_uopc),
    .io_dis_uops_3_bits_fu_code                (_dispatcher_io_dis_uops_2_3_bits_fu_code),
    .io_dis_uops_3_bits_br_mask                (_dispatcher_io_dis_uops_2_3_bits_br_mask),
    .io_dis_uops_3_bits_imm_packed             (_dispatcher_io_dis_uops_2_3_bits_imm_packed),
    .io_dis_uops_3_bits_rob_idx                (_dispatcher_io_dis_uops_2_3_bits_rob_idx),
    .io_dis_uops_3_bits_stq_idx                (_dispatcher_io_dis_uops_2_3_bits_stq_idx),
    .io_dis_uops_3_bits_pdst                   (_dispatcher_io_dis_uops_2_3_bits_pdst),
    .io_dis_uops_3_bits_prs1                   (_dispatcher_io_dis_uops_2_3_bits_prs1),
    .io_dis_uops_3_bits_prs2                   (_dispatcher_io_dis_uops_2_3_bits_prs2),
    .io_dis_uops_3_bits_prs3                   (_dispatcher_io_dis_uops_2_3_bits_prs3),
    .io_dis_uops_3_bits_prs1_busy              (_dispatcher_io_dis_uops_2_3_bits_prs1_busy),
    .io_dis_uops_3_bits_prs2_busy              (_dispatcher_io_dis_uops_2_3_bits_prs2_busy),
    .io_dis_uops_3_bits_prs3_busy              (_dispatcher_io_dis_uops_2_3_bits_prs3_busy),
    .io_dis_uops_3_bits_exception              (_dispatcher_io_dis_uops_2_3_bits_exception),
    .io_dis_uops_3_bits_mem_cmd                (_dispatcher_io_dis_uops_2_3_bits_mem_cmd),
    .io_dis_uops_3_bits_is_fence               (_dispatcher_io_dis_uops_2_3_bits_is_fence),
    .io_dis_uops_3_bits_is_fencei              (_dispatcher_io_dis_uops_2_3_bits_is_fencei),
    .io_dis_uops_3_bits_is_amo                 (_dispatcher_io_dis_uops_2_3_bits_is_amo),
    .io_dis_uops_3_bits_uses_ldq               (_dispatcher_io_dis_uops_2_3_bits_uses_ldq),
    .io_dis_uops_3_bits_uses_stq               (_dispatcher_io_dis_uops_2_3_bits_uses_stq),
    .io_dis_uops_3_bits_dst_rtype              (_dispatcher_io_dis_uops_2_3_bits_dst_rtype),
    .io_dis_uops_3_bits_fp_val                 (_dispatcher_io_dis_uops_2_3_bits_fp_val),
    .io_ll_wports_0_valid                      (_memExeUnit_io_ll_fresp_valid),
    .io_ll_wports_0_bits_uop_uopc              (_memExeUnit_io_ll_fresp_bits_uop_uopc),
    .io_ll_wports_0_bits_uop_br_mask           (_memExeUnit_io_ll_fresp_bits_uop_br_mask),
    .io_ll_wports_0_bits_uop_rob_idx           (_memExeUnit_io_ll_fresp_bits_uop_rob_idx),
    .io_ll_wports_0_bits_uop_stq_idx           (_memExeUnit_io_ll_fresp_bits_uop_stq_idx),
    .io_ll_wports_0_bits_uop_pdst              (_memExeUnit_io_ll_fresp_bits_uop_pdst),
    .io_ll_wports_0_bits_uop_mem_size          (_memExeUnit_io_ll_fresp_bits_uop_mem_size),
    .io_ll_wports_0_bits_uop_is_amo            (_memExeUnit_io_ll_fresp_bits_uop_is_amo),
    .io_ll_wports_0_bits_uop_uses_stq          (_memExeUnit_io_ll_fresp_bits_uop_uses_stq),
    .io_ll_wports_0_bits_uop_dst_rtype         (_memExeUnit_io_ll_fresp_bits_uop_dst_rtype),
    .io_ll_wports_0_bits_uop_fp_val            (_memExeUnit_io_ll_fresp_bits_uop_fp_val),
    .io_ll_wports_0_bits_data                  (_memExeUnit_io_ll_fresp_bits_data),
    .io_ll_wports_1_valid                      (_memExeUnit_1_io_ll_fresp_valid),
    .io_ll_wports_1_bits_uop_rob_idx           (_memExeUnit_1_io_ll_fresp_bits_uop_rob_idx),
    .io_ll_wports_1_bits_uop_pdst              (_memExeUnit_1_io_ll_fresp_bits_uop_pdst),
    .io_ll_wports_1_bits_uop_mem_size          (_memExeUnit_1_io_ll_fresp_bits_uop_mem_size),
    .io_ll_wports_1_bits_uop_dst_rtype         (_memExeUnit_1_io_ll_fresp_bits_uop_dst_rtype),
    .io_ll_wports_1_bits_uop_fp_val            (_memExeUnit_1_io_ll_fresp_bits_uop_fp_val),
    .io_ll_wports_1_bits_data                  (_memExeUnit_1_io_ll_fresp_bits_data),
    .io_from_int_valid                         (_alu_exe_unit_io_ll_fresp_valid),
    .io_from_int_bits_uop_uopc                 (_alu_exe_unit_io_ll_fresp_bits_uop_uopc),
    .io_from_int_bits_uop_br_mask              (_alu_exe_unit_io_ll_fresp_bits_uop_br_mask),
    .io_from_int_bits_uop_rob_idx              (_alu_exe_unit_io_ll_fresp_bits_uop_rob_idx),
    .io_from_int_bits_uop_stq_idx              (_alu_exe_unit_io_ll_fresp_bits_uop_stq_idx),
    .io_from_int_bits_uop_pdst                 (_alu_exe_unit_io_ll_fresp_bits_uop_pdst),
    .io_from_int_bits_uop_is_amo               (_alu_exe_unit_io_ll_fresp_bits_uop_is_amo),
    .io_from_int_bits_uop_uses_stq             (_alu_exe_unit_io_ll_fresp_bits_uop_uses_stq),
    .io_from_int_bits_uop_dst_rtype            (_alu_exe_unit_io_ll_fresp_bits_uop_dst_rtype),
    .io_from_int_bits_uop_fp_val               (_alu_exe_unit_io_ll_fresp_bits_uop_fp_val),
    .io_from_int_bits_data                     (_alu_exe_unit_io_ll_fresp_bits_data),
    .io_from_int_bits_predicated               (_alu_exe_unit_io_ll_fresp_bits_predicated),
    .io_from_int_bits_fflags_valid             (_alu_exe_unit_io_ll_fresp_bits_fflags_valid),
    .io_from_int_bits_fflags_bits_uop_rob_idx  (_alu_exe_unit_io_ll_fresp_bits_fflags_bits_uop_rob_idx),
    .io_from_int_bits_fflags_bits_flags        (_alu_exe_unit_io_ll_fresp_bits_fflags_bits_flags),
    .io_to_sdq_ready                           (io_lsu_fp_stdata_ready),
    .io_to_int_ready                           (_ll_wbarb_io_in_1_ready),
    .io_dis_uops_0_ready                       (_FpPipeline_io_dis_uops_0_ready),
    .io_dis_uops_1_ready                       (_FpPipeline_io_dis_uops_1_ready),
    .io_dis_uops_2_ready                       (_FpPipeline_io_dis_uops_2_ready),
    .io_dis_uops_3_ready                       (_FpPipeline_io_dis_uops_3_ready),
    .io_from_int_ready                         (_FpPipeline_io_from_int_ready),
    .io_to_sdq_valid                           (io_lsu_fp_stdata_valid),
    .io_to_sdq_bits_uop_br_mask                (io_lsu_fp_stdata_bits_uop_br_mask),
    .io_to_sdq_bits_uop_rob_idx                (io_lsu_fp_stdata_bits_uop_rob_idx),
    .io_to_sdq_bits_uop_stq_idx                (io_lsu_fp_stdata_bits_uop_stq_idx),
    .io_to_sdq_bits_data                       (io_lsu_fp_stdata_bits_data),
    .io_to_int_valid                           (_FpPipeline_io_to_int_valid),
    .io_to_int_bits_uop_rob_idx                (_FpPipeline_io_to_int_bits_uop_rob_idx),
    .io_to_int_bits_uop_pdst                   (_FpPipeline_io_to_int_bits_uop_pdst),
    .io_to_int_bits_uop_is_amo                 (_FpPipeline_io_to_int_bits_uop_is_amo),
    .io_to_int_bits_uop_uses_stq               (_FpPipeline_io_to_int_bits_uop_uses_stq),
    .io_to_int_bits_uop_dst_rtype              (_FpPipeline_io_to_int_bits_uop_dst_rtype),
    .io_to_int_bits_data                       (_FpPipeline_io_to_int_bits_data),
    .io_to_int_bits_predicated                 (_FpPipeline_io_to_int_bits_predicated),
    .io_wakeups_0_valid                        (_FpPipeline_io_wakeups_0_valid),
    .io_wakeups_0_bits_uop_rob_idx             (_FpPipeline_io_wakeups_0_bits_uop_rob_idx),
    .io_wakeups_0_bits_uop_pdst                (_FpPipeline_io_wakeups_0_bits_uop_pdst),
    .io_wakeups_0_bits_uop_dst_rtype           (_FpPipeline_io_wakeups_0_bits_uop_dst_rtype),
    .io_wakeups_0_bits_uop_fp_val              (_FpPipeline_io_wakeups_0_bits_uop_fp_val),
    .io_wakeups_0_bits_predicated              (_FpPipeline_io_wakeups_0_bits_predicated),
    .io_wakeups_0_bits_fflags_valid            (_FpPipeline_io_wakeups_0_bits_fflags_valid),
    .io_wakeups_0_bits_fflags_bits_uop_rob_idx (_FpPipeline_io_wakeups_0_bits_fflags_bits_uop_rob_idx),
    .io_wakeups_0_bits_fflags_bits_flags       (_FpPipeline_io_wakeups_0_bits_fflags_bits_flags),
    .io_wakeups_1_valid                        (_FpPipeline_io_wakeups_1_valid),
    .io_wakeups_1_bits_uop_rob_idx             (_FpPipeline_io_wakeups_1_bits_uop_rob_idx),
    .io_wakeups_1_bits_uop_pdst                (_FpPipeline_io_wakeups_1_bits_uop_pdst),
    .io_wakeups_1_bits_uop_dst_rtype           (_FpPipeline_io_wakeups_1_bits_uop_dst_rtype),
    .io_wakeups_1_bits_uop_fp_val              (_FpPipeline_io_wakeups_1_bits_uop_fp_val),
    .io_wakeups_2_valid                        (_FpPipeline_io_wakeups_2_valid),
    .io_wakeups_2_bits_uop_rob_idx             (_FpPipeline_io_wakeups_2_bits_uop_rob_idx),
    .io_wakeups_2_bits_uop_pdst                (_FpPipeline_io_wakeups_2_bits_uop_pdst),
    .io_wakeups_2_bits_uop_dst_rtype           (_FpPipeline_io_wakeups_2_bits_uop_dst_rtype),
    .io_wakeups_2_bits_uop_fp_val              (_FpPipeline_io_wakeups_2_bits_uop_fp_val),
    .io_wakeups_2_bits_fflags_valid            (_FpPipeline_io_wakeups_2_bits_fflags_valid),
    .io_wakeups_2_bits_fflags_bits_uop_rob_idx (_FpPipeline_io_wakeups_2_bits_fflags_bits_uop_rob_idx),
    .io_wakeups_2_bits_fflags_bits_flags       (_FpPipeline_io_wakeups_2_bits_fflags_bits_flags),
    .io_wakeups_3_valid                        (_FpPipeline_io_wakeups_3_valid),
    .io_wakeups_3_bits_uop_rob_idx             (_FpPipeline_io_wakeups_3_bits_uop_rob_idx),
    .io_wakeups_3_bits_uop_pdst                (_FpPipeline_io_wakeups_3_bits_uop_pdst),
    .io_wakeups_3_bits_uop_dst_rtype           (_FpPipeline_io_wakeups_3_bits_uop_dst_rtype),
    .io_wakeups_3_bits_uop_fp_val              (_FpPipeline_io_wakeups_3_bits_uop_fp_val),
    .io_wakeups_3_bits_fflags_valid            (_FpPipeline_io_wakeups_3_bits_fflags_valid),
    .io_wakeups_3_bits_fflags_bits_uop_rob_idx (_FpPipeline_io_wakeups_3_bits_fflags_bits_uop_rob_idx),
    .io_wakeups_3_bits_fflags_bits_flags       (_FpPipeline_io_wakeups_3_bits_fflags_bits_flags)
  );
  DecodeUnit decode_units_0 (
    .io_enq_uop_inst              (io_ifu_fetchpacket_bits_uops_0_bits_inst),
    .io_enq_uop_is_rvc            (io_ifu_fetchpacket_bits_uops_0_bits_is_rvc),
    .io_enq_uop_ctrl_is_load      (io_ifu_fetchpacket_bits_uops_0_bits_ctrl_is_load),
    .io_enq_uop_ctrl_is_sta       (io_ifu_fetchpacket_bits_uops_0_bits_ctrl_is_sta),
    .io_enq_uop_is_sfb            (io_ifu_fetchpacket_bits_uops_0_bits_is_sfb),
    .io_enq_uop_ftq_idx           (io_ifu_fetchpacket_bits_uops_0_bits_ftq_idx),
    .io_enq_uop_edge_inst         (io_ifu_fetchpacket_bits_uops_0_bits_edge_inst),
    .io_enq_uop_pc_lob            (io_ifu_fetchpacket_bits_uops_0_bits_pc_lob),
    .io_enq_uop_taken             (io_ifu_fetchpacket_bits_uops_0_bits_taken),
    .io_enq_uop_xcpt_pf_if        (io_ifu_fetchpacket_bits_uops_0_bits_xcpt_pf_if),
    .io_enq_uop_xcpt_ae_if        (io_ifu_fetchpacket_bits_uops_0_bits_xcpt_ae_if),
    .io_enq_uop_bp_debug_if       (io_ifu_fetchpacket_bits_uops_0_bits_bp_debug_if),
    .io_enq_uop_bp_xcpt_if        (io_ifu_fetchpacket_bits_uops_0_bits_bp_xcpt_if),
    .io_csr_decode_fp_illegal     (_csr_io_decode_0_fp_illegal),
    .io_csr_decode_read_illegal   (_csr_io_decode_0_read_illegal),
    .io_csr_decode_write_illegal  (_csr_io_decode_0_write_illegal),
    .io_csr_decode_write_flush    (_csr_io_decode_0_write_flush),
    .io_csr_decode_system_illegal (_csr_io_decode_0_system_illegal),
    .io_interrupt                 (_csr_io_interrupt),
    .io_interrupt_cause           (_csr_io_interrupt_cause),
    .io_deq_uop_uopc              (_decode_units_0_io_deq_uop_uopc),
    .io_deq_uop_is_rvc            (_decode_units_0_io_deq_uop_is_rvc),
    .io_deq_uop_iq_type           (_decode_units_0_io_deq_uop_iq_type),
    .io_deq_uop_fu_code           (_decode_units_0_io_deq_uop_fu_code),
    .io_deq_uop_ctrl_is_load      (_decode_units_0_io_deq_uop_ctrl_is_load),
    .io_deq_uop_ctrl_is_sta       (_decode_units_0_io_deq_uop_ctrl_is_sta),
    .io_deq_uop_is_br             (_decode_units_0_io_deq_uop_is_br),
    .io_deq_uop_is_jalr           (_decode_units_0_io_deq_uop_is_jalr),
    .io_deq_uop_is_jal            (_decode_units_0_io_deq_uop_is_jal),
    .io_deq_uop_is_sfb            (_decode_units_0_io_deq_uop_is_sfb),
    .io_deq_uop_ftq_idx           (_decode_units_0_io_deq_uop_ftq_idx),
    .io_deq_uop_edge_inst         (_decode_units_0_io_deq_uop_edge_inst),
    .io_deq_uop_pc_lob            (_decode_units_0_io_deq_uop_pc_lob),
    .io_deq_uop_taken             (_decode_units_0_io_deq_uop_taken),
    .io_deq_uop_imm_packed        (_decode_units_0_io_deq_uop_imm_packed),
    .io_deq_uop_exception         (_decode_units_0_io_deq_uop_exception),
    .io_deq_uop_exc_cause         (_decode_units_0_io_deq_uop_exc_cause),
    .io_deq_uop_bypassable        (_decode_units_0_io_deq_uop_bypassable),
    .io_deq_uop_mem_cmd           (_decode_units_0_io_deq_uop_mem_cmd),
    .io_deq_uop_mem_size          (_decode_units_0_io_deq_uop_mem_size),
    .io_deq_uop_mem_signed        (_decode_units_0_io_deq_uop_mem_signed),
    .io_deq_uop_is_fence          (_decode_units_0_io_deq_uop_is_fence),
    .io_deq_uop_is_fencei         (_decode_units_0_io_deq_uop_is_fencei),
    .io_deq_uop_is_amo            (_decode_units_0_io_deq_uop_is_amo),
    .io_deq_uop_uses_ldq          (_decode_units_0_io_deq_uop_uses_ldq),
    .io_deq_uop_uses_stq          (_decode_units_0_io_deq_uop_uses_stq),
    .io_deq_uop_is_sys_pc2epc     (_decode_units_0_io_deq_uop_is_sys_pc2epc),
    .io_deq_uop_is_unique         (_decode_units_0_io_deq_uop_is_unique),
    .io_deq_uop_flush_on_commit   (_decode_units_0_io_deq_uop_flush_on_commit),
    .io_deq_uop_ldst              (_decode_units_0_io_deq_uop_ldst),
    .io_deq_uop_lrs1              (_decode_units_0_io_deq_uop_lrs1),
    .io_deq_uop_lrs2              (_decode_units_0_io_deq_uop_lrs2),
    .io_deq_uop_lrs3              (_decode_units_0_io_deq_uop_lrs3),
    .io_deq_uop_ldst_val          (_decode_units_0_io_deq_uop_ldst_val),
    .io_deq_uop_dst_rtype         (_decode_units_0_io_deq_uop_dst_rtype),
    .io_deq_uop_lrs1_rtype        (_decode_units_0_io_deq_uop_lrs1_rtype),
    .io_deq_uop_lrs2_rtype        (_decode_units_0_io_deq_uop_lrs2_rtype),
    .io_deq_uop_frs3_en           (_decode_units_0_io_deq_uop_frs3_en),
    .io_deq_uop_fp_val            (_decode_units_0_io_deq_uop_fp_val),
    .io_csr_decode_inst           (_decode_units_0_io_csr_decode_inst)
  );
  DecodeUnit decode_units_1 (
    .io_enq_uop_inst              (io_ifu_fetchpacket_bits_uops_1_bits_inst),
    .io_enq_uop_is_rvc            (io_ifu_fetchpacket_bits_uops_1_bits_is_rvc),
    .io_enq_uop_ctrl_is_load      (io_ifu_fetchpacket_bits_uops_1_bits_ctrl_is_load),
    .io_enq_uop_ctrl_is_sta       (io_ifu_fetchpacket_bits_uops_1_bits_ctrl_is_sta),
    .io_enq_uop_is_sfb            (io_ifu_fetchpacket_bits_uops_1_bits_is_sfb),
    .io_enq_uop_ftq_idx           (io_ifu_fetchpacket_bits_uops_1_bits_ftq_idx),
    .io_enq_uop_edge_inst         (io_ifu_fetchpacket_bits_uops_1_bits_edge_inst),
    .io_enq_uop_pc_lob            (io_ifu_fetchpacket_bits_uops_1_bits_pc_lob),
    .io_enq_uop_taken             (io_ifu_fetchpacket_bits_uops_1_bits_taken),
    .io_enq_uop_xcpt_pf_if        (io_ifu_fetchpacket_bits_uops_1_bits_xcpt_pf_if),
    .io_enq_uop_xcpt_ae_if        (io_ifu_fetchpacket_bits_uops_1_bits_xcpt_ae_if),
    .io_enq_uop_bp_debug_if       (io_ifu_fetchpacket_bits_uops_1_bits_bp_debug_if),
    .io_enq_uop_bp_xcpt_if        (io_ifu_fetchpacket_bits_uops_1_bits_bp_xcpt_if),
    .io_csr_decode_fp_illegal     (_csr_io_decode_1_fp_illegal),
    .io_csr_decode_read_illegal   (_csr_io_decode_1_read_illegal),
    .io_csr_decode_write_illegal  (_csr_io_decode_1_write_illegal),
    .io_csr_decode_write_flush    (_csr_io_decode_1_write_flush),
    .io_csr_decode_system_illegal (_csr_io_decode_1_system_illegal),
    .io_interrupt                 (_csr_io_interrupt),
    .io_interrupt_cause           (_csr_io_interrupt_cause),
    .io_deq_uop_uopc              (_decode_units_1_io_deq_uop_uopc),
    .io_deq_uop_is_rvc            (_decode_units_1_io_deq_uop_is_rvc),
    .io_deq_uop_iq_type           (_decode_units_1_io_deq_uop_iq_type),
    .io_deq_uop_fu_code           (_decode_units_1_io_deq_uop_fu_code),
    .io_deq_uop_ctrl_is_load      (_decode_units_1_io_deq_uop_ctrl_is_load),
    .io_deq_uop_ctrl_is_sta       (_decode_units_1_io_deq_uop_ctrl_is_sta),
    .io_deq_uop_is_br             (_decode_units_1_io_deq_uop_is_br),
    .io_deq_uop_is_jalr           (_decode_units_1_io_deq_uop_is_jalr),
    .io_deq_uop_is_jal            (_decode_units_1_io_deq_uop_is_jal),
    .io_deq_uop_is_sfb            (_decode_units_1_io_deq_uop_is_sfb),
    .io_deq_uop_ftq_idx           (_decode_units_1_io_deq_uop_ftq_idx),
    .io_deq_uop_edge_inst         (_decode_units_1_io_deq_uop_edge_inst),
    .io_deq_uop_pc_lob            (_decode_units_1_io_deq_uop_pc_lob),
    .io_deq_uop_taken             (_decode_units_1_io_deq_uop_taken),
    .io_deq_uop_imm_packed        (_decode_units_1_io_deq_uop_imm_packed),
    .io_deq_uop_exception         (_decode_units_1_io_deq_uop_exception),
    .io_deq_uop_exc_cause         (_decode_units_1_io_deq_uop_exc_cause),
    .io_deq_uop_bypassable        (_decode_units_1_io_deq_uop_bypassable),
    .io_deq_uop_mem_cmd           (_decode_units_1_io_deq_uop_mem_cmd),
    .io_deq_uop_mem_size          (_decode_units_1_io_deq_uop_mem_size),
    .io_deq_uop_mem_signed        (_decode_units_1_io_deq_uop_mem_signed),
    .io_deq_uop_is_fence          (_decode_units_1_io_deq_uop_is_fence),
    .io_deq_uop_is_fencei         (_decode_units_1_io_deq_uop_is_fencei),
    .io_deq_uop_is_amo            (_decode_units_1_io_deq_uop_is_amo),
    .io_deq_uop_uses_ldq          (_decode_units_1_io_deq_uop_uses_ldq),
    .io_deq_uop_uses_stq          (_decode_units_1_io_deq_uop_uses_stq),
    .io_deq_uop_is_sys_pc2epc     (_decode_units_1_io_deq_uop_is_sys_pc2epc),
    .io_deq_uop_is_unique         (_decode_units_1_io_deq_uop_is_unique),
    .io_deq_uop_flush_on_commit   (_decode_units_1_io_deq_uop_flush_on_commit),
    .io_deq_uop_ldst              (_decode_units_1_io_deq_uop_ldst),
    .io_deq_uop_lrs1              (_decode_units_1_io_deq_uop_lrs1),
    .io_deq_uop_lrs2              (_decode_units_1_io_deq_uop_lrs2),
    .io_deq_uop_lrs3              (_decode_units_1_io_deq_uop_lrs3),
    .io_deq_uop_ldst_val          (_decode_units_1_io_deq_uop_ldst_val),
    .io_deq_uop_dst_rtype         (_decode_units_1_io_deq_uop_dst_rtype),
    .io_deq_uop_lrs1_rtype        (_decode_units_1_io_deq_uop_lrs1_rtype),
    .io_deq_uop_lrs2_rtype        (_decode_units_1_io_deq_uop_lrs2_rtype),
    .io_deq_uop_frs3_en           (_decode_units_1_io_deq_uop_frs3_en),
    .io_deq_uop_fp_val            (_decode_units_1_io_deq_uop_fp_val),
    .io_csr_decode_inst           (_decode_units_1_io_csr_decode_inst)
  );
  DecodeUnit decode_units_2 (
    .io_enq_uop_inst              (io_ifu_fetchpacket_bits_uops_2_bits_inst),
    .io_enq_uop_is_rvc            (io_ifu_fetchpacket_bits_uops_2_bits_is_rvc),
    .io_enq_uop_ctrl_is_load      (io_ifu_fetchpacket_bits_uops_2_bits_ctrl_is_load),
    .io_enq_uop_ctrl_is_sta       (io_ifu_fetchpacket_bits_uops_2_bits_ctrl_is_sta),
    .io_enq_uop_is_sfb            (io_ifu_fetchpacket_bits_uops_2_bits_is_sfb),
    .io_enq_uop_ftq_idx           (io_ifu_fetchpacket_bits_uops_2_bits_ftq_idx),
    .io_enq_uop_edge_inst         (io_ifu_fetchpacket_bits_uops_2_bits_edge_inst),
    .io_enq_uop_pc_lob            (io_ifu_fetchpacket_bits_uops_2_bits_pc_lob),
    .io_enq_uop_taken             (io_ifu_fetchpacket_bits_uops_2_bits_taken),
    .io_enq_uop_xcpt_pf_if        (io_ifu_fetchpacket_bits_uops_2_bits_xcpt_pf_if),
    .io_enq_uop_xcpt_ae_if        (io_ifu_fetchpacket_bits_uops_2_bits_xcpt_ae_if),
    .io_enq_uop_bp_debug_if       (io_ifu_fetchpacket_bits_uops_2_bits_bp_debug_if),
    .io_enq_uop_bp_xcpt_if        (io_ifu_fetchpacket_bits_uops_2_bits_bp_xcpt_if),
    .io_csr_decode_fp_illegal     (_csr_io_decode_2_fp_illegal),
    .io_csr_decode_read_illegal   (_csr_io_decode_2_read_illegal),
    .io_csr_decode_write_illegal  (_csr_io_decode_2_write_illegal),
    .io_csr_decode_write_flush    (_csr_io_decode_2_write_flush),
    .io_csr_decode_system_illegal (_csr_io_decode_2_system_illegal),
    .io_interrupt                 (_csr_io_interrupt),
    .io_interrupt_cause           (_csr_io_interrupt_cause),
    .io_deq_uop_uopc              (_decode_units_2_io_deq_uop_uopc),
    .io_deq_uop_is_rvc            (_decode_units_2_io_deq_uop_is_rvc),
    .io_deq_uop_iq_type           (_decode_units_2_io_deq_uop_iq_type),
    .io_deq_uop_fu_code           (_decode_units_2_io_deq_uop_fu_code),
    .io_deq_uop_ctrl_is_load      (_decode_units_2_io_deq_uop_ctrl_is_load),
    .io_deq_uop_ctrl_is_sta       (_decode_units_2_io_deq_uop_ctrl_is_sta),
    .io_deq_uop_is_br             (_decode_units_2_io_deq_uop_is_br),
    .io_deq_uop_is_jalr           (_decode_units_2_io_deq_uop_is_jalr),
    .io_deq_uop_is_jal            (_decode_units_2_io_deq_uop_is_jal),
    .io_deq_uop_is_sfb            (_decode_units_2_io_deq_uop_is_sfb),
    .io_deq_uop_ftq_idx           (_decode_units_2_io_deq_uop_ftq_idx),
    .io_deq_uop_edge_inst         (_decode_units_2_io_deq_uop_edge_inst),
    .io_deq_uop_pc_lob            (_decode_units_2_io_deq_uop_pc_lob),
    .io_deq_uop_taken             (_decode_units_2_io_deq_uop_taken),
    .io_deq_uop_imm_packed        (_decode_units_2_io_deq_uop_imm_packed),
    .io_deq_uop_exception         (_decode_units_2_io_deq_uop_exception),
    .io_deq_uop_exc_cause         (_decode_units_2_io_deq_uop_exc_cause),
    .io_deq_uop_bypassable        (_decode_units_2_io_deq_uop_bypassable),
    .io_deq_uop_mem_cmd           (_decode_units_2_io_deq_uop_mem_cmd),
    .io_deq_uop_mem_size          (_decode_units_2_io_deq_uop_mem_size),
    .io_deq_uop_mem_signed        (_decode_units_2_io_deq_uop_mem_signed),
    .io_deq_uop_is_fence          (_decode_units_2_io_deq_uop_is_fence),
    .io_deq_uop_is_fencei         (_decode_units_2_io_deq_uop_is_fencei),
    .io_deq_uop_is_amo            (_decode_units_2_io_deq_uop_is_amo),
    .io_deq_uop_uses_ldq          (_decode_units_2_io_deq_uop_uses_ldq),
    .io_deq_uop_uses_stq          (_decode_units_2_io_deq_uop_uses_stq),
    .io_deq_uop_is_sys_pc2epc     (_decode_units_2_io_deq_uop_is_sys_pc2epc),
    .io_deq_uop_is_unique         (_decode_units_2_io_deq_uop_is_unique),
    .io_deq_uop_flush_on_commit   (_decode_units_2_io_deq_uop_flush_on_commit),
    .io_deq_uop_ldst              (_decode_units_2_io_deq_uop_ldst),
    .io_deq_uop_lrs1              (_decode_units_2_io_deq_uop_lrs1),
    .io_deq_uop_lrs2              (_decode_units_2_io_deq_uop_lrs2),
    .io_deq_uop_lrs3              (_decode_units_2_io_deq_uop_lrs3),
    .io_deq_uop_ldst_val          (_decode_units_2_io_deq_uop_ldst_val),
    .io_deq_uop_dst_rtype         (_decode_units_2_io_deq_uop_dst_rtype),
    .io_deq_uop_lrs1_rtype        (_decode_units_2_io_deq_uop_lrs1_rtype),
    .io_deq_uop_lrs2_rtype        (_decode_units_2_io_deq_uop_lrs2_rtype),
    .io_deq_uop_frs3_en           (_decode_units_2_io_deq_uop_frs3_en),
    .io_deq_uop_fp_val            (_decode_units_2_io_deq_uop_fp_val),
    .io_csr_decode_inst           (_decode_units_2_io_csr_decode_inst)
  );
  DecodeUnit decode_units_3 (
    .io_enq_uop_inst              (io_ifu_fetchpacket_bits_uops_3_bits_inst),
    .io_enq_uop_is_rvc            (io_ifu_fetchpacket_bits_uops_3_bits_is_rvc),
    .io_enq_uop_ctrl_is_load      (io_ifu_fetchpacket_bits_uops_3_bits_ctrl_is_load),
    .io_enq_uop_ctrl_is_sta       (io_ifu_fetchpacket_bits_uops_3_bits_ctrl_is_sta),
    .io_enq_uop_is_sfb            (io_ifu_fetchpacket_bits_uops_3_bits_is_sfb),
    .io_enq_uop_ftq_idx           (io_ifu_fetchpacket_bits_uops_3_bits_ftq_idx),
    .io_enq_uop_edge_inst         (io_ifu_fetchpacket_bits_uops_3_bits_edge_inst),
    .io_enq_uop_pc_lob            (io_ifu_fetchpacket_bits_uops_3_bits_pc_lob),
    .io_enq_uop_taken             (io_ifu_fetchpacket_bits_uops_3_bits_taken),
    .io_enq_uop_xcpt_pf_if        (io_ifu_fetchpacket_bits_uops_3_bits_xcpt_pf_if),
    .io_enq_uop_xcpt_ae_if        (io_ifu_fetchpacket_bits_uops_3_bits_xcpt_ae_if),
    .io_enq_uop_bp_debug_if       (io_ifu_fetchpacket_bits_uops_3_bits_bp_debug_if),
    .io_enq_uop_bp_xcpt_if        (io_ifu_fetchpacket_bits_uops_3_bits_bp_xcpt_if),
    .io_csr_decode_fp_illegal     (_csr_io_decode_3_fp_illegal),
    .io_csr_decode_read_illegal   (_csr_io_decode_3_read_illegal),
    .io_csr_decode_write_illegal  (_csr_io_decode_3_write_illegal),
    .io_csr_decode_write_flush    (_csr_io_decode_3_write_flush),
    .io_csr_decode_system_illegal (_csr_io_decode_3_system_illegal),
    .io_interrupt                 (_csr_io_interrupt),
    .io_interrupt_cause           (_csr_io_interrupt_cause),
    .io_deq_uop_uopc              (_decode_units_3_io_deq_uop_uopc),
    .io_deq_uop_is_rvc            (_decode_units_3_io_deq_uop_is_rvc),
    .io_deq_uop_iq_type           (_decode_units_3_io_deq_uop_iq_type),
    .io_deq_uop_fu_code           (_decode_units_3_io_deq_uop_fu_code),
    .io_deq_uop_ctrl_is_load      (_decode_units_3_io_deq_uop_ctrl_is_load),
    .io_deq_uop_ctrl_is_sta       (_decode_units_3_io_deq_uop_ctrl_is_sta),
    .io_deq_uop_is_br             (_decode_units_3_io_deq_uop_is_br),
    .io_deq_uop_is_jalr           (_decode_units_3_io_deq_uop_is_jalr),
    .io_deq_uop_is_jal            (_decode_units_3_io_deq_uop_is_jal),
    .io_deq_uop_is_sfb            (_decode_units_3_io_deq_uop_is_sfb),
    .io_deq_uop_ftq_idx           (_decode_units_3_io_deq_uop_ftq_idx),
    .io_deq_uop_edge_inst         (_decode_units_3_io_deq_uop_edge_inst),
    .io_deq_uop_pc_lob            (_decode_units_3_io_deq_uop_pc_lob),
    .io_deq_uop_taken             (_decode_units_3_io_deq_uop_taken),
    .io_deq_uop_imm_packed        (_decode_units_3_io_deq_uop_imm_packed),
    .io_deq_uop_exception         (_decode_units_3_io_deq_uop_exception),
    .io_deq_uop_exc_cause         (_decode_units_3_io_deq_uop_exc_cause),
    .io_deq_uop_bypassable        (_decode_units_3_io_deq_uop_bypassable),
    .io_deq_uop_mem_cmd           (_decode_units_3_io_deq_uop_mem_cmd),
    .io_deq_uop_mem_size          (_decode_units_3_io_deq_uop_mem_size),
    .io_deq_uop_mem_signed        (_decode_units_3_io_deq_uop_mem_signed),
    .io_deq_uop_is_fence          (_decode_units_3_io_deq_uop_is_fence),
    .io_deq_uop_is_fencei         (_decode_units_3_io_deq_uop_is_fencei),
    .io_deq_uop_is_amo            (_decode_units_3_io_deq_uop_is_amo),
    .io_deq_uop_uses_ldq          (_decode_units_3_io_deq_uop_uses_ldq),
    .io_deq_uop_uses_stq          (_decode_units_3_io_deq_uop_uses_stq),
    .io_deq_uop_is_sys_pc2epc     (_decode_units_3_io_deq_uop_is_sys_pc2epc),
    .io_deq_uop_is_unique         (_decode_units_3_io_deq_uop_is_unique),
    .io_deq_uop_flush_on_commit   (_decode_units_3_io_deq_uop_flush_on_commit),
    .io_deq_uop_ldst              (_decode_units_3_io_deq_uop_ldst),
    .io_deq_uop_lrs1              (_decode_units_3_io_deq_uop_lrs1),
    .io_deq_uop_lrs2              (_decode_units_3_io_deq_uop_lrs2),
    .io_deq_uop_lrs3              (_decode_units_3_io_deq_uop_lrs3),
    .io_deq_uop_ldst_val          (_decode_units_3_io_deq_uop_ldst_val),
    .io_deq_uop_dst_rtype         (_decode_units_3_io_deq_uop_dst_rtype),
    .io_deq_uop_lrs1_rtype        (_decode_units_3_io_deq_uop_lrs1_rtype),
    .io_deq_uop_lrs2_rtype        (_decode_units_3_io_deq_uop_lrs2_rtype),
    .io_deq_uop_frs3_en           (_decode_units_3_io_deq_uop_frs3_en),
    .io_deq_uop_fp_val            (_decode_units_3_io_deq_uop_fp_val),
    .io_csr_decode_inst           (_decode_units_3_io_csr_decode_inst)
  );
  BranchMaskGenerationLogic dec_brmask_logic (
    .clock                       (clock),
    .reset                       (reset),
    .io_is_branch_0              (~(dec_finished_mask[0]) & (_decode_units_0_io_deq_uop_is_br & ~_decode_units_0_io_deq_uop_is_sfb | _decode_units_0_io_deq_uop_is_jalr)),
    .io_is_branch_1              (~(dec_finished_mask[1]) & (_decode_units_1_io_deq_uop_is_br & ~_decode_units_1_io_deq_uop_is_sfb | _decode_units_1_io_deq_uop_is_jalr)),
    .io_is_branch_2              (~(dec_finished_mask[2]) & (_decode_units_2_io_deq_uop_is_br & ~_decode_units_2_io_deq_uop_is_sfb | _decode_units_2_io_deq_uop_is_jalr)),
    .io_is_branch_3              (~(dec_finished_mask[3]) & (_decode_units_3_io_deq_uop_is_br & ~_decode_units_3_io_deq_uop_is_sfb | _decode_units_3_io_deq_uop_is_jalr)),
    .io_will_fire_0              (dec_fire_0 & (_decode_units_0_io_deq_uop_is_br & ~_decode_units_0_io_deq_uop_is_sfb | _decode_units_0_io_deq_uop_is_jalr)),
    .io_will_fire_1              (dec_fire_1 & (_decode_units_1_io_deq_uop_is_br & ~_decode_units_1_io_deq_uop_is_sfb | _decode_units_1_io_deq_uop_is_jalr)),
    .io_will_fire_2              (dec_fire_2 & (_decode_units_2_io_deq_uop_is_br & ~_decode_units_2_io_deq_uop_is_sfb | _decode_units_2_io_deq_uop_is_jalr)),
    .io_will_fire_3              (dec_ready & (_decode_units_3_io_deq_uop_is_br & ~_decode_units_3_io_deq_uop_is_sfb | _decode_units_3_io_deq_uop_is_jalr)),
    .io_brupdate_b1_resolve_mask (_b1_resolve_mask_T_6),
    .io_brupdate_b2_uop_br_mask  (b2_uop_br_mask),
    .io_brupdate_b2_mispredict   (b2_mispredict),
    .io_flush_pipeline           (dec_brmask_logic_io_flush_pipeline_REG),
    .io_br_tag_0                 (_dec_brmask_logic_io_br_tag_0),
    .io_br_tag_1                 (_dec_brmask_logic_io_br_tag_1),
    .io_br_tag_2                 (_dec_brmask_logic_io_br_tag_2),
    .io_br_tag_3                 (_dec_brmask_logic_io_br_tag_3),
    .io_br_mask_0                (_dec_brmask_logic_io_br_mask_0),
    .io_br_mask_1                (_dec_brmask_logic_io_br_mask_1),
    .io_br_mask_2                (_dec_brmask_logic_io_br_mask_2),
    .io_br_mask_3                (_dec_brmask_logic_io_br_mask_3),
    .io_is_full_0                (_dec_brmask_logic_io_is_full_0),
    .io_is_full_1                (_dec_brmask_logic_io_is_full_1),
    .io_is_full_2                (_dec_brmask_logic_io_is_full_2),
    .io_is_full_3                (_dec_brmask_logic_io_is_full_3)
  );
  RenameStage rename_stage (
    .clock                           (clock),
    .reset                           (reset),
    .io_kill                         (_io_ifu_redirect_flush_output),
    .io_dec_fire_0                   (dec_fire_0),
    .io_dec_fire_1                   (dec_fire_1),
    .io_dec_fire_2                   (dec_fire_2),
    .io_dec_fire_3                   (dec_ready),
    .io_dec_uops_0_uopc              (_decode_units_0_io_deq_uop_uopc),
    .io_dec_uops_0_is_rvc            (_decode_units_0_io_deq_uop_is_rvc),
    .io_dec_uops_0_iq_type           (_decode_units_0_io_deq_uop_iq_type),
    .io_dec_uops_0_fu_code           (_decode_units_0_io_deq_uop_fu_code),
    .io_dec_uops_0_ctrl_is_load      (_decode_units_0_io_deq_uop_ctrl_is_load),
    .io_dec_uops_0_ctrl_is_sta       (_decode_units_0_io_deq_uop_ctrl_is_sta),
    .io_dec_uops_0_is_br             (_decode_units_0_io_deq_uop_is_br),
    .io_dec_uops_0_is_jalr           (_decode_units_0_io_deq_uop_is_jalr),
    .io_dec_uops_0_is_jal            (_decode_units_0_io_deq_uop_is_jal),
    .io_dec_uops_0_is_sfb            (_decode_units_0_io_deq_uop_is_sfb),
    .io_dec_uops_0_br_mask           (_dec_brmask_logic_io_br_mask_0),
    .io_dec_uops_0_br_tag            (_dec_brmask_logic_io_br_tag_0),
    .io_dec_uops_0_ftq_idx           (_decode_units_0_io_deq_uop_ftq_idx),
    .io_dec_uops_0_edge_inst         (_decode_units_0_io_deq_uop_edge_inst),
    .io_dec_uops_0_pc_lob            (_decode_units_0_io_deq_uop_pc_lob),
    .io_dec_uops_0_taken             (_decode_units_0_io_deq_uop_taken),
    .io_dec_uops_0_imm_packed        (_decode_units_0_io_deq_uop_imm_packed),
    .io_dec_uops_0_exception         (_decode_units_0_io_deq_uop_exception),
    .io_dec_uops_0_exc_cause         (_decode_units_0_io_deq_uop_exc_cause),
    .io_dec_uops_0_bypassable        (_decode_units_0_io_deq_uop_bypassable),
    .io_dec_uops_0_mem_cmd           (_decode_units_0_io_deq_uop_mem_cmd),
    .io_dec_uops_0_mem_size          (_decode_units_0_io_deq_uop_mem_size),
    .io_dec_uops_0_mem_signed        (_decode_units_0_io_deq_uop_mem_signed),
    .io_dec_uops_0_is_fence          (_decode_units_0_io_deq_uop_is_fence),
    .io_dec_uops_0_is_fencei         (_decode_units_0_io_deq_uop_is_fencei),
    .io_dec_uops_0_is_amo            (_decode_units_0_io_deq_uop_is_amo),
    .io_dec_uops_0_uses_ldq          (_decode_units_0_io_deq_uop_uses_ldq),
    .io_dec_uops_0_uses_stq          (_decode_units_0_io_deq_uop_uses_stq),
    .io_dec_uops_0_is_sys_pc2epc     (_decode_units_0_io_deq_uop_is_sys_pc2epc),
    .io_dec_uops_0_is_unique         (_decode_units_0_io_deq_uop_is_unique),
    .io_dec_uops_0_flush_on_commit   (_decode_units_0_io_deq_uop_flush_on_commit),
    .io_dec_uops_0_ldst              (_decode_units_0_io_deq_uop_ldst),
    .io_dec_uops_0_lrs1              (_decode_units_0_io_deq_uop_lrs1),
    .io_dec_uops_0_lrs2              (_decode_units_0_io_deq_uop_lrs2),
    .io_dec_uops_0_ldst_val          (_decode_units_0_io_deq_uop_ldst_val),
    .io_dec_uops_0_dst_rtype         (_decode_units_0_io_deq_uop_dst_rtype),
    .io_dec_uops_0_lrs1_rtype        (_decode_units_0_io_deq_uop_lrs1_rtype),
    .io_dec_uops_0_lrs2_rtype        (_decode_units_0_io_deq_uop_lrs2_rtype),
    .io_dec_uops_0_frs3_en           (_decode_units_0_io_deq_uop_frs3_en),
    .io_dec_uops_0_fp_val            (_decode_units_0_io_deq_uop_fp_val),
    .io_dec_uops_1_uopc              (_decode_units_1_io_deq_uop_uopc),
    .io_dec_uops_1_is_rvc            (_decode_units_1_io_deq_uop_is_rvc),
    .io_dec_uops_1_iq_type           (_decode_units_1_io_deq_uop_iq_type),
    .io_dec_uops_1_fu_code           (_decode_units_1_io_deq_uop_fu_code),
    .io_dec_uops_1_ctrl_is_load      (_decode_units_1_io_deq_uop_ctrl_is_load),
    .io_dec_uops_1_ctrl_is_sta       (_decode_units_1_io_deq_uop_ctrl_is_sta),
    .io_dec_uops_1_is_br             (_decode_units_1_io_deq_uop_is_br),
    .io_dec_uops_1_is_jalr           (_decode_units_1_io_deq_uop_is_jalr),
    .io_dec_uops_1_is_jal            (_decode_units_1_io_deq_uop_is_jal),
    .io_dec_uops_1_is_sfb            (_decode_units_1_io_deq_uop_is_sfb),
    .io_dec_uops_1_br_mask           (_dec_brmask_logic_io_br_mask_1),
    .io_dec_uops_1_br_tag            (_dec_brmask_logic_io_br_tag_1),
    .io_dec_uops_1_ftq_idx           (_decode_units_1_io_deq_uop_ftq_idx),
    .io_dec_uops_1_edge_inst         (_decode_units_1_io_deq_uop_edge_inst),
    .io_dec_uops_1_pc_lob            (_decode_units_1_io_deq_uop_pc_lob),
    .io_dec_uops_1_taken             (_decode_units_1_io_deq_uop_taken),
    .io_dec_uops_1_imm_packed        (_decode_units_1_io_deq_uop_imm_packed),
    .io_dec_uops_1_exception         (_decode_units_1_io_deq_uop_exception),
    .io_dec_uops_1_exc_cause         (_decode_units_1_io_deq_uop_exc_cause),
    .io_dec_uops_1_bypassable        (_decode_units_1_io_deq_uop_bypassable),
    .io_dec_uops_1_mem_cmd           (_decode_units_1_io_deq_uop_mem_cmd),
    .io_dec_uops_1_mem_size          (_decode_units_1_io_deq_uop_mem_size),
    .io_dec_uops_1_mem_signed        (_decode_units_1_io_deq_uop_mem_signed),
    .io_dec_uops_1_is_fence          (_decode_units_1_io_deq_uop_is_fence),
    .io_dec_uops_1_is_fencei         (_decode_units_1_io_deq_uop_is_fencei),
    .io_dec_uops_1_is_amo            (_decode_units_1_io_deq_uop_is_amo),
    .io_dec_uops_1_uses_ldq          (_decode_units_1_io_deq_uop_uses_ldq),
    .io_dec_uops_1_uses_stq          (_decode_units_1_io_deq_uop_uses_stq),
    .io_dec_uops_1_is_sys_pc2epc     (_decode_units_1_io_deq_uop_is_sys_pc2epc),
    .io_dec_uops_1_is_unique         (_decode_units_1_io_deq_uop_is_unique),
    .io_dec_uops_1_flush_on_commit   (_decode_units_1_io_deq_uop_flush_on_commit),
    .io_dec_uops_1_ldst              (_decode_units_1_io_deq_uop_ldst),
    .io_dec_uops_1_lrs1              (_decode_units_1_io_deq_uop_lrs1),
    .io_dec_uops_1_lrs2              (_decode_units_1_io_deq_uop_lrs2),
    .io_dec_uops_1_ldst_val          (_decode_units_1_io_deq_uop_ldst_val),
    .io_dec_uops_1_dst_rtype         (_decode_units_1_io_deq_uop_dst_rtype),
    .io_dec_uops_1_lrs1_rtype        (_decode_units_1_io_deq_uop_lrs1_rtype),
    .io_dec_uops_1_lrs2_rtype        (_decode_units_1_io_deq_uop_lrs2_rtype),
    .io_dec_uops_1_frs3_en           (_decode_units_1_io_deq_uop_frs3_en),
    .io_dec_uops_1_fp_val            (_decode_units_1_io_deq_uop_fp_val),
    .io_dec_uops_2_uopc              (_decode_units_2_io_deq_uop_uopc),
    .io_dec_uops_2_is_rvc            (_decode_units_2_io_deq_uop_is_rvc),
    .io_dec_uops_2_iq_type           (_decode_units_2_io_deq_uop_iq_type),
    .io_dec_uops_2_fu_code           (_decode_units_2_io_deq_uop_fu_code),
    .io_dec_uops_2_ctrl_is_load      (_decode_units_2_io_deq_uop_ctrl_is_load),
    .io_dec_uops_2_ctrl_is_sta       (_decode_units_2_io_deq_uop_ctrl_is_sta),
    .io_dec_uops_2_is_br             (_decode_units_2_io_deq_uop_is_br),
    .io_dec_uops_2_is_jalr           (_decode_units_2_io_deq_uop_is_jalr),
    .io_dec_uops_2_is_jal            (_decode_units_2_io_deq_uop_is_jal),
    .io_dec_uops_2_is_sfb            (_decode_units_2_io_deq_uop_is_sfb),
    .io_dec_uops_2_br_mask           (_dec_brmask_logic_io_br_mask_2),
    .io_dec_uops_2_br_tag            (_dec_brmask_logic_io_br_tag_2),
    .io_dec_uops_2_ftq_idx           (_decode_units_2_io_deq_uop_ftq_idx),
    .io_dec_uops_2_edge_inst         (_decode_units_2_io_deq_uop_edge_inst),
    .io_dec_uops_2_pc_lob            (_decode_units_2_io_deq_uop_pc_lob),
    .io_dec_uops_2_taken             (_decode_units_2_io_deq_uop_taken),
    .io_dec_uops_2_imm_packed        (_decode_units_2_io_deq_uop_imm_packed),
    .io_dec_uops_2_exception         (_decode_units_2_io_deq_uop_exception),
    .io_dec_uops_2_exc_cause         (_decode_units_2_io_deq_uop_exc_cause),
    .io_dec_uops_2_bypassable        (_decode_units_2_io_deq_uop_bypassable),
    .io_dec_uops_2_mem_cmd           (_decode_units_2_io_deq_uop_mem_cmd),
    .io_dec_uops_2_mem_size          (_decode_units_2_io_deq_uop_mem_size),
    .io_dec_uops_2_mem_signed        (_decode_units_2_io_deq_uop_mem_signed),
    .io_dec_uops_2_is_fence          (_decode_units_2_io_deq_uop_is_fence),
    .io_dec_uops_2_is_fencei         (_decode_units_2_io_deq_uop_is_fencei),
    .io_dec_uops_2_is_amo            (_decode_units_2_io_deq_uop_is_amo),
    .io_dec_uops_2_uses_ldq          (_decode_units_2_io_deq_uop_uses_ldq),
    .io_dec_uops_2_uses_stq          (_decode_units_2_io_deq_uop_uses_stq),
    .io_dec_uops_2_is_sys_pc2epc     (_decode_units_2_io_deq_uop_is_sys_pc2epc),
    .io_dec_uops_2_is_unique         (_decode_units_2_io_deq_uop_is_unique),
    .io_dec_uops_2_flush_on_commit   (_decode_units_2_io_deq_uop_flush_on_commit),
    .io_dec_uops_2_ldst              (_decode_units_2_io_deq_uop_ldst),
    .io_dec_uops_2_lrs1              (_decode_units_2_io_deq_uop_lrs1),
    .io_dec_uops_2_lrs2              (_decode_units_2_io_deq_uop_lrs2),
    .io_dec_uops_2_ldst_val          (_decode_units_2_io_deq_uop_ldst_val),
    .io_dec_uops_2_dst_rtype         (_decode_units_2_io_deq_uop_dst_rtype),
    .io_dec_uops_2_lrs1_rtype        (_decode_units_2_io_deq_uop_lrs1_rtype),
    .io_dec_uops_2_lrs2_rtype        (_decode_units_2_io_deq_uop_lrs2_rtype),
    .io_dec_uops_2_frs3_en           (_decode_units_2_io_deq_uop_frs3_en),
    .io_dec_uops_2_fp_val            (_decode_units_2_io_deq_uop_fp_val),
    .io_dec_uops_3_uopc              (_decode_units_3_io_deq_uop_uopc),
    .io_dec_uops_3_is_rvc            (_decode_units_3_io_deq_uop_is_rvc),
    .io_dec_uops_3_iq_type           (_decode_units_3_io_deq_uop_iq_type),
    .io_dec_uops_3_fu_code           (_decode_units_3_io_deq_uop_fu_code),
    .io_dec_uops_3_ctrl_is_load      (_decode_units_3_io_deq_uop_ctrl_is_load),
    .io_dec_uops_3_ctrl_is_sta       (_decode_units_3_io_deq_uop_ctrl_is_sta),
    .io_dec_uops_3_is_br             (_decode_units_3_io_deq_uop_is_br),
    .io_dec_uops_3_is_jalr           (_decode_units_3_io_deq_uop_is_jalr),
    .io_dec_uops_3_is_jal            (_decode_units_3_io_deq_uop_is_jal),
    .io_dec_uops_3_is_sfb            (_decode_units_3_io_deq_uop_is_sfb),
    .io_dec_uops_3_br_mask           (_dec_brmask_logic_io_br_mask_3),
    .io_dec_uops_3_br_tag            (_dec_brmask_logic_io_br_tag_3),
    .io_dec_uops_3_ftq_idx           (_decode_units_3_io_deq_uop_ftq_idx),
    .io_dec_uops_3_edge_inst         (_decode_units_3_io_deq_uop_edge_inst),
    .io_dec_uops_3_pc_lob            (_decode_units_3_io_deq_uop_pc_lob),
    .io_dec_uops_3_taken             (_decode_units_3_io_deq_uop_taken),
    .io_dec_uops_3_imm_packed        (_decode_units_3_io_deq_uop_imm_packed),
    .io_dec_uops_3_exception         (_decode_units_3_io_deq_uop_exception),
    .io_dec_uops_3_exc_cause         (_decode_units_3_io_deq_uop_exc_cause),
    .io_dec_uops_3_bypassable        (_decode_units_3_io_deq_uop_bypassable),
    .io_dec_uops_3_mem_cmd           (_decode_units_3_io_deq_uop_mem_cmd),
    .io_dec_uops_3_mem_size          (_decode_units_3_io_deq_uop_mem_size),
    .io_dec_uops_3_mem_signed        (_decode_units_3_io_deq_uop_mem_signed),
    .io_dec_uops_3_is_fence          (_decode_units_3_io_deq_uop_is_fence),
    .io_dec_uops_3_is_fencei         (_decode_units_3_io_deq_uop_is_fencei),
    .io_dec_uops_3_is_amo            (_decode_units_3_io_deq_uop_is_amo),
    .io_dec_uops_3_uses_ldq          (_decode_units_3_io_deq_uop_uses_ldq),
    .io_dec_uops_3_uses_stq          (_decode_units_3_io_deq_uop_uses_stq),
    .io_dec_uops_3_is_sys_pc2epc     (_decode_units_3_io_deq_uop_is_sys_pc2epc),
    .io_dec_uops_3_is_unique         (_decode_units_3_io_deq_uop_is_unique),
    .io_dec_uops_3_flush_on_commit   (_decode_units_3_io_deq_uop_flush_on_commit),
    .io_dec_uops_3_ldst              (_decode_units_3_io_deq_uop_ldst),
    .io_dec_uops_3_lrs1              (_decode_units_3_io_deq_uop_lrs1),
    .io_dec_uops_3_lrs2              (_decode_units_3_io_deq_uop_lrs2),
    .io_dec_uops_3_ldst_val          (_decode_units_3_io_deq_uop_ldst_val),
    .io_dec_uops_3_dst_rtype         (_decode_units_3_io_deq_uop_dst_rtype),
    .io_dec_uops_3_lrs1_rtype        (_decode_units_3_io_deq_uop_lrs1_rtype),
    .io_dec_uops_3_lrs2_rtype        (_decode_units_3_io_deq_uop_lrs2_rtype),
    .io_dec_uops_3_frs3_en           (_decode_units_3_io_deq_uop_frs3_en),
    .io_dec_uops_3_fp_val            (_decode_units_3_io_deq_uop_fp_val),
    .io_brupdate_b1_resolve_mask     (_b1_resolve_mask_T_6),
    .io_brupdate_b2_uop_br_tag       (b2_uop_br_tag),
    .io_brupdate_b2_mispredict       (b2_mispredict),
    .io_dis_fire_0                   (dis_fire_0),
    .io_dis_fire_1                   (dis_fire_1),
    .io_dis_fire_2                   (dis_fire_2),
    .io_dis_fire_3                   (dis_fire_3),
    .io_dis_ready                    (~dis_stalls_3),
    .io_wakeups_0_valid              (_ll_wbarb_io_out_valid & _iregfile_io_write_ports_0_wport_valid_T),
    .io_wakeups_0_bits_uop_pdst      (_ll_wbarb_io_out_bits_uop_pdst),
    .io_wakeups_0_bits_uop_dst_rtype (_ll_wbarb_io_out_bits_uop_dst_rtype),
    .io_wakeups_1_valid              (_memExeUnit_1_io_ll_iresp_valid & _iregfile_io_write_ports_1_wport_valid_T),
    .io_wakeups_1_bits_uop_pdst      (_memExeUnit_1_io_ll_iresp_bits_uop_pdst),
    .io_wakeups_1_bits_uop_dst_rtype (_memExeUnit_1_io_ll_iresp_bits_uop_dst_rtype),
    .io_wakeups_2_valid              (fast_wakeup_valid),
    .io_wakeups_2_bits_uop_pdst      (_int_issue_unit_io_iss_uops_0_pdst),
    .io_wakeups_2_bits_uop_dst_rtype (_int_issue_unit_io_iss_uops_0_dst_rtype),
    .io_wakeups_3_valid              (slow_wakeup_valid),
    .io_wakeups_3_bits_uop_pdst      (_alu_exe_unit_io_iresp_bits_uop_pdst),
    .io_wakeups_3_bits_uop_dst_rtype (_alu_exe_unit_io_iresp_bits_uop_dst_rtype),
    .io_wakeups_4_valid              (fast_wakeup_1_valid),
    .io_wakeups_4_bits_uop_pdst      (_int_issue_unit_io_iss_uops_1_pdst),
    .io_wakeups_4_bits_uop_dst_rtype (_int_issue_unit_io_iss_uops_1_dst_rtype),
    .io_wakeups_5_valid              (slow_wakeup_1_valid),
    .io_wakeups_5_bits_uop_pdst      (_alu_exe_unit_1_io_iresp_bits_uop_pdst),
    .io_wakeups_5_bits_uop_dst_rtype (_alu_exe_unit_1_io_iresp_bits_uop_dst_rtype),
    .io_wakeups_6_valid              (fast_wakeup_2_valid),
    .io_wakeups_6_bits_uop_pdst      (_int_issue_unit_io_iss_uops_2_pdst),
    .io_wakeups_6_bits_uop_dst_rtype (_int_issue_unit_io_iss_uops_2_dst_rtype),
    .io_wakeups_7_valid              (slow_wakeup_2_valid),
    .io_wakeups_7_bits_uop_pdst      (_alu_exe_unit_2_io_iresp_bits_uop_pdst),
    .io_wakeups_7_bits_uop_dst_rtype (_alu_exe_unit_2_io_iresp_bits_uop_dst_rtype),
    .io_wakeups_8_valid              (fast_wakeup_3_valid),
    .io_wakeups_8_bits_uop_pdst      (_int_issue_unit_io_iss_uops_3_pdst),
    .io_wakeups_8_bits_uop_dst_rtype (_int_issue_unit_io_iss_uops_3_dst_rtype),
    .io_wakeups_9_valid              (slow_wakeup_3_valid),
    .io_wakeups_9_bits_uop_pdst      (_alu_exe_unit_3_io_iresp_bits_uop_pdst),
    .io_wakeups_9_bits_uop_dst_rtype (_alu_exe_unit_3_io_iresp_bits_uop_dst_rtype),
    .io_com_valids_0                 (_rob_io_commit_valids_0),
    .io_com_valids_1                 (_rob_io_commit_valids_1),
    .io_com_valids_2                 (_rob_io_commit_valids_2),
    .io_com_valids_3                 (_rob_io_commit_valids_3),
    .io_com_uops_0_pdst              (_rob_io_commit_uops_0_pdst),
    .io_com_uops_0_stale_pdst        (_rob_io_commit_uops_0_stale_pdst),
    .io_com_uops_0_ldst              (_rob_io_commit_uops_0_ldst),
    .io_com_uops_0_ldst_val          (_rob_io_commit_uops_0_ldst_val),
    .io_com_uops_0_dst_rtype         (_rob_io_commit_uops_0_dst_rtype),
    .io_com_uops_1_pdst              (_rob_io_commit_uops_1_pdst),
    .io_com_uops_1_stale_pdst        (_rob_io_commit_uops_1_stale_pdst),
    .io_com_uops_1_ldst              (_rob_io_commit_uops_1_ldst),
    .io_com_uops_1_ldst_val          (_rob_io_commit_uops_1_ldst_val),
    .io_com_uops_1_dst_rtype         (_rob_io_commit_uops_1_dst_rtype),
    .io_com_uops_2_pdst              (_rob_io_commit_uops_2_pdst),
    .io_com_uops_2_stale_pdst        (_rob_io_commit_uops_2_stale_pdst),
    .io_com_uops_2_ldst              (_rob_io_commit_uops_2_ldst),
    .io_com_uops_2_ldst_val          (_rob_io_commit_uops_2_ldst_val),
    .io_com_uops_2_dst_rtype         (_rob_io_commit_uops_2_dst_rtype),
    .io_com_uops_3_pdst              (_rob_io_commit_uops_3_pdst),
    .io_com_uops_3_stale_pdst        (_rob_io_commit_uops_3_stale_pdst),
    .io_com_uops_3_ldst              (_rob_io_commit_uops_3_ldst),
    .io_com_uops_3_ldst_val          (_rob_io_commit_uops_3_ldst_val),
    .io_com_uops_3_dst_rtype         (_rob_io_commit_uops_3_dst_rtype),
    .io_rbk_valids_0                 (_rob_io_commit_rbk_valids_0),
    .io_rbk_valids_1                 (_rob_io_commit_rbk_valids_1),
    .io_rbk_valids_2                 (_rob_io_commit_rbk_valids_2),
    .io_rbk_valids_3                 (_rob_io_commit_rbk_valids_3),
    .io_rollback                     (_rob_io_commit_rollback),
    .io_debug_rob_empty              (_rob_io_empty),
    .io_ren_stalls_0                 (_rename_stage_io_ren_stalls_0),
    .io_ren_stalls_1                 (_rename_stage_io_ren_stalls_1),
    .io_ren_stalls_2                 (_rename_stage_io_ren_stalls_2),
    .io_ren_stalls_3                 (_rename_stage_io_ren_stalls_3),
    .io_ren2_mask_0                  (_rename_stage_io_ren2_mask_0),
    .io_ren2_mask_1                  (_rename_stage_io_ren2_mask_1),
    .io_ren2_mask_2                  (_rename_stage_io_ren2_mask_2),
    .io_ren2_mask_3                  (_rename_stage_io_ren2_mask_3),
    .io_ren2_uops_0_uopc             (_rename_stage_io_ren2_uops_0_uopc),
    .io_ren2_uops_0_is_rvc           (_rename_stage_io_ren2_uops_0_is_rvc),
    .io_ren2_uops_0_iq_type          (_rename_stage_io_ren2_uops_0_iq_type),
    .io_ren2_uops_0_fu_code          (_rename_stage_io_ren2_uops_0_fu_code),
    .io_ren2_uops_0_ctrl_is_load     (io_lsu_dis_uops_0_bits_ctrl_is_load),
    .io_ren2_uops_0_ctrl_is_sta      (io_lsu_dis_uops_0_bits_ctrl_is_sta),
    .io_ren2_uops_0_is_br            (_rename_stage_io_ren2_uops_0_is_br),
    .io_ren2_uops_0_is_jalr          (_rename_stage_io_ren2_uops_0_is_jalr),
    .io_ren2_uops_0_is_jal           (_rename_stage_io_ren2_uops_0_is_jal),
    .io_ren2_uops_0_is_sfb           (_rename_stage_io_ren2_uops_0_is_sfb),
    .io_ren2_uops_0_br_mask          (_rename_stage_io_ren2_uops_0_br_mask),
    .io_ren2_uops_0_br_tag           (_rename_stage_io_ren2_uops_0_br_tag),
    .io_ren2_uops_0_ftq_idx          (_rename_stage_io_ren2_uops_0_ftq_idx),
    .io_ren2_uops_0_edge_inst        (_rename_stage_io_ren2_uops_0_edge_inst),
    .io_ren2_uops_0_pc_lob           (_rename_stage_io_ren2_uops_0_pc_lob),
    .io_ren2_uops_0_taken            (_rename_stage_io_ren2_uops_0_taken),
    .io_ren2_uops_0_imm_packed       (_rename_stage_io_ren2_uops_0_imm_packed),
    .io_ren2_uops_0_pdst             (_rename_stage_io_ren2_uops_0_pdst),
    .io_ren2_uops_0_prs1             (_rename_stage_io_ren2_uops_0_prs1),
    .io_ren2_uops_0_prs2             (_rename_stage_io_ren2_uops_0_prs2),
    .io_ren2_uops_0_prs1_busy        (_rename_stage_io_ren2_uops_0_prs1_busy),
    .io_ren2_uops_0_prs2_busy        (_rename_stage_io_ren2_uops_0_prs2_busy),
    .io_ren2_uops_0_stale_pdst       (_rename_stage_io_ren2_uops_0_stale_pdst),
    .io_ren2_uops_0_exception        (_rename_stage_io_ren2_uops_0_exception),
    .io_ren2_uops_0_exc_cause        (_rename_stage_io_ren2_uops_0_exc_cause),
    .io_ren2_uops_0_bypassable       (_rename_stage_io_ren2_uops_0_bypassable),
    .io_ren2_uops_0_mem_cmd          (_rename_stage_io_ren2_uops_0_mem_cmd),
    .io_ren2_uops_0_mem_size         (_rename_stage_io_ren2_uops_0_mem_size),
    .io_ren2_uops_0_mem_signed       (_rename_stage_io_ren2_uops_0_mem_signed),
    .io_ren2_uops_0_is_fence         (_rename_stage_io_ren2_uops_0_is_fence),
    .io_ren2_uops_0_is_fencei        (_rename_stage_io_ren2_uops_0_is_fencei),
    .io_ren2_uops_0_is_amo           (_rename_stage_io_ren2_uops_0_is_amo),
    .io_ren2_uops_0_uses_ldq         (_rename_stage_io_ren2_uops_0_uses_ldq),
    .io_ren2_uops_0_uses_stq         (_rename_stage_io_ren2_uops_0_uses_stq),
    .io_ren2_uops_0_is_sys_pc2epc    (_rename_stage_io_ren2_uops_0_is_sys_pc2epc),
    .io_ren2_uops_0_is_unique        (_rename_stage_io_ren2_uops_0_is_unique),
    .io_ren2_uops_0_flush_on_commit  (_rename_stage_io_ren2_uops_0_flush_on_commit),
    .io_ren2_uops_0_ldst             (_rename_stage_io_ren2_uops_0_ldst),
    .io_ren2_uops_0_lrs1             (_rename_stage_io_ren2_uops_0_lrs1),
    .io_ren2_uops_0_ldst_val         (_rename_stage_io_ren2_uops_0_ldst_val),
    .io_ren2_uops_0_dst_rtype        (_rename_stage_io_ren2_uops_0_dst_rtype),
    .io_ren2_uops_0_lrs1_rtype       (_rename_stage_io_ren2_uops_0_lrs1_rtype),
    .io_ren2_uops_0_lrs2_rtype       (_rename_stage_io_ren2_uops_0_lrs2_rtype),
    .io_ren2_uops_0_frs3_en          (_rename_stage_io_ren2_uops_0_frs3_en),
    .io_ren2_uops_0_fp_val           (_rename_stage_io_ren2_uops_0_fp_val),
    .io_ren2_uops_1_uopc             (_rename_stage_io_ren2_uops_1_uopc),
    .io_ren2_uops_1_is_rvc           (_rename_stage_io_ren2_uops_1_is_rvc),
    .io_ren2_uops_1_iq_type          (_rename_stage_io_ren2_uops_1_iq_type),
    .io_ren2_uops_1_fu_code          (_rename_stage_io_ren2_uops_1_fu_code),
    .io_ren2_uops_1_ctrl_is_load     (io_lsu_dis_uops_1_bits_ctrl_is_load),
    .io_ren2_uops_1_ctrl_is_sta      (io_lsu_dis_uops_1_bits_ctrl_is_sta),
    .io_ren2_uops_1_is_br            (_rename_stage_io_ren2_uops_1_is_br),
    .io_ren2_uops_1_is_jalr          (_rename_stage_io_ren2_uops_1_is_jalr),
    .io_ren2_uops_1_is_jal           (_rename_stage_io_ren2_uops_1_is_jal),
    .io_ren2_uops_1_is_sfb           (_rename_stage_io_ren2_uops_1_is_sfb),
    .io_ren2_uops_1_br_mask          (_rename_stage_io_ren2_uops_1_br_mask),
    .io_ren2_uops_1_br_tag           (_rename_stage_io_ren2_uops_1_br_tag),
    .io_ren2_uops_1_ftq_idx          (_rename_stage_io_ren2_uops_1_ftq_idx),
    .io_ren2_uops_1_edge_inst        (_rename_stage_io_ren2_uops_1_edge_inst),
    .io_ren2_uops_1_pc_lob           (_rename_stage_io_ren2_uops_1_pc_lob),
    .io_ren2_uops_1_taken            (_rename_stage_io_ren2_uops_1_taken),
    .io_ren2_uops_1_imm_packed       (_rename_stage_io_ren2_uops_1_imm_packed),
    .io_ren2_uops_1_pdst             (_rename_stage_io_ren2_uops_1_pdst),
    .io_ren2_uops_1_prs1             (_rename_stage_io_ren2_uops_1_prs1),
    .io_ren2_uops_1_prs2             (_rename_stage_io_ren2_uops_1_prs2),
    .io_ren2_uops_1_prs1_busy        (_rename_stage_io_ren2_uops_1_prs1_busy),
    .io_ren2_uops_1_prs2_busy        (_rename_stage_io_ren2_uops_1_prs2_busy),
    .io_ren2_uops_1_stale_pdst       (_rename_stage_io_ren2_uops_1_stale_pdst),
    .io_ren2_uops_1_exception        (_rename_stage_io_ren2_uops_1_exception),
    .io_ren2_uops_1_exc_cause        (_rename_stage_io_ren2_uops_1_exc_cause),
    .io_ren2_uops_1_bypassable       (_rename_stage_io_ren2_uops_1_bypassable),
    .io_ren2_uops_1_mem_cmd          (_rename_stage_io_ren2_uops_1_mem_cmd),
    .io_ren2_uops_1_mem_size         (_rename_stage_io_ren2_uops_1_mem_size),
    .io_ren2_uops_1_mem_signed       (_rename_stage_io_ren2_uops_1_mem_signed),
    .io_ren2_uops_1_is_fence         (_rename_stage_io_ren2_uops_1_is_fence),
    .io_ren2_uops_1_is_fencei        (_rename_stage_io_ren2_uops_1_is_fencei),
    .io_ren2_uops_1_is_amo           (_rename_stage_io_ren2_uops_1_is_amo),
    .io_ren2_uops_1_uses_ldq         (_rename_stage_io_ren2_uops_1_uses_ldq),
    .io_ren2_uops_1_uses_stq         (_rename_stage_io_ren2_uops_1_uses_stq),
    .io_ren2_uops_1_is_sys_pc2epc    (_rename_stage_io_ren2_uops_1_is_sys_pc2epc),
    .io_ren2_uops_1_is_unique        (_rename_stage_io_ren2_uops_1_is_unique),
    .io_ren2_uops_1_flush_on_commit  (_rename_stage_io_ren2_uops_1_flush_on_commit),
    .io_ren2_uops_1_ldst             (_rename_stage_io_ren2_uops_1_ldst),
    .io_ren2_uops_1_lrs1             (_rename_stage_io_ren2_uops_1_lrs1),
    .io_ren2_uops_1_ldst_val         (_rename_stage_io_ren2_uops_1_ldst_val),
    .io_ren2_uops_1_dst_rtype        (_rename_stage_io_ren2_uops_1_dst_rtype),
    .io_ren2_uops_1_lrs1_rtype       (_rename_stage_io_ren2_uops_1_lrs1_rtype),
    .io_ren2_uops_1_lrs2_rtype       (_rename_stage_io_ren2_uops_1_lrs2_rtype),
    .io_ren2_uops_1_frs3_en          (_rename_stage_io_ren2_uops_1_frs3_en),
    .io_ren2_uops_1_fp_val           (_rename_stage_io_ren2_uops_1_fp_val),
    .io_ren2_uops_2_uopc             (_rename_stage_io_ren2_uops_2_uopc),
    .io_ren2_uops_2_is_rvc           (_rename_stage_io_ren2_uops_2_is_rvc),
    .io_ren2_uops_2_iq_type          (_rename_stage_io_ren2_uops_2_iq_type),
    .io_ren2_uops_2_fu_code          (_rename_stage_io_ren2_uops_2_fu_code),
    .io_ren2_uops_2_ctrl_is_load     (io_lsu_dis_uops_2_bits_ctrl_is_load),
    .io_ren2_uops_2_ctrl_is_sta      (io_lsu_dis_uops_2_bits_ctrl_is_sta),
    .io_ren2_uops_2_is_br            (_rename_stage_io_ren2_uops_2_is_br),
    .io_ren2_uops_2_is_jalr          (_rename_stage_io_ren2_uops_2_is_jalr),
    .io_ren2_uops_2_is_jal           (_rename_stage_io_ren2_uops_2_is_jal),
    .io_ren2_uops_2_is_sfb           (_rename_stage_io_ren2_uops_2_is_sfb),
    .io_ren2_uops_2_br_mask          (_rename_stage_io_ren2_uops_2_br_mask),
    .io_ren2_uops_2_br_tag           (_rename_stage_io_ren2_uops_2_br_tag),
    .io_ren2_uops_2_ftq_idx          (_rename_stage_io_ren2_uops_2_ftq_idx),
    .io_ren2_uops_2_edge_inst        (_rename_stage_io_ren2_uops_2_edge_inst),
    .io_ren2_uops_2_pc_lob           (_rename_stage_io_ren2_uops_2_pc_lob),
    .io_ren2_uops_2_taken            (_rename_stage_io_ren2_uops_2_taken),
    .io_ren2_uops_2_imm_packed       (_rename_stage_io_ren2_uops_2_imm_packed),
    .io_ren2_uops_2_pdst             (_rename_stage_io_ren2_uops_2_pdst),
    .io_ren2_uops_2_prs1             (_rename_stage_io_ren2_uops_2_prs1),
    .io_ren2_uops_2_prs2             (_rename_stage_io_ren2_uops_2_prs2),
    .io_ren2_uops_2_prs1_busy        (_rename_stage_io_ren2_uops_2_prs1_busy),
    .io_ren2_uops_2_prs2_busy        (_rename_stage_io_ren2_uops_2_prs2_busy),
    .io_ren2_uops_2_stale_pdst       (_rename_stage_io_ren2_uops_2_stale_pdst),
    .io_ren2_uops_2_exception        (_rename_stage_io_ren2_uops_2_exception),
    .io_ren2_uops_2_exc_cause        (_rename_stage_io_ren2_uops_2_exc_cause),
    .io_ren2_uops_2_bypassable       (_rename_stage_io_ren2_uops_2_bypassable),
    .io_ren2_uops_2_mem_cmd          (_rename_stage_io_ren2_uops_2_mem_cmd),
    .io_ren2_uops_2_mem_size         (_rename_stage_io_ren2_uops_2_mem_size),
    .io_ren2_uops_2_mem_signed       (_rename_stage_io_ren2_uops_2_mem_signed),
    .io_ren2_uops_2_is_fence         (_rename_stage_io_ren2_uops_2_is_fence),
    .io_ren2_uops_2_is_fencei        (_rename_stage_io_ren2_uops_2_is_fencei),
    .io_ren2_uops_2_is_amo           (_rename_stage_io_ren2_uops_2_is_amo),
    .io_ren2_uops_2_uses_ldq         (_rename_stage_io_ren2_uops_2_uses_ldq),
    .io_ren2_uops_2_uses_stq         (_rename_stage_io_ren2_uops_2_uses_stq),
    .io_ren2_uops_2_is_sys_pc2epc    (_rename_stage_io_ren2_uops_2_is_sys_pc2epc),
    .io_ren2_uops_2_is_unique        (_rename_stage_io_ren2_uops_2_is_unique),
    .io_ren2_uops_2_flush_on_commit  (_rename_stage_io_ren2_uops_2_flush_on_commit),
    .io_ren2_uops_2_ldst             (_rename_stage_io_ren2_uops_2_ldst),
    .io_ren2_uops_2_lrs1             (_rename_stage_io_ren2_uops_2_lrs1),
    .io_ren2_uops_2_ldst_val         (_rename_stage_io_ren2_uops_2_ldst_val),
    .io_ren2_uops_2_dst_rtype        (_rename_stage_io_ren2_uops_2_dst_rtype),
    .io_ren2_uops_2_lrs1_rtype       (_rename_stage_io_ren2_uops_2_lrs1_rtype),
    .io_ren2_uops_2_lrs2_rtype       (_rename_stage_io_ren2_uops_2_lrs2_rtype),
    .io_ren2_uops_2_frs3_en          (_rename_stage_io_ren2_uops_2_frs3_en),
    .io_ren2_uops_2_fp_val           (_rename_stage_io_ren2_uops_2_fp_val),
    .io_ren2_uops_3_uopc             (_rename_stage_io_ren2_uops_3_uopc),
    .io_ren2_uops_3_is_rvc           (_rename_stage_io_ren2_uops_3_is_rvc),
    .io_ren2_uops_3_iq_type          (_rename_stage_io_ren2_uops_3_iq_type),
    .io_ren2_uops_3_fu_code          (_rename_stage_io_ren2_uops_3_fu_code),
    .io_ren2_uops_3_ctrl_is_load     (io_lsu_dis_uops_3_bits_ctrl_is_load),
    .io_ren2_uops_3_ctrl_is_sta      (io_lsu_dis_uops_3_bits_ctrl_is_sta),
    .io_ren2_uops_3_is_br            (_rename_stage_io_ren2_uops_3_is_br),
    .io_ren2_uops_3_is_jalr          (_rename_stage_io_ren2_uops_3_is_jalr),
    .io_ren2_uops_3_is_jal           (_rename_stage_io_ren2_uops_3_is_jal),
    .io_ren2_uops_3_is_sfb           (_rename_stage_io_ren2_uops_3_is_sfb),
    .io_ren2_uops_3_br_mask          (_rename_stage_io_ren2_uops_3_br_mask),
    .io_ren2_uops_3_br_tag           (_rename_stage_io_ren2_uops_3_br_tag),
    .io_ren2_uops_3_ftq_idx          (_rename_stage_io_ren2_uops_3_ftq_idx),
    .io_ren2_uops_3_edge_inst        (_rename_stage_io_ren2_uops_3_edge_inst),
    .io_ren2_uops_3_pc_lob           (_rename_stage_io_ren2_uops_3_pc_lob),
    .io_ren2_uops_3_taken            (_rename_stage_io_ren2_uops_3_taken),
    .io_ren2_uops_3_imm_packed       (_rename_stage_io_ren2_uops_3_imm_packed),
    .io_ren2_uops_3_pdst             (_rename_stage_io_ren2_uops_3_pdst),
    .io_ren2_uops_3_prs1             (_rename_stage_io_ren2_uops_3_prs1),
    .io_ren2_uops_3_prs2             (_rename_stage_io_ren2_uops_3_prs2),
    .io_ren2_uops_3_prs1_busy        (_rename_stage_io_ren2_uops_3_prs1_busy),
    .io_ren2_uops_3_prs2_busy        (_rename_stage_io_ren2_uops_3_prs2_busy),
    .io_ren2_uops_3_stale_pdst       (_rename_stage_io_ren2_uops_3_stale_pdst),
    .io_ren2_uops_3_exception        (_rename_stage_io_ren2_uops_3_exception),
    .io_ren2_uops_3_exc_cause        (_rename_stage_io_ren2_uops_3_exc_cause),
    .io_ren2_uops_3_bypassable       (_rename_stage_io_ren2_uops_3_bypassable),
    .io_ren2_uops_3_mem_cmd          (_rename_stage_io_ren2_uops_3_mem_cmd),
    .io_ren2_uops_3_mem_size         (_rename_stage_io_ren2_uops_3_mem_size),
    .io_ren2_uops_3_mem_signed       (_rename_stage_io_ren2_uops_3_mem_signed),
    .io_ren2_uops_3_is_fence         (_rename_stage_io_ren2_uops_3_is_fence),
    .io_ren2_uops_3_is_fencei        (_rename_stage_io_ren2_uops_3_is_fencei),
    .io_ren2_uops_3_is_amo           (_rename_stage_io_ren2_uops_3_is_amo),
    .io_ren2_uops_3_uses_ldq         (_rename_stage_io_ren2_uops_3_uses_ldq),
    .io_ren2_uops_3_uses_stq         (_rename_stage_io_ren2_uops_3_uses_stq),
    .io_ren2_uops_3_is_sys_pc2epc    (_rename_stage_io_ren2_uops_3_is_sys_pc2epc),
    .io_ren2_uops_3_is_unique        (_rename_stage_io_ren2_uops_3_is_unique),
    .io_ren2_uops_3_flush_on_commit  (_rename_stage_io_ren2_uops_3_flush_on_commit),
    .io_ren2_uops_3_ldst             (_rename_stage_io_ren2_uops_3_ldst),
    .io_ren2_uops_3_lrs1             (_rename_stage_io_ren2_uops_3_lrs1),
    .io_ren2_uops_3_ldst_val         (_rename_stage_io_ren2_uops_3_ldst_val),
    .io_ren2_uops_3_dst_rtype        (_rename_stage_io_ren2_uops_3_dst_rtype),
    .io_ren2_uops_3_lrs1_rtype       (_rename_stage_io_ren2_uops_3_lrs1_rtype),
    .io_ren2_uops_3_lrs2_rtype       (_rename_stage_io_ren2_uops_3_lrs2_rtype),
    .io_ren2_uops_3_frs3_en          (_rename_stage_io_ren2_uops_3_frs3_en),
    .io_ren2_uops_3_fp_val           (_rename_stage_io_ren2_uops_3_fp_val)
  );
  RenameStage_1 fp_rename_stage (
    .clock                           (clock),
    .reset                           (reset),
    .io_kill                         (_io_ifu_redirect_flush_output),
    .io_dec_uops_0_is_br             (_decode_units_0_io_deq_uop_is_br),
    .io_dec_uops_0_is_jalr           (_decode_units_0_io_deq_uop_is_jalr),
    .io_dec_uops_0_is_sfb            (_decode_units_0_io_deq_uop_is_sfb),
    .io_dec_uops_0_br_tag            (_dec_brmask_logic_io_br_tag_0),
    .io_dec_uops_0_ldst              (_decode_units_0_io_deq_uop_ldst),
    .io_dec_uops_0_lrs1              (_decode_units_0_io_deq_uop_lrs1),
    .io_dec_uops_0_lrs2              (_decode_units_0_io_deq_uop_lrs2),
    .io_dec_uops_0_lrs3              (_decode_units_0_io_deq_uop_lrs3),
    .io_dec_uops_0_ldst_val          (_decode_units_0_io_deq_uop_ldst_val),
    .io_dec_uops_0_dst_rtype         (_decode_units_0_io_deq_uop_dst_rtype),
    .io_dec_uops_0_lrs1_rtype        (_decode_units_0_io_deq_uop_lrs1_rtype),
    .io_dec_uops_0_lrs2_rtype        (_decode_units_0_io_deq_uop_lrs2_rtype),
    .io_dec_uops_0_frs3_en           (_decode_units_0_io_deq_uop_frs3_en),
    .io_dec_uops_1_is_br             (_decode_units_1_io_deq_uop_is_br),
    .io_dec_uops_1_is_jalr           (_decode_units_1_io_deq_uop_is_jalr),
    .io_dec_uops_1_is_sfb            (_decode_units_1_io_deq_uop_is_sfb),
    .io_dec_uops_1_br_tag            (_dec_brmask_logic_io_br_tag_1),
    .io_dec_uops_1_ldst              (_decode_units_1_io_deq_uop_ldst),
    .io_dec_uops_1_lrs1              (_decode_units_1_io_deq_uop_lrs1),
    .io_dec_uops_1_lrs2              (_decode_units_1_io_deq_uop_lrs2),
    .io_dec_uops_1_lrs3              (_decode_units_1_io_deq_uop_lrs3),
    .io_dec_uops_1_ldst_val          (_decode_units_1_io_deq_uop_ldst_val),
    .io_dec_uops_1_dst_rtype         (_decode_units_1_io_deq_uop_dst_rtype),
    .io_dec_uops_1_lrs1_rtype        (_decode_units_1_io_deq_uop_lrs1_rtype),
    .io_dec_uops_1_lrs2_rtype        (_decode_units_1_io_deq_uop_lrs2_rtype),
    .io_dec_uops_1_frs3_en           (_decode_units_1_io_deq_uop_frs3_en),
    .io_dec_uops_2_is_br             (_decode_units_2_io_deq_uop_is_br),
    .io_dec_uops_2_is_jalr           (_decode_units_2_io_deq_uop_is_jalr),
    .io_dec_uops_2_is_sfb            (_decode_units_2_io_deq_uop_is_sfb),
    .io_dec_uops_2_br_tag            (_dec_brmask_logic_io_br_tag_2),
    .io_dec_uops_2_ldst              (_decode_units_2_io_deq_uop_ldst),
    .io_dec_uops_2_lrs1              (_decode_units_2_io_deq_uop_lrs1),
    .io_dec_uops_2_lrs2              (_decode_units_2_io_deq_uop_lrs2),
    .io_dec_uops_2_lrs3              (_decode_units_2_io_deq_uop_lrs3),
    .io_dec_uops_2_ldst_val          (_decode_units_2_io_deq_uop_ldst_val),
    .io_dec_uops_2_dst_rtype         (_decode_units_2_io_deq_uop_dst_rtype),
    .io_dec_uops_2_lrs1_rtype        (_decode_units_2_io_deq_uop_lrs1_rtype),
    .io_dec_uops_2_lrs2_rtype        (_decode_units_2_io_deq_uop_lrs2_rtype),
    .io_dec_uops_2_frs3_en           (_decode_units_2_io_deq_uop_frs3_en),
    .io_dec_uops_3_is_br             (_decode_units_3_io_deq_uop_is_br),
    .io_dec_uops_3_is_jalr           (_decode_units_3_io_deq_uop_is_jalr),
    .io_dec_uops_3_is_sfb            (_decode_units_3_io_deq_uop_is_sfb),
    .io_dec_uops_3_br_tag            (_dec_brmask_logic_io_br_tag_3),
    .io_dec_uops_3_ldst              (_decode_units_3_io_deq_uop_ldst),
    .io_dec_uops_3_lrs1              (_decode_units_3_io_deq_uop_lrs1),
    .io_dec_uops_3_lrs2              (_decode_units_3_io_deq_uop_lrs2),
    .io_dec_uops_3_lrs3              (_decode_units_3_io_deq_uop_lrs3),
    .io_dec_uops_3_ldst_val          (_decode_units_3_io_deq_uop_ldst_val),
    .io_dec_uops_3_dst_rtype         (_decode_units_3_io_deq_uop_dst_rtype),
    .io_dec_uops_3_lrs1_rtype        (_decode_units_3_io_deq_uop_lrs1_rtype),
    .io_dec_uops_3_lrs2_rtype        (_decode_units_3_io_deq_uop_lrs2_rtype),
    .io_dec_uops_3_frs3_en           (_decode_units_3_io_deq_uop_frs3_en),
    .io_brupdate_b2_uop_br_tag       (b2_uop_br_tag),
    .io_brupdate_b2_mispredict       (b2_mispredict),
    .io_dis_fire_0                   (dis_fire_0),
    .io_dis_fire_1                   (dis_fire_1),
    .io_dis_fire_2                   (dis_fire_2),
    .io_dis_fire_3                   (dis_fire_3),
    .io_dis_ready                    (~dis_stalls_3),
    .io_wakeups_0_valid              (_FpPipeline_io_wakeups_0_valid),
    .io_wakeups_0_bits_uop_pdst      (_FpPipeline_io_wakeups_0_bits_uop_pdst),
    .io_wakeups_0_bits_uop_dst_rtype (_FpPipeline_io_wakeups_0_bits_uop_dst_rtype),
    .io_wakeups_1_valid              (_FpPipeline_io_wakeups_1_valid),
    .io_wakeups_1_bits_uop_pdst      (_FpPipeline_io_wakeups_1_bits_uop_pdst),
    .io_wakeups_1_bits_uop_dst_rtype (_FpPipeline_io_wakeups_1_bits_uop_dst_rtype),
    .io_wakeups_2_valid              (_FpPipeline_io_wakeups_2_valid),
    .io_wakeups_2_bits_uop_pdst      (_FpPipeline_io_wakeups_2_bits_uop_pdst),
    .io_wakeups_2_bits_uop_dst_rtype (_FpPipeline_io_wakeups_2_bits_uop_dst_rtype),
    .io_wakeups_3_valid              (_FpPipeline_io_wakeups_3_valid),
    .io_wakeups_3_bits_uop_pdst      (_FpPipeline_io_wakeups_3_bits_uop_pdst),
    .io_wakeups_3_bits_uop_dst_rtype (_FpPipeline_io_wakeups_3_bits_uop_dst_rtype),
    .io_com_valids_0                 (_rob_io_commit_valids_0),
    .io_com_valids_1                 (_rob_io_commit_valids_1),
    .io_com_valids_2                 (_rob_io_commit_valids_2),
    .io_com_valids_3                 (_rob_io_commit_valids_3),
    .io_com_uops_0_pdst              (_rob_io_commit_uops_0_pdst),
    .io_com_uops_0_stale_pdst        (_rob_io_commit_uops_0_stale_pdst),
    .io_com_uops_0_ldst              (_rob_io_commit_uops_0_ldst),
    .io_com_uops_0_ldst_val          (_rob_io_commit_uops_0_ldst_val),
    .io_com_uops_0_dst_rtype         (_rob_io_commit_uops_0_dst_rtype),
    .io_com_uops_1_pdst              (_rob_io_commit_uops_1_pdst),
    .io_com_uops_1_stale_pdst        (_rob_io_commit_uops_1_stale_pdst),
    .io_com_uops_1_ldst              (_rob_io_commit_uops_1_ldst),
    .io_com_uops_1_ldst_val          (_rob_io_commit_uops_1_ldst_val),
    .io_com_uops_1_dst_rtype         (_rob_io_commit_uops_1_dst_rtype),
    .io_com_uops_2_pdst              (_rob_io_commit_uops_2_pdst),
    .io_com_uops_2_stale_pdst        (_rob_io_commit_uops_2_stale_pdst),
    .io_com_uops_2_ldst              (_rob_io_commit_uops_2_ldst),
    .io_com_uops_2_ldst_val          (_rob_io_commit_uops_2_ldst_val),
    .io_com_uops_2_dst_rtype         (_rob_io_commit_uops_2_dst_rtype),
    .io_com_uops_3_pdst              (_rob_io_commit_uops_3_pdst),
    .io_com_uops_3_stale_pdst        (_rob_io_commit_uops_3_stale_pdst),
    .io_com_uops_3_ldst              (_rob_io_commit_uops_3_ldst),
    .io_com_uops_3_ldst_val          (_rob_io_commit_uops_3_ldst_val),
    .io_com_uops_3_dst_rtype         (_rob_io_commit_uops_3_dst_rtype),
    .io_rbk_valids_0                 (_rob_io_commit_rbk_valids_0),
    .io_rbk_valids_1                 (_rob_io_commit_rbk_valids_1),
    .io_rbk_valids_2                 (_rob_io_commit_rbk_valids_2),
    .io_rbk_valids_3                 (_rob_io_commit_rbk_valids_3),
    .io_rollback                     (_rob_io_commit_rollback),
    .io_debug_rob_empty              (_rob_io_empty),
    .io_ren_stalls_0                 (_fp_rename_stage_io_ren_stalls_0),
    .io_ren_stalls_1                 (_fp_rename_stage_io_ren_stalls_1),
    .io_ren_stalls_2                 (_fp_rename_stage_io_ren_stalls_2),
    .io_ren_stalls_3                 (_fp_rename_stage_io_ren_stalls_3),
    .io_ren2_uops_0_pdst             (_fp_rename_stage_io_ren2_uops_0_pdst),
    .io_ren2_uops_0_prs1             (_fp_rename_stage_io_ren2_uops_0_prs1),
    .io_ren2_uops_0_prs2             (_fp_rename_stage_io_ren2_uops_0_prs2),
    .io_ren2_uops_0_prs3             (_fp_rename_stage_io_ren2_uops_0_prs3),
    .io_ren2_uops_0_prs1_busy        (_fp_rename_stage_io_ren2_uops_0_prs1_busy),
    .io_ren2_uops_0_prs2_busy        (_fp_rename_stage_io_ren2_uops_0_prs2_busy),
    .io_ren2_uops_0_prs3_busy        (_fp_rename_stage_io_ren2_uops_0_prs3_busy),
    .io_ren2_uops_0_stale_pdst       (_fp_rename_stage_io_ren2_uops_0_stale_pdst),
    .io_ren2_uops_1_pdst             (_fp_rename_stage_io_ren2_uops_1_pdst),
    .io_ren2_uops_1_prs1             (_fp_rename_stage_io_ren2_uops_1_prs1),
    .io_ren2_uops_1_prs2             (_fp_rename_stage_io_ren2_uops_1_prs2),
    .io_ren2_uops_1_prs3             (_fp_rename_stage_io_ren2_uops_1_prs3),
    .io_ren2_uops_1_prs1_busy        (_fp_rename_stage_io_ren2_uops_1_prs1_busy),
    .io_ren2_uops_1_prs2_busy        (_fp_rename_stage_io_ren2_uops_1_prs2_busy),
    .io_ren2_uops_1_prs3_busy        (_fp_rename_stage_io_ren2_uops_1_prs3_busy),
    .io_ren2_uops_1_stale_pdst       (_fp_rename_stage_io_ren2_uops_1_stale_pdst),
    .io_ren2_uops_2_pdst             (_fp_rename_stage_io_ren2_uops_2_pdst),
    .io_ren2_uops_2_prs1             (_fp_rename_stage_io_ren2_uops_2_prs1),
    .io_ren2_uops_2_prs2             (_fp_rename_stage_io_ren2_uops_2_prs2),
    .io_ren2_uops_2_prs3             (_fp_rename_stage_io_ren2_uops_2_prs3),
    .io_ren2_uops_2_prs1_busy        (_fp_rename_stage_io_ren2_uops_2_prs1_busy),
    .io_ren2_uops_2_prs2_busy        (_fp_rename_stage_io_ren2_uops_2_prs2_busy),
    .io_ren2_uops_2_prs3_busy        (_fp_rename_stage_io_ren2_uops_2_prs3_busy),
    .io_ren2_uops_2_stale_pdst       (_fp_rename_stage_io_ren2_uops_2_stale_pdst),
    .io_ren2_uops_3_pdst             (_fp_rename_stage_io_ren2_uops_3_pdst),
    .io_ren2_uops_3_prs1             (_fp_rename_stage_io_ren2_uops_3_prs1),
    .io_ren2_uops_3_prs2             (_fp_rename_stage_io_ren2_uops_3_prs2),
    .io_ren2_uops_3_prs3             (_fp_rename_stage_io_ren2_uops_3_prs3),
    .io_ren2_uops_3_prs1_busy        (_fp_rename_stage_io_ren2_uops_3_prs1_busy),
    .io_ren2_uops_3_prs2_busy        (_fp_rename_stage_io_ren2_uops_3_prs2_busy),
    .io_ren2_uops_3_prs3_busy        (_fp_rename_stage_io_ren2_uops_3_prs3_busy),
    .io_ren2_uops_3_stale_pdst       (_fp_rename_stage_io_ren2_uops_3_stale_pdst)
  );
  IssueUnitCollapsing_1 mem_issue_unit (
    .clock                          (clock),
    .reset                          (reset),
    .io_dis_uops_0_valid            (_dispatcher_io_dis_uops_0_0_valid),
    .io_dis_uops_0_bits_uopc        (_dispatcher_io_dis_uops_0_0_bits_uopc),
    .io_dis_uops_0_bits_is_rvc      (_dispatcher_io_dis_uops_0_0_bits_is_rvc),
    .io_dis_uops_0_bits_fu_code     (_dispatcher_io_dis_uops_0_0_bits_fu_code),
    .io_dis_uops_0_bits_is_br       (_dispatcher_io_dis_uops_0_0_bits_is_br),
    .io_dis_uops_0_bits_is_jalr     (_dispatcher_io_dis_uops_0_0_bits_is_jalr),
    .io_dis_uops_0_bits_is_jal      (_dispatcher_io_dis_uops_0_0_bits_is_jal),
    .io_dis_uops_0_bits_is_sfb      (_dispatcher_io_dis_uops_0_0_bits_is_sfb),
    .io_dis_uops_0_bits_br_mask     (_dispatcher_io_dis_uops_0_0_bits_br_mask),
    .io_dis_uops_0_bits_br_tag      (_dispatcher_io_dis_uops_0_0_bits_br_tag),
    .io_dis_uops_0_bits_ftq_idx     (_dispatcher_io_dis_uops_0_0_bits_ftq_idx),
    .io_dis_uops_0_bits_edge_inst   (_dispatcher_io_dis_uops_0_0_bits_edge_inst),
    .io_dis_uops_0_bits_pc_lob      (_dispatcher_io_dis_uops_0_0_bits_pc_lob),
    .io_dis_uops_0_bits_taken       (_dispatcher_io_dis_uops_0_0_bits_taken),
    .io_dis_uops_0_bits_imm_packed  (_dispatcher_io_dis_uops_0_0_bits_imm_packed),
    .io_dis_uops_0_bits_rob_idx     (_dispatcher_io_dis_uops_0_0_bits_rob_idx),
    .io_dis_uops_0_bits_ldq_idx     (_dispatcher_io_dis_uops_0_0_bits_ldq_idx),
    .io_dis_uops_0_bits_stq_idx     (_dispatcher_io_dis_uops_0_0_bits_stq_idx),
    .io_dis_uops_0_bits_pdst        (_dispatcher_io_dis_uops_0_0_bits_pdst),
    .io_dis_uops_0_bits_prs1        (_dispatcher_io_dis_uops_0_0_bits_prs1),
    .io_dis_uops_0_bits_prs2        (_dispatcher_io_dis_uops_0_0_bits_prs2),
    .io_dis_uops_0_bits_prs3        (_dispatcher_io_dis_uops_0_0_bits_prs3),
    .io_dis_uops_0_bits_prs1_busy   (_dispatcher_io_dis_uops_0_0_bits_prs1_busy),
    .io_dis_uops_0_bits_prs2_busy   (_dispatcher_io_dis_uops_0_0_bits_prs2_busy),
    .io_dis_uops_0_bits_exception   (_dispatcher_io_dis_uops_0_0_bits_exception),
    .io_dis_uops_0_bits_bypassable  (_dispatcher_io_dis_uops_0_0_bits_bypassable),
    .io_dis_uops_0_bits_mem_cmd     (_dispatcher_io_dis_uops_0_0_bits_mem_cmd),
    .io_dis_uops_0_bits_mem_size    (_dispatcher_io_dis_uops_0_0_bits_mem_size),
    .io_dis_uops_0_bits_mem_signed  (_dispatcher_io_dis_uops_0_0_bits_mem_signed),
    .io_dis_uops_0_bits_is_fence    (_dispatcher_io_dis_uops_0_0_bits_is_fence),
    .io_dis_uops_0_bits_is_fencei   (_dispatcher_io_dis_uops_0_0_bits_is_fencei),
    .io_dis_uops_0_bits_is_amo      (_dispatcher_io_dis_uops_0_0_bits_is_amo),
    .io_dis_uops_0_bits_uses_ldq    (_dispatcher_io_dis_uops_0_0_bits_uses_ldq),
    .io_dis_uops_0_bits_uses_stq    (_dispatcher_io_dis_uops_0_0_bits_uses_stq),
    .io_dis_uops_0_bits_ldst_val    (_dispatcher_io_dis_uops_0_0_bits_ldst_val),
    .io_dis_uops_0_bits_dst_rtype   (_dispatcher_io_dis_uops_0_0_bits_dst_rtype),
    .io_dis_uops_0_bits_lrs1_rtype  (_dispatcher_io_dis_uops_0_0_bits_lrs1_rtype),
    .io_dis_uops_0_bits_lrs2_rtype  (_dispatcher_io_dis_uops_0_0_bits_lrs2_rtype),
    .io_dis_uops_0_bits_fp_val      (_dispatcher_io_dis_uops_0_0_bits_fp_val),
    .io_dis_uops_1_valid            (_dispatcher_io_dis_uops_0_1_valid),
    .io_dis_uops_1_bits_uopc        (_dispatcher_io_dis_uops_0_1_bits_uopc),
    .io_dis_uops_1_bits_is_rvc      (_dispatcher_io_dis_uops_0_1_bits_is_rvc),
    .io_dis_uops_1_bits_fu_code     (_dispatcher_io_dis_uops_0_1_bits_fu_code),
    .io_dis_uops_1_bits_is_br       (_dispatcher_io_dis_uops_0_1_bits_is_br),
    .io_dis_uops_1_bits_is_jalr     (_dispatcher_io_dis_uops_0_1_bits_is_jalr),
    .io_dis_uops_1_bits_is_jal      (_dispatcher_io_dis_uops_0_1_bits_is_jal),
    .io_dis_uops_1_bits_is_sfb      (_dispatcher_io_dis_uops_0_1_bits_is_sfb),
    .io_dis_uops_1_bits_br_mask     (_dispatcher_io_dis_uops_0_1_bits_br_mask),
    .io_dis_uops_1_bits_br_tag      (_dispatcher_io_dis_uops_0_1_bits_br_tag),
    .io_dis_uops_1_bits_ftq_idx     (_dispatcher_io_dis_uops_0_1_bits_ftq_idx),
    .io_dis_uops_1_bits_edge_inst   (_dispatcher_io_dis_uops_0_1_bits_edge_inst),
    .io_dis_uops_1_bits_pc_lob      (_dispatcher_io_dis_uops_0_1_bits_pc_lob),
    .io_dis_uops_1_bits_taken       (_dispatcher_io_dis_uops_0_1_bits_taken),
    .io_dis_uops_1_bits_imm_packed  (_dispatcher_io_dis_uops_0_1_bits_imm_packed),
    .io_dis_uops_1_bits_rob_idx     (_dispatcher_io_dis_uops_0_1_bits_rob_idx),
    .io_dis_uops_1_bits_ldq_idx     (_dispatcher_io_dis_uops_0_1_bits_ldq_idx),
    .io_dis_uops_1_bits_stq_idx     (_dispatcher_io_dis_uops_0_1_bits_stq_idx),
    .io_dis_uops_1_bits_pdst        (_dispatcher_io_dis_uops_0_1_bits_pdst),
    .io_dis_uops_1_bits_prs1        (_dispatcher_io_dis_uops_0_1_bits_prs1),
    .io_dis_uops_1_bits_prs2        (_dispatcher_io_dis_uops_0_1_bits_prs2),
    .io_dis_uops_1_bits_prs3        (_dispatcher_io_dis_uops_0_1_bits_prs3),
    .io_dis_uops_1_bits_prs1_busy   (_dispatcher_io_dis_uops_0_1_bits_prs1_busy),
    .io_dis_uops_1_bits_prs2_busy   (_dispatcher_io_dis_uops_0_1_bits_prs2_busy),
    .io_dis_uops_1_bits_exception   (_dispatcher_io_dis_uops_0_1_bits_exception),
    .io_dis_uops_1_bits_bypassable  (_dispatcher_io_dis_uops_0_1_bits_bypassable),
    .io_dis_uops_1_bits_mem_cmd     (_dispatcher_io_dis_uops_0_1_bits_mem_cmd),
    .io_dis_uops_1_bits_mem_size    (_dispatcher_io_dis_uops_0_1_bits_mem_size),
    .io_dis_uops_1_bits_mem_signed  (_dispatcher_io_dis_uops_0_1_bits_mem_signed),
    .io_dis_uops_1_bits_is_fence    (_dispatcher_io_dis_uops_0_1_bits_is_fence),
    .io_dis_uops_1_bits_is_fencei   (_dispatcher_io_dis_uops_0_1_bits_is_fencei),
    .io_dis_uops_1_bits_is_amo      (_dispatcher_io_dis_uops_0_1_bits_is_amo),
    .io_dis_uops_1_bits_uses_ldq    (_dispatcher_io_dis_uops_0_1_bits_uses_ldq),
    .io_dis_uops_1_bits_uses_stq    (_dispatcher_io_dis_uops_0_1_bits_uses_stq),
    .io_dis_uops_1_bits_ldst_val    (_dispatcher_io_dis_uops_0_1_bits_ldst_val),
    .io_dis_uops_1_bits_dst_rtype   (_dispatcher_io_dis_uops_0_1_bits_dst_rtype),
    .io_dis_uops_1_bits_lrs1_rtype  (_dispatcher_io_dis_uops_0_1_bits_lrs1_rtype),
    .io_dis_uops_1_bits_lrs2_rtype  (_dispatcher_io_dis_uops_0_1_bits_lrs2_rtype),
    .io_dis_uops_1_bits_fp_val      (_dispatcher_io_dis_uops_0_1_bits_fp_val),
    .io_dis_uops_2_valid            (_dispatcher_io_dis_uops_0_2_valid),
    .io_dis_uops_2_bits_uopc        (_dispatcher_io_dis_uops_0_2_bits_uopc),
    .io_dis_uops_2_bits_is_rvc      (_dispatcher_io_dis_uops_0_2_bits_is_rvc),
    .io_dis_uops_2_bits_fu_code     (_dispatcher_io_dis_uops_0_2_bits_fu_code),
    .io_dis_uops_2_bits_is_br       (_dispatcher_io_dis_uops_0_2_bits_is_br),
    .io_dis_uops_2_bits_is_jalr     (_dispatcher_io_dis_uops_0_2_bits_is_jalr),
    .io_dis_uops_2_bits_is_jal      (_dispatcher_io_dis_uops_0_2_bits_is_jal),
    .io_dis_uops_2_bits_is_sfb      (_dispatcher_io_dis_uops_0_2_bits_is_sfb),
    .io_dis_uops_2_bits_br_mask     (_dispatcher_io_dis_uops_0_2_bits_br_mask),
    .io_dis_uops_2_bits_br_tag      (_dispatcher_io_dis_uops_0_2_bits_br_tag),
    .io_dis_uops_2_bits_ftq_idx     (_dispatcher_io_dis_uops_0_2_bits_ftq_idx),
    .io_dis_uops_2_bits_edge_inst   (_dispatcher_io_dis_uops_0_2_bits_edge_inst),
    .io_dis_uops_2_bits_pc_lob      (_dispatcher_io_dis_uops_0_2_bits_pc_lob),
    .io_dis_uops_2_bits_taken       (_dispatcher_io_dis_uops_0_2_bits_taken),
    .io_dis_uops_2_bits_imm_packed  (_dispatcher_io_dis_uops_0_2_bits_imm_packed),
    .io_dis_uops_2_bits_rob_idx     (_dispatcher_io_dis_uops_0_2_bits_rob_idx),
    .io_dis_uops_2_bits_ldq_idx     (_dispatcher_io_dis_uops_0_2_bits_ldq_idx),
    .io_dis_uops_2_bits_stq_idx     (_dispatcher_io_dis_uops_0_2_bits_stq_idx),
    .io_dis_uops_2_bits_pdst        (_dispatcher_io_dis_uops_0_2_bits_pdst),
    .io_dis_uops_2_bits_prs1        (_dispatcher_io_dis_uops_0_2_bits_prs1),
    .io_dis_uops_2_bits_prs2        (_dispatcher_io_dis_uops_0_2_bits_prs2),
    .io_dis_uops_2_bits_prs3        (_dispatcher_io_dis_uops_0_2_bits_prs3),
    .io_dis_uops_2_bits_prs1_busy   (_dispatcher_io_dis_uops_0_2_bits_prs1_busy),
    .io_dis_uops_2_bits_prs2_busy   (_dispatcher_io_dis_uops_0_2_bits_prs2_busy),
    .io_dis_uops_2_bits_exception   (_dispatcher_io_dis_uops_0_2_bits_exception),
    .io_dis_uops_2_bits_bypassable  (_dispatcher_io_dis_uops_0_2_bits_bypassable),
    .io_dis_uops_2_bits_mem_cmd     (_dispatcher_io_dis_uops_0_2_bits_mem_cmd),
    .io_dis_uops_2_bits_mem_size    (_dispatcher_io_dis_uops_0_2_bits_mem_size),
    .io_dis_uops_2_bits_mem_signed  (_dispatcher_io_dis_uops_0_2_bits_mem_signed),
    .io_dis_uops_2_bits_is_fence    (_dispatcher_io_dis_uops_0_2_bits_is_fence),
    .io_dis_uops_2_bits_is_fencei   (_dispatcher_io_dis_uops_0_2_bits_is_fencei),
    .io_dis_uops_2_bits_is_amo      (_dispatcher_io_dis_uops_0_2_bits_is_amo),
    .io_dis_uops_2_bits_uses_ldq    (_dispatcher_io_dis_uops_0_2_bits_uses_ldq),
    .io_dis_uops_2_bits_uses_stq    (_dispatcher_io_dis_uops_0_2_bits_uses_stq),
    .io_dis_uops_2_bits_ldst_val    (_dispatcher_io_dis_uops_0_2_bits_ldst_val),
    .io_dis_uops_2_bits_dst_rtype   (_dispatcher_io_dis_uops_0_2_bits_dst_rtype),
    .io_dis_uops_2_bits_lrs1_rtype  (_dispatcher_io_dis_uops_0_2_bits_lrs1_rtype),
    .io_dis_uops_2_bits_lrs2_rtype  (_dispatcher_io_dis_uops_0_2_bits_lrs2_rtype),
    .io_dis_uops_2_bits_fp_val      (_dispatcher_io_dis_uops_0_2_bits_fp_val),
    .io_dis_uops_3_valid            (_dispatcher_io_dis_uops_0_3_valid),
    .io_dis_uops_3_bits_uopc        (_dispatcher_io_dis_uops_0_3_bits_uopc),
    .io_dis_uops_3_bits_is_rvc      (_dispatcher_io_dis_uops_0_3_bits_is_rvc),
    .io_dis_uops_3_bits_fu_code     (_dispatcher_io_dis_uops_0_3_bits_fu_code),
    .io_dis_uops_3_bits_is_br       (_dispatcher_io_dis_uops_0_3_bits_is_br),
    .io_dis_uops_3_bits_is_jalr     (_dispatcher_io_dis_uops_0_3_bits_is_jalr),
    .io_dis_uops_3_bits_is_jal      (_dispatcher_io_dis_uops_0_3_bits_is_jal),
    .io_dis_uops_3_bits_is_sfb      (_dispatcher_io_dis_uops_0_3_bits_is_sfb),
    .io_dis_uops_3_bits_br_mask     (_dispatcher_io_dis_uops_0_3_bits_br_mask),
    .io_dis_uops_3_bits_br_tag      (_dispatcher_io_dis_uops_0_3_bits_br_tag),
    .io_dis_uops_3_bits_ftq_idx     (_dispatcher_io_dis_uops_0_3_bits_ftq_idx),
    .io_dis_uops_3_bits_edge_inst   (_dispatcher_io_dis_uops_0_3_bits_edge_inst),
    .io_dis_uops_3_bits_pc_lob      (_dispatcher_io_dis_uops_0_3_bits_pc_lob),
    .io_dis_uops_3_bits_taken       (_dispatcher_io_dis_uops_0_3_bits_taken),
    .io_dis_uops_3_bits_imm_packed  (_dispatcher_io_dis_uops_0_3_bits_imm_packed),
    .io_dis_uops_3_bits_rob_idx     (_dispatcher_io_dis_uops_0_3_bits_rob_idx),
    .io_dis_uops_3_bits_ldq_idx     (_dispatcher_io_dis_uops_0_3_bits_ldq_idx),
    .io_dis_uops_3_bits_stq_idx     (_dispatcher_io_dis_uops_0_3_bits_stq_idx),
    .io_dis_uops_3_bits_pdst        (_dispatcher_io_dis_uops_0_3_bits_pdst),
    .io_dis_uops_3_bits_prs1        (_dispatcher_io_dis_uops_0_3_bits_prs1),
    .io_dis_uops_3_bits_prs2        (_dispatcher_io_dis_uops_0_3_bits_prs2),
    .io_dis_uops_3_bits_prs3        (_dispatcher_io_dis_uops_0_3_bits_prs3),
    .io_dis_uops_3_bits_prs1_busy   (_dispatcher_io_dis_uops_0_3_bits_prs1_busy),
    .io_dis_uops_3_bits_prs2_busy   (_dispatcher_io_dis_uops_0_3_bits_prs2_busy),
    .io_dis_uops_3_bits_exception   (_dispatcher_io_dis_uops_0_3_bits_exception),
    .io_dis_uops_3_bits_bypassable  (_dispatcher_io_dis_uops_0_3_bits_bypassable),
    .io_dis_uops_3_bits_mem_cmd     (_dispatcher_io_dis_uops_0_3_bits_mem_cmd),
    .io_dis_uops_3_bits_mem_size    (_dispatcher_io_dis_uops_0_3_bits_mem_size),
    .io_dis_uops_3_bits_mem_signed  (_dispatcher_io_dis_uops_0_3_bits_mem_signed),
    .io_dis_uops_3_bits_is_fence    (_dispatcher_io_dis_uops_0_3_bits_is_fence),
    .io_dis_uops_3_bits_is_fencei   (_dispatcher_io_dis_uops_0_3_bits_is_fencei),
    .io_dis_uops_3_bits_is_amo      (_dispatcher_io_dis_uops_0_3_bits_is_amo),
    .io_dis_uops_3_bits_uses_ldq    (_dispatcher_io_dis_uops_0_3_bits_uses_ldq),
    .io_dis_uops_3_bits_uses_stq    (_dispatcher_io_dis_uops_0_3_bits_uses_stq),
    .io_dis_uops_3_bits_ldst_val    (_dispatcher_io_dis_uops_0_3_bits_ldst_val),
    .io_dis_uops_3_bits_dst_rtype   (_dispatcher_io_dis_uops_0_3_bits_dst_rtype),
    .io_dis_uops_3_bits_lrs1_rtype  (_dispatcher_io_dis_uops_0_3_bits_lrs1_rtype),
    .io_dis_uops_3_bits_lrs2_rtype  (_dispatcher_io_dis_uops_0_3_bits_lrs2_rtype),
    .io_dis_uops_3_bits_fp_val      (_dispatcher_io_dis_uops_0_3_bits_fp_val),
    .io_wakeup_ports_0_valid        (int_iss_wakeups_0_valid),
    .io_wakeup_ports_0_bits_pdst    (_ll_wbarb_io_out_bits_uop_pdst),
    .io_wakeup_ports_1_valid        (int_iss_wakeups_1_valid),
    .io_wakeup_ports_1_bits_pdst    (_memExeUnit_1_io_ll_iresp_bits_uop_pdst),
    .io_wakeup_ports_2_valid        (fast_wakeup_valid),
    .io_wakeup_ports_2_bits_pdst    (_int_issue_unit_io_iss_uops_0_pdst),
    .io_wakeup_ports_3_valid        (slow_wakeup_valid),
    .io_wakeup_ports_3_bits_pdst    (_alu_exe_unit_io_iresp_bits_uop_pdst),
    .io_wakeup_ports_4_valid        (fast_wakeup_1_valid),
    .io_wakeup_ports_4_bits_pdst    (_int_issue_unit_io_iss_uops_1_pdst),
    .io_wakeup_ports_5_valid        (slow_wakeup_1_valid),
    .io_wakeup_ports_5_bits_pdst    (_alu_exe_unit_1_io_iresp_bits_uop_pdst),
    .io_wakeup_ports_6_valid        (fast_wakeup_2_valid),
    .io_wakeup_ports_6_bits_pdst    (_int_issue_unit_io_iss_uops_2_pdst),
    .io_wakeup_ports_7_valid        (slow_wakeup_2_valid),
    .io_wakeup_ports_7_bits_pdst    (_alu_exe_unit_2_io_iresp_bits_uop_pdst),
    .io_wakeup_ports_8_valid        (fast_wakeup_3_valid),
    .io_wakeup_ports_8_bits_pdst    (_int_issue_unit_io_iss_uops_3_pdst),
    .io_wakeup_ports_9_valid        (slow_wakeup_3_valid),
    .io_wakeup_ports_9_bits_pdst    (_alu_exe_unit_3_io_iresp_bits_uop_pdst),
    .io_spec_ld_wakeup_0_valid      (io_lsu_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_lsu_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_lsu_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_lsu_spec_ld_wakeup_1_bits),
    .io_fu_types_0                  ({7'h0, ~pause_mem, 2'h0}),
    .io_fu_types_1                  ({7'h0, ~pause_mem, 2'h0}),
    .io_brupdate_b1_resolve_mask    (_b1_resolve_mask_T_6),
    .io_brupdate_b1_mispredict_mask (_b1_mispredict_mask_T_10),
    .io_flush_pipeline              (mem_issue_unit_io_flush_pipeline_REG),
    .io_ld_miss                     (io_lsu_ld_miss),
    .io_dis_uops_0_ready            (_mem_issue_unit_io_dis_uops_0_ready),
    .io_dis_uops_1_ready            (_mem_issue_unit_io_dis_uops_1_ready),
    .io_dis_uops_2_ready            (_mem_issue_unit_io_dis_uops_2_ready),
    .io_dis_uops_3_ready            (_mem_issue_unit_io_dis_uops_3_ready),
    .io_iss_valids_0                (_mem_issue_unit_io_iss_valids_0),
    .io_iss_valids_1                (_mem_issue_unit_io_iss_valids_1),
    .io_iss_uops_0_uopc             (_mem_issue_unit_io_iss_uops_0_uopc),
    .io_iss_uops_0_fu_code          (_mem_issue_unit_io_iss_uops_0_fu_code),
    .io_iss_uops_0_iw_p1_poisoned   (_mem_issue_unit_io_iss_uops_0_iw_p1_poisoned),
    .io_iss_uops_0_iw_p2_poisoned   (_mem_issue_unit_io_iss_uops_0_iw_p2_poisoned),
    .io_iss_uops_0_br_mask          (_mem_issue_unit_io_iss_uops_0_br_mask),
    .io_iss_uops_0_imm_packed       (_mem_issue_unit_io_iss_uops_0_imm_packed),
    .io_iss_uops_0_rob_idx          (_mem_issue_unit_io_iss_uops_0_rob_idx),
    .io_iss_uops_0_ldq_idx          (_mem_issue_unit_io_iss_uops_0_ldq_idx),
    .io_iss_uops_0_stq_idx          (_mem_issue_unit_io_iss_uops_0_stq_idx),
    .io_iss_uops_0_pdst             (_mem_issue_unit_io_iss_uops_0_pdst),
    .io_iss_uops_0_prs1             (_mem_issue_unit_io_iss_uops_0_prs1),
    .io_iss_uops_0_prs2             (_mem_issue_unit_io_iss_uops_0_prs2),
    .io_iss_uops_0_mem_cmd          (_mem_issue_unit_io_iss_uops_0_mem_cmd),
    .io_iss_uops_0_mem_size         (_mem_issue_unit_io_iss_uops_0_mem_size),
    .io_iss_uops_0_mem_signed       (_mem_issue_unit_io_iss_uops_0_mem_signed),
    .io_iss_uops_0_is_fence         (_mem_issue_unit_io_iss_uops_0_is_fence),
    .io_iss_uops_0_is_amo           (_mem_issue_unit_io_iss_uops_0_is_amo),
    .io_iss_uops_0_uses_ldq         (_mem_issue_unit_io_iss_uops_0_uses_ldq),
    .io_iss_uops_0_uses_stq         (_mem_issue_unit_io_iss_uops_0_uses_stq),
    .io_iss_uops_0_lrs1_rtype       (_mem_issue_unit_io_iss_uops_0_lrs1_rtype),
    .io_iss_uops_0_lrs2_rtype       (_mem_issue_unit_io_iss_uops_0_lrs2_rtype),
    .io_iss_uops_0_fp_val           (_mem_issue_unit_io_iss_uops_0_fp_val),
    .io_iss_uops_1_uopc             (_mem_issue_unit_io_iss_uops_1_uopc),
    .io_iss_uops_1_fu_code          (_mem_issue_unit_io_iss_uops_1_fu_code),
    .io_iss_uops_1_iw_p1_poisoned   (_mem_issue_unit_io_iss_uops_1_iw_p1_poisoned),
    .io_iss_uops_1_iw_p2_poisoned   (_mem_issue_unit_io_iss_uops_1_iw_p2_poisoned),
    .io_iss_uops_1_br_mask          (_mem_issue_unit_io_iss_uops_1_br_mask),
    .io_iss_uops_1_imm_packed       (_mem_issue_unit_io_iss_uops_1_imm_packed),
    .io_iss_uops_1_rob_idx          (_mem_issue_unit_io_iss_uops_1_rob_idx),
    .io_iss_uops_1_ldq_idx          (_mem_issue_unit_io_iss_uops_1_ldq_idx),
    .io_iss_uops_1_stq_idx          (_mem_issue_unit_io_iss_uops_1_stq_idx),
    .io_iss_uops_1_pdst             (_mem_issue_unit_io_iss_uops_1_pdst),
    .io_iss_uops_1_prs1             (_mem_issue_unit_io_iss_uops_1_prs1),
    .io_iss_uops_1_prs2             (_mem_issue_unit_io_iss_uops_1_prs2),
    .io_iss_uops_1_mem_cmd          (_mem_issue_unit_io_iss_uops_1_mem_cmd),
    .io_iss_uops_1_mem_size         (_mem_issue_unit_io_iss_uops_1_mem_size),
    .io_iss_uops_1_mem_signed       (_mem_issue_unit_io_iss_uops_1_mem_signed),
    .io_iss_uops_1_is_fence         (_mem_issue_unit_io_iss_uops_1_is_fence),
    .io_iss_uops_1_is_amo           (_mem_issue_unit_io_iss_uops_1_is_amo),
    .io_iss_uops_1_uses_ldq         (_mem_issue_unit_io_iss_uops_1_uses_ldq),
    .io_iss_uops_1_uses_stq         (_mem_issue_unit_io_iss_uops_1_uses_stq),
    .io_iss_uops_1_lrs1_rtype       (_mem_issue_unit_io_iss_uops_1_lrs1_rtype),
    .io_iss_uops_1_lrs2_rtype       (_mem_issue_unit_io_iss_uops_1_lrs2_rtype),
    .io_iss_uops_1_fp_val           (_mem_issue_unit_io_iss_uops_1_fp_val)
  );
  IssueUnitCollapsing_2 int_issue_unit (
    .clock                          (clock),
    .reset                          (reset),
    .io_dis_uops_0_valid            (_dispatcher_io_dis_uops_1_0_valid),
    .io_dis_uops_0_bits_uopc        (_dispatcher_io_dis_uops_1_0_bits_uopc),
    .io_dis_uops_0_bits_is_rvc      (_dispatcher_io_dis_uops_1_0_bits_is_rvc),
    .io_dis_uops_0_bits_fu_code     (_dispatcher_io_dis_uops_1_0_bits_fu_code),
    .io_dis_uops_0_bits_is_br       (_dispatcher_io_dis_uops_1_0_bits_is_br),
    .io_dis_uops_0_bits_is_jalr     (_dispatcher_io_dis_uops_1_0_bits_is_jalr),
    .io_dis_uops_0_bits_is_jal      (_dispatcher_io_dis_uops_1_0_bits_is_jal),
    .io_dis_uops_0_bits_is_sfb      (_dispatcher_io_dis_uops_1_0_bits_is_sfb),
    .io_dis_uops_0_bits_br_mask     (_dispatcher_io_dis_uops_1_0_bits_br_mask),
    .io_dis_uops_0_bits_br_tag      (_dispatcher_io_dis_uops_1_0_bits_br_tag),
    .io_dis_uops_0_bits_ftq_idx     (_dispatcher_io_dis_uops_1_0_bits_ftq_idx),
    .io_dis_uops_0_bits_edge_inst   (_dispatcher_io_dis_uops_1_0_bits_edge_inst),
    .io_dis_uops_0_bits_pc_lob      (_dispatcher_io_dis_uops_1_0_bits_pc_lob),
    .io_dis_uops_0_bits_taken       (_dispatcher_io_dis_uops_1_0_bits_taken),
    .io_dis_uops_0_bits_imm_packed  (_dispatcher_io_dis_uops_1_0_bits_imm_packed),
    .io_dis_uops_0_bits_rob_idx     (_dispatcher_io_dis_uops_1_0_bits_rob_idx),
    .io_dis_uops_0_bits_ldq_idx     (_dispatcher_io_dis_uops_1_0_bits_ldq_idx),
    .io_dis_uops_0_bits_stq_idx     (_dispatcher_io_dis_uops_1_0_bits_stq_idx),
    .io_dis_uops_0_bits_pdst        (_dispatcher_io_dis_uops_1_0_bits_pdst),
    .io_dis_uops_0_bits_prs1        (_dispatcher_io_dis_uops_1_0_bits_prs1),
    .io_dis_uops_0_bits_prs2        (_dispatcher_io_dis_uops_1_0_bits_prs2),
    .io_dis_uops_0_bits_prs3        (_dispatcher_io_dis_uops_1_0_bits_prs3),
    .io_dis_uops_0_bits_prs1_busy   (_dispatcher_io_dis_uops_1_0_bits_prs1_busy),
    .io_dis_uops_0_bits_prs2_busy   (_dispatcher_io_dis_uops_1_0_bits_prs2_busy),
    .io_dis_uops_0_bits_exception   (_dispatcher_io_dis_uops_1_0_bits_exception),
    .io_dis_uops_0_bits_bypassable  (_dispatcher_io_dis_uops_1_0_bits_bypassable),
    .io_dis_uops_0_bits_mem_cmd     (_dispatcher_io_dis_uops_1_0_bits_mem_cmd),
    .io_dis_uops_0_bits_mem_size    (_dispatcher_io_dis_uops_1_0_bits_mem_size),
    .io_dis_uops_0_bits_mem_signed  (_dispatcher_io_dis_uops_1_0_bits_mem_signed),
    .io_dis_uops_0_bits_is_fence    (_dispatcher_io_dis_uops_1_0_bits_is_fence),
    .io_dis_uops_0_bits_is_fencei   (_dispatcher_io_dis_uops_1_0_bits_is_fencei),
    .io_dis_uops_0_bits_is_amo      (_dispatcher_io_dis_uops_1_0_bits_is_amo),
    .io_dis_uops_0_bits_uses_ldq    (_dispatcher_io_dis_uops_1_0_bits_uses_ldq),
    .io_dis_uops_0_bits_uses_stq    (_dispatcher_io_dis_uops_1_0_bits_uses_stq),
    .io_dis_uops_0_bits_ldst_val    (_dispatcher_io_dis_uops_1_0_bits_ldst_val),
    .io_dis_uops_0_bits_dst_rtype   (_dispatcher_io_dis_uops_1_0_bits_dst_rtype),
    .io_dis_uops_0_bits_lrs1_rtype  (_dispatcher_io_dis_uops_1_0_bits_lrs1_rtype),
    .io_dis_uops_0_bits_lrs2_rtype  (_dispatcher_io_dis_uops_1_0_bits_lrs2_rtype),
    .io_dis_uops_0_bits_fp_val      (_dispatcher_io_dis_uops_1_0_bits_fp_val),
    .io_dis_uops_1_valid            (_dispatcher_io_dis_uops_1_1_valid),
    .io_dis_uops_1_bits_uopc        (_dispatcher_io_dis_uops_1_1_bits_uopc),
    .io_dis_uops_1_bits_is_rvc      (_dispatcher_io_dis_uops_1_1_bits_is_rvc),
    .io_dis_uops_1_bits_fu_code     (_dispatcher_io_dis_uops_1_1_bits_fu_code),
    .io_dis_uops_1_bits_is_br       (_dispatcher_io_dis_uops_1_1_bits_is_br),
    .io_dis_uops_1_bits_is_jalr     (_dispatcher_io_dis_uops_1_1_bits_is_jalr),
    .io_dis_uops_1_bits_is_jal      (_dispatcher_io_dis_uops_1_1_bits_is_jal),
    .io_dis_uops_1_bits_is_sfb      (_dispatcher_io_dis_uops_1_1_bits_is_sfb),
    .io_dis_uops_1_bits_br_mask     (_dispatcher_io_dis_uops_1_1_bits_br_mask),
    .io_dis_uops_1_bits_br_tag      (_dispatcher_io_dis_uops_1_1_bits_br_tag),
    .io_dis_uops_1_bits_ftq_idx     (_dispatcher_io_dis_uops_1_1_bits_ftq_idx),
    .io_dis_uops_1_bits_edge_inst   (_dispatcher_io_dis_uops_1_1_bits_edge_inst),
    .io_dis_uops_1_bits_pc_lob      (_dispatcher_io_dis_uops_1_1_bits_pc_lob),
    .io_dis_uops_1_bits_taken       (_dispatcher_io_dis_uops_1_1_bits_taken),
    .io_dis_uops_1_bits_imm_packed  (_dispatcher_io_dis_uops_1_1_bits_imm_packed),
    .io_dis_uops_1_bits_rob_idx     (_dispatcher_io_dis_uops_1_1_bits_rob_idx),
    .io_dis_uops_1_bits_ldq_idx     (_dispatcher_io_dis_uops_1_1_bits_ldq_idx),
    .io_dis_uops_1_bits_stq_idx     (_dispatcher_io_dis_uops_1_1_bits_stq_idx),
    .io_dis_uops_1_bits_pdst        (_dispatcher_io_dis_uops_1_1_bits_pdst),
    .io_dis_uops_1_bits_prs1        (_dispatcher_io_dis_uops_1_1_bits_prs1),
    .io_dis_uops_1_bits_prs2        (_dispatcher_io_dis_uops_1_1_bits_prs2),
    .io_dis_uops_1_bits_prs3        (_dispatcher_io_dis_uops_1_1_bits_prs3),
    .io_dis_uops_1_bits_prs1_busy   (_dispatcher_io_dis_uops_1_1_bits_prs1_busy),
    .io_dis_uops_1_bits_prs2_busy   (_dispatcher_io_dis_uops_1_1_bits_prs2_busy),
    .io_dis_uops_1_bits_exception   (_dispatcher_io_dis_uops_1_1_bits_exception),
    .io_dis_uops_1_bits_bypassable  (_dispatcher_io_dis_uops_1_1_bits_bypassable),
    .io_dis_uops_1_bits_mem_cmd     (_dispatcher_io_dis_uops_1_1_bits_mem_cmd),
    .io_dis_uops_1_bits_mem_size    (_dispatcher_io_dis_uops_1_1_bits_mem_size),
    .io_dis_uops_1_bits_mem_signed  (_dispatcher_io_dis_uops_1_1_bits_mem_signed),
    .io_dis_uops_1_bits_is_fence    (_dispatcher_io_dis_uops_1_1_bits_is_fence),
    .io_dis_uops_1_bits_is_fencei   (_dispatcher_io_dis_uops_1_1_bits_is_fencei),
    .io_dis_uops_1_bits_is_amo      (_dispatcher_io_dis_uops_1_1_bits_is_amo),
    .io_dis_uops_1_bits_uses_ldq    (_dispatcher_io_dis_uops_1_1_bits_uses_ldq),
    .io_dis_uops_1_bits_uses_stq    (_dispatcher_io_dis_uops_1_1_bits_uses_stq),
    .io_dis_uops_1_bits_ldst_val    (_dispatcher_io_dis_uops_1_1_bits_ldst_val),
    .io_dis_uops_1_bits_dst_rtype   (_dispatcher_io_dis_uops_1_1_bits_dst_rtype),
    .io_dis_uops_1_bits_lrs1_rtype  (_dispatcher_io_dis_uops_1_1_bits_lrs1_rtype),
    .io_dis_uops_1_bits_lrs2_rtype  (_dispatcher_io_dis_uops_1_1_bits_lrs2_rtype),
    .io_dis_uops_1_bits_fp_val      (_dispatcher_io_dis_uops_1_1_bits_fp_val),
    .io_dis_uops_2_valid            (_dispatcher_io_dis_uops_1_2_valid),
    .io_dis_uops_2_bits_uopc        (_dispatcher_io_dis_uops_1_2_bits_uopc),
    .io_dis_uops_2_bits_is_rvc      (_dispatcher_io_dis_uops_1_2_bits_is_rvc),
    .io_dis_uops_2_bits_fu_code     (_dispatcher_io_dis_uops_1_2_bits_fu_code),
    .io_dis_uops_2_bits_is_br       (_dispatcher_io_dis_uops_1_2_bits_is_br),
    .io_dis_uops_2_bits_is_jalr     (_dispatcher_io_dis_uops_1_2_bits_is_jalr),
    .io_dis_uops_2_bits_is_jal      (_dispatcher_io_dis_uops_1_2_bits_is_jal),
    .io_dis_uops_2_bits_is_sfb      (_dispatcher_io_dis_uops_1_2_bits_is_sfb),
    .io_dis_uops_2_bits_br_mask     (_dispatcher_io_dis_uops_1_2_bits_br_mask),
    .io_dis_uops_2_bits_br_tag      (_dispatcher_io_dis_uops_1_2_bits_br_tag),
    .io_dis_uops_2_bits_ftq_idx     (_dispatcher_io_dis_uops_1_2_bits_ftq_idx),
    .io_dis_uops_2_bits_edge_inst   (_dispatcher_io_dis_uops_1_2_bits_edge_inst),
    .io_dis_uops_2_bits_pc_lob      (_dispatcher_io_dis_uops_1_2_bits_pc_lob),
    .io_dis_uops_2_bits_taken       (_dispatcher_io_dis_uops_1_2_bits_taken),
    .io_dis_uops_2_bits_imm_packed  (_dispatcher_io_dis_uops_1_2_bits_imm_packed),
    .io_dis_uops_2_bits_rob_idx     (_dispatcher_io_dis_uops_1_2_bits_rob_idx),
    .io_dis_uops_2_bits_ldq_idx     (_dispatcher_io_dis_uops_1_2_bits_ldq_idx),
    .io_dis_uops_2_bits_stq_idx     (_dispatcher_io_dis_uops_1_2_bits_stq_idx),
    .io_dis_uops_2_bits_pdst        (_dispatcher_io_dis_uops_1_2_bits_pdst),
    .io_dis_uops_2_bits_prs1        (_dispatcher_io_dis_uops_1_2_bits_prs1),
    .io_dis_uops_2_bits_prs2        (_dispatcher_io_dis_uops_1_2_bits_prs2),
    .io_dis_uops_2_bits_prs3        (_dispatcher_io_dis_uops_1_2_bits_prs3),
    .io_dis_uops_2_bits_prs1_busy   (_dispatcher_io_dis_uops_1_2_bits_prs1_busy),
    .io_dis_uops_2_bits_prs2_busy   (_dispatcher_io_dis_uops_1_2_bits_prs2_busy),
    .io_dis_uops_2_bits_exception   (_dispatcher_io_dis_uops_1_2_bits_exception),
    .io_dis_uops_2_bits_bypassable  (_dispatcher_io_dis_uops_1_2_bits_bypassable),
    .io_dis_uops_2_bits_mem_cmd     (_dispatcher_io_dis_uops_1_2_bits_mem_cmd),
    .io_dis_uops_2_bits_mem_size    (_dispatcher_io_dis_uops_1_2_bits_mem_size),
    .io_dis_uops_2_bits_mem_signed  (_dispatcher_io_dis_uops_1_2_bits_mem_signed),
    .io_dis_uops_2_bits_is_fence    (_dispatcher_io_dis_uops_1_2_bits_is_fence),
    .io_dis_uops_2_bits_is_fencei   (_dispatcher_io_dis_uops_1_2_bits_is_fencei),
    .io_dis_uops_2_bits_is_amo      (_dispatcher_io_dis_uops_1_2_bits_is_amo),
    .io_dis_uops_2_bits_uses_ldq    (_dispatcher_io_dis_uops_1_2_bits_uses_ldq),
    .io_dis_uops_2_bits_uses_stq    (_dispatcher_io_dis_uops_1_2_bits_uses_stq),
    .io_dis_uops_2_bits_ldst_val    (_dispatcher_io_dis_uops_1_2_bits_ldst_val),
    .io_dis_uops_2_bits_dst_rtype   (_dispatcher_io_dis_uops_1_2_bits_dst_rtype),
    .io_dis_uops_2_bits_lrs1_rtype  (_dispatcher_io_dis_uops_1_2_bits_lrs1_rtype),
    .io_dis_uops_2_bits_lrs2_rtype  (_dispatcher_io_dis_uops_1_2_bits_lrs2_rtype),
    .io_dis_uops_2_bits_fp_val      (_dispatcher_io_dis_uops_1_2_bits_fp_val),
    .io_dis_uops_3_valid            (_dispatcher_io_dis_uops_1_3_valid),
    .io_dis_uops_3_bits_uopc        (_dispatcher_io_dis_uops_1_3_bits_uopc),
    .io_dis_uops_3_bits_is_rvc      (_dispatcher_io_dis_uops_1_3_bits_is_rvc),
    .io_dis_uops_3_bits_fu_code     (_dispatcher_io_dis_uops_1_3_bits_fu_code),
    .io_dis_uops_3_bits_is_br       (_dispatcher_io_dis_uops_1_3_bits_is_br),
    .io_dis_uops_3_bits_is_jalr     (_dispatcher_io_dis_uops_1_3_bits_is_jalr),
    .io_dis_uops_3_bits_is_jal      (_dispatcher_io_dis_uops_1_3_bits_is_jal),
    .io_dis_uops_3_bits_is_sfb      (_dispatcher_io_dis_uops_1_3_bits_is_sfb),
    .io_dis_uops_3_bits_br_mask     (_dispatcher_io_dis_uops_1_3_bits_br_mask),
    .io_dis_uops_3_bits_br_tag      (_dispatcher_io_dis_uops_1_3_bits_br_tag),
    .io_dis_uops_3_bits_ftq_idx     (_dispatcher_io_dis_uops_1_3_bits_ftq_idx),
    .io_dis_uops_3_bits_edge_inst   (_dispatcher_io_dis_uops_1_3_bits_edge_inst),
    .io_dis_uops_3_bits_pc_lob      (_dispatcher_io_dis_uops_1_3_bits_pc_lob),
    .io_dis_uops_3_bits_taken       (_dispatcher_io_dis_uops_1_3_bits_taken),
    .io_dis_uops_3_bits_imm_packed  (_dispatcher_io_dis_uops_1_3_bits_imm_packed),
    .io_dis_uops_3_bits_rob_idx     (_dispatcher_io_dis_uops_1_3_bits_rob_idx),
    .io_dis_uops_3_bits_ldq_idx     (_dispatcher_io_dis_uops_1_3_bits_ldq_idx),
    .io_dis_uops_3_bits_stq_idx     (_dispatcher_io_dis_uops_1_3_bits_stq_idx),
    .io_dis_uops_3_bits_pdst        (_dispatcher_io_dis_uops_1_3_bits_pdst),
    .io_dis_uops_3_bits_prs1        (_dispatcher_io_dis_uops_1_3_bits_prs1),
    .io_dis_uops_3_bits_prs2        (_dispatcher_io_dis_uops_1_3_bits_prs2),
    .io_dis_uops_3_bits_prs3        (_dispatcher_io_dis_uops_1_3_bits_prs3),
    .io_dis_uops_3_bits_prs1_busy   (_dispatcher_io_dis_uops_1_3_bits_prs1_busy),
    .io_dis_uops_3_bits_prs2_busy   (_dispatcher_io_dis_uops_1_3_bits_prs2_busy),
    .io_dis_uops_3_bits_exception   (_dispatcher_io_dis_uops_1_3_bits_exception),
    .io_dis_uops_3_bits_bypassable  (_dispatcher_io_dis_uops_1_3_bits_bypassable),
    .io_dis_uops_3_bits_mem_cmd     (_dispatcher_io_dis_uops_1_3_bits_mem_cmd),
    .io_dis_uops_3_bits_mem_size    (_dispatcher_io_dis_uops_1_3_bits_mem_size),
    .io_dis_uops_3_bits_mem_signed  (_dispatcher_io_dis_uops_1_3_bits_mem_signed),
    .io_dis_uops_3_bits_is_fence    (_dispatcher_io_dis_uops_1_3_bits_is_fence),
    .io_dis_uops_3_bits_is_fencei   (_dispatcher_io_dis_uops_1_3_bits_is_fencei),
    .io_dis_uops_3_bits_is_amo      (_dispatcher_io_dis_uops_1_3_bits_is_amo),
    .io_dis_uops_3_bits_uses_ldq    (_dispatcher_io_dis_uops_1_3_bits_uses_ldq),
    .io_dis_uops_3_bits_uses_stq    (_dispatcher_io_dis_uops_1_3_bits_uses_stq),
    .io_dis_uops_3_bits_ldst_val    (_dispatcher_io_dis_uops_1_3_bits_ldst_val),
    .io_dis_uops_3_bits_dst_rtype   (_dispatcher_io_dis_uops_1_3_bits_dst_rtype),
    .io_dis_uops_3_bits_lrs1_rtype  (_dispatcher_io_dis_uops_1_3_bits_lrs1_rtype),
    .io_dis_uops_3_bits_lrs2_rtype  (_dispatcher_io_dis_uops_1_3_bits_lrs2_rtype),
    .io_dis_uops_3_bits_fp_val      (_dispatcher_io_dis_uops_1_3_bits_fp_val),
    .io_wakeup_ports_0_valid        (int_iss_wakeups_0_valid),
    .io_wakeup_ports_0_bits_pdst    (_ll_wbarb_io_out_bits_uop_pdst),
    .io_wakeup_ports_1_valid        (int_iss_wakeups_1_valid),
    .io_wakeup_ports_1_bits_pdst    (_memExeUnit_1_io_ll_iresp_bits_uop_pdst),
    .io_wakeup_ports_2_valid        (fast_wakeup_valid),
    .io_wakeup_ports_2_bits_pdst    (_int_issue_unit_io_iss_uops_0_pdst),
    .io_wakeup_ports_3_valid        (slow_wakeup_valid),
    .io_wakeup_ports_3_bits_pdst    (_alu_exe_unit_io_iresp_bits_uop_pdst),
    .io_wakeup_ports_4_valid        (fast_wakeup_1_valid),
    .io_wakeup_ports_4_bits_pdst    (_int_issue_unit_io_iss_uops_1_pdst),
    .io_wakeup_ports_5_valid        (slow_wakeup_1_valid),
    .io_wakeup_ports_5_bits_pdst    (_alu_exe_unit_1_io_iresp_bits_uop_pdst),
    .io_wakeup_ports_6_valid        (fast_wakeup_2_valid),
    .io_wakeup_ports_6_bits_pdst    (_int_issue_unit_io_iss_uops_2_pdst),
    .io_wakeup_ports_7_valid        (slow_wakeup_2_valid),
    .io_wakeup_ports_7_bits_pdst    (_alu_exe_unit_2_io_iresp_bits_uop_pdst),
    .io_wakeup_ports_8_valid        (fast_wakeup_3_valid),
    .io_wakeup_ports_8_bits_pdst    (_int_issue_unit_io_iss_uops_3_pdst),
    .io_wakeup_ports_9_valid        (slow_wakeup_3_valid),
    .io_wakeup_ports_9_bits_pdst    (_alu_exe_unit_3_io_iresp_bits_uop_pdst),
    .io_spec_ld_wakeup_0_valid      (io_lsu_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits       (io_lsu_spec_ld_wakeup_0_bits),
    .io_spec_ld_wakeup_1_valid      (io_lsu_spec_ld_wakeup_1_valid),
    .io_spec_ld_wakeup_1_bits       (io_lsu_spec_ld_wakeup_1_bits),
    .io_fu_types_0                  (_alu_exe_unit_io_fu_types),
    .io_fu_types_2                  (REG_5 & 10'h9),
    .io_fu_types_3                  (_alu_exe_unit_3_io_fu_types & REG_6),
    .io_brupdate_b1_resolve_mask    (_b1_resolve_mask_T_6),
    .io_brupdate_b1_mispredict_mask (_b1_mispredict_mask_T_10),
    .io_flush_pipeline              (int_issue_unit_io_flush_pipeline_REG),
    .io_ld_miss                     (io_lsu_ld_miss),
    .io_dis_uops_0_ready            (_int_issue_unit_io_dis_uops_0_ready),
    .io_dis_uops_1_ready            (_int_issue_unit_io_dis_uops_1_ready),
    .io_dis_uops_2_ready            (_int_issue_unit_io_dis_uops_2_ready),
    .io_dis_uops_3_ready            (_int_issue_unit_io_dis_uops_3_ready),
    .io_iss_valids_0                (_int_issue_unit_io_iss_valids_0),
    .io_iss_valids_1                (_int_issue_unit_io_iss_valids_1),
    .io_iss_valids_2                (_int_issue_unit_io_iss_valids_2),
    .io_iss_valids_3                (_int_issue_unit_io_iss_valids_3),
    .io_iss_uops_0_uopc             (_int_issue_unit_io_iss_uops_0_uopc),
    .io_iss_uops_0_is_rvc           (_int_issue_unit_io_iss_uops_0_is_rvc),
    .io_iss_uops_0_fu_code          (_int_issue_unit_io_iss_uops_0_fu_code),
    .io_iss_uops_0_iw_p1_poisoned   (_int_issue_unit_io_iss_uops_0_iw_p1_poisoned),
    .io_iss_uops_0_iw_p2_poisoned   (_int_issue_unit_io_iss_uops_0_iw_p2_poisoned),
    .io_iss_uops_0_is_br            (_int_issue_unit_io_iss_uops_0_is_br),
    .io_iss_uops_0_is_jalr          (_int_issue_unit_io_iss_uops_0_is_jalr),
    .io_iss_uops_0_is_jal           (_int_issue_unit_io_iss_uops_0_is_jal),
    .io_iss_uops_0_is_sfb           (_int_issue_unit_io_iss_uops_0_is_sfb),
    .io_iss_uops_0_br_mask          (_int_issue_unit_io_iss_uops_0_br_mask),
    .io_iss_uops_0_br_tag           (_int_issue_unit_io_iss_uops_0_br_tag),
    .io_iss_uops_0_ftq_idx          (_int_issue_unit_io_iss_uops_0_ftq_idx),
    .io_iss_uops_0_edge_inst        (_int_issue_unit_io_iss_uops_0_edge_inst),
    .io_iss_uops_0_pc_lob           (_int_issue_unit_io_iss_uops_0_pc_lob),
    .io_iss_uops_0_taken            (_int_issue_unit_io_iss_uops_0_taken),
    .io_iss_uops_0_imm_packed       (_int_issue_unit_io_iss_uops_0_imm_packed),
    .io_iss_uops_0_rob_idx          (_int_issue_unit_io_iss_uops_0_rob_idx),
    .io_iss_uops_0_ldq_idx          (_int_issue_unit_io_iss_uops_0_ldq_idx),
    .io_iss_uops_0_stq_idx          (_int_issue_unit_io_iss_uops_0_stq_idx),
    .io_iss_uops_0_pdst             (_int_issue_unit_io_iss_uops_0_pdst),
    .io_iss_uops_0_prs1             (_int_issue_unit_io_iss_uops_0_prs1),
    .io_iss_uops_0_prs2             (_int_issue_unit_io_iss_uops_0_prs2),
    .io_iss_uops_0_bypassable       (_int_issue_unit_io_iss_uops_0_bypassable),
    .io_iss_uops_0_mem_cmd          (_int_issue_unit_io_iss_uops_0_mem_cmd),
    .io_iss_uops_0_is_amo           (_int_issue_unit_io_iss_uops_0_is_amo),
    .io_iss_uops_0_uses_stq         (_int_issue_unit_io_iss_uops_0_uses_stq),
    .io_iss_uops_0_ldst_val         (_int_issue_unit_io_iss_uops_0_ldst_val),
    .io_iss_uops_0_dst_rtype        (_int_issue_unit_io_iss_uops_0_dst_rtype),
    .io_iss_uops_0_lrs1_rtype       (_int_issue_unit_io_iss_uops_0_lrs1_rtype),
    .io_iss_uops_0_lrs2_rtype       (_int_issue_unit_io_iss_uops_0_lrs2_rtype),
    .io_iss_uops_0_fp_val           (_int_issue_unit_io_iss_uops_0_fp_val),
    .io_iss_uops_1_uopc             (_int_issue_unit_io_iss_uops_1_uopc),
    .io_iss_uops_1_is_rvc           (_int_issue_unit_io_iss_uops_1_is_rvc),
    .io_iss_uops_1_fu_code          (_int_issue_unit_io_iss_uops_1_fu_code),
    .io_iss_uops_1_iw_p1_poisoned   (_int_issue_unit_io_iss_uops_1_iw_p1_poisoned),
    .io_iss_uops_1_iw_p2_poisoned   (_int_issue_unit_io_iss_uops_1_iw_p2_poisoned),
    .io_iss_uops_1_is_br            (_int_issue_unit_io_iss_uops_1_is_br),
    .io_iss_uops_1_is_jalr          (_int_issue_unit_io_iss_uops_1_is_jalr),
    .io_iss_uops_1_is_jal           (_int_issue_unit_io_iss_uops_1_is_jal),
    .io_iss_uops_1_is_sfb           (_int_issue_unit_io_iss_uops_1_is_sfb),
    .io_iss_uops_1_br_mask          (_int_issue_unit_io_iss_uops_1_br_mask),
    .io_iss_uops_1_br_tag           (_int_issue_unit_io_iss_uops_1_br_tag),
    .io_iss_uops_1_ftq_idx          (_int_issue_unit_io_iss_uops_1_ftq_idx),
    .io_iss_uops_1_edge_inst        (_int_issue_unit_io_iss_uops_1_edge_inst),
    .io_iss_uops_1_pc_lob           (_int_issue_unit_io_iss_uops_1_pc_lob),
    .io_iss_uops_1_taken            (_int_issue_unit_io_iss_uops_1_taken),
    .io_iss_uops_1_imm_packed       (_int_issue_unit_io_iss_uops_1_imm_packed),
    .io_iss_uops_1_rob_idx          (_int_issue_unit_io_iss_uops_1_rob_idx),
    .io_iss_uops_1_ldq_idx          (_int_issue_unit_io_iss_uops_1_ldq_idx),
    .io_iss_uops_1_stq_idx          (_int_issue_unit_io_iss_uops_1_stq_idx),
    .io_iss_uops_1_pdst             (_int_issue_unit_io_iss_uops_1_pdst),
    .io_iss_uops_1_prs1             (_int_issue_unit_io_iss_uops_1_prs1),
    .io_iss_uops_1_prs2             (_int_issue_unit_io_iss_uops_1_prs2),
    .io_iss_uops_1_bypassable       (_int_issue_unit_io_iss_uops_1_bypassable),
    .io_iss_uops_1_mem_cmd          (_int_issue_unit_io_iss_uops_1_mem_cmd),
    .io_iss_uops_1_is_amo           (_int_issue_unit_io_iss_uops_1_is_amo),
    .io_iss_uops_1_uses_stq         (_int_issue_unit_io_iss_uops_1_uses_stq),
    .io_iss_uops_1_ldst_val         (_int_issue_unit_io_iss_uops_1_ldst_val),
    .io_iss_uops_1_dst_rtype        (_int_issue_unit_io_iss_uops_1_dst_rtype),
    .io_iss_uops_1_lrs1_rtype       (_int_issue_unit_io_iss_uops_1_lrs1_rtype),
    .io_iss_uops_1_lrs2_rtype       (_int_issue_unit_io_iss_uops_1_lrs2_rtype),
    .io_iss_uops_2_uopc             (_int_issue_unit_io_iss_uops_2_uopc),
    .io_iss_uops_2_is_rvc           (_int_issue_unit_io_iss_uops_2_is_rvc),
    .io_iss_uops_2_fu_code          (_int_issue_unit_io_iss_uops_2_fu_code),
    .io_iss_uops_2_iw_p1_poisoned   (_int_issue_unit_io_iss_uops_2_iw_p1_poisoned),
    .io_iss_uops_2_iw_p2_poisoned   (_int_issue_unit_io_iss_uops_2_iw_p2_poisoned),
    .io_iss_uops_2_is_br            (_int_issue_unit_io_iss_uops_2_is_br),
    .io_iss_uops_2_is_jalr          (_int_issue_unit_io_iss_uops_2_is_jalr),
    .io_iss_uops_2_is_jal           (_int_issue_unit_io_iss_uops_2_is_jal),
    .io_iss_uops_2_is_sfb           (_int_issue_unit_io_iss_uops_2_is_sfb),
    .io_iss_uops_2_br_mask          (_int_issue_unit_io_iss_uops_2_br_mask),
    .io_iss_uops_2_br_tag           (_int_issue_unit_io_iss_uops_2_br_tag),
    .io_iss_uops_2_ftq_idx          (_int_issue_unit_io_iss_uops_2_ftq_idx),
    .io_iss_uops_2_edge_inst        (_int_issue_unit_io_iss_uops_2_edge_inst),
    .io_iss_uops_2_pc_lob           (_int_issue_unit_io_iss_uops_2_pc_lob),
    .io_iss_uops_2_taken            (_int_issue_unit_io_iss_uops_2_taken),
    .io_iss_uops_2_imm_packed       (_int_issue_unit_io_iss_uops_2_imm_packed),
    .io_iss_uops_2_rob_idx          (_int_issue_unit_io_iss_uops_2_rob_idx),
    .io_iss_uops_2_ldq_idx          (_int_issue_unit_io_iss_uops_2_ldq_idx),
    .io_iss_uops_2_stq_idx          (_int_issue_unit_io_iss_uops_2_stq_idx),
    .io_iss_uops_2_pdst             (_int_issue_unit_io_iss_uops_2_pdst),
    .io_iss_uops_2_prs1             (_int_issue_unit_io_iss_uops_2_prs1),
    .io_iss_uops_2_prs2             (_int_issue_unit_io_iss_uops_2_prs2),
    .io_iss_uops_2_bypassable       (_int_issue_unit_io_iss_uops_2_bypassable),
    .io_iss_uops_2_mem_cmd          (_int_issue_unit_io_iss_uops_2_mem_cmd),
    .io_iss_uops_2_is_amo           (_int_issue_unit_io_iss_uops_2_is_amo),
    .io_iss_uops_2_uses_stq         (_int_issue_unit_io_iss_uops_2_uses_stq),
    .io_iss_uops_2_ldst_val         (_int_issue_unit_io_iss_uops_2_ldst_val),
    .io_iss_uops_2_dst_rtype        (_int_issue_unit_io_iss_uops_2_dst_rtype),
    .io_iss_uops_2_lrs1_rtype       (_int_issue_unit_io_iss_uops_2_lrs1_rtype),
    .io_iss_uops_2_lrs2_rtype       (_int_issue_unit_io_iss_uops_2_lrs2_rtype),
    .io_iss_uops_3_uopc             (_int_issue_unit_io_iss_uops_3_uopc),
    .io_iss_uops_3_is_rvc           (_int_issue_unit_io_iss_uops_3_is_rvc),
    .io_iss_uops_3_fu_code          (_int_issue_unit_io_iss_uops_3_fu_code),
    .io_iss_uops_3_iw_p1_poisoned   (_int_issue_unit_io_iss_uops_3_iw_p1_poisoned),
    .io_iss_uops_3_iw_p2_poisoned   (_int_issue_unit_io_iss_uops_3_iw_p2_poisoned),
    .io_iss_uops_3_is_br            (_int_issue_unit_io_iss_uops_3_is_br),
    .io_iss_uops_3_is_jalr          (_int_issue_unit_io_iss_uops_3_is_jalr),
    .io_iss_uops_3_is_jal           (_int_issue_unit_io_iss_uops_3_is_jal),
    .io_iss_uops_3_is_sfb           (_int_issue_unit_io_iss_uops_3_is_sfb),
    .io_iss_uops_3_br_mask          (_int_issue_unit_io_iss_uops_3_br_mask),
    .io_iss_uops_3_br_tag           (_int_issue_unit_io_iss_uops_3_br_tag),
    .io_iss_uops_3_ftq_idx          (_int_issue_unit_io_iss_uops_3_ftq_idx),
    .io_iss_uops_3_edge_inst        (_int_issue_unit_io_iss_uops_3_edge_inst),
    .io_iss_uops_3_pc_lob           (_int_issue_unit_io_iss_uops_3_pc_lob),
    .io_iss_uops_3_taken            (_int_issue_unit_io_iss_uops_3_taken),
    .io_iss_uops_3_imm_packed       (_int_issue_unit_io_iss_uops_3_imm_packed),
    .io_iss_uops_3_rob_idx          (_int_issue_unit_io_iss_uops_3_rob_idx),
    .io_iss_uops_3_ldq_idx          (_int_issue_unit_io_iss_uops_3_ldq_idx),
    .io_iss_uops_3_stq_idx          (_int_issue_unit_io_iss_uops_3_stq_idx),
    .io_iss_uops_3_pdst             (_int_issue_unit_io_iss_uops_3_pdst),
    .io_iss_uops_3_prs1             (_int_issue_unit_io_iss_uops_3_prs1),
    .io_iss_uops_3_prs2             (_int_issue_unit_io_iss_uops_3_prs2),
    .io_iss_uops_3_bypassable       (_int_issue_unit_io_iss_uops_3_bypassable),
    .io_iss_uops_3_mem_cmd          (_int_issue_unit_io_iss_uops_3_mem_cmd),
    .io_iss_uops_3_is_amo           (_int_issue_unit_io_iss_uops_3_is_amo),
    .io_iss_uops_3_uses_stq         (_int_issue_unit_io_iss_uops_3_uses_stq),
    .io_iss_uops_3_ldst_val         (_int_issue_unit_io_iss_uops_3_ldst_val),
    .io_iss_uops_3_dst_rtype        (_int_issue_unit_io_iss_uops_3_dst_rtype),
    .io_iss_uops_3_lrs1_rtype       (_int_issue_unit_io_iss_uops_3_lrs1_rtype),
    .io_iss_uops_3_lrs2_rtype       (_int_issue_unit_io_iss_uops_3_lrs2_rtype)
  );
  BasicDispatcher dispatcher (
    .io_ren_uops_0_valid             (dis_fire_0),
    .io_ren_uops_0_bits_uopc         (_rename_stage_io_ren2_uops_0_uopc),
    .io_ren_uops_0_bits_is_rvc       (_rename_stage_io_ren2_uops_0_is_rvc),
    .io_ren_uops_0_bits_iq_type      (_rename_stage_io_ren2_uops_0_iq_type),
    .io_ren_uops_0_bits_fu_code      (_rename_stage_io_ren2_uops_0_fu_code),
    .io_ren_uops_0_bits_is_br        (_rename_stage_io_ren2_uops_0_is_br),
    .io_ren_uops_0_bits_is_jalr      (_rename_stage_io_ren2_uops_0_is_jalr),
    .io_ren_uops_0_bits_is_jal       (_rename_stage_io_ren2_uops_0_is_jal),
    .io_ren_uops_0_bits_is_sfb       (_rename_stage_io_ren2_uops_0_is_sfb),
    .io_ren_uops_0_bits_br_mask      (_rename_stage_io_ren2_uops_0_br_mask),
    .io_ren_uops_0_bits_br_tag       (_rename_stage_io_ren2_uops_0_br_tag),
    .io_ren_uops_0_bits_ftq_idx      (_rename_stage_io_ren2_uops_0_ftq_idx),
    .io_ren_uops_0_bits_edge_inst    (_rename_stage_io_ren2_uops_0_edge_inst),
    .io_ren_uops_0_bits_pc_lob       (_rename_stage_io_ren2_uops_0_pc_lob),
    .io_ren_uops_0_bits_taken        (_rename_stage_io_ren2_uops_0_taken),
    .io_ren_uops_0_bits_imm_packed   (_rename_stage_io_ren2_uops_0_imm_packed),
    .io_ren_uops_0_bits_rob_idx      (dis_uops_0_rob_idx),
    .io_ren_uops_0_bits_ldq_idx      (io_lsu_dis_ldq_idx_0),
    .io_ren_uops_0_bits_stq_idx      (io_lsu_dis_stq_idx_0),
    .io_ren_uops_0_bits_pdst         (dis_uops_0_pdst),
    .io_ren_uops_0_bits_prs1         (_dis_uops_0_prs1_busy_T_2 ? _fp_rename_stage_io_ren2_uops_0_prs1 : _dis_uops_0_prs1_busy_T ? _rename_stage_io_ren2_uops_0_prs1 : {1'h0, _rename_stage_io_ren2_uops_0_lrs1}),
    .io_ren_uops_0_bits_prs2         (_dis_uops_0_prs2_busy_T_2 ? _fp_rename_stage_io_ren2_uops_0_prs2 : _rename_stage_io_ren2_uops_0_prs2),
    .io_ren_uops_0_bits_prs3         (_fp_rename_stage_io_ren2_uops_0_prs3),
    .io_ren_uops_0_bits_prs1_busy    (_rename_stage_io_ren2_uops_0_prs1_busy & _dis_uops_0_prs1_busy_T | _fp_rename_stage_io_ren2_uops_0_prs1_busy & _dis_uops_0_prs1_busy_T_2),
    .io_ren_uops_0_bits_prs2_busy    (_rename_stage_io_ren2_uops_0_prs2_busy & _rename_stage_io_ren2_uops_0_lrs2_rtype == 2'h0 | _fp_rename_stage_io_ren2_uops_0_prs2_busy & _dis_uops_0_prs2_busy_T_2),
    .io_ren_uops_0_bits_prs3_busy    (_fp_rename_stage_io_ren2_uops_0_prs3_busy & _rename_stage_io_ren2_uops_0_frs3_en),
    .io_ren_uops_0_bits_exception    (_rename_stage_io_ren2_uops_0_exception),
    .io_ren_uops_0_bits_bypassable   (_rename_stage_io_ren2_uops_0_bypassable),
    .io_ren_uops_0_bits_mem_cmd      (_rename_stage_io_ren2_uops_0_mem_cmd),
    .io_ren_uops_0_bits_mem_size     (_rename_stage_io_ren2_uops_0_mem_size),
    .io_ren_uops_0_bits_mem_signed   (_rename_stage_io_ren2_uops_0_mem_signed),
    .io_ren_uops_0_bits_is_fence     (_rename_stage_io_ren2_uops_0_is_fence),
    .io_ren_uops_0_bits_is_fencei    (_rename_stage_io_ren2_uops_0_is_fencei),
    .io_ren_uops_0_bits_is_amo       (_rename_stage_io_ren2_uops_0_is_amo),
    .io_ren_uops_0_bits_uses_ldq     (_rename_stage_io_ren2_uops_0_uses_ldq),
    .io_ren_uops_0_bits_uses_stq     (_rename_stage_io_ren2_uops_0_uses_stq),
    .io_ren_uops_0_bits_ldst_val     (_rename_stage_io_ren2_uops_0_ldst_val),
    .io_ren_uops_0_bits_dst_rtype    (_rename_stage_io_ren2_uops_0_dst_rtype),
    .io_ren_uops_0_bits_lrs1_rtype   (_rename_stage_io_ren2_uops_0_lrs1_rtype),
    .io_ren_uops_0_bits_lrs2_rtype   (_rename_stage_io_ren2_uops_0_lrs2_rtype),
    .io_ren_uops_0_bits_fp_val       (_rename_stage_io_ren2_uops_0_fp_val),
    .io_ren_uops_1_valid             (dis_fire_1),
    .io_ren_uops_1_bits_uopc         (_rename_stage_io_ren2_uops_1_uopc),
    .io_ren_uops_1_bits_is_rvc       (_rename_stage_io_ren2_uops_1_is_rvc),
    .io_ren_uops_1_bits_iq_type      (_rename_stage_io_ren2_uops_1_iq_type),
    .io_ren_uops_1_bits_fu_code      (_rename_stage_io_ren2_uops_1_fu_code),
    .io_ren_uops_1_bits_is_br        (_rename_stage_io_ren2_uops_1_is_br),
    .io_ren_uops_1_bits_is_jalr      (_rename_stage_io_ren2_uops_1_is_jalr),
    .io_ren_uops_1_bits_is_jal       (_rename_stage_io_ren2_uops_1_is_jal),
    .io_ren_uops_1_bits_is_sfb       (_rename_stage_io_ren2_uops_1_is_sfb),
    .io_ren_uops_1_bits_br_mask      (_rename_stage_io_ren2_uops_1_br_mask),
    .io_ren_uops_1_bits_br_tag       (_rename_stage_io_ren2_uops_1_br_tag),
    .io_ren_uops_1_bits_ftq_idx      (_rename_stage_io_ren2_uops_1_ftq_idx),
    .io_ren_uops_1_bits_edge_inst    (_rename_stage_io_ren2_uops_1_edge_inst),
    .io_ren_uops_1_bits_pc_lob       (_rename_stage_io_ren2_uops_1_pc_lob),
    .io_ren_uops_1_bits_taken        (_rename_stage_io_ren2_uops_1_taken),
    .io_ren_uops_1_bits_imm_packed   (_rename_stage_io_ren2_uops_1_imm_packed),
    .io_ren_uops_1_bits_rob_idx      (dis_uops_1_rob_idx),
    .io_ren_uops_1_bits_ldq_idx      (io_lsu_dis_ldq_idx_1),
    .io_ren_uops_1_bits_stq_idx      (io_lsu_dis_stq_idx_1),
    .io_ren_uops_1_bits_pdst         (dis_uops_1_pdst),
    .io_ren_uops_1_bits_prs1         (_dis_uops_1_prs1_busy_T_2 ? _fp_rename_stage_io_ren2_uops_1_prs1 : _dis_uops_1_prs1_busy_T ? _rename_stage_io_ren2_uops_1_prs1 : {1'h0, _rename_stage_io_ren2_uops_1_lrs1}),
    .io_ren_uops_1_bits_prs2         (_dis_uops_1_prs2_busy_T_2 ? _fp_rename_stage_io_ren2_uops_1_prs2 : _rename_stage_io_ren2_uops_1_prs2),
    .io_ren_uops_1_bits_prs3         (_fp_rename_stage_io_ren2_uops_1_prs3),
    .io_ren_uops_1_bits_prs1_busy    (_rename_stage_io_ren2_uops_1_prs1_busy & _dis_uops_1_prs1_busy_T | _fp_rename_stage_io_ren2_uops_1_prs1_busy & _dis_uops_1_prs1_busy_T_2),
    .io_ren_uops_1_bits_prs2_busy    (_rename_stage_io_ren2_uops_1_prs2_busy & _rename_stage_io_ren2_uops_1_lrs2_rtype == 2'h0 | _fp_rename_stage_io_ren2_uops_1_prs2_busy & _dis_uops_1_prs2_busy_T_2),
    .io_ren_uops_1_bits_prs3_busy    (_fp_rename_stage_io_ren2_uops_1_prs3_busy & _rename_stage_io_ren2_uops_1_frs3_en),
    .io_ren_uops_1_bits_exception    (_rename_stage_io_ren2_uops_1_exception),
    .io_ren_uops_1_bits_bypassable   (_rename_stage_io_ren2_uops_1_bypassable),
    .io_ren_uops_1_bits_mem_cmd      (_rename_stage_io_ren2_uops_1_mem_cmd),
    .io_ren_uops_1_bits_mem_size     (_rename_stage_io_ren2_uops_1_mem_size),
    .io_ren_uops_1_bits_mem_signed   (_rename_stage_io_ren2_uops_1_mem_signed),
    .io_ren_uops_1_bits_is_fence     (_rename_stage_io_ren2_uops_1_is_fence),
    .io_ren_uops_1_bits_is_fencei    (_rename_stage_io_ren2_uops_1_is_fencei),
    .io_ren_uops_1_bits_is_amo       (_rename_stage_io_ren2_uops_1_is_amo),
    .io_ren_uops_1_bits_uses_ldq     (_rename_stage_io_ren2_uops_1_uses_ldq),
    .io_ren_uops_1_bits_uses_stq     (_rename_stage_io_ren2_uops_1_uses_stq),
    .io_ren_uops_1_bits_ldst_val     (_rename_stage_io_ren2_uops_1_ldst_val),
    .io_ren_uops_1_bits_dst_rtype    (_rename_stage_io_ren2_uops_1_dst_rtype),
    .io_ren_uops_1_bits_lrs1_rtype   (_rename_stage_io_ren2_uops_1_lrs1_rtype),
    .io_ren_uops_1_bits_lrs2_rtype   (_rename_stage_io_ren2_uops_1_lrs2_rtype),
    .io_ren_uops_1_bits_fp_val       (_rename_stage_io_ren2_uops_1_fp_val),
    .io_ren_uops_2_valid             (dis_fire_2),
    .io_ren_uops_2_bits_uopc         (_rename_stage_io_ren2_uops_2_uopc),
    .io_ren_uops_2_bits_is_rvc       (_rename_stage_io_ren2_uops_2_is_rvc),
    .io_ren_uops_2_bits_iq_type      (_rename_stage_io_ren2_uops_2_iq_type),
    .io_ren_uops_2_bits_fu_code      (_rename_stage_io_ren2_uops_2_fu_code),
    .io_ren_uops_2_bits_is_br        (_rename_stage_io_ren2_uops_2_is_br),
    .io_ren_uops_2_bits_is_jalr      (_rename_stage_io_ren2_uops_2_is_jalr),
    .io_ren_uops_2_bits_is_jal       (_rename_stage_io_ren2_uops_2_is_jal),
    .io_ren_uops_2_bits_is_sfb       (_rename_stage_io_ren2_uops_2_is_sfb),
    .io_ren_uops_2_bits_br_mask      (_rename_stage_io_ren2_uops_2_br_mask),
    .io_ren_uops_2_bits_br_tag       (_rename_stage_io_ren2_uops_2_br_tag),
    .io_ren_uops_2_bits_ftq_idx      (_rename_stage_io_ren2_uops_2_ftq_idx),
    .io_ren_uops_2_bits_edge_inst    (_rename_stage_io_ren2_uops_2_edge_inst),
    .io_ren_uops_2_bits_pc_lob       (_rename_stage_io_ren2_uops_2_pc_lob),
    .io_ren_uops_2_bits_taken        (_rename_stage_io_ren2_uops_2_taken),
    .io_ren_uops_2_bits_imm_packed   (_rename_stage_io_ren2_uops_2_imm_packed),
    .io_ren_uops_2_bits_rob_idx      (dis_uops_2_rob_idx),
    .io_ren_uops_2_bits_ldq_idx      (io_lsu_dis_ldq_idx_2),
    .io_ren_uops_2_bits_stq_idx      (io_lsu_dis_stq_idx_2),
    .io_ren_uops_2_bits_pdst         (dis_uops_2_pdst),
    .io_ren_uops_2_bits_prs1         (_dis_uops_2_prs1_busy_T_2 ? _fp_rename_stage_io_ren2_uops_2_prs1 : _dis_uops_2_prs1_busy_T ? _rename_stage_io_ren2_uops_2_prs1 : {1'h0, _rename_stage_io_ren2_uops_2_lrs1}),
    .io_ren_uops_2_bits_prs2         (_dis_uops_2_prs2_busy_T_2 ? _fp_rename_stage_io_ren2_uops_2_prs2 : _rename_stage_io_ren2_uops_2_prs2),
    .io_ren_uops_2_bits_prs3         (_fp_rename_stage_io_ren2_uops_2_prs3),
    .io_ren_uops_2_bits_prs1_busy    (_rename_stage_io_ren2_uops_2_prs1_busy & _dis_uops_2_prs1_busy_T | _fp_rename_stage_io_ren2_uops_2_prs1_busy & _dis_uops_2_prs1_busy_T_2),
    .io_ren_uops_2_bits_prs2_busy    (_rename_stage_io_ren2_uops_2_prs2_busy & _rename_stage_io_ren2_uops_2_lrs2_rtype == 2'h0 | _fp_rename_stage_io_ren2_uops_2_prs2_busy & _dis_uops_2_prs2_busy_T_2),
    .io_ren_uops_2_bits_prs3_busy    (_fp_rename_stage_io_ren2_uops_2_prs3_busy & _rename_stage_io_ren2_uops_2_frs3_en),
    .io_ren_uops_2_bits_exception    (_rename_stage_io_ren2_uops_2_exception),
    .io_ren_uops_2_bits_bypassable   (_rename_stage_io_ren2_uops_2_bypassable),
    .io_ren_uops_2_bits_mem_cmd      (_rename_stage_io_ren2_uops_2_mem_cmd),
    .io_ren_uops_2_bits_mem_size     (_rename_stage_io_ren2_uops_2_mem_size),
    .io_ren_uops_2_bits_mem_signed   (_rename_stage_io_ren2_uops_2_mem_signed),
    .io_ren_uops_2_bits_is_fence     (_rename_stage_io_ren2_uops_2_is_fence),
    .io_ren_uops_2_bits_is_fencei    (_rename_stage_io_ren2_uops_2_is_fencei),
    .io_ren_uops_2_bits_is_amo       (_rename_stage_io_ren2_uops_2_is_amo),
    .io_ren_uops_2_bits_uses_ldq     (_rename_stage_io_ren2_uops_2_uses_ldq),
    .io_ren_uops_2_bits_uses_stq     (_rename_stage_io_ren2_uops_2_uses_stq),
    .io_ren_uops_2_bits_ldst_val     (_rename_stage_io_ren2_uops_2_ldst_val),
    .io_ren_uops_2_bits_dst_rtype    (_rename_stage_io_ren2_uops_2_dst_rtype),
    .io_ren_uops_2_bits_lrs1_rtype   (_rename_stage_io_ren2_uops_2_lrs1_rtype),
    .io_ren_uops_2_bits_lrs2_rtype   (_rename_stage_io_ren2_uops_2_lrs2_rtype),
    .io_ren_uops_2_bits_fp_val       (_rename_stage_io_ren2_uops_2_fp_val),
    .io_ren_uops_3_valid             (dis_fire_3),
    .io_ren_uops_3_bits_uopc         (_rename_stage_io_ren2_uops_3_uopc),
    .io_ren_uops_3_bits_is_rvc       (_rename_stage_io_ren2_uops_3_is_rvc),
    .io_ren_uops_3_bits_iq_type      (_rename_stage_io_ren2_uops_3_iq_type),
    .io_ren_uops_3_bits_fu_code      (_rename_stage_io_ren2_uops_3_fu_code),
    .io_ren_uops_3_bits_is_br        (_rename_stage_io_ren2_uops_3_is_br),
    .io_ren_uops_3_bits_is_jalr      (_rename_stage_io_ren2_uops_3_is_jalr),
    .io_ren_uops_3_bits_is_jal       (_rename_stage_io_ren2_uops_3_is_jal),
    .io_ren_uops_3_bits_is_sfb       (_rename_stage_io_ren2_uops_3_is_sfb),
    .io_ren_uops_3_bits_br_mask      (_rename_stage_io_ren2_uops_3_br_mask),
    .io_ren_uops_3_bits_br_tag       (_rename_stage_io_ren2_uops_3_br_tag),
    .io_ren_uops_3_bits_ftq_idx      (_rename_stage_io_ren2_uops_3_ftq_idx),
    .io_ren_uops_3_bits_edge_inst    (_rename_stage_io_ren2_uops_3_edge_inst),
    .io_ren_uops_3_bits_pc_lob       (_rename_stage_io_ren2_uops_3_pc_lob),
    .io_ren_uops_3_bits_taken        (_rename_stage_io_ren2_uops_3_taken),
    .io_ren_uops_3_bits_imm_packed   (_rename_stage_io_ren2_uops_3_imm_packed),
    .io_ren_uops_3_bits_rob_idx      (dis_uops_3_rob_idx),
    .io_ren_uops_3_bits_ldq_idx      (io_lsu_dis_ldq_idx_3),
    .io_ren_uops_3_bits_stq_idx      (io_lsu_dis_stq_idx_3),
    .io_ren_uops_3_bits_pdst         (dis_uops_3_pdst),
    .io_ren_uops_3_bits_prs1         (_dis_uops_3_prs1_busy_T_2 ? _fp_rename_stage_io_ren2_uops_3_prs1 : _dis_uops_3_prs1_busy_T ? _rename_stage_io_ren2_uops_3_prs1 : {1'h0, _rename_stage_io_ren2_uops_3_lrs1}),
    .io_ren_uops_3_bits_prs2         (_dis_uops_3_prs2_busy_T_2 ? _fp_rename_stage_io_ren2_uops_3_prs2 : _rename_stage_io_ren2_uops_3_prs2),
    .io_ren_uops_3_bits_prs3         (_fp_rename_stage_io_ren2_uops_3_prs3),
    .io_ren_uops_3_bits_prs1_busy    (_rename_stage_io_ren2_uops_3_prs1_busy & _dis_uops_3_prs1_busy_T | _fp_rename_stage_io_ren2_uops_3_prs1_busy & _dis_uops_3_prs1_busy_T_2),
    .io_ren_uops_3_bits_prs2_busy    (_rename_stage_io_ren2_uops_3_prs2_busy & _rename_stage_io_ren2_uops_3_lrs2_rtype == 2'h0 | _fp_rename_stage_io_ren2_uops_3_prs2_busy & _dis_uops_3_prs2_busy_T_2),
    .io_ren_uops_3_bits_prs3_busy    (_fp_rename_stage_io_ren2_uops_3_prs3_busy & _rename_stage_io_ren2_uops_3_frs3_en),
    .io_ren_uops_3_bits_exception    (_rename_stage_io_ren2_uops_3_exception),
    .io_ren_uops_3_bits_bypassable   (_rename_stage_io_ren2_uops_3_bypassable),
    .io_ren_uops_3_bits_mem_cmd      (_rename_stage_io_ren2_uops_3_mem_cmd),
    .io_ren_uops_3_bits_mem_size     (_rename_stage_io_ren2_uops_3_mem_size),
    .io_ren_uops_3_bits_mem_signed   (_rename_stage_io_ren2_uops_3_mem_signed),
    .io_ren_uops_3_bits_is_fence     (_rename_stage_io_ren2_uops_3_is_fence),
    .io_ren_uops_3_bits_is_fencei    (_rename_stage_io_ren2_uops_3_is_fencei),
    .io_ren_uops_3_bits_is_amo       (_rename_stage_io_ren2_uops_3_is_amo),
    .io_ren_uops_3_bits_uses_ldq     (_rename_stage_io_ren2_uops_3_uses_ldq),
    .io_ren_uops_3_bits_uses_stq     (_rename_stage_io_ren2_uops_3_uses_stq),
    .io_ren_uops_3_bits_ldst_val     (_rename_stage_io_ren2_uops_3_ldst_val),
    .io_ren_uops_3_bits_dst_rtype    (_rename_stage_io_ren2_uops_3_dst_rtype),
    .io_ren_uops_3_bits_lrs1_rtype   (_rename_stage_io_ren2_uops_3_lrs1_rtype),
    .io_ren_uops_3_bits_lrs2_rtype   (_rename_stage_io_ren2_uops_3_lrs2_rtype),
    .io_ren_uops_3_bits_fp_val       (_rename_stage_io_ren2_uops_3_fp_val),
    .io_dis_uops_2_0_ready           (_FpPipeline_io_dis_uops_0_ready),
    .io_dis_uops_2_1_ready           (_FpPipeline_io_dis_uops_1_ready),
    .io_dis_uops_2_2_ready           (_FpPipeline_io_dis_uops_2_ready),
    .io_dis_uops_2_3_ready           (_FpPipeline_io_dis_uops_3_ready),
    .io_dis_uops_1_0_ready           (_int_issue_unit_io_dis_uops_0_ready),
    .io_dis_uops_1_1_ready           (_int_issue_unit_io_dis_uops_1_ready),
    .io_dis_uops_1_2_ready           (_int_issue_unit_io_dis_uops_2_ready),
    .io_dis_uops_1_3_ready           (_int_issue_unit_io_dis_uops_3_ready),
    .io_dis_uops_0_0_ready           (_mem_issue_unit_io_dis_uops_0_ready),
    .io_dis_uops_0_1_ready           (_mem_issue_unit_io_dis_uops_1_ready),
    .io_dis_uops_0_2_ready           (_mem_issue_unit_io_dis_uops_2_ready),
    .io_dis_uops_0_3_ready           (_mem_issue_unit_io_dis_uops_3_ready),
    .io_ren_uops_0_ready             (_dispatcher_io_ren_uops_0_ready),
    .io_ren_uops_1_ready             (_dispatcher_io_ren_uops_1_ready),
    .io_ren_uops_2_ready             (_dispatcher_io_ren_uops_2_ready),
    .io_ren_uops_3_ready             (_dispatcher_io_ren_uops_3_ready),
    .io_dis_uops_2_0_valid           (_dispatcher_io_dis_uops_2_0_valid),
    .io_dis_uops_2_0_bits_uopc       (_dispatcher_io_dis_uops_2_0_bits_uopc),
    .io_dis_uops_2_0_bits_fu_code    (_dispatcher_io_dis_uops_2_0_bits_fu_code),
    .io_dis_uops_2_0_bits_br_mask    (_dispatcher_io_dis_uops_2_0_bits_br_mask),
    .io_dis_uops_2_0_bits_imm_packed (_dispatcher_io_dis_uops_2_0_bits_imm_packed),
    .io_dis_uops_2_0_bits_rob_idx    (_dispatcher_io_dis_uops_2_0_bits_rob_idx),
    .io_dis_uops_2_0_bits_stq_idx    (_dispatcher_io_dis_uops_2_0_bits_stq_idx),
    .io_dis_uops_2_0_bits_pdst       (_dispatcher_io_dis_uops_2_0_bits_pdst),
    .io_dis_uops_2_0_bits_prs1       (_dispatcher_io_dis_uops_2_0_bits_prs1),
    .io_dis_uops_2_0_bits_prs2       (_dispatcher_io_dis_uops_2_0_bits_prs2),
    .io_dis_uops_2_0_bits_prs3       (_dispatcher_io_dis_uops_2_0_bits_prs3),
    .io_dis_uops_2_0_bits_prs1_busy  (_dispatcher_io_dis_uops_2_0_bits_prs1_busy),
    .io_dis_uops_2_0_bits_prs2_busy  (_dispatcher_io_dis_uops_2_0_bits_prs2_busy),
    .io_dis_uops_2_0_bits_prs3_busy  (_dispatcher_io_dis_uops_2_0_bits_prs3_busy),
    .io_dis_uops_2_0_bits_exception  (_dispatcher_io_dis_uops_2_0_bits_exception),
    .io_dis_uops_2_0_bits_mem_cmd    (_dispatcher_io_dis_uops_2_0_bits_mem_cmd),
    .io_dis_uops_2_0_bits_is_fence   (_dispatcher_io_dis_uops_2_0_bits_is_fence),
    .io_dis_uops_2_0_bits_is_fencei  (_dispatcher_io_dis_uops_2_0_bits_is_fencei),
    .io_dis_uops_2_0_bits_is_amo     (_dispatcher_io_dis_uops_2_0_bits_is_amo),
    .io_dis_uops_2_0_bits_uses_ldq   (_dispatcher_io_dis_uops_2_0_bits_uses_ldq),
    .io_dis_uops_2_0_bits_uses_stq   (_dispatcher_io_dis_uops_2_0_bits_uses_stq),
    .io_dis_uops_2_0_bits_dst_rtype  (_dispatcher_io_dis_uops_2_0_bits_dst_rtype),
    .io_dis_uops_2_0_bits_fp_val     (_dispatcher_io_dis_uops_2_0_bits_fp_val),
    .io_dis_uops_2_1_valid           (_dispatcher_io_dis_uops_2_1_valid),
    .io_dis_uops_2_1_bits_uopc       (_dispatcher_io_dis_uops_2_1_bits_uopc),
    .io_dis_uops_2_1_bits_fu_code    (_dispatcher_io_dis_uops_2_1_bits_fu_code),
    .io_dis_uops_2_1_bits_br_mask    (_dispatcher_io_dis_uops_2_1_bits_br_mask),
    .io_dis_uops_2_1_bits_imm_packed (_dispatcher_io_dis_uops_2_1_bits_imm_packed),
    .io_dis_uops_2_1_bits_rob_idx    (_dispatcher_io_dis_uops_2_1_bits_rob_idx),
    .io_dis_uops_2_1_bits_stq_idx    (_dispatcher_io_dis_uops_2_1_bits_stq_idx),
    .io_dis_uops_2_1_bits_pdst       (_dispatcher_io_dis_uops_2_1_bits_pdst),
    .io_dis_uops_2_1_bits_prs1       (_dispatcher_io_dis_uops_2_1_bits_prs1),
    .io_dis_uops_2_1_bits_prs2       (_dispatcher_io_dis_uops_2_1_bits_prs2),
    .io_dis_uops_2_1_bits_prs3       (_dispatcher_io_dis_uops_2_1_bits_prs3),
    .io_dis_uops_2_1_bits_prs1_busy  (_dispatcher_io_dis_uops_2_1_bits_prs1_busy),
    .io_dis_uops_2_1_bits_prs2_busy  (_dispatcher_io_dis_uops_2_1_bits_prs2_busy),
    .io_dis_uops_2_1_bits_prs3_busy  (_dispatcher_io_dis_uops_2_1_bits_prs3_busy),
    .io_dis_uops_2_1_bits_exception  (_dispatcher_io_dis_uops_2_1_bits_exception),
    .io_dis_uops_2_1_bits_mem_cmd    (_dispatcher_io_dis_uops_2_1_bits_mem_cmd),
    .io_dis_uops_2_1_bits_is_fence   (_dispatcher_io_dis_uops_2_1_bits_is_fence),
    .io_dis_uops_2_1_bits_is_fencei  (_dispatcher_io_dis_uops_2_1_bits_is_fencei),
    .io_dis_uops_2_1_bits_is_amo     (_dispatcher_io_dis_uops_2_1_bits_is_amo),
    .io_dis_uops_2_1_bits_uses_ldq   (_dispatcher_io_dis_uops_2_1_bits_uses_ldq),
    .io_dis_uops_2_1_bits_uses_stq   (_dispatcher_io_dis_uops_2_1_bits_uses_stq),
    .io_dis_uops_2_1_bits_dst_rtype  (_dispatcher_io_dis_uops_2_1_bits_dst_rtype),
    .io_dis_uops_2_1_bits_fp_val     (_dispatcher_io_dis_uops_2_1_bits_fp_val),
    .io_dis_uops_2_2_valid           (_dispatcher_io_dis_uops_2_2_valid),
    .io_dis_uops_2_2_bits_uopc       (_dispatcher_io_dis_uops_2_2_bits_uopc),
    .io_dis_uops_2_2_bits_fu_code    (_dispatcher_io_dis_uops_2_2_bits_fu_code),
    .io_dis_uops_2_2_bits_br_mask    (_dispatcher_io_dis_uops_2_2_bits_br_mask),
    .io_dis_uops_2_2_bits_imm_packed (_dispatcher_io_dis_uops_2_2_bits_imm_packed),
    .io_dis_uops_2_2_bits_rob_idx    (_dispatcher_io_dis_uops_2_2_bits_rob_idx),
    .io_dis_uops_2_2_bits_stq_idx    (_dispatcher_io_dis_uops_2_2_bits_stq_idx),
    .io_dis_uops_2_2_bits_pdst       (_dispatcher_io_dis_uops_2_2_bits_pdst),
    .io_dis_uops_2_2_bits_prs1       (_dispatcher_io_dis_uops_2_2_bits_prs1),
    .io_dis_uops_2_2_bits_prs2       (_dispatcher_io_dis_uops_2_2_bits_prs2),
    .io_dis_uops_2_2_bits_prs3       (_dispatcher_io_dis_uops_2_2_bits_prs3),
    .io_dis_uops_2_2_bits_prs1_busy  (_dispatcher_io_dis_uops_2_2_bits_prs1_busy),
    .io_dis_uops_2_2_bits_prs2_busy  (_dispatcher_io_dis_uops_2_2_bits_prs2_busy),
    .io_dis_uops_2_2_bits_prs3_busy  (_dispatcher_io_dis_uops_2_2_bits_prs3_busy),
    .io_dis_uops_2_2_bits_exception  (_dispatcher_io_dis_uops_2_2_bits_exception),
    .io_dis_uops_2_2_bits_mem_cmd    (_dispatcher_io_dis_uops_2_2_bits_mem_cmd),
    .io_dis_uops_2_2_bits_is_fence   (_dispatcher_io_dis_uops_2_2_bits_is_fence),
    .io_dis_uops_2_2_bits_is_fencei  (_dispatcher_io_dis_uops_2_2_bits_is_fencei),
    .io_dis_uops_2_2_bits_is_amo     (_dispatcher_io_dis_uops_2_2_bits_is_amo),
    .io_dis_uops_2_2_bits_uses_ldq   (_dispatcher_io_dis_uops_2_2_bits_uses_ldq),
    .io_dis_uops_2_2_bits_uses_stq   (_dispatcher_io_dis_uops_2_2_bits_uses_stq),
    .io_dis_uops_2_2_bits_dst_rtype  (_dispatcher_io_dis_uops_2_2_bits_dst_rtype),
    .io_dis_uops_2_2_bits_fp_val     (_dispatcher_io_dis_uops_2_2_bits_fp_val),
    .io_dis_uops_2_3_valid           (_dispatcher_io_dis_uops_2_3_valid),
    .io_dis_uops_2_3_bits_uopc       (_dispatcher_io_dis_uops_2_3_bits_uopc),
    .io_dis_uops_2_3_bits_fu_code    (_dispatcher_io_dis_uops_2_3_bits_fu_code),
    .io_dis_uops_2_3_bits_br_mask    (_dispatcher_io_dis_uops_2_3_bits_br_mask),
    .io_dis_uops_2_3_bits_imm_packed (_dispatcher_io_dis_uops_2_3_bits_imm_packed),
    .io_dis_uops_2_3_bits_rob_idx    (_dispatcher_io_dis_uops_2_3_bits_rob_idx),
    .io_dis_uops_2_3_bits_stq_idx    (_dispatcher_io_dis_uops_2_3_bits_stq_idx),
    .io_dis_uops_2_3_bits_pdst       (_dispatcher_io_dis_uops_2_3_bits_pdst),
    .io_dis_uops_2_3_bits_prs1       (_dispatcher_io_dis_uops_2_3_bits_prs1),
    .io_dis_uops_2_3_bits_prs2       (_dispatcher_io_dis_uops_2_3_bits_prs2),
    .io_dis_uops_2_3_bits_prs3       (_dispatcher_io_dis_uops_2_3_bits_prs3),
    .io_dis_uops_2_3_bits_prs1_busy  (_dispatcher_io_dis_uops_2_3_bits_prs1_busy),
    .io_dis_uops_2_3_bits_prs2_busy  (_dispatcher_io_dis_uops_2_3_bits_prs2_busy),
    .io_dis_uops_2_3_bits_prs3_busy  (_dispatcher_io_dis_uops_2_3_bits_prs3_busy),
    .io_dis_uops_2_3_bits_exception  (_dispatcher_io_dis_uops_2_3_bits_exception),
    .io_dis_uops_2_3_bits_mem_cmd    (_dispatcher_io_dis_uops_2_3_bits_mem_cmd),
    .io_dis_uops_2_3_bits_is_fence   (_dispatcher_io_dis_uops_2_3_bits_is_fence),
    .io_dis_uops_2_3_bits_is_fencei  (_dispatcher_io_dis_uops_2_3_bits_is_fencei),
    .io_dis_uops_2_3_bits_is_amo     (_dispatcher_io_dis_uops_2_3_bits_is_amo),
    .io_dis_uops_2_3_bits_uses_ldq   (_dispatcher_io_dis_uops_2_3_bits_uses_ldq),
    .io_dis_uops_2_3_bits_uses_stq   (_dispatcher_io_dis_uops_2_3_bits_uses_stq),
    .io_dis_uops_2_3_bits_dst_rtype  (_dispatcher_io_dis_uops_2_3_bits_dst_rtype),
    .io_dis_uops_2_3_bits_fp_val     (_dispatcher_io_dis_uops_2_3_bits_fp_val),
    .io_dis_uops_1_0_valid           (_dispatcher_io_dis_uops_1_0_valid),
    .io_dis_uops_1_0_bits_uopc       (_dispatcher_io_dis_uops_1_0_bits_uopc),
    .io_dis_uops_1_0_bits_is_rvc     (_dispatcher_io_dis_uops_1_0_bits_is_rvc),
    .io_dis_uops_1_0_bits_fu_code    (_dispatcher_io_dis_uops_1_0_bits_fu_code),
    .io_dis_uops_1_0_bits_is_br      (_dispatcher_io_dis_uops_1_0_bits_is_br),
    .io_dis_uops_1_0_bits_is_jalr    (_dispatcher_io_dis_uops_1_0_bits_is_jalr),
    .io_dis_uops_1_0_bits_is_jal     (_dispatcher_io_dis_uops_1_0_bits_is_jal),
    .io_dis_uops_1_0_bits_is_sfb     (_dispatcher_io_dis_uops_1_0_bits_is_sfb),
    .io_dis_uops_1_0_bits_br_mask    (_dispatcher_io_dis_uops_1_0_bits_br_mask),
    .io_dis_uops_1_0_bits_br_tag     (_dispatcher_io_dis_uops_1_0_bits_br_tag),
    .io_dis_uops_1_0_bits_ftq_idx    (_dispatcher_io_dis_uops_1_0_bits_ftq_idx),
    .io_dis_uops_1_0_bits_edge_inst  (_dispatcher_io_dis_uops_1_0_bits_edge_inst),
    .io_dis_uops_1_0_bits_pc_lob     (_dispatcher_io_dis_uops_1_0_bits_pc_lob),
    .io_dis_uops_1_0_bits_taken      (_dispatcher_io_dis_uops_1_0_bits_taken),
    .io_dis_uops_1_0_bits_imm_packed (_dispatcher_io_dis_uops_1_0_bits_imm_packed),
    .io_dis_uops_1_0_bits_rob_idx    (_dispatcher_io_dis_uops_1_0_bits_rob_idx),
    .io_dis_uops_1_0_bits_ldq_idx    (_dispatcher_io_dis_uops_1_0_bits_ldq_idx),
    .io_dis_uops_1_0_bits_stq_idx    (_dispatcher_io_dis_uops_1_0_bits_stq_idx),
    .io_dis_uops_1_0_bits_pdst       (_dispatcher_io_dis_uops_1_0_bits_pdst),
    .io_dis_uops_1_0_bits_prs1       (_dispatcher_io_dis_uops_1_0_bits_prs1),
    .io_dis_uops_1_0_bits_prs2       (_dispatcher_io_dis_uops_1_0_bits_prs2),
    .io_dis_uops_1_0_bits_prs3       (_dispatcher_io_dis_uops_1_0_bits_prs3),
    .io_dis_uops_1_0_bits_prs1_busy  (_dispatcher_io_dis_uops_1_0_bits_prs1_busy),
    .io_dis_uops_1_0_bits_prs2_busy  (_dispatcher_io_dis_uops_1_0_bits_prs2_busy),
    .io_dis_uops_1_0_bits_exception  (_dispatcher_io_dis_uops_1_0_bits_exception),
    .io_dis_uops_1_0_bits_bypassable (_dispatcher_io_dis_uops_1_0_bits_bypassable),
    .io_dis_uops_1_0_bits_mem_cmd    (_dispatcher_io_dis_uops_1_0_bits_mem_cmd),
    .io_dis_uops_1_0_bits_mem_size   (_dispatcher_io_dis_uops_1_0_bits_mem_size),
    .io_dis_uops_1_0_bits_mem_signed (_dispatcher_io_dis_uops_1_0_bits_mem_signed),
    .io_dis_uops_1_0_bits_is_fence   (_dispatcher_io_dis_uops_1_0_bits_is_fence),
    .io_dis_uops_1_0_bits_is_fencei  (_dispatcher_io_dis_uops_1_0_bits_is_fencei),
    .io_dis_uops_1_0_bits_is_amo     (_dispatcher_io_dis_uops_1_0_bits_is_amo),
    .io_dis_uops_1_0_bits_uses_ldq   (_dispatcher_io_dis_uops_1_0_bits_uses_ldq),
    .io_dis_uops_1_0_bits_uses_stq   (_dispatcher_io_dis_uops_1_0_bits_uses_stq),
    .io_dis_uops_1_0_bits_ldst_val   (_dispatcher_io_dis_uops_1_0_bits_ldst_val),
    .io_dis_uops_1_0_bits_dst_rtype  (_dispatcher_io_dis_uops_1_0_bits_dst_rtype),
    .io_dis_uops_1_0_bits_lrs1_rtype (_dispatcher_io_dis_uops_1_0_bits_lrs1_rtype),
    .io_dis_uops_1_0_bits_lrs2_rtype (_dispatcher_io_dis_uops_1_0_bits_lrs2_rtype),
    .io_dis_uops_1_0_bits_fp_val     (_dispatcher_io_dis_uops_1_0_bits_fp_val),
    .io_dis_uops_1_1_valid           (_dispatcher_io_dis_uops_1_1_valid),
    .io_dis_uops_1_1_bits_uopc       (_dispatcher_io_dis_uops_1_1_bits_uopc),
    .io_dis_uops_1_1_bits_is_rvc     (_dispatcher_io_dis_uops_1_1_bits_is_rvc),
    .io_dis_uops_1_1_bits_fu_code    (_dispatcher_io_dis_uops_1_1_bits_fu_code),
    .io_dis_uops_1_1_bits_is_br      (_dispatcher_io_dis_uops_1_1_bits_is_br),
    .io_dis_uops_1_1_bits_is_jalr    (_dispatcher_io_dis_uops_1_1_bits_is_jalr),
    .io_dis_uops_1_1_bits_is_jal     (_dispatcher_io_dis_uops_1_1_bits_is_jal),
    .io_dis_uops_1_1_bits_is_sfb     (_dispatcher_io_dis_uops_1_1_bits_is_sfb),
    .io_dis_uops_1_1_bits_br_mask    (_dispatcher_io_dis_uops_1_1_bits_br_mask),
    .io_dis_uops_1_1_bits_br_tag     (_dispatcher_io_dis_uops_1_1_bits_br_tag),
    .io_dis_uops_1_1_bits_ftq_idx    (_dispatcher_io_dis_uops_1_1_bits_ftq_idx),
    .io_dis_uops_1_1_bits_edge_inst  (_dispatcher_io_dis_uops_1_1_bits_edge_inst),
    .io_dis_uops_1_1_bits_pc_lob     (_dispatcher_io_dis_uops_1_1_bits_pc_lob),
    .io_dis_uops_1_1_bits_taken      (_dispatcher_io_dis_uops_1_1_bits_taken),
    .io_dis_uops_1_1_bits_imm_packed (_dispatcher_io_dis_uops_1_1_bits_imm_packed),
    .io_dis_uops_1_1_bits_rob_idx    (_dispatcher_io_dis_uops_1_1_bits_rob_idx),
    .io_dis_uops_1_1_bits_ldq_idx    (_dispatcher_io_dis_uops_1_1_bits_ldq_idx),
    .io_dis_uops_1_1_bits_stq_idx    (_dispatcher_io_dis_uops_1_1_bits_stq_idx),
    .io_dis_uops_1_1_bits_pdst       (_dispatcher_io_dis_uops_1_1_bits_pdst),
    .io_dis_uops_1_1_bits_prs1       (_dispatcher_io_dis_uops_1_1_bits_prs1),
    .io_dis_uops_1_1_bits_prs2       (_dispatcher_io_dis_uops_1_1_bits_prs2),
    .io_dis_uops_1_1_bits_prs3       (_dispatcher_io_dis_uops_1_1_bits_prs3),
    .io_dis_uops_1_1_bits_prs1_busy  (_dispatcher_io_dis_uops_1_1_bits_prs1_busy),
    .io_dis_uops_1_1_bits_prs2_busy  (_dispatcher_io_dis_uops_1_1_bits_prs2_busy),
    .io_dis_uops_1_1_bits_exception  (_dispatcher_io_dis_uops_1_1_bits_exception),
    .io_dis_uops_1_1_bits_bypassable (_dispatcher_io_dis_uops_1_1_bits_bypassable),
    .io_dis_uops_1_1_bits_mem_cmd    (_dispatcher_io_dis_uops_1_1_bits_mem_cmd),
    .io_dis_uops_1_1_bits_mem_size   (_dispatcher_io_dis_uops_1_1_bits_mem_size),
    .io_dis_uops_1_1_bits_mem_signed (_dispatcher_io_dis_uops_1_1_bits_mem_signed),
    .io_dis_uops_1_1_bits_is_fence   (_dispatcher_io_dis_uops_1_1_bits_is_fence),
    .io_dis_uops_1_1_bits_is_fencei  (_dispatcher_io_dis_uops_1_1_bits_is_fencei),
    .io_dis_uops_1_1_bits_is_amo     (_dispatcher_io_dis_uops_1_1_bits_is_amo),
    .io_dis_uops_1_1_bits_uses_ldq   (_dispatcher_io_dis_uops_1_1_bits_uses_ldq),
    .io_dis_uops_1_1_bits_uses_stq   (_dispatcher_io_dis_uops_1_1_bits_uses_stq),
    .io_dis_uops_1_1_bits_ldst_val   (_dispatcher_io_dis_uops_1_1_bits_ldst_val),
    .io_dis_uops_1_1_bits_dst_rtype  (_dispatcher_io_dis_uops_1_1_bits_dst_rtype),
    .io_dis_uops_1_1_bits_lrs1_rtype (_dispatcher_io_dis_uops_1_1_bits_lrs1_rtype),
    .io_dis_uops_1_1_bits_lrs2_rtype (_dispatcher_io_dis_uops_1_1_bits_lrs2_rtype),
    .io_dis_uops_1_1_bits_fp_val     (_dispatcher_io_dis_uops_1_1_bits_fp_val),
    .io_dis_uops_1_2_valid           (_dispatcher_io_dis_uops_1_2_valid),
    .io_dis_uops_1_2_bits_uopc       (_dispatcher_io_dis_uops_1_2_bits_uopc),
    .io_dis_uops_1_2_bits_is_rvc     (_dispatcher_io_dis_uops_1_2_bits_is_rvc),
    .io_dis_uops_1_2_bits_fu_code    (_dispatcher_io_dis_uops_1_2_bits_fu_code),
    .io_dis_uops_1_2_bits_is_br      (_dispatcher_io_dis_uops_1_2_bits_is_br),
    .io_dis_uops_1_2_bits_is_jalr    (_dispatcher_io_dis_uops_1_2_bits_is_jalr),
    .io_dis_uops_1_2_bits_is_jal     (_dispatcher_io_dis_uops_1_2_bits_is_jal),
    .io_dis_uops_1_2_bits_is_sfb     (_dispatcher_io_dis_uops_1_2_bits_is_sfb),
    .io_dis_uops_1_2_bits_br_mask    (_dispatcher_io_dis_uops_1_2_bits_br_mask),
    .io_dis_uops_1_2_bits_br_tag     (_dispatcher_io_dis_uops_1_2_bits_br_tag),
    .io_dis_uops_1_2_bits_ftq_idx    (_dispatcher_io_dis_uops_1_2_bits_ftq_idx),
    .io_dis_uops_1_2_bits_edge_inst  (_dispatcher_io_dis_uops_1_2_bits_edge_inst),
    .io_dis_uops_1_2_bits_pc_lob     (_dispatcher_io_dis_uops_1_2_bits_pc_lob),
    .io_dis_uops_1_2_bits_taken      (_dispatcher_io_dis_uops_1_2_bits_taken),
    .io_dis_uops_1_2_bits_imm_packed (_dispatcher_io_dis_uops_1_2_bits_imm_packed),
    .io_dis_uops_1_2_bits_rob_idx    (_dispatcher_io_dis_uops_1_2_bits_rob_idx),
    .io_dis_uops_1_2_bits_ldq_idx    (_dispatcher_io_dis_uops_1_2_bits_ldq_idx),
    .io_dis_uops_1_2_bits_stq_idx    (_dispatcher_io_dis_uops_1_2_bits_stq_idx),
    .io_dis_uops_1_2_bits_pdst       (_dispatcher_io_dis_uops_1_2_bits_pdst),
    .io_dis_uops_1_2_bits_prs1       (_dispatcher_io_dis_uops_1_2_bits_prs1),
    .io_dis_uops_1_2_bits_prs2       (_dispatcher_io_dis_uops_1_2_bits_prs2),
    .io_dis_uops_1_2_bits_prs3       (_dispatcher_io_dis_uops_1_2_bits_prs3),
    .io_dis_uops_1_2_bits_prs1_busy  (_dispatcher_io_dis_uops_1_2_bits_prs1_busy),
    .io_dis_uops_1_2_bits_prs2_busy  (_dispatcher_io_dis_uops_1_2_bits_prs2_busy),
    .io_dis_uops_1_2_bits_exception  (_dispatcher_io_dis_uops_1_2_bits_exception),
    .io_dis_uops_1_2_bits_bypassable (_dispatcher_io_dis_uops_1_2_bits_bypassable),
    .io_dis_uops_1_2_bits_mem_cmd    (_dispatcher_io_dis_uops_1_2_bits_mem_cmd),
    .io_dis_uops_1_2_bits_mem_size   (_dispatcher_io_dis_uops_1_2_bits_mem_size),
    .io_dis_uops_1_2_bits_mem_signed (_dispatcher_io_dis_uops_1_2_bits_mem_signed),
    .io_dis_uops_1_2_bits_is_fence   (_dispatcher_io_dis_uops_1_2_bits_is_fence),
    .io_dis_uops_1_2_bits_is_fencei  (_dispatcher_io_dis_uops_1_2_bits_is_fencei),
    .io_dis_uops_1_2_bits_is_amo     (_dispatcher_io_dis_uops_1_2_bits_is_amo),
    .io_dis_uops_1_2_bits_uses_ldq   (_dispatcher_io_dis_uops_1_2_bits_uses_ldq),
    .io_dis_uops_1_2_bits_uses_stq   (_dispatcher_io_dis_uops_1_2_bits_uses_stq),
    .io_dis_uops_1_2_bits_ldst_val   (_dispatcher_io_dis_uops_1_2_bits_ldst_val),
    .io_dis_uops_1_2_bits_dst_rtype  (_dispatcher_io_dis_uops_1_2_bits_dst_rtype),
    .io_dis_uops_1_2_bits_lrs1_rtype (_dispatcher_io_dis_uops_1_2_bits_lrs1_rtype),
    .io_dis_uops_1_2_bits_lrs2_rtype (_dispatcher_io_dis_uops_1_2_bits_lrs2_rtype),
    .io_dis_uops_1_2_bits_fp_val     (_dispatcher_io_dis_uops_1_2_bits_fp_val),
    .io_dis_uops_1_3_valid           (_dispatcher_io_dis_uops_1_3_valid),
    .io_dis_uops_1_3_bits_uopc       (_dispatcher_io_dis_uops_1_3_bits_uopc),
    .io_dis_uops_1_3_bits_is_rvc     (_dispatcher_io_dis_uops_1_3_bits_is_rvc),
    .io_dis_uops_1_3_bits_fu_code    (_dispatcher_io_dis_uops_1_3_bits_fu_code),
    .io_dis_uops_1_3_bits_is_br      (_dispatcher_io_dis_uops_1_3_bits_is_br),
    .io_dis_uops_1_3_bits_is_jalr    (_dispatcher_io_dis_uops_1_3_bits_is_jalr),
    .io_dis_uops_1_3_bits_is_jal     (_dispatcher_io_dis_uops_1_3_bits_is_jal),
    .io_dis_uops_1_3_bits_is_sfb     (_dispatcher_io_dis_uops_1_3_bits_is_sfb),
    .io_dis_uops_1_3_bits_br_mask    (_dispatcher_io_dis_uops_1_3_bits_br_mask),
    .io_dis_uops_1_3_bits_br_tag     (_dispatcher_io_dis_uops_1_3_bits_br_tag),
    .io_dis_uops_1_3_bits_ftq_idx    (_dispatcher_io_dis_uops_1_3_bits_ftq_idx),
    .io_dis_uops_1_3_bits_edge_inst  (_dispatcher_io_dis_uops_1_3_bits_edge_inst),
    .io_dis_uops_1_3_bits_pc_lob     (_dispatcher_io_dis_uops_1_3_bits_pc_lob),
    .io_dis_uops_1_3_bits_taken      (_dispatcher_io_dis_uops_1_3_bits_taken),
    .io_dis_uops_1_3_bits_imm_packed (_dispatcher_io_dis_uops_1_3_bits_imm_packed),
    .io_dis_uops_1_3_bits_rob_idx    (_dispatcher_io_dis_uops_1_3_bits_rob_idx),
    .io_dis_uops_1_3_bits_ldq_idx    (_dispatcher_io_dis_uops_1_3_bits_ldq_idx),
    .io_dis_uops_1_3_bits_stq_idx    (_dispatcher_io_dis_uops_1_3_bits_stq_idx),
    .io_dis_uops_1_3_bits_pdst       (_dispatcher_io_dis_uops_1_3_bits_pdst),
    .io_dis_uops_1_3_bits_prs1       (_dispatcher_io_dis_uops_1_3_bits_prs1),
    .io_dis_uops_1_3_bits_prs2       (_dispatcher_io_dis_uops_1_3_bits_prs2),
    .io_dis_uops_1_3_bits_prs3       (_dispatcher_io_dis_uops_1_3_bits_prs3),
    .io_dis_uops_1_3_bits_prs1_busy  (_dispatcher_io_dis_uops_1_3_bits_prs1_busy),
    .io_dis_uops_1_3_bits_prs2_busy  (_dispatcher_io_dis_uops_1_3_bits_prs2_busy),
    .io_dis_uops_1_3_bits_exception  (_dispatcher_io_dis_uops_1_3_bits_exception),
    .io_dis_uops_1_3_bits_bypassable (_dispatcher_io_dis_uops_1_3_bits_bypassable),
    .io_dis_uops_1_3_bits_mem_cmd    (_dispatcher_io_dis_uops_1_3_bits_mem_cmd),
    .io_dis_uops_1_3_bits_mem_size   (_dispatcher_io_dis_uops_1_3_bits_mem_size),
    .io_dis_uops_1_3_bits_mem_signed (_dispatcher_io_dis_uops_1_3_bits_mem_signed),
    .io_dis_uops_1_3_bits_is_fence   (_dispatcher_io_dis_uops_1_3_bits_is_fence),
    .io_dis_uops_1_3_bits_is_fencei  (_dispatcher_io_dis_uops_1_3_bits_is_fencei),
    .io_dis_uops_1_3_bits_is_amo     (_dispatcher_io_dis_uops_1_3_bits_is_amo),
    .io_dis_uops_1_3_bits_uses_ldq   (_dispatcher_io_dis_uops_1_3_bits_uses_ldq),
    .io_dis_uops_1_3_bits_uses_stq   (_dispatcher_io_dis_uops_1_3_bits_uses_stq),
    .io_dis_uops_1_3_bits_ldst_val   (_dispatcher_io_dis_uops_1_3_bits_ldst_val),
    .io_dis_uops_1_3_bits_dst_rtype  (_dispatcher_io_dis_uops_1_3_bits_dst_rtype),
    .io_dis_uops_1_3_bits_lrs1_rtype (_dispatcher_io_dis_uops_1_3_bits_lrs1_rtype),
    .io_dis_uops_1_3_bits_lrs2_rtype (_dispatcher_io_dis_uops_1_3_bits_lrs2_rtype),
    .io_dis_uops_1_3_bits_fp_val     (_dispatcher_io_dis_uops_1_3_bits_fp_val),
    .io_dis_uops_0_0_valid           (_dispatcher_io_dis_uops_0_0_valid),
    .io_dis_uops_0_0_bits_uopc       (_dispatcher_io_dis_uops_0_0_bits_uopc),
    .io_dis_uops_0_0_bits_is_rvc     (_dispatcher_io_dis_uops_0_0_bits_is_rvc),
    .io_dis_uops_0_0_bits_fu_code    (_dispatcher_io_dis_uops_0_0_bits_fu_code),
    .io_dis_uops_0_0_bits_is_br      (_dispatcher_io_dis_uops_0_0_bits_is_br),
    .io_dis_uops_0_0_bits_is_jalr    (_dispatcher_io_dis_uops_0_0_bits_is_jalr),
    .io_dis_uops_0_0_bits_is_jal     (_dispatcher_io_dis_uops_0_0_bits_is_jal),
    .io_dis_uops_0_0_bits_is_sfb     (_dispatcher_io_dis_uops_0_0_bits_is_sfb),
    .io_dis_uops_0_0_bits_br_mask    (_dispatcher_io_dis_uops_0_0_bits_br_mask),
    .io_dis_uops_0_0_bits_br_tag     (_dispatcher_io_dis_uops_0_0_bits_br_tag),
    .io_dis_uops_0_0_bits_ftq_idx    (_dispatcher_io_dis_uops_0_0_bits_ftq_idx),
    .io_dis_uops_0_0_bits_edge_inst  (_dispatcher_io_dis_uops_0_0_bits_edge_inst),
    .io_dis_uops_0_0_bits_pc_lob     (_dispatcher_io_dis_uops_0_0_bits_pc_lob),
    .io_dis_uops_0_0_bits_taken      (_dispatcher_io_dis_uops_0_0_bits_taken),
    .io_dis_uops_0_0_bits_imm_packed (_dispatcher_io_dis_uops_0_0_bits_imm_packed),
    .io_dis_uops_0_0_bits_rob_idx    (_dispatcher_io_dis_uops_0_0_bits_rob_idx),
    .io_dis_uops_0_0_bits_ldq_idx    (_dispatcher_io_dis_uops_0_0_bits_ldq_idx),
    .io_dis_uops_0_0_bits_stq_idx    (_dispatcher_io_dis_uops_0_0_bits_stq_idx),
    .io_dis_uops_0_0_bits_pdst       (_dispatcher_io_dis_uops_0_0_bits_pdst),
    .io_dis_uops_0_0_bits_prs1       (_dispatcher_io_dis_uops_0_0_bits_prs1),
    .io_dis_uops_0_0_bits_prs2       (_dispatcher_io_dis_uops_0_0_bits_prs2),
    .io_dis_uops_0_0_bits_prs3       (_dispatcher_io_dis_uops_0_0_bits_prs3),
    .io_dis_uops_0_0_bits_prs1_busy  (_dispatcher_io_dis_uops_0_0_bits_prs1_busy),
    .io_dis_uops_0_0_bits_prs2_busy  (_dispatcher_io_dis_uops_0_0_bits_prs2_busy),
    .io_dis_uops_0_0_bits_exception  (_dispatcher_io_dis_uops_0_0_bits_exception),
    .io_dis_uops_0_0_bits_bypassable (_dispatcher_io_dis_uops_0_0_bits_bypassable),
    .io_dis_uops_0_0_bits_mem_cmd    (_dispatcher_io_dis_uops_0_0_bits_mem_cmd),
    .io_dis_uops_0_0_bits_mem_size   (_dispatcher_io_dis_uops_0_0_bits_mem_size),
    .io_dis_uops_0_0_bits_mem_signed (_dispatcher_io_dis_uops_0_0_bits_mem_signed),
    .io_dis_uops_0_0_bits_is_fence   (_dispatcher_io_dis_uops_0_0_bits_is_fence),
    .io_dis_uops_0_0_bits_is_fencei  (_dispatcher_io_dis_uops_0_0_bits_is_fencei),
    .io_dis_uops_0_0_bits_is_amo     (_dispatcher_io_dis_uops_0_0_bits_is_amo),
    .io_dis_uops_0_0_bits_uses_ldq   (_dispatcher_io_dis_uops_0_0_bits_uses_ldq),
    .io_dis_uops_0_0_bits_uses_stq   (_dispatcher_io_dis_uops_0_0_bits_uses_stq),
    .io_dis_uops_0_0_bits_ldst_val   (_dispatcher_io_dis_uops_0_0_bits_ldst_val),
    .io_dis_uops_0_0_bits_dst_rtype  (_dispatcher_io_dis_uops_0_0_bits_dst_rtype),
    .io_dis_uops_0_0_bits_lrs1_rtype (_dispatcher_io_dis_uops_0_0_bits_lrs1_rtype),
    .io_dis_uops_0_0_bits_lrs2_rtype (_dispatcher_io_dis_uops_0_0_bits_lrs2_rtype),
    .io_dis_uops_0_0_bits_fp_val     (_dispatcher_io_dis_uops_0_0_bits_fp_val),
    .io_dis_uops_0_1_valid           (_dispatcher_io_dis_uops_0_1_valid),
    .io_dis_uops_0_1_bits_uopc       (_dispatcher_io_dis_uops_0_1_bits_uopc),
    .io_dis_uops_0_1_bits_is_rvc     (_dispatcher_io_dis_uops_0_1_bits_is_rvc),
    .io_dis_uops_0_1_bits_fu_code    (_dispatcher_io_dis_uops_0_1_bits_fu_code),
    .io_dis_uops_0_1_bits_is_br      (_dispatcher_io_dis_uops_0_1_bits_is_br),
    .io_dis_uops_0_1_bits_is_jalr    (_dispatcher_io_dis_uops_0_1_bits_is_jalr),
    .io_dis_uops_0_1_bits_is_jal     (_dispatcher_io_dis_uops_0_1_bits_is_jal),
    .io_dis_uops_0_1_bits_is_sfb     (_dispatcher_io_dis_uops_0_1_bits_is_sfb),
    .io_dis_uops_0_1_bits_br_mask    (_dispatcher_io_dis_uops_0_1_bits_br_mask),
    .io_dis_uops_0_1_bits_br_tag     (_dispatcher_io_dis_uops_0_1_bits_br_tag),
    .io_dis_uops_0_1_bits_ftq_idx    (_dispatcher_io_dis_uops_0_1_bits_ftq_idx),
    .io_dis_uops_0_1_bits_edge_inst  (_dispatcher_io_dis_uops_0_1_bits_edge_inst),
    .io_dis_uops_0_1_bits_pc_lob     (_dispatcher_io_dis_uops_0_1_bits_pc_lob),
    .io_dis_uops_0_1_bits_taken      (_dispatcher_io_dis_uops_0_1_bits_taken),
    .io_dis_uops_0_1_bits_imm_packed (_dispatcher_io_dis_uops_0_1_bits_imm_packed),
    .io_dis_uops_0_1_bits_rob_idx    (_dispatcher_io_dis_uops_0_1_bits_rob_idx),
    .io_dis_uops_0_1_bits_ldq_idx    (_dispatcher_io_dis_uops_0_1_bits_ldq_idx),
    .io_dis_uops_0_1_bits_stq_idx    (_dispatcher_io_dis_uops_0_1_bits_stq_idx),
    .io_dis_uops_0_1_bits_pdst       (_dispatcher_io_dis_uops_0_1_bits_pdst),
    .io_dis_uops_0_1_bits_prs1       (_dispatcher_io_dis_uops_0_1_bits_prs1),
    .io_dis_uops_0_1_bits_prs2       (_dispatcher_io_dis_uops_0_1_bits_prs2),
    .io_dis_uops_0_1_bits_prs3       (_dispatcher_io_dis_uops_0_1_bits_prs3),
    .io_dis_uops_0_1_bits_prs1_busy  (_dispatcher_io_dis_uops_0_1_bits_prs1_busy),
    .io_dis_uops_0_1_bits_prs2_busy  (_dispatcher_io_dis_uops_0_1_bits_prs2_busy),
    .io_dis_uops_0_1_bits_exception  (_dispatcher_io_dis_uops_0_1_bits_exception),
    .io_dis_uops_0_1_bits_bypassable (_dispatcher_io_dis_uops_0_1_bits_bypassable),
    .io_dis_uops_0_1_bits_mem_cmd    (_dispatcher_io_dis_uops_0_1_bits_mem_cmd),
    .io_dis_uops_0_1_bits_mem_size   (_dispatcher_io_dis_uops_0_1_bits_mem_size),
    .io_dis_uops_0_1_bits_mem_signed (_dispatcher_io_dis_uops_0_1_bits_mem_signed),
    .io_dis_uops_0_1_bits_is_fence   (_dispatcher_io_dis_uops_0_1_bits_is_fence),
    .io_dis_uops_0_1_bits_is_fencei  (_dispatcher_io_dis_uops_0_1_bits_is_fencei),
    .io_dis_uops_0_1_bits_is_amo     (_dispatcher_io_dis_uops_0_1_bits_is_amo),
    .io_dis_uops_0_1_bits_uses_ldq   (_dispatcher_io_dis_uops_0_1_bits_uses_ldq),
    .io_dis_uops_0_1_bits_uses_stq   (_dispatcher_io_dis_uops_0_1_bits_uses_stq),
    .io_dis_uops_0_1_bits_ldst_val   (_dispatcher_io_dis_uops_0_1_bits_ldst_val),
    .io_dis_uops_0_1_bits_dst_rtype  (_dispatcher_io_dis_uops_0_1_bits_dst_rtype),
    .io_dis_uops_0_1_bits_lrs1_rtype (_dispatcher_io_dis_uops_0_1_bits_lrs1_rtype),
    .io_dis_uops_0_1_bits_lrs2_rtype (_dispatcher_io_dis_uops_0_1_bits_lrs2_rtype),
    .io_dis_uops_0_1_bits_fp_val     (_dispatcher_io_dis_uops_0_1_bits_fp_val),
    .io_dis_uops_0_2_valid           (_dispatcher_io_dis_uops_0_2_valid),
    .io_dis_uops_0_2_bits_uopc       (_dispatcher_io_dis_uops_0_2_bits_uopc),
    .io_dis_uops_0_2_bits_is_rvc     (_dispatcher_io_dis_uops_0_2_bits_is_rvc),
    .io_dis_uops_0_2_bits_fu_code    (_dispatcher_io_dis_uops_0_2_bits_fu_code),
    .io_dis_uops_0_2_bits_is_br      (_dispatcher_io_dis_uops_0_2_bits_is_br),
    .io_dis_uops_0_2_bits_is_jalr    (_dispatcher_io_dis_uops_0_2_bits_is_jalr),
    .io_dis_uops_0_2_bits_is_jal     (_dispatcher_io_dis_uops_0_2_bits_is_jal),
    .io_dis_uops_0_2_bits_is_sfb     (_dispatcher_io_dis_uops_0_2_bits_is_sfb),
    .io_dis_uops_0_2_bits_br_mask    (_dispatcher_io_dis_uops_0_2_bits_br_mask),
    .io_dis_uops_0_2_bits_br_tag     (_dispatcher_io_dis_uops_0_2_bits_br_tag),
    .io_dis_uops_0_2_bits_ftq_idx    (_dispatcher_io_dis_uops_0_2_bits_ftq_idx),
    .io_dis_uops_0_2_bits_edge_inst  (_dispatcher_io_dis_uops_0_2_bits_edge_inst),
    .io_dis_uops_0_2_bits_pc_lob     (_dispatcher_io_dis_uops_0_2_bits_pc_lob),
    .io_dis_uops_0_2_bits_taken      (_dispatcher_io_dis_uops_0_2_bits_taken),
    .io_dis_uops_0_2_bits_imm_packed (_dispatcher_io_dis_uops_0_2_bits_imm_packed),
    .io_dis_uops_0_2_bits_rob_idx    (_dispatcher_io_dis_uops_0_2_bits_rob_idx),
    .io_dis_uops_0_2_bits_ldq_idx    (_dispatcher_io_dis_uops_0_2_bits_ldq_idx),
    .io_dis_uops_0_2_bits_stq_idx    (_dispatcher_io_dis_uops_0_2_bits_stq_idx),
    .io_dis_uops_0_2_bits_pdst       (_dispatcher_io_dis_uops_0_2_bits_pdst),
    .io_dis_uops_0_2_bits_prs1       (_dispatcher_io_dis_uops_0_2_bits_prs1),
    .io_dis_uops_0_2_bits_prs2       (_dispatcher_io_dis_uops_0_2_bits_prs2),
    .io_dis_uops_0_2_bits_prs3       (_dispatcher_io_dis_uops_0_2_bits_prs3),
    .io_dis_uops_0_2_bits_prs1_busy  (_dispatcher_io_dis_uops_0_2_bits_prs1_busy),
    .io_dis_uops_0_2_bits_prs2_busy  (_dispatcher_io_dis_uops_0_2_bits_prs2_busy),
    .io_dis_uops_0_2_bits_exception  (_dispatcher_io_dis_uops_0_2_bits_exception),
    .io_dis_uops_0_2_bits_bypassable (_dispatcher_io_dis_uops_0_2_bits_bypassable),
    .io_dis_uops_0_2_bits_mem_cmd    (_dispatcher_io_dis_uops_0_2_bits_mem_cmd),
    .io_dis_uops_0_2_bits_mem_size   (_dispatcher_io_dis_uops_0_2_bits_mem_size),
    .io_dis_uops_0_2_bits_mem_signed (_dispatcher_io_dis_uops_0_2_bits_mem_signed),
    .io_dis_uops_0_2_bits_is_fence   (_dispatcher_io_dis_uops_0_2_bits_is_fence),
    .io_dis_uops_0_2_bits_is_fencei  (_dispatcher_io_dis_uops_0_2_bits_is_fencei),
    .io_dis_uops_0_2_bits_is_amo     (_dispatcher_io_dis_uops_0_2_bits_is_amo),
    .io_dis_uops_0_2_bits_uses_ldq   (_dispatcher_io_dis_uops_0_2_bits_uses_ldq),
    .io_dis_uops_0_2_bits_uses_stq   (_dispatcher_io_dis_uops_0_2_bits_uses_stq),
    .io_dis_uops_0_2_bits_ldst_val   (_dispatcher_io_dis_uops_0_2_bits_ldst_val),
    .io_dis_uops_0_2_bits_dst_rtype  (_dispatcher_io_dis_uops_0_2_bits_dst_rtype),
    .io_dis_uops_0_2_bits_lrs1_rtype (_dispatcher_io_dis_uops_0_2_bits_lrs1_rtype),
    .io_dis_uops_0_2_bits_lrs2_rtype (_dispatcher_io_dis_uops_0_2_bits_lrs2_rtype),
    .io_dis_uops_0_2_bits_fp_val     (_dispatcher_io_dis_uops_0_2_bits_fp_val),
    .io_dis_uops_0_3_valid           (_dispatcher_io_dis_uops_0_3_valid),
    .io_dis_uops_0_3_bits_uopc       (_dispatcher_io_dis_uops_0_3_bits_uopc),
    .io_dis_uops_0_3_bits_is_rvc     (_dispatcher_io_dis_uops_0_3_bits_is_rvc),
    .io_dis_uops_0_3_bits_fu_code    (_dispatcher_io_dis_uops_0_3_bits_fu_code),
    .io_dis_uops_0_3_bits_is_br      (_dispatcher_io_dis_uops_0_3_bits_is_br),
    .io_dis_uops_0_3_bits_is_jalr    (_dispatcher_io_dis_uops_0_3_bits_is_jalr),
    .io_dis_uops_0_3_bits_is_jal     (_dispatcher_io_dis_uops_0_3_bits_is_jal),
    .io_dis_uops_0_3_bits_is_sfb     (_dispatcher_io_dis_uops_0_3_bits_is_sfb),
    .io_dis_uops_0_3_bits_br_mask    (_dispatcher_io_dis_uops_0_3_bits_br_mask),
    .io_dis_uops_0_3_bits_br_tag     (_dispatcher_io_dis_uops_0_3_bits_br_tag),
    .io_dis_uops_0_3_bits_ftq_idx    (_dispatcher_io_dis_uops_0_3_bits_ftq_idx),
    .io_dis_uops_0_3_bits_edge_inst  (_dispatcher_io_dis_uops_0_3_bits_edge_inst),
    .io_dis_uops_0_3_bits_pc_lob     (_dispatcher_io_dis_uops_0_3_bits_pc_lob),
    .io_dis_uops_0_3_bits_taken      (_dispatcher_io_dis_uops_0_3_bits_taken),
    .io_dis_uops_0_3_bits_imm_packed (_dispatcher_io_dis_uops_0_3_bits_imm_packed),
    .io_dis_uops_0_3_bits_rob_idx    (_dispatcher_io_dis_uops_0_3_bits_rob_idx),
    .io_dis_uops_0_3_bits_ldq_idx    (_dispatcher_io_dis_uops_0_3_bits_ldq_idx),
    .io_dis_uops_0_3_bits_stq_idx    (_dispatcher_io_dis_uops_0_3_bits_stq_idx),
    .io_dis_uops_0_3_bits_pdst       (_dispatcher_io_dis_uops_0_3_bits_pdst),
    .io_dis_uops_0_3_bits_prs1       (_dispatcher_io_dis_uops_0_3_bits_prs1),
    .io_dis_uops_0_3_bits_prs2       (_dispatcher_io_dis_uops_0_3_bits_prs2),
    .io_dis_uops_0_3_bits_prs3       (_dispatcher_io_dis_uops_0_3_bits_prs3),
    .io_dis_uops_0_3_bits_prs1_busy  (_dispatcher_io_dis_uops_0_3_bits_prs1_busy),
    .io_dis_uops_0_3_bits_prs2_busy  (_dispatcher_io_dis_uops_0_3_bits_prs2_busy),
    .io_dis_uops_0_3_bits_exception  (_dispatcher_io_dis_uops_0_3_bits_exception),
    .io_dis_uops_0_3_bits_bypassable (_dispatcher_io_dis_uops_0_3_bits_bypassable),
    .io_dis_uops_0_3_bits_mem_cmd    (_dispatcher_io_dis_uops_0_3_bits_mem_cmd),
    .io_dis_uops_0_3_bits_mem_size   (_dispatcher_io_dis_uops_0_3_bits_mem_size),
    .io_dis_uops_0_3_bits_mem_signed (_dispatcher_io_dis_uops_0_3_bits_mem_signed),
    .io_dis_uops_0_3_bits_is_fence   (_dispatcher_io_dis_uops_0_3_bits_is_fence),
    .io_dis_uops_0_3_bits_is_fencei  (_dispatcher_io_dis_uops_0_3_bits_is_fencei),
    .io_dis_uops_0_3_bits_is_amo     (_dispatcher_io_dis_uops_0_3_bits_is_amo),
    .io_dis_uops_0_3_bits_uses_ldq   (_dispatcher_io_dis_uops_0_3_bits_uses_ldq),
    .io_dis_uops_0_3_bits_uses_stq   (_dispatcher_io_dis_uops_0_3_bits_uses_stq),
    .io_dis_uops_0_3_bits_ldst_val   (_dispatcher_io_dis_uops_0_3_bits_ldst_val),
    .io_dis_uops_0_3_bits_dst_rtype  (_dispatcher_io_dis_uops_0_3_bits_dst_rtype),
    .io_dis_uops_0_3_bits_lrs1_rtype (_dispatcher_io_dis_uops_0_3_bits_lrs1_rtype),
    .io_dis_uops_0_3_bits_lrs2_rtype (_dispatcher_io_dis_uops_0_3_bits_lrs2_rtype),
    .io_dis_uops_0_3_bits_fp_val     (_dispatcher_io_dis_uops_0_3_bits_fp_val)
  );
  RegisterFileSynthesizable_1 iregfile (
    .clock                      (clock),
    .reset                      (reset),
    .io_read_ports_0_addr       (_iregister_read_io_rf_read_ports_0_addr),
    .io_read_ports_1_addr       (_iregister_read_io_rf_read_ports_1_addr),
    .io_read_ports_2_addr       (_iregister_read_io_rf_read_ports_2_addr),
    .io_read_ports_3_addr       (_iregister_read_io_rf_read_ports_3_addr),
    .io_read_ports_4_addr       (_iregister_read_io_rf_read_ports_4_addr),
    .io_read_ports_5_addr       (_iregister_read_io_rf_read_ports_5_addr),
    .io_read_ports_6_addr       (_iregister_read_io_rf_read_ports_6_addr),
    .io_read_ports_7_addr       (_iregister_read_io_rf_read_ports_7_addr),
    .io_read_ports_8_addr       (_iregister_read_io_rf_read_ports_8_addr),
    .io_read_ports_9_addr       (_iregister_read_io_rf_read_ports_9_addr),
    .io_read_ports_10_addr      (_iregister_read_io_rf_read_ports_10_addr),
    .io_read_ports_11_addr      (_iregister_read_io_rf_read_ports_11_addr),
    .io_write_ports_0_valid     (_ll_wbarb_io_out_valid & _iregfile_io_write_ports_0_wport_valid_T),
    .io_write_ports_0_bits_addr (_ll_wbarb_io_out_bits_uop_pdst),
    .io_write_ports_0_bits_data (_ll_wbarb_io_out_bits_data),
    .io_write_ports_1_valid     (_memExeUnit_1_io_ll_iresp_valid & _iregfile_io_write_ports_1_wport_valid_T),
    .io_write_ports_1_bits_addr (_memExeUnit_1_io_ll_iresp_bits_uop_pdst),
    .io_write_ports_1_bits_data (_memExeUnit_1_io_ll_iresp_bits_data[63:0]),
    .io_write_ports_2_valid     (_alu_exe_unit_io_iresp_valid & _rob_io_debug_wb_valids_2_T & ~(|_alu_exe_unit_io_iresp_bits_uop_dst_rtype)),
    .io_write_ports_2_bits_addr (_alu_exe_unit_io_iresp_bits_uop_pdst),
    .io_write_ports_2_bits_data (_alu_exe_unit_io_iresp_bits_data[63:0]),
    .io_write_ports_3_valid     (_alu_exe_unit_1_io_iresp_valid & _rob_io_debug_wb_valids_3_T & ~(|_alu_exe_unit_1_io_iresp_bits_uop_dst_rtype)),
    .io_write_ports_3_bits_addr (_alu_exe_unit_1_io_iresp_bits_uop_pdst),
    .io_write_ports_3_bits_data ((|_alu_exe_unit_1_io_iresp_bits_uop_ctrl_csr_cmd) ? _csr_io_rw_rdata : _alu_exe_unit_1_io_iresp_bits_data[63:0]),
    .io_write_ports_4_valid     (_alu_exe_unit_2_io_iresp_valid & _rob_io_debug_wb_valids_4_T & ~(|_alu_exe_unit_2_io_iresp_bits_uop_dst_rtype)),
    .io_write_ports_4_bits_addr (_alu_exe_unit_2_io_iresp_bits_uop_pdst),
    .io_write_ports_4_bits_data (_alu_exe_unit_2_io_iresp_bits_data[63:0]),
    .io_write_ports_5_valid     (_alu_exe_unit_3_io_iresp_valid & _rob_io_debug_wb_valids_5_T & ~(|_alu_exe_unit_3_io_iresp_bits_uop_dst_rtype)),
    .io_write_ports_5_bits_addr (_alu_exe_unit_3_io_iresp_bits_uop_pdst),
    .io_write_ports_5_bits_data (_alu_exe_unit_3_io_iresp_bits_data[63:0]),
    .io_read_ports_0_data       (_iregfile_io_read_ports_0_data),
    .io_read_ports_1_data       (_iregfile_io_read_ports_1_data),
    .io_read_ports_2_data       (_iregfile_io_read_ports_2_data),
    .io_read_ports_3_data       (_iregfile_io_read_ports_3_data),
    .io_read_ports_4_data       (_iregfile_io_read_ports_4_data),
    .io_read_ports_5_data       (_iregfile_io_read_ports_5_data),
    .io_read_ports_6_data       (_iregfile_io_read_ports_6_data),
    .io_read_ports_7_data       (_iregfile_io_read_ports_7_data),
    .io_read_ports_8_data       (_iregfile_io_read_ports_8_data),
    .io_read_ports_9_data       (_iregfile_io_read_ports_9_data),
    .io_read_ports_10_data      (_iregfile_io_read_ports_10_data),
    .io_read_ports_11_data      (_iregfile_io_read_ports_11_data)
  );
  Arbiter_18 ll_wbarb (
    .io_in_0_valid              (_memExeUnit_io_ll_iresp_valid),
    .io_in_0_bits_uop_rob_idx   (_memExeUnit_io_ll_iresp_bits_uop_rob_idx),
    .io_in_0_bits_uop_pdst      (_memExeUnit_io_ll_iresp_bits_uop_pdst),
    .io_in_0_bits_uop_is_amo    (_memExeUnit_io_ll_iresp_bits_uop_is_amo),
    .io_in_0_bits_uop_uses_stq  (_memExeUnit_io_ll_iresp_bits_uop_uses_stq),
    .io_in_0_bits_uop_dst_rtype (_memExeUnit_io_ll_iresp_bits_uop_dst_rtype),
    .io_in_0_bits_data          (_memExeUnit_io_ll_iresp_bits_data[63:0]),
    .io_in_1_valid              (_FpPipeline_io_to_int_valid),
    .io_in_1_bits_uop_rob_idx   (_FpPipeline_io_to_int_bits_uop_rob_idx),
    .io_in_1_bits_uop_pdst      (_FpPipeline_io_to_int_bits_uop_pdst),
    .io_in_1_bits_uop_is_amo    (_FpPipeline_io_to_int_bits_uop_is_amo),
    .io_in_1_bits_uop_uses_stq  (_FpPipeline_io_to_int_bits_uop_uses_stq),
    .io_in_1_bits_uop_dst_rtype (_FpPipeline_io_to_int_bits_uop_dst_rtype),
    .io_in_1_bits_data          (_FpPipeline_io_to_int_bits_data),
    .io_in_1_bits_predicated    (_FpPipeline_io_to_int_bits_predicated),
    .io_in_1_ready              (_ll_wbarb_io_in_1_ready),
    .io_out_valid               (_ll_wbarb_io_out_valid),
    .io_out_bits_uop_rob_idx    (_ll_wbarb_io_out_bits_uop_rob_idx),
    .io_out_bits_uop_pdst       (_ll_wbarb_io_out_bits_uop_pdst),
    .io_out_bits_uop_is_amo     (_ll_wbarb_io_out_bits_uop_is_amo),
    .io_out_bits_uop_uses_stq   (_ll_wbarb_io_out_bits_uop_uses_stq),
    .io_out_bits_uop_dst_rtype  (_ll_wbarb_io_out_bits_uop_dst_rtype),
    .io_out_bits_data           (_ll_wbarb_io_out_bits_data),
    .io_out_bits_predicated     (_ll_wbarb_io_out_bits_predicated)
  );
  RegisterRead_1 iregister_read (
    .clock                               (clock),
    .reset                               (reset),
    .io_iss_valids_0                     (_mem_issue_unit_io_iss_valids_0 & ~(io_lsu_ld_miss & (_mem_issue_unit_io_iss_uops_0_iw_p1_poisoned | _mem_issue_unit_io_iss_uops_0_iw_p2_poisoned))),
    .io_iss_valids_1                     (_mem_issue_unit_io_iss_valids_1 & ~(io_lsu_ld_miss & (_mem_issue_unit_io_iss_uops_1_iw_p1_poisoned | _mem_issue_unit_io_iss_uops_1_iw_p2_poisoned))),
    .io_iss_valids_2                     (_int_issue_unit_io_iss_valids_0 & ~(io_lsu_ld_miss & _iregister_read_io_iss_valids_2_T)),
    .io_iss_valids_3                     (_int_issue_unit_io_iss_valids_1 & ~(io_lsu_ld_miss & _iregister_read_io_iss_valids_3_T)),
    .io_iss_valids_4                     (_int_issue_unit_io_iss_valids_2 & ~(io_lsu_ld_miss & _iregister_read_io_iss_valids_4_T)),
    .io_iss_valids_5                     (_int_issue_unit_io_iss_valids_3 & ~(io_lsu_ld_miss & _iregister_read_io_iss_valids_5_T)),
    .io_iss_uops_0_uopc                  (_mem_issue_unit_io_iss_uops_0_uopc),
    .io_iss_uops_0_fu_code               (_mem_issue_unit_io_iss_uops_0_fu_code),
    .io_iss_uops_0_br_mask               (_mem_issue_unit_io_iss_uops_0_br_mask),
    .io_iss_uops_0_imm_packed            (_mem_issue_unit_io_iss_uops_0_imm_packed),
    .io_iss_uops_0_rob_idx               (_mem_issue_unit_io_iss_uops_0_rob_idx),
    .io_iss_uops_0_ldq_idx               (_mem_issue_unit_io_iss_uops_0_ldq_idx),
    .io_iss_uops_0_stq_idx               (_mem_issue_unit_io_iss_uops_0_stq_idx),
    .io_iss_uops_0_pdst                  (_mem_issue_unit_io_iss_uops_0_pdst),
    .io_iss_uops_0_prs1                  (_mem_issue_unit_io_iss_uops_0_prs1),
    .io_iss_uops_0_prs2                  (_mem_issue_unit_io_iss_uops_0_prs2),
    .io_iss_uops_0_mem_cmd               (_mem_issue_unit_io_iss_uops_0_mem_cmd),
    .io_iss_uops_0_mem_size              (_mem_issue_unit_io_iss_uops_0_mem_size),
    .io_iss_uops_0_mem_signed            (_mem_issue_unit_io_iss_uops_0_mem_signed),
    .io_iss_uops_0_is_fence              (_mem_issue_unit_io_iss_uops_0_is_fence),
    .io_iss_uops_0_is_amo                (_mem_issue_unit_io_iss_uops_0_is_amo),
    .io_iss_uops_0_uses_ldq              (_mem_issue_unit_io_iss_uops_0_uses_ldq),
    .io_iss_uops_0_uses_stq              (_mem_issue_unit_io_iss_uops_0_uses_stq),
    .io_iss_uops_0_lrs1_rtype            (_mem_issue_unit_io_iss_uops_0_lrs1_rtype),
    .io_iss_uops_0_lrs2_rtype            (_mem_issue_unit_io_iss_uops_0_lrs2_rtype),
    .io_iss_uops_0_fp_val                (_mem_issue_unit_io_iss_uops_0_fp_val),
    .io_iss_uops_1_uopc                  (_mem_issue_unit_io_iss_uops_1_uopc),
    .io_iss_uops_1_fu_code               (_mem_issue_unit_io_iss_uops_1_fu_code),
    .io_iss_uops_1_br_mask               (_mem_issue_unit_io_iss_uops_1_br_mask),
    .io_iss_uops_1_imm_packed            (_mem_issue_unit_io_iss_uops_1_imm_packed),
    .io_iss_uops_1_rob_idx               (_mem_issue_unit_io_iss_uops_1_rob_idx),
    .io_iss_uops_1_ldq_idx               (_mem_issue_unit_io_iss_uops_1_ldq_idx),
    .io_iss_uops_1_stq_idx               (_mem_issue_unit_io_iss_uops_1_stq_idx),
    .io_iss_uops_1_pdst                  (_mem_issue_unit_io_iss_uops_1_pdst),
    .io_iss_uops_1_prs1                  (_mem_issue_unit_io_iss_uops_1_prs1),
    .io_iss_uops_1_prs2                  (_mem_issue_unit_io_iss_uops_1_prs2),
    .io_iss_uops_1_mem_cmd               (_mem_issue_unit_io_iss_uops_1_mem_cmd),
    .io_iss_uops_1_mem_size              (_mem_issue_unit_io_iss_uops_1_mem_size),
    .io_iss_uops_1_mem_signed            (_mem_issue_unit_io_iss_uops_1_mem_signed),
    .io_iss_uops_1_is_fence              (_mem_issue_unit_io_iss_uops_1_is_fence),
    .io_iss_uops_1_is_amo                (_mem_issue_unit_io_iss_uops_1_is_amo),
    .io_iss_uops_1_uses_ldq              (_mem_issue_unit_io_iss_uops_1_uses_ldq),
    .io_iss_uops_1_uses_stq              (_mem_issue_unit_io_iss_uops_1_uses_stq),
    .io_iss_uops_1_lrs1_rtype            (_mem_issue_unit_io_iss_uops_1_lrs1_rtype),
    .io_iss_uops_1_lrs2_rtype            (_mem_issue_unit_io_iss_uops_1_lrs2_rtype),
    .io_iss_uops_1_fp_val                (_mem_issue_unit_io_iss_uops_1_fp_val),
    .io_iss_uops_2_uopc                  (_int_issue_unit_io_iss_uops_0_uopc),
    .io_iss_uops_2_is_rvc                (_int_issue_unit_io_iss_uops_0_is_rvc),
    .io_iss_uops_2_fu_code               (_int_issue_unit_io_iss_uops_0_fu_code),
    .io_iss_uops_2_is_br                 (_int_issue_unit_io_iss_uops_0_is_br),
    .io_iss_uops_2_is_jalr               (_int_issue_unit_io_iss_uops_0_is_jalr),
    .io_iss_uops_2_is_jal                (_int_issue_unit_io_iss_uops_0_is_jal),
    .io_iss_uops_2_is_sfb                (_int_issue_unit_io_iss_uops_0_is_sfb),
    .io_iss_uops_2_br_mask               (_int_issue_unit_io_iss_uops_0_br_mask),
    .io_iss_uops_2_br_tag                (_int_issue_unit_io_iss_uops_0_br_tag),
    .io_iss_uops_2_ftq_idx               (_int_issue_unit_io_iss_uops_0_ftq_idx),
    .io_iss_uops_2_edge_inst             (_int_issue_unit_io_iss_uops_0_edge_inst),
    .io_iss_uops_2_pc_lob                (_int_issue_unit_io_iss_uops_0_pc_lob),
    .io_iss_uops_2_taken                 (_int_issue_unit_io_iss_uops_0_taken),
    .io_iss_uops_2_imm_packed            (_int_issue_unit_io_iss_uops_0_imm_packed),
    .io_iss_uops_2_rob_idx               (_int_issue_unit_io_iss_uops_0_rob_idx),
    .io_iss_uops_2_ldq_idx               (_int_issue_unit_io_iss_uops_0_ldq_idx),
    .io_iss_uops_2_stq_idx               (_int_issue_unit_io_iss_uops_0_stq_idx),
    .io_iss_uops_2_pdst                  (_int_issue_unit_io_iss_uops_0_pdst),
    .io_iss_uops_2_prs1                  (_int_issue_unit_io_iss_uops_0_prs1),
    .io_iss_uops_2_prs2                  (_int_issue_unit_io_iss_uops_0_prs2),
    .io_iss_uops_2_bypassable            (_int_issue_unit_io_iss_uops_0_bypassable),
    .io_iss_uops_2_mem_cmd               (_int_issue_unit_io_iss_uops_0_mem_cmd),
    .io_iss_uops_2_is_amo                (_int_issue_unit_io_iss_uops_0_is_amo),
    .io_iss_uops_2_uses_stq              (_int_issue_unit_io_iss_uops_0_uses_stq),
    .io_iss_uops_2_dst_rtype             (_int_issue_unit_io_iss_uops_0_dst_rtype),
    .io_iss_uops_2_lrs1_rtype            (_int_issue_unit_io_iss_uops_0_lrs1_rtype),
    .io_iss_uops_2_lrs2_rtype            (_int_issue_unit_io_iss_uops_0_lrs2_rtype),
    .io_iss_uops_2_fp_val                (_int_issue_unit_io_iss_uops_0_fp_val),
    .io_iss_uops_3_uopc                  (_int_issue_unit_io_iss_uops_1_uopc),
    .io_iss_uops_3_is_rvc                (_int_issue_unit_io_iss_uops_1_is_rvc),
    .io_iss_uops_3_fu_code               (_int_issue_unit_io_iss_uops_1_fu_code),
    .io_iss_uops_3_is_br                 (_int_issue_unit_io_iss_uops_1_is_br),
    .io_iss_uops_3_is_jalr               (_int_issue_unit_io_iss_uops_1_is_jalr),
    .io_iss_uops_3_is_jal                (_int_issue_unit_io_iss_uops_1_is_jal),
    .io_iss_uops_3_is_sfb                (_int_issue_unit_io_iss_uops_1_is_sfb),
    .io_iss_uops_3_br_mask               (_int_issue_unit_io_iss_uops_1_br_mask),
    .io_iss_uops_3_br_tag                (_int_issue_unit_io_iss_uops_1_br_tag),
    .io_iss_uops_3_ftq_idx               (_int_issue_unit_io_iss_uops_1_ftq_idx),
    .io_iss_uops_3_edge_inst             (_int_issue_unit_io_iss_uops_1_edge_inst),
    .io_iss_uops_3_pc_lob                (_int_issue_unit_io_iss_uops_1_pc_lob),
    .io_iss_uops_3_taken                 (_int_issue_unit_io_iss_uops_1_taken),
    .io_iss_uops_3_imm_packed            (_int_issue_unit_io_iss_uops_1_imm_packed),
    .io_iss_uops_3_rob_idx               (_int_issue_unit_io_iss_uops_1_rob_idx),
    .io_iss_uops_3_ldq_idx               (_int_issue_unit_io_iss_uops_1_ldq_idx),
    .io_iss_uops_3_stq_idx               (_int_issue_unit_io_iss_uops_1_stq_idx),
    .io_iss_uops_3_pdst                  (_int_issue_unit_io_iss_uops_1_pdst),
    .io_iss_uops_3_prs1                  (_int_issue_unit_io_iss_uops_1_prs1),
    .io_iss_uops_3_prs2                  (_int_issue_unit_io_iss_uops_1_prs2),
    .io_iss_uops_3_bypassable            (_int_issue_unit_io_iss_uops_1_bypassable),
    .io_iss_uops_3_mem_cmd               (_int_issue_unit_io_iss_uops_1_mem_cmd),
    .io_iss_uops_3_is_amo                (_int_issue_unit_io_iss_uops_1_is_amo),
    .io_iss_uops_3_uses_stq              (_int_issue_unit_io_iss_uops_1_uses_stq),
    .io_iss_uops_3_dst_rtype             (_int_issue_unit_io_iss_uops_1_dst_rtype),
    .io_iss_uops_3_lrs1_rtype            (_int_issue_unit_io_iss_uops_1_lrs1_rtype),
    .io_iss_uops_3_lrs2_rtype            (_int_issue_unit_io_iss_uops_1_lrs2_rtype),
    .io_iss_uops_4_uopc                  (_int_issue_unit_io_iss_uops_2_uopc),
    .io_iss_uops_4_is_rvc                (_int_issue_unit_io_iss_uops_2_is_rvc),
    .io_iss_uops_4_fu_code               (_int_issue_unit_io_iss_uops_2_fu_code),
    .io_iss_uops_4_is_br                 (_int_issue_unit_io_iss_uops_2_is_br),
    .io_iss_uops_4_is_jalr               (_int_issue_unit_io_iss_uops_2_is_jalr),
    .io_iss_uops_4_is_jal                (_int_issue_unit_io_iss_uops_2_is_jal),
    .io_iss_uops_4_is_sfb                (_int_issue_unit_io_iss_uops_2_is_sfb),
    .io_iss_uops_4_br_mask               (_int_issue_unit_io_iss_uops_2_br_mask),
    .io_iss_uops_4_br_tag                (_int_issue_unit_io_iss_uops_2_br_tag),
    .io_iss_uops_4_ftq_idx               (_int_issue_unit_io_iss_uops_2_ftq_idx),
    .io_iss_uops_4_edge_inst             (_int_issue_unit_io_iss_uops_2_edge_inst),
    .io_iss_uops_4_pc_lob                (_int_issue_unit_io_iss_uops_2_pc_lob),
    .io_iss_uops_4_taken                 (_int_issue_unit_io_iss_uops_2_taken),
    .io_iss_uops_4_imm_packed            (_int_issue_unit_io_iss_uops_2_imm_packed),
    .io_iss_uops_4_rob_idx               (_int_issue_unit_io_iss_uops_2_rob_idx),
    .io_iss_uops_4_ldq_idx               (_int_issue_unit_io_iss_uops_2_ldq_idx),
    .io_iss_uops_4_stq_idx               (_int_issue_unit_io_iss_uops_2_stq_idx),
    .io_iss_uops_4_pdst                  (_int_issue_unit_io_iss_uops_2_pdst),
    .io_iss_uops_4_prs1                  (_int_issue_unit_io_iss_uops_2_prs1),
    .io_iss_uops_4_prs2                  (_int_issue_unit_io_iss_uops_2_prs2),
    .io_iss_uops_4_bypassable            (_int_issue_unit_io_iss_uops_2_bypassable),
    .io_iss_uops_4_mem_cmd               (_int_issue_unit_io_iss_uops_2_mem_cmd),
    .io_iss_uops_4_is_amo                (_int_issue_unit_io_iss_uops_2_is_amo),
    .io_iss_uops_4_uses_stq              (_int_issue_unit_io_iss_uops_2_uses_stq),
    .io_iss_uops_4_dst_rtype             (_int_issue_unit_io_iss_uops_2_dst_rtype),
    .io_iss_uops_4_lrs1_rtype            (_int_issue_unit_io_iss_uops_2_lrs1_rtype),
    .io_iss_uops_4_lrs2_rtype            (_int_issue_unit_io_iss_uops_2_lrs2_rtype),
    .io_iss_uops_5_uopc                  (_int_issue_unit_io_iss_uops_3_uopc),
    .io_iss_uops_5_is_rvc                (_int_issue_unit_io_iss_uops_3_is_rvc),
    .io_iss_uops_5_fu_code               (_int_issue_unit_io_iss_uops_3_fu_code),
    .io_iss_uops_5_is_br                 (_int_issue_unit_io_iss_uops_3_is_br),
    .io_iss_uops_5_is_jalr               (_int_issue_unit_io_iss_uops_3_is_jalr),
    .io_iss_uops_5_is_jal                (_int_issue_unit_io_iss_uops_3_is_jal),
    .io_iss_uops_5_is_sfb                (_int_issue_unit_io_iss_uops_3_is_sfb),
    .io_iss_uops_5_br_mask               (_int_issue_unit_io_iss_uops_3_br_mask),
    .io_iss_uops_5_br_tag                (_int_issue_unit_io_iss_uops_3_br_tag),
    .io_iss_uops_5_ftq_idx               (_int_issue_unit_io_iss_uops_3_ftq_idx),
    .io_iss_uops_5_edge_inst             (_int_issue_unit_io_iss_uops_3_edge_inst),
    .io_iss_uops_5_pc_lob                (_int_issue_unit_io_iss_uops_3_pc_lob),
    .io_iss_uops_5_taken                 (_int_issue_unit_io_iss_uops_3_taken),
    .io_iss_uops_5_imm_packed            (_int_issue_unit_io_iss_uops_3_imm_packed),
    .io_iss_uops_5_rob_idx               (_int_issue_unit_io_iss_uops_3_rob_idx),
    .io_iss_uops_5_ldq_idx               (_int_issue_unit_io_iss_uops_3_ldq_idx),
    .io_iss_uops_5_stq_idx               (_int_issue_unit_io_iss_uops_3_stq_idx),
    .io_iss_uops_5_pdst                  (_int_issue_unit_io_iss_uops_3_pdst),
    .io_iss_uops_5_prs1                  (_int_issue_unit_io_iss_uops_3_prs1),
    .io_iss_uops_5_prs2                  (_int_issue_unit_io_iss_uops_3_prs2),
    .io_iss_uops_5_bypassable            (_int_issue_unit_io_iss_uops_3_bypassable),
    .io_iss_uops_5_mem_cmd               (_int_issue_unit_io_iss_uops_3_mem_cmd),
    .io_iss_uops_5_is_amo                (_int_issue_unit_io_iss_uops_3_is_amo),
    .io_iss_uops_5_uses_stq              (_int_issue_unit_io_iss_uops_3_uses_stq),
    .io_iss_uops_5_dst_rtype             (_int_issue_unit_io_iss_uops_3_dst_rtype),
    .io_iss_uops_5_lrs1_rtype            (_int_issue_unit_io_iss_uops_3_lrs1_rtype),
    .io_iss_uops_5_lrs2_rtype            (_int_issue_unit_io_iss_uops_3_lrs2_rtype),
    .io_rf_read_ports_0_data             (_iregfile_io_read_ports_0_data),
    .io_rf_read_ports_1_data             (_iregfile_io_read_ports_1_data),
    .io_rf_read_ports_2_data             (_iregfile_io_read_ports_2_data),
    .io_rf_read_ports_3_data             (_iregfile_io_read_ports_3_data),
    .io_rf_read_ports_4_data             (_iregfile_io_read_ports_4_data),
    .io_rf_read_ports_5_data             (_iregfile_io_read_ports_5_data),
    .io_rf_read_ports_6_data             (_iregfile_io_read_ports_6_data),
    .io_rf_read_ports_7_data             (_iregfile_io_read_ports_7_data),
    .io_rf_read_ports_8_data             (_iregfile_io_read_ports_8_data),
    .io_rf_read_ports_9_data             (_iregfile_io_read_ports_9_data),
    .io_rf_read_ports_10_data            (_iregfile_io_read_ports_10_data),
    .io_rf_read_ports_11_data            (_iregfile_io_read_ports_11_data),
    .io_bypass_0_valid                   (_alu_exe_unit_io_bypass_0_valid),
    .io_bypass_0_bits_uop_pdst           (_alu_exe_unit_io_bypass_0_bits_uop_pdst),
    .io_bypass_0_bits_uop_dst_rtype      (_alu_exe_unit_io_bypass_0_bits_uop_dst_rtype),
    .io_bypass_0_bits_data               (_alu_exe_unit_io_bypass_0_bits_data[63:0]),
    .io_bypass_1_valid                   (_alu_exe_unit_1_io_bypass_0_valid),
    .io_bypass_1_bits_uop_pdst           (_alu_exe_unit_1_io_bypass_0_bits_uop_pdst),
    .io_bypass_1_bits_uop_dst_rtype      (_alu_exe_unit_1_io_bypass_0_bits_uop_dst_rtype),
    .io_bypass_1_bits_data               (_alu_exe_unit_1_io_bypass_0_bits_data[63:0]),
    .io_bypass_2_valid                   (_alu_exe_unit_2_io_bypass_0_valid),
    .io_bypass_2_bits_uop_pdst           (_alu_exe_unit_2_io_bypass_0_bits_uop_pdst),
    .io_bypass_2_bits_uop_dst_rtype      (_alu_exe_unit_2_io_bypass_0_bits_uop_dst_rtype),
    .io_bypass_2_bits_data               (_alu_exe_unit_2_io_bypass_0_bits_data[63:0]),
    .io_bypass_3_valid                   (_alu_exe_unit_2_io_bypass_1_valid),
    .io_bypass_3_bits_uop_pdst           (_alu_exe_unit_2_io_bypass_1_bits_uop_pdst),
    .io_bypass_3_bits_uop_dst_rtype      (_alu_exe_unit_2_io_bypass_1_bits_uop_dst_rtype),
    .io_bypass_3_bits_data               (_alu_exe_unit_2_io_bypass_1_bits_data[63:0]),
    .io_bypass_4_valid                   (_alu_exe_unit_2_io_bypass_2_valid),
    .io_bypass_4_bits_uop_pdst           (_alu_exe_unit_2_io_bypass_2_bits_uop_pdst),
    .io_bypass_4_bits_uop_dst_rtype      (_alu_exe_unit_2_io_bypass_2_bits_uop_dst_rtype),
    .io_bypass_4_bits_data               (_alu_exe_unit_2_io_bypass_2_bits_data[63:0]),
    .io_bypass_5_valid                   (_alu_exe_unit_3_io_bypass_0_valid),
    .io_bypass_5_bits_uop_pdst           (_alu_exe_unit_3_io_bypass_0_bits_uop_pdst),
    .io_bypass_5_bits_uop_dst_rtype      (_alu_exe_unit_3_io_bypass_0_bits_uop_dst_rtype),
    .io_bypass_5_bits_data               (_alu_exe_unit_3_io_bypass_0_bits_data[63:0]),
    .io_kill                             (iregister_read_io_kill_REG),
    .io_brupdate_b1_resolve_mask         (_b1_resolve_mask_T_6),
    .io_brupdate_b1_mispredict_mask      (_b1_mispredict_mask_T_10),
    .io_rf_read_ports_0_addr             (_iregister_read_io_rf_read_ports_0_addr),
    .io_rf_read_ports_1_addr             (_iregister_read_io_rf_read_ports_1_addr),
    .io_rf_read_ports_2_addr             (_iregister_read_io_rf_read_ports_2_addr),
    .io_rf_read_ports_3_addr             (_iregister_read_io_rf_read_ports_3_addr),
    .io_rf_read_ports_4_addr             (_iregister_read_io_rf_read_ports_4_addr),
    .io_rf_read_ports_5_addr             (_iregister_read_io_rf_read_ports_5_addr),
    .io_rf_read_ports_6_addr             (_iregister_read_io_rf_read_ports_6_addr),
    .io_rf_read_ports_7_addr             (_iregister_read_io_rf_read_ports_7_addr),
    .io_rf_read_ports_8_addr             (_iregister_read_io_rf_read_ports_8_addr),
    .io_rf_read_ports_9_addr             (_iregister_read_io_rf_read_ports_9_addr),
    .io_rf_read_ports_10_addr            (_iregister_read_io_rf_read_ports_10_addr),
    .io_rf_read_ports_11_addr            (_iregister_read_io_rf_read_ports_11_addr),
    .io_exe_reqs_0_valid                 (_iregister_read_io_exe_reqs_0_valid),
    .io_exe_reqs_0_bits_uop_uopc         (_iregister_read_io_exe_reqs_0_bits_uop_uopc),
    .io_exe_reqs_0_bits_uop_fu_code      (_iregister_read_io_exe_reqs_0_bits_uop_fu_code),
    .io_exe_reqs_0_bits_uop_ctrl_is_load (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_load),
    .io_exe_reqs_0_bits_uop_ctrl_is_sta  (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_sta),
    .io_exe_reqs_0_bits_uop_ctrl_is_std  (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_std),
    .io_exe_reqs_0_bits_uop_br_mask      (_iregister_read_io_exe_reqs_0_bits_uop_br_mask),
    .io_exe_reqs_0_bits_uop_imm_packed   (_iregister_read_io_exe_reqs_0_bits_uop_imm_packed),
    .io_exe_reqs_0_bits_uop_rob_idx      (_iregister_read_io_exe_reqs_0_bits_uop_rob_idx),
    .io_exe_reqs_0_bits_uop_ldq_idx      (_iregister_read_io_exe_reqs_0_bits_uop_ldq_idx),
    .io_exe_reqs_0_bits_uop_stq_idx      (_iregister_read_io_exe_reqs_0_bits_uop_stq_idx),
    .io_exe_reqs_0_bits_uop_pdst         (_iregister_read_io_exe_reqs_0_bits_uop_pdst),
    .io_exe_reqs_0_bits_uop_mem_cmd      (_iregister_read_io_exe_reqs_0_bits_uop_mem_cmd),
    .io_exe_reqs_0_bits_uop_mem_size     (_iregister_read_io_exe_reqs_0_bits_uop_mem_size),
    .io_exe_reqs_0_bits_uop_mem_signed   (_iregister_read_io_exe_reqs_0_bits_uop_mem_signed),
    .io_exe_reqs_0_bits_uop_is_fence     (_iregister_read_io_exe_reqs_0_bits_uop_is_fence),
    .io_exe_reqs_0_bits_uop_is_amo       (_iregister_read_io_exe_reqs_0_bits_uop_is_amo),
    .io_exe_reqs_0_bits_uop_uses_ldq     (_iregister_read_io_exe_reqs_0_bits_uop_uses_ldq),
    .io_exe_reqs_0_bits_uop_uses_stq     (_iregister_read_io_exe_reqs_0_bits_uop_uses_stq),
    .io_exe_reqs_0_bits_uop_fp_val       (_iregister_read_io_exe_reqs_0_bits_uop_fp_val),
    .io_exe_reqs_0_bits_rs1_data         (_iregister_read_io_exe_reqs_0_bits_rs1_data),
    .io_exe_reqs_0_bits_rs2_data         (_iregister_read_io_exe_reqs_0_bits_rs2_data),
    .io_exe_reqs_1_valid                 (_iregister_read_io_exe_reqs_1_valid),
    .io_exe_reqs_1_bits_uop_uopc         (_iregister_read_io_exe_reqs_1_bits_uop_uopc),
    .io_exe_reqs_1_bits_uop_fu_code      (_iregister_read_io_exe_reqs_1_bits_uop_fu_code),
    .io_exe_reqs_1_bits_uop_ctrl_is_load (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_is_load),
    .io_exe_reqs_1_bits_uop_ctrl_is_sta  (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_is_sta),
    .io_exe_reqs_1_bits_uop_ctrl_is_std  (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_is_std),
    .io_exe_reqs_1_bits_uop_br_mask      (_iregister_read_io_exe_reqs_1_bits_uop_br_mask),
    .io_exe_reqs_1_bits_uop_imm_packed   (_iregister_read_io_exe_reqs_1_bits_uop_imm_packed),
    .io_exe_reqs_1_bits_uop_rob_idx      (_iregister_read_io_exe_reqs_1_bits_uop_rob_idx),
    .io_exe_reqs_1_bits_uop_ldq_idx      (_iregister_read_io_exe_reqs_1_bits_uop_ldq_idx),
    .io_exe_reqs_1_bits_uop_stq_idx      (_iregister_read_io_exe_reqs_1_bits_uop_stq_idx),
    .io_exe_reqs_1_bits_uop_pdst         (_iregister_read_io_exe_reqs_1_bits_uop_pdst),
    .io_exe_reqs_1_bits_uop_mem_cmd      (_iregister_read_io_exe_reqs_1_bits_uop_mem_cmd),
    .io_exe_reqs_1_bits_uop_mem_size     (_iregister_read_io_exe_reqs_1_bits_uop_mem_size),
    .io_exe_reqs_1_bits_uop_mem_signed   (_iregister_read_io_exe_reqs_1_bits_uop_mem_signed),
    .io_exe_reqs_1_bits_uop_is_fence     (_iregister_read_io_exe_reqs_1_bits_uop_is_fence),
    .io_exe_reqs_1_bits_uop_is_amo       (_iregister_read_io_exe_reqs_1_bits_uop_is_amo),
    .io_exe_reqs_1_bits_uop_uses_ldq     (_iregister_read_io_exe_reqs_1_bits_uop_uses_ldq),
    .io_exe_reqs_1_bits_uop_uses_stq     (_iregister_read_io_exe_reqs_1_bits_uop_uses_stq),
    .io_exe_reqs_1_bits_uop_fp_val       (_iregister_read_io_exe_reqs_1_bits_uop_fp_val),
    .io_exe_reqs_1_bits_rs1_data         (_iregister_read_io_exe_reqs_1_bits_rs1_data),
    .io_exe_reqs_1_bits_rs2_data         (_iregister_read_io_exe_reqs_1_bits_rs2_data),
    .io_exe_reqs_2_valid                 (_iregister_read_io_exe_reqs_2_valid),
    .io_exe_reqs_2_bits_uop_uopc         (_iregister_read_io_exe_reqs_2_bits_uop_uopc),
    .io_exe_reqs_2_bits_uop_is_rvc       (_iregister_read_io_exe_reqs_2_bits_uop_is_rvc),
    .io_exe_reqs_2_bits_uop_fu_code      (_iregister_read_io_exe_reqs_2_bits_uop_fu_code),
    .io_exe_reqs_2_bits_uop_ctrl_br_type (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_br_type),
    .io_exe_reqs_2_bits_uop_ctrl_op1_sel (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_op1_sel),
    .io_exe_reqs_2_bits_uop_ctrl_op2_sel (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_op2_sel),
    .io_exe_reqs_2_bits_uop_ctrl_imm_sel (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_imm_sel),
    .io_exe_reqs_2_bits_uop_ctrl_op_fcn  (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_op_fcn),
    .io_exe_reqs_2_bits_uop_ctrl_fcn_dw  (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_fcn_dw),
    .io_exe_reqs_2_bits_uop_is_br        (_iregister_read_io_exe_reqs_2_bits_uop_is_br),
    .io_exe_reqs_2_bits_uop_is_jalr      (_iregister_read_io_exe_reqs_2_bits_uop_is_jalr),
    .io_exe_reqs_2_bits_uop_is_jal       (_iregister_read_io_exe_reqs_2_bits_uop_is_jal),
    .io_exe_reqs_2_bits_uop_is_sfb       (_iregister_read_io_exe_reqs_2_bits_uop_is_sfb),
    .io_exe_reqs_2_bits_uop_br_mask      (_iregister_read_io_exe_reqs_2_bits_uop_br_mask),
    .io_exe_reqs_2_bits_uop_br_tag       (_iregister_read_io_exe_reqs_2_bits_uop_br_tag),
    .io_exe_reqs_2_bits_uop_ftq_idx      (_iregister_read_io_exe_reqs_2_bits_uop_ftq_idx),
    .io_exe_reqs_2_bits_uop_edge_inst    (_iregister_read_io_exe_reqs_2_bits_uop_edge_inst),
    .io_exe_reqs_2_bits_uop_pc_lob       (_iregister_read_io_exe_reqs_2_bits_uop_pc_lob),
    .io_exe_reqs_2_bits_uop_taken        (_iregister_read_io_exe_reqs_2_bits_uop_taken),
    .io_exe_reqs_2_bits_uop_imm_packed   (_iregister_read_io_exe_reqs_2_bits_uop_imm_packed),
    .io_exe_reqs_2_bits_uop_rob_idx      (_iregister_read_io_exe_reqs_2_bits_uop_rob_idx),
    .io_exe_reqs_2_bits_uop_ldq_idx      (_iregister_read_io_exe_reqs_2_bits_uop_ldq_idx),
    .io_exe_reqs_2_bits_uop_stq_idx      (_iregister_read_io_exe_reqs_2_bits_uop_stq_idx),
    .io_exe_reqs_2_bits_uop_pdst         (_iregister_read_io_exe_reqs_2_bits_uop_pdst),
    .io_exe_reqs_2_bits_uop_prs1         (_iregister_read_io_exe_reqs_2_bits_uop_prs1),
    .io_exe_reqs_2_bits_uop_bypassable   (_iregister_read_io_exe_reqs_2_bits_uop_bypassable),
    .io_exe_reqs_2_bits_uop_is_amo       (_iregister_read_io_exe_reqs_2_bits_uop_is_amo),
    .io_exe_reqs_2_bits_uop_uses_stq     (_iregister_read_io_exe_reqs_2_bits_uop_uses_stq),
    .io_exe_reqs_2_bits_uop_dst_rtype    (_iregister_read_io_exe_reqs_2_bits_uop_dst_rtype),
    .io_exe_reqs_2_bits_uop_fp_val       (_iregister_read_io_exe_reqs_2_bits_uop_fp_val),
    .io_exe_reqs_2_bits_rs1_data         (_iregister_read_io_exe_reqs_2_bits_rs1_data),
    .io_exe_reqs_2_bits_rs2_data         (_iregister_read_io_exe_reqs_2_bits_rs2_data),
    .io_exe_reqs_3_valid                 (_iregister_read_io_exe_reqs_3_valid),
    .io_exe_reqs_3_bits_uop_uopc         (_iregister_read_io_exe_reqs_3_bits_uop_uopc),
    .io_exe_reqs_3_bits_uop_is_rvc       (_iregister_read_io_exe_reqs_3_bits_uop_is_rvc),
    .io_exe_reqs_3_bits_uop_fu_code      (_iregister_read_io_exe_reqs_3_bits_uop_fu_code),
    .io_exe_reqs_3_bits_uop_ctrl_br_type (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_br_type),
    .io_exe_reqs_3_bits_uop_ctrl_op1_sel (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_op1_sel),
    .io_exe_reqs_3_bits_uop_ctrl_op2_sel (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_op2_sel),
    .io_exe_reqs_3_bits_uop_ctrl_imm_sel (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_imm_sel),
    .io_exe_reqs_3_bits_uop_ctrl_op_fcn  (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_op_fcn),
    .io_exe_reqs_3_bits_uop_ctrl_fcn_dw  (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_fcn_dw),
    .io_exe_reqs_3_bits_uop_ctrl_csr_cmd (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_csr_cmd),
    .io_exe_reqs_3_bits_uop_is_br        (_iregister_read_io_exe_reqs_3_bits_uop_is_br),
    .io_exe_reqs_3_bits_uop_is_jalr      (_iregister_read_io_exe_reqs_3_bits_uop_is_jalr),
    .io_exe_reqs_3_bits_uop_is_jal       (_iregister_read_io_exe_reqs_3_bits_uop_is_jal),
    .io_exe_reqs_3_bits_uop_is_sfb       (_iregister_read_io_exe_reqs_3_bits_uop_is_sfb),
    .io_exe_reqs_3_bits_uop_br_mask      (_iregister_read_io_exe_reqs_3_bits_uop_br_mask),
    .io_exe_reqs_3_bits_uop_br_tag       (_iregister_read_io_exe_reqs_3_bits_uop_br_tag),
    .io_exe_reqs_3_bits_uop_ftq_idx      (_iregister_read_io_exe_reqs_3_bits_uop_ftq_idx),
    .io_exe_reqs_3_bits_uop_edge_inst    (_iregister_read_io_exe_reqs_3_bits_uop_edge_inst),
    .io_exe_reqs_3_bits_uop_pc_lob       (_iregister_read_io_exe_reqs_3_bits_uop_pc_lob),
    .io_exe_reqs_3_bits_uop_taken        (_iregister_read_io_exe_reqs_3_bits_uop_taken),
    .io_exe_reqs_3_bits_uop_imm_packed   (_iregister_read_io_exe_reqs_3_bits_uop_imm_packed),
    .io_exe_reqs_3_bits_uop_rob_idx      (_iregister_read_io_exe_reqs_3_bits_uop_rob_idx),
    .io_exe_reqs_3_bits_uop_ldq_idx      (_iregister_read_io_exe_reqs_3_bits_uop_ldq_idx),
    .io_exe_reqs_3_bits_uop_stq_idx      (_iregister_read_io_exe_reqs_3_bits_uop_stq_idx),
    .io_exe_reqs_3_bits_uop_pdst         (_iregister_read_io_exe_reqs_3_bits_uop_pdst),
    .io_exe_reqs_3_bits_uop_prs1         (_iregister_read_io_exe_reqs_3_bits_uop_prs1),
    .io_exe_reqs_3_bits_uop_bypassable   (_iregister_read_io_exe_reqs_3_bits_uop_bypassable),
    .io_exe_reqs_3_bits_uop_is_amo       (_iregister_read_io_exe_reqs_3_bits_uop_is_amo),
    .io_exe_reqs_3_bits_uop_uses_stq     (_iregister_read_io_exe_reqs_3_bits_uop_uses_stq),
    .io_exe_reqs_3_bits_uop_dst_rtype    (_iregister_read_io_exe_reqs_3_bits_uop_dst_rtype),
    .io_exe_reqs_3_bits_rs1_data         (_iregister_read_io_exe_reqs_3_bits_rs1_data),
    .io_exe_reqs_3_bits_rs2_data         (_iregister_read_io_exe_reqs_3_bits_rs2_data),
    .io_exe_reqs_4_valid                 (_iregister_read_io_exe_reqs_4_valid),
    .io_exe_reqs_4_bits_uop_uopc         (_iregister_read_io_exe_reqs_4_bits_uop_uopc),
    .io_exe_reqs_4_bits_uop_is_rvc       (_iregister_read_io_exe_reqs_4_bits_uop_is_rvc),
    .io_exe_reqs_4_bits_uop_fu_code      (_iregister_read_io_exe_reqs_4_bits_uop_fu_code),
    .io_exe_reqs_4_bits_uop_ctrl_br_type (_iregister_read_io_exe_reqs_4_bits_uop_ctrl_br_type),
    .io_exe_reqs_4_bits_uop_ctrl_op1_sel (_iregister_read_io_exe_reqs_4_bits_uop_ctrl_op1_sel),
    .io_exe_reqs_4_bits_uop_ctrl_op2_sel (_iregister_read_io_exe_reqs_4_bits_uop_ctrl_op2_sel),
    .io_exe_reqs_4_bits_uop_ctrl_imm_sel (_iregister_read_io_exe_reqs_4_bits_uop_ctrl_imm_sel),
    .io_exe_reqs_4_bits_uop_ctrl_op_fcn  (_iregister_read_io_exe_reqs_4_bits_uop_ctrl_op_fcn),
    .io_exe_reqs_4_bits_uop_ctrl_fcn_dw  (_iregister_read_io_exe_reqs_4_bits_uop_ctrl_fcn_dw),
    .io_exe_reqs_4_bits_uop_is_br        (_iregister_read_io_exe_reqs_4_bits_uop_is_br),
    .io_exe_reqs_4_bits_uop_is_jalr      (_iregister_read_io_exe_reqs_4_bits_uop_is_jalr),
    .io_exe_reqs_4_bits_uop_is_jal       (_iregister_read_io_exe_reqs_4_bits_uop_is_jal),
    .io_exe_reqs_4_bits_uop_is_sfb       (_iregister_read_io_exe_reqs_4_bits_uop_is_sfb),
    .io_exe_reqs_4_bits_uop_br_mask      (_iregister_read_io_exe_reqs_4_bits_uop_br_mask),
    .io_exe_reqs_4_bits_uop_br_tag       (_iregister_read_io_exe_reqs_4_bits_uop_br_tag),
    .io_exe_reqs_4_bits_uop_ftq_idx      (_iregister_read_io_exe_reqs_4_bits_uop_ftq_idx),
    .io_exe_reqs_4_bits_uop_edge_inst    (_iregister_read_io_exe_reqs_4_bits_uop_edge_inst),
    .io_exe_reqs_4_bits_uop_pc_lob       (_iregister_read_io_exe_reqs_4_bits_uop_pc_lob),
    .io_exe_reqs_4_bits_uop_taken        (_iregister_read_io_exe_reqs_4_bits_uop_taken),
    .io_exe_reqs_4_bits_uop_imm_packed   (_iregister_read_io_exe_reqs_4_bits_uop_imm_packed),
    .io_exe_reqs_4_bits_uop_rob_idx      (_iregister_read_io_exe_reqs_4_bits_uop_rob_idx),
    .io_exe_reqs_4_bits_uop_ldq_idx      (_iregister_read_io_exe_reqs_4_bits_uop_ldq_idx),
    .io_exe_reqs_4_bits_uop_stq_idx      (_iregister_read_io_exe_reqs_4_bits_uop_stq_idx),
    .io_exe_reqs_4_bits_uop_pdst         (_iregister_read_io_exe_reqs_4_bits_uop_pdst),
    .io_exe_reqs_4_bits_uop_prs1         (_iregister_read_io_exe_reqs_4_bits_uop_prs1),
    .io_exe_reqs_4_bits_uop_bypassable   (_iregister_read_io_exe_reqs_4_bits_uop_bypassable),
    .io_exe_reqs_4_bits_uop_is_amo       (_iregister_read_io_exe_reqs_4_bits_uop_is_amo),
    .io_exe_reqs_4_bits_uop_uses_stq     (_iregister_read_io_exe_reqs_4_bits_uop_uses_stq),
    .io_exe_reqs_4_bits_uop_dst_rtype    (_iregister_read_io_exe_reqs_4_bits_uop_dst_rtype),
    .io_exe_reqs_4_bits_rs1_data         (_iregister_read_io_exe_reqs_4_bits_rs1_data),
    .io_exe_reqs_4_bits_rs2_data         (_iregister_read_io_exe_reqs_4_bits_rs2_data),
    .io_exe_reqs_5_valid                 (_iregister_read_io_exe_reqs_5_valid),
    .io_exe_reqs_5_bits_uop_uopc         (_iregister_read_io_exe_reqs_5_bits_uop_uopc),
    .io_exe_reqs_5_bits_uop_is_rvc       (_iregister_read_io_exe_reqs_5_bits_uop_is_rvc),
    .io_exe_reqs_5_bits_uop_fu_code      (_iregister_read_io_exe_reqs_5_bits_uop_fu_code),
    .io_exe_reqs_5_bits_uop_ctrl_br_type (_iregister_read_io_exe_reqs_5_bits_uop_ctrl_br_type),
    .io_exe_reqs_5_bits_uop_ctrl_op1_sel (_iregister_read_io_exe_reqs_5_bits_uop_ctrl_op1_sel),
    .io_exe_reqs_5_bits_uop_ctrl_op2_sel (_iregister_read_io_exe_reqs_5_bits_uop_ctrl_op2_sel),
    .io_exe_reqs_5_bits_uop_ctrl_imm_sel (_iregister_read_io_exe_reqs_5_bits_uop_ctrl_imm_sel),
    .io_exe_reqs_5_bits_uop_ctrl_op_fcn  (_iregister_read_io_exe_reqs_5_bits_uop_ctrl_op_fcn),
    .io_exe_reqs_5_bits_uop_ctrl_fcn_dw  (_iregister_read_io_exe_reqs_5_bits_uop_ctrl_fcn_dw),
    .io_exe_reqs_5_bits_uop_ctrl_csr_cmd (_iregister_read_io_exe_reqs_5_bits_uop_ctrl_csr_cmd),
    .io_exe_reqs_5_bits_uop_is_br        (_iregister_read_io_exe_reqs_5_bits_uop_is_br),
    .io_exe_reqs_5_bits_uop_is_jalr      (_iregister_read_io_exe_reqs_5_bits_uop_is_jalr),
    .io_exe_reqs_5_bits_uop_is_jal       (_iregister_read_io_exe_reqs_5_bits_uop_is_jal),
    .io_exe_reqs_5_bits_uop_is_sfb       (_iregister_read_io_exe_reqs_5_bits_uop_is_sfb),
    .io_exe_reqs_5_bits_uop_br_mask      (_iregister_read_io_exe_reqs_5_bits_uop_br_mask),
    .io_exe_reqs_5_bits_uop_br_tag       (_iregister_read_io_exe_reqs_5_bits_uop_br_tag),
    .io_exe_reqs_5_bits_uop_ftq_idx      (_iregister_read_io_exe_reqs_5_bits_uop_ftq_idx),
    .io_exe_reqs_5_bits_uop_edge_inst    (_iregister_read_io_exe_reqs_5_bits_uop_edge_inst),
    .io_exe_reqs_5_bits_uop_pc_lob       (_iregister_read_io_exe_reqs_5_bits_uop_pc_lob),
    .io_exe_reqs_5_bits_uop_taken        (_iregister_read_io_exe_reqs_5_bits_uop_taken),
    .io_exe_reqs_5_bits_uop_imm_packed   (_iregister_read_io_exe_reqs_5_bits_uop_imm_packed),
    .io_exe_reqs_5_bits_uop_rob_idx      (_iregister_read_io_exe_reqs_5_bits_uop_rob_idx),
    .io_exe_reqs_5_bits_uop_ldq_idx      (_iregister_read_io_exe_reqs_5_bits_uop_ldq_idx),
    .io_exe_reqs_5_bits_uop_stq_idx      (_iregister_read_io_exe_reqs_5_bits_uop_stq_idx),
    .io_exe_reqs_5_bits_uop_pdst         (_iregister_read_io_exe_reqs_5_bits_uop_pdst),
    .io_exe_reqs_5_bits_uop_prs1         (_iregister_read_io_exe_reqs_5_bits_uop_prs1),
    .io_exe_reqs_5_bits_uop_bypassable   (_iregister_read_io_exe_reqs_5_bits_uop_bypassable),
    .io_exe_reqs_5_bits_uop_is_amo       (_iregister_read_io_exe_reqs_5_bits_uop_is_amo),
    .io_exe_reqs_5_bits_uop_uses_stq     (_iregister_read_io_exe_reqs_5_bits_uop_uses_stq),
    .io_exe_reqs_5_bits_uop_dst_rtype    (_iregister_read_io_exe_reqs_5_bits_uop_dst_rtype),
    .io_exe_reqs_5_bits_rs1_data         (_iregister_read_io_exe_reqs_5_bits_rs1_data),
    .io_exe_reqs_5_bits_rs2_data         (_iregister_read_io_exe_reqs_5_bits_rs2_data)
  );
  Rob rob (
    .clock                          (clock),
    .reset                          (reset),
    .io_enq_valids_0                (dis_fire_0),
    .io_enq_valids_1                (dis_fire_1),
    .io_enq_valids_2                (dis_fire_2),
    .io_enq_valids_3                (dis_fire_3),
    .io_enq_uops_0_uopc             (_rename_stage_io_ren2_uops_0_uopc),
    .io_enq_uops_0_is_rvc           (_rename_stage_io_ren2_uops_0_is_rvc),
    .io_enq_uops_0_is_br            (_rename_stage_io_ren2_uops_0_is_br),
    .io_enq_uops_0_is_jalr          (_rename_stage_io_ren2_uops_0_is_jalr),
    .io_enq_uops_0_br_mask          (_rename_stage_io_ren2_uops_0_br_mask),
    .io_enq_uops_0_ftq_idx          (_rename_stage_io_ren2_uops_0_ftq_idx),
    .io_enq_uops_0_edge_inst        (_rename_stage_io_ren2_uops_0_edge_inst),
    .io_enq_uops_0_pc_lob           (_rename_stage_io_ren2_uops_0_pc_lob),
    .io_enq_uops_0_rob_idx          (dis_uops_0_rob_idx),
    .io_enq_uops_0_pdst             (dis_uops_0_pdst),
    .io_enq_uops_0_stale_pdst       (_dis_uops_0_stale_pdst_T ? _fp_rename_stage_io_ren2_uops_0_stale_pdst : _rename_stage_io_ren2_uops_0_stale_pdst),
    .io_enq_uops_0_exception        (_rename_stage_io_ren2_uops_0_exception),
    .io_enq_uops_0_exc_cause        (_rename_stage_io_ren2_uops_0_exc_cause),
    .io_enq_uops_0_is_fence         (_rename_stage_io_ren2_uops_0_is_fence),
    .io_enq_uops_0_is_fencei        (_rename_stage_io_ren2_uops_0_is_fencei),
    .io_enq_uops_0_uses_ldq         (_rename_stage_io_ren2_uops_0_uses_ldq),
    .io_enq_uops_0_uses_stq         (_rename_stage_io_ren2_uops_0_uses_stq),
    .io_enq_uops_0_is_sys_pc2epc    (_rename_stage_io_ren2_uops_0_is_sys_pc2epc),
    .io_enq_uops_0_is_unique        (_rename_stage_io_ren2_uops_0_is_unique),
    .io_enq_uops_0_flush_on_commit  (_rename_stage_io_ren2_uops_0_flush_on_commit),
    .io_enq_uops_0_ldst             (_rename_stage_io_ren2_uops_0_ldst),
    .io_enq_uops_0_ldst_val         (_rename_stage_io_ren2_uops_0_ldst_val),
    .io_enq_uops_0_dst_rtype        (_rename_stage_io_ren2_uops_0_dst_rtype),
    .io_enq_uops_0_fp_val           (_rename_stage_io_ren2_uops_0_fp_val),
    .io_enq_uops_1_uopc             (_rename_stage_io_ren2_uops_1_uopc),
    .io_enq_uops_1_is_rvc           (_rename_stage_io_ren2_uops_1_is_rvc),
    .io_enq_uops_1_is_br            (_rename_stage_io_ren2_uops_1_is_br),
    .io_enq_uops_1_is_jalr          (_rename_stage_io_ren2_uops_1_is_jalr),
    .io_enq_uops_1_br_mask          (_rename_stage_io_ren2_uops_1_br_mask),
    .io_enq_uops_1_ftq_idx          (_rename_stage_io_ren2_uops_1_ftq_idx),
    .io_enq_uops_1_edge_inst        (_rename_stage_io_ren2_uops_1_edge_inst),
    .io_enq_uops_1_pc_lob           (_rename_stage_io_ren2_uops_1_pc_lob),
    .io_enq_uops_1_rob_idx          (dis_uops_1_rob_idx),
    .io_enq_uops_1_pdst             (dis_uops_1_pdst),
    .io_enq_uops_1_stale_pdst       (_dis_uops_1_stale_pdst_T ? _fp_rename_stage_io_ren2_uops_1_stale_pdst : _rename_stage_io_ren2_uops_1_stale_pdst),
    .io_enq_uops_1_exception        (_rename_stage_io_ren2_uops_1_exception),
    .io_enq_uops_1_exc_cause        (_rename_stage_io_ren2_uops_1_exc_cause),
    .io_enq_uops_1_is_fence         (_rename_stage_io_ren2_uops_1_is_fence),
    .io_enq_uops_1_is_fencei        (_rename_stage_io_ren2_uops_1_is_fencei),
    .io_enq_uops_1_uses_ldq         (_rename_stage_io_ren2_uops_1_uses_ldq),
    .io_enq_uops_1_uses_stq         (_rename_stage_io_ren2_uops_1_uses_stq),
    .io_enq_uops_1_is_sys_pc2epc    (_rename_stage_io_ren2_uops_1_is_sys_pc2epc),
    .io_enq_uops_1_is_unique        (_rename_stage_io_ren2_uops_1_is_unique),
    .io_enq_uops_1_flush_on_commit  (_rename_stage_io_ren2_uops_1_flush_on_commit),
    .io_enq_uops_1_ldst             (_rename_stage_io_ren2_uops_1_ldst),
    .io_enq_uops_1_ldst_val         (_rename_stage_io_ren2_uops_1_ldst_val),
    .io_enq_uops_1_dst_rtype        (_rename_stage_io_ren2_uops_1_dst_rtype),
    .io_enq_uops_1_fp_val           (_rename_stage_io_ren2_uops_1_fp_val),
    .io_enq_uops_2_uopc             (_rename_stage_io_ren2_uops_2_uopc),
    .io_enq_uops_2_is_rvc           (_rename_stage_io_ren2_uops_2_is_rvc),
    .io_enq_uops_2_is_br            (_rename_stage_io_ren2_uops_2_is_br),
    .io_enq_uops_2_is_jalr          (_rename_stage_io_ren2_uops_2_is_jalr),
    .io_enq_uops_2_br_mask          (_rename_stage_io_ren2_uops_2_br_mask),
    .io_enq_uops_2_ftq_idx          (_rename_stage_io_ren2_uops_2_ftq_idx),
    .io_enq_uops_2_edge_inst        (_rename_stage_io_ren2_uops_2_edge_inst),
    .io_enq_uops_2_pc_lob           (_rename_stage_io_ren2_uops_2_pc_lob),
    .io_enq_uops_2_rob_idx          (dis_uops_2_rob_idx),
    .io_enq_uops_2_pdst             (dis_uops_2_pdst),
    .io_enq_uops_2_stale_pdst       (_dis_uops_2_stale_pdst_T ? _fp_rename_stage_io_ren2_uops_2_stale_pdst : _rename_stage_io_ren2_uops_2_stale_pdst),
    .io_enq_uops_2_exception        (_rename_stage_io_ren2_uops_2_exception),
    .io_enq_uops_2_exc_cause        (_rename_stage_io_ren2_uops_2_exc_cause),
    .io_enq_uops_2_is_fence         (_rename_stage_io_ren2_uops_2_is_fence),
    .io_enq_uops_2_is_fencei        (_rename_stage_io_ren2_uops_2_is_fencei),
    .io_enq_uops_2_uses_ldq         (_rename_stage_io_ren2_uops_2_uses_ldq),
    .io_enq_uops_2_uses_stq         (_rename_stage_io_ren2_uops_2_uses_stq),
    .io_enq_uops_2_is_sys_pc2epc    (_rename_stage_io_ren2_uops_2_is_sys_pc2epc),
    .io_enq_uops_2_is_unique        (_rename_stage_io_ren2_uops_2_is_unique),
    .io_enq_uops_2_flush_on_commit  (_rename_stage_io_ren2_uops_2_flush_on_commit),
    .io_enq_uops_2_ldst             (_rename_stage_io_ren2_uops_2_ldst),
    .io_enq_uops_2_ldst_val         (_rename_stage_io_ren2_uops_2_ldst_val),
    .io_enq_uops_2_dst_rtype        (_rename_stage_io_ren2_uops_2_dst_rtype),
    .io_enq_uops_2_fp_val           (_rename_stage_io_ren2_uops_2_fp_val),
    .io_enq_uops_3_uopc             (_rename_stage_io_ren2_uops_3_uopc),
    .io_enq_uops_3_is_rvc           (_rename_stage_io_ren2_uops_3_is_rvc),
    .io_enq_uops_3_is_br            (_rename_stage_io_ren2_uops_3_is_br),
    .io_enq_uops_3_is_jalr          (_rename_stage_io_ren2_uops_3_is_jalr),
    .io_enq_uops_3_br_mask          (_rename_stage_io_ren2_uops_3_br_mask),
    .io_enq_uops_3_ftq_idx          (_rename_stage_io_ren2_uops_3_ftq_idx),
    .io_enq_uops_3_edge_inst        (_rename_stage_io_ren2_uops_3_edge_inst),
    .io_enq_uops_3_pc_lob           (_rename_stage_io_ren2_uops_3_pc_lob),
    .io_enq_uops_3_rob_idx          (dis_uops_3_rob_idx),
    .io_enq_uops_3_pdst             (dis_uops_3_pdst),
    .io_enq_uops_3_stale_pdst       (_dis_uops_3_stale_pdst_T ? _fp_rename_stage_io_ren2_uops_3_stale_pdst : _rename_stage_io_ren2_uops_3_stale_pdst),
    .io_enq_uops_3_exception        (_rename_stage_io_ren2_uops_3_exception),
    .io_enq_uops_3_exc_cause        (_rename_stage_io_ren2_uops_3_exc_cause),
    .io_enq_uops_3_is_fence         (_rename_stage_io_ren2_uops_3_is_fence),
    .io_enq_uops_3_is_fencei        (_rename_stage_io_ren2_uops_3_is_fencei),
    .io_enq_uops_3_uses_ldq         (_rename_stage_io_ren2_uops_3_uses_ldq),
    .io_enq_uops_3_uses_stq         (_rename_stage_io_ren2_uops_3_uses_stq),
    .io_enq_uops_3_is_sys_pc2epc    (_rename_stage_io_ren2_uops_3_is_sys_pc2epc),
    .io_enq_uops_3_is_unique        (_rename_stage_io_ren2_uops_3_is_unique),
    .io_enq_uops_3_flush_on_commit  (_rename_stage_io_ren2_uops_3_flush_on_commit),
    .io_enq_uops_3_ldst             (_rename_stage_io_ren2_uops_3_ldst),
    .io_enq_uops_3_ldst_val         (_rename_stage_io_ren2_uops_3_ldst_val),
    .io_enq_uops_3_dst_rtype        (_rename_stage_io_ren2_uops_3_dst_rtype),
    .io_enq_uops_3_fp_val           (_rename_stage_io_ren2_uops_3_fp_val),
    .io_enq_partial_stall           (dis_stalls_3),
    .io_xcpt_fetch_pc               (io_ifu_get_pc_0_pc),
    .io_brupdate_b1_resolve_mask    (_b1_resolve_mask_T_6),
    .io_brupdate_b1_mispredict_mask (_b1_mispredict_mask_T_10),
    .io_brupdate_b2_uop_rob_idx     (b2_uop_rob_idx),
    .io_brupdate_b2_mispredict      (b2_mispredict),
    .io_wb_resps_0_valid            (_ll_wbarb_io_out_valid & ~(_ll_wbarb_io_out_bits_uop_uses_stq & ~_ll_wbarb_io_out_bits_uop_is_amo)),
    .io_wb_resps_0_bits_uop_rob_idx (_ll_wbarb_io_out_bits_uop_rob_idx),
    .io_wb_resps_0_bits_uop_pdst    (_ll_wbarb_io_out_bits_uop_pdst),
    .io_wb_resps_0_bits_predicated  (_ll_wbarb_io_out_bits_predicated),
    .io_wb_resps_1_valid            (_memExeUnit_1_io_ll_iresp_valid & ~(_memExeUnit_1_io_ll_iresp_bits_uop_uses_stq & ~_memExeUnit_1_io_ll_iresp_bits_uop_is_amo)),
    .io_wb_resps_1_bits_uop_rob_idx (_memExeUnit_1_io_ll_iresp_bits_uop_rob_idx),
    .io_wb_resps_1_bits_uop_pdst    (_memExeUnit_1_io_ll_iresp_bits_uop_pdst),
    .io_wb_resps_2_valid            (_alu_exe_unit_io_iresp_valid & ~(_alu_exe_unit_io_iresp_bits_uop_uses_stq & ~_alu_exe_unit_io_iresp_bits_uop_is_amo)),
    .io_wb_resps_2_bits_uop_rob_idx (_alu_exe_unit_io_iresp_bits_uop_rob_idx),
    .io_wb_resps_2_bits_uop_pdst    (_alu_exe_unit_io_iresp_bits_uop_pdst),
    .io_wb_resps_3_valid            (_alu_exe_unit_1_io_iresp_valid & ~(_alu_exe_unit_1_io_iresp_bits_uop_uses_stq & ~_alu_exe_unit_1_io_iresp_bits_uop_is_amo)),
    .io_wb_resps_3_bits_uop_rob_idx (_alu_exe_unit_1_io_iresp_bits_uop_rob_idx),
    .io_wb_resps_3_bits_uop_pdst    (_alu_exe_unit_1_io_iresp_bits_uop_pdst),
    .io_wb_resps_4_valid            (_alu_exe_unit_2_io_iresp_valid & ~(_alu_exe_unit_2_io_iresp_bits_uop_uses_stq & ~_alu_exe_unit_2_io_iresp_bits_uop_is_amo)),
    .io_wb_resps_4_bits_uop_rob_idx (_alu_exe_unit_2_io_iresp_bits_uop_rob_idx),
    .io_wb_resps_4_bits_uop_pdst    (_alu_exe_unit_2_io_iresp_bits_uop_pdst),
    .io_wb_resps_5_valid            (_alu_exe_unit_3_io_iresp_valid & ~(_alu_exe_unit_3_io_iresp_bits_uop_uses_stq & ~_alu_exe_unit_3_io_iresp_bits_uop_is_amo)),
    .io_wb_resps_5_bits_uop_rob_idx (_alu_exe_unit_3_io_iresp_bits_uop_rob_idx),
    .io_wb_resps_5_bits_uop_pdst    (_alu_exe_unit_3_io_iresp_bits_uop_pdst),
    .io_wb_resps_6_valid            (_FpPipeline_io_wakeups_0_valid),
    .io_wb_resps_6_bits_uop_rob_idx (_FpPipeline_io_wakeups_0_bits_uop_rob_idx),
    .io_wb_resps_6_bits_uop_pdst    (_FpPipeline_io_wakeups_0_bits_uop_pdst),
    .io_wb_resps_6_bits_predicated  (_FpPipeline_io_wakeups_0_bits_predicated),
    .io_wb_resps_7_valid            (_FpPipeline_io_wakeups_1_valid),
    .io_wb_resps_7_bits_uop_rob_idx (_FpPipeline_io_wakeups_1_bits_uop_rob_idx),
    .io_wb_resps_7_bits_uop_pdst    (_FpPipeline_io_wakeups_1_bits_uop_pdst),
    .io_wb_resps_8_valid            (_FpPipeline_io_wakeups_2_valid),
    .io_wb_resps_8_bits_uop_rob_idx (_FpPipeline_io_wakeups_2_bits_uop_rob_idx),
    .io_wb_resps_8_bits_uop_pdst    (_FpPipeline_io_wakeups_2_bits_uop_pdst),
    .io_wb_resps_9_valid            (_FpPipeline_io_wakeups_3_valid),
    .io_wb_resps_9_bits_uop_rob_idx (_FpPipeline_io_wakeups_3_bits_uop_rob_idx),
    .io_wb_resps_9_bits_uop_pdst    (_FpPipeline_io_wakeups_3_bits_uop_pdst),
    .io_lsu_clr_bsy_0_valid         (io_lsu_clr_bsy_0_valid),
    .io_lsu_clr_bsy_0_bits          (io_lsu_clr_bsy_0_bits),
    .io_lsu_clr_bsy_1_valid         (io_lsu_clr_bsy_1_valid),
    .io_lsu_clr_bsy_1_bits          (io_lsu_clr_bsy_1_bits),
    .io_lsu_clr_bsy_2_valid         (io_lsu_clr_bsy_2_valid),
    .io_lsu_clr_bsy_2_bits          (io_lsu_clr_bsy_2_bits),
    .io_fflags_0_valid              (_FpPipeline_io_wakeups_0_bits_fflags_valid),
    .io_fflags_0_bits_uop_rob_idx   (_FpPipeline_io_wakeups_0_bits_fflags_bits_uop_rob_idx),
    .io_fflags_0_bits_flags         (_FpPipeline_io_wakeups_0_bits_fflags_bits_flags),
    .io_fflags_2_valid              (_FpPipeline_io_wakeups_2_bits_fflags_valid),
    .io_fflags_2_bits_uop_rob_idx   (_FpPipeline_io_wakeups_2_bits_fflags_bits_uop_rob_idx),
    .io_fflags_2_bits_flags         (_FpPipeline_io_wakeups_2_bits_fflags_bits_flags),
    .io_fflags_3_valid              (_FpPipeline_io_wakeups_3_bits_fflags_valid),
    .io_fflags_3_bits_uop_rob_idx   (_FpPipeline_io_wakeups_3_bits_fflags_bits_uop_rob_idx),
    .io_fflags_3_bits_flags         (_FpPipeline_io_wakeups_3_bits_fflags_bits_flags),
    .io_lxcpt_valid                 (io_lsu_lxcpt_valid),
    .io_lxcpt_bits_uop_br_mask      (io_lsu_lxcpt_bits_uop_br_mask),
    .io_lxcpt_bits_uop_rob_idx      (io_lsu_lxcpt_bits_uop_rob_idx),
    .io_lxcpt_bits_cause            (io_lsu_lxcpt_bits_cause),
    .io_lxcpt_bits_badvaddr         (io_lsu_lxcpt_bits_badvaddr),
    .io_csr_stall                   (_csr_io_csr_stall),
    .io_rob_tail_idx                (_rob_io_rob_tail_idx),
    .io_rob_head_idx                (_rob_io_rob_head_idx),
    .io_commit_valids_0             (_rob_io_commit_valids_0),
    .io_commit_valids_1             (_rob_io_commit_valids_1),
    .io_commit_valids_2             (_rob_io_commit_valids_2),
    .io_commit_valids_3             (_rob_io_commit_valids_3),
    .io_commit_arch_valids_0        (_rob_io_commit_arch_valids_0),
    .io_commit_arch_valids_1        (_rob_io_commit_arch_valids_1),
    .io_commit_arch_valids_2        (_rob_io_commit_arch_valids_2),
    .io_commit_arch_valids_3        (_rob_io_commit_arch_valids_3),
    .io_commit_uops_0_ftq_idx       (_rob_io_commit_uops_0_ftq_idx),
    .io_commit_uops_0_pdst          (_rob_io_commit_uops_0_pdst),
    .io_commit_uops_0_stale_pdst    (_rob_io_commit_uops_0_stale_pdst),
    .io_commit_uops_0_is_fencei     (_rob_io_commit_uops_0_is_fencei),
    .io_commit_uops_0_uses_ldq      (io_lsu_commit_uops_0_uses_ldq),
    .io_commit_uops_0_uses_stq      (io_lsu_commit_uops_0_uses_stq),
    .io_commit_uops_0_ldst          (_rob_io_commit_uops_0_ldst),
    .io_commit_uops_0_ldst_val      (_rob_io_commit_uops_0_ldst_val),
    .io_commit_uops_0_dst_rtype     (_rob_io_commit_uops_0_dst_rtype),
    .io_commit_uops_1_ftq_idx       (_rob_io_commit_uops_1_ftq_idx),
    .io_commit_uops_1_pdst          (_rob_io_commit_uops_1_pdst),
    .io_commit_uops_1_stale_pdst    (_rob_io_commit_uops_1_stale_pdst),
    .io_commit_uops_1_is_fencei     (_rob_io_commit_uops_1_is_fencei),
    .io_commit_uops_1_uses_ldq      (io_lsu_commit_uops_1_uses_ldq),
    .io_commit_uops_1_uses_stq      (io_lsu_commit_uops_1_uses_stq),
    .io_commit_uops_1_ldst          (_rob_io_commit_uops_1_ldst),
    .io_commit_uops_1_ldst_val      (_rob_io_commit_uops_1_ldst_val),
    .io_commit_uops_1_dst_rtype     (_rob_io_commit_uops_1_dst_rtype),
    .io_commit_uops_2_ftq_idx       (_rob_io_commit_uops_2_ftq_idx),
    .io_commit_uops_2_pdst          (_rob_io_commit_uops_2_pdst),
    .io_commit_uops_2_stale_pdst    (_rob_io_commit_uops_2_stale_pdst),
    .io_commit_uops_2_is_fencei     (_rob_io_commit_uops_2_is_fencei),
    .io_commit_uops_2_uses_ldq      (io_lsu_commit_uops_2_uses_ldq),
    .io_commit_uops_2_uses_stq      (io_lsu_commit_uops_2_uses_stq),
    .io_commit_uops_2_ldst          (_rob_io_commit_uops_2_ldst),
    .io_commit_uops_2_ldst_val      (_rob_io_commit_uops_2_ldst_val),
    .io_commit_uops_2_dst_rtype     (_rob_io_commit_uops_2_dst_rtype),
    .io_commit_uops_3_ftq_idx       (_rob_io_commit_uops_3_ftq_idx),
    .io_commit_uops_3_pdst          (_rob_io_commit_uops_3_pdst),
    .io_commit_uops_3_stale_pdst    (_rob_io_commit_uops_3_stale_pdst),
    .io_commit_uops_3_is_fencei     (_rob_io_commit_uops_3_is_fencei),
    .io_commit_uops_3_uses_ldq      (io_lsu_commit_uops_3_uses_ldq),
    .io_commit_uops_3_uses_stq      (io_lsu_commit_uops_3_uses_stq),
    .io_commit_uops_3_ldst          (_rob_io_commit_uops_3_ldst),
    .io_commit_uops_3_ldst_val      (_rob_io_commit_uops_3_ldst_val),
    .io_commit_uops_3_dst_rtype     (_rob_io_commit_uops_3_dst_rtype),
    .io_commit_fflags_valid         (_rob_io_commit_fflags_valid),
    .io_commit_fflags_bits          (_rob_io_commit_fflags_bits),
    .io_commit_rbk_valids_0         (_rob_io_commit_rbk_valids_0),
    .io_commit_rbk_valids_1         (_rob_io_commit_rbk_valids_1),
    .io_commit_rbk_valids_2         (_rob_io_commit_rbk_valids_2),
    .io_commit_rbk_valids_3         (_rob_io_commit_rbk_valids_3),
    .io_commit_rollback             (_rob_io_commit_rollback),
    .io_com_load_is_at_rob_head     (io_lsu_commit_load_at_rob_head),
    .io_com_xcpt_valid              (_rob_io_com_xcpt_valid),
    .io_com_xcpt_bits_ftq_idx       (_rob_io_com_xcpt_bits_ftq_idx),
    .io_com_xcpt_bits_edge_inst     (_rob_io_com_xcpt_bits_edge_inst),
    .io_com_xcpt_bits_pc_lob        (_rob_io_com_xcpt_bits_pc_lob),
    .io_com_xcpt_bits_cause         (_rob_io_com_xcpt_bits_cause),
    .io_com_xcpt_bits_badvaddr      (_rob_io_com_xcpt_bits_badvaddr),
    .io_flush_valid                 (_rob_io_flush_valid),
    .io_flush_bits_ftq_idx          (_rob_io_flush_bits_ftq_idx),
    .io_flush_bits_edge_inst        (_rob_io_flush_bits_edge_inst),
    .io_flush_bits_is_rvc           (_rob_io_flush_bits_is_rvc),
    .io_flush_bits_pc_lob           (_rob_io_flush_bits_pc_lob),
    .io_flush_bits_flush_typ        (_rob_io_flush_bits_flush_typ),
    .io_empty                       (_rob_io_empty),
    .io_ready                       (_rob_io_ready),
    .io_flush_frontend              (_rob_io_flush_frontend)
  );
  CSRFile csr (
    .clock                      (clock),
    .reset                      (reset),
    .io_ungated_clock           (clock),
    .io_interrupts_debug        (io_interrupts_debug),
    .io_interrupts_mtip         (io_interrupts_mtip),
    .io_interrupts_msip         (io_interrupts_msip),
    .io_interrupts_meip         (io_interrupts_meip),
    .io_interrupts_seip         (io_interrupts_seip),
    .io_hartid                  (io_hartid),
    .io_rw_addr                 (_alu_exe_unit_1_io_iresp_bits_uop_csr_addr),
    .io_rw_cmd                  (_alu_exe_unit_1_io_iresp_bits_uop_ctrl_csr_cmd & {_alu_exe_unit_1_io_iresp_valid, 2'h3}),
    .io_rw_wdata                (_alu_exe_unit_1_io_iresp_bits_data[63:0]),
    .io_decode_0_inst           (_decode_units_0_io_csr_decode_inst),
    .io_decode_1_inst           (_decode_units_1_io_csr_decode_inst),
    .io_decode_2_inst           (_decode_units_2_io_csr_decode_inst),
    .io_decode_3_inst           (_decode_units_3_io_csr_decode_inst),
    .io_exception               (csr_io_exception_REG),
    .io_retire                  (csr_io_retire_REG),
    .io_cause                   (csr_io_cause_REG),
    .io_pc                      ({io_ifu_get_pc_0_com_pc[39:6], 6'h0} + {34'h0, csr_io_pc_REG} - {38'h0, csr_io_pc_REG_1, 1'h0}),
    .io_tval                    (csr_io_exception_REG & (csr_io_cause_REG == 64'h3 | csr_io_cause_REG == 64'h4 | csr_io_cause_REG == 64'h6 | csr_io_cause_REG == 64'h5 | csr_io_cause_REG == 64'h7 | csr_io_cause_REG == 64'h1 | csr_io_cause_REG == 64'hD | csr_io_cause_REG == 64'hF | csr_io_cause_REG == 64'hC) ? csr_io_tval_REG : 40'h0),
    .io_fcsr_flags_valid        (_rob_io_commit_fflags_valid),
    .io_fcsr_flags_bits         (_rob_io_commit_fflags_bits),
    .io_set_fs_dirty            (_rob_io_commit_fflags_valid),
    .io_rw_rdata                (_csr_io_rw_rdata),
    .io_decode_0_fp_illegal     (_csr_io_decode_0_fp_illegal),
    .io_decode_0_read_illegal   (_csr_io_decode_0_read_illegal),
    .io_decode_0_write_illegal  (_csr_io_decode_0_write_illegal),
    .io_decode_0_write_flush    (_csr_io_decode_0_write_flush),
    .io_decode_0_system_illegal (_csr_io_decode_0_system_illegal),
    .io_decode_1_fp_illegal     (_csr_io_decode_1_fp_illegal),
    .io_decode_1_read_illegal   (_csr_io_decode_1_read_illegal),
    .io_decode_1_write_illegal  (_csr_io_decode_1_write_illegal),
    .io_decode_1_write_flush    (_csr_io_decode_1_write_flush),
    .io_decode_1_system_illegal (_csr_io_decode_1_system_illegal),
    .io_decode_2_fp_illegal     (_csr_io_decode_2_fp_illegal),
    .io_decode_2_read_illegal   (_csr_io_decode_2_read_illegal),
    .io_decode_2_write_illegal  (_csr_io_decode_2_write_illegal),
    .io_decode_2_write_flush    (_csr_io_decode_2_write_flush),
    .io_decode_2_system_illegal (_csr_io_decode_2_system_illegal),
    .io_decode_3_fp_illegal     (_csr_io_decode_3_fp_illegal),
    .io_decode_3_read_illegal   (_csr_io_decode_3_read_illegal),
    .io_decode_3_write_illegal  (_csr_io_decode_3_write_illegal),
    .io_decode_3_write_flush    (_csr_io_decode_3_write_flush),
    .io_decode_3_system_illegal (_csr_io_decode_3_system_illegal),
    .io_csr_stall               (_csr_io_csr_stall),
    .io_singleStep              (_csr_io_singleStep),
    .io_status_debug            (_csr_io_status_debug),
    .io_status_dprv             (io_ptw_status_dprv),
    .io_status_prv              (io_ptw_status_prv),
    .io_status_mxr              (io_ptw_status_mxr),
    .io_status_sum              (io_ptw_status_sum),
    .io_ptbr_mode               (io_ptw_ptbr_mode),
    .io_ptbr_ppn                (io_ptw_ptbr_ppn),
    .io_evec                    (_csr_io_evec),
    .io_fcsr_rm                 (_csr_io_fcsr_rm),
    .io_interrupt               (_csr_io_interrupt),
    .io_interrupt_cause         (_csr_io_interrupt_cause),
    .io_pmp_0_cfg_l             (io_ptw_pmp_0_cfg_l),
    .io_pmp_0_cfg_a             (io_ptw_pmp_0_cfg_a),
    .io_pmp_0_cfg_x             (io_ptw_pmp_0_cfg_x),
    .io_pmp_0_cfg_w             (io_ptw_pmp_0_cfg_w),
    .io_pmp_0_cfg_r             (io_ptw_pmp_0_cfg_r),
    .io_pmp_0_addr              (io_ptw_pmp_0_addr),
    .io_pmp_0_mask              (io_ptw_pmp_0_mask),
    .io_pmp_1_cfg_l             (io_ptw_pmp_1_cfg_l),
    .io_pmp_1_cfg_a             (io_ptw_pmp_1_cfg_a),
    .io_pmp_1_cfg_x             (io_ptw_pmp_1_cfg_x),
    .io_pmp_1_cfg_w             (io_ptw_pmp_1_cfg_w),
    .io_pmp_1_cfg_r             (io_ptw_pmp_1_cfg_r),
    .io_pmp_1_addr              (io_ptw_pmp_1_addr),
    .io_pmp_1_mask              (io_ptw_pmp_1_mask),
    .io_pmp_2_cfg_l             (io_ptw_pmp_2_cfg_l),
    .io_pmp_2_cfg_a             (io_ptw_pmp_2_cfg_a),
    .io_pmp_2_cfg_x             (io_ptw_pmp_2_cfg_x),
    .io_pmp_2_cfg_w             (io_ptw_pmp_2_cfg_w),
    .io_pmp_2_cfg_r             (io_ptw_pmp_2_cfg_r),
    .io_pmp_2_addr              (io_ptw_pmp_2_addr),
    .io_pmp_2_mask              (io_ptw_pmp_2_mask),
    .io_pmp_3_cfg_l             (io_ptw_pmp_3_cfg_l),
    .io_pmp_3_cfg_a             (io_ptw_pmp_3_cfg_a),
    .io_pmp_3_cfg_x             (io_ptw_pmp_3_cfg_x),
    .io_pmp_3_cfg_w             (io_ptw_pmp_3_cfg_w),
    .io_pmp_3_cfg_r             (io_ptw_pmp_3_cfg_r),
    .io_pmp_3_addr              (io_ptw_pmp_3_addr),
    .io_pmp_3_mask              (io_ptw_pmp_3_mask),
    .io_pmp_4_cfg_l             (io_ptw_pmp_4_cfg_l),
    .io_pmp_4_cfg_a             (io_ptw_pmp_4_cfg_a),
    .io_pmp_4_cfg_x             (io_ptw_pmp_4_cfg_x),
    .io_pmp_4_cfg_w             (io_ptw_pmp_4_cfg_w),
    .io_pmp_4_cfg_r             (io_ptw_pmp_4_cfg_r),
    .io_pmp_4_addr              (io_ptw_pmp_4_addr),
    .io_pmp_4_mask              (io_ptw_pmp_4_mask),
    .io_pmp_5_cfg_l             (io_ptw_pmp_5_cfg_l),
    .io_pmp_5_cfg_a             (io_ptw_pmp_5_cfg_a),
    .io_pmp_5_cfg_x             (io_ptw_pmp_5_cfg_x),
    .io_pmp_5_cfg_w             (io_ptw_pmp_5_cfg_w),
    .io_pmp_5_cfg_r             (io_ptw_pmp_5_cfg_r),
    .io_pmp_5_addr              (io_ptw_pmp_5_addr),
    .io_pmp_5_mask              (io_ptw_pmp_5_mask),
    .io_pmp_6_cfg_l             (io_ptw_pmp_6_cfg_l),
    .io_pmp_6_cfg_a             (io_ptw_pmp_6_cfg_a),
    .io_pmp_6_cfg_x             (io_ptw_pmp_6_cfg_x),
    .io_pmp_6_cfg_w             (io_ptw_pmp_6_cfg_w),
    .io_pmp_6_cfg_r             (io_ptw_pmp_6_cfg_r),
    .io_pmp_6_addr              (io_ptw_pmp_6_addr),
    .io_pmp_6_mask              (io_ptw_pmp_6_mask),
    .io_pmp_7_cfg_l             (io_ptw_pmp_7_cfg_l),
    .io_pmp_7_cfg_a             (io_ptw_pmp_7_cfg_a),
    .io_pmp_7_cfg_x             (io_ptw_pmp_7_cfg_x),
    .io_pmp_7_cfg_w             (io_ptw_pmp_7_cfg_w),
    .io_pmp_7_cfg_r             (io_ptw_pmp_7_cfg_r),
    .io_pmp_7_addr              (io_ptw_pmp_7_addr),
    .io_pmp_7_mask              (io_ptw_pmp_7_mask),
    .io_customCSRs_0_value      (_csr_io_customCSRs_0_value)
  );
  Arbiter_19 ftq_arb (
    .io_in_0_valid (_rob_io_flush_valid),
    .io_in_0_bits  (_rob_io_flush_bits_ftq_idx),
    .io_in_1_valid (jmp_pc_req_valid),
    .io_in_1_bits  (jmp_pc_req_bits),
    .io_in_2_bits  (casez_tmp_0),
    .io_in_2_ready (_ftq_arb_io_in_2_ready),
    .io_out_bits   (io_ifu_get_pc_0_ftq_idx)
  );
  assign io_ifu_fetchpacket_ready = dec_ready;
  assign io_ifu_get_pc_1_ftq_idx = use_this_mispredict_3 ? brinfos_3_uop_ftq_idx : use_this_mispredict_2 ? brinfos_2_uop_ftq_idx : use_this_mispredict_1 ? brinfos_1_uop_ftq_idx : brinfos_0_uop_ftq_idx;
  assign io_ifu_sfence_valid = _io_ifu_sfence_valid_output;
  assign io_ifu_sfence_bits_rs1 = _io_ifu_sfence_bits_rs1_output;
  assign io_ifu_sfence_bits_rs2 = _io_ifu_sfence_bits_rs2_output;
  assign io_ifu_sfence_bits_addr = _io_ifu_sfence_bits_addr_output;
  assign io_ifu_brupdate_b2_uop_ftq_idx = b2_uop_ftq_idx;
  assign io_ifu_brupdate_b2_uop_pc_lob = b2_uop_pc_lob;
  assign io_ifu_brupdate_b2_mispredict = b2_mispredict;
  assign io_ifu_brupdate_b2_taken = b2_taken;
  assign io_ifu_redirect_flush = _io_ifu_redirect_flush_output;
  assign io_ifu_redirect_val = REG | _GEN_5_0;
  assign io_ifu_redirect_pc = REG ? (flush_typ[0] ? (flush_typ == 3'h3 ? io_ifu_redirect_pc_REG_1 : _csr_io_evec) : flush_typ == 3'h2 ? _flush_pc_T_6 : _flush_pc_T_6 + {37'h0, flush_pc_next_REG ? 3'h2 : 3'h4}) : b2_pc_sel == 2'h0 ? _npc_T_2 : b2_cfi_type == 3'h3 ? b2_jalr_target : _GEN_7 + {{19{b2_target_offset[20]}}, b2_target_offset} + {{39{b2_uop_edge_inst}}, 1'h0};
  assign io_ifu_redirect_ftq_idx = REG ? io_ifu_redirect_ftq_idx_REG : b2_uop_ftq_idx;
  assign io_ifu_redirect_ghist_old_history = REG ? 64'h0 : use_same_ghist ? io_ifu_get_pc_1_ghist_old_history : next_ghist_ignore_second_bank ? (io_ifu_get_pc_1_ghist_new_saw_branch_taken ? _GEN_15 : io_ifu_get_pc_1_ghist_new_saw_branch_not_taken ? _GEN_14 : io_ifu_get_pc_1_ghist_old_history) : _next_ghist_new_history_old_history_T_5 ? {io_ifu_get_pc_1_ghist_new_saw_branch_taken ? _GEN_17 : io_ifu_get_pc_1_ghist_new_saw_branch_not_taken ? _GEN_16 : io_ifu_get_pc_1_ghist_old_history[62:0], 1'h1} : next_ghist_first_bank_saw_not_taken ? {io_ifu_get_pc_1_ghist_new_saw_branch_taken ? _GEN_17 : io_ifu_get_pc_1_ghist_new_saw_branch_not_taken ? _GEN_16 : io_ifu_get_pc_1_ghist_old_history[62:0], 1'h0} : io_ifu_get_pc_1_ghist_new_saw_branch_taken ? _GEN_15 : io_ifu_get_pc_1_ghist_new_saw_branch_not_taken ? _GEN_14 : io_ifu_get_pc_1_ghist_old_history;
  assign io_ifu_redirect_ghist_current_saw_branch_not_taken = REG | use_same_ghist;
  assign io_ifu_redirect_ghist_new_saw_branch_not_taken = ~REG & (use_same_ghist ? io_ifu_get_pc_1_ghist_new_saw_branch_not_taken : next_ghist_ignore_second_bank ? next_ghist_first_bank_saw_not_taken : (|(io_ifu_get_pc_1_entry_br_mask[7:4] & {&cfi_idx, _GEN_8[6], _GEN_9[5], _GEN_10[4]} & _next_ghist_not_taken_branches_T_17[7:4])));
  assign io_ifu_redirect_ghist_new_saw_branch_taken = ~REG & (use_same_ghist ? io_ifu_get_pc_1_ghist_new_saw_branch_taken : next_ghist_ignore_second_bank ? _next_ghist_new_history_old_history_T_5 : b2_taken & _next_ghist_T & ~next_ghist_cfi_in_bank_0);
  assign io_ifu_redirect_ghist_ras_idx = REG ? io_ifu_get_pc_0_entry_ras_idx : use_same_ghist ? io_ifu_get_pc_1_ghist_ras_idx : io_ifu_get_pc_1_entry_cfi_is_call & _next_ghist_T_3 ? io_ifu_get_pc_1_ghist_ras_idx + 5'h1 : io_ifu_get_pc_1_entry_cfi_is_ret & _next_ghist_T_3 ? io_ifu_get_pc_1_ghist_ras_idx - 5'h1 : io_ifu_get_pc_1_ghist_ras_idx;
  assign io_ifu_commit_valid = REG_4 | _io_ifu_commit_valid_T | _rob_io_commit_valids_2 | _rob_io_commit_valids_3 | _rob_io_com_xcpt_valid;
  assign io_ifu_commit_bits = {34'h0, REG_4 ? io_ifu_commit_bits_REG : _rob_io_com_xcpt_valid ? _rob_io_com_xcpt_bits_ftq_idx : casez_tmp};
  assign io_ifu_flush_icache = _rob_io_commit_arch_valids_0 & _rob_io_commit_uops_0_is_fencei | io_ifu_flush_icache_REG | _rob_io_commit_arch_valids_1 & _rob_io_commit_uops_1_is_fencei | io_ifu_flush_icache_REG_1 | _rob_io_commit_arch_valids_2 & _rob_io_commit_uops_2_is_fencei | io_ifu_flush_icache_REG_2 | _rob_io_commit_arch_valids_3 & _rob_io_commit_uops_3_is_fencei | io_ifu_flush_icache_REG_3;
  assign io_ptw_sfence_valid = _io_ifu_sfence_valid_output;
  assign io_ptw_sfence_bits_rs1 = _io_ifu_sfence_bits_rs1_output;
  assign io_ptw_sfence_bits_rs2 = _io_ifu_sfence_bits_rs2_output;
  assign io_ptw_sfence_bits_addr = _io_ifu_sfence_bits_addr_output;
  assign io_ptw_status_debug = _csr_io_status_debug;
  assign io_lsu_exe_0_req_bits_sfence_valid = _memExeUnit_io_lsu_io_req_bits_sfence_valid;
  assign io_lsu_exe_0_req_bits_sfence_bits_rs1 = _memExeUnit_io_lsu_io_req_bits_sfence_bits_rs1;
  assign io_lsu_exe_0_req_bits_sfence_bits_rs2 = _memExeUnit_io_lsu_io_req_bits_sfence_bits_rs2;
  assign io_lsu_exe_0_req_bits_sfence_bits_addr = _memExeUnit_io_lsu_io_req_bits_sfence_bits_addr;
  assign io_lsu_exe_1_req_bits_sfence_valid = _memExeUnit_1_io_lsu_io_req_bits_sfence_valid;
  assign io_lsu_exe_1_req_bits_sfence_bits_rs1 = _memExeUnit_1_io_lsu_io_req_bits_sfence_bits_rs1;
  assign io_lsu_exe_1_req_bits_sfence_bits_rs2 = _memExeUnit_1_io_lsu_io_req_bits_sfence_bits_rs2;
  assign io_lsu_exe_1_req_bits_sfence_bits_addr = _memExeUnit_1_io_lsu_io_req_bits_sfence_bits_addr;
  assign io_lsu_dis_uops_0_valid = dis_fire_0;
  assign io_lsu_dis_uops_0_bits_uopc = _rename_stage_io_ren2_uops_0_uopc;
  assign io_lsu_dis_uops_0_bits_br_mask = _rename_stage_io_ren2_uops_0_br_mask;
  assign io_lsu_dis_uops_0_bits_rob_idx = dis_uops_0_rob_idx;
  assign io_lsu_dis_uops_0_bits_ldq_idx = io_lsu_dis_ldq_idx_0;
  assign io_lsu_dis_uops_0_bits_stq_idx = io_lsu_dis_stq_idx_0;
  assign io_lsu_dis_uops_0_bits_pdst = dis_uops_0_pdst;
  assign io_lsu_dis_uops_0_bits_exception = _rename_stage_io_ren2_uops_0_exception;
  assign io_lsu_dis_uops_0_bits_mem_cmd = _rename_stage_io_ren2_uops_0_mem_cmd;
  assign io_lsu_dis_uops_0_bits_mem_size = _rename_stage_io_ren2_uops_0_mem_size;
  assign io_lsu_dis_uops_0_bits_mem_signed = _rename_stage_io_ren2_uops_0_mem_signed;
  assign io_lsu_dis_uops_0_bits_is_fence = _rename_stage_io_ren2_uops_0_is_fence;
  assign io_lsu_dis_uops_0_bits_is_amo = _rename_stage_io_ren2_uops_0_is_amo;
  assign io_lsu_dis_uops_0_bits_uses_ldq = _rename_stage_io_ren2_uops_0_uses_ldq;
  assign io_lsu_dis_uops_0_bits_uses_stq = _rename_stage_io_ren2_uops_0_uses_stq;
  assign io_lsu_dis_uops_0_bits_dst_rtype = _rename_stage_io_ren2_uops_0_dst_rtype;
  assign io_lsu_dis_uops_0_bits_fp_val = _rename_stage_io_ren2_uops_0_fp_val;
  assign io_lsu_dis_uops_1_valid = dis_fire_1;
  assign io_lsu_dis_uops_1_bits_uopc = _rename_stage_io_ren2_uops_1_uopc;
  assign io_lsu_dis_uops_1_bits_br_mask = _rename_stage_io_ren2_uops_1_br_mask;
  assign io_lsu_dis_uops_1_bits_rob_idx = dis_uops_1_rob_idx;
  assign io_lsu_dis_uops_1_bits_ldq_idx = io_lsu_dis_ldq_idx_1;
  assign io_lsu_dis_uops_1_bits_stq_idx = io_lsu_dis_stq_idx_1;
  assign io_lsu_dis_uops_1_bits_pdst = dis_uops_1_pdst;
  assign io_lsu_dis_uops_1_bits_exception = _rename_stage_io_ren2_uops_1_exception;
  assign io_lsu_dis_uops_1_bits_mem_cmd = _rename_stage_io_ren2_uops_1_mem_cmd;
  assign io_lsu_dis_uops_1_bits_mem_size = _rename_stage_io_ren2_uops_1_mem_size;
  assign io_lsu_dis_uops_1_bits_mem_signed = _rename_stage_io_ren2_uops_1_mem_signed;
  assign io_lsu_dis_uops_1_bits_is_fence = _rename_stage_io_ren2_uops_1_is_fence;
  assign io_lsu_dis_uops_1_bits_is_amo = _rename_stage_io_ren2_uops_1_is_amo;
  assign io_lsu_dis_uops_1_bits_uses_ldq = _rename_stage_io_ren2_uops_1_uses_ldq;
  assign io_lsu_dis_uops_1_bits_uses_stq = _rename_stage_io_ren2_uops_1_uses_stq;
  assign io_lsu_dis_uops_1_bits_dst_rtype = _rename_stage_io_ren2_uops_1_dst_rtype;
  assign io_lsu_dis_uops_1_bits_fp_val = _rename_stage_io_ren2_uops_1_fp_val;
  assign io_lsu_dis_uops_2_valid = dis_fire_2;
  assign io_lsu_dis_uops_2_bits_uopc = _rename_stage_io_ren2_uops_2_uopc;
  assign io_lsu_dis_uops_2_bits_br_mask = _rename_stage_io_ren2_uops_2_br_mask;
  assign io_lsu_dis_uops_2_bits_rob_idx = dis_uops_2_rob_idx;
  assign io_lsu_dis_uops_2_bits_ldq_idx = io_lsu_dis_ldq_idx_2;
  assign io_lsu_dis_uops_2_bits_stq_idx = io_lsu_dis_stq_idx_2;
  assign io_lsu_dis_uops_2_bits_pdst = dis_uops_2_pdst;
  assign io_lsu_dis_uops_2_bits_exception = _rename_stage_io_ren2_uops_2_exception;
  assign io_lsu_dis_uops_2_bits_mem_cmd = _rename_stage_io_ren2_uops_2_mem_cmd;
  assign io_lsu_dis_uops_2_bits_mem_size = _rename_stage_io_ren2_uops_2_mem_size;
  assign io_lsu_dis_uops_2_bits_mem_signed = _rename_stage_io_ren2_uops_2_mem_signed;
  assign io_lsu_dis_uops_2_bits_is_fence = _rename_stage_io_ren2_uops_2_is_fence;
  assign io_lsu_dis_uops_2_bits_is_amo = _rename_stage_io_ren2_uops_2_is_amo;
  assign io_lsu_dis_uops_2_bits_uses_ldq = _rename_stage_io_ren2_uops_2_uses_ldq;
  assign io_lsu_dis_uops_2_bits_uses_stq = _rename_stage_io_ren2_uops_2_uses_stq;
  assign io_lsu_dis_uops_2_bits_dst_rtype = _rename_stage_io_ren2_uops_2_dst_rtype;
  assign io_lsu_dis_uops_2_bits_fp_val = _rename_stage_io_ren2_uops_2_fp_val;
  assign io_lsu_dis_uops_3_valid = dis_fire_3;
  assign io_lsu_dis_uops_3_bits_uopc = _rename_stage_io_ren2_uops_3_uopc;
  assign io_lsu_dis_uops_3_bits_br_mask = _rename_stage_io_ren2_uops_3_br_mask;
  assign io_lsu_dis_uops_3_bits_rob_idx = dis_uops_3_rob_idx;
  assign io_lsu_dis_uops_3_bits_ldq_idx = io_lsu_dis_ldq_idx_3;
  assign io_lsu_dis_uops_3_bits_stq_idx = io_lsu_dis_stq_idx_3;
  assign io_lsu_dis_uops_3_bits_pdst = dis_uops_3_pdst;
  assign io_lsu_dis_uops_3_bits_exception = _rename_stage_io_ren2_uops_3_exception;
  assign io_lsu_dis_uops_3_bits_mem_cmd = _rename_stage_io_ren2_uops_3_mem_cmd;
  assign io_lsu_dis_uops_3_bits_mem_size = _rename_stage_io_ren2_uops_3_mem_size;
  assign io_lsu_dis_uops_3_bits_mem_signed = _rename_stage_io_ren2_uops_3_mem_signed;
  assign io_lsu_dis_uops_3_bits_is_fence = _rename_stage_io_ren2_uops_3_is_fence;
  assign io_lsu_dis_uops_3_bits_is_amo = _rename_stage_io_ren2_uops_3_is_amo;
  assign io_lsu_dis_uops_3_bits_uses_ldq = _rename_stage_io_ren2_uops_3_uses_ldq;
  assign io_lsu_dis_uops_3_bits_uses_stq = _rename_stage_io_ren2_uops_3_uses_stq;
  assign io_lsu_dis_uops_3_bits_dst_rtype = _rename_stage_io_ren2_uops_3_dst_rtype;
  assign io_lsu_dis_uops_3_bits_fp_val = _rename_stage_io_ren2_uops_3_fp_val;
  assign io_lsu_commit_valids_0 = _rob_io_commit_valids_0;
  assign io_lsu_commit_valids_1 = _rob_io_commit_valids_1;
  assign io_lsu_commit_valids_2 = _rob_io_commit_valids_2;
  assign io_lsu_commit_valids_3 = _rob_io_commit_valids_3;
  assign io_lsu_fence_dmem = _rename_stage_io_ren2_mask_0 & wait_for_empty_pipeline_0 | _rename_stage_io_ren2_mask_1 & wait_for_empty_pipeline_1 | _rename_stage_io_ren2_mask_2 & wait_for_empty_pipeline_2 | _rename_stage_io_ren2_mask_3 & wait_for_empty_pipeline_3;
  assign io_lsu_brupdate_b1_resolve_mask = _b1_resolve_mask_T_6;
  assign io_lsu_brupdate_b1_mispredict_mask = _b1_mispredict_mask_T_10;
  assign io_lsu_brupdate_b2_uop_ldq_idx = b2_uop_ldq_idx;
  assign io_lsu_brupdate_b2_uop_stq_idx = b2_uop_stq_idx;
  assign io_lsu_brupdate_b2_mispredict = b2_mispredict;
  assign io_lsu_rob_head_idx = _rob_io_rob_head_idx;
  assign io_lsu_exception = io_lsu_exception_REG;
endmodule

