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
module UARTAdapter_assert(
  input txq_io_enq_ready,
        txm_io_out_valid,
        reset,
        clock
);

  wire _GEN = txm_io_out_valid & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN & ~txq_io_enq_ready)
        $fwrite(32'h80000002, "Assertion failed\n    at UARTAdapter.scala:48 when (txq.io.enq.valid) { assert(txq.io.enq.ready) }\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (_GEN)
      assert__assert: assert(txq_io_enq_ready);
  end // always @(posedge)
endmodule

