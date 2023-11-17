// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module FMADecoder(
  input  [6:0] io_uopc,
  output [1:0] io_cmd
);

  wire [5:0] decoder_decoded_invInputs = ~(io_uopc[5:0]);
  assign io_cmd = {|{&{io_uopc[0], io_uopc[1], io_uopc[2], io_uopc[3], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]}, &{decoder_decoded_invInputs[0], decoder_decoded_invInputs[1], decoder_decoded_invInputs[3], decoder_decoded_invInputs[4], io_uopc[5], io_uopc[6]}, &{io_uopc[0], io_uopc[1], decoder_decoded_invInputs[2], decoder_decoded_invInputs[3], decoder_decoded_invInputs[4], io_uopc[5], io_uopc[6]}}, |{&{decoder_decoded_invInputs[0], decoder_decoded_invInputs[1], decoder_decoded_invInputs[2], io_uopc[3], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]}, &{io_uopc[0], io_uopc[1], io_uopc[3], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]}, &{io_uopc[1], io_uopc[2], io_uopc[3], io_uopc[4], decoder_decoded_invInputs[5], io_uopc[6]}, &{io_uopc[1], decoder_decoded_invInputs[2], decoder_decoded_invInputs[3], decoder_decoded_invInputs[4], io_uopc[5], io_uopc[6]}}};
endmodule

