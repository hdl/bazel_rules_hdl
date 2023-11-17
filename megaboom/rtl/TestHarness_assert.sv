// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

// VCS coverage exclude_file
module TestHarness_assert(
  input [31:0] jtag_exit,
               success_exit_sim_exit,
  input        _GEN,
               source_1_clk,
               harnessBinderReset_catcher_io_sync_reset
);

  wire _GEN_0 = jtag_exit < 32'h2;
  `ifndef SYNTHESIS
    always @(posedge source_1_clk) begin
      if ((`PRINTF_COND_) & _GEN & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed: *** FAILED *** (exit code = %d)\n\n    at Periphery.scala:233 assert(io.exit < 2.U, \"*** FAILED *** (exit code = %%%%d)\\n\", io.exit >> 1.U)\n", {1'h0, jtag_exit[31:1]});
      if ((`PRINTF_COND_) & ~harnessBinderReset_catcher_io_sync_reset & (|(success_exit_sim_exit[31:1])))
        $fwrite(32'h80000002, "Assertion failed: *** FAILED *** (exit code = %d)\n\n    at SimTSI.scala:20 assert(!error, \"*** FAILED *** (exit code = %%%%d)\\n\", exit >> 1.U)\n", {1'h0, success_exit_sim_exit[31:1]});
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge source_1_clk) begin
    if (_GEN)
      assert__assert: assert(_GEN_0);
    if (~harnessBinderReset_catcher_io_sync_reset)
      assert__success_assert: assert(~(|(success_exit_sim_exit[31:1])));
  end // always @(posedge)
endmodule

