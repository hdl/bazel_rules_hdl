// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module FetchTargetQueue(
  input          clock,
                 reset,
                 io_enq_valid,
  input  [39:0]  io_enq_bits_pc,
  input          io_enq_bits_cfi_idx_valid,
  input  [2:0]   io_enq_bits_cfi_idx_bits,
                 io_enq_bits_cfi_type,
  input          io_enq_bits_cfi_is_call,
                 io_enq_bits_cfi_is_ret,
  input  [39:0]  io_enq_bits_ras_top,
  input  [7:0]   io_enq_bits_mask,
                 io_enq_bits_br_mask,
  input  [63:0]  io_enq_bits_ghist_old_history,
  input          io_enq_bits_ghist_current_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_taken,
  input  [4:0]   io_enq_bits_ghist_ras_idx,
  input  [119:0] io_enq_bits_bpd_meta_0,
                 io_enq_bits_bpd_meta_1,
  input          io_deq_valid,
  input  [5:0]   io_deq_bits,
                 io_get_ftq_pc_0_ftq_idx,
                 io_get_ftq_pc_1_ftq_idx,
  input          io_redirect_valid,
  input  [5:0]   io_redirect_bits,
                 io_brupdate_b2_uop_ftq_idx,
                 io_brupdate_b2_uop_pc_lob,
  input          io_brupdate_b2_mispredict,
                 io_brupdate_b2_taken,
  output         io_enq_ready,
  output [5:0]   io_enq_idx,
  output         io_get_ftq_pc_0_entry_cfi_idx_valid,
  output [2:0]   io_get_ftq_pc_0_entry_cfi_idx_bits,
  output [4:0]   io_get_ftq_pc_0_entry_ras_idx,
  output         io_get_ftq_pc_0_entry_start_bank,
  output [39:0]  io_get_ftq_pc_0_pc,
                 io_get_ftq_pc_0_com_pc,
  output         io_get_ftq_pc_0_next_val,
  output [39:0]  io_get_ftq_pc_0_next_pc,
  output [2:0]   io_get_ftq_pc_1_entry_cfi_idx_bits,
  output [7:0]   io_get_ftq_pc_1_entry_br_mask,
  output         io_get_ftq_pc_1_entry_cfi_is_call,
                 io_get_ftq_pc_1_entry_cfi_is_ret,
                 io_get_ftq_pc_1_entry_start_bank,
  output [63:0]  io_get_ftq_pc_1_ghist_old_history,
  output         io_get_ftq_pc_1_ghist_current_saw_branch_not_taken,
                 io_get_ftq_pc_1_ghist_new_saw_branch_not_taken,
                 io_get_ftq_pc_1_ghist_new_saw_branch_taken,
  output [4:0]   io_get_ftq_pc_1_ghist_ras_idx,
  output [39:0]  io_get_ftq_pc_1_pc,
  output         io_bpdupdate_valid,
                 io_bpdupdate_bits_is_mispredict_update,
                 io_bpdupdate_bits_is_repair_update,
  output [39:0]  io_bpdupdate_bits_pc,
  output [7:0]   io_bpdupdate_bits_br_mask,
  output         io_bpdupdate_bits_cfi_idx_valid,
  output [2:0]   io_bpdupdate_bits_cfi_idx_bits,
  output         io_bpdupdate_bits_cfi_taken,
                 io_bpdupdate_bits_cfi_mispredicted,
                 io_bpdupdate_bits_cfi_is_br,
                 io_bpdupdate_bits_cfi_is_jal,
  output [63:0]  io_bpdupdate_bits_ghist_old_history,
  output         io_bpdupdate_bits_ghist_new_saw_branch_not_taken,
                 io_bpdupdate_bits_ghist_new_saw_branch_taken,
  output [39:0]  io_bpdupdate_bits_target,
  output [119:0] io_bpdupdate_bits_meta_0,
                 io_bpdupdate_bits_meta_1,
  output         io_ras_update,
  output [4:0]   io_ras_update_idx,
  output [39:0]  io_ras_update_pc
);

  reg         io_enq_ready_REG;
  wire [4:0]  _ghist_0_ras_idx_ext_R0_data;
  wire        _ghist_0_new_saw_branch_taken_ext_R0_data;
  wire        _ghist_0_new_saw_branch_not_taken_ext_R0_data;
  wire        _ghist_0_current_saw_branch_not_taken_ext_R0_data;
  wire [63:0] _ghist_0_old_history_ext_R0_data;
  reg  [5:0]  bpd_ptr;
  reg  [5:0]  deq_ptr;
  reg  [5:0]  enq_ptr;
  reg  [39:0] pcs_0;
  reg  [39:0] pcs_1;
  reg  [39:0] pcs_2;
  reg  [39:0] pcs_3;
  reg  [39:0] pcs_4;
  reg  [39:0] pcs_5;
  reg  [39:0] pcs_6;
  reg  [39:0] pcs_7;
  reg  [39:0] pcs_8;
  reg  [39:0] pcs_9;
  reg  [39:0] pcs_10;
  reg  [39:0] pcs_11;
  reg  [39:0] pcs_12;
  reg  [39:0] pcs_13;
  reg  [39:0] pcs_14;
  reg  [39:0] pcs_15;
  reg  [39:0] pcs_16;
  reg  [39:0] pcs_17;
  reg  [39:0] pcs_18;
  reg  [39:0] pcs_19;
  reg  [39:0] pcs_20;
  reg  [39:0] pcs_21;
  reg  [39:0] pcs_22;
  reg  [39:0] pcs_23;
  reg  [39:0] pcs_24;
  reg  [39:0] pcs_25;
  reg  [39:0] pcs_26;
  reg  [39:0] pcs_27;
  reg  [39:0] pcs_28;
  reg  [39:0] pcs_29;
  reg  [39:0] pcs_30;
  reg  [39:0] pcs_31;
  reg  [39:0] pcs_32;
  reg  [39:0] pcs_33;
  reg  [39:0] pcs_34;
  reg  [39:0] pcs_35;
  reg  [39:0] pcs_36;
  reg  [39:0] pcs_37;
  reg  [39:0] pcs_38;
  reg  [39:0] pcs_39;
  reg         ram_0_cfi_idx_valid;
  reg  [2:0]  ram_0_cfi_idx_bits;
  reg         ram_0_cfi_taken;
  reg         ram_0_cfi_mispredicted;
  reg  [2:0]  ram_0_cfi_type;
  reg  [7:0]  ram_0_br_mask;
  reg         ram_0_cfi_is_call;
  reg         ram_0_cfi_is_ret;
  reg  [39:0] ram_0_ras_top;
  reg  [4:0]  ram_0_ras_idx;
  reg         ram_0_start_bank;
  reg         ram_1_cfi_idx_valid;
  reg  [2:0]  ram_1_cfi_idx_bits;
  reg         ram_1_cfi_taken;
  reg         ram_1_cfi_mispredicted;
  reg  [2:0]  ram_1_cfi_type;
  reg  [7:0]  ram_1_br_mask;
  reg         ram_1_cfi_is_call;
  reg         ram_1_cfi_is_ret;
  reg  [39:0] ram_1_ras_top;
  reg  [4:0]  ram_1_ras_idx;
  reg         ram_1_start_bank;
  reg         ram_2_cfi_idx_valid;
  reg  [2:0]  ram_2_cfi_idx_bits;
  reg         ram_2_cfi_taken;
  reg         ram_2_cfi_mispredicted;
  reg  [2:0]  ram_2_cfi_type;
  reg  [7:0]  ram_2_br_mask;
  reg         ram_2_cfi_is_call;
  reg         ram_2_cfi_is_ret;
  reg  [39:0] ram_2_ras_top;
  reg  [4:0]  ram_2_ras_idx;
  reg         ram_2_start_bank;
  reg         ram_3_cfi_idx_valid;
  reg  [2:0]  ram_3_cfi_idx_bits;
  reg         ram_3_cfi_taken;
  reg         ram_3_cfi_mispredicted;
  reg  [2:0]  ram_3_cfi_type;
  reg  [7:0]  ram_3_br_mask;
  reg         ram_3_cfi_is_call;
  reg         ram_3_cfi_is_ret;
  reg  [39:0] ram_3_ras_top;
  reg  [4:0]  ram_3_ras_idx;
  reg         ram_3_start_bank;
  reg         ram_4_cfi_idx_valid;
  reg  [2:0]  ram_4_cfi_idx_bits;
  reg         ram_4_cfi_taken;
  reg         ram_4_cfi_mispredicted;
  reg  [2:0]  ram_4_cfi_type;
  reg  [7:0]  ram_4_br_mask;
  reg         ram_4_cfi_is_call;
  reg         ram_4_cfi_is_ret;
  reg  [39:0] ram_4_ras_top;
  reg  [4:0]  ram_4_ras_idx;
  reg         ram_4_start_bank;
  reg         ram_5_cfi_idx_valid;
  reg  [2:0]  ram_5_cfi_idx_bits;
  reg         ram_5_cfi_taken;
  reg         ram_5_cfi_mispredicted;
  reg  [2:0]  ram_5_cfi_type;
  reg  [7:0]  ram_5_br_mask;
  reg         ram_5_cfi_is_call;
  reg         ram_5_cfi_is_ret;
  reg  [39:0] ram_5_ras_top;
  reg  [4:0]  ram_5_ras_idx;
  reg         ram_5_start_bank;
  reg         ram_6_cfi_idx_valid;
  reg  [2:0]  ram_6_cfi_idx_bits;
  reg         ram_6_cfi_taken;
  reg         ram_6_cfi_mispredicted;
  reg  [2:0]  ram_6_cfi_type;
  reg  [7:0]  ram_6_br_mask;
  reg         ram_6_cfi_is_call;
  reg         ram_6_cfi_is_ret;
  reg  [39:0] ram_6_ras_top;
  reg  [4:0]  ram_6_ras_idx;
  reg         ram_6_start_bank;
  reg         ram_7_cfi_idx_valid;
  reg  [2:0]  ram_7_cfi_idx_bits;
  reg         ram_7_cfi_taken;
  reg         ram_7_cfi_mispredicted;
  reg  [2:0]  ram_7_cfi_type;
  reg  [7:0]  ram_7_br_mask;
  reg         ram_7_cfi_is_call;
  reg         ram_7_cfi_is_ret;
  reg  [39:0] ram_7_ras_top;
  reg  [4:0]  ram_7_ras_idx;
  reg         ram_7_start_bank;
  reg         ram_8_cfi_idx_valid;
  reg  [2:0]  ram_8_cfi_idx_bits;
  reg         ram_8_cfi_taken;
  reg         ram_8_cfi_mispredicted;
  reg  [2:0]  ram_8_cfi_type;
  reg  [7:0]  ram_8_br_mask;
  reg         ram_8_cfi_is_call;
  reg         ram_8_cfi_is_ret;
  reg  [39:0] ram_8_ras_top;
  reg  [4:0]  ram_8_ras_idx;
  reg         ram_8_start_bank;
  reg         ram_9_cfi_idx_valid;
  reg  [2:0]  ram_9_cfi_idx_bits;
  reg         ram_9_cfi_taken;
  reg         ram_9_cfi_mispredicted;
  reg  [2:0]  ram_9_cfi_type;
  reg  [7:0]  ram_9_br_mask;
  reg         ram_9_cfi_is_call;
  reg         ram_9_cfi_is_ret;
  reg  [39:0] ram_9_ras_top;
  reg  [4:0]  ram_9_ras_idx;
  reg         ram_9_start_bank;
  reg         ram_10_cfi_idx_valid;
  reg  [2:0]  ram_10_cfi_idx_bits;
  reg         ram_10_cfi_taken;
  reg         ram_10_cfi_mispredicted;
  reg  [2:0]  ram_10_cfi_type;
  reg  [7:0]  ram_10_br_mask;
  reg         ram_10_cfi_is_call;
  reg         ram_10_cfi_is_ret;
  reg  [39:0] ram_10_ras_top;
  reg  [4:0]  ram_10_ras_idx;
  reg         ram_10_start_bank;
  reg         ram_11_cfi_idx_valid;
  reg  [2:0]  ram_11_cfi_idx_bits;
  reg         ram_11_cfi_taken;
  reg         ram_11_cfi_mispredicted;
  reg  [2:0]  ram_11_cfi_type;
  reg  [7:0]  ram_11_br_mask;
  reg         ram_11_cfi_is_call;
  reg         ram_11_cfi_is_ret;
  reg  [39:0] ram_11_ras_top;
  reg  [4:0]  ram_11_ras_idx;
  reg         ram_11_start_bank;
  reg         ram_12_cfi_idx_valid;
  reg  [2:0]  ram_12_cfi_idx_bits;
  reg         ram_12_cfi_taken;
  reg         ram_12_cfi_mispredicted;
  reg  [2:0]  ram_12_cfi_type;
  reg  [7:0]  ram_12_br_mask;
  reg         ram_12_cfi_is_call;
  reg         ram_12_cfi_is_ret;
  reg  [39:0] ram_12_ras_top;
  reg  [4:0]  ram_12_ras_idx;
  reg         ram_12_start_bank;
  reg         ram_13_cfi_idx_valid;
  reg  [2:0]  ram_13_cfi_idx_bits;
  reg         ram_13_cfi_taken;
  reg         ram_13_cfi_mispredicted;
  reg  [2:0]  ram_13_cfi_type;
  reg  [7:0]  ram_13_br_mask;
  reg         ram_13_cfi_is_call;
  reg         ram_13_cfi_is_ret;
  reg  [39:0] ram_13_ras_top;
  reg  [4:0]  ram_13_ras_idx;
  reg         ram_13_start_bank;
  reg         ram_14_cfi_idx_valid;
  reg  [2:0]  ram_14_cfi_idx_bits;
  reg         ram_14_cfi_taken;
  reg         ram_14_cfi_mispredicted;
  reg  [2:0]  ram_14_cfi_type;
  reg  [7:0]  ram_14_br_mask;
  reg         ram_14_cfi_is_call;
  reg         ram_14_cfi_is_ret;
  reg  [39:0] ram_14_ras_top;
  reg  [4:0]  ram_14_ras_idx;
  reg         ram_14_start_bank;
  reg         ram_15_cfi_idx_valid;
  reg  [2:0]  ram_15_cfi_idx_bits;
  reg         ram_15_cfi_taken;
  reg         ram_15_cfi_mispredicted;
  reg  [2:0]  ram_15_cfi_type;
  reg  [7:0]  ram_15_br_mask;
  reg         ram_15_cfi_is_call;
  reg         ram_15_cfi_is_ret;
  reg  [39:0] ram_15_ras_top;
  reg  [4:0]  ram_15_ras_idx;
  reg         ram_15_start_bank;
  reg         ram_16_cfi_idx_valid;
  reg  [2:0]  ram_16_cfi_idx_bits;
  reg         ram_16_cfi_taken;
  reg         ram_16_cfi_mispredicted;
  reg  [2:0]  ram_16_cfi_type;
  reg  [7:0]  ram_16_br_mask;
  reg         ram_16_cfi_is_call;
  reg         ram_16_cfi_is_ret;
  reg  [39:0] ram_16_ras_top;
  reg  [4:0]  ram_16_ras_idx;
  reg         ram_16_start_bank;
  reg         ram_17_cfi_idx_valid;
  reg  [2:0]  ram_17_cfi_idx_bits;
  reg         ram_17_cfi_taken;
  reg         ram_17_cfi_mispredicted;
  reg  [2:0]  ram_17_cfi_type;
  reg  [7:0]  ram_17_br_mask;
  reg         ram_17_cfi_is_call;
  reg         ram_17_cfi_is_ret;
  reg  [39:0] ram_17_ras_top;
  reg  [4:0]  ram_17_ras_idx;
  reg         ram_17_start_bank;
  reg         ram_18_cfi_idx_valid;
  reg  [2:0]  ram_18_cfi_idx_bits;
  reg         ram_18_cfi_taken;
  reg         ram_18_cfi_mispredicted;
  reg  [2:0]  ram_18_cfi_type;
  reg  [7:0]  ram_18_br_mask;
  reg         ram_18_cfi_is_call;
  reg         ram_18_cfi_is_ret;
  reg  [39:0] ram_18_ras_top;
  reg  [4:0]  ram_18_ras_idx;
  reg         ram_18_start_bank;
  reg         ram_19_cfi_idx_valid;
  reg  [2:0]  ram_19_cfi_idx_bits;
  reg         ram_19_cfi_taken;
  reg         ram_19_cfi_mispredicted;
  reg  [2:0]  ram_19_cfi_type;
  reg  [7:0]  ram_19_br_mask;
  reg         ram_19_cfi_is_call;
  reg         ram_19_cfi_is_ret;
  reg  [39:0] ram_19_ras_top;
  reg  [4:0]  ram_19_ras_idx;
  reg         ram_19_start_bank;
  reg         ram_20_cfi_idx_valid;
  reg  [2:0]  ram_20_cfi_idx_bits;
  reg         ram_20_cfi_taken;
  reg         ram_20_cfi_mispredicted;
  reg  [2:0]  ram_20_cfi_type;
  reg  [7:0]  ram_20_br_mask;
  reg         ram_20_cfi_is_call;
  reg         ram_20_cfi_is_ret;
  reg  [39:0] ram_20_ras_top;
  reg  [4:0]  ram_20_ras_idx;
  reg         ram_20_start_bank;
  reg         ram_21_cfi_idx_valid;
  reg  [2:0]  ram_21_cfi_idx_bits;
  reg         ram_21_cfi_taken;
  reg         ram_21_cfi_mispredicted;
  reg  [2:0]  ram_21_cfi_type;
  reg  [7:0]  ram_21_br_mask;
  reg         ram_21_cfi_is_call;
  reg         ram_21_cfi_is_ret;
  reg  [39:0] ram_21_ras_top;
  reg  [4:0]  ram_21_ras_idx;
  reg         ram_21_start_bank;
  reg         ram_22_cfi_idx_valid;
  reg  [2:0]  ram_22_cfi_idx_bits;
  reg         ram_22_cfi_taken;
  reg         ram_22_cfi_mispredicted;
  reg  [2:0]  ram_22_cfi_type;
  reg  [7:0]  ram_22_br_mask;
  reg         ram_22_cfi_is_call;
  reg         ram_22_cfi_is_ret;
  reg  [39:0] ram_22_ras_top;
  reg  [4:0]  ram_22_ras_idx;
  reg         ram_22_start_bank;
  reg         ram_23_cfi_idx_valid;
  reg  [2:0]  ram_23_cfi_idx_bits;
  reg         ram_23_cfi_taken;
  reg         ram_23_cfi_mispredicted;
  reg  [2:0]  ram_23_cfi_type;
  reg  [7:0]  ram_23_br_mask;
  reg         ram_23_cfi_is_call;
  reg         ram_23_cfi_is_ret;
  reg  [39:0] ram_23_ras_top;
  reg  [4:0]  ram_23_ras_idx;
  reg         ram_23_start_bank;
  reg         ram_24_cfi_idx_valid;
  reg  [2:0]  ram_24_cfi_idx_bits;
  reg         ram_24_cfi_taken;
  reg         ram_24_cfi_mispredicted;
  reg  [2:0]  ram_24_cfi_type;
  reg  [7:0]  ram_24_br_mask;
  reg         ram_24_cfi_is_call;
  reg         ram_24_cfi_is_ret;
  reg  [39:0] ram_24_ras_top;
  reg  [4:0]  ram_24_ras_idx;
  reg         ram_24_start_bank;
  reg         ram_25_cfi_idx_valid;
  reg  [2:0]  ram_25_cfi_idx_bits;
  reg         ram_25_cfi_taken;
  reg         ram_25_cfi_mispredicted;
  reg  [2:0]  ram_25_cfi_type;
  reg  [7:0]  ram_25_br_mask;
  reg         ram_25_cfi_is_call;
  reg         ram_25_cfi_is_ret;
  reg  [39:0] ram_25_ras_top;
  reg  [4:0]  ram_25_ras_idx;
  reg         ram_25_start_bank;
  reg         ram_26_cfi_idx_valid;
  reg  [2:0]  ram_26_cfi_idx_bits;
  reg         ram_26_cfi_taken;
  reg         ram_26_cfi_mispredicted;
  reg  [2:0]  ram_26_cfi_type;
  reg  [7:0]  ram_26_br_mask;
  reg         ram_26_cfi_is_call;
  reg         ram_26_cfi_is_ret;
  reg  [39:0] ram_26_ras_top;
  reg  [4:0]  ram_26_ras_idx;
  reg         ram_26_start_bank;
  reg         ram_27_cfi_idx_valid;
  reg  [2:0]  ram_27_cfi_idx_bits;
  reg         ram_27_cfi_taken;
  reg         ram_27_cfi_mispredicted;
  reg  [2:0]  ram_27_cfi_type;
  reg  [7:0]  ram_27_br_mask;
  reg         ram_27_cfi_is_call;
  reg         ram_27_cfi_is_ret;
  reg  [39:0] ram_27_ras_top;
  reg  [4:0]  ram_27_ras_idx;
  reg         ram_27_start_bank;
  reg         ram_28_cfi_idx_valid;
  reg  [2:0]  ram_28_cfi_idx_bits;
  reg         ram_28_cfi_taken;
  reg         ram_28_cfi_mispredicted;
  reg  [2:0]  ram_28_cfi_type;
  reg  [7:0]  ram_28_br_mask;
  reg         ram_28_cfi_is_call;
  reg         ram_28_cfi_is_ret;
  reg  [39:0] ram_28_ras_top;
  reg  [4:0]  ram_28_ras_idx;
  reg         ram_28_start_bank;
  reg         ram_29_cfi_idx_valid;
  reg  [2:0]  ram_29_cfi_idx_bits;
  reg         ram_29_cfi_taken;
  reg         ram_29_cfi_mispredicted;
  reg  [2:0]  ram_29_cfi_type;
  reg  [7:0]  ram_29_br_mask;
  reg         ram_29_cfi_is_call;
  reg         ram_29_cfi_is_ret;
  reg  [39:0] ram_29_ras_top;
  reg  [4:0]  ram_29_ras_idx;
  reg         ram_29_start_bank;
  reg         ram_30_cfi_idx_valid;
  reg  [2:0]  ram_30_cfi_idx_bits;
  reg         ram_30_cfi_taken;
  reg         ram_30_cfi_mispredicted;
  reg  [2:0]  ram_30_cfi_type;
  reg  [7:0]  ram_30_br_mask;
  reg         ram_30_cfi_is_call;
  reg         ram_30_cfi_is_ret;
  reg  [39:0] ram_30_ras_top;
  reg  [4:0]  ram_30_ras_idx;
  reg         ram_30_start_bank;
  reg         ram_31_cfi_idx_valid;
  reg  [2:0]  ram_31_cfi_idx_bits;
  reg         ram_31_cfi_taken;
  reg         ram_31_cfi_mispredicted;
  reg  [2:0]  ram_31_cfi_type;
  reg  [7:0]  ram_31_br_mask;
  reg         ram_31_cfi_is_call;
  reg         ram_31_cfi_is_ret;
  reg  [39:0] ram_31_ras_top;
  reg  [4:0]  ram_31_ras_idx;
  reg         ram_31_start_bank;
  reg         ram_32_cfi_idx_valid;
  reg  [2:0]  ram_32_cfi_idx_bits;
  reg         ram_32_cfi_taken;
  reg         ram_32_cfi_mispredicted;
  reg  [2:0]  ram_32_cfi_type;
  reg  [7:0]  ram_32_br_mask;
  reg         ram_32_cfi_is_call;
  reg         ram_32_cfi_is_ret;
  reg  [39:0] ram_32_ras_top;
  reg  [4:0]  ram_32_ras_idx;
  reg         ram_32_start_bank;
  reg         ram_33_cfi_idx_valid;
  reg  [2:0]  ram_33_cfi_idx_bits;
  reg         ram_33_cfi_taken;
  reg         ram_33_cfi_mispredicted;
  reg  [2:0]  ram_33_cfi_type;
  reg  [7:0]  ram_33_br_mask;
  reg         ram_33_cfi_is_call;
  reg         ram_33_cfi_is_ret;
  reg  [39:0] ram_33_ras_top;
  reg  [4:0]  ram_33_ras_idx;
  reg         ram_33_start_bank;
  reg         ram_34_cfi_idx_valid;
  reg  [2:0]  ram_34_cfi_idx_bits;
  reg         ram_34_cfi_taken;
  reg         ram_34_cfi_mispredicted;
  reg  [2:0]  ram_34_cfi_type;
  reg  [7:0]  ram_34_br_mask;
  reg         ram_34_cfi_is_call;
  reg         ram_34_cfi_is_ret;
  reg  [39:0] ram_34_ras_top;
  reg  [4:0]  ram_34_ras_idx;
  reg         ram_34_start_bank;
  reg         ram_35_cfi_idx_valid;
  reg  [2:0]  ram_35_cfi_idx_bits;
  reg         ram_35_cfi_taken;
  reg         ram_35_cfi_mispredicted;
  reg  [2:0]  ram_35_cfi_type;
  reg  [7:0]  ram_35_br_mask;
  reg         ram_35_cfi_is_call;
  reg         ram_35_cfi_is_ret;
  reg  [39:0] ram_35_ras_top;
  reg  [4:0]  ram_35_ras_idx;
  reg         ram_35_start_bank;
  reg         ram_36_cfi_idx_valid;
  reg  [2:0]  ram_36_cfi_idx_bits;
  reg         ram_36_cfi_taken;
  reg         ram_36_cfi_mispredicted;
  reg  [2:0]  ram_36_cfi_type;
  reg  [7:0]  ram_36_br_mask;
  reg         ram_36_cfi_is_call;
  reg         ram_36_cfi_is_ret;
  reg  [39:0] ram_36_ras_top;
  reg  [4:0]  ram_36_ras_idx;
  reg         ram_36_start_bank;
  reg         ram_37_cfi_idx_valid;
  reg  [2:0]  ram_37_cfi_idx_bits;
  reg         ram_37_cfi_taken;
  reg         ram_37_cfi_mispredicted;
  reg  [2:0]  ram_37_cfi_type;
  reg  [7:0]  ram_37_br_mask;
  reg         ram_37_cfi_is_call;
  reg         ram_37_cfi_is_ret;
  reg  [39:0] ram_37_ras_top;
  reg  [4:0]  ram_37_ras_idx;
  reg         ram_37_start_bank;
  reg         ram_38_cfi_idx_valid;
  reg  [2:0]  ram_38_cfi_idx_bits;
  reg         ram_38_cfi_taken;
  reg         ram_38_cfi_mispredicted;
  reg  [2:0]  ram_38_cfi_type;
  reg  [7:0]  ram_38_br_mask;
  reg         ram_38_cfi_is_call;
  reg         ram_38_cfi_is_ret;
  reg  [39:0] ram_38_ras_top;
  reg  [4:0]  ram_38_ras_idx;
  reg         ram_38_start_bank;
  reg         ram_39_cfi_idx_valid;
  reg  [2:0]  ram_39_cfi_idx_bits;
  reg         ram_39_cfi_taken;
  reg         ram_39_cfi_mispredicted;
  reg  [2:0]  ram_39_cfi_type;
  reg  [7:0]  ram_39_br_mask;
  reg         ram_39_cfi_is_call;
  reg         ram_39_cfi_is_ret;
  reg  [39:0] ram_39_ras_top;
  reg  [4:0]  ram_39_ras_idx;
  reg         ram_39_start_bank;
  wire        do_enq = io_enq_ready_REG & io_enq_valid;
  reg  [63:0] prev_ghist_old_history;
  reg         prev_ghist_current_saw_branch_not_taken;
  reg         prev_ghist_new_saw_branch_not_taken;
  reg         prev_ghist_new_saw_branch_taken;
  reg  [4:0]  prev_ghist_ras_idx;
  reg         prev_entry_cfi_idx_valid;
  reg  [2:0]  prev_entry_cfi_idx_bits;
  reg         prev_entry_cfi_taken;
  reg  [7:0]  prev_entry_br_mask;
  reg         prev_entry_cfi_is_call;
  reg         prev_entry_cfi_is_ret;
  reg  [39:0] prev_pc;
  wire [7:0]  _GEN = {5'h0, prev_entry_cfi_idx_bits};
  wire [7:0]  _new_ghist_T = prev_entry_br_mask >> _GEN;
  wire [7:0]  new_ghist_cfi_idx_oh = 8'h1 << _GEN;
  wire [6:0]  _GEN_0 = new_ghist_cfi_idx_oh[6:0] | new_ghist_cfi_idx_oh[7:1];
  wire [5:0]  _GEN_1 = _GEN_0[5:0] | new_ghist_cfi_idx_oh[7:2];
  wire [4:0]  _GEN_2 = _GEN_1[4:0] | new_ghist_cfi_idx_oh[7:3];
  wire [3:0]  _GEN_3 = _GEN_2[3:0] | new_ghist_cfi_idx_oh[7:4];
  wire [2:0]  _GEN_4 = _GEN_3[2:0] | new_ghist_cfi_idx_oh[7:5];
  wire [1:0]  _GEN_5 = _GEN_4[1:0] | new_ghist_cfi_idx_oh[7:6];
  wire [7:0]  _new_ghist_not_taken_branches_T_20 = prev_entry_cfi_idx_valid ? {&prev_entry_cfi_idx_bits, _GEN_0[6], _GEN_1[5], _GEN_2[4], _GEN_3[3], _GEN_4[2], _GEN_5[1], _GEN_5[0] | (&prev_entry_cfi_idx_bits)} & ~(_new_ghist_T[0] & prev_entry_cfi_taken ? new_ghist_cfi_idx_oh : 8'h0) : 8'hFF;
  wire        _new_ghist_new_history_new_saw_branch_taken_T_1 = prev_entry_cfi_idx_valid & prev_entry_cfi_taken;
  wire        new_ghist_cfi_in_bank_0 = _new_ghist_new_history_new_saw_branch_taken_T_1 & ~(prev_entry_cfi_idx_bits[2]);
  wire        new_ghist_ignore_second_bank = new_ghist_cfi_in_bank_0 | (&(prev_pc[5:3]));
  wire        new_ghist_first_bank_saw_not_taken = (|(prev_entry_br_mask[3:0] & _new_ghist_not_taken_branches_T_20[3:0])) | prev_ghist_current_saw_branch_not_taken;
  wire [63:0] _GEN_6 = {prev_ghist_old_history[62:0], 1'h0};
  wire [63:0] _GEN_7 = {prev_ghist_old_history[62:0], 1'h1};
  wire        _new_ghist_new_history_old_history_T_5 = _new_ghist_T[0] & new_ghist_cfi_in_bank_0;
  wire [62:0] _GEN_8 = {prev_ghist_old_history[61:0], 1'h0};
  wire [62:0] _GEN_9 = {prev_ghist_old_history[61:0], 1'h1};
  wire [3:0]  _new_ghist_new_history_new_saw_branch_not_taken_T = prev_entry_br_mask[7:4] & _new_ghist_not_taken_branches_T_20[7:4];
  wire        _new_ghist_new_history_new_saw_branch_taken_T_4 = _new_ghist_new_history_new_saw_branch_taken_T_1 & _new_ghist_T[0] & ~new_ghist_cfi_in_bank_0;
  wire [63:0] _GEN_40 = new_ghist_ignore_second_bank ? (prev_ghist_new_saw_branch_taken ? _GEN_7 : prev_ghist_new_saw_branch_not_taken ? _GEN_6 : prev_ghist_old_history) : _new_ghist_new_history_old_history_T_5 ? {prev_ghist_new_saw_branch_taken ? _GEN_9 : prev_ghist_new_saw_branch_not_taken ? _GEN_8 : prev_ghist_old_history[62:0], 1'h1} : new_ghist_first_bank_saw_not_taken ? {prev_ghist_new_saw_branch_taken ? _GEN_9 : prev_ghist_new_saw_branch_not_taken ? _GEN_8 : prev_ghist_old_history[62:0], 1'h0} : prev_ghist_new_saw_branch_taken ? _GEN_7 : prev_ghist_new_saw_branch_not_taken ? _GEN_6 : prev_ghist_old_history;
  wire        _new_ghist_new_history_ras_idx_T = prev_entry_cfi_idx_valid & prev_entry_cfi_is_call;
  wire [4:0]  _new_ghist_new_history_ras_idx_T_1 = prev_ghist_ras_idx + 5'h1;
  wire        _new_ghist_new_history_ras_idx_T_4 = prev_entry_cfi_idx_valid & prev_entry_cfi_is_ret;
  wire [4:0]  _new_ghist_new_history_ras_idx_T_5 = prev_ghist_ras_idx - 5'h1;
  wire [63:0] new_ghist_old_history = io_enq_bits_ghist_current_saw_branch_not_taken ? io_enq_bits_ghist_old_history : _GEN_40;
  wire        new_ghist_new_saw_branch_not_taken = io_enq_bits_ghist_current_saw_branch_not_taken ? io_enq_bits_ghist_new_saw_branch_not_taken : new_ghist_ignore_second_bank ? new_ghist_first_bank_saw_not_taken : (|_new_ghist_new_history_new_saw_branch_not_taken_T);
  wire        new_ghist_new_saw_branch_taken = io_enq_bits_ghist_current_saw_branch_not_taken ? io_enq_bits_ghist_new_saw_branch_taken : new_ghist_ignore_second_bank ? _new_ghist_new_history_old_history_T_5 : _new_ghist_new_history_new_saw_branch_taken_T_4;
  wire [4:0]  new_ghist_ras_idx = io_enq_bits_ghist_current_saw_branch_not_taken ? io_enq_bits_ghist_ras_idx : _new_ghist_new_history_ras_idx_T ? _new_ghist_new_history_ras_idx_T_1 : _new_ghist_new_history_ras_idx_T_4 ? _new_ghist_new_history_ras_idx_T_5 : prev_ghist_ras_idx;
  reg         first_empty;
  reg         io_ras_update_REG;
  reg  [39:0] io_ras_update_pc_REG;
  reg  [4:0]  io_ras_update_idx_REG;
  reg         bpd_update_mispredict;
  reg         bpd_update_repair;
  reg  [5:0]  bpd_repair_idx;
  reg  [5:0]  bpd_end_idx;
  reg  [39:0] bpd_repair_pc;
  wire [5:0]  bpd_idx = io_redirect_valid ? io_redirect_bits : bpd_update_repair | bpd_update_mispredict ? bpd_repair_idx : bpd_ptr;
  reg         bpd_entry_cfi_idx_valid;
  reg  [2:0]  bpd_entry_cfi_idx_bits;
  reg         bpd_entry_cfi_taken;
  reg         bpd_entry_cfi_mispredicted;
  reg  [2:0]  bpd_entry_cfi_type;
  reg  [7:0]  bpd_entry_br_mask;
  reg  [39:0] bpd_pc;
  reg  [39:0] bpd_target;
  reg         REG;
  reg  [5:0]  bpd_repair_idx_REG;
  reg  [5:0]  bpd_end_idx_REG;
  reg         REG_1;
  reg         do_commit_update_REG;
  reg         REG_2;
  reg         io_bpdupdate_valid_REG;
  reg         io_bpdupdate_bits_is_mispredict_update_REG;
  reg         io_bpdupdate_bits_is_repair_update_REG;
  wire [7:0]  _GEN_10 = {5'h0, bpd_entry_cfi_idx_bits};
  wire [7:0]  _io_bpdupdate_bits_br_mask_T_1 = 8'h1 << _GEN_10;
  wire [6:0]  _GEN_11 = _io_bpdupdate_bits_br_mask_T_1[6:0] | _io_bpdupdate_bits_br_mask_T_1[7:1];
  wire [5:0]  _GEN_12 = _GEN_11[5:0] | _io_bpdupdate_bits_br_mask_T_1[7:2];
  wire [4:0]  _GEN_13 = _GEN_12[4:0] | _io_bpdupdate_bits_br_mask_T_1[7:3];
  wire [3:0]  _GEN_14 = _GEN_13[3:0] | _io_bpdupdate_bits_br_mask_T_1[7:4];
  wire [2:0]  _GEN_15 = _GEN_14[2:0] | _io_bpdupdate_bits_br_mask_T_1[7:5];
  wire [1:0]  _GEN_16 = _GEN_15[1:0] | _io_bpdupdate_bits_br_mask_T_1[7:6];
  wire [7:0]  _io_bpdupdate_bits_cfi_is_br_T = bpd_entry_br_mask >> _GEN_10;
  reg         REG_3;
  reg         prev_entry_REG_cfi_idx_valid;
  reg  [2:0]  prev_entry_REG_cfi_idx_bits;
  reg         prev_entry_REG_cfi_taken;
  reg  [7:0]  prev_entry_REG_br_mask;
  reg         prev_entry_REG_cfi_is_call;
  reg         prev_entry_REG_cfi_is_ret;
  reg  [5:0]  REG_4;
  reg         ram_REG_cfi_idx_valid;
  reg  [2:0]  ram_REG_cfi_idx_bits;
  reg         ram_REG_cfi_taken;
  reg         ram_REG_cfi_mispredicted;
  reg  [2:0]  ram_REG_cfi_type;
  reg  [7:0]  ram_REG_br_mask;
  reg         ram_REG_cfi_is_call;
  reg         ram_REG_cfi_is_ret;
  reg  [39:0] ram_REG_ras_top;
  reg  [4:0]  ram_REG_ras_idx;
  reg         ram_REG_start_bank;
  reg         io_get_ftq_pc_0_entry_REG_cfi_idx_valid;
  reg  [2:0]  io_get_ftq_pc_0_entry_REG_cfi_idx_bits;
  reg  [4:0]  io_get_ftq_pc_0_entry_REG_ras_idx;
  reg         io_get_ftq_pc_0_entry_REG_start_bank;
  reg  [39:0] io_get_ftq_pc_0_pc_REG;
  reg  [39:0] io_get_ftq_pc_0_next_pc_REG;
  reg         io_get_ftq_pc_0_next_val_REG;
  reg  [39:0] io_get_ftq_pc_0_com_pc_REG;
  reg  [2:0]  io_get_ftq_pc_1_entry_REG_cfi_idx_bits;
  reg  [7:0]  io_get_ftq_pc_1_entry_REG_br_mask;
  reg         io_get_ftq_pc_1_entry_REG_cfi_is_call;
  reg         io_get_ftq_pc_1_entry_REG_cfi_is_ret;
  reg         io_get_ftq_pc_1_entry_REG_start_bank;
  reg  [39:0] io_get_ftq_pc_1_pc_REG;
  wire        full_wrap = enq_ptr == 6'h27;
  wire [5:0]  _enq_ptr_T = enq_ptr + 6'h1;
  wire [5:0]  _full_T_2 = full_wrap ? 6'h0 : _enq_ptr_T;
  wire [7:0]  new_entry_br_mask = io_enq_bits_br_mask & io_enq_bits_mask;
  wire        _GEN_17 = do_enq & enq_ptr == 6'h0;
  wire        _GEN_18 = do_enq & enq_ptr == 6'h1;
  wire        _GEN_19 = do_enq & enq_ptr == 6'h2;
  wire        _GEN_20 = do_enq & enq_ptr == 6'h3;
  wire        _GEN_21 = do_enq & enq_ptr == 6'h4;
  wire        _GEN_22 = do_enq & enq_ptr == 6'h5;
  wire        _GEN_23 = do_enq & enq_ptr == 6'h6;
  wire        _GEN_24 = do_enq & enq_ptr == 6'h7;
  wire        _GEN_25 = do_enq & enq_ptr == 6'h8;
  wire        _GEN_26 = do_enq & enq_ptr == 6'h9;
  wire        _GEN_27 = do_enq & enq_ptr == 6'hA;
  wire        _GEN_28 = do_enq & enq_ptr == 6'hB;
  wire        _GEN_29 = do_enq & enq_ptr == 6'hC;
  wire        _GEN_30 = do_enq & enq_ptr == 6'hD;
  wire        _GEN_31 = do_enq & enq_ptr == 6'hE;
  wire        _GEN_32 = do_enq & enq_ptr == 6'hF;
  wire        _GEN_33 = do_enq & enq_ptr == 6'h10;
  wire        _GEN_34 = do_enq & enq_ptr == 6'h11;
  wire        _GEN_35 = do_enq & enq_ptr == 6'h12;
  wire        _GEN_36 = do_enq & enq_ptr == 6'h13;
  wire        _GEN_37 = do_enq & enq_ptr == 6'h14;
  wire        _GEN_38 = do_enq & enq_ptr == 6'h15;
  wire        _GEN_39 = do_enq & enq_ptr == 6'h16;
  wire        _GEN_41 = do_enq & enq_ptr == 6'h17;
  wire        _GEN_42 = do_enq & enq_ptr == 6'h18;
  wire        _GEN_43 = do_enq & enq_ptr == 6'h19;
  wire        _GEN_44 = do_enq & enq_ptr == 6'h1A;
  wire        _GEN_45 = do_enq & enq_ptr == 6'h1B;
  wire        _GEN_46 = do_enq & enq_ptr == 6'h1C;
  wire        _GEN_47 = do_enq & enq_ptr == 6'h1D;
  wire        _GEN_48 = do_enq & enq_ptr == 6'h1E;
  wire        _GEN_49 = do_enq & enq_ptr == 6'h1F;
  wire        _GEN_50 = do_enq & enq_ptr == 6'h20;
  wire        _GEN_51 = do_enq & enq_ptr == 6'h21;
  wire        _GEN_52 = do_enq & enq_ptr == 6'h22;
  wire        _GEN_53 = do_enq & enq_ptr == 6'h23;
  wire        _GEN_54 = do_enq & enq_ptr == 6'h24;
  wire        _GEN_55 = do_enq & enq_ptr == 6'h25;
  wire        _GEN_56 = do_enq & enq_ptr == 6'h26;
  wire        _GEN_57 = do_enq & enq_ptr == 6'h27;
  wire [5:0]  _io_get_ftq_pc_1_com_pc_T = io_deq_valid ? io_deq_bits : deq_ptr;
  wire [5:0]  _bpd_target_T_2 = bpd_idx == 6'h27 ? 6'h0 : bpd_idx + 6'h1;
  wire        wrap = bpd_repair_idx == 6'h27;
  wire [5:0]  _bpd_repair_idx_T_6 = bpd_repair_idx + 6'h1;
  wire        _GEN_58 = bpd_update_repair & REG_1;
  wire        bpd_ptr_wrap = bpd_ptr == 6'h27;
  wire [5:0]  _bpd_ptr_T = bpd_ptr + 6'h1;
  wire        do_commit_update = ~bpd_update_mispredict & ~bpd_update_repair & bpd_ptr != deq_ptr & enq_ptr != (bpd_ptr_wrap ? 6'h0 : _bpd_ptr_T) & ~io_brupdate_b2_mispredict & ~io_redirect_valid & ~do_commit_update_REG;
  wire        _GEN_59 = io_redirect_bits == 6'h1;
  wire        _GEN_60 = io_redirect_bits == 6'h2;
  wire        _GEN_61 = io_redirect_bits == 6'h3;
  wire        _GEN_62 = io_redirect_bits == 6'h4;
  wire        _GEN_63 = io_redirect_bits == 6'h5;
  wire        _GEN_64 = io_redirect_bits == 6'h6;
  wire        _GEN_65 = io_redirect_bits == 6'h7;
  wire        _GEN_66 = io_redirect_bits == 6'h8;
  wire        _GEN_67 = io_redirect_bits == 6'h9;
  wire        _GEN_68 = io_redirect_bits == 6'hA;
  wire        _GEN_69 = io_redirect_bits == 6'hB;
  wire        _GEN_70 = io_redirect_bits == 6'hC;
  wire        _GEN_71 = io_redirect_bits == 6'hD;
  wire        _GEN_72 = io_redirect_bits == 6'hE;
  wire        _GEN_73 = io_redirect_bits == 6'hF;
  wire        _GEN_74 = io_redirect_bits == 6'h10;
  wire        _GEN_75 = io_redirect_bits == 6'h11;
  wire        _GEN_76 = io_redirect_bits == 6'h12;
  wire        _GEN_77 = io_redirect_bits == 6'h13;
  wire        _GEN_78 = io_redirect_bits == 6'h14;
  wire        _GEN_79 = io_redirect_bits == 6'h15;
  wire        _GEN_80 = io_redirect_bits == 6'h16;
  wire        _GEN_81 = io_redirect_bits == 6'h17;
  wire        _GEN_82 = io_redirect_bits == 6'h18;
  wire        _GEN_83 = io_redirect_bits == 6'h19;
  wire        _GEN_84 = io_redirect_bits == 6'h1A;
  wire        _GEN_85 = io_redirect_bits == 6'h1B;
  wire        _GEN_86 = io_redirect_bits == 6'h1C;
  wire        _GEN_87 = io_redirect_bits == 6'h1D;
  wire        _GEN_88 = io_redirect_bits == 6'h1E;
  wire        _GEN_89 = io_redirect_bits == 6'h1F;
  wire        _GEN_90 = io_redirect_bits == 6'h20;
  wire        _GEN_91 = io_redirect_bits == 6'h21;
  wire        _GEN_92 = io_redirect_bits == 6'h22;
  wire        _GEN_93 = io_redirect_bits == 6'h23;
  wire        _GEN_94 = io_redirect_bits == 6'h24;
  wire        _GEN_95 = io_redirect_bits == 6'h25;
  wire        _GEN_96 = io_redirect_bits == 6'h26;
  wire        _GEN_97 = io_redirect_bits == 6'h27;
  wire [2:0]  _ram_io_redirect_bits_cfi_idx_bits = _GEN_97 ? ram_39_cfi_idx_bits : _GEN_96 ? ram_38_cfi_idx_bits : _GEN_95 ? ram_37_cfi_idx_bits : _GEN_94 ? ram_36_cfi_idx_bits : _GEN_93 ? ram_35_cfi_idx_bits : _GEN_92 ? ram_34_cfi_idx_bits : _GEN_91 ? ram_33_cfi_idx_bits : _GEN_90 ? ram_32_cfi_idx_bits : _GEN_89 ? ram_31_cfi_idx_bits : _GEN_88 ? ram_30_cfi_idx_bits : _GEN_87 ? ram_29_cfi_idx_bits : _GEN_86 ? ram_28_cfi_idx_bits : _GEN_85 ? ram_27_cfi_idx_bits : _GEN_84 ? ram_26_cfi_idx_bits : _GEN_83 ? ram_25_cfi_idx_bits : _GEN_82 ? ram_24_cfi_idx_bits : _GEN_81 ? ram_23_cfi_idx_bits : _GEN_80 ? ram_22_cfi_idx_bits : _GEN_79 ? ram_21_cfi_idx_bits : _GEN_78 ? ram_20_cfi_idx_bits : _GEN_77 ? ram_19_cfi_idx_bits : _GEN_76 ? ram_18_cfi_idx_bits : _GEN_75 ? ram_17_cfi_idx_bits : _GEN_74 ? ram_16_cfi_idx_bits : _GEN_73 ? ram_15_cfi_idx_bits : _GEN_72 ? ram_14_cfi_idx_bits : _GEN_71 ? ram_13_cfi_idx_bits : _GEN_70 ? ram_12_cfi_idx_bits : _GEN_69 ? ram_11_cfi_idx_bits : _GEN_68 ? ram_10_cfi_idx_bits : _GEN_67 ? ram_9_cfi_idx_bits : _GEN_66 ? ram_8_cfi_idx_bits : _GEN_65 ? ram_7_cfi_idx_bits : _GEN_64 ? ram_6_cfi_idx_bits : _GEN_63 ? ram_5_cfi_idx_bits : _GEN_62 ? ram_4_cfi_idx_bits : _GEN_61 ? ram_3_cfi_idx_bits : _GEN_60 ? ram_2_cfi_idx_bits : _GEN_59 ? ram_1_cfi_idx_bits : ram_0_cfi_idx_bits;
  wire [2:0]  new_cfi_idx = io_brupdate_b2_uop_pc_lob[3:1] ^ {_GEN_97 ? ram_39_start_bank : _GEN_96 ? ram_38_start_bank : _GEN_95 ? ram_37_start_bank : _GEN_94 ? ram_36_start_bank : _GEN_93 ? ram_35_start_bank : _GEN_92 ? ram_34_start_bank : _GEN_91 ? ram_33_start_bank : _GEN_90 ? ram_32_start_bank : _GEN_89 ? ram_31_start_bank : _GEN_88 ? ram_30_start_bank : _GEN_87 ? ram_29_start_bank : _GEN_86 ? ram_28_start_bank : _GEN_85 ? ram_27_start_bank : _GEN_84 ? ram_26_start_bank : _GEN_83 ? ram_25_start_bank : _GEN_82 ? ram_24_start_bank : _GEN_81 ? ram_23_start_bank : _GEN_80 ? ram_22_start_bank : _GEN_79 ? ram_21_start_bank : _GEN_78 ? ram_20_start_bank : _GEN_77 ? ram_19_start_bank : _GEN_76 ? ram_18_start_bank : _GEN_75 ? ram_17_start_bank : _GEN_74 ? ram_16_start_bank : _GEN_73 ? ram_15_start_bank : _GEN_72 ? ram_14_start_bank : _GEN_71 ? ram_13_start_bank : _GEN_70 ? ram_12_start_bank : _GEN_69 ? ram_11_start_bank : _GEN_68 ? ram_10_start_bank : _GEN_67 ? ram_9_start_bank : _GEN_66 ? ram_8_start_bank : _GEN_65 ? ram_7_start_bank : _GEN_64 ? ram_6_start_bank : _GEN_63 ? ram_5_start_bank : _GEN_62 ? ram_4_start_bank : _GEN_61 ? ram_3_start_bank : _GEN_60 ? ram_2_start_bank : _GEN_59 ? ram_1_start_bank : ram_0_start_bank, 2'h0};
  wire        _GEN_98 = io_redirect_valid & io_brupdate_b2_mispredict;
  wire        redirect_new_entry_cfi_idx_valid = _GEN_98 | (_GEN_97 ? ram_39_cfi_idx_valid : _GEN_96 ? ram_38_cfi_idx_valid : _GEN_95 ? ram_37_cfi_idx_valid : _GEN_94 ? ram_36_cfi_idx_valid : _GEN_93 ? ram_35_cfi_idx_valid : _GEN_92 ? ram_34_cfi_idx_valid : _GEN_91 ? ram_33_cfi_idx_valid : _GEN_90 ? ram_32_cfi_idx_valid : _GEN_89 ? ram_31_cfi_idx_valid : _GEN_88 ? ram_30_cfi_idx_valid : _GEN_87 ? ram_29_cfi_idx_valid : _GEN_86 ? ram_28_cfi_idx_valid : _GEN_85 ? ram_27_cfi_idx_valid : _GEN_84 ? ram_26_cfi_idx_valid : _GEN_83 ? ram_25_cfi_idx_valid : _GEN_82 ? ram_24_cfi_idx_valid : _GEN_81 ? ram_23_cfi_idx_valid : _GEN_80 ? ram_22_cfi_idx_valid : _GEN_79 ? ram_21_cfi_idx_valid : _GEN_78 ? ram_20_cfi_idx_valid : _GEN_77 ? ram_19_cfi_idx_valid : _GEN_76 ? ram_18_cfi_idx_valid : _GEN_75 ? ram_17_cfi_idx_valid : _GEN_74 ? ram_16_cfi_idx_valid : _GEN_73 ? ram_15_cfi_idx_valid : _GEN_72 ? ram_14_cfi_idx_valid : _GEN_71 ? ram_13_cfi_idx_valid : _GEN_70 ? ram_12_cfi_idx_valid : _GEN_69 ? ram_11_cfi_idx_valid : _GEN_68 ? ram_10_cfi_idx_valid : _GEN_67 ? ram_9_cfi_idx_valid : _GEN_66 ? ram_8_cfi_idx_valid : _GEN_65 ? ram_7_cfi_idx_valid : _GEN_64 ? ram_6_cfi_idx_valid : _GEN_63 ? ram_5_cfi_idx_valid : _GEN_62 ? ram_4_cfi_idx_valid : _GEN_61 ? ram_3_cfi_idx_valid : _GEN_60 ? ram_2_cfi_idx_valid : _GEN_59 ? ram_1_cfi_idx_valid : ram_0_cfi_idx_valid);
  wire        redirect_new_entry_cfi_is_call = (~_GEN_98 | _ram_io_redirect_bits_cfi_idx_bits == new_cfi_idx) & (_GEN_97 ? ram_39_cfi_is_call : _GEN_96 ? ram_38_cfi_is_call : _GEN_95 ? ram_37_cfi_is_call : _GEN_94 ? ram_36_cfi_is_call : _GEN_93 ? ram_35_cfi_is_call : _GEN_92 ? ram_34_cfi_is_call : _GEN_91 ? ram_33_cfi_is_call : _GEN_90 ? ram_32_cfi_is_call : _GEN_89 ? ram_31_cfi_is_call : _GEN_88 ? ram_30_cfi_is_call : _GEN_87 ? ram_29_cfi_is_call : _GEN_86 ? ram_28_cfi_is_call : _GEN_85 ? ram_27_cfi_is_call : _GEN_84 ? ram_26_cfi_is_call : _GEN_83 ? ram_25_cfi_is_call : _GEN_82 ? ram_24_cfi_is_call : _GEN_81 ? ram_23_cfi_is_call : _GEN_80 ? ram_22_cfi_is_call : _GEN_79 ? ram_21_cfi_is_call : _GEN_78 ? ram_20_cfi_is_call : _GEN_77 ? ram_19_cfi_is_call : _GEN_76 ? ram_18_cfi_is_call : _GEN_75 ? ram_17_cfi_is_call : _GEN_74 ? ram_16_cfi_is_call : _GEN_73 ? ram_15_cfi_is_call : _GEN_72 ? ram_14_cfi_is_call : _GEN_71 ? ram_13_cfi_is_call : _GEN_70 ? ram_12_cfi_is_call : _GEN_69 ? ram_11_cfi_is_call : _GEN_68 ? ram_10_cfi_is_call : _GEN_67 ? ram_9_cfi_is_call : _GEN_66 ? ram_8_cfi_is_call : _GEN_65 ? ram_7_cfi_is_call : _GEN_64 ? ram_6_cfi_is_call : _GEN_63 ? ram_5_cfi_is_call : _GEN_62 ? ram_4_cfi_is_call : _GEN_61 ? ram_3_cfi_is_call : _GEN_60 ? ram_2_cfi_is_call : _GEN_59 ? ram_1_cfi_is_call : ram_0_cfi_is_call);
  wire        redirect_new_entry_cfi_is_ret = (~_GEN_98 | _ram_io_redirect_bits_cfi_idx_bits == new_cfi_idx) & (_GEN_97 ? ram_39_cfi_is_ret : _GEN_96 ? ram_38_cfi_is_ret : _GEN_95 ? ram_37_cfi_is_ret : _GEN_94 ? ram_36_cfi_is_ret : _GEN_93 ? ram_35_cfi_is_ret : _GEN_92 ? ram_34_cfi_is_ret : _GEN_91 ? ram_33_cfi_is_ret : _GEN_90 ? ram_32_cfi_is_ret : _GEN_89 ? ram_31_cfi_is_ret : _GEN_88 ? ram_30_cfi_is_ret : _GEN_87 ? ram_29_cfi_is_ret : _GEN_86 ? ram_28_cfi_is_ret : _GEN_85 ? ram_27_cfi_is_ret : _GEN_84 ? ram_26_cfi_is_ret : _GEN_83 ? ram_25_cfi_is_ret : _GEN_82 ? ram_24_cfi_is_ret : _GEN_81 ? ram_23_cfi_is_ret : _GEN_80 ? ram_22_cfi_is_ret : _GEN_79 ? ram_21_cfi_is_ret : _GEN_78 ? ram_20_cfi_is_ret : _GEN_77 ? ram_19_cfi_is_ret : _GEN_76 ? ram_18_cfi_is_ret : _GEN_75 ? ram_17_cfi_is_ret : _GEN_74 ? ram_16_cfi_is_ret : _GEN_73 ? ram_15_cfi_is_ret : _GEN_72 ? ram_14_cfi_is_ret : _GEN_71 ? ram_13_cfi_is_ret : _GEN_70 ? ram_12_cfi_is_ret : _GEN_69 ? ram_11_cfi_is_ret : _GEN_68 ? ram_10_cfi_is_ret : _GEN_67 ? ram_9_cfi_is_ret : _GEN_66 ? ram_8_cfi_is_ret : _GEN_65 ? ram_7_cfi_is_ret : _GEN_64 ? ram_6_cfi_is_ret : _GEN_63 ? ram_5_cfi_is_ret : _GEN_62 ? ram_4_cfi_is_ret : _GEN_61 ? ram_3_cfi_is_ret : _GEN_60 ? ram_2_cfi_is_ret : _GEN_59 ? ram_1_cfi_is_ret : ram_0_cfi_is_ret);
  wire [5:0]  next_idx = io_get_ftq_pc_0_ftq_idx == 6'h27 ? 6'h0 : io_get_ftq_pc_0_ftq_idx + 6'h1;
  wire        next_is_enq = next_idx == enq_ptr & do_enq;
  always @(posedge clock) begin
    if (reset) begin
      bpd_ptr <= 6'h0;
      deq_ptr <= 6'h0;
      enq_ptr <= 6'h1;
      prev_ghist_old_history <= 64'h0;
      prev_ghist_current_saw_branch_not_taken <= 1'h0;
      prev_ghist_new_saw_branch_not_taken <= 1'h0;
      prev_ghist_new_saw_branch_taken <= 1'h0;
      prev_ghist_ras_idx <= 5'h0;
      prev_entry_cfi_idx_valid <= 1'h0;
      prev_entry_cfi_idx_bits <= 3'h0;
      prev_entry_cfi_taken <= 1'h0;
      prev_entry_br_mask <= 8'h0;
      prev_entry_cfi_is_call <= 1'h0;
      prev_entry_cfi_is_ret <= 1'h0;
      prev_pc <= 40'h0;
      first_empty <= 1'h1;
      bpd_update_mispredict <= 1'h0;
      bpd_update_repair <= 1'h0;
    end
    else begin
      if (do_commit_update) begin
        if (bpd_ptr_wrap)
          bpd_ptr <= 6'h0;
        else
          bpd_ptr <= _bpd_ptr_T;
      end
      if (io_deq_valid)
        deq_ptr <= io_deq_bits;
      if (io_redirect_valid) begin
        if (io_redirect_bits == 6'h27)
          enq_ptr <= 6'h0;
        else
          enq_ptr <= io_redirect_bits + 6'h1;
      end
      else if (do_enq) begin
        if (full_wrap)
          enq_ptr <= 6'h0;
        else
          enq_ptr <= _enq_ptr_T;
      end
      if (io_redirect_valid | ~REG_3) begin
        if (do_enq) begin
          if (io_enq_bits_ghist_current_saw_branch_not_taken)
            prev_ghist_old_history <= io_enq_bits_ghist_old_history;
          else
            prev_ghist_old_history <= _GEN_40;
          prev_ghist_current_saw_branch_not_taken <= io_enq_bits_ghist_current_saw_branch_not_taken;
          if (io_enq_bits_ghist_current_saw_branch_not_taken) begin
            prev_ghist_new_saw_branch_not_taken <= io_enq_bits_ghist_new_saw_branch_not_taken;
            prev_ghist_new_saw_branch_taken <= io_enq_bits_ghist_new_saw_branch_taken;
            prev_ghist_ras_idx <= io_enq_bits_ghist_ras_idx;
          end
          else begin
            if (new_ghist_ignore_second_bank) begin
              prev_ghist_new_saw_branch_not_taken <= new_ghist_first_bank_saw_not_taken;
              prev_ghist_new_saw_branch_taken <= _new_ghist_new_history_old_history_T_5;
            end
            else begin
              prev_ghist_new_saw_branch_not_taken <= |_new_ghist_new_history_new_saw_branch_not_taken_T;
              prev_ghist_new_saw_branch_taken <= _new_ghist_new_history_new_saw_branch_taken_T_4;
            end
            if (_new_ghist_new_history_ras_idx_T)
              prev_ghist_ras_idx <= _new_ghist_new_history_ras_idx_T_1;
            else if (_new_ghist_new_history_ras_idx_T_4)
              prev_ghist_ras_idx <= _new_ghist_new_history_ras_idx_T_5;
          end
          prev_entry_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
          prev_entry_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
          prev_entry_cfi_taken <= io_enq_bits_cfi_idx_valid;
          prev_entry_br_mask <= new_entry_br_mask;
          prev_entry_cfi_is_call <= io_enq_bits_cfi_is_call;
          prev_entry_cfi_is_ret <= io_enq_bits_cfi_is_ret;
          prev_pc <= io_enq_bits_pc;
        end
      end
      else begin
        prev_ghist_old_history <= _ghist_0_old_history_ext_R0_data;
        prev_ghist_current_saw_branch_not_taken <= _ghist_0_current_saw_branch_not_taken_ext_R0_data;
        prev_ghist_new_saw_branch_not_taken <= _ghist_0_new_saw_branch_not_taken_ext_R0_data;
        prev_ghist_new_saw_branch_taken <= _ghist_0_new_saw_branch_taken_ext_R0_data;
        prev_ghist_ras_idx <= _ghist_0_ras_idx_ext_R0_data;
        prev_entry_cfi_idx_valid <= prev_entry_REG_cfi_idx_valid;
        prev_entry_cfi_idx_bits <= prev_entry_REG_cfi_idx_bits;
        prev_entry_cfi_taken <= prev_entry_REG_cfi_taken;
        prev_entry_br_mask <= prev_entry_REG_br_mask;
        prev_entry_cfi_is_call <= prev_entry_REG_cfi_is_call;
        prev_entry_cfi_is_ret <= prev_entry_REG_cfi_is_ret;
        prev_pc <= bpd_pc;
      end
      first_empty <= ~REG_2 & first_empty;
      bpd_update_mispredict <= ~io_redirect_valid & REG;
      bpd_update_repair <= ~io_redirect_valid & (REG ? bpd_update_repair : bpd_update_mispredict | (_GEN_58 | ~(bpd_update_repair & ((wrap ? 6'h0 : _bpd_repair_idx_T_6) == bpd_end_idx | bpd_pc == bpd_repair_pc))) & bpd_update_repair);
    end
    if (_GEN_17)
      pcs_0 <= io_enq_bits_pc;
    if (_GEN_18)
      pcs_1 <= io_enq_bits_pc;
    if (_GEN_19)
      pcs_2 <= io_enq_bits_pc;
    if (_GEN_20)
      pcs_3 <= io_enq_bits_pc;
    if (_GEN_21)
      pcs_4 <= io_enq_bits_pc;
    if (_GEN_22)
      pcs_5 <= io_enq_bits_pc;
    if (_GEN_23)
      pcs_6 <= io_enq_bits_pc;
    if (_GEN_24)
      pcs_7 <= io_enq_bits_pc;
    if (_GEN_25)
      pcs_8 <= io_enq_bits_pc;
    if (_GEN_26)
      pcs_9 <= io_enq_bits_pc;
    if (_GEN_27)
      pcs_10 <= io_enq_bits_pc;
    if (_GEN_28)
      pcs_11 <= io_enq_bits_pc;
    if (_GEN_29)
      pcs_12 <= io_enq_bits_pc;
    if (_GEN_30)
      pcs_13 <= io_enq_bits_pc;
    if (_GEN_31)
      pcs_14 <= io_enq_bits_pc;
    if (_GEN_32)
      pcs_15 <= io_enq_bits_pc;
    if (_GEN_33)
      pcs_16 <= io_enq_bits_pc;
    if (_GEN_34)
      pcs_17 <= io_enq_bits_pc;
    if (_GEN_35)
      pcs_18 <= io_enq_bits_pc;
    if (_GEN_36)
      pcs_19 <= io_enq_bits_pc;
    if (_GEN_37)
      pcs_20 <= io_enq_bits_pc;
    if (_GEN_38)
      pcs_21 <= io_enq_bits_pc;
    if (_GEN_39)
      pcs_22 <= io_enq_bits_pc;
    if (_GEN_41)
      pcs_23 <= io_enq_bits_pc;
    if (_GEN_42)
      pcs_24 <= io_enq_bits_pc;
    if (_GEN_43)
      pcs_25 <= io_enq_bits_pc;
    if (_GEN_44)
      pcs_26 <= io_enq_bits_pc;
    if (_GEN_45)
      pcs_27 <= io_enq_bits_pc;
    if (_GEN_46)
      pcs_28 <= io_enq_bits_pc;
    if (_GEN_47)
      pcs_29 <= io_enq_bits_pc;
    if (_GEN_48)
      pcs_30 <= io_enq_bits_pc;
    if (_GEN_49)
      pcs_31 <= io_enq_bits_pc;
    if (_GEN_50)
      pcs_32 <= io_enq_bits_pc;
    if (_GEN_51)
      pcs_33 <= io_enq_bits_pc;
    if (_GEN_52)
      pcs_34 <= io_enq_bits_pc;
    if (_GEN_53)
      pcs_35 <= io_enq_bits_pc;
    if (_GEN_54)
      pcs_36 <= io_enq_bits_pc;
    if (_GEN_55)
      pcs_37 <= io_enq_bits_pc;
    if (_GEN_56)
      pcs_38 <= io_enq_bits_pc;
    if (_GEN_57)
      pcs_39 <= io_enq_bits_pc;
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h0)) begin
      if (_GEN_17) begin
        ram_0_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_0_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_0_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_0_cfi_mispredicted <= ~_GEN_17 & ram_0_cfi_mispredicted;
      if (_GEN_17) begin
        ram_0_cfi_type <= io_enq_bits_cfi_type;
        ram_0_br_mask <= new_entry_br_mask;
        ram_0_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_0_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_0_ras_top <= io_enq_bits_ras_top;
        ram_0_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_0_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_0_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_0_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_0_cfi_taken <= ram_REG_cfi_taken;
      ram_0_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_0_cfi_type <= ram_REG_cfi_type;
      ram_0_br_mask <= ram_REG_br_mask;
      ram_0_cfi_is_call <= ram_REG_cfi_is_call;
      ram_0_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_0_ras_top <= ram_REG_ras_top;
      ram_0_ras_idx <= ram_REG_ras_idx;
      ram_0_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h1)) begin
      if (_GEN_18) begin
        ram_1_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_1_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_1_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_1_cfi_mispredicted <= ~_GEN_18 & ram_1_cfi_mispredicted;
      if (_GEN_18) begin
        ram_1_cfi_type <= io_enq_bits_cfi_type;
        ram_1_br_mask <= new_entry_br_mask;
        ram_1_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_1_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_1_ras_top <= io_enq_bits_ras_top;
        ram_1_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_1_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_1_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_1_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_1_cfi_taken <= ram_REG_cfi_taken;
      ram_1_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_1_cfi_type <= ram_REG_cfi_type;
      ram_1_br_mask <= ram_REG_br_mask;
      ram_1_cfi_is_call <= ram_REG_cfi_is_call;
      ram_1_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_1_ras_top <= ram_REG_ras_top;
      ram_1_ras_idx <= ram_REG_ras_idx;
      ram_1_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h2)) begin
      if (_GEN_19) begin
        ram_2_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_2_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_2_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_2_cfi_mispredicted <= ~_GEN_19 & ram_2_cfi_mispredicted;
      if (_GEN_19) begin
        ram_2_cfi_type <= io_enq_bits_cfi_type;
        ram_2_br_mask <= new_entry_br_mask;
        ram_2_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_2_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_2_ras_top <= io_enq_bits_ras_top;
        ram_2_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_2_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_2_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_2_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_2_cfi_taken <= ram_REG_cfi_taken;
      ram_2_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_2_cfi_type <= ram_REG_cfi_type;
      ram_2_br_mask <= ram_REG_br_mask;
      ram_2_cfi_is_call <= ram_REG_cfi_is_call;
      ram_2_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_2_ras_top <= ram_REG_ras_top;
      ram_2_ras_idx <= ram_REG_ras_idx;
      ram_2_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h3)) begin
      if (_GEN_20) begin
        ram_3_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_3_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_3_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_3_cfi_mispredicted <= ~_GEN_20 & ram_3_cfi_mispredicted;
      if (_GEN_20) begin
        ram_3_cfi_type <= io_enq_bits_cfi_type;
        ram_3_br_mask <= new_entry_br_mask;
        ram_3_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_3_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_3_ras_top <= io_enq_bits_ras_top;
        ram_3_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_3_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_3_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_3_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_3_cfi_taken <= ram_REG_cfi_taken;
      ram_3_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_3_cfi_type <= ram_REG_cfi_type;
      ram_3_br_mask <= ram_REG_br_mask;
      ram_3_cfi_is_call <= ram_REG_cfi_is_call;
      ram_3_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_3_ras_top <= ram_REG_ras_top;
      ram_3_ras_idx <= ram_REG_ras_idx;
      ram_3_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h4)) begin
      if (_GEN_21) begin
        ram_4_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_4_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_4_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_4_cfi_mispredicted <= ~_GEN_21 & ram_4_cfi_mispredicted;
      if (_GEN_21) begin
        ram_4_cfi_type <= io_enq_bits_cfi_type;
        ram_4_br_mask <= new_entry_br_mask;
        ram_4_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_4_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_4_ras_top <= io_enq_bits_ras_top;
        ram_4_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_4_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_4_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_4_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_4_cfi_taken <= ram_REG_cfi_taken;
      ram_4_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_4_cfi_type <= ram_REG_cfi_type;
      ram_4_br_mask <= ram_REG_br_mask;
      ram_4_cfi_is_call <= ram_REG_cfi_is_call;
      ram_4_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_4_ras_top <= ram_REG_ras_top;
      ram_4_ras_idx <= ram_REG_ras_idx;
      ram_4_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h5)) begin
      if (_GEN_22) begin
        ram_5_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_5_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_5_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_5_cfi_mispredicted <= ~_GEN_22 & ram_5_cfi_mispredicted;
      if (_GEN_22) begin
        ram_5_cfi_type <= io_enq_bits_cfi_type;
        ram_5_br_mask <= new_entry_br_mask;
        ram_5_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_5_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_5_ras_top <= io_enq_bits_ras_top;
        ram_5_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_5_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_5_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_5_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_5_cfi_taken <= ram_REG_cfi_taken;
      ram_5_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_5_cfi_type <= ram_REG_cfi_type;
      ram_5_br_mask <= ram_REG_br_mask;
      ram_5_cfi_is_call <= ram_REG_cfi_is_call;
      ram_5_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_5_ras_top <= ram_REG_ras_top;
      ram_5_ras_idx <= ram_REG_ras_idx;
      ram_5_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h6)) begin
      if (_GEN_23) begin
        ram_6_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_6_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_6_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_6_cfi_mispredicted <= ~_GEN_23 & ram_6_cfi_mispredicted;
      if (_GEN_23) begin
        ram_6_cfi_type <= io_enq_bits_cfi_type;
        ram_6_br_mask <= new_entry_br_mask;
        ram_6_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_6_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_6_ras_top <= io_enq_bits_ras_top;
        ram_6_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_6_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_6_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_6_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_6_cfi_taken <= ram_REG_cfi_taken;
      ram_6_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_6_cfi_type <= ram_REG_cfi_type;
      ram_6_br_mask <= ram_REG_br_mask;
      ram_6_cfi_is_call <= ram_REG_cfi_is_call;
      ram_6_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_6_ras_top <= ram_REG_ras_top;
      ram_6_ras_idx <= ram_REG_ras_idx;
      ram_6_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h7)) begin
      if (_GEN_24) begin
        ram_7_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_7_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_7_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_7_cfi_mispredicted <= ~_GEN_24 & ram_7_cfi_mispredicted;
      if (_GEN_24) begin
        ram_7_cfi_type <= io_enq_bits_cfi_type;
        ram_7_br_mask <= new_entry_br_mask;
        ram_7_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_7_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_7_ras_top <= io_enq_bits_ras_top;
        ram_7_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_7_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_7_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_7_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_7_cfi_taken <= ram_REG_cfi_taken;
      ram_7_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_7_cfi_type <= ram_REG_cfi_type;
      ram_7_br_mask <= ram_REG_br_mask;
      ram_7_cfi_is_call <= ram_REG_cfi_is_call;
      ram_7_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_7_ras_top <= ram_REG_ras_top;
      ram_7_ras_idx <= ram_REG_ras_idx;
      ram_7_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h8)) begin
      if (_GEN_25) begin
        ram_8_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_8_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_8_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_8_cfi_mispredicted <= ~_GEN_25 & ram_8_cfi_mispredicted;
      if (_GEN_25) begin
        ram_8_cfi_type <= io_enq_bits_cfi_type;
        ram_8_br_mask <= new_entry_br_mask;
        ram_8_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_8_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_8_ras_top <= io_enq_bits_ras_top;
        ram_8_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_8_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_8_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_8_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_8_cfi_taken <= ram_REG_cfi_taken;
      ram_8_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_8_cfi_type <= ram_REG_cfi_type;
      ram_8_br_mask <= ram_REG_br_mask;
      ram_8_cfi_is_call <= ram_REG_cfi_is_call;
      ram_8_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_8_ras_top <= ram_REG_ras_top;
      ram_8_ras_idx <= ram_REG_ras_idx;
      ram_8_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h9)) begin
      if (_GEN_26) begin
        ram_9_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_9_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_9_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_9_cfi_mispredicted <= ~_GEN_26 & ram_9_cfi_mispredicted;
      if (_GEN_26) begin
        ram_9_cfi_type <= io_enq_bits_cfi_type;
        ram_9_br_mask <= new_entry_br_mask;
        ram_9_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_9_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_9_ras_top <= io_enq_bits_ras_top;
        ram_9_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_9_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_9_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_9_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_9_cfi_taken <= ram_REG_cfi_taken;
      ram_9_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_9_cfi_type <= ram_REG_cfi_type;
      ram_9_br_mask <= ram_REG_br_mask;
      ram_9_cfi_is_call <= ram_REG_cfi_is_call;
      ram_9_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_9_ras_top <= ram_REG_ras_top;
      ram_9_ras_idx <= ram_REG_ras_idx;
      ram_9_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'hA)) begin
      if (_GEN_27) begin
        ram_10_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_10_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_10_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_10_cfi_mispredicted <= ~_GEN_27 & ram_10_cfi_mispredicted;
      if (_GEN_27) begin
        ram_10_cfi_type <= io_enq_bits_cfi_type;
        ram_10_br_mask <= new_entry_br_mask;
        ram_10_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_10_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_10_ras_top <= io_enq_bits_ras_top;
        ram_10_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_10_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_10_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_10_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_10_cfi_taken <= ram_REG_cfi_taken;
      ram_10_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_10_cfi_type <= ram_REG_cfi_type;
      ram_10_br_mask <= ram_REG_br_mask;
      ram_10_cfi_is_call <= ram_REG_cfi_is_call;
      ram_10_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_10_ras_top <= ram_REG_ras_top;
      ram_10_ras_idx <= ram_REG_ras_idx;
      ram_10_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'hB)) begin
      if (_GEN_28) begin
        ram_11_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_11_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_11_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_11_cfi_mispredicted <= ~_GEN_28 & ram_11_cfi_mispredicted;
      if (_GEN_28) begin
        ram_11_cfi_type <= io_enq_bits_cfi_type;
        ram_11_br_mask <= new_entry_br_mask;
        ram_11_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_11_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_11_ras_top <= io_enq_bits_ras_top;
        ram_11_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_11_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_11_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_11_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_11_cfi_taken <= ram_REG_cfi_taken;
      ram_11_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_11_cfi_type <= ram_REG_cfi_type;
      ram_11_br_mask <= ram_REG_br_mask;
      ram_11_cfi_is_call <= ram_REG_cfi_is_call;
      ram_11_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_11_ras_top <= ram_REG_ras_top;
      ram_11_ras_idx <= ram_REG_ras_idx;
      ram_11_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'hC)) begin
      if (_GEN_29) begin
        ram_12_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_12_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_12_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_12_cfi_mispredicted <= ~_GEN_29 & ram_12_cfi_mispredicted;
      if (_GEN_29) begin
        ram_12_cfi_type <= io_enq_bits_cfi_type;
        ram_12_br_mask <= new_entry_br_mask;
        ram_12_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_12_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_12_ras_top <= io_enq_bits_ras_top;
        ram_12_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_12_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_12_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_12_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_12_cfi_taken <= ram_REG_cfi_taken;
      ram_12_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_12_cfi_type <= ram_REG_cfi_type;
      ram_12_br_mask <= ram_REG_br_mask;
      ram_12_cfi_is_call <= ram_REG_cfi_is_call;
      ram_12_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_12_ras_top <= ram_REG_ras_top;
      ram_12_ras_idx <= ram_REG_ras_idx;
      ram_12_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'hD)) begin
      if (_GEN_30) begin
        ram_13_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_13_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_13_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_13_cfi_mispredicted <= ~_GEN_30 & ram_13_cfi_mispredicted;
      if (_GEN_30) begin
        ram_13_cfi_type <= io_enq_bits_cfi_type;
        ram_13_br_mask <= new_entry_br_mask;
        ram_13_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_13_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_13_ras_top <= io_enq_bits_ras_top;
        ram_13_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_13_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_13_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_13_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_13_cfi_taken <= ram_REG_cfi_taken;
      ram_13_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_13_cfi_type <= ram_REG_cfi_type;
      ram_13_br_mask <= ram_REG_br_mask;
      ram_13_cfi_is_call <= ram_REG_cfi_is_call;
      ram_13_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_13_ras_top <= ram_REG_ras_top;
      ram_13_ras_idx <= ram_REG_ras_idx;
      ram_13_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'hE)) begin
      if (_GEN_31) begin
        ram_14_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_14_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_14_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_14_cfi_mispredicted <= ~_GEN_31 & ram_14_cfi_mispredicted;
      if (_GEN_31) begin
        ram_14_cfi_type <= io_enq_bits_cfi_type;
        ram_14_br_mask <= new_entry_br_mask;
        ram_14_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_14_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_14_ras_top <= io_enq_bits_ras_top;
        ram_14_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_14_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_14_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_14_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_14_cfi_taken <= ram_REG_cfi_taken;
      ram_14_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_14_cfi_type <= ram_REG_cfi_type;
      ram_14_br_mask <= ram_REG_br_mask;
      ram_14_cfi_is_call <= ram_REG_cfi_is_call;
      ram_14_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_14_ras_top <= ram_REG_ras_top;
      ram_14_ras_idx <= ram_REG_ras_idx;
      ram_14_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'hF)) begin
      if (_GEN_32) begin
        ram_15_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_15_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_15_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_15_cfi_mispredicted <= ~_GEN_32 & ram_15_cfi_mispredicted;
      if (_GEN_32) begin
        ram_15_cfi_type <= io_enq_bits_cfi_type;
        ram_15_br_mask <= new_entry_br_mask;
        ram_15_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_15_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_15_ras_top <= io_enq_bits_ras_top;
        ram_15_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_15_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_15_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_15_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_15_cfi_taken <= ram_REG_cfi_taken;
      ram_15_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_15_cfi_type <= ram_REG_cfi_type;
      ram_15_br_mask <= ram_REG_br_mask;
      ram_15_cfi_is_call <= ram_REG_cfi_is_call;
      ram_15_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_15_ras_top <= ram_REG_ras_top;
      ram_15_ras_idx <= ram_REG_ras_idx;
      ram_15_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h10)) begin
      if (_GEN_33) begin
        ram_16_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_16_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_16_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_16_cfi_mispredicted <= ~_GEN_33 & ram_16_cfi_mispredicted;
      if (_GEN_33) begin
        ram_16_cfi_type <= io_enq_bits_cfi_type;
        ram_16_br_mask <= new_entry_br_mask;
        ram_16_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_16_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_16_ras_top <= io_enq_bits_ras_top;
        ram_16_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_16_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_16_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_16_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_16_cfi_taken <= ram_REG_cfi_taken;
      ram_16_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_16_cfi_type <= ram_REG_cfi_type;
      ram_16_br_mask <= ram_REG_br_mask;
      ram_16_cfi_is_call <= ram_REG_cfi_is_call;
      ram_16_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_16_ras_top <= ram_REG_ras_top;
      ram_16_ras_idx <= ram_REG_ras_idx;
      ram_16_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h11)) begin
      if (_GEN_34) begin
        ram_17_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_17_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_17_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_17_cfi_mispredicted <= ~_GEN_34 & ram_17_cfi_mispredicted;
      if (_GEN_34) begin
        ram_17_cfi_type <= io_enq_bits_cfi_type;
        ram_17_br_mask <= new_entry_br_mask;
        ram_17_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_17_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_17_ras_top <= io_enq_bits_ras_top;
        ram_17_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_17_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_17_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_17_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_17_cfi_taken <= ram_REG_cfi_taken;
      ram_17_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_17_cfi_type <= ram_REG_cfi_type;
      ram_17_br_mask <= ram_REG_br_mask;
      ram_17_cfi_is_call <= ram_REG_cfi_is_call;
      ram_17_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_17_ras_top <= ram_REG_ras_top;
      ram_17_ras_idx <= ram_REG_ras_idx;
      ram_17_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h12)) begin
      if (_GEN_35) begin
        ram_18_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_18_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_18_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_18_cfi_mispredicted <= ~_GEN_35 & ram_18_cfi_mispredicted;
      if (_GEN_35) begin
        ram_18_cfi_type <= io_enq_bits_cfi_type;
        ram_18_br_mask <= new_entry_br_mask;
        ram_18_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_18_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_18_ras_top <= io_enq_bits_ras_top;
        ram_18_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_18_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_18_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_18_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_18_cfi_taken <= ram_REG_cfi_taken;
      ram_18_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_18_cfi_type <= ram_REG_cfi_type;
      ram_18_br_mask <= ram_REG_br_mask;
      ram_18_cfi_is_call <= ram_REG_cfi_is_call;
      ram_18_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_18_ras_top <= ram_REG_ras_top;
      ram_18_ras_idx <= ram_REG_ras_idx;
      ram_18_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h13)) begin
      if (_GEN_36) begin
        ram_19_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_19_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_19_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_19_cfi_mispredicted <= ~_GEN_36 & ram_19_cfi_mispredicted;
      if (_GEN_36) begin
        ram_19_cfi_type <= io_enq_bits_cfi_type;
        ram_19_br_mask <= new_entry_br_mask;
        ram_19_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_19_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_19_ras_top <= io_enq_bits_ras_top;
        ram_19_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_19_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_19_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_19_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_19_cfi_taken <= ram_REG_cfi_taken;
      ram_19_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_19_cfi_type <= ram_REG_cfi_type;
      ram_19_br_mask <= ram_REG_br_mask;
      ram_19_cfi_is_call <= ram_REG_cfi_is_call;
      ram_19_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_19_ras_top <= ram_REG_ras_top;
      ram_19_ras_idx <= ram_REG_ras_idx;
      ram_19_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h14)) begin
      if (_GEN_37) begin
        ram_20_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_20_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_20_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_20_cfi_mispredicted <= ~_GEN_37 & ram_20_cfi_mispredicted;
      if (_GEN_37) begin
        ram_20_cfi_type <= io_enq_bits_cfi_type;
        ram_20_br_mask <= new_entry_br_mask;
        ram_20_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_20_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_20_ras_top <= io_enq_bits_ras_top;
        ram_20_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_20_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_20_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_20_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_20_cfi_taken <= ram_REG_cfi_taken;
      ram_20_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_20_cfi_type <= ram_REG_cfi_type;
      ram_20_br_mask <= ram_REG_br_mask;
      ram_20_cfi_is_call <= ram_REG_cfi_is_call;
      ram_20_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_20_ras_top <= ram_REG_ras_top;
      ram_20_ras_idx <= ram_REG_ras_idx;
      ram_20_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h15)) begin
      if (_GEN_38) begin
        ram_21_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_21_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_21_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_21_cfi_mispredicted <= ~_GEN_38 & ram_21_cfi_mispredicted;
      if (_GEN_38) begin
        ram_21_cfi_type <= io_enq_bits_cfi_type;
        ram_21_br_mask <= new_entry_br_mask;
        ram_21_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_21_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_21_ras_top <= io_enq_bits_ras_top;
        ram_21_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_21_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_21_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_21_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_21_cfi_taken <= ram_REG_cfi_taken;
      ram_21_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_21_cfi_type <= ram_REG_cfi_type;
      ram_21_br_mask <= ram_REG_br_mask;
      ram_21_cfi_is_call <= ram_REG_cfi_is_call;
      ram_21_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_21_ras_top <= ram_REG_ras_top;
      ram_21_ras_idx <= ram_REG_ras_idx;
      ram_21_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h16)) begin
      if (_GEN_39) begin
        ram_22_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_22_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_22_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_22_cfi_mispredicted <= ~_GEN_39 & ram_22_cfi_mispredicted;
      if (_GEN_39) begin
        ram_22_cfi_type <= io_enq_bits_cfi_type;
        ram_22_br_mask <= new_entry_br_mask;
        ram_22_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_22_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_22_ras_top <= io_enq_bits_ras_top;
        ram_22_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_22_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_22_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_22_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_22_cfi_taken <= ram_REG_cfi_taken;
      ram_22_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_22_cfi_type <= ram_REG_cfi_type;
      ram_22_br_mask <= ram_REG_br_mask;
      ram_22_cfi_is_call <= ram_REG_cfi_is_call;
      ram_22_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_22_ras_top <= ram_REG_ras_top;
      ram_22_ras_idx <= ram_REG_ras_idx;
      ram_22_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h17)) begin
      if (_GEN_41) begin
        ram_23_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_23_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_23_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_23_cfi_mispredicted <= ~_GEN_41 & ram_23_cfi_mispredicted;
      if (_GEN_41) begin
        ram_23_cfi_type <= io_enq_bits_cfi_type;
        ram_23_br_mask <= new_entry_br_mask;
        ram_23_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_23_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_23_ras_top <= io_enq_bits_ras_top;
        ram_23_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_23_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_23_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_23_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_23_cfi_taken <= ram_REG_cfi_taken;
      ram_23_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_23_cfi_type <= ram_REG_cfi_type;
      ram_23_br_mask <= ram_REG_br_mask;
      ram_23_cfi_is_call <= ram_REG_cfi_is_call;
      ram_23_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_23_ras_top <= ram_REG_ras_top;
      ram_23_ras_idx <= ram_REG_ras_idx;
      ram_23_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h18)) begin
      if (_GEN_42) begin
        ram_24_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_24_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_24_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_24_cfi_mispredicted <= ~_GEN_42 & ram_24_cfi_mispredicted;
      if (_GEN_42) begin
        ram_24_cfi_type <= io_enq_bits_cfi_type;
        ram_24_br_mask <= new_entry_br_mask;
        ram_24_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_24_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_24_ras_top <= io_enq_bits_ras_top;
        ram_24_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_24_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_24_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_24_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_24_cfi_taken <= ram_REG_cfi_taken;
      ram_24_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_24_cfi_type <= ram_REG_cfi_type;
      ram_24_br_mask <= ram_REG_br_mask;
      ram_24_cfi_is_call <= ram_REG_cfi_is_call;
      ram_24_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_24_ras_top <= ram_REG_ras_top;
      ram_24_ras_idx <= ram_REG_ras_idx;
      ram_24_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h19)) begin
      if (_GEN_43) begin
        ram_25_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_25_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_25_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_25_cfi_mispredicted <= ~_GEN_43 & ram_25_cfi_mispredicted;
      if (_GEN_43) begin
        ram_25_cfi_type <= io_enq_bits_cfi_type;
        ram_25_br_mask <= new_entry_br_mask;
        ram_25_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_25_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_25_ras_top <= io_enq_bits_ras_top;
        ram_25_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_25_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_25_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_25_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_25_cfi_taken <= ram_REG_cfi_taken;
      ram_25_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_25_cfi_type <= ram_REG_cfi_type;
      ram_25_br_mask <= ram_REG_br_mask;
      ram_25_cfi_is_call <= ram_REG_cfi_is_call;
      ram_25_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_25_ras_top <= ram_REG_ras_top;
      ram_25_ras_idx <= ram_REG_ras_idx;
      ram_25_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h1A)) begin
      if (_GEN_44) begin
        ram_26_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_26_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_26_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_26_cfi_mispredicted <= ~_GEN_44 & ram_26_cfi_mispredicted;
      if (_GEN_44) begin
        ram_26_cfi_type <= io_enq_bits_cfi_type;
        ram_26_br_mask <= new_entry_br_mask;
        ram_26_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_26_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_26_ras_top <= io_enq_bits_ras_top;
        ram_26_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_26_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_26_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_26_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_26_cfi_taken <= ram_REG_cfi_taken;
      ram_26_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_26_cfi_type <= ram_REG_cfi_type;
      ram_26_br_mask <= ram_REG_br_mask;
      ram_26_cfi_is_call <= ram_REG_cfi_is_call;
      ram_26_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_26_ras_top <= ram_REG_ras_top;
      ram_26_ras_idx <= ram_REG_ras_idx;
      ram_26_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h1B)) begin
      if (_GEN_45) begin
        ram_27_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_27_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_27_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_27_cfi_mispredicted <= ~_GEN_45 & ram_27_cfi_mispredicted;
      if (_GEN_45) begin
        ram_27_cfi_type <= io_enq_bits_cfi_type;
        ram_27_br_mask <= new_entry_br_mask;
        ram_27_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_27_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_27_ras_top <= io_enq_bits_ras_top;
        ram_27_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_27_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_27_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_27_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_27_cfi_taken <= ram_REG_cfi_taken;
      ram_27_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_27_cfi_type <= ram_REG_cfi_type;
      ram_27_br_mask <= ram_REG_br_mask;
      ram_27_cfi_is_call <= ram_REG_cfi_is_call;
      ram_27_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_27_ras_top <= ram_REG_ras_top;
      ram_27_ras_idx <= ram_REG_ras_idx;
      ram_27_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h1C)) begin
      if (_GEN_46) begin
        ram_28_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_28_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_28_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_28_cfi_mispredicted <= ~_GEN_46 & ram_28_cfi_mispredicted;
      if (_GEN_46) begin
        ram_28_cfi_type <= io_enq_bits_cfi_type;
        ram_28_br_mask <= new_entry_br_mask;
        ram_28_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_28_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_28_ras_top <= io_enq_bits_ras_top;
        ram_28_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_28_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_28_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_28_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_28_cfi_taken <= ram_REG_cfi_taken;
      ram_28_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_28_cfi_type <= ram_REG_cfi_type;
      ram_28_br_mask <= ram_REG_br_mask;
      ram_28_cfi_is_call <= ram_REG_cfi_is_call;
      ram_28_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_28_ras_top <= ram_REG_ras_top;
      ram_28_ras_idx <= ram_REG_ras_idx;
      ram_28_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h1D)) begin
      if (_GEN_47) begin
        ram_29_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_29_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_29_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_29_cfi_mispredicted <= ~_GEN_47 & ram_29_cfi_mispredicted;
      if (_GEN_47) begin
        ram_29_cfi_type <= io_enq_bits_cfi_type;
        ram_29_br_mask <= new_entry_br_mask;
        ram_29_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_29_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_29_ras_top <= io_enq_bits_ras_top;
        ram_29_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_29_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_29_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_29_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_29_cfi_taken <= ram_REG_cfi_taken;
      ram_29_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_29_cfi_type <= ram_REG_cfi_type;
      ram_29_br_mask <= ram_REG_br_mask;
      ram_29_cfi_is_call <= ram_REG_cfi_is_call;
      ram_29_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_29_ras_top <= ram_REG_ras_top;
      ram_29_ras_idx <= ram_REG_ras_idx;
      ram_29_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h1E)) begin
      if (_GEN_48) begin
        ram_30_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_30_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_30_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_30_cfi_mispredicted <= ~_GEN_48 & ram_30_cfi_mispredicted;
      if (_GEN_48) begin
        ram_30_cfi_type <= io_enq_bits_cfi_type;
        ram_30_br_mask <= new_entry_br_mask;
        ram_30_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_30_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_30_ras_top <= io_enq_bits_ras_top;
        ram_30_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_30_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_30_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_30_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_30_cfi_taken <= ram_REG_cfi_taken;
      ram_30_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_30_cfi_type <= ram_REG_cfi_type;
      ram_30_br_mask <= ram_REG_br_mask;
      ram_30_cfi_is_call <= ram_REG_cfi_is_call;
      ram_30_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_30_ras_top <= ram_REG_ras_top;
      ram_30_ras_idx <= ram_REG_ras_idx;
      ram_30_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h1F)) begin
      if (_GEN_49) begin
        ram_31_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_31_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_31_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_31_cfi_mispredicted <= ~_GEN_49 & ram_31_cfi_mispredicted;
      if (_GEN_49) begin
        ram_31_cfi_type <= io_enq_bits_cfi_type;
        ram_31_br_mask <= new_entry_br_mask;
        ram_31_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_31_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_31_ras_top <= io_enq_bits_ras_top;
        ram_31_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_31_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_31_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_31_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_31_cfi_taken <= ram_REG_cfi_taken;
      ram_31_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_31_cfi_type <= ram_REG_cfi_type;
      ram_31_br_mask <= ram_REG_br_mask;
      ram_31_cfi_is_call <= ram_REG_cfi_is_call;
      ram_31_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_31_ras_top <= ram_REG_ras_top;
      ram_31_ras_idx <= ram_REG_ras_idx;
      ram_31_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h20)) begin
      if (_GEN_50) begin
        ram_32_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_32_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_32_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_32_cfi_mispredicted <= ~_GEN_50 & ram_32_cfi_mispredicted;
      if (_GEN_50) begin
        ram_32_cfi_type <= io_enq_bits_cfi_type;
        ram_32_br_mask <= new_entry_br_mask;
        ram_32_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_32_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_32_ras_top <= io_enq_bits_ras_top;
        ram_32_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_32_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_32_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_32_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_32_cfi_taken <= ram_REG_cfi_taken;
      ram_32_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_32_cfi_type <= ram_REG_cfi_type;
      ram_32_br_mask <= ram_REG_br_mask;
      ram_32_cfi_is_call <= ram_REG_cfi_is_call;
      ram_32_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_32_ras_top <= ram_REG_ras_top;
      ram_32_ras_idx <= ram_REG_ras_idx;
      ram_32_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h21)) begin
      if (_GEN_51) begin
        ram_33_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_33_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_33_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_33_cfi_mispredicted <= ~_GEN_51 & ram_33_cfi_mispredicted;
      if (_GEN_51) begin
        ram_33_cfi_type <= io_enq_bits_cfi_type;
        ram_33_br_mask <= new_entry_br_mask;
        ram_33_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_33_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_33_ras_top <= io_enq_bits_ras_top;
        ram_33_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_33_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_33_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_33_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_33_cfi_taken <= ram_REG_cfi_taken;
      ram_33_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_33_cfi_type <= ram_REG_cfi_type;
      ram_33_br_mask <= ram_REG_br_mask;
      ram_33_cfi_is_call <= ram_REG_cfi_is_call;
      ram_33_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_33_ras_top <= ram_REG_ras_top;
      ram_33_ras_idx <= ram_REG_ras_idx;
      ram_33_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h22)) begin
      if (_GEN_52) begin
        ram_34_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_34_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_34_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_34_cfi_mispredicted <= ~_GEN_52 & ram_34_cfi_mispredicted;
      if (_GEN_52) begin
        ram_34_cfi_type <= io_enq_bits_cfi_type;
        ram_34_br_mask <= new_entry_br_mask;
        ram_34_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_34_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_34_ras_top <= io_enq_bits_ras_top;
        ram_34_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_34_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_34_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_34_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_34_cfi_taken <= ram_REG_cfi_taken;
      ram_34_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_34_cfi_type <= ram_REG_cfi_type;
      ram_34_br_mask <= ram_REG_br_mask;
      ram_34_cfi_is_call <= ram_REG_cfi_is_call;
      ram_34_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_34_ras_top <= ram_REG_ras_top;
      ram_34_ras_idx <= ram_REG_ras_idx;
      ram_34_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h23)) begin
      if (_GEN_53) begin
        ram_35_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_35_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_35_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_35_cfi_mispredicted <= ~_GEN_53 & ram_35_cfi_mispredicted;
      if (_GEN_53) begin
        ram_35_cfi_type <= io_enq_bits_cfi_type;
        ram_35_br_mask <= new_entry_br_mask;
        ram_35_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_35_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_35_ras_top <= io_enq_bits_ras_top;
        ram_35_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_35_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_35_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_35_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_35_cfi_taken <= ram_REG_cfi_taken;
      ram_35_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_35_cfi_type <= ram_REG_cfi_type;
      ram_35_br_mask <= ram_REG_br_mask;
      ram_35_cfi_is_call <= ram_REG_cfi_is_call;
      ram_35_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_35_ras_top <= ram_REG_ras_top;
      ram_35_ras_idx <= ram_REG_ras_idx;
      ram_35_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h24)) begin
      if (_GEN_54) begin
        ram_36_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_36_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_36_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_36_cfi_mispredicted <= ~_GEN_54 & ram_36_cfi_mispredicted;
      if (_GEN_54) begin
        ram_36_cfi_type <= io_enq_bits_cfi_type;
        ram_36_br_mask <= new_entry_br_mask;
        ram_36_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_36_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_36_ras_top <= io_enq_bits_ras_top;
        ram_36_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_36_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_36_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_36_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_36_cfi_taken <= ram_REG_cfi_taken;
      ram_36_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_36_cfi_type <= ram_REG_cfi_type;
      ram_36_br_mask <= ram_REG_br_mask;
      ram_36_cfi_is_call <= ram_REG_cfi_is_call;
      ram_36_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_36_ras_top <= ram_REG_ras_top;
      ram_36_ras_idx <= ram_REG_ras_idx;
      ram_36_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h25)) begin
      if (_GEN_55) begin
        ram_37_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_37_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_37_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_37_cfi_mispredicted <= ~_GEN_55 & ram_37_cfi_mispredicted;
      if (_GEN_55) begin
        ram_37_cfi_type <= io_enq_bits_cfi_type;
        ram_37_br_mask <= new_entry_br_mask;
        ram_37_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_37_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_37_ras_top <= io_enq_bits_ras_top;
        ram_37_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_37_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_37_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_37_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_37_cfi_taken <= ram_REG_cfi_taken;
      ram_37_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_37_cfi_type <= ram_REG_cfi_type;
      ram_37_br_mask <= ram_REG_br_mask;
      ram_37_cfi_is_call <= ram_REG_cfi_is_call;
      ram_37_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_37_ras_top <= ram_REG_ras_top;
      ram_37_ras_idx <= ram_REG_ras_idx;
      ram_37_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h26)) begin
      if (_GEN_56) begin
        ram_38_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_38_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_38_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_38_cfi_mispredicted <= ~_GEN_56 & ram_38_cfi_mispredicted;
      if (_GEN_56) begin
        ram_38_cfi_type <= io_enq_bits_cfi_type;
        ram_38_br_mask <= new_entry_br_mask;
        ram_38_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_38_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_38_ras_top <= io_enq_bits_ras_top;
        ram_38_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_38_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_38_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_38_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_38_cfi_taken <= ram_REG_cfi_taken;
      ram_38_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_38_cfi_type <= ram_REG_cfi_type;
      ram_38_br_mask <= ram_REG_br_mask;
      ram_38_cfi_is_call <= ram_REG_cfi_is_call;
      ram_38_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_38_ras_top <= ram_REG_ras_top;
      ram_38_ras_idx <= ram_REG_ras_idx;
      ram_38_start_bank <= ram_REG_start_bank;
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h27)) begin
      if (_GEN_57) begin
        ram_39_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
        ram_39_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
        ram_39_cfi_taken <= io_enq_bits_cfi_idx_valid;
      end
      ram_39_cfi_mispredicted <= ~_GEN_57 & ram_39_cfi_mispredicted;
      if (_GEN_57) begin
        ram_39_cfi_type <= io_enq_bits_cfi_type;
        ram_39_br_mask <= new_entry_br_mask;
        ram_39_cfi_is_call <= io_enq_bits_cfi_is_call;
        ram_39_cfi_is_ret <= io_enq_bits_cfi_is_ret;
        ram_39_ras_top <= io_enq_bits_ras_top;
        ram_39_ras_idx <= io_enq_bits_ghist_ras_idx;
        ram_39_start_bank <= io_enq_bits_pc[3];
      end
    end
    else begin
      ram_39_cfi_idx_valid <= ram_REG_cfi_idx_valid;
      ram_39_cfi_idx_bits <= ram_REG_cfi_idx_bits;
      ram_39_cfi_taken <= ram_REG_cfi_taken;
      ram_39_cfi_mispredicted <= ram_REG_cfi_mispredicted;
      ram_39_cfi_type <= ram_REG_cfi_type;
      ram_39_br_mask <= ram_REG_br_mask;
      ram_39_cfi_is_call <= ram_REG_cfi_is_call;
      ram_39_cfi_is_ret <= ram_REG_cfi_is_ret;
      ram_39_ras_top <= ram_REG_ras_top;
      ram_39_ras_idx <= ram_REG_ras_idx;
      ram_39_start_bank <= ram_REG_start_bank;
    end
    io_ras_update_REG <= io_redirect_valid;
    if (io_redirect_valid) begin
      if (_GEN_97) begin
        io_ras_update_pc_REG <= ram_39_ras_top;
        io_ras_update_idx_REG <= ram_39_ras_idx;
      end
      else if (_GEN_96) begin
        io_ras_update_pc_REG <= ram_38_ras_top;
        io_ras_update_idx_REG <= ram_38_ras_idx;
      end
      else if (_GEN_95) begin
        io_ras_update_pc_REG <= ram_37_ras_top;
        io_ras_update_idx_REG <= ram_37_ras_idx;
      end
      else if (_GEN_94) begin
        io_ras_update_pc_REG <= ram_36_ras_top;
        io_ras_update_idx_REG <= ram_36_ras_idx;
      end
      else if (_GEN_93) begin
        io_ras_update_pc_REG <= ram_35_ras_top;
        io_ras_update_idx_REG <= ram_35_ras_idx;
      end
      else if (_GEN_92) begin
        io_ras_update_pc_REG <= ram_34_ras_top;
        io_ras_update_idx_REG <= ram_34_ras_idx;
      end
      else if (_GEN_91) begin
        io_ras_update_pc_REG <= ram_33_ras_top;
        io_ras_update_idx_REG <= ram_33_ras_idx;
      end
      else if (_GEN_90) begin
        io_ras_update_pc_REG <= ram_32_ras_top;
        io_ras_update_idx_REG <= ram_32_ras_idx;
      end
      else if (_GEN_89) begin
        io_ras_update_pc_REG <= ram_31_ras_top;
        io_ras_update_idx_REG <= ram_31_ras_idx;
      end
      else if (_GEN_88) begin
        io_ras_update_pc_REG <= ram_30_ras_top;
        io_ras_update_idx_REG <= ram_30_ras_idx;
      end
      else if (_GEN_87) begin
        io_ras_update_pc_REG <= ram_29_ras_top;
        io_ras_update_idx_REG <= ram_29_ras_idx;
      end
      else if (_GEN_86) begin
        io_ras_update_pc_REG <= ram_28_ras_top;
        io_ras_update_idx_REG <= ram_28_ras_idx;
      end
      else if (_GEN_85) begin
        io_ras_update_pc_REG <= ram_27_ras_top;
        io_ras_update_idx_REG <= ram_27_ras_idx;
      end
      else if (_GEN_84) begin
        io_ras_update_pc_REG <= ram_26_ras_top;
        io_ras_update_idx_REG <= ram_26_ras_idx;
      end
      else if (_GEN_83) begin
        io_ras_update_pc_REG <= ram_25_ras_top;
        io_ras_update_idx_REG <= ram_25_ras_idx;
      end
      else if (_GEN_82) begin
        io_ras_update_pc_REG <= ram_24_ras_top;
        io_ras_update_idx_REG <= ram_24_ras_idx;
      end
      else if (_GEN_81) begin
        io_ras_update_pc_REG <= ram_23_ras_top;
        io_ras_update_idx_REG <= ram_23_ras_idx;
      end
      else if (_GEN_80) begin
        io_ras_update_pc_REG <= ram_22_ras_top;
        io_ras_update_idx_REG <= ram_22_ras_idx;
      end
      else if (_GEN_79) begin
        io_ras_update_pc_REG <= ram_21_ras_top;
        io_ras_update_idx_REG <= ram_21_ras_idx;
      end
      else if (_GEN_78) begin
        io_ras_update_pc_REG <= ram_20_ras_top;
        io_ras_update_idx_REG <= ram_20_ras_idx;
      end
      else if (_GEN_77) begin
        io_ras_update_pc_REG <= ram_19_ras_top;
        io_ras_update_idx_REG <= ram_19_ras_idx;
      end
      else if (_GEN_76) begin
        io_ras_update_pc_REG <= ram_18_ras_top;
        io_ras_update_idx_REG <= ram_18_ras_idx;
      end
      else if (_GEN_75) begin
        io_ras_update_pc_REG <= ram_17_ras_top;
        io_ras_update_idx_REG <= ram_17_ras_idx;
      end
      else if (_GEN_74) begin
        io_ras_update_pc_REG <= ram_16_ras_top;
        io_ras_update_idx_REG <= ram_16_ras_idx;
      end
      else if (_GEN_73) begin
        io_ras_update_pc_REG <= ram_15_ras_top;
        io_ras_update_idx_REG <= ram_15_ras_idx;
      end
      else if (_GEN_72) begin
        io_ras_update_pc_REG <= ram_14_ras_top;
        io_ras_update_idx_REG <= ram_14_ras_idx;
      end
      else if (_GEN_71) begin
        io_ras_update_pc_REG <= ram_13_ras_top;
        io_ras_update_idx_REG <= ram_13_ras_idx;
      end
      else if (_GEN_70) begin
        io_ras_update_pc_REG <= ram_12_ras_top;
        io_ras_update_idx_REG <= ram_12_ras_idx;
      end
      else if (_GEN_69) begin
        io_ras_update_pc_REG <= ram_11_ras_top;
        io_ras_update_idx_REG <= ram_11_ras_idx;
      end
      else if (_GEN_68) begin
        io_ras_update_pc_REG <= ram_10_ras_top;
        io_ras_update_idx_REG <= ram_10_ras_idx;
      end
      else if (_GEN_67) begin
        io_ras_update_pc_REG <= ram_9_ras_top;
        io_ras_update_idx_REG <= ram_9_ras_idx;
      end
      else if (_GEN_66) begin
        io_ras_update_pc_REG <= ram_8_ras_top;
        io_ras_update_idx_REG <= ram_8_ras_idx;
      end
      else if (_GEN_65) begin
        io_ras_update_pc_REG <= ram_7_ras_top;
        io_ras_update_idx_REG <= ram_7_ras_idx;
      end
      else if (_GEN_64) begin
        io_ras_update_pc_REG <= ram_6_ras_top;
        io_ras_update_idx_REG <= ram_6_ras_idx;
      end
      else if (_GEN_63) begin
        io_ras_update_pc_REG <= ram_5_ras_top;
        io_ras_update_idx_REG <= ram_5_ras_idx;
      end
      else if (_GEN_62) begin
        io_ras_update_pc_REG <= ram_4_ras_top;
        io_ras_update_idx_REG <= ram_4_ras_idx;
      end
      else if (_GEN_61) begin
        io_ras_update_pc_REG <= ram_3_ras_top;
        io_ras_update_idx_REG <= ram_3_ras_idx;
      end
      else if (_GEN_60) begin
        io_ras_update_pc_REG <= ram_2_ras_top;
        io_ras_update_idx_REG <= ram_2_ras_idx;
      end
      else if (_GEN_59) begin
        io_ras_update_pc_REG <= ram_1_ras_top;
        io_ras_update_idx_REG <= ram_1_ras_idx;
      end
      else begin
        io_ras_update_pc_REG <= ram_0_ras_top;
        io_ras_update_idx_REG <= ram_0_ras_idx;
      end
    end
    else begin
      io_ras_update_pc_REG <= 40'h0;
      io_ras_update_idx_REG <= 5'h0;
      if (REG)
        bpd_repair_idx <= bpd_repair_idx_REG;
      else if (bpd_update_mispredict) begin
        if (wrap)
          bpd_repair_idx <= 6'h0;
        else
          bpd_repair_idx <= _bpd_repair_idx_T_6;
      end
      else if (_GEN_58) begin
        if (wrap)
          bpd_repair_idx <= 6'h0;
        else
          bpd_repair_idx <= _bpd_repair_idx_T_6;
      end
      else if (bpd_update_repair) begin
        if (wrap)
          bpd_repair_idx <= 6'h0;
        else
          bpd_repair_idx <= _bpd_repair_idx_T_6;
      end
    end
    if (io_redirect_valid | ~REG) begin
    end
    else
      bpd_end_idx <= bpd_end_idx_REG;
    if (io_redirect_valid | REG | bpd_update_mispredict | ~_GEN_58) begin
    end
    else
      bpd_repair_pc <= bpd_pc;
    if (bpd_idx == 6'h27) begin
      bpd_entry_cfi_idx_valid <= ram_39_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_39_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_39_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_39_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_39_cfi_type;
      bpd_entry_br_mask <= ram_39_br_mask;
      bpd_pc <= pcs_39;
    end
    else if (bpd_idx == 6'h26) begin
      bpd_entry_cfi_idx_valid <= ram_38_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_38_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_38_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_38_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_38_cfi_type;
      bpd_entry_br_mask <= ram_38_br_mask;
      bpd_pc <= pcs_38;
    end
    else if (bpd_idx == 6'h25) begin
      bpd_entry_cfi_idx_valid <= ram_37_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_37_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_37_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_37_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_37_cfi_type;
      bpd_entry_br_mask <= ram_37_br_mask;
      bpd_pc <= pcs_37;
    end
    else if (bpd_idx == 6'h24) begin
      bpd_entry_cfi_idx_valid <= ram_36_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_36_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_36_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_36_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_36_cfi_type;
      bpd_entry_br_mask <= ram_36_br_mask;
      bpd_pc <= pcs_36;
    end
    else if (bpd_idx == 6'h23) begin
      bpd_entry_cfi_idx_valid <= ram_35_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_35_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_35_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_35_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_35_cfi_type;
      bpd_entry_br_mask <= ram_35_br_mask;
      bpd_pc <= pcs_35;
    end
    else if (bpd_idx == 6'h22) begin
      bpd_entry_cfi_idx_valid <= ram_34_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_34_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_34_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_34_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_34_cfi_type;
      bpd_entry_br_mask <= ram_34_br_mask;
      bpd_pc <= pcs_34;
    end
    else if (bpd_idx == 6'h21) begin
      bpd_entry_cfi_idx_valid <= ram_33_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_33_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_33_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_33_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_33_cfi_type;
      bpd_entry_br_mask <= ram_33_br_mask;
      bpd_pc <= pcs_33;
    end
    else if (bpd_idx == 6'h20) begin
      bpd_entry_cfi_idx_valid <= ram_32_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_32_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_32_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_32_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_32_cfi_type;
      bpd_entry_br_mask <= ram_32_br_mask;
      bpd_pc <= pcs_32;
    end
    else if (bpd_idx == 6'h1F) begin
      bpd_entry_cfi_idx_valid <= ram_31_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_31_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_31_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_31_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_31_cfi_type;
      bpd_entry_br_mask <= ram_31_br_mask;
      bpd_pc <= pcs_31;
    end
    else if (bpd_idx == 6'h1E) begin
      bpd_entry_cfi_idx_valid <= ram_30_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_30_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_30_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_30_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_30_cfi_type;
      bpd_entry_br_mask <= ram_30_br_mask;
      bpd_pc <= pcs_30;
    end
    else if (bpd_idx == 6'h1D) begin
      bpd_entry_cfi_idx_valid <= ram_29_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_29_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_29_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_29_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_29_cfi_type;
      bpd_entry_br_mask <= ram_29_br_mask;
      bpd_pc <= pcs_29;
    end
    else if (bpd_idx == 6'h1C) begin
      bpd_entry_cfi_idx_valid <= ram_28_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_28_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_28_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_28_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_28_cfi_type;
      bpd_entry_br_mask <= ram_28_br_mask;
      bpd_pc <= pcs_28;
    end
    else if (bpd_idx == 6'h1B) begin
      bpd_entry_cfi_idx_valid <= ram_27_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_27_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_27_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_27_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_27_cfi_type;
      bpd_entry_br_mask <= ram_27_br_mask;
      bpd_pc <= pcs_27;
    end
    else if (bpd_idx == 6'h1A) begin
      bpd_entry_cfi_idx_valid <= ram_26_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_26_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_26_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_26_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_26_cfi_type;
      bpd_entry_br_mask <= ram_26_br_mask;
      bpd_pc <= pcs_26;
    end
    else if (bpd_idx == 6'h19) begin
      bpd_entry_cfi_idx_valid <= ram_25_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_25_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_25_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_25_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_25_cfi_type;
      bpd_entry_br_mask <= ram_25_br_mask;
      bpd_pc <= pcs_25;
    end
    else if (bpd_idx == 6'h18) begin
      bpd_entry_cfi_idx_valid <= ram_24_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_24_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_24_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_24_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_24_cfi_type;
      bpd_entry_br_mask <= ram_24_br_mask;
      bpd_pc <= pcs_24;
    end
    else if (bpd_idx == 6'h17) begin
      bpd_entry_cfi_idx_valid <= ram_23_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_23_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_23_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_23_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_23_cfi_type;
      bpd_entry_br_mask <= ram_23_br_mask;
      bpd_pc <= pcs_23;
    end
    else if (bpd_idx == 6'h16) begin
      bpd_entry_cfi_idx_valid <= ram_22_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_22_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_22_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_22_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_22_cfi_type;
      bpd_entry_br_mask <= ram_22_br_mask;
      bpd_pc <= pcs_22;
    end
    else if (bpd_idx == 6'h15) begin
      bpd_entry_cfi_idx_valid <= ram_21_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_21_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_21_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_21_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_21_cfi_type;
      bpd_entry_br_mask <= ram_21_br_mask;
      bpd_pc <= pcs_21;
    end
    else if (bpd_idx == 6'h14) begin
      bpd_entry_cfi_idx_valid <= ram_20_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_20_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_20_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_20_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_20_cfi_type;
      bpd_entry_br_mask <= ram_20_br_mask;
      bpd_pc <= pcs_20;
    end
    else if (bpd_idx == 6'h13) begin
      bpd_entry_cfi_idx_valid <= ram_19_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_19_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_19_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_19_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_19_cfi_type;
      bpd_entry_br_mask <= ram_19_br_mask;
      bpd_pc <= pcs_19;
    end
    else if (bpd_idx == 6'h12) begin
      bpd_entry_cfi_idx_valid <= ram_18_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_18_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_18_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_18_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_18_cfi_type;
      bpd_entry_br_mask <= ram_18_br_mask;
      bpd_pc <= pcs_18;
    end
    else if (bpd_idx == 6'h11) begin
      bpd_entry_cfi_idx_valid <= ram_17_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_17_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_17_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_17_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_17_cfi_type;
      bpd_entry_br_mask <= ram_17_br_mask;
      bpd_pc <= pcs_17;
    end
    else if (bpd_idx == 6'h10) begin
      bpd_entry_cfi_idx_valid <= ram_16_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_16_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_16_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_16_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_16_cfi_type;
      bpd_entry_br_mask <= ram_16_br_mask;
      bpd_pc <= pcs_16;
    end
    else if (bpd_idx == 6'hF) begin
      bpd_entry_cfi_idx_valid <= ram_15_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_15_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_15_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_15_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_15_cfi_type;
      bpd_entry_br_mask <= ram_15_br_mask;
      bpd_pc <= pcs_15;
    end
    else if (bpd_idx == 6'hE) begin
      bpd_entry_cfi_idx_valid <= ram_14_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_14_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_14_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_14_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_14_cfi_type;
      bpd_entry_br_mask <= ram_14_br_mask;
      bpd_pc <= pcs_14;
    end
    else if (bpd_idx == 6'hD) begin
      bpd_entry_cfi_idx_valid <= ram_13_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_13_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_13_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_13_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_13_cfi_type;
      bpd_entry_br_mask <= ram_13_br_mask;
      bpd_pc <= pcs_13;
    end
    else if (bpd_idx == 6'hC) begin
      bpd_entry_cfi_idx_valid <= ram_12_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_12_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_12_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_12_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_12_cfi_type;
      bpd_entry_br_mask <= ram_12_br_mask;
      bpd_pc <= pcs_12;
    end
    else if (bpd_idx == 6'hB) begin
      bpd_entry_cfi_idx_valid <= ram_11_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_11_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_11_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_11_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_11_cfi_type;
      bpd_entry_br_mask <= ram_11_br_mask;
      bpd_pc <= pcs_11;
    end
    else if (bpd_idx == 6'hA) begin
      bpd_entry_cfi_idx_valid <= ram_10_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_10_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_10_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_10_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_10_cfi_type;
      bpd_entry_br_mask <= ram_10_br_mask;
      bpd_pc <= pcs_10;
    end
    else if (bpd_idx == 6'h9) begin
      bpd_entry_cfi_idx_valid <= ram_9_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_9_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_9_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_9_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_9_cfi_type;
      bpd_entry_br_mask <= ram_9_br_mask;
      bpd_pc <= pcs_9;
    end
    else if (bpd_idx == 6'h8) begin
      bpd_entry_cfi_idx_valid <= ram_8_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_8_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_8_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_8_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_8_cfi_type;
      bpd_entry_br_mask <= ram_8_br_mask;
      bpd_pc <= pcs_8;
    end
    else if (bpd_idx == 6'h7) begin
      bpd_entry_cfi_idx_valid <= ram_7_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_7_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_7_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_7_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_7_cfi_type;
      bpd_entry_br_mask <= ram_7_br_mask;
      bpd_pc <= pcs_7;
    end
    else if (bpd_idx == 6'h6) begin
      bpd_entry_cfi_idx_valid <= ram_6_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_6_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_6_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_6_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_6_cfi_type;
      bpd_entry_br_mask <= ram_6_br_mask;
      bpd_pc <= pcs_6;
    end
    else if (bpd_idx == 6'h5) begin
      bpd_entry_cfi_idx_valid <= ram_5_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_5_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_5_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_5_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_5_cfi_type;
      bpd_entry_br_mask <= ram_5_br_mask;
      bpd_pc <= pcs_5;
    end
    else if (bpd_idx == 6'h4) begin
      bpd_entry_cfi_idx_valid <= ram_4_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_4_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_4_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_4_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_4_cfi_type;
      bpd_entry_br_mask <= ram_4_br_mask;
      bpd_pc <= pcs_4;
    end
    else if (bpd_idx == 6'h3) begin
      bpd_entry_cfi_idx_valid <= ram_3_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_3_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_3_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_3_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_3_cfi_type;
      bpd_entry_br_mask <= ram_3_br_mask;
      bpd_pc <= pcs_3;
    end
    else if (bpd_idx == 6'h2) begin
      bpd_entry_cfi_idx_valid <= ram_2_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_2_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_2_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_2_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_2_cfi_type;
      bpd_entry_br_mask <= ram_2_br_mask;
      bpd_pc <= pcs_2;
    end
    else if (bpd_idx == 6'h1) begin
      bpd_entry_cfi_idx_valid <= ram_1_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_1_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_1_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_1_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_1_cfi_type;
      bpd_entry_br_mask <= ram_1_br_mask;
      bpd_pc <= pcs_1;
    end
    else begin
      bpd_entry_cfi_idx_valid <= ram_0_cfi_idx_valid;
      bpd_entry_cfi_idx_bits <= ram_0_cfi_idx_bits;
      bpd_entry_cfi_taken <= ram_0_cfi_taken;
      bpd_entry_cfi_mispredicted <= ram_0_cfi_mispredicted;
      bpd_entry_cfi_type <= ram_0_cfi_type;
      bpd_entry_br_mask <= ram_0_br_mask;
      bpd_pc <= pcs_0;
    end
    if (_bpd_target_T_2 == 6'h27)
      bpd_target <= pcs_39;
    else if (_bpd_target_T_2 == 6'h26)
      bpd_target <= pcs_38;
    else if (_bpd_target_T_2 == 6'h25)
      bpd_target <= pcs_37;
    else if (_bpd_target_T_2 == 6'h24)
      bpd_target <= pcs_36;
    else if (_bpd_target_T_2 == 6'h23)
      bpd_target <= pcs_35;
    else if (_bpd_target_T_2 == 6'h22)
      bpd_target <= pcs_34;
    else if (_bpd_target_T_2 == 6'h21)
      bpd_target <= pcs_33;
    else if (_bpd_target_T_2 == 6'h20)
      bpd_target <= pcs_32;
    else if (_bpd_target_T_2 == 6'h1F)
      bpd_target <= pcs_31;
    else if (_bpd_target_T_2 == 6'h1E)
      bpd_target <= pcs_30;
    else if (_bpd_target_T_2 == 6'h1D)
      bpd_target <= pcs_29;
    else if (_bpd_target_T_2 == 6'h1C)
      bpd_target <= pcs_28;
    else if (_bpd_target_T_2 == 6'h1B)
      bpd_target <= pcs_27;
    else if (_bpd_target_T_2 == 6'h1A)
      bpd_target <= pcs_26;
    else if (_bpd_target_T_2 == 6'h19)
      bpd_target <= pcs_25;
    else if (_bpd_target_T_2 == 6'h18)
      bpd_target <= pcs_24;
    else if (_bpd_target_T_2 == 6'h17)
      bpd_target <= pcs_23;
    else if (_bpd_target_T_2 == 6'h16)
      bpd_target <= pcs_22;
    else if (_bpd_target_T_2 == 6'h15)
      bpd_target <= pcs_21;
    else if (_bpd_target_T_2 == 6'h14)
      bpd_target <= pcs_20;
    else if (_bpd_target_T_2 == 6'h13)
      bpd_target <= pcs_19;
    else if (_bpd_target_T_2 == 6'h12)
      bpd_target <= pcs_18;
    else if (_bpd_target_T_2 == 6'h11)
      bpd_target <= pcs_17;
    else if (_bpd_target_T_2 == 6'h10)
      bpd_target <= pcs_16;
    else if (_bpd_target_T_2 == 6'hF)
      bpd_target <= pcs_15;
    else if (_bpd_target_T_2 == 6'hE)
      bpd_target <= pcs_14;
    else if (_bpd_target_T_2 == 6'hD)
      bpd_target <= pcs_13;
    else if (_bpd_target_T_2 == 6'hC)
      bpd_target <= pcs_12;
    else if (_bpd_target_T_2 == 6'hB)
      bpd_target <= pcs_11;
    else if (_bpd_target_T_2 == 6'hA)
      bpd_target <= pcs_10;
    else if (_bpd_target_T_2 == 6'h9)
      bpd_target <= pcs_9;
    else if (_bpd_target_T_2 == 6'h8)
      bpd_target <= pcs_8;
    else if (_bpd_target_T_2 == 6'h7)
      bpd_target <= pcs_7;
    else if (_bpd_target_T_2 == 6'h6)
      bpd_target <= pcs_6;
    else if (_bpd_target_T_2 == 6'h5)
      bpd_target <= pcs_5;
    else if (_bpd_target_T_2 == 6'h4)
      bpd_target <= pcs_4;
    else if (_bpd_target_T_2 == 6'h3)
      bpd_target <= pcs_3;
    else if (_bpd_target_T_2 == 6'h2)
      bpd_target <= pcs_2;
    else if (_bpd_target_T_2 == 6'h1)
      bpd_target <= pcs_1;
    else
      bpd_target <= pcs_0;
    REG <= io_brupdate_b2_mispredict;
    bpd_repair_idx_REG <= io_brupdate_b2_uop_ftq_idx;
    bpd_end_idx_REG <= enq_ptr;
    REG_1 <= bpd_update_mispredict;
    do_commit_update_REG <= io_redirect_valid;
    REG_2 <= do_commit_update | bpd_update_repair | bpd_update_mispredict;
    io_bpdupdate_valid_REG <= bpd_update_repair;
    io_bpdupdate_bits_is_mispredict_update_REG <= bpd_update_mispredict;
    io_bpdupdate_bits_is_repair_update_REG <= bpd_update_repair;
    io_enq_ready_REG <= ~((_full_T_2 == 6'h27 ? 6'h0 : _full_T_2 + 6'h1) == bpd_ptr | (full_wrap ? 6'h0 : _enq_ptr_T) == bpd_ptr) | do_commit_update;
    REG_3 <= io_redirect_valid;
    prev_entry_REG_cfi_idx_valid <= redirect_new_entry_cfi_idx_valid;
    if (_GEN_98) begin
      prev_entry_REG_cfi_idx_bits <= new_cfi_idx;
      prev_entry_REG_cfi_taken <= io_brupdate_b2_taken;
      ram_REG_cfi_idx_bits <= new_cfi_idx;
      ram_REG_cfi_taken <= io_brupdate_b2_taken;
    end
    else if (_GEN_97) begin
      prev_entry_REG_cfi_idx_bits <= ram_39_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_39_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_39_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_39_cfi_taken;
    end
    else if (_GEN_96) begin
      prev_entry_REG_cfi_idx_bits <= ram_38_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_38_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_38_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_38_cfi_taken;
    end
    else if (_GEN_95) begin
      prev_entry_REG_cfi_idx_bits <= ram_37_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_37_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_37_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_37_cfi_taken;
    end
    else if (_GEN_94) begin
      prev_entry_REG_cfi_idx_bits <= ram_36_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_36_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_36_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_36_cfi_taken;
    end
    else if (_GEN_93) begin
      prev_entry_REG_cfi_idx_bits <= ram_35_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_35_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_35_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_35_cfi_taken;
    end
    else if (_GEN_92) begin
      prev_entry_REG_cfi_idx_bits <= ram_34_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_34_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_34_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_34_cfi_taken;
    end
    else if (_GEN_91) begin
      prev_entry_REG_cfi_idx_bits <= ram_33_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_33_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_33_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_33_cfi_taken;
    end
    else if (_GEN_90) begin
      prev_entry_REG_cfi_idx_bits <= ram_32_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_32_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_32_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_32_cfi_taken;
    end
    else if (_GEN_89) begin
      prev_entry_REG_cfi_idx_bits <= ram_31_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_31_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_31_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_31_cfi_taken;
    end
    else if (_GEN_88) begin
      prev_entry_REG_cfi_idx_bits <= ram_30_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_30_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_30_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_30_cfi_taken;
    end
    else if (_GEN_87) begin
      prev_entry_REG_cfi_idx_bits <= ram_29_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_29_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_29_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_29_cfi_taken;
    end
    else if (_GEN_86) begin
      prev_entry_REG_cfi_idx_bits <= ram_28_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_28_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_28_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_28_cfi_taken;
    end
    else if (_GEN_85) begin
      prev_entry_REG_cfi_idx_bits <= ram_27_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_27_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_27_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_27_cfi_taken;
    end
    else if (_GEN_84) begin
      prev_entry_REG_cfi_idx_bits <= ram_26_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_26_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_26_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_26_cfi_taken;
    end
    else if (_GEN_83) begin
      prev_entry_REG_cfi_idx_bits <= ram_25_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_25_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_25_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_25_cfi_taken;
    end
    else if (_GEN_82) begin
      prev_entry_REG_cfi_idx_bits <= ram_24_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_24_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_24_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_24_cfi_taken;
    end
    else if (_GEN_81) begin
      prev_entry_REG_cfi_idx_bits <= ram_23_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_23_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_23_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_23_cfi_taken;
    end
    else if (_GEN_80) begin
      prev_entry_REG_cfi_idx_bits <= ram_22_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_22_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_22_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_22_cfi_taken;
    end
    else if (_GEN_79) begin
      prev_entry_REG_cfi_idx_bits <= ram_21_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_21_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_21_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_21_cfi_taken;
    end
    else if (_GEN_78) begin
      prev_entry_REG_cfi_idx_bits <= ram_20_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_20_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_20_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_20_cfi_taken;
    end
    else if (_GEN_77) begin
      prev_entry_REG_cfi_idx_bits <= ram_19_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_19_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_19_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_19_cfi_taken;
    end
    else if (_GEN_76) begin
      prev_entry_REG_cfi_idx_bits <= ram_18_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_18_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_18_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_18_cfi_taken;
    end
    else if (_GEN_75) begin
      prev_entry_REG_cfi_idx_bits <= ram_17_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_17_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_17_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_17_cfi_taken;
    end
    else if (_GEN_74) begin
      prev_entry_REG_cfi_idx_bits <= ram_16_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_16_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_16_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_16_cfi_taken;
    end
    else if (_GEN_73) begin
      prev_entry_REG_cfi_idx_bits <= ram_15_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_15_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_15_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_15_cfi_taken;
    end
    else if (_GEN_72) begin
      prev_entry_REG_cfi_idx_bits <= ram_14_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_14_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_14_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_14_cfi_taken;
    end
    else if (_GEN_71) begin
      prev_entry_REG_cfi_idx_bits <= ram_13_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_13_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_13_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_13_cfi_taken;
    end
    else if (_GEN_70) begin
      prev_entry_REG_cfi_idx_bits <= ram_12_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_12_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_12_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_12_cfi_taken;
    end
    else if (_GEN_69) begin
      prev_entry_REG_cfi_idx_bits <= ram_11_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_11_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_11_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_11_cfi_taken;
    end
    else if (_GEN_68) begin
      prev_entry_REG_cfi_idx_bits <= ram_10_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_10_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_10_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_10_cfi_taken;
    end
    else if (_GEN_67) begin
      prev_entry_REG_cfi_idx_bits <= ram_9_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_9_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_9_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_9_cfi_taken;
    end
    else if (_GEN_66) begin
      prev_entry_REG_cfi_idx_bits <= ram_8_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_8_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_8_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_8_cfi_taken;
    end
    else if (_GEN_65) begin
      prev_entry_REG_cfi_idx_bits <= ram_7_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_7_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_7_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_7_cfi_taken;
    end
    else if (_GEN_64) begin
      prev_entry_REG_cfi_idx_bits <= ram_6_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_6_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_6_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_6_cfi_taken;
    end
    else if (_GEN_63) begin
      prev_entry_REG_cfi_idx_bits <= ram_5_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_5_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_5_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_5_cfi_taken;
    end
    else if (_GEN_62) begin
      prev_entry_REG_cfi_idx_bits <= ram_4_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_4_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_4_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_4_cfi_taken;
    end
    else if (_GEN_61) begin
      prev_entry_REG_cfi_idx_bits <= ram_3_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_3_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_3_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_3_cfi_taken;
    end
    else if (_GEN_60) begin
      prev_entry_REG_cfi_idx_bits <= ram_2_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_2_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_2_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_2_cfi_taken;
    end
    else if (_GEN_59) begin
      prev_entry_REG_cfi_idx_bits <= ram_1_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_1_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_1_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_1_cfi_taken;
    end
    else begin
      prev_entry_REG_cfi_idx_bits <= ram_0_cfi_idx_bits;
      prev_entry_REG_cfi_taken <= ram_0_cfi_taken;
      ram_REG_cfi_idx_bits <= ram_0_cfi_idx_bits;
      ram_REG_cfi_taken <= ram_0_cfi_taken;
    end
    if (_GEN_97) begin
      prev_entry_REG_br_mask <= ram_39_br_mask;
      ram_REG_cfi_type <= ram_39_cfi_type;
      ram_REG_br_mask <= ram_39_br_mask;
      ram_REG_ras_top <= ram_39_ras_top;
      ram_REG_ras_idx <= ram_39_ras_idx;
      ram_REG_start_bank <= ram_39_start_bank;
    end
    else if (_GEN_96) begin
      prev_entry_REG_br_mask <= ram_38_br_mask;
      ram_REG_cfi_type <= ram_38_cfi_type;
      ram_REG_br_mask <= ram_38_br_mask;
      ram_REG_ras_top <= ram_38_ras_top;
      ram_REG_ras_idx <= ram_38_ras_idx;
      ram_REG_start_bank <= ram_38_start_bank;
    end
    else if (_GEN_95) begin
      prev_entry_REG_br_mask <= ram_37_br_mask;
      ram_REG_cfi_type <= ram_37_cfi_type;
      ram_REG_br_mask <= ram_37_br_mask;
      ram_REG_ras_top <= ram_37_ras_top;
      ram_REG_ras_idx <= ram_37_ras_idx;
      ram_REG_start_bank <= ram_37_start_bank;
    end
    else if (_GEN_94) begin
      prev_entry_REG_br_mask <= ram_36_br_mask;
      ram_REG_cfi_type <= ram_36_cfi_type;
      ram_REG_br_mask <= ram_36_br_mask;
      ram_REG_ras_top <= ram_36_ras_top;
      ram_REG_ras_idx <= ram_36_ras_idx;
      ram_REG_start_bank <= ram_36_start_bank;
    end
    else if (_GEN_93) begin
      prev_entry_REG_br_mask <= ram_35_br_mask;
      ram_REG_cfi_type <= ram_35_cfi_type;
      ram_REG_br_mask <= ram_35_br_mask;
      ram_REG_ras_top <= ram_35_ras_top;
      ram_REG_ras_idx <= ram_35_ras_idx;
      ram_REG_start_bank <= ram_35_start_bank;
    end
    else if (_GEN_92) begin
      prev_entry_REG_br_mask <= ram_34_br_mask;
      ram_REG_cfi_type <= ram_34_cfi_type;
      ram_REG_br_mask <= ram_34_br_mask;
      ram_REG_ras_top <= ram_34_ras_top;
      ram_REG_ras_idx <= ram_34_ras_idx;
      ram_REG_start_bank <= ram_34_start_bank;
    end
    else if (_GEN_91) begin
      prev_entry_REG_br_mask <= ram_33_br_mask;
      ram_REG_cfi_type <= ram_33_cfi_type;
      ram_REG_br_mask <= ram_33_br_mask;
      ram_REG_ras_top <= ram_33_ras_top;
      ram_REG_ras_idx <= ram_33_ras_idx;
      ram_REG_start_bank <= ram_33_start_bank;
    end
    else if (_GEN_90) begin
      prev_entry_REG_br_mask <= ram_32_br_mask;
      ram_REG_cfi_type <= ram_32_cfi_type;
      ram_REG_br_mask <= ram_32_br_mask;
      ram_REG_ras_top <= ram_32_ras_top;
      ram_REG_ras_idx <= ram_32_ras_idx;
      ram_REG_start_bank <= ram_32_start_bank;
    end
    else if (_GEN_89) begin
      prev_entry_REG_br_mask <= ram_31_br_mask;
      ram_REG_cfi_type <= ram_31_cfi_type;
      ram_REG_br_mask <= ram_31_br_mask;
      ram_REG_ras_top <= ram_31_ras_top;
      ram_REG_ras_idx <= ram_31_ras_idx;
      ram_REG_start_bank <= ram_31_start_bank;
    end
    else if (_GEN_88) begin
      prev_entry_REG_br_mask <= ram_30_br_mask;
      ram_REG_cfi_type <= ram_30_cfi_type;
      ram_REG_br_mask <= ram_30_br_mask;
      ram_REG_ras_top <= ram_30_ras_top;
      ram_REG_ras_idx <= ram_30_ras_idx;
      ram_REG_start_bank <= ram_30_start_bank;
    end
    else if (_GEN_87) begin
      prev_entry_REG_br_mask <= ram_29_br_mask;
      ram_REG_cfi_type <= ram_29_cfi_type;
      ram_REG_br_mask <= ram_29_br_mask;
      ram_REG_ras_top <= ram_29_ras_top;
      ram_REG_ras_idx <= ram_29_ras_idx;
      ram_REG_start_bank <= ram_29_start_bank;
    end
    else if (_GEN_86) begin
      prev_entry_REG_br_mask <= ram_28_br_mask;
      ram_REG_cfi_type <= ram_28_cfi_type;
      ram_REG_br_mask <= ram_28_br_mask;
      ram_REG_ras_top <= ram_28_ras_top;
      ram_REG_ras_idx <= ram_28_ras_idx;
      ram_REG_start_bank <= ram_28_start_bank;
    end
    else if (_GEN_85) begin
      prev_entry_REG_br_mask <= ram_27_br_mask;
      ram_REG_cfi_type <= ram_27_cfi_type;
      ram_REG_br_mask <= ram_27_br_mask;
      ram_REG_ras_top <= ram_27_ras_top;
      ram_REG_ras_idx <= ram_27_ras_idx;
      ram_REG_start_bank <= ram_27_start_bank;
    end
    else if (_GEN_84) begin
      prev_entry_REG_br_mask <= ram_26_br_mask;
      ram_REG_cfi_type <= ram_26_cfi_type;
      ram_REG_br_mask <= ram_26_br_mask;
      ram_REG_ras_top <= ram_26_ras_top;
      ram_REG_ras_idx <= ram_26_ras_idx;
      ram_REG_start_bank <= ram_26_start_bank;
    end
    else if (_GEN_83) begin
      prev_entry_REG_br_mask <= ram_25_br_mask;
      ram_REG_cfi_type <= ram_25_cfi_type;
      ram_REG_br_mask <= ram_25_br_mask;
      ram_REG_ras_top <= ram_25_ras_top;
      ram_REG_ras_idx <= ram_25_ras_idx;
      ram_REG_start_bank <= ram_25_start_bank;
    end
    else if (_GEN_82) begin
      prev_entry_REG_br_mask <= ram_24_br_mask;
      ram_REG_cfi_type <= ram_24_cfi_type;
      ram_REG_br_mask <= ram_24_br_mask;
      ram_REG_ras_top <= ram_24_ras_top;
      ram_REG_ras_idx <= ram_24_ras_idx;
      ram_REG_start_bank <= ram_24_start_bank;
    end
    else if (_GEN_81) begin
      prev_entry_REG_br_mask <= ram_23_br_mask;
      ram_REG_cfi_type <= ram_23_cfi_type;
      ram_REG_br_mask <= ram_23_br_mask;
      ram_REG_ras_top <= ram_23_ras_top;
      ram_REG_ras_idx <= ram_23_ras_idx;
      ram_REG_start_bank <= ram_23_start_bank;
    end
    else if (_GEN_80) begin
      prev_entry_REG_br_mask <= ram_22_br_mask;
      ram_REG_cfi_type <= ram_22_cfi_type;
      ram_REG_br_mask <= ram_22_br_mask;
      ram_REG_ras_top <= ram_22_ras_top;
      ram_REG_ras_idx <= ram_22_ras_idx;
      ram_REG_start_bank <= ram_22_start_bank;
    end
    else if (_GEN_79) begin
      prev_entry_REG_br_mask <= ram_21_br_mask;
      ram_REG_cfi_type <= ram_21_cfi_type;
      ram_REG_br_mask <= ram_21_br_mask;
      ram_REG_ras_top <= ram_21_ras_top;
      ram_REG_ras_idx <= ram_21_ras_idx;
      ram_REG_start_bank <= ram_21_start_bank;
    end
    else if (_GEN_78) begin
      prev_entry_REG_br_mask <= ram_20_br_mask;
      ram_REG_cfi_type <= ram_20_cfi_type;
      ram_REG_br_mask <= ram_20_br_mask;
      ram_REG_ras_top <= ram_20_ras_top;
      ram_REG_ras_idx <= ram_20_ras_idx;
      ram_REG_start_bank <= ram_20_start_bank;
    end
    else if (_GEN_77) begin
      prev_entry_REG_br_mask <= ram_19_br_mask;
      ram_REG_cfi_type <= ram_19_cfi_type;
      ram_REG_br_mask <= ram_19_br_mask;
      ram_REG_ras_top <= ram_19_ras_top;
      ram_REG_ras_idx <= ram_19_ras_idx;
      ram_REG_start_bank <= ram_19_start_bank;
    end
    else if (_GEN_76) begin
      prev_entry_REG_br_mask <= ram_18_br_mask;
      ram_REG_cfi_type <= ram_18_cfi_type;
      ram_REG_br_mask <= ram_18_br_mask;
      ram_REG_ras_top <= ram_18_ras_top;
      ram_REG_ras_idx <= ram_18_ras_idx;
      ram_REG_start_bank <= ram_18_start_bank;
    end
    else if (_GEN_75) begin
      prev_entry_REG_br_mask <= ram_17_br_mask;
      ram_REG_cfi_type <= ram_17_cfi_type;
      ram_REG_br_mask <= ram_17_br_mask;
      ram_REG_ras_top <= ram_17_ras_top;
      ram_REG_ras_idx <= ram_17_ras_idx;
      ram_REG_start_bank <= ram_17_start_bank;
    end
    else if (_GEN_74) begin
      prev_entry_REG_br_mask <= ram_16_br_mask;
      ram_REG_cfi_type <= ram_16_cfi_type;
      ram_REG_br_mask <= ram_16_br_mask;
      ram_REG_ras_top <= ram_16_ras_top;
      ram_REG_ras_idx <= ram_16_ras_idx;
      ram_REG_start_bank <= ram_16_start_bank;
    end
    else if (_GEN_73) begin
      prev_entry_REG_br_mask <= ram_15_br_mask;
      ram_REG_cfi_type <= ram_15_cfi_type;
      ram_REG_br_mask <= ram_15_br_mask;
      ram_REG_ras_top <= ram_15_ras_top;
      ram_REG_ras_idx <= ram_15_ras_idx;
      ram_REG_start_bank <= ram_15_start_bank;
    end
    else if (_GEN_72) begin
      prev_entry_REG_br_mask <= ram_14_br_mask;
      ram_REG_cfi_type <= ram_14_cfi_type;
      ram_REG_br_mask <= ram_14_br_mask;
      ram_REG_ras_top <= ram_14_ras_top;
      ram_REG_ras_idx <= ram_14_ras_idx;
      ram_REG_start_bank <= ram_14_start_bank;
    end
    else if (_GEN_71) begin
      prev_entry_REG_br_mask <= ram_13_br_mask;
      ram_REG_cfi_type <= ram_13_cfi_type;
      ram_REG_br_mask <= ram_13_br_mask;
      ram_REG_ras_top <= ram_13_ras_top;
      ram_REG_ras_idx <= ram_13_ras_idx;
      ram_REG_start_bank <= ram_13_start_bank;
    end
    else if (_GEN_70) begin
      prev_entry_REG_br_mask <= ram_12_br_mask;
      ram_REG_cfi_type <= ram_12_cfi_type;
      ram_REG_br_mask <= ram_12_br_mask;
      ram_REG_ras_top <= ram_12_ras_top;
      ram_REG_ras_idx <= ram_12_ras_idx;
      ram_REG_start_bank <= ram_12_start_bank;
    end
    else if (_GEN_69) begin
      prev_entry_REG_br_mask <= ram_11_br_mask;
      ram_REG_cfi_type <= ram_11_cfi_type;
      ram_REG_br_mask <= ram_11_br_mask;
      ram_REG_ras_top <= ram_11_ras_top;
      ram_REG_ras_idx <= ram_11_ras_idx;
      ram_REG_start_bank <= ram_11_start_bank;
    end
    else if (_GEN_68) begin
      prev_entry_REG_br_mask <= ram_10_br_mask;
      ram_REG_cfi_type <= ram_10_cfi_type;
      ram_REG_br_mask <= ram_10_br_mask;
      ram_REG_ras_top <= ram_10_ras_top;
      ram_REG_ras_idx <= ram_10_ras_idx;
      ram_REG_start_bank <= ram_10_start_bank;
    end
    else if (_GEN_67) begin
      prev_entry_REG_br_mask <= ram_9_br_mask;
      ram_REG_cfi_type <= ram_9_cfi_type;
      ram_REG_br_mask <= ram_9_br_mask;
      ram_REG_ras_top <= ram_9_ras_top;
      ram_REG_ras_idx <= ram_9_ras_idx;
      ram_REG_start_bank <= ram_9_start_bank;
    end
    else if (_GEN_66) begin
      prev_entry_REG_br_mask <= ram_8_br_mask;
      ram_REG_cfi_type <= ram_8_cfi_type;
      ram_REG_br_mask <= ram_8_br_mask;
      ram_REG_ras_top <= ram_8_ras_top;
      ram_REG_ras_idx <= ram_8_ras_idx;
      ram_REG_start_bank <= ram_8_start_bank;
    end
    else if (_GEN_65) begin
      prev_entry_REG_br_mask <= ram_7_br_mask;
      ram_REG_cfi_type <= ram_7_cfi_type;
      ram_REG_br_mask <= ram_7_br_mask;
      ram_REG_ras_top <= ram_7_ras_top;
      ram_REG_ras_idx <= ram_7_ras_idx;
      ram_REG_start_bank <= ram_7_start_bank;
    end
    else if (_GEN_64) begin
      prev_entry_REG_br_mask <= ram_6_br_mask;
      ram_REG_cfi_type <= ram_6_cfi_type;
      ram_REG_br_mask <= ram_6_br_mask;
      ram_REG_ras_top <= ram_6_ras_top;
      ram_REG_ras_idx <= ram_6_ras_idx;
      ram_REG_start_bank <= ram_6_start_bank;
    end
    else if (_GEN_63) begin
      prev_entry_REG_br_mask <= ram_5_br_mask;
      ram_REG_cfi_type <= ram_5_cfi_type;
      ram_REG_br_mask <= ram_5_br_mask;
      ram_REG_ras_top <= ram_5_ras_top;
      ram_REG_ras_idx <= ram_5_ras_idx;
      ram_REG_start_bank <= ram_5_start_bank;
    end
    else if (_GEN_62) begin
      prev_entry_REG_br_mask <= ram_4_br_mask;
      ram_REG_cfi_type <= ram_4_cfi_type;
      ram_REG_br_mask <= ram_4_br_mask;
      ram_REG_ras_top <= ram_4_ras_top;
      ram_REG_ras_idx <= ram_4_ras_idx;
      ram_REG_start_bank <= ram_4_start_bank;
    end
    else if (_GEN_61) begin
      prev_entry_REG_br_mask <= ram_3_br_mask;
      ram_REG_cfi_type <= ram_3_cfi_type;
      ram_REG_br_mask <= ram_3_br_mask;
      ram_REG_ras_top <= ram_3_ras_top;
      ram_REG_ras_idx <= ram_3_ras_idx;
      ram_REG_start_bank <= ram_3_start_bank;
    end
    else if (_GEN_60) begin
      prev_entry_REG_br_mask <= ram_2_br_mask;
      ram_REG_cfi_type <= ram_2_cfi_type;
      ram_REG_br_mask <= ram_2_br_mask;
      ram_REG_ras_top <= ram_2_ras_top;
      ram_REG_ras_idx <= ram_2_ras_idx;
      ram_REG_start_bank <= ram_2_start_bank;
    end
    else if (_GEN_59) begin
      prev_entry_REG_br_mask <= ram_1_br_mask;
      ram_REG_cfi_type <= ram_1_cfi_type;
      ram_REG_br_mask <= ram_1_br_mask;
      ram_REG_ras_top <= ram_1_ras_top;
      ram_REG_ras_idx <= ram_1_ras_idx;
      ram_REG_start_bank <= ram_1_start_bank;
    end
    else begin
      prev_entry_REG_br_mask <= ram_0_br_mask;
      ram_REG_cfi_type <= ram_0_cfi_type;
      ram_REG_br_mask <= ram_0_br_mask;
      ram_REG_ras_top <= ram_0_ras_top;
      ram_REG_ras_idx <= ram_0_ras_idx;
      ram_REG_start_bank <= ram_0_start_bank;
    end
    prev_entry_REG_cfi_is_call <= redirect_new_entry_cfi_is_call;
    prev_entry_REG_cfi_is_ret <= redirect_new_entry_cfi_is_ret;
    REG_4 <= io_redirect_bits;
    ram_REG_cfi_idx_valid <= redirect_new_entry_cfi_idx_valid;
    ram_REG_cfi_mispredicted <= _GEN_98 | (_GEN_97 ? ram_39_cfi_mispredicted : _GEN_96 ? ram_38_cfi_mispredicted : _GEN_95 ? ram_37_cfi_mispredicted : _GEN_94 ? ram_36_cfi_mispredicted : _GEN_93 ? ram_35_cfi_mispredicted : _GEN_92 ? ram_34_cfi_mispredicted : _GEN_91 ? ram_33_cfi_mispredicted : _GEN_90 ? ram_32_cfi_mispredicted : _GEN_89 ? ram_31_cfi_mispredicted : _GEN_88 ? ram_30_cfi_mispredicted : _GEN_87 ? ram_29_cfi_mispredicted : _GEN_86 ? ram_28_cfi_mispredicted : _GEN_85 ? ram_27_cfi_mispredicted : _GEN_84 ? ram_26_cfi_mispredicted : _GEN_83 ? ram_25_cfi_mispredicted : _GEN_82 ? ram_24_cfi_mispredicted : _GEN_81 ? ram_23_cfi_mispredicted : _GEN_80 ? ram_22_cfi_mispredicted : _GEN_79 ? ram_21_cfi_mispredicted : _GEN_78 ? ram_20_cfi_mispredicted : _GEN_77 ? ram_19_cfi_mispredicted : _GEN_76 ? ram_18_cfi_mispredicted : _GEN_75 ? ram_17_cfi_mispredicted : _GEN_74 ? ram_16_cfi_mispredicted : _GEN_73 ? ram_15_cfi_mispredicted : _GEN_72 ? ram_14_cfi_mispredicted : _GEN_71 ? ram_13_cfi_mispredicted : _GEN_70 ? ram_12_cfi_mispredicted : _GEN_69 ? ram_11_cfi_mispredicted : _GEN_68 ? ram_10_cfi_mispredicted : _GEN_67 ? ram_9_cfi_mispredicted : _GEN_66 ? ram_8_cfi_mispredicted : _GEN_65 ? ram_7_cfi_mispredicted : _GEN_64 ? ram_6_cfi_mispredicted : _GEN_63 ? ram_5_cfi_mispredicted : _GEN_62 ? ram_4_cfi_mispredicted : _GEN_61 ? ram_3_cfi_mispredicted : _GEN_60 ? ram_2_cfi_mispredicted : _GEN_59 ? ram_1_cfi_mispredicted : ram_0_cfi_mispredicted);
    ram_REG_cfi_is_call <= redirect_new_entry_cfi_is_call;
    ram_REG_cfi_is_ret <= redirect_new_entry_cfi_is_ret;
    if (io_get_ftq_pc_0_ftq_idx == 6'h27) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_39_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_39_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_39_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_39_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_39;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h26) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_38_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_38_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_38_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_38_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_38;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h25) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_37_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_37_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_37_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_37_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_37;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h24) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_36_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_36_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_36_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_36_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_36;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h23) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_35_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_35_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_35_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_35_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_35;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h22) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_34_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_34_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_34_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_34_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_34;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h21) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_33_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_33_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_33_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_33_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_33;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h20) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_32_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_32_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_32_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_32_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_32;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h1F) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_31_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_31_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_31_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_31_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_31;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h1E) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_30_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_30_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_30_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_30_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_30;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h1D) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_29_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_29_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_29_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_29_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_29;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h1C) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_28_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_28_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_28_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_28_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_28;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h1B) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_27_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_27_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_27_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_27_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_27;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h1A) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_26_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_26_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_26_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_26_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_26;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h19) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_25_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_25_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_25_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_25_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_25;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h18) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_24_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_24_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_24_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_24_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_24;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h17) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_23_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_23_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_23_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_23_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_23;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h16) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_22_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_22_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_22_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_22_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_22;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h15) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_21_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_21_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_21_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_21_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_21;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h14) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_20_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_20_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_20_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_20_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_20;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h13) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_19_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_19_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_19_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_19_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_19;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h12) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_18_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_18_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_18_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_18_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_18;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h11) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_17_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_17_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_17_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_17_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_17;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h10) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_16_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_16_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_16_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_16_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_16;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'hF) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_15_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_15_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_15_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_15_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_15;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'hE) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_14_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_14_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_14_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_14_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_14;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'hD) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_13_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_13_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_13_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_13_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_13;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'hC) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_12_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_12_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_12_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_12_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_12;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'hB) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_11_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_11_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_11_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_11_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_11;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'hA) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_10_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_10_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_10_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_10_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_10;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h9) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_9_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_9_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_9_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_9_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_9;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h8) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_8_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_8_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_8_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_8_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_8;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h7) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_7_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_7_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_7_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_7_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_7;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h6) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_6_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_6_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_6_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_6_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_6;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h5) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_5_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_5_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_5_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_5_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_5;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h4) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_4_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_4_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_4_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_4_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_4;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h3) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_3_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_3_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_3_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_3_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_3;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h2) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_2_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_2_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_2_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_2_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_2;
    end
    else if (io_get_ftq_pc_0_ftq_idx == 6'h1) begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_1_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_1_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_1_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_1_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_1;
    end
    else begin
      io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= ram_0_cfi_idx_valid;
      io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= ram_0_cfi_idx_bits;
      io_get_ftq_pc_0_entry_REG_ras_idx <= ram_0_ras_idx;
      io_get_ftq_pc_0_entry_REG_start_bank <= ram_0_start_bank;
      io_get_ftq_pc_0_pc_REG <= pcs_0;
    end
    if (next_is_enq)
      io_get_ftq_pc_0_next_pc_REG <= io_enq_bits_pc;
    else if (next_idx == 6'h27)
      io_get_ftq_pc_0_next_pc_REG <= pcs_39;
    else if (next_idx == 6'h26)
      io_get_ftq_pc_0_next_pc_REG <= pcs_38;
    else if (next_idx == 6'h25)
      io_get_ftq_pc_0_next_pc_REG <= pcs_37;
    else if (next_idx == 6'h24)
      io_get_ftq_pc_0_next_pc_REG <= pcs_36;
    else if (next_idx == 6'h23)
      io_get_ftq_pc_0_next_pc_REG <= pcs_35;
    else if (next_idx == 6'h22)
      io_get_ftq_pc_0_next_pc_REG <= pcs_34;
    else if (next_idx == 6'h21)
      io_get_ftq_pc_0_next_pc_REG <= pcs_33;
    else if (next_idx == 6'h20)
      io_get_ftq_pc_0_next_pc_REG <= pcs_32;
    else if (next_idx == 6'h1F)
      io_get_ftq_pc_0_next_pc_REG <= pcs_31;
    else if (next_idx == 6'h1E)
      io_get_ftq_pc_0_next_pc_REG <= pcs_30;
    else if (next_idx == 6'h1D)
      io_get_ftq_pc_0_next_pc_REG <= pcs_29;
    else if (next_idx == 6'h1C)
      io_get_ftq_pc_0_next_pc_REG <= pcs_28;
    else if (next_idx == 6'h1B)
      io_get_ftq_pc_0_next_pc_REG <= pcs_27;
    else if (next_idx == 6'h1A)
      io_get_ftq_pc_0_next_pc_REG <= pcs_26;
    else if (next_idx == 6'h19)
      io_get_ftq_pc_0_next_pc_REG <= pcs_25;
    else if (next_idx == 6'h18)
      io_get_ftq_pc_0_next_pc_REG <= pcs_24;
    else if (next_idx == 6'h17)
      io_get_ftq_pc_0_next_pc_REG <= pcs_23;
    else if (next_idx == 6'h16)
      io_get_ftq_pc_0_next_pc_REG <= pcs_22;
    else if (next_idx == 6'h15)
      io_get_ftq_pc_0_next_pc_REG <= pcs_21;
    else if (next_idx == 6'h14)
      io_get_ftq_pc_0_next_pc_REG <= pcs_20;
    else if (next_idx == 6'h13)
      io_get_ftq_pc_0_next_pc_REG <= pcs_19;
    else if (next_idx == 6'h12)
      io_get_ftq_pc_0_next_pc_REG <= pcs_18;
    else if (next_idx == 6'h11)
      io_get_ftq_pc_0_next_pc_REG <= pcs_17;
    else if (next_idx == 6'h10)
      io_get_ftq_pc_0_next_pc_REG <= pcs_16;
    else if (next_idx == 6'hF)
      io_get_ftq_pc_0_next_pc_REG <= pcs_15;
    else if (next_idx == 6'hE)
      io_get_ftq_pc_0_next_pc_REG <= pcs_14;
    else if (next_idx == 6'hD)
      io_get_ftq_pc_0_next_pc_REG <= pcs_13;
    else if (next_idx == 6'hC)
      io_get_ftq_pc_0_next_pc_REG <= pcs_12;
    else if (next_idx == 6'hB)
      io_get_ftq_pc_0_next_pc_REG <= pcs_11;
    else if (next_idx == 6'hA)
      io_get_ftq_pc_0_next_pc_REG <= pcs_10;
    else if (next_idx == 6'h9)
      io_get_ftq_pc_0_next_pc_REG <= pcs_9;
    else if (next_idx == 6'h8)
      io_get_ftq_pc_0_next_pc_REG <= pcs_8;
    else if (next_idx == 6'h7)
      io_get_ftq_pc_0_next_pc_REG <= pcs_7;
    else if (next_idx == 6'h6)
      io_get_ftq_pc_0_next_pc_REG <= pcs_6;
    else if (next_idx == 6'h5)
      io_get_ftq_pc_0_next_pc_REG <= pcs_5;
    else if (next_idx == 6'h4)
      io_get_ftq_pc_0_next_pc_REG <= pcs_4;
    else if (next_idx == 6'h3)
      io_get_ftq_pc_0_next_pc_REG <= pcs_3;
    else if (next_idx == 6'h2)
      io_get_ftq_pc_0_next_pc_REG <= pcs_2;
    else if (next_idx == 6'h1)
      io_get_ftq_pc_0_next_pc_REG <= pcs_1;
    else
      io_get_ftq_pc_0_next_pc_REG <= pcs_0;
    io_get_ftq_pc_0_next_val_REG <= next_idx != enq_ptr | next_is_enq;
    if (_io_get_ftq_pc_1_com_pc_T == 6'h27)
      io_get_ftq_pc_0_com_pc_REG <= pcs_39;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h26)
      io_get_ftq_pc_0_com_pc_REG <= pcs_38;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h25)
      io_get_ftq_pc_0_com_pc_REG <= pcs_37;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h24)
      io_get_ftq_pc_0_com_pc_REG <= pcs_36;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h23)
      io_get_ftq_pc_0_com_pc_REG <= pcs_35;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h22)
      io_get_ftq_pc_0_com_pc_REG <= pcs_34;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h21)
      io_get_ftq_pc_0_com_pc_REG <= pcs_33;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h20)
      io_get_ftq_pc_0_com_pc_REG <= pcs_32;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h1F)
      io_get_ftq_pc_0_com_pc_REG <= pcs_31;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h1E)
      io_get_ftq_pc_0_com_pc_REG <= pcs_30;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h1D)
      io_get_ftq_pc_0_com_pc_REG <= pcs_29;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h1C)
      io_get_ftq_pc_0_com_pc_REG <= pcs_28;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h1B)
      io_get_ftq_pc_0_com_pc_REG <= pcs_27;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h1A)
      io_get_ftq_pc_0_com_pc_REG <= pcs_26;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h19)
      io_get_ftq_pc_0_com_pc_REG <= pcs_25;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h18)
      io_get_ftq_pc_0_com_pc_REG <= pcs_24;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h17)
      io_get_ftq_pc_0_com_pc_REG <= pcs_23;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h16)
      io_get_ftq_pc_0_com_pc_REG <= pcs_22;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h15)
      io_get_ftq_pc_0_com_pc_REG <= pcs_21;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h14)
      io_get_ftq_pc_0_com_pc_REG <= pcs_20;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h13)
      io_get_ftq_pc_0_com_pc_REG <= pcs_19;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h12)
      io_get_ftq_pc_0_com_pc_REG <= pcs_18;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h11)
      io_get_ftq_pc_0_com_pc_REG <= pcs_17;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h10)
      io_get_ftq_pc_0_com_pc_REG <= pcs_16;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'hF)
      io_get_ftq_pc_0_com_pc_REG <= pcs_15;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'hE)
      io_get_ftq_pc_0_com_pc_REG <= pcs_14;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'hD)
      io_get_ftq_pc_0_com_pc_REG <= pcs_13;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'hC)
      io_get_ftq_pc_0_com_pc_REG <= pcs_12;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'hB)
      io_get_ftq_pc_0_com_pc_REG <= pcs_11;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'hA)
      io_get_ftq_pc_0_com_pc_REG <= pcs_10;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h9)
      io_get_ftq_pc_0_com_pc_REG <= pcs_9;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h8)
      io_get_ftq_pc_0_com_pc_REG <= pcs_8;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h7)
      io_get_ftq_pc_0_com_pc_REG <= pcs_7;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h6)
      io_get_ftq_pc_0_com_pc_REG <= pcs_6;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h5)
      io_get_ftq_pc_0_com_pc_REG <= pcs_5;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h4)
      io_get_ftq_pc_0_com_pc_REG <= pcs_4;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h3)
      io_get_ftq_pc_0_com_pc_REG <= pcs_3;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h2)
      io_get_ftq_pc_0_com_pc_REG <= pcs_2;
    else if (_io_get_ftq_pc_1_com_pc_T == 6'h1)
      io_get_ftq_pc_0_com_pc_REG <= pcs_1;
    else
      io_get_ftq_pc_0_com_pc_REG <= pcs_0;
    if (io_get_ftq_pc_1_ftq_idx == 6'h27) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_39_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_39_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_39_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_39_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_39_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_39;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h26) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_38_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_38_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_38_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_38_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_38_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_38;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h25) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_37_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_37_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_37_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_37_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_37_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_37;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h24) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_36_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_36_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_36_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_36_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_36_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_36;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h23) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_35_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_35_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_35_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_35_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_35_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_35;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h22) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_34_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_34_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_34_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_34_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_34_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_34;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h21) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_33_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_33_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_33_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_33_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_33_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_33;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h20) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_32_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_32_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_32_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_32_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_32_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_32;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h1F) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_31_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_31_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_31_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_31_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_31_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_31;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h1E) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_30_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_30_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_30_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_30_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_30_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_30;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h1D) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_29_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_29_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_29_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_29_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_29_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_29;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h1C) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_28_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_28_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_28_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_28_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_28_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_28;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h1B) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_27_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_27_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_27_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_27_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_27_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_27;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h1A) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_26_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_26_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_26_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_26_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_26_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_26;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h19) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_25_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_25_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_25_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_25_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_25_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_25;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h18) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_24_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_24_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_24_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_24_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_24_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_24;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h17) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_23_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_23_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_23_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_23_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_23_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_23;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h16) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_22_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_22_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_22_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_22_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_22_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_22;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h15) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_21_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_21_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_21_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_21_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_21_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_21;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h14) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_20_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_20_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_20_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_20_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_20_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_20;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h13) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_19_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_19_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_19_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_19_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_19_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_19;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h12) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_18_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_18_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_18_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_18_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_18_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_18;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h11) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_17_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_17_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_17_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_17_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_17_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_17;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h10) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_16_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_16_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_16_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_16_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_16_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_16;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'hF) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_15_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_15_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_15_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_15_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_15_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_15;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'hE) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_14_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_14_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_14_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_14_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_14_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_14;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'hD) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_13_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_13_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_13_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_13_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_13_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_13;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'hC) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_12_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_12_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_12_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_12_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_12_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_12;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'hB) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_11_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_11_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_11_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_11_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_11_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_11;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'hA) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_10_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_10_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_10_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_10_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_10_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_10;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h9) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_9_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_9_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_9_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_9_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_9_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_9;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h8) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_8_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_8_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_8_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_8_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_8_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_8;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h7) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_7_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_7_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_7_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_7_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_7_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_7;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h6) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_6_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_6_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_6_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_6_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_6_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_6;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h5) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_5_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_5_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_5_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_5_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_5_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_5;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h4) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_4_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_4_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_4_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_4_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_4_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_4;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h3) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_3_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_3_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_3_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_3_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_3_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_3;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h2) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_2_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_2_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_2_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_2_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_2_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_2;
    end
    else if (io_get_ftq_pc_1_ftq_idx == 6'h1) begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_1_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_1_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_1_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_1_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_1_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_1;
    end
    else begin
      io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= ram_0_cfi_idx_bits;
      io_get_ftq_pc_1_entry_REG_br_mask <= ram_0_br_mask;
      io_get_ftq_pc_1_entry_REG_cfi_is_call <= ram_0_cfi_is_call;
      io_get_ftq_pc_1_entry_REG_cfi_is_ret <= ram_0_cfi_is_ret;
      io_get_ftq_pc_1_entry_REG_start_bank <= ram_0_start_bank;
      io_get_ftq_pc_1_pc_REG <= pcs_0;
    end
  end // always @(posedge)
  meta_40x120 meta_0_ext (
    .R0_addr (bpd_idx),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_bpd_meta_0),
    .R0_data (io_bpdupdate_bits_meta_0)
  );
  meta_40x120 meta_1_ext (
    .R0_addr (bpd_idx),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_bpd_meta_1),
    .R0_data (io_bpdupdate_bits_meta_1)
  );
  ghist_40x64 ghist_0_old_history_ext (
    .R0_addr (bpd_idx),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (new_ghist_old_history),
    .R0_data (_ghist_0_old_history_ext_R0_data)
  );
  ghist_40x1 ghist_0_current_saw_branch_not_taken_ext (
    .R0_addr (bpd_idx),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_ghist_current_saw_branch_not_taken),
    .R0_data (_ghist_0_current_saw_branch_not_taken_ext_R0_data)
  );
  ghist_40x1 ghist_0_new_saw_branch_not_taken_ext (
    .R0_addr (bpd_idx),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (new_ghist_new_saw_branch_not_taken),
    .R0_data (_ghist_0_new_saw_branch_not_taken_ext_R0_data)
  );
  ghist_40x1 ghist_0_new_saw_branch_taken_ext (
    .R0_addr (bpd_idx),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (new_ghist_new_saw_branch_taken),
    .R0_data (_ghist_0_new_saw_branch_taken_ext_R0_data)
  );
  ghist_40x5 ghist_0_ras_idx_ext (
    .R0_addr (bpd_idx),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (new_ghist_ras_idx),
    .R0_data (_ghist_0_ras_idx_ext_R0_data)
  );
  ghist_40x64 ghist_1_old_history_ext (
    .R0_addr (io_get_ftq_pc_1_ftq_idx),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (new_ghist_old_history),
    .R0_data (io_get_ftq_pc_1_ghist_old_history)
  );
  ghist_40x1 ghist_1_current_saw_branch_not_taken_ext (
    .R0_addr (io_get_ftq_pc_1_ftq_idx),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_ghist_current_saw_branch_not_taken),
    .R0_data (io_get_ftq_pc_1_ghist_current_saw_branch_not_taken)
  );
  ghist_40x1 ghist_1_new_saw_branch_not_taken_ext (
    .R0_addr (io_get_ftq_pc_1_ftq_idx),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (new_ghist_new_saw_branch_not_taken),
    .R0_data (io_get_ftq_pc_1_ghist_new_saw_branch_not_taken)
  );
  ghist_40x1 ghist_1_new_saw_branch_taken_ext (
    .R0_addr (io_get_ftq_pc_1_ftq_idx),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (new_ghist_new_saw_branch_taken),
    .R0_data (io_get_ftq_pc_1_ghist_new_saw_branch_taken)
  );
  ghist_40x5 ghist_1_ras_idx_ext (
    .R0_addr (io_get_ftq_pc_1_ftq_idx),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (new_ghist_ras_idx),
    .R0_data (io_get_ftq_pc_1_ghist_ras_idx)
  );
  assign io_enq_ready = io_enq_ready_REG;
  assign io_enq_idx = enq_ptr;
  assign io_get_ftq_pc_0_entry_cfi_idx_valid = io_get_ftq_pc_0_entry_REG_cfi_idx_valid;
  assign io_get_ftq_pc_0_entry_cfi_idx_bits = io_get_ftq_pc_0_entry_REG_cfi_idx_bits;
  assign io_get_ftq_pc_0_entry_ras_idx = io_get_ftq_pc_0_entry_REG_ras_idx;
  assign io_get_ftq_pc_0_entry_start_bank = io_get_ftq_pc_0_entry_REG_start_bank;
  assign io_get_ftq_pc_0_pc = io_get_ftq_pc_0_pc_REG;
  assign io_get_ftq_pc_0_com_pc = io_get_ftq_pc_0_com_pc_REG;
  assign io_get_ftq_pc_0_next_val = io_get_ftq_pc_0_next_val_REG;
  assign io_get_ftq_pc_0_next_pc = io_get_ftq_pc_0_next_pc_REG;
  assign io_get_ftq_pc_1_entry_cfi_idx_bits = io_get_ftq_pc_1_entry_REG_cfi_idx_bits;
  assign io_get_ftq_pc_1_entry_br_mask = io_get_ftq_pc_1_entry_REG_br_mask;
  assign io_get_ftq_pc_1_entry_cfi_is_call = io_get_ftq_pc_1_entry_REG_cfi_is_call;
  assign io_get_ftq_pc_1_entry_cfi_is_ret = io_get_ftq_pc_1_entry_REG_cfi_is_ret;
  assign io_get_ftq_pc_1_entry_start_bank = io_get_ftq_pc_1_entry_REG_start_bank;
  assign io_get_ftq_pc_1_pc = io_get_ftq_pc_1_pc_REG;
  assign io_bpdupdate_valid = REG_2 & ~first_empty & (bpd_entry_cfi_idx_valid | (|bpd_entry_br_mask)) & ~(io_bpdupdate_valid_REG & bpd_pc == bpd_repair_pc);
  assign io_bpdupdate_bits_is_mispredict_update = io_bpdupdate_bits_is_mispredict_update_REG;
  assign io_bpdupdate_bits_is_repair_update = io_bpdupdate_bits_is_repair_update_REG;
  assign io_bpdupdate_bits_pc = bpd_pc;
  assign io_bpdupdate_bits_br_mask = ({8{~bpd_entry_cfi_idx_valid}} | {&bpd_entry_cfi_idx_bits, _GEN_11[6], _GEN_12[5], _GEN_13[4], _GEN_14[3], _GEN_15[2], _GEN_16[1], _GEN_16[0] | (&bpd_entry_cfi_idx_bits)}) & bpd_entry_br_mask;
  assign io_bpdupdate_bits_cfi_idx_valid = bpd_entry_cfi_idx_valid;
  assign io_bpdupdate_bits_cfi_idx_bits = bpd_entry_cfi_idx_bits;
  assign io_bpdupdate_bits_cfi_taken = bpd_entry_cfi_taken;
  assign io_bpdupdate_bits_cfi_mispredicted = bpd_entry_cfi_mispredicted;
  assign io_bpdupdate_bits_cfi_is_br = _io_bpdupdate_bits_cfi_is_br_T[0];
  assign io_bpdupdate_bits_cfi_is_jal = bpd_entry_cfi_type == 3'h2 | bpd_entry_cfi_type == 3'h3;
  assign io_bpdupdate_bits_ghist_old_history = _ghist_0_old_history_ext_R0_data;
  assign io_bpdupdate_bits_ghist_new_saw_branch_not_taken = _ghist_0_new_saw_branch_not_taken_ext_R0_data;
  assign io_bpdupdate_bits_ghist_new_saw_branch_taken = _ghist_0_new_saw_branch_taken_ext_R0_data;
  assign io_bpdupdate_bits_target = bpd_target;
  assign io_ras_update = io_ras_update_REG;
  assign io_ras_update_idx = io_ras_update_idx_REG;
  assign io_ras_update_pc = io_ras_update_pc_REG;
endmodule

