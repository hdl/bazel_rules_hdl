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
module DebugTransportModuleJTAG_assert(
  input dmiAccessChain_io_update_valid,
        _GEN,
        _GEN_0,
        stickyBusyReg,
        io_jtag_reset,
        io_jtag_clock
);

  wire _GEN_1 = dmiAccessChain_io_update_valid & ~stickyBusyReg & ~_GEN_0 & _GEN;
  always @(posedge io_jtag_clock) begin
    if (~io_jtag_reset)
      assert__assert: assert(~_GEN_1);
  end // always @(posedge)
  `ifndef SYNTHESIS
    always @(posedge io_jtag_clock) begin
      if ((`PRINTF_COND_) & ~io_jtag_reset & _GEN_1)
        $fwrite(32'h80000002, "Assertion failed: Conflicting updates for dmiReqValidReg, should not happen.\n    at DebugTransport.scala:203 assert(!(dmiReqValidCheck && io.dmi.req.fire), \"Conflicting updates for dmiReqValidReg, should not happen.\");\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule

