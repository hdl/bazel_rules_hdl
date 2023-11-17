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
module TLXbar_5_assert(
  input winner_7,
        winner_6,
        winner_5,
        winner_4,
        winner_3,
        winner_2,
        winner_0,
        winner_1,
        _in_0_d_valid_T,
        auto_out_2_d_valid,
        auto_out_3_d_valid,
        auto_out_4_d_valid,
        auto_out_5_d_valid,
        auto_out_6_d_valid,
        auto_out_7_d_valid,
        reset,
        clock
);

  wire prefixOR_2 = winner_0 | winner_1;
  wire prefixOR_3 = prefixOR_2 | winner_2;
  wire prefixOR_4 = prefixOR_3 | winner_3;
  wire prefixOR_5 = prefixOR_4 | winner_4;
  wire prefixOR_6 = prefixOR_5 | winner_5;
  wire _GEN = (~winner_0 | ~winner_1) & (~prefixOR_2 | ~winner_2) & (~prefixOR_3 | ~winner_3) & (~prefixOR_4 | ~winner_4) & (~prefixOR_5 | ~winner_5) & (~prefixOR_6 | ~winner_6) & (~(prefixOR_6 | winner_6) | ~winner_7);
  wire _GEN_0 = ~(_in_0_d_valid_T | auto_out_2_d_valid | auto_out_3_d_valid | auto_out_4_d_valid | auto_out_5_d_valid | auto_out_6_d_valid | auto_out_7_d_valid) | winner_0 | winner_1 | winner_2 | winner_3 | winner_4 | winner_5 | winner_6 | winner_7;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at Arbiter.scala:77 assert((prefixOR zip winner) map { case (p,w) => !p || !w } reduce {_ && _})\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed\n    at Arbiter.scala:79 assert (!valids.reduce(_||_) || winner.reduce(_||_))\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(_GEN);
      assert__assert_1: assert(_GEN_0);
    end
  end // always @(posedge)
endmodule

