// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module MemoryBus(
  input         auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_ready,
                auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_w_ready,
                auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_b_valid,
  input  [3:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_b_bits_id,
  input  [1:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_b_bits_resp,
  input         auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_ready,
                auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_valid,
  input  [3:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_bits_id,
  input  [63:0] auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_bits_data,
  input  [1:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_bits_resp,
  input         auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_bits_last,
                auto_subsystem_mbus_clock_groups_in_member_subsystem_mbus_0_clock,
                auto_subsystem_mbus_clock_groups_in_member_subsystem_mbus_0_reset,
                auto_bus_xing_in_a_valid,
  input  [2:0]  auto_bus_xing_in_a_bits_opcode,
                auto_bus_xing_in_a_bits_param,
                auto_bus_xing_in_a_bits_size,
  input  [4:0]  auto_bus_xing_in_a_bits_source,
  input  [31:0] auto_bus_xing_in_a_bits_address,
  input  [7:0]  auto_bus_xing_in_a_bits_mask,
  input  [63:0] auto_bus_xing_in_a_bits_data,
  input         auto_bus_xing_in_a_bits_corrupt,
                auto_bus_xing_in_d_ready,
  output        auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_valid,
  output [3:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_id,
  output [31:0] auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_addr,
  output [7:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_len,
  output [2:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_size,
  output [1:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_burst,
  output        auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_lock,
  output [3:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_cache,
  output [2:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_prot,
  output [3:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_qos,
  output        auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_w_valid,
  output [63:0] auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_w_bits_data,
  output [7:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_w_bits_strb,
  output        auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_w_bits_last,
                auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_b_ready,
                auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_valid,
  output [3:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_id,
  output [31:0] auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_addr,
  output [7:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_len,
  output [2:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_size,
  output [1:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_burst,
  output        auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_lock,
  output [3:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_cache,
  output [2:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_prot,
  output [3:0]  auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_qos,
  output        auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_ready,
                auto_fixedClockNode_out_clock,
                auto_fixedClockNode_out_reset,
                auto_bus_xing_in_a_ready,
                auto_bus_xing_in_d_valid,
  output [2:0]  auto_bus_xing_in_d_bits_opcode,
                auto_bus_xing_in_d_bits_size,
  output [4:0]  auto_bus_xing_in_d_bits_source,
  output        auto_bus_xing_in_d_bits_denied,
  output [63:0] auto_bus_xing_in_d_bits_data,
  output        auto_bus_xing_in_d_bits_corrupt
);

  wire        _coupler_to_memory_controller_port_named_axi4_auto_widget_in_a_ready;
  wire        _coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_valid;
  wire [2:0]  _coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_opcode;
  wire [2:0]  _coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_size;
  wire [4:0]  _coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_source;
  wire        _coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_denied;
  wire [63:0] _coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_data;
  wire        _coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_corrupt;
  wire        _coupler_to_memory_controller_port_named_axi4_auto_tl_in_a_ready;
  wire        _coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_valid;
  wire [2:0]  _coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_opcode;
  wire [2:0]  _coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_size;
  wire [4:0]  _coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_source;
  wire        _coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_denied;
  wire [63:0] _coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_data;
  wire        _coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_corrupt;
  wire        _coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_valid;
  wire [2:0]  _coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_opcode;
  wire [2:0]  _coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_param;
  wire [2:0]  _coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_size;
  wire [4:0]  _coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_source;
  wire [31:0] _coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_address;
  wire [7:0]  _coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_mask;
  wire [63:0] _coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_data;
  wire        _coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_corrupt;
  wire        _coupler_to_memory_controller_port_named_axi4_auto_tl_out_d_ready;
  wire        _xbar_auto_in_a_ready;
  wire        _xbar_auto_in_d_valid;
  wire [2:0]  _xbar_auto_in_d_bits_opcode;
  wire [2:0]  _xbar_auto_in_d_bits_size;
  wire [4:0]  _xbar_auto_in_d_bits_source;
  wire        _xbar_auto_in_d_bits_denied;
  wire [63:0] _xbar_auto_in_d_bits_data;
  wire        _xbar_auto_in_d_bits_corrupt;
  wire        _xbar_auto_out_a_valid;
  wire [2:0]  _xbar_auto_out_a_bits_opcode;
  wire [2:0]  _xbar_auto_out_a_bits_param;
  wire [2:0]  _xbar_auto_out_a_bits_size;
  wire [4:0]  _xbar_auto_out_a_bits_source;
  wire [31:0] _xbar_auto_out_a_bits_address;
  wire [7:0]  _xbar_auto_out_a_bits_mask;
  wire [63:0] _xbar_auto_out_a_bits_data;
  wire        _xbar_auto_out_a_bits_corrupt;
  wire        _xbar_auto_out_d_ready;
  wire        _buffer_auto_out_a_valid;
  wire [2:0]  _buffer_auto_out_a_bits_opcode;
  wire [2:0]  _buffer_auto_out_a_bits_param;
  wire [2:0]  _buffer_auto_out_a_bits_size;
  wire [4:0]  _buffer_auto_out_a_bits_source;
  wire [31:0] _buffer_auto_out_a_bits_address;
  wire [7:0]  _buffer_auto_out_a_bits_mask;
  wire [63:0] _buffer_auto_out_a_bits_data;
  wire        _buffer_auto_out_a_bits_corrupt;
  wire        _buffer_auto_out_d_ready;
  wire        _picker_auto_in_a_ready;
  wire        _picker_auto_in_d_valid;
  wire [2:0]  _picker_auto_in_d_bits_opcode;
  wire [2:0]  _picker_auto_in_d_bits_size;
  wire [4:0]  _picker_auto_in_d_bits_source;
  wire        _picker_auto_in_d_bits_denied;
  wire [63:0] _picker_auto_in_d_bits_data;
  wire        _picker_auto_in_d_bits_corrupt;
  wire        _picker_auto_out_a_valid;
  wire [2:0]  _picker_auto_out_a_bits_opcode;
  wire [2:0]  _picker_auto_out_a_bits_param;
  wire [2:0]  _picker_auto_out_a_bits_size;
  wire [4:0]  _picker_auto_out_a_bits_source;
  wire [31:0] _picker_auto_out_a_bits_address;
  wire [7:0]  _picker_auto_out_a_bits_mask;
  wire [63:0] _picker_auto_out_a_bits_data;
  wire        _picker_auto_out_a_bits_corrupt;
  wire        _picker_auto_out_d_ready;
  wire        _fixer_auto_in_a_ready;
  wire        _fixer_auto_in_d_valid;
  wire [2:0]  _fixer_auto_in_d_bits_opcode;
  wire [2:0]  _fixer_auto_in_d_bits_size;
  wire [4:0]  _fixer_auto_in_d_bits_source;
  wire        _fixer_auto_in_d_bits_denied;
  wire [63:0] _fixer_auto_in_d_bits_data;
  wire        _fixer_auto_in_d_bits_corrupt;
  wire        _fixer_auto_out_a_valid;
  wire [2:0]  _fixer_auto_out_a_bits_opcode;
  wire [2:0]  _fixer_auto_out_a_bits_param;
  wire [2:0]  _fixer_auto_out_a_bits_size;
  wire [4:0]  _fixer_auto_out_a_bits_source;
  wire [31:0] _fixer_auto_out_a_bits_address;
  wire [7:0]  _fixer_auto_out_a_bits_mask;
  wire [63:0] _fixer_auto_out_a_bits_data;
  wire        _fixer_auto_out_a_bits_corrupt;
  wire        _fixer_auto_out_d_ready;
  wire        _subsystem_mbus_xbar_auto_in_a_ready;
  wire        _subsystem_mbus_xbar_auto_in_d_valid;
  wire [2:0]  _subsystem_mbus_xbar_auto_in_d_bits_opcode;
  wire [2:0]  _subsystem_mbus_xbar_auto_in_d_bits_size;
  wire [4:0]  _subsystem_mbus_xbar_auto_in_d_bits_source;
  wire        _subsystem_mbus_xbar_auto_in_d_bits_denied;
  wire [63:0] _subsystem_mbus_xbar_auto_in_d_bits_data;
  wire        _subsystem_mbus_xbar_auto_in_d_bits_corrupt;
  wire        _subsystem_mbus_xbar_auto_out_a_valid;
  wire [2:0]  _subsystem_mbus_xbar_auto_out_a_bits_opcode;
  wire [2:0]  _subsystem_mbus_xbar_auto_out_a_bits_param;
  wire [2:0]  _subsystem_mbus_xbar_auto_out_a_bits_size;
  wire [4:0]  _subsystem_mbus_xbar_auto_out_a_bits_source;
  wire [31:0] _subsystem_mbus_xbar_auto_out_a_bits_address;
  wire [7:0]  _subsystem_mbus_xbar_auto_out_a_bits_mask;
  wire [63:0] _subsystem_mbus_xbar_auto_out_a_bits_data;
  wire        _subsystem_mbus_xbar_auto_out_a_bits_corrupt;
  wire        _subsystem_mbus_xbar_auto_out_d_ready;
  wire        _fixedClockNode_auto_out_0_clock;
  wire        _fixedClockNode_auto_out_0_reset;
  wire        _clockGroup_auto_out_clock;
  wire        _clockGroup_auto_out_reset;
  wire        _subsystem_mbus_clock_groups_auto_out_clock;
  wire        _subsystem_mbus_clock_groups_auto_out_reset;
  ClockGroup subsystem_mbus_clock_groups (
    .auto_in_member_subsystem_sbus_0_clock (auto_subsystem_mbus_clock_groups_in_member_subsystem_mbus_0_clock),
    .auto_in_member_subsystem_sbus_0_reset (auto_subsystem_mbus_clock_groups_in_member_subsystem_mbus_0_reset),
    .auto_out_clock                        (_subsystem_mbus_clock_groups_auto_out_clock),
    .auto_out_reset                        (_subsystem_mbus_clock_groups_auto_out_reset)
  );
  ClockGroup clockGroup (
    .auto_in_member_subsystem_sbus_0_clock (_subsystem_mbus_clock_groups_auto_out_clock),
    .auto_in_member_subsystem_sbus_0_reset (_subsystem_mbus_clock_groups_auto_out_reset),
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
  TLXbar_6 subsystem_mbus_xbar (
    .auto_in_a_valid         (_fixer_auto_out_a_valid),
    .auto_in_a_bits_opcode   (_fixer_auto_out_a_bits_opcode),
    .auto_in_a_bits_param    (_fixer_auto_out_a_bits_param),
    .auto_in_a_bits_size     (_fixer_auto_out_a_bits_size),
    .auto_in_a_bits_source   (_fixer_auto_out_a_bits_source),
    .auto_in_a_bits_address  (_fixer_auto_out_a_bits_address),
    .auto_in_a_bits_mask     (_fixer_auto_out_a_bits_mask),
    .auto_in_a_bits_data     (_fixer_auto_out_a_bits_data),
    .auto_in_a_bits_corrupt  (_fixer_auto_out_a_bits_corrupt),
    .auto_in_d_ready         (_fixer_auto_out_d_ready),
    .auto_out_a_ready        (_picker_auto_in_a_ready),
    .auto_out_d_valid        (_picker_auto_in_d_valid),
    .auto_out_d_bits_opcode  (_picker_auto_in_d_bits_opcode),
    .auto_out_d_bits_size    (_picker_auto_in_d_bits_size),
    .auto_out_d_bits_source  (_picker_auto_in_d_bits_source),
    .auto_out_d_bits_denied  (_picker_auto_in_d_bits_denied),
    .auto_out_d_bits_data    (_picker_auto_in_d_bits_data),
    .auto_out_d_bits_corrupt (_picker_auto_in_d_bits_corrupt),
    .auto_in_a_ready         (_subsystem_mbus_xbar_auto_in_a_ready),
    .auto_in_d_valid         (_subsystem_mbus_xbar_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_subsystem_mbus_xbar_auto_in_d_bits_opcode),
    .auto_in_d_bits_size     (_subsystem_mbus_xbar_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_subsystem_mbus_xbar_auto_in_d_bits_source),
    .auto_in_d_bits_denied   (_subsystem_mbus_xbar_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_subsystem_mbus_xbar_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_subsystem_mbus_xbar_auto_in_d_bits_corrupt),
    .auto_out_a_valid        (_subsystem_mbus_xbar_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_subsystem_mbus_xbar_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_subsystem_mbus_xbar_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_subsystem_mbus_xbar_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_subsystem_mbus_xbar_auto_out_a_bits_source),
    .auto_out_a_bits_address (_subsystem_mbus_xbar_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_subsystem_mbus_xbar_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_subsystem_mbus_xbar_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_subsystem_mbus_xbar_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_subsystem_mbus_xbar_auto_out_d_ready)
  );
  TLFIFOFixer_4 fixer (
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
    .auto_out_a_ready        (_subsystem_mbus_xbar_auto_in_a_ready),
    .auto_out_d_valid        (_subsystem_mbus_xbar_auto_in_d_valid),
    .auto_out_d_bits_opcode  (_subsystem_mbus_xbar_auto_in_d_bits_opcode),
    .auto_out_d_bits_size    (_subsystem_mbus_xbar_auto_in_d_bits_size),
    .auto_out_d_bits_source  (_subsystem_mbus_xbar_auto_in_d_bits_source),
    .auto_out_d_bits_denied  (_subsystem_mbus_xbar_auto_in_d_bits_denied),
    .auto_out_d_bits_data    (_subsystem_mbus_xbar_auto_in_d_bits_data),
    .auto_out_d_bits_corrupt (_subsystem_mbus_xbar_auto_in_d_bits_corrupt),
    .auto_in_a_ready         (_fixer_auto_in_a_ready),
    .auto_in_d_valid         (_fixer_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_fixer_auto_in_d_bits_opcode),
    .auto_in_d_bits_size     (_fixer_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_fixer_auto_in_d_bits_source),
    .auto_in_d_bits_denied   (_fixer_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_fixer_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_fixer_auto_in_d_bits_corrupt),
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
  ProbePicker picker (
    .clock                   (_fixedClockNode_auto_out_0_clock),
    .reset                   (_fixedClockNode_auto_out_0_reset),
    .auto_in_a_valid         (_subsystem_mbus_xbar_auto_out_a_valid),
    .auto_in_a_bits_opcode   (_subsystem_mbus_xbar_auto_out_a_bits_opcode),
    .auto_in_a_bits_param    (_subsystem_mbus_xbar_auto_out_a_bits_param),
    .auto_in_a_bits_size     (_subsystem_mbus_xbar_auto_out_a_bits_size),
    .auto_in_a_bits_source   (_subsystem_mbus_xbar_auto_out_a_bits_source),
    .auto_in_a_bits_address  (_subsystem_mbus_xbar_auto_out_a_bits_address),
    .auto_in_a_bits_mask     (_subsystem_mbus_xbar_auto_out_a_bits_mask),
    .auto_in_a_bits_data     (_subsystem_mbus_xbar_auto_out_a_bits_data),
    .auto_in_a_bits_corrupt  (_subsystem_mbus_xbar_auto_out_a_bits_corrupt),
    .auto_in_d_ready         (_subsystem_mbus_xbar_auto_out_d_ready),
    .auto_out_a_ready        (_coupler_to_memory_controller_port_named_axi4_auto_tl_in_a_ready),
    .auto_out_d_valid        (_coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_valid),
    .auto_out_d_bits_opcode  (_coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_opcode),
    .auto_out_d_bits_size    (_coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_size),
    .auto_out_d_bits_source  (_coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_source),
    .auto_out_d_bits_denied  (_coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_denied),
    .auto_out_d_bits_data    (_coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_data),
    .auto_out_d_bits_corrupt (_coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_corrupt),
    .auto_in_a_ready         (_picker_auto_in_a_ready),
    .auto_in_d_valid         (_picker_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_picker_auto_in_d_bits_opcode),
    .auto_in_d_bits_size     (_picker_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_picker_auto_in_d_bits_source),
    .auto_in_d_bits_denied   (_picker_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_picker_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_picker_auto_in_d_bits_corrupt),
    .auto_out_a_valid        (_picker_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_picker_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_picker_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_picker_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_picker_auto_out_a_bits_source),
    .auto_out_a_bits_address (_picker_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_picker_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_picker_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_picker_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_picker_auto_out_d_ready)
  );
  TLBuffer_9 buffer (
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
    .auto_out_a_ready        (_fixer_auto_in_a_ready),
    .auto_out_d_valid        (_fixer_auto_in_d_valid),
    .auto_out_d_bits_opcode  (_fixer_auto_in_d_bits_opcode),
    .auto_out_d_bits_size    (_fixer_auto_in_d_bits_size),
    .auto_out_d_bits_source  (_fixer_auto_in_d_bits_source),
    .auto_out_d_bits_denied  (_fixer_auto_in_d_bits_denied),
    .auto_out_d_bits_data    (_fixer_auto_in_d_bits_data),
    .auto_out_d_bits_corrupt (_fixer_auto_in_d_bits_corrupt),
    .auto_in_a_ready         (auto_bus_xing_in_a_ready),
    .auto_in_d_valid         (auto_bus_xing_in_d_valid),
    .auto_in_d_bits_opcode   (auto_bus_xing_in_d_bits_opcode),
    .auto_in_d_bits_size     (auto_bus_xing_in_d_bits_size),
    .auto_in_d_bits_source   (auto_bus_xing_in_d_bits_source),
    .auto_in_d_bits_denied   (auto_bus_xing_in_d_bits_denied),
    .auto_in_d_bits_data     (auto_bus_xing_in_d_bits_data),
    .auto_in_d_bits_corrupt  (auto_bus_xing_in_d_bits_corrupt),
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
  TLXbar_6 xbar (
    .auto_in_a_valid         (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_valid),
    .auto_in_a_bits_opcode   (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_opcode),
    .auto_in_a_bits_param    (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_param),
    .auto_in_a_bits_size     (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_size),
    .auto_in_a_bits_source   (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_source),
    .auto_in_a_bits_address  (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_address),
    .auto_in_a_bits_mask     (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_mask),
    .auto_in_a_bits_data     (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_data),
    .auto_in_a_bits_corrupt  (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_corrupt),
    .auto_in_d_ready         (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_d_ready),
    .auto_out_a_ready        (_coupler_to_memory_controller_port_named_axi4_auto_widget_in_a_ready),
    .auto_out_d_valid        (_coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_valid),
    .auto_out_d_bits_opcode  (_coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_opcode),
    .auto_out_d_bits_size    (_coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_size),
    .auto_out_d_bits_source  (_coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_source),
    .auto_out_d_bits_denied  (_coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_denied),
    .auto_out_d_bits_data    (_coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_data),
    .auto_out_d_bits_corrupt (_coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_corrupt),
    .auto_in_a_ready         (_xbar_auto_in_a_ready),
    .auto_in_d_valid         (_xbar_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_xbar_auto_in_d_bits_opcode),
    .auto_in_d_bits_size     (_xbar_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_xbar_auto_in_d_bits_source),
    .auto_in_d_bits_denied   (_xbar_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_xbar_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_xbar_auto_in_d_bits_corrupt),
    .auto_out_a_valid        (_xbar_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_xbar_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_xbar_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_xbar_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_xbar_auto_out_a_bits_source),
    .auto_out_a_bits_address (_xbar_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_xbar_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_xbar_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_xbar_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_xbar_auto_out_d_ready)
  );
  TLInterconnectCoupler_17 coupler_to_memory_controller_port_named_axi4 (
    .clock                           (_fixedClockNode_auto_out_0_clock),
    .reset                           (_fixedClockNode_auto_out_0_reset),
    .auto_widget_in_a_valid          (_xbar_auto_out_a_valid),
    .auto_widget_in_a_bits_opcode    (_xbar_auto_out_a_bits_opcode),
    .auto_widget_in_a_bits_param     (_xbar_auto_out_a_bits_param),
    .auto_widget_in_a_bits_size      (_xbar_auto_out_a_bits_size),
    .auto_widget_in_a_bits_source    (_xbar_auto_out_a_bits_source),
    .auto_widget_in_a_bits_address   (_xbar_auto_out_a_bits_address),
    .auto_widget_in_a_bits_mask      (_xbar_auto_out_a_bits_mask),
    .auto_widget_in_a_bits_data      (_xbar_auto_out_a_bits_data),
    .auto_widget_in_a_bits_corrupt   (_xbar_auto_out_a_bits_corrupt),
    .auto_widget_in_d_ready          (_xbar_auto_out_d_ready),
    .auto_axi4yank_out_aw_ready      (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_ready),
    .auto_axi4yank_out_w_ready       (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_w_ready),
    .auto_axi4yank_out_b_valid       (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_b_valid),
    .auto_axi4yank_out_b_bits_id     (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_b_bits_id),
    .auto_axi4yank_out_b_bits_resp   (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_b_bits_resp),
    .auto_axi4yank_out_ar_ready      (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_ready),
    .auto_axi4yank_out_r_valid       (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_valid),
    .auto_axi4yank_out_r_bits_id     (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_bits_id),
    .auto_axi4yank_out_r_bits_data   (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_bits_data),
    .auto_axi4yank_out_r_bits_resp   (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_bits_resp),
    .auto_axi4yank_out_r_bits_last   (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_bits_last),
    .auto_tl_in_a_valid              (_picker_auto_out_a_valid),
    .auto_tl_in_a_bits_opcode        (_picker_auto_out_a_bits_opcode),
    .auto_tl_in_a_bits_param         (_picker_auto_out_a_bits_param),
    .auto_tl_in_a_bits_size          (_picker_auto_out_a_bits_size),
    .auto_tl_in_a_bits_source        (_picker_auto_out_a_bits_source),
    .auto_tl_in_a_bits_address       (_picker_auto_out_a_bits_address),
    .auto_tl_in_a_bits_mask          (_picker_auto_out_a_bits_mask),
    .auto_tl_in_a_bits_data          (_picker_auto_out_a_bits_data),
    .auto_tl_in_a_bits_corrupt       (_picker_auto_out_a_bits_corrupt),
    .auto_tl_in_d_ready              (_picker_auto_out_d_ready),
    .auto_tl_out_a_ready             (_xbar_auto_in_a_ready),
    .auto_tl_out_d_valid             (_xbar_auto_in_d_valid),
    .auto_tl_out_d_bits_opcode       (_xbar_auto_in_d_bits_opcode),
    .auto_tl_out_d_bits_size         (_xbar_auto_in_d_bits_size),
    .auto_tl_out_d_bits_source       (_xbar_auto_in_d_bits_source),
    .auto_tl_out_d_bits_denied       (_xbar_auto_in_d_bits_denied),
    .auto_tl_out_d_bits_data         (_xbar_auto_in_d_bits_data),
    .auto_tl_out_d_bits_corrupt      (_xbar_auto_in_d_bits_corrupt),
    .auto_widget_in_a_ready          (_coupler_to_memory_controller_port_named_axi4_auto_widget_in_a_ready),
    .auto_widget_in_d_valid          (_coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_valid),
    .auto_widget_in_d_bits_opcode    (_coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_opcode),
    .auto_widget_in_d_bits_size      (_coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_size),
    .auto_widget_in_d_bits_source    (_coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_source),
    .auto_widget_in_d_bits_denied    (_coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_denied),
    .auto_widget_in_d_bits_data      (_coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_data),
    .auto_widget_in_d_bits_corrupt   (_coupler_to_memory_controller_port_named_axi4_auto_widget_in_d_bits_corrupt),
    .auto_axi4yank_out_aw_valid      (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_valid),
    .auto_axi4yank_out_aw_bits_id    (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_id),
    .auto_axi4yank_out_aw_bits_addr  (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_addr),
    .auto_axi4yank_out_aw_bits_len   (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_len),
    .auto_axi4yank_out_aw_bits_size  (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_size),
    .auto_axi4yank_out_aw_bits_burst (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_burst),
    .auto_axi4yank_out_aw_bits_lock  (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_lock),
    .auto_axi4yank_out_aw_bits_cache (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_cache),
    .auto_axi4yank_out_aw_bits_prot  (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_prot),
    .auto_axi4yank_out_aw_bits_qos   (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_qos),
    .auto_axi4yank_out_w_valid       (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_w_valid),
    .auto_axi4yank_out_w_bits_data   (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_w_bits_data),
    .auto_axi4yank_out_w_bits_strb   (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_w_bits_strb),
    .auto_axi4yank_out_w_bits_last   (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_w_bits_last),
    .auto_axi4yank_out_b_ready       (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_b_ready),
    .auto_axi4yank_out_ar_valid      (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_valid),
    .auto_axi4yank_out_ar_bits_id    (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_id),
    .auto_axi4yank_out_ar_bits_addr  (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_addr),
    .auto_axi4yank_out_ar_bits_len   (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_len),
    .auto_axi4yank_out_ar_bits_size  (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_size),
    .auto_axi4yank_out_ar_bits_burst (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_burst),
    .auto_axi4yank_out_ar_bits_lock  (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_lock),
    .auto_axi4yank_out_ar_bits_cache (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_cache),
    .auto_axi4yank_out_ar_bits_prot  (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_prot),
    .auto_axi4yank_out_ar_bits_qos   (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_qos),
    .auto_axi4yank_out_r_ready       (auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_ready),
    .auto_tl_in_a_ready              (_coupler_to_memory_controller_port_named_axi4_auto_tl_in_a_ready),
    .auto_tl_in_d_valid              (_coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_valid),
    .auto_tl_in_d_bits_opcode        (_coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_opcode),
    .auto_tl_in_d_bits_size          (_coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_size),
    .auto_tl_in_d_bits_source        (_coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_source),
    .auto_tl_in_d_bits_denied        (_coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_denied),
    .auto_tl_in_d_bits_data          (_coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_data),
    .auto_tl_in_d_bits_corrupt       (_coupler_to_memory_controller_port_named_axi4_auto_tl_in_d_bits_corrupt),
    .auto_tl_out_a_valid             (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_valid),
    .auto_tl_out_a_bits_opcode       (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_opcode),
    .auto_tl_out_a_bits_param        (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_param),
    .auto_tl_out_a_bits_size         (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_size),
    .auto_tl_out_a_bits_source       (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_source),
    .auto_tl_out_a_bits_address      (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_address),
    .auto_tl_out_a_bits_mask         (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_mask),
    .auto_tl_out_a_bits_data         (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_data),
    .auto_tl_out_a_bits_corrupt      (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_a_bits_corrupt),
    .auto_tl_out_d_ready             (_coupler_to_memory_controller_port_named_axi4_auto_tl_out_d_ready)
  );
endmodule

