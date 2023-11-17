// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module MaxPeriodFibonacciLFSR(
  input  clock,
         reset,
         io_increment,
  output io_out_0,
         io_out_1,
         io_out_2,
         io_out_3,
         io_out_4,
         io_out_5,
         io_out_6,
         io_out_7,
         io_out_8,
         io_out_9,
         io_out_10,
         io_out_11,
         io_out_12,
         io_out_13,
         io_out_14,
         io_out_15
);

  reg state_0;
  reg state_1;
  reg state_2;
  reg state_3;
  reg state_4;
  reg state_5;
  reg state_6;
  reg state_7;
  reg state_8;
  reg state_9;
  reg state_10;
  reg state_11;
  reg state_12;
  reg state_13;
  reg state_14;
  reg state_15;
  always @(posedge clock) begin
    if (reset) begin
      state_0 <= 1'h1;
      state_1 <= 1'h0;
      state_2 <= 1'h0;
      state_3 <= 1'h0;
      state_4 <= 1'h0;
      state_5 <= 1'h0;
      state_6 <= 1'h0;
      state_7 <= 1'h0;
      state_8 <= 1'h0;
      state_9 <= 1'h0;
      state_10 <= 1'h0;
      state_11 <= 1'h0;
      state_12 <= 1'h0;
      state_13 <= 1'h0;
      state_14 <= 1'h0;
      state_15 <= 1'h0;
    end
    else if (io_increment) begin
      state_0 <= state_15 ^ state_13 ^ state_12 ^ state_10;
      state_1 <= state_0;
      state_2 <= state_1;
      state_3 <= state_2;
      state_4 <= state_3;
      state_5 <= state_4;
      state_6 <= state_5;
      state_7 <= state_6;
      state_8 <= state_7;
      state_9 <= state_8;
      state_10 <= state_9;
      state_11 <= state_10;
      state_12 <= state_11;
      state_13 <= state_12;
      state_14 <= state_13;
      state_15 <= state_14;
    end
  end // always @(posedge)
  assign io_out_0 = state_0;
  assign io_out_1 = state_1;
  assign io_out_2 = state_2;
  assign io_out_3 = state_3;
  assign io_out_4 = state_4;
  assign io_out_5 = state_5;
  assign io_out_6 = state_6;
  assign io_out_7 = state_7;
  assign io_out_8 = state_8;
  assign io_out_9 = state_9;
  assign io_out_10 = state_10;
  assign io_out_11 = state_11;
  assign io_out_12 = state_12;
  assign io_out_13 = state_13;
  assign io_out_14 = state_14;
  assign io_out_15 = state_15;
endmodule

