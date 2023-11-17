// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module LoopBranchPredictorColumn(
  input         clock,
                reset,
  input  [35:0] io_f2_req_idx,
  input         io_f3_req_fire,
                io_f3_pred_in,
                io_update_mispredict,
                io_update_repair,
  input  [35:0] io_update_idx,
  input  [9:0]  io_update_meta_s_cnt,
  output        io_f3_pred,
  output [9:0]  io_f3_meta_s_cnt
);

  reg  [9:0]  casez_tmp;
  reg  [2:0]  casez_tmp_0;
  reg  [2:0]  casez_tmp_1;
  reg  [9:0]  casez_tmp_2;
  reg  [9:0]  casez_tmp_3;
  reg  [9:0]  casez_tmp_4;
  reg  [9:0]  casez_tmp_5;
  reg  [2:0]  casez_tmp_6;
  reg  [2:0]  casez_tmp_7;
  reg  [9:0]  casez_tmp_8;
  reg         doing_reset;
  reg  [3:0]  reset_idx;
  reg  [9:0]  entries_0_tag;
  reg  [2:0]  entries_0_conf;
  reg  [2:0]  entries_0_age;
  reg  [9:0]  entries_0_p_cnt;
  reg  [9:0]  entries_0_s_cnt;
  reg  [9:0]  entries_1_tag;
  reg  [2:0]  entries_1_conf;
  reg  [2:0]  entries_1_age;
  reg  [9:0]  entries_1_p_cnt;
  reg  [9:0]  entries_1_s_cnt;
  reg  [9:0]  entries_2_tag;
  reg  [2:0]  entries_2_conf;
  reg  [2:0]  entries_2_age;
  reg  [9:0]  entries_2_p_cnt;
  reg  [9:0]  entries_2_s_cnt;
  reg  [9:0]  entries_3_tag;
  reg  [2:0]  entries_3_conf;
  reg  [2:0]  entries_3_age;
  reg  [9:0]  entries_3_p_cnt;
  reg  [9:0]  entries_3_s_cnt;
  reg  [9:0]  entries_4_tag;
  reg  [2:0]  entries_4_conf;
  reg  [2:0]  entries_4_age;
  reg  [9:0]  entries_4_p_cnt;
  reg  [9:0]  entries_4_s_cnt;
  reg  [9:0]  entries_5_tag;
  reg  [2:0]  entries_5_conf;
  reg  [2:0]  entries_5_age;
  reg  [9:0]  entries_5_p_cnt;
  reg  [9:0]  entries_5_s_cnt;
  reg  [9:0]  entries_6_tag;
  reg  [2:0]  entries_6_conf;
  reg  [2:0]  entries_6_age;
  reg  [9:0]  entries_6_p_cnt;
  reg  [9:0]  entries_6_s_cnt;
  reg  [9:0]  entries_7_tag;
  reg  [2:0]  entries_7_conf;
  reg  [2:0]  entries_7_age;
  reg  [9:0]  entries_7_p_cnt;
  reg  [9:0]  entries_7_s_cnt;
  reg  [9:0]  entries_8_tag;
  reg  [2:0]  entries_8_conf;
  reg  [2:0]  entries_8_age;
  reg  [9:0]  entries_8_p_cnt;
  reg  [9:0]  entries_8_s_cnt;
  reg  [9:0]  entries_9_tag;
  reg  [2:0]  entries_9_conf;
  reg  [2:0]  entries_9_age;
  reg  [9:0]  entries_9_p_cnt;
  reg  [9:0]  entries_9_s_cnt;
  reg  [9:0]  entries_10_tag;
  reg  [2:0]  entries_10_conf;
  reg  [2:0]  entries_10_age;
  reg  [9:0]  entries_10_p_cnt;
  reg  [9:0]  entries_10_s_cnt;
  reg  [9:0]  entries_11_tag;
  reg  [2:0]  entries_11_conf;
  reg  [2:0]  entries_11_age;
  reg  [9:0]  entries_11_p_cnt;
  reg  [9:0]  entries_11_s_cnt;
  reg  [9:0]  entries_12_tag;
  reg  [2:0]  entries_12_conf;
  reg  [2:0]  entries_12_age;
  reg  [9:0]  entries_12_p_cnt;
  reg  [9:0]  entries_12_s_cnt;
  reg  [9:0]  entries_13_tag;
  reg  [2:0]  entries_13_conf;
  reg  [2:0]  entries_13_age;
  reg  [9:0]  entries_13_p_cnt;
  reg  [9:0]  entries_13_s_cnt;
  reg  [9:0]  entries_14_tag;
  reg  [2:0]  entries_14_conf;
  reg  [2:0]  entries_14_age;
  reg  [9:0]  entries_14_p_cnt;
  reg  [9:0]  entries_14_s_cnt;
  reg  [9:0]  entries_15_tag;
  reg  [2:0]  entries_15_conf;
  reg  [2:0]  entries_15_age;
  reg  [9:0]  entries_15_p_cnt;
  reg  [9:0]  entries_15_s_cnt;
  always @(*) begin
    casez (io_f2_req_idx[3:0])
      4'b0000:
        casez_tmp = entries_0_tag;
      4'b0001:
        casez_tmp = entries_1_tag;
      4'b0010:
        casez_tmp = entries_2_tag;
      4'b0011:
        casez_tmp = entries_3_tag;
      4'b0100:
        casez_tmp = entries_4_tag;
      4'b0101:
        casez_tmp = entries_5_tag;
      4'b0110:
        casez_tmp = entries_6_tag;
      4'b0111:
        casez_tmp = entries_7_tag;
      4'b1000:
        casez_tmp = entries_8_tag;
      4'b1001:
        casez_tmp = entries_9_tag;
      4'b1010:
        casez_tmp = entries_10_tag;
      4'b1011:
        casez_tmp = entries_11_tag;
      4'b1100:
        casez_tmp = entries_12_tag;
      4'b1101:
        casez_tmp = entries_13_tag;
      4'b1110:
        casez_tmp = entries_14_tag;
      default:
        casez_tmp = entries_15_tag;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_f2_req_idx[3:0])
      4'b0000:
        casez_tmp_0 = entries_0_conf;
      4'b0001:
        casez_tmp_0 = entries_1_conf;
      4'b0010:
        casez_tmp_0 = entries_2_conf;
      4'b0011:
        casez_tmp_0 = entries_3_conf;
      4'b0100:
        casez_tmp_0 = entries_4_conf;
      4'b0101:
        casez_tmp_0 = entries_5_conf;
      4'b0110:
        casez_tmp_0 = entries_6_conf;
      4'b0111:
        casez_tmp_0 = entries_7_conf;
      4'b1000:
        casez_tmp_0 = entries_8_conf;
      4'b1001:
        casez_tmp_0 = entries_9_conf;
      4'b1010:
        casez_tmp_0 = entries_10_conf;
      4'b1011:
        casez_tmp_0 = entries_11_conf;
      4'b1100:
        casez_tmp_0 = entries_12_conf;
      4'b1101:
        casez_tmp_0 = entries_13_conf;
      4'b1110:
        casez_tmp_0 = entries_14_conf;
      default:
        casez_tmp_0 = entries_15_conf;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_f2_req_idx[3:0])
      4'b0000:
        casez_tmp_1 = entries_0_age;
      4'b0001:
        casez_tmp_1 = entries_1_age;
      4'b0010:
        casez_tmp_1 = entries_2_age;
      4'b0011:
        casez_tmp_1 = entries_3_age;
      4'b0100:
        casez_tmp_1 = entries_4_age;
      4'b0101:
        casez_tmp_1 = entries_5_age;
      4'b0110:
        casez_tmp_1 = entries_6_age;
      4'b0111:
        casez_tmp_1 = entries_7_age;
      4'b1000:
        casez_tmp_1 = entries_8_age;
      4'b1001:
        casez_tmp_1 = entries_9_age;
      4'b1010:
        casez_tmp_1 = entries_10_age;
      4'b1011:
        casez_tmp_1 = entries_11_age;
      4'b1100:
        casez_tmp_1 = entries_12_age;
      4'b1101:
        casez_tmp_1 = entries_13_age;
      4'b1110:
        casez_tmp_1 = entries_14_age;
      default:
        casez_tmp_1 = entries_15_age;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_f2_req_idx[3:0])
      4'b0000:
        casez_tmp_2 = entries_0_p_cnt;
      4'b0001:
        casez_tmp_2 = entries_1_p_cnt;
      4'b0010:
        casez_tmp_2 = entries_2_p_cnt;
      4'b0011:
        casez_tmp_2 = entries_3_p_cnt;
      4'b0100:
        casez_tmp_2 = entries_4_p_cnt;
      4'b0101:
        casez_tmp_2 = entries_5_p_cnt;
      4'b0110:
        casez_tmp_2 = entries_6_p_cnt;
      4'b0111:
        casez_tmp_2 = entries_7_p_cnt;
      4'b1000:
        casez_tmp_2 = entries_8_p_cnt;
      4'b1001:
        casez_tmp_2 = entries_9_p_cnt;
      4'b1010:
        casez_tmp_2 = entries_10_p_cnt;
      4'b1011:
        casez_tmp_2 = entries_11_p_cnt;
      4'b1100:
        casez_tmp_2 = entries_12_p_cnt;
      4'b1101:
        casez_tmp_2 = entries_13_p_cnt;
      4'b1110:
        casez_tmp_2 = entries_14_p_cnt;
      default:
        casez_tmp_2 = entries_15_p_cnt;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_f2_req_idx[3:0])
      4'b0000:
        casez_tmp_3 = entries_0_s_cnt;
      4'b0001:
        casez_tmp_3 = entries_1_s_cnt;
      4'b0010:
        casez_tmp_3 = entries_2_s_cnt;
      4'b0011:
        casez_tmp_3 = entries_3_s_cnt;
      4'b0100:
        casez_tmp_3 = entries_4_s_cnt;
      4'b0101:
        casez_tmp_3 = entries_5_s_cnt;
      4'b0110:
        casez_tmp_3 = entries_6_s_cnt;
      4'b0111:
        casez_tmp_3 = entries_7_s_cnt;
      4'b1000:
        casez_tmp_3 = entries_8_s_cnt;
      4'b1001:
        casez_tmp_3 = entries_9_s_cnt;
      4'b1010:
        casez_tmp_3 = entries_10_s_cnt;
      4'b1011:
        casez_tmp_3 = entries_11_s_cnt;
      4'b1100:
        casez_tmp_3 = entries_12_s_cnt;
      4'b1101:
        casez_tmp_3 = entries_13_s_cnt;
      4'b1110:
        casez_tmp_3 = entries_14_s_cnt;
      default:
        casez_tmp_3 = entries_15_s_cnt;
    endcase
  end // always @(*)
  reg  [9:0]  f3_entry_tag;
  reg  [2:0]  f3_entry_conf;
  reg  [2:0]  f3_entry_age;
  reg  [9:0]  f3_entry_p_cnt;
  reg  [9:0]  f3_entry_s_cnt;
  reg  [35:0] f3_scnt_REG;
  wire        _f3_scnt_T_1 = io_update_repair & io_update_idx == f3_scnt_REG;
  wire [9:0]  f3_scnt = _f3_scnt_T_1 ? io_update_meta_s_cnt : f3_entry_s_cnt;
  reg  [9:0]  f3_tag;
  reg         f4_fire;
  reg  [9:0]  f4_entry_tag;
  reg  [2:0]  f4_entry_conf;
  reg  [2:0]  f4_entry_age;
  reg  [9:0]  f4_entry_p_cnt;
  reg  [9:0]  f4_tag;
  reg  [9:0]  f4_scnt;
  reg  [35:0] f4_idx_REG;
  reg  [35:0] f4_idx;
  always @(*) begin
    casez (io_update_idx[3:0])
      4'b0000:
        casez_tmp_4 = entries_0_tag;
      4'b0001:
        casez_tmp_4 = entries_1_tag;
      4'b0010:
        casez_tmp_4 = entries_2_tag;
      4'b0011:
        casez_tmp_4 = entries_3_tag;
      4'b0100:
        casez_tmp_4 = entries_4_tag;
      4'b0101:
        casez_tmp_4 = entries_5_tag;
      4'b0110:
        casez_tmp_4 = entries_6_tag;
      4'b0111:
        casez_tmp_4 = entries_7_tag;
      4'b1000:
        casez_tmp_4 = entries_8_tag;
      4'b1001:
        casez_tmp_4 = entries_9_tag;
      4'b1010:
        casez_tmp_4 = entries_10_tag;
      4'b1011:
        casez_tmp_4 = entries_11_tag;
      4'b1100:
        casez_tmp_4 = entries_12_tag;
      4'b1101:
        casez_tmp_4 = entries_13_tag;
      4'b1110:
        casez_tmp_4 = entries_14_tag;
      default:
        casez_tmp_4 = entries_15_tag;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_update_idx[3:0])
      4'b0000:
        casez_tmp_5 = entries_0_p_cnt;
      4'b0001:
        casez_tmp_5 = entries_1_p_cnt;
      4'b0010:
        casez_tmp_5 = entries_2_p_cnt;
      4'b0011:
        casez_tmp_5 = entries_3_p_cnt;
      4'b0100:
        casez_tmp_5 = entries_4_p_cnt;
      4'b0101:
        casez_tmp_5 = entries_5_p_cnt;
      4'b0110:
        casez_tmp_5 = entries_6_p_cnt;
      4'b0111:
        casez_tmp_5 = entries_7_p_cnt;
      4'b1000:
        casez_tmp_5 = entries_8_p_cnt;
      4'b1001:
        casez_tmp_5 = entries_9_p_cnt;
      4'b1010:
        casez_tmp_5 = entries_10_p_cnt;
      4'b1011:
        casez_tmp_5 = entries_11_p_cnt;
      4'b1100:
        casez_tmp_5 = entries_12_p_cnt;
      4'b1101:
        casez_tmp_5 = entries_13_p_cnt;
      4'b1110:
        casez_tmp_5 = entries_14_p_cnt;
      default:
        casez_tmp_5 = entries_15_p_cnt;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_update_idx[3:0])
      4'b0000:
        casez_tmp_6 = entries_0_conf;
      4'b0001:
        casez_tmp_6 = entries_1_conf;
      4'b0010:
        casez_tmp_6 = entries_2_conf;
      4'b0011:
        casez_tmp_6 = entries_3_conf;
      4'b0100:
        casez_tmp_6 = entries_4_conf;
      4'b0101:
        casez_tmp_6 = entries_5_conf;
      4'b0110:
        casez_tmp_6 = entries_6_conf;
      4'b0111:
        casez_tmp_6 = entries_7_conf;
      4'b1000:
        casez_tmp_6 = entries_8_conf;
      4'b1001:
        casez_tmp_6 = entries_9_conf;
      4'b1010:
        casez_tmp_6 = entries_10_conf;
      4'b1011:
        casez_tmp_6 = entries_11_conf;
      4'b1100:
        casez_tmp_6 = entries_12_conf;
      4'b1101:
        casez_tmp_6 = entries_13_conf;
      4'b1110:
        casez_tmp_6 = entries_14_conf;
      default:
        casez_tmp_6 = entries_15_conf;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_update_idx[3:0])
      4'b0000:
        casez_tmp_7 = entries_0_age;
      4'b0001:
        casez_tmp_7 = entries_1_age;
      4'b0010:
        casez_tmp_7 = entries_2_age;
      4'b0011:
        casez_tmp_7 = entries_3_age;
      4'b0100:
        casez_tmp_7 = entries_4_age;
      4'b0101:
        casez_tmp_7 = entries_5_age;
      4'b0110:
        casez_tmp_7 = entries_6_age;
      4'b0111:
        casez_tmp_7 = entries_7_age;
      4'b1000:
        casez_tmp_7 = entries_8_age;
      4'b1001:
        casez_tmp_7 = entries_9_age;
      4'b1010:
        casez_tmp_7 = entries_10_age;
      4'b1011:
        casez_tmp_7 = entries_11_age;
      4'b1100:
        casez_tmp_7 = entries_12_age;
      4'b1101:
        casez_tmp_7 = entries_13_age;
      4'b1110:
        casez_tmp_7 = entries_14_age;
      default:
        casez_tmp_7 = entries_15_age;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_update_idx[3:0])
      4'b0000:
        casez_tmp_8 = entries_0_s_cnt;
      4'b0001:
        casez_tmp_8 = entries_1_s_cnt;
      4'b0010:
        casez_tmp_8 = entries_2_s_cnt;
      4'b0011:
        casez_tmp_8 = entries_3_s_cnt;
      4'b0100:
        casez_tmp_8 = entries_4_s_cnt;
      4'b0101:
        casez_tmp_8 = entries_5_s_cnt;
      4'b0110:
        casez_tmp_8 = entries_6_s_cnt;
      4'b0111:
        casez_tmp_8 = entries_7_s_cnt;
      4'b1000:
        casez_tmp_8 = entries_8_s_cnt;
      4'b1001:
        casez_tmp_8 = entries_9_s_cnt;
      4'b1010:
        casez_tmp_8 = entries_10_s_cnt;
      4'b1011:
        casez_tmp_8 = entries_11_s_cnt;
      4'b1100:
        casez_tmp_8 = entries_12_s_cnt;
      4'b1101:
        casez_tmp_8 = entries_13_s_cnt;
      4'b1110:
        casez_tmp_8 = entries_14_s_cnt;
      default:
        casez_tmp_8 = entries_15_s_cnt;
    endcase
  end // always @(*)
  wire        _GEN = io_update_idx == io_f2_req_idx;
  wire        _GEN_0 = f4_scnt == f4_entry_p_cnt & (&f4_entry_conf);
  wire [2:0]  _GEN_1 = _GEN_0 | (&f4_entry_age) ? 3'h7 : f4_entry_age + 3'h1;
  wire [9:0]  _GEN_2 = _GEN_0 ? 10'h0 : f4_scnt + 10'h1;
  wire        _GEN_3 = f4_fire & f4_entry_tag == f4_tag;
  wire        tag_match = casez_tmp_4 == io_update_idx[13:4];
  wire        ctr_match = casez_tmp_5 == io_update_meta_s_cnt;
  wire        _GEN_4 = io_update_mispredict & ~doing_reset;
  wire        _GEN_5 = (&casez_tmp_6) & tag_match;
  wire        _GEN_6 = (&casez_tmp_6) & ~tag_match;
  wire        _GEN_7 = (|casez_tmp_6) & tag_match;
  wire        _GEN_8 = _GEN_7 & ctr_match;
  wire [2:0]  _wentry_conf_T = casez_tmp_6 + 3'h1;
  wire        _GEN_9 = _GEN_7 & ~ctr_match;
  wire        _GEN_10 = (|casez_tmp_6) & ~tag_match;
  wire        _GEN_11 = _GEN_10 & ~(|casez_tmp_7);
  wire        _GEN_12 = _GEN_10 & (|casez_tmp_7);
  wire [2:0]  _wentry_age_T = casez_tmp_7 - 3'h1;
  wire        _GEN_13 = ~(|casez_tmp_6) & tag_match;
  wire        _GEN_14 = _GEN_13 & ctr_match;
  wire        _GEN_15 = _GEN_13 & ~ctr_match;
  wire        _GEN_16 = ~(|casez_tmp_6) & ~tag_match;
  wire        _GEN_17 = _GEN_15 | _GEN_16;
  wire        _GEN_18 = _GEN_14 | _GEN_17;
  wire        _GEN_19 = _GEN_11 | ~(_GEN_12 | ~(_GEN_14 | ~(_GEN_15 | ~_GEN_16)));
  wire        _GEN_20 = _GEN_9 | _GEN_11;
  wire        _GEN_21 = _GEN_8 | _GEN_20;
  wire        _GEN_22 = _GEN_5 | ~(_GEN_6 | ~(_GEN_21 | ~(_GEN_12 | ~_GEN_18)));
  wire        _GEN_23 = _GEN_5 | _GEN_6 | _GEN_8 | ~(_GEN_20 | ~(_GEN_12 | _GEN_14 | ~_GEN_17));
  wire        _GEN_24 = _GEN_5 | _GEN_6 | _GEN_8 | _GEN_9 | ~(_GEN_11 | ~(_GEN_12 | _GEN_14 | _GEN_15 | ~_GEN_16));
  wire        _GEN_25 = _GEN_5 | _GEN_6 | _GEN_21;
  wire        _GEN_26 = io_update_repair & ~doing_reset;
  wire        _GEN_27 = tag_match & ~(f4_fire & io_update_idx == f4_idx);
  wire        _GEN_28 = _GEN_26 & _GEN_27;
  wire        _GEN_29 = _GEN_3 & f4_idx[3:0] == 4'h0;
  wire        _GEN_30 = io_update_idx[3:0] == 4'h0;
  wire        _GEN_31 = _GEN_3 & f4_idx[3:0] == 4'h1;
  wire        _GEN_32 = io_update_idx[3:0] == 4'h1;
  wire        _GEN_33 = _GEN_3 & f4_idx[3:0] == 4'h2;
  wire        _GEN_34 = io_update_idx[3:0] == 4'h2;
  wire        _GEN_35 = _GEN_3 & f4_idx[3:0] == 4'h3;
  wire        _GEN_36 = io_update_idx[3:0] == 4'h3;
  wire        _GEN_37 = _GEN_3 & f4_idx[3:0] == 4'h4;
  wire        _GEN_38 = io_update_idx[3:0] == 4'h4;
  wire        _GEN_39 = _GEN_3 & f4_idx[3:0] == 4'h5;
  wire        _GEN_40 = io_update_idx[3:0] == 4'h5;
  wire        _GEN_41 = _GEN_3 & f4_idx[3:0] == 4'h6;
  wire        _GEN_42 = io_update_idx[3:0] == 4'h6;
  wire        _GEN_43 = _GEN_3 & f4_idx[3:0] == 4'h7;
  wire        _GEN_44 = io_update_idx[3:0] == 4'h7;
  wire        _GEN_45 = _GEN_3 & f4_idx[3:0] == 4'h8;
  wire        _GEN_46 = io_update_idx[3:0] == 4'h8;
  wire        _GEN_47 = _GEN_3 & f4_idx[3:0] == 4'h9;
  wire        _GEN_48 = io_update_idx[3:0] == 4'h9;
  wire        _GEN_49 = _GEN_3 & f4_idx[3:0] == 4'hA;
  wire        _GEN_50 = io_update_idx[3:0] == 4'hA;
  wire        _GEN_51 = _GEN_3 & f4_idx[3:0] == 4'hB;
  wire        _GEN_52 = io_update_idx[3:0] == 4'hB;
  wire        _GEN_53 = _GEN_3 & f4_idx[3:0] == 4'hC;
  wire        _GEN_54 = io_update_idx[3:0] == 4'hC;
  wire        _GEN_55 = _GEN_3 & f4_idx[3:0] == 4'hD;
  wire        _GEN_56 = io_update_idx[3:0] == 4'hD;
  wire        _GEN_57 = _GEN_3 & f4_idx[3:0] == 4'hE;
  wire        _GEN_58 = io_update_idx[3:0] == 4'hE;
  wire        _GEN_59 = _GEN_3 & (&(f4_idx[3:0]));
  always @(posedge clock) begin
    if (reset) begin
      doing_reset <= 1'h1;
      reset_idx <= 4'h0;
    end
    else begin
      doing_reset <= ~(&reset_idx) & doing_reset;
      reset_idx <= reset_idx + {3'h0, doing_reset};
    end
    if (doing_reset & reset_idx == 4'h0) begin
      entries_0_tag <= 10'h0;
      entries_0_conf <= 3'h0;
      entries_0_age <= 3'h0;
      entries_0_p_cnt <= 10'h0;
      entries_0_s_cnt <= 10'h0;
    end
    else if (_GEN_4) begin
      if (_GEN_30) begin
        if (_GEN_24)
          entries_0_tag <= casez_tmp_4;
        else
          entries_0_tag <= io_update_idx[13:4];
        if (_GEN_5)
          entries_0_conf <= 3'h0;
        else if (_GEN_6)
          entries_0_conf <= casez_tmp_6;
        else if (_GEN_8)
          entries_0_conf <= _wentry_conf_T;
        else if (_GEN_9)
          entries_0_conf <= 3'h0;
        else if (_GEN_19)
          entries_0_conf <= 3'h1;
        else
          entries_0_conf <= casez_tmp_6;
        if (_GEN_25)
          entries_0_age <= casez_tmp_7;
        else if (_GEN_12)
          entries_0_age <= _wentry_age_T;
        else if (_GEN_18)
          entries_0_age <= 3'h7;
        else
          entries_0_age <= casez_tmp_7;
        if (_GEN_23)
          entries_0_p_cnt <= casez_tmp_5;
        else
          entries_0_p_cnt <= io_update_meta_s_cnt;
        if (_GEN_22)
          entries_0_s_cnt <= 10'h0;
        else
          entries_0_s_cnt <= casez_tmp_8;
      end
      else if (_GEN_29) begin
        entries_0_age <= _GEN_1;
        entries_0_s_cnt <= _GEN_2;
      end
    end
    else if (_GEN_26 & _GEN_27 & _GEN_30) begin
      entries_0_tag <= casez_tmp_4;
      entries_0_conf <= casez_tmp_6;
      entries_0_age <= casez_tmp_7;
      entries_0_p_cnt <= casez_tmp_5;
      if (_GEN_28)
        entries_0_s_cnt <= io_update_meta_s_cnt;
      else
        entries_0_s_cnt <= casez_tmp_8;
    end
    else if (_GEN_29) begin
      entries_0_age <= _GEN_1;
      entries_0_s_cnt <= _GEN_2;
    end
    if (doing_reset & reset_idx == 4'h1) begin
      entries_1_tag <= 10'h0;
      entries_1_conf <= 3'h0;
      entries_1_age <= 3'h0;
      entries_1_p_cnt <= 10'h0;
      entries_1_s_cnt <= 10'h0;
    end
    else if (_GEN_4) begin
      if (_GEN_32) begin
        if (_GEN_24)
          entries_1_tag <= casez_tmp_4;
        else
          entries_1_tag <= io_update_idx[13:4];
        if (_GEN_5)
          entries_1_conf <= 3'h0;
        else if (_GEN_6)
          entries_1_conf <= casez_tmp_6;
        else if (_GEN_8)
          entries_1_conf <= _wentry_conf_T;
        else if (_GEN_9)
          entries_1_conf <= 3'h0;
        else if (_GEN_19)
          entries_1_conf <= 3'h1;
        else
          entries_1_conf <= casez_tmp_6;
        if (_GEN_25)
          entries_1_age <= casez_tmp_7;
        else if (_GEN_12)
          entries_1_age <= _wentry_age_T;
        else if (_GEN_18)
          entries_1_age <= 3'h7;
        else
          entries_1_age <= casez_tmp_7;
        if (_GEN_23)
          entries_1_p_cnt <= casez_tmp_5;
        else
          entries_1_p_cnt <= io_update_meta_s_cnt;
        if (_GEN_22)
          entries_1_s_cnt <= 10'h0;
        else
          entries_1_s_cnt <= casez_tmp_8;
      end
      else if (_GEN_31) begin
        entries_1_age <= _GEN_1;
        entries_1_s_cnt <= _GEN_2;
      end
    end
    else if (_GEN_26 & _GEN_27 & _GEN_32) begin
      entries_1_tag <= casez_tmp_4;
      entries_1_conf <= casez_tmp_6;
      entries_1_age <= casez_tmp_7;
      entries_1_p_cnt <= casez_tmp_5;
      if (_GEN_28)
        entries_1_s_cnt <= io_update_meta_s_cnt;
      else
        entries_1_s_cnt <= casez_tmp_8;
    end
    else if (_GEN_31) begin
      entries_1_age <= _GEN_1;
      entries_1_s_cnt <= _GEN_2;
    end
    if (doing_reset & reset_idx == 4'h2) begin
      entries_2_tag <= 10'h0;
      entries_2_conf <= 3'h0;
      entries_2_age <= 3'h0;
      entries_2_p_cnt <= 10'h0;
      entries_2_s_cnt <= 10'h0;
    end
    else if (_GEN_4) begin
      if (_GEN_34) begin
        if (_GEN_24)
          entries_2_tag <= casez_tmp_4;
        else
          entries_2_tag <= io_update_idx[13:4];
        if (_GEN_5)
          entries_2_conf <= 3'h0;
        else if (_GEN_6)
          entries_2_conf <= casez_tmp_6;
        else if (_GEN_8)
          entries_2_conf <= _wentry_conf_T;
        else if (_GEN_9)
          entries_2_conf <= 3'h0;
        else if (_GEN_19)
          entries_2_conf <= 3'h1;
        else
          entries_2_conf <= casez_tmp_6;
        if (_GEN_25)
          entries_2_age <= casez_tmp_7;
        else if (_GEN_12)
          entries_2_age <= _wentry_age_T;
        else if (_GEN_18)
          entries_2_age <= 3'h7;
        else
          entries_2_age <= casez_tmp_7;
        if (_GEN_23)
          entries_2_p_cnt <= casez_tmp_5;
        else
          entries_2_p_cnt <= io_update_meta_s_cnt;
        if (_GEN_22)
          entries_2_s_cnt <= 10'h0;
        else
          entries_2_s_cnt <= casez_tmp_8;
      end
      else if (_GEN_33) begin
        entries_2_age <= _GEN_1;
        entries_2_s_cnt <= _GEN_2;
      end
    end
    else if (_GEN_26 & _GEN_27 & _GEN_34) begin
      entries_2_tag <= casez_tmp_4;
      entries_2_conf <= casez_tmp_6;
      entries_2_age <= casez_tmp_7;
      entries_2_p_cnt <= casez_tmp_5;
      if (_GEN_28)
        entries_2_s_cnt <= io_update_meta_s_cnt;
      else
        entries_2_s_cnt <= casez_tmp_8;
    end
    else if (_GEN_33) begin
      entries_2_age <= _GEN_1;
      entries_2_s_cnt <= _GEN_2;
    end
    if (doing_reset & reset_idx == 4'h3) begin
      entries_3_tag <= 10'h0;
      entries_3_conf <= 3'h0;
      entries_3_age <= 3'h0;
      entries_3_p_cnt <= 10'h0;
      entries_3_s_cnt <= 10'h0;
    end
    else if (_GEN_4) begin
      if (_GEN_36) begin
        if (_GEN_24)
          entries_3_tag <= casez_tmp_4;
        else
          entries_3_tag <= io_update_idx[13:4];
        if (_GEN_5)
          entries_3_conf <= 3'h0;
        else if (_GEN_6)
          entries_3_conf <= casez_tmp_6;
        else if (_GEN_8)
          entries_3_conf <= _wentry_conf_T;
        else if (_GEN_9)
          entries_3_conf <= 3'h0;
        else if (_GEN_19)
          entries_3_conf <= 3'h1;
        else
          entries_3_conf <= casez_tmp_6;
        if (_GEN_25)
          entries_3_age <= casez_tmp_7;
        else if (_GEN_12)
          entries_3_age <= _wentry_age_T;
        else if (_GEN_18)
          entries_3_age <= 3'h7;
        else
          entries_3_age <= casez_tmp_7;
        if (_GEN_23)
          entries_3_p_cnt <= casez_tmp_5;
        else
          entries_3_p_cnt <= io_update_meta_s_cnt;
        if (_GEN_22)
          entries_3_s_cnt <= 10'h0;
        else
          entries_3_s_cnt <= casez_tmp_8;
      end
      else if (_GEN_35) begin
        entries_3_age <= _GEN_1;
        entries_3_s_cnt <= _GEN_2;
      end
    end
    else if (_GEN_26 & _GEN_27 & _GEN_36) begin
      entries_3_tag <= casez_tmp_4;
      entries_3_conf <= casez_tmp_6;
      entries_3_age <= casez_tmp_7;
      entries_3_p_cnt <= casez_tmp_5;
      if (_GEN_28)
        entries_3_s_cnt <= io_update_meta_s_cnt;
      else
        entries_3_s_cnt <= casez_tmp_8;
    end
    else if (_GEN_35) begin
      entries_3_age <= _GEN_1;
      entries_3_s_cnt <= _GEN_2;
    end
    if (doing_reset & reset_idx == 4'h4) begin
      entries_4_tag <= 10'h0;
      entries_4_conf <= 3'h0;
      entries_4_age <= 3'h0;
      entries_4_p_cnt <= 10'h0;
      entries_4_s_cnt <= 10'h0;
    end
    else if (_GEN_4) begin
      if (_GEN_38) begin
        if (_GEN_24)
          entries_4_tag <= casez_tmp_4;
        else
          entries_4_tag <= io_update_idx[13:4];
        if (_GEN_5)
          entries_4_conf <= 3'h0;
        else if (_GEN_6)
          entries_4_conf <= casez_tmp_6;
        else if (_GEN_8)
          entries_4_conf <= _wentry_conf_T;
        else if (_GEN_9)
          entries_4_conf <= 3'h0;
        else if (_GEN_19)
          entries_4_conf <= 3'h1;
        else
          entries_4_conf <= casez_tmp_6;
        if (_GEN_25)
          entries_4_age <= casez_tmp_7;
        else if (_GEN_12)
          entries_4_age <= _wentry_age_T;
        else if (_GEN_18)
          entries_4_age <= 3'h7;
        else
          entries_4_age <= casez_tmp_7;
        if (_GEN_23)
          entries_4_p_cnt <= casez_tmp_5;
        else
          entries_4_p_cnt <= io_update_meta_s_cnt;
        if (_GEN_22)
          entries_4_s_cnt <= 10'h0;
        else
          entries_4_s_cnt <= casez_tmp_8;
      end
      else if (_GEN_37) begin
        entries_4_age <= _GEN_1;
        entries_4_s_cnt <= _GEN_2;
      end
    end
    else if (_GEN_26 & _GEN_27 & _GEN_38) begin
      entries_4_tag <= casez_tmp_4;
      entries_4_conf <= casez_tmp_6;
      entries_4_age <= casez_tmp_7;
      entries_4_p_cnt <= casez_tmp_5;
      if (_GEN_28)
        entries_4_s_cnt <= io_update_meta_s_cnt;
      else
        entries_4_s_cnt <= casez_tmp_8;
    end
    else if (_GEN_37) begin
      entries_4_age <= _GEN_1;
      entries_4_s_cnt <= _GEN_2;
    end
    if (doing_reset & reset_idx == 4'h5) begin
      entries_5_tag <= 10'h0;
      entries_5_conf <= 3'h0;
      entries_5_age <= 3'h0;
      entries_5_p_cnt <= 10'h0;
      entries_5_s_cnt <= 10'h0;
    end
    else if (_GEN_4) begin
      if (_GEN_40) begin
        if (_GEN_24)
          entries_5_tag <= casez_tmp_4;
        else
          entries_5_tag <= io_update_idx[13:4];
        if (_GEN_5)
          entries_5_conf <= 3'h0;
        else if (_GEN_6)
          entries_5_conf <= casez_tmp_6;
        else if (_GEN_8)
          entries_5_conf <= _wentry_conf_T;
        else if (_GEN_9)
          entries_5_conf <= 3'h0;
        else if (_GEN_19)
          entries_5_conf <= 3'h1;
        else
          entries_5_conf <= casez_tmp_6;
        if (_GEN_25)
          entries_5_age <= casez_tmp_7;
        else if (_GEN_12)
          entries_5_age <= _wentry_age_T;
        else if (_GEN_18)
          entries_5_age <= 3'h7;
        else
          entries_5_age <= casez_tmp_7;
        if (_GEN_23)
          entries_5_p_cnt <= casez_tmp_5;
        else
          entries_5_p_cnt <= io_update_meta_s_cnt;
        if (_GEN_22)
          entries_5_s_cnt <= 10'h0;
        else
          entries_5_s_cnt <= casez_tmp_8;
      end
      else if (_GEN_39) begin
        entries_5_age <= _GEN_1;
        entries_5_s_cnt <= _GEN_2;
      end
    end
    else if (_GEN_26 & _GEN_27 & _GEN_40) begin
      entries_5_tag <= casez_tmp_4;
      entries_5_conf <= casez_tmp_6;
      entries_5_age <= casez_tmp_7;
      entries_5_p_cnt <= casez_tmp_5;
      if (_GEN_28)
        entries_5_s_cnt <= io_update_meta_s_cnt;
      else
        entries_5_s_cnt <= casez_tmp_8;
    end
    else if (_GEN_39) begin
      entries_5_age <= _GEN_1;
      entries_5_s_cnt <= _GEN_2;
    end
    if (doing_reset & reset_idx == 4'h6) begin
      entries_6_tag <= 10'h0;
      entries_6_conf <= 3'h0;
      entries_6_age <= 3'h0;
      entries_6_p_cnt <= 10'h0;
      entries_6_s_cnt <= 10'h0;
    end
    else if (_GEN_4) begin
      if (_GEN_42) begin
        if (_GEN_24)
          entries_6_tag <= casez_tmp_4;
        else
          entries_6_tag <= io_update_idx[13:4];
        if (_GEN_5)
          entries_6_conf <= 3'h0;
        else if (_GEN_6)
          entries_6_conf <= casez_tmp_6;
        else if (_GEN_8)
          entries_6_conf <= _wentry_conf_T;
        else if (_GEN_9)
          entries_6_conf <= 3'h0;
        else if (_GEN_19)
          entries_6_conf <= 3'h1;
        else
          entries_6_conf <= casez_tmp_6;
        if (_GEN_25)
          entries_6_age <= casez_tmp_7;
        else if (_GEN_12)
          entries_6_age <= _wentry_age_T;
        else if (_GEN_18)
          entries_6_age <= 3'h7;
        else
          entries_6_age <= casez_tmp_7;
        if (_GEN_23)
          entries_6_p_cnt <= casez_tmp_5;
        else
          entries_6_p_cnt <= io_update_meta_s_cnt;
        if (_GEN_22)
          entries_6_s_cnt <= 10'h0;
        else
          entries_6_s_cnt <= casez_tmp_8;
      end
      else if (_GEN_41) begin
        entries_6_age <= _GEN_1;
        entries_6_s_cnt <= _GEN_2;
      end
    end
    else if (_GEN_26 & _GEN_27 & _GEN_42) begin
      entries_6_tag <= casez_tmp_4;
      entries_6_conf <= casez_tmp_6;
      entries_6_age <= casez_tmp_7;
      entries_6_p_cnt <= casez_tmp_5;
      if (_GEN_28)
        entries_6_s_cnt <= io_update_meta_s_cnt;
      else
        entries_6_s_cnt <= casez_tmp_8;
    end
    else if (_GEN_41) begin
      entries_6_age <= _GEN_1;
      entries_6_s_cnt <= _GEN_2;
    end
    if (doing_reset & reset_idx == 4'h7) begin
      entries_7_tag <= 10'h0;
      entries_7_conf <= 3'h0;
      entries_7_age <= 3'h0;
      entries_7_p_cnt <= 10'h0;
      entries_7_s_cnt <= 10'h0;
    end
    else if (_GEN_4) begin
      if (_GEN_44) begin
        if (_GEN_24)
          entries_7_tag <= casez_tmp_4;
        else
          entries_7_tag <= io_update_idx[13:4];
        if (_GEN_5)
          entries_7_conf <= 3'h0;
        else if (_GEN_6)
          entries_7_conf <= casez_tmp_6;
        else if (_GEN_8)
          entries_7_conf <= _wentry_conf_T;
        else if (_GEN_9)
          entries_7_conf <= 3'h0;
        else if (_GEN_19)
          entries_7_conf <= 3'h1;
        else
          entries_7_conf <= casez_tmp_6;
        if (_GEN_25)
          entries_7_age <= casez_tmp_7;
        else if (_GEN_12)
          entries_7_age <= _wentry_age_T;
        else if (_GEN_18)
          entries_7_age <= 3'h7;
        else
          entries_7_age <= casez_tmp_7;
        if (_GEN_23)
          entries_7_p_cnt <= casez_tmp_5;
        else
          entries_7_p_cnt <= io_update_meta_s_cnt;
        if (_GEN_22)
          entries_7_s_cnt <= 10'h0;
        else
          entries_7_s_cnt <= casez_tmp_8;
      end
      else if (_GEN_43) begin
        entries_7_age <= _GEN_1;
        entries_7_s_cnt <= _GEN_2;
      end
    end
    else if (_GEN_26 & _GEN_27 & _GEN_44) begin
      entries_7_tag <= casez_tmp_4;
      entries_7_conf <= casez_tmp_6;
      entries_7_age <= casez_tmp_7;
      entries_7_p_cnt <= casez_tmp_5;
      if (_GEN_28)
        entries_7_s_cnt <= io_update_meta_s_cnt;
      else
        entries_7_s_cnt <= casez_tmp_8;
    end
    else if (_GEN_43) begin
      entries_7_age <= _GEN_1;
      entries_7_s_cnt <= _GEN_2;
    end
    if (doing_reset & reset_idx == 4'h8) begin
      entries_8_tag <= 10'h0;
      entries_8_conf <= 3'h0;
      entries_8_age <= 3'h0;
      entries_8_p_cnt <= 10'h0;
      entries_8_s_cnt <= 10'h0;
    end
    else if (_GEN_4) begin
      if (_GEN_46) begin
        if (_GEN_24)
          entries_8_tag <= casez_tmp_4;
        else
          entries_8_tag <= io_update_idx[13:4];
        if (_GEN_5)
          entries_8_conf <= 3'h0;
        else if (_GEN_6)
          entries_8_conf <= casez_tmp_6;
        else if (_GEN_8)
          entries_8_conf <= _wentry_conf_T;
        else if (_GEN_9)
          entries_8_conf <= 3'h0;
        else if (_GEN_19)
          entries_8_conf <= 3'h1;
        else
          entries_8_conf <= casez_tmp_6;
        if (_GEN_25)
          entries_8_age <= casez_tmp_7;
        else if (_GEN_12)
          entries_8_age <= _wentry_age_T;
        else if (_GEN_18)
          entries_8_age <= 3'h7;
        else
          entries_8_age <= casez_tmp_7;
        if (_GEN_23)
          entries_8_p_cnt <= casez_tmp_5;
        else
          entries_8_p_cnt <= io_update_meta_s_cnt;
        if (_GEN_22)
          entries_8_s_cnt <= 10'h0;
        else
          entries_8_s_cnt <= casez_tmp_8;
      end
      else if (_GEN_45) begin
        entries_8_age <= _GEN_1;
        entries_8_s_cnt <= _GEN_2;
      end
    end
    else if (_GEN_26 & _GEN_27 & _GEN_46) begin
      entries_8_tag <= casez_tmp_4;
      entries_8_conf <= casez_tmp_6;
      entries_8_age <= casez_tmp_7;
      entries_8_p_cnt <= casez_tmp_5;
      if (_GEN_28)
        entries_8_s_cnt <= io_update_meta_s_cnt;
      else
        entries_8_s_cnt <= casez_tmp_8;
    end
    else if (_GEN_45) begin
      entries_8_age <= _GEN_1;
      entries_8_s_cnt <= _GEN_2;
    end
    if (doing_reset & reset_idx == 4'h9) begin
      entries_9_tag <= 10'h0;
      entries_9_conf <= 3'h0;
      entries_9_age <= 3'h0;
      entries_9_p_cnt <= 10'h0;
      entries_9_s_cnt <= 10'h0;
    end
    else if (_GEN_4) begin
      if (_GEN_48) begin
        if (_GEN_24)
          entries_9_tag <= casez_tmp_4;
        else
          entries_9_tag <= io_update_idx[13:4];
        if (_GEN_5)
          entries_9_conf <= 3'h0;
        else if (_GEN_6)
          entries_9_conf <= casez_tmp_6;
        else if (_GEN_8)
          entries_9_conf <= _wentry_conf_T;
        else if (_GEN_9)
          entries_9_conf <= 3'h0;
        else if (_GEN_19)
          entries_9_conf <= 3'h1;
        else
          entries_9_conf <= casez_tmp_6;
        if (_GEN_25)
          entries_9_age <= casez_tmp_7;
        else if (_GEN_12)
          entries_9_age <= _wentry_age_T;
        else if (_GEN_18)
          entries_9_age <= 3'h7;
        else
          entries_9_age <= casez_tmp_7;
        if (_GEN_23)
          entries_9_p_cnt <= casez_tmp_5;
        else
          entries_9_p_cnt <= io_update_meta_s_cnt;
        if (_GEN_22)
          entries_9_s_cnt <= 10'h0;
        else
          entries_9_s_cnt <= casez_tmp_8;
      end
      else if (_GEN_47) begin
        entries_9_age <= _GEN_1;
        entries_9_s_cnt <= _GEN_2;
      end
    end
    else if (_GEN_26 & _GEN_27 & _GEN_48) begin
      entries_9_tag <= casez_tmp_4;
      entries_9_conf <= casez_tmp_6;
      entries_9_age <= casez_tmp_7;
      entries_9_p_cnt <= casez_tmp_5;
      if (_GEN_28)
        entries_9_s_cnt <= io_update_meta_s_cnt;
      else
        entries_9_s_cnt <= casez_tmp_8;
    end
    else if (_GEN_47) begin
      entries_9_age <= _GEN_1;
      entries_9_s_cnt <= _GEN_2;
    end
    if (doing_reset & reset_idx == 4'hA) begin
      entries_10_tag <= 10'h0;
      entries_10_conf <= 3'h0;
      entries_10_age <= 3'h0;
      entries_10_p_cnt <= 10'h0;
      entries_10_s_cnt <= 10'h0;
    end
    else if (_GEN_4) begin
      if (_GEN_50) begin
        if (_GEN_24)
          entries_10_tag <= casez_tmp_4;
        else
          entries_10_tag <= io_update_idx[13:4];
        if (_GEN_5)
          entries_10_conf <= 3'h0;
        else if (_GEN_6)
          entries_10_conf <= casez_tmp_6;
        else if (_GEN_8)
          entries_10_conf <= _wentry_conf_T;
        else if (_GEN_9)
          entries_10_conf <= 3'h0;
        else if (_GEN_19)
          entries_10_conf <= 3'h1;
        else
          entries_10_conf <= casez_tmp_6;
        if (_GEN_25)
          entries_10_age <= casez_tmp_7;
        else if (_GEN_12)
          entries_10_age <= _wentry_age_T;
        else if (_GEN_18)
          entries_10_age <= 3'h7;
        else
          entries_10_age <= casez_tmp_7;
        if (_GEN_23)
          entries_10_p_cnt <= casez_tmp_5;
        else
          entries_10_p_cnt <= io_update_meta_s_cnt;
        if (_GEN_22)
          entries_10_s_cnt <= 10'h0;
        else
          entries_10_s_cnt <= casez_tmp_8;
      end
      else if (_GEN_49) begin
        entries_10_age <= _GEN_1;
        entries_10_s_cnt <= _GEN_2;
      end
    end
    else if (_GEN_26 & _GEN_27 & _GEN_50) begin
      entries_10_tag <= casez_tmp_4;
      entries_10_conf <= casez_tmp_6;
      entries_10_age <= casez_tmp_7;
      entries_10_p_cnt <= casez_tmp_5;
      if (_GEN_28)
        entries_10_s_cnt <= io_update_meta_s_cnt;
      else
        entries_10_s_cnt <= casez_tmp_8;
    end
    else if (_GEN_49) begin
      entries_10_age <= _GEN_1;
      entries_10_s_cnt <= _GEN_2;
    end
    if (doing_reset & reset_idx == 4'hB) begin
      entries_11_tag <= 10'h0;
      entries_11_conf <= 3'h0;
      entries_11_age <= 3'h0;
      entries_11_p_cnt <= 10'h0;
      entries_11_s_cnt <= 10'h0;
    end
    else if (_GEN_4) begin
      if (_GEN_52) begin
        if (_GEN_24)
          entries_11_tag <= casez_tmp_4;
        else
          entries_11_tag <= io_update_idx[13:4];
        if (_GEN_5)
          entries_11_conf <= 3'h0;
        else if (_GEN_6)
          entries_11_conf <= casez_tmp_6;
        else if (_GEN_8)
          entries_11_conf <= _wentry_conf_T;
        else if (_GEN_9)
          entries_11_conf <= 3'h0;
        else if (_GEN_19)
          entries_11_conf <= 3'h1;
        else
          entries_11_conf <= casez_tmp_6;
        if (_GEN_25)
          entries_11_age <= casez_tmp_7;
        else if (_GEN_12)
          entries_11_age <= _wentry_age_T;
        else if (_GEN_18)
          entries_11_age <= 3'h7;
        else
          entries_11_age <= casez_tmp_7;
        if (_GEN_23)
          entries_11_p_cnt <= casez_tmp_5;
        else
          entries_11_p_cnt <= io_update_meta_s_cnt;
        if (_GEN_22)
          entries_11_s_cnt <= 10'h0;
        else
          entries_11_s_cnt <= casez_tmp_8;
      end
      else if (_GEN_51) begin
        entries_11_age <= _GEN_1;
        entries_11_s_cnt <= _GEN_2;
      end
    end
    else if (_GEN_26 & _GEN_27 & _GEN_52) begin
      entries_11_tag <= casez_tmp_4;
      entries_11_conf <= casez_tmp_6;
      entries_11_age <= casez_tmp_7;
      entries_11_p_cnt <= casez_tmp_5;
      if (_GEN_28)
        entries_11_s_cnt <= io_update_meta_s_cnt;
      else
        entries_11_s_cnt <= casez_tmp_8;
    end
    else if (_GEN_51) begin
      entries_11_age <= _GEN_1;
      entries_11_s_cnt <= _GEN_2;
    end
    if (doing_reset & reset_idx == 4'hC) begin
      entries_12_tag <= 10'h0;
      entries_12_conf <= 3'h0;
      entries_12_age <= 3'h0;
      entries_12_p_cnt <= 10'h0;
      entries_12_s_cnt <= 10'h0;
    end
    else if (_GEN_4) begin
      if (_GEN_54) begin
        if (_GEN_24)
          entries_12_tag <= casez_tmp_4;
        else
          entries_12_tag <= io_update_idx[13:4];
        if (_GEN_5)
          entries_12_conf <= 3'h0;
        else if (_GEN_6)
          entries_12_conf <= casez_tmp_6;
        else if (_GEN_8)
          entries_12_conf <= _wentry_conf_T;
        else if (_GEN_9)
          entries_12_conf <= 3'h0;
        else if (_GEN_19)
          entries_12_conf <= 3'h1;
        else
          entries_12_conf <= casez_tmp_6;
        if (_GEN_25)
          entries_12_age <= casez_tmp_7;
        else if (_GEN_12)
          entries_12_age <= _wentry_age_T;
        else if (_GEN_18)
          entries_12_age <= 3'h7;
        else
          entries_12_age <= casez_tmp_7;
        if (_GEN_23)
          entries_12_p_cnt <= casez_tmp_5;
        else
          entries_12_p_cnt <= io_update_meta_s_cnt;
        if (_GEN_22)
          entries_12_s_cnt <= 10'h0;
        else
          entries_12_s_cnt <= casez_tmp_8;
      end
      else if (_GEN_53) begin
        entries_12_age <= _GEN_1;
        entries_12_s_cnt <= _GEN_2;
      end
    end
    else if (_GEN_26 & _GEN_27 & _GEN_54) begin
      entries_12_tag <= casez_tmp_4;
      entries_12_conf <= casez_tmp_6;
      entries_12_age <= casez_tmp_7;
      entries_12_p_cnt <= casez_tmp_5;
      if (_GEN_28)
        entries_12_s_cnt <= io_update_meta_s_cnt;
      else
        entries_12_s_cnt <= casez_tmp_8;
    end
    else if (_GEN_53) begin
      entries_12_age <= _GEN_1;
      entries_12_s_cnt <= _GEN_2;
    end
    if (doing_reset & reset_idx == 4'hD) begin
      entries_13_tag <= 10'h0;
      entries_13_conf <= 3'h0;
      entries_13_age <= 3'h0;
      entries_13_p_cnt <= 10'h0;
      entries_13_s_cnt <= 10'h0;
    end
    else if (_GEN_4) begin
      if (_GEN_56) begin
        if (_GEN_24)
          entries_13_tag <= casez_tmp_4;
        else
          entries_13_tag <= io_update_idx[13:4];
        if (_GEN_5)
          entries_13_conf <= 3'h0;
        else if (_GEN_6)
          entries_13_conf <= casez_tmp_6;
        else if (_GEN_8)
          entries_13_conf <= _wentry_conf_T;
        else if (_GEN_9)
          entries_13_conf <= 3'h0;
        else if (_GEN_19)
          entries_13_conf <= 3'h1;
        else
          entries_13_conf <= casez_tmp_6;
        if (_GEN_25)
          entries_13_age <= casez_tmp_7;
        else if (_GEN_12)
          entries_13_age <= _wentry_age_T;
        else if (_GEN_18)
          entries_13_age <= 3'h7;
        else
          entries_13_age <= casez_tmp_7;
        if (_GEN_23)
          entries_13_p_cnt <= casez_tmp_5;
        else
          entries_13_p_cnt <= io_update_meta_s_cnt;
        if (_GEN_22)
          entries_13_s_cnt <= 10'h0;
        else
          entries_13_s_cnt <= casez_tmp_8;
      end
      else if (_GEN_55) begin
        entries_13_age <= _GEN_1;
        entries_13_s_cnt <= _GEN_2;
      end
    end
    else if (_GEN_26 & _GEN_27 & _GEN_56) begin
      entries_13_tag <= casez_tmp_4;
      entries_13_conf <= casez_tmp_6;
      entries_13_age <= casez_tmp_7;
      entries_13_p_cnt <= casez_tmp_5;
      if (_GEN_28)
        entries_13_s_cnt <= io_update_meta_s_cnt;
      else
        entries_13_s_cnt <= casez_tmp_8;
    end
    else if (_GEN_55) begin
      entries_13_age <= _GEN_1;
      entries_13_s_cnt <= _GEN_2;
    end
    if (doing_reset & reset_idx == 4'hE) begin
      entries_14_tag <= 10'h0;
      entries_14_conf <= 3'h0;
      entries_14_age <= 3'h0;
      entries_14_p_cnt <= 10'h0;
      entries_14_s_cnt <= 10'h0;
    end
    else if (_GEN_4) begin
      if (_GEN_58) begin
        if (_GEN_24)
          entries_14_tag <= casez_tmp_4;
        else
          entries_14_tag <= io_update_idx[13:4];
        if (_GEN_5)
          entries_14_conf <= 3'h0;
        else if (_GEN_6)
          entries_14_conf <= casez_tmp_6;
        else if (_GEN_8)
          entries_14_conf <= _wentry_conf_T;
        else if (_GEN_9)
          entries_14_conf <= 3'h0;
        else if (_GEN_19)
          entries_14_conf <= 3'h1;
        else
          entries_14_conf <= casez_tmp_6;
        if (_GEN_25)
          entries_14_age <= casez_tmp_7;
        else if (_GEN_12)
          entries_14_age <= _wentry_age_T;
        else if (_GEN_18)
          entries_14_age <= 3'h7;
        else
          entries_14_age <= casez_tmp_7;
        if (_GEN_23)
          entries_14_p_cnt <= casez_tmp_5;
        else
          entries_14_p_cnt <= io_update_meta_s_cnt;
        if (_GEN_22)
          entries_14_s_cnt <= 10'h0;
        else
          entries_14_s_cnt <= casez_tmp_8;
      end
      else if (_GEN_57) begin
        entries_14_age <= _GEN_1;
        entries_14_s_cnt <= _GEN_2;
      end
    end
    else if (_GEN_26 & _GEN_27 & _GEN_58) begin
      entries_14_tag <= casez_tmp_4;
      entries_14_conf <= casez_tmp_6;
      entries_14_age <= casez_tmp_7;
      entries_14_p_cnt <= casez_tmp_5;
      if (_GEN_28)
        entries_14_s_cnt <= io_update_meta_s_cnt;
      else
        entries_14_s_cnt <= casez_tmp_8;
    end
    else if (_GEN_57) begin
      entries_14_age <= _GEN_1;
      entries_14_s_cnt <= _GEN_2;
    end
    if (doing_reset & (&reset_idx)) begin
      entries_15_tag <= 10'h0;
      entries_15_conf <= 3'h0;
      entries_15_age <= 3'h0;
      entries_15_p_cnt <= 10'h0;
      entries_15_s_cnt <= 10'h0;
    end
    else if (_GEN_4) begin
      if (&(io_update_idx[3:0])) begin
        if (_GEN_24)
          entries_15_tag <= casez_tmp_4;
        else
          entries_15_tag <= io_update_idx[13:4];
        if (_GEN_5)
          entries_15_conf <= 3'h0;
        else if (_GEN_6)
          entries_15_conf <= casez_tmp_6;
        else if (_GEN_8)
          entries_15_conf <= _wentry_conf_T;
        else if (_GEN_9)
          entries_15_conf <= 3'h0;
        else if (_GEN_19)
          entries_15_conf <= 3'h1;
        else
          entries_15_conf <= casez_tmp_6;
        if (_GEN_25)
          entries_15_age <= casez_tmp_7;
        else if (_GEN_12)
          entries_15_age <= _wentry_age_T;
        else if (_GEN_18)
          entries_15_age <= 3'h7;
        else
          entries_15_age <= casez_tmp_7;
        if (_GEN_23)
          entries_15_p_cnt <= casez_tmp_5;
        else
          entries_15_p_cnt <= io_update_meta_s_cnt;
        if (_GEN_22)
          entries_15_s_cnt <= 10'h0;
        else
          entries_15_s_cnt <= casez_tmp_8;
      end
      else if (_GEN_59) begin
        entries_15_age <= _GEN_1;
        entries_15_s_cnt <= _GEN_2;
      end
    end
    else if (_GEN_26 & _GEN_27 & (&(io_update_idx[3:0]))) begin
      entries_15_tag <= casez_tmp_4;
      entries_15_conf <= casez_tmp_6;
      entries_15_age <= casez_tmp_7;
      entries_15_p_cnt <= casez_tmp_5;
      if (_GEN_28)
        entries_15_s_cnt <= io_update_meta_s_cnt;
      else
        entries_15_s_cnt <= casez_tmp_8;
    end
    else if (_GEN_59) begin
      entries_15_age <= _GEN_1;
      entries_15_s_cnt <= _GEN_2;
    end
    f3_entry_tag <= casez_tmp;
    f3_entry_conf <= casez_tmp_0;
    f3_entry_age <= casez_tmp_1;
    f3_entry_p_cnt <= casez_tmp_2;
    if (io_update_repair & _GEN)
      f3_entry_s_cnt <= io_update_meta_s_cnt;
    else if (io_update_mispredict & _GEN)
      f3_entry_s_cnt <= 10'h0;
    else
      f3_entry_s_cnt <= casez_tmp_3;
    f3_scnt_REG <= io_f2_req_idx;
    f3_tag <= io_f2_req_idx[13:4];
    f4_fire <= io_f3_req_fire;
    f4_entry_tag <= f3_entry_tag;
    f4_entry_conf <= f3_entry_conf;
    f4_entry_age <= f3_entry_age;
    f4_entry_p_cnt <= f3_entry_p_cnt;
    f4_tag <= f3_tag;
    if (_f3_scnt_T_1)
      f4_scnt <= io_update_meta_s_cnt;
    else
      f4_scnt <= f3_entry_s_cnt;
    f4_idx_REG <= io_f2_req_idx;
    f4_idx <= f4_idx_REG;
  end // always @(posedge)
  assign io_f3_pred = f3_entry_tag == f3_tag & f3_scnt == f3_entry_p_cnt & (&f3_entry_conf) ^ io_f3_pred_in;
  assign io_f3_meta_s_cnt = f3_scnt;
endmodule

