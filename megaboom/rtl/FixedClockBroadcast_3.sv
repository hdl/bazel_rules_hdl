// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module FixedClockBroadcast_3(
  input  auto_in_clock,
         auto_in_reset,
  output auto_out_5_clock,
         auto_out_5_reset,
         auto_out_4_clock,
         auto_out_4_reset,
         auto_out_3_clock,
         auto_out_3_reset,
         auto_out_1_clock,
         auto_out_1_reset,
         auto_out_0_clock,
         auto_out_0_reset
);

  assign auto_out_5_clock = auto_in_clock;
  assign auto_out_5_reset = auto_in_reset;
  assign auto_out_4_clock = auto_in_clock;
  assign auto_out_4_reset = auto_in_reset;
  assign auto_out_3_clock = auto_in_clock;
  assign auto_out_3_reset = auto_in_reset;
  assign auto_out_1_clock = auto_in_clock;
  assign auto_out_1_reset = auto_in_reset;
  assign auto_out_0_clock = auto_in_clock;
  assign auto_out_0_reset = auto_in_reset;
endmodule

