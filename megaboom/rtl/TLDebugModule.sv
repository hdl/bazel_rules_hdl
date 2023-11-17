// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLDebugModule(
  input         auto_dmInner_dmInner_tl_in_a_valid,
  input  [2:0]  auto_dmInner_dmInner_tl_in_a_bits_opcode,
                auto_dmInner_dmInner_tl_in_a_bits_param,
  input  [1:0]  auto_dmInner_dmInner_tl_in_a_bits_size,
  input  [10:0] auto_dmInner_dmInner_tl_in_a_bits_source,
  input  [11:0] auto_dmInner_dmInner_tl_in_a_bits_address,
  input  [7:0]  auto_dmInner_dmInner_tl_in_a_bits_mask,
  input  [63:0] auto_dmInner_dmInner_tl_in_a_bits_data,
  input         auto_dmInner_dmInner_tl_in_a_bits_corrupt,
                auto_dmInner_dmInner_tl_in_d_ready,
                io_debug_clock,
                io_debug_reset,
                io_ctrl_dmactiveAck,
                io_dmi_dmi_req_valid,
  input  [6:0]  io_dmi_dmi_req_bits_addr,
  input  [31:0] io_dmi_dmi_req_bits_data,
  input  [1:0]  io_dmi_dmi_req_bits_op,
  input         io_dmi_dmi_resp_ready,
                io_dmi_dmiClock,
                io_dmi_dmiReset,
                io_hartIsInReset_0,
  output        auto_dmInner_dmInner_tl_in_a_ready,
                auto_dmInner_dmInner_tl_in_d_valid,
  output [2:0]  auto_dmInner_dmInner_tl_in_d_bits_opcode,
  output [1:0]  auto_dmInner_dmInner_tl_in_d_bits_size,
  output [10:0] auto_dmInner_dmInner_tl_in_d_bits_source,
  output [63:0] auto_dmInner_dmInner_tl_in_d_bits_data,
  output        auto_dmOuter_intsource_out_sync_0,
                io_ctrl_dmactive,
                io_dmi_dmi_req_ready,
                io_dmi_dmi_resp_valid,
  output [31:0] io_dmi_dmi_resp_bits_data,
  output [1:0]  io_dmi_dmi_resp_bits_resp
);

  wire        _dmInner_auto_dmiXing_in_a_ridx;
  wire        _dmInner_auto_dmiXing_in_a_safe_ridx_valid;
  wire        _dmInner_auto_dmiXing_in_a_safe_sink_reset_n;
  wire [2:0]  _dmInner_auto_dmiXing_in_d_mem_0_opcode;
  wire [1:0]  _dmInner_auto_dmiXing_in_d_mem_0_param;
  wire [1:0]  _dmInner_auto_dmiXing_in_d_mem_0_size;
  wire        _dmInner_auto_dmiXing_in_d_mem_0_source;
  wire        _dmInner_auto_dmiXing_in_d_mem_0_sink;
  wire        _dmInner_auto_dmiXing_in_d_mem_0_denied;
  wire [31:0] _dmInner_auto_dmiXing_in_d_mem_0_data;
  wire        _dmInner_auto_dmiXing_in_d_mem_0_corrupt;
  wire        _dmInner_auto_dmiXing_in_d_widx;
  wire        _dmInner_auto_dmiXing_in_d_safe_widx_valid;
  wire        _dmInner_auto_dmiXing_in_d_safe_source_reset_n;
  wire        _dmInner_io_innerCtrl_ridx;
  wire        _dmInner_io_innerCtrl_safe_ridx_valid;
  wire        _dmInner_io_innerCtrl_safe_sink_reset_n;
  wire        _dmInner_io_hgDebugInt_0;
  wire [2:0]  _dmOuter_auto_asource_out_a_mem_0_opcode;
  wire [2:0]  _dmOuter_auto_asource_out_a_mem_0_param;
  wire [1:0]  _dmOuter_auto_asource_out_a_mem_0_size;
  wire        _dmOuter_auto_asource_out_a_mem_0_source;
  wire [8:0]  _dmOuter_auto_asource_out_a_mem_0_address;
  wire [3:0]  _dmOuter_auto_asource_out_a_mem_0_mask;
  wire [31:0] _dmOuter_auto_asource_out_a_mem_0_data;
  wire        _dmOuter_auto_asource_out_a_mem_0_corrupt;
  wire        _dmOuter_auto_asource_out_a_widx;
  wire        _dmOuter_auto_asource_out_a_safe_widx_valid;
  wire        _dmOuter_auto_asource_out_a_safe_source_reset_n;
  wire        _dmOuter_auto_asource_out_d_ridx;
  wire        _dmOuter_auto_asource_out_d_safe_ridx_valid;
  wire        _dmOuter_auto_asource_out_d_safe_sink_reset_n;
  wire        _dmOuter_io_ctrl_dmactive;
  wire        _dmOuter_io_innerCtrl_mem_0_resumereq;
  wire [9:0]  _dmOuter_io_innerCtrl_mem_0_hartsel;
  wire        _dmOuter_io_innerCtrl_mem_0_ackhavereset;
  wire        _dmOuter_io_innerCtrl_mem_0_hasel;
  wire        _dmOuter_io_innerCtrl_mem_0_hamask_0;
  wire        _dmOuter_io_innerCtrl_mem_0_hrmask_0;
  wire        _dmOuter_io_innerCtrl_widx;
  wire        _dmOuter_io_innerCtrl_safe_widx_valid;
  wire        _dmOuter_io_innerCtrl_safe_source_reset_n;
  TLDebugModuleOuterAsync dmOuter (
    .auto_asource_out_a_ridx                (_dmInner_auto_dmiXing_in_a_ridx),
    .auto_asource_out_a_safe_ridx_valid     (_dmInner_auto_dmiXing_in_a_safe_ridx_valid),
    .auto_asource_out_a_safe_sink_reset_n   (_dmInner_auto_dmiXing_in_a_safe_sink_reset_n),
    .auto_asource_out_d_mem_0_opcode        (_dmInner_auto_dmiXing_in_d_mem_0_opcode),
    .auto_asource_out_d_mem_0_param         (_dmInner_auto_dmiXing_in_d_mem_0_param),
    .auto_asource_out_d_mem_0_size          (_dmInner_auto_dmiXing_in_d_mem_0_size),
    .auto_asource_out_d_mem_0_source        (_dmInner_auto_dmiXing_in_d_mem_0_source),
    .auto_asource_out_d_mem_0_sink          (_dmInner_auto_dmiXing_in_d_mem_0_sink),
    .auto_asource_out_d_mem_0_denied        (_dmInner_auto_dmiXing_in_d_mem_0_denied),
    .auto_asource_out_d_mem_0_data          (_dmInner_auto_dmiXing_in_d_mem_0_data),
    .auto_asource_out_d_mem_0_corrupt       (_dmInner_auto_dmiXing_in_d_mem_0_corrupt),
    .auto_asource_out_d_widx                (_dmInner_auto_dmiXing_in_d_widx),
    .auto_asource_out_d_safe_widx_valid     (_dmInner_auto_dmiXing_in_d_safe_widx_valid),
    .auto_asource_out_d_safe_source_reset_n (_dmInner_auto_dmiXing_in_d_safe_source_reset_n),
    .io_dmi_clock                           (io_dmi_dmiClock),
    .io_dmi_reset                           (io_dmi_dmiReset),
    .io_dmi_req_valid                       (io_dmi_dmi_req_valid),
    .io_dmi_req_bits_addr                   (io_dmi_dmi_req_bits_addr),
    .io_dmi_req_bits_data                   (io_dmi_dmi_req_bits_data),
    .io_dmi_req_bits_op                     (io_dmi_dmi_req_bits_op),
    .io_dmi_resp_ready                      (io_dmi_dmi_resp_ready),
    .io_ctrl_dmactiveAck                    (io_ctrl_dmactiveAck),
    .io_innerCtrl_ridx                      (_dmInner_io_innerCtrl_ridx),
    .io_innerCtrl_safe_ridx_valid           (_dmInner_io_innerCtrl_safe_ridx_valid),
    .io_innerCtrl_safe_sink_reset_n         (_dmInner_io_innerCtrl_safe_sink_reset_n),
    .io_hgDebugInt_0                        (_dmInner_io_hgDebugInt_0),
    .auto_asource_out_a_mem_0_opcode        (_dmOuter_auto_asource_out_a_mem_0_opcode),
    .auto_asource_out_a_mem_0_param         (_dmOuter_auto_asource_out_a_mem_0_param),
    .auto_asource_out_a_mem_0_size          (_dmOuter_auto_asource_out_a_mem_0_size),
    .auto_asource_out_a_mem_0_source        (_dmOuter_auto_asource_out_a_mem_0_source),
    .auto_asource_out_a_mem_0_address       (_dmOuter_auto_asource_out_a_mem_0_address),
    .auto_asource_out_a_mem_0_mask          (_dmOuter_auto_asource_out_a_mem_0_mask),
    .auto_asource_out_a_mem_0_data          (_dmOuter_auto_asource_out_a_mem_0_data),
    .auto_asource_out_a_mem_0_corrupt       (_dmOuter_auto_asource_out_a_mem_0_corrupt),
    .auto_asource_out_a_widx                (_dmOuter_auto_asource_out_a_widx),
    .auto_asource_out_a_safe_widx_valid     (_dmOuter_auto_asource_out_a_safe_widx_valid),
    .auto_asource_out_a_safe_source_reset_n (_dmOuter_auto_asource_out_a_safe_source_reset_n),
    .auto_asource_out_d_ridx                (_dmOuter_auto_asource_out_d_ridx),
    .auto_asource_out_d_safe_ridx_valid     (_dmOuter_auto_asource_out_d_safe_ridx_valid),
    .auto_asource_out_d_safe_sink_reset_n   (_dmOuter_auto_asource_out_d_safe_sink_reset_n),
    .auto_intsource_out_sync_0              (auto_dmOuter_intsource_out_sync_0),
    .io_dmi_req_ready                       (io_dmi_dmi_req_ready),
    .io_dmi_resp_valid                      (io_dmi_dmi_resp_valid),
    .io_dmi_resp_bits_data                  (io_dmi_dmi_resp_bits_data),
    .io_dmi_resp_bits_resp                  (io_dmi_dmi_resp_bits_resp),
    .io_ctrl_dmactive                       (_dmOuter_io_ctrl_dmactive),
    .io_innerCtrl_mem_0_resumereq           (_dmOuter_io_innerCtrl_mem_0_resumereq),
    .io_innerCtrl_mem_0_hartsel             (_dmOuter_io_innerCtrl_mem_0_hartsel),
    .io_innerCtrl_mem_0_ackhavereset        (_dmOuter_io_innerCtrl_mem_0_ackhavereset),
    .io_innerCtrl_mem_0_hasel               (_dmOuter_io_innerCtrl_mem_0_hasel),
    .io_innerCtrl_mem_0_hamask_0            (_dmOuter_io_innerCtrl_mem_0_hamask_0),
    .io_innerCtrl_mem_0_hrmask_0            (_dmOuter_io_innerCtrl_mem_0_hrmask_0),
    .io_innerCtrl_widx                      (_dmOuter_io_innerCtrl_widx),
    .io_innerCtrl_safe_widx_valid           (_dmOuter_io_innerCtrl_safe_widx_valid),
    .io_innerCtrl_safe_source_reset_n       (_dmOuter_io_innerCtrl_safe_source_reset_n)
  );
  TLDebugModuleInnerAsync dmInner (
    .auto_dmiXing_in_a_mem_0_opcode        (_dmOuter_auto_asource_out_a_mem_0_opcode),
    .auto_dmiXing_in_a_mem_0_param         (_dmOuter_auto_asource_out_a_mem_0_param),
    .auto_dmiXing_in_a_mem_0_size          (_dmOuter_auto_asource_out_a_mem_0_size),
    .auto_dmiXing_in_a_mem_0_source        (_dmOuter_auto_asource_out_a_mem_0_source),
    .auto_dmiXing_in_a_mem_0_address       (_dmOuter_auto_asource_out_a_mem_0_address),
    .auto_dmiXing_in_a_mem_0_mask          (_dmOuter_auto_asource_out_a_mem_0_mask),
    .auto_dmiXing_in_a_mem_0_data          (_dmOuter_auto_asource_out_a_mem_0_data),
    .auto_dmiXing_in_a_mem_0_corrupt       (_dmOuter_auto_asource_out_a_mem_0_corrupt),
    .auto_dmiXing_in_a_widx                (_dmOuter_auto_asource_out_a_widx),
    .auto_dmiXing_in_a_safe_widx_valid     (_dmOuter_auto_asource_out_a_safe_widx_valid),
    .auto_dmiXing_in_a_safe_source_reset_n (_dmOuter_auto_asource_out_a_safe_source_reset_n),
    .auto_dmiXing_in_d_ridx                (_dmOuter_auto_asource_out_d_ridx),
    .auto_dmiXing_in_d_safe_ridx_valid     (_dmOuter_auto_asource_out_d_safe_ridx_valid),
    .auto_dmiXing_in_d_safe_sink_reset_n   (_dmOuter_auto_asource_out_d_safe_sink_reset_n),
    .auto_dmInner_tl_in_a_valid            (auto_dmInner_dmInner_tl_in_a_valid),
    .auto_dmInner_tl_in_a_bits_opcode      (auto_dmInner_dmInner_tl_in_a_bits_opcode),
    .auto_dmInner_tl_in_a_bits_param       (auto_dmInner_dmInner_tl_in_a_bits_param),
    .auto_dmInner_tl_in_a_bits_size        (auto_dmInner_dmInner_tl_in_a_bits_size),
    .auto_dmInner_tl_in_a_bits_source      (auto_dmInner_dmInner_tl_in_a_bits_source),
    .auto_dmInner_tl_in_a_bits_address     (auto_dmInner_dmInner_tl_in_a_bits_address),
    .auto_dmInner_tl_in_a_bits_mask        (auto_dmInner_dmInner_tl_in_a_bits_mask),
    .auto_dmInner_tl_in_a_bits_data        (auto_dmInner_dmInner_tl_in_a_bits_data),
    .auto_dmInner_tl_in_a_bits_corrupt     (auto_dmInner_dmInner_tl_in_a_bits_corrupt),
    .auto_dmInner_tl_in_d_ready            (auto_dmInner_dmInner_tl_in_d_ready),
    .io_debug_clock                        (io_debug_clock),
    .io_debug_reset                        (io_debug_reset),
    .io_dmactive                           (_dmOuter_io_ctrl_dmactive),
    .io_innerCtrl_mem_0_resumereq          (_dmOuter_io_innerCtrl_mem_0_resumereq),
    .io_innerCtrl_mem_0_hartsel            (_dmOuter_io_innerCtrl_mem_0_hartsel),
    .io_innerCtrl_mem_0_ackhavereset       (_dmOuter_io_innerCtrl_mem_0_ackhavereset),
    .io_innerCtrl_mem_0_hasel              (_dmOuter_io_innerCtrl_mem_0_hasel),
    .io_innerCtrl_mem_0_hamask_0           (_dmOuter_io_innerCtrl_mem_0_hamask_0),
    .io_innerCtrl_mem_0_hrmask_0           (_dmOuter_io_innerCtrl_mem_0_hrmask_0),
    .io_innerCtrl_widx                     (_dmOuter_io_innerCtrl_widx),
    .io_innerCtrl_safe_widx_valid          (_dmOuter_io_innerCtrl_safe_widx_valid),
    .io_innerCtrl_safe_source_reset_n      (_dmOuter_io_innerCtrl_safe_source_reset_n),
    .io_hartIsInReset_0                    (io_hartIsInReset_0),
    .auto_dmiXing_in_a_ridx                (_dmInner_auto_dmiXing_in_a_ridx),
    .auto_dmiXing_in_a_safe_ridx_valid     (_dmInner_auto_dmiXing_in_a_safe_ridx_valid),
    .auto_dmiXing_in_a_safe_sink_reset_n   (_dmInner_auto_dmiXing_in_a_safe_sink_reset_n),
    .auto_dmiXing_in_d_mem_0_opcode        (_dmInner_auto_dmiXing_in_d_mem_0_opcode),
    .auto_dmiXing_in_d_mem_0_param         (_dmInner_auto_dmiXing_in_d_mem_0_param),
    .auto_dmiXing_in_d_mem_0_size          (_dmInner_auto_dmiXing_in_d_mem_0_size),
    .auto_dmiXing_in_d_mem_0_source        (_dmInner_auto_dmiXing_in_d_mem_0_source),
    .auto_dmiXing_in_d_mem_0_sink          (_dmInner_auto_dmiXing_in_d_mem_0_sink),
    .auto_dmiXing_in_d_mem_0_denied        (_dmInner_auto_dmiXing_in_d_mem_0_denied),
    .auto_dmiXing_in_d_mem_0_data          (_dmInner_auto_dmiXing_in_d_mem_0_data),
    .auto_dmiXing_in_d_mem_0_corrupt       (_dmInner_auto_dmiXing_in_d_mem_0_corrupt),
    .auto_dmiXing_in_d_widx                (_dmInner_auto_dmiXing_in_d_widx),
    .auto_dmiXing_in_d_safe_widx_valid     (_dmInner_auto_dmiXing_in_d_safe_widx_valid),
    .auto_dmiXing_in_d_safe_source_reset_n (_dmInner_auto_dmiXing_in_d_safe_source_reset_n),
    .auto_dmInner_tl_in_a_ready            (auto_dmInner_dmInner_tl_in_a_ready),
    .auto_dmInner_tl_in_d_valid            (auto_dmInner_dmInner_tl_in_d_valid),
    .auto_dmInner_tl_in_d_bits_opcode      (auto_dmInner_dmInner_tl_in_d_bits_opcode),
    .auto_dmInner_tl_in_d_bits_size        (auto_dmInner_dmInner_tl_in_d_bits_size),
    .auto_dmInner_tl_in_d_bits_source      (auto_dmInner_dmInner_tl_in_d_bits_source),
    .auto_dmInner_tl_in_d_bits_data        (auto_dmInner_dmInner_tl_in_d_bits_data),
    .io_innerCtrl_ridx                     (_dmInner_io_innerCtrl_ridx),
    .io_innerCtrl_safe_ridx_valid          (_dmInner_io_innerCtrl_safe_ridx_valid),
    .io_innerCtrl_safe_sink_reset_n        (_dmInner_io_innerCtrl_safe_sink_reset_n),
    .io_hgDebugInt_0                       (_dmInner_io_hgDebugInt_0)
  );
  assign io_ctrl_dmactive = _dmOuter_io_ctrl_dmactive;
endmodule

