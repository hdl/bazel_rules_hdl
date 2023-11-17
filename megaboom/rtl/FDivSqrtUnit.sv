// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module FDivSqrtUnit(
  input         clock,
                reset,
                io_req_valid,
  input  [6:0]  io_req_bits_uop_uopc,
  input  [19:0] io_req_bits_uop_br_mask,
                io_req_bits_uop_imm_packed,
  input  [6:0]  io_req_bits_uop_rob_idx,
                io_req_bits_uop_pdst,
  input         io_req_bits_uop_is_amo,
                io_req_bits_uop_uses_ldq,
                io_req_bits_uop_uses_stq,
  input  [1:0]  io_req_bits_uop_dst_rtype,
  input         io_req_bits_uop_fp_val,
  input  [64:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
  input         io_req_bits_kill,
                io_resp_ready,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input  [2:0]  io_fcsr_rm,
  output        io_req_ready,
                io_resp_valid,
  output [6:0]  io_resp_bits_uop_rob_idx,
                io_resp_bits_uop_pdst,
  output        io_resp_bits_uop_is_amo,
                io_resp_bits_uop_uses_ldq,
                io_resp_bits_uop_uses_stq,
  output [1:0]  io_resp_bits_uop_dst_rtype,
  output        io_resp_bits_uop_fp_val,
  output [64:0] io_resp_bits_data,
  output        io_resp_bits_fflags_valid,
  output [6:0]  io_resp_bits_fflags_bits_uop_rob_idx,
  output [4:0]  io_resp_bits_fflags_bits_flags
);

  wire [32:0] _downvert_d2s_io_out;
  wire [4:0]  _downvert_d2s_io_exceptionFlags;
  wire        _divsqrt_io_inReady_div;
  wire        _divsqrt_io_inReady_sqrt;
  wire        _divsqrt_io_outValid_div;
  wire        _divsqrt_io_outValid_sqrt;
  wire [64:0] _divsqrt_io_out;
  wire [4:0]  _divsqrt_io_exceptionFlags;
  wire [64:0] _in2_upconvert_s2d_io_out;
  wire [64:0] _in1_upconvert_s2d_io_out;
  wire [1:0]  _fdiv_decoder_io_sigs_typeTagIn;
  wire        _fdiv_decoder_io_sigs_div;
  wire        _fdiv_decoder_io_sigs_sqrt;
  reg         r_buffer_val;
  reg  [19:0] r_buffer_req_uop_br_mask;
  reg  [6:0]  r_buffer_req_uop_rob_idx;
  reg  [6:0]  r_buffer_req_uop_pdst;
  reg         r_buffer_req_uop_is_amo;
  reg         r_buffer_req_uop_uses_ldq;
  reg         r_buffer_req_uop_uses_stq;
  reg  [1:0]  r_buffer_req_uop_dst_rtype;
  reg         r_buffer_req_uop_fp_val;
  reg  [1:0]  r_buffer_fin_typeTagIn;
  reg         r_buffer_fin_div;
  reg         r_buffer_fin_sqrt;
  reg  [2:0]  r_buffer_fin_rm;
  reg  [64:0] r_buffer_fin_in1;
  reg  [64:0] r_buffer_fin_in2;
  reg         r_divsqrt_val;
  reg         r_divsqrt_killed;
  reg  [1:0]  r_divsqrt_fin_typeTagIn;
  reg  [2:0]  r_divsqrt_fin_rm;
  reg  [19:0] r_divsqrt_uop_br_mask;
  reg  [6:0]  r_divsqrt_uop_rob_idx;
  reg  [6:0]  r_divsqrt_uop_pdst;
  reg         r_divsqrt_uop_is_amo;
  reg         r_divsqrt_uop_uses_ldq;
  reg         r_divsqrt_uop_uses_stq;
  reg  [1:0]  r_divsqrt_uop_dst_rtype;
  reg         r_divsqrt_uop_fp_val;
  reg         r_out_val;
  wire        may_fire_input = r_buffer_val & (r_buffer_fin_div | r_buffer_fin_sqrt) & ~r_divsqrt_val & ~r_out_val;
  reg  [19:0] r_out_uop_br_mask;
  reg  [6:0]  r_out_uop_rob_idx;
  reg  [6:0]  r_out_uop_pdst;
  reg         r_out_uop_is_amo;
  reg         r_out_uop_uses_ldq;
  reg         r_out_uop_uses_stq;
  reg  [1:0]  r_out_uop_dst_rtype;
  reg         r_out_uop_fp_val;
  reg  [4:0]  r_out_flags_double;
  reg  [64:0] r_out_wdata_double;
  wire [19:0] _io_resp_valid_T = io_brupdate_b1_mispredict_mask & r_out_uop_br_mask;
  wire        _GEN = _divsqrt_io_outValid_div | _divsqrt_io_outValid_sqrt;
  wire        _io_resp_bits_data_T = r_divsqrt_fin_typeTagIn == 2'h0;
  wire        _io_resp_valid_output = r_out_val & _io_resp_valid_T == 20'h0;
  wire [19:0] _r_divsqrt_killed_T_4 = io_brupdate_b1_mispredict_mask & r_buffer_req_uop_br_mask;
  wire        _GEN_0 = io_req_valid & (io_brupdate_b1_mispredict_mask & io_req_bits_uop_br_mask) == 20'h0 & ~io_req_bits_kill;
  wire [19:0] _r_out_val_T_1 = io_brupdate_b1_mispredict_mask & r_divsqrt_uop_br_mask;
  wire        _GEN_1 = may_fire_input & (r_buffer_fin_sqrt ? _divsqrt_io_inReady_sqrt : _divsqrt_io_inReady_div);
  always @(posedge clock) begin
    if (reset) begin
      r_buffer_val <= 1'h0;
      r_divsqrt_val <= 1'h0;
      r_out_val <= 1'h0;
    end
    else begin
      r_buffer_val <= ~_GEN_1 & (_GEN_0 | _r_divsqrt_killed_T_4 == 20'h0 & ~io_req_bits_kill & r_buffer_val);
      r_divsqrt_val <= ~_GEN & (_GEN_1 | r_divsqrt_val);
      if (_GEN)
        r_out_val <= ~r_divsqrt_killed & _r_out_val_T_1 == 20'h0 & ~io_req_bits_kill;
      else
        r_out_val <= ~(io_resp_ready | (|_io_resp_valid_T) | io_req_bits_kill) & r_out_val;
    end
    if (_GEN_0) begin
      r_buffer_req_uop_br_mask <= io_req_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;
      r_buffer_req_uop_rob_idx <= io_req_bits_uop_rob_idx;
      r_buffer_req_uop_pdst <= io_req_bits_uop_pdst;
      r_buffer_req_uop_is_amo <= io_req_bits_uop_is_amo;
      r_buffer_req_uop_uses_ldq <= io_req_bits_uop_uses_ldq;
      r_buffer_req_uop_uses_stq <= io_req_bits_uop_uses_stq;
      r_buffer_req_uop_dst_rtype <= io_req_bits_uop_dst_rtype;
      r_buffer_req_uop_fp_val <= io_req_bits_uop_fp_val;
      r_buffer_fin_typeTagIn <= _fdiv_decoder_io_sigs_typeTagIn;
      r_buffer_fin_div <= _fdiv_decoder_io_sigs_div;
      r_buffer_fin_sqrt <= _fdiv_decoder_io_sigs_sqrt;
      if (&(io_req_bits_uop_imm_packed[2:0]))
        r_buffer_fin_rm <= io_fcsr_rm;
      else
        r_buffer_fin_rm <= io_req_bits_uop_imm_packed[2:0];
      if (_fdiv_decoder_io_sigs_typeTagIn == 2'h0) begin
        r_buffer_fin_in1 <= _in1_upconvert_s2d_io_out;
        r_buffer_fin_in2 <= _in2_upconvert_s2d_io_out;
      end
      else begin
        r_buffer_fin_in1 <= io_req_bits_rs1_data;
        r_buffer_fin_in2 <= io_req_bits_rs2_data;
      end
    end
    else
      r_buffer_req_uop_br_mask <= r_buffer_req_uop_br_mask & ~io_brupdate_b1_resolve_mask;
    if (_GEN_1) begin
      r_divsqrt_killed <= (|_r_divsqrt_killed_T_4) | io_req_bits_kill;
      r_divsqrt_fin_typeTagIn <= r_buffer_fin_typeTagIn;
      r_divsqrt_fin_rm <= r_buffer_fin_rm;
      r_divsqrt_uop_br_mask <= r_buffer_req_uop_br_mask & ~io_brupdate_b1_resolve_mask;
      r_divsqrt_uop_rob_idx <= r_buffer_req_uop_rob_idx;
      r_divsqrt_uop_pdst <= r_buffer_req_uop_pdst;
      r_divsqrt_uop_is_amo <= r_buffer_req_uop_is_amo;
      r_divsqrt_uop_uses_ldq <= r_buffer_req_uop_uses_ldq;
      r_divsqrt_uop_uses_stq <= r_buffer_req_uop_uses_stq;
      r_divsqrt_uop_dst_rtype <= r_buffer_req_uop_dst_rtype;
      r_divsqrt_uop_fp_val <= r_buffer_req_uop_fp_val;
    end
    else begin
      r_divsqrt_killed <= r_divsqrt_killed | (|_r_out_val_T_1) | io_req_bits_kill;
      r_divsqrt_uop_br_mask <= r_divsqrt_uop_br_mask & ~io_brupdate_b1_resolve_mask;
    end
    if (_GEN) begin
      r_out_uop_br_mask <= r_divsqrt_uop_br_mask & ~io_brupdate_b1_resolve_mask;
      r_out_uop_rob_idx <= r_divsqrt_uop_rob_idx;
      r_out_uop_pdst <= r_divsqrt_uop_pdst;
      r_out_uop_is_amo <= r_divsqrt_uop_is_amo;
      r_out_uop_uses_ldq <= r_divsqrt_uop_uses_ldq;
      r_out_uop_uses_stq <= r_divsqrt_uop_uses_stq;
      r_out_uop_dst_rtype <= r_divsqrt_uop_dst_rtype;
      r_out_uop_fp_val <= r_divsqrt_uop_fp_val;
      r_out_flags_double <= _divsqrt_io_exceptionFlags;
      r_out_wdata_double <= ({65{_divsqrt_io_out[63:61] != 3'h7}} | 65'h1EFEFFFFFFFFFFFFF) & _divsqrt_io_out;
    end
    else
      r_out_uop_br_mask <= r_out_uop_br_mask & ~io_brupdate_b1_resolve_mask;
  end // always @(posedge)
  UOPCodeFDivDecoder fdiv_decoder (
    .io_uopc           (io_req_bits_uop_uopc),
    .io_sigs_typeTagIn (_fdiv_decoder_io_sigs_typeTagIn),
    .io_sigs_div       (_fdiv_decoder_io_sigs_div),
    .io_sigs_sqrt      (_fdiv_decoder_io_sigs_sqrt)
  );
  RecFNToRecFN_1 in1_upconvert_s2d (
    .io_in  ({io_req_bits_rs1_data[31], io_req_bits_rs1_data[52], io_req_bits_rs1_data[30:0]} | ((&(io_req_bits_rs1_data[64:60])) ? 33'h0 : 33'hE0400000)),
    .io_out (_in1_upconvert_s2d_io_out)
  );
  RecFNToRecFN_1 in2_upconvert_s2d (
    .io_in  ({io_req_bits_rs2_data[31], io_req_bits_rs2_data[52], io_req_bits_rs2_data[30:0]} | ((&(io_req_bits_rs2_data[64:60])) ? 33'h0 : 33'hE0400000)),
    .io_out (_in2_upconvert_s2d_io_out)
  );
  DivSqrtRecF64 divsqrt (
    .clock             (clock),
    .reset             (reset),
    .io_inValid        (may_fire_input),
    .io_sqrtOp         (r_buffer_fin_sqrt),
    .io_a              (r_buffer_fin_in1),
    .io_b              (r_buffer_fin_sqrt ? r_buffer_fin_in1 : r_buffer_fin_in2),
    .io_roundingMode   (r_buffer_fin_rm),
    .io_inReady_div    (_divsqrt_io_inReady_div),
    .io_inReady_sqrt   (_divsqrt_io_inReady_sqrt),
    .io_outValid_div   (_divsqrt_io_outValid_div),
    .io_outValid_sqrt  (_divsqrt_io_outValid_sqrt),
    .io_out            (_divsqrt_io_out),
    .io_exceptionFlags (_divsqrt_io_exceptionFlags)
  );
  RecFNToRecFN downvert_d2s (
    .io_in             (r_out_wdata_double),
    .io_roundingMode   (r_divsqrt_fin_rm),
    .io_detectTininess (1'h0),
    .io_out            (_downvert_d2s_io_out),
    .io_exceptionFlags (_downvert_d2s_io_exceptionFlags)
  );
  assign io_req_ready = ~r_buffer_val;
  assign io_resp_valid = _io_resp_valid_output;
  assign io_resp_bits_uop_rob_idx = r_out_uop_rob_idx;
  assign io_resp_bits_uop_pdst = r_out_uop_pdst;
  assign io_resp_bits_uop_is_amo = r_out_uop_is_amo;
  assign io_resp_bits_uop_uses_ldq = r_out_uop_uses_ldq;
  assign io_resp_bits_uop_uses_stq = r_out_uop_uses_stq;
  assign io_resp_bits_uop_dst_rtype = r_out_uop_dst_rtype;
  assign io_resp_bits_uop_fp_val = r_out_uop_fp_val;
  assign io_resp_bits_data = _io_resp_bits_data_T ? {12'hFFF, _downvert_d2s_io_out[31], 20'hFFFFF, _downvert_d2s_io_out[32], _downvert_d2s_io_out[30:0]} : r_out_wdata_double;
  assign io_resp_bits_fflags_valid = _io_resp_valid_output;
  assign io_resp_bits_fflags_bits_uop_rob_idx = r_out_uop_rob_idx;
  assign io_resp_bits_fflags_bits_flags = r_out_flags_double | (_io_resp_bits_data_T ? _downvert_d2s_io_exceptionFlags : 5'h0);
endmodule

