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
module TLCacheCork_assert(
  input _nodeIn_c_ready_T,
        _c_a_valid_T,
        auto_in_c_valid,
        winner__1,
        c_a_valid,
        _nodeOut_a_valid_T,
        winner_1_2,
        auto_out_d_valid,
        winner_1_1,
        _in_d_valid_T,
        q_1_io_deq_valid,
        reset,
        clock
);

  wire _GEN = ~auto_in_c_valid | _nodeIn_c_ready_T | _c_a_valid_T;
  wire _GEN_0 = ~c_a_valid | ~winner__1;
  wire _GEN_1 = ~_nodeOut_a_valid_T | c_a_valid | winner__1;
  wire _GEN_2 = (~auto_out_d_valid | ~winner_1_1) & (~(auto_out_d_valid | winner_1_1) | ~winner_1_2);
  wire _GEN_3 = ~(_in_d_valid_T | q_1_io_deq_valid) | auto_out_d_valid | winner_1_1 | winner_1_2;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at CacheCork.scala:108 assert (!in.c.valid || in.c.bits.opcode === Release || in.c.bits.opcode === ReleaseData)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed\n    at Arbiter.scala:77 assert((prefixOR zip winner) map { case (p,w) => !p || !w } reduce {_ && _})\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_1)
        $fwrite(32'h80000002, "Assertion failed\n    at Arbiter.scala:79 assert (!valids.reduce(_||_) || winner.reduce(_||_))\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_2)
        $fwrite(32'h80000002, "Assertion failed\n    at Arbiter.scala:77 assert((prefixOR zip winner) map { case (p,w) => !p || !w } reduce {_ && _})\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_3)
        $fwrite(32'h80000002, "Assertion failed\n    at Arbiter.scala:79 assert (!valids.reduce(_||_) || winner.reduce(_||_))\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(_GEN);
      assert__assert_2: assert(_GEN_0);
      assert__assert_3: assert(_GEN_1);
      assert__assert_4: assert(_GEN_2);
      assert__assert_5: assert(_GEN_3);
    end
  end // always @(posedge)
endmodule

