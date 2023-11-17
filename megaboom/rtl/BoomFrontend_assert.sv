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
module BoomFrontend_assert(
  input [39:0] f3_bpd_resp_io_deq_bits_pc,
               f3_io_deq_bits_pc,
  input        _f4_btb_corrections_io_enq_valid_T,
               _GEN,
               clock
);

  wire _GEN_0 = f3_bpd_resp_io_deq_bits_pc == f3_io_deq_bits_pc;
  wire _GEN_1 = _f4_btb_corrections_io_enq_valid_T & _GEN;
  always @(posedge clock) begin
    if (_GEN_1)
      assert__assert: assert(_GEN_0);
  end // always @(posedge)
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_1 & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed\n    at frontend.scala:771 assert(f3_bpd_resp.io.deq.bits.pc === f3_fetch_bundle.pc)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule

