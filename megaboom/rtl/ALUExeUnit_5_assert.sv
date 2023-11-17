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
module ALUExeUnit_5_assert(
  input DivUnit_io_resp_valid,
        ALUUnit_io_resp_valid,
        reset,
        clock
);

  wire [1:0] _GEN = {1'h0, ALUUnit_io_resp_valid} + {1'h0, DivUnit_io_resp_valid};
  wire       _GEN_0 = ~(_GEN[1]) & ~DivUnit_io_resp_valid | _GEN != 2'h3 & DivUnit_io_resp_valid;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed: Multiple functional units are fighting over the write port.\n    at execution-unit.scala:426 assert ((PopCount(iresp_fu_units.map(_.io.resp.valid)) <= 1.U && !div_resp_val) ||\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset)
      assert__assert_1: assert(_GEN_0);
  end // always @(posedge)
endmodule

