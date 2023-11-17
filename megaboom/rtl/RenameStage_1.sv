// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RenameStage_1(
  input        clock,
               reset,
               io_kill,
               io_dec_uops_0_is_br,
               io_dec_uops_0_is_jalr,
               io_dec_uops_0_is_sfb,
  input  [4:0] io_dec_uops_0_br_tag,
  input  [5:0] io_dec_uops_0_ldst,
               io_dec_uops_0_lrs1,
               io_dec_uops_0_lrs2,
               io_dec_uops_0_lrs3,
  input        io_dec_uops_0_ldst_val,
  input  [1:0] io_dec_uops_0_dst_rtype,
               io_dec_uops_0_lrs1_rtype,
               io_dec_uops_0_lrs2_rtype,
  input        io_dec_uops_0_frs3_en,
               io_dec_uops_1_is_br,
               io_dec_uops_1_is_jalr,
               io_dec_uops_1_is_sfb,
  input  [4:0] io_dec_uops_1_br_tag,
  input  [5:0] io_dec_uops_1_ldst,
               io_dec_uops_1_lrs1,
               io_dec_uops_1_lrs2,
               io_dec_uops_1_lrs3,
  input        io_dec_uops_1_ldst_val,
  input  [1:0] io_dec_uops_1_dst_rtype,
               io_dec_uops_1_lrs1_rtype,
               io_dec_uops_1_lrs2_rtype,
  input        io_dec_uops_1_frs3_en,
               io_dec_uops_2_is_br,
               io_dec_uops_2_is_jalr,
               io_dec_uops_2_is_sfb,
  input  [4:0] io_dec_uops_2_br_tag,
  input  [5:0] io_dec_uops_2_ldst,
               io_dec_uops_2_lrs1,
               io_dec_uops_2_lrs2,
               io_dec_uops_2_lrs3,
  input        io_dec_uops_2_ldst_val,
  input  [1:0] io_dec_uops_2_dst_rtype,
               io_dec_uops_2_lrs1_rtype,
               io_dec_uops_2_lrs2_rtype,
  input        io_dec_uops_2_frs3_en,
               io_dec_uops_3_is_br,
               io_dec_uops_3_is_jalr,
               io_dec_uops_3_is_sfb,
  input  [4:0] io_dec_uops_3_br_tag,
  input  [5:0] io_dec_uops_3_ldst,
               io_dec_uops_3_lrs1,
               io_dec_uops_3_lrs2,
               io_dec_uops_3_lrs3,
  input        io_dec_uops_3_ldst_val,
  input  [1:0] io_dec_uops_3_dst_rtype,
               io_dec_uops_3_lrs1_rtype,
               io_dec_uops_3_lrs2_rtype,
  input        io_dec_uops_3_frs3_en,
  input  [4:0] io_brupdate_b2_uop_br_tag,
  input        io_brupdate_b2_mispredict,
               io_dis_fire_0,
               io_dis_fire_1,
               io_dis_fire_2,
               io_dis_fire_3,
               io_dis_ready,
               io_wakeups_0_valid,
  input  [6:0] io_wakeups_0_bits_uop_pdst,
  input  [1:0] io_wakeups_0_bits_uop_dst_rtype,
  input        io_wakeups_1_valid,
  input  [6:0] io_wakeups_1_bits_uop_pdst,
  input  [1:0] io_wakeups_1_bits_uop_dst_rtype,
  input        io_wakeups_2_valid,
  input  [6:0] io_wakeups_2_bits_uop_pdst,
  input  [1:0] io_wakeups_2_bits_uop_dst_rtype,
  input        io_wakeups_3_valid,
  input  [6:0] io_wakeups_3_bits_uop_pdst,
  input  [1:0] io_wakeups_3_bits_uop_dst_rtype,
  input        io_com_valids_0,
               io_com_valids_1,
               io_com_valids_2,
               io_com_valids_3,
  input  [6:0] io_com_uops_0_pdst,
               io_com_uops_0_stale_pdst,
  input  [5:0] io_com_uops_0_ldst,
  input        io_com_uops_0_ldst_val,
  input  [1:0] io_com_uops_0_dst_rtype,
  input  [6:0] io_com_uops_1_pdst,
               io_com_uops_1_stale_pdst,
  input  [5:0] io_com_uops_1_ldst,
  input        io_com_uops_1_ldst_val,
  input  [1:0] io_com_uops_1_dst_rtype,
  input  [6:0] io_com_uops_2_pdst,
               io_com_uops_2_stale_pdst,
  input  [5:0] io_com_uops_2_ldst,
  input        io_com_uops_2_ldst_val,
  input  [1:0] io_com_uops_2_dst_rtype,
  input  [6:0] io_com_uops_3_pdst,
               io_com_uops_3_stale_pdst,
  input  [5:0] io_com_uops_3_ldst,
  input        io_com_uops_3_ldst_val,
  input  [1:0] io_com_uops_3_dst_rtype,
  input        io_rbk_valids_0,
               io_rbk_valids_1,
               io_rbk_valids_2,
               io_rbk_valids_3,
               io_rollback,
               io_debug_rob_empty,
  output       io_ren_stalls_0,
               io_ren_stalls_1,
               io_ren_stalls_2,
               io_ren_stalls_3,
  output [6:0] io_ren2_uops_0_pdst,
               io_ren2_uops_0_prs1,
               io_ren2_uops_0_prs2,
               io_ren2_uops_0_prs3,
  output       io_ren2_uops_0_prs1_busy,
               io_ren2_uops_0_prs2_busy,
               io_ren2_uops_0_prs3_busy,
  output [6:0] io_ren2_uops_0_stale_pdst,
               io_ren2_uops_1_pdst,
               io_ren2_uops_1_prs1,
               io_ren2_uops_1_prs2,
               io_ren2_uops_1_prs3,
  output       io_ren2_uops_1_prs1_busy,
               io_ren2_uops_1_prs2_busy,
               io_ren2_uops_1_prs3_busy,
  output [6:0] io_ren2_uops_1_stale_pdst,
               io_ren2_uops_2_pdst,
               io_ren2_uops_2_prs1,
               io_ren2_uops_2_prs2,
               io_ren2_uops_2_prs3,
  output       io_ren2_uops_2_prs1_busy,
               io_ren2_uops_2_prs2_busy,
               io_ren2_uops_2_prs3_busy,
  output [6:0] io_ren2_uops_2_stale_pdst,
               io_ren2_uops_3_pdst,
               io_ren2_uops_3_prs1,
               io_ren2_uops_3_prs2,
               io_ren2_uops_3_prs3,
  output       io_ren2_uops_3_prs1_busy,
               io_ren2_uops_3_prs2_busy,
               io_ren2_uops_3_prs3_busy,
  output [6:0] io_ren2_uops_3_stale_pdst
);

  wire       _busytable_io_busy_resps_0_prs1_busy;
  wire       _busytable_io_busy_resps_0_prs2_busy;
  wire       _busytable_io_busy_resps_0_prs3_busy;
  wire       _busytable_io_busy_resps_1_prs1_busy;
  wire       _busytable_io_busy_resps_1_prs2_busy;
  wire       _busytable_io_busy_resps_1_prs3_busy;
  wire       _busytable_io_busy_resps_2_prs1_busy;
  wire       _busytable_io_busy_resps_2_prs2_busy;
  wire       _busytable_io_busy_resps_2_prs3_busy;
  wire       _busytable_io_busy_resps_3_prs1_busy;
  wire       _busytable_io_busy_resps_3_prs2_busy;
  wire       _busytable_io_busy_resps_3_prs3_busy;
  wire       _freelist_io_alloc_pregs_0_valid;
  wire [6:0] _freelist_io_alloc_pregs_0_bits;
  wire       _freelist_io_alloc_pregs_1_valid;
  wire [6:0] _freelist_io_alloc_pregs_1_bits;
  wire       _freelist_io_alloc_pregs_2_valid;
  wire [6:0] _freelist_io_alloc_pregs_2_bits;
  wire       _freelist_io_alloc_pregs_3_valid;
  wire [6:0] _freelist_io_alloc_pregs_3_bits;
  wire [6:0] _maptable_io_map_resps_0_prs1;
  wire [6:0] _maptable_io_map_resps_0_prs2;
  wire [6:0] _maptable_io_map_resps_0_prs3;
  wire [6:0] _maptable_io_map_resps_0_stale_pdst;
  wire [6:0] _maptable_io_map_resps_1_prs1;
  wire [6:0] _maptable_io_map_resps_1_prs2;
  wire [6:0] _maptable_io_map_resps_1_prs3;
  wire [6:0] _maptable_io_map_resps_1_stale_pdst;
  wire [6:0] _maptable_io_map_resps_2_prs1;
  wire [6:0] _maptable_io_map_resps_2_prs2;
  wire [6:0] _maptable_io_map_resps_2_prs3;
  wire [6:0] _maptable_io_map_resps_2_stale_pdst;
  wire [6:0] _maptable_io_map_resps_3_prs1;
  wire [6:0] _maptable_io_map_resps_3_prs2;
  wire [6:0] _maptable_io_map_resps_3_prs3;
  wire [6:0] _maptable_io_map_resps_3_stale_pdst;
  reg        r_uop_is_br;
  reg        r_uop_is_jalr;
  reg        r_uop_is_sfb;
  reg  [4:0] r_uop_br_tag;
  reg  [6:0] r_uop_prs1;
  reg  [6:0] r_uop_prs2;
  reg  [6:0] r_uop_prs3;
  reg  [6:0] r_uop_stale_pdst;
  reg  [5:0] r_uop_ldst;
  reg  [5:0] r_uop_lrs1;
  reg  [5:0] r_uop_lrs2;
  reg  [5:0] r_uop_lrs3;
  reg        r_uop_ldst_val;
  reg  [1:0] r_uop_dst_rtype;
  reg  [1:0] r_uop_lrs1_rtype;
  reg  [1:0] r_uop_lrs2_rtype;
  reg        r_uop_frs3_en;
  wire       _io_ren_stalls_0_T = r_uop_dst_rtype == 2'h1;
  wire       ren2_alloc_reqs_0 = r_uop_ldst_val & _io_ren_stalls_0_T & io_dis_fire_0;
  reg  [5:0] r_uop_1_ldst;
  reg        r_uop_1_ldst_val;
  reg  [1:0] r_uop_1_dst_rtype;
  wire       _io_ren_stalls_1_T = r_uop_1_dst_rtype == 2'h1;
  wire       ren2_alloc_reqs_1 = r_uop_1_ldst_val & _io_ren_stalls_1_T & io_dis_fire_1;
  reg  [5:0] r_uop_2_ldst;
  reg        r_uop_2_ldst_val;
  reg  [1:0] r_uop_2_dst_rtype;
  wire       _io_ren_stalls_2_T = r_uop_2_dst_rtype == 2'h1;
  wire       ren2_alloc_reqs_2 = r_uop_2_ldst_val & _io_ren_stalls_2_T & io_dis_fire_2;
  reg  [5:0] r_uop_3_ldst;
  reg        r_uop_3_ldst_val;
  reg  [1:0] r_uop_3_dst_rtype;
  wire       _io_ren_stalls_3_T = r_uop_3_dst_rtype == 2'h1;
  wire       ren2_alloc_reqs_3 = r_uop_3_ldst_val & _io_ren_stalls_3_T & io_dis_fire_3;
  reg        r_uop_1_is_br;
  reg        r_uop_1_is_jalr;
  reg        r_uop_1_is_sfb;
  reg  [4:0] r_uop_1_br_tag;
  reg  [6:0] r_uop_1_prs1;
  reg  [6:0] r_uop_1_prs2;
  reg  [6:0] r_uop_1_prs3;
  reg  [6:0] r_uop_1_stale_pdst;
  reg  [5:0] r_uop_1_lrs1;
  reg  [5:0] r_uop_1_lrs2;
  reg  [5:0] r_uop_1_lrs3;
  reg  [1:0] r_uop_1_lrs1_rtype;
  reg  [1:0] r_uop_1_lrs2_rtype;
  reg        r_uop_1_frs3_en;
  reg        r_uop_2_is_br;
  reg        r_uop_2_is_jalr;
  reg        r_uop_2_is_sfb;
  reg  [4:0] r_uop_2_br_tag;
  reg  [6:0] r_uop_2_prs1;
  reg  [6:0] r_uop_2_prs2;
  reg  [6:0] r_uop_2_prs3;
  reg  [6:0] r_uop_2_stale_pdst;
  reg  [5:0] r_uop_2_lrs1;
  reg  [5:0] r_uop_2_lrs2;
  reg  [5:0] r_uop_2_lrs3;
  reg  [1:0] r_uop_2_lrs1_rtype;
  reg  [1:0] r_uop_2_lrs2_rtype;
  reg        r_uop_2_frs3_en;
  reg        r_uop_3_is_br;
  reg        r_uop_3_is_jalr;
  reg        r_uop_3_is_sfb;
  reg  [4:0] r_uop_3_br_tag;
  reg  [6:0] r_uop_3_prs1;
  reg  [6:0] r_uop_3_prs2;
  reg  [6:0] r_uop_3_prs3;
  reg  [6:0] r_uop_3_stale_pdst;
  reg  [5:0] r_uop_3_lrs1;
  reg  [5:0] r_uop_3_lrs2;
  reg  [5:0] r_uop_3_lrs3;
  reg  [1:0] r_uop_3_lrs1_rtype;
  reg  [1:0] r_uop_3_lrs2_rtype;
  reg        r_uop_3_frs3_en;
  wire       ren2_br_tags_0_valid = io_dis_fire_0 & (r_uop_is_br & ~r_uop_is_sfb | r_uop_is_jalr);
  wire       _rbk_valids_0_T = io_com_uops_0_dst_rtype == 2'h1;
  wire       rbk_valids_0 = io_com_uops_0_ldst_val & _rbk_valids_0_T & io_rbk_valids_0;
  wire       ren2_br_tags_1_valid = io_dis_fire_1 & (r_uop_1_is_br & ~r_uop_1_is_sfb | r_uop_1_is_jalr);
  wire       _rbk_valids_1_T = io_com_uops_1_dst_rtype == 2'h1;
  wire       rbk_valids_1 = io_com_uops_1_ldst_val & _rbk_valids_1_T & io_rbk_valids_1;
  wire       ren2_br_tags_2_valid = io_dis_fire_2 & (r_uop_2_is_br & ~r_uop_2_is_sfb | r_uop_2_is_jalr);
  wire       _rbk_valids_2_T = io_com_uops_2_dst_rtype == 2'h1;
  wire       rbk_valids_2 = io_com_uops_2_ldst_val & _rbk_valids_2_T & io_rbk_valids_2;
  wire       ren2_br_tags_3_valid = io_dis_fire_3 & (r_uop_3_is_br & ~r_uop_3_is_sfb | r_uop_3_is_jalr);
  wire       _rbk_valids_3_T = io_com_uops_3_dst_rtype == 2'h1;
  wire       rbk_valids_3 = io_com_uops_3_ldst_val & _rbk_valids_3_T & io_rbk_valids_3;
  wire       bypassed_uop_bypass_sel_rs1_0 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_1_lrs1;
  wire       bypassed_uop_bypass_sel_rs2_0 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_1_lrs2;
  wire       bypassed_uop_bypass_sel_rs3_0 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_1_lrs3;
  wire       bypassed_uop_bypass_hits_rs1_0_1 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_2_lrs1;
  wire       bypassed_uop_bypass_hits_rs1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_2_lrs1;
  wire       bypassed_uop_bypass_hits_rs2_0_1 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_2_lrs2;
  wire       bypassed_uop_bypass_hits_rs2_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_2_lrs2;
  wire       bypassed_uop_bypass_hits_rs3_0_1 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_2_lrs3;
  wire       bypassed_uop_bypass_hits_rs3_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_2_lrs3;
  wire       bypassed_uop_bypass_hits_dst_0_1 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_2_ldst;
  wire       bypassed_uop_bypass_hits_dst_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_2_ldst;
  wire [1:0] bypassed_uop_bypass_sel_rs1_enc_1 = bypassed_uop_bypass_hits_rs1_1 ? 2'h1 : {bypassed_uop_bypass_hits_rs1_0_1, 1'h0};
  wire [1:0] bypassed_uop_bypass_sel_rs2_enc_1 = bypassed_uop_bypass_hits_rs2_1 ? 2'h1 : {bypassed_uop_bypass_hits_rs2_0_1, 1'h0};
  wire [1:0] bypassed_uop_bypass_sel_rs3_enc_1 = bypassed_uop_bypass_hits_rs3_1 ? 2'h1 : {bypassed_uop_bypass_hits_rs3_0_1, 1'h0};
  wire [1:0] bypassed_uop_bypass_sel_dst_enc_1 = bypassed_uop_bypass_hits_dst_1 ? 2'h1 : {bypassed_uop_bypass_hits_dst_0_1, 1'h0};
  wire       bypassed_uop_do_bypass_rs1 = bypassed_uop_bypass_hits_rs1_0_1 | bypassed_uop_bypass_hits_rs1_1;
  wire       bypassed_uop_do_bypass_rs2 = bypassed_uop_bypass_hits_rs2_0_1 | bypassed_uop_bypass_hits_rs2_1;
  wire       bypassed_uop_do_bypass_rs3 = bypassed_uop_bypass_hits_rs3_0_1 | bypassed_uop_bypass_hits_rs3_1;
  wire       bypassed_uop_bypass_hits_rs1_0_2 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_3_lrs1;
  wire       bypassed_uop_bypass_hits_rs1_1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_3_lrs1;
  wire       bypassed_uop_bypass_hits_rs1_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_3_lrs1;
  wire       bypassed_uop_bypass_hits_rs2_0_2 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_3_lrs2;
  wire       bypassed_uop_bypass_hits_rs2_1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_3_lrs2;
  wire       bypassed_uop_bypass_hits_rs2_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_3_lrs2;
  wire       bypassed_uop_bypass_hits_rs3_0_2 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_3_lrs3;
  wire       bypassed_uop_bypass_hits_rs3_1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_3_lrs3;
  wire       bypassed_uop_bypass_hits_rs3_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_3_lrs3;
  wire       bypassed_uop_bypass_hits_dst_0_2 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_3_ldst;
  wire       bypassed_uop_bypass_hits_dst_1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_3_ldst;
  wire       bypassed_uop_bypass_hits_dst_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_3_ldst;
  wire [2:0] bypassed_uop_bypass_sel_rs1_enc_2 = bypassed_uop_bypass_hits_rs1_2 ? 3'h1 : bypassed_uop_bypass_hits_rs1_1_1 ? 3'h2 : {bypassed_uop_bypass_hits_rs1_0_2, 2'h0};
  wire [2:0] bypassed_uop_bypass_sel_rs2_enc_2 = bypassed_uop_bypass_hits_rs2_2 ? 3'h1 : bypassed_uop_bypass_hits_rs2_1_1 ? 3'h2 : {bypassed_uop_bypass_hits_rs2_0_2, 2'h0};
  wire [2:0] bypassed_uop_bypass_sel_rs3_enc_2 = bypassed_uop_bypass_hits_rs3_2 ? 3'h1 : bypassed_uop_bypass_hits_rs3_1_1 ? 3'h2 : {bypassed_uop_bypass_hits_rs3_0_2, 2'h0};
  wire [2:0] bypassed_uop_bypass_sel_dst_enc_2 = bypassed_uop_bypass_hits_dst_2 ? 3'h1 : bypassed_uop_bypass_hits_dst_1_1 ? 3'h2 : {bypassed_uop_bypass_hits_dst_0_2, 2'h0};
  wire       bypassed_uop_do_bypass_rs1_1 = bypassed_uop_bypass_hits_rs1_0_2 | bypassed_uop_bypass_hits_rs1_1_1 | bypassed_uop_bypass_hits_rs1_2;
  wire       bypassed_uop_do_bypass_rs2_1 = bypassed_uop_bypass_hits_rs2_0_2 | bypassed_uop_bypass_hits_rs2_1_1 | bypassed_uop_bypass_hits_rs2_2;
  wire       bypassed_uop_do_bypass_rs3_1 = bypassed_uop_bypass_hits_rs3_0_2 | bypassed_uop_bypass_hits_rs3_1_1 | bypassed_uop_bypass_hits_rs3_2;
  wire       _GEN = io_kill | ~io_dis_ready;
  wire [5:0] next_uop_ldst = _GEN ? r_uop_ldst : io_dec_uops_0_ldst;
  wire [5:0] next_uop_lrs1 = _GEN ? r_uop_lrs1 : io_dec_uops_0_lrs1;
  wire [5:0] next_uop_lrs2 = _GEN ? r_uop_lrs2 : io_dec_uops_0_lrs2;
  wire [5:0] next_uop_lrs3 = _GEN ? r_uop_lrs3 : io_dec_uops_0_lrs3;
  wire       r_uop_bypass_hits_rs1_0 = ren2_alloc_reqs_0 & r_uop_ldst == next_uop_lrs1;
  wire       r_uop_bypass_hits_rs1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == next_uop_lrs1;
  wire       r_uop_bypass_hits_rs1_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == next_uop_lrs1;
  wire       r_uop_bypass_hits_rs1_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == next_uop_lrs1;
  wire       r_uop_bypass_hits_rs2_0 = ren2_alloc_reqs_0 & r_uop_ldst == next_uop_lrs2;
  wire       r_uop_bypass_hits_rs2_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == next_uop_lrs2;
  wire       r_uop_bypass_hits_rs2_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == next_uop_lrs2;
  wire       r_uop_bypass_hits_rs2_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == next_uop_lrs2;
  wire       r_uop_bypass_hits_rs3_0 = ren2_alloc_reqs_0 & r_uop_ldst == next_uop_lrs3;
  wire       r_uop_bypass_hits_rs3_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == next_uop_lrs3;
  wire       r_uop_bypass_hits_rs3_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == next_uop_lrs3;
  wire       r_uop_bypass_hits_rs3_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == next_uop_lrs3;
  wire       r_uop_bypass_hits_dst_0 = ren2_alloc_reqs_0 & r_uop_ldst == next_uop_ldst;
  wire       r_uop_bypass_hits_dst_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == next_uop_ldst;
  wire       r_uop_bypass_hits_dst_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == next_uop_ldst;
  wire       r_uop_bypass_hits_dst_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == next_uop_ldst;
  wire [5:0] next_uop_1_ldst = _GEN ? r_uop_1_ldst : io_dec_uops_1_ldst;
  wire [5:0] next_uop_1_lrs1 = _GEN ? r_uop_1_lrs1 : io_dec_uops_1_lrs1;
  wire [5:0] next_uop_1_lrs2 = _GEN ? r_uop_1_lrs2 : io_dec_uops_1_lrs2;
  wire [5:0] next_uop_1_lrs3 = _GEN ? r_uop_1_lrs3 : io_dec_uops_1_lrs3;
  wire       r_uop_bypass_hits_rs1_0_1 = ren2_alloc_reqs_0 & r_uop_ldst == next_uop_1_lrs1;
  wire       r_uop_bypass_hits_rs1_1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == next_uop_1_lrs1;
  wire       r_uop_bypass_hits_rs1_2_1 = ren2_alloc_reqs_2 & r_uop_2_ldst == next_uop_1_lrs1;
  wire       r_uop_bypass_hits_rs1_3_1 = ren2_alloc_reqs_3 & r_uop_3_ldst == next_uop_1_lrs1;
  wire       r_uop_bypass_hits_rs2_0_1 = ren2_alloc_reqs_0 & r_uop_ldst == next_uop_1_lrs2;
  wire       r_uop_bypass_hits_rs2_1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == next_uop_1_lrs2;
  wire       r_uop_bypass_hits_rs2_2_1 = ren2_alloc_reqs_2 & r_uop_2_ldst == next_uop_1_lrs2;
  wire       r_uop_bypass_hits_rs2_3_1 = ren2_alloc_reqs_3 & r_uop_3_ldst == next_uop_1_lrs2;
  wire       r_uop_bypass_hits_rs3_0_1 = ren2_alloc_reqs_0 & r_uop_ldst == next_uop_1_lrs3;
  wire       r_uop_bypass_hits_rs3_1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == next_uop_1_lrs3;
  wire       r_uop_bypass_hits_rs3_2_1 = ren2_alloc_reqs_2 & r_uop_2_ldst == next_uop_1_lrs3;
  wire       r_uop_bypass_hits_rs3_3_1 = ren2_alloc_reqs_3 & r_uop_3_ldst == next_uop_1_lrs3;
  wire       r_uop_bypass_hits_dst_0_1 = ren2_alloc_reqs_0 & r_uop_ldst == next_uop_1_ldst;
  wire       r_uop_bypass_hits_dst_1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == next_uop_1_ldst;
  wire       r_uop_bypass_hits_dst_2_1 = ren2_alloc_reqs_2 & r_uop_2_ldst == next_uop_1_ldst;
  wire       r_uop_bypass_hits_dst_3_1 = ren2_alloc_reqs_3 & r_uop_3_ldst == next_uop_1_ldst;
  wire [5:0] next_uop_2_ldst = _GEN ? r_uop_2_ldst : io_dec_uops_2_ldst;
  wire [5:0] next_uop_2_lrs1 = _GEN ? r_uop_2_lrs1 : io_dec_uops_2_lrs1;
  wire [5:0] next_uop_2_lrs2 = _GEN ? r_uop_2_lrs2 : io_dec_uops_2_lrs2;
  wire [5:0] next_uop_2_lrs3 = _GEN ? r_uop_2_lrs3 : io_dec_uops_2_lrs3;
  wire       r_uop_bypass_hits_rs1_0_2 = ren2_alloc_reqs_0 & r_uop_ldst == next_uop_2_lrs1;
  wire       r_uop_bypass_hits_rs1_1_2 = ren2_alloc_reqs_1 & r_uop_1_ldst == next_uop_2_lrs1;
  wire       r_uop_bypass_hits_rs1_2_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == next_uop_2_lrs1;
  wire       r_uop_bypass_hits_rs1_3_2 = ren2_alloc_reqs_3 & r_uop_3_ldst == next_uop_2_lrs1;
  wire       r_uop_bypass_hits_rs2_0_2 = ren2_alloc_reqs_0 & r_uop_ldst == next_uop_2_lrs2;
  wire       r_uop_bypass_hits_rs2_1_2 = ren2_alloc_reqs_1 & r_uop_1_ldst == next_uop_2_lrs2;
  wire       r_uop_bypass_hits_rs2_2_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == next_uop_2_lrs2;
  wire       r_uop_bypass_hits_rs2_3_2 = ren2_alloc_reqs_3 & r_uop_3_ldst == next_uop_2_lrs2;
  wire       r_uop_bypass_hits_rs3_0_2 = ren2_alloc_reqs_0 & r_uop_ldst == next_uop_2_lrs3;
  wire       r_uop_bypass_hits_rs3_1_2 = ren2_alloc_reqs_1 & r_uop_1_ldst == next_uop_2_lrs3;
  wire       r_uop_bypass_hits_rs3_2_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == next_uop_2_lrs3;
  wire       r_uop_bypass_hits_rs3_3_2 = ren2_alloc_reqs_3 & r_uop_3_ldst == next_uop_2_lrs3;
  wire       r_uop_bypass_hits_dst_0_2 = ren2_alloc_reqs_0 & r_uop_ldst == next_uop_2_ldst;
  wire       r_uop_bypass_hits_dst_1_2 = ren2_alloc_reqs_1 & r_uop_1_ldst == next_uop_2_ldst;
  wire       r_uop_bypass_hits_dst_2_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == next_uop_2_ldst;
  wire       r_uop_bypass_hits_dst_3_2 = ren2_alloc_reqs_3 & r_uop_3_ldst == next_uop_2_ldst;
  wire [5:0] next_uop_3_ldst = _GEN ? r_uop_3_ldst : io_dec_uops_3_ldst;
  wire [5:0] next_uop_3_lrs1 = _GEN ? r_uop_3_lrs1 : io_dec_uops_3_lrs1;
  wire [5:0] next_uop_3_lrs2 = _GEN ? r_uop_3_lrs2 : io_dec_uops_3_lrs2;
  wire [5:0] next_uop_3_lrs3 = _GEN ? r_uop_3_lrs3 : io_dec_uops_3_lrs3;
  wire       r_uop_bypass_hits_rs1_0_3 = ren2_alloc_reqs_0 & r_uop_ldst == next_uop_3_lrs1;
  wire       r_uop_bypass_hits_rs1_1_3 = ren2_alloc_reqs_1 & r_uop_1_ldst == next_uop_3_lrs1;
  wire       r_uop_bypass_hits_rs1_2_3 = ren2_alloc_reqs_2 & r_uop_2_ldst == next_uop_3_lrs1;
  wire       r_uop_bypass_hits_rs1_3_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == next_uop_3_lrs1;
  wire       r_uop_bypass_hits_rs2_0_3 = ren2_alloc_reqs_0 & r_uop_ldst == next_uop_3_lrs2;
  wire       r_uop_bypass_hits_rs2_1_3 = ren2_alloc_reqs_1 & r_uop_1_ldst == next_uop_3_lrs2;
  wire       r_uop_bypass_hits_rs2_2_3 = ren2_alloc_reqs_2 & r_uop_2_ldst == next_uop_3_lrs2;
  wire       r_uop_bypass_hits_rs2_3_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == next_uop_3_lrs2;
  wire       r_uop_bypass_hits_rs3_0_3 = ren2_alloc_reqs_0 & r_uop_ldst == next_uop_3_lrs3;
  wire       r_uop_bypass_hits_rs3_1_3 = ren2_alloc_reqs_1 & r_uop_1_ldst == next_uop_3_lrs3;
  wire       r_uop_bypass_hits_rs3_2_3 = ren2_alloc_reqs_2 & r_uop_2_ldst == next_uop_3_lrs3;
  wire       r_uop_bypass_hits_rs3_3_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == next_uop_3_lrs3;
  wire       r_uop_bypass_hits_dst_0_3 = ren2_alloc_reqs_0 & r_uop_ldst == next_uop_3_ldst;
  wire       r_uop_bypass_hits_dst_1_3 = ren2_alloc_reqs_1 & r_uop_1_ldst == next_uop_3_ldst;
  wire       r_uop_bypass_hits_dst_2_3 = ren2_alloc_reqs_2 & r_uop_2_ldst == next_uop_3_ldst;
  wire       r_uop_bypass_hits_dst_3_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == next_uop_3_ldst;
  wire [3:0] r_uop_bypass_sel_rs1_enc = r_uop_bypass_hits_rs1_3 ? 4'h1 : r_uop_bypass_hits_rs1_2 ? 4'h2 : r_uop_bypass_hits_rs1_1 ? 4'h4 : {r_uop_bypass_hits_rs1_0, 3'h0};
  wire [3:0] r_uop_bypass_sel_rs2_enc = r_uop_bypass_hits_rs2_3 ? 4'h1 : r_uop_bypass_hits_rs2_2 ? 4'h2 : r_uop_bypass_hits_rs2_1 ? 4'h4 : {r_uop_bypass_hits_rs2_0, 3'h0};
  wire [3:0] r_uop_bypass_sel_rs3_enc = r_uop_bypass_hits_rs3_3 ? 4'h1 : r_uop_bypass_hits_rs3_2 ? 4'h2 : r_uop_bypass_hits_rs3_1 ? 4'h4 : {r_uop_bypass_hits_rs3_0, 3'h0};
  wire [3:0] r_uop_bypass_sel_dst_enc = r_uop_bypass_hits_dst_3 ? 4'h1 : r_uop_bypass_hits_dst_2 ? 4'h2 : r_uop_bypass_hits_dst_1 ? 4'h4 : {r_uop_bypass_hits_dst_0, 3'h0};
  wire [3:0] r_uop_bypass_sel_rs1_enc_1 = r_uop_bypass_hits_rs1_3_1 ? 4'h1 : r_uop_bypass_hits_rs1_2_1 ? 4'h2 : r_uop_bypass_hits_rs1_1_1 ? 4'h4 : {r_uop_bypass_hits_rs1_0_1, 3'h0};
  wire [3:0] r_uop_bypass_sel_rs2_enc_1 = r_uop_bypass_hits_rs2_3_1 ? 4'h1 : r_uop_bypass_hits_rs2_2_1 ? 4'h2 : r_uop_bypass_hits_rs2_1_1 ? 4'h4 : {r_uop_bypass_hits_rs2_0_1, 3'h0};
  wire [3:0] r_uop_bypass_sel_rs3_enc_1 = r_uop_bypass_hits_rs3_3_1 ? 4'h1 : r_uop_bypass_hits_rs3_2_1 ? 4'h2 : r_uop_bypass_hits_rs3_1_1 ? 4'h4 : {r_uop_bypass_hits_rs3_0_1, 3'h0};
  wire [3:0] r_uop_bypass_sel_dst_enc_1 = r_uop_bypass_hits_dst_3_1 ? 4'h1 : r_uop_bypass_hits_dst_2_1 ? 4'h2 : r_uop_bypass_hits_dst_1_1 ? 4'h4 : {r_uop_bypass_hits_dst_0_1, 3'h0};
  wire [3:0] r_uop_bypass_sel_rs1_enc_2 = r_uop_bypass_hits_rs1_3_2 ? 4'h1 : r_uop_bypass_hits_rs1_2_2 ? 4'h2 : r_uop_bypass_hits_rs1_1_2 ? 4'h4 : {r_uop_bypass_hits_rs1_0_2, 3'h0};
  wire [3:0] r_uop_bypass_sel_rs2_enc_2 = r_uop_bypass_hits_rs2_3_2 ? 4'h1 : r_uop_bypass_hits_rs2_2_2 ? 4'h2 : r_uop_bypass_hits_rs2_1_2 ? 4'h4 : {r_uop_bypass_hits_rs2_0_2, 3'h0};
  wire [3:0] r_uop_bypass_sel_rs3_enc_2 = r_uop_bypass_hits_rs3_3_2 ? 4'h1 : r_uop_bypass_hits_rs3_2_2 ? 4'h2 : r_uop_bypass_hits_rs3_1_2 ? 4'h4 : {r_uop_bypass_hits_rs3_0_2, 3'h0};
  wire [3:0] r_uop_bypass_sel_dst_enc_2 = r_uop_bypass_hits_dst_3_2 ? 4'h1 : r_uop_bypass_hits_dst_2_2 ? 4'h2 : r_uop_bypass_hits_dst_1_2 ? 4'h4 : {r_uop_bypass_hits_dst_0_2, 3'h0};
  wire [3:0] r_uop_bypass_sel_rs1_enc_3 = r_uop_bypass_hits_rs1_3_3 ? 4'h1 : r_uop_bypass_hits_rs1_2_3 ? 4'h2 : r_uop_bypass_hits_rs1_1_3 ? 4'h4 : {r_uop_bypass_hits_rs1_0_3, 3'h0};
  wire [3:0] r_uop_bypass_sel_rs2_enc_3 = r_uop_bypass_hits_rs2_3_3 ? 4'h1 : r_uop_bypass_hits_rs2_2_3 ? 4'h2 : r_uop_bypass_hits_rs2_1_3 ? 4'h4 : {r_uop_bypass_hits_rs2_0_3, 3'h0};
  wire [3:0] r_uop_bypass_sel_rs3_enc_3 = r_uop_bypass_hits_rs3_3_3 ? 4'h1 : r_uop_bypass_hits_rs3_2_3 ? 4'h2 : r_uop_bypass_hits_rs3_1_3 ? 4'h4 : {r_uop_bypass_hits_rs3_0_3, 3'h0};
  wire [3:0] r_uop_bypass_sel_dst_enc_3 = r_uop_bypass_hits_dst_3_3 ? 4'h1 : r_uop_bypass_hits_dst_2_3 ? 4'h2 : r_uop_bypass_hits_dst_1_3 ? 4'h4 : {r_uop_bypass_hits_dst_0_3, 3'h0};
  always @(posedge clock) begin
    if (_GEN) begin
    end
    else begin
      r_uop_is_br <= io_dec_uops_0_is_br;
      r_uop_is_jalr <= io_dec_uops_0_is_jalr;
      r_uop_is_sfb <= io_dec_uops_0_is_sfb;
      r_uop_br_tag <= io_dec_uops_0_br_tag;
    end
    if (r_uop_bypass_hits_rs1_0 | r_uop_bypass_hits_rs1_1 | r_uop_bypass_hits_rs1_2 | r_uop_bypass_hits_rs1_3)
      r_uop_prs1 <= (r_uop_bypass_sel_rs1_enc[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (r_uop_bypass_sel_rs1_enc[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (r_uop_bypass_sel_rs1_enc[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0) | (r_uop_bypass_sel_rs1_enc[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);
    else if (_GEN) begin
    end
    else
      r_uop_prs1 <= _maptable_io_map_resps_0_prs1;
    if (r_uop_bypass_hits_rs2_0 | r_uop_bypass_hits_rs2_1 | r_uop_bypass_hits_rs2_2 | r_uop_bypass_hits_rs2_3)
      r_uop_prs2 <= (r_uop_bypass_sel_rs2_enc[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (r_uop_bypass_sel_rs2_enc[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (r_uop_bypass_sel_rs2_enc[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0) | (r_uop_bypass_sel_rs2_enc[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);
    else if (_GEN) begin
    end
    else
      r_uop_prs2 <= _maptable_io_map_resps_0_prs2;
    if (r_uop_bypass_hits_rs3_0 | r_uop_bypass_hits_rs3_1 | r_uop_bypass_hits_rs3_2 | r_uop_bypass_hits_rs3_3)
      r_uop_prs3 <= (r_uop_bypass_sel_rs3_enc[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (r_uop_bypass_sel_rs3_enc[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (r_uop_bypass_sel_rs3_enc[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0) | (r_uop_bypass_sel_rs3_enc[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);
    else if (_GEN) begin
    end
    else
      r_uop_prs3 <= _maptable_io_map_resps_0_prs3;
    if (r_uop_bypass_hits_dst_0 | r_uop_bypass_hits_dst_1 | r_uop_bypass_hits_dst_2 | r_uop_bypass_hits_dst_3)
      r_uop_stale_pdst <= (r_uop_bypass_sel_dst_enc[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (r_uop_bypass_sel_dst_enc[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (r_uop_bypass_sel_dst_enc[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0) | (r_uop_bypass_sel_dst_enc[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);
    else if (_GEN) begin
    end
    else
      r_uop_stale_pdst <= _maptable_io_map_resps_0_stale_pdst;
    if (_GEN) begin
    end
    else begin
      r_uop_ldst <= io_dec_uops_0_ldst;
      r_uop_lrs1 <= io_dec_uops_0_lrs1;
      r_uop_lrs2 <= io_dec_uops_0_lrs2;
      r_uop_lrs3 <= io_dec_uops_0_lrs3;
      r_uop_ldst_val <= io_dec_uops_0_ldst_val;
      r_uop_dst_rtype <= io_dec_uops_0_dst_rtype;
      r_uop_lrs1_rtype <= io_dec_uops_0_lrs1_rtype;
      r_uop_lrs2_rtype <= io_dec_uops_0_lrs2_rtype;
      r_uop_frs3_en <= io_dec_uops_0_frs3_en;
      r_uop_1_ldst <= io_dec_uops_1_ldst;
      r_uop_1_ldst_val <= io_dec_uops_1_ldst_val;
      r_uop_1_dst_rtype <= io_dec_uops_1_dst_rtype;
      r_uop_2_ldst <= io_dec_uops_2_ldst;
      r_uop_2_ldst_val <= io_dec_uops_2_ldst_val;
      r_uop_2_dst_rtype <= io_dec_uops_2_dst_rtype;
      r_uop_3_ldst <= io_dec_uops_3_ldst;
      r_uop_3_ldst_val <= io_dec_uops_3_ldst_val;
      r_uop_3_dst_rtype <= io_dec_uops_3_dst_rtype;
      r_uop_1_is_br <= io_dec_uops_1_is_br;
      r_uop_1_is_jalr <= io_dec_uops_1_is_jalr;
      r_uop_1_is_sfb <= io_dec_uops_1_is_sfb;
      r_uop_1_br_tag <= io_dec_uops_1_br_tag;
    end
    if (r_uop_bypass_hits_rs1_0_1 | r_uop_bypass_hits_rs1_1_1 | r_uop_bypass_hits_rs1_2_1 | r_uop_bypass_hits_rs1_3_1)
      r_uop_1_prs1 <= (r_uop_bypass_sel_rs1_enc_1[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (r_uop_bypass_sel_rs1_enc_1[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (r_uop_bypass_sel_rs1_enc_1[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0) | (r_uop_bypass_sel_rs1_enc_1[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);
    else if (_GEN) begin
    end
    else
      r_uop_1_prs1 <= _maptable_io_map_resps_1_prs1;
    if (r_uop_bypass_hits_rs2_0_1 | r_uop_bypass_hits_rs2_1_1 | r_uop_bypass_hits_rs2_2_1 | r_uop_bypass_hits_rs2_3_1)
      r_uop_1_prs2 <= (r_uop_bypass_sel_rs2_enc_1[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (r_uop_bypass_sel_rs2_enc_1[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (r_uop_bypass_sel_rs2_enc_1[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0) | (r_uop_bypass_sel_rs2_enc_1[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);
    else if (_GEN) begin
    end
    else
      r_uop_1_prs2 <= _maptable_io_map_resps_1_prs2;
    if (r_uop_bypass_hits_rs3_0_1 | r_uop_bypass_hits_rs3_1_1 | r_uop_bypass_hits_rs3_2_1 | r_uop_bypass_hits_rs3_3_1)
      r_uop_1_prs3 <= (r_uop_bypass_sel_rs3_enc_1[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (r_uop_bypass_sel_rs3_enc_1[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (r_uop_bypass_sel_rs3_enc_1[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0) | (r_uop_bypass_sel_rs3_enc_1[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);
    else if (_GEN) begin
    end
    else
      r_uop_1_prs3 <= _maptable_io_map_resps_1_prs3;
    if (r_uop_bypass_hits_dst_0_1 | r_uop_bypass_hits_dst_1_1 | r_uop_bypass_hits_dst_2_1 | r_uop_bypass_hits_dst_3_1)
      r_uop_1_stale_pdst <= (r_uop_bypass_sel_dst_enc_1[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (r_uop_bypass_sel_dst_enc_1[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (r_uop_bypass_sel_dst_enc_1[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0) | (r_uop_bypass_sel_dst_enc_1[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);
    else if (_GEN) begin
    end
    else
      r_uop_1_stale_pdst <= _maptable_io_map_resps_1_stale_pdst;
    if (_GEN) begin
    end
    else begin
      r_uop_1_lrs1 <= io_dec_uops_1_lrs1;
      r_uop_1_lrs2 <= io_dec_uops_1_lrs2;
      r_uop_1_lrs3 <= io_dec_uops_1_lrs3;
      r_uop_1_lrs1_rtype <= io_dec_uops_1_lrs1_rtype;
      r_uop_1_lrs2_rtype <= io_dec_uops_1_lrs2_rtype;
      r_uop_1_frs3_en <= io_dec_uops_1_frs3_en;
      r_uop_2_is_br <= io_dec_uops_2_is_br;
      r_uop_2_is_jalr <= io_dec_uops_2_is_jalr;
      r_uop_2_is_sfb <= io_dec_uops_2_is_sfb;
      r_uop_2_br_tag <= io_dec_uops_2_br_tag;
    end
    if (r_uop_bypass_hits_rs1_0_2 | r_uop_bypass_hits_rs1_1_2 | r_uop_bypass_hits_rs1_2_2 | r_uop_bypass_hits_rs1_3_2)
      r_uop_2_prs1 <= (r_uop_bypass_sel_rs1_enc_2[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (r_uop_bypass_sel_rs1_enc_2[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (r_uop_bypass_sel_rs1_enc_2[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0) | (r_uop_bypass_sel_rs1_enc_2[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);
    else if (_GEN) begin
    end
    else
      r_uop_2_prs1 <= _maptable_io_map_resps_2_prs1;
    if (r_uop_bypass_hits_rs2_0_2 | r_uop_bypass_hits_rs2_1_2 | r_uop_bypass_hits_rs2_2_2 | r_uop_bypass_hits_rs2_3_2)
      r_uop_2_prs2 <= (r_uop_bypass_sel_rs2_enc_2[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (r_uop_bypass_sel_rs2_enc_2[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (r_uop_bypass_sel_rs2_enc_2[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0) | (r_uop_bypass_sel_rs2_enc_2[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);
    else if (_GEN) begin
    end
    else
      r_uop_2_prs2 <= _maptable_io_map_resps_2_prs2;
    if (r_uop_bypass_hits_rs3_0_2 | r_uop_bypass_hits_rs3_1_2 | r_uop_bypass_hits_rs3_2_2 | r_uop_bypass_hits_rs3_3_2)
      r_uop_2_prs3 <= (r_uop_bypass_sel_rs3_enc_2[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (r_uop_bypass_sel_rs3_enc_2[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (r_uop_bypass_sel_rs3_enc_2[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0) | (r_uop_bypass_sel_rs3_enc_2[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);
    else if (_GEN) begin
    end
    else
      r_uop_2_prs3 <= _maptable_io_map_resps_2_prs3;
    if (r_uop_bypass_hits_dst_0_2 | r_uop_bypass_hits_dst_1_2 | r_uop_bypass_hits_dst_2_2 | r_uop_bypass_hits_dst_3_2)
      r_uop_2_stale_pdst <= (r_uop_bypass_sel_dst_enc_2[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (r_uop_bypass_sel_dst_enc_2[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (r_uop_bypass_sel_dst_enc_2[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0) | (r_uop_bypass_sel_dst_enc_2[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);
    else if (_GEN) begin
    end
    else
      r_uop_2_stale_pdst <= _maptable_io_map_resps_2_stale_pdst;
    if (_GEN) begin
    end
    else begin
      r_uop_2_lrs1 <= io_dec_uops_2_lrs1;
      r_uop_2_lrs2 <= io_dec_uops_2_lrs2;
      r_uop_2_lrs3 <= io_dec_uops_2_lrs3;
      r_uop_2_lrs1_rtype <= io_dec_uops_2_lrs1_rtype;
      r_uop_2_lrs2_rtype <= io_dec_uops_2_lrs2_rtype;
      r_uop_2_frs3_en <= io_dec_uops_2_frs3_en;
      r_uop_3_is_br <= io_dec_uops_3_is_br;
      r_uop_3_is_jalr <= io_dec_uops_3_is_jalr;
      r_uop_3_is_sfb <= io_dec_uops_3_is_sfb;
      r_uop_3_br_tag <= io_dec_uops_3_br_tag;
    end
    if (r_uop_bypass_hits_rs1_0_3 | r_uop_bypass_hits_rs1_1_3 | r_uop_bypass_hits_rs1_2_3 | r_uop_bypass_hits_rs1_3_3)
      r_uop_3_prs1 <= (r_uop_bypass_sel_rs1_enc_3[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (r_uop_bypass_sel_rs1_enc_3[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (r_uop_bypass_sel_rs1_enc_3[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0) | (r_uop_bypass_sel_rs1_enc_3[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);
    else if (_GEN) begin
    end
    else
      r_uop_3_prs1 <= _maptable_io_map_resps_3_prs1;
    if (r_uop_bypass_hits_rs2_0_3 | r_uop_bypass_hits_rs2_1_3 | r_uop_bypass_hits_rs2_2_3 | r_uop_bypass_hits_rs2_3_3)
      r_uop_3_prs2 <= (r_uop_bypass_sel_rs2_enc_3[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (r_uop_bypass_sel_rs2_enc_3[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (r_uop_bypass_sel_rs2_enc_3[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0) | (r_uop_bypass_sel_rs2_enc_3[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);
    else if (_GEN) begin
    end
    else
      r_uop_3_prs2 <= _maptable_io_map_resps_3_prs2;
    if (r_uop_bypass_hits_rs3_0_3 | r_uop_bypass_hits_rs3_1_3 | r_uop_bypass_hits_rs3_2_3 | r_uop_bypass_hits_rs3_3_3)
      r_uop_3_prs3 <= (r_uop_bypass_sel_rs3_enc_3[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (r_uop_bypass_sel_rs3_enc_3[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (r_uop_bypass_sel_rs3_enc_3[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0) | (r_uop_bypass_sel_rs3_enc_3[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);
    else if (_GEN) begin
    end
    else
      r_uop_3_prs3 <= _maptable_io_map_resps_3_prs3;
    if (r_uop_bypass_hits_dst_0_3 | r_uop_bypass_hits_dst_1_3 | r_uop_bypass_hits_dst_2_3 | r_uop_bypass_hits_dst_3_3)
      r_uop_3_stale_pdst <= (r_uop_bypass_sel_dst_enc_3[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (r_uop_bypass_sel_dst_enc_3[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (r_uop_bypass_sel_dst_enc_3[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0) | (r_uop_bypass_sel_dst_enc_3[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);
    else if (_GEN) begin
    end
    else
      r_uop_3_stale_pdst <= _maptable_io_map_resps_3_stale_pdst;
    if (_GEN) begin
    end
    else begin
      r_uop_3_lrs1 <= io_dec_uops_3_lrs1;
      r_uop_3_lrs2 <= io_dec_uops_3_lrs2;
      r_uop_3_lrs3 <= io_dec_uops_3_lrs3;
      r_uop_3_lrs1_rtype <= io_dec_uops_3_lrs1_rtype;
      r_uop_3_lrs2_rtype <= io_dec_uops_3_lrs2_rtype;
      r_uop_3_frs3_en <= io_dec_uops_3_frs3_en;
    end
  end // always @(posedge)
  RenameMapTable_1 maptable (
    .clock                     (clock),
    .reset                     (reset),
    .io_map_reqs_0_lrs1        (io_dec_uops_0_lrs1),
    .io_map_reqs_0_lrs2        (io_dec_uops_0_lrs2),
    .io_map_reqs_0_lrs3        (io_dec_uops_0_lrs3),
    .io_map_reqs_0_ldst        (io_dec_uops_0_ldst),
    .io_map_reqs_1_lrs1        (io_dec_uops_1_lrs1),
    .io_map_reqs_1_lrs2        (io_dec_uops_1_lrs2),
    .io_map_reqs_1_lrs3        (io_dec_uops_1_lrs3),
    .io_map_reqs_1_ldst        (io_dec_uops_1_ldst),
    .io_map_reqs_2_lrs1        (io_dec_uops_2_lrs1),
    .io_map_reqs_2_lrs2        (io_dec_uops_2_lrs2),
    .io_map_reqs_2_lrs3        (io_dec_uops_2_lrs3),
    .io_map_reqs_2_ldst        (io_dec_uops_2_ldst),
    .io_map_reqs_3_lrs1        (io_dec_uops_3_lrs1),
    .io_map_reqs_3_lrs2        (io_dec_uops_3_lrs2),
    .io_map_reqs_3_lrs3        (io_dec_uops_3_lrs3),
    .io_map_reqs_3_ldst        (io_dec_uops_3_ldst),
    .io_remap_reqs_0_ldst      (io_rollback ? io_com_uops_3_ldst : r_uop_ldst),
    .io_remap_reqs_0_pdst      (io_rollback ? io_com_uops_3_stale_pdst : _freelist_io_alloc_pregs_0_bits),
    .io_remap_reqs_0_valid     (ren2_alloc_reqs_0 | rbk_valids_3),
    .io_remap_reqs_1_ldst      (io_rollback ? io_com_uops_2_ldst : r_uop_1_ldst),
    .io_remap_reqs_1_pdst      (io_rollback ? io_com_uops_2_stale_pdst : _freelist_io_alloc_pregs_1_bits),
    .io_remap_reqs_1_valid     (ren2_alloc_reqs_1 | rbk_valids_2),
    .io_remap_reqs_2_ldst      (io_rollback ? io_com_uops_1_ldst : r_uop_2_ldst),
    .io_remap_reqs_2_pdst      (io_rollback ? io_com_uops_1_stale_pdst : _freelist_io_alloc_pregs_2_bits),
    .io_remap_reqs_2_valid     (ren2_alloc_reqs_2 | rbk_valids_1),
    .io_remap_reqs_3_ldst      (io_rollback ? io_com_uops_0_ldst : r_uop_3_ldst),
    .io_remap_reqs_3_pdst      (io_rollback ? io_com_uops_0_stale_pdst : _freelist_io_alloc_pregs_3_bits),
    .io_remap_reqs_3_valid     (ren2_alloc_reqs_3 | rbk_valids_0),
    .io_ren_br_tags_0_valid    (ren2_br_tags_0_valid),
    .io_ren_br_tags_0_bits     (r_uop_br_tag),
    .io_ren_br_tags_1_valid    (ren2_br_tags_1_valid),
    .io_ren_br_tags_1_bits     (r_uop_1_br_tag),
    .io_ren_br_tags_2_valid    (ren2_br_tags_2_valid),
    .io_ren_br_tags_2_bits     (r_uop_2_br_tag),
    .io_ren_br_tags_3_valid    (ren2_br_tags_3_valid),
    .io_ren_br_tags_3_bits     (r_uop_3_br_tag),
    .io_brupdate_b2_uop_br_tag (io_brupdate_b2_uop_br_tag),
    .io_brupdate_b2_mispredict (io_brupdate_b2_mispredict),
    .io_rollback               (io_rollback),
    .io_map_resps_0_prs1       (_maptable_io_map_resps_0_prs1),
    .io_map_resps_0_prs2       (_maptable_io_map_resps_0_prs2),
    .io_map_resps_0_prs3       (_maptable_io_map_resps_0_prs3),
    .io_map_resps_0_stale_pdst (_maptable_io_map_resps_0_stale_pdst),
    .io_map_resps_1_prs1       (_maptable_io_map_resps_1_prs1),
    .io_map_resps_1_prs2       (_maptable_io_map_resps_1_prs2),
    .io_map_resps_1_prs3       (_maptable_io_map_resps_1_prs3),
    .io_map_resps_1_stale_pdst (_maptable_io_map_resps_1_stale_pdst),
    .io_map_resps_2_prs1       (_maptable_io_map_resps_2_prs1),
    .io_map_resps_2_prs2       (_maptable_io_map_resps_2_prs2),
    .io_map_resps_2_prs3       (_maptable_io_map_resps_2_prs3),
    .io_map_resps_2_stale_pdst (_maptable_io_map_resps_2_stale_pdst),
    .io_map_resps_3_prs1       (_maptable_io_map_resps_3_prs1),
    .io_map_resps_3_prs2       (_maptable_io_map_resps_3_prs2),
    .io_map_resps_3_prs3       (_maptable_io_map_resps_3_prs3),
    .io_map_resps_3_stale_pdst (_maptable_io_map_resps_3_stale_pdst)
  );
  RenameFreeList_1 freelist (
    .clock                     (clock),
    .reset                     (reset),
    .io_reqs_0                 (ren2_alloc_reqs_0),
    .io_reqs_1                 (ren2_alloc_reqs_1),
    .io_reqs_2                 (ren2_alloc_reqs_2),
    .io_reqs_3                 (ren2_alloc_reqs_3),
    .io_dealloc_pregs_0_valid  (io_com_uops_0_ldst_val & _rbk_valids_0_T & io_com_valids_0 | rbk_valids_0),
    .io_dealloc_pregs_0_bits   (io_rollback ? io_com_uops_0_pdst : io_com_uops_0_stale_pdst),
    .io_dealloc_pregs_1_valid  (io_com_uops_1_ldst_val & _rbk_valids_1_T & io_com_valids_1 | rbk_valids_1),
    .io_dealloc_pregs_1_bits   (io_rollback ? io_com_uops_1_pdst : io_com_uops_1_stale_pdst),
    .io_dealloc_pregs_2_valid  (io_com_uops_2_ldst_val & _rbk_valids_2_T & io_com_valids_2 | rbk_valids_2),
    .io_dealloc_pregs_2_bits   (io_rollback ? io_com_uops_2_pdst : io_com_uops_2_stale_pdst),
    .io_dealloc_pregs_3_valid  (io_com_uops_3_ldst_val & _rbk_valids_3_T & io_com_valids_3 | rbk_valids_3),
    .io_dealloc_pregs_3_bits   (io_rollback ? io_com_uops_3_pdst : io_com_uops_3_stale_pdst),
    .io_ren_br_tags_0_valid    (ren2_br_tags_0_valid),
    .io_ren_br_tags_0_bits     (r_uop_br_tag),
    .io_ren_br_tags_1_valid    (ren2_br_tags_1_valid),
    .io_ren_br_tags_1_bits     (r_uop_1_br_tag),
    .io_ren_br_tags_2_valid    (ren2_br_tags_2_valid),
    .io_ren_br_tags_2_bits     (r_uop_2_br_tag),
    .io_ren_br_tags_3_valid    (ren2_br_tags_3_valid),
    .io_ren_br_tags_3_bits     (r_uop_3_br_tag),
    .io_brupdate_b2_uop_br_tag (io_brupdate_b2_uop_br_tag),
    .io_brupdate_b2_mispredict (io_brupdate_b2_mispredict),
    .io_debug_pipeline_empty   (io_debug_rob_empty),
    .io_alloc_pregs_0_valid    (_freelist_io_alloc_pregs_0_valid),
    .io_alloc_pregs_0_bits     (_freelist_io_alloc_pregs_0_bits),
    .io_alloc_pregs_1_valid    (_freelist_io_alloc_pregs_1_valid),
    .io_alloc_pregs_1_bits     (_freelist_io_alloc_pregs_1_bits),
    .io_alloc_pregs_2_valid    (_freelist_io_alloc_pregs_2_valid),
    .io_alloc_pregs_2_bits     (_freelist_io_alloc_pregs_2_bits),
    .io_alloc_pregs_3_valid    (_freelist_io_alloc_pregs_3_valid),
    .io_alloc_pregs_3_bits     (_freelist_io_alloc_pregs_3_bits)
  );
  RenameBusyTable_1 busytable (
    .clock                     (clock),
    .reset                     (reset),
    .io_ren_uops_0_pdst        (_freelist_io_alloc_pregs_0_bits),
    .io_ren_uops_0_prs1        (r_uop_prs1),
    .io_ren_uops_0_prs2        (r_uop_prs2),
    .io_ren_uops_0_prs3        (r_uop_prs3),
    .io_ren_uops_1_pdst        (_freelist_io_alloc_pregs_1_bits),
    .io_ren_uops_1_prs1        (r_uop_1_prs1),
    .io_ren_uops_1_prs2        (r_uop_1_prs2),
    .io_ren_uops_1_prs3        (r_uop_1_prs3),
    .io_ren_uops_2_pdst        (_freelist_io_alloc_pregs_2_bits),
    .io_ren_uops_2_prs1        (r_uop_2_prs1),
    .io_ren_uops_2_prs2        (r_uop_2_prs2),
    .io_ren_uops_2_prs3        (r_uop_2_prs3),
    .io_ren_uops_3_pdst        (_freelist_io_alloc_pregs_3_bits),
    .io_ren_uops_3_prs1        (r_uop_3_prs1),
    .io_ren_uops_3_prs2        (r_uop_3_prs2),
    .io_ren_uops_3_prs3        (r_uop_3_prs3),
    .io_rebusy_reqs_0          (ren2_alloc_reqs_0),
    .io_rebusy_reqs_1          (ren2_alloc_reqs_1),
    .io_rebusy_reqs_2          (ren2_alloc_reqs_2),
    .io_rebusy_reqs_3          (ren2_alloc_reqs_3),
    .io_wb_pdsts_0             (io_wakeups_0_bits_uop_pdst),
    .io_wb_pdsts_1             (io_wakeups_1_bits_uop_pdst),
    .io_wb_pdsts_2             (io_wakeups_2_bits_uop_pdst),
    .io_wb_pdsts_3             (io_wakeups_3_bits_uop_pdst),
    .io_wb_valids_0            (io_wakeups_0_valid),
    .io_wb_valids_1            (io_wakeups_1_valid),
    .io_wb_valids_2            (io_wakeups_2_valid),
    .io_wb_valids_3            (io_wakeups_3_valid),
    .io_busy_resps_0_prs1_busy (_busytable_io_busy_resps_0_prs1_busy),
    .io_busy_resps_0_prs2_busy (_busytable_io_busy_resps_0_prs2_busy),
    .io_busy_resps_0_prs3_busy (_busytable_io_busy_resps_0_prs3_busy),
    .io_busy_resps_1_prs1_busy (_busytable_io_busy_resps_1_prs1_busy),
    .io_busy_resps_1_prs2_busy (_busytable_io_busy_resps_1_prs2_busy),
    .io_busy_resps_1_prs3_busy (_busytable_io_busy_resps_1_prs3_busy),
    .io_busy_resps_2_prs1_busy (_busytable_io_busy_resps_2_prs1_busy),
    .io_busy_resps_2_prs2_busy (_busytable_io_busy_resps_2_prs2_busy),
    .io_busy_resps_2_prs3_busy (_busytable_io_busy_resps_2_prs3_busy),
    .io_busy_resps_3_prs1_busy (_busytable_io_busy_resps_3_prs1_busy),
    .io_busy_resps_3_prs2_busy (_busytable_io_busy_resps_3_prs2_busy),
    .io_busy_resps_3_prs3_busy (_busytable_io_busy_resps_3_prs3_busy)
  );
  assign io_ren_stalls_0 = _io_ren_stalls_0_T & ~_freelist_io_alloc_pregs_0_valid;
  assign io_ren_stalls_1 = _io_ren_stalls_1_T & ~_freelist_io_alloc_pregs_1_valid;
  assign io_ren_stalls_2 = _io_ren_stalls_2_T & ~_freelist_io_alloc_pregs_2_valid;
  assign io_ren_stalls_3 = _io_ren_stalls_3_T & ~_freelist_io_alloc_pregs_3_valid;
  assign io_ren2_uops_0_pdst = _freelist_io_alloc_pregs_0_bits;
  assign io_ren2_uops_0_prs1 = r_uop_prs1;
  assign io_ren2_uops_0_prs2 = r_uop_prs2;
  assign io_ren2_uops_0_prs3 = r_uop_prs3;
  assign io_ren2_uops_0_prs1_busy = r_uop_lrs1_rtype == 2'h1 & _busytable_io_busy_resps_0_prs1_busy;
  assign io_ren2_uops_0_prs2_busy = r_uop_lrs2_rtype == 2'h1 & _busytable_io_busy_resps_0_prs2_busy;
  assign io_ren2_uops_0_prs3_busy = r_uop_frs3_en & _busytable_io_busy_resps_0_prs3_busy;
  assign io_ren2_uops_0_stale_pdst = r_uop_stale_pdst;
  assign io_ren2_uops_1_pdst = _freelist_io_alloc_pregs_1_bits;
  assign io_ren2_uops_1_prs1 = bypassed_uop_bypass_sel_rs1_0 ? _freelist_io_alloc_pregs_0_bits : r_uop_1_prs1;
  assign io_ren2_uops_1_prs2 = bypassed_uop_bypass_sel_rs2_0 ? _freelist_io_alloc_pregs_0_bits : r_uop_1_prs2;
  assign io_ren2_uops_1_prs3 = bypassed_uop_bypass_sel_rs3_0 ? _freelist_io_alloc_pregs_0_bits : r_uop_1_prs3;
  assign io_ren2_uops_1_prs1_busy = r_uop_1_lrs1_rtype == 2'h1 & _busytable_io_busy_resps_1_prs1_busy | bypassed_uop_bypass_sel_rs1_0;
  assign io_ren2_uops_1_prs2_busy = r_uop_1_lrs2_rtype == 2'h1 & _busytable_io_busy_resps_1_prs2_busy | bypassed_uop_bypass_sel_rs2_0;
  assign io_ren2_uops_1_prs3_busy = r_uop_1_frs3_en & _busytable_io_busy_resps_1_prs3_busy | bypassed_uop_bypass_sel_rs3_0;
  assign io_ren2_uops_1_stale_pdst = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_1_ldst ? _freelist_io_alloc_pregs_0_bits : r_uop_1_stale_pdst;
  assign io_ren2_uops_2_pdst = _freelist_io_alloc_pregs_2_bits;
  assign io_ren2_uops_2_prs1 = bypassed_uop_do_bypass_rs1 ? (bypassed_uop_bypass_sel_rs1_enc_1[1] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (bypassed_uop_bypass_sel_rs1_enc_1[0] ? _freelist_io_alloc_pregs_1_bits : 7'h0) : r_uop_2_prs1;
  assign io_ren2_uops_2_prs2 = bypassed_uop_do_bypass_rs2 ? (bypassed_uop_bypass_sel_rs2_enc_1[1] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (bypassed_uop_bypass_sel_rs2_enc_1[0] ? _freelist_io_alloc_pregs_1_bits : 7'h0) : r_uop_2_prs2;
  assign io_ren2_uops_2_prs3 = bypassed_uop_do_bypass_rs3 ? (bypassed_uop_bypass_sel_rs3_enc_1[1] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (bypassed_uop_bypass_sel_rs3_enc_1[0] ? _freelist_io_alloc_pregs_1_bits : 7'h0) : r_uop_2_prs3;
  assign io_ren2_uops_2_prs1_busy = r_uop_2_lrs1_rtype == 2'h1 & _busytable_io_busy_resps_2_prs1_busy | bypassed_uop_do_bypass_rs1;
  assign io_ren2_uops_2_prs2_busy = r_uop_2_lrs2_rtype == 2'h1 & _busytable_io_busy_resps_2_prs2_busy | bypassed_uop_do_bypass_rs2;
  assign io_ren2_uops_2_prs3_busy = r_uop_2_frs3_en & _busytable_io_busy_resps_2_prs3_busy | bypassed_uop_do_bypass_rs3;
  assign io_ren2_uops_2_stale_pdst = bypassed_uop_bypass_hits_dst_0_1 | bypassed_uop_bypass_hits_dst_1 ? (bypassed_uop_bypass_sel_dst_enc_1[1] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (bypassed_uop_bypass_sel_dst_enc_1[0] ? _freelist_io_alloc_pregs_1_bits : 7'h0) : r_uop_2_stale_pdst;
  assign io_ren2_uops_3_pdst = _freelist_io_alloc_pregs_3_bits;
  assign io_ren2_uops_3_prs1 = bypassed_uop_do_bypass_rs1_1 ? (bypassed_uop_bypass_sel_rs1_enc_2[2] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (bypassed_uop_bypass_sel_rs1_enc_2[1] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (bypassed_uop_bypass_sel_rs1_enc_2[0] ? _freelist_io_alloc_pregs_2_bits : 7'h0) : r_uop_3_prs1;
  assign io_ren2_uops_3_prs2 = bypassed_uop_do_bypass_rs2_1 ? (bypassed_uop_bypass_sel_rs2_enc_2[2] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (bypassed_uop_bypass_sel_rs2_enc_2[1] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (bypassed_uop_bypass_sel_rs2_enc_2[0] ? _freelist_io_alloc_pregs_2_bits : 7'h0) : r_uop_3_prs2;
  assign io_ren2_uops_3_prs3 = bypassed_uop_do_bypass_rs3_1 ? (bypassed_uop_bypass_sel_rs3_enc_2[2] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (bypassed_uop_bypass_sel_rs3_enc_2[1] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (bypassed_uop_bypass_sel_rs3_enc_2[0] ? _freelist_io_alloc_pregs_2_bits : 7'h0) : r_uop_3_prs3;
  assign io_ren2_uops_3_prs1_busy = r_uop_3_lrs1_rtype == 2'h1 & _busytable_io_busy_resps_3_prs1_busy | bypassed_uop_do_bypass_rs1_1;
  assign io_ren2_uops_3_prs2_busy = r_uop_3_lrs2_rtype == 2'h1 & _busytable_io_busy_resps_3_prs2_busy | bypassed_uop_do_bypass_rs2_1;
  assign io_ren2_uops_3_prs3_busy = r_uop_3_frs3_en & _busytable_io_busy_resps_3_prs3_busy | bypassed_uop_do_bypass_rs3_1;
  assign io_ren2_uops_3_stale_pdst = bypassed_uop_bypass_hits_dst_0_2 | bypassed_uop_bypass_hits_dst_1_1 | bypassed_uop_bypass_hits_dst_2 ? (bypassed_uop_bypass_sel_dst_enc_2[2] ? _freelist_io_alloc_pregs_0_bits : 7'h0) | (bypassed_uop_bypass_sel_dst_enc_2[1] ? _freelist_io_alloc_pregs_1_bits : 7'h0) | (bypassed_uop_bypass_sel_dst_enc_2[0] ? _freelist_io_alloc_pregs_2_bits : 7'h0) : r_uop_3_stale_pdst;
endmodule

