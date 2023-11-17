// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ClockGroupCombiner(
  input  auto_clock_group_combiner_in_member_allClocks_uncore_clock,
         auto_clock_group_combiner_in_member_allClocks_uncore_reset,
  output auto_clock_group_combiner_out_member_allClocks_implicit_clock_clock,
         auto_clock_group_combiner_out_member_allClocks_implicit_clock_reset,
         auto_clock_group_combiner_out_member_allClocks_subsystem_cbus_0_clock,
         auto_clock_group_combiner_out_member_allClocks_subsystem_cbus_0_reset,
         auto_clock_group_combiner_out_member_allClocks_subsystem_mbus_0_clock,
         auto_clock_group_combiner_out_member_allClocks_subsystem_mbus_0_reset,
         auto_clock_group_combiner_out_member_allClocks_subsystem_fbus_0_clock,
         auto_clock_group_combiner_out_member_allClocks_subsystem_fbus_0_reset,
         auto_clock_group_combiner_out_member_allClocks_subsystem_pbus_0_clock,
         auto_clock_group_combiner_out_member_allClocks_subsystem_pbus_0_reset,
         auto_clock_group_combiner_out_member_allClocks_subsystem_sbus_1_clock,
         auto_clock_group_combiner_out_member_allClocks_subsystem_sbus_1_reset,
         auto_clock_group_combiner_out_member_allClocks_subsystem_sbus_0_clock,
         auto_clock_group_combiner_out_member_allClocks_subsystem_sbus_0_reset
);

  assign auto_clock_group_combiner_out_member_allClocks_implicit_clock_clock = auto_clock_group_combiner_in_member_allClocks_uncore_clock;
  assign auto_clock_group_combiner_out_member_allClocks_implicit_clock_reset = auto_clock_group_combiner_in_member_allClocks_uncore_reset;
  assign auto_clock_group_combiner_out_member_allClocks_subsystem_cbus_0_clock = auto_clock_group_combiner_in_member_allClocks_uncore_clock;
  assign auto_clock_group_combiner_out_member_allClocks_subsystem_cbus_0_reset = auto_clock_group_combiner_in_member_allClocks_uncore_reset;
  assign auto_clock_group_combiner_out_member_allClocks_subsystem_mbus_0_clock = auto_clock_group_combiner_in_member_allClocks_uncore_clock;
  assign auto_clock_group_combiner_out_member_allClocks_subsystem_mbus_0_reset = auto_clock_group_combiner_in_member_allClocks_uncore_reset;
  assign auto_clock_group_combiner_out_member_allClocks_subsystem_fbus_0_clock = auto_clock_group_combiner_in_member_allClocks_uncore_clock;
  assign auto_clock_group_combiner_out_member_allClocks_subsystem_fbus_0_reset = auto_clock_group_combiner_in_member_allClocks_uncore_reset;
  assign auto_clock_group_combiner_out_member_allClocks_subsystem_pbus_0_clock = auto_clock_group_combiner_in_member_allClocks_uncore_clock;
  assign auto_clock_group_combiner_out_member_allClocks_subsystem_pbus_0_reset = auto_clock_group_combiner_in_member_allClocks_uncore_reset;
  assign auto_clock_group_combiner_out_member_allClocks_subsystem_sbus_1_clock = auto_clock_group_combiner_in_member_allClocks_uncore_clock;
  assign auto_clock_group_combiner_out_member_allClocks_subsystem_sbus_1_reset = auto_clock_group_combiner_in_member_allClocks_uncore_reset;
  assign auto_clock_group_combiner_out_member_allClocks_subsystem_sbus_0_clock = auto_clock_group_combiner_in_member_allClocks_uncore_clock;
  assign auto_clock_group_combiner_out_member_allClocks_subsystem_sbus_0_reset = auto_clock_group_combiner_in_member_allClocks_uncore_reset;
endmodule

