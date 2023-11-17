// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

// external module plusarg_reader

// external module plusarg_reader

// external module plusarg_reader

// external module GenericDigitalOutIOCell

// external module GenericDigitalInIOCell

// external module EICG_wrapper

// external module plusarg_reader

// external module SimJTAG

// external module plusarg_reader

// external module SimTSI

// external module SimDRAM

// external module SimUART

// external module ClockSourceAtFreqMHz

// external module ClockSourceAtFreqMHz

