// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module FPU(
  input         clock,
                reset,
                io_req_valid,
  input  [6:0]  io_req_bits_uop_uopc,
  input  [19:0] io_req_bits_uop_imm_packed,
  input  [64:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
                io_req_bits_rs3_data,
  input  [2:0]  io_req_bits_fcsr_rm,
  output [64:0] io_resp_bits_data,
  output        io_resp_bits_fflags_valid,
  output [4:0]  io_resp_bits_fflags_bits_flags
);

  wire        _fpmu_io_out_valid;
  wire [64:0] _fpmu_io_out_bits_data;
  wire [4:0]  _fpmu_io_out_bits_exc;
  wire        _fpiu_io_out_bits_lt;
  wire [63:0] _fpiu_io_out_bits_toint;
  wire [4:0]  _fpiu_io_out_bits_exc;
  wire [1:0]  _sfma_io_in_bits_fma_decoder_io_cmd;
  wire        _sfma_io_out_valid;
  wire [64:0] _sfma_io_out_bits_data;
  wire [4:0]  _sfma_io_out_bits_exc;
  wire [1:0]  _dfma_io_in_bits_fma_decoder_io_cmd;
  wire        _dfma_io_out_valid;
  wire [64:0] _dfma_io_out_bits_data;
  wire [4:0]  _dfma_io_out_bits_exc;
  wire        _fp_decoder_io_sigs_ren2;
  wire        _fp_decoder_io_sigs_ren3;
  wire        _fp_decoder_io_sigs_swap23;
  wire [1:0]  _fp_decoder_io_sigs_typeTagIn;
  wire [1:0]  _fp_decoder_io_sigs_typeTagOut;
  wire        _fp_decoder_io_sigs_toint;
  wire        _fp_decoder_io_sigs_fastpipe;
  wire        _fp_decoder_io_sigs_fma;
  wire        _fp_decoder_io_sigs_wflags;
  wire [2:0]  fp_rm = (&(io_req_bits_uop_imm_packed[2:0])) ? io_req_bits_fcsr_rm : io_req_bits_uop_imm_packed[2:0];
  wire        _sfma_io_in_valid_T = io_req_valid & _fp_decoder_io_sigs_fma;
  wire        _fpmu_double_T_1 = _fp_decoder_io_sigs_typeTagOut == 2'h1;
  wire [32:0] _sfma_io_in_bits_req_in2_T_1 = {io_req_bits_rs2_data[31], io_req_bits_rs2_data[52], io_req_bits_rs2_data[30:0]} | ((&(io_req_bits_rs2_data[64:60])) ? 33'h0 : 33'hE0400000);
  wire        _fpiu_io_in_valid_T_2 = io_req_valid & (_fp_decoder_io_sigs_toint | _fp_decoder_io_sigs_fastpipe & _fp_decoder_io_sigs_wflags);
  wire [2:0]  fpiu_io_in_bits_req_in1_expOut_expCode = {io_req_bits_rs1_data[52], io_req_bits_rs1_data[30:29]};
  wire [11:0] _fpiu_io_in_bits_req_in1_expOut_commonCase_T_2 = {3'h0, io_req_bits_rs1_data[52], io_req_bits_rs1_data[30:23]} + 12'h700;
  wire [64:0] fpiu_io_in_bits_req_in1 = _fp_decoder_io_sigs_typeTagIn[0] | (&(io_req_bits_rs1_data[64:60])) ? (_fp_decoder_io_sigs_typeTagIn[0] ? io_req_bits_rs1_data : {io_req_bits_rs1_data[31], fpiu_io_in_bits_req_in1_expOut_expCode == 3'h0 | fpiu_io_in_bits_req_in1_expOut_expCode > 3'h5 ? {io_req_bits_rs1_data[52], io_req_bits_rs1_data[30:29], _fpiu_io_in_bits_req_in1_expOut_commonCase_T_2[8:0]} : _fpiu_io_in_bits_req_in1_expOut_commonCase_T_2, io_req_bits_rs1_data[22:0], 29'h0}) : 65'hE008000000000000;
  wire [2:0]  fpiu_io_in_bits_req_in2_expOut_expCode = {io_req_bits_rs2_data[52], io_req_bits_rs2_data[30:29]};
  wire [11:0] _fpiu_io_in_bits_req_in2_expOut_commonCase_T_2 = {3'h0, io_req_bits_rs2_data[52], io_req_bits_rs2_data[30:23]} + 12'h700;
  wire [64:0] fpiu_io_in_bits_req_in2 = _fp_decoder_io_sigs_typeTagIn[0] | (&(io_req_bits_rs2_data[64:60])) ? (_fp_decoder_io_sigs_typeTagIn[0] ? io_req_bits_rs2_data : {io_req_bits_rs2_data[31], fpiu_io_in_bits_req_in2_expOut_expCode == 3'h0 | fpiu_io_in_bits_req_in2_expOut_expCode > 3'h5 ? {io_req_bits_rs2_data[52], io_req_bits_rs2_data[30:29], _fpiu_io_in_bits_req_in2_expOut_commonCase_T_2[8:0]} : _fpiu_io_in_bits_req_in2_expOut_commonCase_T_2, io_req_bits_rs2_data[22:0], 29'h0}) : 65'hE008000000000000;
  reg         fpiu_out_REG;
  reg         fpiu_out_pipe_v;
  reg  [63:0] fpiu_out_pipe_b_toint;
  reg  [4:0]  fpiu_out_pipe_b_exc;
  reg         fpiu_out_pipe_pipe_v;
  reg  [63:0] fpiu_out_pipe_pipe_b_toint;
  reg  [4:0]  fpiu_out_pipe_pipe_b_exc;
  reg         fpiu_out_valid;
  reg  [63:0] fpiu_out_bits_toint;
  reg  [4:0]  fpiu_result_exc;
  wire        _fpmu_double_T = io_req_valid & _fp_decoder_io_sigs_fastpipe;
  reg         fpmu_double_pipe_v;
  reg         fpmu_double_pipe_b;
  reg         fpmu_double_pipe_pipe_v;
  reg         fpmu_double_pipe_pipe_b;
  reg         fpmu_double_pipe_pipe_pipe_v;
  reg         fpmu_double_pipe_pipe_pipe_b;
  reg         fpmu_double_pipe_pipe_pipe_pipe_b;
  always @(posedge clock) begin
    fpiu_out_REG <= _fpiu_io_in_valid_T_2 & ~_fp_decoder_io_sigs_fastpipe;
    if (fpiu_out_REG) begin
      fpiu_out_pipe_b_toint <= _fpiu_io_out_bits_toint;
      fpiu_out_pipe_b_exc <= _fpiu_io_out_bits_exc;
    end
    if (fpiu_out_pipe_v) begin
      fpiu_out_pipe_pipe_b_toint <= fpiu_out_pipe_b_toint;
      fpiu_out_pipe_pipe_b_exc <= fpiu_out_pipe_b_exc;
    end
    if (fpiu_out_pipe_pipe_v) begin
      fpiu_out_bits_toint <= fpiu_out_pipe_pipe_b_toint;
      fpiu_result_exc <= fpiu_out_pipe_pipe_b_exc;
    end
    if (_fpmu_double_T)
      fpmu_double_pipe_b <= _fpmu_double_T_1;
    if (fpmu_double_pipe_v)
      fpmu_double_pipe_pipe_b <= fpmu_double_pipe_b;
    if (fpmu_double_pipe_pipe_v)
      fpmu_double_pipe_pipe_pipe_b <= fpmu_double_pipe_pipe_b;
    if (fpmu_double_pipe_pipe_pipe_v)
      fpmu_double_pipe_pipe_pipe_pipe_b <= fpmu_double_pipe_pipe_pipe_b;
    if (reset) begin
      fpiu_out_pipe_v <= 1'h0;
      fpiu_out_pipe_pipe_v <= 1'h0;
      fpiu_out_valid <= 1'h0;
      fpmu_double_pipe_v <= 1'h0;
      fpmu_double_pipe_pipe_v <= 1'h0;
      fpmu_double_pipe_pipe_pipe_v <= 1'h0;
    end
    else begin
      fpiu_out_pipe_v <= fpiu_out_REG;
      fpiu_out_pipe_pipe_v <= fpiu_out_pipe_v;
      fpiu_out_valid <= fpiu_out_pipe_pipe_v;
      fpmu_double_pipe_v <= _fpmu_double_T;
      fpmu_double_pipe_pipe_v <= fpmu_double_pipe_v;
      fpmu_double_pipe_pipe_pipe_v <= fpmu_double_pipe_pipe_v;
    end
  end // always @(posedge)
  UOPCodeFPUDecoder fp_decoder (
    .io_uopc            (io_req_bits_uop_uopc),
    .io_sigs_ren2       (_fp_decoder_io_sigs_ren2),
    .io_sigs_ren3       (_fp_decoder_io_sigs_ren3),
    .io_sigs_swap23     (_fp_decoder_io_sigs_swap23),
    .io_sigs_typeTagIn  (_fp_decoder_io_sigs_typeTagIn),
    .io_sigs_typeTagOut (_fp_decoder_io_sigs_typeTagOut),
    .io_sigs_fromint    (/* unused */),
    .io_sigs_toint      (_fp_decoder_io_sigs_toint),
    .io_sigs_fastpipe   (_fp_decoder_io_sigs_fastpipe),
    .io_sigs_fma        (_fp_decoder_io_sigs_fma),
    .io_sigs_wflags     (_fp_decoder_io_sigs_wflags)
  );
  FPUFMAPipe dfma (
    .clock             (clock),
    .reset             (reset),
    .io_in_valid       (_sfma_io_in_valid_T & _fpmu_double_T_1),
    .io_in_bits_ren3   (_fp_decoder_io_sigs_ren3),
    .io_in_bits_swap23 (_fp_decoder_io_sigs_swap23),
    .io_in_bits_rm     (fp_rm),
    .io_in_bits_fmaCmd (_dfma_io_in_bits_fma_decoder_io_cmd),
    .io_in_bits_in1    (io_req_bits_rs1_data),
    .io_in_bits_in2    (io_req_bits_rs2_data),
    .io_in_bits_in3    (_fp_decoder_io_sigs_swap23 ? io_req_bits_rs2_data : io_req_bits_rs3_data),
    .io_out_valid      (_dfma_io_out_valid),
    .io_out_bits_data  (_dfma_io_out_bits_data),
    .io_out_bits_exc   (_dfma_io_out_bits_exc)
  );
  FMADecoder dfma_io_in_bits_fma_decoder (
    .io_uopc (io_req_bits_uop_uopc),
    .io_cmd  (_dfma_io_in_bits_fma_decoder_io_cmd)
  );
  FPUFMAPipe_1 sfma (
    .clock             (clock),
    .reset             (reset),
    .io_in_valid       (_sfma_io_in_valid_T & _fp_decoder_io_sigs_typeTagOut == 2'h0),
    .io_in_bits_ren3   (_fp_decoder_io_sigs_ren3),
    .io_in_bits_swap23 (_fp_decoder_io_sigs_swap23),
    .io_in_bits_rm     (fp_rm),
    .io_in_bits_fmaCmd (_sfma_io_in_bits_fma_decoder_io_cmd),
    .io_in_bits_in1    ({32'h0, {io_req_bits_rs1_data[31], io_req_bits_rs1_data[52], io_req_bits_rs1_data[30:0]} | ((&(io_req_bits_rs1_data[64:60])) ? 33'h0 : 33'hE0400000)}),
    .io_in_bits_in2    ({32'h0, _sfma_io_in_bits_req_in2_T_1}),
    .io_in_bits_in3    ({32'h0, _fp_decoder_io_sigs_swap23 ? _sfma_io_in_bits_req_in2_T_1 : {io_req_bits_rs3_data[31], io_req_bits_rs3_data[52], io_req_bits_rs3_data[30:0]} | ((&(io_req_bits_rs3_data[64:60])) ? 33'h0 : 33'hE0400000)}),
    .io_out_valid      (_sfma_io_out_valid),
    .io_out_bits_data  (_sfma_io_out_bits_data),
    .io_out_bits_exc   (_sfma_io_out_bits_exc)
  );
  FMADecoder sfma_io_in_bits_fma_decoder (
    .io_uopc (io_req_bits_uop_uopc),
    .io_cmd  (_sfma_io_in_bits_fma_decoder_io_cmd)
  );
  FPToInt fpiu (
    .clock                 (clock),
    .io_in_valid           (_fpiu_io_in_valid_T_2),
    .io_in_bits_ren2       (_fp_decoder_io_sigs_ren2),
    .io_in_bits_typeTagOut (_fp_decoder_io_sigs_typeTagOut),
    .io_in_bits_wflags     (_fp_decoder_io_sigs_wflags),
    .io_in_bits_rm         (fp_rm),
    .io_in_bits_typ        (io_req_bits_uop_imm_packed[9:8]),
    .io_in_bits_fmt        ({1'h0, io_req_bits_uop_uopc != 7'h46 & (|_fp_decoder_io_sigs_typeTagIn)}),
    .io_in_bits_in1        (fpiu_io_in_bits_req_in1),
    .io_in_bits_in2        (fpiu_io_in_bits_req_in2),
    .io_out_bits_lt        (_fpiu_io_out_bits_lt),
    .io_out_bits_toint     (_fpiu_io_out_bits_toint),
    .io_out_bits_exc       (_fpiu_io_out_bits_exc)
  );
  FPToFP fpmu (
    .clock                 (clock),
    .reset                 (reset),
    .io_in_valid           (_fpmu_double_T),
    .io_in_bits_ren2       (_fp_decoder_io_sigs_ren2),
    .io_in_bits_typeTagOut (_fp_decoder_io_sigs_typeTagOut),
    .io_in_bits_wflags     (_fp_decoder_io_sigs_wflags),
    .io_in_bits_rm         (fp_rm),
    .io_in_bits_in1        (fpiu_io_in_bits_req_in1),
    .io_in_bits_in2        (fpiu_io_in_bits_req_in2),
    .io_lt                 (_fpiu_io_out_bits_lt),
    .io_out_valid          (_fpmu_io_out_valid),
    .io_out_bits_data      (_fpmu_io_out_bits_data),
    .io_out_bits_exc       (_fpmu_io_out_bits_exc)
  );
  assign io_resp_bits_data = _dfma_io_out_valid ? _dfma_io_out_bits_data : _sfma_io_out_valid ? {12'hFFF, _sfma_io_out_bits_data[31], 20'hFFFFF, _sfma_io_out_bits_data[32], _sfma_io_out_bits_data[30:0]} : fpiu_out_valid ? {1'h0, fpiu_out_bits_toint} : fpmu_double_pipe_pipe_pipe_pipe_b ? _fpmu_io_out_bits_data : {12'hFFF, _fpmu_io_out_bits_data[31], 20'hFFFFF, _fpmu_io_out_bits_data[32], _fpmu_io_out_bits_data[30:0]};
  assign io_resp_bits_fflags_valid = fpiu_out_valid | _fpmu_io_out_valid | _sfma_io_out_valid | _dfma_io_out_valid;
  assign io_resp_bits_fflags_bits_flags = _dfma_io_out_valid ? _dfma_io_out_bits_exc : _sfma_io_out_valid ? _sfma_io_out_bits_exc : fpiu_out_valid ? fpiu_result_exc : _fpmu_io_out_bits_exc;
endmodule

