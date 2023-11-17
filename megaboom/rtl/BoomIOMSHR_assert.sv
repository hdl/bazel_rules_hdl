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
module BoomIOMSHR_assert(
  input       _io_req_ready_output,
  input [4:0] req_uop_mem_cmd,
  input       reset,
              clock
);

  wire _GEN = _io_req_ready_output | req_uop_mem_cmd != 5'h7;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at mshrs.scala:454 assert(state === s_idle || req.uop.mem_cmd =/= M_XSC)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset)
      assert__assert: assert(_GEN);
  end // always @(posedge)
endmodule

