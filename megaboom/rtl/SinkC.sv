// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module SinkC(
  input          clock,
                 reset,
                 io_req_ready,
                 io_c_valid,
  input  [2:0]   io_c_bits_opcode,
                 io_c_bits_param,
                 io_c_bits_size,
  input  [5:0]   io_c_bits_source,
  input  [31:0]  io_c_bits_address,
  input  [127:0] io_c_bits_data,
  input          io_c_bits_corrupt,
  input  [2:0]   io_way,
  input          io_bs_adr_ready,
                 io_rel_pop_valid,
  input  [5:0]   io_rel_pop_bits_index,
  input          io_rel_pop_bits_last,
  output         io_req_valid,
  output [2:0]   io_req_bits_opcode,
                 io_req_bits_param,
                 io_req_bits_size,
  output [5:0]   io_req_bits_source,
  output [11:0]  io_req_bits_tag,
  output [5:0]   io_req_bits_offset,
                 io_req_bits_put,
  output [9:0]   io_req_bits_set,
  output         io_resp_valid,
                 io_resp_bits_last,
  output [9:0]   io_resp_bits_set,
  output [11:0]  io_resp_bits_tag,
  output [5:0]   io_resp_bits_source,
  output [2:0]   io_resp_bits_param,
  output         io_resp_bits_data,
                 io_c_ready,
  output [9:0]   io_set,
  output         io_bs_adr_valid,
                 io_bs_adr_bits_noop,
  output [2:0]   io_bs_adr_bits_way,
  output [9:0]   io_bs_adr_bits_set,
  output [1:0]   io_bs_adr_bits_beat,
                 io_bs_adr_bits_mask,
  output [127:0] io_bs_dat_data,
  output         io_rel_pop_ready,
  output [127:0] io_rel_beat_data,
  output         io_rel_beat_corrupt
);

  wire         _io_rel_pop_ready_output;
  wire         _putbuffer_io_push_ready;
  wire [1:0]   _putbuffer_io_valid;
  wire         _io_bs_adr_q_io_enq_ready;
  wire         _c_q_io_deq_valid;
  wire [2:0]   _c_q_io_deq_bits_opcode;
  wire [2:0]   _c_q_io_deq_bits_param;
  wire [2:0]   _c_q_io_deq_bits_size;
  wire [5:0]   _c_q_io_deq_bits_source;
  wire [31:0]  _c_q_io_deq_bits_address;
  wire [127:0] _c_q_io_deq_bits_data;
  wire         _c_q_io_deq_bits_corrupt;
  wire [12:0]  _beats1_decode_T_1 = 13'h3F << _c_q_io_deq_bits_size;
  wire [1:0]   beats1 = _c_q_io_deq_bits_opcode[0] ? ~(_beats1_decode_T_1[5:4]) : 2'h0;
  reg  [1:0]   counter;
  wire [1:0]   _counter1_T = counter - 2'h1;
  wire         last = counter == 2'h1 | beats1 == 2'h0;
  wire [1:0]   beat = beats1 & ~_counter1_T;
  wire         raw_resp = _c_q_io_deq_bits_opcode == 3'h4 | _c_q_io_deq_bits_opcode == 3'h5;
  reg          resp_r;
  wire         resp = _c_q_io_deq_valid ? raw_resp : resp_r;
  reg  [9:0]   io_set_r;
  wire [9:0]   _io_set_output = _c_q_io_deq_valid ? _c_q_io_deq_bits_address[15:6] : io_set_r;
  wire         bs_adr_valid = resp & ((|counter) | _c_q_io_deq_valid & _c_q_io_deq_bits_opcode[0]);
  reg  [127:0] io_bs_dat_data_r;
  reg  [1:0]   bs_adr_bits_beat_r;
  reg  [1:0]   lists;
  wire         req_block = ~(|counter) & ~io_req_ready;
  wire         buf_block = _c_q_io_deq_bits_opcode[0] & ~_putbuffer_io_push_ready;
  wire [1:0]   _freeOH_T_7 = ~lists;
  wire [1:0]   freeIdx_lo = {~(_freeOH_T_7[0]), 1'h1} & _freeOH_T_7;
  wire         _putbuffer_io_pop_valid_T = _io_rel_pop_ready_output & io_rel_pop_valid;
  wire [1:0]   freeIdx = {1'h0, freeIdx_lo[1]};
  wire         set_block = _c_q_io_deq_bits_opcode[0] & ~(|counter) & (&lists);
  wire         _q_io_deq_ready_T_7 = raw_resp ? ~(_c_q_io_deq_bits_opcode[0]) | _io_bs_adr_q_io_enq_ready : ~req_block & ~buf_block & ~set_block;
  reg  [1:0]   put_r;
  wire [1:0]   put = (|counter) ? put_r : freeIdx;
  wire [5:0]   _io_rel_pop_ready_T = {4'h0, _putbuffer_io_valid} >> io_rel_pop_bits_index;
  assign _io_rel_pop_ready_output = _io_rel_pop_ready_T[0];
  always @(posedge clock) begin
    if (reset) begin
      counter <= 2'h0;
      lists <= 2'h0;
    end
    else begin
      if (_q_io_deq_ready_T_7 & _c_q_io_deq_valid) begin
        if (|counter)
          counter <= _counter1_T;
        else if (_c_q_io_deq_bits_opcode[0])
          counter <= ~(_beats1_decode_T_1[5:4]);
        else
          counter <= 2'h0;
      end
      lists <= (lists | (~resp & _c_q_io_deq_valid & ~(|counter) & _c_q_io_deq_bits_opcode[0] & ~req_block & ~buf_block ? freeIdx_lo : 2'h0)) & ~(_putbuffer_io_pop_valid_T & io_rel_pop_bits_last ? 2'h1 << io_rel_pop_bits_index[0] : 2'h0);
    end
    if (_c_q_io_deq_valid) begin
      resp_r <= raw_resp;
      io_set_r <= _c_q_io_deq_bits_address[15:6];
      bs_adr_bits_beat_r <= beat + {1'h0, _io_bs_adr_q_io_enq_ready};
    end
    if (_io_bs_adr_q_io_enq_ready & bs_adr_valid)
      io_bs_dat_data_r <= _c_q_io_deq_bits_data;
    if (~(|counter))
      put_r <= freeIdx;
  end // always @(posedge)
  Queue_57 c_q (
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (io_c_valid),
    .io_enq_bits_opcode  (io_c_bits_opcode),
    .io_enq_bits_param   (io_c_bits_param),
    .io_enq_bits_size    (io_c_bits_size),
    .io_enq_bits_source  (io_c_bits_source),
    .io_enq_bits_address (io_c_bits_address),
    .io_enq_bits_data    (io_c_bits_data),
    .io_enq_bits_corrupt (io_c_bits_corrupt),
    .io_deq_ready        (_q_io_deq_ready_T_7),
    .io_enq_ready        (io_c_ready),
    .io_deq_valid        (_c_q_io_deq_valid),
    .io_deq_bits_opcode  (_c_q_io_deq_bits_opcode),
    .io_deq_bits_param   (_c_q_io_deq_bits_param),
    .io_deq_bits_size    (_c_q_io_deq_bits_size),
    .io_deq_bits_source  (_c_q_io_deq_bits_source),
    .io_deq_bits_address (_c_q_io_deq_bits_address),
    .io_deq_bits_data    (_c_q_io_deq_bits_data),
    .io_deq_bits_corrupt (_c_q_io_deq_bits_corrupt)
  );
  Queue_58 io_bs_adr_q (
    .clock            (clock),
    .reset            (reset),
    .io_enq_valid     (bs_adr_valid),
    .io_enq_bits_noop (~_c_q_io_deq_valid),
    .io_enq_bits_way  (io_way),
    .io_enq_bits_set  (_io_set_output),
    .io_enq_bits_beat (_c_q_io_deq_valid ? beat : bs_adr_bits_beat_r),
    .io_deq_ready     (io_bs_adr_ready),
    .io_enq_ready     (_io_bs_adr_q_io_enq_ready),
    .io_deq_valid     (io_bs_adr_valid),
    .io_deq_bits_noop (io_bs_adr_bits_noop),
    .io_deq_bits_way  (io_bs_adr_bits_way),
    .io_deq_bits_set  (io_bs_adr_bits_set),
    .io_deq_bits_beat (io_bs_adr_bits_beat),
    .io_deq_bits_mask (io_bs_adr_bits_mask)
  );
  ListBuffer_1 putbuffer (
    .clock                     (clock),
    .reset                     (reset),
    .io_push_valid             (~resp & _c_q_io_deq_valid & _c_q_io_deq_bits_opcode[0] & ~req_block & ~set_block),
    .io_push_bits_index        (put[0]),
    .io_push_bits_data_data    (_c_q_io_deq_bits_data),
    .io_push_bits_data_corrupt (_c_q_io_deq_bits_corrupt),
    .io_pop_valid              (_putbuffer_io_pop_valid_T),
    .io_pop_bits               (io_rel_pop_bits_index[0]),
    .io_push_ready             (_putbuffer_io_push_ready),
    .io_valid                  (_putbuffer_io_valid),
    .io_data_data              (io_rel_beat_data),
    .io_data_corrupt           (io_rel_beat_corrupt)
  );
  assign io_req_valid = ~resp & _c_q_io_deq_valid & ~(|counter) & ~buf_block & ~set_block;
  assign io_req_bits_opcode = _c_q_io_deq_bits_opcode;
  assign io_req_bits_param = _c_q_io_deq_bits_param;
  assign io_req_bits_size = _c_q_io_deq_bits_size;
  assign io_req_bits_source = _c_q_io_deq_bits_source;
  assign io_req_bits_tag = _c_q_io_deq_bits_address[27:16];
  assign io_req_bits_offset = _c_q_io_deq_bits_address[5:0];
  assign io_req_bits_put = {4'h0, put};
  assign io_req_bits_set = _c_q_io_deq_bits_address[15:6];
  assign io_resp_valid = resp & _c_q_io_deq_valid & (~(|counter) | last) & (~(_c_q_io_deq_bits_opcode[0]) | _io_bs_adr_q_io_enq_ready);
  assign io_resp_bits_last = last;
  assign io_resp_bits_set = _c_q_io_deq_bits_address[15:6];
  assign io_resp_bits_tag = _c_q_io_deq_bits_address[27:16];
  assign io_resp_bits_source = _c_q_io_deq_bits_source;
  assign io_resp_bits_param = _c_q_io_deq_bits_param;
  assign io_resp_bits_data = _c_q_io_deq_bits_opcode[0];
  assign io_set = _io_set_output;
  assign io_bs_dat_data = io_bs_dat_data_r;
  assign io_rel_pop_ready = _io_rel_pop_ready_output;
endmodule

