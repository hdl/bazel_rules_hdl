// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module LevelGateway(
  input  clock,
         reset,
         io_interrupt,
         io_plic_ready,
         io_plic_complete,
  output io_plic_valid
);

  reg inFlight;
  always @(posedge clock) begin
    if (reset)
      inFlight <= 1'h0;
    else
      inFlight <= ~io_plic_complete & (io_interrupt & io_plic_ready | inFlight);
  end // always @(posedge)
  assign io_plic_valid = io_interrupt & ~inFlight;
endmodule

