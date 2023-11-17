// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module DebugTransportModuleJTAG(
  input         io_jtag_clock,
                io_jtag_reset,
                io_dmi_req_ready,
                io_dmi_resp_valid,
  input  [31:0] io_dmi_resp_bits_data,
  input  [1:0]  io_dmi_resp_bits_resp,
  input         io_jtag_TMS,
                io_jtag_TDI,
  output        io_dmi_req_valid,
  output [6:0]  io_dmi_req_bits_addr,
  output [31:0] io_dmi_req_bits_data,
  output [1:0]  io_dmi_req_bits_op,
  output        io_dmi_resp_ready,
                io_jtag_TDO_data
);

  wire        _tapIO_bypassChain_io_chainOut_data;
  wire [4:0]  _tapIO_controllerInternal_io_output_instruction;
  wire        _tapIO_controllerInternal_io_output_tapIsInTestLogicReset;
  wire        _tapIO_controllerInternal_io_dataChainOut_shift;
  wire        _tapIO_controllerInternal_io_dataChainOut_data;
  wire        _tapIO_controllerInternal_io_dataChainOut_capture;
  wire        _tapIO_controllerInternal_io_dataChainOut_update;
  wire        _tapIO_idcodeChain_io_chainOut_data;
  wire        _dmiAccessChain_io_chainOut_data;
  wire        _dmiAccessChain_io_capture_capture;
  wire        _dmiAccessChain_io_update_valid;
  wire [6:0]  _dmiAccessChain_io_update_bits_addr;
  wire [31:0] _dmiAccessChain_io_update_bits_data;
  wire [1:0]  _dmiAccessChain_io_update_bits_op;
  wire        _dtmInfoChain_io_chainOut_data;
  wire        _dtmInfoChain_io_update_valid;
  wire        _dtmInfoChain_io_update_bits_dmireset;
  reg         busyReg;
  reg         stickyBusyReg;
  reg         stickyNonzeroRespReg;
  reg         downgradeOpReg;
  reg  [6:0]  dmiResp_addr;
  reg  [31:0] dmiReqReg_data;
  reg  [1:0]  dmiReqReg_op;
  reg         dmiReqValidReg;
  wire        _busy_T_1 = busyReg & ~io_dmi_resp_valid;
  wire        busy = _busy_T_1 | stickyBusyReg;
  wire        _GEN = busy | ~io_dmi_resp_valid;
  wire        _GEN_0 = io_dmi_req_ready & dmiReqValidReg;
  wire        _GEN_1 = downgradeOpReg | _dmiAccessChain_io_update_bits_op == 2'h0;
  wire        _io_dmi_resp_ready_output = dmiReqReg_op == 2'h2 ? io_dmi_resp_valid : _dmiAccessChain_io_capture_capture & ~busy;
  wire        tapIO_icodeSelects_0 = _tapIO_controllerInternal_io_output_instruction == 5'h1;
  wire        tapIO_icodeSelects_0_1 = _tapIO_controllerInternal_io_output_instruction == 5'h10;
  wire        tapIO_icodeSelects_0_2 = _tapIO_controllerInternal_io_output_instruction == 5'h11;
  wire        _nonzeroResp_T_1 = io_dmi_resp_valid & (|io_dmi_resp_bits_resp);
  wire        _GEN_2 = _tapIO_controllerInternal_io_output_tapIsInTestLogicReset | _dtmInfoChain_io_update_valid & _dtmInfoChain_io_update_bits_dmireset;
  always @(posedge io_jtag_clock or posedge io_jtag_reset) begin
    if (io_jtag_reset) begin
      busyReg <= 1'h0;
      stickyBusyReg <= 1'h0;
      stickyNonzeroRespReg <= 1'h0;
      downgradeOpReg <= 1'h0;
      dmiReqValidReg <= 1'h0;
    end
    else begin
      busyReg <= ~(_tapIO_controllerInternal_io_output_tapIsInTestLogicReset | _io_dmi_resp_ready_output & io_dmi_resp_valid) & (dmiReqValidReg | busyReg);
      stickyBusyReg <= ~_GEN_2 & (_dmiAccessChain_io_capture_capture & _busy_T_1 | stickyBusyReg);
      stickyNonzeroRespReg <= ~_GEN_2 & (_dmiAccessChain_io_capture_capture & _nonzeroResp_T_1 | stickyNonzeroRespReg);
      downgradeOpReg <= ~_tapIO_controllerInternal_io_output_tapIsInTestLogicReset & (_dmiAccessChain_io_capture_capture ? ~busy & (stickyNonzeroRespReg | _nonzeroResp_T_1) : ~_dmiAccessChain_io_update_valid & downgradeOpReg);
      dmiReqValidReg <= ~(_tapIO_controllerInternal_io_output_tapIsInTestLogicReset | _GEN_0) & (_dmiAccessChain_io_update_valid & ~(stickyBusyReg | _GEN_1) | dmiReqValidReg);
    end
  end // always @(posedge, posedge)
  always @(posedge io_jtag_clock) begin
    if (~_dmiAccessChain_io_update_valid | stickyBusyReg) begin
    end
    else if (_GEN_1) begin
      dmiResp_addr <= 7'h0;
      dmiReqReg_data <= 32'h0;
      dmiReqReg_op <= 2'h0;
    end
    else begin
      dmiResp_addr <= _dmiAccessChain_io_update_bits_addr;
      dmiReqReg_data <= _dmiAccessChain_io_update_bits_data;
      dmiReqReg_op <= _dmiAccessChain_io_update_bits_op;
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      if (io_jtag_reset) begin
        busyReg = 1'h0;
        stickyBusyReg = 1'h0;
        stickyNonzeroRespReg = 1'h0;
        downgradeOpReg = 1'h0;
        dmiReqValidReg = 1'h0;
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  CaptureUpdateChain dtmInfoChain (
    .clock                     (io_jtag_clock),
    .reset                     (io_jtag_reset),
    .io_chainIn_shift          (tapIO_icodeSelects_0_1 & _tapIO_controllerInternal_io_dataChainOut_shift),
    .io_chainIn_data           (tapIO_icodeSelects_0_1 & _tapIO_controllerInternal_io_dataChainOut_data),
    .io_chainIn_capture        (tapIO_icodeSelects_0_1 & _tapIO_controllerInternal_io_dataChainOut_capture),
    .io_chainIn_update         (tapIO_icodeSelects_0_1 & _tapIO_controllerInternal_io_dataChainOut_update),
    .io_capture_bits_dmiStatus ({stickyNonzeroRespReg, stickyNonzeroRespReg | stickyBusyReg}),
    .io_chainOut_data          (_dtmInfoChain_io_chainOut_data),
    .io_update_valid           (_dtmInfoChain_io_update_valid),
    .io_update_bits_dmireset   (_dtmInfoChain_io_update_bits_dmireset)
  );
  CaptureUpdateChain_1 dmiAccessChain (
    .clock                (io_jtag_clock),
    .reset                (io_jtag_reset),
    .io_chainIn_shift     (tapIO_icodeSelects_0_2 & _tapIO_controllerInternal_io_dataChainOut_shift),
    .io_chainIn_data      (tapIO_icodeSelects_0_2 & _tapIO_controllerInternal_io_dataChainOut_data),
    .io_chainIn_capture   (tapIO_icodeSelects_0_2 & _tapIO_controllerInternal_io_dataChainOut_capture),
    .io_chainIn_update    (tapIO_icodeSelects_0_2 & _tapIO_controllerInternal_io_dataChainOut_update),
    .io_capture_bits_addr (_GEN ? 7'h0 : dmiResp_addr),
    .io_capture_bits_data (_GEN ? 32'h0 : io_dmi_resp_bits_data),
    .io_capture_bits_resp (busy ? 2'h3 : io_dmi_resp_valid ? io_dmi_resp_bits_resp : 2'h0),
    .io_chainOut_data     (_dmiAccessChain_io_chainOut_data),
    .io_capture_capture   (_dmiAccessChain_io_capture_capture),
    .io_update_valid      (_dmiAccessChain_io_update_valid),
    .io_update_bits_addr  (_dmiAccessChain_io_update_bits_addr),
    .io_update_bits_data  (_dmiAccessChain_io_update_bits_data),
    .io_update_bits_op    (_dmiAccessChain_io_update_bits_op)
  );
  CaptureChain tapIO_idcodeChain (
    .clock              (io_jtag_clock),
    .reset              (io_jtag_reset),
    .io_chainIn_shift   (tapIO_icodeSelects_0 & _tapIO_controllerInternal_io_dataChainOut_shift),
    .io_chainIn_data    (tapIO_icodeSelects_0 & _tapIO_controllerInternal_io_dataChainOut_data),
    .io_chainIn_capture (tapIO_icodeSelects_0 & _tapIO_controllerInternal_io_dataChainOut_capture),
    .io_chainIn_update  (tapIO_icodeSelects_0 & _tapIO_controllerInternal_io_dataChainOut_update),
    .io_chainOut_data   (_tapIO_idcodeChain_io_chainOut_data)
  );
  JtagTapController tapIO_controllerInternal (
    .clock                           (io_jtag_clock),
    .reset                           (io_jtag_reset),
    .io_jtag_TMS                     (io_jtag_TMS),
    .io_jtag_TDI                     (io_jtag_TDI),
    .io_control_jtag_reset           (io_jtag_reset),
    .io_dataChainIn_data             (tapIO_icodeSelects_0 ? _tapIO_idcodeChain_io_chainOut_data : tapIO_icodeSelects_0_1 ? _dtmInfoChain_io_chainOut_data : tapIO_icodeSelects_0_2 ? _dmiAccessChain_io_chainOut_data : _tapIO_bypassChain_io_chainOut_data),
    .io_jtag_TDO_data                (io_jtag_TDO_data),
    .io_output_instruction           (_tapIO_controllerInternal_io_output_instruction),
    .io_output_tapIsInTestLogicReset (_tapIO_controllerInternal_io_output_tapIsInTestLogicReset),
    .io_dataChainOut_shift           (_tapIO_controllerInternal_io_dataChainOut_shift),
    .io_dataChainOut_data            (_tapIO_controllerInternal_io_dataChainOut_data),
    .io_dataChainOut_capture         (_tapIO_controllerInternal_io_dataChainOut_capture),
    .io_dataChainOut_update          (_tapIO_controllerInternal_io_dataChainOut_update)
  );
  JtagBypassChain tapIO_bypassChain (
    .clock              (io_jtag_clock),
    .reset              (io_jtag_reset),
    .io_chainIn_shift   (_tapIO_controllerInternal_io_dataChainOut_shift),
    .io_chainIn_data    (_tapIO_controllerInternal_io_dataChainOut_data),
    .io_chainIn_capture (_tapIO_controllerInternal_io_dataChainOut_capture),
    .io_chainIn_update  (_tapIO_controllerInternal_io_dataChainOut_update),
    .io_chainOut_data   (_tapIO_bypassChain_io_chainOut_data)
  );
  assign io_dmi_req_valid = dmiReqValidReg;
  assign io_dmi_req_bits_addr = dmiResp_addr;
  assign io_dmi_req_bits_data = dmiReqReg_data;
  assign io_dmi_req_bits_op = dmiReqReg_op;
  assign io_dmi_resp_ready = _io_dmi_resp_ready_output;
endmodule

