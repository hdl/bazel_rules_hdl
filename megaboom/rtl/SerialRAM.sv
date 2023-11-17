// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module SerialRAM(
  input         clock,
                reset,
                io_ser_in_ready,
                io_ser_out_valid,
  input  [31:0] io_ser_out_bits,
  input         io_tsi_in_valid,
  input  [31:0] io_tsi_in_bits,
  input         io_tsi_out_ready,
  output        io_ser_in_valid,
  output [31:0] io_ser_in_bits,
  output        io_ser_out_ready,
                io_tsi_in_ready,
                io_tsi_out_valid,
  output [31:0] io_tsi_out_bits
);

  wire        _buffer_auto_in_a_ready;
  wire        _buffer_auto_in_d_valid;
  wire [63:0] _buffer_auto_in_d_bits_data;
  wire        _buffer_auto_out_a_valid;
  wire [2:0]  _buffer_auto_out_a_bits_opcode;
  wire [2:0]  _buffer_auto_out_a_bits_param;
  wire [3:0]  _buffer_auto_out_a_bits_size;
  wire        _buffer_auto_out_a_bits_source;
  wire [31:0] _buffer_auto_out_a_bits_address;
  wire [7:0]  _buffer_auto_out_a_bits_mask;
  wire [63:0] _buffer_auto_out_a_bits_data;
  wire        _buffer_auto_out_a_bits_corrupt;
  wire        _buffer_auto_out_d_ready;
  wire        _serdesser_auto_manager_in_a_ready;
  wire        _serdesser_auto_manager_in_d_valid;
  wire [2:0]  _serdesser_auto_manager_in_d_bits_opcode;
  wire [1:0]  _serdesser_auto_manager_in_d_bits_param;
  wire [3:0]  _serdesser_auto_manager_in_d_bits_size;
  wire        _serdesser_auto_manager_in_d_bits_source;
  wire [3:0]  _serdesser_auto_manager_in_d_bits_sink;
  wire        _serdesser_auto_manager_in_d_bits_denied;
  wire [63:0] _serdesser_auto_manager_in_d_bits_data;
  wire        _serdesser_auto_manager_in_d_bits_corrupt;
  wire        _tsi2tl_auto_out_a_valid;
  wire [2:0]  _tsi2tl_auto_out_a_bits_opcode;
  wire [3:0]  _tsi2tl_auto_out_a_bits_size;
  wire [31:0] _tsi2tl_auto_out_a_bits_address;
  wire [7:0]  _tsi2tl_auto_out_a_bits_mask;
  wire [63:0] _tsi2tl_auto_out_a_bits_data;
  wire        _tsi2tl_auto_out_d_ready;
  TSIToTileLink tsi2tl (
    .clock                   (clock),
    .reset                   (reset),
    .auto_out_a_ready        (_buffer_auto_in_a_ready),
    .auto_out_d_valid        (_buffer_auto_in_d_valid),
    .auto_out_d_bits_data    (_buffer_auto_in_d_bits_data),
    .io_tsi_in_valid         (io_tsi_in_valid),
    .io_tsi_in_bits          (io_tsi_in_bits),
    .io_tsi_out_ready        (io_tsi_out_ready),
    .auto_out_a_valid        (_tsi2tl_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_tsi2tl_auto_out_a_bits_opcode),
    .auto_out_a_bits_size    (_tsi2tl_auto_out_a_bits_size),
    .auto_out_a_bits_address (_tsi2tl_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_tsi2tl_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_tsi2tl_auto_out_a_bits_data),
    .auto_out_d_ready        (_tsi2tl_auto_out_d_ready),
    .io_tsi_in_ready         (io_tsi_in_ready),
    .io_tsi_out_valid        (io_tsi_out_valid),
    .io_tsi_out_bits         (io_tsi_out_bits)
  );
  TLSerdesser_1 serdesser (
    .clock                          (clock),
    .reset                          (reset),
    .auto_manager_in_a_valid        (_buffer_auto_out_a_valid),
    .auto_manager_in_a_bits_opcode  (_buffer_auto_out_a_bits_opcode),
    .auto_manager_in_a_bits_param   (_buffer_auto_out_a_bits_param),
    .auto_manager_in_a_bits_size    (_buffer_auto_out_a_bits_size),
    .auto_manager_in_a_bits_source  (_buffer_auto_out_a_bits_source),
    .auto_manager_in_a_bits_address (_buffer_auto_out_a_bits_address),
    .auto_manager_in_a_bits_mask    (_buffer_auto_out_a_bits_mask),
    .auto_manager_in_a_bits_data    (_buffer_auto_out_a_bits_data),
    .auto_manager_in_a_bits_corrupt (_buffer_auto_out_a_bits_corrupt),
    .auto_manager_in_d_ready        (_buffer_auto_out_d_ready),
    .io_ser_in_valid                (io_ser_out_valid),
    .io_ser_in_bits                 (io_ser_out_bits),
    .io_ser_out_ready               (io_ser_in_ready),
    .auto_manager_in_a_ready        (_serdesser_auto_manager_in_a_ready),
    .auto_manager_in_d_valid        (_serdesser_auto_manager_in_d_valid),
    .auto_manager_in_d_bits_opcode  (_serdesser_auto_manager_in_d_bits_opcode),
    .auto_manager_in_d_bits_param   (_serdesser_auto_manager_in_d_bits_param),
    .auto_manager_in_d_bits_size    (_serdesser_auto_manager_in_d_bits_size),
    .auto_manager_in_d_bits_source  (_serdesser_auto_manager_in_d_bits_source),
    .auto_manager_in_d_bits_sink    (_serdesser_auto_manager_in_d_bits_sink),
    .auto_manager_in_d_bits_denied  (_serdesser_auto_manager_in_d_bits_denied),
    .auto_manager_in_d_bits_data    (_serdesser_auto_manager_in_d_bits_data),
    .auto_manager_in_d_bits_corrupt (_serdesser_auto_manager_in_d_bits_corrupt),
    .io_ser_in_ready                (io_ser_out_ready),
    .io_ser_out_valid               (io_ser_in_valid),
    .io_ser_out_bits                (io_ser_in_bits)
  );
  TLBuffer_18 buffer (
    .clock                   (clock),
    .reset                   (reset),
    .auto_in_a_valid         (_tsi2tl_auto_out_a_valid),
    .auto_in_a_bits_opcode   (_tsi2tl_auto_out_a_bits_opcode),
    .auto_in_a_bits_size     (_tsi2tl_auto_out_a_bits_size),
    .auto_in_a_bits_address  (_tsi2tl_auto_out_a_bits_address),
    .auto_in_a_bits_mask     (_tsi2tl_auto_out_a_bits_mask),
    .auto_in_a_bits_data     (_tsi2tl_auto_out_a_bits_data),
    .auto_in_d_ready         (_tsi2tl_auto_out_d_ready),
    .auto_out_a_ready        (_serdesser_auto_manager_in_a_ready),
    .auto_out_d_valid        (_serdesser_auto_manager_in_d_valid),
    .auto_out_d_bits_opcode  (_serdesser_auto_manager_in_d_bits_opcode),
    .auto_out_d_bits_param   (_serdesser_auto_manager_in_d_bits_param),
    .auto_out_d_bits_size    (_serdesser_auto_manager_in_d_bits_size),
    .auto_out_d_bits_source  (_serdesser_auto_manager_in_d_bits_source),
    .auto_out_d_bits_sink    (_serdesser_auto_manager_in_d_bits_sink),
    .auto_out_d_bits_denied  (_serdesser_auto_manager_in_d_bits_denied),
    .auto_out_d_bits_data    (_serdesser_auto_manager_in_d_bits_data),
    .auto_out_d_bits_corrupt (_serdesser_auto_manager_in_d_bits_corrupt),
    .auto_in_a_ready         (_buffer_auto_in_a_ready),
    .auto_in_d_valid         (_buffer_auto_in_d_valid),
    .auto_in_d_bits_data     (_buffer_auto_in_d_bits_data),
    .auto_out_a_valid        (_buffer_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_buffer_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_buffer_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_buffer_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_buffer_auto_out_a_bits_source),
    .auto_out_a_bits_address (_buffer_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_buffer_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_buffer_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_buffer_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_buffer_auto_out_d_ready)
  );
endmodule

