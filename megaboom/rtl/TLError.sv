// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLError(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
  input  [3:0]  auto_in_a_bits_size,
  input  [6:0]  auto_in_a_bits_source,
  input  [13:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input         auto_in_a_bits_corrupt,
                auto_in_d_ready,
  output        auto_in_a_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
  output [3:0]  auto_in_d_bits_size,
  output [6:0]  auto_in_d_bits_source,
  output        auto_in_d_bits_corrupt
);

  wire        _a_q_io_enq_ready;
  wire        _a_q_io_deq_valid;
  wire [2:0]  _a_q_io_deq_bits_opcode;
  wire [3:0]  _a_q_io_deq_bits_size;
  wire [6:0]  _a_q_io_deq_bits_source;
  wire [26:0] _GEN = {23'h0, _a_q_io_deq_bits_size};
  wire [26:0] _a_last_beats1_decode_T_1 = 27'hFFF << _GEN;
  reg  [8:0]  a_last_counter;
  wire        a_last = a_last_counter == 9'h1 | (_a_q_io_deq_bits_opcode[2] ? 9'h0 : ~(_a_last_beats1_decode_T_1[11:3])) == 9'h0;
  wire        da_valid = _a_q_io_deq_valid & a_last;
  wire [26:0] _beats1_decode_T_1 = 27'hFFF << _GEN;
  wire [2:0]  da_bits_opcode = (&_a_q_io_deq_bits_opcode) | _a_q_io_deq_bits_opcode == 3'h6 ? 3'h4 : _a_q_io_deq_bits_opcode == 3'h5 ? 3'h2 : {2'h0, _a_q_io_deq_bits_opcode == 3'h4 | _a_q_io_deq_bits_opcode == 3'h3 | _a_q_io_deq_bits_opcode == 3'h2};
  reg  [8:0]  counter;
  wire        _q_io_deq_ready_T_3 = auto_in_d_ready & (counter == 9'h1 | (da_bits_opcode[0] ? ~(_beats1_decode_T_1[11:3]) : 9'h0) == 9'h0) | ~a_last;
  always @(posedge clock) begin
    if (reset) begin
      a_last_counter <= 9'h0;
      counter <= 9'h0;
    end
    else begin
      if (_q_io_deq_ready_T_3 & _a_q_io_deq_valid) begin
        if (a_last_counter == 9'h0) begin
          if (_a_q_io_deq_bits_opcode[2])
            a_last_counter <= 9'h0;
          else
            a_last_counter <= ~(_a_last_beats1_decode_T_1[11:3]);
        end
        else
          a_last_counter <= a_last_counter - 9'h1;
      end
      if (auto_in_d_ready & da_valid) begin
        if (counter == 9'h0) begin
          if (da_bits_opcode[0])
            counter <= ~(_beats1_decode_T_1[11:3]);
          else
            counter <= 9'h0;
        end
        else
          counter <= counter - 9'h1;
      end
    end
  end // always @(posedge)
  Queue_10 a_q (
    .clock              (clock),
    .reset              (reset),
    .io_enq_valid       (auto_in_a_valid),
    .io_enq_bits_opcode (auto_in_a_bits_opcode),
    .io_enq_bits_size   (auto_in_a_bits_size),
    .io_enq_bits_source (auto_in_a_bits_source),
    .io_deq_ready       (_q_io_deq_ready_T_3),
    .io_enq_ready       (_a_q_io_enq_ready),
    .io_deq_valid       (_a_q_io_deq_valid),
    .io_deq_bits_opcode (_a_q_io_deq_bits_opcode),
    .io_deq_bits_size   (_a_q_io_deq_bits_size),
    .io_deq_bits_source (_a_q_io_deq_bits_source)
  );
  assign auto_in_a_ready = _a_q_io_enq_ready;
  assign auto_in_d_valid = da_valid;
  assign auto_in_d_bits_opcode = da_bits_opcode;
  assign auto_in_d_bits_size = _a_q_io_deq_bits_size;
  assign auto_in_d_bits_source = _a_q_io_deq_bits_source;
  assign auto_in_d_bits_corrupt = da_bits_opcode[0];
endmodule

