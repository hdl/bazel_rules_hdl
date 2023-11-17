// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RenameMapTable(
  input        clock,
               reset,
  input  [5:0] io_map_reqs_0_lrs1,
               io_map_reqs_0_lrs2,
               io_map_reqs_0_ldst,
               io_map_reqs_1_lrs1,
               io_map_reqs_1_lrs2,
               io_map_reqs_1_ldst,
               io_map_reqs_2_lrs1,
               io_map_reqs_2_lrs2,
               io_map_reqs_2_ldst,
               io_map_reqs_3_lrs1,
               io_map_reqs_3_lrs2,
               io_map_reqs_3_ldst,
               io_remap_reqs_0_ldst,
  input  [6:0] io_remap_reqs_0_pdst,
  input        io_remap_reqs_0_valid,
  input  [5:0] io_remap_reqs_1_ldst,
  input  [6:0] io_remap_reqs_1_pdst,
  input        io_remap_reqs_1_valid,
  input  [5:0] io_remap_reqs_2_ldst,
  input  [6:0] io_remap_reqs_2_pdst,
  input        io_remap_reqs_2_valid,
  input  [5:0] io_remap_reqs_3_ldst,
  input  [6:0] io_remap_reqs_3_pdst,
  input        io_remap_reqs_3_valid,
               io_ren_br_tags_0_valid,
  input  [4:0] io_ren_br_tags_0_bits,
  input        io_ren_br_tags_1_valid,
  input  [4:0] io_ren_br_tags_1_bits,
  input        io_ren_br_tags_2_valid,
  input  [4:0] io_ren_br_tags_2_bits,
  input        io_ren_br_tags_3_valid,
  input  [4:0] io_ren_br_tags_3_bits,
               io_brupdate_b2_uop_br_tag,
  input        io_brupdate_b2_mispredict,
               io_rollback,
  output [6:0] io_map_resps_0_prs1,
               io_map_resps_0_prs2,
               io_map_resps_0_stale_pdst,
               io_map_resps_1_prs1,
               io_map_resps_1_prs2,
               io_map_resps_1_stale_pdst,
               io_map_resps_2_prs1,
               io_map_resps_2_prs2,
               io_map_resps_2_stale_pdst,
               io_map_resps_3_prs1,
               io_map_resps_3_prs2,
               io_map_resps_3_stale_pdst
);

  reg  [6:0]  casez_tmp;
  reg  [6:0]  casez_tmp_0;
  reg  [6:0]  casez_tmp_1;
  reg  [6:0]  casez_tmp_2;
  reg  [6:0]  casez_tmp_3;
  reg  [6:0]  casez_tmp_4;
  reg  [6:0]  casez_tmp_5;
  reg  [6:0]  casez_tmp_6;
  reg  [6:0]  casez_tmp_7;
  reg  [6:0]  casez_tmp_8;
  reg  [6:0]  casez_tmp_9;
  reg  [6:0]  casez_tmp_10;
  reg  [6:0]  map_table_0;
  reg  [6:0]  map_table_1;
  reg  [6:0]  map_table_2;
  reg  [6:0]  map_table_3;
  reg  [6:0]  map_table_4;
  reg  [6:0]  map_table_5;
  reg  [6:0]  map_table_6;
  reg  [6:0]  map_table_7;
  reg  [6:0]  map_table_8;
  reg  [6:0]  map_table_9;
  reg  [6:0]  map_table_10;
  reg  [6:0]  map_table_11;
  reg  [6:0]  map_table_12;
  reg  [6:0]  map_table_13;
  reg  [6:0]  map_table_14;
  reg  [6:0]  map_table_15;
  reg  [6:0]  map_table_16;
  reg  [6:0]  map_table_17;
  reg  [6:0]  map_table_18;
  reg  [6:0]  map_table_19;
  reg  [6:0]  map_table_20;
  reg  [6:0]  map_table_21;
  reg  [6:0]  map_table_22;
  reg  [6:0]  map_table_23;
  reg  [6:0]  map_table_24;
  reg  [6:0]  map_table_25;
  reg  [6:0]  map_table_26;
  reg  [6:0]  map_table_27;
  reg  [6:0]  map_table_28;
  reg  [6:0]  map_table_29;
  reg  [6:0]  map_table_30;
  reg  [6:0]  map_table_31;
  reg  [6:0]  br_snapshots_0_0;
  reg  [6:0]  br_snapshots_0_1;
  reg  [6:0]  br_snapshots_0_2;
  reg  [6:0]  br_snapshots_0_3;
  reg  [6:0]  br_snapshots_0_4;
  reg  [6:0]  br_snapshots_0_5;
  reg  [6:0]  br_snapshots_0_6;
  reg  [6:0]  br_snapshots_0_7;
  reg  [6:0]  br_snapshots_0_8;
  reg  [6:0]  br_snapshots_0_9;
  reg  [6:0]  br_snapshots_0_10;
  reg  [6:0]  br_snapshots_0_11;
  reg  [6:0]  br_snapshots_0_12;
  reg  [6:0]  br_snapshots_0_13;
  reg  [6:0]  br_snapshots_0_14;
  reg  [6:0]  br_snapshots_0_15;
  reg  [6:0]  br_snapshots_0_16;
  reg  [6:0]  br_snapshots_0_17;
  reg  [6:0]  br_snapshots_0_18;
  reg  [6:0]  br_snapshots_0_19;
  reg  [6:0]  br_snapshots_0_20;
  reg  [6:0]  br_snapshots_0_21;
  reg  [6:0]  br_snapshots_0_22;
  reg  [6:0]  br_snapshots_0_23;
  reg  [6:0]  br_snapshots_0_24;
  reg  [6:0]  br_snapshots_0_25;
  reg  [6:0]  br_snapshots_0_26;
  reg  [6:0]  br_snapshots_0_27;
  reg  [6:0]  br_snapshots_0_28;
  reg  [6:0]  br_snapshots_0_29;
  reg  [6:0]  br_snapshots_0_30;
  reg  [6:0]  br_snapshots_0_31;
  reg  [6:0]  br_snapshots_1_0;
  reg  [6:0]  br_snapshots_1_1;
  reg  [6:0]  br_snapshots_1_2;
  reg  [6:0]  br_snapshots_1_3;
  reg  [6:0]  br_snapshots_1_4;
  reg  [6:0]  br_snapshots_1_5;
  reg  [6:0]  br_snapshots_1_6;
  reg  [6:0]  br_snapshots_1_7;
  reg  [6:0]  br_snapshots_1_8;
  reg  [6:0]  br_snapshots_1_9;
  reg  [6:0]  br_snapshots_1_10;
  reg  [6:0]  br_snapshots_1_11;
  reg  [6:0]  br_snapshots_1_12;
  reg  [6:0]  br_snapshots_1_13;
  reg  [6:0]  br_snapshots_1_14;
  reg  [6:0]  br_snapshots_1_15;
  reg  [6:0]  br_snapshots_1_16;
  reg  [6:0]  br_snapshots_1_17;
  reg  [6:0]  br_snapshots_1_18;
  reg  [6:0]  br_snapshots_1_19;
  reg  [6:0]  br_snapshots_1_20;
  reg  [6:0]  br_snapshots_1_21;
  reg  [6:0]  br_snapshots_1_22;
  reg  [6:0]  br_snapshots_1_23;
  reg  [6:0]  br_snapshots_1_24;
  reg  [6:0]  br_snapshots_1_25;
  reg  [6:0]  br_snapshots_1_26;
  reg  [6:0]  br_snapshots_1_27;
  reg  [6:0]  br_snapshots_1_28;
  reg  [6:0]  br_snapshots_1_29;
  reg  [6:0]  br_snapshots_1_30;
  reg  [6:0]  br_snapshots_1_31;
  reg  [6:0]  br_snapshots_2_0;
  reg  [6:0]  br_snapshots_2_1;
  reg  [6:0]  br_snapshots_2_2;
  reg  [6:0]  br_snapshots_2_3;
  reg  [6:0]  br_snapshots_2_4;
  reg  [6:0]  br_snapshots_2_5;
  reg  [6:0]  br_snapshots_2_6;
  reg  [6:0]  br_snapshots_2_7;
  reg  [6:0]  br_snapshots_2_8;
  reg  [6:0]  br_snapshots_2_9;
  reg  [6:0]  br_snapshots_2_10;
  reg  [6:0]  br_snapshots_2_11;
  reg  [6:0]  br_snapshots_2_12;
  reg  [6:0]  br_snapshots_2_13;
  reg  [6:0]  br_snapshots_2_14;
  reg  [6:0]  br_snapshots_2_15;
  reg  [6:0]  br_snapshots_2_16;
  reg  [6:0]  br_snapshots_2_17;
  reg  [6:0]  br_snapshots_2_18;
  reg  [6:0]  br_snapshots_2_19;
  reg  [6:0]  br_snapshots_2_20;
  reg  [6:0]  br_snapshots_2_21;
  reg  [6:0]  br_snapshots_2_22;
  reg  [6:0]  br_snapshots_2_23;
  reg  [6:0]  br_snapshots_2_24;
  reg  [6:0]  br_snapshots_2_25;
  reg  [6:0]  br_snapshots_2_26;
  reg  [6:0]  br_snapshots_2_27;
  reg  [6:0]  br_snapshots_2_28;
  reg  [6:0]  br_snapshots_2_29;
  reg  [6:0]  br_snapshots_2_30;
  reg  [6:0]  br_snapshots_2_31;
  reg  [6:0]  br_snapshots_3_0;
  reg  [6:0]  br_snapshots_3_1;
  reg  [6:0]  br_snapshots_3_2;
  reg  [6:0]  br_snapshots_3_3;
  reg  [6:0]  br_snapshots_3_4;
  reg  [6:0]  br_snapshots_3_5;
  reg  [6:0]  br_snapshots_3_6;
  reg  [6:0]  br_snapshots_3_7;
  reg  [6:0]  br_snapshots_3_8;
  reg  [6:0]  br_snapshots_3_9;
  reg  [6:0]  br_snapshots_3_10;
  reg  [6:0]  br_snapshots_3_11;
  reg  [6:0]  br_snapshots_3_12;
  reg  [6:0]  br_snapshots_3_13;
  reg  [6:0]  br_snapshots_3_14;
  reg  [6:0]  br_snapshots_3_15;
  reg  [6:0]  br_snapshots_3_16;
  reg  [6:0]  br_snapshots_3_17;
  reg  [6:0]  br_snapshots_3_18;
  reg  [6:0]  br_snapshots_3_19;
  reg  [6:0]  br_snapshots_3_20;
  reg  [6:0]  br_snapshots_3_21;
  reg  [6:0]  br_snapshots_3_22;
  reg  [6:0]  br_snapshots_3_23;
  reg  [6:0]  br_snapshots_3_24;
  reg  [6:0]  br_snapshots_3_25;
  reg  [6:0]  br_snapshots_3_26;
  reg  [6:0]  br_snapshots_3_27;
  reg  [6:0]  br_snapshots_3_28;
  reg  [6:0]  br_snapshots_3_29;
  reg  [6:0]  br_snapshots_3_30;
  reg  [6:0]  br_snapshots_3_31;
  reg  [6:0]  br_snapshots_4_0;
  reg  [6:0]  br_snapshots_4_1;
  reg  [6:0]  br_snapshots_4_2;
  reg  [6:0]  br_snapshots_4_3;
  reg  [6:0]  br_snapshots_4_4;
  reg  [6:0]  br_snapshots_4_5;
  reg  [6:0]  br_snapshots_4_6;
  reg  [6:0]  br_snapshots_4_7;
  reg  [6:0]  br_snapshots_4_8;
  reg  [6:0]  br_snapshots_4_9;
  reg  [6:0]  br_snapshots_4_10;
  reg  [6:0]  br_snapshots_4_11;
  reg  [6:0]  br_snapshots_4_12;
  reg  [6:0]  br_snapshots_4_13;
  reg  [6:0]  br_snapshots_4_14;
  reg  [6:0]  br_snapshots_4_15;
  reg  [6:0]  br_snapshots_4_16;
  reg  [6:0]  br_snapshots_4_17;
  reg  [6:0]  br_snapshots_4_18;
  reg  [6:0]  br_snapshots_4_19;
  reg  [6:0]  br_snapshots_4_20;
  reg  [6:0]  br_snapshots_4_21;
  reg  [6:0]  br_snapshots_4_22;
  reg  [6:0]  br_snapshots_4_23;
  reg  [6:0]  br_snapshots_4_24;
  reg  [6:0]  br_snapshots_4_25;
  reg  [6:0]  br_snapshots_4_26;
  reg  [6:0]  br_snapshots_4_27;
  reg  [6:0]  br_snapshots_4_28;
  reg  [6:0]  br_snapshots_4_29;
  reg  [6:0]  br_snapshots_4_30;
  reg  [6:0]  br_snapshots_4_31;
  reg  [6:0]  br_snapshots_5_0;
  reg  [6:0]  br_snapshots_5_1;
  reg  [6:0]  br_snapshots_5_2;
  reg  [6:0]  br_snapshots_5_3;
  reg  [6:0]  br_snapshots_5_4;
  reg  [6:0]  br_snapshots_5_5;
  reg  [6:0]  br_snapshots_5_6;
  reg  [6:0]  br_snapshots_5_7;
  reg  [6:0]  br_snapshots_5_8;
  reg  [6:0]  br_snapshots_5_9;
  reg  [6:0]  br_snapshots_5_10;
  reg  [6:0]  br_snapshots_5_11;
  reg  [6:0]  br_snapshots_5_12;
  reg  [6:0]  br_snapshots_5_13;
  reg  [6:0]  br_snapshots_5_14;
  reg  [6:0]  br_snapshots_5_15;
  reg  [6:0]  br_snapshots_5_16;
  reg  [6:0]  br_snapshots_5_17;
  reg  [6:0]  br_snapshots_5_18;
  reg  [6:0]  br_snapshots_5_19;
  reg  [6:0]  br_snapshots_5_20;
  reg  [6:0]  br_snapshots_5_21;
  reg  [6:0]  br_snapshots_5_22;
  reg  [6:0]  br_snapshots_5_23;
  reg  [6:0]  br_snapshots_5_24;
  reg  [6:0]  br_snapshots_5_25;
  reg  [6:0]  br_snapshots_5_26;
  reg  [6:0]  br_snapshots_5_27;
  reg  [6:0]  br_snapshots_5_28;
  reg  [6:0]  br_snapshots_5_29;
  reg  [6:0]  br_snapshots_5_30;
  reg  [6:0]  br_snapshots_5_31;
  reg  [6:0]  br_snapshots_6_0;
  reg  [6:0]  br_snapshots_6_1;
  reg  [6:0]  br_snapshots_6_2;
  reg  [6:0]  br_snapshots_6_3;
  reg  [6:0]  br_snapshots_6_4;
  reg  [6:0]  br_snapshots_6_5;
  reg  [6:0]  br_snapshots_6_6;
  reg  [6:0]  br_snapshots_6_7;
  reg  [6:0]  br_snapshots_6_8;
  reg  [6:0]  br_snapshots_6_9;
  reg  [6:0]  br_snapshots_6_10;
  reg  [6:0]  br_snapshots_6_11;
  reg  [6:0]  br_snapshots_6_12;
  reg  [6:0]  br_snapshots_6_13;
  reg  [6:0]  br_snapshots_6_14;
  reg  [6:0]  br_snapshots_6_15;
  reg  [6:0]  br_snapshots_6_16;
  reg  [6:0]  br_snapshots_6_17;
  reg  [6:0]  br_snapshots_6_18;
  reg  [6:0]  br_snapshots_6_19;
  reg  [6:0]  br_snapshots_6_20;
  reg  [6:0]  br_snapshots_6_21;
  reg  [6:0]  br_snapshots_6_22;
  reg  [6:0]  br_snapshots_6_23;
  reg  [6:0]  br_snapshots_6_24;
  reg  [6:0]  br_snapshots_6_25;
  reg  [6:0]  br_snapshots_6_26;
  reg  [6:0]  br_snapshots_6_27;
  reg  [6:0]  br_snapshots_6_28;
  reg  [6:0]  br_snapshots_6_29;
  reg  [6:0]  br_snapshots_6_30;
  reg  [6:0]  br_snapshots_6_31;
  reg  [6:0]  br_snapshots_7_0;
  reg  [6:0]  br_snapshots_7_1;
  reg  [6:0]  br_snapshots_7_2;
  reg  [6:0]  br_snapshots_7_3;
  reg  [6:0]  br_snapshots_7_4;
  reg  [6:0]  br_snapshots_7_5;
  reg  [6:0]  br_snapshots_7_6;
  reg  [6:0]  br_snapshots_7_7;
  reg  [6:0]  br_snapshots_7_8;
  reg  [6:0]  br_snapshots_7_9;
  reg  [6:0]  br_snapshots_7_10;
  reg  [6:0]  br_snapshots_7_11;
  reg  [6:0]  br_snapshots_7_12;
  reg  [6:0]  br_snapshots_7_13;
  reg  [6:0]  br_snapshots_7_14;
  reg  [6:0]  br_snapshots_7_15;
  reg  [6:0]  br_snapshots_7_16;
  reg  [6:0]  br_snapshots_7_17;
  reg  [6:0]  br_snapshots_7_18;
  reg  [6:0]  br_snapshots_7_19;
  reg  [6:0]  br_snapshots_7_20;
  reg  [6:0]  br_snapshots_7_21;
  reg  [6:0]  br_snapshots_7_22;
  reg  [6:0]  br_snapshots_7_23;
  reg  [6:0]  br_snapshots_7_24;
  reg  [6:0]  br_snapshots_7_25;
  reg  [6:0]  br_snapshots_7_26;
  reg  [6:0]  br_snapshots_7_27;
  reg  [6:0]  br_snapshots_7_28;
  reg  [6:0]  br_snapshots_7_29;
  reg  [6:0]  br_snapshots_7_30;
  reg  [6:0]  br_snapshots_7_31;
  reg  [6:0]  br_snapshots_8_0;
  reg  [6:0]  br_snapshots_8_1;
  reg  [6:0]  br_snapshots_8_2;
  reg  [6:0]  br_snapshots_8_3;
  reg  [6:0]  br_snapshots_8_4;
  reg  [6:0]  br_snapshots_8_5;
  reg  [6:0]  br_snapshots_8_6;
  reg  [6:0]  br_snapshots_8_7;
  reg  [6:0]  br_snapshots_8_8;
  reg  [6:0]  br_snapshots_8_9;
  reg  [6:0]  br_snapshots_8_10;
  reg  [6:0]  br_snapshots_8_11;
  reg  [6:0]  br_snapshots_8_12;
  reg  [6:0]  br_snapshots_8_13;
  reg  [6:0]  br_snapshots_8_14;
  reg  [6:0]  br_snapshots_8_15;
  reg  [6:0]  br_snapshots_8_16;
  reg  [6:0]  br_snapshots_8_17;
  reg  [6:0]  br_snapshots_8_18;
  reg  [6:0]  br_snapshots_8_19;
  reg  [6:0]  br_snapshots_8_20;
  reg  [6:0]  br_snapshots_8_21;
  reg  [6:0]  br_snapshots_8_22;
  reg  [6:0]  br_snapshots_8_23;
  reg  [6:0]  br_snapshots_8_24;
  reg  [6:0]  br_snapshots_8_25;
  reg  [6:0]  br_snapshots_8_26;
  reg  [6:0]  br_snapshots_8_27;
  reg  [6:0]  br_snapshots_8_28;
  reg  [6:0]  br_snapshots_8_29;
  reg  [6:0]  br_snapshots_8_30;
  reg  [6:0]  br_snapshots_8_31;
  reg  [6:0]  br_snapshots_9_0;
  reg  [6:0]  br_snapshots_9_1;
  reg  [6:0]  br_snapshots_9_2;
  reg  [6:0]  br_snapshots_9_3;
  reg  [6:0]  br_snapshots_9_4;
  reg  [6:0]  br_snapshots_9_5;
  reg  [6:0]  br_snapshots_9_6;
  reg  [6:0]  br_snapshots_9_7;
  reg  [6:0]  br_snapshots_9_8;
  reg  [6:0]  br_snapshots_9_9;
  reg  [6:0]  br_snapshots_9_10;
  reg  [6:0]  br_snapshots_9_11;
  reg  [6:0]  br_snapshots_9_12;
  reg  [6:0]  br_snapshots_9_13;
  reg  [6:0]  br_snapshots_9_14;
  reg  [6:0]  br_snapshots_9_15;
  reg  [6:0]  br_snapshots_9_16;
  reg  [6:0]  br_snapshots_9_17;
  reg  [6:0]  br_snapshots_9_18;
  reg  [6:0]  br_snapshots_9_19;
  reg  [6:0]  br_snapshots_9_20;
  reg  [6:0]  br_snapshots_9_21;
  reg  [6:0]  br_snapshots_9_22;
  reg  [6:0]  br_snapshots_9_23;
  reg  [6:0]  br_snapshots_9_24;
  reg  [6:0]  br_snapshots_9_25;
  reg  [6:0]  br_snapshots_9_26;
  reg  [6:0]  br_snapshots_9_27;
  reg  [6:0]  br_snapshots_9_28;
  reg  [6:0]  br_snapshots_9_29;
  reg  [6:0]  br_snapshots_9_30;
  reg  [6:0]  br_snapshots_9_31;
  reg  [6:0]  br_snapshots_10_0;
  reg  [6:0]  br_snapshots_10_1;
  reg  [6:0]  br_snapshots_10_2;
  reg  [6:0]  br_snapshots_10_3;
  reg  [6:0]  br_snapshots_10_4;
  reg  [6:0]  br_snapshots_10_5;
  reg  [6:0]  br_snapshots_10_6;
  reg  [6:0]  br_snapshots_10_7;
  reg  [6:0]  br_snapshots_10_8;
  reg  [6:0]  br_snapshots_10_9;
  reg  [6:0]  br_snapshots_10_10;
  reg  [6:0]  br_snapshots_10_11;
  reg  [6:0]  br_snapshots_10_12;
  reg  [6:0]  br_snapshots_10_13;
  reg  [6:0]  br_snapshots_10_14;
  reg  [6:0]  br_snapshots_10_15;
  reg  [6:0]  br_snapshots_10_16;
  reg  [6:0]  br_snapshots_10_17;
  reg  [6:0]  br_snapshots_10_18;
  reg  [6:0]  br_snapshots_10_19;
  reg  [6:0]  br_snapshots_10_20;
  reg  [6:0]  br_snapshots_10_21;
  reg  [6:0]  br_snapshots_10_22;
  reg  [6:0]  br_snapshots_10_23;
  reg  [6:0]  br_snapshots_10_24;
  reg  [6:0]  br_snapshots_10_25;
  reg  [6:0]  br_snapshots_10_26;
  reg  [6:0]  br_snapshots_10_27;
  reg  [6:0]  br_snapshots_10_28;
  reg  [6:0]  br_snapshots_10_29;
  reg  [6:0]  br_snapshots_10_30;
  reg  [6:0]  br_snapshots_10_31;
  reg  [6:0]  br_snapshots_11_0;
  reg  [6:0]  br_snapshots_11_1;
  reg  [6:0]  br_snapshots_11_2;
  reg  [6:0]  br_snapshots_11_3;
  reg  [6:0]  br_snapshots_11_4;
  reg  [6:0]  br_snapshots_11_5;
  reg  [6:0]  br_snapshots_11_6;
  reg  [6:0]  br_snapshots_11_7;
  reg  [6:0]  br_snapshots_11_8;
  reg  [6:0]  br_snapshots_11_9;
  reg  [6:0]  br_snapshots_11_10;
  reg  [6:0]  br_snapshots_11_11;
  reg  [6:0]  br_snapshots_11_12;
  reg  [6:0]  br_snapshots_11_13;
  reg  [6:0]  br_snapshots_11_14;
  reg  [6:0]  br_snapshots_11_15;
  reg  [6:0]  br_snapshots_11_16;
  reg  [6:0]  br_snapshots_11_17;
  reg  [6:0]  br_snapshots_11_18;
  reg  [6:0]  br_snapshots_11_19;
  reg  [6:0]  br_snapshots_11_20;
  reg  [6:0]  br_snapshots_11_21;
  reg  [6:0]  br_snapshots_11_22;
  reg  [6:0]  br_snapshots_11_23;
  reg  [6:0]  br_snapshots_11_24;
  reg  [6:0]  br_snapshots_11_25;
  reg  [6:0]  br_snapshots_11_26;
  reg  [6:0]  br_snapshots_11_27;
  reg  [6:0]  br_snapshots_11_28;
  reg  [6:0]  br_snapshots_11_29;
  reg  [6:0]  br_snapshots_11_30;
  reg  [6:0]  br_snapshots_11_31;
  reg  [6:0]  br_snapshots_12_0;
  reg  [6:0]  br_snapshots_12_1;
  reg  [6:0]  br_snapshots_12_2;
  reg  [6:0]  br_snapshots_12_3;
  reg  [6:0]  br_snapshots_12_4;
  reg  [6:0]  br_snapshots_12_5;
  reg  [6:0]  br_snapshots_12_6;
  reg  [6:0]  br_snapshots_12_7;
  reg  [6:0]  br_snapshots_12_8;
  reg  [6:0]  br_snapshots_12_9;
  reg  [6:0]  br_snapshots_12_10;
  reg  [6:0]  br_snapshots_12_11;
  reg  [6:0]  br_snapshots_12_12;
  reg  [6:0]  br_snapshots_12_13;
  reg  [6:0]  br_snapshots_12_14;
  reg  [6:0]  br_snapshots_12_15;
  reg  [6:0]  br_snapshots_12_16;
  reg  [6:0]  br_snapshots_12_17;
  reg  [6:0]  br_snapshots_12_18;
  reg  [6:0]  br_snapshots_12_19;
  reg  [6:0]  br_snapshots_12_20;
  reg  [6:0]  br_snapshots_12_21;
  reg  [6:0]  br_snapshots_12_22;
  reg  [6:0]  br_snapshots_12_23;
  reg  [6:0]  br_snapshots_12_24;
  reg  [6:0]  br_snapshots_12_25;
  reg  [6:0]  br_snapshots_12_26;
  reg  [6:0]  br_snapshots_12_27;
  reg  [6:0]  br_snapshots_12_28;
  reg  [6:0]  br_snapshots_12_29;
  reg  [6:0]  br_snapshots_12_30;
  reg  [6:0]  br_snapshots_12_31;
  reg  [6:0]  br_snapshots_13_0;
  reg  [6:0]  br_snapshots_13_1;
  reg  [6:0]  br_snapshots_13_2;
  reg  [6:0]  br_snapshots_13_3;
  reg  [6:0]  br_snapshots_13_4;
  reg  [6:0]  br_snapshots_13_5;
  reg  [6:0]  br_snapshots_13_6;
  reg  [6:0]  br_snapshots_13_7;
  reg  [6:0]  br_snapshots_13_8;
  reg  [6:0]  br_snapshots_13_9;
  reg  [6:0]  br_snapshots_13_10;
  reg  [6:0]  br_snapshots_13_11;
  reg  [6:0]  br_snapshots_13_12;
  reg  [6:0]  br_snapshots_13_13;
  reg  [6:0]  br_snapshots_13_14;
  reg  [6:0]  br_snapshots_13_15;
  reg  [6:0]  br_snapshots_13_16;
  reg  [6:0]  br_snapshots_13_17;
  reg  [6:0]  br_snapshots_13_18;
  reg  [6:0]  br_snapshots_13_19;
  reg  [6:0]  br_snapshots_13_20;
  reg  [6:0]  br_snapshots_13_21;
  reg  [6:0]  br_snapshots_13_22;
  reg  [6:0]  br_snapshots_13_23;
  reg  [6:0]  br_snapshots_13_24;
  reg  [6:0]  br_snapshots_13_25;
  reg  [6:0]  br_snapshots_13_26;
  reg  [6:0]  br_snapshots_13_27;
  reg  [6:0]  br_snapshots_13_28;
  reg  [6:0]  br_snapshots_13_29;
  reg  [6:0]  br_snapshots_13_30;
  reg  [6:0]  br_snapshots_13_31;
  reg  [6:0]  br_snapshots_14_0;
  reg  [6:0]  br_snapshots_14_1;
  reg  [6:0]  br_snapshots_14_2;
  reg  [6:0]  br_snapshots_14_3;
  reg  [6:0]  br_snapshots_14_4;
  reg  [6:0]  br_snapshots_14_5;
  reg  [6:0]  br_snapshots_14_6;
  reg  [6:0]  br_snapshots_14_7;
  reg  [6:0]  br_snapshots_14_8;
  reg  [6:0]  br_snapshots_14_9;
  reg  [6:0]  br_snapshots_14_10;
  reg  [6:0]  br_snapshots_14_11;
  reg  [6:0]  br_snapshots_14_12;
  reg  [6:0]  br_snapshots_14_13;
  reg  [6:0]  br_snapshots_14_14;
  reg  [6:0]  br_snapshots_14_15;
  reg  [6:0]  br_snapshots_14_16;
  reg  [6:0]  br_snapshots_14_17;
  reg  [6:0]  br_snapshots_14_18;
  reg  [6:0]  br_snapshots_14_19;
  reg  [6:0]  br_snapshots_14_20;
  reg  [6:0]  br_snapshots_14_21;
  reg  [6:0]  br_snapshots_14_22;
  reg  [6:0]  br_snapshots_14_23;
  reg  [6:0]  br_snapshots_14_24;
  reg  [6:0]  br_snapshots_14_25;
  reg  [6:0]  br_snapshots_14_26;
  reg  [6:0]  br_snapshots_14_27;
  reg  [6:0]  br_snapshots_14_28;
  reg  [6:0]  br_snapshots_14_29;
  reg  [6:0]  br_snapshots_14_30;
  reg  [6:0]  br_snapshots_14_31;
  reg  [6:0]  br_snapshots_15_0;
  reg  [6:0]  br_snapshots_15_1;
  reg  [6:0]  br_snapshots_15_2;
  reg  [6:0]  br_snapshots_15_3;
  reg  [6:0]  br_snapshots_15_4;
  reg  [6:0]  br_snapshots_15_5;
  reg  [6:0]  br_snapshots_15_6;
  reg  [6:0]  br_snapshots_15_7;
  reg  [6:0]  br_snapshots_15_8;
  reg  [6:0]  br_snapshots_15_9;
  reg  [6:0]  br_snapshots_15_10;
  reg  [6:0]  br_snapshots_15_11;
  reg  [6:0]  br_snapshots_15_12;
  reg  [6:0]  br_snapshots_15_13;
  reg  [6:0]  br_snapshots_15_14;
  reg  [6:0]  br_snapshots_15_15;
  reg  [6:0]  br_snapshots_15_16;
  reg  [6:0]  br_snapshots_15_17;
  reg  [6:0]  br_snapshots_15_18;
  reg  [6:0]  br_snapshots_15_19;
  reg  [6:0]  br_snapshots_15_20;
  reg  [6:0]  br_snapshots_15_21;
  reg  [6:0]  br_snapshots_15_22;
  reg  [6:0]  br_snapshots_15_23;
  reg  [6:0]  br_snapshots_15_24;
  reg  [6:0]  br_snapshots_15_25;
  reg  [6:0]  br_snapshots_15_26;
  reg  [6:0]  br_snapshots_15_27;
  reg  [6:0]  br_snapshots_15_28;
  reg  [6:0]  br_snapshots_15_29;
  reg  [6:0]  br_snapshots_15_30;
  reg  [6:0]  br_snapshots_15_31;
  reg  [6:0]  br_snapshots_16_0;
  reg  [6:0]  br_snapshots_16_1;
  reg  [6:0]  br_snapshots_16_2;
  reg  [6:0]  br_snapshots_16_3;
  reg  [6:0]  br_snapshots_16_4;
  reg  [6:0]  br_snapshots_16_5;
  reg  [6:0]  br_snapshots_16_6;
  reg  [6:0]  br_snapshots_16_7;
  reg  [6:0]  br_snapshots_16_8;
  reg  [6:0]  br_snapshots_16_9;
  reg  [6:0]  br_snapshots_16_10;
  reg  [6:0]  br_snapshots_16_11;
  reg  [6:0]  br_snapshots_16_12;
  reg  [6:0]  br_snapshots_16_13;
  reg  [6:0]  br_snapshots_16_14;
  reg  [6:0]  br_snapshots_16_15;
  reg  [6:0]  br_snapshots_16_16;
  reg  [6:0]  br_snapshots_16_17;
  reg  [6:0]  br_snapshots_16_18;
  reg  [6:0]  br_snapshots_16_19;
  reg  [6:0]  br_snapshots_16_20;
  reg  [6:0]  br_snapshots_16_21;
  reg  [6:0]  br_snapshots_16_22;
  reg  [6:0]  br_snapshots_16_23;
  reg  [6:0]  br_snapshots_16_24;
  reg  [6:0]  br_snapshots_16_25;
  reg  [6:0]  br_snapshots_16_26;
  reg  [6:0]  br_snapshots_16_27;
  reg  [6:0]  br_snapshots_16_28;
  reg  [6:0]  br_snapshots_16_29;
  reg  [6:0]  br_snapshots_16_30;
  reg  [6:0]  br_snapshots_16_31;
  reg  [6:0]  br_snapshots_17_0;
  reg  [6:0]  br_snapshots_17_1;
  reg  [6:0]  br_snapshots_17_2;
  reg  [6:0]  br_snapshots_17_3;
  reg  [6:0]  br_snapshots_17_4;
  reg  [6:0]  br_snapshots_17_5;
  reg  [6:0]  br_snapshots_17_6;
  reg  [6:0]  br_snapshots_17_7;
  reg  [6:0]  br_snapshots_17_8;
  reg  [6:0]  br_snapshots_17_9;
  reg  [6:0]  br_snapshots_17_10;
  reg  [6:0]  br_snapshots_17_11;
  reg  [6:0]  br_snapshots_17_12;
  reg  [6:0]  br_snapshots_17_13;
  reg  [6:0]  br_snapshots_17_14;
  reg  [6:0]  br_snapshots_17_15;
  reg  [6:0]  br_snapshots_17_16;
  reg  [6:0]  br_snapshots_17_17;
  reg  [6:0]  br_snapshots_17_18;
  reg  [6:0]  br_snapshots_17_19;
  reg  [6:0]  br_snapshots_17_20;
  reg  [6:0]  br_snapshots_17_21;
  reg  [6:0]  br_snapshots_17_22;
  reg  [6:0]  br_snapshots_17_23;
  reg  [6:0]  br_snapshots_17_24;
  reg  [6:0]  br_snapshots_17_25;
  reg  [6:0]  br_snapshots_17_26;
  reg  [6:0]  br_snapshots_17_27;
  reg  [6:0]  br_snapshots_17_28;
  reg  [6:0]  br_snapshots_17_29;
  reg  [6:0]  br_snapshots_17_30;
  reg  [6:0]  br_snapshots_17_31;
  reg  [6:0]  br_snapshots_18_0;
  reg  [6:0]  br_snapshots_18_1;
  reg  [6:0]  br_snapshots_18_2;
  reg  [6:0]  br_snapshots_18_3;
  reg  [6:0]  br_snapshots_18_4;
  reg  [6:0]  br_snapshots_18_5;
  reg  [6:0]  br_snapshots_18_6;
  reg  [6:0]  br_snapshots_18_7;
  reg  [6:0]  br_snapshots_18_8;
  reg  [6:0]  br_snapshots_18_9;
  reg  [6:0]  br_snapshots_18_10;
  reg  [6:0]  br_snapshots_18_11;
  reg  [6:0]  br_snapshots_18_12;
  reg  [6:0]  br_snapshots_18_13;
  reg  [6:0]  br_snapshots_18_14;
  reg  [6:0]  br_snapshots_18_15;
  reg  [6:0]  br_snapshots_18_16;
  reg  [6:0]  br_snapshots_18_17;
  reg  [6:0]  br_snapshots_18_18;
  reg  [6:0]  br_snapshots_18_19;
  reg  [6:0]  br_snapshots_18_20;
  reg  [6:0]  br_snapshots_18_21;
  reg  [6:0]  br_snapshots_18_22;
  reg  [6:0]  br_snapshots_18_23;
  reg  [6:0]  br_snapshots_18_24;
  reg  [6:0]  br_snapshots_18_25;
  reg  [6:0]  br_snapshots_18_26;
  reg  [6:0]  br_snapshots_18_27;
  reg  [6:0]  br_snapshots_18_28;
  reg  [6:0]  br_snapshots_18_29;
  reg  [6:0]  br_snapshots_18_30;
  reg  [6:0]  br_snapshots_18_31;
  reg  [6:0]  br_snapshots_19_0;
  reg  [6:0]  br_snapshots_19_1;
  reg  [6:0]  br_snapshots_19_2;
  reg  [6:0]  br_snapshots_19_3;
  reg  [6:0]  br_snapshots_19_4;
  reg  [6:0]  br_snapshots_19_5;
  reg  [6:0]  br_snapshots_19_6;
  reg  [6:0]  br_snapshots_19_7;
  reg  [6:0]  br_snapshots_19_8;
  reg  [6:0]  br_snapshots_19_9;
  reg  [6:0]  br_snapshots_19_10;
  reg  [6:0]  br_snapshots_19_11;
  reg  [6:0]  br_snapshots_19_12;
  reg  [6:0]  br_snapshots_19_13;
  reg  [6:0]  br_snapshots_19_14;
  reg  [6:0]  br_snapshots_19_15;
  reg  [6:0]  br_snapshots_19_16;
  reg  [6:0]  br_snapshots_19_17;
  reg  [6:0]  br_snapshots_19_18;
  reg  [6:0]  br_snapshots_19_19;
  reg  [6:0]  br_snapshots_19_20;
  reg  [6:0]  br_snapshots_19_21;
  reg  [6:0]  br_snapshots_19_22;
  reg  [6:0]  br_snapshots_19_23;
  reg  [6:0]  br_snapshots_19_24;
  reg  [6:0]  br_snapshots_19_25;
  reg  [6:0]  br_snapshots_19_26;
  reg  [6:0]  br_snapshots_19_27;
  reg  [6:0]  br_snapshots_19_28;
  reg  [6:0]  br_snapshots_19_29;
  reg  [6:0]  br_snapshots_19_30;
  reg  [6:0]  br_snapshots_19_31;
  always @(*) begin
    casez (io_map_reqs_0_lrs1[4:0])
      5'b00000:
        casez_tmp = map_table_0;
      5'b00001:
        casez_tmp = map_table_1;
      5'b00010:
        casez_tmp = map_table_2;
      5'b00011:
        casez_tmp = map_table_3;
      5'b00100:
        casez_tmp = map_table_4;
      5'b00101:
        casez_tmp = map_table_5;
      5'b00110:
        casez_tmp = map_table_6;
      5'b00111:
        casez_tmp = map_table_7;
      5'b01000:
        casez_tmp = map_table_8;
      5'b01001:
        casez_tmp = map_table_9;
      5'b01010:
        casez_tmp = map_table_10;
      5'b01011:
        casez_tmp = map_table_11;
      5'b01100:
        casez_tmp = map_table_12;
      5'b01101:
        casez_tmp = map_table_13;
      5'b01110:
        casez_tmp = map_table_14;
      5'b01111:
        casez_tmp = map_table_15;
      5'b10000:
        casez_tmp = map_table_16;
      5'b10001:
        casez_tmp = map_table_17;
      5'b10010:
        casez_tmp = map_table_18;
      5'b10011:
        casez_tmp = map_table_19;
      5'b10100:
        casez_tmp = map_table_20;
      5'b10101:
        casez_tmp = map_table_21;
      5'b10110:
        casez_tmp = map_table_22;
      5'b10111:
        casez_tmp = map_table_23;
      5'b11000:
        casez_tmp = map_table_24;
      5'b11001:
        casez_tmp = map_table_25;
      5'b11010:
        casez_tmp = map_table_26;
      5'b11011:
        casez_tmp = map_table_27;
      5'b11100:
        casez_tmp = map_table_28;
      5'b11101:
        casez_tmp = map_table_29;
      5'b11110:
        casez_tmp = map_table_30;
      default:
        casez_tmp = map_table_31;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_map_reqs_0_lrs2[4:0])
      5'b00000:
        casez_tmp_0 = map_table_0;
      5'b00001:
        casez_tmp_0 = map_table_1;
      5'b00010:
        casez_tmp_0 = map_table_2;
      5'b00011:
        casez_tmp_0 = map_table_3;
      5'b00100:
        casez_tmp_0 = map_table_4;
      5'b00101:
        casez_tmp_0 = map_table_5;
      5'b00110:
        casez_tmp_0 = map_table_6;
      5'b00111:
        casez_tmp_0 = map_table_7;
      5'b01000:
        casez_tmp_0 = map_table_8;
      5'b01001:
        casez_tmp_0 = map_table_9;
      5'b01010:
        casez_tmp_0 = map_table_10;
      5'b01011:
        casez_tmp_0 = map_table_11;
      5'b01100:
        casez_tmp_0 = map_table_12;
      5'b01101:
        casez_tmp_0 = map_table_13;
      5'b01110:
        casez_tmp_0 = map_table_14;
      5'b01111:
        casez_tmp_0 = map_table_15;
      5'b10000:
        casez_tmp_0 = map_table_16;
      5'b10001:
        casez_tmp_0 = map_table_17;
      5'b10010:
        casez_tmp_0 = map_table_18;
      5'b10011:
        casez_tmp_0 = map_table_19;
      5'b10100:
        casez_tmp_0 = map_table_20;
      5'b10101:
        casez_tmp_0 = map_table_21;
      5'b10110:
        casez_tmp_0 = map_table_22;
      5'b10111:
        casez_tmp_0 = map_table_23;
      5'b11000:
        casez_tmp_0 = map_table_24;
      5'b11001:
        casez_tmp_0 = map_table_25;
      5'b11010:
        casez_tmp_0 = map_table_26;
      5'b11011:
        casez_tmp_0 = map_table_27;
      5'b11100:
        casez_tmp_0 = map_table_28;
      5'b11101:
        casez_tmp_0 = map_table_29;
      5'b11110:
        casez_tmp_0 = map_table_30;
      default:
        casez_tmp_0 = map_table_31;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_map_reqs_0_ldst[4:0])
      5'b00000:
        casez_tmp_1 = map_table_0;
      5'b00001:
        casez_tmp_1 = map_table_1;
      5'b00010:
        casez_tmp_1 = map_table_2;
      5'b00011:
        casez_tmp_1 = map_table_3;
      5'b00100:
        casez_tmp_1 = map_table_4;
      5'b00101:
        casez_tmp_1 = map_table_5;
      5'b00110:
        casez_tmp_1 = map_table_6;
      5'b00111:
        casez_tmp_1 = map_table_7;
      5'b01000:
        casez_tmp_1 = map_table_8;
      5'b01001:
        casez_tmp_1 = map_table_9;
      5'b01010:
        casez_tmp_1 = map_table_10;
      5'b01011:
        casez_tmp_1 = map_table_11;
      5'b01100:
        casez_tmp_1 = map_table_12;
      5'b01101:
        casez_tmp_1 = map_table_13;
      5'b01110:
        casez_tmp_1 = map_table_14;
      5'b01111:
        casez_tmp_1 = map_table_15;
      5'b10000:
        casez_tmp_1 = map_table_16;
      5'b10001:
        casez_tmp_1 = map_table_17;
      5'b10010:
        casez_tmp_1 = map_table_18;
      5'b10011:
        casez_tmp_1 = map_table_19;
      5'b10100:
        casez_tmp_1 = map_table_20;
      5'b10101:
        casez_tmp_1 = map_table_21;
      5'b10110:
        casez_tmp_1 = map_table_22;
      5'b10111:
        casez_tmp_1 = map_table_23;
      5'b11000:
        casez_tmp_1 = map_table_24;
      5'b11001:
        casez_tmp_1 = map_table_25;
      5'b11010:
        casez_tmp_1 = map_table_26;
      5'b11011:
        casez_tmp_1 = map_table_27;
      5'b11100:
        casez_tmp_1 = map_table_28;
      5'b11101:
        casez_tmp_1 = map_table_29;
      5'b11110:
        casez_tmp_1 = map_table_30;
      default:
        casez_tmp_1 = map_table_31;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_map_reqs_1_lrs1[4:0])
      5'b00000:
        casez_tmp_2 = map_table_0;
      5'b00001:
        casez_tmp_2 = map_table_1;
      5'b00010:
        casez_tmp_2 = map_table_2;
      5'b00011:
        casez_tmp_2 = map_table_3;
      5'b00100:
        casez_tmp_2 = map_table_4;
      5'b00101:
        casez_tmp_2 = map_table_5;
      5'b00110:
        casez_tmp_2 = map_table_6;
      5'b00111:
        casez_tmp_2 = map_table_7;
      5'b01000:
        casez_tmp_2 = map_table_8;
      5'b01001:
        casez_tmp_2 = map_table_9;
      5'b01010:
        casez_tmp_2 = map_table_10;
      5'b01011:
        casez_tmp_2 = map_table_11;
      5'b01100:
        casez_tmp_2 = map_table_12;
      5'b01101:
        casez_tmp_2 = map_table_13;
      5'b01110:
        casez_tmp_2 = map_table_14;
      5'b01111:
        casez_tmp_2 = map_table_15;
      5'b10000:
        casez_tmp_2 = map_table_16;
      5'b10001:
        casez_tmp_2 = map_table_17;
      5'b10010:
        casez_tmp_2 = map_table_18;
      5'b10011:
        casez_tmp_2 = map_table_19;
      5'b10100:
        casez_tmp_2 = map_table_20;
      5'b10101:
        casez_tmp_2 = map_table_21;
      5'b10110:
        casez_tmp_2 = map_table_22;
      5'b10111:
        casez_tmp_2 = map_table_23;
      5'b11000:
        casez_tmp_2 = map_table_24;
      5'b11001:
        casez_tmp_2 = map_table_25;
      5'b11010:
        casez_tmp_2 = map_table_26;
      5'b11011:
        casez_tmp_2 = map_table_27;
      5'b11100:
        casez_tmp_2 = map_table_28;
      5'b11101:
        casez_tmp_2 = map_table_29;
      5'b11110:
        casez_tmp_2 = map_table_30;
      default:
        casez_tmp_2 = map_table_31;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_map_reqs_1_lrs2[4:0])
      5'b00000:
        casez_tmp_3 = map_table_0;
      5'b00001:
        casez_tmp_3 = map_table_1;
      5'b00010:
        casez_tmp_3 = map_table_2;
      5'b00011:
        casez_tmp_3 = map_table_3;
      5'b00100:
        casez_tmp_3 = map_table_4;
      5'b00101:
        casez_tmp_3 = map_table_5;
      5'b00110:
        casez_tmp_3 = map_table_6;
      5'b00111:
        casez_tmp_3 = map_table_7;
      5'b01000:
        casez_tmp_3 = map_table_8;
      5'b01001:
        casez_tmp_3 = map_table_9;
      5'b01010:
        casez_tmp_3 = map_table_10;
      5'b01011:
        casez_tmp_3 = map_table_11;
      5'b01100:
        casez_tmp_3 = map_table_12;
      5'b01101:
        casez_tmp_3 = map_table_13;
      5'b01110:
        casez_tmp_3 = map_table_14;
      5'b01111:
        casez_tmp_3 = map_table_15;
      5'b10000:
        casez_tmp_3 = map_table_16;
      5'b10001:
        casez_tmp_3 = map_table_17;
      5'b10010:
        casez_tmp_3 = map_table_18;
      5'b10011:
        casez_tmp_3 = map_table_19;
      5'b10100:
        casez_tmp_3 = map_table_20;
      5'b10101:
        casez_tmp_3 = map_table_21;
      5'b10110:
        casez_tmp_3 = map_table_22;
      5'b10111:
        casez_tmp_3 = map_table_23;
      5'b11000:
        casez_tmp_3 = map_table_24;
      5'b11001:
        casez_tmp_3 = map_table_25;
      5'b11010:
        casez_tmp_3 = map_table_26;
      5'b11011:
        casez_tmp_3 = map_table_27;
      5'b11100:
        casez_tmp_3 = map_table_28;
      5'b11101:
        casez_tmp_3 = map_table_29;
      5'b11110:
        casez_tmp_3 = map_table_30;
      default:
        casez_tmp_3 = map_table_31;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_map_reqs_1_ldst[4:0])
      5'b00000:
        casez_tmp_4 = map_table_0;
      5'b00001:
        casez_tmp_4 = map_table_1;
      5'b00010:
        casez_tmp_4 = map_table_2;
      5'b00011:
        casez_tmp_4 = map_table_3;
      5'b00100:
        casez_tmp_4 = map_table_4;
      5'b00101:
        casez_tmp_4 = map_table_5;
      5'b00110:
        casez_tmp_4 = map_table_6;
      5'b00111:
        casez_tmp_4 = map_table_7;
      5'b01000:
        casez_tmp_4 = map_table_8;
      5'b01001:
        casez_tmp_4 = map_table_9;
      5'b01010:
        casez_tmp_4 = map_table_10;
      5'b01011:
        casez_tmp_4 = map_table_11;
      5'b01100:
        casez_tmp_4 = map_table_12;
      5'b01101:
        casez_tmp_4 = map_table_13;
      5'b01110:
        casez_tmp_4 = map_table_14;
      5'b01111:
        casez_tmp_4 = map_table_15;
      5'b10000:
        casez_tmp_4 = map_table_16;
      5'b10001:
        casez_tmp_4 = map_table_17;
      5'b10010:
        casez_tmp_4 = map_table_18;
      5'b10011:
        casez_tmp_4 = map_table_19;
      5'b10100:
        casez_tmp_4 = map_table_20;
      5'b10101:
        casez_tmp_4 = map_table_21;
      5'b10110:
        casez_tmp_4 = map_table_22;
      5'b10111:
        casez_tmp_4 = map_table_23;
      5'b11000:
        casez_tmp_4 = map_table_24;
      5'b11001:
        casez_tmp_4 = map_table_25;
      5'b11010:
        casez_tmp_4 = map_table_26;
      5'b11011:
        casez_tmp_4 = map_table_27;
      5'b11100:
        casez_tmp_4 = map_table_28;
      5'b11101:
        casez_tmp_4 = map_table_29;
      5'b11110:
        casez_tmp_4 = map_table_30;
      default:
        casez_tmp_4 = map_table_31;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_map_reqs_2_lrs1[4:0])
      5'b00000:
        casez_tmp_5 = map_table_0;
      5'b00001:
        casez_tmp_5 = map_table_1;
      5'b00010:
        casez_tmp_5 = map_table_2;
      5'b00011:
        casez_tmp_5 = map_table_3;
      5'b00100:
        casez_tmp_5 = map_table_4;
      5'b00101:
        casez_tmp_5 = map_table_5;
      5'b00110:
        casez_tmp_5 = map_table_6;
      5'b00111:
        casez_tmp_5 = map_table_7;
      5'b01000:
        casez_tmp_5 = map_table_8;
      5'b01001:
        casez_tmp_5 = map_table_9;
      5'b01010:
        casez_tmp_5 = map_table_10;
      5'b01011:
        casez_tmp_5 = map_table_11;
      5'b01100:
        casez_tmp_5 = map_table_12;
      5'b01101:
        casez_tmp_5 = map_table_13;
      5'b01110:
        casez_tmp_5 = map_table_14;
      5'b01111:
        casez_tmp_5 = map_table_15;
      5'b10000:
        casez_tmp_5 = map_table_16;
      5'b10001:
        casez_tmp_5 = map_table_17;
      5'b10010:
        casez_tmp_5 = map_table_18;
      5'b10011:
        casez_tmp_5 = map_table_19;
      5'b10100:
        casez_tmp_5 = map_table_20;
      5'b10101:
        casez_tmp_5 = map_table_21;
      5'b10110:
        casez_tmp_5 = map_table_22;
      5'b10111:
        casez_tmp_5 = map_table_23;
      5'b11000:
        casez_tmp_5 = map_table_24;
      5'b11001:
        casez_tmp_5 = map_table_25;
      5'b11010:
        casez_tmp_5 = map_table_26;
      5'b11011:
        casez_tmp_5 = map_table_27;
      5'b11100:
        casez_tmp_5 = map_table_28;
      5'b11101:
        casez_tmp_5 = map_table_29;
      5'b11110:
        casez_tmp_5 = map_table_30;
      default:
        casez_tmp_5 = map_table_31;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_map_reqs_2_lrs2[4:0])
      5'b00000:
        casez_tmp_6 = map_table_0;
      5'b00001:
        casez_tmp_6 = map_table_1;
      5'b00010:
        casez_tmp_6 = map_table_2;
      5'b00011:
        casez_tmp_6 = map_table_3;
      5'b00100:
        casez_tmp_6 = map_table_4;
      5'b00101:
        casez_tmp_6 = map_table_5;
      5'b00110:
        casez_tmp_6 = map_table_6;
      5'b00111:
        casez_tmp_6 = map_table_7;
      5'b01000:
        casez_tmp_6 = map_table_8;
      5'b01001:
        casez_tmp_6 = map_table_9;
      5'b01010:
        casez_tmp_6 = map_table_10;
      5'b01011:
        casez_tmp_6 = map_table_11;
      5'b01100:
        casez_tmp_6 = map_table_12;
      5'b01101:
        casez_tmp_6 = map_table_13;
      5'b01110:
        casez_tmp_6 = map_table_14;
      5'b01111:
        casez_tmp_6 = map_table_15;
      5'b10000:
        casez_tmp_6 = map_table_16;
      5'b10001:
        casez_tmp_6 = map_table_17;
      5'b10010:
        casez_tmp_6 = map_table_18;
      5'b10011:
        casez_tmp_6 = map_table_19;
      5'b10100:
        casez_tmp_6 = map_table_20;
      5'b10101:
        casez_tmp_6 = map_table_21;
      5'b10110:
        casez_tmp_6 = map_table_22;
      5'b10111:
        casez_tmp_6 = map_table_23;
      5'b11000:
        casez_tmp_6 = map_table_24;
      5'b11001:
        casez_tmp_6 = map_table_25;
      5'b11010:
        casez_tmp_6 = map_table_26;
      5'b11011:
        casez_tmp_6 = map_table_27;
      5'b11100:
        casez_tmp_6 = map_table_28;
      5'b11101:
        casez_tmp_6 = map_table_29;
      5'b11110:
        casez_tmp_6 = map_table_30;
      default:
        casez_tmp_6 = map_table_31;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_map_reqs_2_ldst[4:0])
      5'b00000:
        casez_tmp_7 = map_table_0;
      5'b00001:
        casez_tmp_7 = map_table_1;
      5'b00010:
        casez_tmp_7 = map_table_2;
      5'b00011:
        casez_tmp_7 = map_table_3;
      5'b00100:
        casez_tmp_7 = map_table_4;
      5'b00101:
        casez_tmp_7 = map_table_5;
      5'b00110:
        casez_tmp_7 = map_table_6;
      5'b00111:
        casez_tmp_7 = map_table_7;
      5'b01000:
        casez_tmp_7 = map_table_8;
      5'b01001:
        casez_tmp_7 = map_table_9;
      5'b01010:
        casez_tmp_7 = map_table_10;
      5'b01011:
        casez_tmp_7 = map_table_11;
      5'b01100:
        casez_tmp_7 = map_table_12;
      5'b01101:
        casez_tmp_7 = map_table_13;
      5'b01110:
        casez_tmp_7 = map_table_14;
      5'b01111:
        casez_tmp_7 = map_table_15;
      5'b10000:
        casez_tmp_7 = map_table_16;
      5'b10001:
        casez_tmp_7 = map_table_17;
      5'b10010:
        casez_tmp_7 = map_table_18;
      5'b10011:
        casez_tmp_7 = map_table_19;
      5'b10100:
        casez_tmp_7 = map_table_20;
      5'b10101:
        casez_tmp_7 = map_table_21;
      5'b10110:
        casez_tmp_7 = map_table_22;
      5'b10111:
        casez_tmp_7 = map_table_23;
      5'b11000:
        casez_tmp_7 = map_table_24;
      5'b11001:
        casez_tmp_7 = map_table_25;
      5'b11010:
        casez_tmp_7 = map_table_26;
      5'b11011:
        casez_tmp_7 = map_table_27;
      5'b11100:
        casez_tmp_7 = map_table_28;
      5'b11101:
        casez_tmp_7 = map_table_29;
      5'b11110:
        casez_tmp_7 = map_table_30;
      default:
        casez_tmp_7 = map_table_31;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_map_reqs_3_lrs1[4:0])
      5'b00000:
        casez_tmp_8 = map_table_0;
      5'b00001:
        casez_tmp_8 = map_table_1;
      5'b00010:
        casez_tmp_8 = map_table_2;
      5'b00011:
        casez_tmp_8 = map_table_3;
      5'b00100:
        casez_tmp_8 = map_table_4;
      5'b00101:
        casez_tmp_8 = map_table_5;
      5'b00110:
        casez_tmp_8 = map_table_6;
      5'b00111:
        casez_tmp_8 = map_table_7;
      5'b01000:
        casez_tmp_8 = map_table_8;
      5'b01001:
        casez_tmp_8 = map_table_9;
      5'b01010:
        casez_tmp_8 = map_table_10;
      5'b01011:
        casez_tmp_8 = map_table_11;
      5'b01100:
        casez_tmp_8 = map_table_12;
      5'b01101:
        casez_tmp_8 = map_table_13;
      5'b01110:
        casez_tmp_8 = map_table_14;
      5'b01111:
        casez_tmp_8 = map_table_15;
      5'b10000:
        casez_tmp_8 = map_table_16;
      5'b10001:
        casez_tmp_8 = map_table_17;
      5'b10010:
        casez_tmp_8 = map_table_18;
      5'b10011:
        casez_tmp_8 = map_table_19;
      5'b10100:
        casez_tmp_8 = map_table_20;
      5'b10101:
        casez_tmp_8 = map_table_21;
      5'b10110:
        casez_tmp_8 = map_table_22;
      5'b10111:
        casez_tmp_8 = map_table_23;
      5'b11000:
        casez_tmp_8 = map_table_24;
      5'b11001:
        casez_tmp_8 = map_table_25;
      5'b11010:
        casez_tmp_8 = map_table_26;
      5'b11011:
        casez_tmp_8 = map_table_27;
      5'b11100:
        casez_tmp_8 = map_table_28;
      5'b11101:
        casez_tmp_8 = map_table_29;
      5'b11110:
        casez_tmp_8 = map_table_30;
      default:
        casez_tmp_8 = map_table_31;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_map_reqs_3_lrs2[4:0])
      5'b00000:
        casez_tmp_9 = map_table_0;
      5'b00001:
        casez_tmp_9 = map_table_1;
      5'b00010:
        casez_tmp_9 = map_table_2;
      5'b00011:
        casez_tmp_9 = map_table_3;
      5'b00100:
        casez_tmp_9 = map_table_4;
      5'b00101:
        casez_tmp_9 = map_table_5;
      5'b00110:
        casez_tmp_9 = map_table_6;
      5'b00111:
        casez_tmp_9 = map_table_7;
      5'b01000:
        casez_tmp_9 = map_table_8;
      5'b01001:
        casez_tmp_9 = map_table_9;
      5'b01010:
        casez_tmp_9 = map_table_10;
      5'b01011:
        casez_tmp_9 = map_table_11;
      5'b01100:
        casez_tmp_9 = map_table_12;
      5'b01101:
        casez_tmp_9 = map_table_13;
      5'b01110:
        casez_tmp_9 = map_table_14;
      5'b01111:
        casez_tmp_9 = map_table_15;
      5'b10000:
        casez_tmp_9 = map_table_16;
      5'b10001:
        casez_tmp_9 = map_table_17;
      5'b10010:
        casez_tmp_9 = map_table_18;
      5'b10011:
        casez_tmp_9 = map_table_19;
      5'b10100:
        casez_tmp_9 = map_table_20;
      5'b10101:
        casez_tmp_9 = map_table_21;
      5'b10110:
        casez_tmp_9 = map_table_22;
      5'b10111:
        casez_tmp_9 = map_table_23;
      5'b11000:
        casez_tmp_9 = map_table_24;
      5'b11001:
        casez_tmp_9 = map_table_25;
      5'b11010:
        casez_tmp_9 = map_table_26;
      5'b11011:
        casez_tmp_9 = map_table_27;
      5'b11100:
        casez_tmp_9 = map_table_28;
      5'b11101:
        casez_tmp_9 = map_table_29;
      5'b11110:
        casez_tmp_9 = map_table_30;
      default:
        casez_tmp_9 = map_table_31;
    endcase
  end // always @(*)
  always @(*) begin
    casez (io_map_reqs_3_ldst[4:0])
      5'b00000:
        casez_tmp_10 = map_table_0;
      5'b00001:
        casez_tmp_10 = map_table_1;
      5'b00010:
        casez_tmp_10 = map_table_2;
      5'b00011:
        casez_tmp_10 = map_table_3;
      5'b00100:
        casez_tmp_10 = map_table_4;
      5'b00101:
        casez_tmp_10 = map_table_5;
      5'b00110:
        casez_tmp_10 = map_table_6;
      5'b00111:
        casez_tmp_10 = map_table_7;
      5'b01000:
        casez_tmp_10 = map_table_8;
      5'b01001:
        casez_tmp_10 = map_table_9;
      5'b01010:
        casez_tmp_10 = map_table_10;
      5'b01011:
        casez_tmp_10 = map_table_11;
      5'b01100:
        casez_tmp_10 = map_table_12;
      5'b01101:
        casez_tmp_10 = map_table_13;
      5'b01110:
        casez_tmp_10 = map_table_14;
      5'b01111:
        casez_tmp_10 = map_table_15;
      5'b10000:
        casez_tmp_10 = map_table_16;
      5'b10001:
        casez_tmp_10 = map_table_17;
      5'b10010:
        casez_tmp_10 = map_table_18;
      5'b10011:
        casez_tmp_10 = map_table_19;
      5'b10100:
        casez_tmp_10 = map_table_20;
      5'b10101:
        casez_tmp_10 = map_table_21;
      5'b10110:
        casez_tmp_10 = map_table_22;
      5'b10111:
        casez_tmp_10 = map_table_23;
      5'b11000:
        casez_tmp_10 = map_table_24;
      5'b11001:
        casez_tmp_10 = map_table_25;
      5'b11010:
        casez_tmp_10 = map_table_26;
      5'b11011:
        casez_tmp_10 = map_table_27;
      5'b11100:
        casez_tmp_10 = map_table_28;
      5'b11101:
        casez_tmp_10 = map_table_29;
      5'b11110:
        casez_tmp_10 = map_table_30;
      default:
        casez_tmp_10 = map_table_31;
    endcase
  end // always @(*)
  wire [63:0] _remap_ldsts_oh_T = 64'h1 << io_remap_reqs_0_ldst;
  wire [30:0] _GEN = _remap_ldsts_oh_T[31:1] & {31{io_remap_reqs_0_valid}};
  wire [63:0] _remap_ldsts_oh_T_3 = 64'h1 << io_remap_reqs_1_ldst;
  wire [30:0] _GEN_0 = _remap_ldsts_oh_T_3[31:1] & {31{io_remap_reqs_1_valid}};
  wire [63:0] _remap_ldsts_oh_T_6 = 64'h1 << io_remap_reqs_2_ldst;
  wire [30:0] _GEN_1 = _remap_ldsts_oh_T_6[31:1] & {31{io_remap_reqs_2_valid}};
  wire [63:0] _remap_ldsts_oh_T_9 = 64'h1 << io_remap_reqs_3_ldst;
  wire [30:0] _GEN_2 = _remap_ldsts_oh_T_9[31:1] & {31{io_remap_reqs_3_valid}};
  wire        _GEN_3 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'h0;
  wire        _GEN_4 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'h1;
  wire        _GEN_5 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'h2;
  wire        _GEN_6 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'h3;
  wire        _GEN_7 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'h4;
  wire        _GEN_8 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'h5;
  wire        _GEN_9 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'h6;
  wire        _GEN_10 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'h7;
  wire        _GEN_11 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'h8;
  wire        _GEN_12 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'h9;
  wire        _GEN_13 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'hA;
  wire        _GEN_14 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'hB;
  wire        _GEN_15 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'hC;
  wire        _GEN_16 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'hD;
  wire        _GEN_17 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'hE;
  wire        _GEN_18 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'hF;
  wire        _GEN_19 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'h10;
  wire        _GEN_20 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'h11;
  wire        _GEN_21 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'h12;
  wire        _GEN_22 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 5'h13;
  wire        _GEN_23 = io_ren_br_tags_1_bits == 5'h0;
  wire        _GEN_24 = io_ren_br_tags_1_bits == 5'h1;
  wire        _GEN_25 = io_ren_br_tags_1_bits == 5'h2;
  wire        _GEN_26 = io_ren_br_tags_1_bits == 5'h3;
  wire        _GEN_27 = io_ren_br_tags_1_bits == 5'h4;
  wire        _GEN_28 = io_ren_br_tags_1_bits == 5'h5;
  wire        _GEN_29 = io_ren_br_tags_1_bits == 5'h6;
  wire        _GEN_30 = io_ren_br_tags_1_bits == 5'h7;
  wire        _GEN_31 = io_ren_br_tags_1_bits == 5'h8;
  wire        _GEN_32 = io_ren_br_tags_1_bits == 5'h9;
  wire        _GEN_33 = io_ren_br_tags_1_bits == 5'hA;
  wire        _GEN_34 = io_ren_br_tags_1_bits == 5'hB;
  wire        _GEN_35 = io_ren_br_tags_1_bits == 5'hC;
  wire        _GEN_36 = io_ren_br_tags_1_bits == 5'hD;
  wire        _GEN_37 = io_ren_br_tags_1_bits == 5'hE;
  wire        _GEN_38 = io_ren_br_tags_1_bits == 5'hF;
  wire        _GEN_39 = io_ren_br_tags_1_bits == 5'h10;
  wire        _GEN_40 = io_ren_br_tags_1_bits == 5'h11;
  wire        _GEN_41 = io_ren_br_tags_1_bits == 5'h12;
  wire        _GEN_42 = io_ren_br_tags_1_bits == 5'h13;
  wire        _GEN_43 = io_ren_br_tags_1_valid & _GEN_23 | _GEN_3;
  wire        _GEN_44 = io_ren_br_tags_1_valid & _GEN_24 | _GEN_4;
  wire        _GEN_45 = io_ren_br_tags_1_valid & _GEN_25 | _GEN_5;
  wire        _GEN_46 = io_ren_br_tags_1_valid & _GEN_26 | _GEN_6;
  wire        _GEN_47 = io_ren_br_tags_1_valid & _GEN_27 | _GEN_7;
  wire        _GEN_48 = io_ren_br_tags_1_valid & _GEN_28 | _GEN_8;
  wire        _GEN_49 = io_ren_br_tags_1_valid & _GEN_29 | _GEN_9;
  wire        _GEN_50 = io_ren_br_tags_1_valid & _GEN_30 | _GEN_10;
  wire        _GEN_51 = io_ren_br_tags_1_valid & _GEN_31 | _GEN_11;
  wire        _GEN_52 = io_ren_br_tags_1_valid & _GEN_32 | _GEN_12;
  wire        _GEN_53 = io_ren_br_tags_1_valid & _GEN_33 | _GEN_13;
  wire        _GEN_54 = io_ren_br_tags_1_valid & _GEN_34 | _GEN_14;
  wire        _GEN_55 = io_ren_br_tags_1_valid & _GEN_35 | _GEN_15;
  wire        _GEN_56 = io_ren_br_tags_1_valid & _GEN_36 | _GEN_16;
  wire        _GEN_57 = io_ren_br_tags_1_valid & _GEN_37 | _GEN_17;
  wire        _GEN_58 = io_ren_br_tags_1_valid & _GEN_38 | _GEN_18;
  wire        _GEN_59 = io_ren_br_tags_1_valid & _GEN_39 | _GEN_19;
  wire        _GEN_60 = io_ren_br_tags_1_valid & _GEN_40 | _GEN_20;
  wire        _GEN_61 = io_ren_br_tags_1_valid & _GEN_41 | _GEN_21;
  wire        _GEN_62 = io_ren_br_tags_1_valid & _GEN_42 | _GEN_22;
  wire        _GEN_63 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'h0;
  wire        _GEN_64 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'h1;
  wire        _GEN_65 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'h2;
  wire        _GEN_66 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'h3;
  wire        _GEN_67 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'h4;
  wire        _GEN_68 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'h5;
  wire        _GEN_69 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'h6;
  wire        _GEN_70 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'h7;
  wire        _GEN_71 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'h8;
  wire        _GEN_72 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'h9;
  wire        _GEN_73 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'hA;
  wire        _GEN_74 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'hB;
  wire        _GEN_75 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'hC;
  wire        _GEN_76 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'hD;
  wire        _GEN_77 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'hE;
  wire        _GEN_78 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'hF;
  wire        _GEN_79 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'h10;
  wire        _GEN_80 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'h11;
  wire        _GEN_81 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'h12;
  wire        _GEN_82 = io_ren_br_tags_2_valid & io_ren_br_tags_2_bits == 5'h13;
  wire        _GEN_83 = io_ren_br_tags_3_bits == 5'h0;
  wire        _GEN_84 = io_ren_br_tags_3_bits == 5'h1;
  wire        _GEN_85 = io_ren_br_tags_3_bits == 5'h2;
  wire        _GEN_86 = io_ren_br_tags_3_bits == 5'h3;
  wire        _GEN_87 = io_ren_br_tags_3_bits == 5'h4;
  wire        _GEN_88 = io_ren_br_tags_3_bits == 5'h5;
  wire        _GEN_89 = io_ren_br_tags_3_bits == 5'h6;
  wire        _GEN_90 = io_ren_br_tags_3_bits == 5'h7;
  wire        _GEN_91 = io_ren_br_tags_3_bits == 5'h8;
  wire        _GEN_92 = io_ren_br_tags_3_bits == 5'h9;
  wire        _GEN_93 = io_ren_br_tags_3_bits == 5'hA;
  wire        _GEN_94 = io_ren_br_tags_3_bits == 5'hB;
  wire        _GEN_95 = io_ren_br_tags_3_bits == 5'hC;
  wire        _GEN_96 = io_ren_br_tags_3_bits == 5'hD;
  wire        _GEN_97 = io_ren_br_tags_3_bits == 5'hE;
  wire        _GEN_98 = io_ren_br_tags_3_bits == 5'hF;
  wire        _GEN_99 = io_ren_br_tags_3_bits == 5'h10;
  wire        _GEN_100 = io_ren_br_tags_3_bits == 5'h11;
  wire        _GEN_101 = io_ren_br_tags_3_bits == 5'h12;
  wire        _GEN_102 = io_ren_br_tags_3_bits == 5'h13;
  always @(posedge clock) begin
    if (reset) begin
      map_table_0 <= 7'h0;
      map_table_1 <= 7'h0;
      map_table_2 <= 7'h0;
      map_table_3 <= 7'h0;
      map_table_4 <= 7'h0;
      map_table_5 <= 7'h0;
      map_table_6 <= 7'h0;
      map_table_7 <= 7'h0;
      map_table_8 <= 7'h0;
      map_table_9 <= 7'h0;
      map_table_10 <= 7'h0;
      map_table_11 <= 7'h0;
      map_table_12 <= 7'h0;
      map_table_13 <= 7'h0;
      map_table_14 <= 7'h0;
      map_table_15 <= 7'h0;
      map_table_16 <= 7'h0;
      map_table_17 <= 7'h0;
      map_table_18 <= 7'h0;
      map_table_19 <= 7'h0;
      map_table_20 <= 7'h0;
      map_table_21 <= 7'h0;
      map_table_22 <= 7'h0;
      map_table_23 <= 7'h0;
      map_table_24 <= 7'h0;
      map_table_25 <= 7'h0;
      map_table_26 <= 7'h0;
      map_table_27 <= 7'h0;
      map_table_28 <= 7'h0;
      map_table_29 <= 7'h0;
      map_table_30 <= 7'h0;
      map_table_31 <= 7'h0;
    end
    else if (io_brupdate_b2_mispredict) begin
      if (io_brupdate_b2_uop_br_tag == 5'h13) begin
        map_table_0 <= br_snapshots_19_0;
        map_table_1 <= br_snapshots_19_1;
        map_table_2 <= br_snapshots_19_2;
        map_table_3 <= br_snapshots_19_3;
        map_table_4 <= br_snapshots_19_4;
        map_table_5 <= br_snapshots_19_5;
        map_table_6 <= br_snapshots_19_6;
        map_table_7 <= br_snapshots_19_7;
        map_table_8 <= br_snapshots_19_8;
        map_table_9 <= br_snapshots_19_9;
        map_table_10 <= br_snapshots_19_10;
        map_table_11 <= br_snapshots_19_11;
        map_table_12 <= br_snapshots_19_12;
        map_table_13 <= br_snapshots_19_13;
        map_table_14 <= br_snapshots_19_14;
        map_table_15 <= br_snapshots_19_15;
        map_table_16 <= br_snapshots_19_16;
        map_table_17 <= br_snapshots_19_17;
        map_table_18 <= br_snapshots_19_18;
        map_table_19 <= br_snapshots_19_19;
        map_table_20 <= br_snapshots_19_20;
        map_table_21 <= br_snapshots_19_21;
        map_table_22 <= br_snapshots_19_22;
        map_table_23 <= br_snapshots_19_23;
        map_table_24 <= br_snapshots_19_24;
        map_table_25 <= br_snapshots_19_25;
        map_table_26 <= br_snapshots_19_26;
        map_table_27 <= br_snapshots_19_27;
        map_table_28 <= br_snapshots_19_28;
        map_table_29 <= br_snapshots_19_29;
        map_table_30 <= br_snapshots_19_30;
        map_table_31 <= br_snapshots_19_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'h12) begin
        map_table_0 <= br_snapshots_18_0;
        map_table_1 <= br_snapshots_18_1;
        map_table_2 <= br_snapshots_18_2;
        map_table_3 <= br_snapshots_18_3;
        map_table_4 <= br_snapshots_18_4;
        map_table_5 <= br_snapshots_18_5;
        map_table_6 <= br_snapshots_18_6;
        map_table_7 <= br_snapshots_18_7;
        map_table_8 <= br_snapshots_18_8;
        map_table_9 <= br_snapshots_18_9;
        map_table_10 <= br_snapshots_18_10;
        map_table_11 <= br_snapshots_18_11;
        map_table_12 <= br_snapshots_18_12;
        map_table_13 <= br_snapshots_18_13;
        map_table_14 <= br_snapshots_18_14;
        map_table_15 <= br_snapshots_18_15;
        map_table_16 <= br_snapshots_18_16;
        map_table_17 <= br_snapshots_18_17;
        map_table_18 <= br_snapshots_18_18;
        map_table_19 <= br_snapshots_18_19;
        map_table_20 <= br_snapshots_18_20;
        map_table_21 <= br_snapshots_18_21;
        map_table_22 <= br_snapshots_18_22;
        map_table_23 <= br_snapshots_18_23;
        map_table_24 <= br_snapshots_18_24;
        map_table_25 <= br_snapshots_18_25;
        map_table_26 <= br_snapshots_18_26;
        map_table_27 <= br_snapshots_18_27;
        map_table_28 <= br_snapshots_18_28;
        map_table_29 <= br_snapshots_18_29;
        map_table_30 <= br_snapshots_18_30;
        map_table_31 <= br_snapshots_18_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'h11) begin
        map_table_0 <= br_snapshots_17_0;
        map_table_1 <= br_snapshots_17_1;
        map_table_2 <= br_snapshots_17_2;
        map_table_3 <= br_snapshots_17_3;
        map_table_4 <= br_snapshots_17_4;
        map_table_5 <= br_snapshots_17_5;
        map_table_6 <= br_snapshots_17_6;
        map_table_7 <= br_snapshots_17_7;
        map_table_8 <= br_snapshots_17_8;
        map_table_9 <= br_snapshots_17_9;
        map_table_10 <= br_snapshots_17_10;
        map_table_11 <= br_snapshots_17_11;
        map_table_12 <= br_snapshots_17_12;
        map_table_13 <= br_snapshots_17_13;
        map_table_14 <= br_snapshots_17_14;
        map_table_15 <= br_snapshots_17_15;
        map_table_16 <= br_snapshots_17_16;
        map_table_17 <= br_snapshots_17_17;
        map_table_18 <= br_snapshots_17_18;
        map_table_19 <= br_snapshots_17_19;
        map_table_20 <= br_snapshots_17_20;
        map_table_21 <= br_snapshots_17_21;
        map_table_22 <= br_snapshots_17_22;
        map_table_23 <= br_snapshots_17_23;
        map_table_24 <= br_snapshots_17_24;
        map_table_25 <= br_snapshots_17_25;
        map_table_26 <= br_snapshots_17_26;
        map_table_27 <= br_snapshots_17_27;
        map_table_28 <= br_snapshots_17_28;
        map_table_29 <= br_snapshots_17_29;
        map_table_30 <= br_snapshots_17_30;
        map_table_31 <= br_snapshots_17_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'h10) begin
        map_table_0 <= br_snapshots_16_0;
        map_table_1 <= br_snapshots_16_1;
        map_table_2 <= br_snapshots_16_2;
        map_table_3 <= br_snapshots_16_3;
        map_table_4 <= br_snapshots_16_4;
        map_table_5 <= br_snapshots_16_5;
        map_table_6 <= br_snapshots_16_6;
        map_table_7 <= br_snapshots_16_7;
        map_table_8 <= br_snapshots_16_8;
        map_table_9 <= br_snapshots_16_9;
        map_table_10 <= br_snapshots_16_10;
        map_table_11 <= br_snapshots_16_11;
        map_table_12 <= br_snapshots_16_12;
        map_table_13 <= br_snapshots_16_13;
        map_table_14 <= br_snapshots_16_14;
        map_table_15 <= br_snapshots_16_15;
        map_table_16 <= br_snapshots_16_16;
        map_table_17 <= br_snapshots_16_17;
        map_table_18 <= br_snapshots_16_18;
        map_table_19 <= br_snapshots_16_19;
        map_table_20 <= br_snapshots_16_20;
        map_table_21 <= br_snapshots_16_21;
        map_table_22 <= br_snapshots_16_22;
        map_table_23 <= br_snapshots_16_23;
        map_table_24 <= br_snapshots_16_24;
        map_table_25 <= br_snapshots_16_25;
        map_table_26 <= br_snapshots_16_26;
        map_table_27 <= br_snapshots_16_27;
        map_table_28 <= br_snapshots_16_28;
        map_table_29 <= br_snapshots_16_29;
        map_table_30 <= br_snapshots_16_30;
        map_table_31 <= br_snapshots_16_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'hF) begin
        map_table_0 <= br_snapshots_15_0;
        map_table_1 <= br_snapshots_15_1;
        map_table_2 <= br_snapshots_15_2;
        map_table_3 <= br_snapshots_15_3;
        map_table_4 <= br_snapshots_15_4;
        map_table_5 <= br_snapshots_15_5;
        map_table_6 <= br_snapshots_15_6;
        map_table_7 <= br_snapshots_15_7;
        map_table_8 <= br_snapshots_15_8;
        map_table_9 <= br_snapshots_15_9;
        map_table_10 <= br_snapshots_15_10;
        map_table_11 <= br_snapshots_15_11;
        map_table_12 <= br_snapshots_15_12;
        map_table_13 <= br_snapshots_15_13;
        map_table_14 <= br_snapshots_15_14;
        map_table_15 <= br_snapshots_15_15;
        map_table_16 <= br_snapshots_15_16;
        map_table_17 <= br_snapshots_15_17;
        map_table_18 <= br_snapshots_15_18;
        map_table_19 <= br_snapshots_15_19;
        map_table_20 <= br_snapshots_15_20;
        map_table_21 <= br_snapshots_15_21;
        map_table_22 <= br_snapshots_15_22;
        map_table_23 <= br_snapshots_15_23;
        map_table_24 <= br_snapshots_15_24;
        map_table_25 <= br_snapshots_15_25;
        map_table_26 <= br_snapshots_15_26;
        map_table_27 <= br_snapshots_15_27;
        map_table_28 <= br_snapshots_15_28;
        map_table_29 <= br_snapshots_15_29;
        map_table_30 <= br_snapshots_15_30;
        map_table_31 <= br_snapshots_15_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'hE) begin
        map_table_0 <= br_snapshots_14_0;
        map_table_1 <= br_snapshots_14_1;
        map_table_2 <= br_snapshots_14_2;
        map_table_3 <= br_snapshots_14_3;
        map_table_4 <= br_snapshots_14_4;
        map_table_5 <= br_snapshots_14_5;
        map_table_6 <= br_snapshots_14_6;
        map_table_7 <= br_snapshots_14_7;
        map_table_8 <= br_snapshots_14_8;
        map_table_9 <= br_snapshots_14_9;
        map_table_10 <= br_snapshots_14_10;
        map_table_11 <= br_snapshots_14_11;
        map_table_12 <= br_snapshots_14_12;
        map_table_13 <= br_snapshots_14_13;
        map_table_14 <= br_snapshots_14_14;
        map_table_15 <= br_snapshots_14_15;
        map_table_16 <= br_snapshots_14_16;
        map_table_17 <= br_snapshots_14_17;
        map_table_18 <= br_snapshots_14_18;
        map_table_19 <= br_snapshots_14_19;
        map_table_20 <= br_snapshots_14_20;
        map_table_21 <= br_snapshots_14_21;
        map_table_22 <= br_snapshots_14_22;
        map_table_23 <= br_snapshots_14_23;
        map_table_24 <= br_snapshots_14_24;
        map_table_25 <= br_snapshots_14_25;
        map_table_26 <= br_snapshots_14_26;
        map_table_27 <= br_snapshots_14_27;
        map_table_28 <= br_snapshots_14_28;
        map_table_29 <= br_snapshots_14_29;
        map_table_30 <= br_snapshots_14_30;
        map_table_31 <= br_snapshots_14_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'hD) begin
        map_table_0 <= br_snapshots_13_0;
        map_table_1 <= br_snapshots_13_1;
        map_table_2 <= br_snapshots_13_2;
        map_table_3 <= br_snapshots_13_3;
        map_table_4 <= br_snapshots_13_4;
        map_table_5 <= br_snapshots_13_5;
        map_table_6 <= br_snapshots_13_6;
        map_table_7 <= br_snapshots_13_7;
        map_table_8 <= br_snapshots_13_8;
        map_table_9 <= br_snapshots_13_9;
        map_table_10 <= br_snapshots_13_10;
        map_table_11 <= br_snapshots_13_11;
        map_table_12 <= br_snapshots_13_12;
        map_table_13 <= br_snapshots_13_13;
        map_table_14 <= br_snapshots_13_14;
        map_table_15 <= br_snapshots_13_15;
        map_table_16 <= br_snapshots_13_16;
        map_table_17 <= br_snapshots_13_17;
        map_table_18 <= br_snapshots_13_18;
        map_table_19 <= br_snapshots_13_19;
        map_table_20 <= br_snapshots_13_20;
        map_table_21 <= br_snapshots_13_21;
        map_table_22 <= br_snapshots_13_22;
        map_table_23 <= br_snapshots_13_23;
        map_table_24 <= br_snapshots_13_24;
        map_table_25 <= br_snapshots_13_25;
        map_table_26 <= br_snapshots_13_26;
        map_table_27 <= br_snapshots_13_27;
        map_table_28 <= br_snapshots_13_28;
        map_table_29 <= br_snapshots_13_29;
        map_table_30 <= br_snapshots_13_30;
        map_table_31 <= br_snapshots_13_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'hC) begin
        map_table_0 <= br_snapshots_12_0;
        map_table_1 <= br_snapshots_12_1;
        map_table_2 <= br_snapshots_12_2;
        map_table_3 <= br_snapshots_12_3;
        map_table_4 <= br_snapshots_12_4;
        map_table_5 <= br_snapshots_12_5;
        map_table_6 <= br_snapshots_12_6;
        map_table_7 <= br_snapshots_12_7;
        map_table_8 <= br_snapshots_12_8;
        map_table_9 <= br_snapshots_12_9;
        map_table_10 <= br_snapshots_12_10;
        map_table_11 <= br_snapshots_12_11;
        map_table_12 <= br_snapshots_12_12;
        map_table_13 <= br_snapshots_12_13;
        map_table_14 <= br_snapshots_12_14;
        map_table_15 <= br_snapshots_12_15;
        map_table_16 <= br_snapshots_12_16;
        map_table_17 <= br_snapshots_12_17;
        map_table_18 <= br_snapshots_12_18;
        map_table_19 <= br_snapshots_12_19;
        map_table_20 <= br_snapshots_12_20;
        map_table_21 <= br_snapshots_12_21;
        map_table_22 <= br_snapshots_12_22;
        map_table_23 <= br_snapshots_12_23;
        map_table_24 <= br_snapshots_12_24;
        map_table_25 <= br_snapshots_12_25;
        map_table_26 <= br_snapshots_12_26;
        map_table_27 <= br_snapshots_12_27;
        map_table_28 <= br_snapshots_12_28;
        map_table_29 <= br_snapshots_12_29;
        map_table_30 <= br_snapshots_12_30;
        map_table_31 <= br_snapshots_12_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'hB) begin
        map_table_0 <= br_snapshots_11_0;
        map_table_1 <= br_snapshots_11_1;
        map_table_2 <= br_snapshots_11_2;
        map_table_3 <= br_snapshots_11_3;
        map_table_4 <= br_snapshots_11_4;
        map_table_5 <= br_snapshots_11_5;
        map_table_6 <= br_snapshots_11_6;
        map_table_7 <= br_snapshots_11_7;
        map_table_8 <= br_snapshots_11_8;
        map_table_9 <= br_snapshots_11_9;
        map_table_10 <= br_snapshots_11_10;
        map_table_11 <= br_snapshots_11_11;
        map_table_12 <= br_snapshots_11_12;
        map_table_13 <= br_snapshots_11_13;
        map_table_14 <= br_snapshots_11_14;
        map_table_15 <= br_snapshots_11_15;
        map_table_16 <= br_snapshots_11_16;
        map_table_17 <= br_snapshots_11_17;
        map_table_18 <= br_snapshots_11_18;
        map_table_19 <= br_snapshots_11_19;
        map_table_20 <= br_snapshots_11_20;
        map_table_21 <= br_snapshots_11_21;
        map_table_22 <= br_snapshots_11_22;
        map_table_23 <= br_snapshots_11_23;
        map_table_24 <= br_snapshots_11_24;
        map_table_25 <= br_snapshots_11_25;
        map_table_26 <= br_snapshots_11_26;
        map_table_27 <= br_snapshots_11_27;
        map_table_28 <= br_snapshots_11_28;
        map_table_29 <= br_snapshots_11_29;
        map_table_30 <= br_snapshots_11_30;
        map_table_31 <= br_snapshots_11_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'hA) begin
        map_table_0 <= br_snapshots_10_0;
        map_table_1 <= br_snapshots_10_1;
        map_table_2 <= br_snapshots_10_2;
        map_table_3 <= br_snapshots_10_3;
        map_table_4 <= br_snapshots_10_4;
        map_table_5 <= br_snapshots_10_5;
        map_table_6 <= br_snapshots_10_6;
        map_table_7 <= br_snapshots_10_7;
        map_table_8 <= br_snapshots_10_8;
        map_table_9 <= br_snapshots_10_9;
        map_table_10 <= br_snapshots_10_10;
        map_table_11 <= br_snapshots_10_11;
        map_table_12 <= br_snapshots_10_12;
        map_table_13 <= br_snapshots_10_13;
        map_table_14 <= br_snapshots_10_14;
        map_table_15 <= br_snapshots_10_15;
        map_table_16 <= br_snapshots_10_16;
        map_table_17 <= br_snapshots_10_17;
        map_table_18 <= br_snapshots_10_18;
        map_table_19 <= br_snapshots_10_19;
        map_table_20 <= br_snapshots_10_20;
        map_table_21 <= br_snapshots_10_21;
        map_table_22 <= br_snapshots_10_22;
        map_table_23 <= br_snapshots_10_23;
        map_table_24 <= br_snapshots_10_24;
        map_table_25 <= br_snapshots_10_25;
        map_table_26 <= br_snapshots_10_26;
        map_table_27 <= br_snapshots_10_27;
        map_table_28 <= br_snapshots_10_28;
        map_table_29 <= br_snapshots_10_29;
        map_table_30 <= br_snapshots_10_30;
        map_table_31 <= br_snapshots_10_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'h9) begin
        map_table_0 <= br_snapshots_9_0;
        map_table_1 <= br_snapshots_9_1;
        map_table_2 <= br_snapshots_9_2;
        map_table_3 <= br_snapshots_9_3;
        map_table_4 <= br_snapshots_9_4;
        map_table_5 <= br_snapshots_9_5;
        map_table_6 <= br_snapshots_9_6;
        map_table_7 <= br_snapshots_9_7;
        map_table_8 <= br_snapshots_9_8;
        map_table_9 <= br_snapshots_9_9;
        map_table_10 <= br_snapshots_9_10;
        map_table_11 <= br_snapshots_9_11;
        map_table_12 <= br_snapshots_9_12;
        map_table_13 <= br_snapshots_9_13;
        map_table_14 <= br_snapshots_9_14;
        map_table_15 <= br_snapshots_9_15;
        map_table_16 <= br_snapshots_9_16;
        map_table_17 <= br_snapshots_9_17;
        map_table_18 <= br_snapshots_9_18;
        map_table_19 <= br_snapshots_9_19;
        map_table_20 <= br_snapshots_9_20;
        map_table_21 <= br_snapshots_9_21;
        map_table_22 <= br_snapshots_9_22;
        map_table_23 <= br_snapshots_9_23;
        map_table_24 <= br_snapshots_9_24;
        map_table_25 <= br_snapshots_9_25;
        map_table_26 <= br_snapshots_9_26;
        map_table_27 <= br_snapshots_9_27;
        map_table_28 <= br_snapshots_9_28;
        map_table_29 <= br_snapshots_9_29;
        map_table_30 <= br_snapshots_9_30;
        map_table_31 <= br_snapshots_9_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'h8) begin
        map_table_0 <= br_snapshots_8_0;
        map_table_1 <= br_snapshots_8_1;
        map_table_2 <= br_snapshots_8_2;
        map_table_3 <= br_snapshots_8_3;
        map_table_4 <= br_snapshots_8_4;
        map_table_5 <= br_snapshots_8_5;
        map_table_6 <= br_snapshots_8_6;
        map_table_7 <= br_snapshots_8_7;
        map_table_8 <= br_snapshots_8_8;
        map_table_9 <= br_snapshots_8_9;
        map_table_10 <= br_snapshots_8_10;
        map_table_11 <= br_snapshots_8_11;
        map_table_12 <= br_snapshots_8_12;
        map_table_13 <= br_snapshots_8_13;
        map_table_14 <= br_snapshots_8_14;
        map_table_15 <= br_snapshots_8_15;
        map_table_16 <= br_snapshots_8_16;
        map_table_17 <= br_snapshots_8_17;
        map_table_18 <= br_snapshots_8_18;
        map_table_19 <= br_snapshots_8_19;
        map_table_20 <= br_snapshots_8_20;
        map_table_21 <= br_snapshots_8_21;
        map_table_22 <= br_snapshots_8_22;
        map_table_23 <= br_snapshots_8_23;
        map_table_24 <= br_snapshots_8_24;
        map_table_25 <= br_snapshots_8_25;
        map_table_26 <= br_snapshots_8_26;
        map_table_27 <= br_snapshots_8_27;
        map_table_28 <= br_snapshots_8_28;
        map_table_29 <= br_snapshots_8_29;
        map_table_30 <= br_snapshots_8_30;
        map_table_31 <= br_snapshots_8_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'h7) begin
        map_table_0 <= br_snapshots_7_0;
        map_table_1 <= br_snapshots_7_1;
        map_table_2 <= br_snapshots_7_2;
        map_table_3 <= br_snapshots_7_3;
        map_table_4 <= br_snapshots_7_4;
        map_table_5 <= br_snapshots_7_5;
        map_table_6 <= br_snapshots_7_6;
        map_table_7 <= br_snapshots_7_7;
        map_table_8 <= br_snapshots_7_8;
        map_table_9 <= br_snapshots_7_9;
        map_table_10 <= br_snapshots_7_10;
        map_table_11 <= br_snapshots_7_11;
        map_table_12 <= br_snapshots_7_12;
        map_table_13 <= br_snapshots_7_13;
        map_table_14 <= br_snapshots_7_14;
        map_table_15 <= br_snapshots_7_15;
        map_table_16 <= br_snapshots_7_16;
        map_table_17 <= br_snapshots_7_17;
        map_table_18 <= br_snapshots_7_18;
        map_table_19 <= br_snapshots_7_19;
        map_table_20 <= br_snapshots_7_20;
        map_table_21 <= br_snapshots_7_21;
        map_table_22 <= br_snapshots_7_22;
        map_table_23 <= br_snapshots_7_23;
        map_table_24 <= br_snapshots_7_24;
        map_table_25 <= br_snapshots_7_25;
        map_table_26 <= br_snapshots_7_26;
        map_table_27 <= br_snapshots_7_27;
        map_table_28 <= br_snapshots_7_28;
        map_table_29 <= br_snapshots_7_29;
        map_table_30 <= br_snapshots_7_30;
        map_table_31 <= br_snapshots_7_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'h6) begin
        map_table_0 <= br_snapshots_6_0;
        map_table_1 <= br_snapshots_6_1;
        map_table_2 <= br_snapshots_6_2;
        map_table_3 <= br_snapshots_6_3;
        map_table_4 <= br_snapshots_6_4;
        map_table_5 <= br_snapshots_6_5;
        map_table_6 <= br_snapshots_6_6;
        map_table_7 <= br_snapshots_6_7;
        map_table_8 <= br_snapshots_6_8;
        map_table_9 <= br_snapshots_6_9;
        map_table_10 <= br_snapshots_6_10;
        map_table_11 <= br_snapshots_6_11;
        map_table_12 <= br_snapshots_6_12;
        map_table_13 <= br_snapshots_6_13;
        map_table_14 <= br_snapshots_6_14;
        map_table_15 <= br_snapshots_6_15;
        map_table_16 <= br_snapshots_6_16;
        map_table_17 <= br_snapshots_6_17;
        map_table_18 <= br_snapshots_6_18;
        map_table_19 <= br_snapshots_6_19;
        map_table_20 <= br_snapshots_6_20;
        map_table_21 <= br_snapshots_6_21;
        map_table_22 <= br_snapshots_6_22;
        map_table_23 <= br_snapshots_6_23;
        map_table_24 <= br_snapshots_6_24;
        map_table_25 <= br_snapshots_6_25;
        map_table_26 <= br_snapshots_6_26;
        map_table_27 <= br_snapshots_6_27;
        map_table_28 <= br_snapshots_6_28;
        map_table_29 <= br_snapshots_6_29;
        map_table_30 <= br_snapshots_6_30;
        map_table_31 <= br_snapshots_6_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'h5) begin
        map_table_0 <= br_snapshots_5_0;
        map_table_1 <= br_snapshots_5_1;
        map_table_2 <= br_snapshots_5_2;
        map_table_3 <= br_snapshots_5_3;
        map_table_4 <= br_snapshots_5_4;
        map_table_5 <= br_snapshots_5_5;
        map_table_6 <= br_snapshots_5_6;
        map_table_7 <= br_snapshots_5_7;
        map_table_8 <= br_snapshots_5_8;
        map_table_9 <= br_snapshots_5_9;
        map_table_10 <= br_snapshots_5_10;
        map_table_11 <= br_snapshots_5_11;
        map_table_12 <= br_snapshots_5_12;
        map_table_13 <= br_snapshots_5_13;
        map_table_14 <= br_snapshots_5_14;
        map_table_15 <= br_snapshots_5_15;
        map_table_16 <= br_snapshots_5_16;
        map_table_17 <= br_snapshots_5_17;
        map_table_18 <= br_snapshots_5_18;
        map_table_19 <= br_snapshots_5_19;
        map_table_20 <= br_snapshots_5_20;
        map_table_21 <= br_snapshots_5_21;
        map_table_22 <= br_snapshots_5_22;
        map_table_23 <= br_snapshots_5_23;
        map_table_24 <= br_snapshots_5_24;
        map_table_25 <= br_snapshots_5_25;
        map_table_26 <= br_snapshots_5_26;
        map_table_27 <= br_snapshots_5_27;
        map_table_28 <= br_snapshots_5_28;
        map_table_29 <= br_snapshots_5_29;
        map_table_30 <= br_snapshots_5_30;
        map_table_31 <= br_snapshots_5_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'h4) begin
        map_table_0 <= br_snapshots_4_0;
        map_table_1 <= br_snapshots_4_1;
        map_table_2 <= br_snapshots_4_2;
        map_table_3 <= br_snapshots_4_3;
        map_table_4 <= br_snapshots_4_4;
        map_table_5 <= br_snapshots_4_5;
        map_table_6 <= br_snapshots_4_6;
        map_table_7 <= br_snapshots_4_7;
        map_table_8 <= br_snapshots_4_8;
        map_table_9 <= br_snapshots_4_9;
        map_table_10 <= br_snapshots_4_10;
        map_table_11 <= br_snapshots_4_11;
        map_table_12 <= br_snapshots_4_12;
        map_table_13 <= br_snapshots_4_13;
        map_table_14 <= br_snapshots_4_14;
        map_table_15 <= br_snapshots_4_15;
        map_table_16 <= br_snapshots_4_16;
        map_table_17 <= br_snapshots_4_17;
        map_table_18 <= br_snapshots_4_18;
        map_table_19 <= br_snapshots_4_19;
        map_table_20 <= br_snapshots_4_20;
        map_table_21 <= br_snapshots_4_21;
        map_table_22 <= br_snapshots_4_22;
        map_table_23 <= br_snapshots_4_23;
        map_table_24 <= br_snapshots_4_24;
        map_table_25 <= br_snapshots_4_25;
        map_table_26 <= br_snapshots_4_26;
        map_table_27 <= br_snapshots_4_27;
        map_table_28 <= br_snapshots_4_28;
        map_table_29 <= br_snapshots_4_29;
        map_table_30 <= br_snapshots_4_30;
        map_table_31 <= br_snapshots_4_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'h3) begin
        map_table_0 <= br_snapshots_3_0;
        map_table_1 <= br_snapshots_3_1;
        map_table_2 <= br_snapshots_3_2;
        map_table_3 <= br_snapshots_3_3;
        map_table_4 <= br_snapshots_3_4;
        map_table_5 <= br_snapshots_3_5;
        map_table_6 <= br_snapshots_3_6;
        map_table_7 <= br_snapshots_3_7;
        map_table_8 <= br_snapshots_3_8;
        map_table_9 <= br_snapshots_3_9;
        map_table_10 <= br_snapshots_3_10;
        map_table_11 <= br_snapshots_3_11;
        map_table_12 <= br_snapshots_3_12;
        map_table_13 <= br_snapshots_3_13;
        map_table_14 <= br_snapshots_3_14;
        map_table_15 <= br_snapshots_3_15;
        map_table_16 <= br_snapshots_3_16;
        map_table_17 <= br_snapshots_3_17;
        map_table_18 <= br_snapshots_3_18;
        map_table_19 <= br_snapshots_3_19;
        map_table_20 <= br_snapshots_3_20;
        map_table_21 <= br_snapshots_3_21;
        map_table_22 <= br_snapshots_3_22;
        map_table_23 <= br_snapshots_3_23;
        map_table_24 <= br_snapshots_3_24;
        map_table_25 <= br_snapshots_3_25;
        map_table_26 <= br_snapshots_3_26;
        map_table_27 <= br_snapshots_3_27;
        map_table_28 <= br_snapshots_3_28;
        map_table_29 <= br_snapshots_3_29;
        map_table_30 <= br_snapshots_3_30;
        map_table_31 <= br_snapshots_3_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'h2) begin
        map_table_0 <= br_snapshots_2_0;
        map_table_1 <= br_snapshots_2_1;
        map_table_2 <= br_snapshots_2_2;
        map_table_3 <= br_snapshots_2_3;
        map_table_4 <= br_snapshots_2_4;
        map_table_5 <= br_snapshots_2_5;
        map_table_6 <= br_snapshots_2_6;
        map_table_7 <= br_snapshots_2_7;
        map_table_8 <= br_snapshots_2_8;
        map_table_9 <= br_snapshots_2_9;
        map_table_10 <= br_snapshots_2_10;
        map_table_11 <= br_snapshots_2_11;
        map_table_12 <= br_snapshots_2_12;
        map_table_13 <= br_snapshots_2_13;
        map_table_14 <= br_snapshots_2_14;
        map_table_15 <= br_snapshots_2_15;
        map_table_16 <= br_snapshots_2_16;
        map_table_17 <= br_snapshots_2_17;
        map_table_18 <= br_snapshots_2_18;
        map_table_19 <= br_snapshots_2_19;
        map_table_20 <= br_snapshots_2_20;
        map_table_21 <= br_snapshots_2_21;
        map_table_22 <= br_snapshots_2_22;
        map_table_23 <= br_snapshots_2_23;
        map_table_24 <= br_snapshots_2_24;
        map_table_25 <= br_snapshots_2_25;
        map_table_26 <= br_snapshots_2_26;
        map_table_27 <= br_snapshots_2_27;
        map_table_28 <= br_snapshots_2_28;
        map_table_29 <= br_snapshots_2_29;
        map_table_30 <= br_snapshots_2_30;
        map_table_31 <= br_snapshots_2_31;
      end
      else if (io_brupdate_b2_uop_br_tag == 5'h1) begin
        map_table_0 <= br_snapshots_1_0;
        map_table_1 <= br_snapshots_1_1;
        map_table_2 <= br_snapshots_1_2;
        map_table_3 <= br_snapshots_1_3;
        map_table_4 <= br_snapshots_1_4;
        map_table_5 <= br_snapshots_1_5;
        map_table_6 <= br_snapshots_1_6;
        map_table_7 <= br_snapshots_1_7;
        map_table_8 <= br_snapshots_1_8;
        map_table_9 <= br_snapshots_1_9;
        map_table_10 <= br_snapshots_1_10;
        map_table_11 <= br_snapshots_1_11;
        map_table_12 <= br_snapshots_1_12;
        map_table_13 <= br_snapshots_1_13;
        map_table_14 <= br_snapshots_1_14;
        map_table_15 <= br_snapshots_1_15;
        map_table_16 <= br_snapshots_1_16;
        map_table_17 <= br_snapshots_1_17;
        map_table_18 <= br_snapshots_1_18;
        map_table_19 <= br_snapshots_1_19;
        map_table_20 <= br_snapshots_1_20;
        map_table_21 <= br_snapshots_1_21;
        map_table_22 <= br_snapshots_1_22;
        map_table_23 <= br_snapshots_1_23;
        map_table_24 <= br_snapshots_1_24;
        map_table_25 <= br_snapshots_1_25;
        map_table_26 <= br_snapshots_1_26;
        map_table_27 <= br_snapshots_1_27;
        map_table_28 <= br_snapshots_1_28;
        map_table_29 <= br_snapshots_1_29;
        map_table_30 <= br_snapshots_1_30;
        map_table_31 <= br_snapshots_1_31;
      end
      else begin
        map_table_0 <= br_snapshots_0_0;
        map_table_1 <= br_snapshots_0_1;
        map_table_2 <= br_snapshots_0_2;
        map_table_3 <= br_snapshots_0_3;
        map_table_4 <= br_snapshots_0_4;
        map_table_5 <= br_snapshots_0_5;
        map_table_6 <= br_snapshots_0_6;
        map_table_7 <= br_snapshots_0_7;
        map_table_8 <= br_snapshots_0_8;
        map_table_9 <= br_snapshots_0_9;
        map_table_10 <= br_snapshots_0_10;
        map_table_11 <= br_snapshots_0_11;
        map_table_12 <= br_snapshots_0_12;
        map_table_13 <= br_snapshots_0_13;
        map_table_14 <= br_snapshots_0_14;
        map_table_15 <= br_snapshots_0_15;
        map_table_16 <= br_snapshots_0_16;
        map_table_17 <= br_snapshots_0_17;
        map_table_18 <= br_snapshots_0_18;
        map_table_19 <= br_snapshots_0_19;
        map_table_20 <= br_snapshots_0_20;
        map_table_21 <= br_snapshots_0_21;
        map_table_22 <= br_snapshots_0_22;
        map_table_23 <= br_snapshots_0_23;
        map_table_24 <= br_snapshots_0_24;
        map_table_25 <= br_snapshots_0_25;
        map_table_26 <= br_snapshots_0_26;
        map_table_27 <= br_snapshots_0_27;
        map_table_28 <= br_snapshots_0_28;
        map_table_29 <= br_snapshots_0_29;
        map_table_30 <= br_snapshots_0_30;
        map_table_31 <= br_snapshots_0_31;
      end
    end
    else begin
      map_table_0 <= 7'h0;
      if (_GEN_2[0])
        map_table_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        map_table_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        map_table_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        map_table_1 <= io_remap_reqs_0_pdst;
      if (_GEN_2[1])
        map_table_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        map_table_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        map_table_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        map_table_2 <= io_remap_reqs_0_pdst;
      if (_GEN_2[2])
        map_table_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        map_table_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        map_table_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        map_table_3 <= io_remap_reqs_0_pdst;
      if (_GEN_2[3])
        map_table_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        map_table_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        map_table_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        map_table_4 <= io_remap_reqs_0_pdst;
      if (_GEN_2[4])
        map_table_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        map_table_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        map_table_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        map_table_5 <= io_remap_reqs_0_pdst;
      if (_GEN_2[5])
        map_table_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        map_table_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        map_table_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        map_table_6 <= io_remap_reqs_0_pdst;
      if (_GEN_2[6])
        map_table_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        map_table_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        map_table_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        map_table_7 <= io_remap_reqs_0_pdst;
      if (_GEN_2[7])
        map_table_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        map_table_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        map_table_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        map_table_8 <= io_remap_reqs_0_pdst;
      if (_GEN_2[8])
        map_table_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        map_table_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        map_table_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        map_table_9 <= io_remap_reqs_0_pdst;
      if (_GEN_2[9])
        map_table_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        map_table_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        map_table_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        map_table_10 <= io_remap_reqs_0_pdst;
      if (_GEN_2[10])
        map_table_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        map_table_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        map_table_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        map_table_11 <= io_remap_reqs_0_pdst;
      if (_GEN_2[11])
        map_table_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        map_table_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        map_table_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        map_table_12 <= io_remap_reqs_0_pdst;
      if (_GEN_2[12])
        map_table_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        map_table_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        map_table_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        map_table_13 <= io_remap_reqs_0_pdst;
      if (_GEN_2[13])
        map_table_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        map_table_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        map_table_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        map_table_14 <= io_remap_reqs_0_pdst;
      if (_GEN_2[14])
        map_table_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        map_table_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        map_table_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        map_table_15 <= io_remap_reqs_0_pdst;
      if (_GEN_2[15])
        map_table_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        map_table_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        map_table_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        map_table_16 <= io_remap_reqs_0_pdst;
      if (_GEN_2[16])
        map_table_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        map_table_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        map_table_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        map_table_17 <= io_remap_reqs_0_pdst;
      if (_GEN_2[17])
        map_table_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        map_table_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        map_table_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        map_table_18 <= io_remap_reqs_0_pdst;
      if (_GEN_2[18])
        map_table_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        map_table_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        map_table_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        map_table_19 <= io_remap_reqs_0_pdst;
      if (_GEN_2[19])
        map_table_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        map_table_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        map_table_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        map_table_20 <= io_remap_reqs_0_pdst;
      if (_GEN_2[20])
        map_table_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        map_table_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        map_table_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        map_table_21 <= io_remap_reqs_0_pdst;
      if (_GEN_2[21])
        map_table_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        map_table_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        map_table_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        map_table_22 <= io_remap_reqs_0_pdst;
      if (_GEN_2[22])
        map_table_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        map_table_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        map_table_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        map_table_23 <= io_remap_reqs_0_pdst;
      if (_GEN_2[23])
        map_table_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        map_table_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        map_table_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        map_table_24 <= io_remap_reqs_0_pdst;
      if (_GEN_2[24])
        map_table_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        map_table_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        map_table_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        map_table_25 <= io_remap_reqs_0_pdst;
      if (_GEN_2[25])
        map_table_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        map_table_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        map_table_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        map_table_26 <= io_remap_reqs_0_pdst;
      if (_GEN_2[26])
        map_table_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        map_table_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        map_table_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        map_table_27 <= io_remap_reqs_0_pdst;
      if (_GEN_2[27])
        map_table_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        map_table_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        map_table_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        map_table_28 <= io_remap_reqs_0_pdst;
      if (_GEN_2[28])
        map_table_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        map_table_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        map_table_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        map_table_29 <= io_remap_reqs_0_pdst;
      if (_GEN_2[29])
        map_table_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        map_table_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        map_table_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        map_table_30 <= io_remap_reqs_0_pdst;
      if (_GEN_2[30])
        map_table_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        map_table_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        map_table_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        map_table_31 <= io_remap_reqs_0_pdst;
    end
    if (io_ren_br_tags_3_valid ? _GEN_83 | _GEN_63 | _GEN_43 : _GEN_63 | _GEN_43)
      br_snapshots_0_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_83) begin
      if (_GEN_2[0])
        br_snapshots_0_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_0_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_0_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_0_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_0_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_0_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_0_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_0_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_0_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_0_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_0_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_0_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_0_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_0_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_0_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_0_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_0_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_0_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_0_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_0_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_0_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_0_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_0_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_0_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_0_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_0_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_0_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_0_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_0_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_0_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_0_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_0_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_0_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_0_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_0_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_0_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_0_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_0_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_0_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_0_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_0_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_0_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_0_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_0_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_0_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_0_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_0_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_0_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_0_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_0_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_0_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_0_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_0_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_0_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_0_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_0_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_0_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_0_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_0_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_0_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_0_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_0_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_0_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_0_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_0_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_0_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_0_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_0_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_0_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_0_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_0_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_0_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_0_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_0_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_0_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_0_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_0_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_0_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_0_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_0_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_0_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_0_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_0_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_0_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_0_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_0_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_0_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_0_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_0_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_0_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_0_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_0_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_0_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_0_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_0_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_0_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_0_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_0_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_0_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_0_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_0_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_0_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_0_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_0_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_0_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_0_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_0_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_0_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_0_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_0_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_0_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_0_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_0_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_0_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_0_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_0_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_0_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_0_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_0_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_0_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_0_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_0_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_0_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_0_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_31 <= map_table_31;
    end
    else if (_GEN_63) begin
      if (_GEN_1[0])
        br_snapshots_0_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_0_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_0_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_0_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_0_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_0_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_0_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_0_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_0_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_0_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_0_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_0_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_0_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_0_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_0_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_0_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_0_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_0_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_0_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_0_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_0_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_0_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_0_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_0_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_0_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_0_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_0_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_0_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_0_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_0_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_0_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_0_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_0_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_0_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_0_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_0_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_0_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_0_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_0_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_0_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_0_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_0_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_0_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_0_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_0_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_0_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_0_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_0_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_0_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_0_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_0_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_0_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_0_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_0_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_0_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_0_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_0_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_0_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_0_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_0_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_0_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_0_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_0_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_0_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_0_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_0_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_0_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_0_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_0_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_0_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_0_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_0_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_0_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_0_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_0_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_0_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_0_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_0_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_0_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_0_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_0_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_0_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_0_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_0_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_0_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_0_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_0_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_0_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_0_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_0_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_0_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_0_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_0_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_23) begin
      if (_GEN_0[0])
        br_snapshots_0_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_0_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_0_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_0_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_0_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_0_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_0_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_0_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_0_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_0_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_0_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_0_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_0_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_0_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_0_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_0_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_0_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_0_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_0_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_0_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_0_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_0_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_0_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_0_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_0_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_0_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_0_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_0_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_0_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_0_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_0_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_0_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_0_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_0_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_0_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_0_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_0_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_0_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_0_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_0_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_0_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_0_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_0_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_0_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_0_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_0_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_0_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_0_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_0_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_0_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_0_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_0_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_0_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_0_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_0_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_0_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_0_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_0_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_0_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_0_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_0_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_0_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_31 <= map_table_31;
    end
    else if (_GEN_3) begin
      if (_GEN[0])
        br_snapshots_0_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_0_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_0_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_0_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_0_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_0_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_0_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_0_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_0_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_0_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_0_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_0_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_0_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_0_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_0_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_0_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_0_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_0_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_0_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_0_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_0_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_0_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_0_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_0_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_0_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_0_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_0_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_0_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_0_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_0_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_0_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_0_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_84 | _GEN_64 | _GEN_44 : _GEN_64 | _GEN_44)
      br_snapshots_1_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_84) begin
      if (_GEN_2[0])
        br_snapshots_1_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_1_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_1_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_1_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_1_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_1_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_1_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_1_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_1_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_1_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_1_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_1_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_1_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_1_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_1_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_1_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_1_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_1_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_1_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_1_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_1_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_1_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_1_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_1_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_1_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_1_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_1_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_1_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_1_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_1_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_1_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_1_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_1_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_1_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_1_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_1_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_1_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_1_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_1_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_1_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_1_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_1_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_1_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_1_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_1_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_1_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_1_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_1_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_1_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_1_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_1_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_1_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_1_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_1_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_1_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_1_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_1_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_1_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_1_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_1_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_1_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_1_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_1_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_1_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_1_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_1_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_1_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_1_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_1_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_1_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_1_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_1_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_1_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_1_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_1_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_1_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_1_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_1_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_1_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_1_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_1_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_1_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_1_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_1_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_1_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_1_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_1_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_1_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_1_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_1_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_1_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_1_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_1_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_1_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_1_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_1_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_1_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_1_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_1_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_1_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_1_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_1_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_1_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_1_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_1_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_1_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_1_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_1_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_1_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_1_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_1_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_1_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_1_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_1_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_1_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_1_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_1_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_1_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_1_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_1_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_1_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_1_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_1_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_1_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_31 <= map_table_31;
    end
    else if (_GEN_64) begin
      if (_GEN_1[0])
        br_snapshots_1_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_1_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_1_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_1_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_1_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_1_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_1_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_1_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_1_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_1_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_1_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_1_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_1_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_1_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_1_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_1_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_1_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_1_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_1_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_1_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_1_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_1_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_1_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_1_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_1_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_1_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_1_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_1_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_1_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_1_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_1_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_1_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_1_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_1_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_1_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_1_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_1_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_1_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_1_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_1_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_1_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_1_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_1_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_1_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_1_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_1_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_1_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_1_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_1_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_1_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_1_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_1_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_1_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_1_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_1_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_1_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_1_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_1_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_1_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_1_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_1_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_1_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_1_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_1_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_1_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_1_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_1_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_1_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_1_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_1_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_1_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_1_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_1_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_1_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_1_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_1_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_1_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_1_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_1_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_1_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_1_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_1_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_1_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_1_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_1_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_1_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_1_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_1_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_1_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_1_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_1_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_1_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_1_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_24) begin
      if (_GEN_0[0])
        br_snapshots_1_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_1_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_1_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_1_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_1_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_1_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_1_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_1_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_1_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_1_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_1_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_1_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_1_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_1_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_1_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_1_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_1_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_1_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_1_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_1_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_1_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_1_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_1_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_1_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_1_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_1_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_1_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_1_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_1_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_1_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_1_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_1_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_1_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_1_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_1_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_1_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_1_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_1_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_1_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_1_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_1_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_1_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_1_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_1_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_1_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_1_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_1_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_1_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_1_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_1_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_1_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_1_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_1_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_1_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_1_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_1_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_1_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_1_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_1_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_1_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_1_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_1_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_31 <= map_table_31;
    end
    else if (_GEN_4) begin
      if (_GEN[0])
        br_snapshots_1_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_1_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_1_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_1_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_1_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_1_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_1_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_1_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_1_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_1_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_1_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_1_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_1_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_1_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_1_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_1_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_1_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_1_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_1_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_1_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_1_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_1_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_1_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_1_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_1_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_1_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_1_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_1_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_1_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_1_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_1_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_1_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_85 | _GEN_65 | _GEN_45 : _GEN_65 | _GEN_45)
      br_snapshots_2_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_85) begin
      if (_GEN_2[0])
        br_snapshots_2_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_2_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_2_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_2_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_2_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_2_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_2_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_2_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_2_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_2_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_2_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_2_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_2_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_2_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_2_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_2_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_2_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_2_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_2_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_2_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_2_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_2_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_2_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_2_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_2_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_2_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_2_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_2_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_2_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_2_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_2_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_2_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_2_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_2_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_2_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_2_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_2_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_2_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_2_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_2_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_2_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_2_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_2_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_2_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_2_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_2_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_2_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_2_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_2_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_2_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_2_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_2_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_2_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_2_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_2_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_2_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_2_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_2_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_2_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_2_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_2_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_2_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_2_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_2_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_2_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_2_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_2_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_2_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_2_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_2_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_2_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_2_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_2_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_2_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_2_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_2_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_2_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_2_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_2_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_2_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_2_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_2_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_2_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_2_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_2_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_2_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_2_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_2_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_2_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_2_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_2_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_2_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_2_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_2_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_2_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_2_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_2_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_2_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_2_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_2_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_2_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_2_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_2_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_2_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_2_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_2_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_2_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_2_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_2_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_2_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_2_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_2_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_2_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_2_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_2_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_2_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_2_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_2_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_2_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_2_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_2_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_2_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_2_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_2_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_31 <= map_table_31;
    end
    else if (_GEN_65) begin
      if (_GEN_1[0])
        br_snapshots_2_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_2_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_2_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_2_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_2_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_2_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_2_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_2_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_2_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_2_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_2_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_2_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_2_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_2_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_2_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_2_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_2_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_2_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_2_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_2_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_2_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_2_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_2_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_2_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_2_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_2_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_2_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_2_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_2_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_2_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_2_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_2_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_2_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_2_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_2_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_2_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_2_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_2_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_2_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_2_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_2_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_2_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_2_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_2_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_2_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_2_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_2_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_2_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_2_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_2_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_2_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_2_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_2_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_2_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_2_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_2_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_2_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_2_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_2_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_2_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_2_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_2_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_2_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_2_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_2_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_2_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_2_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_2_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_2_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_2_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_2_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_2_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_2_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_2_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_2_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_2_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_2_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_2_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_2_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_2_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_2_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_2_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_2_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_2_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_2_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_2_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_2_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_2_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_2_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_2_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_2_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_2_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_2_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_25) begin
      if (_GEN_0[0])
        br_snapshots_2_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_2_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_2_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_2_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_2_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_2_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_2_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_2_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_2_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_2_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_2_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_2_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_2_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_2_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_2_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_2_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_2_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_2_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_2_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_2_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_2_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_2_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_2_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_2_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_2_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_2_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_2_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_2_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_2_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_2_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_2_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_2_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_2_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_2_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_2_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_2_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_2_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_2_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_2_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_2_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_2_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_2_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_2_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_2_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_2_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_2_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_2_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_2_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_2_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_2_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_2_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_2_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_2_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_2_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_2_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_2_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_2_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_2_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_2_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_2_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_2_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_2_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_31 <= map_table_31;
    end
    else if (_GEN_5) begin
      if (_GEN[0])
        br_snapshots_2_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_2_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_2_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_2_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_2_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_2_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_2_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_2_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_2_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_2_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_2_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_2_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_2_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_2_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_2_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_2_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_2_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_2_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_2_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_2_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_2_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_2_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_2_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_2_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_2_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_2_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_2_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_2_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_2_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_2_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_2_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_2_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_86 | _GEN_66 | _GEN_46 : _GEN_66 | _GEN_46)
      br_snapshots_3_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_86) begin
      if (_GEN_2[0])
        br_snapshots_3_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_3_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_3_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_3_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_3_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_3_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_3_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_3_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_3_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_3_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_3_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_3_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_3_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_3_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_3_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_3_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_3_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_3_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_3_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_3_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_3_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_3_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_3_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_3_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_3_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_3_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_3_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_3_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_3_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_3_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_3_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_3_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_3_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_3_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_3_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_3_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_3_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_3_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_3_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_3_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_3_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_3_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_3_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_3_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_3_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_3_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_3_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_3_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_3_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_3_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_3_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_3_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_3_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_3_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_3_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_3_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_3_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_3_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_3_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_3_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_3_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_3_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_3_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_3_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_3_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_3_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_3_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_3_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_3_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_3_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_3_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_3_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_3_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_3_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_3_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_3_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_3_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_3_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_3_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_3_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_3_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_3_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_3_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_3_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_3_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_3_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_3_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_3_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_3_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_3_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_3_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_3_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_3_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_3_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_3_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_3_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_3_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_3_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_3_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_3_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_3_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_3_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_3_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_3_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_3_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_3_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_3_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_3_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_3_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_3_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_3_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_3_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_3_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_3_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_3_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_3_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_3_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_3_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_3_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_3_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_3_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_3_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_3_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_3_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_31 <= map_table_31;
    end
    else if (_GEN_66) begin
      if (_GEN_1[0])
        br_snapshots_3_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_3_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_3_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_3_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_3_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_3_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_3_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_3_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_3_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_3_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_3_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_3_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_3_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_3_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_3_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_3_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_3_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_3_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_3_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_3_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_3_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_3_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_3_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_3_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_3_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_3_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_3_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_3_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_3_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_3_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_3_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_3_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_3_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_3_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_3_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_3_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_3_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_3_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_3_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_3_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_3_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_3_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_3_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_3_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_3_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_3_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_3_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_3_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_3_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_3_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_3_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_3_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_3_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_3_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_3_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_3_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_3_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_3_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_3_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_3_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_3_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_3_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_3_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_3_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_3_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_3_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_3_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_3_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_3_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_3_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_3_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_3_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_3_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_3_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_3_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_3_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_3_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_3_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_3_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_3_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_3_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_3_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_3_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_3_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_3_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_3_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_3_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_3_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_3_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_3_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_3_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_3_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_3_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_26) begin
      if (_GEN_0[0])
        br_snapshots_3_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_3_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_3_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_3_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_3_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_3_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_3_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_3_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_3_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_3_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_3_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_3_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_3_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_3_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_3_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_3_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_3_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_3_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_3_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_3_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_3_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_3_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_3_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_3_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_3_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_3_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_3_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_3_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_3_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_3_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_3_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_3_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_3_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_3_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_3_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_3_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_3_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_3_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_3_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_3_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_3_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_3_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_3_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_3_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_3_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_3_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_3_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_3_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_3_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_3_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_3_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_3_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_3_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_3_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_3_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_3_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_3_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_3_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_3_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_3_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_3_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_3_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_31 <= map_table_31;
    end
    else if (_GEN_6) begin
      if (_GEN[0])
        br_snapshots_3_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_3_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_3_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_3_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_3_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_3_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_3_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_3_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_3_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_3_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_3_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_3_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_3_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_3_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_3_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_3_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_3_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_3_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_3_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_3_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_3_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_3_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_3_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_3_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_3_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_3_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_3_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_3_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_3_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_3_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_3_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_3_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_87 | _GEN_67 | _GEN_47 : _GEN_67 | _GEN_47)
      br_snapshots_4_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_87) begin
      if (_GEN_2[0])
        br_snapshots_4_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_4_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_4_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_4_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_4_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_4_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_4_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_4_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_4_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_4_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_4_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_4_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_4_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_4_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_4_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_4_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_4_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_4_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_4_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_4_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_4_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_4_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_4_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_4_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_4_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_4_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_4_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_4_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_4_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_4_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_4_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_4_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_4_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_4_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_4_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_4_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_4_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_4_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_4_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_4_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_4_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_4_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_4_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_4_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_4_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_4_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_4_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_4_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_4_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_4_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_4_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_4_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_4_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_4_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_4_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_4_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_4_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_4_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_4_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_4_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_4_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_4_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_4_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_4_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_4_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_4_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_4_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_4_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_4_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_4_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_4_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_4_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_4_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_4_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_4_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_4_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_4_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_4_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_4_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_4_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_4_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_4_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_4_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_4_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_4_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_4_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_4_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_4_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_4_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_4_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_4_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_4_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_4_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_4_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_4_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_4_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_4_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_4_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_4_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_4_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_4_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_4_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_4_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_4_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_4_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_4_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_4_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_4_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_4_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_4_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_4_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_4_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_4_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_4_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_4_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_4_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_4_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_4_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_4_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_4_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_4_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_4_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_4_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_4_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_31 <= map_table_31;
    end
    else if (_GEN_67) begin
      if (_GEN_1[0])
        br_snapshots_4_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_4_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_4_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_4_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_4_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_4_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_4_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_4_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_4_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_4_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_4_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_4_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_4_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_4_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_4_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_4_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_4_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_4_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_4_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_4_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_4_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_4_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_4_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_4_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_4_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_4_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_4_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_4_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_4_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_4_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_4_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_4_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_4_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_4_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_4_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_4_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_4_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_4_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_4_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_4_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_4_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_4_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_4_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_4_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_4_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_4_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_4_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_4_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_4_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_4_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_4_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_4_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_4_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_4_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_4_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_4_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_4_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_4_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_4_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_4_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_4_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_4_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_4_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_4_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_4_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_4_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_4_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_4_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_4_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_4_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_4_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_4_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_4_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_4_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_4_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_4_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_4_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_4_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_4_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_4_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_4_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_4_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_4_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_4_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_4_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_4_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_4_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_4_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_4_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_4_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_4_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_4_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_4_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_27) begin
      if (_GEN_0[0])
        br_snapshots_4_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_4_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_4_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_4_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_4_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_4_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_4_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_4_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_4_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_4_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_4_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_4_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_4_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_4_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_4_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_4_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_4_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_4_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_4_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_4_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_4_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_4_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_4_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_4_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_4_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_4_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_4_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_4_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_4_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_4_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_4_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_4_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_4_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_4_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_4_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_4_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_4_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_4_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_4_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_4_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_4_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_4_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_4_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_4_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_4_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_4_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_4_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_4_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_4_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_4_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_4_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_4_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_4_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_4_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_4_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_4_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_4_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_4_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_4_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_4_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_4_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_4_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_31 <= map_table_31;
    end
    else if (_GEN_7) begin
      if (_GEN[0])
        br_snapshots_4_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_4_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_4_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_4_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_4_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_4_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_4_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_4_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_4_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_4_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_4_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_4_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_4_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_4_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_4_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_4_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_4_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_4_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_4_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_4_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_4_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_4_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_4_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_4_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_4_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_4_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_4_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_4_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_4_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_4_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_4_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_4_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_88 | _GEN_68 | _GEN_48 : _GEN_68 | _GEN_48)
      br_snapshots_5_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_88) begin
      if (_GEN_2[0])
        br_snapshots_5_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_5_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_5_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_5_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_5_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_5_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_5_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_5_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_5_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_5_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_5_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_5_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_5_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_5_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_5_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_5_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_5_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_5_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_5_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_5_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_5_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_5_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_5_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_5_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_5_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_5_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_5_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_5_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_5_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_5_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_5_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_5_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_5_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_5_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_5_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_5_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_5_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_5_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_5_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_5_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_5_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_5_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_5_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_5_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_5_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_5_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_5_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_5_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_5_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_5_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_5_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_5_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_5_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_5_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_5_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_5_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_5_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_5_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_5_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_5_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_5_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_5_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_5_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_5_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_5_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_5_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_5_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_5_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_5_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_5_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_5_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_5_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_5_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_5_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_5_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_5_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_5_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_5_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_5_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_5_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_5_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_5_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_5_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_5_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_5_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_5_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_5_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_5_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_5_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_5_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_5_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_5_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_5_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_5_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_5_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_5_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_5_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_5_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_5_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_5_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_5_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_5_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_5_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_5_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_5_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_5_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_5_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_5_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_5_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_5_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_5_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_5_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_5_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_5_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_5_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_5_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_5_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_5_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_5_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_5_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_5_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_5_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_5_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_5_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_31 <= map_table_31;
    end
    else if (_GEN_68) begin
      if (_GEN_1[0])
        br_snapshots_5_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_5_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_5_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_5_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_5_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_5_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_5_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_5_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_5_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_5_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_5_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_5_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_5_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_5_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_5_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_5_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_5_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_5_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_5_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_5_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_5_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_5_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_5_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_5_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_5_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_5_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_5_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_5_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_5_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_5_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_5_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_5_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_5_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_5_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_5_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_5_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_5_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_5_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_5_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_5_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_5_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_5_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_5_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_5_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_5_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_5_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_5_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_5_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_5_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_5_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_5_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_5_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_5_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_5_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_5_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_5_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_5_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_5_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_5_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_5_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_5_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_5_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_5_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_5_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_5_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_5_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_5_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_5_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_5_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_5_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_5_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_5_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_5_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_5_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_5_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_5_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_5_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_5_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_5_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_5_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_5_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_5_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_5_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_5_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_5_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_5_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_5_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_5_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_5_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_5_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_5_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_5_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_5_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_28) begin
      if (_GEN_0[0])
        br_snapshots_5_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_5_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_5_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_5_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_5_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_5_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_5_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_5_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_5_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_5_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_5_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_5_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_5_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_5_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_5_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_5_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_5_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_5_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_5_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_5_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_5_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_5_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_5_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_5_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_5_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_5_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_5_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_5_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_5_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_5_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_5_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_5_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_5_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_5_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_5_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_5_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_5_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_5_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_5_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_5_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_5_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_5_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_5_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_5_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_5_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_5_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_5_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_5_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_5_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_5_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_5_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_5_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_5_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_5_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_5_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_5_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_5_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_5_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_5_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_5_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_5_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_5_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_31 <= map_table_31;
    end
    else if (_GEN_8) begin
      if (_GEN[0])
        br_snapshots_5_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_5_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_5_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_5_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_5_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_5_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_5_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_5_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_5_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_5_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_5_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_5_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_5_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_5_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_5_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_5_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_5_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_5_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_5_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_5_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_5_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_5_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_5_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_5_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_5_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_5_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_5_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_5_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_5_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_5_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_5_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_5_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_89 | _GEN_69 | _GEN_49 : _GEN_69 | _GEN_49)
      br_snapshots_6_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_89) begin
      if (_GEN_2[0])
        br_snapshots_6_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_6_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_6_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_6_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_6_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_6_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_6_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_6_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_6_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_6_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_6_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_6_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_6_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_6_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_6_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_6_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_6_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_6_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_6_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_6_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_6_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_6_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_6_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_6_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_6_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_6_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_6_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_6_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_6_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_6_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_6_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_6_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_6_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_6_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_6_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_6_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_6_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_6_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_6_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_6_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_6_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_6_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_6_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_6_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_6_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_6_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_6_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_6_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_6_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_6_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_6_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_6_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_6_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_6_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_6_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_6_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_6_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_6_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_6_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_6_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_6_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_6_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_6_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_6_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_6_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_6_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_6_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_6_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_6_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_6_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_6_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_6_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_6_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_6_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_6_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_6_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_6_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_6_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_6_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_6_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_6_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_6_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_6_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_6_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_6_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_6_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_6_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_6_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_6_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_6_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_6_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_6_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_6_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_6_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_6_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_6_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_6_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_6_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_6_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_6_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_6_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_6_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_6_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_6_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_6_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_6_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_6_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_6_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_6_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_6_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_6_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_6_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_6_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_6_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_6_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_6_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_6_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_6_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_6_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_6_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_6_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_6_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_6_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_6_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_31 <= map_table_31;
    end
    else if (_GEN_69) begin
      if (_GEN_1[0])
        br_snapshots_6_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_6_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_6_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_6_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_6_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_6_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_6_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_6_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_6_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_6_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_6_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_6_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_6_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_6_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_6_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_6_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_6_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_6_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_6_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_6_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_6_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_6_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_6_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_6_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_6_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_6_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_6_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_6_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_6_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_6_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_6_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_6_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_6_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_6_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_6_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_6_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_6_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_6_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_6_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_6_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_6_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_6_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_6_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_6_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_6_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_6_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_6_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_6_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_6_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_6_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_6_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_6_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_6_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_6_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_6_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_6_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_6_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_6_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_6_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_6_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_6_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_6_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_6_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_6_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_6_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_6_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_6_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_6_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_6_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_6_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_6_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_6_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_6_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_6_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_6_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_6_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_6_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_6_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_6_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_6_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_6_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_6_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_6_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_6_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_6_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_6_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_6_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_6_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_6_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_6_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_6_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_6_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_6_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_29) begin
      if (_GEN_0[0])
        br_snapshots_6_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_6_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_6_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_6_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_6_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_6_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_6_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_6_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_6_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_6_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_6_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_6_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_6_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_6_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_6_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_6_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_6_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_6_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_6_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_6_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_6_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_6_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_6_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_6_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_6_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_6_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_6_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_6_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_6_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_6_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_6_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_6_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_6_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_6_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_6_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_6_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_6_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_6_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_6_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_6_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_6_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_6_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_6_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_6_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_6_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_6_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_6_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_6_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_6_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_6_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_6_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_6_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_6_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_6_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_6_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_6_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_6_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_6_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_6_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_6_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_6_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_6_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_31 <= map_table_31;
    end
    else if (_GEN_9) begin
      if (_GEN[0])
        br_snapshots_6_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_6_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_6_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_6_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_6_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_6_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_6_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_6_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_6_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_6_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_6_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_6_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_6_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_6_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_6_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_6_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_6_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_6_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_6_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_6_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_6_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_6_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_6_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_6_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_6_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_6_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_6_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_6_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_6_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_6_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_6_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_6_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_90 | _GEN_70 | _GEN_50 : _GEN_70 | _GEN_50)
      br_snapshots_7_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_90) begin
      if (_GEN_2[0])
        br_snapshots_7_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_7_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_7_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_7_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_7_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_7_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_7_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_7_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_7_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_7_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_7_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_7_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_7_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_7_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_7_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_7_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_7_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_7_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_7_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_7_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_7_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_7_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_7_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_7_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_7_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_7_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_7_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_7_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_7_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_7_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_7_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_7_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_7_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_7_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_7_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_7_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_7_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_7_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_7_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_7_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_7_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_7_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_7_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_7_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_7_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_7_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_7_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_7_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_7_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_7_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_7_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_7_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_7_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_7_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_7_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_7_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_7_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_7_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_7_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_7_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_7_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_7_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_7_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_7_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_7_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_7_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_7_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_7_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_7_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_7_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_7_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_7_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_7_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_7_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_7_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_7_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_7_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_7_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_7_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_7_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_7_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_7_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_7_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_7_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_7_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_7_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_7_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_7_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_7_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_7_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_7_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_7_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_7_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_7_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_7_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_7_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_7_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_7_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_7_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_7_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_7_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_7_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_7_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_7_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_7_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_7_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_7_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_7_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_7_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_7_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_7_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_7_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_7_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_7_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_7_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_7_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_7_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_7_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_7_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_7_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_7_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_7_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_7_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_7_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_31 <= map_table_31;
    end
    else if (_GEN_70) begin
      if (_GEN_1[0])
        br_snapshots_7_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_7_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_7_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_7_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_7_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_7_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_7_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_7_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_7_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_7_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_7_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_7_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_7_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_7_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_7_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_7_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_7_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_7_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_7_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_7_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_7_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_7_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_7_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_7_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_7_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_7_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_7_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_7_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_7_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_7_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_7_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_7_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_7_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_7_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_7_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_7_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_7_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_7_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_7_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_7_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_7_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_7_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_7_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_7_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_7_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_7_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_7_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_7_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_7_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_7_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_7_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_7_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_7_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_7_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_7_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_7_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_7_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_7_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_7_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_7_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_7_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_7_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_7_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_7_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_7_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_7_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_7_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_7_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_7_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_7_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_7_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_7_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_7_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_7_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_7_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_7_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_7_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_7_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_7_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_7_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_7_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_7_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_7_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_7_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_7_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_7_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_7_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_7_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_7_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_7_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_7_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_7_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_7_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_30) begin
      if (_GEN_0[0])
        br_snapshots_7_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_7_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_7_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_7_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_7_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_7_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_7_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_7_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_7_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_7_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_7_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_7_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_7_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_7_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_7_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_7_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_7_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_7_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_7_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_7_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_7_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_7_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_7_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_7_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_7_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_7_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_7_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_7_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_7_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_7_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_7_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_7_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_7_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_7_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_7_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_7_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_7_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_7_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_7_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_7_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_7_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_7_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_7_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_7_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_7_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_7_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_7_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_7_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_7_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_7_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_7_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_7_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_7_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_7_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_7_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_7_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_7_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_7_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_7_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_7_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_7_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_7_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_31 <= map_table_31;
    end
    else if (_GEN_10) begin
      if (_GEN[0])
        br_snapshots_7_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_7_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_7_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_7_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_7_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_7_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_7_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_7_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_7_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_7_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_7_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_7_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_7_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_7_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_7_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_7_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_7_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_7_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_7_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_7_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_7_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_7_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_7_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_7_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_7_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_7_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_7_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_7_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_7_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_7_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_7_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_7_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_91 | _GEN_71 | _GEN_51 : _GEN_71 | _GEN_51)
      br_snapshots_8_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_91) begin
      if (_GEN_2[0])
        br_snapshots_8_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_8_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_8_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_8_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_8_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_8_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_8_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_8_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_8_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_8_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_8_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_8_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_8_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_8_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_8_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_8_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_8_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_8_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_8_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_8_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_8_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_8_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_8_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_8_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_8_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_8_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_8_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_8_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_8_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_8_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_8_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_8_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_8_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_8_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_8_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_8_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_8_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_8_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_8_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_8_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_8_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_8_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_8_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_8_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_8_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_8_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_8_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_8_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_8_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_8_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_8_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_8_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_8_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_8_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_8_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_8_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_8_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_8_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_8_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_8_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_8_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_8_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_8_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_8_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_8_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_8_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_8_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_8_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_8_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_8_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_8_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_8_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_8_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_8_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_8_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_8_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_8_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_8_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_8_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_8_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_8_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_8_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_8_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_8_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_8_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_8_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_8_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_8_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_8_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_8_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_8_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_8_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_8_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_8_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_8_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_8_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_8_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_8_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_8_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_8_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_8_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_8_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_8_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_8_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_8_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_8_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_8_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_8_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_8_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_8_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_8_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_8_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_8_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_8_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_8_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_8_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_8_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_8_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_8_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_8_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_8_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_8_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_8_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_8_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_31 <= map_table_31;
    end
    else if (_GEN_71) begin
      if (_GEN_1[0])
        br_snapshots_8_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_8_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_8_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_8_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_8_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_8_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_8_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_8_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_8_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_8_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_8_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_8_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_8_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_8_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_8_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_8_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_8_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_8_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_8_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_8_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_8_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_8_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_8_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_8_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_8_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_8_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_8_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_8_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_8_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_8_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_8_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_8_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_8_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_8_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_8_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_8_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_8_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_8_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_8_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_8_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_8_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_8_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_8_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_8_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_8_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_8_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_8_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_8_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_8_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_8_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_8_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_8_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_8_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_8_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_8_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_8_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_8_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_8_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_8_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_8_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_8_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_8_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_8_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_8_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_8_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_8_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_8_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_8_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_8_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_8_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_8_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_8_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_8_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_8_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_8_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_8_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_8_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_8_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_8_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_8_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_8_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_8_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_8_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_8_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_8_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_8_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_8_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_8_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_8_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_8_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_8_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_8_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_8_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_31) begin
      if (_GEN_0[0])
        br_snapshots_8_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_8_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_8_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_8_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_8_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_8_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_8_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_8_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_8_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_8_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_8_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_8_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_8_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_8_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_8_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_8_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_8_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_8_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_8_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_8_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_8_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_8_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_8_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_8_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_8_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_8_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_8_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_8_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_8_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_8_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_8_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_8_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_8_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_8_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_8_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_8_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_8_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_8_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_8_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_8_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_8_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_8_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_8_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_8_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_8_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_8_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_8_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_8_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_8_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_8_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_8_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_8_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_8_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_8_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_8_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_8_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_8_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_8_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_8_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_8_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_8_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_8_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_31 <= map_table_31;
    end
    else if (_GEN_11) begin
      if (_GEN[0])
        br_snapshots_8_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_8_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_8_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_8_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_8_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_8_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_8_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_8_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_8_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_8_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_8_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_8_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_8_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_8_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_8_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_8_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_8_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_8_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_8_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_8_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_8_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_8_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_8_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_8_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_8_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_8_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_8_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_8_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_8_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_8_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_8_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_8_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_92 | _GEN_72 | _GEN_52 : _GEN_72 | _GEN_52)
      br_snapshots_9_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_92) begin
      if (_GEN_2[0])
        br_snapshots_9_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_9_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_9_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_9_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_9_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_9_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_9_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_9_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_9_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_9_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_9_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_9_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_9_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_9_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_9_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_9_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_9_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_9_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_9_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_9_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_9_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_9_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_9_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_9_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_9_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_9_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_9_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_9_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_9_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_9_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_9_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_9_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_9_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_9_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_9_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_9_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_9_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_9_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_9_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_9_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_9_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_9_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_9_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_9_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_9_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_9_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_9_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_9_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_9_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_9_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_9_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_9_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_9_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_9_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_9_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_9_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_9_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_9_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_9_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_9_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_9_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_9_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_9_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_9_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_9_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_9_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_9_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_9_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_9_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_9_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_9_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_9_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_9_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_9_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_9_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_9_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_9_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_9_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_9_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_9_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_9_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_9_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_9_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_9_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_9_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_9_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_9_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_9_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_9_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_9_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_9_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_9_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_9_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_9_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_9_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_9_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_9_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_9_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_9_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_9_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_9_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_9_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_9_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_9_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_9_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_9_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_9_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_9_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_9_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_9_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_9_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_9_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_9_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_9_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_9_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_9_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_9_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_9_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_9_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_9_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_9_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_9_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_9_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_9_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_31 <= map_table_31;
    end
    else if (_GEN_72) begin
      if (_GEN_1[0])
        br_snapshots_9_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_9_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_9_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_9_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_9_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_9_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_9_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_9_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_9_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_9_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_9_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_9_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_9_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_9_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_9_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_9_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_9_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_9_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_9_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_9_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_9_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_9_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_9_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_9_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_9_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_9_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_9_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_9_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_9_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_9_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_9_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_9_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_9_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_9_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_9_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_9_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_9_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_9_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_9_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_9_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_9_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_9_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_9_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_9_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_9_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_9_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_9_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_9_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_9_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_9_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_9_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_9_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_9_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_9_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_9_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_9_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_9_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_9_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_9_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_9_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_9_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_9_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_9_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_9_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_9_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_9_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_9_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_9_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_9_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_9_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_9_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_9_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_9_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_9_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_9_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_9_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_9_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_9_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_9_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_9_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_9_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_9_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_9_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_9_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_9_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_9_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_9_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_9_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_9_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_9_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_9_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_9_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_9_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_32) begin
      if (_GEN_0[0])
        br_snapshots_9_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_9_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_9_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_9_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_9_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_9_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_9_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_9_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_9_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_9_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_9_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_9_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_9_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_9_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_9_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_9_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_9_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_9_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_9_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_9_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_9_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_9_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_9_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_9_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_9_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_9_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_9_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_9_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_9_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_9_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_9_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_9_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_9_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_9_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_9_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_9_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_9_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_9_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_9_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_9_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_9_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_9_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_9_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_9_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_9_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_9_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_9_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_9_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_9_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_9_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_9_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_9_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_9_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_9_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_9_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_9_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_9_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_9_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_9_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_9_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_9_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_9_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_31 <= map_table_31;
    end
    else if (_GEN_12) begin
      if (_GEN[0])
        br_snapshots_9_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_9_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_9_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_9_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_9_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_9_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_9_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_9_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_9_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_9_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_9_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_9_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_9_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_9_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_9_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_9_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_9_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_9_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_9_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_9_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_9_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_9_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_9_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_9_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_9_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_9_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_9_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_9_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_9_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_9_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_9_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_9_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_93 | _GEN_73 | _GEN_53 : _GEN_73 | _GEN_53)
      br_snapshots_10_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_93) begin
      if (_GEN_2[0])
        br_snapshots_10_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_10_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_10_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_10_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_10_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_10_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_10_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_10_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_10_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_10_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_10_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_10_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_10_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_10_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_10_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_10_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_10_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_10_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_10_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_10_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_10_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_10_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_10_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_10_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_10_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_10_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_10_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_10_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_10_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_10_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_10_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_10_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_10_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_10_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_10_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_10_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_10_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_10_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_10_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_10_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_10_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_10_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_10_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_10_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_10_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_10_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_10_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_10_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_10_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_10_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_10_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_10_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_10_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_10_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_10_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_10_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_10_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_10_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_10_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_10_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_10_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_10_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_10_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_10_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_10_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_10_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_10_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_10_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_10_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_10_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_10_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_10_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_10_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_10_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_10_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_10_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_10_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_10_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_10_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_10_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_10_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_10_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_10_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_10_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_10_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_10_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_10_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_10_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_10_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_10_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_10_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_10_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_10_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_10_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_10_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_10_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_10_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_10_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_10_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_10_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_10_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_10_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_10_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_10_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_10_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_10_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_10_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_10_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_10_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_10_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_10_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_10_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_10_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_10_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_10_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_10_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_10_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_10_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_10_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_10_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_10_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_10_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_10_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_10_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_31 <= map_table_31;
    end
    else if (_GEN_73) begin
      if (_GEN_1[0])
        br_snapshots_10_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_10_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_10_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_10_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_10_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_10_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_10_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_10_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_10_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_10_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_10_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_10_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_10_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_10_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_10_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_10_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_10_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_10_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_10_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_10_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_10_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_10_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_10_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_10_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_10_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_10_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_10_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_10_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_10_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_10_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_10_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_10_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_10_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_10_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_10_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_10_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_10_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_10_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_10_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_10_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_10_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_10_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_10_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_10_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_10_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_10_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_10_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_10_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_10_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_10_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_10_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_10_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_10_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_10_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_10_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_10_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_10_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_10_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_10_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_10_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_10_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_10_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_10_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_10_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_10_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_10_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_10_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_10_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_10_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_10_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_10_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_10_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_10_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_10_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_10_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_10_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_10_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_10_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_10_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_10_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_10_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_10_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_10_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_10_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_10_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_10_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_10_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_10_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_10_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_10_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_10_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_10_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_10_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_33) begin
      if (_GEN_0[0])
        br_snapshots_10_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_10_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_10_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_10_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_10_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_10_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_10_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_10_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_10_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_10_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_10_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_10_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_10_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_10_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_10_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_10_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_10_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_10_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_10_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_10_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_10_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_10_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_10_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_10_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_10_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_10_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_10_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_10_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_10_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_10_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_10_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_10_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_10_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_10_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_10_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_10_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_10_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_10_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_10_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_10_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_10_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_10_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_10_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_10_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_10_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_10_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_10_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_10_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_10_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_10_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_10_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_10_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_10_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_10_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_10_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_10_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_10_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_10_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_10_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_10_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_10_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_10_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_31 <= map_table_31;
    end
    else if (_GEN_13) begin
      if (_GEN[0])
        br_snapshots_10_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_10_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_10_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_10_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_10_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_10_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_10_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_10_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_10_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_10_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_10_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_10_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_10_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_10_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_10_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_10_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_10_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_10_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_10_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_10_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_10_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_10_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_10_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_10_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_10_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_10_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_10_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_10_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_10_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_10_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_10_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_10_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_94 | _GEN_74 | _GEN_54 : _GEN_74 | _GEN_54)
      br_snapshots_11_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_94) begin
      if (_GEN_2[0])
        br_snapshots_11_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_11_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_11_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_11_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_11_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_11_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_11_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_11_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_11_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_11_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_11_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_11_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_11_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_11_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_11_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_11_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_11_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_11_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_11_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_11_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_11_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_11_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_11_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_11_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_11_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_11_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_11_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_11_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_11_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_11_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_11_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_11_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_11_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_11_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_11_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_11_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_11_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_11_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_11_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_11_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_11_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_11_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_11_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_11_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_11_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_11_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_11_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_11_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_11_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_11_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_11_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_11_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_11_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_11_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_11_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_11_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_11_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_11_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_11_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_11_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_11_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_11_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_11_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_11_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_11_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_11_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_11_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_11_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_11_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_11_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_11_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_11_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_11_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_11_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_11_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_11_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_11_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_11_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_11_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_11_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_11_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_11_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_11_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_11_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_11_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_11_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_11_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_11_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_11_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_11_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_11_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_11_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_11_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_11_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_11_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_11_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_11_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_11_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_11_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_11_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_11_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_11_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_11_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_11_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_11_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_11_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_11_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_11_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_11_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_11_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_11_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_11_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_11_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_11_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_11_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_11_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_11_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_11_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_11_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_11_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_11_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_11_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_11_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_11_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_31 <= map_table_31;
    end
    else if (_GEN_74) begin
      if (_GEN_1[0])
        br_snapshots_11_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_11_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_11_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_11_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_11_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_11_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_11_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_11_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_11_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_11_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_11_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_11_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_11_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_11_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_11_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_11_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_11_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_11_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_11_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_11_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_11_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_11_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_11_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_11_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_11_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_11_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_11_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_11_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_11_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_11_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_11_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_11_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_11_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_11_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_11_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_11_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_11_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_11_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_11_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_11_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_11_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_11_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_11_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_11_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_11_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_11_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_11_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_11_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_11_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_11_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_11_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_11_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_11_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_11_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_11_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_11_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_11_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_11_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_11_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_11_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_11_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_11_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_11_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_11_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_11_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_11_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_11_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_11_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_11_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_11_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_11_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_11_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_11_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_11_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_11_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_11_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_11_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_11_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_11_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_11_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_11_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_11_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_11_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_11_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_11_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_11_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_11_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_11_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_11_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_11_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_11_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_11_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_11_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_34) begin
      if (_GEN_0[0])
        br_snapshots_11_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_11_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_11_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_11_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_11_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_11_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_11_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_11_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_11_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_11_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_11_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_11_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_11_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_11_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_11_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_11_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_11_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_11_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_11_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_11_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_11_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_11_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_11_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_11_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_11_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_11_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_11_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_11_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_11_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_11_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_11_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_11_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_11_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_11_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_11_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_11_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_11_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_11_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_11_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_11_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_11_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_11_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_11_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_11_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_11_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_11_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_11_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_11_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_11_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_11_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_11_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_11_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_11_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_11_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_11_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_11_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_11_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_11_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_11_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_11_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_11_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_11_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_31 <= map_table_31;
    end
    else if (_GEN_14) begin
      if (_GEN[0])
        br_snapshots_11_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_11_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_11_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_11_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_11_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_11_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_11_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_11_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_11_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_11_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_11_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_11_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_11_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_11_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_11_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_11_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_11_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_11_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_11_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_11_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_11_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_11_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_11_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_11_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_11_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_11_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_11_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_11_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_11_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_11_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_11_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_11_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_95 | _GEN_75 | _GEN_55 : _GEN_75 | _GEN_55)
      br_snapshots_12_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_95) begin
      if (_GEN_2[0])
        br_snapshots_12_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_12_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_12_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_12_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_12_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_12_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_12_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_12_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_12_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_12_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_12_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_12_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_12_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_12_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_12_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_12_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_12_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_12_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_12_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_12_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_12_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_12_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_12_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_12_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_12_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_12_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_12_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_12_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_12_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_12_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_12_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_12_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_12_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_12_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_12_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_12_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_12_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_12_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_12_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_12_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_12_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_12_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_12_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_12_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_12_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_12_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_12_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_12_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_12_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_12_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_12_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_12_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_12_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_12_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_12_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_12_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_12_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_12_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_12_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_12_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_12_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_12_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_12_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_12_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_12_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_12_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_12_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_12_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_12_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_12_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_12_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_12_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_12_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_12_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_12_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_12_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_12_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_12_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_12_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_12_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_12_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_12_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_12_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_12_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_12_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_12_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_12_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_12_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_12_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_12_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_12_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_12_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_12_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_12_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_12_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_12_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_12_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_12_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_12_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_12_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_12_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_12_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_12_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_12_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_12_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_12_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_12_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_12_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_12_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_12_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_12_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_12_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_12_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_12_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_12_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_12_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_12_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_12_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_12_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_12_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_12_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_12_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_12_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_12_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_31 <= map_table_31;
    end
    else if (_GEN_75) begin
      if (_GEN_1[0])
        br_snapshots_12_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_12_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_12_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_12_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_12_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_12_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_12_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_12_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_12_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_12_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_12_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_12_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_12_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_12_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_12_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_12_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_12_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_12_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_12_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_12_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_12_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_12_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_12_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_12_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_12_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_12_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_12_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_12_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_12_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_12_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_12_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_12_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_12_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_12_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_12_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_12_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_12_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_12_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_12_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_12_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_12_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_12_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_12_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_12_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_12_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_12_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_12_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_12_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_12_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_12_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_12_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_12_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_12_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_12_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_12_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_12_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_12_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_12_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_12_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_12_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_12_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_12_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_12_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_12_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_12_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_12_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_12_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_12_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_12_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_12_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_12_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_12_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_12_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_12_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_12_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_12_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_12_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_12_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_12_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_12_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_12_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_12_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_12_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_12_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_12_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_12_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_12_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_12_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_12_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_12_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_12_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_12_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_12_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_35) begin
      if (_GEN_0[0])
        br_snapshots_12_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_12_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_12_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_12_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_12_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_12_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_12_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_12_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_12_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_12_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_12_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_12_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_12_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_12_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_12_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_12_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_12_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_12_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_12_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_12_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_12_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_12_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_12_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_12_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_12_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_12_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_12_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_12_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_12_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_12_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_12_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_12_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_12_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_12_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_12_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_12_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_12_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_12_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_12_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_12_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_12_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_12_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_12_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_12_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_12_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_12_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_12_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_12_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_12_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_12_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_12_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_12_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_12_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_12_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_12_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_12_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_12_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_12_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_12_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_12_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_12_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_12_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_31 <= map_table_31;
    end
    else if (_GEN_15) begin
      if (_GEN[0])
        br_snapshots_12_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_12_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_12_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_12_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_12_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_12_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_12_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_12_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_12_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_12_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_12_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_12_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_12_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_12_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_12_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_12_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_12_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_12_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_12_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_12_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_12_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_12_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_12_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_12_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_12_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_12_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_12_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_12_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_12_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_12_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_12_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_12_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_96 | _GEN_76 | _GEN_56 : _GEN_76 | _GEN_56)
      br_snapshots_13_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_96) begin
      if (_GEN_2[0])
        br_snapshots_13_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_13_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_13_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_13_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_13_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_13_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_13_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_13_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_13_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_13_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_13_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_13_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_13_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_13_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_13_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_13_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_13_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_13_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_13_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_13_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_13_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_13_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_13_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_13_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_13_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_13_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_13_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_13_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_13_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_13_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_13_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_13_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_13_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_13_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_13_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_13_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_13_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_13_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_13_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_13_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_13_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_13_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_13_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_13_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_13_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_13_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_13_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_13_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_13_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_13_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_13_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_13_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_13_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_13_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_13_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_13_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_13_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_13_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_13_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_13_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_13_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_13_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_13_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_13_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_13_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_13_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_13_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_13_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_13_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_13_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_13_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_13_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_13_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_13_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_13_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_13_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_13_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_13_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_13_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_13_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_13_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_13_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_13_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_13_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_13_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_13_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_13_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_13_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_13_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_13_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_13_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_13_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_13_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_13_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_13_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_13_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_13_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_13_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_13_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_13_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_13_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_13_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_13_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_13_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_13_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_13_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_13_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_13_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_13_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_13_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_13_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_13_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_13_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_13_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_13_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_13_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_13_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_13_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_13_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_13_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_13_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_13_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_13_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_13_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_31 <= map_table_31;
    end
    else if (_GEN_76) begin
      if (_GEN_1[0])
        br_snapshots_13_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_13_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_13_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_13_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_13_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_13_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_13_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_13_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_13_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_13_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_13_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_13_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_13_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_13_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_13_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_13_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_13_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_13_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_13_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_13_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_13_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_13_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_13_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_13_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_13_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_13_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_13_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_13_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_13_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_13_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_13_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_13_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_13_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_13_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_13_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_13_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_13_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_13_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_13_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_13_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_13_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_13_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_13_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_13_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_13_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_13_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_13_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_13_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_13_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_13_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_13_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_13_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_13_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_13_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_13_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_13_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_13_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_13_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_13_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_13_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_13_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_13_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_13_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_13_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_13_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_13_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_13_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_13_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_13_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_13_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_13_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_13_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_13_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_13_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_13_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_13_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_13_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_13_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_13_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_13_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_13_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_13_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_13_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_13_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_13_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_13_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_13_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_13_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_13_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_13_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_13_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_13_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_13_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_36) begin
      if (_GEN_0[0])
        br_snapshots_13_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_13_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_13_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_13_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_13_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_13_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_13_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_13_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_13_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_13_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_13_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_13_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_13_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_13_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_13_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_13_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_13_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_13_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_13_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_13_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_13_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_13_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_13_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_13_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_13_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_13_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_13_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_13_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_13_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_13_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_13_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_13_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_13_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_13_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_13_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_13_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_13_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_13_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_13_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_13_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_13_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_13_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_13_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_13_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_13_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_13_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_13_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_13_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_13_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_13_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_13_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_13_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_13_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_13_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_13_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_13_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_13_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_13_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_13_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_13_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_13_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_13_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_31 <= map_table_31;
    end
    else if (_GEN_16) begin
      if (_GEN[0])
        br_snapshots_13_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_13_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_13_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_13_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_13_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_13_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_13_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_13_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_13_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_13_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_13_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_13_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_13_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_13_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_13_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_13_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_13_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_13_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_13_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_13_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_13_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_13_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_13_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_13_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_13_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_13_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_13_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_13_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_13_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_13_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_13_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_13_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_97 | _GEN_77 | _GEN_57 : _GEN_77 | _GEN_57)
      br_snapshots_14_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_97) begin
      if (_GEN_2[0])
        br_snapshots_14_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_14_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_14_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_14_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_14_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_14_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_14_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_14_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_14_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_14_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_14_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_14_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_14_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_14_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_14_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_14_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_14_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_14_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_14_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_14_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_14_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_14_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_14_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_14_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_14_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_14_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_14_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_14_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_14_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_14_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_14_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_14_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_14_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_14_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_14_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_14_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_14_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_14_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_14_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_14_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_14_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_14_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_14_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_14_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_14_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_14_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_14_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_14_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_14_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_14_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_14_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_14_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_14_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_14_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_14_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_14_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_14_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_14_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_14_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_14_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_14_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_14_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_14_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_14_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_14_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_14_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_14_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_14_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_14_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_14_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_14_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_14_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_14_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_14_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_14_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_14_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_14_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_14_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_14_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_14_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_14_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_14_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_14_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_14_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_14_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_14_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_14_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_14_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_14_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_14_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_14_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_14_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_14_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_14_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_14_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_14_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_14_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_14_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_14_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_14_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_14_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_14_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_14_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_14_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_14_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_14_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_14_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_14_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_14_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_14_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_14_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_14_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_14_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_14_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_14_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_14_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_14_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_14_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_14_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_14_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_14_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_14_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_14_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_14_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_31 <= map_table_31;
    end
    else if (_GEN_77) begin
      if (_GEN_1[0])
        br_snapshots_14_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_14_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_14_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_14_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_14_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_14_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_14_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_14_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_14_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_14_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_14_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_14_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_14_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_14_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_14_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_14_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_14_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_14_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_14_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_14_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_14_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_14_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_14_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_14_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_14_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_14_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_14_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_14_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_14_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_14_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_14_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_14_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_14_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_14_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_14_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_14_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_14_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_14_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_14_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_14_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_14_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_14_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_14_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_14_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_14_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_14_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_14_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_14_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_14_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_14_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_14_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_14_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_14_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_14_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_14_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_14_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_14_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_14_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_14_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_14_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_14_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_14_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_14_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_14_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_14_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_14_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_14_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_14_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_14_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_14_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_14_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_14_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_14_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_14_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_14_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_14_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_14_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_14_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_14_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_14_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_14_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_14_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_14_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_14_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_14_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_14_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_14_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_14_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_14_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_14_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_14_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_14_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_14_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_37) begin
      if (_GEN_0[0])
        br_snapshots_14_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_14_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_14_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_14_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_14_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_14_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_14_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_14_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_14_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_14_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_14_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_14_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_14_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_14_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_14_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_14_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_14_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_14_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_14_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_14_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_14_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_14_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_14_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_14_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_14_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_14_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_14_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_14_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_14_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_14_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_14_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_14_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_14_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_14_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_14_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_14_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_14_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_14_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_14_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_14_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_14_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_14_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_14_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_14_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_14_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_14_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_14_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_14_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_14_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_14_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_14_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_14_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_14_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_14_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_14_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_14_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_14_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_14_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_14_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_14_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_14_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_14_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_31 <= map_table_31;
    end
    else if (_GEN_17) begin
      if (_GEN[0])
        br_snapshots_14_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_14_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_14_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_14_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_14_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_14_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_14_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_14_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_14_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_14_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_14_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_14_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_14_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_14_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_14_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_14_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_14_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_14_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_14_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_14_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_14_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_14_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_14_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_14_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_14_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_14_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_14_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_14_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_14_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_14_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_14_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_14_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_98 | _GEN_78 | _GEN_58 : _GEN_78 | _GEN_58)
      br_snapshots_15_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_98) begin
      if (_GEN_2[0])
        br_snapshots_15_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_15_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_15_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_15_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_15_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_15_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_15_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_15_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_15_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_15_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_15_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_15_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_15_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_15_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_15_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_15_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_15_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_15_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_15_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_15_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_15_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_15_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_15_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_15_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_15_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_15_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_15_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_15_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_15_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_15_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_15_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_15_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_15_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_15_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_15_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_15_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_15_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_15_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_15_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_15_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_15_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_15_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_15_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_15_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_15_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_15_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_15_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_15_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_15_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_15_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_15_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_15_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_15_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_15_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_15_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_15_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_15_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_15_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_15_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_15_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_15_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_15_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_15_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_15_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_15_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_15_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_15_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_15_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_15_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_15_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_15_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_15_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_15_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_15_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_15_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_15_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_15_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_15_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_15_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_15_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_15_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_15_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_15_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_15_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_15_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_15_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_15_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_15_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_15_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_15_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_15_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_15_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_15_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_15_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_15_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_15_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_15_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_15_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_15_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_15_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_15_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_15_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_15_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_15_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_15_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_15_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_15_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_15_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_15_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_15_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_15_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_15_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_15_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_15_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_15_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_15_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_15_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_15_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_15_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_15_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_15_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_15_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_15_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_15_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_31 <= map_table_31;
    end
    else if (_GEN_78) begin
      if (_GEN_1[0])
        br_snapshots_15_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_15_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_15_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_15_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_15_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_15_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_15_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_15_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_15_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_15_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_15_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_15_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_15_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_15_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_15_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_15_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_15_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_15_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_15_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_15_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_15_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_15_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_15_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_15_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_15_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_15_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_15_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_15_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_15_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_15_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_15_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_15_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_15_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_15_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_15_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_15_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_15_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_15_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_15_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_15_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_15_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_15_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_15_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_15_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_15_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_15_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_15_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_15_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_15_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_15_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_15_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_15_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_15_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_15_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_15_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_15_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_15_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_15_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_15_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_15_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_15_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_15_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_15_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_15_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_15_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_15_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_15_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_15_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_15_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_15_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_15_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_15_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_15_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_15_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_15_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_15_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_15_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_15_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_15_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_15_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_15_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_15_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_15_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_15_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_15_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_15_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_15_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_15_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_15_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_15_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_15_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_15_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_15_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_38) begin
      if (_GEN_0[0])
        br_snapshots_15_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_15_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_15_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_15_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_15_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_15_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_15_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_15_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_15_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_15_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_15_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_15_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_15_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_15_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_15_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_15_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_15_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_15_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_15_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_15_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_15_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_15_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_15_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_15_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_15_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_15_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_15_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_15_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_15_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_15_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_15_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_15_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_15_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_15_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_15_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_15_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_15_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_15_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_15_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_15_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_15_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_15_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_15_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_15_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_15_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_15_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_15_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_15_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_15_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_15_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_15_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_15_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_15_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_15_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_15_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_15_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_15_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_15_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_15_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_15_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_15_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_15_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_31 <= map_table_31;
    end
    else if (_GEN_18) begin
      if (_GEN[0])
        br_snapshots_15_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_15_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_15_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_15_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_15_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_15_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_15_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_15_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_15_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_15_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_15_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_15_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_15_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_15_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_15_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_15_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_15_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_15_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_15_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_15_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_15_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_15_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_15_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_15_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_15_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_15_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_15_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_15_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_15_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_15_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_15_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_15_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_99 | _GEN_79 | _GEN_59 : _GEN_79 | _GEN_59)
      br_snapshots_16_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_99) begin
      if (_GEN_2[0])
        br_snapshots_16_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_16_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_16_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_16_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_16_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_16_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_16_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_16_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_16_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_16_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_16_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_16_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_16_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_16_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_16_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_16_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_16_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_16_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_16_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_16_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_16_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_16_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_16_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_16_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_16_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_16_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_16_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_16_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_16_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_16_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_16_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_16_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_16_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_16_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_16_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_16_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_16_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_16_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_16_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_16_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_16_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_16_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_16_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_16_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_16_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_16_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_16_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_16_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_16_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_16_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_16_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_16_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_16_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_16_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_16_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_16_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_16_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_16_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_16_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_16_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_16_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_16_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_16_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_16_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_16_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_16_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_16_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_16_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_16_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_16_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_16_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_16_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_16_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_16_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_16_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_16_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_16_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_16_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_16_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_16_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_16_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_16_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_16_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_16_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_16_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_16_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_16_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_16_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_16_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_16_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_16_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_16_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_16_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_16_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_16_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_16_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_16_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_16_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_16_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_16_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_16_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_16_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_16_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_16_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_16_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_16_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_16_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_16_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_16_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_16_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_16_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_16_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_16_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_16_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_16_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_16_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_16_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_16_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_16_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_16_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_16_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_16_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_16_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_16_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_31 <= map_table_31;
    end
    else if (_GEN_79) begin
      if (_GEN_1[0])
        br_snapshots_16_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_16_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_16_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_16_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_16_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_16_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_16_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_16_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_16_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_16_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_16_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_16_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_16_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_16_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_16_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_16_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_16_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_16_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_16_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_16_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_16_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_16_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_16_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_16_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_16_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_16_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_16_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_16_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_16_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_16_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_16_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_16_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_16_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_16_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_16_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_16_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_16_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_16_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_16_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_16_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_16_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_16_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_16_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_16_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_16_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_16_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_16_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_16_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_16_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_16_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_16_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_16_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_16_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_16_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_16_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_16_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_16_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_16_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_16_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_16_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_16_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_16_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_16_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_16_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_16_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_16_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_16_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_16_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_16_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_16_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_16_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_16_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_16_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_16_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_16_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_16_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_16_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_16_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_16_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_16_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_16_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_16_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_16_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_16_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_16_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_16_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_16_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_16_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_16_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_16_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_16_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_16_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_16_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_39) begin
      if (_GEN_0[0])
        br_snapshots_16_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_16_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_16_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_16_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_16_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_16_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_16_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_16_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_16_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_16_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_16_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_16_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_16_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_16_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_16_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_16_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_16_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_16_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_16_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_16_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_16_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_16_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_16_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_16_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_16_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_16_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_16_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_16_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_16_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_16_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_16_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_16_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_16_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_16_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_16_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_16_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_16_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_16_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_16_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_16_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_16_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_16_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_16_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_16_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_16_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_16_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_16_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_16_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_16_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_16_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_16_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_16_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_16_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_16_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_16_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_16_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_16_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_16_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_16_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_16_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_16_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_16_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_31 <= map_table_31;
    end
    else if (_GEN_19) begin
      if (_GEN[0])
        br_snapshots_16_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_16_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_16_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_16_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_16_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_16_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_16_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_16_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_16_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_16_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_16_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_16_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_16_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_16_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_16_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_16_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_16_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_16_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_16_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_16_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_16_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_16_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_16_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_16_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_16_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_16_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_16_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_16_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_16_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_16_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_16_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_16_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_100 | _GEN_80 | _GEN_60 : _GEN_80 | _GEN_60)
      br_snapshots_17_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_100) begin
      if (_GEN_2[0])
        br_snapshots_17_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_17_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_17_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_17_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_17_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_17_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_17_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_17_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_17_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_17_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_17_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_17_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_17_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_17_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_17_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_17_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_17_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_17_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_17_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_17_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_17_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_17_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_17_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_17_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_17_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_17_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_17_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_17_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_17_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_17_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_17_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_17_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_17_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_17_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_17_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_17_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_17_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_17_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_17_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_17_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_17_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_17_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_17_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_17_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_17_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_17_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_17_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_17_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_17_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_17_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_17_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_17_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_17_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_17_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_17_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_17_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_17_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_17_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_17_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_17_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_17_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_17_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_17_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_17_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_17_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_17_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_17_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_17_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_17_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_17_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_17_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_17_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_17_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_17_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_17_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_17_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_17_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_17_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_17_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_17_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_17_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_17_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_17_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_17_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_17_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_17_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_17_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_17_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_17_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_17_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_17_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_17_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_17_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_17_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_17_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_17_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_17_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_17_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_17_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_17_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_17_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_17_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_17_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_17_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_17_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_17_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_17_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_17_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_17_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_17_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_17_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_17_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_17_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_17_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_17_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_17_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_17_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_17_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_17_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_17_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_17_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_17_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_17_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_17_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_31 <= map_table_31;
    end
    else if (_GEN_80) begin
      if (_GEN_1[0])
        br_snapshots_17_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_17_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_17_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_17_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_17_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_17_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_17_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_17_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_17_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_17_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_17_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_17_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_17_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_17_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_17_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_17_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_17_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_17_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_17_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_17_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_17_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_17_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_17_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_17_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_17_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_17_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_17_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_17_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_17_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_17_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_17_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_17_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_17_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_17_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_17_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_17_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_17_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_17_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_17_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_17_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_17_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_17_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_17_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_17_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_17_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_17_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_17_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_17_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_17_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_17_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_17_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_17_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_17_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_17_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_17_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_17_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_17_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_17_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_17_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_17_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_17_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_17_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_17_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_17_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_17_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_17_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_17_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_17_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_17_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_17_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_17_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_17_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_17_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_17_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_17_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_17_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_17_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_17_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_17_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_17_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_17_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_17_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_17_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_17_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_17_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_17_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_17_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_17_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_17_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_17_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_17_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_17_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_17_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_40) begin
      if (_GEN_0[0])
        br_snapshots_17_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_17_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_17_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_17_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_17_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_17_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_17_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_17_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_17_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_17_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_17_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_17_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_17_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_17_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_17_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_17_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_17_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_17_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_17_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_17_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_17_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_17_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_17_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_17_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_17_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_17_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_17_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_17_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_17_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_17_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_17_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_17_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_17_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_17_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_17_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_17_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_17_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_17_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_17_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_17_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_17_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_17_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_17_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_17_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_17_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_17_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_17_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_17_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_17_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_17_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_17_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_17_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_17_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_17_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_17_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_17_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_17_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_17_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_17_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_17_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_17_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_17_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_31 <= map_table_31;
    end
    else if (_GEN_20) begin
      if (_GEN[0])
        br_snapshots_17_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_17_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_17_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_17_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_17_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_17_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_17_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_17_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_17_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_17_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_17_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_17_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_17_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_17_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_17_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_17_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_17_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_17_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_17_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_17_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_17_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_17_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_17_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_17_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_17_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_17_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_17_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_17_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_17_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_17_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_17_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_17_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_101 | _GEN_81 | _GEN_61 : _GEN_81 | _GEN_61)
      br_snapshots_18_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_101) begin
      if (_GEN_2[0])
        br_snapshots_18_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_18_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_18_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_18_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_18_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_18_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_18_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_18_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_18_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_18_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_18_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_18_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_18_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_18_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_18_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_18_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_18_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_18_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_18_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_18_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_18_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_18_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_18_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_18_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_18_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_18_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_18_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_18_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_18_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_18_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_18_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_18_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_18_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_18_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_18_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_18_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_18_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_18_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_18_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_18_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_18_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_18_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_18_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_18_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_18_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_18_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_18_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_18_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_18_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_18_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_18_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_18_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_18_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_18_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_18_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_18_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_18_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_18_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_18_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_18_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_18_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_18_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_18_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_18_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_18_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_18_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_18_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_18_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_18_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_18_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_18_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_18_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_18_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_18_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_18_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_18_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_18_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_18_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_18_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_18_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_18_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_18_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_18_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_18_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_18_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_18_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_18_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_18_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_18_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_18_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_18_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_18_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_18_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_18_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_18_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_18_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_18_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_18_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_18_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_18_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_18_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_18_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_18_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_18_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_18_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_18_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_18_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_18_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_18_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_18_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_18_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_18_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_18_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_18_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_18_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_18_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_18_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_18_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_18_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_18_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_18_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_18_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_18_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_18_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_31 <= map_table_31;
    end
    else if (_GEN_81) begin
      if (_GEN_1[0])
        br_snapshots_18_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_18_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_18_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_18_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_18_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_18_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_18_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_18_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_18_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_18_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_18_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_18_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_18_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_18_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_18_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_18_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_18_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_18_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_18_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_18_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_18_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_18_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_18_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_18_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_18_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_18_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_18_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_18_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_18_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_18_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_18_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_18_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_18_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_18_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_18_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_18_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_18_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_18_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_18_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_18_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_18_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_18_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_18_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_18_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_18_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_18_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_18_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_18_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_18_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_18_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_18_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_18_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_18_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_18_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_18_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_18_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_18_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_18_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_18_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_18_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_18_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_18_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_18_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_18_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_18_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_18_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_18_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_18_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_18_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_18_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_18_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_18_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_18_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_18_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_18_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_18_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_18_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_18_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_18_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_18_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_18_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_18_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_18_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_18_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_18_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_18_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_18_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_18_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_18_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_18_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_18_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_18_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_18_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_41) begin
      if (_GEN_0[0])
        br_snapshots_18_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_18_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_18_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_18_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_18_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_18_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_18_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_18_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_18_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_18_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_18_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_18_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_18_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_18_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_18_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_18_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_18_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_18_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_18_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_18_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_18_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_18_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_18_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_18_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_18_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_18_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_18_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_18_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_18_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_18_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_18_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_18_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_18_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_18_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_18_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_18_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_18_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_18_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_18_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_18_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_18_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_18_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_18_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_18_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_18_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_18_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_18_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_18_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_18_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_18_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_18_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_18_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_18_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_18_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_18_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_18_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_18_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_18_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_18_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_18_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_18_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_18_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_31 <= map_table_31;
    end
    else if (_GEN_21) begin
      if (_GEN[0])
        br_snapshots_18_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_18_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_18_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_18_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_18_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_18_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_18_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_18_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_18_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_18_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_18_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_18_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_18_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_18_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_18_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_18_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_18_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_18_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_18_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_18_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_18_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_18_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_18_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_18_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_18_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_18_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_18_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_18_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_18_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_18_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_18_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_18_31 <= map_table_31;
    end
    if (io_ren_br_tags_3_valid ? _GEN_102 | _GEN_82 | _GEN_62 : _GEN_82 | _GEN_62)
      br_snapshots_19_0 <= 7'h0;
    if (io_ren_br_tags_3_valid & _GEN_102) begin
      if (_GEN_2[0])
        br_snapshots_19_1 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[0])
        br_snapshots_19_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_19_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_19_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_1 <= map_table_1;
      if (_GEN_2[1])
        br_snapshots_19_2 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[1])
        br_snapshots_19_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_19_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_19_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_2 <= map_table_2;
      if (_GEN_2[2])
        br_snapshots_19_3 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[2])
        br_snapshots_19_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_19_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_19_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_3 <= map_table_3;
      if (_GEN_2[3])
        br_snapshots_19_4 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[3])
        br_snapshots_19_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_19_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_19_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_4 <= map_table_4;
      if (_GEN_2[4])
        br_snapshots_19_5 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[4])
        br_snapshots_19_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_19_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_19_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_5 <= map_table_5;
      if (_GEN_2[5])
        br_snapshots_19_6 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[5])
        br_snapshots_19_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_19_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_19_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_6 <= map_table_6;
      if (_GEN_2[6])
        br_snapshots_19_7 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[6])
        br_snapshots_19_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_19_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_19_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_7 <= map_table_7;
      if (_GEN_2[7])
        br_snapshots_19_8 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[7])
        br_snapshots_19_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_19_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_19_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_8 <= map_table_8;
      if (_GEN_2[8])
        br_snapshots_19_9 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[8])
        br_snapshots_19_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_19_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_19_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_9 <= map_table_9;
      if (_GEN_2[9])
        br_snapshots_19_10 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[9])
        br_snapshots_19_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_19_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_19_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_10 <= map_table_10;
      if (_GEN_2[10])
        br_snapshots_19_11 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[10])
        br_snapshots_19_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_19_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_19_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_11 <= map_table_11;
      if (_GEN_2[11])
        br_snapshots_19_12 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[11])
        br_snapshots_19_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_19_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_19_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_12 <= map_table_12;
      if (_GEN_2[12])
        br_snapshots_19_13 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[12])
        br_snapshots_19_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_19_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_19_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_13 <= map_table_13;
      if (_GEN_2[13])
        br_snapshots_19_14 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[13])
        br_snapshots_19_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_19_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_19_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_14 <= map_table_14;
      if (_GEN_2[14])
        br_snapshots_19_15 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[14])
        br_snapshots_19_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_19_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_19_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_15 <= map_table_15;
      if (_GEN_2[15])
        br_snapshots_19_16 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[15])
        br_snapshots_19_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_19_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_19_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_16 <= map_table_16;
      if (_GEN_2[16])
        br_snapshots_19_17 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[16])
        br_snapshots_19_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_19_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_19_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_17 <= map_table_17;
      if (_GEN_2[17])
        br_snapshots_19_18 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[17])
        br_snapshots_19_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_19_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_19_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_18 <= map_table_18;
      if (_GEN_2[18])
        br_snapshots_19_19 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[18])
        br_snapshots_19_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_19_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_19_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_19 <= map_table_19;
      if (_GEN_2[19])
        br_snapshots_19_20 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[19])
        br_snapshots_19_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_19_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_19_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_20 <= map_table_20;
      if (_GEN_2[20])
        br_snapshots_19_21 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[20])
        br_snapshots_19_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_19_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_19_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_21 <= map_table_21;
      if (_GEN_2[21])
        br_snapshots_19_22 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[21])
        br_snapshots_19_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_19_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_19_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_22 <= map_table_22;
      if (_GEN_2[22])
        br_snapshots_19_23 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[22])
        br_snapshots_19_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_19_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_19_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_23 <= map_table_23;
      if (_GEN_2[23])
        br_snapshots_19_24 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[23])
        br_snapshots_19_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_19_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_19_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_24 <= map_table_24;
      if (_GEN_2[24])
        br_snapshots_19_25 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[24])
        br_snapshots_19_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_19_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_19_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_25 <= map_table_25;
      if (_GEN_2[25])
        br_snapshots_19_26 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[25])
        br_snapshots_19_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_19_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_19_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_26 <= map_table_26;
      if (_GEN_2[26])
        br_snapshots_19_27 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[26])
        br_snapshots_19_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_19_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_19_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_27 <= map_table_27;
      if (_GEN_2[27])
        br_snapshots_19_28 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[27])
        br_snapshots_19_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_19_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_19_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_28 <= map_table_28;
      if (_GEN_2[28])
        br_snapshots_19_29 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[28])
        br_snapshots_19_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_19_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_19_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_29 <= map_table_29;
      if (_GEN_2[29])
        br_snapshots_19_30 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[29])
        br_snapshots_19_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_19_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_19_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_30 <= map_table_30;
      if (_GEN_2[30])
        br_snapshots_19_31 <= io_remap_reqs_3_pdst;
      else if (_GEN_1[30])
        br_snapshots_19_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_19_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_19_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_31 <= map_table_31;
    end
    else if (_GEN_82) begin
      if (_GEN_1[0])
        br_snapshots_19_1 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[0])
        br_snapshots_19_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_19_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_1 <= map_table_1;
      if (_GEN_1[1])
        br_snapshots_19_2 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[1])
        br_snapshots_19_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_19_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_2 <= map_table_2;
      if (_GEN_1[2])
        br_snapshots_19_3 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[2])
        br_snapshots_19_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_19_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_3 <= map_table_3;
      if (_GEN_1[3])
        br_snapshots_19_4 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[3])
        br_snapshots_19_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_19_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_4 <= map_table_4;
      if (_GEN_1[4])
        br_snapshots_19_5 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[4])
        br_snapshots_19_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_19_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_5 <= map_table_5;
      if (_GEN_1[5])
        br_snapshots_19_6 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[5])
        br_snapshots_19_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_19_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_6 <= map_table_6;
      if (_GEN_1[6])
        br_snapshots_19_7 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[6])
        br_snapshots_19_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_19_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_7 <= map_table_7;
      if (_GEN_1[7])
        br_snapshots_19_8 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[7])
        br_snapshots_19_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_19_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_8 <= map_table_8;
      if (_GEN_1[8])
        br_snapshots_19_9 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[8])
        br_snapshots_19_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_19_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_9 <= map_table_9;
      if (_GEN_1[9])
        br_snapshots_19_10 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[9])
        br_snapshots_19_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_19_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_10 <= map_table_10;
      if (_GEN_1[10])
        br_snapshots_19_11 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[10])
        br_snapshots_19_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_19_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_11 <= map_table_11;
      if (_GEN_1[11])
        br_snapshots_19_12 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[11])
        br_snapshots_19_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_19_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_12 <= map_table_12;
      if (_GEN_1[12])
        br_snapshots_19_13 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[12])
        br_snapshots_19_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_19_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_13 <= map_table_13;
      if (_GEN_1[13])
        br_snapshots_19_14 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[13])
        br_snapshots_19_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_19_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_14 <= map_table_14;
      if (_GEN_1[14])
        br_snapshots_19_15 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[14])
        br_snapshots_19_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_19_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_15 <= map_table_15;
      if (_GEN_1[15])
        br_snapshots_19_16 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[15])
        br_snapshots_19_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_19_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_16 <= map_table_16;
      if (_GEN_1[16])
        br_snapshots_19_17 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[16])
        br_snapshots_19_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_19_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_17 <= map_table_17;
      if (_GEN_1[17])
        br_snapshots_19_18 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[17])
        br_snapshots_19_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_19_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_18 <= map_table_18;
      if (_GEN_1[18])
        br_snapshots_19_19 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[18])
        br_snapshots_19_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_19_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_19 <= map_table_19;
      if (_GEN_1[19])
        br_snapshots_19_20 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[19])
        br_snapshots_19_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_19_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_20 <= map_table_20;
      if (_GEN_1[20])
        br_snapshots_19_21 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[20])
        br_snapshots_19_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_19_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_21 <= map_table_21;
      if (_GEN_1[21])
        br_snapshots_19_22 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[21])
        br_snapshots_19_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_19_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_22 <= map_table_22;
      if (_GEN_1[22])
        br_snapshots_19_23 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[22])
        br_snapshots_19_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_19_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_23 <= map_table_23;
      if (_GEN_1[23])
        br_snapshots_19_24 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[23])
        br_snapshots_19_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_19_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_24 <= map_table_24;
      if (_GEN_1[24])
        br_snapshots_19_25 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[24])
        br_snapshots_19_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_19_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_25 <= map_table_25;
      if (_GEN_1[25])
        br_snapshots_19_26 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[25])
        br_snapshots_19_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_19_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_26 <= map_table_26;
      if (_GEN_1[26])
        br_snapshots_19_27 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[26])
        br_snapshots_19_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_19_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_27 <= map_table_27;
      if (_GEN_1[27])
        br_snapshots_19_28 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[27])
        br_snapshots_19_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_19_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_28 <= map_table_28;
      if (_GEN_1[28])
        br_snapshots_19_29 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[28])
        br_snapshots_19_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_19_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_29 <= map_table_29;
      if (_GEN_1[29])
        br_snapshots_19_30 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[29])
        br_snapshots_19_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_19_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_30 <= map_table_30;
      if (_GEN_1[30])
        br_snapshots_19_31 <= io_remap_reqs_2_pdst;
      else if (_GEN_0[30])
        br_snapshots_19_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_19_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_31 <= map_table_31;
    end
    else if (io_ren_br_tags_1_valid & _GEN_42) begin
      if (_GEN_0[0])
        br_snapshots_19_1 <= io_remap_reqs_1_pdst;
      else if (_GEN[0])
        br_snapshots_19_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_1 <= map_table_1;
      if (_GEN_0[1])
        br_snapshots_19_2 <= io_remap_reqs_1_pdst;
      else if (_GEN[1])
        br_snapshots_19_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_2 <= map_table_2;
      if (_GEN_0[2])
        br_snapshots_19_3 <= io_remap_reqs_1_pdst;
      else if (_GEN[2])
        br_snapshots_19_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_3 <= map_table_3;
      if (_GEN_0[3])
        br_snapshots_19_4 <= io_remap_reqs_1_pdst;
      else if (_GEN[3])
        br_snapshots_19_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_4 <= map_table_4;
      if (_GEN_0[4])
        br_snapshots_19_5 <= io_remap_reqs_1_pdst;
      else if (_GEN[4])
        br_snapshots_19_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_5 <= map_table_5;
      if (_GEN_0[5])
        br_snapshots_19_6 <= io_remap_reqs_1_pdst;
      else if (_GEN[5])
        br_snapshots_19_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_6 <= map_table_6;
      if (_GEN_0[6])
        br_snapshots_19_7 <= io_remap_reqs_1_pdst;
      else if (_GEN[6])
        br_snapshots_19_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_7 <= map_table_7;
      if (_GEN_0[7])
        br_snapshots_19_8 <= io_remap_reqs_1_pdst;
      else if (_GEN[7])
        br_snapshots_19_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_8 <= map_table_8;
      if (_GEN_0[8])
        br_snapshots_19_9 <= io_remap_reqs_1_pdst;
      else if (_GEN[8])
        br_snapshots_19_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_9 <= map_table_9;
      if (_GEN_0[9])
        br_snapshots_19_10 <= io_remap_reqs_1_pdst;
      else if (_GEN[9])
        br_snapshots_19_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_10 <= map_table_10;
      if (_GEN_0[10])
        br_snapshots_19_11 <= io_remap_reqs_1_pdst;
      else if (_GEN[10])
        br_snapshots_19_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_11 <= map_table_11;
      if (_GEN_0[11])
        br_snapshots_19_12 <= io_remap_reqs_1_pdst;
      else if (_GEN[11])
        br_snapshots_19_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_12 <= map_table_12;
      if (_GEN_0[12])
        br_snapshots_19_13 <= io_remap_reqs_1_pdst;
      else if (_GEN[12])
        br_snapshots_19_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_13 <= map_table_13;
      if (_GEN_0[13])
        br_snapshots_19_14 <= io_remap_reqs_1_pdst;
      else if (_GEN[13])
        br_snapshots_19_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_14 <= map_table_14;
      if (_GEN_0[14])
        br_snapshots_19_15 <= io_remap_reqs_1_pdst;
      else if (_GEN[14])
        br_snapshots_19_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_15 <= map_table_15;
      if (_GEN_0[15])
        br_snapshots_19_16 <= io_remap_reqs_1_pdst;
      else if (_GEN[15])
        br_snapshots_19_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_16 <= map_table_16;
      if (_GEN_0[16])
        br_snapshots_19_17 <= io_remap_reqs_1_pdst;
      else if (_GEN[16])
        br_snapshots_19_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_17 <= map_table_17;
      if (_GEN_0[17])
        br_snapshots_19_18 <= io_remap_reqs_1_pdst;
      else if (_GEN[17])
        br_snapshots_19_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_18 <= map_table_18;
      if (_GEN_0[18])
        br_snapshots_19_19 <= io_remap_reqs_1_pdst;
      else if (_GEN[18])
        br_snapshots_19_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_19 <= map_table_19;
      if (_GEN_0[19])
        br_snapshots_19_20 <= io_remap_reqs_1_pdst;
      else if (_GEN[19])
        br_snapshots_19_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_20 <= map_table_20;
      if (_GEN_0[20])
        br_snapshots_19_21 <= io_remap_reqs_1_pdst;
      else if (_GEN[20])
        br_snapshots_19_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_21 <= map_table_21;
      if (_GEN_0[21])
        br_snapshots_19_22 <= io_remap_reqs_1_pdst;
      else if (_GEN[21])
        br_snapshots_19_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_22 <= map_table_22;
      if (_GEN_0[22])
        br_snapshots_19_23 <= io_remap_reqs_1_pdst;
      else if (_GEN[22])
        br_snapshots_19_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_23 <= map_table_23;
      if (_GEN_0[23])
        br_snapshots_19_24 <= io_remap_reqs_1_pdst;
      else if (_GEN[23])
        br_snapshots_19_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_24 <= map_table_24;
      if (_GEN_0[24])
        br_snapshots_19_25 <= io_remap_reqs_1_pdst;
      else if (_GEN[24])
        br_snapshots_19_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_25 <= map_table_25;
      if (_GEN_0[25])
        br_snapshots_19_26 <= io_remap_reqs_1_pdst;
      else if (_GEN[25])
        br_snapshots_19_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_26 <= map_table_26;
      if (_GEN_0[26])
        br_snapshots_19_27 <= io_remap_reqs_1_pdst;
      else if (_GEN[26])
        br_snapshots_19_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_27 <= map_table_27;
      if (_GEN_0[27])
        br_snapshots_19_28 <= io_remap_reqs_1_pdst;
      else if (_GEN[27])
        br_snapshots_19_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_28 <= map_table_28;
      if (_GEN_0[28])
        br_snapshots_19_29 <= io_remap_reqs_1_pdst;
      else if (_GEN[28])
        br_snapshots_19_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_29 <= map_table_29;
      if (_GEN_0[29])
        br_snapshots_19_30 <= io_remap_reqs_1_pdst;
      else if (_GEN[29])
        br_snapshots_19_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_30 <= map_table_30;
      if (_GEN_0[30])
        br_snapshots_19_31 <= io_remap_reqs_1_pdst;
      else if (_GEN[30])
        br_snapshots_19_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_31 <= map_table_31;
    end
    else if (_GEN_22) begin
      if (_GEN[0])
        br_snapshots_19_1 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_1 <= map_table_1;
      if (_GEN[1])
        br_snapshots_19_2 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_2 <= map_table_2;
      if (_GEN[2])
        br_snapshots_19_3 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_3 <= map_table_3;
      if (_GEN[3])
        br_snapshots_19_4 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_4 <= map_table_4;
      if (_GEN[4])
        br_snapshots_19_5 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_5 <= map_table_5;
      if (_GEN[5])
        br_snapshots_19_6 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_6 <= map_table_6;
      if (_GEN[6])
        br_snapshots_19_7 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_7 <= map_table_7;
      if (_GEN[7])
        br_snapshots_19_8 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_8 <= map_table_8;
      if (_GEN[8])
        br_snapshots_19_9 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_9 <= map_table_9;
      if (_GEN[9])
        br_snapshots_19_10 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_10 <= map_table_10;
      if (_GEN[10])
        br_snapshots_19_11 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_11 <= map_table_11;
      if (_GEN[11])
        br_snapshots_19_12 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_12 <= map_table_12;
      if (_GEN[12])
        br_snapshots_19_13 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_13 <= map_table_13;
      if (_GEN[13])
        br_snapshots_19_14 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_14 <= map_table_14;
      if (_GEN[14])
        br_snapshots_19_15 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_15 <= map_table_15;
      if (_GEN[15])
        br_snapshots_19_16 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_16 <= map_table_16;
      if (_GEN[16])
        br_snapshots_19_17 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_17 <= map_table_17;
      if (_GEN[17])
        br_snapshots_19_18 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_18 <= map_table_18;
      if (_GEN[18])
        br_snapshots_19_19 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_19 <= map_table_19;
      if (_GEN[19])
        br_snapshots_19_20 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_20 <= map_table_20;
      if (_GEN[20])
        br_snapshots_19_21 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_21 <= map_table_21;
      if (_GEN[21])
        br_snapshots_19_22 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_22 <= map_table_22;
      if (_GEN[22])
        br_snapshots_19_23 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_23 <= map_table_23;
      if (_GEN[23])
        br_snapshots_19_24 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_24 <= map_table_24;
      if (_GEN[24])
        br_snapshots_19_25 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_25 <= map_table_25;
      if (_GEN[25])
        br_snapshots_19_26 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_26 <= map_table_26;
      if (_GEN[26])
        br_snapshots_19_27 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_27 <= map_table_27;
      if (_GEN[27])
        br_snapshots_19_28 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_28 <= map_table_28;
      if (_GEN[28])
        br_snapshots_19_29 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_29 <= map_table_29;
      if (_GEN[29])
        br_snapshots_19_30 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_30 <= map_table_30;
      if (_GEN[30])
        br_snapshots_19_31 <= io_remap_reqs_0_pdst;
      else
        br_snapshots_19_31 <= map_table_31;
    end
  end // always @(posedge)
  assign io_map_resps_0_prs1 = casez_tmp;
  assign io_map_resps_0_prs2 = casez_tmp_0;
  assign io_map_resps_0_stale_pdst = casez_tmp_1;
  assign io_map_resps_1_prs1 = casez_tmp_2;
  assign io_map_resps_1_prs2 = casez_tmp_3;
  assign io_map_resps_1_stale_pdst = casez_tmp_4;
  assign io_map_resps_2_prs1 = casez_tmp_5;
  assign io_map_resps_2_prs2 = casez_tmp_6;
  assign io_map_resps_2_stale_pdst = casez_tmp_7;
  assign io_map_resps_3_prs1 = casez_tmp_8;
  assign io_map_resps_3_prs2 = casez_tmp_9;
  assign io_map_resps_3_stale_pdst = casez_tmp_10;
endmodule

