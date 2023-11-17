// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module IntSyncSyncCrossingSink(
  input  auto_in_sync_0,
         auto_in_sync_1,
  output auto_out_0,
         auto_out_1
);

  assign auto_out_0 = auto_in_sync_0;
  assign auto_out_1 = auto_in_sync_1;
endmodule

