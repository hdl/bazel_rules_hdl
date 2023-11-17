// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module CoherenceManagerWrapper(
  input          auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_ready,
                 auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_valid,
  input  [2:0]   auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_opcode,
                 auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_size,
  input  [4:0]   auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_source,
  input          auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_denied,
  input  [63:0]  auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_data,
  input          auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_corrupt,
                 auto_coherent_jbar_in_a_valid,
  input  [2:0]   auto_coherent_jbar_in_a_bits_opcode,
                 auto_coherent_jbar_in_a_bits_param,
                 auto_coherent_jbar_in_a_bits_size,
  input  [5:0]   auto_coherent_jbar_in_a_bits_source,
  input  [31:0]  auto_coherent_jbar_in_a_bits_address,
  input  [15:0]  auto_coherent_jbar_in_a_bits_mask,
  input  [127:0] auto_coherent_jbar_in_a_bits_data,
  input          auto_coherent_jbar_in_a_bits_corrupt,
                 auto_coherent_jbar_in_b_ready,
                 auto_coherent_jbar_in_c_valid,
  input  [2:0]   auto_coherent_jbar_in_c_bits_opcode,
                 auto_coherent_jbar_in_c_bits_param,
                 auto_coherent_jbar_in_c_bits_size,
  input  [5:0]   auto_coherent_jbar_in_c_bits_source,
  input  [31:0]  auto_coherent_jbar_in_c_bits_address,
  input  [127:0] auto_coherent_jbar_in_c_bits_data,
  input          auto_coherent_jbar_in_c_bits_corrupt,
                 auto_coherent_jbar_in_d_ready,
                 auto_coherent_jbar_in_e_valid,
  input  [3:0]   auto_coherent_jbar_in_e_bits_sink,
  input          auto_l2_ctrls_ctrl_in_a_valid,
  input  [2:0]   auto_l2_ctrls_ctrl_in_a_bits_opcode,
                 auto_l2_ctrls_ctrl_in_a_bits_param,
  input  [1:0]   auto_l2_ctrls_ctrl_in_a_bits_size,
  input  [10:0]  auto_l2_ctrls_ctrl_in_a_bits_source,
  input  [25:0]  auto_l2_ctrls_ctrl_in_a_bits_address,
  input  [7:0]   auto_l2_ctrls_ctrl_in_a_bits_mask,
  input  [63:0]  auto_l2_ctrls_ctrl_in_a_bits_data,
  input          auto_l2_ctrls_ctrl_in_a_bits_corrupt,
                 auto_l2_ctrls_ctrl_in_d_ready,
                 auto_subsystem_l2_clock_groups_in_member_subsystem_l2_0_clock,
                 auto_subsystem_l2_clock_groups_in_member_subsystem_l2_0_reset,
  output         auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_valid,
  output [2:0]   auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_opcode,
                 auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_param,
                 auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_size,
  output [4:0]   auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_source,
  output [31:0]  auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_address,
  output [7:0]   auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_mask,
  output [63:0]  auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_data,
  output         auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_corrupt,
                 auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_ready,
                 auto_coherent_jbar_in_a_ready,
                 auto_coherent_jbar_in_b_valid,
  output [1:0]   auto_coherent_jbar_in_b_bits_param,
  output [31:0]  auto_coherent_jbar_in_b_bits_address,
  output         auto_coherent_jbar_in_c_ready,
                 auto_coherent_jbar_in_d_valid,
  output [2:0]   auto_coherent_jbar_in_d_bits_opcode,
  output [1:0]   auto_coherent_jbar_in_d_bits_param,
  output [2:0]   auto_coherent_jbar_in_d_bits_size,
  output [5:0]   auto_coherent_jbar_in_d_bits_source,
  output [3:0]   auto_coherent_jbar_in_d_bits_sink,
  output         auto_coherent_jbar_in_d_bits_denied,
  output [127:0] auto_coherent_jbar_in_d_bits_data,
  output         auto_coherent_jbar_in_d_bits_corrupt,
                 auto_l2_ctrls_ctrl_in_a_ready,
                 auto_l2_ctrls_ctrl_in_d_valid,
  output [2:0]   auto_l2_ctrls_ctrl_in_d_bits_opcode,
  output [1:0]   auto_l2_ctrls_ctrl_in_d_bits_size,
  output [10:0]  auto_l2_ctrls_ctrl_in_d_bits_source,
  output [63:0]  auto_l2_ctrls_ctrl_in_d_bits_data
);

  wire         _coupler_to_bus_named_subsystem_mbus_auto_widget_in_a_ready;
  wire         _coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_valid;
  wire [2:0]   _coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_opcode;
  wire [2:0]   _coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_size;
  wire [4:0]   _coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_source;
  wire         _coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_denied;
  wire [63:0]  _coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_data;
  wire         _coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_corrupt;
  wire         _binder_auto_in_a_ready;
  wire         _binder_auto_in_d_valid;
  wire [2:0]   _binder_auto_in_d_bits_opcode;
  wire [2:0]   _binder_auto_in_d_bits_size;
  wire [4:0]   _binder_auto_in_d_bits_source;
  wire         _binder_auto_in_d_bits_denied;
  wire [63:0]  _binder_auto_in_d_bits_data;
  wire         _binder_auto_in_d_bits_corrupt;
  wire         _binder_auto_out_a_valid;
  wire [2:0]   _binder_auto_out_a_bits_opcode;
  wire [2:0]   _binder_auto_out_a_bits_param;
  wire [2:0]   _binder_auto_out_a_bits_size;
  wire [4:0]   _binder_auto_out_a_bits_source;
  wire [31:0]  _binder_auto_out_a_bits_address;
  wire [7:0]   _binder_auto_out_a_bits_mask;
  wire [63:0]  _binder_auto_out_a_bits_data;
  wire         _binder_auto_out_a_bits_corrupt;
  wire         _binder_auto_out_d_ready;
  wire         _coherent_jbar_auto_out_a_valid;
  wire [2:0]   _coherent_jbar_auto_out_a_bits_opcode;
  wire [2:0]   _coherent_jbar_auto_out_a_bits_param;
  wire [2:0]   _coherent_jbar_auto_out_a_bits_size;
  wire [5:0]   _coherent_jbar_auto_out_a_bits_source;
  wire [31:0]  _coherent_jbar_auto_out_a_bits_address;
  wire [15:0]  _coherent_jbar_auto_out_a_bits_mask;
  wire [127:0] _coherent_jbar_auto_out_a_bits_data;
  wire         _coherent_jbar_auto_out_a_bits_corrupt;
  wire         _coherent_jbar_auto_out_b_ready;
  wire         _coherent_jbar_auto_out_c_valid;
  wire [2:0]   _coherent_jbar_auto_out_c_bits_opcode;
  wire [2:0]   _coherent_jbar_auto_out_c_bits_param;
  wire [2:0]   _coherent_jbar_auto_out_c_bits_size;
  wire [5:0]   _coherent_jbar_auto_out_c_bits_source;
  wire [31:0]  _coherent_jbar_auto_out_c_bits_address;
  wire [127:0] _coherent_jbar_auto_out_c_bits_data;
  wire         _coherent_jbar_auto_out_c_bits_corrupt;
  wire         _coherent_jbar_auto_out_d_ready;
  wire         _coherent_jbar_auto_out_e_valid;
  wire [3:0]   _coherent_jbar_auto_out_e_bits_sink;
  wire         _cork_auto_in_a_ready;
  wire         _cork_auto_in_c_ready;
  wire         _cork_auto_in_d_valid;
  wire [2:0]   _cork_auto_in_d_bits_opcode;
  wire [1:0]   _cork_auto_in_d_bits_param;
  wire [2:0]   _cork_auto_in_d_bits_size;
  wire [3:0]   _cork_auto_in_d_bits_source;
  wire [2:0]   _cork_auto_in_d_bits_sink;
  wire         _cork_auto_in_d_bits_denied;
  wire [63:0]  _cork_auto_in_d_bits_data;
  wire         _cork_auto_in_d_bits_corrupt;
  wire         _cork_auto_out_a_valid;
  wire [2:0]   _cork_auto_out_a_bits_opcode;
  wire [2:0]   _cork_auto_out_a_bits_param;
  wire [2:0]   _cork_auto_out_a_bits_size;
  wire [4:0]   _cork_auto_out_a_bits_source;
  wire [31:0]  _cork_auto_out_a_bits_address;
  wire [7:0]   _cork_auto_out_a_bits_mask;
  wire [63:0]  _cork_auto_out_a_bits_data;
  wire         _cork_auto_out_a_bits_corrupt;
  wire         _cork_auto_out_d_ready;
  wire         _InclusiveCache_outer_TLBuffer_auto_in_a_ready;
  wire         _InclusiveCache_outer_TLBuffer_auto_in_c_ready;
  wire         _InclusiveCache_outer_TLBuffer_auto_in_d_valid;
  wire [2:0]   _InclusiveCache_outer_TLBuffer_auto_in_d_bits_opcode;
  wire [1:0]   _InclusiveCache_outer_TLBuffer_auto_in_d_bits_param;
  wire [2:0]   _InclusiveCache_outer_TLBuffer_auto_in_d_bits_size;
  wire [3:0]   _InclusiveCache_outer_TLBuffer_auto_in_d_bits_source;
  wire [2:0]   _InclusiveCache_outer_TLBuffer_auto_in_d_bits_sink;
  wire         _InclusiveCache_outer_TLBuffer_auto_in_d_bits_denied;
  wire [63:0]  _InclusiveCache_outer_TLBuffer_auto_in_d_bits_data;
  wire         _InclusiveCache_outer_TLBuffer_auto_in_d_bits_corrupt;
  wire         _InclusiveCache_outer_TLBuffer_auto_out_a_valid;
  wire [2:0]   _InclusiveCache_outer_TLBuffer_auto_out_a_bits_opcode;
  wire [2:0]   _InclusiveCache_outer_TLBuffer_auto_out_a_bits_param;
  wire [2:0]   _InclusiveCache_outer_TLBuffer_auto_out_a_bits_size;
  wire [3:0]   _InclusiveCache_outer_TLBuffer_auto_out_a_bits_source;
  wire [31:0]  _InclusiveCache_outer_TLBuffer_auto_out_a_bits_address;
  wire [7:0]   _InclusiveCache_outer_TLBuffer_auto_out_a_bits_mask;
  wire [63:0]  _InclusiveCache_outer_TLBuffer_auto_out_a_bits_data;
  wire         _InclusiveCache_outer_TLBuffer_auto_out_a_bits_corrupt;
  wire         _InclusiveCache_outer_TLBuffer_auto_out_c_valid;
  wire [2:0]   _InclusiveCache_outer_TLBuffer_auto_out_c_bits_opcode;
  wire [2:0]   _InclusiveCache_outer_TLBuffer_auto_out_c_bits_param;
  wire [2:0]   _InclusiveCache_outer_TLBuffer_auto_out_c_bits_size;
  wire [3:0]   _InclusiveCache_outer_TLBuffer_auto_out_c_bits_source;
  wire [31:0]  _InclusiveCache_outer_TLBuffer_auto_out_c_bits_address;
  wire [63:0]  _InclusiveCache_outer_TLBuffer_auto_out_c_bits_data;
  wire         _InclusiveCache_outer_TLBuffer_auto_out_c_bits_corrupt;
  wire         _InclusiveCache_outer_TLBuffer_auto_out_d_ready;
  wire         _InclusiveCache_outer_TLBuffer_auto_out_e_valid;
  wire [2:0]   _InclusiveCache_outer_TLBuffer_auto_out_e_bits_sink;
  wire         _InclusiveCache_inner_TLBuffer_auto_in_a_ready;
  wire         _InclusiveCache_inner_TLBuffer_auto_in_b_valid;
  wire [1:0]   _InclusiveCache_inner_TLBuffer_auto_in_b_bits_param;
  wire [31:0]  _InclusiveCache_inner_TLBuffer_auto_in_b_bits_address;
  wire         _InclusiveCache_inner_TLBuffer_auto_in_c_ready;
  wire         _InclusiveCache_inner_TLBuffer_auto_in_d_valid;
  wire [2:0]   _InclusiveCache_inner_TLBuffer_auto_in_d_bits_opcode;
  wire [1:0]   _InclusiveCache_inner_TLBuffer_auto_in_d_bits_param;
  wire [2:0]   _InclusiveCache_inner_TLBuffer_auto_in_d_bits_size;
  wire [5:0]   _InclusiveCache_inner_TLBuffer_auto_in_d_bits_source;
  wire [3:0]   _InclusiveCache_inner_TLBuffer_auto_in_d_bits_sink;
  wire         _InclusiveCache_inner_TLBuffer_auto_in_d_bits_denied;
  wire [127:0] _InclusiveCache_inner_TLBuffer_auto_in_d_bits_data;
  wire         _InclusiveCache_inner_TLBuffer_auto_in_d_bits_corrupt;
  wire         _InclusiveCache_inner_TLBuffer_auto_out_a_valid;
  wire [2:0]   _InclusiveCache_inner_TLBuffer_auto_out_a_bits_opcode;
  wire [2:0]   _InclusiveCache_inner_TLBuffer_auto_out_a_bits_param;
  wire [2:0]   _InclusiveCache_inner_TLBuffer_auto_out_a_bits_size;
  wire [5:0]   _InclusiveCache_inner_TLBuffer_auto_out_a_bits_source;
  wire [31:0]  _InclusiveCache_inner_TLBuffer_auto_out_a_bits_address;
  wire [15:0]  _InclusiveCache_inner_TLBuffer_auto_out_a_bits_mask;
  wire [127:0] _InclusiveCache_inner_TLBuffer_auto_out_a_bits_data;
  wire         _InclusiveCache_inner_TLBuffer_auto_out_a_bits_corrupt;
  wire         _InclusiveCache_inner_TLBuffer_auto_out_b_ready;
  wire         _InclusiveCache_inner_TLBuffer_auto_out_c_valid;
  wire [2:0]   _InclusiveCache_inner_TLBuffer_auto_out_c_bits_opcode;
  wire [2:0]   _InclusiveCache_inner_TLBuffer_auto_out_c_bits_param;
  wire [2:0]   _InclusiveCache_inner_TLBuffer_auto_out_c_bits_size;
  wire [5:0]   _InclusiveCache_inner_TLBuffer_auto_out_c_bits_source;
  wire [31:0]  _InclusiveCache_inner_TLBuffer_auto_out_c_bits_address;
  wire [127:0] _InclusiveCache_inner_TLBuffer_auto_out_c_bits_data;
  wire         _InclusiveCache_inner_TLBuffer_auto_out_c_bits_corrupt;
  wire         _InclusiveCache_inner_TLBuffer_auto_out_d_ready;
  wire         _InclusiveCache_inner_TLBuffer_auto_out_e_valid;
  wire [3:0]   _InclusiveCache_inner_TLBuffer_auto_out_e_bits_sink;
  wire         _filter_auto_in_a_ready;
  wire         _filter_auto_in_b_valid;
  wire [1:0]   _filter_auto_in_b_bits_param;
  wire [31:0]  _filter_auto_in_b_bits_address;
  wire         _filter_auto_in_c_ready;
  wire         _filter_auto_in_d_valid;
  wire [2:0]   _filter_auto_in_d_bits_opcode;
  wire [1:0]   _filter_auto_in_d_bits_param;
  wire [2:0]   _filter_auto_in_d_bits_size;
  wire [5:0]   _filter_auto_in_d_bits_source;
  wire [3:0]   _filter_auto_in_d_bits_sink;
  wire         _filter_auto_in_d_bits_denied;
  wire [127:0] _filter_auto_in_d_bits_data;
  wire         _filter_auto_in_d_bits_corrupt;
  wire         _filter_auto_out_a_valid;
  wire [2:0]   _filter_auto_out_a_bits_opcode;
  wire [2:0]   _filter_auto_out_a_bits_param;
  wire [2:0]   _filter_auto_out_a_bits_size;
  wire [5:0]   _filter_auto_out_a_bits_source;
  wire [31:0]  _filter_auto_out_a_bits_address;
  wire [15:0]  _filter_auto_out_a_bits_mask;
  wire [127:0] _filter_auto_out_a_bits_data;
  wire         _filter_auto_out_a_bits_corrupt;
  wire         _filter_auto_out_b_ready;
  wire         _filter_auto_out_c_valid;
  wire [2:0]   _filter_auto_out_c_bits_opcode;
  wire [2:0]   _filter_auto_out_c_bits_param;
  wire [2:0]   _filter_auto_out_c_bits_size;
  wire [5:0]   _filter_auto_out_c_bits_source;
  wire [31:0]  _filter_auto_out_c_bits_address;
  wire [127:0] _filter_auto_out_c_bits_data;
  wire         _filter_auto_out_c_bits_corrupt;
  wire         _filter_auto_out_d_ready;
  wire         _filter_auto_out_e_valid;
  wire [3:0]   _filter_auto_out_e_bits_sink;
  wire         _l2_auto_in_a_ready;
  wire         _l2_auto_in_b_valid;
  wire [1:0]   _l2_auto_in_b_bits_param;
  wire [31:0]  _l2_auto_in_b_bits_address;
  wire         _l2_auto_in_c_ready;
  wire         _l2_auto_in_d_valid;
  wire [2:0]   _l2_auto_in_d_bits_opcode;
  wire [1:0]   _l2_auto_in_d_bits_param;
  wire [2:0]   _l2_auto_in_d_bits_size;
  wire [5:0]   _l2_auto_in_d_bits_source;
  wire [3:0]   _l2_auto_in_d_bits_sink;
  wire         _l2_auto_in_d_bits_denied;
  wire [127:0] _l2_auto_in_d_bits_data;
  wire         _l2_auto_in_d_bits_corrupt;
  wire         _l2_auto_out_a_valid;
  wire [2:0]   _l2_auto_out_a_bits_opcode;
  wire [2:0]   _l2_auto_out_a_bits_param;
  wire [2:0]   _l2_auto_out_a_bits_size;
  wire [3:0]   _l2_auto_out_a_bits_source;
  wire [31:0]  _l2_auto_out_a_bits_address;
  wire [7:0]   _l2_auto_out_a_bits_mask;
  wire [63:0]  _l2_auto_out_a_bits_data;
  wire         _l2_auto_out_a_bits_corrupt;
  wire         _l2_auto_out_c_valid;
  wire [2:0]   _l2_auto_out_c_bits_opcode;
  wire [2:0]   _l2_auto_out_c_bits_param;
  wire [2:0]   _l2_auto_out_c_bits_size;
  wire [3:0]   _l2_auto_out_c_bits_source;
  wire [31:0]  _l2_auto_out_c_bits_address;
  wire [63:0]  _l2_auto_out_c_bits_data;
  wire         _l2_auto_out_c_bits_corrupt;
  wire         _l2_auto_out_d_ready;
  wire         _l2_auto_out_e_valid;
  wire [2:0]   _l2_auto_out_e_bits_sink;
  wire         _fixedClockNode_auto_out_clock;
  wire         _fixedClockNode_auto_out_reset;
  wire         _clockGroup_auto_out_clock;
  wire         _clockGroup_auto_out_reset;
  wire         _subsystem_l2_clock_groups_auto_out_clock;
  wire         _subsystem_l2_clock_groups_auto_out_reset;
  ClockGroup subsystem_l2_clock_groups (
    .auto_in_member_subsystem_sbus_0_clock (auto_subsystem_l2_clock_groups_in_member_subsystem_l2_0_clock),
    .auto_in_member_subsystem_sbus_0_reset (auto_subsystem_l2_clock_groups_in_member_subsystem_l2_0_reset),
    .auto_out_clock                        (_subsystem_l2_clock_groups_auto_out_clock),
    .auto_out_reset                        (_subsystem_l2_clock_groups_auto_out_reset)
  );
  ClockGroup clockGroup (
    .auto_in_member_subsystem_sbus_0_clock (_subsystem_l2_clock_groups_auto_out_clock),
    .auto_in_member_subsystem_sbus_0_reset (_subsystem_l2_clock_groups_auto_out_reset),
    .auto_out_clock                        (_clockGroup_auto_out_clock),
    .auto_out_reset                        (_clockGroup_auto_out_reset)
  );
  ClockGroup fixedClockNode (
    .auto_in_member_subsystem_sbus_0_clock (_clockGroup_auto_out_clock),
    .auto_in_member_subsystem_sbus_0_reset (_clockGroup_auto_out_reset),
    .auto_out_clock                        (_fixedClockNode_auto_out_clock),
    .auto_out_reset                        (_fixedClockNode_auto_out_reset)
  );
  InclusiveCache l2 (
    .clock                             (_fixedClockNode_auto_out_clock),
    .reset                             (_fixedClockNode_auto_out_reset),
    .auto_ctrls_ctrl_in_a_valid        (auto_l2_ctrls_ctrl_in_a_valid),
    .auto_ctrls_ctrl_in_a_bits_opcode  (auto_l2_ctrls_ctrl_in_a_bits_opcode),
    .auto_ctrls_ctrl_in_a_bits_param   (auto_l2_ctrls_ctrl_in_a_bits_param),
    .auto_ctrls_ctrl_in_a_bits_size    (auto_l2_ctrls_ctrl_in_a_bits_size),
    .auto_ctrls_ctrl_in_a_bits_source  (auto_l2_ctrls_ctrl_in_a_bits_source),
    .auto_ctrls_ctrl_in_a_bits_address (auto_l2_ctrls_ctrl_in_a_bits_address),
    .auto_ctrls_ctrl_in_a_bits_mask    (auto_l2_ctrls_ctrl_in_a_bits_mask),
    .auto_ctrls_ctrl_in_a_bits_data    (auto_l2_ctrls_ctrl_in_a_bits_data),
    .auto_ctrls_ctrl_in_a_bits_corrupt (auto_l2_ctrls_ctrl_in_a_bits_corrupt),
    .auto_ctrls_ctrl_in_d_ready        (auto_l2_ctrls_ctrl_in_d_ready),
    .auto_in_a_valid                   (_InclusiveCache_inner_TLBuffer_auto_out_a_valid),
    .auto_in_a_bits_opcode             (_InclusiveCache_inner_TLBuffer_auto_out_a_bits_opcode),
    .auto_in_a_bits_param              (_InclusiveCache_inner_TLBuffer_auto_out_a_bits_param),
    .auto_in_a_bits_size               (_InclusiveCache_inner_TLBuffer_auto_out_a_bits_size),
    .auto_in_a_bits_source             (_InclusiveCache_inner_TLBuffer_auto_out_a_bits_source),
    .auto_in_a_bits_address            (_InclusiveCache_inner_TLBuffer_auto_out_a_bits_address),
    .auto_in_a_bits_mask               (_InclusiveCache_inner_TLBuffer_auto_out_a_bits_mask),
    .auto_in_a_bits_data               (_InclusiveCache_inner_TLBuffer_auto_out_a_bits_data),
    .auto_in_a_bits_corrupt            (_InclusiveCache_inner_TLBuffer_auto_out_a_bits_corrupt),
    .auto_in_b_ready                   (_InclusiveCache_inner_TLBuffer_auto_out_b_ready),
    .auto_in_c_valid                   (_InclusiveCache_inner_TLBuffer_auto_out_c_valid),
    .auto_in_c_bits_opcode             (_InclusiveCache_inner_TLBuffer_auto_out_c_bits_opcode),
    .auto_in_c_bits_param              (_InclusiveCache_inner_TLBuffer_auto_out_c_bits_param),
    .auto_in_c_bits_size               (_InclusiveCache_inner_TLBuffer_auto_out_c_bits_size),
    .auto_in_c_bits_source             (_InclusiveCache_inner_TLBuffer_auto_out_c_bits_source),
    .auto_in_c_bits_address            (_InclusiveCache_inner_TLBuffer_auto_out_c_bits_address),
    .auto_in_c_bits_data               (_InclusiveCache_inner_TLBuffer_auto_out_c_bits_data),
    .auto_in_c_bits_corrupt            (_InclusiveCache_inner_TLBuffer_auto_out_c_bits_corrupt),
    .auto_in_d_ready                   (_InclusiveCache_inner_TLBuffer_auto_out_d_ready),
    .auto_in_e_valid                   (_InclusiveCache_inner_TLBuffer_auto_out_e_valid),
    .auto_in_e_bits_sink               (_InclusiveCache_inner_TLBuffer_auto_out_e_bits_sink),
    .auto_out_a_ready                  (_InclusiveCache_outer_TLBuffer_auto_in_a_ready),
    .auto_out_c_ready                  (_InclusiveCache_outer_TLBuffer_auto_in_c_ready),
    .auto_out_d_valid                  (_InclusiveCache_outer_TLBuffer_auto_in_d_valid),
    .auto_out_d_bits_opcode            (_InclusiveCache_outer_TLBuffer_auto_in_d_bits_opcode),
    .auto_out_d_bits_param             (_InclusiveCache_outer_TLBuffer_auto_in_d_bits_param),
    .auto_out_d_bits_size              (_InclusiveCache_outer_TLBuffer_auto_in_d_bits_size),
    .auto_out_d_bits_source            (_InclusiveCache_outer_TLBuffer_auto_in_d_bits_source),
    .auto_out_d_bits_sink              (_InclusiveCache_outer_TLBuffer_auto_in_d_bits_sink),
    .auto_out_d_bits_denied            (_InclusiveCache_outer_TLBuffer_auto_in_d_bits_denied),
    .auto_out_d_bits_data              (_InclusiveCache_outer_TLBuffer_auto_in_d_bits_data),
    .auto_out_d_bits_corrupt           (_InclusiveCache_outer_TLBuffer_auto_in_d_bits_corrupt),
    .auto_ctrls_ctrl_in_a_ready        (auto_l2_ctrls_ctrl_in_a_ready),
    .auto_ctrls_ctrl_in_d_valid        (auto_l2_ctrls_ctrl_in_d_valid),
    .auto_ctrls_ctrl_in_d_bits_opcode  (auto_l2_ctrls_ctrl_in_d_bits_opcode),
    .auto_ctrls_ctrl_in_d_bits_size    (auto_l2_ctrls_ctrl_in_d_bits_size),
    .auto_ctrls_ctrl_in_d_bits_source  (auto_l2_ctrls_ctrl_in_d_bits_source),
    .auto_ctrls_ctrl_in_d_bits_data    (auto_l2_ctrls_ctrl_in_d_bits_data),
    .auto_in_a_ready                   (_l2_auto_in_a_ready),
    .auto_in_b_valid                   (_l2_auto_in_b_valid),
    .auto_in_b_bits_param              (_l2_auto_in_b_bits_param),
    .auto_in_b_bits_address            (_l2_auto_in_b_bits_address),
    .auto_in_c_ready                   (_l2_auto_in_c_ready),
    .auto_in_d_valid                   (_l2_auto_in_d_valid),
    .auto_in_d_bits_opcode             (_l2_auto_in_d_bits_opcode),
    .auto_in_d_bits_param              (_l2_auto_in_d_bits_param),
    .auto_in_d_bits_size               (_l2_auto_in_d_bits_size),
    .auto_in_d_bits_source             (_l2_auto_in_d_bits_source),
    .auto_in_d_bits_sink               (_l2_auto_in_d_bits_sink),
    .auto_in_d_bits_denied             (_l2_auto_in_d_bits_denied),
    .auto_in_d_bits_data               (_l2_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt            (_l2_auto_in_d_bits_corrupt),
    .auto_out_a_valid                  (_l2_auto_out_a_valid),
    .auto_out_a_bits_opcode            (_l2_auto_out_a_bits_opcode),
    .auto_out_a_bits_param             (_l2_auto_out_a_bits_param),
    .auto_out_a_bits_size              (_l2_auto_out_a_bits_size),
    .auto_out_a_bits_source            (_l2_auto_out_a_bits_source),
    .auto_out_a_bits_address           (_l2_auto_out_a_bits_address),
    .auto_out_a_bits_mask              (_l2_auto_out_a_bits_mask),
    .auto_out_a_bits_data              (_l2_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt           (_l2_auto_out_a_bits_corrupt),
    .auto_out_c_valid                  (_l2_auto_out_c_valid),
    .auto_out_c_bits_opcode            (_l2_auto_out_c_bits_opcode),
    .auto_out_c_bits_param             (_l2_auto_out_c_bits_param),
    .auto_out_c_bits_size              (_l2_auto_out_c_bits_size),
    .auto_out_c_bits_source            (_l2_auto_out_c_bits_source),
    .auto_out_c_bits_address           (_l2_auto_out_c_bits_address),
    .auto_out_c_bits_data              (_l2_auto_out_c_bits_data),
    .auto_out_c_bits_corrupt           (_l2_auto_out_c_bits_corrupt),
    .auto_out_d_ready                  (_l2_auto_out_d_ready),
    .auto_out_e_valid                  (_l2_auto_out_e_valid),
    .auto_out_e_bits_sink              (_l2_auto_out_e_bits_sink)
  );
  TLWidthWidget_2 filter (
    .auto_in_a_valid         (_coherent_jbar_auto_out_a_valid),
    .auto_in_a_bits_opcode   (_coherent_jbar_auto_out_a_bits_opcode),
    .auto_in_a_bits_param    (_coherent_jbar_auto_out_a_bits_param),
    .auto_in_a_bits_size     (_coherent_jbar_auto_out_a_bits_size),
    .auto_in_a_bits_source   (_coherent_jbar_auto_out_a_bits_source),
    .auto_in_a_bits_address  (_coherent_jbar_auto_out_a_bits_address),
    .auto_in_a_bits_mask     (_coherent_jbar_auto_out_a_bits_mask),
    .auto_in_a_bits_data     (_coherent_jbar_auto_out_a_bits_data),
    .auto_in_a_bits_corrupt  (_coherent_jbar_auto_out_a_bits_corrupt),
    .auto_in_b_ready         (_coherent_jbar_auto_out_b_ready),
    .auto_in_c_valid         (_coherent_jbar_auto_out_c_valid),
    .auto_in_c_bits_opcode   (_coherent_jbar_auto_out_c_bits_opcode),
    .auto_in_c_bits_param    (_coherent_jbar_auto_out_c_bits_param),
    .auto_in_c_bits_size     (_coherent_jbar_auto_out_c_bits_size),
    .auto_in_c_bits_source   (_coherent_jbar_auto_out_c_bits_source),
    .auto_in_c_bits_address  (_coherent_jbar_auto_out_c_bits_address),
    .auto_in_c_bits_data     (_coherent_jbar_auto_out_c_bits_data),
    .auto_in_c_bits_corrupt  (_coherent_jbar_auto_out_c_bits_corrupt),
    .auto_in_d_ready         (_coherent_jbar_auto_out_d_ready),
    .auto_in_e_valid         (_coherent_jbar_auto_out_e_valid),
    .auto_in_e_bits_sink     (_coherent_jbar_auto_out_e_bits_sink),
    .auto_out_a_ready        (_InclusiveCache_inner_TLBuffer_auto_in_a_ready),
    .auto_out_b_valid        (_InclusiveCache_inner_TLBuffer_auto_in_b_valid),
    .auto_out_b_bits_param   (_InclusiveCache_inner_TLBuffer_auto_in_b_bits_param),
    .auto_out_b_bits_address (_InclusiveCache_inner_TLBuffer_auto_in_b_bits_address),
    .auto_out_c_ready        (_InclusiveCache_inner_TLBuffer_auto_in_c_ready),
    .auto_out_d_valid        (_InclusiveCache_inner_TLBuffer_auto_in_d_valid),
    .auto_out_d_bits_opcode  (_InclusiveCache_inner_TLBuffer_auto_in_d_bits_opcode),
    .auto_out_d_bits_param   (_InclusiveCache_inner_TLBuffer_auto_in_d_bits_param),
    .auto_out_d_bits_size    (_InclusiveCache_inner_TLBuffer_auto_in_d_bits_size),
    .auto_out_d_bits_source  (_InclusiveCache_inner_TLBuffer_auto_in_d_bits_source),
    .auto_out_d_bits_sink    (_InclusiveCache_inner_TLBuffer_auto_in_d_bits_sink),
    .auto_out_d_bits_denied  (_InclusiveCache_inner_TLBuffer_auto_in_d_bits_denied),
    .auto_out_d_bits_data    (_InclusiveCache_inner_TLBuffer_auto_in_d_bits_data),
    .auto_out_d_bits_corrupt (_InclusiveCache_inner_TLBuffer_auto_in_d_bits_corrupt),
    .auto_in_a_ready         (_filter_auto_in_a_ready),
    .auto_in_b_valid         (_filter_auto_in_b_valid),
    .auto_in_b_bits_param    (_filter_auto_in_b_bits_param),
    .auto_in_b_bits_address  (_filter_auto_in_b_bits_address),
    .auto_in_c_ready         (_filter_auto_in_c_ready),
    .auto_in_d_valid         (_filter_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_filter_auto_in_d_bits_opcode),
    .auto_in_d_bits_param    (_filter_auto_in_d_bits_param),
    .auto_in_d_bits_size     (_filter_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_filter_auto_in_d_bits_source),
    .auto_in_d_bits_sink     (_filter_auto_in_d_bits_sink),
    .auto_in_d_bits_denied   (_filter_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_filter_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_filter_auto_in_d_bits_corrupt),
    .auto_out_a_valid        (_filter_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_filter_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_filter_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_filter_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_filter_auto_out_a_bits_source),
    .auto_out_a_bits_address (_filter_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_filter_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_filter_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_filter_auto_out_a_bits_corrupt),
    .auto_out_b_ready        (_filter_auto_out_b_ready),
    .auto_out_c_valid        (_filter_auto_out_c_valid),
    .auto_out_c_bits_opcode  (_filter_auto_out_c_bits_opcode),
    .auto_out_c_bits_param   (_filter_auto_out_c_bits_param),
    .auto_out_c_bits_size    (_filter_auto_out_c_bits_size),
    .auto_out_c_bits_source  (_filter_auto_out_c_bits_source),
    .auto_out_c_bits_address (_filter_auto_out_c_bits_address),
    .auto_out_c_bits_data    (_filter_auto_out_c_bits_data),
    .auto_out_c_bits_corrupt (_filter_auto_out_c_bits_corrupt),
    .auto_out_d_ready        (_filter_auto_out_d_ready),
    .auto_out_e_valid        (_filter_auto_out_e_valid),
    .auto_out_e_bits_sink    (_filter_auto_out_e_bits_sink)
  );
  TLBuffer_11 InclusiveCache_inner_TLBuffer (
    .clock                   (_fixedClockNode_auto_out_clock),
    .reset                   (_fixedClockNode_auto_out_reset),
    .auto_in_a_valid         (_filter_auto_out_a_valid),
    .auto_in_a_bits_opcode   (_filter_auto_out_a_bits_opcode),
    .auto_in_a_bits_param    (_filter_auto_out_a_bits_param),
    .auto_in_a_bits_size     (_filter_auto_out_a_bits_size),
    .auto_in_a_bits_source   (_filter_auto_out_a_bits_source),
    .auto_in_a_bits_address  (_filter_auto_out_a_bits_address),
    .auto_in_a_bits_mask     (_filter_auto_out_a_bits_mask),
    .auto_in_a_bits_data     (_filter_auto_out_a_bits_data),
    .auto_in_a_bits_corrupt  (_filter_auto_out_a_bits_corrupt),
    .auto_in_b_ready         (_filter_auto_out_b_ready),
    .auto_in_c_valid         (_filter_auto_out_c_valid),
    .auto_in_c_bits_opcode   (_filter_auto_out_c_bits_opcode),
    .auto_in_c_bits_param    (_filter_auto_out_c_bits_param),
    .auto_in_c_bits_size     (_filter_auto_out_c_bits_size),
    .auto_in_c_bits_source   (_filter_auto_out_c_bits_source),
    .auto_in_c_bits_address  (_filter_auto_out_c_bits_address),
    .auto_in_c_bits_data     (_filter_auto_out_c_bits_data),
    .auto_in_c_bits_corrupt  (_filter_auto_out_c_bits_corrupt),
    .auto_in_d_ready         (_filter_auto_out_d_ready),
    .auto_in_e_valid         (_filter_auto_out_e_valid),
    .auto_in_e_bits_sink     (_filter_auto_out_e_bits_sink),
    .auto_out_a_ready        (_l2_auto_in_a_ready),
    .auto_out_b_valid        (_l2_auto_in_b_valid),
    .auto_out_b_bits_param   (_l2_auto_in_b_bits_param),
    .auto_out_b_bits_address (_l2_auto_in_b_bits_address),
    .auto_out_c_ready        (_l2_auto_in_c_ready),
    .auto_out_d_valid        (_l2_auto_in_d_valid),
    .auto_out_d_bits_opcode  (_l2_auto_in_d_bits_opcode),
    .auto_out_d_bits_param   (_l2_auto_in_d_bits_param),
    .auto_out_d_bits_size    (_l2_auto_in_d_bits_size),
    .auto_out_d_bits_source  (_l2_auto_in_d_bits_source),
    .auto_out_d_bits_sink    (_l2_auto_in_d_bits_sink),
    .auto_out_d_bits_denied  (_l2_auto_in_d_bits_denied),
    .auto_out_d_bits_data    (_l2_auto_in_d_bits_data),
    .auto_out_d_bits_corrupt (_l2_auto_in_d_bits_corrupt),
    .auto_in_a_ready         (_InclusiveCache_inner_TLBuffer_auto_in_a_ready),
    .auto_in_b_valid         (_InclusiveCache_inner_TLBuffer_auto_in_b_valid),
    .auto_in_b_bits_param    (_InclusiveCache_inner_TLBuffer_auto_in_b_bits_param),
    .auto_in_b_bits_address  (_InclusiveCache_inner_TLBuffer_auto_in_b_bits_address),
    .auto_in_c_ready         (_InclusiveCache_inner_TLBuffer_auto_in_c_ready),
    .auto_in_d_valid         (_InclusiveCache_inner_TLBuffer_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_InclusiveCache_inner_TLBuffer_auto_in_d_bits_opcode),
    .auto_in_d_bits_param    (_InclusiveCache_inner_TLBuffer_auto_in_d_bits_param),
    .auto_in_d_bits_size     (_InclusiveCache_inner_TLBuffer_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_InclusiveCache_inner_TLBuffer_auto_in_d_bits_source),
    .auto_in_d_bits_sink     (_InclusiveCache_inner_TLBuffer_auto_in_d_bits_sink),
    .auto_in_d_bits_denied   (_InclusiveCache_inner_TLBuffer_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_InclusiveCache_inner_TLBuffer_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_InclusiveCache_inner_TLBuffer_auto_in_d_bits_corrupt),
    .auto_out_a_valid        (_InclusiveCache_inner_TLBuffer_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_InclusiveCache_inner_TLBuffer_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_InclusiveCache_inner_TLBuffer_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_InclusiveCache_inner_TLBuffer_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_InclusiveCache_inner_TLBuffer_auto_out_a_bits_source),
    .auto_out_a_bits_address (_InclusiveCache_inner_TLBuffer_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_InclusiveCache_inner_TLBuffer_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_InclusiveCache_inner_TLBuffer_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_InclusiveCache_inner_TLBuffer_auto_out_a_bits_corrupt),
    .auto_out_b_ready        (_InclusiveCache_inner_TLBuffer_auto_out_b_ready),
    .auto_out_c_valid        (_InclusiveCache_inner_TLBuffer_auto_out_c_valid),
    .auto_out_c_bits_opcode  (_InclusiveCache_inner_TLBuffer_auto_out_c_bits_opcode),
    .auto_out_c_bits_param   (_InclusiveCache_inner_TLBuffer_auto_out_c_bits_param),
    .auto_out_c_bits_size    (_InclusiveCache_inner_TLBuffer_auto_out_c_bits_size),
    .auto_out_c_bits_source  (_InclusiveCache_inner_TLBuffer_auto_out_c_bits_source),
    .auto_out_c_bits_address (_InclusiveCache_inner_TLBuffer_auto_out_c_bits_address),
    .auto_out_c_bits_data    (_InclusiveCache_inner_TLBuffer_auto_out_c_bits_data),
    .auto_out_c_bits_corrupt (_InclusiveCache_inner_TLBuffer_auto_out_c_bits_corrupt),
    .auto_out_d_ready        (_InclusiveCache_inner_TLBuffer_auto_out_d_ready),
    .auto_out_e_valid        (_InclusiveCache_inner_TLBuffer_auto_out_e_valid),
    .auto_out_e_bits_sink    (_InclusiveCache_inner_TLBuffer_auto_out_e_bits_sink)
  );
  TLBuffer_12 InclusiveCache_outer_TLBuffer (
    .auto_in_a_valid         (_l2_auto_out_a_valid),
    .auto_in_a_bits_opcode   (_l2_auto_out_a_bits_opcode),
    .auto_in_a_bits_param    (_l2_auto_out_a_bits_param),
    .auto_in_a_bits_size     (_l2_auto_out_a_bits_size),
    .auto_in_a_bits_source   (_l2_auto_out_a_bits_source),
    .auto_in_a_bits_address  (_l2_auto_out_a_bits_address),
    .auto_in_a_bits_mask     (_l2_auto_out_a_bits_mask),
    .auto_in_a_bits_data     (_l2_auto_out_a_bits_data),
    .auto_in_a_bits_corrupt  (_l2_auto_out_a_bits_corrupt),
    .auto_in_c_valid         (_l2_auto_out_c_valid),
    .auto_in_c_bits_opcode   (_l2_auto_out_c_bits_opcode),
    .auto_in_c_bits_param    (_l2_auto_out_c_bits_param),
    .auto_in_c_bits_size     (_l2_auto_out_c_bits_size),
    .auto_in_c_bits_source   (_l2_auto_out_c_bits_source),
    .auto_in_c_bits_address  (_l2_auto_out_c_bits_address),
    .auto_in_c_bits_data     (_l2_auto_out_c_bits_data),
    .auto_in_c_bits_corrupt  (_l2_auto_out_c_bits_corrupt),
    .auto_in_d_ready         (_l2_auto_out_d_ready),
    .auto_in_e_valid         (_l2_auto_out_e_valid),
    .auto_in_e_bits_sink     (_l2_auto_out_e_bits_sink),
    .auto_out_a_ready        (_cork_auto_in_a_ready),
    .auto_out_c_ready        (_cork_auto_in_c_ready),
    .auto_out_d_valid        (_cork_auto_in_d_valid),
    .auto_out_d_bits_opcode  (_cork_auto_in_d_bits_opcode),
    .auto_out_d_bits_param   (_cork_auto_in_d_bits_param),
    .auto_out_d_bits_size    (_cork_auto_in_d_bits_size),
    .auto_out_d_bits_source  (_cork_auto_in_d_bits_source),
    .auto_out_d_bits_sink    (_cork_auto_in_d_bits_sink),
    .auto_out_d_bits_denied  (_cork_auto_in_d_bits_denied),
    .auto_out_d_bits_data    (_cork_auto_in_d_bits_data),
    .auto_out_d_bits_corrupt (_cork_auto_in_d_bits_corrupt),
    .auto_in_a_ready         (_InclusiveCache_outer_TLBuffer_auto_in_a_ready),
    .auto_in_c_ready         (_InclusiveCache_outer_TLBuffer_auto_in_c_ready),
    .auto_in_d_valid         (_InclusiveCache_outer_TLBuffer_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_InclusiveCache_outer_TLBuffer_auto_in_d_bits_opcode),
    .auto_in_d_bits_param    (_InclusiveCache_outer_TLBuffer_auto_in_d_bits_param),
    .auto_in_d_bits_size     (_InclusiveCache_outer_TLBuffer_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_InclusiveCache_outer_TLBuffer_auto_in_d_bits_source),
    .auto_in_d_bits_sink     (_InclusiveCache_outer_TLBuffer_auto_in_d_bits_sink),
    .auto_in_d_bits_denied   (_InclusiveCache_outer_TLBuffer_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_InclusiveCache_outer_TLBuffer_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_InclusiveCache_outer_TLBuffer_auto_in_d_bits_corrupt),
    .auto_out_a_valid        (_InclusiveCache_outer_TLBuffer_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_InclusiveCache_outer_TLBuffer_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_InclusiveCache_outer_TLBuffer_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_InclusiveCache_outer_TLBuffer_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_InclusiveCache_outer_TLBuffer_auto_out_a_bits_source),
    .auto_out_a_bits_address (_InclusiveCache_outer_TLBuffer_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_InclusiveCache_outer_TLBuffer_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_InclusiveCache_outer_TLBuffer_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_InclusiveCache_outer_TLBuffer_auto_out_a_bits_corrupt),
    .auto_out_c_valid        (_InclusiveCache_outer_TLBuffer_auto_out_c_valid),
    .auto_out_c_bits_opcode  (_InclusiveCache_outer_TLBuffer_auto_out_c_bits_opcode),
    .auto_out_c_bits_param   (_InclusiveCache_outer_TLBuffer_auto_out_c_bits_param),
    .auto_out_c_bits_size    (_InclusiveCache_outer_TLBuffer_auto_out_c_bits_size),
    .auto_out_c_bits_source  (_InclusiveCache_outer_TLBuffer_auto_out_c_bits_source),
    .auto_out_c_bits_address (_InclusiveCache_outer_TLBuffer_auto_out_c_bits_address),
    .auto_out_c_bits_data    (_InclusiveCache_outer_TLBuffer_auto_out_c_bits_data),
    .auto_out_c_bits_corrupt (_InclusiveCache_outer_TLBuffer_auto_out_c_bits_corrupt),
    .auto_out_d_ready        (_InclusiveCache_outer_TLBuffer_auto_out_d_ready),
    .auto_out_e_valid        (_InclusiveCache_outer_TLBuffer_auto_out_e_valid),
    .auto_out_e_bits_sink    (_InclusiveCache_outer_TLBuffer_auto_out_e_bits_sink)
  );
  TLCacheCork cork (
    .clock                   (_fixedClockNode_auto_out_clock),
    .reset                   (_fixedClockNode_auto_out_reset),
    .auto_in_a_valid         (_InclusiveCache_outer_TLBuffer_auto_out_a_valid),
    .auto_in_a_bits_opcode   (_InclusiveCache_outer_TLBuffer_auto_out_a_bits_opcode),
    .auto_in_a_bits_param    (_InclusiveCache_outer_TLBuffer_auto_out_a_bits_param),
    .auto_in_a_bits_size     (_InclusiveCache_outer_TLBuffer_auto_out_a_bits_size),
    .auto_in_a_bits_source   (_InclusiveCache_outer_TLBuffer_auto_out_a_bits_source),
    .auto_in_a_bits_address  (_InclusiveCache_outer_TLBuffer_auto_out_a_bits_address),
    .auto_in_a_bits_mask     (_InclusiveCache_outer_TLBuffer_auto_out_a_bits_mask),
    .auto_in_a_bits_data     (_InclusiveCache_outer_TLBuffer_auto_out_a_bits_data),
    .auto_in_a_bits_corrupt  (_InclusiveCache_outer_TLBuffer_auto_out_a_bits_corrupt),
    .auto_in_c_valid         (_InclusiveCache_outer_TLBuffer_auto_out_c_valid),
    .auto_in_c_bits_opcode   (_InclusiveCache_outer_TLBuffer_auto_out_c_bits_opcode),
    .auto_in_c_bits_param    (_InclusiveCache_outer_TLBuffer_auto_out_c_bits_param),
    .auto_in_c_bits_size     (_InclusiveCache_outer_TLBuffer_auto_out_c_bits_size),
    .auto_in_c_bits_source   (_InclusiveCache_outer_TLBuffer_auto_out_c_bits_source),
    .auto_in_c_bits_address  (_InclusiveCache_outer_TLBuffer_auto_out_c_bits_address),
    .auto_in_c_bits_data     (_InclusiveCache_outer_TLBuffer_auto_out_c_bits_data),
    .auto_in_c_bits_corrupt  (_InclusiveCache_outer_TLBuffer_auto_out_c_bits_corrupt),
    .auto_in_d_ready         (_InclusiveCache_outer_TLBuffer_auto_out_d_ready),
    .auto_in_e_valid         (_InclusiveCache_outer_TLBuffer_auto_out_e_valid),
    .auto_in_e_bits_sink     (_InclusiveCache_outer_TLBuffer_auto_out_e_bits_sink),
    .auto_out_a_ready        (_binder_auto_in_a_ready),
    .auto_out_d_valid        (_binder_auto_in_d_valid),
    .auto_out_d_bits_opcode  (_binder_auto_in_d_bits_opcode),
    .auto_out_d_bits_size    (_binder_auto_in_d_bits_size),
    .auto_out_d_bits_source  (_binder_auto_in_d_bits_source),
    .auto_out_d_bits_denied  (_binder_auto_in_d_bits_denied),
    .auto_out_d_bits_data    (_binder_auto_in_d_bits_data),
    .auto_out_d_bits_corrupt (_binder_auto_in_d_bits_corrupt),
    .auto_in_a_ready         (_cork_auto_in_a_ready),
    .auto_in_c_ready         (_cork_auto_in_c_ready),
    .auto_in_d_valid         (_cork_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_cork_auto_in_d_bits_opcode),
    .auto_in_d_bits_param    (_cork_auto_in_d_bits_param),
    .auto_in_d_bits_size     (_cork_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_cork_auto_in_d_bits_source),
    .auto_in_d_bits_sink     (_cork_auto_in_d_bits_sink),
    .auto_in_d_bits_denied   (_cork_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_cork_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_cork_auto_in_d_bits_corrupt),
    .auto_out_a_valid        (_cork_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_cork_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_cork_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_cork_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_cork_auto_out_a_bits_source),
    .auto_out_a_bits_address (_cork_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_cork_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_cork_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_cork_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_cork_auto_out_d_ready)
  );
  TLJbar coherent_jbar (
    .auto_in_a_valid         (auto_coherent_jbar_in_a_valid),
    .auto_in_a_bits_opcode   (auto_coherent_jbar_in_a_bits_opcode),
    .auto_in_a_bits_param    (auto_coherent_jbar_in_a_bits_param),
    .auto_in_a_bits_size     (auto_coherent_jbar_in_a_bits_size),
    .auto_in_a_bits_source   (auto_coherent_jbar_in_a_bits_source),
    .auto_in_a_bits_address  (auto_coherent_jbar_in_a_bits_address),
    .auto_in_a_bits_mask     (auto_coherent_jbar_in_a_bits_mask),
    .auto_in_a_bits_data     (auto_coherent_jbar_in_a_bits_data),
    .auto_in_a_bits_corrupt  (auto_coherent_jbar_in_a_bits_corrupt),
    .auto_in_b_ready         (auto_coherent_jbar_in_b_ready),
    .auto_in_c_valid         (auto_coherent_jbar_in_c_valid),
    .auto_in_c_bits_opcode   (auto_coherent_jbar_in_c_bits_opcode),
    .auto_in_c_bits_param    (auto_coherent_jbar_in_c_bits_param),
    .auto_in_c_bits_size     (auto_coherent_jbar_in_c_bits_size),
    .auto_in_c_bits_source   (auto_coherent_jbar_in_c_bits_source),
    .auto_in_c_bits_address  (auto_coherent_jbar_in_c_bits_address),
    .auto_in_c_bits_data     (auto_coherent_jbar_in_c_bits_data),
    .auto_in_c_bits_corrupt  (auto_coherent_jbar_in_c_bits_corrupt),
    .auto_in_d_ready         (auto_coherent_jbar_in_d_ready),
    .auto_in_e_valid         (auto_coherent_jbar_in_e_valid),
    .auto_in_e_bits_sink     (auto_coherent_jbar_in_e_bits_sink),
    .auto_out_a_ready        (_filter_auto_in_a_ready),
    .auto_out_b_valid        (_filter_auto_in_b_valid),
    .auto_out_b_bits_param   (_filter_auto_in_b_bits_param),
    .auto_out_b_bits_address (_filter_auto_in_b_bits_address),
    .auto_out_c_ready        (_filter_auto_in_c_ready),
    .auto_out_d_valid        (_filter_auto_in_d_valid),
    .auto_out_d_bits_opcode  (_filter_auto_in_d_bits_opcode),
    .auto_out_d_bits_param   (_filter_auto_in_d_bits_param),
    .auto_out_d_bits_size    (_filter_auto_in_d_bits_size),
    .auto_out_d_bits_source  (_filter_auto_in_d_bits_source),
    .auto_out_d_bits_sink    (_filter_auto_in_d_bits_sink),
    .auto_out_d_bits_denied  (_filter_auto_in_d_bits_denied),
    .auto_out_d_bits_data    (_filter_auto_in_d_bits_data),
    .auto_out_d_bits_corrupt (_filter_auto_in_d_bits_corrupt),
    .auto_in_a_ready         (auto_coherent_jbar_in_a_ready),
    .auto_in_b_valid         (auto_coherent_jbar_in_b_valid),
    .auto_in_b_bits_param    (auto_coherent_jbar_in_b_bits_param),
    .auto_in_b_bits_address  (auto_coherent_jbar_in_b_bits_address),
    .auto_in_c_ready         (auto_coherent_jbar_in_c_ready),
    .auto_in_d_valid         (auto_coherent_jbar_in_d_valid),
    .auto_in_d_bits_opcode   (auto_coherent_jbar_in_d_bits_opcode),
    .auto_in_d_bits_param    (auto_coherent_jbar_in_d_bits_param),
    .auto_in_d_bits_size     (auto_coherent_jbar_in_d_bits_size),
    .auto_in_d_bits_source   (auto_coherent_jbar_in_d_bits_source),
    .auto_in_d_bits_sink     (auto_coherent_jbar_in_d_bits_sink),
    .auto_in_d_bits_denied   (auto_coherent_jbar_in_d_bits_denied),
    .auto_in_d_bits_data     (auto_coherent_jbar_in_d_bits_data),
    .auto_in_d_bits_corrupt  (auto_coherent_jbar_in_d_bits_corrupt),
    .auto_out_a_valid        (_coherent_jbar_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_coherent_jbar_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_coherent_jbar_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_coherent_jbar_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_coherent_jbar_auto_out_a_bits_source),
    .auto_out_a_bits_address (_coherent_jbar_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_coherent_jbar_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_coherent_jbar_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_coherent_jbar_auto_out_a_bits_corrupt),
    .auto_out_b_ready        (_coherent_jbar_auto_out_b_ready),
    .auto_out_c_valid        (_coherent_jbar_auto_out_c_valid),
    .auto_out_c_bits_opcode  (_coherent_jbar_auto_out_c_bits_opcode),
    .auto_out_c_bits_param   (_coherent_jbar_auto_out_c_bits_param),
    .auto_out_c_bits_size    (_coherent_jbar_auto_out_c_bits_size),
    .auto_out_c_bits_source  (_coherent_jbar_auto_out_c_bits_source),
    .auto_out_c_bits_address (_coherent_jbar_auto_out_c_bits_address),
    .auto_out_c_bits_data    (_coherent_jbar_auto_out_c_bits_data),
    .auto_out_c_bits_corrupt (_coherent_jbar_auto_out_c_bits_corrupt),
    .auto_out_d_ready        (_coherent_jbar_auto_out_d_ready),
    .auto_out_e_valid        (_coherent_jbar_auto_out_e_valid),
    .auto_out_e_bits_sink    (_coherent_jbar_auto_out_e_bits_sink)
  );
  BankBinder binder (
    .clock                   (_fixedClockNode_auto_out_clock),
    .reset                   (_fixedClockNode_auto_out_reset),
    .auto_in_a_valid         (_cork_auto_out_a_valid),
    .auto_in_a_bits_opcode   (_cork_auto_out_a_bits_opcode),
    .auto_in_a_bits_param    (_cork_auto_out_a_bits_param),
    .auto_in_a_bits_size     (_cork_auto_out_a_bits_size),
    .auto_in_a_bits_source   (_cork_auto_out_a_bits_source),
    .auto_in_a_bits_address  (_cork_auto_out_a_bits_address),
    .auto_in_a_bits_mask     (_cork_auto_out_a_bits_mask),
    .auto_in_a_bits_data     (_cork_auto_out_a_bits_data),
    .auto_in_a_bits_corrupt  (_cork_auto_out_a_bits_corrupt),
    .auto_in_d_ready         (_cork_auto_out_d_ready),
    .auto_out_a_ready        (_coupler_to_bus_named_subsystem_mbus_auto_widget_in_a_ready),
    .auto_out_d_valid        (_coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_valid),
    .auto_out_d_bits_opcode  (_coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_opcode),
    .auto_out_d_bits_size    (_coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_size),
    .auto_out_d_bits_source  (_coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_source),
    .auto_out_d_bits_denied  (_coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_denied),
    .auto_out_d_bits_data    (_coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_data),
    .auto_out_d_bits_corrupt (_coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_corrupt),
    .auto_in_a_ready         (_binder_auto_in_a_ready),
    .auto_in_d_valid         (_binder_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_binder_auto_in_d_bits_opcode),
    .auto_in_d_bits_size     (_binder_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_binder_auto_in_d_bits_source),
    .auto_in_d_bits_denied   (_binder_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_binder_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_binder_auto_in_d_bits_corrupt),
    .auto_out_a_valid        (_binder_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_binder_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_binder_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_binder_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_binder_auto_out_a_bits_source),
    .auto_out_a_bits_address (_binder_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_binder_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_binder_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_binder_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_binder_auto_out_d_ready)
  );
  TLInterconnectCoupler_18 coupler_to_bus_named_subsystem_mbus (
    .auto_widget_in_a_valid           (_binder_auto_out_a_valid),
    .auto_widget_in_a_bits_opcode     (_binder_auto_out_a_bits_opcode),
    .auto_widget_in_a_bits_param      (_binder_auto_out_a_bits_param),
    .auto_widget_in_a_bits_size       (_binder_auto_out_a_bits_size),
    .auto_widget_in_a_bits_source     (_binder_auto_out_a_bits_source),
    .auto_widget_in_a_bits_address    (_binder_auto_out_a_bits_address),
    .auto_widget_in_a_bits_mask       (_binder_auto_out_a_bits_mask),
    .auto_widget_in_a_bits_data       (_binder_auto_out_a_bits_data),
    .auto_widget_in_a_bits_corrupt    (_binder_auto_out_a_bits_corrupt),
    .auto_widget_in_d_ready           (_binder_auto_out_d_ready),
    .auto_bus_xing_out_a_ready        (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_ready),
    .auto_bus_xing_out_d_valid        (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_valid),
    .auto_bus_xing_out_d_bits_opcode  (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_opcode),
    .auto_bus_xing_out_d_bits_size    (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_size),
    .auto_bus_xing_out_d_bits_source  (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_source),
    .auto_bus_xing_out_d_bits_denied  (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_denied),
    .auto_bus_xing_out_d_bits_data    (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_data),
    .auto_bus_xing_out_d_bits_corrupt (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_corrupt),
    .auto_widget_in_a_ready           (_coupler_to_bus_named_subsystem_mbus_auto_widget_in_a_ready),
    .auto_widget_in_d_valid           (_coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_valid),
    .auto_widget_in_d_bits_opcode     (_coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_opcode),
    .auto_widget_in_d_bits_size       (_coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_size),
    .auto_widget_in_d_bits_source     (_coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_source),
    .auto_widget_in_d_bits_denied     (_coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_denied),
    .auto_widget_in_d_bits_data       (_coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_data),
    .auto_widget_in_d_bits_corrupt    (_coupler_to_bus_named_subsystem_mbus_auto_widget_in_d_bits_corrupt),
    .auto_bus_xing_out_a_valid        (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_valid),
    .auto_bus_xing_out_a_bits_opcode  (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_opcode),
    .auto_bus_xing_out_a_bits_param   (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_param),
    .auto_bus_xing_out_a_bits_size    (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_size),
    .auto_bus_xing_out_a_bits_source  (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_source),
    .auto_bus_xing_out_a_bits_address (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_address),
    .auto_bus_xing_out_a_bits_mask    (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_mask),
    .auto_bus_xing_out_a_bits_data    (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_data),
    .auto_bus_xing_out_a_bits_corrupt (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_corrupt),
    .auto_bus_xing_out_d_ready        (auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_ready)
  );
endmodule

