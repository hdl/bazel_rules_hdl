// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module UARTAdapter(
  input  clock,
         reset,
         io_uart_txd,
  output io_uart_rxd
);

  wire       _rxq_io_enq_ready;
  wire       _rxq_io_deq_valid;
  wire [7:0] _rxq_io_deq_bits;
  wire [3:0] _rxq_io_count;
  wire       _rxm_io_in_ready;
  wire       _txq_io_enq_ready;
  wire       _txq_io_deq_valid;
  wire [7:0] _txq_io_deq_bits;
  wire       _txm_io_out_valid;
  wire [7:0] _txm_io_out_bits;
  wire       _sim_serial_in_valid;
  wire [7:0] _sim_serial_in_bits;
  wire       _sim_serial_out_ready;
  SimUART #(
    .FORCEPTY(0),
    .UARTNO(0)
  ) sim (
    .clock            (clock),
    .reset            (reset),
    .serial_in_ready  (_rxq_io_enq_ready & _rxq_io_count < 4'h7),
    .serial_out_valid (_txq_io_deq_valid),
    .serial_out_bits  (_txq_io_deq_bits),
    .serial_in_valid  (_sim_serial_in_valid),
    .serial_in_bits   (_sim_serial_in_bits),
    .serial_out_ready (_sim_serial_out_ready)
  );
  UARTRx txm (
    .clock        (clock),
    .reset        (reset),
    .io_en        (1'h1),
    .io_in        (io_uart_txd),
    .io_div       (16'h10F4),
    .io_out_valid (_txm_io_out_valid),
    .io_out_bits  (_txm_io_out_bits)
  );
  Queue_80 txq (
    .clock        (clock),
    .reset        (reset),
    .io_enq_valid (_txm_io_out_valid),
    .io_enq_bits  (_txm_io_out_bits),
    .io_deq_ready (_sim_serial_out_ready),
    .io_enq_ready (_txq_io_enq_ready),
    .io_deq_valid (_txq_io_deq_valid),
    .io_deq_bits  (_txq_io_deq_bits),
    .io_count     (/* unused */)
  );
  UARTTx rxm (
    .clock       (clock),
    .reset       (reset),
    .io_en       (1'h1),
    .io_in_valid (_rxq_io_deq_valid),
    .io_in_bits  (_rxq_io_deq_bits),
    .io_div      (16'h10F4),
    .io_nstop    (1'h0),
    .io_in_ready (_rxm_io_in_ready),
    .io_out      (io_uart_rxd)
  );
  Queue_80 rxq (
    .clock        (clock),
    .reset        (reset),
    .io_enq_valid (_sim_serial_in_valid),
    .io_enq_bits  (_sim_serial_in_bits),
    .io_deq_ready (_rxm_io_in_ready),
    .io_enq_ready (_rxq_io_enq_ready),
    .io_deq_valid (_rxq_io_deq_valid),
    .io_deq_bits  (_rxq_io_deq_bits),
    .io_count     (_rxq_io_count)
  );
endmodule

