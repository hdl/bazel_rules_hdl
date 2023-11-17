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
module ICache_assert(
  input s1_valid,
        s1_tag_hit_7,
        s1_tag_hit_6,
        s1_tag_hit_5,
        s1_tag_hit_4,
        s1_tag_hit_3,
        s1_tag_hit_2,
        s1_tag_hit_1,
        s1_tag_hit_0,
        reset,
        clock
);

  wire _GEN = {1'h0, {1'h0, {1'h0, s1_tag_hit_0} + {1'h0, s1_tag_hit_1}} + {1'h0, {1'h0, s1_tag_hit_2} + {1'h0, s1_tag_hit_3}}} + {1'h0, {1'h0, {1'h0, s1_tag_hit_4} + {1'h0, s1_tag_hit_5}} + {1'h0, {1'h0, s1_tag_hit_6} + {1'h0, s1_tag_hit_7}}} < 4'h2 | ~s1_valid;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at icache.scala:180 assert(PopCount(s1_tag_hit) <= 1.U || !s1_valid)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset)
      assert__assert: assert(_GEN);
  end // always @(posedge)
endmodule

