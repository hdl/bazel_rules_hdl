// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLInterconnectCoupler_15(
  input         clock,
                reset,
                auto_fixer_out_a_ready,
                auto_fixer_out_d_valid,
  input  [2:0]  auto_fixer_out_d_bits_opcode,
                auto_fixer_out_d_bits_size,
  input  [6:0]  auto_fixer_out_d_bits_source,
  input  [63:0] auto_fixer_out_d_bits_data,
  input         auto_tl_in_a_valid,
  input  [2:0]  auto_tl_in_a_bits_opcode,
                auto_tl_in_a_bits_param,
                auto_tl_in_a_bits_size,
  input  [6:0]  auto_tl_in_a_bits_source,
  input  [20:0] auto_tl_in_a_bits_address,
  input  [7:0]  auto_tl_in_a_bits_mask,
  input  [63:0] auto_tl_in_a_bits_data,
  input         auto_tl_in_a_bits_corrupt,
                auto_tl_in_d_ready,
  output        auto_fixer_out_a_valid,
  output [2:0]  auto_fixer_out_a_bits_opcode,
                auto_fixer_out_a_bits_param,
                auto_fixer_out_a_bits_size,
  output [6:0]  auto_fixer_out_a_bits_source,
  output [20:0] auto_fixer_out_a_bits_address,
  output [7:0]  auto_fixer_out_a_bits_mask,
  output [63:0] auto_fixer_out_a_bits_data,
  output        auto_fixer_out_a_bits_corrupt,
                auto_fixer_out_d_ready,
                auto_tl_in_a_ready,
                auto_tl_in_d_valid,
  output [2:0]  auto_tl_in_d_bits_opcode,
  output [1:0]  auto_tl_in_d_bits_param,
  output [2:0]  auto_tl_in_d_bits_size,
  output [6:0]  auto_tl_in_d_bits_source,
  output        auto_tl_in_d_bits_sink,
                auto_tl_in_d_bits_denied,
  output [63:0] auto_tl_in_d_bits_data,
  output        auto_tl_in_d_bits_corrupt
);

  wire        _buffer_auto_out_a_valid;
  wire [2:0]  _buffer_auto_out_a_bits_opcode;
  wire [2:0]  _buffer_auto_out_a_bits_param;
  wire [2:0]  _buffer_auto_out_a_bits_size;
  wire [6:0]  _buffer_auto_out_a_bits_source;
  wire [20:0] _buffer_auto_out_a_bits_address;
  wire [7:0]  _buffer_auto_out_a_bits_mask;
  wire [63:0] _buffer_auto_out_a_bits_data;
  wire        _buffer_auto_out_a_bits_corrupt;
  wire        _buffer_auto_out_d_ready;
  wire        _fixer_auto_in_a_ready;
  wire        _fixer_auto_in_d_valid;
  wire [2:0]  _fixer_auto_in_d_bits_opcode;
  wire [2:0]  _fixer_auto_in_d_bits_size;
  wire [6:0]  _fixer_auto_in_d_bits_source;
  wire [63:0] _fixer_auto_in_d_bits_data;
  TLFIFOFixer_3 fixer (
    .clock                   (clock),
    .reset                   (reset),
    .auto_in_a_valid         (_buffer_auto_out_a_valid),
    .auto_in_a_bits_opcode   (_buffer_auto_out_a_bits_opcode),
    .auto_in_a_bits_param    (_buffer_auto_out_a_bits_param),
    .auto_in_a_bits_size     (_buffer_auto_out_a_bits_size),
    .auto_in_a_bits_source   (_buffer_auto_out_a_bits_source),
    .auto_in_a_bits_address  (_buffer_auto_out_a_bits_address),
    .auto_in_a_bits_mask     (_buffer_auto_out_a_bits_mask),
    .auto_in_a_bits_data     (_buffer_auto_out_a_bits_data),
    .auto_in_a_bits_corrupt  (_buffer_auto_out_a_bits_corrupt),
    .auto_in_d_ready         (_buffer_auto_out_d_ready),
    .auto_out_a_ready        (auto_fixer_out_a_ready),
    .auto_out_d_valid        (auto_fixer_out_d_valid),
    .auto_out_d_bits_opcode  (auto_fixer_out_d_bits_opcode),
    .auto_out_d_bits_size    (auto_fixer_out_d_bits_size),
    .auto_out_d_bits_source  (auto_fixer_out_d_bits_source),
    .auto_out_d_bits_data    (auto_fixer_out_d_bits_data),
    .auto_in_a_ready         (_fixer_auto_in_a_ready),
    .auto_in_d_valid         (_fixer_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_fixer_auto_in_d_bits_opcode),
    .auto_in_d_bits_size     (_fixer_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_fixer_auto_in_d_bits_source),
    .auto_in_d_bits_data     (_fixer_auto_in_d_bits_data),
    .auto_out_a_valid        (auto_fixer_out_a_valid),
    .auto_out_a_bits_opcode  (auto_fixer_out_a_bits_opcode),
    .auto_out_a_bits_param   (auto_fixer_out_a_bits_param),
    .auto_out_a_bits_size    (auto_fixer_out_a_bits_size),
    .auto_out_a_bits_source  (auto_fixer_out_a_bits_source),
    .auto_out_a_bits_address (auto_fixer_out_a_bits_address),
    .auto_out_a_bits_mask    (auto_fixer_out_a_bits_mask),
    .auto_out_a_bits_data    (auto_fixer_out_a_bits_data),
    .auto_out_a_bits_corrupt (auto_fixer_out_a_bits_corrupt),
    .auto_out_d_ready        (auto_fixer_out_d_ready)
  );
  TLBuffer_8 buffer (
    .clock                   (clock),
    .reset                   (reset),
    .auto_in_a_valid         (auto_tl_in_a_valid),
    .auto_in_a_bits_opcode   (auto_tl_in_a_bits_opcode),
    .auto_in_a_bits_param    (auto_tl_in_a_bits_param),
    .auto_in_a_bits_size     (auto_tl_in_a_bits_size),
    .auto_in_a_bits_source   (auto_tl_in_a_bits_source),
    .auto_in_a_bits_address  (auto_tl_in_a_bits_address),
    .auto_in_a_bits_mask     (auto_tl_in_a_bits_mask),
    .auto_in_a_bits_data     (auto_tl_in_a_bits_data),
    .auto_in_a_bits_corrupt  (auto_tl_in_a_bits_corrupt),
    .auto_in_d_ready         (auto_tl_in_d_ready),
    .auto_out_a_ready        (_fixer_auto_in_a_ready),
    .auto_out_d_valid        (_fixer_auto_in_d_valid),
    .auto_out_d_bits_opcode  (_fixer_auto_in_d_bits_opcode),
    .auto_out_d_bits_size    (_fixer_auto_in_d_bits_size),
    .auto_out_d_bits_source  (_fixer_auto_in_d_bits_source),
    .auto_out_d_bits_data    (_fixer_auto_in_d_bits_data),
    .auto_in_a_ready         (auto_tl_in_a_ready),
    .auto_in_d_valid         (auto_tl_in_d_valid),
    .auto_in_d_bits_opcode   (auto_tl_in_d_bits_opcode),
    .auto_in_d_bits_param    (auto_tl_in_d_bits_param),
    .auto_in_d_bits_size     (auto_tl_in_d_bits_size),
    .auto_in_d_bits_source   (auto_tl_in_d_bits_source),
    .auto_in_d_bits_sink     (auto_tl_in_d_bits_sink),
    .auto_in_d_bits_denied   (auto_tl_in_d_bits_denied),
    .auto_in_d_bits_data     (auto_tl_in_d_bits_data),
    .auto_in_d_bits_corrupt  (auto_tl_in_d_bits_corrupt),
    .auto_out_a_valid        (_buffer_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_buffer_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_buffer_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_buffer_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_buffer_auto_out_a_bits_source),
    .auto_out_a_bits_address (_buffer_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_buffer_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_buffer_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_buffer_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_buffer_auto_out_d_ready)
  );
endmodule

