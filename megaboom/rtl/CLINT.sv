// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module CLINT(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
  input  [1:0]  auto_in_a_bits_size,
  input  [10:0] auto_in_a_bits_source,
  input  [25:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input  [63:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
                auto_in_d_ready,
                io_rtcTick,
  output        auto_int_out_0,
                auto_int_out_1,
                auto_in_a_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
  output [1:0]  auto_in_d_bits_size,
  output [10:0] auto_in_d_bits_source,
  output [63:0] auto_in_d_bits_data
);

  reg  [63:0] casez_tmp;
  reg  [63:0] time_0;
  reg  [63:0] pad;
  reg         ipi_0;
  wire        in_bits_read = auto_in_a_bits_opcode == 3'h4;
  wire        _GEN_37 = auto_in_a_bits_address[13:3] == 11'h0;
  always @(*) begin
    casez (auto_in_a_bits_address[15:14])
      2'b00:
        casez_tmp = {63'h0, ipi_0};
      2'b01:
        casez_tmp = pad;
      2'b10:
        casez_tmp = time_0;
      default:
        casez_tmp = 64'h0;
    endcase
  end // always @(*)
  wire [2:0]  _GEN = {2'h0, in_bits_read};
  wire        _out_wofireMux_T_2 = auto_in_a_valid & auto_in_d_ready & ~in_bits_read;
  wire        out_woready_10 = _out_wofireMux_T_2 & auto_in_a_bits_address[15:14] == 2'h1 & _GEN_37;
  wire        valids__0 = out_woready_10 & auto_in_a_bits_mask[0];
  wire        valids__1 = out_woready_10 & auto_in_a_bits_mask[1];
  wire        valids__2 = out_woready_10 & auto_in_a_bits_mask[2];
  wire        valids__3 = out_woready_10 & auto_in_a_bits_mask[3];
  wire        valids__4 = out_woready_10 & auto_in_a_bits_mask[4];
  wire        valids__5 = out_woready_10 & auto_in_a_bits_mask[5];
  wire        valids__6 = out_woready_10 & auto_in_a_bits_mask[6];
  wire        valids__7 = out_woready_10 & auto_in_a_bits_mask[7];
  wire        out_woready_2 = _out_wofireMux_T_2 & auto_in_a_bits_address[15:14] == 2'h2 & (&(auto_in_a_bits_address[13:3]));
  wire        valids_1_0 = out_woready_2 & auto_in_a_bits_mask[0];
  wire        valids_1_1 = out_woready_2 & auto_in_a_bits_mask[1];
  wire        valids_1_2 = out_woready_2 & auto_in_a_bits_mask[2];
  wire        valids_1_3 = out_woready_2 & auto_in_a_bits_mask[3];
  wire        valids_1_4 = out_woready_2 & auto_in_a_bits_mask[4];
  wire        valids_1_5 = out_woready_2 & auto_in_a_bits_mask[5];
  wire        valids_1_6 = out_woready_2 & auto_in_a_bits_mask[6];
  wire        valids_1_7 = out_woready_2 & auto_in_a_bits_mask[7];
  always @(posedge clock) begin
    if (reset) begin
      time_0 <= 64'h0;
      ipi_0 <= 1'h0;
    end
    else begin
      if (valids_1_0 | valids_1_1 | valids_1_2 | valids_1_3 | valids_1_4 | valids_1_5 | valids_1_6 | valids_1_7)
        time_0 <= {valids_1_7 ? auto_in_a_bits_data[63:56] : time_0[63:56], valids_1_6 ? auto_in_a_bits_data[55:48] : time_0[55:48], valids_1_5 ? auto_in_a_bits_data[47:40] : time_0[47:40], valids_1_4 ? auto_in_a_bits_data[39:32] : time_0[39:32], valids_1_3 ? auto_in_a_bits_data[31:24] : time_0[31:24], valids_1_2 ? auto_in_a_bits_data[23:16] : time_0[23:16], valids_1_1 ? auto_in_a_bits_data[15:8] : time_0[15:8], valids_1_0 ? auto_in_a_bits_data[7:0] : time_0[7:0]};
      else if (io_rtcTick)
        time_0 <= time_0 + 64'h1;
      if (_out_wofireMux_T_2 & auto_in_a_bits_address[15:14] == 2'h0 & _GEN_37 & auto_in_a_bits_mask[0])
        ipi_0 <= auto_in_a_bits_data[0];
    end
    if (valids__0 | valids__1 | valids__2 | valids__3 | valids__4 | valids__5 | valids__6 | valids__7)
      pad <= {valids__7 ? auto_in_a_bits_data[63:56] : pad[63:56], valids__6 ? auto_in_a_bits_data[55:48] : pad[55:48], valids__5 ? auto_in_a_bits_data[47:40] : pad[47:40], valids__4 ? auto_in_a_bits_data[39:32] : pad[39:32], valids__3 ? auto_in_a_bits_data[31:24] : pad[31:24], valids__2 ? auto_in_a_bits_data[23:16] : pad[23:16], valids__1 ? auto_in_a_bits_data[15:8] : pad[15:8], valids__0 ? auto_in_a_bits_data[7:0] : pad[7:0]};
  end // always @(posedge)
  assign auto_int_out_0 = ipi_0;
  assign auto_int_out_1 = time_0 >= pad;
  assign auto_in_a_ready = auto_in_d_ready;
  assign auto_in_d_valid = auto_in_a_valid;
  assign auto_in_d_bits_opcode = _GEN;
  assign auto_in_d_bits_size = auto_in_a_bits_size;
  assign auto_in_d_bits_source = auto_in_a_bits_source;
  assign auto_in_d_bits_data = (&(auto_in_a_bits_address[15:14])) | (auto_in_a_bits_address[15:14] == 2'h2 ? (&(auto_in_a_bits_address[13:3])) : _GEN_37) ? casez_tmp : 64'h0;
endmodule

