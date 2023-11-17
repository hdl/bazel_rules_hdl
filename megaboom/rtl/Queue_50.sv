// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_50(
  input         clock,
                reset,
                io_enq_valid,
  input  [4:0]  io_enq_bits_id,
  input  [31:0] io_enq_bits_addr,
  input  [7:0]  io_enq_bits_len,
  input  [2:0]  io_enq_bits_size,
  input  [3:0]  io_enq_bits_echo_tl_state_size,
  input  [4:0]  io_enq_bits_echo_tl_state_source,
  input         io_enq_bits_wen,
                io_deq_ready,
  output        io_enq_ready,
                io_deq_valid,
  output [4:0]  io_deq_bits_id,
  output [31:0] io_deq_bits_addr,
  output [7:0]  io_deq_bits_len,
  output [2:0]  io_deq_bits_size,
  output [1:0]  io_deq_bits_burst,
  output        io_deq_bits_lock,
  output [3:0]  io_deq_bits_cache,
  output [2:0]  io_deq_bits_prot,
  output [3:0]  io_deq_bits_qos,
                io_deq_bits_echo_tl_state_size,
  output [4:0]  io_deq_bits_echo_tl_state_source,
  output        io_deq_bits_wen
);

  reg         full;
  reg         ram_wen;
  reg  [4:0]  ram_echo_tl_state_source;
  reg  [3:0]  ram_echo_tl_state_size;
  reg  [3:0]  ram_qos;
  reg  [2:0]  ram_prot;
  reg  [3:0]  ram_cache;
  reg         ram_lock;
  reg  [1:0]  ram_burst;
  reg  [2:0]  ram_size;
  reg  [7:0]  ram_len;
  reg  [31:0] ram_addr;
  reg  [4:0]  ram_id;
  wire        _io_enq_ready_output = io_deq_ready | ~full;
  wire        do_enq = _io_enq_ready_output & io_enq_valid;
  always @(posedge clock) begin
    if (reset)
      full <= 1'h0;
    else if (do_enq != (io_deq_ready & full))
      full <= do_enq;
    if (do_enq) begin
      ram_wen <= io_enq_bits_wen;
      ram_echo_tl_state_source <= io_enq_bits_echo_tl_state_source;
      ram_echo_tl_state_size <= io_enq_bits_echo_tl_state_size;
      ram_qos <= 4'h0;
      ram_prot <= 3'h1;
      ram_cache <= 4'h0;
      ram_burst <= 2'h1;
      ram_size <= io_enq_bits_size;
      ram_len <= io_enq_bits_len;
      ram_addr <= io_enq_bits_addr;
      ram_id <= io_enq_bits_id;
    end
    ram_lock <= ~do_enq & ram_lock;
  end // always @(posedge)
  assign io_enq_ready = _io_enq_ready_output;
  assign io_deq_valid = full;
  assign io_deq_bits_id = ram_id;
  assign io_deq_bits_addr = ram_addr;
  assign io_deq_bits_len = ram_len;
  assign io_deq_bits_size = ram_size;
  assign io_deq_bits_burst = ram_burst;
  assign io_deq_bits_lock = ram_lock;
  assign io_deq_bits_cache = ram_cache;
  assign io_deq_bits_prot = ram_prot;
  assign io_deq_bits_qos = ram_qos;
  assign io_deq_bits_echo_tl_state_size = ram_echo_tl_state_size;
  assign io_deq_bits_echo_tl_state_source = ram_echo_tl_state_source;
  assign io_deq_bits_wen = ram_wen;
endmodule

