// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module UOPCodeFDivDecoder(
  input  [6:0] io_uopc,
  output [1:0] io_sigs_typeTagIn,
  output       io_sigs_div,
               io_sigs_sqrt
);

  wire [4:0] decoder_decoded_invInputs = ~(io_uopc[4:0]);
  wire [6:0] _decoder_decoded_T_2 = {decoder_decoded_invInputs[0], io_uopc[1], io_uopc[2], decoder_decoded_invInputs[3], decoder_decoded_invInputs[4], io_uopc[5], io_uopc[6]};
  wire [3:0] _decoder_decoded_T_6 = {io_uopc[3], decoder_decoded_invInputs[4], io_uopc[5], io_uopc[6]};
  assign io_sigs_typeTagIn = {1'h0, |{&_decoder_decoded_T_2, &_decoder_decoded_T_6}};
  assign io_sigs_div = |{&{decoder_decoded_invInputs[1], io_uopc[2], decoder_decoded_invInputs[3], decoder_decoded_invInputs[4], io_uopc[5], io_uopc[6]}, &_decoder_decoded_T_2};
  assign io_sigs_sqrt = |{&{io_uopc[0], io_uopc[1], io_uopc[2], decoder_decoded_invInputs[3], decoder_decoded_invInputs[4], io_uopc[5], io_uopc[6]}, &_decoder_decoded_T_6};
endmodule

