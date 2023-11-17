// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module FPUUnit(
  input         clock,
                reset,
                io_req_valid,
  input  [6:0]  io_req_bits_uop_uopc,
  input  [9:0]  io_req_bits_uop_fu_code,
  input  [19:0] io_req_bits_uop_br_mask,
                io_req_bits_uop_imm_packed,
  input  [6:0]  io_req_bits_uop_rob_idx,
  input  [4:0]  io_req_bits_uop_stq_idx,
  input  [6:0]  io_req_bits_uop_pdst,
  input         io_req_bits_uop_is_amo,
                io_req_bits_uop_uses_ldq,
                io_req_bits_uop_uses_stq,
  input  [1:0]  io_req_bits_uop_dst_rtype,
  input         io_req_bits_uop_fp_val,
  input  [64:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
                io_req_bits_rs3_data,
  input         io_req_bits_kill,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input  [2:0]  io_fcsr_rm,
  output        io_resp_valid,
  output [6:0]  io_resp_bits_uop_uopc,
  output [9:0]  io_resp_bits_uop_fu_code,
  output [19:0] io_resp_bits_uop_br_mask,
  output [6:0]  io_resp_bits_uop_rob_idx,
  output [4:0]  io_resp_bits_uop_stq_idx,
  output [6:0]  io_resp_bits_uop_pdst,
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

  reg        r_valids_0;
  reg        r_valids_1;
  reg        r_valids_2;
  reg        r_valids_3;
  reg [6:0]  r_uops_0_uopc;
  reg [9:0]  r_uops_0_fu_code;
  reg [19:0] r_uops_0_br_mask;
  reg [6:0]  r_uops_0_rob_idx;
  reg [4:0]  r_uops_0_stq_idx;
  reg [6:0]  r_uops_0_pdst;
  reg        r_uops_0_is_amo;
  reg        r_uops_0_uses_ldq;
  reg        r_uops_0_uses_stq;
  reg [1:0]  r_uops_0_dst_rtype;
  reg        r_uops_0_fp_val;
  reg [6:0]  r_uops_1_uopc;
  reg [9:0]  r_uops_1_fu_code;
  reg [19:0] r_uops_1_br_mask;
  reg [6:0]  r_uops_1_rob_idx;
  reg [4:0]  r_uops_1_stq_idx;
  reg [6:0]  r_uops_1_pdst;
  reg        r_uops_1_is_amo;
  reg        r_uops_1_uses_ldq;
  reg        r_uops_1_uses_stq;
  reg [1:0]  r_uops_1_dst_rtype;
  reg        r_uops_1_fp_val;
  reg [6:0]  r_uops_2_uopc;
  reg [9:0]  r_uops_2_fu_code;
  reg [19:0] r_uops_2_br_mask;
  reg [6:0]  r_uops_2_rob_idx;
  reg [4:0]  r_uops_2_stq_idx;
  reg [6:0]  r_uops_2_pdst;
  reg        r_uops_2_is_amo;
  reg        r_uops_2_uses_ldq;
  reg        r_uops_2_uses_stq;
  reg [1:0]  r_uops_2_dst_rtype;
  reg        r_uops_2_fp_val;
  reg [6:0]  r_uops_3_uopc;
  reg [9:0]  r_uops_3_fu_code;
  reg [19:0] r_uops_3_br_mask;
  reg [6:0]  r_uops_3_rob_idx;
  reg [4:0]  r_uops_3_stq_idx;
  reg [6:0]  r_uops_3_pdst;
  reg        r_uops_3_is_amo;
  reg        r_uops_3_uses_ldq;
  reg        r_uops_3_uses_stq;
  reg [1:0]  r_uops_3_dst_rtype;
  reg        r_uops_3_fp_val;
  always @(posedge clock) begin
    if (reset) begin
      r_valids_0 <= 1'h0;
      r_valids_1 <= 1'h0;
      r_valids_2 <= 1'h0;
      r_valids_3 <= 1'h0;
    end
    else begin
      r_valids_0 <= io_req_valid & (io_brupdate_b1_mispredict_mask & io_req_bits_uop_br_mask) == 20'h0 & ~io_req_bits_kill;
      r_valids_1 <= r_valids_0 & (io_brupdate_b1_mispredict_mask & r_uops_0_br_mask) == 20'h0 & ~io_req_bits_kill;
      r_valids_2 <= r_valids_1 & (io_brupdate_b1_mispredict_mask & r_uops_1_br_mask) == 20'h0 & ~io_req_bits_kill;
      r_valids_3 <= r_valids_2 & (io_brupdate_b1_mispredict_mask & r_uops_2_br_mask) == 20'h0 & ~io_req_bits_kill;
    end
    r_uops_0_uopc <= io_req_bits_uop_uopc;
    r_uops_0_fu_code <= io_req_bits_uop_fu_code;
    r_uops_0_br_mask <= io_req_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;
    r_uops_0_rob_idx <= io_req_bits_uop_rob_idx;
    r_uops_0_stq_idx <= io_req_bits_uop_stq_idx;
    r_uops_0_pdst <= io_req_bits_uop_pdst;
    r_uops_0_is_amo <= io_req_bits_uop_is_amo;
    r_uops_0_uses_ldq <= io_req_bits_uop_uses_ldq;
    r_uops_0_uses_stq <= io_req_bits_uop_uses_stq;
    r_uops_0_dst_rtype <= io_req_bits_uop_dst_rtype;
    r_uops_0_fp_val <= io_req_bits_uop_fp_val;
    r_uops_1_uopc <= r_uops_0_uopc;
    r_uops_1_fu_code <= r_uops_0_fu_code;
    r_uops_1_br_mask <= r_uops_0_br_mask & ~io_brupdate_b1_resolve_mask;
    r_uops_1_rob_idx <= r_uops_0_rob_idx;
    r_uops_1_stq_idx <= r_uops_0_stq_idx;
    r_uops_1_pdst <= r_uops_0_pdst;
    r_uops_1_is_amo <= r_uops_0_is_amo;
    r_uops_1_uses_ldq <= r_uops_0_uses_ldq;
    r_uops_1_uses_stq <= r_uops_0_uses_stq;
    r_uops_1_dst_rtype <= r_uops_0_dst_rtype;
    r_uops_1_fp_val <= r_uops_0_fp_val;
    r_uops_2_uopc <= r_uops_1_uopc;
    r_uops_2_fu_code <= r_uops_1_fu_code;
    r_uops_2_br_mask <= r_uops_1_br_mask & ~io_brupdate_b1_resolve_mask;
    r_uops_2_rob_idx <= r_uops_1_rob_idx;
    r_uops_2_stq_idx <= r_uops_1_stq_idx;
    r_uops_2_pdst <= r_uops_1_pdst;
    r_uops_2_is_amo <= r_uops_1_is_amo;
    r_uops_2_uses_ldq <= r_uops_1_uses_ldq;
    r_uops_2_uses_stq <= r_uops_1_uses_stq;
    r_uops_2_dst_rtype <= r_uops_1_dst_rtype;
    r_uops_2_fp_val <= r_uops_1_fp_val;
    r_uops_3_uopc <= r_uops_2_uopc;
    r_uops_3_fu_code <= r_uops_2_fu_code;
    r_uops_3_br_mask <= r_uops_2_br_mask & ~io_brupdate_b1_resolve_mask;
    r_uops_3_rob_idx <= r_uops_2_rob_idx;
    r_uops_3_stq_idx <= r_uops_2_stq_idx;
    r_uops_3_pdst <= r_uops_2_pdst;
    r_uops_3_is_amo <= r_uops_2_is_amo;
    r_uops_3_uses_ldq <= r_uops_2_uses_ldq;
    r_uops_3_uses_stq <= r_uops_2_uses_stq;
    r_uops_3_dst_rtype <= r_uops_2_dst_rtype;
    r_uops_3_fp_val <= r_uops_2_fp_val;
  end // always @(posedge)
  FPU fpu (
    .clock                          (clock),
    .reset                          (reset),
    .io_req_valid                   (io_req_valid),
    .io_req_bits_uop_uopc           (io_req_bits_uop_uopc),
    .io_req_bits_uop_imm_packed     (io_req_bits_uop_imm_packed),
    .io_req_bits_rs1_data           (io_req_bits_rs1_data),
    .io_req_bits_rs2_data           (io_req_bits_rs2_data),
    .io_req_bits_rs3_data           (io_req_bits_rs3_data),
    .io_req_bits_fcsr_rm            (io_fcsr_rm),
    .io_resp_bits_data              (io_resp_bits_data),
    .io_resp_bits_fflags_valid      (io_resp_bits_fflags_valid),
    .io_resp_bits_fflags_bits_flags (io_resp_bits_fflags_bits_flags)
  );
  assign io_resp_valid = r_valids_3 & (io_brupdate_b1_mispredict_mask & r_uops_3_br_mask) == 20'h0;
  assign io_resp_bits_uop_uopc = r_uops_3_uopc;
  assign io_resp_bits_uop_fu_code = r_uops_3_fu_code;
  assign io_resp_bits_uop_br_mask = r_uops_3_br_mask & ~io_brupdate_b1_resolve_mask;
  assign io_resp_bits_uop_rob_idx = r_uops_3_rob_idx;
  assign io_resp_bits_uop_stq_idx = r_uops_3_stq_idx;
  assign io_resp_bits_uop_pdst = r_uops_3_pdst;
  assign io_resp_bits_uop_is_amo = r_uops_3_is_amo;
  assign io_resp_bits_uop_uses_ldq = r_uops_3_uses_ldq;
  assign io_resp_bits_uop_uses_stq = r_uops_3_uses_stq;
  assign io_resp_bits_uop_dst_rtype = r_uops_3_dst_rtype;
  assign io_resp_bits_uop_fp_val = r_uops_3_fp_val;
  assign io_resp_bits_fflags_bits_uop_rob_idx = r_uops_3_rob_idx;
endmodule

