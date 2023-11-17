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
module IssueSlot_32_assert(
  input       io_clear,
              io_kill,
  input [1:0] state,
  input [6:0] next_uop_prs1,
              next_uop_prs2,
  input       io_spec_ld_wakeup_0_valid,
  input [6:0] io_spec_ld_wakeup_0_bits,
  input       io_spec_ld_wakeup_1_valid,
  input [6:0] io_spec_ld_wakeup_1_bits,
  input       next_p1_poisoned,
              next_p2_poisoned,
              io_in_uop_valid,
              reset,
              clock,
              _GEN,
              _GEN_0,
              _GEN_140,
              _GEN_142,
              _GEN_1,
              _GEN_2
);

  wire _GEN_3 = state == 2'h0 | io_clear | io_kill;
  wire _GEN_4 = io_spec_ld_wakeup_0_valid & io_spec_ld_wakeup_0_bits == 7'h0;
  wire _GEN_5 = io_spec_ld_wakeup_1_valid & io_spec_ld_wakeup_1_bits == 7'h0;
  wire _GEN_6 = io_in_uop_valid & ~reset;
  wire _GEN_7 = _GEN & ~reset;
  wire _GEN_8 = _GEN_0 & ~reset;
  wire _GEN_9 = _GEN_140 & ~reset;
  wire _GEN_10 = _GEN_142 & ~reset;
  wire _GEN_11 = _GEN_1 & ~reset;
  wire _GEN_12 = _GEN_2 & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_6 & ~_GEN_3)
        $fwrite(32'h80000002, "Assertion failed: trying to overwrite a valid issue slot.\n    at issue-slot.scala:156 assert (is_invalid || io.clear || io.kill, \"trying to overwrite a valid issue slot.\")\n");
      if ((`PRINTF_COND_) & _GEN_7 & ~(|next_uop_prs1))
        $fwrite(32'h80000002, "Assertion failed: Poison bit can't be set for prs1=x0!\n    at issue-slot.scala:176 assert(next_uop.prs1 =/= 0.U, \"Poison bit can't be set for prs1=x0!\")\n");
      if ((`PRINTF_COND_) & _GEN_8 & ~(|next_uop_prs2))
        $fwrite(32'h80000002, "Assertion failed: Poison bit can't be set for prs2=x0!\n    at issue-slot.scala:180 assert(next_uop.prs2 =/= 0.U, \"Poison bit can't be set for prs2=x0!\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_4)
        $fwrite(32'h80000002, "Assertion failed: Loads to x0 should never speculatively wakeup other instructions\n    at issue-slot.scala:203 assert (!(io.spec_ld_wakeup(w).valid && io.spec_ld_wakeup(w).bits === 0.U),\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_5)
        $fwrite(32'h80000002, "Assertion failed: Loads to x0 should never speculatively wakeup other instructions\n    at issue-slot.scala:203 assert (!(io.spec_ld_wakeup(w).valid && io.spec_ld_wakeup(w).bits === 0.U),\n");
      if ((`PRINTF_COND_) & _GEN_9 & next_p1_poisoned)
        $fwrite(32'h80000002, "Assertion failed\n    at issue-slot.scala:214 assert (!next_p1_poisoned)\n");
      if ((`PRINTF_COND_) & _GEN_10 & next_p2_poisoned)
        $fwrite(32'h80000002, "Assertion failed\n    at issue-slot.scala:221 assert (!next_p2_poisoned)\n");
      if ((`PRINTF_COND_) & _GEN_11 & next_p1_poisoned)
        $fwrite(32'h80000002, "Assertion failed\n    at issue-slot.scala:214 assert (!next_p1_poisoned)\n");
      if ((`PRINTF_COND_) & _GEN_12 & next_p2_poisoned)
        $fwrite(32'h80000002, "Assertion failed\n    at issue-slot.scala:221 assert (!next_p2_poisoned)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (_GEN_6)
      assert__assert: assert(_GEN_3);
    if (_GEN_7)
      assert__assert_1: assert(|next_uop_prs1);
    if (_GEN_8)
      assert__assert_2: assert(|next_uop_prs2);
    if (~reset) begin
      assert__assert_3: assert(~_GEN_4);
      assert__assert_4: assert(~_GEN_5);
    end
    if (_GEN_9)
      assert__assert_5: assert(~next_p1_poisoned);
    if (_GEN_10)
      assert__assert_6: assert(~next_p2_poisoned);
    if (_GEN_11)
      assert__assert_7: assert(~next_p1_poisoned);
    if (_GEN_12)
      assert__assert_8: assert(~next_p2_poisoned);
  end // always @(posedge)
endmodule

