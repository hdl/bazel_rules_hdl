// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module SynchronizerShiftReg_w1_d3(
  input  clock,
         io_d,
  output io_q
);

  NonSyncResetSynchronizerPrimitiveShiftReg_d3 output_chain (
    .clock (clock),
    .io_d  (io_d),
    .io_q  (io_q)
  );
endmodule

