// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module MSHR(
  input         clock,
                reset,
                io_allocate_valid,
                io_allocate_bits_prio_0,
                io_allocate_bits_prio_1,
                io_allocate_bits_prio_2,
                io_allocate_bits_control,
  input  [2:0]  io_allocate_bits_opcode,
                io_allocate_bits_param,
                io_allocate_bits_size,
  input  [5:0]  io_allocate_bits_source,
  input  [11:0] io_allocate_bits_tag,
  input  [5:0]  io_allocate_bits_offset,
                io_allocate_bits_put,
  input  [9:0]  io_allocate_bits_set,
  input         io_allocate_bits_repeat,
                io_directory_valid,
                io_directory_bits_dirty,
  input  [1:0]  io_directory_bits_state,
  input         io_directory_bits_clients,
  input  [11:0] io_directory_bits_tag,
  input         io_directory_bits_hit,
  input  [2:0]  io_directory_bits_way,
  input         io_schedule_ready,
                io_sinkc_valid,
                io_sinkc_bits_last,
  input  [11:0] io_sinkc_bits_tag,
  input  [5:0]  io_sinkc_bits_source,
  input  [2:0]  io_sinkc_bits_param,
  input         io_sinkc_bits_data,
                io_sinkd_valid,
                io_sinkd_bits_last,
  input  [2:0]  io_sinkd_bits_opcode,
                io_sinkd_bits_param,
                io_sinkd_bits_sink,
  input         io_sinkd_bits_denied,
                io_sinke_valid,
  input  [9:0]  io_nestedwb_set,
  input  [11:0] io_nestedwb_tag,
  input         io_nestedwb_b_toN,
                io_nestedwb_b_toB,
                io_nestedwb_b_clr_dirty,
                io_nestedwb_c_set_dirty,
  output        io_status_valid,
  output [9:0]  io_status_bits_set,
  output [11:0] io_status_bits_tag,
  output [2:0]  io_status_bits_way,
  output        io_status_bits_blockC,
                io_status_bits_nestC,
                io_schedule_valid,
                io_schedule_bits_a_valid,
  output [11:0] io_schedule_bits_a_bits_tag,
  output [9:0]  io_schedule_bits_a_bits_set,
  output [2:0]  io_schedule_bits_a_bits_param,
  output        io_schedule_bits_a_bits_block,
                io_schedule_bits_b_valid,
  output [2:0]  io_schedule_bits_b_bits_param,
  output [11:0] io_schedule_bits_b_bits_tag,
  output [9:0]  io_schedule_bits_b_bits_set,
  output        io_schedule_bits_b_bits_clients,
                io_schedule_bits_c_valid,
  output [2:0]  io_schedule_bits_c_bits_opcode,
                io_schedule_bits_c_bits_param,
  output [11:0] io_schedule_bits_c_bits_tag,
  output [9:0]  io_schedule_bits_c_bits_set,
  output [2:0]  io_schedule_bits_c_bits_way,
  output        io_schedule_bits_c_bits_dirty,
                io_schedule_bits_d_valid,
                io_schedule_bits_d_bits_prio_0,
                io_schedule_bits_d_bits_prio_2,
  output [2:0]  io_schedule_bits_d_bits_opcode,
                io_schedule_bits_d_bits_param,
                io_schedule_bits_d_bits_size,
  output [5:0]  io_schedule_bits_d_bits_source,
                io_schedule_bits_d_bits_offset,
                io_schedule_bits_d_bits_put,
  output [9:0]  io_schedule_bits_d_bits_set,
  output [2:0]  io_schedule_bits_d_bits_way,
  output        io_schedule_bits_d_bits_bad,
                io_schedule_bits_e_valid,
  output [2:0]  io_schedule_bits_e_bits_sink,
  output        io_schedule_bits_x_valid,
                io_schedule_bits_dir_valid,
  output [9:0]  io_schedule_bits_dir_bits_set,
  output [2:0]  io_schedule_bits_dir_bits_way,
  output        io_schedule_bits_dir_bits_data_dirty,
  output [1:0]  io_schedule_bits_dir_bits_data_state,
  output        io_schedule_bits_dir_bits_data_clients,
  output [11:0] io_schedule_bits_dir_bits_data_tag,
  output        io_schedule_bits_reload
);

  reg         request_valid;
  reg         request_prio_0;
  reg         request_prio_1;
  reg         request_prio_2;
  reg         request_control;
  reg  [2:0]  request_opcode;
  reg  [2:0]  request_param;
  reg  [2:0]  request_size;
  reg  [5:0]  request_source;
  reg  [11:0] request_tag;
  reg  [5:0]  request_offset;
  reg  [5:0]  request_put;
  reg  [9:0]  request_set;
  reg         meta_valid;
  reg         meta_dirty;
  reg  [1:0]  meta_state;
  reg         evict_c;
  reg  [11:0] meta_tag;
  reg         meta_hit;
  reg  [2:0]  meta_way;
  wire        _io_schedule_bits_c_bits_param_T = meta_state == 2'h1;
  wire        _final_meta_writeback_state_T_1 = meta_state == 2'h2;
  reg         s_rprobe;
  reg         w_rprobeackfirst;
  reg         w_rprobeacklast;
  reg         s_release;
  reg         w_releaseack;
  reg         s_pprobe;
  reg         s_acquire;
  reg         s_flush;
  reg         w_grantfirst;
  reg         w_grantlast;
  reg         w_grant;
  reg         w_pprobeackfirst;
  reg         w_pprobeacklast;
  reg         w_pprobeack;
  reg         s_grantack;
  reg         s_execute;
  reg         w_grantack;
  reg         s_writeback;
  reg  [2:0]  sink;
  reg         gotT;
  reg         bad_grant;
  reg         probes_done;
  reg         probes_toN;
  wire        _io_status_bits_nestC_output = meta_valid & (~w_rprobeackfirst | ~w_pprobeackfirst | ~w_grantfirst);
  wire        no_wait = w_rprobeacklast & w_releaseack & w_grantlast & w_pprobeacklast & w_grantack;
  wire        _io_schedule_bits_a_valid_output = ~s_acquire & s_release & s_pprobe;
  wire        _io_schedule_bits_b_valid_output = ~s_rprobe | ~s_pprobe;
  wire        _io_schedule_bits_c_valid_output = ~s_release & w_rprobeackfirst;
  wire        _io_schedule_bits_d_valid_output = ~s_execute & w_pprobeack & w_grant;
  wire        _io_schedule_bits_e_valid_output = ~s_grantack & w_grantfirst;
  wire        _io_schedule_bits_x_valid_output = ~s_flush & w_releaseack;
  wire        _io_schedule_bits_dir_valid_output = ~s_release & w_rprobeackfirst | ~s_writeback & no_wait;
  wire        _io_schedule_valid_output = _io_schedule_bits_a_valid_output | _io_schedule_bits_b_valid_output | _io_schedule_bits_c_valid_output | _io_schedule_bits_d_valid_output | _io_schedule_bits_e_valid_output | _io_schedule_bits_x_valid_output | _io_schedule_bits_dir_valid_output;
  wire        req_clientBit = request_source[5:4] == 2'h0 & request_source[3:0] < 4'h9;
  wire        _excluded_client_T_1 = request_opcode == 3'h6;
  wire        req_needT = ~(request_opcode[2]) | request_opcode == 3'h5 & request_param == 3'h1 | (_excluded_client_T_1 | (&request_opcode)) & (|request_param);
  wire        req_acquire = _excluded_client_T_1 | (&request_opcode);
  wire        _final_meta_writeback_state_T_2 = request_param != 3'h3 & _final_meta_writeback_state_T_1;
  wire        _final_meta_writeback_clients_T_7 = evict_c & ~((request_param == 3'h1 | request_param == 3'h2 | request_param == 3'h5) & req_clientBit);
  wire        _GEN_29 = (~meta_hit | ~probes_toN) & evict_c;
  wire [1:0]  _final_meta_writeback_state_T_6 = {1'h1, ~req_acquire};
  wire [1:0]  _final_meta_writeback_state_T_9 = {1'h1, ~(~evict_c & req_acquire)};
  wire [1:0]  _final_meta_writeback_state_T_13 = {meta_state == 2'h2, 1'h1};
  wire        _final_meta_writeback_clients_T_14 = meta_hit & evict_c & ~probes_toN | req_acquire & req_clientBit;
  wire        _GEN_35 = request_prio_2 ? meta_dirty | request_opcode[0] : request_control ? ~meta_hit & meta_dirty : meta_hit & meta_dirty | ~(request_opcode[2]);
  wire        _GEN_38 = request_prio_2 | ~request_control;
  wire        _GEN = request_prio_2 | request_control;
  wire [1:0]  _GEN_42 = {1'h0, meta_hit};
  wire        _GEN_43 = meta_hit & evict_c & ~probes_toN;
  wire        final_meta_writeback_dirty = ~bad_grant & _GEN_35;
  wire [1:0]  final_meta_writeback_state = bad_grant ? _GEN_42 : request_prio_2 ? (_final_meta_writeback_state_T_2 ? 2'h3 : meta_state) : request_control ? (meta_hit ? 2'h0 : meta_state) : req_needT ? _final_meta_writeback_state_T_6 : meta_hit ? ((&meta_state) ? _final_meta_writeback_state_T_9 : _final_meta_writeback_state_T_13) : gotT ? _final_meta_writeback_state_T_6 : 2'h1;
  wire        after_c = bad_grant ? _GEN_43 : request_prio_2 ? _final_meta_writeback_clients_T_7 : request_control ? _GEN_29 : _final_meta_writeback_clients_T_14;
  wire        excluded_client = meta_hit & request_prio_0 & (_excluded_client_T_1 | (&request_opcode) | request_opcode == 3'h4) & req_clientBit;
  wire        _new_meta_T = io_allocate_valid & io_allocate_bits_repeat;
  wire        new_meta_hit = _new_meta_T ? (bad_grant ? meta_hit : _GEN_38) : io_directory_bits_hit;
  wire        new_request_prio_2 = io_allocate_valid ? io_allocate_bits_prio_2 : request_prio_2;
  wire        _GEN_0 = io_directory_valid | _new_meta_T;
  wire        new_meta_dirty = _new_meta_T ? final_meta_writeback_dirty : io_directory_bits_dirty;
  wire [1:0]  new_meta_state = _new_meta_T ? final_meta_writeback_state : io_directory_bits_state;
  wire        new_meta_clients = _new_meta_T ? after_c : io_directory_bits_clients;
  wire        new_request_control = io_allocate_valid ? io_allocate_bits_control : request_control;
  wire [2:0]  new_request_opcode = io_allocate_valid ? io_allocate_bits_opcode : request_opcode;
  wire [2:0]  new_request_param = io_allocate_valid ? io_allocate_bits_param : request_param;
  wire [5:0]  new_request_source = io_allocate_valid ? io_allocate_bits_source : request_source;
  wire        _new_skipProbe_T = new_request_opcode == 3'h6;
  wire        new_needT = ~(new_request_opcode[2]) | new_request_opcode == 3'h5 & new_request_param == 3'h1 | (_new_skipProbe_T | (&new_request_opcode)) & (|new_request_param);
  wire        new_clientBit = new_request_source[5:4] == 2'h0 & new_request_source[3:0] < 4'h9;
  wire        _GEN_1 = new_meta_state == 2'h2;
  wire        _GEN_2 = ~new_meta_hit & (|new_meta_state);
  wire        _GEN_3 = ~new_meta_hit | new_meta_state == 2'h1 & new_needT;
  wire        _GEN_4 = new_meta_hit & (new_needT | _GEN_1) & new_meta_clients & ~((_new_skipProbe_T | (&new_request_opcode) | new_request_opcode == 3'h4) & new_clientBit);
  wire        _GEN_5 = _new_skipProbe_T | (&new_request_opcode);
  wire        _GEN_133 = new_request_prio_2 | (new_request_control ? ~new_meta_hit : ~_GEN_2);
  wire        _GEN_134 = new_request_prio_2 | (new_request_control ? ~new_meta_hit | ~new_meta_clients : ~_GEN_2 | ~new_meta_clients);
  wire        _GEN_6 = new_request_prio_2 | new_request_control;
  wire        _GEN_135 = _GEN_6 | ~_GEN_3;
  wire        _GEN_136 = _GEN_6 | ~_GEN_4;
  wire        _w_grant_T = request_offset == 6'h0;
  wire        _GEN_7 = io_schedule_ready & no_wait;
  wire        _GEN_8 = meta_valid & (|meta_state) & io_nestedwb_set == request_set & io_nestedwb_tag == meta_tag;
  wire        probe_bit = io_sinkc_bits_source[5:4] == 2'h0 & io_sinkc_bits_source[3:0] < 4'h9;
  wire        _GEN_9 = io_sinkd_bits_opcode == 3'h4 | io_sinkd_bits_opcode == 3'h5;
  wire        _GEN_10 = io_sinkd_valid & _GEN_9;
  wire        last_probe = (probes_done | probe_bit) == (evict_c & ~excluded_client);
  wire        _GEN_11 = io_sinkc_valid & last_probe;
  wire        _GEN_12 = io_sinkc_valid & last_probe & io_sinkc_bits_last;
  always @(posedge clock) begin
    if (reset) begin
      request_valid <= 1'h0;
      meta_valid <= 1'h0;
      s_rprobe <= 1'h1;
      w_rprobeackfirst <= 1'h1;
      w_rprobeacklast <= 1'h1;
      s_release <= 1'h1;
      w_releaseack <= 1'h1;
      s_pprobe <= 1'h1;
      s_acquire <= 1'h1;
      s_flush <= 1'h1;
      w_grantfirst <= 1'h1;
      w_grantlast <= 1'h1;
      w_grant <= 1'h1;
      w_pprobeackfirst <= 1'h1;
      w_pprobeacklast <= 1'h1;
      w_pprobeack <= 1'h1;
      s_grantack <= 1'h1;
      s_execute <= 1'h1;
      w_grantack <= 1'h1;
      s_writeback <= 1'h1;
    end
    else begin
      request_valid <= io_allocate_valid | ~_GEN_7 & request_valid;
      meta_valid <= _GEN_0 | ~_GEN_7 & meta_valid;
      if (_GEN_0) begin
        s_rprobe <= _GEN_134;
        w_rprobeackfirst <= _GEN_134;
        w_rprobeacklast <= _GEN_134;
        s_release <= _GEN_133;
        w_releaseack <= _GEN_133;
        s_pprobe <= _GEN_136;
        s_acquire <= _GEN_135;
        s_flush <= new_request_prio_2 | ~new_request_control;
        w_grantfirst <= _GEN_135;
        w_grantlast <= _GEN_135;
        w_grant <= _GEN_135;
        w_pprobeackfirst <= _GEN_136;
        w_pprobeacklast <= _GEN_136;
        w_pprobeack <= _GEN_136;
        s_grantack <= _GEN_135;
        s_execute <= ~new_request_prio_2 & new_request_control;
        w_grantack <= _GEN_6 | ~_GEN_5;
        if (new_request_prio_2)
          s_writeback <= ~((new_request_param == 3'h1 | new_request_param == 3'h2 | new_request_param == 3'h5) & new_meta_clients & new_clientBit | (new_request_param == 3'h0 | new_request_param == 3'h4) & _GEN_1) & ~(new_request_opcode[0] & ~new_meta_dirty);
        else
          s_writeback <= new_request_control | ~(~(new_request_opcode[2]) & new_meta_hit & ~new_meta_dirty | _GEN_5 | _GEN_4) & ~_GEN_3;
      end
      else begin
        s_rprobe <= io_schedule_ready | s_rprobe;
        w_rprobeackfirst <= _GEN_11 | w_rprobeackfirst;
        w_rprobeacklast <= _GEN_12 | w_rprobeacklast;
        s_release <= io_schedule_ready & w_rprobeackfirst | s_release;
        w_releaseack <= io_sinkd_valid & ~_GEN_9 & io_sinkd_bits_opcode == 3'h6 | w_releaseack;
        s_pprobe <= io_schedule_ready | s_pprobe;
        s_acquire <= io_schedule_ready & s_release & s_pprobe | s_acquire;
        s_flush <= io_schedule_ready & w_releaseack | s_flush;
        w_grantfirst <= _GEN_10 | w_grantfirst;
        if (_GEN_10) begin
          w_grantlast <= io_sinkd_bits_last;
          w_grant <= _w_grant_T | io_sinkd_bits_last;
        end
        w_pprobeackfirst <= _GEN_11 | w_pprobeackfirst;
        w_pprobeacklast <= _GEN_12 | w_pprobeacklast;
        w_pprobeack <= io_sinkc_valid & last_probe & (io_sinkc_bits_last | _w_grant_T) | w_pprobeack;
        s_grantack <= io_schedule_ready & w_grantfirst | s_grantack;
        s_execute <= io_schedule_ready & w_pprobeack & w_grant | s_execute;
        w_grantack <= io_sinke_valid | w_grantack;
        s_writeback <= _GEN_7 | s_writeback;
      end
    end
    if (io_allocate_valid) begin
      request_prio_0 <= io_allocate_bits_prio_0;
      request_prio_1 <= io_allocate_bits_prio_1;
      request_prio_2 <= io_allocate_bits_prio_2;
      request_control <= io_allocate_bits_control;
      request_opcode <= io_allocate_bits_opcode;
      request_param <= io_allocate_bits_param;
      request_size <= io_allocate_bits_size;
      request_source <= io_allocate_bits_source;
      request_tag <= io_allocate_bits_tag;
      request_offset <= io_allocate_bits_offset;
      request_put <= io_allocate_bits_put;
      request_set <= io_allocate_bits_set;
    end
    if (_GEN_0) begin
      if (_new_meta_T) begin
        meta_dirty <= final_meta_writeback_dirty;
        if (bad_grant) begin
          meta_state <= _GEN_42;
          evict_c <= _GEN_43;
        end
        else begin
          if (request_prio_2) begin
            if (_final_meta_writeback_state_T_2)
              meta_state <= 2'h3;
            evict_c <= _final_meta_writeback_clients_T_7;
          end
          else if (request_control) begin
            if (meta_hit)
              meta_state <= 2'h0;
            evict_c <= _GEN_29;
          end
          else begin
            if (req_needT)
              meta_state <= _final_meta_writeback_state_T_6;
            else if (meta_hit) begin
              if (&meta_state)
                meta_state <= _final_meta_writeback_state_T_9;
              else
                meta_state <= _final_meta_writeback_state_T_13;
            end
            else if (gotT)
              meta_state <= _final_meta_writeback_state_T_6;
            else
              meta_state <= 2'h1;
            evict_c <= _final_meta_writeback_clients_T_14;
          end
          meta_hit <= _GEN_38;
        end
        if (~_GEN)
          meta_tag <= request_tag;
      end
      else begin
        meta_dirty <= io_directory_bits_dirty;
        meta_state <= io_directory_bits_state;
        evict_c <= io_directory_bits_clients;
        meta_tag <= io_directory_bits_tag;
        meta_hit <= io_directory_bits_hit;
      end
    end
    else begin
      meta_dirty <= io_sinkc_valid & (|meta_state) & io_sinkc_bits_tag == meta_tag & io_sinkc_bits_data | (_GEN_8 ? io_nestedwb_c_set_dirty | ~io_nestedwb_b_clr_dirty & meta_dirty : meta_dirty);
      if (_GEN_8 & io_nestedwb_b_toB)
        meta_state <= 2'h1;
      meta_hit <= ~(_GEN_8 & io_nestedwb_b_toN) & meta_hit;
    end
    if (~_GEN_0 | _new_meta_T) begin
    end
    else
      meta_way <= io_directory_bits_way;
    if (_GEN_10)
      sink <= io_sinkd_bits_sink;
    gotT <= ~_GEN_0 & (_GEN_10 ? io_sinkd_bits_param == 3'h0 : gotT);
    bad_grant <= ~_GEN_0 & (_GEN_10 ? io_sinkd_bits_denied : bad_grant);
    probes_done <= ~_GEN_0 & (io_sinkc_valid & probe_bit | probes_done);
    probes_toN <= ~_GEN_0 & (io_sinkc_valid & (io_sinkc_bits_param == 3'h1 | io_sinkc_bits_param == 3'h2 | io_sinkc_bits_param == 3'h5) & probe_bit | probes_toN);
  end // always @(posedge)
  assign io_status_valid = request_valid;
  assign io_status_bits_set = request_set;
  assign io_status_bits_tag = request_tag;
  assign io_status_bits_way = meta_way;
  assign io_status_bits_blockC = ~meta_valid;
  assign io_status_bits_nestC = _io_status_bits_nestC_output;
  assign io_schedule_valid = _io_schedule_valid_output;
  assign io_schedule_bits_a_valid = _io_schedule_bits_a_valid_output;
  assign io_schedule_bits_a_bits_tag = request_tag;
  assign io_schedule_bits_a_bits_set = request_set;
  assign io_schedule_bits_a_bits_param = {1'h0, req_needT ? (meta_hit ? 2'h2 : 2'h1) : 2'h0};
  assign io_schedule_bits_a_bits_block = request_size != 3'h6 | ~(request_opcode == 3'h0 | (&request_opcode));
  assign io_schedule_bits_b_valid = _io_schedule_bits_b_valid_output;
  assign io_schedule_bits_b_bits_param = s_rprobe ? (request_prio_1 ? request_param : {1'h0, req_needT ? 2'h2 : 2'h1}) : 3'h2;
  assign io_schedule_bits_b_bits_tag = s_rprobe ? request_tag : meta_tag;
  assign io_schedule_bits_b_bits_set = request_set;
  assign io_schedule_bits_b_bits_clients = evict_c & ~excluded_client;
  assign io_schedule_bits_c_valid = _io_schedule_bits_c_valid_output;
  assign io_schedule_bits_c_bits_opcode = {2'h3, meta_dirty};
  assign io_schedule_bits_c_bits_param = _io_schedule_bits_c_bits_param_T ? 3'h2 : 3'h1;
  assign io_schedule_bits_c_bits_tag = meta_tag;
  assign io_schedule_bits_c_bits_set = request_set;
  assign io_schedule_bits_c_bits_way = meta_way;
  assign io_schedule_bits_c_bits_dirty = meta_dirty;
  assign io_schedule_bits_d_valid = _io_schedule_bits_d_valid_output;
  assign io_schedule_bits_d_bits_prio_0 = request_prio_0;
  assign io_schedule_bits_d_bits_prio_2 = request_prio_2;
  assign io_schedule_bits_d_bits_opcode = request_opcode;
  assign io_schedule_bits_d_bits_param = req_acquire ? (request_param == 3'h1 ? 3'h1 : request_param == 3'h2 ? {1'h0, meta_hit & evict_c & req_clientBit ? 2'h2 : 2'h1} : request_param == 3'h0 ? {2'h0, req_acquire & (meta_hit ? ~evict_c & (&meta_state) : gotT)} : request_param) : request_param;
  assign io_schedule_bits_d_bits_size = request_size;
  assign io_schedule_bits_d_bits_source = request_source;
  assign io_schedule_bits_d_bits_offset = request_offset;
  assign io_schedule_bits_d_bits_put = request_put;
  assign io_schedule_bits_d_bits_set = request_set;
  assign io_schedule_bits_d_bits_way = meta_way;
  assign io_schedule_bits_d_bits_bad = bad_grant;
  assign io_schedule_bits_e_valid = _io_schedule_bits_e_valid_output;
  assign io_schedule_bits_e_bits_sink = sink;
  assign io_schedule_bits_x_valid = _io_schedule_bits_x_valid_output;
  assign io_schedule_bits_dir_valid = _io_schedule_bits_dir_valid_output;
  assign io_schedule_bits_dir_bits_set = request_set;
  assign io_schedule_bits_dir_bits_way = meta_way;
  assign io_schedule_bits_dir_bits_data_dirty = ~(~s_release | bad_grant) & _GEN_35;
  assign io_schedule_bits_dir_bits_data_state = s_release ? final_meta_writeback_state : 2'h0;
  assign io_schedule_bits_dir_bits_data_clients = s_release & after_c;
  assign io_schedule_bits_dir_bits_data_tag = s_release ? (_GEN ? meta_tag : request_tag) : 12'h0;
  assign io_schedule_bits_reload = no_wait;
endmodule

