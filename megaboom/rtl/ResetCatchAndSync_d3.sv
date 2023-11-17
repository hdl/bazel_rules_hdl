// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ResetCatchAndSync_d3(
  input  clock,
         reset,
  output io_sync_reset
);

  wire _io_sync_reset_chain_io_q;
  AsyncResetSynchronizerShiftReg_w1_d3_i0 io_sync_reset_chain (
    .clock (clock),
    .reset (reset),
    .io_d  (1'h1),
    .io_q  (_io_sync_reset_chain_io_q)
  );
  assign io_sync_reset = ~_io_sync_reset_chain_io_q;
endmodule

