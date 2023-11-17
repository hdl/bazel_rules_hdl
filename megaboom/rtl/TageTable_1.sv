// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TageTable_1(
  input         clock,
                reset,
                io_f1_req_valid,
  input  [39:0] io_f1_req_pc,
  input  [63:0] io_f1_req_ghist,
  input         io_update_mask_0,
                io_update_mask_1,
                io_update_mask_2,
                io_update_mask_3,
                io_update_taken_0,
                io_update_taken_1,
                io_update_taken_2,
                io_update_taken_3,
                io_update_alloc_0,
                io_update_alloc_1,
                io_update_alloc_2,
                io_update_alloc_3,
  input  [2:0]  io_update_old_ctr_0,
                io_update_old_ctr_1,
                io_update_old_ctr_2,
                io_update_old_ctr_3,
  input  [39:0] io_update_pc,
  input  [63:0] io_update_hist,
  input         io_update_u_mask_0,
                io_update_u_mask_1,
                io_update_u_mask_2,
                io_update_u_mask_3,
  input  [1:0]  io_update_u_0,
                io_update_u_1,
                io_update_u_2,
                io_update_u_3,
  output        io_f3_resp_0_valid,
  output [2:0]  io_f3_resp_0_bits_ctr,
  output [1:0]  io_f3_resp_0_bits_u,
  output        io_f3_resp_1_valid,
  output [2:0]  io_f3_resp_1_bits_ctr,
  output [1:0]  io_f3_resp_1_bits_u,
  output        io_f3_resp_2_valid,
  output [2:0]  io_f3_resp_2_bits_ctr,
  output [1:0]  io_f3_resp_2_bits_u,
  output        io_f3_resp_3_valid,
  output [2:0]  io_f3_resp_3_bits_ctr,
  output [1:0]  io_f3_resp_3_bits_u
);

  wire [10:0] _table_3_ext_R0_data;
  wire [10:0] _table_2_ext_R0_data;
  wire [10:0] _table_1_ext_R0_data;
  wire [10:0] _table_0_ext_R0_data;
  wire        _lo_us_3_ext_R0_data;
  wire        _lo_us_2_ext_R0_data;
  wire        _lo_us_1_ext_R0_data;
  wire        _lo_us_0_ext_R0_data;
  wire        _hi_us_3_ext_R0_data;
  wire        _hi_us_2_ext_R0_data;
  wire        _hi_us_1_ext_R0_data;
  wire        _hi_us_0_ext_R0_data;
  reg         doing_reset;
  reg  [6:0]  reset_idx;
  wire [6:0]  s1_hashed_idx = {io_f1_req_pc[10:8], io_f1_req_pc[7:4] ^ io_f1_req_ghist[3:0]};
  reg  [6:0]  s2_tag;
  reg         io_f3_resp_0_valid_REG;
  reg  [1:0]  io_f3_resp_0_bits_u_REG;
  reg  [2:0]  io_f3_resp_0_bits_ctr_REG;
  reg         io_f3_resp_1_valid_REG;
  reg  [1:0]  io_f3_resp_1_bits_u_REG;
  reg  [2:0]  io_f3_resp_1_bits_ctr_REG;
  reg         io_f3_resp_2_valid_REG;
  reg  [1:0]  io_f3_resp_2_bits_u_REG;
  reg  [2:0]  io_f3_resp_2_bits_ctr_REG;
  reg         io_f3_resp_3_valid_REG;
  reg  [1:0]  io_f3_resp_3_bits_u_REG;
  reg  [2:0]  io_f3_resp_3_bits_ctr_REG;
  reg  [18:0] clear_u_ctr;
  wire        doing_clear_u = clear_u_ctr[10:0] == 11'h0;
  wire        doing_clear_u_hi = doing_clear_u & clear_u_ctr[18];
  wire        doing_clear_u_lo = doing_clear_u & ~(clear_u_ctr[18]);
  wire [3:0]  _GEN = io_update_pc[7:4] ^ io_update_hist[3:0];
  wire [6:0]  update_idx = {io_update_pc[10:8], _GEN};
  wire [3:0]  _GEN_0 = io_update_pc[14:11] ^ io_update_hist[3:0];
  wire [6:0]  update_tag = {io_update_pc[17:15], _GEN_0};
  wire [6:0]  _GEN_1 = doing_reset ? reset_idx : update_idx;
  reg  [6:0]  wrbypass_tags_0;
  reg  [6:0]  wrbypass_idxs_0;
  wire        wrbypass_hits_0 = ~doing_reset & wrbypass_tags_0 == update_tag & wrbypass_idxs_0 == update_idx;
  reg  [6:0]  wrbypass_tags_1;
  reg  [6:0]  wrbypass_idxs_1;
  wire        wrbypass_hit = wrbypass_hits_0 | ~doing_reset & wrbypass_tags_1 == update_tag & wrbypass_idxs_1 == update_idx;
  reg  [2:0]  wrbypass_1_0;
  reg  [2:0]  wrbypass_0_0;
  wire [2:0]  _wrbypass_wrbypass_hit_idx_0_2 = wrbypass_hits_0 ? wrbypass_0_0 : wrbypass_1_0;
  wire        _update_wdata_0_ctr_T_2 = _wrbypass_wrbypass_hit_idx_0_2 == 3'h0;
  wire [2:0]  _update_wdata_0_ctr_T_3 = _wrbypass_wrbypass_hit_idx_0_2 - 3'h1;
  wire [2:0]  _update_wdata_0_ctr_T_7 = _wrbypass_wrbypass_hit_idx_0_2 + 3'h1;
  wire        _update_wdata_0_ctr_T_12 = io_update_old_ctr_0 == 3'h0;
  wire [2:0]  _update_wdata_0_ctr_T_13 = io_update_old_ctr_0 - 3'h1;
  wire [2:0]  _update_wdata_0_ctr_T_17 = io_update_old_ctr_0 + 3'h1;
  reg  [2:0]  wrbypass_1_1;
  reg  [2:0]  wrbypass_0_1;
  wire [2:0]  _wrbypass_wrbypass_hit_idx_1_2 = wrbypass_hits_0 ? wrbypass_0_1 : wrbypass_1_1;
  wire        _update_wdata_1_ctr_T_2 = _wrbypass_wrbypass_hit_idx_1_2 == 3'h0;
  wire [2:0]  _update_wdata_1_ctr_T_3 = _wrbypass_wrbypass_hit_idx_1_2 - 3'h1;
  wire [2:0]  _update_wdata_1_ctr_T_7 = _wrbypass_wrbypass_hit_idx_1_2 + 3'h1;
  wire        _update_wdata_1_ctr_T_12 = io_update_old_ctr_1 == 3'h0;
  wire [2:0]  _update_wdata_1_ctr_T_13 = io_update_old_ctr_1 - 3'h1;
  wire [2:0]  _update_wdata_1_ctr_T_17 = io_update_old_ctr_1 + 3'h1;
  reg  [2:0]  wrbypass_1_2;
  reg  [2:0]  wrbypass_0_2;
  wire [2:0]  _wrbypass_wrbypass_hit_idx_2_2 = wrbypass_hits_0 ? wrbypass_0_2 : wrbypass_1_2;
  wire        _update_wdata_2_ctr_T_2 = _wrbypass_wrbypass_hit_idx_2_2 == 3'h0;
  wire [2:0]  _update_wdata_2_ctr_T_3 = _wrbypass_wrbypass_hit_idx_2_2 - 3'h1;
  wire [2:0]  _update_wdata_2_ctr_T_7 = _wrbypass_wrbypass_hit_idx_2_2 + 3'h1;
  wire        _update_wdata_2_ctr_T_12 = io_update_old_ctr_2 == 3'h0;
  wire [2:0]  _update_wdata_2_ctr_T_13 = io_update_old_ctr_2 - 3'h1;
  wire [2:0]  _update_wdata_2_ctr_T_17 = io_update_old_ctr_2 + 3'h1;
  reg  [2:0]  wrbypass_1_3;
  reg  [2:0]  wrbypass_0_3;
  wire [2:0]  _wrbypass_wrbypass_hit_idx_3_2 = wrbypass_hits_0 ? wrbypass_0_3 : wrbypass_1_3;
  wire        _update_wdata_3_ctr_T_2 = _wrbypass_wrbypass_hit_idx_3_2 == 3'h0;
  wire [2:0]  _update_wdata_3_ctr_T_3 = _wrbypass_wrbypass_hit_idx_3_2 - 3'h1;
  wire [2:0]  _update_wdata_3_ctr_T_7 = _wrbypass_wrbypass_hit_idx_3_2 + 3'h1;
  wire        _update_wdata_3_ctr_T_12 = io_update_old_ctr_3 == 3'h0;
  wire [2:0]  _update_wdata_3_ctr_T_13 = io_update_old_ctr_3 - 3'h1;
  wire [2:0]  _update_wdata_3_ctr_T_17 = io_update_old_ctr_3 + 3'h1;
  wire [3:0]  _GEN_2 = doing_reset ? 4'hF : {io_update_mask_3, io_update_mask_2, io_update_mask_1, io_update_mask_0};
  wire [6:0]  _GEN_3 = {io_update_pc[10:8], _GEN};
  wire [6:0]  _GEN_4 = doing_reset ? reset_idx : doing_clear_u_hi ? clear_u_ctr[17:11] : _GEN_3;
  wire        _GEN_5 = doing_reset | doing_clear_u_hi;
  wire [3:0]  _GEN_6 = {io_update_u_mask_3, io_update_u_mask_2, io_update_u_mask_1, io_update_u_mask_0};
  wire [3:0]  _GEN_7 = _GEN_5 ? 4'hF : _GEN_6;
  wire [6:0]  _GEN_8 = doing_reset ? reset_idx : doing_clear_u_lo ? clear_u_ctr[17:11] : _GEN_3;
  wire        _GEN_9 = doing_reset | doing_clear_u_lo;
  wire [3:0]  _GEN_10 = _GEN_9 ? 4'hF : _GEN_6;
  reg         wrbypass_enq_idx;
  wire        _GEN_11 = io_update_mask_0 | io_update_mask_1 | io_update_mask_2 | io_update_mask_3;
  always @(posedge clock) begin
    if (reset) begin
      doing_reset <= 1'h1;
      reset_idx <= 7'h0;
      clear_u_ctr <= 19'h0;
      wrbypass_enq_idx <= 1'h0;
    end
    else begin
      doing_reset <= reset_idx != 7'h7F & doing_reset;
      reset_idx <= reset_idx + {6'h0, doing_reset};
      if (doing_reset)
        clear_u_ctr <= 19'h1;
      else
        clear_u_ctr <= clear_u_ctr + 19'h1;
      if (~_GEN_11 | wrbypass_hit) begin
      end
      else
        wrbypass_enq_idx <= wrbypass_enq_idx - 1'h1;
    end
    s2_tag <= {io_f1_req_pc[17:15], io_f1_req_pc[14:11] ^ io_f1_req_ghist[3:0]};
    io_f3_resp_0_valid_REG <= _table_0_ext_R0_data[10] & _table_0_ext_R0_data[9:3] == s2_tag & ~doing_reset;
    io_f3_resp_0_bits_u_REG <= {_hi_us_0_ext_R0_data, _lo_us_0_ext_R0_data};
    io_f3_resp_0_bits_ctr_REG <= _table_0_ext_R0_data[2:0];
    io_f3_resp_1_valid_REG <= _table_1_ext_R0_data[10] & _table_1_ext_R0_data[9:3] == s2_tag & ~doing_reset;
    io_f3_resp_1_bits_u_REG <= {_hi_us_1_ext_R0_data, _lo_us_1_ext_R0_data};
    io_f3_resp_1_bits_ctr_REG <= _table_1_ext_R0_data[2:0];
    io_f3_resp_2_valid_REG <= _table_2_ext_R0_data[10] & _table_2_ext_R0_data[9:3] == s2_tag & ~doing_reset;
    io_f3_resp_2_bits_u_REG <= {_hi_us_2_ext_R0_data, _lo_us_2_ext_R0_data};
    io_f3_resp_2_bits_ctr_REG <= _table_2_ext_R0_data[2:0];
    io_f3_resp_3_valid_REG <= _table_3_ext_R0_data[10] & _table_3_ext_R0_data[9:3] == s2_tag & ~doing_reset;
    io_f3_resp_3_bits_u_REG <= {_hi_us_3_ext_R0_data, _lo_us_3_ext_R0_data};
    io_f3_resp_3_bits_ctr_REG <= _table_3_ext_R0_data[2:0];
    if (~_GEN_11 | wrbypass_hit | wrbypass_enq_idx) begin
    end
    else begin
      wrbypass_tags_0 <= update_tag;
      wrbypass_idxs_0 <= update_idx;
    end
    if (~_GEN_11 | wrbypass_hit | ~wrbypass_enq_idx) begin
    end
    else begin
      wrbypass_tags_1 <= update_tag;
      wrbypass_idxs_1 <= update_idx;
    end
    if (_GEN_11) begin
      if (wrbypass_hit) begin
        if (wrbypass_hits_0) begin
          if (io_update_alloc_0) begin
            if (io_update_taken_0)
              wrbypass_0_0 <= 3'h4;
            else
              wrbypass_0_0 <= 3'h3;
          end
          else if (io_update_taken_0) begin
            if (&_wrbypass_wrbypass_hit_idx_0_2)
              wrbypass_0_0 <= 3'h7;
            else
              wrbypass_0_0 <= _update_wdata_0_ctr_T_7;
          end
          else if (_update_wdata_0_ctr_T_2)
            wrbypass_0_0 <= 3'h0;
          else
            wrbypass_0_0 <= _update_wdata_0_ctr_T_3;
          if (io_update_alloc_1) begin
            if (io_update_taken_1)
              wrbypass_0_1 <= 3'h4;
            else
              wrbypass_0_1 <= 3'h3;
          end
          else if (io_update_taken_1) begin
            if (&_wrbypass_wrbypass_hit_idx_1_2)
              wrbypass_0_1 <= 3'h7;
            else
              wrbypass_0_1 <= _update_wdata_1_ctr_T_7;
          end
          else if (_update_wdata_1_ctr_T_2)
            wrbypass_0_1 <= 3'h0;
          else
            wrbypass_0_1 <= _update_wdata_1_ctr_T_3;
          if (io_update_alloc_2) begin
            if (io_update_taken_2)
              wrbypass_0_2 <= 3'h4;
            else
              wrbypass_0_2 <= 3'h3;
          end
          else if (io_update_taken_2) begin
            if (&_wrbypass_wrbypass_hit_idx_2_2)
              wrbypass_0_2 <= 3'h7;
            else
              wrbypass_0_2 <= _update_wdata_2_ctr_T_7;
          end
          else if (_update_wdata_2_ctr_T_2)
            wrbypass_0_2 <= 3'h0;
          else
            wrbypass_0_2 <= _update_wdata_2_ctr_T_3;
          if (io_update_alloc_3) begin
            if (io_update_taken_3)
              wrbypass_0_3 <= 3'h4;
            else
              wrbypass_0_3 <= 3'h3;
          end
          else if (io_update_taken_3) begin
            if (&_wrbypass_wrbypass_hit_idx_3_2)
              wrbypass_0_3 <= 3'h7;
            else
              wrbypass_0_3 <= _update_wdata_3_ctr_T_7;
          end
          else if (_update_wdata_3_ctr_T_2)
            wrbypass_0_3 <= 3'h0;
          else
            wrbypass_0_3 <= _update_wdata_3_ctr_T_3;
        end
        else begin
          if (io_update_alloc_0) begin
            if (io_update_taken_0)
              wrbypass_1_0 <= 3'h4;
            else
              wrbypass_1_0 <= 3'h3;
          end
          else if (io_update_taken_0) begin
            if (&_wrbypass_wrbypass_hit_idx_0_2)
              wrbypass_1_0 <= 3'h7;
            else
              wrbypass_1_0 <= _update_wdata_0_ctr_T_7;
          end
          else if (_update_wdata_0_ctr_T_2)
            wrbypass_1_0 <= 3'h0;
          else
            wrbypass_1_0 <= _update_wdata_0_ctr_T_3;
          if (io_update_alloc_1) begin
            if (io_update_taken_1)
              wrbypass_1_1 <= 3'h4;
            else
              wrbypass_1_1 <= 3'h3;
          end
          else if (io_update_taken_1) begin
            if (&_wrbypass_wrbypass_hit_idx_1_2)
              wrbypass_1_1 <= 3'h7;
            else
              wrbypass_1_1 <= _update_wdata_1_ctr_T_7;
          end
          else if (_update_wdata_1_ctr_T_2)
            wrbypass_1_1 <= 3'h0;
          else
            wrbypass_1_1 <= _update_wdata_1_ctr_T_3;
          if (io_update_alloc_2) begin
            if (io_update_taken_2)
              wrbypass_1_2 <= 3'h4;
            else
              wrbypass_1_2 <= 3'h3;
          end
          else if (io_update_taken_2) begin
            if (&_wrbypass_wrbypass_hit_idx_2_2)
              wrbypass_1_2 <= 3'h7;
            else
              wrbypass_1_2 <= _update_wdata_2_ctr_T_7;
          end
          else if (_update_wdata_2_ctr_T_2)
            wrbypass_1_2 <= 3'h0;
          else
            wrbypass_1_2 <= _update_wdata_2_ctr_T_3;
          if (io_update_alloc_3) begin
            if (io_update_taken_3)
              wrbypass_1_3 <= 3'h4;
            else
              wrbypass_1_3 <= 3'h3;
          end
          else if (io_update_taken_3) begin
            if (&_wrbypass_wrbypass_hit_idx_3_2)
              wrbypass_1_3 <= 3'h7;
            else
              wrbypass_1_3 <= _update_wdata_3_ctr_T_7;
          end
          else if (_update_wdata_3_ctr_T_2)
            wrbypass_1_3 <= 3'h0;
          else
            wrbypass_1_3 <= _update_wdata_3_ctr_T_3;
        end
      end
      else if (wrbypass_enq_idx) begin
        if (io_update_alloc_0) begin
          if (io_update_taken_0)
            wrbypass_1_0 <= 3'h4;
          else
            wrbypass_1_0 <= 3'h3;
        end
        else if (io_update_taken_0) begin
          if (&io_update_old_ctr_0)
            wrbypass_1_0 <= 3'h7;
          else
            wrbypass_1_0 <= _update_wdata_0_ctr_T_17;
        end
        else if (_update_wdata_0_ctr_T_12)
          wrbypass_1_0 <= 3'h0;
        else
          wrbypass_1_0 <= _update_wdata_0_ctr_T_13;
        if (io_update_alloc_1) begin
          if (io_update_taken_1)
            wrbypass_1_1 <= 3'h4;
          else
            wrbypass_1_1 <= 3'h3;
        end
        else if (io_update_taken_1) begin
          if (&io_update_old_ctr_1)
            wrbypass_1_1 <= 3'h7;
          else
            wrbypass_1_1 <= _update_wdata_1_ctr_T_17;
        end
        else if (_update_wdata_1_ctr_T_12)
          wrbypass_1_1 <= 3'h0;
        else
          wrbypass_1_1 <= _update_wdata_1_ctr_T_13;
        if (io_update_alloc_2) begin
          if (io_update_taken_2)
            wrbypass_1_2 <= 3'h4;
          else
            wrbypass_1_2 <= 3'h3;
        end
        else if (io_update_taken_2) begin
          if (&io_update_old_ctr_2)
            wrbypass_1_2 <= 3'h7;
          else
            wrbypass_1_2 <= _update_wdata_2_ctr_T_17;
        end
        else if (_update_wdata_2_ctr_T_12)
          wrbypass_1_2 <= 3'h0;
        else
          wrbypass_1_2 <= _update_wdata_2_ctr_T_13;
        if (io_update_alloc_3) begin
          if (io_update_taken_3)
            wrbypass_1_3 <= 3'h4;
          else
            wrbypass_1_3 <= 3'h3;
        end
        else if (io_update_taken_3) begin
          if (&io_update_old_ctr_3)
            wrbypass_1_3 <= 3'h7;
          else
            wrbypass_1_3 <= _update_wdata_3_ctr_T_17;
        end
        else if (_update_wdata_3_ctr_T_12)
          wrbypass_1_3 <= 3'h0;
        else
          wrbypass_1_3 <= _update_wdata_3_ctr_T_13;
      end
      else begin
        if (io_update_alloc_0) begin
          if (io_update_taken_0)
            wrbypass_0_0 <= 3'h4;
          else
            wrbypass_0_0 <= 3'h3;
        end
        else if (io_update_taken_0) begin
          if (&io_update_old_ctr_0)
            wrbypass_0_0 <= 3'h7;
          else
            wrbypass_0_0 <= _update_wdata_0_ctr_T_17;
        end
        else if (_update_wdata_0_ctr_T_12)
          wrbypass_0_0 <= 3'h0;
        else
          wrbypass_0_0 <= _update_wdata_0_ctr_T_13;
        if (io_update_alloc_1) begin
          if (io_update_taken_1)
            wrbypass_0_1 <= 3'h4;
          else
            wrbypass_0_1 <= 3'h3;
        end
        else if (io_update_taken_1) begin
          if (&io_update_old_ctr_1)
            wrbypass_0_1 <= 3'h7;
          else
            wrbypass_0_1 <= _update_wdata_1_ctr_T_17;
        end
        else if (_update_wdata_1_ctr_T_12)
          wrbypass_0_1 <= 3'h0;
        else
          wrbypass_0_1 <= _update_wdata_1_ctr_T_13;
        if (io_update_alloc_2) begin
          if (io_update_taken_2)
            wrbypass_0_2 <= 3'h4;
          else
            wrbypass_0_2 <= 3'h3;
        end
        else if (io_update_taken_2) begin
          if (&io_update_old_ctr_2)
            wrbypass_0_2 <= 3'h7;
          else
            wrbypass_0_2 <= _update_wdata_2_ctr_T_17;
        end
        else if (_update_wdata_2_ctr_T_12)
          wrbypass_0_2 <= 3'h0;
        else
          wrbypass_0_2 <= _update_wdata_2_ctr_T_13;
        if (io_update_alloc_3) begin
          if (io_update_taken_3)
            wrbypass_0_3 <= 3'h4;
          else
            wrbypass_0_3 <= 3'h3;
        end
        else if (io_update_taken_3) begin
          if (&io_update_old_ctr_3)
            wrbypass_0_3 <= 3'h7;
          else
            wrbypass_0_3 <= _update_wdata_3_ctr_T_17;
        end
        else if (_update_wdata_3_ctr_T_12)
          wrbypass_0_3 <= 3'h0;
        else
          wrbypass_0_3 <= _update_wdata_3_ctr_T_13;
      end
    end
  end // always @(posedge)
  mem_128x1 hi_us_0_ext (
    .R0_addr (s1_hashed_idx),
    .R0_en   (io_f1_req_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_4),
    .W0_en   (_GEN_7[0]),
    .W0_clk  (clock),
    .W0_data (~_GEN_5 & io_update_u_0[1]),
    .R0_data (_hi_us_0_ext_R0_data)
  );
  mem_128x1 hi_us_1_ext (
    .R0_addr (s1_hashed_idx),
    .R0_en   (io_f1_req_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_4),
    .W0_en   (_GEN_7[1]),
    .W0_clk  (clock),
    .W0_data (~_GEN_5 & io_update_u_1[1]),
    .R0_data (_hi_us_1_ext_R0_data)
  );
  mem_128x1 hi_us_2_ext (
    .R0_addr (s1_hashed_idx),
    .R0_en   (io_f1_req_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_4),
    .W0_en   (_GEN_7[2]),
    .W0_clk  (clock),
    .W0_data (~_GEN_5 & io_update_u_2[1]),
    .R0_data (_hi_us_2_ext_R0_data)
  );
  mem_128x1 hi_us_3_ext (
    .R0_addr (s1_hashed_idx),
    .R0_en   (io_f1_req_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_4),
    .W0_en   (_GEN_7[3]),
    .W0_clk  (clock),
    .W0_data (~_GEN_5 & io_update_u_3[1]),
    .R0_data (_hi_us_3_ext_R0_data)
  );
  mem_128x1 lo_us_0_ext (
    .R0_addr (s1_hashed_idx),
    .R0_en   (io_f1_req_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_8),
    .W0_en   (_GEN_10[0]),
    .W0_clk  (clock),
    .W0_data (~_GEN_9 & io_update_u_0[0]),
    .R0_data (_lo_us_0_ext_R0_data)
  );
  mem_128x1 lo_us_1_ext (
    .R0_addr (s1_hashed_idx),
    .R0_en   (io_f1_req_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_8),
    .W0_en   (_GEN_10[1]),
    .W0_clk  (clock),
    .W0_data (~_GEN_9 & io_update_u_1[0]),
    .R0_data (_lo_us_1_ext_R0_data)
  );
  mem_128x1 lo_us_2_ext (
    .R0_addr (s1_hashed_idx),
    .R0_en   (io_f1_req_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_8),
    .W0_en   (_GEN_10[2]),
    .W0_clk  (clock),
    .W0_data (~_GEN_9 & io_update_u_2[0]),
    .R0_data (_lo_us_2_ext_R0_data)
  );
  mem_128x1 lo_us_3_ext (
    .R0_addr (s1_hashed_idx),
    .R0_en   (io_f1_req_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_8),
    .W0_en   (_GEN_10[3]),
    .W0_clk  (clock),
    .W0_data (~_GEN_9 & io_update_u_3[0]),
    .R0_data (_lo_us_3_ext_R0_data)
  );
  table_128x11 table_0_ext (
    .R0_addr (s1_hashed_idx),
    .R0_en   (io_f1_req_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_1),
    .W0_en   (_GEN_2[0]),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 11'h0 : {1'h1, io_update_pc[17:15], _GEN_0, io_update_alloc_0 ? (io_update_taken_0 ? 3'h4 : 3'h3) : wrbypass_hit ? (io_update_taken_0 ? ((&_wrbypass_wrbypass_hit_idx_0_2) ? 3'h7 : _update_wdata_0_ctr_T_7) : _update_wdata_0_ctr_T_2 ? 3'h0 : _update_wdata_0_ctr_T_3) : io_update_taken_0 ? ((&io_update_old_ctr_0) ? 3'h7 : _update_wdata_0_ctr_T_17) : _update_wdata_0_ctr_T_12 ? 3'h0 : _update_wdata_0_ctr_T_13}),
    .R0_data (_table_0_ext_R0_data)
  );
  table_128x11 table_1_ext (
    .R0_addr (s1_hashed_idx),
    .R0_en   (io_f1_req_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_1),
    .W0_en   (_GEN_2[1]),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 11'h0 : {1'h1, io_update_pc[17:15], _GEN_0, io_update_alloc_1 ? (io_update_taken_1 ? 3'h4 : 3'h3) : wrbypass_hit ? (io_update_taken_1 ? ((&_wrbypass_wrbypass_hit_idx_1_2) ? 3'h7 : _update_wdata_1_ctr_T_7) : _update_wdata_1_ctr_T_2 ? 3'h0 : _update_wdata_1_ctr_T_3) : io_update_taken_1 ? ((&io_update_old_ctr_1) ? 3'h7 : _update_wdata_1_ctr_T_17) : _update_wdata_1_ctr_T_12 ? 3'h0 : _update_wdata_1_ctr_T_13}),
    .R0_data (_table_1_ext_R0_data)
  );
  table_128x11 table_2_ext (
    .R0_addr (s1_hashed_idx),
    .R0_en   (io_f1_req_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_1),
    .W0_en   (_GEN_2[2]),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 11'h0 : {1'h1, io_update_pc[17:15], _GEN_0, io_update_alloc_2 ? (io_update_taken_2 ? 3'h4 : 3'h3) : wrbypass_hit ? (io_update_taken_2 ? ((&_wrbypass_wrbypass_hit_idx_2_2) ? 3'h7 : _update_wdata_2_ctr_T_7) : _update_wdata_2_ctr_T_2 ? 3'h0 : _update_wdata_2_ctr_T_3) : io_update_taken_2 ? ((&io_update_old_ctr_2) ? 3'h7 : _update_wdata_2_ctr_T_17) : _update_wdata_2_ctr_T_12 ? 3'h0 : _update_wdata_2_ctr_T_13}),
    .R0_data (_table_2_ext_R0_data)
  );
  table_128x11 table_3_ext (
    .R0_addr (s1_hashed_idx),
    .R0_en   (io_f1_req_valid),
    .R0_clk  (clock),
    .W0_addr (_GEN_1),
    .W0_en   (_GEN_2[3]),
    .W0_clk  (clock),
    .W0_data (doing_reset ? 11'h0 : {1'h1, io_update_pc[17:15], _GEN_0, io_update_alloc_3 ? (io_update_taken_3 ? 3'h4 : 3'h3) : wrbypass_hit ? (io_update_taken_3 ? ((&_wrbypass_wrbypass_hit_idx_3_2) ? 3'h7 : _update_wdata_3_ctr_T_7) : _update_wdata_3_ctr_T_2 ? 3'h0 : _update_wdata_3_ctr_T_3) : io_update_taken_3 ? ((&io_update_old_ctr_3) ? 3'h7 : _update_wdata_3_ctr_T_17) : _update_wdata_3_ctr_T_12 ? 3'h0 : _update_wdata_3_ctr_T_13}),
    .R0_data (_table_3_ext_R0_data)
  );
  assign io_f3_resp_0_valid = io_f3_resp_0_valid_REG;
  assign io_f3_resp_0_bits_ctr = io_f3_resp_0_bits_ctr_REG;
  assign io_f3_resp_0_bits_u = io_f3_resp_0_bits_u_REG;
  assign io_f3_resp_1_valid = io_f3_resp_1_valid_REG;
  assign io_f3_resp_1_bits_ctr = io_f3_resp_1_bits_ctr_REG;
  assign io_f3_resp_1_bits_u = io_f3_resp_1_bits_u_REG;
  assign io_f3_resp_2_valid = io_f3_resp_2_valid_REG;
  assign io_f3_resp_2_bits_ctr = io_f3_resp_2_bits_ctr_REG;
  assign io_f3_resp_2_bits_u = io_f3_resp_2_bits_u_REG;
  assign io_f3_resp_3_valid = io_f3_resp_3_valid_REG;
  assign io_f3_resp_3_bits_ctr = io_f3_resp_3_bits_ctr_REG;
  assign io_f3_resp_3_bits_u = io_f3_resp_3_bits_u_REG;
endmodule

