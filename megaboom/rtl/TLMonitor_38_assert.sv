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
module TLMonitor_38_assert(
  input [31:0] io_in_a_bits_address,
  input [2:0]  io_in_a_bits_size,
  input [3:0]  io_in_a_bits_source,
  input [2:0]  io_in_a_bits_param,
  input [7:0]  io_in_a_bits_mask,
  input        io_in_a_bits_corrupt,
  input [2:0]  io_in_d_bits_opcode,
  input [3:0]  io_in_d_bits_source,
  input [2:0]  io_in_d_bits_size,
  input [1:0]  io_in_d_bits_param,
  input        io_in_d_bits_corrupt,
               io_in_d_bits_denied,
  input [31:0] io_in_c_bits_address,
  input [3:0]  io_in_c_bits_source,
  input [2:0]  io_in_c_bits_size,
               io_in_c_bits_param,
  input        io_in_c_bits_corrupt,
  input [2:0]  io_in_a_bits_opcode,
  input        clock,
               reset,
               io_in_a_ready,
               io_in_a_valid,
               io_in_d_ready,
               io_in_d_valid,
  input [2:0]  io_in_d_bits_sink,
               io_in_c_bits_opcode,
  input        io_in_c_ready,
               io_in_c_valid,
               io_in_e_valid,
  input [2:0]  io_in_e_bits_sink
);

  wire [31:0]  _plusarg_reader_1_out;
  wire [31:0]  _plusarg_reader_out;
  wire         _source_ok_WIRE_0 = io_in_a_bits_source < 4'hA;
  wire [12:0]  _GEN = {10'h0, io_in_a_bits_size};
  wire [12:0]  _is_aligned_mask_T_1 = 13'h3F << _GEN;
  wire [5:0]   _GEN_0 = io_in_a_bits_address[5:0] & ~(_is_aligned_mask_T_1[5:0]);
  wire         _mask_T = io_in_a_bits_size > 3'h2;
  wire         mask_size = io_in_a_bits_size[1:0] == 2'h2;
  wire         mask_acc = _mask_T | mask_size & ~(io_in_a_bits_address[2]);
  wire         mask_acc_1 = _mask_T | mask_size & io_in_a_bits_address[2];
  wire         mask_size_1 = io_in_a_bits_size[1:0] == 2'h1;
  wire         mask_eq_2 = ~(io_in_a_bits_address[2]) & ~(io_in_a_bits_address[1]);
  wire         mask_acc_2 = mask_acc | mask_size_1 & mask_eq_2;
  wire         mask_eq_3 = ~(io_in_a_bits_address[2]) & io_in_a_bits_address[1];
  wire         mask_acc_3 = mask_acc | mask_size_1 & mask_eq_3;
  wire         mask_eq_4 = io_in_a_bits_address[2] & ~(io_in_a_bits_address[1]);
  wire         mask_acc_4 = mask_acc_1 | mask_size_1 & mask_eq_4;
  wire         mask_eq_5 = io_in_a_bits_address[2] & io_in_a_bits_address[1];
  wire         mask_acc_5 = mask_acc_1 | mask_size_1 & mask_eq_5;
  wire [7:0]   mask = {mask_acc_5 | mask_eq_5 & io_in_a_bits_address[0], mask_acc_5 | mask_eq_5 & ~(io_in_a_bits_address[0]), mask_acc_4 | mask_eq_4 & io_in_a_bits_address[0], mask_acc_4 | mask_eq_4 & ~(io_in_a_bits_address[0]), mask_acc_3 | mask_eq_3 & io_in_a_bits_address[0], mask_acc_3 | mask_eq_3 & ~(io_in_a_bits_address[0]), mask_acc_2 | mask_eq_2 & io_in_a_bits_address[0], mask_acc_2 | mask_eq_2 & ~(io_in_a_bits_address[0])};
  wire         _GEN_1 = io_in_a_bits_opcode == 3'h6;
  wire         _GEN_2 = io_in_a_bits_source < 4'hA;
  wire         _GEN_3 = io_in_a_bits_address[31:28] == 4'h8;
  wire         _GEN_4 = io_in_a_bits_size != 3'h7 & _GEN_3;
  wire         _GEN_5 = _GEN_2 & _GEN_4;
  wire         _GEN_6 = io_in_a_bits_size == 3'h6 & _GEN_3;
  wire         _GEN_7 = io_in_a_bits_param < 3'h3;
  wire         _GEN_8 = io_in_a_bits_mask != 8'hFF;
  wire         _GEN_9 = io_in_a_bits_opcode == 3'h4;
  wire         _GEN_10 = io_in_a_bits_mask == mask;
  wire [7:0]   _GEN_11 = io_in_a_bits_mask & ~mask;
  wire         _GEN_12 = io_in_a_bits_opcode == 3'h2;
  wire         _GEN_13 = io_in_a_bits_param < 3'h5;
  wire         _GEN_14 = io_in_a_bits_opcode == 3'h3;
  wire         _GEN_15 = io_in_a_bits_opcode == 3'h5;
  wire         _GEN_16 = io_in_a_bits_param < 3'h2;
  wire         _GEN_17 = io_in_d_bits_opcode != 3'h7;
  wire         _source_ok_WIRE_1_0 = io_in_d_bits_source < 4'hA;
  wire         d_release_ack = io_in_d_bits_opcode == 3'h6;
  wire         _GEN_18 = io_in_d_bits_size > 3'h2;
  wire         _GEN_19 = io_in_d_bits_param != 2'h3;
  wire         _GEN_20 = io_in_d_bits_param != 2'h2;
  wire         _GEN_21 = ~io_in_d_bits_denied | io_in_d_bits_corrupt;
  wire         _source_ok_WIRE_2_0 = io_in_c_bits_source < 4'hA;
  wire [12:0]  _GEN_22 = {10'h0, io_in_c_bits_size};
  wire [12:0]  _is_aligned_mask_T_7 = 13'h3F << _GEN_22;
  wire [5:0]   _GEN_23 = io_in_c_bits_address[5:0] & ~(_is_aligned_mask_T_7[5:0]);
  wire         _GEN_24 = io_in_c_bits_address[31:28] != 4'h8;
  wire         _c_probe_ack_T = io_in_c_bits_opcode == 3'h4;
  wire         _GEN_25 = io_in_c_bits_size > 3'h2;
  wire         _GEN_26 = io_in_c_bits_param[2:1] != 2'h3;
  wire         _c_probe_ack_T_1 = io_in_c_bits_opcode == 3'h5;
  wire         _GEN_27 = io_in_c_bits_source < 4'hA & io_in_c_bits_size != 3'h7 & ~_GEN_24;
  wire         _GEN_28 = io_in_c_bits_size == 3'h6 & ~_GEN_24;
  wire         _a_first_T_1 = io_in_a_ready & io_in_a_valid;
  reg  [2:0]   a_first_counter;
  reg  [2:0]   opcode;
  reg  [2:0]   param;
  reg  [2:0]   size;
  reg  [3:0]   source;
  reg  [31:0]  address;
  wire         _GEN_29 = io_in_a_bits_opcode == opcode;
  wire         _GEN_30 = io_in_a_bits_param == param;
  wire         _GEN_31 = io_in_a_bits_size == size;
  wire         _GEN_32 = io_in_a_bits_source == source;
  wire         _GEN_33 = io_in_a_bits_address == address;
  wire         _d_first_T_3 = io_in_d_ready & io_in_d_valid;
  reg  [2:0]   d_first_counter;
  reg  [2:0]   opcode_1;
  reg  [1:0]   param_1;
  reg  [2:0]   size_1;
  reg  [3:0]   source_1;
  reg  [2:0]   sink;
  reg          denied;
  wire         _GEN_34 = io_in_d_bits_opcode == opcode_1;
  wire         _GEN_35 = io_in_d_bits_param == param_1;
  wire         _GEN_36 = io_in_d_bits_size == size_1;
  wire         _GEN_37 = io_in_d_bits_source == source_1;
  wire         _GEN_38 = io_in_d_bits_sink == sink;
  wire         _GEN_39 = io_in_d_bits_denied == denied;
  wire         _c_first_T_1 = io_in_c_ready & io_in_c_valid;
  reg  [2:0]   c_first_counter;
  reg  [2:0]   opcode_3;
  reg  [2:0]   param_3;
  reg  [2:0]   size_3;
  reg  [3:0]   source_3;
  reg  [31:0]  address_2;
  wire         _GEN_40 = io_in_c_bits_opcode == opcode_3;
  wire         _GEN_41 = io_in_c_bits_param == param_3;
  wire         _GEN_42 = io_in_c_bits_size == size_3;
  wire         _GEN_43 = io_in_c_bits_source == source_3;
  wire         _GEN_44 = io_in_c_bits_address == address_2;
  reg  [9:0]   inflight;
  reg  [39:0]  inflight_opcodes;
  reg  [39:0]  inflight_sizes;
  reg  [2:0]   a_first_counter_1;
  wire         a_first_1 = a_first_counter_1 == 3'h0;
  reg  [2:0]   d_first_counter_1;
  wire         d_first_1 = d_first_counter_1 == 3'h0;
  wire [39:0]  _GEN_45 = {34'h0, io_in_d_bits_source, 2'h0};
  wire [39:0]  _a_opcode_lookup_T_1 = inflight_opcodes >> _GEN_45;
  wire [39:0]  _a_size_lookup_T_1 = inflight_sizes >> _GEN_45;
  wire         _same_cycle_resp_T_1 = io_in_a_valid & a_first_1;
  wire [15:0]  _a_set_T = 16'h1 << io_in_a_bits_source;
  wire [9:0]   _GEN_27_0 = _same_cycle_resp_T_1 ? _a_set_T[9:0] : 10'h0;
  wire         _GEN_46 = _a_first_T_1 & a_first_1;
  wire [9:0]   _GEN_47 = inflight >> io_in_a_bits_source;
  wire         _GEN_48 = io_in_d_valid & d_first_1;
  wire         _GEN_49 = _GEN_48 & ~d_release_ack;
  wire [15:0]  _d_clr_T_1 = 16'h1 << io_in_d_bits_source;
  wire         _same_cycle_resp_T_2 = io_in_a_bits_source == io_in_d_bits_source;
  wire         same_cycle_resp = _same_cycle_resp_T_1 & _same_cycle_resp_T_2;
  wire [9:0]   _GEN_50 = {6'h0, io_in_d_bits_source};
  wire [9:0]   _GEN_51 = inflight >> _GEN_50;
  wire         _GEN_52 = _GEN_51[0] | same_cycle_resp;
  wire         _GEN_53 = _GEN_9 | _GEN_14 | _GEN_12;
  wire         _GEN_54 = io_in_d_bits_opcode == ((&io_in_a_bits_opcode) | _GEN_1 ? 3'h4 : _GEN_15 ? 3'h2 : {2'h0, _GEN_53}) | io_in_d_bits_opcode == ((&io_in_a_bits_opcode) ? 3'h4 : _GEN_1 ? 3'h5 : _GEN_15 ? 3'h2 : {2'h0, _GEN_53});
  wire         _GEN_55 = io_in_a_bits_size == io_in_d_bits_size;
  wire         _GEN_56 = _a_opcode_lookup_T_1[3:1] == 3'h4 | _a_opcode_lookup_T_1[3:1] == 3'h3 | _a_opcode_lookup_T_1[3:1] == 3'h2;
  wire         _GEN_57 = _a_opcode_lookup_T_1[3:1] == 3'h5;
  wire         _GEN_58 = _a_opcode_lookup_T_1[3:1] == 3'h6;
  wire         _GEN_59 = io_in_d_bits_opcode == ((&(_a_opcode_lookup_T_1[3:1])) | _GEN_58 ? 3'h4 : _GEN_57 ? 3'h2 : {2'h0, _GEN_56}) | io_in_d_bits_opcode == ((&(_a_opcode_lookup_T_1[3:1])) ? 3'h4 : _GEN_58 ? 3'h5 : _GEN_57 ? 3'h2 : {2'h0, _GEN_56});
  wire         _GEN_60 = io_in_d_bits_size == _a_size_lookup_T_1[3:1];
  wire         _GEN_61 = ~io_in_d_ready | io_in_a_ready;
  wire         _GEN_62 = _GEN_27_0 != (_GEN_49 ? _d_clr_T_1[9:0] : 10'h0) | _GEN_27_0 == 10'h0;
  reg  [31:0]  watchdog;
  wire         _GEN_63 = inflight == 10'h0 | _plusarg_reader_out == 32'h0 | watchdog < _plusarg_reader_out;
  reg  [9:0]   inflight_1;
  reg  [39:0]  inflight_sizes_1;
  reg  [2:0]   c_first_counter_1;
  wire         c_first_1 = c_first_counter_1 == 3'h0;
  reg  [2:0]   d_first_counter_2;
  wire         d_first_2 = d_first_counter_2 == 3'h0;
  wire [39:0]  _c_size_lookup_T_1 = inflight_sizes_1 >> _GEN_45;
  wire         _same_cycle_resp_T_3 = io_in_c_valid & c_first_1;
  wire         _GEN_64 = io_in_c_bits_opcode[2] & io_in_c_bits_opcode[1];
  wire [15:0]  _c_set_T = 16'h1 << io_in_c_bits_source;
  wire [9:0]   _GEN_72 = _same_cycle_resp_T_3 & _GEN_64 ? _c_set_T[9:0] : 10'h0;
  wire         _GEN_65 = _c_first_T_1 & c_first_1 & _GEN_64;
  wire [9:0]   _GEN_66 = inflight_1 >> io_in_c_bits_source;
  wire         _GEN_67 = io_in_d_valid & d_first_2;
  wire         _GEN_68 = _GEN_67 & d_release_ack;
  wire         _same_cycle_resp_T_8 = io_in_c_bits_source == io_in_d_bits_source;
  wire         same_cycle_resp_1 = _same_cycle_resp_T_3 & io_in_c_bits_opcode[2] & io_in_c_bits_opcode[1] & _same_cycle_resp_T_8;
  wire [9:0]   _GEN_69 = inflight_1 >> _GEN_50;
  wire         _GEN_70 = _GEN_69[0] | same_cycle_resp_1;
  wire         _GEN_71 = io_in_d_bits_size == io_in_c_bits_size;
  wire         _GEN_73 = io_in_d_bits_size == _c_size_lookup_T_1[3:1];
  wire         _GEN_74 = ~io_in_d_ready | io_in_c_ready;
  wire         _GEN_75 = _GEN_72 != (_GEN_68 ? _d_clr_T_1[9:0] : 10'h0);
  reg  [31:0]  watchdog_1;
  wire         _GEN_76 = inflight_1 == 10'h0 | _plusarg_reader_1_out == 32'h0 | watchdog_1 < _plusarg_reader_1_out;
  reg  [7:0]   inflight_2;
  reg  [2:0]   d_first_counter_3;
  wire         d_first_3 = d_first_counter_3 == 3'h0;
  wire         _GEN_77 = _d_first_T_3 & d_first_3 & io_in_d_bits_opcode[2] & ~(io_in_d_bits_opcode[1]);
  wire [7:0]   _GEN_78 = {5'h0, io_in_d_bits_sink};
  wire [7:0]   _GEN_79 = inflight_2 >> _GEN_78;
  wire [7:0]   d_set = _GEN_77 ? 8'h1 << _GEN_78 : 8'h0;
  wire [7:0]   _GEN_80 = {5'h0, io_in_e_bits_sink};
  wire [7:0]   _GEN_81 = (d_set | inflight_2) >> _GEN_80;
  wire         _GEN_82 = io_in_a_valid & _GEN_1 & ~reset;
  wire         _GEN_83 = io_in_a_valid & (&io_in_a_bits_opcode) & ~reset;
  wire         _GEN_84 = io_in_a_valid & _GEN_9 & ~reset;
  wire         _GEN_85 = io_in_a_valid & io_in_a_bits_opcode == 3'h0 & ~reset;
  wire         _GEN_86 = io_in_a_valid & io_in_a_bits_opcode == 3'h1 & ~reset;
  wire         _GEN_87 = io_in_a_valid & _GEN_12 & ~reset;
  wire         _GEN_88 = io_in_a_valid & _GEN_14 & ~reset;
  wire         _GEN_89 = io_in_a_valid & _GEN_15 & ~reset;
  wire         _GEN_90 = io_in_d_valid & ~reset;
  wire         _GEN_91 = io_in_d_valid & d_release_ack & ~reset;
  wire         _GEN_92 = io_in_d_valid & io_in_d_bits_opcode == 3'h4 & ~reset;
  wire         _GEN_93 = io_in_d_valid & io_in_d_bits_opcode == 3'h5 & ~reset;
  wire         _GEN_94 = io_in_d_valid & io_in_d_bits_opcode == 3'h0 & ~reset;
  wire         _GEN_95 = io_in_d_valid & io_in_d_bits_opcode == 3'h1 & ~reset;
  wire         _GEN_96 = io_in_d_valid & io_in_d_bits_opcode == 3'h2 & ~reset;
  wire         _GEN_97 = io_in_c_valid & _c_probe_ack_T & ~reset;
  wire         _GEN_98 = io_in_c_valid & _c_probe_ack_T_1 & ~reset;
  wire         _GEN_99 = io_in_c_valid & io_in_c_bits_opcode == 3'h6 & ~reset;
  wire         _GEN_100 = io_in_c_valid & (&io_in_c_bits_opcode) & ~reset;
  wire         _GEN_101 = io_in_c_valid & io_in_c_bits_opcode == 3'h0 & ~reset;
  wire         _GEN_102 = io_in_c_valid & io_in_c_bits_opcode == 3'h1 & ~reset;
  wire         _GEN_103 = io_in_c_valid & io_in_c_bits_opcode == 3'h2 & ~reset;
  wire         _GEN_104 = io_in_a_valid & (|a_first_counter) & ~reset;
  wire         _GEN_105 = io_in_d_valid & (|d_first_counter) & ~reset;
  wire         _GEN_106 = io_in_c_valid & (|c_first_counter) & ~reset;
  wire         _GEN_107 = _GEN_46 & ~reset;
  wire         _GEN_108 = _GEN_49 & ~reset;
  wire         _GEN_109 = _GEN_49 & same_cycle_resp & ~reset;
  wire         _GEN_110 = _GEN_49 & ~same_cycle_resp & ~reset;
  wire         _GEN_111 = _GEN_48 & a_first_1 & io_in_a_valid & _same_cycle_resp_T_2 & ~d_release_ack & ~reset;
  wire         _GEN_112 = _GEN_65 & ~reset;
  wire         _GEN_113 = _GEN_68 & ~reset;
  wire         _GEN_114 = _GEN_68 & same_cycle_resp_1 & ~reset;
  wire         _GEN_115 = _GEN_68 & ~same_cycle_resp_1 & ~reset;
  wire         _GEN_116 = _GEN_67 & c_first_1 & io_in_c_valid & _same_cycle_resp_T_8 & d_release_ack & ~(_c_probe_ack_T | _c_probe_ack_T_1) & ~reset;
  wire         _GEN_117 = (|_GEN_72) & ~reset;
  wire         _GEN_118 = _GEN_77 & ~reset;
  wire         _GEN_119 = io_in_e_valid & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_82 & ~_GEN_5)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquireBlock type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_82 & ~_GEN_6)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquireBlock from a client which does not support Probe (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_82 & ~_source_ok_WIRE_0)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_82 & ~_mask_T)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_82 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_82 & ~_GEN_7)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock carries invalid grow param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_82 & _GEN_8)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_82 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_83 & ~_GEN_5)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquirePerm type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_83 & ~_GEN_6)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquirePerm from a client which does not support Probe (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_83 & ~_source_ok_WIRE_0)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_83 & ~_mask_T)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_83 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_83 & ~_GEN_7)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm carries invalid grow param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_83 & ~(|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm requests NtoB (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_83 & _GEN_8)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_83 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_84 & ~_GEN_2)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Get type which master claims it can't emit (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_84 & ~_GEN_4)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Get type which slave claims it can't support (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_84 & ~_source_ok_WIRE_0)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_84 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_84 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_84 & ~_GEN_10)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_84 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_85 & ~_GEN_5)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries PutFull type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_85 & ~_source_ok_WIRE_0)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_85 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_85 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_85 & ~_GEN_10)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_86 & ~_GEN_5)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries PutPartial type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_86 & ~_source_ok_WIRE_0)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_86 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_86 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_86 & (|_GEN_11))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_87)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Arithmetic type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_87 & ~_source_ok_WIRE_0)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_87 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_87 & ~_GEN_13)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic carries invalid opcode param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_87 & ~_GEN_10)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_88)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Logical type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_88 & ~_source_ok_WIRE_0)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_88 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_88 & io_in_a_bits_param[2])
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical carries invalid opcode param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_88 & ~_GEN_10)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_89)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Hint type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_89 & ~_source_ok_WIRE_0)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_89 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_89 & ~_GEN_16)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint carries invalid opcode param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_89 & ~_GEN_10)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_89 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_90 & ~_GEN_17)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel has invalid opcode (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_91 & ~_source_ok_WIRE_1_0)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_91 & ~_GEN_18)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_91 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseeAck carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_91 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_91 & io_in_d_bits_denied)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck is denied (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_92 & ~_source_ok_WIRE_1_0)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_92 & ~_GEN_18)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_92 & ~_GEN_19)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid cap param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_92 & ~_GEN_20)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries toN param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_92 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_93 & ~_source_ok_WIRE_1_0)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_93 & ~_GEN_18)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_93 & ~_GEN_19)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid cap param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_93 & ~_GEN_20)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries toN param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_93 & ~_GEN_21)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData is denied but not corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_94 & ~_source_ok_WIRE_1_0)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_94 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_94 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_95 & ~_source_ok_WIRE_1_0)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_95 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_95 & ~_GEN_21)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData is denied but not corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_96 & ~_source_ok_WIRE_1_0)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_96 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_96 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_97 & _GEN_24)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAck carries unmanaged address (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_97 & ~_source_ok_WIRE_2_0)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAck carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_97 & ~_GEN_25)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAck smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_97 & (|_GEN_23))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAck address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_97 & ~_GEN_26)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAck carries invalid report param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_97 & io_in_c_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAck is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_98 & _GEN_24)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAckData carries unmanaged address (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_98 & ~_source_ok_WIRE_2_0)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAckData carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_98 & ~_GEN_25)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAckData smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_98 & (|_GEN_23))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAckData address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_98 & ~_GEN_26)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAckData carries invalid report param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_99 & ~_GEN_27)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel carries Release type unsupported by manager (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_99 & ~_GEN_28)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel carries Release from a client which does not support Probe (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_99 & ~_source_ok_WIRE_2_0)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel Release carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_99 & ~_GEN_25)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel Release smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_99 & (|_GEN_23))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel Release address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_99 & ~_GEN_26)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel Release carries invalid report param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_99 & io_in_c_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel Release is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_100 & ~_GEN_27)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel carries ReleaseData type unsupported by manager (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_100 & ~_GEN_28)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel carries Release from a client which does not support Probe (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_100 & ~_source_ok_WIRE_2_0)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ReleaseData carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_100 & ~_GEN_25)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ReleaseData smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_100 & (|_GEN_23))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ReleaseData address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_100 & ~_GEN_26)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ReleaseData carries invalid report param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_101 & _GEN_24)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAck carries unmanaged address (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_101 & ~_source_ok_WIRE_2_0)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAck carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_101 & (|_GEN_23))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAck address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_101 & (|io_in_c_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAck carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_101 & io_in_c_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAck is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_102 & _GEN_24)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAckData carries unmanaged address (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_102 & ~_source_ok_WIRE_2_0)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAckData carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_102 & (|_GEN_23))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAckData address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_102 & (|io_in_c_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAckData carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_103 & _GEN_24)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel HintAck carries unmanaged address (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_103 & ~_source_ok_WIRE_2_0)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel HintAck carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_103 & (|_GEN_23))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel HintAck address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_103 & (|io_in_c_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel HintAck carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_103 & io_in_c_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel HintAck is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_104 & ~_GEN_29)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel opcode changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_104 & ~_GEN_30)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel param changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_104 & ~_GEN_31)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel size changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_104 & ~_GEN_32)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel source changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_104 & ~_GEN_33)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel address changed with multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_105 & ~_GEN_34)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel opcode changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_105 & ~_GEN_35)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel param changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_105 & ~_GEN_36)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel size changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_105 & ~_GEN_37)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel source changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_105 & ~_GEN_38)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel sink changed with multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_105 & ~_GEN_39)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel denied changed with multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_106 & ~_GEN_40)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel opcode changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_106 & ~_GEN_41)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel param changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_106 & ~_GEN_42)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel size changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_106 & ~_GEN_43)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel source changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_106 & ~_GEN_44)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel address changed with multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_107 & _GEN_47[0])
        $fwrite(32'h80000002, "Assertion failed: 'A' channel re-used a source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_108 & ~_GEN_52)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_109 & ~_GEN_54)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_109 & ~_GEN_55)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_110 & ~_GEN_59)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_110 & ~_GEN_60)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_111 & ~_GEN_61)
        $fwrite(32'h80000002, "Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_62)
        $fwrite(32'h80000002, "Assertion failed: 'A' and 'D' concurrent, despite minlatency 1 (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_63)
        $fwrite(32'h80000002, "Assertion failed: TileLink timeout expired (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_112 & _GEN_66[0])
        $fwrite(32'h80000002, "Assertion failed: 'C' channel re-used a source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_113 & ~_GEN_70)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_114 & ~_GEN_71)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_115 & ~_GEN_73)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_116 & ~_GEN_74)
        $fwrite(32'h80000002, "Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_117 & ~_GEN_75)
        $fwrite(32'h80000002, "Assertion failed: 'C' and 'D' concurrent, despite minlatency 1 (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_76)
        $fwrite(32'h80000002, "Assertion failed: TileLink timeout expired (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_118 & _GEN_79[0])
        $fwrite(32'h80000002, "Assertion failed: 'D' channel re-used a sink ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_119 & ~(_GEN_81[0]))
        $fwrite(32'h80000002, "Assertion failed: 'E' channel acknowledged for nothing inflight (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:131:34)\n    at Monitor.scala:42 assert(cond, message)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire [12:0]  _a_first_beats1_decode_T_1 = 13'h3F << _GEN;
  wire [12:0]  _a_first_beats1_decode_T_5 = 13'h3F << _GEN;
  wire [12:0]  _GEN_120 = {10'h0, io_in_d_bits_size};
  wire [12:0]  _d_first_beats1_decode_T_1 = 13'h3F << _GEN_120;
  wire [12:0]  _d_first_beats1_decode_T_5 = 13'h3F << _GEN_120;
  wire [12:0]  _d_first_beats1_decode_T_9 = 13'h3F << _GEN_120;
  wire [12:0]  _d_first_beats1_decode_T_13 = 13'h3F << _GEN_120;
  wire [12:0]  _c_first_beats1_decode_T_1 = 13'h3F << _GEN_22;
  wire [12:0]  _c_first_beats1_decode_T_5 = 13'h3F << _GEN_22;
  wire [130:0] _GEN_121 = {125'h0, io_in_a_bits_source, 2'h0};
  wire         _GEN_122 = _d_first_T_3 & d_first_1 & ~d_release_ack;
  wire [142:0] _GEN_123 = {137'h0, io_in_d_bits_source, 2'h0};
  wire         _GEN_124 = _d_first_T_3 & d_first_2 & d_release_ack;
  wire [142:0] _d_opcodes_clr_T_5 = 143'hF << _GEN_123;
  wire [130:0] _a_opcodes_set_T_1 = {127'h0, _GEN_46 ? {io_in_a_bits_opcode, 1'h1} : 4'h0} << _GEN_121;
  wire [142:0] _d_sizes_clr_T_5 = 143'hF << _GEN_123;
  wire [130:0] _a_sizes_set_T_1 = {127'h0, _GEN_46 ? {io_in_a_bits_size, 1'h1} : 4'h0} << _GEN_121;
  wire [142:0] _d_sizes_clr_T_11 = 143'hF << _GEN_123;
  wire [130:0] _c_sizes_set_T_1 = {127'h0, _GEN_65 ? {io_in_c_bits_size, 1'h1} : 4'h0} << {125'h0, io_in_c_bits_source, 2'h0};
  always @(posedge clock) begin
    if (_GEN_82) begin
      assert__assert_2: assert(_GEN_5);
      assert__assert_3: assert(_GEN_6);
      assert__assert_4: assert(_source_ok_WIRE_0);
      assert__assert_5: assert(_mask_T);
      assert__assert_6: assert(~(|_GEN_0));
      assert__assert_7: assert(_GEN_7);
      assert__assert_8: assert(~_GEN_8);
      assert__assert_9: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_83) begin
      assert__assert_10: assert(_GEN_5);
      assert__assert_11: assert(_GEN_6);
      assert__assert_12: assert(_source_ok_WIRE_0);
      assert__assert_13: assert(_mask_T);
      assert__assert_14: assert(~(|_GEN_0));
      assert__assert_15: assert(_GEN_7);
      assert__assert_16: assert(|io_in_a_bits_param);
      assert__assert_17: assert(~_GEN_8);
      assert__assert_18: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_84) begin
      assert__assert_19: assert(_GEN_2);
      assert__assert_20: assert(_GEN_4);
      assert__assert_21: assert(_source_ok_WIRE_0);
      assert__assert_22: assert(~(|_GEN_0));
      assert__assert_23: assert(~(|io_in_a_bits_param));
      assert__assert_24: assert(_GEN_10);
      assert__assert_25: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_85) begin
      assert__assert_26: assert(_GEN_5);
      assert__assert_27: assert(_source_ok_WIRE_0);
      assert__assert_28: assert(~(|_GEN_0));
      assert__assert_29: assert(~(|io_in_a_bits_param));
      assert__assert_30: assert(_GEN_10);
    end
    if (_GEN_86) begin
      assert__assert_31: assert(_GEN_5);
      assert__assert_32: assert(_source_ok_WIRE_0);
      assert__assert_33: assert(~(|_GEN_0));
      assert__assert_34: assert(~(|io_in_a_bits_param));
      assert__assert_35: assert(~(|_GEN_11));
    end
    if (_GEN_87) begin
      assert__assert_36: assert(1'h0);
      assert__assert_37: assert(_source_ok_WIRE_0);
      assert__assert_38: assert(~(|_GEN_0));
      assert__assert_39: assert(_GEN_13);
      assert__assert_40: assert(_GEN_10);
    end
    if (_GEN_88) begin
      assert__assert_41: assert(1'h0);
      assert__assert_42: assert(_source_ok_WIRE_0);
      assert__assert_43: assert(~(|_GEN_0));
      assert__assert_44: assert(~(io_in_a_bits_param[2]));
      assert__assert_45: assert(_GEN_10);
    end
    if (_GEN_89) begin
      assert__assert_46: assert(1'h0);
      assert__assert_47: assert(_source_ok_WIRE_0);
      assert__assert_48: assert(~(|_GEN_0));
      assert__assert_49: assert(_GEN_16);
      assert__assert_50: assert(_GEN_10);
      assert__assert_51: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_90)
      assert__assert_52: assert(_GEN_17);
    if (_GEN_91) begin
      assert__assert_53: assert(_source_ok_WIRE_1_0);
      assert__assert_54: assert(_GEN_18);
      assert__assert_55: assert(~(|io_in_d_bits_param));
      assert__assert_56: assert(~io_in_d_bits_corrupt);
      assert__assert_57: assert(~io_in_d_bits_denied);
    end
    if (_GEN_92) begin
      assert__assert_58: assert(_source_ok_WIRE_1_0);
      assert__assert_60: assert(_GEN_18);
      assert__assert_61: assert(_GEN_19);
      assert__assert_62: assert(_GEN_20);
      assert__assert_63: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_93) begin
      assert__assert_65: assert(_source_ok_WIRE_1_0);
      assert__assert_67: assert(_GEN_18);
      assert__assert_68: assert(_GEN_19);
      assert__assert_69: assert(_GEN_20);
      assert__assert_70: assert(_GEN_21);
    end
    if (_GEN_94) begin
      assert__assert_72: assert(_source_ok_WIRE_1_0);
      assert__assert_73: assert(~(|io_in_d_bits_param));
      assert__assert_74: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_95) begin
      assert__assert_76: assert(_source_ok_WIRE_1_0);
      assert__assert_77: assert(~(|io_in_d_bits_param));
      assert__assert_78: assert(_GEN_21);
    end
    if (_GEN_96) begin
      assert__assert_80: assert(_source_ok_WIRE_1_0);
      assert__assert_81: assert(~(|io_in_d_bits_param));
      assert__assert_82: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_97) begin
      assert__assert_132: assert(~_GEN_24);
      assert__assert_133: assert(_source_ok_WIRE_2_0);
      assert__assert_134: assert(_GEN_25);
      assert__assert_135: assert(~(|_GEN_23));
      assert__assert_136: assert(_GEN_26);
      assert__assert_137: assert(~io_in_c_bits_corrupt);
    end
    if (_GEN_98) begin
      assert__assert_138: assert(~_GEN_24);
      assert__assert_139: assert(_source_ok_WIRE_2_0);
      assert__assert_140: assert(_GEN_25);
      assert__assert_141: assert(~(|_GEN_23));
      assert__assert_142: assert(_GEN_26);
    end
    if (_GEN_99) begin
      assert__assert_143: assert(_GEN_27);
      assert__assert_144: assert(_GEN_28);
      assert__assert_145: assert(_source_ok_WIRE_2_0);
      assert__assert_146: assert(_GEN_25);
      assert__assert_147: assert(~(|_GEN_23));
      assert__assert_148: assert(_GEN_26);
      assert__assert_149: assert(~io_in_c_bits_corrupt);
    end
    if (_GEN_100) begin
      assert__assert_150: assert(_GEN_27);
      assert__assert_151: assert(_GEN_28);
      assert__assert_152: assert(_source_ok_WIRE_2_0);
      assert__assert_153: assert(_GEN_25);
      assert__assert_154: assert(~(|_GEN_23));
      assert__assert_155: assert(_GEN_26);
    end
    if (_GEN_101) begin
      assert__assert_156: assert(~_GEN_24);
      assert__assert_157: assert(_source_ok_WIRE_2_0);
      assert__assert_158: assert(~(|_GEN_23));
      assert__assert_159: assert(~(|io_in_c_bits_param));
      assert__assert_160: assert(~io_in_c_bits_corrupt);
    end
    if (_GEN_102) begin
      assert__assert_161: assert(~_GEN_24);
      assert__assert_162: assert(_source_ok_WIRE_2_0);
      assert__assert_163: assert(~(|_GEN_23));
      assert__assert_164: assert(~(|io_in_c_bits_param));
    end
    if (_GEN_103) begin
      assert__assert_165: assert(~_GEN_24);
      assert__assert_166: assert(_source_ok_WIRE_2_0);
      assert__assert_167: assert(~(|_GEN_23));
      assert__assert_168: assert(~(|io_in_c_bits_param));
      assert__assert_169: assert(~io_in_c_bits_corrupt);
    end
    if (_GEN_104) begin
      assert__assert_171: assert(_GEN_29);
      assert__assert_172: assert(_GEN_30);
      assert__assert_173: assert(_GEN_31);
      assert__assert_174: assert(_GEN_32);
      assert__assert_175: assert(_GEN_33);
    end
    if (_GEN_105) begin
      assert__assert_176: assert(_GEN_34);
      assert__assert_177: assert(_GEN_35);
      assert__assert_178: assert(_GEN_36);
      assert__assert_179: assert(_GEN_37);
      assert__assert_180: assert(_GEN_38);
      assert__assert_181: assert(_GEN_39);
    end
    if (_GEN_106) begin
      assert__assert_187: assert(_GEN_40);
      assert__assert_188: assert(_GEN_41);
      assert__assert_189: assert(_GEN_42);
      assert__assert_190: assert(_GEN_43);
      assert__assert_191: assert(_GEN_44);
    end
    if (_GEN_107)
      assert__assert_192: assert(~(_GEN_47[0]));
    if (_GEN_108)
      assert__assert_193: assert(_GEN_52);
    if (_GEN_109) begin
      assert__assert_194: assert(_GEN_54);
      assert__assert_195: assert(_GEN_55);
    end
    if (_GEN_110) begin
      assert__assert_196: assert(_GEN_59);
      assert__assert_197: assert(_GEN_60);
    end
    if (_GEN_111)
      assert__assert_198: assert(_GEN_61);
    if (~reset) begin
      assert__assert_199: assert(_GEN_62);
      assert__assert_200: assert(_GEN_63);
    end
    if (_GEN_112)
      assert__assert_201: assert(~(_GEN_66[0]));
    if (_GEN_113)
      assert__assert_202: assert(_GEN_70);
    if (_GEN_114)
      assert__assert_203: assert(_GEN_71);
    if (_GEN_115)
      assert__assert_204: assert(_GEN_73);
    if (_GEN_116)
      assert__assert_205: assert(_GEN_74);
    if (_GEN_117)
      assert__assert_206: assert(_GEN_75);
    if (~reset)
      assert__assert_207: assert(_GEN_76);
    if (_GEN_118)
      assert__assert_208: assert(~(_GEN_79[0]));
    if (_GEN_119)
      assert__assert_209: assert(_GEN_81[0]);
    if (reset) begin
      a_first_counter <= 3'h0;
      d_first_counter <= 3'h0;
      c_first_counter <= 3'h0;
      inflight <= 10'h0;
      inflight_opcodes <= 40'h0;
      inflight_sizes <= 40'h0;
      a_first_counter_1 <= 3'h0;
      d_first_counter_1 <= 3'h0;
      watchdog <= 32'h0;
      inflight_1 <= 10'h0;
      inflight_sizes_1 <= 40'h0;
      c_first_counter_1 <= 3'h0;
      d_first_counter_2 <= 3'h0;
      watchdog_1 <= 32'h0;
      inflight_2 <= 8'h0;
      d_first_counter_3 <= 3'h0;
    end
    else begin
      if (_a_first_T_1) begin
        if (|a_first_counter)
          a_first_counter <= a_first_counter - 3'h1;
        else if (io_in_a_bits_opcode[2])
          a_first_counter <= 3'h0;
        else
          a_first_counter <= ~(_a_first_beats1_decode_T_1[5:3]);
        if (a_first_1) begin
          if (io_in_a_bits_opcode[2])
            a_first_counter_1 <= 3'h0;
          else
            a_first_counter_1 <= ~(_a_first_beats1_decode_T_5[5:3]);
        end
        else
          a_first_counter_1 <= a_first_counter_1 - 3'h1;
      end
      if (_d_first_T_3) begin
        if (|d_first_counter)
          d_first_counter <= d_first_counter - 3'h1;
        else if (io_in_d_bits_opcode[0])
          d_first_counter <= ~(_d_first_beats1_decode_T_1[5:3]);
        else
          d_first_counter <= 3'h0;
        if (d_first_1) begin
          if (io_in_d_bits_opcode[0])
            d_first_counter_1 <= ~(_d_first_beats1_decode_T_5[5:3]);
          else
            d_first_counter_1 <= 3'h0;
        end
        else
          d_first_counter_1 <= d_first_counter_1 - 3'h1;
        if (d_first_2) begin
          if (io_in_d_bits_opcode[0])
            d_first_counter_2 <= ~(_d_first_beats1_decode_T_9[5:3]);
          else
            d_first_counter_2 <= 3'h0;
        end
        else
          d_first_counter_2 <= d_first_counter_2 - 3'h1;
        if (d_first_3) begin
          if (io_in_d_bits_opcode[0])
            d_first_counter_3 <= ~(_d_first_beats1_decode_T_13[5:3]);
          else
            d_first_counter_3 <= 3'h0;
        end
        else
          d_first_counter_3 <= d_first_counter_3 - 3'h1;
      end
      if (_c_first_T_1) begin
        if (|c_first_counter)
          c_first_counter <= c_first_counter - 3'h1;
        else if (io_in_c_bits_opcode[0])
          c_first_counter <= ~(_c_first_beats1_decode_T_1[5:3]);
        else
          c_first_counter <= 3'h0;
        if (c_first_1) begin
          if (io_in_c_bits_opcode[0])
            c_first_counter_1 <= ~(_c_first_beats1_decode_T_5[5:3]);
          else
            c_first_counter_1 <= 3'h0;
        end
        else
          c_first_counter_1 <= c_first_counter_1 - 3'h1;
      end
      inflight <= (inflight | (_GEN_46 ? _a_set_T[9:0] : 10'h0)) & ~(_GEN_122 ? _d_clr_T_1[9:0] : 10'h0);
      inflight_opcodes <= (inflight_opcodes | (_GEN_46 ? _a_opcodes_set_T_1[39:0] : 40'h0)) & ~(_GEN_122 ? _d_opcodes_clr_T_5[39:0] : 40'h0);
      inflight_sizes <= (inflight_sizes | (_GEN_46 ? _a_sizes_set_T_1[39:0] : 40'h0)) & ~(_GEN_122 ? _d_sizes_clr_T_5[39:0] : 40'h0);
      if (_a_first_T_1 | _d_first_T_3)
        watchdog <= 32'h0;
      else
        watchdog <= watchdog + 32'h1;
      inflight_1 <= (inflight_1 | (_GEN_65 ? _c_set_T[9:0] : 10'h0)) & ~(_GEN_124 ? _d_clr_T_1[9:0] : 10'h0);
      inflight_sizes_1 <= (inflight_sizes_1 | (_GEN_65 ? _c_sizes_set_T_1[39:0] : 40'h0)) & ~(_GEN_124 ? _d_sizes_clr_T_11[39:0] : 40'h0);
      if (_c_first_T_1 | _d_first_T_3)
        watchdog_1 <= 32'h0;
      else
        watchdog_1 <= watchdog_1 + 32'h1;
      inflight_2 <= (inflight_2 | d_set) & ~(io_in_e_valid ? 8'h1 << _GEN_80 : 8'h0);
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

