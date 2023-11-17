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
module TLMonitor_42_assert(
  input [31:0] io_in_a_bits_address,
  input [3:0]  io_in_a_bits_size,
  input [4:0]  io_in_a_bits_source,
  input [2:0]  io_in_a_bits_param,
  input [15:0] io_in_a_bits_mask,
  input [2:0]  io_in_d_bits_opcode,
  input [4:0]  io_in_d_bits_source,
  input [3:0]  io_in_d_bits_size,
  input [1:0]  io_in_d_bits_param,
  input        io_in_d_bits_corrupt,
               io_in_d_bits_denied,
  input [2:0]  io_in_b_bits_opcode,
  input [31:0] io_in_b_bits_address,
  input [3:0]  io_in_b_bits_size,
  input [4:0]  io_in_b_bits_source,
  input [1:0]  io_in_b_bits_param,
  input [15:0] io_in_b_bits_mask,
  input        io_in_b_bits_corrupt,
  input [31:0] io_in_c_bits_address,
  input [4:0]  io_in_c_bits_source,
  input [3:0]  io_in_c_bits_size,
  input [2:0]  io_in_c_bits_param,
               io_in_a_bits_opcode,
  input        clock,
               reset,
               io_in_a_ready,
               io_in_a_valid,
               io_in_d_ready,
               io_in_d_valid,
  input [3:0]  io_in_d_bits_sink,
  input        io_in_b_ready,
               io_in_b_valid,
  input [2:0]  io_in_c_bits_opcode,
  input        io_in_c_ready,
               io_in_c_valid,
  input [3:0]  io_in_e_bits_sink,
  input        io_in_e_ready,
               io_in_e_valid
);

  wire [31:0]  _plusarg_reader_1_out;
  wire [31:0]  _plusarg_reader_out;
  wire         _source_ok_WIRE__1 = io_in_a_bits_source == 5'h9;
  wire         _source_ok_WIRE__2 = io_in_a_bits_source == 5'h10;
  wire         source_ok = ~(io_in_a_bits_source[4]) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__1 | _source_ok_WIRE__2;
  wire [26:0]  _GEN = {23'h0, io_in_a_bits_size};
  wire [26:0]  _is_aligned_mask_T_1 = 27'hFFF << _GEN;
  wire [11:0]  _GEN_0 = io_in_a_bits_address[11:0] & ~(_is_aligned_mask_T_1[11:0]);
  wire         mask_acc = (|(io_in_a_bits_size[3:2])) | (&(io_in_a_bits_size[1:0])) & ~(io_in_a_bits_address[3]);
  wire         mask_acc_1 = (|(io_in_a_bits_size[3:2])) | (&(io_in_a_bits_size[1:0])) & io_in_a_bits_address[3];
  wire         mask_size_1 = io_in_a_bits_size[1:0] == 2'h2;
  wire         mask_eq_2 = ~(io_in_a_bits_address[3]) & ~(io_in_a_bits_address[2]);
  wire         mask_acc_2 = mask_acc | mask_size_1 & mask_eq_2;
  wire         mask_eq_3 = ~(io_in_a_bits_address[3]) & io_in_a_bits_address[2];
  wire         mask_acc_3 = mask_acc | mask_size_1 & mask_eq_3;
  wire         mask_eq_4 = io_in_a_bits_address[3] & ~(io_in_a_bits_address[2]);
  wire         mask_acc_4 = mask_acc_1 | mask_size_1 & mask_eq_4;
  wire         mask_eq_5 = io_in_a_bits_address[3] & io_in_a_bits_address[2];
  wire         mask_acc_5 = mask_acc_1 | mask_size_1 & mask_eq_5;
  wire         mask_size_2 = io_in_a_bits_size[1:0] == 2'h1;
  wire         mask_eq_6 = mask_eq_2 & ~(io_in_a_bits_address[1]);
  wire         mask_acc_6 = mask_acc_2 | mask_size_2 & mask_eq_6;
  wire         mask_eq_7 = mask_eq_2 & io_in_a_bits_address[1];
  wire         mask_acc_7 = mask_acc_2 | mask_size_2 & mask_eq_7;
  wire         mask_eq_8 = mask_eq_3 & ~(io_in_a_bits_address[1]);
  wire         mask_acc_8 = mask_acc_3 | mask_size_2 & mask_eq_8;
  wire         mask_eq_9 = mask_eq_3 & io_in_a_bits_address[1];
  wire         mask_acc_9 = mask_acc_3 | mask_size_2 & mask_eq_9;
  wire         mask_eq_10 = mask_eq_4 & ~(io_in_a_bits_address[1]);
  wire         mask_acc_10 = mask_acc_4 | mask_size_2 & mask_eq_10;
  wire         mask_eq_11 = mask_eq_4 & io_in_a_bits_address[1];
  wire         mask_acc_11 = mask_acc_4 | mask_size_2 & mask_eq_11;
  wire         mask_eq_12 = mask_eq_5 & ~(io_in_a_bits_address[1]);
  wire         mask_acc_12 = mask_acc_5 | mask_size_2 & mask_eq_12;
  wire         mask_eq_13 = mask_eq_5 & io_in_a_bits_address[1];
  wire         mask_acc_13 = mask_acc_5 | mask_size_2 & mask_eq_13;
  wire [15:0]  mask = {mask_acc_13 | mask_eq_13 & io_in_a_bits_address[0], mask_acc_13 | mask_eq_13 & ~(io_in_a_bits_address[0]), mask_acc_12 | mask_eq_12 & io_in_a_bits_address[0], mask_acc_12 | mask_eq_12 & ~(io_in_a_bits_address[0]), mask_acc_11 | mask_eq_11 & io_in_a_bits_address[0], mask_acc_11 | mask_eq_11 & ~(io_in_a_bits_address[0]), mask_acc_10 | mask_eq_10 & io_in_a_bits_address[0], mask_acc_10 | mask_eq_10 & ~(io_in_a_bits_address[0]), mask_acc_9 | mask_eq_9 & io_in_a_bits_address[0], mask_acc_9 | mask_eq_9 & ~(io_in_a_bits_address[0]), mask_acc_8 | mask_eq_8 & io_in_a_bits_address[0], mask_acc_8 | mask_eq_8 & ~(io_in_a_bits_address[0]), mask_acc_7 | mask_eq_7 & io_in_a_bits_address[0], mask_acc_7 | mask_eq_7 & ~(io_in_a_bits_address[0]), mask_acc_6 | mask_eq_6 & io_in_a_bits_address[0], mask_acc_6 | mask_eq_6 & ~(io_in_a_bits_address[0])};
  wire         _GEN_1 = io_in_a_bits_opcode == 3'h6;
  wire         _GEN_2 = io_in_a_bits_size < 4'hD;
  wire         _GEN_3 = io_in_a_bits_size == 4'h6;
  wire         _GEN_4 = io_in_a_bits_address[31:28] == 4'h8;
  wire         _GEN_5 = _GEN_3 & _GEN_4;
  wire         _GEN_6 = _GEN_2 & (~(io_in_a_bits_source[4]) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__1 | _source_ok_WIRE__2) & _GEN_5;
  wire         _GEN_7 = {io_in_a_bits_address[31:15], io_in_a_bits_address[13:12]} == 19'h0;
  wire         _GEN_8 = {io_in_a_bits_address[31:14], ~(io_in_a_bits_address[13:12])} == 20'h0;
  wire         _GEN_9 = {io_in_a_bits_address[31:17], ~(io_in_a_bits_address[16])} == 16'h0;
  wire         _GEN_10 = {io_in_a_bits_address[31:21], io_in_a_bits_address[20:17] ^ 4'h8, io_in_a_bits_address[15:12]} == 19'h0;
  wire         _GEN_11 = {io_in_a_bits_address[31:26], io_in_a_bits_address[25:16] ^ 10'h200} == 16'h0;
  wire         _GEN_12 = {io_in_a_bits_address[31:26], io_in_a_bits_address[25:12] ^ 14'h2010} == 20'h0;
  wire         _GEN_13 = {io_in_a_bits_address[31:28], ~(io_in_a_bits_address[27:26])} == 6'h0;
  wire         _GEN_14 = {io_in_a_bits_address[31:29], io_in_a_bits_address[28:12] ^ 17'h10020} == 20'h0;
  wire         _GEN_15 = _GEN_7 | _GEN_8;
  wire         _GEN_16 = _GEN_2 & (_GEN_15 | _GEN_9 | _GEN_10 | _GEN_11 | _GEN_12 | _GEN_13 | _GEN_14 | _GEN_4);
  wire         _GEN_17 = ~(io_in_a_bits_source[4]) & io_in_a_bits_source[3:0] < 4'h9 & _GEN_3 & _GEN_16;
  wire         _GEN_18 = io_in_a_bits_param < 3'h3;
  wire         _GEN_19 = io_in_a_bits_mask != 16'hFFFF;
  wire         _GEN_20 = _GEN_2 & (~(io_in_a_bits_source[4]) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__1 | _source_ok_WIRE__2) & _GEN_5;
  wire         _GEN_21 = ~(io_in_a_bits_source[4]) & io_in_a_bits_source[3:0] < 4'h9 & _GEN_3 & _GEN_16;
  wire         _GEN_22 = io_in_a_bits_opcode == 3'h4;
  wire         _GEN_23 = _GEN_2 & (~(io_in_a_bits_source[4]) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__1 | _source_ok_WIRE__2);
  wire         _GEN_24 = _GEN_2 & _GEN_8;
  wire         _GEN_25 = io_in_a_bits_size < 4'h7;
  wire         _GEN_26 = _GEN_24 | _GEN_25 & (_GEN_7 | _GEN_9 | _GEN_10 | _GEN_11 | _GEN_12 | _GEN_13 | _GEN_14 | _GEN_4);
  wire         _GEN_27 = io_in_a_bits_mask == mask;
  wire         _GEN_28 = _GEN_24 | _GEN_25 & (_GEN_7 | _GEN_10 | _GEN_11 | _GEN_12 | _GEN_13 | _GEN_14 | _GEN_4);
  wire         _GEN_29 = _GEN_2 & (~(io_in_a_bits_source[4]) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__1 | _source_ok_WIRE__2) & _GEN_28;
  wire         _GEN_30 = _GEN_2 & (~(io_in_a_bits_source[4]) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__1 | _source_ok_WIRE__2) & _GEN_28;
  wire [15:0]  _GEN_31 = io_in_a_bits_mask & ~mask;
  wire         _GEN_32 = io_in_a_bits_opcode == 3'h2;
  wire         _GEN_33 = io_in_a_bits_size < 4'h4 & (_GEN_15 | _GEN_10 | _GEN_11 | _GEN_12 | _GEN_13 | _GEN_14) | io_in_a_bits_size < 4'h5 & _GEN_4;
  wire         _GEN_34 = _GEN_2 & (~(io_in_a_bits_source[4]) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__1 | _source_ok_WIRE__2) & _GEN_33;
  wire         _GEN_35 = io_in_a_bits_param < 3'h5;
  wire         _GEN_36 = io_in_a_bits_opcode == 3'h3;
  wire         _GEN_37 = _GEN_2 & (~(io_in_a_bits_source[4]) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__1 | _source_ok_WIRE__2) & _GEN_33;
  wire         _GEN_38 = io_in_a_bits_opcode == 3'h5;
  wire         _GEN_39 = _GEN_2 & (~(io_in_a_bits_source[4]) & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE__1 | _source_ok_WIRE__2) & (_GEN_24 | _GEN_25 & _GEN_4);
  wire         _GEN_40 = io_in_a_bits_param < 3'h2;
  wire         _GEN_41 = io_in_d_bits_opcode != 3'h7;
  wire         source_ok_1 = ~(io_in_d_bits_source[4]) & io_in_d_bits_source[3:0] < 4'h9 | io_in_d_bits_source == 5'h9 | io_in_d_bits_source == 5'h10;
  wire         d_release_ack = io_in_d_bits_opcode == 3'h6;
  wire         _GEN_42 = io_in_d_bits_param != 2'h3;
  wire         _GEN_43 = io_in_d_bits_param != 2'h2;
  wire         _GEN_44 = ~io_in_d_bits_denied | io_in_d_bits_corrupt;
  wire         _GEN_45 = io_in_b_bits_opcode != 3'h7;
  wire [19:0]  _GEN_46 = {io_in_b_bits_address[31:14], ~(io_in_b_bits_address[13:12])};
  wire [19:0]  _GEN_47 = {io_in_b_bits_address[31:26], io_in_b_bits_address[25:12] ^ 14'h2010};
  wire [19:0]  _GEN_48 = {io_in_b_bits_address[31:29], io_in_b_bits_address[28:12] ^ 17'h10020};
  wire [5:0]   _GEN_49 = {io_in_b_bits_address[31:28], ~(io_in_b_bits_address[27:26])};
  wire [15:0]  _GEN_50 = {io_in_b_bits_address[31:26], io_in_b_bits_address[25:16] ^ 10'h200};
  wire [15:0]  _GEN_51 = {io_in_b_bits_address[31:17], ~(io_in_b_bits_address[16])};
  wire [8:0]   _GEN_52 = io_in_b_bits_address[20:12] ^ 9'h100;
  wire         _GEN_53 = io_in_b_bits_address[31:28] != 4'h8;
  wire         address_ok = ~(|_GEN_46) | ~(|_GEN_47) | {io_in_b_bits_address[31:15], io_in_b_bits_address[14:12] ^ 3'h4} == 20'h0 | ~(|_GEN_48) | ~(|_GEN_49) | ~(|_GEN_50) | io_in_b_bits_address[31:12] == 20'h0 | ~(|_GEN_51) | {io_in_b_bits_address[31:21], _GEN_52} == 20'h0 | {io_in_b_bits_address[31:21], io_in_b_bits_address[20:12] ^ 9'h110} == 20'h0 | ~_GEN_53;
  wire [26:0]  _is_aligned_mask_T_4 = 27'hFFF << io_in_b_bits_size;
  wire [11:0]  _GEN_54 = io_in_b_bits_address[11:0] & ~(_is_aligned_mask_T_4[11:0]);
  wire         mask_acc_30 = (|(io_in_b_bits_size[3:2])) | (&(io_in_b_bits_size[1:0])) & ~(io_in_b_bits_address[3]);
  wire         mask_acc_31 = (|(io_in_b_bits_size[3:2])) | (&(io_in_b_bits_size[1:0])) & io_in_b_bits_address[3];
  wire         mask_size_5 = io_in_b_bits_size[1:0] == 2'h2;
  wire         mask_eq_32 = ~(io_in_b_bits_address[3]) & ~(io_in_b_bits_address[2]);
  wire         mask_acc_32 = mask_acc_30 | mask_size_5 & mask_eq_32;
  wire         mask_eq_33 = ~(io_in_b_bits_address[3]) & io_in_b_bits_address[2];
  wire         mask_acc_33 = mask_acc_30 | mask_size_5 & mask_eq_33;
  wire         mask_eq_34 = io_in_b_bits_address[3] & ~(io_in_b_bits_address[2]);
  wire         mask_acc_34 = mask_acc_31 | mask_size_5 & mask_eq_34;
  wire         mask_eq_35 = io_in_b_bits_address[3] & io_in_b_bits_address[2];
  wire         mask_acc_35 = mask_acc_31 | mask_size_5 & mask_eq_35;
  wire         mask_size_6 = io_in_b_bits_size[1:0] == 2'h1;
  wire         mask_eq_36 = mask_eq_32 & ~(io_in_b_bits_address[1]);
  wire         mask_acc_36 = mask_acc_32 | mask_size_6 & mask_eq_36;
  wire         mask_eq_37 = mask_eq_32 & io_in_b_bits_address[1];
  wire         mask_acc_37 = mask_acc_32 | mask_size_6 & mask_eq_37;
  wire         mask_eq_38 = mask_eq_33 & ~(io_in_b_bits_address[1]);
  wire         mask_acc_38 = mask_acc_33 | mask_size_6 & mask_eq_38;
  wire         mask_eq_39 = mask_eq_33 & io_in_b_bits_address[1];
  wire         mask_acc_39 = mask_acc_33 | mask_size_6 & mask_eq_39;
  wire         mask_eq_40 = mask_eq_34 & ~(io_in_b_bits_address[1]);
  wire         mask_acc_40 = mask_acc_34 | mask_size_6 & mask_eq_40;
  wire         mask_eq_41 = mask_eq_34 & io_in_b_bits_address[1];
  wire         mask_acc_41 = mask_acc_34 | mask_size_6 & mask_eq_41;
  wire         mask_eq_42 = mask_eq_35 & ~(io_in_b_bits_address[1]);
  wire         mask_acc_42 = mask_acc_35 | mask_size_6 & mask_eq_42;
  wire         mask_eq_43 = mask_eq_35 & io_in_b_bits_address[1];
  wire         mask_acc_43 = mask_acc_35 | mask_size_6 & mask_eq_43;
  wire [15:0]  mask_1 = {mask_acc_43 | mask_eq_43 & io_in_b_bits_address[0], mask_acc_43 | mask_eq_43 & ~(io_in_b_bits_address[0]), mask_acc_42 | mask_eq_42 & io_in_b_bits_address[0], mask_acc_42 | mask_eq_42 & ~(io_in_b_bits_address[0]), mask_acc_41 | mask_eq_41 & io_in_b_bits_address[0], mask_acc_41 | mask_eq_41 & ~(io_in_b_bits_address[0]), mask_acc_40 | mask_eq_40 & io_in_b_bits_address[0], mask_acc_40 | mask_eq_40 & ~(io_in_b_bits_address[0]), mask_acc_39 | mask_eq_39 & io_in_b_bits_address[0], mask_acc_39 | mask_eq_39 & ~(io_in_b_bits_address[0]), mask_acc_38 | mask_eq_38 & io_in_b_bits_address[0], mask_acc_38 | mask_eq_38 & ~(io_in_b_bits_address[0]), mask_acc_37 | mask_eq_37 & io_in_b_bits_address[0], mask_acc_37 | mask_eq_37 & ~(io_in_b_bits_address[0]), mask_acc_36 | mask_eq_36 & io_in_b_bits_address[0], mask_acc_36 | mask_eq_36 & ~(io_in_b_bits_address[0])};
  wire         legal_source = {io_in_b_bits_source == 5'h10, io_in_b_bits_source == 5'h9 ? 4'h9 : 4'h0} == io_in_b_bits_source;
  wire         _GEN_55 = ~(io_in_b_bits_source[4]) & io_in_b_bits_source[3:0] < 4'h9 & io_in_b_bits_size == 4'h6 & io_in_b_bits_size < 4'hD & ({io_in_b_bits_address[31:15], io_in_b_bits_address[13:12]} == 19'h0 | ~(|_GEN_46) | ~(|_GEN_51) | {io_in_b_bits_address[31:21], _GEN_52[8:5], io_in_b_bits_address[15:12]} == 19'h0 | ~(|_GEN_50) | ~(|_GEN_47) | ~(|_GEN_49) | ~(|_GEN_48) | ~_GEN_53);
  wire         _GEN_56 = io_in_b_bits_param != 2'h3;
  wire         _GEN_57 = io_in_b_bits_mask == mask_1;
  wire [15:0]  _GEN_58 = io_in_b_bits_mask & ~mask_1;
  wire         _source_ok_WIRE_2_1 = io_in_c_bits_source == 5'h9;
  wire         _source_ok_WIRE_2_2 = io_in_c_bits_source == 5'h10;
  wire         source_ok_2 = ~(io_in_c_bits_source[4]) & io_in_c_bits_source[3:0] < 4'h9 | _source_ok_WIRE_2_1 | _source_ok_WIRE_2_2;
  wire [26:0]  _GEN_59 = {23'h0, io_in_c_bits_size};
  wire [26:0]  _is_aligned_mask_T_7 = 27'hFFF << _GEN_59;
  wire [11:0]  _GEN_60 = io_in_c_bits_address[11:0] & ~(_is_aligned_mask_T_7[11:0]);
  wire [19:0]  _GEN_61 = {io_in_c_bits_address[31:14], ~(io_in_c_bits_address[13:12])};
  wire [19:0]  _GEN_62 = {io_in_c_bits_address[31:26], io_in_c_bits_address[25:12] ^ 14'h2010};
  wire [19:0]  _GEN_63 = {io_in_c_bits_address[31:29], io_in_c_bits_address[28:12] ^ 17'h10020};
  wire [5:0]   _GEN_64 = {io_in_c_bits_address[31:28], ~(io_in_c_bits_address[27:26])};
  wire [15:0]  _GEN_65 = {io_in_c_bits_address[31:26], io_in_c_bits_address[25:16] ^ 10'h200};
  wire [15:0]  _GEN_66 = {io_in_c_bits_address[31:17], ~(io_in_c_bits_address[16])};
  wire [8:0]   _GEN_67 = io_in_c_bits_address[20:12] ^ 9'h100;
  wire         _GEN_68 = io_in_c_bits_address[31:28] != 4'h8;
  wire         address_ok_1 = ~(|_GEN_61) | ~(|_GEN_62) | {io_in_c_bits_address[31:15], io_in_c_bits_address[14:12] ^ 3'h4} == 20'h0 | ~(|_GEN_63) | ~(|_GEN_64) | ~(|_GEN_65) | io_in_c_bits_address[31:12] == 20'h0 | ~(|_GEN_66) | {io_in_c_bits_address[31:21], _GEN_67} == 20'h0 | {io_in_c_bits_address[31:21], io_in_c_bits_address[20:12] ^ 9'h110} == 20'h0 | ~_GEN_68;
  wire         _c_probe_ack_T = io_in_c_bits_opcode == 3'h4;
  wire         _GEN_69 = io_in_c_bits_param[2:1] != 2'h3;
  wire         _c_probe_ack_T_1 = io_in_c_bits_opcode == 3'h5;
  wire         _GEN_70 = io_in_c_bits_size < 4'hD;
  wire         _GEN_71 = io_in_c_bits_size == 4'h6;
  wire         _GEN_72 = _GEN_71 & ~_GEN_68;
  wire         _GEN_73 = _GEN_70 & (~(io_in_c_bits_source[4]) & io_in_c_bits_source[3:0] < 4'h9 | _source_ok_WIRE_2_1 | _source_ok_WIRE_2_2) & _GEN_72;
  wire         _GEN_74 = _GEN_70 & ({io_in_c_bits_address[31:15], io_in_c_bits_address[13:12]} == 19'h0 | ~(|_GEN_61) | ~(|_GEN_66) | {io_in_c_bits_address[31:21], _GEN_67[8:5], io_in_c_bits_address[15:12]} == 19'h0 | ~(|_GEN_65) | ~(|_GEN_62) | ~(|_GEN_64) | ~(|_GEN_63) | ~_GEN_68);
  wire         _GEN_75 = ~(io_in_c_bits_source[4]) & io_in_c_bits_source[3:0] < 4'h9 & _GEN_71 & _GEN_74;
  wire         _GEN_76 = _GEN_70 & (~(io_in_c_bits_source[4]) & io_in_c_bits_source[3:0] < 4'h9 | _source_ok_WIRE_2_1 | _source_ok_WIRE_2_2) & _GEN_72;
  wire         _GEN_77 = ~(io_in_c_bits_source[4]) & io_in_c_bits_source[3:0] < 4'h9 & _GEN_71 & _GEN_74;
  wire         _a_first_T_1 = io_in_a_ready & io_in_a_valid;
  reg  [7:0]   a_first_counter;
  reg  [2:0]   opcode;
  reg  [2:0]   param;
  reg  [3:0]   size;
  reg  [4:0]   source;
  reg  [31:0]  address;
  wire         _GEN_78 = io_in_a_bits_opcode == opcode;
  wire         _GEN_79 = io_in_a_bits_param == param;
  wire         _GEN_80 = io_in_a_bits_size == size;
  wire         _GEN_81 = io_in_a_bits_source == source;
  wire         _GEN_82 = io_in_a_bits_address == address;
  wire         _d_first_T_3 = io_in_d_ready & io_in_d_valid;
  reg  [7:0]   d_first_counter;
  reg  [2:0]   opcode_1;
  reg  [1:0]   param_1;
  reg  [3:0]   size_1;
  reg  [4:0]   source_1;
  reg  [3:0]   sink;
  reg          denied;
  wire         _GEN_83 = io_in_d_bits_opcode == opcode_1;
  wire         _GEN_84 = io_in_d_bits_param == param_1;
  wire         _GEN_85 = io_in_d_bits_size == size_1;
  wire         _GEN_86 = io_in_d_bits_source == source_1;
  wire         _GEN_87 = io_in_d_bits_sink == sink;
  wire         _GEN_88 = io_in_d_bits_denied == denied;
  reg  [7:0]   b_first_counter;
  reg  [2:0]   opcode_2;
  reg  [1:0]   param_2;
  reg  [3:0]   size_2;
  reg  [4:0]   source_2;
  reg  [31:0]  address_1;
  wire         _GEN_89 = io_in_b_bits_opcode == opcode_2;
  wire         _GEN_90 = io_in_b_bits_param == param_2;
  wire         _GEN_91 = io_in_b_bits_size == size_2;
  wire         _GEN_92 = io_in_b_bits_source == source_2;
  wire         _GEN_93 = io_in_b_bits_address == address_1;
  wire         _c_first_T_1 = io_in_c_ready & io_in_c_valid;
  reg  [7:0]   c_first_counter;
  reg  [2:0]   opcode_3;
  reg  [2:0]   param_3;
  reg  [3:0]   size_3;
  reg  [4:0]   source_3;
  reg  [31:0]  address_2;
  wire         _GEN_94 = io_in_c_bits_opcode == opcode_3;
  wire         _GEN_95 = io_in_c_bits_param == param_3;
  wire         _GEN_96 = io_in_c_bits_size == size_3;
  wire         _GEN_97 = io_in_c_bits_source == source_3;
  wire         _GEN_98 = io_in_c_bits_address == address_2;
  reg  [16:0]  inflight;
  reg  [67:0]  inflight_opcodes;
  reg  [135:0] inflight_sizes;
  reg  [7:0]   a_first_counter_1;
  wire         a_first_1 = a_first_counter_1 == 8'h0;
  reg  [7:0]   d_first_counter_1;
  wire         d_first_1 = d_first_counter_1 == 8'h0;
  wire [67:0]  _a_opcode_lookup_T_1 = inflight_opcodes >> {61'h0, io_in_d_bits_source, 2'h0};
  wire [135:0] _GEN_99 = {128'h0, io_in_d_bits_source, 3'h0};
  wire [135:0] _a_size_lookup_T_1 = inflight_sizes >> _GEN_99;
  wire         _same_cycle_resp_T_1 = io_in_a_valid & a_first_1;
  wire [31:0]  _a_set_T = 32'h1 << io_in_a_bits_source;
  wire [16:0]  _GEN_27_0 = _same_cycle_resp_T_1 ? _a_set_T[16:0] : 17'h0;
  wire         _GEN_100 = _a_first_T_1 & a_first_1;
  wire [16:0]  _GEN_101 = inflight >> io_in_a_bits_source;
  wire         _GEN_102 = io_in_d_valid & d_first_1;
  wire         _GEN_103 = _GEN_102 & ~d_release_ack;
  wire [31:0]  _d_clr_T_1 = 32'h1 << io_in_d_bits_source;
  wire         _same_cycle_resp_T_2 = io_in_a_bits_source == io_in_d_bits_source;
  wire         same_cycle_resp = _same_cycle_resp_T_1 & _same_cycle_resp_T_2;
  wire [16:0]  _GEN_104 = {12'h0, io_in_d_bits_source};
  wire [16:0]  _GEN_105 = inflight >> _GEN_104;
  wire         _GEN_106 = _GEN_105[0] | same_cycle_resp;
  wire         _GEN_107 = _GEN_22 | _GEN_36 | _GEN_32;
  wire         _GEN_108 = io_in_d_bits_opcode == ((&io_in_a_bits_opcode) | _GEN_1 ? 3'h4 : _GEN_38 ? 3'h2 : {2'h0, _GEN_107}) | io_in_d_bits_opcode == ((&io_in_a_bits_opcode) ? 3'h4 : _GEN_1 ? 3'h5 : _GEN_38 ? 3'h2 : {2'h0, _GEN_107});
  wire         _GEN_109 = io_in_a_bits_size == io_in_d_bits_size;
  wire         _GEN_110 = _a_opcode_lookup_T_1[3:1] == 3'h4 | _a_opcode_lookup_T_1[3:1] == 3'h3 | _a_opcode_lookup_T_1[3:1] == 3'h2;
  wire         _GEN_111 = _a_opcode_lookup_T_1[3:1] == 3'h5;
  wire         _GEN_112 = _a_opcode_lookup_T_1[3:1] == 3'h6;
  wire         _GEN_113 = io_in_d_bits_opcode == ((&(_a_opcode_lookup_T_1[3:1])) | _GEN_112 ? 3'h4 : _GEN_111 ? 3'h2 : {2'h0, _GEN_110}) | io_in_d_bits_opcode == ((&(_a_opcode_lookup_T_1[3:1])) ? 3'h4 : _GEN_112 ? 3'h5 : _GEN_111 ? 3'h2 : {2'h0, _GEN_110});
  wire [7:0]   _GEN_114 = {4'h0, io_in_d_bits_size};
  wire         _GEN_115 = _GEN_114 == {1'h0, _a_size_lookup_T_1[7:1]};
  wire         _GEN_116 = ~io_in_d_ready | io_in_a_ready;
  wire         _GEN_117 = _GEN_27_0 != (_GEN_103 ? _d_clr_T_1[16:0] : 17'h0) | _GEN_27_0 == 17'h0;
  reg  [31:0]  watchdog;
  wire         _GEN_118 = inflight == 17'h0 | _plusarg_reader_out == 32'h0 | watchdog < _plusarg_reader_out;
  reg  [16:0]  inflight_1;
  reg  [135:0] inflight_sizes_1;
  reg  [7:0]   c_first_counter_1;
  wire         c_first_1 = c_first_counter_1 == 8'h0;
  reg  [7:0]   d_first_counter_2;
  wire         d_first_2 = d_first_counter_2 == 8'h0;
  wire [135:0] _c_size_lookup_T_1 = inflight_sizes_1 >> _GEN_99;
  wire         _same_cycle_resp_T_3 = io_in_c_valid & c_first_1;
  wire         _GEN_119 = io_in_c_bits_opcode[2] & io_in_c_bits_opcode[1];
  wire [31:0]  _c_set_T = 32'h1 << io_in_c_bits_source;
  wire [16:0]  _GEN_72_0 = _same_cycle_resp_T_3 & _GEN_119 ? _c_set_T[16:0] : 17'h0;
  wire         _GEN_120 = _c_first_T_1 & c_first_1 & _GEN_119;
  wire [16:0]  _GEN_121 = inflight_1 >> io_in_c_bits_source;
  wire         _GEN_122 = io_in_d_valid & d_first_2;
  wire         _GEN_123 = _GEN_122 & d_release_ack;
  wire         _same_cycle_resp_T_8 = io_in_c_bits_source == io_in_d_bits_source;
  wire         same_cycle_resp_1 = _same_cycle_resp_T_3 & io_in_c_bits_opcode[2] & io_in_c_bits_opcode[1] & _same_cycle_resp_T_8;
  wire [16:0]  _GEN_124 = inflight_1 >> _GEN_104;
  wire         _GEN_125 = _GEN_124[0] | same_cycle_resp_1;
  wire         _GEN_126 = io_in_d_bits_size == io_in_c_bits_size;
  wire         _GEN_127 = _GEN_114 == {1'h0, _c_size_lookup_T_1[7:1]};
  wire         _GEN_128 = ~io_in_d_ready | io_in_c_ready;
  wire         _GEN_129 = _GEN_72_0 != (_GEN_123 ? _d_clr_T_1[16:0] : 17'h0);
  reg  [31:0]  watchdog_1;
  wire         _GEN_130 = inflight_1 == 17'h0 | _plusarg_reader_1_out == 32'h0 | watchdog_1 < _plusarg_reader_1_out;
  reg  [15:0]  inflight_2;
  reg  [7:0]   d_first_counter_3;
  wire         d_first_3 = d_first_counter_3 == 8'h0;
  wire         _GEN_131 = _d_first_T_3 & d_first_3 & io_in_d_bits_opcode[2] & ~(io_in_d_bits_opcode[1]);
  wire [15:0]  _GEN_132 = {12'h0, io_in_d_bits_sink};
  wire [15:0]  _GEN_133 = inflight_2 >> _GEN_132;
  wire [15:0]  d_set = _GEN_131 ? 16'h1 << _GEN_132 : 16'h0;
  wire         _GEN_134 = io_in_e_ready & io_in_e_valid;
  wire [15:0]  _GEN_135 = {12'h0, io_in_e_bits_sink};
  wire [15:0]  _GEN_136 = (d_set | inflight_2) >> _GEN_135;
  wire         _GEN_137 = io_in_a_valid & _GEN_1 & ~reset;
  wire         _GEN_138 = io_in_a_valid & (&io_in_a_bits_opcode) & ~reset;
  wire         _GEN_139 = io_in_a_valid & _GEN_22 & ~reset;
  wire         _GEN_140 = io_in_a_valid & io_in_a_bits_opcode == 3'h0 & ~reset;
  wire         _GEN_141 = io_in_a_valid & io_in_a_bits_opcode == 3'h1 & ~reset;
  wire         _GEN_142 = io_in_a_valid & _GEN_32 & ~reset;
  wire         _GEN_143 = io_in_a_valid & _GEN_36 & ~reset;
  wire         _GEN_144 = io_in_a_valid & _GEN_38 & ~reset;
  wire         _GEN_145 = io_in_d_valid & ~reset;
  wire         _GEN_146 = io_in_d_valid & d_release_ack & ~reset;
  wire         _GEN_147 = io_in_d_valid & io_in_d_bits_opcode == 3'h4 & ~reset;
  wire         _GEN_148 = io_in_d_valid & io_in_d_bits_opcode == 3'h5 & ~reset;
  wire         _GEN_149 = io_in_d_valid & io_in_d_bits_opcode == 3'h0 & ~reset;
  wire         _GEN_150 = io_in_d_valid & io_in_d_bits_opcode == 3'h1 & ~reset;
  wire         _GEN_151 = io_in_d_valid & io_in_d_bits_opcode == 3'h2 & ~reset;
  wire         _GEN_152 = io_in_b_valid & ~reset;
  wire         _GEN_153 = io_in_b_valid & io_in_b_bits_opcode == 3'h6 & ~reset;
  wire         _GEN_154 = io_in_b_valid & io_in_b_bits_opcode == 3'h4 & ~reset;
  wire         _GEN_155 = io_in_b_valid & io_in_b_bits_opcode == 3'h0 & ~reset;
  wire         _GEN_156 = io_in_b_valid & io_in_b_bits_opcode == 3'h1 & ~reset;
  wire         _GEN_157 = io_in_b_valid & io_in_b_bits_opcode == 3'h2 & ~reset;
  wire         _GEN_158 = io_in_b_valid & io_in_b_bits_opcode == 3'h3 & ~reset;
  wire         _GEN_159 = io_in_b_valid & io_in_b_bits_opcode == 3'h5 & ~reset;
  wire         _GEN_160 = io_in_c_valid & _c_probe_ack_T & ~reset;
  wire         _GEN_161 = io_in_c_valid & _c_probe_ack_T_1 & ~reset;
  wire         _GEN_162 = io_in_c_valid & io_in_c_bits_opcode == 3'h6 & ~reset;
  wire         _GEN_163 = io_in_c_valid & (&io_in_c_bits_opcode) & ~reset;
  wire         _GEN_164 = io_in_c_valid & io_in_c_bits_opcode == 3'h0 & ~reset;
  wire         _GEN_165 = io_in_c_valid & io_in_c_bits_opcode == 3'h1 & ~reset;
  wire         _GEN_166 = io_in_c_valid & io_in_c_bits_opcode == 3'h2 & ~reset;
  wire         _GEN_167 = io_in_a_valid & (|a_first_counter) & ~reset;
  wire         _GEN_168 = io_in_d_valid & (|d_first_counter) & ~reset;
  wire         _GEN_169 = io_in_b_valid & (|b_first_counter) & ~reset;
  wire         _GEN_170 = io_in_c_valid & (|c_first_counter) & ~reset;
  wire         _GEN_171 = _GEN_100 & ~reset;
  wire         _GEN_172 = _GEN_103 & ~reset;
  wire         _GEN_173 = _GEN_103 & same_cycle_resp & ~reset;
  wire         _GEN_174 = _GEN_103 & ~same_cycle_resp & ~reset;
  wire         _GEN_175 = _GEN_102 & a_first_1 & io_in_a_valid & _same_cycle_resp_T_2 & ~d_release_ack & ~reset;
  wire         _GEN_176 = _GEN_120 & ~reset;
  wire         _GEN_177 = _GEN_123 & ~reset;
  wire         _GEN_178 = _GEN_123 & same_cycle_resp_1 & ~reset;
  wire         _GEN_179 = _GEN_123 & ~same_cycle_resp_1 & ~reset;
  wire         _GEN_180 = _GEN_122 & c_first_1 & io_in_c_valid & _same_cycle_resp_T_8 & d_release_ack & ~(_c_probe_ack_T | _c_probe_ack_T_1) & ~reset;
  wire         _GEN_181 = (|_GEN_72_0) & ~reset;
  wire         _GEN_182 = _GEN_131 & ~reset;
  wire         _GEN_183 = _GEN_134 & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_137 & ~_GEN_6)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquireBlock type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_137 & ~_GEN_17)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquireBlock from a client which does not support Probe (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_137 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_137 & ~(|(io_in_a_bits_size[3:2])))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock smaller than a beat (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_137 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_137 & ~_GEN_18)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock carries invalid grow param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_137 & _GEN_19)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquireBlock contains invalid mask (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_138 & ~_GEN_20)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquirePerm type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_138 & ~_GEN_21)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries AcquirePerm from a client which does not support Probe (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_138 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_138 & ~(|(io_in_a_bits_size[3:2])))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm smaller than a beat (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_138 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_138 & ~_GEN_18)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm carries invalid grow param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_138 & ~(|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm requests NtoB (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_138 & _GEN_19)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel AcquirePerm contains invalid mask (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_139 & ~_GEN_23)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Get type which master claims it can't emit (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_139 & ~_GEN_26)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Get type which slave claims it can't support (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_139 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_139 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_139 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get carries invalid param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_139 & ~_GEN_27)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Get contains invalid mask (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_140 & ~_GEN_29)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries PutFull type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_140 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_140 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_140 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull carries invalid param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_140 & ~_GEN_27)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutFull contains invalid mask (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_141 & ~_GEN_30)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries PutPartial type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_141 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_141 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_141 & (|io_in_a_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial carries invalid param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_141 & (|_GEN_31))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel PutPartial contains invalid mask (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_142 & ~_GEN_34)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Arithmetic type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_142 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_142 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_142 & ~_GEN_35)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic carries invalid opcode param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_142 & ~_GEN_27)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Arithmetic contains invalid mask (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_143 & ~_GEN_37)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Logical type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_143 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_143 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_143 & io_in_a_bits_param[2])
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical carries invalid opcode param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_143 & ~_GEN_27)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Logical contains invalid mask (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_144 & ~_GEN_39)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel carries Hint type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_144 & ~source_ok)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_144 & (|_GEN_0))
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_144 & ~_GEN_40)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint carries invalid opcode param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_144 & ~_GEN_27)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel Hint contains invalid mask (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_145 & ~_GEN_41)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel has invalid opcode (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_146 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_146 & ~(|(io_in_d_bits_size[3:2])))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck smaller than a beat (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_146 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseeAck carries invalid param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_146 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck is corrupt (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_146 & io_in_d_bits_denied)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel ReleaseAck is denied (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_147 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_147 & ~(|(io_in_d_bits_size[3:2])))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant smaller than a beat (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_147 & ~_GEN_42)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries invalid cap param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_147 & ~_GEN_43)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant carries toN param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_147 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel Grant is corrupt (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_148 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_148 & ~(|(io_in_d_bits_size[3:2])))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData smaller than a beat (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_148 & ~_GEN_42)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries invalid cap param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_148 & ~_GEN_43)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData carries toN param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_148 & ~_GEN_44)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel GrantData is denied but not corrupt (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_149 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_149 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck carries invalid param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_149 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAck is corrupt (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_150 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_150 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData carries invalid param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_150 & ~_GEN_44)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel AccessAckData is denied but not corrupt (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_151 & ~source_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_151 & (|io_in_d_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck carries invalid param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_151 & io_in_d_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel HintAck is corrupt (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_152 & ~_GEN_45)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel has invalid opcode (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_153 & ~_GEN_55)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel carries Probe type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_153 & ~address_ok)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Probe carries unmanaged address (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_153 & ~legal_source)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Probe carries source that is not first source (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_153 & (|_GEN_54))
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Probe address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_153 & ~_GEN_56)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Probe carries invalid cap param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_153 & ~_GEN_57)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Probe contains invalid mask (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_153 & io_in_b_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Probe is corrupt (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_154)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel carries Get type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_154 & ~address_ok)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Get carries unmanaged address (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_154 & ~legal_source)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Get carries source that is not first source (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_154 & (|_GEN_54))
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Get address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_154 & (|io_in_b_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Get carries invalid param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_154 & ~_GEN_57)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Get contains invalid mask (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_154 & io_in_b_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Get is corrupt (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_155)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel carries PutFull type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_155 & ~address_ok)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel PutFull carries unmanaged address (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_155 & ~legal_source)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel PutFull carries source that is not first source (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_155 & (|_GEN_54))
        $fwrite(32'h80000002, "Assertion failed: 'B' channel PutFull address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_155 & (|io_in_b_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'B' channel PutFull carries invalid param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_155 & ~_GEN_57)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel PutFull contains invalid mask (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_156)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel carries PutPartial type which is unexpected using diplomatic parameters (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_156 & ~address_ok)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel PutPartial carries unmanaged address (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_156 & ~legal_source)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel PutPartial carries source that is not first source (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_156 & (|_GEN_54))
        $fwrite(32'h80000002, "Assertion failed: 'B' channel PutPartial address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_156 & (|io_in_b_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'B' channel PutPartial carries invalid param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_156 & (|_GEN_58))
        $fwrite(32'h80000002, "Assertion failed: 'B' channel PutPartial contains invalid mask (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_157)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel carries Arithmetic type unsupported by master (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_157 & ~address_ok)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Arithmetic carries unmanaged address (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_157 & ~legal_source)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Arithmetic carries source that is not first source (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_157 & (|_GEN_54))
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Arithmetic address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_157 & ~_GEN_57)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Arithmetic contains invalid mask (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_158)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel carries Logical type unsupported by client (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_158 & ~address_ok)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Logical carries unmanaged address (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_158 & ~legal_source)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Logical carries source that is not first source (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_158 & (|_GEN_54))
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Logical address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_158 & ~_GEN_57)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Logical contains invalid mask (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_159)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel carries Hint type unsupported by client (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_159 & ~address_ok)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Hint carries unmanaged address (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_159 & ~legal_source)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Hint carries source that is not first source (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_159 & (|_GEN_54))
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Hint address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_159 & ~_GEN_57)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Hint contains invalid mask (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_159 & io_in_b_bits_corrupt)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel Hint is corrupt (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_160 & ~address_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAck carries unmanaged address (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_160 & ~source_ok_2)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAck carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_160 & ~(|(io_in_c_bits_size[3:2])))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAck smaller than a beat (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_160 & (|_GEN_60))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAck address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_160 & ~_GEN_69)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAck carries invalid report param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_161 & ~address_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAckData carries unmanaged address (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_161 & ~source_ok_2)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAckData carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_161 & ~(|(io_in_c_bits_size[3:2])))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAckData smaller than a beat (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_161 & (|_GEN_60))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAckData address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_161 & ~_GEN_69)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ProbeAckData carries invalid report param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_162 & ~_GEN_73)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel carries Release type unsupported by manager (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_162 & ~_GEN_75)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel carries Release from a client which does not support Probe (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_162 & ~source_ok_2)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel Release carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_162 & ~(|(io_in_c_bits_size[3:2])))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel Release smaller than a beat (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_162 & (|_GEN_60))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel Release address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_162 & ~_GEN_69)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel Release carries invalid report param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_163 & ~_GEN_76)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel carries ReleaseData type unsupported by manager (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_163 & ~_GEN_77)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel carries Release from a client which does not support Probe (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_163 & ~source_ok_2)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ReleaseData carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_163 & ~(|(io_in_c_bits_size[3:2])))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ReleaseData smaller than a beat (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_163 & (|_GEN_60))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ReleaseData address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_163 & ~_GEN_69)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel ReleaseData carries invalid report param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_164 & ~address_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAck carries unmanaged address (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_164 & ~source_ok_2)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAck carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_164 & (|_GEN_60))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAck address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_164 & (|io_in_c_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAck carries invalid param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_165 & ~address_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAckData carries unmanaged address (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_165 & ~source_ok_2)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAckData carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_165 & (|_GEN_60))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAckData address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_165 & (|io_in_c_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel AccessAckData carries invalid param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_166 & ~address_ok_1)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel HintAck carries unmanaged address (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_166 & ~source_ok_2)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel HintAck carries invalid source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_166 & (|_GEN_60))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel HintAck address not aligned to size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_166 & (|io_in_c_bits_param))
        $fwrite(32'h80000002, "Assertion failed: 'C' channel HintAck carries invalid param (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_167 & ~_GEN_78)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel opcode changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_167 & ~_GEN_79)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel param changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_167 & ~_GEN_80)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel size changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_167 & ~_GEN_81)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel source changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_167 & ~_GEN_82)
        $fwrite(32'h80000002, "Assertion failed: 'A' channel address changed with multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_168 & ~_GEN_83)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel opcode changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_168 & ~_GEN_84)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel param changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_168 & ~_GEN_85)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel size changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_168 & ~_GEN_86)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel source changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_168 & ~_GEN_87)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel sink changed with multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_168 & ~_GEN_88)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel denied changed with multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_169 & ~_GEN_89)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel opcode changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_169 & ~_GEN_90)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel param changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_169 & ~_GEN_91)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel size changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_169 & ~_GEN_92)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel source changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_169 & ~_GEN_93)
        $fwrite(32'h80000002, "Assertion failed: 'B' channel addresss changed with multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_170 & ~_GEN_94)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel opcode changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_170 & ~_GEN_95)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel param changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_170 & ~_GEN_96)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel size changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_170 & ~_GEN_97)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel source changed within multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_170 & ~_GEN_98)
        $fwrite(32'h80000002, "Assertion failed: 'C' channel address changed with multibeat operation (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_171 & _GEN_101[0])
        $fwrite(32'h80000002, "Assertion failed: 'A' channel re-used a source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_172 & ~_GEN_106)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_173 & ~_GEN_108)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_173 & ~_GEN_109)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_174 & ~_GEN_113)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper opcode response (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_174 & ~_GEN_115)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_175 & ~_GEN_116)
        $fwrite(32'h80000002, "Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_117)
        $fwrite(32'h80000002, "Assertion failed: 'A' and 'D' concurrent, despite minlatency 4 (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_118)
        $fwrite(32'h80000002, "Assertion failed: TileLink timeout expired (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_176 & _GEN_121[0])
        $fwrite(32'h80000002, "Assertion failed: 'C' channel re-used a source ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_177 & ~_GEN_125)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_178 & ~_GEN_126)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_179 & ~_GEN_127)
        $fwrite(32'h80000002, "Assertion failed: 'D' channel contains improper response size (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_180 & ~_GEN_128)
        $fwrite(32'h80000002, "Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_181 & ~_GEN_129)
        $fwrite(32'h80000002, "Assertion failed: 'C' and 'D' concurrent, despite minlatency 4 (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_130)
        $fwrite(32'h80000002, "Assertion failed: TileLink timeout expired (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_182 & _GEN_133[0])
        $fwrite(32'h80000002, "Assertion failed: 'D' channel re-used a sink ID (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:49 assert(cond, message)\n");
      if ((`PRINTF_COND_) & _GEN_183 & ~(_GEN_136[0]))
        $fwrite(32'h80000002, "Assertion failed: 'E' channel acknowledged for nothing inflight (connected at generators/rocket-chip/src/main/scala/tilelink/CrossingHelper.scala:61:80)\n    at Monitor.scala:42 assert(cond, message)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire [26:0]  _a_first_beats1_decode_T_1 = 27'hFFF << _GEN;
  wire [26:0]  _a_first_beats1_decode_T_5 = 27'hFFF << _GEN;
  wire [26:0]  _GEN_184 = {23'h0, io_in_d_bits_size};
  wire [26:0]  _d_first_beats1_decode_T_1 = 27'hFFF << _GEN_184;
  wire [26:0]  _d_first_beats1_decode_T_5 = 27'hFFF << _GEN_184;
  wire [26:0]  _d_first_beats1_decode_T_9 = 27'hFFF << _GEN_184;
  wire [26:0]  _d_first_beats1_decode_T_13 = 27'hFFF << _GEN_184;
  wire [26:0]  _c_first_beats1_decode_T_1 = 27'hFFF << _GEN_59;
  wire [26:0]  _c_first_beats1_decode_T_5 = 27'hFFF << _GEN_59;
  wire         _GEN_185 = _d_first_T_3 & d_first_1 & ~d_release_ack;
  wire [270:0] _GEN_186 = {263'h0, io_in_d_bits_source, 3'h0};
  wire         _GEN_187 = _d_first_T_3 & d_first_2 & d_release_ack;
  wire [270:0] _d_opcodes_clr_T_5 = 271'hF << {264'h0, io_in_d_bits_source, 2'h0};
  wire [258:0] _a_opcodes_set_T_1 = {255'h0, _GEN_100 ? {io_in_a_bits_opcode, 1'h1} : 4'h0} << {252'h0, io_in_a_bits_source, 2'h0};
  wire [270:0] _d_sizes_clr_T_5 = 271'hFF << _GEN_186;
  wire [259:0] _a_sizes_set_T_1 = {255'h0, _GEN_100 ? {io_in_a_bits_size, 1'h1} : 5'h0} << {252'h0, io_in_a_bits_source, 3'h0};
  wire [270:0] _d_sizes_clr_T_11 = 271'hFF << _GEN_186;
  wire [259:0] _c_sizes_set_T_1 = {255'h0, _GEN_120 ? {io_in_c_bits_size, 1'h1} : 5'h0} << {252'h0, io_in_c_bits_source, 3'h0};
  wire         b_first_done = io_in_b_ready & io_in_b_valid;
  always @(posedge clock) begin
    if (_GEN_137) begin
      assert__assert_2: assert(_GEN_6);
      assert__assert_3: assert(_GEN_17);
      assert__assert_4: assert(source_ok);
      assert__assert_5: assert(|(io_in_a_bits_size[3:2]));
      assert__assert_6: assert(~(|_GEN_0));
      assert__assert_7: assert(_GEN_18);
      assert__assert_8: assert(~_GEN_19);
    end
    if (_GEN_138) begin
      assert__assert_10: assert(_GEN_20);
      assert__assert_11: assert(_GEN_21);
      assert__assert_12: assert(source_ok);
      assert__assert_13: assert(|(io_in_a_bits_size[3:2]));
      assert__assert_14: assert(~(|_GEN_0));
      assert__assert_15: assert(_GEN_18);
      assert__assert_16: assert(|io_in_a_bits_param);
      assert__assert_17: assert(~_GEN_19);
    end
    if (_GEN_139) begin
      assert__assert_19: assert(_GEN_23);
      assert__assert_20: assert(_GEN_26);
      assert__assert_21: assert(source_ok);
      assert__assert_22: assert(~(|_GEN_0));
      assert__assert_23: assert(~(|io_in_a_bits_param));
      assert__assert_24: assert(_GEN_27);
    end
    if (_GEN_140) begin
      assert__assert_26: assert(_GEN_29);
      assert__assert_27: assert(source_ok);
      assert__assert_28: assert(~(|_GEN_0));
      assert__assert_29: assert(~(|io_in_a_bits_param));
      assert__assert_30: assert(_GEN_27);
    end
    if (_GEN_141) begin
      assert__assert_31: assert(_GEN_30);
      assert__assert_32: assert(source_ok);
      assert__assert_33: assert(~(|_GEN_0));
      assert__assert_34: assert(~(|io_in_a_bits_param));
      assert__assert_35: assert(~(|_GEN_31));
    end
    if (_GEN_142) begin
      assert__assert_36: assert(_GEN_34);
      assert__assert_37: assert(source_ok);
      assert__assert_38: assert(~(|_GEN_0));
      assert__assert_39: assert(_GEN_35);
      assert__assert_40: assert(_GEN_27);
    end
    if (_GEN_143) begin
      assert__assert_41: assert(_GEN_37);
      assert__assert_42: assert(source_ok);
      assert__assert_43: assert(~(|_GEN_0));
      assert__assert_44: assert(~(io_in_a_bits_param[2]));
      assert__assert_45: assert(_GEN_27);
    end
    if (_GEN_144) begin
      assert__assert_46: assert(_GEN_39);
      assert__assert_47: assert(source_ok);
      assert__assert_48: assert(~(|_GEN_0));
      assert__assert_49: assert(_GEN_40);
      assert__assert_50: assert(_GEN_27);
    end
    if (_GEN_145)
      assert__assert_52: assert(_GEN_41);
    if (_GEN_146) begin
      assert__assert_53: assert(source_ok_1);
      assert__assert_54: assert(|(io_in_d_bits_size[3:2]));
      assert__assert_55: assert(~(|io_in_d_bits_param));
      assert__assert_56: assert(~io_in_d_bits_corrupt);
      assert__assert_57: assert(~io_in_d_bits_denied);
    end
    if (_GEN_147) begin
      assert__assert_58: assert(source_ok_1);
      assert__assert_60: assert(|(io_in_d_bits_size[3:2]));
      assert__assert_61: assert(_GEN_42);
      assert__assert_62: assert(_GEN_43);
      assert__assert_63: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_148) begin
      assert__assert_65: assert(source_ok_1);
      assert__assert_67: assert(|(io_in_d_bits_size[3:2]));
      assert__assert_68: assert(_GEN_42);
      assert__assert_69: assert(_GEN_43);
      assert__assert_70: assert(_GEN_44);
    end
    if (_GEN_149) begin
      assert__assert_72: assert(source_ok_1);
      assert__assert_73: assert(~(|io_in_d_bits_param));
      assert__assert_74: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_150) begin
      assert__assert_76: assert(source_ok_1);
      assert__assert_77: assert(~(|io_in_d_bits_param));
      assert__assert_78: assert(_GEN_44);
    end
    if (_GEN_151) begin
      assert__assert_80: assert(source_ok_1);
      assert__assert_81: assert(~(|io_in_d_bits_param));
      assert__assert_82: assert(~io_in_d_bits_corrupt);
    end
    if (_GEN_152)
      assert__assert_84: assert(_GEN_45);
    if (_GEN_153) begin
      assert__assert_86: assert(_GEN_55);
      assert__assert_87: assert(address_ok);
      assert__assert_88: assert(legal_source);
      assert__assert_89: assert(~(|_GEN_54));
      assert__assert_90: assert(_GEN_56);
      assert__assert_91: assert(_GEN_57);
      assert__assert_92: assert(~io_in_b_bits_corrupt);
    end
    if (_GEN_154) begin
      assert__assert_93: assert(1'h0);
      assert__assert_94: assert(address_ok);
      assert__assert_95: assert(legal_source);
      assert__assert_96: assert(~(|_GEN_54));
      assert__assert_97: assert(~(|io_in_b_bits_param));
      assert__assert_98: assert(_GEN_57);
      assert__assert_99: assert(~io_in_b_bits_corrupt);
    end
    if (_GEN_155) begin
      assert__assert_100: assert(1'h0);
      assert__assert_101: assert(address_ok);
      assert__assert_102: assert(legal_source);
      assert__assert_103: assert(~(|_GEN_54));
      assert__assert_104: assert(~(|io_in_b_bits_param));
      assert__assert_105: assert(_GEN_57);
    end
    if (_GEN_156) begin
      assert__assert_106: assert(1'h0);
      assert__assert_107: assert(address_ok);
      assert__assert_108: assert(legal_source);
      assert__assert_109: assert(~(|_GEN_54));
      assert__assert_110: assert(~(|io_in_b_bits_param));
      assert__assert_111: assert(~(|_GEN_58));
    end
    if (_GEN_157) begin
      assert__assert_112: assert(1'h0);
      assert__assert_113: assert(address_ok);
      assert__assert_114: assert(legal_source);
      assert__assert_115: assert(~(|_GEN_54));
      assert__assert_117: assert(_GEN_57);
    end
    if (_GEN_158) begin
      assert__assert_118: assert(1'h0);
      assert__assert_119: assert(address_ok);
      assert__assert_120: assert(legal_source);
      assert__assert_121: assert(~(|_GEN_54));
      assert__assert_123: assert(_GEN_57);
    end
    if (_GEN_159) begin
      assert__assert_124: assert(1'h0);
      assert__assert_125: assert(address_ok);
      assert__assert_126: assert(legal_source);
      assert__assert_127: assert(~(|_GEN_54));
      assert__assert_128: assert(_GEN_57);
      assert__assert_129: assert(~io_in_b_bits_corrupt);
    end
    if (_GEN_160) begin
      assert__assert_132: assert(address_ok_1);
      assert__assert_133: assert(source_ok_2);
      assert__assert_134: assert(|(io_in_c_bits_size[3:2]));
      assert__assert_135: assert(~(|_GEN_60));
      assert__assert_136: assert(_GEN_69);
    end
    if (_GEN_161) begin
      assert__assert_138: assert(address_ok_1);
      assert__assert_139: assert(source_ok_2);
      assert__assert_140: assert(|(io_in_c_bits_size[3:2]));
      assert__assert_141: assert(~(|_GEN_60));
      assert__assert_142: assert(_GEN_69);
    end
    if (_GEN_162) begin
      assert__assert_143: assert(_GEN_73);
      assert__assert_144: assert(_GEN_75);
      assert__assert_145: assert(source_ok_2);
      assert__assert_146: assert(|(io_in_c_bits_size[3:2]));
      assert__assert_147: assert(~(|_GEN_60));
      assert__assert_148: assert(_GEN_69);
    end
    if (_GEN_163) begin
      assert__assert_150: assert(_GEN_76);
      assert__assert_151: assert(_GEN_77);
      assert__assert_152: assert(source_ok_2);
      assert__assert_153: assert(|(io_in_c_bits_size[3:2]));
      assert__assert_154: assert(~(|_GEN_60));
      assert__assert_155: assert(_GEN_69);
    end
    if (_GEN_164) begin
      assert__assert_156: assert(address_ok_1);
      assert__assert_157: assert(source_ok_2);
      assert__assert_158: assert(~(|_GEN_60));
      assert__assert_159: assert(~(|io_in_c_bits_param));
    end
    if (_GEN_165) begin
      assert__assert_161: assert(address_ok_1);
      assert__assert_162: assert(source_ok_2);
      assert__assert_163: assert(~(|_GEN_60));
      assert__assert_164: assert(~(|io_in_c_bits_param));
    end
    if (_GEN_166) begin
      assert__assert_165: assert(address_ok_1);
      assert__assert_166: assert(source_ok_2);
      assert__assert_167: assert(~(|_GEN_60));
      assert__assert_168: assert(~(|io_in_c_bits_param));
    end
    if (_GEN_167) begin
      assert__assert_171: assert(_GEN_78);
      assert__assert_172: assert(_GEN_79);
      assert__assert_173: assert(_GEN_80);
      assert__assert_174: assert(_GEN_81);
      assert__assert_175: assert(_GEN_82);
    end
    if (_GEN_168) begin
      assert__assert_176: assert(_GEN_83);
      assert__assert_177: assert(_GEN_84);
      assert__assert_178: assert(_GEN_85);
      assert__assert_179: assert(_GEN_86);
      assert__assert_180: assert(_GEN_87);
      assert__assert_181: assert(_GEN_88);
    end
    if (_GEN_169) begin
      assert__assert_182: assert(_GEN_89);
      assert__assert_183: assert(_GEN_90);
      assert__assert_184: assert(_GEN_91);
      assert__assert_185: assert(_GEN_92);
      assert__assert_186: assert(_GEN_93);
    end
    if (_GEN_170) begin
      assert__assert_187: assert(_GEN_94);
      assert__assert_188: assert(_GEN_95);
      assert__assert_189: assert(_GEN_96);
      assert__assert_190: assert(_GEN_97);
      assert__assert_191: assert(_GEN_98);
    end
    if (_GEN_171)
      assert__assert_192: assert(~(_GEN_101[0]));
    if (_GEN_172)
      assert__assert_193: assert(_GEN_106);
    if (_GEN_173) begin
      assert__assert_194: assert(_GEN_108);
      assert__assert_195: assert(_GEN_109);
    end
    if (_GEN_174) begin
      assert__assert_196: assert(_GEN_113);
      assert__assert_197: assert(_GEN_115);
    end
    if (_GEN_175)
      assert__assert_198: assert(_GEN_116);
    if (~reset) begin
      assert__assert_199: assert(_GEN_117);
      assert__assert_200: assert(_GEN_118);
    end
    if (_GEN_176)
      assert__assert_201: assert(~(_GEN_121[0]));
    if (_GEN_177)
      assert__assert_202: assert(_GEN_125);
    if (_GEN_178)
      assert__assert_203: assert(_GEN_126);
    if (_GEN_179)
      assert__assert_204: assert(_GEN_127);
    if (_GEN_180)
      assert__assert_205: assert(_GEN_128);
    if (_GEN_181)
      assert__assert_206: assert(_GEN_129);
    if (~reset)
      assert__assert_207: assert(_GEN_130);
    if (_GEN_182)
      assert__assert_208: assert(~(_GEN_133[0]));
    if (_GEN_183)
      assert__assert_209: assert(_GEN_136[0]);
    if (reset) begin
      a_first_counter <= 8'h0;
      d_first_counter <= 8'h0;
      b_first_counter <= 8'h0;
      c_first_counter <= 8'h0;
      inflight <= 17'h0;
      inflight_opcodes <= 68'h0;
      inflight_sizes <= 136'h0;
      a_first_counter_1 <= 8'h0;
      d_first_counter_1 <= 8'h0;
      watchdog <= 32'h0;
      inflight_1 <= 17'h0;
      inflight_sizes_1 <= 136'h0;
      c_first_counter_1 <= 8'h0;
      d_first_counter_2 <= 8'h0;
      watchdog_1 <= 32'h0;
      inflight_2 <= 16'h0;
      d_first_counter_3 <= 8'h0;
    end
    else begin
      if (_a_first_T_1) begin
        if (|a_first_counter)
          a_first_counter <= a_first_counter - 8'h1;
        else if (io_in_a_bits_opcode[2])
          a_first_counter <= 8'h0;
        else
          a_first_counter <= ~(_a_first_beats1_decode_T_1[11:4]);
        if (a_first_1) begin
          if (io_in_a_bits_opcode[2])
            a_first_counter_1 <= 8'h0;
          else
            a_first_counter_1 <= ~(_a_first_beats1_decode_T_5[11:4]);
        end
        else
          a_first_counter_1 <= a_first_counter_1 - 8'h1;
      end
      if (_d_first_T_3) begin
        if (|d_first_counter)
          d_first_counter <= d_first_counter - 8'h1;
        else if (io_in_d_bits_opcode[0])
          d_first_counter <= ~(_d_first_beats1_decode_T_1[11:4]);
        else
          d_first_counter <= 8'h0;
        if (d_first_1) begin
          if (io_in_d_bits_opcode[0])
            d_first_counter_1 <= ~(_d_first_beats1_decode_T_5[11:4]);
          else
            d_first_counter_1 <= 8'h0;
        end
        else
          d_first_counter_1 <= d_first_counter_1 - 8'h1;
        if (d_first_2) begin
          if (io_in_d_bits_opcode[0])
            d_first_counter_2 <= ~(_d_first_beats1_decode_T_9[11:4]);
          else
            d_first_counter_2 <= 8'h0;
        end
        else
          d_first_counter_2 <= d_first_counter_2 - 8'h1;
        if (d_first_3) begin
          if (io_in_d_bits_opcode[0])
            d_first_counter_3 <= ~(_d_first_beats1_decode_T_13[11:4]);
          else
            d_first_counter_3 <= 8'h0;
        end
        else
          d_first_counter_3 <= d_first_counter_3 - 8'h1;
      end
      if (b_first_done) begin
        if (|b_first_counter)
          b_first_counter <= b_first_counter - 8'h1;
        else
          b_first_counter <= 8'h0;
      end
      if (_c_first_T_1) begin
        if (|c_first_counter)
          c_first_counter <= c_first_counter - 8'h1;
        else if (io_in_c_bits_opcode[0])
          c_first_counter <= ~(_c_first_beats1_decode_T_1[11:4]);
        else
          c_first_counter <= 8'h0;
        if (c_first_1) begin
          if (io_in_c_bits_opcode[0])
            c_first_counter_1 <= ~(_c_first_beats1_decode_T_5[11:4]);
          else
            c_first_counter_1 <= 8'h0;
        end
        else
          c_first_counter_1 <= c_first_counter_1 - 8'h1;
      end
      inflight <= (inflight | (_GEN_100 ? _a_set_T[16:0] : 17'h0)) & ~(_GEN_185 ? _d_clr_T_1[16:0] : 17'h0);
      inflight_opcodes <= (inflight_opcodes | (_GEN_100 ? _a_opcodes_set_T_1[67:0] : 68'h0)) & ~(_GEN_185 ? _d_opcodes_clr_T_5[67:0] : 68'h0);
      inflight_sizes <= (inflight_sizes | (_GEN_100 ? _a_sizes_set_T_1[135:0] : 136'h0)) & ~(_GEN_185 ? _d_sizes_clr_T_5[135:0] : 136'h0);
      if (_a_first_T_1 | _d_first_T_3)
        watchdog <= 32'h0;
      else
        watchdog <= watchdog + 32'h1;
      inflight_1 <= (inflight_1 | (_GEN_120 ? _c_set_T[16:0] : 17'h0)) & ~(_GEN_187 ? _d_clr_T_1[16:0] : 17'h0);
      inflight_sizes_1 <= (inflight_sizes_1 | (_GEN_120 ? _c_sizes_set_T_1[135:0] : 136'h0)) & ~(_GEN_187 ? _d_sizes_clr_T_11[135:0] : 136'h0);
      if (_c_first_T_1 | _d_first_T_3)
        watchdog_1 <= 32'h0;
      else
        watchdog_1 <= watchdog_1 + 32'h1;
      inflight_2 <= (inflight_2 | d_set) & ~(_GEN_134 ? 16'h1 << _GEN_135 : 16'h0);
    end
    if (_a_first_T_1 & ~(|a_first_counter)) begin
      opcode <= io_in_a_bits_opcode;
      param <= io_in_a_bits_param;
      size <= io_in_a_bits_size;
      source <= io_in_a_bits_source;
      address <= io_in_a_bits_address;
    end
    if (_d_first_T_3 & ~(|d_first_counter)) begin
      opcode_1 <= io_in_d_bits_opcode;
      param_1 <= io_in_d_bits_param;
      size_1 <= io_in_d_bits_size;
      source_1 <= io_in_d_bits_source;
      sink <= io_in_d_bits_sink;
      denied <= io_in_d_bits_denied;
    end
    if (b_first_done & ~(|b_first_counter)) begin
      opcode_2 <= io_in_b_bits_opcode;
      param_2 <= io_in_b_bits_param;
      size_2 <= io_in_b_bits_size;
      source_2 <= io_in_b_bits_source;
      address_1 <= io_in_b_bits_address;
    end
    if (_c_first_T_1 & ~(|c_first_counter)) begin
      opcode_3 <= io_in_c_bits_opcode;
      param_3 <= io_in_c_bits_param;
      size_3 <= io_in_c_bits_size;
      source_3 <= io_in_c_bits_source;
      address_2 <= io_in_c_bits_address;
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

