// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module FrontBus(
  input         auto_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_clock,
                auto_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_reset,
                auto_bus_xing_out_a_ready,
                auto_bus_xing_out_d_valid,
  input  [2:0]  auto_bus_xing_out_d_bits_opcode,
  input  [1:0]  auto_bus_xing_out_d_bits_param,
  input  [3:0]  auto_bus_xing_out_d_bits_size,
                auto_bus_xing_out_d_bits_source,
                auto_bus_xing_out_d_bits_sink,
  input         auto_bus_xing_out_d_bits_denied,
  input  [63:0] auto_bus_xing_out_d_bits_data,
  input         auto_bus_xing_out_d_bits_corrupt,
                serial_tl_clock,
                serial_tl_bits_in_valid,
  input  [31:0] serial_tl_bits_in_bits,
  input         serial_tl_bits_out_ready,
  output        auto_bus_xing_out_a_valid,
  output [2:0]  auto_bus_xing_out_a_bits_opcode,
                auto_bus_xing_out_a_bits_param,
  output [3:0]  auto_bus_xing_out_a_bits_size,
                auto_bus_xing_out_a_bits_source,
  output [31:0] auto_bus_xing_out_a_bits_address,
  output [7:0]  auto_bus_xing_out_a_bits_mask,
  output [63:0] auto_bus_xing_out_a_bits_data,
  output        auto_bus_xing_out_a_bits_corrupt,
                auto_bus_xing_out_d_ready,
                serial_tl_bits_in_ready,
                serial_tl_bits_out_valid,
  output [31:0] serial_tl_bits_out_bits
);

  wire        _in_async_io_enq_ready;
  wire        _in_async_io_deq_valid;
  wire [31:0] _in_async_io_deq_bits;
  wire        _out_async_io_enq_ready;
  wire        _outer_reset_catcher_io_sync_reset;
  wire        _coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_a_ready;
  wire        _coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_valid;
  wire [2:0]  _coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_opcode;
  wire [1:0]  _coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_param;
  wire [3:0]  _coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_size;
  wire [3:0]  _coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_source;
  wire [3:0]  _coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_sink;
  wire        _coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_denied;
  wire [63:0] _coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_data;
  wire        _coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_corrupt;
  wire        _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_valid;
  wire [2:0]  _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_opcode;
  wire [2:0]  _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_param;
  wire [3:0]  _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_size;
  wire [3:0]  _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_source;
  wire [31:0] _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_address;
  wire [7:0]  _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_mask;
  wire [63:0] _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_data;
  wire        _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_corrupt;
  wire        _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_d_ready;
  wire        _serdesser_auto_client_out_a_valid;
  wire [2:0]  _serdesser_auto_client_out_a_bits_opcode;
  wire [2:0]  _serdesser_auto_client_out_a_bits_param;
  wire [3:0]  _serdesser_auto_client_out_a_bits_size;
  wire [3:0]  _serdesser_auto_client_out_a_bits_source;
  wire [31:0] _serdesser_auto_client_out_a_bits_address;
  wire [7:0]  _serdesser_auto_client_out_a_bits_mask;
  wire [63:0] _serdesser_auto_client_out_a_bits_data;
  wire        _serdesser_auto_client_out_a_bits_corrupt;
  wire        _serdesser_auto_client_out_d_ready;
  wire        _serdesser_io_ser_in_ready;
  wire        _serdesser_io_ser_out_valid;
  wire [31:0] _serdesser_io_ser_out_bits;
  wire        _buffer_auto_in_a_ready;
  wire        _buffer_auto_in_d_valid;
  wire [2:0]  _buffer_auto_in_d_bits_opcode;
  wire [1:0]  _buffer_auto_in_d_bits_param;
  wire [3:0]  _buffer_auto_in_d_bits_size;
  wire [3:0]  _buffer_auto_in_d_bits_source;
  wire [3:0]  _buffer_auto_in_d_bits_sink;
  wire        _buffer_auto_in_d_bits_denied;
  wire [63:0] _buffer_auto_in_d_bits_data;
  wire        _buffer_auto_in_d_bits_corrupt;
  wire        _subsystem_fbus_xbar_auto_in_a_ready;
  wire        _subsystem_fbus_xbar_auto_in_d_valid;
  wire [2:0]  _subsystem_fbus_xbar_auto_in_d_bits_opcode;
  wire [1:0]  _subsystem_fbus_xbar_auto_in_d_bits_param;
  wire [3:0]  _subsystem_fbus_xbar_auto_in_d_bits_size;
  wire [3:0]  _subsystem_fbus_xbar_auto_in_d_bits_source;
  wire [3:0]  _subsystem_fbus_xbar_auto_in_d_bits_sink;
  wire        _subsystem_fbus_xbar_auto_in_d_bits_denied;
  wire [63:0] _subsystem_fbus_xbar_auto_in_d_bits_data;
  wire        _subsystem_fbus_xbar_auto_in_d_bits_corrupt;
  wire        _subsystem_fbus_xbar_auto_out_a_valid;
  wire [2:0]  _subsystem_fbus_xbar_auto_out_a_bits_opcode;
  wire [2:0]  _subsystem_fbus_xbar_auto_out_a_bits_param;
  wire [3:0]  _subsystem_fbus_xbar_auto_out_a_bits_size;
  wire [3:0]  _subsystem_fbus_xbar_auto_out_a_bits_source;
  wire [31:0] _subsystem_fbus_xbar_auto_out_a_bits_address;
  wire [7:0]  _subsystem_fbus_xbar_auto_out_a_bits_mask;
  wire [63:0] _subsystem_fbus_xbar_auto_out_a_bits_data;
  wire        _subsystem_fbus_xbar_auto_out_a_bits_corrupt;
  wire        _subsystem_fbus_xbar_auto_out_d_ready;
  wire        _fixedClockNode_auto_out_clock;
  wire        _fixedClockNode_auto_out_reset;
  wire        _clockGroup_auto_out_clock;
  wire        _clockGroup_auto_out_reset;
  wire        _subsystem_fbus_clock_groups_auto_out_clock;
  wire        _subsystem_fbus_clock_groups_auto_out_reset;
  reg  [1:0]  out_async_io_enq_c_value;
  reg         out_async_io_enq_r;
  reg  [1:0]  in_async_io_enq_c_value;
  reg         in_async_io_enq_r;
  always @(posedge _fixedClockNode_auto_out_clock) begin
    if (_fixedClockNode_auto_out_reset) begin
      out_async_io_enq_c_value <= 2'h0;
      in_async_io_enq_c_value <= 2'h0;
    end
    else begin
      out_async_io_enq_c_value <= out_async_io_enq_c_value + 2'h1;
      in_async_io_enq_c_value <= in_async_io_enq_c_value + 2'h1;
    end
    out_async_io_enq_r <= ~_fixedClockNode_auto_out_reset & ((&out_async_io_enq_c_value) | out_async_io_enq_r);
    in_async_io_enq_r <= ~_fixedClockNode_auto_out_reset & ((&in_async_io_enq_c_value) | in_async_io_enq_r);
  end // always @(posedge)
  ClockGroup subsystem_fbus_clock_groups (
    .auto_in_member_subsystem_sbus_0_clock (auto_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_clock),
    .auto_in_member_subsystem_sbus_0_reset (auto_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_reset),
    .auto_out_clock                        (_subsystem_fbus_clock_groups_auto_out_clock),
    .auto_out_reset                        (_subsystem_fbus_clock_groups_auto_out_reset)
  );
  ClockGroup clockGroup (
    .auto_in_member_subsystem_sbus_0_clock (_subsystem_fbus_clock_groups_auto_out_clock),
    .auto_in_member_subsystem_sbus_0_reset (_subsystem_fbus_clock_groups_auto_out_reset),
    .auto_out_clock                        (_clockGroup_auto_out_clock),
    .auto_out_reset                        (_clockGroup_auto_out_reset)
  );
  ClockGroup fixedClockNode (
    .auto_in_member_subsystem_sbus_0_clock (_clockGroup_auto_out_clock),
    .auto_in_member_subsystem_sbus_0_reset (_clockGroup_auto_out_reset),
    .auto_out_clock                        (_fixedClockNode_auto_out_clock),
    .auto_out_reset                        (_fixedClockNode_auto_out_reset)
  );
  TLXbar_3 subsystem_fbus_xbar (
    .auto_in_a_valid         (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_valid),
    .auto_in_a_bits_opcode   (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_opcode),
    .auto_in_a_bits_param    (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_param),
    .auto_in_a_bits_size     (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_size),
    .auto_in_a_bits_source   (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_source),
    .auto_in_a_bits_address  (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_address),
    .auto_in_a_bits_mask     (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_mask),
    .auto_in_a_bits_data     (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_data),
    .auto_in_a_bits_corrupt  (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_corrupt),
    .auto_in_d_ready         (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_d_ready),
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
    .auto_in_a_ready         (_subsystem_fbus_xbar_auto_in_a_ready),
    .auto_in_d_valid         (_subsystem_fbus_xbar_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_subsystem_fbus_xbar_auto_in_d_bits_opcode),
    .auto_in_d_bits_param    (_subsystem_fbus_xbar_auto_in_d_bits_param),
    .auto_in_d_bits_size     (_subsystem_fbus_xbar_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_subsystem_fbus_xbar_auto_in_d_bits_source),
    .auto_in_d_bits_sink     (_subsystem_fbus_xbar_auto_in_d_bits_sink),
    .auto_in_d_bits_denied   (_subsystem_fbus_xbar_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_subsystem_fbus_xbar_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_subsystem_fbus_xbar_auto_in_d_bits_corrupt),
    .auto_out_a_valid        (_subsystem_fbus_xbar_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_subsystem_fbus_xbar_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_subsystem_fbus_xbar_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_subsystem_fbus_xbar_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_subsystem_fbus_xbar_auto_out_a_bits_source),
    .auto_out_a_bits_address (_subsystem_fbus_xbar_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_subsystem_fbus_xbar_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_subsystem_fbus_xbar_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_subsystem_fbus_xbar_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_subsystem_fbus_xbar_auto_out_d_ready)
  );
  TLBuffer_2 buffer (
    .clock                   (_fixedClockNode_auto_out_clock),
    .reset                   (_fixedClockNode_auto_out_reset),
    .auto_in_a_valid         (_subsystem_fbus_xbar_auto_out_a_valid),
    .auto_in_a_bits_opcode   (_subsystem_fbus_xbar_auto_out_a_bits_opcode),
    .auto_in_a_bits_param    (_subsystem_fbus_xbar_auto_out_a_bits_param),
    .auto_in_a_bits_size     (_subsystem_fbus_xbar_auto_out_a_bits_size),
    .auto_in_a_bits_source   (_subsystem_fbus_xbar_auto_out_a_bits_source),
    .auto_in_a_bits_address  (_subsystem_fbus_xbar_auto_out_a_bits_address),
    .auto_in_a_bits_mask     (_subsystem_fbus_xbar_auto_out_a_bits_mask),
    .auto_in_a_bits_data     (_subsystem_fbus_xbar_auto_out_a_bits_data),
    .auto_in_a_bits_corrupt  (_subsystem_fbus_xbar_auto_out_a_bits_corrupt),
    .auto_in_d_ready         (_subsystem_fbus_xbar_auto_out_d_ready),
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
  TLSerdesser serdesser (
    .clock                          (_fixedClockNode_auto_out_clock),
    .reset                          (_fixedClockNode_auto_out_reset),
    .auto_client_out_a_ready        (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_a_ready),
    .auto_client_out_d_valid        (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_valid),
    .auto_client_out_d_bits_opcode  (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_opcode),
    .auto_client_out_d_bits_param   (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_param),
    .auto_client_out_d_bits_size    (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_size),
    .auto_client_out_d_bits_source  (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_source),
    .auto_client_out_d_bits_sink    (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_sink),
    .auto_client_out_d_bits_denied  (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_denied),
    .auto_client_out_d_bits_data    (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_data),
    .auto_client_out_d_bits_corrupt (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_corrupt),
    .io_ser_in_valid                (_in_async_io_deq_valid),
    .io_ser_in_bits                 (_in_async_io_deq_bits),
    .io_ser_out_ready               (out_async_io_enq_r & _out_async_io_enq_ready),
    .auto_client_out_a_valid        (_serdesser_auto_client_out_a_valid),
    .auto_client_out_a_bits_opcode  (_serdesser_auto_client_out_a_bits_opcode),
    .auto_client_out_a_bits_param   (_serdesser_auto_client_out_a_bits_param),
    .auto_client_out_a_bits_size    (_serdesser_auto_client_out_a_bits_size),
    .auto_client_out_a_bits_source  (_serdesser_auto_client_out_a_bits_source),
    .auto_client_out_a_bits_address (_serdesser_auto_client_out_a_bits_address),
    .auto_client_out_a_bits_mask    (_serdesser_auto_client_out_a_bits_mask),
    .auto_client_out_a_bits_data    (_serdesser_auto_client_out_a_bits_data),
    .auto_client_out_a_bits_corrupt (_serdesser_auto_client_out_a_bits_corrupt),
    .auto_client_out_d_ready        (_serdesser_auto_client_out_d_ready),
    .io_ser_in_ready                (_serdesser_io_ser_in_ready),
    .io_ser_out_valid               (_serdesser_io_ser_out_valid),
    .io_ser_out_bits                (_serdesser_io_ser_out_bits)
  );
  TLInterconnectCoupler_6 coupler_from_port_named_serial_tl_ctrl (
    .clock                         (_fixedClockNode_auto_out_clock),
    .reset                         (_fixedClockNode_auto_out_reset),
    .auto_buffer_in_a_valid        (_serdesser_auto_client_out_a_valid),
    .auto_buffer_in_a_bits_opcode  (_serdesser_auto_client_out_a_bits_opcode),
    .auto_buffer_in_a_bits_param   (_serdesser_auto_client_out_a_bits_param),
    .auto_buffer_in_a_bits_size    (_serdesser_auto_client_out_a_bits_size),
    .auto_buffer_in_a_bits_source  (_serdesser_auto_client_out_a_bits_source),
    .auto_buffer_in_a_bits_address (_serdesser_auto_client_out_a_bits_address),
    .auto_buffer_in_a_bits_mask    (_serdesser_auto_client_out_a_bits_mask),
    .auto_buffer_in_a_bits_data    (_serdesser_auto_client_out_a_bits_data),
    .auto_buffer_in_a_bits_corrupt (_serdesser_auto_client_out_a_bits_corrupt),
    .auto_buffer_in_d_ready        (_serdesser_auto_client_out_d_ready),
    .auto_tl_out_a_ready           (_subsystem_fbus_xbar_auto_in_a_ready),
    .auto_tl_out_d_valid           (_subsystem_fbus_xbar_auto_in_d_valid),
    .auto_tl_out_d_bits_opcode     (_subsystem_fbus_xbar_auto_in_d_bits_opcode),
    .auto_tl_out_d_bits_param      (_subsystem_fbus_xbar_auto_in_d_bits_param),
    .auto_tl_out_d_bits_size       (_subsystem_fbus_xbar_auto_in_d_bits_size),
    .auto_tl_out_d_bits_source     (_subsystem_fbus_xbar_auto_in_d_bits_source),
    .auto_tl_out_d_bits_sink       (_subsystem_fbus_xbar_auto_in_d_bits_sink),
    .auto_tl_out_d_bits_denied     (_subsystem_fbus_xbar_auto_in_d_bits_denied),
    .auto_tl_out_d_bits_data       (_subsystem_fbus_xbar_auto_in_d_bits_data),
    .auto_tl_out_d_bits_corrupt    (_subsystem_fbus_xbar_auto_in_d_bits_corrupt),
    .auto_buffer_in_a_ready        (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_a_ready),
    .auto_buffer_in_d_valid        (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_valid),
    .auto_buffer_in_d_bits_opcode  (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_opcode),
    .auto_buffer_in_d_bits_param   (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_param),
    .auto_buffer_in_d_bits_size    (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_size),
    .auto_buffer_in_d_bits_source  (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_source),
    .auto_buffer_in_d_bits_sink    (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_sink),
    .auto_buffer_in_d_bits_denied  (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_denied),
    .auto_buffer_in_d_bits_data    (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_data),
    .auto_buffer_in_d_bits_corrupt (_coupler_from_port_named_serial_tl_ctrl_auto_buffer_in_d_bits_corrupt),
    .auto_tl_out_a_valid           (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_valid),
    .auto_tl_out_a_bits_opcode     (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_opcode),
    .auto_tl_out_a_bits_param      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_param),
    .auto_tl_out_a_bits_size       (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_size),
    .auto_tl_out_a_bits_source     (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_source),
    .auto_tl_out_a_bits_address    (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_address),
    .auto_tl_out_a_bits_mask       (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_mask),
    .auto_tl_out_a_bits_data       (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_data),
    .auto_tl_out_a_bits_corrupt    (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_corrupt),
    .auto_tl_out_d_ready           (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_d_ready)
  );
  ResetCatchAndSync_d3 outer_reset_catcher (
    .clock         (serial_tl_clock),
    .reset         (_fixedClockNode_auto_out_reset),
    .io_sync_reset (_outer_reset_catcher_io_sync_reset)
  );
  AsyncQueue out_async (
    .io_enq_clock (_fixedClockNode_auto_out_clock),
    .io_enq_reset (_fixedClockNode_auto_out_reset),
    .io_enq_valid (out_async_io_enq_r & _serdesser_io_ser_out_valid),
    .io_enq_bits  (_serdesser_io_ser_out_bits),
    .io_deq_clock (serial_tl_clock),
    .io_deq_reset (_outer_reset_catcher_io_sync_reset),
    .io_deq_ready (serial_tl_bits_out_ready),
    .io_enq_ready (_out_async_io_enq_ready),
    .io_deq_valid (serial_tl_bits_out_valid),
    .io_deq_bits  (serial_tl_bits_out_bits)
  );
  AsyncQueue in_async (
    .io_enq_clock (serial_tl_clock),
    .io_enq_reset (_outer_reset_catcher_io_sync_reset),
    .io_enq_valid (in_async_io_enq_r & serial_tl_bits_in_valid),
    .io_enq_bits  (serial_tl_bits_in_bits),
    .io_deq_clock (_fixedClockNode_auto_out_clock),
    .io_deq_reset (_fixedClockNode_auto_out_reset),
    .io_deq_ready (_serdesser_io_ser_in_ready),
    .io_enq_ready (_in_async_io_enq_ready),
    .io_deq_valid (_in_async_io_deq_valid),
    .io_deq_bits  (_in_async_io_deq_bits)
  );
  assign serial_tl_bits_in_ready = in_async_io_enq_r & _in_async_io_enq_ready;
endmodule

