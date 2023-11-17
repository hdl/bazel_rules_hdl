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
module FpPipeline_assert(
  input       ll_wbarb_io_in_0_ready,
  input [1:0] io_from_int_bits_uop_dst_rtype,
  input       _fregfile_io_write_ports_2_valid_T,
              _io_wakeups_2_valid_T,
              _fregfile_io_write_ports_3_valid_T,
              _io_wakeups_3_valid_T,
              fpu_exe_unit_io_fresp_valid,
              fpu_exe_unit_io_fresp_bits_uop_uses_ldq,
              fpu_exe_unit_io_fresp_bits_uop_uses_stq,
              fpu_exe_unit_io_fresp_bits_uop_is_amo,
              fpu_exe_unit_1_io_fresp_valid,
              fpu_exe_unit_1_io_fresp_bits_uop_uses_ldq,
              fpu_exe_unit_1_io_fresp_bits_uop_uses_stq,
              fpu_exe_unit_1_io_fresp_bits_uop_is_amo,
              reset,
              clock,
              io_from_int_valid
);

  wire _GEN = io_from_int_bits_uop_dst_rtype != 2'h2 & io_from_int_bits_uop_dst_rtype == 2'h1;
  wire _GEN_0 = fpu_exe_unit_io_fresp_valid & fpu_exe_unit_io_fresp_bits_uop_uses_ldq;
  wire _GEN_1 = fpu_exe_unit_io_fresp_valid & fpu_exe_unit_io_fresp_bits_uop_uses_stq;
  wire _GEN_2 = fpu_exe_unit_io_fresp_valid & fpu_exe_unit_io_fresp_bits_uop_is_amo;
  wire _GEN_3 = fpu_exe_unit_1_io_fresp_valid & fpu_exe_unit_1_io_fresp_bits_uop_uses_ldq;
  wire _GEN_4 = fpu_exe_unit_1_io_fresp_valid & fpu_exe_unit_1_io_fresp_bits_uop_uses_stq;
  wire _GEN_5 = fpu_exe_unit_1_io_fresp_valid & fpu_exe_unit_1_io_fresp_bits_uop_is_amo;
  wire _GEN_6 = io_from_int_valid & ~reset;
  wire _GEN_7 = fpu_exe_unit_io_fresp_valid & ~reset;
  wire _GEN_8 = fpu_exe_unit_1_io_fresp_valid & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~ll_wbarb_io_in_0_ready)
        $fwrite(32'h80000002, "Assertion failed\n    at fp-pipeline.scala:187 assert (ll_wbarb.io.in(0).ready) // never backpressure the memory unit.\n");
      if ((`PRINTF_COND_) & _GEN_6 & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at fp-pipeline.scala:188 when (ifpu_resp.valid) { assert (ifpu_resp.bits.uop.rf_wen && ifpu_resp.bits.uop.dst_rtype === RT_FLT) }\n");
      if ((`PRINTF_COND_) & _GEN_7 & ~_fregfile_io_write_ports_2_valid_T)
        $fwrite(32'h80000002, "Assertion failed: rf_wen must be high here\n    at fp-pipeline.scala:205 assert(eu.io.fresp.bits.uop.rf_wen, \"rf_wen must be high here\")\n");
      if ((`PRINTF_COND_) & _GEN_7 & ~_io_wakeups_2_valid_T)
        $fwrite(32'h80000002, "Assertion failed: wb type must be FLT for fpu\n    at fp-pipeline.scala:206 assert(eu.io.fresp.bits.uop.dst_rtype === RT_FLT, \"wb type must be FLT for fpu\")\n");
      if ((`PRINTF_COND_) & _GEN_8 & ~_fregfile_io_write_ports_3_valid_T)
        $fwrite(32'h80000002, "Assertion failed: rf_wen must be high here\n    at fp-pipeline.scala:205 assert(eu.io.fresp.bits.uop.rf_wen, \"rf_wen must be high here\")\n");
      if ((`PRINTF_COND_) & _GEN_8 & ~_io_wakeups_3_valid_T)
        $fwrite(32'h80000002, "Assertion failed: wb type must be FLT for fpu\n    at fp-pipeline.scala:206 assert(eu.io.fresp.bits.uop.dst_rtype === RT_FLT, \"wb type must be FLT for fpu\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_0)
        $fwrite(32'h80000002, "Assertion failed\n    at fp-pipeline.scala:248 assert(!(exe_resp.valid && wb_uop.uses_ldq))\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_1)
        $fwrite(32'h80000002, "Assertion failed\n    at fp-pipeline.scala:249 assert(!(exe_resp.valid && wb_uop.uses_stq))\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_2)
        $fwrite(32'h80000002, "Assertion failed\n    at fp-pipeline.scala:250 assert(!(exe_resp.valid && wb_uop.is_amo))\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_3)
        $fwrite(32'h80000002, "Assertion failed\n    at fp-pipeline.scala:248 assert(!(exe_resp.valid && wb_uop.uses_ldq))\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_4)
        $fwrite(32'h80000002, "Assertion failed\n    at fp-pipeline.scala:249 assert(!(exe_resp.valid && wb_uop.uses_stq))\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_5)
        $fwrite(32'h80000002, "Assertion failed\n    at fp-pipeline.scala:250 assert(!(exe_resp.valid && wb_uop.is_amo))\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset)
      assert__assert: assert(ll_wbarb_io_in_0_ready);
    if (_GEN_6)
      assert__assert_1: assert(_GEN);
    if (_GEN_7) begin
      assert__assert_3: assert(_fregfile_io_write_ports_2_valid_T);
      assert__assert_4: assert(_io_wakeups_2_valid_T);
    end
    if (_GEN_8) begin
      assert__assert_6: assert(_fregfile_io_write_ports_3_valid_T);
      assert__assert_7: assert(_io_wakeups_3_valid_T);
    end
    if (~reset) begin
      assert__assert_8: assert(~_GEN_0);
      assert__assert_9: assert(~_GEN_1);
      assert__assert_10: assert(~_GEN_2);
      assert__assert_11: assert(~_GEN_3);
      assert__assert_12: assert(~_GEN_4);
      assert__assert_13: assert(~_GEN_5);
    end
  end // always @(posedge)
endmodule

