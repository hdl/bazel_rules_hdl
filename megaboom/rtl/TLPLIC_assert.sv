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
module TLPLIC_assert(
  input        claimer_1,
               claimer_0,
               completer_1,
               completer_0,
               completerDev,
  input [63:0] out_back_q_io_deq_bits_data,
  input        reset,
               clock
);

  wire [1:0] _GEN = {claimer_1, claimer_0};
  wire [1:0] _GEN_0 = _GEN & _GEN - 2'h1;
  wire [1:0] _GEN_1 = {completer_1, completer_0};
  wire [1:0] _GEN_2 = _GEN_1 & _GEN_1 - 2'h1;
  wire       _out_T_72 = completerDev == out_back_q_io_deq_bits_data[32];
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(~(|_GEN_0));
      assert__assert_1: assert(~(|_GEN_2));
    end
    if (~reset)
      assert__out_assert: assert(_out_T_72);
  end // always @(posedge)
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed\n    at Plic.scala:244 assert((claimer.asUInt & (claimer.asUInt - 1.U)) === 0.U) // One-Hot\n");
      if ((`PRINTF_COND_) & ~reset & (|_GEN_2))
        $fwrite(32'h80000002, "Assertion failed\n    at Plic.scala:261 assert((completer.asUInt & (completer.asUInt - 1.U)) === 0.U) // One-Hot\n");
      if ((`PRINTF_COND_) & ~reset & ~_out_T_72)
        $fwrite(32'h80000002, "Assertion failed: completerDev should be consistent for all harts\n    at Plic.scala:291 assert(completerDev === data.extract(log2Ceil(nDevices+1)-1, 0),\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule

