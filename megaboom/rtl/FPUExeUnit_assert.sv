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
module FPUExeUnit_assert(
  input queue_io_enq_ready,
        _fp_sdq_io_enq_valid_T_5,
        fp_sdq_io_enq_ready,
        reset,
        clock
);

  wire _GEN = _fp_sdq_io_enq_valid_T_5 & ~fp_sdq_io_enq_ready;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~queue_io_enq_ready)
        $fwrite(32'h80000002, "Assertion failed\n    at execution-unit.scala:550 assert (queue.io.enq.ready) // If this backs up, we've miscalculated the size of the queue.\n");
      if ((`PRINTF_COND_) & ~reset & _GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at execution-unit.scala:562 assert(!(fp_sdq.io.enq.valid && !fp_sdq.io.enq.ready))\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert_1: assert(queue_io_enq_ready);
      assert__assert_2: assert(~_GEN);
    end
  end // always @(posedge)
endmodule

