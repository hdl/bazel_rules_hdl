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
module ALUExeUnit_2_assert(
  input queue_io_enq_ready,
        reset,
        clock
);

  always @(posedge clock) begin
    if (~reset)
      assert__assert_1: assert(queue_io_enq_ready);
  end // always @(posedge)
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~queue_io_enq_ready)
        $fwrite(32'h80000002, "Assertion failed\n    at execution-unit.scala:360 assert (queue.io.enq.ready)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule

