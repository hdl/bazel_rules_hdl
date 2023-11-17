// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module SystemBus(
  input          auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_valid,
  input  [2:0]   auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_bits_opcode,
                 auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_bits_param,
  input  [3:0]   auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_bits_size,
  input  [4:0]   auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_bits_source,
  input  [31:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_bits_address,
  input  [15:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_bits_mask,
  input  [127:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_bits_data,
  input          auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_bits_corrupt,
                 auto_coupler_from_boom_tile_tl_master_clock_xing_in_b_ready,
                 auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_valid,
  input  [2:0]   auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_bits_opcode,
                 auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_bits_param,
  input  [3:0]   auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_bits_size,
  input  [4:0]   auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_bits_source,
  input  [31:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_bits_address,
  input  [127:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_bits_data,
  input          auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_bits_corrupt,
                 auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_ready,
                 auto_coupler_from_boom_tile_tl_master_clock_xing_in_e_valid,
  input  [3:0]   auto_coupler_from_boom_tile_tl_master_clock_xing_in_e_bits_sink,
  input          auto_coupler_to_bus_named_subsystem_l2_widget_out_a_ready,
                 auto_coupler_to_bus_named_subsystem_l2_widget_out_b_valid,
  input  [1:0]   auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_param,
  input  [31:0]  auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_address,
  input          auto_coupler_to_bus_named_subsystem_l2_widget_out_c_ready,
                 auto_coupler_to_bus_named_subsystem_l2_widget_out_d_valid,
  input  [2:0]   auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_opcode,
  input  [1:0]   auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_param,
  input  [2:0]   auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_size,
  input  [5:0]   auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_source,
  input  [3:0]   auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_sink,
  input          auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_denied,
  input  [127:0] auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_data,
  input          auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_corrupt,
                 auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_valid,
  input  [2:0]   auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_opcode,
                 auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_param,
  input  [3:0]   auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_size,
                 auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_source,
  input  [31:0]  auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_address,
  input  [7:0]   auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_mask,
  input  [63:0]  auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_data,
  input          auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_corrupt,
                 auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_ready,
                 auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_ready,
                 auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_valid,
  input  [2:0]   auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_opcode,
  input  [1:0]   auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_param,
  input  [3:0]   auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_size,
  input  [5:0]   auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_source,
  input          auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_sink,
                 auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_denied,
  input  [63:0]  auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_data,
  input          auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_corrupt,
                 auto_subsystem_sbus_clock_groups_in_member_subsystem_sbus_1_clock,
                 auto_subsystem_sbus_clock_groups_in_member_subsystem_sbus_1_reset,
                 auto_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_clock,
                 auto_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_reset,
  output         auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_ready,
                 auto_coupler_from_boom_tile_tl_master_clock_xing_in_b_valid,
  output [1:0]   auto_coupler_from_boom_tile_tl_master_clock_xing_in_b_bits_param,
  output [31:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_b_bits_address,
  output         auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_ready,
                 auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_valid,
  output [2:0]   auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_bits_opcode,
  output [1:0]   auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_bits_param,
  output [3:0]   auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_bits_size,
  output [4:0]   auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_bits_source,
  output [3:0]   auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_bits_sink,
  output         auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_bits_denied,
  output [127:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_bits_data,
  output         auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_bits_corrupt,
                 auto_coupler_to_bus_named_subsystem_l2_widget_out_a_valid,
  output [2:0]   auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_opcode,
                 auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_param,
                 auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_size,
  output [5:0]   auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_source,
  output [31:0]  auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_address,
  output [15:0]  auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_mask,
  output [127:0] auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_data,
  output         auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_corrupt,
                 auto_coupler_to_bus_named_subsystem_l2_widget_out_b_ready,
                 auto_coupler_to_bus_named_subsystem_l2_widget_out_c_valid,
  output [2:0]   auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_opcode,
                 auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_param,
                 auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_size,
  output [5:0]   auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_source,
  output [31:0]  auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_address,
  output [127:0] auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_data,
  output         auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_corrupt,
                 auto_coupler_to_bus_named_subsystem_l2_widget_out_d_ready,
                 auto_coupler_to_bus_named_subsystem_l2_widget_out_e_valid,
  output [3:0]   auto_coupler_to_bus_named_subsystem_l2_widget_out_e_bits_sink,
  output         auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_ready,
                 auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_valid,
  output [2:0]   auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_opcode,
  output [1:0]   auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_param,
  output [3:0]   auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_size,
                 auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_source,
                 auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_sink,
  output         auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_denied,
  output [63:0]  auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_data,
  output         auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_corrupt,
                 auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_valid,
  output [2:0]   auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_opcode,
                 auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_param,
  output [3:0]   auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_size,
  output [5:0]   auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_source,
  output [28:0]  auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_address,
  output [7:0]   auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_mask,
  output [63:0]  auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_data,
  output         auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_corrupt,
                 auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_ready,
                 auto_fixedClockNode_out_1_clock,
                 auto_fixedClockNode_out_1_reset,
                 auto_subsystem_sbus_clock_groups_out_member_subsystem_l2_0_clock,
                 auto_subsystem_sbus_clock_groups_out_member_subsystem_l2_0_reset
);

  wire         _coupler_from_boom_tile_auto_tl_out_a_valid;
  wire [2:0]   _coupler_from_boom_tile_auto_tl_out_a_bits_opcode;
  wire [2:0]   _coupler_from_boom_tile_auto_tl_out_a_bits_param;
  wire [3:0]   _coupler_from_boom_tile_auto_tl_out_a_bits_size;
  wire [4:0]   _coupler_from_boom_tile_auto_tl_out_a_bits_source;
  wire [31:0]  _coupler_from_boom_tile_auto_tl_out_a_bits_address;
  wire [15:0]  _coupler_from_boom_tile_auto_tl_out_a_bits_mask;
  wire [127:0] _coupler_from_boom_tile_auto_tl_out_a_bits_data;
  wire         _coupler_from_boom_tile_auto_tl_out_a_bits_corrupt;
  wire         _coupler_from_boom_tile_auto_tl_out_b_ready;
  wire         _coupler_from_boom_tile_auto_tl_out_c_valid;
  wire [2:0]   _coupler_from_boom_tile_auto_tl_out_c_bits_opcode;
  wire [2:0]   _coupler_from_boom_tile_auto_tl_out_c_bits_param;
  wire [3:0]   _coupler_from_boom_tile_auto_tl_out_c_bits_size;
  wire [4:0]   _coupler_from_boom_tile_auto_tl_out_c_bits_source;
  wire [31:0]  _coupler_from_boom_tile_auto_tl_out_c_bits_address;
  wire [127:0] _coupler_from_boom_tile_auto_tl_out_c_bits_data;
  wire         _coupler_from_boom_tile_auto_tl_out_c_bits_corrupt;
  wire         _coupler_from_boom_tile_auto_tl_out_d_ready;
  wire         _coupler_from_boom_tile_auto_tl_out_e_valid;
  wire [3:0]   _coupler_from_boom_tile_auto_tl_out_e_bits_sink;
  wire         _coupler_to_bus_named_subsystem_l2_auto_widget_in_a_ready;
  wire         _coupler_to_bus_named_subsystem_l2_auto_widget_in_b_valid;
  wire [1:0]   _coupler_to_bus_named_subsystem_l2_auto_widget_in_b_bits_param;
  wire [31:0]  _coupler_to_bus_named_subsystem_l2_auto_widget_in_b_bits_address;
  wire         _coupler_to_bus_named_subsystem_l2_auto_widget_in_c_ready;
  wire         _coupler_to_bus_named_subsystem_l2_auto_widget_in_d_valid;
  wire [2:0]   _coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_opcode;
  wire [1:0]   _coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_param;
  wire [2:0]   _coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_size;
  wire [5:0]   _coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_source;
  wire [3:0]   _coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_sink;
  wire         _coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_denied;
  wire [127:0] _coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_data;
  wire         _coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_corrupt;
  wire         _coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_valid;
  wire [2:0]   _coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_opcode;
  wire [2:0]   _coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_param;
  wire [3:0]   _coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_size;
  wire [3:0]   _coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_source;
  wire [31:0]  _coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_address;
  wire [15:0]  _coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_mask;
  wire [127:0] _coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_data;
  wire         _coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_corrupt;
  wire         _coupler_from_bus_named_subsystem_fbus_auto_widget_out_d_ready;
  wire         _coupler_to_bus_named_subsystem_cbus_auto_widget_in_a_ready;
  wire         _coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_valid;
  wire [2:0]   _coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_opcode;
  wire [1:0]   _coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_param;
  wire [3:0]   _coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_size;
  wire [5:0]   _coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_source;
  wire         _coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_sink;
  wire         _coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_denied;
  wire [127:0] _coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_data;
  wire         _coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_corrupt;
  wire         _fixer_auto_in_1_a_ready;
  wire         _fixer_auto_in_1_b_valid;
  wire [1:0]   _fixer_auto_in_1_b_bits_param;
  wire [31:0]  _fixer_auto_in_1_b_bits_address;
  wire         _fixer_auto_in_1_c_ready;
  wire         _fixer_auto_in_1_d_valid;
  wire [2:0]   _fixer_auto_in_1_d_bits_opcode;
  wire [1:0]   _fixer_auto_in_1_d_bits_param;
  wire [3:0]   _fixer_auto_in_1_d_bits_size;
  wire [4:0]   _fixer_auto_in_1_d_bits_source;
  wire [3:0]   _fixer_auto_in_1_d_bits_sink;
  wire         _fixer_auto_in_1_d_bits_denied;
  wire [127:0] _fixer_auto_in_1_d_bits_data;
  wire         _fixer_auto_in_1_d_bits_corrupt;
  wire         _fixer_auto_in_0_a_ready;
  wire         _fixer_auto_in_0_d_valid;
  wire [2:0]   _fixer_auto_in_0_d_bits_opcode;
  wire [1:0]   _fixer_auto_in_0_d_bits_param;
  wire [3:0]   _fixer_auto_in_0_d_bits_size;
  wire [3:0]   _fixer_auto_in_0_d_bits_source;
  wire [3:0]   _fixer_auto_in_0_d_bits_sink;
  wire         _fixer_auto_in_0_d_bits_denied;
  wire [127:0] _fixer_auto_in_0_d_bits_data;
  wire         _fixer_auto_in_0_d_bits_corrupt;
  wire         _fixer_auto_out_1_a_valid;
  wire [2:0]   _fixer_auto_out_1_a_bits_opcode;
  wire [2:0]   _fixer_auto_out_1_a_bits_param;
  wire [3:0]   _fixer_auto_out_1_a_bits_size;
  wire [4:0]   _fixer_auto_out_1_a_bits_source;
  wire [31:0]  _fixer_auto_out_1_a_bits_address;
  wire [15:0]  _fixer_auto_out_1_a_bits_mask;
  wire [127:0] _fixer_auto_out_1_a_bits_data;
  wire         _fixer_auto_out_1_a_bits_corrupt;
  wire         _fixer_auto_out_1_b_ready;
  wire         _fixer_auto_out_1_c_valid;
  wire [2:0]   _fixer_auto_out_1_c_bits_opcode;
  wire [2:0]   _fixer_auto_out_1_c_bits_param;
  wire [3:0]   _fixer_auto_out_1_c_bits_size;
  wire [4:0]   _fixer_auto_out_1_c_bits_source;
  wire [31:0]  _fixer_auto_out_1_c_bits_address;
  wire [127:0] _fixer_auto_out_1_c_bits_data;
  wire         _fixer_auto_out_1_c_bits_corrupt;
  wire         _fixer_auto_out_1_d_ready;
  wire         _fixer_auto_out_1_e_valid;
  wire [3:0]   _fixer_auto_out_1_e_bits_sink;
  wire         _fixer_auto_out_0_a_valid;
  wire [2:0]   _fixer_auto_out_0_a_bits_opcode;
  wire [2:0]   _fixer_auto_out_0_a_bits_param;
  wire [3:0]   _fixer_auto_out_0_a_bits_size;
  wire [3:0]   _fixer_auto_out_0_a_bits_source;
  wire [31:0]  _fixer_auto_out_0_a_bits_address;
  wire [15:0]  _fixer_auto_out_0_a_bits_mask;
  wire [127:0] _fixer_auto_out_0_a_bits_data;
  wire         _fixer_auto_out_0_a_bits_corrupt;
  wire         _fixer_auto_out_0_d_ready;
  wire         _system_bus_xbar_auto_in_1_a_ready;
  wire         _system_bus_xbar_auto_in_1_b_valid;
  wire [1:0]   _system_bus_xbar_auto_in_1_b_bits_param;
  wire [31:0]  _system_bus_xbar_auto_in_1_b_bits_address;
  wire         _system_bus_xbar_auto_in_1_c_ready;
  wire         _system_bus_xbar_auto_in_1_d_valid;
  wire [2:0]   _system_bus_xbar_auto_in_1_d_bits_opcode;
  wire [1:0]   _system_bus_xbar_auto_in_1_d_bits_param;
  wire [3:0]   _system_bus_xbar_auto_in_1_d_bits_size;
  wire [4:0]   _system_bus_xbar_auto_in_1_d_bits_source;
  wire [3:0]   _system_bus_xbar_auto_in_1_d_bits_sink;
  wire         _system_bus_xbar_auto_in_1_d_bits_denied;
  wire [127:0] _system_bus_xbar_auto_in_1_d_bits_data;
  wire         _system_bus_xbar_auto_in_1_d_bits_corrupt;
  wire         _system_bus_xbar_auto_in_0_a_ready;
  wire         _system_bus_xbar_auto_in_0_d_valid;
  wire [2:0]   _system_bus_xbar_auto_in_0_d_bits_opcode;
  wire [1:0]   _system_bus_xbar_auto_in_0_d_bits_param;
  wire [3:0]   _system_bus_xbar_auto_in_0_d_bits_size;
  wire [3:0]   _system_bus_xbar_auto_in_0_d_bits_source;
  wire [3:0]   _system_bus_xbar_auto_in_0_d_bits_sink;
  wire         _system_bus_xbar_auto_in_0_d_bits_denied;
  wire [127:0] _system_bus_xbar_auto_in_0_d_bits_data;
  wire         _system_bus_xbar_auto_in_0_d_bits_corrupt;
  wire         _system_bus_xbar_auto_out_1_a_valid;
  wire [2:0]   _system_bus_xbar_auto_out_1_a_bits_opcode;
  wire [2:0]   _system_bus_xbar_auto_out_1_a_bits_param;
  wire [2:0]   _system_bus_xbar_auto_out_1_a_bits_size;
  wire [5:0]   _system_bus_xbar_auto_out_1_a_bits_source;
  wire [31:0]  _system_bus_xbar_auto_out_1_a_bits_address;
  wire [15:0]  _system_bus_xbar_auto_out_1_a_bits_mask;
  wire [127:0] _system_bus_xbar_auto_out_1_a_bits_data;
  wire         _system_bus_xbar_auto_out_1_a_bits_corrupt;
  wire         _system_bus_xbar_auto_out_1_b_ready;
  wire         _system_bus_xbar_auto_out_1_c_valid;
  wire [2:0]   _system_bus_xbar_auto_out_1_c_bits_opcode;
  wire [2:0]   _system_bus_xbar_auto_out_1_c_bits_param;
  wire [2:0]   _system_bus_xbar_auto_out_1_c_bits_size;
  wire [5:0]   _system_bus_xbar_auto_out_1_c_bits_source;
  wire [31:0]  _system_bus_xbar_auto_out_1_c_bits_address;
  wire [127:0] _system_bus_xbar_auto_out_1_c_bits_data;
  wire         _system_bus_xbar_auto_out_1_c_bits_corrupt;
  wire         _system_bus_xbar_auto_out_1_d_ready;
  wire         _system_bus_xbar_auto_out_1_e_valid;
  wire [3:0]   _system_bus_xbar_auto_out_1_e_bits_sink;
  wire         _system_bus_xbar_auto_out_0_a_valid;
  wire [2:0]   _system_bus_xbar_auto_out_0_a_bits_opcode;
  wire [2:0]   _system_bus_xbar_auto_out_0_a_bits_param;
  wire [3:0]   _system_bus_xbar_auto_out_0_a_bits_size;
  wire [5:0]   _system_bus_xbar_auto_out_0_a_bits_source;
  wire [28:0]  _system_bus_xbar_auto_out_0_a_bits_address;
  wire [15:0]  _system_bus_xbar_auto_out_0_a_bits_mask;
  wire [127:0] _system_bus_xbar_auto_out_0_a_bits_data;
  wire         _system_bus_xbar_auto_out_0_a_bits_corrupt;
  wire         _system_bus_xbar_auto_out_0_d_ready;
  wire         _fixedClockNode_auto_out_0_clock;
  wire         _fixedClockNode_auto_out_0_reset;
  wire         _clockGroup_auto_out_clock;
  wire         _clockGroup_auto_out_reset;
  wire         _subsystem_sbus_clock_groups_auto_out_0_member_subsystem_sbus_0_clock;
  wire         _subsystem_sbus_clock_groups_auto_out_0_member_subsystem_sbus_0_reset;
  ClockGroupAggregator subsystem_sbus_clock_groups (
    .auto_in_member_subsystem_sbus_1_clock    (auto_subsystem_sbus_clock_groups_in_member_subsystem_sbus_1_clock),
    .auto_in_member_subsystem_sbus_1_reset    (auto_subsystem_sbus_clock_groups_in_member_subsystem_sbus_1_reset),
    .auto_in_member_subsystem_sbus_0_clock    (auto_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_clock),
    .auto_in_member_subsystem_sbus_0_reset    (auto_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_reset),
    .auto_out_1_member_subsystem_l2_0_clock   (auto_subsystem_sbus_clock_groups_out_member_subsystem_l2_0_clock),
    .auto_out_1_member_subsystem_l2_0_reset   (auto_subsystem_sbus_clock_groups_out_member_subsystem_l2_0_reset),
    .auto_out_0_member_subsystem_sbus_0_clock (_subsystem_sbus_clock_groups_auto_out_0_member_subsystem_sbus_0_clock),
    .auto_out_0_member_subsystem_sbus_0_reset (_subsystem_sbus_clock_groups_auto_out_0_member_subsystem_sbus_0_reset)
  );
  ClockGroup clockGroup (
    .auto_in_member_subsystem_sbus_0_clock (_subsystem_sbus_clock_groups_auto_out_0_member_subsystem_sbus_0_clock),
    .auto_in_member_subsystem_sbus_0_reset (_subsystem_sbus_clock_groups_auto_out_0_member_subsystem_sbus_0_reset),
    .auto_out_clock                        (_clockGroup_auto_out_clock),
    .auto_out_reset                        (_clockGroup_auto_out_reset)
  );
  FixedClockBroadcast fixedClockNode (
    .auto_in_clock    (_clockGroup_auto_out_clock),
    .auto_in_reset    (_clockGroup_auto_out_reset),
    .auto_out_2_clock (auto_fixedClockNode_out_1_clock),
    .auto_out_2_reset (auto_fixedClockNode_out_1_reset),
    .auto_out_0_clock (_fixedClockNode_auto_out_0_clock),
    .auto_out_0_reset (_fixedClockNode_auto_out_0_reset)
  );
  TLXbar system_bus_xbar (
    .clock                     (_fixedClockNode_auto_out_0_clock),
    .reset                     (_fixedClockNode_auto_out_0_reset),
    .auto_in_1_a_valid         (_fixer_auto_out_1_a_valid),
    .auto_in_1_a_bits_opcode   (_fixer_auto_out_1_a_bits_opcode),
    .auto_in_1_a_bits_param    (_fixer_auto_out_1_a_bits_param),
    .auto_in_1_a_bits_size     (_fixer_auto_out_1_a_bits_size),
    .auto_in_1_a_bits_source   (_fixer_auto_out_1_a_bits_source),
    .auto_in_1_a_bits_address  (_fixer_auto_out_1_a_bits_address),
    .auto_in_1_a_bits_mask     (_fixer_auto_out_1_a_bits_mask),
    .auto_in_1_a_bits_data     (_fixer_auto_out_1_a_bits_data),
    .auto_in_1_a_bits_corrupt  (_fixer_auto_out_1_a_bits_corrupt),
    .auto_in_1_b_ready         (_fixer_auto_out_1_b_ready),
    .auto_in_1_c_valid         (_fixer_auto_out_1_c_valid),
    .auto_in_1_c_bits_opcode   (_fixer_auto_out_1_c_bits_opcode),
    .auto_in_1_c_bits_param    (_fixer_auto_out_1_c_bits_param),
    .auto_in_1_c_bits_size     (_fixer_auto_out_1_c_bits_size),
    .auto_in_1_c_bits_source   (_fixer_auto_out_1_c_bits_source),
    .auto_in_1_c_bits_address  (_fixer_auto_out_1_c_bits_address),
    .auto_in_1_c_bits_data     (_fixer_auto_out_1_c_bits_data),
    .auto_in_1_c_bits_corrupt  (_fixer_auto_out_1_c_bits_corrupt),
    .auto_in_1_d_ready         (_fixer_auto_out_1_d_ready),
    .auto_in_1_e_valid         (_fixer_auto_out_1_e_valid),
    .auto_in_1_e_bits_sink     (_fixer_auto_out_1_e_bits_sink),
    .auto_in_0_a_valid         (_fixer_auto_out_0_a_valid),
    .auto_in_0_a_bits_opcode   (_fixer_auto_out_0_a_bits_opcode),
    .auto_in_0_a_bits_param    (_fixer_auto_out_0_a_bits_param),
    .auto_in_0_a_bits_size     (_fixer_auto_out_0_a_bits_size),
    .auto_in_0_a_bits_source   (_fixer_auto_out_0_a_bits_source),
    .auto_in_0_a_bits_address  (_fixer_auto_out_0_a_bits_address),
    .auto_in_0_a_bits_mask     (_fixer_auto_out_0_a_bits_mask),
    .auto_in_0_a_bits_data     (_fixer_auto_out_0_a_bits_data),
    .auto_in_0_a_bits_corrupt  (_fixer_auto_out_0_a_bits_corrupt),
    .auto_in_0_d_ready         (_fixer_auto_out_0_d_ready),
    .auto_out_1_a_ready        (_coupler_to_bus_named_subsystem_l2_auto_widget_in_a_ready),
    .auto_out_1_b_valid        (_coupler_to_bus_named_subsystem_l2_auto_widget_in_b_valid),
    .auto_out_1_b_bits_param   (_coupler_to_bus_named_subsystem_l2_auto_widget_in_b_bits_param),
    .auto_out_1_b_bits_address (_coupler_to_bus_named_subsystem_l2_auto_widget_in_b_bits_address),
    .auto_out_1_c_ready        (_coupler_to_bus_named_subsystem_l2_auto_widget_in_c_ready),
    .auto_out_1_d_valid        (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_valid),
    .auto_out_1_d_bits_opcode  (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_opcode),
    .auto_out_1_d_bits_param   (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_param),
    .auto_out_1_d_bits_size    (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_size),
    .auto_out_1_d_bits_source  (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_source),
    .auto_out_1_d_bits_sink    (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_sink),
    .auto_out_1_d_bits_denied  (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_denied),
    .auto_out_1_d_bits_data    (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_data),
    .auto_out_1_d_bits_corrupt (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_corrupt),
    .auto_out_0_a_ready        (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_a_ready),
    .auto_out_0_d_valid        (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_valid),
    .auto_out_0_d_bits_opcode  (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_opcode),
    .auto_out_0_d_bits_param   (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_param),
    .auto_out_0_d_bits_size    (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_size),
    .auto_out_0_d_bits_source  (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_source),
    .auto_out_0_d_bits_sink    (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_sink),
    .auto_out_0_d_bits_denied  (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_denied),
    .auto_out_0_d_bits_data    (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_data),
    .auto_out_0_d_bits_corrupt (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_corrupt),
    .auto_in_1_a_ready         (_system_bus_xbar_auto_in_1_a_ready),
    .auto_in_1_b_valid         (_system_bus_xbar_auto_in_1_b_valid),
    .auto_in_1_b_bits_param    (_system_bus_xbar_auto_in_1_b_bits_param),
    .auto_in_1_b_bits_address  (_system_bus_xbar_auto_in_1_b_bits_address),
    .auto_in_1_c_ready         (_system_bus_xbar_auto_in_1_c_ready),
    .auto_in_1_d_valid         (_system_bus_xbar_auto_in_1_d_valid),
    .auto_in_1_d_bits_opcode   (_system_bus_xbar_auto_in_1_d_bits_opcode),
    .auto_in_1_d_bits_param    (_system_bus_xbar_auto_in_1_d_bits_param),
    .auto_in_1_d_bits_size     (_system_bus_xbar_auto_in_1_d_bits_size),
    .auto_in_1_d_bits_source   (_system_bus_xbar_auto_in_1_d_bits_source),
    .auto_in_1_d_bits_sink     (_system_bus_xbar_auto_in_1_d_bits_sink),
    .auto_in_1_d_bits_denied   (_system_bus_xbar_auto_in_1_d_bits_denied),
    .auto_in_1_d_bits_data     (_system_bus_xbar_auto_in_1_d_bits_data),
    .auto_in_1_d_bits_corrupt  (_system_bus_xbar_auto_in_1_d_bits_corrupt),
    .auto_in_0_a_ready         (_system_bus_xbar_auto_in_0_a_ready),
    .auto_in_0_d_valid         (_system_bus_xbar_auto_in_0_d_valid),
    .auto_in_0_d_bits_opcode   (_system_bus_xbar_auto_in_0_d_bits_opcode),
    .auto_in_0_d_bits_param    (_system_bus_xbar_auto_in_0_d_bits_param),
    .auto_in_0_d_bits_size     (_system_bus_xbar_auto_in_0_d_bits_size),
    .auto_in_0_d_bits_source   (_system_bus_xbar_auto_in_0_d_bits_source),
    .auto_in_0_d_bits_sink     (_system_bus_xbar_auto_in_0_d_bits_sink),
    .auto_in_0_d_bits_denied   (_system_bus_xbar_auto_in_0_d_bits_denied),
    .auto_in_0_d_bits_data     (_system_bus_xbar_auto_in_0_d_bits_data),
    .auto_in_0_d_bits_corrupt  (_system_bus_xbar_auto_in_0_d_bits_corrupt),
    .auto_out_1_a_valid        (_system_bus_xbar_auto_out_1_a_valid),
    .auto_out_1_a_bits_opcode  (_system_bus_xbar_auto_out_1_a_bits_opcode),
    .auto_out_1_a_bits_param   (_system_bus_xbar_auto_out_1_a_bits_param),
    .auto_out_1_a_bits_size    (_system_bus_xbar_auto_out_1_a_bits_size),
    .auto_out_1_a_bits_source  (_system_bus_xbar_auto_out_1_a_bits_source),
    .auto_out_1_a_bits_address (_system_bus_xbar_auto_out_1_a_bits_address),
    .auto_out_1_a_bits_mask    (_system_bus_xbar_auto_out_1_a_bits_mask),
    .auto_out_1_a_bits_data    (_system_bus_xbar_auto_out_1_a_bits_data),
    .auto_out_1_a_bits_corrupt (_system_bus_xbar_auto_out_1_a_bits_corrupt),
    .auto_out_1_b_ready        (_system_bus_xbar_auto_out_1_b_ready),
    .auto_out_1_c_valid        (_system_bus_xbar_auto_out_1_c_valid),
    .auto_out_1_c_bits_opcode  (_system_bus_xbar_auto_out_1_c_bits_opcode),
    .auto_out_1_c_bits_param   (_system_bus_xbar_auto_out_1_c_bits_param),
    .auto_out_1_c_bits_size    (_system_bus_xbar_auto_out_1_c_bits_size),
    .auto_out_1_c_bits_source  (_system_bus_xbar_auto_out_1_c_bits_source),
    .auto_out_1_c_bits_address (_system_bus_xbar_auto_out_1_c_bits_address),
    .auto_out_1_c_bits_data    (_system_bus_xbar_auto_out_1_c_bits_data),
    .auto_out_1_c_bits_corrupt (_system_bus_xbar_auto_out_1_c_bits_corrupt),
    .auto_out_1_d_ready        (_system_bus_xbar_auto_out_1_d_ready),
    .auto_out_1_e_valid        (_system_bus_xbar_auto_out_1_e_valid),
    .auto_out_1_e_bits_sink    (_system_bus_xbar_auto_out_1_e_bits_sink),
    .auto_out_0_a_valid        (_system_bus_xbar_auto_out_0_a_valid),
    .auto_out_0_a_bits_opcode  (_system_bus_xbar_auto_out_0_a_bits_opcode),
    .auto_out_0_a_bits_param   (_system_bus_xbar_auto_out_0_a_bits_param),
    .auto_out_0_a_bits_size    (_system_bus_xbar_auto_out_0_a_bits_size),
    .auto_out_0_a_bits_source  (_system_bus_xbar_auto_out_0_a_bits_source),
    .auto_out_0_a_bits_address (_system_bus_xbar_auto_out_0_a_bits_address),
    .auto_out_0_a_bits_mask    (_system_bus_xbar_auto_out_0_a_bits_mask),
    .auto_out_0_a_bits_data    (_system_bus_xbar_auto_out_0_a_bits_data),
    .auto_out_0_a_bits_corrupt (_system_bus_xbar_auto_out_0_a_bits_corrupt),
    .auto_out_0_d_ready        (_system_bus_xbar_auto_out_0_d_ready)
  );
  TLFIFOFixer fixer (
    .clock                     (_fixedClockNode_auto_out_0_clock),
    .reset                     (_fixedClockNode_auto_out_0_reset),
    .auto_in_1_a_valid         (_coupler_from_boom_tile_auto_tl_out_a_valid),
    .auto_in_1_a_bits_opcode   (_coupler_from_boom_tile_auto_tl_out_a_bits_opcode),
    .auto_in_1_a_bits_param    (_coupler_from_boom_tile_auto_tl_out_a_bits_param),
    .auto_in_1_a_bits_size     (_coupler_from_boom_tile_auto_tl_out_a_bits_size),
    .auto_in_1_a_bits_source   (_coupler_from_boom_tile_auto_tl_out_a_bits_source),
    .auto_in_1_a_bits_address  (_coupler_from_boom_tile_auto_tl_out_a_bits_address),
    .auto_in_1_a_bits_mask     (_coupler_from_boom_tile_auto_tl_out_a_bits_mask),
    .auto_in_1_a_bits_data     (_coupler_from_boom_tile_auto_tl_out_a_bits_data),
    .auto_in_1_a_bits_corrupt  (_coupler_from_boom_tile_auto_tl_out_a_bits_corrupt),
    .auto_in_1_b_ready         (_coupler_from_boom_tile_auto_tl_out_b_ready),
    .auto_in_1_c_valid         (_coupler_from_boom_tile_auto_tl_out_c_valid),
    .auto_in_1_c_bits_opcode   (_coupler_from_boom_tile_auto_tl_out_c_bits_opcode),
    .auto_in_1_c_bits_param    (_coupler_from_boom_tile_auto_tl_out_c_bits_param),
    .auto_in_1_c_bits_size     (_coupler_from_boom_tile_auto_tl_out_c_bits_size),
    .auto_in_1_c_bits_source   (_coupler_from_boom_tile_auto_tl_out_c_bits_source),
    .auto_in_1_c_bits_address  (_coupler_from_boom_tile_auto_tl_out_c_bits_address),
    .auto_in_1_c_bits_data     (_coupler_from_boom_tile_auto_tl_out_c_bits_data),
    .auto_in_1_c_bits_corrupt  (_coupler_from_boom_tile_auto_tl_out_c_bits_corrupt),
    .auto_in_1_d_ready         (_coupler_from_boom_tile_auto_tl_out_d_ready),
    .auto_in_1_e_valid         (_coupler_from_boom_tile_auto_tl_out_e_valid),
    .auto_in_1_e_bits_sink     (_coupler_from_boom_tile_auto_tl_out_e_bits_sink),
    .auto_in_0_a_valid         (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_valid),
    .auto_in_0_a_bits_opcode   (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_opcode),
    .auto_in_0_a_bits_param    (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_param),
    .auto_in_0_a_bits_size     (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_size),
    .auto_in_0_a_bits_source   (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_source),
    .auto_in_0_a_bits_address  (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_address),
    .auto_in_0_a_bits_mask     (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_mask),
    .auto_in_0_a_bits_data     (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_data),
    .auto_in_0_a_bits_corrupt  (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_corrupt),
    .auto_in_0_d_ready         (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_d_ready),
    .auto_out_1_a_ready        (_system_bus_xbar_auto_in_1_a_ready),
    .auto_out_1_b_valid        (_system_bus_xbar_auto_in_1_b_valid),
    .auto_out_1_b_bits_param   (_system_bus_xbar_auto_in_1_b_bits_param),
    .auto_out_1_b_bits_address (_system_bus_xbar_auto_in_1_b_bits_address),
    .auto_out_1_c_ready        (_system_bus_xbar_auto_in_1_c_ready),
    .auto_out_1_d_valid        (_system_bus_xbar_auto_in_1_d_valid),
    .auto_out_1_d_bits_opcode  (_system_bus_xbar_auto_in_1_d_bits_opcode),
    .auto_out_1_d_bits_param   (_system_bus_xbar_auto_in_1_d_bits_param),
    .auto_out_1_d_bits_size    (_system_bus_xbar_auto_in_1_d_bits_size),
    .auto_out_1_d_bits_source  (_system_bus_xbar_auto_in_1_d_bits_source),
    .auto_out_1_d_bits_sink    (_system_bus_xbar_auto_in_1_d_bits_sink),
    .auto_out_1_d_bits_denied  (_system_bus_xbar_auto_in_1_d_bits_denied),
    .auto_out_1_d_bits_data    (_system_bus_xbar_auto_in_1_d_bits_data),
    .auto_out_1_d_bits_corrupt (_system_bus_xbar_auto_in_1_d_bits_corrupt),
    .auto_out_0_a_ready        (_system_bus_xbar_auto_in_0_a_ready),
    .auto_out_0_d_valid        (_system_bus_xbar_auto_in_0_d_valid),
    .auto_out_0_d_bits_opcode  (_system_bus_xbar_auto_in_0_d_bits_opcode),
    .auto_out_0_d_bits_param   (_system_bus_xbar_auto_in_0_d_bits_param),
    .auto_out_0_d_bits_size    (_system_bus_xbar_auto_in_0_d_bits_size),
    .auto_out_0_d_bits_source  (_system_bus_xbar_auto_in_0_d_bits_source),
    .auto_out_0_d_bits_sink    (_system_bus_xbar_auto_in_0_d_bits_sink),
    .auto_out_0_d_bits_denied  (_system_bus_xbar_auto_in_0_d_bits_denied),
    .auto_out_0_d_bits_data    (_system_bus_xbar_auto_in_0_d_bits_data),
    .auto_out_0_d_bits_corrupt (_system_bus_xbar_auto_in_0_d_bits_corrupt),
    .auto_in_1_a_ready         (_fixer_auto_in_1_a_ready),
    .auto_in_1_b_valid         (_fixer_auto_in_1_b_valid),
    .auto_in_1_b_bits_param    (_fixer_auto_in_1_b_bits_param),
    .auto_in_1_b_bits_address  (_fixer_auto_in_1_b_bits_address),
    .auto_in_1_c_ready         (_fixer_auto_in_1_c_ready),
    .auto_in_1_d_valid         (_fixer_auto_in_1_d_valid),
    .auto_in_1_d_bits_opcode   (_fixer_auto_in_1_d_bits_opcode),
    .auto_in_1_d_bits_param    (_fixer_auto_in_1_d_bits_param),
    .auto_in_1_d_bits_size     (_fixer_auto_in_1_d_bits_size),
    .auto_in_1_d_bits_source   (_fixer_auto_in_1_d_bits_source),
    .auto_in_1_d_bits_sink     (_fixer_auto_in_1_d_bits_sink),
    .auto_in_1_d_bits_denied   (_fixer_auto_in_1_d_bits_denied),
    .auto_in_1_d_bits_data     (_fixer_auto_in_1_d_bits_data),
    .auto_in_1_d_bits_corrupt  (_fixer_auto_in_1_d_bits_corrupt),
    .auto_in_0_a_ready         (_fixer_auto_in_0_a_ready),
    .auto_in_0_d_valid         (_fixer_auto_in_0_d_valid),
    .auto_in_0_d_bits_opcode   (_fixer_auto_in_0_d_bits_opcode),
    .auto_in_0_d_bits_param    (_fixer_auto_in_0_d_bits_param),
    .auto_in_0_d_bits_size     (_fixer_auto_in_0_d_bits_size),
    .auto_in_0_d_bits_source   (_fixer_auto_in_0_d_bits_source),
    .auto_in_0_d_bits_sink     (_fixer_auto_in_0_d_bits_sink),
    .auto_in_0_d_bits_denied   (_fixer_auto_in_0_d_bits_denied),
    .auto_in_0_d_bits_data     (_fixer_auto_in_0_d_bits_data),
    .auto_in_0_d_bits_corrupt  (_fixer_auto_in_0_d_bits_corrupt),
    .auto_out_1_a_valid        (_fixer_auto_out_1_a_valid),
    .auto_out_1_a_bits_opcode  (_fixer_auto_out_1_a_bits_opcode),
    .auto_out_1_a_bits_param   (_fixer_auto_out_1_a_bits_param),
    .auto_out_1_a_bits_size    (_fixer_auto_out_1_a_bits_size),
    .auto_out_1_a_bits_source  (_fixer_auto_out_1_a_bits_source),
    .auto_out_1_a_bits_address (_fixer_auto_out_1_a_bits_address),
    .auto_out_1_a_bits_mask    (_fixer_auto_out_1_a_bits_mask),
    .auto_out_1_a_bits_data    (_fixer_auto_out_1_a_bits_data),
    .auto_out_1_a_bits_corrupt (_fixer_auto_out_1_a_bits_corrupt),
    .auto_out_1_b_ready        (_fixer_auto_out_1_b_ready),
    .auto_out_1_c_valid        (_fixer_auto_out_1_c_valid),
    .auto_out_1_c_bits_opcode  (_fixer_auto_out_1_c_bits_opcode),
    .auto_out_1_c_bits_param   (_fixer_auto_out_1_c_bits_param),
    .auto_out_1_c_bits_size    (_fixer_auto_out_1_c_bits_size),
    .auto_out_1_c_bits_source  (_fixer_auto_out_1_c_bits_source),
    .auto_out_1_c_bits_address (_fixer_auto_out_1_c_bits_address),
    .auto_out_1_c_bits_data    (_fixer_auto_out_1_c_bits_data),
    .auto_out_1_c_bits_corrupt (_fixer_auto_out_1_c_bits_corrupt),
    .auto_out_1_d_ready        (_fixer_auto_out_1_d_ready),
    .auto_out_1_e_valid        (_fixer_auto_out_1_e_valid),
    .auto_out_1_e_bits_sink    (_fixer_auto_out_1_e_bits_sink),
    .auto_out_0_a_valid        (_fixer_auto_out_0_a_valid),
    .auto_out_0_a_bits_opcode  (_fixer_auto_out_0_a_bits_opcode),
    .auto_out_0_a_bits_param   (_fixer_auto_out_0_a_bits_param),
    .auto_out_0_a_bits_size    (_fixer_auto_out_0_a_bits_size),
    .auto_out_0_a_bits_source  (_fixer_auto_out_0_a_bits_source),
    .auto_out_0_a_bits_address (_fixer_auto_out_0_a_bits_address),
    .auto_out_0_a_bits_mask    (_fixer_auto_out_0_a_bits_mask),
    .auto_out_0_a_bits_data    (_fixer_auto_out_0_a_bits_data),
    .auto_out_0_a_bits_corrupt (_fixer_auto_out_0_a_bits_corrupt),
    .auto_out_0_d_ready        (_fixer_auto_out_0_d_ready)
  );
  TLInterconnectCoupler coupler_to_bus_named_subsystem_cbus (
    .clock                            (_fixedClockNode_auto_out_0_clock),
    .reset                            (_fixedClockNode_auto_out_0_reset),
    .auto_widget_in_a_valid           (_system_bus_xbar_auto_out_0_a_valid),
    .auto_widget_in_a_bits_opcode     (_system_bus_xbar_auto_out_0_a_bits_opcode),
    .auto_widget_in_a_bits_param      (_system_bus_xbar_auto_out_0_a_bits_param),
    .auto_widget_in_a_bits_size       (_system_bus_xbar_auto_out_0_a_bits_size),
    .auto_widget_in_a_bits_source     (_system_bus_xbar_auto_out_0_a_bits_source),
    .auto_widget_in_a_bits_address    (_system_bus_xbar_auto_out_0_a_bits_address),
    .auto_widget_in_a_bits_mask       (_system_bus_xbar_auto_out_0_a_bits_mask),
    .auto_widget_in_a_bits_data       (_system_bus_xbar_auto_out_0_a_bits_data),
    .auto_widget_in_a_bits_corrupt    (_system_bus_xbar_auto_out_0_a_bits_corrupt),
    .auto_widget_in_d_ready           (_system_bus_xbar_auto_out_0_d_ready),
    .auto_bus_xing_out_a_ready        (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_ready),
    .auto_bus_xing_out_d_valid        (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_valid),
    .auto_bus_xing_out_d_bits_opcode  (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_opcode),
    .auto_bus_xing_out_d_bits_param   (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_param),
    .auto_bus_xing_out_d_bits_size    (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_size),
    .auto_bus_xing_out_d_bits_source  (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_source),
    .auto_bus_xing_out_d_bits_sink    (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_sink),
    .auto_bus_xing_out_d_bits_denied  (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_denied),
    .auto_bus_xing_out_d_bits_data    (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_data),
    .auto_bus_xing_out_d_bits_corrupt (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_corrupt),
    .auto_widget_in_a_ready           (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_a_ready),
    .auto_widget_in_d_valid           (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_valid),
    .auto_widget_in_d_bits_opcode     (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_opcode),
    .auto_widget_in_d_bits_param      (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_param),
    .auto_widget_in_d_bits_size       (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_size),
    .auto_widget_in_d_bits_source     (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_source),
    .auto_widget_in_d_bits_sink       (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_sink),
    .auto_widget_in_d_bits_denied     (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_denied),
    .auto_widget_in_d_bits_data       (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_data),
    .auto_widget_in_d_bits_corrupt    (_coupler_to_bus_named_subsystem_cbus_auto_widget_in_d_bits_corrupt),
    .auto_bus_xing_out_a_valid        (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_valid),
    .auto_bus_xing_out_a_bits_opcode  (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_opcode),
    .auto_bus_xing_out_a_bits_param   (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_param),
    .auto_bus_xing_out_a_bits_size    (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_size),
    .auto_bus_xing_out_a_bits_source  (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_source),
    .auto_bus_xing_out_a_bits_address (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_address),
    .auto_bus_xing_out_a_bits_mask    (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_mask),
    .auto_bus_xing_out_a_bits_data    (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_data),
    .auto_bus_xing_out_a_bits_corrupt (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_corrupt),
    .auto_bus_xing_out_d_ready        (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_ready)
  );
  TLInterconnectCoupler_1 coupler_from_bus_named_subsystem_fbus (
    .clock                           (_fixedClockNode_auto_out_0_clock),
    .reset                           (_fixedClockNode_auto_out_0_reset),
    .auto_widget_out_a_ready         (_fixer_auto_in_0_a_ready),
    .auto_widget_out_d_valid         (_fixer_auto_in_0_d_valid),
    .auto_widget_out_d_bits_opcode   (_fixer_auto_in_0_d_bits_opcode),
    .auto_widget_out_d_bits_param    (_fixer_auto_in_0_d_bits_param),
    .auto_widget_out_d_bits_size     (_fixer_auto_in_0_d_bits_size),
    .auto_widget_out_d_bits_source   (_fixer_auto_in_0_d_bits_source),
    .auto_widget_out_d_bits_sink     (_fixer_auto_in_0_d_bits_sink),
    .auto_widget_out_d_bits_denied   (_fixer_auto_in_0_d_bits_denied),
    .auto_widget_out_d_bits_data     (_fixer_auto_in_0_d_bits_data),
    .auto_widget_out_d_bits_corrupt  (_fixer_auto_in_0_d_bits_corrupt),
    .auto_bus_xing_in_a_valid        (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_valid),
    .auto_bus_xing_in_a_bits_opcode  (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_opcode),
    .auto_bus_xing_in_a_bits_param   (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_param),
    .auto_bus_xing_in_a_bits_size    (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_size),
    .auto_bus_xing_in_a_bits_source  (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_source),
    .auto_bus_xing_in_a_bits_address (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_address),
    .auto_bus_xing_in_a_bits_mask    (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_mask),
    .auto_bus_xing_in_a_bits_data    (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_data),
    .auto_bus_xing_in_a_bits_corrupt (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_corrupt),
    .auto_bus_xing_in_d_ready        (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_ready),
    .auto_widget_out_a_valid         (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_valid),
    .auto_widget_out_a_bits_opcode   (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_opcode),
    .auto_widget_out_a_bits_param    (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_param),
    .auto_widget_out_a_bits_size     (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_size),
    .auto_widget_out_a_bits_source   (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_source),
    .auto_widget_out_a_bits_address  (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_address),
    .auto_widget_out_a_bits_mask     (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_mask),
    .auto_widget_out_a_bits_data     (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_data),
    .auto_widget_out_a_bits_corrupt  (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_a_bits_corrupt),
    .auto_widget_out_d_ready         (_coupler_from_bus_named_subsystem_fbus_auto_widget_out_d_ready),
    .auto_bus_xing_in_a_ready        (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_ready),
    .auto_bus_xing_in_d_valid        (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_valid),
    .auto_bus_xing_in_d_bits_opcode  (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_opcode),
    .auto_bus_xing_in_d_bits_param   (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_param),
    .auto_bus_xing_in_d_bits_size    (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_size),
    .auto_bus_xing_in_d_bits_source  (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_source),
    .auto_bus_xing_in_d_bits_sink    (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_sink),
    .auto_bus_xing_in_d_bits_denied  (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_denied),
    .auto_bus_xing_in_d_bits_data    (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_data),
    .auto_bus_xing_in_d_bits_corrupt (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_corrupt)
  );
  TLInterconnectCoupler_2 coupler_to_bus_named_subsystem_l2 (
    .auto_widget_in_a_valid         (_system_bus_xbar_auto_out_1_a_valid),
    .auto_widget_in_a_bits_opcode   (_system_bus_xbar_auto_out_1_a_bits_opcode),
    .auto_widget_in_a_bits_param    (_system_bus_xbar_auto_out_1_a_bits_param),
    .auto_widget_in_a_bits_size     (_system_bus_xbar_auto_out_1_a_bits_size),
    .auto_widget_in_a_bits_source   (_system_bus_xbar_auto_out_1_a_bits_source),
    .auto_widget_in_a_bits_address  (_system_bus_xbar_auto_out_1_a_bits_address),
    .auto_widget_in_a_bits_mask     (_system_bus_xbar_auto_out_1_a_bits_mask),
    .auto_widget_in_a_bits_data     (_system_bus_xbar_auto_out_1_a_bits_data),
    .auto_widget_in_a_bits_corrupt  (_system_bus_xbar_auto_out_1_a_bits_corrupt),
    .auto_widget_in_b_ready         (_system_bus_xbar_auto_out_1_b_ready),
    .auto_widget_in_c_valid         (_system_bus_xbar_auto_out_1_c_valid),
    .auto_widget_in_c_bits_opcode   (_system_bus_xbar_auto_out_1_c_bits_opcode),
    .auto_widget_in_c_bits_param    (_system_bus_xbar_auto_out_1_c_bits_param),
    .auto_widget_in_c_bits_size     (_system_bus_xbar_auto_out_1_c_bits_size),
    .auto_widget_in_c_bits_source   (_system_bus_xbar_auto_out_1_c_bits_source),
    .auto_widget_in_c_bits_address  (_system_bus_xbar_auto_out_1_c_bits_address),
    .auto_widget_in_c_bits_data     (_system_bus_xbar_auto_out_1_c_bits_data),
    .auto_widget_in_c_bits_corrupt  (_system_bus_xbar_auto_out_1_c_bits_corrupt),
    .auto_widget_in_d_ready         (_system_bus_xbar_auto_out_1_d_ready),
    .auto_widget_in_e_valid         (_system_bus_xbar_auto_out_1_e_valid),
    .auto_widget_in_e_bits_sink     (_system_bus_xbar_auto_out_1_e_bits_sink),
    .auto_widget_out_a_ready        (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_ready),
    .auto_widget_out_b_valid        (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_valid),
    .auto_widget_out_b_bits_param   (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_param),
    .auto_widget_out_b_bits_address (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_address),
    .auto_widget_out_c_ready        (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_ready),
    .auto_widget_out_d_valid        (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_valid),
    .auto_widget_out_d_bits_opcode  (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_opcode),
    .auto_widget_out_d_bits_param   (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_param),
    .auto_widget_out_d_bits_size    (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_size),
    .auto_widget_out_d_bits_source  (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_source),
    .auto_widget_out_d_bits_sink    (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_sink),
    .auto_widget_out_d_bits_denied  (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_denied),
    .auto_widget_out_d_bits_data    (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_data),
    .auto_widget_out_d_bits_corrupt (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_corrupt),
    .auto_widget_in_a_ready         (_coupler_to_bus_named_subsystem_l2_auto_widget_in_a_ready),
    .auto_widget_in_b_valid         (_coupler_to_bus_named_subsystem_l2_auto_widget_in_b_valid),
    .auto_widget_in_b_bits_param    (_coupler_to_bus_named_subsystem_l2_auto_widget_in_b_bits_param),
    .auto_widget_in_b_bits_address  (_coupler_to_bus_named_subsystem_l2_auto_widget_in_b_bits_address),
    .auto_widget_in_c_ready         (_coupler_to_bus_named_subsystem_l2_auto_widget_in_c_ready),
    .auto_widget_in_d_valid         (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_valid),
    .auto_widget_in_d_bits_opcode   (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_opcode),
    .auto_widget_in_d_bits_param    (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_param),
    .auto_widget_in_d_bits_size     (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_size),
    .auto_widget_in_d_bits_source   (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_source),
    .auto_widget_in_d_bits_sink     (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_sink),
    .auto_widget_in_d_bits_denied   (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_denied),
    .auto_widget_in_d_bits_data     (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_data),
    .auto_widget_in_d_bits_corrupt  (_coupler_to_bus_named_subsystem_l2_auto_widget_in_d_bits_corrupt),
    .auto_widget_out_a_valid        (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_valid),
    .auto_widget_out_a_bits_opcode  (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_opcode),
    .auto_widget_out_a_bits_param   (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_param),
    .auto_widget_out_a_bits_size    (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_size),
    .auto_widget_out_a_bits_source  (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_source),
    .auto_widget_out_a_bits_address (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_address),
    .auto_widget_out_a_bits_mask    (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_mask),
    .auto_widget_out_a_bits_data    (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_data),
    .auto_widget_out_a_bits_corrupt (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_corrupt),
    .auto_widget_out_b_ready        (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_ready),
    .auto_widget_out_c_valid        (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_valid),
    .auto_widget_out_c_bits_opcode  (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_opcode),
    .auto_widget_out_c_bits_param   (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_param),
    .auto_widget_out_c_bits_size    (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_size),
    .auto_widget_out_c_bits_source  (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_source),
    .auto_widget_out_c_bits_address (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_address),
    .auto_widget_out_c_bits_data    (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_data),
    .auto_widget_out_c_bits_corrupt (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_corrupt),
    .auto_widget_out_d_ready        (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_ready),
    .auto_widget_out_e_valid        (auto_coupler_to_bus_named_subsystem_l2_widget_out_e_valid),
    .auto_widget_out_e_bits_sink    (auto_coupler_to_bus_named_subsystem_l2_widget_out_e_bits_sink)
  );
  TLInterconnectCoupler_3 coupler_from_boom_tile (
    .auto_tl_master_clock_xing_in_a_valid        (auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_valid),
    .auto_tl_master_clock_xing_in_a_bits_opcode  (auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_bits_opcode),
    .auto_tl_master_clock_xing_in_a_bits_param   (auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_bits_param),
    .auto_tl_master_clock_xing_in_a_bits_size    (auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_bits_size),
    .auto_tl_master_clock_xing_in_a_bits_source  (auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_bits_source),
    .auto_tl_master_clock_xing_in_a_bits_address (auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_bits_address),
    .auto_tl_master_clock_xing_in_a_bits_mask    (auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_bits_mask),
    .auto_tl_master_clock_xing_in_a_bits_data    (auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_bits_data),
    .auto_tl_master_clock_xing_in_a_bits_corrupt (auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_bits_corrupt),
    .auto_tl_master_clock_xing_in_b_ready        (auto_coupler_from_boom_tile_tl_master_clock_xing_in_b_ready),
    .auto_tl_master_clock_xing_in_c_valid        (auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_valid),
    .auto_tl_master_clock_xing_in_c_bits_opcode  (auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_bits_opcode),
    .auto_tl_master_clock_xing_in_c_bits_param   (auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_bits_param),
    .auto_tl_master_clock_xing_in_c_bits_size    (auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_bits_size),
    .auto_tl_master_clock_xing_in_c_bits_source  (auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_bits_source),
    .auto_tl_master_clock_xing_in_c_bits_address (auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_bits_address),
    .auto_tl_master_clock_xing_in_c_bits_data    (auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_bits_data),
    .auto_tl_master_clock_xing_in_c_bits_corrupt (auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_bits_corrupt),
    .auto_tl_master_clock_xing_in_d_ready        (auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_ready),
    .auto_tl_master_clock_xing_in_e_valid        (auto_coupler_from_boom_tile_tl_master_clock_xing_in_e_valid),
    .auto_tl_master_clock_xing_in_e_bits_sink    (auto_coupler_from_boom_tile_tl_master_clock_xing_in_e_bits_sink),
    .auto_tl_out_a_ready                         (_fixer_auto_in_1_a_ready),
    .auto_tl_out_b_valid                         (_fixer_auto_in_1_b_valid),
    .auto_tl_out_b_bits_param                    (_fixer_auto_in_1_b_bits_param),
    .auto_tl_out_b_bits_address                  (_fixer_auto_in_1_b_bits_address),
    .auto_tl_out_c_ready                         (_fixer_auto_in_1_c_ready),
    .auto_tl_out_d_valid                         (_fixer_auto_in_1_d_valid),
    .auto_tl_out_d_bits_opcode                   (_fixer_auto_in_1_d_bits_opcode),
    .auto_tl_out_d_bits_param                    (_fixer_auto_in_1_d_bits_param),
    .auto_tl_out_d_bits_size                     (_fixer_auto_in_1_d_bits_size),
    .auto_tl_out_d_bits_source                   (_fixer_auto_in_1_d_bits_source),
    .auto_tl_out_d_bits_sink                     (_fixer_auto_in_1_d_bits_sink),
    .auto_tl_out_d_bits_denied                   (_fixer_auto_in_1_d_bits_denied),
    .auto_tl_out_d_bits_data                     (_fixer_auto_in_1_d_bits_data),
    .auto_tl_out_d_bits_corrupt                  (_fixer_auto_in_1_d_bits_corrupt),
    .auto_tl_master_clock_xing_in_a_ready        (auto_coupler_from_boom_tile_tl_master_clock_xing_in_a_ready),
    .auto_tl_master_clock_xing_in_b_valid        (auto_coupler_from_boom_tile_tl_master_clock_xing_in_b_valid),
    .auto_tl_master_clock_xing_in_b_bits_param   (auto_coupler_from_boom_tile_tl_master_clock_xing_in_b_bits_param),
    .auto_tl_master_clock_xing_in_b_bits_address (auto_coupler_from_boom_tile_tl_master_clock_xing_in_b_bits_address),
    .auto_tl_master_clock_xing_in_c_ready        (auto_coupler_from_boom_tile_tl_master_clock_xing_in_c_ready),
    .auto_tl_master_clock_xing_in_d_valid        (auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_valid),
    .auto_tl_master_clock_xing_in_d_bits_opcode  (auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_bits_opcode),
    .auto_tl_master_clock_xing_in_d_bits_param   (auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_bits_param),
    .auto_tl_master_clock_xing_in_d_bits_size    (auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_bits_size),
    .auto_tl_master_clock_xing_in_d_bits_source  (auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_bits_source),
    .auto_tl_master_clock_xing_in_d_bits_sink    (auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_bits_sink),
    .auto_tl_master_clock_xing_in_d_bits_denied  (auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_bits_denied),
    .auto_tl_master_clock_xing_in_d_bits_data    (auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_bits_data),
    .auto_tl_master_clock_xing_in_d_bits_corrupt (auto_coupler_from_boom_tile_tl_master_clock_xing_in_d_bits_corrupt),
    .auto_tl_out_a_valid                         (_coupler_from_boom_tile_auto_tl_out_a_valid),
    .auto_tl_out_a_bits_opcode                   (_coupler_from_boom_tile_auto_tl_out_a_bits_opcode),
    .auto_tl_out_a_bits_param                    (_coupler_from_boom_tile_auto_tl_out_a_bits_param),
    .auto_tl_out_a_bits_size                     (_coupler_from_boom_tile_auto_tl_out_a_bits_size),
    .auto_tl_out_a_bits_source                   (_coupler_from_boom_tile_auto_tl_out_a_bits_source),
    .auto_tl_out_a_bits_address                  (_coupler_from_boom_tile_auto_tl_out_a_bits_address),
    .auto_tl_out_a_bits_mask                     (_coupler_from_boom_tile_auto_tl_out_a_bits_mask),
    .auto_tl_out_a_bits_data                     (_coupler_from_boom_tile_auto_tl_out_a_bits_data),
    .auto_tl_out_a_bits_corrupt                  (_coupler_from_boom_tile_auto_tl_out_a_bits_corrupt),
    .auto_tl_out_b_ready                         (_coupler_from_boom_tile_auto_tl_out_b_ready),
    .auto_tl_out_c_valid                         (_coupler_from_boom_tile_auto_tl_out_c_valid),
    .auto_tl_out_c_bits_opcode                   (_coupler_from_boom_tile_auto_tl_out_c_bits_opcode),
    .auto_tl_out_c_bits_param                    (_coupler_from_boom_tile_auto_tl_out_c_bits_param),
    .auto_tl_out_c_bits_size                     (_coupler_from_boom_tile_auto_tl_out_c_bits_size),
    .auto_tl_out_c_bits_source                   (_coupler_from_boom_tile_auto_tl_out_c_bits_source),
    .auto_tl_out_c_bits_address                  (_coupler_from_boom_tile_auto_tl_out_c_bits_address),
    .auto_tl_out_c_bits_data                     (_coupler_from_boom_tile_auto_tl_out_c_bits_data),
    .auto_tl_out_c_bits_corrupt                  (_coupler_from_boom_tile_auto_tl_out_c_bits_corrupt),
    .auto_tl_out_d_ready                         (_coupler_from_boom_tile_auto_tl_out_d_ready),
    .auto_tl_out_e_valid                         (_coupler_from_boom_tile_auto_tl_out_e_valid),
    .auto_tl_out_e_bits_sink                     (_coupler_from_boom_tile_auto_tl_out_e_bits_sink)
  );
endmodule

