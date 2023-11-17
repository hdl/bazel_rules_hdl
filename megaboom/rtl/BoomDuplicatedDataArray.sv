// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BoomDuplicatedDataArray(
  input          clock,
                 io_read_0_valid,
  input  [7:0]   io_read_0_bits_way_en,
  input  [11:0]  io_read_0_bits_addr,
  input          io_read_1_valid,
  input  [7:0]   io_read_1_bits_way_en,
  input  [11:0]  io_read_1_bits_addr,
  input          io_write_valid,
  input  [7:0]   io_write_bits_way_en,
  input  [11:0]  io_write_bits_addr,
  input  [1:0]   io_write_bits_wmask,
  input  [127:0] io_write_bits_data,
  output [127:0] io_resp_0_0,
                 io_resp_0_1,
                 io_resp_0_2,
                 io_resp_0_3,
                 io_resp_0_4,
                 io_resp_0_5,
                 io_resp_0_6,
                 io_resp_0_7,
                 io_resp_1_0,
                 io_resp_1_1,
                 io_resp_1_2,
                 io_resp_1_3,
                 io_resp_1_4,
                 io_resp_1_5,
                 io_resp_1_6,
                 io_resp_1_7
);

  wire         _GEN_231;
  wire         _GEN_216;
  wire         _GEN_201;
  wire         _GEN_186;
  wire         _GEN_171;
  wire         _GEN_156;
  wire         _GEN_141;
  wire         _GEN_126;
  wire         _GEN_111;
  wire         _GEN_96;
  wire         _GEN_81;
  wire         _GEN_66;
  wire         _GEN_51;
  wire         _GEN_36;
  wire         _GEN_21;
  wire         _GEN_233;
  wire         _GEN_232;
  wire         _GEN_6;
  wire [63:0]  _array_7_1_1_ext_R0_data;
  wire [63:0]  _array_7_1_0_ext_R0_data;
  wire [63:0]  _array_6_1_1_ext_R0_data;
  wire [63:0]  _array_6_1_0_ext_R0_data;
  wire [63:0]  _array_5_1_1_ext_R0_data;
  wire [63:0]  _array_5_1_0_ext_R0_data;
  wire [63:0]  _array_4_1_1_ext_R0_data;
  wire [63:0]  _array_4_1_0_ext_R0_data;
  wire [63:0]  _array_3_1_1_ext_R0_data;
  wire [63:0]  _array_3_1_0_ext_R0_data;
  wire [63:0]  _array_2_1_1_ext_R0_data;
  wire [63:0]  _array_2_1_0_ext_R0_data;
  wire [63:0]  _array_1_1_1_ext_R0_data;
  wire [63:0]  _array_1_1_0_ext_R0_data;
  wire [63:0]  _array_0_1_1_ext_R0_data;
  wire [63:0]  _array_0_1_0_ext_R0_data;
  wire [63:0]  _array_7_0_1_ext_R0_data;
  wire [63:0]  _array_7_0_0_ext_R0_data;
  wire [63:0]  _array_6_0_1_ext_R0_data;
  wire [63:0]  _array_6_0_0_ext_R0_data;
  wire [63:0]  _array_5_0_1_ext_R0_data;
  wire [63:0]  _array_5_0_0_ext_R0_data;
  wire [63:0]  _array_4_0_1_ext_R0_data;
  wire [63:0]  _array_4_0_0_ext_R0_data;
  wire [63:0]  _array_3_0_1_ext_R0_data;
  wire [63:0]  _array_3_0_0_ext_R0_data;
  wire [63:0]  _array_2_0_1_ext_R0_data;
  wire [63:0]  _array_2_0_0_ext_R0_data;
  wire [63:0]  _array_1_0_1_ext_R0_data;
  wire [63:0]  _array_1_0_0_ext_R0_data;
  wire [63:0]  _array_0_0_1_ext_R0_data;
  wire [63:0]  _array_0_0_0_ext_R0_data;
  assign _GEN_6 = io_write_bits_way_en[0] & io_write_valid;
  assign _GEN_232 = io_write_bits_wmask[0];
  assign _GEN_233 = io_write_bits_wmask[1];
  wire         _GEN_12 = io_read_0_bits_way_en[0] & io_read_0_valid;
  reg  [127:0] io_resp_0_0_REG;
  assign _GEN_21 = io_write_bits_way_en[1] & io_write_valid;
  wire         _GEN_27 = io_read_0_bits_way_en[1] & io_read_0_valid;
  reg  [127:0] io_resp_0_1_REG;
  assign _GEN_36 = io_write_bits_way_en[2] & io_write_valid;
  wire         _GEN_42 = io_read_0_bits_way_en[2] & io_read_0_valid;
  reg  [127:0] io_resp_0_2_REG;
  assign _GEN_51 = io_write_bits_way_en[3] & io_write_valid;
  wire         _GEN_57 = io_read_0_bits_way_en[3] & io_read_0_valid;
  reg  [127:0] io_resp_0_3_REG;
  assign _GEN_66 = io_write_bits_way_en[4] & io_write_valid;
  wire         _GEN_72 = io_read_0_bits_way_en[4] & io_read_0_valid;
  reg  [127:0] io_resp_0_4_REG;
  assign _GEN_81 = io_write_bits_way_en[5] & io_write_valid;
  wire         _GEN_87 = io_read_0_bits_way_en[5] & io_read_0_valid;
  reg  [127:0] io_resp_0_5_REG;
  assign _GEN_96 = io_write_bits_way_en[6] & io_write_valid;
  wire         _GEN_102 = io_read_0_bits_way_en[6] & io_read_0_valid;
  reg  [127:0] io_resp_0_6_REG;
  assign _GEN_111 = io_write_bits_way_en[7] & io_write_valid;
  wire         _GEN_117 = io_read_0_bits_way_en[7] & io_read_0_valid;
  reg  [127:0] io_resp_0_7_REG;
  assign _GEN_126 = io_write_bits_way_en[0] & io_write_valid;
  wire         _GEN_132 = io_read_1_bits_way_en[0] & io_read_1_valid;
  reg  [127:0] io_resp_1_0_REG;
  assign _GEN_141 = io_write_bits_way_en[1] & io_write_valid;
  wire         _GEN_147 = io_read_1_bits_way_en[1] & io_read_1_valid;
  reg  [127:0] io_resp_1_1_REG;
  assign _GEN_156 = io_write_bits_way_en[2] & io_write_valid;
  wire         _GEN_162 = io_read_1_bits_way_en[2] & io_read_1_valid;
  reg  [127:0] io_resp_1_2_REG;
  assign _GEN_171 = io_write_bits_way_en[3] & io_write_valid;
  wire         _GEN_177 = io_read_1_bits_way_en[3] & io_read_1_valid;
  reg  [127:0] io_resp_1_3_REG;
  assign _GEN_186 = io_write_bits_way_en[4] & io_write_valid;
  wire         _GEN_192 = io_read_1_bits_way_en[4] & io_read_1_valid;
  reg  [127:0] io_resp_1_4_REG;
  assign _GEN_201 = io_write_bits_way_en[5] & io_write_valid;
  wire         _GEN_207 = io_read_1_bits_way_en[5] & io_read_1_valid;
  reg  [127:0] io_resp_1_5_REG;
  assign _GEN_216 = io_write_bits_way_en[6] & io_write_valid;
  wire         _GEN_222 = io_read_1_bits_way_en[6] & io_read_1_valid;
  reg  [127:0] io_resp_1_6_REG;
  assign _GEN_231 = io_write_bits_way_en[7] & io_write_valid;
  wire         _GEN_237 = io_read_1_bits_way_en[7] & io_read_1_valid;
  reg  [127:0] io_resp_1_7_REG;
  always @(posedge clock) begin
    io_resp_0_0_REG <= {_array_0_0_1_ext_R0_data, _array_0_0_0_ext_R0_data};
    io_resp_0_1_REG <= {_array_1_0_1_ext_R0_data, _array_1_0_0_ext_R0_data};
    io_resp_0_2_REG <= {_array_2_0_1_ext_R0_data, _array_2_0_0_ext_R0_data};
    io_resp_0_3_REG <= {_array_3_0_1_ext_R0_data, _array_3_0_0_ext_R0_data};
    io_resp_0_4_REG <= {_array_4_0_1_ext_R0_data, _array_4_0_0_ext_R0_data};
    io_resp_0_5_REG <= {_array_5_0_1_ext_R0_data, _array_5_0_0_ext_R0_data};
    io_resp_0_6_REG <= {_array_6_0_1_ext_R0_data, _array_6_0_0_ext_R0_data};
    io_resp_0_7_REG <= {_array_7_0_1_ext_R0_data, _array_7_0_0_ext_R0_data};
    io_resp_1_0_REG <= {_array_0_1_1_ext_R0_data, _array_0_1_0_ext_R0_data};
    io_resp_1_1_REG <= {_array_1_1_1_ext_R0_data, _array_1_1_0_ext_R0_data};
    io_resp_1_2_REG <= {_array_2_1_1_ext_R0_data, _array_2_1_0_ext_R0_data};
    io_resp_1_3_REG <= {_array_3_1_1_ext_R0_data, _array_3_1_0_ext_R0_data};
    io_resp_1_4_REG <= {_array_4_1_1_ext_R0_data, _array_4_1_0_ext_R0_data};
    io_resp_1_5_REG <= {_array_5_1_1_ext_R0_data, _array_5_1_0_ext_R0_data};
    io_resp_1_6_REG <= {_array_6_1_1_ext_R0_data, _array_6_1_0_ext_R0_data};
    io_resp_1_7_REG <= {_array_7_1_1_ext_R0_data, _array_7_1_0_ext_R0_data};
  end // always @(posedge)
  array_256x64 array_0_0_0_ext (
    .R0_addr (io_read_0_bits_addr[11:4]),
    .R0_en   (_GEN_12),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_6 & _GEN_232),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[63:0]),
    .R0_data (_array_0_0_0_ext_R0_data)
  );
  array_256x64 array_0_0_1_ext (
    .R0_addr (io_read_0_bits_addr[11:4]),
    .R0_en   (_GEN_12),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_6 & _GEN_233),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[127:64]),
    .R0_data (_array_0_0_1_ext_R0_data)
  );
  array_256x64 array_1_0_0_ext (
    .R0_addr (io_read_0_bits_addr[11:4]),
    .R0_en   (_GEN_27),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_21 & _GEN_232),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[63:0]),
    .R0_data (_array_1_0_0_ext_R0_data)
  );
  array_256x64 array_1_0_1_ext (
    .R0_addr (io_read_0_bits_addr[11:4]),
    .R0_en   (_GEN_27),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_21 & _GEN_233),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[127:64]),
    .R0_data (_array_1_0_1_ext_R0_data)
  );
  array_256x64 array_2_0_0_ext (
    .R0_addr (io_read_0_bits_addr[11:4]),
    .R0_en   (_GEN_42),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_36 & _GEN_232),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[63:0]),
    .R0_data (_array_2_0_0_ext_R0_data)
  );
  array_256x64 array_2_0_1_ext (
    .R0_addr (io_read_0_bits_addr[11:4]),
    .R0_en   (_GEN_42),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_36 & _GEN_233),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[127:64]),
    .R0_data (_array_2_0_1_ext_R0_data)
  );
  array_256x64 array_3_0_0_ext (
    .R0_addr (io_read_0_bits_addr[11:4]),
    .R0_en   (_GEN_57),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_51 & _GEN_232),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[63:0]),
    .R0_data (_array_3_0_0_ext_R0_data)
  );
  array_256x64 array_3_0_1_ext (
    .R0_addr (io_read_0_bits_addr[11:4]),
    .R0_en   (_GEN_57),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_51 & _GEN_233),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[127:64]),
    .R0_data (_array_3_0_1_ext_R0_data)
  );
  array_256x64 array_4_0_0_ext (
    .R0_addr (io_read_0_bits_addr[11:4]),
    .R0_en   (_GEN_72),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_66 & _GEN_232),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[63:0]),
    .R0_data (_array_4_0_0_ext_R0_data)
  );
  array_256x64 array_4_0_1_ext (
    .R0_addr (io_read_0_bits_addr[11:4]),
    .R0_en   (_GEN_72),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_66 & _GEN_233),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[127:64]),
    .R0_data (_array_4_0_1_ext_R0_data)
  );
  array_256x64 array_5_0_0_ext (
    .R0_addr (io_read_0_bits_addr[11:4]),
    .R0_en   (_GEN_87),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_81 & _GEN_232),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[63:0]),
    .R0_data (_array_5_0_0_ext_R0_data)
  );
  array_256x64 array_5_0_1_ext (
    .R0_addr (io_read_0_bits_addr[11:4]),
    .R0_en   (_GEN_87),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_81 & _GEN_233),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[127:64]),
    .R0_data (_array_5_0_1_ext_R0_data)
  );
  array_256x64 array_6_0_0_ext (
    .R0_addr (io_read_0_bits_addr[11:4]),
    .R0_en   (_GEN_102),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_96 & _GEN_232),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[63:0]),
    .R0_data (_array_6_0_0_ext_R0_data)
  );
  array_256x64 array_6_0_1_ext (
    .R0_addr (io_read_0_bits_addr[11:4]),
    .R0_en   (_GEN_102),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_96 & _GEN_233),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[127:64]),
    .R0_data (_array_6_0_1_ext_R0_data)
  );
  array_256x64 array_7_0_0_ext (
    .R0_addr (io_read_0_bits_addr[11:4]),
    .R0_en   (_GEN_117),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_111 & _GEN_232),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[63:0]),
    .R0_data (_array_7_0_0_ext_R0_data)
  );
  array_256x64 array_7_0_1_ext (
    .R0_addr (io_read_0_bits_addr[11:4]),
    .R0_en   (_GEN_117),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_111 & _GEN_233),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[127:64]),
    .R0_data (_array_7_0_1_ext_R0_data)
  );
  array_256x64 array_0_1_0_ext (
    .R0_addr (io_read_1_bits_addr[11:4]),
    .R0_en   (_GEN_132),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_126 & _GEN_232),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[63:0]),
    .R0_data (_array_0_1_0_ext_R0_data)
  );
  array_256x64 array_0_1_1_ext (
    .R0_addr (io_read_1_bits_addr[11:4]),
    .R0_en   (_GEN_132),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_126 & _GEN_233),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[127:64]),
    .R0_data (_array_0_1_1_ext_R0_data)
  );
  array_256x64 array_1_1_0_ext (
    .R0_addr (io_read_1_bits_addr[11:4]),
    .R0_en   (_GEN_147),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_141 & _GEN_232),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[63:0]),
    .R0_data (_array_1_1_0_ext_R0_data)
  );
  array_256x64 array_1_1_1_ext (
    .R0_addr (io_read_1_bits_addr[11:4]),
    .R0_en   (_GEN_147),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_141 & _GEN_233),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[127:64]),
    .R0_data (_array_1_1_1_ext_R0_data)
  );
  array_256x64 array_2_1_0_ext (
    .R0_addr (io_read_1_bits_addr[11:4]),
    .R0_en   (_GEN_162),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_156 & _GEN_232),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[63:0]),
    .R0_data (_array_2_1_0_ext_R0_data)
  );
  array_256x64 array_2_1_1_ext (
    .R0_addr (io_read_1_bits_addr[11:4]),
    .R0_en   (_GEN_162),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_156 & _GEN_233),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[127:64]),
    .R0_data (_array_2_1_1_ext_R0_data)
  );
  array_256x64 array_3_1_0_ext (
    .R0_addr (io_read_1_bits_addr[11:4]),
    .R0_en   (_GEN_177),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_171 & _GEN_232),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[63:0]),
    .R0_data (_array_3_1_0_ext_R0_data)
  );
  array_256x64 array_3_1_1_ext (
    .R0_addr (io_read_1_bits_addr[11:4]),
    .R0_en   (_GEN_177),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_171 & _GEN_233),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[127:64]),
    .R0_data (_array_3_1_1_ext_R0_data)
  );
  array_256x64 array_4_1_0_ext (
    .R0_addr (io_read_1_bits_addr[11:4]),
    .R0_en   (_GEN_192),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_186 & _GEN_232),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[63:0]),
    .R0_data (_array_4_1_0_ext_R0_data)
  );
  array_256x64 array_4_1_1_ext (
    .R0_addr (io_read_1_bits_addr[11:4]),
    .R0_en   (_GEN_192),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_186 & _GEN_233),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[127:64]),
    .R0_data (_array_4_1_1_ext_R0_data)
  );
  array_256x64 array_5_1_0_ext (
    .R0_addr (io_read_1_bits_addr[11:4]),
    .R0_en   (_GEN_207),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_201 & _GEN_232),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[63:0]),
    .R0_data (_array_5_1_0_ext_R0_data)
  );
  array_256x64 array_5_1_1_ext (
    .R0_addr (io_read_1_bits_addr[11:4]),
    .R0_en   (_GEN_207),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_201 & _GEN_233),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[127:64]),
    .R0_data (_array_5_1_1_ext_R0_data)
  );
  array_256x64 array_6_1_0_ext (
    .R0_addr (io_read_1_bits_addr[11:4]),
    .R0_en   (_GEN_222),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_216 & _GEN_232),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[63:0]),
    .R0_data (_array_6_1_0_ext_R0_data)
  );
  array_256x64 array_6_1_1_ext (
    .R0_addr (io_read_1_bits_addr[11:4]),
    .R0_en   (_GEN_222),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_216 & _GEN_233),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[127:64]),
    .R0_data (_array_6_1_1_ext_R0_data)
  );
  array_256x64 array_7_1_0_ext (
    .R0_addr (io_read_1_bits_addr[11:4]),
    .R0_en   (_GEN_237),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_231 & _GEN_232),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[63:0]),
    .R0_data (_array_7_1_0_ext_R0_data)
  );
  array_256x64 array_7_1_1_ext (
    .R0_addr (io_read_1_bits_addr[11:4]),
    .R0_en   (_GEN_237),
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:4]),
    .W0_en   (_GEN_231 & _GEN_233),
    .W0_clk  (clock),
    .W0_data (io_write_bits_data[127:64]),
    .R0_data (_array_7_1_1_ext_R0_data)
  );
  assign io_resp_0_0 = io_resp_0_0_REG;
  assign io_resp_0_1 = io_resp_0_1_REG;
  assign io_resp_0_2 = io_resp_0_2_REG;
  assign io_resp_0_3 = io_resp_0_3_REG;
  assign io_resp_0_4 = io_resp_0_4_REG;
  assign io_resp_0_5 = io_resp_0_5_REG;
  assign io_resp_0_6 = io_resp_0_6_REG;
  assign io_resp_0_7 = io_resp_0_7_REG;
  assign io_resp_1_0 = io_resp_1_0_REG;
  assign io_resp_1_1 = io_resp_1_1_REG;
  assign io_resp_1_2 = io_resp_1_2_REG;
  assign io_resp_1_3 = io_resp_1_3_REG;
  assign io_resp_1_4 = io_resp_1_4_REG;
  assign io_resp_1_5 = io_resp_1_5_REG;
  assign io_resp_1_6 = io_resp_1_6_REG;
  assign io_resp_1_7 = io_resp_1_7_REG;
endmodule

