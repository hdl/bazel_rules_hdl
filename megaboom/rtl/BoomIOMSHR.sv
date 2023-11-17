// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BoomIOMSHR(
  input          clock,
                 reset,
                 io_req_valid,
  input  [19:0]  io_req_bits_uop_br_mask,
  input  [4:0]   io_req_bits_uop_ldq_idx,
                 io_req_bits_uop_stq_idx,
                 io_req_bits_uop_mem_cmd,
  input  [1:0]   io_req_bits_uop_mem_size,
  input          io_req_bits_uop_mem_signed,
                 io_req_bits_uop_is_amo,
                 io_req_bits_uop_uses_ldq,
                 io_req_bits_uop_uses_stq,
  input  [39:0]  io_req_bits_addr,
  input  [63:0]  io_req_bits_data,
  input          io_req_bits_is_hella,
                 io_resp_ready,
                 io_mem_access_ready,
                 io_mem_ack_valid,
  input  [127:0] io_mem_ack_bits_data,
  output         io_req_ready,
                 io_resp_valid,
  output [19:0]  io_resp_bits_uop_br_mask,
  output [4:0]   io_resp_bits_uop_ldq_idx,
                 io_resp_bits_uop_stq_idx,
  output         io_resp_bits_uop_is_amo,
                 io_resp_bits_uop_uses_ldq,
                 io_resp_bits_uop_uses_stq,
  output [63:0]  io_resp_bits_data,
  output         io_resp_bits_is_hella,
                 io_mem_access_valid,
  output [2:0]   io_mem_access_bits_opcode,
                 io_mem_access_bits_param,
  output [3:0]   io_mem_access_bits_size,
                 io_mem_access_bits_source,
  output [31:0]  io_mem_access_bits_address,
  output [15:0]  io_mem_access_bits_mask,
  output [127:0] io_mem_access_bits_data
);

  reg  [19:0]  req_uop_br_mask;
  reg  [4:0]   req_uop_ldq_idx;
  reg  [4:0]   req_uop_stq_idx;
  reg  [4:0]   req_uop_mem_cmd;
  reg  [1:0]   size;
  reg          req_uop_mem_signed;
  reg          req_uop_is_amo;
  reg          req_uop_uses_ldq;
  reg          req_uop_uses_stq;
  reg  [39:0]  req_addr;
  reg  [63:0]  req_data;
  reg          req_is_hella;
  reg  [63:0]  grant_word;
  reg  [1:0]   state;
  wire         _io_req_ready_output = state == 2'h0;
  wire [127:0] a_data = {2{req_data}};
  wire         get_a_mask_acc = (&size) & ~(req_addr[3]);
  wire         get_a_mask_acc_1 = (&size) & req_addr[3];
  wire         get_a_mask_size_1 = size == 2'h2;
  wire         get_a_mask_eq_2 = ~(req_addr[3]) & ~(req_addr[2]);
  wire         get_a_mask_acc_2 = get_a_mask_acc | get_a_mask_size_1 & get_a_mask_eq_2;
  wire         get_a_mask_eq_3 = ~(req_addr[3]) & req_addr[2];
  wire         get_a_mask_acc_3 = get_a_mask_acc | get_a_mask_size_1 & get_a_mask_eq_3;
  wire         get_a_mask_eq_4 = req_addr[3] & ~(req_addr[2]);
  wire         get_a_mask_acc_4 = get_a_mask_acc_1 | get_a_mask_size_1 & get_a_mask_eq_4;
  wire         get_a_mask_eq_5 = req_addr[3] & req_addr[2];
  wire         get_a_mask_acc_5 = get_a_mask_acc_1 | get_a_mask_size_1 & get_a_mask_eq_5;
  wire         get_a_mask_size_2 = size == 2'h1;
  wire         get_a_mask_eq_6 = get_a_mask_eq_2 & ~(req_addr[1]);
  wire         get_a_mask_acc_6 = get_a_mask_acc_2 | get_a_mask_size_2 & get_a_mask_eq_6;
  wire         get_a_mask_eq_7 = get_a_mask_eq_2 & req_addr[1];
  wire         get_a_mask_acc_7 = get_a_mask_acc_2 | get_a_mask_size_2 & get_a_mask_eq_7;
  wire         get_a_mask_eq_8 = get_a_mask_eq_3 & ~(req_addr[1]);
  wire         get_a_mask_acc_8 = get_a_mask_acc_3 | get_a_mask_size_2 & get_a_mask_eq_8;
  wire         get_a_mask_eq_9 = get_a_mask_eq_3 & req_addr[1];
  wire         get_a_mask_acc_9 = get_a_mask_acc_3 | get_a_mask_size_2 & get_a_mask_eq_9;
  wire         get_a_mask_eq_10 = get_a_mask_eq_4 & ~(req_addr[1]);
  wire         get_a_mask_acc_10 = get_a_mask_acc_4 | get_a_mask_size_2 & get_a_mask_eq_10;
  wire         get_a_mask_eq_11 = get_a_mask_eq_4 & req_addr[1];
  wire         get_a_mask_acc_11 = get_a_mask_acc_4 | get_a_mask_size_2 & get_a_mask_eq_11;
  wire         get_a_mask_eq_12 = get_a_mask_eq_5 & ~(req_addr[1]);
  wire         get_a_mask_acc_12 = get_a_mask_acc_5 | get_a_mask_size_2 & get_a_mask_eq_12;
  wire         get_a_mask_eq_13 = get_a_mask_eq_5 & req_addr[1];
  wire         get_a_mask_acc_13 = get_a_mask_acc_5 | get_a_mask_size_2 & get_a_mask_eq_13;
  wire         put_a_mask_acc = (&size) & ~(req_addr[3]);
  wire         put_a_mask_acc_1 = (&size) & req_addr[3];
  wire         put_a_mask_size_1 = size == 2'h2;
  wire         put_a_mask_eq_2 = ~(req_addr[3]) & ~(req_addr[2]);
  wire         put_a_mask_acc_2 = put_a_mask_acc | put_a_mask_size_1 & put_a_mask_eq_2;
  wire         put_a_mask_eq_3 = ~(req_addr[3]) & req_addr[2];
  wire         put_a_mask_acc_3 = put_a_mask_acc | put_a_mask_size_1 & put_a_mask_eq_3;
  wire         put_a_mask_eq_4 = req_addr[3] & ~(req_addr[2]);
  wire         put_a_mask_acc_4 = put_a_mask_acc_1 | put_a_mask_size_1 & put_a_mask_eq_4;
  wire         put_a_mask_eq_5 = req_addr[3] & req_addr[2];
  wire         put_a_mask_acc_5 = put_a_mask_acc_1 | put_a_mask_size_1 & put_a_mask_eq_5;
  wire         put_a_mask_size_2 = size == 2'h1;
  wire         put_a_mask_eq_6 = put_a_mask_eq_2 & ~(req_addr[1]);
  wire         put_a_mask_acc_6 = put_a_mask_acc_2 | put_a_mask_size_2 & put_a_mask_eq_6;
  wire         put_a_mask_eq_7 = put_a_mask_eq_2 & req_addr[1];
  wire         put_a_mask_acc_7 = put_a_mask_acc_2 | put_a_mask_size_2 & put_a_mask_eq_7;
  wire         put_a_mask_eq_8 = put_a_mask_eq_3 & ~(req_addr[1]);
  wire         put_a_mask_acc_8 = put_a_mask_acc_3 | put_a_mask_size_2 & put_a_mask_eq_8;
  wire         put_a_mask_eq_9 = put_a_mask_eq_3 & req_addr[1];
  wire         put_a_mask_acc_9 = put_a_mask_acc_3 | put_a_mask_size_2 & put_a_mask_eq_9;
  wire         put_a_mask_eq_10 = put_a_mask_eq_4 & ~(req_addr[1]);
  wire         put_a_mask_acc_10 = put_a_mask_acc_4 | put_a_mask_size_2 & put_a_mask_eq_10;
  wire         put_a_mask_eq_11 = put_a_mask_eq_4 & req_addr[1];
  wire         put_a_mask_acc_11 = put_a_mask_acc_4 | put_a_mask_size_2 & put_a_mask_eq_11;
  wire         put_a_mask_eq_12 = put_a_mask_eq_5 & ~(req_addr[1]);
  wire         put_a_mask_acc_12 = put_a_mask_acc_5 | put_a_mask_size_2 & put_a_mask_eq_12;
  wire         put_a_mask_eq_13 = put_a_mask_eq_5 & req_addr[1];
  wire         put_a_mask_acc_13 = put_a_mask_acc_5 | put_a_mask_size_2 & put_a_mask_eq_13;
  wire         atomics_a_mask_acc = (&size) & ~(req_addr[3]);
  wire         atomics_a_mask_acc_1 = (&size) & req_addr[3];
  wire         atomics_a_mask_size_1 = size == 2'h2;
  wire         atomics_a_mask_eq_2 = ~(req_addr[3]) & ~(req_addr[2]);
  wire         atomics_a_mask_acc_2 = atomics_a_mask_acc | atomics_a_mask_size_1 & atomics_a_mask_eq_2;
  wire         atomics_a_mask_eq_3 = ~(req_addr[3]) & req_addr[2];
  wire         atomics_a_mask_acc_3 = atomics_a_mask_acc | atomics_a_mask_size_1 & atomics_a_mask_eq_3;
  wire         atomics_a_mask_eq_4 = req_addr[3] & ~(req_addr[2]);
  wire         atomics_a_mask_acc_4 = atomics_a_mask_acc_1 | atomics_a_mask_size_1 & atomics_a_mask_eq_4;
  wire         atomics_a_mask_eq_5 = req_addr[3] & req_addr[2];
  wire         atomics_a_mask_acc_5 = atomics_a_mask_acc_1 | atomics_a_mask_size_1 & atomics_a_mask_eq_5;
  wire         atomics_a_mask_size_2 = size == 2'h1;
  wire         atomics_a_mask_eq_6 = atomics_a_mask_eq_2 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_6 = atomics_a_mask_acc_2 | atomics_a_mask_size_2 & atomics_a_mask_eq_6;
  wire         atomics_a_mask_eq_7 = atomics_a_mask_eq_2 & req_addr[1];
  wire         atomics_a_mask_acc_7 = atomics_a_mask_acc_2 | atomics_a_mask_size_2 & atomics_a_mask_eq_7;
  wire         atomics_a_mask_eq_8 = atomics_a_mask_eq_3 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_8 = atomics_a_mask_acc_3 | atomics_a_mask_size_2 & atomics_a_mask_eq_8;
  wire         atomics_a_mask_eq_9 = atomics_a_mask_eq_3 & req_addr[1];
  wire         atomics_a_mask_acc_9 = atomics_a_mask_acc_3 | atomics_a_mask_size_2 & atomics_a_mask_eq_9;
  wire         atomics_a_mask_eq_10 = atomics_a_mask_eq_4 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_10 = atomics_a_mask_acc_4 | atomics_a_mask_size_2 & atomics_a_mask_eq_10;
  wire         atomics_a_mask_eq_11 = atomics_a_mask_eq_4 & req_addr[1];
  wire         atomics_a_mask_acc_11 = atomics_a_mask_acc_4 | atomics_a_mask_size_2 & atomics_a_mask_eq_11;
  wire         atomics_a_mask_eq_12 = atomics_a_mask_eq_5 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_12 = atomics_a_mask_acc_5 | atomics_a_mask_size_2 & atomics_a_mask_eq_12;
  wire         atomics_a_mask_eq_13 = atomics_a_mask_eq_5 & req_addr[1];
  wire         atomics_a_mask_acc_13 = atomics_a_mask_acc_5 | atomics_a_mask_size_2 & atomics_a_mask_eq_13;
  wire         atomics_a_mask_acc_30 = (&size) & ~(req_addr[3]);
  wire         atomics_a_mask_acc_31 = (&size) & req_addr[3];
  wire         atomics_a_mask_size_5 = size == 2'h2;
  wire         atomics_a_mask_eq_32 = ~(req_addr[3]) & ~(req_addr[2]);
  wire         atomics_a_mask_acc_32 = atomics_a_mask_acc_30 | atomics_a_mask_size_5 & atomics_a_mask_eq_32;
  wire         atomics_a_mask_eq_33 = ~(req_addr[3]) & req_addr[2];
  wire         atomics_a_mask_acc_33 = atomics_a_mask_acc_30 | atomics_a_mask_size_5 & atomics_a_mask_eq_33;
  wire         atomics_a_mask_eq_34 = req_addr[3] & ~(req_addr[2]);
  wire         atomics_a_mask_acc_34 = atomics_a_mask_acc_31 | atomics_a_mask_size_5 & atomics_a_mask_eq_34;
  wire         atomics_a_mask_eq_35 = req_addr[3] & req_addr[2];
  wire         atomics_a_mask_acc_35 = atomics_a_mask_acc_31 | atomics_a_mask_size_5 & atomics_a_mask_eq_35;
  wire         atomics_a_mask_size_6 = size == 2'h1;
  wire         atomics_a_mask_eq_36 = atomics_a_mask_eq_32 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_36 = atomics_a_mask_acc_32 | atomics_a_mask_size_6 & atomics_a_mask_eq_36;
  wire         atomics_a_mask_eq_37 = atomics_a_mask_eq_32 & req_addr[1];
  wire         atomics_a_mask_acc_37 = atomics_a_mask_acc_32 | atomics_a_mask_size_6 & atomics_a_mask_eq_37;
  wire         atomics_a_mask_eq_38 = atomics_a_mask_eq_33 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_38 = atomics_a_mask_acc_33 | atomics_a_mask_size_6 & atomics_a_mask_eq_38;
  wire         atomics_a_mask_eq_39 = atomics_a_mask_eq_33 & req_addr[1];
  wire         atomics_a_mask_acc_39 = atomics_a_mask_acc_33 | atomics_a_mask_size_6 & atomics_a_mask_eq_39;
  wire         atomics_a_mask_eq_40 = atomics_a_mask_eq_34 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_40 = atomics_a_mask_acc_34 | atomics_a_mask_size_6 & atomics_a_mask_eq_40;
  wire         atomics_a_mask_eq_41 = atomics_a_mask_eq_34 & req_addr[1];
  wire         atomics_a_mask_acc_41 = atomics_a_mask_acc_34 | atomics_a_mask_size_6 & atomics_a_mask_eq_41;
  wire         atomics_a_mask_eq_42 = atomics_a_mask_eq_35 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_42 = atomics_a_mask_acc_35 | atomics_a_mask_size_6 & atomics_a_mask_eq_42;
  wire         atomics_a_mask_eq_43 = atomics_a_mask_eq_35 & req_addr[1];
  wire         atomics_a_mask_acc_43 = atomics_a_mask_acc_35 | atomics_a_mask_size_6 & atomics_a_mask_eq_43;
  wire         atomics_a_mask_acc_60 = (&size) & ~(req_addr[3]);
  wire         atomics_a_mask_acc_61 = (&size) & req_addr[3];
  wire         atomics_a_mask_size_9 = size == 2'h2;
  wire         atomics_a_mask_eq_62 = ~(req_addr[3]) & ~(req_addr[2]);
  wire         atomics_a_mask_acc_62 = atomics_a_mask_acc_60 | atomics_a_mask_size_9 & atomics_a_mask_eq_62;
  wire         atomics_a_mask_eq_63 = ~(req_addr[3]) & req_addr[2];
  wire         atomics_a_mask_acc_63 = atomics_a_mask_acc_60 | atomics_a_mask_size_9 & atomics_a_mask_eq_63;
  wire         atomics_a_mask_eq_64 = req_addr[3] & ~(req_addr[2]);
  wire         atomics_a_mask_acc_64 = atomics_a_mask_acc_61 | atomics_a_mask_size_9 & atomics_a_mask_eq_64;
  wire         atomics_a_mask_eq_65 = req_addr[3] & req_addr[2];
  wire         atomics_a_mask_acc_65 = atomics_a_mask_acc_61 | atomics_a_mask_size_9 & atomics_a_mask_eq_65;
  wire         atomics_a_mask_size_10 = size == 2'h1;
  wire         atomics_a_mask_eq_66 = atomics_a_mask_eq_62 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_66 = atomics_a_mask_acc_62 | atomics_a_mask_size_10 & atomics_a_mask_eq_66;
  wire         atomics_a_mask_eq_67 = atomics_a_mask_eq_62 & req_addr[1];
  wire         atomics_a_mask_acc_67 = atomics_a_mask_acc_62 | atomics_a_mask_size_10 & atomics_a_mask_eq_67;
  wire         atomics_a_mask_eq_68 = atomics_a_mask_eq_63 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_68 = atomics_a_mask_acc_63 | atomics_a_mask_size_10 & atomics_a_mask_eq_68;
  wire         atomics_a_mask_eq_69 = atomics_a_mask_eq_63 & req_addr[1];
  wire         atomics_a_mask_acc_69 = atomics_a_mask_acc_63 | atomics_a_mask_size_10 & atomics_a_mask_eq_69;
  wire         atomics_a_mask_eq_70 = atomics_a_mask_eq_64 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_70 = atomics_a_mask_acc_64 | atomics_a_mask_size_10 & atomics_a_mask_eq_70;
  wire         atomics_a_mask_eq_71 = atomics_a_mask_eq_64 & req_addr[1];
  wire         atomics_a_mask_acc_71 = atomics_a_mask_acc_64 | atomics_a_mask_size_10 & atomics_a_mask_eq_71;
  wire         atomics_a_mask_eq_72 = atomics_a_mask_eq_65 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_72 = atomics_a_mask_acc_65 | atomics_a_mask_size_10 & atomics_a_mask_eq_72;
  wire         atomics_a_mask_eq_73 = atomics_a_mask_eq_65 & req_addr[1];
  wire         atomics_a_mask_acc_73 = atomics_a_mask_acc_65 | atomics_a_mask_size_10 & atomics_a_mask_eq_73;
  wire         atomics_a_mask_acc_90 = (&size) & ~(req_addr[3]);
  wire         atomics_a_mask_acc_91 = (&size) & req_addr[3];
  wire         atomics_a_mask_size_13 = size == 2'h2;
  wire         atomics_a_mask_eq_92 = ~(req_addr[3]) & ~(req_addr[2]);
  wire         atomics_a_mask_acc_92 = atomics_a_mask_acc_90 | atomics_a_mask_size_13 & atomics_a_mask_eq_92;
  wire         atomics_a_mask_eq_93 = ~(req_addr[3]) & req_addr[2];
  wire         atomics_a_mask_acc_93 = atomics_a_mask_acc_90 | atomics_a_mask_size_13 & atomics_a_mask_eq_93;
  wire         atomics_a_mask_eq_94 = req_addr[3] & ~(req_addr[2]);
  wire         atomics_a_mask_acc_94 = atomics_a_mask_acc_91 | atomics_a_mask_size_13 & atomics_a_mask_eq_94;
  wire         atomics_a_mask_eq_95 = req_addr[3] & req_addr[2];
  wire         atomics_a_mask_acc_95 = atomics_a_mask_acc_91 | atomics_a_mask_size_13 & atomics_a_mask_eq_95;
  wire         atomics_a_mask_size_14 = size == 2'h1;
  wire         atomics_a_mask_eq_96 = atomics_a_mask_eq_92 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_96 = atomics_a_mask_acc_92 | atomics_a_mask_size_14 & atomics_a_mask_eq_96;
  wire         atomics_a_mask_eq_97 = atomics_a_mask_eq_92 & req_addr[1];
  wire         atomics_a_mask_acc_97 = atomics_a_mask_acc_92 | atomics_a_mask_size_14 & atomics_a_mask_eq_97;
  wire         atomics_a_mask_eq_98 = atomics_a_mask_eq_93 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_98 = atomics_a_mask_acc_93 | atomics_a_mask_size_14 & atomics_a_mask_eq_98;
  wire         atomics_a_mask_eq_99 = atomics_a_mask_eq_93 & req_addr[1];
  wire         atomics_a_mask_acc_99 = atomics_a_mask_acc_93 | atomics_a_mask_size_14 & atomics_a_mask_eq_99;
  wire         atomics_a_mask_eq_100 = atomics_a_mask_eq_94 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_100 = atomics_a_mask_acc_94 | atomics_a_mask_size_14 & atomics_a_mask_eq_100;
  wire         atomics_a_mask_eq_101 = atomics_a_mask_eq_94 & req_addr[1];
  wire         atomics_a_mask_acc_101 = atomics_a_mask_acc_94 | atomics_a_mask_size_14 & atomics_a_mask_eq_101;
  wire         atomics_a_mask_eq_102 = atomics_a_mask_eq_95 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_102 = atomics_a_mask_acc_95 | atomics_a_mask_size_14 & atomics_a_mask_eq_102;
  wire         atomics_a_mask_eq_103 = atomics_a_mask_eq_95 & req_addr[1];
  wire         atomics_a_mask_acc_103 = atomics_a_mask_acc_95 | atomics_a_mask_size_14 & atomics_a_mask_eq_103;
  wire         atomics_a_mask_acc_120 = (&size) & ~(req_addr[3]);
  wire         atomics_a_mask_acc_121 = (&size) & req_addr[3];
  wire         atomics_a_mask_size_17 = size == 2'h2;
  wire         atomics_a_mask_eq_122 = ~(req_addr[3]) & ~(req_addr[2]);
  wire         atomics_a_mask_acc_122 = atomics_a_mask_acc_120 | atomics_a_mask_size_17 & atomics_a_mask_eq_122;
  wire         atomics_a_mask_eq_123 = ~(req_addr[3]) & req_addr[2];
  wire         atomics_a_mask_acc_123 = atomics_a_mask_acc_120 | atomics_a_mask_size_17 & atomics_a_mask_eq_123;
  wire         atomics_a_mask_eq_124 = req_addr[3] & ~(req_addr[2]);
  wire         atomics_a_mask_acc_124 = atomics_a_mask_acc_121 | atomics_a_mask_size_17 & atomics_a_mask_eq_124;
  wire         atomics_a_mask_eq_125 = req_addr[3] & req_addr[2];
  wire         atomics_a_mask_acc_125 = atomics_a_mask_acc_121 | atomics_a_mask_size_17 & atomics_a_mask_eq_125;
  wire         atomics_a_mask_size_18 = size == 2'h1;
  wire         atomics_a_mask_eq_126 = atomics_a_mask_eq_122 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_126 = atomics_a_mask_acc_122 | atomics_a_mask_size_18 & atomics_a_mask_eq_126;
  wire         atomics_a_mask_eq_127 = atomics_a_mask_eq_122 & req_addr[1];
  wire         atomics_a_mask_acc_127 = atomics_a_mask_acc_122 | atomics_a_mask_size_18 & atomics_a_mask_eq_127;
  wire         atomics_a_mask_eq_128 = atomics_a_mask_eq_123 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_128 = atomics_a_mask_acc_123 | atomics_a_mask_size_18 & atomics_a_mask_eq_128;
  wire         atomics_a_mask_eq_129 = atomics_a_mask_eq_123 & req_addr[1];
  wire         atomics_a_mask_acc_129 = atomics_a_mask_acc_123 | atomics_a_mask_size_18 & atomics_a_mask_eq_129;
  wire         atomics_a_mask_eq_130 = atomics_a_mask_eq_124 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_130 = atomics_a_mask_acc_124 | atomics_a_mask_size_18 & atomics_a_mask_eq_130;
  wire         atomics_a_mask_eq_131 = atomics_a_mask_eq_124 & req_addr[1];
  wire         atomics_a_mask_acc_131 = atomics_a_mask_acc_124 | atomics_a_mask_size_18 & atomics_a_mask_eq_131;
  wire         atomics_a_mask_eq_132 = atomics_a_mask_eq_125 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_132 = atomics_a_mask_acc_125 | atomics_a_mask_size_18 & atomics_a_mask_eq_132;
  wire         atomics_a_mask_eq_133 = atomics_a_mask_eq_125 & req_addr[1];
  wire         atomics_a_mask_acc_133 = atomics_a_mask_acc_125 | atomics_a_mask_size_18 & atomics_a_mask_eq_133;
  wire         atomics_a_mask_acc_150 = (&size) & ~(req_addr[3]);
  wire         atomics_a_mask_acc_151 = (&size) & req_addr[3];
  wire         atomics_a_mask_size_21 = size == 2'h2;
  wire         atomics_a_mask_eq_152 = ~(req_addr[3]) & ~(req_addr[2]);
  wire         atomics_a_mask_acc_152 = atomics_a_mask_acc_150 | atomics_a_mask_size_21 & atomics_a_mask_eq_152;
  wire         atomics_a_mask_eq_153 = ~(req_addr[3]) & req_addr[2];
  wire         atomics_a_mask_acc_153 = atomics_a_mask_acc_150 | atomics_a_mask_size_21 & atomics_a_mask_eq_153;
  wire         atomics_a_mask_eq_154 = req_addr[3] & ~(req_addr[2]);
  wire         atomics_a_mask_acc_154 = atomics_a_mask_acc_151 | atomics_a_mask_size_21 & atomics_a_mask_eq_154;
  wire         atomics_a_mask_eq_155 = req_addr[3] & req_addr[2];
  wire         atomics_a_mask_acc_155 = atomics_a_mask_acc_151 | atomics_a_mask_size_21 & atomics_a_mask_eq_155;
  wire         atomics_a_mask_size_22 = size == 2'h1;
  wire         atomics_a_mask_eq_156 = atomics_a_mask_eq_152 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_156 = atomics_a_mask_acc_152 | atomics_a_mask_size_22 & atomics_a_mask_eq_156;
  wire         atomics_a_mask_eq_157 = atomics_a_mask_eq_152 & req_addr[1];
  wire         atomics_a_mask_acc_157 = atomics_a_mask_acc_152 | atomics_a_mask_size_22 & atomics_a_mask_eq_157;
  wire         atomics_a_mask_eq_158 = atomics_a_mask_eq_153 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_158 = atomics_a_mask_acc_153 | atomics_a_mask_size_22 & atomics_a_mask_eq_158;
  wire         atomics_a_mask_eq_159 = atomics_a_mask_eq_153 & req_addr[1];
  wire         atomics_a_mask_acc_159 = atomics_a_mask_acc_153 | atomics_a_mask_size_22 & atomics_a_mask_eq_159;
  wire         atomics_a_mask_eq_160 = atomics_a_mask_eq_154 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_160 = atomics_a_mask_acc_154 | atomics_a_mask_size_22 & atomics_a_mask_eq_160;
  wire         atomics_a_mask_eq_161 = atomics_a_mask_eq_154 & req_addr[1];
  wire         atomics_a_mask_acc_161 = atomics_a_mask_acc_154 | atomics_a_mask_size_22 & atomics_a_mask_eq_161;
  wire         atomics_a_mask_eq_162 = atomics_a_mask_eq_155 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_162 = atomics_a_mask_acc_155 | atomics_a_mask_size_22 & atomics_a_mask_eq_162;
  wire         atomics_a_mask_eq_163 = atomics_a_mask_eq_155 & req_addr[1];
  wire         atomics_a_mask_acc_163 = atomics_a_mask_acc_155 | atomics_a_mask_size_22 & atomics_a_mask_eq_163;
  wire         atomics_a_mask_acc_180 = (&size) & ~(req_addr[3]);
  wire         atomics_a_mask_acc_181 = (&size) & req_addr[3];
  wire         atomics_a_mask_size_25 = size == 2'h2;
  wire         atomics_a_mask_eq_182 = ~(req_addr[3]) & ~(req_addr[2]);
  wire         atomics_a_mask_acc_182 = atomics_a_mask_acc_180 | atomics_a_mask_size_25 & atomics_a_mask_eq_182;
  wire         atomics_a_mask_eq_183 = ~(req_addr[3]) & req_addr[2];
  wire         atomics_a_mask_acc_183 = atomics_a_mask_acc_180 | atomics_a_mask_size_25 & atomics_a_mask_eq_183;
  wire         atomics_a_mask_eq_184 = req_addr[3] & ~(req_addr[2]);
  wire         atomics_a_mask_acc_184 = atomics_a_mask_acc_181 | atomics_a_mask_size_25 & atomics_a_mask_eq_184;
  wire         atomics_a_mask_eq_185 = req_addr[3] & req_addr[2];
  wire         atomics_a_mask_acc_185 = atomics_a_mask_acc_181 | atomics_a_mask_size_25 & atomics_a_mask_eq_185;
  wire         atomics_a_mask_size_26 = size == 2'h1;
  wire         atomics_a_mask_eq_186 = atomics_a_mask_eq_182 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_186 = atomics_a_mask_acc_182 | atomics_a_mask_size_26 & atomics_a_mask_eq_186;
  wire         atomics_a_mask_eq_187 = atomics_a_mask_eq_182 & req_addr[1];
  wire         atomics_a_mask_acc_187 = atomics_a_mask_acc_182 | atomics_a_mask_size_26 & atomics_a_mask_eq_187;
  wire         atomics_a_mask_eq_188 = atomics_a_mask_eq_183 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_188 = atomics_a_mask_acc_183 | atomics_a_mask_size_26 & atomics_a_mask_eq_188;
  wire         atomics_a_mask_eq_189 = atomics_a_mask_eq_183 & req_addr[1];
  wire         atomics_a_mask_acc_189 = atomics_a_mask_acc_183 | atomics_a_mask_size_26 & atomics_a_mask_eq_189;
  wire         atomics_a_mask_eq_190 = atomics_a_mask_eq_184 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_190 = atomics_a_mask_acc_184 | atomics_a_mask_size_26 & atomics_a_mask_eq_190;
  wire         atomics_a_mask_eq_191 = atomics_a_mask_eq_184 & req_addr[1];
  wire         atomics_a_mask_acc_191 = atomics_a_mask_acc_184 | atomics_a_mask_size_26 & atomics_a_mask_eq_191;
  wire         atomics_a_mask_eq_192 = atomics_a_mask_eq_185 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_192 = atomics_a_mask_acc_185 | atomics_a_mask_size_26 & atomics_a_mask_eq_192;
  wire         atomics_a_mask_eq_193 = atomics_a_mask_eq_185 & req_addr[1];
  wire         atomics_a_mask_acc_193 = atomics_a_mask_acc_185 | atomics_a_mask_size_26 & atomics_a_mask_eq_193;
  wire         atomics_a_mask_acc_210 = (&size) & ~(req_addr[3]);
  wire         atomics_a_mask_acc_211 = (&size) & req_addr[3];
  wire         atomics_a_mask_size_29 = size == 2'h2;
  wire         atomics_a_mask_eq_212 = ~(req_addr[3]) & ~(req_addr[2]);
  wire         atomics_a_mask_acc_212 = atomics_a_mask_acc_210 | atomics_a_mask_size_29 & atomics_a_mask_eq_212;
  wire         atomics_a_mask_eq_213 = ~(req_addr[3]) & req_addr[2];
  wire         atomics_a_mask_acc_213 = atomics_a_mask_acc_210 | atomics_a_mask_size_29 & atomics_a_mask_eq_213;
  wire         atomics_a_mask_eq_214 = req_addr[3] & ~(req_addr[2]);
  wire         atomics_a_mask_acc_214 = atomics_a_mask_acc_211 | atomics_a_mask_size_29 & atomics_a_mask_eq_214;
  wire         atomics_a_mask_eq_215 = req_addr[3] & req_addr[2];
  wire         atomics_a_mask_acc_215 = atomics_a_mask_acc_211 | atomics_a_mask_size_29 & atomics_a_mask_eq_215;
  wire         atomics_a_mask_size_30 = size == 2'h1;
  wire         atomics_a_mask_eq_216 = atomics_a_mask_eq_212 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_216 = atomics_a_mask_acc_212 | atomics_a_mask_size_30 & atomics_a_mask_eq_216;
  wire         atomics_a_mask_eq_217 = atomics_a_mask_eq_212 & req_addr[1];
  wire         atomics_a_mask_acc_217 = atomics_a_mask_acc_212 | atomics_a_mask_size_30 & atomics_a_mask_eq_217;
  wire         atomics_a_mask_eq_218 = atomics_a_mask_eq_213 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_218 = atomics_a_mask_acc_213 | atomics_a_mask_size_30 & atomics_a_mask_eq_218;
  wire         atomics_a_mask_eq_219 = atomics_a_mask_eq_213 & req_addr[1];
  wire         atomics_a_mask_acc_219 = atomics_a_mask_acc_213 | atomics_a_mask_size_30 & atomics_a_mask_eq_219;
  wire         atomics_a_mask_eq_220 = atomics_a_mask_eq_214 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_220 = atomics_a_mask_acc_214 | atomics_a_mask_size_30 & atomics_a_mask_eq_220;
  wire         atomics_a_mask_eq_221 = atomics_a_mask_eq_214 & req_addr[1];
  wire         atomics_a_mask_acc_221 = atomics_a_mask_acc_214 | atomics_a_mask_size_30 & atomics_a_mask_eq_221;
  wire         atomics_a_mask_eq_222 = atomics_a_mask_eq_215 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_222 = atomics_a_mask_acc_215 | atomics_a_mask_size_30 & atomics_a_mask_eq_222;
  wire         atomics_a_mask_eq_223 = atomics_a_mask_eq_215 & req_addr[1];
  wire         atomics_a_mask_acc_223 = atomics_a_mask_acc_215 | atomics_a_mask_size_30 & atomics_a_mask_eq_223;
  wire         atomics_a_mask_acc_240 = (&size) & ~(req_addr[3]);
  wire         atomics_a_mask_acc_241 = (&size) & req_addr[3];
  wire         atomics_a_mask_size_33 = size == 2'h2;
  wire         atomics_a_mask_eq_242 = ~(req_addr[3]) & ~(req_addr[2]);
  wire         atomics_a_mask_acc_242 = atomics_a_mask_acc_240 | atomics_a_mask_size_33 & atomics_a_mask_eq_242;
  wire         atomics_a_mask_eq_243 = ~(req_addr[3]) & req_addr[2];
  wire         atomics_a_mask_acc_243 = atomics_a_mask_acc_240 | atomics_a_mask_size_33 & atomics_a_mask_eq_243;
  wire         atomics_a_mask_eq_244 = req_addr[3] & ~(req_addr[2]);
  wire         atomics_a_mask_acc_244 = atomics_a_mask_acc_241 | atomics_a_mask_size_33 & atomics_a_mask_eq_244;
  wire         atomics_a_mask_eq_245 = req_addr[3] & req_addr[2];
  wire         atomics_a_mask_acc_245 = atomics_a_mask_acc_241 | atomics_a_mask_size_33 & atomics_a_mask_eq_245;
  wire         atomics_a_mask_size_34 = size == 2'h1;
  wire         atomics_a_mask_eq_246 = atomics_a_mask_eq_242 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_246 = atomics_a_mask_acc_242 | atomics_a_mask_size_34 & atomics_a_mask_eq_246;
  wire         atomics_a_mask_eq_247 = atomics_a_mask_eq_242 & req_addr[1];
  wire         atomics_a_mask_acc_247 = atomics_a_mask_acc_242 | atomics_a_mask_size_34 & atomics_a_mask_eq_247;
  wire         atomics_a_mask_eq_248 = atomics_a_mask_eq_243 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_248 = atomics_a_mask_acc_243 | atomics_a_mask_size_34 & atomics_a_mask_eq_248;
  wire         atomics_a_mask_eq_249 = atomics_a_mask_eq_243 & req_addr[1];
  wire         atomics_a_mask_acc_249 = atomics_a_mask_acc_243 | atomics_a_mask_size_34 & atomics_a_mask_eq_249;
  wire         atomics_a_mask_eq_250 = atomics_a_mask_eq_244 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_250 = atomics_a_mask_acc_244 | atomics_a_mask_size_34 & atomics_a_mask_eq_250;
  wire         atomics_a_mask_eq_251 = atomics_a_mask_eq_244 & req_addr[1];
  wire         atomics_a_mask_acc_251 = atomics_a_mask_acc_244 | atomics_a_mask_size_34 & atomics_a_mask_eq_251;
  wire         atomics_a_mask_eq_252 = atomics_a_mask_eq_245 & ~(req_addr[1]);
  wire         atomics_a_mask_acc_252 = atomics_a_mask_acc_245 | atomics_a_mask_size_34 & atomics_a_mask_eq_252;
  wire         atomics_a_mask_eq_253 = atomics_a_mask_eq_245 & req_addr[1];
  wire         atomics_a_mask_acc_253 = atomics_a_mask_acc_245 | atomics_a_mask_size_34 & atomics_a_mask_eq_253;
  wire         _atomics_T = req_uop_mem_cmd == 5'h4;
  wire         _atomics_T_2 = req_uop_mem_cmd == 5'h9;
  wire         _atomics_T_4 = req_uop_mem_cmd == 5'hA;
  wire         _atomics_T_6 = req_uop_mem_cmd == 5'hB;
  wire         _GEN = _atomics_T_6 | _atomics_T_4 | _atomics_T_2 | _atomics_T;
  wire         _atomics_T_8 = req_uop_mem_cmd == 5'h8;
  wire [15:0]  _atomics_T_9_mask =
    _atomics_T_8
      ? {atomics_a_mask_acc_133 | atomics_a_mask_eq_133 & req_addr[0], atomics_a_mask_acc_133 | atomics_a_mask_eq_133 & ~(req_addr[0]), atomics_a_mask_acc_132 | atomics_a_mask_eq_132 & req_addr[0], atomics_a_mask_acc_132 | atomics_a_mask_eq_132 & ~(req_addr[0]), atomics_a_mask_acc_131 | atomics_a_mask_eq_131 & req_addr[0], atomics_a_mask_acc_131 | atomics_a_mask_eq_131 & ~(req_addr[0]), atomics_a_mask_acc_130 | atomics_a_mask_eq_130 & req_addr[0], atomics_a_mask_acc_130 | atomics_a_mask_eq_130 & ~(req_addr[0]), atomics_a_mask_acc_129 | atomics_a_mask_eq_129 & req_addr[0], atomics_a_mask_acc_129 | atomics_a_mask_eq_129 & ~(req_addr[0]), atomics_a_mask_acc_128 | atomics_a_mask_eq_128 & req_addr[0], atomics_a_mask_acc_128 | atomics_a_mask_eq_128 & ~(req_addr[0]), atomics_a_mask_acc_127 | atomics_a_mask_eq_127 & req_addr[0], atomics_a_mask_acc_127 | atomics_a_mask_eq_127 & ~(req_addr[0]), atomics_a_mask_acc_126 | atomics_a_mask_eq_126 & req_addr[0], atomics_a_mask_acc_126 | atomics_a_mask_eq_126 & ~(req_addr[0])}
      : _atomics_T_6
          ? {atomics_a_mask_acc_103 | atomics_a_mask_eq_103 & req_addr[0], atomics_a_mask_acc_103 | atomics_a_mask_eq_103 & ~(req_addr[0]), atomics_a_mask_acc_102 | atomics_a_mask_eq_102 & req_addr[0], atomics_a_mask_acc_102 | atomics_a_mask_eq_102 & ~(req_addr[0]), atomics_a_mask_acc_101 | atomics_a_mask_eq_101 & req_addr[0], atomics_a_mask_acc_101 | atomics_a_mask_eq_101 & ~(req_addr[0]), atomics_a_mask_acc_100 | atomics_a_mask_eq_100 & req_addr[0], atomics_a_mask_acc_100 | atomics_a_mask_eq_100 & ~(req_addr[0]), atomics_a_mask_acc_99 | atomics_a_mask_eq_99 & req_addr[0], atomics_a_mask_acc_99 | atomics_a_mask_eq_99 & ~(req_addr[0]), atomics_a_mask_acc_98 | atomics_a_mask_eq_98 & req_addr[0], atomics_a_mask_acc_98 | atomics_a_mask_eq_98 & ~(req_addr[0]), atomics_a_mask_acc_97 | atomics_a_mask_eq_97 & req_addr[0], atomics_a_mask_acc_97 | atomics_a_mask_eq_97 & ~(req_addr[0]), atomics_a_mask_acc_96 | atomics_a_mask_eq_96 & req_addr[0], atomics_a_mask_acc_96 | atomics_a_mask_eq_96 & ~(req_addr[0])}
          : _atomics_T_4
              ? {atomics_a_mask_acc_73 | atomics_a_mask_eq_73 & req_addr[0], atomics_a_mask_acc_73 | atomics_a_mask_eq_73 & ~(req_addr[0]), atomics_a_mask_acc_72 | atomics_a_mask_eq_72 & req_addr[0], atomics_a_mask_acc_72 | atomics_a_mask_eq_72 & ~(req_addr[0]), atomics_a_mask_acc_71 | atomics_a_mask_eq_71 & req_addr[0], atomics_a_mask_acc_71 | atomics_a_mask_eq_71 & ~(req_addr[0]), atomics_a_mask_acc_70 | atomics_a_mask_eq_70 & req_addr[0], atomics_a_mask_acc_70 | atomics_a_mask_eq_70 & ~(req_addr[0]), atomics_a_mask_acc_69 | atomics_a_mask_eq_69 & req_addr[0], atomics_a_mask_acc_69 | atomics_a_mask_eq_69 & ~(req_addr[0]), atomics_a_mask_acc_68 | atomics_a_mask_eq_68 & req_addr[0], atomics_a_mask_acc_68 | atomics_a_mask_eq_68 & ~(req_addr[0]), atomics_a_mask_acc_67 | atomics_a_mask_eq_67 & req_addr[0], atomics_a_mask_acc_67 | atomics_a_mask_eq_67 & ~(req_addr[0]), atomics_a_mask_acc_66 | atomics_a_mask_eq_66 & req_addr[0], atomics_a_mask_acc_66 | atomics_a_mask_eq_66 & ~(req_addr[0])}
              : _atomics_T_2 ? {atomics_a_mask_acc_43 | atomics_a_mask_eq_43 & req_addr[0], atomics_a_mask_acc_43 | atomics_a_mask_eq_43 & ~(req_addr[0]), atomics_a_mask_acc_42 | atomics_a_mask_eq_42 & req_addr[0], atomics_a_mask_acc_42 | atomics_a_mask_eq_42 & ~(req_addr[0]), atomics_a_mask_acc_41 | atomics_a_mask_eq_41 & req_addr[0], atomics_a_mask_acc_41 | atomics_a_mask_eq_41 & ~(req_addr[0]), atomics_a_mask_acc_40 | atomics_a_mask_eq_40 & req_addr[0], atomics_a_mask_acc_40 | atomics_a_mask_eq_40 & ~(req_addr[0]), atomics_a_mask_acc_39 | atomics_a_mask_eq_39 & req_addr[0], atomics_a_mask_acc_39 | atomics_a_mask_eq_39 & ~(req_addr[0]), atomics_a_mask_acc_38 | atomics_a_mask_eq_38 & req_addr[0], atomics_a_mask_acc_38 | atomics_a_mask_eq_38 & ~(req_addr[0]), atomics_a_mask_acc_37 | atomics_a_mask_eq_37 & req_addr[0], atomics_a_mask_acc_37 | atomics_a_mask_eq_37 & ~(req_addr[0]), atomics_a_mask_acc_36 | atomics_a_mask_eq_36 & req_addr[0], atomics_a_mask_acc_36 | atomics_a_mask_eq_36 & ~(req_addr[0])} : _atomics_T ? {atomics_a_mask_acc_13 | atomics_a_mask_eq_13 & req_addr[0], atomics_a_mask_acc_13 | atomics_a_mask_eq_13 & ~(req_addr[0]), atomics_a_mask_acc_12 | atomics_a_mask_eq_12 & req_addr[0], atomics_a_mask_acc_12 | atomics_a_mask_eq_12 & ~(req_addr[0]), atomics_a_mask_acc_11 | atomics_a_mask_eq_11 & req_addr[0], atomics_a_mask_acc_11 | atomics_a_mask_eq_11 & ~(req_addr[0]), atomics_a_mask_acc_10 | atomics_a_mask_eq_10 & req_addr[0], atomics_a_mask_acc_10 | atomics_a_mask_eq_10 & ~(req_addr[0]), atomics_a_mask_acc_9 | atomics_a_mask_eq_9 & req_addr[0], atomics_a_mask_acc_9 | atomics_a_mask_eq_9 & ~(req_addr[0]), atomics_a_mask_acc_8 | atomics_a_mask_eq_8 & req_addr[0], atomics_a_mask_acc_8 | atomics_a_mask_eq_8 & ~(req_addr[0]), atomics_a_mask_acc_7 | atomics_a_mask_eq_7 & req_addr[0], atomics_a_mask_acc_7 | atomics_a_mask_eq_7 & ~(req_addr[0]), atomics_a_mask_acc_6 | atomics_a_mask_eq_6 & req_addr[0], atomics_a_mask_acc_6 | atomics_a_mask_eq_6 & ~(req_addr[0])} : 16'h0;
  wire         _atomics_T_10 = req_uop_mem_cmd == 5'hC;
  wire         _atomics_T_12 = req_uop_mem_cmd == 5'hD;
  wire         _atomics_T_14 = req_uop_mem_cmd == 5'hE;
  wire         _atomics_T_16 = req_uop_mem_cmd == 5'hF;
  wire         _GEN_0 = _atomics_T_16 | _atomics_T_14 | _atomics_T_12 | _atomics_T_10 | _atomics_T_8 | _GEN;
  wire         _io_mem_access_valid_output = state == 2'h1;
  wire         _send_resp_T_7 = req_uop_mem_cmd == 5'h4;
  wire         _send_resp_T_8 = req_uop_mem_cmd == 5'h9;
  wire         _send_resp_T_9 = req_uop_mem_cmd == 5'hA;
  wire         _send_resp_T_10 = req_uop_mem_cmd == 5'hB;
  wire         _send_resp_T_14 = req_uop_mem_cmd == 5'h8;
  wire         _send_resp_T_15 = req_uop_mem_cmd == 5'hC;
  wire         _send_resp_T_16 = req_uop_mem_cmd == 5'hD;
  wire         _send_resp_T_17 = req_uop_mem_cmd == 5'hE;
  wire         _send_resp_T_18 = req_uop_mem_cmd == 5'hF;
  wire         _io_mem_access_bits_T_16 = _send_resp_T_7 | _send_resp_T_8 | _send_resp_T_9 | _send_resp_T_10 | _send_resp_T_14 | _send_resp_T_15 | _send_resp_T_16 | _send_resp_T_17 | _send_resp_T_18;
  wire         _send_resp_T = req_uop_mem_cmd == 5'h0;
  wire         _send_resp_T_1 = req_uop_mem_cmd == 5'h10;
  wire         _send_resp_T_2 = req_uop_mem_cmd == 5'h6;
  wire         _send_resp_T_3 = req_uop_mem_cmd == 5'h7;
  wire         _io_mem_access_bits_T_41 = _send_resp_T | _send_resp_T_1 | _send_resp_T_2 | _send_resp_T_3 | _send_resp_T_7 | _send_resp_T_8 | _send_resp_T_9 | _send_resp_T_10 | _send_resp_T_14 | _send_resp_T_15 | _send_resp_T_16 | _send_resp_T_17 | _send_resp_T_18;
  wire         _GEN_1 = ~_io_mem_access_bits_T_16 | _GEN_0;
  wire         send_resp = _send_resp_T | _send_resp_T_1 | _send_resp_T_2 | _send_resp_T_3 | _send_resp_T_7 | _send_resp_T_8 | _send_resp_T_9 | _send_resp_T_10 | _send_resp_T_14 | _send_resp_T_15 | _send_resp_T_16 | _send_resp_T_17 | _send_resp_T_18;
  wire         _io_resp_valid_output = (&state) & send_resp;
  wire [31:0]  io_resp_bits_data_zeroed = req_addr[2] ? grant_word[63:32] : grant_word[31:0];
  wire [15:0]  io_resp_bits_data_zeroed_1 = req_addr[1] ? io_resp_bits_data_zeroed[31:16] : io_resp_bits_data_zeroed[15:0];
  wire [7:0]   io_resp_bits_data_zeroed_2 = req_addr[0] ? io_resp_bits_data_zeroed_1[15:8] : io_resp_bits_data_zeroed_1[7:0];
  wire [127:0] _grant_word_T = io_mem_ack_bits_data >> {121'h0, req_addr[3], 6'h0};
  wire         _GEN_2 = _io_req_ready_output & io_req_valid;
  wire         _GEN_3 = state == 2'h2 & io_mem_ack_valid;
  always @(posedge clock) begin
    if (_GEN_2) begin
      req_uop_br_mask <= io_req_bits_uop_br_mask;
      req_uop_ldq_idx <= io_req_bits_uop_ldq_idx;
      req_uop_stq_idx <= io_req_bits_uop_stq_idx;
      req_uop_mem_cmd <= io_req_bits_uop_mem_cmd;
      size <= io_req_bits_uop_mem_size;
      req_uop_mem_signed <= io_req_bits_uop_mem_signed;
      req_uop_is_amo <= io_req_bits_uop_is_amo;
      req_uop_uses_ldq <= io_req_bits_uop_uses_ldq;
      req_uop_uses_stq <= io_req_bits_uop_uses_stq;
      req_addr <= io_req_bits_addr;
      req_data <= io_req_bits_data;
      req_is_hella <= io_req_bits_is_hella;
    end
    if (_GEN_3 & (_send_resp_T | _send_resp_T_1 | _send_resp_T_2 | _send_resp_T_3 | _send_resp_T_7 | _send_resp_T_8 | _send_resp_T_9 | _send_resp_T_10 | _send_resp_T_14 | _send_resp_T_15 | _send_resp_T_16 | _send_resp_T_17 | _send_resp_T_18))
      grant_word <= _grant_word_T[63:0];
    if (reset)
      state <= 2'h0;
    else if ((&state) & (~send_resp | io_resp_ready & _io_resp_valid_output))
      state <= 2'h0;
    else if (_GEN_3)
      state <= 2'h3;
    else if (io_mem_access_ready & _io_mem_access_valid_output)
      state <= 2'h2;
    else if (_GEN_2)
      state <= 2'h1;
  end // always @(posedge)
  assign io_req_ready = _io_req_ready_output;
  assign io_resp_valid = _io_resp_valid_output;
  assign io_resp_bits_uop_br_mask = req_uop_br_mask;
  assign io_resp_bits_uop_ldq_idx = req_uop_ldq_idx;
  assign io_resp_bits_uop_stq_idx = req_uop_stq_idx;
  assign io_resp_bits_uop_is_amo = req_uop_is_amo;
  assign io_resp_bits_uop_uses_ldq = req_uop_uses_ldq;
  assign io_resp_bits_uop_uses_stq = req_uop_uses_stq;
  assign io_resp_bits_data = {size == 2'h0 ? {56{req_uop_mem_signed & io_resp_bits_data_zeroed_2[7]}} : {size == 2'h1 ? {48{req_uop_mem_signed & io_resp_bits_data_zeroed_1[15]}} : {size == 2'h2 ? {32{req_uop_mem_signed & io_resp_bits_data_zeroed[31]}} : grant_word[63:32], io_resp_bits_data_zeroed[31:16]}, io_resp_bits_data_zeroed_1[15:8]}, io_resp_bits_data_zeroed_2};
  assign io_resp_bits_is_hella = req_is_hella;
  assign io_mem_access_valid = _io_mem_access_valid_output;
  assign io_mem_access_bits_opcode = _io_mem_access_bits_T_16 ? (_atomics_T_16 | _atomics_T_14 | _atomics_T_12 | _atomics_T_10 | _atomics_T_8 ? 3'h2 : _GEN ? 3'h3 : 3'h0) : {_io_mem_access_bits_T_41, 2'h0};
  assign io_mem_access_bits_param = _io_mem_access_bits_T_16 ? (_atomics_T_16 ? 3'h3 : _atomics_T_14 ? 3'h2 : _atomics_T_12 ? 3'h1 : _atomics_T_10 ? 3'h0 : _atomics_T_8 ? 3'h4 : _atomics_T_6 ? 3'h2 : _atomics_T_4 ? 3'h1 : _atomics_T_2 | ~_atomics_T ? 3'h0 : 3'h3) : 3'h0;
  assign io_mem_access_bits_size = _GEN_1 ? {2'h0, size} : 4'h0;
  assign io_mem_access_bits_source = _GEN_1 ? 4'h9 : 4'h0;
  assign io_mem_access_bits_address = _GEN_1 ? req_addr[31:0] : 32'h0;
  assign io_mem_access_bits_mask =
    _io_mem_access_bits_T_16
      ? (_atomics_T_16
           ? {atomics_a_mask_acc_253 | atomics_a_mask_eq_253 & req_addr[0], atomics_a_mask_acc_253 | atomics_a_mask_eq_253 & ~(req_addr[0]), atomics_a_mask_acc_252 | atomics_a_mask_eq_252 & req_addr[0], atomics_a_mask_acc_252 | atomics_a_mask_eq_252 & ~(req_addr[0]), atomics_a_mask_acc_251 | atomics_a_mask_eq_251 & req_addr[0], atomics_a_mask_acc_251 | atomics_a_mask_eq_251 & ~(req_addr[0]), atomics_a_mask_acc_250 | atomics_a_mask_eq_250 & req_addr[0], atomics_a_mask_acc_250 | atomics_a_mask_eq_250 & ~(req_addr[0]), atomics_a_mask_acc_249 | atomics_a_mask_eq_249 & req_addr[0], atomics_a_mask_acc_249 | atomics_a_mask_eq_249 & ~(req_addr[0]), atomics_a_mask_acc_248 | atomics_a_mask_eq_248 & req_addr[0], atomics_a_mask_acc_248 | atomics_a_mask_eq_248 & ~(req_addr[0]), atomics_a_mask_acc_247 | atomics_a_mask_eq_247 & req_addr[0], atomics_a_mask_acc_247 | atomics_a_mask_eq_247 & ~(req_addr[0]), atomics_a_mask_acc_246 | atomics_a_mask_eq_246 & req_addr[0], atomics_a_mask_acc_246 | atomics_a_mask_eq_246 & ~(req_addr[0])}
           : _atomics_T_14
               ? {atomics_a_mask_acc_223 | atomics_a_mask_eq_223 & req_addr[0], atomics_a_mask_acc_223 | atomics_a_mask_eq_223 & ~(req_addr[0]), atomics_a_mask_acc_222 | atomics_a_mask_eq_222 & req_addr[0], atomics_a_mask_acc_222 | atomics_a_mask_eq_222 & ~(req_addr[0]), atomics_a_mask_acc_221 | atomics_a_mask_eq_221 & req_addr[0], atomics_a_mask_acc_221 | atomics_a_mask_eq_221 & ~(req_addr[0]), atomics_a_mask_acc_220 | atomics_a_mask_eq_220 & req_addr[0], atomics_a_mask_acc_220 | atomics_a_mask_eq_220 & ~(req_addr[0]), atomics_a_mask_acc_219 | atomics_a_mask_eq_219 & req_addr[0], atomics_a_mask_acc_219 | atomics_a_mask_eq_219 & ~(req_addr[0]), atomics_a_mask_acc_218 | atomics_a_mask_eq_218 & req_addr[0], atomics_a_mask_acc_218 | atomics_a_mask_eq_218 & ~(req_addr[0]), atomics_a_mask_acc_217 | atomics_a_mask_eq_217 & req_addr[0], atomics_a_mask_acc_217 | atomics_a_mask_eq_217 & ~(req_addr[0]), atomics_a_mask_acc_216 | atomics_a_mask_eq_216 & req_addr[0], atomics_a_mask_acc_216 | atomics_a_mask_eq_216 & ~(req_addr[0])}
               : _atomics_T_12
                   ? {atomics_a_mask_acc_193 | atomics_a_mask_eq_193 & req_addr[0], atomics_a_mask_acc_193 | atomics_a_mask_eq_193 & ~(req_addr[0]), atomics_a_mask_acc_192 | atomics_a_mask_eq_192 & req_addr[0], atomics_a_mask_acc_192 | atomics_a_mask_eq_192 & ~(req_addr[0]), atomics_a_mask_acc_191 | atomics_a_mask_eq_191 & req_addr[0], atomics_a_mask_acc_191 | atomics_a_mask_eq_191 & ~(req_addr[0]), atomics_a_mask_acc_190 | atomics_a_mask_eq_190 & req_addr[0], atomics_a_mask_acc_190 | atomics_a_mask_eq_190 & ~(req_addr[0]), atomics_a_mask_acc_189 | atomics_a_mask_eq_189 & req_addr[0], atomics_a_mask_acc_189 | atomics_a_mask_eq_189 & ~(req_addr[0]), atomics_a_mask_acc_188 | atomics_a_mask_eq_188 & req_addr[0], atomics_a_mask_acc_188 | atomics_a_mask_eq_188 & ~(req_addr[0]), atomics_a_mask_acc_187 | atomics_a_mask_eq_187 & req_addr[0], atomics_a_mask_acc_187 | atomics_a_mask_eq_187 & ~(req_addr[0]), atomics_a_mask_acc_186 | atomics_a_mask_eq_186 & req_addr[0], atomics_a_mask_acc_186 | atomics_a_mask_eq_186 & ~(req_addr[0])}
                   : _atomics_T_10 ? {atomics_a_mask_acc_163 | atomics_a_mask_eq_163 & req_addr[0], atomics_a_mask_acc_163 | atomics_a_mask_eq_163 & ~(req_addr[0]), atomics_a_mask_acc_162 | atomics_a_mask_eq_162 & req_addr[0], atomics_a_mask_acc_162 | atomics_a_mask_eq_162 & ~(req_addr[0]), atomics_a_mask_acc_161 | atomics_a_mask_eq_161 & req_addr[0], atomics_a_mask_acc_161 | atomics_a_mask_eq_161 & ~(req_addr[0]), atomics_a_mask_acc_160 | atomics_a_mask_eq_160 & req_addr[0], atomics_a_mask_acc_160 | atomics_a_mask_eq_160 & ~(req_addr[0]), atomics_a_mask_acc_159 | atomics_a_mask_eq_159 & req_addr[0], atomics_a_mask_acc_159 | atomics_a_mask_eq_159 & ~(req_addr[0]), atomics_a_mask_acc_158 | atomics_a_mask_eq_158 & req_addr[0], atomics_a_mask_acc_158 | atomics_a_mask_eq_158 & ~(req_addr[0]), atomics_a_mask_acc_157 | atomics_a_mask_eq_157 & req_addr[0], atomics_a_mask_acc_157 | atomics_a_mask_eq_157 & ~(req_addr[0]), atomics_a_mask_acc_156 | atomics_a_mask_eq_156 & req_addr[0], atomics_a_mask_acc_156 | atomics_a_mask_eq_156 & ~(req_addr[0])} : _atomics_T_9_mask)
      : _io_mem_access_bits_T_41 ? {get_a_mask_acc_13 | get_a_mask_eq_13 & req_addr[0], get_a_mask_acc_13 | get_a_mask_eq_13 & ~(req_addr[0]), get_a_mask_acc_12 | get_a_mask_eq_12 & req_addr[0], get_a_mask_acc_12 | get_a_mask_eq_12 & ~(req_addr[0]), get_a_mask_acc_11 | get_a_mask_eq_11 & req_addr[0], get_a_mask_acc_11 | get_a_mask_eq_11 & ~(req_addr[0]), get_a_mask_acc_10 | get_a_mask_eq_10 & req_addr[0], get_a_mask_acc_10 | get_a_mask_eq_10 & ~(req_addr[0]), get_a_mask_acc_9 | get_a_mask_eq_9 & req_addr[0], get_a_mask_acc_9 | get_a_mask_eq_9 & ~(req_addr[0]), get_a_mask_acc_8 | get_a_mask_eq_8 & req_addr[0], get_a_mask_acc_8 | get_a_mask_eq_8 & ~(req_addr[0]), get_a_mask_acc_7 | get_a_mask_eq_7 & req_addr[0], get_a_mask_acc_7 | get_a_mask_eq_7 & ~(req_addr[0]), get_a_mask_acc_6 | get_a_mask_eq_6 & req_addr[0], get_a_mask_acc_6 | get_a_mask_eq_6 & ~(req_addr[0])} : {put_a_mask_acc_13 | put_a_mask_eq_13 & req_addr[0], put_a_mask_acc_13 | put_a_mask_eq_13 & ~(req_addr[0]), put_a_mask_acc_12 | put_a_mask_eq_12 & req_addr[0], put_a_mask_acc_12 | put_a_mask_eq_12 & ~(req_addr[0]), put_a_mask_acc_11 | put_a_mask_eq_11 & req_addr[0], put_a_mask_acc_11 | put_a_mask_eq_11 & ~(req_addr[0]), put_a_mask_acc_10 | put_a_mask_eq_10 & req_addr[0], put_a_mask_acc_10 | put_a_mask_eq_10 & ~(req_addr[0]), put_a_mask_acc_9 | put_a_mask_eq_9 & req_addr[0], put_a_mask_acc_9 | put_a_mask_eq_9 & ~(req_addr[0]), put_a_mask_acc_8 | put_a_mask_eq_8 & req_addr[0], put_a_mask_acc_8 | put_a_mask_eq_8 & ~(req_addr[0]), put_a_mask_acc_7 | put_a_mask_eq_7 & req_addr[0], put_a_mask_acc_7 | put_a_mask_eq_7 & ~(req_addr[0]), put_a_mask_acc_6 | put_a_mask_eq_6 & req_addr[0], put_a_mask_acc_6 | put_a_mask_eq_6 & ~(req_addr[0])};
  assign io_mem_access_bits_data = _io_mem_access_bits_T_16 ? (_GEN_0 ? a_data : 128'h0) : _io_mem_access_bits_T_41 ? 128'h0 : a_data;
endmodule

