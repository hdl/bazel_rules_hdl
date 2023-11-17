// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLInterconnectCoupler(
  input          clock,
                 reset,
                 auto_widget_in_a_valid,
  input  [2:0]   auto_widget_in_a_bits_opcode,
                 auto_widget_in_a_bits_param,
  input  [3:0]   auto_widget_in_a_bits_size,
  input  [5:0]   auto_widget_in_a_bits_source,
  input  [28:0]  auto_widget_in_a_bits_address,
  input  [15:0]  auto_widget_in_a_bits_mask,
  input  [127:0] auto_widget_in_a_bits_data,
  input          auto_widget_in_a_bits_corrupt,
                 auto_widget_in_d_ready,
                 auto_bus_xing_out_a_ready,
                 auto_bus_xing_out_d_valid,
  input  [2:0]   auto_bus_xing_out_d_bits_opcode,
  input  [1:0]   auto_bus_xing_out_d_bits_param,
  input  [3:0]   auto_bus_xing_out_d_bits_size,
  input  [5:0]   auto_bus_xing_out_d_bits_source,
  input          auto_bus_xing_out_d_bits_sink,
                 auto_bus_xing_out_d_bits_denied,
  input  [63:0]  auto_bus_xing_out_d_bits_data,
  input          auto_bus_xing_out_d_bits_corrupt,
  output         auto_widget_in_a_ready,
                 auto_widget_in_d_valid,
  output [2:0]   auto_widget_in_d_bits_opcode,
  output [1:0]   auto_widget_in_d_bits_param,
  output [3:0]   auto_widget_in_d_bits_size,
  output [5:0]   auto_widget_in_d_bits_source,
  output         auto_widget_in_d_bits_sink,
                 auto_widget_in_d_bits_denied,
  output [127:0] auto_widget_in_d_bits_data,
  output         auto_widget_in_d_bits_corrupt,
                 auto_bus_xing_out_a_valid,
  output [2:0]   auto_bus_xing_out_a_bits_opcode,
                 auto_bus_xing_out_a_bits_param,
  output [3:0]   auto_bus_xing_out_a_bits_size,
  output [5:0]   auto_bus_xing_out_a_bits_source,
  output [28:0]  auto_bus_xing_out_a_bits_address,
  output [7:0]   auto_bus_xing_out_a_bits_mask,
  output [63:0]  auto_bus_xing_out_a_bits_data,
  output         auto_bus_xing_out_a_bits_corrupt,
                 auto_bus_xing_out_d_ready
);

  TLWidthWidget widget (
    .clock                   (clock),
    .reset                   (reset),
    .auto_in_a_valid         (auto_widget_in_a_valid),
    .auto_in_a_bits_opcode   (auto_widget_in_a_bits_opcode),
    .auto_in_a_bits_param    (auto_widget_in_a_bits_param),
    .auto_in_a_bits_size     (auto_widget_in_a_bits_size),
    .auto_in_a_bits_source   (auto_widget_in_a_bits_source),
    .auto_in_a_bits_address  (auto_widget_in_a_bits_address),
    .auto_in_a_bits_mask     (auto_widget_in_a_bits_mask),
    .auto_in_a_bits_data     (auto_widget_in_a_bits_data),
    .auto_in_a_bits_corrupt  (auto_widget_in_a_bits_corrupt),
    .auto_in_d_ready         (auto_widget_in_d_ready),
    .auto_out_a_ready        (auto_bus_xing_out_a_ready),
    .auto_out_d_valid        (auto_bus_xing_out_d_valid),
    .auto_out_d_bits_opcode  (auto_bus_xing_out_d_bits_opcode),
    .auto_out_d_bits_param   (auto_bus_xing_out_d_bits_param),
    .auto_out_d_bits_size    (auto_bus_xing_out_d_bits_size),
    .auto_out_d_bits_source  (auto_bus_xing_out_d_bits_source),
    .auto_out_d_bits_sink    (auto_bus_xing_out_d_bits_sink),
    .auto_out_d_bits_denied  (auto_bus_xing_out_d_bits_denied),
    .auto_out_d_bits_data    (auto_bus_xing_out_d_bits_data),
    .auto_out_d_bits_corrupt (auto_bus_xing_out_d_bits_corrupt),
    .auto_in_a_ready         (auto_widget_in_a_ready),
    .auto_in_d_valid         (auto_widget_in_d_valid),
    .auto_in_d_bits_opcode   (auto_widget_in_d_bits_opcode),
    .auto_in_d_bits_param    (auto_widget_in_d_bits_param),
    .auto_in_d_bits_size     (auto_widget_in_d_bits_size),
    .auto_in_d_bits_source   (auto_widget_in_d_bits_source),
    .auto_in_d_bits_sink     (auto_widget_in_d_bits_sink),
    .auto_in_d_bits_denied   (auto_widget_in_d_bits_denied),
    .auto_in_d_bits_data     (auto_widget_in_d_bits_data),
    .auto_in_d_bits_corrupt  (auto_widget_in_d_bits_corrupt),
    .auto_out_a_valid        (auto_bus_xing_out_a_valid),
    .auto_out_a_bits_opcode  (auto_bus_xing_out_a_bits_opcode),
    .auto_out_a_bits_param   (auto_bus_xing_out_a_bits_param),
    .auto_out_a_bits_size    (auto_bus_xing_out_a_bits_size),
    .auto_out_a_bits_source  (auto_bus_xing_out_a_bits_source),
    .auto_out_a_bits_address (auto_bus_xing_out_a_bits_address),
    .auto_out_a_bits_mask    (auto_bus_xing_out_a_bits_mask),
    .auto_out_a_bits_data    (auto_bus_xing_out_a_bits_data),
    .auto_out_a_bits_corrupt (auto_bus_xing_out_a_bits_corrupt),
    .auto_out_d_ready        (auto_bus_xing_out_d_ready)
  );
endmodule

