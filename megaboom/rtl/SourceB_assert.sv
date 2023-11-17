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
module SourceB_assert(
  input io_req_bits_clients,
        io_req_valid,
        reset,
        clock
);

  wire _GEN = ~io_req_valid | io_req_bits_clients;
  always @(posedge clock) begin
    if (~reset)
      assert__assert: assert(_GEN);
  end // always @(posedge)
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at SourceB.scala:59 assert (!io.req.valid || io.req.bits.clients =/= 0.U)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule

