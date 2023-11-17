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
module TLB_assert(
  input [26:0] vpn,
  input [38:0] io_sfence_bits_addr,
  input        io_sfence_bits_rs1,
               io_sfence_valid,
               reset,
               clock
);

  wire _GEN = ~io_sfence_bits_rs1 | io_sfence_bits_addr[38:12] == vpn;
  wire _GEN_0 = io_sfence_valid & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_0 & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at TLB.scala:709 assert(!io.sfence.bits.rs1 || (io.sfence.bits.addr >> pgIdxBits) === vpn)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (_GEN_0)
      assert__assert: assert(_GEN);
  end // always @(posedge)
endmodule

