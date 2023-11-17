// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLAtomicAutomata(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
                auto_in_a_bits_size,
  input  [6:0]  auto_in_a_bits_source,
  input  [28:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input  [63:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
                auto_in_d_ready,
                auto_out_a_ready,
                auto_out_d_valid,
  input  [2:0]  auto_out_d_bits_opcode,
  input  [1:0]  auto_out_d_bits_param,
  input  [2:0]  auto_out_d_bits_size,
  input  [6:0]  auto_out_d_bits_source,
  input         auto_out_d_bits_sink,
                auto_out_d_bits_denied,
  input  [63:0] auto_out_d_bits_data,
  input         auto_out_d_bits_corrupt,
  output        auto_in_a_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
  output [1:0]  auto_in_d_bits_param,
  output [2:0]  auto_in_d_bits_size,
  output [6:0]  auto_in_d_bits_source,
  output        auto_in_d_bits_sink,
                auto_in_d_bits_denied,
  output [63:0] auto_in_d_bits_data,
  output        auto_in_d_bits_corrupt,
                auto_out_a_valid,
  output [2:0]  auto_out_a_bits_opcode,
                auto_out_a_bits_param,
                auto_out_a_bits_size,
  output [6:0]  auto_out_a_bits_source,
  output [28:0] auto_out_a_bits_address,
  output [7:0]  auto_out_a_bits_mask,
  output [63:0] auto_out_a_bits_data,
  output        auto_out_a_bits_corrupt,
                auto_out_d_ready
);

  reg  [3:0]  casez_tmp;
  reg  [1:0]  cam_s_0_state;
  reg  [2:0]  cam_a_0_bits_opcode;
  reg  [2:0]  cam_a_0_bits_param;
  reg  [2:0]  source_c_bits_size;
  reg  [6:0]  source_c_bits_source;
  reg  [28:0] source_c_bits_address;
  reg  [7:0]  cam_a_0_bits_mask;
  reg  [63:0] cam_a_0_bits_data;
  reg         cam_a_0_bits_corrupt;
  reg         cam_a_0_fifoId;
  reg  [3:0]  cam_a_0_lut;
  reg  [63:0] cam_d_0_data;
  reg         cam_d_0_denied;
  reg         cam_d_0_corrupt;
  wire        cam_free_0 = cam_s_0_state == 2'h0;
  wire        cam_amo_0 = cam_s_0_state == 2'h2;
  wire        a_isSupported = auto_in_a_bits_opcode != 3'h3 & auto_in_a_bits_opcode != 3'h2;
  wire [3:0]  _logic_out_T = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[0], cam_d_0_data[0]};
  wire [3:0]  _logic_out_T_2 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[1], cam_d_0_data[1]};
  wire [3:0]  _logic_out_T_4 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[2], cam_d_0_data[2]};
  wire [3:0]  _logic_out_T_6 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[3], cam_d_0_data[3]};
  wire [3:0]  _logic_out_T_8 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[4], cam_d_0_data[4]};
  wire [3:0]  _logic_out_T_10 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[5], cam_d_0_data[5]};
  wire [3:0]  _logic_out_T_12 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[6], cam_d_0_data[6]};
  wire [3:0]  _logic_out_T_14 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[7], cam_d_0_data[7]};
  wire [3:0]  _logic_out_T_16 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[8], cam_d_0_data[8]};
  wire [3:0]  _logic_out_T_18 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[9], cam_d_0_data[9]};
  wire [3:0]  _logic_out_T_20 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[10], cam_d_0_data[10]};
  wire [3:0]  _logic_out_T_22 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[11], cam_d_0_data[11]};
  wire [3:0]  _logic_out_T_24 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[12], cam_d_0_data[12]};
  wire [3:0]  _logic_out_T_26 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[13], cam_d_0_data[13]};
  wire [3:0]  _logic_out_T_28 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[14], cam_d_0_data[14]};
  wire [3:0]  _logic_out_T_30 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[15], cam_d_0_data[15]};
  wire [3:0]  _logic_out_T_32 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[16], cam_d_0_data[16]};
  wire [3:0]  _logic_out_T_34 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[17], cam_d_0_data[17]};
  wire [3:0]  _logic_out_T_36 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[18], cam_d_0_data[18]};
  wire [3:0]  _logic_out_T_38 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[19], cam_d_0_data[19]};
  wire [3:0]  _logic_out_T_40 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[20], cam_d_0_data[20]};
  wire [3:0]  _logic_out_T_42 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[21], cam_d_0_data[21]};
  wire [3:0]  _logic_out_T_44 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[22], cam_d_0_data[22]};
  wire [3:0]  _logic_out_T_46 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[23], cam_d_0_data[23]};
  wire [3:0]  _logic_out_T_48 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[24], cam_d_0_data[24]};
  wire [3:0]  _logic_out_T_50 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[25], cam_d_0_data[25]};
  wire [3:0]  _logic_out_T_52 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[26], cam_d_0_data[26]};
  wire [3:0]  _logic_out_T_54 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[27], cam_d_0_data[27]};
  wire [3:0]  _logic_out_T_56 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[28], cam_d_0_data[28]};
  wire [3:0]  _logic_out_T_58 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[29], cam_d_0_data[29]};
  wire [3:0]  _logic_out_T_60 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[30], cam_d_0_data[30]};
  wire [3:0]  _logic_out_T_62 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[31], cam_d_0_data[31]};
  wire [3:0]  _logic_out_T_64 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[32], cam_d_0_data[32]};
  wire [3:0]  _logic_out_T_66 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[33], cam_d_0_data[33]};
  wire [3:0]  _logic_out_T_68 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[34], cam_d_0_data[34]};
  wire [3:0]  _logic_out_T_70 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[35], cam_d_0_data[35]};
  wire [3:0]  _logic_out_T_72 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[36], cam_d_0_data[36]};
  wire [3:0]  _logic_out_T_74 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[37], cam_d_0_data[37]};
  wire [3:0]  _logic_out_T_76 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[38], cam_d_0_data[38]};
  wire [3:0]  _logic_out_T_78 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[39], cam_d_0_data[39]};
  wire [3:0]  _logic_out_T_80 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[40], cam_d_0_data[40]};
  wire [3:0]  _logic_out_T_82 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[41], cam_d_0_data[41]};
  wire [3:0]  _logic_out_T_84 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[42], cam_d_0_data[42]};
  wire [3:0]  _logic_out_T_86 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[43], cam_d_0_data[43]};
  wire [3:0]  _logic_out_T_88 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[44], cam_d_0_data[44]};
  wire [3:0]  _logic_out_T_90 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[45], cam_d_0_data[45]};
  wire [3:0]  _logic_out_T_92 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[46], cam_d_0_data[46]};
  wire [3:0]  _logic_out_T_94 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[47], cam_d_0_data[47]};
  wire [3:0]  _logic_out_T_96 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[48], cam_d_0_data[48]};
  wire [3:0]  _logic_out_T_98 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[49], cam_d_0_data[49]};
  wire [3:0]  _logic_out_T_100 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[50], cam_d_0_data[50]};
  wire [3:0]  _logic_out_T_102 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[51], cam_d_0_data[51]};
  wire [3:0]  _logic_out_T_104 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[52], cam_d_0_data[52]};
  wire [3:0]  _logic_out_T_106 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[53], cam_d_0_data[53]};
  wire [3:0]  _logic_out_T_108 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[54], cam_d_0_data[54]};
  wire [3:0]  _logic_out_T_110 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[55], cam_d_0_data[55]};
  wire [3:0]  _logic_out_T_112 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[56], cam_d_0_data[56]};
  wire [3:0]  _logic_out_T_114 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[57], cam_d_0_data[57]};
  wire [3:0]  _logic_out_T_116 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[58], cam_d_0_data[58]};
  wire [3:0]  _logic_out_T_118 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[59], cam_d_0_data[59]};
  wire [3:0]  _logic_out_T_120 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[60], cam_d_0_data[60]};
  wire [3:0]  _logic_out_T_122 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[61], cam_d_0_data[61]};
  wire [3:0]  _logic_out_T_124 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[62], cam_d_0_data[62]};
  wire [3:0]  _logic_out_T_126 = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[63], cam_d_0_data[63]};
  wire [6:0]  _GEN = ~(cam_a_0_bits_mask[6:0]) | cam_a_0_bits_mask[7:1];
  wire [6:0]  _signbit_a_T = {cam_a_0_bits_data[55], cam_a_0_bits_data[47], cam_a_0_bits_data[39], cam_a_0_bits_data[31], cam_a_0_bits_data[23], cam_a_0_bits_data[15], cam_a_0_bits_data[7]} & ~_GEN;
  wire [6:0]  _signbit_d_T = {cam_d_0_data[55], cam_d_0_data[47], cam_d_0_data[39], cam_d_0_data[31], cam_d_0_data[23], cam_d_0_data[15], cam_d_0_data[7]} & ~_GEN;
  wire [5:0]  _GEN_0 = _signbit_a_T[6:1] | _signbit_a_T[5:0];
  wire [3:0]  _GEN_1 = _GEN_0[5:2] | _GEN_0[3:0];
  wire        _signext_a_T_24 = _GEN_0[1] | _signbit_a_T[0];
  wire [5:0]  _GEN_2 = _signbit_d_T[6:1] | _signbit_d_T[5:0];
  wire [3:0]  _GEN_3 = _GEN_2[5:2] | _GEN_2[3:0];
  wire        _signext_d_T_24 = _GEN_2[1] | _signbit_d_T[0];
  wire [63:0] wide_mask = {{8{cam_a_0_bits_mask[7]}}, {8{cam_a_0_bits_mask[6]}}, {8{cam_a_0_bits_mask[5]}}, {8{cam_a_0_bits_mask[4]}}, {8{cam_a_0_bits_mask[3]}}, {8{cam_a_0_bits_mask[2]}}, {8{cam_a_0_bits_mask[1]}}, {8{cam_a_0_bits_mask[0]}}};
  wire [63:0] a_a_ext = cam_a_0_bits_data & wide_mask | {{8{_GEN_1[3] | _signext_a_T_24}}, {8{_GEN_1[2] | _GEN_0[0]}}, {8{_GEN_1[1] | _signbit_a_T[0]}}, {8{_GEN_1[0]}}, {8{_signext_a_T_24}}, {8{_GEN_0[0]}}, {8{_signbit_a_T[0]}}, 8'h0};
  wire [63:0] a_d_ext = cam_d_0_data & wide_mask | {{8{_GEN_3[3] | _signext_d_T_24}}, {8{_GEN_3[2] | _GEN_2[0]}}, {8{_GEN_3[1] | _signbit_d_T[0]}}, {8{_GEN_3[0]}}, {8{_signext_d_T_24}}, {8{_GEN_2[0]}}, {8{_signbit_d_T[0]}}, 8'h0};
  wire [63:0] _adder_out_T = a_a_ext + ({64{~(cam_a_0_bits_param[2])}} ^ a_d_ext);
  wire        a_allow = ~(((&cam_s_0_state) | cam_amo_0) & ~cam_a_0_fifoId) & (a_isSupported | cam_free_0);
  reg  [2:0]  beatsLeft;
  wire        idle = beatsLeft == 3'h0;
  wire        source_i_valid = auto_in_a_valid & a_allow;
  reg         state_1;
  wire        source_i_ready = auto_out_a_ready & (idle ? ~cam_amo_0 : state_1);
  wire        nodeIn_a_ready = source_i_ready & a_allow;
  wire        _source_c_bits_a_mask_T = source_c_bits_size > 3'h2;
  wire        source_c_bits_a_mask_size = source_c_bits_size[1:0] == 2'h2;
  wire        source_c_bits_a_mask_acc = _source_c_bits_a_mask_T | source_c_bits_a_mask_size & ~(source_c_bits_address[2]);
  wire        source_c_bits_a_mask_acc_1 = _source_c_bits_a_mask_T | source_c_bits_a_mask_size & source_c_bits_address[2];
  wire        source_c_bits_a_mask_size_1 = source_c_bits_size[1:0] == 2'h1;
  wire        source_c_bits_a_mask_eq_2 = ~(source_c_bits_address[2]) & ~(source_c_bits_address[1]);
  wire        source_c_bits_a_mask_acc_2 = source_c_bits_a_mask_acc | source_c_bits_a_mask_size_1 & source_c_bits_a_mask_eq_2;
  wire        source_c_bits_a_mask_eq_3 = ~(source_c_bits_address[2]) & source_c_bits_address[1];
  wire        source_c_bits_a_mask_acc_3 = source_c_bits_a_mask_acc | source_c_bits_a_mask_size_1 & source_c_bits_a_mask_eq_3;
  wire        source_c_bits_a_mask_eq_4 = source_c_bits_address[2] & ~(source_c_bits_address[1]);
  wire        source_c_bits_a_mask_acc_4 = source_c_bits_a_mask_acc_1 | source_c_bits_a_mask_size_1 & source_c_bits_a_mask_eq_4;
  wire        source_c_bits_a_mask_eq_5 = source_c_bits_address[2] & source_c_bits_address[1];
  wire        source_c_bits_a_mask_acc_5 = source_c_bits_a_mask_acc_1 | source_c_bits_a_mask_size_1 & source_c_bits_a_mask_eq_5;
  wire        winner_1 = ~cam_amo_0 & source_i_valid;
  wire        _nodeOut_a_valid_T = cam_amo_0 | source_i_valid;
  reg         state_0;
  wire        nodeOut_a_valid = idle ? _nodeOut_a_valid_T : state_0 & cam_amo_0 | state_1 & source_i_valid;
  wire        muxState_0 = idle ? cam_amo_0 : state_0;
  wire        muxState_1 = idle ? winner_1 : state_1;
  always @(*) begin
    casez (auto_in_a_bits_param[1:0])
      2'b00:
        casez_tmp = 4'h6;
      2'b01:
        casez_tmp = 4'hE;
      2'b10:
        casez_tmp = 4'h8;
      default:
        casez_tmp = 4'hC;
    endcase
  end // always @(*)
  reg  [2:0]  d_first_counter;
  wire        d_first = d_first_counter == 3'h0;
  wire        d_ackd = auto_out_d_bits_opcode == 3'h1;
  wire        d_cam_sel_0 = source_c_bits_source == auto_out_d_bits_source & (|cam_s_0_state);
  wire        d_drop = d_first & d_ackd & d_cam_sel_0;
  wire        nodeOut_d_ready = auto_in_d_ready | d_drop;
  wire        d_replace = d_first & auto_out_d_bits_opcode == 3'h0 & d_cam_sel_0;
  wire        nodeIn_d_valid = auto_out_d_valid & ~d_drop;
  wire [2:0]  nodeIn_d_bits_opcode = d_replace ? 3'h1 : auto_out_d_bits_opcode;
  wire        nodeIn_d_bits_corrupt = d_replace ? cam_d_0_corrupt | auto_out_d_bits_denied : auto_out_d_bits_corrupt;
  wire        nodeIn_d_bits_denied = d_replace & cam_d_0_denied | auto_out_d_bits_denied;
  wire [12:0] _decode_T_1 = 13'h3F << auto_in_a_bits_size;
  wire [12:0] _d_first_beats1_decode_T_1 = 13'h3F << auto_out_d_bits_size;
  wire        _GEN_4 = source_i_ready & source_i_valid & ~a_isSupported & cam_free_0;
  wire        _d_first_T = nodeOut_d_ready & auto_out_d_valid;
  wire        _GEN_5 = _d_first_T & d_first;
  always @(posedge clock) begin
    if (reset) begin
      cam_s_0_state <= 2'h0;
      beatsLeft <= 3'h0;
      state_1 <= 1'h0;
      state_0 <= 1'h0;
      d_first_counter <= 3'h0;
    end
    else begin
      if (_GEN_5 & d_cam_sel_0)
        cam_s_0_state <= {d_ackd, 1'h0};
      else if (auto_out_a_ready & (idle | state_0) & cam_amo_0)
        cam_s_0_state <= 2'h1;
      else if (_GEN_4)
        cam_s_0_state <= 2'h3;
      if (idle & auto_out_a_ready) begin
        if (winner_1 & ~(auto_in_a_bits_opcode[2]))
          beatsLeft <= ~(_decode_T_1[5:3]);
        else
          beatsLeft <= 3'h0;
      end
      else
        beatsLeft <= beatsLeft - {2'h0, auto_out_a_ready & nodeOut_a_valid};
      if (idle) begin
        state_1 <= winner_1;
        state_0 <= cam_amo_0;
      end
      if (_d_first_T) begin
        if (d_first) begin
          if (auto_out_d_bits_opcode[0])
            d_first_counter <= ~(_d_first_beats1_decode_T_1[5:3]);
          else
            d_first_counter <= 3'h0;
        end
        else
          d_first_counter <= d_first_counter - 3'h1;
      end
    end
    if (_GEN_4) begin
      cam_a_0_bits_opcode <= auto_in_a_bits_opcode;
      cam_a_0_bits_param <= auto_in_a_bits_param;
      source_c_bits_size <= auto_in_a_bits_size;
      source_c_bits_source <= auto_in_a_bits_source;
      source_c_bits_address <= auto_in_a_bits_address;
      cam_a_0_bits_mask <= auto_in_a_bits_mask;
      cam_a_0_bits_data <= auto_in_a_bits_data;
      cam_a_0_bits_corrupt <= auto_in_a_bits_corrupt;
      cam_a_0_lut <= casez_tmp;
    end
    cam_a_0_fifoId <= ~_GEN_4 & cam_a_0_fifoId;
    if (_GEN_5 & d_cam_sel_0 & d_ackd) begin
      cam_d_0_data <= auto_out_d_bits_data;
      cam_d_0_denied <= auto_out_d_bits_denied;
      cam_d_0_corrupt <= auto_out_d_bits_corrupt;
    end
  end // always @(posedge)
  assign auto_in_a_ready = nodeIn_a_ready;
  assign auto_in_d_valid = nodeIn_d_valid;
  assign auto_in_d_bits_opcode = nodeIn_d_bits_opcode;
  assign auto_in_d_bits_param = auto_out_d_bits_param;
  assign auto_in_d_bits_size = auto_out_d_bits_size;
  assign auto_in_d_bits_source = auto_out_d_bits_source;
  assign auto_in_d_bits_sink = auto_out_d_bits_sink;
  assign auto_in_d_bits_denied = nodeIn_d_bits_denied;
  assign auto_in_d_bits_data = d_replace ? cam_d_0_data : auto_out_d_bits_data;
  assign auto_in_d_bits_corrupt = nodeIn_d_bits_corrupt;
  assign auto_out_a_valid = nodeOut_a_valid;
  assign auto_out_a_bits_opcode = muxState_1 ? (a_isSupported ? auto_in_a_bits_opcode : 3'h4) : 3'h0;
  assign auto_out_a_bits_param = muxState_1 & a_isSupported ? auto_in_a_bits_param : 3'h0;
  assign auto_out_a_bits_size = (muxState_0 ? source_c_bits_size : 3'h0) | (muxState_1 ? auto_in_a_bits_size : 3'h0);
  assign auto_out_a_bits_source = (muxState_0 ? source_c_bits_source : 7'h0) | (muxState_1 ? auto_in_a_bits_source : 7'h0);
  assign auto_out_a_bits_address = (muxState_0 ? source_c_bits_address : 29'h0) | (muxState_1 ? auto_in_a_bits_address : 29'h0);
  assign auto_out_a_bits_mask = (muxState_0 ? {source_c_bits_a_mask_acc_5 | source_c_bits_a_mask_eq_5 & source_c_bits_address[0], source_c_bits_a_mask_acc_5 | source_c_bits_a_mask_eq_5 & ~(source_c_bits_address[0]), source_c_bits_a_mask_acc_4 | source_c_bits_a_mask_eq_4 & source_c_bits_address[0], source_c_bits_a_mask_acc_4 | source_c_bits_a_mask_eq_4 & ~(source_c_bits_address[0]), source_c_bits_a_mask_acc_3 | source_c_bits_a_mask_eq_3 & source_c_bits_address[0], source_c_bits_a_mask_acc_3 | source_c_bits_a_mask_eq_3 & ~(source_c_bits_address[0]), source_c_bits_a_mask_acc_2 | source_c_bits_a_mask_eq_2 & source_c_bits_address[0], source_c_bits_a_mask_acc_2 | source_c_bits_a_mask_eq_2 & ~(source_c_bits_address[0])} : 8'h0) | (muxState_1 ? auto_in_a_bits_mask : 8'h0);
  assign auto_out_a_bits_data = (muxState_0 ? (cam_a_0_bits_opcode[0] ? {_logic_out_T_126[0], _logic_out_T_124[0], _logic_out_T_122[0], _logic_out_T_120[0], _logic_out_T_118[0], _logic_out_T_116[0], _logic_out_T_114[0], _logic_out_T_112[0], _logic_out_T_110[0], _logic_out_T_108[0], _logic_out_T_106[0], _logic_out_T_104[0], _logic_out_T_102[0], _logic_out_T_100[0], _logic_out_T_98[0], _logic_out_T_96[0], _logic_out_T_94[0], _logic_out_T_92[0], _logic_out_T_90[0], _logic_out_T_88[0], _logic_out_T_86[0], _logic_out_T_84[0], _logic_out_T_82[0], _logic_out_T_80[0], _logic_out_T_78[0], _logic_out_T_76[0], _logic_out_T_74[0], _logic_out_T_72[0], _logic_out_T_70[0], _logic_out_T_68[0], _logic_out_T_66[0], _logic_out_T_64[0], _logic_out_T_62[0], _logic_out_T_60[0], _logic_out_T_58[0], _logic_out_T_56[0], _logic_out_T_54[0], _logic_out_T_52[0], _logic_out_T_50[0], _logic_out_T_48[0], _logic_out_T_46[0], _logic_out_T_44[0], _logic_out_T_42[0], _logic_out_T_40[0], _logic_out_T_38[0], _logic_out_T_36[0], _logic_out_T_34[0], _logic_out_T_32[0], _logic_out_T_30[0], _logic_out_T_28[0], _logic_out_T_26[0], _logic_out_T_24[0], _logic_out_T_22[0], _logic_out_T_20[0], _logic_out_T_18[0], _logic_out_T_16[0], _logic_out_T_14[0], _logic_out_T_12[0], _logic_out_T_10[0], _logic_out_T_8[0], _logic_out_T_6[0], _logic_out_T_4[0], _logic_out_T_2[0], _logic_out_T[0]} : cam_a_0_bits_param[2] ? _adder_out_T : cam_a_0_bits_param[0] == (a_a_ext[63] == a_d_ext[63] ? ~(_adder_out_T[63]) : cam_a_0_bits_param[1] == a_a_ext[63]) ? cam_a_0_bits_data : cam_d_0_data) : 64'h0) | (muxState_1 ? auto_in_a_bits_data : 64'h0);
  assign auto_out_a_bits_corrupt = muxState_0 & (cam_a_0_bits_corrupt | cam_d_0_corrupt) | muxState_1 & auto_in_a_bits_corrupt;
  assign auto_out_d_ready = nodeOut_d_ready;
endmodule

