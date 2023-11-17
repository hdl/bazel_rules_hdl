// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module IntSyncAsyncCrossingSink(
  input  clock,
         auto_in_sync_0,
  output auto_out_0
);

  SynchronizerShiftReg_w1_d3 chain (
    .clock (clock),
    .io_d  (auto_in_sync_0),
    .io_q  (auto_out_0)
  );
endmodule

