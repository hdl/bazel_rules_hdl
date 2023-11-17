// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BTBBranchPredictorBank(
  input          clock,
                 reset,
                 io_f0_valid,
  input  [39:0]  io_f0_pc,
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

  wire         _GEN_148;
  wire         _GEN_147;
  wire         _GEN_146;
  wire         _GEN_145;
  wire         _GEN_139;
  wire         _GEN_138;
  wire         _GEN_137;
  wire         _GEN_136;
  wire         _GEN_135;
  wire         _GEN_112;
  wire         _GEN_111;
  wire         _GEN_110;
  wire         _GEN_109;
  wire         _GEN_103;
  wire         _GEN_102;
  wire         _GEN_101;
  wire         _GEN_100;
  wire         _GEN_99;
  wire [39:0]  _ebtb_ext_R0_data;
  wire [13:0]  _btb_1_3_ext_R0_data;
  wire [13:0]  _btb_1_2_ext_R0_data;
  wire [13:0]  _btb_1_1_ext_R0_data;
  wire [13:0]  _btb_1_0_ext_R0_data;
  wire [13:0]  _btb_0_3_ext_R0_data;
  wire [13:0]  _btb_0_2_ext_R0_data;
  wire [13:0]  _btb_0_1_ext_R0_data;
  wire [13:0]  _btb_0_0_ext_R0_data;
  wire [29:0]  _meta_1_3_ext_R0_data;
  wire [29:0]  _meta_1_2_ext_R0_data;
  wire [29:0]  _meta_1_1_ext_R0_data;
  wire [29:0]  _meta_1_0_ext_R0_data;
  wire [29:0]  _meta_0_3_ext_R0_data;
  wire [29:0]  _meta_0_2_ext_R0_data;
  wire [29:0]  _meta_0_1_ext_R0_data;
  wire [29:0]  _meta_0_0_ext_R0_data;
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
  reg  [39:0]  s1_update__bits_target;
  reg  [119:0] s1_update__bits_meta;
  reg  [35:0]  s1_update_idx;
  reg          f3_meta_REG_write_way;
  reg          f3_meta_write_way;
  reg          doing_reset;
  reg  [6:0]   reset_idx;
  reg          REG;
  reg          io_resp_f2_0_predicted_pc_REG_valid;
  reg  [39:0]  io_resp_f2_0_predicted_pc_REG_bits;
  reg          io_resp_f2_0_is_br_REG;
  reg          io_resp_f2_0_is_jal_REG;
  reg          REG_1;
  reg          REG_2;
  reg          REG_3;
  reg          io_resp_f3_0_predicted_pc_REG_valid;
  reg  [39:0]  io_resp_f3_0_predicted_pc_REG_bits;
  reg          REG_4;
  reg          REG_5;
  reg          REG_6;
  reg          io_resp_f2_1_predicted_pc_REG_valid;
  reg  [39:0]  io_resp_f2_1_predicted_pc_REG_bits;
  reg          io_resp_f2_1_is_br_REG;
  reg          io_resp_f2_1_is_jal_REG;
  reg          REG_7;
  reg          REG_8;
  reg          REG_9;
  reg          io_resp_f3_1_predicted_pc_REG_valid;
  reg  [39:0]  io_resp_f3_1_predicted_pc_REG_bits;
  reg          REG_10;
  reg          REG_11;
  reg          REG_12;
  reg          io_resp_f2_2_predicted_pc_REG_valid;
  reg  [39:0]  io_resp_f2_2_predicted_pc_REG_bits;
  reg          io_resp_f2_2_is_br_REG;
  reg          io_resp_f2_2_is_jal_REG;
  reg          REG_13;
  reg          REG_14;
  reg          REG_15;
  reg          io_resp_f3_2_predicted_pc_REG_valid;
  reg  [39:0]  io_resp_f3_2_predicted_pc_REG_bits;
  reg          REG_16;
  reg          REG_17;
  reg          REG_18;
  reg          io_resp_f2_3_predicted_pc_REG_valid;
  reg  [39:0]  io_resp_f2_3_predicted_pc_REG_bits;
  reg          io_resp_f2_3_is_br_REG;
  reg          io_resp_f2_3_is_jal_REG;
  reg          REG_19;
  reg          REG_20;
  reg          REG_21;
  reg          io_resp_f3_3_predicted_pc_REG_valid;
  reg  [39:0]  io_resp_f3_3_predicted_pc_REG_bits;
  reg          REG_22;
  reg          REG_23;
  wire [39:0]  _new_offset_value_T_5 = s1_update__bits_target - (s1_update__bits_pc + {37'h0, s1_update__bits_cfi_idx_bits, 1'h0});
  wire         offset_is_extended = $signed(_new_offset_value_T_5) > 40'shFFF | $signed(_new_offset_value_T_5) < -40'sh1000;
  wire         _s1_update_wmeta_mask_T_1 = s1_update__bits_is_mispredict_update | s1_update__bits_is_repair_update;
  wire [3:0]   s1_update_wbtb_mask = 4'h1 << s1_update__bits_cfi_idx_bits & {4{s1_update__bits_cfi_idx_valid & s1_update__valid & s1_update__bits_cfi_taken & ~(_s1_update_wmeta_mask_T_1 | (|s1_update__bits_btb_mispredicts))}};
  assign _GEN_99 = doing_reset | ~(s1_update__bits_meta[0]);
  wire [6:0]   _GEN_97 = doing_reset ? reset_idx : s1_update_idx[6:0];
  wire [13:0]  _GEN = {_new_offset_value_T_5[12:0], offset_is_extended};
  wire [3:0]   _GEN_0 = doing_reset ? 4'hF : s1_update_wbtb_mask;
  assign _GEN_100 = _GEN_0[0];
  assign _GEN_101 = _GEN_0[1];
  assign _GEN_102 = _GEN_0[2];
  assign _GEN_103 = _GEN_0[3];
  wire [29:0]  _GEN_1 = {s1_update__bits_br_mask[0], s1_update__bits_btb_mispredicts[0] ? 29'h0 : s1_update_idx[35:7]};
  wire [29:0]  _GEN_2 = {s1_update__bits_br_mask[1], s1_update__bits_btb_mispredicts[1] ? 29'h0 : s1_update_idx[35:7]};
  wire [29:0]  _GEN_3 = {s1_update__bits_br_mask[2], s1_update__bits_btb_mispredicts[2] ? 29'h0 : s1_update_idx[35:7]};
  wire [29:0]  _GEN_4 = {s1_update__bits_br_mask[3], s1_update__bits_btb_mispredicts[3] ? 29'h0 : s1_update_idx[35:7]};
  wire [3:0]   _GEN_5 = doing_reset ? 4'hF : (s1_update_wbtb_mask | s1_update__bits_br_mask) & ({4{s1_update__valid & ~(_s1_update_wmeta_mask_T_1 | (|s1_update__bits_btb_mispredicts))}} | {4{s1_update__valid}} & s1_update__bits_btb_mispredicts);
  assign _GEN_109 = _GEN_5[0];
  assign _GEN_110 = _GEN_5[1];
  assign _GEN_111 = _GEN_5[2];
  assign _GEN_112 = _GEN_5[3];
  assign _GEN_135 = doing_reset | s1_update__bits_meta[0];
  assign _GEN_136 = _GEN_0[0];
  assign _GEN_137 = _GEN_0[1];
  assign _GEN_138 = _GEN_0[2];
  assign _GEN_139 = _GEN_0[3];
  assign _GEN_145 = _GEN_5[0];
  assign _GEN_146 = _GEN_5[1];
  assign _GEN_147 = _GEN_5[2];
  assign _GEN_148 = _GEN_5[3];
  wire         alloc_way =
    s1_idx[7] ^ s1_idx[8] ^ s1_idx[9] ^ s1_idx[10] ^ s1_idx[11] ^ s1_idx[12] ^ s1_idx[13] ^ s1_idx[14] ^ s1_idx[15] ^ s1_idx[16] ^ s1_idx[17] ^ s1_idx[18] ^ s1_idx[19] ^ s1_idx[20] ^ s1_idx[21] ^ s1_idx[22] ^ s1_idx[23] ^ s1_idx[24] ^ s1_idx[25] ^ s1_idx[26] ^ s1_idx[27] ^ s1_idx[28] ^ s1_idx[29] ^ s1_idx[30] ^ s1_idx[31] ^ s1_idx[32] ^ s1_idx[33] ^ s1_idx[34] ^ s1_idx[35] ^ _meta_0_0_ext_R0_data[0] ^ _meta_0_0_ext_R0_data[1] ^ _meta_0_0_ext_R0_data[2] ^ _meta_0_0_ext_R0_data[3] ^ _meta_0_0_ext_R0_data[4] ^ _meta_0_0_ext_R0_data[5] ^ _meta_0_0_ext_R0_data[6] ^ _meta_0_0_ext_R0_data[7] ^ _meta_0_0_ext_R0_data[8] ^ _meta_0_0_ext_R0_data[9] ^ _meta_0_0_ext_R0_data[10] ^ _meta_0_0_ext_R0_data[11] ^ _meta_0_0_ext_R0_data[12] ^ _meta_0_0_ext_R0_data[13] ^ _meta_0_0_ext_R0_data[14] ^ _meta_0_0_ext_R0_data[15] ^ _meta_0_0_ext_R0_data[16] ^ _meta_0_0_ext_R0_data[17] ^ _meta_0_0_ext_R0_data[18] ^ _meta_0_0_ext_R0_data[19] ^ _meta_0_0_ext_R0_data[20] ^ _meta_0_0_ext_R0_data[21] ^ _meta_0_0_ext_R0_data[22] ^ _meta_0_0_ext_R0_data[23] ^ _meta_0_0_ext_R0_data[24] ^ _meta_0_0_ext_R0_data[25] ^ _meta_0_0_ext_R0_data[26] ^ _meta_0_0_ext_R0_data[27] ^ _meta_0_0_ext_R0_data[28] ^ _meta_0_1_ext_R0_data[0] ^ _meta_0_1_ext_R0_data[1] ^ _meta_0_1_ext_R0_data[2] ^ _meta_0_1_ext_R0_data[3] ^ _meta_0_1_ext_R0_data[4] ^ _meta_0_1_ext_R0_data[5] ^ _meta_0_1_ext_R0_data[6] ^ _meta_0_1_ext_R0_data[7] ^ _meta_0_1_ext_R0_data[8] ^ _meta_0_1_ext_R0_data[9] ^ _meta_0_1_ext_R0_data[10] ^ _meta_0_1_ext_R0_data[11] ^ _meta_0_1_ext_R0_data[12] ^ _meta_0_1_ext_R0_data[13] ^ _meta_0_1_ext_R0_data[14] ^ _meta_0_1_ext_R0_data[15] ^ _meta_0_1_ext_R0_data[16] ^ _meta_0_1_ext_R0_data[17] ^ _meta_0_1_ext_R0_data[18] ^ _meta_0_1_ext_R0_data[19] ^ _meta_0_1_ext_R0_data[20] ^ _meta_0_1_ext_R0_data[21] ^ _meta_0_1_ext_R0_data[22] ^ _meta_0_1_ext_R0_data[23] ^ _meta_0_1_ext_R0_data[24] ^ _meta_0_1_ext_R0_data[25] ^ _meta_0_1_ext_R0_data[26] ^ _meta_0_1_ext_R0_data[27] ^ _meta_0_1_ext_R0_data[28] ^ _meta_0_2_ext_R0_data[0] ^ _meta_0_2_ext_R0_data[1]
    ^ _meta_0_2_ext_R0_data[2] ^ _meta_0_2_ext_R0_data[3] ^ _meta_0_2_ext_R0_data[4] ^ _meta_0_2_ext_R0_data[5] ^ _meta_0_2_ext_R0_data[6] ^ _meta_0_2_ext_R0_data[7] ^ _meta_0_2_ext_R0_data[8] ^ _meta_0_2_ext_R0_data[9] ^ _meta_0_2_ext_R0_data[10] ^ _meta_0_2_ext_R0_data[11] ^ _meta_0_2_ext_R0_data[12] ^ _meta_0_2_ext_R0_data[13] ^ _meta_0_2_ext_R0_data[14] ^ _meta_0_2_ext_R0_data[15] ^ _meta_0_2_ext_R0_data[16] ^ _meta_0_2_ext_R0_data[17] ^ _meta_0_2_ext_R0_data[18] ^ _meta_0_2_ext_R0_data[19] ^ _meta_0_2_ext_R0_data[20] ^ _meta_0_2_ext_R0_data[21] ^ _meta_0_2_ext_R0_data[22] ^ _meta_0_2_ext_R0_data[23] ^ _meta_0_2_ext_R0_data[24] ^ _meta_0_2_ext_R0_data[25] ^ _meta_0_2_ext_R0_data[26] ^ _meta_0_2_ext_R0_data[27] ^ _meta_0_2_ext_R0_data[28] ^ _meta_0_3_ext_R0_data[0] ^ _meta_0_3_ext_R0_data[1] ^ _meta_0_3_ext_R0_data[2] ^ _meta_0_3_ext_R0_data[3] ^ _meta_0_3_ext_R0_data[4] ^ _meta_0_3_ext_R0_data[5] ^ _meta_0_3_ext_R0_data[6] ^ _meta_0_3_ext_R0_data[7] ^ _meta_0_3_ext_R0_data[8] ^ _meta_0_3_ext_R0_data[9] ^ _meta_0_3_ext_R0_data[10] ^ _meta_0_3_ext_R0_data[11] ^ _meta_0_3_ext_R0_data[12] ^ _meta_0_3_ext_R0_data[13] ^ _meta_0_3_ext_R0_data[14] ^ _meta_0_3_ext_R0_data[15] ^ _meta_0_3_ext_R0_data[16] ^ _meta_0_3_ext_R0_data[17] ^ _meta_0_3_ext_R0_data[18] ^ _meta_0_3_ext_R0_data[19] ^ _meta_0_3_ext_R0_data[20] ^ _meta_0_3_ext_R0_data[21] ^ _meta_0_3_ext_R0_data[22] ^ _meta_0_3_ext_R0_data[23] ^ _meta_0_3_ext_R0_data[24] ^ _meta_0_3_ext_R0_data[25] ^ _meta_0_3_ext_R0_data[26] ^ _meta_0_3_ext_R0_data[27] ^ _meta_0_3_ext_R0_data[28] ^ _meta_1_0_ext_R0_data[0] ^ _meta_1_0_ext_R0_data[1] ^ _meta_1_0_ext_R0_data[2] ^ _meta_1_0_ext_R0_data[3] ^ _meta_1_0_ext_R0_data[4] ^ _meta_1_0_ext_R0_data[5] ^ _meta_1_0_ext_R0_data[6] ^ _meta_1_0_ext_R0_data[7] ^ _meta_1_0_ext_R0_data[8] ^ _meta_1_0_ext_R0_data[9] ^ _meta_1_0_ext_R0_data[10] ^ _meta_1_0_ext_R0_data[11] ^ _meta_1_0_ext_R0_data[12] ^ _meta_1_0_ext_R0_data[13] ^ _meta_1_0_ext_R0_data[14] ^ _meta_1_0_ext_R0_data[15] ^ _meta_1_0_ext_R0_data[16] ^ _meta_1_0_ext_R0_data[17]
    ^ _meta_1_0_ext_R0_data[18] ^ _meta_1_0_ext_R0_data[19] ^ _meta_1_0_ext_R0_data[20] ^ _meta_1_0_ext_R0_data[21] ^ _meta_1_0_ext_R0_data[22] ^ _meta_1_0_ext_R0_data[23] ^ _meta_1_0_ext_R0_data[24] ^ _meta_1_0_ext_R0_data[25] ^ _meta_1_0_ext_R0_data[26] ^ _meta_1_0_ext_R0_data[27] ^ _meta_1_0_ext_R0_data[28] ^ _meta_1_1_ext_R0_data[0] ^ _meta_1_1_ext_R0_data[1] ^ _meta_1_1_ext_R0_data[2] ^ _meta_1_1_ext_R0_data[3] ^ _meta_1_1_ext_R0_data[4] ^ _meta_1_1_ext_R0_data[5] ^ _meta_1_1_ext_R0_data[6] ^ _meta_1_1_ext_R0_data[7] ^ _meta_1_1_ext_R0_data[8] ^ _meta_1_1_ext_R0_data[9] ^ _meta_1_1_ext_R0_data[10] ^ _meta_1_1_ext_R0_data[11] ^ _meta_1_1_ext_R0_data[12] ^ _meta_1_1_ext_R0_data[13] ^ _meta_1_1_ext_R0_data[14] ^ _meta_1_1_ext_R0_data[15] ^ _meta_1_1_ext_R0_data[16] ^ _meta_1_1_ext_R0_data[17] ^ _meta_1_1_ext_R0_data[18] ^ _meta_1_1_ext_R0_data[19] ^ _meta_1_1_ext_R0_data[20] ^ _meta_1_1_ext_R0_data[21] ^ _meta_1_1_ext_R0_data[22] ^ _meta_1_1_ext_R0_data[23] ^ _meta_1_1_ext_R0_data[24] ^ _meta_1_1_ext_R0_data[25] ^ _meta_1_1_ext_R0_data[26] ^ _meta_1_1_ext_R0_data[27] ^ _meta_1_1_ext_R0_data[28] ^ _meta_1_2_ext_R0_data[0] ^ _meta_1_2_ext_R0_data[1] ^ _meta_1_2_ext_R0_data[2] ^ _meta_1_2_ext_R0_data[3] ^ _meta_1_2_ext_R0_data[4] ^ _meta_1_2_ext_R0_data[5] ^ _meta_1_2_ext_R0_data[6] ^ _meta_1_2_ext_R0_data[7] ^ _meta_1_2_ext_R0_data[8] ^ _meta_1_2_ext_R0_data[9] ^ _meta_1_2_ext_R0_data[10] ^ _meta_1_2_ext_R0_data[11] ^ _meta_1_2_ext_R0_data[12] ^ _meta_1_2_ext_R0_data[13] ^ _meta_1_2_ext_R0_data[14] ^ _meta_1_2_ext_R0_data[15] ^ _meta_1_2_ext_R0_data[16] ^ _meta_1_2_ext_R0_data[17] ^ _meta_1_2_ext_R0_data[18] ^ _meta_1_2_ext_R0_data[19] ^ _meta_1_2_ext_R0_data[20] ^ _meta_1_2_ext_R0_data[21] ^ _meta_1_2_ext_R0_data[22] ^ _meta_1_2_ext_R0_data[23] ^ _meta_1_2_ext_R0_data[24] ^ _meta_1_2_ext_R0_data[25] ^ _meta_1_2_ext_R0_data[26] ^ _meta_1_2_ext_R0_data[27] ^ _meta_1_2_ext_R0_data[28] ^ _meta_1_3_ext_R0_data[0] ^ _meta_1_3_ext_R0_data[1] ^ _meta_1_3_ext_R0_data[2] ^ _meta_1_3_ext_R0_data[3]
    ^ _meta_1_3_ext_R0_data[4] ^ _meta_1_3_ext_R0_data[5] ^ _meta_1_3_ext_R0_data[6] ^ _meta_1_3_ext_R0_data[7] ^ _meta_1_3_ext_R0_data[8] ^ _meta_1_3_ext_R0_data[9] ^ _meta_1_3_ext_R0_data[10] ^ _meta_1_3_ext_R0_data[11] ^ _meta_1_3_ext_R0_data[12] ^ _meta_1_3_ext_R0_data[13] ^ _meta_1_3_ext_R0_data[14] ^ _meta_1_3_ext_R0_data[15] ^ _meta_1_3_ext_R0_data[16] ^ _meta_1_3_ext_R0_data[17] ^ _meta_1_3_ext_R0_data[18] ^ _meta_1_3_ext_R0_data[19] ^ _meta_1_3_ext_R0_data[20] ^ _meta_1_3_ext_R0_data[21] ^ _meta_1_3_ext_R0_data[22] ^ _meta_1_3_ext_R0_data[23] ^ _meta_1_3_ext_R0_data[24] ^ _meta_1_3_ext_R0_data[25] ^ _meta_1_3_ext_R0_data[26] ^ _meta_1_3_ext_R0_data[27] ^ _meta_1_3_ext_R0_data[28];
  wire         s1_hit_ohs_0_0 = _meta_0_0_ext_R0_data[28:0] == s1_idx[35:7];
  wire         s1_hit_ohs_1_0 = _meta_0_1_ext_R0_data[28:0] == s1_idx[35:7];
  wire         s1_hit_ohs_2_0 = _meta_0_2_ext_R0_data[28:0] == s1_idx[35:7];
  wire         s1_hit_ohs_3_0 = _meta_0_3_ext_R0_data[28:0] == s1_idx[35:7];
  wire         s1_hits_0 = s1_hit_ohs_0_0 | _meta_1_0_ext_R0_data[28:0] == s1_idx[35:7];
  wire         s1_hits_1 = s1_hit_ohs_1_0 | _meta_1_1_ext_R0_data[28:0] == s1_idx[35:7];
  wire         s1_hits_2 = s1_hit_ohs_2_0 | _meta_1_2_ext_R0_data[28:0] == s1_idx[35:7];
  wire         s1_hits_3 = s1_hit_ohs_3_0 | _meta_1_3_ext_R0_data[28:0] == s1_idx[35:7];
  wire         s1_resp_0_valid = ~doing_reset & s1_valid & s1_hits_0;
  wire         _s1_req_rmeta_s1_hit_ways_0_0_is_br_0 = s1_hit_ohs_0_0 ? _meta_0_0_ext_R0_data[29] : _meta_1_0_ext_R0_data[29];
  wire         s1_is_jal_0 = ~doing_reset & s1_resp_0_valid & ~_s1_req_rmeta_s1_hit_ways_0_0_is_br_0;
  wire         s1_resp_1_valid = ~doing_reset & s1_valid & s1_hits_1;
  wire         _s1_req_rmeta_s1_hit_ways_1_1_is_br_0 = s1_hit_ohs_1_0 ? _meta_0_1_ext_R0_data[29] : _meta_1_1_ext_R0_data[29];
  wire         s1_is_jal_1 = ~doing_reset & s1_resp_1_valid & ~_s1_req_rmeta_s1_hit_ways_1_1_is_br_0;
  wire         s1_resp_2_valid = ~doing_reset & s1_valid & s1_hits_2;
  wire         _s1_req_rmeta_s1_hit_ways_2_2_is_br_0 = s1_hit_ohs_2_0 ? _meta_0_2_ext_R0_data[29] : _meta_1_2_ext_R0_data[29];
  wire         s1_is_jal_2 = ~doing_reset & s1_resp_2_valid & ~_s1_req_rmeta_s1_hit_ways_2_2_is_br_0;
  wire         s1_resp_3_valid = ~doing_reset & s1_valid & s1_hits_3;
  wire         _s1_req_rmeta_s1_hit_ways_3_3_is_br_0 = s1_hit_ohs_3_0 ? _meta_0_3_ext_R0_data[29] : _meta_1_3_ext_R0_data[29];
  wire         s1_is_jal_3 = ~doing_reset & s1_resp_3_valid & ~_s1_req_rmeta_s1_hit_ways_3_3_is_br_0;
  wire [12:0]  _s1_req_rbtb_s1_hit_ways_0_0_offset = s1_hit_ohs_0_0 ? _btb_0_0_ext_R0_data[13:1] : _btb_1_0_ext_R0_data[13:1];
  wire [12:0]  _s1_req_rbtb_s1_hit_ways_1_1_offset = s1_hit_ohs_1_0 ? _btb_0_1_ext_R0_data[13:1] : _btb_1_1_ext_R0_data[13:1];
  wire [12:0]  _s1_req_rbtb_s1_hit_ways_2_2_offset = s1_hit_ohs_2_0 ? _btb_0_2_ext_R0_data[13:1] : _btb_1_2_ext_R0_data[13:1];
  wire [12:0]  _s1_req_rbtb_s1_hit_ways_3_3_offset = s1_hit_ohs_3_0 ? _btb_0_3_ext_R0_data[13:1] : _btb_1_3_ext_R0_data[13:1];
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
    s1_update__bits_target <= io_update_bits_target;
    s1_update__bits_meta <= io_update_bits_meta;
    s1_update_idx <= io_update_bits_pc[39:4];
    if (s1_hits_0 | s1_hits_1 | s1_hits_2 | s1_hits_3)
      f3_meta_REG_write_way <= ~(s1_hit_ohs_0_0 | s1_hit_ohs_1_0 | s1_hit_ohs_2_0 | s1_hit_ohs_3_0);
    else
      f3_meta_REG_write_way <= alloc_way;
    f3_meta_write_way <= f3_meta_REG_write_way;
    REG <= s1_hits_0;
    io_resp_f2_0_predicted_pc_REG_valid <= s1_resp_0_valid;
    if (s1_hit_ohs_0_0 ? _btb_0_0_ext_R0_data[0] : _btb_1_0_ext_R0_data[0])
      io_resp_f2_0_predicted_pc_REG_bits <= _ebtb_ext_R0_data;
    else
      io_resp_f2_0_predicted_pc_REG_bits <= s1_pc + {{27{_s1_req_rbtb_s1_hit_ways_0_0_offset[12]}}, _s1_req_rbtb_s1_hit_ways_0_0_offset};
    io_resp_f2_0_is_br_REG <= ~doing_reset & s1_resp_0_valid & _s1_req_rmeta_s1_hit_ways_0_0_is_br_0;
    io_resp_f2_0_is_jal_REG <= s1_is_jal_0;
    REG_1 <= s1_is_jal_0;
    REG_2 <= s1_hits_0;
    REG_3 <= REG_2;
    if (REG) begin
      io_resp_f3_0_predicted_pc_REG_valid <= io_resp_f2_0_predicted_pc_REG_valid;
      io_resp_f3_0_predicted_pc_REG_bits <= io_resp_f2_0_predicted_pc_REG_bits;
    end
    else begin
      io_resp_f3_0_predicted_pc_REG_valid <= io_resp_in_0_f2_0_predicted_pc_valid;
      io_resp_f3_0_predicted_pc_REG_bits <= io_resp_in_0_f2_0_predicted_pc_bits;
    end
    REG_4 <= s1_is_jal_0;
    REG_5 <= REG_4;
    REG_6 <= s1_hits_1;
    io_resp_f2_1_predicted_pc_REG_valid <= s1_resp_1_valid;
    if (s1_hit_ohs_1_0 ? _btb_0_1_ext_R0_data[0] : _btb_1_1_ext_R0_data[0])
      io_resp_f2_1_predicted_pc_REG_bits <= _ebtb_ext_R0_data;
    else
      io_resp_f2_1_predicted_pc_REG_bits <= s1_pc + {{27{_s1_req_rbtb_s1_hit_ways_1_1_offset[12]}}, _s1_req_rbtb_s1_hit_ways_1_1_offset} + 40'h2;
    io_resp_f2_1_is_br_REG <= ~doing_reset & s1_resp_1_valid & _s1_req_rmeta_s1_hit_ways_1_1_is_br_0;
    io_resp_f2_1_is_jal_REG <= s1_is_jal_1;
    REG_7 <= s1_is_jal_1;
    REG_8 <= s1_hits_1;
    REG_9 <= REG_8;
    if (REG_6) begin
      io_resp_f3_1_predicted_pc_REG_valid <= io_resp_f2_1_predicted_pc_REG_valid;
      io_resp_f3_1_predicted_pc_REG_bits <= io_resp_f2_1_predicted_pc_REG_bits;
    end
    else begin
      io_resp_f3_1_predicted_pc_REG_valid <= io_resp_in_0_f2_1_predicted_pc_valid;
      io_resp_f3_1_predicted_pc_REG_bits <= io_resp_in_0_f2_1_predicted_pc_bits;
    end
    REG_10 <= s1_is_jal_1;
    REG_11 <= REG_10;
    REG_12 <= s1_hits_2;
    io_resp_f2_2_predicted_pc_REG_valid <= s1_resp_2_valid;
    if (s1_hit_ohs_2_0 ? _btb_0_2_ext_R0_data[0] : _btb_1_2_ext_R0_data[0])
      io_resp_f2_2_predicted_pc_REG_bits <= _ebtb_ext_R0_data;
    else
      io_resp_f2_2_predicted_pc_REG_bits <= s1_pc + {{27{_s1_req_rbtb_s1_hit_ways_2_2_offset[12]}}, _s1_req_rbtb_s1_hit_ways_2_2_offset} + 40'h4;
    io_resp_f2_2_is_br_REG <= ~doing_reset & s1_resp_2_valid & _s1_req_rmeta_s1_hit_ways_2_2_is_br_0;
    io_resp_f2_2_is_jal_REG <= s1_is_jal_2;
    REG_13 <= s1_is_jal_2;
    REG_14 <= s1_hits_2;
    REG_15 <= REG_14;
    if (REG_12) begin
      io_resp_f3_2_predicted_pc_REG_valid <= io_resp_f2_2_predicted_pc_REG_valid;
      io_resp_f3_2_predicted_pc_REG_bits <= io_resp_f2_2_predicted_pc_REG_bits;
    end
    else begin
      io_resp_f3_2_predicted_pc_REG_valid <= io_resp_in_0_f2_2_predicted_pc_valid;
      io_resp_f3_2_predicted_pc_REG_bits <= io_resp_in_0_f2_2_predicted_pc_bits;
    end
    REG_16 <= s1_is_jal_2;
    REG_17 <= REG_16;
    REG_18 <= s1_hits_3;
    io_resp_f2_3_predicted_pc_REG_valid <= s1_resp_3_valid;
    if (s1_hit_ohs_3_0 ? _btb_0_3_ext_R0_data[0] : _btb_1_3_ext_R0_data[0])
      io_resp_f2_3_predicted_pc_REG_bits <= _ebtb_ext_R0_data;
    else
      io_resp_f2_3_predicted_pc_REG_bits <= s1_pc + {{27{_s1_req_rbtb_s1_hit_ways_3_3_offset[12]}}, _s1_req_rbtb_s1_hit_ways_3_3_offset} + 40'h6;
    io_resp_f2_3_is_br_REG <= ~doing_reset & s1_resp_3_valid & _s1_req_rmeta_s1_hit_ways_3_3_is_br_0;
    io_resp_f2_3_is_jal_REG <= s1_is_jal_3;
    REG_19 <= s1_is_jal_3;
    REG_20 <= s1_hits_3;
    REG_21 <= REG_20;
    if (REG_18) begin
      io_resp_f3_3_predicted_pc_REG_valid <= io_resp_f2_3_predicted_pc_REG_valid;
      io_resp_f3_3_predicted_pc_REG_bits <= io_resp_f2_3_predicted_pc_REG_bits;
    end
    else begin
      io_resp_f3_3_predicted_pc_REG_valid <= io_resp_in_0_f2_3_predicted_pc_valid;
      io_resp_f3_3_predicted_pc_REG_bits <= io_resp_in_0_f2_3_predicted_pc_bits;
    end
    REG_22 <= s1_is_jal_3;
    REG_23 <= REG_22;
    if (reset) begin
      doing_reset <= 1'h1;
      reset_idx <= 7'h0;
    end
    else begin
      doing_reset <= reset_idx != 7'h7F & doing_reset;
      reset_idx <= reset_idx + {6'h0, doing_reset};
    end
  end // always @(posedge)
  meta_128x30 meta_0_0_ext (
    .R0_addr (io_f0_pc[10:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_97),
    .W0_en   (_GEN_99 & _GEN_109),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 30'h0 : _GEN_1),
    .R0_data (_meta_0_0_ext_R0_data)
  );
  meta_128x30 meta_0_1_ext (
    .R0_addr (io_f0_pc[10:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_97),
    .W0_en   (_GEN_99 & _GEN_110),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 30'h0 : _GEN_2),
    .R0_data (_meta_0_1_ext_R0_data)
  );
  meta_128x30 meta_0_2_ext (
    .R0_addr (io_f0_pc[10:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_97),
    .W0_en   (_GEN_99 & _GEN_111),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 30'h0 : _GEN_3),
    .R0_data (_meta_0_2_ext_R0_data)
  );
  meta_128x30 meta_0_3_ext (
    .R0_addr (io_f0_pc[10:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_97),
    .W0_en   (_GEN_99 & _GEN_112),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 30'h0 : _GEN_4),
    .R0_data (_meta_0_3_ext_R0_data)
  );
  meta_128x30 meta_1_0_ext (
    .R0_addr (io_f0_pc[10:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_97),
    .W0_en   (_GEN_135 & _GEN_145),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 30'h0 : _GEN_1),
    .R0_data (_meta_1_0_ext_R0_data)
  );
  meta_128x30 meta_1_1_ext (
    .R0_addr (io_f0_pc[10:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_97),
    .W0_en   (_GEN_135 & _GEN_146),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 30'h0 : _GEN_2),
    .R0_data (_meta_1_1_ext_R0_data)
  );
  meta_128x30 meta_1_2_ext (
    .R0_addr (io_f0_pc[10:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_97),
    .W0_en   (_GEN_135 & _GEN_147),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 30'h0 : _GEN_3),
    .R0_data (_meta_1_2_ext_R0_data)
  );
  meta_128x30 meta_1_3_ext (
    .R0_addr (io_f0_pc[10:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_97),
    .W0_en   (_GEN_135 & _GEN_148),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 30'h0 : _GEN_4),
    .R0_data (_meta_1_3_ext_R0_data)
  );
  btb_128x14 btb_0_0_ext (
    .R0_addr (io_f0_pc[10:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_97),
    .W0_en   (_GEN_99 & _GEN_100),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 14'h0 : _GEN),
    .R0_data (_btb_0_0_ext_R0_data)
  );
  btb_128x14 btb_0_1_ext (
    .R0_addr (io_f0_pc[10:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_97),
    .W0_en   (_GEN_99 & _GEN_101),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 14'h0 : _GEN),
    .R0_data (_btb_0_1_ext_R0_data)
  );
  btb_128x14 btb_0_2_ext (
    .R0_addr (io_f0_pc[10:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_97),
    .W0_en   (_GEN_99 & _GEN_102),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 14'h0 : _GEN),
    .R0_data (_btb_0_2_ext_R0_data)
  );
  btb_128x14 btb_0_3_ext (
    .R0_addr (io_f0_pc[10:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_97),
    .W0_en   (_GEN_99 & _GEN_103),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 14'h0 : _GEN),
    .R0_data (_btb_0_3_ext_R0_data)
  );
  btb_128x14 btb_1_0_ext (
    .R0_addr (io_f0_pc[10:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_97),
    .W0_en   (_GEN_135 & _GEN_136),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 14'h0 : _GEN),
    .R0_data (_btb_1_0_ext_R0_data)
  );
  btb_128x14 btb_1_1_ext (
    .R0_addr (io_f0_pc[10:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_97),
    .W0_en   (_GEN_135 & _GEN_137),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 14'h0 : _GEN),
    .R0_data (_btb_1_1_ext_R0_data)
  );
  btb_128x14 btb_1_2_ext (
    .R0_addr (io_f0_pc[10:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_97),
    .W0_en   (_GEN_135 & _GEN_138),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 14'h0 : _GEN),
    .R0_data (_btb_1_2_ext_R0_data)
  );
  btb_128x14 btb_1_3_ext (
    .R0_addr (io_f0_pc[10:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_97),
    .W0_en   (_GEN_135 & _GEN_139),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 14'h0 : _GEN),
    .R0_data (_btb_1_3_ext_R0_data)
  );
  ebtb_128x40 ebtb_ext (
    .R0_addr (io_f0_pc[10:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (s1_update_idx[6:0]),
    .W0_en   ((|s1_update_wbtb_mask) & offset_is_extended),
    .W0_clk  (clock),
    .W0_data (s1_update__bits_target),
    .R0_data (_ebtb_ext_R0_data)
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
  assign io_resp_f2_0_taken = REG & REG_1 | io_resp_in_0_f2_0_taken;
  assign io_resp_f2_0_is_br = REG ? io_resp_f2_0_is_br_REG : io_resp_in_0_f2_0_is_br;
  assign io_resp_f2_0_is_jal = REG ? io_resp_f2_0_is_jal_REG : io_resp_in_0_f2_0_is_jal;
  assign io_resp_f2_0_predicted_pc_valid = REG ? io_resp_f2_0_predicted_pc_REG_valid : io_resp_in_0_f2_0_predicted_pc_valid;
  assign io_resp_f2_0_predicted_pc_bits = REG ? io_resp_f2_0_predicted_pc_REG_bits : io_resp_in_0_f2_0_predicted_pc_bits;
  assign io_resp_f2_1_taken = REG_6 & REG_7 | io_resp_in_0_f2_1_taken;
  assign io_resp_f2_1_is_br = REG_6 ? io_resp_f2_1_is_br_REG : io_resp_in_0_f2_1_is_br;
  assign io_resp_f2_1_is_jal = REG_6 ? io_resp_f2_1_is_jal_REG : io_resp_in_0_f2_1_is_jal;
  assign io_resp_f2_1_predicted_pc_valid = REG_6 ? io_resp_f2_1_predicted_pc_REG_valid : io_resp_in_0_f2_1_predicted_pc_valid;
  assign io_resp_f2_1_predicted_pc_bits = REG_6 ? io_resp_f2_1_predicted_pc_REG_bits : io_resp_in_0_f2_1_predicted_pc_bits;
  assign io_resp_f2_2_taken = REG_12 & REG_13 | io_resp_in_0_f2_2_taken;
  assign io_resp_f2_2_is_br = REG_12 ? io_resp_f2_2_is_br_REG : io_resp_in_0_f2_2_is_br;
  assign io_resp_f2_2_is_jal = REG_12 ? io_resp_f2_2_is_jal_REG : io_resp_in_0_f2_2_is_jal;
  assign io_resp_f2_2_predicted_pc_valid = REG_12 ? io_resp_f2_2_predicted_pc_REG_valid : io_resp_in_0_f2_2_predicted_pc_valid;
  assign io_resp_f2_2_predicted_pc_bits = REG_12 ? io_resp_f2_2_predicted_pc_REG_bits : io_resp_in_0_f2_2_predicted_pc_bits;
  assign io_resp_f2_3_taken = REG_18 & REG_19 | io_resp_in_0_f2_3_taken;
  assign io_resp_f2_3_is_br = REG_18 ? io_resp_f2_3_is_br_REG : io_resp_in_0_f2_3_is_br;
  assign io_resp_f2_3_is_jal = REG_18 ? io_resp_f2_3_is_jal_REG : io_resp_in_0_f2_3_is_jal;
  assign io_resp_f2_3_predicted_pc_valid = REG_18 ? io_resp_f2_3_predicted_pc_REG_valid : io_resp_in_0_f2_3_predicted_pc_valid;
  assign io_resp_f2_3_predicted_pc_bits = REG_18 ? io_resp_f2_3_predicted_pc_REG_bits : io_resp_in_0_f2_3_predicted_pc_bits;
  assign io_resp_f3_0_taken = REG_3 & REG_5 | io_resp_in_0_f3_0_taken;
  assign io_resp_f3_0_predicted_pc_valid = REG_3 ? io_resp_f3_0_predicted_pc_REG_valid : io_resp_in_0_f3_0_predicted_pc_valid;
  assign io_resp_f3_0_predicted_pc_bits = REG_3 ? io_resp_f3_0_predicted_pc_REG_bits : io_resp_in_0_f3_0_predicted_pc_bits;
  assign io_resp_f3_1_taken = REG_9 & REG_11 | io_resp_in_0_f3_1_taken;
  assign io_resp_f3_1_predicted_pc_valid = REG_9 ? io_resp_f3_1_predicted_pc_REG_valid : io_resp_in_0_f3_1_predicted_pc_valid;
  assign io_resp_f3_1_predicted_pc_bits = REG_9 ? io_resp_f3_1_predicted_pc_REG_bits : io_resp_in_0_f3_1_predicted_pc_bits;
  assign io_resp_f3_2_taken = REG_15 & REG_17 | io_resp_in_0_f3_2_taken;
  assign io_resp_f3_2_predicted_pc_valid = REG_15 ? io_resp_f3_2_predicted_pc_REG_valid : io_resp_in_0_f3_2_predicted_pc_valid;
  assign io_resp_f3_2_predicted_pc_bits = REG_15 ? io_resp_f3_2_predicted_pc_REG_bits : io_resp_in_0_f3_2_predicted_pc_bits;
  assign io_resp_f3_3_taken = REG_21 & REG_23 | io_resp_in_0_f3_3_taken;
  assign io_resp_f3_3_predicted_pc_valid = REG_21 ? io_resp_f3_3_predicted_pc_REG_valid : io_resp_in_0_f3_3_predicted_pc_valid;
  assign io_resp_f3_3_predicted_pc_bits = REG_21 ? io_resp_f3_3_predicted_pc_REG_bits : io_resp_in_0_f3_3_predicted_pc_bits;
  assign io_f3_meta = {119'h0, f3_meta_write_way};
endmodule

