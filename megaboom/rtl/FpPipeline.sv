// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module FpPipeline(
  input         clock,
                reset,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input         io_flush_pipeline,
  input  [2:0]  io_fcsr_rm,
  input         io_dis_uops_0_valid,
  input  [6:0]  io_dis_uops_0_bits_uopc,
  input  [9:0]  io_dis_uops_0_bits_fu_code,
  input  [19:0] io_dis_uops_0_bits_br_mask,
                io_dis_uops_0_bits_imm_packed,
  input  [6:0]  io_dis_uops_0_bits_rob_idx,
  input  [4:0]  io_dis_uops_0_bits_stq_idx,
  input  [6:0]  io_dis_uops_0_bits_pdst,
                io_dis_uops_0_bits_prs1,
                io_dis_uops_0_bits_prs2,
                io_dis_uops_0_bits_prs3,
  input         io_dis_uops_0_bits_prs1_busy,
                io_dis_uops_0_bits_prs2_busy,
                io_dis_uops_0_bits_prs3_busy,
                io_dis_uops_0_bits_exception,
  input  [4:0]  io_dis_uops_0_bits_mem_cmd,
  input         io_dis_uops_0_bits_is_fence,
                io_dis_uops_0_bits_is_fencei,
                io_dis_uops_0_bits_is_amo,
                io_dis_uops_0_bits_uses_ldq,
                io_dis_uops_0_bits_uses_stq,
  input  [1:0]  io_dis_uops_0_bits_dst_rtype,
  input         io_dis_uops_0_bits_fp_val,
                io_dis_uops_1_valid,
  input  [6:0]  io_dis_uops_1_bits_uopc,
  input  [9:0]  io_dis_uops_1_bits_fu_code,
  input  [19:0] io_dis_uops_1_bits_br_mask,
                io_dis_uops_1_bits_imm_packed,
  input  [6:0]  io_dis_uops_1_bits_rob_idx,
  input  [4:0]  io_dis_uops_1_bits_stq_idx,
  input  [6:0]  io_dis_uops_1_bits_pdst,
                io_dis_uops_1_bits_prs1,
                io_dis_uops_1_bits_prs2,
                io_dis_uops_1_bits_prs3,
  input         io_dis_uops_1_bits_prs1_busy,
                io_dis_uops_1_bits_prs2_busy,
                io_dis_uops_1_bits_prs3_busy,
                io_dis_uops_1_bits_exception,
  input  [4:0]  io_dis_uops_1_bits_mem_cmd,
  input         io_dis_uops_1_bits_is_fence,
                io_dis_uops_1_bits_is_fencei,
                io_dis_uops_1_bits_is_amo,
                io_dis_uops_1_bits_uses_ldq,
                io_dis_uops_1_bits_uses_stq,
  input  [1:0]  io_dis_uops_1_bits_dst_rtype,
  input         io_dis_uops_1_bits_fp_val,
                io_dis_uops_2_valid,
  input  [6:0]  io_dis_uops_2_bits_uopc,
  input  [9:0]  io_dis_uops_2_bits_fu_code,
  input  [19:0] io_dis_uops_2_bits_br_mask,
                io_dis_uops_2_bits_imm_packed,
  input  [6:0]  io_dis_uops_2_bits_rob_idx,
  input  [4:0]  io_dis_uops_2_bits_stq_idx,
  input  [6:0]  io_dis_uops_2_bits_pdst,
                io_dis_uops_2_bits_prs1,
                io_dis_uops_2_bits_prs2,
                io_dis_uops_2_bits_prs3,
  input         io_dis_uops_2_bits_prs1_busy,
                io_dis_uops_2_bits_prs2_busy,
                io_dis_uops_2_bits_prs3_busy,
                io_dis_uops_2_bits_exception,
  input  [4:0]  io_dis_uops_2_bits_mem_cmd,
  input         io_dis_uops_2_bits_is_fence,
                io_dis_uops_2_bits_is_fencei,
                io_dis_uops_2_bits_is_amo,
                io_dis_uops_2_bits_uses_ldq,
                io_dis_uops_2_bits_uses_stq,
  input  [1:0]  io_dis_uops_2_bits_dst_rtype,
  input         io_dis_uops_2_bits_fp_val,
                io_dis_uops_3_valid,
  input  [6:0]  io_dis_uops_3_bits_uopc,
  input  [9:0]  io_dis_uops_3_bits_fu_code,
  input  [19:0] io_dis_uops_3_bits_br_mask,
                io_dis_uops_3_bits_imm_packed,
  input  [6:0]  io_dis_uops_3_bits_rob_idx,
  input  [4:0]  io_dis_uops_3_bits_stq_idx,
  input  [6:0]  io_dis_uops_3_bits_pdst,
                io_dis_uops_3_bits_prs1,
                io_dis_uops_3_bits_prs2,
                io_dis_uops_3_bits_prs3,
  input         io_dis_uops_3_bits_prs1_busy,
                io_dis_uops_3_bits_prs2_busy,
                io_dis_uops_3_bits_prs3_busy,
                io_dis_uops_3_bits_exception,
  input  [4:0]  io_dis_uops_3_bits_mem_cmd,
  input         io_dis_uops_3_bits_is_fence,
                io_dis_uops_3_bits_is_fencei,
                io_dis_uops_3_bits_is_amo,
                io_dis_uops_3_bits_uses_ldq,
                io_dis_uops_3_bits_uses_stq,
  input  [1:0]  io_dis_uops_3_bits_dst_rtype,
  input         io_dis_uops_3_bits_fp_val,
                io_ll_wports_0_valid,
  input  [6:0]  io_ll_wports_0_bits_uop_uopc,
  input  [19:0] io_ll_wports_0_bits_uop_br_mask,
  input  [6:0]  io_ll_wports_0_bits_uop_rob_idx,
  input  [4:0]  io_ll_wports_0_bits_uop_stq_idx,
  input  [6:0]  io_ll_wports_0_bits_uop_pdst,
  input  [1:0]  io_ll_wports_0_bits_uop_mem_size,
  input         io_ll_wports_0_bits_uop_is_amo,
                io_ll_wports_0_bits_uop_uses_stq,
  input  [1:0]  io_ll_wports_0_bits_uop_dst_rtype,
  input         io_ll_wports_0_bits_uop_fp_val,
  input  [64:0] io_ll_wports_0_bits_data,
  input         io_ll_wports_1_valid,
  input  [6:0]  io_ll_wports_1_bits_uop_rob_idx,
                io_ll_wports_1_bits_uop_pdst,
  input  [1:0]  io_ll_wports_1_bits_uop_mem_size,
                io_ll_wports_1_bits_uop_dst_rtype,
  input         io_ll_wports_1_bits_uop_fp_val,
  input  [64:0] io_ll_wports_1_bits_data,
  input         io_from_int_valid,
  input  [6:0]  io_from_int_bits_uop_uopc,
  input  [19:0] io_from_int_bits_uop_br_mask,
  input  [6:0]  io_from_int_bits_uop_rob_idx,
  input  [4:0]  io_from_int_bits_uop_stq_idx,
  input  [6:0]  io_from_int_bits_uop_pdst,
  input         io_from_int_bits_uop_is_amo,
                io_from_int_bits_uop_uses_stq,
  input  [1:0]  io_from_int_bits_uop_dst_rtype,
  input         io_from_int_bits_uop_fp_val,
  input  [64:0] io_from_int_bits_data,
  input         io_from_int_bits_predicated,
                io_from_int_bits_fflags_valid,
  input  [6:0]  io_from_int_bits_fflags_bits_uop_rob_idx,
  input  [4:0]  io_from_int_bits_fflags_bits_flags,
  input         io_to_sdq_ready,
                io_to_int_ready,
  output        io_dis_uops_0_ready,
                io_dis_uops_1_ready,
                io_dis_uops_2_ready,
                io_dis_uops_3_ready,
                io_from_int_ready,
                io_to_sdq_valid,
  output [19:0] io_to_sdq_bits_uop_br_mask,
  output [6:0]  io_to_sdq_bits_uop_rob_idx,
  output [4:0]  io_to_sdq_bits_uop_stq_idx,
  output [63:0] io_to_sdq_bits_data,
  output        io_to_int_valid,
  output [6:0]  io_to_int_bits_uop_rob_idx,
                io_to_int_bits_uop_pdst,
  output        io_to_int_bits_uop_is_amo,
                io_to_int_bits_uop_uses_stq,
  output [1:0]  io_to_int_bits_uop_dst_rtype,
  output [63:0] io_to_int_bits_data,
  output        io_to_int_bits_predicated,
                io_wakeups_0_valid,
  output [6:0]  io_wakeups_0_bits_uop_rob_idx,
                io_wakeups_0_bits_uop_pdst,
  output [1:0]  io_wakeups_0_bits_uop_dst_rtype,
  output        io_wakeups_0_bits_uop_fp_val,
                io_wakeups_0_bits_predicated,
                io_wakeups_0_bits_fflags_valid,
  output [6:0]  io_wakeups_0_bits_fflags_bits_uop_rob_idx,
  output [4:0]  io_wakeups_0_bits_fflags_bits_flags,
  output        io_wakeups_1_valid,
  output [6:0]  io_wakeups_1_bits_uop_rob_idx,
                io_wakeups_1_bits_uop_pdst,
  output [1:0]  io_wakeups_1_bits_uop_dst_rtype,
  output        io_wakeups_1_bits_uop_fp_val,
                io_wakeups_2_valid,
  output [6:0]  io_wakeups_2_bits_uop_rob_idx,
                io_wakeups_2_bits_uop_pdst,
  output [1:0]  io_wakeups_2_bits_uop_dst_rtype,
  output        io_wakeups_2_bits_uop_fp_val,
                io_wakeups_2_bits_fflags_valid,
  output [6:0]  io_wakeups_2_bits_fflags_bits_uop_rob_idx,
  output [4:0]  io_wakeups_2_bits_fflags_bits_flags,
  output        io_wakeups_3_valid,
  output [6:0]  io_wakeups_3_bits_uop_rob_idx,
                io_wakeups_3_bits_uop_pdst,
  output [1:0]  io_wakeups_3_bits_uop_dst_rtype,
  output        io_wakeups_3_bits_uop_fp_val,
                io_wakeups_3_bits_fflags_valid,
  output [6:0]  io_wakeups_3_bits_fflags_bits_uop_rob_idx,
  output [4:0]  io_wakeups_3_bits_fflags_bits_flags
);

  wire         _fpu_exe_unit_io_ll_iresp_ready_T;
  wire         _ll_wbarb_io_in_0_ready;
  wire         _ll_wbarb_io_out_valid;
  wire [6:0]   _ll_wbarb_io_out_bits_uop_pdst;
  wire [1:0]   _ll_wbarb_io_out_bits_uop_dst_rtype;
  wire [64:0]  _ll_wbarb_io_out_bits_data;
  wire [6:0]   _fregister_read_io_rf_read_ports_0_addr;
  wire [6:0]   _fregister_read_io_rf_read_ports_1_addr;
  wire [6:0]   _fregister_read_io_rf_read_ports_2_addr;
  wire [6:0]   _fregister_read_io_rf_read_ports_3_addr;
  wire [6:0]   _fregister_read_io_rf_read_ports_4_addr;
  wire [6:0]   _fregister_read_io_rf_read_ports_5_addr;
  wire         _fregister_read_io_exe_reqs_0_valid;
  wire [6:0]   _fregister_read_io_exe_reqs_0_bits_uop_uopc;
  wire [9:0]   _fregister_read_io_exe_reqs_0_bits_uop_fu_code;
  wire [19:0]  _fregister_read_io_exe_reqs_0_bits_uop_br_mask;
  wire [19:0]  _fregister_read_io_exe_reqs_0_bits_uop_imm_packed;
  wire [6:0]   _fregister_read_io_exe_reqs_0_bits_uop_rob_idx;
  wire [4:0]   _fregister_read_io_exe_reqs_0_bits_uop_stq_idx;
  wire [6:0]   _fregister_read_io_exe_reqs_0_bits_uop_pdst;
  wire         _fregister_read_io_exe_reqs_0_bits_uop_is_amo;
  wire         _fregister_read_io_exe_reqs_0_bits_uop_uses_ldq;
  wire         _fregister_read_io_exe_reqs_0_bits_uop_uses_stq;
  wire [1:0]   _fregister_read_io_exe_reqs_0_bits_uop_dst_rtype;
  wire         _fregister_read_io_exe_reqs_0_bits_uop_fp_val;
  wire [64:0]  _fregister_read_io_exe_reqs_0_bits_rs1_data;
  wire [64:0]  _fregister_read_io_exe_reqs_0_bits_rs2_data;
  wire [64:0]  _fregister_read_io_exe_reqs_0_bits_rs3_data;
  wire         _fregister_read_io_exe_reqs_1_valid;
  wire [6:0]   _fregister_read_io_exe_reqs_1_bits_uop_uopc;
  wire [9:0]   _fregister_read_io_exe_reqs_1_bits_uop_fu_code;
  wire [19:0]  _fregister_read_io_exe_reqs_1_bits_uop_br_mask;
  wire [19:0]  _fregister_read_io_exe_reqs_1_bits_uop_imm_packed;
  wire [6:0]   _fregister_read_io_exe_reqs_1_bits_uop_rob_idx;
  wire [4:0]   _fregister_read_io_exe_reqs_1_bits_uop_stq_idx;
  wire [6:0]   _fregister_read_io_exe_reqs_1_bits_uop_pdst;
  wire         _fregister_read_io_exe_reqs_1_bits_uop_is_amo;
  wire         _fregister_read_io_exe_reqs_1_bits_uop_uses_ldq;
  wire         _fregister_read_io_exe_reqs_1_bits_uop_uses_stq;
  wire [1:0]   _fregister_read_io_exe_reqs_1_bits_uop_dst_rtype;
  wire         _fregister_read_io_exe_reqs_1_bits_uop_fp_val;
  wire [64:0]  _fregister_read_io_exe_reqs_1_bits_rs1_data;
  wire [64:0]  _fregister_read_io_exe_reqs_1_bits_rs2_data;
  wire [64:0]  _fregister_read_io_exe_reqs_1_bits_rs3_data;
  wire [64:0]  _fregfile_io_read_ports_0_data;
  wire [64:0]  _fregfile_io_read_ports_1_data;
  wire [64:0]  _fregfile_io_read_ports_2_data;
  wire [64:0]  _fregfile_io_read_ports_3_data;
  wire [64:0]  _fregfile_io_read_ports_4_data;
  wire [64:0]  _fregfile_io_read_ports_5_data;
  wire         _fp_issue_unit_io_iss_valids_0;
  wire         _fp_issue_unit_io_iss_valids_1;
  wire [6:0]   _fp_issue_unit_io_iss_uops_0_uopc;
  wire [9:0]   _fp_issue_unit_io_iss_uops_0_fu_code;
  wire [19:0]  _fp_issue_unit_io_iss_uops_0_br_mask;
  wire [19:0]  _fp_issue_unit_io_iss_uops_0_imm_packed;
  wire [6:0]   _fp_issue_unit_io_iss_uops_0_rob_idx;
  wire [4:0]   _fp_issue_unit_io_iss_uops_0_stq_idx;
  wire [6:0]   _fp_issue_unit_io_iss_uops_0_pdst;
  wire [6:0]   _fp_issue_unit_io_iss_uops_0_prs1;
  wire [6:0]   _fp_issue_unit_io_iss_uops_0_prs2;
  wire [6:0]   _fp_issue_unit_io_iss_uops_0_prs3;
  wire [4:0]   _fp_issue_unit_io_iss_uops_0_mem_cmd;
  wire         _fp_issue_unit_io_iss_uops_0_is_amo;
  wire         _fp_issue_unit_io_iss_uops_0_uses_ldq;
  wire         _fp_issue_unit_io_iss_uops_0_uses_stq;
  wire [1:0]   _fp_issue_unit_io_iss_uops_0_dst_rtype;
  wire         _fp_issue_unit_io_iss_uops_0_fp_val;
  wire [6:0]   _fp_issue_unit_io_iss_uops_1_uopc;
  wire [9:0]   _fp_issue_unit_io_iss_uops_1_fu_code;
  wire [19:0]  _fp_issue_unit_io_iss_uops_1_br_mask;
  wire [19:0]  _fp_issue_unit_io_iss_uops_1_imm_packed;
  wire [6:0]   _fp_issue_unit_io_iss_uops_1_rob_idx;
  wire [4:0]   _fp_issue_unit_io_iss_uops_1_stq_idx;
  wire [6:0]   _fp_issue_unit_io_iss_uops_1_pdst;
  wire [6:0]   _fp_issue_unit_io_iss_uops_1_prs1;
  wire [6:0]   _fp_issue_unit_io_iss_uops_1_prs2;
  wire [6:0]   _fp_issue_unit_io_iss_uops_1_prs3;
  wire [4:0]   _fp_issue_unit_io_iss_uops_1_mem_cmd;
  wire         _fp_issue_unit_io_iss_uops_1_is_amo;
  wire         _fp_issue_unit_io_iss_uops_1_uses_ldq;
  wire         _fp_issue_unit_io_iss_uops_1_uses_stq;
  wire [1:0]   _fp_issue_unit_io_iss_uops_1_dst_rtype;
  wire         _fp_issue_unit_io_iss_uops_1_fp_val;
  wire         _fpu_exe_unit_1_io_fresp_valid;
  wire [6:0]   _fpu_exe_unit_1_io_fresp_bits_uop_pdst;
  wire         _fpu_exe_unit_1_io_fresp_bits_uop_is_amo;
  wire         _fpu_exe_unit_1_io_fresp_bits_uop_uses_ldq;
  wire         _fpu_exe_unit_1_io_fresp_bits_uop_uses_stq;
  wire [1:0]   _fpu_exe_unit_1_io_fresp_bits_uop_dst_rtype;
  wire [64:0]  _fpu_exe_unit_1_io_fresp_bits_data;
  wire [9:0]   _fpu_exe_unit_io_fu_types;
  wire         _fpu_exe_unit_io_fresp_valid;
  wire [6:0]   _fpu_exe_unit_io_fresp_bits_uop_pdst;
  wire         _fpu_exe_unit_io_fresp_bits_uop_is_amo;
  wire         _fpu_exe_unit_io_fresp_bits_uop_uses_ldq;
  wire         _fpu_exe_unit_io_fresp_bits_uop_uses_stq;
  wire [1:0]   _fpu_exe_unit_io_fresp_bits_uop_dst_rtype;
  wire [64:0]  _fpu_exe_unit_io_fresp_bits_data;
  wire         _fpu_exe_unit_io_ll_iresp_valid;
  wire [6:0]   _fpu_exe_unit_io_ll_iresp_bits_uop_uopc;
  wire [6:0]   _fpu_exe_unit_io_ll_iresp_bits_uop_rob_idx;
  wire [64:0]  _fpu_exe_unit_io_ll_iresp_bits_data;
  reg  [9:0]   REG;
  wire [63:0]  _ll_wbarb_io_in_0_bits_data_T_3 = (io_ll_wports_0_bits_uop_mem_size != 2'h2 ? 64'h0 : 64'hFFFFFFFF00000000) | io_ll_wports_0_bits_data[63:0];
  wire         ll_wbarb_io_in_0_bits_data_rawIn_isZeroExpIn = _ll_wbarb_io_in_0_bits_data_T_3[62:52] == 11'h0;
  wire [5:0]   ll_wbarb_io_in_0_bits_data_rawIn_normDist =
    _ll_wbarb_io_in_0_bits_data_T_3[51]
      ? 6'h0
      : _ll_wbarb_io_in_0_bits_data_T_3[50]
          ? 6'h1
          : _ll_wbarb_io_in_0_bits_data_T_3[49]
              ? 6'h2
              : _ll_wbarb_io_in_0_bits_data_T_3[48]
                  ? 6'h3
                  : _ll_wbarb_io_in_0_bits_data_T_3[47]
                      ? 6'h4
                      : _ll_wbarb_io_in_0_bits_data_T_3[46]
                          ? 6'h5
                          : _ll_wbarb_io_in_0_bits_data_T_3[45]
                              ? 6'h6
                              : _ll_wbarb_io_in_0_bits_data_T_3[44] ? 6'h7 : _ll_wbarb_io_in_0_bits_data_T_3[43] ? 6'h8 : _ll_wbarb_io_in_0_bits_data_T_3[42] ? 6'h9 : _ll_wbarb_io_in_0_bits_data_T_3[41] ? 6'hA : _ll_wbarb_io_in_0_bits_data_T_3[40] ? 6'hB : _ll_wbarb_io_in_0_bits_data_T_3[39] ? 6'hC : _ll_wbarb_io_in_0_bits_data_T_3[38] ? 6'hD : _ll_wbarb_io_in_0_bits_data_T_3[37] ? 6'hE : _ll_wbarb_io_in_0_bits_data_T_3[36] ? 6'hF : _ll_wbarb_io_in_0_bits_data_T_3[35] ? 6'h10 : _ll_wbarb_io_in_0_bits_data_T_3[34] ? 6'h11 : _ll_wbarb_io_in_0_bits_data_T_3[33] ? 6'h12 : _ll_wbarb_io_in_0_bits_data_T_3[32] ? 6'h13 : _ll_wbarb_io_in_0_bits_data_T_3[31] ? 6'h14 : _ll_wbarb_io_in_0_bits_data_T_3[30] ? 6'h15 : _ll_wbarb_io_in_0_bits_data_T_3[29] ? 6'h16 : _ll_wbarb_io_in_0_bits_data_T_3[28] ? 6'h17 : _ll_wbarb_io_in_0_bits_data_T_3[27] ? 6'h18 : _ll_wbarb_io_in_0_bits_data_T_3[26] ? 6'h19 : _ll_wbarb_io_in_0_bits_data_T_3[25] ? 6'h1A : _ll_wbarb_io_in_0_bits_data_T_3[24] ? 6'h1B : _ll_wbarb_io_in_0_bits_data_T_3[23] ? 6'h1C : _ll_wbarb_io_in_0_bits_data_T_3[22] ? 6'h1D : _ll_wbarb_io_in_0_bits_data_T_3[21] ? 6'h1E : _ll_wbarb_io_in_0_bits_data_T_3[20] ? 6'h1F : _ll_wbarb_io_in_0_bits_data_T_3[19] ? 6'h20 : _ll_wbarb_io_in_0_bits_data_T_3[18] ? 6'h21 : _ll_wbarb_io_in_0_bits_data_T_3[17] ? 6'h22 : _ll_wbarb_io_in_0_bits_data_T_3[16] ? 6'h23 : _ll_wbarb_io_in_0_bits_data_T_3[15] ? 6'h24 : _ll_wbarb_io_in_0_bits_data_T_3[14] ? 6'h25 : _ll_wbarb_io_in_0_bits_data_T_3[13] ? 6'h26 : _ll_wbarb_io_in_0_bits_data_T_3[12] ? 6'h27 : _ll_wbarb_io_in_0_bits_data_T_3[11] ? 6'h28 : _ll_wbarb_io_in_0_bits_data_T_3[10] ? 6'h29 : _ll_wbarb_io_in_0_bits_data_T_3[9] ? 6'h2A : _ll_wbarb_io_in_0_bits_data_T_3[8] ? 6'h2B : _ll_wbarb_io_in_0_bits_data_T_3[7] ? 6'h2C : _ll_wbarb_io_in_0_bits_data_T_3[6] ? 6'h2D : _ll_wbarb_io_in_0_bits_data_T_3[5] ? 6'h2E : _ll_wbarb_io_in_0_bits_data_T_3[4] ? 6'h2F : _ll_wbarb_io_in_0_bits_data_T_3[3] ? 6'h30 : _ll_wbarb_io_in_0_bits_data_T_3[2] ? 6'h31 : {5'h19, ~(_ll_wbarb_io_in_0_bits_data_T_3[1])};
  wire [114:0] _ll_wbarb_io_in_0_bits_data_rawIn_subnormFract_T = {63'h0, _ll_wbarb_io_in_0_bits_data_T_3[51:0]} << ll_wbarb_io_in_0_bits_data_rawIn_normDist;
  wire [11:0]  _ll_wbarb_io_in_0_bits_data_rawIn_adjustedExp_T_4 = (ll_wbarb_io_in_0_bits_data_rawIn_isZeroExpIn ? {6'h3F, ~ll_wbarb_io_in_0_bits_data_rawIn_normDist} : {1'h0, _ll_wbarb_io_in_0_bits_data_T_3[62:52]}) + {10'h100, ll_wbarb_io_in_0_bits_data_rawIn_isZeroExpIn ? 2'h2 : 2'h1};
  wire [51:0]  _ll_wbarb_io_in_0_bits_data_rawIn_out_sig_T_2 = ll_wbarb_io_in_0_bits_data_rawIn_isZeroExpIn ? {_ll_wbarb_io_in_0_bits_data_rawIn_subnormFract_T[50:0], 1'h0} : _ll_wbarb_io_in_0_bits_data_T_3[51:0];
  wire [2:0]   _ll_wbarb_io_in_0_bits_data_T_5 = ll_wbarb_io_in_0_bits_data_rawIn_isZeroExpIn & ~(|(_ll_wbarb_io_in_0_bits_data_T_3[51:0])) ? 3'h0 : _ll_wbarb_io_in_0_bits_data_rawIn_adjustedExp_T_4[11:9];
  wire         _GEN = _ll_wbarb_io_in_0_bits_data_T_5[0] | (&(_ll_wbarb_io_in_0_bits_data_rawIn_adjustedExp_T_4[11:10])) & (|(_ll_wbarb_io_in_0_bits_data_T_3[51:0]));
  wire         ll_wbarb_io_in_0_bits_data_rawIn_isZeroExpIn_1 = _ll_wbarb_io_in_0_bits_data_T_3[30:23] == 8'h0;
  wire [4:0]   ll_wbarb_io_in_0_bits_data_rawIn_normDist_1 = _ll_wbarb_io_in_0_bits_data_T_3[22] ? 5'h0 : _ll_wbarb_io_in_0_bits_data_T_3[21] ? 5'h1 : _ll_wbarb_io_in_0_bits_data_T_3[20] ? 5'h2 : _ll_wbarb_io_in_0_bits_data_T_3[19] ? 5'h3 : _ll_wbarb_io_in_0_bits_data_T_3[18] ? 5'h4 : _ll_wbarb_io_in_0_bits_data_T_3[17] ? 5'h5 : _ll_wbarb_io_in_0_bits_data_T_3[16] ? 5'h6 : _ll_wbarb_io_in_0_bits_data_T_3[15] ? 5'h7 : _ll_wbarb_io_in_0_bits_data_T_3[14] ? 5'h8 : _ll_wbarb_io_in_0_bits_data_T_3[13] ? 5'h9 : _ll_wbarb_io_in_0_bits_data_T_3[12] ? 5'hA : _ll_wbarb_io_in_0_bits_data_T_3[11] ? 5'hB : _ll_wbarb_io_in_0_bits_data_T_3[10] ? 5'hC : _ll_wbarb_io_in_0_bits_data_T_3[9] ? 5'hD : _ll_wbarb_io_in_0_bits_data_T_3[8] ? 5'hE : _ll_wbarb_io_in_0_bits_data_T_3[7] ? 5'hF : _ll_wbarb_io_in_0_bits_data_T_3[6] ? 5'h10 : _ll_wbarb_io_in_0_bits_data_T_3[5] ? 5'h11 : _ll_wbarb_io_in_0_bits_data_T_3[4] ? 5'h12 : _ll_wbarb_io_in_0_bits_data_T_3[3] ? 5'h13 : _ll_wbarb_io_in_0_bits_data_T_3[2] ? 5'h14 : _ll_wbarb_io_in_0_bits_data_T_3[1] ? 5'h15 : 5'h16;
  wire [53:0]  _ll_wbarb_io_in_0_bits_data_rawIn_subnormFract_T_2 = {31'h0, _ll_wbarb_io_in_0_bits_data_T_3[22:0]} << ll_wbarb_io_in_0_bits_data_rawIn_normDist_1;
  wire [8:0]   _ll_wbarb_io_in_0_bits_data_rawIn_adjustedExp_T_9 = (ll_wbarb_io_in_0_bits_data_rawIn_isZeroExpIn_1 ? {4'hF, ~ll_wbarb_io_in_0_bits_data_rawIn_normDist_1} : {1'h0, _ll_wbarb_io_in_0_bits_data_T_3[30:23]}) + {7'h20, ll_wbarb_io_in_0_bits_data_rawIn_isZeroExpIn_1 ? 2'h2 : 2'h1};
  wire [2:0]   _ll_wbarb_io_in_0_bits_data_T_14 = ll_wbarb_io_in_0_bits_data_rawIn_isZeroExpIn_1 & ~(|(_ll_wbarb_io_in_0_bits_data_T_3[22:0])) ? 3'h0 : _ll_wbarb_io_in_0_bits_data_rawIn_adjustedExp_T_9[8:6];
  reg          fregfile_io_write_ports_0_REG_valid;
  reg  [6:0]   fregfile_io_write_ports_0_REG_bits_addr;
  reg  [64:0]  fregfile_io_write_ports_0_REG_bits_data;
  reg          fregfile_io_write_ports_1_REG_valid;
  reg  [6:0]   fregfile_io_write_ports_1_REG_bits_addr;
  reg  [64:0]  fregfile_io_write_ports_1_bits_data_REG;
  wire         _fregfile_io_write_ports_2_valid_T = _fpu_exe_unit_io_fresp_bits_uop_dst_rtype != 2'h2;
  wire         _io_wakeups_2_valid_T = _fpu_exe_unit_io_fresp_bits_uop_dst_rtype == 2'h1;
  wire         _fregfile_io_write_ports_3_valid_T = _fpu_exe_unit_1_io_fresp_bits_uop_dst_rtype != 2'h2;
  wire         _io_wakeups_3_valid_T = _fpu_exe_unit_1_io_fresp_bits_uop_dst_rtype == 2'h1;
  wire         fpiu_is_sdq = _fpu_exe_unit_io_ll_iresp_bits_uop_uopc == 7'h2;
  wire         _io_to_sdq_valid_T = _fpu_exe_unit_io_ll_iresp_ready_T & _fpu_exe_unit_io_ll_iresp_valid;
  assign _fpu_exe_unit_io_ll_iresp_ready_T = io_to_sdq_ready & io_to_int_ready;
  wire         _io_wakeups_2_valid_output = _fpu_exe_unit_io_fresp_valid & _io_wakeups_2_valid_T;
  wire         _io_wakeups_3_valid_output = _fpu_exe_unit_1_io_fresp_valid & _io_wakeups_3_valid_T;
  wire [63:0]  _fregfile_io_write_ports_1_bits_data_T_3 = (io_ll_wports_1_bits_uop_mem_size != 2'h2 ? 64'h0 : 64'hFFFFFFFF00000000) | io_ll_wports_1_bits_data[63:0];
  wire         fregfile_io_write_ports_1_bits_data_rawIn_isZeroExpIn = _fregfile_io_write_ports_1_bits_data_T_3[62:52] == 11'h0;
  wire [5:0]   fregfile_io_write_ports_1_bits_data_rawIn_normDist =
    _fregfile_io_write_ports_1_bits_data_T_3[51]
      ? 6'h0
      : _fregfile_io_write_ports_1_bits_data_T_3[50]
          ? 6'h1
          : _fregfile_io_write_ports_1_bits_data_T_3[49]
              ? 6'h2
              : _fregfile_io_write_ports_1_bits_data_T_3[48]
                  ? 6'h3
                  : _fregfile_io_write_ports_1_bits_data_T_3[47]
                      ? 6'h4
                      : _fregfile_io_write_ports_1_bits_data_T_3[46]
                          ? 6'h5
                          : _fregfile_io_write_ports_1_bits_data_T_3[45]
                              ? 6'h6
                              : _fregfile_io_write_ports_1_bits_data_T_3[44]
                                  ? 6'h7
                                  : _fregfile_io_write_ports_1_bits_data_T_3[43]
                                      ? 6'h8
                                      : _fregfile_io_write_ports_1_bits_data_T_3[42]
                                          ? 6'h9
                                          : _fregfile_io_write_ports_1_bits_data_T_3[41]
                                              ? 6'hA
                                              : _fregfile_io_write_ports_1_bits_data_T_3[40]
                                                  ? 6'hB
                                                  : _fregfile_io_write_ports_1_bits_data_T_3[39]
                                                      ? 6'hC
                                                      : _fregfile_io_write_ports_1_bits_data_T_3[38]
                                                          ? 6'hD
                                                          : _fregfile_io_write_ports_1_bits_data_T_3[37]
                                                              ? 6'hE
                                                              : _fregfile_io_write_ports_1_bits_data_T_3[36] ? 6'hF : _fregfile_io_write_ports_1_bits_data_T_3[35] ? 6'h10 : _fregfile_io_write_ports_1_bits_data_T_3[34] ? 6'h11 : _fregfile_io_write_ports_1_bits_data_T_3[33] ? 6'h12 : _fregfile_io_write_ports_1_bits_data_T_3[32] ? 6'h13 : _fregfile_io_write_ports_1_bits_data_T_3[31] ? 6'h14 : _fregfile_io_write_ports_1_bits_data_T_3[30] ? 6'h15 : _fregfile_io_write_ports_1_bits_data_T_3[29] ? 6'h16 : _fregfile_io_write_ports_1_bits_data_T_3[28] ? 6'h17 : _fregfile_io_write_ports_1_bits_data_T_3[27] ? 6'h18 : _fregfile_io_write_ports_1_bits_data_T_3[26] ? 6'h19 : _fregfile_io_write_ports_1_bits_data_T_3[25] ? 6'h1A : _fregfile_io_write_ports_1_bits_data_T_3[24] ? 6'h1B : _fregfile_io_write_ports_1_bits_data_T_3[23] ? 6'h1C : _fregfile_io_write_ports_1_bits_data_T_3[22] ? 6'h1D : _fregfile_io_write_ports_1_bits_data_T_3[21] ? 6'h1E : _fregfile_io_write_ports_1_bits_data_T_3[20] ? 6'h1F : _fregfile_io_write_ports_1_bits_data_T_3[19] ? 6'h20 : _fregfile_io_write_ports_1_bits_data_T_3[18] ? 6'h21 : _fregfile_io_write_ports_1_bits_data_T_3[17] ? 6'h22 : _fregfile_io_write_ports_1_bits_data_T_3[16] ? 6'h23 : _fregfile_io_write_ports_1_bits_data_T_3[15] ? 6'h24 : _fregfile_io_write_ports_1_bits_data_T_3[14] ? 6'h25 : _fregfile_io_write_ports_1_bits_data_T_3[13] ? 6'h26 : _fregfile_io_write_ports_1_bits_data_T_3[12] ? 6'h27 : _fregfile_io_write_ports_1_bits_data_T_3[11] ? 6'h28 : _fregfile_io_write_ports_1_bits_data_T_3[10] ? 6'h29 : _fregfile_io_write_ports_1_bits_data_T_3[9] ? 6'h2A : _fregfile_io_write_ports_1_bits_data_T_3[8] ? 6'h2B : _fregfile_io_write_ports_1_bits_data_T_3[7] ? 6'h2C : _fregfile_io_write_ports_1_bits_data_T_3[6] ? 6'h2D : _fregfile_io_write_ports_1_bits_data_T_3[5] ? 6'h2E : _fregfile_io_write_ports_1_bits_data_T_3[4] ? 6'h2F : _fregfile_io_write_ports_1_bits_data_T_3[3] ? 6'h30 : _fregfile_io_write_ports_1_bits_data_T_3[2] ? 6'h31 : {5'h19, ~(_fregfile_io_write_ports_1_bits_data_T_3[1])};
  wire [11:0]  _fregfile_io_write_ports_1_bits_data_rawIn_adjustedExp_T_4 = (fregfile_io_write_ports_1_bits_data_rawIn_isZeroExpIn ? {6'h3F, ~fregfile_io_write_ports_1_bits_data_rawIn_normDist} : {1'h0, _fregfile_io_write_ports_1_bits_data_T_3[62:52]}) + {10'h100, fregfile_io_write_ports_1_bits_data_rawIn_isZeroExpIn ? 2'h2 : 2'h1};
  wire [114:0] _fregfile_io_write_ports_1_bits_data_rawIn_subnormFract_T = {63'h0, _fregfile_io_write_ports_1_bits_data_T_3[51:0]} << fregfile_io_write_ports_1_bits_data_rawIn_normDist;
  wire [51:0]  _fregfile_io_write_ports_1_bits_data_rawIn_out_sig_T_2 = fregfile_io_write_ports_1_bits_data_rawIn_isZeroExpIn ? {_fregfile_io_write_ports_1_bits_data_rawIn_subnormFract_T[50:0], 1'h0} : _fregfile_io_write_ports_1_bits_data_T_3[51:0];
  wire [2:0]   _fregfile_io_write_ports_1_bits_data_T_5 = fregfile_io_write_ports_1_bits_data_rawIn_isZeroExpIn & ~(|(_fregfile_io_write_ports_1_bits_data_T_3[51:0])) ? 3'h0 : _fregfile_io_write_ports_1_bits_data_rawIn_adjustedExp_T_4[11:9];
  wire         _GEN_0 = _fregfile_io_write_ports_1_bits_data_T_5[0] | (&(_fregfile_io_write_ports_1_bits_data_rawIn_adjustedExp_T_4[11:10])) & (|(_fregfile_io_write_ports_1_bits_data_T_3[51:0]));
  wire         fregfile_io_write_ports_1_bits_data_rawIn_isZeroExpIn_1 = _fregfile_io_write_ports_1_bits_data_T_3[30:23] == 8'h0;
  wire [4:0]   fregfile_io_write_ports_1_bits_data_rawIn_normDist_1 = _fregfile_io_write_ports_1_bits_data_T_3[22] ? 5'h0 : _fregfile_io_write_ports_1_bits_data_T_3[21] ? 5'h1 : _fregfile_io_write_ports_1_bits_data_T_3[20] ? 5'h2 : _fregfile_io_write_ports_1_bits_data_T_3[19] ? 5'h3 : _fregfile_io_write_ports_1_bits_data_T_3[18] ? 5'h4 : _fregfile_io_write_ports_1_bits_data_T_3[17] ? 5'h5 : _fregfile_io_write_ports_1_bits_data_T_3[16] ? 5'h6 : _fregfile_io_write_ports_1_bits_data_T_3[15] ? 5'h7 : _fregfile_io_write_ports_1_bits_data_T_3[14] ? 5'h8 : _fregfile_io_write_ports_1_bits_data_T_3[13] ? 5'h9 : _fregfile_io_write_ports_1_bits_data_T_3[12] ? 5'hA : _fregfile_io_write_ports_1_bits_data_T_3[11] ? 5'hB : _fregfile_io_write_ports_1_bits_data_T_3[10] ? 5'hC : _fregfile_io_write_ports_1_bits_data_T_3[9] ? 5'hD : _fregfile_io_write_ports_1_bits_data_T_3[8] ? 5'hE : _fregfile_io_write_ports_1_bits_data_T_3[7] ? 5'hF : _fregfile_io_write_ports_1_bits_data_T_3[6] ? 5'h10 : _fregfile_io_write_ports_1_bits_data_T_3[5] ? 5'h11 : _fregfile_io_write_ports_1_bits_data_T_3[4] ? 5'h12 : _fregfile_io_write_ports_1_bits_data_T_3[3] ? 5'h13 : _fregfile_io_write_ports_1_bits_data_T_3[2] ? 5'h14 : _fregfile_io_write_ports_1_bits_data_T_3[1] ? 5'h15 : 5'h16;
  wire [8:0]   _fregfile_io_write_ports_1_bits_data_rawIn_adjustedExp_T_9 = (fregfile_io_write_ports_1_bits_data_rawIn_isZeroExpIn_1 ? {4'hF, ~fregfile_io_write_ports_1_bits_data_rawIn_normDist_1} : {1'h0, _fregfile_io_write_ports_1_bits_data_T_3[30:23]}) + {7'h20, fregfile_io_write_ports_1_bits_data_rawIn_isZeroExpIn_1 ? 2'h2 : 2'h1};
  wire [2:0]   _fregfile_io_write_ports_1_bits_data_T_14 = fregfile_io_write_ports_1_bits_data_rawIn_isZeroExpIn_1 & ~(|(_fregfile_io_write_ports_1_bits_data_T_3[22:0])) ? 3'h0 : _fregfile_io_write_ports_1_bits_data_rawIn_adjustedExp_T_9[8:6];
  wire [53:0]  _fregfile_io_write_ports_1_bits_data_rawIn_subnormFract_T_2 = {31'h0, _fregfile_io_write_ports_1_bits_data_T_3[22:0]} << fregfile_io_write_ports_1_bits_data_rawIn_normDist_1;
  always @(posedge clock) begin
    REG <= {2'h3, ~(_fp_issue_unit_io_iss_valids_0 & _fp_issue_unit_io_iss_uops_0_fu_code[7]), 7'h7F};
    fregfile_io_write_ports_0_REG_valid <= _ll_wbarb_io_out_valid & _ll_wbarb_io_out_bits_uop_dst_rtype == 2'h1;
    fregfile_io_write_ports_0_REG_bits_addr <= _ll_wbarb_io_out_bits_uop_pdst;
    fregfile_io_write_ports_0_REG_bits_data <= _ll_wbarb_io_out_bits_data;
    fregfile_io_write_ports_1_REG_valid <= io_ll_wports_1_valid & io_ll_wports_1_bits_uop_dst_rtype == 2'h1;
    fregfile_io_write_ports_1_REG_bits_addr <= io_ll_wports_1_bits_uop_pdst;
    fregfile_io_write_ports_1_bits_data_REG <= {_fregfile_io_write_ports_1_bits_data_T_3[63], _fregfile_io_write_ports_1_bits_data_T_5[2:1], _GEN_0, (&{_fregfile_io_write_ports_1_bits_data_T_5[2:1], _GEN_0}) ? {&(_fregfile_io_write_ports_1_bits_data_rawIn_out_sig_T_2[51:32]), _fregfile_io_write_ports_1_bits_data_rawIn_adjustedExp_T_4[7:1], _fregfile_io_write_ports_1_bits_data_T_14[2], _fregfile_io_write_ports_1_bits_data_rawIn_out_sig_T_2[51:32], _fregfile_io_write_ports_1_bits_data_T_3[31], _fregfile_io_write_ports_1_bits_data_T_14[1], _fregfile_io_write_ports_1_bits_data_T_14[0] | (&(_fregfile_io_write_ports_1_bits_data_rawIn_adjustedExp_T_9[8:7])) & (|(_fregfile_io_write_ports_1_bits_data_T_3[22:0])), _fregfile_io_write_ports_1_bits_data_rawIn_adjustedExp_T_9[5:0], fregfile_io_write_ports_1_bits_data_rawIn_isZeroExpIn_1 ? {_fregfile_io_write_ports_1_bits_data_rawIn_subnormFract_T_2[21:0], 1'h0} : _fregfile_io_write_ports_1_bits_data_T_3[22:0]} : {_fregfile_io_write_ports_1_bits_data_rawIn_adjustedExp_T_4[8:0], _fregfile_io_write_ports_1_bits_data_rawIn_out_sig_T_2}};
  end // always @(posedge)
  FPUExeUnit fpu_exe_unit (
    .clock                                 (clock),
    .reset                                 (reset),
    .io_req_valid                          (_fregister_read_io_exe_reqs_0_valid),
    .io_req_bits_uop_uopc                  (_fregister_read_io_exe_reqs_0_bits_uop_uopc),
    .io_req_bits_uop_fu_code               (_fregister_read_io_exe_reqs_0_bits_uop_fu_code),
    .io_req_bits_uop_br_mask               (_fregister_read_io_exe_reqs_0_bits_uop_br_mask),
    .io_req_bits_uop_imm_packed            (_fregister_read_io_exe_reqs_0_bits_uop_imm_packed),
    .io_req_bits_uop_rob_idx               (_fregister_read_io_exe_reqs_0_bits_uop_rob_idx),
    .io_req_bits_uop_stq_idx               (_fregister_read_io_exe_reqs_0_bits_uop_stq_idx),
    .io_req_bits_uop_pdst                  (_fregister_read_io_exe_reqs_0_bits_uop_pdst),
    .io_req_bits_uop_is_amo                (_fregister_read_io_exe_reqs_0_bits_uop_is_amo),
    .io_req_bits_uop_uses_ldq              (_fregister_read_io_exe_reqs_0_bits_uop_uses_ldq),
    .io_req_bits_uop_uses_stq              (_fregister_read_io_exe_reqs_0_bits_uop_uses_stq),
    .io_req_bits_uop_dst_rtype             (_fregister_read_io_exe_reqs_0_bits_uop_dst_rtype),
    .io_req_bits_uop_fp_val                (_fregister_read_io_exe_reqs_0_bits_uop_fp_val),
    .io_req_bits_rs1_data                  (_fregister_read_io_exe_reqs_0_bits_rs1_data),
    .io_req_bits_rs2_data                  (_fregister_read_io_exe_reqs_0_bits_rs2_data),
    .io_req_bits_rs3_data                  (_fregister_read_io_exe_reqs_0_bits_rs3_data),
    .io_req_bits_kill                      (io_flush_pipeline),
    .io_ll_iresp_ready                     (_fpu_exe_unit_io_ll_iresp_ready_T),
    .io_brupdate_b1_resolve_mask           (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask        (io_brupdate_b1_mispredict_mask),
    .io_fcsr_rm                            (io_fcsr_rm),
    .io_fu_types                           (_fpu_exe_unit_io_fu_types),
    .io_fresp_valid                        (_fpu_exe_unit_io_fresp_valid),
    .io_fresp_bits_uop_rob_idx             (io_wakeups_2_bits_uop_rob_idx),
    .io_fresp_bits_uop_pdst                (_fpu_exe_unit_io_fresp_bits_uop_pdst),
    .io_fresp_bits_uop_is_amo              (_fpu_exe_unit_io_fresp_bits_uop_is_amo),
    .io_fresp_bits_uop_uses_ldq            (_fpu_exe_unit_io_fresp_bits_uop_uses_ldq),
    .io_fresp_bits_uop_uses_stq            (_fpu_exe_unit_io_fresp_bits_uop_uses_stq),
    .io_fresp_bits_uop_dst_rtype           (_fpu_exe_unit_io_fresp_bits_uop_dst_rtype),
    .io_fresp_bits_uop_fp_val              (io_wakeups_2_bits_uop_fp_val),
    .io_fresp_bits_data                    (_fpu_exe_unit_io_fresp_bits_data),
    .io_fresp_bits_fflags_valid            (io_wakeups_2_bits_fflags_valid),
    .io_fresp_bits_fflags_bits_uop_rob_idx (io_wakeups_2_bits_fflags_bits_uop_rob_idx),
    .io_fresp_bits_fflags_bits_flags       (io_wakeups_2_bits_fflags_bits_flags),
    .io_ll_iresp_valid                     (_fpu_exe_unit_io_ll_iresp_valid),
    .io_ll_iresp_bits_uop_uopc             (_fpu_exe_unit_io_ll_iresp_bits_uop_uopc),
    .io_ll_iresp_bits_uop_br_mask          (io_to_sdq_bits_uop_br_mask),
    .io_ll_iresp_bits_uop_rob_idx          (_fpu_exe_unit_io_ll_iresp_bits_uop_rob_idx),
    .io_ll_iresp_bits_uop_stq_idx          (io_to_sdq_bits_uop_stq_idx),
    .io_ll_iresp_bits_uop_pdst             (io_to_int_bits_uop_pdst),
    .io_ll_iresp_bits_uop_is_amo           (io_to_int_bits_uop_is_amo),
    .io_ll_iresp_bits_uop_uses_stq         (io_to_int_bits_uop_uses_stq),
    .io_ll_iresp_bits_uop_dst_rtype        (io_to_int_bits_uop_dst_rtype),
    .io_ll_iresp_bits_data                 (_fpu_exe_unit_io_ll_iresp_bits_data),
    .io_ll_iresp_bits_predicated           (io_to_int_bits_predicated)
  );
  FPUExeUnit_1 fpu_exe_unit_1 (
    .clock                                 (clock),
    .reset                                 (reset),
    .io_req_valid                          (_fregister_read_io_exe_reqs_1_valid),
    .io_req_bits_uop_uopc                  (_fregister_read_io_exe_reqs_1_bits_uop_uopc),
    .io_req_bits_uop_fu_code               (_fregister_read_io_exe_reqs_1_bits_uop_fu_code),
    .io_req_bits_uop_br_mask               (_fregister_read_io_exe_reqs_1_bits_uop_br_mask),
    .io_req_bits_uop_imm_packed            (_fregister_read_io_exe_reqs_1_bits_uop_imm_packed),
    .io_req_bits_uop_rob_idx               (_fregister_read_io_exe_reqs_1_bits_uop_rob_idx),
    .io_req_bits_uop_stq_idx               (_fregister_read_io_exe_reqs_1_bits_uop_stq_idx),
    .io_req_bits_uop_pdst                  (_fregister_read_io_exe_reqs_1_bits_uop_pdst),
    .io_req_bits_uop_is_amo                (_fregister_read_io_exe_reqs_1_bits_uop_is_amo),
    .io_req_bits_uop_uses_ldq              (_fregister_read_io_exe_reqs_1_bits_uop_uses_ldq),
    .io_req_bits_uop_uses_stq              (_fregister_read_io_exe_reqs_1_bits_uop_uses_stq),
    .io_req_bits_uop_dst_rtype             (_fregister_read_io_exe_reqs_1_bits_uop_dst_rtype),
    .io_req_bits_uop_fp_val                (_fregister_read_io_exe_reqs_1_bits_uop_fp_val),
    .io_req_bits_rs1_data                  (_fregister_read_io_exe_reqs_1_bits_rs1_data),
    .io_req_bits_rs2_data                  (_fregister_read_io_exe_reqs_1_bits_rs2_data),
    .io_req_bits_rs3_data                  (_fregister_read_io_exe_reqs_1_bits_rs3_data),
    .io_req_bits_kill                      (io_flush_pipeline),
    .io_brupdate_b1_resolve_mask           (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask        (io_brupdate_b1_mispredict_mask),
    .io_fcsr_rm                            (io_fcsr_rm),
    .io_fresp_valid                        (_fpu_exe_unit_1_io_fresp_valid),
    .io_fresp_bits_uop_rob_idx             (io_wakeups_3_bits_uop_rob_idx),
    .io_fresp_bits_uop_pdst                (_fpu_exe_unit_1_io_fresp_bits_uop_pdst),
    .io_fresp_bits_uop_is_amo              (_fpu_exe_unit_1_io_fresp_bits_uop_is_amo),
    .io_fresp_bits_uop_uses_ldq            (_fpu_exe_unit_1_io_fresp_bits_uop_uses_ldq),
    .io_fresp_bits_uop_uses_stq            (_fpu_exe_unit_1_io_fresp_bits_uop_uses_stq),
    .io_fresp_bits_uop_dst_rtype           (_fpu_exe_unit_1_io_fresp_bits_uop_dst_rtype),
    .io_fresp_bits_uop_fp_val              (io_wakeups_3_bits_uop_fp_val),
    .io_fresp_bits_data                    (_fpu_exe_unit_1_io_fresp_bits_data),
    .io_fresp_bits_fflags_valid            (io_wakeups_3_bits_fflags_valid),
    .io_fresp_bits_fflags_bits_uop_rob_idx (io_wakeups_3_bits_fflags_bits_uop_rob_idx),
    .io_fresp_bits_fflags_bits_flags       (io_wakeups_3_bits_fflags_bits_flags)
  );
  IssueUnitCollapsing fp_issue_unit (
    .clock                          (clock),
    .reset                          (reset),
    .io_dis_uops_0_valid            (io_dis_uops_0_valid),
    .io_dis_uops_0_bits_uopc        (io_dis_uops_0_bits_uopc),
    .io_dis_uops_0_bits_fu_code     (io_dis_uops_0_bits_fu_code),
    .io_dis_uops_0_bits_br_mask     (io_dis_uops_0_bits_br_mask),
    .io_dis_uops_0_bits_imm_packed  (io_dis_uops_0_bits_imm_packed),
    .io_dis_uops_0_bits_rob_idx     (io_dis_uops_0_bits_rob_idx),
    .io_dis_uops_0_bits_stq_idx     (io_dis_uops_0_bits_stq_idx),
    .io_dis_uops_0_bits_pdst        (io_dis_uops_0_bits_pdst),
    .io_dis_uops_0_bits_prs1        (io_dis_uops_0_bits_prs1),
    .io_dis_uops_0_bits_prs2        (io_dis_uops_0_bits_prs2),
    .io_dis_uops_0_bits_prs3        (io_dis_uops_0_bits_prs3),
    .io_dis_uops_0_bits_prs1_busy   (io_dis_uops_0_bits_prs1_busy),
    .io_dis_uops_0_bits_prs2_busy   (io_dis_uops_0_bits_prs2_busy),
    .io_dis_uops_0_bits_prs3_busy   (io_dis_uops_0_bits_prs3_busy),
    .io_dis_uops_0_bits_exception   (io_dis_uops_0_bits_exception),
    .io_dis_uops_0_bits_mem_cmd     (io_dis_uops_0_bits_mem_cmd),
    .io_dis_uops_0_bits_is_fence    (io_dis_uops_0_bits_is_fence),
    .io_dis_uops_0_bits_is_fencei   (io_dis_uops_0_bits_is_fencei),
    .io_dis_uops_0_bits_is_amo      (io_dis_uops_0_bits_is_amo),
    .io_dis_uops_0_bits_uses_ldq    (io_dis_uops_0_bits_uses_ldq),
    .io_dis_uops_0_bits_uses_stq    (io_dis_uops_0_bits_uses_stq),
    .io_dis_uops_0_bits_dst_rtype   (io_dis_uops_0_bits_dst_rtype),
    .io_dis_uops_0_bits_fp_val      (io_dis_uops_0_bits_fp_val),
    .io_dis_uops_1_valid            (io_dis_uops_1_valid),
    .io_dis_uops_1_bits_uopc        (io_dis_uops_1_bits_uopc),
    .io_dis_uops_1_bits_fu_code     (io_dis_uops_1_bits_fu_code),
    .io_dis_uops_1_bits_br_mask     (io_dis_uops_1_bits_br_mask),
    .io_dis_uops_1_bits_imm_packed  (io_dis_uops_1_bits_imm_packed),
    .io_dis_uops_1_bits_rob_idx     (io_dis_uops_1_bits_rob_idx),
    .io_dis_uops_1_bits_stq_idx     (io_dis_uops_1_bits_stq_idx),
    .io_dis_uops_1_bits_pdst        (io_dis_uops_1_bits_pdst),
    .io_dis_uops_1_bits_prs1        (io_dis_uops_1_bits_prs1),
    .io_dis_uops_1_bits_prs2        (io_dis_uops_1_bits_prs2),
    .io_dis_uops_1_bits_prs3        (io_dis_uops_1_bits_prs3),
    .io_dis_uops_1_bits_prs1_busy   (io_dis_uops_1_bits_prs1_busy),
    .io_dis_uops_1_bits_prs2_busy   (io_dis_uops_1_bits_prs2_busy),
    .io_dis_uops_1_bits_prs3_busy   (io_dis_uops_1_bits_prs3_busy),
    .io_dis_uops_1_bits_exception   (io_dis_uops_1_bits_exception),
    .io_dis_uops_1_bits_mem_cmd     (io_dis_uops_1_bits_mem_cmd),
    .io_dis_uops_1_bits_is_fence    (io_dis_uops_1_bits_is_fence),
    .io_dis_uops_1_bits_is_fencei   (io_dis_uops_1_bits_is_fencei),
    .io_dis_uops_1_bits_is_amo      (io_dis_uops_1_bits_is_amo),
    .io_dis_uops_1_bits_uses_ldq    (io_dis_uops_1_bits_uses_ldq),
    .io_dis_uops_1_bits_uses_stq    (io_dis_uops_1_bits_uses_stq),
    .io_dis_uops_1_bits_dst_rtype   (io_dis_uops_1_bits_dst_rtype),
    .io_dis_uops_1_bits_fp_val      (io_dis_uops_1_bits_fp_val),
    .io_dis_uops_2_valid            (io_dis_uops_2_valid),
    .io_dis_uops_2_bits_uopc        (io_dis_uops_2_bits_uopc),
    .io_dis_uops_2_bits_fu_code     (io_dis_uops_2_bits_fu_code),
    .io_dis_uops_2_bits_br_mask     (io_dis_uops_2_bits_br_mask),
    .io_dis_uops_2_bits_imm_packed  (io_dis_uops_2_bits_imm_packed),
    .io_dis_uops_2_bits_rob_idx     (io_dis_uops_2_bits_rob_idx),
    .io_dis_uops_2_bits_stq_idx     (io_dis_uops_2_bits_stq_idx),
    .io_dis_uops_2_bits_pdst        (io_dis_uops_2_bits_pdst),
    .io_dis_uops_2_bits_prs1        (io_dis_uops_2_bits_prs1),
    .io_dis_uops_2_bits_prs2        (io_dis_uops_2_bits_prs2),
    .io_dis_uops_2_bits_prs3        (io_dis_uops_2_bits_prs3),
    .io_dis_uops_2_bits_prs1_busy   (io_dis_uops_2_bits_prs1_busy),
    .io_dis_uops_2_bits_prs2_busy   (io_dis_uops_2_bits_prs2_busy),
    .io_dis_uops_2_bits_prs3_busy   (io_dis_uops_2_bits_prs3_busy),
    .io_dis_uops_2_bits_exception   (io_dis_uops_2_bits_exception),
    .io_dis_uops_2_bits_mem_cmd     (io_dis_uops_2_bits_mem_cmd),
    .io_dis_uops_2_bits_is_fence    (io_dis_uops_2_bits_is_fence),
    .io_dis_uops_2_bits_is_fencei   (io_dis_uops_2_bits_is_fencei),
    .io_dis_uops_2_bits_is_amo      (io_dis_uops_2_bits_is_amo),
    .io_dis_uops_2_bits_uses_ldq    (io_dis_uops_2_bits_uses_ldq),
    .io_dis_uops_2_bits_uses_stq    (io_dis_uops_2_bits_uses_stq),
    .io_dis_uops_2_bits_dst_rtype   (io_dis_uops_2_bits_dst_rtype),
    .io_dis_uops_2_bits_fp_val      (io_dis_uops_2_bits_fp_val),
    .io_dis_uops_3_valid            (io_dis_uops_3_valid),
    .io_dis_uops_3_bits_uopc        (io_dis_uops_3_bits_uopc),
    .io_dis_uops_3_bits_fu_code     (io_dis_uops_3_bits_fu_code),
    .io_dis_uops_3_bits_br_mask     (io_dis_uops_3_bits_br_mask),
    .io_dis_uops_3_bits_imm_packed  (io_dis_uops_3_bits_imm_packed),
    .io_dis_uops_3_bits_rob_idx     (io_dis_uops_3_bits_rob_idx),
    .io_dis_uops_3_bits_stq_idx     (io_dis_uops_3_bits_stq_idx),
    .io_dis_uops_3_bits_pdst        (io_dis_uops_3_bits_pdst),
    .io_dis_uops_3_bits_prs1        (io_dis_uops_3_bits_prs1),
    .io_dis_uops_3_bits_prs2        (io_dis_uops_3_bits_prs2),
    .io_dis_uops_3_bits_prs3        (io_dis_uops_3_bits_prs3),
    .io_dis_uops_3_bits_prs1_busy   (io_dis_uops_3_bits_prs1_busy),
    .io_dis_uops_3_bits_prs2_busy   (io_dis_uops_3_bits_prs2_busy),
    .io_dis_uops_3_bits_prs3_busy   (io_dis_uops_3_bits_prs3_busy),
    .io_dis_uops_3_bits_exception   (io_dis_uops_3_bits_exception),
    .io_dis_uops_3_bits_mem_cmd     (io_dis_uops_3_bits_mem_cmd),
    .io_dis_uops_3_bits_is_fence    (io_dis_uops_3_bits_is_fence),
    .io_dis_uops_3_bits_is_fencei   (io_dis_uops_3_bits_is_fencei),
    .io_dis_uops_3_bits_is_amo      (io_dis_uops_3_bits_is_amo),
    .io_dis_uops_3_bits_uses_ldq    (io_dis_uops_3_bits_uses_ldq),
    .io_dis_uops_3_bits_uses_stq    (io_dis_uops_3_bits_uses_stq),
    .io_dis_uops_3_bits_dst_rtype   (io_dis_uops_3_bits_dst_rtype),
    .io_dis_uops_3_bits_fp_val      (io_dis_uops_3_bits_fp_val),
    .io_wakeup_ports_0_valid        (_ll_wbarb_io_out_valid),
    .io_wakeup_ports_0_bits_pdst    (_ll_wbarb_io_out_bits_uop_pdst),
    .io_wakeup_ports_1_valid        (io_ll_wports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_ll_wports_1_bits_uop_pdst),
    .io_wakeup_ports_2_valid        (_io_wakeups_2_valid_output),
    .io_wakeup_ports_2_bits_pdst    (_fpu_exe_unit_io_fresp_bits_uop_pdst),
    .io_wakeup_ports_3_valid        (_io_wakeups_3_valid_output),
    .io_wakeup_ports_3_bits_pdst    (_fpu_exe_unit_1_io_fresp_bits_uop_pdst),
    .io_fu_types_0                  (_fpu_exe_unit_io_fu_types & REG),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_flush_pipeline              (io_flush_pipeline),
    .io_dis_uops_0_ready            (io_dis_uops_0_ready),
    .io_dis_uops_1_ready            (io_dis_uops_1_ready),
    .io_dis_uops_2_ready            (io_dis_uops_2_ready),
    .io_dis_uops_3_ready            (io_dis_uops_3_ready),
    .io_iss_valids_0                (_fp_issue_unit_io_iss_valids_0),
    .io_iss_valids_1                (_fp_issue_unit_io_iss_valids_1),
    .io_iss_uops_0_uopc             (_fp_issue_unit_io_iss_uops_0_uopc),
    .io_iss_uops_0_fu_code          (_fp_issue_unit_io_iss_uops_0_fu_code),
    .io_iss_uops_0_br_mask          (_fp_issue_unit_io_iss_uops_0_br_mask),
    .io_iss_uops_0_imm_packed       (_fp_issue_unit_io_iss_uops_0_imm_packed),
    .io_iss_uops_0_rob_idx          (_fp_issue_unit_io_iss_uops_0_rob_idx),
    .io_iss_uops_0_stq_idx          (_fp_issue_unit_io_iss_uops_0_stq_idx),
    .io_iss_uops_0_pdst             (_fp_issue_unit_io_iss_uops_0_pdst),
    .io_iss_uops_0_prs1             (_fp_issue_unit_io_iss_uops_0_prs1),
    .io_iss_uops_0_prs2             (_fp_issue_unit_io_iss_uops_0_prs2),
    .io_iss_uops_0_prs3             (_fp_issue_unit_io_iss_uops_0_prs3),
    .io_iss_uops_0_mem_cmd          (_fp_issue_unit_io_iss_uops_0_mem_cmd),
    .io_iss_uops_0_is_amo           (_fp_issue_unit_io_iss_uops_0_is_amo),
    .io_iss_uops_0_uses_ldq         (_fp_issue_unit_io_iss_uops_0_uses_ldq),
    .io_iss_uops_0_uses_stq         (_fp_issue_unit_io_iss_uops_0_uses_stq),
    .io_iss_uops_0_dst_rtype        (_fp_issue_unit_io_iss_uops_0_dst_rtype),
    .io_iss_uops_0_fp_val           (_fp_issue_unit_io_iss_uops_0_fp_val),
    .io_iss_uops_1_uopc             (_fp_issue_unit_io_iss_uops_1_uopc),
    .io_iss_uops_1_fu_code          (_fp_issue_unit_io_iss_uops_1_fu_code),
    .io_iss_uops_1_br_mask          (_fp_issue_unit_io_iss_uops_1_br_mask),
    .io_iss_uops_1_imm_packed       (_fp_issue_unit_io_iss_uops_1_imm_packed),
    .io_iss_uops_1_rob_idx          (_fp_issue_unit_io_iss_uops_1_rob_idx),
    .io_iss_uops_1_stq_idx          (_fp_issue_unit_io_iss_uops_1_stq_idx),
    .io_iss_uops_1_pdst             (_fp_issue_unit_io_iss_uops_1_pdst),
    .io_iss_uops_1_prs1             (_fp_issue_unit_io_iss_uops_1_prs1),
    .io_iss_uops_1_prs2             (_fp_issue_unit_io_iss_uops_1_prs2),
    .io_iss_uops_1_prs3             (_fp_issue_unit_io_iss_uops_1_prs3),
    .io_iss_uops_1_mem_cmd          (_fp_issue_unit_io_iss_uops_1_mem_cmd),
    .io_iss_uops_1_is_amo           (_fp_issue_unit_io_iss_uops_1_is_amo),
    .io_iss_uops_1_uses_ldq         (_fp_issue_unit_io_iss_uops_1_uses_ldq),
    .io_iss_uops_1_uses_stq         (_fp_issue_unit_io_iss_uops_1_uses_stq),
    .io_iss_uops_1_dst_rtype        (_fp_issue_unit_io_iss_uops_1_dst_rtype),
    .io_iss_uops_1_fp_val           (_fp_issue_unit_io_iss_uops_1_fp_val)
  );
  RegisterFileSynthesizable fregfile (
    .clock                      (clock),
    .reset                      (reset),
    .io_read_ports_0_addr       (_fregister_read_io_rf_read_ports_0_addr),
    .io_read_ports_1_addr       (_fregister_read_io_rf_read_ports_1_addr),
    .io_read_ports_2_addr       (_fregister_read_io_rf_read_ports_2_addr),
    .io_read_ports_3_addr       (_fregister_read_io_rf_read_ports_3_addr),
    .io_read_ports_4_addr       (_fregister_read_io_rf_read_ports_4_addr),
    .io_read_ports_5_addr       (_fregister_read_io_rf_read_ports_5_addr),
    .io_write_ports_0_valid     (fregfile_io_write_ports_0_REG_valid),
    .io_write_ports_0_bits_addr (fregfile_io_write_ports_0_REG_bits_addr),
    .io_write_ports_0_bits_data (fregfile_io_write_ports_0_REG_bits_data),
    .io_write_ports_1_valid     (fregfile_io_write_ports_1_REG_valid),
    .io_write_ports_1_bits_addr (fregfile_io_write_ports_1_REG_bits_addr),
    .io_write_ports_1_bits_data (fregfile_io_write_ports_1_bits_data_REG),
    .io_write_ports_2_valid     (_fpu_exe_unit_io_fresp_valid & _fregfile_io_write_ports_2_valid_T),
    .io_write_ports_2_bits_addr (_fpu_exe_unit_io_fresp_bits_uop_pdst),
    .io_write_ports_2_bits_data (_fpu_exe_unit_io_fresp_bits_data),
    .io_write_ports_3_valid     (_fpu_exe_unit_1_io_fresp_valid & _fregfile_io_write_ports_3_valid_T),
    .io_write_ports_3_bits_addr (_fpu_exe_unit_1_io_fresp_bits_uop_pdst),
    .io_write_ports_3_bits_data (_fpu_exe_unit_1_io_fresp_bits_data),
    .io_read_ports_0_data       (_fregfile_io_read_ports_0_data),
    .io_read_ports_1_data       (_fregfile_io_read_ports_1_data),
    .io_read_ports_2_data       (_fregfile_io_read_ports_2_data),
    .io_read_ports_3_data       (_fregfile_io_read_ports_3_data),
    .io_read_ports_4_data       (_fregfile_io_read_ports_4_data),
    .io_read_ports_5_data       (_fregfile_io_read_ports_5_data)
  );
  RegisterRead fregister_read (
    .clock                             (clock),
    .reset                             (reset),
    .io_iss_valids_0                   (_fp_issue_unit_io_iss_valids_0),
    .io_iss_valids_1                   (_fp_issue_unit_io_iss_valids_1),
    .io_iss_uops_0_uopc                (_fp_issue_unit_io_iss_uops_0_uopc),
    .io_iss_uops_0_fu_code             (_fp_issue_unit_io_iss_uops_0_fu_code),
    .io_iss_uops_0_br_mask             (_fp_issue_unit_io_iss_uops_0_br_mask),
    .io_iss_uops_0_imm_packed          (_fp_issue_unit_io_iss_uops_0_imm_packed),
    .io_iss_uops_0_rob_idx             (_fp_issue_unit_io_iss_uops_0_rob_idx),
    .io_iss_uops_0_stq_idx             (_fp_issue_unit_io_iss_uops_0_stq_idx),
    .io_iss_uops_0_pdst                (_fp_issue_unit_io_iss_uops_0_pdst),
    .io_iss_uops_0_prs1                (_fp_issue_unit_io_iss_uops_0_prs1),
    .io_iss_uops_0_prs2                (_fp_issue_unit_io_iss_uops_0_prs2),
    .io_iss_uops_0_prs3                (_fp_issue_unit_io_iss_uops_0_prs3),
    .io_iss_uops_0_mem_cmd             (_fp_issue_unit_io_iss_uops_0_mem_cmd),
    .io_iss_uops_0_is_amo              (_fp_issue_unit_io_iss_uops_0_is_amo),
    .io_iss_uops_0_uses_ldq            (_fp_issue_unit_io_iss_uops_0_uses_ldq),
    .io_iss_uops_0_uses_stq            (_fp_issue_unit_io_iss_uops_0_uses_stq),
    .io_iss_uops_0_dst_rtype           (_fp_issue_unit_io_iss_uops_0_dst_rtype),
    .io_iss_uops_0_fp_val              (_fp_issue_unit_io_iss_uops_0_fp_val),
    .io_iss_uops_1_uopc                (_fp_issue_unit_io_iss_uops_1_uopc),
    .io_iss_uops_1_fu_code             (_fp_issue_unit_io_iss_uops_1_fu_code),
    .io_iss_uops_1_br_mask             (_fp_issue_unit_io_iss_uops_1_br_mask),
    .io_iss_uops_1_imm_packed          (_fp_issue_unit_io_iss_uops_1_imm_packed),
    .io_iss_uops_1_rob_idx             (_fp_issue_unit_io_iss_uops_1_rob_idx),
    .io_iss_uops_1_stq_idx             (_fp_issue_unit_io_iss_uops_1_stq_idx),
    .io_iss_uops_1_pdst                (_fp_issue_unit_io_iss_uops_1_pdst),
    .io_iss_uops_1_prs1                (_fp_issue_unit_io_iss_uops_1_prs1),
    .io_iss_uops_1_prs2                (_fp_issue_unit_io_iss_uops_1_prs2),
    .io_iss_uops_1_prs3                (_fp_issue_unit_io_iss_uops_1_prs3),
    .io_iss_uops_1_mem_cmd             (_fp_issue_unit_io_iss_uops_1_mem_cmd),
    .io_iss_uops_1_is_amo              (_fp_issue_unit_io_iss_uops_1_is_amo),
    .io_iss_uops_1_uses_ldq            (_fp_issue_unit_io_iss_uops_1_uses_ldq),
    .io_iss_uops_1_uses_stq            (_fp_issue_unit_io_iss_uops_1_uses_stq),
    .io_iss_uops_1_dst_rtype           (_fp_issue_unit_io_iss_uops_1_dst_rtype),
    .io_iss_uops_1_fp_val              (_fp_issue_unit_io_iss_uops_1_fp_val),
    .io_rf_read_ports_0_data           (_fregfile_io_read_ports_0_data),
    .io_rf_read_ports_1_data           (_fregfile_io_read_ports_1_data),
    .io_rf_read_ports_2_data           (_fregfile_io_read_ports_2_data),
    .io_rf_read_ports_3_data           (_fregfile_io_read_ports_3_data),
    .io_rf_read_ports_4_data           (_fregfile_io_read_ports_4_data),
    .io_rf_read_ports_5_data           (_fregfile_io_read_ports_5_data),
    .io_kill                           (io_flush_pipeline),
    .io_brupdate_b1_resolve_mask       (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask    (io_brupdate_b1_mispredict_mask),
    .io_rf_read_ports_0_addr           (_fregister_read_io_rf_read_ports_0_addr),
    .io_rf_read_ports_1_addr           (_fregister_read_io_rf_read_ports_1_addr),
    .io_rf_read_ports_2_addr           (_fregister_read_io_rf_read_ports_2_addr),
    .io_rf_read_ports_3_addr           (_fregister_read_io_rf_read_ports_3_addr),
    .io_rf_read_ports_4_addr           (_fregister_read_io_rf_read_ports_4_addr),
    .io_rf_read_ports_5_addr           (_fregister_read_io_rf_read_ports_5_addr),
    .io_exe_reqs_0_valid               (_fregister_read_io_exe_reqs_0_valid),
    .io_exe_reqs_0_bits_uop_uopc       (_fregister_read_io_exe_reqs_0_bits_uop_uopc),
    .io_exe_reqs_0_bits_uop_fu_code    (_fregister_read_io_exe_reqs_0_bits_uop_fu_code),
    .io_exe_reqs_0_bits_uop_br_mask    (_fregister_read_io_exe_reqs_0_bits_uop_br_mask),
    .io_exe_reqs_0_bits_uop_imm_packed (_fregister_read_io_exe_reqs_0_bits_uop_imm_packed),
    .io_exe_reqs_0_bits_uop_rob_idx    (_fregister_read_io_exe_reqs_0_bits_uop_rob_idx),
    .io_exe_reqs_0_bits_uop_stq_idx    (_fregister_read_io_exe_reqs_0_bits_uop_stq_idx),
    .io_exe_reqs_0_bits_uop_pdst       (_fregister_read_io_exe_reqs_0_bits_uop_pdst),
    .io_exe_reqs_0_bits_uop_is_amo     (_fregister_read_io_exe_reqs_0_bits_uop_is_amo),
    .io_exe_reqs_0_bits_uop_uses_ldq   (_fregister_read_io_exe_reqs_0_bits_uop_uses_ldq),
    .io_exe_reqs_0_bits_uop_uses_stq   (_fregister_read_io_exe_reqs_0_bits_uop_uses_stq),
    .io_exe_reqs_0_bits_uop_dst_rtype  (_fregister_read_io_exe_reqs_0_bits_uop_dst_rtype),
    .io_exe_reqs_0_bits_uop_fp_val     (_fregister_read_io_exe_reqs_0_bits_uop_fp_val),
    .io_exe_reqs_0_bits_rs1_data       (_fregister_read_io_exe_reqs_0_bits_rs1_data),
    .io_exe_reqs_0_bits_rs2_data       (_fregister_read_io_exe_reqs_0_bits_rs2_data),
    .io_exe_reqs_0_bits_rs3_data       (_fregister_read_io_exe_reqs_0_bits_rs3_data),
    .io_exe_reqs_1_valid               (_fregister_read_io_exe_reqs_1_valid),
    .io_exe_reqs_1_bits_uop_uopc       (_fregister_read_io_exe_reqs_1_bits_uop_uopc),
    .io_exe_reqs_1_bits_uop_fu_code    (_fregister_read_io_exe_reqs_1_bits_uop_fu_code),
    .io_exe_reqs_1_bits_uop_br_mask    (_fregister_read_io_exe_reqs_1_bits_uop_br_mask),
    .io_exe_reqs_1_bits_uop_imm_packed (_fregister_read_io_exe_reqs_1_bits_uop_imm_packed),
    .io_exe_reqs_1_bits_uop_rob_idx    (_fregister_read_io_exe_reqs_1_bits_uop_rob_idx),
    .io_exe_reqs_1_bits_uop_stq_idx    (_fregister_read_io_exe_reqs_1_bits_uop_stq_idx),
    .io_exe_reqs_1_bits_uop_pdst       (_fregister_read_io_exe_reqs_1_bits_uop_pdst),
    .io_exe_reqs_1_bits_uop_is_amo     (_fregister_read_io_exe_reqs_1_bits_uop_is_amo),
    .io_exe_reqs_1_bits_uop_uses_ldq   (_fregister_read_io_exe_reqs_1_bits_uop_uses_ldq),
    .io_exe_reqs_1_bits_uop_uses_stq   (_fregister_read_io_exe_reqs_1_bits_uop_uses_stq),
    .io_exe_reqs_1_bits_uop_dst_rtype  (_fregister_read_io_exe_reqs_1_bits_uop_dst_rtype),
    .io_exe_reqs_1_bits_uop_fp_val     (_fregister_read_io_exe_reqs_1_bits_uop_fp_val),
    .io_exe_reqs_1_bits_rs1_data       (_fregister_read_io_exe_reqs_1_bits_rs1_data),
    .io_exe_reqs_1_bits_rs2_data       (_fregister_read_io_exe_reqs_1_bits_rs2_data),
    .io_exe_reqs_1_bits_rs3_data       (_fregister_read_io_exe_reqs_1_bits_rs3_data)
  );
  Arbiter_16 ll_wbarb (
    .io_in_0_valid                        (io_ll_wports_0_valid),
    .io_in_0_bits_uop_uopc                (io_ll_wports_0_bits_uop_uopc),
    .io_in_0_bits_uop_br_mask             (io_ll_wports_0_bits_uop_br_mask),
    .io_in_0_bits_uop_rob_idx             (io_ll_wports_0_bits_uop_rob_idx),
    .io_in_0_bits_uop_stq_idx             (io_ll_wports_0_bits_uop_stq_idx),
    .io_in_0_bits_uop_pdst                (io_ll_wports_0_bits_uop_pdst),
    .io_in_0_bits_uop_is_amo              (io_ll_wports_0_bits_uop_is_amo),
    .io_in_0_bits_uop_uses_stq            (io_ll_wports_0_bits_uop_uses_stq),
    .io_in_0_bits_uop_dst_rtype           (io_ll_wports_0_bits_uop_dst_rtype),
    .io_in_0_bits_uop_fp_val              (io_ll_wports_0_bits_uop_fp_val),
    .io_in_0_bits_data                    ({_ll_wbarb_io_in_0_bits_data_T_3[63], _ll_wbarb_io_in_0_bits_data_T_5[2:1], _GEN, (&{_ll_wbarb_io_in_0_bits_data_T_5[2:1], _GEN}) ? {&(_ll_wbarb_io_in_0_bits_data_rawIn_out_sig_T_2[51:32]), _ll_wbarb_io_in_0_bits_data_rawIn_adjustedExp_T_4[7:1], _ll_wbarb_io_in_0_bits_data_T_14[2], _ll_wbarb_io_in_0_bits_data_rawIn_out_sig_T_2[51:32], _ll_wbarb_io_in_0_bits_data_T_3[31], _ll_wbarb_io_in_0_bits_data_T_14[1], _ll_wbarb_io_in_0_bits_data_T_14[0] | (&(_ll_wbarb_io_in_0_bits_data_rawIn_adjustedExp_T_9[8:7])) & (|(_ll_wbarb_io_in_0_bits_data_T_3[22:0])), _ll_wbarb_io_in_0_bits_data_rawIn_adjustedExp_T_9[5:0], ll_wbarb_io_in_0_bits_data_rawIn_isZeroExpIn_1 ? {_ll_wbarb_io_in_0_bits_data_rawIn_subnormFract_T_2[21:0], 1'h0} : _ll_wbarb_io_in_0_bits_data_T_3[22:0]} : {_ll_wbarb_io_in_0_bits_data_rawIn_adjustedExp_T_4[8:0], _ll_wbarb_io_in_0_bits_data_rawIn_out_sig_T_2}}),
    .io_in_0_bits_predicated              (1'h0),
    .io_in_0_bits_fflags_valid            (1'h0),
    .io_in_0_bits_fflags_bits_uop_rob_idx (7'h0),
    .io_in_0_bits_fflags_bits_flags       (5'h0),
    .io_in_1_valid                        (io_from_int_valid),
    .io_in_1_bits_uop_uopc                (io_from_int_bits_uop_uopc),
    .io_in_1_bits_uop_br_mask             (io_from_int_bits_uop_br_mask),
    .io_in_1_bits_uop_rob_idx             (io_from_int_bits_uop_rob_idx),
    .io_in_1_bits_uop_stq_idx             (io_from_int_bits_uop_stq_idx),
    .io_in_1_bits_uop_pdst                (io_from_int_bits_uop_pdst),
    .io_in_1_bits_uop_is_amo              (io_from_int_bits_uop_is_amo),
    .io_in_1_bits_uop_uses_stq            (io_from_int_bits_uop_uses_stq),
    .io_in_1_bits_uop_dst_rtype           (io_from_int_bits_uop_dst_rtype),
    .io_in_1_bits_uop_fp_val              (io_from_int_bits_uop_fp_val),
    .io_in_1_bits_data                    (io_from_int_bits_data),
    .io_in_1_bits_predicated              (io_from_int_bits_predicated),
    .io_in_1_bits_fflags_valid            (io_from_int_bits_fflags_valid),
    .io_in_1_bits_fflags_bits_uop_rob_idx (io_from_int_bits_fflags_bits_uop_rob_idx),
    .io_in_1_bits_fflags_bits_flags       (io_from_int_bits_fflags_bits_flags),
    .io_out_ready                         (1'h1),
    .io_in_0_ready                        (_ll_wbarb_io_in_0_ready),
    .io_in_1_ready                        (io_from_int_ready),
    .io_out_valid                         (_ll_wbarb_io_out_valid),
    .io_out_bits_uop_uopc                 (/* unused */),
    .io_out_bits_uop_br_mask              (/* unused */),
    .io_out_bits_uop_rob_idx              (io_wakeups_0_bits_uop_rob_idx),
    .io_out_bits_uop_stq_idx              (/* unused */),
    .io_out_bits_uop_pdst                 (_ll_wbarb_io_out_bits_uop_pdst),
    .io_out_bits_uop_is_amo               (/* unused */),
    .io_out_bits_uop_uses_stq             (/* unused */),
    .io_out_bits_uop_dst_rtype            (_ll_wbarb_io_out_bits_uop_dst_rtype),
    .io_out_bits_uop_fp_val               (io_wakeups_0_bits_uop_fp_val),
    .io_out_bits_data                     (_ll_wbarb_io_out_bits_data),
    .io_out_bits_predicated               (io_wakeups_0_bits_predicated),
    .io_out_bits_fflags_valid             (io_wakeups_0_bits_fflags_valid),
    .io_out_bits_fflags_bits_uop_rob_idx  (io_wakeups_0_bits_fflags_bits_uop_rob_idx),
    .io_out_bits_fflags_bits_flags        (io_wakeups_0_bits_fflags_bits_flags)
  );
  assign io_to_sdq_valid = _io_to_sdq_valid_T & fpiu_is_sdq;
  assign io_to_sdq_bits_uop_rob_idx = _fpu_exe_unit_io_ll_iresp_bits_uop_rob_idx;
  assign io_to_sdq_bits_data = _fpu_exe_unit_io_ll_iresp_bits_data[63:0];
  assign io_to_int_valid = _io_to_sdq_valid_T & ~fpiu_is_sdq;
  assign io_to_int_bits_uop_rob_idx = _fpu_exe_unit_io_ll_iresp_bits_uop_rob_idx;
  assign io_to_int_bits_data = _fpu_exe_unit_io_ll_iresp_bits_data[63:0];
  assign io_wakeups_0_valid = _ll_wbarb_io_out_valid;
  assign io_wakeups_0_bits_uop_pdst = _ll_wbarb_io_out_bits_uop_pdst;
  assign io_wakeups_0_bits_uop_dst_rtype = _ll_wbarb_io_out_bits_uop_dst_rtype;
  assign io_wakeups_1_valid = io_ll_wports_1_valid;
  assign io_wakeups_1_bits_uop_rob_idx = io_ll_wports_1_bits_uop_rob_idx;
  assign io_wakeups_1_bits_uop_pdst = io_ll_wports_1_bits_uop_pdst;
  assign io_wakeups_1_bits_uop_dst_rtype = io_ll_wports_1_bits_uop_dst_rtype;
  assign io_wakeups_1_bits_uop_fp_val = io_ll_wports_1_bits_uop_fp_val;
  assign io_wakeups_2_valid = _io_wakeups_2_valid_output;
  assign io_wakeups_2_bits_uop_pdst = _fpu_exe_unit_io_fresp_bits_uop_pdst;
  assign io_wakeups_2_bits_uop_dst_rtype = _fpu_exe_unit_io_fresp_bits_uop_dst_rtype;
  assign io_wakeups_3_valid = _io_wakeups_3_valid_output;
  assign io_wakeups_3_bits_uop_pdst = _fpu_exe_unit_1_io_fresp_bits_uop_pdst;
  assign io_wakeups_3_bits_uop_dst_rtype = _fpu_exe_unit_1_io_fresp_bits_uop_dst_rtype;
endmodule

