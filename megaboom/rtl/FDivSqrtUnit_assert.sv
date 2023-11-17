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
module FDivSqrtUnit_assert(
  input r_buffer_val,
        io_req_valid,
        r_divsqrt_val,
        r_out_val,
        _GEN,
        reset,
        clock,
        _may_fire_input_T_2
);

  wire _GEN_0 = r_buffer_val & io_req_valid;
  wire _GEN_1 = r_out_val & _GEN;
  wire _GEN_2 = _GEN & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & _GEN_0)
        $fwrite(32'h80000002, "Assertion failed: [fdiv] a request is incoming while the buffer is already full.\n    at fdiv.scala:137 assert (!(r_buffer_val && io.req.valid), \"[fdiv] a request is incoming while the buffer is already full.\")\n");
      if ((`PRINTF_COND_) & _GEN_2 & _may_fire_input_T_2)
        $fwrite(32'h80000002, "Assertion failed: [fdiv] a response is being generated for no request.\n    at fdiv.scala:204 assert (r_divsqrt_val, \"[fdiv] a response is being generated for no request.\")\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_1)
        $fwrite(32'h80000002, "Assertion failed: [fdiv] Buffered output being overwritten by another output from the fdiv/fsqrt unit.\n    at fdiv.scala:207 assert (!(r_out_val && (divsqrt.io.outValid_div || divsqrt.io.outValid_sqrt)),\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset)
      assert__assert: assert(~_GEN_0);
    if (_GEN_2)
      assert__assert_1: assert(r_divsqrt_val);
    if (~reset)
      assert__assert_2: assert(~_GEN_1);
  end // always @(posedge)
endmodule

