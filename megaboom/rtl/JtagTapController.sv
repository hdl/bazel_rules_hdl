// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module JtagTapController(
  input        clock,
               reset,
               io_jtag_TMS,
               io_jtag_TDI,
               io_control_jtag_reset,
               io_dataChainIn_data,
  output       io_jtag_TDO_data,
  output [4:0] io_output_instruction,
  output       io_output_tapIsInTestLogicReset,
               io_dataChainOut_shift,
               io_dataChainOut_data,
               io_dataChainOut_capture,
               io_dataChainOut_update
);

  wire       _irChain_io_chainOut_data;
  wire [4:0] _irChain_io_update_bits;
  wire [3:0] _stateMachine_io_currState;
  wire       _clock_falling_T_1 = ~clock;
  reg        tdoReg;
  wire       _irChain_io_chainIn_update_T = _stateMachine_io_currState == 4'hD;
  reg  [4:0] activeInstruction;
  wire       _io_dataChainOut_shift_T = _stateMachine_io_currState == 4'h2;
  always @(posedge _clock_falling_T_1 or posedge io_control_jtag_reset) begin
    if (io_control_jtag_reset) begin
      tdoReg <= 1'h0;
      activeInstruction <= 5'h1;
    end
    else begin
      if (_io_dataChainOut_shift_T)
        tdoReg <= io_dataChainIn_data;
      else
        tdoReg <= _irChain_io_chainOut_data;
      if (&_stateMachine_io_currState)
        activeInstruction <= 5'h1;
      else if (_irChain_io_chainIn_update_T)
        activeInstruction <= _irChain_io_update_bits;
    end
  end // always @(posedge, posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      if (io_control_jtag_reset) begin
        tdoReg = 1'h0;
        activeInstruction = 5'h1;
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  JtagStateMachine stateMachine (
    .clock        (clock),
    .reset        (io_control_jtag_reset),
    .io_tms       (io_jtag_TMS),
    .io_currState (_stateMachine_io_currState)
  );
  CaptureUpdateChain_2 irChain (
    .clock              (clock),
    .reset              (reset),
    .io_chainIn_shift   (_stateMachine_io_currState == 4'hA),
    .io_chainIn_data    (io_jtag_TDI),
    .io_chainIn_capture (_stateMachine_io_currState == 4'hE),
    .io_chainIn_update  (_irChain_io_chainIn_update_T),
    .io_chainOut_data   (_irChain_io_chainOut_data),
    .io_update_bits     (_irChain_io_update_bits)
  );
  assign io_jtag_TDO_data = tdoReg;
  assign io_output_instruction = activeInstruction;
  assign io_output_tapIsInTestLogicReset = &_stateMachine_io_currState;
  assign io_dataChainOut_shift = _io_dataChainOut_shift_T;
  assign io_dataChainOut_data = io_jtag_TDI;
  assign io_dataChainOut_capture = _stateMachine_io_currState == 4'h6;
  assign io_dataChainOut_update = _stateMachine_io_currState == 4'h5;
endmodule

