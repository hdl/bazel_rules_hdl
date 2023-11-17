// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RenameBusyTable_1(
  input        clock,
               reset,
  input  [6:0] io_ren_uops_0_pdst,
               io_ren_uops_0_prs1,
               io_ren_uops_0_prs2,
               io_ren_uops_0_prs3,
               io_ren_uops_1_pdst,
               io_ren_uops_1_prs1,
               io_ren_uops_1_prs2,
               io_ren_uops_1_prs3,
               io_ren_uops_2_pdst,
               io_ren_uops_2_prs1,
               io_ren_uops_2_prs2,
               io_ren_uops_2_prs3,
               io_ren_uops_3_pdst,
               io_ren_uops_3_prs1,
               io_ren_uops_3_prs2,
               io_ren_uops_3_prs3,
  input        io_rebusy_reqs_0,
               io_rebusy_reqs_1,
               io_rebusy_reqs_2,
               io_rebusy_reqs_3,
  input  [6:0] io_wb_pdsts_0,
               io_wb_pdsts_1,
               io_wb_pdsts_2,
               io_wb_pdsts_3,
  input        io_wb_valids_0,
               io_wb_valids_1,
               io_wb_valids_2,
               io_wb_valids_3,
  output       io_busy_resps_0_prs1_busy,
               io_busy_resps_0_prs2_busy,
               io_busy_resps_0_prs3_busy,
               io_busy_resps_1_prs1_busy,
               io_busy_resps_1_prs2_busy,
               io_busy_resps_1_prs3_busy,
               io_busy_resps_2_prs1_busy,
               io_busy_resps_2_prs2_busy,
               io_busy_resps_2_prs3_busy,
               io_busy_resps_3_prs1_busy,
               io_busy_resps_3_prs2_busy,
               io_busy_resps_3_prs3_busy
);

  reg  [127:0] busy_table;
  wire [127:0] _io_busy_resps_0_prs1_busy_T = busy_table >> io_ren_uops_0_prs1;
  wire [127:0] _io_busy_resps_0_prs2_busy_T = busy_table >> io_ren_uops_0_prs2;
  wire [127:0] _io_busy_resps_0_prs3_busy_T = busy_table >> io_ren_uops_0_prs3;
  wire [127:0] _io_busy_resps_1_prs1_busy_T = busy_table >> io_ren_uops_1_prs1;
  wire [127:0] _io_busy_resps_1_prs2_busy_T = busy_table >> io_ren_uops_1_prs2;
  wire [127:0] _io_busy_resps_1_prs3_busy_T = busy_table >> io_ren_uops_1_prs3;
  wire [127:0] _io_busy_resps_2_prs1_busy_T = busy_table >> io_ren_uops_2_prs1;
  wire [127:0] _io_busy_resps_2_prs2_busy_T = busy_table >> io_ren_uops_2_prs2;
  wire [127:0] _io_busy_resps_2_prs3_busy_T = busy_table >> io_ren_uops_2_prs3;
  wire [127:0] _io_busy_resps_3_prs1_busy_T = busy_table >> io_ren_uops_3_prs1;
  wire [127:0] _io_busy_resps_3_prs2_busy_T = busy_table >> io_ren_uops_3_prs2;
  wire [127:0] _io_busy_resps_3_prs3_busy_T = busy_table >> io_ren_uops_3_prs3;
  always @(posedge clock) begin
    if (reset)
      busy_table <= 128'h0;
    else
      busy_table <= busy_table & ~(128'h1 << io_wb_pdsts_0 & {128{io_wb_valids_0}} | 128'h1 << io_wb_pdsts_1 & {128{io_wb_valids_1}} | 128'h1 << io_wb_pdsts_2 & {128{io_wb_valids_2}} | 128'h1 << io_wb_pdsts_3 & {128{io_wb_valids_3}}) | 128'h1 << io_ren_uops_0_pdst & {128{io_rebusy_reqs_0}} | 128'h1 << io_ren_uops_1_pdst & {128{io_rebusy_reqs_1}} | 128'h1 << io_ren_uops_2_pdst & {128{io_rebusy_reqs_2}} | 128'h1 << io_ren_uops_3_pdst & {128{io_rebusy_reqs_3}};
  end // always @(posedge)
  assign io_busy_resps_0_prs1_busy = _io_busy_resps_0_prs1_busy_T[0];
  assign io_busy_resps_0_prs2_busy = _io_busy_resps_0_prs2_busy_T[0];
  assign io_busy_resps_0_prs3_busy = _io_busy_resps_0_prs3_busy_T[0];
  assign io_busy_resps_1_prs1_busy = _io_busy_resps_1_prs1_busy_T[0];
  assign io_busy_resps_1_prs2_busy = _io_busy_resps_1_prs2_busy_T[0];
  assign io_busy_resps_1_prs3_busy = _io_busy_resps_1_prs3_busy_T[0];
  assign io_busy_resps_2_prs1_busy = _io_busy_resps_2_prs1_busy_T[0];
  assign io_busy_resps_2_prs2_busy = _io_busy_resps_2_prs2_busy_T[0];
  assign io_busy_resps_2_prs3_busy = _io_busy_resps_2_prs3_busy_T[0];
  assign io_busy_resps_3_prs1_busy = _io_busy_resps_3_prs1_busy_T[0];
  assign io_busy_resps_3_prs2_busy = _io_busy_resps_3_prs2_busy_T[0];
  assign io_busy_resps_3_prs3_busy = _io_busy_resps_3_prs3_busy_T[0];
endmodule

