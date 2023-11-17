// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module IntSyncCrossingSource_5(
  input  clock,
         reset,
         auto_in_0,
         auto_in_1,
  output auto_out_sync_0,
         auto_out_sync_1
);

  wire [1:0] _reg_io_q;
  AsyncResetRegVec_w2_i0 reg_0 (
    .clock (clock),
    .reset (reset),
    .io_d  ({auto_in_1, auto_in_0}),
    .io_q  (_reg_io_q)
  );
  assign auto_out_sync_0 = _reg_io_q[0];
  assign auto_out_sync_1 = _reg_io_q[1];
endmodule

