// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module JtagBypassChain(
  input  clock,
         reset,
         io_chainIn_shift,
         io_chainIn_data,
         io_chainIn_capture,
         io_chainIn_update,
  output io_chainOut_data
);

  reg reg_0;
  always @(posedge clock) begin
    if (io_chainIn_capture)
      reg_0 <= 1'h0;
    else if (io_chainIn_shift)
      reg_0 <= io_chainIn_data;
  end // always @(posedge)
  assign io_chainOut_data = reg_0;
endmodule

