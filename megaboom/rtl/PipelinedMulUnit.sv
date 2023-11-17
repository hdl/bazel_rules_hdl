// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module PipelinedMulUnit(
  input         clock,
                reset,
                io_req_valid,
  input  [3:0]  io_req_bits_uop_ctrl_op_fcn,
  input         io_req_bits_uop_ctrl_fcn_dw,
  input  [19:0] io_req_bits_uop_br_mask,
  input  [6:0]  io_req_bits_uop_rob_idx,
                io_req_bits_uop_pdst,
  input         io_req_bits_uop_bypassable,
                io_req_bits_uop_is_amo,
                io_req_bits_uop_uses_stq,
  input  [1:0]  io_req_bits_uop_dst_rtype,
  input  [63:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
  input         io_req_bits_kill,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  output        io_resp_valid,
  output [6:0]  io_resp_bits_uop_rob_idx,
                io_resp_bits_uop_pdst,
  output        io_resp_bits_uop_bypassable,
                io_resp_bits_uop_is_amo,
                io_resp_bits_uop_uses_stq,
  output [1:0]  io_resp_bits_uop_dst_rtype,
  output [63:0] io_resp_bits_data
);

  reg        r_valids_0;
  reg        r_valids_1;
  reg        r_valids_2;
  reg [19:0] r_uops_0_br_mask;
  reg [6:0]  r_uops_0_rob_idx;
  reg [6:0]  r_uops_0_pdst;
  reg        r_uops_0_bypassable;
  reg        r_uops_0_is_amo;
  reg        r_uops_0_uses_stq;
  reg [1:0]  r_uops_0_dst_rtype;
  reg [19:0] r_uops_1_br_mask;
  reg [6:0]  r_uops_1_rob_idx;
  reg [6:0]  r_uops_1_pdst;
  reg        r_uops_1_bypassable;
  reg        r_uops_1_is_amo;
  reg        r_uops_1_uses_stq;
  reg [1:0]  r_uops_1_dst_rtype;
  reg [19:0] r_uops_2_br_mask;
  reg [6:0]  r_uops_2_rob_idx;
  reg [6:0]  r_uops_2_pdst;
  reg        r_uops_2_bypassable;
  reg        r_uops_2_is_amo;
  reg        r_uops_2_uses_stq;
  reg [1:0]  r_uops_2_dst_rtype;
  always @(posedge clock) begin
    if (reset) begin
      r_valids_0 <= 1'h0;
      r_valids_1 <= 1'h0;
      r_valids_2 <= 1'h0;
    end
    else begin
      r_valids_0 <= io_req_valid & (io_brupdate_b1_mispredict_mask & io_req_bits_uop_br_mask) == 20'h0 & ~io_req_bits_kill;
      r_valids_1 <= r_valids_0 & (io_brupdate_b1_mispredict_mask & r_uops_0_br_mask) == 20'h0 & ~io_req_bits_kill;
      r_valids_2 <= r_valids_1 & (io_brupdate_b1_mispredict_mask & r_uops_1_br_mask) == 20'h0 & ~io_req_bits_kill;
    end
    r_uops_0_br_mask <= io_req_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;
    r_uops_0_rob_idx <= io_req_bits_uop_rob_idx;
    r_uops_0_pdst <= io_req_bits_uop_pdst;
    r_uops_0_bypassable <= io_req_bits_uop_bypassable;
    r_uops_0_is_amo <= io_req_bits_uop_is_amo;
    r_uops_0_uses_stq <= io_req_bits_uop_uses_stq;
    r_uops_0_dst_rtype <= io_req_bits_uop_dst_rtype;
    r_uops_1_br_mask <= r_uops_0_br_mask & ~io_brupdate_b1_resolve_mask;
    r_uops_1_rob_idx <= r_uops_0_rob_idx;
    r_uops_1_pdst <= r_uops_0_pdst;
    r_uops_1_bypassable <= r_uops_0_bypassable;
    r_uops_1_is_amo <= r_uops_0_is_amo;
    r_uops_1_uses_stq <= r_uops_0_uses_stq;
    r_uops_1_dst_rtype <= r_uops_0_dst_rtype;
    r_uops_2_br_mask <= r_uops_1_br_mask & ~io_brupdate_b1_resolve_mask;
    r_uops_2_rob_idx <= r_uops_1_rob_idx;
    r_uops_2_pdst <= r_uops_1_pdst;
    r_uops_2_bypassable <= r_uops_1_bypassable;
    r_uops_2_is_amo <= r_uops_1_is_amo;
    r_uops_2_uses_stq <= r_uops_1_uses_stq;
    r_uops_2_dst_rtype <= r_uops_1_dst_rtype;
  end // always @(posedge)
  PipelinedMultiplier imul (
    .clock             (clock),
    .reset             (reset),
    .io_req_valid      (io_req_valid),
    .io_req_bits_fn    (io_req_bits_uop_ctrl_op_fcn),
    .io_req_bits_dw    (io_req_bits_uop_ctrl_fcn_dw),
    .io_req_bits_in1   (io_req_bits_rs1_data),
    .io_req_bits_in2   (io_req_bits_rs2_data),
    .io_resp_bits_data (io_resp_bits_data)
  );
  assign io_resp_valid = r_valids_2 & (io_brupdate_b1_mispredict_mask & r_uops_2_br_mask) == 20'h0;
  assign io_resp_bits_uop_rob_idx = r_uops_2_rob_idx;
  assign io_resp_bits_uop_pdst = r_uops_2_pdst;
  assign io_resp_bits_uop_bypassable = r_uops_2_bypassable;
  assign io_resp_bits_uop_is_amo = r_uops_2_is_amo;
  assign io_resp_bits_uop_uses_stq = r_uops_2_uses_stq;
  assign io_resp_bits_uop_dst_rtype = r_uops_2_dst_rtype;
endmodule

