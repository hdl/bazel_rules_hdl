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
module SourceD_assert(
  input queue_io_enq_ready,
        queue_io_enq_valid_REG_1,
        _io_grant_safe_T_11,
        queue_io_deq_valid,
        s3_need_r,
        s4_full,
        clock,
        s4_latch,
        s3_latch,
        s2_valid_pb,
        s2_req_prio_0,
        io_pb_beat_corrupt,
        io_rel_beat_corrupt,
        s3_need_pb,
        reset
);

  wire _GEN = ~queue_io_enq_valid_REG_1 | queue_io_enq_ready;
  reg  s2_pdata_r_corrupt;
  reg  s3_pdata_corrupt;
  wire _GEN_0 = _io_grant_safe_T_11 | ~s3_need_r | queue_io_deq_valid;
  reg  s4_need_pb;
  reg  s4_pdata_corrupt;
  wire _GEN_1 = s4_full & s4_need_pb & s4_pdata_corrupt;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at SourceD.scala:123 assert (!queue.io.enq.valid || queue.io.enq.ready)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed\n    at SourceD.scala:232 assert (!s3_full || !s3_need_r || queue.io.deq.valid)\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_1)
        $fwrite(32'h80000002, "Assertion failed: Data poisoning unsupported\n    at SourceD.scala:277 assert (!(s4_full && s4_need_pb && s4_pdata.corrupt), \"Data poisoning unsupported\")\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(_GEN);
      assert__assert_1: assert(_GEN_0);
      assert__assert_2: assert(~_GEN_1);
    end
    if (s2_valid_pb) begin
      if (s2_req_prio_0)
        s2_pdata_r_corrupt <= io_pb_beat_corrupt;
      else
        s2_pdata_r_corrupt <= io_rel_beat_corrupt;
    end
    if (s3_latch) begin
      if (s2_valid_pb) begin
        if (s2_req_prio_0)
          s3_pdata_corrupt <= io_pb_beat_corrupt;
        else
          s3_pdata_corrupt <= io_rel_beat_corrupt;
      end
      else
        s3_pdata_corrupt <= s2_pdata_r_corrupt;
    end
    if (s4_latch) begin
      s4_need_pb <= s3_need_pb;
      s4_pdata_corrupt <= s3_pdata_corrupt;
    end
  end // always @(posedge)
endmodule

