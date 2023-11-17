// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module HellaCacheArbiter(
  input         io_requestor_0_req_valid,
  input  [39:0] io_requestor_0_req_bits_addr,
  input         io_requestor_0_s1_kill,
                io_mem_req_ready,
                io_mem_s2_nack,
                io_mem_resp_valid,
  input  [63:0] io_mem_resp_bits_data,
  input         io_mem_s2_xcpt_ae_ld,
  output        io_requestor_0_req_ready,
                io_requestor_0_s2_nack,
                io_requestor_0_resp_valid,
  output [63:0] io_requestor_0_resp_bits_data,
  output        io_requestor_0_s2_xcpt_ae_ld,
                io_mem_req_valid,
  output [39:0] io_mem_req_bits_addr,
  output        io_mem_s1_kill
);

  assign io_requestor_0_req_ready = io_mem_req_ready;
  assign io_requestor_0_s2_nack = io_mem_s2_nack;
  assign io_requestor_0_resp_valid = io_mem_resp_valid;
  assign io_requestor_0_resp_bits_data = io_mem_resp_bits_data;
  assign io_requestor_0_s2_xcpt_ae_ld = io_mem_s2_xcpt_ae_ld;
  assign io_mem_req_valid = io_requestor_0_req_valid;
  assign io_mem_req_bits_addr = io_requestor_0_req_bits_addr;
  assign io_mem_s1_kill = io_requestor_0_s1_kill;
endmodule

