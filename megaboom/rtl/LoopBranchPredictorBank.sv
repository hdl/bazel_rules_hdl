// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module LoopBranchPredictorBank(
  input          clock,
                 reset,
                 io_f0_valid,
  input  [39:0]  io_f0_pc,
  input  [3:0]   io_f0_mask,
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
  input          io_f3_fire,
                 io_update_valid,
                 io_update_bits_is_mispredict_update,
                 io_update_bits_is_repair_update,
  input  [39:0]  io_update_bits_pc,
  input  [3:0]   io_update_bits_br_mask,
  input          io_update_bits_cfi_mispredicted,
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

  wire [9:0]   _columns_3_io_f3_meta_s_cnt;
  wire [9:0]   _columns_2_io_f3_meta_s_cnt;
  wire [9:0]   _columns_1_io_f3_meta_s_cnt;
  wire [9:0]   _columns_0_io_f3_meta_s_cnt;
  reg  [35:0]  s1_idx;
  reg  [35:0]  s2_idx;
  reg          s1_valid;
  reg          s2_valid;
  reg          s3_valid;
  reg  [3:0]   s1_mask;
  reg  [3:0]   s2_mask;
  reg  [3:0]   s3_mask;
  reg          s1_update__valid;
  reg          s1_update__bits_is_mispredict_update;
  reg          s1_update__bits_is_repair_update;
  reg  [3:0]   s1_update__bits_br_mask;
  reg          s1_update__bits_cfi_mispredicted;
  reg  [119:0] s1_update__bits_meta;
  reg  [35:0]  s1_update_idx;
  reg          columns_0_io_f3_req_fire_REG;
  reg          columns_1_io_f3_req_fire_REG;
  reg          columns_2_io_f3_req_fire_REG;
  reg          columns_3_io_f3_req_fire_REG;
  always @(posedge clock) begin
    s1_idx <= io_f0_pc[39:4];
    s2_idx <= s1_idx;
    s1_valid <= io_f0_valid;
    s2_valid <= s1_valid;
    s3_valid <= s2_valid;
    s1_mask <= io_f0_mask;
    s2_mask <= s1_mask;
    s3_mask <= s2_mask;
    s1_update__valid <= io_update_valid;
    s1_update__bits_is_mispredict_update <= io_update_bits_is_mispredict_update;
    s1_update__bits_is_repair_update <= io_update_bits_is_repair_update;
    s1_update__bits_br_mask <= io_update_bits_br_mask;
    s1_update__bits_cfi_mispredicted <= io_update_bits_cfi_mispredicted;
    s1_update__bits_meta <= io_update_bits_meta;
    s1_update_idx <= io_update_bits_pc[39:4];
    columns_0_io_f3_req_fire_REG <= io_resp_in_0_f2_0_predicted_pc_valid & io_resp_in_0_f2_0_is_br;
    columns_1_io_f3_req_fire_REG <= io_resp_in_0_f2_1_predicted_pc_valid & io_resp_in_0_f2_1_is_br;
    columns_2_io_f3_req_fire_REG <= io_resp_in_0_f2_2_predicted_pc_valid & io_resp_in_0_f2_2_is_br;
    columns_3_io_f3_req_fire_REG <= io_resp_in_0_f2_3_predicted_pc_valid & io_resp_in_0_f2_3_is_br;
  end // always @(posedge)
  LoopBranchPredictorColumn columns_0 (
    .clock                (clock),
    .reset                (reset),
    .io_f2_req_idx        (s2_idx),
    .io_f3_req_fire       (s3_valid & s3_mask[0] & io_f3_fire & columns_0_io_f3_req_fire_REG),
    .io_f3_pred_in        (io_resp_in_0_f3_0_taken),
    .io_update_mispredict (s1_update__valid & s1_update__bits_br_mask[0] & s1_update__bits_is_mispredict_update & s1_update__bits_cfi_mispredicted),
    .io_update_repair     (s1_update__valid & s1_update__bits_br_mask[0] & s1_update__bits_is_repair_update),
    .io_update_idx        (s1_update_idx),
    .io_update_meta_s_cnt (s1_update__bits_meta[9:0]),
    .io_f3_pred           (io_resp_f3_0_taken),
    .io_f3_meta_s_cnt     (_columns_0_io_f3_meta_s_cnt)
  );
  LoopBranchPredictorColumn columns_1 (
    .clock                (clock),
    .reset                (reset),
    .io_f2_req_idx        (s2_idx),
    .io_f3_req_fire       (s3_valid & s3_mask[1] & io_f3_fire & columns_1_io_f3_req_fire_REG),
    .io_f3_pred_in        (io_resp_in_0_f3_1_taken),
    .io_update_mispredict (s1_update__valid & s1_update__bits_br_mask[1] & s1_update__bits_is_mispredict_update & s1_update__bits_cfi_mispredicted),
    .io_update_repair     (s1_update__valid & s1_update__bits_br_mask[1] & s1_update__bits_is_repair_update),
    .io_update_idx        (s1_update_idx),
    .io_update_meta_s_cnt (s1_update__bits_meta[19:10]),
    .io_f3_pred           (io_resp_f3_1_taken),
    .io_f3_meta_s_cnt     (_columns_1_io_f3_meta_s_cnt)
  );
  LoopBranchPredictorColumn columns_2 (
    .clock                (clock),
    .reset                (reset),
    .io_f2_req_idx        (s2_idx),
    .io_f3_req_fire       (s3_valid & s3_mask[2] & io_f3_fire & columns_2_io_f3_req_fire_REG),
    .io_f3_pred_in        (io_resp_in_0_f3_2_taken),
    .io_update_mispredict (s1_update__valid & s1_update__bits_br_mask[2] & s1_update__bits_is_mispredict_update & s1_update__bits_cfi_mispredicted),
    .io_update_repair     (s1_update__valid & s1_update__bits_br_mask[2] & s1_update__bits_is_repair_update),
    .io_update_idx        (s1_update_idx),
    .io_update_meta_s_cnt (s1_update__bits_meta[29:20]),
    .io_f3_pred           (io_resp_f3_2_taken),
    .io_f3_meta_s_cnt     (_columns_2_io_f3_meta_s_cnt)
  );
  LoopBranchPredictorColumn columns_3 (
    .clock                (clock),
    .reset                (reset),
    .io_f2_req_idx        (s2_idx),
    .io_f3_req_fire       (s3_valid & s3_mask[3] & io_f3_fire & columns_3_io_f3_req_fire_REG),
    .io_f3_pred_in        (io_resp_in_0_f3_3_taken),
    .io_update_mispredict (s1_update__valid & s1_update__bits_br_mask[3] & s1_update__bits_is_mispredict_update & s1_update__bits_cfi_mispredicted),
    .io_update_repair     (s1_update__valid & s1_update__bits_br_mask[3] & s1_update__bits_is_repair_update),
    .io_update_idx        (s1_update_idx),
    .io_update_meta_s_cnt (s1_update__bits_meta[39:30]),
    .io_f3_pred           (io_resp_f3_3_taken),
    .io_f3_meta_s_cnt     (_columns_3_io_f3_meta_s_cnt)
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
  assign io_resp_f3_0_predicted_pc_valid = io_resp_in_0_f3_0_predicted_pc_valid;
  assign io_resp_f3_0_predicted_pc_bits = io_resp_in_0_f3_0_predicted_pc_bits;
  assign io_resp_f3_1_predicted_pc_valid = io_resp_in_0_f3_1_predicted_pc_valid;
  assign io_resp_f3_1_predicted_pc_bits = io_resp_in_0_f3_1_predicted_pc_bits;
  assign io_resp_f3_2_predicted_pc_valid = io_resp_in_0_f3_2_predicted_pc_valid;
  assign io_resp_f3_2_predicted_pc_bits = io_resp_in_0_f3_2_predicted_pc_bits;
  assign io_resp_f3_3_predicted_pc_valid = io_resp_in_0_f3_3_predicted_pc_valid;
  assign io_resp_f3_3_predicted_pc_bits = io_resp_in_0_f3_3_predicted_pc_bits;
  assign io_f3_meta = {80'h0, _columns_3_io_f3_meta_s_cnt, _columns_2_io_f3_meta_s_cnt, _columns_1_io_f3_meta_s_cnt, _columns_0_io_f3_meta_s_cnt};
endmodule

