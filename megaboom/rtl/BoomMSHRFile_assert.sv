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
module BoomMSHRFile_assert(
  input winner__8,
        winner__7,
        winner__6,
        winner__5,
        winner__4,
        winner__3,
        winner__2,
        mshrs_0_io_mem_acquire_valid,
        winner__1,
        _io_mem_acquire_valid_T,
        mshrs_2_io_mem_acquire_valid,
        mshrs_3_io_mem_acquire_valid,
        mshrs_4_io_mem_acquire_valid,
        mshrs_5_io_mem_acquire_valid,
        mshrs_6_io_mem_acquire_valid,
        mshrs_7_io_mem_acquire_valid,
        mmios_0_io_mem_access_valid,
        winner_1_7,
        winner_1_6,
        winner_1_5,
        winner_1_4,
        winner_1_3,
        winner_1_2,
        mshrs_0_io_mem_finish_valid,
        winner_1_1,
        _io_mem_finish_valid_T,
        mshrs_2_io_mem_finish_valid,
        mshrs_3_io_mem_finish_valid,
        mshrs_4_io_mem_finish_valid,
        mshrs_5_io_mem_finish_valid,
        mshrs_6_io_mem_finish_valid,
        mshrs_7_io_mem_finish_valid,
        reset,
        clock
);

  wire prefixOR_2 = mshrs_0_io_mem_acquire_valid | winner__1;
  wire prefixOR_3 = prefixOR_2 | winner__2;
  wire prefixOR_4 = prefixOR_3 | winner__3;
  wire prefixOR_5 = prefixOR_4 | winner__4;
  wire prefixOR_6 = prefixOR_5 | winner__5;
  wire prefixOR_7 = prefixOR_6 | winner__6;
  wire _GEN = (~mshrs_0_io_mem_acquire_valid | ~winner__1) & (~prefixOR_2 | ~winner__2) & (~prefixOR_3 | ~winner__3) & (~prefixOR_4 | ~winner__4) & (~prefixOR_5 | ~winner__5) & (~prefixOR_6 | ~winner__6) & (~prefixOR_7 | ~winner__7) & (~(prefixOR_7 | winner__7) | ~winner__8);
  wire _GEN_0 = ~(_io_mem_acquire_valid_T | mshrs_2_io_mem_acquire_valid | mshrs_3_io_mem_acquire_valid | mshrs_4_io_mem_acquire_valid | mshrs_5_io_mem_acquire_valid | mshrs_6_io_mem_acquire_valid | mshrs_7_io_mem_acquire_valid | mmios_0_io_mem_access_valid) | mshrs_0_io_mem_acquire_valid | winner__1 | winner__2 | winner__3 | winner__4 | winner__5 | winner__6 | winner__7 | winner__8;
  wire prefixOR_2_1 = mshrs_0_io_mem_finish_valid | winner_1_1;
  wire prefixOR_3_1 = prefixOR_2_1 | winner_1_2;
  wire prefixOR_4_1 = prefixOR_3_1 | winner_1_3;
  wire prefixOR_5_1 = prefixOR_4_1 | winner_1_4;
  wire prefixOR_6_1 = prefixOR_5_1 | winner_1_5;
  wire _GEN_1 = (~mshrs_0_io_mem_finish_valid | ~winner_1_1) & (~prefixOR_2_1 | ~winner_1_2) & (~prefixOR_3_1 | ~winner_1_3) & (~prefixOR_4_1 | ~winner_1_4) & (~prefixOR_5_1 | ~winner_1_5) & (~prefixOR_6_1 | ~winner_1_6) & (~(prefixOR_6_1 | winner_1_6) | ~winner_1_7);
  wire _GEN_2 = ~(_io_mem_finish_valid_T | mshrs_2_io_mem_finish_valid | mshrs_3_io_mem_finish_valid | mshrs_4_io_mem_finish_valid | mshrs_5_io_mem_finish_valid | mshrs_6_io_mem_finish_valid | mshrs_7_io_mem_finish_valid) | mshrs_0_io_mem_finish_valid | winner_1_1 | winner_1_2 | winner_1_3 | winner_1_4 | winner_1_5 | winner_1_6 | winner_1_7;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at Arbiter.scala:77 assert((prefixOR zip winner) map { case (p,w) => !p || !w } reduce {_ && _})\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed\n    at Arbiter.scala:79 assert (!valids.reduce(_||_) || winner.reduce(_||_))\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_1)
        $fwrite(32'h80000002, "Assertion failed\n    at Arbiter.scala:77 assert((prefixOR zip winner) map { case (p,w) => !p || !w } reduce {_ && _})\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_2)
        $fwrite(32'h80000002, "Assertion failed\n    at Arbiter.scala:79 assert (!valids.reduce(_||_) || winner.reduce(_||_))\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(_GEN);
      assert__assert_1: assert(_GEN_0);
      assert__assert_2: assert(_GEN_1);
      assert__assert_3: assert(_GEN_2);
    end
  end // always @(posedge)
endmodule

