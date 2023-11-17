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
module Directory_assert(
  input wipeDone,
        _q_io_deq_ready_T,
        _victimLTE_T_7,
        _victimLTE_T_6,
        _victimLTE_T_5,
        victimLFSR_prng_io_out_9,
        _victimLTE_T_3,
        _victimLTE_T_2,
        _victimLTE_T_1,
        io_read_valid,
        clock,
        reset,
        _view__T_76,
        _view__T_75,
        _view__T_74,
        _view__T_73,
        _view__T_72,
        _view__T_71,
        _GEN
);

  wire _GEN_0 = wipeDone | _q_io_deq_ready_T;
  wire _GEN_1 = _q_io_deq_ready_T | wipeDone;
  reg  ren1;
  wire _GEN_2 = ~ren1 | ({~_victimLTE_T_6, ~_victimLTE_T_5, ~victimLFSR_prng_io_out_9, ~_victimLTE_T_3, ~_victimLTE_T_2, ~_victimLTE_T_1} & {_victimLTE_T_7, _victimLTE_T_6, _victimLTE_T_5, victimLFSR_prng_io_out_9, _victimLTE_T_3, _victimLTE_T_2}) == 6'h0;
  wire _GEN_3 = ~ren1 | {1'h0, {1'h0, {1'h0, _GEN} + {1'h0, _view__T_71}} + {1'h0, {1'h0, _view__T_72} + {1'h0, _view__T_73}}} + {1'h0, {1'h0, {1'h0, _view__T_74} + {1'h0, _view__T_75}} + {1'h0, {1'h0, _view__T_76} + {1'h0, _victimLTE_T_7}}} == 4'h1;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed\n    at Directory.scala:86 assert (wipeDone || !io.read.valid)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_1)
        $fwrite(32'h80000002, "Assertion failed\n    at Directory.scala:91 assert (!io.read.valid || wipeDone)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_2)
        $fwrite(32'h80000002, "Assertion failed\n    at Directory.scala:122 assert (!ren2 || ((victimSimp >> 1) & ~victimSimp) === 0.U) // monotone\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_3)
        $fwrite(32'h80000002, "Assertion failed\n    at Directory.scala:123 assert (!ren2 || PopCount(victimWayOH) === 1.U)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(_GEN_0);
      assert__assert_1: assert(_GEN_1);
      assert__assert_3: assert(_GEN_2);
      assert__assert_4: assert(_GEN_3);
    end
    if (reset)
      ren1 <= 1'h0;
    else
      ren1 <= io_read_valid;
  end // always @(posedge)
endmodule

