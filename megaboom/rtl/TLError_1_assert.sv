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
module TLError_1_assert(
  input idle,
        clock,
        reset,
        done
);

  reg  counter;
  wire _GEN = idle | ~counter;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at Error.scala:31 assert (idle || da_first) // we only send Grant, never GrantData => simplified flow control below\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset)
      assert__assert: assert(_GEN);
    if (reset)
      counter <= 1'h0;
    else
      counter <= (~done | counter - 1'h1) & counter;
  end // always @(posedge)
endmodule

