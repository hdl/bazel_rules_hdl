// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RenameFreeList(
  input        clock,
               reset,
               io_reqs_0,
               io_reqs_1,
               io_reqs_2,
               io_reqs_3,
               io_dealloc_pregs_0_valid,
  input  [6:0] io_dealloc_pregs_0_bits,
  input        io_dealloc_pregs_1_valid,
  input  [6:0] io_dealloc_pregs_1_bits,
  input        io_dealloc_pregs_2_valid,
  input  [6:0] io_dealloc_pregs_2_bits,
  input        io_dealloc_pregs_3_valid,
  input  [6:0] io_dealloc_pregs_3_bits,
  input        io_ren_br_tags_0_valid,
  input  [4:0] io_ren_br_tags_0_bits,
  input        io_ren_br_tags_1_valid,
  input  [4:0] io_ren_br_tags_1_bits,
  input        io_ren_br_tags_2_valid,
  input  [4:0] io_ren_br_tags_2_bits,
  input        io_ren_br_tags_3_valid,
  input  [4:0] io_ren_br_tags_3_bits,
               io_brupdate_b2_uop_br_tag,
  input        io_brupdate_b2_mispredict,
               io_debug_pipeline_empty,
  output       io_alloc_pregs_0_valid,
  output [6:0] io_alloc_pregs_0_bits,
  output       io_alloc_pregs_1_valid,
  output [6:0] io_alloc_pregs_1_bits,
  output       io_alloc_pregs_2_valid,
  output [6:0] io_alloc_pregs_2_bits,
  output       io_alloc_pregs_3_valid,
  output [6:0] io_alloc_pregs_3_bits
);

  reg  [6:0]   r_sel_3;
  reg  [6:0]   r_sel_2;
  reg  [6:0]   r_sel_1;
  reg  [6:0]   r_sel;
  reg  [127:0] free_list;
  reg  [127:0] br_alloc_lists_0;
  reg  [127:0] br_alloc_lists_1;
  reg  [127:0] br_alloc_lists_2;
  reg  [127:0] br_alloc_lists_3;
  reg  [127:0] br_alloc_lists_4;
  reg  [127:0] br_alloc_lists_5;
  reg  [127:0] br_alloc_lists_6;
  reg  [127:0] br_alloc_lists_7;
  reg  [127:0] br_alloc_lists_8;
  reg  [127:0] br_alloc_lists_9;
  reg  [127:0] br_alloc_lists_10;
  reg  [127:0] br_alloc_lists_11;
  reg  [127:0] br_alloc_lists_12;
  reg  [127:0] br_alloc_lists_13;
  reg  [127:0] br_alloc_lists_14;
  reg  [127:0] br_alloc_lists_15;
  reg  [127:0] br_alloc_lists_16;
  reg  [127:0] br_alloc_lists_17;
  reg  [127:0] br_alloc_lists_18;
  reg  [127:0] br_alloc_lists_19;
  wire [127:0] allocs_0 = 128'h1 << r_sel;
  wire [127:0] allocs_1 = 128'h1 << r_sel_1;
  wire [127:0] allocs_2 = 128'h1 << r_sel_2;
  wire [127:0] allocs_3 = 128'h1 << r_sel_3;
  reg          r_valid;
  reg          r_valid_1;
  reg          r_valid_2;
  reg          r_valid_3;
  wire [127:0] br_deallocs = (io_brupdate_b2_uop_br_tag == 5'h13 ? br_alloc_lists_19 : io_brupdate_b2_uop_br_tag == 5'h12 ? br_alloc_lists_18 : io_brupdate_b2_uop_br_tag == 5'h11 ? br_alloc_lists_17 : io_brupdate_b2_uop_br_tag == 5'h10 ? br_alloc_lists_16 : io_brupdate_b2_uop_br_tag == 5'hF ? br_alloc_lists_15 : io_brupdate_b2_uop_br_tag == 5'hE ? br_alloc_lists_14 : io_brupdate_b2_uop_br_tag == 5'hD ? br_alloc_lists_13 : io_brupdate_b2_uop_br_tag == 5'hC ? br_alloc_lists_12 : io_brupdate_b2_uop_br_tag == 5'hB ? br_alloc_lists_11 : io_brupdate_b2_uop_br_tag == 5'hA ? br_alloc_lists_10 : io_brupdate_b2_uop_br_tag == 5'h9 ? br_alloc_lists_9 : io_brupdate_b2_uop_br_tag == 5'h8 ? br_alloc_lists_8 : io_brupdate_b2_uop_br_tag == 5'h7 ? br_alloc_lists_7 : io_brupdate_b2_uop_br_tag == 5'h6 ? br_alloc_lists_6 : io_brupdate_b2_uop_br_tag == 5'h5 ? br_alloc_lists_5 : io_brupdate_b2_uop_br_tag == 5'h4 ? br_alloc_lists_4 : io_brupdate_b2_uop_br_tag == 5'h3 ? br_alloc_lists_3 : io_brupdate_b2_uop_br_tag == 5'h2 ? br_alloc_lists_2 : io_brupdate_b2_uop_br_tag == 5'h1 ? br_alloc_lists_1 : br_alloc_lists_0) & {128{io_brupdate_b2_mispredict}};
  wire [127:0] dealloc_mask = 128'h1 << io_dealloc_pregs_0_bits & {128{io_dealloc_pregs_0_valid}} | 128'h1 << io_dealloc_pregs_1_bits & {128{io_dealloc_pregs_1_valid}} | 128'h1 << io_dealloc_pregs_2_bits & {128{io_dealloc_pregs_2_valid}} | 128'h1 << io_dealloc_pregs_3_bits & {128{io_dealloc_pregs_3_valid}} | br_deallocs;
  wire [127:0] sels_0 =
    free_list[0]
      ? 128'h1
      : free_list[1]
          ? 128'h2
          : free_list[2]
              ? 128'h4
              : free_list[3]
                  ? 128'h8
                  : free_list[4]
                      ? 128'h10
                      : free_list[5]
                          ? 128'h20
                          : free_list[6]
                              ? 128'h40
                              : free_list[7]
                                  ? 128'h80
                                  : free_list[8]
                                      ? 128'h100
                                      : free_list[9]
                                          ? 128'h200
                                          : free_list[10]
                                              ? 128'h400
                                              : free_list[11]
                                                  ? 128'h800
                                                  : free_list[12]
                                                      ? 128'h1000
                                                      : free_list[13]
                                                          ? 128'h2000
                                                          : free_list[14]
                                                              ? 128'h4000
                                                              : free_list[15]
                                                                  ? 128'h8000
                                                                  : free_list[16]
                                                                      ? 128'h10000
                                                                      : free_list[17]
                                                                          ? 128'h20000
                                                                          : free_list[18]
                                                                              ? 128'h40000
                                                                              : free_list[19]
                                                                                  ? 128'h80000
                                                                                  : free_list[20]
                                                                                      ? 128'h100000
                                                                                      : free_list[21]
                                                                                          ? 128'h200000
                                                                                          : free_list[22]
                                                                                              ? 128'h400000
                                                                                              : free_list[23]
                                                                                                  ? 128'h800000
                                                                                                  : free_list[24]
                                                                                                      ? 128'h1000000
                                                                                                      : free_list[25]
                                                                                                          ? 128'h2000000
                                                                                                          : free_list[26]
                                                                                                              ? 128'h4000000
                                                                                                              : free_list[27]
                                                                                                                  ? 128'h8000000
                                                                                                                  : free_list[28]
                                                                                                                      ? 128'h10000000
                                                                                                                      : free_list[29]
                                                                                                                          ? 128'h20000000
                                                                                                                          : free_list[30]
                                                                                                                              ? 128'h40000000
                                                                                                                              : free_list[31]
                                                                                                                                  ? 128'h80000000
                                                                                                                                  : free_list[32]
                                                                                                                                      ? 128'h100000000
                                                                                                                                      : free_list[33]
                                                                                                                                          ? 128'h200000000
                                                                                                                                          : free_list[34]
                                                                                                                                              ? 128'h400000000
                                                                                                                                              : free_list[35]
                                                                                                                                                  ? 128'h800000000
                                                                                                                                                  : free_list[36]
                                                                                                                                                      ? 128'h1000000000
                                                                                                                                                      : free_list[37]
                                                                                                                                                          ? 128'h2000000000
                                                                                                                                                          : free_list[38]
                                                                                                                                                              ? 128'h4000000000
                                                                                                                                                              : free_list[39]
                                                                                                                                                                  ? 128'h8000000000
                                                                                                                                                                  : free_list[40]
                                                                                                                                                                      ? 128'h10000000000
                                                                                                                                                                      : free_list[41]
                                                                                                                                                                          ? 128'h20000000000
                                                                                                                                                                          : free_list[42]
                                                                                                                                                                              ? 128'h40000000000
                                                                                                                                                                              : free_list[43]
                                                                                                                                                                                  ? 128'h80000000000
                                                                                                                                                                                  : free_list[44]
                                                                                                                                                                                      ? 128'h100000000000
                                                                                                                                                                                      : free_list[45]
                                                                                                                                                                                          ? 128'h200000000000
                                                                                                                                                                                          : free_list[46]
                                                                                                                                                                                              ? 128'h400000000000
                                                                                                                                                                                              : free_list[47]
                                                                                                                                                                                                  ? 128'h800000000000
                                                                                                                                                                                                  : free_list[48]
                                                                                                                                                                                                      ? 128'h1000000000000
                                                                                                                                                                                                      : free_list[49]
                                                                                                                                                                                                          ? 128'h2000000000000
                                                                                                                                                                                                          : free_list[50]
                                                                                                                                                                                                              ? 128'h4000000000000
                                                                                                                                                                                                              : free_list[51]
                                                                                                                                                                                                                  ? 128'h8000000000000
                                                                                                                                                                                                                  : free_list[52]
                                                                                                                                                                                                                      ? 128'h10000000000000
                                                                                                                                                                                                                      : free_list[53]
                                                                                                                                                                                                                          ? 128'h20000000000000
                                                                                                                                                                                                                          : free_list[54]
                                                                                                                                                                                                                              ? 128'h40000000000000
                                                                                                                                                                                                                              : free_list[55]
                                                                                                                                                                                                                                  ? 128'h80000000000000
                                                                                                                                                                                                                                  : free_list[56]
                                                                                                                                                                                                                                      ? 128'h100000000000000
                                                                                                                                                                                                                                      : free_list[57]
                                                                                                                                                                                                                                          ? 128'h200000000000000
                                                                                                                                                                                                                                          : free_list[58]
                                                                                                                                                                                                                                              ? 128'h400000000000000
                                                                                                                                                                                                                                              : free_list[59]
                                                                                                                                                                                                                                                  ? 128'h800000000000000
                                                                                                                                                                                                                                                  : free_list[60]
                                                                                                                                                                                                                                                      ? 128'h1000000000000000
                                                                                                                                                                                                                                                      : free_list[61]
                                                                                                                                                                                                                                                          ? 128'h2000000000000000
                                                                                                                                                                                                                                                          : free_list[62]
                                                                                                                                                                                                                                                              ? 128'h4000000000000000
                                                                                                                                                                                                                                                              : free_list[63]
                                                                                                                                                                                                                                                                  ? 128'h8000000000000000
                                                                                                                                                                                                                                                                  : free_list[64]
                                                                                                                                                                                                                                                                      ? 128'h10000000000000000
                                                                                                                                                                                                                                                                      : free_list[65]
                                                                                                                                                                                                                                                                          ? 128'h20000000000000000
                                                                                                                                                                                                                                                                          : free_list[66]
                                                                                                                                                                                                                                                                              ? 128'h40000000000000000
                                                                                                                                                                                                                                                                              : free_list[67]
                                                                                                                                                                                                                                                                                  ? 128'h80000000000000000
                                                                                                                                                                                                                                                                                  : free_list[68]
                                                                                                                                                                                                                                                                                      ? 128'h100000000000000000
                                                                                                                                                                                                                                                                                      : free_list[69]
                                                                                                                                                                                                                                                                                          ? 128'h200000000000000000
                                                                                                                                                                                                                                                                                          : free_list[70]
                                                                                                                                                                                                                                                                                              ? 128'h400000000000000000
                                                                                                                                                                                                                                                                                              : free_list[71]
                                                                                                                                                                                                                                                                                                  ? 128'h800000000000000000
                                                                                                                                                                                                                                                                                                  : free_list[72]
                                                                                                                                                                                                                                                                                                      ? 128'h1000000000000000000
                                                                                                                                                                                                                                                                                                      : free_list[73]
                                                                                                                                                                                                                                                                                                          ? 128'h2000000000000000000
                                                                                                                                                                                                                                                                                                          : free_list[74]
                                                                                                                                                                                                                                                                                                              ? 128'h4000000000000000000
                                                                                                                                                                                                                                                                                                              : free_list[75]
                                                                                                                                                                                                                                                                                                                  ? 128'h8000000000000000000
                                                                                                                                                                                                                                                                                                                  : free_list[76]
                                                                                                                                                                                                                                                                                                                      ? 128'h10000000000000000000
                                                                                                                                                                                                                                                                                                                      : free_list[77]
                                                                                                                                                                                                                                                                                                                          ? 128'h20000000000000000000
                                                                                                                                                                                                                                                                                                                          : free_list[78]
                                                                                                                                                                                                                                                                                                                              ? 128'h40000000000000000000
                                                                                                                                                                                                                                                                                                                              : free_list[79]
                                                                                                                                                                                                                                                                                                                                  ? 128'h80000000000000000000
                                                                                                                                                                                                                                                                                                                                  : free_list[80]
                                                                                                                                                                                                                                                                                                                                      ? 128'h100000000000000000000
                                                                                                                                                                                                                                                                                                                                      : free_list[81]
                                                                                                                                                                                                                                                                                                                                          ? 128'h200000000000000000000
                                                                                                                                                                                                                                                                                                                                          : free_list[82]
                                                                                                                                                                                                                                                                                                                                              ? 128'h400000000000000000000
                                                                                                                                                                                                                                                                                                                                              : free_list[83]
                                                                                                                                                                                                                                                                                                                                                  ? 128'h800000000000000000000
                                                                                                                                                                                                                                                                                                                                                  : free_list[84]
                                                                                                                                                                                                                                                                                                                                                      ? 128'h1000000000000000000000
                                                                                                                                                                                                                                                                                                                                                      : free_list[85]
                                                                                                                                                                                                                                                                                                                                                          ? 128'h2000000000000000000000
                                                                                                                                                                                                                                                                                                                                                          : free_list[86]
                                                                                                                                                                                                                                                                                                                                                              ? 128'h4000000000000000000000
                                                                                                                                                                                                                                                                                                                                                              : free_list[87]
                                                                                                                                                                                                                                                                                                                                                                  ? 128'h8000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                  : free_list[88]
                                                                                                                                                                                                                                                                                                                                                                      ? 128'h10000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                      : free_list[89]
                                                                                                                                                                                                                                                                                                                                                                          ? 128'h20000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                          : free_list[90]
                                                                                                                                                                                                                                                                                                                                                                              ? 128'h40000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                              : free_list[91]
                                                                                                                                                                                                                                                                                                                                                                                  ? 128'h80000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                  : free_list[92]
                                                                                                                                                                                                                                                                                                                                                                                      ? 128'h100000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                      : free_list[93]
                                                                                                                                                                                                                                                                                                                                                                                          ? 128'h200000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                          : free_list[94]
                                                                                                                                                                                                                                                                                                                                                                                              ? 128'h400000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                              : free_list[95]
                                                                                                                                                                                                                                                                                                                                                                                                  ? 128'h800000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                  : free_list[96]
                                                                                                                                                                                                                                                                                                                                                                                                      ? 128'h1000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                      : free_list[97] ? 128'h2000000000000000000000000 : free_list[98] ? 128'h4000000000000000000000000 : free_list[99] ? 128'h8000000000000000000000000 : free_list[100] ? 128'h10000000000000000000000000 : free_list[101] ? 128'h20000000000000000000000000 : free_list[102] ? 128'h40000000000000000000000000 : free_list[103] ? 128'h80000000000000000000000000 : free_list[104] ? 128'h100000000000000000000000000 : free_list[105] ? 128'h200000000000000000000000000 : free_list[106] ? 128'h400000000000000000000000000 : free_list[107] ? 128'h800000000000000000000000000 : free_list[108] ? 128'h1000000000000000000000000000 : free_list[109] ? 128'h2000000000000000000000000000 : free_list[110] ? 128'h4000000000000000000000000000 : free_list[111] ? 128'h8000000000000000000000000000 : free_list[112] ? 128'h10000000000000000000000000000 : free_list[113] ? 128'h20000000000000000000000000000 : free_list[114] ? 128'h40000000000000000000000000000 : free_list[115] ? 128'h80000000000000000000000000000 : free_list[116] ? 128'h100000000000000000000000000000 : free_list[117] ? 128'h200000000000000000000000000000 : free_list[118] ? 128'h400000000000000000000000000000 : free_list[119] ? 128'h800000000000000000000000000000 : free_list[120] ? 128'h1000000000000000000000000000000 : free_list[121] ? 128'h2000000000000000000000000000000 : free_list[122] ? 128'h4000000000000000000000000000000 : free_list[123] ? 128'h8000000000000000000000000000000 : free_list[124] ? 128'h10000000000000000000000000000000 : free_list[125] ? 128'h20000000000000000000000000000000 : free_list[126] ? 128'h40000000000000000000000000000000 : {free_list[127], 127'h0};
  wire [127:0] _sels_T = ~sels_0;
  wire [127:0] _sels_sels_1_T_213 =
    free_list[42] & _sels_T[42]
      ? 128'h40000000000
      : free_list[43] & _sels_T[43]
          ? 128'h80000000000
          : free_list[44] & _sels_T[44]
              ? 128'h100000000000
              : free_list[45] & _sels_T[45]
                  ? 128'h200000000000
                  : free_list[46] & _sels_T[46]
                      ? 128'h400000000000
                      : free_list[47] & _sels_T[47]
                          ? 128'h800000000000
                          : free_list[48] & _sels_T[48]
                              ? 128'h1000000000000
                              : free_list[49] & _sels_T[49]
                                  ? 128'h2000000000000
                                  : free_list[50] & _sels_T[50]
                                      ? 128'h4000000000000
                                      : free_list[51] & _sels_T[51]
                                          ? 128'h8000000000000
                                          : free_list[52] & _sels_T[52]
                                              ? 128'h10000000000000
                                              : free_list[53] & _sels_T[53]
                                                  ? 128'h20000000000000
                                                  : free_list[54] & _sels_T[54]
                                                      ? 128'h40000000000000
                                                      : free_list[55] & _sels_T[55]
                                                          ? 128'h80000000000000
                                                          : free_list[56] & _sels_T[56]
                                                              ? 128'h100000000000000
                                                              : free_list[57] & _sels_T[57]
                                                                  ? 128'h200000000000000
                                                                  : free_list[58] & _sels_T[58]
                                                                      ? 128'h400000000000000
                                                                      : free_list[59] & _sels_T[59]
                                                                          ? 128'h800000000000000
                                                                          : free_list[60] & _sels_T[60]
                                                                              ? 128'h1000000000000000
                                                                              : free_list[61] & _sels_T[61]
                                                                                  ? 128'h2000000000000000
                                                                                  : free_list[62] & _sels_T[62]
                                                                                      ? 128'h4000000000000000
                                                                                      : free_list[63] & _sels_T[63]
                                                                                          ? 128'h8000000000000000
                                                                                          : free_list[64] & _sels_T[64]
                                                                                              ? 128'h10000000000000000
                                                                                              : free_list[65] & _sels_T[65]
                                                                                                  ? 128'h20000000000000000
                                                                                                  : free_list[66] & _sels_T[66]
                                                                                                      ? 128'h40000000000000000
                                                                                                      : free_list[67] & _sels_T[67]
                                                                                                          ? 128'h80000000000000000
                                                                                                          : free_list[68] & _sels_T[68]
                                                                                                              ? 128'h100000000000000000
                                                                                                              : free_list[69] & _sels_T[69]
                                                                                                                  ? 128'h200000000000000000
                                                                                                                  : free_list[70] & _sels_T[70]
                                                                                                                      ? 128'h400000000000000000
                                                                                                                      : free_list[71] & _sels_T[71]
                                                                                                                          ? 128'h800000000000000000
                                                                                                                          : free_list[72] & _sels_T[72]
                                                                                                                              ? 128'h1000000000000000000
                                                                                                                              : free_list[73] & _sels_T[73]
                                                                                                                                  ? 128'h2000000000000000000
                                                                                                                                  : free_list[74] & _sels_T[74]
                                                                                                                                      ? 128'h4000000000000000000
                                                                                                                                      : free_list[75] & _sels_T[75]
                                                                                                                                          ? 128'h8000000000000000000
                                                                                                                                          : free_list[76] & _sels_T[76]
                                                                                                                                              ? 128'h10000000000000000000
                                                                                                                                              : free_list[77] & _sels_T[77]
                                                                                                                                                  ? 128'h20000000000000000000
                                                                                                                                                  : free_list[78] & _sels_T[78]
                                                                                                                                                      ? 128'h40000000000000000000
                                                                                                                                                      : free_list[79] & _sels_T[79]
                                                                                                                                                          ? 128'h80000000000000000000
                                                                                                                                                          : free_list[80] & _sels_T[80]
                                                                                                                                                              ? 128'h100000000000000000000
                                                                                                                                                              : free_list[81] & _sels_T[81]
                                                                                                                                                                  ? 128'h200000000000000000000
                                                                                                                                                                  : free_list[82] & _sels_T[82]
                                                                                                                                                                      ? 128'h400000000000000000000
                                                                                                                                                                      : free_list[83] & _sels_T[83]
                                                                                                                                                                          ? 128'h800000000000000000000
                                                                                                                                                                          : free_list[84] & _sels_T[84]
                                                                                                                                                                              ? 128'h1000000000000000000000
                                                                                                                                                                              : free_list[85] & _sels_T[85]
                                                                                                                                                                                  ? 128'h2000000000000000000000
                                                                                                                                                                                  : free_list[86] & _sels_T[86]
                                                                                                                                                                                      ? 128'h4000000000000000000000
                                                                                                                                                                                      : free_list[87] & _sels_T[87]
                                                                                                                                                                                          ? 128'h8000000000000000000000
                                                                                                                                                                                          : free_list[88] & _sels_T[88]
                                                                                                                                                                                              ? 128'h10000000000000000000000
                                                                                                                                                                                              : free_list[89] & _sels_T[89]
                                                                                                                                                                                                  ? 128'h20000000000000000000000
                                                                                                                                                                                                  : free_list[90] & _sels_T[90]
                                                                                                                                                                                                      ? 128'h40000000000000000000000
                                                                                                                                                                                                      : free_list[91] & _sels_T[91]
                                                                                                                                                                                                          ? 128'h80000000000000000000000
                                                                                                                                                                                                          : free_list[92] & _sels_T[92]
                                                                                                                                                                                                              ? 128'h100000000000000000000000
                                                                                                                                                                                                              : free_list[93] & _sels_T[93]
                                                                                                                                                                                                                  ? 128'h200000000000000000000000
                                                                                                                                                                                                                  : free_list[94] & _sels_T[94]
                                                                                                                                                                                                                      ? 128'h400000000000000000000000
                                                                                                                                                                                                                      : free_list[95] & _sels_T[95]
                                                                                                                                                                                                                          ? 128'h800000000000000000000000
                                                                                                                                                                                                                          : free_list[96] & _sels_T[96]
                                                                                                                                                                                                                              ? 128'h1000000000000000000000000
                                                                                                                                                                                                                              : free_list[97] & _sels_T[97]
                                                                                                                                                                                                                                  ? 128'h2000000000000000000000000
                                                                                                                                                                                                                                  : free_list[98] & _sels_T[98]
                                                                                                                                                                                                                                      ? 128'h4000000000000000000000000
                                                                                                                                                                                                                                      : free_list[99] & _sels_T[99]
                                                                                                                                                                                                                                          ? 128'h8000000000000000000000000
                                                                                                                                                                                                                                          : free_list[100] & _sels_T[100]
                                                                                                                                                                                                                                              ? 128'h10000000000000000000000000
                                                                                                                                                                                                                                              : free_list[101] & _sels_T[101]
                                                                                                                                                                                                                                                  ? 128'h20000000000000000000000000
                                                                                                                                                                                                                                                  : free_list[102] & _sels_T[102] ? 128'h40000000000000000000000000 : free_list[103] & _sels_T[103] ? 128'h80000000000000000000000000 : free_list[104] & _sels_T[104] ? 128'h100000000000000000000000000 : free_list[105] & _sels_T[105] ? 128'h200000000000000000000000000 : free_list[106] & _sels_T[106] ? 128'h400000000000000000000000000 : free_list[107] & _sels_T[107] ? 128'h800000000000000000000000000 : free_list[108] & _sels_T[108] ? 128'h1000000000000000000000000000 : free_list[109] & _sels_T[109] ? 128'h2000000000000000000000000000 : free_list[110] & _sels_T[110] ? 128'h4000000000000000000000000000 : free_list[111] & _sels_T[111] ? 128'h8000000000000000000000000000 : free_list[112] & _sels_T[112] ? 128'h10000000000000000000000000000 : free_list[113] & _sels_T[113] ? 128'h20000000000000000000000000000 : free_list[114] & _sels_T[114] ? 128'h40000000000000000000000000000 : free_list[115] & _sels_T[115] ? 128'h80000000000000000000000000000 : free_list[116] & _sels_T[116] ? 128'h100000000000000000000000000000 : free_list[117] & _sels_T[117] ? 128'h200000000000000000000000000000 : free_list[118] & _sels_T[118] ? 128'h400000000000000000000000000000 : free_list[119] & _sels_T[119] ? 128'h800000000000000000000000000000 : free_list[120] & _sels_T[120] ? 128'h1000000000000000000000000000000 : free_list[121] & _sels_T[121] ? 128'h2000000000000000000000000000000 : free_list[122] & _sels_T[122] ? 128'h4000000000000000000000000000000 : free_list[123] & _sels_T[123] ? 128'h8000000000000000000000000000000 : free_list[124] & _sels_T[124] ? 128'h10000000000000000000000000000000 : free_list[125] & _sels_T[125] ? 128'h20000000000000000000000000000000 : free_list[126] & _sels_T[126] ? 128'h40000000000000000000000000000000 : {free_list[127] & _sels_T[127], 127'h0};
  wire [127:0] sels_1 = free_list[0] & _sels_T[0] ? 128'h1 : free_list[1] & _sels_T[1] ? 128'h2 : free_list[2] & _sels_T[2] ? 128'h4 : free_list[3] & _sels_T[3] ? 128'h8 : free_list[4] & _sels_T[4] ? 128'h10 : free_list[5] & _sels_T[5] ? 128'h20 : free_list[6] & _sels_T[6] ? 128'h40 : free_list[7] & _sels_T[7] ? 128'h80 : free_list[8] & _sels_T[8] ? 128'h100 : free_list[9] & _sels_T[9] ? 128'h200 : free_list[10] & _sels_T[10] ? 128'h400 : free_list[11] & _sels_T[11] ? 128'h800 : free_list[12] & _sels_T[12] ? 128'h1000 : free_list[13] & _sels_T[13] ? 128'h2000 : free_list[14] & _sels_T[14] ? 128'h4000 : free_list[15] & _sels_T[15] ? 128'h8000 : free_list[16] & _sels_T[16] ? 128'h10000 : free_list[17] & _sels_T[17] ? 128'h20000 : free_list[18] & _sels_T[18] ? 128'h40000 : free_list[19] & _sels_T[19] ? 128'h80000 : free_list[20] & _sels_T[20] ? 128'h100000 : free_list[21] & _sels_T[21] ? 128'h200000 : free_list[22] & _sels_T[22] ? 128'h400000 : free_list[23] & _sels_T[23] ? 128'h800000 : free_list[24] & _sels_T[24] ? 128'h1000000 : free_list[25] & _sels_T[25] ? 128'h2000000 : free_list[26] & _sels_T[26] ? 128'h4000000 : free_list[27] & _sels_T[27] ? 128'h8000000 : free_list[28] & _sels_T[28] ? 128'h10000000 : free_list[29] & _sels_T[29] ? 128'h20000000 : free_list[30] & _sels_T[30] ? 128'h40000000 : free_list[31] & _sels_T[31] ? 128'h80000000 : free_list[32] & _sels_T[32] ? 128'h100000000 : free_list[33] & _sels_T[33] ? 128'h200000000 : free_list[34] & _sels_T[34] ? 128'h400000000 : free_list[35] & _sels_T[35] ? 128'h800000000 : free_list[36] & _sels_T[36] ? 128'h1000000000 : free_list[37] & _sels_T[37] ? 128'h2000000000 : free_list[38] & _sels_T[38] ? 128'h4000000000 : free_list[39] & _sels_T[39] ? 128'h8000000000 : free_list[40] & _sels_T[40] ? 128'h10000000000 : free_list[41] & _sels_T[41] ? 128'h20000000000 : _sels_sels_1_T_213;
  wire [127:0] _sels_T_2 = ~sels_1;
  wire         _GEN = free_list[0] & _sels_T[0];
  wire         _GEN_0 = free_list[1] & _sels_T[1];
  wire         _GEN_1 = free_list[2] & _sels_T[2];
  wire         _GEN_2 = free_list[3] & _sels_T[3];
  wire         _GEN_3 = free_list[4] & _sels_T[4];
  wire         _GEN_4 = free_list[5] & _sels_T[5];
  wire         _GEN_5 = free_list[6] & _sels_T[6];
  wire         _GEN_6 = free_list[7] & _sels_T[7];
  wire         _GEN_7 = free_list[8] & _sels_T[8];
  wire         _GEN_8 = free_list[9] & _sels_T[9];
  wire         _GEN_9 = free_list[10] & _sels_T[10];
  wire         _GEN_10 = free_list[11] & _sels_T[11];
  wire         _GEN_11 = free_list[12] & _sels_T[12];
  wire         _GEN_12 = free_list[13] & _sels_T[13];
  wire         _GEN_13 = free_list[14] & _sels_T[14];
  wire         _GEN_14 = free_list[15] & _sels_T[15];
  wire         _GEN_15 = free_list[16] & _sels_T[16];
  wire         _GEN_16 = free_list[17] & _sels_T[17];
  wire         _GEN_17 = free_list[18] & _sels_T[18];
  wire         _GEN_18 = free_list[19] & _sels_T[19];
  wire         _GEN_19 = free_list[20] & _sels_T[20];
  wire         _GEN_20 = free_list[21] & _sels_T[21];
  wire         _GEN_21 = free_list[22] & _sels_T[22];
  wire         _GEN_22 = free_list[23] & _sels_T[23];
  wire         _GEN_23 = free_list[24] & _sels_T[24];
  wire         _GEN_24 = free_list[25] & _sels_T[25];
  wire         _GEN_25 = free_list[26] & _sels_T[26];
  wire         _GEN_26 = free_list[27] & _sels_T[27];
  wire         _GEN_27 = free_list[28] & _sels_T[28];
  wire         _GEN_28 = free_list[29] & _sels_T[29];
  wire         _GEN_29 = free_list[30] & _sels_T[30];
  wire         _GEN_30 = free_list[31] & _sels_T[31];
  wire         _GEN_31 = free_list[32] & _sels_T[32];
  wire         _GEN_32 = free_list[33] & _sels_T[33];
  wire         _GEN_33 = free_list[34] & _sels_T[34];
  wire         _GEN_34 = free_list[35] & _sels_T[35];
  wire         _GEN_35 = free_list[36] & _sels_T[36];
  wire         _GEN_36 = free_list[37] & _sels_T[37];
  wire         _GEN_37 = free_list[38] & _sels_T[38];
  wire         _GEN_38 = free_list[39] & _sels_T[39];
  wire         _GEN_39 = free_list[40] & _sels_T[40];
  wire         _GEN_40 = free_list[41] & _sels_T[41];
  wire         _GEN_41 = free_list[42] & _sels_T[42];
  wire         _GEN_42 = free_list[43] & _sels_T[43];
  wire         _GEN_43 = free_list[44] & _sels_T[44];
  wire         _GEN_44 = free_list[45] & _sels_T[45];
  wire         _GEN_45 = free_list[46] & _sels_T[46];
  wire         _GEN_46 = free_list[47] & _sels_T[47];
  wire         _GEN_47 = free_list[48] & _sels_T[48];
  wire         _GEN_48 = free_list[49] & _sels_T[49];
  wire         _GEN_49 = free_list[50] & _sels_T[50];
  wire         _GEN_50 = free_list[51] & _sels_T[51];
  wire         _GEN_51 = free_list[52] & _sels_T[52];
  wire         _GEN_52 = free_list[53] & _sels_T[53];
  wire         _GEN_53 = free_list[54] & _sels_T[54];
  wire         _GEN_54 = free_list[55] & _sels_T[55];
  wire         _GEN_55 = free_list[56] & _sels_T[56];
  wire         _GEN_56 = free_list[57] & _sels_T[57];
  wire         _GEN_57 = free_list[58] & _sels_T[58];
  wire         _GEN_58 = free_list[59] & _sels_T[59];
  wire         _GEN_59 = free_list[60] & _sels_T[60];
  wire         _GEN_60 = free_list[61] & _sels_T[61];
  wire         _GEN_61 = free_list[62] & _sels_T[62];
  wire         _GEN_62 = free_list[63] & _sels_T[63];
  wire         _GEN_63 = free_list[64] & _sels_T[64];
  wire         _GEN_64 = free_list[65] & _sels_T[65];
  wire         _GEN_65 = free_list[66] & _sels_T[66];
  wire         _GEN_66 = free_list[67] & _sels_T[67];
  wire         _GEN_67 = free_list[68] & _sels_T[68];
  wire         _GEN_68 = free_list[69] & _sels_T[69];
  wire         _GEN_69 = free_list[70] & _sels_T[70];
  wire         _GEN_70 = free_list[71] & _sels_T[71];
  wire         _GEN_71 = free_list[72] & _sels_T[72];
  wire         _GEN_72 = free_list[73] & _sels_T[73];
  wire         _GEN_73 = free_list[74] & _sels_T[74];
  wire         _GEN_74 = free_list[75] & _sels_T[75];
  wire         _GEN_75 = free_list[76] & _sels_T[76];
  wire         _GEN_76 = free_list[77] & _sels_T[77];
  wire         _GEN_77 = free_list[78] & _sels_T[78];
  wire         _GEN_78 = free_list[79] & _sels_T[79];
  wire         _GEN_79 = free_list[80] & _sels_T[80];
  wire         _GEN_80 = free_list[81] & _sels_T[81];
  wire         _GEN_81 = free_list[82] & _sels_T[82];
  wire         _GEN_82 = free_list[83] & _sels_T[83];
  wire         _GEN_83 = free_list[84] & _sels_T[84];
  wire         _GEN_84 = free_list[85] & _sels_T[85];
  wire         _GEN_85 = free_list[86] & _sels_T[86];
  wire         _GEN_86 = free_list[87] & _sels_T[87];
  wire         _GEN_87 = free_list[88] & _sels_T[88];
  wire         _GEN_88 = free_list[89] & _sels_T[89];
  wire         _GEN_89 = free_list[90] & _sels_T[90];
  wire         _GEN_90 = free_list[91] & _sels_T[91];
  wire         _GEN_91 = free_list[92] & _sels_T[92];
  wire         _GEN_92 = free_list[93] & _sels_T[93];
  wire         _GEN_93 = free_list[94] & _sels_T[94];
  wire         _GEN_94 = free_list[95] & _sels_T[95];
  wire         _GEN_95 = free_list[96] & _sels_T[96];
  wire         _GEN_96 = free_list[97] & _sels_T[97];
  wire         _GEN_97 = free_list[98] & _sels_T[98];
  wire         _GEN_98 = free_list[99] & _sels_T[99];
  wire         _GEN_99 = free_list[100] & _sels_T[100];
  wire         _GEN_100 = free_list[101] & _sels_T[101];
  wire         _GEN_101 = free_list[102] & _sels_T[102];
  wire         _GEN_102 = free_list[103] & _sels_T[103];
  wire         _GEN_103 = free_list[104] & _sels_T[104];
  wire         _GEN_104 = free_list[105] & _sels_T[105];
  wire         _GEN_105 = free_list[106] & _sels_T[106];
  wire         _GEN_106 = free_list[107] & _sels_T[107];
  wire         _GEN_107 = free_list[108] & _sels_T[108];
  wire         _GEN_108 = free_list[109] & _sels_T[109];
  wire         _GEN_109 = free_list[110] & _sels_T[110];
  wire         _GEN_110 = free_list[111] & _sels_T[111];
  wire         _GEN_111 = free_list[112] & _sels_T[112];
  wire         _GEN_112 = free_list[113] & _sels_T[113];
  wire         _GEN_113 = free_list[114] & _sels_T[114];
  wire         _GEN_114 = free_list[115] & _sels_T[115];
  wire         _GEN_115 = free_list[116] & _sels_T[116];
  wire         _GEN_116 = free_list[117] & _sels_T[117];
  wire         _GEN_117 = free_list[118] & _sels_T[118];
  wire         _GEN_118 = free_list[119] & _sels_T[119];
  wire         _GEN_119 = free_list[120] & _sels_T[120];
  wire         _GEN_120 = free_list[121] & _sels_T[121];
  wire         _GEN_121 = free_list[122] & _sels_T[122];
  wire         _GEN_122 = free_list[123] & _sels_T[123];
  wire         _GEN_123 = free_list[124] & _sels_T[124];
  wire         _GEN_124 = free_list[125] & _sels_T[125];
  wire         _GEN_125 = free_list[126] & _sels_T[126];
  wire         _GEN_126 = free_list[127] & _sels_T[127];
  wire [127:0] _sels_sels_2_T_213 =
    _GEN_41 & _sels_T_2[42]
      ? 128'h40000000000
      : _GEN_42 & _sels_T_2[43]
          ? 128'h80000000000
          : _GEN_43 & _sels_T_2[44]
              ? 128'h100000000000
              : _GEN_44 & _sels_T_2[45]
                  ? 128'h200000000000
                  : _GEN_45 & _sels_T_2[46]
                      ? 128'h400000000000
                      : _GEN_46 & _sels_T_2[47]
                          ? 128'h800000000000
                          : _GEN_47 & _sels_T_2[48]
                              ? 128'h1000000000000
                              : _GEN_48 & _sels_T_2[49]
                                  ? 128'h2000000000000
                                  : _GEN_49 & _sels_T_2[50]
                                      ? 128'h4000000000000
                                      : _GEN_50 & _sels_T_2[51]
                                          ? 128'h8000000000000
                                          : _GEN_51 & _sels_T_2[52]
                                              ? 128'h10000000000000
                                              : _GEN_52 & _sels_T_2[53]
                                                  ? 128'h20000000000000
                                                  : _GEN_53 & _sels_T_2[54]
                                                      ? 128'h40000000000000
                                                      : _GEN_54 & _sels_T_2[55]
                                                          ? 128'h80000000000000
                                                          : _GEN_55 & _sels_T_2[56]
                                                              ? 128'h100000000000000
                                                              : _GEN_56 & _sels_T_2[57]
                                                                  ? 128'h200000000000000
                                                                  : _GEN_57 & _sels_T_2[58]
                                                                      ? 128'h400000000000000
                                                                      : _GEN_58 & _sels_T_2[59]
                                                                          ? 128'h800000000000000
                                                                          : _GEN_59 & _sels_T_2[60]
                                                                              ? 128'h1000000000000000
                                                                              : _GEN_60 & _sels_T_2[61]
                                                                                  ? 128'h2000000000000000
                                                                                  : _GEN_61 & _sels_T_2[62]
                                                                                      ? 128'h4000000000000000
                                                                                      : _GEN_62 & _sels_T_2[63]
                                                                                          ? 128'h8000000000000000
                                                                                          : _GEN_63 & _sels_T_2[64]
                                                                                              ? 128'h10000000000000000
                                                                                              : _GEN_64 & _sels_T_2[65]
                                                                                                  ? 128'h20000000000000000
                                                                                                  : _GEN_65 & _sels_T_2[66]
                                                                                                      ? 128'h40000000000000000
                                                                                                      : _GEN_66 & _sels_T_2[67]
                                                                                                          ? 128'h80000000000000000
                                                                                                          : _GEN_67 & _sels_T_2[68]
                                                                                                              ? 128'h100000000000000000
                                                                                                              : _GEN_68 & _sels_T_2[69]
                                                                                                                  ? 128'h200000000000000000
                                                                                                                  : _GEN_69 & _sels_T_2[70]
                                                                                                                      ? 128'h400000000000000000
                                                                                                                      : _GEN_70 & _sels_T_2[71]
                                                                                                                          ? 128'h800000000000000000
                                                                                                                          : _GEN_71 & _sels_T_2[72]
                                                                                                                              ? 128'h1000000000000000000
                                                                                                                              : _GEN_72 & _sels_T_2[73]
                                                                                                                                  ? 128'h2000000000000000000
                                                                                                                                  : _GEN_73 & _sels_T_2[74]
                                                                                                                                      ? 128'h4000000000000000000
                                                                                                                                      : _GEN_74 & _sels_T_2[75]
                                                                                                                                          ? 128'h8000000000000000000
                                                                                                                                          : _GEN_75 & _sels_T_2[76]
                                                                                                                                              ? 128'h10000000000000000000
                                                                                                                                              : _GEN_76 & _sels_T_2[77]
                                                                                                                                                  ? 128'h20000000000000000000
                                                                                                                                                  : _GEN_77 & _sels_T_2[78]
                                                                                                                                                      ? 128'h40000000000000000000
                                                                                                                                                      : _GEN_78 & _sels_T_2[79]
                                                                                                                                                          ? 128'h80000000000000000000
                                                                                                                                                          : _GEN_79 & _sels_T_2[80]
                                                                                                                                                              ? 128'h100000000000000000000
                                                                                                                                                              : _GEN_80 & _sels_T_2[81]
                                                                                                                                                                  ? 128'h200000000000000000000
                                                                                                                                                                  : _GEN_81 & _sels_T_2[82]
                                                                                                                                                                      ? 128'h400000000000000000000
                                                                                                                                                                      : _GEN_82 & _sels_T_2[83]
                                                                                                                                                                          ? 128'h800000000000000000000
                                                                                                                                                                          : _GEN_83 & _sels_T_2[84]
                                                                                                                                                                              ? 128'h1000000000000000000000
                                                                                                                                                                              : _GEN_84 & _sels_T_2[85]
                                                                                                                                                                                  ? 128'h2000000000000000000000
                                                                                                                                                                                  : _GEN_85 & _sels_T_2[86]
                                                                                                                                                                                      ? 128'h4000000000000000000000
                                                                                                                                                                                      : _GEN_86 & _sels_T_2[87]
                                                                                                                                                                                          ? 128'h8000000000000000000000
                                                                                                                                                                                          : _GEN_87 & _sels_T_2[88]
                                                                                                                                                                                              ? 128'h10000000000000000000000
                                                                                                                                                                                              : _GEN_88 & _sels_T_2[89]
                                                                                                                                                                                                  ? 128'h20000000000000000000000
                                                                                                                                                                                                  : _GEN_89 & _sels_T_2[90]
                                                                                                                                                                                                      ? 128'h40000000000000000000000
                                                                                                                                                                                                      : _GEN_90 & _sels_T_2[91]
                                                                                                                                                                                                          ? 128'h80000000000000000000000
                                                                                                                                                                                                          : _GEN_91 & _sels_T_2[92]
                                                                                                                                                                                                              ? 128'h100000000000000000000000
                                                                                                                                                                                                              : _GEN_92 & _sels_T_2[93]
                                                                                                                                                                                                                  ? 128'h200000000000000000000000
                                                                                                                                                                                                                  : _GEN_93 & _sels_T_2[94]
                                                                                                                                                                                                                      ? 128'h400000000000000000000000
                                                                                                                                                                                                                      : _GEN_94 & _sels_T_2[95]
                                                                                                                                                                                                                          ? 128'h800000000000000000000000
                                                                                                                                                                                                                          : _GEN_95 & _sels_T_2[96]
                                                                                                                                                                                                                              ? 128'h1000000000000000000000000
                                                                                                                                                                                                                              : _GEN_96 & _sels_T_2[97]
                                                                                                                                                                                                                                  ? 128'h2000000000000000000000000
                                                                                                                                                                                                                                  : _GEN_97 & _sels_T_2[98]
                                                                                                                                                                                                                                      ? 128'h4000000000000000000000000
                                                                                                                                                                                                                                      : _GEN_98 & _sels_T_2[99]
                                                                                                                                                                                                                                          ? 128'h8000000000000000000000000
                                                                                                                                                                                                                                          : _GEN_99 & _sels_T_2[100] ? 128'h10000000000000000000000000 : _GEN_100 & _sels_T_2[101] ? 128'h20000000000000000000000000 : _GEN_101 & _sels_T_2[102] ? 128'h40000000000000000000000000 : _GEN_102 & _sels_T_2[103] ? 128'h80000000000000000000000000 : _GEN_103 & _sels_T_2[104] ? 128'h100000000000000000000000000 : _GEN_104 & _sels_T_2[105] ? 128'h200000000000000000000000000 : _GEN_105 & _sels_T_2[106] ? 128'h400000000000000000000000000 : _GEN_106 & _sels_T_2[107] ? 128'h800000000000000000000000000 : _GEN_107 & _sels_T_2[108] ? 128'h1000000000000000000000000000 : _GEN_108 & _sels_T_2[109] ? 128'h2000000000000000000000000000 : _GEN_109 & _sels_T_2[110] ? 128'h4000000000000000000000000000 : _GEN_110 & _sels_T_2[111] ? 128'h8000000000000000000000000000 : _GEN_111 & _sels_T_2[112] ? 128'h10000000000000000000000000000 : _GEN_112 & _sels_T_2[113] ? 128'h20000000000000000000000000000 : _GEN_113 & _sels_T_2[114] ? 128'h40000000000000000000000000000 : _GEN_114 & _sels_T_2[115] ? 128'h80000000000000000000000000000 : _GEN_115 & _sels_T_2[116] ? 128'h100000000000000000000000000000 : _GEN_116 & _sels_T_2[117] ? 128'h200000000000000000000000000000 : _GEN_117 & _sels_T_2[118] ? 128'h400000000000000000000000000000 : _GEN_118 & _sels_T_2[119] ? 128'h800000000000000000000000000000 : _GEN_119 & _sels_T_2[120] ? 128'h1000000000000000000000000000000 : _GEN_120 & _sels_T_2[121] ? 128'h2000000000000000000000000000000 : _GEN_121 & _sels_T_2[122] ? 128'h4000000000000000000000000000000 : _GEN_122 & _sels_T_2[123] ? 128'h8000000000000000000000000000000 : _GEN_123 & _sels_T_2[124] ? 128'h10000000000000000000000000000000 : _GEN_124 & _sels_T_2[125] ? 128'h20000000000000000000000000000000 : _GEN_125 & _sels_T_2[126] ? 128'h40000000000000000000000000000000 : {_GEN_126 & _sels_T_2[127], 127'h0};
  wire [127:0] sels_2 = _GEN & _sels_T_2[0] ? 128'h1 : _GEN_0 & _sels_T_2[1] ? 128'h2 : _GEN_1 & _sels_T_2[2] ? 128'h4 : _GEN_2 & _sels_T_2[3] ? 128'h8 : _GEN_3 & _sels_T_2[4] ? 128'h10 : _GEN_4 & _sels_T_2[5] ? 128'h20 : _GEN_5 & _sels_T_2[6] ? 128'h40 : _GEN_6 & _sels_T_2[7] ? 128'h80 : _GEN_7 & _sels_T_2[8] ? 128'h100 : _GEN_8 & _sels_T_2[9] ? 128'h200 : _GEN_9 & _sels_T_2[10] ? 128'h400 : _GEN_10 & _sels_T_2[11] ? 128'h800 : _GEN_11 & _sels_T_2[12] ? 128'h1000 : _GEN_12 & _sels_T_2[13] ? 128'h2000 : _GEN_13 & _sels_T_2[14] ? 128'h4000 : _GEN_14 & _sels_T_2[15] ? 128'h8000 : _GEN_15 & _sels_T_2[16] ? 128'h10000 : _GEN_16 & _sels_T_2[17] ? 128'h20000 : _GEN_17 & _sels_T_2[18] ? 128'h40000 : _GEN_18 & _sels_T_2[19] ? 128'h80000 : _GEN_19 & _sels_T_2[20] ? 128'h100000 : _GEN_20 & _sels_T_2[21] ? 128'h200000 : _GEN_21 & _sels_T_2[22] ? 128'h400000 : _GEN_22 & _sels_T_2[23] ? 128'h800000 : _GEN_23 & _sels_T_2[24] ? 128'h1000000 : _GEN_24 & _sels_T_2[25] ? 128'h2000000 : _GEN_25 & _sels_T_2[26] ? 128'h4000000 : _GEN_26 & _sels_T_2[27] ? 128'h8000000 : _GEN_27 & _sels_T_2[28] ? 128'h10000000 : _GEN_28 & _sels_T_2[29] ? 128'h20000000 : _GEN_29 & _sels_T_2[30] ? 128'h40000000 : _GEN_30 & _sels_T_2[31] ? 128'h80000000 : _GEN_31 & _sels_T_2[32] ? 128'h100000000 : _GEN_32 & _sels_T_2[33] ? 128'h200000000 : _GEN_33 & _sels_T_2[34] ? 128'h400000000 : _GEN_34 & _sels_T_2[35] ? 128'h800000000 : _GEN_35 & _sels_T_2[36] ? 128'h1000000000 : _GEN_36 & _sels_T_2[37] ? 128'h2000000000 : _GEN_37 & _sels_T_2[38] ? 128'h4000000000 : _GEN_38 & _sels_T_2[39] ? 128'h8000000000 : _GEN_39 & _sels_T_2[40] ? 128'h10000000000 : _GEN_40 & _sels_T_2[41] ? 128'h20000000000 : _sels_sels_2_T_213;
  wire [127:0] _sels_T_4 = ~sels_2;
  wire [127:0] _sels_sels_3_T_192 =
    _GEN_62 & _sels_T_2[63] & _sels_T_4[63]
      ? 128'h8000000000000000
      : _GEN_63 & _sels_T_2[64] & _sels_T_4[64]
          ? 128'h10000000000000000
          : _GEN_64 & _sels_T_2[65] & _sels_T_4[65]
              ? 128'h20000000000000000
              : _GEN_65 & _sels_T_2[66] & _sels_T_4[66]
                  ? 128'h40000000000000000
                  : _GEN_66 & _sels_T_2[67] & _sels_T_4[67]
                      ? 128'h80000000000000000
                      : _GEN_67 & _sels_T_2[68] & _sels_T_4[68]
                          ? 128'h100000000000000000
                          : _GEN_68 & _sels_T_2[69] & _sels_T_4[69]
                              ? 128'h200000000000000000
                              : _GEN_69 & _sels_T_2[70] & _sels_T_4[70]
                                  ? 128'h400000000000000000
                                  : _GEN_70 & _sels_T_2[71] & _sels_T_4[71]
                                      ? 128'h800000000000000000
                                      : _GEN_71 & _sels_T_2[72] & _sels_T_4[72]
                                          ? 128'h1000000000000000000
                                          : _GEN_72 & _sels_T_2[73] & _sels_T_4[73]
                                              ? 128'h2000000000000000000
                                              : _GEN_73 & _sels_T_2[74] & _sels_T_4[74]
                                                  ? 128'h4000000000000000000
                                                  : _GEN_74 & _sels_T_2[75] & _sels_T_4[75]
                                                      ? 128'h8000000000000000000
                                                      : _GEN_75 & _sels_T_2[76] & _sels_T_4[76]
                                                          ? 128'h10000000000000000000
                                                          : _GEN_76 & _sels_T_2[77] & _sels_T_4[77]
                                                              ? 128'h20000000000000000000
                                                              : _GEN_77 & _sels_T_2[78] & _sels_T_4[78]
                                                                  ? 128'h40000000000000000000
                                                                  : _GEN_78 & _sels_T_2[79] & _sels_T_4[79]
                                                                      ? 128'h80000000000000000000
                                                                      : _GEN_79 & _sels_T_2[80] & _sels_T_4[80]
                                                                          ? 128'h100000000000000000000
                                                                          : _GEN_80 & _sels_T_2[81] & _sels_T_4[81]
                                                                              ? 128'h200000000000000000000
                                                                              : _GEN_81 & _sels_T_2[82] & _sels_T_4[82]
                                                                                  ? 128'h400000000000000000000
                                                                                  : _GEN_82 & _sels_T_2[83] & _sels_T_4[83]
                                                                                      ? 128'h800000000000000000000
                                                                                      : _GEN_83 & _sels_T_2[84] & _sels_T_4[84]
                                                                                          ? 128'h1000000000000000000000
                                                                                          : _GEN_84 & _sels_T_2[85] & _sels_T_4[85]
                                                                                              ? 128'h2000000000000000000000
                                                                                              : _GEN_85 & _sels_T_2[86] & _sels_T_4[86]
                                                                                                  ? 128'h4000000000000000000000
                                                                                                  : _GEN_86 & _sels_T_2[87] & _sels_T_4[87]
                                                                                                      ? 128'h8000000000000000000000
                                                                                                      : _GEN_87 & _sels_T_2[88] & _sels_T_4[88]
                                                                                                          ? 128'h10000000000000000000000
                                                                                                          : _GEN_88 & _sels_T_2[89] & _sels_T_4[89]
                                                                                                              ? 128'h20000000000000000000000
                                                                                                              : _GEN_89 & _sels_T_2[90] & _sels_T_4[90]
                                                                                                                  ? 128'h40000000000000000000000
                                                                                                                  : _GEN_90 & _sels_T_2[91] & _sels_T_4[91]
                                                                                                                      ? 128'h80000000000000000000000
                                                                                                                      : _GEN_91 & _sels_T_2[92] & _sels_T_4[92]
                                                                                                                          ? 128'h100000000000000000000000
                                                                                                                          : _GEN_92 & _sels_T_2[93] & _sels_T_4[93]
                                                                                                                              ? 128'h200000000000000000000000
                                                                                                                              : _GEN_93 & _sels_T_2[94] & _sels_T_4[94]
                                                                                                                                  ? 128'h400000000000000000000000
                                                                                                                                  : _GEN_94 & _sels_T_2[95] & _sels_T_4[95]
                                                                                                                                      ? 128'h800000000000000000000000
                                                                                                                                      : _GEN_95 & _sels_T_2[96] & _sels_T_4[96]
                                                                                                                                          ? 128'h1000000000000000000000000
                                                                                                                                          : _GEN_96 & _sels_T_2[97] & _sels_T_4[97]
                                                                                                                                              ? 128'h2000000000000000000000000
                                                                                                                                              : _GEN_97 & _sels_T_2[98] & _sels_T_4[98]
                                                                                                                                                  ? 128'h4000000000000000000000000
                                                                                                                                                  : _GEN_98 & _sels_T_2[99] & _sels_T_4[99]
                                                                                                                                                      ? 128'h8000000000000000000000000
                                                                                                                                                      : _GEN_99 & _sels_T_2[100] & _sels_T_4[100]
                                                                                                                                                          ? 128'h10000000000000000000000000
                                                                                                                                                          : _GEN_100 & _sels_T_2[101] & _sels_T_4[101]
                                                                                                                                                              ? 128'h20000000000000000000000000
                                                                                                                                                              : _GEN_101 & _sels_T_2[102] & _sels_T_4[102]
                                                                                                                                                                  ? 128'h40000000000000000000000000
                                                                                                                                                                  : _GEN_102 & _sels_T_2[103] & _sels_T_4[103]
                                                                                                                                                                      ? 128'h80000000000000000000000000
                                                                                                                                                                      : _GEN_103 & _sels_T_2[104] & _sels_T_4[104]
                                                                                                                                                                          ? 128'h100000000000000000000000000
                                                                                                                                                                          : _GEN_104 & _sels_T_2[105] & _sels_T_4[105] ? 128'h200000000000000000000000000 : _GEN_105 & _sels_T_2[106] & _sels_T_4[106] ? 128'h400000000000000000000000000 : _GEN_106 & _sels_T_2[107] & _sels_T_4[107] ? 128'h800000000000000000000000000 : _GEN_107 & _sels_T_2[108] & _sels_T_4[108] ? 128'h1000000000000000000000000000 : _GEN_108 & _sels_T_2[109] & _sels_T_4[109] ? 128'h2000000000000000000000000000 : _GEN_109 & _sels_T_2[110] & _sels_T_4[110] ? 128'h4000000000000000000000000000 : _GEN_110 & _sels_T_2[111] & _sels_T_4[111] ? 128'h8000000000000000000000000000 : _GEN_111 & _sels_T_2[112] & _sels_T_4[112] ? 128'h10000000000000000000000000000 : _GEN_112 & _sels_T_2[113] & _sels_T_4[113] ? 128'h20000000000000000000000000000 : _GEN_113 & _sels_T_2[114] & _sels_T_4[114] ? 128'h40000000000000000000000000000 : _GEN_114 & _sels_T_2[115] & _sels_T_4[115] ? 128'h80000000000000000000000000000 : _GEN_115 & _sels_T_2[116] & _sels_T_4[116] ? 128'h100000000000000000000000000000 : _GEN_116 & _sels_T_2[117] & _sels_T_4[117] ? 128'h200000000000000000000000000000 : _GEN_117 & _sels_T_2[118] & _sels_T_4[118] ? 128'h400000000000000000000000000000 : _GEN_118 & _sels_T_2[119] & _sels_T_4[119] ? 128'h800000000000000000000000000000 : _GEN_119 & _sels_T_2[120] & _sels_T_4[120] ? 128'h1000000000000000000000000000000 : _GEN_120 & _sels_T_2[121] & _sels_T_4[121] ? 128'h2000000000000000000000000000000 : _GEN_121 & _sels_T_2[122] & _sels_T_4[122] ? 128'h4000000000000000000000000000000 : _GEN_122 & _sels_T_2[123] & _sels_T_4[123] ? 128'h8000000000000000000000000000000 : _GEN_123 & _sels_T_2[124] & _sels_T_4[124] ? 128'h10000000000000000000000000000000 : _GEN_124 & _sels_T_2[125] & _sels_T_4[125] ? 128'h20000000000000000000000000000000 : _GEN_125 & _sels_T_2[126] & _sels_T_4[126] ? 128'h40000000000000000000000000000000 : {_GEN_126 & _sels_T_2[127] & _sels_T_4[127], 127'h0};
  wire [127:0] sels_3 =
    _GEN & _sels_T_2[0] & _sels_T_4[0]
      ? 128'h1
      : _GEN_0 & _sels_T_2[1] & _sels_T_4[1]
          ? 128'h2
          : _GEN_1 & _sels_T_2[2] & _sels_T_4[2]
              ? 128'h4
              : _GEN_2 & _sels_T_2[3] & _sels_T_4[3]
                  ? 128'h8
                  : _GEN_3 & _sels_T_2[4] & _sels_T_4[4]
                      ? 128'h10
                      : _GEN_4 & _sels_T_2[5] & _sels_T_4[5]
                          ? 128'h20
                          : _GEN_5 & _sels_T_2[6] & _sels_T_4[6]
                              ? 128'h40
                              : _GEN_6 & _sels_T_2[7] & _sels_T_4[7]
                                  ? 128'h80
                                  : _GEN_7 & _sels_T_2[8] & _sels_T_4[8]
                                      ? 128'h100
                                      : _GEN_8 & _sels_T_2[9] & _sels_T_4[9]
                                          ? 128'h200
                                          : _GEN_9 & _sels_T_2[10] & _sels_T_4[10]
                                              ? 128'h400
                                              : _GEN_10 & _sels_T_2[11] & _sels_T_4[11]
                                                  ? 128'h800
                                                  : _GEN_11 & _sels_T_2[12] & _sels_T_4[12]
                                                      ? 128'h1000
                                                      : _GEN_12 & _sels_T_2[13] & _sels_T_4[13]
                                                          ? 128'h2000
                                                          : _GEN_13 & _sels_T_2[14] & _sels_T_4[14]
                                                              ? 128'h4000
                                                              : _GEN_14 & _sels_T_2[15] & _sels_T_4[15]
                                                                  ? 128'h8000
                                                                  : _GEN_15 & _sels_T_2[16] & _sels_T_4[16]
                                                                      ? 128'h10000
                                                                      : _GEN_16 & _sels_T_2[17] & _sels_T_4[17]
                                                                          ? 128'h20000
                                                                          : _GEN_17 & _sels_T_2[18] & _sels_T_4[18]
                                                                              ? 128'h40000
                                                                              : _GEN_18 & _sels_T_2[19] & _sels_T_4[19]
                                                                                  ? 128'h80000
                                                                                  : _GEN_19 & _sels_T_2[20] & _sels_T_4[20]
                                                                                      ? 128'h100000
                                                                                      : _GEN_20 & _sels_T_2[21] & _sels_T_4[21]
                                                                                          ? 128'h200000
                                                                                          : _GEN_21 & _sels_T_2[22] & _sels_T_4[22]
                                                                                              ? 128'h400000
                                                                                              : _GEN_22 & _sels_T_2[23] & _sels_T_4[23]
                                                                                                  ? 128'h800000
                                                                                                  : _GEN_23 & _sels_T_2[24] & _sels_T_4[24]
                                                                                                      ? 128'h1000000
                                                                                                      : _GEN_24 & _sels_T_2[25] & _sels_T_4[25]
                                                                                                          ? 128'h2000000
                                                                                                          : _GEN_25 & _sels_T_2[26] & _sels_T_4[26]
                                                                                                              ? 128'h4000000
                                                                                                              : _GEN_26 & _sels_T_2[27] & _sels_T_4[27]
                                                                                                                  ? 128'h8000000
                                                                                                                  : _GEN_27 & _sels_T_2[28] & _sels_T_4[28]
                                                                                                                      ? 128'h10000000
                                                                                                                      : _GEN_28 & _sels_T_2[29] & _sels_T_4[29]
                                                                                                                          ? 128'h20000000
                                                                                                                          : _GEN_29 & _sels_T_2[30] & _sels_T_4[30]
                                                                                                                              ? 128'h40000000
                                                                                                                              : _GEN_30 & _sels_T_2[31] & _sels_T_4[31]
                                                                                                                                  ? 128'h80000000
                                                                                                                                  : _GEN_31 & _sels_T_2[32] & _sels_T_4[32]
                                                                                                                                      ? 128'h100000000
                                                                                                                                      : _GEN_32 & _sels_T_2[33] & _sels_T_4[33] ? 128'h200000000 : _GEN_33 & _sels_T_2[34] & _sels_T_4[34] ? 128'h400000000 : _GEN_34 & _sels_T_2[35] & _sels_T_4[35] ? 128'h800000000 : _GEN_35 & _sels_T_2[36] & _sels_T_4[36] ? 128'h1000000000 : _GEN_36 & _sels_T_2[37] & _sels_T_4[37] ? 128'h2000000000 : _GEN_37 & _sels_T_2[38] & _sels_T_4[38] ? 128'h4000000000 : _GEN_38 & _sels_T_2[39] & _sels_T_4[39] ? 128'h8000000000 : _GEN_39 & _sels_T_2[40] & _sels_T_4[40] ? 128'h10000000000 : _GEN_40 & _sels_T_2[41] & _sels_T_4[41] ? 128'h20000000000 : _GEN_41 & _sels_T_2[42] & _sels_T_4[42] ? 128'h40000000000 : _GEN_42 & _sels_T_2[43] & _sels_T_4[43] ? 128'h80000000000 : _GEN_43 & _sels_T_2[44] & _sels_T_4[44] ? 128'h100000000000 : _GEN_44 & _sels_T_2[45] & _sels_T_4[45] ? 128'h200000000000 : _GEN_45 & _sels_T_2[46] & _sels_T_4[46] ? 128'h400000000000 : _GEN_46 & _sels_T_2[47] & _sels_T_4[47] ? 128'h800000000000 : _GEN_47 & _sels_T_2[48] & _sels_T_4[48] ? 128'h1000000000000 : _GEN_48 & _sels_T_2[49] & _sels_T_4[49] ? 128'h2000000000000 : _GEN_49 & _sels_T_2[50] & _sels_T_4[50] ? 128'h4000000000000 : _GEN_50 & _sels_T_2[51] & _sels_T_4[51] ? 128'h8000000000000 : _GEN_51 & _sels_T_2[52] & _sels_T_4[52] ? 128'h10000000000000 : _GEN_52 & _sels_T_2[53] & _sels_T_4[53] ? 128'h20000000000000 : _GEN_53 & _sels_T_2[54] & _sels_T_4[54] ? 128'h40000000000000 : _GEN_54 & _sels_T_2[55] & _sels_T_4[55] ? 128'h80000000000000 : _GEN_55 & _sels_T_2[56] & _sels_T_4[56] ? 128'h100000000000000 : _GEN_56 & _sels_T_2[57] & _sels_T_4[57] ? 128'h200000000000000 : _GEN_57 & _sels_T_2[58] & _sels_T_4[58] ? 128'h400000000000000 : _GEN_58 & _sels_T_2[59] & _sels_T_4[59] ? 128'h800000000000000 : _GEN_59 & _sels_T_2[60] & _sels_T_4[60] ? 128'h1000000000000000 : _GEN_60 & _sels_T_2[61] & _sels_T_4[61] ? 128'h2000000000000000 : _GEN_61 & _sels_T_2[62] & _sels_T_4[62] ? 128'h4000000000000000 : _sels_sels_3_T_192;
  wire [127:0] alloc_masks_3 = allocs_3 & {128{io_reqs_3}};
  wire [127:0] alloc_masks_2 = alloc_masks_3 | allocs_2 & {128{io_reqs_2}};
  wire [127:0] alloc_masks_1 = alloc_masks_2 | allocs_1 & {128{io_reqs_1}};
  wire [127:0] alloc_masks_0 = alloc_masks_1 | allocs_0 & {128{io_reqs_0}};
  wire         sel_fire_0 = (~r_valid | io_reqs_0) & (|sels_0);
  wire         sel_fire_1 = (~r_valid_1 | io_reqs_1) & (|sels_1);
  wire         sel_fire_2 = (~r_valid_2 | io_reqs_2) & (|sels_2);
  wire         sel_fire_3 = (~r_valid_3 | io_reqs_3) & (|sels_3);
  wire [3:0]   br_slots = {io_ren_br_tags_3_valid, io_ren_br_tags_2_valid, io_ren_br_tags_1_valid, io_ren_br_tags_0_valid};
  wire         _list_req_WIRE__0 = io_ren_br_tags_0_bits == 5'h0;
  wire         _list_req_WIRE__1 = io_ren_br_tags_1_bits == 5'h0;
  wire         _list_req_WIRE__2 = io_ren_br_tags_2_bits == 5'h0;
  wire         _list_req_WIRE_1_0 = io_ren_br_tags_0_bits == 5'h1;
  wire         _list_req_WIRE_1_1 = io_ren_br_tags_1_bits == 5'h1;
  wire         _list_req_WIRE_1_2 = io_ren_br_tags_2_bits == 5'h1;
  wire         _list_req_WIRE_2_0 = io_ren_br_tags_0_bits == 5'h2;
  wire         _list_req_WIRE_2_1 = io_ren_br_tags_1_bits == 5'h2;
  wire         _list_req_WIRE_2_2 = io_ren_br_tags_2_bits == 5'h2;
  wire         _list_req_WIRE_3_0 = io_ren_br_tags_0_bits == 5'h3;
  wire         _list_req_WIRE_3_1 = io_ren_br_tags_1_bits == 5'h3;
  wire         _list_req_WIRE_3_2 = io_ren_br_tags_2_bits == 5'h3;
  wire         _list_req_WIRE_4_0 = io_ren_br_tags_0_bits == 5'h4;
  wire         _list_req_WIRE_4_1 = io_ren_br_tags_1_bits == 5'h4;
  wire         _list_req_WIRE_4_2 = io_ren_br_tags_2_bits == 5'h4;
  wire         _list_req_WIRE_5_0 = io_ren_br_tags_0_bits == 5'h5;
  wire         _list_req_WIRE_5_1 = io_ren_br_tags_1_bits == 5'h5;
  wire         _list_req_WIRE_5_2 = io_ren_br_tags_2_bits == 5'h5;
  wire         _list_req_WIRE_6_0 = io_ren_br_tags_0_bits == 5'h6;
  wire         _list_req_WIRE_6_1 = io_ren_br_tags_1_bits == 5'h6;
  wire         _list_req_WIRE_6_2 = io_ren_br_tags_2_bits == 5'h6;
  wire         _list_req_WIRE_7_0 = io_ren_br_tags_0_bits == 5'h7;
  wire         _list_req_WIRE_7_1 = io_ren_br_tags_1_bits == 5'h7;
  wire         _list_req_WIRE_7_2 = io_ren_br_tags_2_bits == 5'h7;
  wire         _list_req_WIRE_8_0 = io_ren_br_tags_0_bits == 5'h8;
  wire         _list_req_WIRE_8_1 = io_ren_br_tags_1_bits == 5'h8;
  wire         _list_req_WIRE_8_2 = io_ren_br_tags_2_bits == 5'h8;
  wire         _list_req_WIRE_9_0 = io_ren_br_tags_0_bits == 5'h9;
  wire         _list_req_WIRE_9_1 = io_ren_br_tags_1_bits == 5'h9;
  wire         _list_req_WIRE_9_2 = io_ren_br_tags_2_bits == 5'h9;
  wire         _list_req_WIRE_10_0 = io_ren_br_tags_0_bits == 5'hA;
  wire         _list_req_WIRE_10_1 = io_ren_br_tags_1_bits == 5'hA;
  wire         _list_req_WIRE_10_2 = io_ren_br_tags_2_bits == 5'hA;
  wire         _list_req_WIRE_11_0 = io_ren_br_tags_0_bits == 5'hB;
  wire         _list_req_WIRE_11_1 = io_ren_br_tags_1_bits == 5'hB;
  wire         _list_req_WIRE_11_2 = io_ren_br_tags_2_bits == 5'hB;
  wire         _list_req_WIRE_12_0 = io_ren_br_tags_0_bits == 5'hC;
  wire         _list_req_WIRE_12_1 = io_ren_br_tags_1_bits == 5'hC;
  wire         _list_req_WIRE_12_2 = io_ren_br_tags_2_bits == 5'hC;
  wire         _list_req_WIRE_13_0 = io_ren_br_tags_0_bits == 5'hD;
  wire         _list_req_WIRE_13_1 = io_ren_br_tags_1_bits == 5'hD;
  wire         _list_req_WIRE_13_2 = io_ren_br_tags_2_bits == 5'hD;
  wire         _list_req_WIRE_14_0 = io_ren_br_tags_0_bits == 5'hE;
  wire         _list_req_WIRE_14_1 = io_ren_br_tags_1_bits == 5'hE;
  wire         _list_req_WIRE_14_2 = io_ren_br_tags_2_bits == 5'hE;
  wire         _list_req_WIRE_15_0 = io_ren_br_tags_0_bits == 5'hF;
  wire         _list_req_WIRE_15_1 = io_ren_br_tags_1_bits == 5'hF;
  wire         _list_req_WIRE_15_2 = io_ren_br_tags_2_bits == 5'hF;
  wire         _list_req_WIRE_16_0 = io_ren_br_tags_0_bits == 5'h10;
  wire         _list_req_WIRE_16_1 = io_ren_br_tags_1_bits == 5'h10;
  wire         _list_req_WIRE_16_2 = io_ren_br_tags_2_bits == 5'h10;
  wire         _list_req_WIRE_17_0 = io_ren_br_tags_0_bits == 5'h11;
  wire         _list_req_WIRE_17_1 = io_ren_br_tags_1_bits == 5'h11;
  wire         _list_req_WIRE_17_2 = io_ren_br_tags_2_bits == 5'h11;
  wire         _list_req_WIRE_18_0 = io_ren_br_tags_0_bits == 5'h12;
  wire         _list_req_WIRE_18_1 = io_ren_br_tags_1_bits == 5'h12;
  wire         _list_req_WIRE_18_2 = io_ren_br_tags_2_bits == 5'h12;
  wire         _list_req_WIRE_19_0 = io_ren_br_tags_0_bits == 5'h13;
  wire         _list_req_WIRE_19_1 = io_ren_br_tags_1_bits == 5'h13;
  wire         _list_req_WIRE_19_2 = io_ren_br_tags_2_bits == 5'h13;
  wire [62:0]  _r_sel_T_1 = sels_0[127:65] | sels_0[63:1];
  wire [30:0]  _r_sel_T_3 = _r_sel_T_1[62:32] | _r_sel_T_1[30:0];
  wire [14:0]  _r_sel_T_5 = _r_sel_T_3[30:16] | _r_sel_T_3[14:0];
  wire [6:0]   _r_sel_T_7 = _r_sel_T_5[14:8] | _r_sel_T_5[6:0];
  wire [2:0]   _r_sel_T_9 = _r_sel_T_7[6:4] | _r_sel_T_7[2:0];
  wire [62:0]  _r_sel_T_20 = sels_1[127:65] | sels_1[63:1];
  wire [30:0]  _r_sel_T_22 = _r_sel_T_20[62:32] | _r_sel_T_20[30:0];
  wire [14:0]  _r_sel_T_24 = _r_sel_T_22[30:16] | _r_sel_T_22[14:0];
  wire [6:0]   _r_sel_T_26 = _r_sel_T_24[14:8] | _r_sel_T_24[6:0];
  wire [2:0]   _r_sel_T_28 = _r_sel_T_26[6:4] | _r_sel_T_26[2:0];
  wire [62:0]  _r_sel_T_39 = sels_2[127:65] | sels_2[63:1];
  wire [30:0]  _r_sel_T_41 = _r_sel_T_39[62:32] | _r_sel_T_39[30:0];
  wire [14:0]  _r_sel_T_43 = _r_sel_T_41[30:16] | _r_sel_T_41[14:0];
  wire [6:0]   _r_sel_T_45 = _r_sel_T_43[14:8] | _r_sel_T_43[6:0];
  wire [2:0]   _r_sel_T_47 = _r_sel_T_45[6:4] | _r_sel_T_45[2:0];
  wire [62:0]  _r_sel_T_58 = sels_3[127:65] | sels_3[63:1];
  wire [30:0]  _r_sel_T_60 = _r_sel_T_58[62:32] | _r_sel_T_58[30:0];
  wire [14:0]  _r_sel_T_62 = _r_sel_T_60[30:16] | _r_sel_T_60[14:0];
  wire [6:0]   _r_sel_T_64 = _r_sel_T_62[14:8] | _r_sel_T_62[6:0];
  wire [2:0]   _r_sel_T_66 = _r_sel_T_64[6:4] | _r_sel_T_64[2:0];
  always @(posedge clock) begin
    if (reset) begin
      free_list <= 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE;
      r_valid <= 1'h0;
      r_valid_1 <= 1'h0;
      r_valid_2 <= 1'h0;
      r_valid_3 <= 1'h0;
    end
    else begin
      free_list <= (free_list & ~(sels_0 & {128{sel_fire_0}} | sels_1 & {128{sel_fire_1}} | sels_2 & {128{sel_fire_2}} | sels_3 & {128{sel_fire_3}}) | dealloc_mask) & 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE;
      r_valid <= r_valid & ~io_reqs_0 | (|sels_0);
      r_valid_1 <= r_valid_1 & ~io_reqs_1 | (|sels_1);
      r_valid_2 <= r_valid_2 & ~io_reqs_2 | (|sels_2);
      r_valid_3 <= r_valid_3 & ~io_reqs_3 | (|sels_3);
    end
    if (|({io_ren_br_tags_3_bits == 5'h0, _list_req_WIRE__2, _list_req_WIRE__1, _list_req_WIRE__0} & br_slots))
      br_alloc_lists_0 <= (_list_req_WIRE__0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE__1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE__2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_0 <= br_alloc_lists_0 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'h1, _list_req_WIRE_1_2, _list_req_WIRE_1_1, _list_req_WIRE_1_0} & br_slots))
      br_alloc_lists_1 <= (_list_req_WIRE_1_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_1_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_1_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_1 <= br_alloc_lists_1 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'h2, _list_req_WIRE_2_2, _list_req_WIRE_2_1, _list_req_WIRE_2_0} & br_slots))
      br_alloc_lists_2 <= (_list_req_WIRE_2_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_2_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_2_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_2 <= br_alloc_lists_2 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'h3, _list_req_WIRE_3_2, _list_req_WIRE_3_1, _list_req_WIRE_3_0} & br_slots))
      br_alloc_lists_3 <= (_list_req_WIRE_3_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_3_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_3_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_3 <= br_alloc_lists_3 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'h4, _list_req_WIRE_4_2, _list_req_WIRE_4_1, _list_req_WIRE_4_0} & br_slots))
      br_alloc_lists_4 <= (_list_req_WIRE_4_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_4_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_4_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_4 <= br_alloc_lists_4 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'h5, _list_req_WIRE_5_2, _list_req_WIRE_5_1, _list_req_WIRE_5_0} & br_slots))
      br_alloc_lists_5 <= (_list_req_WIRE_5_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_5_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_5_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_5 <= br_alloc_lists_5 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'h6, _list_req_WIRE_6_2, _list_req_WIRE_6_1, _list_req_WIRE_6_0} & br_slots))
      br_alloc_lists_6 <= (_list_req_WIRE_6_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_6_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_6_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_6 <= br_alloc_lists_6 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'h7, _list_req_WIRE_7_2, _list_req_WIRE_7_1, _list_req_WIRE_7_0} & br_slots))
      br_alloc_lists_7 <= (_list_req_WIRE_7_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_7_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_7_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_7 <= br_alloc_lists_7 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'h8, _list_req_WIRE_8_2, _list_req_WIRE_8_1, _list_req_WIRE_8_0} & br_slots))
      br_alloc_lists_8 <= (_list_req_WIRE_8_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_8_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_8_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_8 <= br_alloc_lists_8 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'h9, _list_req_WIRE_9_2, _list_req_WIRE_9_1, _list_req_WIRE_9_0} & br_slots))
      br_alloc_lists_9 <= (_list_req_WIRE_9_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_9_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_9_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_9 <= br_alloc_lists_9 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'hA, _list_req_WIRE_10_2, _list_req_WIRE_10_1, _list_req_WIRE_10_0} & br_slots))
      br_alloc_lists_10 <= (_list_req_WIRE_10_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_10_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_10_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_10 <= br_alloc_lists_10 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'hB, _list_req_WIRE_11_2, _list_req_WIRE_11_1, _list_req_WIRE_11_0} & br_slots))
      br_alloc_lists_11 <= (_list_req_WIRE_11_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_11_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_11_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_11 <= br_alloc_lists_11 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'hC, _list_req_WIRE_12_2, _list_req_WIRE_12_1, _list_req_WIRE_12_0} & br_slots))
      br_alloc_lists_12 <= (_list_req_WIRE_12_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_12_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_12_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_12 <= br_alloc_lists_12 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'hD, _list_req_WIRE_13_2, _list_req_WIRE_13_1, _list_req_WIRE_13_0} & br_slots))
      br_alloc_lists_13 <= (_list_req_WIRE_13_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_13_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_13_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_13 <= br_alloc_lists_13 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'hE, _list_req_WIRE_14_2, _list_req_WIRE_14_1, _list_req_WIRE_14_0} & br_slots))
      br_alloc_lists_14 <= (_list_req_WIRE_14_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_14_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_14_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_14 <= br_alloc_lists_14 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'hF, _list_req_WIRE_15_2, _list_req_WIRE_15_1, _list_req_WIRE_15_0} & br_slots))
      br_alloc_lists_15 <= (_list_req_WIRE_15_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_15_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_15_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_15 <= br_alloc_lists_15 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'h10, _list_req_WIRE_16_2, _list_req_WIRE_16_1, _list_req_WIRE_16_0} & br_slots))
      br_alloc_lists_16 <= (_list_req_WIRE_16_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_16_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_16_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_16 <= br_alloc_lists_16 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'h11, _list_req_WIRE_17_2, _list_req_WIRE_17_1, _list_req_WIRE_17_0} & br_slots))
      br_alloc_lists_17 <= (_list_req_WIRE_17_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_17_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_17_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_17 <= br_alloc_lists_17 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'h12, _list_req_WIRE_18_2, _list_req_WIRE_18_1, _list_req_WIRE_18_0} & br_slots))
      br_alloc_lists_18 <= (_list_req_WIRE_18_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_18_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_18_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_18 <= br_alloc_lists_18 & ~br_deallocs | alloc_masks_0;
    if (|({io_ren_br_tags_3_bits == 5'h13, _list_req_WIRE_19_2, _list_req_WIRE_19_1, _list_req_WIRE_19_0} & br_slots))
      br_alloc_lists_19 <= (_list_req_WIRE_19_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0) | (_list_req_WIRE_19_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0) | (_list_req_WIRE_19_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);
    else
      br_alloc_lists_19 <= br_alloc_lists_19 & ~br_deallocs | alloc_masks_0;
    if (sel_fire_0)
      r_sel <= {|(sels_0[127:64]), |(_r_sel_T_1[62:31]), |(_r_sel_T_3[30:15]), |(_r_sel_T_5[14:7]), |(_r_sel_T_7[6:3]), |(_r_sel_T_9[2:1]), _r_sel_T_9[2] | _r_sel_T_9[0]};
    if (sel_fire_1)
      r_sel_1 <= {|(sels_1[127:64]), |(_r_sel_T_20[62:31]), |(_r_sel_T_22[30:15]), |(_r_sel_T_24[14:7]), |(_r_sel_T_26[6:3]), |(_r_sel_T_28[2:1]), _r_sel_T_28[2] | _r_sel_T_28[0]};
    if (sel_fire_2)
      r_sel_2 <= {|(sels_2[127:64]), |(_r_sel_T_39[62:31]), |(_r_sel_T_41[30:15]), |(_r_sel_T_43[14:7]), |(_r_sel_T_45[6:3]), |(_r_sel_T_47[2:1]), _r_sel_T_47[2] | _r_sel_T_47[0]};
    if (sel_fire_3)
      r_sel_3 <= {|(sels_3[127:64]), |(_r_sel_T_58[62:31]), |(_r_sel_T_60[30:15]), |(_r_sel_T_62[14:7]), |(_r_sel_T_64[6:3]), |(_r_sel_T_66[2:1]), _r_sel_T_66[2] | _r_sel_T_66[0]};
  end // always @(posedge)
  assign io_alloc_pregs_0_valid = r_valid;
  assign io_alloc_pregs_0_bits = r_sel;
  assign io_alloc_pregs_1_valid = r_valid_1;
  assign io_alloc_pregs_1_bits = r_sel_1;
  assign io_alloc_pregs_2_valid = r_valid_2;
  assign io_alloc_pregs_2_bits = r_sel_2;
  assign io_alloc_pregs_3_valid = r_valid_3;
  assign io_alloc_pregs_3_bits = r_sel_3;
endmodule

