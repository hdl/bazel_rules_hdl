// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TSIToTileLink(
  input         clock,
                reset,
                auto_out_a_ready,
                auto_out_d_valid,
  input  [63:0] auto_out_d_bits_data,
  input         io_tsi_in_valid,
  input  [31:0] io_tsi_in_bits,
  input         io_tsi_out_ready,
  output        auto_out_a_valid,
  output [2:0]  auto_out_a_bits_opcode,
  output [3:0]  auto_out_a_bits_size,
  output [31:0] auto_out_a_bits_address,
  output [7:0]  auto_out_a_bits_mask,
  output [63:0] auto_out_a_bits_data,
  output        auto_out_d_ready,
                io_tsi_in_ready,
                io_tsi_out_valid,
  output [31:0] io_tsi_out_bits
);

  reg  [31:0] cmd;
  reg  [63:0] addr;
  reg  [63:0] len;
  reg  [31:0] body_0;
  reg  [31:0] body_1;
  reg  [1:0]  bodyValid;
  reg         idx;
  reg  [3:0]  state;
  wire        _io_tsi_in_ready_T = state == 4'h0;
  wire        _io_tsi_in_ready_T_1 = state == 4'h1;
  wire        _io_tsi_in_ready_T_2 = state == 4'h2;
  wire        _io_tsi_in_ready_T_3 = state == 4'h6;
  wire        _io_tsi_out_valid_T = state == 4'h5;
  wire [63:0] _GEN = {32'h0, addr[31:3] + 29'h1, 3'h0};
  wire [65:0] len_size = {len + 64'h1, 2'h0};
  wire [65:0] _GEN_0 = {2'h0, _GEN - addr};
  wire [65:0] raw_size = len_size < _GEN_0 ? len_size : _GEN_0;
  wire [1:0]  rsize = raw_size == 66'h4 ? 2'h2 : raw_size == 66'h2 ? 2'h1 : raw_size == 66'h1 ? 2'h0 : 2'h3;
  wire        pow2size = {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, raw_size[0]} + {1'h0, raw_size[1]}} + {1'h0, {1'h0, raw_size[2]} + {1'h0, raw_size[3]}}} + {1'h0, {1'h0, {1'h0, raw_size[4]} + {1'h0, raw_size[5]}} + {1'h0, {1'h0, raw_size[6]} + {1'h0, raw_size[7]}}}} + {1'h0, {1'h0, {1'h0, {1'h0, raw_size[8]} + {1'h0, raw_size[9]}} + {1'h0, {1'h0, raw_size[10]} + {1'h0, raw_size[11]}}} + {1'h0, {1'h0, {1'h0, raw_size[12]} + {1'h0, raw_size[13]}} + {1'h0, {1'h0, raw_size[14]} + {1'h0, raw_size[15]}}}}} + {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, raw_size[16]} + {1'h0, raw_size[17]}} + {1'h0, {1'h0, raw_size[18]} + {1'h0, raw_size[19]}}} + {1'h0, {1'h0, {1'h0, raw_size[20]} + {1'h0, raw_size[21]}} + {1'h0, {1'h0, raw_size[22]} + {1'h0, raw_size[23]}}}} + {1'h0, {1'h0, {1'h0, {1'h0, raw_size[24]} + {1'h0, raw_size[25]}} + {1'h0, {1'h0, raw_size[26]} + {1'h0, raw_size[27]}}} + {1'h0, {1'h0, {1'h0, raw_size[28]} + {1'h0, raw_size[29]}} + {1'h0, {1'h0, raw_size[30]} + {1'h0, raw_size[31]} + {1'h0, raw_size[32]}}}}}} + {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, raw_size[33]} + {1'h0, raw_size[34]}} + {1'h0, {1'h0, raw_size[35]} + {1'h0, raw_size[36]}}} + {1'h0, {1'h0, {1'h0, raw_size[37]} + {1'h0, raw_size[38]}} + {1'h0, {1'h0, raw_size[39]} + {1'h0, raw_size[40]}}}} + {1'h0, {1'h0, {1'h0, {1'h0, raw_size[41]} + {1'h0, raw_size[42]}} + {1'h0, {1'h0, raw_size[43]} + {1'h0, raw_size[44]}}} + {1'h0, {1'h0, {1'h0, raw_size[45]} + {1'h0, raw_size[46]}} + {1'h0, {1'h0, raw_size[47]} + {1'h0, raw_size[48]}}}}} + {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, raw_size[49]} + {1'h0, raw_size[50]}} + {1'h0, {1'h0, raw_size[51]} + {1'h0, raw_size[52]}}} + {1'h0, {1'h0, {1'h0, raw_size[53]} + {1'h0, raw_size[54]}} + {1'h0, {1'h0, raw_size[55]} + {1'h0, raw_size[56]}}}} + {1'h0, {1'h0, {1'h0, {1'h0, raw_size[57]} + {1'h0, raw_size[58]}} + {1'h0, {1'h0, raw_size[59]} + {1'h0, raw_size[60]}}} + {1'h0, {1'h0, {1'h0, raw_size[61]} + {1'h0, raw_size[62]}} + {1'h0, {1'h0, raw_size[63]} + {1'h0, raw_size[64]} + {1'h0, raw_size[65]}}}}}} == 7'h1;
  wire [2:0]  byteAddr = pow2size ? addr[2:0] : 3'h0;
  wire        get_acquire_a_mask_size = rsize == 2'h2;
  wire        get_acquire_a_mask_acc = (&rsize) | get_acquire_a_mask_size & ~(byteAddr[2]);
  wire        get_acquire_a_mask_acc_1 = (&rsize) | get_acquire_a_mask_size & byteAddr[2];
  wire        get_acquire_a_mask_size_1 = rsize == 2'h1;
  wire        get_acquire_a_mask_eq_2 = ~(byteAddr[2]) & ~(byteAddr[1]);
  wire        get_acquire_a_mask_acc_2 = get_acquire_a_mask_acc | get_acquire_a_mask_size_1 & get_acquire_a_mask_eq_2;
  wire        get_acquire_a_mask_eq_3 = ~(byteAddr[2]) & byteAddr[1];
  wire        get_acquire_a_mask_acc_3 = get_acquire_a_mask_acc | get_acquire_a_mask_size_1 & get_acquire_a_mask_eq_3;
  wire        get_acquire_a_mask_eq_4 = byteAddr[2] & ~(byteAddr[1]);
  wire        get_acquire_a_mask_acc_4 = get_acquire_a_mask_acc_1 | get_acquire_a_mask_size_1 & get_acquire_a_mask_eq_4;
  wire        get_acquire_a_mask_eq_5 = byteAddr[2] & byteAddr[1];
  wire        get_acquire_a_mask_acc_5 = get_acquire_a_mask_acc_1 | get_acquire_a_mask_size_1 & get_acquire_a_mask_eq_5;
  wire        _nodeOut_a_bits_T = state == 4'h7;
  wire        _nodeOut_a_valid_T_1 = state == 4'h3;
  wire        _nodeOut_d_ready_T = state == 4'h8;
  wire        _nodeOut_d_ready_T_1 = state == 4'h4;
  wire        _GEN_1 = _io_tsi_in_ready_T_2 & io_tsi_in_valid;
  wire        _GEN_2 = cmd == 32'h1;
  wire        _GEN_3 = _GEN_1 & idx;
  wire        _GEN_4 = _nodeOut_a_valid_T_1 & auto_out_a_ready;
  wire        _GEN_5 = _io_tsi_in_ready_T & io_tsi_in_valid;
  wire        _GEN_6 = _io_tsi_in_ready_T_1 & io_tsi_in_valid;
  wire [94:0] _GEN_7 = {63'h0, io_tsi_in_bits};
  wire [94:0] _GEN_8 = {89'h0, idx, 5'h0};
  wire        _idx_T_8 = idx - 1'h1;
  wire        _GEN_9 = _nodeOut_d_ready_T_1 & auto_out_d_valid;
  wire        _GEN_10 = _io_tsi_out_valid_T & io_tsi_out_ready;
  wire        _GEN_11 = len == 64'h0;
  wire        _GEN_12 = _io_tsi_in_ready_T_3 & io_tsi_in_valid;
  wire        _GEN_13 = idx | _GEN_11;
  wire        _GEN_14 = _nodeOut_d_ready_T & auto_out_d_valid;
  wire        _GEN_15 = ~_GEN_14 | _GEN_11;
  wire [94:0] _addr_T_2 = _GEN_7 << _GEN_8;
  wire [94:0] _len_T_2 = _GEN_7 << _GEN_8;
  wire        _GEN_16 = _GEN_6 & idx;
  always @(posedge clock) begin
    if (_GEN_5)
      cmd <= io_tsi_in_bits;
    addr <= _GEN_14 & ~_GEN_11 | _GEN_9 ? _GEN : _GEN_6 ? addr | _addr_T_2[63:0] : _GEN_5 ? 64'h0 : addr;
    len <= ~(_GEN_15 & (~_GEN_12 | _GEN_13)) | _GEN_10 ? len - 64'h1 : _GEN_1 ? len | _len_T_2[63:0] : _GEN_5 ? 64'h0 : len;
    if (_GEN_12 & ~idx)
      body_0 <= io_tsi_in_bits;
    else if (_GEN_9)
      body_0 <= auto_out_d_bits_data[31:0];
    if (_GEN_12 & idx)
      body_1 <= io_tsi_in_bits;
    else if (_GEN_9)
      body_1 <= auto_out_d_bits_data[63:32];
    if (_GEN_15) begin
      if (_GEN_12)
        bodyValid <= bodyValid | 2'h1 << idx;
      else if (_GEN_1 & idx & _GEN_2)
        bodyValid <= 2'h0;
    end
    else
      bodyValid <= 2'h0;
    idx <= _GEN_15 & (_GEN_12 & ~_GEN_13 | _GEN_10 ? _idx_T_8 : _GEN_9 ? addr[2] : _GEN_1 ? (idx ? addr[2] : _idx_T_8) : _GEN_6 ? ~idx & _idx_T_8 : ~_GEN_5 & idx);
    if (reset)
      state <= 4'h0;
    else if (_GEN_14) begin
      if (_GEN_11)
        state <= 4'h0;
      else
        state <= 4'h6;
    end
    else if (_nodeOut_a_bits_T & auto_out_a_ready)
      state <= 4'h8;
    else if (_GEN_12 & _GEN_13)
      state <= 4'h7;
    else if (_GEN_10) begin
      if (_GEN_11)
        state <= 4'h0;
      else if (idx)
        state <= 4'h3;
      else if (_GEN_9)
        state <= 4'h5;
      else if (_GEN_4)
        state <= 4'h4;
      else if (_GEN_3) begin
        if (_GEN_2)
          state <= 4'h6;
        else if (|cmd) begin
          if (_GEN_16)
            state <= 4'h2;
          else if (_GEN_5)
            state <= 4'h1;
        end
        else
          state <= 4'h3;
      end
      else if (_GEN_16)
        state <= 4'h2;
      else if (_GEN_5)
        state <= 4'h1;
    end
    else if (_GEN_9)
      state <= 4'h5;
    else if (_GEN_4)
      state <= 4'h4;
    else if (_GEN_3) begin
      if (_GEN_2)
        state <= 4'h6;
      else if (|cmd) begin
        if (_GEN_16)
          state <= 4'h2;
        else if (_GEN_5)
          state <= 4'h1;
      end
      else
        state <= 4'h3;
    end
    else if (_GEN_16)
      state <= 4'h2;
    else if (_GEN_5)
      state <= 4'h1;
  end // always @(posedge)
  assign auto_out_a_valid = _nodeOut_a_bits_T | _nodeOut_a_valid_T_1;
  assign auto_out_a_bits_opcode = _nodeOut_a_bits_T ? 3'h1 : 3'h4;
  assign auto_out_a_bits_size = _nodeOut_a_bits_T ? 4'h3 : {2'h0, rsize};
  assign auto_out_a_bits_address = {addr[31:3], _nodeOut_a_bits_T | ~pow2size ? 3'h0 : addr[2:0]};
  assign auto_out_a_bits_mask = _nodeOut_a_bits_T ? {{4{bodyValid[1]}}, {4{bodyValid[0]}}} : {get_acquire_a_mask_acc_5 | get_acquire_a_mask_eq_5 & byteAddr[0], get_acquire_a_mask_acc_5 | get_acquire_a_mask_eq_5 & ~(byteAddr[0]), get_acquire_a_mask_acc_4 | get_acquire_a_mask_eq_4 & byteAddr[0], get_acquire_a_mask_acc_4 | get_acquire_a_mask_eq_4 & ~(byteAddr[0]), get_acquire_a_mask_acc_3 | get_acquire_a_mask_eq_3 & byteAddr[0], get_acquire_a_mask_acc_3 | get_acquire_a_mask_eq_3 & ~(byteAddr[0]), get_acquire_a_mask_acc_2 | get_acquire_a_mask_eq_2 & byteAddr[0], get_acquire_a_mask_acc_2 | get_acquire_a_mask_eq_2 & ~(byteAddr[0])};
  assign auto_out_a_bits_data = _nodeOut_a_bits_T ? {body_1, body_0} : 64'h0;
  assign auto_out_d_ready = _nodeOut_d_ready_T | _nodeOut_d_ready_T_1;
  assign io_tsi_in_ready = _io_tsi_in_ready_T | _io_tsi_in_ready_T_1 | _io_tsi_in_ready_T_2 | _io_tsi_in_ready_T_3;
  assign io_tsi_out_valid = _io_tsi_out_valid_T;
  assign io_tsi_out_bits = idx ? body_1 : body_0;
endmodule

