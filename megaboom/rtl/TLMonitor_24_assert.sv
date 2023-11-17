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
module TLMonitor_24_assert(
  input [10:0] io_in_a_bits_source,
  input [1:0]  io_in_a_bits_size,
  input [25:0] io_in_a_bits_address,
  input [2:0]  io_in_a_bits_param,
  input [7:0]  io_in_a_bits_mask,
  input        io_in_a_bits_corrupt,
  input [2:0]  io_in_d_bits_opcode,
  input [10:0] io_in_d_bits_source,
  input [1:0]  io_in_d_bits_size,
               io_in_d_bits_param,
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

  wire [31:0]    _plusarg_reader_1_out;
  wire [31:0]    _plusarg_reader_out;
  wire           _source_ok_WIRE_0 = io_in_a_bits_source < 11'h410;
  wire [5:0]     _is_aligned_mask_T_1 = 6'h7 << io_in_a_bits_size;
  wire [2:0]     _GEN = io_in_a_bits_address[2:0] & ~(_is_aligned_mask_T_1[2:0]);
  wire           mask_size = io_in_a_bits_size == 2'h2;
  wire           mask_acc = (&io_in_a_bits_size) | mask_size & ~(io_in_a_bits_address[2]);
  wire           mask_acc_1 = (&io_in_a_bits_size) | mask_size & io_in_a_bits_address[2];
  wire           mask_size_1 = io_in_a_bits_size == 2'h1;
  wire           mask_eq_2 = ~(io_in_a_bits_address[2]) & ~(io_in_a_bits_address[1]);
  wire           mask_acc_2 = mask_acc | mask_size_1 & mask_eq_2;
  wire           mask_eq_3 = ~(io_in_a_bits_address[2]) & io_in_a_bits_address[1];
  wire           mask_acc_3 = mask_acc | mask_size_1 & mask_eq_3;
  wire           mask_eq_4 = io_in_a_bits_address[2] & ~(io_in_a_bits_address[1]);
  wire           mask_acc_4 = mask_acc_1 | mask_size_1 & mask_eq_4;
  wire           mask_eq_5 = io_in_a_bits_address[2] & io_in_a_bits_address[1];
  wire           mask_acc_5 = mask_acc_1 | mask_size_1 & mask_eq_5;
  wire [7:0]     mask = {mask_acc_5 | mask_eq_5 & io_in_a_bits_address[0], mask_acc_5 | mask_eq_5 & ~(io_in_a_bits_address[0]), mask_acc_4 | mask_eq_4 & io_in_a_bits_address[0], mask_acc_4 | mask_eq_4 & ~(io_in_a_bits_address[0]), mask_acc_3 | mask_eq_3 & io_in_a_bits_address[0], mask_acc_3 | mask_eq_3 & ~(io_in_a_bits_address[0]), mask_acc_2 | mask_eq_2 & io_in_a_bits_address[0], mask_acc_2 | mask_eq_2 & ~(io_in_a_bits_address[0])};
  wire           _GEN_0 = io_in_a_bits_opcode == 3'h6;
  wire           _GEN_1 = io_in_a_bits_param < 3'h3;
  wire           _GEN_2 = io_in_a_bits_mask != 8'hFF;
  wire           _GEN_3 = io_in_a_bits_opcode == 3'h4;
  wire           _GEN_4 = io_in_a_bits_source < 11'h410;
  wire           _GEN_5 = io_in_a_bits_address[25:12] != 14'h2010;
  wire           _GEN_6 = io_in_a_bits_mask == mask;
  wire           _GEN_7 = _GEN_4 & ~_GEN_5;
  wire [7:0]     _GEN_8 = io_in_a_bits_mask & ~mask;
  wire           _GEN_9 = io_in_a_bits_opcode == 3'h2;
  wire           _GEN_10 = io_in_a_bits_param < 3'h5;
  wire           _GEN_11 = io_in_a_bits_opcode == 3'h3;
  wire           _GEN_12 = io_in_a_bits_opcode == 3'h5;
  wire           _GEN_13 = io_in_a_bits_param < 3'h2;
  wire           _GEN_14 = io_in_d_bits_opcode != 3'h7;
  wire           _source_ok_WIRE_1_0 = io_in_d_bits_source < 11'h410;
  wire           d_release_ack = io_in_d_bits_opcode == 3'h6;
  wire           _GEN_15 = io_in_d_bits_param != 2'h3;
  wire           _GEN_16 = io_in_d_bits_param != 2'h2;
  wire           _GEN_17 = ~io_in_d_bits_denied | io_in_d_bits_corrupt;
  wire           a_first_done = io_in_a_ready & io_in_a_valid;
  reg            a_first_counter;
  reg  [2:0]     opcode;
  reg  [2:0]     param;
  reg  [1:0]     size;
  reg  [10:0]    source;
  reg  [25:0]    address;
  wire           _GEN_18 = io_in_a_bits_opcode == opcode;
  wire           _GEN_19 = io_in_a_bits_param == param;
  wire           _GEN_20 = io_in_a_bits_size == size;
  wire           _GEN_21 = io_in_a_bits_source == source;
  wire           _GEN_22 = io_in_a_bits_address == address;
  reg            d_first_counter;
  reg  [2:0]     opcode_1;
  reg  [1:0]     param_1;
  reg  [1:0]     size_1;
  reg  [10:0]    source_1;
  reg            sink;
  reg            denied;
  wire           _GEN_23 = io_in_d_bits_opcode == opcode_1;
  wire           _GEN_24 = io_in_d_bits_param == param_1;
  wire           _GEN_25 = io_in_d_bits_size == size_1;
  wire           _GEN_26 = io_in_d_bits_source == source_1;
  wire           _GEN_27 = io_in_d_bits_sink == sink;
  wire           _GEN_28 = io_in_d_bits_denied == denied;
  reg  [1039:0]  inflight;
  reg  [4159:0]  inflight_opcodes;
  reg  [4159:0]  inflight_sizes;
  reg            a_first_counter_1;
  reg            d_first_counter_1;
  wire [4159:0]  _GEN_29 = {4147'h0, io_in_d_bits_source, 2'h0};
  wire [4159:0]  _a_opcode_lookup_T_1 = inflight_opcodes >> _GEN_29;
  wire [4159:0]  _a_size_lookup_T_1 = inflight_sizes >> _GEN_29;
  wire           _same_cycle_resp_T_1 = io_in_a_valid & ~a_first_counter_1;
  wire [2047:0]  _a_set_T = 2048'h1 << io_in_a_bits_source;
  wire [1039:0]  _GEN_15_0 = _same_cycle_resp_T_1 ? _a_set_T[1039:0] : 1040'h0;
  wire           _GEN_30 = a_first_done & ~a_first_counter_1;
  wire [1039:0]  _GEN_31 = inflight >> io_in_a_bits_source;
  wire           _GEN_32 = io_in_d_valid & ~d_first_counter_1;
  wire           _GEN_33 = _GEN_32 & ~d_release_ack;
  wire [2047:0]  _d_clr_T_1 = 2048'h1 << io_in_d_bits_source;
  wire           _same_cycle_resp_T_2 = io_in_a_bits_source == io_in_d_bits_source;
  wire           same_cycle_resp = _same_cycle_resp_T_1 & _same_cycle_resp_T_2;
  wire [1039:0]  _GEN_34 = {1029'h0, io_in_d_bits_source};
  wire [1039:0]  _GEN_35 = inflight >> _GEN_34;
  wire           _GEN_36 = _GEN_35[0] | same_cycle_resp;
  wire           _GEN_37 = _GEN_3 | _GEN_11 | _GEN_9;
  wire           _GEN_38 = io_in_d_bits_opcode == ((&io_in_a_bits_opcode) | _GEN_0 ? 3'h4 : _GEN_12 ? 3'h2 : {2'h0, _GEN_37}) | io_in_d_bits_opcode == ((&io_in_a_bits_opcode) ? 3'h4 : _GEN_0 ? 3'h5 : _GEN_12 ? 3'h2 : {2'h0, _GEN_37});
  wire           _GEN_39 = io_in_a_bits_size == io_in_d_bits_size;
  wire           _GEN_40 = _a_opcode_lookup_T_1[3:1] == 3'h4 | _a_opcode_lookup_T_1[3:1] == 3'h3 | _a_opcode_lookup_T_1[3:1] == 3'h2;
  wire           _GEN_41 = _a_opcode_lookup_T_1[3:1] == 3'h5;
  wire           _GEN_42 = _a_opcode_lookup_T_1[3:1] == 3'h6;
  wire           _GEN_43 = io_in_d_bits_opcode == ((&(_a_opcode_lookup_T_1[3:1])) | _GEN_42 ? 3'h4 : _GEN_41 ? 3'h2 : {2'h0, _GEN_40}) | io_in_d_bits_opcode == ((&(_a_opcode_lookup_T_1[3:1])) ? 3'h4 : _GEN_42 ? 3'h5 : _GEN_41 ? 3'h2 : {2'h0, _GEN_40});
  wire [3:0]     _GEN_44 = {2'h0, io_in_d_bits_size};
  wire           _GEN_45 = _GEN_44 == {1'h0, _a_size_lookup_T_1[3:1]};
  wire           _GEN_46 = ~io_in_d_ready | io_in_a_ready;
  wire           _GEN_47 = _GEN_15_0 != (_GEN_33 ? _d_clr_T_1[1039:0] : 1040'h0) | _GEN_15_0 == 1040'h0;
  reg  [31:0]    watchdog;
  wire           _GEN_48 = inflight == 1040'h0 | _plusarg_reader_out == 32'h0 | watchdog < _plusarg_reader_out;
  reg  [1039:0]  inflight_1;
  reg  [4159:0]  inflight_sizes_1;
  reg            d_first_counter_2;
  wire [4159:0]  _c_size_lookup_T_1 = inflight_sizes_1 >> _GEN_29;
  wire [1039:0]  _GEN_49 = inflight_1 >> _GEN_34;
  wire           _GEN_50 = _GEN_44 == {1'h0, _c_size_lookup_T_1[3:1]};
  reg  [31:0]    watchdog_1;
  wire           _GEN_51 = inflight_1 == 1040'h0 | _plusarg_reader_1_out == 32'h0 | watchdog_1 < _plusarg_reader_1_out;
  wire           _GEN_52 = io_in_a_valid & _GEN_0 & ~reset;
  wire           _GEN_53 = io_in_a_valid & (&io_in_a_bits_opcode) & ~reset;
  wire           _GEN_54 = io_in_a_valid & _GEN_3 & ~reset;
  wire           _GEN_55 = io_in_a_valid & io_in_a_bits_opcode == 3'h0 & ~reset;
  wire           _GEN_56 = io_in_a_valid & io_in_a_bits_opcode == 3'h1 & ~reset;
  wire           _GEN_57 = io_in_a_valid & _GEN_9 & ~reset;
  wire           _GEN_58 = io_in_a_valid & _GEN_11 & ~reset;
  wire           _GEN_59 = io_in_a_valid & _GEN_12 & ~reset;
  wire           _GEN_60 = io_in_d_valid & ~reset;
  wire           _GEN_61 = io_in_d_valid & d_release_ack & ~reset;
  wire           _GEN_62 = io_in_d_valid & io_in_d_bits_opcode == 3'h4 & ~reset;
  wire           _GEN_63 = io_in_d_valid & io_in_d_bits_opcode == 3'h5 & ~reset;
  wire           _GEN_64 = io_in_d_valid & io_in_d_bits_opcode == 3'h0 & ~reset;
  wire           _GEN_65 = io_in_d_valid & io_in_d_bits_opcode == 3'h1 & ~reset;
  wire           _GEN_66 = io_in_d_valid & io_in_d_bits_opcode == 3'h2 & ~reset;
  wire           _GEN_67 = io_in_a_valid & a_first_counter & ~reset;
  wire           _GEN_68 = io_in_d_valid & d_first_counter & ~reset;
  wire           _GEN_69 = _GEN_30 & ~reset;
  wire           _GEN_70 = _GEN_33 & ~reset;
  wire           _GEN_71 = _GEN_33 & same_cycle_resp & ~reset;
  wire           _GEN_72 = _GEN_33 & ~same_cycle_resp & ~reset;
  wire           _GEN_73 = _GEN_32 & ~a_first_counter_1 & io_in_a_valid & _same_cycle_resp_T_2 & ~d_release_ack & ~reset;
  wire           _GEN_74 = io_in_d_valid & ~d_first_counter_2 & d_release_ack & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_52) begin
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquireBlock type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquireBlock from a client which does not support Probe (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      end
      if ((`PRINTF_COND_) & _GEN_52 & ~_source_ok_WIRE_0)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_52 & ~(&io_in_a_bits_size))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_52 & (|_GEN))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_52 & ~_GEN_1)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock carries invalid grow param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_52 & _GEN_2)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_52 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_53) begin
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquirePerm type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquirePerm from a client which does not support Probe (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      end
      if ((`PRINTF_COND_) & _GEN_53 & ~_source_ok_WIRE_0)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_53 & ~(&io_in_a_bits_size))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_53 & (|_GEN))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_53 & ~_GEN_1)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm carries invalid grow param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_53 & ~(|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm requests NtoB (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_53 & _GEN_2)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_53 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_54 & ~_GEN_4)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Get type which master claims it can't emit (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_54 & _GEN_5)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Get type which slave claims it can't support (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_54 & ~_source_ok_WIRE_0)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_54 & (|_GEN))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_54 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_54 & ~_GEN_6)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_54 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_55 & ~_GEN_7)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries PutFull type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_55 & ~_source_ok_WIRE_0)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_55 & (|_GEN))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_55 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_55 & ~_GEN_6)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_56 & ~_GEN_7)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries PutPartial type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_56 & ~_source_ok_WIRE_0)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_56 & (|_GEN))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_56 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_56 & (|_GEN_8))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_57)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Arithmetic type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_57 & ~_source_ok_WIRE_0)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_57 & (|_GEN))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_57 & ~_GEN_10)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic carries invalid opcode param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_57 & ~_GEN_6)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_58)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Logical type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_58 & ~_source_ok_WIRE_0)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_58 & (|_GEN))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_58 & io_in_a_bits_param[2])
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical carries invalid opcode param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_58 & ~_GEN_6)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_59)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Hint type which is unexpected using diplomatic parameters (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_59 & ~_source_ok_WIRE_0)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_59 & (|_GEN))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint address not aligned to size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_59 & ~_GEN_13)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint carries invalid opcode param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_59 & ~_GEN_6)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint contains invalid mask (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_59 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_60 & ~_GEN_14)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel has invalid opcode (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_61 & ~_source_ok_WIRE_1_0)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_61 & ~(&io_in_d_bits_size))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_61 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseeAck carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_61 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_61 & io_in_d_bits_denied)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck is denied (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_62 & ~_source_ok_WIRE_1_0)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_62)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid sink ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_62 & ~(&io_in_d_bits_size))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_62 & ~_GEN_15)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid cap param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_62 & ~_GEN_16)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries toN param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_62 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_62 & io_in_d_bits_denied)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant is denied (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_63 & ~_source_ok_WIRE_1_0)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_63)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid sink ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_63 & ~(&io_in_d_bits_size))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData smaller than a beat (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_63 & ~_GEN_15)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid cap param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_63 & ~_GEN_16)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries toN param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_63 & ~_GEN_17)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData is denied but not corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_63 & io_in_d_bits_denied)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData is denied (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_64 & ~_source_ok_WIRE_1_0)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_64 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_64 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_64 & io_in_d_bits_denied)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck is denied (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_65 & ~_source_ok_WIRE_1_0)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_65 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_65 & ~_GEN_17)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData is denied but not corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_65 & io_in_d_bits_denied)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData is denied (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_66 & ~_source_ok_WIRE_1_0)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck carries invalid source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_66 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck carries invalid param (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_66 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck is corrupt (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_66 & io_in_d_bits_denied)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck is denied (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_67 & ~_GEN_18)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel opcode changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_67 & ~_GEN_19)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel param changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_67 & ~_GEN_20)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel size changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_67 & ~_GEN_21)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel source changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_67 & ~_GEN_22)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel address changed with multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_68 & ~_GEN_23)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel opcode changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_68 & ~_GEN_24)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel param changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_68 & ~_GEN_25)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel size changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_68 & ~_GEN_26)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel source changed within multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_68 & ~_GEN_27)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel sink changed with multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_68 & ~_GEN_28)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel denied changed with multibeat operation (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_69 & _GEN_31[0])
        $fwrite(32'h80000002, "Assertion failed: 'A' channel re-used a source ID (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_70 & ~_GEN_36)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_71 & ~_GEN_38)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_71 & ~_GEN_39)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_72 & ~_GEN_43)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_72 & ~_GEN_45)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_73 & ~_GEN_46)
        $fwrite(32'h80000002, "Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_47)
        $fwrite(32'h80000002, "Assertion failed: 'A' and 'D' concurrent, despite minlatency 3 (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_48)
        $fwrite(32'h80000002, "Assertion failed: TileLink timeout expired (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_74 & ~(_GEN_49[0]))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_74 & ~_GEN_50)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_51)
        $fwrite(32'h80000002, "Assertion failed: TileLink timeout expired (connected at generators/sifive-cache/design/craft/inclusivecache/src/Configs.scala:142:60)\n    at Monitor.scala:42 assert(cond, message)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire [16398:0] _GEN_75 = {16386'h0, io_in_d_bits_source, 2'h0};
  wire [16398:0] _d_opcodes_clr_T_5 = 16399'hF << _GEN_75;
  wire [16386:0] _a_opcodes_set_T_1 = {16383'h0, _GEN_30 ? {io_in_a_bits_opcode, 1'h1} : 4'h0} << {16374'h0, io_in_a_bits_source, 2'h0};
  wire [16398:0] _d_sizes_clr_T_5 = 16399'hF << _GEN_75;
  wire [16385:0] _a_sizes_set_T_1 = {16383'h0, _GEN_30 ? {io_in_a_bits_size, 1'h1} : 3'h0} << {16373'h0, io_in_a_bits_source, 2'h0};
  wire [16398:0] _d_sizes_clr_T_11 = 16399'hF << _GEN_75;
  wire           d_first_done = io_in_d_ready & io_in_d_valid;
  wire           _GEN_76 = d_first_done & ~d_first_counter_1 & ~d_release_ack;
  wire           _GEN_77 = d_first_done & ~d_first_counter_2 & d_release_ack;
  always @(posedge clock) begin
    if (_GEN_52) begin
      assert__assert_2: assert(1'h0);
      assert__assert_3: assert(1'h0);
      assert__assert_4: assert(_source_ok_WIRE_0);
      assert__assert_5: assert(&io_in_a_bits_size);
      assert__assert_6: assert(~(|_GEN));
      assert__assert_7: assert(_GEN_1);
      assert__assert_8: assert(~_GEN_2);
      assert__assert_9: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_53) begin
      assert__assert_10: assert(1'h0);
      assert__assert_11: assert(1'h0);
      assert__assert_12: assert(_source_ok_WIRE_0);
      assert__assert_13: assert(&io_in_a_bits_size);
      assert__assert_14: assert(~(|_GEN));
      assert__assert_15: assert(_GEN_1);
      assert__assert_16: assert(|io_in_a_bits_param);
      assert__assert_17: assert(~_GEN_2);
      assert__assert_18: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_54) begin
      assert__assert_19: assert(_GEN_4);
      assert__assert_20: assert(~_GEN_5);
      assert__assert_21: assert(_source_ok_WIRE_0);
      assert__assert_22: assert(~(|_GEN));
      assert__assert_23: assert(~(|io_in_a_bits_param));
      assert__assert_24: assert(_GEN_6);
      assert__assert_25: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_55) begin
      assert__assert_26: assert(_GEN_7);
      assert__assert_27: assert(_source_ok_WIRE_0);
      assert__assert_28: assert(~(|_GEN));
      assert__assert_29: assert(~(|io_in_a_bits_param));
      assert__assert_30: assert(_GEN_6);
    end
    if (_GEN_56) begin
      assert__assert_31: assert(_GEN_7);
      assert__assert_32: assert(_source_ok_WIRE_0);
      assert__assert_33: assert(~(|_GEN));
      assert__assert_34: assert(~(|io_in_a_bits_param));
      assert__assert_35: assert(~(|_GEN_8));
    end
    if (_GEN_57) begin
      assert__assert_36: assert(1'h0);
      assert__assert_37: assert(_source_ok_WIRE_0);
      assert__assert_38: assert(~(|_GEN));
      assert__assert_39: assert(_GEN_10);
      assert__assert_40: assert(_GEN_6);
    end
    if (_GEN_58) begin
      assert__assert_41: assert(1'h0);
      assert__assert_42: assert(_source_ok_WIRE_0);
      assert__assert_43: assert(~(|_GEN));
      assert__assert_44: assert(~(io_in_a_bits_param[2]));
      assert__assert_45: assert(_GEN_6);
    end
    if (_GEN_59) begin
      assert__assert_46: assert(1'h0);
      assert__assert_47: assert(_source_ok_WIRE_0);
      assert__assert_48: assert(~(|_GEN));
      assert__assert_49: assert(_GEN_13);
      assert__assert_50: assert(_GEN_6);
      assert__assert_51: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_60)
      assert__assert_52: assert(_GEN_14);
    if (_GEN_61) begin
      assert__assert_53: assert(_source_ok_WIRE_1_0);
      assert__assert_54: assert(&io_in_d_bits_size);
      assert__assert_55: assert(~(|io_in_d_bits_param));
      assert__assert_56: assert(~io_in_d_bits_corrupt);
      assert__assert_57: assert(~io_in_d_bits_denied);
    end
    if (_GEN_62) begin
      assert__assert_58: assert(_source_ok_WIRE_1_0);
      assert__assert_59: assert(1'h0);
      assert__assert_60: assert(&io_in_d_bits_size);
      assert__assert_61: assert(_GEN_15);
      assert__assert_62: assert(_GEN_16);
      assert__assert_63: assert(~io_in_d_bits_corrupt);
      assert__assert_64: assert(~io_in_d_bits_denied);
    end
    if (_GEN_63) begin
      assert__assert_65: assert(_source_ok_WIRE_1_0);
      assert__assert_66: assert(1'h0);
      assert__assert_67: assert(&io_in_d_bits_size);
      assert__assert_68: assert(_GEN_15);
      assert__assert_69: assert(_GEN_16);
      assert__assert_70: assert(_GEN_17);
      assert__assert_71: assert(~io_in_d_bits_denied);
    end
    if (_GEN_64) begin
      assert__assert_72: assert(_source_ok_WIRE_1_0);
      assert__assert_73: assert(~(|io_in_d_bits_param));
      assert__assert_74: assert(~io_in_d_bits_corrupt);
      assert__assert_75: assert(~io_in_d_bits_denied);
    end
    if (_GEN_65) begin
      assert__assert_76: assert(_source_ok_WIRE_1_0);
      assert__assert_77: assert(~(|io_in_d_bits_param));
      assert__assert_78: assert(_GEN_17);
      assert__assert_79: assert(~io_in_d_bits_denied);
    end
    if (_GEN_66) begin
      assert__assert_80: assert(_source_ok_WIRE_1_0);
      assert__assert_81: assert(~(|io_in_d_bits_param));
      assert__assert_82: assert(~io_in_d_bits_corrupt);
      assert__assert_83: assert(~io_in_d_bits_denied);
    end
    if (_GEN_67) begin
      assert__assert_87: assert(_GEN_18);
      assert__assert_88: assert(_GEN_19);
      assert__assert_89: assert(_GEN_20);
      assert__assert_90: assert(_GEN_21);
      assert__assert_91: assert(_GEN_22);
    end
    if (_GEN_68) begin
      assert__assert_92: assert(_GEN_23);
      assert__assert_93: assert(_GEN_24);
      assert__assert_94: assert(_GEN_25);
      assert__assert_95: assert(_GEN_26);
      assert__assert_96: assert(_GEN_27);
      assert__assert_97: assert(_GEN_28);
    end
    if (_GEN_69)
      assert__assert_98: assert(~(_GEN_31[0]));
    if (_GEN_70)
      assert__assert_99: assert(_GEN_36);
    if (_GEN_71) begin
      assert__assert_100: assert(_GEN_38);
      assert__assert_101: assert(_GEN_39);
    end
    if (_GEN_72) begin
      assert__assert_102: assert(_GEN_43);
      assert__assert_103: assert(_GEN_45);
    end
    if (_GEN_73)
      assert__assert_104: assert(_GEN_46);
    if (~reset) begin
      assert__assert_105: assert(_GEN_47);
      assert__assert_106: assert(_GEN_48);
    end
    if (_GEN_74) begin
      assert__assert_108: assert(_GEN_49[0]);
      assert__assert_110: assert(_GEN_50);
    end
    if (~reset)
      assert__assert_113: assert(_GEN_51);
    if (reset) begin
      a_first_counter <= 1'h0;
      d_first_counter <= 1'h0;
      inflight <= 1040'h0;
      inflight_opcodes <= 4160'h0;
      inflight_sizes <= 4160'h0;
      a_first_counter_1 <= 1'h0;
      d_first_counter_1 <= 1'h0;
      watchdog <= 32'h0;
      inflight_1 <= 1040'h0;
      inflight_sizes_1 <= 4160'h0;
      d_first_counter_2 <= 1'h0;
      watchdog_1 <= 32'h0;
    end
    else begin
      a_first_counter <= (~a_first_done | a_first_counter - 1'h1) & a_first_counter;
      d_first_counter <= (~d_first_done | d_first_counter - 1'h1) & d_first_counter;
      inflight <= (inflight | (_GEN_30 ? _a_set_T[1039:0] : 1040'h0)) & ~(_GEN_76 ? _d_clr_T_1[1039:0] : 1040'h0);
      inflight_opcodes <= (inflight_opcodes | (_GEN_30 ? _a_opcodes_set_T_1[4159:0] : 4160'h0)) & ~(_GEN_76 ? _d_opcodes_clr_T_5[4159:0] : 4160'h0);
      inflight_sizes <= (inflight_sizes | (_GEN_30 ? _a_sizes_set_T_1[4159:0] : 4160'h0)) & ~(_GEN_76 ? _d_sizes_clr_T_5[4159:0] : 4160'h0);
      a_first_counter_1 <= (~a_first_done | a_first_counter_1 - 1'h1) & a_first_counter_1;
      d_first_counter_1 <= (~d_first_done | d_first_counter_1 - 1'h1) & d_first_counter_1;
      if (a_first_done | d_first_done)
        watchdog <= 32'h0;
      else
        watchdog <= watchdog + 32'h1;
      inflight_1 <= inflight_1 & ~(_GEN_77 ? _d_clr_T_1[1039:0] : 1040'h0);
      inflight_sizes_1 <= inflight_sizes_1 & ~(_GEN_77 ? _d_sizes_clr_T_11[4159:0] : 4160'h0);
      d_first_counter_2 <= (~d_first_done | d_first_counter_2 - 1'h1) & d_first_counter_2;
      if (d_first_done)
        watchdog_1 <= 32'h0;
      else
        watchdog_1 <= watchdog_1 + 32'h1;
    end
    if (a_first_done & ~a_first_counter) begin
      opcode <= io_in_a_bits_opcode;
      param <= io_in_a_bits_param;
      size <= io_in_a_bits_size;
      source <= io_in_a_bits_source;
      address <= io_in_a_bits_address;
    end
    if (d_first_done & ~d_first_counter) begin
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

