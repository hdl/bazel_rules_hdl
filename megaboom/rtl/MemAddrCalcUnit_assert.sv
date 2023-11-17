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
module MemAddrCalcUnit_assert(
  input [64:0] io_req_bits_rs2_data,
  input        io_req_valid,
               io_req_bits_uop_ctrl_is_std,
               io_req_bits_uop_fp_val,
  input [6:0]  io_req_bits_uop_uopc,
  input        ma_ld,
               ma_st,
               reset,
               clock
);

  wire _GEN = io_req_valid & io_req_bits_uop_ctrl_is_std;
  wire _GEN_0 = _GEN & io_req_bits_rs2_data[64];
  wire _GEN_1 = _GEN & io_req_bits_uop_fp_val;
  wire _GEN_2 = io_req_bits_uop_fp_val & io_req_valid & io_req_bits_uop_uopc != 7'h1 & io_req_bits_uop_uopc != 7'h2;
  wire _GEN_3 = ma_ld & ma_st;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & _GEN_0)
        $fwrite(32'h80000002, "Assertion failed: 65th bit set in MemAddrCalcUnit.\n    at functional-unit.scala:504 assert (!(io.req.valid && io.req.bits.uop.ctrl.is_std &&\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_1)
        $fwrite(32'h80000002, "Assertion failed: FP store-data should now be going through a different unit.\n    at functional-unit.scala:507 assert (!(io.req.valid && io.req.bits.uop.ctrl.is_std && io.req.bits.uop.fp_val),\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_2)
        $fwrite(32'h80000002, "Assertion failed: [maddrcalc] assert we never get store data in here.\n    at functional-unit.scala:511 assert (!(io.req.bits.uop.fp_val && io.req.valid && io.req.bits.uop.uopc =/=\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_3)
        $fwrite(32'h80000002, "Assertion failed: Mutually-exclusive exceptions are firing.\n    at functional-unit.scala:547 assert (!(ma_ld && ma_st), \"Mutually-exclusive exceptions are firing.\")\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(~_GEN_0);
      assert__assert_1: assert(~_GEN_1);
      assert__assert_2: assert(~_GEN_2);
      assert__assert_3: assert(~_GEN_3);
    end
  end // always @(posedge)
endmodule

