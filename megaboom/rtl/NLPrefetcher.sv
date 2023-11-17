// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module NLPrefetcher(
  input         clock,
                reset,
                io_mshr_avail,
                io_req_val,
  input  [39:0] io_req_addr,
  input  [1:0]  io_req_coh_state,
  input         io_prefetch_ready,
  output        io_prefetch_valid,
  output [4:0]  io_prefetch_bits_uop_mem_cmd,
  output [39:0] io_prefetch_bits_addr
);

  reg         req_valid;
  reg  [39:0] req_addr;
  reg  [4:0]  req_cmd;
  wire        _io_prefetch_valid_output = req_valid & io_mshr_avail;
  wire [39:0] _mshr_req_addr_T = io_req_addr + 40'h40;
  wire        _GEN = io_req_val & {_mshr_req_addr_T[39:32], _mshr_req_addr_T[31:28] ^ 4'h8} == 12'h0;
  always @(posedge clock) begin
    if (reset)
      req_valid <= 1'h0;
    else
      req_valid <= _GEN | ~(io_prefetch_ready & _io_prefetch_valid_output) & req_valid;
    if (_GEN) begin
      req_addr <= _mshr_req_addr_T;
      req_cmd <= {4'h1, io_req_coh_state[1]};
    end
  end // always @(posedge)
  assign io_prefetch_valid = _io_prefetch_valid_output;
  assign io_prefetch_bits_uop_mem_cmd = req_cmd;
  assign io_prefetch_bits_addr = req_addr;
endmodule

