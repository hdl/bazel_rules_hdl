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
module TLMonitor_60_assert(
  input [31:0] io_in_a_bits_address,
  input [3:0]  io_in_a_bits_size,
  input [7:0]  io_in_a_bits_mask,
  input [2:0]  io_in_d_bits_opcode,
  input        io_in_d_bits_source,
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
  input [3:0]  io_in_d_bits_sink
);

  wire [31:0] _plusarg_reader_1_out;
  wire [31:0] _plusarg_reader_out;
  wire [26:0] _GEN = {23'h0, io_in_a_bits_size};
  wire [26:0] _is_aligned_mask_T_1 = 27'hFFF << _GEN;
  wire [11:0] _GEN_0 = io_in_a_bits_address[11:0] & ~(_is_aligned_mask_T_1[11:0]);
  wire        _mask_T = io_in_a_bits_size > 4'h2;
  wire        mask_size = io_in_a_bits_size[1:0] == 2'h2;
  wire        mask_acc = _mask_T | mask_size & ~(io_in_a_bits_address[2]);
  wire        mask_acc_1 = _mask_T | mask_size & io_in_a_bits_address[2];
  wire        mask_size_1 = io_in_a_bits_size[1:0] == 2'h1;
  wire        mask_eq_2 = ~(io_in_a_bits_address[2]) & ~(io_in_a_bits_address[1]);
  wire        mask_acc_2 = mask_acc | mask_size_1 & mask_eq_2;
  wire        mask_eq_3 = ~(io_in_a_bits_address[2]) & io_in_a_bits_address[1];
  wire        mask_acc_3 = mask_acc | mask_size_1 & mask_eq_3;
  wire        mask_eq_4 = io_in_a_bits_address[2] & ~(io_in_a_bits_address[1]);
  wire        mask_acc_4 = mask_acc_1 | mask_size_1 & mask_eq_4;
  wire        mask_eq_5 = io_in_a_bits_address[2] & io_in_a_bits_address[1];
  wire        mask_acc_5 = mask_acc_1 | mask_size_1 & mask_eq_5;
  wire [7:0]  mask = {mask_acc_5 | mask_eq_5 & io_in_a_bits_address[0], mask_acc_5 | mask_eq_5 & ~(io_in_a_bits_address[0]), mask_acc_4 | mask_eq_4 & io_in_a_bits_address[0], mask_acc_4 | mask_eq_4 & ~(io_in_a_bits_address[0]), mask_acc_3 | mask_eq_3 & io_in_a_bits_address[0], mask_acc_3 | mask_eq_3 & ~(io_in_a_bits_address[0]), mask_acc_2 | mask_eq_2 & io_in_a_bits_address[0], mask_acc_2 | mask_eq_2 & ~(io_in_a_bits_address[0])};
  wire        _GEN_1 = io_in_a_bits_opcode == 3'h6;
  wire        _GEN_2 = io_in_a_bits_size < 4'hD;
  wire        _GEN_3 = io_in_a_bits_address[31:28] == 4'h8;
  wire        _GEN_4 = _GEN_2 & io_in_a_bits_size == 4'h6 & _GEN_3;
  wire        _GEN_5 = io_in_a_bits_mask != 8'hFF;
  wire        _GEN_6 = io_in_a_bits_opcode == 3'h4;
  wire        _GEN_7 = {io_in_a_bits_address[31:14], ~(io_in_a_bits_address[13:12])} == 20'h0;
  wire        _GEN_8 = _GEN_2 & _GEN_7;
  wire        _GEN_9 = io_in_a_bits_size < 4'h7;
  wire        _GEN_10 = {io_in_a_bits_address[31:15], io_in_a_bits_address[13:12]} == 19'h0;
  wire        _GEN_11 = {io_in_a_bits_address[31:21], io_in_a_bits_address[20:17] ^ 4'h8, io_in_a_bits_address[15:12]} == 19'h0;
  wire        _GEN_12 = {io_in_a_bits_address[31:26], io_in_a_bits_address[25:16] ^ 10'h200} == 16'h0;
  wire        _GEN_13 = {io_in_a_bits_address[31:26], io_in_a_bits_address[25:12] ^ 14'h2010} == 20'h0;
  wire        _GEN_14 = {io_in_a_bits_address[31:28], ~(io_in_a_bits_address[27:26])} == 6'h0;
  wire        _GEN_15 = {io_in_a_bits_address[31:29], io_in_a_bits_address[28:12] ^ 17'h10020} == 20'h0;
  wire        _GEN_16 = _GEN_8 | _GEN_9 & (_GEN_10 | {io_in_a_bits_address[31:17], ~(io_in_a_bits_address[16])} == 16'h0 | _GEN_11 | _GEN_12 | _GEN_13 | _GEN_14 | _GEN_15 | _GEN_3);
  wire        _GEN_17 = io_in_a_bits_mask == mask;
  wire        _GEN_18 = _GEN_2 & (_GEN_8 | _GEN_9 & (_GEN_10 | _GEN_11 | _GEN_12 | _GEN_13 | _GEN_14 | _GEN_15 | _GEN_3));
  wire [7:0]  _GEN_19 = io_in_a_bits_mask & ~mask;
  wire        _GEN_20 = io_in_a_bits_opcode == 3'h2;
  wire        _GEN_21 = _GEN_2 & (io_in_a_bits_size < 4'h4 & (_GEN_10 | _GEN_7 | _GEN_11 | _GEN_12 | _GEN_13 | _GEN_14 | _GEN_15) | io_in_a_bits_size < 4'h5 & _GEN_3);
  wire        _GEN_22 = io_in_a_bits_opcode == 3'h3;
  wire        _GEN_23 = io_in_a_bits_opcode == 3'h5;
  wire        _GEN_24 = _GEN_2 & (_GEN_8 | _GEN_9 & _GEN_3);
  wire        _GEN_25 = io_in_d_bits_opcode != 3'h7;
  wire        d_release_ack = io_in_d_bits_opcode == 3'h6;
  wire        _GEN_26 = io_in_d_bits_size > 4'h2;
  wire        _GEN_27 = io_in_d_bits_param != 2'h3;
  wire        _GEN_28 = io_in_d_bits_param != 2'h2;
  wire        _GEN_29 = ~io_in_d_bits_denied | io_in_d_bits_corrupt;
  wire        _a_first_T_1 = io_in_a_ready & io_in_a_valid;
  reg  [8:0]  a_first_counter;
  reg  [2:0]  opcode;
  reg  [2:0]  param;
  reg  [3:0]  size;
  reg         source;
  reg  [31:0] address;
  wire        _GEN_30 = io_in_a_bits_opcode == opcode;
  wire        _GEN_31 = io_in_a_bits_size == size;
  wire        _GEN_32 = io_in_a_bits_address == address;
  reg  [8:0]  d_first_counter;
  reg  [2:0]  opcode_1;
  reg  [1:0]  param_1;
  reg  [3:0]  size_1;
  reg         source_1;
  reg  [3:0]  sink;
  reg         denied;
  wire        _GEN_33 = io_in_d_bits_opcode == opcode_1;
  wire        _GEN_34 = io_in_d_bits_param == param_1;
  wire        _GEN_35 = io_in_d_bits_size == size_1;
  wire        _GEN_36 = io_in_d_bits_source == source_1;
  wire        _GEN_37 = io_in_d_bits_sink == sink;
  wire        _GEN_38 = io_in_d_bits_denied == denied;
  reg         inflight;
  reg  [3:0]  inflight_opcodes;
  reg  [7:0]  inflight_sizes;
  reg  [8:0]  a_first_counter_1;
  wire        a_first_1 = a_first_counter_1 == 9'h0;
  reg  [8:0]  d_first_counter_1;
  wire        d_first_1 = d_first_counter_1 == 9'h0;
  wire [3:0]  _a_opcode_lookup_T_1 = inflight_opcodes >> {1'h0, io_in_d_bits_source, 2'h0};
  wire [7:0]  _GEN_39 = {4'h0, io_in_d_bits_source, 3'h0};
  wire [7:0]  _a_size_lookup_T_1 = inflight_sizes >> _GEN_39;
  wire        _same_cycle_resp_T_1 = io_in_a_valid & a_first_1;
  wire        _GEN_40 = _a_first_T_1 & a_first_1;
  wire        _GEN_41 = io_in_d_valid & d_first_1;
  wire        _GEN_42 = _GEN_41 & ~d_release_ack;
  wire        same_cycle_resp = _same_cycle_resp_T_1 & ~io_in_d_bits_source;
  wire        _GEN_43 = inflight >> io_in_d_bits_source | same_cycle_resp;
  wire        _GEN_44 = _GEN_6 | _GEN_22 | _GEN_20;
  wire        _GEN_45 = io_in_d_bits_opcode == ((&io_in_a_bits_opcode) | _GEN_1 ? 3'h4 : _GEN_23 ? 3'h2 : {2'h0, _GEN_44}) | io_in_d_bits_opcode == ((&io_in_a_bits_opcode) ? 3'h4 : _GEN_1 ? 3'h5 : _GEN_23 ? 3'h2 : {2'h0, _GEN_44});
  wire        _GEN_46 = io_in_a_bits_size == io_in_d_bits_size;
  wire        _GEN_47 = _a_opcode_lookup_T_1[3:1] == 3'h4 | _a_opcode_lookup_T_1[3:1] == 3'h3 | _a_opcode_lookup_T_1[3:1] == 3'h2;
  wire        _GEN_48 = _a_opcode_lookup_T_1[3:1] == 3'h5;
  wire        _GEN_49 = _a_opcode_lookup_T_1[3:1] == 3'h6;
  wire        _GEN_50 = io_in_d_bits_opcode == ((&(_a_opcode_lookup_T_1[3:1])) | _GEN_49 ? 3'h4 : _GEN_48 ? 3'h2 : {2'h0, _GEN_47}) | io_in_d_bits_opcode == ((&(_a_opcode_lookup_T_1[3:1])) ? 3'h4 : _GEN_49 ? 3'h5 : _GEN_48 ? 3'h2 : {2'h0, _GEN_47});
  wire [7:0]  _GEN_51 = {4'h0, io_in_d_bits_size};
  wire        _GEN_52 = _GEN_51 == {1'h0, _a_size_lookup_T_1[7:1]};
  wire        _GEN_53 = ~io_in_d_ready | io_in_a_ready;
  wire        _GEN_54 = _same_cycle_resp_T_1 != (_GEN_42 & ~io_in_d_bits_source) | ~_same_cycle_resp_T_1;
  reg  [31:0] watchdog;
  wire        _GEN_55 = ~inflight | _plusarg_reader_out == 32'h0 | watchdog < _plusarg_reader_out;
  reg         inflight_1;
  reg  [7:0]  inflight_sizes_1;
  reg  [8:0]  d_first_counter_2;
  wire        d_first_2 = d_first_counter_2 == 9'h0;
  wire [7:0]  _c_size_lookup_T_1 = inflight_sizes_1 >> _GEN_39;
  wire        _GEN_56 = inflight_1 >> io_in_d_bits_source;
  wire        _GEN_57 = _GEN_51 == {1'h0, _c_size_lookup_T_1[7:1]};
  reg  [31:0] watchdog_1;
  wire        _GEN_58 = ~inflight_1 | _plusarg_reader_1_out == 32'h0 | watchdog_1 < _plusarg_reader_1_out;
  wire        _GEN_59 = io_in_a_valid & _GEN_1 & ~reset;
  wire        _GEN_60 = io_in_a_valid & (&io_in_a_bits_opcode) & ~reset;
  wire        _GEN_61 = io_in_a_valid & _GEN_6 & ~reset;
  wire        _GEN_62 = io_in_a_valid & io_in_a_bits_opcode == 3'h0 & ~reset;
  wire        _GEN_63 = io_in_a_valid & io_in_a_bits_opcode == 3'h1 & ~reset;
  wire        _GEN_64 = io_in_a_valid & _GEN_20 & ~reset;
  wire        _GEN_65 = io_in_a_valid & _GEN_22 & ~reset;
  wire        _GEN_66 = io_in_a_valid & _GEN_23 & ~reset;
  wire        _GEN_67 = io_in_d_valid & ~reset;
  wire        _GEN_68 = io_in_d_valid & d_release_ack & ~reset;
  wire        _GEN_69 = io_in_d_valid & io_in_d_bits_opcode == 3'h4 & ~reset;
  wire        _GEN_70 = io_in_d_valid & io_in_d_bits_opcode == 3'h5 & ~reset;
  wire        _GEN_71 = io_in_d_valid & io_in_d_bits_opcode == 3'h0 & ~reset;
  wire        _GEN_72 = io_in_d_valid & io_in_d_bits_opcode == 3'h1 & ~reset;
  wire        _GEN_73 = io_in_d_valid & io_in_d_bits_opcode == 3'h2 & ~reset;
  wire        _GEN_74 = io_in_a_valid & (|a_first_counter) & ~reset;
  wire        _GEN_75 = io_in_d_valid & (|d_first_counter) & ~reset;
  wire        _GEN_76 = _GEN_40 & ~reset;
  wire        _GEN_77 = _GEN_42 & ~reset;
  wire        _GEN_78 = _GEN_42 & same_cycle_resp & ~reset;
  wire        _GEN_79 = _GEN_42 & ~same_cycle_resp & ~reset;
  wire        _GEN_80 = _GEN_41 & a_first_1 & io_in_a_valid & ~io_in_d_bits_source & ~d_release_ack & ~reset;
  wire        _GEN_81 = io_in_d_valid & d_first_2 & d_release_ack & ~reset;
  `ifndef SYNTHESIS
    wire _GEN_82 = (`PRINTF_COND_) & _GEN_60;
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_59 & ~_GEN_4)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquireBlock type which is unexpected using diplomatic parameters (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_59)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquireBlock from a client which does not support Probe (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_59 & ~_mask_T)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock smaller than a beat (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_59 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock address not aligned to size (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_59 & _GEN_5)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock contains invalid mask (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_60 & ~_GEN_4)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquirePerm type which is unexpected using diplomatic parameters (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if (_GEN_82)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquirePerm from a client which does not support Probe (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_60 & ~_mask_T)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm smaller than a beat (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_60 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm address not aligned to size (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if (_GEN_82)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm requests NtoB (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_60 & _GEN_5)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm contains invalid mask (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_61 & ~_GEN_2)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Get type which master claims it can't emit (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_61 & ~_GEN_16)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Get type which slave claims it can't support (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_61 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get address not aligned to size (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_61 & ~_GEN_17)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get contains invalid mask (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_62 & ~_GEN_18)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries PutFull type which is unexpected using diplomatic parameters (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_62 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull address not aligned to size (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_62 & ~_GEN_17)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull contains invalid mask (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_63 & ~_GEN_18)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries PutPartial type which is unexpected using diplomatic parameters (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_63 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial address not aligned to size (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_63 & (|_GEN_19))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial contains invalid mask (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_64 & ~_GEN_21)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Arithmetic type which is unexpected using diplomatic parameters (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_64 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic address not aligned to size (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_64 & ~_GEN_17)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic contains invalid mask (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_65 & ~_GEN_21)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Logical type which is unexpected using diplomatic parameters (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_65 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical address not aligned to size (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_65 & ~_GEN_17)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical contains invalid mask (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_66 & ~_GEN_24)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Hint type which is unexpected using diplomatic parameters (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_66 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint address not aligned to size (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_66 & ~_GEN_17)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint contains invalid mask (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_67 & ~_GEN_25)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel has invalid opcode (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_68 & io_in_d_bits_source)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck carries invalid source ID (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_68 & ~_GEN_26)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck smaller than a beat (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_68 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseeAck carries invalid param (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_68 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck is corrupt (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_68 & io_in_d_bits_denied)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck is denied (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_69 & io_in_d_bits_source)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid source ID (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_69 & ~_GEN_26)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant smaller than a beat (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_69 & ~_GEN_27)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid cap param (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_69 & ~_GEN_28)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries toN param (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_69 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant is corrupt (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_70 & io_in_d_bits_source)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid source ID (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_70 & ~_GEN_26)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData smaller than a beat (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_70 & ~_GEN_27)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid cap param (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_70 & ~_GEN_28)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries toN param (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_70 & ~_GEN_29)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData is denied but not corrupt (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_71 & io_in_d_bits_source)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck carries invalid source ID (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_71 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck carries invalid param (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_71 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck is corrupt (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_72 & io_in_d_bits_source)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData carries invalid source ID (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_72 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData carries invalid param (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_72 & ~_GEN_29)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData is denied but not corrupt (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_73 & io_in_d_bits_source)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck carries invalid source ID (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_73 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck carries invalid param (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_73 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck is corrupt (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_74 & ~_GEN_30)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel opcode changed within multibeat operation (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_74 & (|param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel param changed within multibeat operation (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_74 & ~_GEN_31)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel size changed within multibeat operation (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_74 & source)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel source changed within multibeat operation (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_74 & ~_GEN_32)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel address changed with multibeat operation (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_75 & ~_GEN_33)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel opcode changed within multibeat operation (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_75 & ~_GEN_34)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel param changed within multibeat operation (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_75 & ~_GEN_35)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel size changed within multibeat operation (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_75 & ~_GEN_36)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel source changed within multibeat operation (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_75 & ~_GEN_37)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel sink changed with multibeat operation (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_75 & ~_GEN_38)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel denied changed with multibeat operation (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_76 & inflight)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel re-used a source ID (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_77 & ~_GEN_43)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_78 & ~_GEN_45)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_78 & ~_GEN_46)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_79 & ~_GEN_50)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_79 & ~_GEN_52)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_80 & ~_GEN_53)
        $fwrite(32'h80000002, "Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_54)
        $fwrite(32'h80000002, "Assertion failed: 'A' and 'D' concurrent, despite minlatency 8 (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_55)
        $fwrite(32'h80000002, "Assertion failed: TileLink timeout expired (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_81 & ~_GEN_56)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_81 & ~_GEN_57)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_58)
        $fwrite(32'h80000002, "Assertion failed: TileLink timeout expired (connected at generators/testchipip/src/main/scala/TSIHarness.scala:100:43)\n    at Monitor.scala:42 assert(cond, message)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire [26:0] _a_first_beats1_decode_T_1 = 27'hFFF << _GEN;
  wire [26:0] _a_first_beats1_decode_T_5 = 27'hFFF << _GEN;
  wire [26:0] _GEN_83 = {23'h0, io_in_d_bits_size};
  wire [26:0] _d_first_beats1_decode_T_1 = 27'hFFF << _GEN_83;
  wire [26:0] _d_first_beats1_decode_T_5 = 27'hFFF << _GEN_83;
  wire [26:0] _d_first_beats1_decode_T_9 = 27'hFFF << _GEN_83;
  wire [30:0] _GEN_84 = {27'h0, io_in_d_bits_source, 3'h0};
  wire [30:0] _d_opcodes_clr_T_5 = 31'hF << {28'h0, io_in_d_bits_source, 2'h0};
  wire [30:0] _d_sizes_clr_T_5 = 31'hFF << _GEN_84;
  wire [30:0] _d_sizes_clr_T_11 = 31'hFF << _GEN_84;
  wire        _GEN_85 = _a_first_T_1 & ~(|a_first_counter);
  wire        _d_first_T_2 = io_in_d_ready & io_in_d_valid;
  wire        _GEN_86 = _d_first_T_2 & d_first_1 & ~d_release_ack;
  wire        _GEN_87 = _d_first_T_2 & d_first_2 & d_release_ack;
  always @(posedge clock) begin
    if (_GEN_59) begin
      assert__assert_2: assert(_GEN_4);
      assert__assert_3: assert(1'h0);
      assert__assert_5: assert(_mask_T);
      assert__assert_6: assert(~(|_GEN_0));
      assert__assert_8: assert(~_GEN_5);
    end
    if (_GEN_60) begin
      assert__assert_10: assert(_GEN_4);
      assert__assert_11: assert(1'h0);
      assert__assert_13: assert(_mask_T);
      assert__assert_14: assert(~(|_GEN_0));
      assert__assert_16: assert(1'h0);
      assert__assert_17: assert(~_GEN_5);
    end
    if (_GEN_61) begin
      assert__assert_19: assert(_GEN_2);
      assert__assert_20: assert(_GEN_16);
      assert__assert_22: assert(~(|_GEN_0));
      assert__assert_24: assert(_GEN_17);
    end
    if (_GEN_62) begin
      assert__assert_26: assert(_GEN_18);
      assert__assert_28: assert(~(|_GEN_0));
      assert__assert_30: assert(_GEN_17);
    end
    if (_GEN_63) begin
      assert__assert_31: assert(_GEN_18);
      assert__assert_33: assert(~(|_GEN_0));
      assert__assert_35: assert(~(|_GEN_19));
    end
    if (_GEN_64) begin
      assert__assert_36: assert(_GEN_21);
      assert__assert_38: assert(~(|_GEN_0));
      assert__assert_40: assert(_GEN_17);
    end
    if (_GEN_65) begin
      assert__assert_41: assert(_GEN_21);
      assert__assert_43: assert(~(|_GEN_0));
      assert__assert_45: assert(_GEN_17);
    end
    if (_GEN_66) begin
      assert__assert_46: assert(_GEN_24);
      assert__assert_48: assert(~(|_GEN_0));
      assert__assert_50: assert(_GEN_17);
    end
    if (_GEN_67)
      assert__assert_52: assert(_GEN_25);
    if (_GEN_68) begin
      assert__assert_53: assert(~io_in_d_bits_source);
      assert__assert_54: assert(_GEN_26);
      assert__assert_55: assert(~(|io_in_d_bits_param));
      assert__assert_56: assert(~io_in_d_bits_corrupt);
      assert__assert_57: assert(~io_in_d_bits_denied);
    end
    if (_GEN_69) begin
      assert__assert_58: assert(~io_in_d_bits_source);
      assert__assert_60: assert(_GEN_26);
      assert__assert_61: assert(_GEN_27);
      assert__assert_62: assert(_GEN_28);
      assert__assert_63: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_70) begin
      assert__assert_65: assert(~io_in_d_bits_source);
      assert__assert_67: assert(_GEN_26);
      assert__assert_68: assert(_GEN_27);
      assert__assert_69: assert(_GEN_28);
      assert__assert_70: assert(_GEN_29);
    end
    if (_GEN_71) begin
      assert__assert_72: assert(~io_in_d_bits_source);
      assert__assert_73: assert(~(|io_in_d_bits_param));
      assert__assert_74: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_72) begin
      assert__assert_76: assert(~io_in_d_bits_source);
      assert__assert_77: assert(~(|io_in_d_bits_param));
      assert__assert_78: assert(_GEN_29);
    end
    if (_GEN_73) begin
      assert__assert_80: assert(~io_in_d_bits_source);
      assert__assert_81: assert(~(|io_in_d_bits_param));
      assert__assert_82: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_74) begin
      assert__assert_87: assert(_GEN_30);
      assert__assert_88: assert(~(|param));
      assert__assert_89: assert(_GEN_31);
      assert__assert_90: assert(~source);
      assert__assert_91: assert(_GEN_32);
    end
    if (_GEN_75) begin
      assert__assert_92: assert(_GEN_33);
      assert__assert_93: assert(_GEN_34);
      assert__assert_94: assert(_GEN_35);
      assert__assert_95: assert(_GEN_36);
      assert__assert_96: assert(_GEN_37);
      assert__assert_97: assert(_GEN_38);
    end
    if (_GEN_76)
      assert__assert_98: assert(~inflight);
    if (_GEN_77)
      assert__assert_99: assert(_GEN_43);
    if (_GEN_78) begin
      assert__assert_100: assert(_GEN_45);
      assert__assert_101: assert(_GEN_46);
    end
    if (_GEN_79) begin
      assert__assert_102: assert(_GEN_50);
      assert__assert_103: assert(_GEN_52);
    end
    if (_GEN_80)
      assert__assert_104: assert(_GEN_53);
    if (~reset) begin
      assert__assert_105: assert(_GEN_54);
      assert__assert_106: assert(_GEN_55);
    end
    if (_GEN_81) begin
      assert__assert_108: assert(_GEN_56);
      assert__assert_110: assert(_GEN_57);
    end
    if (~reset)
      assert__assert_113: assert(_GEN_58);
    if (reset) begin
      a_first_counter <= 9'h0;
      d_first_counter <= 9'h0;
      inflight <= 1'h0;
      inflight_opcodes <= 4'h0;
      inflight_sizes <= 8'h0;
      a_first_counter_1 <= 9'h0;
      d_first_counter_1 <= 9'h0;
      watchdog <= 32'h0;
      inflight_1 <= 1'h0;
      inflight_sizes_1 <= 8'h0;
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
      inflight <= (inflight | _GEN_40) & ~(_GEN_86 & ~io_in_d_bits_source);
      inflight_opcodes <= (inflight_opcodes | (_GEN_40 ? {io_in_a_bits_opcode, 1'h1} : 4'h0)) & ~(_GEN_86 ? _d_opcodes_clr_T_5[3:0] : 4'h0);
      inflight_sizes <= (inflight_sizes | (_GEN_40 ? {3'h0, _GEN_40 ? {io_in_a_bits_size, 1'h1} : 5'h0} : 8'h0)) & ~(_GEN_86 ? _d_sizes_clr_T_5[7:0] : 8'h0);
      if (_a_first_T_1 | _d_first_T_2)
        watchdog <= 32'h0;
      else
        watchdog <= watchdog + 32'h1;
      inflight_1 <= inflight_1 & ~(_GEN_87 & ~io_in_d_bits_source);
      inflight_sizes_1 <= inflight_sizes_1 & ~(_GEN_87 ? _d_sizes_clr_T_11[7:0] : 8'h0);
    end
    if (_GEN_85) begin
      opcode <= io_in_a_bits_opcode;
      param <= 3'h0;
      size <= io_in_a_bits_size;
      address <= io_in_a_bits_address;
    end
    source <= ~_GEN_85 & source;
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

