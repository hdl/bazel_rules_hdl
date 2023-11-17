// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module FAMicroBTBBranchPredictorBank(
  input          clock,
                 reset,
                 io_f0_valid,
  input  [39:0]  io_f0_pc,
  input          io_update_valid,
                 io_update_bits_is_mispredict_update,
                 io_update_bits_is_repair_update,
  input  [3:0]   io_update_bits_btb_mispredicts,
  input  [39:0]  io_update_bits_pc,
  input  [3:0]   io_update_bits_br_mask,
  input          io_update_bits_cfi_idx_valid,
  input  [1:0]   io_update_bits_cfi_idx_bits,
  input          io_update_bits_cfi_taken,
                 io_update_bits_cfi_is_jal,
  input  [39:0]  io_update_bits_target,
  input  [119:0] io_update_bits_meta,
  output         io_resp_f1_0_taken,
                 io_resp_f1_0_is_br,
                 io_resp_f1_0_is_jal,
                 io_resp_f1_0_predicted_pc_valid,
  output [39:0]  io_resp_f1_0_predicted_pc_bits,
  output         io_resp_f1_1_taken,
                 io_resp_f1_1_is_br,
                 io_resp_f1_1_is_jal,
                 io_resp_f1_1_predicted_pc_valid,
  output [39:0]  io_resp_f1_1_predicted_pc_bits,
  output         io_resp_f1_2_taken,
                 io_resp_f1_2_is_br,
                 io_resp_f1_2_is_jal,
                 io_resp_f1_2_predicted_pc_valid,
  output [39:0]  io_resp_f1_2_predicted_pc_bits,
  output         io_resp_f1_3_taken,
                 io_resp_f1_3_is_br,
                 io_resp_f1_3_is_jal,
                 io_resp_f1_3_predicted_pc_valid,
  output [39:0]  io_resp_f1_3_predicted_pc_bits,
  output         io_resp_f2_0_is_br,
                 io_resp_f2_0_is_jal,
                 io_resp_f2_0_predicted_pc_valid,
  output [39:0]  io_resp_f2_0_predicted_pc_bits,
  output         io_resp_f2_1_is_br,
                 io_resp_f2_1_is_jal,
                 io_resp_f2_1_predicted_pc_valid,
  output [39:0]  io_resp_f2_1_predicted_pc_bits,
  output         io_resp_f2_2_is_br,
                 io_resp_f2_2_is_jal,
                 io_resp_f2_2_predicted_pc_valid,
  output [39:0]  io_resp_f2_2_predicted_pc_bits,
  output         io_resp_f2_3_is_br,
                 io_resp_f2_3_is_jal,
                 io_resp_f2_3_predicted_pc_valid,
  output [39:0]  io_resp_f2_3_predicted_pc_bits,
  output         io_resp_f3_0_predicted_pc_valid,
  output [39:0]  io_resp_f3_0_predicted_pc_bits,
  output         io_resp_f3_1_predicted_pc_valid,
  output [39:0]  io_resp_f3_1_predicted_pc_bits,
  output         io_resp_f3_2_predicted_pc_valid,
  output [39:0]  io_resp_f3_2_predicted_pc_bits,
  output         io_resp_f3_3_predicted_pc_valid,
  output [39:0]  io_resp_f3_3_predicted_pc_bits,
  output [119:0] io_f3_meta
);

  reg  [12:0]  casez_tmp;
  reg          casez_tmp_0;
  reg  [1:0]   casez_tmp_1;
  reg  [12:0]  casez_tmp_2;
  reg          casez_tmp_3;
  reg  [1:0]   casez_tmp_4;
  reg  [12:0]  casez_tmp_5;
  reg          casez_tmp_6;
  reg  [1:0]   casez_tmp_7;
  reg  [12:0]  casez_tmp_8;
  reg          casez_tmp_9;
  reg  [1:0]   casez_tmp_10;
  reg  [1:0]   casez_tmp_11;
  reg  [1:0]   casez_tmp_12;
  reg  [1:0]   casez_tmp_13;
  reg  [1:0]   casez_tmp_14;
  reg  [35:0]  s1_idx;
  reg          s1_valid;
  reg  [39:0]  s1_pc;
  reg          s1_update__valid;
  reg          s1_update__bits_is_mispredict_update;
  reg          s1_update__bits_is_repair_update;
  reg  [3:0]   s1_update__bits_btb_mispredicts;
  reg  [39:0]  s1_update__bits_pc;
  reg  [3:0]   s1_update__bits_br_mask;
  reg          s1_update__bits_cfi_idx_valid;
  reg  [1:0]   s1_update__bits_cfi_idx_bits;
  reg          s1_update__bits_cfi_taken;
  reg          s1_update__bits_cfi_is_jal;
  reg  [39:0]  s1_update__bits_target;
  reg  [119:0] s1_update__bits_meta;
  reg  [35:0]  s1_update_idx;
  reg  [35:0]  meta_0_0_tag;
  wire         s1_hit_ohs_0_0 = meta_0_0_tag == s1_idx;
  reg  [35:0]  meta_1_0_tag;
  wire         s1_hit_ohs_0_1 = meta_1_0_tag == s1_idx;
  reg  [35:0]  meta_2_0_tag;
  wire         s1_hit_ohs_0_2 = meta_2_0_tag == s1_idx;
  reg  [35:0]  meta_3_0_tag;
  wire         s1_hit_ohs_0_3 = meta_3_0_tag == s1_idx;
  reg  [35:0]  meta_4_0_tag;
  wire         s1_hit_ohs_0_4 = meta_4_0_tag == s1_idx;
  reg  [35:0]  meta_5_0_tag;
  wire         s1_hit_ohs_0_5 = meta_5_0_tag == s1_idx;
  reg  [35:0]  meta_6_0_tag;
  wire         s1_hit_ohs_0_6 = meta_6_0_tag == s1_idx;
  reg  [35:0]  meta_7_0_tag;
  wire         s1_hit_ohs_0_7 = meta_7_0_tag == s1_idx;
  reg  [35:0]  meta_8_0_tag;
  wire         s1_hit_ohs_0_8 = meta_8_0_tag == s1_idx;
  reg  [35:0]  meta_9_0_tag;
  wire         s1_hit_ohs_0_9 = meta_9_0_tag == s1_idx;
  reg  [35:0]  meta_10_0_tag;
  wire         s1_hit_ohs_0_10 = meta_10_0_tag == s1_idx;
  reg  [35:0]  meta_11_0_tag;
  wire         s1_hit_ohs_0_11 = meta_11_0_tag == s1_idx;
  reg  [35:0]  meta_12_0_tag;
  wire         s1_hit_ohs_0_12 = meta_12_0_tag == s1_idx;
  reg  [35:0]  meta_13_0_tag;
  wire         s1_hit_ohs_0_13 = meta_13_0_tag == s1_idx;
  reg  [35:0]  meta_14_0_tag;
  wire         s1_hit_ohs_0_14 = meta_14_0_tag == s1_idx;
  reg  [35:0]  meta_15_0_tag;
  wire         s1_hits_0 = s1_hit_ohs_0_0 | s1_hit_ohs_0_1 | s1_hit_ohs_0_2 | s1_hit_ohs_0_3 | s1_hit_ohs_0_4 | s1_hit_ohs_0_5 | s1_hit_ohs_0_6 | s1_hit_ohs_0_7 | s1_hit_ohs_0_8 | s1_hit_ohs_0_9 | s1_hit_ohs_0_10 | s1_hit_ohs_0_11 | s1_hit_ohs_0_12 | s1_hit_ohs_0_13 | s1_hit_ohs_0_14 | meta_15_0_tag == s1_idx;
  reg  [35:0]  meta_0_1_tag;
  wire         s1_hit_ohs_1_0 = meta_0_1_tag == s1_idx;
  reg  [35:0]  meta_1_1_tag;
  wire         s1_hit_ohs_1_1 = meta_1_1_tag == s1_idx;
  reg  [35:0]  meta_2_1_tag;
  wire         s1_hit_ohs_1_2 = meta_2_1_tag == s1_idx;
  reg  [35:0]  meta_3_1_tag;
  wire         s1_hit_ohs_1_3 = meta_3_1_tag == s1_idx;
  reg  [35:0]  meta_4_1_tag;
  wire         s1_hit_ohs_1_4 = meta_4_1_tag == s1_idx;
  reg  [35:0]  meta_5_1_tag;
  wire         s1_hit_ohs_1_5 = meta_5_1_tag == s1_idx;
  reg  [35:0]  meta_6_1_tag;
  wire         s1_hit_ohs_1_6 = meta_6_1_tag == s1_idx;
  reg  [35:0]  meta_7_1_tag;
  wire         s1_hit_ohs_1_7 = meta_7_1_tag == s1_idx;
  reg  [35:0]  meta_8_1_tag;
  wire         s1_hit_ohs_1_8 = meta_8_1_tag == s1_idx;
  reg  [35:0]  meta_9_1_tag;
  wire         s1_hit_ohs_1_9 = meta_9_1_tag == s1_idx;
  reg  [35:0]  meta_10_1_tag;
  wire         s1_hit_ohs_1_10 = meta_10_1_tag == s1_idx;
  reg  [35:0]  meta_11_1_tag;
  wire         s1_hit_ohs_1_11 = meta_11_1_tag == s1_idx;
  reg  [35:0]  meta_12_1_tag;
  wire         s1_hit_ohs_1_12 = meta_12_1_tag == s1_idx;
  reg  [35:0]  meta_13_1_tag;
  wire         s1_hit_ohs_1_13 = meta_13_1_tag == s1_idx;
  reg  [35:0]  meta_14_1_tag;
  wire         s1_hit_ohs_1_14 = meta_14_1_tag == s1_idx;
  reg  [35:0]  meta_15_1_tag;
  wire         s1_hits_1 = s1_hit_ohs_1_0 | s1_hit_ohs_1_1 | s1_hit_ohs_1_2 | s1_hit_ohs_1_3 | s1_hit_ohs_1_4 | s1_hit_ohs_1_5 | s1_hit_ohs_1_6 | s1_hit_ohs_1_7 | s1_hit_ohs_1_8 | s1_hit_ohs_1_9 | s1_hit_ohs_1_10 | s1_hit_ohs_1_11 | s1_hit_ohs_1_12 | s1_hit_ohs_1_13 | s1_hit_ohs_1_14 | meta_15_1_tag == s1_idx;
  reg  [35:0]  meta_0_2_tag;
  wire         s1_hit_ohs_2_0 = meta_0_2_tag == s1_idx;
  reg  [35:0]  meta_1_2_tag;
  wire         s1_hit_ohs_2_1 = meta_1_2_tag == s1_idx;
  reg  [35:0]  meta_2_2_tag;
  wire         s1_hit_ohs_2_2 = meta_2_2_tag == s1_idx;
  reg  [35:0]  meta_3_2_tag;
  wire         s1_hit_ohs_2_3 = meta_3_2_tag == s1_idx;
  reg  [35:0]  meta_4_2_tag;
  wire         s1_hit_ohs_2_4 = meta_4_2_tag == s1_idx;
  reg  [35:0]  meta_5_2_tag;
  wire         s1_hit_ohs_2_5 = meta_5_2_tag == s1_idx;
  reg  [35:0]  meta_6_2_tag;
  wire         s1_hit_ohs_2_6 = meta_6_2_tag == s1_idx;
  reg  [35:0]  meta_7_2_tag;
  wire         s1_hit_ohs_2_7 = meta_7_2_tag == s1_idx;
  reg  [35:0]  meta_8_2_tag;
  wire         s1_hit_ohs_2_8 = meta_8_2_tag == s1_idx;
  reg  [35:0]  meta_9_2_tag;
  wire         s1_hit_ohs_2_9 = meta_9_2_tag == s1_idx;
  reg  [35:0]  meta_10_2_tag;
  wire         s1_hit_ohs_2_10 = meta_10_2_tag == s1_idx;
  reg  [35:0]  meta_11_2_tag;
  wire         s1_hit_ohs_2_11 = meta_11_2_tag == s1_idx;
  reg  [35:0]  meta_12_2_tag;
  wire         s1_hit_ohs_2_12 = meta_12_2_tag == s1_idx;
  reg  [35:0]  meta_13_2_tag;
  wire         s1_hit_ohs_2_13 = meta_13_2_tag == s1_idx;
  reg  [35:0]  meta_14_2_tag;
  wire         s1_hit_ohs_2_14 = meta_14_2_tag == s1_idx;
  reg  [35:0]  meta_15_2_tag;
  wire         s1_hits_2 = s1_hit_ohs_2_0 | s1_hit_ohs_2_1 | s1_hit_ohs_2_2 | s1_hit_ohs_2_3 | s1_hit_ohs_2_4 | s1_hit_ohs_2_5 | s1_hit_ohs_2_6 | s1_hit_ohs_2_7 | s1_hit_ohs_2_8 | s1_hit_ohs_2_9 | s1_hit_ohs_2_10 | s1_hit_ohs_2_11 | s1_hit_ohs_2_12 | s1_hit_ohs_2_13 | s1_hit_ohs_2_14 | meta_15_2_tag == s1_idx;
  reg  [35:0]  meta_0_3_tag;
  wire         s1_hit_ohs_3_0 = meta_0_3_tag == s1_idx;
  reg  [35:0]  meta_1_3_tag;
  wire         s1_hit_ohs_3_1 = meta_1_3_tag == s1_idx;
  reg  [35:0]  meta_2_3_tag;
  wire         s1_hit_ohs_3_2 = meta_2_3_tag == s1_idx;
  reg  [35:0]  meta_3_3_tag;
  wire         s1_hit_ohs_3_3 = meta_3_3_tag == s1_idx;
  reg  [35:0]  meta_4_3_tag;
  wire         s1_hit_ohs_3_4 = meta_4_3_tag == s1_idx;
  reg  [35:0]  meta_5_3_tag;
  wire         s1_hit_ohs_3_5 = meta_5_3_tag == s1_idx;
  reg  [35:0]  meta_6_3_tag;
  wire         s1_hit_ohs_3_6 = meta_6_3_tag == s1_idx;
  reg  [35:0]  meta_7_3_tag;
  wire         s1_hit_ohs_3_7 = meta_7_3_tag == s1_idx;
  reg  [35:0]  meta_8_3_tag;
  wire         s1_hit_ohs_3_8 = meta_8_3_tag == s1_idx;
  reg  [35:0]  meta_9_3_tag;
  wire         s1_hit_ohs_3_9 = meta_9_3_tag == s1_idx;
  reg  [35:0]  meta_10_3_tag;
  wire         s1_hit_ohs_3_10 = meta_10_3_tag == s1_idx;
  reg  [35:0]  meta_11_3_tag;
  wire         s1_hit_ohs_3_11 = meta_11_3_tag == s1_idx;
  reg  [35:0]  meta_12_3_tag;
  wire         s1_hit_ohs_3_12 = meta_12_3_tag == s1_idx;
  reg  [35:0]  meta_13_3_tag;
  wire         s1_hit_ohs_3_13 = meta_13_3_tag == s1_idx;
  reg  [35:0]  meta_14_3_tag;
  wire         s1_hit_ohs_3_14 = meta_14_3_tag == s1_idx;
  reg  [35:0]  meta_15_3_tag;
  wire         s1_hits_3 = s1_hit_ohs_3_0 | s1_hit_ohs_3_1 | s1_hit_ohs_3_2 | s1_hit_ohs_3_3 | s1_hit_ohs_3_4 | s1_hit_ohs_3_5 | s1_hit_ohs_3_6 | s1_hit_ohs_3_7 | s1_hit_ohs_3_8 | s1_hit_ohs_3_9 | s1_hit_ohs_3_10 | s1_hit_ohs_3_11 | s1_hit_ohs_3_12 | s1_hit_ohs_3_13 | s1_hit_ohs_3_14 | meta_15_3_tag == s1_idx;
  reg          meta_0_0_is_br;
  reg  [1:0]   meta_0_0_ctr;
  reg          meta_0_1_is_br;
  reg  [1:0]   meta_0_1_ctr;
  reg          meta_0_2_is_br;
  reg  [1:0]   meta_0_2_ctr;
  reg          meta_0_3_is_br;
  reg  [1:0]   meta_0_3_ctr;
  reg          meta_1_0_is_br;
  reg  [1:0]   meta_1_0_ctr;
  reg          meta_1_1_is_br;
  reg  [1:0]   meta_1_1_ctr;
  reg          meta_1_2_is_br;
  reg  [1:0]   meta_1_2_ctr;
  reg          meta_1_3_is_br;
  reg  [1:0]   meta_1_3_ctr;
  reg          meta_2_0_is_br;
  reg  [1:0]   meta_2_0_ctr;
  reg          meta_2_1_is_br;
  reg  [1:0]   meta_2_1_ctr;
  reg          meta_2_2_is_br;
  reg  [1:0]   meta_2_2_ctr;
  reg          meta_2_3_is_br;
  reg  [1:0]   meta_2_3_ctr;
  reg          meta_3_0_is_br;
  reg  [1:0]   meta_3_0_ctr;
  reg          meta_3_1_is_br;
  reg  [1:0]   meta_3_1_ctr;
  reg          meta_3_2_is_br;
  reg  [1:0]   meta_3_2_ctr;
  reg          meta_3_3_is_br;
  reg  [1:0]   meta_3_3_ctr;
  reg          meta_4_0_is_br;
  reg  [1:0]   meta_4_0_ctr;
  reg          meta_4_1_is_br;
  reg  [1:0]   meta_4_1_ctr;
  reg          meta_4_2_is_br;
  reg  [1:0]   meta_4_2_ctr;
  reg          meta_4_3_is_br;
  reg  [1:0]   meta_4_3_ctr;
  reg          meta_5_0_is_br;
  reg  [1:0]   meta_5_0_ctr;
  reg          meta_5_1_is_br;
  reg  [1:0]   meta_5_1_ctr;
  reg          meta_5_2_is_br;
  reg  [1:0]   meta_5_2_ctr;
  reg          meta_5_3_is_br;
  reg  [1:0]   meta_5_3_ctr;
  reg          meta_6_0_is_br;
  reg  [1:0]   meta_6_0_ctr;
  reg          meta_6_1_is_br;
  reg  [1:0]   meta_6_1_ctr;
  reg          meta_6_2_is_br;
  reg  [1:0]   meta_6_2_ctr;
  reg          meta_6_3_is_br;
  reg  [1:0]   meta_6_3_ctr;
  reg          meta_7_0_is_br;
  reg  [1:0]   meta_7_0_ctr;
  reg          meta_7_1_is_br;
  reg  [1:0]   meta_7_1_ctr;
  reg          meta_7_2_is_br;
  reg  [1:0]   meta_7_2_ctr;
  reg          meta_7_3_is_br;
  reg  [1:0]   meta_7_3_ctr;
  reg          meta_8_0_is_br;
  reg  [1:0]   meta_8_0_ctr;
  reg          meta_8_1_is_br;
  reg  [1:0]   meta_8_1_ctr;
  reg          meta_8_2_is_br;
  reg  [1:0]   meta_8_2_ctr;
  reg          meta_8_3_is_br;
  reg  [1:0]   meta_8_3_ctr;
  reg          meta_9_0_is_br;
  reg  [1:0]   meta_9_0_ctr;
  reg          meta_9_1_is_br;
  reg  [1:0]   meta_9_1_ctr;
  reg          meta_9_2_is_br;
  reg  [1:0]   meta_9_2_ctr;
  reg          meta_9_3_is_br;
  reg  [1:0]   meta_9_3_ctr;
  reg          meta_10_0_is_br;
  reg  [1:0]   meta_10_0_ctr;
  reg          meta_10_1_is_br;
  reg  [1:0]   meta_10_1_ctr;
  reg          meta_10_2_is_br;
  reg  [1:0]   meta_10_2_ctr;
  reg          meta_10_3_is_br;
  reg  [1:0]   meta_10_3_ctr;
  reg          meta_11_0_is_br;
  reg  [1:0]   meta_11_0_ctr;
  reg          meta_11_1_is_br;
  reg  [1:0]   meta_11_1_ctr;
  reg          meta_11_2_is_br;
  reg  [1:0]   meta_11_2_ctr;
  reg          meta_11_3_is_br;
  reg  [1:0]   meta_11_3_ctr;
  reg          meta_12_0_is_br;
  reg  [1:0]   meta_12_0_ctr;
  reg          meta_12_1_is_br;
  reg  [1:0]   meta_12_1_ctr;
  reg          meta_12_2_is_br;
  reg  [1:0]   meta_12_2_ctr;
  reg          meta_12_3_is_br;
  reg  [1:0]   meta_12_3_ctr;
  reg          meta_13_0_is_br;
  reg  [1:0]   meta_13_0_ctr;
  reg          meta_13_1_is_br;
  reg  [1:0]   meta_13_1_ctr;
  reg          meta_13_2_is_br;
  reg  [1:0]   meta_13_2_ctr;
  reg          meta_13_3_is_br;
  reg  [1:0]   meta_13_3_ctr;
  reg          meta_14_0_is_br;
  reg  [1:0]   meta_14_0_ctr;
  reg          meta_14_1_is_br;
  reg  [1:0]   meta_14_1_ctr;
  reg          meta_14_2_is_br;
  reg  [1:0]   meta_14_2_ctr;
  reg          meta_14_3_is_br;
  reg  [1:0]   meta_14_3_ctr;
  reg          meta_15_0_is_br;
  reg  [1:0]   meta_15_0_ctr;
  reg          meta_15_1_is_br;
  reg  [1:0]   meta_15_1_ctr;
  reg          meta_15_2_is_br;
  reg  [1:0]   meta_15_2_ctr;
  reg          meta_15_3_is_br;
  reg  [1:0]   meta_15_3_ctr;
  reg  [12:0]  btb_0_0_offset;
  reg  [12:0]  btb_0_1_offset;
  reg  [12:0]  btb_0_2_offset;
  reg  [12:0]  btb_0_3_offset;
  reg  [12:0]  btb_1_0_offset;
  reg  [12:0]  btb_1_1_offset;
  reg  [12:0]  btb_1_2_offset;
  reg  [12:0]  btb_1_3_offset;
  reg  [12:0]  btb_2_0_offset;
  reg  [12:0]  btb_2_1_offset;
  reg  [12:0]  btb_2_2_offset;
  reg  [12:0]  btb_2_3_offset;
  reg  [12:0]  btb_3_0_offset;
  reg  [12:0]  btb_3_1_offset;
  reg  [12:0]  btb_3_2_offset;
  reg  [12:0]  btb_3_3_offset;
  reg  [12:0]  btb_4_0_offset;
  reg  [12:0]  btb_4_1_offset;
  reg  [12:0]  btb_4_2_offset;
  reg  [12:0]  btb_4_3_offset;
  reg  [12:0]  btb_5_0_offset;
  reg  [12:0]  btb_5_1_offset;
  reg  [12:0]  btb_5_2_offset;
  reg  [12:0]  btb_5_3_offset;
  reg  [12:0]  btb_6_0_offset;
  reg  [12:0]  btb_6_1_offset;
  reg  [12:0]  btb_6_2_offset;
  reg  [12:0]  btb_6_3_offset;
  reg  [12:0]  btb_7_0_offset;
  reg  [12:0]  btb_7_1_offset;
  reg  [12:0]  btb_7_2_offset;
  reg  [12:0]  btb_7_3_offset;
  reg  [12:0]  btb_8_0_offset;
  reg  [12:0]  btb_8_1_offset;
  reg  [12:0]  btb_8_2_offset;
  reg  [12:0]  btb_8_3_offset;
  reg  [12:0]  btb_9_0_offset;
  reg  [12:0]  btb_9_1_offset;
  reg  [12:0]  btb_9_2_offset;
  reg  [12:0]  btb_9_3_offset;
  reg  [12:0]  btb_10_0_offset;
  reg  [12:0]  btb_10_1_offset;
  reg  [12:0]  btb_10_2_offset;
  reg  [12:0]  btb_10_3_offset;
  reg  [12:0]  btb_11_0_offset;
  reg  [12:0]  btb_11_1_offset;
  reg  [12:0]  btb_11_2_offset;
  reg  [12:0]  btb_11_3_offset;
  reg  [12:0]  btb_12_0_offset;
  reg  [12:0]  btb_12_1_offset;
  reg  [12:0]  btb_12_2_offset;
  reg  [12:0]  btb_12_3_offset;
  reg  [12:0]  btb_13_0_offset;
  reg  [12:0]  btb_13_1_offset;
  reg  [12:0]  btb_13_2_offset;
  reg  [12:0]  btb_13_3_offset;
  reg  [12:0]  btb_14_0_offset;
  reg  [12:0]  btb_14_1_offset;
  reg  [12:0]  btb_14_2_offset;
  reg  [12:0]  btb_14_3_offset;
  reg  [12:0]  btb_15_0_offset;
  reg  [12:0]  btb_15_1_offset;
  reg  [12:0]  btb_15_2_offset;
  reg  [12:0]  btb_15_3_offset;
  wire [3:0]   s1_hit_ways_0 = s1_hit_ohs_0_0 ? 4'h0 : s1_hit_ohs_0_1 ? 4'h1 : s1_hit_ohs_0_2 ? 4'h2 : s1_hit_ohs_0_3 ? 4'h3 : s1_hit_ohs_0_4 ? 4'h4 : s1_hit_ohs_0_5 ? 4'h5 : s1_hit_ohs_0_6 ? 4'h6 : s1_hit_ohs_0_7 ? 4'h7 : s1_hit_ohs_0_8 ? 4'h8 : s1_hit_ohs_0_9 ? 4'h9 : s1_hit_ohs_0_10 ? 4'hA : s1_hit_ohs_0_11 ? 4'hB : s1_hit_ohs_0_12 ? 4'hC : s1_hit_ohs_0_13 ? 4'hD : {3'h7, ~s1_hit_ohs_0_14};
  wire [3:0]   s1_hit_ways_1 = s1_hit_ohs_1_0 ? 4'h0 : s1_hit_ohs_1_1 ? 4'h1 : s1_hit_ohs_1_2 ? 4'h2 : s1_hit_ohs_1_3 ? 4'h3 : s1_hit_ohs_1_4 ? 4'h4 : s1_hit_ohs_1_5 ? 4'h5 : s1_hit_ohs_1_6 ? 4'h6 : s1_hit_ohs_1_7 ? 4'h7 : s1_hit_ohs_1_8 ? 4'h8 : s1_hit_ohs_1_9 ? 4'h9 : s1_hit_ohs_1_10 ? 4'hA : s1_hit_ohs_1_11 ? 4'hB : s1_hit_ohs_1_12 ? 4'hC : s1_hit_ohs_1_13 ? 4'hD : {3'h7, ~s1_hit_ohs_1_14};
  wire [3:0]   s1_hit_ways_2 = s1_hit_ohs_2_0 ? 4'h0 : s1_hit_ohs_2_1 ? 4'h1 : s1_hit_ohs_2_2 ? 4'h2 : s1_hit_ohs_2_3 ? 4'h3 : s1_hit_ohs_2_4 ? 4'h4 : s1_hit_ohs_2_5 ? 4'h5 : s1_hit_ohs_2_6 ? 4'h6 : s1_hit_ohs_2_7 ? 4'h7 : s1_hit_ohs_2_8 ? 4'h8 : s1_hit_ohs_2_9 ? 4'h9 : s1_hit_ohs_2_10 ? 4'hA : s1_hit_ohs_2_11 ? 4'hB : s1_hit_ohs_2_12 ? 4'hC : s1_hit_ohs_2_13 ? 4'hD : {3'h7, ~s1_hit_ohs_2_14};
  wire [3:0]   s1_hit_ways_3 = s1_hit_ohs_3_0 ? 4'h0 : s1_hit_ohs_3_1 ? 4'h1 : s1_hit_ohs_3_2 ? 4'h2 : s1_hit_ohs_3_3 ? 4'h3 : s1_hit_ohs_3_4 ? 4'h4 : s1_hit_ohs_3_5 ? 4'h5 : s1_hit_ohs_3_6 ? 4'h6 : s1_hit_ohs_3_7 ? 4'h7 : s1_hit_ohs_3_8 ? 4'h8 : s1_hit_ohs_3_9 ? 4'h9 : s1_hit_ohs_3_10 ? 4'hA : s1_hit_ohs_3_11 ? 4'hB : s1_hit_ohs_3_12 ? 4'hC : s1_hit_ohs_3_13 ? 4'hD : {3'h7, ~s1_hit_ohs_3_14};
  wire         _io_resp_f1_0_predicted_pc_valid_output = s1_valid & s1_hits_0;
  always @(*) begin
    casez (s1_hit_ways_0)
      4'b0000:
        casez_tmp = btb_0_0_offset;
      4'b0001:
        casez_tmp = btb_1_0_offset;
      4'b0010:
        casez_tmp = btb_2_0_offset;
      4'b0011:
        casez_tmp = btb_3_0_offset;
      4'b0100:
        casez_tmp = btb_4_0_offset;
      4'b0101:
        casez_tmp = btb_5_0_offset;
      4'b0110:
        casez_tmp = btb_6_0_offset;
      4'b0111:
        casez_tmp = btb_7_0_offset;
      4'b1000:
        casez_tmp = btb_8_0_offset;
      4'b1001:
        casez_tmp = btb_9_0_offset;
      4'b1010:
        casez_tmp = btb_10_0_offset;
      4'b1011:
        casez_tmp = btb_11_0_offset;
      4'b1100:
        casez_tmp = btb_12_0_offset;
      4'b1101:
        casez_tmp = btb_13_0_offset;
      4'b1110:
        casez_tmp = btb_14_0_offset;
      default:
        casez_tmp = btb_15_0_offset;
    endcase
  end // always @(*)
  wire [39:0]  _s1_resp_0_bits_T_4 = s1_pc + {{27{casez_tmp[12]}}, casez_tmp};
  always @(*) begin
    casez (s1_hit_ways_0)
      4'b0000:
        casez_tmp_0 = meta_0_0_is_br;
      4'b0001:
        casez_tmp_0 = meta_1_0_is_br;
      4'b0010:
        casez_tmp_0 = meta_2_0_is_br;
      4'b0011:
        casez_tmp_0 = meta_3_0_is_br;
      4'b0100:
        casez_tmp_0 = meta_4_0_is_br;
      4'b0101:
        casez_tmp_0 = meta_5_0_is_br;
      4'b0110:
        casez_tmp_0 = meta_6_0_is_br;
      4'b0111:
        casez_tmp_0 = meta_7_0_is_br;
      4'b1000:
        casez_tmp_0 = meta_8_0_is_br;
      4'b1001:
        casez_tmp_0 = meta_9_0_is_br;
      4'b1010:
        casez_tmp_0 = meta_10_0_is_br;
      4'b1011:
        casez_tmp_0 = meta_11_0_is_br;
      4'b1100:
        casez_tmp_0 = meta_12_0_is_br;
      4'b1101:
        casez_tmp_0 = meta_13_0_is_br;
      4'b1110:
        casez_tmp_0 = meta_14_0_is_br;
      default:
        casez_tmp_0 = meta_15_0_is_br;
    endcase
  end // always @(*)
  wire         _io_resp_f1_0_is_br_output = _io_resp_f1_0_predicted_pc_valid_output & casez_tmp_0;
  wire         _io_resp_f1_0_is_jal_output = _io_resp_f1_0_predicted_pc_valid_output & ~casez_tmp_0;
  always @(*) begin
    casez (s1_hit_ways_0)
      4'b0000:
        casez_tmp_1 = meta_0_0_ctr;
      4'b0001:
        casez_tmp_1 = meta_1_0_ctr;
      4'b0010:
        casez_tmp_1 = meta_2_0_ctr;
      4'b0011:
        casez_tmp_1 = meta_3_0_ctr;
      4'b0100:
        casez_tmp_1 = meta_4_0_ctr;
      4'b0101:
        casez_tmp_1 = meta_5_0_ctr;
      4'b0110:
        casez_tmp_1 = meta_6_0_ctr;
      4'b0111:
        casez_tmp_1 = meta_7_0_ctr;
      4'b1000:
        casez_tmp_1 = meta_8_0_ctr;
      4'b1001:
        casez_tmp_1 = meta_9_0_ctr;
      4'b1010:
        casez_tmp_1 = meta_10_0_ctr;
      4'b1011:
        casez_tmp_1 = meta_11_0_ctr;
      4'b1100:
        casez_tmp_1 = meta_12_0_ctr;
      4'b1101:
        casez_tmp_1 = meta_13_0_ctr;
      4'b1110:
        casez_tmp_1 = meta_14_0_ctr;
      default:
        casez_tmp_1 = meta_15_0_ctr;
    endcase
  end // always @(*)
  wire         _io_resp_f1_1_predicted_pc_valid_output = s1_valid & s1_hits_1;
  always @(*) begin
    casez (s1_hit_ways_1)
      4'b0000:
        casez_tmp_2 = btb_0_1_offset;
      4'b0001:
        casez_tmp_2 = btb_1_1_offset;
      4'b0010:
        casez_tmp_2 = btb_2_1_offset;
      4'b0011:
        casez_tmp_2 = btb_3_1_offset;
      4'b0100:
        casez_tmp_2 = btb_4_1_offset;
      4'b0101:
        casez_tmp_2 = btb_5_1_offset;
      4'b0110:
        casez_tmp_2 = btb_6_1_offset;
      4'b0111:
        casez_tmp_2 = btb_7_1_offset;
      4'b1000:
        casez_tmp_2 = btb_8_1_offset;
      4'b1001:
        casez_tmp_2 = btb_9_1_offset;
      4'b1010:
        casez_tmp_2 = btb_10_1_offset;
      4'b1011:
        casez_tmp_2 = btb_11_1_offset;
      4'b1100:
        casez_tmp_2 = btb_12_1_offset;
      4'b1101:
        casez_tmp_2 = btb_13_1_offset;
      4'b1110:
        casez_tmp_2 = btb_14_1_offset;
      default:
        casez_tmp_2 = btb_15_1_offset;
    endcase
  end // always @(*)
  wire [39:0]  _s1_resp_1_bits_T_4 = s1_pc + {{27{casez_tmp_2[12]}}, casez_tmp_2} + 40'h2;
  always @(*) begin
    casez (s1_hit_ways_1)
      4'b0000:
        casez_tmp_3 = meta_0_1_is_br;
      4'b0001:
        casez_tmp_3 = meta_1_1_is_br;
      4'b0010:
        casez_tmp_3 = meta_2_1_is_br;
      4'b0011:
        casez_tmp_3 = meta_3_1_is_br;
      4'b0100:
        casez_tmp_3 = meta_4_1_is_br;
      4'b0101:
        casez_tmp_3 = meta_5_1_is_br;
      4'b0110:
        casez_tmp_3 = meta_6_1_is_br;
      4'b0111:
        casez_tmp_3 = meta_7_1_is_br;
      4'b1000:
        casez_tmp_3 = meta_8_1_is_br;
      4'b1001:
        casez_tmp_3 = meta_9_1_is_br;
      4'b1010:
        casez_tmp_3 = meta_10_1_is_br;
      4'b1011:
        casez_tmp_3 = meta_11_1_is_br;
      4'b1100:
        casez_tmp_3 = meta_12_1_is_br;
      4'b1101:
        casez_tmp_3 = meta_13_1_is_br;
      4'b1110:
        casez_tmp_3 = meta_14_1_is_br;
      default:
        casez_tmp_3 = meta_15_1_is_br;
    endcase
  end // always @(*)
  wire         _io_resp_f1_1_is_br_output = _io_resp_f1_1_predicted_pc_valid_output & casez_tmp_3;
  wire         _io_resp_f1_1_is_jal_output = _io_resp_f1_1_predicted_pc_valid_output & ~casez_tmp_3;
  always @(*) begin
    casez (s1_hit_ways_1)
      4'b0000:
        casez_tmp_4 = meta_0_1_ctr;
      4'b0001:
        casez_tmp_4 = meta_1_1_ctr;
      4'b0010:
        casez_tmp_4 = meta_2_1_ctr;
      4'b0011:
        casez_tmp_4 = meta_3_1_ctr;
      4'b0100:
        casez_tmp_4 = meta_4_1_ctr;
      4'b0101:
        casez_tmp_4 = meta_5_1_ctr;
      4'b0110:
        casez_tmp_4 = meta_6_1_ctr;
      4'b0111:
        casez_tmp_4 = meta_7_1_ctr;
      4'b1000:
        casez_tmp_4 = meta_8_1_ctr;
      4'b1001:
        casez_tmp_4 = meta_9_1_ctr;
      4'b1010:
        casez_tmp_4 = meta_10_1_ctr;
      4'b1011:
        casez_tmp_4 = meta_11_1_ctr;
      4'b1100:
        casez_tmp_4 = meta_12_1_ctr;
      4'b1101:
        casez_tmp_4 = meta_13_1_ctr;
      4'b1110:
        casez_tmp_4 = meta_14_1_ctr;
      default:
        casez_tmp_4 = meta_15_1_ctr;
    endcase
  end // always @(*)
  wire         _io_resp_f1_2_predicted_pc_valid_output = s1_valid & s1_hits_2;
  always @(*) begin
    casez (s1_hit_ways_2)
      4'b0000:
        casez_tmp_5 = btb_0_2_offset;
      4'b0001:
        casez_tmp_5 = btb_1_2_offset;
      4'b0010:
        casez_tmp_5 = btb_2_2_offset;
      4'b0011:
        casez_tmp_5 = btb_3_2_offset;
      4'b0100:
        casez_tmp_5 = btb_4_2_offset;
      4'b0101:
        casez_tmp_5 = btb_5_2_offset;
      4'b0110:
        casez_tmp_5 = btb_6_2_offset;
      4'b0111:
        casez_tmp_5 = btb_7_2_offset;
      4'b1000:
        casez_tmp_5 = btb_8_2_offset;
      4'b1001:
        casez_tmp_5 = btb_9_2_offset;
      4'b1010:
        casez_tmp_5 = btb_10_2_offset;
      4'b1011:
        casez_tmp_5 = btb_11_2_offset;
      4'b1100:
        casez_tmp_5 = btb_12_2_offset;
      4'b1101:
        casez_tmp_5 = btb_13_2_offset;
      4'b1110:
        casez_tmp_5 = btb_14_2_offset;
      default:
        casez_tmp_5 = btb_15_2_offset;
    endcase
  end // always @(*)
  wire [39:0]  _s1_resp_2_bits_T_4 = s1_pc + {{27{casez_tmp_5[12]}}, casez_tmp_5} + 40'h4;
  always @(*) begin
    casez (s1_hit_ways_2)
      4'b0000:
        casez_tmp_6 = meta_0_2_is_br;
      4'b0001:
        casez_tmp_6 = meta_1_2_is_br;
      4'b0010:
        casez_tmp_6 = meta_2_2_is_br;
      4'b0011:
        casez_tmp_6 = meta_3_2_is_br;
      4'b0100:
        casez_tmp_6 = meta_4_2_is_br;
      4'b0101:
        casez_tmp_6 = meta_5_2_is_br;
      4'b0110:
        casez_tmp_6 = meta_6_2_is_br;
      4'b0111:
        casez_tmp_6 = meta_7_2_is_br;
      4'b1000:
        casez_tmp_6 = meta_8_2_is_br;
      4'b1001:
        casez_tmp_6 = meta_9_2_is_br;
      4'b1010:
        casez_tmp_6 = meta_10_2_is_br;
      4'b1011:
        casez_tmp_6 = meta_11_2_is_br;
      4'b1100:
        casez_tmp_6 = meta_12_2_is_br;
      4'b1101:
        casez_tmp_6 = meta_13_2_is_br;
      4'b1110:
        casez_tmp_6 = meta_14_2_is_br;
      default:
        casez_tmp_6 = meta_15_2_is_br;
    endcase
  end // always @(*)
  wire         _io_resp_f1_2_is_br_output = _io_resp_f1_2_predicted_pc_valid_output & casez_tmp_6;
  wire         _io_resp_f1_2_is_jal_output = _io_resp_f1_2_predicted_pc_valid_output & ~casez_tmp_6;
  always @(*) begin
    casez (s1_hit_ways_2)
      4'b0000:
        casez_tmp_7 = meta_0_2_ctr;
      4'b0001:
        casez_tmp_7 = meta_1_2_ctr;
      4'b0010:
        casez_tmp_7 = meta_2_2_ctr;
      4'b0011:
        casez_tmp_7 = meta_3_2_ctr;
      4'b0100:
        casez_tmp_7 = meta_4_2_ctr;
      4'b0101:
        casez_tmp_7 = meta_5_2_ctr;
      4'b0110:
        casez_tmp_7 = meta_6_2_ctr;
      4'b0111:
        casez_tmp_7 = meta_7_2_ctr;
      4'b1000:
        casez_tmp_7 = meta_8_2_ctr;
      4'b1001:
        casez_tmp_7 = meta_9_2_ctr;
      4'b1010:
        casez_tmp_7 = meta_10_2_ctr;
      4'b1011:
        casez_tmp_7 = meta_11_2_ctr;
      4'b1100:
        casez_tmp_7 = meta_12_2_ctr;
      4'b1101:
        casez_tmp_7 = meta_13_2_ctr;
      4'b1110:
        casez_tmp_7 = meta_14_2_ctr;
      default:
        casez_tmp_7 = meta_15_2_ctr;
    endcase
  end // always @(*)
  wire         _io_resp_f1_3_predicted_pc_valid_output = s1_valid & s1_hits_3;
  always @(*) begin
    casez (s1_hit_ways_3)
      4'b0000:
        casez_tmp_8 = btb_0_3_offset;
      4'b0001:
        casez_tmp_8 = btb_1_3_offset;
      4'b0010:
        casez_tmp_8 = btb_2_3_offset;
      4'b0011:
        casez_tmp_8 = btb_3_3_offset;
      4'b0100:
        casez_tmp_8 = btb_4_3_offset;
      4'b0101:
        casez_tmp_8 = btb_5_3_offset;
      4'b0110:
        casez_tmp_8 = btb_6_3_offset;
      4'b0111:
        casez_tmp_8 = btb_7_3_offset;
      4'b1000:
        casez_tmp_8 = btb_8_3_offset;
      4'b1001:
        casez_tmp_8 = btb_9_3_offset;
      4'b1010:
        casez_tmp_8 = btb_10_3_offset;
      4'b1011:
        casez_tmp_8 = btb_11_3_offset;
      4'b1100:
        casez_tmp_8 = btb_12_3_offset;
      4'b1101:
        casez_tmp_8 = btb_13_3_offset;
      4'b1110:
        casez_tmp_8 = btb_14_3_offset;
      default:
        casez_tmp_8 = btb_15_3_offset;
    endcase
  end // always @(*)
  wire [39:0]  _s1_resp_3_bits_T_4 = s1_pc + {{27{casez_tmp_8[12]}}, casez_tmp_8} + 40'h6;
  always @(*) begin
    casez (s1_hit_ways_3)
      4'b0000:
        casez_tmp_9 = meta_0_3_is_br;
      4'b0001:
        casez_tmp_9 = meta_1_3_is_br;
      4'b0010:
        casez_tmp_9 = meta_2_3_is_br;
      4'b0011:
        casez_tmp_9 = meta_3_3_is_br;
      4'b0100:
        casez_tmp_9 = meta_4_3_is_br;
      4'b0101:
        casez_tmp_9 = meta_5_3_is_br;
      4'b0110:
        casez_tmp_9 = meta_6_3_is_br;
      4'b0111:
        casez_tmp_9 = meta_7_3_is_br;
      4'b1000:
        casez_tmp_9 = meta_8_3_is_br;
      4'b1001:
        casez_tmp_9 = meta_9_3_is_br;
      4'b1010:
        casez_tmp_9 = meta_10_3_is_br;
      4'b1011:
        casez_tmp_9 = meta_11_3_is_br;
      4'b1100:
        casez_tmp_9 = meta_12_3_is_br;
      4'b1101:
        casez_tmp_9 = meta_13_3_is_br;
      4'b1110:
        casez_tmp_9 = meta_14_3_is_br;
      default:
        casez_tmp_9 = meta_15_3_is_br;
    endcase
  end // always @(*)
  wire         _io_resp_f1_3_is_br_output = _io_resp_f1_3_predicted_pc_valid_output & casez_tmp_9;
  wire         _io_resp_f1_3_is_jal_output = _io_resp_f1_3_predicted_pc_valid_output & ~casez_tmp_9;
  always @(*) begin
    casez (s1_hit_ways_3)
      4'b0000:
        casez_tmp_10 = meta_0_3_ctr;
      4'b0001:
        casez_tmp_10 = meta_1_3_ctr;
      4'b0010:
        casez_tmp_10 = meta_2_3_ctr;
      4'b0011:
        casez_tmp_10 = meta_3_3_ctr;
      4'b0100:
        casez_tmp_10 = meta_4_3_ctr;
      4'b0101:
        casez_tmp_10 = meta_5_3_ctr;
      4'b0110:
        casez_tmp_10 = meta_6_3_ctr;
      4'b0111:
        casez_tmp_10 = meta_7_3_ctr;
      4'b1000:
        casez_tmp_10 = meta_8_3_ctr;
      4'b1001:
        casez_tmp_10 = meta_9_3_ctr;
      4'b1010:
        casez_tmp_10 = meta_10_3_ctr;
      4'b1011:
        casez_tmp_10 = meta_11_3_ctr;
      4'b1100:
        casez_tmp_10 = meta_12_3_ctr;
      4'b1101:
        casez_tmp_10 = meta_13_3_ctr;
      4'b1110:
        casez_tmp_10 = meta_14_3_ctr;
      default:
        casez_tmp_10 = meta_15_3_ctr;
    endcase
  end // always @(*)
  reg          io_resp_f2_0_REG_is_br;
  reg          io_resp_f2_0_REG_is_jal;
  reg          io_resp_f2_0_REG_predicted_pc_valid;
  reg  [39:0]  io_resp_f2_0_REG_predicted_pc_bits;
  reg          io_resp_f3_0_REG_predicted_pc_valid;
  reg  [39:0]  io_resp_f3_0_REG_predicted_pc_bits;
  reg          io_resp_f2_1_REG_is_br;
  reg          io_resp_f2_1_REG_is_jal;
  reg          io_resp_f2_1_REG_predicted_pc_valid;
  reg  [39:0]  io_resp_f2_1_REG_predicted_pc_bits;
  reg          io_resp_f3_1_REG_predicted_pc_valid;
  reg  [39:0]  io_resp_f3_1_REG_predicted_pc_bits;
  reg          io_resp_f2_2_REG_is_br;
  reg          io_resp_f2_2_REG_is_jal;
  reg          io_resp_f2_2_REG_predicted_pc_valid;
  reg  [39:0]  io_resp_f2_2_REG_predicted_pc_bits;
  reg          io_resp_f3_2_REG_predicted_pc_valid;
  reg  [39:0]  io_resp_f3_2_REG_predicted_pc_bits;
  reg          io_resp_f2_3_REG_is_br;
  reg          io_resp_f2_3_REG_is_jal;
  reg          io_resp_f2_3_REG_predicted_pc_valid;
  reg  [39:0]  io_resp_f2_3_REG_predicted_pc_bits;
  reg          io_resp_f3_3_REG_predicted_pc_valid;
  reg  [39:0]  io_resp_f3_3_REG_predicted_pc_bits;
  reg  [7:0]   io_f3_meta_REG;
  reg  [7:0]   io_f3_meta_REG_1;
  always @(*) begin
    casez (s1_update__bits_meta[3:0])
      4'b0000:
        casez_tmp_11 = meta_0_0_ctr;
      4'b0001:
        casez_tmp_11 = meta_1_0_ctr;
      4'b0010:
        casez_tmp_11 = meta_2_0_ctr;
      4'b0011:
        casez_tmp_11 = meta_3_0_ctr;
      4'b0100:
        casez_tmp_11 = meta_4_0_ctr;
      4'b0101:
        casez_tmp_11 = meta_5_0_ctr;
      4'b0110:
        casez_tmp_11 = meta_6_0_ctr;
      4'b0111:
        casez_tmp_11 = meta_7_0_ctr;
      4'b1000:
        casez_tmp_11 = meta_8_0_ctr;
      4'b1001:
        casez_tmp_11 = meta_9_0_ctr;
      4'b1010:
        casez_tmp_11 = meta_10_0_ctr;
      4'b1011:
        casez_tmp_11 = meta_11_0_ctr;
      4'b1100:
        casez_tmp_11 = meta_12_0_ctr;
      4'b1101:
        casez_tmp_11 = meta_13_0_ctr;
      4'b1110:
        casez_tmp_11 = meta_14_0_ctr;
      default:
        casez_tmp_11 = meta_15_0_ctr;
    endcase
  end // always @(*)
  always @(*) begin
    casez (s1_update__bits_meta[3:0])
      4'b0000:
        casez_tmp_12 = meta_0_1_ctr;
      4'b0001:
        casez_tmp_12 = meta_1_1_ctr;
      4'b0010:
        casez_tmp_12 = meta_2_1_ctr;
      4'b0011:
        casez_tmp_12 = meta_3_1_ctr;
      4'b0100:
        casez_tmp_12 = meta_4_1_ctr;
      4'b0101:
        casez_tmp_12 = meta_5_1_ctr;
      4'b0110:
        casez_tmp_12 = meta_6_1_ctr;
      4'b0111:
        casez_tmp_12 = meta_7_1_ctr;
      4'b1000:
        casez_tmp_12 = meta_8_1_ctr;
      4'b1001:
        casez_tmp_12 = meta_9_1_ctr;
      4'b1010:
        casez_tmp_12 = meta_10_1_ctr;
      4'b1011:
        casez_tmp_12 = meta_11_1_ctr;
      4'b1100:
        casez_tmp_12 = meta_12_1_ctr;
      4'b1101:
        casez_tmp_12 = meta_13_1_ctr;
      4'b1110:
        casez_tmp_12 = meta_14_1_ctr;
      default:
        casez_tmp_12 = meta_15_1_ctr;
    endcase
  end // always @(*)
  always @(*) begin
    casez (s1_update__bits_meta[3:0])
      4'b0000:
        casez_tmp_13 = meta_0_2_ctr;
      4'b0001:
        casez_tmp_13 = meta_1_2_ctr;
      4'b0010:
        casez_tmp_13 = meta_2_2_ctr;
      4'b0011:
        casez_tmp_13 = meta_3_2_ctr;
      4'b0100:
        casez_tmp_13 = meta_4_2_ctr;
      4'b0101:
        casez_tmp_13 = meta_5_2_ctr;
      4'b0110:
        casez_tmp_13 = meta_6_2_ctr;
      4'b0111:
        casez_tmp_13 = meta_7_2_ctr;
      4'b1000:
        casez_tmp_13 = meta_8_2_ctr;
      4'b1001:
        casez_tmp_13 = meta_9_2_ctr;
      4'b1010:
        casez_tmp_13 = meta_10_2_ctr;
      4'b1011:
        casez_tmp_13 = meta_11_2_ctr;
      4'b1100:
        casez_tmp_13 = meta_12_2_ctr;
      4'b1101:
        casez_tmp_13 = meta_13_2_ctr;
      4'b1110:
        casez_tmp_13 = meta_14_2_ctr;
      default:
        casez_tmp_13 = meta_15_2_ctr;
    endcase
  end // always @(*)
  always @(*) begin
    casez (s1_update__bits_meta[3:0])
      4'b0000:
        casez_tmp_14 = meta_0_3_ctr;
      4'b0001:
        casez_tmp_14 = meta_1_3_ctr;
      4'b0010:
        casez_tmp_14 = meta_2_3_ctr;
      4'b0011:
        casez_tmp_14 = meta_3_3_ctr;
      4'b0100:
        casez_tmp_14 = meta_4_3_ctr;
      4'b0101:
        casez_tmp_14 = meta_5_3_ctr;
      4'b0110:
        casez_tmp_14 = meta_6_3_ctr;
      4'b0111:
        casez_tmp_14 = meta_7_3_ctr;
      4'b1000:
        casez_tmp_14 = meta_8_3_ctr;
      4'b1001:
        casez_tmp_14 = meta_9_3_ctr;
      4'b1010:
        casez_tmp_14 = meta_10_3_ctr;
      4'b1011:
        casez_tmp_14 = meta_11_3_ctr;
      4'b1100:
        casez_tmp_14 = meta_12_3_ctr;
      4'b1101:
        casez_tmp_14 = meta_13_3_ctr;
      4'b1110:
        casez_tmp_14 = meta_14_3_ctr;
      default:
        casez_tmp_14 = meta_15_3_ctr;
    endcase
  end // always @(*)
  wire         _was_taken_T_11 = s1_update__bits_cfi_taken | s1_update__bits_cfi_is_jal;
  wire         was_taken = ~(|s1_update__bits_cfi_idx_bits) & s1_update__bits_cfi_idx_valid & _was_taken_T_11;
  wire [1:0]   _meta_0_ctr_T_1 = {2{was_taken}};
  wire         _meta_0_ctr_T_2 = (&casez_tmp_11) & was_taken;
  wire         _meta_0_ctr_T_4 = casez_tmp_11 == 2'h0 & ~was_taken;
  wire [1:0]   _meta_0_ctr_T_5 = casez_tmp_11 + 2'h1;
  wire [1:0]   _meta_0_ctr_T_7 = casez_tmp_11 - 2'h1;
  wire         _was_taken_T_3 = s1_update__bits_cfi_idx_bits == 2'h1;
  wire         was_taken_1 = _was_taken_T_3 & s1_update__bits_cfi_idx_valid & _was_taken_T_11;
  wire [1:0]   _meta_1_ctr_T_1 = {2{was_taken_1}};
  wire         _meta_1_ctr_T_2 = (&casez_tmp_12) & was_taken_1;
  wire         _meta_1_ctr_T_4 = casez_tmp_12 == 2'h0 & ~was_taken_1;
  wire [1:0]   _meta_1_ctr_T_5 = casez_tmp_12 + 2'h1;
  wire [1:0]   _meta_1_ctr_T_7 = casez_tmp_12 - 2'h1;
  wire         _was_taken_T_6 = s1_update__bits_cfi_idx_bits == 2'h2;
  wire         was_taken_2 = _was_taken_T_6 & s1_update__bits_cfi_idx_valid & _was_taken_T_11;
  wire [1:0]   _meta_2_ctr_T_1 = {2{was_taken_2}};
  wire         _meta_2_ctr_T_2 = (&casez_tmp_13) & was_taken_2;
  wire         _meta_2_ctr_T_4 = casez_tmp_13 == 2'h0 & ~was_taken_2;
  wire [1:0]   _meta_2_ctr_T_5 = casez_tmp_13 + 2'h1;
  wire [1:0]   _meta_2_ctr_T_7 = casez_tmp_13 - 2'h1;
  wire         was_taken_3 = (&s1_update__bits_cfi_idx_bits) & s1_update__bits_cfi_idx_valid & _was_taken_T_11;
  wire [1:0]   _meta_3_ctr_T_1 = {2{was_taken_3}};
  wire         _meta_3_ctr_T_2 = (&casez_tmp_14) & was_taken_3;
  wire         _meta_3_ctr_T_4 = casez_tmp_14 == 2'h0 & ~was_taken_3;
  wire [1:0]   _meta_3_ctr_T_5 = casez_tmp_14 + 2'h1;
  wire [1:0]   _meta_3_ctr_T_7 = casez_tmp_14 - 2'h1;
  wire [14:0]  _s1_meta_write_way_T_9 = {s1_hit_ohs_0_14, s1_hit_ohs_0_13, s1_hit_ohs_0_12, s1_hit_ohs_0_11, s1_hit_ohs_0_10, s1_hit_ohs_0_9, s1_hit_ohs_0_8, s1_hit_ohs_0_7, s1_hit_ohs_0_6, s1_hit_ohs_0_5, s1_hit_ohs_0_4, s1_hit_ohs_0_3, s1_hit_ohs_0_2, s1_hit_ohs_0_1, s1_hit_ohs_0_0} | {s1_hit_ohs_1_14, s1_hit_ohs_1_13, s1_hit_ohs_1_12, s1_hit_ohs_1_11, s1_hit_ohs_1_10, s1_hit_ohs_1_9, s1_hit_ohs_1_8, s1_hit_ohs_1_7, s1_hit_ohs_1_6, s1_hit_ohs_1_5, s1_hit_ohs_1_4, s1_hit_ohs_1_3, s1_hit_ohs_1_2, s1_hit_ohs_1_1, s1_hit_ohs_1_0} | {s1_hit_ohs_2_14, s1_hit_ohs_2_13, s1_hit_ohs_2_12, s1_hit_ohs_2_11, s1_hit_ohs_2_10, s1_hit_ohs_2_9, s1_hit_ohs_2_8, s1_hit_ohs_2_7, s1_hit_ohs_2_6, s1_hit_ohs_2_5, s1_hit_ohs_2_4, s1_hit_ohs_2_3, s1_hit_ohs_2_2, s1_hit_ohs_2_1, s1_hit_ohs_2_0} | {s1_hit_ohs_3_14, s1_hit_ohs_3_13, s1_hit_ohs_3_12, s1_hit_ohs_3_11, s1_hit_ohs_3_10, s1_hit_ohs_3_9, s1_hit_ohs_3_8, s1_hit_ohs_3_7, s1_hit_ohs_3_6, s1_hit_ohs_3_5, s1_hit_ohs_3_4, s1_hit_ohs_3_3, s1_hit_ohs_3_2, s1_hit_ohs_3_1, s1_hit_ohs_3_0};
  wire [12:0]  _new_offset_value_T_5 = s1_update__bits_target[12:0] - (s1_update__bits_pc[12:0] + {10'h0, s1_update__bits_cfi_idx_bits, 1'h0});
  wire         _GEN = s1_update__bits_is_mispredict_update | s1_update__bits_is_repair_update | (|s1_update__bits_btb_mispredicts);
  wire         _GEN_0 = s1_update__valid & s1_update__bits_cfi_taken & s1_update__bits_cfi_idx_valid & ~_GEN;
  wire         _GEN_1 = s1_update__bits_meta[3:0] == 4'h0;
  wire         _GEN_2 = s1_update__bits_cfi_idx_bits == 2'h1;
  wire         _GEN_3 = s1_update__bits_cfi_idx_bits == 2'h2;
  wire         _GEN_4 = s1_update__bits_meta[3:0] == 4'h1;
  wire         _GEN_5 = s1_update__bits_meta[3:0] == 4'h2;
  wire         _GEN_6 = s1_update__bits_meta[3:0] == 4'h3;
  wire         _GEN_7 = s1_update__bits_meta[3:0] == 4'h4;
  wire         _GEN_8 = s1_update__bits_meta[3:0] == 4'h5;
  wire         _GEN_9 = s1_update__bits_meta[3:0] == 4'h6;
  wire         _GEN_10 = s1_update__bits_meta[3:0] == 4'h7;
  wire         _GEN_11 = s1_update__bits_meta[3:0] == 4'h8;
  wire         _GEN_12 = s1_update__bits_meta[3:0] == 4'h9;
  wire         _GEN_13 = s1_update__bits_meta[3:0] == 4'hA;
  wire         _GEN_14 = s1_update__bits_meta[3:0] == 4'hB;
  wire         _GEN_15 = s1_update__bits_meta[3:0] == 4'hC;
  wire         _GEN_16 = s1_update__bits_meta[3:0] == 4'hD;
  wire         _GEN_17 = s1_update__bits_meta[3:0] == 4'hE;
  wire [3:0]   _GEN_18 =
    s1_idx[3:0] ^ s1_idx[7:4] ^ s1_idx[11:8] ^ s1_idx[15:12] ^ s1_idx[19:16] ^ s1_idx[23:20] ^ s1_idx[27:24] ^ s1_idx[31:28] ^ s1_idx[35:32] ^ meta_0_0_tag[3:0] ^ meta_0_0_tag[7:4] ^ meta_0_0_tag[11:8] ^ meta_0_0_tag[15:12] ^ meta_0_0_tag[19:16] ^ meta_0_0_tag[23:20] ^ meta_0_0_tag[27:24] ^ meta_0_0_tag[31:28] ^ meta_0_0_tag[35:32] ^ meta_0_1_tag[3:0] ^ meta_0_1_tag[7:4] ^ meta_0_1_tag[11:8] ^ meta_0_1_tag[15:12] ^ meta_0_1_tag[19:16] ^ meta_0_1_tag[23:20] ^ meta_0_1_tag[27:24] ^ meta_0_1_tag[31:28] ^ meta_0_1_tag[35:32] ^ meta_0_2_tag[3:0] ^ meta_0_2_tag[7:4] ^ meta_0_2_tag[11:8] ^ meta_0_2_tag[15:12] ^ meta_0_2_tag[19:16] ^ meta_0_2_tag[23:20] ^ meta_0_2_tag[27:24] ^ meta_0_2_tag[31:28] ^ meta_0_2_tag[35:32] ^ meta_0_3_tag[3:0] ^ meta_0_3_tag[7:4] ^ meta_0_3_tag[11:8] ^ meta_0_3_tag[15:12] ^ meta_0_3_tag[19:16] ^ meta_0_3_tag[23:20] ^ meta_0_3_tag[27:24] ^ meta_0_3_tag[31:28] ^ meta_0_3_tag[35:32] ^ meta_1_0_tag[3:0] ^ meta_1_0_tag[7:4] ^ meta_1_0_tag[11:8] ^ meta_1_0_tag[15:12] ^ meta_1_0_tag[19:16] ^ meta_1_0_tag[23:20] ^ meta_1_0_tag[27:24] ^ meta_1_0_tag[31:28] ^ meta_1_0_tag[35:32] ^ meta_1_1_tag[3:0] ^ meta_1_1_tag[7:4] ^ meta_1_1_tag[11:8] ^ meta_1_1_tag[15:12] ^ meta_1_1_tag[19:16] ^ meta_1_1_tag[23:20] ^ meta_1_1_tag[27:24] ^ meta_1_1_tag[31:28] ^ meta_1_1_tag[35:32] ^ meta_1_2_tag[3:0] ^ meta_1_2_tag[7:4] ^ meta_1_2_tag[11:8] ^ meta_1_2_tag[15:12] ^ meta_1_2_tag[19:16] ^ meta_1_2_tag[23:20] ^ meta_1_2_tag[27:24] ^ meta_1_2_tag[31:28] ^ meta_1_2_tag[35:32] ^ meta_1_3_tag[3:0] ^ meta_1_3_tag[7:4] ^ meta_1_3_tag[11:8] ^ meta_1_3_tag[15:12] ^ meta_1_3_tag[19:16] ^ meta_1_3_tag[23:20] ^ meta_1_3_tag[27:24] ^ meta_1_3_tag[31:28] ^ meta_1_3_tag[35:32] ^ meta_2_0_tag[3:0] ^ meta_2_0_tag[7:4] ^ meta_2_0_tag[11:8] ^ meta_2_0_tag[15:12] ^ meta_2_0_tag[19:16] ^ meta_2_0_tag[23:20] ^ meta_2_0_tag[27:24] ^ meta_2_0_tag[31:28] ^ meta_2_0_tag[35:32] ^ meta_2_1_tag[3:0] ^ meta_2_1_tag[7:4] ^ meta_2_1_tag[11:8] ^ meta_2_1_tag[15:12] ^ meta_2_1_tag[19:16] ^ meta_2_1_tag[23:20] ^ meta_2_1_tag[27:24] ^ meta_2_1_tag[31:28]
    ^ meta_2_1_tag[35:32] ^ meta_2_2_tag[3:0] ^ meta_2_2_tag[7:4] ^ meta_2_2_tag[11:8] ^ meta_2_2_tag[15:12] ^ meta_2_2_tag[19:16] ^ meta_2_2_tag[23:20] ^ meta_2_2_tag[27:24] ^ meta_2_2_tag[31:28] ^ meta_2_2_tag[35:32] ^ meta_2_3_tag[3:0] ^ meta_2_3_tag[7:4] ^ meta_2_3_tag[11:8] ^ meta_2_3_tag[15:12] ^ meta_2_3_tag[19:16] ^ meta_2_3_tag[23:20] ^ meta_2_3_tag[27:24] ^ meta_2_3_tag[31:28] ^ meta_2_3_tag[35:32] ^ meta_3_0_tag[3:0] ^ meta_3_0_tag[7:4] ^ meta_3_0_tag[11:8] ^ meta_3_0_tag[15:12] ^ meta_3_0_tag[19:16] ^ meta_3_0_tag[23:20] ^ meta_3_0_tag[27:24] ^ meta_3_0_tag[31:28] ^ meta_3_0_tag[35:32] ^ meta_3_1_tag[3:0] ^ meta_3_1_tag[7:4] ^ meta_3_1_tag[11:8] ^ meta_3_1_tag[15:12] ^ meta_3_1_tag[19:16] ^ meta_3_1_tag[23:20] ^ meta_3_1_tag[27:24] ^ meta_3_1_tag[31:28] ^ meta_3_1_tag[35:32] ^ meta_3_2_tag[3:0] ^ meta_3_2_tag[7:4] ^ meta_3_2_tag[11:8] ^ meta_3_2_tag[15:12] ^ meta_3_2_tag[19:16] ^ meta_3_2_tag[23:20] ^ meta_3_2_tag[27:24] ^ meta_3_2_tag[31:28] ^ meta_3_2_tag[35:32] ^ meta_3_3_tag[3:0] ^ meta_3_3_tag[7:4] ^ meta_3_3_tag[11:8] ^ meta_3_3_tag[15:12] ^ meta_3_3_tag[19:16] ^ meta_3_3_tag[23:20] ^ meta_3_3_tag[27:24] ^ meta_3_3_tag[31:28] ^ meta_3_3_tag[35:32] ^ meta_4_0_tag[3:0] ^ meta_4_0_tag[7:4] ^ meta_4_0_tag[11:8] ^ meta_4_0_tag[15:12] ^ meta_4_0_tag[19:16] ^ meta_4_0_tag[23:20] ^ meta_4_0_tag[27:24] ^ meta_4_0_tag[31:28] ^ meta_4_0_tag[35:32] ^ meta_4_1_tag[3:0] ^ meta_4_1_tag[7:4] ^ meta_4_1_tag[11:8] ^ meta_4_1_tag[15:12] ^ meta_4_1_tag[19:16] ^ meta_4_1_tag[23:20] ^ meta_4_1_tag[27:24] ^ meta_4_1_tag[31:28] ^ meta_4_1_tag[35:32] ^ meta_4_2_tag[3:0] ^ meta_4_2_tag[7:4] ^ meta_4_2_tag[11:8] ^ meta_4_2_tag[15:12] ^ meta_4_2_tag[19:16] ^ meta_4_2_tag[23:20] ^ meta_4_2_tag[27:24] ^ meta_4_2_tag[31:28] ^ meta_4_2_tag[35:32] ^ meta_4_3_tag[3:0] ^ meta_4_3_tag[7:4] ^ meta_4_3_tag[11:8] ^ meta_4_3_tag[15:12] ^ meta_4_3_tag[19:16] ^ meta_4_3_tag[23:20] ^ meta_4_3_tag[27:24] ^ meta_4_3_tag[31:28] ^ meta_4_3_tag[35:32] ^ meta_5_0_tag[3:0] ^ meta_5_0_tag[7:4] ^ meta_5_0_tag[11:8] ^ meta_5_0_tag[15:12]
    ^ meta_5_0_tag[19:16] ^ meta_5_0_tag[23:20] ^ meta_5_0_tag[27:24] ^ meta_5_0_tag[31:28] ^ meta_5_0_tag[35:32] ^ meta_5_1_tag[3:0] ^ meta_5_1_tag[7:4] ^ meta_5_1_tag[11:8] ^ meta_5_1_tag[15:12] ^ meta_5_1_tag[19:16] ^ meta_5_1_tag[23:20] ^ meta_5_1_tag[27:24] ^ meta_5_1_tag[31:28] ^ meta_5_1_tag[35:32] ^ meta_5_2_tag[3:0] ^ meta_5_2_tag[7:4] ^ meta_5_2_tag[11:8] ^ meta_5_2_tag[15:12] ^ meta_5_2_tag[19:16] ^ meta_5_2_tag[23:20] ^ meta_5_2_tag[27:24] ^ meta_5_2_tag[31:28] ^ meta_5_2_tag[35:32] ^ meta_5_3_tag[3:0] ^ meta_5_3_tag[7:4] ^ meta_5_3_tag[11:8] ^ meta_5_3_tag[15:12] ^ meta_5_3_tag[19:16] ^ meta_5_3_tag[23:20] ^ meta_5_3_tag[27:24] ^ meta_5_3_tag[31:28] ^ meta_5_3_tag[35:32] ^ meta_6_0_tag[3:0] ^ meta_6_0_tag[7:4] ^ meta_6_0_tag[11:8] ^ meta_6_0_tag[15:12] ^ meta_6_0_tag[19:16] ^ meta_6_0_tag[23:20] ^ meta_6_0_tag[27:24] ^ meta_6_0_tag[31:28] ^ meta_6_0_tag[35:32] ^ meta_6_1_tag[3:0] ^ meta_6_1_tag[7:4] ^ meta_6_1_tag[11:8] ^ meta_6_1_tag[15:12] ^ meta_6_1_tag[19:16] ^ meta_6_1_tag[23:20] ^ meta_6_1_tag[27:24] ^ meta_6_1_tag[31:28] ^ meta_6_1_tag[35:32] ^ meta_6_2_tag[3:0] ^ meta_6_2_tag[7:4] ^ meta_6_2_tag[11:8] ^ meta_6_2_tag[15:12] ^ meta_6_2_tag[19:16] ^ meta_6_2_tag[23:20] ^ meta_6_2_tag[27:24] ^ meta_6_2_tag[31:28] ^ meta_6_2_tag[35:32] ^ meta_6_3_tag[3:0] ^ meta_6_3_tag[7:4] ^ meta_6_3_tag[11:8] ^ meta_6_3_tag[15:12] ^ meta_6_3_tag[19:16] ^ meta_6_3_tag[23:20] ^ meta_6_3_tag[27:24] ^ meta_6_3_tag[31:28] ^ meta_6_3_tag[35:32] ^ meta_7_0_tag[3:0] ^ meta_7_0_tag[7:4] ^ meta_7_0_tag[11:8] ^ meta_7_0_tag[15:12] ^ meta_7_0_tag[19:16] ^ meta_7_0_tag[23:20] ^ meta_7_0_tag[27:24] ^ meta_7_0_tag[31:28] ^ meta_7_0_tag[35:32] ^ meta_7_1_tag[3:0] ^ meta_7_1_tag[7:4] ^ meta_7_1_tag[11:8] ^ meta_7_1_tag[15:12] ^ meta_7_1_tag[19:16] ^ meta_7_1_tag[23:20] ^ meta_7_1_tag[27:24] ^ meta_7_1_tag[31:28] ^ meta_7_1_tag[35:32] ^ meta_7_2_tag[3:0] ^ meta_7_2_tag[7:4] ^ meta_7_2_tag[11:8] ^ meta_7_2_tag[15:12] ^ meta_7_2_tag[19:16] ^ meta_7_2_tag[23:20] ^ meta_7_2_tag[27:24] ^ meta_7_2_tag[31:28] ^ meta_7_2_tag[35:32]
    ^ meta_7_3_tag[3:0] ^ meta_7_3_tag[7:4] ^ meta_7_3_tag[11:8] ^ meta_7_3_tag[15:12];
  wire [3:0]   _GEN_19 =
    meta_7_3_tag[19:16] ^ meta_7_3_tag[23:20] ^ meta_7_3_tag[27:24] ^ meta_7_3_tag[31:28] ^ meta_7_3_tag[35:32] ^ meta_8_0_tag[3:0] ^ meta_8_0_tag[7:4] ^ meta_8_0_tag[11:8] ^ meta_8_0_tag[15:12] ^ meta_8_0_tag[19:16] ^ meta_8_0_tag[23:20] ^ meta_8_0_tag[27:24] ^ meta_8_0_tag[31:28] ^ meta_8_0_tag[35:32] ^ meta_8_1_tag[3:0] ^ meta_8_1_tag[7:4] ^ meta_8_1_tag[11:8] ^ meta_8_1_tag[15:12] ^ meta_8_1_tag[19:16] ^ meta_8_1_tag[23:20] ^ meta_8_1_tag[27:24] ^ meta_8_1_tag[31:28] ^ meta_8_1_tag[35:32] ^ meta_8_2_tag[3:0] ^ meta_8_2_tag[7:4] ^ meta_8_2_tag[11:8] ^ meta_8_2_tag[15:12] ^ meta_8_2_tag[19:16] ^ meta_8_2_tag[23:20] ^ meta_8_2_tag[27:24] ^ meta_8_2_tag[31:28] ^ meta_8_2_tag[35:32] ^ meta_8_3_tag[3:0] ^ meta_8_3_tag[7:4] ^ meta_8_3_tag[11:8] ^ meta_8_3_tag[15:12] ^ meta_8_3_tag[19:16] ^ meta_8_3_tag[23:20] ^ meta_8_3_tag[27:24] ^ meta_8_3_tag[31:28] ^ meta_8_3_tag[35:32] ^ meta_9_0_tag[3:0] ^ meta_9_0_tag[7:4] ^ meta_9_0_tag[11:8] ^ meta_9_0_tag[15:12] ^ meta_9_0_tag[19:16] ^ meta_9_0_tag[23:20] ^ meta_9_0_tag[27:24] ^ meta_9_0_tag[31:28] ^ meta_9_0_tag[35:32] ^ meta_9_1_tag[3:0] ^ meta_9_1_tag[7:4] ^ meta_9_1_tag[11:8] ^ meta_9_1_tag[15:12] ^ meta_9_1_tag[19:16] ^ meta_9_1_tag[23:20] ^ meta_9_1_tag[27:24] ^ meta_9_1_tag[31:28] ^ meta_9_1_tag[35:32] ^ meta_9_2_tag[3:0] ^ meta_9_2_tag[7:4] ^ meta_9_2_tag[11:8] ^ meta_9_2_tag[15:12] ^ meta_9_2_tag[19:16] ^ meta_9_2_tag[23:20] ^ meta_9_2_tag[27:24] ^ meta_9_2_tag[31:28] ^ meta_9_2_tag[35:32] ^ meta_9_3_tag[3:0] ^ meta_9_3_tag[7:4] ^ meta_9_3_tag[11:8] ^ meta_9_3_tag[15:12] ^ meta_9_3_tag[19:16] ^ meta_9_3_tag[23:20] ^ meta_9_3_tag[27:24] ^ meta_9_3_tag[31:28] ^ meta_9_3_tag[35:32] ^ meta_10_0_tag[3:0] ^ meta_10_0_tag[7:4] ^ meta_10_0_tag[11:8] ^ meta_10_0_tag[15:12] ^ meta_10_0_tag[19:16] ^ meta_10_0_tag[23:20] ^ meta_10_0_tag[27:24] ^ meta_10_0_tag[31:28] ^ meta_10_0_tag[35:32] ^ meta_10_1_tag[3:0] ^ meta_10_1_tag[7:4] ^ meta_10_1_tag[11:8] ^ meta_10_1_tag[15:12] ^ meta_10_1_tag[19:16] ^ meta_10_1_tag[23:20] ^ meta_10_1_tag[27:24] ^ meta_10_1_tag[31:28]
    ^ meta_10_1_tag[35:32] ^ meta_10_2_tag[3:0] ^ meta_10_2_tag[7:4] ^ meta_10_2_tag[11:8] ^ meta_10_2_tag[15:12] ^ meta_10_2_tag[19:16] ^ meta_10_2_tag[23:20] ^ meta_10_2_tag[27:24] ^ meta_10_2_tag[31:28] ^ meta_10_2_tag[35:32] ^ meta_10_3_tag[3:0] ^ meta_10_3_tag[7:4] ^ meta_10_3_tag[11:8] ^ meta_10_3_tag[15:12] ^ meta_10_3_tag[19:16] ^ meta_10_3_tag[23:20] ^ meta_10_3_tag[27:24] ^ meta_10_3_tag[31:28] ^ meta_10_3_tag[35:32] ^ meta_11_0_tag[3:0] ^ meta_11_0_tag[7:4] ^ meta_11_0_tag[11:8] ^ meta_11_0_tag[15:12] ^ meta_11_0_tag[19:16] ^ meta_11_0_tag[23:20] ^ meta_11_0_tag[27:24] ^ meta_11_0_tag[31:28] ^ meta_11_0_tag[35:32] ^ meta_11_1_tag[3:0] ^ meta_11_1_tag[7:4] ^ meta_11_1_tag[11:8] ^ meta_11_1_tag[15:12] ^ meta_11_1_tag[19:16] ^ meta_11_1_tag[23:20] ^ meta_11_1_tag[27:24] ^ meta_11_1_tag[31:28] ^ meta_11_1_tag[35:32] ^ meta_11_2_tag[3:0] ^ meta_11_2_tag[7:4] ^ meta_11_2_tag[11:8] ^ meta_11_2_tag[15:12] ^ meta_11_2_tag[19:16] ^ meta_11_2_tag[23:20] ^ meta_11_2_tag[27:24] ^ meta_11_2_tag[31:28] ^ meta_11_2_tag[35:32] ^ meta_11_3_tag[3:0] ^ meta_11_3_tag[7:4] ^ meta_11_3_tag[11:8] ^ meta_11_3_tag[15:12] ^ meta_11_3_tag[19:16] ^ meta_11_3_tag[23:20] ^ meta_11_3_tag[27:24] ^ meta_11_3_tag[31:28] ^ meta_11_3_tag[35:32] ^ meta_12_0_tag[3:0] ^ meta_12_0_tag[7:4] ^ meta_12_0_tag[11:8] ^ meta_12_0_tag[15:12] ^ meta_12_0_tag[19:16] ^ meta_12_0_tag[23:20] ^ meta_12_0_tag[27:24] ^ meta_12_0_tag[31:28] ^ meta_12_0_tag[35:32] ^ meta_12_1_tag[3:0] ^ meta_12_1_tag[7:4] ^ meta_12_1_tag[11:8] ^ meta_12_1_tag[15:12] ^ meta_12_1_tag[19:16] ^ meta_12_1_tag[23:20] ^ meta_12_1_tag[27:24] ^ meta_12_1_tag[31:28] ^ meta_12_1_tag[35:32] ^ meta_12_2_tag[3:0] ^ meta_12_2_tag[7:4] ^ meta_12_2_tag[11:8] ^ meta_12_2_tag[15:12] ^ meta_12_2_tag[19:16] ^ meta_12_2_tag[23:20] ^ meta_12_2_tag[27:24] ^ meta_12_2_tag[31:28] ^ meta_12_2_tag[35:32] ^ meta_12_3_tag[3:0] ^ meta_12_3_tag[7:4] ^ meta_12_3_tag[11:8] ^ meta_12_3_tag[15:12] ^ meta_12_3_tag[19:16] ^ meta_12_3_tag[23:20] ^ meta_12_3_tag[27:24] ^ meta_12_3_tag[31:28] ^ meta_12_3_tag[35:32]
    ^ meta_13_0_tag[3:0] ^ meta_13_0_tag[7:4] ^ meta_13_0_tag[11:8] ^ meta_13_0_tag[15:12] ^ meta_13_0_tag[19:16] ^ meta_13_0_tag[23:20] ^ meta_13_0_tag[27:24] ^ meta_13_0_tag[31:28] ^ meta_13_0_tag[35:32] ^ meta_13_1_tag[3:0] ^ meta_13_1_tag[7:4] ^ meta_13_1_tag[11:8] ^ meta_13_1_tag[15:12] ^ meta_13_1_tag[19:16] ^ meta_13_1_tag[23:20] ^ meta_13_1_tag[27:24] ^ meta_13_1_tag[31:28] ^ meta_13_1_tag[35:32] ^ meta_13_2_tag[3:0] ^ meta_13_2_tag[7:4] ^ meta_13_2_tag[11:8] ^ meta_13_2_tag[15:12] ^ meta_13_2_tag[19:16] ^ meta_13_2_tag[23:20] ^ meta_13_2_tag[27:24] ^ meta_13_2_tag[31:28] ^ meta_13_2_tag[35:32] ^ meta_13_3_tag[3:0] ^ meta_13_3_tag[7:4] ^ meta_13_3_tag[11:8] ^ meta_13_3_tag[15:12] ^ meta_13_3_tag[19:16] ^ meta_13_3_tag[23:20] ^ meta_13_3_tag[27:24] ^ meta_13_3_tag[31:28] ^ meta_13_3_tag[35:32] ^ meta_14_0_tag[3:0] ^ meta_14_0_tag[7:4] ^ meta_14_0_tag[11:8] ^ meta_14_0_tag[15:12] ^ meta_14_0_tag[19:16] ^ meta_14_0_tag[23:20] ^ meta_14_0_tag[27:24] ^ meta_14_0_tag[31:28] ^ meta_14_0_tag[35:32] ^ meta_14_1_tag[3:0] ^ meta_14_1_tag[7:4] ^ meta_14_1_tag[11:8] ^ meta_14_1_tag[15:12] ^ meta_14_1_tag[19:16] ^ meta_14_1_tag[23:20] ^ meta_14_1_tag[27:24] ^ meta_14_1_tag[31:28] ^ meta_14_1_tag[35:32] ^ meta_14_2_tag[3:0] ^ meta_14_2_tag[7:4] ^ meta_14_2_tag[11:8] ^ meta_14_2_tag[15:12] ^ meta_14_2_tag[19:16] ^ meta_14_2_tag[23:20] ^ meta_14_2_tag[27:24] ^ meta_14_2_tag[31:28] ^ meta_14_2_tag[35:32] ^ meta_14_3_tag[3:0] ^ meta_14_3_tag[7:4] ^ meta_14_3_tag[11:8] ^ meta_14_3_tag[15:12] ^ meta_14_3_tag[19:16] ^ meta_14_3_tag[23:20] ^ meta_14_3_tag[27:24] ^ meta_14_3_tag[31:28] ^ meta_14_3_tag[35:32] ^ meta_15_0_tag[3:0] ^ meta_15_0_tag[7:4] ^ meta_15_0_tag[11:8] ^ meta_15_0_tag[15:12] ^ meta_15_0_tag[19:16] ^ meta_15_0_tag[23:20] ^ meta_15_0_tag[27:24] ^ meta_15_0_tag[31:28] ^ meta_15_0_tag[35:32] ^ meta_15_1_tag[3:0] ^ meta_15_1_tag[7:4] ^ meta_15_1_tag[11:8] ^ meta_15_1_tag[15:12] ^ meta_15_1_tag[19:16] ^ meta_15_1_tag[23:20] ^ meta_15_1_tag[27:24] ^ meta_15_1_tag[31:28] ^ meta_15_1_tag[35:32] ^ meta_15_2_tag[3:0]
    ^ meta_15_2_tag[7:4] ^ meta_15_2_tag[11:8] ^ meta_15_2_tag[15:12] ^ meta_15_2_tag[19:16] ^ meta_15_2_tag[23:20] ^ meta_15_2_tag[27:24] ^ meta_15_2_tag[31:28] ^ meta_15_2_tag[35:32] ^ meta_15_3_tag[3:0] ^ meta_15_3_tag[7:4] ^ meta_15_3_tag[11:8] ^ meta_15_3_tag[15:12] ^ meta_15_3_tag[19:16] ^ meta_15_3_tag[23:20] ^ meta_15_3_tag[27:24] ^ meta_15_3_tag[31:28] ^ meta_15_3_tag[35:32];
  wire         _GEN_20 = s1_update__valid & ~_GEN;
  wire         _GEN_21 = _GEN_20 & (s1_update__bits_br_mask[0] | ~(|s1_update__bits_cfi_idx_bits) & s1_update__bits_cfi_taken & s1_update__bits_cfi_idx_valid);
  wire         _GEN_22 = _GEN_20 & (s1_update__bits_br_mask[1] | _was_taken_T_3 & s1_update__bits_cfi_taken & s1_update__bits_cfi_idx_valid);
  wire         _GEN_23 = _GEN_20 & (s1_update__bits_br_mask[2] | _was_taken_T_6 & s1_update__bits_cfi_taken & s1_update__bits_cfi_idx_valid);
  wire         _GEN_24 = _GEN_20 & (s1_update__bits_br_mask[3] | (&s1_update__bits_cfi_idx_bits) & s1_update__bits_cfi_taken & s1_update__bits_cfi_idx_valid);
  always @(posedge clock) begin
    s1_idx <= io_f0_pc[39:4];
    s1_valid <= io_f0_valid;
    s1_pc <= io_f0_pc;
    s1_update__valid <= io_update_valid;
    s1_update__bits_is_mispredict_update <= io_update_bits_is_mispredict_update;
    s1_update__bits_is_repair_update <= io_update_bits_is_repair_update;
    s1_update__bits_btb_mispredicts <= io_update_bits_btb_mispredicts;
    s1_update__bits_pc <= io_update_bits_pc;
    s1_update__bits_br_mask <= io_update_bits_br_mask;
    s1_update__bits_cfi_idx_valid <= io_update_bits_cfi_idx_valid;
    s1_update__bits_cfi_idx_bits <= io_update_bits_cfi_idx_bits;
    s1_update__bits_cfi_taken <= io_update_bits_cfi_taken;
    s1_update__bits_cfi_is_jal <= io_update_bits_cfi_is_jal;
    s1_update__bits_target <= io_update_bits_target;
    s1_update__bits_meta <= io_update_bits_meta;
    s1_update_idx <= io_update_bits_pc[39:4];
    if (_GEN_0 & _GEN_1 & ~(|s1_update__bits_cfi_idx_bits))
      btb_0_0_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_1 & _GEN_2)
      btb_0_1_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_1 & _GEN_3)
      btb_0_2_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_1 & (&s1_update__bits_cfi_idx_bits))
      btb_0_3_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_4 & ~(|s1_update__bits_cfi_idx_bits))
      btb_1_0_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_4 & _GEN_2)
      btb_1_1_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_4 & _GEN_3)
      btb_1_2_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_4 & (&s1_update__bits_cfi_idx_bits))
      btb_1_3_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_5 & ~(|s1_update__bits_cfi_idx_bits))
      btb_2_0_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_5 & _GEN_2)
      btb_2_1_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_5 & _GEN_3)
      btb_2_2_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_5 & (&s1_update__bits_cfi_idx_bits))
      btb_2_3_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_6 & ~(|s1_update__bits_cfi_idx_bits))
      btb_3_0_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_6 & _GEN_2)
      btb_3_1_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_6 & _GEN_3)
      btb_3_2_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_6 & (&s1_update__bits_cfi_idx_bits))
      btb_3_3_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_7 & ~(|s1_update__bits_cfi_idx_bits))
      btb_4_0_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_7 & _GEN_2)
      btb_4_1_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_7 & _GEN_3)
      btb_4_2_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_7 & (&s1_update__bits_cfi_idx_bits))
      btb_4_3_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_8 & ~(|s1_update__bits_cfi_idx_bits))
      btb_5_0_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_8 & _GEN_2)
      btb_5_1_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_8 & _GEN_3)
      btb_5_2_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_8 & (&s1_update__bits_cfi_idx_bits))
      btb_5_3_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_9 & ~(|s1_update__bits_cfi_idx_bits))
      btb_6_0_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_9 & _GEN_2)
      btb_6_1_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_9 & _GEN_3)
      btb_6_2_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_9 & (&s1_update__bits_cfi_idx_bits))
      btb_6_3_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_10 & ~(|s1_update__bits_cfi_idx_bits))
      btb_7_0_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_10 & _GEN_2)
      btb_7_1_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_10 & _GEN_3)
      btb_7_2_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_10 & (&s1_update__bits_cfi_idx_bits))
      btb_7_3_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_11 & ~(|s1_update__bits_cfi_idx_bits))
      btb_8_0_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_11 & _GEN_2)
      btb_8_1_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_11 & _GEN_3)
      btb_8_2_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_11 & (&s1_update__bits_cfi_idx_bits))
      btb_8_3_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_12 & ~(|s1_update__bits_cfi_idx_bits))
      btb_9_0_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_12 & _GEN_2)
      btb_9_1_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_12 & _GEN_3)
      btb_9_2_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_12 & (&s1_update__bits_cfi_idx_bits))
      btb_9_3_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_13 & ~(|s1_update__bits_cfi_idx_bits))
      btb_10_0_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_13 & _GEN_2)
      btb_10_1_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_13 & _GEN_3)
      btb_10_2_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_13 & (&s1_update__bits_cfi_idx_bits))
      btb_10_3_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_14 & ~(|s1_update__bits_cfi_idx_bits))
      btb_11_0_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_14 & _GEN_2)
      btb_11_1_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_14 & _GEN_3)
      btb_11_2_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_14 & (&s1_update__bits_cfi_idx_bits))
      btb_11_3_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_15 & ~(|s1_update__bits_cfi_idx_bits))
      btb_12_0_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_15 & _GEN_2)
      btb_12_1_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_15 & _GEN_3)
      btb_12_2_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_15 & (&s1_update__bits_cfi_idx_bits))
      btb_12_3_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_16 & ~(|s1_update__bits_cfi_idx_bits))
      btb_13_0_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_16 & _GEN_2)
      btb_13_1_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_16 & _GEN_3)
      btb_13_2_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_16 & (&s1_update__bits_cfi_idx_bits))
      btb_13_3_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_17 & ~(|s1_update__bits_cfi_idx_bits))
      btb_14_0_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_17 & _GEN_2)
      btb_14_1_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_17 & _GEN_3)
      btb_14_2_offset <= _new_offset_value_T_5;
    if (_GEN_0 & _GEN_17 & (&s1_update__bits_cfi_idx_bits))
      btb_14_3_offset <= _new_offset_value_T_5;
    if (_GEN_0 & (&(s1_update__bits_meta[3:0])) & ~(|s1_update__bits_cfi_idx_bits))
      btb_15_0_offset <= _new_offset_value_T_5;
    if (_GEN_0 & (&(s1_update__bits_meta[3:0])) & _GEN_2)
      btb_15_1_offset <= _new_offset_value_T_5;
    if (_GEN_0 & (&(s1_update__bits_meta[3:0])) & _GEN_3)
      btb_15_2_offset <= _new_offset_value_T_5;
    if (_GEN_0 & (&(s1_update__bits_meta[3:0])) & (&s1_update__bits_cfi_idx_bits))
      btb_15_3_offset <= _new_offset_value_T_5;
    io_resp_f2_0_REG_is_br <= _io_resp_f1_0_is_br_output;
    io_resp_f2_0_REG_is_jal <= _io_resp_f1_0_is_jal_output;
    io_resp_f2_0_REG_predicted_pc_valid <= _io_resp_f1_0_predicted_pc_valid_output;
    io_resp_f2_0_REG_predicted_pc_bits <= _s1_resp_0_bits_T_4;
    io_resp_f3_0_REG_predicted_pc_valid <= io_resp_f2_0_REG_predicted_pc_valid;
    io_resp_f3_0_REG_predicted_pc_bits <= io_resp_f2_0_REG_predicted_pc_bits;
    io_resp_f2_1_REG_is_br <= _io_resp_f1_1_is_br_output;
    io_resp_f2_1_REG_is_jal <= _io_resp_f1_1_is_jal_output;
    io_resp_f2_1_REG_predicted_pc_valid <= _io_resp_f1_1_predicted_pc_valid_output;
    io_resp_f2_1_REG_predicted_pc_bits <= _s1_resp_1_bits_T_4;
    io_resp_f3_1_REG_predicted_pc_valid <= io_resp_f2_1_REG_predicted_pc_valid;
    io_resp_f3_1_REG_predicted_pc_bits <= io_resp_f2_1_REG_predicted_pc_bits;
    io_resp_f2_2_REG_is_br <= _io_resp_f1_2_is_br_output;
    io_resp_f2_2_REG_is_jal <= _io_resp_f1_2_is_jal_output;
    io_resp_f2_2_REG_predicted_pc_valid <= _io_resp_f1_2_predicted_pc_valid_output;
    io_resp_f2_2_REG_predicted_pc_bits <= _s1_resp_2_bits_T_4;
    io_resp_f3_2_REG_predicted_pc_valid <= io_resp_f2_2_REG_predicted_pc_valid;
    io_resp_f3_2_REG_predicted_pc_bits <= io_resp_f2_2_REG_predicted_pc_bits;
    io_resp_f2_3_REG_is_br <= _io_resp_f1_3_is_br_output;
    io_resp_f2_3_REG_is_jal <= _io_resp_f1_3_is_jal_output;
    io_resp_f2_3_REG_predicted_pc_valid <= _io_resp_f1_3_predicted_pc_valid_output;
    io_resp_f2_3_REG_predicted_pc_bits <= _s1_resp_3_bits_T_4;
    io_resp_f3_3_REG_predicted_pc_valid <= io_resp_f2_3_REG_predicted_pc_valid;
    io_resp_f3_3_REG_predicted_pc_bits <= io_resp_f2_3_REG_predicted_pc_bits;
    io_f3_meta_REG <= {s1_hits_3, s1_hits_2, s1_hits_1, s1_hits_0, s1_hits_0 | s1_hits_1 | s1_hits_2 | s1_hits_3 ? (_s1_meta_write_way_T_9[0] ? 4'h0 : _s1_meta_write_way_T_9[1] ? 4'h1 : _s1_meta_write_way_T_9[2] ? 4'h2 : _s1_meta_write_way_T_9[3] ? 4'h3 : _s1_meta_write_way_T_9[4] ? 4'h4 : _s1_meta_write_way_T_9[5] ? 4'h5 : _s1_meta_write_way_T_9[6] ? 4'h6 : _s1_meta_write_way_T_9[7] ? 4'h7 : _s1_meta_write_way_T_9[8] ? 4'h8 : _s1_meta_write_way_T_9[9] ? 4'h9 : _s1_meta_write_way_T_9[10] ? 4'hA : _s1_meta_write_way_T_9[11] ? 4'hB : _s1_meta_write_way_T_9[12] ? 4'hC : _s1_meta_write_way_T_9[13] ? 4'hD : {3'h7, ~(_s1_meta_write_way_T_9[14])}) : _GEN_18 ^ _GEN_19};
    io_f3_meta_REG_1 <= io_f3_meta_REG;
    if (reset) begin
      meta_0_0_tag <= 36'h0;
      meta_1_0_tag <= 36'h0;
      meta_2_0_tag <= 36'h0;
      meta_3_0_tag <= 36'h0;
      meta_4_0_tag <= 36'h0;
      meta_5_0_tag <= 36'h0;
      meta_6_0_tag <= 36'h0;
      meta_7_0_tag <= 36'h0;
      meta_8_0_tag <= 36'h0;
      meta_9_0_tag <= 36'h0;
      meta_10_0_tag <= 36'h0;
      meta_11_0_tag <= 36'h0;
      meta_12_0_tag <= 36'h0;
      meta_13_0_tag <= 36'h0;
      meta_14_0_tag <= 36'h0;
      meta_15_0_tag <= 36'h0;
      meta_0_1_tag <= 36'h0;
      meta_1_1_tag <= 36'h0;
      meta_2_1_tag <= 36'h0;
      meta_3_1_tag <= 36'h0;
      meta_4_1_tag <= 36'h0;
      meta_5_1_tag <= 36'h0;
      meta_6_1_tag <= 36'h0;
      meta_7_1_tag <= 36'h0;
      meta_8_1_tag <= 36'h0;
      meta_9_1_tag <= 36'h0;
      meta_10_1_tag <= 36'h0;
      meta_11_1_tag <= 36'h0;
      meta_12_1_tag <= 36'h0;
      meta_13_1_tag <= 36'h0;
      meta_14_1_tag <= 36'h0;
      meta_15_1_tag <= 36'h0;
      meta_0_2_tag <= 36'h0;
      meta_1_2_tag <= 36'h0;
      meta_2_2_tag <= 36'h0;
      meta_3_2_tag <= 36'h0;
      meta_4_2_tag <= 36'h0;
      meta_5_2_tag <= 36'h0;
      meta_6_2_tag <= 36'h0;
      meta_7_2_tag <= 36'h0;
      meta_8_2_tag <= 36'h0;
      meta_9_2_tag <= 36'h0;
      meta_10_2_tag <= 36'h0;
      meta_11_2_tag <= 36'h0;
      meta_12_2_tag <= 36'h0;
      meta_13_2_tag <= 36'h0;
      meta_14_2_tag <= 36'h0;
      meta_15_2_tag <= 36'h0;
      meta_0_3_tag <= 36'h0;
      meta_1_3_tag <= 36'h0;
      meta_2_3_tag <= 36'h0;
      meta_3_3_tag <= 36'h0;
      meta_4_3_tag <= 36'h0;
      meta_5_3_tag <= 36'h0;
      meta_6_3_tag <= 36'h0;
      meta_7_3_tag <= 36'h0;
      meta_8_3_tag <= 36'h0;
      meta_9_3_tag <= 36'h0;
      meta_10_3_tag <= 36'h0;
      meta_11_3_tag <= 36'h0;
      meta_12_3_tag <= 36'h0;
      meta_13_3_tag <= 36'h0;
      meta_14_3_tag <= 36'h0;
      meta_15_3_tag <= 36'h0;
      meta_0_0_is_br <= 1'h0;
      meta_0_0_ctr <= 2'h0;
      meta_0_1_is_br <= 1'h0;
      meta_0_1_ctr <= 2'h0;
      meta_0_2_is_br <= 1'h0;
      meta_0_2_ctr <= 2'h0;
      meta_0_3_is_br <= 1'h0;
      meta_0_3_ctr <= 2'h0;
      meta_1_0_is_br <= 1'h0;
      meta_1_0_ctr <= 2'h0;
      meta_1_1_is_br <= 1'h0;
      meta_1_1_ctr <= 2'h0;
      meta_1_2_is_br <= 1'h0;
      meta_1_2_ctr <= 2'h0;
      meta_1_3_is_br <= 1'h0;
      meta_1_3_ctr <= 2'h0;
      meta_2_0_is_br <= 1'h0;
      meta_2_0_ctr <= 2'h0;
      meta_2_1_is_br <= 1'h0;
      meta_2_1_ctr <= 2'h0;
      meta_2_2_is_br <= 1'h0;
      meta_2_2_ctr <= 2'h0;
      meta_2_3_is_br <= 1'h0;
      meta_2_3_ctr <= 2'h0;
      meta_3_0_is_br <= 1'h0;
      meta_3_0_ctr <= 2'h0;
      meta_3_1_is_br <= 1'h0;
      meta_3_1_ctr <= 2'h0;
      meta_3_2_is_br <= 1'h0;
      meta_3_2_ctr <= 2'h0;
      meta_3_3_is_br <= 1'h0;
      meta_3_3_ctr <= 2'h0;
      meta_4_0_is_br <= 1'h0;
      meta_4_0_ctr <= 2'h0;
      meta_4_1_is_br <= 1'h0;
      meta_4_1_ctr <= 2'h0;
      meta_4_2_is_br <= 1'h0;
      meta_4_2_ctr <= 2'h0;
      meta_4_3_is_br <= 1'h0;
      meta_4_3_ctr <= 2'h0;
      meta_5_0_is_br <= 1'h0;
      meta_5_0_ctr <= 2'h0;
      meta_5_1_is_br <= 1'h0;
      meta_5_1_ctr <= 2'h0;
      meta_5_2_is_br <= 1'h0;
      meta_5_2_ctr <= 2'h0;
      meta_5_3_is_br <= 1'h0;
      meta_5_3_ctr <= 2'h0;
      meta_6_0_is_br <= 1'h0;
      meta_6_0_ctr <= 2'h0;
      meta_6_1_is_br <= 1'h0;
      meta_6_1_ctr <= 2'h0;
      meta_6_2_is_br <= 1'h0;
      meta_6_2_ctr <= 2'h0;
      meta_6_3_is_br <= 1'h0;
      meta_6_3_ctr <= 2'h0;
      meta_7_0_is_br <= 1'h0;
      meta_7_0_ctr <= 2'h0;
      meta_7_1_is_br <= 1'h0;
      meta_7_1_ctr <= 2'h0;
      meta_7_2_is_br <= 1'h0;
      meta_7_2_ctr <= 2'h0;
      meta_7_3_is_br <= 1'h0;
      meta_7_3_ctr <= 2'h0;
      meta_8_0_is_br <= 1'h0;
      meta_8_0_ctr <= 2'h0;
      meta_8_1_is_br <= 1'h0;
      meta_8_1_ctr <= 2'h0;
      meta_8_2_is_br <= 1'h0;
      meta_8_2_ctr <= 2'h0;
      meta_8_3_is_br <= 1'h0;
      meta_8_3_ctr <= 2'h0;
      meta_9_0_is_br <= 1'h0;
      meta_9_0_ctr <= 2'h0;
      meta_9_1_is_br <= 1'h0;
      meta_9_1_ctr <= 2'h0;
      meta_9_2_is_br <= 1'h0;
      meta_9_2_ctr <= 2'h0;
      meta_9_3_is_br <= 1'h0;
      meta_9_3_ctr <= 2'h0;
      meta_10_0_is_br <= 1'h0;
      meta_10_0_ctr <= 2'h0;
      meta_10_1_is_br <= 1'h0;
      meta_10_1_ctr <= 2'h0;
      meta_10_2_is_br <= 1'h0;
      meta_10_2_ctr <= 2'h0;
      meta_10_3_is_br <= 1'h0;
      meta_10_3_ctr <= 2'h0;
      meta_11_0_is_br <= 1'h0;
      meta_11_0_ctr <= 2'h0;
      meta_11_1_is_br <= 1'h0;
      meta_11_1_ctr <= 2'h0;
      meta_11_2_is_br <= 1'h0;
      meta_11_2_ctr <= 2'h0;
      meta_11_3_is_br <= 1'h0;
      meta_11_3_ctr <= 2'h0;
      meta_12_0_is_br <= 1'h0;
      meta_12_0_ctr <= 2'h0;
      meta_12_1_is_br <= 1'h0;
      meta_12_1_ctr <= 2'h0;
      meta_12_2_is_br <= 1'h0;
      meta_12_2_ctr <= 2'h0;
      meta_12_3_is_br <= 1'h0;
      meta_12_3_ctr <= 2'h0;
      meta_13_0_is_br <= 1'h0;
      meta_13_0_ctr <= 2'h0;
      meta_13_1_is_br <= 1'h0;
      meta_13_1_ctr <= 2'h0;
      meta_13_2_is_br <= 1'h0;
      meta_13_2_ctr <= 2'h0;
      meta_13_3_is_br <= 1'h0;
      meta_13_3_ctr <= 2'h0;
      meta_14_0_is_br <= 1'h0;
      meta_14_0_ctr <= 2'h0;
      meta_14_1_is_br <= 1'h0;
      meta_14_1_ctr <= 2'h0;
      meta_14_2_is_br <= 1'h0;
      meta_14_2_ctr <= 2'h0;
      meta_14_3_is_br <= 1'h0;
      meta_14_3_ctr <= 2'h0;
      meta_15_0_is_br <= 1'h0;
      meta_15_0_ctr <= 2'h0;
      meta_15_1_is_br <= 1'h0;
      meta_15_1_ctr <= 2'h0;
      meta_15_2_is_br <= 1'h0;
      meta_15_2_ctr <= 2'h0;
      meta_15_3_is_br <= 1'h0;
      meta_15_3_ctr <= 2'h0;
    end
    else begin
      if (_GEN_21 & _GEN_1) begin
        meta_0_0_tag <= s1_update_idx;
        meta_0_0_is_br <= s1_update__bits_br_mask[0];
        if (s1_update__bits_meta[4]) begin
          if (_meta_0_ctr_T_2)
            meta_0_0_ctr <= 2'h3;
          else if (_meta_0_ctr_T_4)
            meta_0_0_ctr <= 2'h0;
          else if (was_taken)
            meta_0_0_ctr <= _meta_0_ctr_T_5;
          else
            meta_0_0_ctr <= _meta_0_ctr_T_7;
        end
        else
          meta_0_0_ctr <= _meta_0_ctr_T_1;
      end
      if (_GEN_21 & _GEN_4) begin
        meta_1_0_tag <= s1_update_idx;
        meta_1_0_is_br <= s1_update__bits_br_mask[0];
        if (s1_update__bits_meta[4]) begin
          if (_meta_0_ctr_T_2)
            meta_1_0_ctr <= 2'h3;
          else if (_meta_0_ctr_T_4)
            meta_1_0_ctr <= 2'h0;
          else if (was_taken)
            meta_1_0_ctr <= _meta_0_ctr_T_5;
          else
            meta_1_0_ctr <= _meta_0_ctr_T_7;
        end
        else
          meta_1_0_ctr <= _meta_0_ctr_T_1;
      end
      if (_GEN_21 & _GEN_5) begin
        meta_2_0_tag <= s1_update_idx;
        meta_2_0_is_br <= s1_update__bits_br_mask[0];
        if (s1_update__bits_meta[4]) begin
          if (_meta_0_ctr_T_2)
            meta_2_0_ctr <= 2'h3;
          else if (_meta_0_ctr_T_4)
            meta_2_0_ctr <= 2'h0;
          else if (was_taken)
            meta_2_0_ctr <= _meta_0_ctr_T_5;
          else
            meta_2_0_ctr <= _meta_0_ctr_T_7;
        end
        else
          meta_2_0_ctr <= _meta_0_ctr_T_1;
      end
      if (_GEN_21 & _GEN_6) begin
        meta_3_0_tag <= s1_update_idx;
        meta_3_0_is_br <= s1_update__bits_br_mask[0];
        if (s1_update__bits_meta[4]) begin
          if (_meta_0_ctr_T_2)
            meta_3_0_ctr <= 2'h3;
          else if (_meta_0_ctr_T_4)
            meta_3_0_ctr <= 2'h0;
          else if (was_taken)
            meta_3_0_ctr <= _meta_0_ctr_T_5;
          else
            meta_3_0_ctr <= _meta_0_ctr_T_7;
        end
        else
          meta_3_0_ctr <= _meta_0_ctr_T_1;
      end
      if (_GEN_21 & _GEN_7) begin
        meta_4_0_tag <= s1_update_idx;
        meta_4_0_is_br <= s1_update__bits_br_mask[0];
        if (s1_update__bits_meta[4]) begin
          if (_meta_0_ctr_T_2)
            meta_4_0_ctr <= 2'h3;
          else if (_meta_0_ctr_T_4)
            meta_4_0_ctr <= 2'h0;
          else if (was_taken)
            meta_4_0_ctr <= _meta_0_ctr_T_5;
          else
            meta_4_0_ctr <= _meta_0_ctr_T_7;
        end
        else
          meta_4_0_ctr <= _meta_0_ctr_T_1;
      end
      if (_GEN_21 & _GEN_8) begin
        meta_5_0_tag <= s1_update_idx;
        meta_5_0_is_br <= s1_update__bits_br_mask[0];
        if (s1_update__bits_meta[4]) begin
          if (_meta_0_ctr_T_2)
            meta_5_0_ctr <= 2'h3;
          else if (_meta_0_ctr_T_4)
            meta_5_0_ctr <= 2'h0;
          else if (was_taken)
            meta_5_0_ctr <= _meta_0_ctr_T_5;
          else
            meta_5_0_ctr <= _meta_0_ctr_T_7;
        end
        else
          meta_5_0_ctr <= _meta_0_ctr_T_1;
      end
      if (_GEN_21 & _GEN_9) begin
        meta_6_0_tag <= s1_update_idx;
        meta_6_0_is_br <= s1_update__bits_br_mask[0];
        if (s1_update__bits_meta[4]) begin
          if (_meta_0_ctr_T_2)
            meta_6_0_ctr <= 2'h3;
          else if (_meta_0_ctr_T_4)
            meta_6_0_ctr <= 2'h0;
          else if (was_taken)
            meta_6_0_ctr <= _meta_0_ctr_T_5;
          else
            meta_6_0_ctr <= _meta_0_ctr_T_7;
        end
        else
          meta_6_0_ctr <= _meta_0_ctr_T_1;
      end
      if (_GEN_21 & _GEN_10) begin
        meta_7_0_tag <= s1_update_idx;
        meta_7_0_is_br <= s1_update__bits_br_mask[0];
        if (s1_update__bits_meta[4]) begin
          if (_meta_0_ctr_T_2)
            meta_7_0_ctr <= 2'h3;
          else if (_meta_0_ctr_T_4)
            meta_7_0_ctr <= 2'h0;
          else if (was_taken)
            meta_7_0_ctr <= _meta_0_ctr_T_5;
          else
            meta_7_0_ctr <= _meta_0_ctr_T_7;
        end
        else
          meta_7_0_ctr <= _meta_0_ctr_T_1;
      end
      if (_GEN_21 & _GEN_11) begin
        meta_8_0_tag <= s1_update_idx;
        meta_8_0_is_br <= s1_update__bits_br_mask[0];
        if (s1_update__bits_meta[4]) begin
          if (_meta_0_ctr_T_2)
            meta_8_0_ctr <= 2'h3;
          else if (_meta_0_ctr_T_4)
            meta_8_0_ctr <= 2'h0;
          else if (was_taken)
            meta_8_0_ctr <= _meta_0_ctr_T_5;
          else
            meta_8_0_ctr <= _meta_0_ctr_T_7;
        end
        else
          meta_8_0_ctr <= _meta_0_ctr_T_1;
      end
      if (_GEN_21 & _GEN_12) begin
        meta_9_0_tag <= s1_update_idx;
        meta_9_0_is_br <= s1_update__bits_br_mask[0];
        if (s1_update__bits_meta[4]) begin
          if (_meta_0_ctr_T_2)
            meta_9_0_ctr <= 2'h3;
          else if (_meta_0_ctr_T_4)
            meta_9_0_ctr <= 2'h0;
          else if (was_taken)
            meta_9_0_ctr <= _meta_0_ctr_T_5;
          else
            meta_9_0_ctr <= _meta_0_ctr_T_7;
        end
        else
          meta_9_0_ctr <= _meta_0_ctr_T_1;
      end
      if (_GEN_21 & _GEN_13) begin
        meta_10_0_tag <= s1_update_idx;
        meta_10_0_is_br <= s1_update__bits_br_mask[0];
        if (s1_update__bits_meta[4]) begin
          if (_meta_0_ctr_T_2)
            meta_10_0_ctr <= 2'h3;
          else if (_meta_0_ctr_T_4)
            meta_10_0_ctr <= 2'h0;
          else if (was_taken)
            meta_10_0_ctr <= _meta_0_ctr_T_5;
          else
            meta_10_0_ctr <= _meta_0_ctr_T_7;
        end
        else
          meta_10_0_ctr <= _meta_0_ctr_T_1;
      end
      if (_GEN_21 & _GEN_14) begin
        meta_11_0_tag <= s1_update_idx;
        meta_11_0_is_br <= s1_update__bits_br_mask[0];
        if (s1_update__bits_meta[4]) begin
          if (_meta_0_ctr_T_2)
            meta_11_0_ctr <= 2'h3;
          else if (_meta_0_ctr_T_4)
            meta_11_0_ctr <= 2'h0;
          else if (was_taken)
            meta_11_0_ctr <= _meta_0_ctr_T_5;
          else
            meta_11_0_ctr <= _meta_0_ctr_T_7;
        end
        else
          meta_11_0_ctr <= _meta_0_ctr_T_1;
      end
      if (_GEN_21 & _GEN_15) begin
        meta_12_0_tag <= s1_update_idx;
        meta_12_0_is_br <= s1_update__bits_br_mask[0];
        if (s1_update__bits_meta[4]) begin
          if (_meta_0_ctr_T_2)
            meta_12_0_ctr <= 2'h3;
          else if (_meta_0_ctr_T_4)
            meta_12_0_ctr <= 2'h0;
          else if (was_taken)
            meta_12_0_ctr <= _meta_0_ctr_T_5;
          else
            meta_12_0_ctr <= _meta_0_ctr_T_7;
        end
        else
          meta_12_0_ctr <= _meta_0_ctr_T_1;
      end
      if (_GEN_21 & _GEN_16) begin
        meta_13_0_tag <= s1_update_idx;
        meta_13_0_is_br <= s1_update__bits_br_mask[0];
        if (s1_update__bits_meta[4]) begin
          if (_meta_0_ctr_T_2)
            meta_13_0_ctr <= 2'h3;
          else if (_meta_0_ctr_T_4)
            meta_13_0_ctr <= 2'h0;
          else if (was_taken)
            meta_13_0_ctr <= _meta_0_ctr_T_5;
          else
            meta_13_0_ctr <= _meta_0_ctr_T_7;
        end
        else
          meta_13_0_ctr <= _meta_0_ctr_T_1;
      end
      if (_GEN_21 & _GEN_17) begin
        meta_14_0_tag <= s1_update_idx;
        meta_14_0_is_br <= s1_update__bits_br_mask[0];
        if (s1_update__bits_meta[4]) begin
          if (_meta_0_ctr_T_2)
            meta_14_0_ctr <= 2'h3;
          else if (_meta_0_ctr_T_4)
            meta_14_0_ctr <= 2'h0;
          else if (was_taken)
            meta_14_0_ctr <= _meta_0_ctr_T_5;
          else
            meta_14_0_ctr <= _meta_0_ctr_T_7;
        end
        else
          meta_14_0_ctr <= _meta_0_ctr_T_1;
      end
      if (_GEN_21 & (&(s1_update__bits_meta[3:0]))) begin
        meta_15_0_tag <= s1_update_idx;
        meta_15_0_is_br <= s1_update__bits_br_mask[0];
        if (s1_update__bits_meta[4]) begin
          if (_meta_0_ctr_T_2)
            meta_15_0_ctr <= 2'h3;
          else if (_meta_0_ctr_T_4)
            meta_15_0_ctr <= 2'h0;
          else if (was_taken)
            meta_15_0_ctr <= _meta_0_ctr_T_5;
          else
            meta_15_0_ctr <= _meta_0_ctr_T_7;
        end
        else
          meta_15_0_ctr <= _meta_0_ctr_T_1;
      end
      if (_GEN_22 & _GEN_1) begin
        meta_0_1_tag <= s1_update_idx;
        meta_0_1_is_br <= s1_update__bits_br_mask[1];
        if (s1_update__bits_meta[5]) begin
          if (_meta_1_ctr_T_2)
            meta_0_1_ctr <= 2'h3;
          else if (_meta_1_ctr_T_4)
            meta_0_1_ctr <= 2'h0;
          else if (was_taken_1)
            meta_0_1_ctr <= _meta_1_ctr_T_5;
          else
            meta_0_1_ctr <= _meta_1_ctr_T_7;
        end
        else
          meta_0_1_ctr <= _meta_1_ctr_T_1;
      end
      if (_GEN_22 & _GEN_4) begin
        meta_1_1_tag <= s1_update_idx;
        meta_1_1_is_br <= s1_update__bits_br_mask[1];
        if (s1_update__bits_meta[5]) begin
          if (_meta_1_ctr_T_2)
            meta_1_1_ctr <= 2'h3;
          else if (_meta_1_ctr_T_4)
            meta_1_1_ctr <= 2'h0;
          else if (was_taken_1)
            meta_1_1_ctr <= _meta_1_ctr_T_5;
          else
            meta_1_1_ctr <= _meta_1_ctr_T_7;
        end
        else
          meta_1_1_ctr <= _meta_1_ctr_T_1;
      end
      if (_GEN_22 & _GEN_5) begin
        meta_2_1_tag <= s1_update_idx;
        meta_2_1_is_br <= s1_update__bits_br_mask[1];
        if (s1_update__bits_meta[5]) begin
          if (_meta_1_ctr_T_2)
            meta_2_1_ctr <= 2'h3;
          else if (_meta_1_ctr_T_4)
            meta_2_1_ctr <= 2'h0;
          else if (was_taken_1)
            meta_2_1_ctr <= _meta_1_ctr_T_5;
          else
            meta_2_1_ctr <= _meta_1_ctr_T_7;
        end
        else
          meta_2_1_ctr <= _meta_1_ctr_T_1;
      end
      if (_GEN_22 & _GEN_6) begin
        meta_3_1_tag <= s1_update_idx;
        meta_3_1_is_br <= s1_update__bits_br_mask[1];
        if (s1_update__bits_meta[5]) begin
          if (_meta_1_ctr_T_2)
            meta_3_1_ctr <= 2'h3;
          else if (_meta_1_ctr_T_4)
            meta_3_1_ctr <= 2'h0;
          else if (was_taken_1)
            meta_3_1_ctr <= _meta_1_ctr_T_5;
          else
            meta_3_1_ctr <= _meta_1_ctr_T_7;
        end
        else
          meta_3_1_ctr <= _meta_1_ctr_T_1;
      end
      if (_GEN_22 & _GEN_7) begin
        meta_4_1_tag <= s1_update_idx;
        meta_4_1_is_br <= s1_update__bits_br_mask[1];
        if (s1_update__bits_meta[5]) begin
          if (_meta_1_ctr_T_2)
            meta_4_1_ctr <= 2'h3;
          else if (_meta_1_ctr_T_4)
            meta_4_1_ctr <= 2'h0;
          else if (was_taken_1)
            meta_4_1_ctr <= _meta_1_ctr_T_5;
          else
            meta_4_1_ctr <= _meta_1_ctr_T_7;
        end
        else
          meta_4_1_ctr <= _meta_1_ctr_T_1;
      end
      if (_GEN_22 & _GEN_8) begin
        meta_5_1_tag <= s1_update_idx;
        meta_5_1_is_br <= s1_update__bits_br_mask[1];
        if (s1_update__bits_meta[5]) begin
          if (_meta_1_ctr_T_2)
            meta_5_1_ctr <= 2'h3;
          else if (_meta_1_ctr_T_4)
            meta_5_1_ctr <= 2'h0;
          else if (was_taken_1)
            meta_5_1_ctr <= _meta_1_ctr_T_5;
          else
            meta_5_1_ctr <= _meta_1_ctr_T_7;
        end
        else
          meta_5_1_ctr <= _meta_1_ctr_T_1;
      end
      if (_GEN_22 & _GEN_9) begin
        meta_6_1_tag <= s1_update_idx;
        meta_6_1_is_br <= s1_update__bits_br_mask[1];
        if (s1_update__bits_meta[5]) begin
          if (_meta_1_ctr_T_2)
            meta_6_1_ctr <= 2'h3;
          else if (_meta_1_ctr_T_4)
            meta_6_1_ctr <= 2'h0;
          else if (was_taken_1)
            meta_6_1_ctr <= _meta_1_ctr_T_5;
          else
            meta_6_1_ctr <= _meta_1_ctr_T_7;
        end
        else
          meta_6_1_ctr <= _meta_1_ctr_T_1;
      end
      if (_GEN_22 & _GEN_10) begin
        meta_7_1_tag <= s1_update_idx;
        meta_7_1_is_br <= s1_update__bits_br_mask[1];
        if (s1_update__bits_meta[5]) begin
          if (_meta_1_ctr_T_2)
            meta_7_1_ctr <= 2'h3;
          else if (_meta_1_ctr_T_4)
            meta_7_1_ctr <= 2'h0;
          else if (was_taken_1)
            meta_7_1_ctr <= _meta_1_ctr_T_5;
          else
            meta_7_1_ctr <= _meta_1_ctr_T_7;
        end
        else
          meta_7_1_ctr <= _meta_1_ctr_T_1;
      end
      if (_GEN_22 & _GEN_11) begin
        meta_8_1_tag <= s1_update_idx;
        meta_8_1_is_br <= s1_update__bits_br_mask[1];
        if (s1_update__bits_meta[5]) begin
          if (_meta_1_ctr_T_2)
            meta_8_1_ctr <= 2'h3;
          else if (_meta_1_ctr_T_4)
            meta_8_1_ctr <= 2'h0;
          else if (was_taken_1)
            meta_8_1_ctr <= _meta_1_ctr_T_5;
          else
            meta_8_1_ctr <= _meta_1_ctr_T_7;
        end
        else
          meta_8_1_ctr <= _meta_1_ctr_T_1;
      end
      if (_GEN_22 & _GEN_12) begin
        meta_9_1_tag <= s1_update_idx;
        meta_9_1_is_br <= s1_update__bits_br_mask[1];
        if (s1_update__bits_meta[5]) begin
          if (_meta_1_ctr_T_2)
            meta_9_1_ctr <= 2'h3;
          else if (_meta_1_ctr_T_4)
            meta_9_1_ctr <= 2'h0;
          else if (was_taken_1)
            meta_9_1_ctr <= _meta_1_ctr_T_5;
          else
            meta_9_1_ctr <= _meta_1_ctr_T_7;
        end
        else
          meta_9_1_ctr <= _meta_1_ctr_T_1;
      end
      if (_GEN_22 & _GEN_13) begin
        meta_10_1_tag <= s1_update_idx;
        meta_10_1_is_br <= s1_update__bits_br_mask[1];
        if (s1_update__bits_meta[5]) begin
          if (_meta_1_ctr_T_2)
            meta_10_1_ctr <= 2'h3;
          else if (_meta_1_ctr_T_4)
            meta_10_1_ctr <= 2'h0;
          else if (was_taken_1)
            meta_10_1_ctr <= _meta_1_ctr_T_5;
          else
            meta_10_1_ctr <= _meta_1_ctr_T_7;
        end
        else
          meta_10_1_ctr <= _meta_1_ctr_T_1;
      end
      if (_GEN_22 & _GEN_14) begin
        meta_11_1_tag <= s1_update_idx;
        meta_11_1_is_br <= s1_update__bits_br_mask[1];
        if (s1_update__bits_meta[5]) begin
          if (_meta_1_ctr_T_2)
            meta_11_1_ctr <= 2'h3;
          else if (_meta_1_ctr_T_4)
            meta_11_1_ctr <= 2'h0;
          else if (was_taken_1)
            meta_11_1_ctr <= _meta_1_ctr_T_5;
          else
            meta_11_1_ctr <= _meta_1_ctr_T_7;
        end
        else
          meta_11_1_ctr <= _meta_1_ctr_T_1;
      end
      if (_GEN_22 & _GEN_15) begin
        meta_12_1_tag <= s1_update_idx;
        meta_12_1_is_br <= s1_update__bits_br_mask[1];
        if (s1_update__bits_meta[5]) begin
          if (_meta_1_ctr_T_2)
            meta_12_1_ctr <= 2'h3;
          else if (_meta_1_ctr_T_4)
            meta_12_1_ctr <= 2'h0;
          else if (was_taken_1)
            meta_12_1_ctr <= _meta_1_ctr_T_5;
          else
            meta_12_1_ctr <= _meta_1_ctr_T_7;
        end
        else
          meta_12_1_ctr <= _meta_1_ctr_T_1;
      end
      if (_GEN_22 & _GEN_16) begin
        meta_13_1_tag <= s1_update_idx;
        meta_13_1_is_br <= s1_update__bits_br_mask[1];
        if (s1_update__bits_meta[5]) begin
          if (_meta_1_ctr_T_2)
            meta_13_1_ctr <= 2'h3;
          else if (_meta_1_ctr_T_4)
            meta_13_1_ctr <= 2'h0;
          else if (was_taken_1)
            meta_13_1_ctr <= _meta_1_ctr_T_5;
          else
            meta_13_1_ctr <= _meta_1_ctr_T_7;
        end
        else
          meta_13_1_ctr <= _meta_1_ctr_T_1;
      end
      if (_GEN_22 & _GEN_17) begin
        meta_14_1_tag <= s1_update_idx;
        meta_14_1_is_br <= s1_update__bits_br_mask[1];
        if (s1_update__bits_meta[5]) begin
          if (_meta_1_ctr_T_2)
            meta_14_1_ctr <= 2'h3;
          else if (_meta_1_ctr_T_4)
            meta_14_1_ctr <= 2'h0;
          else if (was_taken_1)
            meta_14_1_ctr <= _meta_1_ctr_T_5;
          else
            meta_14_1_ctr <= _meta_1_ctr_T_7;
        end
        else
          meta_14_1_ctr <= _meta_1_ctr_T_1;
      end
      if (_GEN_22 & (&(s1_update__bits_meta[3:0]))) begin
        meta_15_1_tag <= s1_update_idx;
        meta_15_1_is_br <= s1_update__bits_br_mask[1];
        if (s1_update__bits_meta[5]) begin
          if (_meta_1_ctr_T_2)
            meta_15_1_ctr <= 2'h3;
          else if (_meta_1_ctr_T_4)
            meta_15_1_ctr <= 2'h0;
          else if (was_taken_1)
            meta_15_1_ctr <= _meta_1_ctr_T_5;
          else
            meta_15_1_ctr <= _meta_1_ctr_T_7;
        end
        else
          meta_15_1_ctr <= _meta_1_ctr_T_1;
      end
      if (_GEN_23 & _GEN_1) begin
        meta_0_2_tag <= s1_update_idx;
        meta_0_2_is_br <= s1_update__bits_br_mask[2];
        if (s1_update__bits_meta[6]) begin
          if (_meta_2_ctr_T_2)
            meta_0_2_ctr <= 2'h3;
          else if (_meta_2_ctr_T_4)
            meta_0_2_ctr <= 2'h0;
          else if (was_taken_2)
            meta_0_2_ctr <= _meta_2_ctr_T_5;
          else
            meta_0_2_ctr <= _meta_2_ctr_T_7;
        end
        else
          meta_0_2_ctr <= _meta_2_ctr_T_1;
      end
      if (_GEN_23 & _GEN_4) begin
        meta_1_2_tag <= s1_update_idx;
        meta_1_2_is_br <= s1_update__bits_br_mask[2];
        if (s1_update__bits_meta[6]) begin
          if (_meta_2_ctr_T_2)
            meta_1_2_ctr <= 2'h3;
          else if (_meta_2_ctr_T_4)
            meta_1_2_ctr <= 2'h0;
          else if (was_taken_2)
            meta_1_2_ctr <= _meta_2_ctr_T_5;
          else
            meta_1_2_ctr <= _meta_2_ctr_T_7;
        end
        else
          meta_1_2_ctr <= _meta_2_ctr_T_1;
      end
      if (_GEN_23 & _GEN_5) begin
        meta_2_2_tag <= s1_update_idx;
        meta_2_2_is_br <= s1_update__bits_br_mask[2];
        if (s1_update__bits_meta[6]) begin
          if (_meta_2_ctr_T_2)
            meta_2_2_ctr <= 2'h3;
          else if (_meta_2_ctr_T_4)
            meta_2_2_ctr <= 2'h0;
          else if (was_taken_2)
            meta_2_2_ctr <= _meta_2_ctr_T_5;
          else
            meta_2_2_ctr <= _meta_2_ctr_T_7;
        end
        else
          meta_2_2_ctr <= _meta_2_ctr_T_1;
      end
      if (_GEN_23 & _GEN_6) begin
        meta_3_2_tag <= s1_update_idx;
        meta_3_2_is_br <= s1_update__bits_br_mask[2];
        if (s1_update__bits_meta[6]) begin
          if (_meta_2_ctr_T_2)
            meta_3_2_ctr <= 2'h3;
          else if (_meta_2_ctr_T_4)
            meta_3_2_ctr <= 2'h0;
          else if (was_taken_2)
            meta_3_2_ctr <= _meta_2_ctr_T_5;
          else
            meta_3_2_ctr <= _meta_2_ctr_T_7;
        end
        else
          meta_3_2_ctr <= _meta_2_ctr_T_1;
      end
      if (_GEN_23 & _GEN_7) begin
        meta_4_2_tag <= s1_update_idx;
        meta_4_2_is_br <= s1_update__bits_br_mask[2];
        if (s1_update__bits_meta[6]) begin
          if (_meta_2_ctr_T_2)
            meta_4_2_ctr <= 2'h3;
          else if (_meta_2_ctr_T_4)
            meta_4_2_ctr <= 2'h0;
          else if (was_taken_2)
            meta_4_2_ctr <= _meta_2_ctr_T_5;
          else
            meta_4_2_ctr <= _meta_2_ctr_T_7;
        end
        else
          meta_4_2_ctr <= _meta_2_ctr_T_1;
      end
      if (_GEN_23 & _GEN_8) begin
        meta_5_2_tag <= s1_update_idx;
        meta_5_2_is_br <= s1_update__bits_br_mask[2];
        if (s1_update__bits_meta[6]) begin
          if (_meta_2_ctr_T_2)
            meta_5_2_ctr <= 2'h3;
          else if (_meta_2_ctr_T_4)
            meta_5_2_ctr <= 2'h0;
          else if (was_taken_2)
            meta_5_2_ctr <= _meta_2_ctr_T_5;
          else
            meta_5_2_ctr <= _meta_2_ctr_T_7;
        end
        else
          meta_5_2_ctr <= _meta_2_ctr_T_1;
      end
      if (_GEN_23 & _GEN_9) begin
        meta_6_2_tag <= s1_update_idx;
        meta_6_2_is_br <= s1_update__bits_br_mask[2];
        if (s1_update__bits_meta[6]) begin
          if (_meta_2_ctr_T_2)
            meta_6_2_ctr <= 2'h3;
          else if (_meta_2_ctr_T_4)
            meta_6_2_ctr <= 2'h0;
          else if (was_taken_2)
            meta_6_2_ctr <= _meta_2_ctr_T_5;
          else
            meta_6_2_ctr <= _meta_2_ctr_T_7;
        end
        else
          meta_6_2_ctr <= _meta_2_ctr_T_1;
      end
      if (_GEN_23 & _GEN_10) begin
        meta_7_2_tag <= s1_update_idx;
        meta_7_2_is_br <= s1_update__bits_br_mask[2];
        if (s1_update__bits_meta[6]) begin
          if (_meta_2_ctr_T_2)
            meta_7_2_ctr <= 2'h3;
          else if (_meta_2_ctr_T_4)
            meta_7_2_ctr <= 2'h0;
          else if (was_taken_2)
            meta_7_2_ctr <= _meta_2_ctr_T_5;
          else
            meta_7_2_ctr <= _meta_2_ctr_T_7;
        end
        else
          meta_7_2_ctr <= _meta_2_ctr_T_1;
      end
      if (_GEN_23 & _GEN_11) begin
        meta_8_2_tag <= s1_update_idx;
        meta_8_2_is_br <= s1_update__bits_br_mask[2];
        if (s1_update__bits_meta[6]) begin
          if (_meta_2_ctr_T_2)
            meta_8_2_ctr <= 2'h3;
          else if (_meta_2_ctr_T_4)
            meta_8_2_ctr <= 2'h0;
          else if (was_taken_2)
            meta_8_2_ctr <= _meta_2_ctr_T_5;
          else
            meta_8_2_ctr <= _meta_2_ctr_T_7;
        end
        else
          meta_8_2_ctr <= _meta_2_ctr_T_1;
      end
      if (_GEN_23 & _GEN_12) begin
        meta_9_2_tag <= s1_update_idx;
        meta_9_2_is_br <= s1_update__bits_br_mask[2];
        if (s1_update__bits_meta[6]) begin
          if (_meta_2_ctr_T_2)
            meta_9_2_ctr <= 2'h3;
          else if (_meta_2_ctr_T_4)
            meta_9_2_ctr <= 2'h0;
          else if (was_taken_2)
            meta_9_2_ctr <= _meta_2_ctr_T_5;
          else
            meta_9_2_ctr <= _meta_2_ctr_T_7;
        end
        else
          meta_9_2_ctr <= _meta_2_ctr_T_1;
      end
      if (_GEN_23 & _GEN_13) begin
        meta_10_2_tag <= s1_update_idx;
        meta_10_2_is_br <= s1_update__bits_br_mask[2];
        if (s1_update__bits_meta[6]) begin
          if (_meta_2_ctr_T_2)
            meta_10_2_ctr <= 2'h3;
          else if (_meta_2_ctr_T_4)
            meta_10_2_ctr <= 2'h0;
          else if (was_taken_2)
            meta_10_2_ctr <= _meta_2_ctr_T_5;
          else
            meta_10_2_ctr <= _meta_2_ctr_T_7;
        end
        else
          meta_10_2_ctr <= _meta_2_ctr_T_1;
      end
      if (_GEN_23 & _GEN_14) begin
        meta_11_2_tag <= s1_update_idx;
        meta_11_2_is_br <= s1_update__bits_br_mask[2];
        if (s1_update__bits_meta[6]) begin
          if (_meta_2_ctr_T_2)
            meta_11_2_ctr <= 2'h3;
          else if (_meta_2_ctr_T_4)
            meta_11_2_ctr <= 2'h0;
          else if (was_taken_2)
            meta_11_2_ctr <= _meta_2_ctr_T_5;
          else
            meta_11_2_ctr <= _meta_2_ctr_T_7;
        end
        else
          meta_11_2_ctr <= _meta_2_ctr_T_1;
      end
      if (_GEN_23 & _GEN_15) begin
        meta_12_2_tag <= s1_update_idx;
        meta_12_2_is_br <= s1_update__bits_br_mask[2];
        if (s1_update__bits_meta[6]) begin
          if (_meta_2_ctr_T_2)
            meta_12_2_ctr <= 2'h3;
          else if (_meta_2_ctr_T_4)
            meta_12_2_ctr <= 2'h0;
          else if (was_taken_2)
            meta_12_2_ctr <= _meta_2_ctr_T_5;
          else
            meta_12_2_ctr <= _meta_2_ctr_T_7;
        end
        else
          meta_12_2_ctr <= _meta_2_ctr_T_1;
      end
      if (_GEN_23 & _GEN_16) begin
        meta_13_2_tag <= s1_update_idx;
        meta_13_2_is_br <= s1_update__bits_br_mask[2];
        if (s1_update__bits_meta[6]) begin
          if (_meta_2_ctr_T_2)
            meta_13_2_ctr <= 2'h3;
          else if (_meta_2_ctr_T_4)
            meta_13_2_ctr <= 2'h0;
          else if (was_taken_2)
            meta_13_2_ctr <= _meta_2_ctr_T_5;
          else
            meta_13_2_ctr <= _meta_2_ctr_T_7;
        end
        else
          meta_13_2_ctr <= _meta_2_ctr_T_1;
      end
      if (_GEN_23 & _GEN_17) begin
        meta_14_2_tag <= s1_update_idx;
        meta_14_2_is_br <= s1_update__bits_br_mask[2];
        if (s1_update__bits_meta[6]) begin
          if (_meta_2_ctr_T_2)
            meta_14_2_ctr <= 2'h3;
          else if (_meta_2_ctr_T_4)
            meta_14_2_ctr <= 2'h0;
          else if (was_taken_2)
            meta_14_2_ctr <= _meta_2_ctr_T_5;
          else
            meta_14_2_ctr <= _meta_2_ctr_T_7;
        end
        else
          meta_14_2_ctr <= _meta_2_ctr_T_1;
      end
      if (_GEN_23 & (&(s1_update__bits_meta[3:0]))) begin
        meta_15_2_tag <= s1_update_idx;
        meta_15_2_is_br <= s1_update__bits_br_mask[2];
        if (s1_update__bits_meta[6]) begin
          if (_meta_2_ctr_T_2)
            meta_15_2_ctr <= 2'h3;
          else if (_meta_2_ctr_T_4)
            meta_15_2_ctr <= 2'h0;
          else if (was_taken_2)
            meta_15_2_ctr <= _meta_2_ctr_T_5;
          else
            meta_15_2_ctr <= _meta_2_ctr_T_7;
        end
        else
          meta_15_2_ctr <= _meta_2_ctr_T_1;
      end
      if (_GEN_24 & _GEN_1) begin
        meta_0_3_tag <= s1_update_idx;
        meta_0_3_is_br <= s1_update__bits_br_mask[3];
        if (s1_update__bits_meta[7]) begin
          if (_meta_3_ctr_T_2)
            meta_0_3_ctr <= 2'h3;
          else if (_meta_3_ctr_T_4)
            meta_0_3_ctr <= 2'h0;
          else if (was_taken_3)
            meta_0_3_ctr <= _meta_3_ctr_T_5;
          else
            meta_0_3_ctr <= _meta_3_ctr_T_7;
        end
        else
          meta_0_3_ctr <= _meta_3_ctr_T_1;
      end
      if (_GEN_24 & _GEN_4) begin
        meta_1_3_tag <= s1_update_idx;
        meta_1_3_is_br <= s1_update__bits_br_mask[3];
        if (s1_update__bits_meta[7]) begin
          if (_meta_3_ctr_T_2)
            meta_1_3_ctr <= 2'h3;
          else if (_meta_3_ctr_T_4)
            meta_1_3_ctr <= 2'h0;
          else if (was_taken_3)
            meta_1_3_ctr <= _meta_3_ctr_T_5;
          else
            meta_1_3_ctr <= _meta_3_ctr_T_7;
        end
        else
          meta_1_3_ctr <= _meta_3_ctr_T_1;
      end
      if (_GEN_24 & _GEN_5) begin
        meta_2_3_tag <= s1_update_idx;
        meta_2_3_is_br <= s1_update__bits_br_mask[3];
        if (s1_update__bits_meta[7]) begin
          if (_meta_3_ctr_T_2)
            meta_2_3_ctr <= 2'h3;
          else if (_meta_3_ctr_T_4)
            meta_2_3_ctr <= 2'h0;
          else if (was_taken_3)
            meta_2_3_ctr <= _meta_3_ctr_T_5;
          else
            meta_2_3_ctr <= _meta_3_ctr_T_7;
        end
        else
          meta_2_3_ctr <= _meta_3_ctr_T_1;
      end
      if (_GEN_24 & _GEN_6) begin
        meta_3_3_tag <= s1_update_idx;
        meta_3_3_is_br <= s1_update__bits_br_mask[3];
        if (s1_update__bits_meta[7]) begin
          if (_meta_3_ctr_T_2)
            meta_3_3_ctr <= 2'h3;
          else if (_meta_3_ctr_T_4)
            meta_3_3_ctr <= 2'h0;
          else if (was_taken_3)
            meta_3_3_ctr <= _meta_3_ctr_T_5;
          else
            meta_3_3_ctr <= _meta_3_ctr_T_7;
        end
        else
          meta_3_3_ctr <= _meta_3_ctr_T_1;
      end
      if (_GEN_24 & _GEN_7) begin
        meta_4_3_tag <= s1_update_idx;
        meta_4_3_is_br <= s1_update__bits_br_mask[3];
        if (s1_update__bits_meta[7]) begin
          if (_meta_3_ctr_T_2)
            meta_4_3_ctr <= 2'h3;
          else if (_meta_3_ctr_T_4)
            meta_4_3_ctr <= 2'h0;
          else if (was_taken_3)
            meta_4_3_ctr <= _meta_3_ctr_T_5;
          else
            meta_4_3_ctr <= _meta_3_ctr_T_7;
        end
        else
          meta_4_3_ctr <= _meta_3_ctr_T_1;
      end
      if (_GEN_24 & _GEN_8) begin
        meta_5_3_tag <= s1_update_idx;
        meta_5_3_is_br <= s1_update__bits_br_mask[3];
        if (s1_update__bits_meta[7]) begin
          if (_meta_3_ctr_T_2)
            meta_5_3_ctr <= 2'h3;
          else if (_meta_3_ctr_T_4)
            meta_5_3_ctr <= 2'h0;
          else if (was_taken_3)
            meta_5_3_ctr <= _meta_3_ctr_T_5;
          else
            meta_5_3_ctr <= _meta_3_ctr_T_7;
        end
        else
          meta_5_3_ctr <= _meta_3_ctr_T_1;
      end
      if (_GEN_24 & _GEN_9) begin
        meta_6_3_tag <= s1_update_idx;
        meta_6_3_is_br <= s1_update__bits_br_mask[3];
        if (s1_update__bits_meta[7]) begin
          if (_meta_3_ctr_T_2)
            meta_6_3_ctr <= 2'h3;
          else if (_meta_3_ctr_T_4)
            meta_6_3_ctr <= 2'h0;
          else if (was_taken_3)
            meta_6_3_ctr <= _meta_3_ctr_T_5;
          else
            meta_6_3_ctr <= _meta_3_ctr_T_7;
        end
        else
          meta_6_3_ctr <= _meta_3_ctr_T_1;
      end
      if (_GEN_24 & _GEN_10) begin
        meta_7_3_tag <= s1_update_idx;
        meta_7_3_is_br <= s1_update__bits_br_mask[3];
        if (s1_update__bits_meta[7]) begin
          if (_meta_3_ctr_T_2)
            meta_7_3_ctr <= 2'h3;
          else if (_meta_3_ctr_T_4)
            meta_7_3_ctr <= 2'h0;
          else if (was_taken_3)
            meta_7_3_ctr <= _meta_3_ctr_T_5;
          else
            meta_7_3_ctr <= _meta_3_ctr_T_7;
        end
        else
          meta_7_3_ctr <= _meta_3_ctr_T_1;
      end
      if (_GEN_24 & _GEN_11) begin
        meta_8_3_tag <= s1_update_idx;
        meta_8_3_is_br <= s1_update__bits_br_mask[3];
        if (s1_update__bits_meta[7]) begin
          if (_meta_3_ctr_T_2)
            meta_8_3_ctr <= 2'h3;
          else if (_meta_3_ctr_T_4)
            meta_8_3_ctr <= 2'h0;
          else if (was_taken_3)
            meta_8_3_ctr <= _meta_3_ctr_T_5;
          else
            meta_8_3_ctr <= _meta_3_ctr_T_7;
        end
        else
          meta_8_3_ctr <= _meta_3_ctr_T_1;
      end
      if (_GEN_24 & _GEN_12) begin
        meta_9_3_tag <= s1_update_idx;
        meta_9_3_is_br <= s1_update__bits_br_mask[3];
        if (s1_update__bits_meta[7]) begin
          if (_meta_3_ctr_T_2)
            meta_9_3_ctr <= 2'h3;
          else if (_meta_3_ctr_T_4)
            meta_9_3_ctr <= 2'h0;
          else if (was_taken_3)
            meta_9_3_ctr <= _meta_3_ctr_T_5;
          else
            meta_9_3_ctr <= _meta_3_ctr_T_7;
        end
        else
          meta_9_3_ctr <= _meta_3_ctr_T_1;
      end
      if (_GEN_24 & _GEN_13) begin
        meta_10_3_tag <= s1_update_idx;
        meta_10_3_is_br <= s1_update__bits_br_mask[3];
        if (s1_update__bits_meta[7]) begin
          if (_meta_3_ctr_T_2)
            meta_10_3_ctr <= 2'h3;
          else if (_meta_3_ctr_T_4)
            meta_10_3_ctr <= 2'h0;
          else if (was_taken_3)
            meta_10_3_ctr <= _meta_3_ctr_T_5;
          else
            meta_10_3_ctr <= _meta_3_ctr_T_7;
        end
        else
          meta_10_3_ctr <= _meta_3_ctr_T_1;
      end
      if (_GEN_24 & _GEN_14) begin
        meta_11_3_tag <= s1_update_idx;
        meta_11_3_is_br <= s1_update__bits_br_mask[3];
        if (s1_update__bits_meta[7]) begin
          if (_meta_3_ctr_T_2)
            meta_11_3_ctr <= 2'h3;
          else if (_meta_3_ctr_T_4)
            meta_11_3_ctr <= 2'h0;
          else if (was_taken_3)
            meta_11_3_ctr <= _meta_3_ctr_T_5;
          else
            meta_11_3_ctr <= _meta_3_ctr_T_7;
        end
        else
          meta_11_3_ctr <= _meta_3_ctr_T_1;
      end
      if (_GEN_24 & _GEN_15) begin
        meta_12_3_tag <= s1_update_idx;
        meta_12_3_is_br <= s1_update__bits_br_mask[3];
        if (s1_update__bits_meta[7]) begin
          if (_meta_3_ctr_T_2)
            meta_12_3_ctr <= 2'h3;
          else if (_meta_3_ctr_T_4)
            meta_12_3_ctr <= 2'h0;
          else if (was_taken_3)
            meta_12_3_ctr <= _meta_3_ctr_T_5;
          else
            meta_12_3_ctr <= _meta_3_ctr_T_7;
        end
        else
          meta_12_3_ctr <= _meta_3_ctr_T_1;
      end
      if (_GEN_24 & _GEN_16) begin
        meta_13_3_tag <= s1_update_idx;
        meta_13_3_is_br <= s1_update__bits_br_mask[3];
        if (s1_update__bits_meta[7]) begin
          if (_meta_3_ctr_T_2)
            meta_13_3_ctr <= 2'h3;
          else if (_meta_3_ctr_T_4)
            meta_13_3_ctr <= 2'h0;
          else if (was_taken_3)
            meta_13_3_ctr <= _meta_3_ctr_T_5;
          else
            meta_13_3_ctr <= _meta_3_ctr_T_7;
        end
        else
          meta_13_3_ctr <= _meta_3_ctr_T_1;
      end
      if (_GEN_24 & _GEN_17) begin
        meta_14_3_tag <= s1_update_idx;
        meta_14_3_is_br <= s1_update__bits_br_mask[3];
        if (s1_update__bits_meta[7]) begin
          if (_meta_3_ctr_T_2)
            meta_14_3_ctr <= 2'h3;
          else if (_meta_3_ctr_T_4)
            meta_14_3_ctr <= 2'h0;
          else if (was_taken_3)
            meta_14_3_ctr <= _meta_3_ctr_T_5;
          else
            meta_14_3_ctr <= _meta_3_ctr_T_7;
        end
        else
          meta_14_3_ctr <= _meta_3_ctr_T_1;
      end
      if (_GEN_24 & (&(s1_update__bits_meta[3:0]))) begin
        meta_15_3_tag <= s1_update_idx;
        meta_15_3_is_br <= s1_update__bits_br_mask[3];
        if (s1_update__bits_meta[7]) begin
          if (_meta_3_ctr_T_2)
            meta_15_3_ctr <= 2'h3;
          else if (_meta_3_ctr_T_4)
            meta_15_3_ctr <= 2'h0;
          else if (was_taken_3)
            meta_15_3_ctr <= _meta_3_ctr_T_5;
          else
            meta_15_3_ctr <= _meta_3_ctr_T_7;
        end
        else
          meta_15_3_ctr <= _meta_3_ctr_T_1;
      end
    end
  end // always @(posedge)
  assign io_resp_f1_0_taken = ~casez_tmp_0 | casez_tmp_1[1];
  assign io_resp_f1_0_is_br = _io_resp_f1_0_is_br_output;
  assign io_resp_f1_0_is_jal = _io_resp_f1_0_is_jal_output;
  assign io_resp_f1_0_predicted_pc_valid = _io_resp_f1_0_predicted_pc_valid_output;
  assign io_resp_f1_0_predicted_pc_bits = _s1_resp_0_bits_T_4;
  assign io_resp_f1_1_taken = ~casez_tmp_3 | casez_tmp_4[1];
  assign io_resp_f1_1_is_br = _io_resp_f1_1_is_br_output;
  assign io_resp_f1_1_is_jal = _io_resp_f1_1_is_jal_output;
  assign io_resp_f1_1_predicted_pc_valid = _io_resp_f1_1_predicted_pc_valid_output;
  assign io_resp_f1_1_predicted_pc_bits = _s1_resp_1_bits_T_4;
  assign io_resp_f1_2_taken = ~casez_tmp_6 | casez_tmp_7[1];
  assign io_resp_f1_2_is_br = _io_resp_f1_2_is_br_output;
  assign io_resp_f1_2_is_jal = _io_resp_f1_2_is_jal_output;
  assign io_resp_f1_2_predicted_pc_valid = _io_resp_f1_2_predicted_pc_valid_output;
  assign io_resp_f1_2_predicted_pc_bits = _s1_resp_2_bits_T_4;
  assign io_resp_f1_3_taken = ~casez_tmp_9 | casez_tmp_10[1];
  assign io_resp_f1_3_is_br = _io_resp_f1_3_is_br_output;
  assign io_resp_f1_3_is_jal = _io_resp_f1_3_is_jal_output;
  assign io_resp_f1_3_predicted_pc_valid = _io_resp_f1_3_predicted_pc_valid_output;
  assign io_resp_f1_3_predicted_pc_bits = _s1_resp_3_bits_T_4;
  assign io_resp_f2_0_is_br = io_resp_f2_0_REG_is_br;
  assign io_resp_f2_0_is_jal = io_resp_f2_0_REG_is_jal;
  assign io_resp_f2_0_predicted_pc_valid = io_resp_f2_0_REG_predicted_pc_valid;
  assign io_resp_f2_0_predicted_pc_bits = io_resp_f2_0_REG_predicted_pc_bits;
  assign io_resp_f2_1_is_br = io_resp_f2_1_REG_is_br;
  assign io_resp_f2_1_is_jal = io_resp_f2_1_REG_is_jal;
  assign io_resp_f2_1_predicted_pc_valid = io_resp_f2_1_REG_predicted_pc_valid;
  assign io_resp_f2_1_predicted_pc_bits = io_resp_f2_1_REG_predicted_pc_bits;
  assign io_resp_f2_2_is_br = io_resp_f2_2_REG_is_br;
  assign io_resp_f2_2_is_jal = io_resp_f2_2_REG_is_jal;
  assign io_resp_f2_2_predicted_pc_valid = io_resp_f2_2_REG_predicted_pc_valid;
  assign io_resp_f2_2_predicted_pc_bits = io_resp_f2_2_REG_predicted_pc_bits;
  assign io_resp_f2_3_is_br = io_resp_f2_3_REG_is_br;
  assign io_resp_f2_3_is_jal = io_resp_f2_3_REG_is_jal;
  assign io_resp_f2_3_predicted_pc_valid = io_resp_f2_3_REG_predicted_pc_valid;
  assign io_resp_f2_3_predicted_pc_bits = io_resp_f2_3_REG_predicted_pc_bits;
  assign io_resp_f3_0_predicted_pc_valid = io_resp_f3_0_REG_predicted_pc_valid;
  assign io_resp_f3_0_predicted_pc_bits = io_resp_f3_0_REG_predicted_pc_bits;
  assign io_resp_f3_1_predicted_pc_valid = io_resp_f3_1_REG_predicted_pc_valid;
  assign io_resp_f3_1_predicted_pc_bits = io_resp_f3_1_REG_predicted_pc_bits;
  assign io_resp_f3_2_predicted_pc_valid = io_resp_f3_2_REG_predicted_pc_valid;
  assign io_resp_f3_2_predicted_pc_bits = io_resp_f3_2_REG_predicted_pc_bits;
  assign io_resp_f3_3_predicted_pc_valid = io_resp_f3_3_REG_predicted_pc_valid;
  assign io_resp_f3_3_predicted_pc_bits = io_resp_f3_3_REG_predicted_pc_bits;
  assign io_f3_meta = {112'h0, io_f3_meta_REG_1};
endmodule

