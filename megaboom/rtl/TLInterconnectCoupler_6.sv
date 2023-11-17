// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLInterconnectCoupler_6(
  input         clock,
                reset,
                auto_buffer_in_a_valid,
  input  [2:0]  auto_buffer_in_a_bits_opcode,
                auto_buffer_in_a_bits_param,
  input  [3:0]  auto_buffer_in_a_bits_size,
                auto_buffer_in_a_bits_source,
  input  [31:0] auto_buffer_in_a_bits_address,
  input  [7:0]  auto_buffer_in_a_bits_mask,
  input  [63:0] auto_buffer_in_a_bits_data,
  input         auto_buffer_in_a_bits_corrupt,
                auto_buffer_in_d_ready,
                auto_tl_out_a_ready,
                auto_tl_out_d_valid,
  input  [2:0]  auto_tl_out_d_bits_opcode,
  input  [1:0]  auto_tl_out_d_bits_param,
  input  [3:0]  auto_tl_out_d_bits_size,
                auto_tl_out_d_bits_source,
                auto_tl_out_d_bits_sink,
  input         auto_tl_out_d_bits_denied,
  input  [63:0] auto_tl_out_d_bits_data,
  input         auto_tl_out_d_bits_corrupt,
  output        auto_buffer_in_a_ready,
                auto_buffer_in_d_valid,
  output [2:0]  auto_buffer_in_d_bits_opcode,
  output [1:0]  auto_buffer_in_d_bits_param,
  output [3:0]  auto_buffer_in_d_bits_size,
                auto_buffer_in_d_bits_source,
                auto_buffer_in_d_bits_sink,
  output        auto_buffer_in_d_bits_denied,
  output [63:0] auto_buffer_in_d_bits_data,
  output        auto_buffer_in_d_bits_corrupt,
                auto_tl_out_a_valid,
  output [2:0]  auto_tl_out_a_bits_opcode,
                auto_tl_out_a_bits_param,
  output [3:0]  auto_tl_out_a_bits_size,
                auto_tl_out_a_bits_source,
  output [31:0] auto_tl_out_a_bits_address,
  output [7:0]  auto_tl_out_a_bits_mask,
  output [63:0] auto_tl_out_a_bits_data,
  output        auto_tl_out_a_bits_corrupt,
                auto_tl_out_d_ready
);

  TLBuffer_3 buffer (
    .clock                   (clock),
    .reset                   (reset),
    .auto_in_a_valid         (auto_buffer_in_a_valid),
    .auto_in_a_bits_opcode   (auto_buffer_in_a_bits_opcode),
    .auto_in_a_bits_param    (auto_buffer_in_a_bits_param),
    .auto_in_a_bits_size     (auto_buffer_in_a_bits_size),
    .auto_in_a_bits_source   (auto_buffer_in_a_bits_source),
    .auto_in_a_bits_address  (auto_buffer_in_a_bits_address),
    .auto_in_a_bits_mask     (auto_buffer_in_a_bits_mask),
    .auto_in_a_bits_data     (auto_buffer_in_a_bits_data),
    .auto_in_a_bits_corrupt  (auto_buffer_in_a_bits_corrupt),
    .auto_in_d_ready         (auto_buffer_in_d_ready),
    .auto_out_a_ready        (auto_tl_out_a_ready),
    .auto_out_d_valid        (auto_tl_out_d_valid),
    .auto_out_d_bits_opcode  (auto_tl_out_d_bits_opcode),
    .auto_out_d_bits_param   (auto_tl_out_d_bits_param),
    .auto_out_d_bits_size    (auto_tl_out_d_bits_size),
    .auto_out_d_bits_source  (auto_tl_out_d_bits_source),
    .auto_out_d_bits_sink    (auto_tl_out_d_bits_sink),
    .auto_out_d_bits_denied  (auto_tl_out_d_bits_denied),
    .auto_out_d_bits_data    (auto_tl_out_d_bits_data),
    .auto_out_d_bits_corrupt (auto_tl_out_d_bits_corrupt),
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
    .auto_out_a_valid        (auto_tl_out_a_valid),
    .auto_out_a_bits_opcode  (auto_tl_out_a_bits_opcode),
    .auto_out_a_bits_param   (auto_tl_out_a_bits_param),
    .auto_out_a_bits_size    (auto_tl_out_a_bits_size),
    .auto_out_a_bits_source  (auto_tl_out_a_bits_source),
    .auto_out_a_bits_address (auto_tl_out_a_bits_address),
    .auto_out_a_bits_mask    (auto_tl_out_a_bits_mask),
    .auto_out_a_bits_data    (auto_tl_out_a_bits_data),
    .auto_out_a_bits_corrupt (auto_tl_out_a_bits_corrupt),
    .auto_out_d_ready        (auto_tl_out_d_ready)
  );
endmodule

