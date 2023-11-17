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
module CSRFile_assert(
  input       io_exception,
              insn_break,
              insn_call,
              insn_ret,
              _io_interrupt_T,
  input [2:0] io_retire,
  input       reg_singleStepped,
  input [1:0] reg_mstatus_fs,
  input       reset,
              clock,
              set_fs_dirty
);

  wire _GEN = {1'h0, {1'h0, insn_ret} + {1'h0, insn_call}} + {1'h0, {1'h0, insn_break} + {1'h0, io_exception}} < 3'h2;
  wire _GEN_0 = _io_interrupt_T | io_retire < 3'h2;
  wire _GEN_1 = ~reg_singleStepped | io_retire == 3'h0;
  wire _GEN_2 = set_fs_dirty & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed: these conditions must be mutually exclusive\n    at CSR.scala:1005 assert(PopCount(insn_ret :: insn_call :: insn_break :: io.exception :: Nil) <= 1.U, \"these conditions must be mutually exclusive\")\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed\n    at CSR.scala:1013 assert(!io.singleStep || io.retire <= 1.U)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_1)
        $fwrite(32'h80000002, "Assertion failed\n    at CSR.scala:1014 assert(!reg_singleStepped || io.retire === 0.U)\n");
      if ((`PRINTF_COND_) & _GEN_2 & ~(|reg_mstatus_fs))
        $fwrite(32'h80000002, "Assertion failed\n    at CSR.scala:1185 assert(reg_mstatus.fs > 0.U)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(_GEN);
      assert__assert_1: assert(_GEN_0);
      assert__assert_2: assert(_GEN_1);
    end
    if (_GEN_2)
      assert__assert_3: assert(|reg_mstatus_fs);
  end // always @(posedge)
endmodule

