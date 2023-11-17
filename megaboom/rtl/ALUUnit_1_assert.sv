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
module ALUUnit_1_assert(
  input [1:0] pc_sel,
  input       brinfo_valid,
              reset,
              clock
);

  wire _GEN = pc_sel != 2'h2;
  wire _GEN_0 = brinfo_valid & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_0 & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at functional-unit.scala:375 assert (pc_sel =/= PC_JALR)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (_GEN_0)
      assert__assert: assert(_GEN);
  end // always @(posedge)
endmodule

