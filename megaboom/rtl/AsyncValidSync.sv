// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module AsyncValidSync(
  input  io_in,
         clock,
         reset,
  output io_out
);

  AsyncResetSynchronizerShiftReg_w1_d3_i0_1 io_out_source_valid_0 (
    .clock (clock),
    .reset (reset),
    .io_d  (io_in),
    .io_q  (io_out)
  );
endmodule

