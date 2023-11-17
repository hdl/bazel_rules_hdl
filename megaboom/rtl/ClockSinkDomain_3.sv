// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ClockSinkDomain_3(
  input         auto_reset_setter_clock_in_member_allClocks_uncore_clock,
                auto_reset_setter_clock_in_member_allClocks_uncore_reset,
                auto_xbar_in_a_valid,
  input  [2:0]  auto_xbar_in_a_bits_opcode,
                auto_xbar_in_a_bits_param,
                auto_xbar_in_a_bits_size,
  input  [6:0]  auto_xbar_in_a_bits_source,
  input  [20:0] auto_xbar_in_a_bits_address,
  input  [7:0]  auto_xbar_in_a_bits_mask,
  input  [63:0] auto_xbar_in_a_bits_data,
  input         auto_xbar_in_a_bits_corrupt,
                auto_xbar_in_d_ready,
                auto_clock_in_clock,
                auto_clock_in_reset,
  output        auto_resetSynchronizer_out_member_allClocks_uncore_clock,
                auto_resetSynchronizer_out_member_allClocks_uncore_reset,
                auto_xbar_in_a_ready,
                auto_xbar_in_d_valid,
  output [2:0]  auto_xbar_in_d_bits_opcode,
                auto_xbar_in_d_bits_size,
  output [6:0]  auto_xbar_in_d_bits_source,
  output [63:0] auto_xbar_in_d_bits_data
);

  wire        _fragmenter_1_auto_in_a_ready;
  wire        _fragmenter_1_auto_in_d_valid;
  wire [2:0]  _fragmenter_1_auto_in_d_bits_opcode;
  wire [2:0]  _fragmenter_1_auto_in_d_bits_size;
  wire [6:0]  _fragmenter_1_auto_in_d_bits_source;
  wire [63:0] _fragmenter_1_auto_in_d_bits_data;
  wire        _fragmenter_1_auto_out_a_valid;
  wire [2:0]  _fragmenter_1_auto_out_a_bits_opcode;
  wire [2:0]  _fragmenter_1_auto_out_a_bits_param;
  wire [1:0]  _fragmenter_1_auto_out_a_bits_size;
  wire [10:0] _fragmenter_1_auto_out_a_bits_source;
  wire [20:0] _fragmenter_1_auto_out_a_bits_address;
  wire [7:0]  _fragmenter_1_auto_out_a_bits_mask;
  wire        _fragmenter_1_auto_out_a_bits_corrupt;
  wire        _fragmenter_1_auto_out_d_ready;
  wire        _reset_setter_auto_clock_out_member_allClocks_uncore_clock;
  wire        _reset_setter_auto_clock_out_member_allClocks_uncore_reset;
  wire        _reset_setter_auto_tl_in_a_ready;
  wire        _reset_setter_auto_tl_in_d_valid;
  wire [2:0]  _reset_setter_auto_tl_in_d_bits_opcode;
  wire [1:0]  _reset_setter_auto_tl_in_d_bits_size;
  wire [10:0] _reset_setter_auto_tl_in_d_bits_source;
  wire [63:0] _reset_setter_auto_tl_in_d_bits_data;
  wire        _fragmenter_auto_in_a_ready;
  wire        _fragmenter_auto_in_d_valid;
  wire [2:0]  _fragmenter_auto_in_d_bits_opcode;
  wire [2:0]  _fragmenter_auto_in_d_bits_size;
  wire [6:0]  _fragmenter_auto_in_d_bits_source;
  wire [63:0] _fragmenter_auto_in_d_bits_data;
  wire        _fragmenter_auto_out_a_valid;
  wire [2:0]  _fragmenter_auto_out_a_bits_opcode;
  wire [2:0]  _fragmenter_auto_out_a_bits_param;
  wire [1:0]  _fragmenter_auto_out_a_bits_size;
  wire [10:0] _fragmenter_auto_out_a_bits_source;
  wire [20:0] _fragmenter_auto_out_a_bits_address;
  wire [7:0]  _fragmenter_auto_out_a_bits_mask;
  wire [63:0] _fragmenter_auto_out_a_bits_data;
  wire        _fragmenter_auto_out_a_bits_corrupt;
  wire        _fragmenter_auto_out_d_ready;
  wire        _clock_gater_auto_clock_gater_in_1_a_ready;
  wire        _clock_gater_auto_clock_gater_in_1_d_valid;
  wire [2:0]  _clock_gater_auto_clock_gater_in_1_d_bits_opcode;
  wire [1:0]  _clock_gater_auto_clock_gater_in_1_d_bits_size;
  wire [10:0] _clock_gater_auto_clock_gater_in_1_d_bits_source;
  wire [63:0] _clock_gater_auto_clock_gater_in_1_d_bits_data;
  wire        _clock_gater_auto_clock_gater_out_member_allClocks_uncore_clock;
  wire        _clock_gater_auto_clock_gater_out_member_allClocks_uncore_reset;
  wire        _xbar_auto_out_1_a_valid;
  wire [2:0]  _xbar_auto_out_1_a_bits_opcode;
  wire [2:0]  _xbar_auto_out_1_a_bits_param;
  wire [2:0]  _xbar_auto_out_1_a_bits_size;
  wire [6:0]  _xbar_auto_out_1_a_bits_source;
  wire [20:0] _xbar_auto_out_1_a_bits_address;
  wire [7:0]  _xbar_auto_out_1_a_bits_mask;
  wire        _xbar_auto_out_1_a_bits_corrupt;
  wire        _xbar_auto_out_1_d_ready;
  wire        _xbar_auto_out_0_a_valid;
  wire [2:0]  _xbar_auto_out_0_a_bits_opcode;
  wire [2:0]  _xbar_auto_out_0_a_bits_param;
  wire [2:0]  _xbar_auto_out_0_a_bits_size;
  wire [6:0]  _xbar_auto_out_0_a_bits_source;
  wire [20:0] _xbar_auto_out_0_a_bits_address;
  wire [7:0]  _xbar_auto_out_0_a_bits_mask;
  wire [63:0] _xbar_auto_out_0_a_bits_data;
  wire        _xbar_auto_out_0_a_bits_corrupt;
  wire        _xbar_auto_out_0_d_ready;
  TLXbar_11 xbar (
    .clock                     (auto_clock_in_clock),
    .reset                     (auto_clock_in_reset),
    .auto_in_a_valid           (auto_xbar_in_a_valid),
    .auto_in_a_bits_opcode     (auto_xbar_in_a_bits_opcode),
    .auto_in_a_bits_param      (auto_xbar_in_a_bits_param),
    .auto_in_a_bits_size       (auto_xbar_in_a_bits_size),
    .auto_in_a_bits_source     (auto_xbar_in_a_bits_source),
    .auto_in_a_bits_address    (auto_xbar_in_a_bits_address),
    .auto_in_a_bits_mask       (auto_xbar_in_a_bits_mask),
    .auto_in_a_bits_data       (auto_xbar_in_a_bits_data),
    .auto_in_a_bits_corrupt    (auto_xbar_in_a_bits_corrupt),
    .auto_in_d_ready           (auto_xbar_in_d_ready),
    .auto_out_1_a_ready        (_fragmenter_1_auto_in_a_ready),
    .auto_out_1_d_valid        (_fragmenter_1_auto_in_d_valid),
    .auto_out_1_d_bits_opcode  (_fragmenter_1_auto_in_d_bits_opcode),
    .auto_out_1_d_bits_size    (_fragmenter_1_auto_in_d_bits_size),
    .auto_out_1_d_bits_source  (_fragmenter_1_auto_in_d_bits_source),
    .auto_out_1_d_bits_data    (_fragmenter_1_auto_in_d_bits_data),
    .auto_out_0_a_ready        (_fragmenter_auto_in_a_ready),
    .auto_out_0_d_valid        (_fragmenter_auto_in_d_valid),
    .auto_out_0_d_bits_opcode  (_fragmenter_auto_in_d_bits_opcode),
    .auto_out_0_d_bits_size    (_fragmenter_auto_in_d_bits_size),
    .auto_out_0_d_bits_source  (_fragmenter_auto_in_d_bits_source),
    .auto_out_0_d_bits_data    (_fragmenter_auto_in_d_bits_data),
    .auto_in_a_ready           (auto_xbar_in_a_ready),
    .auto_in_d_valid           (auto_xbar_in_d_valid),
    .auto_in_d_bits_opcode     (auto_xbar_in_d_bits_opcode),
    .auto_in_d_bits_size       (auto_xbar_in_d_bits_size),
    .auto_in_d_bits_source     (auto_xbar_in_d_bits_source),
    .auto_in_d_bits_data       (auto_xbar_in_d_bits_data),
    .auto_out_1_a_valid        (_xbar_auto_out_1_a_valid),
    .auto_out_1_a_bits_opcode  (_xbar_auto_out_1_a_bits_opcode),
    .auto_out_1_a_bits_param   (_xbar_auto_out_1_a_bits_param),
    .auto_out_1_a_bits_size    (_xbar_auto_out_1_a_bits_size),
    .auto_out_1_a_bits_source  (_xbar_auto_out_1_a_bits_source),
    .auto_out_1_a_bits_address (_xbar_auto_out_1_a_bits_address),
    .auto_out_1_a_bits_mask    (_xbar_auto_out_1_a_bits_mask),
    .auto_out_1_a_bits_corrupt (_xbar_auto_out_1_a_bits_corrupt),
    .auto_out_1_d_ready        (_xbar_auto_out_1_d_ready),
    .auto_out_0_a_valid        (_xbar_auto_out_0_a_valid),
    .auto_out_0_a_bits_opcode  (_xbar_auto_out_0_a_bits_opcode),
    .auto_out_0_a_bits_param   (_xbar_auto_out_0_a_bits_param),
    .auto_out_0_a_bits_size    (_xbar_auto_out_0_a_bits_size),
    .auto_out_0_a_bits_source  (_xbar_auto_out_0_a_bits_source),
    .auto_out_0_a_bits_address (_xbar_auto_out_0_a_bits_address),
    .auto_out_0_a_bits_mask    (_xbar_auto_out_0_a_bits_mask),
    .auto_out_0_a_bits_data    (_xbar_auto_out_0_a_bits_data),
    .auto_out_0_a_bits_corrupt (_xbar_auto_out_0_a_bits_corrupt),
    .auto_out_0_d_ready        (_xbar_auto_out_0_d_ready)
  );
  ClockGroupResetSynchronizer resetSynchronizer (
    .auto_in_member_allClocks_uncore_clock  (_clock_gater_auto_clock_gater_out_member_allClocks_uncore_clock),
    .auto_in_member_allClocks_uncore_reset  (_clock_gater_auto_clock_gater_out_member_allClocks_uncore_reset),
    .auto_out_member_allClocks_uncore_clock (auto_resetSynchronizer_out_member_allClocks_uncore_clock),
    .auto_out_member_allClocks_uncore_reset (auto_resetSynchronizer_out_member_allClocks_uncore_reset)
  );
  TileClockGater clock_gater (
    .clock                                               (auto_clock_in_clock),
    .reset                                               (auto_clock_in_reset),
    .auto_clock_gater_in_1_a_valid                       (_fragmenter_auto_out_a_valid),
    .auto_clock_gater_in_1_a_bits_opcode                 (_fragmenter_auto_out_a_bits_opcode),
    .auto_clock_gater_in_1_a_bits_param                  (_fragmenter_auto_out_a_bits_param),
    .auto_clock_gater_in_1_a_bits_size                   (_fragmenter_auto_out_a_bits_size),
    .auto_clock_gater_in_1_a_bits_source                 (_fragmenter_auto_out_a_bits_source),
    .auto_clock_gater_in_1_a_bits_address                (_fragmenter_auto_out_a_bits_address),
    .auto_clock_gater_in_1_a_bits_mask                   (_fragmenter_auto_out_a_bits_mask),
    .auto_clock_gater_in_1_a_bits_data                   (_fragmenter_auto_out_a_bits_data),
    .auto_clock_gater_in_1_a_bits_corrupt                (_fragmenter_auto_out_a_bits_corrupt),
    .auto_clock_gater_in_1_d_ready                       (_fragmenter_auto_out_d_ready),
    .auto_clock_gater_in_0_member_allClocks_uncore_clock (_reset_setter_auto_clock_out_member_allClocks_uncore_clock),
    .auto_clock_gater_in_0_member_allClocks_uncore_reset (_reset_setter_auto_clock_out_member_allClocks_uncore_reset),
    .auto_clock_gater_in_1_a_ready                       (_clock_gater_auto_clock_gater_in_1_a_ready),
    .auto_clock_gater_in_1_d_valid                       (_clock_gater_auto_clock_gater_in_1_d_valid),
    .auto_clock_gater_in_1_d_bits_opcode                 (_clock_gater_auto_clock_gater_in_1_d_bits_opcode),
    .auto_clock_gater_in_1_d_bits_size                   (_clock_gater_auto_clock_gater_in_1_d_bits_size),
    .auto_clock_gater_in_1_d_bits_source                 (_clock_gater_auto_clock_gater_in_1_d_bits_source),
    .auto_clock_gater_in_1_d_bits_data                   (_clock_gater_auto_clock_gater_in_1_d_bits_data),
    .auto_clock_gater_out_member_allClocks_uncore_clock  (_clock_gater_auto_clock_gater_out_member_allClocks_uncore_clock),
    .auto_clock_gater_out_member_allClocks_uncore_reset  (_clock_gater_auto_clock_gater_out_member_allClocks_uncore_reset)
  );
  TLFragmenter_7 fragmenter (
    .clock                   (auto_clock_in_clock),
    .reset                   (auto_clock_in_reset),
    .auto_in_a_valid         (_xbar_auto_out_0_a_valid),
    .auto_in_a_bits_opcode   (_xbar_auto_out_0_a_bits_opcode),
    .auto_in_a_bits_param    (_xbar_auto_out_0_a_bits_param),
    .auto_in_a_bits_size     (_xbar_auto_out_0_a_bits_size),
    .auto_in_a_bits_source   (_xbar_auto_out_0_a_bits_source),
    .auto_in_a_bits_address  (_xbar_auto_out_0_a_bits_address),
    .auto_in_a_bits_mask     (_xbar_auto_out_0_a_bits_mask),
    .auto_in_a_bits_data     (_xbar_auto_out_0_a_bits_data),
    .auto_in_a_bits_corrupt  (_xbar_auto_out_0_a_bits_corrupt),
    .auto_in_d_ready         (_xbar_auto_out_0_d_ready),
    .auto_out_a_ready        (_clock_gater_auto_clock_gater_in_1_a_ready),
    .auto_out_d_valid        (_clock_gater_auto_clock_gater_in_1_d_valid),
    .auto_out_d_bits_opcode  (_clock_gater_auto_clock_gater_in_1_d_bits_opcode),
    .auto_out_d_bits_size    (_clock_gater_auto_clock_gater_in_1_d_bits_size),
    .auto_out_d_bits_source  (_clock_gater_auto_clock_gater_in_1_d_bits_source),
    .auto_out_d_bits_data    (_clock_gater_auto_clock_gater_in_1_d_bits_data),
    .auto_in_a_ready         (_fragmenter_auto_in_a_ready),
    .auto_in_d_valid         (_fragmenter_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_fragmenter_auto_in_d_bits_opcode),
    .auto_in_d_bits_size     (_fragmenter_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_fragmenter_auto_in_d_bits_source),
    .auto_in_d_bits_data     (_fragmenter_auto_in_d_bits_data),
    .auto_out_a_valid        (_fragmenter_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_fragmenter_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_fragmenter_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_fragmenter_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_fragmenter_auto_out_a_bits_source),
    .auto_out_a_bits_address (_fragmenter_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_fragmenter_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_fragmenter_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_fragmenter_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_fragmenter_auto_out_d_ready)
  );
  TileResetSetter reset_setter (
    .clock                                        (auto_clock_in_clock),
    .reset                                        (auto_clock_in_reset),
    .auto_clock_in_member_allClocks_uncore_clock  (auto_reset_setter_clock_in_member_allClocks_uncore_clock),
    .auto_clock_in_member_allClocks_uncore_reset  (auto_reset_setter_clock_in_member_allClocks_uncore_reset),
    .auto_tl_in_a_valid                           (_fragmenter_1_auto_out_a_valid),
    .auto_tl_in_a_bits_opcode                     (_fragmenter_1_auto_out_a_bits_opcode),
    .auto_tl_in_a_bits_param                      (_fragmenter_1_auto_out_a_bits_param),
    .auto_tl_in_a_bits_size                       (_fragmenter_1_auto_out_a_bits_size),
    .auto_tl_in_a_bits_source                     (_fragmenter_1_auto_out_a_bits_source),
    .auto_tl_in_a_bits_address                    (_fragmenter_1_auto_out_a_bits_address),
    .auto_tl_in_a_bits_mask                       (_fragmenter_1_auto_out_a_bits_mask),
    .auto_tl_in_a_bits_corrupt                    (_fragmenter_1_auto_out_a_bits_corrupt),
    .auto_tl_in_d_ready                           (_fragmenter_1_auto_out_d_ready),
    .auto_clock_out_member_allClocks_uncore_clock (_reset_setter_auto_clock_out_member_allClocks_uncore_clock),
    .auto_clock_out_member_allClocks_uncore_reset (_reset_setter_auto_clock_out_member_allClocks_uncore_reset),
    .auto_tl_in_a_ready                           (_reset_setter_auto_tl_in_a_ready),
    .auto_tl_in_d_valid                           (_reset_setter_auto_tl_in_d_valid),
    .auto_tl_in_d_bits_opcode                     (_reset_setter_auto_tl_in_d_bits_opcode),
    .auto_tl_in_d_bits_size                       (_reset_setter_auto_tl_in_d_bits_size),
    .auto_tl_in_d_bits_source                     (_reset_setter_auto_tl_in_d_bits_source),
    .auto_tl_in_d_bits_data                       (_reset_setter_auto_tl_in_d_bits_data)
  );
  TLFragmenter_8 fragmenter_1 (
    .clock                   (auto_clock_in_clock),
    .reset                   (auto_clock_in_reset),
    .auto_in_a_valid         (_xbar_auto_out_1_a_valid),
    .auto_in_a_bits_opcode   (_xbar_auto_out_1_a_bits_opcode),
    .auto_in_a_bits_param    (_xbar_auto_out_1_a_bits_param),
    .auto_in_a_bits_size     (_xbar_auto_out_1_a_bits_size),
    .auto_in_a_bits_source   (_xbar_auto_out_1_a_bits_source),
    .auto_in_a_bits_address  (_xbar_auto_out_1_a_bits_address),
    .auto_in_a_bits_mask     (_xbar_auto_out_1_a_bits_mask),
    .auto_in_a_bits_corrupt  (_xbar_auto_out_1_a_bits_corrupt),
    .auto_in_d_ready         (_xbar_auto_out_1_d_ready),
    .auto_out_a_ready        (_reset_setter_auto_tl_in_a_ready),
    .auto_out_d_valid        (_reset_setter_auto_tl_in_d_valid),
    .auto_out_d_bits_opcode  (_reset_setter_auto_tl_in_d_bits_opcode),
    .auto_out_d_bits_size    (_reset_setter_auto_tl_in_d_bits_size),
    .auto_out_d_bits_source  (_reset_setter_auto_tl_in_d_bits_source),
    .auto_out_d_bits_data    (_reset_setter_auto_tl_in_d_bits_data),
    .auto_in_a_ready         (_fragmenter_1_auto_in_a_ready),
    .auto_in_d_valid         (_fragmenter_1_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_fragmenter_1_auto_in_d_bits_opcode),
    .auto_in_d_bits_size     (_fragmenter_1_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_fragmenter_1_auto_in_d_bits_source),
    .auto_in_d_bits_data     (_fragmenter_1_auto_in_d_bits_data),
    .auto_out_a_valid        (_fragmenter_1_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_fragmenter_1_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_fragmenter_1_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_fragmenter_1_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_fragmenter_1_auto_out_a_bits_source),
    .auto_out_a_bits_address (_fragmenter_1_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_fragmenter_1_auto_out_a_bits_mask),
    .auto_out_a_bits_corrupt (_fragmenter_1_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_fragmenter_1_auto_out_d_ready)
  );
endmodule

