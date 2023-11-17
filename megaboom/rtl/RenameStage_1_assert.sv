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
module RenameStage_1_assert(
  input [6:0] freelist_io_alloc_pregs_3_bits,
  input       ren2_alloc_reqs_3,
  input [6:0] freelist_io_alloc_pregs_2_bits,
  input       ren2_alloc_reqs_2,
  input [6:0] freelist_io_alloc_pregs_1_bits,
  input       ren2_alloc_reqs_1,
  input [6:0] freelist_io_alloc_pregs_0_bits,
  input       ren2_alloc_reqs_0,
              io_wakeups_3_valid,
  input [1:0] io_wakeups_3_bits_uop_dst_rtype,
  input       io_wakeups_2_valid,
  input [1:0] io_wakeups_2_bits_uop_dst_rtype,
  input       io_wakeups_1_valid,
  input [1:0] io_wakeups_1_bits_uop_dst_rtype,
  input       io_wakeups_0_valid,
  input [1:0] io_wakeups_0_bits_uop_dst_rtype,
  input       reset,
              clock
);

  wire _GEN = (~ren2_alloc_reqs_0 | (|freelist_io_alloc_pregs_0_bits)) & (~ren2_alloc_reqs_1 | (|freelist_io_alloc_pregs_1_bits)) & (~ren2_alloc_reqs_2 | (|freelist_io_alloc_pregs_2_bits)) & (~ren2_alloc_reqs_3 | (|freelist_io_alloc_pregs_3_bits));
  wire _GEN_0 = io_wakeups_0_valid & io_wakeups_0_bits_uop_dst_rtype != 2'h1 | io_wakeups_1_valid & io_wakeups_1_bits_uop_dst_rtype != 2'h1 | io_wakeups_2_valid & io_wakeups_2_bits_uop_dst_rtype != 2'h1 | io_wakeups_3_valid & io_wakeups_3_bits_uop_dst_rtype != 2'h1;
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(_GEN);
      assert__assert_1: assert(~_GEN_0);
    end
  end // always @(posedge)
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed: [rename-stage] A uop is trying to allocate the zero physical register.\n    at rename-stage.scala:300 assert (ren2_alloc_reqs zip freelist.io.alloc_pregs map {case (r,p) => !r || p.bits =/= 0.U} reduce (_&&_),\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_0)
        $fwrite(32'h80000002, "Assertion failed: [rename] Wakeup has wrong rtype.\n    at rename-stage.scala:317 assert (!(io.wakeups.map(x => x.valid && x.bits.uop.dst_rtype =/= rtype).reduce(_||_)),\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule

