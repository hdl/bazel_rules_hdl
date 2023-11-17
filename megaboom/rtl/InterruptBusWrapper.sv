// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module InterruptBusWrapper(
  input  auto_int_bus_int_in_0,
  output auto_int_bus_int_out_0
);

  IntXbar int_bus (
    .auto_int_in_0  (auto_int_bus_int_in_0),
    .auto_int_out_0 (auto_int_bus_int_out_0)
  );
endmodule

