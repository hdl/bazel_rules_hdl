// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BankedStore(
  input          clock,
                 io_sinkC_adr_valid,
                 io_sinkC_adr_bits_noop,
  input  [2:0]   io_sinkC_adr_bits_way,
  input  [9:0]   io_sinkC_adr_bits_set,
  input  [1:0]   io_sinkC_adr_bits_beat,
                 io_sinkC_adr_bits_mask,
  input  [127:0] io_sinkC_dat_data,
  input          io_sinkD_adr_valid,
                 io_sinkD_adr_bits_noop,
  input  [2:0]   io_sinkD_adr_bits_way,
  input  [9:0]   io_sinkD_adr_bits_set,
  input  [2:0]   io_sinkD_adr_bits_beat,
  input  [63:0]  io_sinkD_dat_data,
  input          io_sourceC_adr_valid,
  input  [2:0]   io_sourceC_adr_bits_way,
  input  [9:0]   io_sourceC_adr_bits_set,
  input  [2:0]   io_sourceC_adr_bits_beat,
  input          io_sourceD_radr_valid,
  input  [2:0]   io_sourceD_radr_bits_way,
  input  [9:0]   io_sourceD_radr_bits_set,
  input  [1:0]   io_sourceD_radr_bits_beat,
                 io_sourceD_radr_bits_mask,
  input          io_sourceD_wadr_valid,
  input  [2:0]   io_sourceD_wadr_bits_way,
  input  [9:0]   io_sourceD_wadr_bits_set,
  input  [1:0]   io_sourceD_wadr_bits_beat,
                 io_sourceD_wadr_bits_mask,
  input  [127:0] io_sourceD_wdat_data,
  output         io_sinkC_adr_ready,
                 io_sinkD_adr_ready,
                 io_sourceC_adr_ready,
  output [63:0]  io_sourceC_dat_data,
  output         io_sourceD_radr_ready,
  output [127:0] io_sourceD_rdat_data,
  output         io_sourceD_wadr_ready
);

  wire        readEnable;
  wire        writeEnable;
  wire        readEnable_0;
  wire        writeEnable_0;
  wire        readEnable_1;
  wire        writeEnable_1;
  wire        readEnable_2;
  wire        writeEnable_2;
  wire        readEnable_3;
  wire        writeEnable_3;
  wire        readEnable_4;
  wire        writeEnable_4;
  wire        readEnable_5;
  wire        writeEnable_5;
  wire        readEnable_6;
  wire        writeEnable_6;
  wire [63:0] _cc_banks_7_ext_RW0_rdata;
  wire [63:0] _cc_banks_6_ext_RW0_rdata;
  wire [63:0] _cc_banks_5_ext_RW0_rdata;
  wire [63:0] _cc_banks_4_ext_RW0_rdata;
  wire [63:0] _cc_banks_3_ext_RW0_rdata;
  wire [63:0] _cc_banks_2_ext_RW0_rdata;
  wire [63:0] _cc_banks_1_ext_RW0_rdata;
  wire [63:0] _cc_banks_0_ext_RW0_rdata;
  wire [3:0]  _sinkC_req_io_sinkC_adr_ready_T_1 = 4'hF >> io_sinkC_adr_bits_beat;
  wire [12:0] sinkC_req_index = {io_sinkC_adr_bits_way, io_sinkC_adr_bits_set};
  wire [7:0]  _sinkC_req_out_bankSel_T_15 = {{2{&io_sinkC_adr_bits_beat}}, {2{io_sinkC_adr_bits_beat == 2'h2}}, {2{io_sinkC_adr_bits_beat == 2'h1}}, {2{io_sinkC_adr_bits_beat == 2'h0}}} & {2{{2{io_sinkC_adr_bits_mask}}}};
  wire [7:0]  sinkC_req_bankSel = io_sinkC_adr_valid ? _sinkC_req_out_bankSel_T_15 : 8'h0;
  wire [7:0]  sinkC_req_bankEn = io_sinkC_adr_bits_noop | ~io_sinkC_adr_valid ? 8'h0 : _sinkC_req_out_bankSel_T_15;
  wire [7:0]  _GEN = {5'h0, io_sinkD_adr_bits_beat};
  wire [7:0]  _GEN_0 = {5'h0, io_sourceC_adr_bits_beat};
  wire [7:0]  sourceC_req_bankSel = io_sourceC_adr_valid ? 8'h1 << _GEN_0 : 8'h0;
  wire [7:0]  sinkD_req_bankSum = sourceC_req_bankSel | sinkC_req_bankSel;
  wire [7:0]  sinkD_req_ready = {~(sinkD_req_bankSum[7]), ~(sinkD_req_bankSum[6]), ~(sinkD_req_bankSum[5]), ~(sinkD_req_bankSum[4]), ~(sinkD_req_bankSum[3]), ~(sinkD_req_bankSum[2]), ~(sinkD_req_bankSum[1]), ~(sinkD_req_bankSum[0])};
  wire [7:0]  _sinkD_req_io_sinkD_adr_ready_T_1 = sinkD_req_ready >> _GEN;
  wire [12:0] sinkD_req_index = {io_sinkD_adr_bits_way, io_sinkD_adr_bits_set};
  wire [7:0]  sinkD_req_bankSel = io_sinkD_adr_valid ? 8'h1 << _GEN : 8'h0;
  wire [7:0]  sinkD_req_bankEn = io_sinkD_adr_bits_noop ? 8'h0 : sinkD_req_bankSel & sinkD_req_ready;
  wire [7:0]  sourceC_req_ready = {~(sinkC_req_bankSel[7]), ~(sinkC_req_bankSel[6]), ~(sinkC_req_bankSel[5]), ~(sinkC_req_bankSel[4]), ~(sinkC_req_bankSel[3]), ~(sinkC_req_bankSel[2]), ~(sinkC_req_bankSel[1]), ~(sinkC_req_bankSel[0])};
  wire [7:0]  _sourceC_req_io_sourceC_adr_ready_T_1 = sourceC_req_ready >> _GEN_0;
  wire [12:0] sourceC_req_index = {io_sourceC_adr_bits_way, io_sourceC_adr_bits_set};
  wire [7:0]  sourceD_wreq_bankSel = io_sourceD_wadr_valid ? {{2{&io_sourceD_wadr_bits_beat}}, {2{io_sourceD_wadr_bits_beat == 2'h2}}, {2{io_sourceD_wadr_bits_beat == 2'h1}}, {2{io_sourceD_wadr_bits_beat == 2'h0}}} & {2{{2{io_sourceD_wadr_bits_mask}}}} : 8'h0;
  wire [7:0]  sourceD_wreq_bankSum = sinkD_req_bankSel | sinkD_req_bankSum;
  wire [7:0]  sourceD_rreq_bankSum = sourceD_wreq_bankSel | sourceD_wreq_bankSum;
  wire        _sourceD_rreq_ready_T_3 = (sourceD_rreq_bankSum[1:0] & io_sourceD_radr_bits_mask) == 2'h0;
  wire        _sourceD_rreq_ready_T_7 = (sourceD_rreq_bankSum[3:2] & io_sourceD_radr_bits_mask) == 2'h0;
  wire        _sourceD_rreq_ready_T_11 = (sourceD_rreq_bankSum[5:4] & io_sourceD_radr_bits_mask) == 2'h0;
  wire        _sourceD_rreq_ready_T_15 = (sourceD_rreq_bankSum[7:6] & io_sourceD_radr_bits_mask) == 2'h0;
  wire [3:0]  _sourceD_rreq_io_sourceD_radr_ready_T_1 = {_sourceD_rreq_ready_T_15, _sourceD_rreq_ready_T_11, _sourceD_rreq_ready_T_7, _sourceD_rreq_ready_T_3} >> io_sourceD_radr_bits_beat;
  wire [12:0] sourceD_rreq_index = {io_sourceD_radr_bits_way, io_sourceD_radr_bits_set};
  wire [7:0]  sourceD_rreq_bankSel = io_sourceD_radr_valid ? {{2{&io_sourceD_radr_bits_beat}}, {2{io_sourceD_radr_bits_beat == 2'h2}}, {2{io_sourceD_radr_bits_beat == 2'h1}}, {2{io_sourceD_radr_bits_beat == 2'h0}}} & {2{{2{io_sourceD_radr_bits_mask}}}} : 8'h0;
  wire        _sourceD_wreq_ready_T_3 = (sourceD_wreq_bankSum[1:0] & io_sourceD_wadr_bits_mask) == 2'h0;
  wire        _sourceD_wreq_ready_T_7 = (sourceD_wreq_bankSum[3:2] & io_sourceD_wadr_bits_mask) == 2'h0;
  wire        _sourceD_wreq_ready_T_11 = (sourceD_wreq_bankSum[5:4] & io_sourceD_wadr_bits_mask) == 2'h0;
  wire        _sourceD_wreq_ready_T_15 = (sourceD_wreq_bankSum[7:6] & io_sourceD_wadr_bits_mask) == 2'h0;
  wire [3:0]  _sourceD_wreq_io_sourceD_wadr_ready_T_1 = {_sourceD_wreq_ready_T_15, _sourceD_wreq_ready_T_11, _sourceD_wreq_ready_T_7, _sourceD_wreq_ready_T_3} >> io_sourceD_wadr_bits_beat;
  wire [12:0] sourceD_wreq_index = {io_sourceD_wadr_bits_way, io_sourceD_wadr_bits_set};
  wire        regout_en = sinkC_req_bankEn[0] | sourceC_req_bankSel[0] & ~(sinkC_req_bankSel[0]) | sinkD_req_bankEn[0] | sourceD_wreq_bankSel[0] & _sourceD_wreq_ready_T_3 | sourceD_rreq_bankSel[0] & _sourceD_rreq_ready_T_3;
  wire        regout_wen = sinkC_req_bankSel[0] | ~(sourceC_req_bankSel[0]) & (sinkD_req_bankSel[0] | sourceD_wreq_bankSel[0]);
  assign writeEnable_6 = regout_wen & regout_en;
  assign readEnable_6 = ~regout_wen & regout_en;
  reg         regout_REG;
  reg  [63:0] regout_r;
  wire        regout_en_1 = sinkC_req_bankEn[1] | sourceC_req_bankSel[1] & ~(sinkC_req_bankSel[1]) | sinkD_req_bankEn[1] | sourceD_wreq_bankSel[1] & _sourceD_wreq_ready_T_3 | sourceD_rreq_bankSel[1] & _sourceD_rreq_ready_T_3;
  wire        regout_wen_1 = sinkC_req_bankSel[1] | ~(sourceC_req_bankSel[1]) & (sinkD_req_bankSel[1] | sourceD_wreq_bankSel[1]);
  assign writeEnable_5 = regout_wen_1 & regout_en_1;
  assign readEnable_5 = ~regout_wen_1 & regout_en_1;
  reg         regout_REG_1;
  reg  [63:0] regout_1;
  wire        regout_en_2 = sinkC_req_bankEn[2] | sourceC_req_bankSel[2] & ~(sinkC_req_bankSel[2]) | sinkD_req_bankEn[2] | sourceD_wreq_bankSel[2] & _sourceD_wreq_ready_T_7 | sourceD_rreq_bankSel[2] & _sourceD_rreq_ready_T_7;
  wire        regout_wen_2 = sinkC_req_bankSel[2] | ~(sourceC_req_bankSel[2]) & (sinkD_req_bankSel[2] | sourceD_wreq_bankSel[2]);
  assign writeEnable_4 = regout_wen_2 & regout_en_2;
  assign readEnable_4 = ~regout_wen_2 & regout_en_2;
  reg         regout_REG_2;
  reg  [63:0] regout_2;
  wire        regout_en_3 = sinkC_req_bankEn[3] | sourceC_req_bankSel[3] & ~(sinkC_req_bankSel[3]) | sinkD_req_bankEn[3] | sourceD_wreq_bankSel[3] & _sourceD_wreq_ready_T_7 | sourceD_rreq_bankSel[3] & _sourceD_rreq_ready_T_7;
  wire        regout_wen_3 = sinkC_req_bankSel[3] | ~(sourceC_req_bankSel[3]) & (sinkD_req_bankSel[3] | sourceD_wreq_bankSel[3]);
  assign writeEnable_3 = regout_wen_3 & regout_en_3;
  assign readEnable_3 = ~regout_wen_3 & regout_en_3;
  reg         regout_REG_3;
  reg  [63:0] regout_3;
  wire        regout_en_4 = sinkC_req_bankEn[4] | sourceC_req_bankSel[4] & ~(sinkC_req_bankSel[4]) | sinkD_req_bankEn[4] | sourceD_wreq_bankSel[4] & _sourceD_wreq_ready_T_11 | sourceD_rreq_bankSel[4] & _sourceD_rreq_ready_T_11;
  wire        regout_wen_4 = sinkC_req_bankSel[4] | ~(sourceC_req_bankSel[4]) & (sinkD_req_bankSel[4] | sourceD_wreq_bankSel[4]);
  assign writeEnable_2 = regout_wen_4 & regout_en_4;
  assign readEnable_2 = ~regout_wen_4 & regout_en_4;
  reg         regout_REG_4;
  reg  [63:0] regout_4;
  wire        regout_en_5 = sinkC_req_bankEn[5] | sourceC_req_bankSel[5] & ~(sinkC_req_bankSel[5]) | sinkD_req_bankEn[5] | sourceD_wreq_bankSel[5] & _sourceD_wreq_ready_T_11 | sourceD_rreq_bankSel[5] & _sourceD_rreq_ready_T_11;
  wire        regout_wen_5 = sinkC_req_bankSel[5] | ~(sourceC_req_bankSel[5]) & (sinkD_req_bankSel[5] | sourceD_wreq_bankSel[5]);
  assign writeEnable_1 = regout_wen_5 & regout_en_5;
  assign readEnable_1 = ~regout_wen_5 & regout_en_5;
  reg         regout_REG_5;
  reg  [63:0] regout_5;
  wire        regout_en_6 = sinkC_req_bankEn[6] | sourceC_req_bankSel[6] & ~(sinkC_req_bankSel[6]) | sinkD_req_bankEn[6] | sourceD_wreq_bankSel[6] & _sourceD_wreq_ready_T_15 | sourceD_rreq_bankSel[6] & _sourceD_rreq_ready_T_15;
  wire        regout_wen_6 = sinkC_req_bankSel[6] | ~(sourceC_req_bankSel[6]) & (sinkD_req_bankSel[6] | sourceD_wreq_bankSel[6]);
  assign writeEnable_0 = regout_wen_6 & regout_en_6;
  assign readEnable_0 = ~regout_wen_6 & regout_en_6;
  reg         regout_REG_6;
  reg  [63:0] regout_6;
  wire        regout_en_7 = sinkC_req_bankEn[7] | sourceC_req_bankSel[7] & ~(sinkC_req_bankSel[7]) | sinkD_req_bankEn[7] | sourceD_wreq_bankSel[7] & _sourceD_wreq_ready_T_15 | sourceD_rreq_bankSel[7] & _sourceD_rreq_ready_T_15;
  wire        regout_wen_7 = sinkC_req_bankSel[7] | ~(sourceC_req_bankSel[7]) & (sinkD_req_bankSel[7] | sourceD_wreq_bankSel[7]);
  assign writeEnable = regout_wen_7 & regout_en_7;
  assign readEnable = ~regout_wen_7 & regout_en_7;
  reg         regout_REG_7;
  reg  [63:0] regout_7;
  reg  [7:0]  regsel_sourceC_REG;
  reg  [7:0]  regsel_sourceC;
  reg  [7:0]  regsel_sourceD_REG;
  reg  [7:0]  regsel_sourceD;
  always @(posedge clock) begin
    regout_REG <= ~regout_wen & regout_en;
    if (regout_REG)
      regout_r <= _cc_banks_0_ext_RW0_rdata;
    regout_REG_1 <= ~regout_wen_1 & regout_en_1;
    if (regout_REG_1)
      regout_1 <= _cc_banks_1_ext_RW0_rdata;
    regout_REG_2 <= ~regout_wen_2 & regout_en_2;
    if (regout_REG_2)
      regout_2 <= _cc_banks_2_ext_RW0_rdata;
    regout_REG_3 <= ~regout_wen_3 & regout_en_3;
    if (regout_REG_3)
      regout_3 <= _cc_banks_3_ext_RW0_rdata;
    regout_REG_4 <= ~regout_wen_4 & regout_en_4;
    if (regout_REG_4)
      regout_4 <= _cc_banks_4_ext_RW0_rdata;
    regout_REG_5 <= ~regout_wen_5 & regout_en_5;
    if (regout_REG_5)
      regout_5 <= _cc_banks_5_ext_RW0_rdata;
    regout_REG_6 <= ~regout_wen_6 & regout_en_6;
    if (regout_REG_6)
      regout_6 <= _cc_banks_6_ext_RW0_rdata;
    regout_REG_7 <= ~regout_wen_7 & regout_en_7;
    if (regout_REG_7)
      regout_7 <= _cc_banks_7_ext_RW0_rdata;
    regsel_sourceC_REG <= sourceC_req_bankSel & sourceC_req_ready;
    regsel_sourceC <= regsel_sourceC_REG;
    regsel_sourceD_REG <= sourceD_rreq_bankSel & {{2{_sourceD_rreq_ready_T_15}}, {2{_sourceD_rreq_ready_T_11}}, {2{_sourceD_rreq_ready_T_7}}, {2{_sourceD_rreq_ready_T_3}}};
    regsel_sourceD <= regsel_sourceD_REG;
  end // always @(posedge)
  cc_banks_8192x64 cc_banks_0_ext (
    .RW0_addr  (sinkC_req_bankSel[0] ? sinkC_req_index : sourceC_req_bankSel[0] ? sourceC_req_index : sinkD_req_bankSel[0] ? sinkD_req_index : sourceD_wreq_bankSel[0] ? sourceD_wreq_index : sourceD_rreq_index),
    .RW0_en    (readEnable_6 | writeEnable_6),
    .RW0_clk   (clock),
    .RW0_wmode (regout_wen),
    .RW0_wdata (sinkC_req_bankSel[0] ? io_sinkC_dat_data[63:0] : sourceC_req_bankSel[0] ? 64'h0 : sinkD_req_bankSel[0] ? io_sinkD_dat_data : sourceD_wreq_bankSel[0] ? io_sourceD_wdat_data[63:0] : 64'h0),
    .RW0_rdata (_cc_banks_0_ext_RW0_rdata)
  );
  cc_banks_8192x64 cc_banks_1_ext (
    .RW0_addr  (sinkC_req_bankSel[1] ? sinkC_req_index : sourceC_req_bankSel[1] ? sourceC_req_index : sinkD_req_bankSel[1] ? sinkD_req_index : sourceD_wreq_bankSel[1] ? sourceD_wreq_index : sourceD_rreq_index),
    .RW0_en    (readEnable_5 | writeEnable_5),
    .RW0_clk   (clock),
    .RW0_wmode (regout_wen_1),
    .RW0_wdata (sinkC_req_bankSel[1] ? io_sinkC_dat_data[127:64] : sourceC_req_bankSel[1] ? 64'h0 : sinkD_req_bankSel[1] ? io_sinkD_dat_data : sourceD_wreq_bankSel[1] ? io_sourceD_wdat_data[127:64] : 64'h0),
    .RW0_rdata (_cc_banks_1_ext_RW0_rdata)
  );
  cc_banks_8192x64 cc_banks_2_ext (
    .RW0_addr  (sinkC_req_bankSel[2] ? sinkC_req_index : sourceC_req_bankSel[2] ? sourceC_req_index : sinkD_req_bankSel[2] ? sinkD_req_index : sourceD_wreq_bankSel[2] ? sourceD_wreq_index : sourceD_rreq_index),
    .RW0_en    (readEnable_4 | writeEnable_4),
    .RW0_clk   (clock),
    .RW0_wmode (regout_wen_2),
    .RW0_wdata (sinkC_req_bankSel[2] ? io_sinkC_dat_data[63:0] : sourceC_req_bankSel[2] ? 64'h0 : sinkD_req_bankSel[2] ? io_sinkD_dat_data : sourceD_wreq_bankSel[2] ? io_sourceD_wdat_data[63:0] : 64'h0),
    .RW0_rdata (_cc_banks_2_ext_RW0_rdata)
  );
  cc_banks_8192x64 cc_banks_3_ext (
    .RW0_addr  (sinkC_req_bankSel[3] ? sinkC_req_index : sourceC_req_bankSel[3] ? sourceC_req_index : sinkD_req_bankSel[3] ? sinkD_req_index : sourceD_wreq_bankSel[3] ? sourceD_wreq_index : sourceD_rreq_index),
    .RW0_en    (readEnable_3 | writeEnable_3),
    .RW0_clk   (clock),
    .RW0_wmode (regout_wen_3),
    .RW0_wdata (sinkC_req_bankSel[3] ? io_sinkC_dat_data[127:64] : sourceC_req_bankSel[3] ? 64'h0 : sinkD_req_bankSel[3] ? io_sinkD_dat_data : sourceD_wreq_bankSel[3] ? io_sourceD_wdat_data[127:64] : 64'h0),
    .RW0_rdata (_cc_banks_3_ext_RW0_rdata)
  );
  cc_banks_8192x64 cc_banks_4_ext (
    .RW0_addr  (sinkC_req_bankSel[4] ? sinkC_req_index : sourceC_req_bankSel[4] ? sourceC_req_index : sinkD_req_bankSel[4] ? sinkD_req_index : sourceD_wreq_bankSel[4] ? sourceD_wreq_index : sourceD_rreq_index),
    .RW0_en    (readEnable_2 | writeEnable_2),
    .RW0_clk   (clock),
    .RW0_wmode (regout_wen_4),
    .RW0_wdata (sinkC_req_bankSel[4] ? io_sinkC_dat_data[63:0] : sourceC_req_bankSel[4] ? 64'h0 : sinkD_req_bankSel[4] ? io_sinkD_dat_data : sourceD_wreq_bankSel[4] ? io_sourceD_wdat_data[63:0] : 64'h0),
    .RW0_rdata (_cc_banks_4_ext_RW0_rdata)
  );
  cc_banks_8192x64 cc_banks_5_ext (
    .RW0_addr  (sinkC_req_bankSel[5] ? sinkC_req_index : sourceC_req_bankSel[5] ? sourceC_req_index : sinkD_req_bankSel[5] ? sinkD_req_index : sourceD_wreq_bankSel[5] ? sourceD_wreq_index : sourceD_rreq_index),
    .RW0_en    (readEnable_1 | writeEnable_1),
    .RW0_clk   (clock),
    .RW0_wmode (regout_wen_5),
    .RW0_wdata (sinkC_req_bankSel[5] ? io_sinkC_dat_data[127:64] : sourceC_req_bankSel[5] ? 64'h0 : sinkD_req_bankSel[5] ? io_sinkD_dat_data : sourceD_wreq_bankSel[5] ? io_sourceD_wdat_data[127:64] : 64'h0),
    .RW0_rdata (_cc_banks_5_ext_RW0_rdata)
  );
  cc_banks_8192x64 cc_banks_6_ext (
    .RW0_addr  (sinkC_req_bankSel[6] ? sinkC_req_index : sourceC_req_bankSel[6] ? sourceC_req_index : sinkD_req_bankSel[6] ? sinkD_req_index : sourceD_wreq_bankSel[6] ? sourceD_wreq_index : sourceD_rreq_index),
    .RW0_en    (readEnable_0 | writeEnable_0),
    .RW0_clk   (clock),
    .RW0_wmode (regout_wen_6),
    .RW0_wdata (sinkC_req_bankSel[6] ? io_sinkC_dat_data[63:0] : sourceC_req_bankSel[6] ? 64'h0 : sinkD_req_bankSel[6] ? io_sinkD_dat_data : sourceD_wreq_bankSel[6] ? io_sourceD_wdat_data[63:0] : 64'h0),
    .RW0_rdata (_cc_banks_6_ext_RW0_rdata)
  );
  cc_banks_8192x64 cc_banks_7_ext (
    .RW0_addr  (sinkC_req_bankSel[7] ? sinkC_req_index : sourceC_req_bankSel[7] ? sourceC_req_index : sinkD_req_bankSel[7] ? sinkD_req_index : sourceD_wreq_bankSel[7] ? sourceD_wreq_index : sourceD_rreq_index),
    .RW0_en    (readEnable | writeEnable),
    .RW0_clk   (clock),
    .RW0_wmode (regout_wen_7),
    .RW0_wdata (sinkC_req_bankSel[7] ? io_sinkC_dat_data[127:64] : sourceC_req_bankSel[7] ? 64'h0 : sinkD_req_bankSel[7] ? io_sinkD_dat_data : sourceD_wreq_bankSel[7] ? io_sourceD_wdat_data[127:64] : 64'h0),
    .RW0_rdata (_cc_banks_7_ext_RW0_rdata)
  );
  assign io_sinkC_adr_ready = _sinkC_req_io_sinkC_adr_ready_T_1[0];
  assign io_sinkD_adr_ready = _sinkD_req_io_sinkD_adr_ready_T_1[0];
  assign io_sourceC_adr_ready = _sourceC_req_io_sourceC_adr_ready_T_1[0];
  assign io_sourceC_dat_data = (regsel_sourceC[0] ? regout_r : 64'h0) | (regsel_sourceC[1] ? regout_1 : 64'h0) | (regsel_sourceC[2] ? regout_2 : 64'h0) | (regsel_sourceC[3] ? regout_3 : 64'h0) | (regsel_sourceC[4] ? regout_4 : 64'h0) | (regsel_sourceC[5] ? regout_5 : 64'h0) | (regsel_sourceC[6] ? regout_6 : 64'h0) | (regsel_sourceC[7] ? regout_7 : 64'h0);
  assign io_sourceD_radr_ready = _sourceD_rreq_io_sourceD_radr_ready_T_1[0];
  assign io_sourceD_rdat_data = {(regsel_sourceD[1] ? regout_1 : 64'h0) | (regsel_sourceD[3] ? regout_3 : 64'h0) | (regsel_sourceD[5] ? regout_5 : 64'h0) | (regsel_sourceD[7] ? regout_7 : 64'h0), (regsel_sourceD[0] ? regout_r : 64'h0) | (regsel_sourceD[2] ? regout_2 : 64'h0) | (regsel_sourceD[4] ? regout_4 : 64'h0) | (regsel_sourceD[6] ? regout_6 : 64'h0)};
  assign io_sourceD_wadr_ready = _sourceD_wreq_io_sourceD_wadr_ready_T_1[0];
endmodule

