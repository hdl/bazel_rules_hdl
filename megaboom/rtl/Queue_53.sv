// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_53(
  input         clock,
                reset,
                io_enq_valid,
  input  [2:0]  io_enq_bits_opcode,
                io_enq_bits_param,
  input  [3:0]  io_enq_bits_source,
  input  [31:0] io_enq_bits_address,
  input  [63:0] io_enq_bits_data,
  input         io_deq_ready,
  output        io_enq_ready,
                io_deq_valid,
  output [2:0]  io_deq_bits_opcode,
                io_deq_bits_param,
                io_deq_bits_size,
  output [3:0]  io_deq_bits_source,
  output [31:0] io_deq_bits_address,
  output [63:0] io_deq_bits_data,
  output        io_deq_bits_corrupt,
  output [3:0]  io_count
);

  reg  [3:0] enq_ptr_value;
  reg  [3:0] deq_ptr_value;
  reg        maybe_full;
  wire       ptr_match = enq_ptr_value == deq_ptr_value;
  wire       empty = ptr_match & ~maybe_full;
  wire       full = ptr_match & maybe_full;
  wire       do_enq = ~full & io_enq_valid;
  wire [3:0] _ptr_diff_T = enq_ptr_value - deq_ptr_value;
  wire       do_deq = io_deq_ready & ~empty;
  always @(posedge clock) begin
    if (reset) begin
      enq_ptr_value <= 4'h0;
      deq_ptr_value <= 4'h0;
      maybe_full <= 1'h0;
    end
    else begin
      if (do_enq) begin
        if (enq_ptr_value == 4'hB)
          enq_ptr_value <= 4'h0;
        else
          enq_ptr_value <= enq_ptr_value + 4'h1;
      end
      if (do_deq) begin
        if (deq_ptr_value == 4'hB)
          deq_ptr_value <= 4'h0;
        else
          deq_ptr_value <= deq_ptr_value + 4'h1;
      end
      if (do_enq != do_deq)
        maybe_full <= do_enq;
    end
  end // always @(posedge)
  ram_12x3 ram_opcode_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_opcode),
    .R0_data (io_deq_bits_opcode)
  );
  ram_12x3 ram_param_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_param),
    .R0_data (io_deq_bits_param)
  );
  ram_12x3 ram_size_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (3'h6),
    .R0_data (io_deq_bits_size)
  );
  ram_source_12x4 ram_source_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_source),
    .R0_data (io_deq_bits_source)
  );
  ram_address_12x32 ram_address_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_address),
    .R0_data (io_deq_bits_address)
  );
  ram_data_12x64 ram_data_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_data),
    .R0_data (io_deq_bits_data)
  );
  ram_corrupt_12x1 ram_corrupt_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (1'h0),
    .R0_data (io_deq_bits_corrupt)
  );
  assign io_enq_ready = ~full;
  assign io_deq_valid = ~empty;
  assign io_count = ptr_match ? (maybe_full ? 4'hC : 4'h0) : deq_ptr_value > enq_ptr_value ? _ptr_diff_T - 4'h4 : _ptr_diff_T;
endmodule

