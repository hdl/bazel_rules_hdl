// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module AsyncResetSynchronizerShiftReg_w4_d3_i0(
  input        clock,
               reset,
  input  [3:0] io_d,
  output [3:0] io_q
);

  wire _output_chain_3_io_q;
  wire _output_chain_2_io_q;
  wire _output_chain_1_io_q;
  wire _output_chain_io_q;
  AsyncResetSynchronizerPrimitiveShiftReg_d3_i0 output_chain (
    .clock (clock),
    .reset (reset),
    .io_d  (io_d[0]),
    .io_q  (_output_chain_io_q)
  );
  AsyncResetSynchronizerPrimitiveShiftReg_d3_i0 output_chain_1 (
    .clock (clock),
    .reset (reset),
    .io_d  (io_d[1]),
    .io_q  (_output_chain_1_io_q)
  );
  AsyncResetSynchronizerPrimitiveShiftReg_d3_i0 output_chain_2 (
    .clock (clock),
    .reset (reset),
    .io_d  (io_d[2]),
    .io_q  (_output_chain_2_io_q)
  );
  AsyncResetSynchronizerPrimitiveShiftReg_d3_i0 output_chain_3 (
    .clock (clock),
    .reset (reset),
    .io_d  (io_d[3]),
    .io_q  (_output_chain_3_io_q)
  );
  assign io_q = {_output_chain_3_io_q, _output_chain_2_io_q, _output_chain_1_io_q, _output_chain_io_q};
endmodule

