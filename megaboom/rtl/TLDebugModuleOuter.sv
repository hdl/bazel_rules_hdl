// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLDebugModuleOuter(
  input         clock,
                reset,
                auto_dmi_in_a_valid,
  input  [2:0]  auto_dmi_in_a_bits_opcode,
  input  [6:0]  auto_dmi_in_a_bits_address,
  input  [31:0] auto_dmi_in_a_bits_data,
  input         auto_dmi_in_d_ready,
                io_ctrl_dmactiveAck,
                io_innerCtrl_ready,
                io_hgDebugInt_0,
  output        auto_dmi_in_a_ready,
                auto_dmi_in_d_valid,
  output [2:0]  auto_dmi_in_d_bits_opcode,
  output [31:0] auto_dmi_in_d_bits_data,
  output        auto_int_out_0,
                io_ctrl_dmactive,
                io_innerCtrl_valid,
                io_innerCtrl_bits_resumereq,
                io_innerCtrl_bits_ackhavereset,
                io_innerCtrl_bits_hrmask_0
);

  reg        DMCONTROLReg_haltreq;
  reg        DMCONTROLReg_ndmreset;
  reg        DMCONTROLReg_dmactive;
  wire       in_bits_read = auto_dmi_in_a_bits_opcode == 3'h4;
  wire       _out_out_bits_data_T_1 = {auto_dmi_in_a_bits_address[4], auto_dmi_in_a_bits_address[2]} == 2'h0;
  wire       out_woready_1 = auto_dmi_in_a_valid & auto_dmi_in_d_ready & ~in_bits_read & ~(auto_dmi_in_a_bits_address[3]) & _out_out_bits_data_T_1;
  reg        hrmaskReg_0;
  wire       hrmask_0 = ~(~DMCONTROLReg_dmactive | out_woready_1 & auto_dmi_in_a_bits_data[2]) & (out_woready_1 & auto_dmi_in_a_bits_data[3] | hrmaskReg_0);
  reg        debugIntRegs_0;
  reg        innerCtrlValidReg;
  reg        innerCtrlResumeReqReg;
  reg        innerCtrlAckHaveResetReg;
  wire       _io_innerCtrl_valid_output = out_woready_1 | innerCtrlValidReg;
  wire       _io_innerCtrl_bits_resumereq_output = out_woready_1 & auto_dmi_in_a_bits_data[30] | innerCtrlResumeReqReg;
  wire       _io_innerCtrl_bits_ackhavereset_output = out_woready_1 & auto_dmi_in_a_bits_data[28] | innerCtrlAckHaveResetReg;
  wire [2:0] _GEN = {2'h0, in_bits_read};
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      DMCONTROLReg_haltreq <= 1'h0;
      DMCONTROLReg_ndmreset <= 1'h0;
      DMCONTROLReg_dmactive <= 1'h0;
      hrmaskReg_0 <= 1'h0;
      debugIntRegs_0 <= 1'h0;
      innerCtrlValidReg <= 1'h0;
      innerCtrlResumeReqReg <= 1'h0;
      innerCtrlAckHaveResetReg <= 1'h0;
    end
    else begin
      DMCONTROLReg_haltreq <= DMCONTROLReg_dmactive & (out_woready_1 ? auto_dmi_in_a_bits_data[31] : DMCONTROLReg_haltreq);
      DMCONTROLReg_ndmreset <= DMCONTROLReg_dmactive & (out_woready_1 ? auto_dmi_in_a_bits_data[1] : DMCONTROLReg_ndmreset);
      if (out_woready_1)
        DMCONTROLReg_dmactive <= auto_dmi_in_a_bits_data[0];
      hrmaskReg_0 <= hrmask_0;
      debugIntRegs_0 <= DMCONTROLReg_dmactive & (out_woready_1 ? auto_dmi_in_a_bits_data[31] : debugIntRegs_0);
      innerCtrlValidReg <= _io_innerCtrl_valid_output & ~io_innerCtrl_ready;
      innerCtrlResumeReqReg <= _io_innerCtrl_bits_resumereq_output & ~io_innerCtrl_ready;
      innerCtrlAckHaveResetReg <= _io_innerCtrl_bits_ackhavereset_output & ~io_innerCtrl_ready;
    end
  end // always @(posedge, posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      if (reset) begin
        DMCONTROLReg_haltreq = 1'h0;
        DMCONTROLReg_ndmreset = 1'h0;
        DMCONTROLReg_dmactive = 1'h0;
        hrmaskReg_0 = 1'h0;
        debugIntRegs_0 = 1'h0;
        innerCtrlValidReg = 1'h0;
        innerCtrlResumeReqReg = 1'h0;
        innerCtrlAckHaveResetReg = 1'h0;
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign auto_dmi_in_a_ready = auto_dmi_in_d_ready;
  assign auto_dmi_in_d_valid = auto_dmi_in_a_valid;
  assign auto_dmi_in_d_bits_opcode = _GEN;
  assign auto_dmi_in_d_bits_data = _out_out_bits_data_T_1 ? (auto_dmi_in_a_bits_address[3] ? 32'h118380 : {DMCONTROLReg_haltreq, 29'h0, DMCONTROLReg_ndmreset, DMCONTROLReg_dmactive & io_ctrl_dmactiveAck}) : 32'h0;
  assign auto_int_out_0 = debugIntRegs_0 | io_hgDebugInt_0;
  assign io_ctrl_dmactive = DMCONTROLReg_dmactive;
  assign io_innerCtrl_valid = _io_innerCtrl_valid_output;
  assign io_innerCtrl_bits_resumereq = _io_innerCtrl_bits_resumereq_output;
  assign io_innerCtrl_bits_ackhavereset = _io_innerCtrl_bits_ackhavereset_output;
  assign io_innerCtrl_bits_hrmask_0 = hrmask_0;
endmodule

