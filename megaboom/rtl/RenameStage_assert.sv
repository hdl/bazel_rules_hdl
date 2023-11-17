// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

// VCS coverage exclude_file
module RenameStage_assert(
  input [6:0] freelist_io_alloc_pregs_3_bits,
  input       ren2_alloc_reqs_3,
  input [6:0] freelist_io_alloc_pregs_2_bits,
  input       ren2_alloc_reqs_2,
  input [6:0] freelist_io_alloc_pregs_1_bits,
  input       ren2_alloc_reqs_1,
  input [6:0] freelist_io_alloc_pregs_0_bits,
  input       ren2_alloc_reqs_0,
              io_wakeups_9_valid,
  input [1:0] io_wakeups_9_bits_uop_dst_rtype,
  input       io_wakeups_8_valid,
  input [1:0] io_wakeups_8_bits_uop_dst_rtype,
  input       io_wakeups_7_valid,
  input [1:0] io_wakeups_7_bits_uop_dst_rtype,
  input       io_wakeups_6_valid,
  input [1:0] io_wakeups_6_bits_uop_dst_rtype,
  input       io_wakeups_5_valid,
  input [1:0] io_wakeups_5_bits_uop_dst_rtype,
  input       io_wakeups_4_valid,
  input [1:0] io_wakeups_4_bits_uop_dst_rtype,
  input       io_wakeups_3_valid,
  input [1:0] io_wakeups_3_bits_uop_dst_rtype,
  input       io_wakeups_2_valid,
  input [1:0] io_wakeups_2_bits_uop_dst_rtype,
  input       io_wakeups_1_valid,
  input [1:0] io_wakeups_1_bits_uop_dst_rtype,
  input       io_wakeups_0_valid,
  input [1:0] io_wakeups_0_bits_uop_dst_rtype,
  input       r_valid,
              busytable_io_busy_resps_0_prs1_busy,
  input [5:0] r_uop_lrs1,
  input       busytable_io_busy_resps_0_prs2_busy,
  input [5:0] r_uop_lrs2,
  input       r_valid_1,
              busytable_io_busy_resps_1_prs1_busy,
  input [5:0] r_uop_1_lrs1,
  input       busytable_io_busy_resps_1_prs2_busy,
  input [5:0] r_uop_1_lrs2,
  input       r_valid_2,
              busytable_io_busy_resps_2_prs1_busy,
  input [5:0] r_uop_2_lrs1,
  input       busytable_io_busy_resps_2_prs2_busy,
  input [5:0] r_uop_2_lrs2,
  input       r_valid_3,
              busytable_io_busy_resps_3_prs1_busy,
  input [5:0] r_uop_3_lrs1,
  input       busytable_io_busy_resps_3_prs2_busy,
  input [5:0] r_uop_3_lrs2,
  input       reset,
              clock
);

  wire _GEN = (~ren2_alloc_reqs_0 | (|freelist_io_alloc_pregs_0_bits)) & (~ren2_alloc_reqs_1 | (|freelist_io_alloc_pregs_1_bits)) & (~ren2_alloc_reqs_2 | (|freelist_io_alloc_pregs_2_bits)) & (~ren2_alloc_reqs_3 | (|freelist_io_alloc_pregs_3_bits));
  wire _GEN_0 = io_wakeups_0_valid & (|io_wakeups_0_bits_uop_dst_rtype) | io_wakeups_1_valid & (|io_wakeups_1_bits_uop_dst_rtype) | io_wakeups_2_valid & (|io_wakeups_2_bits_uop_dst_rtype) | io_wakeups_3_valid & (|io_wakeups_3_bits_uop_dst_rtype) | io_wakeups_4_valid & (|io_wakeups_4_bits_uop_dst_rtype) | io_wakeups_5_valid & (|io_wakeups_5_bits_uop_dst_rtype) | io_wakeups_6_valid & (|io_wakeups_6_bits_uop_dst_rtype) | io_wakeups_7_valid & (|io_wakeups_7_bits_uop_dst_rtype) | io_wakeups_8_valid & (|io_wakeups_8_bits_uop_dst_rtype) | io_wakeups_9_valid & (|io_wakeups_9_bits_uop_dst_rtype);
  wire _GEN_1 = r_valid & busytable_io_busy_resps_0_prs1_busy & r_uop_lrs1 == 6'h0;
  wire _GEN_2 = r_valid & busytable_io_busy_resps_0_prs2_busy & r_uop_lrs2 == 6'h0;
  wire _GEN_3 = r_valid_1 & busytable_io_busy_resps_1_prs1_busy & r_uop_1_lrs1 == 6'h0;
  wire _GEN_4 = r_valid_1 & busytable_io_busy_resps_1_prs2_busy & r_uop_1_lrs2 == 6'h0;
  wire _GEN_5 = r_valid_2 & busytable_io_busy_resps_2_prs1_busy & r_uop_2_lrs1 == 6'h0;
  wire _GEN_6 = r_valid_2 & busytable_io_busy_resps_2_prs2_busy & r_uop_2_lrs2 == 6'h0;
  wire _GEN_7 = r_valid_3 & busytable_io_busy_resps_3_prs1_busy & r_uop_3_lrs1 == 6'h0;
  wire _GEN_8 = r_valid_3 & busytable_io_busy_resps_3_prs2_busy & r_uop_3_lrs2 == 6'h0;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed: [rename-stage] A uop is trying to allocate the zero physical register.\n    at rename-stage.scala:300 assert (ren2_alloc_reqs zip freelist.io.alloc_pregs map {case (r,p) => !r || p.bits =/= 0.U} reduce (_&&_),\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_0)
        $fwrite(32'h80000002, "Assertion failed: [rename] Wakeup has wrong rtype.\n    at rename-stage.scala:317 assert (!(io.wakeups.map(x => x.valid && x.bits.uop.dst_rtype =/= rtype).reduce(_||_)),\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_1)
        $fwrite(32'h80000002, "Assertion failed: [rename] x0 is busy??\n    at rename-stage.scala:328 assert (!(valid && busy.prs1_busy && rtype === RT_FIX && uop.lrs1 === 0.U), \"[rename] x0 is busy??\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_2)
        $fwrite(32'h80000002, "Assertion failed: [rename] x0 is busy??\n    at rename-stage.scala:329 assert (!(valid && busy.prs2_busy && rtype === RT_FIX && uop.lrs2 === 0.U), \"[rename] x0 is busy??\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_3)
        $fwrite(32'h80000002, "Assertion failed: [rename] x0 is busy??\n    at rename-stage.scala:328 assert (!(valid && busy.prs1_busy && rtype === RT_FIX && uop.lrs1 === 0.U), \"[rename] x0 is busy??\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_4)
        $fwrite(32'h80000002, "Assertion failed: [rename] x0 is busy??\n    at rename-stage.scala:329 assert (!(valid && busy.prs2_busy && rtype === RT_FIX && uop.lrs2 === 0.U), \"[rename] x0 is busy??\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_5)
        $fwrite(32'h80000002, "Assertion failed: [rename] x0 is busy??\n    at rename-stage.scala:328 assert (!(valid && busy.prs1_busy && rtype === RT_FIX && uop.lrs1 === 0.U), \"[rename] x0 is busy??\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_6)
        $fwrite(32'h80000002, "Assertion failed: [rename] x0 is busy??\n    at rename-stage.scala:329 assert (!(valid && busy.prs2_busy && rtype === RT_FIX && uop.lrs2 === 0.U), \"[rename] x0 is busy??\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_7)
        $fwrite(32'h80000002, "Assertion failed: [rename] x0 is busy??\n    at rename-stage.scala:328 assert (!(valid && busy.prs1_busy && rtype === RT_FIX && uop.lrs1 === 0.U), \"[rename] x0 is busy??\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_8)
        $fwrite(32'h80000002, "Assertion failed: [rename] x0 is busy??\n    at rename-stage.scala:329 assert (!(valid && busy.prs2_busy && rtype === RT_FIX && uop.lrs2 === 0.U), \"[rename] x0 is busy??\")\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(_GEN);
      assert__assert_1: assert(~_GEN_0);
      assert__assert_2: assert(~_GEN_1);
      assert__assert_3: assert(~_GEN_2);
      assert__assert_4: assert(~_GEN_3);
      assert__assert_5: assert(~_GEN_4);
      assert__assert_6: assert(~_GEN_5);
      assert__assert_7: assert(~_GEN_6);
      assert__assert_8: assert(~_GEN_7);
      assert__assert_9: assert(~_GEN_8);
    end
  end // always @(posedge)
endmodule

