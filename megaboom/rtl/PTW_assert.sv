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
module PTW_assert(
  input       l2_hit,
              _r_pte_T_2,
              clock,
              _GEN,
              _GEN_0,
              pte_cache_hit,
              _GEN_1,
              _resp_ae_ptw_T,
              _GEN_2,
              s2_hit_vec_0,
              l2_error,
              _s0_suitable_T_1,
              arb_io_out_bits_bits_stage2,
              _GEN_3,
  input [2:0] state,
  input       reset,
              _GEN_4,
              _GEN_5,
              mem_resp_valid,
              io_mem_s2_nack
);

  wire _GEN_1226;
  reg  pte_hit;
  wire _GEN_6 = l2_hit & (_GEN_1226 | pte_hit & _r_pte_T_2 & ~l2_hit);
  wire _GEN_7 = s2_hit_vec_0 | l2_error;
  wire _GEN_8 = _s0_suitable_T_1 | arb_io_out_bits_bits_stage2;
  assign _GEN_1226 = ~_GEN_2 & _GEN_1 & _resp_ae_ptw_T;
  wire _GEN_9 = _r_pte_T_2 | _GEN_3;
  wire _GEN_10 = state == 3'h5;
  wire _GEN_11 = l2_hit & ~reset;
  wire _GEN_12 = _GEN_4 & ~reset;
  wire _GEN_13 = _GEN_5 & ~reset;
  wire _GEN_14 = mem_resp_valid & ~reset;
  wire _GEN_15 = io_mem_s2_nack & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & _GEN_6)
        $fwrite(32'h80000002, "Assertion failed: PTE Cache Hit/Miss Performance Monitor Events are lower priority than L2TLB Hit event\n    at PTW.scala:407 assert(!(io.dpath.perf.l2hit && (io.dpath.perf.pte_miss || io.dpath.perf.pte_hit)),\n");
      if ((`PRINTF_COND_) & _GEN_11 & ~_GEN_7)
        $fwrite(32'h80000002, "Assertion failed: L2 TLB multi-hit\n    at PTW.scala:498 assert((PopCount(s2_hit_vec) === 1.U) || s2_error, \"L2 TLB multi-hit\")\n");
      if ((`PRINTF_COND_) & _GEN_12 & ~_GEN_8)
        $fwrite(32'h80000002, "Assertion failed\n    at PTW.scala:622 assert(!arb.io.out.bits.bits.need_gpa || arb.io.out.bits.bits.stage2)\n");
      if ((`PRINTF_COND_) & _GEN_13 & ~_GEN_9)
        $fwrite(32'h80000002, "Assertion failed\n    at PTW.scala:693 assert(state === s_req || state === s_wait1)\n");
      if ((`PRINTF_COND_) & _GEN_14 & ~_GEN_10)
        $fwrite(32'h80000002, "Assertion failed\n    at PTW.scala:699 assert(state === s_wait3)\n");
      if ((`PRINTF_COND_) & _GEN_15 & ~_GEN_1)
        $fwrite(32'h80000002, "Assertion failed\n    at PTW.scala:743 assert(state === s_wait2)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset)
      assert__assert: assert(~_GEN_6);
    if (_GEN_11)
      assert__assert_1: assert(_GEN_7);
    if (_GEN_12)
      assert__assert_2: assert(_GEN_8);
    if (_GEN_13)
      assert__assert_3: assert(_GEN_9);
    if (_GEN_14)
      assert__assert_4: assert(_GEN_10);
    if (_GEN_15)
      assert__assert_5: assert(_GEN_1);
    pte_hit <= _GEN & _GEN_0 & pte_cache_hit;
  end // always @(posedge)
endmodule

