// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ClockGroupResetSynchronizer(
  input  auto_in_member_allClocks_uncore_clock,
         auto_in_member_allClocks_uncore_reset,
  output auto_out_member_allClocks_uncore_clock,
         auto_out_member_allClocks_uncore_reset
);

  ResetCatchAndSync_d3 nodeOut_member_allClocks_uncore_reset_catcher (
    .clock         (auto_in_member_allClocks_uncore_clock),
    .reset         (auto_in_member_allClocks_uncore_reset),
    .io_sync_reset (auto_out_member_allClocks_uncore_reset)
  );
  assign auto_out_member_allClocks_uncore_clock = auto_in_member_allClocks_uncore_clock;
endmodule

