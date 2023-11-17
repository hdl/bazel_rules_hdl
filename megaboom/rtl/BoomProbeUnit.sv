// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BoomProbeUnit(
  input         clock,
                reset,
                io_req_valid,
  input  [1:0]  io_req_bits_param,
  input  [3:0]  io_req_bits_size,
                io_req_bits_source,
  input  [31:0] io_req_bits_address,
  input         io_rep_ready,
                io_meta_read_ready,
                io_meta_write_ready,
                io_wb_req_ready,
  input  [7:0]  io_way_en,
  input         io_wb_rdy,
                io_mshr_rdy,
  input  [1:0]  io_block_state_state,
  input         io_lsu_release_ready,
  output        io_req_ready,
                io_rep_valid,
  output [2:0]  io_rep_bits_param,
  output [3:0]  io_rep_bits_size,
                io_rep_bits_source,
  output [31:0] io_rep_bits_address,
  output        io_meta_read_valid,
  output [5:0]  io_meta_read_bits_idx,
  output [19:0] io_meta_read_bits_tag,
  output        io_meta_write_valid,
  output [5:0]  io_meta_write_bits_idx,
  output [7:0]  io_meta_write_bits_way_en,
  output [1:0]  io_meta_write_bits_data_coh_state,
  output [19:0] io_meta_write_bits_data_tag,
  output        io_wb_req_valid,
  output [19:0] io_wb_req_bits_tag,
  output [5:0]  io_wb_req_bits_idx,
  output [2:0]  io_wb_req_bits_param,
  output [7:0]  io_wb_req_bits_way_en,
  output        io_mshr_wb_rdy,
                io_lsu_release_valid,
  output [31:0] io_lsu_release_bits_address,
  output        io_state_valid,
  output [39:0] io_state_bits
);

  reg  [3:0]  casez_tmp;
  reg  [3:0]  state;
  reg  [1:0]  req_param;
  reg  [3:0]  req_size;
  reg  [3:0]  req_source;
  reg  [31:0] req_address;
  reg  [7:0]  way_en;
  reg  [1:0]  old_coh_state;
  wire [3:0]  _GEN = {req_param, (|way_en) ? old_coh_state : 2'h0};
  wire        _GEN_0 = _GEN == 4'hB;
  wire        _GEN_1 = _GEN == 4'h4;
  wire        _GEN_2 = _GEN == 4'h5;
  wire        _GEN_3 = _GEN == 4'h6;
  wire        _GEN_4 = _GEN == 4'h7;
  wire        _GEN_5 = _GEN == 4'h0;
  wire        _GEN_6 = _GEN == 4'h1;
  wire        _GEN_7 = _GEN == 4'h2;
  wire        _GEN_8 = _GEN == 4'h3;
  wire        _GEN_9 = _GEN_8 | _GEN_7;
  wire [2:0]  report_param = _GEN_9 ? 3'h3 : _GEN_6 ? 3'h4 : _GEN_5 ? 3'h5 : _GEN_4 | _GEN_3 ? 3'h0 : _GEN_2 ? 3'h4 : _GEN_1 ? 3'h5 : _GEN_0 | _GEN == 4'hA ? 3'h1 : _GEN == 4'h9 ? 3'h2 : _GEN == 4'h8 ? 3'h5 : 3'h0;
  wire        _io_req_ready_output = state == 4'h0;
  wire        _io_mshr_wb_rdy_T = state == 4'h6;
  wire        _io_meta_read_valid_output = state == 4'h1;
  wire        _io_meta_write_valid_output = state == 4'h9;
  wire        _io_wb_req_valid_output = state == 4'h7;
  wire        _io_lsu_release_valid_output = state == 4'h5;
  wire        _GEN_10 = _io_req_ready_output & io_req_valid;
  always @(*) begin
    casez (state)
      4'b0000:
        casez_tmp = _GEN_10 ? 4'h1 : state;
      4'b0001:
        casez_tmp = io_meta_read_ready & _io_meta_read_valid_output ? 4'h2 : state;
      4'b0010:
        casez_tmp = 4'h3;
      4'b0011:
        casez_tmp = io_mshr_rdy & io_wb_rdy ? 4'h4 : 4'h1;
      4'b0100:
        casez_tmp = {2'h1, (|way_en) & (_GEN_8 | ~(_GEN_7 | _GEN_6 | _GEN_5) & (_GEN_4 | ~(_GEN_3 | _GEN_2 | _GEN_1) & _GEN_0)), 1'h1};
      4'b0101:
        casez_tmp = io_lsu_release_ready & _io_lsu_release_valid_output ? 4'h6 : state;
      4'b0110:
        casez_tmp = io_rep_ready ? ((|way_en) ? 4'h9 : 4'h0) : state;
      4'b0111:
        casez_tmp = io_wb_req_ready & _io_wb_req_valid_output ? 4'h8 : state;
      4'b1000:
        casez_tmp = io_wb_req_ready ? 4'h9 : state;
      4'b1001:
        casez_tmp = io_meta_write_ready & _io_meta_write_valid_output ? 4'hA : state;
      4'b1010:
        casez_tmp = 4'h0;
      4'b1011:
        casez_tmp = state;
      4'b1100:
        casez_tmp = state;
      4'b1101:
        casez_tmp = state;
      4'b1110:
        casez_tmp = state;
      default:
        casez_tmp = state;
    endcase
  end // always @(*)
  always @(posedge clock) begin
    if (reset)
      state <= 4'h0;
    else
      state <= casez_tmp;
    if (_io_req_ready_output & _GEN_10) begin
      req_param <= io_req_bits_param;
      req_size <= io_req_bits_size;
      req_source <= io_req_bits_source;
      req_address <= io_req_bits_address;
    end
    if (_io_req_ready_output | _io_meta_read_valid_output | state == 4'h2 | state != 4'h3) begin
    end
    else begin
      way_en <= io_way_en;
      old_coh_state <= io_block_state_state;
    end
  end // always @(posedge)
  assign io_req_ready = _io_req_ready_output;
  assign io_rep_valid = _io_mshr_wb_rdy_T;
  assign io_rep_bits_param = report_param;
  assign io_rep_bits_size = req_size;
  assign io_rep_bits_source = req_source;
  assign io_rep_bits_address = req_address;
  assign io_meta_read_valid = _io_meta_read_valid_output;
  assign io_meta_read_bits_idx = req_address[11:6];
  assign io_meta_read_bits_tag = req_address[31:12];
  assign io_meta_write_valid = _io_meta_write_valid_output;
  assign io_meta_write_bits_idx = req_address[11:6];
  assign io_meta_write_bits_way_en = way_en;
  assign io_meta_write_bits_data_coh_state = _GEN_9 ? 2'h2 : _GEN_6 ? 2'h1 : _GEN_5 ? 2'h0 : {1'h0, _GEN_4 | _GEN_3 | _GEN_2};
  assign io_meta_write_bits_data_tag = req_address[31:12];
  assign io_wb_req_valid = _io_wb_req_valid_output;
  assign io_wb_req_bits_tag = req_address[31:12];
  assign io_wb_req_bits_idx = req_address[11:6];
  assign io_wb_req_bits_param = report_param;
  assign io_wb_req_bits_way_en = way_en;
  assign io_mshr_wb_rdy = ~(_io_mshr_wb_rdy_T | _io_wb_req_valid_output | state == 4'h8 | _io_meta_write_valid_output | state == 4'hA);
  assign io_lsu_release_valid = _io_lsu_release_valid_output;
  assign io_lsu_release_bits_address = req_address;
  assign io_state_valid = |state;
  assign io_state_bits = {8'h0, req_address};
endmodule

