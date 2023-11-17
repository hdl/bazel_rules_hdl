// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module SourceD(
  input          clock,
                 reset,
                 io_req_valid,
                 io_req_bits_prio_0,
                 io_req_bits_prio_2,
  input  [2:0]   io_req_bits_opcode,
                 io_req_bits_param,
                 io_req_bits_size,
  input  [5:0]   io_req_bits_source,
                 io_req_bits_offset,
                 io_req_bits_put,
  input  [9:0]   io_req_bits_set,
  input  [3:0]   io_req_bits_sink,
  input  [2:0]   io_req_bits_way,
  input          io_req_bits_bad,
                 io_d_ready,
                 io_pb_pop_ready,
  input  [127:0] io_pb_beat_data,
  input  [15:0]  io_pb_beat_mask,
  input          io_pb_beat_corrupt,
                 io_rel_pop_ready,
  input  [127:0] io_rel_beat_data,
  input          io_rel_beat_corrupt,
                 io_bs_radr_ready,
  input  [127:0] io_bs_rdat_data,
  input          io_bs_wadr_ready,
  input  [9:0]   io_evict_req_set,
  input  [2:0]   io_evict_req_way,
  input  [9:0]   io_grant_req_set,
  input  [2:0]   io_grant_req_way,
  output         io_req_ready,
                 io_d_valid,
  output [2:0]   io_d_bits_opcode,
  output [1:0]   io_d_bits_param,
  output [2:0]   io_d_bits_size,
  output [5:0]   io_d_bits_source,
  output [3:0]   io_d_bits_sink,
  output         io_d_bits_denied,
  output [127:0] io_d_bits_data,
  output         io_d_bits_corrupt,
                 io_pb_pop_valid,
  output [5:0]   io_pb_pop_bits_index,
  output         io_pb_pop_bits_last,
                 io_rel_pop_valid,
  output [5:0]   io_rel_pop_bits_index,
  output         io_rel_pop_bits_last,
                 io_bs_radr_valid,
  output [2:0]   io_bs_radr_bits_way,
  output [9:0]   io_bs_radr_bits_set,
  output [1:0]   io_bs_radr_bits_beat,
                 io_bs_radr_bits_mask,
  output         io_bs_wadr_valid,
  output [2:0]   io_bs_wadr_bits_way,
  output [9:0]   io_bs_wadr_bits_set,
  output [1:0]   io_bs_wadr_bits_beat,
                 io_bs_wadr_bits_mask,
  output [127:0] io_bs_wdat_data,
  output         io_evict_safe,
                 io_grant_safe
);

  wire [127:0] _atomics_io_data_out;
  wire         _queue_io_enq_ready;
  wire         _queue_io_deq_valid;
  wire [127:0] _queue_io_deq_bits_data;
  reg          busy;
  reg          s1_block_r;
  reg  [1:0]   s1_counter;
  reg          s1_req_reg_prio_0;
  reg          s1_req_reg_prio_2;
  reg  [2:0]   s1_req_reg_opcode;
  reg  [2:0]   s1_req_reg_param;
  reg  [2:0]   s1_req_reg_size;
  reg  [5:0]   s1_req_reg_source;
  reg  [5:0]   s1_req_reg_offset;
  reg  [5:0]   s1_req_reg_put;
  reg  [9:0]   s1_req_reg_set;
  reg  [3:0]   s1_req_reg_sink;
  reg  [2:0]   s1_req_reg_way;
  reg          s1_req_reg_bad;
  wire         s1_req_prio_0 = busy ? s1_req_reg_prio_0 : io_req_bits_prio_0;
  wire [2:0]   s1_req_opcode = busy ? s1_req_reg_opcode : io_req_bits_opcode;
  wire [2:0]   s1_req_size = busy ? s1_req_reg_size : io_req_bits_size;
  wire [2:0]   s1_req_offset = busy ? s1_req_reg_offset[5:3] : io_req_bits_offset[5:3];
  wire [9:0]   s1_req_set = busy ? s1_req_reg_set : io_req_bits_set;
  wire [2:0]   s1_req_way = busy ? s1_req_reg_way : io_req_bits_way;
  wire         _s1_valid_T = busy | io_req_valid;
  reg          s2_full;
  reg          s3_full;
  reg          s3_retires;
  reg          s4_full;
  reg          s4_need_bs;
  wire         s4_ready = ~s3_retires | ~s4_full | io_bs_wadr_ready | ~s4_need_bs;
  reg          d_valid;
  wire         s3_ready = ~s3_full | s4_ready & (~d_valid | io_d_ready);
  reg          s2_valid_pb;
  reg          s2_req_prio_0;
  wire         pb_ready = s2_req_prio_0 ? io_pb_pop_ready : io_rel_pop_ready;
  reg          s1_latch_bypass;
  reg  [1:0]   s1_bypass_r;
  reg  [9:0]   s2_req_set;
  reg  [2:0]   s2_req_way;
  reg  [1:0]   s2_beat;
  wire [1:0]   s1_beat = s1_req_offset[2:1] | s1_counter;
  reg          s2_retires;
  reg  [2:0]   s2_req_size;
  reg  [5:0]   s2_req_offset;
  reg  [9:0]   s3_req_set;
  reg  [2:0]   s3_req_way;
  reg  [1:0]   s3_beat;
  reg  [2:0]   s3_req_size;
  reg  [5:0]   s3_req_offset;
  reg  [9:0]   s4_req_set;
  reg  [2:0]   s4_req_way;
  reg  [1:0]   s4_beat;
  reg  [2:0]   s4_req_size;
  reg  [5:0]   s4_req_offset;
  wire [1:0]   s1_x_bypass = (s2_req_set == s1_req_set & s2_req_way == s1_req_way & s2_beat == s1_beat & s2_full & s2_retires ? {s2_req_size[2] | s2_req_offset[3], s2_req_size[2] | ~(s2_req_offset[3])} : 2'h0) | (s3_req_set == s1_req_set & s3_req_way == s1_req_way & s3_beat == s1_beat & s3_full & s3_retires ? {s3_req_size[2] | s3_req_offset[3], s3_req_size[2] | ~(s3_req_offset[3])} : 2'h0) | (s4_req_set == s1_req_set & s4_req_way == s1_req_way & s4_beat == s1_beat & s4_full ? {s4_req_size[2] | s4_req_offset[3], s4_req_size[2] | ~(s4_req_offset[3])} : 2'h0);
  wire [1:0]   s1_mask = {s1_req_size[2] | s1_req_offset[0], s1_req_size[2] | ~(s1_req_offset[0])} & ~(s1_latch_bypass ? s1_x_bypass : s1_bypass_r);
  wire         _s1_single_T_2 = s1_req_opcode == 3'h6;
  wire         s1_grant = _s1_single_T_2 & (busy ? s1_req_reg_param : io_req_bits_param) == 3'h2 | (&s1_req_opcode);
  wire         s1_need_r = (|s1_mask) & s1_req_prio_0 & s1_req_opcode != 3'h5 & ~s1_grant & ((|s1_req_opcode) | s1_req_size < 3'h3);
  wire         _io_bs_radr_valid_output = _s1_valid_T & s1_need_r & ~s1_block_r;
  reg          queue_io_enq_valid_REG;
  reg          queue_io_enq_valid_REG_1;
  reg  [1:0]   s2_bypass;
  reg          s2_req_prio_2;
  reg  [2:0]   s2_req_opcode;
  reg  [2:0]   s2_req_param;
  reg  [5:0]   s2_req_source;
  reg  [5:0]   s2_req_put;
  reg  [3:0]   s2_req_sink;
  reg          s2_req_bad;
  reg          s2_last;
  reg          s2_need_r;
  reg          s2_need_pb;
  reg          s2_need_d;
  reg  [127:0] s2_pdata_r_data;
  reg  [15:0]  s2_pdata_r_mask;
  wire         s3_latch = s2_full & (~s2_valid_pb | pb_ready) & s3_ready;
  reg  [1:0]   s3_bypass;
  reg          s3_req_prio_0;
  reg          s3_req_prio_2;
  reg  [2:0]   s3_req_opcode;
  reg  [2:0]   s3_req_param;
  reg  [5:0]   s3_req_source;
  reg  [3:0]   s3_req_sink;
  reg          s3_req_bad;
  reg  [127:0] s3_pdata_data;
  reg  [15:0]  s3_pdata_mask;
  reg          s3_need_pb;
  reg          s3_need_r;
  reg  [1:0]   s3_bypass_data_REG;
  reg  [127:0] s3_bypass_data_REG_1;
  wire [127:0] s3_rdata = {s3_bypass[1] ? (s3_bypass_data_REG[1] ? _atomics_io_data_out[127:64] : s3_bypass_data_REG_1[127:64]) : _queue_io_deq_bits_data[127:64], s3_bypass[0] ? (s3_bypass_data_REG[0] ? _atomics_io_data_out[63:0] : s3_bypass_data_REG_1[63:0]) : _queue_io_deq_bits_data[63:0]};
  wire [2:0]   d_bits_opcode = s3_req_prio_0 ? ((&s3_req_opcode) ? 3'h4 : s3_req_opcode == 3'h6 ? {2'h2, s3_req_param != 3'h2} : s3_req_opcode == 3'h5 ? 3'h2 : {2'h0, s3_req_opcode == 3'h4 | s3_req_opcode == 3'h3 | s3_req_opcode == 3'h2}) : 3'h6;
  wire         s3_valid = s3_full & (~d_valid | io_d_ready);
  wire         _queue_io_deq_ready_T = s3_valid & s4_ready;
  wire         s4_latch = s3_valid & s3_retires & s4_ready;
  reg          s4_req_prio_2;
  reg  [2:0]   s4_req_param;
  reg  [2:0]   s4_adjusted_opcode;
  reg  [127:0] s4_pdata_data;
  reg  [15:0]  s4_pdata_mask;
  reg  [127:0] s4_rdata;
  reg  [2:0]   s5_req_size;
  reg  [5:0]   s5_req_offset;
  reg  [9:0]   s5_req_set;
  reg  [2:0]   s5_req_way;
  reg  [1:0]   s5_beat;
  reg  [127:0] s5_dat;
  reg  [2:0]   s6_req_size;
  reg  [5:0]   s6_req_offset;
  reg  [9:0]   s6_req_set;
  reg  [2:0]   s6_req_way;
  reg  [1:0]   s6_beat;
  reg  [127:0] s6_dat;
  reg  [127:0] s7_dat;
  wire         s2_ready = ~s2_full | s3_ready & (~s2_valid_pb | pb_ready);
  wire         s1_single = s1_req_prio_0 ? s1_req_opcode == 3'h5 | s1_grant : _s1_single_T_2;
  wire [12:0]  _s1_beats1_T_1 = 13'h3F << s1_req_size;
  wire         s1_last = s1_counter == (s1_single ? 2'h0 : ~(_s1_beats1_T_1[5:4]));
  wire         _queue_io_enq_valid_T = io_bs_radr_ready & _io_bs_radr_valid_output;
  wire         s2_latch = _s1_valid_T & (~_io_bs_radr_valid_output | io_bs_radr_ready) & s2_ready;
  wire [1:0]   pre_s3_beat = s3_latch ? s2_beat : s3_beat;
  wire [9:0]   pre_s3_req_set = s3_latch ? s2_req_set : s3_req_set;
  wire [2:0]   pre_s3_req_way = s3_latch ? s2_req_way : s3_req_way;
  wire         retire = s4_full & (io_bs_wadr_ready | ~s4_need_bs);
  wire         pre_s5_req_size = retire ? s4_req_size[2] : s5_req_size[2];
  wire         pre_s5_req_offset = retire ? s4_req_offset[3] : s5_req_offset[3];
  wire [127:0] pre_s5_dat = retire ? _atomics_io_data_out : s5_dat;
  wire         pre_s6_req_size = retire ? s5_req_size[2] : s6_req_size[2];
  wire         pre_s6_req_offset = retire ? s5_req_offset[3] : s6_req_offset[3];
  wire [127:0] pre_s6_dat = retire ? s5_dat : s6_dat;
  wire [127:0] pre_s7_dat = retire ? s6_dat : s7_dat;
  wire [1:0]   pre_s3_5_bypass = (retire ? s4_req_set : s5_req_set) == pre_s3_req_set & (retire ? s4_req_way : s5_req_way) == pre_s3_req_way & (retire ? s4_beat : s5_beat) == pre_s3_beat ? {pre_s5_req_size | pre_s5_req_offset, pre_s5_req_size | ~pre_s5_req_offset} : 2'h0;
  wire [1:0]   pre_s3_6_bypass = (retire ? s5_req_set : s6_req_set) == pre_s3_req_set & (retire ? s5_req_way : s6_req_way) == pre_s3_req_way & (retire ? s5_beat : s6_beat) == pre_s3_beat ? {pre_s6_req_size | pre_s6_req_offset, pre_s6_req_size | ~pre_s6_req_offset} : 2'h0;
  wire         pre_s4_req_size = s4_latch ? s3_req_size[2] : s4_req_size[2];
  wire         pre_s4_req_offset = s4_latch ? s3_req_offset[3] : s4_req_offset[3];
  always @(posedge clock) begin
    if (reset) begin
      busy <= 1'h0;
      s1_block_r <= 1'h0;
      s1_counter <= 2'h0;
      s2_full <= 1'h0;
      s3_full <= 1'h0;
      s4_full <= 1'h0;
      d_valid <= 1'h0;
      s2_valid_pb <= 1'h0;
    end
    else begin
      busy <= ~(s2_latch & s1_last) & (io_req_valid | busy);
      s1_block_r <= ~s2_latch & (_queue_io_enq_valid_T | s1_block_r);
      if (s2_latch) begin
        if (s1_last)
          s1_counter <= 2'h0;
        else
          s1_counter <= s1_counter + 2'h1;
        if (s1_req_prio_0)
          s2_valid_pb <= ~(s1_req_opcode[2]);
        else
          s2_valid_pb <= s1_req_opcode[0];
      end
      else
        s2_valid_pb <= ~pb_ready & s2_valid_pb;
      s2_full <= s2_latch | ~s3_latch & s2_full;
      s3_full <= s3_latch | ~_queue_io_deq_ready_T & s3_full;
      s4_full <= s4_latch | ~(io_bs_wadr_ready | ~s4_need_bs) & s4_full;
      if (s3_latch)
        d_valid <= s2_need_d;
      else
        d_valid <= ~io_d_ready & d_valid;
    end
    if (~busy & io_req_valid) begin
      s1_req_reg_prio_0 <= io_req_bits_prio_0;
      s1_req_reg_prio_2 <= io_req_bits_prio_2;
      s1_req_reg_opcode <= io_req_bits_opcode;
      s1_req_reg_param <= io_req_bits_param;
      s1_req_reg_size <= io_req_bits_size;
      s1_req_reg_source <= io_req_bits_source;
      s1_req_reg_offset <= io_req_bits_offset;
      s1_req_reg_put <= io_req_bits_put;
      s1_req_reg_set <= io_req_bits_set;
      s1_req_reg_sink <= io_req_bits_sink;
      s1_req_reg_way <= io_req_bits_way;
      s1_req_reg_bad <= io_req_bits_bad;
    end
    if (s3_latch) begin
      s3_retires <= s2_retires;
      s3_req_set <= s2_req_set;
      s3_req_way <= s2_req_way;
      s3_beat <= s2_beat;
      s3_req_size <= s2_req_size;
      s3_req_offset <= s2_req_offset;
      s3_bypass <= s2_bypass;
      s3_req_prio_0 <= s2_req_prio_0;
      s3_req_prio_2 <= s2_req_prio_2;
      s3_req_opcode <= s2_req_opcode;
      s3_req_param <= s2_req_param;
      s3_req_source <= s2_req_source;
      s3_req_sink <= s2_req_sink;
      s3_req_bad <= s2_req_bad;
      if (s2_valid_pb) begin
        if (s2_req_prio_0) begin
          s3_pdata_data <= io_pb_beat_data;
          s3_pdata_mask <= io_pb_beat_mask;
        end
        else begin
          s3_pdata_data <= io_rel_beat_data;
          s3_pdata_mask <= 16'hFFFF;
        end
      end
      else begin
        s3_pdata_data <= s2_pdata_r_data;
        s3_pdata_mask <= s2_pdata_r_mask;
      end
      s3_need_pb <= s2_need_pb;
      s3_need_r <= s2_need_r;
    end
    if (s4_latch) begin
      s4_need_bs <= s3_need_pb;
      s4_req_set <= s3_req_set;
      s4_req_way <= s3_req_way;
      s4_beat <= s3_beat;
      s4_req_size <= s3_req_size;
      s4_req_offset <= s3_req_offset;
      s4_req_prio_2 <= s3_req_prio_2;
      s4_req_param <= s3_req_param;
      if (s3_req_bad)
        s4_adjusted_opcode <= 3'h4;
      else
        s4_adjusted_opcode <= s3_req_opcode;
      s4_pdata_data <= s3_pdata_data;
      s4_pdata_mask <= s3_pdata_mask;
      s4_rdata <= s3_rdata;
    end
    if (s2_latch) begin
      if (busy) begin
        s2_req_prio_0 <= s1_req_reg_prio_0;
        s2_req_set <= s1_req_reg_set;
        s2_req_way <= s1_req_reg_way;
        s2_req_size <= s1_req_reg_size;
        s2_req_offset <= s1_req_reg_offset;
        s2_req_prio_2 <= s1_req_reg_prio_2;
        s2_req_opcode <= s1_req_reg_opcode;
        s2_req_param <= s1_req_reg_param;
        s2_req_source <= s1_req_reg_source;
        s2_req_put <= s1_req_reg_put;
        s2_req_sink <= s1_req_reg_sink;
        s2_req_bad <= s1_req_reg_bad;
      end
      else begin
        s2_req_prio_0 <= io_req_bits_prio_0;
        s2_req_set <= io_req_bits_set;
        s2_req_way <= io_req_bits_way;
        s2_req_size <= io_req_bits_size;
        s2_req_offset <= io_req_bits_offset;
        s2_req_prio_2 <= io_req_bits_prio_2;
        s2_req_opcode <= io_req_bits_opcode;
        s2_req_param <= io_req_bits_param;
        s2_req_source <= io_req_bits_source;
        s2_req_put <= io_req_bits_put;
        s2_req_sink <= io_req_bits_sink;
        s2_req_bad <= io_req_bits_bad;
      end
      s2_beat <= s1_beat;
      s2_retires <= ~s1_single;
      if (s1_latch_bypass)
        s2_bypass <= s1_x_bypass;
      else
        s2_bypass <= s1_bypass_r;
      s2_last <= s1_last;
      s2_need_r <= s1_need_r;
      if (s1_req_prio_0)
        s2_need_pb <= ~(s1_req_opcode[2]);
      else
        s2_need_pb <= s1_req_opcode[0];
      s2_need_d <= ~(s1_req_prio_0 ? ~(s1_req_opcode[2]) : s1_req_opcode[0]) | s1_counter == 2'h0;
    end
    s1_latch_bypass <= ~_s1_valid_T | s2_ready;
    if (s1_latch_bypass)
      s1_bypass_r <= s1_x_bypass;
    queue_io_enq_valid_REG <= _queue_io_enq_valid_T;
    queue_io_enq_valid_REG_1 <= queue_io_enq_valid_REG;
    if (s2_valid_pb) begin
      if (s2_req_prio_0) begin
        s2_pdata_r_data <= io_pb_beat_data;
        s2_pdata_r_mask <= io_pb_beat_mask;
      end
      else begin
        s2_pdata_r_data <= io_rel_beat_data;
        s2_pdata_r_mask <= 16'hFFFF;
      end
    end
    if ((s4_latch ? s3_req_set : s4_req_set) == pre_s3_req_set & (s4_latch ? s3_req_way : s4_req_way) == pre_s3_req_way & (s4_latch ? s3_beat : s4_beat) == pre_s3_beat & (s4_latch | ~(io_bs_wadr_ready | ~s4_need_bs) & s4_full))
      s3_bypass_data_REG <= {pre_s4_req_size | pre_s4_req_offset, pre_s4_req_size | ~pre_s4_req_offset};
    else
      s3_bypass_data_REG <= 2'h0;
    s3_bypass_data_REG_1 <= {pre_s3_5_bypass[1] ? pre_s5_dat[127:64] : pre_s3_6_bypass[1] ? pre_s6_dat[127:64] : pre_s7_dat[127:64], pre_s3_5_bypass[0] ? pre_s5_dat[63:0] : pre_s3_6_bypass[0] ? pre_s6_dat[63:0] : pre_s7_dat[63:0]};
    if (retire) begin
      s5_req_size <= s4_req_size;
      s5_req_offset <= s4_req_offset;
      s5_req_set <= s4_req_set;
      s5_req_way <= s4_req_way;
      s5_beat <= s4_beat;
      s5_dat <= _atomics_io_data_out;
      s6_req_size <= s5_req_size;
      s6_req_offset <= s5_req_offset;
      s6_req_set <= s5_req_set;
      s6_req_way <= s5_req_way;
      s6_beat <= s5_beat;
      s6_dat <= s5_dat;
      s7_dat <= s6_dat;
    end
  end // always @(posedge)
  Queue_54 queue (
    .clock            (clock),
    .reset            (reset),
    .io_enq_valid     (queue_io_enq_valid_REG_1),
    .io_enq_bits_data (io_bs_rdat_data),
    .io_deq_ready     (_queue_io_deq_ready_T & s3_need_r),
    .io_enq_ready     (_queue_io_enq_ready),
    .io_deq_valid     (_queue_io_deq_valid),
    .io_deq_bits_data (_queue_io_deq_bits_data)
  );
  Atomics atomics (
    .io_write    (s4_req_prio_2),
    .io_a_opcode (s4_adjusted_opcode),
    .io_a_param  (s4_req_param),
    .io_a_mask   (s4_pdata_mask),
    .io_a_data   (s4_pdata_data),
    .io_data_in  (s4_rdata),
    .io_data_out (_atomics_io_data_out)
  );
  assign io_req_ready = ~busy;
  assign io_d_valid = d_valid;
  assign io_d_bits_opcode = d_bits_opcode;
  assign io_d_bits_param = s3_req_prio_0 & (s3_req_opcode == 3'h6 | (&s3_req_opcode)) ? {1'h0, s3_req_param == 3'h0} : 2'h0;
  assign io_d_bits_size = s3_req_size;
  assign io_d_bits_source = s3_req_source;
  assign io_d_bits_sink = s3_req_sink;
  assign io_d_bits_denied = s3_req_bad;
  assign io_d_bits_data = s3_rdata;
  assign io_d_bits_corrupt = s3_req_bad & d_bits_opcode[0];
  assign io_pb_pop_valid = s2_valid_pb & s2_req_prio_0;
  assign io_pb_pop_bits_index = s2_req_put;
  assign io_pb_pop_bits_last = s2_last;
  assign io_rel_pop_valid = s2_valid_pb & ~s2_req_prio_0;
  assign io_rel_pop_bits_index = s2_req_put;
  assign io_rel_pop_bits_last = s2_last;
  assign io_bs_radr_valid = _io_bs_radr_valid_output;
  assign io_bs_radr_bits_way = s1_req_way;
  assign io_bs_radr_bits_set = s1_req_set;
  assign io_bs_radr_bits_beat = s1_beat;
  assign io_bs_radr_bits_mask = s1_mask;
  assign io_bs_wadr_valid = s4_full & s4_need_bs;
  assign io_bs_wadr_bits_way = s4_req_way;
  assign io_bs_wadr_bits_set = s4_req_set;
  assign io_bs_wadr_bits_beat = s4_beat;
  assign io_bs_wadr_bits_mask = {s4_pdata_mask[8] | s4_pdata_mask[9] | s4_pdata_mask[10] | s4_pdata_mask[11] | s4_pdata_mask[12] | s4_pdata_mask[13] | s4_pdata_mask[14] | s4_pdata_mask[15], s4_pdata_mask[0] | s4_pdata_mask[1] | s4_pdata_mask[2] | s4_pdata_mask[3] | s4_pdata_mask[4] | s4_pdata_mask[5] | s4_pdata_mask[6] | s4_pdata_mask[7]};
  assign io_bs_wdat_data = _atomics_io_data_out;
  assign io_evict_safe = (~busy | io_evict_req_way != s1_req_reg_way | io_evict_req_set != s1_req_reg_set) & (~s2_full | io_evict_req_way != s2_req_way | io_evict_req_set != s2_req_set) & (~s3_full | io_evict_req_way != s3_req_way | io_evict_req_set != s3_req_set) & (~s4_full | io_evict_req_way != s4_req_way | io_evict_req_set != s4_req_set);
  assign io_grant_safe = (~busy | io_grant_req_way != s1_req_reg_way | io_grant_req_set != s1_req_reg_set) & (~s2_full | io_grant_req_way != s2_req_way | io_grant_req_set != s2_req_set) & (~s3_full | io_grant_req_way != s3_req_way | io_grant_req_set != s3_req_set) & (~s4_full | io_grant_req_way != s4_req_way | io_grant_req_set != s4_req_set);
endmodule

