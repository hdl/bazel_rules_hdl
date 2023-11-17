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
module CaptureUpdateChain_2_assert(
  input io_chainIn_update,
        io_chainIn_shift,
        io_chainIn_capture,
        reset,
        clock
);

  wire _GEN = ~(io_chainIn_capture & io_chainIn_update) & ~(io_chainIn_capture & io_chainIn_shift) & ~(io_chainIn_update & io_chainIn_shift);
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at JtagShifter.scala:183 assert(!(io.chainIn.capture && io.chainIn.update)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset)
      assert__assert: assert(_GEN);
  end // always @(posedge)
endmodule

