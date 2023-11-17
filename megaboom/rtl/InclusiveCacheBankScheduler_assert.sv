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
module InclusiveCacheBankScheduler_assert(
  input sinkC_io_req_valid,
        _GEN,
        reset,
        clock,
        request_bits_prio_0
);

  wire _GEN_0 = _GEN & ~reset;
  always @(posedge clock) begin
    if (_GEN_0)
      assert__assert_1: assert(sinkC_io_req_valid);
  end // always @(posedge)
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_0 & request_bits_prio_0)
        $fwrite(32'h80000002, "Assertion failed\n    at Scheduler.scala:299 assert (!request.bits.prio(0))\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule

