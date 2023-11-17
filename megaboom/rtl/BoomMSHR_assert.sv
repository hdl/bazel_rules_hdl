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
module BoomMSHR_assert(
  input       _io_way_valid_T,
              rpq_io_empty,
              rpq_io_enq_ready,
              _state_T_157,
              _state_T_158,
              _state_T_160,
              _state_T_162,
              _state_T_163,
              _state_T_164,
              _state_T_165,
              _state_T_169,
              _state_T_170,
              _state_T_171,
              _state_T_172,
              _state_T_173,
              clock,
              reset,
              _GEN,
              _rpq_io_enq_valid_T,
  input [1:0] io_req_old_meta_coh_state,
  input       _GEN_0,
              _GEN_1,
              _GEN_423,
              grant_had_data,
  input [3:0] _GEN_2,
  input       io_req_tag_match,
              state_is_hit,
              _io_probe_rdy_T_3,
              refill_done,
              _GEN_3026,
              _GEN_3,
              _GEN_4,
              _GEN_1000,
              _GEN_5,
              _GEN_1398,
              _GEN_6,
              _GEN_7,
              _GEN_8,
              _io_probe_rdy_T_8,
              _io_probe_rdy_T_4,
              _rpq_io_enq_valid_T_1,
              _GEN_9,
              _sec_rdy_T_6,
              _sec_rdy_T_5,
              _GEN_707,
              state_is_hit_1
);

  reg  req_needs_wb;
  wire _GEN_10 = _io_way_valid_T & ~rpq_io_empty;
  wire _state_T_85 = _state_T_157 | _state_T_158 | _state_T_160 | _state_T_162 | _state_T_163 | _state_T_164 | _state_T_165 | _state_T_169 | _state_T_170 | _state_T_171 | _state_T_172 | _state_T_173;
  wire _GEN_11 = ~grant_had_data & req_needs_wb;
  wire is_hit = _GEN_2 == 4'h3 | _GEN_2 == 4'h2 | _GEN_2 == 4'h1 | _GEN_2 == 4'h7 | _GEN_2 == 4'h6 | (&_GEN_2) | _GEN_2 == 4'hE;
  wire _state_T_179 = _state_T_157 | _state_T_158 | _state_T_160 | _state_T_162 | _state_T_163 | _state_T_164 | _state_T_165 | _state_T_169 | _state_T_170 | _state_T_171 | _state_T_172 | _state_T_173;
  wire _GEN_12 = _io_way_valid_T & _rpq_io_enq_valid_T;
  wire _GEN_13 = _GEN_12 & ~reset;
  wire _GEN_14 = _GEN_12 & io_req_tag_match & state_is_hit & ~reset;
  wire _GEN_15 = _GEN & ~_GEN_3026;
  wire _GEN_16 = _GEN_15 & _io_probe_rdy_T_3 & refill_done & ~reset;
  wire _GEN_17 = _GEN_15 & ~_io_probe_rdy_T_3 & ~_io_probe_rdy_T_4 & ~_io_probe_rdy_T_8 & ~_GEN_8 & ~_GEN_7 & ~_GEN_6 & ~_GEN_1398 & ~_GEN_5 & ~_GEN_1000;
  wire _GEN_18 = _GEN_17 & _GEN_3 & _GEN_4 & ~reset;
  wire _GEN_19 = _GEN_17 & ~_GEN_3 & ~_GEN_707 & ~_sec_rdy_T_5 & ~_sec_rdy_T_6 & _GEN_423 & ~_GEN_9 & ~_rpq_io_enq_valid_T_1 & _rpq_io_enq_valid_T;
  wire _GEN_20 = _GEN_19 & ~reset;
  wire _GEN_21 = _GEN_19 & io_req_tag_match & state_is_hit_1 & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & _GEN_10)
        $fwrite(32'h80000002, "Assertion failed\n    at mshrs.scala:131 assert(!(state === s_invalid && !rpq.io.empty))\n");
      if ((`PRINTF_COND_) & _GEN_13 & ~rpq_io_enq_ready)
        $fwrite(32'h80000002, "Assertion failed\n    at mshrs.scala:194 assert(rpq.io.enq.ready)\n");
      if ((`PRINTF_COND_) & _GEN_14 & ~_state_T_85)
        $fwrite(32'h80000002, "Assertion failed\n    at mshrs.scala:201 assert(isWrite(io.req.uop.mem_cmd))\n");
      if ((`PRINTF_COND_) & _GEN_16 & _GEN_11)
        $fwrite(32'h80000002, "Assertion failed\n    at mshrs.scala:251 assert(!(!grant_had_data && req_needs_wb))\n");
      if ((`PRINTF_COND_) & _GEN_18 & ~is_hit)
        $fwrite(32'h80000002, "Assertion failed: We still don't have permissions for this store\n    at mshrs.scala:357 assert(is_hit, \"We still don't have permissions for this store\")\n");
      if ((`PRINTF_COND_) & _GEN_20 & ~rpq_io_enq_ready)
        $fwrite(32'h80000002, "Assertion failed\n    at mshrs.scala:194 assert(rpq.io.enq.ready)\n");
      if ((`PRINTF_COND_) & _GEN_21 & ~_state_T_179)
        $fwrite(32'h80000002, "Assertion failed\n    at mshrs.scala:201 assert(isWrite(io.req.uop.mem_cmd))\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset)
      assert__assert: assert(~_GEN_10);
    if (_GEN_13)
      assert__state_assert: assert(rpq_io_enq_ready);
    if (_GEN_14)
      assert__state_assert_1: assert(_state_T_85);
    if (_GEN_16)
      assert__assert_1: assert(~_GEN_11);
    if (_GEN_18)
      assert__assert_2: assert(is_hit);
    if (_GEN_20)
      assert__state_assert_2: assert(rpq_io_enq_ready);
    if (_GEN_21)
      assert__state_assert_3: assert(_state_T_179);
    if (reset)
      req_needs_wb <= 1'h0;
    else if (_GEN) begin
      if (_GEN_0 | ~_GEN_423 | _GEN_1 | ~_rpq_io_enq_valid_T) begin
      end
      else
        req_needs_wb <= &io_req_old_meta_coh_state;
    end
    else if (_rpq_io_enq_valid_T)
      req_needs_wb <= &io_req_old_meta_coh_state;
  end // always @(posedge)
endmodule

