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
module NBDTLB_assert(
  input [26:0] vpn_0,
  input [38:0] io_sfence_bits_addr,
  input        io_sfence_bits_rs1,
  input [26:0] vpn_1,
  input        io_sfence_valid,
               reset,
               clock
);

  wire _GEN = ~io_sfence_bits_rs1 | io_sfence_bits_addr[38:12] == vpn_0;
  wire _GEN_0 = ~io_sfence_bits_rs1 | io_sfence_bits_addr[38:12] == vpn_1;
  wire _GEN_1 = io_sfence_valid & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_1 & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at tlb.scala:340 assert(!io.sfence.bits.rs1 || (io.sfence.bits.addr >> pgIdxBits) === vpn(w))\n");
      if ((`PRINTF_COND_) & _GEN_1 & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed\n    at tlb.scala:340 assert(!io.sfence.bits.rs1 || (io.sfence.bits.addr >> pgIdxBits) === vpn(w))\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (_GEN_1) begin
      assert__assert: assert(_GEN);
      assert__assert_1: assert(_GEN_0);
    end
  end // always @(posedge)
endmodule

