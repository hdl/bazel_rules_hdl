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
module BranchPredictor_assert(
  input [7:0] io_update_bits_br_mask,
  input [2:0] io_update_bits_cfi_idx_bits,
  input       io_update_valid,
              io_update_bits_cfi_is_br,
              io_update_bits_cfi_idx_valid,
              reset,
              clock
);

  wire [7:0] _GEN = io_update_bits_br_mask >> io_update_bits_cfi_idx_bits;
  wire       _GEN_0 = io_update_valid & io_update_bits_cfi_is_br & io_update_bits_cfi_idx_valid & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_0 & ~(_GEN[0]))
        $fwrite(32'h80000002, "Assertion failed\n    at predictor.scala:468 assert(io.update.bits.br_mask(io.update.bits.cfi_idx.bits))\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (_GEN_0)
      assert__assert: assert(_GEN[0]);
  end // always @(posedge)
endmodule

