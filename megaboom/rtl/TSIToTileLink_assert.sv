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
module TSIToTileLink_assert(
  input _GEN,
        _GEN_0,
        reset,
        _GEN_1,
        clock
);

  wire _GEN_2 = _GEN & ~_GEN_1 & _GEN_0 & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_2)
        $fwrite(32'h80000002, "Assertion failed: Bad TSI command\n    at TSIToTileLink.scala:137 assert(false.B, \"Bad TSI command\")\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (_GEN_2)
      assert__assert: assert(1'h0);
  end // always @(posedge)
endmodule

