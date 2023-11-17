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
module IntToFPUnit_assert(
  input        io_req_valid,
               fp_decoder_io_sigs_fromint,
  input [64:0] io_req_bits_rs1_data,
  input [1:0]  fp_decoder_io_sigs_typeTagIn,
  input        reset,
               clock
);

  wire _GEN = io_req_valid & fp_decoder_io_sigs_fromint & (fp_decoder_io_sigs_typeTagIn[0] | (&(io_req_bits_rs1_data[64:60]))) & (fp_decoder_io_sigs_typeTagIn[0] ? io_req_bits_rs1_data[64] : io_req_bits_rs1_data[31]);
  wire _GEN_0 = io_req_valid & ~fp_decoder_io_sigs_fromint;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & _GEN)
        $fwrite(32'h80000002, "Assertion failed: [func] IntToFP integer input has 65th high-order bit set!\n    at functional-unit.scala:618 assert (!(io.req.valid && fp_ctrl.fromint && req.in1(xLen).asBool),\n");
      if ((`PRINTF_COND_) & ~reset & _GEN_0)
        $fwrite(32'h80000002, "Assertion failed: [func] Only support fromInt micro-ops.\n    at functional-unit.scala:621 assert (!(io.req.valid && !fp_ctrl.fromint),\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(~_GEN);
      assert__assert_1: assert(~_GEN_0);
    end
  end // always @(posedge)
endmodule

