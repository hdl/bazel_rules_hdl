// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module InclusiveCache(
  input          clock,
                 reset,
                 auto_ctrls_ctrl_in_a_valid,
  input  [2:0]   auto_ctrls_ctrl_in_a_bits_opcode,
                 auto_ctrls_ctrl_in_a_bits_param,
  input  [1:0]   auto_ctrls_ctrl_in_a_bits_size,
  input  [10:0]  auto_ctrls_ctrl_in_a_bits_source,
  input  [25:0]  auto_ctrls_ctrl_in_a_bits_address,
  input  [7:0]   auto_ctrls_ctrl_in_a_bits_mask,
  input  [63:0]  auto_ctrls_ctrl_in_a_bits_data,
  input          auto_ctrls_ctrl_in_a_bits_corrupt,
                 auto_ctrls_ctrl_in_d_ready,
                 auto_in_a_valid,
  input  [2:0]   auto_in_a_bits_opcode,
                 auto_in_a_bits_param,
                 auto_in_a_bits_size,
  input  [5:0]   auto_in_a_bits_source,
  input  [31:0]  auto_in_a_bits_address,
  input  [15:0]  auto_in_a_bits_mask,
  input  [127:0] auto_in_a_bits_data,
  input          auto_in_a_bits_corrupt,
                 auto_in_b_ready,
                 auto_in_c_valid,
  input  [2:0]   auto_in_c_bits_opcode,
                 auto_in_c_bits_param,
                 auto_in_c_bits_size,
  input  [5:0]   auto_in_c_bits_source,
  input  [31:0]  auto_in_c_bits_address,
  input  [127:0] auto_in_c_bits_data,
  input          auto_in_c_bits_corrupt,
                 auto_in_d_ready,
                 auto_in_e_valid,
  input  [3:0]   auto_in_e_bits_sink,
  input          auto_out_a_ready,
                 auto_out_c_ready,
                 auto_out_d_valid,
  input  [2:0]   auto_out_d_bits_opcode,
  input  [1:0]   auto_out_d_bits_param,
  input  [2:0]   auto_out_d_bits_size,
  input  [3:0]   auto_out_d_bits_source,
  input  [2:0]   auto_out_d_bits_sink,
  input          auto_out_d_bits_denied,
  input  [63:0]  auto_out_d_bits_data,
  input          auto_out_d_bits_corrupt,
  output         auto_ctrls_ctrl_in_a_ready,
                 auto_ctrls_ctrl_in_d_valid,
  output [2:0]   auto_ctrls_ctrl_in_d_bits_opcode,
  output [1:0]   auto_ctrls_ctrl_in_d_bits_size,
  output [10:0]  auto_ctrls_ctrl_in_d_bits_source,
  output [63:0]  auto_ctrls_ctrl_in_d_bits_data,
  output         auto_in_a_ready,
                 auto_in_b_valid,
  output [1:0]   auto_in_b_bits_param,
  output [31:0]  auto_in_b_bits_address,
  output         auto_in_c_ready,
                 auto_in_d_valid,
  output [2:0]   auto_in_d_bits_opcode,
  output [1:0]   auto_in_d_bits_param,
  output [2:0]   auto_in_d_bits_size,
  output [5:0]   auto_in_d_bits_source,
  output [3:0]   auto_in_d_bits_sink,
  output         auto_in_d_bits_denied,
  output [127:0] auto_in_d_bits_data,
  output         auto_in_d_bits_corrupt,
                 auto_out_a_valid,
  output [2:0]   auto_out_a_bits_opcode,
                 auto_out_a_bits_param,
                 auto_out_a_bits_size,
  output [3:0]   auto_out_a_bits_source,
  output [31:0]  auto_out_a_bits_address,
  output [7:0]   auto_out_a_bits_mask,
  output [63:0]  auto_out_a_bits_data,
  output         auto_out_a_bits_corrupt,
                 auto_out_c_valid,
  output [2:0]   auto_out_c_bits_opcode,
                 auto_out_c_bits_param,
                 auto_out_c_bits_size,
  output [3:0]   auto_out_c_bits_source,
  output [31:0]  auto_out_c_bits_address,
  output [63:0]  auto_out_c_bits_data,
  output         auto_out_c_bits_corrupt,
                 auto_out_d_ready,
                 auto_out_e_valid,
  output [2:0]   auto_out_e_bits_sink
);

  wire        _inclusive_cache_bank_sched_io_in_a_ready;
  wire        _inclusive_cache_bank_sched_io_in_b_valid;
  wire [1:0]  _inclusive_cache_bank_sched_io_in_b_bits_param;
  wire [31:0] _inclusive_cache_bank_sched_io_in_b_bits_address;
  wire        _inclusive_cache_bank_sched_io_in_c_ready;
  wire        _inclusive_cache_bank_sched_io_in_d_valid;
  wire [2:0]  _inclusive_cache_bank_sched_io_in_d_bits_opcode;
  wire [1:0]  _inclusive_cache_bank_sched_io_in_d_bits_param;
  wire [2:0]  _inclusive_cache_bank_sched_io_in_d_bits_size;
  wire [5:0]  _inclusive_cache_bank_sched_io_in_d_bits_source;
  wire [3:0]  _inclusive_cache_bank_sched_io_in_d_bits_sink;
  wire        _inclusive_cache_bank_sched_io_in_d_bits_denied;
  wire        _inclusive_cache_bank_sched_io_in_d_bits_corrupt;
  wire [31:0] _inclusive_cache_bank_sched_io_out_a_bits_address;
  wire [31:0] _inclusive_cache_bank_sched_io_out_c_bits_address;
  wire        _inclusive_cache_bank_sched_io_req_ready;
  wire        _inclusive_cache_bank_sched_io_resp_valid;
  wire        _ctrls_io_flush_req_valid;
  wire [63:0] _ctrls_io_flush_req_bits;
  wire [31:0] nodeIn_b_bits_address = _inclusive_cache_bank_sched_io_in_b_bits_address | 32'h80000000;
  wire        contained = {_ctrls_io_flush_req_bits[63:32], _ctrls_io_flush_req_bits[31:28] ^ 4'h8} == 36'h0;
  InclusiveCacheControl ctrls (
    .clock                       (clock),
    .reset                       (reset),
    .auto_ctrl_in_a_valid        (auto_ctrls_ctrl_in_a_valid),
    .auto_ctrl_in_a_bits_opcode  (auto_ctrls_ctrl_in_a_bits_opcode),
    .auto_ctrl_in_a_bits_param   (auto_ctrls_ctrl_in_a_bits_param),
    .auto_ctrl_in_a_bits_size    (auto_ctrls_ctrl_in_a_bits_size),
    .auto_ctrl_in_a_bits_source  (auto_ctrls_ctrl_in_a_bits_source),
    .auto_ctrl_in_a_bits_address (auto_ctrls_ctrl_in_a_bits_address),
    .auto_ctrl_in_a_bits_mask    (auto_ctrls_ctrl_in_a_bits_mask),
    .auto_ctrl_in_a_bits_data    (auto_ctrls_ctrl_in_a_bits_data),
    .auto_ctrl_in_a_bits_corrupt (auto_ctrls_ctrl_in_a_bits_corrupt),
    .auto_ctrl_in_d_ready        (auto_ctrls_ctrl_in_d_ready),
    .io_flush_match              (contained),
    .io_flush_req_ready          (contained & _inclusive_cache_bank_sched_io_req_ready),
    .io_flush_resp               (_inclusive_cache_bank_sched_io_resp_valid),
    .auto_ctrl_in_a_ready        (auto_ctrls_ctrl_in_a_ready),
    .auto_ctrl_in_d_valid        (auto_ctrls_ctrl_in_d_valid),
    .auto_ctrl_in_d_bits_opcode  (auto_ctrls_ctrl_in_d_bits_opcode),
    .auto_ctrl_in_d_bits_size    (auto_ctrls_ctrl_in_d_bits_size),
    .auto_ctrl_in_d_bits_source  (auto_ctrls_ctrl_in_d_bits_source),
    .auto_ctrl_in_d_bits_data    (auto_ctrls_ctrl_in_d_bits_data),
    .io_flush_req_valid          (_ctrls_io_flush_req_valid),
    .io_flush_req_bits           (_ctrls_io_flush_req_bits)
  );
  InclusiveCacheBankScheduler inclusive_cache_bank_sched (
    .clock                 (clock),
    .reset                 (reset),
    .io_in_a_valid         (auto_in_a_valid),
    .io_in_a_bits_opcode   (auto_in_a_bits_opcode),
    .io_in_a_bits_param    (auto_in_a_bits_param),
    .io_in_a_bits_size     (auto_in_a_bits_size),
    .io_in_a_bits_source   (auto_in_a_bits_source),
    .io_in_a_bits_address  (auto_in_a_bits_address),
    .io_in_a_bits_mask     (auto_in_a_bits_mask),
    .io_in_a_bits_data     (auto_in_a_bits_data),
    .io_in_a_bits_corrupt  (auto_in_a_bits_corrupt),
    .io_in_b_ready         (auto_in_b_ready),
    .io_in_c_valid         (auto_in_c_valid),
    .io_in_c_bits_opcode   (auto_in_c_bits_opcode),
    .io_in_c_bits_param    (auto_in_c_bits_param),
    .io_in_c_bits_size     (auto_in_c_bits_size),
    .io_in_c_bits_source   (auto_in_c_bits_source),
    .io_in_c_bits_address  (auto_in_c_bits_address),
    .io_in_c_bits_data     (auto_in_c_bits_data),
    .io_in_c_bits_corrupt  (auto_in_c_bits_corrupt),
    .io_in_d_ready         (auto_in_d_ready),
    .io_in_e_valid         (auto_in_e_valid),
    .io_in_e_bits_sink     (auto_in_e_bits_sink),
    .io_out_a_ready        (auto_out_a_ready),
    .io_out_c_ready        (auto_out_c_ready),
    .io_out_d_valid        (auto_out_d_valid),
    .io_out_d_bits_opcode  (auto_out_d_bits_opcode),
    .io_out_d_bits_param   (auto_out_d_bits_param),
    .io_out_d_bits_size    (auto_out_d_bits_size),
    .io_out_d_bits_source  (auto_out_d_bits_source),
    .io_out_d_bits_sink    (auto_out_d_bits_sink),
    .io_out_d_bits_denied  (auto_out_d_bits_denied),
    .io_out_d_bits_data    (auto_out_d_bits_data),
    .io_out_d_bits_corrupt (auto_out_d_bits_corrupt),
    .io_req_valid          (contained & _ctrls_io_flush_req_valid),
    .io_req_bits_address   (_ctrls_io_flush_req_bits[31:0]),
    .io_in_a_ready         (_inclusive_cache_bank_sched_io_in_a_ready),
    .io_in_b_valid         (_inclusive_cache_bank_sched_io_in_b_valid),
    .io_in_b_bits_param    (_inclusive_cache_bank_sched_io_in_b_bits_param),
    .io_in_b_bits_address  (_inclusive_cache_bank_sched_io_in_b_bits_address),
    .io_in_c_ready         (_inclusive_cache_bank_sched_io_in_c_ready),
    .io_in_d_valid         (_inclusive_cache_bank_sched_io_in_d_valid),
    .io_in_d_bits_opcode   (_inclusive_cache_bank_sched_io_in_d_bits_opcode),
    .io_in_d_bits_param    (_inclusive_cache_bank_sched_io_in_d_bits_param),
    .io_in_d_bits_size     (_inclusive_cache_bank_sched_io_in_d_bits_size),
    .io_in_d_bits_source   (_inclusive_cache_bank_sched_io_in_d_bits_source),
    .io_in_d_bits_sink     (_inclusive_cache_bank_sched_io_in_d_bits_sink),
    .io_in_d_bits_denied   (_inclusive_cache_bank_sched_io_in_d_bits_denied),
    .io_in_d_bits_data     (auto_in_d_bits_data),
    .io_in_d_bits_corrupt  (_inclusive_cache_bank_sched_io_in_d_bits_corrupt),
    .io_out_a_valid        (auto_out_a_valid),
    .io_out_a_bits_opcode  (auto_out_a_bits_opcode),
    .io_out_a_bits_param   (auto_out_a_bits_param),
    .io_out_a_bits_size    (auto_out_a_bits_size),
    .io_out_a_bits_source  (auto_out_a_bits_source),
    .io_out_a_bits_address (_inclusive_cache_bank_sched_io_out_a_bits_address),
    .io_out_a_bits_mask    (auto_out_a_bits_mask),
    .io_out_a_bits_data    (auto_out_a_bits_data),
    .io_out_a_bits_corrupt (auto_out_a_bits_corrupt),
    .io_out_c_valid        (auto_out_c_valid),
    .io_out_c_bits_opcode  (auto_out_c_bits_opcode),
    .io_out_c_bits_param   (auto_out_c_bits_param),
    .io_out_c_bits_size    (auto_out_c_bits_size),
    .io_out_c_bits_source  (auto_out_c_bits_source),
    .io_out_c_bits_address (_inclusive_cache_bank_sched_io_out_c_bits_address),
    .io_out_c_bits_data    (auto_out_c_bits_data),
    .io_out_c_bits_corrupt (auto_out_c_bits_corrupt),
    .io_out_d_ready        (auto_out_d_ready),
    .io_out_e_valid        (auto_out_e_valid),
    .io_out_e_bits_sink    (auto_out_e_bits_sink),
    .io_req_ready          (_inclusive_cache_bank_sched_io_req_ready),
    .io_resp_valid         (_inclusive_cache_bank_sched_io_resp_valid)
  );
  assign auto_in_a_ready = _inclusive_cache_bank_sched_io_in_a_ready;
  assign auto_in_b_valid = _inclusive_cache_bank_sched_io_in_b_valid;
  assign auto_in_b_bits_param = _inclusive_cache_bank_sched_io_in_b_bits_param;
  assign auto_in_b_bits_address = nodeIn_b_bits_address;
  assign auto_in_c_ready = _inclusive_cache_bank_sched_io_in_c_ready;
  assign auto_in_d_valid = _inclusive_cache_bank_sched_io_in_d_valid;
  assign auto_in_d_bits_opcode = _inclusive_cache_bank_sched_io_in_d_bits_opcode;
  assign auto_in_d_bits_param = _inclusive_cache_bank_sched_io_in_d_bits_param;
  assign auto_in_d_bits_size = _inclusive_cache_bank_sched_io_in_d_bits_size;
  assign auto_in_d_bits_source = _inclusive_cache_bank_sched_io_in_d_bits_source;
  assign auto_in_d_bits_sink = _inclusive_cache_bank_sched_io_in_d_bits_sink;
  assign auto_in_d_bits_denied = _inclusive_cache_bank_sched_io_in_d_bits_denied;
  assign auto_in_d_bits_corrupt = _inclusive_cache_bank_sched_io_in_d_bits_corrupt;
  assign auto_out_a_bits_address = _inclusive_cache_bank_sched_io_out_a_bits_address | 32'h80000000;
  assign auto_out_c_bits_address = _inclusive_cache_bank_sched_io_out_c_bits_address | 32'h80000000;
endmodule

