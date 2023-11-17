// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module DivUnit(
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
                io_resp_ready,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  output        io_req_ready,
                io_resp_valid,
  output [6:0]  io_resp_bits_uop_rob_idx,
                io_resp_bits_uop_pdst,
  output        io_resp_bits_uop_bypassable,
                io_resp_bits_uop_is_amo,
                io_resp_bits_uop_uses_stq,
  output [1:0]  io_resp_bits_uop_dst_rtype,
  output [63:0] io_resp_bits_data
);

  wire        _div_io_req_ready;
  wire        _div_io_resp_valid;
  reg  [19:0] r_uop_br_mask;
  reg  [6:0]  r_uop_rob_idx;
  reg  [6:0]  r_uop_pdst;
  reg         r_uop_bypassable;
  reg         r_uop_is_amo;
  reg         r_uop_uses_stq;
  reg  [1:0]  r_uop_dst_rtype;
  wire        _GEN = _div_io_req_ready & io_req_valid;
  wire        do_kill = _GEN ? (|(io_brupdate_b1_mispredict_mask & io_req_bits_uop_br_mask)) | io_req_bits_kill : (|(io_brupdate_b1_mispredict_mask & r_uop_br_mask)) | io_req_bits_kill;
  always @(posedge clock) begin
    if (_GEN) begin
      r_uop_br_mask <= io_req_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;
      r_uop_rob_idx <= io_req_bits_uop_rob_idx;
      r_uop_pdst <= io_req_bits_uop_pdst;
      r_uop_bypassable <= io_req_bits_uop_bypassable;
      r_uop_is_amo <= io_req_bits_uop_is_amo;
      r_uop_uses_stq <= io_req_bits_uop_uses_stq;
      r_uop_dst_rtype <= io_req_bits_uop_dst_rtype;
    end
    else
      r_uop_br_mask <= r_uop_br_mask & ~io_brupdate_b1_resolve_mask;
  end // always @(posedge)
  MulDiv div (
    .clock             (clock),
    .reset             (reset),
    .io_req_valid      (io_req_valid & ~do_kill),
    .io_req_bits_fn    (io_req_bits_uop_ctrl_op_fcn),
    .io_req_bits_dw    (io_req_bits_uop_ctrl_fcn_dw),
    .io_req_bits_in1   (io_req_bits_rs1_data),
    .io_req_bits_in2   (io_req_bits_rs2_data),
    .io_kill           (do_kill),
    .io_resp_ready     (io_resp_ready),
    .io_req_ready      (_div_io_req_ready),
    .io_resp_valid     (_div_io_resp_valid),
    .io_resp_bits_data (io_resp_bits_data)
  );
  assign io_req_ready = _div_io_req_ready;
  assign io_resp_valid = _div_io_resp_valid & ~do_kill;
  assign io_resp_bits_uop_rob_idx = r_uop_rob_idx;
  assign io_resp_bits_uop_pdst = r_uop_pdst;
  assign io_resp_bits_uop_bypassable = r_uop_bypassable;
  assign io_resp_bits_uop_is_amo = r_uop_is_amo;
  assign io_resp_bits_uop_uses_stq = r_uop_uses_stq;
  assign io_resp_bits_uop_dst_rtype = r_uop_dst_rtype;
endmodule

