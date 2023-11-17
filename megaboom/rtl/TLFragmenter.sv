// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLFragmenter(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
                auto_in_a_bits_size,
  input  [6:0]  auto_in_a_bits_source,
  input  [14:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input  [63:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
                auto_in_d_ready,
                auto_out_a_ready,
                auto_out_d_valid,
  input  [2:0]  auto_out_d_bits_opcode,
  input  [1:0]  auto_out_d_bits_size,
  input  [10:0] auto_out_d_bits_source,
  input  [63:0] auto_out_d_bits_data,
  output        auto_in_a_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
                auto_in_d_bits_size,
  output [6:0]  auto_in_d_bits_source,
  output [63:0] auto_in_d_bits_data,
  output        auto_out_a_valid,
  output [2:0]  auto_out_a_bits_opcode,
                auto_out_a_bits_param,
  output [1:0]  auto_out_a_bits_size,
  output [10:0] auto_out_a_bits_source,
  output [14:0] auto_out_a_bits_address,
  output [7:0]  auto_out_a_bits_mask,
  output [63:0] auto_out_a_bits_data,
  output        auto_out_a_bits_corrupt,
                auto_out_d_ready
);

  wire        _repeater_io_full;
  wire        _repeater_io_enq_ready;
  wire        _repeater_io_deq_valid;
  wire [2:0]  _repeater_io_deq_bits_opcode;
  wire [2:0]  _repeater_io_deq_bits_size;
  wire [6:0]  _repeater_io_deq_bits_source;
  wire [14:0] _repeater_io_deq_bits_address;
  wire [7:0]  _repeater_io_deq_bits_mask;
  reg  [2:0]  acknum;
  reg  [2:0]  dOrig;
  reg         dToggle;
  wire        dFirst = acknum == 3'h0;
  wire [5:0]  _dsizeOH1_T_1 = 6'h7 << auto_out_d_bits_size;
  wire [2:0]  _GEN = ~(auto_out_d_bits_source[2:0]);
  wire [2:0]  dFirst_size_hi = auto_out_d_bits_source[2:0] & {1'h1, _GEN[2:1]};
  wire [2:0]  _dFirst_size_T_8 = {1'h0, dFirst_size_hi[2:1]} | ~(_dsizeOH1_T_1[2:0]) & {_GEN[0], _dsizeOH1_T_1[2:1]};
  wire [2:0]  dFirst_size = {|dFirst_size_hi, |(_dFirst_size_T_8[2:1]), _dFirst_size_T_8[2] | _dFirst_size_T_8[0]};
  wire        drop = ~(auto_out_d_bits_opcode[0]) & (|(auto_out_d_bits_source[2:0]));
  wire        nodeOut_d_ready = auto_in_d_ready | drop;
  wire [2:0]  nodeIn_d_bits_size = dFirst ? dFirst_size : dOrig;
  wire        nodeIn_d_valid = auto_out_d_valid & ~drop;
  wire [12:0] _aOrigOH1_T_1 = 13'h3F << _repeater_io_deq_bits_size;
  reg  [2:0]  gennum;
  wire        aFirst = gennum == 3'h0;
  wire [2:0]  _old_gennum1_T_1 = gennum - 3'h1;
  wire [2:0]  aFragnum = aFirst ? ~(_aOrigOH1_T_1[5:3]) : _old_gennum1_T_1;
  reg         aToggle_r;
  wire        _GEN_0 = nodeOut_d_ready & auto_out_d_valid;
  wire        _GEN_1 = _GEN_0 & dFirst;
  always @(posedge clock) begin
    if (reset) begin
      acknum <= 3'h0;
      dToggle <= 1'h0;
      gennum <= 3'h0;
    end
    else begin
      if (_GEN_0) begin
        if (dFirst)
          acknum <= auto_out_d_bits_source[2:0];
        else
          acknum <= acknum - {2'h0, auto_out_d_bits_opcode[0] | (&auto_out_d_bits_size)};
      end
      if (_GEN_1)
        dToggle <= auto_out_d_bits_source[3];
      if (auto_out_a_ready & _repeater_io_deq_valid) begin
        if (aFirst)
          gennum <= ~(_aOrigOH1_T_1[5:3]);
        else
          gennum <= _old_gennum1_T_1;
      end
    end
    if (_GEN_1)
      dOrig <= dFirst_size;
    if (aFirst)
      aToggle_r <= dToggle;
  end // always @(posedge)
  Repeater_2 repeater (
    .clock               (clock),
    .reset               (reset),
    .io_repeat           (_repeater_io_deq_bits_opcode[2] & (|aFragnum)),
    .io_enq_valid        (auto_in_a_valid),
    .io_enq_bits_opcode  (auto_in_a_bits_opcode),
    .io_enq_bits_param   (auto_in_a_bits_param),
    .io_enq_bits_size    (auto_in_a_bits_size),
    .io_enq_bits_source  (auto_in_a_bits_source),
    .io_enq_bits_address (auto_in_a_bits_address),
    .io_enq_bits_mask    (auto_in_a_bits_mask),
    .io_enq_bits_corrupt (auto_in_a_bits_corrupt),
    .io_deq_ready        (auto_out_a_ready),
    .io_full             (_repeater_io_full),
    .io_enq_ready        (_repeater_io_enq_ready),
    .io_deq_valid        (_repeater_io_deq_valid),
    .io_deq_bits_opcode  (_repeater_io_deq_bits_opcode),
    .io_deq_bits_param   (auto_out_a_bits_param),
    .io_deq_bits_size    (_repeater_io_deq_bits_size),
    .io_deq_bits_source  (_repeater_io_deq_bits_source),
    .io_deq_bits_address (_repeater_io_deq_bits_address),
    .io_deq_bits_mask    (_repeater_io_deq_bits_mask),
    .io_deq_bits_corrupt (auto_out_a_bits_corrupt)
  );
  assign auto_in_a_ready = _repeater_io_enq_ready;
  assign auto_in_d_valid = nodeIn_d_valid;
  assign auto_in_d_bits_opcode = auto_out_d_bits_opcode;
  assign auto_in_d_bits_size = nodeIn_d_bits_size;
  assign auto_in_d_bits_source = auto_out_d_bits_source[10:4];
  assign auto_in_d_bits_data = auto_out_d_bits_data;
  assign auto_out_a_valid = _repeater_io_deq_valid;
  assign auto_out_a_bits_opcode = _repeater_io_deq_bits_opcode;
  assign auto_out_a_bits_size = _repeater_io_deq_bits_size[2] ? 2'h3 : _repeater_io_deq_bits_size[1:0];
  assign auto_out_a_bits_source = {_repeater_io_deq_bits_source, ~(aFirst ? dToggle : aToggle_r), aFragnum};
  assign auto_out_a_bits_address = {_repeater_io_deq_bits_address[14:6], _repeater_io_deq_bits_address[5:0] | {~(aFragnum | _aOrigOH1_T_1[5:3]), 3'h0}};
  assign auto_out_a_bits_mask = _repeater_io_full ? 8'hFF : auto_in_a_bits_mask;
  assign auto_out_a_bits_data = auto_in_a_bits_data;
  assign auto_out_d_ready = nodeOut_d_ready;
endmodule

