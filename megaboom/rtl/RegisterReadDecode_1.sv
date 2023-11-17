// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RegisterReadDecode_1(
  input         io_iss_valid,
  input  [6:0]  io_iss_uop_uopc,
  input  [9:0]  io_iss_uop_fu_code,
  input  [19:0] io_iss_uop_br_mask,
                io_iss_uop_imm_packed,
  input  [6:0]  io_iss_uop_rob_idx,
  input  [4:0]  io_iss_uop_stq_idx,
  input  [6:0]  io_iss_uop_pdst,
  input  [4:0]  io_iss_uop_mem_cmd,
  input         io_iss_uop_is_amo,
                io_iss_uop_uses_ldq,
                io_iss_uop_uses_stq,
  input  [1:0]  io_iss_uop_dst_rtype,
  input         io_iss_uop_fp_val,
  output        io_rrd_valid,
  output [6:0]  io_rrd_uop_uopc,
  output [9:0]  io_rrd_uop_fu_code,
  output [19:0] io_rrd_uop_br_mask,
                io_rrd_uop_imm_packed,
  output [6:0]  io_rrd_uop_rob_idx,
  output [4:0]  io_rrd_uop_stq_idx,
  output [6:0]  io_rrd_uop_pdst,
  output        io_rrd_uop_is_amo,
                io_rrd_uop_uses_ldq,
                io_rrd_uop_uses_stq,
  output [1:0]  io_rrd_uop_dst_rtype,
  output        io_rrd_uop_fp_val
);

  assign io_rrd_valid = io_iss_valid;
  assign io_rrd_uop_uopc = io_iss_uop_uopc;
  assign io_rrd_uop_fu_code = io_iss_uop_fu_code;
  assign io_rrd_uop_br_mask = io_iss_uop_br_mask;
  assign io_rrd_uop_imm_packed = io_iss_uop_uopc == 7'h43 | io_iss_uop_uopc == 7'h1 & io_iss_uop_mem_cmd == 5'h6 ? 20'h0 : io_iss_uop_imm_packed;
  assign io_rrd_uop_rob_idx = io_iss_uop_rob_idx;
  assign io_rrd_uop_stq_idx = io_iss_uop_stq_idx;
  assign io_rrd_uop_pdst = io_iss_uop_pdst;
  assign io_rrd_uop_is_amo = io_iss_uop_is_amo;
  assign io_rrd_uop_uses_ldq = io_iss_uop_uses_ldq;
  assign io_rrd_uop_uses_stq = io_iss_uop_uses_stq;
  assign io_rrd_uop_dst_rtype = io_iss_uop_dst_rtype;
  assign io_rrd_uop_fp_val = io_iss_uop_fp_val;
endmodule

