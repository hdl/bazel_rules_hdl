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
module TLDebugModuleInner_assert(
  input [63:0] auto_tl_in_a_bits_data,
  input        _GEN,
               _GEN_0,
               hartExceptionWrEn,
               io_dmactive,
               hartGoingWrEn,
               reset,
               goAbstract,
               clock,
               _errorBusy_T_14,
               _GEN_1,
  input [1:0]  ctrlStateReg
);

  wire _GEN_2 = _GEN | ~hartExceptionWrEn | _GEN_0;
  wire _GEN_3 = io_dmactive & ~goAbstract & hartGoingWrEn & ~reset;
  wire _GEN_4 = _errorBusy_T_14 & ~_GEN_1;
  wire _GEN_5 = _GEN_4 & _GEN_0 & hartExceptionWrEn & ~reset;
  wire _GEN_6 = _GEN_4 & ~_GEN_0 & (&ctrlStateReg) & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_3 & (|(auto_tl_in_a_bits_data[41:32])))
        $fwrite(32'h80000002, "Assertion failed: Unexpected 'GOING' hart.\n    at Debug.scala:1499 assert(hartGoingId === 0.U, \"Unexpected 'GOING' hart.\")//Chisel3 #540 %%%%x, expected %%%%x\", hartGoingId, 0.U)\n");
      if ((`PRINTF_COND_) & _GEN_5 & (|(auto_tl_in_a_bits_data[41:32])))
        $fwrite(32'h80000002, "Assertion failed: Unexpected 'EXCEPTION' hart\n    at Debug.scala:1820 assert(hartExceptionId === 0.U, \"Unexpected 'EXCEPTION' hart\")//Chisel3 #540, %%%%x, expected %%%%x\", hartExceptionId, 0.U)\n");
      if ((`PRINTF_COND_) & _GEN_6)
        $fwrite(32'h80000002, "Assertion failed: Should not be in custom state unless we need it.\n    at Debug.scala:1825 assert(needCustom.B, \"Should not be in custom state unless we need it.\")\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_2)
        $fwrite(32'h80000002, "Assertion failed: Unexpected EXCEPTION write: should only get it in Debug Module EXEC state\n    at Debug.scala:1838 assert ((!io.dmactive || !hartExceptionWrEn || ctrlStateReg === CtrlState(Exec)),\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (_GEN_3)
      assert__assert: assert(~(|(auto_tl_in_a_bits_data[41:32])));
    if (_GEN_5)
      assert__assert_2: assert(~(|(auto_tl_in_a_bits_data[41:32])));
    if (_GEN_6)
      assert__assert_3: assert(1'h0);
    if (~reset)
      assert__assert_4: assert(_GEN_2);
  end // always @(posedge)
endmodule

