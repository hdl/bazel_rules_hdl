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
module TLXbar_assert(
  input winner__1,
        prefixOR_1,
        _out_0_a_valid_T,
        winner_1_1,
        winner_1_0,
        _out_1_a_valid_T,
        winner_2_1,
        winner_2_0,
        _in_0_d_valid_T,
        winner_3_1,
        winner_3_0,
        _in_1_d_valid_T,
        reset,
        clock
);

  wire _GEN = ~prefixOR_1 | ~winner__1;
  wire _GEN_0 = ~_out_0_a_valid_T | prefixOR_1 | winner__1;
  wire _GEN_1 = ~winner_1_0 | ~winner_1_1;
  wire _GEN_2 = ~_out_1_a_valid_T | winner_1_0 | winner_1_1;
  wire _GEN_3 = ~winner_2_0 | ~winner_2_1;
  wire _GEN_4 = ~_in_0_d_valid_T | winner_2_0 | winner_2_1;
  wire _GEN_5 = ~winner_3_0 | ~winner_3_1;
  wire _GEN_6 = ~_in_1_d_valid_T | winner_3_0 | winner_3_1;
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
      if ((`PRINTF_COND_) & ~reset & ~_GEN_3)
        $fwrite(32'h80000002, "Assertion failed\n    at Arbiter.scala:77 assert((prefixOR zip winner) map { case (p,w) => !p || !w } reduce {_ && _})\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_4)
        $fwrite(32'h80000002, "Assertion failed\n    at Arbiter.scala:79 assert (!valids.reduce(_||_) || winner.reduce(_||_))\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_5)
        $fwrite(32'h80000002, "Assertion failed\n    at Arbiter.scala:77 assert((prefixOR zip winner) map { case (p,w) => !p || !w } reduce {_ && _})\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_6)
        $fwrite(32'h80000002, "Assertion failed\n    at Arbiter.scala:79 assert (!valids.reduce(_||_) || winner.reduce(_||_))\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(_GEN);
      assert__assert_1: assert(_GEN_0);
      assert__assert_2: assert(_GEN_1);
      assert__assert_3: assert(_GEN_2);
      assert__assert_4: assert(_GEN_3);
      assert__assert_5: assert(_GEN_4);
      assert__assert_6: assert(_GEN_5);
      assert__assert_7: assert(_GEN_6);
    end
  end // always @(posedge)
endmodule

