// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module IntToFPUnit(
  input         clock,
                reset,
                io_req_valid,
  input  [6:0]  io_req_bits_uop_uopc,
  input  [19:0] io_req_bits_uop_br_mask,
                io_req_bits_uop_imm_packed,
  input  [6:0]  io_req_bits_uop_rob_idx,
  input  [4:0]  io_req_bits_uop_stq_idx,
  input  [6:0]  io_req_bits_uop_pdst,
  input         io_req_bits_uop_is_amo,
                io_req_bits_uop_uses_stq,
  input  [1:0]  io_req_bits_uop_dst_rtype,
  input         io_req_bits_uop_fp_val,
  input  [64:0] io_req_bits_rs1_data,
  input         io_req_bits_kill,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input  [2:0]  io_fcsr_rm,
  output        io_resp_valid,
  output [6:0]  io_resp_bits_uop_uopc,
  output [19:0] io_resp_bits_uop_br_mask,
  output [6:0]  io_resp_bits_uop_rob_idx,
  output [4:0]  io_resp_bits_uop_stq_idx,
  output [6:0]  io_resp_bits_uop_pdst,
  output        io_resp_bits_uop_is_amo,
                io_resp_bits_uop_uses_stq,
  output [1:0]  io_resp_bits_uop_dst_rtype,
  output        io_resp_bits_uop_fp_val,
  output [64:0] io_resp_bits_data,
  output        io_resp_bits_fflags_valid,
  output [6:0]  io_resp_bits_fflags_bits_uop_rob_idx,
  output [4:0]  io_resp_bits_fflags_bits_flags
);

  wire [64:0] _ifpu_io_out_bits_data;
  wire [1:0]  _fp_decoder_io_sigs_typeTagIn;
  wire [1:0]  _fp_decoder_io_sigs_typeTagOut;
  wire        _fp_decoder_io_sigs_fromint;
  wire        _fp_decoder_io_sigs_wflags;
  reg         r_valids_0;
  reg         r_valids_1;
  reg  [6:0]  r_uops_0_uopc;
  reg  [19:0] r_uops_0_br_mask;
  reg  [6:0]  r_uops_0_rob_idx;
  reg  [4:0]  r_uops_0_stq_idx;
  reg  [6:0]  r_uops_0_pdst;
  reg         r_uops_0_is_amo;
  reg         r_uops_0_uses_stq;
  reg  [1:0]  r_uops_0_dst_rtype;
  reg         r_uops_0_fp_val;
  reg  [6:0]  r_uops_1_uopc;
  reg  [19:0] r_uops_1_br_mask;
  reg  [6:0]  r_uops_1_rob_idx;
  reg  [4:0]  r_uops_1_stq_idx;
  reg  [6:0]  r_uops_1_pdst;
  reg         r_uops_1_is_amo;
  reg         r_uops_1_uses_stq;
  reg  [1:0]  r_uops_1_dst_rtype;
  reg         r_uops_1_fp_val;
  reg         out_double_pipe_v;
  reg         out_double_pipe_b;
  reg         out_double_pipe_pipe_b;
  always @(posedge clock) begin
    if (reset) begin
      r_valids_0 <= 1'h0;
      r_valids_1 <= 1'h0;
      out_double_pipe_v <= 1'h0;
    end
    else begin
      r_valids_0 <= io_req_valid & (io_brupdate_b1_mispredict_mask & io_req_bits_uop_br_mask) == 20'h0 & ~io_req_bits_kill;
      r_valids_1 <= r_valids_0 & (io_brupdate_b1_mispredict_mask & r_uops_0_br_mask) == 20'h0 & ~io_req_bits_kill;
      out_double_pipe_v <= io_req_valid;
    end
    r_uops_0_uopc <= io_req_bits_uop_uopc;
    r_uops_0_br_mask <= io_req_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;
    r_uops_0_rob_idx <= io_req_bits_uop_rob_idx;
    r_uops_0_stq_idx <= io_req_bits_uop_stq_idx;
    r_uops_0_pdst <= io_req_bits_uop_pdst;
    r_uops_0_is_amo <= io_req_bits_uop_is_amo;
    r_uops_0_uses_stq <= io_req_bits_uop_uses_stq;
    r_uops_0_dst_rtype <= io_req_bits_uop_dst_rtype;
    r_uops_0_fp_val <= io_req_bits_uop_fp_val;
    r_uops_1_uopc <= r_uops_0_uopc;
    r_uops_1_br_mask <= r_uops_0_br_mask & ~io_brupdate_b1_resolve_mask;
    r_uops_1_rob_idx <= r_uops_0_rob_idx;
    r_uops_1_stq_idx <= r_uops_0_stq_idx;
    r_uops_1_pdst <= r_uops_0_pdst;
    r_uops_1_is_amo <= r_uops_0_is_amo;
    r_uops_1_uses_stq <= r_uops_0_uses_stq;
    r_uops_1_dst_rtype <= r_uops_0_dst_rtype;
    r_uops_1_fp_val <= r_uops_0_fp_val;
    if (io_req_valid)
      out_double_pipe_b <= _fp_decoder_io_sigs_typeTagOut == 2'h1;
    if (out_double_pipe_v)
      out_double_pipe_pipe_b <= out_double_pipe_b;
  end // always @(posedge)
  UOPCodeFPUDecoder fp_decoder (
    .io_uopc            (io_req_bits_uop_uopc),
    .io_sigs_ren2       (/* unused */),
    .io_sigs_ren3       (/* unused */),
    .io_sigs_swap23     (/* unused */),
    .io_sigs_typeTagIn  (_fp_decoder_io_sigs_typeTagIn),
    .io_sigs_typeTagOut (_fp_decoder_io_sigs_typeTagOut),
    .io_sigs_fromint    (_fp_decoder_io_sigs_fromint),
    .io_sigs_toint      (/* unused */),
    .io_sigs_fastpipe   (/* unused */),
    .io_sigs_fma        (/* unused */),
    .io_sigs_wflags     (_fp_decoder_io_sigs_wflags)
  );
  IntToFP ifpu (
    .clock                (clock),
    .reset                (reset),
    .io_in_valid          (io_req_valid),
    .io_in_bits_typeTagIn (_fp_decoder_io_sigs_typeTagIn),
    .io_in_bits_wflags    (_fp_decoder_io_sigs_wflags),
    .io_in_bits_rm        ((&(io_req_bits_uop_imm_packed[2:0])) ? io_fcsr_rm : io_req_bits_uop_imm_packed[2:0]),
    .io_in_bits_typ       (io_req_bits_uop_imm_packed[9:8]),
    .io_in_bits_in1       (io_req_bits_rs1_data[63:0]),
    .io_out_valid         (io_resp_bits_fflags_valid),
    .io_out_bits_data     (_ifpu_io_out_bits_data),
    .io_out_bits_exc      (io_resp_bits_fflags_bits_flags)
  );
  assign io_resp_valid = r_valids_1 & (io_brupdate_b1_mispredict_mask & r_uops_1_br_mask) == 20'h0;
  assign io_resp_bits_uop_uopc = r_uops_1_uopc;
  assign io_resp_bits_uop_br_mask = r_uops_1_br_mask & ~io_brupdate_b1_resolve_mask;
  assign io_resp_bits_uop_rob_idx = r_uops_1_rob_idx;
  assign io_resp_bits_uop_stq_idx = r_uops_1_stq_idx;
  assign io_resp_bits_uop_pdst = r_uops_1_pdst;
  assign io_resp_bits_uop_is_amo = r_uops_1_is_amo;
  assign io_resp_bits_uop_uses_stq = r_uops_1_uses_stq;
  assign io_resp_bits_uop_dst_rtype = r_uops_1_dst_rtype;
  assign io_resp_bits_uop_fp_val = r_uops_1_fp_val;
  assign io_resp_bits_data = out_double_pipe_pipe_b ? _ifpu_io_out_bits_data : {12'hFFF, _ifpu_io_out_bits_data[31], 20'hFFFFF, _ifpu_io_out_bits_data[32], _ifpu_io_out_bits_data[30:0]};
  assign io_resp_bits_fflags_bits_uop_rob_idx = r_uops_1_rob_idx;
endmodule

