// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module PeripheryBus(
  input         auto_coupler_to_device_named_uart_0_control_xing_out_a_ready,
                auto_coupler_to_device_named_uart_0_control_xing_out_d_valid,
  input  [2:0]  auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_opcode,
  input  [1:0]  auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_size,
  input  [10:0] auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_source,
  input  [63:0] auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_data,
  input         auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock,
                auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset,
                auto_bus_xing_in_a_valid,
  input  [2:0]  auto_bus_xing_in_a_bits_opcode,
                auto_bus_xing_in_a_bits_param,
                auto_bus_xing_in_a_bits_size,
  input  [6:0]  auto_bus_xing_in_a_bits_source,
  input  [28:0] auto_bus_xing_in_a_bits_address,
  input  [7:0]  auto_bus_xing_in_a_bits_mask,
  input  [63:0] auto_bus_xing_in_a_bits_data,
  input         auto_bus_xing_in_a_bits_corrupt,
                auto_bus_xing_in_d_ready,
  output        auto_coupler_to_device_named_uart_0_control_xing_out_a_valid,
  output [2:0]  auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_opcode,
                auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_param,
  output [1:0]  auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_size,
  output [10:0] auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_source,
  output [28:0] auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_address,
  output [7:0]  auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_mask,
  output [63:0] auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_data,
  output        auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_corrupt,
                auto_coupler_to_device_named_uart_0_control_xing_out_d_ready,
                auto_fixedClockNode_out_clock,
                auto_fixedClockNode_out_reset,
                auto_bus_xing_in_a_ready,
                auto_bus_xing_in_d_valid,
  output [2:0]  auto_bus_xing_in_d_bits_opcode,
  output [1:0]  auto_bus_xing_in_d_bits_param,
  output [2:0]  auto_bus_xing_in_d_bits_size,
  output [6:0]  auto_bus_xing_in_d_bits_source,
  output        auto_bus_xing_in_d_bits_sink,
                auto_bus_xing_in_d_bits_denied,
  output [63:0] auto_bus_xing_in_d_bits_data,
  output        auto_bus_xing_in_d_bits_corrupt,
                clock,
                reset
);

  wire        _coupler_to_device_named_uart_0_auto_tl_in_a_ready;
  wire        _coupler_to_device_named_uart_0_auto_tl_in_d_valid;
  wire [2:0]  _coupler_to_device_named_uart_0_auto_tl_in_d_bits_opcode;
  wire [2:0]  _coupler_to_device_named_uart_0_auto_tl_in_d_bits_size;
  wire [6:0]  _coupler_to_device_named_uart_0_auto_tl_in_d_bits_source;
  wire [63:0] _coupler_to_device_named_uart_0_auto_tl_in_d_bits_data;
  wire        _coupler_to_bootaddressreg_auto_fragmenter_out_a_valid;
  wire [2:0]  _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_opcode;
  wire [2:0]  _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_param;
  wire [1:0]  _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_size;
  wire [10:0] _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_source;
  wire [14:0] _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_address;
  wire [7:0]  _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_mask;
  wire [63:0] _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_data;
  wire        _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_corrupt;
  wire        _coupler_to_bootaddressreg_auto_fragmenter_out_d_ready;
  wire        _coupler_to_bootaddressreg_auto_tl_in_a_ready;
  wire        _coupler_to_bootaddressreg_auto_tl_in_d_valid;
  wire [2:0]  _coupler_to_bootaddressreg_auto_tl_in_d_bits_opcode;
  wire [2:0]  _coupler_to_bootaddressreg_auto_tl_in_d_bits_size;
  wire [6:0]  _coupler_to_bootaddressreg_auto_tl_in_d_bits_source;
  wire [63:0] _coupler_to_bootaddressreg_auto_tl_in_d_bits_data;
  wire        _buffer_1_auto_out_a_valid;
  wire [2:0]  _buffer_1_auto_out_a_bits_opcode;
  wire [2:0]  _buffer_1_auto_out_a_bits_param;
  wire [2:0]  _buffer_1_auto_out_a_bits_size;
  wire [6:0]  _buffer_1_auto_out_a_bits_source;
  wire [28:0] _buffer_1_auto_out_a_bits_address;
  wire [7:0]  _buffer_1_auto_out_a_bits_mask;
  wire [63:0] _buffer_1_auto_out_a_bits_data;
  wire        _buffer_1_auto_out_a_bits_corrupt;
  wire        _buffer_1_auto_out_d_ready;
  wire        _atomics_auto_in_a_ready;
  wire        _atomics_auto_in_d_valid;
  wire [2:0]  _atomics_auto_in_d_bits_opcode;
  wire [1:0]  _atomics_auto_in_d_bits_param;
  wire [2:0]  _atomics_auto_in_d_bits_size;
  wire [6:0]  _atomics_auto_in_d_bits_source;
  wire        _atomics_auto_in_d_bits_sink;
  wire        _atomics_auto_in_d_bits_denied;
  wire [63:0] _atomics_auto_in_d_bits_data;
  wire        _atomics_auto_in_d_bits_corrupt;
  wire        _atomics_auto_out_a_valid;
  wire [2:0]  _atomics_auto_out_a_bits_opcode;
  wire [2:0]  _atomics_auto_out_a_bits_param;
  wire [2:0]  _atomics_auto_out_a_bits_size;
  wire [6:0]  _atomics_auto_out_a_bits_source;
  wire [28:0] _atomics_auto_out_a_bits_address;
  wire [7:0]  _atomics_auto_out_a_bits_mask;
  wire [63:0] _atomics_auto_out_a_bits_data;
  wire        _atomics_auto_out_a_bits_corrupt;
  wire        _atomics_auto_out_d_ready;
  wire        _buffer_auto_in_a_ready;
  wire        _buffer_auto_in_d_valid;
  wire [2:0]  _buffer_auto_in_d_bits_opcode;
  wire [1:0]  _buffer_auto_in_d_bits_param;
  wire [2:0]  _buffer_auto_in_d_bits_size;
  wire [6:0]  _buffer_auto_in_d_bits_source;
  wire        _buffer_auto_in_d_bits_sink;
  wire        _buffer_auto_in_d_bits_denied;
  wire [63:0] _buffer_auto_in_d_bits_data;
  wire        _buffer_auto_in_d_bits_corrupt;
  wire        _buffer_auto_out_a_valid;
  wire [2:0]  _buffer_auto_out_a_bits_opcode;
  wire [2:0]  _buffer_auto_out_a_bits_param;
  wire [2:0]  _buffer_auto_out_a_bits_size;
  wire [6:0]  _buffer_auto_out_a_bits_source;
  wire [28:0] _buffer_auto_out_a_bits_address;
  wire [7:0]  _buffer_auto_out_a_bits_mask;
  wire [63:0] _buffer_auto_out_a_bits_data;
  wire        _buffer_auto_out_a_bits_corrupt;
  wire        _buffer_auto_out_d_ready;
  wire        _out_xbar_auto_in_a_ready;
  wire        _out_xbar_auto_in_d_valid;
  wire [2:0]  _out_xbar_auto_in_d_bits_opcode;
  wire [2:0]  _out_xbar_auto_in_d_bits_size;
  wire [6:0]  _out_xbar_auto_in_d_bits_source;
  wire [63:0] _out_xbar_auto_in_d_bits_data;
  wire        _out_xbar_auto_out_1_a_valid;
  wire [2:0]  _out_xbar_auto_out_1_a_bits_opcode;
  wire [2:0]  _out_xbar_auto_out_1_a_bits_param;
  wire [2:0]  _out_xbar_auto_out_1_a_bits_size;
  wire [6:0]  _out_xbar_auto_out_1_a_bits_source;
  wire [28:0] _out_xbar_auto_out_1_a_bits_address;
  wire [7:0]  _out_xbar_auto_out_1_a_bits_mask;
  wire [63:0] _out_xbar_auto_out_1_a_bits_data;
  wire        _out_xbar_auto_out_1_a_bits_corrupt;
  wire        _out_xbar_auto_out_1_d_ready;
  wire        _out_xbar_auto_out_0_a_valid;
  wire [2:0]  _out_xbar_auto_out_0_a_bits_opcode;
  wire [2:0]  _out_xbar_auto_out_0_a_bits_param;
  wire [2:0]  _out_xbar_auto_out_0_a_bits_size;
  wire [6:0]  _out_xbar_auto_out_0_a_bits_source;
  wire [14:0] _out_xbar_auto_out_0_a_bits_address;
  wire [7:0]  _out_xbar_auto_out_0_a_bits_mask;
  wire [63:0] _out_xbar_auto_out_0_a_bits_data;
  wire        _out_xbar_auto_out_0_a_bits_corrupt;
  wire        _out_xbar_auto_out_0_d_ready;
  wire        _in_xbar_auto_in_a_ready;
  wire        _in_xbar_auto_in_d_valid;
  wire [2:0]  _in_xbar_auto_in_d_bits_opcode;
  wire [1:0]  _in_xbar_auto_in_d_bits_param;
  wire [2:0]  _in_xbar_auto_in_d_bits_size;
  wire [6:0]  _in_xbar_auto_in_d_bits_source;
  wire        _in_xbar_auto_in_d_bits_sink;
  wire        _in_xbar_auto_in_d_bits_denied;
  wire [63:0] _in_xbar_auto_in_d_bits_data;
  wire        _in_xbar_auto_in_d_bits_corrupt;
  wire        _in_xbar_auto_out_a_valid;
  wire [2:0]  _in_xbar_auto_out_a_bits_opcode;
  wire [2:0]  _in_xbar_auto_out_a_bits_param;
  wire [2:0]  _in_xbar_auto_out_a_bits_size;
  wire [6:0]  _in_xbar_auto_out_a_bits_source;
  wire [28:0] _in_xbar_auto_out_a_bits_address;
  wire [7:0]  _in_xbar_auto_out_a_bits_mask;
  wire [63:0] _in_xbar_auto_out_a_bits_data;
  wire        _in_xbar_auto_out_a_bits_corrupt;
  wire        _in_xbar_auto_out_d_ready;
  wire        _fixer_auto_in_a_ready;
  wire        _fixer_auto_in_d_valid;
  wire [2:0]  _fixer_auto_in_d_bits_opcode;
  wire [2:0]  _fixer_auto_in_d_bits_size;
  wire [6:0]  _fixer_auto_in_d_bits_source;
  wire [63:0] _fixer_auto_in_d_bits_data;
  wire        _fixer_auto_out_a_valid;
  wire [2:0]  _fixer_auto_out_a_bits_opcode;
  wire [2:0]  _fixer_auto_out_a_bits_param;
  wire [2:0]  _fixer_auto_out_a_bits_size;
  wire [6:0]  _fixer_auto_out_a_bits_source;
  wire [28:0] _fixer_auto_out_a_bits_address;
  wire [7:0]  _fixer_auto_out_a_bits_mask;
  wire [63:0] _fixer_auto_out_a_bits_data;
  wire        _fixer_auto_out_a_bits_corrupt;
  wire        _fixer_auto_out_d_ready;
  wire        _fixedClockNode_auto_out_0_clock;
  wire        _fixedClockNode_auto_out_0_reset;
  wire        _clockGroup_auto_out_clock;
  wire        _clockGroup_auto_out_reset;
  wire        _subsystem_pbus_clock_groups_auto_out_clock;
  wire        _subsystem_pbus_clock_groups_auto_out_reset;
  reg  [63:0] pad;
  wire        in_bits_read = _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_opcode == 3'h4;
  wire        _out_out_bits_data_T_1 = _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_address[11:3] == 9'h0;
  wire [2:0]  _GEN = {2'h0, in_bits_read};
  wire        out_woready_0 = _coupler_to_bootaddressreg_auto_fragmenter_out_a_valid & _coupler_to_bootaddressreg_auto_fragmenter_out_d_ready & ~in_bits_read & _out_out_bits_data_T_1;
  wire        valids_0 = out_woready_0 & _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_mask[0];
  wire        valids_1 = out_woready_0 & _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_mask[1];
  wire        valids_2 = out_woready_0 & _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_mask[2];
  wire        valids_3 = out_woready_0 & _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_mask[3];
  wire        valids_4 = out_woready_0 & _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_mask[4];
  wire        valids_5 = out_woready_0 & _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_mask[5];
  wire        valids_6 = out_woready_0 & _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_mask[6];
  wire        valids_7 = out_woready_0 & _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_mask[7];
  always @(posedge _fixedClockNode_auto_out_0_clock) begin
    if (_fixedClockNode_auto_out_0_reset)
      pad <= 64'h80000000;
    else if (valids_0 | valids_1 | valids_2 | valids_3 | valids_4 | valids_5 | valids_6 | valids_7)
      pad <= {valids_7 ? _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_data[63:56] : pad[63:56], valids_6 ? _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_data[55:48] : pad[55:48], valids_5 ? _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_data[47:40] : pad[47:40], valids_4 ? _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_data[39:32] : pad[39:32], valids_3 ? _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_data[31:24] : pad[31:24], valids_2 ? _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_data[23:16] : pad[23:16], valids_1 ? _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_data[15:8] : pad[15:8], valids_0 ? _coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_data[7:0] : pad[7:0]};
  end // always @(posedge)
  ClockGroup subsystem_pbus_clock_groups (
    .auto_in_member_subsystem_sbus_0_clock (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock),
    .auto_in_member_subsystem_sbus_0_reset (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset),
    .auto_out_clock                        (_subsystem_pbus_clock_groups_auto_out_clock),
    .auto_out_reset                        (_subsystem_pbus_clock_groups_auto_out_reset)
  );
  ClockGroup clockGroup (
    .auto_in_member_subsystem_sbus_0_clock (_subsystem_pbus_clock_groups_auto_out_clock),
    .auto_in_member_subsystem_sbus_0_reset (_subsystem_pbus_clock_groups_auto_out_reset),
    .auto_out_clock                        (_clockGroup_auto_out_clock),
    .auto_out_reset                        (_clockGroup_auto_out_reset)
  );
  FixedClockBroadcast_1 fixedClockNode (
    .auto_in_clock    (_clockGroup_auto_out_clock),
    .auto_in_reset    (_clockGroup_auto_out_reset),
    .auto_out_1_clock (auto_fixedClockNode_out_clock),
    .auto_out_1_reset (auto_fixedClockNode_out_reset),
    .auto_out_0_clock (_fixedClockNode_auto_out_0_clock),
    .auto_out_0_reset (_fixedClockNode_auto_out_0_reset)
  );
  TLFIFOFixer_1 fixer (
    .clock                   (_fixedClockNode_auto_out_0_clock),
    .reset                   (_fixedClockNode_auto_out_0_reset),
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
    .auto_out_a_ready        (_out_xbar_auto_in_a_ready),
    .auto_out_d_valid        (_out_xbar_auto_in_d_valid),
    .auto_out_d_bits_opcode  (_out_xbar_auto_in_d_bits_opcode),
    .auto_out_d_bits_size    (_out_xbar_auto_in_d_bits_size),
    .auto_out_d_bits_source  (_out_xbar_auto_in_d_bits_source),
    .auto_out_d_bits_data    (_out_xbar_auto_in_d_bits_data),
    .auto_in_a_ready         (_fixer_auto_in_a_ready),
    .auto_in_d_valid         (_fixer_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_fixer_auto_in_d_bits_opcode),
    .auto_in_d_bits_size     (_fixer_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_fixer_auto_in_d_bits_source),
    .auto_in_d_bits_data     (_fixer_auto_in_d_bits_data),
    .auto_out_a_valid        (_fixer_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_fixer_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_fixer_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_fixer_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_fixer_auto_out_a_bits_source),
    .auto_out_a_bits_address (_fixer_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_fixer_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_fixer_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_fixer_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_fixer_auto_out_d_ready)
  );
  TLXbar_1 in_xbar (
    .auto_in_a_valid         (_buffer_1_auto_out_a_valid),
    .auto_in_a_bits_opcode   (_buffer_1_auto_out_a_bits_opcode),
    .auto_in_a_bits_param    (_buffer_1_auto_out_a_bits_param),
    .auto_in_a_bits_size     (_buffer_1_auto_out_a_bits_size),
    .auto_in_a_bits_source   (_buffer_1_auto_out_a_bits_source),
    .auto_in_a_bits_address  (_buffer_1_auto_out_a_bits_address),
    .auto_in_a_bits_mask     (_buffer_1_auto_out_a_bits_mask),
    .auto_in_a_bits_data     (_buffer_1_auto_out_a_bits_data),
    .auto_in_a_bits_corrupt  (_buffer_1_auto_out_a_bits_corrupt),
    .auto_in_d_ready         (_buffer_1_auto_out_d_ready),
    .auto_out_a_ready        (_atomics_auto_in_a_ready),
    .auto_out_d_valid        (_atomics_auto_in_d_valid),
    .auto_out_d_bits_opcode  (_atomics_auto_in_d_bits_opcode),
    .auto_out_d_bits_param   (_atomics_auto_in_d_bits_param),
    .auto_out_d_bits_size    (_atomics_auto_in_d_bits_size),
    .auto_out_d_bits_source  (_atomics_auto_in_d_bits_source),
    .auto_out_d_bits_sink    (_atomics_auto_in_d_bits_sink),
    .auto_out_d_bits_denied  (_atomics_auto_in_d_bits_denied),
    .auto_out_d_bits_data    (_atomics_auto_in_d_bits_data),
    .auto_out_d_bits_corrupt (_atomics_auto_in_d_bits_corrupt),
    .auto_in_a_ready         (_in_xbar_auto_in_a_ready),
    .auto_in_d_valid         (_in_xbar_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_in_xbar_auto_in_d_bits_opcode),
    .auto_in_d_bits_param    (_in_xbar_auto_in_d_bits_param),
    .auto_in_d_bits_size     (_in_xbar_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_in_xbar_auto_in_d_bits_source),
    .auto_in_d_bits_sink     (_in_xbar_auto_in_d_bits_sink),
    .auto_in_d_bits_denied   (_in_xbar_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_in_xbar_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_in_xbar_auto_in_d_bits_corrupt),
    .auto_out_a_valid        (_in_xbar_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_in_xbar_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_in_xbar_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_in_xbar_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_in_xbar_auto_out_a_bits_source),
    .auto_out_a_bits_address (_in_xbar_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_in_xbar_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_in_xbar_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_in_xbar_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_in_xbar_auto_out_d_ready)
  );
  TLXbar_2 out_xbar (
    .clock                     (_fixedClockNode_auto_out_0_clock),
    .reset                     (_fixedClockNode_auto_out_0_reset),
    .auto_in_a_valid           (_fixer_auto_out_a_valid),
    .auto_in_a_bits_opcode     (_fixer_auto_out_a_bits_opcode),
    .auto_in_a_bits_param      (_fixer_auto_out_a_bits_param),
    .auto_in_a_bits_size       (_fixer_auto_out_a_bits_size),
    .auto_in_a_bits_source     (_fixer_auto_out_a_bits_source),
    .auto_in_a_bits_address    (_fixer_auto_out_a_bits_address),
    .auto_in_a_bits_mask       (_fixer_auto_out_a_bits_mask),
    .auto_in_a_bits_data       (_fixer_auto_out_a_bits_data),
    .auto_in_a_bits_corrupt    (_fixer_auto_out_a_bits_corrupt),
    .auto_in_d_ready           (_fixer_auto_out_d_ready),
    .auto_out_1_a_ready        (_coupler_to_device_named_uart_0_auto_tl_in_a_ready),
    .auto_out_1_d_valid        (_coupler_to_device_named_uart_0_auto_tl_in_d_valid),
    .auto_out_1_d_bits_opcode  (_coupler_to_device_named_uart_0_auto_tl_in_d_bits_opcode),
    .auto_out_1_d_bits_size    (_coupler_to_device_named_uart_0_auto_tl_in_d_bits_size),
    .auto_out_1_d_bits_source  (_coupler_to_device_named_uart_0_auto_tl_in_d_bits_source),
    .auto_out_1_d_bits_data    (_coupler_to_device_named_uart_0_auto_tl_in_d_bits_data),
    .auto_out_0_a_ready        (_coupler_to_bootaddressreg_auto_tl_in_a_ready),
    .auto_out_0_d_valid        (_coupler_to_bootaddressreg_auto_tl_in_d_valid),
    .auto_out_0_d_bits_opcode  (_coupler_to_bootaddressreg_auto_tl_in_d_bits_opcode),
    .auto_out_0_d_bits_size    (_coupler_to_bootaddressreg_auto_tl_in_d_bits_size),
    .auto_out_0_d_bits_source  (_coupler_to_bootaddressreg_auto_tl_in_d_bits_source),
    .auto_out_0_d_bits_data    (_coupler_to_bootaddressreg_auto_tl_in_d_bits_data),
    .auto_in_a_ready           (_out_xbar_auto_in_a_ready),
    .auto_in_d_valid           (_out_xbar_auto_in_d_valid),
    .auto_in_d_bits_opcode     (_out_xbar_auto_in_d_bits_opcode),
    .auto_in_d_bits_size       (_out_xbar_auto_in_d_bits_size),
    .auto_in_d_bits_source     (_out_xbar_auto_in_d_bits_source),
    .auto_in_d_bits_data       (_out_xbar_auto_in_d_bits_data),
    .auto_out_1_a_valid        (_out_xbar_auto_out_1_a_valid),
    .auto_out_1_a_bits_opcode  (_out_xbar_auto_out_1_a_bits_opcode),
    .auto_out_1_a_bits_param   (_out_xbar_auto_out_1_a_bits_param),
    .auto_out_1_a_bits_size    (_out_xbar_auto_out_1_a_bits_size),
    .auto_out_1_a_bits_source  (_out_xbar_auto_out_1_a_bits_source),
    .auto_out_1_a_bits_address (_out_xbar_auto_out_1_a_bits_address),
    .auto_out_1_a_bits_mask    (_out_xbar_auto_out_1_a_bits_mask),
    .auto_out_1_a_bits_data    (_out_xbar_auto_out_1_a_bits_data),
    .auto_out_1_a_bits_corrupt (_out_xbar_auto_out_1_a_bits_corrupt),
    .auto_out_1_d_ready        (_out_xbar_auto_out_1_d_ready),
    .auto_out_0_a_valid        (_out_xbar_auto_out_0_a_valid),
    .auto_out_0_a_bits_opcode  (_out_xbar_auto_out_0_a_bits_opcode),
    .auto_out_0_a_bits_param   (_out_xbar_auto_out_0_a_bits_param),
    .auto_out_0_a_bits_size    (_out_xbar_auto_out_0_a_bits_size),
    .auto_out_0_a_bits_source  (_out_xbar_auto_out_0_a_bits_source),
    .auto_out_0_a_bits_address (_out_xbar_auto_out_0_a_bits_address),
    .auto_out_0_a_bits_mask    (_out_xbar_auto_out_0_a_bits_mask),
    .auto_out_0_a_bits_data    (_out_xbar_auto_out_0_a_bits_data),
    .auto_out_0_a_bits_corrupt (_out_xbar_auto_out_0_a_bits_corrupt),
    .auto_out_0_d_ready        (_out_xbar_auto_out_0_d_ready)
  );
  TLBuffer buffer (
    .clock                   (_fixedClockNode_auto_out_0_clock),
    .reset                   (_fixedClockNode_auto_out_0_reset),
    .auto_in_a_valid         (_atomics_auto_out_a_valid),
    .auto_in_a_bits_opcode   (_atomics_auto_out_a_bits_opcode),
    .auto_in_a_bits_param    (_atomics_auto_out_a_bits_param),
    .auto_in_a_bits_size     (_atomics_auto_out_a_bits_size),
    .auto_in_a_bits_source   (_atomics_auto_out_a_bits_source),
    .auto_in_a_bits_address  (_atomics_auto_out_a_bits_address),
    .auto_in_a_bits_mask     (_atomics_auto_out_a_bits_mask),
    .auto_in_a_bits_data     (_atomics_auto_out_a_bits_data),
    .auto_in_a_bits_corrupt  (_atomics_auto_out_a_bits_corrupt),
    .auto_in_d_ready         (_atomics_auto_out_d_ready),
    .auto_out_a_ready        (_fixer_auto_in_a_ready),
    .auto_out_d_valid        (_fixer_auto_in_d_valid),
    .auto_out_d_bits_opcode  (_fixer_auto_in_d_bits_opcode),
    .auto_out_d_bits_size    (_fixer_auto_in_d_bits_size),
    .auto_out_d_bits_source  (_fixer_auto_in_d_bits_source),
    .auto_out_d_bits_data    (_fixer_auto_in_d_bits_data),
    .auto_in_a_ready         (_buffer_auto_in_a_ready),
    .auto_in_d_valid         (_buffer_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_buffer_auto_in_d_bits_opcode),
    .auto_in_d_bits_param    (_buffer_auto_in_d_bits_param),
    .auto_in_d_bits_size     (_buffer_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_buffer_auto_in_d_bits_source),
    .auto_in_d_bits_sink     (_buffer_auto_in_d_bits_sink),
    .auto_in_d_bits_denied   (_buffer_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_buffer_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_buffer_auto_in_d_bits_corrupt),
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
  TLAtomicAutomata atomics (
    .clock                   (_fixedClockNode_auto_out_0_clock),
    .reset                   (_fixedClockNode_auto_out_0_reset),
    .auto_in_a_valid         (_in_xbar_auto_out_a_valid),
    .auto_in_a_bits_opcode   (_in_xbar_auto_out_a_bits_opcode),
    .auto_in_a_bits_param    (_in_xbar_auto_out_a_bits_param),
    .auto_in_a_bits_size     (_in_xbar_auto_out_a_bits_size),
    .auto_in_a_bits_source   (_in_xbar_auto_out_a_bits_source),
    .auto_in_a_bits_address  (_in_xbar_auto_out_a_bits_address),
    .auto_in_a_bits_mask     (_in_xbar_auto_out_a_bits_mask),
    .auto_in_a_bits_data     (_in_xbar_auto_out_a_bits_data),
    .auto_in_a_bits_corrupt  (_in_xbar_auto_out_a_bits_corrupt),
    .auto_in_d_ready         (_in_xbar_auto_out_d_ready),
    .auto_out_a_ready        (_buffer_auto_in_a_ready),
    .auto_out_d_valid        (_buffer_auto_in_d_valid),
    .auto_out_d_bits_opcode  (_buffer_auto_in_d_bits_opcode),
    .auto_out_d_bits_param   (_buffer_auto_in_d_bits_param),
    .auto_out_d_bits_size    (_buffer_auto_in_d_bits_size),
    .auto_out_d_bits_source  (_buffer_auto_in_d_bits_source),
    .auto_out_d_bits_sink    (_buffer_auto_in_d_bits_sink),
    .auto_out_d_bits_denied  (_buffer_auto_in_d_bits_denied),
    .auto_out_d_bits_data    (_buffer_auto_in_d_bits_data),
    .auto_out_d_bits_corrupt (_buffer_auto_in_d_bits_corrupt),
    .auto_in_a_ready         (_atomics_auto_in_a_ready),
    .auto_in_d_valid         (_atomics_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_atomics_auto_in_d_bits_opcode),
    .auto_in_d_bits_param    (_atomics_auto_in_d_bits_param),
    .auto_in_d_bits_size     (_atomics_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_atomics_auto_in_d_bits_source),
    .auto_in_d_bits_sink     (_atomics_auto_in_d_bits_sink),
    .auto_in_d_bits_denied   (_atomics_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_atomics_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_atomics_auto_in_d_bits_corrupt),
    .auto_out_a_valid        (_atomics_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_atomics_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_atomics_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_atomics_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_atomics_auto_out_a_bits_source),
    .auto_out_a_bits_address (_atomics_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_atomics_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_atomics_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_atomics_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_atomics_auto_out_d_ready)
  );
  TLBuffer_1 buffer_1 (
    .clock                   (_fixedClockNode_auto_out_0_clock),
    .reset                   (_fixedClockNode_auto_out_0_reset),
    .auto_in_a_valid         (auto_bus_xing_in_a_valid),
    .auto_in_a_bits_opcode   (auto_bus_xing_in_a_bits_opcode),
    .auto_in_a_bits_param    (auto_bus_xing_in_a_bits_param),
    .auto_in_a_bits_size     (auto_bus_xing_in_a_bits_size),
    .auto_in_a_bits_source   (auto_bus_xing_in_a_bits_source),
    .auto_in_a_bits_address  (auto_bus_xing_in_a_bits_address),
    .auto_in_a_bits_mask     (auto_bus_xing_in_a_bits_mask),
    .auto_in_a_bits_data     (auto_bus_xing_in_a_bits_data),
    .auto_in_a_bits_corrupt  (auto_bus_xing_in_a_bits_corrupt),
    .auto_in_d_ready         (auto_bus_xing_in_d_ready),
    .auto_out_a_ready        (_in_xbar_auto_in_a_ready),
    .auto_out_d_valid        (_in_xbar_auto_in_d_valid),
    .auto_out_d_bits_opcode  (_in_xbar_auto_in_d_bits_opcode),
    .auto_out_d_bits_param   (_in_xbar_auto_in_d_bits_param),
    .auto_out_d_bits_size    (_in_xbar_auto_in_d_bits_size),
    .auto_out_d_bits_source  (_in_xbar_auto_in_d_bits_source),
    .auto_out_d_bits_sink    (_in_xbar_auto_in_d_bits_sink),
    .auto_out_d_bits_denied  (_in_xbar_auto_in_d_bits_denied),
    .auto_out_d_bits_data    (_in_xbar_auto_in_d_bits_data),
    .auto_out_d_bits_corrupt (_in_xbar_auto_in_d_bits_corrupt),
    .auto_in_a_ready         (auto_bus_xing_in_a_ready),
    .auto_in_d_valid         (auto_bus_xing_in_d_valid),
    .auto_in_d_bits_opcode   (auto_bus_xing_in_d_bits_opcode),
    .auto_in_d_bits_param    (auto_bus_xing_in_d_bits_param),
    .auto_in_d_bits_size     (auto_bus_xing_in_d_bits_size),
    .auto_in_d_bits_source   (auto_bus_xing_in_d_bits_source),
    .auto_in_d_bits_sink     (auto_bus_xing_in_d_bits_sink),
    .auto_in_d_bits_denied   (auto_bus_xing_in_d_bits_denied),
    .auto_in_d_bits_data     (auto_bus_xing_in_d_bits_data),
    .auto_in_d_bits_corrupt  (auto_bus_xing_in_d_bits_corrupt),
    .auto_out_a_valid        (_buffer_1_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_buffer_1_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_buffer_1_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_buffer_1_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_buffer_1_auto_out_a_bits_source),
    .auto_out_a_bits_address (_buffer_1_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_buffer_1_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_buffer_1_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_buffer_1_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_buffer_1_auto_out_d_ready)
  );
  TLInterconnectCoupler_4 coupler_to_bootaddressreg (
    .clock                              (_fixedClockNode_auto_out_0_clock),
    .reset                              (_fixedClockNode_auto_out_0_reset),
    .auto_fragmenter_out_a_ready        (_coupler_to_bootaddressreg_auto_fragmenter_out_d_ready),
    .auto_fragmenter_out_d_valid        (_coupler_to_bootaddressreg_auto_fragmenter_out_a_valid),
    .auto_fragmenter_out_d_bits_opcode  (_GEN),
    .auto_fragmenter_out_d_bits_size    (_coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_size),
    .auto_fragmenter_out_d_bits_source  (_coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_source),
    .auto_fragmenter_out_d_bits_data    (_out_out_bits_data_T_1 ? pad : 64'h0),
    .auto_tl_in_a_valid                 (_out_xbar_auto_out_0_a_valid),
    .auto_tl_in_a_bits_opcode           (_out_xbar_auto_out_0_a_bits_opcode),
    .auto_tl_in_a_bits_param            (_out_xbar_auto_out_0_a_bits_param),
    .auto_tl_in_a_bits_size             (_out_xbar_auto_out_0_a_bits_size),
    .auto_tl_in_a_bits_source           (_out_xbar_auto_out_0_a_bits_source),
    .auto_tl_in_a_bits_address          (_out_xbar_auto_out_0_a_bits_address),
    .auto_tl_in_a_bits_mask             (_out_xbar_auto_out_0_a_bits_mask),
    .auto_tl_in_a_bits_data             (_out_xbar_auto_out_0_a_bits_data),
    .auto_tl_in_a_bits_corrupt          (_out_xbar_auto_out_0_a_bits_corrupt),
    .auto_tl_in_d_ready                 (_out_xbar_auto_out_0_d_ready),
    .auto_fragmenter_out_a_valid        (_coupler_to_bootaddressreg_auto_fragmenter_out_a_valid),
    .auto_fragmenter_out_a_bits_opcode  (_coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_opcode),
    .auto_fragmenter_out_a_bits_param   (_coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_param),
    .auto_fragmenter_out_a_bits_size    (_coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_size),
    .auto_fragmenter_out_a_bits_source  (_coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_source),
    .auto_fragmenter_out_a_bits_address (_coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_address),
    .auto_fragmenter_out_a_bits_mask    (_coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_mask),
    .auto_fragmenter_out_a_bits_data    (_coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_data),
    .auto_fragmenter_out_a_bits_corrupt (_coupler_to_bootaddressreg_auto_fragmenter_out_a_bits_corrupt),
    .auto_fragmenter_out_d_ready        (_coupler_to_bootaddressreg_auto_fragmenter_out_d_ready),
    .auto_tl_in_a_ready                 (_coupler_to_bootaddressreg_auto_tl_in_a_ready),
    .auto_tl_in_d_valid                 (_coupler_to_bootaddressreg_auto_tl_in_d_valid),
    .auto_tl_in_d_bits_opcode           (_coupler_to_bootaddressreg_auto_tl_in_d_bits_opcode),
    .auto_tl_in_d_bits_size             (_coupler_to_bootaddressreg_auto_tl_in_d_bits_size),
    .auto_tl_in_d_bits_source           (_coupler_to_bootaddressreg_auto_tl_in_d_bits_source),
    .auto_tl_in_d_bits_data             (_coupler_to_bootaddressreg_auto_tl_in_d_bits_data)
  );
  TLInterconnectCoupler_5 coupler_to_device_named_uart_0 (
    .clock                                (_fixedClockNode_auto_out_0_clock),
    .reset                                (_fixedClockNode_auto_out_0_reset),
    .auto_control_xing_out_a_ready        (auto_coupler_to_device_named_uart_0_control_xing_out_a_ready),
    .auto_control_xing_out_d_valid        (auto_coupler_to_device_named_uart_0_control_xing_out_d_valid),
    .auto_control_xing_out_d_bits_opcode  (auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_opcode),
    .auto_control_xing_out_d_bits_size    (auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_size),
    .auto_control_xing_out_d_bits_source  (auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_source),
    .auto_control_xing_out_d_bits_data    (auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_data),
    .auto_tl_in_a_valid                   (_out_xbar_auto_out_1_a_valid),
    .auto_tl_in_a_bits_opcode             (_out_xbar_auto_out_1_a_bits_opcode),
    .auto_tl_in_a_bits_param              (_out_xbar_auto_out_1_a_bits_param),
    .auto_tl_in_a_bits_size               (_out_xbar_auto_out_1_a_bits_size),
    .auto_tl_in_a_bits_source             (_out_xbar_auto_out_1_a_bits_source),
    .auto_tl_in_a_bits_address            (_out_xbar_auto_out_1_a_bits_address),
    .auto_tl_in_a_bits_mask               (_out_xbar_auto_out_1_a_bits_mask),
    .auto_tl_in_a_bits_data               (_out_xbar_auto_out_1_a_bits_data),
    .auto_tl_in_a_bits_corrupt            (_out_xbar_auto_out_1_a_bits_corrupt),
    .auto_tl_in_d_ready                   (_out_xbar_auto_out_1_d_ready),
    .auto_control_xing_out_a_valid        (auto_coupler_to_device_named_uart_0_control_xing_out_a_valid),
    .auto_control_xing_out_a_bits_opcode  (auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_opcode),
    .auto_control_xing_out_a_bits_param   (auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_param),
    .auto_control_xing_out_a_bits_size    (auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_size),
    .auto_control_xing_out_a_bits_source  (auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_source),
    .auto_control_xing_out_a_bits_address (auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_address),
    .auto_control_xing_out_a_bits_mask    (auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_mask),
    .auto_control_xing_out_a_bits_data    (auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_data),
    .auto_control_xing_out_a_bits_corrupt (auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_corrupt),
    .auto_control_xing_out_d_ready        (auto_coupler_to_device_named_uart_0_control_xing_out_d_ready),
    .auto_tl_in_a_ready                   (_coupler_to_device_named_uart_0_auto_tl_in_a_ready),
    .auto_tl_in_d_valid                   (_coupler_to_device_named_uart_0_auto_tl_in_d_valid),
    .auto_tl_in_d_bits_opcode             (_coupler_to_device_named_uart_0_auto_tl_in_d_bits_opcode),
    .auto_tl_in_d_bits_size               (_coupler_to_device_named_uart_0_auto_tl_in_d_bits_size),
    .auto_tl_in_d_bits_source             (_coupler_to_device_named_uart_0_auto_tl_in_d_bits_source),
    .auto_tl_in_d_bits_data               (_coupler_to_device_named_uart_0_auto_tl_in_d_bits_data)
  );
  assign clock = _fixedClockNode_auto_out_0_clock;
  assign reset = _fixedClockNode_auto_out_0_reset;
endmodule

