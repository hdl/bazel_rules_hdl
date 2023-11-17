// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module AsyncResetSynchronizerPrimitiveShiftReg_d3_i0(
  input  clock,
         reset,
         io_d,
  output io_q
);

  reg sync_0;
  reg sync_1;
  reg sync_2;
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      sync_0 <= 1'h0;
      sync_1 <= 1'h0;
      sync_2 <= 1'h0;
    end
    else begin
      sync_0 <= sync_1;
      sync_1 <= sync_2;
      sync_2 <= io_d;
    end
  end // always @(posedge, posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      if (reset) begin
        sync_0 = 1'h0;
        sync_1 = 1'h0;
        sync_2 = 1'h0;
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_q = sync_0;
endmodule

