// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Atomics(
  input          io_write,
  input  [2:0]   io_a_opcode,
                 io_a_param,
  input  [15:0]  io_a_mask,
  input  [127:0] io_a_data,
                 io_data_in,
  output [127:0] io_data_out
);

  reg  [7:0]   casez_tmp;
  reg  [7:0]   casez_tmp_0;
  reg  [7:0]   casez_tmp_1;
  reg  [7:0]   casez_tmp_2;
  reg  [7:0]   casez_tmp_3;
  reg  [7:0]   casez_tmp_4;
  reg  [7:0]   casez_tmp_5;
  reg  [7:0]   casez_tmp_6;
  reg  [7:0]   casez_tmp_7;
  reg  [7:0]   casez_tmp_8;
  reg  [7:0]   casez_tmp_9;
  reg  [7:0]   casez_tmp_10;
  reg  [7:0]   casez_tmp_11;
  reg  [7:0]   casez_tmp_12;
  reg  [7:0]   casez_tmp_13;
  reg  [7:0]   casez_tmp_14;
  wire [15:0]  signBit = io_a_mask & {1'h1, ~(io_a_mask[15:1])};
  wire [127:0] _sum_T_50 = ({{8{io_a_mask[15]}}, {8{io_a_mask[14]}}, {8{io_a_mask[13]}}, {8{io_a_mask[12]}}, {8{io_a_mask[11]}}, {8{io_a_mask[10]}}, {8{io_a_mask[9]}}, {8{io_a_mask[8]}}, {8{io_a_mask[7]}}, {8{io_a_mask[6]}}, {8{io_a_mask[5]}}, {8{io_a_mask[4]}}, {8{io_a_mask[3]}}, {8{io_a_mask[2]}}, {8{io_a_mask[1]}}, {8{io_a_mask[0]}}} & io_a_data) + ({128{~(io_a_param[2])}} ^ io_data_in);
  wire [15:0]  _sign_a_T_129 = {io_a_data[127], io_a_data[119], io_a_data[111], io_a_data[103], io_a_data[95], io_a_data[87], io_a_data[79], io_a_data[71], io_a_data[63], io_a_data[55], io_a_data[47], io_a_data[39], io_a_data[31], io_a_data[23], io_a_data[15], io_a_data[7]} & signBit;
  wire [3:0]   _lut_WIRE_lut_T_126 = (&(io_a_param[1:0])) ? 4'hC : io_a_param[1:0] == 2'h2 ? 4'h8 : {io_a_param[1:0] == 2'h1, 3'h6};
  wire [1:0]   select = io_write ? 2'h1 : (&io_a_opcode) | io_a_opcode == 3'h6 | io_a_opcode == 3'h5 | io_a_opcode == 3'h4 ? 2'h0 : io_a_opcode == 3'h3 ? 2'h3 : io_a_opcode == 3'h2 ? (io_a_param[2] ? 2'h2 : {1'h0, io_a_param[0] == ((|_sign_a_T_129) == (|({io_data_in[127], io_data_in[119], io_data_in[111], io_data_in[103], io_data_in[95], io_data_in[87], io_data_in[79], io_data_in[71], io_data_in[63], io_data_in[55], io_data_in[47], io_data_in[39], io_data_in[31], io_data_in[23], io_data_in[15], io_data_in[7]} & signBit)) ? ({_sum_T_50[127], _sum_T_50[119], _sum_T_50[111], _sum_T_50[103], _sum_T_50[95], _sum_T_50[87], _sum_T_50[79], _sum_T_50[71], _sum_T_50[63], _sum_T_50[55], _sum_T_50[47], _sum_T_50[39], _sum_T_50[31], _sum_T_50[23], _sum_T_50[15], _sum_T_50[7]} & signBit) == 16'h0 : io_a_param[1] == (|_sign_a_T_129))}) : 2'h1;
  wire [3:0]   _logical_T_302 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[15], io_data_in[15]};
  wire [3:0]   _logical_T_299 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[14], io_data_in[14]};
  wire [3:0]   _logical_T_296 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[13], io_data_in[13]};
  wire [3:0]   _logical_T_293 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[12], io_data_in[12]};
  wire [3:0]   _logical_T_290 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[11], io_data_in[11]};
  wire [3:0]   _logical_T_287 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[10], io_data_in[10]};
  wire [3:0]   _logical_T_284 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[9], io_data_in[9]};
  wire [3:0]   _logical_T_281 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[8], io_data_in[8]};
  always @(*) begin
    casez (io_a_mask[1] ? select : 2'h0)
      2'b00:
        casez_tmp = io_data_in[15:8];
      2'b01:
        casez_tmp = io_a_data[15:8];
      2'b10:
        casez_tmp = _sum_T_50[15:8];
      default:
        casez_tmp = {_logical_T_302[0], _logical_T_299[0], _logical_T_296[0], _logical_T_293[0], _logical_T_290[0], _logical_T_287[0], _logical_T_284[0], _logical_T_281[0]};
    endcase
  end // always @(*)
  wire [3:0]   _logical_T_278 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[7], io_data_in[7]};
  wire [3:0]   _logical_T_275 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[6], io_data_in[6]};
  wire [3:0]   _logical_T_272 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[5], io_data_in[5]};
  wire [3:0]   _logical_T_269 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[4], io_data_in[4]};
  wire [3:0]   _logical_T_266 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[3], io_data_in[3]};
  wire [3:0]   _logical_T_263 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[2], io_data_in[2]};
  wire [3:0]   _logical_T_260 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[1], io_data_in[1]};
  wire [3:0]   _logical_T_257 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[0], io_data_in[0]};
  always @(*) begin
    casez (io_a_mask[0] ? select : 2'h0)
      2'b00:
        casez_tmp_0 = io_data_in[7:0];
      2'b01:
        casez_tmp_0 = io_a_data[7:0];
      2'b10:
        casez_tmp_0 = _sum_T_50[7:0];
      default:
        casez_tmp_0 = {_logical_T_278[0], _logical_T_275[0], _logical_T_272[0], _logical_T_269[0], _logical_T_266[0], _logical_T_263[0], _logical_T_260[0], _logical_T_257[0]};
    endcase
  end // always @(*)
  wire [3:0]   _logical_T_350 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[31], io_data_in[31]};
  wire [3:0]   _logical_T_347 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[30], io_data_in[30]};
  wire [3:0]   _logical_T_344 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[29], io_data_in[29]};
  wire [3:0]   _logical_T_341 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[28], io_data_in[28]};
  wire [3:0]   _logical_T_338 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[27], io_data_in[27]};
  wire [3:0]   _logical_T_335 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[26], io_data_in[26]};
  wire [3:0]   _logical_T_332 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[25], io_data_in[25]};
  wire [3:0]   _logical_T_329 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[24], io_data_in[24]};
  always @(*) begin
    casez (io_a_mask[3] ? select : 2'h0)
      2'b00:
        casez_tmp_1 = io_data_in[31:24];
      2'b01:
        casez_tmp_1 = io_a_data[31:24];
      2'b10:
        casez_tmp_1 = _sum_T_50[31:24];
      default:
        casez_tmp_1 = {_logical_T_350[0], _logical_T_347[0], _logical_T_344[0], _logical_T_341[0], _logical_T_338[0], _logical_T_335[0], _logical_T_332[0], _logical_T_329[0]};
    endcase
  end // always @(*)
  wire [3:0]   _logical_T_326 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[23], io_data_in[23]};
  wire [3:0]   _logical_T_323 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[22], io_data_in[22]};
  wire [3:0]   _logical_T_320 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[21], io_data_in[21]};
  wire [3:0]   _logical_T_317 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[20], io_data_in[20]};
  wire [3:0]   _logical_T_314 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[19], io_data_in[19]};
  wire [3:0]   _logical_T_311 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[18], io_data_in[18]};
  wire [3:0]   _logical_T_308 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[17], io_data_in[17]};
  wire [3:0]   _logical_T_305 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[16], io_data_in[16]};
  always @(*) begin
    casez (io_a_mask[2] ? select : 2'h0)
      2'b00:
        casez_tmp_2 = io_data_in[23:16];
      2'b01:
        casez_tmp_2 = io_a_data[23:16];
      2'b10:
        casez_tmp_2 = _sum_T_50[23:16];
      default:
        casez_tmp_2 = {_logical_T_326[0], _logical_T_323[0], _logical_T_320[0], _logical_T_317[0], _logical_T_314[0], _logical_T_311[0], _logical_T_308[0], _logical_T_305[0]};
    endcase
  end // always @(*)
  wire [3:0]   _logical_T_398 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[47], io_data_in[47]};
  wire [3:0]   _logical_T_395 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[46], io_data_in[46]};
  wire [3:0]   _logical_T_392 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[45], io_data_in[45]};
  wire [3:0]   _logical_T_389 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[44], io_data_in[44]};
  wire [3:0]   _logical_T_386 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[43], io_data_in[43]};
  wire [3:0]   _logical_T_383 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[42], io_data_in[42]};
  wire [3:0]   _logical_T_380 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[41], io_data_in[41]};
  wire [3:0]   _logical_T_377 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[40], io_data_in[40]};
  always @(*) begin
    casez (io_a_mask[5] ? select : 2'h0)
      2'b00:
        casez_tmp_3 = io_data_in[47:40];
      2'b01:
        casez_tmp_3 = io_a_data[47:40];
      2'b10:
        casez_tmp_3 = _sum_T_50[47:40];
      default:
        casez_tmp_3 = {_logical_T_398[0], _logical_T_395[0], _logical_T_392[0], _logical_T_389[0], _logical_T_386[0], _logical_T_383[0], _logical_T_380[0], _logical_T_377[0]};
    endcase
  end // always @(*)
  wire [3:0]   _logical_T_374 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[39], io_data_in[39]};
  wire [3:0]   _logical_T_371 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[38], io_data_in[38]};
  wire [3:0]   _logical_T_368 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[37], io_data_in[37]};
  wire [3:0]   _logical_T_365 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[36], io_data_in[36]};
  wire [3:0]   _logical_T_362 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[35], io_data_in[35]};
  wire [3:0]   _logical_T_359 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[34], io_data_in[34]};
  wire [3:0]   _logical_T_356 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[33], io_data_in[33]};
  wire [3:0]   _logical_T_353 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[32], io_data_in[32]};
  always @(*) begin
    casez (io_a_mask[4] ? select : 2'h0)
      2'b00:
        casez_tmp_4 = io_data_in[39:32];
      2'b01:
        casez_tmp_4 = io_a_data[39:32];
      2'b10:
        casez_tmp_4 = _sum_T_50[39:32];
      default:
        casez_tmp_4 = {_logical_T_374[0], _logical_T_371[0], _logical_T_368[0], _logical_T_365[0], _logical_T_362[0], _logical_T_359[0], _logical_T_356[0], _logical_T_353[0]};
    endcase
  end // always @(*)
  wire [3:0]   _logical_T_446 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[63], io_data_in[63]};
  wire [3:0]   _logical_T_443 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[62], io_data_in[62]};
  wire [3:0]   _logical_T_440 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[61], io_data_in[61]};
  wire [3:0]   _logical_T_437 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[60], io_data_in[60]};
  wire [3:0]   _logical_T_434 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[59], io_data_in[59]};
  wire [3:0]   _logical_T_431 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[58], io_data_in[58]};
  wire [3:0]   _logical_T_428 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[57], io_data_in[57]};
  wire [3:0]   _logical_T_425 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[56], io_data_in[56]};
  always @(*) begin
    casez (io_a_mask[7] ? select : 2'h0)
      2'b00:
        casez_tmp_5 = io_data_in[63:56];
      2'b01:
        casez_tmp_5 = io_a_data[63:56];
      2'b10:
        casez_tmp_5 = _sum_T_50[63:56];
      default:
        casez_tmp_5 = {_logical_T_446[0], _logical_T_443[0], _logical_T_440[0], _logical_T_437[0], _logical_T_434[0], _logical_T_431[0], _logical_T_428[0], _logical_T_425[0]};
    endcase
  end // always @(*)
  wire [3:0]   _logical_T_422 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[55], io_data_in[55]};
  wire [3:0]   _logical_T_419 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[54], io_data_in[54]};
  wire [3:0]   _logical_T_416 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[53], io_data_in[53]};
  wire [3:0]   _logical_T_413 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[52], io_data_in[52]};
  wire [3:0]   _logical_T_410 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[51], io_data_in[51]};
  wire [3:0]   _logical_T_407 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[50], io_data_in[50]};
  wire [3:0]   _logical_T_404 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[49], io_data_in[49]};
  wire [3:0]   _logical_T_401 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[48], io_data_in[48]};
  always @(*) begin
    casez (io_a_mask[6] ? select : 2'h0)
      2'b00:
        casez_tmp_6 = io_data_in[55:48];
      2'b01:
        casez_tmp_6 = io_a_data[55:48];
      2'b10:
        casez_tmp_6 = _sum_T_50[55:48];
      default:
        casez_tmp_6 = {_logical_T_422[0], _logical_T_419[0], _logical_T_416[0], _logical_T_413[0], _logical_T_410[0], _logical_T_407[0], _logical_T_404[0], _logical_T_401[0]};
    endcase
  end // always @(*)
  wire [3:0]   _logical_T_494 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[79], io_data_in[79]};
  wire [3:0]   _logical_T_491 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[78], io_data_in[78]};
  wire [3:0]   _logical_T_488 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[77], io_data_in[77]};
  wire [3:0]   _logical_T_485 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[76], io_data_in[76]};
  wire [3:0]   _logical_T_482 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[75], io_data_in[75]};
  wire [3:0]   _logical_T_479 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[74], io_data_in[74]};
  wire [3:0]   _logical_T_476 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[73], io_data_in[73]};
  wire [3:0]   _logical_T_473 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[72], io_data_in[72]};
  always @(*) begin
    casez (io_a_mask[9] ? select : 2'h0)
      2'b00:
        casez_tmp_7 = io_data_in[79:72];
      2'b01:
        casez_tmp_7 = io_a_data[79:72];
      2'b10:
        casez_tmp_7 = _sum_T_50[79:72];
      default:
        casez_tmp_7 = {_logical_T_494[0], _logical_T_491[0], _logical_T_488[0], _logical_T_485[0], _logical_T_482[0], _logical_T_479[0], _logical_T_476[0], _logical_T_473[0]};
    endcase
  end // always @(*)
  wire [3:0]   _logical_T_470 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[71], io_data_in[71]};
  wire [3:0]   _logical_T_467 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[70], io_data_in[70]};
  wire [3:0]   _logical_T_464 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[69], io_data_in[69]};
  wire [3:0]   _logical_T_461 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[68], io_data_in[68]};
  wire [3:0]   _logical_T_458 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[67], io_data_in[67]};
  wire [3:0]   _logical_T_455 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[66], io_data_in[66]};
  wire [3:0]   _logical_T_452 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[65], io_data_in[65]};
  wire [3:0]   _logical_T_449 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[64], io_data_in[64]};
  always @(*) begin
    casez (io_a_mask[8] ? select : 2'h0)
      2'b00:
        casez_tmp_8 = io_data_in[71:64];
      2'b01:
        casez_tmp_8 = io_a_data[71:64];
      2'b10:
        casez_tmp_8 = _sum_T_50[71:64];
      default:
        casez_tmp_8 = {_logical_T_470[0], _logical_T_467[0], _logical_T_464[0], _logical_T_461[0], _logical_T_458[0], _logical_T_455[0], _logical_T_452[0], _logical_T_449[0]};
    endcase
  end // always @(*)
  wire [3:0]   _logical_T_542 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[95], io_data_in[95]};
  wire [3:0]   _logical_T_539 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[94], io_data_in[94]};
  wire [3:0]   _logical_T_536 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[93], io_data_in[93]};
  wire [3:0]   _logical_T_533 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[92], io_data_in[92]};
  wire [3:0]   _logical_T_530 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[91], io_data_in[91]};
  wire [3:0]   _logical_T_527 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[90], io_data_in[90]};
  wire [3:0]   _logical_T_524 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[89], io_data_in[89]};
  wire [3:0]   _logical_T_521 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[88], io_data_in[88]};
  always @(*) begin
    casez (io_a_mask[11] ? select : 2'h0)
      2'b00:
        casez_tmp_9 = io_data_in[95:88];
      2'b01:
        casez_tmp_9 = io_a_data[95:88];
      2'b10:
        casez_tmp_9 = _sum_T_50[95:88];
      default:
        casez_tmp_9 = {_logical_T_542[0], _logical_T_539[0], _logical_T_536[0], _logical_T_533[0], _logical_T_530[0], _logical_T_527[0], _logical_T_524[0], _logical_T_521[0]};
    endcase
  end // always @(*)
  wire [3:0]   _logical_T_518 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[87], io_data_in[87]};
  wire [3:0]   _logical_T_515 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[86], io_data_in[86]};
  wire [3:0]   _logical_T_512 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[85], io_data_in[85]};
  wire [3:0]   _logical_T_509 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[84], io_data_in[84]};
  wire [3:0]   _logical_T_506 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[83], io_data_in[83]};
  wire [3:0]   _logical_T_503 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[82], io_data_in[82]};
  wire [3:0]   _logical_T_500 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[81], io_data_in[81]};
  wire [3:0]   _logical_T_497 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[80], io_data_in[80]};
  always @(*) begin
    casez (io_a_mask[10] ? select : 2'h0)
      2'b00:
        casez_tmp_10 = io_data_in[87:80];
      2'b01:
        casez_tmp_10 = io_a_data[87:80];
      2'b10:
        casez_tmp_10 = _sum_T_50[87:80];
      default:
        casez_tmp_10 = {_logical_T_518[0], _logical_T_515[0], _logical_T_512[0], _logical_T_509[0], _logical_T_506[0], _logical_T_503[0], _logical_T_500[0], _logical_T_497[0]};
    endcase
  end // always @(*)
  wire [3:0]   _logical_T_590 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[111], io_data_in[111]};
  wire [3:0]   _logical_T_587 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[110], io_data_in[110]};
  wire [3:0]   _logical_T_584 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[109], io_data_in[109]};
  wire [3:0]   _logical_T_581 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[108], io_data_in[108]};
  wire [3:0]   _logical_T_578 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[107], io_data_in[107]};
  wire [3:0]   _logical_T_575 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[106], io_data_in[106]};
  wire [3:0]   _logical_T_572 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[105], io_data_in[105]};
  wire [3:0]   _logical_T_569 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[104], io_data_in[104]};
  always @(*) begin
    casez (io_a_mask[13] ? select : 2'h0)
      2'b00:
        casez_tmp_11 = io_data_in[111:104];
      2'b01:
        casez_tmp_11 = io_a_data[111:104];
      2'b10:
        casez_tmp_11 = _sum_T_50[111:104];
      default:
        casez_tmp_11 = {_logical_T_590[0], _logical_T_587[0], _logical_T_584[0], _logical_T_581[0], _logical_T_578[0], _logical_T_575[0], _logical_T_572[0], _logical_T_569[0]};
    endcase
  end // always @(*)
  wire [3:0]   _logical_T_566 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[103], io_data_in[103]};
  wire [3:0]   _logical_T_563 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[102], io_data_in[102]};
  wire [3:0]   _logical_T_560 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[101], io_data_in[101]};
  wire [3:0]   _logical_T_557 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[100], io_data_in[100]};
  wire [3:0]   _logical_T_554 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[99], io_data_in[99]};
  wire [3:0]   _logical_T_551 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[98], io_data_in[98]};
  wire [3:0]   _logical_T_548 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[97], io_data_in[97]};
  wire [3:0]   _logical_T_545 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[96], io_data_in[96]};
  always @(*) begin
    casez (io_a_mask[12] ? select : 2'h0)
      2'b00:
        casez_tmp_12 = io_data_in[103:96];
      2'b01:
        casez_tmp_12 = io_a_data[103:96];
      2'b10:
        casez_tmp_12 = _sum_T_50[103:96];
      default:
        casez_tmp_12 = {_logical_T_566[0], _logical_T_563[0], _logical_T_560[0], _logical_T_557[0], _logical_T_554[0], _logical_T_551[0], _logical_T_548[0], _logical_T_545[0]};
    endcase
  end // always @(*)
  wire [3:0]   _logical_T_638 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[127], io_data_in[127]};
  wire [3:0]   _logical_T_635 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[126], io_data_in[126]};
  wire [3:0]   _logical_T_632 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[125], io_data_in[125]};
  wire [3:0]   _logical_T_629 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[124], io_data_in[124]};
  wire [3:0]   _logical_T_626 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[123], io_data_in[123]};
  wire [3:0]   _logical_T_623 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[122], io_data_in[122]};
  wire [3:0]   _logical_T_620 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[121], io_data_in[121]};
  wire [3:0]   _logical_T_617 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[120], io_data_in[120]};
  always @(*) begin
    casez (io_a_mask[15] ? select : 2'h0)
      2'b00:
        casez_tmp_13 = io_data_in[127:120];
      2'b01:
        casez_tmp_13 = io_a_data[127:120];
      2'b10:
        casez_tmp_13 = _sum_T_50[127:120];
      default:
        casez_tmp_13 = {_logical_T_638[0], _logical_T_635[0], _logical_T_632[0], _logical_T_629[0], _logical_T_626[0], _logical_T_623[0], _logical_T_620[0], _logical_T_617[0]};
    endcase
  end // always @(*)
  wire [3:0]   _logical_T_614 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[119], io_data_in[119]};
  wire [3:0]   _logical_T_611 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[118], io_data_in[118]};
  wire [3:0]   _logical_T_608 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[117], io_data_in[117]};
  wire [3:0]   _logical_T_605 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[116], io_data_in[116]};
  wire [3:0]   _logical_T_602 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[115], io_data_in[115]};
  wire [3:0]   _logical_T_599 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[114], io_data_in[114]};
  wire [3:0]   _logical_T_596 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[113], io_data_in[113]};
  wire [3:0]   _logical_T_593 = _lut_WIRE_lut_T_126 >> {2'h0, io_a_data[112], io_data_in[112]};
  always @(*) begin
    casez (io_a_mask[14] ? select : 2'h0)
      2'b00:
        casez_tmp_14 = io_data_in[119:112];
      2'b01:
        casez_tmp_14 = io_a_data[119:112];
      2'b10:
        casez_tmp_14 = _sum_T_50[119:112];
      default:
        casez_tmp_14 = {_logical_T_614[0], _logical_T_611[0], _logical_T_608[0], _logical_T_605[0], _logical_T_602[0], _logical_T_599[0], _logical_T_596[0], _logical_T_593[0]};
    endcase
  end // always @(*)
  assign io_data_out = {casez_tmp_13, casez_tmp_14, casez_tmp_11, casez_tmp_12, casez_tmp_9, casez_tmp_10, casez_tmp_7, casez_tmp_8, casez_tmp_5, casez_tmp_6, casez_tmp_3, casez_tmp_4, casez_tmp_1, casez_tmp_2, casez_tmp, casez_tmp_0};
endmodule

