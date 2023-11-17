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
module SinkD_assert(
  input d_q_io_deq_valid,
        d_q_io_deq_bits_corrupt,
        d_q_io_deq_bits_denied,
        reset,
        clock
);

  wire _GEN = d_q_io_deq_valid & d_q_io_deq_bits_corrupt & ~d_q_io_deq_bits_denied;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & _GEN)
        $fwrite(32'h80000002, "Assertion failed: Data poisoning unsupported\n    at SinkD.scala:82 assert (!(d.valid && d.bits.corrupt && !d.bits.denied), \"Data poisoning unsupported\")\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset)
      assert__assert: assert(~_GEN);
  end // always @(posedge)
endmodule

