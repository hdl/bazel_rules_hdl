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
module TLMonitor_19_assert(
  input [28:0] io_in_a_bits_address,
  input [3:0]  io_in_a_bits_size,
  input [6:0]  io_in_a_bits_source,
  input [2:0]  io_in_a_bits_param,
  input [7:0]  io_in_a_bits_mask,
  input        io_in_a_bits_corrupt,
  input [2:0]  io_in_d_bits_opcode,
  input [6:0]  io_in_d_bits_source,
  input [3:0]  io_in_d_bits_size,
  input [1:0]  io_in_d_bits_param,
  input        io_in_d_bits_corrupt,
               io_in_d_bits_denied,
  input [2:0]  io_in_a_bits_opcode,
  input        clock,
               reset,
               io_in_a_ready,
               io_in_a_valid,
               io_in_d_ready,
               io_in_d_valid,
               io_in_d_bits_sink
);

  wire [31:0]   _plusarg_reader_1_out;
  wire [31:0]   _plusarg_reader_out;
  wire          _source_ok_WIRE__2 = io_in_a_bits_source == 7'h9;
  wire          _source_ok_WIRE__3 = io_in_a_bits_source == 7'h10;
  wire          _source_ok_WIRE__4 = io_in_a_bits_source == 7'h40;
  wire          source_ok = io_in_a_bits_source[6:4] == 3'h2 | ~(|(io_in_a_bits_source[6:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2 | _source_ok_WIRE__3 | _source_ok_WIRE__4;
  wire [26:0]   _GEN = {23'h0, io_in_a_bits_size};
  wire [26:0]   _is_aligned_mask_T_1 = 27'hFFF << _GEN;
  wire [11:0]   _GEN_0 = io_in_a_bits_address[11:0] & ~(_is_aligned_mask_T_1[11:0]);
  wire          _mask_T = io_in_a_bits_size > 4'h2;
  wire          mask_size = io_in_a_bits_size[1:0] == 2'h2;
  wire          mask_acc = _mask_T | mask_size & ~(io_in_a_bits_address[2]);
  wire          mask_acc_1 = _mask_T | mask_size & io_in_a_bits_address[2];
  wire          mask_size_1 = io_in_a_bits_size[1:0] == 2'h1;
  wire          mask_eq_2 = ~(io_in_a_bits_address[2]) & ~(io_in_a_bits_address[1]);
  wire          mask_acc_2 = mask_acc | mask_size_1 & mask_eq_2;
  wire          mask_eq_3 = ~(io_in_a_bits_address[2]) & io_in_a_bits_address[1];
  wire          mask_acc_3 = mask_acc | mask_size_1 & mask_eq_3;
  wire          mask_eq_4 = io_in_a_bits_address[2] & ~(io_in_a_bits_address[1]);
  wire          mask_acc_4 = mask_acc_1 | mask_size_1 & mask_eq_4;
  wire          mask_eq_5 = io_in_a_bits_address[2] & io_in_a_bits_address[1];
  wire          mask_acc_5 = mask_acc_1 | mask_size_1 & mask_eq_5;
  wire [7:0]    mask = {mask_acc_5 | mask_eq_5 & io_in_a_bits_address[0], mask_acc_5 | mask_eq_5 & ~(io_in_a_bits_address[0]), mask_acc_4 | mask_eq_4 & io_in_a_bits_address[0], mask_acc_4 | mask_eq_4 & ~(io_in_a_bits_address[0]), mask_acc_3 | mask_eq_3 & io_in_a_bits_address[0], mask_acc_3 | mask_eq_3 & ~(io_in_a_bits_address[0]), mask_acc_2 | mask_eq_2 & io_in_a_bits_address[0], mask_acc_2 | mask_eq_2 & ~(io_in_a_bits_address[0])};
  wire          _GEN_1 = io_in_a_bits_opcode == 3'h6;
  wire          _GEN_2 = io_in_a_bits_size < 4'hD;
  wire          _GEN_3 = io_in_a_bits_size == 4'h6;
  wire          _GEN_4 = {io_in_a_bits_address[28:15], io_in_a_bits_address[13:12]} == 16'h0;
  wire          _GEN_5 = {io_in_a_bits_address[28:14], ~(io_in_a_bits_address[13:12])} == 17'h0;
  wire          _GEN_6 = {io_in_a_bits_address[28:17], ~(io_in_a_bits_address[16])} == 13'h0;
  wire          _GEN_7 = {io_in_a_bits_address[28:21], io_in_a_bits_address[20:17] ^ 4'h8, io_in_a_bits_address[15:12]} == 16'h0;
  wire          _GEN_8 = {io_in_a_bits_address[28:26], io_in_a_bits_address[25:16] ^ 10'h200} == 13'h0;
  wire          _GEN_9 = {io_in_a_bits_address[28:26], io_in_a_bits_address[25:12] ^ 14'h2010} == 17'h0;
  wire          _GEN_10 = {io_in_a_bits_address[28], ~(io_in_a_bits_address[27:26])} == 3'h0;
  wire          _GEN_11 = io_in_a_bits_address[28:12] == 17'h10020;
  wire          _GEN_12 = _GEN_2 & (_GEN_4 | _GEN_5 | _GEN_6 | _GEN_7 | _GEN_8 | _GEN_9 | _GEN_10 | _GEN_11);
  wire          _GEN_13 = ~(|(io_in_a_bits_source[6:4])) & io_in_a_bits_source[3:0] < 4'h9 & _GEN_3 & _GEN_12;
  wire          _GEN_14 = io_in_a_bits_param < 3'h3;
  wire          _GEN_15 = io_in_a_bits_mask != 8'hFF;
  wire          _GEN_16 = ~(|(io_in_a_bits_source[6:4])) & io_in_a_bits_source[3:0] < 4'h9 & _GEN_3 & _GEN_12;
  wire          _GEN_17 = io_in_a_bits_opcode == 3'h4;
  wire          _GEN_18 = io_in_a_bits_source[6:4] == 3'h2;
  wire          _GEN_19 = _GEN_2 & (_GEN_18 | ~(|(io_in_a_bits_source[6:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2 | _source_ok_WIRE__3 | _source_ok_WIRE__4);
  wire          _GEN_20 = _GEN_2 & _GEN_5;
  wire          _GEN_21 = io_in_a_bits_size < 4'h7;
  wire          _GEN_22 = _GEN_20 | _GEN_21 & (_GEN_4 | _GEN_6 | _GEN_7 | _GEN_8 | _GEN_9 | _GEN_10 | _GEN_11);
  wire          _GEN_23 = io_in_a_bits_mask == mask;
  wire          _GEN_24 = _GEN_20 | _GEN_21 & (_GEN_4 | _GEN_7 | _GEN_8 | _GEN_9 | _GEN_10 | _GEN_11);
  wire          _GEN_25 = _GEN_2 & (_GEN_18 | ~(|(io_in_a_bits_source[6:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2 | _source_ok_WIRE__3 | _source_ok_WIRE__4) & _GEN_24;
  wire          _GEN_26 = _GEN_2 & (_GEN_18 | ~(|(io_in_a_bits_source[6:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2 | _source_ok_WIRE__3 | _source_ok_WIRE__4) & _GEN_24;
  wire [7:0]    _GEN_27 = io_in_a_bits_mask & ~mask;
  wire          _GEN_28 = io_in_a_bits_opcode == 3'h2;
  wire          _GEN_29 = io_in_a_bits_size < 4'h4 & (_GEN_5 | {io_in_a_bits_address[28:15], io_in_a_bits_address[14:12] ^ 3'h4} == 17'h0 | _GEN_11);
  wire          _GEN_30 = _GEN_2 & (_GEN_18 | ~(|(io_in_a_bits_source[6:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2 | _source_ok_WIRE__3 | _source_ok_WIRE__4) & _GEN_29;
  wire          _GEN_31 = io_in_a_bits_param < 3'h5;
  wire          _GEN_32 = io_in_a_bits_opcode == 3'h3;
  wire          _GEN_33 = _GEN_2 & (_GEN_18 | ~(|(io_in_a_bits_source[6:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2 | _source_ok_WIRE__3 | _source_ok_WIRE__4) & _GEN_29;
  wire          _GEN_34 = io_in_a_bits_opcode == 3'h5;
  wire          _GEN_35 = _GEN_2 & (_GEN_18 | ~(|(io_in_a_bits_source[6:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2 | _source_ok_WIRE__3 | _source_ok_WIRE__4) & _GEN_20;
  wire          _GEN_36 = io_in_a_bits_param < 3'h2;
  wire          _GEN_37 = io_in_d_bits_opcode != 3'h7;
  wire          source_ok_1 = io_in_d_bits_source[6:4] == 3'h2 | io_in_d_bits_source[6:4] == 3'h0 & io_in_d_bits_source[3:0] < 4'h9 | io_in_d_bits_source == 7'h9 | io_in_d_bits_source == 7'h10 | io_in_d_bits_source == 7'h40;
  wire          d_release_ack = io_in_d_bits_opcode == 3'h6;
  wire          _GEN_38 = io_in_d_bits_size > 4'h2;
  wire          _GEN_39 = io_in_d_bits_param != 2'h3;
  wire          _GEN_40 = io_in_d_bits_param != 2'h2;
  wire          _GEN_41 = ~io_in_d_bits_denied | io_in_d_bits_corrupt;
  wire          _a_first_T_1 = io_in_a_ready & io_in_a_valid;
  reg  [8:0]    a_first_counter;
  reg  [2:0]    opcode;
  reg  [2:0]    param;
  reg  [3:0]    size;
  reg  [6:0]    source;
  reg  [28:0]   address;
  wire          _GEN_42 = io_in_a_bits_opcode == opcode;
  wire          _GEN_43 = io_in_a_bits_param == param;
  wire          _GEN_44 = io_in_a_bits_size == size;
  wire          _GEN_45 = io_in_a_bits_source == source;
  wire          _GEN_46 = io_in_a_bits_address == address;
  reg  [8:0]    d_first_counter;
  reg  [2:0]    opcode_1;
  reg  [1:0]    param_1;
  reg  [3:0]    size_1;
  reg  [6:0]    source_1;
  reg           sink;
  reg           denied;
  wire          _GEN_47 = io_in_d_bits_opcode == opcode_1;
  wire          _GEN_48 = io_in_d_bits_param == param_1;
  wire          _GEN_49 = io_in_d_bits_size == size_1;
  wire          _GEN_50 = io_in_d_bits_source == source_1;
  wire          _GEN_51 = io_in_d_bits_sink == sink;
  wire          _GEN_52 = io_in_d_bits_denied == denied;
  reg  [64:0]   inflight;
  reg  [259:0]  inflight_opcodes;
  reg  [519:0]  inflight_sizes;
  reg  [8:0]    a_first_counter_1;
  wire          a_first_1 = a_first_counter_1 == 9'h0;
  reg  [8:0]    d_first_counter_1;
  wire          d_first_1 = d_first_counter_1 == 9'h0;
  wire [259:0]  _a_opcode_lookup_T_1 = inflight_opcodes >> {251'h0, io_in_d_bits_source, 2'h0};
  wire [519:0]  _GEN_53 = {510'h0, io_in_d_bits_source, 3'h0};
  wire [519:0]  _a_size_lookup_T_1 = inflight_sizes >> _GEN_53;
  wire          _GEN_54 = _a_first_T_1 & a_first_1;
  wire [64:0]   _GEN_55 = inflight >> io_in_a_bits_source;
  wire          _GEN_56 = io_in_d_valid & d_first_1;
  wire          _GEN_57 = _GEN_56 & ~d_release_ack;
  wire          _same_cycle_resp_T_2 = io_in_a_bits_source == io_in_d_bits_source;
  wire          same_cycle_resp = io_in_a_valid & a_first_1 & _same_cycle_resp_T_2;
  wire [64:0]   _GEN_58 = {58'h0, io_in_d_bits_source};
  wire [64:0]   _GEN_59 = inflight >> _GEN_58;
  wire          _GEN_60 = _GEN_59[0] | same_cycle_resp;
  wire          _GEN_61 = _GEN_17 | _GEN_32 | _GEN_28;
  wire          _GEN_62 = io_in_d_bits_opcode == ((&io_in_a_bits_opcode) | _GEN_1 ? 3'h4 : _GEN_34 ? 3'h2 : {2'h0, _GEN_61}) | io_in_d_bits_opcode == ((&io_in_a_bits_opcode) ? 3'h4 : _GEN_1 ? 3'h5 : _GEN_34 ? 3'h2 : {2'h0, _GEN_61});
  wire          _GEN_63 = io_in_a_bits_size == io_in_d_bits_size;
  wire          _GEN_64 = _a_opcode_lookup_T_1[3:1] == 3'h4 | _a_opcode_lookup_T_1[3:1] == 3'h3 | _a_opcode_lookup_T_1[3:1] == 3'h2;
  wire          _GEN_65 = _a_opcode_lookup_T_1[3:1] == 3'h5;
  wire          _GEN_66 = _a_opcode_lookup_T_1[3:1] == 3'h6;
  wire          _GEN_67 = io_in_d_bits_opcode == ((&(_a_opcode_lookup_T_1[3:1])) | _GEN_66 ? 3'h4 : _GEN_65 ? 3'h2 : {2'h0, _GEN_64}) | io_in_d_bits_opcode == ((&(_a_opcode_lookup_T_1[3:1])) ? 3'h4 : _GEN_66 ? 3'h5 : _GEN_65 ? 3'h2 : {2'h0, _GEN_64});
  wire [7:0]    _GEN_68 = {4'h0, io_in_d_bits_size};
  wire          _GEN_69 = _GEN_68 == {1'h0, _a_size_lookup_T_1[7:1]};
  wire          _GEN_70 = ~io_in_d_ready | io_in_a_ready;
  reg  [31:0]   watchdog;
  wire          _GEN_71 = inflight == 65'h0 | _plusarg_reader_out == 32'h0 | watchdog < _plusarg_reader_out;
  reg  [64:0]   inflight_1;
  reg  [519:0]  inflight_sizes_1;
  reg  [8:0]    d_first_counter_2;
  wire          d_first_2 = d_first_counter_2 == 9'h0;
  wire [519:0]  _c_size_lookup_T_1 = inflight_sizes_1 >> _GEN_53;
  wire [64:0]   _GEN_72 = inflight_1 >> _GEN_58;
  wire          _GEN_73 = _GEN_68 == {1'h0, _c_size_lookup_T_1[7:1]};
  reg  [31:0]   watchdog_1;
  wire          _GEN_74 = inflight_1 == 65'h0 | _plusarg_reader_1_out == 32'h0 | watchdog_1 < _plusarg_reader_1_out;
  wire          _GEN_75 = io_in_a_valid & _GEN_1 & ~reset;
  wire          _GEN_76 = io_in_a_valid & (&io_in_a_bits_opcode) & ~reset;
  wire          _GEN_77 = io_in_a_valid & _GEN_17 & ~reset;
  wire          _GEN_78 = io_in_a_valid & io_in_a_bits_opcode == 3'h0 & ~reset;
  wire          _GEN_79 = io_in_a_valid & io_in_a_bits_opcode == 3'h1 & ~reset;
  wire          _GEN_80 = io_in_a_valid & _GEN_28 & ~reset;
  wire          _GEN_81 = io_in_a_valid & _GEN_32 & ~reset;
  wire          _GEN_82 = io_in_a_valid & _GEN_34 & ~reset;
  wire          _GEN_83 = io_in_d_valid & ~reset;
  wire          _GEN_84 = io_in_d_valid & d_release_ack & ~reset;
  wire          _GEN_85 = io_in_d_valid & io_in_d_bits_opcode == 3'h4 & ~reset;
  wire          _GEN_86 = io_in_d_valid & io_in_d_bits_opcode == 3'h5 & ~reset;
  wire          _GEN_87 = io_in_d_valid & io_in_d_bits_opcode == 3'h0 & ~reset;
  wire          _GEN_88 = io_in_d_valid & io_in_d_bits_opcode == 3'h1 & ~reset;
  wire          _GEN_89 = io_in_d_valid & io_in_d_bits_opcode == 3'h2 & ~reset;
  wire          _GEN_90 = io_in_a_valid & (|a_first_counter) & ~reset;
  wire          _GEN_91 = io_in_d_valid & (|d_first_counter) & ~reset;
  wire          _GEN_92 = _GEN_54 & ~reset;
  wire          _GEN_93 = _GEN_57 & ~reset;
  wire          _GEN_94 = _GEN_57 & same_cycle_resp & ~reset;
  wire          _GEN_95 = _GEN_57 & ~same_cycle_resp & ~reset;
  wire          _GEN_96 = _GEN_56 & a_first_1 & io_in_a_valid & _same_cycle_resp_T_2 & ~d_release_ack & ~reset;
  wire          _GEN_97 = io_in_d_valid & d_first_2 & d_release_ack & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_75)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquireBlock type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_75 & ~_GEN_13)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquireBlock from a client which does not support Probe (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_75 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock carries invalid source ID (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_75 & ~_mask_T)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock smaller than a beat (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_75 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock address not aligned to size (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_75 & ~_GEN_14)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock carries invalid grow param (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_75 & _GEN_15)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock contains invalid mask (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_75 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock is corrupt (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_76)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquirePerm type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_76 & ~_GEN_16)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquirePerm from a client which does not support Probe (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_76 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm carries invalid source ID (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_76 & ~_mask_T)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm smaller than a beat (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_76 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm address not aligned to size (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_76 & ~_GEN_14)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm carries invalid grow param (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_76 & ~(|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm requests NtoB (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_76 & _GEN_15)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm contains invalid mask (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_76 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm is corrupt (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_77 & ~_GEN_19)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Get type which master claims it can't emit (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_77 & ~_GEN_22)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Get type which slave claims it can't support (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_77 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get carries invalid source ID (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_77 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get address not aligned to size (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_77 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get carries invalid param (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_77 & ~_GEN_23)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get contains invalid mask (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_77 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get is corrupt (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_78 & ~_GEN_25)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries PutFull type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_78 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull carries invalid source ID (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_78 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull address not aligned to size (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_78 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull carries invalid param (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_78 & ~_GEN_23)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull contains invalid mask (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_79 & ~_GEN_26)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries PutPartial type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_79 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial carries invalid source ID (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_79 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial address not aligned to size (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_79 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial carries invalid param (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_79 & (|_GEN_27))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial contains invalid mask (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_80 & ~_GEN_30)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Arithmetic type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_80 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic carries invalid source ID (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_80 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic address not aligned to size (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_80 & ~_GEN_31)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic carries invalid opcode param (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_80 & ~_GEN_23)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic contains invalid mask (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_81 & ~_GEN_33)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Logical type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_81 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical carries invalid source ID (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_81 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical address not aligned to size (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_81 & io_in_a_bits_param[2])
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical carries invalid opcode param (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_81 & ~_GEN_23)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical contains invalid mask (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_82 & ~_GEN_35)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Hint type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_82 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint carries invalid source ID (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_82 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint address not aligned to size (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_82 & ~_GEN_36)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint carries invalid opcode param (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_82 & ~_GEN_23)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint contains invalid mask (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_82 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint is corrupt (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_83 & ~_GEN_37)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel has invalid opcode (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_84 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck carries invalid source ID (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_84 & ~_GEN_38)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck smaller than a beat (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_84 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseeAck carries invalid param (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_84 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck is corrupt (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_84 & io_in_d_bits_denied)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck is denied (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_85 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid source ID (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_85)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid sink ID (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_85 & ~_GEN_38)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant smaller than a beat (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_85 & ~_GEN_39)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid cap param (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_85 & ~_GEN_40)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries toN param (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_85 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant is corrupt (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_86 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid source ID (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_86)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid sink ID (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_86 & ~_GEN_38)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData smaller than a beat (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_86 & ~_GEN_39)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid cap param (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_86 & ~_GEN_40)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries toN param (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_86 & ~_GEN_41)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData is denied but not corrupt (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_87 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck carries invalid source ID (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_87 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck carries invalid param (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_87 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck is corrupt (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_88 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData carries invalid source ID (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_88 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData carries invalid param (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_88 & ~_GEN_41)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData is denied but not corrupt (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_89 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck carries invalid source ID (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_89 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck carries invalid param (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_89 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck is corrupt (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_90 & ~_GEN_42)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel opcode changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_90 & ~_GEN_43)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel param changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_90 & ~_GEN_44)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel size changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_90 & ~_GEN_45)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel source changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_90 & ~_GEN_46)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel address changed with multibeat operation (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_91 & ~_GEN_47)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel opcode changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_91 & ~_GEN_48)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel param changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_91 & ~_GEN_49)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel size changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_91 & ~_GEN_50)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel source changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_91 & ~_GEN_51)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel sink changed with multibeat operation (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_91 & ~_GEN_52)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel denied changed with multibeat operation (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_92 & _GEN_55[0])
        $fwrite(32'h80000002, "Assertion failed: 'A' channel re-used a source ID (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_93 & ~_GEN_60)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_94 & ~_GEN_62)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_94 & ~_GEN_63)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_95 & ~_GEN_67)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_95 & ~_GEN_69)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_96 & ~_GEN_70)
        $fwrite(32'h80000002, "Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_71)
        $fwrite(32'h80000002, "Assertion failed: TileLink timeout expired (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_97 & ~(_GEN_72[0]))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_97 & ~_GEN_73)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_74)
        $fwrite(32'h80000002, "Assertion failed: TileLink timeout expired (connected at generators/rocket-chip/src/main/scala/subsystem/PeripheryBus.scala:53:7)\n    at Monitor.scala:42 assert(cond, message)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire [26:0]   _a_first_beats1_decode_T_1 = 27'hFFF << _GEN;
  wire [26:0]   _a_first_beats1_decode_T_5 = 27'hFFF << _GEN;
  wire [26:0]   _GEN_98 = {23'h0, io_in_d_bits_size};
  wire [26:0]   _d_first_beats1_decode_T_1 = 27'hFFF << _GEN_98;
  wire [26:0]   _d_first_beats1_decode_T_5 = 27'hFFF << _GEN_98;
  wire [26:0]   _d_first_beats1_decode_T_9 = 27'hFFF << _GEN_98;
  wire [1038:0] _GEN_99 = {1029'h0, io_in_d_bits_source, 3'h0};
  wire [127:0]  _d_clr_T_1 = 128'h1 << io_in_d_bits_source;
  wire [127:0]  _a_set_T = 128'h1 << io_in_a_bits_source;
  wire [1038:0] _d_opcodes_clr_T_5 = 1039'hF << {1030'h0, io_in_d_bits_source, 2'h0};
  wire [1026:0] _a_opcodes_set_T_1 = {1023'h0, _GEN_54 ? {io_in_a_bits_opcode, 1'h1} : 4'h0} << {1018'h0, io_in_a_bits_source, 2'h0};
  wire [1038:0] _d_sizes_clr_T_5 = 1039'hFF << _GEN_99;
  wire [1027:0] _a_sizes_set_T_1 = {1023'h0, _GEN_54 ? {io_in_a_bits_size, 1'h1} : 5'h0} << {1018'h0, io_in_a_bits_source, 3'h0};
  wire [1038:0] _d_sizes_clr_T_11 = 1039'hFF << _GEN_99;
  wire          _d_first_T_2 = io_in_d_ready & io_in_d_valid;
  wire          _GEN_100 = _d_first_T_2 & d_first_1 & ~d_release_ack;
  wire          _GEN_101 = _d_first_T_2 & d_first_2 & d_release_ack;
  always @(posedge clock) begin
    if (_GEN_75) begin
      assert__assert_2: assert(1'h0);
      assert__assert_3: assert(_GEN_13);
      assert__assert_4: assert(source_ok);
      assert__assert_5: assert(_mask_T);
      assert__assert_6: assert(~(|_GEN_0));
      assert__assert_7: assert(_GEN_14);
      assert__assert_8: assert(~_GEN_15);
      assert__assert_9: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_76) begin
      assert__assert_10: assert(1'h0);
      assert__assert_11: assert(_GEN_16);
      assert__assert_12: assert(source_ok);
      assert__assert_13: assert(_mask_T);
      assert__assert_14: assert(~(|_GEN_0));
      assert__assert_15: assert(_GEN_14);
      assert__assert_16: assert(|io_in_a_bits_param);
      assert__assert_17: assert(~_GEN_15);
      assert__assert_18: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_77) begin
      assert__assert_19: assert(_GEN_19);
      assert__assert_20: assert(_GEN_22);
      assert__assert_21: assert(source_ok);
      assert__assert_22: assert(~(|_GEN_0));
      assert__assert_23: assert(~(|io_in_a_bits_param));
      assert__assert_24: assert(_GEN_23);
      assert__assert_25: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_78) begin
      assert__assert_26: assert(_GEN_25);
      assert__assert_27: assert(source_ok);
      assert__assert_28: assert(~(|_GEN_0));
      assert__assert_29: assert(~(|io_in_a_bits_param));
      assert__assert_30: assert(_GEN_23);
    end
    if (_GEN_79) begin
      assert__assert_31: assert(_GEN_26);
      assert__assert_32: assert(source_ok);
      assert__assert_33: assert(~(|_GEN_0));
      assert__assert_34: assert(~(|io_in_a_bits_param));
      assert__assert_35: assert(~(|_GEN_27));
    end
    if (_GEN_80) begin
      assert__assert_36: assert(_GEN_30);
      assert__assert_37: assert(source_ok);
      assert__assert_38: assert(~(|_GEN_0));
      assert__assert_39: assert(_GEN_31);
      assert__assert_40: assert(_GEN_23);
    end
    if (_GEN_81) begin
      assert__assert_41: assert(_GEN_33);
      assert__assert_42: assert(source_ok);
      assert__assert_43: assert(~(|_GEN_0));
      assert__assert_44: assert(~(io_in_a_bits_param[2]));
      assert__assert_45: assert(_GEN_23);
    end
    if (_GEN_82) begin
      assert__assert_46: assert(_GEN_35);
      assert__assert_47: assert(source_ok);
      assert__assert_48: assert(~(|_GEN_0));
      assert__assert_49: assert(_GEN_36);
      assert__assert_50: assert(_GEN_23);
      assert__assert_51: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_83)
      assert__assert_52: assert(_GEN_37);
    if (_GEN_84) begin
      assert__assert_53: assert(source_ok_1);
      assert__assert_54: assert(_GEN_38);
      assert__assert_55: assert(~(|io_in_d_bits_param));
      assert__assert_56: assert(~io_in_d_bits_corrupt);
      assert__assert_57: assert(~io_in_d_bits_denied);
    end
    if (_GEN_85) begin
      assert__assert_58: assert(source_ok_1);
      assert__assert_59: assert(1'h0);
      assert__assert_60: assert(_GEN_38);
      assert__assert_61: assert(_GEN_39);
      assert__assert_62: assert(_GEN_40);
      assert__assert_63: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_86) begin
      assert__assert_65: assert(source_ok_1);
      assert__assert_66: assert(1'h0);
      assert__assert_67: assert(_GEN_38);
      assert__assert_68: assert(_GEN_39);
      assert__assert_69: assert(_GEN_40);
      assert__assert_70: assert(_GEN_41);
    end
    if (_GEN_87) begin
      assert__assert_72: assert(source_ok_1);
      assert__assert_73: assert(~(|io_in_d_bits_param));
      assert__assert_74: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_88) begin
      assert__assert_76: assert(source_ok_1);
      assert__assert_77: assert(~(|io_in_d_bits_param));
      assert__assert_78: assert(_GEN_41);
    end
    if (_GEN_89) begin
      assert__assert_80: assert(source_ok_1);
      assert__assert_81: assert(~(|io_in_d_bits_param));
      assert__assert_82: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_90) begin
      assert__assert_87: assert(_GEN_42);
      assert__assert_88: assert(_GEN_43);
      assert__assert_89: assert(_GEN_44);
      assert__assert_90: assert(_GEN_45);
      assert__assert_91: assert(_GEN_46);
    end
    if (_GEN_91) begin
      assert__assert_92: assert(_GEN_47);
      assert__assert_93: assert(_GEN_48);
      assert__assert_94: assert(_GEN_49);
      assert__assert_95: assert(_GEN_50);
      assert__assert_96: assert(_GEN_51);
      assert__assert_97: assert(_GEN_52);
    end
    if (_GEN_92)
      assert__assert_98: assert(~(_GEN_55[0]));
    if (_GEN_93)
      assert__assert_99: assert(_GEN_60);
    if (_GEN_94) begin
      assert__assert_100: assert(_GEN_62);
      assert__assert_101: assert(_GEN_63);
    end
    if (_GEN_95) begin
      assert__assert_102: assert(_GEN_67);
      assert__assert_103: assert(_GEN_69);
    end
    if (_GEN_96)
      assert__assert_104: assert(_GEN_70);
    if (~reset)
      assert__assert_105: assert(_GEN_71);
    if (_GEN_97) begin
      assert__assert_107: assert(_GEN_72[0]);
      assert__assert_109: assert(_GEN_73);
    end
    if (~reset)
      assert__assert_111: assert(_GEN_74);
    if (reset) begin
      a_first_counter <= 9'h0;
      d_first_counter <= 9'h0;
      inflight <= 65'h0;
      inflight_opcodes <= 260'h0;
      inflight_sizes <= 520'h0;
      a_first_counter_1 <= 9'h0;
      d_first_counter_1 <= 9'h0;
      watchdog <= 32'h0;
      inflight_1 <= 65'h0;
      inflight_sizes_1 <= 520'h0;
      d_first_counter_2 <= 9'h0;
      watchdog_1 <= 32'h0;
    end
    else begin
      if (_a_first_T_1) begin
        if (|a_first_counter)
          a_first_counter <= a_first_counter - 9'h1;
        else if (io_in_a_bits_opcode[2])
          a_first_counter <= 9'h0;
        else
          a_first_counter <= ~(_a_first_beats1_decode_T_1[11:3]);
        if (a_first_1) begin
          if (io_in_a_bits_opcode[2])
            a_first_counter_1 <= 9'h0;
          else
            a_first_counter_1 <= ~(_a_first_beats1_decode_T_5[11:3]);
        end
        else
          a_first_counter_1 <= a_first_counter_1 - 9'h1;
      end
      if (_d_first_T_2) begin
        if (|d_first_counter)
          d_first_counter <= d_first_counter - 9'h1;
        else if (io_in_d_bits_opcode[0])
          d_first_counter <= ~(_d_first_beats1_decode_T_1[11:3]);
        else
          d_first_counter <= 9'h0;
        if (d_first_1) begin
          if (io_in_d_bits_opcode[0])
            d_first_counter_1 <= ~(_d_first_beats1_decode_T_5[11:3]);
          else
            d_first_counter_1 <= 9'h0;
        end
        else
          d_first_counter_1 <= d_first_counter_1 - 9'h1;
        if (d_first_2) begin
          if (io_in_d_bits_opcode[0])
            d_first_counter_2 <= ~(_d_first_beats1_decode_T_9[11:3]);
          else
            d_first_counter_2 <= 9'h0;
        end
        else
          d_first_counter_2 <= d_first_counter_2 - 9'h1;
        watchdog_1 <= 32'h0;
      end
      else
        watchdog_1 <= watchdog_1 + 32'h1;
      inflight <= (inflight | (_GEN_54 ? _a_set_T[64:0] : 65'h0)) & ~(_GEN_100 ? _d_clr_T_1[64:0] : 65'h0);
      inflight_opcodes <= (inflight_opcodes | (_GEN_54 ? _a_opcodes_set_T_1[259:0] : 260'h0)) & ~(_GEN_100 ? _d_opcodes_clr_T_5[259:0] : 260'h0);
      inflight_sizes <= (inflight_sizes | (_GEN_54 ? _a_sizes_set_T_1[519:0] : 520'h0)) & ~(_GEN_100 ? _d_sizes_clr_T_5[519:0] : 520'h0);
      if (_a_first_T_1 | _d_first_T_2)
        watchdog <= 32'h0;
      else
        watchdog <= watchdog + 32'h1;
      inflight_1 <= inflight_1 & ~(_GEN_101 ? _d_clr_T_1[64:0] : 65'h0);
      inflight_sizes_1 <= inflight_sizes_1 & ~(_GEN_101 ? _d_sizes_clr_T_11[519:0] : 520'h0);
    end
    if (_a_first_T_1 & ~(|a_first_counter)) begin
      opcode <= io_in_a_bits_opcode;
      param <= io_in_a_bits_param;
      size <= io_in_a_bits_size;
      source <= io_in_a_bits_source;
      address <= io_in_a_bits_address;
    end
    if (_d_first_T_2 & ~(|d_first_counter)) begin
      opcode_1 <= io_in_d_bits_opcode;
      param_1 <= io_in_d_bits_param;
      size_1 <= io_in_d_bits_size;
      source_1 <= io_in_d_bits_source;
      sink <= io_in_d_bits_sink;
      denied <= io_in_d_bits_denied;
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

