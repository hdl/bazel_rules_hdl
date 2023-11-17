// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ClockCrossingReg_w32(
  input         clock,
  input  [31:0] io_d,
  input         io_en,
  output [31:0] io_q
);

  reg [31:0] cdc_reg;
  always @(posedge clock) begin
    if (io_en)
      cdc_reg <= io_d;
  end // always @(posedge)
  assign io_q = cdc_reg;
endmodule

