// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

// VCS coverage exclude_file
module IDPool_assert(
  input [7:0] _GEN,
              bitmap,
              _bitmap1_T,
  input       io_free_valid,
              valid,
              _valid1_T,
  input [2:0] select,
  input       _valid1_T_1,
              _valid1_T_2,
              _valid1_T_3,
              _valid1_T_4,
              _valid1_T_5,
              _valid1_T_6,
              _valid1_T_7,
              reset,
              clock,
              _GEN_0
);

  wire [7:0] _GEN_1 = (bitmap & _bitmap1_T) >> _GEN;
  wire       _GEN_2 = ~io_free_valid | ~(_GEN_1[0]);
  wire       _GEN_3 = valid == _valid1_T;
  reg        REG;
  wire       _GEN_4 = select == (_valid1_T_1 ? 3'h0 : _valid1_T_2 ? 3'h1 : _valid1_T_3 ? 3'h2 : _valid1_T_4 ? 3'h3 : _valid1_T_5 ? 3'h4 : _valid1_T_6 ? 3'h5 : {2'h3, ~_valid1_T_7});
  wire       _GEN_5 = valid & REG & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN_2)
        $fwrite(32'h80000002, "Assertion failed\n    at IDPool.scala:44 assert (!io.free.valid || !(bitmap & ~taken)(io.free.bits))\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_3)
        $fwrite(32'h80000002, "Assertion failed\n    at IDPool.scala:48 assert (valid === bitmap.orR)\n");
      if ((`PRINTF_COND_) & _GEN_5 & ~_GEN_4)
        $fwrite(32'h80000002, "Assertion failed\n    at IDPool.scala:52 assert (select === PriorityEncoder(bitmap))\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(_GEN_2);
      assert__assert_1: assert(_GEN_3);
    end
    if (_GEN_5)
      assert__assert_2: assert(_GEN_4);
    REG <= _GEN_0;
  end // always @(posedge)
endmodule

