// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module L1MetadataArray(
  input         clock,
                reset,
                io_read_valid,
  input  [5:0]  io_read_bits_idx,
  input         io_write_valid,
  input  [5:0]  io_write_bits_idx,
  input  [7:0]  io_write_bits_way_en,
  input  [1:0]  io_write_bits_data_coh_state,
  input  [19:0] io_write_bits_data_tag,
  output        io_read_ready,
                io_write_ready,
  output [1:0]  io_resp_0_coh_state,
  output [19:0] io_resp_0_tag,
  output [1:0]  io_resp_1_coh_state,
  output [19:0] io_resp_1_tag,
  output [1:0]  io_resp_2_coh_state,
  output [19:0] io_resp_2_tag,
  output [1:0]  io_resp_3_coh_state,
  output [19:0] io_resp_3_tag,
  output [1:0]  io_resp_4_coh_state,
  output [19:0] io_resp_4_tag,
  output [1:0]  io_resp_5_coh_state,
  output [19:0] io_resp_5_tag,
  output [1:0]  io_resp_6_coh_state,
  output [19:0] io_resp_6_tag,
  output [1:0]  io_resp_7_coh_state,
  output [19:0] io_resp_7_tag
);

  wire        wen;
  wire        wmask_7;
  wire        wmask_6;
  wire        wmask_5;
  wire        wmask_4;
  wire        wmask_3;
  wire        wmask_2;
  wire        wmask_1;
  wire        wmask_0;
  wire [21:0] _tag_array_7_ext_R0_data;
  wire [21:0] _tag_array_6_ext_R0_data;
  wire [21:0] _tag_array_5_ext_R0_data;
  wire [21:0] _tag_array_4_ext_R0_data;
  wire [21:0] _tag_array_3_ext_R0_data;
  wire [21:0] _tag_array_2_ext_R0_data;
  wire [21:0] _tag_array_1_ext_R0_data;
  wire [21:0] _tag_array_0_ext_R0_data;
  reg  [6:0]  rst_cnt;
  wire [5:0]  waddr = rst_cnt[6] ? io_write_bits_idx : rst_cnt[5:0];
  wire [21:0] wdata = {rst_cnt[6] ? io_write_bits_data_coh_state : 2'h0, rst_cnt[6] ? io_write_bits_data_tag : 20'h0};
  wire [7:0]  _wmask_T_2 = rst_cnt[6] ? io_write_bits_way_en : 8'hFF;
  assign wmask_0 = _wmask_T_2[0];
  assign wmask_1 = _wmask_T_2[1];
  assign wmask_2 = _wmask_T_2[2];
  assign wmask_3 = _wmask_T_2[3];
  assign wmask_4 = _wmask_T_2[4];
  assign wmask_5 = _wmask_T_2[5];
  assign wmask_6 = _wmask_T_2[6];
  assign wmask_7 = _wmask_T_2[7];
  assign wen = ~(rst_cnt[6]) | io_write_valid;
  wire        _GEN_37 = ~wen & io_read_valid;
  always @(posedge clock) begin
    if (reset)
      rst_cnt <= 7'h0;
    else if (rst_cnt[6]) begin
    end
    else
      rst_cnt <= rst_cnt + 7'h1;
  end // always @(posedge)
  tag_array_64x22 tag_array_0_ext (
    .R0_addr (io_read_bits_idx),
    .R0_en   (_GEN_37),
    .R0_clk  (clock),
    .W0_addr (waddr),
    .W0_en   (wen & wmask_0),
    .W0_clk  (clock),
    .W0_data (wdata),
    .R0_data (_tag_array_0_ext_R0_data)
  );
  tag_array_64x22 tag_array_1_ext (
    .R0_addr (io_read_bits_idx),
    .R0_en   (_GEN_37),
    .R0_clk  (clock),
    .W0_addr (waddr),
    .W0_en   (wen & wmask_1),
    .W0_clk  (clock),
    .W0_data (wdata),
    .R0_data (_tag_array_1_ext_R0_data)
  );
  tag_array_64x22 tag_array_2_ext (
    .R0_addr (io_read_bits_idx),
    .R0_en   (_GEN_37),
    .R0_clk  (clock),
    .W0_addr (waddr),
    .W0_en   (wen & wmask_2),
    .W0_clk  (clock),
    .W0_data (wdata),
    .R0_data (_tag_array_2_ext_R0_data)
  );
  tag_array_64x22 tag_array_3_ext (
    .R0_addr (io_read_bits_idx),
    .R0_en   (_GEN_37),
    .R0_clk  (clock),
    .W0_addr (waddr),
    .W0_en   (wen & wmask_3),
    .W0_clk  (clock),
    .W0_data (wdata),
    .R0_data (_tag_array_3_ext_R0_data)
  );
  tag_array_64x22 tag_array_4_ext (
    .R0_addr (io_read_bits_idx),
    .R0_en   (_GEN_37),
    .R0_clk  (clock),
    .W0_addr (waddr),
    .W0_en   (wen & wmask_4),
    .W0_clk  (clock),
    .W0_data (wdata),
    .R0_data (_tag_array_4_ext_R0_data)
  );
  tag_array_64x22 tag_array_5_ext (
    .R0_addr (io_read_bits_idx),
    .R0_en   (_GEN_37),
    .R0_clk  (clock),
    .W0_addr (waddr),
    .W0_en   (wen & wmask_5),
    .W0_clk  (clock),
    .W0_data (wdata),
    .R0_data (_tag_array_5_ext_R0_data)
  );
  tag_array_64x22 tag_array_6_ext (
    .R0_addr (io_read_bits_idx),
    .R0_en   (_GEN_37),
    .R0_clk  (clock),
    .W0_addr (waddr),
    .W0_en   (wen & wmask_6),
    .W0_clk  (clock),
    .W0_data (wdata),
    .R0_data (_tag_array_6_ext_R0_data)
  );
  tag_array_64x22 tag_array_7_ext (
    .R0_addr (io_read_bits_idx),
    .R0_en   (_GEN_37),
    .R0_clk  (clock),
    .W0_addr (waddr),
    .W0_en   (wen & wmask_7),
    .W0_clk  (clock),
    .W0_data (wdata),
    .R0_data (_tag_array_7_ext_R0_data)
  );
  assign io_read_ready = ~wen;
  assign io_write_ready = rst_cnt[6];
  assign io_resp_0_coh_state = _tag_array_0_ext_R0_data[21:20];
  assign io_resp_0_tag = _tag_array_0_ext_R0_data[19:0];
  assign io_resp_1_coh_state = _tag_array_1_ext_R0_data[21:20];
  assign io_resp_1_tag = _tag_array_1_ext_R0_data[19:0];
  assign io_resp_2_coh_state = _tag_array_2_ext_R0_data[21:20];
  assign io_resp_2_tag = _tag_array_2_ext_R0_data[19:0];
  assign io_resp_3_coh_state = _tag_array_3_ext_R0_data[21:20];
  assign io_resp_3_tag = _tag_array_3_ext_R0_data[19:0];
  assign io_resp_4_coh_state = _tag_array_4_ext_R0_data[21:20];
  assign io_resp_4_tag = _tag_array_4_ext_R0_data[19:0];
  assign io_resp_5_coh_state = _tag_array_5_ext_R0_data[21:20];
  assign io_resp_5_tag = _tag_array_5_ext_R0_data[19:0];
  assign io_resp_6_coh_state = _tag_array_6_ext_R0_data[21:20];
  assign io_resp_6_tag = _tag_array_6_ext_R0_data[19:0];
  assign io_resp_7_coh_state = _tag_array_7_ext_R0_data[21:20];
  assign io_resp_7_tag = _tag_array_7_ext_R0_data[19:0];
endmodule

