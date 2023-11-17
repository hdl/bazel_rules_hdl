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
module TLMonitor_29_assert(
  input [16:0] io_in_a_bits_address,
  input [2:0]  io_in_a_bits_size,
  input [6:0]  io_in_a_bits_source,
  input [2:0]  io_in_a_bits_param,
  input [7:0]  io_in_a_bits_mask,
  input        io_in_a_bits_corrupt,
  input [6:0]  io_in_d_bits_source,
  input [2:0]  io_in_a_bits_opcode,
  input        clock,
               reset,
               io_in_a_ready,
               io_in_a_valid,
  input [2:0]  io_in_d_bits_size,
  input        io_in_d_ready,
               io_in_d_valid
);

  wire [31:0]   _plusarg_reader_out;
  wire          _source_ok_WIRE__2 = io_in_a_bits_source == 7'h9;
  wire          _source_ok_WIRE__3 = io_in_a_bits_source == 7'h10;
  wire          _source_ok_WIRE__4 = io_in_a_bits_source == 7'h40;
  wire          source_ok = io_in_a_bits_source[6:4] == 3'h2 | ~(|(io_in_a_bits_source[6:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2 | _source_ok_WIRE__3 | _source_ok_WIRE__4;
  wire [12:0]   _is_aligned_mask_T_1 = 13'h3F << io_in_a_bits_size;
  wire [5:0]    _GEN = io_in_a_bits_address[5:0] & ~(_is_aligned_mask_T_1[5:0]);
  wire          _mask_T = io_in_a_bits_size > 3'h2;
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
  wire          _GEN_0 = io_in_a_bits_opcode == 3'h6;
  wire          _GEN_1 = io_in_a_bits_size == 3'h6;
  wire          _GEN_2 = ~(|(io_in_a_bits_source[6:4])) & io_in_a_bits_source[3:0] < 4'h9 & _GEN_1 & io_in_a_bits_address[16];
  wire          _GEN_3 = io_in_a_bits_param < 3'h3;
  wire          _GEN_4 = io_in_a_bits_mask != 8'hFF;
  wire          _GEN_5 = ~(|(io_in_a_bits_source[6:4])) & io_in_a_bits_source[3:0] < 4'h9 & _GEN_1 & io_in_a_bits_address[16];
  wire          _GEN_6 = io_in_a_bits_opcode == 3'h4;
  wire          _GEN_7 = io_in_a_bits_source[6:4] == 3'h2 | ~(|(io_in_a_bits_source[6:4])) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__2 | _source_ok_WIRE__3 | _source_ok_WIRE__4;
  wire          _GEN_8 = io_in_a_bits_size != 3'h7 & io_in_a_bits_address[16];
  wire          _GEN_9 = io_in_a_bits_mask == mask;
  wire [7:0]    _GEN_10 = io_in_a_bits_mask & ~mask;
  wire          _GEN_11 = io_in_a_bits_opcode == 3'h2;
  wire          _GEN_12 = io_in_a_bits_param < 3'h5;
  wire          _GEN_13 = io_in_a_bits_opcode == 3'h3;
  wire          _GEN_14 = io_in_a_bits_opcode == 3'h5;
  wire          _GEN_15 = io_in_a_bits_param < 3'h2;
  wire          source_ok_1 = io_in_d_bits_source[6:4] == 3'h2 | io_in_d_bits_source[6:4] == 3'h0 & io_in_d_bits_source[3:0] < 4'h9 | io_in_d_bits_source == 7'h9 | io_in_d_bits_source == 7'h10 | io_in_d_bits_source == 7'h40;
  wire          a_first_done = io_in_a_ready & io_in_a_valid;
  reg  [2:0]    a_first_counter;
  reg  [2:0]    opcode;
  reg  [2:0]    param;
  reg  [2:0]    size;
  reg  [6:0]    source;
  reg  [16:0]   address;
  wire          _GEN_16 = io_in_a_bits_opcode == opcode;
  wire          _GEN_17 = io_in_a_bits_param == param;
  wire          _GEN_18 = io_in_a_bits_size == size;
  wire          _GEN_19 = io_in_a_bits_source == source;
  wire          _GEN_20 = io_in_a_bits_address == address;
  reg  [2:0]    d_first_counter;
  reg  [2:0]    opcode_1;
  reg  [1:0]    param_1;
  reg  [2:0]    size_1;
  reg  [6:0]    source_1;
  reg           sink;
  reg           denied;
  wire          _GEN_21 = opcode_1 == 3'h1;
  wire          _GEN_22 = io_in_d_bits_size == size_1;
  wire          _GEN_23 = io_in_d_bits_source == source_1;
  reg  [64:0]   inflight;
  reg  [259:0]  inflight_opcodes;
  reg  [259:0]  inflight_sizes;
  reg  [2:0]    a_first_counter_1;
  wire          a_first_1 = a_first_counter_1 == 3'h0;
  reg  [2:0]    d_first_counter_1;
  wire          d_first_1 = d_first_counter_1 == 3'h0;
  wire [259:0]  _GEN_24 = {251'h0, io_in_d_bits_source, 2'h0};
  wire [259:0]  _a_opcode_lookup_T_1 = inflight_opcodes >> _GEN_24;
  wire [259:0]  _a_size_lookup_T_1 = inflight_sizes >> _GEN_24;
  wire          _GEN_25 = a_first_done & a_first_1;
  wire [64:0]   _GEN_26 = inflight >> io_in_a_bits_source;
  wire          _GEN_27 = io_in_d_valid & d_first_1;
  wire          _same_cycle_resp_T_2 = io_in_a_bits_source == io_in_d_bits_source;
  wire          same_cycle_resp = io_in_a_valid & a_first_1 & _same_cycle_resp_T_2;
  wire [64:0]   _GEN_28 = inflight >> io_in_d_bits_source;
  wire          _GEN_29 = _GEN_28[0] | same_cycle_resp;
  wire          _GEN_30 = _GEN_6 | _GEN_13 | _GEN_11;
  wire          _GEN_31 = ((&io_in_a_bits_opcode) | _GEN_0 ? 3'h4 : _GEN_14 ? 3'h2 : {2'h0, _GEN_30}) == 3'h1 | ((&io_in_a_bits_opcode) ? 3'h4 : _GEN_0 ? 3'h5 : _GEN_14 ? 3'h2 : {2'h0, _GEN_30}) == 3'h1;
  wire          _GEN_32 = io_in_a_bits_size == io_in_d_bits_size;
  wire          _GEN_33 = _a_opcode_lookup_T_1[3:1] == 3'h4 | _a_opcode_lookup_T_1[3:1] == 3'h3 | _a_opcode_lookup_T_1[3:1] == 3'h2;
  wire          _GEN_34 = _a_opcode_lookup_T_1[3:1] == 3'h5;
  wire          _GEN_35 = _a_opcode_lookup_T_1[3:1] == 3'h6;
  wire          _GEN_36 = ((&(_a_opcode_lookup_T_1[3:1])) | _GEN_35 ? 3'h4 : _GEN_34 ? 3'h2 : {2'h0, _GEN_33}) == 3'h1 | ((&(_a_opcode_lookup_T_1[3:1])) ? 3'h4 : _GEN_35 ? 3'h5 : _GEN_34 ? 3'h2 : {2'h0, _GEN_33}) == 3'h1;
  wire          _GEN_37 = io_in_d_bits_size == _a_size_lookup_T_1[3:1];
  wire          _GEN_38 = ~io_in_d_ready | io_in_a_ready;
  reg  [31:0]   watchdog;
  wire          _GEN_39 = inflight == 65'h0 | _plusarg_reader_out == 32'h0 | watchdog < _plusarg_reader_out;
  wire          _GEN_40 = io_in_a_valid & _GEN_0 & ~reset;
  wire          _GEN_41 = io_in_a_valid & (&io_in_a_bits_opcode) & ~reset;
  wire          _GEN_42 = io_in_a_valid & _GEN_6 & ~reset;
  wire          _GEN_43 = io_in_a_valid & io_in_a_bits_opcode == 3'h0 & ~reset;
  wire          _GEN_44 = io_in_a_valid & io_in_a_bits_opcode == 3'h1 & ~reset;
  wire          _GEN_45 = io_in_a_valid & _GEN_11 & ~reset;
  wire          _GEN_46 = io_in_a_valid & _GEN_13 & ~reset;
  wire          _GEN_47 = io_in_a_valid & _GEN_14 & ~reset;
  wire          _GEN_48 = io_in_d_valid & ~reset;
  wire          _GEN_49 = io_in_a_valid & (|a_first_counter) & ~reset;
  wire          _GEN_50 = io_in_d_valid & (|d_first_counter) & ~reset;
  wire          _GEN_51 = _GEN_25 & ~reset;
  wire          _GEN_52 = _GEN_27 & ~reset;
  wire          _GEN_53 = _GEN_27 & same_cycle_resp & ~reset;
  wire          _GEN_54 = _GEN_27 & ~same_cycle_resp & ~reset;
  wire          _GEN_55 = _GEN_27 & a_first_1 & io_in_a_valid & _same_cycle_resp_T_2 & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_40)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquireBlock type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_40 & ~_GEN_2)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquireBlock from a client which does not support Probe (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_40 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock carries invalid source ID (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_40 & ~_mask_T)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock smaller than a beat (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_40 & (|_GEN))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock address not aligned to size (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_40 & ~_GEN_3)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock carries invalid grow param (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_40 & _GEN_4)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock contains invalid mask (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_40 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock is corrupt (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_41)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquirePerm type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_41 & ~_GEN_5)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquirePerm from a client which does not support Probe (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_41 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm carries invalid source ID (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_41 & ~_mask_T)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm smaller than a beat (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_41 & (|_GEN))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm address not aligned to size (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_41 & ~_GEN_3)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm carries invalid grow param (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_41 & ~(|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm requests NtoB (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_41 & _GEN_4)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm contains invalid mask (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_41 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm is corrupt (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_42 & ~_GEN_7)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Get type which master claims it can't emit (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_42 & ~_GEN_8)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Get type which slave claims it can't support (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_42 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get carries invalid source ID (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_42 & (|_GEN))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get address not aligned to size (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_42 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get carries invalid param (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_42 & ~_GEN_9)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get contains invalid mask (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_42 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get is corrupt (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_43)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries PutFull type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_43 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull carries invalid source ID (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_43 & (|_GEN))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull address not aligned to size (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_43 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull carries invalid param (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_43 & ~_GEN_9)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull contains invalid mask (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_44)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries PutPartial type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_44 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial carries invalid source ID (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_44 & (|_GEN))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial address not aligned to size (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_44 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial carries invalid param (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_44 & (|_GEN_10))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial contains invalid mask (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_45)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Arithmetic type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_45 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic carries invalid source ID (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_45 & (|_GEN))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic address not aligned to size (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_45 & ~_GEN_12)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic carries invalid opcode param (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_45 & ~_GEN_9)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic contains invalid mask (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_46)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Logical type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_46 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical carries invalid source ID (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_46 & (|_GEN))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical address not aligned to size (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_46 & io_in_a_bits_param[2])
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical carries invalid opcode param (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_46 & ~_GEN_9)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical contains invalid mask (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_47)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Hint type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_47 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint carries invalid source ID (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_47 & (|_GEN))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint address not aligned to size (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_47 & ~_GEN_15)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint carries invalid opcode param (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_47 & ~_GEN_9)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint contains invalid mask (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_47 & io_in_a_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint is corrupt (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_48 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData carries invalid source ID (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_49 & ~_GEN_16)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel opcode changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_49 & ~_GEN_17)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel param changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_49 & ~_GEN_18)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel size changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_49 & ~_GEN_19)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel source changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_49 & ~_GEN_20)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel address changed with multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_50 & ~_GEN_21)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel opcode changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_50 & (|param_1))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel param changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_50 & ~_GEN_22)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel size changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_50 & ~_GEN_23)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel source changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_50 & sink)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel sink changed with multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_50 & denied)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel denied changed with multibeat operation (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_51 & _GEN_26[0])
        $fwrite(32'h80000002, "Assertion failed: 'A' channel re-used a source ID (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_52 & ~_GEN_29)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_53 & ~_GEN_31)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_53 & ~_GEN_32)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_54 & ~_GEN_36)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_54 & ~_GEN_37)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_55 & ~_GEN_38)
        $fwrite(32'h80000002, "Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_39)
        $fwrite(32'h80000002, "Assertion failed: TileLink timeout expired (connected at generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:86:68)\n    at Monitor.scala:42 assert(cond, message)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire [12:0]   _GEN_56 = {10'h0, io_in_d_bits_size};
  wire [12:0]   _d_first_beats1_decode_T_1 = 13'h3F << _GEN_56;
  wire [12:0]   _d_first_beats1_decode_T_5 = 13'h3F << _GEN_56;
  wire [1026:0] _GEN_57 = {1018'h0, io_in_a_bits_source, 2'h0};
  wire [1038:0] _GEN_58 = {1030'h0, io_in_d_bits_source, 2'h0};
  wire [127:0]  _d_clr_T_1 = 128'h1 << io_in_d_bits_source;
  wire [127:0]  _a_set_T = 128'h1 << io_in_a_bits_source;
  wire [1038:0] _d_opcodes_clr_T_5 = 1039'hF << _GEN_58;
  wire [1026:0] _a_opcodes_set_T_1 = {1023'h0, _GEN_25 ? {io_in_a_bits_opcode, 1'h1} : 4'h0} << _GEN_57;
  wire [1038:0] _d_sizes_clr_T_5 = 1039'hF << _GEN_58;
  wire [1026:0] _a_sizes_set_T_1 = {1023'h0, _GEN_25 ? {io_in_a_bits_size, 1'h1} : 4'h0} << _GEN_57;
  wire          _d_first_T_2 = io_in_d_ready & io_in_d_valid;
  wire          _GEN_59 = _d_first_T_2 & ~(|d_first_counter);
  wire          _GEN_60 = _d_first_T_2 & d_first_1;
  always @(posedge clock) begin
    if (_GEN_40) begin
      assert__assert_2: assert(1'h0);
      assert__assert_3: assert(_GEN_2);
      assert__assert_4: assert(source_ok);
      assert__assert_5: assert(_mask_T);
      assert__assert_6: assert(~(|_GEN));
      assert__assert_7: assert(_GEN_3);
      assert__assert_8: assert(~_GEN_4);
      assert__assert_9: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_41) begin
      assert__assert_10: assert(1'h0);
      assert__assert_11: assert(_GEN_5);
      assert__assert_12: assert(source_ok);
      assert__assert_13: assert(_mask_T);
      assert__assert_14: assert(~(|_GEN));
      assert__assert_15: assert(_GEN_3);
      assert__assert_16: assert(|io_in_a_bits_param);
      assert__assert_17: assert(~_GEN_4);
      assert__assert_18: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_42) begin
      assert__assert_19: assert(_GEN_7);
      assert__assert_20: assert(_GEN_8);
      assert__assert_21: assert(source_ok);
      assert__assert_22: assert(~(|_GEN));
      assert__assert_23: assert(~(|io_in_a_bits_param));
      assert__assert_24: assert(_GEN_9);
      assert__assert_25: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_43) begin
      assert__assert_26: assert(1'h0);
      assert__assert_27: assert(source_ok);
      assert__assert_28: assert(~(|_GEN));
      assert__assert_29: assert(~(|io_in_a_bits_param));
      assert__assert_30: assert(_GEN_9);
    end
    if (_GEN_44) begin
      assert__assert_31: assert(1'h0);
      assert__assert_32: assert(source_ok);
      assert__assert_33: assert(~(|_GEN));
      assert__assert_34: assert(~(|io_in_a_bits_param));
      assert__assert_35: assert(~(|_GEN_10));
    end
    if (_GEN_45) begin
      assert__assert_36: assert(1'h0);
      assert__assert_37: assert(source_ok);
      assert__assert_38: assert(~(|_GEN));
      assert__assert_39: assert(_GEN_12);
      assert__assert_40: assert(_GEN_9);
    end
    if (_GEN_46) begin
      assert__assert_41: assert(1'h0);
      assert__assert_42: assert(source_ok);
      assert__assert_43: assert(~(|_GEN));
      assert__assert_44: assert(~(io_in_a_bits_param[2]));
      assert__assert_45: assert(_GEN_9);
    end
    if (_GEN_47) begin
      assert__assert_46: assert(1'h0);
      assert__assert_47: assert(source_ok);
      assert__assert_48: assert(~(|_GEN));
      assert__assert_49: assert(_GEN_15);
      assert__assert_50: assert(_GEN_9);
      assert__assert_51: assert(~io_in_a_bits_corrupt);
    end
    if (_GEN_48)
      assert__assert_76: assert(source_ok_1);
    if (_GEN_49) begin
      assert__assert_87: assert(_GEN_16);
      assert__assert_88: assert(_GEN_17);
      assert__assert_89: assert(_GEN_18);
      assert__assert_90: assert(_GEN_19);
      assert__assert_91: assert(_GEN_20);
    end
    if (_GEN_50) begin
      assert__assert_92: assert(_GEN_21);
      assert__assert_93: assert(~(|param_1));
      assert__assert_94: assert(_GEN_22);
      assert__assert_95: assert(_GEN_23);
      assert__assert_96: assert(~sink);
      assert__assert_97: assert(~denied);
    end
    if (_GEN_51)
      assert__assert_98: assert(~(_GEN_26[0]));
    if (_GEN_52)
      assert__assert_99: assert(_GEN_29);
    if (_GEN_53) begin
      assert__assert_100: assert(_GEN_31);
      assert__assert_101: assert(_GEN_32);
    end
    if (_GEN_54) begin
      assert__assert_102: assert(_GEN_36);
      assert__assert_103: assert(_GEN_37);
    end
    if (_GEN_55)
      assert__assert_104: assert(_GEN_38);
    if (~reset)
      assert__assert_105: assert(_GEN_39);
    if (reset) begin
      a_first_counter <= 3'h0;
      d_first_counter <= 3'h0;
      inflight <= 65'h0;
      inflight_opcodes <= 260'h0;
      inflight_sizes <= 260'h0;
      a_first_counter_1 <= 3'h0;
      d_first_counter_1 <= 3'h0;
      watchdog <= 32'h0;
    end
    else begin
      if (a_first_done) begin
        if (|a_first_counter)
          a_first_counter <= a_first_counter - 3'h1;
        else
          a_first_counter <= 3'h0;
        if (a_first_1)
          a_first_counter_1 <= 3'h0;
        else
          a_first_counter_1 <= a_first_counter_1 - 3'h1;
      end
      if (_d_first_T_2) begin
        if (|d_first_counter)
          d_first_counter <= d_first_counter - 3'h1;
        else
          d_first_counter <= ~(_d_first_beats1_decode_T_1[5:3]);
        if (d_first_1)
          d_first_counter_1 <= ~(_d_first_beats1_decode_T_5[5:3]);
        else
          d_first_counter_1 <= d_first_counter_1 - 3'h1;
      end
      inflight <= (inflight | (_GEN_25 ? _a_set_T[64:0] : 65'h0)) & ~(_GEN_60 ? _d_clr_T_1[64:0] : 65'h0);
      inflight_opcodes <= (inflight_opcodes | (_GEN_25 ? _a_opcodes_set_T_1[259:0] : 260'h0)) & ~(_GEN_60 ? _d_opcodes_clr_T_5[259:0] : 260'h0);
      inflight_sizes <= (inflight_sizes | (_GEN_25 ? _a_sizes_set_T_1[259:0] : 260'h0)) & ~(_GEN_60 ? _d_sizes_clr_T_5[259:0] : 260'h0);
      if (a_first_done | _d_first_T_2)
        watchdog <= 32'h0;
      else
        watchdog <= watchdog + 32'h1;
    end
    if (a_first_done & ~(|a_first_counter)) begin
      opcode <= io_in_a_bits_opcode;
      param <= io_in_a_bits_param;
      size <= io_in_a_bits_size;
      source <= io_in_a_bits_source;
      address <= io_in_a_bits_address;
    end
    if (_GEN_59) begin
      opcode_1 <= 3'h1;
      param_1 <= 2'h0;
      size_1 <= io_in_d_bits_size;
      source_1 <= io_in_d_bits_source;
    end
    sink <= ~_GEN_59 & sink;
    denied <= ~_GEN_59 & denied;
  end // always @(posedge)
  plusarg_reader #(
    .DEFAULT(0),
    .FORMAT("tilelink_timeout=%d"),
    .WIDTH(32)
  ) plusarg_reader (
    .out (_plusarg_reader_out)
  );
endmodule

