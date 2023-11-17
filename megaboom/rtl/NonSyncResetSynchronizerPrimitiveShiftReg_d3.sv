// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module NonSyncResetSynchronizerPrimitiveShiftReg_d3(
  input  clock,
         io_d,
  output io_q
);

  reg sync_0;
  reg sync_1;
  reg sync_2;
  always @(posedge clock) begin
    sync_0 <= sync_1;
    sync_1 <= sync_2;
    sync_2 <= io_d;
  end // always @(posedge)
  assign io_q = sync_0;
endmodule

