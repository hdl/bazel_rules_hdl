// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TestHarness(
  input  clock,
         reset,
  output io_success
);

  wire        _source_1_clk;
  wire        _source_clk;
  wire        _harnessBinderReset_catcher_io_sync_reset;
  wire        _uart_sim_0_uartno0_io_uart_rxd;
  wire        _simdram_axi_aw_ready;
  wire        _simdram_axi_w_ready;
  wire        _simdram_axi_b_valid;
  wire [3:0]  _simdram_axi_b_bits_id;
  wire [1:0]  _simdram_axi_b_bits_resp;
  wire        _simdram_axi_ar_ready;
  wire        _simdram_axi_r_valid;
  wire [3:0]  _simdram_axi_r_bits_id;
  wire [63:0] _simdram_axi_r_bits_data;
  wire [1:0]  _simdram_axi_r_bits_resp;
  wire        _simdram_axi_r_bits_last;
  wire        _success_exit_sim_tsi_in_valid;
  wire [31:0] _success_exit_sim_tsi_in_bits;
  wire        _success_exit_sim_tsi_out_ready;
  wire [31:0] _success_exit_sim_exit;
  wire        _ram_io_ser_in_valid;
  wire [31:0] _ram_io_ser_in_bits;
  wire        _ram_io_ser_out_ready;
  wire        _ram_io_tsi_in_ready;
  wire        _ram_io_tsi_out_valid;
  wire [31:0] _ram_io_tsi_out_bits;
  wire [31:0] _plusarg_reader_1_out;
  wire        _jtag_jtag_TCK;
  wire        _jtag_jtag_TMS;
  wire        _jtag_jtag_TDI;
  wire [31:0] _jtag_exit;
  wire        _plusarg_reader_out;
  wire        _chiptop0_serial_tl_bits_in_ready;
  wire        _chiptop0_serial_tl_bits_out_valid;
  wire [31:0] _chiptop0_serial_tl_bits_out_bits;
  wire        _chiptop0_axi4_mem_0_clock;
  wire        _chiptop0_axi4_mem_0_reset;
  wire        _chiptop0_axi4_mem_0_bits_aw_valid;
  wire [3:0]  _chiptop0_axi4_mem_0_bits_aw_bits_id;
  wire [31:0] _chiptop0_axi4_mem_0_bits_aw_bits_addr;
  wire [7:0]  _chiptop0_axi4_mem_0_bits_aw_bits_len;
  wire [2:0]  _chiptop0_axi4_mem_0_bits_aw_bits_size;
  wire [1:0]  _chiptop0_axi4_mem_0_bits_aw_bits_burst;
  wire        _chiptop0_axi4_mem_0_bits_aw_bits_lock;
  wire [3:0]  _chiptop0_axi4_mem_0_bits_aw_bits_cache;
  wire [2:0]  _chiptop0_axi4_mem_0_bits_aw_bits_prot;
  wire [3:0]  _chiptop0_axi4_mem_0_bits_aw_bits_qos;
  wire        _chiptop0_axi4_mem_0_bits_w_valid;
  wire [63:0] _chiptop0_axi4_mem_0_bits_w_bits_data;
  wire [7:0]  _chiptop0_axi4_mem_0_bits_w_bits_strb;
  wire        _chiptop0_axi4_mem_0_bits_w_bits_last;
  wire        _chiptop0_axi4_mem_0_bits_b_ready;
  wire        _chiptop0_axi4_mem_0_bits_ar_valid;
  wire [3:0]  _chiptop0_axi4_mem_0_bits_ar_bits_id;
  wire [31:0] _chiptop0_axi4_mem_0_bits_ar_bits_addr;
  wire [7:0]  _chiptop0_axi4_mem_0_bits_ar_bits_len;
  wire [2:0]  _chiptop0_axi4_mem_0_bits_ar_bits_size;
  wire [1:0]  _chiptop0_axi4_mem_0_bits_ar_bits_burst;
  wire        _chiptop0_axi4_mem_0_bits_ar_bits_lock;
  wire [3:0]  _chiptop0_axi4_mem_0_bits_ar_bits_cache;
  wire [2:0]  _chiptop0_axi4_mem_0_bits_ar_bits_prot;
  wire [3:0]  _chiptop0_axi4_mem_0_bits_ar_bits_qos;
  wire        _chiptop0_axi4_mem_0_bits_r_ready;
  wire        _chiptop0_jtag_TDO;
  wire        _chiptop0_uart_0_txd;
  ChipTop chiptop0 (
    .serial_tl_clock               (_source_1_clk),
    .serial_tl_bits_in_valid       (_ram_io_ser_in_valid),
    .serial_tl_bits_in_bits        (_ram_io_ser_in_bits),
    .serial_tl_bits_out_ready      (_ram_io_ser_out_ready),
    .custom_boot                   (_plusarg_reader_out),
    .reset_io                      (reset),
    .clock_uncore_clock            (_source_clk),
    .axi4_mem_0_bits_aw_ready      (_simdram_axi_aw_ready),
    .axi4_mem_0_bits_w_ready       (_simdram_axi_w_ready),
    .axi4_mem_0_bits_b_valid       (_simdram_axi_b_valid),
    .axi4_mem_0_bits_b_bits_id     (_simdram_axi_b_bits_id),
    .axi4_mem_0_bits_b_bits_resp   (_simdram_axi_b_bits_resp),
    .axi4_mem_0_bits_ar_ready      (_simdram_axi_ar_ready),
    .axi4_mem_0_bits_r_valid       (_simdram_axi_r_valid),
    .axi4_mem_0_bits_r_bits_id     (_simdram_axi_r_bits_id),
    .axi4_mem_0_bits_r_bits_data   (_simdram_axi_r_bits_data),
    .axi4_mem_0_bits_r_bits_resp   (_simdram_axi_r_bits_resp),
    .axi4_mem_0_bits_r_bits_last   (_simdram_axi_r_bits_last),
    .jtag_TCK                      (_jtag_jtag_TCK),
    .jtag_TMS                      (_jtag_jtag_TMS),
    .jtag_TDI                      (_jtag_jtag_TDI),
    .uart_0_rxd                    (_uart_sim_0_uartno0_io_uart_rxd),
    .serial_tl_bits_in_ready       (_chiptop0_serial_tl_bits_in_ready),
    .serial_tl_bits_out_valid      (_chiptop0_serial_tl_bits_out_valid),
    .serial_tl_bits_out_bits       (_chiptop0_serial_tl_bits_out_bits),
    .axi4_mem_0_clock              (_chiptop0_axi4_mem_0_clock),
    .axi4_mem_0_reset              (_chiptop0_axi4_mem_0_reset),
    .axi4_mem_0_bits_aw_valid      (_chiptop0_axi4_mem_0_bits_aw_valid),
    .axi4_mem_0_bits_aw_bits_id    (_chiptop0_axi4_mem_0_bits_aw_bits_id),
    .axi4_mem_0_bits_aw_bits_addr  (_chiptop0_axi4_mem_0_bits_aw_bits_addr),
    .axi4_mem_0_bits_aw_bits_len   (_chiptop0_axi4_mem_0_bits_aw_bits_len),
    .axi4_mem_0_bits_aw_bits_size  (_chiptop0_axi4_mem_0_bits_aw_bits_size),
    .axi4_mem_0_bits_aw_bits_burst (_chiptop0_axi4_mem_0_bits_aw_bits_burst),
    .axi4_mem_0_bits_aw_bits_lock  (_chiptop0_axi4_mem_0_bits_aw_bits_lock),
    .axi4_mem_0_bits_aw_bits_cache (_chiptop0_axi4_mem_0_bits_aw_bits_cache),
    .axi4_mem_0_bits_aw_bits_prot  (_chiptop0_axi4_mem_0_bits_aw_bits_prot),
    .axi4_mem_0_bits_aw_bits_qos   (_chiptop0_axi4_mem_0_bits_aw_bits_qos),
    .axi4_mem_0_bits_w_valid       (_chiptop0_axi4_mem_0_bits_w_valid),
    .axi4_mem_0_bits_w_bits_data   (_chiptop0_axi4_mem_0_bits_w_bits_data),
    .axi4_mem_0_bits_w_bits_strb   (_chiptop0_axi4_mem_0_bits_w_bits_strb),
    .axi4_mem_0_bits_w_bits_last   (_chiptop0_axi4_mem_0_bits_w_bits_last),
    .axi4_mem_0_bits_b_ready       (_chiptop0_axi4_mem_0_bits_b_ready),
    .axi4_mem_0_bits_ar_valid      (_chiptop0_axi4_mem_0_bits_ar_valid),
    .axi4_mem_0_bits_ar_bits_id    (_chiptop0_axi4_mem_0_bits_ar_bits_id),
    .axi4_mem_0_bits_ar_bits_addr  (_chiptop0_axi4_mem_0_bits_ar_bits_addr),
    .axi4_mem_0_bits_ar_bits_len   (_chiptop0_axi4_mem_0_bits_ar_bits_len),
    .axi4_mem_0_bits_ar_bits_size  (_chiptop0_axi4_mem_0_bits_ar_bits_size),
    .axi4_mem_0_bits_ar_bits_burst (_chiptop0_axi4_mem_0_bits_ar_bits_burst),
    .axi4_mem_0_bits_ar_bits_lock  (_chiptop0_axi4_mem_0_bits_ar_bits_lock),
    .axi4_mem_0_bits_ar_bits_cache (_chiptop0_axi4_mem_0_bits_ar_bits_cache),
    .axi4_mem_0_bits_ar_bits_prot  (_chiptop0_axi4_mem_0_bits_ar_bits_prot),
    .axi4_mem_0_bits_ar_bits_qos   (_chiptop0_axi4_mem_0_bits_ar_bits_qos),
    .axi4_mem_0_bits_r_ready       (_chiptop0_axi4_mem_0_bits_r_ready),
    .jtag_TDO                      (_chiptop0_jtag_TDO),
    .uart_0_txd                    (_chiptop0_uart_0_txd)
  );
  plusarg_reader #(
    .DEFAULT(0),
    .FORMAT("custom_boot_pin=%d"),
    .WIDTH(1)
  ) plusarg_reader (
    .out (_plusarg_reader_out)
  );
  SimJTAG #(
    .TICK_DELAY(3)
  ) jtag (
    .clock           (_source_1_clk),
    .reset           (_harnessBinderReset_catcher_io_sync_reset),
    .jtag_TDO_data   (_chiptop0_jtag_TDO),
    .jtag_TDO_driven (1'h1),
    .enable          (_plusarg_reader_1_out[0]),
    .init_done       (~_harnessBinderReset_catcher_io_sync_reset),
    .jtag_TRSTn      (/* unused */),
    .jtag_TCK        (_jtag_jtag_TCK),
    .jtag_TMS        (_jtag_jtag_TMS),
    .jtag_TDI        (_jtag_jtag_TDI),
    .exit            (_jtag_exit)
  );
  plusarg_reader #(
    .DEFAULT(0),
    .FORMAT("jtag_rbb_enable=%d"),
    .WIDTH(32)
  ) plusarg_reader_1 (
    .out (_plusarg_reader_1_out)
  );
  SerialRAM ram (
    .clock            (_source_1_clk),
    .reset            (_harnessBinderReset_catcher_io_sync_reset),
    .io_ser_in_ready  (_chiptop0_serial_tl_bits_in_ready),
    .io_ser_out_valid (_chiptop0_serial_tl_bits_out_valid),
    .io_ser_out_bits  (_chiptop0_serial_tl_bits_out_bits),
    .io_tsi_in_valid  (_success_exit_sim_tsi_in_valid),
    .io_tsi_in_bits   (_success_exit_sim_tsi_in_bits),
    .io_tsi_out_ready (_success_exit_sim_tsi_out_ready),
    .io_ser_in_valid  (_ram_io_ser_in_valid),
    .io_ser_in_bits   (_ram_io_ser_in_bits),
    .io_ser_out_ready (_ram_io_ser_out_ready),
    .io_tsi_in_ready  (_ram_io_tsi_in_ready),
    .io_tsi_out_valid (_ram_io_tsi_out_valid),
    .io_tsi_out_bits  (_ram_io_tsi_out_bits)
  );
  SimTSI success_exit_sim (
    .clock         (_source_1_clk),
    .reset         (_harnessBinderReset_catcher_io_sync_reset),
    .tsi_in_ready  (_ram_io_tsi_in_ready),
    .tsi_out_valid (_ram_io_tsi_out_valid),
    .tsi_out_bits  (_ram_io_tsi_out_bits),
    .tsi_in_valid  (_success_exit_sim_tsi_in_valid),
    .tsi_in_bits   (_success_exit_sim_tsi_in_bits),
    .tsi_out_ready (_success_exit_sim_tsi_out_ready),
    .exit          (_success_exit_sim_exit)
  );
  SimDRAM #(
    .ADDR_BITS(32),
    .CLOCK_HZ(500000000),
    .DATA_BITS(64),
    .ID_BITS(4),
    .LINE_SIZE(64),
    .MEM_BASE(40'd2147483648),
    .MEM_SIZE(268435456)
  ) simdram (
    .clock             (_chiptop0_axi4_mem_0_clock),
    .reset             (_chiptop0_axi4_mem_0_reset),
    .axi_aw_valid      (_chiptop0_axi4_mem_0_bits_aw_valid),
    .axi_aw_bits_id    (_chiptop0_axi4_mem_0_bits_aw_bits_id),
    .axi_aw_bits_addr  (_chiptop0_axi4_mem_0_bits_aw_bits_addr),
    .axi_aw_bits_len   (_chiptop0_axi4_mem_0_bits_aw_bits_len),
    .axi_aw_bits_size  (_chiptop0_axi4_mem_0_bits_aw_bits_size),
    .axi_aw_bits_burst (_chiptop0_axi4_mem_0_bits_aw_bits_burst),
    .axi_aw_bits_lock  (_chiptop0_axi4_mem_0_bits_aw_bits_lock),
    .axi_aw_bits_cache (_chiptop0_axi4_mem_0_bits_aw_bits_cache),
    .axi_aw_bits_prot  (_chiptop0_axi4_mem_0_bits_aw_bits_prot),
    .axi_aw_bits_qos   (_chiptop0_axi4_mem_0_bits_aw_bits_qos),
    .axi_w_valid       (_chiptop0_axi4_mem_0_bits_w_valid),
    .axi_w_bits_data   (_chiptop0_axi4_mem_0_bits_w_bits_data),
    .axi_w_bits_strb   (_chiptop0_axi4_mem_0_bits_w_bits_strb),
    .axi_w_bits_last   (_chiptop0_axi4_mem_0_bits_w_bits_last),
    .axi_b_ready       (_chiptop0_axi4_mem_0_bits_b_ready),
    .axi_ar_valid      (_chiptop0_axi4_mem_0_bits_ar_valid),
    .axi_ar_bits_id    (_chiptop0_axi4_mem_0_bits_ar_bits_id),
    .axi_ar_bits_addr  (_chiptop0_axi4_mem_0_bits_ar_bits_addr),
    .axi_ar_bits_len   (_chiptop0_axi4_mem_0_bits_ar_bits_len),
    .axi_ar_bits_size  (_chiptop0_axi4_mem_0_bits_ar_bits_size),
    .axi_ar_bits_burst (_chiptop0_axi4_mem_0_bits_ar_bits_burst),
    .axi_ar_bits_lock  (_chiptop0_axi4_mem_0_bits_ar_bits_lock),
    .axi_ar_bits_cache (_chiptop0_axi4_mem_0_bits_ar_bits_cache),
    .axi_ar_bits_prot  (_chiptop0_axi4_mem_0_bits_ar_bits_prot),
    .axi_ar_bits_qos   (_chiptop0_axi4_mem_0_bits_ar_bits_qos),
    .axi_r_ready       (_chiptop0_axi4_mem_0_bits_r_ready),
    .axi_aw_ready      (_simdram_axi_aw_ready),
    .axi_w_ready       (_simdram_axi_w_ready),
    .axi_b_valid       (_simdram_axi_b_valid),
    .axi_b_bits_id     (_simdram_axi_b_bits_id),
    .axi_b_bits_resp   (_simdram_axi_b_bits_resp),
    .axi_ar_ready      (_simdram_axi_ar_ready),
    .axi_r_valid       (_simdram_axi_r_valid),
    .axi_r_bits_id     (_simdram_axi_r_bits_id),
    .axi_r_bits_data   (_simdram_axi_r_bits_data),
    .axi_r_bits_resp   (_simdram_axi_r_bits_resp),
    .axi_r_bits_last   (_simdram_axi_r_bits_last)
  );
  UARTAdapter uart_sim_0_uartno0 (
    .clock       (_source_1_clk),
    .reset       (_harnessBinderReset_catcher_io_sync_reset),
    .io_uart_txd (_chiptop0_uart_0_txd),
    .io_uart_rxd (_uart_sim_0_uartno0_io_uart_rxd)
  );
  ResetCatchAndSync_d3 harnessBinderReset_catcher (
    .clock         (_source_1_clk),
    .reset         (reset),
    .io_sync_reset (_harnessBinderReset_catcher_io_sync_reset)
  );
  ClockSourceAtFreqMHz #(
    .PERIOD(2.000000e+00)
  ) source (
    .power (1'h1),
    .gate  (1'h0),
    .clk   (_source_clk)
  );
  ClockSourceAtFreqMHz #(
    .PERIOD(1.000000e+01)
  ) source_1 (
    .power (1'h1),
    .gate  (1'h0),
    .clk   (_source_1_clk)
  );
  assign io_success = _success_exit_sim_exit == 32'h1 | _jtag_exit == 32'h1;
endmodule

