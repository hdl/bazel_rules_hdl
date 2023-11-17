// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RegisterReadDecode_6(
  input         io_iss_valid,
  input  [6:0]  io_iss_uop_uopc,
  input         io_iss_uop_is_rvc,
  input  [9:0]  io_iss_uop_fu_code,
  input         io_iss_uop_is_br,
                io_iss_uop_is_jalr,
                io_iss_uop_is_jal,
                io_iss_uop_is_sfb,
  input  [19:0] io_iss_uop_br_mask,
  input  [4:0]  io_iss_uop_br_tag,
  input  [5:0]  io_iss_uop_ftq_idx,
  input         io_iss_uop_edge_inst,
  input  [5:0]  io_iss_uop_pc_lob,
  input         io_iss_uop_taken,
  input  [19:0] io_iss_uop_imm_packed,
  input  [6:0]  io_iss_uop_rob_idx,
  input  [4:0]  io_iss_uop_ldq_idx,
                io_iss_uop_stq_idx,
  input  [6:0]  io_iss_uop_pdst,
                io_iss_uop_prs1,
                io_iss_uop_prs2,
  input         io_iss_uop_bypassable,
  input  [4:0]  io_iss_uop_mem_cmd,
  input         io_iss_uop_is_amo,
                io_iss_uop_uses_stq,
  input  [1:0]  io_iss_uop_dst_rtype,
                io_iss_uop_lrs1_rtype,
                io_iss_uop_lrs2_rtype,
  output        io_rrd_valid,
  output [6:0]  io_rrd_uop_uopc,
  output        io_rrd_uop_is_rvc,
  output [9:0]  io_rrd_uop_fu_code,
  output [3:0]  io_rrd_uop_ctrl_br_type,
  output [1:0]  io_rrd_uop_ctrl_op1_sel,
  output [2:0]  io_rrd_uop_ctrl_op2_sel,
                io_rrd_uop_ctrl_imm_sel,
  output [3:0]  io_rrd_uop_ctrl_op_fcn,
  output        io_rrd_uop_ctrl_fcn_dw,
  output [2:0]  io_rrd_uop_ctrl_csr_cmd,
  output        io_rrd_uop_is_br,
                io_rrd_uop_is_jalr,
                io_rrd_uop_is_jal,
                io_rrd_uop_is_sfb,
  output [19:0] io_rrd_uop_br_mask,
  output [4:0]  io_rrd_uop_br_tag,
  output [5:0]  io_rrd_uop_ftq_idx,
  output        io_rrd_uop_edge_inst,
  output [5:0]  io_rrd_uop_pc_lob,
  output        io_rrd_uop_taken,
  output [19:0] io_rrd_uop_imm_packed,
  output [6:0]  io_rrd_uop_rob_idx,
  output [4:0]  io_rrd_uop_ldq_idx,
                io_rrd_uop_stq_idx,
  output [6:0]  io_rrd_uop_pdst,
                io_rrd_uop_prs1,
                io_rrd_uop_prs2,
  output        io_rrd_uop_bypassable,
                io_rrd_uop_is_amo,
                io_rrd_uop_uses_stq,
  output [1:0]  io_rrd_uop_dst_rtype,
                io_rrd_uop_lrs1_rtype,
                io_rrd_uop_lrs2_rtype
);

  wire [6:0] rrd_cs_decoder_decoded_invInputs = ~io_iss_uop_uopc;
  wire [6:0] _rrd_cs_decoder_decoded_T_6 = {rrd_cs_decoder_decoded_invInputs[0], rrd_cs_decoder_decoded_invInputs[1], io_iss_uop_uopc[2], rrd_cs_decoder_decoded_invInputs[3], rrd_cs_decoder_decoded_invInputs[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]};
  wire [5:0] _rrd_cs_decoder_decoded_T_12 = {io_iss_uop_uopc[1], io_iss_uop_uopc[2], rrd_cs_decoder_decoded_invInputs[3], rrd_cs_decoder_decoded_invInputs[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]};
  wire [6:0] _rrd_cs_decoder_decoded_T_90 = {io_iss_uop_uopc[0], rrd_cs_decoder_decoded_invInputs[1], io_iss_uop_uopc[2], io_iss_uop_uopc[3], rrd_cs_decoder_decoded_invInputs[4], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]};
  wire [4:0] _rrd_cs_decoder_decoded_T_102 = {rrd_cs_decoder_decoded_invInputs[2], rrd_cs_decoder_decoded_invInputs[3], io_iss_uop_uopc[4], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]};
  wire [6:0] _rrd_cs_decoder_decoded_T_128 = {rrd_cs_decoder_decoded_invInputs[0], rrd_cs_decoder_decoded_invInputs[1], rrd_cs_decoder_decoded_invInputs[2], rrd_cs_decoder_decoded_invInputs[3], rrd_cs_decoder_decoded_invInputs[4], rrd_cs_decoder_decoded_invInputs[5], io_iss_uop_uopc[6]};
  assign io_rrd_valid = io_iss_valid;
  assign io_rrd_uop_uopc = io_iss_uop_uopc;
  assign io_rrd_uop_is_rvc = io_iss_uop_is_rvc;
  assign io_rrd_uop_fu_code = io_iss_uop_fu_code;
  assign io_rrd_uop_ctrl_br_type = {1'h0, |{&{io_iss_uop_uopc[0], io_iss_uop_uopc[1], rrd_cs_decoder_decoded_invInputs[2], io_iss_uop_uopc[3], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[1], io_iss_uop_uopc[2], io_iss_uop_uopc[3], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}}, |{&{rrd_cs_decoder_decoded_invInputs[0], rrd_cs_decoder_decoded_invInputs[2], io_iss_uop_uopc[3], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{io_iss_uop_uopc[0], rrd_cs_decoder_decoded_invInputs[1], io_iss_uop_uopc[2], io_iss_uop_uopc[3], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}}, |{&{io_iss_uop_uopc[0], rrd_cs_decoder_decoded_invInputs[1], rrd_cs_decoder_decoded_invInputs[2], io_iss_uop_uopc[3], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[0], io_iss_uop_uopc[1], rrd_cs_decoder_decoded_invInputs[2], io_iss_uop_uopc[3], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[0], rrd_cs_decoder_decoded_invInputs[1], io_iss_uop_uopc[2], io_iss_uop_uopc[3], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}}};
  assign io_rrd_uop_ctrl_op1_sel = {1'h0, &_rrd_cs_decoder_decoded_T_6};
  assign io_rrd_uop_ctrl_op2_sel = {2'h0, |{&{rrd_cs_decoder_decoded_invInputs[1], rrd_cs_decoder_decoded_invInputs[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[3], rrd_cs_decoder_decoded_invInputs[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[2], io_iss_uop_uopc[3], rrd_cs_decoder_decoded_invInputs[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{io_iss_uop_uopc[0], rrd_cs_decoder_decoded_invInputs[2], io_iss_uop_uopc[3], rrd_cs_decoder_decoded_invInputs[4], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[0], io_iss_uop_uopc[1], io_iss_uop_uopc[2], io_iss_uop_uopc[3], rrd_cs_decoder_decoded_invInputs[4], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[0], rrd_cs_decoder_decoded_invInputs[2], rrd_cs_decoder_decoded_invInputs[3], io_iss_uop_uopc[4], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]}}};
  assign io_rrd_uop_ctrl_imm_sel = {1'h0, |{&_rrd_cs_decoder_decoded_T_6, &{io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}}, &_rrd_cs_decoder_decoded_T_6};
  assign io_rrd_uop_ctrl_op_fcn =
    {|{&{io_iss_uop_uopc[0], rrd_cs_decoder_decoded_invInputs[1], rrd_cs_decoder_decoded_invInputs[2], io_iss_uop_uopc[3], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[0], io_iss_uop_uopc[1], rrd_cs_decoder_decoded_invInputs[2], io_iss_uop_uopc[3], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[0], rrd_cs_decoder_decoded_invInputs[1], io_iss_uop_uopc[2], io_iss_uop_uopc[3], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[1], rrd_cs_decoder_decoded_invInputs[2], rrd_cs_decoder_decoded_invInputs[3], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[0], io_iss_uop_uopc[1], rrd_cs_decoder_decoded_invInputs[3], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[1], io_iss_uop_uopc[3], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[2], io_iss_uop_uopc[3], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &_rrd_cs_decoder_decoded_T_90},
     |{&_rrd_cs_decoder_decoded_T_12, &{rrd_cs_decoder_decoded_invInputs[0], rrd_cs_decoder_decoded_invInputs[2], io_iss_uop_uopc[3], rrd_cs_decoder_decoded_invInputs[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{io_iss_uop_uopc[0], rrd_cs_decoder_decoded_invInputs[1], io_iss_uop_uopc[3], rrd_cs_decoder_decoded_invInputs[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{io_iss_uop_uopc[0], rrd_cs_decoder_decoded_invInputs[3], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{io_iss_uop_uopc[1], rrd_cs_decoder_decoded_invInputs[2], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[1], io_iss_uop_uopc[2], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{io_iss_uop_uopc[0], io_iss_uop_uopc[3], io_iss_uop_uopc[4], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]}, &{io_iss_uop_uopc[2], io_iss_uop_uopc[3], io_iss_uop_uopc[4], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]}, &_rrd_cs_decoder_decoded_T_128},
     |{&_rrd_cs_decoder_decoded_T_12, &{rrd_cs_decoder_decoded_invInputs[0], io_iss_uop_uopc[1], rrd_cs_decoder_decoded_invInputs[2], io_iss_uop_uopc[3], rrd_cs_decoder_decoded_invInputs[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[0], rrd_cs_decoder_decoded_invInputs[1], io_iss_uop_uopc[2], io_iss_uop_uopc[3], rrd_cs_decoder_decoded_invInputs[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[0], rrd_cs_decoder_decoded_invInputs[1], rrd_cs_decoder_decoded_invInputs[2], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[0], rrd_cs_decoder_decoded_invInputs[3], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{io_iss_uop_uopc[0], io_iss_uop_uopc[1], rrd_cs_decoder_decoded_invInputs[2], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{io_iss_uop_uopc[0], rrd_cs_decoder_decoded_invInputs[1], io_iss_uop_uopc[3], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &_rrd_cs_decoder_decoded_T_90, &{rrd_cs_decoder_decoded_invInputs[1], rrd_cs_decoder_decoded_invInputs[2], rrd_cs_decoder_decoded_invInputs[3], io_iss_uop_uopc[4], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]}, &{io_iss_uop_uopc[1], io_iss_uop_uopc[2], rrd_cs_decoder_decoded_invInputs[3], io_iss_uop_uopc[4], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]}, &{io_iss_uop_uopc[0], io_iss_uop_uopc[1], io_iss_uop_uopc[3], io_iss_uop_uopc[4], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[0], rrd_cs_decoder_decoded_invInputs[1], io_iss_uop_uopc[2], io_iss_uop_uopc[3], io_iss_uop_uopc[4], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]}, &_rrd_cs_decoder_decoded_T_128},
     |{&{rrd_cs_decoder_decoded_invInputs[0], io_iss_uop_uopc[1], io_iss_uop_uopc[2], rrd_cs_decoder_decoded_invInputs[3], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[0], io_iss_uop_uopc[1], io_iss_uop_uopc[2], rrd_cs_decoder_decoded_invInputs[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{io_iss_uop_uopc[0], io_iss_uop_uopc[1], rrd_cs_decoder_decoded_invInputs[2], io_iss_uop_uopc[3], rrd_cs_decoder_decoded_invInputs[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[1], io_iss_uop_uopc[2], io_iss_uop_uopc[3], rrd_cs_decoder_decoded_invInputs[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{io_iss_uop_uopc[0], io_iss_uop_uopc[1], rrd_cs_decoder_decoded_invInputs[3], io_iss_uop_uopc[4], rrd_cs_decoder_decoded_invInputs[5], rrd_cs_decoder_decoded_invInputs[6]}, &{io_iss_uop_uopc[1], io_iss_uop_uopc[2], io_iss_uop_uopc[3], rrd_cs_decoder_decoded_invInputs[4], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]}, &_rrd_cs_decoder_decoded_T_102, &{io_iss_uop_uopc[0], rrd_cs_decoder_decoded_invInputs[1], rrd_cs_decoder_decoded_invInputs[3], io_iss_uop_uopc[4], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[0], io_iss_uop_uopc[1], io_iss_uop_uopc[4], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[0], io_iss_uop_uopc[2], io_iss_uop_uopc[3], io_iss_uop_uopc[4], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]}, &_rrd_cs_decoder_decoded_T_128}};
  assign io_rrd_uop_ctrl_fcn_dw = {&{io_iss_uop_uopc[0], io_iss_uop_uopc[1], io_iss_uop_uopc[3], rrd_cs_decoder_decoded_invInputs[4], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]}, &{io_iss_uop_uopc[2], io_iss_uop_uopc[3], rrd_cs_decoder_decoded_invInputs[4], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]}, &{io_iss_uop_uopc[0], io_iss_uop_uopc[2], io_iss_uop_uopc[3], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]}, &{io_iss_uop_uopc[1], io_iss_uop_uopc[2], io_iss_uop_uopc[3], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]}, &{rrd_cs_decoder_decoded_invInputs[0], rrd_cs_decoder_decoded_invInputs[1], rrd_cs_decoder_decoded_invInputs[2], io_iss_uop_uopc[4], io_iss_uop_uopc[5], rrd_cs_decoder_decoded_invInputs[6]}, &_rrd_cs_decoder_decoded_T_102, &_rrd_cs_decoder_decoded_T_128} == 7'h0;
  assign io_rrd_uop_ctrl_csr_cmd = 3'h0;
  assign io_rrd_uop_is_br = io_iss_uop_is_br;
  assign io_rrd_uop_is_jalr = io_iss_uop_is_jalr;
  assign io_rrd_uop_is_jal = io_iss_uop_is_jal;
  assign io_rrd_uop_is_sfb = io_iss_uop_is_sfb;
  assign io_rrd_uop_br_mask = io_iss_uop_br_mask;
  assign io_rrd_uop_br_tag = io_iss_uop_br_tag;
  assign io_rrd_uop_ftq_idx = io_iss_uop_ftq_idx;
  assign io_rrd_uop_edge_inst = io_iss_uop_edge_inst;
  assign io_rrd_uop_pc_lob = io_iss_uop_pc_lob;
  assign io_rrd_uop_taken = io_iss_uop_taken;
  assign io_rrd_uop_imm_packed = io_iss_uop_uopc == 7'h43 | io_iss_uop_uopc == 7'h1 & io_iss_uop_mem_cmd == 5'h6 ? 20'h0 : io_iss_uop_imm_packed;
  assign io_rrd_uop_rob_idx = io_iss_uop_rob_idx;
  assign io_rrd_uop_ldq_idx = io_iss_uop_ldq_idx;
  assign io_rrd_uop_stq_idx = io_iss_uop_stq_idx;
  assign io_rrd_uop_pdst = io_iss_uop_pdst;
  assign io_rrd_uop_prs1 = io_iss_uop_prs1;
  assign io_rrd_uop_prs2 = io_iss_uop_prs2;
  assign io_rrd_uop_bypassable = io_iss_uop_bypassable;
  assign io_rrd_uop_is_amo = io_iss_uop_is_amo;
  assign io_rrd_uop_uses_stq = io_iss_uop_uses_stq;
  assign io_rrd_uop_dst_rtype = io_iss_uop_dst_rtype;
  assign io_rrd_uop_lrs1_rtype = io_iss_uop_lrs1_rtype;
  assign io_rrd_uop_lrs2_rtype = io_iss_uop_lrs2_rtype;
endmodule

