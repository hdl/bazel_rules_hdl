// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ErrorDeviceWrapper(
  input         clock,
                reset,
                auto_buffer_in_a_valid,
  input  [2:0]  auto_buffer_in_a_bits_opcode,
                auto_buffer_in_a_bits_param,
  input  [3:0]  auto_buffer_in_a_bits_size,
  input  [6:0]  auto_buffer_in_a_bits_source,
  input  [13:0] auto_buffer_in_a_bits_address,
  input  [7:0]  auto_buffer_in_a_bits_mask,
  input         auto_buffer_in_a_bits_corrupt,
                auto_buffer_in_d_ready,
  output        auto_buffer_in_a_ready,
                auto_buffer_in_d_valid,
  output [2:0]  auto_buffer_in_d_bits_opcode,
  output [1:0]  auto_buffer_in_d_bits_param,
  output [3:0]  auto_buffer_in_d_bits_size,
  output [6:0]  auto_buffer_in_d_bits_source,
  output        auto_buffer_in_d_bits_sink,
                auto_buffer_in_d_bits_denied,
  output [63:0] auto_buffer_in_d_bits_data,
  output        auto_buffer_in_d_bits_corrupt
);

  wire        _buffer_auto_out_a_valid;
  wire [2:0]  _buffer_auto_out_a_bits_opcode;
  wire [2:0]  _buffer_auto_out_a_bits_param;
  wire [3:0]  _buffer_auto_out_a_bits_size;
  wire [6:0]  _buffer_auto_out_a_bits_source;
  wire [13:0] _buffer_auto_out_a_bits_address;
  wire [7:0]  _buffer_auto_out_a_bits_mask;
  wire        _buffer_auto_out_a_bits_corrupt;
  wire        _buffer_auto_out_d_ready;
  wire        _error_auto_in_a_ready;
  wire        _error_auto_in_d_valid;
  wire [2:0]  _error_auto_in_d_bits_opcode;
  wire [3:0]  _error_auto_in_d_bits_size;
  wire [6:0]  _error_auto_in_d_bits_source;
  wire        _error_auto_in_d_bits_corrupt;
  TLError error (
    .clock                  (clock),
    .reset                  (reset),
    .auto_in_a_valid        (_buffer_auto_out_a_valid),
    .auto_in_a_bits_opcode  (_buffer_auto_out_a_bits_opcode),
    .auto_in_a_bits_param   (_buffer_auto_out_a_bits_param),
    .auto_in_a_bits_size    (_buffer_auto_out_a_bits_size),
    .auto_in_a_bits_source  (_buffer_auto_out_a_bits_source),
    .auto_in_a_bits_address (_buffer_auto_out_a_bits_address),
    .auto_in_a_bits_mask    (_buffer_auto_out_a_bits_mask),
    .auto_in_a_bits_corrupt (_buffer_auto_out_a_bits_corrupt),
    .auto_in_d_ready        (_buffer_auto_out_d_ready),
    .auto_in_a_ready        (_error_auto_in_a_ready),
    .auto_in_d_valid        (_error_auto_in_d_valid),
    .auto_in_d_bits_opcode  (_error_auto_in_d_bits_opcode),
    .auto_in_d_bits_size    (_error_auto_in_d_bits_size),
    .auto_in_d_bits_source  (_error_auto_in_d_bits_source),
    .auto_in_d_bits_corrupt (_error_auto_in_d_bits_corrupt)
  );
  TLBuffer_5 buffer (
    .clock                   (clock),
    .reset                   (reset),
    .auto_in_a_valid         (auto_buffer_in_a_valid),
    .auto_in_a_bits_opcode   (auto_buffer_in_a_bits_opcode),
    .auto_in_a_bits_param    (auto_buffer_in_a_bits_param),
    .auto_in_a_bits_size     (auto_buffer_in_a_bits_size),
    .auto_in_a_bits_source   (auto_buffer_in_a_bits_source),
    .auto_in_a_bits_address  (auto_buffer_in_a_bits_address),
    .auto_in_a_bits_mask     (auto_buffer_in_a_bits_mask),
    .auto_in_a_bits_corrupt  (auto_buffer_in_a_bits_corrupt),
    .auto_in_d_ready         (auto_buffer_in_d_ready),
    .auto_out_a_ready        (_error_auto_in_a_ready),
    .auto_out_d_valid        (_error_auto_in_d_valid),
    .auto_out_d_bits_opcode  (_error_auto_in_d_bits_opcode),
    .auto_out_d_bits_size    (_error_auto_in_d_bits_size),
    .auto_out_d_bits_source  (_error_auto_in_d_bits_source),
    .auto_out_d_bits_corrupt (_error_auto_in_d_bits_corrupt),
    .auto_in_a_ready         (auto_buffer_in_a_ready),
    .auto_in_d_valid         (auto_buffer_in_d_valid),
    .auto_in_d_bits_opcode   (auto_buffer_in_d_bits_opcode),
    .auto_in_d_bits_param    (auto_buffer_in_d_bits_param),
    .auto_in_d_bits_size     (auto_buffer_in_d_bits_size),
    .auto_in_d_bits_source   (auto_buffer_in_d_bits_source),
    .auto_in_d_bits_sink     (auto_buffer_in_d_bits_sink),
    .auto_in_d_bits_denied   (auto_buffer_in_d_bits_denied),
    .auto_in_d_bits_data     (auto_buffer_in_d_bits_data),
    .auto_in_d_bits_corrupt  (auto_buffer_in_d_bits_corrupt),
    .auto_out_a_valid        (_buffer_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_buffer_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_buffer_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_buffer_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_buffer_auto_out_a_bits_source),
    .auto_out_a_bits_address (_buffer_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_buffer_auto_out_a_bits_mask),
    .auto_out_a_bits_corrupt (_buffer_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_buffer_auto_out_d_ready)
  );
endmodule

