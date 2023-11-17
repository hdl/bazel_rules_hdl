// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RVCExpander(
  input  [31:0] io_in,
  output [31:0] io_out_bits,
  output        io_rvc
);

  reg  [2:0]  casez_tmp;
  wire [2:0]  _io_out_s_funct_T_2 = {io_in[12], io_in[6:5]};
  wire [2:0]  _io_out_s_funct_T_4 = {_io_out_s_funct_T_2 == 3'h1, 2'h0};
  always @(*) begin
    casez (_io_out_s_funct_T_2)
      3'b000:
        casez_tmp = _io_out_s_funct_T_4;
      3'b001:
        casez_tmp = _io_out_s_funct_T_4;
      3'b010:
        casez_tmp = 3'h6;
      3'b011:
        casez_tmp = 3'h7;
      3'b100:
        casez_tmp = 3'h0;
      3'b101:
        casez_tmp = 3'h0;
      3'b110:
        casez_tmp = 3'h2;
      default:
        casez_tmp = 3'h3;
    endcase
  end // always @(*)
  wire [3:0]  _GEN = {4{io_in[12]}};
  wire [6:0]  io_out_s_load_opc = (|(io_in[11:7])) ? 7'h3 : 7'h1F;
  wire [4:0]  _io_out_T_2 = {io_in[1:0], io_in[15:13]};
  wire [31:0] _io_out_T_42_bits =
    _io_out_T_2 == 5'h14
      ? {7'h0, io_in[12] ? ((|(io_in[6:2])) ? {io_in[6:2], io_in[11:7], 3'h0, io_in[11:7], 7'h33} : (|(io_in[11:7])) ? {io_in[6:2], io_in[11:7], 15'hE7} : {io_in[6:3], 1'h1, io_in[11:7], 15'h73}) : {io_in[6:2], (|(io_in[6:2])) ? {8'h0, io_in[11:7], 7'h33} : {io_in[11:7], (|(io_in[11:7])) ? 15'h67 : 15'h1F}}}
      : _io_out_T_2 == 5'h13
          ? {3'h0, io_in[4:2], io_in[12], io_in[6:5], 11'h13, io_in[11:7], io_out_s_load_opc}
          : _io_out_T_2 == 5'h12
              ? {4'h0, io_in[3:2], io_in[12], io_in[6:4], 10'h12, io_in[11:7], io_out_s_load_opc}
              : _io_out_T_2 == 5'h11
                  ? {3'h0, io_in[4:2], io_in[12], io_in[6:5], 11'h13, io_in[11:7], 7'h7}
                  : _io_out_T_2 == 5'h10
                      ? {6'h0, io_in[12], io_in[6:2], io_in[11:7], 3'h1, io_in[11:7], 7'h13}
                      : _io_out_T_2 == 5'hF
                          ? {_GEN, io_in[6:5], io_in[2], 7'h1, io_in[9:7], 3'h1, io_in[11:10], io_in[4:3], io_in[12], 7'h63}
                          : _io_out_T_2 == 5'hE
                              ? {_GEN, io_in[6:5], io_in[2], 7'h1, io_in[9:7], 3'h0, io_in[11:10], io_in[4:3], io_in[12], 7'h63}
                              : _io_out_T_2 == 5'hD ? {io_in[12], io_in[8], io_in[10:9], io_in[6], io_in[7], io_in[2], io_in[11], io_in[5:3], {9{io_in[12]}}, 12'h6F} : _io_out_T_2 == 5'hC ? ((&(io_in[11:10])) ? {1'h0, io_in[6:5] == 2'h0, 7'h1, io_in[4:2], 2'h1, io_in[9:7], casez_tmp, 2'h1, io_in[9:7], 3'h3, io_in[12], 3'h3} : {io_in[11:10] == 2'h2 ? {{7{io_in[12]}}, io_in[6:2], 2'h1, io_in[9:7], 5'h1D} : {1'h0, io_in[11:10] == 2'h1, 4'h0, io_in[12], io_in[6:2], 2'h1, io_in[9:7], 5'h15}, io_in[9:7], 7'h13}) : _io_out_T_2 == 5'hB ? {{3{io_in[12]}}, io_in[11:7] == 5'h0 | io_in[11:7] == 5'h2 ? {io_in[4:3], io_in[5], io_in[2], io_in[6], 4'h0, io_in[11:7], 3'h0, io_in[11:7], (|{{7{io_in[12]}}, io_in[6:2]}) ? 7'h13 : 7'h1F} : {{12{io_in[12]}}, io_in[6:2], io_in[11:7], 3'h3, {{7{io_in[12]}}, io_in[6:2]} == 12'h0, 3'h7}} : _io_out_T_2 == 5'hA ? {{7{io_in[12]}}, io_in[6:2], 8'h0, io_in[11:7], 7'h13} : _io_out_T_2 == 5'h9 ? {{7{io_in[12]}}, io_in[6:2], io_in[11:7], 3'h0, io_in[11:7], 4'h3, io_in[11:7] == 5'h0, 2'h3} : _io_out_T_2 == 5'h8 ? {{7{io_in[12]}}, io_in[6:2], io_in[11:7], 3'h0, io_in[11:7], 7'h13} : _io_out_T_2 == 5'h7 ? {4'h0, io_in[6:5], io_in[12], 2'h1, io_in[4:2], 2'h1, io_in[9:7], 3'h3, io_in[11:10], 10'h23} : _io_out_T_2 == 5'h6 ? {5'h0, io_in[5], io_in[12], 2'h1, io_in[4:2], 2'h1, io_in[9:7], 3'h2, io_in[11:10], io_in[6], 9'h23} : _io_out_T_2 == 5'h5 ? {4'h0, io_in[6:5], io_in[12], 2'h1, io_in[4:2], 2'h1, io_in[9:7], 3'h3, io_in[11:10], 10'h27} : _io_out_T_2 == 5'h4 ? {5'h0, io_in[5], io_in[12], 2'h1, io_in[4:2], 2'h1, io_in[9:7], 3'h2, io_in[11:10], io_in[6], 9'h3F} : _io_out_T_2 == 5'h3 ? {4'h0, io_in[6:5], io_in[12:10], 5'h1, io_in[9:7], 5'hD, io_in[4:2], 7'h3} : _io_out_T_2 == 5'h2 ? {5'h0, io_in[5], io_in[12:10], io_in[6], 4'h1, io_in[9:7], 5'h9, io_in[4:2], 7'h3} : _io_out_T_2 == 5'h1 ? {4'h0, io_in[6:5], io_in[12:10], 5'h1, io_in[9:7], 5'hD, io_in[4:2], 7'h7} : {2'h0, io_in[10:7], io_in[12:11], io_in[5], io_in[6], 12'h41, io_in[4:2], (|(io_in[12:5])) ? 7'h13 : 7'h1F};
  assign io_out_bits = (&_io_out_T_2) | _io_out_T_2 == 5'h1E | _io_out_T_2 == 5'h1D | _io_out_T_2 == 5'h1C | _io_out_T_2 == 5'h1B | _io_out_T_2 == 5'h1A | _io_out_T_2 == 5'h19 | _io_out_T_2 == 5'h18 ? io_in : _io_out_T_2 == 5'h17 ? {3'h0, io_in[9:7], io_in[12], io_in[6:2], 8'h13, io_in[11:10], 10'h23} : _io_out_T_2 == 5'h16 ? {4'h0, io_in[8:7], io_in[12], io_in[6:2], 8'h12, io_in[11:9], 9'h23} : _io_out_T_2 == 5'h15 ? {3'h0, io_in[9:7], io_in[12], io_in[6:2], 8'h13, io_in[11:10], 10'h27} : _io_out_T_42_bits;
  assign io_rvc = io_in[1:0] != 2'h3;
endmodule

