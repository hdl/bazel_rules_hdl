// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ChipTop(
  input         serial_tl_clock,
                serial_tl_bits_in_valid,
  input  [31:0] serial_tl_bits_in_bits,
  input         serial_tl_bits_out_ready,
                custom_boot,
                reset_io,
                clock_uncore_clock,
                axi4_mem_0_bits_aw_ready,
                axi4_mem_0_bits_w_ready,
                axi4_mem_0_bits_b_valid,
  input  [3:0]  axi4_mem_0_bits_b_bits_id,
  input  [1:0]  axi4_mem_0_bits_b_bits_resp,
  input         axi4_mem_0_bits_ar_ready,
                axi4_mem_0_bits_r_valid,
  input  [3:0]  axi4_mem_0_bits_r_bits_id,
  input  [63:0] axi4_mem_0_bits_r_bits_data,
  input  [1:0]  axi4_mem_0_bits_r_bits_resp,
  input         axi4_mem_0_bits_r_bits_last,
                jtag_TCK,
                jtag_TMS,
                jtag_TDI,
                uart_0_rxd,
  output        serial_tl_bits_in_ready,
                serial_tl_bits_out_valid,
  output [31:0] serial_tl_bits_out_bits,
  output        axi4_mem_0_clock,
                axi4_mem_0_reset,
                axi4_mem_0_bits_aw_valid,
  output [3:0]  axi4_mem_0_bits_aw_bits_id,
  output [31:0] axi4_mem_0_bits_aw_bits_addr,
  output [7:0]  axi4_mem_0_bits_aw_bits_len,
  output [2:0]  axi4_mem_0_bits_aw_bits_size,
  output [1:0]  axi4_mem_0_bits_aw_bits_burst,
  output        axi4_mem_0_bits_aw_bits_lock,
  output [3:0]  axi4_mem_0_bits_aw_bits_cache,
  output [2:0]  axi4_mem_0_bits_aw_bits_prot,
  output [3:0]  axi4_mem_0_bits_aw_bits_qos,
  output        axi4_mem_0_bits_w_valid,
  output [63:0] axi4_mem_0_bits_w_bits_data,
  output [7:0]  axi4_mem_0_bits_w_bits_strb,
  output        axi4_mem_0_bits_w_bits_last,
                axi4_mem_0_bits_b_ready,
                axi4_mem_0_bits_ar_valid,
  output [3:0]  axi4_mem_0_bits_ar_bits_id,
  output [31:0] axi4_mem_0_bits_ar_bits_addr,
  output [7:0]  axi4_mem_0_bits_ar_bits_len,
  output [2:0]  axi4_mem_0_bits_ar_bits_size,
  output [1:0]  axi4_mem_0_bits_ar_bits_burst,
  output        axi4_mem_0_bits_ar_bits_lock,
  output [3:0]  axi4_mem_0_bits_ar_bits_cache,
  output [2:0]  axi4_mem_0_bits_ar_bits_prot,
  output [3:0]  axi4_mem_0_bits_ar_bits_qos,
  output        axi4_mem_0_bits_r_ready,
                jtag_TDO,
                uart_0_txd
);

  wire        _iocell_uart_0_rxd_i;
  wire        _iocell_jtag_TCK_i;
  wire        _iocell_jtag_TMS_i;
  wire        _iocell_jtag_TDI_i;
  wire        _gated_clock_debug_clock_gate_out;
  wire        _dmactiveAck_dmactiveAck_io_q;
  wire        _debug_reset_syncd_debug_reset_sync_io_q;
  wire        _system_debug_systemjtag_reset_catcher_io_sync_reset;
  wire        _iocell_custom_boot_i;
  wire        _iocell_serial_tl_clock_i;
  wire        _iocell_serial_tl_bits_in_valid_i;
  wire        _iocell_serial_tl_bits_in_bits_31_i;
  wire        _iocell_serial_tl_bits_in_bits_30_i;
  wire        _iocell_serial_tl_bits_in_bits_29_i;
  wire        _iocell_serial_tl_bits_in_bits_28_i;
  wire        _iocell_serial_tl_bits_in_bits_27_i;
  wire        _iocell_serial_tl_bits_in_bits_26_i;
  wire        _iocell_serial_tl_bits_in_bits_25_i;
  wire        _iocell_serial_tl_bits_in_bits_24_i;
  wire        _iocell_serial_tl_bits_in_bits_23_i;
  wire        _iocell_serial_tl_bits_in_bits_22_i;
  wire        _iocell_serial_tl_bits_in_bits_21_i;
  wire        _iocell_serial_tl_bits_in_bits_20_i;
  wire        _iocell_serial_tl_bits_in_bits_19_i;
  wire        _iocell_serial_tl_bits_in_bits_18_i;
  wire        _iocell_serial_tl_bits_in_bits_17_i;
  wire        _iocell_serial_tl_bits_in_bits_16_i;
  wire        _iocell_serial_tl_bits_in_bits_15_i;
  wire        _iocell_serial_tl_bits_in_bits_14_i;
  wire        _iocell_serial_tl_bits_in_bits_13_i;
  wire        _iocell_serial_tl_bits_in_bits_12_i;
  wire        _iocell_serial_tl_bits_in_bits_11_i;
  wire        _iocell_serial_tl_bits_in_bits_10_i;
  wire        _iocell_serial_tl_bits_in_bits_9_i;
  wire        _iocell_serial_tl_bits_in_bits_8_i;
  wire        _iocell_serial_tl_bits_in_bits_7_i;
  wire        _iocell_serial_tl_bits_in_bits_6_i;
  wire        _iocell_serial_tl_bits_in_bits_5_i;
  wire        _iocell_serial_tl_bits_in_bits_4_i;
  wire        _iocell_serial_tl_bits_in_bits_3_i;
  wire        _iocell_serial_tl_bits_in_bits_2_i;
  wire        _iocell_serial_tl_bits_in_bits_1_i;
  wire        _iocell_serial_tl_bits_in_bits_i;
  wire        _iocell_serial_tl_bits_out_ready_i;
  wire        _iocell_serial_tl_bits_out_bits_31_pad;
  wire        _iocell_serial_tl_bits_out_bits_30_pad;
  wire        _iocell_serial_tl_bits_out_bits_29_pad;
  wire        _iocell_serial_tl_bits_out_bits_28_pad;
  wire        _iocell_serial_tl_bits_out_bits_27_pad;
  wire        _iocell_serial_tl_bits_out_bits_26_pad;
  wire        _iocell_serial_tl_bits_out_bits_25_pad;
  wire        _iocell_serial_tl_bits_out_bits_24_pad;
  wire        _iocell_serial_tl_bits_out_bits_23_pad;
  wire        _iocell_serial_tl_bits_out_bits_22_pad;
  wire        _iocell_serial_tl_bits_out_bits_21_pad;
  wire        _iocell_serial_tl_bits_out_bits_20_pad;
  wire        _iocell_serial_tl_bits_out_bits_19_pad;
  wire        _iocell_serial_tl_bits_out_bits_18_pad;
  wire        _iocell_serial_tl_bits_out_bits_17_pad;
  wire        _iocell_serial_tl_bits_out_bits_16_pad;
  wire        _iocell_serial_tl_bits_out_bits_15_pad;
  wire        _iocell_serial_tl_bits_out_bits_14_pad;
  wire        _iocell_serial_tl_bits_out_bits_13_pad;
  wire        _iocell_serial_tl_bits_out_bits_12_pad;
  wire        _iocell_serial_tl_bits_out_bits_11_pad;
  wire        _iocell_serial_tl_bits_out_bits_10_pad;
  wire        _iocell_serial_tl_bits_out_bits_9_pad;
  wire        _iocell_serial_tl_bits_out_bits_8_pad;
  wire        _iocell_serial_tl_bits_out_bits_7_pad;
  wire        _iocell_serial_tl_bits_out_bits_6_pad;
  wire        _iocell_serial_tl_bits_out_bits_5_pad;
  wire        _iocell_serial_tl_bits_out_bits_4_pad;
  wire        _iocell_serial_tl_bits_out_bits_3_pad;
  wire        _iocell_serial_tl_bits_out_bits_2_pad;
  wire        _iocell_serial_tl_bits_out_bits_1_pad;
  wire        _iocell_serial_tl_bits_out_bits_pad;
  wire        _system_auto_implicitClockGrouper_out_clock;
  wire        _system_auto_implicitClockGrouper_out_reset;
  wire        _system_auto_subsystem_cbus_fixedClockNode_out_clock;
  wire        _system_auto_subsystem_cbus_fixedClockNode_out_reset;
  wire        _system_debug_systemjtag_jtag_TDO_data;
  wire        _system_debug_dmactive;
  wire        _system_serial_tl_bits_in_ready;
  wire        _system_serial_tl_bits_out_valid;
  wire [31:0] _system_serial_tl_bits_out_bits;
  wire        _system_uart_0_txd;
  wire        debug_reset = ~_debug_reset_syncd_debug_reset_sync_io_q;
  reg         clock_en;
  always @(posedge _system_auto_subsystem_cbus_fixedClockNode_out_clock or posedge debug_reset) begin
    if (debug_reset)
      clock_en <= 1'h1;
    else
      clock_en <= _dmactiveAck_dmactiveAck_io_q;
  end // always @(posedge, posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      if (debug_reset)
        clock_en = 1'h1;
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  DigitalTop system (
    .clock                                                                     (_system_auto_implicitClockGrouper_out_clock),
    .reset                                                                     (_system_auto_implicitClockGrouper_out_reset),
    .auto_prci_ctrl_domain_reset_setter_clock_in_member_allClocks_uncore_clock (clock_uncore_clock),
    .auto_prci_ctrl_domain_reset_setter_clock_in_member_allClocks_uncore_reset (reset_io),
    .resetctrl_hartIsInReset_0                                                 (_system_auto_subsystem_cbus_fixedClockNode_out_reset),
    .debug_clock                                                               (_gated_clock_debug_clock_gate_out),
    .debug_reset                                                               (debug_reset),
    .debug_systemjtag_jtag_TCK                                                 (_iocell_jtag_TCK_i),
    .debug_systemjtag_jtag_TMS                                                 (_iocell_jtag_TMS_i),
    .debug_systemjtag_jtag_TDI                                                 (_iocell_jtag_TDI_i),
    .debug_systemjtag_reset                                                    (_system_debug_systemjtag_reset_catcher_io_sync_reset),
    .debug_dmactiveAck                                                         (_dmactiveAck_dmactiveAck_io_q),
    .mem_axi4_0_aw_ready                                                       (axi4_mem_0_bits_aw_ready),
    .mem_axi4_0_w_ready                                                        (axi4_mem_0_bits_w_ready),
    .mem_axi4_0_b_valid                                                        (axi4_mem_0_bits_b_valid),
    .mem_axi4_0_b_bits_id                                                      (axi4_mem_0_bits_b_bits_id),
    .mem_axi4_0_b_bits_resp                                                    (axi4_mem_0_bits_b_bits_resp),
    .mem_axi4_0_ar_ready                                                       (axi4_mem_0_bits_ar_ready),
    .mem_axi4_0_r_valid                                                        (axi4_mem_0_bits_r_valid),
    .mem_axi4_0_r_bits_id                                                      (axi4_mem_0_bits_r_bits_id),
    .mem_axi4_0_r_bits_data                                                    (axi4_mem_0_bits_r_bits_data),
    .mem_axi4_0_r_bits_resp                                                    (axi4_mem_0_bits_r_bits_resp),
    .mem_axi4_0_r_bits_last                                                    (axi4_mem_0_bits_r_bits_last),
    .custom_boot                                                               (_iocell_custom_boot_i),
    .serial_tl_clock                                                           (_iocell_serial_tl_clock_i),
    .serial_tl_bits_in_valid                                                   (_iocell_serial_tl_bits_in_valid_i),
    .serial_tl_bits_in_bits                                                    ({_iocell_serial_tl_bits_in_bits_31_i, _iocell_serial_tl_bits_in_bits_30_i, _iocell_serial_tl_bits_in_bits_29_i, _iocell_serial_tl_bits_in_bits_28_i, _iocell_serial_tl_bits_in_bits_27_i, _iocell_serial_tl_bits_in_bits_26_i, _iocell_serial_tl_bits_in_bits_25_i, _iocell_serial_tl_bits_in_bits_24_i, _iocell_serial_tl_bits_in_bits_23_i, _iocell_serial_tl_bits_in_bits_22_i, _iocell_serial_tl_bits_in_bits_21_i, _iocell_serial_tl_bits_in_bits_20_i, _iocell_serial_tl_bits_in_bits_19_i, _iocell_serial_tl_bits_in_bits_18_i, _iocell_serial_tl_bits_in_bits_17_i, _iocell_serial_tl_bits_in_bits_16_i, _iocell_serial_tl_bits_in_bits_15_i, _iocell_serial_tl_bits_in_bits_14_i, _iocell_serial_tl_bits_in_bits_13_i, _iocell_serial_tl_bits_in_bits_12_i, _iocell_serial_tl_bits_in_bits_11_i, _iocell_serial_tl_bits_in_bits_10_i, _iocell_serial_tl_bits_in_bits_9_i, _iocell_serial_tl_bits_in_bits_8_i, _iocell_serial_tl_bits_in_bits_7_i, _iocell_serial_tl_bits_in_bits_6_i, _iocell_serial_tl_bits_in_bits_5_i, _iocell_serial_tl_bits_in_bits_4_i, _iocell_serial_tl_bits_in_bits_3_i, _iocell_serial_tl_bits_in_bits_2_i, _iocell_serial_tl_bits_in_bits_1_i, _iocell_serial_tl_bits_in_bits_i}),
    .serial_tl_bits_out_ready                                                  (_iocell_serial_tl_bits_out_ready_i),
    .uart_0_rxd                                                                (_iocell_uart_0_rxd_i),
    .auto_implicitClockGrouper_out_clock                                       (_system_auto_implicitClockGrouper_out_clock),
    .auto_implicitClockGrouper_out_reset                                       (_system_auto_implicitClockGrouper_out_reset),
    .auto_subsystem_mbus_fixedClockNode_out_clock                              (axi4_mem_0_clock),
    .auto_subsystem_mbus_fixedClockNode_out_reset                              (axi4_mem_0_reset),
    .auto_subsystem_cbus_fixedClockNode_out_clock                              (_system_auto_subsystem_cbus_fixedClockNode_out_clock),
    .auto_subsystem_cbus_fixedClockNode_out_reset                              (_system_auto_subsystem_cbus_fixedClockNode_out_reset),
    .debug_systemjtag_jtag_TDO_data                                            (_system_debug_systemjtag_jtag_TDO_data),
    .debug_dmactive                                                            (_system_debug_dmactive),
    .mem_axi4_0_aw_valid                                                       (axi4_mem_0_bits_aw_valid),
    .mem_axi4_0_aw_bits_id                                                     (axi4_mem_0_bits_aw_bits_id),
    .mem_axi4_0_aw_bits_addr                                                   (axi4_mem_0_bits_aw_bits_addr),
    .mem_axi4_0_aw_bits_len                                                    (axi4_mem_0_bits_aw_bits_len),
    .mem_axi4_0_aw_bits_size                                                   (axi4_mem_0_bits_aw_bits_size),
    .mem_axi4_0_aw_bits_burst                                                  (axi4_mem_0_bits_aw_bits_burst),
    .mem_axi4_0_aw_bits_lock                                                   (axi4_mem_0_bits_aw_bits_lock),
    .mem_axi4_0_aw_bits_cache                                                  (axi4_mem_0_bits_aw_bits_cache),
    .mem_axi4_0_aw_bits_prot                                                   (axi4_mem_0_bits_aw_bits_prot),
    .mem_axi4_0_aw_bits_qos                                                    (axi4_mem_0_bits_aw_bits_qos),
    .mem_axi4_0_w_valid                                                        (axi4_mem_0_bits_w_valid),
    .mem_axi4_0_w_bits_data                                                    (axi4_mem_0_bits_w_bits_data),
    .mem_axi4_0_w_bits_strb                                                    (axi4_mem_0_bits_w_bits_strb),
    .mem_axi4_0_w_bits_last                                                    (axi4_mem_0_bits_w_bits_last),
    .mem_axi4_0_b_ready                                                        (axi4_mem_0_bits_b_ready),
    .mem_axi4_0_ar_valid                                                       (axi4_mem_0_bits_ar_valid),
    .mem_axi4_0_ar_bits_id                                                     (axi4_mem_0_bits_ar_bits_id),
    .mem_axi4_0_ar_bits_addr                                                   (axi4_mem_0_bits_ar_bits_addr),
    .mem_axi4_0_ar_bits_len                                                    (axi4_mem_0_bits_ar_bits_len),
    .mem_axi4_0_ar_bits_size                                                   (axi4_mem_0_bits_ar_bits_size),
    .mem_axi4_0_ar_bits_burst                                                  (axi4_mem_0_bits_ar_bits_burst),
    .mem_axi4_0_ar_bits_lock                                                   (axi4_mem_0_bits_ar_bits_lock),
    .mem_axi4_0_ar_bits_cache                                                  (axi4_mem_0_bits_ar_bits_cache),
    .mem_axi4_0_ar_bits_prot                                                   (axi4_mem_0_bits_ar_bits_prot),
    .mem_axi4_0_ar_bits_qos                                                    (axi4_mem_0_bits_ar_bits_qos),
    .mem_axi4_0_r_ready                                                        (axi4_mem_0_bits_r_ready),
    .serial_tl_bits_in_ready                                                   (_system_serial_tl_bits_in_ready),
    .serial_tl_bits_out_valid                                                  (_system_serial_tl_bits_out_valid),
    .serial_tl_bits_out_bits                                                   (_system_serial_tl_bits_out_bits),
    .uart_0_txd                                                                (_system_uart_0_txd)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits (
    .o   (_system_serial_tl_bits_out_bits[0]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_1 (
    .o   (_system_serial_tl_bits_out_bits[1]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_1_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_2 (
    .o   (_system_serial_tl_bits_out_bits[2]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_2_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_3 (
    .o   (_system_serial_tl_bits_out_bits[3]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_3_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_4 (
    .o   (_system_serial_tl_bits_out_bits[4]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_4_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_5 (
    .o   (_system_serial_tl_bits_out_bits[5]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_5_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_6 (
    .o   (_system_serial_tl_bits_out_bits[6]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_6_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_7 (
    .o   (_system_serial_tl_bits_out_bits[7]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_7_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_8 (
    .o   (_system_serial_tl_bits_out_bits[8]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_8_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_9 (
    .o   (_system_serial_tl_bits_out_bits[9]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_9_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_10 (
    .o   (_system_serial_tl_bits_out_bits[10]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_10_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_11 (
    .o   (_system_serial_tl_bits_out_bits[11]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_11_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_12 (
    .o   (_system_serial_tl_bits_out_bits[12]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_12_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_13 (
    .o   (_system_serial_tl_bits_out_bits[13]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_13_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_14 (
    .o   (_system_serial_tl_bits_out_bits[14]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_14_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_15 (
    .o   (_system_serial_tl_bits_out_bits[15]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_15_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_16 (
    .o   (_system_serial_tl_bits_out_bits[16]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_16_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_17 (
    .o   (_system_serial_tl_bits_out_bits[17]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_17_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_18 (
    .o   (_system_serial_tl_bits_out_bits[18]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_18_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_19 (
    .o   (_system_serial_tl_bits_out_bits[19]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_19_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_20 (
    .o   (_system_serial_tl_bits_out_bits[20]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_20_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_21 (
    .o   (_system_serial_tl_bits_out_bits[21]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_21_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_22 (
    .o   (_system_serial_tl_bits_out_bits[22]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_22_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_23 (
    .o   (_system_serial_tl_bits_out_bits[23]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_23_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_24 (
    .o   (_system_serial_tl_bits_out_bits[24]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_24_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_25 (
    .o   (_system_serial_tl_bits_out_bits[25]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_25_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_26 (
    .o   (_system_serial_tl_bits_out_bits[26]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_26_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_27 (
    .o   (_system_serial_tl_bits_out_bits[27]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_27_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_28 (
    .o   (_system_serial_tl_bits_out_bits[28]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_28_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_29 (
    .o   (_system_serial_tl_bits_out_bits[29]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_29_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_30 (
    .o   (_system_serial_tl_bits_out_bits[30]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_30_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_31 (
    .o   (_system_serial_tl_bits_out_bits[31]),
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_31_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_valid (
    .o   (_system_serial_tl_bits_out_valid),
    .oe  (1'h1),
    .pad (serial_tl_bits_out_valid)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_out_ready (
    .pad (serial_tl_bits_out_ready),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_out_ready_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits (
    .pad (serial_tl_bits_in_bits[0]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_1 (
    .pad (serial_tl_bits_in_bits[1]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_1_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_2 (
    .pad (serial_tl_bits_in_bits[2]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_2_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_3 (
    .pad (serial_tl_bits_in_bits[3]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_3_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_4 (
    .pad (serial_tl_bits_in_bits[4]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_4_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_5 (
    .pad (serial_tl_bits_in_bits[5]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_5_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_6 (
    .pad (serial_tl_bits_in_bits[6]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_6_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_7 (
    .pad (serial_tl_bits_in_bits[7]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_7_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_8 (
    .pad (serial_tl_bits_in_bits[8]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_8_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_9 (
    .pad (serial_tl_bits_in_bits[9]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_9_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_10 (
    .pad (serial_tl_bits_in_bits[10]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_10_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_11 (
    .pad (serial_tl_bits_in_bits[11]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_11_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_12 (
    .pad (serial_tl_bits_in_bits[12]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_12_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_13 (
    .pad (serial_tl_bits_in_bits[13]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_13_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_14 (
    .pad (serial_tl_bits_in_bits[14]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_14_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_15 (
    .pad (serial_tl_bits_in_bits[15]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_15_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_16 (
    .pad (serial_tl_bits_in_bits[16]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_16_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_17 (
    .pad (serial_tl_bits_in_bits[17]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_17_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_18 (
    .pad (serial_tl_bits_in_bits[18]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_18_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_19 (
    .pad (serial_tl_bits_in_bits[19]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_19_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_20 (
    .pad (serial_tl_bits_in_bits[20]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_20_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_21 (
    .pad (serial_tl_bits_in_bits[21]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_21_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_22 (
    .pad (serial_tl_bits_in_bits[22]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_22_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_23 (
    .pad (serial_tl_bits_in_bits[23]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_23_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_24 (
    .pad (serial_tl_bits_in_bits[24]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_24_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_25 (
    .pad (serial_tl_bits_in_bits[25]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_25_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_26 (
    .pad (serial_tl_bits_in_bits[26]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_26_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_27 (
    .pad (serial_tl_bits_in_bits[27]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_27_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_28 (
    .pad (serial_tl_bits_in_bits[28]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_28_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_29 (
    .pad (serial_tl_bits_in_bits[29]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_29_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_30 (
    .pad (serial_tl_bits_in_bits[30]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_30_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_31 (
    .pad (serial_tl_bits_in_bits[31]),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_31_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_valid (
    .pad (serial_tl_bits_in_valid),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_valid_i)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_in_ready (
    .o   (_system_serial_tl_bits_in_ready),
    .oe  (1'h1),
    .pad (serial_tl_bits_in_ready)
  );
  GenericDigitalInIOCell iocell_serial_tl_clock (
    .pad (serial_tl_clock),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_clock_i)
  );
  GenericDigitalInIOCell iocell_custom_boot (
    .pad (custom_boot),
    .ie  (1'h1),
    .i   (_iocell_custom_boot_i)
  );
  ResetCatchAndSync_d3 system_debug_systemjtag_reset_catcher (
    .clock         (_iocell_jtag_TCK_i),
    .reset         (_system_auto_subsystem_cbus_fixedClockNode_out_reset),
    .io_sync_reset (_system_debug_systemjtag_reset_catcher_io_sync_reset)
  );
  AsyncResetSynchronizerShiftReg_w1_d3_i0 debug_reset_syncd_debug_reset_sync (
    .clock (_system_auto_subsystem_cbus_fixedClockNode_out_clock),
    .reset (_system_debug_systemjtag_reset_catcher_io_sync_reset),
    .io_d  (1'h1),
    .io_q  (_debug_reset_syncd_debug_reset_sync_io_q)
  );
  ResetSynchronizerShiftReg_w1_d3_i0 dmactiveAck_dmactiveAck (
    .clock (_system_auto_subsystem_cbus_fixedClockNode_out_clock),
    .reset (debug_reset),
    .io_d  (_system_debug_dmactive),
    .io_q  (_dmactiveAck_dmactiveAck_io_q)
  );
  EICG_wrapper gated_clock_debug_clock_gate (
    .in      (_system_auto_subsystem_cbus_fixedClockNode_out_clock),
    .test_en (1'h0),
    .en      (clock_en),
    .out     (_gated_clock_debug_clock_gate_out)
  );
  GenericDigitalOutIOCell iocell_jtag_TDO (
    .o   (_system_debug_systemjtag_jtag_TDO_data),
    .oe  (1'h1),
    .pad (jtag_TDO)
  );
  GenericDigitalInIOCell iocell_jtag_TDI (
    .pad (jtag_TDI),
    .ie  (1'h1),
    .i   (_iocell_jtag_TDI_i)
  );
  GenericDigitalInIOCell iocell_jtag_TMS (
    .pad (jtag_TMS),
    .ie  (1'h1),
    .i   (_iocell_jtag_TMS_i)
  );
  GenericDigitalInIOCell iocell_jtag_TCK (
    .pad (jtag_TCK),
    .ie  (1'h1),
    .i   (_iocell_jtag_TCK_i)
  );
  GenericDigitalInIOCell iocell_uart_0_rxd (
    .pad (uart_0_rxd),
    .ie  (1'h1),
    .i   (_iocell_uart_0_rxd_i)
  );
  GenericDigitalOutIOCell iocell_uart_0_txd (
    .o   (_system_uart_0_txd),
    .oe  (1'h1),
    .pad (uart_0_txd)
  );
  assign serial_tl_bits_out_bits = {_iocell_serial_tl_bits_out_bits_31_pad, _iocell_serial_tl_bits_out_bits_30_pad, _iocell_serial_tl_bits_out_bits_29_pad, _iocell_serial_tl_bits_out_bits_28_pad, _iocell_serial_tl_bits_out_bits_27_pad, _iocell_serial_tl_bits_out_bits_26_pad, _iocell_serial_tl_bits_out_bits_25_pad, _iocell_serial_tl_bits_out_bits_24_pad, _iocell_serial_tl_bits_out_bits_23_pad, _iocell_serial_tl_bits_out_bits_22_pad, _iocell_serial_tl_bits_out_bits_21_pad, _iocell_serial_tl_bits_out_bits_20_pad, _iocell_serial_tl_bits_out_bits_19_pad, _iocell_serial_tl_bits_out_bits_18_pad, _iocell_serial_tl_bits_out_bits_17_pad, _iocell_serial_tl_bits_out_bits_16_pad, _iocell_serial_tl_bits_out_bits_15_pad, _iocell_serial_tl_bits_out_bits_14_pad, _iocell_serial_tl_bits_out_bits_13_pad, _iocell_serial_tl_bits_out_bits_12_pad, _iocell_serial_tl_bits_out_bits_11_pad, _iocell_serial_tl_bits_out_bits_10_pad, _iocell_serial_tl_bits_out_bits_9_pad, _iocell_serial_tl_bits_out_bits_8_pad, _iocell_serial_tl_bits_out_bits_7_pad, _iocell_serial_tl_bits_out_bits_6_pad, _iocell_serial_tl_bits_out_bits_5_pad, _iocell_serial_tl_bits_out_bits_4_pad, _iocell_serial_tl_bits_out_bits_3_pad, _iocell_serial_tl_bits_out_bits_2_pad, _iocell_serial_tl_bits_out_bits_1_pad, _iocell_serial_tl_bits_out_bits_pad};
endmodule

