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
module BoomNonBlockingDCache_assert(
  input        _wb_fire_T,
               _wb_fire_T_1,
               io_lsu_s1_kill_0,
               io_lsu_req_bits_0_valid,
               clock,
               _s1_valid_T_19,
               io_lsu_s1_kill_1,
               io_lsu_req_bits_1_valid,
               _s2_sc_T_2,
               _mshrs_io_req_0_valid_T,
               _s2_hit_T_15,
               reset,
               s2_valid_0,
               s2_sc_fail,
               s2_sc,
  input [39:0] s2_req_0_addr,
  input        s2_send_resp_0,
               s2_send_nack_0,
               s2_send_resp_1,
               s2_send_nack_1,
               _mshrs_io_req_0_valid_T_74,
               _mshrs_io_req_1_valid_T_74,
               winner_1,
               wb_io_release_valid,
               _nodeOut_c_valid_T,
               _io_lsu_nack_0_valid_output,
  input [2:0]  s2_type,
  input        _io_lsu_nack_1_valid_output,
               _s2_nack_victim_T_2,
               _s3_valid_T_25,
               s2_nack_1,
               _mshrs_io_req_1_valid_T_50,
               _mshrs_io_req_1_valid_T_51,
               _mshrs_io_req_1_valid_T_53,
               _mshrs_io_req_1_valid_T_55,
               _mshrs_io_req_1_valid_T_56,
               _mshrs_io_req_1_valid_T_57,
               _mshrs_io_req_1_valid_T_58,
               _mshrs_io_req_1_valid_T_62,
               _mshrs_io_req_1_valid_T_63,
               _mshrs_io_req_1_valid_T_64,
               _mshrs_io_req_1_valid_T_65,
               _mshrs_io_req_1_valid_T_66
);

  wire        _GEN = _wb_fire_T ^ _wb_fire_T_1;
  reg         REG;
  reg         REG_1;
  wire        _GEN_0 = io_lsu_s1_kill_0 & ~REG & ~REG_1;
  reg         REG_2;
  reg         REG_3;
  wire        _GEN_1 = io_lsu_s1_kill_1 & ~REG_2 & ~REG_3;
  wire        _GEN_2 = _s2_sc_T_2 & _mshrs_io_req_0_valid_T;
  wire        _GEN_3 = _s2_hit_T_15 & _mshrs_io_req_0_valid_T;
  reg  [39:0] debug_sc_fail_addr;
  reg  [7:0]  debug_sc_fail_cnt;
  wire        _GEN_4 = debug_sc_fail_cnt < 8'h64;
  wire        _GEN_5 = s2_send_resp_0 & s2_send_nack_0;
  wire        _GEN_6 = s2_send_resp_1 & s2_send_nack_1;
  wire        _GEN_7 = _mshrs_io_req_0_valid_T_74 & _s2_sc_T_2;
  wire        _GEN_8 = _mshrs_io_req_1_valid_T_74 & _s2_sc_T_2;
  wire        _GEN_9 = ~wb_io_release_valid | ~winner_1;
  wire        _GEN_10 = ~_nodeOut_c_valid_T | wb_io_release_valid | winner_1;
  wire        _GEN_11 = s2_type != 3'h4;
  wire        _GEN_12 = _io_lsu_nack_0_valid_output & _GEN_11;
  wire        _GEN_13 = _io_lsu_nack_1_valid_output & _GEN_11;
  wire        _GEN_14 = _s2_nack_victim_T_2 & (_mshrs_io_req_1_valid_T_50 | _mshrs_io_req_1_valid_T_51 | _mshrs_io_req_1_valid_T_53 | _mshrs_io_req_1_valid_T_55 | _mshrs_io_req_1_valid_T_56 | _mshrs_io_req_1_valid_T_57 | _mshrs_io_req_1_valid_T_58 | _mshrs_io_req_1_valid_T_62 | _mshrs_io_req_1_valid_T_63 | _mshrs_io_req_1_valid_T_64 | _mshrs_io_req_1_valid_T_65 | _mshrs_io_req_1_valid_T_66) & _s3_valid_T_25 & ~(s2_send_nack_1 & s2_nack_1);
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & _GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at dcache.scala:548 assert(!(wb.io.meta_read.fire ^ wb.io.data_req.fire))\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_0)
        $fwrite(32'h80000002, "Assertion failed\n    at dcache.scala:611 assert(!(io.lsu.s1_kill(w) && !RegNext(io.lsu.req.fire) && !RegNext(io.lsu.req.bits(w).valid)))\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_1)
        $fwrite(32'h80000002, "Assertion failed\n    at dcache.scala:611 assert(!(io.lsu.s1_kill(w) && !RegNext(io.lsu.req.fire) && !RegNext(io.lsu.req.bits(w).valid)))\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_2)
        $fwrite(32'h80000002, "Assertion failed: Replays should always hit\n    at dcache.scala:651 assert(!(s2_type === t_replay && !s2_hit(0)), \"Replays should always hit\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_3)
        $fwrite(32'h80000002, "Assertion failed: Writeback should always see data hit\n    at dcache.scala:652 assert(!(s2_type === t_wb && !s2_hit(0)), \"Writeback should always see data hit\")\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_4)
        $fwrite(32'h80000002, "Assertion failed: L1DCache failed too many SCs in a row\n    at dcache.scala:703 assert(debug_sc_fail_cnt < 100.U, \"L1DCache failed too many SCs in a row\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_5)
        $fwrite(32'h80000002, "Assertion failed\n    at dcache.scala:737 assert(!(s2_send_resp(w) && s2_send_nack(w)))\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_6)
        $fwrite(32'h80000002, "Assertion failed\n    at dcache.scala:737 assert(!(s2_send_resp(w) && s2_send_nack(w)))\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_7)
        $fwrite(32'h80000002, "Assertion failed: Replays should not need to go back into MSHRs\n    at dcache.scala:758 assert(!(mshrs.io.req(w).valid && s2_type === t_replay), \"Replays should not need to go back into MSHRs\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_8)
        $fwrite(32'h80000002, "Assertion failed: Replays should not need to go back into MSHRs\n    at dcache.scala:758 assert(!(mshrs.io.req(w).valid && s2_type === t_replay), \"Replays should not need to go back into MSHRs\")\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_9)
        $fwrite(32'h80000002, "Assertion failed\n    at Arbiter.scala:77 assert((prefixOR zip winner) map { case (p,w) => !p || !w } reduce {_ && _})\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_10)
        $fwrite(32'h80000002, "Assertion failed\n    at Arbiter.scala:79 assert (!valids.reduce(_||_) || winner.reduce(_||_))\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_12)
        $fwrite(32'h80000002, "Assertion failed\n    at dcache.scala:866 assert(!(io.lsu.nack(w).valid && s2_type =/= t_lsu))\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_13)
        $fwrite(32'h80000002, "Assertion failed\n    at dcache.scala:866 assert(!(io.lsu.nack(w).valid && s2_type =/= t_lsu))\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_14)
        $fwrite(32'h80000002, "Assertion failed: Store must go through 0th pipe in L1D\n    at dcache.scala:874 assert(!(s2_valid(w) && s2_hit(w) && isWrite(s2_req(w).uop.mem_cmd) &&\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire        _GEN_15 = s2_req_0_addr == debug_sc_fail_addr;
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(~_GEN);
      assert__assert_1: assert(~_GEN_0);
      assert__assert_2: assert(~_GEN_1);
      assert__assert_3: assert(~_GEN_2);
      assert__assert_4: assert(~_GEN_3);
      assert__assert_5: assert(_GEN_4);
      assert__assert_6: assert(~_GEN_5);
      assert__assert_7: assert(~_GEN_6);
      assert__assert_8: assert(~_GEN_7);
      assert__assert_9: assert(~_GEN_8);
      assert__assert_10: assert(_GEN_9);
      assert__assert_11: assert(_GEN_10);
      assert__assert_12: assert(~_GEN_12);
      assert__assert_13: assert(~_GEN_13);
      assert__assert_14: assert(~_GEN_14);
    end
    REG <= _s1_valid_T_19;
    REG_1 <= io_lsu_req_bits_0_valid;
    REG_2 <= _s1_valid_T_19;
    REG_3 <= io_lsu_req_bits_1_valid;
    if (reset) begin
      debug_sc_fail_addr <= 40'h0;
      debug_sc_fail_cnt <= 8'h0;
    end
    else begin
      if (~s2_valid_0 | _GEN_15 | ~s2_sc_fail) begin
      end
      else
        debug_sc_fail_addr <= s2_req_0_addr;
      if (s2_valid_0) begin
        if (_GEN_15) begin
          if (s2_sc_fail)
            debug_sc_fail_cnt <= debug_sc_fail_cnt + 8'h1;
          else if (s2_sc)
            debug_sc_fail_cnt <= 8'h0;
        end
        else if (s2_sc_fail)
          debug_sc_fail_cnt <= 8'h1;
      end
    end
  end // always @(posedge)
endmodule

