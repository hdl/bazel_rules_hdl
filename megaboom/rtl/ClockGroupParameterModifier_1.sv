// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ClockGroupParameterModifier_1(
  input  auto_frequency_specifier_in_member_allClocks_implicit_clock_clock,
         auto_frequency_specifier_in_member_allClocks_implicit_clock_reset,
         auto_frequency_specifier_in_member_allClocks_subsystem_cbus_0_clock,
         auto_frequency_specifier_in_member_allClocks_subsystem_cbus_0_reset,
         auto_frequency_specifier_in_member_allClocks_subsystem_mbus_0_clock,
         auto_frequency_specifier_in_member_allClocks_subsystem_mbus_0_reset,
         auto_frequency_specifier_in_member_allClocks_subsystem_fbus_0_clock,
         auto_frequency_specifier_in_member_allClocks_subsystem_fbus_0_reset,
         auto_frequency_specifier_in_member_allClocks_subsystem_pbus_0_clock,
         auto_frequency_specifier_in_member_allClocks_subsystem_pbus_0_reset,
         auto_frequency_specifier_in_member_allClocks_subsystem_sbus_1_clock,
         auto_frequency_specifier_in_member_allClocks_subsystem_sbus_1_reset,
         auto_frequency_specifier_in_member_allClocks_subsystem_sbus_0_clock,
         auto_frequency_specifier_in_member_allClocks_subsystem_sbus_0_reset,
  output auto_frequency_specifier_out_member_allClocks_implicit_clock_clock,
         auto_frequency_specifier_out_member_allClocks_implicit_clock_reset,
         auto_frequency_specifier_out_member_allClocks_subsystem_cbus_0_clock,
         auto_frequency_specifier_out_member_allClocks_subsystem_cbus_0_reset,
         auto_frequency_specifier_out_member_allClocks_subsystem_mbus_0_clock,
         auto_frequency_specifier_out_member_allClocks_subsystem_mbus_0_reset,
         auto_frequency_specifier_out_member_allClocks_subsystem_fbus_0_clock,
         auto_frequency_specifier_out_member_allClocks_subsystem_fbus_0_reset,
         auto_frequency_specifier_out_member_allClocks_subsystem_pbus_0_clock,
         auto_frequency_specifier_out_member_allClocks_subsystem_pbus_0_reset,
         auto_frequency_specifier_out_member_allClocks_subsystem_sbus_1_clock,
         auto_frequency_specifier_out_member_allClocks_subsystem_sbus_1_reset,
         auto_frequency_specifier_out_member_allClocks_subsystem_sbus_0_clock,
         auto_frequency_specifier_out_member_allClocks_subsystem_sbus_0_reset
);

  assign auto_frequency_specifier_out_member_allClocks_implicit_clock_clock = auto_frequency_specifier_in_member_allClocks_implicit_clock_clock;
  assign auto_frequency_specifier_out_member_allClocks_implicit_clock_reset = auto_frequency_specifier_in_member_allClocks_implicit_clock_reset;
  assign auto_frequency_specifier_out_member_allClocks_subsystem_cbus_0_clock = auto_frequency_specifier_in_member_allClocks_subsystem_cbus_0_clock;
  assign auto_frequency_specifier_out_member_allClocks_subsystem_cbus_0_reset = auto_frequency_specifier_in_member_allClocks_subsystem_cbus_0_reset;
  assign auto_frequency_specifier_out_member_allClocks_subsystem_mbus_0_clock = auto_frequency_specifier_in_member_allClocks_subsystem_mbus_0_clock;
  assign auto_frequency_specifier_out_member_allClocks_subsystem_mbus_0_reset = auto_frequency_specifier_in_member_allClocks_subsystem_mbus_0_reset;
  assign auto_frequency_specifier_out_member_allClocks_subsystem_fbus_0_clock = auto_frequency_specifier_in_member_allClocks_subsystem_fbus_0_clock;
  assign auto_frequency_specifier_out_member_allClocks_subsystem_fbus_0_reset = auto_frequency_specifier_in_member_allClocks_subsystem_fbus_0_reset;
  assign auto_frequency_specifier_out_member_allClocks_subsystem_pbus_0_clock = auto_frequency_specifier_in_member_allClocks_subsystem_pbus_0_clock;
  assign auto_frequency_specifier_out_member_allClocks_subsystem_pbus_0_reset = auto_frequency_specifier_in_member_allClocks_subsystem_pbus_0_reset;
  assign auto_frequency_specifier_out_member_allClocks_subsystem_sbus_1_clock = auto_frequency_specifier_in_member_allClocks_subsystem_sbus_1_clock;
  assign auto_frequency_specifier_out_member_allClocks_subsystem_sbus_1_reset = auto_frequency_specifier_in_member_allClocks_subsystem_sbus_1_reset;
  assign auto_frequency_specifier_out_member_allClocks_subsystem_sbus_0_clock = auto_frequency_specifier_in_member_allClocks_subsystem_sbus_0_clock;
  assign auto_frequency_specifier_out_member_allClocks_subsystem_sbus_0_reset = auto_frequency_specifier_in_member_allClocks_subsystem_sbus_0_reset;
endmodule

