// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module JtagStateMachine(
  input        clock,
               reset,
               io_tms,
  output [3:0] io_currState
);

  reg  [3:0] casez_tmp;
  reg  [3:0] currState;
  wire [3:0] _nextState_T_15 = io_tms ? 4'h7 : 4'hC;
  wire [3:0] _nextState_T_4 = io_tms ? 4'h1 : 4'h2;
  wire [3:0] _nextState_T_11 = io_tms ? 4'h9 : 4'hA;
  always @(*) begin
    casez (currState)
      4'b0000:
        casez_tmp = io_tms ? 4'h5 : 4'h2;
      4'b0001:
        casez_tmp = io_tms ? 4'h5 : 4'h3;
      4'b0010:
        casez_tmp = _nextState_T_4;
      4'b0011:
        casez_tmp = io_tms ? 4'h0 : 4'h3;
      4'b0100:
        casez_tmp = {3'h7, io_tms};
      4'b0101:
        casez_tmp = _nextState_T_15;
      4'b0110:
        casez_tmp = _nextState_T_4;
      4'b0111:
        casez_tmp = {2'h1, ~io_tms, 1'h0};
      4'b1000:
        casez_tmp = io_tms ? 4'hD : 4'hA;
      4'b1001:
        casez_tmp = io_tms ? 4'hD : 4'hB;
      4'b1010:
        casez_tmp = _nextState_T_11;
      4'b1011:
        casez_tmp = io_tms ? 4'h8 : 4'hB;
      4'b1100:
        casez_tmp = _nextState_T_15;
      4'b1101:
        casez_tmp = _nextState_T_15;
      4'b1110:
        casez_tmp = _nextState_T_11;
      default:
        casez_tmp = io_tms ? 4'hF : 4'hC;
    endcase
  end // always @(*)
  always @(posedge clock or posedge reset) begin
    if (reset)
      currState <= 4'hF;
    else
      currState <= casez_tmp;
  end // always @(posedge, posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      if (reset)
        currState = 4'hF;
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_currState = currState;
endmodule

