// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BIMBranchPredictorBank(
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
  input          io_resp_in_0_f2_0_is_br,
                 io_resp_in_0_f2_0_is_jal,
                 io_resp_in_0_f2_0_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f2_0_predicted_pc_bits,
  input          io_resp_in_0_f2_1_is_br,
                 io_resp_in_0_f2_1_is_jal,
                 io_resp_in_0_f2_1_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f2_1_predicted_pc_bits,
  input          io_resp_in_0_f2_2_is_br,
                 io_resp_in_0_f2_2_is_jal,
                 io_resp_in_0_f2_2_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f2_2_predicted_pc_bits,
  input          io_resp_in_0_f2_3_is_br,
                 io_resp_in_0_f2_3_is_jal,
                 io_resp_in_0_f2_3_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f2_3_predicted_pc_bits,
  input          io_resp_in_0_f3_0_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f3_0_predicted_pc_bits,
  input          io_resp_in_0_f3_1_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f3_1_predicted_pc_bits,
  input          io_resp_in_0_f3_2_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f3_2_predicted_pc_bits,
  input          io_resp_in_0_f3_3_predicted_pc_valid,
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
                 io_update_bits_cfi_is_br,
                 io_update_bits_cfi_is_jal,
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

  wire         _GEN_35;
  wire         _GEN_34;
  wire         _GEN_33;
  wire         _GEN_32;
  wire         _GEN_31;
  wire [1:0]   _data_3_ext_R0_data;
  wire [1:0]   _data_2_ext_R0_data;
  wire [1:0]   _data_1_ext_R0_data;
  wire [1:0]   _data_0_ext_R0_data;
  reg          s1_valid;
  reg          s2_valid;
  reg          s1_update__valid;
  reg          s1_update__bits_is_mispredict_update;
  reg          s1_update__bits_is_repair_update;
  reg  [3:0]   s1_update__bits_btb_mispredicts;
  reg  [3:0]   s1_update__bits_br_mask;
  reg          s1_update__bits_cfi_idx_valid;
  reg  [1:0]   s1_update__bits_cfi_idx_bits;
  reg          s1_update__bits_cfi_taken;
  reg          s1_update__bits_cfi_is_br;
  reg          s1_update__bits_cfi_is_jal;
  reg  [119:0] s1_update__bits_meta;
  reg  [35:0]  s1_update_idx;
  reg  [1:0]   s2_req_rdata_1;
  reg  [1:0]   s2_req_rdata_0;
  reg  [1:0]   s2_req_rdata_3;
  reg  [1:0]   s2_req_rdata_2;
  reg          doing_reset;
  reg  [10:0]  reset_idx;
  wire         _io_resp_f2_0_taken_output = s2_valid & s2_req_rdata_0[1] & ~doing_reset;
  wire         _io_resp_f2_1_taken_output = s2_valid & s2_req_rdata_1[1] & ~doing_reset;
  wire         _io_resp_f2_2_taken_output = s2_valid & s2_req_rdata_2[1] & ~doing_reset;
  wire         _io_resp_f2_3_taken_output = s2_valid & s2_req_rdata_3[1] & ~doing_reset;
  reg  [10:0]  wrbypass_idxs_0;
  reg  [10:0]  wrbypass_idxs_1;
  reg  [1:0]   wrbypass_0_0;
  reg  [1:0]   wrbypass_0_1;
  reg  [1:0]   wrbypass_0_2;
  reg  [1:0]   wrbypass_0_3;
  reg  [1:0]   wrbypass_1_0;
  reg  [1:0]   wrbypass_1_1;
  reg  [1:0]   wrbypass_1_2;
  reg  [1:0]   wrbypass_1_3;
  reg          wrbypass_enq_idx;
  wire         wrbypass_hits_0 = ~doing_reset & wrbypass_idxs_0 == s1_update_idx[10:0];
  wire         wrbypass_hit = wrbypass_hits_0 | ~doing_reset & wrbypass_idxs_1 == s1_update_idx[10:0];
  wire         _was_taken_T = s1_update__bits_cfi_idx_bits == 2'h0;
  wire         s1_update_wmask_0 = s1_update__bits_br_mask[0] | s1_update__bits_cfi_idx_valid & _was_taken_T;
  wire         was_taken = s1_update__bits_cfi_idx_valid & _was_taken_T & (s1_update__bits_cfi_is_br & s1_update__bits_br_mask[0] & s1_update__bits_cfi_taken | s1_update__bits_cfi_is_jal);
  wire [1:0]   old_bim_value = wrbypass_hit ? (wrbypass_hits_0 ? wrbypass_0_0 : wrbypass_1_0) : s1_update__bits_meta[1:0];
  wire         _s1_update_wdata_0_T = (&old_bim_value) & was_taken;
  wire         _s1_update_wdata_0_T_2 = old_bim_value == 2'h0 & ~was_taken;
  wire [1:0]   _s1_update_wdata_0_T_3 = old_bim_value + 2'h1;
  wire [1:0]   _s1_update_wdata_0_T_5 = old_bim_value - 2'h1;
  wire         _was_taken_T_6 = s1_update__bits_cfi_idx_bits == 2'h1;
  wire         s1_update_wmask_1 = s1_update__bits_br_mask[1] | s1_update__bits_cfi_idx_valid & _was_taken_T_6;
  wire         was_taken_1 = s1_update__bits_cfi_idx_valid & _was_taken_T_6 & (s1_update__bits_cfi_is_br & s1_update__bits_br_mask[1] & s1_update__bits_cfi_taken | s1_update__bits_cfi_is_jal);
  wire [1:0]   old_bim_value_1 = wrbypass_hit ? (wrbypass_hits_0 ? wrbypass_0_1 : wrbypass_1_1) : s1_update__bits_meta[3:2];
  wire         _s1_update_wdata_1_T = (&old_bim_value_1) & was_taken_1;
  wire         _s1_update_wdata_1_T_2 = old_bim_value_1 == 2'h0 & ~was_taken_1;
  wire [1:0]   _s1_update_wdata_1_T_3 = old_bim_value_1 + 2'h1;
  wire [1:0]   _s1_update_wdata_1_T_5 = old_bim_value_1 - 2'h1;
  wire         _was_taken_T_12 = s1_update__bits_cfi_idx_bits == 2'h2;
  wire         s1_update_wmask_2 = s1_update__bits_br_mask[2] | s1_update__bits_cfi_idx_valid & _was_taken_T_12;
  wire         was_taken_2 = s1_update__bits_cfi_idx_valid & _was_taken_T_12 & (s1_update__bits_cfi_is_br & s1_update__bits_br_mask[2] & s1_update__bits_cfi_taken | s1_update__bits_cfi_is_jal);
  wire [1:0]   old_bim_value_2 = wrbypass_hit ? (wrbypass_hits_0 ? wrbypass_0_2 : wrbypass_1_2) : s1_update__bits_meta[5:4];
  wire         _s1_update_wdata_2_T = (&old_bim_value_2) & was_taken_2;
  wire         _s1_update_wdata_2_T_2 = old_bim_value_2 == 2'h0 & ~was_taken_2;
  wire [1:0]   _s1_update_wdata_2_T_3 = old_bim_value_2 + 2'h1;
  wire [1:0]   _s1_update_wdata_2_T_5 = old_bim_value_2 - 2'h1;
  wire         s1_update_wmask_3 = s1_update__bits_br_mask[3] | s1_update__bits_cfi_idx_valid & (&s1_update__bits_cfi_idx_bits);
  wire         was_taken_3 = s1_update__bits_cfi_idx_valid & (&s1_update__bits_cfi_idx_bits) & (s1_update__bits_cfi_is_br & s1_update__bits_br_mask[3] & s1_update__bits_cfi_taken | s1_update__bits_cfi_is_jal);
  wire [1:0]   old_bim_value_3 = wrbypass_hit ? (wrbypass_hits_0 ? wrbypass_0_3 : wrbypass_1_3) : s1_update__bits_meta[7:6];
  wire         _s1_update_wdata_3_T = (&old_bim_value_3) & was_taken_3;
  wire         _s1_update_wdata_3_T_2 = old_bim_value_3 == 2'h0 & ~was_taken_3;
  wire [1:0]   _s1_update_wdata_3_T_3 = old_bim_value_3 + 2'h1;
  wire [1:0]   _s1_update_wdata_3_T_5 = old_bim_value_3 - 2'h1;
  wire         _GEN = s1_update__bits_is_mispredict_update | s1_update__bits_is_repair_update | (|s1_update__bits_btb_mispredicts);
  assign _GEN_31 = doing_reset | s1_update__valid & ~_GEN;
  wire [10:0]  _GEN_29 = doing_reset ? reset_idx : s1_update_idx[10:0];
  wire [3:0]   _GEN_0 = doing_reset ? 4'hF : {s1_update_wmask_3, s1_update_wmask_2, s1_update_wmask_1, s1_update_wmask_0};
  assign _GEN_32 = _GEN_0[0];
  assign _GEN_33 = _GEN_0[1];
  assign _GEN_34 = _GEN_0[2];
  assign _GEN_35 = _GEN_0[3];
  reg          io_resp_f3_0_taken_REG;
  reg          io_resp_f3_1_taken_REG;
  reg          io_resp_f3_2_taken_REG;
  reg          io_resp_f3_3_taken_REG;
  reg  [7:0]   io_f3_meta_REG;
  wire         _GEN_1 = (s1_update_wmask_0 | s1_update_wmask_1 | s1_update_wmask_2 | s1_update_wmask_3) & s1_update__valid & ~_GEN;
  always @(posedge clock) begin
    s1_valid <= io_f0_valid;
    s2_valid <= s1_valid;
    s1_update__valid <= io_update_valid;
    s1_update__bits_is_mispredict_update <= io_update_bits_is_mispredict_update;
    s1_update__bits_is_repair_update <= io_update_bits_is_repair_update;
    s1_update__bits_btb_mispredicts <= io_update_bits_btb_mispredicts;
    s1_update__bits_br_mask <= io_update_bits_br_mask;
    s1_update__bits_cfi_idx_valid <= io_update_bits_cfi_idx_valid;
    s1_update__bits_cfi_idx_bits <= io_update_bits_cfi_idx_bits;
    s1_update__bits_cfi_taken <= io_update_bits_cfi_taken;
    s1_update__bits_cfi_is_br <= io_update_bits_cfi_is_br;
    s1_update__bits_cfi_is_jal <= io_update_bits_cfi_is_jal;
    s1_update__bits_meta <= io_update_bits_meta;
    s1_update_idx <= io_update_bits_pc[39:4];
    s2_req_rdata_1 <= _data_1_ext_R0_data;
    s2_req_rdata_0 <= _data_0_ext_R0_data;
    s2_req_rdata_3 <= _data_3_ext_R0_data;
    s2_req_rdata_2 <= _data_2_ext_R0_data;
    if (~_GEN_1 | wrbypass_hit | wrbypass_enq_idx) begin
    end
    else
      wrbypass_idxs_0 <= s1_update_idx[10:0];
    if (~_GEN_1 | wrbypass_hit | ~wrbypass_enq_idx) begin
    end
    else
      wrbypass_idxs_1 <= s1_update_idx[10:0];
    if (_GEN_1) begin
      if (wrbypass_hit) begin
        if (wrbypass_hits_0) begin
          if (_s1_update_wdata_0_T)
            wrbypass_0_0 <= 2'h3;
          else if (_s1_update_wdata_0_T_2)
            wrbypass_0_0 <= 2'h0;
          else if (was_taken)
            wrbypass_0_0 <= _s1_update_wdata_0_T_3;
          else
            wrbypass_0_0 <= _s1_update_wdata_0_T_5;
          if (_s1_update_wdata_1_T)
            wrbypass_0_1 <= 2'h3;
          else if (_s1_update_wdata_1_T_2)
            wrbypass_0_1 <= 2'h0;
          else if (was_taken_1)
            wrbypass_0_1 <= _s1_update_wdata_1_T_3;
          else
            wrbypass_0_1 <= _s1_update_wdata_1_T_5;
          if (_s1_update_wdata_2_T)
            wrbypass_0_2 <= 2'h3;
          else if (_s1_update_wdata_2_T_2)
            wrbypass_0_2 <= 2'h0;
          else if (was_taken_2)
            wrbypass_0_2 <= _s1_update_wdata_2_T_3;
          else
            wrbypass_0_2 <= _s1_update_wdata_2_T_5;
          if (_s1_update_wdata_3_T)
            wrbypass_0_3 <= 2'h3;
          else if (_s1_update_wdata_3_T_2)
            wrbypass_0_3 <= 2'h0;
          else if (was_taken_3)
            wrbypass_0_3 <= _s1_update_wdata_3_T_3;
          else
            wrbypass_0_3 <= _s1_update_wdata_3_T_5;
        end
        else begin
          if (_s1_update_wdata_0_T)
            wrbypass_1_0 <= 2'h3;
          else if (_s1_update_wdata_0_T_2)
            wrbypass_1_0 <= 2'h0;
          else if (was_taken)
            wrbypass_1_0 <= _s1_update_wdata_0_T_3;
          else
            wrbypass_1_0 <= _s1_update_wdata_0_T_5;
          if (_s1_update_wdata_1_T)
            wrbypass_1_1 <= 2'h3;
          else if (_s1_update_wdata_1_T_2)
            wrbypass_1_1 <= 2'h0;
          else if (was_taken_1)
            wrbypass_1_1 <= _s1_update_wdata_1_T_3;
          else
            wrbypass_1_1 <= _s1_update_wdata_1_T_5;
          if (_s1_update_wdata_2_T)
            wrbypass_1_2 <= 2'h3;
          else if (_s1_update_wdata_2_T_2)
            wrbypass_1_2 <= 2'h0;
          else if (was_taken_2)
            wrbypass_1_2 <= _s1_update_wdata_2_T_3;
          else
            wrbypass_1_2 <= _s1_update_wdata_2_T_5;
          if (_s1_update_wdata_3_T)
            wrbypass_1_3 <= 2'h3;
          else if (_s1_update_wdata_3_T_2)
            wrbypass_1_3 <= 2'h0;
          else if (was_taken_3)
            wrbypass_1_3 <= _s1_update_wdata_3_T_3;
          else
            wrbypass_1_3 <= _s1_update_wdata_3_T_5;
        end
      end
      else if (wrbypass_enq_idx) begin
        if (_s1_update_wdata_0_T)
          wrbypass_1_0 <= 2'h3;
        else if (_s1_update_wdata_0_T_2)
          wrbypass_1_0 <= 2'h0;
        else if (was_taken)
          wrbypass_1_0 <= _s1_update_wdata_0_T_3;
        else
          wrbypass_1_0 <= _s1_update_wdata_0_T_5;
        if (_s1_update_wdata_1_T)
          wrbypass_1_1 <= 2'h3;
        else if (_s1_update_wdata_1_T_2)
          wrbypass_1_1 <= 2'h0;
        else if (was_taken_1)
          wrbypass_1_1 <= _s1_update_wdata_1_T_3;
        else
          wrbypass_1_1 <= _s1_update_wdata_1_T_5;
        if (_s1_update_wdata_2_T)
          wrbypass_1_2 <= 2'h3;
        else if (_s1_update_wdata_2_T_2)
          wrbypass_1_2 <= 2'h0;
        else if (was_taken_2)
          wrbypass_1_2 <= _s1_update_wdata_2_T_3;
        else
          wrbypass_1_2 <= _s1_update_wdata_2_T_5;
        if (_s1_update_wdata_3_T)
          wrbypass_1_3 <= 2'h3;
        else if (_s1_update_wdata_3_T_2)
          wrbypass_1_3 <= 2'h0;
        else if (was_taken_3)
          wrbypass_1_3 <= _s1_update_wdata_3_T_3;
        else
          wrbypass_1_3 <= _s1_update_wdata_3_T_5;
      end
      else begin
        if (_s1_update_wdata_0_T)
          wrbypass_0_0 <= 2'h3;
        else if (_s1_update_wdata_0_T_2)
          wrbypass_0_0 <= 2'h0;
        else if (was_taken)
          wrbypass_0_0 <= _s1_update_wdata_0_T_3;
        else
          wrbypass_0_0 <= _s1_update_wdata_0_T_5;
        if (_s1_update_wdata_1_T)
          wrbypass_0_1 <= 2'h3;
        else if (_s1_update_wdata_1_T_2)
          wrbypass_0_1 <= 2'h0;
        else if (was_taken_1)
          wrbypass_0_1 <= _s1_update_wdata_1_T_3;
        else
          wrbypass_0_1 <= _s1_update_wdata_1_T_5;
        if (_s1_update_wdata_2_T)
          wrbypass_0_2 <= 2'h3;
        else if (_s1_update_wdata_2_T_2)
          wrbypass_0_2 <= 2'h0;
        else if (was_taken_2)
          wrbypass_0_2 <= _s1_update_wdata_2_T_3;
        else
          wrbypass_0_2 <= _s1_update_wdata_2_T_5;
        if (_s1_update_wdata_3_T)
          wrbypass_0_3 <= 2'h3;
        else if (_s1_update_wdata_3_T_2)
          wrbypass_0_3 <= 2'h0;
        else if (was_taken_3)
          wrbypass_0_3 <= _s1_update_wdata_3_T_3;
        else
          wrbypass_0_3 <= _s1_update_wdata_3_T_5;
      end
    end
    io_resp_f3_0_taken_REG <= _io_resp_f2_0_taken_output;
    io_resp_f3_1_taken_REG <= _io_resp_f2_1_taken_output;
    io_resp_f3_2_taken_REG <= _io_resp_f2_2_taken_output;
    io_resp_f3_3_taken_REG <= _io_resp_f2_3_taken_output;
    io_f3_meta_REG <= {s2_req_rdata_3, s2_req_rdata_2, s2_req_rdata_1, s2_req_rdata_0};
    if (reset) begin
      doing_reset <= 1'h1;
      reset_idx <= 11'h0;
      wrbypass_enq_idx <= 1'h0;
    end
    else begin
      doing_reset <= reset_idx != 11'h7FF & doing_reset;
      reset_idx <= reset_idx + {10'h0, doing_reset};
      if (~_GEN_1 | wrbypass_hit) begin
      end
      else
        wrbypass_enq_idx <= wrbypass_enq_idx - 1'h1;
    end
  end // always @(posedge)
  data_2048x2 data_0_ext (
    .R0_addr (io_f0_pc[14:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_29),
    .W0_en   (_GEN_31 & _GEN_32),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 2'h2 : _s1_update_wdata_0_T ? 2'h3 : _s1_update_wdata_0_T_2 ? 2'h0 : was_taken ? _s1_update_wdata_0_T_3 : _s1_update_wdata_0_T_5),
    .R0_data (_data_0_ext_R0_data)
  );
  data_2048x2 data_1_ext (
    .R0_addr (io_f0_pc[14:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_29),
    .W0_en   (_GEN_31 & _GEN_33),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 2'h2 : _s1_update_wdata_1_T ? 2'h3 : _s1_update_wdata_1_T_2 ? 2'h0 : was_taken_1 ? _s1_update_wdata_1_T_3 : _s1_update_wdata_1_T_5),
    .R0_data (_data_1_ext_R0_data)
  );
  data_2048x2 data_2_ext (
    .R0_addr (io_f0_pc[14:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_29),
    .W0_en   (_GEN_31 & _GEN_34),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 2'h2 : _s1_update_wdata_2_T ? 2'h3 : _s1_update_wdata_2_T_2 ? 2'h0 : was_taken_2 ? _s1_update_wdata_2_T_3 : _s1_update_wdata_2_T_5),
    .R0_data (_data_2_ext_R0_data)
  );
  data_2048x2 data_3_ext (
    .R0_addr (io_f0_pc[14:4]),
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_29),
    .W0_en   (_GEN_31 & _GEN_35),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 2'h2 : _s1_update_wdata_3_T ? 2'h3 : _s1_update_wdata_3_T_2 ? 2'h0 : was_taken_3 ? _s1_update_wdata_3_T_3 : _s1_update_wdata_3_T_5),
    .R0_data (_data_3_ext_R0_data)
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
  assign io_resp_f2_0_taken = _io_resp_f2_0_taken_output;
  assign io_resp_f2_0_is_br = io_resp_in_0_f2_0_is_br;
  assign io_resp_f2_0_is_jal = io_resp_in_0_f2_0_is_jal;
  assign io_resp_f2_0_predicted_pc_valid = io_resp_in_0_f2_0_predicted_pc_valid;
  assign io_resp_f2_0_predicted_pc_bits = io_resp_in_0_f2_0_predicted_pc_bits;
  assign io_resp_f2_1_taken = _io_resp_f2_1_taken_output;
  assign io_resp_f2_1_is_br = io_resp_in_0_f2_1_is_br;
  assign io_resp_f2_1_is_jal = io_resp_in_0_f2_1_is_jal;
  assign io_resp_f2_1_predicted_pc_valid = io_resp_in_0_f2_1_predicted_pc_valid;
  assign io_resp_f2_1_predicted_pc_bits = io_resp_in_0_f2_1_predicted_pc_bits;
  assign io_resp_f2_2_taken = _io_resp_f2_2_taken_output;
  assign io_resp_f2_2_is_br = io_resp_in_0_f2_2_is_br;
  assign io_resp_f2_2_is_jal = io_resp_in_0_f2_2_is_jal;
  assign io_resp_f2_2_predicted_pc_valid = io_resp_in_0_f2_2_predicted_pc_valid;
  assign io_resp_f2_2_predicted_pc_bits = io_resp_in_0_f2_2_predicted_pc_bits;
  assign io_resp_f2_3_taken = _io_resp_f2_3_taken_output;
  assign io_resp_f2_3_is_br = io_resp_in_0_f2_3_is_br;
  assign io_resp_f2_3_is_jal = io_resp_in_0_f2_3_is_jal;
  assign io_resp_f2_3_predicted_pc_valid = io_resp_in_0_f2_3_predicted_pc_valid;
  assign io_resp_f2_3_predicted_pc_bits = io_resp_in_0_f2_3_predicted_pc_bits;
  assign io_resp_f3_0_taken = io_resp_f3_0_taken_REG;
  assign io_resp_f3_0_predicted_pc_valid = io_resp_in_0_f3_0_predicted_pc_valid;
  assign io_resp_f3_0_predicted_pc_bits = io_resp_in_0_f3_0_predicted_pc_bits;
  assign io_resp_f3_1_taken = io_resp_f3_1_taken_REG;
  assign io_resp_f3_1_predicted_pc_valid = io_resp_in_0_f3_1_predicted_pc_valid;
  assign io_resp_f3_1_predicted_pc_bits = io_resp_in_0_f3_1_predicted_pc_bits;
  assign io_resp_f3_2_taken = io_resp_f3_2_taken_REG;
  assign io_resp_f3_2_predicted_pc_valid = io_resp_in_0_f3_2_predicted_pc_valid;
  assign io_resp_f3_2_predicted_pc_bits = io_resp_in_0_f3_2_predicted_pc_bits;
  assign io_resp_f3_3_taken = io_resp_f3_3_taken_REG;
  assign io_resp_f3_3_predicted_pc_valid = io_resp_in_0_f3_3_predicted_pc_valid;
  assign io_resp_f3_3_predicted_pc_bits = io_resp_in_0_f3_3_predicted_pc_bits;
  assign io_f3_meta = {112'h0, io_f3_meta_REG};
endmodule

