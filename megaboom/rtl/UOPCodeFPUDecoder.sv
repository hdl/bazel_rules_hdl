// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module UOPCodeFPUDecoder(
  input  [6:0] io_uopc,
  output       io_sigs_ren2,
               io_sigs_ren3,
               io_sigs_swap23,
  output [1:0] io_sigs_typeTagIn,
               io_sigs_typeTagOut,
  output       io_sigs_fromint,
               io_sigs_toint,
               io_sigs_fastpipe,
               io_sigs_fma,
               io_sigs_wflags
);

  wire [5:0] decoder_decoded_invInputs = ~(io_uopc[5:0]);
  wire [4:0] _decoder_decoded_T_6 = {io_uopc[0], io_uopc[2], decoder_decoded_invInputs[4], decoder_decoded_invInputs[5], io_uopc[6]};
  wire [3:0] _decoder_decoded_T_28 = {decoder_decoded_invInputs[1], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]};
  wire [4:0] _decoder_decoded_T_44 = {io_uopc[0], io_uopc[2], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]};
  wire [3:0] _decoder_decoded_T_50 = {io_uopc[3], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]};
  wire [5:0] _decoder_decoded_T_54 = {io_uopc[1], decoder_decoded_invInputs[2], io_uopc[3], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]};
  wire [6:0] _decoder_decoded_T_56 = {decoder_decoded_invInputs[0], decoder_decoded_invInputs[1], io_uopc[2], io_uopc[3], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]};
  wire [5:0] _decoder_decoded_T_62 = {decoder_decoded_invInputs[0], decoder_decoded_invInputs[1], decoder_decoded_invInputs[3], decoder_decoded_invInputs[4], io_uopc[5], io_uopc[6]};
  wire [4:0] _decoder_decoded_T_64 = {decoder_decoded_invInputs[2], decoder_decoded_invInputs[3], decoder_decoded_invInputs[4], io_uopc[5], io_uopc[6]};
  wire [5:0] _decoder_decoded_T_66 = {io_uopc[0], decoder_decoded_invInputs[2], decoder_decoded_invInputs[3], decoder_decoded_invInputs[4], io_uopc[5], io_uopc[6]};
  wire [5:0] _decoder_decoded_T_68 = {io_uopc[1], decoder_decoded_invInputs[2], decoder_decoded_invInputs[3], decoder_decoded_invInputs[4], io_uopc[5], io_uopc[6]};
  assign io_sigs_ren2 = |{&{decoder_decoded_invInputs[1], decoder_decoded_invInputs[2], io_uopc[3], decoder_decoded_invInputs[5], io_uopc[6]}, &_decoder_decoded_T_28, &_decoder_decoded_T_44, &_decoder_decoded_T_50, &_decoder_decoded_T_62, &_decoder_decoded_T_64};
  assign io_sigs_ren3 = |{&{io_uopc[0], io_uopc[2], io_uopc[3], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]}, &{io_uopc[1], io_uopc[2], io_uopc[3], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]}, &_decoder_decoded_T_62, &_decoder_decoded_T_64};
  assign io_sigs_swap23 = |{&{io_uopc[0], io_uopc[1], io_uopc[2], decoder_decoded_invInputs[3], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]}, &{decoder_decoded_invInputs[0], decoder_decoded_invInputs[2], io_uopc[3], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]}, &_decoder_decoded_T_54};
  assign io_sigs_typeTagIn = {1'h0, |{&_decoder_decoded_T_6, &{io_uopc[1], io_uopc[2], decoder_decoded_invInputs[3], decoder_decoded_invInputs[4], decoder_decoded_invInputs[5], io_uopc[6]}, &{io_uopc[0], decoder_decoded_invInputs[1], io_uopc[3], decoder_decoded_invInputs[4], decoder_decoded_invInputs[5], io_uopc[6]}, &{decoder_decoded_invInputs[0], io_uopc[1], decoder_decoded_invInputs[2], io_uopc[3], decoder_decoded_invInputs[5], io_uopc[6]}, &{io_uopc[0], decoder_decoded_invInputs[1], decoder_decoded_invInputs[3], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]}, &{io_uopc[0], io_uopc[1], decoder_decoded_invInputs[2], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]}, &_decoder_decoded_T_56, &_decoder_decoded_T_66, &_decoder_decoded_T_68, &{decoder_decoded_invInputs[0], decoder_decoded_invInputs[1], io_uopc[2], decoder_decoded_invInputs[3], decoder_decoded_invInputs[4], io_uopc[5], io_uopc[6]}}};
  assign io_sigs_typeTagOut = {1'h0, |{&{decoder_decoded_invInputs[0], decoder_decoded_invInputs[1], io_uopc[2], decoder_decoded_invInputs[3], decoder_decoded_invInputs[4], io_uopc[6]}, &{io_uopc[0], decoder_decoded_invInputs[1], io_uopc[2], decoder_decoded_invInputs[3], decoder_decoded_invInputs[5], io_uopc[6]}, &_decoder_decoded_T_6, &{io_uopc[0], io_uopc[3], decoder_decoded_invInputs[4], decoder_decoded_invInputs[5], io_uopc[6]}, &{io_uopc[0], decoder_decoded_invInputs[2], decoder_decoded_invInputs[3], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]}, &_decoder_decoded_T_54, &_decoder_decoded_T_56, &_decoder_decoded_T_66, &_decoder_decoded_T_68}};
  assign io_sigs_fromint = &{decoder_decoded_invInputs[1], io_uopc[2], decoder_decoded_invInputs[4], decoder_decoded_invInputs[5], io_uopc[6]};
  assign io_sigs_toint = |{&{io_uopc[1], io_uopc[2], decoder_decoded_invInputs[4], decoder_decoded_invInputs[5], io_uopc[6]}, &{decoder_decoded_invInputs[2], decoder_decoded_invInputs[3], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]}};
  assign io_sigs_fastpipe = |{&{decoder_decoded_invInputs[2], io_uopc[3], decoder_decoded_invInputs[4], decoder_decoded_invInputs[5], io_uopc[6]}, &{decoder_decoded_invInputs[1], io_uopc[2], decoder_decoded_invInputs[3], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]}};
  assign io_sigs_fma = |{&{io_uopc[0], io_uopc[1], io_uopc[2], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]}, &_decoder_decoded_T_50, &_decoder_decoded_T_62, &_decoder_decoded_T_64};
  assign io_sigs_wflags = |{&{io_uopc[1], io_uopc[3], decoder_decoded_invInputs[5], io_uopc[6]}, &{io_uopc[2], io_uopc[3], decoder_decoded_invInputs[5], io_uopc[6]}, &_decoder_decoded_T_28, &_decoder_decoded_T_44, &_decoder_decoded_T_62, &_decoder_decoded_T_64};
endmodule

