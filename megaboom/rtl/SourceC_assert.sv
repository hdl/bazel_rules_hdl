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
module SourceC_assert(
  input       room,
  input [3:0] queue_io_count,
  input       queue_io_enq_ready,
              c_valid,
              reset,
              clock
);

  wire _GEN = room == (queue_io_count < 4'h2);
  wire _GEN_0 = ~c_valid | queue_io_enq_ready;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at SourceC.scala:64 assert (room === queue.io.count <= 1.U)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed\n    at SourceC.scala:119 assert(!c.valid || c.ready)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(_GEN);
      assert__assert_1: assert(_GEN_0);
    end
  end // always @(posedge)
endmodule

