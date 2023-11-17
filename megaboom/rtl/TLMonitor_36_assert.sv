// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

// VCS coverage exclude_file
module TLMonitor_36_assert(
  input [31:0] io_in_a_bits_address,
  input [2:0]  io_in_a_bits_size,
  input [5:0]  io_in_a_bits_source,
  input [2:0]  io_in_a_bits_param,
  input [15:0] io_in_a_bits_mask,
  input        io_in_a_bits_corrupt,
  input [2:0]  io_in_d_bits_opcode,
  input [5:0]  io_in_d_bits_source,
  input [2:0]  io_in_d_bits_size,
  input [1:0]  io_in_d_bits_param,
  input        io_in_d_bits_corrupt,
               io_in_d_bits_denied,
  input [3:0]  io_in_d_bits_sink,
  input [31:0] io_in_b_bits_address,
  input [1:0]  io_in_b_bits_param,
  input [31:0] io_in_c_bits_address,
  input [5:0]  io_in_c_bits_source,
  input [2:0]  io_in_c_bits_size,
               io_in_c_bits_param,
  input        io_in_c_bits_corrupt,
  input [3:0]  io_in_e_bits_sink,
  input [2:0]  io_in_a_bits_opcode,
  input        clock,
               reset,
               io_in_a_ready,
               io_in_a_valid,
               io_in_d_ready,
               io_in_d_valid,
               io_in_b_ready,
               io_in_b_valid,
  input [2:0]  io_in_c_bits_opcode,
  input        io_in_c_ready,
               io_in_c_valid,
               io_in_e_valid
);

  wire [31:0]  _plusarg_reader_1_out;
  wire [31:0]  _plusarg_reader_out;
  wire         _source_ok_WIRE__2 = io_in_a_bits_source == 6'h10;
  wire         source_ok = io_in_a_bits_source[5:4] == 2'h2 | ~(|(io_in_a_bits_source[5:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2;
  wire [12:0]  _GEN = {10'h0, io_in_a_bits_size};
  wire [12:0]  _is_aligned_mask_T_1 = 13'h3F << _GEN;
  wire [5:0]   _GEN_0 = io_in_a_bits_address[5:0] & ~(_is_aligned_mask_T_1[5:0]);
  wire         mask_acc = io_in_a_bits_size[2] | (&(io_in_a_bits_size[1:0])) & ~(io_in_a_bits_address[3]);
  wire         mask_acc_1 = io_in_a_bits_size[2] | (&(io_in_a_bits_size[1:0])) & io_in_a_bits_address[3];
  wire         mask_size_1 = io_in_a_bits_size[1:0] == 2'h2;
  wire         mask_eq_2 = ~(io_in_a_bits_address[3]) & ~(io_in_a_bits_address[2]);
  wire         mask_acc_2 = mask_acc | mask_size_1 & mask_eq_2;
  wire         mask_eq_3 = ~(io_in_a_bits_address[3]) & io_in_a_bits_address[2];
  wire         mask_acc_3 = mask_acc | mask_size_1 & mask_eq_3;
  wire         mask_eq_4 = io_in_a_bits_address[3] & ~(io_in_a_bits_address[2]);
  wire         mask_acc_4 = mask_acc_1 | mask_size_1 & mask_eq_4;
  wire         mask_eq_5 = io_in_a_bits_address[3] & io_in_a_bits_address[2];
  wire         mask_acc_5 = mask_acc_1 | mask_size_1 & mask_eq_5;
  wire         mask_size_2 = io_in_a_bits_size[1:0] == 2'h1;
  wire         mask_eq_6 = mask_eq_2 & ~(io_in_a_bits_address[1]);
  wire         mask_acc_6 = mask_acc_2 | mask_size_2 & mask_eq_6;
  wire         mask_eq_7 = mask_eq_2 & io_in_a_bits_address[1];
  wire         mask_acc_7 = mask_acc_2 | mask_size_2 & mask_eq_7;
  wire         mask_eq_8 = mask_eq_3 & ~(io_in_a_bits_address[1]);
  wire         mask_acc_8 = mask_acc_3 | mask_size_2 & mask_eq_8;
  wire         mask_eq_9 = mask_eq_3 & io_in_a_bits_address[1];
  wire         mask_acc_9 = mask_acc_3 | mask_size_2 & mask_eq_9;
  wire         mask_eq_10 = mask_eq_4 & ~(io_in_a_bits_address[1]);
  wire         mask_acc_10 = mask_acc_4 | mask_size_2 & mask_eq_10;
  wire         mask_eq_11 = mask_eq_4 & io_in_a_bits_address[1];
  wire         mask_acc_11 = mask_acc_4 | mask_size_2 & mask_eq_11;
  wire         mask_eq_12 = mask_eq_5 & ~(io_in_a_bits_address[1]);
  wire         mask_acc_12 = mask_acc_5 | mask_size_2 & mask_eq_12;
  wire         mask_eq_13 = mask_eq_5 & io_in_a_bits_address[1];
  wire         mask_acc_13 = mask_acc_5 | mask_size_2 & mask_eq_13;
  wire [15:0]  mask = {mask_acc_13 | mask_eq_13 & io_in_a_bits_address[0], mask_acc_13 | mask_eq_13 & ~(io_in_a_bits_address[0]), mask_acc_12 | mask_eq_12 & io_in_a_bits_address[0], mask_acc_12 | mask_eq_12 & ~(io_in_a_bits_address[0]), mask_acc_11 | mask_eq_11 & io_in_a_bits_address[0], mask_acc_11 | mask_eq_11 & ~(io_in_a_bits_address[0]), mask_acc_10 | mask_eq_10 & io_in_a_bits_address[0], mask_acc_10 | mask_eq_10 & ~(io_in_a_bits_address[0]), mask_acc_9 | mask_eq_9 & io_in_a_bits_address[0], mask_acc_9 | mask_eq_9 & ~(io_in_a_bits_address[0]), mask_acc_8 | mask_eq_8 & io_in_a_bits_address[0], mask_acc_8 | mask_eq_8 & ~(io_in_a_bits_address[0]), mask_acc_7 | mask_eq_7 & io_in_a_bits_address[0], mask_acc_7 | mask_eq_7 & ~(io_in_a_bits_address[0]), mask_acc_6 | mask_eq_6 & io_in_a_bits_address[0], mask_acc_6 | mask_eq_6 & ~(io_in_a_bits_address[0])};
  wire         _GEN_1 = io_in_a_bits_opcode == 3'h6;
  wire         _GEN_2 = io_in_a_bits_source[5:4] == 2'h2;
  wire         _GEN_3 = io_in_a_bits_size == 3'h6;
  wire         _GEN_4 = io_in_a_bits_address[31:28] == 4'h8;
  wire         _GEN_5 = _GEN_3 & _GEN_4;
  wire         _GEN_6 = (_GEN_2 | ~(|(io_in_a_bits_source[5:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2) & _GEN_5;
  wire         _GEN_7 = ~(|(io_in_a_bits_source[5:4])) & io_in_a_bits_source[3:0] < 4'h9 & _GEN_3 & _GEN_4;
  wire         _GEN_8 = io_in_a_bits_param < 3'h3;
  wire         _GEN_9 = io_in_a_bits_mask != 16'hFFFF;
  wire         _GEN_10 = (_GEN_2 | ~(|(io_in_a_bits_source[5:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2) & _GEN_5;
  wire         _GEN_11 = ~(|(io_in_a_bits_source[5:4])) & io_in_a_bits_source[3:0] < 4'h9 & _GEN_3 & _GEN_4;
  wire         _GEN_12 = io_in_a_bits_opcode == 3'h4;
  wire         _GEN_13 = _GEN_2 | ~(|(io_in_a_bits_source[5:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2;
  wire         _GEN_14 = io_in_a_bits_size != 3'h7 & _GEN_4;
  wire         _GEN_15 = io_in_a_bits_mask == mask;
  wire         _GEN_16 = (_GEN_2 | ~(|(io_in_a_bits_source[5:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2) & _GEN_14;
  wire         _GEN_17 = (_GEN_2 | ~(|(io_in_a_bits_source[5:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2) & _GEN_14;
  wire [15:0]  _GEN_18 = io_in_a_bits_mask & ~mask;
  wire         _GEN_19 = io_in_a_bits_opcode == 3'h2;
  wire         _GEN_20 = io_in_a_bits_size < 3'h5 & _GEN_4;
  wire         _GEN_21 = (_GEN_2 | ~(|(io_in_a_bits_source[5:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2) & _GEN_20;
  wire         _GEN_22 = io_in_a_bits_param < 3'h5;
  wire         _GEN_23 = io_in_a_bits_opcode == 3'h3;
  wire         _GEN_24 = (_GEN_2 | ~(|(io_in_a_bits_source[5:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2) & _GEN_20;
  wire         _GEN_25 = io_in_a_bits_opcode == 3'h5;
  wire         _GEN_26 = (_GEN_2 | ~(|(io_in_a_bits_source[5:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2) & _GEN_14;
  wire         _GEN_27 = io_in_a_bits_param < 3'h2;
  wire         _GEN_28 = io_in_d_bits_opcode != 3'h7;
  wire         source_ok_1 = io_in_d_bits_source[5:4] == 2'h2 | io_in_d_bits_source[5:4] == 2'h0 & io_in_d_bits_source[3:0] < 4'h9 | io_in_d_bits_source == 6'h10;
  wire         sink_ok = io_in_d_bits_sink[3:2] != 2'h3;
  wire         d_release_ack = io_in_d_bits_opcode == 3'h6;
  wire         _GEN_29 = io_in_d_bits_param != 2'h3;
  wire         _GEN_30 = io_in_d_bits_param != 2'h2;
  wire         _GEN_31 = ~io_in_d_bits_denied | io_in_d_bits_corrupt;
  wire         _GEN_32 = io_in_b_bits_address[31:28] != 4'h8;
  wire         _GEN_33 = io_in_b_bits_param != 2'h3;
  wire         _source_ok_WIRE_2_2 = io_in_c_bits_source == 6'h10;
  wire         source_ok_2 = io_in_c_bits_source[5:4] == 2'h2 | ~(|(io_in_c_bits_source[5:4])) & io_in_c_bits_source[3:0] < 4'h9 | _source_ok_WIRE_2_2;
  wire [12:0]  _GEN_34 = {10'h0, io_in_c_bits_size};
  wire [12:0]  _is_aligned_mask_T_7 = 13'h3F << _GEN_34;
  wire [5:0]   _GEN_35 = io_in_c_bits_address[5:0] & ~(_is_aligned_mask_T_7[5:0]);
  wire         _GEN_36 = io_in_c_bits_address[31:28] != 4'h8;
  wire         _c_probe_ack_T = io_in_c_bits_opcode == 3'h4;
  wire         _GEN_37 = io_in_c_bits_param[2:1] != 2'h3;
  wire         _c_probe_ack_T_1 = io_in_c_bits_opcode == 3'h5;
  wire         _GEN_38 = io_in_c_bits_source[5:4] == 2'h2;
  wire         _GEN_39 = io_in_c_bits_size == 3'h6;
  wire         _GEN_40 = _GEN_39 & ~_GEN_36;
  wire         _GEN_41 = (_GEN_38 | ~(|(io_in_c_bits_source[5:4])) & io_in_c_bits_source[3:0] < 4'h9 | _source_ok_WIRE_2_2) & _GEN_40;
  wire         _GEN_42 = ~(|(io_in_c_bits_source[5:4])) & io_in_c_bits_source[3:0] < 4'h9 & _GEN_39 & ~_GEN_36;
  wire         _GEN_43 = (_GEN_38 | ~(|(io_in_c_bits_source[5:4])) & io_in_c_bits_source[3:0] < 4'h9 | _source_ok_WIRE_2_2) & _GEN_40;
  wire         _GEN_44 = ~(|(io_in_c_bits_source[5:4])) & io_in_c_bits_source[3:0] < 4'h9 & _GEN_39 & ~_GEN_36;
  wire         sink_ok_1 = io_in_e_bits_sink[3:2] != 2'h3;
  wire         _a_first_T_1 = io_in_a_ready & io_in_a_valid;
  reg  [1:0]   a_first_counter;
  reg  [2:0]   opcode;
  reg  [2:0]   param;
  reg  [2:0]   size;
  reg  [5:0]   source;
  reg  [31:0]  address;
  wire         _GEN_45 = io_in_a_bits_opcode == opcode;
  wire         _GEN_46 = io_in_a_bits_param == param;
  wire         _GEN_47 = io_in_a_bits_size == size;
  wire         _GEN_48 = io_in_a_bits_source == source;
  wire         _GEN_49 = io_in_a_bits_address == address;
  wire         _d_first_T_3 = io_in_d_ready & io_in_d_valid;
  reg  [1:0]   d_first_counter;
  reg  [2:0]   opcode_1;
  reg  [1:0]   param_1;
  reg  [2:0]   size_1;
  reg  [5:0]   source_1;
  reg  [3:0]   sink;
  reg          denied;
  wire         _GEN_50 = io_in_d_bits_opcode == opcode_1;
  wire         _GEN_51 = io_in_d_bits_param == param_1;
  wire         _GEN_52 = io_in_d_bits_size == size_1;
  wire         _GEN_53 = io_in_d_bits_source == source_1;
  wire         _GEN_54 = io_in_d_bits_sink == sink;
  wire         _GEN_55 = io_in_d_bits_denied == denied;
  reg  [1:0]   b_first_counter;
  reg  [2:0]   opcode_2;
  reg  [1:0]   param_2;
  reg  [2:0]   size_2;
  reg  [5:0]   source_2;
  reg  [31:0]  address_1;
  wire         _GEN_56 = opcode_2 == 3'h6;
  wire         _GEN_57 = io_in_b_bits_param == param_2;
  wire         _GEN_58 = size_2 == 3'h6;
  wire         _GEN_59 = io_in_b_bits_address == address_1;
  wire         _c_first_T_1 = io_in_c_ready & io_in_c_valid;
  reg  [1:0]   c_first_counter;
  reg  [2:0]   opcode_3;
  reg  [2:0]   param_3;
  reg  [2:0]   size_3;
  reg  [5:0]   source_3;
  reg  [31:0]  address_2;
  wire         _GEN_60 = io_in_c_bits_opcode == opcode_3;
  wire         _GEN_61 = io_in_c_bits_param == param_3;
  wire         _GEN_62 = io_in_c_bits_size == size_3;
  wire         _GEN_63 = io_in_c_bits_source == source_3;
  wire         _GEN_64 = io_in_c_bits_address == address_2;
  reg  [47:0]  inflight;
  reg  [191:0] inflight_opcodes;
  reg  [191:0] inflight_sizes;
  reg  [1:0]   a_first_counter_1;
  wire         a_first_1 = a_first_counter_1 == 2'h0;
  reg  [1:0]   d_first_counter_1;
  wire         d_first_1 = d_first_counter_1 == 2'h0;
  wire [191:0] _GEN_65 = {184'h0, io_in_d_bits_source, 2'h0};
  wire [191:0] _a_opcode_lookup_T_1 = inflight_opcodes >> _GEN_65;
  wire [191:0] _a_size_lookup_T_1 = inflight_sizes >> _GEN_65;
  wire         _same_cycle_resp_T_1 = io_in_a_valid & a_first_1;
  wire [63:0]  _a_set_T = 64'h1 << io_in_a_bits_source;
  wire [47:0]  _GEN_27_0 = _same_cycle_resp_T_1 ? _a_set_T[47:0] : 48'h0;
  wire         _GEN_66 = _a_first_T_1 & a_first_1;
  wire [47:0]  _GEN_67 = inflight >> io_in_a_bits_source;
  wire         _GEN_68 = io_in_d_valid & d_first_1;
  wire         _GEN_69 = _GEN_68 & ~d_release_ack;
  wire [63:0]  _d_clr_T_1 = 64'h1 << io_in_d_bits_source;
  wire         _same_cycle_resp_T_2 = io_in_a_bits_source == io_in_d_bits_source;
  wire         same_cycle_resp = _same_cycle_resp_T_1 & _same_cycle_resp_T_2;
  wire [47:0]  _GEN_70 = {42'h0, io_in_d_bits_source};
  wire [47:0]  _GEN_71 = inflight >> _GEN_70;
  wire         _GEN_72 = _GEN_71[0] | same_cycle_resp;
  wire         _GEN_73 = _GEN_12 | _GEN_23 | _GEN_19;
  wire         _GEN_74 = io_in_d_bits_opcode == ((&io_in_a_bits_opcode) | _GEN_1 ? 3'h4 : _GEN_25 ? 3'h2 : {2'h0, _GEN_73}) | io_in_d_bits_opcode == ((&io_in_a_bits_opcode) ? 3'h4 : _GEN_1 ? 3'h5 : _GEN_25 ? 3'h2 : {2'h0, _GEN_73});
  wire         _GEN_75 = io_in_a_bits_size == io_in_d_bits_size;
  wire         _GEN_76 = _a_opcode_lookup_T_1[3:1] == 3'h4 | _a_opcode_lookup_T_1[3:1] == 3'h3 | _a_opcode_lookup_T_1[3:1] == 3'h2;
  wire         _GEN_77 = _a_opcode_lookup_T_1[3:1] == 3'h5;
  wire         _GEN_78 = _a_opcode_lookup_T_1[3:1] == 3'h6;
  wire         _GEN_79 = io_in_d_bits_opcode == ((&(_a_opcode_lookup_T_1[3:1])) | _GEN_78 ? 3'h4 : _GEN_77 ? 3'h2 : {2'h0, _GEN_76}) | io_in_d_bits_opcode == ((&(_a_opcode_lookup_T_1[3:1])) ? 3'h4 : _GEN_78 ? 3'h5 : _GEN_77 ? 3'h2 : {2'h0, _GEN_76});
  wire         _GEN_80 = io_in_d_bits_size == _a_size_lookup_T_1[3:1];
  wire         _GEN_81 = ~io_in_d_ready | io_in_a_ready;
  wire         _GEN_82 = _GEN_27_0 != (_GEN_69 ? _d_clr_T_1[47:0] : 48'h0) | _GEN_27_0 == 48'h0;
  reg  [31:0]  watchdog;
  wire         _GEN_83 = inflight == 48'h0 | _plusarg_reader_out == 32'h0 | watchdog < _plusarg_reader_out;
  reg  [47:0]  inflight_1;
  reg  [191:0] inflight_sizes_1;
  reg  [1:0]   c_first_counter_1;
  wire         c_first_1 = c_first_counter_1 == 2'h0;
  reg  [1:0]   d_first_counter_2;
  wire         d_first_2 = d_first_counter_2 == 2'h0;
  wire [191:0] _c_size_lookup_T_1 = inflight_sizes_1 >> _GEN_65;
  wire         _same_cycle_resp_T_3 = io_in_c_valid & c_first_1;
  wire         _GEN_84 = io_in_c_bits_opcode[2] & io_in_c_bits_opcode[1];
  wire [63:0]  _c_set_T = 64'h1 << io_in_c_bits_source;
  wire [47:0]  _GEN_72_0 = _same_cycle_resp_T_3 & _GEN_84 ? _c_set_T[47:0] : 48'h0;
  wire         _GEN_85 = _c_first_T_1 & c_first_1 & _GEN_84;
  wire [47:0]  _GEN_86 = inflight_1 >> io_in_c_bits_source;
  wire         _GEN_87 = io_in_d_valid & d_first_2;
  wire         _GEN_88 = _GEN_87 & d_release_ack;
  wire         _same_cycle_resp_T_8 = io_in_c_bits_source == io_in_d_bits_source;
  wire         same_cycle_resp_1 = _same_cycle_resp_T_3 & io_in_c_bits_opcode[2] & io_in_c_bits_opcode[1] & _same_cycle_resp_T_8;
  wire [47:0]  _GEN_89 = inflight_1 >> _GEN_70;
  wire         _GEN_90 = _GEN_89[0] | same_cycle_resp_1;
  wire         _GEN_91 = io_in_d_bits_size == io_in_c_bits_size;
  wire         _GEN_92 = io_in_d_bits_size == _c_size_lookup_T_1[3:1];
  wire         _GEN_93 = ~io_in_d_ready | io_in_c_ready;
  wire         _GEN_94 = _GEN_72_0 != (_GEN_88 ? _d_clr_T_1[47:0] : 48'h0);
  reg  [31:0]  watchdog_1;
  wire         _GEN_95 = inflight_1 == 48'h0 | _plusarg_reader_1_out == 32'h0 | watchdog_1 < _plusarg_reader_1_out;
  reg  [11:0]  inflight_2;
  reg  [1:0]   d_first_counter_3;
  wire         d_first_3 = d_first_counter_3 == 2'h0;
  wire         _GEN_96 = _d_first_T_3 & d_first_3 & io_in_d_bits_opcode[2] & ~(io_in_d_bits_opcode[1]);
  wire [15:0]  _d_set_T = 16'h1 << io_in_d_bits_sink;
  wire [11:0]  _GEN_97 = inflight_2 >> io_in_d_bits_sink;
  wire [11:0]  _GEN_84_0 = _GEN_96 ? _d_set_T[11:0] : 12'h0;
  wire [11:0]  _GEN_98 = (_GEN_84_0 | inflight_2) >> io_in_e_bits_sink;
  wire         _GEN_99 = io_in_a_valid & _GEN_1 & ~reset;
  wire         _GEN_100 = io_in_a_valid & (&io_in_a_bits_opcode) & ~reset;
  wire         _GEN_101 = io_in_a_valid & _GEN_12 & ~reset;
  wire         _GEN_102 = io_in_a_valid & io_in_a_bits_opcode == 3'h0 & ~reset;
  wire         _GEN_103 = io_in_a_valid & io_in_a_bits_opcode == 3'h1 & ~reset;
  wire         _GEN_104 = io_in_a_valid & _GEN_19 & ~reset;
  wire         _GEN_105 = io_in_a_valid & _GEN_23 & ~reset;
  wire         _GEN_106 = io_in_a_valid & _GEN_25 & ~reset;
  wire         _GEN_107 = io_in_d_valid & ~reset;
  wire         _GEN_108 = io_in_d_valid & d_release_ack & ~reset;
  wire         _GEN_109 = io_in_d_valid & io_in_d_bits_opcode == 3'h4 & ~reset;
  wire         _GEN_110 = io_in_d_valid & io_in_d_bits_opcode == 3'h5 & ~reset;
  wire         _GEN_111 = io_in_d_valid & io_in_d_bits_opcode == 3'h0 & ~reset;
  wire         _GEN_112 = io_in_d_valid & io_in_d_bits_opcode == 3'h1 & ~reset;
  wire         _GEN_113 = io_in_d_valid & io_in_d_bits_opcode == 3'h2 & ~reset;
  wire         _GEN_114 = io_in_b_valid & ~reset;
  wire         _GEN_115 = io_in_c_valid & _c_probe_ack_T & ~reset;
  wire         _GEN_116 = io_in_c_valid & _c_probe_ack_T_1 & ~reset;
  wire         _GEN_117 = io_in_c_valid & io_in_c_bits_opcode == 3'h6 & ~reset;
  wire         _GEN_118 = io_in_c_valid & (&io_in_c_bits_opcode) & ~reset;
  wire         _GEN_119 = io_in_c_valid & io_in_c_bits_opcode == 3'h0 & ~reset;
  wire         _GEN_120 = io_in_c_valid & io_in_c_bits_opcode == 3'h1 & ~reset;
  wire         _GEN_121 = io_in_c_valid & io_in_c_bits_opcode == 3'h2 & ~reset;
  wire         _GEN_122 = io_in_e_valid & ~reset;
  wire         _GEN_123 = io_in_a_valid & (|a_first_counter) & ~reset;
  wire         _GEN_124 = io_in_d_valid & (|d_first_counter) & ~reset;
  wire         _GEN_125 = io_in_b_valid & (|b_first_counter) & ~reset;
  wire         _GEN_126 = io_in_c_valid & (|c_first_counter) & ~reset;
  wire         _GEN_127 = _GEN_66 & ~reset;
  wire         _GEN_128 = _GEN_69 & ~reset;
  wire         _GEN_129 = _GEN_69 & same_cycle_resp & ~reset;
  wire         _GEN_130 = _GEN_69 & ~same_cycle_resp & ~reset;
  wire         _GEN_131 = _GEN_68 & a_first_1 & io_in_a_valid & _same_cycle_resp_T_2 & ~d_release_ack & ~reset;
  wire         _GEN_132 = _GEN_85 & ~reset;
  wire         _GEN_133 = _GEN_88 & ~reset;
  wire         _GEN_134 = _GEN_88 & same_cycle_resp_1 & ~reset;
  wire         _GEN_135 = _GEN_88 & ~same_cycle_resp_1 & ~reset;
  wire         _GEN_136 = _GEN_87 & c_first_1 & io_in_c_valid & _same_cycle_resp_T_8 & d_release_ack & ~(_c_probe_ack_T | _c_probe_ack_T_1) & ~reset;
  wire         _GEN_137 = (|_GEN_72_0) & ~reset;
  wire         _GEN_138 = _GEN_96 & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_99 & ~_GEN_6)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquireBlock type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_99 & ~_GEN_7)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquireBlock from a client which does not support Probe (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_99 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_99 & ~(io_in_a_bits_size[2]))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_99 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_99 & ~_GEN_8)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock carries invalid grow param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_99 & _GEN_9)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_99 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_100 & ~_GEN_10)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquirePerm type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_100 & ~_GEN_11)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquirePerm from a client which does not support Probe (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_100 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_100 & ~(io_in_a_bits_size[2]))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_100 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_100 & ~_GEN_8)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm carries invalid grow param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_100 & ~(|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm requests NtoB (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_100 & _GEN_9)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_100 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_101 & ~_GEN_13)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Get type which master claims it can't emit (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_101 & ~_GEN_14)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Get type which slave claims it can't support (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_101 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_101 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_101 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_101 & ~_GEN_15)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_101 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_102 & ~_GEN_16)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries PutFull type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_102 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_102 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_102 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_102 & ~_GEN_15)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_103 & ~_GEN_17)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries PutPartial type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_103 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_103 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_103 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_103 & (|_GEN_18))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_104 & ~_GEN_21)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Arithmetic type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_104 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_104 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_104 & ~_GEN_22)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic carries invalid opcode param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_104 & ~_GEN_15)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_105 & ~_GEN_24)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Logical type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_105 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_105 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_105 & io_in_a_bits_param[2])
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical carries invalid opcode param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_105 & ~_GEN_15)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_106 & ~_GEN_26)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Hint type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_106 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_106 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_106 & ~_GEN_27)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint carries invalid opcode param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_106 & ~_GEN_15)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_106 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_107 & ~_GEN_28)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel has invalid opcode (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_108 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_108 & ~(io_in_d_bits_size[2]))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_108 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseeAck carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_108 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_108 & io_in_d_bits_denied)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck is denied (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_109 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_109 & ~sink_ok)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid sink ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_109 & ~(io_in_d_bits_size[2]))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_109 & ~_GEN_29)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid cap param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_109 & ~_GEN_30)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries toN param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_109 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_110 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_110 & ~sink_ok)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid sink ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_110 & ~(io_in_d_bits_size[2]))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_110 & ~_GEN_29)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid cap param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_110 & ~_GEN_30)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries toN param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_110 & ~_GEN_31)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData is denied but not corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_111 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_111 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_111 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_112 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_112 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_112 & ~_GEN_31)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData is denied but not corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_113 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_113 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_113 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_114 & _GEN_32) begin
        $fwrite(32'h80000002, "Assertion failed: 'B' channel carries Probe type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Probe carries unmanaged address (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      end
      if ((`PRINTF_COND_) & _GEN_114 & (|(io_in_b_bits_address[5:0])))
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Probe address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_114 & ~_GEN_33)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Probe carries invalid cap param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_115 & _GEN_36)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAck carries unmanaged address (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_115 & ~source_ok_2)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAck carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_115 & ~(io_in_c_bits_size[2]))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAck smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_115 & (|_GEN_35))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAck address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_115 & ~_GEN_37)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAck carries invalid report param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_115 & io_in_c_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAck is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_116 & _GEN_36)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAckData carries unmanaged address (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_116 & ~source_ok_2)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAckData carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_116 & ~(io_in_c_bits_size[2]))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAckData smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_116 & (|_GEN_35))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAckData address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_116 & ~_GEN_37)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAckData carries invalid report param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_117 & ~_GEN_41)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel carries Release type unsupported by manager (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_117 & ~_GEN_42)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel carries Release from a client which does not support Probe (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_117 & ~source_ok_2)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel Release carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_117 & ~(io_in_c_bits_size[2]))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel Release smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_117 & (|_GEN_35))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel Release address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_117 & ~_GEN_37)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel Release carries invalid report param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_117 & io_in_c_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel Release is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_118 & ~_GEN_43)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel carries ReleaseData type unsupported by manager (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_118 & ~_GEN_44)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel carries Release from a client which does not support Probe (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_118 & ~source_ok_2)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ReleaseData carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_118 & ~(io_in_c_bits_size[2]))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ReleaseData smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_118 & (|_GEN_35))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ReleaseData address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_118 & ~_GEN_37)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ReleaseData carries invalid report param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_119 & _GEN_36)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAck carries unmanaged address (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_119 & ~source_ok_2)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAck carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_119 & (|_GEN_35))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAck address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_119 & (|io_in_c_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAck carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_119 & io_in_c_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAck is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_120 & _GEN_36)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAckData carries unmanaged address (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_120 & ~source_ok_2)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAckData carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_120 & (|_GEN_35))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAckData address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_120 & (|io_in_c_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAckData carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_121 & _GEN_36)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel HintAck carries unmanaged address (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_121 & ~source_ok_2)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel HintAck carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_121 & (|_GEN_35))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel HintAck address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_121 & (|io_in_c_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel HintAck carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_121 & io_in_c_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel HintAck is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_122 & ~sink_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'E' channels carries invalid sink ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_123 & ~_GEN_45)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel opcode changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_123 & ~_GEN_46)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel param changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_123 & ~_GEN_47)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel size changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_123 & ~_GEN_48)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel source changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_123 & ~_GEN_49)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel address changed with multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_124 & ~_GEN_50)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel opcode changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_124 & ~_GEN_51)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel param changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_124 & ~_GEN_52)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel size changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_124 & ~_GEN_53)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel source changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_124 & ~_GEN_54)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel sink changed with multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_124 & ~_GEN_55)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel denied changed with multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_125 & ~_GEN_56)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel opcode changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_125 & ~_GEN_57)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel param changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_125 & ~_GEN_58)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel size changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_125 & (|source_2))
        $fwrite(32'h80000002, "Assertion failed: 'B' channel source changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_125 & ~_GEN_59)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel addresss changed with multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_126 & ~_GEN_60)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel opcode changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_126 & ~_GEN_61)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel param changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_126 & ~_GEN_62)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel size changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_126 & ~_GEN_63)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel source changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_126 & ~_GEN_64)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel address changed with multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_127 & _GEN_67[0])
        $fwrite(32'h80000002, "Assertion failed: 'A' channel re-used a source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_128 & ~_GEN_72)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_129 & ~_GEN_74)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_129 & ~_GEN_75)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_130 & ~_GEN_79)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_130 & ~_GEN_80)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_131 & ~_GEN_81)
        $fwrite(32'h80000002, "Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_82)
        $fwrite(32'h80000002, "Assertion failed: 'A' and 'D' concurrent, despite minlatency 2 (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_83)
        $fwrite(32'h80000002, "Assertion failed: TileLink timeout expired (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_132 & _GEN_86[0])
        $fwrite(32'h80000002, "Assertion failed: 'C' channel re-used a source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_133 & ~_GEN_90)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_134 & ~_GEN_91)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_135 & ~_GEN_92)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_136 & ~_GEN_93)
        $fwrite(32'h80000002, "Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_137 & ~_GEN_94)
        $fwrite(32'h80000002, "Assertion failed: 'C' and 'D' concurrent, despite minlatency 2 (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_95)
        $fwrite(32'h80000002, "Assertion failed: TileLink timeout expired (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_138 & _GEN_97[0])
        $fwrite(32'h80000002, "Assertion failed: 'D' channel re-used a sink ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_122 & ~(_GEN_98[0]))
        $fwrite(32'h80000002, "Assertion failed: 'E' channel acknowledged for nothing inflight (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:126:13)\n    at Monitor.scala:42 assert(cond, message)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire [12:0]  _a_first_beats1_decode_T_1 = 13'h3F << _GEN;
  wire [12:0]  _a_first_beats1_decode_T_5 = 13'h3F << _GEN;
  wire [12:0]  _GEN_139 = {10'h0, io_in_d_bits_size};
  wire [12:0]  _d_first_beats1_decode_T_1 = 13'h3F << _GEN_139;
  wire [12:0]  _d_first_beats1_decode_T_5 = 13'h3F << _GEN_139;
  wire [12:0]  _d_first_beats1_decode_T_9 = 13'h3F << _GEN_139;
  wire [12:0]  _d_first_beats1_decode_T_13 = 13'h3F << _GEN_139;
  wire [12:0]  _c_first_beats1_decode_T_1 = 13'h3F << _GEN_34;
  wire [12:0]  _c_first_beats1_decode_T_5 = 13'h3F << _GEN_34;
  wire [514:0] _GEN_140 = {507'h0, io_in_a_bits_source, 2'h0};
  wire         _GEN_141 = _d_first_T_3 & d_first_1 & ~d_release_ack;
  wire [526:0] _GEN_142 = {519'h0, io_in_d_bits_source, 2'h0};
  wire         _GEN_143 = _d_first_T_3 & d_first_2 & d_release_ack;
  wire [526:0] _d_opcodes_clr_T_5 = 527'hF << _GEN_142;
  wire [514:0] _a_opcodes_set_T_1 = {511'h0, _GEN_66 ? {io_in_a_bits_opcode, 1'h1} : 4'h0} << _GEN_140;
  wire [526:0] _d_sizes_clr_T_5 = 527'hF << _GEN_142;
  wire [514:0] _a_sizes_set_T_1 = {511'h0, _GEN_66 ? {io_in_a_bits_size, 1'h1} : 4'h0} << _GEN_140;
  wire [526:0] _d_sizes_clr_T_11 = 527'hF << _GEN_142;
  wire [514:0] _c_sizes_set_T_1 = {511'h0, _GEN_85 ? {io_in_c_bits_size, 1'h1} : 4'h0} << {507'h0, io_in_c_bits_source, 2'h0};
  wire [15:0]  _e_clr_T = 16'h1 << io_in_e_bits_sink;
  wire         b_first_done = io_in_b_ready & io_in_b_valid;
  always @(posedge clock) begin
    if (_GEN_99) begin
      assert__assert_2: assert(_GEN_6);
      assert__assert_3: assert(_GEN_7);
      assert__assert_4: assert(source_ok);
      assert__assert_5: assert(io_in_a_bits_size[2]);
      assert__assert_6: assert(~(|_GEN_0));
      assert__assert_7: assert(_GEN_8);
      assert__assert_8: assert(~_GEN_9);
      assert__assert_9: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_100) begin
      assert__assert_10: assert(_GEN_10);
      assert__assert_11: assert(_GEN_11);
      assert__assert_12: assert(source_ok);
      assert__assert_13: assert(io_in_a_bits_size[2]);
      assert__assert_14: assert(~(|_GEN_0));
      assert__assert_15: assert(_GEN_8);
      assert__assert_16: assert(|io_in_a_bits_param);
      assert__assert_17: assert(~_GEN_9);
      assert__assert_18: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_101) begin
      assert__assert_19: assert(_GEN_13);
      assert__assert_20: assert(_GEN_14);
      assert__assert_21: assert(source_ok);
      assert__assert_22: assert(~(|_GEN_0));
      assert__assert_23: assert(~(|io_in_a_bits_param));
      assert__assert_24: assert(_GEN_15);
      assert__assert_25: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_102) begin
      assert__assert_26: assert(_GEN_16);
      assert__assert_27: assert(source_ok);
      assert__assert_28: assert(~(|_GEN_0));
      assert__assert_29: assert(~(|io_in_a_bits_param));
      assert__assert_30: assert(_GEN_15);
    end
    if (_GEN_103) begin
      assert__assert_31: assert(_GEN_17);
      assert__assert_32: assert(source_ok);
      assert__assert_33: assert(~(|_GEN_0));
      assert__assert_34: assert(~(|io_in_a_bits_param));
      assert__assert_35: assert(~(|_GEN_18));
    end
    if (_GEN_104) begin
      assert__assert_36: assert(_GEN_21);
      assert__assert_37: assert(source_ok);
      assert__assert_38: assert(~(|_GEN_0));
      assert__assert_39: assert(_GEN_22);
      assert__assert_40: assert(_GEN_15);
    end
    if (_GEN_105) begin
      assert__assert_41: assert(_GEN_24);
      assert__assert_42: assert(source_ok);
      assert__assert_43: assert(~(|_GEN_0));
      assert__assert_44: assert(~(io_in_a_bits_param[2]));
      assert__assert_45: assert(_GEN_15);
    end
    if (_GEN_106) begin
      assert__assert_46: assert(_GEN_26);
      assert__assert_47: assert(source_ok);
      assert__assert_48: assert(~(|_GEN_0));
      assert__assert_49: assert(_GEN_27);
      assert__assert_50: assert(_GEN_15);
      assert__assert_51: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_107)
      assert__assert_52: assert(_GEN_28);
    if (_GEN_108) begin
      assert__assert_53: assert(source_ok_1);
      assert__assert_54: assert(io_in_d_bits_size[2]);
      assert__assert_55: assert(~(|io_in_d_bits_param));
      assert__assert_56: assert(~io_in_d_bits_corrupt);
      assert__assert_57: assert(~io_in_d_bits_denied);
    end
    if (_GEN_109) begin
      assert__assert_58: assert(source_ok_1);
      assert__assert_59: assert(sink_ok);
      assert__assert_60: assert(io_in_d_bits_size[2]);
      assert__assert_61: assert(_GEN_29);
      assert__assert_62: assert(_GEN_30);
      assert__assert_63: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_110) begin
      assert__assert_65: assert(source_ok_1);
      assert__assert_66: assert(sink_ok);
      assert__assert_67: assert(io_in_d_bits_size[2]);
      assert__assert_68: assert(_GEN_29);
      assert__assert_69: assert(_GEN_30);
      assert__assert_70: assert(_GEN_31);
    end
    if (_GEN_111) begin
      assert__assert_72: assert(source_ok_1);
      assert__assert_73: assert(~(|io_in_d_bits_param));
      assert__assert_74: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_112) begin
      assert__assert_76: assert(source_ok_1);
      assert__assert_77: assert(~(|io_in_d_bits_param));
      assert__assert_78: assert(_GEN_31);
    end
    if (_GEN_113) begin
      assert__assert_80: assert(source_ok_1);
      assert__assert_81: assert(~(|io_in_d_bits_param));
      assert__assert_82: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_114) begin
      assert__assert_86: assert(~_GEN_32);
      assert__assert_87: assert(~_GEN_32);
      assert__assert_89: assert(~(|(io_in_b_bits_address[5:0])));
      assert__assert_90: assert(_GEN_33);
    end
    if (_GEN_115) begin
      assert__assert_132: assert(~_GEN_36);
      assert__assert_133: assert(source_ok_2);
      assert__assert_134: assert(io_in_c_bits_size[2]);
      assert__assert_135: assert(~(|_GEN_35));
      assert__assert_136: assert(_GEN_37);
      assert__assert_137: assert(~io_in_c_bits_corrupt);
    end
    if (_GEN_116) begin
      assert__assert_138: assert(~_GEN_36);
      assert__assert_139: assert(source_ok_2);
      assert__assert_140: assert(io_in_c_bits_size[2]);
      assert__assert_141: assert(~(|_GEN_35));
      assert__assert_142: assert(_GEN_37);
    end
    if (_GEN_117) begin
      assert__assert_143: assert(_GEN_41);
      assert__assert_144: assert(_GEN_42);
      assert__assert_145: assert(source_ok_2);
      assert__assert_146: assert(io_in_c_bits_size[2]);
      assert__assert_147: assert(~(|_GEN_35));
      assert__assert_148: assert(_GEN_37);
      assert__assert_149: assert(~io_in_c_bits_corrupt);
    end
    if (_GEN_118) begin
      assert__assert_150: assert(_GEN_43);
      assert__assert_151: assert(_GEN_44);
      assert__assert_152: assert(source_ok_2);
      assert__assert_153: assert(io_in_c_bits_size[2]);
      assert__assert_154: assert(~(|_GEN_35));
      assert__assert_155: assert(_GEN_37);
    end
    if (_GEN_119) begin
      assert__assert_156: assert(~_GEN_36);
      assert__assert_157: assert(source_ok_2);
      assert__assert_158: assert(~(|_GEN_35));
      assert__assert_159: assert(~(|io_in_c_bits_param));
      assert__assert_160: assert(~io_in_c_bits_corrupt);
    end
    if (_GEN_120) begin
      assert__assert_161: assert(~_GEN_36);
      assert__assert_162: assert(source_ok_2);
      assert__assert_163: assert(~(|_GEN_35));
      assert__assert_164: assert(~(|io_in_c_bits_param));
    end
    if (_GEN_121) begin
      assert__assert_165: assert(~_GEN_36);
      assert__assert_166: assert(source_ok_2);
      assert__assert_167: assert(~(|_GEN_35));
      assert__assert_168: assert(~(|io_in_c_bits_param));
      assert__assert_169: assert(~io_in_c_bits_corrupt);
    end
    if (_GEN_122)
      assert__assert_170: assert(sink_ok_1);
    if (_GEN_123) begin
      assert__assert_171: assert(_GEN_45);
      assert__assert_172: assert(_GEN_46);
      assert__assert_173: assert(_GEN_47);
      assert__assert_174: assert(_GEN_48);
      assert__assert_175: assert(_GEN_49);
    end
    if (_GEN_124) begin
      assert__assert_176: assert(_GEN_50);
      assert__assert_177: assert(_GEN_51);
      assert__assert_178: assert(_GEN_52);
      assert__assert_179: assert(_GEN_53);
      assert__assert_180: assert(_GEN_54);
      assert__assert_181: assert(_GEN_55);
    end
    if (_GEN_125) begin
      assert__assert_182: assert(_GEN_56);
      assert__assert_183: assert(_GEN_57);
      assert__assert_184: assert(_GEN_58);
      assert__assert_185: assert(~(|source_2));
      assert__assert_186: assert(_GEN_59);
    end
    if (_GEN_126) begin
      assert__assert_187: assert(_GEN_60);
      assert__assert_188: assert(_GEN_61);
      assert__assert_189: assert(_GEN_62);
      assert__assert_190: assert(_GEN_63);
      assert__assert_191: assert(_GEN_64);
    end
    if (_GEN_127)
      assert__assert_192: assert(~(_GEN_67[0]));
    if (_GEN_128)
      assert__assert_193: assert(_GEN_72);
    if (_GEN_129) begin
      assert__assert_194: assert(_GEN_74);
      assert__assert_195: assert(_GEN_75);
    end
    if (_GEN_130) begin
      assert__assert_196: assert(_GEN_79);
      assert__assert_197: assert(_GEN_80);
    end
    if (_GEN_131)
      assert__assert_198: assert(_GEN_81);
    if (~reset) begin
      assert__assert_199: assert(_GEN_82);
      assert__assert_200: assert(_GEN_83);
    end
    if (_GEN_132)
      assert__assert_201: assert(~(_GEN_86[0]));
    if (_GEN_133)
      assert__assert_202: assert(_GEN_90);
    if (_GEN_134)
      assert__assert_203: assert(_GEN_91);
    if (_GEN_135)
      assert__assert_204: assert(_GEN_92);
    if (_GEN_136)
      assert__assert_205: assert(_GEN_93);
    if (_GEN_137)
      assert__assert_206: assert(_GEN_94);
    if (~reset)
      assert__assert_207: assert(_GEN_95);
    if (_GEN_138)
      assert__assert_208: assert(~(_GEN_97[0]));
    if (_GEN_122)
      assert__assert_209: assert(_GEN_98[0]);
    if (reset) begin
      a_first_counter <= 2'h0;
      d_first_counter <= 2'h0;
      b_first_counter <= 2'h0;
      c_first_counter <= 2'h0;
      inflight <= 48'h0;
      inflight_opcodes <= 192'h0;
      inflight_sizes <= 192'h0;
      a_first_counter_1 <= 2'h0;
      d_first_counter_1 <= 2'h0;
      watchdog <= 32'h0;
      inflight_1 <= 48'h0;
      inflight_sizes_1 <= 192'h0;
      c_first_counter_1 <= 2'h0;
      d_first_counter_2 <= 2'h0;
      watchdog_1 <= 32'h0;
      inflight_2 <= 12'h0;
      d_first_counter_3 <= 2'h0;
    end
    else begin
      if (_a_first_T_1) begin
        if (|a_first_counter)
          a_first_counter <= a_first_counter - 2'h1;
        else if (io_in_a_bits_opcode[2])
          a_first_counter <= 2'h0;
        else
          a_first_counter <= ~(_a_first_beats1_decode_T_1[5:4]);
        if (a_first_1) begin
          if (io_in_a_bits_opcode[2])
            a_first_counter_1 <= 2'h0;
          else
            a_first_counter_1 <= ~(_a_first_beats1_decode_T_5[5:4]);
        end
        else
          a_first_counter_1 <= a_first_counter_1 - 2'h1;
      end
      if (_d_first_T_3) begin
        if (|d_first_counter)
          d_first_counter <= d_first_counter - 2'h1;
        else if (io_in_d_bits_opcode[0])
          d_first_counter <= ~(_d_first_beats1_decode_T_1[5:4]);
        else
          d_first_counter <= 2'h0;
        if (d_first_1) begin
          if (io_in_d_bits_opcode[0])
            d_first_counter_1 <= ~(_d_first_beats1_decode_T_5[5:4]);
          else
            d_first_counter_1 <= 2'h0;
        end
        else
          d_first_counter_1 <= d_first_counter_1 - 2'h1;
        if (d_first_2) begin
          if (io_in_d_bits_opcode[0])
            d_first_counter_2 <= ~(_d_first_beats1_decode_T_9[5:4]);
          else
            d_first_counter_2 <= 2'h0;
        end
        else
          d_first_counter_2 <= d_first_counter_2 - 2'h1;
        if (d_first_3) begin
          if (io_in_d_bits_opcode[0])
            d_first_counter_3 <= ~(_d_first_beats1_decode_T_13[5:4]);
          else
            d_first_counter_3 <= 2'h0;
        end
        else
          d_first_counter_3 <= d_first_counter_3 - 2'h1;
      end
      if (b_first_done) begin
        if (|b_first_counter)
          b_first_counter <= b_first_counter - 2'h1;
        else
          b_first_counter <= 2'h0;
      end
      if (_c_first_T_1) begin
        if (|c_first_counter)
          c_first_counter <= c_first_counter - 2'h1;
        else if (io_in_c_bits_opcode[0])
          c_first_counter <= ~(_c_first_beats1_decode_T_1[5:4]);
        else
          c_first_counter <= 2'h0;
        if (c_first_1) begin
          if (io_in_c_bits_opcode[0])
            c_first_counter_1 <= ~(_c_first_beats1_decode_T_5[5:4]);
          else
            c_first_counter_1 <= 2'h0;
        end
        else
          c_first_counter_1 <= c_first_counter_1 - 2'h1;
      end
      inflight <= (inflight | (_GEN_66 ? _a_set_T[47:0] : 48'h0)) & ~(_GEN_141 ? _d_clr_T_1[47:0] : 48'h0);
      inflight_opcodes <= (inflight_opcodes | (_GEN_66 ? _a_opcodes_set_T_1[191:0] : 192'h0)) & ~(_GEN_141 ? _d_opcodes_clr_T_5[191:0] : 192'h0);
      inflight_sizes <= (inflight_sizes | (_GEN_66 ? _a_sizes_set_T_1[191:0] : 192'h0)) & ~(_GEN_141 ? _d_sizes_clr_T_5[191:0] : 192'h0);
      if (_a_first_T_1 | _d_first_T_3)
        watchdog <= 32'h0;
      else
        watchdog <= watchdog + 32'h1;
      inflight_1 <= (inflight_1 | (_GEN_85 ? _c_set_T[47:0] : 48'h0)) & ~(_GEN_143 ? _d_clr_T_1[47:0] : 48'h0);
      inflight_sizes_1 <= (inflight_sizes_1 | (_GEN_85 ? _c_sizes_set_T_1[191:0] : 192'h0)) & ~(_GEN_143 ? _d_sizes_clr_T_11[191:0] : 192'h0);
      if (_c_first_T_1 | _d_first_T_3)
        watchdog_1 <= 32'h0;
      else
        watchdog_1 <= watchdog_1 + 32'h1;
      inflight_2 <= (inflight_2 | _GEN_84_0) & ~(io_in_e_valid ? _e_clr_T[11:0] : 12'h0);
    end
    if (_a_first_T_1 & ~(|a_first_counter)) begin
      opcode <= io_in_a_bits_opcode;
      param <= io_in_a_bits_param;
      size <= io_in_a_bits_size;
      source <= io_in_a_bits_source;
      address <= io_in_a_bits_address;
    end
    if (_d_first_T_3 & ~(|d_first_counter)) begin
      opcode_1 <= io_in_d_bits_opcode;
      param_1 <= io_in_d_bits_param;
      size_1 <= io_in_d_bits_size;
      source_1 <= io_in_d_bits_source;
      sink <= io_in_d_bits_sink;
      denied <= io_in_d_bits_denied;
    end
    if (b_first_done & ~(|b_first_counter)) begin
      opcode_2 <= 3'h6;
      param_2 <= io_in_b_bits_param;
      size_2 <= 3'h6;
      source_2 <= 6'h0;
      address_1 <= io_in_b_bits_address;
    end
    if (_c_first_T_1 & ~(|c_first_counter)) begin
      opcode_3 <= io_in_c_bits_opcode;
      param_3 <= io_in_c_bits_param;
      size_3 <= io_in_c_bits_size;
      source_3 <= io_in_c_bits_source;
      address_2 <= io_in_c_bits_address;
    end
  end // always @(posedge)
  plusarg_reader #(
    .DEFAULT(0),
    .FORMAT("tilelink_timeout=%d"),
    .WIDTH(32)
  ) plusarg_reader (
    .out (_plusarg_reader_out)
  );
  plusarg_reader #(
    .DEFAULT(0),
    .FORMAT("tilelink_timeout=%d"),
    .WIDTH(32)
  ) plusarg_reader_1 (
    .out (_plusarg_reader_1_out)
  );
endmodule

