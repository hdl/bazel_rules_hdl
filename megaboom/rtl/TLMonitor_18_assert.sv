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
module TLMonitor_18_assert(
  input [28:0] io_in_a_bits_address,
  input [2:0]  io_in_d_bits_opcode,
  input [3:0]  io_in_d_bits_size,
  input [1:0]  io_in_d_bits_param,
  input        io_in_d_bits_corrupt,
               io_in_d_bits_denied,
               clock,
               reset,
               io_in_a_ready,
               io_in_a_valid,
               io_in_d_valid,
               io_in_d_bits_sink
);

  wire [31:0] _plusarg_reader_1_out;
  wire [31:0] _plusarg_reader_out;
  wire        mask_eq_2 = ~(io_in_a_bits_address[2]) & ~(io_in_a_bits_address[1]);
  wire        mask_eq_3 = ~(io_in_a_bits_address[2]) & io_in_a_bits_address[1];
  wire        mask_eq_4 = io_in_a_bits_address[2] & ~(io_in_a_bits_address[1]);
  wire        mask_eq_5 = io_in_a_bits_address[2] & io_in_a_bits_address[1];
  wire        _GEN = {io_in_a_bits_address[2] | mask_eq_5 & io_in_a_bits_address[0], io_in_a_bits_address[2] | mask_eq_5 & ~(io_in_a_bits_address[0]), io_in_a_bits_address[2] | mask_eq_4 & io_in_a_bits_address[0], io_in_a_bits_address[2] | mask_eq_4 & ~(io_in_a_bits_address[0]), ~(io_in_a_bits_address[2]) | mask_eq_3 & io_in_a_bits_address[0], ~(io_in_a_bits_address[2]) | mask_eq_3 & ~(io_in_a_bits_address[0]), ~(io_in_a_bits_address[2]) | mask_eq_2 & io_in_a_bits_address[0], ~(io_in_a_bits_address[2]) | mask_eq_2 & ~(io_in_a_bits_address[0])} == 8'hF;
  wire        _GEN_0 = {io_in_a_bits_address[28:14], ~(io_in_a_bits_address[13:12])} == 17'h0 | {io_in_a_bits_address[28:15], io_in_a_bits_address[13:12]} == 16'h0 | {io_in_a_bits_address[28:21], io_in_a_bits_address[20:17] ^ 4'h8, io_in_a_bits_address[15:12]} == 16'h0 | {io_in_a_bits_address[28:26], io_in_a_bits_address[25:16] ^ 10'h200} == 13'h0 | {io_in_a_bits_address[28:26], io_in_a_bits_address[25:12] ^ 14'h2010} == 17'h0 | {io_in_a_bits_address[28], ~(io_in_a_bits_address[27:26])} == 3'h0 | io_in_a_bits_address[28:12] == 17'h10020;
  wire        _GEN_1 = io_in_d_bits_opcode != 3'h7;
  wire        d_release_ack = io_in_d_bits_opcode == 3'h6;
  wire        _GEN_2 = io_in_d_bits_size > 4'h2;
  wire        _GEN_3 = io_in_d_bits_param != 2'h3;
  wire        _GEN_4 = io_in_d_bits_param != 2'h2;
  wire        _GEN_5 = ~io_in_d_bits_denied | io_in_d_bits_corrupt;
  wire        _GEN_6 = io_in_d_bits_opcode == 3'h0;
  wire        _a_first_T_1 = io_in_a_ready & io_in_a_valid;
  reg  [8:0]  a_first_counter;
  reg  [2:0]  opcode;
  reg  [2:0]  param;
  reg  [3:0]  size;
  reg         source;
  reg  [28:0] address;
  wire        _GEN_7 = size == 4'h2;
  wire        _GEN_8 = io_in_a_bits_address == address;
  reg  [8:0]  d_first_counter;
  reg  [2:0]  opcode_1;
  reg  [1:0]  param_1;
  reg  [3:0]  size_1;
  reg         source_1;
  reg         sink;
  reg         denied;
  wire        _GEN_9 = io_in_d_bits_opcode == opcode_1;
  wire        _GEN_10 = io_in_d_bits_param == param_1;
  wire        _GEN_11 = io_in_d_bits_size == size_1;
  wire        _GEN_12 = io_in_d_bits_sink == sink;
  wire        _GEN_13 = io_in_d_bits_denied == denied;
  reg         inflight;
  reg  [3:0]  inflight_opcodes;
  reg  [7:0]  inflight_sizes;
  reg  [8:0]  a_first_counter_1;
  wire        a_first_1 = a_first_counter_1 == 9'h0;
  reg  [8:0]  d_first_counter_1;
  wire        d_first_1 = d_first_counter_1 == 9'h0;
  wire        _same_cycle_resp_T_1 = io_in_a_valid & a_first_1;
  wire        _GEN_14 = _a_first_T_1 & a_first_1;
  wire        _GEN_15 = io_in_d_valid & d_first_1;
  wire        _GEN_16 = _GEN_15 & ~d_release_ack;
  wire        _GEN_17 = inflight | _same_cycle_resp_T_1;
  wire        _GEN_18 = io_in_d_bits_size == 4'h2;
  wire        _GEN_19 = inflight_opcodes[3:1] == 3'h4 | inflight_opcodes[3:1] == 3'h3 | inflight_opcodes[3:1] == 3'h2;
  wire        _GEN_20 = inflight_opcodes[3:1] == 3'h5;
  wire        _GEN_21 = inflight_opcodes[3:1] == 3'h6;
  wire        _GEN_22 = io_in_d_bits_opcode == ((&(inflight_opcodes[3:1])) | _GEN_21 ? 3'h4 : _GEN_20 ? 3'h2 : {2'h0, _GEN_19}) | io_in_d_bits_opcode == ((&(inflight_opcodes[3:1])) ? 3'h4 : _GEN_21 ? 3'h5 : _GEN_20 ? 3'h2 : {2'h0, _GEN_19});
  wire [7:0]  _GEN_23 = {4'h0, io_in_d_bits_size};
  wire        _GEN_24 = _GEN_23 == {1'h0, inflight_sizes[7:1]};
  wire        _GEN_25 = _same_cycle_resp_T_1 != _GEN_16 | ~_same_cycle_resp_T_1;
  reg  [31:0] watchdog;
  wire        _GEN_26 = ~inflight | _plusarg_reader_out == 32'h0 | watchdog < _plusarg_reader_out;
  reg         inflight_1;
  reg  [7:0]  inflight_sizes_1;
  reg  [8:0]  d_first_counter_2;
  wire        d_first_2 = d_first_counter_2 == 9'h0;
  wire        _GEN_27 = io_in_d_valid & d_first_2 & d_release_ack;
  wire        _GEN_28 = _GEN_23 == {1'h0, inflight_sizes_1[7:1]};
  reg  [31:0] watchdog_1;
  wire        _GEN_29 = ~inflight_1 | _plusarg_reader_1_out == 32'h0 | watchdog_1 < _plusarg_reader_1_out;
  wire        _GEN_30 = io_in_a_valid & ~reset;
  wire        _GEN_31 = io_in_d_valid & ~reset;
  wire        _GEN_32 = io_in_d_valid & d_release_ack & ~reset;
  wire        _GEN_33 = io_in_d_valid & io_in_d_bits_opcode == 3'h4 & ~reset;
  wire        _GEN_34 = io_in_d_valid & io_in_d_bits_opcode == 3'h5 & ~reset;
  wire        _GEN_35 = io_in_d_valid & _GEN_6 & ~reset;
  wire        _GEN_36 = io_in_d_valid & io_in_d_bits_opcode == 3'h1 & ~reset;
  wire        _GEN_37 = io_in_d_valid & io_in_d_bits_opcode == 3'h2 & ~reset;
  wire        _GEN_38 = io_in_a_valid & (|a_first_counter) & ~reset;
  wire        _GEN_39 = io_in_d_valid & (|d_first_counter) & ~reset;
  wire        _GEN_40 = _GEN_14 & ~reset;
  wire        _GEN_41 = _GEN_16 & ~reset;
  wire        _GEN_42 = _GEN_16 & _same_cycle_resp_T_1 & ~reset;
  wire        _GEN_43 = _GEN_16 & ~_same_cycle_resp_T_1 & ~reset;
  wire        _GEN_44 = _GEN_15 & a_first_1 & io_in_a_valid & ~d_release_ack & ~reset;
  wire        _GEN_45 = _GEN_27 & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_30 & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries PutFull type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_30 & (|(io_in_a_bits_address[1:0])))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_30 & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull contains invalid mask (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_31 & ~_GEN_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel has invalid opcode (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_32 & ~_GEN_2)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck smaller than a beat (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_32 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseeAck carries invalid param (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_32 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck is corrupt (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_32 & io_in_d_bits_denied)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck is denied (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_33)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid sink ID (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_33 & ~_GEN_2)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant smaller than a beat (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_33 & ~_GEN_3)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid cap param (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_33 & ~_GEN_4)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries toN param (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_33 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant is corrupt (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_34)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid sink ID (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_34 & ~_GEN_2)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData smaller than a beat (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_34 & ~_GEN_3)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid cap param (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_34 & ~_GEN_4)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries toN param (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_34 & ~_GEN_5)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData is denied but not corrupt (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_35 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck carries invalid param (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_35 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck is corrupt (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_36 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData carries invalid param (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_36 & ~_GEN_5)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData is denied but not corrupt (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_37 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck carries invalid param (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_37 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck is corrupt (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_38 & (|opcode))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel opcode changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_38 & (|param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel param changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_38 & ~_GEN_7)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel size changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_38 & source)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel source changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_38 & ~_GEN_8)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel address changed with multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_39 & ~_GEN_9)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel opcode changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_39 & ~_GEN_10)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel param changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_39 & ~_GEN_11)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel size changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_39 & source_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel source changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_39 & ~_GEN_12)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel sink changed with multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_39 & ~_GEN_13)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel denied changed with multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_40 & inflight)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel re-used a source ID (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_41 & ~_GEN_17)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_42 & ~_GEN_6)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_42 & ~_GEN_18)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_43 & ~_GEN_22)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_43 & ~_GEN_24)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_44 & ~io_in_a_ready)
        $fwrite(32'h80000002, "Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_25)
        $fwrite(32'h80000002, "Assertion failed: 'A' and 'D' concurrent, despite minlatency 2 (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_26)
        $fwrite(32'h80000002, "Assertion failed: TileLink timeout expired (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_45 & ~inflight_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_45 & ~_GEN_28)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_29)
        $fwrite(32'h80000002, "Assertion failed: TileLink timeout expired (connected at generators/rocket-chip/src/main/scala/tilelink/BusWrapper.scala:90:33)\n    at Monitor.scala:42 assert(cond, message)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire [26:0] _GEN_46 = {23'h0, io_in_d_bits_size};
  wire [26:0] _d_first_beats1_decode_T_1 = 27'hFFF << _GEN_46;
  wire [26:0] _d_first_beats1_decode_T_5 = 27'hFFF << _GEN_46;
  wire [26:0] _d_first_beats1_decode_T_9 = 27'hFFF << _GEN_46;
  wire        _GEN_47 = _a_first_T_1 & ~(|a_first_counter);
  wire        _GEN_48 = io_in_d_valid & ~(|d_first_counter);
  always @(posedge clock) begin
    if (_GEN_30) begin
      assert__assert_26: assert(_GEN_0);
      assert__assert_28: assert(~(|(io_in_a_bits_address[1:0])));
      assert__assert_30: assert(_GEN);
    end
    if (_GEN_31)
      assert__assert_52: assert(_GEN_1);
    if (_GEN_32) begin
      assert__assert_54: assert(_GEN_2);
      assert__assert_55: assert(~(|io_in_d_bits_param));
      assert__assert_56: assert(~io_in_d_bits_corrupt);
      assert__assert_57: assert(~io_in_d_bits_denied);
    end
    if (_GEN_33) begin
      assert__assert_59: assert(1'h0);
      assert__assert_60: assert(_GEN_2);
      assert__assert_61: assert(_GEN_3);
      assert__assert_62: assert(_GEN_4);
      assert__assert_63: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_34) begin
      assert__assert_66: assert(1'h0);
      assert__assert_67: assert(_GEN_2);
      assert__assert_68: assert(_GEN_3);
      assert__assert_69: assert(_GEN_4);
      assert__assert_70: assert(_GEN_5);
    end
    if (_GEN_35) begin
      assert__assert_73: assert(~(|io_in_d_bits_param));
      assert__assert_74: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_36) begin
      assert__assert_77: assert(~(|io_in_d_bits_param));
      assert__assert_78: assert(_GEN_5);
    end
    if (_GEN_37) begin
      assert__assert_81: assert(~(|io_in_d_bits_param));
      assert__assert_82: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_38) begin
      assert__assert_87: assert(~(|opcode));
      assert__assert_88: assert(~(|param));
      assert__assert_89: assert(_GEN_7);
      assert__assert_90: assert(~source);
      assert__assert_91: assert(_GEN_8);
    end
    if (_GEN_39) begin
      assert__assert_92: assert(_GEN_9);
      assert__assert_93: assert(_GEN_10);
      assert__assert_94: assert(_GEN_11);
      assert__assert_95: assert(~source_1);
      assert__assert_96: assert(_GEN_12);
      assert__assert_97: assert(_GEN_13);
    end
    if (_GEN_40)
      assert__assert_98: assert(~inflight);
    if (_GEN_41)
      assert__assert_99: assert(_GEN_17);
    if (_GEN_42) begin
      assert__assert_100: assert(_GEN_6);
      assert__assert_101: assert(_GEN_18);
    end
    if (_GEN_43) begin
      assert__assert_102: assert(_GEN_22);
      assert__assert_103: assert(_GEN_24);
    end
    if (_GEN_44)
      assert__assert_104: assert(io_in_a_ready);
    if (~reset) begin
      assert__assert_105: assert(_GEN_25);
      assert__assert_106: assert(_GEN_26);
    end
    if (_GEN_45) begin
      assert__assert_108: assert(inflight_1);
      assert__assert_110: assert(_GEN_28);
    end
    if (~reset)
      assert__assert_113: assert(_GEN_29);
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
        else
          a_first_counter <= 9'h0;
        if (a_first_1)
          a_first_counter_1 <= 9'h0;
        else
          a_first_counter_1 <= a_first_counter_1 - 9'h1;
      end
      if (io_in_d_valid) begin
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
      inflight <= (inflight | _GEN_14) & ~_GEN_16;
      inflight_opcodes <= (inflight_opcodes | (_GEN_14 ? {3'h0, _GEN_14} : 4'h0)) & ~{4{_GEN_16}};
      inflight_sizes <= (inflight_sizes | (_GEN_14 ? {3'h0, _GEN_14 ? 5'h5 : 5'h0} : 8'h0)) & ~{8{_GEN_16}};
      if (_a_first_T_1 | io_in_d_valid)
        watchdog <= 32'h0;
      else
        watchdog <= watchdog + 32'h1;
      inflight_1 <= inflight_1 & ~_GEN_27;
      inflight_sizes_1 <= inflight_sizes_1 & ~{8{_GEN_27}};
    end
    if (_GEN_47) begin
      opcode <= 3'h0;
      param <= 3'h0;
      size <= 4'h2;
      address <= io_in_a_bits_address;
    end
    source <= ~_GEN_47 & source;
    if (_GEN_48) begin
      opcode_1 <= io_in_d_bits_opcode;
      param_1 <= io_in_d_bits_param;
      size_1 <= io_in_d_bits_size;
      sink <= io_in_d_bits_sink;
      denied <= io_in_d_bits_denied;
    end
    source_1 <= ~_GEN_48 & source_1;
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

