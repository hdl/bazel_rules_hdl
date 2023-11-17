// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ClockGroup(
  input  auto_in_member_subsystem_sbus_0_clock,
         auto_in_member_subsystem_sbus_0_reset,
  output auto_out_clock,
         auto_out_reset
);

  assign auto_out_clock = auto_in_member_subsystem_sbus_0_clock;
  assign auto_out_reset = auto_in_member_subsystem_sbus_0_reset;
endmodule

