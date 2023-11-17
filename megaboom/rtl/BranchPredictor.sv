// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BranchPredictor(
  input          clock,
                 reset,
                 io_f0_req_valid,
  input  [39:0]  io_f0_req_bits_pc,
  input  [63:0]  io_f0_req_bits_ghist_old_history,
  input          io_f0_req_bits_ghist_new_saw_branch_not_taken,
                 io_f0_req_bits_ghist_new_saw_branch_taken,
                 io_f3_fire,
                 io_update_valid,
                 io_update_bits_is_mispredict_update,
                 io_update_bits_is_repair_update,
  input  [7:0]   io_update_bits_btb_mispredicts,
  input  [39:0]  io_update_bits_pc,
  input  [7:0]   io_update_bits_br_mask,
  input          io_update_bits_cfi_idx_valid,
  input  [2:0]   io_update_bits_cfi_idx_bits,
  input          io_update_bits_cfi_taken,
                 io_update_bits_cfi_mispredicted,
                 io_update_bits_cfi_is_br,
                 io_update_bits_cfi_is_jal,
  input  [63:0]  io_update_bits_ghist_old_history,
  input          io_update_bits_ghist_new_saw_branch_not_taken,
                 io_update_bits_ghist_new_saw_branch_taken,
  input  [39:0]  io_update_bits_target,
  input  [119:0] io_update_bits_meta_0,
                 io_update_bits_meta_1,
  output         io_resp_f1_preds_0_taken,
                 io_resp_f1_preds_0_is_br,
                 io_resp_f1_preds_0_is_jal,
                 io_resp_f1_preds_0_predicted_pc_valid,
  output [39:0]  io_resp_f1_preds_0_predicted_pc_bits,
  output         io_resp_f1_preds_1_taken,
                 io_resp_f1_preds_1_is_br,
                 io_resp_f1_preds_1_is_jal,
                 io_resp_f1_preds_1_predicted_pc_valid,
  output [39:0]  io_resp_f1_preds_1_predicted_pc_bits,
  output         io_resp_f1_preds_2_taken,
                 io_resp_f1_preds_2_is_br,
                 io_resp_f1_preds_2_is_jal,
                 io_resp_f1_preds_2_predicted_pc_valid,
  output [39:0]  io_resp_f1_preds_2_predicted_pc_bits,
  output         io_resp_f1_preds_3_taken,
                 io_resp_f1_preds_3_is_br,
                 io_resp_f1_preds_3_is_jal,
                 io_resp_f1_preds_3_predicted_pc_valid,
  output [39:0]  io_resp_f1_preds_3_predicted_pc_bits,
  output         io_resp_f1_preds_4_taken,
                 io_resp_f1_preds_4_is_br,
                 io_resp_f1_preds_4_is_jal,
                 io_resp_f1_preds_4_predicted_pc_valid,
  output [39:0]  io_resp_f1_preds_4_predicted_pc_bits,
  output         io_resp_f1_preds_5_taken,
                 io_resp_f1_preds_5_is_br,
                 io_resp_f1_preds_5_is_jal,
                 io_resp_f1_preds_5_predicted_pc_valid,
  output [39:0]  io_resp_f1_preds_5_predicted_pc_bits,
  output         io_resp_f1_preds_6_taken,
                 io_resp_f1_preds_6_is_br,
                 io_resp_f1_preds_6_is_jal,
                 io_resp_f1_preds_6_predicted_pc_valid,
  output [39:0]  io_resp_f1_preds_6_predicted_pc_bits,
  output         io_resp_f1_preds_7_taken,
                 io_resp_f1_preds_7_is_br,
                 io_resp_f1_preds_7_is_jal,
                 io_resp_f1_preds_7_predicted_pc_valid,
  output [39:0]  io_resp_f1_preds_7_predicted_pc_bits,
  output         io_resp_f2_preds_0_taken,
                 io_resp_f2_preds_0_is_br,
                 io_resp_f2_preds_0_is_jal,
                 io_resp_f2_preds_0_predicted_pc_valid,
  output [39:0]  io_resp_f2_preds_0_predicted_pc_bits,
  output         io_resp_f2_preds_1_taken,
                 io_resp_f2_preds_1_is_br,
                 io_resp_f2_preds_1_is_jal,
                 io_resp_f2_preds_1_predicted_pc_valid,
  output [39:0]  io_resp_f2_preds_1_predicted_pc_bits,
  output         io_resp_f2_preds_2_taken,
                 io_resp_f2_preds_2_is_br,
                 io_resp_f2_preds_2_is_jal,
                 io_resp_f2_preds_2_predicted_pc_valid,
  output [39:0]  io_resp_f2_preds_2_predicted_pc_bits,
  output         io_resp_f2_preds_3_taken,
                 io_resp_f2_preds_3_is_br,
                 io_resp_f2_preds_3_is_jal,
                 io_resp_f2_preds_3_predicted_pc_valid,
  output [39:0]  io_resp_f2_preds_3_predicted_pc_bits,
  output         io_resp_f2_preds_4_taken,
                 io_resp_f2_preds_4_is_br,
                 io_resp_f2_preds_4_is_jal,
                 io_resp_f2_preds_4_predicted_pc_valid,
  output [39:0]  io_resp_f2_preds_4_predicted_pc_bits,
  output         io_resp_f2_preds_5_taken,
                 io_resp_f2_preds_5_is_br,
                 io_resp_f2_preds_5_is_jal,
                 io_resp_f2_preds_5_predicted_pc_valid,
  output [39:0]  io_resp_f2_preds_5_predicted_pc_bits,
  output         io_resp_f2_preds_6_taken,
                 io_resp_f2_preds_6_is_br,
                 io_resp_f2_preds_6_is_jal,
                 io_resp_f2_preds_6_predicted_pc_valid,
  output [39:0]  io_resp_f2_preds_6_predicted_pc_bits,
  output         io_resp_f2_preds_7_taken,
                 io_resp_f2_preds_7_is_br,
                 io_resp_f2_preds_7_is_jal,
                 io_resp_f2_preds_7_predicted_pc_valid,
  output [39:0]  io_resp_f2_preds_7_predicted_pc_bits,
                 io_resp_f3_pc,
  output         io_resp_f3_preds_0_taken,
                 io_resp_f3_preds_0_predicted_pc_valid,
  output [39:0]  io_resp_f3_preds_0_predicted_pc_bits,
  output         io_resp_f3_preds_1_taken,
                 io_resp_f3_preds_1_predicted_pc_valid,
  output [39:0]  io_resp_f3_preds_1_predicted_pc_bits,
  output         io_resp_f3_preds_2_taken,
                 io_resp_f3_preds_2_predicted_pc_valid,
  output [39:0]  io_resp_f3_preds_2_predicted_pc_bits,
  output         io_resp_f3_preds_3_taken,
                 io_resp_f3_preds_3_predicted_pc_valid,
  output [39:0]  io_resp_f3_preds_3_predicted_pc_bits,
  output         io_resp_f3_preds_4_taken,
                 io_resp_f3_preds_4_predicted_pc_valid,
  output [39:0]  io_resp_f3_preds_4_predicted_pc_bits,
  output         io_resp_f3_preds_5_taken,
                 io_resp_f3_preds_5_predicted_pc_valid,
  output [39:0]  io_resp_f3_preds_5_predicted_pc_bits,
  output         io_resp_f3_preds_6_taken,
                 io_resp_f3_preds_6_predicted_pc_valid,
  output [39:0]  io_resp_f3_preds_6_predicted_pc_bits,
  output         io_resp_f3_preds_7_taken,
                 io_resp_f3_preds_7_predicted_pc_valid,
  output [39:0]  io_resp_f3_preds_7_predicted_pc_bits,
  output [119:0] io_resp_f3_meta_0,
                 io_resp_f3_meta_1
);

  reg  [39:0] io_resp_f3_pc_REG;
  reg  [39:0] io_resp_f2_pc_REG;
  reg  [39:0] io_resp_f1_pc_REG;
  wire        _banked_predictors_1_io_resp_f1_0_taken;
  wire        _banked_predictors_1_io_resp_f1_0_is_br;
  wire        _banked_predictors_1_io_resp_f1_0_is_jal;
  wire        _banked_predictors_1_io_resp_f1_0_predicted_pc_valid;
  wire [39:0] _banked_predictors_1_io_resp_f1_0_predicted_pc_bits;
  wire        _banked_predictors_1_io_resp_f1_1_taken;
  wire        _banked_predictors_1_io_resp_f1_1_is_br;
  wire        _banked_predictors_1_io_resp_f1_1_is_jal;
  wire        _banked_predictors_1_io_resp_f1_1_predicted_pc_valid;
  wire [39:0] _banked_predictors_1_io_resp_f1_1_predicted_pc_bits;
  wire        _banked_predictors_1_io_resp_f1_2_taken;
  wire        _banked_predictors_1_io_resp_f1_2_is_br;
  wire        _banked_predictors_1_io_resp_f1_2_is_jal;
  wire        _banked_predictors_1_io_resp_f1_2_predicted_pc_valid;
  wire [39:0] _banked_predictors_1_io_resp_f1_2_predicted_pc_bits;
  wire        _banked_predictors_1_io_resp_f1_3_taken;
  wire        _banked_predictors_1_io_resp_f1_3_is_br;
  wire        _banked_predictors_1_io_resp_f1_3_is_jal;
  wire        _banked_predictors_1_io_resp_f1_3_predicted_pc_valid;
  wire [39:0] _banked_predictors_1_io_resp_f1_3_predicted_pc_bits;
  wire        _banked_predictors_1_io_resp_f2_0_taken;
  wire        _banked_predictors_1_io_resp_f2_0_is_br;
  wire        _banked_predictors_1_io_resp_f2_0_is_jal;
  wire        _banked_predictors_1_io_resp_f2_0_predicted_pc_valid;
  wire [39:0] _banked_predictors_1_io_resp_f2_0_predicted_pc_bits;
  wire        _banked_predictors_1_io_resp_f2_1_taken;
  wire        _banked_predictors_1_io_resp_f2_1_is_br;
  wire        _banked_predictors_1_io_resp_f2_1_is_jal;
  wire        _banked_predictors_1_io_resp_f2_1_predicted_pc_valid;
  wire [39:0] _banked_predictors_1_io_resp_f2_1_predicted_pc_bits;
  wire        _banked_predictors_1_io_resp_f2_2_taken;
  wire        _banked_predictors_1_io_resp_f2_2_is_br;
  wire        _banked_predictors_1_io_resp_f2_2_is_jal;
  wire        _banked_predictors_1_io_resp_f2_2_predicted_pc_valid;
  wire [39:0] _banked_predictors_1_io_resp_f2_2_predicted_pc_bits;
  wire        _banked_predictors_1_io_resp_f2_3_taken;
  wire        _banked_predictors_1_io_resp_f2_3_is_br;
  wire        _banked_predictors_1_io_resp_f2_3_is_jal;
  wire        _banked_predictors_1_io_resp_f2_3_predicted_pc_valid;
  wire [39:0] _banked_predictors_1_io_resp_f2_3_predicted_pc_bits;
  wire        _banked_predictors_1_io_resp_f3_0_taken;
  wire        _banked_predictors_1_io_resp_f3_0_predicted_pc_valid;
  wire [39:0] _banked_predictors_1_io_resp_f3_0_predicted_pc_bits;
  wire        _banked_predictors_1_io_resp_f3_1_taken;
  wire        _banked_predictors_1_io_resp_f3_1_predicted_pc_valid;
  wire [39:0] _banked_predictors_1_io_resp_f3_1_predicted_pc_bits;
  wire        _banked_predictors_1_io_resp_f3_2_taken;
  wire        _banked_predictors_1_io_resp_f3_2_predicted_pc_valid;
  wire [39:0] _banked_predictors_1_io_resp_f3_2_predicted_pc_bits;
  wire        _banked_predictors_1_io_resp_f3_3_taken;
  wire        _banked_predictors_1_io_resp_f3_3_predicted_pc_valid;
  wire [39:0] _banked_predictors_1_io_resp_f3_3_predicted_pc_bits;
  wire        _banked_predictors_0_io_resp_f1_0_taken;
  wire        _banked_predictors_0_io_resp_f1_0_is_br;
  wire        _banked_predictors_0_io_resp_f1_0_is_jal;
  wire        _banked_predictors_0_io_resp_f1_0_predicted_pc_valid;
  wire [39:0] _banked_predictors_0_io_resp_f1_0_predicted_pc_bits;
  wire        _banked_predictors_0_io_resp_f1_1_taken;
  wire        _banked_predictors_0_io_resp_f1_1_is_br;
  wire        _banked_predictors_0_io_resp_f1_1_is_jal;
  wire        _banked_predictors_0_io_resp_f1_1_predicted_pc_valid;
  wire [39:0] _banked_predictors_0_io_resp_f1_1_predicted_pc_bits;
  wire        _banked_predictors_0_io_resp_f1_2_taken;
  wire        _banked_predictors_0_io_resp_f1_2_is_br;
  wire        _banked_predictors_0_io_resp_f1_2_is_jal;
  wire        _banked_predictors_0_io_resp_f1_2_predicted_pc_valid;
  wire [39:0] _banked_predictors_0_io_resp_f1_2_predicted_pc_bits;
  wire        _banked_predictors_0_io_resp_f1_3_taken;
  wire        _banked_predictors_0_io_resp_f1_3_is_br;
  wire        _banked_predictors_0_io_resp_f1_3_is_jal;
  wire        _banked_predictors_0_io_resp_f1_3_predicted_pc_valid;
  wire [39:0] _banked_predictors_0_io_resp_f1_3_predicted_pc_bits;
  wire        _banked_predictors_0_io_resp_f2_0_taken;
  wire        _banked_predictors_0_io_resp_f2_0_is_br;
  wire        _banked_predictors_0_io_resp_f2_0_is_jal;
  wire        _banked_predictors_0_io_resp_f2_0_predicted_pc_valid;
  wire [39:0] _banked_predictors_0_io_resp_f2_0_predicted_pc_bits;
  wire        _banked_predictors_0_io_resp_f2_1_taken;
  wire        _banked_predictors_0_io_resp_f2_1_is_br;
  wire        _banked_predictors_0_io_resp_f2_1_is_jal;
  wire        _banked_predictors_0_io_resp_f2_1_predicted_pc_valid;
  wire [39:0] _banked_predictors_0_io_resp_f2_1_predicted_pc_bits;
  wire        _banked_predictors_0_io_resp_f2_2_taken;
  wire        _banked_predictors_0_io_resp_f2_2_is_br;
  wire        _banked_predictors_0_io_resp_f2_2_is_jal;
  wire        _banked_predictors_0_io_resp_f2_2_predicted_pc_valid;
  wire [39:0] _banked_predictors_0_io_resp_f2_2_predicted_pc_bits;
  wire        _banked_predictors_0_io_resp_f2_3_taken;
  wire        _banked_predictors_0_io_resp_f2_3_is_br;
  wire        _banked_predictors_0_io_resp_f2_3_is_jal;
  wire        _banked_predictors_0_io_resp_f2_3_predicted_pc_valid;
  wire [39:0] _banked_predictors_0_io_resp_f2_3_predicted_pc_bits;
  wire        _banked_predictors_0_io_resp_f3_0_taken;
  wire        _banked_predictors_0_io_resp_f3_0_predicted_pc_valid;
  wire [39:0] _banked_predictors_0_io_resp_f3_0_predicted_pc_bits;
  wire        _banked_predictors_0_io_resp_f3_1_taken;
  wire        _banked_predictors_0_io_resp_f3_1_predicted_pc_valid;
  wire [39:0] _banked_predictors_0_io_resp_f3_1_predicted_pc_bits;
  wire        _banked_predictors_0_io_resp_f3_2_taken;
  wire        _banked_predictors_0_io_resp_f3_2_predicted_pc_valid;
  wire [39:0] _banked_predictors_0_io_resp_f3_2_predicted_pc_bits;
  wire        _banked_predictors_0_io_resp_f3_3_taken;
  wire        _banked_predictors_0_io_resp_f3_3_predicted_pc_valid;
  wire [39:0] _banked_predictors_0_io_resp_f3_3_predicted_pc_bits;
  wire [10:0] _banked_predictors_0_io_f0_mask_T = 11'hFF << io_f0_req_bits_pc[2:1];
  wire [39:0] _GEN = {io_f0_req_bits_pc[39:3], 3'h0};
  wire [10:0] _banked_predictors_1_io_f0_mask_T_1 = 11'hFF << io_f0_req_bits_pc[2:1];
  wire        _GEN_4 = (~(io_f0_req_bits_pc[3]) | io_f0_req_bits_pc[5:3] != 3'h7) & io_f0_req_valid;
  reg         REG;
  reg  [63:0] banked_predictors_0_io_f1_ghist_REG;
  reg  [64:0] banked_predictors_1_io_f1_ghist_REG;
  reg  [64:0] banked_predictors_0_io_f1_ghist_REG_1;
  reg  [63:0] banked_predictors_1_io_f1_ghist_REG_1;
  reg         b0_fire_REG;
  reg         b0_fire_REG_1;
  reg         b0_fire_REG_2;
  reg         b1_fire_REG;
  reg         b1_fire_REG_1;
  reg         b1_fire_REG_2;
  wire [39:0] _GEN_0 = {io_update_bits_pc[39:3], 3'h0};
  wire [63:0] _GEN_1 = {io_update_bits_ghist_old_history[62:0], 1'h0};
  wire [63:0] _GEN_2 = {io_update_bits_ghist_old_history[62:0], 1'h1};
  wire [64:0] _banked_predictors_0_io_f1_ghist_T_2 = {io_f0_req_bits_ghist_old_history, 1'h0};
  wire [64:0] _GEN_3 = {1'h0, io_f0_req_bits_ghist_old_history};
  always @(posedge clock) begin
    REG <= ~(io_f0_req_bits_pc[3]);
    banked_predictors_0_io_f1_ghist_REG <= io_f0_req_bits_ghist_old_history;
    if (io_f0_req_bits_ghist_new_saw_branch_taken) begin
      banked_predictors_1_io_f1_ghist_REG <= {io_f0_req_bits_ghist_old_history, 1'h1};
      banked_predictors_0_io_f1_ghist_REG_1 <= {io_f0_req_bits_ghist_old_history, 1'h1};
    end
    else if (io_f0_req_bits_ghist_new_saw_branch_not_taken) begin
      banked_predictors_1_io_f1_ghist_REG <= _banked_predictors_0_io_f1_ghist_T_2;
      banked_predictors_0_io_f1_ghist_REG_1 <= _banked_predictors_0_io_f1_ghist_T_2;
    end
    else begin
      banked_predictors_1_io_f1_ghist_REG <= _GEN_3;
      banked_predictors_0_io_f1_ghist_REG_1 <= _GEN_3;
    end
    banked_predictors_1_io_f1_ghist_REG_1 <= io_f0_req_bits_ghist_old_history;
    b0_fire_REG <= _GEN_4;
    b0_fire_REG_1 <= b0_fire_REG;
    b0_fire_REG_2 <= b0_fire_REG_1;
    b1_fire_REG <= io_f0_req_valid;
    b1_fire_REG_1 <= b1_fire_REG;
    b1_fire_REG_2 <= b1_fire_REG_1;
    io_resp_f1_pc_REG <= io_f0_req_bits_pc;
    io_resp_f2_pc_REG <= io_resp_f1_pc_REG;
    io_resp_f3_pc_REG <= io_resp_f2_pc_REG;
  end // always @(posedge)
  ComposedBranchPredictorBank banked_predictors_0 (
    .clock                               (clock),
    .reset                               (reset),
    .io_f0_valid                         (_GEN_4),
    .io_f0_pc                            (io_f0_req_bits_pc[3] ? _GEN + 40'h8 : {io_f0_req_bits_pc[39:3], 3'h0}),
    .io_f0_mask                          (io_f0_req_bits_pc[3] ? 4'hF : _banked_predictors_0_io_f0_mask_T[3:0]),
    .io_f1_ghist                         (REG ? banked_predictors_0_io_f1_ghist_REG : banked_predictors_0_io_f1_ghist_REG_1[63:0]),
    .io_f3_fire                          (io_f3_fire & b0_fire_REG_2),
    .io_update_valid                     ((~(io_update_bits_pc[3]) | io_update_bits_pc[5:3] != 3'h7 & (~io_update_bits_cfi_idx_valid | io_update_bits_cfi_idx_bits[2])) & io_update_valid),
    .io_update_bits_is_mispredict_update (io_update_bits_is_mispredict_update),
    .io_update_bits_is_repair_update     (io_update_bits_is_repair_update),
    .io_update_bits_btb_mispredicts      (io_update_bits_pc[3] ? io_update_bits_btb_mispredicts[7:4] : io_update_bits_btb_mispredicts[3:0]),
    .io_update_bits_pc                   (io_update_bits_pc[3] ? _GEN_0 + 40'h8 : {io_update_bits_pc[39:3], 3'h0}),
    .io_update_bits_br_mask              (io_update_bits_pc[3] ? io_update_bits_br_mask[7:4] : io_update_bits_br_mask[3:0]),
    .io_update_bits_cfi_idx_valid        (io_update_bits_pc[3] ? io_update_bits_cfi_idx_valid & io_update_bits_cfi_idx_bits[2] : io_update_bits_cfi_idx_valid & ~(io_update_bits_cfi_idx_bits[2])),
    .io_update_bits_cfi_idx_bits         (io_update_bits_cfi_idx_bits[1:0]),
    .io_update_bits_cfi_taken            (io_update_bits_cfi_taken),
    .io_update_bits_cfi_mispredicted     (io_update_bits_cfi_mispredicted),
    .io_update_bits_cfi_is_br            (io_update_bits_cfi_is_br),
    .io_update_bits_cfi_is_jal           (io_update_bits_cfi_is_jal),
    .io_update_bits_ghist                (io_update_bits_pc[3] ? (io_update_bits_ghist_new_saw_branch_taken ? _GEN_2 : io_update_bits_ghist_new_saw_branch_not_taken ? _GEN_1 : io_update_bits_ghist_old_history) : io_update_bits_ghist_old_history),
    .io_update_bits_target               (io_update_bits_target),
    .io_update_bits_meta                 (io_update_bits_meta_0),
    .io_resp_f1_0_taken                  (_banked_predictors_0_io_resp_f1_0_taken),
    .io_resp_f1_0_is_br                  (_banked_predictors_0_io_resp_f1_0_is_br),
    .io_resp_f1_0_is_jal                 (_banked_predictors_0_io_resp_f1_0_is_jal),
    .io_resp_f1_0_predicted_pc_valid     (_banked_predictors_0_io_resp_f1_0_predicted_pc_valid),
    .io_resp_f1_0_predicted_pc_bits      (_banked_predictors_0_io_resp_f1_0_predicted_pc_bits),
    .io_resp_f1_1_taken                  (_banked_predictors_0_io_resp_f1_1_taken),
    .io_resp_f1_1_is_br                  (_banked_predictors_0_io_resp_f1_1_is_br),
    .io_resp_f1_1_is_jal                 (_banked_predictors_0_io_resp_f1_1_is_jal),
    .io_resp_f1_1_predicted_pc_valid     (_banked_predictors_0_io_resp_f1_1_predicted_pc_valid),
    .io_resp_f1_1_predicted_pc_bits      (_banked_predictors_0_io_resp_f1_1_predicted_pc_bits),
    .io_resp_f1_2_taken                  (_banked_predictors_0_io_resp_f1_2_taken),
    .io_resp_f1_2_is_br                  (_banked_predictors_0_io_resp_f1_2_is_br),
    .io_resp_f1_2_is_jal                 (_banked_predictors_0_io_resp_f1_2_is_jal),
    .io_resp_f1_2_predicted_pc_valid     (_banked_predictors_0_io_resp_f1_2_predicted_pc_valid),
    .io_resp_f1_2_predicted_pc_bits      (_banked_predictors_0_io_resp_f1_2_predicted_pc_bits),
    .io_resp_f1_3_taken                  (_banked_predictors_0_io_resp_f1_3_taken),
    .io_resp_f1_3_is_br                  (_banked_predictors_0_io_resp_f1_3_is_br),
    .io_resp_f1_3_is_jal                 (_banked_predictors_0_io_resp_f1_3_is_jal),
    .io_resp_f1_3_predicted_pc_valid     (_banked_predictors_0_io_resp_f1_3_predicted_pc_valid),
    .io_resp_f1_3_predicted_pc_bits      (_banked_predictors_0_io_resp_f1_3_predicted_pc_bits),
    .io_resp_f2_0_taken                  (_banked_predictors_0_io_resp_f2_0_taken),
    .io_resp_f2_0_is_br                  (_banked_predictors_0_io_resp_f2_0_is_br),
    .io_resp_f2_0_is_jal                 (_banked_predictors_0_io_resp_f2_0_is_jal),
    .io_resp_f2_0_predicted_pc_valid     (_banked_predictors_0_io_resp_f2_0_predicted_pc_valid),
    .io_resp_f2_0_predicted_pc_bits      (_banked_predictors_0_io_resp_f2_0_predicted_pc_bits),
    .io_resp_f2_1_taken                  (_banked_predictors_0_io_resp_f2_1_taken),
    .io_resp_f2_1_is_br                  (_banked_predictors_0_io_resp_f2_1_is_br),
    .io_resp_f2_1_is_jal                 (_banked_predictors_0_io_resp_f2_1_is_jal),
    .io_resp_f2_1_predicted_pc_valid     (_banked_predictors_0_io_resp_f2_1_predicted_pc_valid),
    .io_resp_f2_1_predicted_pc_bits      (_banked_predictors_0_io_resp_f2_1_predicted_pc_bits),
    .io_resp_f2_2_taken                  (_banked_predictors_0_io_resp_f2_2_taken),
    .io_resp_f2_2_is_br                  (_banked_predictors_0_io_resp_f2_2_is_br),
    .io_resp_f2_2_is_jal                 (_banked_predictors_0_io_resp_f2_2_is_jal),
    .io_resp_f2_2_predicted_pc_valid     (_banked_predictors_0_io_resp_f2_2_predicted_pc_valid),
    .io_resp_f2_2_predicted_pc_bits      (_banked_predictors_0_io_resp_f2_2_predicted_pc_bits),
    .io_resp_f2_3_taken                  (_banked_predictors_0_io_resp_f2_3_taken),
    .io_resp_f2_3_is_br                  (_banked_predictors_0_io_resp_f2_3_is_br),
    .io_resp_f2_3_is_jal                 (_banked_predictors_0_io_resp_f2_3_is_jal),
    .io_resp_f2_3_predicted_pc_valid     (_banked_predictors_0_io_resp_f2_3_predicted_pc_valid),
    .io_resp_f2_3_predicted_pc_bits      (_banked_predictors_0_io_resp_f2_3_predicted_pc_bits),
    .io_resp_f3_0_taken                  (_banked_predictors_0_io_resp_f3_0_taken),
    .io_resp_f3_0_predicted_pc_valid     (_banked_predictors_0_io_resp_f3_0_predicted_pc_valid),
    .io_resp_f3_0_predicted_pc_bits      (_banked_predictors_0_io_resp_f3_0_predicted_pc_bits),
    .io_resp_f3_1_taken                  (_banked_predictors_0_io_resp_f3_1_taken),
    .io_resp_f3_1_predicted_pc_valid     (_banked_predictors_0_io_resp_f3_1_predicted_pc_valid),
    .io_resp_f3_1_predicted_pc_bits      (_banked_predictors_0_io_resp_f3_1_predicted_pc_bits),
    .io_resp_f3_2_taken                  (_banked_predictors_0_io_resp_f3_2_taken),
    .io_resp_f3_2_predicted_pc_valid     (_banked_predictors_0_io_resp_f3_2_predicted_pc_valid),
    .io_resp_f3_2_predicted_pc_bits      (_banked_predictors_0_io_resp_f3_2_predicted_pc_bits),
    .io_resp_f3_3_taken                  (_banked_predictors_0_io_resp_f3_3_taken),
    .io_resp_f3_3_predicted_pc_valid     (_banked_predictors_0_io_resp_f3_3_predicted_pc_valid),
    .io_resp_f3_3_predicted_pc_bits      (_banked_predictors_0_io_resp_f3_3_predicted_pc_bits),
    .io_f3_meta                          (io_resp_f3_meta_0)
  );
  ComposedBranchPredictorBank banked_predictors_1 (
    .clock                               (clock),
    .reset                               (reset),
    .io_f0_valid                         (io_f0_req_valid),
    .io_f0_pc                            (io_f0_req_bits_pc[3] ? {io_f0_req_bits_pc[39:3], 3'h0} : _GEN + 40'h8),
    .io_f0_mask                          (io_f0_req_bits_pc[3] ? _banked_predictors_1_io_f0_mask_T_1[3:0] : 4'hF),
    .io_f1_ghist                         (REG ? banked_predictors_1_io_f1_ghist_REG[63:0] : banked_predictors_1_io_f1_ghist_REG_1),
    .io_f3_fire                          (io_f3_fire & b1_fire_REG_2),
    .io_update_valid                     ((io_update_bits_pc[3] | ~io_update_bits_cfi_idx_valid | io_update_bits_cfi_idx_bits[2]) & io_update_valid),
    .io_update_bits_is_mispredict_update (io_update_bits_is_mispredict_update),
    .io_update_bits_is_repair_update     (io_update_bits_is_repair_update),
    .io_update_bits_btb_mispredicts      (io_update_bits_pc[3] ? io_update_bits_btb_mispredicts[3:0] : io_update_bits_btb_mispredicts[7:4]),
    .io_update_bits_pc                   (io_update_bits_pc[3] ? {io_update_bits_pc[39:3], 3'h0} : _GEN_0 + 40'h8),
    .io_update_bits_br_mask              (io_update_bits_pc[3] ? io_update_bits_br_mask[3:0] : io_update_bits_br_mask[7:4]),
    .io_update_bits_cfi_idx_valid        (io_update_bits_pc[3] ? io_update_bits_cfi_idx_valid & ~(io_update_bits_cfi_idx_bits[2]) : io_update_bits_cfi_idx_valid & io_update_bits_cfi_idx_bits[2]),
    .io_update_bits_cfi_idx_bits         (io_update_bits_cfi_idx_bits[1:0]),
    .io_update_bits_cfi_taken            (io_update_bits_cfi_taken),
    .io_update_bits_cfi_mispredicted     (io_update_bits_cfi_mispredicted),
    .io_update_bits_cfi_is_br            (io_update_bits_cfi_is_br),
    .io_update_bits_cfi_is_jal           (io_update_bits_cfi_is_jal),
    .io_update_bits_ghist                (io_update_bits_pc[3] ? io_update_bits_ghist_old_history : io_update_bits_ghist_new_saw_branch_taken ? _GEN_2 : io_update_bits_ghist_new_saw_branch_not_taken ? _GEN_1 : io_update_bits_ghist_old_history),
    .io_update_bits_target               (io_update_bits_target),
    .io_update_bits_meta                 (io_update_bits_meta_1),
    .io_resp_f1_0_taken                  (_banked_predictors_1_io_resp_f1_0_taken),
    .io_resp_f1_0_is_br                  (_banked_predictors_1_io_resp_f1_0_is_br),
    .io_resp_f1_0_is_jal                 (_banked_predictors_1_io_resp_f1_0_is_jal),
    .io_resp_f1_0_predicted_pc_valid     (_banked_predictors_1_io_resp_f1_0_predicted_pc_valid),
    .io_resp_f1_0_predicted_pc_bits      (_banked_predictors_1_io_resp_f1_0_predicted_pc_bits),
    .io_resp_f1_1_taken                  (_banked_predictors_1_io_resp_f1_1_taken),
    .io_resp_f1_1_is_br                  (_banked_predictors_1_io_resp_f1_1_is_br),
    .io_resp_f1_1_is_jal                 (_banked_predictors_1_io_resp_f1_1_is_jal),
    .io_resp_f1_1_predicted_pc_valid     (_banked_predictors_1_io_resp_f1_1_predicted_pc_valid),
    .io_resp_f1_1_predicted_pc_bits      (_banked_predictors_1_io_resp_f1_1_predicted_pc_bits),
    .io_resp_f1_2_taken                  (_banked_predictors_1_io_resp_f1_2_taken),
    .io_resp_f1_2_is_br                  (_banked_predictors_1_io_resp_f1_2_is_br),
    .io_resp_f1_2_is_jal                 (_banked_predictors_1_io_resp_f1_2_is_jal),
    .io_resp_f1_2_predicted_pc_valid     (_banked_predictors_1_io_resp_f1_2_predicted_pc_valid),
    .io_resp_f1_2_predicted_pc_bits      (_banked_predictors_1_io_resp_f1_2_predicted_pc_bits),
    .io_resp_f1_3_taken                  (_banked_predictors_1_io_resp_f1_3_taken),
    .io_resp_f1_3_is_br                  (_banked_predictors_1_io_resp_f1_3_is_br),
    .io_resp_f1_3_is_jal                 (_banked_predictors_1_io_resp_f1_3_is_jal),
    .io_resp_f1_3_predicted_pc_valid     (_banked_predictors_1_io_resp_f1_3_predicted_pc_valid),
    .io_resp_f1_3_predicted_pc_bits      (_banked_predictors_1_io_resp_f1_3_predicted_pc_bits),
    .io_resp_f2_0_taken                  (_banked_predictors_1_io_resp_f2_0_taken),
    .io_resp_f2_0_is_br                  (_banked_predictors_1_io_resp_f2_0_is_br),
    .io_resp_f2_0_is_jal                 (_banked_predictors_1_io_resp_f2_0_is_jal),
    .io_resp_f2_0_predicted_pc_valid     (_banked_predictors_1_io_resp_f2_0_predicted_pc_valid),
    .io_resp_f2_0_predicted_pc_bits      (_banked_predictors_1_io_resp_f2_0_predicted_pc_bits),
    .io_resp_f2_1_taken                  (_banked_predictors_1_io_resp_f2_1_taken),
    .io_resp_f2_1_is_br                  (_banked_predictors_1_io_resp_f2_1_is_br),
    .io_resp_f2_1_is_jal                 (_banked_predictors_1_io_resp_f2_1_is_jal),
    .io_resp_f2_1_predicted_pc_valid     (_banked_predictors_1_io_resp_f2_1_predicted_pc_valid),
    .io_resp_f2_1_predicted_pc_bits      (_banked_predictors_1_io_resp_f2_1_predicted_pc_bits),
    .io_resp_f2_2_taken                  (_banked_predictors_1_io_resp_f2_2_taken),
    .io_resp_f2_2_is_br                  (_banked_predictors_1_io_resp_f2_2_is_br),
    .io_resp_f2_2_is_jal                 (_banked_predictors_1_io_resp_f2_2_is_jal),
    .io_resp_f2_2_predicted_pc_valid     (_banked_predictors_1_io_resp_f2_2_predicted_pc_valid),
    .io_resp_f2_2_predicted_pc_bits      (_banked_predictors_1_io_resp_f2_2_predicted_pc_bits),
    .io_resp_f2_3_taken                  (_banked_predictors_1_io_resp_f2_3_taken),
    .io_resp_f2_3_is_br                  (_banked_predictors_1_io_resp_f2_3_is_br),
    .io_resp_f2_3_is_jal                 (_banked_predictors_1_io_resp_f2_3_is_jal),
    .io_resp_f2_3_predicted_pc_valid     (_banked_predictors_1_io_resp_f2_3_predicted_pc_valid),
    .io_resp_f2_3_predicted_pc_bits      (_banked_predictors_1_io_resp_f2_3_predicted_pc_bits),
    .io_resp_f3_0_taken                  (_banked_predictors_1_io_resp_f3_0_taken),
    .io_resp_f3_0_predicted_pc_valid     (_banked_predictors_1_io_resp_f3_0_predicted_pc_valid),
    .io_resp_f3_0_predicted_pc_bits      (_banked_predictors_1_io_resp_f3_0_predicted_pc_bits),
    .io_resp_f3_1_taken                  (_banked_predictors_1_io_resp_f3_1_taken),
    .io_resp_f3_1_predicted_pc_valid     (_banked_predictors_1_io_resp_f3_1_predicted_pc_valid),
    .io_resp_f3_1_predicted_pc_bits      (_banked_predictors_1_io_resp_f3_1_predicted_pc_bits),
    .io_resp_f3_2_taken                  (_banked_predictors_1_io_resp_f3_2_taken),
    .io_resp_f3_2_predicted_pc_valid     (_banked_predictors_1_io_resp_f3_2_predicted_pc_valid),
    .io_resp_f3_2_predicted_pc_bits      (_banked_predictors_1_io_resp_f3_2_predicted_pc_bits),
    .io_resp_f3_3_taken                  (_banked_predictors_1_io_resp_f3_3_taken),
    .io_resp_f3_3_predicted_pc_valid     (_banked_predictors_1_io_resp_f3_3_predicted_pc_valid),
    .io_resp_f3_3_predicted_pc_bits      (_banked_predictors_1_io_resp_f3_3_predicted_pc_bits),
    .io_f3_meta                          (io_resp_f3_meta_1)
  );
  assign io_resp_f1_preds_0_taken = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_0_taken : _banked_predictors_0_io_resp_f1_0_taken;
  assign io_resp_f1_preds_0_is_br = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_0_is_br : _banked_predictors_0_io_resp_f1_0_is_br;
  assign io_resp_f1_preds_0_is_jal = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_0_is_jal : _banked_predictors_0_io_resp_f1_0_is_jal;
  assign io_resp_f1_preds_0_predicted_pc_valid = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_0_predicted_pc_valid : _banked_predictors_0_io_resp_f1_0_predicted_pc_valid;
  assign io_resp_f1_preds_0_predicted_pc_bits = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_0_predicted_pc_bits : _banked_predictors_0_io_resp_f1_0_predicted_pc_bits;
  assign io_resp_f1_preds_1_taken = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_1_taken : _banked_predictors_0_io_resp_f1_1_taken;
  assign io_resp_f1_preds_1_is_br = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_1_is_br : _banked_predictors_0_io_resp_f1_1_is_br;
  assign io_resp_f1_preds_1_is_jal = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_1_is_jal : _banked_predictors_0_io_resp_f1_1_is_jal;
  assign io_resp_f1_preds_1_predicted_pc_valid = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_1_predicted_pc_valid : _banked_predictors_0_io_resp_f1_1_predicted_pc_valid;
  assign io_resp_f1_preds_1_predicted_pc_bits = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_1_predicted_pc_bits : _banked_predictors_0_io_resp_f1_1_predicted_pc_bits;
  assign io_resp_f1_preds_2_taken = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_2_taken : _banked_predictors_0_io_resp_f1_2_taken;
  assign io_resp_f1_preds_2_is_br = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_2_is_br : _banked_predictors_0_io_resp_f1_2_is_br;
  assign io_resp_f1_preds_2_is_jal = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_2_is_jal : _banked_predictors_0_io_resp_f1_2_is_jal;
  assign io_resp_f1_preds_2_predicted_pc_valid = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_2_predicted_pc_valid : _banked_predictors_0_io_resp_f1_2_predicted_pc_valid;
  assign io_resp_f1_preds_2_predicted_pc_bits = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_2_predicted_pc_bits : _banked_predictors_0_io_resp_f1_2_predicted_pc_bits;
  assign io_resp_f1_preds_3_taken = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_3_taken : _banked_predictors_0_io_resp_f1_3_taken;
  assign io_resp_f1_preds_3_is_br = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_3_is_br : _banked_predictors_0_io_resp_f1_3_is_br;
  assign io_resp_f1_preds_3_is_jal = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_3_is_jal : _banked_predictors_0_io_resp_f1_3_is_jal;
  assign io_resp_f1_preds_3_predicted_pc_valid = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_3_predicted_pc_valid : _banked_predictors_0_io_resp_f1_3_predicted_pc_valid;
  assign io_resp_f1_preds_3_predicted_pc_bits = io_resp_f1_pc_REG[3] ? _banked_predictors_1_io_resp_f1_3_predicted_pc_bits : _banked_predictors_0_io_resp_f1_3_predicted_pc_bits;
  assign io_resp_f1_preds_4_taken = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_0_taken : _banked_predictors_1_io_resp_f1_0_taken;
  assign io_resp_f1_preds_4_is_br = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_0_is_br : _banked_predictors_1_io_resp_f1_0_is_br;
  assign io_resp_f1_preds_4_is_jal = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_0_is_jal : _banked_predictors_1_io_resp_f1_0_is_jal;
  assign io_resp_f1_preds_4_predicted_pc_valid = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_0_predicted_pc_valid : _banked_predictors_1_io_resp_f1_0_predicted_pc_valid;
  assign io_resp_f1_preds_4_predicted_pc_bits = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_0_predicted_pc_bits : _banked_predictors_1_io_resp_f1_0_predicted_pc_bits;
  assign io_resp_f1_preds_5_taken = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_1_taken : _banked_predictors_1_io_resp_f1_1_taken;
  assign io_resp_f1_preds_5_is_br = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_1_is_br : _banked_predictors_1_io_resp_f1_1_is_br;
  assign io_resp_f1_preds_5_is_jal = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_1_is_jal : _banked_predictors_1_io_resp_f1_1_is_jal;
  assign io_resp_f1_preds_5_predicted_pc_valid = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_1_predicted_pc_valid : _banked_predictors_1_io_resp_f1_1_predicted_pc_valid;
  assign io_resp_f1_preds_5_predicted_pc_bits = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_1_predicted_pc_bits : _banked_predictors_1_io_resp_f1_1_predicted_pc_bits;
  assign io_resp_f1_preds_6_taken = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_2_taken : _banked_predictors_1_io_resp_f1_2_taken;
  assign io_resp_f1_preds_6_is_br = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_2_is_br : _banked_predictors_1_io_resp_f1_2_is_br;
  assign io_resp_f1_preds_6_is_jal = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_2_is_jal : _banked_predictors_1_io_resp_f1_2_is_jal;
  assign io_resp_f1_preds_6_predicted_pc_valid = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_2_predicted_pc_valid : _banked_predictors_1_io_resp_f1_2_predicted_pc_valid;
  assign io_resp_f1_preds_6_predicted_pc_bits = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_2_predicted_pc_bits : _banked_predictors_1_io_resp_f1_2_predicted_pc_bits;
  assign io_resp_f1_preds_7_taken = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_3_taken : _banked_predictors_1_io_resp_f1_3_taken;
  assign io_resp_f1_preds_7_is_br = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_3_is_br : _banked_predictors_1_io_resp_f1_3_is_br;
  assign io_resp_f1_preds_7_is_jal = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_3_is_jal : _banked_predictors_1_io_resp_f1_3_is_jal;
  assign io_resp_f1_preds_7_predicted_pc_valid = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_3_predicted_pc_valid : _banked_predictors_1_io_resp_f1_3_predicted_pc_valid;
  assign io_resp_f1_preds_7_predicted_pc_bits = io_resp_f1_pc_REG[3] ? _banked_predictors_0_io_resp_f1_3_predicted_pc_bits : _banked_predictors_1_io_resp_f1_3_predicted_pc_bits;
  assign io_resp_f2_preds_0_taken = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_0_taken : _banked_predictors_0_io_resp_f2_0_taken;
  assign io_resp_f2_preds_0_is_br = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_0_is_br : _banked_predictors_0_io_resp_f2_0_is_br;
  assign io_resp_f2_preds_0_is_jal = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_0_is_jal : _banked_predictors_0_io_resp_f2_0_is_jal;
  assign io_resp_f2_preds_0_predicted_pc_valid = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_0_predicted_pc_valid : _banked_predictors_0_io_resp_f2_0_predicted_pc_valid;
  assign io_resp_f2_preds_0_predicted_pc_bits = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_0_predicted_pc_bits : _banked_predictors_0_io_resp_f2_0_predicted_pc_bits;
  assign io_resp_f2_preds_1_taken = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_1_taken : _banked_predictors_0_io_resp_f2_1_taken;
  assign io_resp_f2_preds_1_is_br = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_1_is_br : _banked_predictors_0_io_resp_f2_1_is_br;
  assign io_resp_f2_preds_1_is_jal = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_1_is_jal : _banked_predictors_0_io_resp_f2_1_is_jal;
  assign io_resp_f2_preds_1_predicted_pc_valid = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_1_predicted_pc_valid : _banked_predictors_0_io_resp_f2_1_predicted_pc_valid;
  assign io_resp_f2_preds_1_predicted_pc_bits = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_1_predicted_pc_bits : _banked_predictors_0_io_resp_f2_1_predicted_pc_bits;
  assign io_resp_f2_preds_2_taken = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_2_taken : _banked_predictors_0_io_resp_f2_2_taken;
  assign io_resp_f2_preds_2_is_br = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_2_is_br : _banked_predictors_0_io_resp_f2_2_is_br;
  assign io_resp_f2_preds_2_is_jal = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_2_is_jal : _banked_predictors_0_io_resp_f2_2_is_jal;
  assign io_resp_f2_preds_2_predicted_pc_valid = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_2_predicted_pc_valid : _banked_predictors_0_io_resp_f2_2_predicted_pc_valid;
  assign io_resp_f2_preds_2_predicted_pc_bits = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_2_predicted_pc_bits : _banked_predictors_0_io_resp_f2_2_predicted_pc_bits;
  assign io_resp_f2_preds_3_taken = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_3_taken : _banked_predictors_0_io_resp_f2_3_taken;
  assign io_resp_f2_preds_3_is_br = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_3_is_br : _banked_predictors_0_io_resp_f2_3_is_br;
  assign io_resp_f2_preds_3_is_jal = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_3_is_jal : _banked_predictors_0_io_resp_f2_3_is_jal;
  assign io_resp_f2_preds_3_predicted_pc_valid = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_3_predicted_pc_valid : _banked_predictors_0_io_resp_f2_3_predicted_pc_valid;
  assign io_resp_f2_preds_3_predicted_pc_bits = io_resp_f2_pc_REG[3] ? _banked_predictors_1_io_resp_f2_3_predicted_pc_bits : _banked_predictors_0_io_resp_f2_3_predicted_pc_bits;
  assign io_resp_f2_preds_4_taken = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_0_taken : _banked_predictors_1_io_resp_f2_0_taken;
  assign io_resp_f2_preds_4_is_br = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_0_is_br : _banked_predictors_1_io_resp_f2_0_is_br;
  assign io_resp_f2_preds_4_is_jal = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_0_is_jal : _banked_predictors_1_io_resp_f2_0_is_jal;
  assign io_resp_f2_preds_4_predicted_pc_valid = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_0_predicted_pc_valid : _banked_predictors_1_io_resp_f2_0_predicted_pc_valid;
  assign io_resp_f2_preds_4_predicted_pc_bits = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_0_predicted_pc_bits : _banked_predictors_1_io_resp_f2_0_predicted_pc_bits;
  assign io_resp_f2_preds_5_taken = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_1_taken : _banked_predictors_1_io_resp_f2_1_taken;
  assign io_resp_f2_preds_5_is_br = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_1_is_br : _banked_predictors_1_io_resp_f2_1_is_br;
  assign io_resp_f2_preds_5_is_jal = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_1_is_jal : _banked_predictors_1_io_resp_f2_1_is_jal;
  assign io_resp_f2_preds_5_predicted_pc_valid = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_1_predicted_pc_valid : _banked_predictors_1_io_resp_f2_1_predicted_pc_valid;
  assign io_resp_f2_preds_5_predicted_pc_bits = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_1_predicted_pc_bits : _banked_predictors_1_io_resp_f2_1_predicted_pc_bits;
  assign io_resp_f2_preds_6_taken = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_2_taken : _banked_predictors_1_io_resp_f2_2_taken;
  assign io_resp_f2_preds_6_is_br = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_2_is_br : _banked_predictors_1_io_resp_f2_2_is_br;
  assign io_resp_f2_preds_6_is_jal = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_2_is_jal : _banked_predictors_1_io_resp_f2_2_is_jal;
  assign io_resp_f2_preds_6_predicted_pc_valid = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_2_predicted_pc_valid : _banked_predictors_1_io_resp_f2_2_predicted_pc_valid;
  assign io_resp_f2_preds_6_predicted_pc_bits = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_2_predicted_pc_bits : _banked_predictors_1_io_resp_f2_2_predicted_pc_bits;
  assign io_resp_f2_preds_7_taken = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_3_taken : _banked_predictors_1_io_resp_f2_3_taken;
  assign io_resp_f2_preds_7_is_br = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_3_is_br : _banked_predictors_1_io_resp_f2_3_is_br;
  assign io_resp_f2_preds_7_is_jal = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_3_is_jal : _banked_predictors_1_io_resp_f2_3_is_jal;
  assign io_resp_f2_preds_7_predicted_pc_valid = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_3_predicted_pc_valid : _banked_predictors_1_io_resp_f2_3_predicted_pc_valid;
  assign io_resp_f2_preds_7_predicted_pc_bits = io_resp_f2_pc_REG[3] ? _banked_predictors_0_io_resp_f2_3_predicted_pc_bits : _banked_predictors_1_io_resp_f2_3_predicted_pc_bits;
  assign io_resp_f3_pc = io_resp_f3_pc_REG;
  assign io_resp_f3_preds_0_taken = io_resp_f3_pc_REG[3] ? _banked_predictors_1_io_resp_f3_0_taken : _banked_predictors_0_io_resp_f3_0_taken;
  assign io_resp_f3_preds_0_predicted_pc_valid = io_resp_f3_pc_REG[3] ? _banked_predictors_1_io_resp_f3_0_predicted_pc_valid : _banked_predictors_0_io_resp_f3_0_predicted_pc_valid;
  assign io_resp_f3_preds_0_predicted_pc_bits = io_resp_f3_pc_REG[3] ? _banked_predictors_1_io_resp_f3_0_predicted_pc_bits : _banked_predictors_0_io_resp_f3_0_predicted_pc_bits;
  assign io_resp_f3_preds_1_taken = io_resp_f3_pc_REG[3] ? _banked_predictors_1_io_resp_f3_1_taken : _banked_predictors_0_io_resp_f3_1_taken;
  assign io_resp_f3_preds_1_predicted_pc_valid = io_resp_f3_pc_REG[3] ? _banked_predictors_1_io_resp_f3_1_predicted_pc_valid : _banked_predictors_0_io_resp_f3_1_predicted_pc_valid;
  assign io_resp_f3_preds_1_predicted_pc_bits = io_resp_f3_pc_REG[3] ? _banked_predictors_1_io_resp_f3_1_predicted_pc_bits : _banked_predictors_0_io_resp_f3_1_predicted_pc_bits;
  assign io_resp_f3_preds_2_taken = io_resp_f3_pc_REG[3] ? _banked_predictors_1_io_resp_f3_2_taken : _banked_predictors_0_io_resp_f3_2_taken;
  assign io_resp_f3_preds_2_predicted_pc_valid = io_resp_f3_pc_REG[3] ? _banked_predictors_1_io_resp_f3_2_predicted_pc_valid : _banked_predictors_0_io_resp_f3_2_predicted_pc_valid;
  assign io_resp_f3_preds_2_predicted_pc_bits = io_resp_f3_pc_REG[3] ? _banked_predictors_1_io_resp_f3_2_predicted_pc_bits : _banked_predictors_0_io_resp_f3_2_predicted_pc_bits;
  assign io_resp_f3_preds_3_taken = io_resp_f3_pc_REG[3] ? _banked_predictors_1_io_resp_f3_3_taken : _banked_predictors_0_io_resp_f3_3_taken;
  assign io_resp_f3_preds_3_predicted_pc_valid = io_resp_f3_pc_REG[3] ? _banked_predictors_1_io_resp_f3_3_predicted_pc_valid : _banked_predictors_0_io_resp_f3_3_predicted_pc_valid;
  assign io_resp_f3_preds_3_predicted_pc_bits = io_resp_f3_pc_REG[3] ? _banked_predictors_1_io_resp_f3_3_predicted_pc_bits : _banked_predictors_0_io_resp_f3_3_predicted_pc_bits;
  assign io_resp_f3_preds_4_taken = io_resp_f3_pc_REG[3] ? _banked_predictors_0_io_resp_f3_0_taken : _banked_predictors_1_io_resp_f3_0_taken;
  assign io_resp_f3_preds_4_predicted_pc_valid = io_resp_f3_pc_REG[3] ? _banked_predictors_0_io_resp_f3_0_predicted_pc_valid : _banked_predictors_1_io_resp_f3_0_predicted_pc_valid;
  assign io_resp_f3_preds_4_predicted_pc_bits = io_resp_f3_pc_REG[3] ? _banked_predictors_0_io_resp_f3_0_predicted_pc_bits : _banked_predictors_1_io_resp_f3_0_predicted_pc_bits;
  assign io_resp_f3_preds_5_taken = io_resp_f3_pc_REG[3] ? _banked_predictors_0_io_resp_f3_1_taken : _banked_predictors_1_io_resp_f3_1_taken;
  assign io_resp_f3_preds_5_predicted_pc_valid = io_resp_f3_pc_REG[3] ? _banked_predictors_0_io_resp_f3_1_predicted_pc_valid : _banked_predictors_1_io_resp_f3_1_predicted_pc_valid;
  assign io_resp_f3_preds_5_predicted_pc_bits = io_resp_f3_pc_REG[3] ? _banked_predictors_0_io_resp_f3_1_predicted_pc_bits : _banked_predictors_1_io_resp_f3_1_predicted_pc_bits;
  assign io_resp_f3_preds_6_taken = io_resp_f3_pc_REG[3] ? _banked_predictors_0_io_resp_f3_2_taken : _banked_predictors_1_io_resp_f3_2_taken;
  assign io_resp_f3_preds_6_predicted_pc_valid = io_resp_f3_pc_REG[3] ? _banked_predictors_0_io_resp_f3_2_predicted_pc_valid : _banked_predictors_1_io_resp_f3_2_predicted_pc_valid;
  assign io_resp_f3_preds_6_predicted_pc_bits = io_resp_f3_pc_REG[3] ? _banked_predictors_0_io_resp_f3_2_predicted_pc_bits : _banked_predictors_1_io_resp_f3_2_predicted_pc_bits;
  assign io_resp_f3_preds_7_taken = io_resp_f3_pc_REG[3] ? _banked_predictors_0_io_resp_f3_3_taken : _banked_predictors_1_io_resp_f3_3_taken;
  assign io_resp_f3_preds_7_predicted_pc_valid = io_resp_f3_pc_REG[3] ? _banked_predictors_0_io_resp_f3_3_predicted_pc_valid : _banked_predictors_1_io_resp_f3_3_predicted_pc_valid;
  assign io_resp_f3_preds_7_predicted_pc_bits = io_resp_f3_pc_REG[3] ? _banked_predictors_0_io_resp_f3_3_predicted_pc_bits : _banked_predictors_1_io_resp_f3_3_predicted_pc_bits;
endmodule

