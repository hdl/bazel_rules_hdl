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
module TLMonitor_45_assert(
  input [8:0] io_in_a_bits_address,
  input [2:0] io_in_d_bits_opcode,
  input [1:0] io_in_d_bits_size,
              io_in_d_bits_param,
  input       io_in_d_bits_corrupt,
              io_in_d_bits_denied,
  input [2:0] io_in_a_bits_opcode,
  input       clock,
              reset,
              io_in_a_ready,
              io_in_a_valid,
              io_in_d_ready,
              io_in_d_valid,
              io_in_d_bits_sink
);

  wire [31:0] _plusarg_reader_1_out;
  wire [31:0] _plusarg_reader_out;
  wire        _GEN = io_in_a_bits_opcode == 3'h6;
  wire        _GEN_0 = io_in_a_bits_opcode == 3'h4;
  wire        _GEN_1 = io_in_a_bits_opcode == 3'h2;
  wire        _GEN_2 = io_in_a_bits_opcode == 3'h3;
  wire        _GEN_3 = io_in_a_bits_opcode == 3'h5;
  wire        _GEN_4 = io_in_d_bits_opcode != 3'h7;
  wire        d_release_ack = io_in_d_bits_opcode == 3'h6;
  wire        _GEN_5 = io_in_d_bits_param != 2'h3;
  wire        _GEN_6 = io_in_d_bits_param != 2'h2;
  wire        _GEN_7 = ~io_in_d_bits_denied | io_in_d_bits_corrupt;
  wire        a_first_done = io_in_a_ready & io_in_a_valid;
  reg         a_first_counter;
  reg  [2:0]  opcode;
  reg  [2:0]  param;
  reg  [1:0]  size;
  reg         source;
  reg  [8:0]  address;
  wire        _GEN_8 = io_in_a_bits_opcode == opcode;
  wire        _GEN_9 = size == 2'h2;
  wire        _GEN_10 = io_in_a_bits_address == address;
  reg         d_first_counter;
  reg  [2:0]  opcode_1;
  reg  [1:0]  param_1;
  reg  [1:0]  size_1;
  reg         source_1;
  reg         sink;
  reg         denied;
  wire        _GEN_11 = io_in_d_bits_opcode == opcode_1;
  wire        _GEN_12 = io_in_d_bits_param == param_1;
  wire        _GEN_13 = io_in_d_bits_size == size_1;
  wire        _GEN_14 = io_in_d_bits_sink == sink;
  wire        _GEN_15 = io_in_d_bits_denied == denied;
  reg         inflight;
  reg  [3:0]  inflight_opcodes;
  reg  [3:0]  inflight_sizes;
  reg         a_first_counter_1;
  reg         d_first_counter_1;
  wire        _same_cycle_resp_T_1 = io_in_a_valid & ~a_first_counter_1;
  wire        _GEN_16 = a_first_done & ~a_first_counter_1;
  wire        _GEN_17 = io_in_d_valid & ~d_first_counter_1;
  wire        _GEN_18 = _GEN_17 & ~d_release_ack;
  wire        _GEN_19 = inflight | _same_cycle_resp_T_1;
  wire        _GEN_20 = _GEN_0 | _GEN_2 | _GEN_1;
  wire        _GEN_21 = io_in_d_bits_opcode == ((&io_in_a_bits_opcode) | _GEN ? 3'h4 : _GEN_3 ? 3'h2 : {2'h0, _GEN_20}) | io_in_d_bits_opcode == ((&io_in_a_bits_opcode) ? 3'h4 : _GEN ? 3'h5 : _GEN_3 ? 3'h2 : {2'h0, _GEN_20});
  wire        _GEN_22 = io_in_d_bits_size == 2'h2;
  wire        _GEN_23 = inflight_opcodes[3:1] == 3'h4 | inflight_opcodes[3:1] == 3'h3 | inflight_opcodes[3:1] == 3'h2;
  wire        _GEN_24 = inflight_opcodes[3:1] == 3'h5;
  wire        _GEN_25 = inflight_opcodes[3:1] == 3'h6;
  wire        _GEN_26 = io_in_d_bits_opcode == ((&(inflight_opcodes[3:1])) | _GEN_25 ? 3'h4 : _GEN_24 ? 3'h2 : {2'h0, _GEN_23}) | io_in_d_bits_opcode == ((&(inflight_opcodes[3:1])) ? 3'h4 : _GEN_25 ? 3'h5 : _GEN_24 ? 3'h2 : {2'h0, _GEN_23});
  wire [3:0]  _GEN_27 = {2'h0, io_in_d_bits_size};
  wire        _GEN_28 = _GEN_27 == {1'h0, inflight_sizes[3:1]};
  wire        _GEN_29 = ~io_in_d_ready | io_in_a_ready;
  reg  [31:0] watchdog;
  wire        _GEN_30 = ~inflight | _plusarg_reader_out == 32'h0 | watchdog < _plusarg_reader_out;
  reg         inflight_1;
  reg  [3:0]  inflight_sizes_1;
  reg         d_first_counter_2;
  wire        _GEN_31 = _GEN_27 == {1'h0, inflight_sizes_1[3:1]};
  reg  [31:0] watchdog_1;
  wire        _GEN_32 = ~inflight_1 | _plusarg_reader_1_out == 32'h0 | watchdog_1 < _plusarg_reader_1_out;
  wire        _GEN_33 = io_in_a_valid & _GEN & ~reset;
  wire        _GEN_34 = io_in_a_valid & (&io_in_a_bits_opcode) & ~reset;
  wire        _GEN_35 = io_in_a_valid & _GEN_0 & ~reset;
  wire        _GEN_36 = io_in_a_valid & io_in_a_bits_opcode == 3'h0 & ~reset;
  wire        _GEN_37 = io_in_a_valid & io_in_a_bits_opcode == 3'h1 & ~reset;
  wire        _GEN_38 = io_in_a_valid & _GEN_1 & ~reset;
  wire        _GEN_39 = io_in_a_valid & _GEN_2 & ~reset;
  wire        _GEN_40 = io_in_a_valid & _GEN_3 & ~reset;
  wire        _GEN_41 = io_in_d_valid & ~reset;
  wire        _GEN_42 = io_in_d_valid & d_release_ack & ~reset;
  wire        _GEN_43 = io_in_d_valid & io_in_d_bits_opcode == 3'h4 & ~reset;
  wire        _GEN_44 = io_in_d_valid & io_in_d_bits_opcode == 3'h5 & ~reset;
  wire        _GEN_45 = io_in_d_valid & io_in_d_bits_opcode == 3'h0 & ~reset;
  wire        _GEN_46 = io_in_d_valid & io_in_d_bits_opcode == 3'h1 & ~reset;
  wire        _GEN_47 = io_in_d_valid & io_in_d_bits_opcode == 3'h2 & ~reset;
  wire        _GEN_48 = io_in_a_valid & a_first_counter & ~reset;
  wire        _GEN_49 = io_in_d_valid & d_first_counter & ~reset;
  wire        _GEN_50 = _GEN_16 & ~reset;
  wire        _GEN_51 = _GEN_18 & ~reset;
  wire        _GEN_52 = _GEN_18 & _same_cycle_resp_T_1 & ~reset;
  wire        _GEN_53 = _GEN_18 & ~_same_cycle_resp_T_1 & ~reset;
  wire        _GEN_54 = _GEN_17 & ~a_first_counter_1 & io_in_a_valid & ~d_release_ack & ~reset;
  wire        _GEN_55 = io_in_d_valid & ~d_first_counter_2 & d_release_ack & ~reset;
  `ifndef SYNTHESIS
    wire _GEN_56 = (`PRINTF_COND_) & _GEN_34;
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_33) begin
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquireBlock type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquireBlock from a client which does not support Probe (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      end
      if ((`PRINTF_COND_) & _GEN_33 & (|(io_in_a_bits_address[1:0])))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock address not aligned to size (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if (_GEN_56) begin
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquirePerm type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquirePerm from a client which does not support Probe (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      end
      if ((`PRINTF_COND_) & _GEN_34 & (|(io_in_a_bits_address[1:0])))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm address not aligned to size (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if (_GEN_56)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm requests NtoB (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_35 & (|(io_in_a_bits_address[1:0])))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get address not aligned to size (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_36 & (|(io_in_a_bits_address[1:0])))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull address not aligned to size (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_37)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries PutPartial type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_37 & (|(io_in_a_bits_address[1:0])))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial address not aligned to size (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_38)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Arithmetic type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_38 & (|(io_in_a_bits_address[1:0])))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic address not aligned to size (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_39)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Logical type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_39 & (|(io_in_a_bits_address[1:0])))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical address not aligned to size (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_40)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Hint type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_40 & (|(io_in_a_bits_address[1:0])))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint address not aligned to size (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_41 & ~_GEN_4)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel has invalid opcode (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_42 & ~(io_in_d_bits_size[1]))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck smaller than a beat (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_42 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseeAck carries invalid param (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_42 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck is corrupt (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_42 & io_in_d_bits_denied)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck is denied (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_43)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid sink ID (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_43 & ~(io_in_d_bits_size[1]))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant smaller than a beat (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_43 & ~_GEN_5)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid cap param (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_43 & ~_GEN_6)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries toN param (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_43 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant is corrupt (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_44)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid sink ID (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_44 & ~(io_in_d_bits_size[1]))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData smaller than a beat (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_44 & ~_GEN_5)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid cap param (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_44 & ~_GEN_6)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries toN param (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_44 & ~_GEN_7)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData is denied but not corrupt (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_45 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck carries invalid param (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_45 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck is corrupt (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_46 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData carries invalid param (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_46 & ~_GEN_7)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData is denied but not corrupt (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_47 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck carries invalid param (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_47 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck is corrupt (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_48 & ~_GEN_8)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel opcode changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_48 & (|param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel param changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_48 & ~_GEN_9)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel size changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_48 & source)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel source changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_48 & ~_GEN_10)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel address changed with multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_49 & ~_GEN_11)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel opcode changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_49 & ~_GEN_12)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel param changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_49 & ~_GEN_13)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel size changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_49 & source_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel source changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_49 & ~_GEN_14)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel sink changed with multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_49 & ~_GEN_15)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel denied changed with multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_50 & inflight)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel re-used a source ID (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_51 & ~_GEN_19)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_52 & ~_GEN_21)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_52 & ~_GEN_22)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_53 & ~_GEN_26)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_53 & ~_GEN_28)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_54 & ~_GEN_29)
        $fwrite(32'h80000002, "Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_30)
        $fwrite(32'h80000002, "Assertion failed: TileLink timeout expired (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_55 & ~inflight_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_55 & ~_GEN_31)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_32)
        $fwrite(32'h80000002, "Assertion failed: TileLink timeout expired (connected at generators/rocket-chip/src/main/scala/devices/debug/Debug.scala:674:18)\n    at Monitor.scala:42 assert(cond, message)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire        _GEN_57 = a_first_done & ~a_first_counter;
  wire        d_first_done = io_in_d_ready & io_in_d_valid;
  wire        _GEN_58 = d_first_done & ~d_first_counter;
  wire        _GEN_59 = d_first_done & ~d_first_counter_1 & ~d_release_ack;
  wire        _GEN_60 = d_first_done & ~d_first_counter_2 & d_release_ack;
  always @(posedge clock) begin
    if (_GEN_33) begin
      assert__assert_2: assert(1'h0);
      assert__assert_3: assert(1'h0);
      assert__assert_6: assert(~(|(io_in_a_bits_address[1:0])));
    end
    if (_GEN_34) begin
      assert__assert_10: assert(1'h0);
      assert__assert_11: assert(1'h0);
      assert__assert_14: assert(~(|(io_in_a_bits_address[1:0])));
      assert__assert_16: assert(1'h0);
    end
    if (_GEN_35)
      assert__assert_22: assert(~(|(io_in_a_bits_address[1:0])));
    if (_GEN_36)
      assert__assert_28: assert(~(|(io_in_a_bits_address[1:0])));
    if (_GEN_37) begin
      assert__assert_31: assert(1'h0);
      assert__assert_33: assert(~(|(io_in_a_bits_address[1:0])));
    end
    if (_GEN_38) begin
      assert__assert_36: assert(1'h0);
      assert__assert_38: assert(~(|(io_in_a_bits_address[1:0])));
    end
    if (_GEN_39) begin
      assert__assert_41: assert(1'h0);
      assert__assert_43: assert(~(|(io_in_a_bits_address[1:0])));
    end
    if (_GEN_40) begin
      assert__assert_46: assert(1'h0);
      assert__assert_48: assert(~(|(io_in_a_bits_address[1:0])));
    end
    if (_GEN_41)
      assert__assert_52: assert(_GEN_4);
    if (_GEN_42) begin
      assert__assert_54: assert(io_in_d_bits_size[1]);
      assert__assert_55: assert(~(|io_in_d_bits_param));
      assert__assert_56: assert(~io_in_d_bits_corrupt);
      assert__assert_57: assert(~io_in_d_bits_denied);
    end
    if (_GEN_43) begin
      assert__assert_59: assert(1'h0);
      assert__assert_60: assert(io_in_d_bits_size[1]);
      assert__assert_61: assert(_GEN_5);
      assert__assert_62: assert(_GEN_6);
      assert__assert_63: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_44) begin
      assert__assert_66: assert(1'h0);
      assert__assert_67: assert(io_in_d_bits_size[1]);
      assert__assert_68: assert(_GEN_5);
      assert__assert_69: assert(_GEN_6);
      assert__assert_70: assert(_GEN_7);
    end
    if (_GEN_45) begin
      assert__assert_73: assert(~(|io_in_d_bits_param));
      assert__assert_74: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_46) begin
      assert__assert_77: assert(~(|io_in_d_bits_param));
      assert__assert_78: assert(_GEN_7);
    end
    if (_GEN_47) begin
      assert__assert_81: assert(~(|io_in_d_bits_param));
      assert__assert_82: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_48) begin
      assert__assert_87: assert(_GEN_8);
      assert__assert_88: assert(~(|param));
      assert__assert_89: assert(_GEN_9);
      assert__assert_90: assert(~source);
      assert__assert_91: assert(_GEN_10);
    end
    if (_GEN_49) begin
      assert__assert_92: assert(_GEN_11);
      assert__assert_93: assert(_GEN_12);
      assert__assert_94: assert(_GEN_13);
      assert__assert_95: assert(~source_1);
      assert__assert_96: assert(_GEN_14);
      assert__assert_97: assert(_GEN_15);
    end
    if (_GEN_50)
      assert__assert_98: assert(~inflight);
    if (_GEN_51)
      assert__assert_99: assert(_GEN_19);
    if (_GEN_52) begin
      assert__assert_100: assert(_GEN_21);
      assert__assert_101: assert(_GEN_22);
    end
    if (_GEN_53) begin
      assert__assert_102: assert(_GEN_26);
      assert__assert_103: assert(_GEN_28);
    end
    if (_GEN_54)
      assert__assert_104: assert(_GEN_29);
    if (~reset)
      assert__assert_105: assert(_GEN_30);
    if (_GEN_55) begin
      assert__assert_107: assert(inflight_1);
      assert__assert_109: assert(_GEN_31);
    end
    if (~reset)
      assert__assert_111: assert(_GEN_32);
    if (reset) begin
      a_first_counter <= 1'h0;
      d_first_counter <= 1'h0;
      inflight <= 1'h0;
      inflight_opcodes <= 4'h0;
      inflight_sizes <= 4'h0;
      a_first_counter_1 <= 1'h0;
      d_first_counter_1 <= 1'h0;
      watchdog <= 32'h0;
      inflight_1 <= 1'h0;
      inflight_sizes_1 <= 4'h0;
      d_first_counter_2 <= 1'h0;
      watchdog_1 <= 32'h0;
    end
    else begin
      a_first_counter <= (~a_first_done | a_first_counter - 1'h1) & a_first_counter;
      d_first_counter <= (~d_first_done | d_first_counter - 1'h1) & d_first_counter;
      inflight <= (inflight | _GEN_16) & ~_GEN_59;
      inflight_opcodes <= (inflight_opcodes | (_GEN_16 ? {io_in_a_bits_opcode, 1'h1} : 4'h0)) & ~{4{_GEN_59}};
      inflight_sizes <= (inflight_sizes | (_GEN_16 ? {1'h0, _GEN_16 ? 3'h5 : 3'h0} : 4'h0)) & ~{4{_GEN_59}};
      a_first_counter_1 <= (~a_first_done | a_first_counter_1 - 1'h1) & a_first_counter_1;
      d_first_counter_1 <= (~d_first_done | d_first_counter_1 - 1'h1) & d_first_counter_1;
      if (a_first_done | d_first_done)
        watchdog <= 32'h0;
      else
        watchdog <= watchdog + 32'h1;
      inflight_1 <= inflight_1 & ~_GEN_60;
      inflight_sizes_1 <= inflight_sizes_1 & ~{4{_GEN_60}};
      d_first_counter_2 <= (~d_first_done | d_first_counter_2 - 1'h1) & d_first_counter_2;
      if (d_first_done)
        watchdog_1 <= 32'h0;
      else
        watchdog_1 <= watchdog_1 + 32'h1;
    end
    if (_GEN_57) begin
      opcode <= io_in_a_bits_opcode;
      param <= 3'h0;
      size <= 2'h2;
      address <= io_in_a_bits_address;
    end
    source <= ~_GEN_57 & source;
    if (_GEN_58) begin
      opcode_1 <= io_in_d_bits_opcode;
      param_1 <= io_in_d_bits_param;
      size_1 <= io_in_d_bits_size;
      sink <= io_in_d_bits_sink;
      denied <= io_in_d_bits_denied;
    end
    source_1 <= ~_GEN_58 & source_1;
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

