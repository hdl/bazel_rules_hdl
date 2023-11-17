// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLDebugModuleInnerAsync(
  input  [2:0]  auto_dmiXing_in_a_mem_0_opcode,
                auto_dmiXing_in_a_mem_0_param,
  input  [1:0]  auto_dmiXing_in_a_mem_0_size,
  input         auto_dmiXing_in_a_mem_0_source,
  input  [8:0]  auto_dmiXing_in_a_mem_0_address,
  input  [3:0]  auto_dmiXing_in_a_mem_0_mask,
  input  [31:0] auto_dmiXing_in_a_mem_0_data,
  input         auto_dmiXing_in_a_mem_0_corrupt,
                auto_dmiXing_in_a_widx,
                auto_dmiXing_in_a_safe_widx_valid,
                auto_dmiXing_in_a_safe_source_reset_n,
                auto_dmiXing_in_d_ridx,
                auto_dmiXing_in_d_safe_ridx_valid,
                auto_dmiXing_in_d_safe_sink_reset_n,
                auto_dmInner_tl_in_a_valid,
  input  [2:0]  auto_dmInner_tl_in_a_bits_opcode,
                auto_dmInner_tl_in_a_bits_param,
  input  [1:0]  auto_dmInner_tl_in_a_bits_size,
  input  [10:0] auto_dmInner_tl_in_a_bits_source,
  input  [11:0] auto_dmInner_tl_in_a_bits_address,
  input  [7:0]  auto_dmInner_tl_in_a_bits_mask,
  input  [63:0] auto_dmInner_tl_in_a_bits_data,
  input         auto_dmInner_tl_in_a_bits_corrupt,
                auto_dmInner_tl_in_d_ready,
                io_debug_clock,
                io_debug_reset,
                io_dmactive,
                io_innerCtrl_mem_0_resumereq,
  input  [9:0]  io_innerCtrl_mem_0_hartsel,
  input         io_innerCtrl_mem_0_ackhavereset,
                io_innerCtrl_mem_0_hasel,
                io_innerCtrl_mem_0_hamask_0,
                io_innerCtrl_mem_0_hrmask_0,
                io_innerCtrl_widx,
                io_innerCtrl_safe_widx_valid,
                io_innerCtrl_safe_source_reset_n,
                io_hartIsInReset_0,
  output        auto_dmiXing_in_a_ridx,
                auto_dmiXing_in_a_safe_ridx_valid,
                auto_dmiXing_in_a_safe_sink_reset_n,
  output [2:0]  auto_dmiXing_in_d_mem_0_opcode,
  output [1:0]  auto_dmiXing_in_d_mem_0_param,
                auto_dmiXing_in_d_mem_0_size,
  output        auto_dmiXing_in_d_mem_0_source,
                auto_dmiXing_in_d_mem_0_sink,
                auto_dmiXing_in_d_mem_0_denied,
  output [31:0] auto_dmiXing_in_d_mem_0_data,
  output        auto_dmiXing_in_d_mem_0_corrupt,
                auto_dmiXing_in_d_widx,
                auto_dmiXing_in_d_safe_widx_valid,
                auto_dmiXing_in_d_safe_source_reset_n,
                auto_dmInner_tl_in_a_ready,
                auto_dmInner_tl_in_d_valid,
  output [2:0]  auto_dmInner_tl_in_d_bits_opcode,
  output [1:0]  auto_dmInner_tl_in_d_bits_size,
  output [10:0] auto_dmInner_tl_in_d_bits_source,
  output [63:0] auto_dmInner_tl_in_d_bits_data,
  output        io_innerCtrl_ridx,
                io_innerCtrl_safe_ridx_valid,
                io_innerCtrl_safe_sink_reset_n,
                io_hgDebugInt_0
);

  wire        _dmactive_synced_dmInner_io_innerCtrl_sink_io_deq_valid;
  wire        _dmactive_synced_dmInner_io_innerCtrl_sink_io_deq_bits_resumereq;
  wire [9:0]  _dmactive_synced_dmInner_io_innerCtrl_sink_io_deq_bits_hartsel;
  wire        _dmactive_synced_dmInner_io_innerCtrl_sink_io_deq_bits_ackhavereset;
  wire        _dmactive_synced_dmInner_io_innerCtrl_sink_io_deq_bits_hrmask_0;
  wire        _dmactive_synced_dmactive_synced_dmactiveSync_io_q;
  wire        _dmiXing_auto_out_a_valid;
  wire [2:0]  _dmiXing_auto_out_a_bits_opcode;
  wire [2:0]  _dmiXing_auto_out_a_bits_param;
  wire [1:0]  _dmiXing_auto_out_a_bits_size;
  wire        _dmiXing_auto_out_a_bits_source;
  wire [8:0]  _dmiXing_auto_out_a_bits_address;
  wire [3:0]  _dmiXing_auto_out_a_bits_mask;
  wire [31:0] _dmiXing_auto_out_a_bits_data;
  wire        _dmiXing_auto_out_a_bits_corrupt;
  wire        _dmiXing_auto_out_d_ready;
  wire        _dmInner_auto_dmi_in_a_ready;
  wire        _dmInner_auto_dmi_in_d_valid;
  wire [2:0]  _dmInner_auto_dmi_in_d_bits_opcode;
  wire [1:0]  _dmInner_auto_dmi_in_d_bits_size;
  wire        _dmInner_auto_dmi_in_d_bits_source;
  wire [31:0] _dmInner_auto_dmi_in_d_bits_data;
  TLDebugModuleInner dmInner (
    .clock                          (io_debug_clock),
    .reset                          (io_debug_reset),
    .auto_tl_in_a_valid             (auto_dmInner_tl_in_a_valid),
    .auto_tl_in_a_bits_opcode       (auto_dmInner_tl_in_a_bits_opcode),
    .auto_tl_in_a_bits_param        (auto_dmInner_tl_in_a_bits_param),
    .auto_tl_in_a_bits_size         (auto_dmInner_tl_in_a_bits_size),
    .auto_tl_in_a_bits_source       (auto_dmInner_tl_in_a_bits_source),
    .auto_tl_in_a_bits_address      (auto_dmInner_tl_in_a_bits_address),
    .auto_tl_in_a_bits_mask         (auto_dmInner_tl_in_a_bits_mask),
    .auto_tl_in_a_bits_data         (auto_dmInner_tl_in_a_bits_data),
    .auto_tl_in_a_bits_corrupt      (auto_dmInner_tl_in_a_bits_corrupt),
    .auto_tl_in_d_ready             (auto_dmInner_tl_in_d_ready),
    .auto_dmi_in_a_valid            (_dmiXing_auto_out_a_valid),
    .auto_dmi_in_a_bits_opcode      (_dmiXing_auto_out_a_bits_opcode),
    .auto_dmi_in_a_bits_param       (_dmiXing_auto_out_a_bits_param),
    .auto_dmi_in_a_bits_size        (_dmiXing_auto_out_a_bits_size),
    .auto_dmi_in_a_bits_source      (_dmiXing_auto_out_a_bits_source),
    .auto_dmi_in_a_bits_address     (_dmiXing_auto_out_a_bits_address),
    .auto_dmi_in_a_bits_mask        (_dmiXing_auto_out_a_bits_mask),
    .auto_dmi_in_a_bits_data        (_dmiXing_auto_out_a_bits_data),
    .auto_dmi_in_a_bits_corrupt     (_dmiXing_auto_out_a_bits_corrupt),
    .auto_dmi_in_d_ready            (_dmiXing_auto_out_d_ready),
    .io_dmactive                    (_dmactive_synced_dmactive_synced_dmactiveSync_io_q),
    .io_innerCtrl_valid             (_dmactive_synced_dmInner_io_innerCtrl_sink_io_deq_valid),
    .io_innerCtrl_bits_resumereq    (_dmactive_synced_dmInner_io_innerCtrl_sink_io_deq_bits_resumereq),
    .io_innerCtrl_bits_hartsel      (_dmactive_synced_dmInner_io_innerCtrl_sink_io_deq_bits_hartsel),
    .io_innerCtrl_bits_ackhavereset (_dmactive_synced_dmInner_io_innerCtrl_sink_io_deq_bits_ackhavereset),
    .io_innerCtrl_bits_hrmask_0     (_dmactive_synced_dmInner_io_innerCtrl_sink_io_deq_bits_hrmask_0),
    .io_hartIsInReset_0             (io_hartIsInReset_0),
    .auto_tl_in_a_ready             (auto_dmInner_tl_in_a_ready),
    .auto_tl_in_d_valid             (auto_dmInner_tl_in_d_valid),
    .auto_tl_in_d_bits_opcode       (auto_dmInner_tl_in_d_bits_opcode),
    .auto_tl_in_d_bits_size         (auto_dmInner_tl_in_d_bits_size),
    .auto_tl_in_d_bits_source       (auto_dmInner_tl_in_d_bits_source),
    .auto_tl_in_d_bits_data         (auto_dmInner_tl_in_d_bits_data),
    .auto_dmi_in_a_ready            (_dmInner_auto_dmi_in_a_ready),
    .auto_dmi_in_d_valid            (_dmInner_auto_dmi_in_d_valid),
    .auto_dmi_in_d_bits_opcode      (_dmInner_auto_dmi_in_d_bits_opcode),
    .auto_dmi_in_d_bits_size        (_dmInner_auto_dmi_in_d_bits_size),
    .auto_dmi_in_d_bits_source      (_dmInner_auto_dmi_in_d_bits_source),
    .auto_dmi_in_d_bits_data        (_dmInner_auto_dmi_in_d_bits_data),
    .io_hgDebugInt_0                (io_hgDebugInt_0)
  );
  TLAsyncCrossingSink dmiXing (
    .clock                         (io_debug_clock),
    .reset                         (io_debug_reset),
    .auto_in_a_mem_0_opcode        (auto_dmiXing_in_a_mem_0_opcode),
    .auto_in_a_mem_0_param         (auto_dmiXing_in_a_mem_0_param),
    .auto_in_a_mem_0_size          (auto_dmiXing_in_a_mem_0_size),
    .auto_in_a_mem_0_source        (auto_dmiXing_in_a_mem_0_source),
    .auto_in_a_mem_0_address       (auto_dmiXing_in_a_mem_0_address),
    .auto_in_a_mem_0_mask          (auto_dmiXing_in_a_mem_0_mask),
    .auto_in_a_mem_0_data          (auto_dmiXing_in_a_mem_0_data),
    .auto_in_a_mem_0_corrupt       (auto_dmiXing_in_a_mem_0_corrupt),
    .auto_in_a_widx                (auto_dmiXing_in_a_widx),
    .auto_in_a_safe_widx_valid     (auto_dmiXing_in_a_safe_widx_valid),
    .auto_in_a_safe_source_reset_n (auto_dmiXing_in_a_safe_source_reset_n),
    .auto_in_d_ridx                (auto_dmiXing_in_d_ridx),
    .auto_in_d_safe_ridx_valid     (auto_dmiXing_in_d_safe_ridx_valid),
    .auto_in_d_safe_sink_reset_n   (auto_dmiXing_in_d_safe_sink_reset_n),
    .auto_out_a_ready              (_dmInner_auto_dmi_in_a_ready),
    .auto_out_d_valid              (_dmInner_auto_dmi_in_d_valid),
    .auto_out_d_bits_opcode        (_dmInner_auto_dmi_in_d_bits_opcode),
    .auto_out_d_bits_size          (_dmInner_auto_dmi_in_d_bits_size),
    .auto_out_d_bits_source        (_dmInner_auto_dmi_in_d_bits_source),
    .auto_out_d_bits_data          (_dmInner_auto_dmi_in_d_bits_data),
    .auto_in_a_ridx                (auto_dmiXing_in_a_ridx),
    .auto_in_a_safe_ridx_valid     (auto_dmiXing_in_a_safe_ridx_valid),
    .auto_in_a_safe_sink_reset_n   (auto_dmiXing_in_a_safe_sink_reset_n),
    .auto_in_d_mem_0_opcode        (auto_dmiXing_in_d_mem_0_opcode),
    .auto_in_d_mem_0_param         (auto_dmiXing_in_d_mem_0_param),
    .auto_in_d_mem_0_size          (auto_dmiXing_in_d_mem_0_size),
    .auto_in_d_mem_0_source        (auto_dmiXing_in_d_mem_0_source),
    .auto_in_d_mem_0_sink          (auto_dmiXing_in_d_mem_0_sink),
    .auto_in_d_mem_0_denied        (auto_dmiXing_in_d_mem_0_denied),
    .auto_in_d_mem_0_data          (auto_dmiXing_in_d_mem_0_data),
    .auto_in_d_mem_0_corrupt       (auto_dmiXing_in_d_mem_0_corrupt),
    .auto_in_d_widx                (auto_dmiXing_in_d_widx),
    .auto_in_d_safe_widx_valid     (auto_dmiXing_in_d_safe_widx_valid),
    .auto_in_d_safe_source_reset_n (auto_dmiXing_in_d_safe_source_reset_n),
    .auto_out_a_valid              (_dmiXing_auto_out_a_valid),
    .auto_out_a_bits_opcode        (_dmiXing_auto_out_a_bits_opcode),
    .auto_out_a_bits_param         (_dmiXing_auto_out_a_bits_param),
    .auto_out_a_bits_size          (_dmiXing_auto_out_a_bits_size),
    .auto_out_a_bits_source        (_dmiXing_auto_out_a_bits_source),
    .auto_out_a_bits_address       (_dmiXing_auto_out_a_bits_address),
    .auto_out_a_bits_mask          (_dmiXing_auto_out_a_bits_mask),
    .auto_out_a_bits_data          (_dmiXing_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt       (_dmiXing_auto_out_a_bits_corrupt),
    .auto_out_d_ready              (_dmiXing_auto_out_d_ready)
  );
  AsyncResetSynchronizerShiftReg_w1_d3_i0 dmactive_synced_dmactive_synced_dmactiveSync (
    .clock (io_debug_clock),
    .reset (io_debug_reset),
    .io_d  (io_dmactive),
    .io_q  (_dmactive_synced_dmactive_synced_dmactiveSync_io_q)
  );
  AsyncQueueSink_4 dmactive_synced_dmInner_io_innerCtrl_sink (
    .clock                        (io_debug_clock),
    .reset                        (io_debug_reset),
    .io_async_mem_0_resumereq     (io_innerCtrl_mem_0_resumereq),
    .io_async_mem_0_hartsel       (io_innerCtrl_mem_0_hartsel),
    .io_async_mem_0_ackhavereset  (io_innerCtrl_mem_0_ackhavereset),
    .io_async_mem_0_hasel         (io_innerCtrl_mem_0_hasel),
    .io_async_mem_0_hamask_0      (io_innerCtrl_mem_0_hamask_0),
    .io_async_mem_0_hrmask_0      (io_innerCtrl_mem_0_hrmask_0),
    .io_async_widx                (io_innerCtrl_widx),
    .io_async_safe_widx_valid     (io_innerCtrl_safe_widx_valid),
    .io_async_safe_source_reset_n (io_innerCtrl_safe_source_reset_n),
    .io_deq_valid                 (_dmactive_synced_dmInner_io_innerCtrl_sink_io_deq_valid),
    .io_deq_bits_resumereq        (_dmactive_synced_dmInner_io_innerCtrl_sink_io_deq_bits_resumereq),
    .io_deq_bits_hartsel          (_dmactive_synced_dmInner_io_innerCtrl_sink_io_deq_bits_hartsel),
    .io_deq_bits_ackhavereset     (_dmactive_synced_dmInner_io_innerCtrl_sink_io_deq_bits_ackhavereset),
    .io_deq_bits_hrmask_0         (_dmactive_synced_dmInner_io_innerCtrl_sink_io_deq_bits_hrmask_0),
    .io_async_ridx                (io_innerCtrl_ridx),
    .io_async_safe_ridx_valid     (io_innerCtrl_safe_ridx_valid),
    .io_async_safe_sink_reset_n   (io_innerCtrl_safe_sink_reset_n)
  );
endmodule

