// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ClockGroupAggregator_6(
  input  auto_in_member_allClocks_implicit_clock_clock,
         auto_in_member_allClocks_implicit_clock_reset,
         auto_in_member_allClocks_subsystem_cbus_0_clock,
         auto_in_member_allClocks_subsystem_cbus_0_reset,
         auto_in_member_allClocks_subsystem_mbus_0_clock,
         auto_in_member_allClocks_subsystem_mbus_0_reset,
         auto_in_member_allClocks_subsystem_fbus_0_clock,
         auto_in_member_allClocks_subsystem_fbus_0_reset,
         auto_in_member_allClocks_subsystem_pbus_0_clock,
         auto_in_member_allClocks_subsystem_pbus_0_reset,
         auto_in_member_allClocks_subsystem_sbus_1_clock,
         auto_in_member_allClocks_subsystem_sbus_1_reset,
         auto_in_member_allClocks_subsystem_sbus_0_clock,
         auto_in_member_allClocks_subsystem_sbus_0_reset,
  output auto_out_5_member_implicitClockGrouper_implicit_clock_clock,
         auto_out_5_member_implicitClockGrouper_implicit_clock_reset,
         auto_out_4_member_subsystem_cbus_subsystem_cbus_0_clock,
         auto_out_4_member_subsystem_cbus_subsystem_cbus_0_reset,
         auto_out_3_member_subsystem_mbus_subsystem_mbus_0_clock,
         auto_out_3_member_subsystem_mbus_subsystem_mbus_0_reset,
         auto_out_2_member_subsystem_fbus_subsystem_fbus_0_clock,
         auto_out_2_member_subsystem_fbus_subsystem_fbus_0_reset,
         auto_out_1_member_subsystem_pbus_subsystem_pbus_0_clock,
         auto_out_1_member_subsystem_pbus_subsystem_pbus_0_reset,
         auto_out_0_member_subsystem_sbus_subsystem_sbus_1_clock,
         auto_out_0_member_subsystem_sbus_subsystem_sbus_1_reset,
         auto_out_0_member_subsystem_sbus_subsystem_sbus_0_clock,
         auto_out_0_member_subsystem_sbus_subsystem_sbus_0_reset
);

  assign auto_out_5_member_implicitClockGrouper_implicit_clock_clock = auto_in_member_allClocks_implicit_clock_clock;
  assign auto_out_5_member_implicitClockGrouper_implicit_clock_reset = auto_in_member_allClocks_implicit_clock_reset;
  assign auto_out_4_member_subsystem_cbus_subsystem_cbus_0_clock = auto_in_member_allClocks_subsystem_cbus_0_clock;
  assign auto_out_4_member_subsystem_cbus_subsystem_cbus_0_reset = auto_in_member_allClocks_subsystem_cbus_0_reset;
  assign auto_out_3_member_subsystem_mbus_subsystem_mbus_0_clock = auto_in_member_allClocks_subsystem_mbus_0_clock;
  assign auto_out_3_member_subsystem_mbus_subsystem_mbus_0_reset = auto_in_member_allClocks_subsystem_mbus_0_reset;
  assign auto_out_2_member_subsystem_fbus_subsystem_fbus_0_clock = auto_in_member_allClocks_subsystem_fbus_0_clock;
  assign auto_out_2_member_subsystem_fbus_subsystem_fbus_0_reset = auto_in_member_allClocks_subsystem_fbus_0_reset;
  assign auto_out_1_member_subsystem_pbus_subsystem_pbus_0_clock = auto_in_member_allClocks_subsystem_pbus_0_clock;
  assign auto_out_1_member_subsystem_pbus_subsystem_pbus_0_reset = auto_in_member_allClocks_subsystem_pbus_0_reset;
  assign auto_out_0_member_subsystem_sbus_subsystem_sbus_1_clock = auto_in_member_allClocks_subsystem_sbus_1_clock;
  assign auto_out_0_member_subsystem_sbus_subsystem_sbus_1_reset = auto_in_member_allClocks_subsystem_sbus_1_reset;
  assign auto_out_0_member_subsystem_sbus_subsystem_sbus_0_clock = auto_in_member_allClocks_subsystem_sbus_0_clock;
  assign auto_out_0_member_subsystem_sbus_subsystem_sbus_0_reset = auto_in_member_allClocks_subsystem_sbus_0_reset;
endmodule

