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
module IssueSlot_assert(
  input       io_clear,
              io_kill,
  input [1:0] state,
  input       io_in_uop_valid,
              reset,
              clock
);

  wire _GEN = state == 2'h0 | io_clear | io_kill;
  wire _GEN_0 = io_in_uop_valid & ~reset;
  always @(posedge clock) begin
    if (_GEN_0)
      assert__assert: assert(_GEN);
  end // always @(posedge)
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_0 & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed: trying to overwrite a valid issue slot.\n    at issue-slot.scala:156 assert (is_invalid || io.clear || io.kill, \"trying to overwrite a valid issue slot.\")\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule

