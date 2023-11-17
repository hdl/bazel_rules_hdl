// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module AsyncResetSynchronizerShiftReg_w1_d3_i0_1(
  input  clock,
         reset,
         io_d,
  output io_q
);

  AsyncResetSynchronizerPrimitiveShiftReg_d3_i0 output_chain (
    .clock (clock),
    .reset (reset),
    .io_d  (io_d),
    .io_q  (io_q)
  );
endmodule

