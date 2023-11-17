// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BoomFrontend(
  input          clock,
                 reset,
                 auto_icache_master_out_a_ready,
                 auto_icache_master_out_d_valid,
  input  [2:0]   auto_icache_master_out_d_bits_opcode,
  input  [3:0]   auto_icache_master_out_d_bits_size,
  input  [127:0] auto_icache_master_out_d_bits_data,
  input          io_cpu_fetchpacket_ready,
  input  [5:0]   io_cpu_get_pc_0_ftq_idx,
                 io_cpu_get_pc_1_ftq_idx,
  input          io_cpu_sfence_valid,
                 io_cpu_sfence_bits_rs1,
                 io_cpu_sfence_bits_rs2,
  input  [38:0]  io_cpu_sfence_bits_addr,
  input  [5:0]   io_cpu_brupdate_b2_uop_ftq_idx,
                 io_cpu_brupdate_b2_uop_pc_lob,
  input          io_cpu_brupdate_b2_mispredict,
                 io_cpu_brupdate_b2_taken,
                 io_cpu_redirect_flush,
                 io_cpu_redirect_val,
  input  [39:0]  io_cpu_redirect_pc,
  input  [5:0]   io_cpu_redirect_ftq_idx,
  input  [63:0]  io_cpu_redirect_ghist_old_history,
  input          io_cpu_redirect_ghist_current_saw_branch_not_taken,
                 io_cpu_redirect_ghist_new_saw_branch_not_taken,
                 io_cpu_redirect_ghist_new_saw_branch_taken,
  input  [4:0]   io_cpu_redirect_ghist_ras_idx,
  input          io_cpu_commit_valid,
  input  [39:0]  io_cpu_commit_bits,
  input          io_cpu_flush_icache,
                 io_ptw_req_ready,
                 io_ptw_resp_valid,
                 io_ptw_resp_bits_ae_ptw,
                 io_ptw_resp_bits_ae_final,
                 io_ptw_resp_bits_pf,
                 io_ptw_resp_bits_gf,
                 io_ptw_resp_bits_hr,
                 io_ptw_resp_bits_hw,
                 io_ptw_resp_bits_hx,
  input  [43:0]  io_ptw_resp_bits_pte_ppn,
  input          io_ptw_resp_bits_pte_d,
                 io_ptw_resp_bits_pte_a,
                 io_ptw_resp_bits_pte_g,
                 io_ptw_resp_bits_pte_u,
                 io_ptw_resp_bits_pte_x,
                 io_ptw_resp_bits_pte_w,
                 io_ptw_resp_bits_pte_r,
                 io_ptw_resp_bits_pte_v,
  input  [1:0]   io_ptw_resp_bits_level,
  input          io_ptw_resp_bits_homogeneous,
                 io_ptw_resp_bits_gpa_is_pte,
  input  [3:0]   io_ptw_ptbr_mode,
  input          io_ptw_status_debug,
  input  [1:0]   io_ptw_status_prv,
  input          io_ptw_pmp_0_cfg_l,
  input  [1:0]   io_ptw_pmp_0_cfg_a,
  input          io_ptw_pmp_0_cfg_x,
                 io_ptw_pmp_0_cfg_w,
                 io_ptw_pmp_0_cfg_r,
  input  [29:0]  io_ptw_pmp_0_addr,
  input  [31:0]  io_ptw_pmp_0_mask,
  input          io_ptw_pmp_1_cfg_l,
  input  [1:0]   io_ptw_pmp_1_cfg_a,
  input          io_ptw_pmp_1_cfg_x,
                 io_ptw_pmp_1_cfg_w,
                 io_ptw_pmp_1_cfg_r,
  input  [29:0]  io_ptw_pmp_1_addr,
  input  [31:0]  io_ptw_pmp_1_mask,
  input          io_ptw_pmp_2_cfg_l,
  input  [1:0]   io_ptw_pmp_2_cfg_a,
  input          io_ptw_pmp_2_cfg_x,
                 io_ptw_pmp_2_cfg_w,
                 io_ptw_pmp_2_cfg_r,
  input  [29:0]  io_ptw_pmp_2_addr,
  input  [31:0]  io_ptw_pmp_2_mask,
  input          io_ptw_pmp_3_cfg_l,
  input  [1:0]   io_ptw_pmp_3_cfg_a,
  input          io_ptw_pmp_3_cfg_x,
                 io_ptw_pmp_3_cfg_w,
                 io_ptw_pmp_3_cfg_r,
  input  [29:0]  io_ptw_pmp_3_addr,
  input  [31:0]  io_ptw_pmp_3_mask,
  input          io_ptw_pmp_4_cfg_l,
  input  [1:0]   io_ptw_pmp_4_cfg_a,
  input          io_ptw_pmp_4_cfg_x,
                 io_ptw_pmp_4_cfg_w,
                 io_ptw_pmp_4_cfg_r,
  input  [29:0]  io_ptw_pmp_4_addr,
  input  [31:0]  io_ptw_pmp_4_mask,
  input          io_ptw_pmp_5_cfg_l,
  input  [1:0]   io_ptw_pmp_5_cfg_a,
  input          io_ptw_pmp_5_cfg_x,
                 io_ptw_pmp_5_cfg_w,
                 io_ptw_pmp_5_cfg_r,
  input  [29:0]  io_ptw_pmp_5_addr,
  input  [31:0]  io_ptw_pmp_5_mask,
  input          io_ptw_pmp_6_cfg_l,
  input  [1:0]   io_ptw_pmp_6_cfg_a,
  input          io_ptw_pmp_6_cfg_x,
                 io_ptw_pmp_6_cfg_w,
                 io_ptw_pmp_6_cfg_r,
  input  [29:0]  io_ptw_pmp_6_addr,
  input  [31:0]  io_ptw_pmp_6_mask,
  input          io_ptw_pmp_7_cfg_l,
  input  [1:0]   io_ptw_pmp_7_cfg_a,
  input          io_ptw_pmp_7_cfg_x,
                 io_ptw_pmp_7_cfg_w,
                 io_ptw_pmp_7_cfg_r,
  input  [29:0]  io_ptw_pmp_7_addr,
  input  [31:0]  io_ptw_pmp_7_mask,
  output         auto_icache_master_out_a_valid,
  output [31:0]  auto_icache_master_out_a_bits_address,
  output         io_cpu_fetchpacket_valid,
                 io_cpu_fetchpacket_bits_uops_0_valid,
  output [31:0]  io_cpu_fetchpacket_bits_uops_0_bits_inst,
  output         io_cpu_fetchpacket_bits_uops_0_bits_is_rvc,
                 io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_load,
                 io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_sta,
                 io_cpu_fetchpacket_bits_uops_0_bits_is_sfb,
  output [5:0]   io_cpu_fetchpacket_bits_uops_0_bits_ftq_idx,
  output         io_cpu_fetchpacket_bits_uops_0_bits_edge_inst,
  output [5:0]   io_cpu_fetchpacket_bits_uops_0_bits_pc_lob,
  output         io_cpu_fetchpacket_bits_uops_0_bits_taken,
                 io_cpu_fetchpacket_bits_uops_0_bits_xcpt_pf_if,
                 io_cpu_fetchpacket_bits_uops_0_bits_xcpt_ae_if,
                 io_cpu_fetchpacket_bits_uops_0_bits_bp_debug_if,
                 io_cpu_fetchpacket_bits_uops_0_bits_bp_xcpt_if,
                 io_cpu_fetchpacket_bits_uops_1_valid,
  output [31:0]  io_cpu_fetchpacket_bits_uops_1_bits_inst,
  output         io_cpu_fetchpacket_bits_uops_1_bits_is_rvc,
                 io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_load,
                 io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_sta,
                 io_cpu_fetchpacket_bits_uops_1_bits_is_sfb,
  output [5:0]   io_cpu_fetchpacket_bits_uops_1_bits_ftq_idx,
  output         io_cpu_fetchpacket_bits_uops_1_bits_edge_inst,
  output [5:0]   io_cpu_fetchpacket_bits_uops_1_bits_pc_lob,
  output         io_cpu_fetchpacket_bits_uops_1_bits_taken,
                 io_cpu_fetchpacket_bits_uops_1_bits_xcpt_pf_if,
                 io_cpu_fetchpacket_bits_uops_1_bits_xcpt_ae_if,
                 io_cpu_fetchpacket_bits_uops_1_bits_bp_debug_if,
                 io_cpu_fetchpacket_bits_uops_1_bits_bp_xcpt_if,
                 io_cpu_fetchpacket_bits_uops_2_valid,
  output [31:0]  io_cpu_fetchpacket_bits_uops_2_bits_inst,
  output         io_cpu_fetchpacket_bits_uops_2_bits_is_rvc,
                 io_cpu_fetchpacket_bits_uops_2_bits_ctrl_is_load,
                 io_cpu_fetchpacket_bits_uops_2_bits_ctrl_is_sta,
                 io_cpu_fetchpacket_bits_uops_2_bits_is_sfb,
  output [5:0]   io_cpu_fetchpacket_bits_uops_2_bits_ftq_idx,
  output         io_cpu_fetchpacket_bits_uops_2_bits_edge_inst,
  output [5:0]   io_cpu_fetchpacket_bits_uops_2_bits_pc_lob,
  output         io_cpu_fetchpacket_bits_uops_2_bits_taken,
                 io_cpu_fetchpacket_bits_uops_2_bits_xcpt_pf_if,
                 io_cpu_fetchpacket_bits_uops_2_bits_xcpt_ae_if,
                 io_cpu_fetchpacket_bits_uops_2_bits_bp_debug_if,
                 io_cpu_fetchpacket_bits_uops_2_bits_bp_xcpt_if,
                 io_cpu_fetchpacket_bits_uops_3_valid,
  output [31:0]  io_cpu_fetchpacket_bits_uops_3_bits_inst,
  output         io_cpu_fetchpacket_bits_uops_3_bits_is_rvc,
                 io_cpu_fetchpacket_bits_uops_3_bits_ctrl_is_load,
                 io_cpu_fetchpacket_bits_uops_3_bits_ctrl_is_sta,
                 io_cpu_fetchpacket_bits_uops_3_bits_is_sfb,
  output [5:0]   io_cpu_fetchpacket_bits_uops_3_bits_ftq_idx,
  output         io_cpu_fetchpacket_bits_uops_3_bits_edge_inst,
  output [5:0]   io_cpu_fetchpacket_bits_uops_3_bits_pc_lob,
  output         io_cpu_fetchpacket_bits_uops_3_bits_taken,
                 io_cpu_fetchpacket_bits_uops_3_bits_xcpt_pf_if,
                 io_cpu_fetchpacket_bits_uops_3_bits_xcpt_ae_if,
                 io_cpu_fetchpacket_bits_uops_3_bits_bp_debug_if,
                 io_cpu_fetchpacket_bits_uops_3_bits_bp_xcpt_if,
                 io_cpu_get_pc_0_entry_cfi_idx_valid,
  output [2:0]   io_cpu_get_pc_0_entry_cfi_idx_bits,
  output [4:0]   io_cpu_get_pc_0_entry_ras_idx,
  output         io_cpu_get_pc_0_entry_start_bank,
  output [39:0]  io_cpu_get_pc_0_pc,
                 io_cpu_get_pc_0_com_pc,
  output         io_cpu_get_pc_0_next_val,
  output [39:0]  io_cpu_get_pc_0_next_pc,
  output [2:0]   io_cpu_get_pc_1_entry_cfi_idx_bits,
  output [7:0]   io_cpu_get_pc_1_entry_br_mask,
  output         io_cpu_get_pc_1_entry_cfi_is_call,
                 io_cpu_get_pc_1_entry_cfi_is_ret,
                 io_cpu_get_pc_1_entry_start_bank,
  output [63:0]  io_cpu_get_pc_1_ghist_old_history,
  output         io_cpu_get_pc_1_ghist_current_saw_branch_not_taken,
                 io_cpu_get_pc_1_ghist_new_saw_branch_not_taken,
                 io_cpu_get_pc_1_ghist_new_saw_branch_taken,
  output [4:0]   io_cpu_get_pc_1_ghist_ras_idx,
  output [39:0]  io_cpu_get_pc_1_pc,
  output         io_ptw_req_valid,
  output [26:0]  io_ptw_req_bits_bits_addr,
  output         io_ptw_req_bits_bits_need_gpa,
                 io_ptw_req_bits_bits_vstage1,
                 io_ptw_req_bits_bits_stage2
);

  wire         _f4_io_enq_valid_T_1;
  wire [4:0]   _GEN_238;
  wire         _bpd_update_arbiter_io_in_1_ready;
  wire         _bpd_update_arbiter_io_out_valid;
  wire         _bpd_update_arbiter_io_out_bits_is_mispredict_update;
  wire         _bpd_update_arbiter_io_out_bits_is_repair_update;
  wire [7:0]   _bpd_update_arbiter_io_out_bits_btb_mispredicts;
  wire [39:0]  _bpd_update_arbiter_io_out_bits_pc;
  wire [7:0]   _bpd_update_arbiter_io_out_bits_br_mask;
  wire         _bpd_update_arbiter_io_out_bits_cfi_idx_valid;
  wire [2:0]   _bpd_update_arbiter_io_out_bits_cfi_idx_bits;
  wire         _bpd_update_arbiter_io_out_bits_cfi_taken;
  wire         _bpd_update_arbiter_io_out_bits_cfi_mispredicted;
  wire         _bpd_update_arbiter_io_out_bits_cfi_is_br;
  wire         _bpd_update_arbiter_io_out_bits_cfi_is_jal;
  wire [63:0]  _bpd_update_arbiter_io_out_bits_ghist_old_history;
  wire         _bpd_update_arbiter_io_out_bits_ghist_new_saw_branch_not_taken;
  wire         _bpd_update_arbiter_io_out_bits_ghist_new_saw_branch_taken;
  wire [39:0]  _bpd_update_arbiter_io_out_bits_target;
  wire [119:0] _bpd_update_arbiter_io_out_bits_meta_0;
  wire [119:0] _bpd_update_arbiter_io_out_bits_meta_1;
  wire         _ftq_io_enq_ready;
  wire [5:0]   _ftq_io_enq_idx;
  wire         _ftq_io_bpdupdate_valid;
  wire         _ftq_io_bpdupdate_bits_is_mispredict_update;
  wire         _ftq_io_bpdupdate_bits_is_repair_update;
  wire [39:0]  _ftq_io_bpdupdate_bits_pc;
  wire [7:0]   _ftq_io_bpdupdate_bits_br_mask;
  wire         _ftq_io_bpdupdate_bits_cfi_idx_valid;
  wire [2:0]   _ftq_io_bpdupdate_bits_cfi_idx_bits;
  wire         _ftq_io_bpdupdate_bits_cfi_taken;
  wire         _ftq_io_bpdupdate_bits_cfi_mispredicted;
  wire         _ftq_io_bpdupdate_bits_cfi_is_br;
  wire         _ftq_io_bpdupdate_bits_cfi_is_jal;
  wire [63:0]  _ftq_io_bpdupdate_bits_ghist_old_history;
  wire         _ftq_io_bpdupdate_bits_ghist_new_saw_branch_not_taken;
  wire         _ftq_io_bpdupdate_bits_ghist_new_saw_branch_taken;
  wire [39:0]  _ftq_io_bpdupdate_bits_target;
  wire [119:0] _ftq_io_bpdupdate_bits_meta_0;
  wire [119:0] _ftq_io_bpdupdate_bits_meta_1;
  wire         _ftq_io_ras_update;
  wire [4:0]   _ftq_io_ras_update_idx;
  wire [39:0]  _ftq_io_ras_update_pc;
  wire         _fb_io_enq_ready;
  wire         _f4_io_enq_ready;
  wire         _f4_io_deq_valid;
  wire [39:0]  _f4_io_deq_bits_pc;
  wire         _f4_io_deq_bits_edge_inst_0;
  wire         _f4_io_deq_bits_edge_inst_1;
  wire [31:0]  _f4_io_deq_bits_insts_0;
  wire [31:0]  _f4_io_deq_bits_insts_1;
  wire [31:0]  _f4_io_deq_bits_insts_2;
  wire [31:0]  _f4_io_deq_bits_insts_3;
  wire [31:0]  _f4_io_deq_bits_insts_4;
  wire [31:0]  _f4_io_deq_bits_insts_5;
  wire [31:0]  _f4_io_deq_bits_insts_6;
  wire [31:0]  _f4_io_deq_bits_insts_7;
  wire [31:0]  _f4_io_deq_bits_exp_insts_0;
  wire [31:0]  _f4_io_deq_bits_exp_insts_1;
  wire [31:0]  _f4_io_deq_bits_exp_insts_2;
  wire [31:0]  _f4_io_deq_bits_exp_insts_3;
  wire [31:0]  _f4_io_deq_bits_exp_insts_4;
  wire [31:0]  _f4_io_deq_bits_exp_insts_5;
  wire [31:0]  _f4_io_deq_bits_exp_insts_6;
  wire [31:0]  _f4_io_deq_bits_exp_insts_7;
  wire         _f4_io_deq_bits_sfbs_0;
  wire         _f4_io_deq_bits_sfbs_1;
  wire         _f4_io_deq_bits_sfbs_2;
  wire         _f4_io_deq_bits_sfbs_3;
  wire         _f4_io_deq_bits_sfbs_4;
  wire         _f4_io_deq_bits_sfbs_5;
  wire         _f4_io_deq_bits_sfbs_6;
  wire         _f4_io_deq_bits_sfbs_7;
  wire         _f4_io_deq_bits_shadowed_mask_0;
  wire         _f4_io_deq_bits_shadowed_mask_1;
  wire         _f4_io_deq_bits_shadowed_mask_2;
  wire         _f4_io_deq_bits_shadowed_mask_3;
  wire         _f4_io_deq_bits_shadowed_mask_4;
  wire         _f4_io_deq_bits_shadowed_mask_5;
  wire         _f4_io_deq_bits_shadowed_mask_6;
  wire         _f4_io_deq_bits_shadowed_mask_7;
  wire         _f4_io_deq_bits_cfi_idx_valid;
  wire [2:0]   _f4_io_deq_bits_cfi_idx_bits;
  wire [2:0]   _f4_io_deq_bits_cfi_type;
  wire         _f4_io_deq_bits_cfi_is_call;
  wire         _f4_io_deq_bits_cfi_is_ret;
  wire [39:0]  _f4_io_deq_bits_ras_top;
  wire [7:0]   _f4_io_deq_bits_mask;
  wire [7:0]   _f4_io_deq_bits_br_mask;
  wire [63:0]  _f4_io_deq_bits_ghist_old_history;
  wire         _f4_io_deq_bits_ghist_current_saw_branch_not_taken;
  wire         _f4_io_deq_bits_ghist_new_saw_branch_not_taken;
  wire         _f4_io_deq_bits_ghist_new_saw_branch_taken;
  wire [4:0]   _f4_io_deq_bits_ghist_ras_idx;
  wire         _f4_io_deq_bits_xcpt_pf_if;
  wire         _f4_io_deq_bits_xcpt_ae_if;
  wire         _f4_io_deq_bits_bp_debug_if_oh_0;
  wire         _f4_io_deq_bits_bp_debug_if_oh_1;
  wire         _f4_io_deq_bits_bp_debug_if_oh_2;
  wire         _f4_io_deq_bits_bp_debug_if_oh_3;
  wire         _f4_io_deq_bits_bp_debug_if_oh_4;
  wire         _f4_io_deq_bits_bp_debug_if_oh_5;
  wire         _f4_io_deq_bits_bp_debug_if_oh_6;
  wire         _f4_io_deq_bits_bp_debug_if_oh_7;
  wire         _f4_io_deq_bits_bp_xcpt_if_oh_0;
  wire         _f4_io_deq_bits_bp_xcpt_if_oh_1;
  wire         _f4_io_deq_bits_bp_xcpt_if_oh_2;
  wire         _f4_io_deq_bits_bp_xcpt_if_oh_3;
  wire         _f4_io_deq_bits_bp_xcpt_if_oh_4;
  wire         _f4_io_deq_bits_bp_xcpt_if_oh_5;
  wire         _f4_io_deq_bits_bp_xcpt_if_oh_6;
  wire         _f4_io_deq_bits_bp_xcpt_if_oh_7;
  wire [119:0] _f4_io_deq_bits_bpd_meta_0;
  wire [119:0] _f4_io_deq_bits_bpd_meta_1;
  wire         _f4_btb_corrections_io_deq_valid;
  wire         _f4_btb_corrections_io_deq_bits_is_mispredict_update;
  wire         _f4_btb_corrections_io_deq_bits_is_repair_update;
  wire [7:0]   _f4_btb_corrections_io_deq_bits_btb_mispredicts;
  wire [39:0]  _f4_btb_corrections_io_deq_bits_pc;
  wire [7:0]   _f4_btb_corrections_io_deq_bits_br_mask;
  wire         _f4_btb_corrections_io_deq_bits_cfi_idx_valid;
  wire [2:0]   _f4_btb_corrections_io_deq_bits_cfi_idx_bits;
  wire         _f4_btb_corrections_io_deq_bits_cfi_taken;
  wire         _f4_btb_corrections_io_deq_bits_cfi_mispredicted;
  wire         _f4_btb_corrections_io_deq_bits_cfi_is_br;
  wire         _f4_btb_corrections_io_deq_bits_cfi_is_jal;
  wire [63:0]  _f4_btb_corrections_io_deq_bits_ghist_old_history;
  wire         _f4_btb_corrections_io_deq_bits_ghist_new_saw_branch_not_taken;
  wire         _f4_btb_corrections_io_deq_bits_ghist_new_saw_branch_taken;
  wire [39:0]  _f4_btb_corrections_io_deq_bits_target;
  wire [119:0] _f4_btb_corrections_io_deq_bits_meta_0;
  wire [119:0] _f4_btb_corrections_io_deq_bits_meta_1;
  wire         _bpd_decoder_5_io_out_is_ret;
  wire         _bpd_decoder_5_io_out_is_call;
  wire [39:0]  _bpd_decoder_5_io_out_target;
  wire [2:0]   _bpd_decoder_5_io_out_cfi_type;
  wire         _bpd_decoder_5_io_out_sfb_offset_valid;
  wire [5:0]   _bpd_decoder_5_io_out_sfb_offset_bits;
  wire [31:0]  _exp_inst_rvc_exp_5_io_out_bits;
  wire         _exp_inst_rvc_exp_5_io_rvc;
  wire         _bpd_decoder_4_io_out_is_ret;
  wire         _bpd_decoder_4_io_out_is_call;
  wire [39:0]  _bpd_decoder_4_io_out_target;
  wire [2:0]   _bpd_decoder_4_io_out_cfi_type;
  wire         _bpd_decoder_4_io_out_sfb_offset_valid;
  wire [5:0]   _bpd_decoder_4_io_out_sfb_offset_bits;
  wire [31:0]  _exp_inst_rvc_exp_4_io_out_bits;
  wire         _exp_inst_rvc_exp_4_io_rvc;
  wire         _bpd_decoder_3_io_out_is_ret;
  wire         _bpd_decoder_3_io_out_is_call;
  wire [39:0]  _bpd_decoder_3_io_out_target;
  wire [2:0]   _bpd_decoder_3_io_out_cfi_type;
  wire         _bpd_decoder_3_io_out_sfb_offset_valid;
  wire [5:0]   _bpd_decoder_3_io_out_sfb_offset_bits;
  wire [31:0]  _exp_inst_rvc_exp_3_io_out_bits;
  wire         _exp_inst_rvc_exp_3_io_rvc;
  wire         _bpd_decoder0b_io_out_is_ret;
  wire         _bpd_decoder0b_io_out_is_call;
  wire [39:0]  _bpd_decoder0b_io_out_target;
  wire [2:0]   _bpd_decoder0b_io_out_cfi_type;
  wire         _bpd_decoder0b_io_out_sfb_offset_valid;
  wire [5:0]   _bpd_decoder0b_io_out_sfb_offset_bits;
  wire [31:0]  _exp_inst0b_rvc_exp_io_out_bits;
  wire         _exp_inst0b_rvc_exp_io_rvc;
  wire         _bpd_decoder1_1_io_out_is_ret;
  wire         _bpd_decoder1_1_io_out_is_call;
  wire [39:0]  _bpd_decoder1_1_io_out_target;
  wire [2:0]   _bpd_decoder1_1_io_out_cfi_type;
  wire         _bpd_decoder1_1_io_out_sfb_offset_valid;
  wire [5:0]   _bpd_decoder1_1_io_out_sfb_offset_bits;
  wire [31:0]  _exp_inst1_rvc_exp_1_io_out_bits;
  wire         _exp_inst1_rvc_exp_1_io_rvc;
  wire         _bpd_decoder_2_io_out_is_ret;
  wire         _bpd_decoder_2_io_out_is_call;
  wire [39:0]  _bpd_decoder_2_io_out_target;
  wire [2:0]   _bpd_decoder_2_io_out_cfi_type;
  wire         _bpd_decoder_2_io_out_sfb_offset_valid;
  wire [5:0]   _bpd_decoder_2_io_out_sfb_offset_bits;
  wire [31:0]  _exp_inst_rvc_exp_2_io_out_bits;
  wire         _exp_inst_rvc_exp_2_io_rvc;
  wire         _bpd_decoder_1_io_out_is_ret;
  wire         _bpd_decoder_1_io_out_is_call;
  wire [39:0]  _bpd_decoder_1_io_out_target;
  wire [2:0]   _bpd_decoder_1_io_out_cfi_type;
  wire         _bpd_decoder_1_io_out_sfb_offset_valid;
  wire [5:0]   _bpd_decoder_1_io_out_sfb_offset_bits;
  wire [31:0]  _exp_inst_rvc_exp_1_io_out_bits;
  wire         _exp_inst_rvc_exp_1_io_rvc;
  wire         _bpd_decoder_io_out_is_ret;
  wire         _bpd_decoder_io_out_is_call;
  wire [39:0]  _bpd_decoder_io_out_target;
  wire [2:0]   _bpd_decoder_io_out_cfi_type;
  wire         _bpd_decoder_io_out_sfb_offset_valid;
  wire [5:0]   _bpd_decoder_io_out_sfb_offset_bits;
  wire [31:0]  _exp_inst_rvc_exp_io_out_bits;
  wire         _exp_inst_rvc_exp_io_rvc;
  wire         _bpd_decoder1_io_out_is_ret;
  wire         _bpd_decoder1_io_out_is_call;
  wire [39:0]  _bpd_decoder1_io_out_target;
  wire [2:0]   _bpd_decoder1_io_out_cfi_type;
  wire         _bpd_decoder1_io_out_sfb_offset_valid;
  wire [5:0]   _bpd_decoder1_io_out_sfb_offset_bits;
  wire         _bpd_decoder0_io_out_is_ret;
  wire         _bpd_decoder0_io_out_is_call;
  wire [39:0]  _bpd_decoder0_io_out_target;
  wire [2:0]   _bpd_decoder0_io_out_cfi_type;
  wire         _bpd_decoder0_io_out_sfb_offset_valid;
  wire [5:0]   _bpd_decoder0_io_out_sfb_offset_bits;
  wire [31:0]  _exp_inst1_rvc_exp_io_out_bits;
  wire         _exp_inst1_rvc_exp_io_rvc;
  wire [31:0]  _exp_inst0_rvc_exp_io_out_bits;
  wire         _exp_inst0_rvc_exp_io_rvc;
  wire         _f3_bpd_resp_io_enq_ready;
  wire [39:0]  _f3_bpd_resp_io_deq_bits_pc;
  wire         _f3_bpd_resp_io_deq_bits_preds_0_taken;
  wire         _f3_bpd_resp_io_deq_bits_preds_0_predicted_pc_valid;
  wire [39:0]  _f3_bpd_resp_io_deq_bits_preds_0_predicted_pc_bits;
  wire         _f3_bpd_resp_io_deq_bits_preds_1_taken;
  wire         _f3_bpd_resp_io_deq_bits_preds_1_predicted_pc_valid;
  wire [39:0]  _f3_bpd_resp_io_deq_bits_preds_1_predicted_pc_bits;
  wire         _f3_bpd_resp_io_deq_bits_preds_2_taken;
  wire         _f3_bpd_resp_io_deq_bits_preds_2_predicted_pc_valid;
  wire [39:0]  _f3_bpd_resp_io_deq_bits_preds_2_predicted_pc_bits;
  wire         _f3_bpd_resp_io_deq_bits_preds_3_taken;
  wire         _f3_bpd_resp_io_deq_bits_preds_3_predicted_pc_valid;
  wire [39:0]  _f3_bpd_resp_io_deq_bits_preds_3_predicted_pc_bits;
  wire         _f3_bpd_resp_io_deq_bits_preds_4_taken;
  wire         _f3_bpd_resp_io_deq_bits_preds_4_predicted_pc_valid;
  wire [39:0]  _f3_bpd_resp_io_deq_bits_preds_4_predicted_pc_bits;
  wire         _f3_bpd_resp_io_deq_bits_preds_5_taken;
  wire         _f3_bpd_resp_io_deq_bits_preds_5_predicted_pc_valid;
  wire [39:0]  _f3_bpd_resp_io_deq_bits_preds_5_predicted_pc_bits;
  wire         _f3_bpd_resp_io_deq_bits_preds_6_taken;
  wire         _f3_bpd_resp_io_deq_bits_preds_6_predicted_pc_valid;
  wire [39:0]  _f3_bpd_resp_io_deq_bits_preds_6_predicted_pc_bits;
  wire         _f3_bpd_resp_io_deq_bits_preds_7_taken;
  wire         _f3_bpd_resp_io_deq_bits_preds_7_predicted_pc_valid;
  wire [39:0]  _f3_bpd_resp_io_deq_bits_preds_7_predicted_pc_bits;
  wire [119:0] _f3_bpd_resp_io_deq_bits_meta_0;
  wire [119:0] _f3_bpd_resp_io_deq_bits_meta_1;
  wire         _f3_io_enq_ready;
  wire         _f3_io_deq_valid;
  wire [39:0]  _f3_io_deq_bits_pc;
  wire [127:0] _f3_io_deq_bits_data;
  wire [7:0]   _f3_io_deq_bits_mask;
  wire         _f3_io_deq_bits_xcpt_pf_inst;
  wire         _f3_io_deq_bits_xcpt_ae_inst;
  wire [63:0]  _f3_io_deq_bits_ghist_old_history;
  wire         _f3_io_deq_bits_ghist_current_saw_branch_not_taken;
  wire         _f3_io_deq_bits_ghist_new_saw_branch_not_taken;
  wire         _f3_io_deq_bits_ghist_new_saw_branch_taken;
  wire [4:0]   _f3_io_deq_bits_ghist_ras_idx;
  wire         _tlb_io_resp_miss;
  wire [31:0]  _tlb_io_resp_paddr;
  wire         _tlb_io_resp_pf_inst;
  wire         _tlb_io_resp_ae_inst;
  wire [39:0]  _ras_io_read_addr;
  wire         _bpd_io_resp_f1_preds_0_taken;
  wire         _bpd_io_resp_f1_preds_0_is_br;
  wire         _bpd_io_resp_f1_preds_0_is_jal;
  wire         _bpd_io_resp_f1_preds_0_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f1_preds_0_predicted_pc_bits;
  wire         _bpd_io_resp_f1_preds_1_taken;
  wire         _bpd_io_resp_f1_preds_1_is_br;
  wire         _bpd_io_resp_f1_preds_1_is_jal;
  wire         _bpd_io_resp_f1_preds_1_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f1_preds_1_predicted_pc_bits;
  wire         _bpd_io_resp_f1_preds_2_taken;
  wire         _bpd_io_resp_f1_preds_2_is_br;
  wire         _bpd_io_resp_f1_preds_2_is_jal;
  wire         _bpd_io_resp_f1_preds_2_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f1_preds_2_predicted_pc_bits;
  wire         _bpd_io_resp_f1_preds_3_taken;
  wire         _bpd_io_resp_f1_preds_3_is_br;
  wire         _bpd_io_resp_f1_preds_3_is_jal;
  wire         _bpd_io_resp_f1_preds_3_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f1_preds_3_predicted_pc_bits;
  wire         _bpd_io_resp_f1_preds_4_taken;
  wire         _bpd_io_resp_f1_preds_4_is_br;
  wire         _bpd_io_resp_f1_preds_4_is_jal;
  wire         _bpd_io_resp_f1_preds_4_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f1_preds_4_predicted_pc_bits;
  wire         _bpd_io_resp_f1_preds_5_taken;
  wire         _bpd_io_resp_f1_preds_5_is_br;
  wire         _bpd_io_resp_f1_preds_5_is_jal;
  wire         _bpd_io_resp_f1_preds_5_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f1_preds_5_predicted_pc_bits;
  wire         _bpd_io_resp_f1_preds_6_taken;
  wire         _bpd_io_resp_f1_preds_6_is_br;
  wire         _bpd_io_resp_f1_preds_6_is_jal;
  wire         _bpd_io_resp_f1_preds_6_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f1_preds_6_predicted_pc_bits;
  wire         _bpd_io_resp_f1_preds_7_taken;
  wire         _bpd_io_resp_f1_preds_7_is_br;
  wire         _bpd_io_resp_f1_preds_7_is_jal;
  wire         _bpd_io_resp_f1_preds_7_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f1_preds_7_predicted_pc_bits;
  wire         _bpd_io_resp_f2_preds_0_taken;
  wire         _bpd_io_resp_f2_preds_0_is_br;
  wire         _bpd_io_resp_f2_preds_0_is_jal;
  wire         _bpd_io_resp_f2_preds_0_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f2_preds_0_predicted_pc_bits;
  wire         _bpd_io_resp_f2_preds_1_taken;
  wire         _bpd_io_resp_f2_preds_1_is_br;
  wire         _bpd_io_resp_f2_preds_1_is_jal;
  wire         _bpd_io_resp_f2_preds_1_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f2_preds_1_predicted_pc_bits;
  wire         _bpd_io_resp_f2_preds_2_taken;
  wire         _bpd_io_resp_f2_preds_2_is_br;
  wire         _bpd_io_resp_f2_preds_2_is_jal;
  wire         _bpd_io_resp_f2_preds_2_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f2_preds_2_predicted_pc_bits;
  wire         _bpd_io_resp_f2_preds_3_taken;
  wire         _bpd_io_resp_f2_preds_3_is_br;
  wire         _bpd_io_resp_f2_preds_3_is_jal;
  wire         _bpd_io_resp_f2_preds_3_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f2_preds_3_predicted_pc_bits;
  wire         _bpd_io_resp_f2_preds_4_taken;
  wire         _bpd_io_resp_f2_preds_4_is_br;
  wire         _bpd_io_resp_f2_preds_4_is_jal;
  wire         _bpd_io_resp_f2_preds_4_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f2_preds_4_predicted_pc_bits;
  wire         _bpd_io_resp_f2_preds_5_taken;
  wire         _bpd_io_resp_f2_preds_5_is_br;
  wire         _bpd_io_resp_f2_preds_5_is_jal;
  wire         _bpd_io_resp_f2_preds_5_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f2_preds_5_predicted_pc_bits;
  wire         _bpd_io_resp_f2_preds_6_taken;
  wire         _bpd_io_resp_f2_preds_6_is_br;
  wire         _bpd_io_resp_f2_preds_6_is_jal;
  wire         _bpd_io_resp_f2_preds_6_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f2_preds_6_predicted_pc_bits;
  wire         _bpd_io_resp_f2_preds_7_taken;
  wire         _bpd_io_resp_f2_preds_7_is_br;
  wire         _bpd_io_resp_f2_preds_7_is_jal;
  wire         _bpd_io_resp_f2_preds_7_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f2_preds_7_predicted_pc_bits;
  wire [39:0]  _bpd_io_resp_f3_pc;
  wire         _bpd_io_resp_f3_preds_0_taken;
  wire         _bpd_io_resp_f3_preds_0_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f3_preds_0_predicted_pc_bits;
  wire         _bpd_io_resp_f3_preds_1_taken;
  wire         _bpd_io_resp_f3_preds_1_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f3_preds_1_predicted_pc_bits;
  wire         _bpd_io_resp_f3_preds_2_taken;
  wire         _bpd_io_resp_f3_preds_2_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f3_preds_2_predicted_pc_bits;
  wire         _bpd_io_resp_f3_preds_3_taken;
  wire         _bpd_io_resp_f3_preds_3_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f3_preds_3_predicted_pc_bits;
  wire         _bpd_io_resp_f3_preds_4_taken;
  wire         _bpd_io_resp_f3_preds_4_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f3_preds_4_predicted_pc_bits;
  wire         _bpd_io_resp_f3_preds_5_taken;
  wire         _bpd_io_resp_f3_preds_5_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f3_preds_5_predicted_pc_bits;
  wire         _bpd_io_resp_f3_preds_6_taken;
  wire         _bpd_io_resp_f3_preds_6_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f3_preds_6_predicted_pc_bits;
  wire         _bpd_io_resp_f3_preds_7_taken;
  wire         _bpd_io_resp_f3_preds_7_predicted_pc_valid;
  wire [39:0]  _bpd_io_resp_f3_preds_7_predicted_pc_bits;
  wire [119:0] _bpd_io_resp_f3_meta_0;
  wire [119:0] _bpd_io_resp_f3_meta_1;
  wire         _icache_io_resp_valid;
  wire [127:0] _icache_io_resp_bits_data;
  reg          casez_tmp;
  reg  [39:0]  casez_tmp_0;
  reg  [39:0]  casez_tmp_1;
  reg          casez_tmp_2;
  reg          casez_tmp_3;
  reg  [39:0]  casez_tmp_4;
  reg          casez_tmp_5;
  reg          casez_tmp_6;
  reg  [2:0]   casez_tmp_7;
  reg          casez_tmp_8;
  reg          casez_tmp_9;
  reg          REG;
  wire         _GEN_0 = REG & ~reset;
  reg  [39:0]  s1_vpc;
  reg          s1_valid;
  reg  [63:0]  s1_ghist_old_history;
  reg          s1_ghist_current_saw_branch_not_taken;
  reg          s1_ghist_new_saw_branch_not_taken;
  reg          s1_ghist_new_saw_branch_taken;
  reg  [4:0]   s1_ghist_ras_idx;
  reg          s1_is_replay;
  reg          s1_is_sfence;
  wire         _GEN = _f3_io_deq_valid & _f4_io_enq_ready;
  reg          s2_valid;
  reg  [39:0]  s2_vpc;
  wire         f3_mask_0 = _f3_io_deq_valid & _f3_io_deq_bits_mask[0];
  reg          f3_prev_is_half;
  wire [2:0]   brsigs_cfi_type = f3_prev_is_half ? _bpd_decoder0_io_out_cfi_type : _bpd_decoder1_io_out_cfi_type;
  wire         _f3_btb_mispredicts_0_T_1 = brsigs_cfi_type == 3'h2;
  wire         _f3_targs_0_T = brsigs_cfi_type == 3'h3;
  wire         _f3_br_mask_0_T = brsigs_cfi_type == 3'h1;
  wire         f3_redirects_0 = f3_mask_0 & (_f3_btb_mispredicts_0_T_1 | _f3_targs_0_T | _f3_br_mask_0_T & _f3_bpd_resp_io_deq_bits_preds_0_taken);
  reg  [15:0]  f3_prev_half;
  wire [31:0]  inst0 = {_f3_io_deq_bits_data[15:0], f3_prev_half};
  wire [31:0]  bank_insts__0 = f3_prev_is_half ? inst0 : _f3_io_deq_bits_data[31:0];
  wire         valid_1 = f3_prev_is_half | ~(_f3_io_deq_valid & _f3_io_deq_bits_mask[0] & (&(bank_insts__0[1:0])));
  wire         f3_mask_1 = _f3_io_deq_valid & _f3_io_deq_bits_mask[1] & valid_1 & ~f3_redirects_0;
  wire         _f3_btb_mispredicts_1_T = _bpd_decoder_io_out_cfi_type == 3'h2;
  wire         _f3_targs_1_T = _bpd_decoder_io_out_cfi_type == 3'h3;
  wire         _f3_br_mask_1_T = _bpd_decoder_io_out_cfi_type == 3'h1;
  wire         f3_redirects_1 = f3_mask_1 & (_f3_btb_mispredicts_1_T | _f3_targs_1_T | _f3_br_mask_1_T & _f3_bpd_resp_io_deq_bits_preds_1_taken);
  wire         _f3_fetch_bundle_cfi_idx_valid_T = f3_redirects_0 | f3_redirects_1;
  wire         _valid_T_9 = _f3_io_deq_valid & _f3_io_deq_bits_mask[1] & valid_1 & ~f3_redirects_0 & (&(_f3_io_deq_bits_data[17:16]));
  wire         _GEN_1 = f3_redirects_0 | f3_redirects_1;
  wire         f3_mask_2 = _f3_io_deq_valid & _f3_io_deq_bits_mask[2] & ~_valid_T_9 & ~_GEN_1;
  wire         _f3_btb_mispredicts_2_T = _bpd_decoder_1_io_out_cfi_type == 3'h2;
  wire         _f3_targs_2_T = _bpd_decoder_1_io_out_cfi_type == 3'h3;
  wire         _f3_br_mask_2_T = _bpd_decoder_1_io_out_cfi_type == 3'h1;
  wire         f3_redirects_2 = f3_mask_2 & (_f3_btb_mispredicts_2_T | _f3_targs_2_T | _f3_br_mask_2_T & _f3_bpd_resp_io_deq_bits_preds_2_taken);
  wire         bank_mask__2 = _f3_io_deq_valid & _f3_io_deq_bits_mask[2] & ~_valid_T_9 & ~_GEN_1;
  wire [31:0]  inst_2 = {16'h0, _f3_io_deq_bits_data[63:48]};
  wire         _valid_T_18 = bank_mask__2 & (&(_f3_io_deq_bits_data[33:32])) | (&(_f3_io_deq_bits_data[49:48]));
  wire         _GEN_2 = _GEN_1 | f3_redirects_2;
  wire         f3_mask_3 = _f3_io_deq_valid & _f3_io_deq_bits_mask[3] & ~_valid_T_18 & ~_GEN_2;
  wire         _f3_btb_mispredicts_3_T = _bpd_decoder_2_io_out_cfi_type == 3'h2;
  wire         _f3_targs_3_T = _bpd_decoder_2_io_out_cfi_type == 3'h3;
  wire         _f3_br_mask_3_T = _bpd_decoder_2_io_out_cfi_type == 3'h1;
  wire         f3_redirects_3 = f3_mask_3 & (_f3_btb_mispredicts_3_T | _f3_targs_3_T | _f3_br_mask_3_T & _f3_bpd_resp_io_deq_bits_preds_3_taken);
  wire         _GEN_3 = _GEN_2 | f3_redirects_3;
  wire         f3_mask_4 = _f3_io_deq_valid & _f3_io_deq_bits_mask[4] & ~_GEN_3;
  wire         f3_fetch_bundle_edge_inst_1 = ~(bank_mask__2 & (&(_f3_io_deq_bits_data[33:32]))) & (&(_f3_io_deq_bits_data[49:48]));
  wire [2:0]   f3_cfi_types_4 = f3_fetch_bundle_edge_inst_1 ? _bpd_decoder0b_io_out_cfi_type : _bpd_decoder1_1_io_out_cfi_type;
  wire         _f3_btb_mispredicts_4_T_1 = f3_cfi_types_4 == 3'h2;
  wire         _f3_targs_4_T = f3_cfi_types_4 == 3'h3;
  wire         _f3_br_mask_4_T = f3_cfi_types_4 == 3'h1;
  wire         f3_redirects_4 = f3_mask_4 & (_f3_btb_mispredicts_4_T_1 | _f3_targs_4_T | _f3_br_mask_4_T & _f3_bpd_resp_io_deq_bits_preds_4_taken);
  wire [31:0]  bank_insts_1_0 = f3_fetch_bundle_edge_inst_1 ? _f3_io_deq_bits_data[79:48] : _f3_io_deq_bits_data[95:64];
  wire         valid_5 = f3_fetch_bundle_edge_inst_1 | ~(_f3_io_deq_valid & _f3_io_deq_bits_mask[4] & ~_GEN_3 & (&(bank_insts_1_0[1:0])));
  wire         _GEN_4 = _GEN_3 | f3_redirects_4;
  wire         f3_mask_5 = _f3_io_deq_valid & _f3_io_deq_bits_mask[5] & valid_5 & ~_GEN_4;
  wire         _f3_btb_mispredicts_5_T = _bpd_decoder_3_io_out_cfi_type == 3'h2;
  wire         _f3_targs_5_T = _bpd_decoder_3_io_out_cfi_type == 3'h3;
  wire         _f3_br_mask_5_T = _bpd_decoder_3_io_out_cfi_type == 3'h1;
  wire         f3_redirects_5 = f3_mask_5 & (_f3_btb_mispredicts_5_T | _f3_targs_5_T | _f3_br_mask_5_T & _f3_bpd_resp_io_deq_bits_preds_5_taken);
  wire         _valid_T_29 = _f3_io_deq_valid & _f3_io_deq_bits_mask[5] & valid_5 & ~_GEN_4 & (&(_f3_io_deq_bits_data[81:80]));
  wire         _GEN_5 = _GEN_4 | f3_redirects_5;
  wire         f3_mask_6 = _f3_io_deq_valid & _f3_io_deq_bits_mask[6] & ~_valid_T_29 & ~_GEN_5;
  wire         _f3_btb_mispredicts_6_T = _bpd_decoder_4_io_out_cfi_type == 3'h2;
  wire         _f3_targs_6_T = _bpd_decoder_4_io_out_cfi_type == 3'h3;
  wire         _f3_br_mask_6_T = _bpd_decoder_4_io_out_cfi_type == 3'h1;
  wire         f3_redirects_6 = f3_mask_6 & (_f3_btb_mispredicts_6_T | _f3_targs_6_T | _f3_br_mask_6_T & _f3_bpd_resp_io_deq_bits_preds_6_taken);
  wire         bank_mask_1_2 = _f3_io_deq_valid & _f3_io_deq_bits_mask[6] & ~_valid_T_29 & ~_GEN_5;
  wire [31:0]  inst_5 = {16'h0, _f3_io_deq_bits_data[127:112]};
  wire         _valid_T_38 = bank_mask_1_2 & (&(_f3_io_deq_bits_data[97:96])) | (&(_f3_io_deq_bits_data[113:112]));
  wire         f3_mask_7 = _f3_io_deq_valid & _f3_io_deq_bits_mask[7] & ~_valid_T_38 & ~(_GEN_5 | f3_redirects_6);
  wire         _f3_btb_mispredicts_7_T = _bpd_decoder_5_io_out_cfi_type == 3'h2;
  wire         _f3_targs_7_T = _bpd_decoder_5_io_out_cfi_type == 3'h3;
  wire         _f3_br_mask_7_T = _bpd_decoder_5_io_out_cfi_type == 3'h1;
  wire         f3_redirects_7 = f3_mask_7 & (_f3_btb_mispredicts_7_T | _f3_targs_7_T | _f3_br_mask_7_T & _f3_bpd_resp_io_deq_bits_preds_7_taken);
  wire         _f3_predicted_target_T_6 = _f3_fetch_bundle_cfi_idx_valid_T | f3_redirects_2 | f3_redirects_3 | f3_redirects_4 | f3_redirects_5 | f3_redirects_6 | f3_redirects_7;
  wire [2:0]   _f3_predicted_target_T_9 = {2'h3, ~f3_redirects_6};
  wire [2:0]   f3_fetch_bundle_cfi_idx_bits = f3_redirects_0 ? 3'h0 : f3_redirects_1 ? 3'h1 : f3_redirects_2 ? 3'h2 : f3_redirects_3 ? 3'h3 : f3_redirects_4 ? 3'h4 : f3_redirects_5 ? 3'h5 : _f3_predicted_target_T_9;
  always @(*) begin
    casez (f3_fetch_bundle_cfi_idx_bits)
      3'b000:
        casez_tmp = f3_prev_is_half ? _bpd_decoder0_io_out_is_ret : _bpd_decoder1_io_out_is_ret;
      3'b001:
        casez_tmp = _bpd_decoder_io_out_is_ret;
      3'b010:
        casez_tmp = _bpd_decoder_1_io_out_is_ret;
      3'b011:
        casez_tmp = _bpd_decoder_2_io_out_is_ret;
      3'b100:
        casez_tmp = f3_fetch_bundle_edge_inst_1 ? _bpd_decoder0b_io_out_is_ret : _bpd_decoder1_1_io_out_is_ret;
      3'b101:
        casez_tmp = _bpd_decoder_3_io_out_is_ret;
      3'b110:
        casez_tmp = _bpd_decoder_4_io_out_is_ret;
      default:
        casez_tmp = _bpd_decoder_5_io_out_is_ret;
    endcase
  end // always @(*)
  wire [39:0]  brsigs_4_target = f3_fetch_bundle_edge_inst_1 ? _bpd_decoder0b_io_out_target : _bpd_decoder1_1_io_out_target;
  wire [39:0]  brsigs_target = f3_prev_is_half ? _bpd_decoder0_io_out_target : _bpd_decoder1_io_out_target;
  always @(*) begin
    casez (f3_redirects_0 ? 3'h0 : f3_redirects_1 ? 3'h1 : f3_redirects_2 ? 3'h2 : f3_redirects_3 ? 3'h3 : f3_redirects_4 ? 3'h4 : f3_redirects_5 ? 3'h5 : _f3_predicted_target_T_9)
      3'b000:
        casez_tmp_0 = _f3_targs_0_T ? _f3_bpd_resp_io_deq_bits_preds_0_predicted_pc_bits : brsigs_target;
      3'b001:
        casez_tmp_0 = _f3_targs_1_T ? _f3_bpd_resp_io_deq_bits_preds_1_predicted_pc_bits : _bpd_decoder_io_out_target;
      3'b010:
        casez_tmp_0 = _f3_targs_2_T ? _f3_bpd_resp_io_deq_bits_preds_2_predicted_pc_bits : _bpd_decoder_1_io_out_target;
      3'b011:
        casez_tmp_0 = _f3_targs_3_T ? _f3_bpd_resp_io_deq_bits_preds_3_predicted_pc_bits : _bpd_decoder_2_io_out_target;
      3'b100:
        casez_tmp_0 = _f3_targs_4_T ? _f3_bpd_resp_io_deq_bits_preds_4_predicted_pc_bits : brsigs_4_target;
      3'b101:
        casez_tmp_0 = _f3_targs_5_T ? _f3_bpd_resp_io_deq_bits_preds_5_predicted_pc_bits : _bpd_decoder_3_io_out_target;
      3'b110:
        casez_tmp_0 = _f3_targs_6_T ? _f3_bpd_resp_io_deq_bits_preds_6_predicted_pc_bits : _bpd_decoder_4_io_out_target;
      default:
        casez_tmp_0 = _f3_targs_7_T ? _f3_bpd_resp_io_deq_bits_preds_7_predicted_pc_bits : _bpd_decoder_5_io_out_target;
    endcase
  end // always @(*)
  wire [39:0]  _GEN_6 = {_f3_io_deq_bits_pc[39:3], 3'h0};
  wire [39:0]  _f3_predicted_target_T_24 = _GEN_6 + {35'h0, (&(_f3_io_deq_bits_pc[5:3])) ? 5'h8 : 5'h10};
  wire [39:0]  f3_predicted_target = _f3_predicted_target_T_6 ? (casez_tmp ? _ras_io_read_addr : casez_tmp_0) : _f3_predicted_target_T_24;
  reg  [63:0]  s2_ghist_old_history;
  wire         f3_fetch_bundle_cfi_idx_valid = _f3_fetch_bundle_cfi_idx_valid_T | f3_redirects_2 | f3_redirects_3 | f3_redirects_4 | f3_redirects_5 | f3_redirects_6 | f3_redirects_7;
  wire         f3_predicted_ghist_cfi_in_bank_0 = f3_fetch_bundle_cfi_idx_valid & ~(f3_fetch_bundle_cfi_idx_bits[2]);
  wire         f3_predicted_ghist_ignore_second_bank = f3_predicted_ghist_cfi_in_bank_0 | (&(_f3_io_deq_bits_pc[5:3]));
  wire [63:0]  _GEN_7 = {_f3_io_deq_bits_ghist_old_history[62:0], 1'h0};
  wire [63:0]  _GEN_8 = {_f3_io_deq_bits_ghist_old_history[62:0], 1'h1};
  wire         f3_br_mask_7 = f3_mask_7 & _f3_br_mask_7_T;
  wire         f3_br_mask_6 = f3_mask_6 & _f3_br_mask_6_T;
  wire         f3_br_mask_5 = f3_mask_5 & _f3_br_mask_5_T;
  wire         f3_br_mask_4 = f3_mask_4 & _f3_br_mask_4_T;
  wire         f3_br_mask_3 = f3_mask_3 & _f3_br_mask_3_T;
  wire         f3_br_mask_2 = f3_mask_2 & _f3_br_mask_2_T;
  wire         f3_br_mask_1 = f3_mask_1 & _f3_br_mask_1_T;
  wire         f3_br_mask_0 = f3_mask_0 & _f3_br_mask_0_T;
  wire [7:0]   f3_fetch_bundle_br_mask = {f3_br_mask_7, f3_br_mask_6, f3_br_mask_5, f3_br_mask_4, f3_br_mask_3, f3_br_mask_2, f3_br_mask_1, f3_br_mask_0};
  wire [7:0]   _GEN_9 = {5'h0, f3_fetch_bundle_cfi_idx_bits};
  wire [7:0]   _f3_predicted_ghist_T = f3_fetch_bundle_br_mask >> _GEN_9;
  wire         _f3_predicted_ghist_new_history_new_saw_branch_taken_T = _f3_predicted_ghist_T[0] & f3_predicted_ghist_cfi_in_bank_0;
  wire [62:0]  _GEN_10 = {_f3_io_deq_bits_ghist_old_history[61:0], 1'h0};
  wire [62:0]  _GEN_11 = {_f3_io_deq_bits_ghist_old_history[61:0], 1'h1};
  wire [7:0]   f3_predicted_ghist_cfi_idx_oh = 8'h1 << _GEN_9;
  wire [6:0]   _GEN_12 = f3_predicted_ghist_cfi_idx_oh[6:0] | f3_predicted_ghist_cfi_idx_oh[7:1];
  wire [5:0]   _GEN_13 = _GEN_12[5:0] | f3_predicted_ghist_cfi_idx_oh[7:2];
  wire [4:0]   _GEN_14 = _GEN_13[4:0] | f3_predicted_ghist_cfi_idx_oh[7:3];
  wire [3:0]   _GEN_15 = _GEN_14[3:0] | f3_predicted_ghist_cfi_idx_oh[7:4];
  wire [2:0]   _GEN_16 = _GEN_15[2:0] | f3_predicted_ghist_cfi_idx_oh[7:5];
  wire [1:0]   _GEN_17 = _GEN_16[1:0] | f3_predicted_ghist_cfi_idx_oh[7:6];
  wire [7:0]   _f3_predicted_ghist_not_taken_branches_T_20 = f3_fetch_bundle_cfi_idx_valid ? {&f3_fetch_bundle_cfi_idx_bits, _GEN_12[6], _GEN_13[5], _GEN_14[4], _GEN_15[3], _GEN_16[2], _GEN_17[1], _GEN_17[0] | (&f3_fetch_bundle_cfi_idx_bits)} & ~(_f3_predicted_ghist_T[0] & f3_fetch_bundle_cfi_idx_valid ? f3_predicted_ghist_cfi_idx_oh : 8'h0) : 8'hFF;
  wire         f3_predicted_ghist_first_bank_saw_not_taken = (|({f3_br_mask_3, f3_br_mask_2, f3_br_mask_1, f3_br_mask_0} & _f3_predicted_ghist_not_taken_branches_T_20[3:0])) | _f3_io_deq_bits_ghist_current_saw_branch_not_taken;
  wire [63:0]  _GEN_180 = f3_predicted_ghist_ignore_second_bank ? (_f3_io_deq_bits_ghist_new_saw_branch_taken ? _GEN_8 : _f3_io_deq_bits_ghist_new_saw_branch_not_taken ? _GEN_7 : _f3_io_deq_bits_ghist_old_history) : _f3_predicted_ghist_new_history_new_saw_branch_taken_T ? {_f3_io_deq_bits_ghist_new_saw_branch_taken ? _GEN_11 : _f3_io_deq_bits_ghist_new_saw_branch_not_taken ? _GEN_10 : _f3_io_deq_bits_ghist_old_history[62:0], 1'h1} : f3_predicted_ghist_first_bank_saw_not_taken ? {_f3_io_deq_bits_ghist_new_saw_branch_taken ? _GEN_11 : _f3_io_deq_bits_ghist_new_saw_branch_not_taken ? _GEN_10 : _f3_io_deq_bits_ghist_old_history[62:0], 1'h0} : _f3_io_deq_bits_ghist_new_saw_branch_taken ? _GEN_8 : _f3_io_deq_bits_ghist_new_saw_branch_not_taken ? _GEN_7 : _f3_io_deq_bits_ghist_old_history;
  reg          s2_ghist_new_saw_branch_not_taken;
  wire [3:0]   _f3_predicted_ghist_new_history_new_saw_branch_not_taken_T = {f3_br_mask_7, f3_br_mask_6, f3_br_mask_5, f3_br_mask_4} & _f3_predicted_ghist_not_taken_branches_T_20[7:4];
  wire         f3_predicted_ghist_new_saw_branch_not_taken = f3_predicted_ghist_ignore_second_bank ? f3_predicted_ghist_first_bank_saw_not_taken : (|_f3_predicted_ghist_new_history_new_saw_branch_not_taken_T);
  reg          s2_ghist_new_saw_branch_taken;
  wire         _f3_predicted_ghist_new_history_new_saw_branch_taken_T_4 = f3_fetch_bundle_cfi_idx_valid & _f3_predicted_ghist_T[0] & ~f3_predicted_ghist_cfi_in_bank_0;
  wire         f3_predicted_ghist_new_saw_branch_taken = f3_predicted_ghist_ignore_second_bank ? _f3_predicted_ghist_new_history_new_saw_branch_taken_T : _f3_predicted_ghist_new_history_new_saw_branch_taken_T_4;
  wire         _f3_correct_f2_ghist_T_4 = s2_ghist_old_history == _GEN_180 & s2_ghist_new_saw_branch_not_taken == f3_predicted_ghist_new_saw_branch_not_taken & s2_ghist_new_saw_branch_taken == f3_predicted_ghist_new_saw_branch_taken;
  wire         _GEN_18 = s2_valid & s2_vpc == f3_predicted_target & _f3_correct_f2_ghist_T_4;
  wire         _s0_is_replay_T = s2_valid & _icache_io_resp_valid;
  wire         _GEN_19 = s2_valid & ~_icache_io_resp_valid | _s0_is_replay_T & ~_f3_io_enq_ready;
  wire         _GEN_20 = s2_valid & _f3_io_enq_ready;
  wire [10:0]  _f2_mask_T = 11'hFF << s2_vpc[2:1];
  wire [7:0]   _GEN_21 = _f2_mask_T[7:0] & ((&(s2_vpc[5:3])) ? 8'hF : 8'hFF);
  wire         f2_redirects_0 = s2_valid & _GEN_21[0] & _bpd_io_resp_f2_preds_0_predicted_pc_valid & (_bpd_io_resp_f2_preds_0_is_jal | _bpd_io_resp_f2_preds_0_is_br & _bpd_io_resp_f2_preds_0_taken);
  wire         f2_redirects_1 = s2_valid & _GEN_21[1] & _bpd_io_resp_f2_preds_1_predicted_pc_valid & (_bpd_io_resp_f2_preds_1_is_jal | _bpd_io_resp_f2_preds_1_is_br & _bpd_io_resp_f2_preds_1_taken);
  wire         f2_redirects_2 = s2_valid & _GEN_21[2] & _bpd_io_resp_f2_preds_2_predicted_pc_valid & (_bpd_io_resp_f2_preds_2_is_jal | _bpd_io_resp_f2_preds_2_is_br & _bpd_io_resp_f2_preds_2_taken);
  wire         f2_redirects_3 = s2_valid & _GEN_21[3] & _bpd_io_resp_f2_preds_3_predicted_pc_valid & (_bpd_io_resp_f2_preds_3_is_jal | _bpd_io_resp_f2_preds_3_is_br & _bpd_io_resp_f2_preds_3_taken);
  wire         f2_redirects_4 = s2_valid & _GEN_21[4] & _bpd_io_resp_f2_preds_4_predicted_pc_valid & (_bpd_io_resp_f2_preds_4_is_jal | _bpd_io_resp_f2_preds_4_is_br & _bpd_io_resp_f2_preds_4_taken);
  wire         f2_redirects_5 = s2_valid & _GEN_21[5] & _bpd_io_resp_f2_preds_5_predicted_pc_valid & (_bpd_io_resp_f2_preds_5_is_jal | _bpd_io_resp_f2_preds_5_is_br & _bpd_io_resp_f2_preds_5_taken);
  wire         f2_redirects_6 = s2_valid & _GEN_21[6] & _bpd_io_resp_f2_preds_6_predicted_pc_valid & (_bpd_io_resp_f2_preds_6_is_jal | _bpd_io_resp_f2_preds_6_is_br & _bpd_io_resp_f2_preds_6_taken);
  wire         f2_do_redirect = f2_redirects_0 | f2_redirects_1 | f2_redirects_2 | f2_redirects_3 | f2_redirects_4 | f2_redirects_5 | f2_redirects_6 | s2_valid & _GEN_21[7] & _bpd_io_resp_f2_preds_7_predicted_pc_valid & (_bpd_io_resp_f2_preds_7_is_jal | _bpd_io_resp_f2_preds_7_is_br & _bpd_io_resp_f2_preds_7_taken);
  wire [2:0]   f2_redirect_idx = f2_redirects_0 ? 3'h0 : f2_redirects_1 ? 3'h1 : f2_redirects_2 ? 3'h2 : f2_redirects_3 ? 3'h3 : f2_redirects_4 ? 3'h4 : f2_redirects_5 ? 3'h5 : {2'h3, ~f2_redirects_6};
  always @(*) begin
    casez (f2_redirect_idx)
      3'b000:
        casez_tmp_1 = _bpd_io_resp_f2_preds_0_predicted_pc_bits;
      3'b001:
        casez_tmp_1 = _bpd_io_resp_f2_preds_1_predicted_pc_bits;
      3'b010:
        casez_tmp_1 = _bpd_io_resp_f2_preds_2_predicted_pc_bits;
      3'b011:
        casez_tmp_1 = _bpd_io_resp_f2_preds_3_predicted_pc_bits;
      3'b100:
        casez_tmp_1 = _bpd_io_resp_f2_preds_4_predicted_pc_bits;
      3'b101:
        casez_tmp_1 = _bpd_io_resp_f2_preds_5_predicted_pc_bits;
      3'b110:
        casez_tmp_1 = _bpd_io_resp_f2_preds_6_predicted_pc_bits;
      default:
        casez_tmp_1 = _bpd_io_resp_f2_preds_7_predicted_pc_bits;
    endcase
  end // always @(*)
  wire [39:0]  _f2_predicted_target_T_21 = {s2_vpc[39:3], 3'h0} + {35'h0, (&(s2_vpc[5:3])) ? 5'h8 : 5'h10};
  wire [39:0]  f2_predicted_target = f2_do_redirect ? casez_tmp_1 : _f2_predicted_target_T_21;
  always @(*) begin
    casez (f2_redirect_idx)
      3'b000:
        casez_tmp_2 = _bpd_io_resp_f2_preds_0_taken;
      3'b001:
        casez_tmp_2 = _bpd_io_resp_f2_preds_1_taken;
      3'b010:
        casez_tmp_2 = _bpd_io_resp_f2_preds_2_taken;
      3'b011:
        casez_tmp_2 = _bpd_io_resp_f2_preds_3_taken;
      3'b100:
        casez_tmp_2 = _bpd_io_resp_f2_preds_4_taken;
      3'b101:
        casez_tmp_2 = _bpd_io_resp_f2_preds_5_taken;
      3'b110:
        casez_tmp_2 = _bpd_io_resp_f2_preds_6_taken;
      default:
        casez_tmp_2 = _bpd_io_resp_f2_preds_7_taken;
    endcase
  end // always @(*)
  wire         _f2_predicted_ghist_T_10 = casez_tmp_2 & f2_do_redirect;
  wire         _f2_predicted_ghist_new_history_new_saw_branch_taken_T_1 = f2_do_redirect & _f2_predicted_ghist_T_10;
  wire         f2_predicted_ghist_cfi_in_bank_0 = _f2_predicted_ghist_new_history_new_saw_branch_taken_T_1 & ~(f2_redirect_idx[2]);
  wire         f2_predicted_ghist_ignore_second_bank = f2_predicted_ghist_cfi_in_bank_0 | (&(s2_vpc[5:3]));
  wire [63:0]  _GEN_22 = {s2_ghist_old_history[62:0], 1'h0};
  wire [63:0]  _GEN_23 = {s2_ghist_old_history[62:0], 1'h1};
  always @(*) begin
    casez (f2_redirect_idx)
      3'b000:
        casez_tmp_3 = _bpd_io_resp_f2_preds_0_is_br;
      3'b001:
        casez_tmp_3 = _bpd_io_resp_f2_preds_1_is_br;
      3'b010:
        casez_tmp_3 = _bpd_io_resp_f2_preds_2_is_br;
      3'b011:
        casez_tmp_3 = _bpd_io_resp_f2_preds_3_is_br;
      3'b100:
        casez_tmp_3 = _bpd_io_resp_f2_preds_4_is_br;
      3'b101:
        casez_tmp_3 = _bpd_io_resp_f2_preds_5_is_br;
      3'b110:
        casez_tmp_3 = _bpd_io_resp_f2_preds_6_is_br;
      default:
        casez_tmp_3 = _bpd_io_resp_f2_preds_7_is_br;
    endcase
  end // always @(*)
  wire [62:0]  _GEN_24 = {s2_ghist_old_history[61:0], 1'h0};
  wire [62:0]  _GEN_25 = {s2_ghist_old_history[61:0], 1'h1};
  wire [7:0]   f2_predicted_ghist_cfi_idx_oh = 8'h1 << f2_redirect_idx;
  wire [6:0]   _GEN_26 = f2_predicted_ghist_cfi_idx_oh[6:0] | f2_predicted_ghist_cfi_idx_oh[7:1];
  wire [5:0]   _GEN_27 = _GEN_26[5:0] | f2_predicted_ghist_cfi_idx_oh[7:2];
  wire [4:0]   _GEN_28 = _GEN_27[4:0] | f2_predicted_ghist_cfi_idx_oh[7:3];
  wire [3:0]   _GEN_29 = _GEN_28[3:0] | f2_predicted_ghist_cfi_idx_oh[7:4];
  wire [2:0]   _GEN_30 = _GEN_29[2:0] | f2_predicted_ghist_cfi_idx_oh[7:5];
  wire [1:0]   _GEN_31 = _GEN_30[1:0] | f2_predicted_ghist_cfi_idx_oh[7:6];
  wire [7:0]   _GEN_32 = {_bpd_io_resp_f2_preds_7_is_br & _bpd_io_resp_f2_preds_7_predicted_pc_valid, _bpd_io_resp_f2_preds_6_is_br & _bpd_io_resp_f2_preds_6_predicted_pc_valid, _bpd_io_resp_f2_preds_5_is_br & _bpd_io_resp_f2_preds_5_predicted_pc_valid, _bpd_io_resp_f2_preds_4_is_br & _bpd_io_resp_f2_preds_4_predicted_pc_valid, _bpd_io_resp_f2_preds_3_is_br & _bpd_io_resp_f2_preds_3_predicted_pc_valid, _bpd_io_resp_f2_preds_2_is_br & _bpd_io_resp_f2_preds_2_predicted_pc_valid, _bpd_io_resp_f2_preds_1_is_br & _bpd_io_resp_f2_preds_1_predicted_pc_valid, _bpd_io_resp_f2_preds_0_is_br & _bpd_io_resp_f2_preds_0_predicted_pc_valid} & _GEN_21 & (f2_do_redirect ? {&f2_redirect_idx, _GEN_26[6], _GEN_27[5], _GEN_28[4], _GEN_29[3], _GEN_30[2], _GEN_31[1], _GEN_31[0] | (&f2_redirect_idx)} & ~(casez_tmp_3 & _f2_predicted_ghist_T_10 ? f2_predicted_ghist_cfi_idx_oh : 8'h0) : 8'hFF);
  reg          s2_ghist_current_saw_branch_not_taken;
  wire         f2_predicted_ghist_first_bank_saw_not_taken = (|(_GEN_32[3:0])) | s2_ghist_current_saw_branch_not_taken;
  wire [63:0]  _GEN_52 = f2_predicted_ghist_ignore_second_bank ? (s2_ghist_new_saw_branch_taken ? _GEN_23 : s2_ghist_new_saw_branch_not_taken ? _GEN_22 : s2_ghist_old_history) : casez_tmp_3 & f2_predicted_ghist_cfi_in_bank_0 ? {s2_ghist_new_saw_branch_taken ? _GEN_25 : s2_ghist_new_saw_branch_not_taken ? _GEN_24 : s2_ghist_old_history[62:0], 1'h1} : f2_predicted_ghist_first_bank_saw_not_taken ? {s2_ghist_new_saw_branch_taken ? _GEN_25 : s2_ghist_new_saw_branch_not_taken ? _GEN_24 : s2_ghist_old_history[62:0], 1'h0} : s2_ghist_new_saw_branch_taken ? _GEN_23 : s2_ghist_new_saw_branch_not_taken ? _GEN_22 : s2_ghist_old_history;
  wire         f2_predicted_ghist_new_saw_branch_not_taken = f2_predicted_ghist_ignore_second_bank ? f2_predicted_ghist_first_bank_saw_not_taken : (|(_GEN_32[7:4]));
  wire         _f2_predicted_ghist_new_history_new_saw_branch_taken_T = casez_tmp_3 & f2_predicted_ghist_cfi_in_bank_0;
  wire         _f2_predicted_ghist_new_history_new_saw_branch_taken_T_4 = _f2_predicted_ghist_new_history_new_saw_branch_taken_T_1 & casez_tmp_3 & ~f2_predicted_ghist_cfi_in_bank_0;
  wire         f2_predicted_ghist_new_saw_branch_taken = f2_predicted_ghist_ignore_second_bank ? _f2_predicted_ghist_new_history_new_saw_branch_taken_T : _f2_predicted_ghist_new_history_new_saw_branch_taken_T_4;
  wire         _f2_correct_f1_ghist_T_4 = s1_ghist_old_history == _GEN_52 & s1_ghist_new_saw_branch_not_taken == f2_predicted_ghist_new_saw_branch_not_taken & s1_ghist_new_saw_branch_taken == f2_predicted_ghist_new_saw_branch_taken;
  wire         _GEN_60 = s1_valid & (s1_vpc != f2_predicted_target | ~_f2_correct_f1_ghist_T_4) | ~s1_valid;
  wire         _GEN_76 = _GEN_20 & _GEN_60;
  wire         _GEN_33 = ~s2_valid & s1_valid;
  wire         _f3_correct_f1_ghist_T_4 = s1_ghist_old_history == _GEN_180 & s1_ghist_new_saw_branch_not_taken == f3_predicted_ghist_new_saw_branch_not_taken & s1_ghist_new_saw_branch_taken == f3_predicted_ghist_new_saw_branch_taken;
  wire         _GEN_34 = _GEN_33 & s1_vpc == f3_predicted_target & _f3_correct_f1_ghist_T_4;
  wire         _GEN_185 = s2_valid & (s2_vpc != f3_predicted_target | ~_f3_correct_f2_ghist_T_4) | _GEN_33 & (s1_vpc != f3_predicted_target | ~_f3_correct_f1_ghist_T_4) | ~s2_valid & ~s1_valid;
  wire         _GEN_35 = _GEN_18 | _GEN_34;
  wire         _GEN_36 = io_cpu_sfence_valid | io_cpu_redirect_flush;
  wire         f1_clear = _GEN_36 | (~_GEN | _GEN_35 ? _GEN_19 | _GEN_76 : _GEN_185 | _GEN_19 | _GEN_76);
  reg          tlb_io_sfence_REG_valid;
  reg          tlb_io_sfence_REG_bits_rs1;
  reg          tlb_io_sfence_REG_bits_rs2;
  reg  [38:0]  tlb_io_sfence_REG_bits_addr;
  wire         s1_tlb_miss = ~s1_is_replay & _tlb_io_resp_miss;
  reg          s1_tlb_resp_REG_pf_inst;
  reg          s1_tlb_resp_REG_ae_inst;
  reg  [31:0]  s1_ppc_REG;
  wire [10:0]  _f1_mask_T = 11'hFF << s1_vpc[2:1];
  wire [7:0]   _GEN_37 = _f1_mask_T[7:0] & ((&(s1_vpc[5:3])) ? 8'hF : 8'hFF);
  wire         f1_redirects_0 = s1_valid & _GEN_37[0] & _bpd_io_resp_f1_preds_0_predicted_pc_valid & (_bpd_io_resp_f1_preds_0_is_jal | _bpd_io_resp_f1_preds_0_is_br & _bpd_io_resp_f1_preds_0_taken);
  wire         f1_redirects_1 = s1_valid & _GEN_37[1] & _bpd_io_resp_f1_preds_1_predicted_pc_valid & (_bpd_io_resp_f1_preds_1_is_jal | _bpd_io_resp_f1_preds_1_is_br & _bpd_io_resp_f1_preds_1_taken);
  wire         f1_redirects_2 = s1_valid & _GEN_37[2] & _bpd_io_resp_f1_preds_2_predicted_pc_valid & (_bpd_io_resp_f1_preds_2_is_jal | _bpd_io_resp_f1_preds_2_is_br & _bpd_io_resp_f1_preds_2_taken);
  wire         f1_redirects_3 = s1_valid & _GEN_37[3] & _bpd_io_resp_f1_preds_3_predicted_pc_valid & (_bpd_io_resp_f1_preds_3_is_jal | _bpd_io_resp_f1_preds_3_is_br & _bpd_io_resp_f1_preds_3_taken);
  wire         f1_redirects_4 = s1_valid & _GEN_37[4] & _bpd_io_resp_f1_preds_4_predicted_pc_valid & (_bpd_io_resp_f1_preds_4_is_jal | _bpd_io_resp_f1_preds_4_is_br & _bpd_io_resp_f1_preds_4_taken);
  wire         f1_redirects_5 = s1_valid & _GEN_37[5] & _bpd_io_resp_f1_preds_5_predicted_pc_valid & (_bpd_io_resp_f1_preds_5_is_jal | _bpd_io_resp_f1_preds_5_is_br & _bpd_io_resp_f1_preds_5_taken);
  wire         f1_redirects_6 = s1_valid & _GEN_37[6] & _bpd_io_resp_f1_preds_6_predicted_pc_valid & (_bpd_io_resp_f1_preds_6_is_jal | _bpd_io_resp_f1_preds_6_is_br & _bpd_io_resp_f1_preds_6_taken);
  wire [2:0]   f1_redirect_idx = f1_redirects_0 ? 3'h0 : f1_redirects_1 ? 3'h1 : f1_redirects_2 ? 3'h2 : f1_redirects_3 ? 3'h3 : f1_redirects_4 ? 3'h4 : f1_redirects_5 ? 3'h5 : {2'h3, ~f1_redirects_6};
  wire         f1_do_redirect = f1_redirects_0 | f1_redirects_1 | f1_redirects_2 | f1_redirects_3 | f1_redirects_4 | f1_redirects_5 | f1_redirects_6 | s1_valid & _GEN_37[7] & _bpd_io_resp_f1_preds_7_predicted_pc_valid & (_bpd_io_resp_f1_preds_7_is_jal | _bpd_io_resp_f1_preds_7_is_br & _bpd_io_resp_f1_preds_7_taken);
  always @(*) begin
    casez (f1_redirect_idx)
      3'b000:
        casez_tmp_4 = _bpd_io_resp_f1_preds_0_predicted_pc_bits;
      3'b001:
        casez_tmp_4 = _bpd_io_resp_f1_preds_1_predicted_pc_bits;
      3'b010:
        casez_tmp_4 = _bpd_io_resp_f1_preds_2_predicted_pc_bits;
      3'b011:
        casez_tmp_4 = _bpd_io_resp_f1_preds_3_predicted_pc_bits;
      3'b100:
        casez_tmp_4 = _bpd_io_resp_f1_preds_4_predicted_pc_bits;
      3'b101:
        casez_tmp_4 = _bpd_io_resp_f1_preds_5_predicted_pc_bits;
      3'b110:
        casez_tmp_4 = _bpd_io_resp_f1_preds_6_predicted_pc_bits;
      default:
        casez_tmp_4 = _bpd_io_resp_f1_preds_7_predicted_pc_bits;
    endcase
  end // always @(*)
  wire [39:0]  _f1_predicted_target_T_21 = {s1_vpc[39:3], 3'h0} + {35'h0, (&(s1_vpc[5:3])) ? 5'h8 : 5'h10};
  always @(*) begin
    casez (f1_redirect_idx)
      3'b000:
        casez_tmp_5 = _bpd_io_resp_f1_preds_0_taken;
      3'b001:
        casez_tmp_5 = _bpd_io_resp_f1_preds_1_taken;
      3'b010:
        casez_tmp_5 = _bpd_io_resp_f1_preds_2_taken;
      3'b011:
        casez_tmp_5 = _bpd_io_resp_f1_preds_3_taken;
      3'b100:
        casez_tmp_5 = _bpd_io_resp_f1_preds_4_taken;
      3'b101:
        casez_tmp_5 = _bpd_io_resp_f1_preds_5_taken;
      3'b110:
        casez_tmp_5 = _bpd_io_resp_f1_preds_6_taken;
      default:
        casez_tmp_5 = _bpd_io_resp_f1_preds_7_taken;
    endcase
  end // always @(*)
  wire         _f1_predicted_ghist_T_10 = casez_tmp_5 & f1_do_redirect;
  wire [7:0]   f1_predicted_ghist_cfi_idx_oh = 8'h1 << f1_redirect_idx;
  wire [6:0]   _GEN_38 = f1_predicted_ghist_cfi_idx_oh[6:0] | f1_predicted_ghist_cfi_idx_oh[7:1];
  wire [5:0]   _GEN_39 = _GEN_38[5:0] | f1_predicted_ghist_cfi_idx_oh[7:2];
  wire [4:0]   _GEN_40 = _GEN_39[4:0] | f1_predicted_ghist_cfi_idx_oh[7:3];
  wire [3:0]   _GEN_41 = _GEN_40[3:0] | f1_predicted_ghist_cfi_idx_oh[7:4];
  wire [2:0]   _GEN_42 = _GEN_41[2:0] | f1_predicted_ghist_cfi_idx_oh[7:5];
  wire [1:0]   _GEN_43 = _GEN_42[1:0] | f1_predicted_ghist_cfi_idx_oh[7:6];
  always @(*) begin
    casez (f1_redirect_idx)
      3'b000:
        casez_tmp_6 = _bpd_io_resp_f1_preds_0_is_br;
      3'b001:
        casez_tmp_6 = _bpd_io_resp_f1_preds_1_is_br;
      3'b010:
        casez_tmp_6 = _bpd_io_resp_f1_preds_2_is_br;
      3'b011:
        casez_tmp_6 = _bpd_io_resp_f1_preds_3_is_br;
      3'b100:
        casez_tmp_6 = _bpd_io_resp_f1_preds_4_is_br;
      3'b101:
        casez_tmp_6 = _bpd_io_resp_f1_preds_5_is_br;
      3'b110:
        casez_tmp_6 = _bpd_io_resp_f1_preds_6_is_br;
      default:
        casez_tmp_6 = _bpd_io_resp_f1_preds_7_is_br;
    endcase
  end // always @(*)
  wire [7:0]   _GEN_44 = {_bpd_io_resp_f1_preds_7_is_br & _bpd_io_resp_f1_preds_7_predicted_pc_valid, _bpd_io_resp_f1_preds_6_is_br & _bpd_io_resp_f1_preds_6_predicted_pc_valid, _bpd_io_resp_f1_preds_5_is_br & _bpd_io_resp_f1_preds_5_predicted_pc_valid, _bpd_io_resp_f1_preds_4_is_br & _bpd_io_resp_f1_preds_4_predicted_pc_valid, _bpd_io_resp_f1_preds_3_is_br & _bpd_io_resp_f1_preds_3_predicted_pc_valid, _bpd_io_resp_f1_preds_2_is_br & _bpd_io_resp_f1_preds_2_predicted_pc_valid, _bpd_io_resp_f1_preds_1_is_br & _bpd_io_resp_f1_preds_1_predicted_pc_valid, _bpd_io_resp_f1_preds_0_is_br & _bpd_io_resp_f1_preds_0_predicted_pc_valid} & _GEN_37 & (f1_do_redirect ? {&f1_redirect_idx, _GEN_38[6], _GEN_39[5], _GEN_40[4], _GEN_41[3], _GEN_42[2], _GEN_43[1], _GEN_43[0] | (&f1_redirect_idx)} & ~(casez_tmp_6 & _f1_predicted_ghist_T_10 ? f1_predicted_ghist_cfi_idx_oh : 8'h0) : 8'hFF);
  wire         _f1_predicted_ghist_new_history_new_saw_branch_taken_T_1 = f1_do_redirect & _f1_predicted_ghist_T_10;
  wire         f1_predicted_ghist_cfi_in_bank_0 = _f1_predicted_ghist_new_history_new_saw_branch_taken_T_1 & ~(f1_redirect_idx[2]);
  wire         f1_predicted_ghist_ignore_second_bank = f1_predicted_ghist_cfi_in_bank_0 | (&(s1_vpc[5:3]));
  wire         f1_predicted_ghist_first_bank_saw_not_taken = (|(_GEN_44[3:0])) | s1_ghist_current_saw_branch_not_taken;
  wire [63:0]  _GEN_45 = {s1_ghist_old_history[62:0], 1'h0};
  wire [63:0]  _GEN_46 = {s1_ghist_old_history[62:0], 1'h1};
  wire [62:0]  _GEN_47 = {s1_ghist_old_history[61:0], 1'h0};
  wire [62:0]  _GEN_48 = {s1_ghist_old_history[61:0], 1'h1};
  wire [63:0]  _GEN_24_0 = f1_predicted_ghist_ignore_second_bank ? (s1_ghist_new_saw_branch_taken ? _GEN_46 : s1_ghist_new_saw_branch_not_taken ? _GEN_45 : s1_ghist_old_history) : casez_tmp_6 & f1_predicted_ghist_cfi_in_bank_0 ? {s1_ghist_new_saw_branch_taken ? _GEN_48 : s1_ghist_new_saw_branch_not_taken ? _GEN_47 : s1_ghist_old_history[62:0], 1'h1} : f1_predicted_ghist_first_bank_saw_not_taken ? {s1_ghist_new_saw_branch_taken ? _GEN_48 : s1_ghist_new_saw_branch_not_taken ? _GEN_47 : s1_ghist_old_history[62:0], 1'h0} : s1_ghist_new_saw_branch_taken ? _GEN_46 : s1_ghist_new_saw_branch_not_taken ? _GEN_45 : s1_ghist_old_history;
  wire         _GEN_49 = s1_valid & ~s1_tlb_miss;
  wire         _GEN_32_0 = _GEN_49 & (f1_predicted_ghist_ignore_second_bank ? f1_predicted_ghist_first_bank_saw_not_taken : (|(_GEN_44[7:4])));
  wire         _GEN_33_0 = _GEN_49 & (f1_predicted_ghist_ignore_second_bank ? casez_tmp_6 & f1_predicted_ghist_cfi_in_bank_0 : _f1_predicted_ghist_new_history_new_saw_branch_taken_T_1 & casez_tmp_6 & ~f1_predicted_ghist_cfi_in_bank_0);
  reg  [4:0]   s2_ghist_ras_idx;
  reg  [31:0]  s2_ppc;
  reg          s2_tlb_resp_pf_inst;
  reg          s2_tlb_resp_ae_inst;
  reg          s2_tlb_miss;
  reg          s2_is_replay_REG;
  wire         s2_is_replay = s2_is_replay_REG & s2_valid;
  wire         _f3_io_enq_valid_T_2 = s2_tlb_resp_ae_inst | s2_tlb_resp_pf_inst;
  wire         s2_xcpt = s2_valid & _f3_io_enq_valid_T_2 & ~s2_is_replay;
  wire         _GEN_50 = _GEN_20 & _GEN_60;
  wire         f3_clear = io_cpu_sfence_valid | io_cpu_redirect_flush;
  wire         _GEN_51 = reset | f3_clear;
  wire         _f3_io_enq_valid_T_6 = s2_valid & ~(_GEN_36 | _GEN & ~_GEN_35 & _GEN_185) & (_icache_io_resp_valid | _f3_io_enq_valid_T_2 & ~s2_tlb_miss);
  wire [10:0]  _f3_io_enq_bits_mask_T = 11'hFF << s2_vpc[2:1];
  reg  [4:0]   ras_read_idx;
  wire         _GEN_53 = _f3_io_enq_ready & _f3_io_enq_valid_T_6;
  reg          f3_bpd_resp_io_enq_valid_REG;
  wire         _f3_bpd_resp_io_enq_valid_T = _f3_io_deq_valid & f3_bpd_resp_io_enq_valid_REG;
  wire [31:0]  exp_inst0 = _exp_inst0_rvc_exp_io_rvc ? _exp_inst0_rvc_exp_io_out_bits : inst0;
  wire [31:0]  exp_inst1 = _exp_inst1_rvc_exp_io_rvc ? _exp_inst1_rvc_exp_io_out_bits : _f3_io_deq_bits_data[31:0];
  wire         f3_btb_mispredicts_0 = _f3_btb_mispredicts_0_T_1 & _f3_bpd_resp_io_deq_bits_preds_0_predicted_pc_valid & _f3_bpd_resp_io_deq_bits_preds_0_predicted_pc_bits != brsigs_target;
  wire [6:0]   _GEN_54 = {1'h0, (&(_f3_io_deq_bits_pc[5:3])) ? 6'h18 : 6'h20};
  wire [31:0]  exp_inst = _exp_inst_rvc_exp_io_rvc ? _exp_inst_rvc_exp_io_out_bits : _f3_io_deq_bits_data[47:16];
  wire         f3_btb_mispredicts_1 = _f3_btb_mispredicts_1_T & valid_1 & _f3_bpd_resp_io_deq_bits_preds_1_predicted_pc_valid & _f3_bpd_resp_io_deq_bits_preds_1_predicted_pc_bits != _bpd_decoder_io_out_target;
  wire [31:0]  exp_inst_1 = _exp_inst_rvc_exp_1_io_rvc ? _exp_inst_rvc_exp_1_io_out_bits : _f3_io_deq_bits_data[63:32];
  wire         f3_btb_mispredicts_2 = _f3_btb_mispredicts_2_T & ~_valid_T_9 & _f3_bpd_resp_io_deq_bits_preds_2_predicted_pc_valid & _f3_bpd_resp_io_deq_bits_preds_2_predicted_pc_bits != _bpd_decoder_1_io_out_target;
  wire [31:0]  exp_inst_2 = _exp_inst_rvc_exp_2_io_rvc ? _exp_inst_rvc_exp_2_io_out_bits : inst_2;
  wire         f3_btb_mispredicts_3 = _f3_btb_mispredicts_3_T & ~_valid_T_18 & _f3_bpd_resp_io_deq_bits_preds_3_predicted_pc_valid & _f3_bpd_resp_io_deq_bits_preds_3_predicted_pc_bits != _bpd_decoder_2_io_out_target;
  wire [31:0]  exp_inst1_1 = _exp_inst1_rvc_exp_1_io_rvc ? _exp_inst1_rvc_exp_1_io_out_bits : _f3_io_deq_bits_data[95:64];
  wire [31:0]  exp_inst0b = _exp_inst0b_rvc_exp_io_rvc ? _exp_inst0b_rvc_exp_io_out_bits : _f3_io_deq_bits_data[79:48];
  wire         f3_btb_mispredicts_4 = _f3_btb_mispredicts_4_T_1 & _f3_bpd_resp_io_deq_bits_preds_4_predicted_pc_valid & _f3_bpd_resp_io_deq_bits_preds_4_predicted_pc_bits != brsigs_4_target;
  wire [31:0]  exp_inst_3 = _exp_inst_rvc_exp_3_io_rvc ? _exp_inst_rvc_exp_3_io_out_bits : _f3_io_deq_bits_data[111:80];
  wire         f3_btb_mispredicts_5 = _f3_btb_mispredicts_5_T & valid_5 & _f3_bpd_resp_io_deq_bits_preds_5_predicted_pc_valid & _f3_bpd_resp_io_deq_bits_preds_5_predicted_pc_bits != _bpd_decoder_3_io_out_target;
  wire [31:0]  exp_inst_4 = _exp_inst_rvc_exp_4_io_rvc ? _exp_inst_rvc_exp_4_io_out_bits : _f3_io_deq_bits_data[127:96];
  wire         f3_btb_mispredicts_6 = _f3_btb_mispredicts_6_T & ~_valid_T_29 & _f3_bpd_resp_io_deq_bits_preds_6_predicted_pc_valid & _f3_bpd_resp_io_deq_bits_preds_6_predicted_pc_bits != _bpd_decoder_4_io_out_target;
  wire [31:0]  exp_inst_5 = _exp_inst_rvc_exp_5_io_rvc ? _exp_inst_rvc_exp_5_io_out_bits : inst_5;
  wire         f3_btb_mispredicts_7 = _f3_btb_mispredicts_7_T & ~_valid_T_38 & _f3_bpd_resp_io_deq_bits_preds_7_predicted_pc_valid & _f3_bpd_resp_io_deq_bits_preds_7_predicted_pc_bits != _bpd_decoder_5_io_out_target;
  always @(*) begin
    casez (f3_fetch_bundle_cfi_idx_bits)
      3'b000:
        casez_tmp_7 = brsigs_cfi_type;
      3'b001:
        casez_tmp_7 = _bpd_decoder_io_out_cfi_type;
      3'b010:
        casez_tmp_7 = _bpd_decoder_1_io_out_cfi_type;
      3'b011:
        casez_tmp_7 = _bpd_decoder_2_io_out_cfi_type;
      3'b100:
        casez_tmp_7 = f3_cfi_types_4;
      3'b101:
        casez_tmp_7 = _bpd_decoder_3_io_out_cfi_type;
      3'b110:
        casez_tmp_7 = _bpd_decoder_4_io_out_cfi_type;
      default:
        casez_tmp_7 = _bpd_decoder_5_io_out_cfi_type;
    endcase
  end // always @(*)
  always @(*) begin
    casez (f3_fetch_bundle_cfi_idx_bits)
      3'b000:
        casez_tmp_8 = f3_prev_is_half ? _bpd_decoder0_io_out_is_call : _bpd_decoder1_io_out_is_call;
      3'b001:
        casez_tmp_8 = _bpd_decoder_io_out_is_call;
      3'b010:
        casez_tmp_8 = _bpd_decoder_1_io_out_is_call;
      3'b011:
        casez_tmp_8 = _bpd_decoder_2_io_out_is_call;
      3'b100:
        casez_tmp_8 = f3_fetch_bundle_edge_inst_1 ? _bpd_decoder0b_io_out_is_call : _bpd_decoder1_1_io_out_is_call;
      3'b101:
        casez_tmp_8 = _bpd_decoder_3_io_out_is_call;
      3'b110:
        casez_tmp_8 = _bpd_decoder_4_io_out_is_call;
      default:
        casez_tmp_8 = _bpd_decoder_5_io_out_is_call;
    endcase
  end // always @(*)
  always @(*) begin
    casez (f3_fetch_bundle_cfi_idx_bits)
      3'b000:
        casez_tmp_9 = (&(bank_insts__0[1:0])) & ~f3_prev_is_half;
      3'b001:
        casez_tmp_9 = &(_f3_io_deq_bits_data[17:16]);
      3'b010:
        casez_tmp_9 = &(_f3_io_deq_bits_data[33:32]);
      3'b011:
        casez_tmp_9 = &(_f3_io_deq_bits_data[49:48]);
      3'b100:
        casez_tmp_9 = (&(bank_insts_1_0[1:0])) & ~f3_fetch_bundle_edge_inst_1;
      3'b101:
        casez_tmp_9 = &(_f3_io_deq_bits_data[81:80]);
      3'b110:
        casez_tmp_9 = &(_f3_io_deq_bits_data[97:96]);
      default:
        casez_tmp_9 = &(_f3_io_deq_bits_data[113:112]);
    endcase
  end // always @(*)
  wire         _f4_btb_corrections_io_enq_valid_T = _f4_io_enq_ready & _f3_io_deq_valid;
  wire         _f3_predicted_ghist_new_history_ras_idx_T = f3_fetch_bundle_cfi_idx_valid & casez_tmp_8;
  wire [4:0]   _ras_io_write_idx_T = _f3_io_deq_bits_ghist_ras_idx + 5'h1;
  wire         _f3_predicted_ghist_new_history_ras_idx_T_4 = f3_fetch_bundle_cfi_idx_valid & casez_tmp;
  wire [4:0]   _f3_predicted_ghist_new_history_ras_idx_T_5 = _f3_io_deq_bits_ghist_ras_idx - 5'h1;
  wire         _GEN_55 = _GEN & _GEN_18;
  assign _GEN_238 = _GEN_55 ? (_f3_predicted_ghist_new_history_ras_idx_T ? _ras_io_write_idx_T : _f3_predicted_ghist_new_history_ras_idx_T_4 ? _f3_predicted_ghist_new_history_ras_idx_T_5 : _f3_io_deq_bits_ghist_ras_idx) : s2_ghist_ras_idx;
  wire         _GEN_56 = ~_GEN | _GEN_35 | ~_GEN_185;
  wire         f4_delay = (_f4_io_deq_bits_sfbs_0 | _f4_io_deq_bits_sfbs_1 | _f4_io_deq_bits_sfbs_2 | _f4_io_deq_bits_sfbs_3 | _f4_io_deq_bits_sfbs_4 | _f4_io_deq_bits_sfbs_5 | _f4_io_deq_bits_sfbs_6 | _f4_io_deq_bits_sfbs_7) & ~_f4_io_deq_bits_cfi_idx_valid & ~_f4_io_enq_valid_T_1 & ~_f4_io_deq_bits_xcpt_pf_if & ~_f4_io_deq_bits_xcpt_ae_if;
  assign _f4_io_enq_valid_T_1 = _f3_io_deq_valid & ~f3_clear;
  wire         s0_valid = ~io_cpu_sfence_valid & (io_cpu_redirect_flush ? io_cpu_redirect_val : _GEN_56 ? (_GEN_19 ? ~s2_tlb_resp_ae_inst & ~s2_tlb_resp_pf_inst | s2_is_replay | s2_tlb_miss : _GEN_50 ? ~(_f3_io_enq_valid_T_2 & ~s2_is_replay) : _GEN_49 ? ~((s1_is_replay ? s1_tlb_resp_REG_ae_inst : _tlb_io_resp_ae_inst) | (s1_is_replay ? s1_tlb_resp_REG_pf_inst : _tlb_io_resp_pf_inst)) : _GEN_0) : ~(_f3_io_deq_bits_xcpt_pf_inst | _f3_io_deq_bits_xcpt_ae_inst));
  wire [39:0]  _GEN_57 = {1'h0, io_cpu_sfence_bits_addr};
  wire [39:0]  s0_vpc = io_cpu_sfence_valid ? _GEN_57 : io_cpu_redirect_flush ? io_cpu_redirect_pc : _GEN_56 ? (_GEN_19 ? s2_vpc : _GEN_50 ? f2_predicted_target : _GEN_49 ? (f1_do_redirect ? casez_tmp_4 : _f1_predicted_target_T_21) : _GEN_0 ? 40'h10040 : 40'h0) : f3_predicted_target;
  wire         _GEN_58 = io_cpu_sfence_valid | ~io_cpu_redirect_flush;
  wire         _GEN_59 = _GEN_19 | ~(_GEN_20 & s1_valid & s1_vpc == f2_predicted_target & _f2_correct_f1_ghist_T_4);
  wire         _f3_fetch_bundle_shadowable_mask_7_T_4 = _f3_io_deq_bits_pc[5:3] != 3'h7;
  wire         _GEN_61 = ~_GEN | _GEN_18 | ~_GEN_34;
  wire         _GEN_169 = _f4_btb_corrections_io_enq_valid_T ? (_f3_fetch_bundle_shadowable_mask_7_T_4 ? ~(bank_mask_1_2 & (&(_f3_io_deq_bits_data[97:96]))) & (&(_f3_io_deq_bits_data[113:112])) : f3_fetch_bundle_edge_inst_1) : f3_prev_is_half;
  always @(posedge clock) begin
    REG <= reset;
    if (io_cpu_sfence_valid)
      s1_vpc <= _GEN_57;
    else if (io_cpu_redirect_flush)
      s1_vpc <= io_cpu_redirect_pc;
    else if (_GEN_56) begin
      if (_GEN_19)
        s1_vpc <= s2_vpc;
      else if (_GEN_50) begin
        if (f2_do_redirect)
          s1_vpc <= casez_tmp_1;
        else
          s1_vpc <= _f2_predicted_target_T_21;
      end
      else if (_GEN_49) begin
        if (f1_do_redirect)
          s1_vpc <= casez_tmp_4;
        else
          s1_vpc <= _f1_predicted_target_T_21;
      end
      else if (_GEN_0)
        s1_vpc <= 40'h10040;
      else
        s1_vpc <= 40'h0;
    end
    else if (_f3_predicted_target_T_6) begin
      if (casez_tmp)
        s1_vpc <= _ras_io_read_addr;
      else
        s1_vpc <= casez_tmp_0;
    end
    else
      s1_vpc <= _f3_predicted_target_T_24;
    if (_GEN_58) begin
      if (_GEN_56) begin
        if (_GEN_19)
          s1_ghist_old_history <= s2_ghist_old_history;
        else if (_GEN_50)
          s1_ghist_old_history <= _GEN_52;
        else if (_GEN_49)
          s1_ghist_old_history <= _GEN_24_0;
        else
          s1_ghist_old_history <= 64'h0;
      end
      else
        s1_ghist_old_history <= _GEN_180;
      s1_ghist_current_saw_branch_not_taken <= _GEN_56 & _GEN_19 & s2_ghist_current_saw_branch_not_taken;
      if (_GEN_56) begin
        if (_GEN_19) begin
          s1_ghist_new_saw_branch_not_taken <= s2_ghist_new_saw_branch_not_taken;
          s1_ghist_new_saw_branch_taken <= s2_ghist_new_saw_branch_taken;
        end
        else if (_GEN_50) begin
          if (f2_predicted_ghist_ignore_second_bank) begin
            s1_ghist_new_saw_branch_not_taken <= f2_predicted_ghist_first_bank_saw_not_taken;
            s1_ghist_new_saw_branch_taken <= _f2_predicted_ghist_new_history_new_saw_branch_taken_T;
          end
          else begin
            s1_ghist_new_saw_branch_not_taken <= |(_GEN_32[7:4]);
            s1_ghist_new_saw_branch_taken <= _f2_predicted_ghist_new_history_new_saw_branch_taken_T_4;
          end
        end
        else begin
          s1_ghist_new_saw_branch_not_taken <= _GEN_32_0;
          s1_ghist_new_saw_branch_taken <= _GEN_33_0;
        end
        if (_GEN_19 | _GEN_50)
          s1_ghist_ras_idx <= s2_ghist_ras_idx;
        else if (~_GEN_49)
          s1_ghist_ras_idx <= 5'h0;
      end
      else begin
        if (f3_predicted_ghist_ignore_second_bank) begin
          s1_ghist_new_saw_branch_not_taken <= f3_predicted_ghist_first_bank_saw_not_taken;
          s1_ghist_new_saw_branch_taken <= _f3_predicted_ghist_new_history_new_saw_branch_taken_T;
        end
        else begin
          s1_ghist_new_saw_branch_not_taken <= |_f3_predicted_ghist_new_history_new_saw_branch_not_taken_T;
          s1_ghist_new_saw_branch_taken <= _f3_predicted_ghist_new_history_new_saw_branch_taken_T_4;
        end
        if (_f3_predicted_ghist_new_history_ras_idx_T)
          s1_ghist_ras_idx <= _ras_io_write_idx_T;
        else if (_f3_predicted_ghist_new_history_ras_idx_T_4)
          s1_ghist_ras_idx <= _f3_predicted_ghist_new_history_ras_idx_T_5;
        else
          s1_ghist_ras_idx <= _f3_io_deq_bits_ghist_ras_idx;
      end
    end
    else begin
      s1_ghist_old_history <= io_cpu_redirect_ghist_old_history;
      s1_ghist_current_saw_branch_not_taken <= io_cpu_redirect_ghist_current_saw_branch_not_taken;
      s1_ghist_new_saw_branch_not_taken <= io_cpu_redirect_ghist_new_saw_branch_not_taken;
      s1_ghist_new_saw_branch_taken <= io_cpu_redirect_ghist_new_saw_branch_taken;
      s1_ghist_ras_idx <= io_cpu_redirect_ghist_ras_idx;
    end
    s1_is_replay <= ~_GEN_36 & _GEN_56 & _GEN_19 & _s0_is_replay_T;
    s1_is_sfence <= io_cpu_sfence_valid;
    s2_vpc <= s1_vpc;
    if (_f4_btb_corrections_io_enq_valid_T) begin
      if (_f3_fetch_bundle_shadowable_mask_7_T_4)
        f3_prev_half <= _f3_io_deq_bits_data[127:112];
      else
        f3_prev_half <= _f3_io_deq_bits_data[63:48];
    end
    if (_GEN_61) begin
      if (_GEN_59) begin
        s2_ghist_old_history <= s1_ghist_old_history;
        s2_ghist_new_saw_branch_not_taken <= s1_ghist_new_saw_branch_not_taken;
        s2_ghist_new_saw_branch_taken <= s1_ghist_new_saw_branch_taken;
      end
      else begin
        s2_ghist_old_history <= _GEN_52;
        if (f2_predicted_ghist_ignore_second_bank) begin
          s2_ghist_new_saw_branch_not_taken <= f2_predicted_ghist_first_bank_saw_not_taken;
          s2_ghist_new_saw_branch_taken <= _f2_predicted_ghist_new_history_new_saw_branch_taken_T;
        end
        else begin
          s2_ghist_new_saw_branch_not_taken <= |(_GEN_32[7:4]);
          s2_ghist_new_saw_branch_taken <= _f2_predicted_ghist_new_history_new_saw_branch_taken_T_4;
        end
      end
    end
    else begin
      s2_ghist_old_history <= _GEN_180;
      if (f3_predicted_ghist_ignore_second_bank) begin
        s2_ghist_new_saw_branch_not_taken <= f3_predicted_ghist_first_bank_saw_not_taken;
        s2_ghist_new_saw_branch_taken <= _f3_predicted_ghist_new_history_new_saw_branch_taken_T;
      end
      else begin
        s2_ghist_new_saw_branch_not_taken <= |_f3_predicted_ghist_new_history_new_saw_branch_not_taken_T;
        s2_ghist_new_saw_branch_taken <= _f3_predicted_ghist_new_history_new_saw_branch_taken_T_4;
      end
    end
    s2_ghist_current_saw_branch_not_taken <= _GEN_61 & _GEN_59 & s1_ghist_current_saw_branch_not_taken;
    tlb_io_sfence_REG_valid <= io_cpu_sfence_valid;
    tlb_io_sfence_REG_bits_rs1 <= io_cpu_sfence_bits_rs1;
    tlb_io_sfence_REG_bits_rs2 <= io_cpu_sfence_bits_rs2;
    tlb_io_sfence_REG_bits_addr <= io_cpu_sfence_bits_addr;
    s1_tlb_resp_REG_pf_inst <= s2_tlb_resp_pf_inst;
    s1_tlb_resp_REG_ae_inst <= s2_tlb_resp_ae_inst;
    s1_ppc_REG <= s2_ppc;
    if (_GEN_61) begin
      if (_GEN_59)
        s2_ghist_ras_idx <= s1_ghist_ras_idx;
    end
    else if (_f3_predicted_ghist_new_history_ras_idx_T)
      s2_ghist_ras_idx <= _ras_io_write_idx_T;
    else if (_f3_predicted_ghist_new_history_ras_idx_T_4)
      s2_ghist_ras_idx <= _f3_predicted_ghist_new_history_ras_idx_T_5;
    else
      s2_ghist_ras_idx <= _f3_io_deq_bits_ghist_ras_idx;
    if (s1_is_replay) begin
      s2_ppc <= s1_ppc_REG;
      s2_tlb_resp_pf_inst <= s1_tlb_resp_REG_pf_inst;
      s2_tlb_resp_ae_inst <= s1_tlb_resp_REG_ae_inst;
    end
    else begin
      s2_ppc <= _tlb_io_resp_paddr;
      s2_tlb_resp_pf_inst <= _tlb_io_resp_pf_inst;
      s2_tlb_resp_ae_inst <= _tlb_io_resp_ae_inst;
    end
    s2_tlb_miss <= s1_tlb_miss;
    s2_is_replay_REG <= s1_is_replay;
    f3_bpd_resp_io_enq_valid_REG <= _f3_io_enq_ready;
    if (reset) begin
      s1_valid <= 1'h0;
      s2_valid <= 1'h0;
      f3_prev_is_half <= 1'h0;
      ras_read_idx <= 5'h0;
    end
    else begin
      s1_valid <= s0_valid;
      s2_valid <= s1_valid & ~f1_clear;
      f3_prev_is_half <= _GEN_58 & (_GEN ? ~(_f3_fetch_bundle_cfi_idx_valid_T | f3_redirects_2 | f3_redirects_3 | f3_redirects_4 | f3_redirects_5 | f3_redirects_6 | f3_redirects_7 | f3_clear) & _GEN_169 : ~f3_clear & _GEN_169);
      if (_GEN_53) begin
        if (_GEN_55) begin
          if (_f3_predicted_ghist_new_history_ras_idx_T)
            ras_read_idx <= _ras_io_write_idx_T;
          else if (_f3_predicted_ghist_new_history_ras_idx_T_4)
            ras_read_idx <= _f3_predicted_ghist_new_history_ras_idx_T_5;
          else
            ras_read_idx <= _f3_io_deq_bits_ghist_ras_idx;
        end
        else
          ras_read_idx <= s2_ghist_ras_idx;
      end
    end
  end // always @(posedge)
  ICache icache (
    .clock                          (clock),
    .reset                          (reset),
    .auto_master_out_a_ready        (auto_icache_master_out_a_ready),
    .auto_master_out_d_valid        (auto_icache_master_out_d_valid),
    .auto_master_out_d_bits_opcode  (auto_icache_master_out_d_bits_opcode),
    .auto_master_out_d_bits_size    (auto_icache_master_out_d_bits_size),
    .auto_master_out_d_bits_data    (auto_icache_master_out_d_bits_data),
    .io_req_valid                   (s0_valid),
    .io_req_bits_addr               (s0_vpc[38:0]),
    .io_s1_paddr                    (s1_is_replay ? s1_ppc_REG : _tlb_io_resp_paddr),
    .io_s1_kill                     (_tlb_io_resp_miss | f1_clear),
    .io_s2_kill                     (s2_xcpt),
    .io_invalidate                  (io_cpu_flush_icache),
    .auto_master_out_a_valid        (auto_icache_master_out_a_valid),
    .auto_master_out_a_bits_address (auto_icache_master_out_a_bits_address),
    .io_resp_valid                  (_icache_io_resp_valid),
    .io_resp_bits_data              (_icache_io_resp_bits_data)
  );
  BranchPredictor bpd (
    .clock                                         (clock),
    .reset                                         (reset),
    .io_f0_req_valid                               (s0_valid),
    .io_f0_req_bits_pc                             (s0_vpc),
    .io_f0_req_bits_ghist_old_history              (_GEN_58 ? (_GEN_56 ? (_GEN_19 ? s2_ghist_old_history : _GEN_50 ? _GEN_52 : _GEN_49 ? _GEN_24_0 : 64'h0) : _GEN_180) : io_cpu_redirect_ghist_old_history),
    .io_f0_req_bits_ghist_new_saw_branch_not_taken (_GEN_58 ? (_GEN_56 ? (_GEN_19 ? s2_ghist_new_saw_branch_not_taken : _GEN_50 ? f2_predicted_ghist_new_saw_branch_not_taken : _GEN_32_0) : f3_predicted_ghist_new_saw_branch_not_taken) : io_cpu_redirect_ghist_new_saw_branch_not_taken),
    .io_f0_req_bits_ghist_new_saw_branch_taken     (_GEN_58 ? (_GEN_56 ? (_GEN_19 ? s2_ghist_new_saw_branch_taken : _GEN_50 ? f2_predicted_ghist_new_saw_branch_taken : _GEN_33_0) : f3_predicted_ghist_new_saw_branch_taken) : io_cpu_redirect_ghist_new_saw_branch_taken),
    .io_f3_fire                                    (_f3_bpd_resp_io_enq_ready & _f3_bpd_resp_io_enq_valid_T),
    .io_update_valid                               (_bpd_update_arbiter_io_out_valid),
    .io_update_bits_is_mispredict_update           (_bpd_update_arbiter_io_out_bits_is_mispredict_update),
    .io_update_bits_is_repair_update               (_bpd_update_arbiter_io_out_bits_is_repair_update),
    .io_update_bits_btb_mispredicts                (_bpd_update_arbiter_io_out_bits_btb_mispredicts),
    .io_update_bits_pc                             (_bpd_update_arbiter_io_out_bits_pc),
    .io_update_bits_br_mask                        (_bpd_update_arbiter_io_out_bits_br_mask),
    .io_update_bits_cfi_idx_valid                  (_bpd_update_arbiter_io_out_bits_cfi_idx_valid),
    .io_update_bits_cfi_idx_bits                   (_bpd_update_arbiter_io_out_bits_cfi_idx_bits),
    .io_update_bits_cfi_taken                      (_bpd_update_arbiter_io_out_bits_cfi_taken),
    .io_update_bits_cfi_mispredicted               (_bpd_update_arbiter_io_out_bits_cfi_mispredicted),
    .io_update_bits_cfi_is_br                      (_bpd_update_arbiter_io_out_bits_cfi_is_br),
    .io_update_bits_cfi_is_jal                     (_bpd_update_arbiter_io_out_bits_cfi_is_jal),
    .io_update_bits_ghist_old_history              (_bpd_update_arbiter_io_out_bits_ghist_old_history),
    .io_update_bits_ghist_new_saw_branch_not_taken (_bpd_update_arbiter_io_out_bits_ghist_new_saw_branch_not_taken),
    .io_update_bits_ghist_new_saw_branch_taken     (_bpd_update_arbiter_io_out_bits_ghist_new_saw_branch_taken),
    .io_update_bits_target                         (_bpd_update_arbiter_io_out_bits_target),
    .io_update_bits_meta_0                         (_bpd_update_arbiter_io_out_bits_meta_0),
    .io_update_bits_meta_1                         (_bpd_update_arbiter_io_out_bits_meta_1),
    .io_resp_f1_preds_0_taken                      (_bpd_io_resp_f1_preds_0_taken),
    .io_resp_f1_preds_0_is_br                      (_bpd_io_resp_f1_preds_0_is_br),
    .io_resp_f1_preds_0_is_jal                     (_bpd_io_resp_f1_preds_0_is_jal),
    .io_resp_f1_preds_0_predicted_pc_valid         (_bpd_io_resp_f1_preds_0_predicted_pc_valid),
    .io_resp_f1_preds_0_predicted_pc_bits          (_bpd_io_resp_f1_preds_0_predicted_pc_bits),
    .io_resp_f1_preds_1_taken                      (_bpd_io_resp_f1_preds_1_taken),
    .io_resp_f1_preds_1_is_br                      (_bpd_io_resp_f1_preds_1_is_br),
    .io_resp_f1_preds_1_is_jal                     (_bpd_io_resp_f1_preds_1_is_jal),
    .io_resp_f1_preds_1_predicted_pc_valid         (_bpd_io_resp_f1_preds_1_predicted_pc_valid),
    .io_resp_f1_preds_1_predicted_pc_bits          (_bpd_io_resp_f1_preds_1_predicted_pc_bits),
    .io_resp_f1_preds_2_taken                      (_bpd_io_resp_f1_preds_2_taken),
    .io_resp_f1_preds_2_is_br                      (_bpd_io_resp_f1_preds_2_is_br),
    .io_resp_f1_preds_2_is_jal                     (_bpd_io_resp_f1_preds_2_is_jal),
    .io_resp_f1_preds_2_predicted_pc_valid         (_bpd_io_resp_f1_preds_2_predicted_pc_valid),
    .io_resp_f1_preds_2_predicted_pc_bits          (_bpd_io_resp_f1_preds_2_predicted_pc_bits),
    .io_resp_f1_preds_3_taken                      (_bpd_io_resp_f1_preds_3_taken),
    .io_resp_f1_preds_3_is_br                      (_bpd_io_resp_f1_preds_3_is_br),
    .io_resp_f1_preds_3_is_jal                     (_bpd_io_resp_f1_preds_3_is_jal),
    .io_resp_f1_preds_3_predicted_pc_valid         (_bpd_io_resp_f1_preds_3_predicted_pc_valid),
    .io_resp_f1_preds_3_predicted_pc_bits          (_bpd_io_resp_f1_preds_3_predicted_pc_bits),
    .io_resp_f1_preds_4_taken                      (_bpd_io_resp_f1_preds_4_taken),
    .io_resp_f1_preds_4_is_br                      (_bpd_io_resp_f1_preds_4_is_br),
    .io_resp_f1_preds_4_is_jal                     (_bpd_io_resp_f1_preds_4_is_jal),
    .io_resp_f1_preds_4_predicted_pc_valid         (_bpd_io_resp_f1_preds_4_predicted_pc_valid),
    .io_resp_f1_preds_4_predicted_pc_bits          (_bpd_io_resp_f1_preds_4_predicted_pc_bits),
    .io_resp_f1_preds_5_taken                      (_bpd_io_resp_f1_preds_5_taken),
    .io_resp_f1_preds_5_is_br                      (_bpd_io_resp_f1_preds_5_is_br),
    .io_resp_f1_preds_5_is_jal                     (_bpd_io_resp_f1_preds_5_is_jal),
    .io_resp_f1_preds_5_predicted_pc_valid         (_bpd_io_resp_f1_preds_5_predicted_pc_valid),
    .io_resp_f1_preds_5_predicted_pc_bits          (_bpd_io_resp_f1_preds_5_predicted_pc_bits),
    .io_resp_f1_preds_6_taken                      (_bpd_io_resp_f1_preds_6_taken),
    .io_resp_f1_preds_6_is_br                      (_bpd_io_resp_f1_preds_6_is_br),
    .io_resp_f1_preds_6_is_jal                     (_bpd_io_resp_f1_preds_6_is_jal),
    .io_resp_f1_preds_6_predicted_pc_valid         (_bpd_io_resp_f1_preds_6_predicted_pc_valid),
    .io_resp_f1_preds_6_predicted_pc_bits          (_bpd_io_resp_f1_preds_6_predicted_pc_bits),
    .io_resp_f1_preds_7_taken                      (_bpd_io_resp_f1_preds_7_taken),
    .io_resp_f1_preds_7_is_br                      (_bpd_io_resp_f1_preds_7_is_br),
    .io_resp_f1_preds_7_is_jal                     (_bpd_io_resp_f1_preds_7_is_jal),
    .io_resp_f1_preds_7_predicted_pc_valid         (_bpd_io_resp_f1_preds_7_predicted_pc_valid),
    .io_resp_f1_preds_7_predicted_pc_bits          (_bpd_io_resp_f1_preds_7_predicted_pc_bits),
    .io_resp_f2_preds_0_taken                      (_bpd_io_resp_f2_preds_0_taken),
    .io_resp_f2_preds_0_is_br                      (_bpd_io_resp_f2_preds_0_is_br),
    .io_resp_f2_preds_0_is_jal                     (_bpd_io_resp_f2_preds_0_is_jal),
    .io_resp_f2_preds_0_predicted_pc_valid         (_bpd_io_resp_f2_preds_0_predicted_pc_valid),
    .io_resp_f2_preds_0_predicted_pc_bits          (_bpd_io_resp_f2_preds_0_predicted_pc_bits),
    .io_resp_f2_preds_1_taken                      (_bpd_io_resp_f2_preds_1_taken),
    .io_resp_f2_preds_1_is_br                      (_bpd_io_resp_f2_preds_1_is_br),
    .io_resp_f2_preds_1_is_jal                     (_bpd_io_resp_f2_preds_1_is_jal),
    .io_resp_f2_preds_1_predicted_pc_valid         (_bpd_io_resp_f2_preds_1_predicted_pc_valid),
    .io_resp_f2_preds_1_predicted_pc_bits          (_bpd_io_resp_f2_preds_1_predicted_pc_bits),
    .io_resp_f2_preds_2_taken                      (_bpd_io_resp_f2_preds_2_taken),
    .io_resp_f2_preds_2_is_br                      (_bpd_io_resp_f2_preds_2_is_br),
    .io_resp_f2_preds_2_is_jal                     (_bpd_io_resp_f2_preds_2_is_jal),
    .io_resp_f2_preds_2_predicted_pc_valid         (_bpd_io_resp_f2_preds_2_predicted_pc_valid),
    .io_resp_f2_preds_2_predicted_pc_bits          (_bpd_io_resp_f2_preds_2_predicted_pc_bits),
    .io_resp_f2_preds_3_taken                      (_bpd_io_resp_f2_preds_3_taken),
    .io_resp_f2_preds_3_is_br                      (_bpd_io_resp_f2_preds_3_is_br),
    .io_resp_f2_preds_3_is_jal                     (_bpd_io_resp_f2_preds_3_is_jal),
    .io_resp_f2_preds_3_predicted_pc_valid         (_bpd_io_resp_f2_preds_3_predicted_pc_valid),
    .io_resp_f2_preds_3_predicted_pc_bits          (_bpd_io_resp_f2_preds_3_predicted_pc_bits),
    .io_resp_f2_preds_4_taken                      (_bpd_io_resp_f2_preds_4_taken),
    .io_resp_f2_preds_4_is_br                      (_bpd_io_resp_f2_preds_4_is_br),
    .io_resp_f2_preds_4_is_jal                     (_bpd_io_resp_f2_preds_4_is_jal),
    .io_resp_f2_preds_4_predicted_pc_valid         (_bpd_io_resp_f2_preds_4_predicted_pc_valid),
    .io_resp_f2_preds_4_predicted_pc_bits          (_bpd_io_resp_f2_preds_4_predicted_pc_bits),
    .io_resp_f2_preds_5_taken                      (_bpd_io_resp_f2_preds_5_taken),
    .io_resp_f2_preds_5_is_br                      (_bpd_io_resp_f2_preds_5_is_br),
    .io_resp_f2_preds_5_is_jal                     (_bpd_io_resp_f2_preds_5_is_jal),
    .io_resp_f2_preds_5_predicted_pc_valid         (_bpd_io_resp_f2_preds_5_predicted_pc_valid),
    .io_resp_f2_preds_5_predicted_pc_bits          (_bpd_io_resp_f2_preds_5_predicted_pc_bits),
    .io_resp_f2_preds_6_taken                      (_bpd_io_resp_f2_preds_6_taken),
    .io_resp_f2_preds_6_is_br                      (_bpd_io_resp_f2_preds_6_is_br),
    .io_resp_f2_preds_6_is_jal                     (_bpd_io_resp_f2_preds_6_is_jal),
    .io_resp_f2_preds_6_predicted_pc_valid         (_bpd_io_resp_f2_preds_6_predicted_pc_valid),
    .io_resp_f2_preds_6_predicted_pc_bits          (_bpd_io_resp_f2_preds_6_predicted_pc_bits),
    .io_resp_f2_preds_7_taken                      (_bpd_io_resp_f2_preds_7_taken),
    .io_resp_f2_preds_7_is_br                      (_bpd_io_resp_f2_preds_7_is_br),
    .io_resp_f2_preds_7_is_jal                     (_bpd_io_resp_f2_preds_7_is_jal),
    .io_resp_f2_preds_7_predicted_pc_valid         (_bpd_io_resp_f2_preds_7_predicted_pc_valid),
    .io_resp_f2_preds_7_predicted_pc_bits          (_bpd_io_resp_f2_preds_7_predicted_pc_bits),
    .io_resp_f3_pc                                 (_bpd_io_resp_f3_pc),
    .io_resp_f3_preds_0_taken                      (_bpd_io_resp_f3_preds_0_taken),
    .io_resp_f3_preds_0_predicted_pc_valid         (_bpd_io_resp_f3_preds_0_predicted_pc_valid),
    .io_resp_f3_preds_0_predicted_pc_bits          (_bpd_io_resp_f3_preds_0_predicted_pc_bits),
    .io_resp_f3_preds_1_taken                      (_bpd_io_resp_f3_preds_1_taken),
    .io_resp_f3_preds_1_predicted_pc_valid         (_bpd_io_resp_f3_preds_1_predicted_pc_valid),
    .io_resp_f3_preds_1_predicted_pc_bits          (_bpd_io_resp_f3_preds_1_predicted_pc_bits),
    .io_resp_f3_preds_2_taken                      (_bpd_io_resp_f3_preds_2_taken),
    .io_resp_f3_preds_2_predicted_pc_valid         (_bpd_io_resp_f3_preds_2_predicted_pc_valid),
    .io_resp_f3_preds_2_predicted_pc_bits          (_bpd_io_resp_f3_preds_2_predicted_pc_bits),
    .io_resp_f3_preds_3_taken                      (_bpd_io_resp_f3_preds_3_taken),
    .io_resp_f3_preds_3_predicted_pc_valid         (_bpd_io_resp_f3_preds_3_predicted_pc_valid),
    .io_resp_f3_preds_3_predicted_pc_bits          (_bpd_io_resp_f3_preds_3_predicted_pc_bits),
    .io_resp_f3_preds_4_taken                      (_bpd_io_resp_f3_preds_4_taken),
    .io_resp_f3_preds_4_predicted_pc_valid         (_bpd_io_resp_f3_preds_4_predicted_pc_valid),
    .io_resp_f3_preds_4_predicted_pc_bits          (_bpd_io_resp_f3_preds_4_predicted_pc_bits),
    .io_resp_f3_preds_5_taken                      (_bpd_io_resp_f3_preds_5_taken),
    .io_resp_f3_preds_5_predicted_pc_valid         (_bpd_io_resp_f3_preds_5_predicted_pc_valid),
    .io_resp_f3_preds_5_predicted_pc_bits          (_bpd_io_resp_f3_preds_5_predicted_pc_bits),
    .io_resp_f3_preds_6_taken                      (_bpd_io_resp_f3_preds_6_taken),
    .io_resp_f3_preds_6_predicted_pc_valid         (_bpd_io_resp_f3_preds_6_predicted_pc_valid),
    .io_resp_f3_preds_6_predicted_pc_bits          (_bpd_io_resp_f3_preds_6_predicted_pc_bits),
    .io_resp_f3_preds_7_taken                      (_bpd_io_resp_f3_preds_7_taken),
    .io_resp_f3_preds_7_predicted_pc_valid         (_bpd_io_resp_f3_preds_7_predicted_pc_valid),
    .io_resp_f3_preds_7_predicted_pc_bits          (_bpd_io_resp_f3_preds_7_predicted_pc_bits),
    .io_resp_f3_meta_0                             (_bpd_io_resp_f3_meta_0),
    .io_resp_f3_meta_1                             (_bpd_io_resp_f3_meta_1)
  );
  BoomRAS ras (
    .clock          (clock),
    .io_read_idx    (_GEN_53 ? _GEN_238 : ras_read_idx),
    .io_write_valid (_ftq_io_ras_update | _GEN & casez_tmp_8 & f3_fetch_bundle_cfi_idx_valid),
    .io_write_idx   (_ftq_io_ras_update ? _ftq_io_ras_update_idx : _ras_io_write_idx_T),
    .io_write_addr  (_ftq_io_ras_update ? _ftq_io_ras_update_pc : _GEN_6 + {36'h0, f3_fetch_bundle_cfi_idx_bits, 1'h0} + {37'h0, casez_tmp_9 ? 3'h4 : 3'h2}),
    .io_read_addr   (_ras_io_read_addr)
  );
  TLB tlb (
    .clock                         (clock),
    .reset                         (reset),
    .io_req_valid                  (s1_valid & ~s1_is_replay & ~f1_clear | s1_is_sfence),
    .io_req_bits_vaddr             (s1_vpc),
    .io_req_bits_prv               (io_ptw_status_prv),
    .io_sfence_valid               (tlb_io_sfence_REG_valid),
    .io_sfence_bits_rs1            (tlb_io_sfence_REG_bits_rs1),
    .io_sfence_bits_rs2            (tlb_io_sfence_REG_bits_rs2),
    .io_sfence_bits_addr           (tlb_io_sfence_REG_bits_addr),
    .io_ptw_req_ready              (io_ptw_req_ready),
    .io_ptw_resp_valid             (io_ptw_resp_valid),
    .io_ptw_resp_bits_ae_ptw       (io_ptw_resp_bits_ae_ptw),
    .io_ptw_resp_bits_ae_final     (io_ptw_resp_bits_ae_final),
    .io_ptw_resp_bits_pf           (io_ptw_resp_bits_pf),
    .io_ptw_resp_bits_gf           (io_ptw_resp_bits_gf),
    .io_ptw_resp_bits_hr           (io_ptw_resp_bits_hr),
    .io_ptw_resp_bits_hw           (io_ptw_resp_bits_hw),
    .io_ptw_resp_bits_hx           (io_ptw_resp_bits_hx),
    .io_ptw_resp_bits_pte_ppn      (io_ptw_resp_bits_pte_ppn),
    .io_ptw_resp_bits_pte_d        (io_ptw_resp_bits_pte_d),
    .io_ptw_resp_bits_pte_a        (io_ptw_resp_bits_pte_a),
    .io_ptw_resp_bits_pte_g        (io_ptw_resp_bits_pte_g),
    .io_ptw_resp_bits_pte_u        (io_ptw_resp_bits_pte_u),
    .io_ptw_resp_bits_pte_x        (io_ptw_resp_bits_pte_x),
    .io_ptw_resp_bits_pte_w        (io_ptw_resp_bits_pte_w),
    .io_ptw_resp_bits_pte_r        (io_ptw_resp_bits_pte_r),
    .io_ptw_resp_bits_pte_v        (io_ptw_resp_bits_pte_v),
    .io_ptw_resp_bits_level        (io_ptw_resp_bits_level),
    .io_ptw_resp_bits_homogeneous  (io_ptw_resp_bits_homogeneous),
    .io_ptw_resp_bits_gpa_is_pte   (io_ptw_resp_bits_gpa_is_pte),
    .io_ptw_ptbr_mode              (io_ptw_ptbr_mode),
    .io_ptw_status_debug           (io_ptw_status_debug),
    .io_ptw_pmp_0_cfg_l            (io_ptw_pmp_0_cfg_l),
    .io_ptw_pmp_0_cfg_a            (io_ptw_pmp_0_cfg_a),
    .io_ptw_pmp_0_cfg_x            (io_ptw_pmp_0_cfg_x),
    .io_ptw_pmp_0_cfg_w            (io_ptw_pmp_0_cfg_w),
    .io_ptw_pmp_0_cfg_r            (io_ptw_pmp_0_cfg_r),
    .io_ptw_pmp_0_addr             (io_ptw_pmp_0_addr),
    .io_ptw_pmp_0_mask             (io_ptw_pmp_0_mask),
    .io_ptw_pmp_1_cfg_l            (io_ptw_pmp_1_cfg_l),
    .io_ptw_pmp_1_cfg_a            (io_ptw_pmp_1_cfg_a),
    .io_ptw_pmp_1_cfg_x            (io_ptw_pmp_1_cfg_x),
    .io_ptw_pmp_1_cfg_w            (io_ptw_pmp_1_cfg_w),
    .io_ptw_pmp_1_cfg_r            (io_ptw_pmp_1_cfg_r),
    .io_ptw_pmp_1_addr             (io_ptw_pmp_1_addr),
    .io_ptw_pmp_1_mask             (io_ptw_pmp_1_mask),
    .io_ptw_pmp_2_cfg_l            (io_ptw_pmp_2_cfg_l),
    .io_ptw_pmp_2_cfg_a            (io_ptw_pmp_2_cfg_a),
    .io_ptw_pmp_2_cfg_x            (io_ptw_pmp_2_cfg_x),
    .io_ptw_pmp_2_cfg_w            (io_ptw_pmp_2_cfg_w),
    .io_ptw_pmp_2_cfg_r            (io_ptw_pmp_2_cfg_r),
    .io_ptw_pmp_2_addr             (io_ptw_pmp_2_addr),
    .io_ptw_pmp_2_mask             (io_ptw_pmp_2_mask),
    .io_ptw_pmp_3_cfg_l            (io_ptw_pmp_3_cfg_l),
    .io_ptw_pmp_3_cfg_a            (io_ptw_pmp_3_cfg_a),
    .io_ptw_pmp_3_cfg_x            (io_ptw_pmp_3_cfg_x),
    .io_ptw_pmp_3_cfg_w            (io_ptw_pmp_3_cfg_w),
    .io_ptw_pmp_3_cfg_r            (io_ptw_pmp_3_cfg_r),
    .io_ptw_pmp_3_addr             (io_ptw_pmp_3_addr),
    .io_ptw_pmp_3_mask             (io_ptw_pmp_3_mask),
    .io_ptw_pmp_4_cfg_l            (io_ptw_pmp_4_cfg_l),
    .io_ptw_pmp_4_cfg_a            (io_ptw_pmp_4_cfg_a),
    .io_ptw_pmp_4_cfg_x            (io_ptw_pmp_4_cfg_x),
    .io_ptw_pmp_4_cfg_w            (io_ptw_pmp_4_cfg_w),
    .io_ptw_pmp_4_cfg_r            (io_ptw_pmp_4_cfg_r),
    .io_ptw_pmp_4_addr             (io_ptw_pmp_4_addr),
    .io_ptw_pmp_4_mask             (io_ptw_pmp_4_mask),
    .io_ptw_pmp_5_cfg_l            (io_ptw_pmp_5_cfg_l),
    .io_ptw_pmp_5_cfg_a            (io_ptw_pmp_5_cfg_a),
    .io_ptw_pmp_5_cfg_x            (io_ptw_pmp_5_cfg_x),
    .io_ptw_pmp_5_cfg_w            (io_ptw_pmp_5_cfg_w),
    .io_ptw_pmp_5_cfg_r            (io_ptw_pmp_5_cfg_r),
    .io_ptw_pmp_5_addr             (io_ptw_pmp_5_addr),
    .io_ptw_pmp_5_mask             (io_ptw_pmp_5_mask),
    .io_ptw_pmp_6_cfg_l            (io_ptw_pmp_6_cfg_l),
    .io_ptw_pmp_6_cfg_a            (io_ptw_pmp_6_cfg_a),
    .io_ptw_pmp_6_cfg_x            (io_ptw_pmp_6_cfg_x),
    .io_ptw_pmp_6_cfg_w            (io_ptw_pmp_6_cfg_w),
    .io_ptw_pmp_6_cfg_r            (io_ptw_pmp_6_cfg_r),
    .io_ptw_pmp_6_addr             (io_ptw_pmp_6_addr),
    .io_ptw_pmp_6_mask             (io_ptw_pmp_6_mask),
    .io_ptw_pmp_7_cfg_l            (io_ptw_pmp_7_cfg_l),
    .io_ptw_pmp_7_cfg_a            (io_ptw_pmp_7_cfg_a),
    .io_ptw_pmp_7_cfg_x            (io_ptw_pmp_7_cfg_x),
    .io_ptw_pmp_7_cfg_w            (io_ptw_pmp_7_cfg_w),
    .io_ptw_pmp_7_cfg_r            (io_ptw_pmp_7_cfg_r),
    .io_ptw_pmp_7_addr             (io_ptw_pmp_7_addr),
    .io_ptw_pmp_7_mask             (io_ptw_pmp_7_mask),
    .io_resp_miss                  (_tlb_io_resp_miss),
    .io_resp_paddr                 (_tlb_io_resp_paddr),
    .io_resp_pf_inst               (_tlb_io_resp_pf_inst),
    .io_resp_ae_inst               (_tlb_io_resp_ae_inst),
    .io_ptw_req_valid              (io_ptw_req_valid),
    .io_ptw_req_bits_bits_addr     (io_ptw_req_bits_bits_addr),
    .io_ptw_req_bits_bits_need_gpa (io_ptw_req_bits_bits_need_gpa),
    .io_ptw_req_bits_bits_vstage1  (io_ptw_req_bits_bits_vstage1),
    .io_ptw_req_bits_bits_stage2   (io_ptw_req_bits_bits_stage2)
  );
  Queue_66 f3 (
    .clock                                          (clock),
    .reset                                          (_GEN_51),
    .io_enq_valid                                   (_f3_io_enq_valid_T_6),
    .io_enq_bits_pc                                 (s2_vpc),
    .io_enq_bits_data                               (s2_xcpt ? 128'h0 : _icache_io_resp_bits_data),
    .io_enq_bits_mask                               (_f3_io_enq_bits_mask_T[7:0] & ((&(s2_vpc[5:3])) ? 8'hF : 8'hFF)),
    .io_enq_bits_xcpt_pf_inst                       (s2_tlb_resp_pf_inst),
    .io_enq_bits_xcpt_ae_inst                       (s2_tlb_resp_ae_inst),
    .io_enq_bits_ghist_old_history                  (_GEN_55 ? _GEN_180 : s2_ghist_old_history),
    .io_enq_bits_ghist_current_saw_branch_not_taken (~_GEN_55 & s2_ghist_current_saw_branch_not_taken),
    .io_enq_bits_ghist_new_saw_branch_not_taken     (_GEN_55 ? f3_predicted_ghist_new_saw_branch_not_taken : s2_ghist_new_saw_branch_not_taken),
    .io_enq_bits_ghist_new_saw_branch_taken         (_GEN_55 ? f3_predicted_ghist_new_saw_branch_taken : s2_ghist_new_saw_branch_taken),
    .io_enq_bits_ghist_ras_idx                      (_GEN_238),
    .io_deq_ready                                   (_f4_io_enq_ready),
    .io_enq_ready                                   (_f3_io_enq_ready),
    .io_deq_valid                                   (_f3_io_deq_valid),
    .io_deq_bits_pc                                 (_f3_io_deq_bits_pc),
    .io_deq_bits_data                               (_f3_io_deq_bits_data),
    .io_deq_bits_mask                               (_f3_io_deq_bits_mask),
    .io_deq_bits_xcpt_pf_inst                       (_f3_io_deq_bits_xcpt_pf_inst),
    .io_deq_bits_xcpt_ae_inst                       (_f3_io_deq_bits_xcpt_ae_inst),
    .io_deq_bits_ghist_old_history                  (_f3_io_deq_bits_ghist_old_history),
    .io_deq_bits_ghist_current_saw_branch_not_taken (_f3_io_deq_bits_ghist_current_saw_branch_not_taken),
    .io_deq_bits_ghist_new_saw_branch_not_taken     (_f3_io_deq_bits_ghist_new_saw_branch_not_taken),
    .io_deq_bits_ghist_new_saw_branch_taken         (_f3_io_deq_bits_ghist_new_saw_branch_taken),
    .io_deq_bits_ghist_ras_idx                      (_f3_io_deq_bits_ghist_ras_idx)
  );
  Queue_67 f3_bpd_resp (
    .clock                                  (clock),
    .reset                                  (_GEN_51),
    .io_enq_valid                           (_f3_bpd_resp_io_enq_valid_T),
    .io_enq_bits_pc                         (_bpd_io_resp_f3_pc),
    .io_enq_bits_preds_0_taken              (_bpd_io_resp_f3_preds_0_taken),
    .io_enq_bits_preds_0_predicted_pc_valid (_bpd_io_resp_f3_preds_0_predicted_pc_valid),
    .io_enq_bits_preds_0_predicted_pc_bits  (_bpd_io_resp_f3_preds_0_predicted_pc_bits),
    .io_enq_bits_preds_1_taken              (_bpd_io_resp_f3_preds_1_taken),
    .io_enq_bits_preds_1_predicted_pc_valid (_bpd_io_resp_f3_preds_1_predicted_pc_valid),
    .io_enq_bits_preds_1_predicted_pc_bits  (_bpd_io_resp_f3_preds_1_predicted_pc_bits),
    .io_enq_bits_preds_2_taken              (_bpd_io_resp_f3_preds_2_taken),
    .io_enq_bits_preds_2_predicted_pc_valid (_bpd_io_resp_f3_preds_2_predicted_pc_valid),
    .io_enq_bits_preds_2_predicted_pc_bits  (_bpd_io_resp_f3_preds_2_predicted_pc_bits),
    .io_enq_bits_preds_3_taken              (_bpd_io_resp_f3_preds_3_taken),
    .io_enq_bits_preds_3_predicted_pc_valid (_bpd_io_resp_f3_preds_3_predicted_pc_valid),
    .io_enq_bits_preds_3_predicted_pc_bits  (_bpd_io_resp_f3_preds_3_predicted_pc_bits),
    .io_enq_bits_preds_4_taken              (_bpd_io_resp_f3_preds_4_taken),
    .io_enq_bits_preds_4_predicted_pc_valid (_bpd_io_resp_f3_preds_4_predicted_pc_valid),
    .io_enq_bits_preds_4_predicted_pc_bits  (_bpd_io_resp_f3_preds_4_predicted_pc_bits),
    .io_enq_bits_preds_5_taken              (_bpd_io_resp_f3_preds_5_taken),
    .io_enq_bits_preds_5_predicted_pc_valid (_bpd_io_resp_f3_preds_5_predicted_pc_valid),
    .io_enq_bits_preds_5_predicted_pc_bits  (_bpd_io_resp_f3_preds_5_predicted_pc_bits),
    .io_enq_bits_preds_6_taken              (_bpd_io_resp_f3_preds_6_taken),
    .io_enq_bits_preds_6_predicted_pc_valid (_bpd_io_resp_f3_preds_6_predicted_pc_valid),
    .io_enq_bits_preds_6_predicted_pc_bits  (_bpd_io_resp_f3_preds_6_predicted_pc_bits),
    .io_enq_bits_preds_7_taken              (_bpd_io_resp_f3_preds_7_taken),
    .io_enq_bits_preds_7_predicted_pc_valid (_bpd_io_resp_f3_preds_7_predicted_pc_valid),
    .io_enq_bits_preds_7_predicted_pc_bits  (_bpd_io_resp_f3_preds_7_predicted_pc_bits),
    .io_enq_bits_meta_0                     (_bpd_io_resp_f3_meta_0),
    .io_enq_bits_meta_1                     (_bpd_io_resp_f3_meta_1),
    .io_deq_ready                           (_f4_io_enq_ready),
    .io_enq_ready                           (_f3_bpd_resp_io_enq_ready),
    .io_deq_bits_pc                         (_f3_bpd_resp_io_deq_bits_pc),
    .io_deq_bits_preds_0_taken              (_f3_bpd_resp_io_deq_bits_preds_0_taken),
    .io_deq_bits_preds_0_predicted_pc_valid (_f3_bpd_resp_io_deq_bits_preds_0_predicted_pc_valid),
    .io_deq_bits_preds_0_predicted_pc_bits  (_f3_bpd_resp_io_deq_bits_preds_0_predicted_pc_bits),
    .io_deq_bits_preds_1_taken              (_f3_bpd_resp_io_deq_bits_preds_1_taken),
    .io_deq_bits_preds_1_predicted_pc_valid (_f3_bpd_resp_io_deq_bits_preds_1_predicted_pc_valid),
    .io_deq_bits_preds_1_predicted_pc_bits  (_f3_bpd_resp_io_deq_bits_preds_1_predicted_pc_bits),
    .io_deq_bits_preds_2_taken              (_f3_bpd_resp_io_deq_bits_preds_2_taken),
    .io_deq_bits_preds_2_predicted_pc_valid (_f3_bpd_resp_io_deq_bits_preds_2_predicted_pc_valid),
    .io_deq_bits_preds_2_predicted_pc_bits  (_f3_bpd_resp_io_deq_bits_preds_2_predicted_pc_bits),
    .io_deq_bits_preds_3_taken              (_f3_bpd_resp_io_deq_bits_preds_3_taken),
    .io_deq_bits_preds_3_predicted_pc_valid (_f3_bpd_resp_io_deq_bits_preds_3_predicted_pc_valid),
    .io_deq_bits_preds_3_predicted_pc_bits  (_f3_bpd_resp_io_deq_bits_preds_3_predicted_pc_bits),
    .io_deq_bits_preds_4_taken              (_f3_bpd_resp_io_deq_bits_preds_4_taken),
    .io_deq_bits_preds_4_predicted_pc_valid (_f3_bpd_resp_io_deq_bits_preds_4_predicted_pc_valid),
    .io_deq_bits_preds_4_predicted_pc_bits  (_f3_bpd_resp_io_deq_bits_preds_4_predicted_pc_bits),
    .io_deq_bits_preds_5_taken              (_f3_bpd_resp_io_deq_bits_preds_5_taken),
    .io_deq_bits_preds_5_predicted_pc_valid (_f3_bpd_resp_io_deq_bits_preds_5_predicted_pc_valid),
    .io_deq_bits_preds_5_predicted_pc_bits  (_f3_bpd_resp_io_deq_bits_preds_5_predicted_pc_bits),
    .io_deq_bits_preds_6_taken              (_f3_bpd_resp_io_deq_bits_preds_6_taken),
    .io_deq_bits_preds_6_predicted_pc_valid (_f3_bpd_resp_io_deq_bits_preds_6_predicted_pc_valid),
    .io_deq_bits_preds_6_predicted_pc_bits  (_f3_bpd_resp_io_deq_bits_preds_6_predicted_pc_bits),
    .io_deq_bits_preds_7_taken              (_f3_bpd_resp_io_deq_bits_preds_7_taken),
    .io_deq_bits_preds_7_predicted_pc_valid (_f3_bpd_resp_io_deq_bits_preds_7_predicted_pc_valid),
    .io_deq_bits_preds_7_predicted_pc_bits  (_f3_bpd_resp_io_deq_bits_preds_7_predicted_pc_bits),
    .io_deq_bits_meta_0                     (_f3_bpd_resp_io_deq_bits_meta_0),
    .io_deq_bits_meta_1                     (_f3_bpd_resp_io_deq_bits_meta_1)
  );
  RVCExpander exp_inst0_rvc_exp (
    .io_in       (inst0),
    .io_out_bits (_exp_inst0_rvc_exp_io_out_bits),
    .io_rvc      (_exp_inst0_rvc_exp_io_rvc)
  );
  RVCExpander exp_inst1_rvc_exp (
    .io_in       (_f3_io_deq_bits_data[31:0]),
    .io_out_bits (_exp_inst1_rvc_exp_io_out_bits),
    .io_rvc      (_exp_inst1_rvc_exp_io_rvc)
  );
  BranchDecode bpd_decoder0 (
    .io_inst                 (exp_inst0),
    .io_pc                   (_GEN_6 - 40'h2),
    .io_out_is_ret           (_bpd_decoder0_io_out_is_ret),
    .io_out_is_call          (_bpd_decoder0_io_out_is_call),
    .io_out_target           (_bpd_decoder0_io_out_target),
    .io_out_cfi_type         (_bpd_decoder0_io_out_cfi_type),
    .io_out_sfb_offset_valid (_bpd_decoder0_io_out_sfb_offset_valid),
    .io_out_sfb_offset_bits  (_bpd_decoder0_io_out_sfb_offset_bits)
  );
  BranchDecode bpd_decoder1 (
    .io_inst                 (exp_inst1),
    .io_pc                   ({_f3_io_deq_bits_pc[39:3], 3'h0}),
    .io_out_is_ret           (_bpd_decoder1_io_out_is_ret),
    .io_out_is_call          (_bpd_decoder1_io_out_is_call),
    .io_out_target           (_bpd_decoder1_io_out_target),
    .io_out_cfi_type         (_bpd_decoder1_io_out_cfi_type),
    .io_out_sfb_offset_valid (_bpd_decoder1_io_out_sfb_offset_valid),
    .io_out_sfb_offset_bits  (_bpd_decoder1_io_out_sfb_offset_bits)
  );
  RVCExpander exp_inst_rvc_exp (
    .io_in       (_f3_io_deq_bits_data[47:16]),
    .io_out_bits (_exp_inst_rvc_exp_io_out_bits),
    .io_rvc      (_exp_inst_rvc_exp_io_rvc)
  );
  BranchDecode bpd_decoder (
    .io_inst                 (exp_inst),
    .io_pc                   (_GEN_6 + 40'h2),
    .io_out_is_ret           (_bpd_decoder_io_out_is_ret),
    .io_out_is_call          (_bpd_decoder_io_out_is_call),
    .io_out_target           (_bpd_decoder_io_out_target),
    .io_out_cfi_type         (_bpd_decoder_io_out_cfi_type),
    .io_out_sfb_offset_valid (_bpd_decoder_io_out_sfb_offset_valid),
    .io_out_sfb_offset_bits  (_bpd_decoder_io_out_sfb_offset_bits)
  );
  RVCExpander exp_inst_rvc_exp_1 (
    .io_in       (_f3_io_deq_bits_data[63:32]),
    .io_out_bits (_exp_inst_rvc_exp_1_io_out_bits),
    .io_rvc      (_exp_inst_rvc_exp_1_io_rvc)
  );
  BranchDecode bpd_decoder_1 (
    .io_inst                 (exp_inst_1),
    .io_pc                   (_GEN_6 + 40'h4),
    .io_out_is_ret           (_bpd_decoder_1_io_out_is_ret),
    .io_out_is_call          (_bpd_decoder_1_io_out_is_call),
    .io_out_target           (_bpd_decoder_1_io_out_target),
    .io_out_cfi_type         (_bpd_decoder_1_io_out_cfi_type),
    .io_out_sfb_offset_valid (_bpd_decoder_1_io_out_sfb_offset_valid),
    .io_out_sfb_offset_bits  (_bpd_decoder_1_io_out_sfb_offset_bits)
  );
  RVCExpander exp_inst_rvc_exp_2 (
    .io_in       (inst_2),
    .io_out_bits (_exp_inst_rvc_exp_2_io_out_bits),
    .io_rvc      (_exp_inst_rvc_exp_2_io_rvc)
  );
  BranchDecode bpd_decoder_2 (
    .io_inst                 (exp_inst_2),
    .io_pc                   (_GEN_6 + 40'h6),
    .io_out_is_ret           (_bpd_decoder_2_io_out_is_ret),
    .io_out_is_call          (_bpd_decoder_2_io_out_is_call),
    .io_out_target           (_bpd_decoder_2_io_out_target),
    .io_out_cfi_type         (_bpd_decoder_2_io_out_cfi_type),
    .io_out_sfb_offset_valid (_bpd_decoder_2_io_out_sfb_offset_valid),
    .io_out_sfb_offset_bits  (_bpd_decoder_2_io_out_sfb_offset_bits)
  );
  RVCExpander exp_inst1_rvc_exp_1 (
    .io_in       (_f3_io_deq_bits_data[95:64]),
    .io_out_bits (_exp_inst1_rvc_exp_1_io_out_bits),
    .io_rvc      (_exp_inst1_rvc_exp_1_io_rvc)
  );
  BranchDecode bpd_decoder1_1 (
    .io_inst                 (exp_inst1_1),
    .io_pc                   (_GEN_6 + 40'h8),
    .io_out_is_ret           (_bpd_decoder1_1_io_out_is_ret),
    .io_out_is_call          (_bpd_decoder1_1_io_out_is_call),
    .io_out_target           (_bpd_decoder1_1_io_out_target),
    .io_out_cfi_type         (_bpd_decoder1_1_io_out_cfi_type),
    .io_out_sfb_offset_valid (_bpd_decoder1_1_io_out_sfb_offset_valid),
    .io_out_sfb_offset_bits  (_bpd_decoder1_1_io_out_sfb_offset_bits)
  );
  RVCExpander exp_inst0b_rvc_exp (
    .io_in       (_f3_io_deq_bits_data[79:48]),
    .io_out_bits (_exp_inst0b_rvc_exp_io_out_bits),
    .io_rvc      (_exp_inst0b_rvc_exp_io_rvc)
  );
  BranchDecode bpd_decoder0b (
    .io_inst                 (exp_inst0b),
    .io_pc                   (_GEN_6 + 40'h6),
    .io_out_is_ret           (_bpd_decoder0b_io_out_is_ret),
    .io_out_is_call          (_bpd_decoder0b_io_out_is_call),
    .io_out_target           (_bpd_decoder0b_io_out_target),
    .io_out_cfi_type         (_bpd_decoder0b_io_out_cfi_type),
    .io_out_sfb_offset_valid (_bpd_decoder0b_io_out_sfb_offset_valid),
    .io_out_sfb_offset_bits  (_bpd_decoder0b_io_out_sfb_offset_bits)
  );
  RVCExpander exp_inst_rvc_exp_3 (
    .io_in       (_f3_io_deq_bits_data[111:80]),
    .io_out_bits (_exp_inst_rvc_exp_3_io_out_bits),
    .io_rvc      (_exp_inst_rvc_exp_3_io_rvc)
  );
  BranchDecode bpd_decoder_3 (
    .io_inst                 (exp_inst_3),
    .io_pc                   (_GEN_6 + 40'hA),
    .io_out_is_ret           (_bpd_decoder_3_io_out_is_ret),
    .io_out_is_call          (_bpd_decoder_3_io_out_is_call),
    .io_out_target           (_bpd_decoder_3_io_out_target),
    .io_out_cfi_type         (_bpd_decoder_3_io_out_cfi_type),
    .io_out_sfb_offset_valid (_bpd_decoder_3_io_out_sfb_offset_valid),
    .io_out_sfb_offset_bits  (_bpd_decoder_3_io_out_sfb_offset_bits)
  );
  RVCExpander exp_inst_rvc_exp_4 (
    .io_in       (_f3_io_deq_bits_data[127:96]),
    .io_out_bits (_exp_inst_rvc_exp_4_io_out_bits),
    .io_rvc      (_exp_inst_rvc_exp_4_io_rvc)
  );
  BranchDecode bpd_decoder_4 (
    .io_inst                 (exp_inst_4),
    .io_pc                   (_GEN_6 + 40'hC),
    .io_out_is_ret           (_bpd_decoder_4_io_out_is_ret),
    .io_out_is_call          (_bpd_decoder_4_io_out_is_call),
    .io_out_target           (_bpd_decoder_4_io_out_target),
    .io_out_cfi_type         (_bpd_decoder_4_io_out_cfi_type),
    .io_out_sfb_offset_valid (_bpd_decoder_4_io_out_sfb_offset_valid),
    .io_out_sfb_offset_bits  (_bpd_decoder_4_io_out_sfb_offset_bits)
  );
  RVCExpander exp_inst_rvc_exp_5 (
    .io_in       (inst_5),
    .io_out_bits (_exp_inst_rvc_exp_5_io_out_bits),
    .io_rvc      (_exp_inst_rvc_exp_5_io_rvc)
  );
  BranchDecode bpd_decoder_5 (
    .io_inst                 (exp_inst_5),
    .io_pc                   (_GEN_6 + 40'hE),
    .io_out_is_ret           (_bpd_decoder_5_io_out_is_ret),
    .io_out_is_call          (_bpd_decoder_5_io_out_is_call),
    .io_out_target           (_bpd_decoder_5_io_out_target),
    .io_out_cfi_type         (_bpd_decoder_5_io_out_cfi_type),
    .io_out_sfb_offset_valid (_bpd_decoder_5_io_out_sfb_offset_valid),
    .io_out_sfb_offset_bits  (_bpd_decoder_5_io_out_sfb_offset_bits)
  );
  Queue_68 f4_btb_corrections (
    .clock                                      (clock),
    .reset                                      (reset),
    .io_enq_valid                               (_f4_btb_corrections_io_enq_valid_T & (f3_btb_mispredicts_0 | f3_btb_mispredicts_1 | f3_btb_mispredicts_2 | f3_btb_mispredicts_3 | f3_btb_mispredicts_4 | f3_btb_mispredicts_5 | f3_btb_mispredicts_6 | f3_btb_mispredicts_7)),
    .io_enq_bits_btb_mispredicts                ({f3_btb_mispredicts_7, f3_btb_mispredicts_6, f3_btb_mispredicts_5, f3_btb_mispredicts_4, f3_btb_mispredicts_3, f3_btb_mispredicts_2, f3_btb_mispredicts_1, f3_btb_mispredicts_0}),
    .io_enq_bits_pc                             (_f3_io_deq_bits_pc),
    .io_enq_bits_ghist_old_history              (_f3_io_deq_bits_ghist_old_history),
    .io_enq_bits_ghist_new_saw_branch_not_taken (_f3_io_deq_bits_ghist_new_saw_branch_not_taken),
    .io_enq_bits_ghist_new_saw_branch_taken     (_f3_io_deq_bits_ghist_new_saw_branch_taken),
    .io_enq_bits_meta_0                         (_f3_bpd_resp_io_deq_bits_meta_0),
    .io_enq_bits_meta_1                         (_f3_bpd_resp_io_deq_bits_meta_1),
    .io_deq_ready                               (_bpd_update_arbiter_io_in_1_ready),
    .io_deq_valid                               (_f4_btb_corrections_io_deq_valid),
    .io_deq_bits_is_mispredict_update           (_f4_btb_corrections_io_deq_bits_is_mispredict_update),
    .io_deq_bits_is_repair_update               (_f4_btb_corrections_io_deq_bits_is_repair_update),
    .io_deq_bits_btb_mispredicts                (_f4_btb_corrections_io_deq_bits_btb_mispredicts),
    .io_deq_bits_pc                             (_f4_btb_corrections_io_deq_bits_pc),
    .io_deq_bits_br_mask                        (_f4_btb_corrections_io_deq_bits_br_mask),
    .io_deq_bits_cfi_idx_valid                  (_f4_btb_corrections_io_deq_bits_cfi_idx_valid),
    .io_deq_bits_cfi_idx_bits                   (_f4_btb_corrections_io_deq_bits_cfi_idx_bits),
    .io_deq_bits_cfi_taken                      (_f4_btb_corrections_io_deq_bits_cfi_taken),
    .io_deq_bits_cfi_mispredicted               (_f4_btb_corrections_io_deq_bits_cfi_mispredicted),
    .io_deq_bits_cfi_is_br                      (_f4_btb_corrections_io_deq_bits_cfi_is_br),
    .io_deq_bits_cfi_is_jal                     (_f4_btb_corrections_io_deq_bits_cfi_is_jal),
    .io_deq_bits_ghist_old_history              (_f4_btb_corrections_io_deq_bits_ghist_old_history),
    .io_deq_bits_ghist_new_saw_branch_not_taken (_f4_btb_corrections_io_deq_bits_ghist_new_saw_branch_not_taken),
    .io_deq_bits_ghist_new_saw_branch_taken     (_f4_btb_corrections_io_deq_bits_ghist_new_saw_branch_taken),
    .io_deq_bits_target                         (_f4_btb_corrections_io_deq_bits_target),
    .io_deq_bits_meta_0                         (_f4_btb_corrections_io_deq_bits_meta_0),
    .io_deq_bits_meta_1                         (_f4_btb_corrections_io_deq_bits_meta_1)
  );
  Queue_69 f4 (
    .clock                                          (clock),
    .reset                                          (_GEN_51),
    .io_enq_valid                                   (_f4_io_enq_valid_T_1),
    .io_enq_bits_pc                                 (_f3_io_deq_bits_pc),
    .io_enq_bits_edge_inst_0                        (f3_prev_is_half),
    .io_enq_bits_edge_inst_1                        (f3_fetch_bundle_edge_inst_1),
    .io_enq_bits_insts_0                            (bank_insts__0),
    .io_enq_bits_insts_1                            (_f3_io_deq_bits_data[47:16]),
    .io_enq_bits_insts_2                            (_f3_io_deq_bits_data[63:32]),
    .io_enq_bits_insts_3                            (inst_2),
    .io_enq_bits_insts_4                            (bank_insts_1_0),
    .io_enq_bits_insts_5                            (_f3_io_deq_bits_data[111:80]),
    .io_enq_bits_insts_6                            (_f3_io_deq_bits_data[127:96]),
    .io_enq_bits_insts_7                            (inst_5),
    .io_enq_bits_exp_insts_0                        (f3_prev_is_half ? exp_inst0 : exp_inst1),
    .io_enq_bits_exp_insts_1                        (exp_inst),
    .io_enq_bits_exp_insts_2                        (exp_inst_1),
    .io_enq_bits_exp_insts_3                        (exp_inst_2),
    .io_enq_bits_exp_insts_4                        (f3_fetch_bundle_edge_inst_1 ? exp_inst0b : exp_inst1_1),
    .io_enq_bits_exp_insts_5                        (exp_inst_3),
    .io_enq_bits_exp_insts_6                        (exp_inst_4),
    .io_enq_bits_exp_insts_7                        (exp_inst_5),
    .io_enq_bits_sfbs_0                             (f3_mask_0 & (f3_prev_is_half ? _bpd_decoder0_io_out_sfb_offset_valid : _bpd_decoder1_io_out_sfb_offset_valid) & {1'h0, f3_prev_is_half ? _bpd_decoder0_io_out_sfb_offset_bits : _bpd_decoder1_io_out_sfb_offset_bits} - {5'h0, f3_prev_is_half, 1'h0} <= _GEN_54),
    .io_enq_bits_sfbs_1                             (f3_mask_1 & _bpd_decoder_io_out_sfb_offset_valid & {1'h0, _bpd_decoder_io_out_sfb_offset_bits} + 7'h2 <= _GEN_54),
    .io_enq_bits_sfbs_2                             (f3_mask_2 & _bpd_decoder_1_io_out_sfb_offset_valid & {1'h0, _bpd_decoder_1_io_out_sfb_offset_bits} + 7'h4 <= _GEN_54),
    .io_enq_bits_sfbs_3                             (f3_mask_3 & _bpd_decoder_2_io_out_sfb_offset_valid & {1'h0, _bpd_decoder_2_io_out_sfb_offset_bits} + 7'h6 <= _GEN_54),
    .io_enq_bits_sfbs_4                             (f3_mask_4 & (f3_fetch_bundle_edge_inst_1 ? _bpd_decoder0b_io_out_sfb_offset_valid : _bpd_decoder1_1_io_out_sfb_offset_valid) & {1'h0, f3_fetch_bundle_edge_inst_1 ? _bpd_decoder0b_io_out_sfb_offset_bits : _bpd_decoder1_1_io_out_sfb_offset_bits} + 7'h8 - {5'h0, f3_fetch_bundle_edge_inst_1, 1'h0} <= _GEN_54),
    .io_enq_bits_sfbs_5                             (f3_mask_5 & _bpd_decoder_3_io_out_sfb_offset_valid & {1'h0, _bpd_decoder_3_io_out_sfb_offset_bits} + 7'hA <= _GEN_54),
    .io_enq_bits_sfbs_6                             (f3_mask_6 & _bpd_decoder_4_io_out_sfb_offset_valid & {1'h0, _bpd_decoder_4_io_out_sfb_offset_bits} + 7'hC <= _GEN_54),
    .io_enq_bits_sfbs_7                             (f3_mask_7 & _bpd_decoder_5_io_out_sfb_offset_valid & {1'h0, _bpd_decoder_5_io_out_sfb_offset_bits} + 7'hE <= _GEN_54),
    .io_enq_bits_cfi_idx_valid                      (f3_fetch_bundle_cfi_idx_valid),
    .io_enq_bits_cfi_idx_bits                       (f3_fetch_bundle_cfi_idx_bits),
    .io_enq_bits_cfi_type                           (casez_tmp_7),
    .io_enq_bits_cfi_is_call                        (casez_tmp_8),
    .io_enq_bits_cfi_is_ret                         (casez_tmp),
    .io_enq_bits_ras_top                            (_ras_io_read_addr),
    .io_enq_bits_mask                               ({f3_mask_7, f3_mask_6, f3_mask_5, f3_mask_4, f3_mask_3, f3_mask_2, f3_mask_1, f3_mask_0}),
    .io_enq_bits_br_mask                            (f3_fetch_bundle_br_mask),
    .io_enq_bits_ghist_old_history                  (_f3_io_deq_bits_ghist_old_history),
    .io_enq_bits_ghist_current_saw_branch_not_taken (_f3_io_deq_bits_ghist_current_saw_branch_not_taken),
    .io_enq_bits_ghist_new_saw_branch_not_taken     (_f3_io_deq_bits_ghist_new_saw_branch_not_taken),
    .io_enq_bits_ghist_new_saw_branch_taken         (_f3_io_deq_bits_ghist_new_saw_branch_taken),
    .io_enq_bits_ghist_ras_idx                      (_f3_io_deq_bits_ghist_ras_idx),
    .io_enq_bits_xcpt_pf_if                         (_f3_io_deq_bits_xcpt_pf_inst),
    .io_enq_bits_xcpt_ae_if                         (_f3_io_deq_bits_xcpt_ae_inst),
    .io_enq_bits_bpd_meta_0                         (_f3_bpd_resp_io_deq_bits_meta_0),
    .io_enq_bits_bpd_meta_1                         (_f3_bpd_resp_io_deq_bits_meta_1),
    .io_deq_ready                                   (_fb_io_enq_ready & _ftq_io_enq_ready & ~f4_delay),
    .io_enq_ready                                   (_f4_io_enq_ready),
    .io_deq_valid                                   (_f4_io_deq_valid),
    .io_deq_bits_pc                                 (_f4_io_deq_bits_pc),
    .io_deq_bits_edge_inst_0                        (_f4_io_deq_bits_edge_inst_0),
    .io_deq_bits_edge_inst_1                        (_f4_io_deq_bits_edge_inst_1),
    .io_deq_bits_insts_0                            (_f4_io_deq_bits_insts_0),
    .io_deq_bits_insts_1                            (_f4_io_deq_bits_insts_1),
    .io_deq_bits_insts_2                            (_f4_io_deq_bits_insts_2),
    .io_deq_bits_insts_3                            (_f4_io_deq_bits_insts_3),
    .io_deq_bits_insts_4                            (_f4_io_deq_bits_insts_4),
    .io_deq_bits_insts_5                            (_f4_io_deq_bits_insts_5),
    .io_deq_bits_insts_6                            (_f4_io_deq_bits_insts_6),
    .io_deq_bits_insts_7                            (_f4_io_deq_bits_insts_7),
    .io_deq_bits_exp_insts_0                        (_f4_io_deq_bits_exp_insts_0),
    .io_deq_bits_exp_insts_1                        (_f4_io_deq_bits_exp_insts_1),
    .io_deq_bits_exp_insts_2                        (_f4_io_deq_bits_exp_insts_2),
    .io_deq_bits_exp_insts_3                        (_f4_io_deq_bits_exp_insts_3),
    .io_deq_bits_exp_insts_4                        (_f4_io_deq_bits_exp_insts_4),
    .io_deq_bits_exp_insts_5                        (_f4_io_deq_bits_exp_insts_5),
    .io_deq_bits_exp_insts_6                        (_f4_io_deq_bits_exp_insts_6),
    .io_deq_bits_exp_insts_7                        (_f4_io_deq_bits_exp_insts_7),
    .io_deq_bits_sfbs_0                             (_f4_io_deq_bits_sfbs_0),
    .io_deq_bits_sfbs_1                             (_f4_io_deq_bits_sfbs_1),
    .io_deq_bits_sfbs_2                             (_f4_io_deq_bits_sfbs_2),
    .io_deq_bits_sfbs_3                             (_f4_io_deq_bits_sfbs_3),
    .io_deq_bits_sfbs_4                             (_f4_io_deq_bits_sfbs_4),
    .io_deq_bits_sfbs_5                             (_f4_io_deq_bits_sfbs_5),
    .io_deq_bits_sfbs_6                             (_f4_io_deq_bits_sfbs_6),
    .io_deq_bits_sfbs_7                             (_f4_io_deq_bits_sfbs_7),
    .io_deq_bits_shadowed_mask_0                    (_f4_io_deq_bits_shadowed_mask_0),
    .io_deq_bits_shadowed_mask_1                    (_f4_io_deq_bits_shadowed_mask_1),
    .io_deq_bits_shadowed_mask_2                    (_f4_io_deq_bits_shadowed_mask_2),
    .io_deq_bits_shadowed_mask_3                    (_f4_io_deq_bits_shadowed_mask_3),
    .io_deq_bits_shadowed_mask_4                    (_f4_io_deq_bits_shadowed_mask_4),
    .io_deq_bits_shadowed_mask_5                    (_f4_io_deq_bits_shadowed_mask_5),
    .io_deq_bits_shadowed_mask_6                    (_f4_io_deq_bits_shadowed_mask_6),
    .io_deq_bits_shadowed_mask_7                    (_f4_io_deq_bits_shadowed_mask_7),
    .io_deq_bits_cfi_idx_valid                      (_f4_io_deq_bits_cfi_idx_valid),
    .io_deq_bits_cfi_idx_bits                       (_f4_io_deq_bits_cfi_idx_bits),
    .io_deq_bits_cfi_type                           (_f4_io_deq_bits_cfi_type),
    .io_deq_bits_cfi_is_call                        (_f4_io_deq_bits_cfi_is_call),
    .io_deq_bits_cfi_is_ret                         (_f4_io_deq_bits_cfi_is_ret),
    .io_deq_bits_ras_top                            (_f4_io_deq_bits_ras_top),
    .io_deq_bits_mask                               (_f4_io_deq_bits_mask),
    .io_deq_bits_br_mask                            (_f4_io_deq_bits_br_mask),
    .io_deq_bits_ghist_old_history                  (_f4_io_deq_bits_ghist_old_history),
    .io_deq_bits_ghist_current_saw_branch_not_taken (_f4_io_deq_bits_ghist_current_saw_branch_not_taken),
    .io_deq_bits_ghist_new_saw_branch_not_taken     (_f4_io_deq_bits_ghist_new_saw_branch_not_taken),
    .io_deq_bits_ghist_new_saw_branch_taken         (_f4_io_deq_bits_ghist_new_saw_branch_taken),
    .io_deq_bits_ghist_ras_idx                      (_f4_io_deq_bits_ghist_ras_idx),
    .io_deq_bits_xcpt_pf_if                         (_f4_io_deq_bits_xcpt_pf_if),
    .io_deq_bits_xcpt_ae_if                         (_f4_io_deq_bits_xcpt_ae_if),
    .io_deq_bits_bp_debug_if_oh_0                   (_f4_io_deq_bits_bp_debug_if_oh_0),
    .io_deq_bits_bp_debug_if_oh_1                   (_f4_io_deq_bits_bp_debug_if_oh_1),
    .io_deq_bits_bp_debug_if_oh_2                   (_f4_io_deq_bits_bp_debug_if_oh_2),
    .io_deq_bits_bp_debug_if_oh_3                   (_f4_io_deq_bits_bp_debug_if_oh_3),
    .io_deq_bits_bp_debug_if_oh_4                   (_f4_io_deq_bits_bp_debug_if_oh_4),
    .io_deq_bits_bp_debug_if_oh_5                   (_f4_io_deq_bits_bp_debug_if_oh_5),
    .io_deq_bits_bp_debug_if_oh_6                   (_f4_io_deq_bits_bp_debug_if_oh_6),
    .io_deq_bits_bp_debug_if_oh_7                   (_f4_io_deq_bits_bp_debug_if_oh_7),
    .io_deq_bits_bp_xcpt_if_oh_0                    (_f4_io_deq_bits_bp_xcpt_if_oh_0),
    .io_deq_bits_bp_xcpt_if_oh_1                    (_f4_io_deq_bits_bp_xcpt_if_oh_1),
    .io_deq_bits_bp_xcpt_if_oh_2                    (_f4_io_deq_bits_bp_xcpt_if_oh_2),
    .io_deq_bits_bp_xcpt_if_oh_3                    (_f4_io_deq_bits_bp_xcpt_if_oh_3),
    .io_deq_bits_bp_xcpt_if_oh_4                    (_f4_io_deq_bits_bp_xcpt_if_oh_4),
    .io_deq_bits_bp_xcpt_if_oh_5                    (_f4_io_deq_bits_bp_xcpt_if_oh_5),
    .io_deq_bits_bp_xcpt_if_oh_6                    (_f4_io_deq_bits_bp_xcpt_if_oh_6),
    .io_deq_bits_bp_xcpt_if_oh_7                    (_f4_io_deq_bits_bp_xcpt_if_oh_7),
    .io_deq_bits_bpd_meta_0                         (_f4_io_deq_bits_bpd_meta_0),
    .io_deq_bits_bpd_meta_1                         (_f4_io_deq_bits_bpd_meta_1)
  );
  FetchBuffer fb (
    .clock                                (clock),
    .reset                                (reset),
    .io_enq_valid                         (_f4_io_deq_valid & _ftq_io_enq_ready & ~f4_delay),
    .io_enq_bits_pc                       (_f4_io_deq_bits_pc),
    .io_enq_bits_edge_inst_0              (_f4_io_deq_bits_edge_inst_0),
    .io_enq_bits_edge_inst_1              (_f4_io_deq_bits_edge_inst_1),
    .io_enq_bits_insts_0                  (_f4_io_deq_bits_insts_0),
    .io_enq_bits_insts_1                  (_f4_io_deq_bits_insts_1),
    .io_enq_bits_insts_2                  (_f4_io_deq_bits_insts_2),
    .io_enq_bits_insts_3                  (_f4_io_deq_bits_insts_3),
    .io_enq_bits_insts_4                  (_f4_io_deq_bits_insts_4),
    .io_enq_bits_insts_5                  (_f4_io_deq_bits_insts_5),
    .io_enq_bits_insts_6                  (_f4_io_deq_bits_insts_6),
    .io_enq_bits_insts_7                  (_f4_io_deq_bits_insts_7),
    .io_enq_bits_exp_insts_0              (_f4_io_deq_bits_exp_insts_0),
    .io_enq_bits_exp_insts_1              (_f4_io_deq_bits_exp_insts_1),
    .io_enq_bits_exp_insts_2              (_f4_io_deq_bits_exp_insts_2),
    .io_enq_bits_exp_insts_3              (_f4_io_deq_bits_exp_insts_3),
    .io_enq_bits_exp_insts_4              (_f4_io_deq_bits_exp_insts_4),
    .io_enq_bits_exp_insts_5              (_f4_io_deq_bits_exp_insts_5),
    .io_enq_bits_exp_insts_6              (_f4_io_deq_bits_exp_insts_6),
    .io_enq_bits_exp_insts_7              (_f4_io_deq_bits_exp_insts_7),
    .io_enq_bits_shadowed_mask_0          (_f4_io_deq_bits_shadowed_mask_0),
    .io_enq_bits_shadowed_mask_1          (_f4_io_deq_bits_shadowed_mask_1),
    .io_enq_bits_shadowed_mask_2          (_f4_io_deq_bits_shadowed_mask_2),
    .io_enq_bits_shadowed_mask_3          (_f4_io_deq_bits_shadowed_mask_3),
    .io_enq_bits_shadowed_mask_4          (_f4_io_deq_bits_shadowed_mask_4),
    .io_enq_bits_shadowed_mask_5          (_f4_io_deq_bits_shadowed_mask_5),
    .io_enq_bits_shadowed_mask_6          (_f4_io_deq_bits_shadowed_mask_6),
    .io_enq_bits_shadowed_mask_7          (_f4_io_deq_bits_shadowed_mask_7),
    .io_enq_bits_cfi_idx_valid            (_f4_io_deq_bits_cfi_idx_valid),
    .io_enq_bits_cfi_idx_bits             (_f4_io_deq_bits_cfi_idx_bits),
    .io_enq_bits_ftq_idx                  (_ftq_io_enq_idx),
    .io_enq_bits_mask                     (_f4_io_deq_bits_mask),
    .io_enq_bits_xcpt_pf_if               (_f4_io_deq_bits_xcpt_pf_if),
    .io_enq_bits_xcpt_ae_if               (_f4_io_deq_bits_xcpt_ae_if),
    .io_enq_bits_bp_debug_if_oh_0         (_f4_io_deq_bits_bp_debug_if_oh_0),
    .io_enq_bits_bp_debug_if_oh_1         (_f4_io_deq_bits_bp_debug_if_oh_1),
    .io_enq_bits_bp_debug_if_oh_2         (_f4_io_deq_bits_bp_debug_if_oh_2),
    .io_enq_bits_bp_debug_if_oh_3         (_f4_io_deq_bits_bp_debug_if_oh_3),
    .io_enq_bits_bp_debug_if_oh_4         (_f4_io_deq_bits_bp_debug_if_oh_4),
    .io_enq_bits_bp_debug_if_oh_5         (_f4_io_deq_bits_bp_debug_if_oh_5),
    .io_enq_bits_bp_debug_if_oh_6         (_f4_io_deq_bits_bp_debug_if_oh_6),
    .io_enq_bits_bp_debug_if_oh_7         (_f4_io_deq_bits_bp_debug_if_oh_7),
    .io_enq_bits_bp_xcpt_if_oh_0          (_f4_io_deq_bits_bp_xcpt_if_oh_0),
    .io_enq_bits_bp_xcpt_if_oh_1          (_f4_io_deq_bits_bp_xcpt_if_oh_1),
    .io_enq_bits_bp_xcpt_if_oh_2          (_f4_io_deq_bits_bp_xcpt_if_oh_2),
    .io_enq_bits_bp_xcpt_if_oh_3          (_f4_io_deq_bits_bp_xcpt_if_oh_3),
    .io_enq_bits_bp_xcpt_if_oh_4          (_f4_io_deq_bits_bp_xcpt_if_oh_4),
    .io_enq_bits_bp_xcpt_if_oh_5          (_f4_io_deq_bits_bp_xcpt_if_oh_5),
    .io_enq_bits_bp_xcpt_if_oh_6          (_f4_io_deq_bits_bp_xcpt_if_oh_6),
    .io_enq_bits_bp_xcpt_if_oh_7          (_f4_io_deq_bits_bp_xcpt_if_oh_7),
    .io_deq_ready                         (io_cpu_fetchpacket_ready),
    .io_clear                             (f3_clear),
    .io_enq_ready                         (_fb_io_enq_ready),
    .io_deq_valid                         (io_cpu_fetchpacket_valid),
    .io_deq_bits_uops_0_valid             (io_cpu_fetchpacket_bits_uops_0_valid),
    .io_deq_bits_uops_0_bits_inst         (io_cpu_fetchpacket_bits_uops_0_bits_inst),
    .io_deq_bits_uops_0_bits_is_rvc       (io_cpu_fetchpacket_bits_uops_0_bits_is_rvc),
    .io_deq_bits_uops_0_bits_ctrl_is_load (io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_load),
    .io_deq_bits_uops_0_bits_ctrl_is_sta  (io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_sta),
    .io_deq_bits_uops_0_bits_is_sfb       (io_cpu_fetchpacket_bits_uops_0_bits_is_sfb),
    .io_deq_bits_uops_0_bits_ftq_idx      (io_cpu_fetchpacket_bits_uops_0_bits_ftq_idx),
    .io_deq_bits_uops_0_bits_edge_inst    (io_cpu_fetchpacket_bits_uops_0_bits_edge_inst),
    .io_deq_bits_uops_0_bits_pc_lob       (io_cpu_fetchpacket_bits_uops_0_bits_pc_lob),
    .io_deq_bits_uops_0_bits_taken        (io_cpu_fetchpacket_bits_uops_0_bits_taken),
    .io_deq_bits_uops_0_bits_xcpt_pf_if   (io_cpu_fetchpacket_bits_uops_0_bits_xcpt_pf_if),
    .io_deq_bits_uops_0_bits_xcpt_ae_if   (io_cpu_fetchpacket_bits_uops_0_bits_xcpt_ae_if),
    .io_deq_bits_uops_0_bits_bp_debug_if  (io_cpu_fetchpacket_bits_uops_0_bits_bp_debug_if),
    .io_deq_bits_uops_0_bits_bp_xcpt_if   (io_cpu_fetchpacket_bits_uops_0_bits_bp_xcpt_if),
    .io_deq_bits_uops_1_valid             (io_cpu_fetchpacket_bits_uops_1_valid),
    .io_deq_bits_uops_1_bits_inst         (io_cpu_fetchpacket_bits_uops_1_bits_inst),
    .io_deq_bits_uops_1_bits_is_rvc       (io_cpu_fetchpacket_bits_uops_1_bits_is_rvc),
    .io_deq_bits_uops_1_bits_ctrl_is_load (io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_load),
    .io_deq_bits_uops_1_bits_ctrl_is_sta  (io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_sta),
    .io_deq_bits_uops_1_bits_is_sfb       (io_cpu_fetchpacket_bits_uops_1_bits_is_sfb),
    .io_deq_bits_uops_1_bits_ftq_idx      (io_cpu_fetchpacket_bits_uops_1_bits_ftq_idx),
    .io_deq_bits_uops_1_bits_edge_inst    (io_cpu_fetchpacket_bits_uops_1_bits_edge_inst),
    .io_deq_bits_uops_1_bits_pc_lob       (io_cpu_fetchpacket_bits_uops_1_bits_pc_lob),
    .io_deq_bits_uops_1_bits_taken        (io_cpu_fetchpacket_bits_uops_1_bits_taken),
    .io_deq_bits_uops_1_bits_xcpt_pf_if   (io_cpu_fetchpacket_bits_uops_1_bits_xcpt_pf_if),
    .io_deq_bits_uops_1_bits_xcpt_ae_if   (io_cpu_fetchpacket_bits_uops_1_bits_xcpt_ae_if),
    .io_deq_bits_uops_1_bits_bp_debug_if  (io_cpu_fetchpacket_bits_uops_1_bits_bp_debug_if),
    .io_deq_bits_uops_1_bits_bp_xcpt_if   (io_cpu_fetchpacket_bits_uops_1_bits_bp_xcpt_if),
    .io_deq_bits_uops_2_valid             (io_cpu_fetchpacket_bits_uops_2_valid),
    .io_deq_bits_uops_2_bits_inst         (io_cpu_fetchpacket_bits_uops_2_bits_inst),
    .io_deq_bits_uops_2_bits_is_rvc       (io_cpu_fetchpacket_bits_uops_2_bits_is_rvc),
    .io_deq_bits_uops_2_bits_ctrl_is_load (io_cpu_fetchpacket_bits_uops_2_bits_ctrl_is_load),
    .io_deq_bits_uops_2_bits_ctrl_is_sta  (io_cpu_fetchpacket_bits_uops_2_bits_ctrl_is_sta),
    .io_deq_bits_uops_2_bits_is_sfb       (io_cpu_fetchpacket_bits_uops_2_bits_is_sfb),
    .io_deq_bits_uops_2_bits_ftq_idx      (io_cpu_fetchpacket_bits_uops_2_bits_ftq_idx),
    .io_deq_bits_uops_2_bits_edge_inst    (io_cpu_fetchpacket_bits_uops_2_bits_edge_inst),
    .io_deq_bits_uops_2_bits_pc_lob       (io_cpu_fetchpacket_bits_uops_2_bits_pc_lob),
    .io_deq_bits_uops_2_bits_taken        (io_cpu_fetchpacket_bits_uops_2_bits_taken),
    .io_deq_bits_uops_2_bits_xcpt_pf_if   (io_cpu_fetchpacket_bits_uops_2_bits_xcpt_pf_if),
    .io_deq_bits_uops_2_bits_xcpt_ae_if   (io_cpu_fetchpacket_bits_uops_2_bits_xcpt_ae_if),
    .io_deq_bits_uops_2_bits_bp_debug_if  (io_cpu_fetchpacket_bits_uops_2_bits_bp_debug_if),
    .io_deq_bits_uops_2_bits_bp_xcpt_if   (io_cpu_fetchpacket_bits_uops_2_bits_bp_xcpt_if),
    .io_deq_bits_uops_3_valid             (io_cpu_fetchpacket_bits_uops_3_valid),
    .io_deq_bits_uops_3_bits_inst         (io_cpu_fetchpacket_bits_uops_3_bits_inst),
    .io_deq_bits_uops_3_bits_is_rvc       (io_cpu_fetchpacket_bits_uops_3_bits_is_rvc),
    .io_deq_bits_uops_3_bits_ctrl_is_load (io_cpu_fetchpacket_bits_uops_3_bits_ctrl_is_load),
    .io_deq_bits_uops_3_bits_ctrl_is_sta  (io_cpu_fetchpacket_bits_uops_3_bits_ctrl_is_sta),
    .io_deq_bits_uops_3_bits_is_sfb       (io_cpu_fetchpacket_bits_uops_3_bits_is_sfb),
    .io_deq_bits_uops_3_bits_ftq_idx      (io_cpu_fetchpacket_bits_uops_3_bits_ftq_idx),
    .io_deq_bits_uops_3_bits_edge_inst    (io_cpu_fetchpacket_bits_uops_3_bits_edge_inst),
    .io_deq_bits_uops_3_bits_pc_lob       (io_cpu_fetchpacket_bits_uops_3_bits_pc_lob),
    .io_deq_bits_uops_3_bits_taken        (io_cpu_fetchpacket_bits_uops_3_bits_taken),
    .io_deq_bits_uops_3_bits_xcpt_pf_if   (io_cpu_fetchpacket_bits_uops_3_bits_xcpt_pf_if),
    .io_deq_bits_uops_3_bits_xcpt_ae_if   (io_cpu_fetchpacket_bits_uops_3_bits_xcpt_ae_if),
    .io_deq_bits_uops_3_bits_bp_debug_if  (io_cpu_fetchpacket_bits_uops_3_bits_bp_debug_if),
    .io_deq_bits_uops_3_bits_bp_xcpt_if   (io_cpu_fetchpacket_bits_uops_3_bits_bp_xcpt_if)
  );
  FetchTargetQueue ftq (
    .clock                                              (clock),
    .reset                                              (reset),
    .io_enq_valid                                       (_f4_io_deq_valid & _fb_io_enq_ready & ~f4_delay),
    .io_enq_bits_pc                                     (_f4_io_deq_bits_pc),
    .io_enq_bits_cfi_idx_valid                          (_f4_io_deq_bits_cfi_idx_valid),
    .io_enq_bits_cfi_idx_bits                           (_f4_io_deq_bits_cfi_idx_bits),
    .io_enq_bits_cfi_type                               (_f4_io_deq_bits_cfi_type),
    .io_enq_bits_cfi_is_call                            (_f4_io_deq_bits_cfi_is_call),
    .io_enq_bits_cfi_is_ret                             (_f4_io_deq_bits_cfi_is_ret),
    .io_enq_bits_ras_top                                (_f4_io_deq_bits_ras_top),
    .io_enq_bits_mask                                   (_f4_io_deq_bits_mask),
    .io_enq_bits_br_mask                                (_f4_io_deq_bits_br_mask),
    .io_enq_bits_ghist_old_history                      (_f4_io_deq_bits_ghist_old_history),
    .io_enq_bits_ghist_current_saw_branch_not_taken     (_f4_io_deq_bits_ghist_current_saw_branch_not_taken),
    .io_enq_bits_ghist_new_saw_branch_not_taken         (_f4_io_deq_bits_ghist_new_saw_branch_not_taken),
    .io_enq_bits_ghist_new_saw_branch_taken             (_f4_io_deq_bits_ghist_new_saw_branch_taken),
    .io_enq_bits_ghist_ras_idx                          (_f4_io_deq_bits_ghist_ras_idx),
    .io_enq_bits_bpd_meta_0                             (_f4_io_deq_bits_bpd_meta_0),
    .io_enq_bits_bpd_meta_1                             (_f4_io_deq_bits_bpd_meta_1),
    .io_deq_valid                                       (io_cpu_commit_valid),
    .io_deq_bits                                        (io_cpu_commit_bits[5:0]),
    .io_get_ftq_pc_0_ftq_idx                            (io_cpu_get_pc_0_ftq_idx),
    .io_get_ftq_pc_1_ftq_idx                            (io_cpu_get_pc_1_ftq_idx),
    .io_redirect_valid                                  (io_cpu_redirect_val),
    .io_redirect_bits                                   (io_cpu_redirect_ftq_idx),
    .io_brupdate_b2_uop_ftq_idx                         (io_cpu_brupdate_b2_uop_ftq_idx),
    .io_brupdate_b2_uop_pc_lob                          (io_cpu_brupdate_b2_uop_pc_lob),
    .io_brupdate_b2_mispredict                          (io_cpu_brupdate_b2_mispredict),
    .io_brupdate_b2_taken                               (io_cpu_brupdate_b2_taken),
    .io_enq_ready                                       (_ftq_io_enq_ready),
    .io_enq_idx                                         (_ftq_io_enq_idx),
    .io_get_ftq_pc_0_entry_cfi_idx_valid                (io_cpu_get_pc_0_entry_cfi_idx_valid),
    .io_get_ftq_pc_0_entry_cfi_idx_bits                 (io_cpu_get_pc_0_entry_cfi_idx_bits),
    .io_get_ftq_pc_0_entry_ras_idx                      (io_cpu_get_pc_0_entry_ras_idx),
    .io_get_ftq_pc_0_entry_start_bank                   (io_cpu_get_pc_0_entry_start_bank),
    .io_get_ftq_pc_0_pc                                 (io_cpu_get_pc_0_pc),
    .io_get_ftq_pc_0_com_pc                             (io_cpu_get_pc_0_com_pc),
    .io_get_ftq_pc_0_next_val                           (io_cpu_get_pc_0_next_val),
    .io_get_ftq_pc_0_next_pc                            (io_cpu_get_pc_0_next_pc),
    .io_get_ftq_pc_1_entry_cfi_idx_bits                 (io_cpu_get_pc_1_entry_cfi_idx_bits),
    .io_get_ftq_pc_1_entry_br_mask                      (io_cpu_get_pc_1_entry_br_mask),
    .io_get_ftq_pc_1_entry_cfi_is_call                  (io_cpu_get_pc_1_entry_cfi_is_call),
    .io_get_ftq_pc_1_entry_cfi_is_ret                   (io_cpu_get_pc_1_entry_cfi_is_ret),
    .io_get_ftq_pc_1_entry_start_bank                   (io_cpu_get_pc_1_entry_start_bank),
    .io_get_ftq_pc_1_ghist_old_history                  (io_cpu_get_pc_1_ghist_old_history),
    .io_get_ftq_pc_1_ghist_current_saw_branch_not_taken (io_cpu_get_pc_1_ghist_current_saw_branch_not_taken),
    .io_get_ftq_pc_1_ghist_new_saw_branch_not_taken     (io_cpu_get_pc_1_ghist_new_saw_branch_not_taken),
    .io_get_ftq_pc_1_ghist_new_saw_branch_taken         (io_cpu_get_pc_1_ghist_new_saw_branch_taken),
    .io_get_ftq_pc_1_ghist_ras_idx                      (io_cpu_get_pc_1_ghist_ras_idx),
    .io_get_ftq_pc_1_pc                                 (io_cpu_get_pc_1_pc),
    .io_bpdupdate_valid                                 (_ftq_io_bpdupdate_valid),
    .io_bpdupdate_bits_is_mispredict_update             (_ftq_io_bpdupdate_bits_is_mispredict_update),
    .io_bpdupdate_bits_is_repair_update                 (_ftq_io_bpdupdate_bits_is_repair_update),
    .io_bpdupdate_bits_pc                               (_ftq_io_bpdupdate_bits_pc),
    .io_bpdupdate_bits_br_mask                          (_ftq_io_bpdupdate_bits_br_mask),
    .io_bpdupdate_bits_cfi_idx_valid                    (_ftq_io_bpdupdate_bits_cfi_idx_valid),
    .io_bpdupdate_bits_cfi_idx_bits                     (_ftq_io_bpdupdate_bits_cfi_idx_bits),
    .io_bpdupdate_bits_cfi_taken                        (_ftq_io_bpdupdate_bits_cfi_taken),
    .io_bpdupdate_bits_cfi_mispredicted                 (_ftq_io_bpdupdate_bits_cfi_mispredicted),
    .io_bpdupdate_bits_cfi_is_br                        (_ftq_io_bpdupdate_bits_cfi_is_br),
    .io_bpdupdate_bits_cfi_is_jal                       (_ftq_io_bpdupdate_bits_cfi_is_jal),
    .io_bpdupdate_bits_ghist_old_history                (_ftq_io_bpdupdate_bits_ghist_old_history),
    .io_bpdupdate_bits_ghist_new_saw_branch_not_taken   (_ftq_io_bpdupdate_bits_ghist_new_saw_branch_not_taken),
    .io_bpdupdate_bits_ghist_new_saw_branch_taken       (_ftq_io_bpdupdate_bits_ghist_new_saw_branch_taken),
    .io_bpdupdate_bits_target                           (_ftq_io_bpdupdate_bits_target),
    .io_bpdupdate_bits_meta_0                           (_ftq_io_bpdupdate_bits_meta_0),
    .io_bpdupdate_bits_meta_1                           (_ftq_io_bpdupdate_bits_meta_1),
    .io_ras_update                                      (_ftq_io_ras_update),
    .io_ras_update_idx                                  (_ftq_io_ras_update_idx),
    .io_ras_update_pc                                   (_ftq_io_ras_update_pc)
  );
  Arbiter_15 bpd_update_arbiter (
    .io_in_0_valid                               (_ftq_io_bpdupdate_valid),
    .io_in_0_bits_is_mispredict_update           (_ftq_io_bpdupdate_bits_is_mispredict_update),
    .io_in_0_bits_is_repair_update               (_ftq_io_bpdupdate_bits_is_repair_update),
    .io_in_0_bits_pc                             (_ftq_io_bpdupdate_bits_pc),
    .io_in_0_bits_br_mask                        (_ftq_io_bpdupdate_bits_br_mask),
    .io_in_0_bits_cfi_idx_valid                  (_ftq_io_bpdupdate_bits_cfi_idx_valid),
    .io_in_0_bits_cfi_idx_bits                   (_ftq_io_bpdupdate_bits_cfi_idx_bits),
    .io_in_0_bits_cfi_taken                      (_ftq_io_bpdupdate_bits_cfi_taken),
    .io_in_0_bits_cfi_mispredicted               (_ftq_io_bpdupdate_bits_cfi_mispredicted),
    .io_in_0_bits_cfi_is_br                      (_ftq_io_bpdupdate_bits_cfi_is_br),
    .io_in_0_bits_cfi_is_jal                     (_ftq_io_bpdupdate_bits_cfi_is_jal),
    .io_in_0_bits_ghist_old_history              (_ftq_io_bpdupdate_bits_ghist_old_history),
    .io_in_0_bits_ghist_new_saw_branch_not_taken (_ftq_io_bpdupdate_bits_ghist_new_saw_branch_not_taken),
    .io_in_0_bits_ghist_new_saw_branch_taken     (_ftq_io_bpdupdate_bits_ghist_new_saw_branch_taken),
    .io_in_0_bits_target                         (_ftq_io_bpdupdate_bits_target),
    .io_in_0_bits_meta_0                         (_ftq_io_bpdupdate_bits_meta_0),
    .io_in_0_bits_meta_1                         (_ftq_io_bpdupdate_bits_meta_1),
    .io_in_1_valid                               (_f4_btb_corrections_io_deq_valid),
    .io_in_1_bits_is_mispredict_update           (_f4_btb_corrections_io_deq_bits_is_mispredict_update),
    .io_in_1_bits_is_repair_update               (_f4_btb_corrections_io_deq_bits_is_repair_update),
    .io_in_1_bits_btb_mispredicts                (_f4_btb_corrections_io_deq_bits_btb_mispredicts),
    .io_in_1_bits_pc                             (_f4_btb_corrections_io_deq_bits_pc),
    .io_in_1_bits_br_mask                        (_f4_btb_corrections_io_deq_bits_br_mask),
    .io_in_1_bits_cfi_idx_valid                  (_f4_btb_corrections_io_deq_bits_cfi_idx_valid),
    .io_in_1_bits_cfi_idx_bits                   (_f4_btb_corrections_io_deq_bits_cfi_idx_bits),
    .io_in_1_bits_cfi_taken                      (_f4_btb_corrections_io_deq_bits_cfi_taken),
    .io_in_1_bits_cfi_mispredicted               (_f4_btb_corrections_io_deq_bits_cfi_mispredicted),
    .io_in_1_bits_cfi_is_br                      (_f4_btb_corrections_io_deq_bits_cfi_is_br),
    .io_in_1_bits_cfi_is_jal                     (_f4_btb_corrections_io_deq_bits_cfi_is_jal),
    .io_in_1_bits_ghist_old_history              (_f4_btb_corrections_io_deq_bits_ghist_old_history),
    .io_in_1_bits_ghist_new_saw_branch_not_taken (_f4_btb_corrections_io_deq_bits_ghist_new_saw_branch_not_taken),
    .io_in_1_bits_ghist_new_saw_branch_taken     (_f4_btb_corrections_io_deq_bits_ghist_new_saw_branch_taken),
    .io_in_1_bits_target                         (_f4_btb_corrections_io_deq_bits_target),
    .io_in_1_bits_meta_0                         (_f4_btb_corrections_io_deq_bits_meta_0),
    .io_in_1_bits_meta_1                         (_f4_btb_corrections_io_deq_bits_meta_1),
    .io_in_1_ready                               (_bpd_update_arbiter_io_in_1_ready),
    .io_out_valid                                (_bpd_update_arbiter_io_out_valid),
    .io_out_bits_is_mispredict_update            (_bpd_update_arbiter_io_out_bits_is_mispredict_update),
    .io_out_bits_is_repair_update                (_bpd_update_arbiter_io_out_bits_is_repair_update),
    .io_out_bits_btb_mispredicts                 (_bpd_update_arbiter_io_out_bits_btb_mispredicts),
    .io_out_bits_pc                              (_bpd_update_arbiter_io_out_bits_pc),
    .io_out_bits_br_mask                         (_bpd_update_arbiter_io_out_bits_br_mask),
    .io_out_bits_cfi_idx_valid                   (_bpd_update_arbiter_io_out_bits_cfi_idx_valid),
    .io_out_bits_cfi_idx_bits                    (_bpd_update_arbiter_io_out_bits_cfi_idx_bits),
    .io_out_bits_cfi_taken                       (_bpd_update_arbiter_io_out_bits_cfi_taken),
    .io_out_bits_cfi_mispredicted                (_bpd_update_arbiter_io_out_bits_cfi_mispredicted),
    .io_out_bits_cfi_is_br                       (_bpd_update_arbiter_io_out_bits_cfi_is_br),
    .io_out_bits_cfi_is_jal                      (_bpd_update_arbiter_io_out_bits_cfi_is_jal),
    .io_out_bits_ghist_old_history               (_bpd_update_arbiter_io_out_bits_ghist_old_history),
    .io_out_bits_ghist_new_saw_branch_not_taken  (_bpd_update_arbiter_io_out_bits_ghist_new_saw_branch_not_taken),
    .io_out_bits_ghist_new_saw_branch_taken      (_bpd_update_arbiter_io_out_bits_ghist_new_saw_branch_taken),
    .io_out_bits_target                          (_bpd_update_arbiter_io_out_bits_target),
    .io_out_bits_meta_0                          (_bpd_update_arbiter_io_out_bits_meta_0),
    .io_out_bits_meta_1                          (_bpd_update_arbiter_io_out_bits_meta_1)
  );
endmodule

