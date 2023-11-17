// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BoomTile(
  input          clock,
                 reset,
                 auto_buffer_out_a_ready,
                 auto_buffer_out_b_valid,
  input  [2:0]   auto_buffer_out_b_bits_opcode,
  input  [1:0]   auto_buffer_out_b_bits_param,
  input  [3:0]   auto_buffer_out_b_bits_size,
  input  [4:0]   auto_buffer_out_b_bits_source,
  input  [31:0]  auto_buffer_out_b_bits_address,
  input  [15:0]  auto_buffer_out_b_bits_mask,
  input          auto_buffer_out_b_bits_corrupt,
                 auto_buffer_out_c_ready,
                 auto_buffer_out_d_valid,
  input  [2:0]   auto_buffer_out_d_bits_opcode,
  input  [1:0]   auto_buffer_out_d_bits_param,
  input  [3:0]   auto_buffer_out_d_bits_size,
  input  [4:0]   auto_buffer_out_d_bits_source,
  input  [3:0]   auto_buffer_out_d_bits_sink,
  input          auto_buffer_out_d_bits_denied,
  input  [127:0] auto_buffer_out_d_bits_data,
  input          auto_buffer_out_d_bits_corrupt,
                 auto_buffer_out_e_ready,
                 auto_int_local_in_3_0,
                 auto_int_local_in_2_0,
                 auto_int_local_in_1_0,
                 auto_int_local_in_1_1,
                 auto_int_local_in_0_0,
  output         auto_buffer_out_a_valid,
  output [2:0]   auto_buffer_out_a_bits_opcode,
                 auto_buffer_out_a_bits_param,
  output [3:0]   auto_buffer_out_a_bits_size,
  output [4:0]   auto_buffer_out_a_bits_source,
  output [31:0]  auto_buffer_out_a_bits_address,
  output [15:0]  auto_buffer_out_a_bits_mask,
  output [127:0] auto_buffer_out_a_bits_data,
  output         auto_buffer_out_b_ready,
                 auto_buffer_out_c_valid,
  output [2:0]   auto_buffer_out_c_bits_opcode,
                 auto_buffer_out_c_bits_param,
  output [3:0]   auto_buffer_out_c_bits_size,
  output [4:0]   auto_buffer_out_c_bits_source,
  output [31:0]  auto_buffer_out_c_bits_address,
  output [127:0] auto_buffer_out_c_bits_data,
  output         auto_buffer_out_d_ready,
                 auto_buffer_out_e_valid,
  output [3:0]   auto_buffer_out_e_bits_sink
);

  wire         _hellaCacheArb_io_requestor_0_req_ready;
  wire         _hellaCacheArb_io_requestor_0_s2_nack;
  wire         _hellaCacheArb_io_requestor_0_resp_valid;
  wire [63:0]  _hellaCacheArb_io_requestor_0_resp_bits_data;
  wire         _hellaCacheArb_io_requestor_0_s2_xcpt_ae_ld;
  wire         _hellaCacheArb_io_mem_req_valid;
  wire [39:0]  _hellaCacheArb_io_mem_req_bits_addr;
  wire         _hellaCacheArb_io_mem_s1_kill;
  wire         _ptw_io_requestor_0_req_ready;
  wire         _ptw_io_requestor_0_resp_valid;
  wire         _ptw_io_requestor_0_resp_bits_ae_final;
  wire [43:0]  _ptw_io_requestor_0_resp_bits_pte_ppn;
  wire         _ptw_io_requestor_0_resp_bits_pte_d;
  wire         _ptw_io_requestor_0_resp_bits_pte_a;
  wire         _ptw_io_requestor_0_resp_bits_pte_g;
  wire         _ptw_io_requestor_0_resp_bits_pte_u;
  wire         _ptw_io_requestor_0_resp_bits_pte_x;
  wire         _ptw_io_requestor_0_resp_bits_pte_w;
  wire         _ptw_io_requestor_0_resp_bits_pte_r;
  wire         _ptw_io_requestor_0_resp_bits_pte_v;
  wire [1:0]   _ptw_io_requestor_0_resp_bits_level;
  wire         _ptw_io_requestor_0_resp_bits_homogeneous;
  wire [3:0]   _ptw_io_requestor_0_ptbr_mode;
  wire [1:0]   _ptw_io_requestor_0_status_dprv;
  wire         _ptw_io_requestor_0_status_mxr;
  wire         _ptw_io_requestor_0_status_sum;
  wire         _ptw_io_requestor_0_pmp_0_cfg_l;
  wire [1:0]   _ptw_io_requestor_0_pmp_0_cfg_a;
  wire         _ptw_io_requestor_0_pmp_0_cfg_x;
  wire         _ptw_io_requestor_0_pmp_0_cfg_w;
  wire         _ptw_io_requestor_0_pmp_0_cfg_r;
  wire [29:0]  _ptw_io_requestor_0_pmp_0_addr;
  wire [31:0]  _ptw_io_requestor_0_pmp_0_mask;
  wire         _ptw_io_requestor_0_pmp_1_cfg_l;
  wire [1:0]   _ptw_io_requestor_0_pmp_1_cfg_a;
  wire         _ptw_io_requestor_0_pmp_1_cfg_x;
  wire         _ptw_io_requestor_0_pmp_1_cfg_w;
  wire         _ptw_io_requestor_0_pmp_1_cfg_r;
  wire [29:0]  _ptw_io_requestor_0_pmp_1_addr;
  wire [31:0]  _ptw_io_requestor_0_pmp_1_mask;
  wire         _ptw_io_requestor_0_pmp_2_cfg_l;
  wire [1:0]   _ptw_io_requestor_0_pmp_2_cfg_a;
  wire         _ptw_io_requestor_0_pmp_2_cfg_x;
  wire         _ptw_io_requestor_0_pmp_2_cfg_w;
  wire         _ptw_io_requestor_0_pmp_2_cfg_r;
  wire [29:0]  _ptw_io_requestor_0_pmp_2_addr;
  wire [31:0]  _ptw_io_requestor_0_pmp_2_mask;
  wire         _ptw_io_requestor_0_pmp_3_cfg_l;
  wire [1:0]   _ptw_io_requestor_0_pmp_3_cfg_a;
  wire         _ptw_io_requestor_0_pmp_3_cfg_x;
  wire         _ptw_io_requestor_0_pmp_3_cfg_w;
  wire         _ptw_io_requestor_0_pmp_3_cfg_r;
  wire [29:0]  _ptw_io_requestor_0_pmp_3_addr;
  wire [31:0]  _ptw_io_requestor_0_pmp_3_mask;
  wire         _ptw_io_requestor_0_pmp_4_cfg_l;
  wire [1:0]   _ptw_io_requestor_0_pmp_4_cfg_a;
  wire         _ptw_io_requestor_0_pmp_4_cfg_x;
  wire         _ptw_io_requestor_0_pmp_4_cfg_w;
  wire         _ptw_io_requestor_0_pmp_4_cfg_r;
  wire [29:0]  _ptw_io_requestor_0_pmp_4_addr;
  wire [31:0]  _ptw_io_requestor_0_pmp_4_mask;
  wire         _ptw_io_requestor_0_pmp_5_cfg_l;
  wire [1:0]   _ptw_io_requestor_0_pmp_5_cfg_a;
  wire         _ptw_io_requestor_0_pmp_5_cfg_x;
  wire         _ptw_io_requestor_0_pmp_5_cfg_w;
  wire         _ptw_io_requestor_0_pmp_5_cfg_r;
  wire [29:0]  _ptw_io_requestor_0_pmp_5_addr;
  wire [31:0]  _ptw_io_requestor_0_pmp_5_mask;
  wire         _ptw_io_requestor_0_pmp_6_cfg_l;
  wire [1:0]   _ptw_io_requestor_0_pmp_6_cfg_a;
  wire         _ptw_io_requestor_0_pmp_6_cfg_x;
  wire         _ptw_io_requestor_0_pmp_6_cfg_w;
  wire         _ptw_io_requestor_0_pmp_6_cfg_r;
  wire [29:0]  _ptw_io_requestor_0_pmp_6_addr;
  wire [31:0]  _ptw_io_requestor_0_pmp_6_mask;
  wire         _ptw_io_requestor_0_pmp_7_cfg_l;
  wire [1:0]   _ptw_io_requestor_0_pmp_7_cfg_a;
  wire         _ptw_io_requestor_0_pmp_7_cfg_x;
  wire         _ptw_io_requestor_0_pmp_7_cfg_w;
  wire         _ptw_io_requestor_0_pmp_7_cfg_r;
  wire [29:0]  _ptw_io_requestor_0_pmp_7_addr;
  wire [31:0]  _ptw_io_requestor_0_pmp_7_mask;
  wire         _ptw_io_requestor_1_req_ready;
  wire         _ptw_io_requestor_1_resp_valid;
  wire         _ptw_io_requestor_1_resp_bits_ae_ptw;
  wire         _ptw_io_requestor_1_resp_bits_ae_final;
  wire         _ptw_io_requestor_1_resp_bits_pf;
  wire         _ptw_io_requestor_1_resp_bits_gf;
  wire         _ptw_io_requestor_1_resp_bits_hr;
  wire         _ptw_io_requestor_1_resp_bits_hw;
  wire         _ptw_io_requestor_1_resp_bits_hx;
  wire [43:0]  _ptw_io_requestor_1_resp_bits_pte_ppn;
  wire         _ptw_io_requestor_1_resp_bits_pte_d;
  wire         _ptw_io_requestor_1_resp_bits_pte_a;
  wire         _ptw_io_requestor_1_resp_bits_pte_g;
  wire         _ptw_io_requestor_1_resp_bits_pte_u;
  wire         _ptw_io_requestor_1_resp_bits_pte_x;
  wire         _ptw_io_requestor_1_resp_bits_pte_w;
  wire         _ptw_io_requestor_1_resp_bits_pte_r;
  wire         _ptw_io_requestor_1_resp_bits_pte_v;
  wire [1:0]   _ptw_io_requestor_1_resp_bits_level;
  wire         _ptw_io_requestor_1_resp_bits_homogeneous;
  wire         _ptw_io_requestor_1_resp_bits_gpa_is_pte;
  wire [3:0]   _ptw_io_requestor_1_ptbr_mode;
  wire         _ptw_io_requestor_1_status_debug;
  wire [1:0]   _ptw_io_requestor_1_status_prv;
  wire         _ptw_io_requestor_1_pmp_0_cfg_l;
  wire [1:0]   _ptw_io_requestor_1_pmp_0_cfg_a;
  wire         _ptw_io_requestor_1_pmp_0_cfg_x;
  wire         _ptw_io_requestor_1_pmp_0_cfg_w;
  wire         _ptw_io_requestor_1_pmp_0_cfg_r;
  wire [29:0]  _ptw_io_requestor_1_pmp_0_addr;
  wire [31:0]  _ptw_io_requestor_1_pmp_0_mask;
  wire         _ptw_io_requestor_1_pmp_1_cfg_l;
  wire [1:0]   _ptw_io_requestor_1_pmp_1_cfg_a;
  wire         _ptw_io_requestor_1_pmp_1_cfg_x;
  wire         _ptw_io_requestor_1_pmp_1_cfg_w;
  wire         _ptw_io_requestor_1_pmp_1_cfg_r;
  wire [29:0]  _ptw_io_requestor_1_pmp_1_addr;
  wire [31:0]  _ptw_io_requestor_1_pmp_1_mask;
  wire         _ptw_io_requestor_1_pmp_2_cfg_l;
  wire [1:0]   _ptw_io_requestor_1_pmp_2_cfg_a;
  wire         _ptw_io_requestor_1_pmp_2_cfg_x;
  wire         _ptw_io_requestor_1_pmp_2_cfg_w;
  wire         _ptw_io_requestor_1_pmp_2_cfg_r;
  wire [29:0]  _ptw_io_requestor_1_pmp_2_addr;
  wire [31:0]  _ptw_io_requestor_1_pmp_2_mask;
  wire         _ptw_io_requestor_1_pmp_3_cfg_l;
  wire [1:0]   _ptw_io_requestor_1_pmp_3_cfg_a;
  wire         _ptw_io_requestor_1_pmp_3_cfg_x;
  wire         _ptw_io_requestor_1_pmp_3_cfg_w;
  wire         _ptw_io_requestor_1_pmp_3_cfg_r;
  wire [29:0]  _ptw_io_requestor_1_pmp_3_addr;
  wire [31:0]  _ptw_io_requestor_1_pmp_3_mask;
  wire         _ptw_io_requestor_1_pmp_4_cfg_l;
  wire [1:0]   _ptw_io_requestor_1_pmp_4_cfg_a;
  wire         _ptw_io_requestor_1_pmp_4_cfg_x;
  wire         _ptw_io_requestor_1_pmp_4_cfg_w;
  wire         _ptw_io_requestor_1_pmp_4_cfg_r;
  wire [29:0]  _ptw_io_requestor_1_pmp_4_addr;
  wire [31:0]  _ptw_io_requestor_1_pmp_4_mask;
  wire         _ptw_io_requestor_1_pmp_5_cfg_l;
  wire [1:0]   _ptw_io_requestor_1_pmp_5_cfg_a;
  wire         _ptw_io_requestor_1_pmp_5_cfg_x;
  wire         _ptw_io_requestor_1_pmp_5_cfg_w;
  wire         _ptw_io_requestor_1_pmp_5_cfg_r;
  wire [29:0]  _ptw_io_requestor_1_pmp_5_addr;
  wire [31:0]  _ptw_io_requestor_1_pmp_5_mask;
  wire         _ptw_io_requestor_1_pmp_6_cfg_l;
  wire [1:0]   _ptw_io_requestor_1_pmp_6_cfg_a;
  wire         _ptw_io_requestor_1_pmp_6_cfg_x;
  wire         _ptw_io_requestor_1_pmp_6_cfg_w;
  wire         _ptw_io_requestor_1_pmp_6_cfg_r;
  wire [29:0]  _ptw_io_requestor_1_pmp_6_addr;
  wire [31:0]  _ptw_io_requestor_1_pmp_6_mask;
  wire         _ptw_io_requestor_1_pmp_7_cfg_l;
  wire [1:0]   _ptw_io_requestor_1_pmp_7_cfg_a;
  wire         _ptw_io_requestor_1_pmp_7_cfg_x;
  wire         _ptw_io_requestor_1_pmp_7_cfg_w;
  wire         _ptw_io_requestor_1_pmp_7_cfg_r;
  wire [29:0]  _ptw_io_requestor_1_pmp_7_addr;
  wire [31:0]  _ptw_io_requestor_1_pmp_7_mask;
  wire         _ptw_io_mem_req_valid;
  wire [39:0]  _ptw_io_mem_req_bits_addr;
  wire         _ptw_io_mem_s1_kill;
  wire         _lsu_io_ptw_req_valid;
  wire         _lsu_io_ptw_req_bits_valid;
  wire [26:0]  _lsu_io_ptw_req_bits_bits_addr;
  wire         _lsu_io_core_exe_0_iresp_valid;
  wire [6:0]   _lsu_io_core_exe_0_iresp_bits_uop_rob_idx;
  wire [6:0]   _lsu_io_core_exe_0_iresp_bits_uop_pdst;
  wire         _lsu_io_core_exe_0_iresp_bits_uop_is_amo;
  wire         _lsu_io_core_exe_0_iresp_bits_uop_uses_stq;
  wire [1:0]   _lsu_io_core_exe_0_iresp_bits_uop_dst_rtype;
  wire [63:0]  _lsu_io_core_exe_0_iresp_bits_data;
  wire         _lsu_io_core_exe_0_fresp_valid;
  wire [6:0]   _lsu_io_core_exe_0_fresp_bits_uop_uopc;
  wire [19:0]  _lsu_io_core_exe_0_fresp_bits_uop_br_mask;
  wire [6:0]   _lsu_io_core_exe_0_fresp_bits_uop_rob_idx;
  wire [4:0]   _lsu_io_core_exe_0_fresp_bits_uop_stq_idx;
  wire [6:0]   _lsu_io_core_exe_0_fresp_bits_uop_pdst;
  wire [1:0]   _lsu_io_core_exe_0_fresp_bits_uop_mem_size;
  wire         _lsu_io_core_exe_0_fresp_bits_uop_is_amo;
  wire         _lsu_io_core_exe_0_fresp_bits_uop_uses_stq;
  wire [1:0]   _lsu_io_core_exe_0_fresp_bits_uop_dst_rtype;
  wire         _lsu_io_core_exe_0_fresp_bits_uop_fp_val;
  wire [64:0]  _lsu_io_core_exe_0_fresp_bits_data;
  wire         _lsu_io_core_exe_1_iresp_valid;
  wire [6:0]   _lsu_io_core_exe_1_iresp_bits_uop_rob_idx;
  wire [6:0]   _lsu_io_core_exe_1_iresp_bits_uop_pdst;
  wire         _lsu_io_core_exe_1_iresp_bits_uop_is_amo;
  wire         _lsu_io_core_exe_1_iresp_bits_uop_uses_stq;
  wire [1:0]   _lsu_io_core_exe_1_iresp_bits_uop_dst_rtype;
  wire [63:0]  _lsu_io_core_exe_1_iresp_bits_data;
  wire         _lsu_io_core_exe_1_fresp_valid;
  wire [6:0]   _lsu_io_core_exe_1_fresp_bits_uop_uopc;
  wire [19:0]  _lsu_io_core_exe_1_fresp_bits_uop_br_mask;
  wire [6:0]   _lsu_io_core_exe_1_fresp_bits_uop_rob_idx;
  wire [4:0]   _lsu_io_core_exe_1_fresp_bits_uop_stq_idx;
  wire [6:0]   _lsu_io_core_exe_1_fresp_bits_uop_pdst;
  wire [1:0]   _lsu_io_core_exe_1_fresp_bits_uop_mem_size;
  wire         _lsu_io_core_exe_1_fresp_bits_uop_is_amo;
  wire         _lsu_io_core_exe_1_fresp_bits_uop_uses_stq;
  wire [1:0]   _lsu_io_core_exe_1_fresp_bits_uop_dst_rtype;
  wire         _lsu_io_core_exe_1_fresp_bits_uop_fp_val;
  wire [64:0]  _lsu_io_core_exe_1_fresp_bits_data;
  wire [4:0]   _lsu_io_core_dis_ldq_idx_0;
  wire [4:0]   _lsu_io_core_dis_ldq_idx_1;
  wire [4:0]   _lsu_io_core_dis_ldq_idx_2;
  wire [4:0]   _lsu_io_core_dis_ldq_idx_3;
  wire [4:0]   _lsu_io_core_dis_stq_idx_0;
  wire [4:0]   _lsu_io_core_dis_stq_idx_1;
  wire [4:0]   _lsu_io_core_dis_stq_idx_2;
  wire [4:0]   _lsu_io_core_dis_stq_idx_3;
  wire         _lsu_io_core_ldq_full_0;
  wire         _lsu_io_core_ldq_full_1;
  wire         _lsu_io_core_ldq_full_2;
  wire         _lsu_io_core_ldq_full_3;
  wire         _lsu_io_core_stq_full_0;
  wire         _lsu_io_core_stq_full_1;
  wire         _lsu_io_core_stq_full_2;
  wire         _lsu_io_core_stq_full_3;
  wire         _lsu_io_core_fp_stdata_ready;
  wire         _lsu_io_core_clr_bsy_0_valid;
  wire [6:0]   _lsu_io_core_clr_bsy_0_bits;
  wire         _lsu_io_core_clr_bsy_1_valid;
  wire [6:0]   _lsu_io_core_clr_bsy_1_bits;
  wire         _lsu_io_core_clr_bsy_2_valid;
  wire [6:0]   _lsu_io_core_clr_bsy_2_bits;
  wire         _lsu_io_core_spec_ld_wakeup_0_valid;
  wire [6:0]   _lsu_io_core_spec_ld_wakeup_0_bits;
  wire         _lsu_io_core_spec_ld_wakeup_1_valid;
  wire [6:0]   _lsu_io_core_spec_ld_wakeup_1_bits;
  wire         _lsu_io_core_ld_miss;
  wire         _lsu_io_core_fencei_rdy;
  wire         _lsu_io_core_lxcpt_valid;
  wire [19:0]  _lsu_io_core_lxcpt_bits_uop_br_mask;
  wire [6:0]   _lsu_io_core_lxcpt_bits_uop_rob_idx;
  wire [4:0]   _lsu_io_core_lxcpt_bits_cause;
  wire [39:0]  _lsu_io_core_lxcpt_bits_badvaddr;
  wire         _lsu_io_dmem_req_valid;
  wire         _lsu_io_dmem_req_bits_0_valid;
  wire [19:0]  _lsu_io_dmem_req_bits_0_bits_uop_br_mask;
  wire [4:0]   _lsu_io_dmem_req_bits_0_bits_uop_ldq_idx;
  wire [4:0]   _lsu_io_dmem_req_bits_0_bits_uop_stq_idx;
  wire [4:0]   _lsu_io_dmem_req_bits_0_bits_uop_mem_cmd;
  wire [1:0]   _lsu_io_dmem_req_bits_0_bits_uop_mem_size;
  wire         _lsu_io_dmem_req_bits_0_bits_uop_mem_signed;
  wire         _lsu_io_dmem_req_bits_0_bits_uop_is_amo;
  wire         _lsu_io_dmem_req_bits_0_bits_uop_uses_ldq;
  wire         _lsu_io_dmem_req_bits_0_bits_uop_uses_stq;
  wire [39:0]  _lsu_io_dmem_req_bits_0_bits_addr;
  wire [63:0]  _lsu_io_dmem_req_bits_0_bits_data;
  wire         _lsu_io_dmem_req_bits_1_valid;
  wire [19:0]  _lsu_io_dmem_req_bits_1_bits_uop_br_mask;
  wire [4:0]   _lsu_io_dmem_req_bits_1_bits_uop_ldq_idx;
  wire [4:0]   _lsu_io_dmem_req_bits_1_bits_uop_stq_idx;
  wire [4:0]   _lsu_io_dmem_req_bits_1_bits_uop_mem_cmd;
  wire [1:0]   _lsu_io_dmem_req_bits_1_bits_uop_mem_size;
  wire         _lsu_io_dmem_req_bits_1_bits_uop_mem_signed;
  wire         _lsu_io_dmem_req_bits_1_bits_uop_is_amo;
  wire         _lsu_io_dmem_req_bits_1_bits_uop_uses_ldq;
  wire         _lsu_io_dmem_req_bits_1_bits_uop_uses_stq;
  wire [39:0]  _lsu_io_dmem_req_bits_1_bits_addr;
  wire [63:0]  _lsu_io_dmem_req_bits_1_bits_data;
  wire         _lsu_io_dmem_req_bits_1_bits_is_hella;
  wire         _lsu_io_dmem_s1_kill_0;
  wire         _lsu_io_dmem_s1_kill_1;
  wire [19:0]  _lsu_io_dmem_brupdate_b1_resolve_mask;
  wire [19:0]  _lsu_io_dmem_brupdate_b1_mispredict_mask;
  wire         _lsu_io_dmem_exception;
  wire         _lsu_io_dmem_release_ready;
  wire         _lsu_io_dmem_force_order;
  wire         _lsu_io_hellacache_req_ready;
  wire         _lsu_io_hellacache_s2_nack;
  wire         _lsu_io_hellacache_resp_valid;
  wire [63:0]  _lsu_io_hellacache_resp_bits_data;
  wire         _lsu_io_hellacache_s2_xcpt_ae_ld;
  wire         _core_io_ifu_fetchpacket_ready;
  wire [5:0]   _core_io_ifu_get_pc_0_ftq_idx;
  wire [5:0]   _core_io_ifu_get_pc_1_ftq_idx;
  wire         _core_io_ifu_sfence_valid;
  wire         _core_io_ifu_sfence_bits_rs1;
  wire         _core_io_ifu_sfence_bits_rs2;
  wire [38:0]  _core_io_ifu_sfence_bits_addr;
  wire [5:0]   _core_io_ifu_brupdate_b2_uop_ftq_idx;
  wire [5:0]   _core_io_ifu_brupdate_b2_uop_pc_lob;
  wire         _core_io_ifu_brupdate_b2_mispredict;
  wire         _core_io_ifu_brupdate_b2_taken;
  wire         _core_io_ifu_redirect_flush;
  wire         _core_io_ifu_redirect_val;
  wire [39:0]  _core_io_ifu_redirect_pc;
  wire [5:0]   _core_io_ifu_redirect_ftq_idx;
  wire [63:0]  _core_io_ifu_redirect_ghist_old_history;
  wire         _core_io_ifu_redirect_ghist_current_saw_branch_not_taken;
  wire         _core_io_ifu_redirect_ghist_new_saw_branch_not_taken;
  wire         _core_io_ifu_redirect_ghist_new_saw_branch_taken;
  wire [4:0]   _core_io_ifu_redirect_ghist_ras_idx;
  wire         _core_io_ifu_commit_valid;
  wire [39:0]  _core_io_ifu_commit_bits;
  wire         _core_io_ifu_flush_icache;
  wire [3:0]   _core_io_ptw_ptbr_mode;
  wire [43:0]  _core_io_ptw_ptbr_ppn;
  wire         _core_io_ptw_sfence_valid;
  wire         _core_io_ptw_sfence_bits_rs1;
  wire         _core_io_ptw_sfence_bits_rs2;
  wire [38:0]  _core_io_ptw_sfence_bits_addr;
  wire         _core_io_ptw_status_debug;
  wire [1:0]   _core_io_ptw_status_dprv;
  wire [1:0]   _core_io_ptw_status_prv;
  wire         _core_io_ptw_status_mxr;
  wire         _core_io_ptw_status_sum;
  wire         _core_io_ptw_pmp_0_cfg_l;
  wire [1:0]   _core_io_ptw_pmp_0_cfg_a;
  wire         _core_io_ptw_pmp_0_cfg_x;
  wire         _core_io_ptw_pmp_0_cfg_w;
  wire         _core_io_ptw_pmp_0_cfg_r;
  wire [29:0]  _core_io_ptw_pmp_0_addr;
  wire [31:0]  _core_io_ptw_pmp_0_mask;
  wire         _core_io_ptw_pmp_1_cfg_l;
  wire [1:0]   _core_io_ptw_pmp_1_cfg_a;
  wire         _core_io_ptw_pmp_1_cfg_x;
  wire         _core_io_ptw_pmp_1_cfg_w;
  wire         _core_io_ptw_pmp_1_cfg_r;
  wire [29:0]  _core_io_ptw_pmp_1_addr;
  wire [31:0]  _core_io_ptw_pmp_1_mask;
  wire         _core_io_ptw_pmp_2_cfg_l;
  wire [1:0]   _core_io_ptw_pmp_2_cfg_a;
  wire         _core_io_ptw_pmp_2_cfg_x;
  wire         _core_io_ptw_pmp_2_cfg_w;
  wire         _core_io_ptw_pmp_2_cfg_r;
  wire [29:0]  _core_io_ptw_pmp_2_addr;
  wire [31:0]  _core_io_ptw_pmp_2_mask;
  wire         _core_io_ptw_pmp_3_cfg_l;
  wire [1:0]   _core_io_ptw_pmp_3_cfg_a;
  wire         _core_io_ptw_pmp_3_cfg_x;
  wire         _core_io_ptw_pmp_3_cfg_w;
  wire         _core_io_ptw_pmp_3_cfg_r;
  wire [29:0]  _core_io_ptw_pmp_3_addr;
  wire [31:0]  _core_io_ptw_pmp_3_mask;
  wire         _core_io_ptw_pmp_4_cfg_l;
  wire [1:0]   _core_io_ptw_pmp_4_cfg_a;
  wire         _core_io_ptw_pmp_4_cfg_x;
  wire         _core_io_ptw_pmp_4_cfg_w;
  wire         _core_io_ptw_pmp_4_cfg_r;
  wire [29:0]  _core_io_ptw_pmp_4_addr;
  wire [31:0]  _core_io_ptw_pmp_4_mask;
  wire         _core_io_ptw_pmp_5_cfg_l;
  wire [1:0]   _core_io_ptw_pmp_5_cfg_a;
  wire         _core_io_ptw_pmp_5_cfg_x;
  wire         _core_io_ptw_pmp_5_cfg_w;
  wire         _core_io_ptw_pmp_5_cfg_r;
  wire [29:0]  _core_io_ptw_pmp_5_addr;
  wire [31:0]  _core_io_ptw_pmp_5_mask;
  wire         _core_io_ptw_pmp_6_cfg_l;
  wire [1:0]   _core_io_ptw_pmp_6_cfg_a;
  wire         _core_io_ptw_pmp_6_cfg_x;
  wire         _core_io_ptw_pmp_6_cfg_w;
  wire         _core_io_ptw_pmp_6_cfg_r;
  wire [29:0]  _core_io_ptw_pmp_6_addr;
  wire [31:0]  _core_io_ptw_pmp_6_mask;
  wire         _core_io_ptw_pmp_7_cfg_l;
  wire [1:0]   _core_io_ptw_pmp_7_cfg_a;
  wire         _core_io_ptw_pmp_7_cfg_x;
  wire         _core_io_ptw_pmp_7_cfg_w;
  wire         _core_io_ptw_pmp_7_cfg_r;
  wire [29:0]  _core_io_ptw_pmp_7_addr;
  wire [31:0]  _core_io_ptw_pmp_7_mask;
  wire         _core_io_lsu_exe_0_req_valid;
  wire         _core_io_lsu_exe_0_req_bits_uop_ctrl_is_load;
  wire         _core_io_lsu_exe_0_req_bits_uop_ctrl_is_sta;
  wire         _core_io_lsu_exe_0_req_bits_uop_ctrl_is_std;
  wire [19:0]  _core_io_lsu_exe_0_req_bits_uop_br_mask;
  wire [6:0]   _core_io_lsu_exe_0_req_bits_uop_rob_idx;
  wire [4:0]   _core_io_lsu_exe_0_req_bits_uop_ldq_idx;
  wire [4:0]   _core_io_lsu_exe_0_req_bits_uop_stq_idx;
  wire [6:0]   _core_io_lsu_exe_0_req_bits_uop_pdst;
  wire [4:0]   _core_io_lsu_exe_0_req_bits_uop_mem_cmd;
  wire [1:0]   _core_io_lsu_exe_0_req_bits_uop_mem_size;
  wire         _core_io_lsu_exe_0_req_bits_uop_mem_signed;
  wire         _core_io_lsu_exe_0_req_bits_uop_is_fence;
  wire         _core_io_lsu_exe_0_req_bits_uop_is_amo;
  wire         _core_io_lsu_exe_0_req_bits_uop_uses_ldq;
  wire         _core_io_lsu_exe_0_req_bits_uop_uses_stq;
  wire         _core_io_lsu_exe_0_req_bits_uop_fp_val;
  wire [63:0]  _core_io_lsu_exe_0_req_bits_data;
  wire [39:0]  _core_io_lsu_exe_0_req_bits_addr;
  wire         _core_io_lsu_exe_0_req_bits_mxcpt_valid;
  wire         _core_io_lsu_exe_0_req_bits_sfence_valid;
  wire         _core_io_lsu_exe_0_req_bits_sfence_bits_rs1;
  wire         _core_io_lsu_exe_0_req_bits_sfence_bits_rs2;
  wire [38:0]  _core_io_lsu_exe_0_req_bits_sfence_bits_addr;
  wire         _core_io_lsu_exe_1_req_valid;
  wire         _core_io_lsu_exe_1_req_bits_uop_ctrl_is_load;
  wire         _core_io_lsu_exe_1_req_bits_uop_ctrl_is_sta;
  wire         _core_io_lsu_exe_1_req_bits_uop_ctrl_is_std;
  wire [19:0]  _core_io_lsu_exe_1_req_bits_uop_br_mask;
  wire [6:0]   _core_io_lsu_exe_1_req_bits_uop_rob_idx;
  wire [4:0]   _core_io_lsu_exe_1_req_bits_uop_ldq_idx;
  wire [4:0]   _core_io_lsu_exe_1_req_bits_uop_stq_idx;
  wire [6:0]   _core_io_lsu_exe_1_req_bits_uop_pdst;
  wire [4:0]   _core_io_lsu_exe_1_req_bits_uop_mem_cmd;
  wire [1:0]   _core_io_lsu_exe_1_req_bits_uop_mem_size;
  wire         _core_io_lsu_exe_1_req_bits_uop_mem_signed;
  wire         _core_io_lsu_exe_1_req_bits_uop_is_fence;
  wire         _core_io_lsu_exe_1_req_bits_uop_is_amo;
  wire         _core_io_lsu_exe_1_req_bits_uop_uses_ldq;
  wire         _core_io_lsu_exe_1_req_bits_uop_uses_stq;
  wire         _core_io_lsu_exe_1_req_bits_uop_fp_val;
  wire [63:0]  _core_io_lsu_exe_1_req_bits_data;
  wire [39:0]  _core_io_lsu_exe_1_req_bits_addr;
  wire         _core_io_lsu_exe_1_req_bits_mxcpt_valid;
  wire         _core_io_lsu_exe_1_req_bits_sfence_valid;
  wire         _core_io_lsu_exe_1_req_bits_sfence_bits_rs1;
  wire         _core_io_lsu_exe_1_req_bits_sfence_bits_rs2;
  wire [38:0]  _core_io_lsu_exe_1_req_bits_sfence_bits_addr;
  wire         _core_io_lsu_dis_uops_0_valid;
  wire [6:0]   _core_io_lsu_dis_uops_0_bits_uopc;
  wire         _core_io_lsu_dis_uops_0_bits_ctrl_is_load;
  wire         _core_io_lsu_dis_uops_0_bits_ctrl_is_sta;
  wire [19:0]  _core_io_lsu_dis_uops_0_bits_br_mask;
  wire [6:0]   _core_io_lsu_dis_uops_0_bits_rob_idx;
  wire [4:0]   _core_io_lsu_dis_uops_0_bits_ldq_idx;
  wire [4:0]   _core_io_lsu_dis_uops_0_bits_stq_idx;
  wire [6:0]   _core_io_lsu_dis_uops_0_bits_pdst;
  wire         _core_io_lsu_dis_uops_0_bits_exception;
  wire [4:0]   _core_io_lsu_dis_uops_0_bits_mem_cmd;
  wire [1:0]   _core_io_lsu_dis_uops_0_bits_mem_size;
  wire         _core_io_lsu_dis_uops_0_bits_mem_signed;
  wire         _core_io_lsu_dis_uops_0_bits_is_fence;
  wire         _core_io_lsu_dis_uops_0_bits_is_amo;
  wire         _core_io_lsu_dis_uops_0_bits_uses_ldq;
  wire         _core_io_lsu_dis_uops_0_bits_uses_stq;
  wire [1:0]   _core_io_lsu_dis_uops_0_bits_dst_rtype;
  wire         _core_io_lsu_dis_uops_0_bits_fp_val;
  wire         _core_io_lsu_dis_uops_1_valid;
  wire [6:0]   _core_io_lsu_dis_uops_1_bits_uopc;
  wire         _core_io_lsu_dis_uops_1_bits_ctrl_is_load;
  wire         _core_io_lsu_dis_uops_1_bits_ctrl_is_sta;
  wire [19:0]  _core_io_lsu_dis_uops_1_bits_br_mask;
  wire [6:0]   _core_io_lsu_dis_uops_1_bits_rob_idx;
  wire [4:0]   _core_io_lsu_dis_uops_1_bits_ldq_idx;
  wire [4:0]   _core_io_lsu_dis_uops_1_bits_stq_idx;
  wire [6:0]   _core_io_lsu_dis_uops_1_bits_pdst;
  wire         _core_io_lsu_dis_uops_1_bits_exception;
  wire [4:0]   _core_io_lsu_dis_uops_1_bits_mem_cmd;
  wire [1:0]   _core_io_lsu_dis_uops_1_bits_mem_size;
  wire         _core_io_lsu_dis_uops_1_bits_mem_signed;
  wire         _core_io_lsu_dis_uops_1_bits_is_fence;
  wire         _core_io_lsu_dis_uops_1_bits_is_amo;
  wire         _core_io_lsu_dis_uops_1_bits_uses_ldq;
  wire         _core_io_lsu_dis_uops_1_bits_uses_stq;
  wire [1:0]   _core_io_lsu_dis_uops_1_bits_dst_rtype;
  wire         _core_io_lsu_dis_uops_1_bits_fp_val;
  wire         _core_io_lsu_dis_uops_2_valid;
  wire [6:0]   _core_io_lsu_dis_uops_2_bits_uopc;
  wire         _core_io_lsu_dis_uops_2_bits_ctrl_is_load;
  wire         _core_io_lsu_dis_uops_2_bits_ctrl_is_sta;
  wire [19:0]  _core_io_lsu_dis_uops_2_bits_br_mask;
  wire [6:0]   _core_io_lsu_dis_uops_2_bits_rob_idx;
  wire [4:0]   _core_io_lsu_dis_uops_2_bits_ldq_idx;
  wire [4:0]   _core_io_lsu_dis_uops_2_bits_stq_idx;
  wire [6:0]   _core_io_lsu_dis_uops_2_bits_pdst;
  wire         _core_io_lsu_dis_uops_2_bits_exception;
  wire [4:0]   _core_io_lsu_dis_uops_2_bits_mem_cmd;
  wire [1:0]   _core_io_lsu_dis_uops_2_bits_mem_size;
  wire         _core_io_lsu_dis_uops_2_bits_mem_signed;
  wire         _core_io_lsu_dis_uops_2_bits_is_fence;
  wire         _core_io_lsu_dis_uops_2_bits_is_amo;
  wire         _core_io_lsu_dis_uops_2_bits_uses_ldq;
  wire         _core_io_lsu_dis_uops_2_bits_uses_stq;
  wire [1:0]   _core_io_lsu_dis_uops_2_bits_dst_rtype;
  wire         _core_io_lsu_dis_uops_2_bits_fp_val;
  wire         _core_io_lsu_dis_uops_3_valid;
  wire [6:0]   _core_io_lsu_dis_uops_3_bits_uopc;
  wire         _core_io_lsu_dis_uops_3_bits_ctrl_is_load;
  wire         _core_io_lsu_dis_uops_3_bits_ctrl_is_sta;
  wire [19:0]  _core_io_lsu_dis_uops_3_bits_br_mask;
  wire [6:0]   _core_io_lsu_dis_uops_3_bits_rob_idx;
  wire [4:0]   _core_io_lsu_dis_uops_3_bits_ldq_idx;
  wire [4:0]   _core_io_lsu_dis_uops_3_bits_stq_idx;
  wire [6:0]   _core_io_lsu_dis_uops_3_bits_pdst;
  wire         _core_io_lsu_dis_uops_3_bits_exception;
  wire [4:0]   _core_io_lsu_dis_uops_3_bits_mem_cmd;
  wire [1:0]   _core_io_lsu_dis_uops_3_bits_mem_size;
  wire         _core_io_lsu_dis_uops_3_bits_mem_signed;
  wire         _core_io_lsu_dis_uops_3_bits_is_fence;
  wire         _core_io_lsu_dis_uops_3_bits_is_amo;
  wire         _core_io_lsu_dis_uops_3_bits_uses_ldq;
  wire         _core_io_lsu_dis_uops_3_bits_uses_stq;
  wire [1:0]   _core_io_lsu_dis_uops_3_bits_dst_rtype;
  wire         _core_io_lsu_dis_uops_3_bits_fp_val;
  wire         _core_io_lsu_fp_stdata_valid;
  wire [19:0]  _core_io_lsu_fp_stdata_bits_uop_br_mask;
  wire [6:0]   _core_io_lsu_fp_stdata_bits_uop_rob_idx;
  wire [4:0]   _core_io_lsu_fp_stdata_bits_uop_stq_idx;
  wire [63:0]  _core_io_lsu_fp_stdata_bits_data;
  wire         _core_io_lsu_commit_valids_0;
  wire         _core_io_lsu_commit_valids_1;
  wire         _core_io_lsu_commit_valids_2;
  wire         _core_io_lsu_commit_valids_3;
  wire         _core_io_lsu_commit_uops_0_uses_ldq;
  wire         _core_io_lsu_commit_uops_0_uses_stq;
  wire         _core_io_lsu_commit_uops_1_uses_ldq;
  wire         _core_io_lsu_commit_uops_1_uses_stq;
  wire         _core_io_lsu_commit_uops_2_uses_ldq;
  wire         _core_io_lsu_commit_uops_2_uses_stq;
  wire         _core_io_lsu_commit_uops_3_uses_ldq;
  wire         _core_io_lsu_commit_uops_3_uses_stq;
  wire         _core_io_lsu_commit_load_at_rob_head;
  wire         _core_io_lsu_fence_dmem;
  wire [19:0]  _core_io_lsu_brupdate_b1_resolve_mask;
  wire [19:0]  _core_io_lsu_brupdate_b1_mispredict_mask;
  wire [4:0]   _core_io_lsu_brupdate_b2_uop_ldq_idx;
  wire [4:0]   _core_io_lsu_brupdate_b2_uop_stq_idx;
  wire         _core_io_lsu_brupdate_b2_mispredict;
  wire [6:0]   _core_io_lsu_rob_head_idx;
  wire         _core_io_lsu_exception;
  wire         _buffer_auto_in_a_ready;
  wire         _buffer_auto_in_b_valid;
  wire [2:0]   _buffer_auto_in_b_bits_opcode;
  wire [1:0]   _buffer_auto_in_b_bits_param;
  wire [3:0]   _buffer_auto_in_b_bits_size;
  wire [4:0]   _buffer_auto_in_b_bits_source;
  wire [31:0]  _buffer_auto_in_b_bits_address;
  wire [15:0]  _buffer_auto_in_b_bits_mask;
  wire         _buffer_auto_in_b_bits_corrupt;
  wire         _buffer_auto_in_c_ready;
  wire         _buffer_auto_in_d_valid;
  wire [2:0]   _buffer_auto_in_d_bits_opcode;
  wire [1:0]   _buffer_auto_in_d_bits_param;
  wire [3:0]   _buffer_auto_in_d_bits_size;
  wire [4:0]   _buffer_auto_in_d_bits_source;
  wire [3:0]   _buffer_auto_in_d_bits_sink;
  wire         _buffer_auto_in_d_bits_denied;
  wire [127:0] _buffer_auto_in_d_bits_data;
  wire         _buffer_auto_in_d_bits_corrupt;
  wire         _buffer_auto_in_e_ready;
  wire         _widget_1_auto_in_a_ready;
  wire         _widget_1_auto_in_d_valid;
  wire [2:0]   _widget_1_auto_in_d_bits_opcode;
  wire [3:0]   _widget_1_auto_in_d_bits_size;
  wire [127:0] _widget_1_auto_in_d_bits_data;
  wire         _widget_1_auto_out_a_valid;
  wire [31:0]  _widget_1_auto_out_a_bits_address;
  wire         _frontend_auto_icache_master_out_a_valid;
  wire [31:0]  _frontend_auto_icache_master_out_a_bits_address;
  wire         _frontend_io_cpu_fetchpacket_valid;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_0_valid;
  wire [31:0]  _frontend_io_cpu_fetchpacket_bits_uops_0_bits_inst;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_0_bits_is_rvc;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_load;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_sta;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_0_bits_is_sfb;
  wire [5:0]   _frontend_io_cpu_fetchpacket_bits_uops_0_bits_ftq_idx;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_0_bits_edge_inst;
  wire [5:0]   _frontend_io_cpu_fetchpacket_bits_uops_0_bits_pc_lob;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_0_bits_taken;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_0_bits_xcpt_pf_if;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_0_bits_xcpt_ae_if;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_0_bits_bp_debug_if;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_0_bits_bp_xcpt_if;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_1_valid;
  wire [31:0]  _frontend_io_cpu_fetchpacket_bits_uops_1_bits_inst;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_1_bits_is_rvc;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_load;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_sta;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_1_bits_is_sfb;
  wire [5:0]   _frontend_io_cpu_fetchpacket_bits_uops_1_bits_ftq_idx;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_1_bits_edge_inst;
  wire [5:0]   _frontend_io_cpu_fetchpacket_bits_uops_1_bits_pc_lob;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_1_bits_taken;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_1_bits_xcpt_pf_if;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_1_bits_xcpt_ae_if;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_1_bits_bp_debug_if;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_1_bits_bp_xcpt_if;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_2_valid;
  wire [31:0]  _frontend_io_cpu_fetchpacket_bits_uops_2_bits_inst;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_2_bits_is_rvc;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_2_bits_ctrl_is_load;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_2_bits_ctrl_is_sta;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_2_bits_is_sfb;
  wire [5:0]   _frontend_io_cpu_fetchpacket_bits_uops_2_bits_ftq_idx;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_2_bits_edge_inst;
  wire [5:0]   _frontend_io_cpu_fetchpacket_bits_uops_2_bits_pc_lob;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_2_bits_taken;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_2_bits_xcpt_pf_if;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_2_bits_xcpt_ae_if;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_2_bits_bp_debug_if;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_2_bits_bp_xcpt_if;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_3_valid;
  wire [31:0]  _frontend_io_cpu_fetchpacket_bits_uops_3_bits_inst;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_3_bits_is_rvc;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_3_bits_ctrl_is_load;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_3_bits_ctrl_is_sta;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_3_bits_is_sfb;
  wire [5:0]   _frontend_io_cpu_fetchpacket_bits_uops_3_bits_ftq_idx;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_3_bits_edge_inst;
  wire [5:0]   _frontend_io_cpu_fetchpacket_bits_uops_3_bits_pc_lob;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_3_bits_taken;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_3_bits_xcpt_pf_if;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_3_bits_xcpt_ae_if;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_3_bits_bp_debug_if;
  wire         _frontend_io_cpu_fetchpacket_bits_uops_3_bits_bp_xcpt_if;
  wire         _frontend_io_cpu_get_pc_0_entry_cfi_idx_valid;
  wire [2:0]   _frontend_io_cpu_get_pc_0_entry_cfi_idx_bits;
  wire [4:0]   _frontend_io_cpu_get_pc_0_entry_ras_idx;
  wire         _frontend_io_cpu_get_pc_0_entry_start_bank;
  wire [39:0]  _frontend_io_cpu_get_pc_0_pc;
  wire [39:0]  _frontend_io_cpu_get_pc_0_com_pc;
  wire         _frontend_io_cpu_get_pc_0_next_val;
  wire [39:0]  _frontend_io_cpu_get_pc_0_next_pc;
  wire [2:0]   _frontend_io_cpu_get_pc_1_entry_cfi_idx_bits;
  wire [7:0]   _frontend_io_cpu_get_pc_1_entry_br_mask;
  wire         _frontend_io_cpu_get_pc_1_entry_cfi_is_call;
  wire         _frontend_io_cpu_get_pc_1_entry_cfi_is_ret;
  wire         _frontend_io_cpu_get_pc_1_entry_start_bank;
  wire [63:0]  _frontend_io_cpu_get_pc_1_ghist_old_history;
  wire         _frontend_io_cpu_get_pc_1_ghist_current_saw_branch_not_taken;
  wire         _frontend_io_cpu_get_pc_1_ghist_new_saw_branch_not_taken;
  wire         _frontend_io_cpu_get_pc_1_ghist_new_saw_branch_taken;
  wire [4:0]   _frontend_io_cpu_get_pc_1_ghist_ras_idx;
  wire [39:0]  _frontend_io_cpu_get_pc_1_pc;
  wire         _frontend_io_ptw_req_valid;
  wire [26:0]  _frontend_io_ptw_req_bits_bits_addr;
  wire         _frontend_io_ptw_req_bits_bits_need_gpa;
  wire         _frontend_io_ptw_req_bits_bits_vstage1;
  wire         _frontend_io_ptw_req_bits_bits_stage2;
  wire         _dcache_auto_out_a_valid;
  wire [2:0]   _dcache_auto_out_a_bits_opcode;
  wire [2:0]   _dcache_auto_out_a_bits_param;
  wire [3:0]   _dcache_auto_out_a_bits_size;
  wire [3:0]   _dcache_auto_out_a_bits_source;
  wire [31:0]  _dcache_auto_out_a_bits_address;
  wire [15:0]  _dcache_auto_out_a_bits_mask;
  wire [127:0] _dcache_auto_out_a_bits_data;
  wire         _dcache_auto_out_b_ready;
  wire         _dcache_auto_out_c_valid;
  wire [2:0]   _dcache_auto_out_c_bits_opcode;
  wire [2:0]   _dcache_auto_out_c_bits_param;
  wire [3:0]   _dcache_auto_out_c_bits_size;
  wire [3:0]   _dcache_auto_out_c_bits_source;
  wire [31:0]  _dcache_auto_out_c_bits_address;
  wire [127:0] _dcache_auto_out_c_bits_data;
  wire         _dcache_auto_out_d_ready;
  wire         _dcache_auto_out_e_valid;
  wire [3:0]   _dcache_auto_out_e_bits_sink;
  wire         _dcache_io_lsu_req_ready;
  wire         _dcache_io_lsu_resp_0_valid;
  wire [4:0]   _dcache_io_lsu_resp_0_bits_uop_ldq_idx;
  wire [4:0]   _dcache_io_lsu_resp_0_bits_uop_stq_idx;
  wire         _dcache_io_lsu_resp_0_bits_uop_is_amo;
  wire         _dcache_io_lsu_resp_0_bits_uop_uses_ldq;
  wire         _dcache_io_lsu_resp_0_bits_uop_uses_stq;
  wire [63:0]  _dcache_io_lsu_resp_0_bits_data;
  wire         _dcache_io_lsu_resp_0_bits_is_hella;
  wire         _dcache_io_lsu_resp_1_valid;
  wire [4:0]   _dcache_io_lsu_resp_1_bits_uop_ldq_idx;
  wire [4:0]   _dcache_io_lsu_resp_1_bits_uop_stq_idx;
  wire         _dcache_io_lsu_resp_1_bits_uop_is_amo;
  wire         _dcache_io_lsu_resp_1_bits_uop_uses_ldq;
  wire         _dcache_io_lsu_resp_1_bits_uop_uses_stq;
  wire [63:0]  _dcache_io_lsu_resp_1_bits_data;
  wire         _dcache_io_lsu_resp_1_bits_is_hella;
  wire         _dcache_io_lsu_nack_0_valid;
  wire [4:0]   _dcache_io_lsu_nack_0_bits_uop_ldq_idx;
  wire [4:0]   _dcache_io_lsu_nack_0_bits_uop_stq_idx;
  wire         _dcache_io_lsu_nack_0_bits_uop_uses_ldq;
  wire         _dcache_io_lsu_nack_0_bits_uop_uses_stq;
  wire         _dcache_io_lsu_nack_0_bits_is_hella;
  wire         _dcache_io_lsu_nack_1_valid;
  wire [4:0]   _dcache_io_lsu_nack_1_bits_uop_ldq_idx;
  wire [4:0]   _dcache_io_lsu_nack_1_bits_uop_stq_idx;
  wire         _dcache_io_lsu_nack_1_bits_uop_uses_ldq;
  wire         _dcache_io_lsu_nack_1_bits_uop_uses_stq;
  wire         _dcache_io_lsu_nack_1_bits_is_hella;
  wire         _dcache_io_lsu_release_valid;
  wire [31:0]  _dcache_io_lsu_release_bits_address;
  wire         _dcache_io_lsu_ordered;
  wire         _widget_auto_in_a_ready;
  wire         _widget_auto_in_b_valid;
  wire [1:0]   _widget_auto_in_b_bits_param;
  wire [3:0]   _widget_auto_in_b_bits_size;
  wire [3:0]   _widget_auto_in_b_bits_source;
  wire [31:0]  _widget_auto_in_b_bits_address;
  wire         _widget_auto_in_c_ready;
  wire         _widget_auto_in_d_valid;
  wire [2:0]   _widget_auto_in_d_bits_opcode;
  wire [1:0]   _widget_auto_in_d_bits_param;
  wire [3:0]   _widget_auto_in_d_bits_size;
  wire [3:0]   _widget_auto_in_d_bits_source;
  wire [3:0]   _widget_auto_in_d_bits_sink;
  wire [127:0] _widget_auto_in_d_bits_data;
  wire         _widget_auto_in_e_ready;
  wire         _widget_auto_out_a_valid;
  wire [2:0]   _widget_auto_out_a_bits_opcode;
  wire [2:0]   _widget_auto_out_a_bits_param;
  wire [3:0]   _widget_auto_out_a_bits_size;
  wire [3:0]   _widget_auto_out_a_bits_source;
  wire [31:0]  _widget_auto_out_a_bits_address;
  wire [15:0]  _widget_auto_out_a_bits_mask;
  wire [127:0] _widget_auto_out_a_bits_data;
  wire         _widget_auto_out_b_ready;
  wire         _widget_auto_out_c_valid;
  wire [2:0]   _widget_auto_out_c_bits_opcode;
  wire [2:0]   _widget_auto_out_c_bits_param;
  wire [3:0]   _widget_auto_out_c_bits_size;
  wire [3:0]   _widget_auto_out_c_bits_source;
  wire [31:0]  _widget_auto_out_c_bits_address;
  wire [127:0] _widget_auto_out_c_bits_data;
  wire         _widget_auto_out_d_ready;
  wire         _widget_auto_out_e_valid;
  wire [3:0]   _widget_auto_out_e_bits_sink;
  wire         _broadcast_auto_int_out_0;
  wire         _intXbar_auto_int_out_0;
  wire         _intXbar_auto_int_out_1;
  wire         _intXbar_auto_int_out_2;
  wire         _intXbar_auto_int_out_3;
  wire         _intXbar_auto_int_out_4;
  wire         _tlMasterXbar_auto_in_1_a_ready;
  wire         _tlMasterXbar_auto_in_1_d_valid;
  wire [2:0]   _tlMasterXbar_auto_in_1_d_bits_opcode;
  wire [3:0]   _tlMasterXbar_auto_in_1_d_bits_size;
  wire [127:0] _tlMasterXbar_auto_in_1_d_bits_data;
  wire         _tlMasterXbar_auto_in_0_a_ready;
  wire         _tlMasterXbar_auto_in_0_b_valid;
  wire [1:0]   _tlMasterXbar_auto_in_0_b_bits_param;
  wire [3:0]   _tlMasterXbar_auto_in_0_b_bits_size;
  wire [3:0]   _tlMasterXbar_auto_in_0_b_bits_source;
  wire [31:0]  _tlMasterXbar_auto_in_0_b_bits_address;
  wire         _tlMasterXbar_auto_in_0_c_ready;
  wire         _tlMasterXbar_auto_in_0_d_valid;
  wire [2:0]   _tlMasterXbar_auto_in_0_d_bits_opcode;
  wire [1:0]   _tlMasterXbar_auto_in_0_d_bits_param;
  wire [3:0]   _tlMasterXbar_auto_in_0_d_bits_size;
  wire [3:0]   _tlMasterXbar_auto_in_0_d_bits_source;
  wire [3:0]   _tlMasterXbar_auto_in_0_d_bits_sink;
  wire [127:0] _tlMasterXbar_auto_in_0_d_bits_data;
  wire         _tlMasterXbar_auto_in_0_e_ready;
  wire         _tlMasterXbar_auto_out_a_valid;
  wire [2:0]   _tlMasterXbar_auto_out_a_bits_opcode;
  wire [2:0]   _tlMasterXbar_auto_out_a_bits_param;
  wire [3:0]   _tlMasterXbar_auto_out_a_bits_size;
  wire [4:0]   _tlMasterXbar_auto_out_a_bits_source;
  wire [31:0]  _tlMasterXbar_auto_out_a_bits_address;
  wire [15:0]  _tlMasterXbar_auto_out_a_bits_mask;
  wire [127:0] _tlMasterXbar_auto_out_a_bits_data;
  wire         _tlMasterXbar_auto_out_b_ready;
  wire         _tlMasterXbar_auto_out_c_valid;
  wire [2:0]   _tlMasterXbar_auto_out_c_bits_opcode;
  wire [2:0]   _tlMasterXbar_auto_out_c_bits_param;
  wire [3:0]   _tlMasterXbar_auto_out_c_bits_size;
  wire [4:0]   _tlMasterXbar_auto_out_c_bits_source;
  wire [31:0]  _tlMasterXbar_auto_out_c_bits_address;
  wire [127:0] _tlMasterXbar_auto_out_c_bits_data;
  wire         _tlMasterXbar_auto_out_d_ready;
  wire         _tlMasterXbar_auto_out_e_valid;
  wire [3:0]   _tlMasterXbar_auto_out_e_bits_sink;
  TLXbar_8 tlMasterXbar (
    .clock                    (clock),
    .reset                    (reset),
    .auto_in_1_a_valid        (_widget_1_auto_out_a_valid),
    .auto_in_1_a_bits_address (_widget_1_auto_out_a_bits_address),
    .auto_in_0_a_valid        (_widget_auto_out_a_valid),
    .auto_in_0_a_bits_opcode  (_widget_auto_out_a_bits_opcode),
    .auto_in_0_a_bits_param   (_widget_auto_out_a_bits_param),
    .auto_in_0_a_bits_size    (_widget_auto_out_a_bits_size),
    .auto_in_0_a_bits_source  (_widget_auto_out_a_bits_source),
    .auto_in_0_a_bits_address (_widget_auto_out_a_bits_address),
    .auto_in_0_a_bits_mask    (_widget_auto_out_a_bits_mask),
    .auto_in_0_a_bits_data    (_widget_auto_out_a_bits_data),
    .auto_in_0_b_ready        (_widget_auto_out_b_ready),
    .auto_in_0_c_valid        (_widget_auto_out_c_valid),
    .auto_in_0_c_bits_opcode  (_widget_auto_out_c_bits_opcode),
    .auto_in_0_c_bits_param   (_widget_auto_out_c_bits_param),
    .auto_in_0_c_bits_size    (_widget_auto_out_c_bits_size),
    .auto_in_0_c_bits_source  (_widget_auto_out_c_bits_source),
    .auto_in_0_c_bits_address (_widget_auto_out_c_bits_address),
    .auto_in_0_c_bits_data    (_widget_auto_out_c_bits_data),
    .auto_in_0_d_ready        (_widget_auto_out_d_ready),
    .auto_in_0_e_valid        (_widget_auto_out_e_valid),
    .auto_in_0_e_bits_sink    (_widget_auto_out_e_bits_sink),
    .auto_out_a_ready         (_buffer_auto_in_a_ready),
    .auto_out_b_valid         (_buffer_auto_in_b_valid),
    .auto_out_b_bits_opcode   (_buffer_auto_in_b_bits_opcode),
    .auto_out_b_bits_param    (_buffer_auto_in_b_bits_param),
    .auto_out_b_bits_size     (_buffer_auto_in_b_bits_size),
    .auto_out_b_bits_source   (_buffer_auto_in_b_bits_source),
    .auto_out_b_bits_address  (_buffer_auto_in_b_bits_address),
    .auto_out_b_bits_mask     (_buffer_auto_in_b_bits_mask),
    .auto_out_b_bits_corrupt  (_buffer_auto_in_b_bits_corrupt),
    .auto_out_c_ready         (_buffer_auto_in_c_ready),
    .auto_out_d_valid         (_buffer_auto_in_d_valid),
    .auto_out_d_bits_opcode   (_buffer_auto_in_d_bits_opcode),
    .auto_out_d_bits_param    (_buffer_auto_in_d_bits_param),
    .auto_out_d_bits_size     (_buffer_auto_in_d_bits_size),
    .auto_out_d_bits_source   (_buffer_auto_in_d_bits_source),
    .auto_out_d_bits_sink     (_buffer_auto_in_d_bits_sink),
    .auto_out_d_bits_denied   (_buffer_auto_in_d_bits_denied),
    .auto_out_d_bits_data     (_buffer_auto_in_d_bits_data),
    .auto_out_d_bits_corrupt  (_buffer_auto_in_d_bits_corrupt),
    .auto_out_e_ready         (_buffer_auto_in_e_ready),
    .auto_in_1_a_ready        (_tlMasterXbar_auto_in_1_a_ready),
    .auto_in_1_d_valid        (_tlMasterXbar_auto_in_1_d_valid),
    .auto_in_1_d_bits_opcode  (_tlMasterXbar_auto_in_1_d_bits_opcode),
    .auto_in_1_d_bits_size    (_tlMasterXbar_auto_in_1_d_bits_size),
    .auto_in_1_d_bits_data    (_tlMasterXbar_auto_in_1_d_bits_data),
    .auto_in_0_a_ready        (_tlMasterXbar_auto_in_0_a_ready),
    .auto_in_0_b_valid        (_tlMasterXbar_auto_in_0_b_valid),
    .auto_in_0_b_bits_param   (_tlMasterXbar_auto_in_0_b_bits_param),
    .auto_in_0_b_bits_size    (_tlMasterXbar_auto_in_0_b_bits_size),
    .auto_in_0_b_bits_source  (_tlMasterXbar_auto_in_0_b_bits_source),
    .auto_in_0_b_bits_address (_tlMasterXbar_auto_in_0_b_bits_address),
    .auto_in_0_c_ready        (_tlMasterXbar_auto_in_0_c_ready),
    .auto_in_0_d_valid        (_tlMasterXbar_auto_in_0_d_valid),
    .auto_in_0_d_bits_opcode  (_tlMasterXbar_auto_in_0_d_bits_opcode),
    .auto_in_0_d_bits_param   (_tlMasterXbar_auto_in_0_d_bits_param),
    .auto_in_0_d_bits_size    (_tlMasterXbar_auto_in_0_d_bits_size),
    .auto_in_0_d_bits_source  (_tlMasterXbar_auto_in_0_d_bits_source),
    .auto_in_0_d_bits_sink    (_tlMasterXbar_auto_in_0_d_bits_sink),
    .auto_in_0_d_bits_data    (_tlMasterXbar_auto_in_0_d_bits_data),
    .auto_in_0_e_ready        (_tlMasterXbar_auto_in_0_e_ready),
    .auto_out_a_valid         (_tlMasterXbar_auto_out_a_valid),
    .auto_out_a_bits_opcode   (_tlMasterXbar_auto_out_a_bits_opcode),
    .auto_out_a_bits_param    (_tlMasterXbar_auto_out_a_bits_param),
    .auto_out_a_bits_size     (_tlMasterXbar_auto_out_a_bits_size),
    .auto_out_a_bits_source   (_tlMasterXbar_auto_out_a_bits_source),
    .auto_out_a_bits_address  (_tlMasterXbar_auto_out_a_bits_address),
    .auto_out_a_bits_mask     (_tlMasterXbar_auto_out_a_bits_mask),
    .auto_out_a_bits_data     (_tlMasterXbar_auto_out_a_bits_data),
    .auto_out_b_ready         (_tlMasterXbar_auto_out_b_ready),
    .auto_out_c_valid         (_tlMasterXbar_auto_out_c_valid),
    .auto_out_c_bits_opcode   (_tlMasterXbar_auto_out_c_bits_opcode),
    .auto_out_c_bits_param    (_tlMasterXbar_auto_out_c_bits_param),
    .auto_out_c_bits_size     (_tlMasterXbar_auto_out_c_bits_size),
    .auto_out_c_bits_source   (_tlMasterXbar_auto_out_c_bits_source),
    .auto_out_c_bits_address  (_tlMasterXbar_auto_out_c_bits_address),
    .auto_out_c_bits_data     (_tlMasterXbar_auto_out_c_bits_data),
    .auto_out_d_ready         (_tlMasterXbar_auto_out_d_ready),
    .auto_out_e_valid         (_tlMasterXbar_auto_out_e_valid),
    .auto_out_e_bits_sink     (_tlMasterXbar_auto_out_e_bits_sink)
  );
  IntXbar_1 intXbar (
    .auto_int_in_3_0 (auto_int_local_in_3_0),
    .auto_int_in_2_0 (auto_int_local_in_2_0),
    .auto_int_in_1_0 (auto_int_local_in_1_0),
    .auto_int_in_1_1 (auto_int_local_in_1_1),
    .auto_int_in_0_0 (auto_int_local_in_0_0),
    .auto_int_out_0  (_intXbar_auto_int_out_0),
    .auto_int_out_1  (_intXbar_auto_int_out_1),
    .auto_int_out_2  (_intXbar_auto_int_out_2),
    .auto_int_out_3  (_intXbar_auto_int_out_3),
    .auto_int_out_4  (_intXbar_auto_int_out_4)
  );
  IntXbar broadcast (
    .auto_int_in_0  (1'h0),
    .auto_int_out_0 (_broadcast_auto_int_out_0)
  );
  TLWidthWidget_8 widget (
    .auto_in_a_valid         (_dcache_auto_out_a_valid),
    .auto_in_a_bits_opcode   (_dcache_auto_out_a_bits_opcode),
    .auto_in_a_bits_param    (_dcache_auto_out_a_bits_param),
    .auto_in_a_bits_size     (_dcache_auto_out_a_bits_size),
    .auto_in_a_bits_source   (_dcache_auto_out_a_bits_source),
    .auto_in_a_bits_address  (_dcache_auto_out_a_bits_address),
    .auto_in_a_bits_mask     (_dcache_auto_out_a_bits_mask),
    .auto_in_a_bits_data     (_dcache_auto_out_a_bits_data),
    .auto_in_b_ready         (_dcache_auto_out_b_ready),
    .auto_in_c_valid         (_dcache_auto_out_c_valid),
    .auto_in_c_bits_opcode   (_dcache_auto_out_c_bits_opcode),
    .auto_in_c_bits_param    (_dcache_auto_out_c_bits_param),
    .auto_in_c_bits_size     (_dcache_auto_out_c_bits_size),
    .auto_in_c_bits_source   (_dcache_auto_out_c_bits_source),
    .auto_in_c_bits_address  (_dcache_auto_out_c_bits_address),
    .auto_in_c_bits_data     (_dcache_auto_out_c_bits_data),
    .auto_in_d_ready         (_dcache_auto_out_d_ready),
    .auto_in_e_valid         (_dcache_auto_out_e_valid),
    .auto_in_e_bits_sink     (_dcache_auto_out_e_bits_sink),
    .auto_out_a_ready        (_tlMasterXbar_auto_in_0_a_ready),
    .auto_out_b_valid        (_tlMasterXbar_auto_in_0_b_valid),
    .auto_out_b_bits_param   (_tlMasterXbar_auto_in_0_b_bits_param),
    .auto_out_b_bits_size    (_tlMasterXbar_auto_in_0_b_bits_size),
    .auto_out_b_bits_source  (_tlMasterXbar_auto_in_0_b_bits_source),
    .auto_out_b_bits_address (_tlMasterXbar_auto_in_0_b_bits_address),
    .auto_out_c_ready        (_tlMasterXbar_auto_in_0_c_ready),
    .auto_out_d_valid        (_tlMasterXbar_auto_in_0_d_valid),
    .auto_out_d_bits_opcode  (_tlMasterXbar_auto_in_0_d_bits_opcode),
    .auto_out_d_bits_param   (_tlMasterXbar_auto_in_0_d_bits_param),
    .auto_out_d_bits_size    (_tlMasterXbar_auto_in_0_d_bits_size),
    .auto_out_d_bits_source  (_tlMasterXbar_auto_in_0_d_bits_source),
    .auto_out_d_bits_sink    (_tlMasterXbar_auto_in_0_d_bits_sink),
    .auto_out_d_bits_data    (_tlMasterXbar_auto_in_0_d_bits_data),
    .auto_out_e_ready        (_tlMasterXbar_auto_in_0_e_ready),
    .auto_in_a_ready         (_widget_auto_in_a_ready),
    .auto_in_b_valid         (_widget_auto_in_b_valid),
    .auto_in_b_bits_param    (_widget_auto_in_b_bits_param),
    .auto_in_b_bits_size     (_widget_auto_in_b_bits_size),
    .auto_in_b_bits_source   (_widget_auto_in_b_bits_source),
    .auto_in_b_bits_address  (_widget_auto_in_b_bits_address),
    .auto_in_c_ready         (_widget_auto_in_c_ready),
    .auto_in_d_valid         (_widget_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_widget_auto_in_d_bits_opcode),
    .auto_in_d_bits_param    (_widget_auto_in_d_bits_param),
    .auto_in_d_bits_size     (_widget_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_widget_auto_in_d_bits_source),
    .auto_in_d_bits_sink     (_widget_auto_in_d_bits_sink),
    .auto_in_d_bits_data     (_widget_auto_in_d_bits_data),
    .auto_in_e_ready         (_widget_auto_in_e_ready),
    .auto_out_a_valid        (_widget_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_widget_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_widget_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_widget_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_widget_auto_out_a_bits_source),
    .auto_out_a_bits_address (_widget_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_widget_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_widget_auto_out_a_bits_data),
    .auto_out_b_ready        (_widget_auto_out_b_ready),
    .auto_out_c_valid        (_widget_auto_out_c_valid),
    .auto_out_c_bits_opcode  (_widget_auto_out_c_bits_opcode),
    .auto_out_c_bits_param   (_widget_auto_out_c_bits_param),
    .auto_out_c_bits_size    (_widget_auto_out_c_bits_size),
    .auto_out_c_bits_source  (_widget_auto_out_c_bits_source),
    .auto_out_c_bits_address (_widget_auto_out_c_bits_address),
    .auto_out_c_bits_data    (_widget_auto_out_c_bits_data),
    .auto_out_d_ready        (_widget_auto_out_d_ready),
    .auto_out_e_valid        (_widget_auto_out_e_valid),
    .auto_out_e_bits_sink    (_widget_auto_out_e_bits_sink)
  );
  BoomNonBlockingDCache dcache (
    .clock                                 (clock),
    .reset                                 (reset),
    .auto_out_a_ready                      (_widget_auto_in_a_ready),
    .auto_out_b_valid                      (_widget_auto_in_b_valid),
    .auto_out_b_bits_param                 (_widget_auto_in_b_bits_param),
    .auto_out_b_bits_size                  (_widget_auto_in_b_bits_size),
    .auto_out_b_bits_source                (_widget_auto_in_b_bits_source),
    .auto_out_b_bits_address               (_widget_auto_in_b_bits_address),
    .auto_out_c_ready                      (_widget_auto_in_c_ready),
    .auto_out_d_valid                      (_widget_auto_in_d_valid),
    .auto_out_d_bits_opcode                (_widget_auto_in_d_bits_opcode),
    .auto_out_d_bits_param                 (_widget_auto_in_d_bits_param),
    .auto_out_d_bits_size                  (_widget_auto_in_d_bits_size),
    .auto_out_d_bits_source                (_widget_auto_in_d_bits_source),
    .auto_out_d_bits_sink                  (_widget_auto_in_d_bits_sink),
    .auto_out_d_bits_data                  (_widget_auto_in_d_bits_data),
    .auto_out_e_ready                      (_widget_auto_in_e_ready),
    .io_lsu_req_valid                      (_lsu_io_dmem_req_valid),
    .io_lsu_req_bits_0_valid               (_lsu_io_dmem_req_bits_0_valid),
    .io_lsu_req_bits_0_bits_uop_br_mask    (_lsu_io_dmem_req_bits_0_bits_uop_br_mask),
    .io_lsu_req_bits_0_bits_uop_ldq_idx    (_lsu_io_dmem_req_bits_0_bits_uop_ldq_idx),
    .io_lsu_req_bits_0_bits_uop_stq_idx    (_lsu_io_dmem_req_bits_0_bits_uop_stq_idx),
    .io_lsu_req_bits_0_bits_uop_mem_cmd    (_lsu_io_dmem_req_bits_0_bits_uop_mem_cmd),
    .io_lsu_req_bits_0_bits_uop_mem_size   (_lsu_io_dmem_req_bits_0_bits_uop_mem_size),
    .io_lsu_req_bits_0_bits_uop_mem_signed (_lsu_io_dmem_req_bits_0_bits_uop_mem_signed),
    .io_lsu_req_bits_0_bits_uop_is_amo     (_lsu_io_dmem_req_bits_0_bits_uop_is_amo),
    .io_lsu_req_bits_0_bits_uop_uses_ldq   (_lsu_io_dmem_req_bits_0_bits_uop_uses_ldq),
    .io_lsu_req_bits_0_bits_uop_uses_stq   (_lsu_io_dmem_req_bits_0_bits_uop_uses_stq),
    .io_lsu_req_bits_0_bits_addr           (_lsu_io_dmem_req_bits_0_bits_addr),
    .io_lsu_req_bits_0_bits_data           (_lsu_io_dmem_req_bits_0_bits_data),
    .io_lsu_req_bits_1_valid               (_lsu_io_dmem_req_bits_1_valid),
    .io_lsu_req_bits_1_bits_uop_br_mask    (_lsu_io_dmem_req_bits_1_bits_uop_br_mask),
    .io_lsu_req_bits_1_bits_uop_ldq_idx    (_lsu_io_dmem_req_bits_1_bits_uop_ldq_idx),
    .io_lsu_req_bits_1_bits_uop_stq_idx    (_lsu_io_dmem_req_bits_1_bits_uop_stq_idx),
    .io_lsu_req_bits_1_bits_uop_mem_cmd    (_lsu_io_dmem_req_bits_1_bits_uop_mem_cmd),
    .io_lsu_req_bits_1_bits_uop_mem_size   (_lsu_io_dmem_req_bits_1_bits_uop_mem_size),
    .io_lsu_req_bits_1_bits_uop_mem_signed (_lsu_io_dmem_req_bits_1_bits_uop_mem_signed),
    .io_lsu_req_bits_1_bits_uop_is_amo     (_lsu_io_dmem_req_bits_1_bits_uop_is_amo),
    .io_lsu_req_bits_1_bits_uop_uses_ldq   (_lsu_io_dmem_req_bits_1_bits_uop_uses_ldq),
    .io_lsu_req_bits_1_bits_uop_uses_stq   (_lsu_io_dmem_req_bits_1_bits_uop_uses_stq),
    .io_lsu_req_bits_1_bits_addr           (_lsu_io_dmem_req_bits_1_bits_addr),
    .io_lsu_req_bits_1_bits_data           (_lsu_io_dmem_req_bits_1_bits_data),
    .io_lsu_req_bits_1_bits_is_hella       (_lsu_io_dmem_req_bits_1_bits_is_hella),
    .io_lsu_s1_kill_0                      (_lsu_io_dmem_s1_kill_0),
    .io_lsu_s1_kill_1                      (_lsu_io_dmem_s1_kill_1),
    .io_lsu_brupdate_b1_resolve_mask       (_lsu_io_dmem_brupdate_b1_resolve_mask),
    .io_lsu_brupdate_b1_mispredict_mask    (_lsu_io_dmem_brupdate_b1_mispredict_mask),
    .io_lsu_exception                      (_lsu_io_dmem_exception),
    .io_lsu_release_ready                  (_lsu_io_dmem_release_ready),
    .io_lsu_force_order                    (_lsu_io_dmem_force_order),
    .auto_out_a_valid                      (_dcache_auto_out_a_valid),
    .auto_out_a_bits_opcode                (_dcache_auto_out_a_bits_opcode),
    .auto_out_a_bits_param                 (_dcache_auto_out_a_bits_param),
    .auto_out_a_bits_size                  (_dcache_auto_out_a_bits_size),
    .auto_out_a_bits_source                (_dcache_auto_out_a_bits_source),
    .auto_out_a_bits_address               (_dcache_auto_out_a_bits_address),
    .auto_out_a_bits_mask                  (_dcache_auto_out_a_bits_mask),
    .auto_out_a_bits_data                  (_dcache_auto_out_a_bits_data),
    .auto_out_b_ready                      (_dcache_auto_out_b_ready),
    .auto_out_c_valid                      (_dcache_auto_out_c_valid),
    .auto_out_c_bits_opcode                (_dcache_auto_out_c_bits_opcode),
    .auto_out_c_bits_param                 (_dcache_auto_out_c_bits_param),
    .auto_out_c_bits_size                  (_dcache_auto_out_c_bits_size),
    .auto_out_c_bits_source                (_dcache_auto_out_c_bits_source),
    .auto_out_c_bits_address               (_dcache_auto_out_c_bits_address),
    .auto_out_c_bits_data                  (_dcache_auto_out_c_bits_data),
    .auto_out_d_ready                      (_dcache_auto_out_d_ready),
    .auto_out_e_valid                      (_dcache_auto_out_e_valid),
    .auto_out_e_bits_sink                  (_dcache_auto_out_e_bits_sink),
    .io_lsu_req_ready                      (_dcache_io_lsu_req_ready),
    .io_lsu_resp_0_valid                   (_dcache_io_lsu_resp_0_valid),
    .io_lsu_resp_0_bits_uop_ldq_idx        (_dcache_io_lsu_resp_0_bits_uop_ldq_idx),
    .io_lsu_resp_0_bits_uop_stq_idx        (_dcache_io_lsu_resp_0_bits_uop_stq_idx),
    .io_lsu_resp_0_bits_uop_is_amo         (_dcache_io_lsu_resp_0_bits_uop_is_amo),
    .io_lsu_resp_0_bits_uop_uses_ldq       (_dcache_io_lsu_resp_0_bits_uop_uses_ldq),
    .io_lsu_resp_0_bits_uop_uses_stq       (_dcache_io_lsu_resp_0_bits_uop_uses_stq),
    .io_lsu_resp_0_bits_data               (_dcache_io_lsu_resp_0_bits_data),
    .io_lsu_resp_0_bits_is_hella           (_dcache_io_lsu_resp_0_bits_is_hella),
    .io_lsu_resp_1_valid                   (_dcache_io_lsu_resp_1_valid),
    .io_lsu_resp_1_bits_uop_ldq_idx        (_dcache_io_lsu_resp_1_bits_uop_ldq_idx),
    .io_lsu_resp_1_bits_uop_stq_idx        (_dcache_io_lsu_resp_1_bits_uop_stq_idx),
    .io_lsu_resp_1_bits_uop_is_amo         (_dcache_io_lsu_resp_1_bits_uop_is_amo),
    .io_lsu_resp_1_bits_uop_uses_ldq       (_dcache_io_lsu_resp_1_bits_uop_uses_ldq),
    .io_lsu_resp_1_bits_uop_uses_stq       (_dcache_io_lsu_resp_1_bits_uop_uses_stq),
    .io_lsu_resp_1_bits_data               (_dcache_io_lsu_resp_1_bits_data),
    .io_lsu_resp_1_bits_is_hella           (_dcache_io_lsu_resp_1_bits_is_hella),
    .io_lsu_nack_0_valid                   (_dcache_io_lsu_nack_0_valid),
    .io_lsu_nack_0_bits_uop_ldq_idx        (_dcache_io_lsu_nack_0_bits_uop_ldq_idx),
    .io_lsu_nack_0_bits_uop_stq_idx        (_dcache_io_lsu_nack_0_bits_uop_stq_idx),
    .io_lsu_nack_0_bits_uop_uses_ldq       (_dcache_io_lsu_nack_0_bits_uop_uses_ldq),
    .io_lsu_nack_0_bits_uop_uses_stq       (_dcache_io_lsu_nack_0_bits_uop_uses_stq),
    .io_lsu_nack_0_bits_is_hella           (_dcache_io_lsu_nack_0_bits_is_hella),
    .io_lsu_nack_1_valid                   (_dcache_io_lsu_nack_1_valid),
    .io_lsu_nack_1_bits_uop_ldq_idx        (_dcache_io_lsu_nack_1_bits_uop_ldq_idx),
    .io_lsu_nack_1_bits_uop_stq_idx        (_dcache_io_lsu_nack_1_bits_uop_stq_idx),
    .io_lsu_nack_1_bits_uop_uses_ldq       (_dcache_io_lsu_nack_1_bits_uop_uses_ldq),
    .io_lsu_nack_1_bits_uop_uses_stq       (_dcache_io_lsu_nack_1_bits_uop_uses_stq),
    .io_lsu_nack_1_bits_is_hella           (_dcache_io_lsu_nack_1_bits_is_hella),
    .io_lsu_release_valid                  (_dcache_io_lsu_release_valid),
    .io_lsu_release_bits_address           (_dcache_io_lsu_release_bits_address),
    .io_lsu_ordered                        (_dcache_io_lsu_ordered)
  );
  BoomFrontend frontend (
    .clock                                              (clock),
    .reset                                              (reset),
    .auto_icache_master_out_a_ready                     (_widget_1_auto_in_a_ready),
    .auto_icache_master_out_d_valid                     (_widget_1_auto_in_d_valid),
    .auto_icache_master_out_d_bits_opcode               (_widget_1_auto_in_d_bits_opcode),
    .auto_icache_master_out_d_bits_size                 (_widget_1_auto_in_d_bits_size),
    .auto_icache_master_out_d_bits_data                 (_widget_1_auto_in_d_bits_data),
    .io_cpu_fetchpacket_ready                           (_core_io_ifu_fetchpacket_ready),
    .io_cpu_get_pc_0_ftq_idx                            (_core_io_ifu_get_pc_0_ftq_idx),
    .io_cpu_get_pc_1_ftq_idx                            (_core_io_ifu_get_pc_1_ftq_idx),
    .io_cpu_sfence_valid                                (_core_io_ifu_sfence_valid),
    .io_cpu_sfence_bits_rs1                             (_core_io_ifu_sfence_bits_rs1),
    .io_cpu_sfence_bits_rs2                             (_core_io_ifu_sfence_bits_rs2),
    .io_cpu_sfence_bits_addr                            (_core_io_ifu_sfence_bits_addr),
    .io_cpu_brupdate_b2_uop_ftq_idx                     (_core_io_ifu_brupdate_b2_uop_ftq_idx),
    .io_cpu_brupdate_b2_uop_pc_lob                      (_core_io_ifu_brupdate_b2_uop_pc_lob),
    .io_cpu_brupdate_b2_mispredict                      (_core_io_ifu_brupdate_b2_mispredict),
    .io_cpu_brupdate_b2_taken                           (_core_io_ifu_brupdate_b2_taken),
    .io_cpu_redirect_flush                              (_core_io_ifu_redirect_flush),
    .io_cpu_redirect_val                                (_core_io_ifu_redirect_val),
    .io_cpu_redirect_pc                                 (_core_io_ifu_redirect_pc),
    .io_cpu_redirect_ftq_idx                            (_core_io_ifu_redirect_ftq_idx),
    .io_cpu_redirect_ghist_old_history                  (_core_io_ifu_redirect_ghist_old_history),
    .io_cpu_redirect_ghist_current_saw_branch_not_taken (_core_io_ifu_redirect_ghist_current_saw_branch_not_taken),
    .io_cpu_redirect_ghist_new_saw_branch_not_taken     (_core_io_ifu_redirect_ghist_new_saw_branch_not_taken),
    .io_cpu_redirect_ghist_new_saw_branch_taken         (_core_io_ifu_redirect_ghist_new_saw_branch_taken),
    .io_cpu_redirect_ghist_ras_idx                      (_core_io_ifu_redirect_ghist_ras_idx),
    .io_cpu_commit_valid                                (_core_io_ifu_commit_valid),
    .io_cpu_commit_bits                                 (_core_io_ifu_commit_bits),
    .io_cpu_flush_icache                                (_core_io_ifu_flush_icache),
    .io_ptw_req_ready                                   (_ptw_io_requestor_1_req_ready),
    .io_ptw_resp_valid                                  (_ptw_io_requestor_1_resp_valid),
    .io_ptw_resp_bits_ae_ptw                            (_ptw_io_requestor_1_resp_bits_ae_ptw),
    .io_ptw_resp_bits_ae_final                          (_ptw_io_requestor_1_resp_bits_ae_final),
    .io_ptw_resp_bits_pf                                (_ptw_io_requestor_1_resp_bits_pf),
    .io_ptw_resp_bits_gf                                (_ptw_io_requestor_1_resp_bits_gf),
    .io_ptw_resp_bits_hr                                (_ptw_io_requestor_1_resp_bits_hr),
    .io_ptw_resp_bits_hw                                (_ptw_io_requestor_1_resp_bits_hw),
    .io_ptw_resp_bits_hx                                (_ptw_io_requestor_1_resp_bits_hx),
    .io_ptw_resp_bits_pte_ppn                           (_ptw_io_requestor_1_resp_bits_pte_ppn),
    .io_ptw_resp_bits_pte_d                             (_ptw_io_requestor_1_resp_bits_pte_d),
    .io_ptw_resp_bits_pte_a                             (_ptw_io_requestor_1_resp_bits_pte_a),
    .io_ptw_resp_bits_pte_g                             (_ptw_io_requestor_1_resp_bits_pte_g),
    .io_ptw_resp_bits_pte_u                             (_ptw_io_requestor_1_resp_bits_pte_u),
    .io_ptw_resp_bits_pte_x                             (_ptw_io_requestor_1_resp_bits_pte_x),
    .io_ptw_resp_bits_pte_w                             (_ptw_io_requestor_1_resp_bits_pte_w),
    .io_ptw_resp_bits_pte_r                             (_ptw_io_requestor_1_resp_bits_pte_r),
    .io_ptw_resp_bits_pte_v                             (_ptw_io_requestor_1_resp_bits_pte_v),
    .io_ptw_resp_bits_level                             (_ptw_io_requestor_1_resp_bits_level),
    .io_ptw_resp_bits_homogeneous                       (_ptw_io_requestor_1_resp_bits_homogeneous),
    .io_ptw_resp_bits_gpa_is_pte                        (_ptw_io_requestor_1_resp_bits_gpa_is_pte),
    .io_ptw_ptbr_mode                                   (_ptw_io_requestor_1_ptbr_mode),
    .io_ptw_status_debug                                (_ptw_io_requestor_1_status_debug),
    .io_ptw_status_prv                                  (_ptw_io_requestor_1_status_prv),
    .io_ptw_pmp_0_cfg_l                                 (_ptw_io_requestor_1_pmp_0_cfg_l),
    .io_ptw_pmp_0_cfg_a                                 (_ptw_io_requestor_1_pmp_0_cfg_a),
    .io_ptw_pmp_0_cfg_x                                 (_ptw_io_requestor_1_pmp_0_cfg_x),
    .io_ptw_pmp_0_cfg_w                                 (_ptw_io_requestor_1_pmp_0_cfg_w),
    .io_ptw_pmp_0_cfg_r                                 (_ptw_io_requestor_1_pmp_0_cfg_r),
    .io_ptw_pmp_0_addr                                  (_ptw_io_requestor_1_pmp_0_addr),
    .io_ptw_pmp_0_mask                                  (_ptw_io_requestor_1_pmp_0_mask),
    .io_ptw_pmp_1_cfg_l                                 (_ptw_io_requestor_1_pmp_1_cfg_l),
    .io_ptw_pmp_1_cfg_a                                 (_ptw_io_requestor_1_pmp_1_cfg_a),
    .io_ptw_pmp_1_cfg_x                                 (_ptw_io_requestor_1_pmp_1_cfg_x),
    .io_ptw_pmp_1_cfg_w                                 (_ptw_io_requestor_1_pmp_1_cfg_w),
    .io_ptw_pmp_1_cfg_r                                 (_ptw_io_requestor_1_pmp_1_cfg_r),
    .io_ptw_pmp_1_addr                                  (_ptw_io_requestor_1_pmp_1_addr),
    .io_ptw_pmp_1_mask                                  (_ptw_io_requestor_1_pmp_1_mask),
    .io_ptw_pmp_2_cfg_l                                 (_ptw_io_requestor_1_pmp_2_cfg_l),
    .io_ptw_pmp_2_cfg_a                                 (_ptw_io_requestor_1_pmp_2_cfg_a),
    .io_ptw_pmp_2_cfg_x                                 (_ptw_io_requestor_1_pmp_2_cfg_x),
    .io_ptw_pmp_2_cfg_w                                 (_ptw_io_requestor_1_pmp_2_cfg_w),
    .io_ptw_pmp_2_cfg_r                                 (_ptw_io_requestor_1_pmp_2_cfg_r),
    .io_ptw_pmp_2_addr                                  (_ptw_io_requestor_1_pmp_2_addr),
    .io_ptw_pmp_2_mask                                  (_ptw_io_requestor_1_pmp_2_mask),
    .io_ptw_pmp_3_cfg_l                                 (_ptw_io_requestor_1_pmp_3_cfg_l),
    .io_ptw_pmp_3_cfg_a                                 (_ptw_io_requestor_1_pmp_3_cfg_a),
    .io_ptw_pmp_3_cfg_x                                 (_ptw_io_requestor_1_pmp_3_cfg_x),
    .io_ptw_pmp_3_cfg_w                                 (_ptw_io_requestor_1_pmp_3_cfg_w),
    .io_ptw_pmp_3_cfg_r                                 (_ptw_io_requestor_1_pmp_3_cfg_r),
    .io_ptw_pmp_3_addr                                  (_ptw_io_requestor_1_pmp_3_addr),
    .io_ptw_pmp_3_mask                                  (_ptw_io_requestor_1_pmp_3_mask),
    .io_ptw_pmp_4_cfg_l                                 (_ptw_io_requestor_1_pmp_4_cfg_l),
    .io_ptw_pmp_4_cfg_a                                 (_ptw_io_requestor_1_pmp_4_cfg_a),
    .io_ptw_pmp_4_cfg_x                                 (_ptw_io_requestor_1_pmp_4_cfg_x),
    .io_ptw_pmp_4_cfg_w                                 (_ptw_io_requestor_1_pmp_4_cfg_w),
    .io_ptw_pmp_4_cfg_r                                 (_ptw_io_requestor_1_pmp_4_cfg_r),
    .io_ptw_pmp_4_addr                                  (_ptw_io_requestor_1_pmp_4_addr),
    .io_ptw_pmp_4_mask                                  (_ptw_io_requestor_1_pmp_4_mask),
    .io_ptw_pmp_5_cfg_l                                 (_ptw_io_requestor_1_pmp_5_cfg_l),
    .io_ptw_pmp_5_cfg_a                                 (_ptw_io_requestor_1_pmp_5_cfg_a),
    .io_ptw_pmp_5_cfg_x                                 (_ptw_io_requestor_1_pmp_5_cfg_x),
    .io_ptw_pmp_5_cfg_w                                 (_ptw_io_requestor_1_pmp_5_cfg_w),
    .io_ptw_pmp_5_cfg_r                                 (_ptw_io_requestor_1_pmp_5_cfg_r),
    .io_ptw_pmp_5_addr                                  (_ptw_io_requestor_1_pmp_5_addr),
    .io_ptw_pmp_5_mask                                  (_ptw_io_requestor_1_pmp_5_mask),
    .io_ptw_pmp_6_cfg_l                                 (_ptw_io_requestor_1_pmp_6_cfg_l),
    .io_ptw_pmp_6_cfg_a                                 (_ptw_io_requestor_1_pmp_6_cfg_a),
    .io_ptw_pmp_6_cfg_x                                 (_ptw_io_requestor_1_pmp_6_cfg_x),
    .io_ptw_pmp_6_cfg_w                                 (_ptw_io_requestor_1_pmp_6_cfg_w),
    .io_ptw_pmp_6_cfg_r                                 (_ptw_io_requestor_1_pmp_6_cfg_r),
    .io_ptw_pmp_6_addr                                  (_ptw_io_requestor_1_pmp_6_addr),
    .io_ptw_pmp_6_mask                                  (_ptw_io_requestor_1_pmp_6_mask),
    .io_ptw_pmp_7_cfg_l                                 (_ptw_io_requestor_1_pmp_7_cfg_l),
    .io_ptw_pmp_7_cfg_a                                 (_ptw_io_requestor_1_pmp_7_cfg_a),
    .io_ptw_pmp_7_cfg_x                                 (_ptw_io_requestor_1_pmp_7_cfg_x),
    .io_ptw_pmp_7_cfg_w                                 (_ptw_io_requestor_1_pmp_7_cfg_w),
    .io_ptw_pmp_7_cfg_r                                 (_ptw_io_requestor_1_pmp_7_cfg_r),
    .io_ptw_pmp_7_addr                                  (_ptw_io_requestor_1_pmp_7_addr),
    .io_ptw_pmp_7_mask                                  (_ptw_io_requestor_1_pmp_7_mask),
    .auto_icache_master_out_a_valid                     (_frontend_auto_icache_master_out_a_valid),
    .auto_icache_master_out_a_bits_address              (_frontend_auto_icache_master_out_a_bits_address),
    .io_cpu_fetchpacket_valid                           (_frontend_io_cpu_fetchpacket_valid),
    .io_cpu_fetchpacket_bits_uops_0_valid               (_frontend_io_cpu_fetchpacket_bits_uops_0_valid),
    .io_cpu_fetchpacket_bits_uops_0_bits_inst           (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_inst),
    .io_cpu_fetchpacket_bits_uops_0_bits_is_rvc         (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_is_rvc),
    .io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_load   (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_load),
    .io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_sta    (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_sta),
    .io_cpu_fetchpacket_bits_uops_0_bits_is_sfb         (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_is_sfb),
    .io_cpu_fetchpacket_bits_uops_0_bits_ftq_idx        (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_ftq_idx),
    .io_cpu_fetchpacket_bits_uops_0_bits_edge_inst      (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_edge_inst),
    .io_cpu_fetchpacket_bits_uops_0_bits_pc_lob         (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_pc_lob),
    .io_cpu_fetchpacket_bits_uops_0_bits_taken          (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_taken),
    .io_cpu_fetchpacket_bits_uops_0_bits_xcpt_pf_if     (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_xcpt_pf_if),
    .io_cpu_fetchpacket_bits_uops_0_bits_xcpt_ae_if     (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_xcpt_ae_if),
    .io_cpu_fetchpacket_bits_uops_0_bits_bp_debug_if    (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_bp_debug_if),
    .io_cpu_fetchpacket_bits_uops_0_bits_bp_xcpt_if     (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_bp_xcpt_if),
    .io_cpu_fetchpacket_bits_uops_1_valid               (_frontend_io_cpu_fetchpacket_bits_uops_1_valid),
    .io_cpu_fetchpacket_bits_uops_1_bits_inst           (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_inst),
    .io_cpu_fetchpacket_bits_uops_1_bits_is_rvc         (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_is_rvc),
    .io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_load   (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_load),
    .io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_sta    (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_sta),
    .io_cpu_fetchpacket_bits_uops_1_bits_is_sfb         (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_is_sfb),
    .io_cpu_fetchpacket_bits_uops_1_bits_ftq_idx        (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_ftq_idx),
    .io_cpu_fetchpacket_bits_uops_1_bits_edge_inst      (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_edge_inst),
    .io_cpu_fetchpacket_bits_uops_1_bits_pc_lob         (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_pc_lob),
    .io_cpu_fetchpacket_bits_uops_1_bits_taken          (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_taken),
    .io_cpu_fetchpacket_bits_uops_1_bits_xcpt_pf_if     (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_xcpt_pf_if),
    .io_cpu_fetchpacket_bits_uops_1_bits_xcpt_ae_if     (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_xcpt_ae_if),
    .io_cpu_fetchpacket_bits_uops_1_bits_bp_debug_if    (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_bp_debug_if),
    .io_cpu_fetchpacket_bits_uops_1_bits_bp_xcpt_if     (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_bp_xcpt_if),
    .io_cpu_fetchpacket_bits_uops_2_valid               (_frontend_io_cpu_fetchpacket_bits_uops_2_valid),
    .io_cpu_fetchpacket_bits_uops_2_bits_inst           (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_inst),
    .io_cpu_fetchpacket_bits_uops_2_bits_is_rvc         (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_is_rvc),
    .io_cpu_fetchpacket_bits_uops_2_bits_ctrl_is_load   (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_ctrl_is_load),
    .io_cpu_fetchpacket_bits_uops_2_bits_ctrl_is_sta    (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_ctrl_is_sta),
    .io_cpu_fetchpacket_bits_uops_2_bits_is_sfb         (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_is_sfb),
    .io_cpu_fetchpacket_bits_uops_2_bits_ftq_idx        (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_ftq_idx),
    .io_cpu_fetchpacket_bits_uops_2_bits_edge_inst      (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_edge_inst),
    .io_cpu_fetchpacket_bits_uops_2_bits_pc_lob         (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_pc_lob),
    .io_cpu_fetchpacket_bits_uops_2_bits_taken          (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_taken),
    .io_cpu_fetchpacket_bits_uops_2_bits_xcpt_pf_if     (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_xcpt_pf_if),
    .io_cpu_fetchpacket_bits_uops_2_bits_xcpt_ae_if     (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_xcpt_ae_if),
    .io_cpu_fetchpacket_bits_uops_2_bits_bp_debug_if    (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_bp_debug_if),
    .io_cpu_fetchpacket_bits_uops_2_bits_bp_xcpt_if     (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_bp_xcpt_if),
    .io_cpu_fetchpacket_bits_uops_3_valid               (_frontend_io_cpu_fetchpacket_bits_uops_3_valid),
    .io_cpu_fetchpacket_bits_uops_3_bits_inst           (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_inst),
    .io_cpu_fetchpacket_bits_uops_3_bits_is_rvc         (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_is_rvc),
    .io_cpu_fetchpacket_bits_uops_3_bits_ctrl_is_load   (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_ctrl_is_load),
    .io_cpu_fetchpacket_bits_uops_3_bits_ctrl_is_sta    (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_ctrl_is_sta),
    .io_cpu_fetchpacket_bits_uops_3_bits_is_sfb         (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_is_sfb),
    .io_cpu_fetchpacket_bits_uops_3_bits_ftq_idx        (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_ftq_idx),
    .io_cpu_fetchpacket_bits_uops_3_bits_edge_inst      (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_edge_inst),
    .io_cpu_fetchpacket_bits_uops_3_bits_pc_lob         (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_pc_lob),
    .io_cpu_fetchpacket_bits_uops_3_bits_taken          (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_taken),
    .io_cpu_fetchpacket_bits_uops_3_bits_xcpt_pf_if     (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_xcpt_pf_if),
    .io_cpu_fetchpacket_bits_uops_3_bits_xcpt_ae_if     (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_xcpt_ae_if),
    .io_cpu_fetchpacket_bits_uops_3_bits_bp_debug_if    (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_bp_debug_if),
    .io_cpu_fetchpacket_bits_uops_3_bits_bp_xcpt_if     (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_bp_xcpt_if),
    .io_cpu_get_pc_0_entry_cfi_idx_valid                (_frontend_io_cpu_get_pc_0_entry_cfi_idx_valid),
    .io_cpu_get_pc_0_entry_cfi_idx_bits                 (_frontend_io_cpu_get_pc_0_entry_cfi_idx_bits),
    .io_cpu_get_pc_0_entry_ras_idx                      (_frontend_io_cpu_get_pc_0_entry_ras_idx),
    .io_cpu_get_pc_0_entry_start_bank                   (_frontend_io_cpu_get_pc_0_entry_start_bank),
    .io_cpu_get_pc_0_pc                                 (_frontend_io_cpu_get_pc_0_pc),
    .io_cpu_get_pc_0_com_pc                             (_frontend_io_cpu_get_pc_0_com_pc),
    .io_cpu_get_pc_0_next_val                           (_frontend_io_cpu_get_pc_0_next_val),
    .io_cpu_get_pc_0_next_pc                            (_frontend_io_cpu_get_pc_0_next_pc),
    .io_cpu_get_pc_1_entry_cfi_idx_bits                 (_frontend_io_cpu_get_pc_1_entry_cfi_idx_bits),
    .io_cpu_get_pc_1_entry_br_mask                      (_frontend_io_cpu_get_pc_1_entry_br_mask),
    .io_cpu_get_pc_1_entry_cfi_is_call                  (_frontend_io_cpu_get_pc_1_entry_cfi_is_call),
    .io_cpu_get_pc_1_entry_cfi_is_ret                   (_frontend_io_cpu_get_pc_1_entry_cfi_is_ret),
    .io_cpu_get_pc_1_entry_start_bank                   (_frontend_io_cpu_get_pc_1_entry_start_bank),
    .io_cpu_get_pc_1_ghist_old_history                  (_frontend_io_cpu_get_pc_1_ghist_old_history),
    .io_cpu_get_pc_1_ghist_current_saw_branch_not_taken (_frontend_io_cpu_get_pc_1_ghist_current_saw_branch_not_taken),
    .io_cpu_get_pc_1_ghist_new_saw_branch_not_taken     (_frontend_io_cpu_get_pc_1_ghist_new_saw_branch_not_taken),
    .io_cpu_get_pc_1_ghist_new_saw_branch_taken         (_frontend_io_cpu_get_pc_1_ghist_new_saw_branch_taken),
    .io_cpu_get_pc_1_ghist_ras_idx                      (_frontend_io_cpu_get_pc_1_ghist_ras_idx),
    .io_cpu_get_pc_1_pc                                 (_frontend_io_cpu_get_pc_1_pc),
    .io_ptw_req_valid                                   (_frontend_io_ptw_req_valid),
    .io_ptw_req_bits_bits_addr                          (_frontend_io_ptw_req_bits_bits_addr),
    .io_ptw_req_bits_bits_need_gpa                      (_frontend_io_ptw_req_bits_bits_need_gpa),
    .io_ptw_req_bits_bits_vstage1                       (_frontend_io_ptw_req_bits_bits_vstage1),
    .io_ptw_req_bits_bits_stage2                        (_frontend_io_ptw_req_bits_bits_stage2)
  );
  TLWidthWidget_9 widget_1 (
    .auto_in_a_valid         (_frontend_auto_icache_master_out_a_valid),
    .auto_in_a_bits_address  (_frontend_auto_icache_master_out_a_bits_address),
    .auto_out_a_ready        (_tlMasterXbar_auto_in_1_a_ready),
    .auto_out_d_valid        (_tlMasterXbar_auto_in_1_d_valid),
    .auto_out_d_bits_opcode  (_tlMasterXbar_auto_in_1_d_bits_opcode),
    .auto_out_d_bits_size    (_tlMasterXbar_auto_in_1_d_bits_size),
    .auto_out_d_bits_data    (_tlMasterXbar_auto_in_1_d_bits_data),
    .auto_in_a_ready         (_widget_1_auto_in_a_ready),
    .auto_in_d_valid         (_widget_1_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_widget_1_auto_in_d_bits_opcode),
    .auto_in_d_bits_size     (_widget_1_auto_in_d_bits_size),
    .auto_in_d_bits_data     (_widget_1_auto_in_d_bits_data),
    .auto_out_a_valid        (_widget_1_auto_out_a_valid),
    .auto_out_a_bits_address (_widget_1_auto_out_a_bits_address)
  );
  TLBuffer_13 buffer (
    .auto_in_a_valid         (_tlMasterXbar_auto_out_a_valid),
    .auto_in_a_bits_opcode   (_tlMasterXbar_auto_out_a_bits_opcode),
    .auto_in_a_bits_param    (_tlMasterXbar_auto_out_a_bits_param),
    .auto_in_a_bits_size     (_tlMasterXbar_auto_out_a_bits_size),
    .auto_in_a_bits_source   (_tlMasterXbar_auto_out_a_bits_source),
    .auto_in_a_bits_address  (_tlMasterXbar_auto_out_a_bits_address),
    .auto_in_a_bits_mask     (_tlMasterXbar_auto_out_a_bits_mask),
    .auto_in_a_bits_data     (_tlMasterXbar_auto_out_a_bits_data),
    .auto_in_b_ready         (_tlMasterXbar_auto_out_b_ready),
    .auto_in_c_valid         (_tlMasterXbar_auto_out_c_valid),
    .auto_in_c_bits_opcode   (_tlMasterXbar_auto_out_c_bits_opcode),
    .auto_in_c_bits_param    (_tlMasterXbar_auto_out_c_bits_param),
    .auto_in_c_bits_size     (_tlMasterXbar_auto_out_c_bits_size),
    .auto_in_c_bits_source   (_tlMasterXbar_auto_out_c_bits_source),
    .auto_in_c_bits_address  (_tlMasterXbar_auto_out_c_bits_address),
    .auto_in_c_bits_data     (_tlMasterXbar_auto_out_c_bits_data),
    .auto_in_d_ready         (_tlMasterXbar_auto_out_d_ready),
    .auto_in_e_valid         (_tlMasterXbar_auto_out_e_valid),
    .auto_in_e_bits_sink     (_tlMasterXbar_auto_out_e_bits_sink),
    .auto_out_a_ready        (auto_buffer_out_a_ready),
    .auto_out_b_valid        (auto_buffer_out_b_valid),
    .auto_out_b_bits_opcode  (auto_buffer_out_b_bits_opcode),
    .auto_out_b_bits_param   (auto_buffer_out_b_bits_param),
    .auto_out_b_bits_size    (auto_buffer_out_b_bits_size),
    .auto_out_b_bits_source  (auto_buffer_out_b_bits_source),
    .auto_out_b_bits_address (auto_buffer_out_b_bits_address),
    .auto_out_b_bits_mask    (auto_buffer_out_b_bits_mask),
    .auto_out_b_bits_corrupt (auto_buffer_out_b_bits_corrupt),
    .auto_out_c_ready        (auto_buffer_out_c_ready),
    .auto_out_d_valid        (auto_buffer_out_d_valid),
    .auto_out_d_bits_opcode  (auto_buffer_out_d_bits_opcode),
    .auto_out_d_bits_param   (auto_buffer_out_d_bits_param),
    .auto_out_d_bits_size    (auto_buffer_out_d_bits_size),
    .auto_out_d_bits_source  (auto_buffer_out_d_bits_source),
    .auto_out_d_bits_sink    (auto_buffer_out_d_bits_sink),
    .auto_out_d_bits_denied  (auto_buffer_out_d_bits_denied),
    .auto_out_d_bits_data    (auto_buffer_out_d_bits_data),
    .auto_out_d_bits_corrupt (auto_buffer_out_d_bits_corrupt),
    .auto_out_e_ready        (auto_buffer_out_e_ready),
    .auto_in_a_ready         (_buffer_auto_in_a_ready),
    .auto_in_b_valid         (_buffer_auto_in_b_valid),
    .auto_in_b_bits_opcode   (_buffer_auto_in_b_bits_opcode),
    .auto_in_b_bits_param    (_buffer_auto_in_b_bits_param),
    .auto_in_b_bits_size     (_buffer_auto_in_b_bits_size),
    .auto_in_b_bits_source   (_buffer_auto_in_b_bits_source),
    .auto_in_b_bits_address  (_buffer_auto_in_b_bits_address),
    .auto_in_b_bits_mask     (_buffer_auto_in_b_bits_mask),
    .auto_in_b_bits_corrupt  (_buffer_auto_in_b_bits_corrupt),
    .auto_in_c_ready         (_buffer_auto_in_c_ready),
    .auto_in_d_valid         (_buffer_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_buffer_auto_in_d_bits_opcode),
    .auto_in_d_bits_param    (_buffer_auto_in_d_bits_param),
    .auto_in_d_bits_size     (_buffer_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_buffer_auto_in_d_bits_source),
    .auto_in_d_bits_sink     (_buffer_auto_in_d_bits_sink),
    .auto_in_d_bits_denied   (_buffer_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_buffer_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_buffer_auto_in_d_bits_corrupt),
    .auto_in_e_ready         (_buffer_auto_in_e_ready),
    .auto_out_a_valid        (auto_buffer_out_a_valid),
    .auto_out_a_bits_opcode  (auto_buffer_out_a_bits_opcode),
    .auto_out_a_bits_param   (auto_buffer_out_a_bits_param),
    .auto_out_a_bits_size    (auto_buffer_out_a_bits_size),
    .auto_out_a_bits_source  (auto_buffer_out_a_bits_source),
    .auto_out_a_bits_address (auto_buffer_out_a_bits_address),
    .auto_out_a_bits_mask    (auto_buffer_out_a_bits_mask),
    .auto_out_a_bits_data    (auto_buffer_out_a_bits_data),
    .auto_out_b_ready        (auto_buffer_out_b_ready),
    .auto_out_c_valid        (auto_buffer_out_c_valid),
    .auto_out_c_bits_opcode  (auto_buffer_out_c_bits_opcode),
    .auto_out_c_bits_param   (auto_buffer_out_c_bits_param),
    .auto_out_c_bits_size    (auto_buffer_out_c_bits_size),
    .auto_out_c_bits_source  (auto_buffer_out_c_bits_source),
    .auto_out_c_bits_address (auto_buffer_out_c_bits_address),
    .auto_out_c_bits_data    (auto_buffer_out_c_bits_data),
    .auto_out_d_ready        (auto_buffer_out_d_ready),
    .auto_out_e_valid        (auto_buffer_out_e_valid),
    .auto_out_e_bits_sink    (auto_buffer_out_e_bits_sink)
  );
  BoomCore core (
    .clock                                              (clock),
    .reset                                              (reset),
    .io_hartid                                          (_broadcast_auto_int_out_0),
    .io_interrupts_debug                                (_intXbar_auto_int_out_0),
    .io_interrupts_mtip                                 (_intXbar_auto_int_out_2),
    .io_interrupts_msip                                 (_intXbar_auto_int_out_1),
    .io_interrupts_meip                                 (_intXbar_auto_int_out_3),
    .io_interrupts_seip                                 (_intXbar_auto_int_out_4),
    .io_ifu_fetchpacket_valid                           (_frontend_io_cpu_fetchpacket_valid),
    .io_ifu_fetchpacket_bits_uops_0_valid               (_frontend_io_cpu_fetchpacket_bits_uops_0_valid),
    .io_ifu_fetchpacket_bits_uops_0_bits_inst           (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_inst),
    .io_ifu_fetchpacket_bits_uops_0_bits_is_rvc         (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_is_rvc),
    .io_ifu_fetchpacket_bits_uops_0_bits_ctrl_is_load   (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_load),
    .io_ifu_fetchpacket_bits_uops_0_bits_ctrl_is_sta    (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_sta),
    .io_ifu_fetchpacket_bits_uops_0_bits_is_sfb         (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_is_sfb),
    .io_ifu_fetchpacket_bits_uops_0_bits_ftq_idx        (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_ftq_idx),
    .io_ifu_fetchpacket_bits_uops_0_bits_edge_inst      (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_edge_inst),
    .io_ifu_fetchpacket_bits_uops_0_bits_pc_lob         (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_pc_lob),
    .io_ifu_fetchpacket_bits_uops_0_bits_taken          (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_taken),
    .io_ifu_fetchpacket_bits_uops_0_bits_xcpt_pf_if     (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_xcpt_pf_if),
    .io_ifu_fetchpacket_bits_uops_0_bits_xcpt_ae_if     (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_xcpt_ae_if),
    .io_ifu_fetchpacket_bits_uops_0_bits_bp_debug_if    (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_bp_debug_if),
    .io_ifu_fetchpacket_bits_uops_0_bits_bp_xcpt_if     (_frontend_io_cpu_fetchpacket_bits_uops_0_bits_bp_xcpt_if),
    .io_ifu_fetchpacket_bits_uops_1_valid               (_frontend_io_cpu_fetchpacket_bits_uops_1_valid),
    .io_ifu_fetchpacket_bits_uops_1_bits_inst           (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_inst),
    .io_ifu_fetchpacket_bits_uops_1_bits_is_rvc         (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_is_rvc),
    .io_ifu_fetchpacket_bits_uops_1_bits_ctrl_is_load   (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_load),
    .io_ifu_fetchpacket_bits_uops_1_bits_ctrl_is_sta    (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_sta),
    .io_ifu_fetchpacket_bits_uops_1_bits_is_sfb         (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_is_sfb),
    .io_ifu_fetchpacket_bits_uops_1_bits_ftq_idx        (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_ftq_idx),
    .io_ifu_fetchpacket_bits_uops_1_bits_edge_inst      (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_edge_inst),
    .io_ifu_fetchpacket_bits_uops_1_bits_pc_lob         (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_pc_lob),
    .io_ifu_fetchpacket_bits_uops_1_bits_taken          (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_taken),
    .io_ifu_fetchpacket_bits_uops_1_bits_xcpt_pf_if     (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_xcpt_pf_if),
    .io_ifu_fetchpacket_bits_uops_1_bits_xcpt_ae_if     (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_xcpt_ae_if),
    .io_ifu_fetchpacket_bits_uops_1_bits_bp_debug_if    (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_bp_debug_if),
    .io_ifu_fetchpacket_bits_uops_1_bits_bp_xcpt_if     (_frontend_io_cpu_fetchpacket_bits_uops_1_bits_bp_xcpt_if),
    .io_ifu_fetchpacket_bits_uops_2_valid               (_frontend_io_cpu_fetchpacket_bits_uops_2_valid),
    .io_ifu_fetchpacket_bits_uops_2_bits_inst           (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_inst),
    .io_ifu_fetchpacket_bits_uops_2_bits_is_rvc         (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_is_rvc),
    .io_ifu_fetchpacket_bits_uops_2_bits_ctrl_is_load   (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_ctrl_is_load),
    .io_ifu_fetchpacket_bits_uops_2_bits_ctrl_is_sta    (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_ctrl_is_sta),
    .io_ifu_fetchpacket_bits_uops_2_bits_is_sfb         (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_is_sfb),
    .io_ifu_fetchpacket_bits_uops_2_bits_ftq_idx        (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_ftq_idx),
    .io_ifu_fetchpacket_bits_uops_2_bits_edge_inst      (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_edge_inst),
    .io_ifu_fetchpacket_bits_uops_2_bits_pc_lob         (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_pc_lob),
    .io_ifu_fetchpacket_bits_uops_2_bits_taken          (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_taken),
    .io_ifu_fetchpacket_bits_uops_2_bits_xcpt_pf_if     (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_xcpt_pf_if),
    .io_ifu_fetchpacket_bits_uops_2_bits_xcpt_ae_if     (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_xcpt_ae_if),
    .io_ifu_fetchpacket_bits_uops_2_bits_bp_debug_if    (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_bp_debug_if),
    .io_ifu_fetchpacket_bits_uops_2_bits_bp_xcpt_if     (_frontend_io_cpu_fetchpacket_bits_uops_2_bits_bp_xcpt_if),
    .io_ifu_fetchpacket_bits_uops_3_valid               (_frontend_io_cpu_fetchpacket_bits_uops_3_valid),
    .io_ifu_fetchpacket_bits_uops_3_bits_inst           (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_inst),
    .io_ifu_fetchpacket_bits_uops_3_bits_is_rvc         (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_is_rvc),
    .io_ifu_fetchpacket_bits_uops_3_bits_ctrl_is_load   (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_ctrl_is_load),
    .io_ifu_fetchpacket_bits_uops_3_bits_ctrl_is_sta    (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_ctrl_is_sta),
    .io_ifu_fetchpacket_bits_uops_3_bits_is_sfb         (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_is_sfb),
    .io_ifu_fetchpacket_bits_uops_3_bits_ftq_idx        (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_ftq_idx),
    .io_ifu_fetchpacket_bits_uops_3_bits_edge_inst      (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_edge_inst),
    .io_ifu_fetchpacket_bits_uops_3_bits_pc_lob         (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_pc_lob),
    .io_ifu_fetchpacket_bits_uops_3_bits_taken          (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_taken),
    .io_ifu_fetchpacket_bits_uops_3_bits_xcpt_pf_if     (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_xcpt_pf_if),
    .io_ifu_fetchpacket_bits_uops_3_bits_xcpt_ae_if     (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_xcpt_ae_if),
    .io_ifu_fetchpacket_bits_uops_3_bits_bp_debug_if    (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_bp_debug_if),
    .io_ifu_fetchpacket_bits_uops_3_bits_bp_xcpt_if     (_frontend_io_cpu_fetchpacket_bits_uops_3_bits_bp_xcpt_if),
    .io_ifu_get_pc_0_entry_cfi_idx_valid                (_frontend_io_cpu_get_pc_0_entry_cfi_idx_valid),
    .io_ifu_get_pc_0_entry_cfi_idx_bits                 (_frontend_io_cpu_get_pc_0_entry_cfi_idx_bits),
    .io_ifu_get_pc_0_entry_ras_idx                      (_frontend_io_cpu_get_pc_0_entry_ras_idx),
    .io_ifu_get_pc_0_entry_start_bank                   (_frontend_io_cpu_get_pc_0_entry_start_bank),
    .io_ifu_get_pc_0_pc                                 (_frontend_io_cpu_get_pc_0_pc),
    .io_ifu_get_pc_0_com_pc                             (_frontend_io_cpu_get_pc_0_com_pc),
    .io_ifu_get_pc_0_next_val                           (_frontend_io_cpu_get_pc_0_next_val),
    .io_ifu_get_pc_0_next_pc                            (_frontend_io_cpu_get_pc_0_next_pc),
    .io_ifu_get_pc_1_entry_cfi_idx_bits                 (_frontend_io_cpu_get_pc_1_entry_cfi_idx_bits),
    .io_ifu_get_pc_1_entry_br_mask                      (_frontend_io_cpu_get_pc_1_entry_br_mask),
    .io_ifu_get_pc_1_entry_cfi_is_call                  (_frontend_io_cpu_get_pc_1_entry_cfi_is_call),
    .io_ifu_get_pc_1_entry_cfi_is_ret                   (_frontend_io_cpu_get_pc_1_entry_cfi_is_ret),
    .io_ifu_get_pc_1_entry_start_bank                   (_frontend_io_cpu_get_pc_1_entry_start_bank),
    .io_ifu_get_pc_1_ghist_old_history                  (_frontend_io_cpu_get_pc_1_ghist_old_history),
    .io_ifu_get_pc_1_ghist_current_saw_branch_not_taken (_frontend_io_cpu_get_pc_1_ghist_current_saw_branch_not_taken),
    .io_ifu_get_pc_1_ghist_new_saw_branch_not_taken     (_frontend_io_cpu_get_pc_1_ghist_new_saw_branch_not_taken),
    .io_ifu_get_pc_1_ghist_new_saw_branch_taken         (_frontend_io_cpu_get_pc_1_ghist_new_saw_branch_taken),
    .io_ifu_get_pc_1_ghist_ras_idx                      (_frontend_io_cpu_get_pc_1_ghist_ras_idx),
    .io_ifu_get_pc_1_pc                                 (_frontend_io_cpu_get_pc_1_pc),
    .io_lsu_exe_0_iresp_valid                           (_lsu_io_core_exe_0_iresp_valid),
    .io_lsu_exe_0_iresp_bits_uop_rob_idx                (_lsu_io_core_exe_0_iresp_bits_uop_rob_idx),
    .io_lsu_exe_0_iresp_bits_uop_pdst                   (_lsu_io_core_exe_0_iresp_bits_uop_pdst),
    .io_lsu_exe_0_iresp_bits_uop_is_amo                 (_lsu_io_core_exe_0_iresp_bits_uop_is_amo),
    .io_lsu_exe_0_iresp_bits_uop_uses_stq               (_lsu_io_core_exe_0_iresp_bits_uop_uses_stq),
    .io_lsu_exe_0_iresp_bits_uop_dst_rtype              (_lsu_io_core_exe_0_iresp_bits_uop_dst_rtype),
    .io_lsu_exe_0_iresp_bits_data                       (_lsu_io_core_exe_0_iresp_bits_data),
    .io_lsu_exe_0_fresp_valid                           (_lsu_io_core_exe_0_fresp_valid),
    .io_lsu_exe_0_fresp_bits_uop_uopc                   (_lsu_io_core_exe_0_fresp_bits_uop_uopc),
    .io_lsu_exe_0_fresp_bits_uop_br_mask                (_lsu_io_core_exe_0_fresp_bits_uop_br_mask),
    .io_lsu_exe_0_fresp_bits_uop_rob_idx                (_lsu_io_core_exe_0_fresp_bits_uop_rob_idx),
    .io_lsu_exe_0_fresp_bits_uop_stq_idx                (_lsu_io_core_exe_0_fresp_bits_uop_stq_idx),
    .io_lsu_exe_0_fresp_bits_uop_pdst                   (_lsu_io_core_exe_0_fresp_bits_uop_pdst),
    .io_lsu_exe_0_fresp_bits_uop_mem_size               (_lsu_io_core_exe_0_fresp_bits_uop_mem_size),
    .io_lsu_exe_0_fresp_bits_uop_is_amo                 (_lsu_io_core_exe_0_fresp_bits_uop_is_amo),
    .io_lsu_exe_0_fresp_bits_uop_uses_stq               (_lsu_io_core_exe_0_fresp_bits_uop_uses_stq),
    .io_lsu_exe_0_fresp_bits_uop_dst_rtype              (_lsu_io_core_exe_0_fresp_bits_uop_dst_rtype),
    .io_lsu_exe_0_fresp_bits_uop_fp_val                 (_lsu_io_core_exe_0_fresp_bits_uop_fp_val),
    .io_lsu_exe_0_fresp_bits_data                       (_lsu_io_core_exe_0_fresp_bits_data),
    .io_lsu_exe_1_iresp_valid                           (_lsu_io_core_exe_1_iresp_valid),
    .io_lsu_exe_1_iresp_bits_uop_rob_idx                (_lsu_io_core_exe_1_iresp_bits_uop_rob_idx),
    .io_lsu_exe_1_iresp_bits_uop_pdst                   (_lsu_io_core_exe_1_iresp_bits_uop_pdst),
    .io_lsu_exe_1_iresp_bits_uop_is_amo                 (_lsu_io_core_exe_1_iresp_bits_uop_is_amo),
    .io_lsu_exe_1_iresp_bits_uop_uses_stq               (_lsu_io_core_exe_1_iresp_bits_uop_uses_stq),
    .io_lsu_exe_1_iresp_bits_uop_dst_rtype              (_lsu_io_core_exe_1_iresp_bits_uop_dst_rtype),
    .io_lsu_exe_1_iresp_bits_data                       (_lsu_io_core_exe_1_iresp_bits_data),
    .io_lsu_exe_1_fresp_valid                           (_lsu_io_core_exe_1_fresp_valid),
    .io_lsu_exe_1_fresp_bits_uop_uopc                   (_lsu_io_core_exe_1_fresp_bits_uop_uopc),
    .io_lsu_exe_1_fresp_bits_uop_br_mask                (_lsu_io_core_exe_1_fresp_bits_uop_br_mask),
    .io_lsu_exe_1_fresp_bits_uop_rob_idx                (_lsu_io_core_exe_1_fresp_bits_uop_rob_idx),
    .io_lsu_exe_1_fresp_bits_uop_stq_idx                (_lsu_io_core_exe_1_fresp_bits_uop_stq_idx),
    .io_lsu_exe_1_fresp_bits_uop_pdst                   (_lsu_io_core_exe_1_fresp_bits_uop_pdst),
    .io_lsu_exe_1_fresp_bits_uop_mem_size               (_lsu_io_core_exe_1_fresp_bits_uop_mem_size),
    .io_lsu_exe_1_fresp_bits_uop_is_amo                 (_lsu_io_core_exe_1_fresp_bits_uop_is_amo),
    .io_lsu_exe_1_fresp_bits_uop_uses_stq               (_lsu_io_core_exe_1_fresp_bits_uop_uses_stq),
    .io_lsu_exe_1_fresp_bits_uop_dst_rtype              (_lsu_io_core_exe_1_fresp_bits_uop_dst_rtype),
    .io_lsu_exe_1_fresp_bits_uop_fp_val                 (_lsu_io_core_exe_1_fresp_bits_uop_fp_val),
    .io_lsu_exe_1_fresp_bits_data                       (_lsu_io_core_exe_1_fresp_bits_data),
    .io_lsu_dis_ldq_idx_0                               (_lsu_io_core_dis_ldq_idx_0),
    .io_lsu_dis_ldq_idx_1                               (_lsu_io_core_dis_ldq_idx_1),
    .io_lsu_dis_ldq_idx_2                               (_lsu_io_core_dis_ldq_idx_2),
    .io_lsu_dis_ldq_idx_3                               (_lsu_io_core_dis_ldq_idx_3),
    .io_lsu_dis_stq_idx_0                               (_lsu_io_core_dis_stq_idx_0),
    .io_lsu_dis_stq_idx_1                               (_lsu_io_core_dis_stq_idx_1),
    .io_lsu_dis_stq_idx_2                               (_lsu_io_core_dis_stq_idx_2),
    .io_lsu_dis_stq_idx_3                               (_lsu_io_core_dis_stq_idx_3),
    .io_lsu_ldq_full_0                                  (_lsu_io_core_ldq_full_0),
    .io_lsu_ldq_full_1                                  (_lsu_io_core_ldq_full_1),
    .io_lsu_ldq_full_2                                  (_lsu_io_core_ldq_full_2),
    .io_lsu_ldq_full_3                                  (_lsu_io_core_ldq_full_3),
    .io_lsu_stq_full_0                                  (_lsu_io_core_stq_full_0),
    .io_lsu_stq_full_1                                  (_lsu_io_core_stq_full_1),
    .io_lsu_stq_full_2                                  (_lsu_io_core_stq_full_2),
    .io_lsu_stq_full_3                                  (_lsu_io_core_stq_full_3),
    .io_lsu_fp_stdata_ready                             (_lsu_io_core_fp_stdata_ready),
    .io_lsu_clr_bsy_0_valid                             (_lsu_io_core_clr_bsy_0_valid),
    .io_lsu_clr_bsy_0_bits                              (_lsu_io_core_clr_bsy_0_bits),
    .io_lsu_clr_bsy_1_valid                             (_lsu_io_core_clr_bsy_1_valid),
    .io_lsu_clr_bsy_1_bits                              (_lsu_io_core_clr_bsy_1_bits),
    .io_lsu_clr_bsy_2_valid                             (_lsu_io_core_clr_bsy_2_valid),
    .io_lsu_clr_bsy_2_bits                              (_lsu_io_core_clr_bsy_2_bits),
    .io_lsu_spec_ld_wakeup_0_valid                      (_lsu_io_core_spec_ld_wakeup_0_valid),
    .io_lsu_spec_ld_wakeup_0_bits                       (_lsu_io_core_spec_ld_wakeup_0_bits),
    .io_lsu_spec_ld_wakeup_1_valid                      (_lsu_io_core_spec_ld_wakeup_1_valid),
    .io_lsu_spec_ld_wakeup_1_bits                       (_lsu_io_core_spec_ld_wakeup_1_bits),
    .io_lsu_ld_miss                                     (_lsu_io_core_ld_miss),
    .io_lsu_fencei_rdy                                  (_lsu_io_core_fencei_rdy),
    .io_lsu_lxcpt_valid                                 (_lsu_io_core_lxcpt_valid),
    .io_lsu_lxcpt_bits_uop_br_mask                      (_lsu_io_core_lxcpt_bits_uop_br_mask),
    .io_lsu_lxcpt_bits_uop_rob_idx                      (_lsu_io_core_lxcpt_bits_uop_rob_idx),
    .io_lsu_lxcpt_bits_cause                            (_lsu_io_core_lxcpt_bits_cause),
    .io_lsu_lxcpt_bits_badvaddr                         (_lsu_io_core_lxcpt_bits_badvaddr),
    .io_ifu_fetchpacket_ready                           (_core_io_ifu_fetchpacket_ready),
    .io_ifu_get_pc_0_ftq_idx                            (_core_io_ifu_get_pc_0_ftq_idx),
    .io_ifu_get_pc_1_ftq_idx                            (_core_io_ifu_get_pc_1_ftq_idx),
    .io_ifu_sfence_valid                                (_core_io_ifu_sfence_valid),
    .io_ifu_sfence_bits_rs1                             (_core_io_ifu_sfence_bits_rs1),
    .io_ifu_sfence_bits_rs2                             (_core_io_ifu_sfence_bits_rs2),
    .io_ifu_sfence_bits_addr                            (_core_io_ifu_sfence_bits_addr),
    .io_ifu_brupdate_b2_uop_ftq_idx                     (_core_io_ifu_brupdate_b2_uop_ftq_idx),
    .io_ifu_brupdate_b2_uop_pc_lob                      (_core_io_ifu_brupdate_b2_uop_pc_lob),
    .io_ifu_brupdate_b2_mispredict                      (_core_io_ifu_brupdate_b2_mispredict),
    .io_ifu_brupdate_b2_taken                           (_core_io_ifu_brupdate_b2_taken),
    .io_ifu_redirect_flush                              (_core_io_ifu_redirect_flush),
    .io_ifu_redirect_val                                (_core_io_ifu_redirect_val),
    .io_ifu_redirect_pc                                 (_core_io_ifu_redirect_pc),
    .io_ifu_redirect_ftq_idx                            (_core_io_ifu_redirect_ftq_idx),
    .io_ifu_redirect_ghist_old_history                  (_core_io_ifu_redirect_ghist_old_history),
    .io_ifu_redirect_ghist_current_saw_branch_not_taken (_core_io_ifu_redirect_ghist_current_saw_branch_not_taken),
    .io_ifu_redirect_ghist_new_saw_branch_not_taken     (_core_io_ifu_redirect_ghist_new_saw_branch_not_taken),
    .io_ifu_redirect_ghist_new_saw_branch_taken         (_core_io_ifu_redirect_ghist_new_saw_branch_taken),
    .io_ifu_redirect_ghist_ras_idx                      (_core_io_ifu_redirect_ghist_ras_idx),
    .io_ifu_commit_valid                                (_core_io_ifu_commit_valid),
    .io_ifu_commit_bits                                 (_core_io_ifu_commit_bits),
    .io_ifu_flush_icache                                (_core_io_ifu_flush_icache),
    .io_ptw_ptbr_mode                                   (_core_io_ptw_ptbr_mode),
    .io_ptw_ptbr_ppn                                    (_core_io_ptw_ptbr_ppn),
    .io_ptw_sfence_valid                                (_core_io_ptw_sfence_valid),
    .io_ptw_sfence_bits_rs1                             (_core_io_ptw_sfence_bits_rs1),
    .io_ptw_sfence_bits_rs2                             (_core_io_ptw_sfence_bits_rs2),
    .io_ptw_sfence_bits_addr                            (_core_io_ptw_sfence_bits_addr),
    .io_ptw_status_debug                                (_core_io_ptw_status_debug),
    .io_ptw_status_dprv                                 (_core_io_ptw_status_dprv),
    .io_ptw_status_prv                                  (_core_io_ptw_status_prv),
    .io_ptw_status_mxr                                  (_core_io_ptw_status_mxr),
    .io_ptw_status_sum                                  (_core_io_ptw_status_sum),
    .io_ptw_pmp_0_cfg_l                                 (_core_io_ptw_pmp_0_cfg_l),
    .io_ptw_pmp_0_cfg_a                                 (_core_io_ptw_pmp_0_cfg_a),
    .io_ptw_pmp_0_cfg_x                                 (_core_io_ptw_pmp_0_cfg_x),
    .io_ptw_pmp_0_cfg_w                                 (_core_io_ptw_pmp_0_cfg_w),
    .io_ptw_pmp_0_cfg_r                                 (_core_io_ptw_pmp_0_cfg_r),
    .io_ptw_pmp_0_addr                                  (_core_io_ptw_pmp_0_addr),
    .io_ptw_pmp_0_mask                                  (_core_io_ptw_pmp_0_mask),
    .io_ptw_pmp_1_cfg_l                                 (_core_io_ptw_pmp_1_cfg_l),
    .io_ptw_pmp_1_cfg_a                                 (_core_io_ptw_pmp_1_cfg_a),
    .io_ptw_pmp_1_cfg_x                                 (_core_io_ptw_pmp_1_cfg_x),
    .io_ptw_pmp_1_cfg_w                                 (_core_io_ptw_pmp_1_cfg_w),
    .io_ptw_pmp_1_cfg_r                                 (_core_io_ptw_pmp_1_cfg_r),
    .io_ptw_pmp_1_addr                                  (_core_io_ptw_pmp_1_addr),
    .io_ptw_pmp_1_mask                                  (_core_io_ptw_pmp_1_mask),
    .io_ptw_pmp_2_cfg_l                                 (_core_io_ptw_pmp_2_cfg_l),
    .io_ptw_pmp_2_cfg_a                                 (_core_io_ptw_pmp_2_cfg_a),
    .io_ptw_pmp_2_cfg_x                                 (_core_io_ptw_pmp_2_cfg_x),
    .io_ptw_pmp_2_cfg_w                                 (_core_io_ptw_pmp_2_cfg_w),
    .io_ptw_pmp_2_cfg_r                                 (_core_io_ptw_pmp_2_cfg_r),
    .io_ptw_pmp_2_addr                                  (_core_io_ptw_pmp_2_addr),
    .io_ptw_pmp_2_mask                                  (_core_io_ptw_pmp_2_mask),
    .io_ptw_pmp_3_cfg_l                                 (_core_io_ptw_pmp_3_cfg_l),
    .io_ptw_pmp_3_cfg_a                                 (_core_io_ptw_pmp_3_cfg_a),
    .io_ptw_pmp_3_cfg_x                                 (_core_io_ptw_pmp_3_cfg_x),
    .io_ptw_pmp_3_cfg_w                                 (_core_io_ptw_pmp_3_cfg_w),
    .io_ptw_pmp_3_cfg_r                                 (_core_io_ptw_pmp_3_cfg_r),
    .io_ptw_pmp_3_addr                                  (_core_io_ptw_pmp_3_addr),
    .io_ptw_pmp_3_mask                                  (_core_io_ptw_pmp_3_mask),
    .io_ptw_pmp_4_cfg_l                                 (_core_io_ptw_pmp_4_cfg_l),
    .io_ptw_pmp_4_cfg_a                                 (_core_io_ptw_pmp_4_cfg_a),
    .io_ptw_pmp_4_cfg_x                                 (_core_io_ptw_pmp_4_cfg_x),
    .io_ptw_pmp_4_cfg_w                                 (_core_io_ptw_pmp_4_cfg_w),
    .io_ptw_pmp_4_cfg_r                                 (_core_io_ptw_pmp_4_cfg_r),
    .io_ptw_pmp_4_addr                                  (_core_io_ptw_pmp_4_addr),
    .io_ptw_pmp_4_mask                                  (_core_io_ptw_pmp_4_mask),
    .io_ptw_pmp_5_cfg_l                                 (_core_io_ptw_pmp_5_cfg_l),
    .io_ptw_pmp_5_cfg_a                                 (_core_io_ptw_pmp_5_cfg_a),
    .io_ptw_pmp_5_cfg_x                                 (_core_io_ptw_pmp_5_cfg_x),
    .io_ptw_pmp_5_cfg_w                                 (_core_io_ptw_pmp_5_cfg_w),
    .io_ptw_pmp_5_cfg_r                                 (_core_io_ptw_pmp_5_cfg_r),
    .io_ptw_pmp_5_addr                                  (_core_io_ptw_pmp_5_addr),
    .io_ptw_pmp_5_mask                                  (_core_io_ptw_pmp_5_mask),
    .io_ptw_pmp_6_cfg_l                                 (_core_io_ptw_pmp_6_cfg_l),
    .io_ptw_pmp_6_cfg_a                                 (_core_io_ptw_pmp_6_cfg_a),
    .io_ptw_pmp_6_cfg_x                                 (_core_io_ptw_pmp_6_cfg_x),
    .io_ptw_pmp_6_cfg_w                                 (_core_io_ptw_pmp_6_cfg_w),
    .io_ptw_pmp_6_cfg_r                                 (_core_io_ptw_pmp_6_cfg_r),
    .io_ptw_pmp_6_addr                                  (_core_io_ptw_pmp_6_addr),
    .io_ptw_pmp_6_mask                                  (_core_io_ptw_pmp_6_mask),
    .io_ptw_pmp_7_cfg_l                                 (_core_io_ptw_pmp_7_cfg_l),
    .io_ptw_pmp_7_cfg_a                                 (_core_io_ptw_pmp_7_cfg_a),
    .io_ptw_pmp_7_cfg_x                                 (_core_io_ptw_pmp_7_cfg_x),
    .io_ptw_pmp_7_cfg_w                                 (_core_io_ptw_pmp_7_cfg_w),
    .io_ptw_pmp_7_cfg_r                                 (_core_io_ptw_pmp_7_cfg_r),
    .io_ptw_pmp_7_addr                                  (_core_io_ptw_pmp_7_addr),
    .io_ptw_pmp_7_mask                                  (_core_io_ptw_pmp_7_mask),
    .io_lsu_exe_0_req_valid                             (_core_io_lsu_exe_0_req_valid),
    .io_lsu_exe_0_req_bits_uop_ctrl_is_load             (_core_io_lsu_exe_0_req_bits_uop_ctrl_is_load),
    .io_lsu_exe_0_req_bits_uop_ctrl_is_sta              (_core_io_lsu_exe_0_req_bits_uop_ctrl_is_sta),
    .io_lsu_exe_0_req_bits_uop_ctrl_is_std              (_core_io_lsu_exe_0_req_bits_uop_ctrl_is_std),
    .io_lsu_exe_0_req_bits_uop_br_mask                  (_core_io_lsu_exe_0_req_bits_uop_br_mask),
    .io_lsu_exe_0_req_bits_uop_rob_idx                  (_core_io_lsu_exe_0_req_bits_uop_rob_idx),
    .io_lsu_exe_0_req_bits_uop_ldq_idx                  (_core_io_lsu_exe_0_req_bits_uop_ldq_idx),
    .io_lsu_exe_0_req_bits_uop_stq_idx                  (_core_io_lsu_exe_0_req_bits_uop_stq_idx),
    .io_lsu_exe_0_req_bits_uop_pdst                     (_core_io_lsu_exe_0_req_bits_uop_pdst),
    .io_lsu_exe_0_req_bits_uop_mem_cmd                  (_core_io_lsu_exe_0_req_bits_uop_mem_cmd),
    .io_lsu_exe_0_req_bits_uop_mem_size                 (_core_io_lsu_exe_0_req_bits_uop_mem_size),
    .io_lsu_exe_0_req_bits_uop_mem_signed               (_core_io_lsu_exe_0_req_bits_uop_mem_signed),
    .io_lsu_exe_0_req_bits_uop_is_fence                 (_core_io_lsu_exe_0_req_bits_uop_is_fence),
    .io_lsu_exe_0_req_bits_uop_is_amo                   (_core_io_lsu_exe_0_req_bits_uop_is_amo),
    .io_lsu_exe_0_req_bits_uop_uses_ldq                 (_core_io_lsu_exe_0_req_bits_uop_uses_ldq),
    .io_lsu_exe_0_req_bits_uop_uses_stq                 (_core_io_lsu_exe_0_req_bits_uop_uses_stq),
    .io_lsu_exe_0_req_bits_uop_fp_val                   (_core_io_lsu_exe_0_req_bits_uop_fp_val),
    .io_lsu_exe_0_req_bits_data                         (_core_io_lsu_exe_0_req_bits_data),
    .io_lsu_exe_0_req_bits_addr                         (_core_io_lsu_exe_0_req_bits_addr),
    .io_lsu_exe_0_req_bits_mxcpt_valid                  (_core_io_lsu_exe_0_req_bits_mxcpt_valid),
    .io_lsu_exe_0_req_bits_sfence_valid                 (_core_io_lsu_exe_0_req_bits_sfence_valid),
    .io_lsu_exe_0_req_bits_sfence_bits_rs1              (_core_io_lsu_exe_0_req_bits_sfence_bits_rs1),
    .io_lsu_exe_0_req_bits_sfence_bits_rs2              (_core_io_lsu_exe_0_req_bits_sfence_bits_rs2),
    .io_lsu_exe_0_req_bits_sfence_bits_addr             (_core_io_lsu_exe_0_req_bits_sfence_bits_addr),
    .io_lsu_exe_1_req_valid                             (_core_io_lsu_exe_1_req_valid),
    .io_lsu_exe_1_req_bits_uop_ctrl_is_load             (_core_io_lsu_exe_1_req_bits_uop_ctrl_is_load),
    .io_lsu_exe_1_req_bits_uop_ctrl_is_sta              (_core_io_lsu_exe_1_req_bits_uop_ctrl_is_sta),
    .io_lsu_exe_1_req_bits_uop_ctrl_is_std              (_core_io_lsu_exe_1_req_bits_uop_ctrl_is_std),
    .io_lsu_exe_1_req_bits_uop_br_mask                  (_core_io_lsu_exe_1_req_bits_uop_br_mask),
    .io_lsu_exe_1_req_bits_uop_rob_idx                  (_core_io_lsu_exe_1_req_bits_uop_rob_idx),
    .io_lsu_exe_1_req_bits_uop_ldq_idx                  (_core_io_lsu_exe_1_req_bits_uop_ldq_idx),
    .io_lsu_exe_1_req_bits_uop_stq_idx                  (_core_io_lsu_exe_1_req_bits_uop_stq_idx),
    .io_lsu_exe_1_req_bits_uop_pdst                     (_core_io_lsu_exe_1_req_bits_uop_pdst),
    .io_lsu_exe_1_req_bits_uop_mem_cmd                  (_core_io_lsu_exe_1_req_bits_uop_mem_cmd),
    .io_lsu_exe_1_req_bits_uop_mem_size                 (_core_io_lsu_exe_1_req_bits_uop_mem_size),
    .io_lsu_exe_1_req_bits_uop_mem_signed               (_core_io_lsu_exe_1_req_bits_uop_mem_signed),
    .io_lsu_exe_1_req_bits_uop_is_fence                 (_core_io_lsu_exe_1_req_bits_uop_is_fence),
    .io_lsu_exe_1_req_bits_uop_is_amo                   (_core_io_lsu_exe_1_req_bits_uop_is_amo),
    .io_lsu_exe_1_req_bits_uop_uses_ldq                 (_core_io_lsu_exe_1_req_bits_uop_uses_ldq),
    .io_lsu_exe_1_req_bits_uop_uses_stq                 (_core_io_lsu_exe_1_req_bits_uop_uses_stq),
    .io_lsu_exe_1_req_bits_uop_fp_val                   (_core_io_lsu_exe_1_req_bits_uop_fp_val),
    .io_lsu_exe_1_req_bits_data                         (_core_io_lsu_exe_1_req_bits_data),
    .io_lsu_exe_1_req_bits_addr                         (_core_io_lsu_exe_1_req_bits_addr),
    .io_lsu_exe_1_req_bits_mxcpt_valid                  (_core_io_lsu_exe_1_req_bits_mxcpt_valid),
    .io_lsu_exe_1_req_bits_sfence_valid                 (_core_io_lsu_exe_1_req_bits_sfence_valid),
    .io_lsu_exe_1_req_bits_sfence_bits_rs1              (_core_io_lsu_exe_1_req_bits_sfence_bits_rs1),
    .io_lsu_exe_1_req_bits_sfence_bits_rs2              (_core_io_lsu_exe_1_req_bits_sfence_bits_rs2),
    .io_lsu_exe_1_req_bits_sfence_bits_addr             (_core_io_lsu_exe_1_req_bits_sfence_bits_addr),
    .io_lsu_dis_uops_0_valid                            (_core_io_lsu_dis_uops_0_valid),
    .io_lsu_dis_uops_0_bits_uopc                        (_core_io_lsu_dis_uops_0_bits_uopc),
    .io_lsu_dis_uops_0_bits_ctrl_is_load                (_core_io_lsu_dis_uops_0_bits_ctrl_is_load),
    .io_lsu_dis_uops_0_bits_ctrl_is_sta                 (_core_io_lsu_dis_uops_0_bits_ctrl_is_sta),
    .io_lsu_dis_uops_0_bits_br_mask                     (_core_io_lsu_dis_uops_0_bits_br_mask),
    .io_lsu_dis_uops_0_bits_rob_idx                     (_core_io_lsu_dis_uops_0_bits_rob_idx),
    .io_lsu_dis_uops_0_bits_ldq_idx                     (_core_io_lsu_dis_uops_0_bits_ldq_idx),
    .io_lsu_dis_uops_0_bits_stq_idx                     (_core_io_lsu_dis_uops_0_bits_stq_idx),
    .io_lsu_dis_uops_0_bits_pdst                        (_core_io_lsu_dis_uops_0_bits_pdst),
    .io_lsu_dis_uops_0_bits_exception                   (_core_io_lsu_dis_uops_0_bits_exception),
    .io_lsu_dis_uops_0_bits_mem_cmd                     (_core_io_lsu_dis_uops_0_bits_mem_cmd),
    .io_lsu_dis_uops_0_bits_mem_size                    (_core_io_lsu_dis_uops_0_bits_mem_size),
    .io_lsu_dis_uops_0_bits_mem_signed                  (_core_io_lsu_dis_uops_0_bits_mem_signed),
    .io_lsu_dis_uops_0_bits_is_fence                    (_core_io_lsu_dis_uops_0_bits_is_fence),
    .io_lsu_dis_uops_0_bits_is_amo                      (_core_io_lsu_dis_uops_0_bits_is_amo),
    .io_lsu_dis_uops_0_bits_uses_ldq                    (_core_io_lsu_dis_uops_0_bits_uses_ldq),
    .io_lsu_dis_uops_0_bits_uses_stq                    (_core_io_lsu_dis_uops_0_bits_uses_stq),
    .io_lsu_dis_uops_0_bits_dst_rtype                   (_core_io_lsu_dis_uops_0_bits_dst_rtype),
    .io_lsu_dis_uops_0_bits_fp_val                      (_core_io_lsu_dis_uops_0_bits_fp_val),
    .io_lsu_dis_uops_1_valid                            (_core_io_lsu_dis_uops_1_valid),
    .io_lsu_dis_uops_1_bits_uopc                        (_core_io_lsu_dis_uops_1_bits_uopc),
    .io_lsu_dis_uops_1_bits_ctrl_is_load                (_core_io_lsu_dis_uops_1_bits_ctrl_is_load),
    .io_lsu_dis_uops_1_bits_ctrl_is_sta                 (_core_io_lsu_dis_uops_1_bits_ctrl_is_sta),
    .io_lsu_dis_uops_1_bits_br_mask                     (_core_io_lsu_dis_uops_1_bits_br_mask),
    .io_lsu_dis_uops_1_bits_rob_idx                     (_core_io_lsu_dis_uops_1_bits_rob_idx),
    .io_lsu_dis_uops_1_bits_ldq_idx                     (_core_io_lsu_dis_uops_1_bits_ldq_idx),
    .io_lsu_dis_uops_1_bits_stq_idx                     (_core_io_lsu_dis_uops_1_bits_stq_idx),
    .io_lsu_dis_uops_1_bits_pdst                        (_core_io_lsu_dis_uops_1_bits_pdst),
    .io_lsu_dis_uops_1_bits_exception                   (_core_io_lsu_dis_uops_1_bits_exception),
    .io_lsu_dis_uops_1_bits_mem_cmd                     (_core_io_lsu_dis_uops_1_bits_mem_cmd),
    .io_lsu_dis_uops_1_bits_mem_size                    (_core_io_lsu_dis_uops_1_bits_mem_size),
    .io_lsu_dis_uops_1_bits_mem_signed                  (_core_io_lsu_dis_uops_1_bits_mem_signed),
    .io_lsu_dis_uops_1_bits_is_fence                    (_core_io_lsu_dis_uops_1_bits_is_fence),
    .io_lsu_dis_uops_1_bits_is_amo                      (_core_io_lsu_dis_uops_1_bits_is_amo),
    .io_lsu_dis_uops_1_bits_uses_ldq                    (_core_io_lsu_dis_uops_1_bits_uses_ldq),
    .io_lsu_dis_uops_1_bits_uses_stq                    (_core_io_lsu_dis_uops_1_bits_uses_stq),
    .io_lsu_dis_uops_1_bits_dst_rtype                   (_core_io_lsu_dis_uops_1_bits_dst_rtype),
    .io_lsu_dis_uops_1_bits_fp_val                      (_core_io_lsu_dis_uops_1_bits_fp_val),
    .io_lsu_dis_uops_2_valid                            (_core_io_lsu_dis_uops_2_valid),
    .io_lsu_dis_uops_2_bits_uopc                        (_core_io_lsu_dis_uops_2_bits_uopc),
    .io_lsu_dis_uops_2_bits_ctrl_is_load                (_core_io_lsu_dis_uops_2_bits_ctrl_is_load),
    .io_lsu_dis_uops_2_bits_ctrl_is_sta                 (_core_io_lsu_dis_uops_2_bits_ctrl_is_sta),
    .io_lsu_dis_uops_2_bits_br_mask                     (_core_io_lsu_dis_uops_2_bits_br_mask),
    .io_lsu_dis_uops_2_bits_rob_idx                     (_core_io_lsu_dis_uops_2_bits_rob_idx),
    .io_lsu_dis_uops_2_bits_ldq_idx                     (_core_io_lsu_dis_uops_2_bits_ldq_idx),
    .io_lsu_dis_uops_2_bits_stq_idx                     (_core_io_lsu_dis_uops_2_bits_stq_idx),
    .io_lsu_dis_uops_2_bits_pdst                        (_core_io_lsu_dis_uops_2_bits_pdst),
    .io_lsu_dis_uops_2_bits_exception                   (_core_io_lsu_dis_uops_2_bits_exception),
    .io_lsu_dis_uops_2_bits_mem_cmd                     (_core_io_lsu_dis_uops_2_bits_mem_cmd),
    .io_lsu_dis_uops_2_bits_mem_size                    (_core_io_lsu_dis_uops_2_bits_mem_size),
    .io_lsu_dis_uops_2_bits_mem_signed                  (_core_io_lsu_dis_uops_2_bits_mem_signed),
    .io_lsu_dis_uops_2_bits_is_fence                    (_core_io_lsu_dis_uops_2_bits_is_fence),
    .io_lsu_dis_uops_2_bits_is_amo                      (_core_io_lsu_dis_uops_2_bits_is_amo),
    .io_lsu_dis_uops_2_bits_uses_ldq                    (_core_io_lsu_dis_uops_2_bits_uses_ldq),
    .io_lsu_dis_uops_2_bits_uses_stq                    (_core_io_lsu_dis_uops_2_bits_uses_stq),
    .io_lsu_dis_uops_2_bits_dst_rtype                   (_core_io_lsu_dis_uops_2_bits_dst_rtype),
    .io_lsu_dis_uops_2_bits_fp_val                      (_core_io_lsu_dis_uops_2_bits_fp_val),
    .io_lsu_dis_uops_3_valid                            (_core_io_lsu_dis_uops_3_valid),
    .io_lsu_dis_uops_3_bits_uopc                        (_core_io_lsu_dis_uops_3_bits_uopc),
    .io_lsu_dis_uops_3_bits_ctrl_is_load                (_core_io_lsu_dis_uops_3_bits_ctrl_is_load),
    .io_lsu_dis_uops_3_bits_ctrl_is_sta                 (_core_io_lsu_dis_uops_3_bits_ctrl_is_sta),
    .io_lsu_dis_uops_3_bits_br_mask                     (_core_io_lsu_dis_uops_3_bits_br_mask),
    .io_lsu_dis_uops_3_bits_rob_idx                     (_core_io_lsu_dis_uops_3_bits_rob_idx),
    .io_lsu_dis_uops_3_bits_ldq_idx                     (_core_io_lsu_dis_uops_3_bits_ldq_idx),
    .io_lsu_dis_uops_3_bits_stq_idx                     (_core_io_lsu_dis_uops_3_bits_stq_idx),
    .io_lsu_dis_uops_3_bits_pdst                        (_core_io_lsu_dis_uops_3_bits_pdst),
    .io_lsu_dis_uops_3_bits_exception                   (_core_io_lsu_dis_uops_3_bits_exception),
    .io_lsu_dis_uops_3_bits_mem_cmd                     (_core_io_lsu_dis_uops_3_bits_mem_cmd),
    .io_lsu_dis_uops_3_bits_mem_size                    (_core_io_lsu_dis_uops_3_bits_mem_size),
    .io_lsu_dis_uops_3_bits_mem_signed                  (_core_io_lsu_dis_uops_3_bits_mem_signed),
    .io_lsu_dis_uops_3_bits_is_fence                    (_core_io_lsu_dis_uops_3_bits_is_fence),
    .io_lsu_dis_uops_3_bits_is_amo                      (_core_io_lsu_dis_uops_3_bits_is_amo),
    .io_lsu_dis_uops_3_bits_uses_ldq                    (_core_io_lsu_dis_uops_3_bits_uses_ldq),
    .io_lsu_dis_uops_3_bits_uses_stq                    (_core_io_lsu_dis_uops_3_bits_uses_stq),
    .io_lsu_dis_uops_3_bits_dst_rtype                   (_core_io_lsu_dis_uops_3_bits_dst_rtype),
    .io_lsu_dis_uops_3_bits_fp_val                      (_core_io_lsu_dis_uops_3_bits_fp_val),
    .io_lsu_fp_stdata_valid                             (_core_io_lsu_fp_stdata_valid),
    .io_lsu_fp_stdata_bits_uop_br_mask                  (_core_io_lsu_fp_stdata_bits_uop_br_mask),
    .io_lsu_fp_stdata_bits_uop_rob_idx                  (_core_io_lsu_fp_stdata_bits_uop_rob_idx),
    .io_lsu_fp_stdata_bits_uop_stq_idx                  (_core_io_lsu_fp_stdata_bits_uop_stq_idx),
    .io_lsu_fp_stdata_bits_data                         (_core_io_lsu_fp_stdata_bits_data),
    .io_lsu_commit_valids_0                             (_core_io_lsu_commit_valids_0),
    .io_lsu_commit_valids_1                             (_core_io_lsu_commit_valids_1),
    .io_lsu_commit_valids_2                             (_core_io_lsu_commit_valids_2),
    .io_lsu_commit_valids_3                             (_core_io_lsu_commit_valids_3),
    .io_lsu_commit_uops_0_uses_ldq                      (_core_io_lsu_commit_uops_0_uses_ldq),
    .io_lsu_commit_uops_0_uses_stq                      (_core_io_lsu_commit_uops_0_uses_stq),
    .io_lsu_commit_uops_1_uses_ldq                      (_core_io_lsu_commit_uops_1_uses_ldq),
    .io_lsu_commit_uops_1_uses_stq                      (_core_io_lsu_commit_uops_1_uses_stq),
    .io_lsu_commit_uops_2_uses_ldq                      (_core_io_lsu_commit_uops_2_uses_ldq),
    .io_lsu_commit_uops_2_uses_stq                      (_core_io_lsu_commit_uops_2_uses_stq),
    .io_lsu_commit_uops_3_uses_ldq                      (_core_io_lsu_commit_uops_3_uses_ldq),
    .io_lsu_commit_uops_3_uses_stq                      (_core_io_lsu_commit_uops_3_uses_stq),
    .io_lsu_commit_load_at_rob_head                     (_core_io_lsu_commit_load_at_rob_head),
    .io_lsu_fence_dmem                                  (_core_io_lsu_fence_dmem),
    .io_lsu_brupdate_b1_resolve_mask                    (_core_io_lsu_brupdate_b1_resolve_mask),
    .io_lsu_brupdate_b1_mispredict_mask                 (_core_io_lsu_brupdate_b1_mispredict_mask),
    .io_lsu_brupdate_b2_uop_ldq_idx                     (_core_io_lsu_brupdate_b2_uop_ldq_idx),
    .io_lsu_brupdate_b2_uop_stq_idx                     (_core_io_lsu_brupdate_b2_uop_stq_idx),
    .io_lsu_brupdate_b2_mispredict                      (_core_io_lsu_brupdate_b2_mispredict),
    .io_lsu_rob_head_idx                                (_core_io_lsu_rob_head_idx),
    .io_lsu_exception                                   (_core_io_lsu_exception)
  );
  LSU lsu (
    .clock                                   (clock),
    .reset                                   (reset),
    .io_ptw_req_ready                        (_ptw_io_requestor_0_req_ready),
    .io_ptw_resp_valid                       (_ptw_io_requestor_0_resp_valid),
    .io_ptw_resp_bits_ae_final               (_ptw_io_requestor_0_resp_bits_ae_final),
    .io_ptw_resp_bits_pte_ppn                (_ptw_io_requestor_0_resp_bits_pte_ppn),
    .io_ptw_resp_bits_pte_d                  (_ptw_io_requestor_0_resp_bits_pte_d),
    .io_ptw_resp_bits_pte_a                  (_ptw_io_requestor_0_resp_bits_pte_a),
    .io_ptw_resp_bits_pte_g                  (_ptw_io_requestor_0_resp_bits_pte_g),
    .io_ptw_resp_bits_pte_u                  (_ptw_io_requestor_0_resp_bits_pte_u),
    .io_ptw_resp_bits_pte_x                  (_ptw_io_requestor_0_resp_bits_pte_x),
    .io_ptw_resp_bits_pte_w                  (_ptw_io_requestor_0_resp_bits_pte_w),
    .io_ptw_resp_bits_pte_r                  (_ptw_io_requestor_0_resp_bits_pte_r),
    .io_ptw_resp_bits_pte_v                  (_ptw_io_requestor_0_resp_bits_pte_v),
    .io_ptw_resp_bits_level                  (_ptw_io_requestor_0_resp_bits_level),
    .io_ptw_resp_bits_homogeneous            (_ptw_io_requestor_0_resp_bits_homogeneous),
    .io_ptw_ptbr_mode                        (_ptw_io_requestor_0_ptbr_mode),
    .io_ptw_status_dprv                      (_ptw_io_requestor_0_status_dprv),
    .io_ptw_status_mxr                       (_ptw_io_requestor_0_status_mxr),
    .io_ptw_status_sum                       (_ptw_io_requestor_0_status_sum),
    .io_ptw_pmp_0_cfg_l                      (_ptw_io_requestor_0_pmp_0_cfg_l),
    .io_ptw_pmp_0_cfg_a                      (_ptw_io_requestor_0_pmp_0_cfg_a),
    .io_ptw_pmp_0_cfg_x                      (_ptw_io_requestor_0_pmp_0_cfg_x),
    .io_ptw_pmp_0_cfg_w                      (_ptw_io_requestor_0_pmp_0_cfg_w),
    .io_ptw_pmp_0_cfg_r                      (_ptw_io_requestor_0_pmp_0_cfg_r),
    .io_ptw_pmp_0_addr                       (_ptw_io_requestor_0_pmp_0_addr),
    .io_ptw_pmp_0_mask                       (_ptw_io_requestor_0_pmp_0_mask),
    .io_ptw_pmp_1_cfg_l                      (_ptw_io_requestor_0_pmp_1_cfg_l),
    .io_ptw_pmp_1_cfg_a                      (_ptw_io_requestor_0_pmp_1_cfg_a),
    .io_ptw_pmp_1_cfg_x                      (_ptw_io_requestor_0_pmp_1_cfg_x),
    .io_ptw_pmp_1_cfg_w                      (_ptw_io_requestor_0_pmp_1_cfg_w),
    .io_ptw_pmp_1_cfg_r                      (_ptw_io_requestor_0_pmp_1_cfg_r),
    .io_ptw_pmp_1_addr                       (_ptw_io_requestor_0_pmp_1_addr),
    .io_ptw_pmp_1_mask                       (_ptw_io_requestor_0_pmp_1_mask),
    .io_ptw_pmp_2_cfg_l                      (_ptw_io_requestor_0_pmp_2_cfg_l),
    .io_ptw_pmp_2_cfg_a                      (_ptw_io_requestor_0_pmp_2_cfg_a),
    .io_ptw_pmp_2_cfg_x                      (_ptw_io_requestor_0_pmp_2_cfg_x),
    .io_ptw_pmp_2_cfg_w                      (_ptw_io_requestor_0_pmp_2_cfg_w),
    .io_ptw_pmp_2_cfg_r                      (_ptw_io_requestor_0_pmp_2_cfg_r),
    .io_ptw_pmp_2_addr                       (_ptw_io_requestor_0_pmp_2_addr),
    .io_ptw_pmp_2_mask                       (_ptw_io_requestor_0_pmp_2_mask),
    .io_ptw_pmp_3_cfg_l                      (_ptw_io_requestor_0_pmp_3_cfg_l),
    .io_ptw_pmp_3_cfg_a                      (_ptw_io_requestor_0_pmp_3_cfg_a),
    .io_ptw_pmp_3_cfg_x                      (_ptw_io_requestor_0_pmp_3_cfg_x),
    .io_ptw_pmp_3_cfg_w                      (_ptw_io_requestor_0_pmp_3_cfg_w),
    .io_ptw_pmp_3_cfg_r                      (_ptw_io_requestor_0_pmp_3_cfg_r),
    .io_ptw_pmp_3_addr                       (_ptw_io_requestor_0_pmp_3_addr),
    .io_ptw_pmp_3_mask                       (_ptw_io_requestor_0_pmp_3_mask),
    .io_ptw_pmp_4_cfg_l                      (_ptw_io_requestor_0_pmp_4_cfg_l),
    .io_ptw_pmp_4_cfg_a                      (_ptw_io_requestor_0_pmp_4_cfg_a),
    .io_ptw_pmp_4_cfg_x                      (_ptw_io_requestor_0_pmp_4_cfg_x),
    .io_ptw_pmp_4_cfg_w                      (_ptw_io_requestor_0_pmp_4_cfg_w),
    .io_ptw_pmp_4_cfg_r                      (_ptw_io_requestor_0_pmp_4_cfg_r),
    .io_ptw_pmp_4_addr                       (_ptw_io_requestor_0_pmp_4_addr),
    .io_ptw_pmp_4_mask                       (_ptw_io_requestor_0_pmp_4_mask),
    .io_ptw_pmp_5_cfg_l                      (_ptw_io_requestor_0_pmp_5_cfg_l),
    .io_ptw_pmp_5_cfg_a                      (_ptw_io_requestor_0_pmp_5_cfg_a),
    .io_ptw_pmp_5_cfg_x                      (_ptw_io_requestor_0_pmp_5_cfg_x),
    .io_ptw_pmp_5_cfg_w                      (_ptw_io_requestor_0_pmp_5_cfg_w),
    .io_ptw_pmp_5_cfg_r                      (_ptw_io_requestor_0_pmp_5_cfg_r),
    .io_ptw_pmp_5_addr                       (_ptw_io_requestor_0_pmp_5_addr),
    .io_ptw_pmp_5_mask                       (_ptw_io_requestor_0_pmp_5_mask),
    .io_ptw_pmp_6_cfg_l                      (_ptw_io_requestor_0_pmp_6_cfg_l),
    .io_ptw_pmp_6_cfg_a                      (_ptw_io_requestor_0_pmp_6_cfg_a),
    .io_ptw_pmp_6_cfg_x                      (_ptw_io_requestor_0_pmp_6_cfg_x),
    .io_ptw_pmp_6_cfg_w                      (_ptw_io_requestor_0_pmp_6_cfg_w),
    .io_ptw_pmp_6_cfg_r                      (_ptw_io_requestor_0_pmp_6_cfg_r),
    .io_ptw_pmp_6_addr                       (_ptw_io_requestor_0_pmp_6_addr),
    .io_ptw_pmp_6_mask                       (_ptw_io_requestor_0_pmp_6_mask),
    .io_ptw_pmp_7_cfg_l                      (_ptw_io_requestor_0_pmp_7_cfg_l),
    .io_ptw_pmp_7_cfg_a                      (_ptw_io_requestor_0_pmp_7_cfg_a),
    .io_ptw_pmp_7_cfg_x                      (_ptw_io_requestor_0_pmp_7_cfg_x),
    .io_ptw_pmp_7_cfg_w                      (_ptw_io_requestor_0_pmp_7_cfg_w),
    .io_ptw_pmp_7_cfg_r                      (_ptw_io_requestor_0_pmp_7_cfg_r),
    .io_ptw_pmp_7_addr                       (_ptw_io_requestor_0_pmp_7_addr),
    .io_ptw_pmp_7_mask                       (_ptw_io_requestor_0_pmp_7_mask),
    .io_core_exe_0_req_valid                 (_core_io_lsu_exe_0_req_valid),
    .io_core_exe_0_req_bits_uop_ctrl_is_load (_core_io_lsu_exe_0_req_bits_uop_ctrl_is_load),
    .io_core_exe_0_req_bits_uop_ctrl_is_sta  (_core_io_lsu_exe_0_req_bits_uop_ctrl_is_sta),
    .io_core_exe_0_req_bits_uop_ctrl_is_std  (_core_io_lsu_exe_0_req_bits_uop_ctrl_is_std),
    .io_core_exe_0_req_bits_uop_br_mask      (_core_io_lsu_exe_0_req_bits_uop_br_mask),
    .io_core_exe_0_req_bits_uop_rob_idx      (_core_io_lsu_exe_0_req_bits_uop_rob_idx),
    .io_core_exe_0_req_bits_uop_ldq_idx      (_core_io_lsu_exe_0_req_bits_uop_ldq_idx),
    .io_core_exe_0_req_bits_uop_stq_idx      (_core_io_lsu_exe_0_req_bits_uop_stq_idx),
    .io_core_exe_0_req_bits_uop_pdst         (_core_io_lsu_exe_0_req_bits_uop_pdst),
    .io_core_exe_0_req_bits_uop_mem_cmd      (_core_io_lsu_exe_0_req_bits_uop_mem_cmd),
    .io_core_exe_0_req_bits_uop_mem_size     (_core_io_lsu_exe_0_req_bits_uop_mem_size),
    .io_core_exe_0_req_bits_uop_mem_signed   (_core_io_lsu_exe_0_req_bits_uop_mem_signed),
    .io_core_exe_0_req_bits_uop_is_fence     (_core_io_lsu_exe_0_req_bits_uop_is_fence),
    .io_core_exe_0_req_bits_uop_is_amo       (_core_io_lsu_exe_0_req_bits_uop_is_amo),
    .io_core_exe_0_req_bits_uop_uses_ldq     (_core_io_lsu_exe_0_req_bits_uop_uses_ldq),
    .io_core_exe_0_req_bits_uop_uses_stq     (_core_io_lsu_exe_0_req_bits_uop_uses_stq),
    .io_core_exe_0_req_bits_uop_fp_val       (_core_io_lsu_exe_0_req_bits_uop_fp_val),
    .io_core_exe_0_req_bits_data             (_core_io_lsu_exe_0_req_bits_data),
    .io_core_exe_0_req_bits_addr             (_core_io_lsu_exe_0_req_bits_addr),
    .io_core_exe_0_req_bits_mxcpt_valid      (_core_io_lsu_exe_0_req_bits_mxcpt_valid),
    .io_core_exe_0_req_bits_sfence_valid     (_core_io_lsu_exe_0_req_bits_sfence_valid),
    .io_core_exe_0_req_bits_sfence_bits_rs1  (_core_io_lsu_exe_0_req_bits_sfence_bits_rs1),
    .io_core_exe_0_req_bits_sfence_bits_rs2  (_core_io_lsu_exe_0_req_bits_sfence_bits_rs2),
    .io_core_exe_0_req_bits_sfence_bits_addr (_core_io_lsu_exe_0_req_bits_sfence_bits_addr),
    .io_core_exe_1_req_valid                 (_core_io_lsu_exe_1_req_valid),
    .io_core_exe_1_req_bits_uop_ctrl_is_load (_core_io_lsu_exe_1_req_bits_uop_ctrl_is_load),
    .io_core_exe_1_req_bits_uop_ctrl_is_sta  (_core_io_lsu_exe_1_req_bits_uop_ctrl_is_sta),
    .io_core_exe_1_req_bits_uop_ctrl_is_std  (_core_io_lsu_exe_1_req_bits_uop_ctrl_is_std),
    .io_core_exe_1_req_bits_uop_br_mask      (_core_io_lsu_exe_1_req_bits_uop_br_mask),
    .io_core_exe_1_req_bits_uop_rob_idx      (_core_io_lsu_exe_1_req_bits_uop_rob_idx),
    .io_core_exe_1_req_bits_uop_ldq_idx      (_core_io_lsu_exe_1_req_bits_uop_ldq_idx),
    .io_core_exe_1_req_bits_uop_stq_idx      (_core_io_lsu_exe_1_req_bits_uop_stq_idx),
    .io_core_exe_1_req_bits_uop_pdst         (_core_io_lsu_exe_1_req_bits_uop_pdst),
    .io_core_exe_1_req_bits_uop_mem_cmd      (_core_io_lsu_exe_1_req_bits_uop_mem_cmd),
    .io_core_exe_1_req_bits_uop_mem_size     (_core_io_lsu_exe_1_req_bits_uop_mem_size),
    .io_core_exe_1_req_bits_uop_mem_signed   (_core_io_lsu_exe_1_req_bits_uop_mem_signed),
    .io_core_exe_1_req_bits_uop_is_fence     (_core_io_lsu_exe_1_req_bits_uop_is_fence),
    .io_core_exe_1_req_bits_uop_is_amo       (_core_io_lsu_exe_1_req_bits_uop_is_amo),
    .io_core_exe_1_req_bits_uop_uses_ldq     (_core_io_lsu_exe_1_req_bits_uop_uses_ldq),
    .io_core_exe_1_req_bits_uop_uses_stq     (_core_io_lsu_exe_1_req_bits_uop_uses_stq),
    .io_core_exe_1_req_bits_uop_fp_val       (_core_io_lsu_exe_1_req_bits_uop_fp_val),
    .io_core_exe_1_req_bits_data             (_core_io_lsu_exe_1_req_bits_data),
    .io_core_exe_1_req_bits_addr             (_core_io_lsu_exe_1_req_bits_addr),
    .io_core_exe_1_req_bits_mxcpt_valid      (_core_io_lsu_exe_1_req_bits_mxcpt_valid),
    .io_core_exe_1_req_bits_sfence_valid     (_core_io_lsu_exe_1_req_bits_sfence_valid),
    .io_core_exe_1_req_bits_sfence_bits_rs1  (_core_io_lsu_exe_1_req_bits_sfence_bits_rs1),
    .io_core_exe_1_req_bits_sfence_bits_rs2  (_core_io_lsu_exe_1_req_bits_sfence_bits_rs2),
    .io_core_exe_1_req_bits_sfence_bits_addr (_core_io_lsu_exe_1_req_bits_sfence_bits_addr),
    .io_core_dis_uops_0_valid                (_core_io_lsu_dis_uops_0_valid),
    .io_core_dis_uops_0_bits_uopc            (_core_io_lsu_dis_uops_0_bits_uopc),
    .io_core_dis_uops_0_bits_ctrl_is_load    (_core_io_lsu_dis_uops_0_bits_ctrl_is_load),
    .io_core_dis_uops_0_bits_ctrl_is_sta     (_core_io_lsu_dis_uops_0_bits_ctrl_is_sta),
    .io_core_dis_uops_0_bits_br_mask         (_core_io_lsu_dis_uops_0_bits_br_mask),
    .io_core_dis_uops_0_bits_rob_idx         (_core_io_lsu_dis_uops_0_bits_rob_idx),
    .io_core_dis_uops_0_bits_ldq_idx         (_core_io_lsu_dis_uops_0_bits_ldq_idx),
    .io_core_dis_uops_0_bits_stq_idx         (_core_io_lsu_dis_uops_0_bits_stq_idx),
    .io_core_dis_uops_0_bits_pdst            (_core_io_lsu_dis_uops_0_bits_pdst),
    .io_core_dis_uops_0_bits_exception       (_core_io_lsu_dis_uops_0_bits_exception),
    .io_core_dis_uops_0_bits_mem_cmd         (_core_io_lsu_dis_uops_0_bits_mem_cmd),
    .io_core_dis_uops_0_bits_mem_size        (_core_io_lsu_dis_uops_0_bits_mem_size),
    .io_core_dis_uops_0_bits_mem_signed      (_core_io_lsu_dis_uops_0_bits_mem_signed),
    .io_core_dis_uops_0_bits_is_fence        (_core_io_lsu_dis_uops_0_bits_is_fence),
    .io_core_dis_uops_0_bits_is_amo          (_core_io_lsu_dis_uops_0_bits_is_amo),
    .io_core_dis_uops_0_bits_uses_ldq        (_core_io_lsu_dis_uops_0_bits_uses_ldq),
    .io_core_dis_uops_0_bits_uses_stq        (_core_io_lsu_dis_uops_0_bits_uses_stq),
    .io_core_dis_uops_0_bits_dst_rtype       (_core_io_lsu_dis_uops_0_bits_dst_rtype),
    .io_core_dis_uops_0_bits_fp_val          (_core_io_lsu_dis_uops_0_bits_fp_val),
    .io_core_dis_uops_1_valid                (_core_io_lsu_dis_uops_1_valid),
    .io_core_dis_uops_1_bits_uopc            (_core_io_lsu_dis_uops_1_bits_uopc),
    .io_core_dis_uops_1_bits_ctrl_is_load    (_core_io_lsu_dis_uops_1_bits_ctrl_is_load),
    .io_core_dis_uops_1_bits_ctrl_is_sta     (_core_io_lsu_dis_uops_1_bits_ctrl_is_sta),
    .io_core_dis_uops_1_bits_br_mask         (_core_io_lsu_dis_uops_1_bits_br_mask),
    .io_core_dis_uops_1_bits_rob_idx         (_core_io_lsu_dis_uops_1_bits_rob_idx),
    .io_core_dis_uops_1_bits_ldq_idx         (_core_io_lsu_dis_uops_1_bits_ldq_idx),
    .io_core_dis_uops_1_bits_stq_idx         (_core_io_lsu_dis_uops_1_bits_stq_idx),
    .io_core_dis_uops_1_bits_pdst            (_core_io_lsu_dis_uops_1_bits_pdst),
    .io_core_dis_uops_1_bits_exception       (_core_io_lsu_dis_uops_1_bits_exception),
    .io_core_dis_uops_1_bits_mem_cmd         (_core_io_lsu_dis_uops_1_bits_mem_cmd),
    .io_core_dis_uops_1_bits_mem_size        (_core_io_lsu_dis_uops_1_bits_mem_size),
    .io_core_dis_uops_1_bits_mem_signed      (_core_io_lsu_dis_uops_1_bits_mem_signed),
    .io_core_dis_uops_1_bits_is_fence        (_core_io_lsu_dis_uops_1_bits_is_fence),
    .io_core_dis_uops_1_bits_is_amo          (_core_io_lsu_dis_uops_1_bits_is_amo),
    .io_core_dis_uops_1_bits_uses_ldq        (_core_io_lsu_dis_uops_1_bits_uses_ldq),
    .io_core_dis_uops_1_bits_uses_stq        (_core_io_lsu_dis_uops_1_bits_uses_stq),
    .io_core_dis_uops_1_bits_dst_rtype       (_core_io_lsu_dis_uops_1_bits_dst_rtype),
    .io_core_dis_uops_1_bits_fp_val          (_core_io_lsu_dis_uops_1_bits_fp_val),
    .io_core_dis_uops_2_valid                (_core_io_lsu_dis_uops_2_valid),
    .io_core_dis_uops_2_bits_uopc            (_core_io_lsu_dis_uops_2_bits_uopc),
    .io_core_dis_uops_2_bits_ctrl_is_load    (_core_io_lsu_dis_uops_2_bits_ctrl_is_load),
    .io_core_dis_uops_2_bits_ctrl_is_sta     (_core_io_lsu_dis_uops_2_bits_ctrl_is_sta),
    .io_core_dis_uops_2_bits_br_mask         (_core_io_lsu_dis_uops_2_bits_br_mask),
    .io_core_dis_uops_2_bits_rob_idx         (_core_io_lsu_dis_uops_2_bits_rob_idx),
    .io_core_dis_uops_2_bits_ldq_idx         (_core_io_lsu_dis_uops_2_bits_ldq_idx),
    .io_core_dis_uops_2_bits_stq_idx         (_core_io_lsu_dis_uops_2_bits_stq_idx),
    .io_core_dis_uops_2_bits_pdst            (_core_io_lsu_dis_uops_2_bits_pdst),
    .io_core_dis_uops_2_bits_exception       (_core_io_lsu_dis_uops_2_bits_exception),
    .io_core_dis_uops_2_bits_mem_cmd         (_core_io_lsu_dis_uops_2_bits_mem_cmd),
    .io_core_dis_uops_2_bits_mem_size        (_core_io_lsu_dis_uops_2_bits_mem_size),
    .io_core_dis_uops_2_bits_mem_signed      (_core_io_lsu_dis_uops_2_bits_mem_signed),
    .io_core_dis_uops_2_bits_is_fence        (_core_io_lsu_dis_uops_2_bits_is_fence),
    .io_core_dis_uops_2_bits_is_amo          (_core_io_lsu_dis_uops_2_bits_is_amo),
    .io_core_dis_uops_2_bits_uses_ldq        (_core_io_lsu_dis_uops_2_bits_uses_ldq),
    .io_core_dis_uops_2_bits_uses_stq        (_core_io_lsu_dis_uops_2_bits_uses_stq),
    .io_core_dis_uops_2_bits_dst_rtype       (_core_io_lsu_dis_uops_2_bits_dst_rtype),
    .io_core_dis_uops_2_bits_fp_val          (_core_io_lsu_dis_uops_2_bits_fp_val),
    .io_core_dis_uops_3_valid                (_core_io_lsu_dis_uops_3_valid),
    .io_core_dis_uops_3_bits_uopc            (_core_io_lsu_dis_uops_3_bits_uopc),
    .io_core_dis_uops_3_bits_ctrl_is_load    (_core_io_lsu_dis_uops_3_bits_ctrl_is_load),
    .io_core_dis_uops_3_bits_ctrl_is_sta     (_core_io_lsu_dis_uops_3_bits_ctrl_is_sta),
    .io_core_dis_uops_3_bits_br_mask         (_core_io_lsu_dis_uops_3_bits_br_mask),
    .io_core_dis_uops_3_bits_rob_idx         (_core_io_lsu_dis_uops_3_bits_rob_idx),
    .io_core_dis_uops_3_bits_ldq_idx         (_core_io_lsu_dis_uops_3_bits_ldq_idx),
    .io_core_dis_uops_3_bits_stq_idx         (_core_io_lsu_dis_uops_3_bits_stq_idx),
    .io_core_dis_uops_3_bits_pdst            (_core_io_lsu_dis_uops_3_bits_pdst),
    .io_core_dis_uops_3_bits_exception       (_core_io_lsu_dis_uops_3_bits_exception),
    .io_core_dis_uops_3_bits_mem_cmd         (_core_io_lsu_dis_uops_3_bits_mem_cmd),
    .io_core_dis_uops_3_bits_mem_size        (_core_io_lsu_dis_uops_3_bits_mem_size),
    .io_core_dis_uops_3_bits_mem_signed      (_core_io_lsu_dis_uops_3_bits_mem_signed),
    .io_core_dis_uops_3_bits_is_fence        (_core_io_lsu_dis_uops_3_bits_is_fence),
    .io_core_dis_uops_3_bits_is_amo          (_core_io_lsu_dis_uops_3_bits_is_amo),
    .io_core_dis_uops_3_bits_uses_ldq        (_core_io_lsu_dis_uops_3_bits_uses_ldq),
    .io_core_dis_uops_3_bits_uses_stq        (_core_io_lsu_dis_uops_3_bits_uses_stq),
    .io_core_dis_uops_3_bits_dst_rtype       (_core_io_lsu_dis_uops_3_bits_dst_rtype),
    .io_core_dis_uops_3_bits_fp_val          (_core_io_lsu_dis_uops_3_bits_fp_val),
    .io_core_fp_stdata_valid                 (_core_io_lsu_fp_stdata_valid),
    .io_core_fp_stdata_bits_uop_br_mask      (_core_io_lsu_fp_stdata_bits_uop_br_mask),
    .io_core_fp_stdata_bits_uop_rob_idx      (_core_io_lsu_fp_stdata_bits_uop_rob_idx),
    .io_core_fp_stdata_bits_uop_stq_idx      (_core_io_lsu_fp_stdata_bits_uop_stq_idx),
    .io_core_fp_stdata_bits_data             (_core_io_lsu_fp_stdata_bits_data),
    .io_core_commit_valids_0                 (_core_io_lsu_commit_valids_0),
    .io_core_commit_valids_1                 (_core_io_lsu_commit_valids_1),
    .io_core_commit_valids_2                 (_core_io_lsu_commit_valids_2),
    .io_core_commit_valids_3                 (_core_io_lsu_commit_valids_3),
    .io_core_commit_uops_0_uses_ldq          (_core_io_lsu_commit_uops_0_uses_ldq),
    .io_core_commit_uops_0_uses_stq          (_core_io_lsu_commit_uops_0_uses_stq),
    .io_core_commit_uops_1_uses_ldq          (_core_io_lsu_commit_uops_1_uses_ldq),
    .io_core_commit_uops_1_uses_stq          (_core_io_lsu_commit_uops_1_uses_stq),
    .io_core_commit_uops_2_uses_ldq          (_core_io_lsu_commit_uops_2_uses_ldq),
    .io_core_commit_uops_2_uses_stq          (_core_io_lsu_commit_uops_2_uses_stq),
    .io_core_commit_uops_3_uses_ldq          (_core_io_lsu_commit_uops_3_uses_ldq),
    .io_core_commit_uops_3_uses_stq          (_core_io_lsu_commit_uops_3_uses_stq),
    .io_core_commit_load_at_rob_head         (_core_io_lsu_commit_load_at_rob_head),
    .io_core_fence_dmem                      (_core_io_lsu_fence_dmem),
    .io_core_brupdate_b1_resolve_mask        (_core_io_lsu_brupdate_b1_resolve_mask),
    .io_core_brupdate_b1_mispredict_mask     (_core_io_lsu_brupdate_b1_mispredict_mask),
    .io_core_brupdate_b2_uop_ldq_idx         (_core_io_lsu_brupdate_b2_uop_ldq_idx),
    .io_core_brupdate_b2_uop_stq_idx         (_core_io_lsu_brupdate_b2_uop_stq_idx),
    .io_core_brupdate_b2_mispredict          (_core_io_lsu_brupdate_b2_mispredict),
    .io_core_rob_head_idx                    (_core_io_lsu_rob_head_idx),
    .io_core_exception                       (_core_io_lsu_exception),
    .io_dmem_req_ready                       (_dcache_io_lsu_req_ready),
    .io_dmem_resp_0_valid                    (_dcache_io_lsu_resp_0_valid),
    .io_dmem_resp_0_bits_uop_ldq_idx         (_dcache_io_lsu_resp_0_bits_uop_ldq_idx),
    .io_dmem_resp_0_bits_uop_stq_idx         (_dcache_io_lsu_resp_0_bits_uop_stq_idx),
    .io_dmem_resp_0_bits_uop_is_amo          (_dcache_io_lsu_resp_0_bits_uop_is_amo),
    .io_dmem_resp_0_bits_uop_uses_ldq        (_dcache_io_lsu_resp_0_bits_uop_uses_ldq),
    .io_dmem_resp_0_bits_uop_uses_stq        (_dcache_io_lsu_resp_0_bits_uop_uses_stq),
    .io_dmem_resp_0_bits_data                (_dcache_io_lsu_resp_0_bits_data),
    .io_dmem_resp_0_bits_is_hella            (_dcache_io_lsu_resp_0_bits_is_hella),
    .io_dmem_resp_1_valid                    (_dcache_io_lsu_resp_1_valid),
    .io_dmem_resp_1_bits_uop_ldq_idx         (_dcache_io_lsu_resp_1_bits_uop_ldq_idx),
    .io_dmem_resp_1_bits_uop_stq_idx         (_dcache_io_lsu_resp_1_bits_uop_stq_idx),
    .io_dmem_resp_1_bits_uop_is_amo          (_dcache_io_lsu_resp_1_bits_uop_is_amo),
    .io_dmem_resp_1_bits_uop_uses_ldq        (_dcache_io_lsu_resp_1_bits_uop_uses_ldq),
    .io_dmem_resp_1_bits_uop_uses_stq        (_dcache_io_lsu_resp_1_bits_uop_uses_stq),
    .io_dmem_resp_1_bits_data                (_dcache_io_lsu_resp_1_bits_data),
    .io_dmem_resp_1_bits_is_hella            (_dcache_io_lsu_resp_1_bits_is_hella),
    .io_dmem_nack_0_valid                    (_dcache_io_lsu_nack_0_valid),
    .io_dmem_nack_0_bits_uop_ldq_idx         (_dcache_io_lsu_nack_0_bits_uop_ldq_idx),
    .io_dmem_nack_0_bits_uop_stq_idx         (_dcache_io_lsu_nack_0_bits_uop_stq_idx),
    .io_dmem_nack_0_bits_uop_uses_ldq        (_dcache_io_lsu_nack_0_bits_uop_uses_ldq),
    .io_dmem_nack_0_bits_uop_uses_stq        (_dcache_io_lsu_nack_0_bits_uop_uses_stq),
    .io_dmem_nack_0_bits_is_hella            (_dcache_io_lsu_nack_0_bits_is_hella),
    .io_dmem_nack_1_valid                    (_dcache_io_lsu_nack_1_valid),
    .io_dmem_nack_1_bits_uop_ldq_idx         (_dcache_io_lsu_nack_1_bits_uop_ldq_idx),
    .io_dmem_nack_1_bits_uop_stq_idx         (_dcache_io_lsu_nack_1_bits_uop_stq_idx),
    .io_dmem_nack_1_bits_uop_uses_ldq        (_dcache_io_lsu_nack_1_bits_uop_uses_ldq),
    .io_dmem_nack_1_bits_uop_uses_stq        (_dcache_io_lsu_nack_1_bits_uop_uses_stq),
    .io_dmem_nack_1_bits_is_hella            (_dcache_io_lsu_nack_1_bits_is_hella),
    .io_dmem_release_valid                   (_dcache_io_lsu_release_valid),
    .io_dmem_release_bits_address            (_dcache_io_lsu_release_bits_address),
    .io_dmem_ordered                         (_dcache_io_lsu_ordered),
    .io_hellacache_req_valid                 (_hellaCacheArb_io_mem_req_valid),
    .io_hellacache_req_bits_addr             (_hellaCacheArb_io_mem_req_bits_addr),
    .io_hellacache_s1_kill                   (_hellaCacheArb_io_mem_s1_kill),
    .io_ptw_req_valid                        (_lsu_io_ptw_req_valid),
    .io_ptw_req_bits_valid                   (_lsu_io_ptw_req_bits_valid),
    .io_ptw_req_bits_bits_addr               (_lsu_io_ptw_req_bits_bits_addr),
    .io_core_exe_0_iresp_valid               (_lsu_io_core_exe_0_iresp_valid),
    .io_core_exe_0_iresp_bits_uop_rob_idx    (_lsu_io_core_exe_0_iresp_bits_uop_rob_idx),
    .io_core_exe_0_iresp_bits_uop_pdst       (_lsu_io_core_exe_0_iresp_bits_uop_pdst),
    .io_core_exe_0_iresp_bits_uop_is_amo     (_lsu_io_core_exe_0_iresp_bits_uop_is_amo),
    .io_core_exe_0_iresp_bits_uop_uses_stq   (_lsu_io_core_exe_0_iresp_bits_uop_uses_stq),
    .io_core_exe_0_iresp_bits_uop_dst_rtype  (_lsu_io_core_exe_0_iresp_bits_uop_dst_rtype),
    .io_core_exe_0_iresp_bits_data           (_lsu_io_core_exe_0_iresp_bits_data),
    .io_core_exe_0_fresp_valid               (_lsu_io_core_exe_0_fresp_valid),
    .io_core_exe_0_fresp_bits_uop_uopc       (_lsu_io_core_exe_0_fresp_bits_uop_uopc),
    .io_core_exe_0_fresp_bits_uop_br_mask    (_lsu_io_core_exe_0_fresp_bits_uop_br_mask),
    .io_core_exe_0_fresp_bits_uop_rob_idx    (_lsu_io_core_exe_0_fresp_bits_uop_rob_idx),
    .io_core_exe_0_fresp_bits_uop_stq_idx    (_lsu_io_core_exe_0_fresp_bits_uop_stq_idx),
    .io_core_exe_0_fresp_bits_uop_pdst       (_lsu_io_core_exe_0_fresp_bits_uop_pdst),
    .io_core_exe_0_fresp_bits_uop_mem_size   (_lsu_io_core_exe_0_fresp_bits_uop_mem_size),
    .io_core_exe_0_fresp_bits_uop_is_amo     (_lsu_io_core_exe_0_fresp_bits_uop_is_amo),
    .io_core_exe_0_fresp_bits_uop_uses_stq   (_lsu_io_core_exe_0_fresp_bits_uop_uses_stq),
    .io_core_exe_0_fresp_bits_uop_dst_rtype  (_lsu_io_core_exe_0_fresp_bits_uop_dst_rtype),
    .io_core_exe_0_fresp_bits_uop_fp_val     (_lsu_io_core_exe_0_fresp_bits_uop_fp_val),
    .io_core_exe_0_fresp_bits_data           (_lsu_io_core_exe_0_fresp_bits_data),
    .io_core_exe_1_iresp_valid               (_lsu_io_core_exe_1_iresp_valid),
    .io_core_exe_1_iresp_bits_uop_rob_idx    (_lsu_io_core_exe_1_iresp_bits_uop_rob_idx),
    .io_core_exe_1_iresp_bits_uop_pdst       (_lsu_io_core_exe_1_iresp_bits_uop_pdst),
    .io_core_exe_1_iresp_bits_uop_is_amo     (_lsu_io_core_exe_1_iresp_bits_uop_is_amo),
    .io_core_exe_1_iresp_bits_uop_uses_stq   (_lsu_io_core_exe_1_iresp_bits_uop_uses_stq),
    .io_core_exe_1_iresp_bits_uop_dst_rtype  (_lsu_io_core_exe_1_iresp_bits_uop_dst_rtype),
    .io_core_exe_1_iresp_bits_data           (_lsu_io_core_exe_1_iresp_bits_data),
    .io_core_exe_1_fresp_valid               (_lsu_io_core_exe_1_fresp_valid),
    .io_core_exe_1_fresp_bits_uop_uopc       (_lsu_io_core_exe_1_fresp_bits_uop_uopc),
    .io_core_exe_1_fresp_bits_uop_br_mask    (_lsu_io_core_exe_1_fresp_bits_uop_br_mask),
    .io_core_exe_1_fresp_bits_uop_rob_idx    (_lsu_io_core_exe_1_fresp_bits_uop_rob_idx),
    .io_core_exe_1_fresp_bits_uop_stq_idx    (_lsu_io_core_exe_1_fresp_bits_uop_stq_idx),
    .io_core_exe_1_fresp_bits_uop_pdst       (_lsu_io_core_exe_1_fresp_bits_uop_pdst),
    .io_core_exe_1_fresp_bits_uop_mem_size   (_lsu_io_core_exe_1_fresp_bits_uop_mem_size),
    .io_core_exe_1_fresp_bits_uop_is_amo     (_lsu_io_core_exe_1_fresp_bits_uop_is_amo),
    .io_core_exe_1_fresp_bits_uop_uses_stq   (_lsu_io_core_exe_1_fresp_bits_uop_uses_stq),
    .io_core_exe_1_fresp_bits_uop_dst_rtype  (_lsu_io_core_exe_1_fresp_bits_uop_dst_rtype),
    .io_core_exe_1_fresp_bits_uop_fp_val     (_lsu_io_core_exe_1_fresp_bits_uop_fp_val),
    .io_core_exe_1_fresp_bits_data           (_lsu_io_core_exe_1_fresp_bits_data),
    .io_core_dis_ldq_idx_0                   (_lsu_io_core_dis_ldq_idx_0),
    .io_core_dis_ldq_idx_1                   (_lsu_io_core_dis_ldq_idx_1),
    .io_core_dis_ldq_idx_2                   (_lsu_io_core_dis_ldq_idx_2),
    .io_core_dis_ldq_idx_3                   (_lsu_io_core_dis_ldq_idx_3),
    .io_core_dis_stq_idx_0                   (_lsu_io_core_dis_stq_idx_0),
    .io_core_dis_stq_idx_1                   (_lsu_io_core_dis_stq_idx_1),
    .io_core_dis_stq_idx_2                   (_lsu_io_core_dis_stq_idx_2),
    .io_core_dis_stq_idx_3                   (_lsu_io_core_dis_stq_idx_3),
    .io_core_ldq_full_0                      (_lsu_io_core_ldq_full_0),
    .io_core_ldq_full_1                      (_lsu_io_core_ldq_full_1),
    .io_core_ldq_full_2                      (_lsu_io_core_ldq_full_2),
    .io_core_ldq_full_3                      (_lsu_io_core_ldq_full_3),
    .io_core_stq_full_0                      (_lsu_io_core_stq_full_0),
    .io_core_stq_full_1                      (_lsu_io_core_stq_full_1),
    .io_core_stq_full_2                      (_lsu_io_core_stq_full_2),
    .io_core_stq_full_3                      (_lsu_io_core_stq_full_3),
    .io_core_fp_stdata_ready                 (_lsu_io_core_fp_stdata_ready),
    .io_core_clr_bsy_0_valid                 (_lsu_io_core_clr_bsy_0_valid),
    .io_core_clr_bsy_0_bits                  (_lsu_io_core_clr_bsy_0_bits),
    .io_core_clr_bsy_1_valid                 (_lsu_io_core_clr_bsy_1_valid),
    .io_core_clr_bsy_1_bits                  (_lsu_io_core_clr_bsy_1_bits),
    .io_core_clr_bsy_2_valid                 (_lsu_io_core_clr_bsy_2_valid),
    .io_core_clr_bsy_2_bits                  (_lsu_io_core_clr_bsy_2_bits),
    .io_core_spec_ld_wakeup_0_valid          (_lsu_io_core_spec_ld_wakeup_0_valid),
    .io_core_spec_ld_wakeup_0_bits           (_lsu_io_core_spec_ld_wakeup_0_bits),
    .io_core_spec_ld_wakeup_1_valid          (_lsu_io_core_spec_ld_wakeup_1_valid),
    .io_core_spec_ld_wakeup_1_bits           (_lsu_io_core_spec_ld_wakeup_1_bits),
    .io_core_ld_miss                         (_lsu_io_core_ld_miss),
    .io_core_fencei_rdy                      (_lsu_io_core_fencei_rdy),
    .io_core_lxcpt_valid                     (_lsu_io_core_lxcpt_valid),
    .io_core_lxcpt_bits_uop_br_mask          (_lsu_io_core_lxcpt_bits_uop_br_mask),
    .io_core_lxcpt_bits_uop_rob_idx          (_lsu_io_core_lxcpt_bits_uop_rob_idx),
    .io_core_lxcpt_bits_cause                (_lsu_io_core_lxcpt_bits_cause),
    .io_core_lxcpt_bits_badvaddr             (_lsu_io_core_lxcpt_bits_badvaddr),
    .io_dmem_req_valid                       (_lsu_io_dmem_req_valid),
    .io_dmem_req_bits_0_valid                (_lsu_io_dmem_req_bits_0_valid),
    .io_dmem_req_bits_0_bits_uop_br_mask     (_lsu_io_dmem_req_bits_0_bits_uop_br_mask),
    .io_dmem_req_bits_0_bits_uop_ldq_idx     (_lsu_io_dmem_req_bits_0_bits_uop_ldq_idx),
    .io_dmem_req_bits_0_bits_uop_stq_idx     (_lsu_io_dmem_req_bits_0_bits_uop_stq_idx),
    .io_dmem_req_bits_0_bits_uop_mem_cmd     (_lsu_io_dmem_req_bits_0_bits_uop_mem_cmd),
    .io_dmem_req_bits_0_bits_uop_mem_size    (_lsu_io_dmem_req_bits_0_bits_uop_mem_size),
    .io_dmem_req_bits_0_bits_uop_mem_signed  (_lsu_io_dmem_req_bits_0_bits_uop_mem_signed),
    .io_dmem_req_bits_0_bits_uop_is_amo      (_lsu_io_dmem_req_bits_0_bits_uop_is_amo),
    .io_dmem_req_bits_0_bits_uop_uses_ldq    (_lsu_io_dmem_req_bits_0_bits_uop_uses_ldq),
    .io_dmem_req_bits_0_bits_uop_uses_stq    (_lsu_io_dmem_req_bits_0_bits_uop_uses_stq),
    .io_dmem_req_bits_0_bits_addr            (_lsu_io_dmem_req_bits_0_bits_addr),
    .io_dmem_req_bits_0_bits_data            (_lsu_io_dmem_req_bits_0_bits_data),
    .io_dmem_req_bits_1_valid                (_lsu_io_dmem_req_bits_1_valid),
    .io_dmem_req_bits_1_bits_uop_br_mask     (_lsu_io_dmem_req_bits_1_bits_uop_br_mask),
    .io_dmem_req_bits_1_bits_uop_ldq_idx     (_lsu_io_dmem_req_bits_1_bits_uop_ldq_idx),
    .io_dmem_req_bits_1_bits_uop_stq_idx     (_lsu_io_dmem_req_bits_1_bits_uop_stq_idx),
    .io_dmem_req_bits_1_bits_uop_mem_cmd     (_lsu_io_dmem_req_bits_1_bits_uop_mem_cmd),
    .io_dmem_req_bits_1_bits_uop_mem_size    (_lsu_io_dmem_req_bits_1_bits_uop_mem_size),
    .io_dmem_req_bits_1_bits_uop_mem_signed  (_lsu_io_dmem_req_bits_1_bits_uop_mem_signed),
    .io_dmem_req_bits_1_bits_uop_is_amo      (_lsu_io_dmem_req_bits_1_bits_uop_is_amo),
    .io_dmem_req_bits_1_bits_uop_uses_ldq    (_lsu_io_dmem_req_bits_1_bits_uop_uses_ldq),
    .io_dmem_req_bits_1_bits_uop_uses_stq    (_lsu_io_dmem_req_bits_1_bits_uop_uses_stq),
    .io_dmem_req_bits_1_bits_addr            (_lsu_io_dmem_req_bits_1_bits_addr),
    .io_dmem_req_bits_1_bits_data            (_lsu_io_dmem_req_bits_1_bits_data),
    .io_dmem_req_bits_1_bits_is_hella        (_lsu_io_dmem_req_bits_1_bits_is_hella),
    .io_dmem_s1_kill_0                       (_lsu_io_dmem_s1_kill_0),
    .io_dmem_s1_kill_1                       (_lsu_io_dmem_s1_kill_1),
    .io_dmem_brupdate_b1_resolve_mask        (_lsu_io_dmem_brupdate_b1_resolve_mask),
    .io_dmem_brupdate_b1_mispredict_mask     (_lsu_io_dmem_brupdate_b1_mispredict_mask),
    .io_dmem_exception                       (_lsu_io_dmem_exception),
    .io_dmem_release_ready                   (_lsu_io_dmem_release_ready),
    .io_dmem_force_order                     (_lsu_io_dmem_force_order),
    .io_hellacache_req_ready                 (_lsu_io_hellacache_req_ready),
    .io_hellacache_s2_nack                   (_lsu_io_hellacache_s2_nack),
    .io_hellacache_resp_valid                (_lsu_io_hellacache_resp_valid),
    .io_hellacache_resp_bits_data            (_lsu_io_hellacache_resp_bits_data),
    .io_hellacache_s2_xcpt_ae_ld             (_lsu_io_hellacache_s2_xcpt_ae_ld)
  );
  PTW ptw (
    .clock                                 (clock),
    .reset                                 (reset),
    .io_requestor_0_req_valid              (_lsu_io_ptw_req_valid),
    .io_requestor_0_req_bits_valid         (_lsu_io_ptw_req_bits_valid),
    .io_requestor_0_req_bits_bits_addr     (_lsu_io_ptw_req_bits_bits_addr),
    .io_requestor_1_req_valid              (_frontend_io_ptw_req_valid),
    .io_requestor_1_req_bits_bits_addr     (_frontend_io_ptw_req_bits_bits_addr),
    .io_requestor_1_req_bits_bits_need_gpa (_frontend_io_ptw_req_bits_bits_need_gpa),
    .io_requestor_1_req_bits_bits_vstage1  (_frontend_io_ptw_req_bits_bits_vstage1),
    .io_requestor_1_req_bits_bits_stage2   (_frontend_io_ptw_req_bits_bits_stage2),
    .io_mem_req_ready                      (_hellaCacheArb_io_requestor_0_req_ready),
    .io_mem_s2_nack                        (_hellaCacheArb_io_requestor_0_s2_nack),
    .io_mem_resp_valid                     (_hellaCacheArb_io_requestor_0_resp_valid),
    .io_mem_resp_bits_data                 (_hellaCacheArb_io_requestor_0_resp_bits_data),
    .io_mem_s2_xcpt_ae_ld                  (_hellaCacheArb_io_requestor_0_s2_xcpt_ae_ld),
    .io_dpath_ptbr_mode                    (_core_io_ptw_ptbr_mode),
    .io_dpath_ptbr_ppn                     (_core_io_ptw_ptbr_ppn),
    .io_dpath_sfence_valid                 (_core_io_ptw_sfence_valid),
    .io_dpath_sfence_bits_rs1              (_core_io_ptw_sfence_bits_rs1),
    .io_dpath_sfence_bits_rs2              (_core_io_ptw_sfence_bits_rs2),
    .io_dpath_sfence_bits_addr             (_core_io_ptw_sfence_bits_addr),
    .io_dpath_status_debug                 (_core_io_ptw_status_debug),
    .io_dpath_status_dprv                  (_core_io_ptw_status_dprv),
    .io_dpath_status_prv                   (_core_io_ptw_status_prv),
    .io_dpath_status_mxr                   (_core_io_ptw_status_mxr),
    .io_dpath_status_sum                   (_core_io_ptw_status_sum),
    .io_dpath_pmp_0_cfg_l                  (_core_io_ptw_pmp_0_cfg_l),
    .io_dpath_pmp_0_cfg_a                  (_core_io_ptw_pmp_0_cfg_a),
    .io_dpath_pmp_0_cfg_x                  (_core_io_ptw_pmp_0_cfg_x),
    .io_dpath_pmp_0_cfg_w                  (_core_io_ptw_pmp_0_cfg_w),
    .io_dpath_pmp_0_cfg_r                  (_core_io_ptw_pmp_0_cfg_r),
    .io_dpath_pmp_0_addr                   (_core_io_ptw_pmp_0_addr),
    .io_dpath_pmp_0_mask                   (_core_io_ptw_pmp_0_mask),
    .io_dpath_pmp_1_cfg_l                  (_core_io_ptw_pmp_1_cfg_l),
    .io_dpath_pmp_1_cfg_a                  (_core_io_ptw_pmp_1_cfg_a),
    .io_dpath_pmp_1_cfg_x                  (_core_io_ptw_pmp_1_cfg_x),
    .io_dpath_pmp_1_cfg_w                  (_core_io_ptw_pmp_1_cfg_w),
    .io_dpath_pmp_1_cfg_r                  (_core_io_ptw_pmp_1_cfg_r),
    .io_dpath_pmp_1_addr                   (_core_io_ptw_pmp_1_addr),
    .io_dpath_pmp_1_mask                   (_core_io_ptw_pmp_1_mask),
    .io_dpath_pmp_2_cfg_l                  (_core_io_ptw_pmp_2_cfg_l),
    .io_dpath_pmp_2_cfg_a                  (_core_io_ptw_pmp_2_cfg_a),
    .io_dpath_pmp_2_cfg_x                  (_core_io_ptw_pmp_2_cfg_x),
    .io_dpath_pmp_2_cfg_w                  (_core_io_ptw_pmp_2_cfg_w),
    .io_dpath_pmp_2_cfg_r                  (_core_io_ptw_pmp_2_cfg_r),
    .io_dpath_pmp_2_addr                   (_core_io_ptw_pmp_2_addr),
    .io_dpath_pmp_2_mask                   (_core_io_ptw_pmp_2_mask),
    .io_dpath_pmp_3_cfg_l                  (_core_io_ptw_pmp_3_cfg_l),
    .io_dpath_pmp_3_cfg_a                  (_core_io_ptw_pmp_3_cfg_a),
    .io_dpath_pmp_3_cfg_x                  (_core_io_ptw_pmp_3_cfg_x),
    .io_dpath_pmp_3_cfg_w                  (_core_io_ptw_pmp_3_cfg_w),
    .io_dpath_pmp_3_cfg_r                  (_core_io_ptw_pmp_3_cfg_r),
    .io_dpath_pmp_3_addr                   (_core_io_ptw_pmp_3_addr),
    .io_dpath_pmp_3_mask                   (_core_io_ptw_pmp_3_mask),
    .io_dpath_pmp_4_cfg_l                  (_core_io_ptw_pmp_4_cfg_l),
    .io_dpath_pmp_4_cfg_a                  (_core_io_ptw_pmp_4_cfg_a),
    .io_dpath_pmp_4_cfg_x                  (_core_io_ptw_pmp_4_cfg_x),
    .io_dpath_pmp_4_cfg_w                  (_core_io_ptw_pmp_4_cfg_w),
    .io_dpath_pmp_4_cfg_r                  (_core_io_ptw_pmp_4_cfg_r),
    .io_dpath_pmp_4_addr                   (_core_io_ptw_pmp_4_addr),
    .io_dpath_pmp_4_mask                   (_core_io_ptw_pmp_4_mask),
    .io_dpath_pmp_5_cfg_l                  (_core_io_ptw_pmp_5_cfg_l),
    .io_dpath_pmp_5_cfg_a                  (_core_io_ptw_pmp_5_cfg_a),
    .io_dpath_pmp_5_cfg_x                  (_core_io_ptw_pmp_5_cfg_x),
    .io_dpath_pmp_5_cfg_w                  (_core_io_ptw_pmp_5_cfg_w),
    .io_dpath_pmp_5_cfg_r                  (_core_io_ptw_pmp_5_cfg_r),
    .io_dpath_pmp_5_addr                   (_core_io_ptw_pmp_5_addr),
    .io_dpath_pmp_5_mask                   (_core_io_ptw_pmp_5_mask),
    .io_dpath_pmp_6_cfg_l                  (_core_io_ptw_pmp_6_cfg_l),
    .io_dpath_pmp_6_cfg_a                  (_core_io_ptw_pmp_6_cfg_a),
    .io_dpath_pmp_6_cfg_x                  (_core_io_ptw_pmp_6_cfg_x),
    .io_dpath_pmp_6_cfg_w                  (_core_io_ptw_pmp_6_cfg_w),
    .io_dpath_pmp_6_cfg_r                  (_core_io_ptw_pmp_6_cfg_r),
    .io_dpath_pmp_6_addr                   (_core_io_ptw_pmp_6_addr),
    .io_dpath_pmp_6_mask                   (_core_io_ptw_pmp_6_mask),
    .io_dpath_pmp_7_cfg_l                  (_core_io_ptw_pmp_7_cfg_l),
    .io_dpath_pmp_7_cfg_a                  (_core_io_ptw_pmp_7_cfg_a),
    .io_dpath_pmp_7_cfg_x                  (_core_io_ptw_pmp_7_cfg_x),
    .io_dpath_pmp_7_cfg_w                  (_core_io_ptw_pmp_7_cfg_w),
    .io_dpath_pmp_7_cfg_r                  (_core_io_ptw_pmp_7_cfg_r),
    .io_dpath_pmp_7_addr                   (_core_io_ptw_pmp_7_addr),
    .io_dpath_pmp_7_mask                   (_core_io_ptw_pmp_7_mask),
    .io_requestor_0_req_ready              (_ptw_io_requestor_0_req_ready),
    .io_requestor_0_resp_valid             (_ptw_io_requestor_0_resp_valid),
    .io_requestor_0_resp_bits_ae_final     (_ptw_io_requestor_0_resp_bits_ae_final),
    .io_requestor_0_resp_bits_pte_ppn      (_ptw_io_requestor_0_resp_bits_pte_ppn),
    .io_requestor_0_resp_bits_pte_d        (_ptw_io_requestor_0_resp_bits_pte_d),
    .io_requestor_0_resp_bits_pte_a        (_ptw_io_requestor_0_resp_bits_pte_a),
    .io_requestor_0_resp_bits_pte_g        (_ptw_io_requestor_0_resp_bits_pte_g),
    .io_requestor_0_resp_bits_pte_u        (_ptw_io_requestor_0_resp_bits_pte_u),
    .io_requestor_0_resp_bits_pte_x        (_ptw_io_requestor_0_resp_bits_pte_x),
    .io_requestor_0_resp_bits_pte_w        (_ptw_io_requestor_0_resp_bits_pte_w),
    .io_requestor_0_resp_bits_pte_r        (_ptw_io_requestor_0_resp_bits_pte_r),
    .io_requestor_0_resp_bits_pte_v        (_ptw_io_requestor_0_resp_bits_pte_v),
    .io_requestor_0_resp_bits_level        (_ptw_io_requestor_0_resp_bits_level),
    .io_requestor_0_resp_bits_homogeneous  (_ptw_io_requestor_0_resp_bits_homogeneous),
    .io_requestor_0_ptbr_mode              (_ptw_io_requestor_0_ptbr_mode),
    .io_requestor_0_status_dprv            (_ptw_io_requestor_0_status_dprv),
    .io_requestor_0_status_mxr             (_ptw_io_requestor_0_status_mxr),
    .io_requestor_0_status_sum             (_ptw_io_requestor_0_status_sum),
    .io_requestor_0_pmp_0_cfg_l            (_ptw_io_requestor_0_pmp_0_cfg_l),
    .io_requestor_0_pmp_0_cfg_a            (_ptw_io_requestor_0_pmp_0_cfg_a),
    .io_requestor_0_pmp_0_cfg_x            (_ptw_io_requestor_0_pmp_0_cfg_x),
    .io_requestor_0_pmp_0_cfg_w            (_ptw_io_requestor_0_pmp_0_cfg_w),
    .io_requestor_0_pmp_0_cfg_r            (_ptw_io_requestor_0_pmp_0_cfg_r),
    .io_requestor_0_pmp_0_addr             (_ptw_io_requestor_0_pmp_0_addr),
    .io_requestor_0_pmp_0_mask             (_ptw_io_requestor_0_pmp_0_mask),
    .io_requestor_0_pmp_1_cfg_l            (_ptw_io_requestor_0_pmp_1_cfg_l),
    .io_requestor_0_pmp_1_cfg_a            (_ptw_io_requestor_0_pmp_1_cfg_a),
    .io_requestor_0_pmp_1_cfg_x            (_ptw_io_requestor_0_pmp_1_cfg_x),
    .io_requestor_0_pmp_1_cfg_w            (_ptw_io_requestor_0_pmp_1_cfg_w),
    .io_requestor_0_pmp_1_cfg_r            (_ptw_io_requestor_0_pmp_1_cfg_r),
    .io_requestor_0_pmp_1_addr             (_ptw_io_requestor_0_pmp_1_addr),
    .io_requestor_0_pmp_1_mask             (_ptw_io_requestor_0_pmp_1_mask),
    .io_requestor_0_pmp_2_cfg_l            (_ptw_io_requestor_0_pmp_2_cfg_l),
    .io_requestor_0_pmp_2_cfg_a            (_ptw_io_requestor_0_pmp_2_cfg_a),
    .io_requestor_0_pmp_2_cfg_x            (_ptw_io_requestor_0_pmp_2_cfg_x),
    .io_requestor_0_pmp_2_cfg_w            (_ptw_io_requestor_0_pmp_2_cfg_w),
    .io_requestor_0_pmp_2_cfg_r            (_ptw_io_requestor_0_pmp_2_cfg_r),
    .io_requestor_0_pmp_2_addr             (_ptw_io_requestor_0_pmp_2_addr),
    .io_requestor_0_pmp_2_mask             (_ptw_io_requestor_0_pmp_2_mask),
    .io_requestor_0_pmp_3_cfg_l            (_ptw_io_requestor_0_pmp_3_cfg_l),
    .io_requestor_0_pmp_3_cfg_a            (_ptw_io_requestor_0_pmp_3_cfg_a),
    .io_requestor_0_pmp_3_cfg_x            (_ptw_io_requestor_0_pmp_3_cfg_x),
    .io_requestor_0_pmp_3_cfg_w            (_ptw_io_requestor_0_pmp_3_cfg_w),
    .io_requestor_0_pmp_3_cfg_r            (_ptw_io_requestor_0_pmp_3_cfg_r),
    .io_requestor_0_pmp_3_addr             (_ptw_io_requestor_0_pmp_3_addr),
    .io_requestor_0_pmp_3_mask             (_ptw_io_requestor_0_pmp_3_mask),
    .io_requestor_0_pmp_4_cfg_l            (_ptw_io_requestor_0_pmp_4_cfg_l),
    .io_requestor_0_pmp_4_cfg_a            (_ptw_io_requestor_0_pmp_4_cfg_a),
    .io_requestor_0_pmp_4_cfg_x            (_ptw_io_requestor_0_pmp_4_cfg_x),
    .io_requestor_0_pmp_4_cfg_w            (_ptw_io_requestor_0_pmp_4_cfg_w),
    .io_requestor_0_pmp_4_cfg_r            (_ptw_io_requestor_0_pmp_4_cfg_r),
    .io_requestor_0_pmp_4_addr             (_ptw_io_requestor_0_pmp_4_addr),
    .io_requestor_0_pmp_4_mask             (_ptw_io_requestor_0_pmp_4_mask),
    .io_requestor_0_pmp_5_cfg_l            (_ptw_io_requestor_0_pmp_5_cfg_l),
    .io_requestor_0_pmp_5_cfg_a            (_ptw_io_requestor_0_pmp_5_cfg_a),
    .io_requestor_0_pmp_5_cfg_x            (_ptw_io_requestor_0_pmp_5_cfg_x),
    .io_requestor_0_pmp_5_cfg_w            (_ptw_io_requestor_0_pmp_5_cfg_w),
    .io_requestor_0_pmp_5_cfg_r            (_ptw_io_requestor_0_pmp_5_cfg_r),
    .io_requestor_0_pmp_5_addr             (_ptw_io_requestor_0_pmp_5_addr),
    .io_requestor_0_pmp_5_mask             (_ptw_io_requestor_0_pmp_5_mask),
    .io_requestor_0_pmp_6_cfg_l            (_ptw_io_requestor_0_pmp_6_cfg_l),
    .io_requestor_0_pmp_6_cfg_a            (_ptw_io_requestor_0_pmp_6_cfg_a),
    .io_requestor_0_pmp_6_cfg_x            (_ptw_io_requestor_0_pmp_6_cfg_x),
    .io_requestor_0_pmp_6_cfg_w            (_ptw_io_requestor_0_pmp_6_cfg_w),
    .io_requestor_0_pmp_6_cfg_r            (_ptw_io_requestor_0_pmp_6_cfg_r),
    .io_requestor_0_pmp_6_addr             (_ptw_io_requestor_0_pmp_6_addr),
    .io_requestor_0_pmp_6_mask             (_ptw_io_requestor_0_pmp_6_mask),
    .io_requestor_0_pmp_7_cfg_l            (_ptw_io_requestor_0_pmp_7_cfg_l),
    .io_requestor_0_pmp_7_cfg_a            (_ptw_io_requestor_0_pmp_7_cfg_a),
    .io_requestor_0_pmp_7_cfg_x            (_ptw_io_requestor_0_pmp_7_cfg_x),
    .io_requestor_0_pmp_7_cfg_w            (_ptw_io_requestor_0_pmp_7_cfg_w),
    .io_requestor_0_pmp_7_cfg_r            (_ptw_io_requestor_0_pmp_7_cfg_r),
    .io_requestor_0_pmp_7_addr             (_ptw_io_requestor_0_pmp_7_addr),
    .io_requestor_0_pmp_7_mask             (_ptw_io_requestor_0_pmp_7_mask),
    .io_requestor_1_req_ready              (_ptw_io_requestor_1_req_ready),
    .io_requestor_1_resp_valid             (_ptw_io_requestor_1_resp_valid),
    .io_requestor_1_resp_bits_ae_ptw       (_ptw_io_requestor_1_resp_bits_ae_ptw),
    .io_requestor_1_resp_bits_ae_final     (_ptw_io_requestor_1_resp_bits_ae_final),
    .io_requestor_1_resp_bits_pf           (_ptw_io_requestor_1_resp_bits_pf),
    .io_requestor_1_resp_bits_gf           (_ptw_io_requestor_1_resp_bits_gf),
    .io_requestor_1_resp_bits_hr           (_ptw_io_requestor_1_resp_bits_hr),
    .io_requestor_1_resp_bits_hw           (_ptw_io_requestor_1_resp_bits_hw),
    .io_requestor_1_resp_bits_hx           (_ptw_io_requestor_1_resp_bits_hx),
    .io_requestor_1_resp_bits_pte_ppn      (_ptw_io_requestor_1_resp_bits_pte_ppn),
    .io_requestor_1_resp_bits_pte_d        (_ptw_io_requestor_1_resp_bits_pte_d),
    .io_requestor_1_resp_bits_pte_a        (_ptw_io_requestor_1_resp_bits_pte_a),
    .io_requestor_1_resp_bits_pte_g        (_ptw_io_requestor_1_resp_bits_pte_g),
    .io_requestor_1_resp_bits_pte_u        (_ptw_io_requestor_1_resp_bits_pte_u),
    .io_requestor_1_resp_bits_pte_x        (_ptw_io_requestor_1_resp_bits_pte_x),
    .io_requestor_1_resp_bits_pte_w        (_ptw_io_requestor_1_resp_bits_pte_w),
    .io_requestor_1_resp_bits_pte_r        (_ptw_io_requestor_1_resp_bits_pte_r),
    .io_requestor_1_resp_bits_pte_v        (_ptw_io_requestor_1_resp_bits_pte_v),
    .io_requestor_1_resp_bits_level        (_ptw_io_requestor_1_resp_bits_level),
    .io_requestor_1_resp_bits_homogeneous  (_ptw_io_requestor_1_resp_bits_homogeneous),
    .io_requestor_1_resp_bits_gpa_is_pte   (_ptw_io_requestor_1_resp_bits_gpa_is_pte),
    .io_requestor_1_ptbr_mode              (_ptw_io_requestor_1_ptbr_mode),
    .io_requestor_1_status_debug           (_ptw_io_requestor_1_status_debug),
    .io_requestor_1_status_prv             (_ptw_io_requestor_1_status_prv),
    .io_requestor_1_pmp_0_cfg_l            (_ptw_io_requestor_1_pmp_0_cfg_l),
    .io_requestor_1_pmp_0_cfg_a            (_ptw_io_requestor_1_pmp_0_cfg_a),
    .io_requestor_1_pmp_0_cfg_x            (_ptw_io_requestor_1_pmp_0_cfg_x),
    .io_requestor_1_pmp_0_cfg_w            (_ptw_io_requestor_1_pmp_0_cfg_w),
    .io_requestor_1_pmp_0_cfg_r            (_ptw_io_requestor_1_pmp_0_cfg_r),
    .io_requestor_1_pmp_0_addr             (_ptw_io_requestor_1_pmp_0_addr),
    .io_requestor_1_pmp_0_mask             (_ptw_io_requestor_1_pmp_0_mask),
    .io_requestor_1_pmp_1_cfg_l            (_ptw_io_requestor_1_pmp_1_cfg_l),
    .io_requestor_1_pmp_1_cfg_a            (_ptw_io_requestor_1_pmp_1_cfg_a),
    .io_requestor_1_pmp_1_cfg_x            (_ptw_io_requestor_1_pmp_1_cfg_x),
    .io_requestor_1_pmp_1_cfg_w            (_ptw_io_requestor_1_pmp_1_cfg_w),
    .io_requestor_1_pmp_1_cfg_r            (_ptw_io_requestor_1_pmp_1_cfg_r),
    .io_requestor_1_pmp_1_addr             (_ptw_io_requestor_1_pmp_1_addr),
    .io_requestor_1_pmp_1_mask             (_ptw_io_requestor_1_pmp_1_mask),
    .io_requestor_1_pmp_2_cfg_l            (_ptw_io_requestor_1_pmp_2_cfg_l),
    .io_requestor_1_pmp_2_cfg_a            (_ptw_io_requestor_1_pmp_2_cfg_a),
    .io_requestor_1_pmp_2_cfg_x            (_ptw_io_requestor_1_pmp_2_cfg_x),
    .io_requestor_1_pmp_2_cfg_w            (_ptw_io_requestor_1_pmp_2_cfg_w),
    .io_requestor_1_pmp_2_cfg_r            (_ptw_io_requestor_1_pmp_2_cfg_r),
    .io_requestor_1_pmp_2_addr             (_ptw_io_requestor_1_pmp_2_addr),
    .io_requestor_1_pmp_2_mask             (_ptw_io_requestor_1_pmp_2_mask),
    .io_requestor_1_pmp_3_cfg_l            (_ptw_io_requestor_1_pmp_3_cfg_l),
    .io_requestor_1_pmp_3_cfg_a            (_ptw_io_requestor_1_pmp_3_cfg_a),
    .io_requestor_1_pmp_3_cfg_x            (_ptw_io_requestor_1_pmp_3_cfg_x),
    .io_requestor_1_pmp_3_cfg_w            (_ptw_io_requestor_1_pmp_3_cfg_w),
    .io_requestor_1_pmp_3_cfg_r            (_ptw_io_requestor_1_pmp_3_cfg_r),
    .io_requestor_1_pmp_3_addr             (_ptw_io_requestor_1_pmp_3_addr),
    .io_requestor_1_pmp_3_mask             (_ptw_io_requestor_1_pmp_3_mask),
    .io_requestor_1_pmp_4_cfg_l            (_ptw_io_requestor_1_pmp_4_cfg_l),
    .io_requestor_1_pmp_4_cfg_a            (_ptw_io_requestor_1_pmp_4_cfg_a),
    .io_requestor_1_pmp_4_cfg_x            (_ptw_io_requestor_1_pmp_4_cfg_x),
    .io_requestor_1_pmp_4_cfg_w            (_ptw_io_requestor_1_pmp_4_cfg_w),
    .io_requestor_1_pmp_4_cfg_r            (_ptw_io_requestor_1_pmp_4_cfg_r),
    .io_requestor_1_pmp_4_addr             (_ptw_io_requestor_1_pmp_4_addr),
    .io_requestor_1_pmp_4_mask             (_ptw_io_requestor_1_pmp_4_mask),
    .io_requestor_1_pmp_5_cfg_l            (_ptw_io_requestor_1_pmp_5_cfg_l),
    .io_requestor_1_pmp_5_cfg_a            (_ptw_io_requestor_1_pmp_5_cfg_a),
    .io_requestor_1_pmp_5_cfg_x            (_ptw_io_requestor_1_pmp_5_cfg_x),
    .io_requestor_1_pmp_5_cfg_w            (_ptw_io_requestor_1_pmp_5_cfg_w),
    .io_requestor_1_pmp_5_cfg_r            (_ptw_io_requestor_1_pmp_5_cfg_r),
    .io_requestor_1_pmp_5_addr             (_ptw_io_requestor_1_pmp_5_addr),
    .io_requestor_1_pmp_5_mask             (_ptw_io_requestor_1_pmp_5_mask),
    .io_requestor_1_pmp_6_cfg_l            (_ptw_io_requestor_1_pmp_6_cfg_l),
    .io_requestor_1_pmp_6_cfg_a            (_ptw_io_requestor_1_pmp_6_cfg_a),
    .io_requestor_1_pmp_6_cfg_x            (_ptw_io_requestor_1_pmp_6_cfg_x),
    .io_requestor_1_pmp_6_cfg_w            (_ptw_io_requestor_1_pmp_6_cfg_w),
    .io_requestor_1_pmp_6_cfg_r            (_ptw_io_requestor_1_pmp_6_cfg_r),
    .io_requestor_1_pmp_6_addr             (_ptw_io_requestor_1_pmp_6_addr),
    .io_requestor_1_pmp_6_mask             (_ptw_io_requestor_1_pmp_6_mask),
    .io_requestor_1_pmp_7_cfg_l            (_ptw_io_requestor_1_pmp_7_cfg_l),
    .io_requestor_1_pmp_7_cfg_a            (_ptw_io_requestor_1_pmp_7_cfg_a),
    .io_requestor_1_pmp_7_cfg_x            (_ptw_io_requestor_1_pmp_7_cfg_x),
    .io_requestor_1_pmp_7_cfg_w            (_ptw_io_requestor_1_pmp_7_cfg_w),
    .io_requestor_1_pmp_7_cfg_r            (_ptw_io_requestor_1_pmp_7_cfg_r),
    .io_requestor_1_pmp_7_addr             (_ptw_io_requestor_1_pmp_7_addr),
    .io_requestor_1_pmp_7_mask             (_ptw_io_requestor_1_pmp_7_mask),
    .io_mem_req_valid                      (_ptw_io_mem_req_valid),
    .io_mem_req_bits_addr                  (_ptw_io_mem_req_bits_addr),
    .io_mem_s1_kill                        (_ptw_io_mem_s1_kill)
  );
  HellaCacheArbiter hellaCacheArb (
    .io_requestor_0_req_valid      (_ptw_io_mem_req_valid),
    .io_requestor_0_req_bits_addr  (_ptw_io_mem_req_bits_addr),
    .io_requestor_0_s1_kill        (_ptw_io_mem_s1_kill),
    .io_mem_req_ready              (_lsu_io_hellacache_req_ready),
    .io_mem_s2_nack                (_lsu_io_hellacache_s2_nack),
    .io_mem_resp_valid             (_lsu_io_hellacache_resp_valid),
    .io_mem_resp_bits_data         (_lsu_io_hellacache_resp_bits_data),
    .io_mem_s2_xcpt_ae_ld          (_lsu_io_hellacache_s2_xcpt_ae_ld),
    .io_requestor_0_req_ready      (_hellaCacheArb_io_requestor_0_req_ready),
    .io_requestor_0_s2_nack        (_hellaCacheArb_io_requestor_0_s2_nack),
    .io_requestor_0_resp_valid     (_hellaCacheArb_io_requestor_0_resp_valid),
    .io_requestor_0_resp_bits_data (_hellaCacheArb_io_requestor_0_resp_bits_data),
    .io_requestor_0_s2_xcpt_ae_ld  (_hellaCacheArb_io_requestor_0_s2_xcpt_ae_ld),
    .io_mem_req_valid              (_hellaCacheArb_io_mem_req_valid),
    .io_mem_req_bits_addr          (_hellaCacheArb_io_mem_req_bits_addr),
    .io_mem_s1_kill                (_hellaCacheArb_io_mem_s1_kill)
  );
endmodule

