// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLB(
  input         clock,
                reset,
                io_req_valid,
  input  [39:0] io_req_bits_vaddr,
  input  [1:0]  io_req_bits_prv,
  input         io_sfence_valid,
                io_sfence_bits_rs1,
                io_sfence_bits_rs2,
  input  [38:0] io_sfence_bits_addr,
  input         io_ptw_req_ready,
                io_ptw_resp_valid,
                io_ptw_resp_bits_ae_ptw,
                io_ptw_resp_bits_ae_final,
                io_ptw_resp_bits_pf,
                io_ptw_resp_bits_gf,
                io_ptw_resp_bits_hr,
                io_ptw_resp_bits_hw,
                io_ptw_resp_bits_hx,
  input  [43:0] io_ptw_resp_bits_pte_ppn,
  input         io_ptw_resp_bits_pte_d,
                io_ptw_resp_bits_pte_a,
                io_ptw_resp_bits_pte_g,
                io_ptw_resp_bits_pte_u,
                io_ptw_resp_bits_pte_x,
                io_ptw_resp_bits_pte_w,
                io_ptw_resp_bits_pte_r,
                io_ptw_resp_bits_pte_v,
  input  [1:0]  io_ptw_resp_bits_level,
  input         io_ptw_resp_bits_homogeneous,
                io_ptw_resp_bits_gpa_is_pte,
  input  [3:0]  io_ptw_ptbr_mode,
  input         io_ptw_status_debug,
                io_ptw_pmp_0_cfg_l,
  input  [1:0]  io_ptw_pmp_0_cfg_a,
  input         io_ptw_pmp_0_cfg_x,
                io_ptw_pmp_0_cfg_w,
                io_ptw_pmp_0_cfg_r,
  input  [29:0] io_ptw_pmp_0_addr,
  input  [31:0] io_ptw_pmp_0_mask,
  input         io_ptw_pmp_1_cfg_l,
  input  [1:0]  io_ptw_pmp_1_cfg_a,
  input         io_ptw_pmp_1_cfg_x,
                io_ptw_pmp_1_cfg_w,
                io_ptw_pmp_1_cfg_r,
  input  [29:0] io_ptw_pmp_1_addr,
  input  [31:0] io_ptw_pmp_1_mask,
  input         io_ptw_pmp_2_cfg_l,
  input  [1:0]  io_ptw_pmp_2_cfg_a,
  input         io_ptw_pmp_2_cfg_x,
                io_ptw_pmp_2_cfg_w,
                io_ptw_pmp_2_cfg_r,
  input  [29:0] io_ptw_pmp_2_addr,
  input  [31:0] io_ptw_pmp_2_mask,
  input         io_ptw_pmp_3_cfg_l,
  input  [1:0]  io_ptw_pmp_3_cfg_a,
  input         io_ptw_pmp_3_cfg_x,
                io_ptw_pmp_3_cfg_w,
                io_ptw_pmp_3_cfg_r,
  input  [29:0] io_ptw_pmp_3_addr,
  input  [31:0] io_ptw_pmp_3_mask,
  input         io_ptw_pmp_4_cfg_l,
  input  [1:0]  io_ptw_pmp_4_cfg_a,
  input         io_ptw_pmp_4_cfg_x,
                io_ptw_pmp_4_cfg_w,
                io_ptw_pmp_4_cfg_r,
  input  [29:0] io_ptw_pmp_4_addr,
  input  [31:0] io_ptw_pmp_4_mask,
  input         io_ptw_pmp_5_cfg_l,
  input  [1:0]  io_ptw_pmp_5_cfg_a,
  input         io_ptw_pmp_5_cfg_x,
                io_ptw_pmp_5_cfg_w,
                io_ptw_pmp_5_cfg_r,
  input  [29:0] io_ptw_pmp_5_addr,
  input  [31:0] io_ptw_pmp_5_mask,
  input         io_ptw_pmp_6_cfg_l,
  input  [1:0]  io_ptw_pmp_6_cfg_a,
  input         io_ptw_pmp_6_cfg_x,
                io_ptw_pmp_6_cfg_w,
                io_ptw_pmp_6_cfg_r,
  input  [29:0] io_ptw_pmp_6_addr,
  input  [31:0] io_ptw_pmp_6_mask,
  input         io_ptw_pmp_7_cfg_l,
  input  [1:0]  io_ptw_pmp_7_cfg_a,
  input         io_ptw_pmp_7_cfg_x,
                io_ptw_pmp_7_cfg_w,
                io_ptw_pmp_7_cfg_r,
  input  [29:0] io_ptw_pmp_7_addr,
  input  [31:0] io_ptw_pmp_7_mask,
  output        io_resp_miss,
  output [31:0] io_resp_paddr,
  output        io_resp_pf_inst,
                io_resp_ae_inst,
                io_ptw_req_valid,
  output [26:0] io_ptw_req_bits_bits_addr,
  output        io_ptw_req_bits_bits_need_gpa,
                io_ptw_req_bits_bits_vstage1,
                io_ptw_req_bits_bits_stage2
);

  wire [19:0] _entries_barrier_12_io_y_ppn;
  wire        _entries_barrier_12_io_y_u;
  wire        _entries_barrier_12_io_y_ae_ptw;
  wire        _entries_barrier_12_io_y_ae_final;
  wire        _entries_barrier_12_io_y_pf;
  wire        _entries_barrier_12_io_y_gf;
  wire        _entries_barrier_12_io_y_sx;
  wire [19:0] _entries_barrier_11_io_y_ppn;
  wire        _entries_barrier_11_io_y_u;
  wire        _entries_barrier_11_io_y_ae_ptw;
  wire        _entries_barrier_11_io_y_ae_final;
  wire        _entries_barrier_11_io_y_pf;
  wire        _entries_barrier_11_io_y_gf;
  wire        _entries_barrier_11_io_y_sx;
  wire        _entries_barrier_11_io_y_px;
  wire [19:0] _entries_barrier_10_io_y_ppn;
  wire        _entries_barrier_10_io_y_u;
  wire        _entries_barrier_10_io_y_ae_ptw;
  wire        _entries_barrier_10_io_y_ae_final;
  wire        _entries_barrier_10_io_y_pf;
  wire        _entries_barrier_10_io_y_gf;
  wire        _entries_barrier_10_io_y_sx;
  wire        _entries_barrier_10_io_y_px;
  wire [19:0] _entries_barrier_9_io_y_ppn;
  wire        _entries_barrier_9_io_y_u;
  wire        _entries_barrier_9_io_y_ae_ptw;
  wire        _entries_barrier_9_io_y_ae_final;
  wire        _entries_barrier_9_io_y_pf;
  wire        _entries_barrier_9_io_y_gf;
  wire        _entries_barrier_9_io_y_sx;
  wire        _entries_barrier_9_io_y_px;
  wire [19:0] _entries_barrier_8_io_y_ppn;
  wire        _entries_barrier_8_io_y_u;
  wire        _entries_barrier_8_io_y_ae_ptw;
  wire        _entries_barrier_8_io_y_ae_final;
  wire        _entries_barrier_8_io_y_pf;
  wire        _entries_barrier_8_io_y_gf;
  wire        _entries_barrier_8_io_y_sx;
  wire        _entries_barrier_8_io_y_px;
  wire [19:0] _entries_barrier_7_io_y_ppn;
  wire        _entries_barrier_7_io_y_u;
  wire        _entries_barrier_7_io_y_ae_ptw;
  wire        _entries_barrier_7_io_y_ae_final;
  wire        _entries_barrier_7_io_y_pf;
  wire        _entries_barrier_7_io_y_gf;
  wire        _entries_barrier_7_io_y_sx;
  wire        _entries_barrier_7_io_y_px;
  wire [19:0] _entries_barrier_6_io_y_ppn;
  wire        _entries_barrier_6_io_y_u;
  wire        _entries_barrier_6_io_y_ae_ptw;
  wire        _entries_barrier_6_io_y_ae_final;
  wire        _entries_barrier_6_io_y_pf;
  wire        _entries_barrier_6_io_y_gf;
  wire        _entries_barrier_6_io_y_sx;
  wire        _entries_barrier_6_io_y_px;
  wire [19:0] _entries_barrier_5_io_y_ppn;
  wire        _entries_barrier_5_io_y_u;
  wire        _entries_barrier_5_io_y_ae_ptw;
  wire        _entries_barrier_5_io_y_ae_final;
  wire        _entries_barrier_5_io_y_pf;
  wire        _entries_barrier_5_io_y_gf;
  wire        _entries_barrier_5_io_y_sx;
  wire        _entries_barrier_5_io_y_px;
  wire [19:0] _entries_barrier_4_io_y_ppn;
  wire        _entries_barrier_4_io_y_u;
  wire        _entries_barrier_4_io_y_ae_ptw;
  wire        _entries_barrier_4_io_y_ae_final;
  wire        _entries_barrier_4_io_y_pf;
  wire        _entries_barrier_4_io_y_gf;
  wire        _entries_barrier_4_io_y_sx;
  wire        _entries_barrier_4_io_y_px;
  wire [19:0] _entries_barrier_3_io_y_ppn;
  wire        _entries_barrier_3_io_y_u;
  wire        _entries_barrier_3_io_y_ae_ptw;
  wire        _entries_barrier_3_io_y_ae_final;
  wire        _entries_barrier_3_io_y_pf;
  wire        _entries_barrier_3_io_y_gf;
  wire        _entries_barrier_3_io_y_sx;
  wire        _entries_barrier_3_io_y_px;
  wire [19:0] _entries_barrier_2_io_y_ppn;
  wire        _entries_barrier_2_io_y_u;
  wire        _entries_barrier_2_io_y_ae_ptw;
  wire        _entries_barrier_2_io_y_ae_final;
  wire        _entries_barrier_2_io_y_pf;
  wire        _entries_barrier_2_io_y_gf;
  wire        _entries_barrier_2_io_y_sx;
  wire        _entries_barrier_2_io_y_px;
  wire [19:0] _entries_barrier_1_io_y_ppn;
  wire        _entries_barrier_1_io_y_u;
  wire        _entries_barrier_1_io_y_ae_ptw;
  wire        _entries_barrier_1_io_y_ae_final;
  wire        _entries_barrier_1_io_y_pf;
  wire        _entries_barrier_1_io_y_gf;
  wire        _entries_barrier_1_io_y_sx;
  wire        _entries_barrier_1_io_y_px;
  wire [19:0] _entries_barrier_io_y_ppn;
  wire        _entries_barrier_io_y_u;
  wire        _entries_barrier_io_y_ae_ptw;
  wire        _entries_barrier_io_y_ae_final;
  wire        _entries_barrier_io_y_pf;
  wire        _entries_barrier_io_y_gf;
  wire        _entries_barrier_io_y_sx;
  wire        _entries_barrier_io_y_px;
  wire        _pmp_io_r;
  wire        _pmp_io_w;
  wire        _pmp_io_x;
  wire [19:0] _mpu_ppn_barrier_io_y_ppn;
  reg         casez_tmp;
  reg         casez_tmp_0;
  reg         casez_tmp_1;
  reg         casez_tmp_2;
  reg         casez_tmp_3;
  reg         casez_tmp_4;
  reg         casez_tmp_5;
  reg         casez_tmp_6;
  reg  [41:0] casez_tmp_7;
  reg  [41:0] casez_tmp_8;
  reg  [41:0] casez_tmp_9;
  reg  [41:0] casez_tmp_10;
  reg  [41:0] casez_tmp_11;
  reg  [41:0] casez_tmp_12;
  reg  [41:0] casez_tmp_13;
  reg  [41:0] casez_tmp_14;
  reg  [26:0] sectored_entries_0_0_tag_vpn;
  reg         sectored_entries_0_0_tag_v;
  reg  [41:0] sectored_entries_0_0_data_0;
  reg  [41:0] sectored_entries_0_0_data_1;
  reg  [41:0] sectored_entries_0_0_data_2;
  reg  [41:0] sectored_entries_0_0_data_3;
  reg         sectored_entries_0_0_valid_0;
  reg         sectored_entries_0_0_valid_1;
  reg         sectored_entries_0_0_valid_2;
  reg         sectored_entries_0_0_valid_3;
  reg  [26:0] sectored_entries_0_1_tag_vpn;
  reg         sectored_entries_0_1_tag_v;
  reg  [41:0] sectored_entries_0_1_data_0;
  reg  [41:0] sectored_entries_0_1_data_1;
  reg  [41:0] sectored_entries_0_1_data_2;
  reg  [41:0] sectored_entries_0_1_data_3;
  reg         sectored_entries_0_1_valid_0;
  reg         sectored_entries_0_1_valid_1;
  reg         sectored_entries_0_1_valid_2;
  reg         sectored_entries_0_1_valid_3;
  reg  [26:0] sectored_entries_0_2_tag_vpn;
  reg         sectored_entries_0_2_tag_v;
  reg  [41:0] sectored_entries_0_2_data_0;
  reg  [41:0] sectored_entries_0_2_data_1;
  reg  [41:0] sectored_entries_0_2_data_2;
  reg  [41:0] sectored_entries_0_2_data_3;
  reg         sectored_entries_0_2_valid_0;
  reg         sectored_entries_0_2_valid_1;
  reg         sectored_entries_0_2_valid_2;
  reg         sectored_entries_0_2_valid_3;
  reg  [26:0] sectored_entries_0_3_tag_vpn;
  reg         sectored_entries_0_3_tag_v;
  reg  [41:0] sectored_entries_0_3_data_0;
  reg  [41:0] sectored_entries_0_3_data_1;
  reg  [41:0] sectored_entries_0_3_data_2;
  reg  [41:0] sectored_entries_0_3_data_3;
  reg         sectored_entries_0_3_valid_0;
  reg         sectored_entries_0_3_valid_1;
  reg         sectored_entries_0_3_valid_2;
  reg         sectored_entries_0_3_valid_3;
  reg  [26:0] sectored_entries_0_4_tag_vpn;
  reg         sectored_entries_0_4_tag_v;
  reg  [41:0] sectored_entries_0_4_data_0;
  reg  [41:0] sectored_entries_0_4_data_1;
  reg  [41:0] sectored_entries_0_4_data_2;
  reg  [41:0] sectored_entries_0_4_data_3;
  reg         sectored_entries_0_4_valid_0;
  reg         sectored_entries_0_4_valid_1;
  reg         sectored_entries_0_4_valid_2;
  reg         sectored_entries_0_4_valid_3;
  reg  [26:0] sectored_entries_0_5_tag_vpn;
  reg         sectored_entries_0_5_tag_v;
  reg  [41:0] sectored_entries_0_5_data_0;
  reg  [41:0] sectored_entries_0_5_data_1;
  reg  [41:0] sectored_entries_0_5_data_2;
  reg  [41:0] sectored_entries_0_5_data_3;
  reg         sectored_entries_0_5_valid_0;
  reg         sectored_entries_0_5_valid_1;
  reg         sectored_entries_0_5_valid_2;
  reg         sectored_entries_0_5_valid_3;
  reg  [26:0] sectored_entries_0_6_tag_vpn;
  reg         sectored_entries_0_6_tag_v;
  reg  [41:0] sectored_entries_0_6_data_0;
  reg  [41:0] sectored_entries_0_6_data_1;
  reg  [41:0] sectored_entries_0_6_data_2;
  reg  [41:0] sectored_entries_0_6_data_3;
  reg         sectored_entries_0_6_valid_0;
  reg         sectored_entries_0_6_valid_1;
  reg         sectored_entries_0_6_valid_2;
  reg         sectored_entries_0_6_valid_3;
  reg  [26:0] sectored_entries_0_7_tag_vpn;
  reg         sectored_entries_0_7_tag_v;
  reg  [41:0] sectored_entries_0_7_data_0;
  reg  [41:0] sectored_entries_0_7_data_1;
  reg  [41:0] sectored_entries_0_7_data_2;
  reg  [41:0] sectored_entries_0_7_data_3;
  reg         sectored_entries_0_7_valid_0;
  reg         sectored_entries_0_7_valid_1;
  reg         sectored_entries_0_7_valid_2;
  reg         sectored_entries_0_7_valid_3;
  reg  [1:0]  superpage_entries_0_level;
  reg  [26:0] superpage_entries_0_tag_vpn;
  reg         superpage_entries_0_tag_v;
  reg  [41:0] superpage_entries_0_data_0;
  reg         superpage_entries_0_valid_0;
  reg  [1:0]  superpage_entries_1_level;
  reg  [26:0] superpage_entries_1_tag_vpn;
  reg         superpage_entries_1_tag_v;
  reg  [41:0] superpage_entries_1_data_0;
  reg         superpage_entries_1_valid_0;
  reg  [1:0]  superpage_entries_2_level;
  reg  [26:0] superpage_entries_2_tag_vpn;
  reg         superpage_entries_2_tag_v;
  reg  [41:0] superpage_entries_2_data_0;
  reg         superpage_entries_2_valid_0;
  reg  [1:0]  superpage_entries_3_level;
  reg  [26:0] superpage_entries_3_tag_vpn;
  reg         superpage_entries_3_tag_v;
  reg  [41:0] superpage_entries_3_data_0;
  reg         superpage_entries_3_valid_0;
  reg  [1:0]  special_entry_level;
  reg  [26:0] special_entry_tag_vpn;
  reg         special_entry_tag_v;
  reg  [41:0] special_entry_data_0;
  reg         special_entry_valid_0;
  reg  [1:0]  state;
  reg  [26:0] r_refill_tag;
  reg  [1:0]  waddr;
  reg  [2:0]  r_sectored_repl_addr;
  reg         r_sectored_hit_valid;
  reg  [2:0]  r_sectored_hit_bits;
  reg         r_vstage1_en;
  reg         r_stage2_en;
  reg         r_need_gpa;
  wire        _vm_enabled_T_1 = io_ptw_ptbr_mode[3] & ~(io_req_bits_prv[1]);
  wire        _io_ptw_req_valid_T = state == 2'h1;
  wire        ignore_13 = special_entry_level == 2'h0;
  wire [27:0] mpu_ppn = io_ptw_resp_valid ? {8'h0, io_ptw_resp_bits_pte_ppn[19:0]} : _vm_enabled_T_1 ? {8'h0, _mpu_ppn_barrier_io_y_ppn[19:18], (ignore_13 ? io_req_bits_vaddr[29:21] : 9'h0) | _mpu_ppn_barrier_io_y_ppn[17:9], (special_entry_level[1] ? 9'h0 : io_req_bits_vaddr[20:12]) | _mpu_ppn_barrier_io_y_ppn[8:0]} : io_req_bits_vaddr[39:12];
  wire [2:0]  mpu_priv = io_ptw_resp_valid ? 3'h1 : {io_ptw_status_debug, io_req_bits_prv};
  wire [13:0] _GEN = mpu_ppn[13:0] ^ 14'h2010;
  wire [9:0]  _GEN_0 = mpu_ppn[13:4] ^ 10'h200;
  wire [8:0]  _GEN_1 = mpu_ppn[8:0] ^ 9'h100;
  wire [3:0]  _GEN_2 = mpu_ppn[19:16] ^ 4'h8;
  wire        legal_address = {mpu_ppn[27:2], ~(mpu_ppn[1:0])} == 28'h0 | {mpu_ppn[27:14], _GEN} == 28'h0 | {mpu_ppn[27:3], mpu_ppn[2:0] ^ 3'h4} == 28'h0 | {mpu_ppn[27:17], mpu_ppn[16:0] ^ 17'h10020} == 28'h0 | {mpu_ppn[27:16], ~(mpu_ppn[15:14])} == 14'h0 | {mpu_ppn[27:14], _GEN_0} == 24'h0 | ~(|mpu_ppn) | {mpu_ppn[27:5], ~(mpu_ppn[4])} == 24'h0 | {mpu_ppn[27:9], _GEN_1} == 28'h0 | {mpu_ppn[27:9], mpu_ppn[8:0] ^ 9'h110} == 28'h0 | {mpu_ppn[27:20], _GEN_2} == 12'h0;
  wire        deny_access_to_debug = ~(mpu_priv[2]) & ~(|mpu_ppn);
  wire [1:0]  _GEN_3 = {_GEN_2[3], mpu_ppn[16]};
  wire        prot_x = legal_address & ({mpu_ppn[19], mpu_ppn[16:15], mpu_ppn[13], mpu_ppn[8], mpu_ppn[4], mpu_ppn[2]} == 7'h0 | {mpu_ppn[19], mpu_ppn[16:15], mpu_ppn[13], mpu_ppn[8], ~(mpu_ppn[4])} == 6'h0 | ~(|_GEN_3)) & ~deny_access_to_debug & _pmp_io_x;
  wire [24:0] _hitsVec_T = sectored_entries_0_0_tag_vpn[26:2] ^ io_req_bits_vaddr[38:14];
  wire [24:0] _hitsVec_T_6 = sectored_entries_0_1_tag_vpn[26:2] ^ io_req_bits_vaddr[38:14];
  wire [24:0] _hitsVec_T_12 = sectored_entries_0_2_tag_vpn[26:2] ^ io_req_bits_vaddr[38:14];
  wire [24:0] _hitsVec_T_18 = sectored_entries_0_3_tag_vpn[26:2] ^ io_req_bits_vaddr[38:14];
  wire [24:0] _hitsVec_T_24 = sectored_entries_0_4_tag_vpn[26:2] ^ io_req_bits_vaddr[38:14];
  wire [24:0] _hitsVec_T_30 = sectored_entries_0_5_tag_vpn[26:2] ^ io_req_bits_vaddr[38:14];
  wire [24:0] _hitsVec_T_36 = sectored_entries_0_6_tag_vpn[26:2] ^ io_req_bits_vaddr[38:14];
  wire [24:0] _hitsVec_T_42 = sectored_entries_0_7_tag_vpn[26:2] ^ io_req_bits_vaddr[38:14];
  wire [17:0] _hitsVec_T_58 = superpage_entries_0_tag_vpn[26:9] ^ io_req_bits_vaddr[38:21];
  wire        ignore_1 = superpage_entries_0_level == 2'h0;
  wire [17:0] _hitsVec_T_73 = superpage_entries_1_tag_vpn[26:9] ^ io_req_bits_vaddr[38:21];
  wire        ignore_4 = superpage_entries_1_level == 2'h0;
  wire [17:0] _hitsVec_T_88 = superpage_entries_2_tag_vpn[26:9] ^ io_req_bits_vaddr[38:21];
  wire        ignore_7 = superpage_entries_2_level == 2'h0;
  wire [17:0] _hitsVec_T_103 = superpage_entries_3_tag_vpn[26:9] ^ io_req_bits_vaddr[38:21];
  wire        ignore_10 = superpage_entries_3_level == 2'h0;
  always @(*) begin
    casez (io_req_bits_vaddr[13:12])
      2'b00:
        casez_tmp = sectored_entries_0_0_valid_0;
      2'b01:
        casez_tmp = sectored_entries_0_0_valid_1;
      2'b10:
        casez_tmp = sectored_entries_0_0_valid_2;
      default:
        casez_tmp = sectored_entries_0_0_valid_3;
    endcase
  end // always @(*)
  wire        hitsVec_0 = _vm_enabled_T_1 & casez_tmp & _hitsVec_T == 25'h0 & ~sectored_entries_0_0_tag_v;
  always @(*) begin
    casez (io_req_bits_vaddr[13:12])
      2'b00:
        casez_tmp_0 = sectored_entries_0_1_valid_0;
      2'b01:
        casez_tmp_0 = sectored_entries_0_1_valid_1;
      2'b10:
        casez_tmp_0 = sectored_entries_0_1_valid_2;
      default:
        casez_tmp_0 = sectored_entries_0_1_valid_3;
    endcase
  end // always @(*)
  wire        hitsVec_1 = _vm_enabled_T_1 & casez_tmp_0 & _hitsVec_T_6 == 25'h0 & ~sectored_entries_0_1_tag_v;
  always @(*) begin
    casez (io_req_bits_vaddr[13:12])
      2'b00:
        casez_tmp_1 = sectored_entries_0_2_valid_0;
      2'b01:
        casez_tmp_1 = sectored_entries_0_2_valid_1;
      2'b10:
        casez_tmp_1 = sectored_entries_0_2_valid_2;
      default:
        casez_tmp_1 = sectored_entries_0_2_valid_3;
    endcase
  end // always @(*)
  wire        hitsVec_2 = _vm_enabled_T_1 & casez_tmp_1 & _hitsVec_T_12 == 25'h0 & ~sectored_entries_0_2_tag_v;
  always @(*) begin
    casez (io_req_bits_vaddr[13:12])
      2'b00:
        casez_tmp_2 = sectored_entries_0_3_valid_0;
      2'b01:
        casez_tmp_2 = sectored_entries_0_3_valid_1;
      2'b10:
        casez_tmp_2 = sectored_entries_0_3_valid_2;
      default:
        casez_tmp_2 = sectored_entries_0_3_valid_3;
    endcase
  end // always @(*)
  wire        hitsVec_3 = _vm_enabled_T_1 & casez_tmp_2 & _hitsVec_T_18 == 25'h0 & ~sectored_entries_0_3_tag_v;
  always @(*) begin
    casez (io_req_bits_vaddr[13:12])
      2'b00:
        casez_tmp_3 = sectored_entries_0_4_valid_0;
      2'b01:
        casez_tmp_3 = sectored_entries_0_4_valid_1;
      2'b10:
        casez_tmp_3 = sectored_entries_0_4_valid_2;
      default:
        casez_tmp_3 = sectored_entries_0_4_valid_3;
    endcase
  end // always @(*)
  wire        hitsVec_4 = _vm_enabled_T_1 & casez_tmp_3 & _hitsVec_T_24 == 25'h0 & ~sectored_entries_0_4_tag_v;
  always @(*) begin
    casez (io_req_bits_vaddr[13:12])
      2'b00:
        casez_tmp_4 = sectored_entries_0_5_valid_0;
      2'b01:
        casez_tmp_4 = sectored_entries_0_5_valid_1;
      2'b10:
        casez_tmp_4 = sectored_entries_0_5_valid_2;
      default:
        casez_tmp_4 = sectored_entries_0_5_valid_3;
    endcase
  end // always @(*)
  wire        hitsVec_5 = _vm_enabled_T_1 & casez_tmp_4 & _hitsVec_T_30 == 25'h0 & ~sectored_entries_0_5_tag_v;
  always @(*) begin
    casez (io_req_bits_vaddr[13:12])
      2'b00:
        casez_tmp_5 = sectored_entries_0_6_valid_0;
      2'b01:
        casez_tmp_5 = sectored_entries_0_6_valid_1;
      2'b10:
        casez_tmp_5 = sectored_entries_0_6_valid_2;
      default:
        casez_tmp_5 = sectored_entries_0_6_valid_3;
    endcase
  end // always @(*)
  wire        hitsVec_6 = _vm_enabled_T_1 & casez_tmp_5 & _hitsVec_T_36 == 25'h0 & ~sectored_entries_0_6_tag_v;
  always @(*) begin
    casez (io_req_bits_vaddr[13:12])
      2'b00:
        casez_tmp_6 = sectored_entries_0_7_valid_0;
      2'b01:
        casez_tmp_6 = sectored_entries_0_7_valid_1;
      2'b10:
        casez_tmp_6 = sectored_entries_0_7_valid_2;
      default:
        casez_tmp_6 = sectored_entries_0_7_valid_3;
    endcase
  end // always @(*)
  wire        hitsVec_7 = _vm_enabled_T_1 & casez_tmp_6 & _hitsVec_T_42 == 25'h0 & ~sectored_entries_0_7_tag_v;
  wire        hitsVec_8 = _vm_enabled_T_1 & superpage_entries_0_valid_0 & ~superpage_entries_0_tag_v & _hitsVec_T_58[17:9] == 9'h0 & (ignore_1 | _hitsVec_T_58[8:0] == 9'h0);
  wire        hitsVec_9 = _vm_enabled_T_1 & superpage_entries_1_valid_0 & ~superpage_entries_1_tag_v & _hitsVec_T_73[17:9] == 9'h0 & (ignore_4 | _hitsVec_T_73[8:0] == 9'h0);
  wire        hitsVec_10 = _vm_enabled_T_1 & superpage_entries_2_valid_0 & ~superpage_entries_2_tag_v & _hitsVec_T_88[17:9] == 9'h0 & (ignore_7 | _hitsVec_T_88[8:0] == 9'h0);
  wire        hitsVec_11 = _vm_enabled_T_1 & superpage_entries_3_valid_0 & ~superpage_entries_3_tag_v & _hitsVec_T_103[17:9] == 9'h0 & (ignore_10 | _hitsVec_T_103[8:0] == 9'h0);
  wire [26:0] _hitsVec_T_118 = special_entry_tag_vpn ^ io_req_bits_vaddr[38:12];
  wire        hitsVec_12 = _vm_enabled_T_1 & special_entry_valid_0 & ~special_entry_tag_v & _hitsVec_T_118[26:18] == 9'h0 & (ignore_13 | _hitsVec_T_118[17:9] == 9'h0) & (~(special_entry_level[1]) | _hitsVec_T_118[8:0] == 9'h0);
  wire [12:0] real_hits = {hitsVec_12, hitsVec_11, hitsVec_10, hitsVec_9, hitsVec_8, hitsVec_7, hitsVec_6, hitsVec_5, hitsVec_4, hitsVec_3, hitsVec_2, hitsVec_1, hitsVec_0};
  always @(*) begin
    casez (io_req_bits_vaddr[13:12])
      2'b00:
        casez_tmp_7 = sectored_entries_0_0_data_0;
      2'b01:
        casez_tmp_7 = sectored_entries_0_0_data_1;
      2'b10:
        casez_tmp_7 = sectored_entries_0_0_data_2;
      default:
        casez_tmp_7 = sectored_entries_0_0_data_3;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_req_bits_vaddr[13:12])
      2'b00:
        casez_tmp_8 = sectored_entries_0_1_data_0;
      2'b01:
        casez_tmp_8 = sectored_entries_0_1_data_1;
      2'b10:
        casez_tmp_8 = sectored_entries_0_1_data_2;
      default:
        casez_tmp_8 = sectored_entries_0_1_data_3;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_req_bits_vaddr[13:12])
      2'b00:
        casez_tmp_9 = sectored_entries_0_2_data_0;
      2'b01:
        casez_tmp_9 = sectored_entries_0_2_data_1;
      2'b10:
        casez_tmp_9 = sectored_entries_0_2_data_2;
      default:
        casez_tmp_9 = sectored_entries_0_2_data_3;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_req_bits_vaddr[13:12])
      2'b00:
        casez_tmp_10 = sectored_entries_0_3_data_0;
      2'b01:
        casez_tmp_10 = sectored_entries_0_3_data_1;
      2'b10:
        casez_tmp_10 = sectored_entries_0_3_data_2;
      default:
        casez_tmp_10 = sectored_entries_0_3_data_3;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_req_bits_vaddr[13:12])
      2'b00:
        casez_tmp_11 = sectored_entries_0_4_data_0;
      2'b01:
        casez_tmp_11 = sectored_entries_0_4_data_1;
      2'b10:
        casez_tmp_11 = sectored_entries_0_4_data_2;
      default:
        casez_tmp_11 = sectored_entries_0_4_data_3;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_req_bits_vaddr[13:12])
      2'b00:
        casez_tmp_12 = sectored_entries_0_5_data_0;
      2'b01:
        casez_tmp_12 = sectored_entries_0_5_data_1;
      2'b10:
        casez_tmp_12 = sectored_entries_0_5_data_2;
      default:
        casez_tmp_12 = sectored_entries_0_5_data_3;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_req_bits_vaddr[13:12])
      2'b00:
        casez_tmp_13 = sectored_entries_0_6_data_0;
      2'b01:
        casez_tmp_13 = sectored_entries_0_6_data_1;
      2'b10:
        casez_tmp_13 = sectored_entries_0_6_data_2;
      default:
        casez_tmp_13 = sectored_entries_0_6_data_3;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_req_bits_vaddr[13:12])
      2'b00:
        casez_tmp_14 = sectored_entries_0_7_data_0;
      2'b01:
        casez_tmp_14 = sectored_entries_0_7_data_1;
      2'b10:
        casez_tmp_14 = sectored_entries_0_7_data_2;
      default:
        casez_tmp_14 = sectored_entries_0_7_data_3;
    endcase
  end // always @(*)
  wire        bad_va = _vm_enabled_T_1 & io_ptw_ptbr_mode[3] & ~(io_req_bits_vaddr[39:38] == 2'h0 | (&(io_req_bits_vaddr[39:38])));
  wire        tlb_miss = _vm_enabled_T_1 & ~bad_va & real_hits == 13'h0;
  reg  [6:0]  state_vec_0;
  reg  [2:0]  state_reg_1;
  wire        multipleHits_rightOne_1 = hitsVec_1 | hitsVec_2;
  wire        multipleHits_leftOne_2 = hitsVec_0 | multipleHits_rightOne_1;
  wire        multipleHits_rightOne_3 = hitsVec_4 | hitsVec_5;
  wire        multipleHits_rightOne_4 = hitsVec_3 | multipleHits_rightOne_3;
  wire        multipleHits_rightOne_6 = hitsVec_7 | hitsVec_8;
  wire        multipleHits_leftOne_8 = hitsVec_6 | multipleHits_rightOne_6;
  wire        multipleHits_leftOne_10 = hitsVec_9 | hitsVec_10;
  wire        multipleHits_rightOne_9 = hitsVec_11 | hitsVec_12;
  wire        multipleHits_rightOne_10 = multipleHits_leftOne_10 | multipleHits_rightOne_9;
  wire        multipleHits = hitsVec_1 & hitsVec_2 | hitsVec_0 & multipleHits_rightOne_1 | hitsVec_4 & hitsVec_5 | hitsVec_3 & multipleHits_rightOne_3 | multipleHits_leftOne_2 & multipleHits_rightOne_4 | hitsVec_7 & hitsVec_8 | hitsVec_6 & multipleHits_rightOne_6 | hitsVec_9 & hitsVec_10 | hitsVec_11 & hitsVec_12 | multipleHits_leftOne_10 & multipleHits_rightOne_9 | multipleHits_leftOne_8 & multipleHits_rightOne_10 | (multipleHits_leftOne_2 | multipleHits_rightOne_4) & (multipleHits_leftOne_8 | multipleHits_rightOne_10);
  wire [2:0]  _r_superpage_repl_addr_T_5 = ~{superpage_entries_2_valid_0, superpage_entries_1_valid_0, superpage_entries_0_valid_0};
  wire        superpage_hits_1 = superpage_entries_1_valid_0 & ~superpage_entries_1_tag_v & _hitsVec_T_73[17:9] == 9'h0 & (ignore_4 | _hitsVec_T_73[8:0] == 9'h0);
  wire        superpage_hits_2 = superpage_entries_2_valid_0 & ~superpage_entries_2_tag_v & _hitsVec_T_88[17:9] == 9'h0 & (ignore_7 | _hitsVec_T_88[8:0] == 9'h0);
  wire        superpage_hits_3 = superpage_entries_3_valid_0 & ~superpage_entries_3_tag_v & _hitsVec_T_103[17:9] == 9'h0 & (ignore_10 | _hitsVec_T_103[8:0] == 9'h0);
  wire        _GEN_4 = io_req_valid & _vm_enabled_T_1;
  wire [1:0]  hi_4 = {superpage_hits_3, superpage_hits_2};
  wire        _state_reg_T_5 = superpage_hits_3 | superpage_hits_1;
  wire        invalidate_refill = _io_ptw_req_valid_T | (&state) | io_sfence_valid;
  wire        cacheable = legal_address & ~(_GEN_2[3]);
  wire        prot_r = legal_address & ~deny_access_to_debug & _pmp_io_r;
  wire [4:0]  _GEN_5 = {mpu_ppn[19], mpu_ppn[15], mpu_ppn[13], mpu_ppn[8], mpu_ppn[4]};
  wire [4:0]  _GEN_6 = {mpu_ppn[19], mpu_ppn[16:15], mpu_ppn[13], _GEN_1[8]};
  wire [4:0]  _GEN_7 = {mpu_ppn[19], mpu_ppn[16:15], _GEN_0[9], mpu_ppn[8]};
  wire [2:0]  _GEN_8 = {mpu_ppn[19], mpu_ppn[16], ~(mpu_ppn[15])};
  wire        prot_w = legal_address & (~(|_GEN_5) | ~(|_GEN_6) | ~(|_GEN_7) | ~(|_GEN_8) | ~(|_GEN_3)) & ~deny_access_to_debug & _pmp_io_w;
  wire        prot_pp = legal_address & (~(|_GEN_5) | ~(|_GEN_6) | ~(|_GEN_7) | ~(|_GEN_8) | ~(|_GEN_3));
  wire        prot_al = legal_address & (~(|_GEN_5) | ~(|_GEN_6) | ~(|_GEN_7) | ~(|_GEN_8) | ~(|_GEN_3));
  wire        prot_aa = legal_address & (~(|_GEN_5) | ~(|_GEN_6) | ~(|_GEN_7) | ~(|_GEN_8) | ~(|_GEN_3));
  wire        prot_eff = legal_address & ({mpu_ppn[19], mpu_ppn[15], mpu_ppn[13], mpu_ppn[8], mpu_ppn[4], mpu_ppn[1]} == 6'h0 | {mpu_ppn[19], mpu_ppn[16:15], mpu_ppn[13], _GEN_1[8], mpu_ppn[1]} == 6'h0 | {mpu_ppn[19], mpu_ppn[16:15], _GEN_0[9], mpu_ppn[8], mpu_ppn[4]} == 6'h0 | {mpu_ppn[19], mpu_ppn[16:15], _GEN[13], mpu_ppn[8], _GEN[4], mpu_ppn[1]} == 7'h0 | ~(|_GEN_8));
  wire        _r_sectored_repl_addr_valids_T = sectored_entries_0_0_valid_0 | sectored_entries_0_0_valid_1;
  wire        _r_sectored_repl_addr_valids_T_3 = sectored_entries_0_1_valid_0 | sectored_entries_0_1_valid_1;
  wire        sector_hits_1 = (_r_sectored_repl_addr_valids_T_3 | sectored_entries_0_1_valid_2 | sectored_entries_0_1_valid_3) & _hitsVec_T_6 == 25'h0 & ~sectored_entries_0_1_tag_v;
  wire        _r_sectored_repl_addr_valids_T_6 = sectored_entries_0_2_valid_0 | sectored_entries_0_2_valid_1;
  wire        sector_hits_2 = (_r_sectored_repl_addr_valids_T_6 | sectored_entries_0_2_valid_2 | sectored_entries_0_2_valid_3) & _hitsVec_T_12 == 25'h0 & ~sectored_entries_0_2_tag_v;
  wire        _r_sectored_repl_addr_valids_T_9 = sectored_entries_0_3_valid_0 | sectored_entries_0_3_valid_1;
  wire        sector_hits_3 = (_r_sectored_repl_addr_valids_T_9 | sectored_entries_0_3_valid_2 | sectored_entries_0_3_valid_3) & _hitsVec_T_18 == 25'h0 & ~sectored_entries_0_3_tag_v;
  wire        _r_sectored_repl_addr_valids_T_12 = sectored_entries_0_4_valid_0 | sectored_entries_0_4_valid_1;
  wire        sector_hits_4 = (_r_sectored_repl_addr_valids_T_12 | sectored_entries_0_4_valid_2 | sectored_entries_0_4_valid_3) & _hitsVec_T_24 == 25'h0 & ~sectored_entries_0_4_tag_v;
  wire        _r_sectored_repl_addr_valids_T_15 = sectored_entries_0_5_valid_0 | sectored_entries_0_5_valid_1;
  wire        sector_hits_5 = (_r_sectored_repl_addr_valids_T_15 | sectored_entries_0_5_valid_2 | sectored_entries_0_5_valid_3) & _hitsVec_T_30 == 25'h0 & ~sectored_entries_0_5_tag_v;
  wire        _r_sectored_repl_addr_valids_T_18 = sectored_entries_0_6_valid_0 | sectored_entries_0_6_valid_1;
  wire        sector_hits_6 = (_r_sectored_repl_addr_valids_T_18 | sectored_entries_0_6_valid_2 | sectored_entries_0_6_valid_3) & _hitsVec_T_36 == 25'h0 & ~sectored_entries_0_6_tag_v;
  wire        _r_sectored_repl_addr_valids_T_21 = sectored_entries_0_7_valid_0 | sectored_entries_0_7_valid_1;
  wire        sector_hits_7 = (_r_sectored_repl_addr_valids_T_21 | sectored_entries_0_7_valid_2 | sectored_entries_0_7_valid_3) & _hitsVec_T_42 == 25'h0 & ~sectored_entries_0_7_tag_v;
  wire        _GEN_9 = io_req_bits_vaddr[13:12] == 2'h1;
  wire        _GEN_10 = io_req_bits_vaddr[13:12] == 2'h2;
  wire        refill_v = r_vstage1_en | r_stage2_en;
  wire        newEntry_g = io_ptw_resp_bits_pte_g & io_ptw_resp_bits_pte_v;
  wire        newEntry_ae_stage2 = io_ptw_resp_bits_ae_final & io_ptw_resp_bits_gpa_is_pte & r_stage2_en;
  wire        newEntry_sr = io_ptw_resp_bits_pte_v & (io_ptw_resp_bits_pte_r | io_ptw_resp_bits_pte_x & ~io_ptw_resp_bits_pte_w) & io_ptw_resp_bits_pte_a & io_ptw_resp_bits_pte_r;
  wire        newEntry_sw = io_ptw_resp_bits_pte_v & (io_ptw_resp_bits_pte_r | io_ptw_resp_bits_pte_x & ~io_ptw_resp_bits_pte_w) & io_ptw_resp_bits_pte_a & io_ptw_resp_bits_pte_w & io_ptw_resp_bits_pte_d;
  wire        newEntry_sx = io_ptw_resp_bits_pte_v & (io_ptw_resp_bits_pte_r | io_ptw_resp_bits_pte_x & ~io_ptw_resp_bits_pte_w) & io_ptw_resp_bits_pte_a & io_ptw_resp_bits_pte_x;
  wire [1:0]  _GEN_11 = {1'h0, io_ptw_resp_bits_level[0]};
  wire [2:0]  waddr_1 = r_sectored_hit_valid ? r_sectored_hit_bits : r_sectored_repl_addr;
  wire        _GEN_12 = waddr_1 == 3'h0;
  wire        _GEN_13 = r_refill_tag[1:0] == 2'h0;
  wire        _GEN_14 = r_refill_tag[1:0] == 2'h1;
  wire        _GEN_15 = r_refill_tag[1:0] == 2'h2;
  wire [41:0] _sectored_entries_0_0_data_idx = {io_ptw_resp_bits_pte_ppn[19:0], io_ptw_resp_bits_pte_u, newEntry_g, io_ptw_resp_bits_ae_ptw, io_ptw_resp_bits_ae_final, newEntry_ae_stage2, io_ptw_resp_bits_pf, io_ptw_resp_bits_gf, newEntry_sw, newEntry_sx, newEntry_sr, io_ptw_resp_bits_hw, io_ptw_resp_bits_hx, io_ptw_resp_bits_hr, prot_w, prot_x, prot_r, prot_pp, prot_al, prot_aa, prot_eff, cacheable, 1'h0};
  wire        _GEN_16 = waddr_1 == 3'h1;
  wire [41:0] _sectored_entries_0_1_data_idx_1 = {io_ptw_resp_bits_pte_ppn[19:0], io_ptw_resp_bits_pte_u, newEntry_g, io_ptw_resp_bits_ae_ptw, io_ptw_resp_bits_ae_final, newEntry_ae_stage2, io_ptw_resp_bits_pf, io_ptw_resp_bits_gf, newEntry_sw, newEntry_sx, newEntry_sr, io_ptw_resp_bits_hw, io_ptw_resp_bits_hx, io_ptw_resp_bits_hr, prot_w, prot_x, prot_r, prot_pp, prot_al, prot_aa, prot_eff, cacheable, 1'h0};
  wire        _GEN_17 = waddr_1 == 3'h2;
  wire [41:0] _sectored_entries_0_2_data_idx_2 = {io_ptw_resp_bits_pte_ppn[19:0], io_ptw_resp_bits_pte_u, newEntry_g, io_ptw_resp_bits_ae_ptw, io_ptw_resp_bits_ae_final, newEntry_ae_stage2, io_ptw_resp_bits_pf, io_ptw_resp_bits_gf, newEntry_sw, newEntry_sx, newEntry_sr, io_ptw_resp_bits_hw, io_ptw_resp_bits_hx, io_ptw_resp_bits_hr, prot_w, prot_x, prot_r, prot_pp, prot_al, prot_aa, prot_eff, cacheable, 1'h0};
  wire        _GEN_18 = waddr_1 == 3'h3;
  wire [41:0] _sectored_entries_0_3_data_idx_3 = {io_ptw_resp_bits_pte_ppn[19:0], io_ptw_resp_bits_pte_u, newEntry_g, io_ptw_resp_bits_ae_ptw, io_ptw_resp_bits_ae_final, newEntry_ae_stage2, io_ptw_resp_bits_pf, io_ptw_resp_bits_gf, newEntry_sw, newEntry_sx, newEntry_sr, io_ptw_resp_bits_hw, io_ptw_resp_bits_hx, io_ptw_resp_bits_hr, prot_w, prot_x, prot_r, prot_pp, prot_al, prot_aa, prot_eff, cacheable, 1'h0};
  wire        _GEN_19 = waddr_1 == 3'h4;
  wire [41:0] _sectored_entries_0_4_data_idx_4 = {io_ptw_resp_bits_pte_ppn[19:0], io_ptw_resp_bits_pte_u, newEntry_g, io_ptw_resp_bits_ae_ptw, io_ptw_resp_bits_ae_final, newEntry_ae_stage2, io_ptw_resp_bits_pf, io_ptw_resp_bits_gf, newEntry_sw, newEntry_sx, newEntry_sr, io_ptw_resp_bits_hw, io_ptw_resp_bits_hx, io_ptw_resp_bits_hr, prot_w, prot_x, prot_r, prot_pp, prot_al, prot_aa, prot_eff, cacheable, 1'h0};
  wire        _GEN_20 = waddr_1 == 3'h5;
  wire [41:0] _sectored_entries_0_5_data_idx_5 = {io_ptw_resp_bits_pte_ppn[19:0], io_ptw_resp_bits_pte_u, newEntry_g, io_ptw_resp_bits_ae_ptw, io_ptw_resp_bits_ae_final, newEntry_ae_stage2, io_ptw_resp_bits_pf, io_ptw_resp_bits_gf, newEntry_sw, newEntry_sx, newEntry_sr, io_ptw_resp_bits_hw, io_ptw_resp_bits_hx, io_ptw_resp_bits_hr, prot_w, prot_x, prot_r, prot_pp, prot_al, prot_aa, prot_eff, cacheable, 1'h0};
  wire        _GEN_21 = waddr_1 == 3'h6;
  wire [41:0] _sectored_entries_0_6_data_idx_6 = {io_ptw_resp_bits_pte_ppn[19:0], io_ptw_resp_bits_pte_u, newEntry_g, io_ptw_resp_bits_ae_ptw, io_ptw_resp_bits_ae_final, newEntry_ae_stage2, io_ptw_resp_bits_pf, io_ptw_resp_bits_gf, newEntry_sw, newEntry_sx, newEntry_sr, io_ptw_resp_bits_hw, io_ptw_resp_bits_hx, io_ptw_resp_bits_hr, prot_w, prot_x, prot_r, prot_pp, prot_al, prot_aa, prot_eff, cacheable, 1'h0};
  wire [41:0] _sectored_entries_0_7_data_idx_7 = {io_ptw_resp_bits_pte_ppn[19:0], io_ptw_resp_bits_pte_u, newEntry_g, io_ptw_resp_bits_ae_ptw, io_ptw_resp_bits_ae_final, newEntry_ae_stage2, io_ptw_resp_bits_pf, io_ptw_resp_bits_gf, newEntry_sw, newEntry_sx, newEntry_sr, io_ptw_resp_bits_hw, io_ptw_resp_bits_hx, io_ptw_resp_bits_hr, prot_w, prot_x, prot_r, prot_pp, prot_al, prot_aa, prot_eff, cacheable, 1'h0};
  wire        _GEN_22 = ~io_ptw_resp_bits_homogeneous | ~(io_ptw_resp_bits_level[1]);
  wire        _GEN_23 = io_ptw_resp_valid & ~io_ptw_resp_bits_homogeneous;
  wire        _GEN_493 = _GEN_23 | special_entry_valid_0;
  wire        _GEN_24 = io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1]) & waddr == 2'h0;
  wire        _GEN_498 = _GEN_24 ? ~invalidate_refill : superpage_entries_0_valid_0;
  wire        _GEN_25 = io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1]) & waddr == 2'h1;
  wire        _GEN_503 = _GEN_25 ? ~invalidate_refill : superpage_entries_1_valid_0;
  wire        _GEN_26 = io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1]) & waddr == 2'h2;
  wire        _GEN_508 = _GEN_26 ? ~invalidate_refill : superpage_entries_2_valid_0;
  wire        _GEN_27 = io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1]) & (&waddr);
  wire        _GEN_513 = _GEN_27 ? ~invalidate_refill : superpage_entries_3_valid_0;
  wire        _GEN_28 = ~io_ptw_resp_valid | _GEN_22 | ~_GEN_12;
  wire        _GEN_515 = _GEN_28 ? sectored_entries_0_0_valid_0 : ~invalidate_refill & (_GEN_13 | r_sectored_hit_valid & sectored_entries_0_0_valid_0);
  wire        _GEN_516 = _GEN_28 ? sectored_entries_0_0_valid_1 : ~invalidate_refill & (_GEN_14 | r_sectored_hit_valid & sectored_entries_0_0_valid_1);
  wire        _GEN_517 = _GEN_28 ? sectored_entries_0_0_valid_2 : ~invalidate_refill & (_GEN_15 | r_sectored_hit_valid & sectored_entries_0_0_valid_2);
  wire        _GEN_518 = _GEN_28 ? sectored_entries_0_0_valid_3 : ~invalidate_refill & ((&(r_refill_tag[1:0])) | r_sectored_hit_valid & sectored_entries_0_0_valid_3);
  wire        _GEN_29 = ~io_ptw_resp_valid | _GEN_22 | ~_GEN_16;
  wire        _GEN_526 = _GEN_29 ? sectored_entries_0_1_valid_0 : ~invalidate_refill & (_GEN_13 | r_sectored_hit_valid & sectored_entries_0_1_valid_0);
  wire        _GEN_527 = _GEN_29 ? sectored_entries_0_1_valid_1 : ~invalidate_refill & (_GEN_14 | r_sectored_hit_valid & sectored_entries_0_1_valid_1);
  wire        _GEN_528 = _GEN_29 ? sectored_entries_0_1_valid_2 : ~invalidate_refill & (_GEN_15 | r_sectored_hit_valid & sectored_entries_0_1_valid_2);
  wire        _GEN_529 = _GEN_29 ? sectored_entries_0_1_valid_3 : ~invalidate_refill & ((&(r_refill_tag[1:0])) | r_sectored_hit_valid & sectored_entries_0_1_valid_3);
  wire        _GEN_30 = ~io_ptw_resp_valid | _GEN_22 | ~_GEN_17;
  wire        _GEN_537 = _GEN_30 ? sectored_entries_0_2_valid_0 : ~invalidate_refill & (_GEN_13 | r_sectored_hit_valid & sectored_entries_0_2_valid_0);
  wire        _GEN_538 = _GEN_30 ? sectored_entries_0_2_valid_1 : ~invalidate_refill & (_GEN_14 | r_sectored_hit_valid & sectored_entries_0_2_valid_1);
  wire        _GEN_539 = _GEN_30 ? sectored_entries_0_2_valid_2 : ~invalidate_refill & (_GEN_15 | r_sectored_hit_valid & sectored_entries_0_2_valid_2);
  wire        _GEN_540 = _GEN_30 ? sectored_entries_0_2_valid_3 : ~invalidate_refill & ((&(r_refill_tag[1:0])) | r_sectored_hit_valid & sectored_entries_0_2_valid_3);
  wire        _GEN_31 = ~io_ptw_resp_valid | _GEN_22 | ~_GEN_18;
  wire        _GEN_548 = _GEN_31 ? sectored_entries_0_3_valid_0 : ~invalidate_refill & (_GEN_13 | r_sectored_hit_valid & sectored_entries_0_3_valid_0);
  wire        _GEN_549 = _GEN_31 ? sectored_entries_0_3_valid_1 : ~invalidate_refill & (_GEN_14 | r_sectored_hit_valid & sectored_entries_0_3_valid_1);
  wire        _GEN_550 = _GEN_31 ? sectored_entries_0_3_valid_2 : ~invalidate_refill & (_GEN_15 | r_sectored_hit_valid & sectored_entries_0_3_valid_2);
  wire        _GEN_551 = _GEN_31 ? sectored_entries_0_3_valid_3 : ~invalidate_refill & ((&(r_refill_tag[1:0])) | r_sectored_hit_valid & sectored_entries_0_3_valid_3);
  wire        _GEN_32 = ~io_ptw_resp_valid | _GEN_22 | ~_GEN_19;
  wire        _GEN_559 = _GEN_32 ? sectored_entries_0_4_valid_0 : ~invalidate_refill & (_GEN_13 | r_sectored_hit_valid & sectored_entries_0_4_valid_0);
  wire        _GEN_560 = _GEN_32 ? sectored_entries_0_4_valid_1 : ~invalidate_refill & (_GEN_14 | r_sectored_hit_valid & sectored_entries_0_4_valid_1);
  wire        _GEN_561 = _GEN_32 ? sectored_entries_0_4_valid_2 : ~invalidate_refill & (_GEN_15 | r_sectored_hit_valid & sectored_entries_0_4_valid_2);
  wire        _GEN_562 = _GEN_32 ? sectored_entries_0_4_valid_3 : ~invalidate_refill & ((&(r_refill_tag[1:0])) | r_sectored_hit_valid & sectored_entries_0_4_valid_3);
  wire        _GEN_33 = ~io_ptw_resp_valid | _GEN_22 | ~_GEN_20;
  wire        _GEN_570 = _GEN_33 ? sectored_entries_0_5_valid_0 : ~invalidate_refill & (_GEN_13 | r_sectored_hit_valid & sectored_entries_0_5_valid_0);
  wire        _GEN_571 = _GEN_33 ? sectored_entries_0_5_valid_1 : ~invalidate_refill & (_GEN_14 | r_sectored_hit_valid & sectored_entries_0_5_valid_1);
  wire        _GEN_572 = _GEN_33 ? sectored_entries_0_5_valid_2 : ~invalidate_refill & (_GEN_15 | r_sectored_hit_valid & sectored_entries_0_5_valid_2);
  wire        _GEN_573 = _GEN_33 ? sectored_entries_0_5_valid_3 : ~invalidate_refill & ((&(r_refill_tag[1:0])) | r_sectored_hit_valid & sectored_entries_0_5_valid_3);
  wire        _GEN_34 = ~io_ptw_resp_valid | _GEN_22 | ~_GEN_21;
  wire        _GEN_581 = _GEN_34 ? sectored_entries_0_6_valid_0 : ~invalidate_refill & (_GEN_13 | r_sectored_hit_valid & sectored_entries_0_6_valid_0);
  wire        _GEN_582 = _GEN_34 ? sectored_entries_0_6_valid_1 : ~invalidate_refill & (_GEN_14 | r_sectored_hit_valid & sectored_entries_0_6_valid_1);
  wire        _GEN_583 = _GEN_34 ? sectored_entries_0_6_valid_2 : ~invalidate_refill & (_GEN_15 | r_sectored_hit_valid & sectored_entries_0_6_valid_2);
  wire        _GEN_584 = _GEN_34 ? sectored_entries_0_6_valid_3 : ~invalidate_refill & ((&(r_refill_tag[1:0])) | r_sectored_hit_valid & sectored_entries_0_6_valid_3);
  wire        _GEN_35 = ~io_ptw_resp_valid | _GEN_22 | ~(&waddr_1);
  wire        _GEN_592 = _GEN_35 ? sectored_entries_0_7_valid_0 : ~invalidate_refill & (_GEN_13 | r_sectored_hit_valid & sectored_entries_0_7_valid_0);
  wire        _GEN_593 = _GEN_35 ? sectored_entries_0_7_valid_1 : ~invalidate_refill & (_GEN_14 | r_sectored_hit_valid & sectored_entries_0_7_valid_1);
  wire        _GEN_594 = _GEN_35 ? sectored_entries_0_7_valid_2 : ~invalidate_refill & (_GEN_15 | r_sectored_hit_valid & sectored_entries_0_7_valid_2);
  wire        _GEN_595 = _GEN_35 ? sectored_entries_0_7_valid_3 : ~invalidate_refill & ((&(r_refill_tag[1:0])) | r_sectored_hit_valid & sectored_entries_0_7_valid_3);
  wire        _r_sectored_hit_valid_T = (_r_sectored_repl_addr_valids_T | sectored_entries_0_0_valid_2 | sectored_entries_0_0_valid_3) & _hitsVec_T == 25'h0 & ~sectored_entries_0_0_tag_v | sector_hits_1;
  wire [2:0]  _GEN_36 = {sector_hits_7, sector_hits_6, sector_hits_5};
  wire [2:0]  _GEN_37 = {sector_hits_3, sector_hits_2, sector_hits_1};
  wire        _GEN_38 = state == 2'h0 & io_req_valid & tlb_miss;
  wire        _GEN_39 = _hitsVec_T == 25'h0 & ~sectored_entries_0_0_tag_v;
  wire        _GEN_40 = io_req_bits_vaddr[13:12] == 2'h0;
  wire        _GEN_41 = _GEN_39 & ~sectored_entries_0_0_tag_v & _GEN_40;
  wire        _GEN_42 = _GEN_39 & ~sectored_entries_0_0_tag_v & _GEN_9;
  wire        _GEN_43 = _GEN_39 & ~sectored_entries_0_0_tag_v & _GEN_10;
  wire        _GEN_44 = _GEN_39 & ~sectored_entries_0_0_tag_v & (&(io_req_bits_vaddr[13:12]));
  wire        _GEN_45 = _hitsVec_T[24:16] == 9'h0;
  wire        _GEN_46 = _hitsVec_T_6 == 25'h0 & ~sectored_entries_0_1_tag_v;
  wire        _GEN_47 = _GEN_46 & ~sectored_entries_0_1_tag_v & _GEN_40;
  wire        _GEN_48 = _GEN_46 & ~sectored_entries_0_1_tag_v & _GEN_9;
  wire        _GEN_49 = _GEN_46 & ~sectored_entries_0_1_tag_v & _GEN_10;
  wire        _GEN_50 = _GEN_46 & ~sectored_entries_0_1_tag_v & (&(io_req_bits_vaddr[13:12]));
  wire        _GEN_51 = _hitsVec_T_6[24:16] == 9'h0;
  wire        _GEN_52 = _hitsVec_T_12 == 25'h0 & ~sectored_entries_0_2_tag_v;
  wire        _GEN_53 = _GEN_52 & ~sectored_entries_0_2_tag_v & _GEN_40;
  wire        _GEN_54 = _GEN_52 & ~sectored_entries_0_2_tag_v & _GEN_9;
  wire        _GEN_55 = _GEN_52 & ~sectored_entries_0_2_tag_v & _GEN_10;
  wire        _GEN_56 = _GEN_52 & ~sectored_entries_0_2_tag_v & (&(io_req_bits_vaddr[13:12]));
  wire        _GEN_57 = _hitsVec_T_12[24:16] == 9'h0;
  wire        _GEN_58 = _hitsVec_T_18 == 25'h0 & ~sectored_entries_0_3_tag_v;
  wire        _GEN_59 = _GEN_58 & ~sectored_entries_0_3_tag_v & _GEN_40;
  wire        _GEN_60 = _GEN_58 & ~sectored_entries_0_3_tag_v & _GEN_9;
  wire        _GEN_61 = _GEN_58 & ~sectored_entries_0_3_tag_v & _GEN_10;
  wire        _GEN_62 = _GEN_58 & ~sectored_entries_0_3_tag_v & (&(io_req_bits_vaddr[13:12]));
  wire        _GEN_63 = _hitsVec_T_18[24:16] == 9'h0;
  wire        _GEN_64 = _hitsVec_T_24 == 25'h0 & ~sectored_entries_0_4_tag_v;
  wire        _GEN_65 = _GEN_64 & ~sectored_entries_0_4_tag_v & _GEN_40;
  wire        _GEN_66 = _GEN_64 & ~sectored_entries_0_4_tag_v & _GEN_9;
  wire        _GEN_67 = _GEN_64 & ~sectored_entries_0_4_tag_v & _GEN_10;
  wire        _GEN_68 = _GEN_64 & ~sectored_entries_0_4_tag_v & (&(io_req_bits_vaddr[13:12]));
  wire        _GEN_69 = _hitsVec_T_24[24:16] == 9'h0;
  wire        _GEN_70 = _hitsVec_T_30 == 25'h0 & ~sectored_entries_0_5_tag_v;
  wire        _GEN_71 = _GEN_70 & ~sectored_entries_0_5_tag_v & _GEN_40;
  wire        _GEN_72 = _GEN_70 & ~sectored_entries_0_5_tag_v & _GEN_9;
  wire        _GEN_73 = _GEN_70 & ~sectored_entries_0_5_tag_v & _GEN_10;
  wire        _GEN_74 = _GEN_70 & ~sectored_entries_0_5_tag_v & (&(io_req_bits_vaddr[13:12]));
  wire        _GEN_75 = _hitsVec_T_30[24:16] == 9'h0;
  wire        _GEN_76 = _hitsVec_T_36 == 25'h0 & ~sectored_entries_0_6_tag_v;
  wire        _GEN_77 = _GEN_76 & ~sectored_entries_0_6_tag_v & _GEN_40;
  wire        _GEN_78 = _GEN_76 & ~sectored_entries_0_6_tag_v & _GEN_9;
  wire        _GEN_79 = _GEN_76 & ~sectored_entries_0_6_tag_v & _GEN_10;
  wire        _GEN_80 = _GEN_76 & ~sectored_entries_0_6_tag_v & (&(io_req_bits_vaddr[13:12]));
  wire        _GEN_81 = _hitsVec_T_36[24:16] == 9'h0;
  wire        _GEN_82 = _hitsVec_T_42 == 25'h0 & ~sectored_entries_0_7_tag_v;
  wire        _GEN_83 = _GEN_82 & ~sectored_entries_0_7_tag_v & _GEN_40;
  wire        _GEN_84 = _GEN_82 & ~sectored_entries_0_7_tag_v & _GEN_9;
  wire        _GEN_85 = _GEN_82 & ~sectored_entries_0_7_tag_v & _GEN_10;
  wire        _GEN_86 = _GEN_82 & ~sectored_entries_0_7_tag_v & (&(io_req_bits_vaddr[13:12]));
  wire        _GEN_87 = _hitsVec_T_42[24:16] == 9'h0;
  wire        _GEN_88 = _hitsVec_T_58[17:9] == 9'h0;
  wire        _GEN_89 = superpage_entries_0_valid_0 & ~superpage_entries_0_tag_v & _GEN_88 & (ignore_1 | _hitsVec_T_58[8:0] == 9'h0);
  wire        _GEN_90 = _hitsVec_T_73[17:9] == 9'h0;
  wire        _GEN_91 = superpage_entries_1_valid_0 & ~superpage_entries_1_tag_v & _GEN_90 & (ignore_4 | _hitsVec_T_73[8:0] == 9'h0);
  wire        _GEN_92 = _hitsVec_T_88[17:9] == 9'h0;
  wire        _GEN_93 = superpage_entries_2_valid_0 & ~superpage_entries_2_tag_v & _GEN_92 & (ignore_7 | _hitsVec_T_88[8:0] == 9'h0);
  wire        _GEN_94 = _hitsVec_T_103[17:9] == 9'h0;
  wire        _GEN_95 = superpage_entries_3_valid_0 & ~superpage_entries_3_tag_v & _GEN_94 & (ignore_10 | _hitsVec_T_103[8:0] == 9'h0);
  wire        _GEN_96 = _hitsVec_T_118[26:18] == 9'h0;
  wire        _GEN_97 = special_entry_valid_0 & ~special_entry_tag_v & _GEN_96 & (ignore_13 | _hitsVec_T_118[17:9] == 9'h0) & (~(special_entry_level[1]) | _hitsVec_T_118[8:0] == 9'h0);
  wire        _GEN_98 = multipleHits | reset;
  wire        _r_sectored_repl_addr_valids_T_2 = _r_sectored_repl_addr_valids_T | sectored_entries_0_0_valid_2 | sectored_entries_0_0_valid_3;
  wire        _r_sectored_repl_addr_valids_T_5 = _r_sectored_repl_addr_valids_T_3 | sectored_entries_0_1_valid_2 | sectored_entries_0_1_valid_3;
  wire        _r_sectored_repl_addr_valids_T_8 = _r_sectored_repl_addr_valids_T_6 | sectored_entries_0_2_valid_2 | sectored_entries_0_2_valid_3;
  wire        _r_sectored_repl_addr_valids_T_11 = _r_sectored_repl_addr_valids_T_9 | sectored_entries_0_3_valid_2 | sectored_entries_0_3_valid_3;
  wire        _r_sectored_repl_addr_valids_T_14 = _r_sectored_repl_addr_valids_T_12 | sectored_entries_0_4_valid_2 | sectored_entries_0_4_valid_3;
  wire        _r_sectored_repl_addr_valids_T_17 = _r_sectored_repl_addr_valids_T_15 | sectored_entries_0_5_valid_2 | sectored_entries_0_5_valid_3;
  wire        _r_sectored_repl_addr_valids_T_20 = _r_sectored_repl_addr_valids_T_18 | sectored_entries_0_6_valid_2 | sectored_entries_0_6_valid_3;
  wire [2:0]  _r_sectored_hit_bits_T_2 = _GEN_36 | _GEN_37;
  wire [6:0]  _r_sectored_repl_addr_T_11 = ~{_r_sectored_repl_addr_valids_T_20, _r_sectored_repl_addr_valids_T_17, _r_sectored_repl_addr_valids_T_14, _r_sectored_repl_addr_valids_T_11, _r_sectored_repl_addr_valids_T_8, _r_sectored_repl_addr_valids_T_5, _r_sectored_repl_addr_valids_T_2};
  wire [3:0]  hi_1 = {sector_hits_7, sector_hits_6, sector_hits_5, sector_hits_4};
  wire [2:0]  _GEN_99 = _GEN_36 | _GEN_37;
  wire        _state_vec_0_T_6 = _GEN_99[2] | _GEN_99[0];
  always @(posedge clock) begin
    if (_GEN_28) begin
    end
    else begin
      sectored_entries_0_0_tag_vpn <= r_refill_tag;
      sectored_entries_0_0_tag_v <= refill_v;
    end
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_12 & _GEN_13)) begin
    end
    else
      sectored_entries_0_0_data_0 <= _sectored_entries_0_0_data_idx;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_12 & _GEN_14)) begin
    end
    else
      sectored_entries_0_0_data_1 <= _sectored_entries_0_0_data_idx;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_12 & _GEN_15)) begin
    end
    else
      sectored_entries_0_0_data_2 <= _sectored_entries_0_0_data_idx;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_12 & (&(r_refill_tag[1:0])))) begin
    end
    else
      sectored_entries_0_0_data_3 <= _sectored_entries_0_0_data_idx;
    sectored_entries_0_0_valid_0 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_45 ? ~(~sectored_entries_0_0_tag_v & sectored_entries_0_0_data_0[0] | _GEN_41) & _GEN_515 : ~_GEN_41 & _GEN_515) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_0_tag_v & ~(sectored_entries_0_0_data_0[20])) & _GEN_515 : sectored_entries_0_0_tag_v & _GEN_515) : _GEN_515);
    sectored_entries_0_0_valid_1 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_45 ? ~(~sectored_entries_0_0_tag_v & sectored_entries_0_0_data_1[0] | _GEN_42) & _GEN_516 : ~_GEN_42 & _GEN_516) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_0_tag_v & ~(sectored_entries_0_0_data_1[20])) & _GEN_516 : sectored_entries_0_0_tag_v & _GEN_516) : _GEN_516);
    sectored_entries_0_0_valid_2 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_45 ? ~(~sectored_entries_0_0_tag_v & sectored_entries_0_0_data_2[0] | _GEN_43) & _GEN_517 : ~_GEN_43 & _GEN_517) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_0_tag_v & ~(sectored_entries_0_0_data_2[20])) & _GEN_517 : sectored_entries_0_0_tag_v & _GEN_517) : _GEN_517);
    sectored_entries_0_0_valid_3 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_45 ? ~(~sectored_entries_0_0_tag_v & sectored_entries_0_0_data_3[0] | _GEN_44) & _GEN_518 : ~_GEN_44 & _GEN_518) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_0_tag_v & ~(sectored_entries_0_0_data_3[20])) & _GEN_518 : sectored_entries_0_0_tag_v & _GEN_518) : _GEN_518);
    if (_GEN_29) begin
    end
    else begin
      sectored_entries_0_1_tag_vpn <= r_refill_tag;
      sectored_entries_0_1_tag_v <= refill_v;
    end
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_16 & _GEN_13)) begin
    end
    else
      sectored_entries_0_1_data_0 <= _sectored_entries_0_1_data_idx_1;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_16 & _GEN_14)) begin
    end
    else
      sectored_entries_0_1_data_1 <= _sectored_entries_0_1_data_idx_1;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_16 & _GEN_15)) begin
    end
    else
      sectored_entries_0_1_data_2 <= _sectored_entries_0_1_data_idx_1;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_16 & (&(r_refill_tag[1:0])))) begin
    end
    else
      sectored_entries_0_1_data_3 <= _sectored_entries_0_1_data_idx_1;
    sectored_entries_0_1_valid_0 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_51 ? ~(~sectored_entries_0_1_tag_v & sectored_entries_0_1_data_0[0] | _GEN_47) & _GEN_526 : ~_GEN_47 & _GEN_526) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_1_tag_v & ~(sectored_entries_0_1_data_0[20])) & _GEN_526 : sectored_entries_0_1_tag_v & _GEN_526) : _GEN_526);
    sectored_entries_0_1_valid_1 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_51 ? ~(~sectored_entries_0_1_tag_v & sectored_entries_0_1_data_1[0] | _GEN_48) & _GEN_527 : ~_GEN_48 & _GEN_527) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_1_tag_v & ~(sectored_entries_0_1_data_1[20])) & _GEN_527 : sectored_entries_0_1_tag_v & _GEN_527) : _GEN_527);
    sectored_entries_0_1_valid_2 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_51 ? ~(~sectored_entries_0_1_tag_v & sectored_entries_0_1_data_2[0] | _GEN_49) & _GEN_528 : ~_GEN_49 & _GEN_528) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_1_tag_v & ~(sectored_entries_0_1_data_2[20])) & _GEN_528 : sectored_entries_0_1_tag_v & _GEN_528) : _GEN_528);
    sectored_entries_0_1_valid_3 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_51 ? ~(~sectored_entries_0_1_tag_v & sectored_entries_0_1_data_3[0] | _GEN_50) & _GEN_529 : ~_GEN_50 & _GEN_529) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_1_tag_v & ~(sectored_entries_0_1_data_3[20])) & _GEN_529 : sectored_entries_0_1_tag_v & _GEN_529) : _GEN_529);
    if (_GEN_30) begin
    end
    else begin
      sectored_entries_0_2_tag_vpn <= r_refill_tag;
      sectored_entries_0_2_tag_v <= refill_v;
    end
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_17 & _GEN_13)) begin
    end
    else
      sectored_entries_0_2_data_0 <= _sectored_entries_0_2_data_idx_2;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_17 & _GEN_14)) begin
    end
    else
      sectored_entries_0_2_data_1 <= _sectored_entries_0_2_data_idx_2;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_17 & _GEN_15)) begin
    end
    else
      sectored_entries_0_2_data_2 <= _sectored_entries_0_2_data_idx_2;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_17 & (&(r_refill_tag[1:0])))) begin
    end
    else
      sectored_entries_0_2_data_3 <= _sectored_entries_0_2_data_idx_2;
    sectored_entries_0_2_valid_0 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_57 ? ~(~sectored_entries_0_2_tag_v & sectored_entries_0_2_data_0[0] | _GEN_53) & _GEN_537 : ~_GEN_53 & _GEN_537) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_2_tag_v & ~(sectored_entries_0_2_data_0[20])) & _GEN_537 : sectored_entries_0_2_tag_v & _GEN_537) : _GEN_537);
    sectored_entries_0_2_valid_1 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_57 ? ~(~sectored_entries_0_2_tag_v & sectored_entries_0_2_data_1[0] | _GEN_54) & _GEN_538 : ~_GEN_54 & _GEN_538) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_2_tag_v & ~(sectored_entries_0_2_data_1[20])) & _GEN_538 : sectored_entries_0_2_tag_v & _GEN_538) : _GEN_538);
    sectored_entries_0_2_valid_2 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_57 ? ~(~sectored_entries_0_2_tag_v & sectored_entries_0_2_data_2[0] | _GEN_55) & _GEN_539 : ~_GEN_55 & _GEN_539) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_2_tag_v & ~(sectored_entries_0_2_data_2[20])) & _GEN_539 : sectored_entries_0_2_tag_v & _GEN_539) : _GEN_539);
    sectored_entries_0_2_valid_3 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_57 ? ~(~sectored_entries_0_2_tag_v & sectored_entries_0_2_data_3[0] | _GEN_56) & _GEN_540 : ~_GEN_56 & _GEN_540) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_2_tag_v & ~(sectored_entries_0_2_data_3[20])) & _GEN_540 : sectored_entries_0_2_tag_v & _GEN_540) : _GEN_540);
    if (_GEN_31) begin
    end
    else begin
      sectored_entries_0_3_tag_vpn <= r_refill_tag;
      sectored_entries_0_3_tag_v <= refill_v;
    end
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_18 & _GEN_13)) begin
    end
    else
      sectored_entries_0_3_data_0 <= _sectored_entries_0_3_data_idx_3;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_18 & _GEN_14)) begin
    end
    else
      sectored_entries_0_3_data_1 <= _sectored_entries_0_3_data_idx_3;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_18 & _GEN_15)) begin
    end
    else
      sectored_entries_0_3_data_2 <= _sectored_entries_0_3_data_idx_3;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_18 & (&(r_refill_tag[1:0])))) begin
    end
    else
      sectored_entries_0_3_data_3 <= _sectored_entries_0_3_data_idx_3;
    sectored_entries_0_3_valid_0 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_63 ? ~(~sectored_entries_0_3_tag_v & sectored_entries_0_3_data_0[0] | _GEN_59) & _GEN_548 : ~_GEN_59 & _GEN_548) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_3_tag_v & ~(sectored_entries_0_3_data_0[20])) & _GEN_548 : sectored_entries_0_3_tag_v & _GEN_548) : _GEN_548);
    sectored_entries_0_3_valid_1 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_63 ? ~(~sectored_entries_0_3_tag_v & sectored_entries_0_3_data_1[0] | _GEN_60) & _GEN_549 : ~_GEN_60 & _GEN_549) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_3_tag_v & ~(sectored_entries_0_3_data_1[20])) & _GEN_549 : sectored_entries_0_3_tag_v & _GEN_549) : _GEN_549);
    sectored_entries_0_3_valid_2 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_63 ? ~(~sectored_entries_0_3_tag_v & sectored_entries_0_3_data_2[0] | _GEN_61) & _GEN_550 : ~_GEN_61 & _GEN_550) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_3_tag_v & ~(sectored_entries_0_3_data_2[20])) & _GEN_550 : sectored_entries_0_3_tag_v & _GEN_550) : _GEN_550);
    sectored_entries_0_3_valid_3 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_63 ? ~(~sectored_entries_0_3_tag_v & sectored_entries_0_3_data_3[0] | _GEN_62) & _GEN_551 : ~_GEN_62 & _GEN_551) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_3_tag_v & ~(sectored_entries_0_3_data_3[20])) & _GEN_551 : sectored_entries_0_3_tag_v & _GEN_551) : _GEN_551);
    if (_GEN_32) begin
    end
    else begin
      sectored_entries_0_4_tag_vpn <= r_refill_tag;
      sectored_entries_0_4_tag_v <= refill_v;
    end
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_19 & _GEN_13)) begin
    end
    else
      sectored_entries_0_4_data_0 <= _sectored_entries_0_4_data_idx_4;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_19 & _GEN_14)) begin
    end
    else
      sectored_entries_0_4_data_1 <= _sectored_entries_0_4_data_idx_4;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_19 & _GEN_15)) begin
    end
    else
      sectored_entries_0_4_data_2 <= _sectored_entries_0_4_data_idx_4;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_19 & (&(r_refill_tag[1:0])))) begin
    end
    else
      sectored_entries_0_4_data_3 <= _sectored_entries_0_4_data_idx_4;
    sectored_entries_0_4_valid_0 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_69 ? ~(~sectored_entries_0_4_tag_v & sectored_entries_0_4_data_0[0] | _GEN_65) & _GEN_559 : ~_GEN_65 & _GEN_559) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_4_tag_v & ~(sectored_entries_0_4_data_0[20])) & _GEN_559 : sectored_entries_0_4_tag_v & _GEN_559) : _GEN_559);
    sectored_entries_0_4_valid_1 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_69 ? ~(~sectored_entries_0_4_tag_v & sectored_entries_0_4_data_1[0] | _GEN_66) & _GEN_560 : ~_GEN_66 & _GEN_560) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_4_tag_v & ~(sectored_entries_0_4_data_1[20])) & _GEN_560 : sectored_entries_0_4_tag_v & _GEN_560) : _GEN_560);
    sectored_entries_0_4_valid_2 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_69 ? ~(~sectored_entries_0_4_tag_v & sectored_entries_0_4_data_2[0] | _GEN_67) & _GEN_561 : ~_GEN_67 & _GEN_561) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_4_tag_v & ~(sectored_entries_0_4_data_2[20])) & _GEN_561 : sectored_entries_0_4_tag_v & _GEN_561) : _GEN_561);
    sectored_entries_0_4_valid_3 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_69 ? ~(~sectored_entries_0_4_tag_v & sectored_entries_0_4_data_3[0] | _GEN_68) & _GEN_562 : ~_GEN_68 & _GEN_562) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_4_tag_v & ~(sectored_entries_0_4_data_3[20])) & _GEN_562 : sectored_entries_0_4_tag_v & _GEN_562) : _GEN_562);
    if (_GEN_33) begin
    end
    else begin
      sectored_entries_0_5_tag_vpn <= r_refill_tag;
      sectored_entries_0_5_tag_v <= refill_v;
    end
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_20 & _GEN_13)) begin
    end
    else
      sectored_entries_0_5_data_0 <= _sectored_entries_0_5_data_idx_5;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_20 & _GEN_14)) begin
    end
    else
      sectored_entries_0_5_data_1 <= _sectored_entries_0_5_data_idx_5;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_20 & _GEN_15)) begin
    end
    else
      sectored_entries_0_5_data_2 <= _sectored_entries_0_5_data_idx_5;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_20 & (&(r_refill_tag[1:0])))) begin
    end
    else
      sectored_entries_0_5_data_3 <= _sectored_entries_0_5_data_idx_5;
    sectored_entries_0_5_valid_0 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_75 ? ~(~sectored_entries_0_5_tag_v & sectored_entries_0_5_data_0[0] | _GEN_71) & _GEN_570 : ~_GEN_71 & _GEN_570) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_5_tag_v & ~(sectored_entries_0_5_data_0[20])) & _GEN_570 : sectored_entries_0_5_tag_v & _GEN_570) : _GEN_570);
    sectored_entries_0_5_valid_1 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_75 ? ~(~sectored_entries_0_5_tag_v & sectored_entries_0_5_data_1[0] | _GEN_72) & _GEN_571 : ~_GEN_72 & _GEN_571) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_5_tag_v & ~(sectored_entries_0_5_data_1[20])) & _GEN_571 : sectored_entries_0_5_tag_v & _GEN_571) : _GEN_571);
    sectored_entries_0_5_valid_2 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_75 ? ~(~sectored_entries_0_5_tag_v & sectored_entries_0_5_data_2[0] | _GEN_73) & _GEN_572 : ~_GEN_73 & _GEN_572) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_5_tag_v & ~(sectored_entries_0_5_data_2[20])) & _GEN_572 : sectored_entries_0_5_tag_v & _GEN_572) : _GEN_572);
    sectored_entries_0_5_valid_3 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_75 ? ~(~sectored_entries_0_5_tag_v & sectored_entries_0_5_data_3[0] | _GEN_74) & _GEN_573 : ~_GEN_74 & _GEN_573) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_5_tag_v & ~(sectored_entries_0_5_data_3[20])) & _GEN_573 : sectored_entries_0_5_tag_v & _GEN_573) : _GEN_573);
    if (_GEN_34) begin
    end
    else begin
      sectored_entries_0_6_tag_vpn <= r_refill_tag;
      sectored_entries_0_6_tag_v <= refill_v;
    end
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_21 & _GEN_13)) begin
    end
    else
      sectored_entries_0_6_data_0 <= _sectored_entries_0_6_data_idx_6;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_21 & _GEN_14)) begin
    end
    else
      sectored_entries_0_6_data_1 <= _sectored_entries_0_6_data_idx_6;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_21 & _GEN_15)) begin
    end
    else
      sectored_entries_0_6_data_2 <= _sectored_entries_0_6_data_idx_6;
    if (~io_ptw_resp_valid | _GEN_22 | ~(_GEN_21 & (&(r_refill_tag[1:0])))) begin
    end
    else
      sectored_entries_0_6_data_3 <= _sectored_entries_0_6_data_idx_6;
    sectored_entries_0_6_valid_0 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_81 ? ~(~sectored_entries_0_6_tag_v & sectored_entries_0_6_data_0[0] | _GEN_77) & _GEN_581 : ~_GEN_77 & _GEN_581) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_6_tag_v & ~(sectored_entries_0_6_data_0[20])) & _GEN_581 : sectored_entries_0_6_tag_v & _GEN_581) : _GEN_581);
    sectored_entries_0_6_valid_1 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_81 ? ~(~sectored_entries_0_6_tag_v & sectored_entries_0_6_data_1[0] | _GEN_78) & _GEN_582 : ~_GEN_78 & _GEN_582) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_6_tag_v & ~(sectored_entries_0_6_data_1[20])) & _GEN_582 : sectored_entries_0_6_tag_v & _GEN_582) : _GEN_582);
    sectored_entries_0_6_valid_2 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_81 ? ~(~sectored_entries_0_6_tag_v & sectored_entries_0_6_data_2[0] | _GEN_79) & _GEN_583 : ~_GEN_79 & _GEN_583) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_6_tag_v & ~(sectored_entries_0_6_data_2[20])) & _GEN_583 : sectored_entries_0_6_tag_v & _GEN_583) : _GEN_583);
    sectored_entries_0_6_valid_3 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_81 ? ~(~sectored_entries_0_6_tag_v & sectored_entries_0_6_data_3[0] | _GEN_80) & _GEN_584 : ~_GEN_80 & _GEN_584) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_6_tag_v & ~(sectored_entries_0_6_data_3[20])) & _GEN_584 : sectored_entries_0_6_tag_v & _GEN_584) : _GEN_584);
    if (_GEN_35) begin
    end
    else begin
      sectored_entries_0_7_tag_vpn <= r_refill_tag;
      sectored_entries_0_7_tag_v <= refill_v;
    end
    if (~io_ptw_resp_valid | _GEN_22 | ~((&waddr_1) & _GEN_13)) begin
    end
    else
      sectored_entries_0_7_data_0 <= _sectored_entries_0_7_data_idx_7;
    if (~io_ptw_resp_valid | _GEN_22 | ~((&waddr_1) & _GEN_14)) begin
    end
    else
      sectored_entries_0_7_data_1 <= _sectored_entries_0_7_data_idx_7;
    if (~io_ptw_resp_valid | _GEN_22 | ~((&waddr_1) & _GEN_15)) begin
    end
    else
      sectored_entries_0_7_data_2 <= _sectored_entries_0_7_data_idx_7;
    if (~io_ptw_resp_valid | _GEN_22 | ~((&waddr_1) & (&(r_refill_tag[1:0])))) begin
    end
    else
      sectored_entries_0_7_data_3 <= _sectored_entries_0_7_data_idx_7;
    sectored_entries_0_7_valid_0 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_87 ? ~(~sectored_entries_0_7_tag_v & sectored_entries_0_7_data_0[0] | _GEN_83) & _GEN_592 : ~_GEN_83 & _GEN_592) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_7_tag_v & ~(sectored_entries_0_7_data_0[20])) & _GEN_592 : sectored_entries_0_7_tag_v & _GEN_592) : _GEN_592);
    sectored_entries_0_7_valid_1 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_87 ? ~(~sectored_entries_0_7_tag_v & sectored_entries_0_7_data_1[0] | _GEN_84) & _GEN_593 : ~_GEN_84 & _GEN_593) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_7_tag_v & ~(sectored_entries_0_7_data_1[20])) & _GEN_593 : sectored_entries_0_7_tag_v & _GEN_593) : _GEN_593);
    sectored_entries_0_7_valid_2 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_87 ? ~(~sectored_entries_0_7_tag_v & sectored_entries_0_7_data_2[0] | _GEN_85) & _GEN_594 : ~_GEN_85 & _GEN_594) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_7_tag_v & ~(sectored_entries_0_7_data_2[20])) & _GEN_594 : sectored_entries_0_7_tag_v & _GEN_594) : _GEN_594);
    sectored_entries_0_7_valid_3 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_87 ? ~(~sectored_entries_0_7_tag_v & sectored_entries_0_7_data_3[0] | _GEN_86) & _GEN_595 : ~_GEN_86 & _GEN_595) : io_sfence_bits_rs2 ? ~(~sectored_entries_0_7_tag_v & ~(sectored_entries_0_7_data_3[20])) & _GEN_595 : sectored_entries_0_7_tag_v & _GEN_595) : _GEN_595);
    if (_GEN_24) begin
      superpage_entries_0_level <= _GEN_11;
      superpage_entries_0_tag_vpn <= r_refill_tag;
      superpage_entries_0_tag_v <= refill_v;
      superpage_entries_0_data_0 <= {io_ptw_resp_bits_pte_ppn[19:0], io_ptw_resp_bits_pte_u, newEntry_g, io_ptw_resp_bits_ae_ptw, io_ptw_resp_bits_ae_final, newEntry_ae_stage2, io_ptw_resp_bits_pf, io_ptw_resp_bits_gf, newEntry_sw, newEntry_sx, newEntry_sr, io_ptw_resp_bits_hw, io_ptw_resp_bits_hx, io_ptw_resp_bits_hr, prot_w, prot_x, prot_r, prot_pp, prot_al, prot_aa, prot_eff, cacheable, 1'h0};
    end
    superpage_entries_0_valid_0 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_88 ? ~(~superpage_entries_0_tag_v & superpage_entries_0_data_0[0] | _GEN_89) & _GEN_498 : ~_GEN_89 & _GEN_498) : io_sfence_bits_rs2 ? ~(~superpage_entries_0_tag_v & ~(superpage_entries_0_data_0[20])) & _GEN_498 : superpage_entries_0_tag_v & _GEN_498) : _GEN_498);
    if (_GEN_25) begin
      superpage_entries_1_level <= _GEN_11;
      superpage_entries_1_tag_vpn <= r_refill_tag;
      superpage_entries_1_tag_v <= refill_v;
      superpage_entries_1_data_0 <= {io_ptw_resp_bits_pte_ppn[19:0], io_ptw_resp_bits_pte_u, newEntry_g, io_ptw_resp_bits_ae_ptw, io_ptw_resp_bits_ae_final, newEntry_ae_stage2, io_ptw_resp_bits_pf, io_ptw_resp_bits_gf, newEntry_sw, newEntry_sx, newEntry_sr, io_ptw_resp_bits_hw, io_ptw_resp_bits_hx, io_ptw_resp_bits_hr, prot_w, prot_x, prot_r, prot_pp, prot_al, prot_aa, prot_eff, cacheable, 1'h0};
    end
    superpage_entries_1_valid_0 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_90 ? ~(~superpage_entries_1_tag_v & superpage_entries_1_data_0[0] | _GEN_91) & _GEN_503 : ~_GEN_91 & _GEN_503) : io_sfence_bits_rs2 ? ~(~superpage_entries_1_tag_v & ~(superpage_entries_1_data_0[20])) & _GEN_503 : superpage_entries_1_tag_v & _GEN_503) : _GEN_503);
    if (_GEN_26) begin
      superpage_entries_2_level <= _GEN_11;
      superpage_entries_2_tag_vpn <= r_refill_tag;
      superpage_entries_2_tag_v <= refill_v;
      superpage_entries_2_data_0 <= {io_ptw_resp_bits_pte_ppn[19:0], io_ptw_resp_bits_pte_u, newEntry_g, io_ptw_resp_bits_ae_ptw, io_ptw_resp_bits_ae_final, newEntry_ae_stage2, io_ptw_resp_bits_pf, io_ptw_resp_bits_gf, newEntry_sw, newEntry_sx, newEntry_sr, io_ptw_resp_bits_hw, io_ptw_resp_bits_hx, io_ptw_resp_bits_hr, prot_w, prot_x, prot_r, prot_pp, prot_al, prot_aa, prot_eff, cacheable, 1'h0};
    end
    superpage_entries_2_valid_0 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_92 ? ~(~superpage_entries_2_tag_v & superpage_entries_2_data_0[0] | _GEN_93) & _GEN_508 : ~_GEN_93 & _GEN_508) : io_sfence_bits_rs2 ? ~(~superpage_entries_2_tag_v & ~(superpage_entries_2_data_0[20])) & _GEN_508 : superpage_entries_2_tag_v & _GEN_508) : _GEN_508);
    if (_GEN_27) begin
      superpage_entries_3_level <= _GEN_11;
      superpage_entries_3_tag_vpn <= r_refill_tag;
      superpage_entries_3_tag_v <= refill_v;
      superpage_entries_3_data_0 <= {io_ptw_resp_bits_pte_ppn[19:0], io_ptw_resp_bits_pte_u, newEntry_g, io_ptw_resp_bits_ae_ptw, io_ptw_resp_bits_ae_final, newEntry_ae_stage2, io_ptw_resp_bits_pf, io_ptw_resp_bits_gf, newEntry_sw, newEntry_sx, newEntry_sr, io_ptw_resp_bits_hw, io_ptw_resp_bits_hx, io_ptw_resp_bits_hr, prot_w, prot_x, prot_r, prot_pp, prot_al, prot_aa, prot_eff, cacheable, 1'h0};
    end
    superpage_entries_3_valid_0 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_94 ? ~(~superpage_entries_3_tag_v & superpage_entries_3_data_0[0] | _GEN_95) & _GEN_513 : ~_GEN_95 & _GEN_513) : io_sfence_bits_rs2 ? ~(~superpage_entries_3_tag_v & ~(superpage_entries_3_data_0[20])) & _GEN_513 : superpage_entries_3_tag_v & _GEN_513) : _GEN_513);
    if (_GEN_23) begin
      special_entry_level <= io_ptw_resp_bits_level;
      special_entry_tag_vpn <= r_refill_tag;
      special_entry_tag_v <= refill_v;
      special_entry_data_0 <= {io_ptw_resp_bits_pte_ppn[19:0], io_ptw_resp_bits_pte_u, newEntry_g, io_ptw_resp_bits_ae_ptw, io_ptw_resp_bits_ae_final, newEntry_ae_stage2, io_ptw_resp_bits_pf, io_ptw_resp_bits_gf, newEntry_sw, newEntry_sx, newEntry_sr, io_ptw_resp_bits_hw, io_ptw_resp_bits_hx, io_ptw_resp_bits_hr, prot_w, prot_x, prot_r, prot_pp, prot_al, prot_aa, prot_eff, cacheable, 1'h0};
    end
    special_entry_valid_0 <= ~_GEN_98 & (io_sfence_valid ? (io_sfence_bits_rs1 ? (_GEN_96 ? ~(~special_entry_tag_v & special_entry_data_0[0] | _GEN_97) & _GEN_493 : ~_GEN_97 & _GEN_493) : io_sfence_bits_rs2 ? ~(~special_entry_tag_v & ~(special_entry_data_0[20])) & _GEN_493 : special_entry_tag_v & _GEN_493) : _GEN_493);
    if (_GEN_38) begin
      r_refill_tag <= io_req_bits_vaddr[38:12];
      if (&{superpage_entries_3_valid_0, superpage_entries_2_valid_0, superpage_entries_1_valid_0, superpage_entries_0_valid_0})
        waddr <= {state_reg_1[2], state_reg_1[2] ? state_reg_1[1] : state_reg_1[0]};
      else if (_r_superpage_repl_addr_T_5[0])
        waddr <= 2'h0;
      else if (_r_superpage_repl_addr_T_5[1])
        waddr <= 2'h1;
      else
        waddr <= {1'h1, ~(_r_superpage_repl_addr_T_5[2])};
      if (&{_r_sectored_repl_addr_valids_T_21 | sectored_entries_0_7_valid_2 | sectored_entries_0_7_valid_3, _r_sectored_repl_addr_valids_T_20, _r_sectored_repl_addr_valids_T_17, _r_sectored_repl_addr_valids_T_14, _r_sectored_repl_addr_valids_T_11, _r_sectored_repl_addr_valids_T_8, _r_sectored_repl_addr_valids_T_5, _r_sectored_repl_addr_valids_T_2})
        r_sectored_repl_addr <= {state_vec_0[6], state_vec_0[6] ? {state_vec_0[5], state_vec_0[5] ? state_vec_0[4] : state_vec_0[3]} : {state_vec_0[2], state_vec_0[2] ? state_vec_0[1] : state_vec_0[0]}};
      else if (_r_sectored_repl_addr_T_11[0])
        r_sectored_repl_addr <= 3'h0;
      else if (_r_sectored_repl_addr_T_11[1])
        r_sectored_repl_addr <= 3'h1;
      else if (_r_sectored_repl_addr_T_11[2])
        r_sectored_repl_addr <= 3'h2;
      else if (_r_sectored_repl_addr_T_11[3])
        r_sectored_repl_addr <= 3'h3;
      else if (_r_sectored_repl_addr_T_11[4])
        r_sectored_repl_addr <= 3'h4;
      else if (_r_sectored_repl_addr_T_11[5])
        r_sectored_repl_addr <= 3'h5;
      else
        r_sectored_repl_addr <= {2'h3, ~(_r_sectored_repl_addr_T_11[6])};
      r_sectored_hit_valid <= _r_sectored_hit_valid_T | sector_hits_2 | sector_hits_3 | sector_hits_4 | sector_hits_5 | sector_hits_6 | sector_hits_7;
      r_sectored_hit_bits <= {|{sector_hits_7, sector_hits_6, sector_hits_5, sector_hits_4}, |(_r_sectored_hit_bits_T_2[2:1]), _r_sectored_hit_bits_T_2[2] | _r_sectored_hit_bits_T_2[0]};
      r_need_gpa <= |real_hits;
    end
    r_vstage1_en <= ~_GEN_38 & r_vstage1_en;
    r_stage2_en <= ~_GEN_38 & r_stage2_en;
    if (reset) begin
      state <= 2'h0;
      state_vec_0 <= 7'h0;
      state_reg_1 <= 3'h0;
    end
    else begin
      if (io_ptw_resp_valid)
        state <= 2'h0;
      else if (state == 2'h2 & io_sfence_valid)
        state <= 2'h3;
      else if (_io_ptw_req_valid_T) begin
        if (io_ptw_req_ready)
          state <= {1'h1, io_sfence_valid};
        else if (io_sfence_valid)
          state <= 2'h0;
        else if (_GEN_38)
          state <= 2'h1;
      end
      else if (_GEN_38)
        state <= 2'h1;
      if (_GEN_4 & (_r_sectored_hit_valid_T | sector_hits_2 | sector_hits_3 | sector_hits_4 | sector_hits_5 | sector_hits_6 | sector_hits_7))
        state_vec_0 <= {~(|hi_1), (|hi_1) ? {~(|(_GEN_99[2:1])), (|(_GEN_99[2:1])) ? ~_state_vec_0_T_6 : state_vec_0[4], (|(_GEN_99[2:1])) ? state_vec_0[3] : ~_state_vec_0_T_6} : state_vec_0[5:3], (|hi_1) ? state_vec_0[2:0] : {~(|(_GEN_99[2:1])), (|(_GEN_99[2:1])) ? ~_state_vec_0_T_6 : state_vec_0[1], (|(_GEN_99[2:1])) ? state_vec_0[0] : ~_state_vec_0_T_6}};
      if (_GEN_4 & (superpage_entries_0_valid_0 & ~superpage_entries_0_tag_v & _hitsVec_T_58[17:9] == 9'h0 & (ignore_1 | _hitsVec_T_58[8:0] == 9'h0) | superpage_hits_1 | superpage_hits_2 | superpage_hits_3))
        state_reg_1 <= {~(|hi_4), (|hi_4) ? ~_state_reg_T_5 : state_reg_1[1], (|hi_4) ? state_reg_1[0] : ~_state_reg_T_5};
    end
  end // always @(posedge)
  OptimizationBarrier mpu_ppn_barrier (
    .io_x_ppn      (special_entry_data_0[41:22]),
    .io_x_u        (special_entry_data_0[21]),
    .io_x_ae_ptw   (special_entry_data_0[19]),
    .io_x_ae_final (special_entry_data_0[18]),
    .io_x_pf       (special_entry_data_0[16]),
    .io_x_gf       (special_entry_data_0[15]),
    .io_x_sx       (special_entry_data_0[13]),
    .io_x_px       (special_entry_data_0[7]),
    .io_y_ppn      (_mpu_ppn_barrier_io_y_ppn),
    .io_y_u        (/* unused */),
    .io_y_ae_ptw   (/* unused */),
    .io_y_ae_final (/* unused */),
    .io_y_pf       (/* unused */),
    .io_y_gf       (/* unused */),
    .io_y_sx       (/* unused */),
    .io_y_px       (/* unused */)
  );
  PMPChecker pmp (
    .io_prv         (mpu_priv[1:0]),
    .io_pmp_0_cfg_l (io_ptw_pmp_0_cfg_l),
    .io_pmp_0_cfg_a (io_ptw_pmp_0_cfg_a),
    .io_pmp_0_cfg_x (io_ptw_pmp_0_cfg_x),
    .io_pmp_0_cfg_w (io_ptw_pmp_0_cfg_w),
    .io_pmp_0_cfg_r (io_ptw_pmp_0_cfg_r),
    .io_pmp_0_addr  (io_ptw_pmp_0_addr),
    .io_pmp_0_mask  (io_ptw_pmp_0_mask),
    .io_pmp_1_cfg_l (io_ptw_pmp_1_cfg_l),
    .io_pmp_1_cfg_a (io_ptw_pmp_1_cfg_a),
    .io_pmp_1_cfg_x (io_ptw_pmp_1_cfg_x),
    .io_pmp_1_cfg_w (io_ptw_pmp_1_cfg_w),
    .io_pmp_1_cfg_r (io_ptw_pmp_1_cfg_r),
    .io_pmp_1_addr  (io_ptw_pmp_1_addr),
    .io_pmp_1_mask  (io_ptw_pmp_1_mask),
    .io_pmp_2_cfg_l (io_ptw_pmp_2_cfg_l),
    .io_pmp_2_cfg_a (io_ptw_pmp_2_cfg_a),
    .io_pmp_2_cfg_x (io_ptw_pmp_2_cfg_x),
    .io_pmp_2_cfg_w (io_ptw_pmp_2_cfg_w),
    .io_pmp_2_cfg_r (io_ptw_pmp_2_cfg_r),
    .io_pmp_2_addr  (io_ptw_pmp_2_addr),
    .io_pmp_2_mask  (io_ptw_pmp_2_mask),
    .io_pmp_3_cfg_l (io_ptw_pmp_3_cfg_l),
    .io_pmp_3_cfg_a (io_ptw_pmp_3_cfg_a),
    .io_pmp_3_cfg_x (io_ptw_pmp_3_cfg_x),
    .io_pmp_3_cfg_w (io_ptw_pmp_3_cfg_w),
    .io_pmp_3_cfg_r (io_ptw_pmp_3_cfg_r),
    .io_pmp_3_addr  (io_ptw_pmp_3_addr),
    .io_pmp_3_mask  (io_ptw_pmp_3_mask),
    .io_pmp_4_cfg_l (io_ptw_pmp_4_cfg_l),
    .io_pmp_4_cfg_a (io_ptw_pmp_4_cfg_a),
    .io_pmp_4_cfg_x (io_ptw_pmp_4_cfg_x),
    .io_pmp_4_cfg_w (io_ptw_pmp_4_cfg_w),
    .io_pmp_4_cfg_r (io_ptw_pmp_4_cfg_r),
    .io_pmp_4_addr  (io_ptw_pmp_4_addr),
    .io_pmp_4_mask  (io_ptw_pmp_4_mask),
    .io_pmp_5_cfg_l (io_ptw_pmp_5_cfg_l),
    .io_pmp_5_cfg_a (io_ptw_pmp_5_cfg_a),
    .io_pmp_5_cfg_x (io_ptw_pmp_5_cfg_x),
    .io_pmp_5_cfg_w (io_ptw_pmp_5_cfg_w),
    .io_pmp_5_cfg_r (io_ptw_pmp_5_cfg_r),
    .io_pmp_5_addr  (io_ptw_pmp_5_addr),
    .io_pmp_5_mask  (io_ptw_pmp_5_mask),
    .io_pmp_6_cfg_l (io_ptw_pmp_6_cfg_l),
    .io_pmp_6_cfg_a (io_ptw_pmp_6_cfg_a),
    .io_pmp_6_cfg_x (io_ptw_pmp_6_cfg_x),
    .io_pmp_6_cfg_w (io_ptw_pmp_6_cfg_w),
    .io_pmp_6_cfg_r (io_ptw_pmp_6_cfg_r),
    .io_pmp_6_addr  (io_ptw_pmp_6_addr),
    .io_pmp_6_mask  (io_ptw_pmp_6_mask),
    .io_pmp_7_cfg_l (io_ptw_pmp_7_cfg_l),
    .io_pmp_7_cfg_a (io_ptw_pmp_7_cfg_a),
    .io_pmp_7_cfg_x (io_ptw_pmp_7_cfg_x),
    .io_pmp_7_cfg_w (io_ptw_pmp_7_cfg_w),
    .io_pmp_7_cfg_r (io_ptw_pmp_7_cfg_r),
    .io_pmp_7_addr  (io_ptw_pmp_7_addr),
    .io_pmp_7_mask  (io_ptw_pmp_7_mask),
    .io_addr        ({mpu_ppn[19:0], io_req_bits_vaddr[11:0]}),
    .io_r           (_pmp_io_r),
    .io_w           (_pmp_io_w),
    .io_x           (_pmp_io_x)
  );
  OptimizationBarrier entries_barrier (
    .io_x_ppn      (casez_tmp_7[41:22]),
    .io_x_u        (casez_tmp_7[21]),
    .io_x_ae_ptw   (casez_tmp_7[19]),
    .io_x_ae_final (casez_tmp_7[18]),
    .io_x_pf       (casez_tmp_7[16]),
    .io_x_gf       (casez_tmp_7[15]),
    .io_x_sx       (casez_tmp_7[13]),
    .io_x_px       (casez_tmp_7[7]),
    .io_y_ppn      (_entries_barrier_io_y_ppn),
    .io_y_u        (_entries_barrier_io_y_u),
    .io_y_ae_ptw   (_entries_barrier_io_y_ae_ptw),
    .io_y_ae_final (_entries_barrier_io_y_ae_final),
    .io_y_pf       (_entries_barrier_io_y_pf),
    .io_y_gf       (_entries_barrier_io_y_gf),
    .io_y_sx       (_entries_barrier_io_y_sx),
    .io_y_px       (_entries_barrier_io_y_px)
  );
  OptimizationBarrier entries_barrier_1 (
    .io_x_ppn      (casez_tmp_8[41:22]),
    .io_x_u        (casez_tmp_8[21]),
    .io_x_ae_ptw   (casez_tmp_8[19]),
    .io_x_ae_final (casez_tmp_8[18]),
    .io_x_pf       (casez_tmp_8[16]),
    .io_x_gf       (casez_tmp_8[15]),
    .io_x_sx       (casez_tmp_8[13]),
    .io_x_px       (casez_tmp_8[7]),
    .io_y_ppn      (_entries_barrier_1_io_y_ppn),
    .io_y_u        (_entries_barrier_1_io_y_u),
    .io_y_ae_ptw   (_entries_barrier_1_io_y_ae_ptw),
    .io_y_ae_final (_entries_barrier_1_io_y_ae_final),
    .io_y_pf       (_entries_barrier_1_io_y_pf),
    .io_y_gf       (_entries_barrier_1_io_y_gf),
    .io_y_sx       (_entries_barrier_1_io_y_sx),
    .io_y_px       (_entries_barrier_1_io_y_px)
  );
  OptimizationBarrier entries_barrier_2 (
    .io_x_ppn      (casez_tmp_9[41:22]),
    .io_x_u        (casez_tmp_9[21]),
    .io_x_ae_ptw   (casez_tmp_9[19]),
    .io_x_ae_final (casez_tmp_9[18]),
    .io_x_pf       (casez_tmp_9[16]),
    .io_x_gf       (casez_tmp_9[15]),
    .io_x_sx       (casez_tmp_9[13]),
    .io_x_px       (casez_tmp_9[7]),
    .io_y_ppn      (_entries_barrier_2_io_y_ppn),
    .io_y_u        (_entries_barrier_2_io_y_u),
    .io_y_ae_ptw   (_entries_barrier_2_io_y_ae_ptw),
    .io_y_ae_final (_entries_barrier_2_io_y_ae_final),
    .io_y_pf       (_entries_barrier_2_io_y_pf),
    .io_y_gf       (_entries_barrier_2_io_y_gf),
    .io_y_sx       (_entries_barrier_2_io_y_sx),
    .io_y_px       (_entries_barrier_2_io_y_px)
  );
  OptimizationBarrier entries_barrier_3 (
    .io_x_ppn      (casez_tmp_10[41:22]),
    .io_x_u        (casez_tmp_10[21]),
    .io_x_ae_ptw   (casez_tmp_10[19]),
    .io_x_ae_final (casez_tmp_10[18]),
    .io_x_pf       (casez_tmp_10[16]),
    .io_x_gf       (casez_tmp_10[15]),
    .io_x_sx       (casez_tmp_10[13]),
    .io_x_px       (casez_tmp_10[7]),
    .io_y_ppn      (_entries_barrier_3_io_y_ppn),
    .io_y_u        (_entries_barrier_3_io_y_u),
    .io_y_ae_ptw   (_entries_barrier_3_io_y_ae_ptw),
    .io_y_ae_final (_entries_barrier_3_io_y_ae_final),
    .io_y_pf       (_entries_barrier_3_io_y_pf),
    .io_y_gf       (_entries_barrier_3_io_y_gf),
    .io_y_sx       (_entries_barrier_3_io_y_sx),
    .io_y_px       (_entries_barrier_3_io_y_px)
  );
  OptimizationBarrier entries_barrier_4 (
    .io_x_ppn      (casez_tmp_11[41:22]),
    .io_x_u        (casez_tmp_11[21]),
    .io_x_ae_ptw   (casez_tmp_11[19]),
    .io_x_ae_final (casez_tmp_11[18]),
    .io_x_pf       (casez_tmp_11[16]),
    .io_x_gf       (casez_tmp_11[15]),
    .io_x_sx       (casez_tmp_11[13]),
    .io_x_px       (casez_tmp_11[7]),
    .io_y_ppn      (_entries_barrier_4_io_y_ppn),
    .io_y_u        (_entries_barrier_4_io_y_u),
    .io_y_ae_ptw   (_entries_barrier_4_io_y_ae_ptw),
    .io_y_ae_final (_entries_barrier_4_io_y_ae_final),
    .io_y_pf       (_entries_barrier_4_io_y_pf),
    .io_y_gf       (_entries_barrier_4_io_y_gf),
    .io_y_sx       (_entries_barrier_4_io_y_sx),
    .io_y_px       (_entries_barrier_4_io_y_px)
  );
  OptimizationBarrier entries_barrier_5 (
    .io_x_ppn      (casez_tmp_12[41:22]),
    .io_x_u        (casez_tmp_12[21]),
    .io_x_ae_ptw   (casez_tmp_12[19]),
    .io_x_ae_final (casez_tmp_12[18]),
    .io_x_pf       (casez_tmp_12[16]),
    .io_x_gf       (casez_tmp_12[15]),
    .io_x_sx       (casez_tmp_12[13]),
    .io_x_px       (casez_tmp_12[7]),
    .io_y_ppn      (_entries_barrier_5_io_y_ppn),
    .io_y_u        (_entries_barrier_5_io_y_u),
    .io_y_ae_ptw   (_entries_barrier_5_io_y_ae_ptw),
    .io_y_ae_final (_entries_barrier_5_io_y_ae_final),
    .io_y_pf       (_entries_barrier_5_io_y_pf),
    .io_y_gf       (_entries_barrier_5_io_y_gf),
    .io_y_sx       (_entries_barrier_5_io_y_sx),
    .io_y_px       (_entries_barrier_5_io_y_px)
  );
  OptimizationBarrier entries_barrier_6 (
    .io_x_ppn      (casez_tmp_13[41:22]),
    .io_x_u        (casez_tmp_13[21]),
    .io_x_ae_ptw   (casez_tmp_13[19]),
    .io_x_ae_final (casez_tmp_13[18]),
    .io_x_pf       (casez_tmp_13[16]),
    .io_x_gf       (casez_tmp_13[15]),
    .io_x_sx       (casez_tmp_13[13]),
    .io_x_px       (casez_tmp_13[7]),
    .io_y_ppn      (_entries_barrier_6_io_y_ppn),
    .io_y_u        (_entries_barrier_6_io_y_u),
    .io_y_ae_ptw   (_entries_barrier_6_io_y_ae_ptw),
    .io_y_ae_final (_entries_barrier_6_io_y_ae_final),
    .io_y_pf       (_entries_barrier_6_io_y_pf),
    .io_y_gf       (_entries_barrier_6_io_y_gf),
    .io_y_sx       (_entries_barrier_6_io_y_sx),
    .io_y_px       (_entries_barrier_6_io_y_px)
  );
  OptimizationBarrier entries_barrier_7 (
    .io_x_ppn      (casez_tmp_14[41:22]),
    .io_x_u        (casez_tmp_14[21]),
    .io_x_ae_ptw   (casez_tmp_14[19]),
    .io_x_ae_final (casez_tmp_14[18]),
    .io_x_pf       (casez_tmp_14[16]),
    .io_x_gf       (casez_tmp_14[15]),
    .io_x_sx       (casez_tmp_14[13]),
    .io_x_px       (casez_tmp_14[7]),
    .io_y_ppn      (_entries_barrier_7_io_y_ppn),
    .io_y_u        (_entries_barrier_7_io_y_u),
    .io_y_ae_ptw   (_entries_barrier_7_io_y_ae_ptw),
    .io_y_ae_final (_entries_barrier_7_io_y_ae_final),
    .io_y_pf       (_entries_barrier_7_io_y_pf),
    .io_y_gf       (_entries_barrier_7_io_y_gf),
    .io_y_sx       (_entries_barrier_7_io_y_sx),
    .io_y_px       (_entries_barrier_7_io_y_px)
  );
  OptimizationBarrier entries_barrier_8 (
    .io_x_ppn      (superpage_entries_0_data_0[41:22]),
    .io_x_u        (superpage_entries_0_data_0[21]),
    .io_x_ae_ptw   (superpage_entries_0_data_0[19]),
    .io_x_ae_final (superpage_entries_0_data_0[18]),
    .io_x_pf       (superpage_entries_0_data_0[16]),
    .io_x_gf       (superpage_entries_0_data_0[15]),
    .io_x_sx       (superpage_entries_0_data_0[13]),
    .io_x_px       (superpage_entries_0_data_0[7]),
    .io_y_ppn      (_entries_barrier_8_io_y_ppn),
    .io_y_u        (_entries_barrier_8_io_y_u),
    .io_y_ae_ptw   (_entries_barrier_8_io_y_ae_ptw),
    .io_y_ae_final (_entries_barrier_8_io_y_ae_final),
    .io_y_pf       (_entries_barrier_8_io_y_pf),
    .io_y_gf       (_entries_barrier_8_io_y_gf),
    .io_y_sx       (_entries_barrier_8_io_y_sx),
    .io_y_px       (_entries_barrier_8_io_y_px)
  );
  OptimizationBarrier entries_barrier_9 (
    .io_x_ppn      (superpage_entries_1_data_0[41:22]),
    .io_x_u        (superpage_entries_1_data_0[21]),
    .io_x_ae_ptw   (superpage_entries_1_data_0[19]),
    .io_x_ae_final (superpage_entries_1_data_0[18]),
    .io_x_pf       (superpage_entries_1_data_0[16]),
    .io_x_gf       (superpage_entries_1_data_0[15]),
    .io_x_sx       (superpage_entries_1_data_0[13]),
    .io_x_px       (superpage_entries_1_data_0[7]),
    .io_y_ppn      (_entries_barrier_9_io_y_ppn),
    .io_y_u        (_entries_barrier_9_io_y_u),
    .io_y_ae_ptw   (_entries_barrier_9_io_y_ae_ptw),
    .io_y_ae_final (_entries_barrier_9_io_y_ae_final),
    .io_y_pf       (_entries_barrier_9_io_y_pf),
    .io_y_gf       (_entries_barrier_9_io_y_gf),
    .io_y_sx       (_entries_barrier_9_io_y_sx),
    .io_y_px       (_entries_barrier_9_io_y_px)
  );
  OptimizationBarrier entries_barrier_10 (
    .io_x_ppn      (superpage_entries_2_data_0[41:22]),
    .io_x_u        (superpage_entries_2_data_0[21]),
    .io_x_ae_ptw   (superpage_entries_2_data_0[19]),
    .io_x_ae_final (superpage_entries_2_data_0[18]),
    .io_x_pf       (superpage_entries_2_data_0[16]),
    .io_x_gf       (superpage_entries_2_data_0[15]),
    .io_x_sx       (superpage_entries_2_data_0[13]),
    .io_x_px       (superpage_entries_2_data_0[7]),
    .io_y_ppn      (_entries_barrier_10_io_y_ppn),
    .io_y_u        (_entries_barrier_10_io_y_u),
    .io_y_ae_ptw   (_entries_barrier_10_io_y_ae_ptw),
    .io_y_ae_final (_entries_barrier_10_io_y_ae_final),
    .io_y_pf       (_entries_barrier_10_io_y_pf),
    .io_y_gf       (_entries_barrier_10_io_y_gf),
    .io_y_sx       (_entries_barrier_10_io_y_sx),
    .io_y_px       (_entries_barrier_10_io_y_px)
  );
  OptimizationBarrier entries_barrier_11 (
    .io_x_ppn      (superpage_entries_3_data_0[41:22]),
    .io_x_u        (superpage_entries_3_data_0[21]),
    .io_x_ae_ptw   (superpage_entries_3_data_0[19]),
    .io_x_ae_final (superpage_entries_3_data_0[18]),
    .io_x_pf       (superpage_entries_3_data_0[16]),
    .io_x_gf       (superpage_entries_3_data_0[15]),
    .io_x_sx       (superpage_entries_3_data_0[13]),
    .io_x_px       (superpage_entries_3_data_0[7]),
    .io_y_ppn      (_entries_barrier_11_io_y_ppn),
    .io_y_u        (_entries_barrier_11_io_y_u),
    .io_y_ae_ptw   (_entries_barrier_11_io_y_ae_ptw),
    .io_y_ae_final (_entries_barrier_11_io_y_ae_final),
    .io_y_pf       (_entries_barrier_11_io_y_pf),
    .io_y_gf       (_entries_barrier_11_io_y_gf),
    .io_y_sx       (_entries_barrier_11_io_y_sx),
    .io_y_px       (_entries_barrier_11_io_y_px)
  );
  OptimizationBarrier entries_barrier_12 (
    .io_x_ppn      (special_entry_data_0[41:22]),
    .io_x_u        (special_entry_data_0[21]),
    .io_x_ae_ptw   (special_entry_data_0[19]),
    .io_x_ae_final (special_entry_data_0[18]),
    .io_x_pf       (special_entry_data_0[16]),
    .io_x_gf       (special_entry_data_0[15]),
    .io_x_sx       (special_entry_data_0[13]),
    .io_x_px       (special_entry_data_0[7]),
    .io_y_ppn      (_entries_barrier_12_io_y_ppn),
    .io_y_u        (_entries_barrier_12_io_y_u),
    .io_y_ae_ptw   (_entries_barrier_12_io_y_ae_ptw),
    .io_y_ae_final (_entries_barrier_12_io_y_ae_final),
    .io_y_pf       (_entries_barrier_12_io_y_pf),
    .io_y_gf       (_entries_barrier_12_io_y_gf),
    .io_y_sx       (_entries_barrier_12_io_y_sx),
    .io_y_px       (/* unused */)
  );
  assign io_resp_miss = io_ptw_resp_valid | tlb_miss | multipleHits;
  assign io_resp_paddr = {(hitsVec_0 ? _entries_barrier_io_y_ppn : 20'h0) | (hitsVec_1 ? _entries_barrier_1_io_y_ppn : 20'h0) | (hitsVec_2 ? _entries_barrier_2_io_y_ppn : 20'h0) | (hitsVec_3 ? _entries_barrier_3_io_y_ppn : 20'h0) | (hitsVec_4 ? _entries_barrier_4_io_y_ppn : 20'h0) | (hitsVec_5 ? _entries_barrier_5_io_y_ppn : 20'h0) | (hitsVec_6 ? _entries_barrier_6_io_y_ppn : 20'h0) | (hitsVec_7 ? _entries_barrier_7_io_y_ppn : 20'h0) | (hitsVec_8 ? {_entries_barrier_8_io_y_ppn[19:18], (ignore_1 ? io_req_bits_vaddr[29:21] : 9'h0) | _entries_barrier_8_io_y_ppn[17:9], io_req_bits_vaddr[20:12] | _entries_barrier_8_io_y_ppn[8:0]} : 20'h0) | (hitsVec_9 ? {_entries_barrier_9_io_y_ppn[19:18], (ignore_4 ? io_req_bits_vaddr[29:21] : 9'h0) | _entries_barrier_9_io_y_ppn[17:9], io_req_bits_vaddr[20:12] | _entries_barrier_9_io_y_ppn[8:0]} : 20'h0) | (hitsVec_10 ? {_entries_barrier_10_io_y_ppn[19:18], (ignore_7 ? io_req_bits_vaddr[29:21] : 9'h0) | _entries_barrier_10_io_y_ppn[17:9], io_req_bits_vaddr[20:12] | _entries_barrier_10_io_y_ppn[8:0]} : 20'h0) | (hitsVec_11 ? {_entries_barrier_11_io_y_ppn[19:18], (ignore_10 ? io_req_bits_vaddr[29:21] : 9'h0) | _entries_barrier_11_io_y_ppn[17:9], io_req_bits_vaddr[20:12] | _entries_barrier_11_io_y_ppn[8:0]} : 20'h0) | (hitsVec_12 ? {_entries_barrier_12_io_y_ppn[19:18], (ignore_13 ? io_req_bits_vaddr[29:21] : 9'h0) | _entries_barrier_12_io_y_ppn[17:9], (special_entry_level[1] ? 9'h0 : io_req_bits_vaddr[20:12]) | _entries_barrier_12_io_y_ppn[8:0]} : 20'h0) | (_vm_enabled_T_1 ? 20'h0 : io_req_bits_vaddr[31:12]), io_req_bits_vaddr[11:0]};
  assign io_resp_pf_inst =
    bad_va
    | (|((~((io_req_bits_prv[0] ? ~{_entries_barrier_12_io_y_u, _entries_barrier_11_io_y_u, _entries_barrier_10_io_y_u, _entries_barrier_9_io_y_u, _entries_barrier_8_io_y_u, _entries_barrier_7_io_y_u, _entries_barrier_6_io_y_u, _entries_barrier_5_io_y_u, _entries_barrier_4_io_y_u, _entries_barrier_3_io_y_u, _entries_barrier_2_io_y_u, _entries_barrier_1_io_y_u, _entries_barrier_io_y_u} : {_entries_barrier_12_io_y_u, _entries_barrier_11_io_y_u, _entries_barrier_10_io_y_u, _entries_barrier_9_io_y_u, _entries_barrier_8_io_y_u, _entries_barrier_7_io_y_u, _entries_barrier_6_io_y_u, _entries_barrier_5_io_y_u, _entries_barrier_4_io_y_u, _entries_barrier_3_io_y_u, _entries_barrier_2_io_y_u, _entries_barrier_1_io_y_u, _entries_barrier_io_y_u}) & {_entries_barrier_12_io_y_sx, _entries_barrier_11_io_y_sx, _entries_barrier_10_io_y_sx, _entries_barrier_9_io_y_sx, _entries_barrier_8_io_y_sx, _entries_barrier_7_io_y_sx, _entries_barrier_6_io_y_sx, _entries_barrier_5_io_y_sx, _entries_barrier_4_io_y_sx, _entries_barrier_3_io_y_sx, _entries_barrier_2_io_y_sx, _entries_barrier_1_io_y_sx, _entries_barrier_io_y_sx}) & {~_entries_barrier_12_io_y_ae_ptw, ~_entries_barrier_11_io_y_ae_ptw, ~_entries_barrier_10_io_y_ae_ptw, ~_entries_barrier_9_io_y_ae_ptw, ~_entries_barrier_8_io_y_ae_ptw, ~_entries_barrier_7_io_y_ae_ptw, ~_entries_barrier_6_io_y_ae_ptw, ~_entries_barrier_5_io_y_ae_ptw, ~_entries_barrier_4_io_y_ae_ptw, ~_entries_barrier_3_io_y_ae_ptw, ~_entries_barrier_2_io_y_ae_ptw, ~_entries_barrier_1_io_y_ae_ptw, ~_entries_barrier_io_y_ae_ptw} | {_entries_barrier_12_io_y_pf, _entries_barrier_11_io_y_pf, _entries_barrier_10_io_y_pf, _entries_barrier_9_io_y_pf, _entries_barrier_8_io_y_pf, _entries_barrier_7_io_y_pf, _entries_barrier_6_io_y_pf, _entries_barrier_5_io_y_pf, _entries_barrier_4_io_y_pf, _entries_barrier_3_io_y_pf, _entries_barrier_2_io_y_pf, _entries_barrier_1_io_y_pf, _entries_barrier_io_y_pf})
         & {~_entries_barrier_12_io_y_gf, ~_entries_barrier_11_io_y_gf, ~_entries_barrier_10_io_y_gf, ~_entries_barrier_9_io_y_gf, ~_entries_barrier_8_io_y_gf, ~_entries_barrier_7_io_y_gf, ~_entries_barrier_6_io_y_gf, ~_entries_barrier_5_io_y_gf, ~_entries_barrier_4_io_y_gf, ~_entries_barrier_3_io_y_gf, ~_entries_barrier_2_io_y_gf, ~_entries_barrier_1_io_y_gf, ~_entries_barrier_io_y_gf} & {hitsVec_12, hitsVec_11, hitsVec_10, hitsVec_9, hitsVec_8, hitsVec_7, hitsVec_6, hitsVec_5, hitsVec_4, hitsVec_3, hitsVec_2, hitsVec_1, hitsVec_0}));
  assign io_resp_ae_inst = |(~({{2{prot_x}}, _entries_barrier_11_io_y_px, _entries_barrier_10_io_y_px, _entries_barrier_9_io_y_px, _entries_barrier_8_io_y_px, _entries_barrier_7_io_y_px, _entries_barrier_6_io_y_px, _entries_barrier_5_io_y_px, _entries_barrier_4_io_y_px, _entries_barrier_3_io_y_px, _entries_barrier_2_io_y_px, _entries_barrier_1_io_y_px, _entries_barrier_io_y_px} & {1'h1, ~(_entries_barrier_12_io_y_ae_ptw | _entries_barrier_12_io_y_ae_final), ~(_entries_barrier_11_io_y_ae_ptw | _entries_barrier_11_io_y_ae_final), ~(_entries_barrier_10_io_y_ae_ptw | _entries_barrier_10_io_y_ae_final), ~(_entries_barrier_9_io_y_ae_ptw | _entries_barrier_9_io_y_ae_final), ~(_entries_barrier_8_io_y_ae_ptw | _entries_barrier_8_io_y_ae_final), ~(_entries_barrier_7_io_y_ae_ptw | _entries_barrier_7_io_y_ae_final), ~(_entries_barrier_6_io_y_ae_ptw | _entries_barrier_6_io_y_ae_final), ~(_entries_barrier_5_io_y_ae_ptw | _entries_barrier_5_io_y_ae_final), ~(_entries_barrier_4_io_y_ae_ptw | _entries_barrier_4_io_y_ae_final), ~(_entries_barrier_3_io_y_ae_ptw | _entries_barrier_3_io_y_ae_final), ~(_entries_barrier_2_io_y_ae_ptw | _entries_barrier_2_io_y_ae_final), ~(_entries_barrier_1_io_y_ae_ptw | _entries_barrier_1_io_y_ae_final), ~(_entries_barrier_io_y_ae_ptw | _entries_barrier_io_y_ae_final)}) & {~_vm_enabled_T_1, hitsVec_12, hitsVec_11, hitsVec_10, hitsVec_9, hitsVec_8, hitsVec_7, hitsVec_6, hitsVec_5, hitsVec_4, hitsVec_3, hitsVec_2, hitsVec_1, hitsVec_0});
  assign io_ptw_req_valid = _io_ptw_req_valid_T;
  assign io_ptw_req_bits_bits_addr = r_refill_tag;
  assign io_ptw_req_bits_bits_need_gpa = r_need_gpa;
  assign io_ptw_req_bits_bits_vstage1 = r_vstage1_en;
  assign io_ptw_req_bits_bits_stage2 = r_stage2_en;
endmodule

