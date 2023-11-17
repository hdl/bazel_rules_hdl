// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TageBranchPredictorBank(
  input          clock,
                 reset,
                 io_f0_valid,
  input  [39:0]  io_f0_pc,
  input  [63:0]  io_f1_ghist,
  input          io_resp_in_0_f1_0_taken,
                 io_resp_in_0_f1_0_is_br,
                 io_resp_in_0_f1_0_is_jal,
                 io_resp_in_0_f1_0_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f1_0_predicted_pc_bits,
  input          io_resp_in_0_f1_1_taken,
                 io_resp_in_0_f1_1_is_br,
                 io_resp_in_0_f1_1_is_jal,
                 io_resp_in_0_f1_1_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f1_1_predicted_pc_bits,
  input          io_resp_in_0_f1_2_taken,
                 io_resp_in_0_f1_2_is_br,
                 io_resp_in_0_f1_2_is_jal,
                 io_resp_in_0_f1_2_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f1_2_predicted_pc_bits,
  input          io_resp_in_0_f1_3_taken,
                 io_resp_in_0_f1_3_is_br,
                 io_resp_in_0_f1_3_is_jal,
                 io_resp_in_0_f1_3_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f1_3_predicted_pc_bits,
  input          io_resp_in_0_f2_0_taken,
                 io_resp_in_0_f2_0_is_br,
                 io_resp_in_0_f2_0_is_jal,
                 io_resp_in_0_f2_0_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f2_0_predicted_pc_bits,
  input          io_resp_in_0_f2_1_taken,
                 io_resp_in_0_f2_1_is_br,
                 io_resp_in_0_f2_1_is_jal,
                 io_resp_in_0_f2_1_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f2_1_predicted_pc_bits,
  input          io_resp_in_0_f2_2_taken,
                 io_resp_in_0_f2_2_is_br,
                 io_resp_in_0_f2_2_is_jal,
                 io_resp_in_0_f2_2_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f2_2_predicted_pc_bits,
  input          io_resp_in_0_f2_3_taken,
                 io_resp_in_0_f2_3_is_br,
                 io_resp_in_0_f2_3_is_jal,
                 io_resp_in_0_f2_3_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f2_3_predicted_pc_bits,
  input          io_resp_in_0_f3_0_taken,
                 io_resp_in_0_f3_0_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f3_0_predicted_pc_bits,
  input          io_resp_in_0_f3_1_taken,
                 io_resp_in_0_f3_1_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f3_1_predicted_pc_bits,
  input          io_resp_in_0_f3_2_taken,
                 io_resp_in_0_f3_2_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f3_2_predicted_pc_bits,
  input          io_resp_in_0_f3_3_taken,
                 io_resp_in_0_f3_3_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f3_3_predicted_pc_bits,
  input          io_update_valid,
                 io_update_bits_is_mispredict_update,
                 io_update_bits_is_repair_update,
  input  [3:0]   io_update_bits_btb_mispredicts,
  input  [39:0]  io_update_bits_pc,
  input  [3:0]   io_update_bits_br_mask,
  input          io_update_bits_cfi_idx_valid,
  input  [1:0]   io_update_bits_cfi_idx_bits,
  input          io_update_bits_cfi_taken,
                 io_update_bits_cfi_mispredicted,
  input  [63:0]  io_update_bits_ghist,
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
  output         io_resp_f2_0_taken,
                 io_resp_f2_0_is_br,
                 io_resp_f2_0_is_jal,
                 io_resp_f2_0_predicted_pc_valid,
  output [39:0]  io_resp_f2_0_predicted_pc_bits,
  output         io_resp_f2_1_taken,
                 io_resp_f2_1_is_br,
                 io_resp_f2_1_is_jal,
                 io_resp_f2_1_predicted_pc_valid,
  output [39:0]  io_resp_f2_1_predicted_pc_bits,
  output         io_resp_f2_2_taken,
                 io_resp_f2_2_is_br,
                 io_resp_f2_2_is_jal,
                 io_resp_f2_2_predicted_pc_valid,
  output [39:0]  io_resp_f2_2_predicted_pc_bits,
  output         io_resp_f2_3_taken,
                 io_resp_f2_3_is_br,
                 io_resp_f2_3_is_jal,
                 io_resp_f2_3_predicted_pc_valid,
  output [39:0]  io_resp_f2_3_predicted_pc_bits,
  output         io_resp_f3_0_taken,
                 io_resp_f3_0_predicted_pc_valid,
  output [39:0]  io_resp_f3_0_predicted_pc_bits,
  output         io_resp_f3_1_taken,
                 io_resp_f3_1_predicted_pc_valid,
  output [39:0]  io_resp_f3_1_predicted_pc_bits,
  output         io_resp_f3_2_taken,
                 io_resp_f3_2_predicted_pc_valid,
  output [39:0]  io_resp_f3_2_predicted_pc_bits,
  output         io_resp_f3_3_taken,
                 io_resp_f3_3_predicted_pc_valid,
  output [39:0]  io_resp_f3_3_predicted_pc_bits,
  output [119:0] io_f3_meta
);

  wire         _io_resp_f3_3_taken_output;
  wire         _io_resp_f3_2_taken_output;
  wire         _io_resp_f3_1_taken_output;
  wire         _io_resp_f3_0_taken_output;
  wire         _alloc_lfsr_prng_3_io_out_0;
  wire         _alloc_lfsr_prng_3_io_out_1;
  wire         _alloc_lfsr_prng_3_io_out_2;
  wire         _alloc_lfsr_prng_3_io_out_3;
  wire         _alloc_lfsr_prng_3_io_out_4;
  wire         _alloc_lfsr_prng_3_io_out_5;
  wire         _alloc_lfsr_prng_2_io_out_0;
  wire         _alloc_lfsr_prng_2_io_out_1;
  wire         _alloc_lfsr_prng_2_io_out_2;
  wire         _alloc_lfsr_prng_2_io_out_3;
  wire         _alloc_lfsr_prng_2_io_out_4;
  wire         _alloc_lfsr_prng_2_io_out_5;
  wire         _alloc_lfsr_prng_1_io_out_0;
  wire         _alloc_lfsr_prng_1_io_out_1;
  wire         _alloc_lfsr_prng_1_io_out_2;
  wire         _alloc_lfsr_prng_1_io_out_3;
  wire         _alloc_lfsr_prng_1_io_out_4;
  wire         _alloc_lfsr_prng_1_io_out_5;
  wire         _alloc_lfsr_prng_io_out_0;
  wire         _alloc_lfsr_prng_io_out_1;
  wire         _alloc_lfsr_prng_io_out_2;
  wire         _alloc_lfsr_prng_io_out_3;
  wire         _alloc_lfsr_prng_io_out_4;
  wire         _alloc_lfsr_prng_io_out_5;
  wire         _t_5_io_f3_resp_0_valid;
  wire [2:0]   _t_5_io_f3_resp_0_bits_ctr;
  wire [1:0]   _t_5_io_f3_resp_0_bits_u;
  wire         _t_5_io_f3_resp_1_valid;
  wire [2:0]   _t_5_io_f3_resp_1_bits_ctr;
  wire [1:0]   _t_5_io_f3_resp_1_bits_u;
  wire         _t_5_io_f3_resp_2_valid;
  wire [2:0]   _t_5_io_f3_resp_2_bits_ctr;
  wire [1:0]   _t_5_io_f3_resp_2_bits_u;
  wire         _t_5_io_f3_resp_3_valid;
  wire [2:0]   _t_5_io_f3_resp_3_bits_ctr;
  wire [1:0]   _t_5_io_f3_resp_3_bits_u;
  wire         _t_4_io_f3_resp_0_valid;
  wire [2:0]   _t_4_io_f3_resp_0_bits_ctr;
  wire [1:0]   _t_4_io_f3_resp_0_bits_u;
  wire         _t_4_io_f3_resp_1_valid;
  wire [2:0]   _t_4_io_f3_resp_1_bits_ctr;
  wire [1:0]   _t_4_io_f3_resp_1_bits_u;
  wire         _t_4_io_f3_resp_2_valid;
  wire [2:0]   _t_4_io_f3_resp_2_bits_ctr;
  wire [1:0]   _t_4_io_f3_resp_2_bits_u;
  wire         _t_4_io_f3_resp_3_valid;
  wire [2:0]   _t_4_io_f3_resp_3_bits_ctr;
  wire [1:0]   _t_4_io_f3_resp_3_bits_u;
  wire         _t_3_io_f3_resp_0_valid;
  wire [2:0]   _t_3_io_f3_resp_0_bits_ctr;
  wire [1:0]   _t_3_io_f3_resp_0_bits_u;
  wire         _t_3_io_f3_resp_1_valid;
  wire [2:0]   _t_3_io_f3_resp_1_bits_ctr;
  wire [1:0]   _t_3_io_f3_resp_1_bits_u;
  wire         _t_3_io_f3_resp_2_valid;
  wire [2:0]   _t_3_io_f3_resp_2_bits_ctr;
  wire [1:0]   _t_3_io_f3_resp_2_bits_u;
  wire         _t_3_io_f3_resp_3_valid;
  wire [2:0]   _t_3_io_f3_resp_3_bits_ctr;
  wire [1:0]   _t_3_io_f3_resp_3_bits_u;
  wire         _t_2_io_f3_resp_0_valid;
  wire [2:0]   _t_2_io_f3_resp_0_bits_ctr;
  wire [1:0]   _t_2_io_f3_resp_0_bits_u;
  wire         _t_2_io_f3_resp_1_valid;
  wire [2:0]   _t_2_io_f3_resp_1_bits_ctr;
  wire [1:0]   _t_2_io_f3_resp_1_bits_u;
  wire         _t_2_io_f3_resp_2_valid;
  wire [2:0]   _t_2_io_f3_resp_2_bits_ctr;
  wire [1:0]   _t_2_io_f3_resp_2_bits_u;
  wire         _t_2_io_f3_resp_3_valid;
  wire [2:0]   _t_2_io_f3_resp_3_bits_ctr;
  wire [1:0]   _t_2_io_f3_resp_3_bits_u;
  wire         _t_1_io_f3_resp_0_valid;
  wire [2:0]   _t_1_io_f3_resp_0_bits_ctr;
  wire [1:0]   _t_1_io_f3_resp_0_bits_u;
  wire         _t_1_io_f3_resp_1_valid;
  wire [2:0]   _t_1_io_f3_resp_1_bits_ctr;
  wire [1:0]   _t_1_io_f3_resp_1_bits_u;
  wire         _t_1_io_f3_resp_2_valid;
  wire [2:0]   _t_1_io_f3_resp_2_bits_ctr;
  wire [1:0]   _t_1_io_f3_resp_2_bits_u;
  wire         _t_1_io_f3_resp_3_valid;
  wire [2:0]   _t_1_io_f3_resp_3_bits_ctr;
  wire [1:0]   _t_1_io_f3_resp_3_bits_u;
  wire         _t_io_f3_resp_0_valid;
  wire [2:0]   _t_io_f3_resp_0_bits_ctr;
  wire [1:0]   _t_io_f3_resp_0_bits_u;
  wire         _t_io_f3_resp_1_valid;
  wire [2:0]   _t_io_f3_resp_1_bits_ctr;
  wire [1:0]   _t_io_f3_resp_1_bits_u;
  wire         _t_io_f3_resp_2_valid;
  wire [2:0]   _t_io_f3_resp_2_bits_ctr;
  wire [1:0]   _t_io_f3_resp_2_bits_u;
  wire         _t_io_f3_resp_3_valid;
  wire [2:0]   _t_io_f3_resp_3_bits_ctr;
  wire [1:0]   _t_io_f3_resp_3_bits_u;
  reg  [2:0]   casez_tmp;
  reg  [2:0]   casez_tmp_0;
  reg  [2:0]   casez_tmp_1;
  reg  [2:0]   casez_tmp_2;
  reg  [1:0]   casez_tmp_3;
  reg  [1:0]   casez_tmp_4;
  reg  [1:0]   casez_tmp_5;
  reg  [1:0]   casez_tmp_6;
  reg          casez_tmp_7;
  reg  [2:0]   casez_tmp_8;
  reg  [2:0]   casez_tmp_9;
  reg          casez_tmp_10;
  reg          s1_update__valid;
  reg          s1_update__bits_is_mispredict_update;
  reg          s1_update__bits_is_repair_update;
  reg  [3:0]   s1_update__bits_btb_mispredicts;
  reg  [39:0]  s1_update__bits_pc;
  reg  [3:0]   s1_update__bits_br_mask;
  reg          s1_update__bits_cfi_idx_valid;
  reg  [1:0]   s1_update__bits_cfi_idx_bits;
  reg          s1_update__bits_cfi_taken;
  reg          s1_update__bits_cfi_mispredicted;
  reg  [63:0]  s1_update__bits_ghist;
  reg  [119:0] s1_update__bits_meta;
  wire [2:0]   f3_meta_provider_1_bits = _t_5_io_f3_resp_1_valid ? 3'h5 : _t_4_io_f3_resp_1_valid ? 3'h4 : {1'h0, _t_3_io_f3_resp_1_valid ? 2'h3 : _t_2_io_f3_resp_1_valid ? 2'h2 : {1'h0, _t_1_io_f3_resp_1_valid}};
  wire [7:0]   _allocatable_slots_T_59 = 8'h1 << f3_meta_provider_1_bits;
  wire [5:0]   _GEN = _allocatable_slots_T_59[5:0] | _allocatable_slots_T_59[6:1] | _allocatable_slots_T_59[7:2];
  wire [4:0]   _GEN_0 = _GEN[4:0] | _allocatable_slots_T_59[7:3];
  wire [3:0]   _GEN_1 = _GEN_0[3:0] | _allocatable_slots_T_59[7:4];
  wire [2:0]   _GEN_2 = _GEN_1[2:0] | _allocatable_slots_T_59[7:5];
  wire [1:0]   _GEN_3 = _GEN_2[1:0] | _allocatable_slots_T_59[7:6];
  wire         f3_meta_provider_1_valid = _t_io_f3_resp_1_valid | _t_1_io_f3_resp_1_valid | _t_2_io_f3_resp_1_valid | _t_3_io_f3_resp_1_valid | _t_4_io_f3_resp_1_valid | _t_5_io_f3_resp_1_valid;
  wire [5:0]   _GEN_4 = ~({_GEN[5], _GEN_0[4], _GEN_1[3], _GEN_2[2], _GEN_3[1], _GEN_3[0] | (&f3_meta_provider_1_bits)} & {6{f3_meta_provider_1_valid}}) & {~_t_5_io_f3_resp_1_valid & _t_5_io_f3_resp_1_bits_u == 2'h0, ~_t_4_io_f3_resp_1_valid & _t_4_io_f3_resp_1_bits_u == 2'h0, ~_t_3_io_f3_resp_1_valid & _t_3_io_f3_resp_1_bits_u == 2'h0, ~_t_2_io_f3_resp_1_valid & _t_2_io_f3_resp_1_bits_u == 2'h0, ~_t_1_io_f3_resp_1_valid & _t_1_io_f3_resp_1_bits_u == 2'h0, ~_t_io_f3_resp_1_valid & _t_io_f3_resp_1_bits_u == 2'h0};
  wire [5:0]   _GEN_5 = _GEN_4 & {_alloc_lfsr_prng_1_io_out_5, _alloc_lfsr_prng_1_io_out_4, _alloc_lfsr_prng_1_io_out_3, _alloc_lfsr_prng_1_io_out_2, _alloc_lfsr_prng_1_io_out_1, _alloc_lfsr_prng_1_io_out_0};
  wire [2:0]   masked_entry_1 = _GEN_5[0] ? 3'h0 : _GEN_5[1] ? 3'h1 : _GEN_5[2] ? 3'h2 : _GEN_5[3] ? 3'h3 : _GEN_5[4] ? 3'h4 : {1'h1, ~(_GEN_5[5]), 1'h1};
  wire [7:0]   _alloc_entry_T_2 = {2'h0, _GEN_4} >> masked_entry_1;
  wire [2:0]   f3_meta_provider_0_bits = _t_5_io_f3_resp_0_valid ? 3'h5 : _t_4_io_f3_resp_0_valid ? 3'h4 : {1'h0, _t_3_io_f3_resp_0_valid ? 2'h3 : _t_2_io_f3_resp_0_valid ? 2'h2 : {1'h0, _t_1_io_f3_resp_0_valid}};
  wire [7:0]   _allocatable_slots_T_20 = 8'h1 << f3_meta_provider_0_bits;
  wire [5:0]   _GEN_6 = _allocatable_slots_T_20[5:0] | _allocatable_slots_T_20[6:1] | _allocatable_slots_T_20[7:2];
  wire [4:0]   _GEN_7 = _GEN_6[4:0] | _allocatable_slots_T_20[7:3];
  wire [3:0]   _GEN_8 = _GEN_7[3:0] | _allocatable_slots_T_20[7:4];
  wire [2:0]   _GEN_9 = _GEN_8[2:0] | _allocatable_slots_T_20[7:5];
  wire [1:0]   _GEN_10 = _GEN_9[1:0] | _allocatable_slots_T_20[7:6];
  wire         f3_meta_provider_0_valid = _t_io_f3_resp_0_valid | _t_1_io_f3_resp_0_valid | _t_2_io_f3_resp_0_valid | _t_3_io_f3_resp_0_valid | _t_4_io_f3_resp_0_valid | _t_5_io_f3_resp_0_valid;
  wire [5:0]   _GEN_11 = ~({_GEN_6[5], _GEN_7[4], _GEN_8[3], _GEN_9[2], _GEN_10[1], _GEN_10[0] | (&f3_meta_provider_0_bits)} & {6{f3_meta_provider_0_valid}}) & {~_t_5_io_f3_resp_0_valid & _t_5_io_f3_resp_0_bits_u == 2'h0, ~_t_4_io_f3_resp_0_valid & _t_4_io_f3_resp_0_bits_u == 2'h0, ~_t_3_io_f3_resp_0_valid & _t_3_io_f3_resp_0_bits_u == 2'h0, ~_t_2_io_f3_resp_0_valid & _t_2_io_f3_resp_0_bits_u == 2'h0, ~_t_1_io_f3_resp_0_valid & _t_1_io_f3_resp_0_bits_u == 2'h0, ~_t_io_f3_resp_0_valid & _t_io_f3_resp_0_bits_u == 2'h0};
  wire [5:0]   _GEN_12 = _GEN_11 & {_alloc_lfsr_prng_io_out_5, _alloc_lfsr_prng_io_out_4, _alloc_lfsr_prng_io_out_3, _alloc_lfsr_prng_io_out_2, _alloc_lfsr_prng_io_out_1, _alloc_lfsr_prng_io_out_0};
  wire [2:0]   masked_entry = _GEN_12[0] ? 3'h0 : _GEN_12[1] ? 3'h1 : _GEN_12[2] ? 3'h2 : _GEN_12[3] ? 3'h3 : _GEN_12[4] ? 3'h4 : {1'h1, ~(_GEN_12[5]), 1'h1};
  wire [7:0]   _alloc_entry_T = {2'h0, _GEN_11} >> masked_entry;
  wire [2:0]   f3_meta_provider_2_bits = _t_5_io_f3_resp_2_valid ? 3'h5 : _t_4_io_f3_resp_2_valid ? 3'h4 : {1'h0, _t_3_io_f3_resp_2_valid ? 2'h3 : _t_2_io_f3_resp_2_valid ? 2'h2 : {1'h0, _t_1_io_f3_resp_2_valid}};
  wire [7:0]   _allocatable_slots_T_98 = 8'h1 << f3_meta_provider_2_bits;
  wire [5:0]   _GEN_13 = _allocatable_slots_T_98[5:0] | _allocatable_slots_T_98[6:1] | _allocatable_slots_T_98[7:2];
  wire [4:0]   _GEN_14 = _GEN_13[4:0] | _allocatable_slots_T_98[7:3];
  wire [3:0]   _GEN_15 = _GEN_14[3:0] | _allocatable_slots_T_98[7:4];
  wire [2:0]   _GEN_16 = _GEN_15[2:0] | _allocatable_slots_T_98[7:5];
  wire [1:0]   _GEN_17 = _GEN_16[1:0] | _allocatable_slots_T_98[7:6];
  wire         f3_meta_provider_2_valid = _t_io_f3_resp_2_valid | _t_1_io_f3_resp_2_valid | _t_2_io_f3_resp_2_valid | _t_3_io_f3_resp_2_valid | _t_4_io_f3_resp_2_valid | _t_5_io_f3_resp_2_valid;
  wire [5:0]   _GEN_18 = ~({_GEN_13[5], _GEN_14[4], _GEN_15[3], _GEN_16[2], _GEN_17[1], _GEN_17[0] | (&f3_meta_provider_2_bits)} & {6{f3_meta_provider_2_valid}}) & {~_t_5_io_f3_resp_2_valid & _t_5_io_f3_resp_2_bits_u == 2'h0, ~_t_4_io_f3_resp_2_valid & _t_4_io_f3_resp_2_bits_u == 2'h0, ~_t_3_io_f3_resp_2_valid & _t_3_io_f3_resp_2_bits_u == 2'h0, ~_t_2_io_f3_resp_2_valid & _t_2_io_f3_resp_2_bits_u == 2'h0, ~_t_1_io_f3_resp_2_valid & _t_1_io_f3_resp_2_bits_u == 2'h0, ~_t_io_f3_resp_2_valid & _t_io_f3_resp_2_bits_u == 2'h0};
  wire [5:0]   _GEN_19 = _GEN_18 & {_alloc_lfsr_prng_2_io_out_5, _alloc_lfsr_prng_2_io_out_4, _alloc_lfsr_prng_2_io_out_3, _alloc_lfsr_prng_2_io_out_2, _alloc_lfsr_prng_2_io_out_1, _alloc_lfsr_prng_2_io_out_0};
  wire [2:0]   masked_entry_2 = _GEN_19[0] ? 3'h0 : _GEN_19[1] ? 3'h1 : _GEN_19[2] ? 3'h2 : _GEN_19[3] ? 3'h3 : _GEN_19[4] ? 3'h4 : {1'h1, ~(_GEN_19[5]), 1'h1};
  wire [7:0]   _alloc_entry_T_4 = {2'h0, _GEN_18} >> masked_entry_2;
  wire [2:0]   f3_meta_provider_3_bits = _t_5_io_f3_resp_3_valid ? 3'h5 : _t_4_io_f3_resp_3_valid ? 3'h4 : {1'h0, _t_3_io_f3_resp_3_valid ? 2'h3 : _t_2_io_f3_resp_3_valid ? 2'h2 : {1'h0, _t_1_io_f3_resp_3_valid}};
  wire [7:0]   _allocatable_slots_T_137 = 8'h1 << f3_meta_provider_3_bits;
  wire [5:0]   _GEN_20 = _allocatable_slots_T_137[5:0] | _allocatable_slots_T_137[6:1] | _allocatable_slots_T_137[7:2];
  wire [4:0]   _GEN_21 = _GEN_20[4:0] | _allocatable_slots_T_137[7:3];
  wire [3:0]   _GEN_22 = _GEN_21[3:0] | _allocatable_slots_T_137[7:4];
  wire [2:0]   _GEN_23 = _GEN_22[2:0] | _allocatable_slots_T_137[7:5];
  wire [1:0]   _GEN_24 = _GEN_23[1:0] | _allocatable_slots_T_137[7:6];
  wire         f3_meta_provider_3_valid = _t_io_f3_resp_3_valid | _t_1_io_f3_resp_3_valid | _t_2_io_f3_resp_3_valid | _t_3_io_f3_resp_3_valid | _t_4_io_f3_resp_3_valid | _t_5_io_f3_resp_3_valid;
  wire [5:0]   _GEN_25 = ~({_GEN_20[5], _GEN_21[4], _GEN_22[3], _GEN_23[2], _GEN_24[1], _GEN_24[0] | (&f3_meta_provider_3_bits)} & {6{f3_meta_provider_3_valid}}) & {~_t_5_io_f3_resp_3_valid & _t_5_io_f3_resp_3_bits_u == 2'h0, ~_t_4_io_f3_resp_3_valid & _t_4_io_f3_resp_3_bits_u == 2'h0, ~_t_3_io_f3_resp_3_valid & _t_3_io_f3_resp_3_bits_u == 2'h0, ~_t_2_io_f3_resp_3_valid & _t_2_io_f3_resp_3_bits_u == 2'h0, ~_t_1_io_f3_resp_3_valid & _t_1_io_f3_resp_3_bits_u == 2'h0, ~_t_io_f3_resp_3_valid & _t_io_f3_resp_3_bits_u == 2'h0};
  wire [5:0]   _GEN_26 = _GEN_25 & {_alloc_lfsr_prng_3_io_out_5, _alloc_lfsr_prng_3_io_out_4, _alloc_lfsr_prng_3_io_out_3, _alloc_lfsr_prng_3_io_out_2, _alloc_lfsr_prng_3_io_out_1, _alloc_lfsr_prng_3_io_out_0};
  wire [2:0]   masked_entry_3 = _GEN_26[0] ? 3'h0 : _GEN_26[1] ? 3'h1 : _GEN_26[2] ? 3'h2 : _GEN_26[3] ? 3'h3 : _GEN_26[4] ? 3'h4 : {1'h1, ~(_GEN_26[5]), 1'h1};
  wire [7:0]   _alloc_entry_T_6 = {2'h0, _GEN_25} >> masked_entry_3;
  always @(*) begin
    casez (f3_meta_provider_1_bits)
      3'b000:
        casez_tmp = _t_io_f3_resp_1_bits_ctr;
      3'b001:
        casez_tmp = _t_1_io_f3_resp_1_bits_ctr;
      3'b010:
        casez_tmp = _t_2_io_f3_resp_1_bits_ctr;
      3'b011:
        casez_tmp = _t_3_io_f3_resp_1_bits_ctr;
      3'b100:
        casez_tmp = _t_4_io_f3_resp_1_bits_ctr;
      3'b101:
        casez_tmp = _t_5_io_f3_resp_1_bits_ctr;
      3'b110:
        casez_tmp = _t_io_f3_resp_1_bits_ctr;
      default:
        casez_tmp = _t_io_f3_resp_1_bits_ctr;
    endcase
  end // always @(*)
  always @(*) begin
    casez (f3_meta_provider_0_bits)
      3'b000:
        casez_tmp_0 = _t_io_f3_resp_0_bits_ctr;
      3'b001:
        casez_tmp_0 = _t_1_io_f3_resp_0_bits_ctr;
      3'b010:
        casez_tmp_0 = _t_2_io_f3_resp_0_bits_ctr;
      3'b011:
        casez_tmp_0 = _t_3_io_f3_resp_0_bits_ctr;
      3'b100:
        casez_tmp_0 = _t_4_io_f3_resp_0_bits_ctr;
      3'b101:
        casez_tmp_0 = _t_5_io_f3_resp_0_bits_ctr;
      3'b110:
        casez_tmp_0 = _t_io_f3_resp_0_bits_ctr;
      default:
        casez_tmp_0 = _t_io_f3_resp_0_bits_ctr;
    endcase
  end // always @(*)
  always @(*) begin
    casez (f3_meta_provider_3_bits)
      3'b000:
        casez_tmp_1 = _t_io_f3_resp_3_bits_ctr;
      3'b001:
        casez_tmp_1 = _t_1_io_f3_resp_3_bits_ctr;
      3'b010:
        casez_tmp_1 = _t_2_io_f3_resp_3_bits_ctr;
      3'b011:
        casez_tmp_1 = _t_3_io_f3_resp_3_bits_ctr;
      3'b100:
        casez_tmp_1 = _t_4_io_f3_resp_3_bits_ctr;
      3'b101:
        casez_tmp_1 = _t_5_io_f3_resp_3_bits_ctr;
      3'b110:
        casez_tmp_1 = _t_io_f3_resp_3_bits_ctr;
      default:
        casez_tmp_1 = _t_io_f3_resp_3_bits_ctr;
    endcase
  end // always @(*)
  always @(*) begin
    casez (f3_meta_provider_2_bits)
      3'b000:
        casez_tmp_2 = _t_io_f3_resp_2_bits_ctr;
      3'b001:
        casez_tmp_2 = _t_1_io_f3_resp_2_bits_ctr;
      3'b010:
        casez_tmp_2 = _t_2_io_f3_resp_2_bits_ctr;
      3'b011:
        casez_tmp_2 = _t_3_io_f3_resp_2_bits_ctr;
      3'b100:
        casez_tmp_2 = _t_4_io_f3_resp_2_bits_ctr;
      3'b101:
        casez_tmp_2 = _t_5_io_f3_resp_2_bits_ctr;
      3'b110:
        casez_tmp_2 = _t_io_f3_resp_2_bits_ctr;
      default:
        casez_tmp_2 = _t_io_f3_resp_2_bits_ctr;
    endcase
  end // always @(*)
  always @(*) begin
    casez (f3_meta_provider_1_bits)
      3'b000:
        casez_tmp_3 = _t_io_f3_resp_1_bits_u;
      3'b001:
        casez_tmp_3 = _t_1_io_f3_resp_1_bits_u;
      3'b010:
        casez_tmp_3 = _t_2_io_f3_resp_1_bits_u;
      3'b011:
        casez_tmp_3 = _t_3_io_f3_resp_1_bits_u;
      3'b100:
        casez_tmp_3 = _t_4_io_f3_resp_1_bits_u;
      3'b101:
        casez_tmp_3 = _t_5_io_f3_resp_1_bits_u;
      3'b110:
        casez_tmp_3 = _t_io_f3_resp_1_bits_u;
      default:
        casez_tmp_3 = _t_io_f3_resp_1_bits_u;
    endcase
  end // always @(*)
  always @(*) begin
    casez (f3_meta_provider_0_bits)
      3'b000:
        casez_tmp_4 = _t_io_f3_resp_0_bits_u;
      3'b001:
        casez_tmp_4 = _t_1_io_f3_resp_0_bits_u;
      3'b010:
        casez_tmp_4 = _t_2_io_f3_resp_0_bits_u;
      3'b011:
        casez_tmp_4 = _t_3_io_f3_resp_0_bits_u;
      3'b100:
        casez_tmp_4 = _t_4_io_f3_resp_0_bits_u;
      3'b101:
        casez_tmp_4 = _t_5_io_f3_resp_0_bits_u;
      3'b110:
        casez_tmp_4 = _t_io_f3_resp_0_bits_u;
      default:
        casez_tmp_4 = _t_io_f3_resp_0_bits_u;
    endcase
  end // always @(*)
  wire         _GEN_27 = _t_io_f3_resp_0_valid ? _t_io_f3_resp_0_bits_ctr[2] : io_resp_in_0_f3_0_taken;
  wire         _GEN_28 = _t_1_io_f3_resp_0_valid ? _t_1_io_f3_resp_0_bits_ctr[2] : _GEN_27;
  wire         _GEN_29 = _t_2_io_f3_resp_0_valid ? _t_2_io_f3_resp_0_bits_ctr[2] : _GEN_28;
  wire         _GEN_30 = _t_3_io_f3_resp_0_valid ? _t_3_io_f3_resp_0_bits_ctr[2] : _GEN_29;
  wire         _GEN_31 = _t_4_io_f3_resp_0_valid ? _t_4_io_f3_resp_0_bits_ctr[2] : _GEN_30;
  always @(*) begin
    casez (f3_meta_provider_3_bits)
      3'b000:
        casez_tmp_5 = _t_io_f3_resp_3_bits_u;
      3'b001:
        casez_tmp_5 = _t_1_io_f3_resp_3_bits_u;
      3'b010:
        casez_tmp_5 = _t_2_io_f3_resp_3_bits_u;
      3'b011:
        casez_tmp_5 = _t_3_io_f3_resp_3_bits_u;
      3'b100:
        casez_tmp_5 = _t_4_io_f3_resp_3_bits_u;
      3'b101:
        casez_tmp_5 = _t_5_io_f3_resp_3_bits_u;
      3'b110:
        casez_tmp_5 = _t_io_f3_resp_3_bits_u;
      default:
        casez_tmp_5 = _t_io_f3_resp_3_bits_u;
    endcase
  end // always @(*)
  always @(*) begin
    casez (f3_meta_provider_2_bits)
      3'b000:
        casez_tmp_6 = _t_io_f3_resp_2_bits_u;
      3'b001:
        casez_tmp_6 = _t_1_io_f3_resp_2_bits_u;
      3'b010:
        casez_tmp_6 = _t_2_io_f3_resp_2_bits_u;
      3'b011:
        casez_tmp_6 = _t_3_io_f3_resp_2_bits_u;
      3'b100:
        casez_tmp_6 = _t_4_io_f3_resp_2_bits_u;
      3'b101:
        casez_tmp_6 = _t_5_io_f3_resp_2_bits_u;
      3'b110:
        casez_tmp_6 = _t_io_f3_resp_2_bits_u;
      default:
        casez_tmp_6 = _t_io_f3_resp_2_bits_u;
    endcase
  end // always @(*)
  wire         _GEN_32 = _t_io_f3_resp_2_valid ? _t_io_f3_resp_2_bits_ctr[2] : io_resp_in_0_f3_2_taken;
  wire         _GEN_33 = _t_1_io_f3_resp_2_valid ? _t_1_io_f3_resp_2_bits_ctr[2] : _GEN_32;
  wire         _GEN_34 = _t_2_io_f3_resp_2_valid ? _t_2_io_f3_resp_2_bits_ctr[2] : _GEN_33;
  wire         _GEN_35 = _t_3_io_f3_resp_2_valid ? _t_3_io_f3_resp_2_bits_ctr[2] : _GEN_34;
  wire         _GEN_36 = _t_4_io_f3_resp_2_valid ? _t_4_io_f3_resp_2_bits_ctr[2] : _GEN_35;
  wire         _GEN_37 = _t_io_f3_resp_1_valid ? _t_io_f3_resp_1_bits_ctr[2] : io_resp_in_0_f3_1_taken;
  wire         _GEN_38 = _t_1_io_f3_resp_1_valid ? _t_1_io_f3_resp_1_bits_ctr[2] : _GEN_37;
  wire         _GEN_39 = _t_2_io_f3_resp_1_valid ? _t_2_io_f3_resp_1_bits_ctr[2] : _GEN_38;
  wire         _GEN_40 = _t_3_io_f3_resp_1_valid ? _t_3_io_f3_resp_1_bits_ctr[2] : _GEN_39;
  wire         _GEN_41 = _t_4_io_f3_resp_1_valid ? _t_4_io_f3_resp_1_bits_ctr[2] : _GEN_40;
  wire         _GEN_42 = _t_io_f3_resp_3_valid ? _t_io_f3_resp_3_bits_ctr[2] : io_resp_in_0_f3_3_taken;
  wire         _GEN_43 = _t_1_io_f3_resp_3_valid ? _t_1_io_f3_resp_3_bits_ctr[2] : _GEN_42;
  wire         _GEN_44 = _t_2_io_f3_resp_3_valid ? _t_2_io_f3_resp_3_bits_ctr[2] : _GEN_43;
  wire         _GEN_45 = _t_3_io_f3_resp_3_valid ? _t_3_io_f3_resp_3_bits_ctr[2] : _GEN_44;
  wire         _GEN_46 = _t_4_io_f3_resp_3_valid ? _t_4_io_f3_resp_3_bits_ctr[2] : _GEN_45;
  reg          t_io_f1_req_valid_REG;
  reg  [39:0]  t_io_f1_req_pc_REG;
  reg          t_io_f1_req_valid_REG_1;
  reg  [39:0]  t_io_f1_req_pc_REG_1;
  reg          t_io_f1_req_valid_REG_2;
  reg  [39:0]  t_io_f1_req_pc_REG_2;
  reg          t_io_f1_req_valid_REG_3;
  reg  [39:0]  t_io_f1_req_pc_REG_3;
  reg          t_io_f1_req_valid_REG_4;
  reg  [39:0]  t_io_f1_req_pc_REG_4;
  reg          t_io_f1_req_valid_REG_5;
  reg  [39:0]  t_io_f1_req_pc_REG_5;
  assign _io_resp_f3_0_taken_output = _t_5_io_f3_resp_0_valid ? (_t_5_io_f3_resp_0_bits_ctr == 3'h3 | _t_5_io_f3_resp_0_bits_ctr == 3'h4 ? _GEN_31 : _t_5_io_f3_resp_0_bits_ctr[2]) : _t_4_io_f3_resp_0_valid ? (_t_4_io_f3_resp_0_bits_ctr == 3'h3 | _t_4_io_f3_resp_0_bits_ctr == 3'h4 ? _GEN_30 : _t_4_io_f3_resp_0_bits_ctr[2]) : _t_3_io_f3_resp_0_valid ? (_t_3_io_f3_resp_0_bits_ctr == 3'h3 | _t_3_io_f3_resp_0_bits_ctr == 3'h4 ? _GEN_29 : _t_3_io_f3_resp_0_bits_ctr[2]) : _t_2_io_f3_resp_0_valid ? (_t_2_io_f3_resp_0_bits_ctr == 3'h3 | _t_2_io_f3_resp_0_bits_ctr == 3'h4 ? _GEN_28 : _t_2_io_f3_resp_0_bits_ctr[2]) : _t_1_io_f3_resp_0_valid ? (_t_1_io_f3_resp_0_bits_ctr == 3'h3 | _t_1_io_f3_resp_0_bits_ctr == 3'h4 ? _GEN_27 : _t_1_io_f3_resp_0_bits_ctr[2]) : ~_t_io_f3_resp_0_valid | _t_io_f3_resp_0_bits_ctr == 3'h3 | _t_io_f3_resp_0_bits_ctr == 3'h4 ? io_resp_in_0_f3_0_taken : _t_io_f3_resp_0_bits_ctr[2];
  assign _io_resp_f3_1_taken_output = _t_5_io_f3_resp_1_valid ? (_t_5_io_f3_resp_1_bits_ctr == 3'h3 | _t_5_io_f3_resp_1_bits_ctr == 3'h4 ? _GEN_41 : _t_5_io_f3_resp_1_bits_ctr[2]) : _t_4_io_f3_resp_1_valid ? (_t_4_io_f3_resp_1_bits_ctr == 3'h3 | _t_4_io_f3_resp_1_bits_ctr == 3'h4 ? _GEN_40 : _t_4_io_f3_resp_1_bits_ctr[2]) : _t_3_io_f3_resp_1_valid ? (_t_3_io_f3_resp_1_bits_ctr == 3'h3 | _t_3_io_f3_resp_1_bits_ctr == 3'h4 ? _GEN_39 : _t_3_io_f3_resp_1_bits_ctr[2]) : _t_2_io_f3_resp_1_valid ? (_t_2_io_f3_resp_1_bits_ctr == 3'h3 | _t_2_io_f3_resp_1_bits_ctr == 3'h4 ? _GEN_38 : _t_2_io_f3_resp_1_bits_ctr[2]) : _t_1_io_f3_resp_1_valid ? (_t_1_io_f3_resp_1_bits_ctr == 3'h3 | _t_1_io_f3_resp_1_bits_ctr == 3'h4 ? _GEN_37 : _t_1_io_f3_resp_1_bits_ctr[2]) : ~_t_io_f3_resp_1_valid | _t_io_f3_resp_1_bits_ctr == 3'h3 | _t_io_f3_resp_1_bits_ctr == 3'h4 ? io_resp_in_0_f3_1_taken : _t_io_f3_resp_1_bits_ctr[2];
  assign _io_resp_f3_2_taken_output = _t_5_io_f3_resp_2_valid ? (_t_5_io_f3_resp_2_bits_ctr == 3'h3 | _t_5_io_f3_resp_2_bits_ctr == 3'h4 ? _GEN_36 : _t_5_io_f3_resp_2_bits_ctr[2]) : _t_4_io_f3_resp_2_valid ? (_t_4_io_f3_resp_2_bits_ctr == 3'h3 | _t_4_io_f3_resp_2_bits_ctr == 3'h4 ? _GEN_35 : _t_4_io_f3_resp_2_bits_ctr[2]) : _t_3_io_f3_resp_2_valid ? (_t_3_io_f3_resp_2_bits_ctr == 3'h3 | _t_3_io_f3_resp_2_bits_ctr == 3'h4 ? _GEN_34 : _t_3_io_f3_resp_2_bits_ctr[2]) : _t_2_io_f3_resp_2_valid ? (_t_2_io_f3_resp_2_bits_ctr == 3'h3 | _t_2_io_f3_resp_2_bits_ctr == 3'h4 ? _GEN_33 : _t_2_io_f3_resp_2_bits_ctr[2]) : _t_1_io_f3_resp_2_valid ? (_t_1_io_f3_resp_2_bits_ctr == 3'h3 | _t_1_io_f3_resp_2_bits_ctr == 3'h4 ? _GEN_32 : _t_1_io_f3_resp_2_bits_ctr[2]) : ~_t_io_f3_resp_2_valid | _t_io_f3_resp_2_bits_ctr == 3'h3 | _t_io_f3_resp_2_bits_ctr == 3'h4 ? io_resp_in_0_f3_2_taken : _t_io_f3_resp_2_bits_ctr[2];
  assign _io_resp_f3_3_taken_output = _t_5_io_f3_resp_3_valid ? (_t_5_io_f3_resp_3_bits_ctr == 3'h3 | _t_5_io_f3_resp_3_bits_ctr == 3'h4 ? _GEN_46 : _t_5_io_f3_resp_3_bits_ctr[2]) : _t_4_io_f3_resp_3_valid ? (_t_4_io_f3_resp_3_bits_ctr == 3'h3 | _t_4_io_f3_resp_3_bits_ctr == 3'h4 ? _GEN_45 : _t_4_io_f3_resp_3_bits_ctr[2]) : _t_3_io_f3_resp_3_valid ? (_t_3_io_f3_resp_3_bits_ctr == 3'h3 | _t_3_io_f3_resp_3_bits_ctr == 3'h4 ? _GEN_44 : _t_3_io_f3_resp_3_bits_ctr[2]) : _t_2_io_f3_resp_3_valid ? (_t_2_io_f3_resp_3_bits_ctr == 3'h3 | _t_2_io_f3_resp_3_bits_ctr == 3'h4 ? _GEN_43 : _t_2_io_f3_resp_3_bits_ctr[2]) : _t_1_io_f3_resp_3_valid ? (_t_1_io_f3_resp_3_bits_ctr == 3'h3 | _t_1_io_f3_resp_3_bits_ctr == 3'h4 ? _GEN_42 : _t_1_io_f3_resp_3_bits_ctr[2]) : ~_t_io_f3_resp_3_valid | _t_io_f3_resp_3_bits_ctr == 3'h3 | _t_io_f3_resp_3_bits_ctr == 3'h4 ? io_resp_in_0_f3_3_taken : _t_io_f3_resp_3_bits_ctr[2];
  always @(*) begin
    casez (s1_update__bits_cfi_idx_bits)
      2'b00:
        casez_tmp_7 = s1_update__bits_meta[3];
      2'b01:
        casez_tmp_7 = s1_update__bits_meta[7];
      2'b10:
        casez_tmp_7 = s1_update__bits_meta[11];
      default:
        casez_tmp_7 = s1_update__bits_meta[15];
    endcase
  end // always @(*)
  always @(*) begin
    casez (s1_update__bits_cfi_idx_bits)
      2'b00:
        casez_tmp_8 = s1_update__bits_meta[2:0];
      2'b01:
        casez_tmp_8 = s1_update__bits_meta[6:4];
      2'b10:
        casez_tmp_8 = s1_update__bits_meta[10:8];
      default:
        casez_tmp_8 = s1_update__bits_meta[14:12];
    endcase
  end // always @(*)
  always @(*) begin
    casez (s1_update__bits_cfi_idx_bits)
      2'b00:
        casez_tmp_9 = s1_update__bits_meta[42:40];
      2'b01:
        casez_tmp_9 = s1_update__bits_meta[46:44];
      2'b10:
        casez_tmp_9 = s1_update__bits_meta[50:48];
      default:
        casez_tmp_9 = s1_update__bits_meta[54:52];
    endcase
  end // always @(*)
  always @(*) begin
    casez (s1_update__bits_cfi_idx_bits)
      2'b00:
        casez_tmp_10 = s1_update__bits_meta[43];
      2'b01:
        casez_tmp_10 = s1_update__bits_meta[47];
      2'b10:
        casez_tmp_10 = s1_update__bits_meta[51];
      default:
        casez_tmp_10 = s1_update__bits_meta[55];
    endcase
  end // always @(*)
  reg          t_io_update_mask_0_REG;
  reg          t_io_update_taken_0_REG;
  reg          t_io_update_alloc_0_REG;
  reg  [2:0]   t_io_update_old_ctr_0_REG;
  reg          t_io_update_u_mask_0_REG;
  reg  [1:0]   t_io_update_u_0_REG;
  reg          t_io_update_mask_1_REG;
  reg          t_io_update_taken_1_REG;
  reg          t_io_update_alloc_1_REG;
  reg  [2:0]   t_io_update_old_ctr_1_REG;
  reg          t_io_update_u_mask_1_REG;
  reg  [1:0]   t_io_update_u_1_REG;
  reg          t_io_update_mask_2_REG;
  reg          t_io_update_taken_2_REG;
  reg          t_io_update_alloc_2_REG;
  reg  [2:0]   t_io_update_old_ctr_2_REG;
  reg          t_io_update_u_mask_2_REG;
  reg  [1:0]   t_io_update_u_2_REG;
  reg          t_io_update_mask_3_REG;
  reg          t_io_update_taken_3_REG;
  reg          t_io_update_alloc_3_REG;
  reg  [2:0]   t_io_update_old_ctr_3_REG;
  reg          t_io_update_u_mask_3_REG;
  reg  [1:0]   t_io_update_u_3_REG;
  reg  [39:0]  t_io_update_pc_REG;
  reg  [63:0]  t_io_update_hist_REG;
  reg          t_io_update_mask_0_REG_1;
  reg          t_io_update_taken_0_REG_1;
  reg          t_io_update_alloc_0_REG_1;
  reg  [2:0]   t_io_update_old_ctr_0_REG_1;
  reg          t_io_update_u_mask_0_REG_1;
  reg  [1:0]   t_io_update_u_0_REG_1;
  reg          t_io_update_mask_1_REG_1;
  reg          t_io_update_taken_1_REG_1;
  reg          t_io_update_alloc_1_REG_1;
  reg  [2:0]   t_io_update_old_ctr_1_REG_1;
  reg          t_io_update_u_mask_1_REG_1;
  reg  [1:0]   t_io_update_u_1_REG_1;
  reg          t_io_update_mask_2_REG_1;
  reg          t_io_update_taken_2_REG_1;
  reg          t_io_update_alloc_2_REG_1;
  reg  [2:0]   t_io_update_old_ctr_2_REG_1;
  reg          t_io_update_u_mask_2_REG_1;
  reg  [1:0]   t_io_update_u_2_REG_1;
  reg          t_io_update_mask_3_REG_1;
  reg          t_io_update_taken_3_REG_1;
  reg          t_io_update_alloc_3_REG_1;
  reg  [2:0]   t_io_update_old_ctr_3_REG_1;
  reg          t_io_update_u_mask_3_REG_1;
  reg  [1:0]   t_io_update_u_3_REG_1;
  reg  [39:0]  t_io_update_pc_REG_1;
  reg  [63:0]  t_io_update_hist_REG_1;
  reg          t_io_update_mask_0_REG_2;
  reg          t_io_update_taken_0_REG_2;
  reg          t_io_update_alloc_0_REG_2;
  reg  [2:0]   t_io_update_old_ctr_0_REG_2;
  reg          t_io_update_u_mask_0_REG_2;
  reg  [1:0]   t_io_update_u_0_REG_2;
  reg          t_io_update_mask_1_REG_2;
  reg          t_io_update_taken_1_REG_2;
  reg          t_io_update_alloc_1_REG_2;
  reg  [2:0]   t_io_update_old_ctr_1_REG_2;
  reg          t_io_update_u_mask_1_REG_2;
  reg  [1:0]   t_io_update_u_1_REG_2;
  reg          t_io_update_mask_2_REG_2;
  reg          t_io_update_taken_2_REG_2;
  reg          t_io_update_alloc_2_REG_2;
  reg  [2:0]   t_io_update_old_ctr_2_REG_2;
  reg          t_io_update_u_mask_2_REG_2;
  reg  [1:0]   t_io_update_u_2_REG_2;
  reg          t_io_update_mask_3_REG_2;
  reg          t_io_update_taken_3_REG_2;
  reg          t_io_update_alloc_3_REG_2;
  reg  [2:0]   t_io_update_old_ctr_3_REG_2;
  reg          t_io_update_u_mask_3_REG_2;
  reg  [1:0]   t_io_update_u_3_REG_2;
  reg  [39:0]  t_io_update_pc_REG_2;
  reg  [63:0]  t_io_update_hist_REG_2;
  reg          t_io_update_mask_0_REG_3;
  reg          t_io_update_taken_0_REG_3;
  reg          t_io_update_alloc_0_REG_3;
  reg  [2:0]   t_io_update_old_ctr_0_REG_3;
  reg          t_io_update_u_mask_0_REG_3;
  reg  [1:0]   t_io_update_u_0_REG_3;
  reg          t_io_update_mask_1_REG_3;
  reg          t_io_update_taken_1_REG_3;
  reg          t_io_update_alloc_1_REG_3;
  reg  [2:0]   t_io_update_old_ctr_1_REG_3;
  reg          t_io_update_u_mask_1_REG_3;
  reg  [1:0]   t_io_update_u_1_REG_3;
  reg          t_io_update_mask_2_REG_3;
  reg          t_io_update_taken_2_REG_3;
  reg          t_io_update_alloc_2_REG_3;
  reg  [2:0]   t_io_update_old_ctr_2_REG_3;
  reg          t_io_update_u_mask_2_REG_3;
  reg  [1:0]   t_io_update_u_2_REG_3;
  reg          t_io_update_mask_3_REG_3;
  reg          t_io_update_taken_3_REG_3;
  reg          t_io_update_alloc_3_REG_3;
  reg  [2:0]   t_io_update_old_ctr_3_REG_3;
  reg          t_io_update_u_mask_3_REG_3;
  reg  [1:0]   t_io_update_u_3_REG_3;
  reg  [39:0]  t_io_update_pc_REG_3;
  reg  [63:0]  t_io_update_hist_REG_3;
  reg          t_io_update_mask_0_REG_4;
  reg          t_io_update_taken_0_REG_4;
  reg          t_io_update_alloc_0_REG_4;
  reg  [2:0]   t_io_update_old_ctr_0_REG_4;
  reg          t_io_update_u_mask_0_REG_4;
  reg  [1:0]   t_io_update_u_0_REG_4;
  reg          t_io_update_mask_1_REG_4;
  reg          t_io_update_taken_1_REG_4;
  reg          t_io_update_alloc_1_REG_4;
  reg  [2:0]   t_io_update_old_ctr_1_REG_4;
  reg          t_io_update_u_mask_1_REG_4;
  reg  [1:0]   t_io_update_u_1_REG_4;
  reg          t_io_update_mask_2_REG_4;
  reg          t_io_update_taken_2_REG_4;
  reg          t_io_update_alloc_2_REG_4;
  reg  [2:0]   t_io_update_old_ctr_2_REG_4;
  reg          t_io_update_u_mask_2_REG_4;
  reg  [1:0]   t_io_update_u_2_REG_4;
  reg          t_io_update_mask_3_REG_4;
  reg          t_io_update_taken_3_REG_4;
  reg          t_io_update_alloc_3_REG_4;
  reg  [2:0]   t_io_update_old_ctr_3_REG_4;
  reg          t_io_update_u_mask_3_REG_4;
  reg  [1:0]   t_io_update_u_3_REG_4;
  reg  [39:0]  t_io_update_pc_REG_4;
  reg  [63:0]  t_io_update_hist_REG_4;
  reg          t_io_update_mask_0_REG_5;
  reg          t_io_update_taken_0_REG_5;
  reg          t_io_update_alloc_0_REG_5;
  reg  [2:0]   t_io_update_old_ctr_0_REG_5;
  reg          t_io_update_u_mask_0_REG_5;
  reg  [1:0]   t_io_update_u_0_REG_5;
  reg          t_io_update_mask_1_REG_5;
  reg          t_io_update_taken_1_REG_5;
  reg          t_io_update_alloc_1_REG_5;
  reg  [2:0]   t_io_update_old_ctr_1_REG_5;
  reg          t_io_update_u_mask_1_REG_5;
  reg  [1:0]   t_io_update_u_1_REG_5;
  reg          t_io_update_mask_2_REG_5;
  reg          t_io_update_taken_2_REG_5;
  reg          t_io_update_alloc_2_REG_5;
  reg  [2:0]   t_io_update_old_ctr_2_REG_5;
  reg          t_io_update_u_mask_2_REG_5;
  reg  [1:0]   t_io_update_u_2_REG_5;
  reg          t_io_update_mask_3_REG_5;
  reg          t_io_update_taken_3_REG_5;
  reg          t_io_update_alloc_3_REG_5;
  reg  [2:0]   t_io_update_old_ctr_3_REG_5;
  reg          t_io_update_u_mask_3_REG_5;
  reg  [1:0]   t_io_update_u_3_REG_5;
  reg  [39:0]  t_io_update_pc_REG_5;
  reg  [63:0]  t_io_update_hist_REG_5;
  wire         _GEN_47 = s1_update__bits_is_mispredict_update | s1_update__bits_is_repair_update | (|s1_update__bits_btb_mispredicts);
  wire         _GEN_30_0 = s1_update__bits_meta[42:40] == 3'h0;
  wire         _GEN_31_0 = s1_update__bits_meta[42:40] == 3'h1;
  wire         _GEN_32_0 = s1_update__bits_meta[42:40] == 3'h2;
  wire         _GEN_33_0 = s1_update__bits_meta[42:40] == 3'h3;
  wire         _GEN_34_0 = s1_update__bits_meta[42:40] == 3'h4;
  wire         _GEN_35_0 = s1_update__bits_meta[42:40] == 3'h5;
  wire         _new_u_T = s1_update__bits_cfi_idx_bits == 2'h0 & s1_update__bits_cfi_mispredicted;
  wire         _new_u_T_2 = s1_update__bits_meta[29:28] == 2'h0;
  wire [1:0]   _new_u_T_3 = s1_update__bits_meta[29:28] - 2'h1;
  wire [1:0]   _new_u_T_7 = s1_update__bits_meta[29:28] + 2'h1;
  wire         _GEN_48 = s1_update__bits_br_mask[0] & s1_update__valid & ~_GEN_47 & s1_update__bits_meta[43];
  wire         _GEN_102 = _GEN_48 & _GEN_30_0;
  wire         _GEN_103 = _GEN_48 & _GEN_31_0;
  wire         _GEN_104 = _GEN_48 & _GEN_32_0;
  wire         _GEN_105 = _GEN_48 & _GEN_33_0;
  wire         _GEN_106 = _GEN_48 & _GEN_34_0;
  wire         _GEN_107 = _GEN_48 & _GEN_35_0;
  wire         _GEN_162 = s1_update__bits_meta[46:44] == 3'h0;
  wire         _GEN_163 = s1_update__bits_meta[46:44] == 3'h1;
  wire         _GEN_164 = s1_update__bits_meta[46:44] == 3'h2;
  wire         _GEN_165 = s1_update__bits_meta[46:44] == 3'h3;
  wire         _GEN_166 = s1_update__bits_meta[46:44] == 3'h4;
  wire         _GEN_167 = s1_update__bits_meta[46:44] == 3'h5;
  wire         _new_u_T_11 = s1_update__bits_cfi_idx_bits == 2'h1 & s1_update__bits_cfi_mispredicted;
  wire         _new_u_T_13 = s1_update__bits_meta[31:30] == 2'h0;
  wire [1:0]   _new_u_T_14 = s1_update__bits_meta[31:30] - 2'h1;
  wire [1:0]   _new_u_T_18 = s1_update__bits_meta[31:30] + 2'h1;
  wire         _GEN_49 = s1_update__bits_br_mask[1] & s1_update__valid & ~_GEN_47 & s1_update__bits_meta[47];
  wire         _GEN_234 = _GEN_49 & _GEN_162;
  wire         _GEN_235 = _GEN_49 & _GEN_163;
  wire         _GEN_236 = _GEN_49 & _GEN_164;
  wire         _GEN_237 = _GEN_49 & _GEN_165;
  wire         _GEN_238 = _GEN_49 & _GEN_166;
  wire         _GEN_239 = _GEN_49 & _GEN_167;
  wire         _GEN_294 = s1_update__bits_meta[50:48] == 3'h0;
  wire         _GEN_295 = s1_update__bits_meta[50:48] == 3'h1;
  wire         _GEN_296 = s1_update__bits_meta[50:48] == 3'h2;
  wire         _GEN_297 = s1_update__bits_meta[50:48] == 3'h3;
  wire         _GEN_298 = s1_update__bits_meta[50:48] == 3'h4;
  wire         _GEN_299 = s1_update__bits_meta[50:48] == 3'h5;
  wire         _new_u_T_22 = s1_update__bits_cfi_idx_bits == 2'h2 & s1_update__bits_cfi_mispredicted;
  wire         _new_u_T_24 = s1_update__bits_meta[33:32] == 2'h0;
  wire [1:0]   _new_u_T_25 = s1_update__bits_meta[33:32] - 2'h1;
  wire [1:0]   _new_u_T_29 = s1_update__bits_meta[33:32] + 2'h1;
  wire         _GEN_50 = s1_update__bits_br_mask[2] & s1_update__valid & ~_GEN_47 & s1_update__bits_meta[51];
  wire         _GEN_366 = _GEN_50 & _GEN_294;
  wire         _GEN_367 = _GEN_50 & _GEN_295;
  wire         _GEN_368 = _GEN_50 & _GEN_296;
  wire         _GEN_369 = _GEN_50 & _GEN_297;
  wire         _GEN_370 = _GEN_50 & _GEN_298;
  wire         _GEN_371 = _GEN_50 & _GEN_299;
  wire         _GEN_426 = s1_update__bits_meta[54:52] == 3'h0;
  wire         _GEN_427 = s1_update__bits_meta[54:52] == 3'h1;
  wire         _GEN_428 = s1_update__bits_meta[54:52] == 3'h2;
  wire         _GEN_429 = s1_update__bits_meta[54:52] == 3'h3;
  wire         _GEN_430 = s1_update__bits_meta[54:52] == 3'h4;
  wire         _GEN_431 = s1_update__bits_meta[54:52] == 3'h5;
  wire         _new_u_T_33 = (&s1_update__bits_cfi_idx_bits) & s1_update__bits_cfi_mispredicted;
  wire         _new_u_T_35 = s1_update__bits_meta[35:34] == 2'h0;
  wire [1:0]   _new_u_T_36 = s1_update__bits_meta[35:34] - 2'h1;
  wire [1:0]   _new_u_T_40 = s1_update__bits_meta[35:34] + 2'h1;
  wire         _GEN_51 = s1_update__bits_br_mask[3] & s1_update__valid & ~_GEN_47 & s1_update__bits_meta[55];
  wire         _GEN_498 = _GEN_51 & _GEN_426;
  wire         _GEN_499 = _GEN_51 & _GEN_427;
  wire         _GEN_500 = _GEN_51 & _GEN_428;
  wire         _GEN_501 = _GEN_51 & _GEN_429;
  wire         _GEN_502 = _GEN_51 & _GEN_430;
  wire         _GEN_503 = _GEN_51 & _GEN_431;
  wire         _GEN_52 = s1_update__valid & ~_GEN_47 & s1_update__bits_cfi_mispredicted & s1_update__bits_cfi_idx_valid;
  wire         _GEN_53 = s1_update__bits_cfi_idx_bits == 2'h1;
  wire         _GEN_54 = s1_update__bits_cfi_idx_bits == 2'h2;
  wire         _GEN_55 = casez_tmp_8 == 3'h0;
  wire         _GEN_56 = _GEN_55 & ~(|s1_update__bits_cfi_idx_bits);
  wire         _GEN_57 = _GEN_55 & _GEN_53;
  wire         _GEN_58 = _GEN_55 & _GEN_54;
  wire         _GEN_59 = _GEN_55 & (&s1_update__bits_cfi_idx_bits);
  wire         _GEN_60 = casez_tmp_8 == 3'h1;
  wire         _GEN_61 = _GEN_60 & ~(|s1_update__bits_cfi_idx_bits);
  wire         _GEN_62 = _GEN_60 & _GEN_53;
  wire         _GEN_63 = _GEN_60 & _GEN_54;
  wire         _GEN_64 = _GEN_60 & (&s1_update__bits_cfi_idx_bits);
  wire         _GEN_65 = casez_tmp_8 == 3'h2;
  wire         _GEN_66 = _GEN_65 & ~(|s1_update__bits_cfi_idx_bits);
  wire         _GEN_67 = _GEN_65 & _GEN_53;
  wire         _GEN_68 = _GEN_65 & _GEN_54;
  wire         _GEN_69 = _GEN_65 & (&s1_update__bits_cfi_idx_bits);
  wire         _GEN_70 = casez_tmp_8 == 3'h3;
  wire         _GEN_71 = _GEN_70 & ~(|s1_update__bits_cfi_idx_bits);
  wire         _GEN_72 = _GEN_70 & _GEN_53;
  wire         _GEN_73 = _GEN_70 & _GEN_54;
  wire         _GEN_74 = _GEN_70 & (&s1_update__bits_cfi_idx_bits);
  wire         _GEN_75 = casez_tmp_8 == 3'h4;
  wire         _GEN_76 = _GEN_75 & ~(|s1_update__bits_cfi_idx_bits);
  wire         _GEN_77 = _GEN_75 & _GEN_53;
  wire         _GEN_78 = _GEN_75 & _GEN_54;
  wire         _GEN_79 = _GEN_75 & (&s1_update__bits_cfi_idx_bits);
  wire         _GEN_80 = casez_tmp_8 == 3'h5;
  wire         _GEN_81 = _GEN_80 & ~(|s1_update__bits_cfi_idx_bits);
  wire         _GEN_82 = _GEN_80 & _GEN_53;
  wire         _GEN_83 = _GEN_80 & _GEN_54;
  wire         _GEN_84 = _GEN_80 & (&s1_update__bits_cfi_idx_bits);
  wire [7:0]   _decr_mask_T_1 = 8'h1 << casez_tmp_9;
  wire [5:0]   _GEN_85 = _decr_mask_T_1[5:0] | _decr_mask_T_1[6:1] | _decr_mask_T_1[7:2];
  wire [4:0]   _GEN_86 = _GEN_85[4:0] | _decr_mask_T_1[7:3];
  wire [3:0]   _GEN_87 = _GEN_86[3:0] | _decr_mask_T_1[7:4];
  wire [2:0]   _GEN_88 = _GEN_87[2:0] | _decr_mask_T_1[7:5];
  wire [1:0]   _GEN_89 = _GEN_88[1:0] | _decr_mask_T_1[7:6];
  wire [5:0]   decr_mask = casez_tmp_10 ? ~{_GEN_85[5], _GEN_86[4], _GEN_87[3], _GEN_88[2], _GEN_89[1], _GEN_89[0] | (&casez_tmp_9)} : 6'h0;
  wire         _GEN_90 = decr_mask[0] & ~(|s1_update__bits_cfi_idx_bits);
  wire         _GEN_91 = decr_mask[0] & _GEN_53;
  wire         _GEN_92 = decr_mask[0] & _GEN_54;
  wire         _GEN_93 = decr_mask[0] & (&s1_update__bits_cfi_idx_bits);
  wire         _GEN_94 = decr_mask[1] & ~(|s1_update__bits_cfi_idx_bits);
  wire         _GEN_95 = decr_mask[1] & _GEN_53;
  wire         _GEN_96 = decr_mask[1] & _GEN_54;
  wire         _GEN_97 = decr_mask[1] & (&s1_update__bits_cfi_idx_bits);
  wire         _GEN_98 = decr_mask[2] & ~(|s1_update__bits_cfi_idx_bits);
  wire         _GEN_99 = decr_mask[2] & _GEN_53;
  wire         _GEN_100 = decr_mask[2] & _GEN_54;
  wire         _GEN_101 = decr_mask[2] & (&s1_update__bits_cfi_idx_bits);
  wire         _GEN_108 = decr_mask[3] & ~(|s1_update__bits_cfi_idx_bits);
  wire         _GEN_109 = decr_mask[3] & _GEN_53;
  wire         _GEN_110 = decr_mask[3] & _GEN_54;
  wire         _GEN_111 = decr_mask[3] & (&s1_update__bits_cfi_idx_bits);
  wire         _GEN_112 = decr_mask[4] & ~(|s1_update__bits_cfi_idx_bits);
  wire         _GEN_113 = decr_mask[4] & _GEN_53;
  wire         _GEN_114 = decr_mask[4] & _GEN_54;
  wire         _GEN_115 = decr_mask[4] & (&s1_update__bits_cfi_idx_bits);
  wire         _GEN_116 = decr_mask[5] & ~(|s1_update__bits_cfi_idx_bits);
  wire         _GEN_117 = decr_mask[5] & _GEN_53;
  wire         _GEN_118 = decr_mask[5] & _GEN_54;
  wire         _GEN_119 = decr_mask[5] & (&s1_update__bits_cfi_idx_bits);
  wire         _GEN_120 = _GEN_52 & casez_tmp_7 & _GEN_56;
  wire         _GEN_121 = _GEN_52 & casez_tmp_7 & _GEN_57;
  wire         _GEN_122 = _GEN_52 & casez_tmp_7 & _GEN_58;
  wire         _GEN_123 = _GEN_52 & casez_tmp_7 & _GEN_59;
  wire         _GEN_124 = _GEN_52 & casez_tmp_7 & _GEN_61;
  wire         _GEN_125 = _GEN_52 & casez_tmp_7 & _GEN_62;
  wire         _GEN_126 = _GEN_52 & casez_tmp_7 & _GEN_63;
  wire         _GEN_127 = _GEN_52 & casez_tmp_7 & _GEN_64;
  wire         _GEN_128 = _GEN_52 & casez_tmp_7 & _GEN_66;
  wire         _GEN_129 = _GEN_52 & casez_tmp_7 & _GEN_67;
  wire         _GEN_130 = _GEN_52 & casez_tmp_7 & _GEN_68;
  wire         _GEN_131 = _GEN_52 & casez_tmp_7 & _GEN_69;
  wire         _GEN_132 = _GEN_52 & casez_tmp_7 & _GEN_71;
  wire         _GEN_133 = _GEN_52 & casez_tmp_7 & _GEN_72;
  wire         _GEN_134 = _GEN_52 & casez_tmp_7 & _GEN_73;
  wire         _GEN_135 = _GEN_52 & casez_tmp_7 & _GEN_74;
  wire         _GEN_136 = _GEN_52 & casez_tmp_7 & _GEN_76;
  wire         _GEN_137 = _GEN_52 & casez_tmp_7 & _GEN_77;
  wire         _GEN_138 = _GEN_52 & casez_tmp_7 & _GEN_78;
  wire         _GEN_139 = _GEN_52 & casez_tmp_7 & _GEN_79;
  wire         _GEN_140 = _GEN_52 & casez_tmp_7 & _GEN_81;
  wire         _GEN_141 = _GEN_52 & casez_tmp_7 & _GEN_82;
  wire         _GEN_142 = _GEN_52 & casez_tmp_7 & _GEN_83;
  wire         _GEN_143 = _GEN_52 & casez_tmp_7 & _GEN_84;
  wire         _GEN_144 = s1_update__bits_cfi_idx_valid & ~(|s1_update__bits_cfi_idx_bits);
  wire         _GEN_145 = s1_update__bits_cfi_idx_valid & s1_update__bits_cfi_idx_bits == 2'h1;
  wire         _GEN_146 = s1_update__bits_cfi_idx_valid & s1_update__bits_cfi_idx_bits == 2'h2;
  wire         _GEN_147 = s1_update__bits_cfi_idx_valid & (&s1_update__bits_cfi_idx_bits);
  wire         _GEN_148 = _GEN_52 & casez_tmp_7;
  always @(posedge clock) begin
    s1_update__valid <= io_update_valid;
    s1_update__bits_is_mispredict_update <= io_update_bits_is_mispredict_update;
    s1_update__bits_is_repair_update <= io_update_bits_is_repair_update;
    s1_update__bits_btb_mispredicts <= io_update_bits_btb_mispredicts;
    s1_update__bits_pc <= io_update_bits_pc;
    s1_update__bits_br_mask <= io_update_bits_br_mask;
    s1_update__bits_cfi_idx_valid <= io_update_bits_cfi_idx_valid;
    s1_update__bits_cfi_idx_bits <= io_update_bits_cfi_idx_bits;
    s1_update__bits_cfi_taken <= io_update_bits_cfi_taken;
    s1_update__bits_cfi_mispredicted <= io_update_bits_cfi_mispredicted;
    s1_update__bits_ghist <= io_update_bits_ghist;
    s1_update__bits_meta <= io_update_bits_meta;
    t_io_f1_req_valid_REG <= io_f0_valid;
    t_io_f1_req_pc_REG <= io_f0_pc;
    t_io_f1_req_valid_REG_1 <= io_f0_valid;
    t_io_f1_req_pc_REG_1 <= io_f0_pc;
    t_io_f1_req_valid_REG_2 <= io_f0_valid;
    t_io_f1_req_pc_REG_2 <= io_f0_pc;
    t_io_f1_req_valid_REG_3 <= io_f0_valid;
    t_io_f1_req_pc_REG_3 <= io_f0_pc;
    t_io_f1_req_valid_REG_4 <= io_f0_valid;
    t_io_f1_req_pc_REG_4 <= io_f0_pc;
    t_io_f1_req_valid_REG_5 <= io_f0_valid;
    t_io_f1_req_pc_REG_5 <= io_f0_pc;
    t_io_update_mask_0_REG <= _GEN_120 | _GEN_48 & _GEN_30_0;
    t_io_update_taken_0_REG <= (_GEN_120 | _GEN_144) & s1_update__bits_cfi_taken;
    t_io_update_alloc_0_REG <= _GEN_148 & _GEN_55 & ~(|s1_update__bits_cfi_idx_bits);
    t_io_update_old_ctr_0_REG <= s1_update__bits_meta[18:16];
    if (_GEN_52) begin
      if (casez_tmp_7) begin
        t_io_update_u_mask_0_REG <= _GEN_56 | _GEN_102;
        t_io_update_u_mask_1_REG <= _GEN_57 | _GEN_234;
        t_io_update_u_mask_2_REG <= _GEN_58 | _GEN_366;
        t_io_update_u_mask_3_REG <= _GEN_59 | _GEN_498;
        t_io_update_u_mask_0_REG_1 <= _GEN_61 | _GEN_103;
        t_io_update_u_mask_1_REG_1 <= _GEN_62 | _GEN_235;
        t_io_update_u_mask_2_REG_1 <= _GEN_63 | _GEN_367;
        t_io_update_u_mask_3_REG_1 <= _GEN_64 | _GEN_499;
        t_io_update_u_mask_0_REG_2 <= _GEN_66 | _GEN_104;
        t_io_update_u_mask_1_REG_2 <= _GEN_67 | _GEN_236;
        t_io_update_u_mask_2_REG_2 <= _GEN_68 | _GEN_368;
        t_io_update_u_mask_3_REG_2 <= _GEN_69 | _GEN_500;
        t_io_update_u_mask_0_REG_3 <= _GEN_71 | _GEN_105;
        t_io_update_u_mask_1_REG_3 <= _GEN_72 | _GEN_237;
        t_io_update_u_mask_2_REG_3 <= _GEN_73 | _GEN_369;
        t_io_update_u_mask_3_REG_3 <= _GEN_74 | _GEN_501;
        t_io_update_u_mask_0_REG_4 <= _GEN_76 | _GEN_106;
        t_io_update_u_mask_1_REG_4 <= _GEN_77 | _GEN_238;
        t_io_update_u_mask_2_REG_4 <= _GEN_78 | _GEN_370;
        t_io_update_u_mask_3_REG_4 <= _GEN_79 | _GEN_502;
        t_io_update_u_mask_0_REG_5 <= _GEN_81 | _GEN_107;
        t_io_update_u_mask_1_REG_5 <= _GEN_82 | _GEN_239;
        t_io_update_u_mask_2_REG_5 <= _GEN_83 | _GEN_371;
        t_io_update_u_mask_3_REG_5 <= _GEN_84 | _GEN_503;
      end
      else begin
        t_io_update_u_mask_0_REG <= _GEN_90 | _GEN_102;
        t_io_update_u_mask_1_REG <= _GEN_91 | _GEN_234;
        t_io_update_u_mask_2_REG <= _GEN_92 | _GEN_366;
        t_io_update_u_mask_3_REG <= _GEN_93 | _GEN_498;
        t_io_update_u_mask_0_REG_1 <= _GEN_94 | _GEN_103;
        t_io_update_u_mask_1_REG_1 <= _GEN_95 | _GEN_235;
        t_io_update_u_mask_2_REG_1 <= _GEN_96 | _GEN_367;
        t_io_update_u_mask_3_REG_1 <= _GEN_97 | _GEN_499;
        t_io_update_u_mask_0_REG_2 <= _GEN_98 | _GEN_104;
        t_io_update_u_mask_1_REG_2 <= _GEN_99 | _GEN_236;
        t_io_update_u_mask_2_REG_2 <= _GEN_100 | _GEN_368;
        t_io_update_u_mask_3_REG_2 <= _GEN_101 | _GEN_500;
        t_io_update_u_mask_0_REG_3 <= _GEN_108 | _GEN_105;
        t_io_update_u_mask_1_REG_3 <= _GEN_109 | _GEN_237;
        t_io_update_u_mask_2_REG_3 <= _GEN_110 | _GEN_369;
        t_io_update_u_mask_3_REG_3 <= _GEN_111 | _GEN_501;
        t_io_update_u_mask_0_REG_4 <= _GEN_112 | _GEN_106;
        t_io_update_u_mask_1_REG_4 <= _GEN_113 | _GEN_238;
        t_io_update_u_mask_2_REG_4 <= _GEN_114 | _GEN_370;
        t_io_update_u_mask_3_REG_4 <= _GEN_115 | _GEN_502;
        t_io_update_u_mask_0_REG_5 <= _GEN_116 | _GEN_107;
        t_io_update_u_mask_1_REG_5 <= _GEN_117 | _GEN_239;
        t_io_update_u_mask_2_REG_5 <= _GEN_118 | _GEN_371;
        t_io_update_u_mask_3_REG_5 <= _GEN_119 | _GEN_503;
      end
    end
    else begin
      t_io_update_u_mask_0_REG <= _GEN_102;
      t_io_update_u_mask_1_REG <= _GEN_234;
      t_io_update_u_mask_2_REG <= _GEN_366;
      t_io_update_u_mask_3_REG <= _GEN_498;
      t_io_update_u_mask_0_REG_1 <= _GEN_103;
      t_io_update_u_mask_1_REG_1 <= _GEN_235;
      t_io_update_u_mask_2_REG_1 <= _GEN_367;
      t_io_update_u_mask_3_REG_1 <= _GEN_499;
      t_io_update_u_mask_0_REG_2 <= _GEN_104;
      t_io_update_u_mask_1_REG_2 <= _GEN_236;
      t_io_update_u_mask_2_REG_2 <= _GEN_368;
      t_io_update_u_mask_3_REG_2 <= _GEN_500;
      t_io_update_u_mask_0_REG_3 <= _GEN_105;
      t_io_update_u_mask_1_REG_3 <= _GEN_237;
      t_io_update_u_mask_2_REG_3 <= _GEN_369;
      t_io_update_u_mask_3_REG_3 <= _GEN_501;
      t_io_update_u_mask_0_REG_4 <= _GEN_106;
      t_io_update_u_mask_1_REG_4 <= _GEN_238;
      t_io_update_u_mask_2_REG_4 <= _GEN_370;
      t_io_update_u_mask_3_REG_4 <= _GEN_502;
      t_io_update_u_mask_0_REG_5 <= _GEN_107;
      t_io_update_u_mask_1_REG_5 <= _GEN_239;
      t_io_update_u_mask_2_REG_5 <= _GEN_371;
      t_io_update_u_mask_3_REG_5 <= _GEN_503;
    end
    if (_GEN_52 & (casez_tmp_7 ? _GEN_56 : _GEN_90))
      t_io_update_u_0_REG <= 2'h0;
    else if (s1_update__bits_meta[36]) begin
      if (_new_u_T) begin
        if (_new_u_T_2)
          t_io_update_u_0_REG <= 2'h0;
        else
          t_io_update_u_0_REG <= _new_u_T_3;
      end
      else if (&(s1_update__bits_meta[29:28]))
        t_io_update_u_0_REG <= 2'h3;
      else
        t_io_update_u_0_REG <= _new_u_T_7;
    end
    else
      t_io_update_u_0_REG <= s1_update__bits_meta[29:28];
    t_io_update_mask_1_REG <= _GEN_121 | _GEN_49 & _GEN_162;
    t_io_update_taken_1_REG <= (_GEN_121 | _GEN_145) & s1_update__bits_cfi_taken;
    t_io_update_alloc_1_REG <= _GEN_148 & _GEN_55 & _GEN_53;
    t_io_update_old_ctr_1_REG <= s1_update__bits_meta[21:19];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_57 : _GEN_91))
      t_io_update_u_1_REG <= 2'h0;
    else if (s1_update__bits_meta[37]) begin
      if (_new_u_T_11) begin
        if (_new_u_T_13)
          t_io_update_u_1_REG <= 2'h0;
        else
          t_io_update_u_1_REG <= _new_u_T_14;
      end
      else if (&(s1_update__bits_meta[31:30]))
        t_io_update_u_1_REG <= 2'h3;
      else
        t_io_update_u_1_REG <= _new_u_T_18;
    end
    else
      t_io_update_u_1_REG <= s1_update__bits_meta[31:30];
    t_io_update_mask_2_REG <= _GEN_122 | _GEN_50 & _GEN_294;
    t_io_update_taken_2_REG <= (_GEN_122 | _GEN_146) & s1_update__bits_cfi_taken;
    t_io_update_alloc_2_REG <= _GEN_148 & _GEN_55 & _GEN_54;
    t_io_update_old_ctr_2_REG <= s1_update__bits_meta[24:22];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_58 : _GEN_92))
      t_io_update_u_2_REG <= 2'h0;
    else if (s1_update__bits_meta[38]) begin
      if (_new_u_T_22) begin
        if (_new_u_T_24)
          t_io_update_u_2_REG <= 2'h0;
        else
          t_io_update_u_2_REG <= _new_u_T_25;
      end
      else if (&(s1_update__bits_meta[33:32]))
        t_io_update_u_2_REG <= 2'h3;
      else
        t_io_update_u_2_REG <= _new_u_T_29;
    end
    else
      t_io_update_u_2_REG <= s1_update__bits_meta[33:32];
    t_io_update_mask_3_REG <= _GEN_123 | _GEN_51 & _GEN_426;
    t_io_update_taken_3_REG <= (_GEN_123 | _GEN_147) & s1_update__bits_cfi_taken;
    t_io_update_alloc_3_REG <= _GEN_148 & _GEN_55 & (&s1_update__bits_cfi_idx_bits);
    t_io_update_old_ctr_3_REG <= s1_update__bits_meta[27:25];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_59 : _GEN_93))
      t_io_update_u_3_REG <= 2'h0;
    else if (s1_update__bits_meta[39]) begin
      if (_new_u_T_33) begin
        if (_new_u_T_35)
          t_io_update_u_3_REG <= 2'h0;
        else
          t_io_update_u_3_REG <= _new_u_T_36;
      end
      else if (&(s1_update__bits_meta[35:34]))
        t_io_update_u_3_REG <= 2'h3;
      else
        t_io_update_u_3_REG <= _new_u_T_40;
    end
    else
      t_io_update_u_3_REG <= s1_update__bits_meta[35:34];
    t_io_update_pc_REG <= s1_update__bits_pc;
    t_io_update_hist_REG <= s1_update__bits_ghist;
    t_io_update_mask_0_REG_1 <= _GEN_124 | _GEN_48 & _GEN_31_0;
    t_io_update_taken_0_REG_1 <= (_GEN_124 | _GEN_144) & s1_update__bits_cfi_taken;
    t_io_update_alloc_0_REG_1 <= _GEN_148 & _GEN_60 & ~(|s1_update__bits_cfi_idx_bits);
    t_io_update_old_ctr_0_REG_1 <= s1_update__bits_meta[18:16];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_61 : _GEN_94))
      t_io_update_u_0_REG_1 <= 2'h0;
    else if (s1_update__bits_meta[36]) begin
      if (_new_u_T) begin
        if (_new_u_T_2)
          t_io_update_u_0_REG_1 <= 2'h0;
        else
          t_io_update_u_0_REG_1 <= _new_u_T_3;
      end
      else if (&(s1_update__bits_meta[29:28]))
        t_io_update_u_0_REG_1 <= 2'h3;
      else
        t_io_update_u_0_REG_1 <= _new_u_T_7;
    end
    else
      t_io_update_u_0_REG_1 <= s1_update__bits_meta[29:28];
    t_io_update_mask_1_REG_1 <= _GEN_125 | _GEN_49 & _GEN_163;
    t_io_update_taken_1_REG_1 <= (_GEN_125 | _GEN_145) & s1_update__bits_cfi_taken;
    t_io_update_alloc_1_REG_1 <= _GEN_148 & _GEN_60 & _GEN_53;
    t_io_update_old_ctr_1_REG_1 <= s1_update__bits_meta[21:19];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_62 : _GEN_95))
      t_io_update_u_1_REG_1 <= 2'h0;
    else if (s1_update__bits_meta[37]) begin
      if (_new_u_T_11) begin
        if (_new_u_T_13)
          t_io_update_u_1_REG_1 <= 2'h0;
        else
          t_io_update_u_1_REG_1 <= _new_u_T_14;
      end
      else if (&(s1_update__bits_meta[31:30]))
        t_io_update_u_1_REG_1 <= 2'h3;
      else
        t_io_update_u_1_REG_1 <= _new_u_T_18;
    end
    else
      t_io_update_u_1_REG_1 <= s1_update__bits_meta[31:30];
    t_io_update_mask_2_REG_1 <= _GEN_126 | _GEN_50 & _GEN_295;
    t_io_update_taken_2_REG_1 <= (_GEN_126 | _GEN_146) & s1_update__bits_cfi_taken;
    t_io_update_alloc_2_REG_1 <= _GEN_148 & _GEN_60 & _GEN_54;
    t_io_update_old_ctr_2_REG_1 <= s1_update__bits_meta[24:22];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_63 : _GEN_96))
      t_io_update_u_2_REG_1 <= 2'h0;
    else if (s1_update__bits_meta[38]) begin
      if (_new_u_T_22) begin
        if (_new_u_T_24)
          t_io_update_u_2_REG_1 <= 2'h0;
        else
          t_io_update_u_2_REG_1 <= _new_u_T_25;
      end
      else if (&(s1_update__bits_meta[33:32]))
        t_io_update_u_2_REG_1 <= 2'h3;
      else
        t_io_update_u_2_REG_1 <= _new_u_T_29;
    end
    else
      t_io_update_u_2_REG_1 <= s1_update__bits_meta[33:32];
    t_io_update_mask_3_REG_1 <= _GEN_127 | _GEN_51 & _GEN_427;
    t_io_update_taken_3_REG_1 <= (_GEN_127 | _GEN_147) & s1_update__bits_cfi_taken;
    t_io_update_alloc_3_REG_1 <= _GEN_148 & _GEN_60 & (&s1_update__bits_cfi_idx_bits);
    t_io_update_old_ctr_3_REG_1 <= s1_update__bits_meta[27:25];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_64 : _GEN_97))
      t_io_update_u_3_REG_1 <= 2'h0;
    else if (s1_update__bits_meta[39]) begin
      if (_new_u_T_33) begin
        if (_new_u_T_35)
          t_io_update_u_3_REG_1 <= 2'h0;
        else
          t_io_update_u_3_REG_1 <= _new_u_T_36;
      end
      else if (&(s1_update__bits_meta[35:34]))
        t_io_update_u_3_REG_1 <= 2'h3;
      else
        t_io_update_u_3_REG_1 <= _new_u_T_40;
    end
    else
      t_io_update_u_3_REG_1 <= s1_update__bits_meta[35:34];
    t_io_update_pc_REG_1 <= s1_update__bits_pc;
    t_io_update_hist_REG_1 <= s1_update__bits_ghist;
    t_io_update_mask_0_REG_2 <= _GEN_128 | _GEN_48 & _GEN_32_0;
    t_io_update_taken_0_REG_2 <= (_GEN_128 | _GEN_144) & s1_update__bits_cfi_taken;
    t_io_update_alloc_0_REG_2 <= _GEN_148 & _GEN_65 & ~(|s1_update__bits_cfi_idx_bits);
    t_io_update_old_ctr_0_REG_2 <= s1_update__bits_meta[18:16];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_66 : _GEN_98))
      t_io_update_u_0_REG_2 <= 2'h0;
    else if (s1_update__bits_meta[36]) begin
      if (_new_u_T) begin
        if (_new_u_T_2)
          t_io_update_u_0_REG_2 <= 2'h0;
        else
          t_io_update_u_0_REG_2 <= _new_u_T_3;
      end
      else if (&(s1_update__bits_meta[29:28]))
        t_io_update_u_0_REG_2 <= 2'h3;
      else
        t_io_update_u_0_REG_2 <= _new_u_T_7;
    end
    else
      t_io_update_u_0_REG_2 <= s1_update__bits_meta[29:28];
    t_io_update_mask_1_REG_2 <= _GEN_129 | _GEN_49 & _GEN_164;
    t_io_update_taken_1_REG_2 <= (_GEN_129 | _GEN_145) & s1_update__bits_cfi_taken;
    t_io_update_alloc_1_REG_2 <= _GEN_148 & _GEN_65 & _GEN_53;
    t_io_update_old_ctr_1_REG_2 <= s1_update__bits_meta[21:19];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_67 : _GEN_99))
      t_io_update_u_1_REG_2 <= 2'h0;
    else if (s1_update__bits_meta[37]) begin
      if (_new_u_T_11) begin
        if (_new_u_T_13)
          t_io_update_u_1_REG_2 <= 2'h0;
        else
          t_io_update_u_1_REG_2 <= _new_u_T_14;
      end
      else if (&(s1_update__bits_meta[31:30]))
        t_io_update_u_1_REG_2 <= 2'h3;
      else
        t_io_update_u_1_REG_2 <= _new_u_T_18;
    end
    else
      t_io_update_u_1_REG_2 <= s1_update__bits_meta[31:30];
    t_io_update_mask_2_REG_2 <= _GEN_130 | _GEN_50 & _GEN_296;
    t_io_update_taken_2_REG_2 <= (_GEN_130 | _GEN_146) & s1_update__bits_cfi_taken;
    t_io_update_alloc_2_REG_2 <= _GEN_148 & _GEN_65 & _GEN_54;
    t_io_update_old_ctr_2_REG_2 <= s1_update__bits_meta[24:22];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_68 : _GEN_100))
      t_io_update_u_2_REG_2 <= 2'h0;
    else if (s1_update__bits_meta[38]) begin
      if (_new_u_T_22) begin
        if (_new_u_T_24)
          t_io_update_u_2_REG_2 <= 2'h0;
        else
          t_io_update_u_2_REG_2 <= _new_u_T_25;
      end
      else if (&(s1_update__bits_meta[33:32]))
        t_io_update_u_2_REG_2 <= 2'h3;
      else
        t_io_update_u_2_REG_2 <= _new_u_T_29;
    end
    else
      t_io_update_u_2_REG_2 <= s1_update__bits_meta[33:32];
    t_io_update_mask_3_REG_2 <= _GEN_131 | _GEN_51 & _GEN_428;
    t_io_update_taken_3_REG_2 <= (_GEN_131 | _GEN_147) & s1_update__bits_cfi_taken;
    t_io_update_alloc_3_REG_2 <= _GEN_148 & _GEN_65 & (&s1_update__bits_cfi_idx_bits);
    t_io_update_old_ctr_3_REG_2 <= s1_update__bits_meta[27:25];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_69 : _GEN_101))
      t_io_update_u_3_REG_2 <= 2'h0;
    else if (s1_update__bits_meta[39]) begin
      if (_new_u_T_33) begin
        if (_new_u_T_35)
          t_io_update_u_3_REG_2 <= 2'h0;
        else
          t_io_update_u_3_REG_2 <= _new_u_T_36;
      end
      else if (&(s1_update__bits_meta[35:34]))
        t_io_update_u_3_REG_2 <= 2'h3;
      else
        t_io_update_u_3_REG_2 <= _new_u_T_40;
    end
    else
      t_io_update_u_3_REG_2 <= s1_update__bits_meta[35:34];
    t_io_update_pc_REG_2 <= s1_update__bits_pc;
    t_io_update_hist_REG_2 <= s1_update__bits_ghist;
    t_io_update_mask_0_REG_3 <= _GEN_132 | _GEN_48 & _GEN_33_0;
    t_io_update_taken_0_REG_3 <= (_GEN_132 | _GEN_144) & s1_update__bits_cfi_taken;
    t_io_update_alloc_0_REG_3 <= _GEN_148 & _GEN_70 & ~(|s1_update__bits_cfi_idx_bits);
    t_io_update_old_ctr_0_REG_3 <= s1_update__bits_meta[18:16];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_71 : _GEN_108))
      t_io_update_u_0_REG_3 <= 2'h0;
    else if (s1_update__bits_meta[36]) begin
      if (_new_u_T) begin
        if (_new_u_T_2)
          t_io_update_u_0_REG_3 <= 2'h0;
        else
          t_io_update_u_0_REG_3 <= _new_u_T_3;
      end
      else if (&(s1_update__bits_meta[29:28]))
        t_io_update_u_0_REG_3 <= 2'h3;
      else
        t_io_update_u_0_REG_3 <= _new_u_T_7;
    end
    else
      t_io_update_u_0_REG_3 <= s1_update__bits_meta[29:28];
    t_io_update_mask_1_REG_3 <= _GEN_133 | _GEN_49 & _GEN_165;
    t_io_update_taken_1_REG_3 <= (_GEN_133 | _GEN_145) & s1_update__bits_cfi_taken;
    t_io_update_alloc_1_REG_3 <= _GEN_148 & _GEN_70 & _GEN_53;
    t_io_update_old_ctr_1_REG_3 <= s1_update__bits_meta[21:19];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_72 : _GEN_109))
      t_io_update_u_1_REG_3 <= 2'h0;
    else if (s1_update__bits_meta[37]) begin
      if (_new_u_T_11) begin
        if (_new_u_T_13)
          t_io_update_u_1_REG_3 <= 2'h0;
        else
          t_io_update_u_1_REG_3 <= _new_u_T_14;
      end
      else if (&(s1_update__bits_meta[31:30]))
        t_io_update_u_1_REG_3 <= 2'h3;
      else
        t_io_update_u_1_REG_3 <= _new_u_T_18;
    end
    else
      t_io_update_u_1_REG_3 <= s1_update__bits_meta[31:30];
    t_io_update_mask_2_REG_3 <= _GEN_134 | _GEN_50 & _GEN_297;
    t_io_update_taken_2_REG_3 <= (_GEN_134 | _GEN_146) & s1_update__bits_cfi_taken;
    t_io_update_alloc_2_REG_3 <= _GEN_148 & _GEN_70 & _GEN_54;
    t_io_update_old_ctr_2_REG_3 <= s1_update__bits_meta[24:22];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_73 : _GEN_110))
      t_io_update_u_2_REG_3 <= 2'h0;
    else if (s1_update__bits_meta[38]) begin
      if (_new_u_T_22) begin
        if (_new_u_T_24)
          t_io_update_u_2_REG_3 <= 2'h0;
        else
          t_io_update_u_2_REG_3 <= _new_u_T_25;
      end
      else if (&(s1_update__bits_meta[33:32]))
        t_io_update_u_2_REG_3 <= 2'h3;
      else
        t_io_update_u_2_REG_3 <= _new_u_T_29;
    end
    else
      t_io_update_u_2_REG_3 <= s1_update__bits_meta[33:32];
    t_io_update_mask_3_REG_3 <= _GEN_135 | _GEN_51 & _GEN_429;
    t_io_update_taken_3_REG_3 <= (_GEN_135 | _GEN_147) & s1_update__bits_cfi_taken;
    t_io_update_alloc_3_REG_3 <= _GEN_148 & _GEN_70 & (&s1_update__bits_cfi_idx_bits);
    t_io_update_old_ctr_3_REG_3 <= s1_update__bits_meta[27:25];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_74 : _GEN_111))
      t_io_update_u_3_REG_3 <= 2'h0;
    else if (s1_update__bits_meta[39]) begin
      if (_new_u_T_33) begin
        if (_new_u_T_35)
          t_io_update_u_3_REG_3 <= 2'h0;
        else
          t_io_update_u_3_REG_3 <= _new_u_T_36;
      end
      else if (&(s1_update__bits_meta[35:34]))
        t_io_update_u_3_REG_3 <= 2'h3;
      else
        t_io_update_u_3_REG_3 <= _new_u_T_40;
    end
    else
      t_io_update_u_3_REG_3 <= s1_update__bits_meta[35:34];
    t_io_update_pc_REG_3 <= s1_update__bits_pc;
    t_io_update_hist_REG_3 <= s1_update__bits_ghist;
    t_io_update_mask_0_REG_4 <= _GEN_136 | _GEN_48 & _GEN_34_0;
    t_io_update_taken_0_REG_4 <= (_GEN_136 | _GEN_144) & s1_update__bits_cfi_taken;
    t_io_update_alloc_0_REG_4 <= _GEN_148 & _GEN_75 & ~(|s1_update__bits_cfi_idx_bits);
    t_io_update_old_ctr_0_REG_4 <= s1_update__bits_meta[18:16];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_76 : _GEN_112))
      t_io_update_u_0_REG_4 <= 2'h0;
    else if (s1_update__bits_meta[36]) begin
      if (_new_u_T) begin
        if (_new_u_T_2)
          t_io_update_u_0_REG_4 <= 2'h0;
        else
          t_io_update_u_0_REG_4 <= _new_u_T_3;
      end
      else if (&(s1_update__bits_meta[29:28]))
        t_io_update_u_0_REG_4 <= 2'h3;
      else
        t_io_update_u_0_REG_4 <= _new_u_T_7;
    end
    else
      t_io_update_u_0_REG_4 <= s1_update__bits_meta[29:28];
    t_io_update_mask_1_REG_4 <= _GEN_137 | _GEN_49 & _GEN_166;
    t_io_update_taken_1_REG_4 <= (_GEN_137 | _GEN_145) & s1_update__bits_cfi_taken;
    t_io_update_alloc_1_REG_4 <= _GEN_148 & _GEN_75 & _GEN_53;
    t_io_update_old_ctr_1_REG_4 <= s1_update__bits_meta[21:19];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_77 : _GEN_113))
      t_io_update_u_1_REG_4 <= 2'h0;
    else if (s1_update__bits_meta[37]) begin
      if (_new_u_T_11) begin
        if (_new_u_T_13)
          t_io_update_u_1_REG_4 <= 2'h0;
        else
          t_io_update_u_1_REG_4 <= _new_u_T_14;
      end
      else if (&(s1_update__bits_meta[31:30]))
        t_io_update_u_1_REG_4 <= 2'h3;
      else
        t_io_update_u_1_REG_4 <= _new_u_T_18;
    end
    else
      t_io_update_u_1_REG_4 <= s1_update__bits_meta[31:30];
    t_io_update_mask_2_REG_4 <= _GEN_138 | _GEN_50 & _GEN_298;
    t_io_update_taken_2_REG_4 <= (_GEN_138 | _GEN_146) & s1_update__bits_cfi_taken;
    t_io_update_alloc_2_REG_4 <= _GEN_148 & _GEN_75 & _GEN_54;
    t_io_update_old_ctr_2_REG_4 <= s1_update__bits_meta[24:22];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_78 : _GEN_114))
      t_io_update_u_2_REG_4 <= 2'h0;
    else if (s1_update__bits_meta[38]) begin
      if (_new_u_T_22) begin
        if (_new_u_T_24)
          t_io_update_u_2_REG_4 <= 2'h0;
        else
          t_io_update_u_2_REG_4 <= _new_u_T_25;
      end
      else if (&(s1_update__bits_meta[33:32]))
        t_io_update_u_2_REG_4 <= 2'h3;
      else
        t_io_update_u_2_REG_4 <= _new_u_T_29;
    end
    else
      t_io_update_u_2_REG_4 <= s1_update__bits_meta[33:32];
    t_io_update_mask_3_REG_4 <= _GEN_139 | _GEN_51 & _GEN_430;
    t_io_update_taken_3_REG_4 <= (_GEN_139 | _GEN_147) & s1_update__bits_cfi_taken;
    t_io_update_alloc_3_REG_4 <= _GEN_148 & _GEN_75 & (&s1_update__bits_cfi_idx_bits);
    t_io_update_old_ctr_3_REG_4 <= s1_update__bits_meta[27:25];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_79 : _GEN_115))
      t_io_update_u_3_REG_4 <= 2'h0;
    else if (s1_update__bits_meta[39]) begin
      if (_new_u_T_33) begin
        if (_new_u_T_35)
          t_io_update_u_3_REG_4 <= 2'h0;
        else
          t_io_update_u_3_REG_4 <= _new_u_T_36;
      end
      else if (&(s1_update__bits_meta[35:34]))
        t_io_update_u_3_REG_4 <= 2'h3;
      else
        t_io_update_u_3_REG_4 <= _new_u_T_40;
    end
    else
      t_io_update_u_3_REG_4 <= s1_update__bits_meta[35:34];
    t_io_update_pc_REG_4 <= s1_update__bits_pc;
    t_io_update_hist_REG_4 <= s1_update__bits_ghist;
    t_io_update_mask_0_REG_5 <= _GEN_140 | _GEN_48 & _GEN_35_0;
    t_io_update_taken_0_REG_5 <= (_GEN_140 | _GEN_144) & s1_update__bits_cfi_taken;
    t_io_update_alloc_0_REG_5 <= _GEN_148 & _GEN_80 & ~(|s1_update__bits_cfi_idx_bits);
    t_io_update_old_ctr_0_REG_5 <= s1_update__bits_meta[18:16];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_81 : _GEN_116))
      t_io_update_u_0_REG_5 <= 2'h0;
    else if (s1_update__bits_meta[36]) begin
      if (_new_u_T) begin
        if (_new_u_T_2)
          t_io_update_u_0_REG_5 <= 2'h0;
        else
          t_io_update_u_0_REG_5 <= _new_u_T_3;
      end
      else if (&(s1_update__bits_meta[29:28]))
        t_io_update_u_0_REG_5 <= 2'h3;
      else
        t_io_update_u_0_REG_5 <= _new_u_T_7;
    end
    else
      t_io_update_u_0_REG_5 <= s1_update__bits_meta[29:28];
    t_io_update_mask_1_REG_5 <= _GEN_141 | _GEN_49 & _GEN_167;
    t_io_update_taken_1_REG_5 <= (_GEN_141 | _GEN_145) & s1_update__bits_cfi_taken;
    t_io_update_alloc_1_REG_5 <= _GEN_148 & _GEN_80 & _GEN_53;
    t_io_update_old_ctr_1_REG_5 <= s1_update__bits_meta[21:19];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_82 : _GEN_117))
      t_io_update_u_1_REG_5 <= 2'h0;
    else if (s1_update__bits_meta[37]) begin
      if (_new_u_T_11) begin
        if (_new_u_T_13)
          t_io_update_u_1_REG_5 <= 2'h0;
        else
          t_io_update_u_1_REG_5 <= _new_u_T_14;
      end
      else if (&(s1_update__bits_meta[31:30]))
        t_io_update_u_1_REG_5 <= 2'h3;
      else
        t_io_update_u_1_REG_5 <= _new_u_T_18;
    end
    else
      t_io_update_u_1_REG_5 <= s1_update__bits_meta[31:30];
    t_io_update_mask_2_REG_5 <= _GEN_142 | _GEN_50 & _GEN_299;
    t_io_update_taken_2_REG_5 <= (_GEN_142 | _GEN_146) & s1_update__bits_cfi_taken;
    t_io_update_alloc_2_REG_5 <= _GEN_148 & _GEN_80 & _GEN_54;
    t_io_update_old_ctr_2_REG_5 <= s1_update__bits_meta[24:22];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_83 : _GEN_118))
      t_io_update_u_2_REG_5 <= 2'h0;
    else if (s1_update__bits_meta[38]) begin
      if (_new_u_T_22) begin
        if (_new_u_T_24)
          t_io_update_u_2_REG_5 <= 2'h0;
        else
          t_io_update_u_2_REG_5 <= _new_u_T_25;
      end
      else if (&(s1_update__bits_meta[33:32]))
        t_io_update_u_2_REG_5 <= 2'h3;
      else
        t_io_update_u_2_REG_5 <= _new_u_T_29;
    end
    else
      t_io_update_u_2_REG_5 <= s1_update__bits_meta[33:32];
    t_io_update_mask_3_REG_5 <= _GEN_143 | _GEN_51 & _GEN_431;
    t_io_update_taken_3_REG_5 <= (_GEN_143 | _GEN_147) & s1_update__bits_cfi_taken;
    t_io_update_alloc_3_REG_5 <= _GEN_148 & _GEN_80 & (&s1_update__bits_cfi_idx_bits);
    t_io_update_old_ctr_3_REG_5 <= s1_update__bits_meta[27:25];
    if (_GEN_52 & (casez_tmp_7 ? _GEN_84 : _GEN_119))
      t_io_update_u_3_REG_5 <= 2'h0;
    else if (s1_update__bits_meta[39]) begin
      if (_new_u_T_33) begin
        if (_new_u_T_35)
          t_io_update_u_3_REG_5 <= 2'h0;
        else
          t_io_update_u_3_REG_5 <= _new_u_T_36;
      end
      else if (&(s1_update__bits_meta[35:34]))
        t_io_update_u_3_REG_5 <= 2'h3;
      else
        t_io_update_u_3_REG_5 <= _new_u_T_40;
    end
    else
      t_io_update_u_3_REG_5 <= s1_update__bits_meta[35:34];
    t_io_update_pc_REG_5 <= s1_update__bits_pc;
    t_io_update_hist_REG_5 <= s1_update__bits_ghist;
  end // always @(posedge)
  TageTable t (
    .clock                 (clock),
    .reset                 (reset),
    .io_f1_req_valid       (t_io_f1_req_valid_REG),
    .io_f1_req_pc          (t_io_f1_req_pc_REG),
    .io_f1_req_ghist       (io_f1_ghist),
    .io_update_mask_0      (t_io_update_mask_0_REG),
    .io_update_mask_1      (t_io_update_mask_1_REG),
    .io_update_mask_2      (t_io_update_mask_2_REG),
    .io_update_mask_3      (t_io_update_mask_3_REG),
    .io_update_taken_0     (t_io_update_taken_0_REG),
    .io_update_taken_1     (t_io_update_taken_1_REG),
    .io_update_taken_2     (t_io_update_taken_2_REG),
    .io_update_taken_3     (t_io_update_taken_3_REG),
    .io_update_alloc_0     (t_io_update_alloc_0_REG),
    .io_update_alloc_1     (t_io_update_alloc_1_REG),
    .io_update_alloc_2     (t_io_update_alloc_2_REG),
    .io_update_alloc_3     (t_io_update_alloc_3_REG),
    .io_update_old_ctr_0   (t_io_update_old_ctr_0_REG),
    .io_update_old_ctr_1   (t_io_update_old_ctr_1_REG),
    .io_update_old_ctr_2   (t_io_update_old_ctr_2_REG),
    .io_update_old_ctr_3   (t_io_update_old_ctr_3_REG),
    .io_update_pc          (t_io_update_pc_REG),
    .io_update_hist        (t_io_update_hist_REG),
    .io_update_u_mask_0    (t_io_update_u_mask_0_REG),
    .io_update_u_mask_1    (t_io_update_u_mask_1_REG),
    .io_update_u_mask_2    (t_io_update_u_mask_2_REG),
    .io_update_u_mask_3    (t_io_update_u_mask_3_REG),
    .io_update_u_0         (t_io_update_u_0_REG),
    .io_update_u_1         (t_io_update_u_1_REG),
    .io_update_u_2         (t_io_update_u_2_REG),
    .io_update_u_3         (t_io_update_u_3_REG),
    .io_f3_resp_0_valid    (_t_io_f3_resp_0_valid),
    .io_f3_resp_0_bits_ctr (_t_io_f3_resp_0_bits_ctr),
    .io_f3_resp_0_bits_u   (_t_io_f3_resp_0_bits_u),
    .io_f3_resp_1_valid    (_t_io_f3_resp_1_valid),
    .io_f3_resp_1_bits_ctr (_t_io_f3_resp_1_bits_ctr),
    .io_f3_resp_1_bits_u   (_t_io_f3_resp_1_bits_u),
    .io_f3_resp_2_valid    (_t_io_f3_resp_2_valid),
    .io_f3_resp_2_bits_ctr (_t_io_f3_resp_2_bits_ctr),
    .io_f3_resp_2_bits_u   (_t_io_f3_resp_2_bits_u),
    .io_f3_resp_3_valid    (_t_io_f3_resp_3_valid),
    .io_f3_resp_3_bits_ctr (_t_io_f3_resp_3_bits_ctr),
    .io_f3_resp_3_bits_u   (_t_io_f3_resp_3_bits_u)
  );
  TageTable_1 t_1 (
    .clock                 (clock),
    .reset                 (reset),
    .io_f1_req_valid       (t_io_f1_req_valid_REG_1),
    .io_f1_req_pc          (t_io_f1_req_pc_REG_1),
    .io_f1_req_ghist       (io_f1_ghist),
    .io_update_mask_0      (t_io_update_mask_0_REG_1),
    .io_update_mask_1      (t_io_update_mask_1_REG_1),
    .io_update_mask_2      (t_io_update_mask_2_REG_1),
    .io_update_mask_3      (t_io_update_mask_3_REG_1),
    .io_update_taken_0     (t_io_update_taken_0_REG_1),
    .io_update_taken_1     (t_io_update_taken_1_REG_1),
    .io_update_taken_2     (t_io_update_taken_2_REG_1),
    .io_update_taken_3     (t_io_update_taken_3_REG_1),
    .io_update_alloc_0     (t_io_update_alloc_0_REG_1),
    .io_update_alloc_1     (t_io_update_alloc_1_REG_1),
    .io_update_alloc_2     (t_io_update_alloc_2_REG_1),
    .io_update_alloc_3     (t_io_update_alloc_3_REG_1),
    .io_update_old_ctr_0   (t_io_update_old_ctr_0_REG_1),
    .io_update_old_ctr_1   (t_io_update_old_ctr_1_REG_1),
    .io_update_old_ctr_2   (t_io_update_old_ctr_2_REG_1),
    .io_update_old_ctr_3   (t_io_update_old_ctr_3_REG_1),
    .io_update_pc          (t_io_update_pc_REG_1),
    .io_update_hist        (t_io_update_hist_REG_1),
    .io_update_u_mask_0    (t_io_update_u_mask_0_REG_1),
    .io_update_u_mask_1    (t_io_update_u_mask_1_REG_1),
    .io_update_u_mask_2    (t_io_update_u_mask_2_REG_1),
    .io_update_u_mask_3    (t_io_update_u_mask_3_REG_1),
    .io_update_u_0         (t_io_update_u_0_REG_1),
    .io_update_u_1         (t_io_update_u_1_REG_1),
    .io_update_u_2         (t_io_update_u_2_REG_1),
    .io_update_u_3         (t_io_update_u_3_REG_1),
    .io_f3_resp_0_valid    (_t_1_io_f3_resp_0_valid),
    .io_f3_resp_0_bits_ctr (_t_1_io_f3_resp_0_bits_ctr),
    .io_f3_resp_0_bits_u   (_t_1_io_f3_resp_0_bits_u),
    .io_f3_resp_1_valid    (_t_1_io_f3_resp_1_valid),
    .io_f3_resp_1_bits_ctr (_t_1_io_f3_resp_1_bits_ctr),
    .io_f3_resp_1_bits_u   (_t_1_io_f3_resp_1_bits_u),
    .io_f3_resp_2_valid    (_t_1_io_f3_resp_2_valid),
    .io_f3_resp_2_bits_ctr (_t_1_io_f3_resp_2_bits_ctr),
    .io_f3_resp_2_bits_u   (_t_1_io_f3_resp_2_bits_u),
    .io_f3_resp_3_valid    (_t_1_io_f3_resp_3_valid),
    .io_f3_resp_3_bits_ctr (_t_1_io_f3_resp_3_bits_ctr),
    .io_f3_resp_3_bits_u   (_t_1_io_f3_resp_3_bits_u)
  );
  TageTable_2 t_2 (
    .clock                 (clock),
    .reset                 (reset),
    .io_f1_req_valid       (t_io_f1_req_valid_REG_2),
    .io_f1_req_pc          (t_io_f1_req_pc_REG_2),
    .io_f1_req_ghist       (io_f1_ghist),
    .io_update_mask_0      (t_io_update_mask_0_REG_2),
    .io_update_mask_1      (t_io_update_mask_1_REG_2),
    .io_update_mask_2      (t_io_update_mask_2_REG_2),
    .io_update_mask_3      (t_io_update_mask_3_REG_2),
    .io_update_taken_0     (t_io_update_taken_0_REG_2),
    .io_update_taken_1     (t_io_update_taken_1_REG_2),
    .io_update_taken_2     (t_io_update_taken_2_REG_2),
    .io_update_taken_3     (t_io_update_taken_3_REG_2),
    .io_update_alloc_0     (t_io_update_alloc_0_REG_2),
    .io_update_alloc_1     (t_io_update_alloc_1_REG_2),
    .io_update_alloc_2     (t_io_update_alloc_2_REG_2),
    .io_update_alloc_3     (t_io_update_alloc_3_REG_2),
    .io_update_old_ctr_0   (t_io_update_old_ctr_0_REG_2),
    .io_update_old_ctr_1   (t_io_update_old_ctr_1_REG_2),
    .io_update_old_ctr_2   (t_io_update_old_ctr_2_REG_2),
    .io_update_old_ctr_3   (t_io_update_old_ctr_3_REG_2),
    .io_update_pc          (t_io_update_pc_REG_2),
    .io_update_hist        (t_io_update_hist_REG_2),
    .io_update_u_mask_0    (t_io_update_u_mask_0_REG_2),
    .io_update_u_mask_1    (t_io_update_u_mask_1_REG_2),
    .io_update_u_mask_2    (t_io_update_u_mask_2_REG_2),
    .io_update_u_mask_3    (t_io_update_u_mask_3_REG_2),
    .io_update_u_0         (t_io_update_u_0_REG_2),
    .io_update_u_1         (t_io_update_u_1_REG_2),
    .io_update_u_2         (t_io_update_u_2_REG_2),
    .io_update_u_3         (t_io_update_u_3_REG_2),
    .io_f3_resp_0_valid    (_t_2_io_f3_resp_0_valid),
    .io_f3_resp_0_bits_ctr (_t_2_io_f3_resp_0_bits_ctr),
    .io_f3_resp_0_bits_u   (_t_2_io_f3_resp_0_bits_u),
    .io_f3_resp_1_valid    (_t_2_io_f3_resp_1_valid),
    .io_f3_resp_1_bits_ctr (_t_2_io_f3_resp_1_bits_ctr),
    .io_f3_resp_1_bits_u   (_t_2_io_f3_resp_1_bits_u),
    .io_f3_resp_2_valid    (_t_2_io_f3_resp_2_valid),
    .io_f3_resp_2_bits_ctr (_t_2_io_f3_resp_2_bits_ctr),
    .io_f3_resp_2_bits_u   (_t_2_io_f3_resp_2_bits_u),
    .io_f3_resp_3_valid    (_t_2_io_f3_resp_3_valid),
    .io_f3_resp_3_bits_ctr (_t_2_io_f3_resp_3_bits_ctr),
    .io_f3_resp_3_bits_u   (_t_2_io_f3_resp_3_bits_u)
  );
  TageTable_3 t_3 (
    .clock                 (clock),
    .reset                 (reset),
    .io_f1_req_valid       (t_io_f1_req_valid_REG_3),
    .io_f1_req_pc          (t_io_f1_req_pc_REG_3),
    .io_f1_req_ghist       (io_f1_ghist),
    .io_update_mask_0      (t_io_update_mask_0_REG_3),
    .io_update_mask_1      (t_io_update_mask_1_REG_3),
    .io_update_mask_2      (t_io_update_mask_2_REG_3),
    .io_update_mask_3      (t_io_update_mask_3_REG_3),
    .io_update_taken_0     (t_io_update_taken_0_REG_3),
    .io_update_taken_1     (t_io_update_taken_1_REG_3),
    .io_update_taken_2     (t_io_update_taken_2_REG_3),
    .io_update_taken_3     (t_io_update_taken_3_REG_3),
    .io_update_alloc_0     (t_io_update_alloc_0_REG_3),
    .io_update_alloc_1     (t_io_update_alloc_1_REG_3),
    .io_update_alloc_2     (t_io_update_alloc_2_REG_3),
    .io_update_alloc_3     (t_io_update_alloc_3_REG_3),
    .io_update_old_ctr_0   (t_io_update_old_ctr_0_REG_3),
    .io_update_old_ctr_1   (t_io_update_old_ctr_1_REG_3),
    .io_update_old_ctr_2   (t_io_update_old_ctr_2_REG_3),
    .io_update_old_ctr_3   (t_io_update_old_ctr_3_REG_3),
    .io_update_pc          (t_io_update_pc_REG_3),
    .io_update_hist        (t_io_update_hist_REG_3),
    .io_update_u_mask_0    (t_io_update_u_mask_0_REG_3),
    .io_update_u_mask_1    (t_io_update_u_mask_1_REG_3),
    .io_update_u_mask_2    (t_io_update_u_mask_2_REG_3),
    .io_update_u_mask_3    (t_io_update_u_mask_3_REG_3),
    .io_update_u_0         (t_io_update_u_0_REG_3),
    .io_update_u_1         (t_io_update_u_1_REG_3),
    .io_update_u_2         (t_io_update_u_2_REG_3),
    .io_update_u_3         (t_io_update_u_3_REG_3),
    .io_f3_resp_0_valid    (_t_3_io_f3_resp_0_valid),
    .io_f3_resp_0_bits_ctr (_t_3_io_f3_resp_0_bits_ctr),
    .io_f3_resp_0_bits_u   (_t_3_io_f3_resp_0_bits_u),
    .io_f3_resp_1_valid    (_t_3_io_f3_resp_1_valid),
    .io_f3_resp_1_bits_ctr (_t_3_io_f3_resp_1_bits_ctr),
    .io_f3_resp_1_bits_u   (_t_3_io_f3_resp_1_bits_u),
    .io_f3_resp_2_valid    (_t_3_io_f3_resp_2_valid),
    .io_f3_resp_2_bits_ctr (_t_3_io_f3_resp_2_bits_ctr),
    .io_f3_resp_2_bits_u   (_t_3_io_f3_resp_2_bits_u),
    .io_f3_resp_3_valid    (_t_3_io_f3_resp_3_valid),
    .io_f3_resp_3_bits_ctr (_t_3_io_f3_resp_3_bits_ctr),
    .io_f3_resp_3_bits_u   (_t_3_io_f3_resp_3_bits_u)
  );
  TageTable_4 t_4 (
    .clock                 (clock),
    .reset                 (reset),
    .io_f1_req_valid       (t_io_f1_req_valid_REG_4),
    .io_f1_req_pc          (t_io_f1_req_pc_REG_4),
    .io_f1_req_ghist       (io_f1_ghist),
    .io_update_mask_0      (t_io_update_mask_0_REG_4),
    .io_update_mask_1      (t_io_update_mask_1_REG_4),
    .io_update_mask_2      (t_io_update_mask_2_REG_4),
    .io_update_mask_3      (t_io_update_mask_3_REG_4),
    .io_update_taken_0     (t_io_update_taken_0_REG_4),
    .io_update_taken_1     (t_io_update_taken_1_REG_4),
    .io_update_taken_2     (t_io_update_taken_2_REG_4),
    .io_update_taken_3     (t_io_update_taken_3_REG_4),
    .io_update_alloc_0     (t_io_update_alloc_0_REG_4),
    .io_update_alloc_1     (t_io_update_alloc_1_REG_4),
    .io_update_alloc_2     (t_io_update_alloc_2_REG_4),
    .io_update_alloc_3     (t_io_update_alloc_3_REG_4),
    .io_update_old_ctr_0   (t_io_update_old_ctr_0_REG_4),
    .io_update_old_ctr_1   (t_io_update_old_ctr_1_REG_4),
    .io_update_old_ctr_2   (t_io_update_old_ctr_2_REG_4),
    .io_update_old_ctr_3   (t_io_update_old_ctr_3_REG_4),
    .io_update_pc          (t_io_update_pc_REG_4),
    .io_update_hist        (t_io_update_hist_REG_4),
    .io_update_u_mask_0    (t_io_update_u_mask_0_REG_4),
    .io_update_u_mask_1    (t_io_update_u_mask_1_REG_4),
    .io_update_u_mask_2    (t_io_update_u_mask_2_REG_4),
    .io_update_u_mask_3    (t_io_update_u_mask_3_REG_4),
    .io_update_u_0         (t_io_update_u_0_REG_4),
    .io_update_u_1         (t_io_update_u_1_REG_4),
    .io_update_u_2         (t_io_update_u_2_REG_4),
    .io_update_u_3         (t_io_update_u_3_REG_4),
    .io_f3_resp_0_valid    (_t_4_io_f3_resp_0_valid),
    .io_f3_resp_0_bits_ctr (_t_4_io_f3_resp_0_bits_ctr),
    .io_f3_resp_0_bits_u   (_t_4_io_f3_resp_0_bits_u),
    .io_f3_resp_1_valid    (_t_4_io_f3_resp_1_valid),
    .io_f3_resp_1_bits_ctr (_t_4_io_f3_resp_1_bits_ctr),
    .io_f3_resp_1_bits_u   (_t_4_io_f3_resp_1_bits_u),
    .io_f3_resp_2_valid    (_t_4_io_f3_resp_2_valid),
    .io_f3_resp_2_bits_ctr (_t_4_io_f3_resp_2_bits_ctr),
    .io_f3_resp_2_bits_u   (_t_4_io_f3_resp_2_bits_u),
    .io_f3_resp_3_valid    (_t_4_io_f3_resp_3_valid),
    .io_f3_resp_3_bits_ctr (_t_4_io_f3_resp_3_bits_ctr),
    .io_f3_resp_3_bits_u   (_t_4_io_f3_resp_3_bits_u)
  );
  TageTable_5 t_5 (
    .clock                 (clock),
    .reset                 (reset),
    .io_f1_req_valid       (t_io_f1_req_valid_REG_5),
    .io_f1_req_pc          (t_io_f1_req_pc_REG_5),
    .io_f1_req_ghist       (io_f1_ghist),
    .io_update_mask_0      (t_io_update_mask_0_REG_5),
    .io_update_mask_1      (t_io_update_mask_1_REG_5),
    .io_update_mask_2      (t_io_update_mask_2_REG_5),
    .io_update_mask_3      (t_io_update_mask_3_REG_5),
    .io_update_taken_0     (t_io_update_taken_0_REG_5),
    .io_update_taken_1     (t_io_update_taken_1_REG_5),
    .io_update_taken_2     (t_io_update_taken_2_REG_5),
    .io_update_taken_3     (t_io_update_taken_3_REG_5),
    .io_update_alloc_0     (t_io_update_alloc_0_REG_5),
    .io_update_alloc_1     (t_io_update_alloc_1_REG_5),
    .io_update_alloc_2     (t_io_update_alloc_2_REG_5),
    .io_update_alloc_3     (t_io_update_alloc_3_REG_5),
    .io_update_old_ctr_0   (t_io_update_old_ctr_0_REG_5),
    .io_update_old_ctr_1   (t_io_update_old_ctr_1_REG_5),
    .io_update_old_ctr_2   (t_io_update_old_ctr_2_REG_5),
    .io_update_old_ctr_3   (t_io_update_old_ctr_3_REG_5),
    .io_update_pc          (t_io_update_pc_REG_5),
    .io_update_hist        (t_io_update_hist_REG_5),
    .io_update_u_mask_0    (t_io_update_u_mask_0_REG_5),
    .io_update_u_mask_1    (t_io_update_u_mask_1_REG_5),
    .io_update_u_mask_2    (t_io_update_u_mask_2_REG_5),
    .io_update_u_mask_3    (t_io_update_u_mask_3_REG_5),
    .io_update_u_0         (t_io_update_u_0_REG_5),
    .io_update_u_1         (t_io_update_u_1_REG_5),
    .io_update_u_2         (t_io_update_u_2_REG_5),
    .io_update_u_3         (t_io_update_u_3_REG_5),
    .io_f3_resp_0_valid    (_t_5_io_f3_resp_0_valid),
    .io_f3_resp_0_bits_ctr (_t_5_io_f3_resp_0_bits_ctr),
    .io_f3_resp_0_bits_u   (_t_5_io_f3_resp_0_bits_u),
    .io_f3_resp_1_valid    (_t_5_io_f3_resp_1_valid),
    .io_f3_resp_1_bits_ctr (_t_5_io_f3_resp_1_bits_ctr),
    .io_f3_resp_1_bits_u   (_t_5_io_f3_resp_1_bits_u),
    .io_f3_resp_2_valid    (_t_5_io_f3_resp_2_valid),
    .io_f3_resp_2_bits_ctr (_t_5_io_f3_resp_2_bits_ctr),
    .io_f3_resp_2_bits_u   (_t_5_io_f3_resp_2_bits_u),
    .io_f3_resp_3_valid    (_t_5_io_f3_resp_3_valid),
    .io_f3_resp_3_bits_ctr (_t_5_io_f3_resp_3_bits_ctr),
    .io_f3_resp_3_bits_u   (_t_5_io_f3_resp_3_bits_u)
  );
  MaxPeriodFibonacciLFSR_3 alloc_lfsr_prng (
    .clock    (clock),
    .reset    (reset),
    .io_out_0 (_alloc_lfsr_prng_io_out_0),
    .io_out_1 (_alloc_lfsr_prng_io_out_1),
    .io_out_2 (_alloc_lfsr_prng_io_out_2),
    .io_out_3 (_alloc_lfsr_prng_io_out_3),
    .io_out_4 (_alloc_lfsr_prng_io_out_4),
    .io_out_5 (_alloc_lfsr_prng_io_out_5)
  );
  MaxPeriodFibonacciLFSR_3 alloc_lfsr_prng_1 (
    .clock    (clock),
    .reset    (reset),
    .io_out_0 (_alloc_lfsr_prng_1_io_out_0),
    .io_out_1 (_alloc_lfsr_prng_1_io_out_1),
    .io_out_2 (_alloc_lfsr_prng_1_io_out_2),
    .io_out_3 (_alloc_lfsr_prng_1_io_out_3),
    .io_out_4 (_alloc_lfsr_prng_1_io_out_4),
    .io_out_5 (_alloc_lfsr_prng_1_io_out_5)
  );
  MaxPeriodFibonacciLFSR_3 alloc_lfsr_prng_2 (
    .clock    (clock),
    .reset    (reset),
    .io_out_0 (_alloc_lfsr_prng_2_io_out_0),
    .io_out_1 (_alloc_lfsr_prng_2_io_out_1),
    .io_out_2 (_alloc_lfsr_prng_2_io_out_2),
    .io_out_3 (_alloc_lfsr_prng_2_io_out_3),
    .io_out_4 (_alloc_lfsr_prng_2_io_out_4),
    .io_out_5 (_alloc_lfsr_prng_2_io_out_5)
  );
  MaxPeriodFibonacciLFSR_3 alloc_lfsr_prng_3 (
    .clock    (clock),
    .reset    (reset),
    .io_out_0 (_alloc_lfsr_prng_3_io_out_0),
    .io_out_1 (_alloc_lfsr_prng_3_io_out_1),
    .io_out_2 (_alloc_lfsr_prng_3_io_out_2),
    .io_out_3 (_alloc_lfsr_prng_3_io_out_3),
    .io_out_4 (_alloc_lfsr_prng_3_io_out_4),
    .io_out_5 (_alloc_lfsr_prng_3_io_out_5)
  );
  assign io_resp_f1_0_taken = io_resp_in_0_f1_0_taken;
  assign io_resp_f1_0_is_br = io_resp_in_0_f1_0_is_br;
  assign io_resp_f1_0_is_jal = io_resp_in_0_f1_0_is_jal;
  assign io_resp_f1_0_predicted_pc_valid = io_resp_in_0_f1_0_predicted_pc_valid;
  assign io_resp_f1_0_predicted_pc_bits = io_resp_in_0_f1_0_predicted_pc_bits;
  assign io_resp_f1_1_taken = io_resp_in_0_f1_1_taken;
  assign io_resp_f1_1_is_br = io_resp_in_0_f1_1_is_br;
  assign io_resp_f1_1_is_jal = io_resp_in_0_f1_1_is_jal;
  assign io_resp_f1_1_predicted_pc_valid = io_resp_in_0_f1_1_predicted_pc_valid;
  assign io_resp_f1_1_predicted_pc_bits = io_resp_in_0_f1_1_predicted_pc_bits;
  assign io_resp_f1_2_taken = io_resp_in_0_f1_2_taken;
  assign io_resp_f1_2_is_br = io_resp_in_0_f1_2_is_br;
  assign io_resp_f1_2_is_jal = io_resp_in_0_f1_2_is_jal;
  assign io_resp_f1_2_predicted_pc_valid = io_resp_in_0_f1_2_predicted_pc_valid;
  assign io_resp_f1_2_predicted_pc_bits = io_resp_in_0_f1_2_predicted_pc_bits;
  assign io_resp_f1_3_taken = io_resp_in_0_f1_3_taken;
  assign io_resp_f1_3_is_br = io_resp_in_0_f1_3_is_br;
  assign io_resp_f1_3_is_jal = io_resp_in_0_f1_3_is_jal;
  assign io_resp_f1_3_predicted_pc_valid = io_resp_in_0_f1_3_predicted_pc_valid;
  assign io_resp_f1_3_predicted_pc_bits = io_resp_in_0_f1_3_predicted_pc_bits;
  assign io_resp_f2_0_taken = io_resp_in_0_f2_0_taken;
  assign io_resp_f2_0_is_br = io_resp_in_0_f2_0_is_br;
  assign io_resp_f2_0_is_jal = io_resp_in_0_f2_0_is_jal;
  assign io_resp_f2_0_predicted_pc_valid = io_resp_in_0_f2_0_predicted_pc_valid;
  assign io_resp_f2_0_predicted_pc_bits = io_resp_in_0_f2_0_predicted_pc_bits;
  assign io_resp_f2_1_taken = io_resp_in_0_f2_1_taken;
  assign io_resp_f2_1_is_br = io_resp_in_0_f2_1_is_br;
  assign io_resp_f2_1_is_jal = io_resp_in_0_f2_1_is_jal;
  assign io_resp_f2_1_predicted_pc_valid = io_resp_in_0_f2_1_predicted_pc_valid;
  assign io_resp_f2_1_predicted_pc_bits = io_resp_in_0_f2_1_predicted_pc_bits;
  assign io_resp_f2_2_taken = io_resp_in_0_f2_2_taken;
  assign io_resp_f2_2_is_br = io_resp_in_0_f2_2_is_br;
  assign io_resp_f2_2_is_jal = io_resp_in_0_f2_2_is_jal;
  assign io_resp_f2_2_predicted_pc_valid = io_resp_in_0_f2_2_predicted_pc_valid;
  assign io_resp_f2_2_predicted_pc_bits = io_resp_in_0_f2_2_predicted_pc_bits;
  assign io_resp_f2_3_taken = io_resp_in_0_f2_3_taken;
  assign io_resp_f2_3_is_br = io_resp_in_0_f2_3_is_br;
  assign io_resp_f2_3_is_jal = io_resp_in_0_f2_3_is_jal;
  assign io_resp_f2_3_predicted_pc_valid = io_resp_in_0_f2_3_predicted_pc_valid;
  assign io_resp_f2_3_predicted_pc_bits = io_resp_in_0_f2_3_predicted_pc_bits;
  assign io_resp_f3_0_taken = _io_resp_f3_0_taken_output;
  assign io_resp_f3_0_predicted_pc_valid = io_resp_in_0_f3_0_predicted_pc_valid;
  assign io_resp_f3_0_predicted_pc_bits = io_resp_in_0_f3_0_predicted_pc_bits;
  assign io_resp_f3_1_taken = _io_resp_f3_1_taken_output;
  assign io_resp_f3_1_predicted_pc_valid = io_resp_in_0_f3_1_predicted_pc_valid;
  assign io_resp_f3_1_predicted_pc_bits = io_resp_in_0_f3_1_predicted_pc_bits;
  assign io_resp_f3_2_taken = _io_resp_f3_2_taken_output;
  assign io_resp_f3_2_predicted_pc_valid = io_resp_in_0_f3_2_predicted_pc_valid;
  assign io_resp_f3_2_predicted_pc_bits = io_resp_in_0_f3_2_predicted_pc_bits;
  assign io_resp_f3_3_taken = _io_resp_f3_3_taken_output;
  assign io_resp_f3_3_predicted_pc_valid = io_resp_in_0_f3_3_predicted_pc_valid;
  assign io_resp_f3_3_predicted_pc_bits = io_resp_in_0_f3_3_predicted_pc_bits;
  assign io_f3_meta =
    {64'h0,
     f3_meta_provider_3_valid,
     f3_meta_provider_3_bits,
     f3_meta_provider_2_valid,
     f3_meta_provider_2_bits,
     f3_meta_provider_1_valid,
     f3_meta_provider_1_bits,
     f3_meta_provider_0_valid,
     f3_meta_provider_0_bits,
     (_t_5_io_f3_resp_3_valid ? _GEN_46 : _t_4_io_f3_resp_3_valid ? _GEN_45 : _t_3_io_f3_resp_3_valid ? _GEN_44 : _t_2_io_f3_resp_3_valid ? _GEN_43 : _t_1_io_f3_resp_3_valid & _t_io_f3_resp_3_valid ? _t_io_f3_resp_3_bits_ctr[2] : io_resp_in_0_f3_3_taken) != _io_resp_f3_3_taken_output,
     (_t_5_io_f3_resp_2_valid ? _GEN_36 : _t_4_io_f3_resp_2_valid ? _GEN_35 : _t_3_io_f3_resp_2_valid ? _GEN_34 : _t_2_io_f3_resp_2_valid ? _GEN_33 : _t_1_io_f3_resp_2_valid & _t_io_f3_resp_2_valid ? _t_io_f3_resp_2_bits_ctr[2] : io_resp_in_0_f3_2_taken) != _io_resp_f3_2_taken_output,
     (_t_5_io_f3_resp_1_valid ? _GEN_41 : _t_4_io_f3_resp_1_valid ? _GEN_40 : _t_3_io_f3_resp_1_valid ? _GEN_39 : _t_2_io_f3_resp_1_valid ? _GEN_38 : _t_1_io_f3_resp_1_valid & _t_io_f3_resp_1_valid ? _t_io_f3_resp_1_bits_ctr[2] : io_resp_in_0_f3_1_taken) != _io_resp_f3_1_taken_output,
     (_t_5_io_f3_resp_0_valid ? _GEN_31 : _t_4_io_f3_resp_0_valid ? _GEN_30 : _t_3_io_f3_resp_0_valid ? _GEN_29 : _t_2_io_f3_resp_0_valid ? _GEN_28 : _t_1_io_f3_resp_0_valid & _t_io_f3_resp_0_valid ? _t_io_f3_resp_0_bits_ctr[2] : io_resp_in_0_f3_0_taken) != _io_resp_f3_0_taken_output,
     casez_tmp_5,
     casez_tmp_6,
     casez_tmp_3,
     casez_tmp_4,
     casez_tmp_1,
     casez_tmp_2,
     casez_tmp,
     casez_tmp_0,
     |_GEN_25,
     _alloc_entry_T_6[0] ? masked_entry_3 : _GEN_25[0] ? 3'h0 : _GEN_25[1] ? 3'h1 : _GEN_25[2] ? 3'h2 : _GEN_25[3] ? 3'h3 : _GEN_25[4] ? 3'h4 : {1'h1, ~(_GEN_25[5]), 1'h1},
     |_GEN_18,
     _alloc_entry_T_4[0] ? masked_entry_2 : _GEN_18[0] ? 3'h0 : _GEN_18[1] ? 3'h1 : _GEN_18[2] ? 3'h2 : _GEN_18[3] ? 3'h3 : _GEN_18[4] ? 3'h4 : {1'h1, ~(_GEN_18[5]), 1'h1},
     |_GEN_4,
     _alloc_entry_T_2[0] ? masked_entry_1 : _GEN_4[0] ? 3'h0 : _GEN_4[1] ? 3'h1 : _GEN_4[2] ? 3'h2 : _GEN_4[3] ? 3'h3 : _GEN_4[4] ? 3'h4 : {1'h1, ~(_GEN_4[5]), 1'h1},
     |_GEN_11,
     _alloc_entry_T[0] ? masked_entry : _GEN_11[0] ? 3'h0 : _GEN_11[1] ? 3'h1 : _GEN_11[2] ? 3'h2 : _GEN_11[3] ? 3'h3 : _GEN_11[4] ? 3'h4 : {1'h1, ~(_GEN_11[5]), 1'h1}};
endmodule

