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
module BoomCore_assert(
  input       rob_io_commit_rollback,
              _dec_hazards_T_28,
              b2_mispredict,
              rob_io_com_xcpt_valid,
              _io_ifu_commit_valid_T,
              rob_io_commit_valids_2,
              rob_io_commit_valids_3,
              _GEN,
              alu_exe_unit_io_iresp_valid,
              _rob_io_debug_wb_valids_2_T,
              _GEN_0,
              alu_exe_unit_1_io_iresp_valid,
              _rob_io_debug_wb_valids_3_T,
              _GEN_1,
              alu_exe_unit_2_io_iresp_valid,
              _rob_io_debug_wb_valids_4_T,
              _GEN_2,
              alu_exe_unit_3_io_iresp_valid,
              _rob_io_debug_wb_valids_5_T,
  input [1:0] alu_exe_unit_io_iresp_bits_uop_dst_rtype,
  input       _rob_io_debug_wb_valids_2_T_2,
  input [1:0] alu_exe_unit_1_io_iresp_bits_uop_dst_rtype,
  input       _rob_io_debug_wb_valids_3_T_2,
  input [1:0] alu_exe_unit_2_io_iresp_bits_uop_dst_rtype,
  input       _rob_io_debug_wb_valids_4_T_2,
  input [1:0] alu_exe_unit_3_io_iresp_bits_uop_dst_rtype,
  input       _rob_io_debug_wb_valids_5_T_2,
              FpPipeline_io_wakeups_0_valid,
  input [1:0] FpPipeline_io_wakeups_0_bits_uop_dst_rtype,
  input       FpPipeline_io_wakeups_0_bits_uop_fp_val,
              FpPipeline_io_wakeups_1_valid,
  input [1:0] FpPipeline_io_wakeups_1_bits_uop_dst_rtype,
  input       FpPipeline_io_wakeups_1_bits_uop_fp_val,
              FpPipeline_io_wakeups_2_valid,
  input [1:0] FpPipeline_io_wakeups_2_bits_uop_dst_rtype,
  input       FpPipeline_io_wakeups_2_bits_uop_fp_val,
              FpPipeline_io_wakeups_3_valid,
  input [1:0] FpPipeline_io_wakeups_3_bits_uop_dst_rtype,
  input       FpPipeline_io_wakeups_3_bits_uop_fp_val,
              csr_io_singleStep,
              _brinfos_3_valid_T,
              clock,
              reset,
              csr_io_csr_stall,
              rob_io_commit_valids_1,
              rob_io_commit_valids_0
);

  wire        _GEN_3 = (_dec_hazards_T_28 | b2_mispredict) & rob_io_commit_rollback;
  wire        _GEN_4 = (_io_ifu_commit_valid_T | rob_io_commit_valids_2 | rob_io_commit_valids_3) & rob_io_com_xcpt_valid;
  wire        _GEN_5 = alu_exe_unit_io_iresp_valid & _rob_io_debug_wb_valids_2_T;
  wire        _GEN_6 = _GEN_5 & _GEN;
  wire        _GEN_7 = alu_exe_unit_1_io_iresp_valid & _rob_io_debug_wb_valids_3_T;
  wire        _GEN_8 = _GEN_7 & _GEN_0;
  wire        _GEN_9 = alu_exe_unit_2_io_iresp_valid & _rob_io_debug_wb_valids_4_T;
  wire        _GEN_10 = _GEN_9 & _GEN_1;
  wire        _GEN_11 = alu_exe_unit_3_io_iresp_valid & _rob_io_debug_wb_valids_5_T;
  wire        _GEN_12 = _GEN_11 & _GEN_2;
  wire        _GEN_13 = _GEN_5 & alu_exe_unit_io_iresp_bits_uop_dst_rtype == 2'h1;
  wire        _GEN_14 = alu_exe_unit_io_iresp_valid & ~_rob_io_debug_wb_valids_2_T & _rob_io_debug_wb_valids_2_T_2;
  wire        _GEN_15 = _GEN_7 & alu_exe_unit_1_io_iresp_bits_uop_dst_rtype == 2'h1;
  wire        _GEN_16 = alu_exe_unit_1_io_iresp_valid & ~_rob_io_debug_wb_valids_3_T & _rob_io_debug_wb_valids_3_T_2;
  wire        _GEN_17 = _GEN_9 & alu_exe_unit_2_io_iresp_bits_uop_dst_rtype == 2'h1;
  wire        _GEN_18 = alu_exe_unit_2_io_iresp_valid & ~_rob_io_debug_wb_valids_4_T & _rob_io_debug_wb_valids_4_T_2;
  wire        _GEN_19 = _GEN_11 & alu_exe_unit_3_io_iresp_bits_uop_dst_rtype == 2'h1;
  wire        _GEN_20 = alu_exe_unit_3_io_iresp_valid & ~_rob_io_debug_wb_valids_5_T & _rob_io_debug_wb_valids_5_T_2;
  wire        _GEN_21 = FpPipeline_io_wakeups_0_valid & FpPipeline_io_wakeups_0_bits_uop_dst_rtype != 2'h1;
  wire        _GEN_22 = FpPipeline_io_wakeups_0_valid & ~FpPipeline_io_wakeups_0_bits_uop_fp_val;
  wire        _GEN_23 = FpPipeline_io_wakeups_1_valid & FpPipeline_io_wakeups_1_bits_uop_dst_rtype != 2'h1;
  wire        _GEN_24 = FpPipeline_io_wakeups_1_valid & ~FpPipeline_io_wakeups_1_bits_uop_fp_val;
  wire        _GEN_25 = FpPipeline_io_wakeups_2_valid & FpPipeline_io_wakeups_2_bits_uop_dst_rtype != 2'h1;
  wire        _GEN_26 = FpPipeline_io_wakeups_2_valid & ~FpPipeline_io_wakeups_2_bits_uop_fp_val;
  wire        _GEN_27 = FpPipeline_io_wakeups_3_valid & FpPipeline_io_wakeups_3_bits_uop_dst_rtype != 2'h1;
  wire        _GEN_28 = FpPipeline_io_wakeups_3_valid & ~FpPipeline_io_wakeups_3_bits_uop_fp_val;
  wire        _GEN_29 = rob_io_com_xcpt_valid & _brinfos_3_valid_T;
  reg  [4:0]  small_0;
  reg  [26:0] large_0;
  `ifndef SYNTHESIS
    wire _GEN_30 = (`PRINTF_COND_) & ~reset & _GEN_6;
    wire _GEN_31 = (`PRINTF_COND_) & ~reset & _GEN_8;
    wire _GEN_32 = (`PRINTF_COND_) & ~reset & _GEN_10;
    wire _GEN_33 = (`PRINTF_COND_) & ~reset & _GEN_12;
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & _GEN_3)
        $fwrite(32'h80000002, "Assertion failed: Can't have a mispredict during rollback.\n    at core.scala:224 assert (!((brupdate.b1.mispredict_mask =/= 0.U || brupdate.b2.mispredict)\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_4)
        $fwrite(32'h80000002, "Assertion failed: ROB can't commit and except in same cycle!\n    at core.scala:470 assert(!(rob.io.commit.valids.reduce(_|_) && rob.io.com_xcpt.valid),\n");
      if (_GEN_30)
        $fwrite(32'h80000002, "Assertion failed\n    at core.scala:819 assert(!(resp.valid && resp.bits.uop.rf_wen && resp.bits.uop.dst_rtype =/= RT_FIX))\n");
      if (_GEN_31)
        $fwrite(32'h80000002, "Assertion failed\n    at core.scala:819 assert(!(resp.valid && resp.bits.uop.rf_wen && resp.bits.uop.dst_rtype =/= RT_FIX))\n");
      if (_GEN_32)
        $fwrite(32'h80000002, "Assertion failed\n    at core.scala:819 assert(!(resp.valid && resp.bits.uop.rf_wen && resp.bits.uop.dst_rtype =/= RT_FIX))\n");
      if (_GEN_33)
        $fwrite(32'h80000002, "Assertion failed\n    at core.scala:819 assert(!(resp.valid && resp.bits.uop.rf_wen && resp.bits.uop.dst_rtype =/= RT_FIX))\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_13)
        $fwrite(32'h80000002, "Assertion failed: [fppipeline] An FP writeback is being attempted to the Int Regfile.\n    at core.scala:1171 assert (!wbIsValid(RT_FLT), \"[fppipeline] An FP writeback is being attempted to the Int Regfile.\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_14)
        $fwrite(32'h80000002, "Assertion failed: [fppipeline] An Int writeback is being attempted with rf_wen disabled.\n    at core.scala:1173 assert (!(wbresp.valid &&\n");
      if (_GEN_30)
        $fwrite(32'h80000002, "Assertion failed: [fppipeline] writeback being attempted to Int RF with dst != Int type exe_units(2).iresp\n    at core.scala:1178 assert (!(wbresp.valid &&\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_15)
        $fwrite(32'h80000002, "Assertion failed: [fppipeline] An FP writeback is being attempted to the Int Regfile.\n    at core.scala:1171 assert (!wbIsValid(RT_FLT), \"[fppipeline] An FP writeback is being attempted to the Int Regfile.\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_16)
        $fwrite(32'h80000002, "Assertion failed: [fppipeline] An Int writeback is being attempted with rf_wen disabled.\n    at core.scala:1173 assert (!(wbresp.valid &&\n");
      if (_GEN_31)
        $fwrite(32'h80000002, "Assertion failed: [fppipeline] writeback being attempted to Int RF with dst != Int type exe_units(3).iresp\n    at core.scala:1178 assert (!(wbresp.valid &&\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_17)
        $fwrite(32'h80000002, "Assertion failed: [fppipeline] An FP writeback is being attempted to the Int Regfile.\n    at core.scala:1171 assert (!wbIsValid(RT_FLT), \"[fppipeline] An FP writeback is being attempted to the Int Regfile.\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_18)
        $fwrite(32'h80000002, "Assertion failed: [fppipeline] An Int writeback is being attempted with rf_wen disabled.\n    at core.scala:1173 assert (!(wbresp.valid &&\n");
      if (_GEN_32)
        $fwrite(32'h80000002, "Assertion failed: [fppipeline] writeback being attempted to Int RF with dst != Int type exe_units(4).iresp\n    at core.scala:1178 assert (!(wbresp.valid &&\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_19)
        $fwrite(32'h80000002, "Assertion failed: [fppipeline] An FP writeback is being attempted to the Int Regfile.\n    at core.scala:1171 assert (!wbIsValid(RT_FLT), \"[fppipeline] An FP writeback is being attempted to the Int Regfile.\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_20)
        $fwrite(32'h80000002, "Assertion failed: [fppipeline] An Int writeback is being attempted with rf_wen disabled.\n    at core.scala:1173 assert (!(wbresp.valid &&\n");
      if (_GEN_33)
        $fwrite(32'h80000002, "Assertion failed: [fppipeline] writeback being attempted to Int RF with dst != Int type exe_units(5).iresp\n    at core.scala:1178 assert (!(wbresp.valid &&\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_21)
        $fwrite(32'h80000002, "Assertion failed: [core] FP wakeup does not write back to a FP register.\n    at core.scala:1265 assert (!(wakeup.valid && wakeup.bits.uop.dst_rtype =/= RT_FLT),\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_22)
        $fwrite(32'h80000002, "Assertion failed: [core] FP wakeup does not involve an FP instruction.\n    at core.scala:1268 assert (!(wakeup.valid && !wakeup.bits.uop.fp_val),\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_23)
        $fwrite(32'h80000002, "Assertion failed: [core] FP wakeup does not write back to a FP register.\n    at core.scala:1265 assert (!(wakeup.valid && wakeup.bits.uop.dst_rtype =/= RT_FLT),\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_24)
        $fwrite(32'h80000002, "Assertion failed: [core] FP wakeup does not involve an FP instruction.\n    at core.scala:1268 assert (!(wakeup.valid && !wakeup.bits.uop.fp_val),\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_25)
        $fwrite(32'h80000002, "Assertion failed: [core] FP wakeup does not write back to a FP register.\n    at core.scala:1265 assert (!(wakeup.valid && wakeup.bits.uop.dst_rtype =/= RT_FLT),\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_26)
        $fwrite(32'h80000002, "Assertion failed: [core] FP wakeup does not involve an FP instruction.\n    at core.scala:1268 assert (!(wakeup.valid && !wakeup.bits.uop.fp_val),\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_27)
        $fwrite(32'h80000002, "Assertion failed: [core] FP wakeup does not write back to a FP register.\n    at core.scala:1265 assert (!(wakeup.valid && wakeup.bits.uop.dst_rtype =/= RT_FLT),\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_28)
        $fwrite(32'h80000002, "Assertion failed: [core] FP wakeup does not involve an FP instruction.\n    at core.scala:1268 assert (!(wakeup.valid && !wakeup.bits.uop.fp_val),\n");
      if ((`PRINTF_COND_) & ~reset & csr_io_singleStep)
        $fwrite(32'h80000002, "Assertion failed: [core] single-step is unsupported.\n    at core.scala:1296 assert (!(csr.io.singleStep), \"[core] single-step is unsupported.\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_29)
        $fwrite(32'h80000002, "Assertion failed: [core] exception occurred, but pipeline flush signal not set!\n    at core.scala:1312 assert (!(rob.io.com_xcpt.valid && !rob.io.flush.valid),\n");
      if ((`PRINTF_COND_) & ~reset & large_0[8])
        $fwrite(32'h80000002, "Assertion failed: Pipeline has hung.\n    at core.scala:1329 assert (!(idle_cycles.value(13)), \"Pipeline has hung.\")\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire [5:0]  nextSmall = {1'h0, small_0} + 6'h1;
  wire        _GEN_34 = (|{rob_io_commit_valids_3, rob_io_commit_valids_2, rob_io_commit_valids_1, rob_io_commit_valids_0}) | csr_io_csr_stall | reset;
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(~_GEN_3);
      assert__assert_1: assert(~_GEN_4);
      assert__assert_2: assert(~_GEN_6);
      assert__assert_3: assert(~_GEN_8);
      assert__assert_4: assert(~_GEN_10);
      assert__assert_5: assert(~_GEN_12);
      assert__assert_7: assert(~_GEN_13);
      assert__assert_8: assert(~_GEN_14);
      assert__assert_9: assert(~_GEN_6);
      assert__assert_10: assert(~_GEN_15);
      assert__assert_11: assert(~_GEN_16);
      assert__assert_12: assert(~_GEN_8);
      assert__assert_13: assert(~_GEN_17);
      assert__assert_14: assert(~_GEN_18);
      assert__assert_15: assert(~_GEN_10);
      assert__assert_16: assert(~_GEN_19);
      assert__assert_17: assert(~_GEN_20);
      assert__assert_18: assert(~_GEN_12);
      assert__assert_19: assert(~_GEN_21);
      assert__assert_20: assert(~_GEN_22);
      assert__assert_21: assert(~_GEN_23);
      assert__assert_22: assert(~_GEN_24);
      assert__assert_23: assert(~_GEN_25);
      assert__assert_24: assert(~_GEN_26);
      assert__assert_25: assert(~_GEN_27);
      assert__assert_26: assert(~_GEN_28);
      assert__assert_27: assert(~csr_io_singleStep);
      assert__assert_28: assert(~_GEN_29);
      assert__assert_29: assert(~(large_0[8]));
    end
    small_0 <= reset | _GEN_34 ? 5'h0 : nextSmall[4:0];
    if (reset)
      large_0 <= 27'h0;
    else if (_GEN_34)
      large_0 <= 27'h0;
    else if (nextSmall[5])
      large_0 <= large_0 + 27'h1;
  end // always @(posedge)
endmodule

