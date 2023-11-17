// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Directory(
  input         clock,
                reset,
                io_write_valid,
  input  [9:0]  io_write_bits_set,
  input  [2:0]  io_write_bits_way,
  input         io_write_bits_data_dirty,
  input  [1:0]  io_write_bits_data_state,
  input         io_write_bits_data_clients,
  input  [11:0] io_write_bits_data_tag,
  input         io_read_valid,
  input  [9:0]  io_read_bits_set,
  input  [11:0] io_read_bits_tag,
  output        io_write_ready,
                io_result_bits_dirty,
  output [1:0]  io_result_bits_state,
  output        io_result_bits_clients,
  output [11:0] io_result_bits_tag,
  output        io_result_bits_hit,
  output [2:0]  io_result_bits_way,
  output        io_ready
);

  wire        _GEN_27;
  wire        _GEN_26;
  wire        _GEN_25;
  wire        _GEN_24;
  wire        _GEN_23;
  wire        _GEN_22;
  wire        _GEN_21;
  wire        _GEN_20;
  wire [9:0]  writeAddr;
  wire        writeEnable;
  wire        _victimLFSR_prng_io_out_0;
  wire        _victimLFSR_prng_io_out_1;
  wire        _victimLFSR_prng_io_out_2;
  wire        _victimLFSR_prng_io_out_3;
  wire        _victimLFSR_prng_io_out_4;
  wire        _victimLFSR_prng_io_out_5;
  wire        _victimLFSR_prng_io_out_6;
  wire        _victimLFSR_prng_io_out_7;
  wire        _victimLFSR_prng_io_out_8;
  wire        _victimLFSR_prng_io_out_9;
  wire        _write_q_io_deq_valid;
  wire [9:0]  _write_q_io_deq_bits_set;
  wire [2:0]  _write_q_io_deq_bits_way;
  wire        _write_q_io_deq_bits_data_dirty;
  wire [1:0]  _write_q_io_deq_bits_data_state;
  wire        _write_q_io_deq_bits_data_clients;
  wire [11:0] _write_q_io_deq_bits_data_tag;
  wire [15:0] _cc_dir_7_ext_RW0_rdata;
  wire [15:0] _cc_dir_6_ext_RW0_rdata;
  wire [15:0] _cc_dir_5_ext_RW0_rdata;
  wire [15:0] _cc_dir_4_ext_RW0_rdata;
  wire [15:0] _cc_dir_3_ext_RW0_rdata;
  wire [15:0] _cc_dir_2_ext_RW0_rdata;
  wire [15:0] _cc_dir_1_ext_RW0_rdata;
  wire [15:0] _cc_dir_0_ext_RW0_rdata;
  wire [9:0]  _GEN = writeEnable ? writeAddr : io_read_bits_set;
  wire        _GEN_0 = io_read_valid | writeEnable;
  reg  [10:0] wipeCount;
  reg         wipeOff;
  assign writeEnable = ~io_read_valid & (~(wipeCount[10]) & ~wipeOff | _write_q_io_deq_valid);
  assign writeAddr = wipeCount[10] ? _write_q_io_deq_bits_set : wipeCount[9:0];
  wire [15:0] _GEN_1 = {_write_q_io_deq_bits_data_dirty, _write_q_io_deq_bits_data_state, _write_q_io_deq_bits_data_clients, _write_q_io_deq_bits_data_tag};
  assign _GEN_20 = _write_q_io_deq_bits_way == 3'h0 | ~(wipeCount[10]);
  assign _GEN_21 = _write_q_io_deq_bits_way == 3'h1 | ~(wipeCount[10]);
  assign _GEN_22 = _write_q_io_deq_bits_way == 3'h2 | ~(wipeCount[10]);
  assign _GEN_23 = _write_q_io_deq_bits_way == 3'h3 | ~(wipeCount[10]);
  assign _GEN_24 = _write_q_io_deq_bits_way == 3'h4 | ~(wipeCount[10]);
  assign _GEN_25 = _write_q_io_deq_bits_way == 3'h5 | ~(wipeCount[10]);
  assign _GEN_26 = _write_q_io_deq_bits_way == 3'h6 | ~(wipeCount[10]);
  assign _GEN_27 = (&_write_q_io_deq_bits_way) | ~(wipeCount[10]);
  reg  [11:0] tag;
  reg  [9:0]  set;
  wire [9:0]  victimLFSR = {_victimLFSR_prng_io_out_9, _victimLFSR_prng_io_out_8, _victimLFSR_prng_io_out_7, _victimLFSR_prng_io_out_6, _victimLFSR_prng_io_out_5, _victimLFSR_prng_io_out_4, _victimLFSR_prng_io_out_3, _victimLFSR_prng_io_out_2, _victimLFSR_prng_io_out_1, _victimLFSR_prng_io_out_0};
  wire [2:0]  _GEN_2 = {_victimLFSR_prng_io_out_9, _victimLFSR_prng_io_out_8, _victimLFSR_prng_io_out_7};
  wire [1:0]  _GEN_3 = {_victimLFSR_prng_io_out_9, _victimLFSR_prng_io_out_8};
  wire        _victimLTE_T_3 = victimLFSR > 10'h17F;
  wire        _victimLTE_T_5 = victimLFSR > 10'h27F;
  wire        _victimLTE_T_6 = victimLFSR > 10'h2FF;
  wire        _victimLTE_T_7 = victimLFSR > 10'h37F;
  wire [3:0]  victimWay_hi = {_victimLTE_T_7, _victimLTE_T_6, _victimLTE_T_5, _victimLFSR_prng_io_out_9} & {1'h1, ~_victimLTE_T_7, ~_victimLTE_T_6, ~_victimLTE_T_5};
  wire [2:0]  _victimWay_T_1 = victimWay_hi[3:1] | {_victimLTE_T_3, |_GEN_3, |_GEN_2} & {~_victimLFSR_prng_io_out_9, ~_victimLTE_T_3, ~(|_GEN_3)};
  wire [2:0]  victimWay = {|victimWay_hi, |(_victimWay_T_1[2:1]), _victimWay_T_1[2] | _victimWay_T_1[0]};
  wire        _view__T_71 = (|_GEN_2) & ~(|_GEN_3);
  wire        _view__T_72 = (|_GEN_3) & ~_victimLTE_T_3;
  wire        _view__T_73 = _victimLTE_T_3 & ~_victimLFSR_prng_io_out_9;
  wire        _view__T_74 = _victimLFSR_prng_io_out_9 & ~_victimLTE_T_5;
  wire        _view__T_75 = _victimLTE_T_5 & ~_victimLTE_T_6;
  wire        _view__T_76 = _victimLTE_T_6 & ~_victimLTE_T_7;
  wire        setQuash = _write_q_io_deq_valid & _write_q_io_deq_bits_set == set;
  wire        tagMatch = _write_q_io_deq_bits_data_tag == tag;
  wire        _hits_T_6 = _cc_dir_0_ext_RW0_rdata[11:0] == tag & (|(_cc_dir_0_ext_RW0_rdata[14:13])) & (~setQuash | (|_write_q_io_deq_bits_way));
  wire        _hits_T_13 = _cc_dir_1_ext_RW0_rdata[11:0] == tag & (|(_cc_dir_1_ext_RW0_rdata[14:13])) & (~setQuash | _write_q_io_deq_bits_way != 3'h1);
  wire        _hits_T_20 = _cc_dir_2_ext_RW0_rdata[11:0] == tag & (|(_cc_dir_2_ext_RW0_rdata[14:13])) & (~setQuash | _write_q_io_deq_bits_way != 3'h2);
  wire        _hits_T_27 = _cc_dir_3_ext_RW0_rdata[11:0] == tag & (|(_cc_dir_3_ext_RW0_rdata[14:13])) & (~setQuash | _write_q_io_deq_bits_way != 3'h3);
  wire        _hits_T_34 = _cc_dir_4_ext_RW0_rdata[11:0] == tag & (|(_cc_dir_4_ext_RW0_rdata[14:13])) & (~setQuash | _write_q_io_deq_bits_way != 3'h4);
  wire        _hits_T_41 = _cc_dir_5_ext_RW0_rdata[11:0] == tag & (|(_cc_dir_5_ext_RW0_rdata[14:13])) & (~setQuash | _write_q_io_deq_bits_way != 3'h5);
  wire        _hits_T_48 = _cc_dir_6_ext_RW0_rdata[11:0] == tag & (|(_cc_dir_6_ext_RW0_rdata[14:13])) & (~setQuash | _write_q_io_deq_bits_way != 3'h6);
  wire        _hits_T_55 = _cc_dir_7_ext_RW0_rdata[11:0] == tag & (|(_cc_dir_7_ext_RW0_rdata[14:13])) & (~setQuash | _write_q_io_deq_bits_way != 3'h7);
  wire [7:0]  hits = {_hits_T_55, _hits_T_48, _hits_T_41, _hits_T_34, _hits_T_27, _hits_T_20, _hits_T_13, _hits_T_6};
  wire        _view__T_69 = setQuash & (tagMatch | _write_q_io_deq_bits_way == victimWay);
  wire        _io_result_bits_way_T_7 = setQuash & tagMatch;
  wire [2:0]  _io_result_bits_way_T_1 = {_hits_T_55, _hits_T_48, _hits_T_41} | {_hits_T_27, _hits_T_20, _hits_T_13};
  always @(posedge clock) begin
    if (reset) begin
      wipeCount <= 11'h0;
      wipeOff <= 1'h1;
    end
    else begin
      if (wipeCount[10] | wipeOff) begin
      end
      else
        wipeCount <= wipeCount + 11'h1;
      wipeOff <= 1'h0;
    end
    if (io_read_valid) begin
      tag <= io_read_bits_tag;
      set <= io_read_bits_set;
    end
  end // always @(posedge)
  cc_dir_1024x16 cc_dir_0_ext (
    .RW0_addr  (_GEN),
    .RW0_en    (_GEN_0),
    .RW0_clk   (clock),
    .RW0_wmode (~io_read_valid & _GEN_20),
    .RW0_wdata (wipeCount[10] ? _GEN_1 : 16'h0),
    .RW0_rdata (_cc_dir_0_ext_RW0_rdata)
  );
  cc_dir_1024x16 cc_dir_1_ext (
    .RW0_addr  (_GEN),
    .RW0_en    (_GEN_0),
    .RW0_clk   (clock),
    .RW0_wmode (~io_read_valid & _GEN_21),
    .RW0_wdata (wipeCount[10] ? _GEN_1 : 16'h0),
    .RW0_rdata (_cc_dir_1_ext_RW0_rdata)
  );
  cc_dir_1024x16 cc_dir_2_ext (
    .RW0_addr  (_GEN),
    .RW0_en    (_GEN_0),
    .RW0_clk   (clock),
    .RW0_wmode (~io_read_valid & _GEN_22),
    .RW0_wdata (wipeCount[10] ? _GEN_1 : 16'h0),
    .RW0_rdata (_cc_dir_2_ext_RW0_rdata)
  );
  cc_dir_1024x16 cc_dir_3_ext (
    .RW0_addr  (_GEN),
    .RW0_en    (_GEN_0),
    .RW0_clk   (clock),
    .RW0_wmode (~io_read_valid & _GEN_23),
    .RW0_wdata (wipeCount[10] ? _GEN_1 : 16'h0),
    .RW0_rdata (_cc_dir_3_ext_RW0_rdata)
  );
  cc_dir_1024x16 cc_dir_4_ext (
    .RW0_addr  (_GEN),
    .RW0_en    (_GEN_0),
    .RW0_clk   (clock),
    .RW0_wmode (~io_read_valid & _GEN_24),
    .RW0_wdata (wipeCount[10] ? _GEN_1 : 16'h0),
    .RW0_rdata (_cc_dir_4_ext_RW0_rdata)
  );
  cc_dir_1024x16 cc_dir_5_ext (
    .RW0_addr  (_GEN),
    .RW0_en    (_GEN_0),
    .RW0_clk   (clock),
    .RW0_wmode (~io_read_valid & _GEN_25),
    .RW0_wdata (wipeCount[10] ? _GEN_1 : 16'h0),
    .RW0_rdata (_cc_dir_5_ext_RW0_rdata)
  );
  cc_dir_1024x16 cc_dir_6_ext (
    .RW0_addr  (_GEN),
    .RW0_en    (_GEN_0),
    .RW0_clk   (clock),
    .RW0_wmode (~io_read_valid & _GEN_26),
    .RW0_wdata (wipeCount[10] ? _GEN_1 : 16'h0),
    .RW0_rdata (_cc_dir_6_ext_RW0_rdata)
  );
  cc_dir_1024x16 cc_dir_7_ext (
    .RW0_addr  (_GEN),
    .RW0_en    (_GEN_0),
    .RW0_clk   (clock),
    .RW0_wmode (~io_read_valid & _GEN_27),
    .RW0_wdata (wipeCount[10] ? _GEN_1 : 16'h0),
    .RW0_rdata (_cc_dir_7_ext_RW0_rdata)
  );
  Queue_61 write_q (
    .clock                    (clock),
    .reset                    (reset),
    .io_enq_valid             (io_write_valid),
    .io_enq_bits_set          (io_write_bits_set),
    .io_enq_bits_way          (io_write_bits_way),
    .io_enq_bits_data_dirty   (io_write_bits_data_dirty),
    .io_enq_bits_data_state   (io_write_bits_data_state),
    .io_enq_bits_data_clients (io_write_bits_data_clients),
    .io_enq_bits_data_tag     (io_write_bits_data_tag),
    .io_deq_ready             (~io_read_valid),
    .io_enq_ready             (io_write_ready),
    .io_deq_valid             (_write_q_io_deq_valid),
    .io_deq_bits_set          (_write_q_io_deq_bits_set),
    .io_deq_bits_way          (_write_q_io_deq_bits_way),
    .io_deq_bits_data_dirty   (_write_q_io_deq_bits_data_dirty),
    .io_deq_bits_data_state   (_write_q_io_deq_bits_data_state),
    .io_deq_bits_data_clients (_write_q_io_deq_bits_data_clients),
    .io_deq_bits_data_tag     (_write_q_io_deq_bits_data_tag)
  );
  MaxPeriodFibonacciLFSR victimLFSR_prng (
    .clock        (clock),
    .reset        (reset),
    .io_increment (io_read_valid),
    .io_out_0     (_victimLFSR_prng_io_out_0),
    .io_out_1     (_victimLFSR_prng_io_out_1),
    .io_out_2     (_victimLFSR_prng_io_out_2),
    .io_out_3     (_victimLFSR_prng_io_out_3),
    .io_out_4     (_victimLFSR_prng_io_out_4),
    .io_out_5     (_victimLFSR_prng_io_out_5),
    .io_out_6     (_victimLFSR_prng_io_out_6),
    .io_out_7     (_victimLFSR_prng_io_out_7),
    .io_out_8     (_victimLFSR_prng_io_out_8),
    .io_out_9     (_victimLFSR_prng_io_out_9),
    .io_out_10    (/* unused */),
    .io_out_11    (/* unused */),
    .io_out_12    (/* unused */),
    .io_out_13    (/* unused */),
    .io_out_14    (/* unused */),
    .io_out_15    (/* unused */)
  );
  assign io_result_bits_dirty = (|hits) ? _hits_T_6 & _cc_dir_0_ext_RW0_rdata[15] | _hits_T_13 & _cc_dir_1_ext_RW0_rdata[15] | _hits_T_20 & _cc_dir_2_ext_RW0_rdata[15] | _hits_T_27 & _cc_dir_3_ext_RW0_rdata[15] | _hits_T_34 & _cc_dir_4_ext_RW0_rdata[15] | _hits_T_41 & _cc_dir_5_ext_RW0_rdata[15] | _hits_T_48 & _cc_dir_6_ext_RW0_rdata[15] | _hits_T_55 & _cc_dir_7_ext_RW0_rdata[15] : _view__T_69 ? _write_q_io_deq_bits_data_dirty : ~(|_GEN_2) & _cc_dir_0_ext_RW0_rdata[15] | _view__T_71 & _cc_dir_1_ext_RW0_rdata[15] | _view__T_72 & _cc_dir_2_ext_RW0_rdata[15] | _view__T_73 & _cc_dir_3_ext_RW0_rdata[15] | _view__T_74 & _cc_dir_4_ext_RW0_rdata[15] | _view__T_75 & _cc_dir_5_ext_RW0_rdata[15] | _view__T_76 & _cc_dir_6_ext_RW0_rdata[15] | _victimLTE_T_7 & _cc_dir_7_ext_RW0_rdata[15];
  assign io_result_bits_state = (|hits) ? (_hits_T_6 ? _cc_dir_0_ext_RW0_rdata[14:13] : 2'h0) | (_hits_T_13 ? _cc_dir_1_ext_RW0_rdata[14:13] : 2'h0) | (_hits_T_20 ? _cc_dir_2_ext_RW0_rdata[14:13] : 2'h0) | (_hits_T_27 ? _cc_dir_3_ext_RW0_rdata[14:13] : 2'h0) | (_hits_T_34 ? _cc_dir_4_ext_RW0_rdata[14:13] : 2'h0) | (_hits_T_41 ? _cc_dir_5_ext_RW0_rdata[14:13] : 2'h0) | (_hits_T_48 ? _cc_dir_6_ext_RW0_rdata[14:13] : 2'h0) | (_hits_T_55 ? _cc_dir_7_ext_RW0_rdata[14:13] : 2'h0) : _view__T_69 ? _write_q_io_deq_bits_data_state : ((|_GEN_2) ? 2'h0 : _cc_dir_0_ext_RW0_rdata[14:13]) | (_view__T_71 ? _cc_dir_1_ext_RW0_rdata[14:13] : 2'h0) | (_view__T_72 ? _cc_dir_2_ext_RW0_rdata[14:13] : 2'h0) | (_view__T_73 ? _cc_dir_3_ext_RW0_rdata[14:13] : 2'h0) | (_view__T_74 ? _cc_dir_4_ext_RW0_rdata[14:13] : 2'h0) | (_view__T_75 ? _cc_dir_5_ext_RW0_rdata[14:13] : 2'h0) | (_view__T_76 ? _cc_dir_6_ext_RW0_rdata[14:13] : 2'h0) | (_victimLTE_T_7 ? _cc_dir_7_ext_RW0_rdata[14:13] : 2'h0);
  assign io_result_bits_clients = (|hits) ? _hits_T_6 & _cc_dir_0_ext_RW0_rdata[12] | _hits_T_13 & _cc_dir_1_ext_RW0_rdata[12] | _hits_T_20 & _cc_dir_2_ext_RW0_rdata[12] | _hits_T_27 & _cc_dir_3_ext_RW0_rdata[12] | _hits_T_34 & _cc_dir_4_ext_RW0_rdata[12] | _hits_T_41 & _cc_dir_5_ext_RW0_rdata[12] | _hits_T_48 & _cc_dir_6_ext_RW0_rdata[12] | _hits_T_55 & _cc_dir_7_ext_RW0_rdata[12] : _view__T_69 ? _write_q_io_deq_bits_data_clients : ~(|_GEN_2) & _cc_dir_0_ext_RW0_rdata[12] | _view__T_71 & _cc_dir_1_ext_RW0_rdata[12] | _view__T_72 & _cc_dir_2_ext_RW0_rdata[12] | _view__T_73 & _cc_dir_3_ext_RW0_rdata[12] | _view__T_74 & _cc_dir_4_ext_RW0_rdata[12] | _view__T_75 & _cc_dir_5_ext_RW0_rdata[12] | _view__T_76 & _cc_dir_6_ext_RW0_rdata[12] | _victimLTE_T_7 & _cc_dir_7_ext_RW0_rdata[12];
  assign io_result_bits_tag = (|hits) ? (_hits_T_6 ? _cc_dir_0_ext_RW0_rdata[11:0] : 12'h0) | (_hits_T_13 ? _cc_dir_1_ext_RW0_rdata[11:0] : 12'h0) | (_hits_T_20 ? _cc_dir_2_ext_RW0_rdata[11:0] : 12'h0) | (_hits_T_27 ? _cc_dir_3_ext_RW0_rdata[11:0] : 12'h0) | (_hits_T_34 ? _cc_dir_4_ext_RW0_rdata[11:0] : 12'h0) | (_hits_T_41 ? _cc_dir_5_ext_RW0_rdata[11:0] : 12'h0) | (_hits_T_48 ? _cc_dir_6_ext_RW0_rdata[11:0] : 12'h0) | (_hits_T_55 ? _cc_dir_7_ext_RW0_rdata[11:0] : 12'h0) : _view__T_69 ? _write_q_io_deq_bits_data_tag : ((|_GEN_2) ? 12'h0 : _cc_dir_0_ext_RW0_rdata[11:0]) | (_view__T_71 ? _cc_dir_1_ext_RW0_rdata[11:0] : 12'h0) | (_view__T_72 ? _cc_dir_2_ext_RW0_rdata[11:0] : 12'h0) | (_view__T_73 ? _cc_dir_3_ext_RW0_rdata[11:0] : 12'h0) | (_view__T_74 ? _cc_dir_4_ext_RW0_rdata[11:0] : 12'h0) | (_view__T_75 ? _cc_dir_5_ext_RW0_rdata[11:0] : 12'h0) | (_view__T_76 ? _cc_dir_6_ext_RW0_rdata[11:0] : 12'h0) | (_victimLTE_T_7 ? _cc_dir_7_ext_RW0_rdata[11:0] : 12'h0);
  assign io_result_bits_hit = (|hits) | _io_result_bits_way_T_7 & (|_write_q_io_deq_bits_data_state);
  assign io_result_bits_way = (|hits) ? {|{_hits_T_55, _hits_T_48, _hits_T_41, _hits_T_34}, |(_io_result_bits_way_T_1[2:1]), _io_result_bits_way_T_1[2] | _io_result_bits_way_T_1[0]} : _io_result_bits_way_T_7 ? _write_q_io_deq_bits_way : victimWay;
  assign io_ready = wipeCount[10];
endmodule

