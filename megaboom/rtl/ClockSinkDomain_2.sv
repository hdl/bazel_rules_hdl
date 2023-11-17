// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ClockSinkDomain_2(
  input         auto_uart_0_control_xing_in_a_valid,
  input  [2:0]  auto_uart_0_control_xing_in_a_bits_opcode,
                auto_uart_0_control_xing_in_a_bits_param,
  input  [1:0]  auto_uart_0_control_xing_in_a_bits_size,
  input  [10:0] auto_uart_0_control_xing_in_a_bits_source,
  input  [28:0] auto_uart_0_control_xing_in_a_bits_address,
  input  [7:0]  auto_uart_0_control_xing_in_a_bits_mask,
  input  [63:0] auto_uart_0_control_xing_in_a_bits_data,
  input         auto_uart_0_control_xing_in_a_bits_corrupt,
                auto_uart_0_control_xing_in_d_ready,
                auto_uart_0_io_out_rxd,
                auto_clock_in_clock,
                auto_clock_in_reset,
  output        auto_uart_0_int_xing_out_sync_0,
                auto_uart_0_control_xing_in_a_ready,
                auto_uart_0_control_xing_in_d_valid,
  output [2:0]  auto_uart_0_control_xing_in_d_bits_opcode,
  output [1:0]  auto_uart_0_control_xing_in_d_bits_size,
  output [10:0] auto_uart_0_control_xing_in_d_bits_source,
  output [63:0] auto_uart_0_control_xing_in_d_bits_data,
  output        auto_uart_0_io_out_txd
);

  TLUART uart_0 (
    .clock                               (auto_clock_in_clock),
    .reset                               (auto_clock_in_reset),
    .auto_control_xing_in_a_valid        (auto_uart_0_control_xing_in_a_valid),
    .auto_control_xing_in_a_bits_opcode  (auto_uart_0_control_xing_in_a_bits_opcode),
    .auto_control_xing_in_a_bits_param   (auto_uart_0_control_xing_in_a_bits_param),
    .auto_control_xing_in_a_bits_size    (auto_uart_0_control_xing_in_a_bits_size),
    .auto_control_xing_in_a_bits_source  (auto_uart_0_control_xing_in_a_bits_source),
    .auto_control_xing_in_a_bits_address (auto_uart_0_control_xing_in_a_bits_address),
    .auto_control_xing_in_a_bits_mask    (auto_uart_0_control_xing_in_a_bits_mask),
    .auto_control_xing_in_a_bits_data    (auto_uart_0_control_xing_in_a_bits_data),
    .auto_control_xing_in_a_bits_corrupt (auto_uart_0_control_xing_in_a_bits_corrupt),
    .auto_control_xing_in_d_ready        (auto_uart_0_control_xing_in_d_ready),
    .auto_io_out_rxd                     (auto_uart_0_io_out_rxd),
    .auto_int_xing_out_sync_0            (auto_uart_0_int_xing_out_sync_0),
    .auto_control_xing_in_a_ready        (auto_uart_0_control_xing_in_a_ready),
    .auto_control_xing_in_d_valid        (auto_uart_0_control_xing_in_d_valid),
    .auto_control_xing_in_d_bits_opcode  (auto_uart_0_control_xing_in_d_bits_opcode),
    .auto_control_xing_in_d_bits_size    (auto_uart_0_control_xing_in_d_bits_size),
    .auto_control_xing_in_d_bits_source  (auto_uart_0_control_xing_in_d_bits_source),
    .auto_control_xing_in_d_bits_data    (auto_uart_0_control_xing_in_d_bits_data),
    .auto_io_out_txd                     (auto_uart_0_io_out_txd)
  );
endmodule

