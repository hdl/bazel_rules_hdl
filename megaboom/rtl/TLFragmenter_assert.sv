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
module TLFragmenter_assert(
  input       _repeater_io_repeat_T,
              repeater_io_full,
  input [7:0] repeater_io_deq_bits_mask,
  input       reset,
              clock
);

  wire _GEN = ~repeater_io_full | _repeater_io_repeat_T;
  wire _GEN_0 = ~repeater_io_full | (&repeater_io_deq_bits_mask);
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at Fragmenter.scala:311 assert (!repeater.io.full || !aHasData)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed\n    at Fragmenter.scala:314 assert (!repeater.io.full || in_a.bits.mask === fullMask)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert_1: assert(_GEN);
      assert__assert_2: assert(_GEN_0);
    end
  end // always @(posedge)
endmodule

