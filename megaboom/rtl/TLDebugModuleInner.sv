// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLDebugModuleInner(
  input         clock,
                reset,
                auto_tl_in_a_valid,
  input  [2:0]  auto_tl_in_a_bits_opcode,
                auto_tl_in_a_bits_param,
  input  [1:0]  auto_tl_in_a_bits_size,
  input  [10:0] auto_tl_in_a_bits_source,
  input  [11:0] auto_tl_in_a_bits_address,
  input  [7:0]  auto_tl_in_a_bits_mask,
  input  [63:0] auto_tl_in_a_bits_data,
  input         auto_tl_in_a_bits_corrupt,
                auto_tl_in_d_ready,
                auto_dmi_in_a_valid,
  input  [2:0]  auto_dmi_in_a_bits_opcode,
                auto_dmi_in_a_bits_param,
  input  [1:0]  auto_dmi_in_a_bits_size,
  input         auto_dmi_in_a_bits_source,
  input  [8:0]  auto_dmi_in_a_bits_address,
  input  [3:0]  auto_dmi_in_a_bits_mask,
  input  [31:0] auto_dmi_in_a_bits_data,
  input         auto_dmi_in_a_bits_corrupt,
                auto_dmi_in_d_ready,
                io_dmactive,
                io_innerCtrl_valid,
                io_innerCtrl_bits_resumereq,
  input  [9:0]  io_innerCtrl_bits_hartsel,
  input         io_innerCtrl_bits_ackhavereset,
                io_innerCtrl_bits_hrmask_0,
                io_hartIsInReset_0,
  output        auto_tl_in_a_ready,
                auto_tl_in_d_valid,
  output [2:0]  auto_tl_in_d_bits_opcode,
  output [1:0]  auto_tl_in_d_bits_size,
  output [10:0] auto_tl_in_d_bits_source,
  output [63:0] auto_tl_in_d_bits_data,
  output        auto_dmi_in_a_ready,
                auto_dmi_in_d_valid,
  output [2:0]  auto_dmi_in_d_bits_opcode,
  output [1:0]  auto_dmi_in_d_bits_size,
  output        auto_dmi_in_d_bits_source,
  output [31:0] auto_dmi_in_d_bits_data,
  output        io_hgDebugInt_0
);

  wire        _hartIsInResetSync_0_debug_hartReset_0_io_q;
  reg  [63:0] casez_tmp;
  reg         haltedBitRegs;
  reg         resumeReqRegs;
  reg         haveResetBitRegs;
  reg         hrmaskReg_0;
  reg         hrDebugInt_0;
  wire        resumereq = io_innerCtrl_valid & io_innerCtrl_bits_resumereq;
  wire [31:0] _GEN = {31'h0, haltedBitRegs};
  reg  [4:0]  ABSTRACTCSReg_progbufsize;
  reg  [2:0]  ABSTRACTCSReg_cmderr;
  reg  [3:0]  ABSTRACTCSReg_datacount;
  wire        in_bits_read = auto_dmi_in_a_bits_opcode == 3'h4;
  reg  [1:0]  ctrlStateReg;
  wire        _GEN_0 = ctrlStateReg == 2'h1;
  reg  [7:0]  COMMANDReg_cmdtype;
  wire        commandRegIsAccessRegister = COMMANDReg_cmdtype == 8'h0;
  reg  [23:0] COMMANDReg_control;
  wire        _GEN_1 = ~(COMMANDReg_control[17]) | (|(COMMANDReg_control[15:12])) & COMMANDReg_control[15:0] < 16'h1020 & (COMMANDReg_control[22:20] == 3'h2 | COMMANDReg_control[22:20] == 3'h3);
  wire        commandRegIsUnsupported = ~commandRegIsAccessRegister | ~_GEN_1;
  wire        commandRegBadHaltResume = commandRegIsAccessRegister & _GEN_1 & ~haltedBitRegs;
  reg  [11:0] ABSTRACTAUTOReg_autoexecdata;
  reg  [15:0] ABSTRACTAUTOReg_autoexecprogbuf;
  wire        _GEN_2 = ctrlStateReg == 2'h2;
  wire        in_1_bits_read = auto_tl_in_a_bits_opcode == 3'h4;
  wire        _out_wofireMux_T_262 = auto_tl_in_a_valid & auto_tl_in_d_ready & ~in_1_bits_read;
  wire        out_woready_1_353 = _out_wofireMux_T_262 & auto_tl_in_a_bits_address[10:3] == 8'h21 & ~(auto_tl_in_a_bits_address[11]);
  wire [9:0]  _out_romask_T_664 = {{2{auto_tl_in_a_bits_mask[5]}}, {8{auto_tl_in_a_bits_mask[4]}}};
  wire        hartExceptionWrEn = out_woready_1_353 & (&_out_romask_T_664);
  reg  [7:0]  abstractDataMem_0;
  reg  [7:0]  abstractDataMem_1;
  reg  [7:0]  abstractDataMem_2;
  reg  [7:0]  abstractDataMem_3;
  reg  [7:0]  abstractDataMem_4;
  reg  [7:0]  abstractDataMem_5;
  reg  [7:0]  abstractDataMem_6;
  reg  [7:0]  abstractDataMem_7;
  reg  [7:0]  abstractDataMem_8;
  reg  [7:0]  abstractDataMem_9;
  reg  [7:0]  abstractDataMem_10;
  reg  [7:0]  abstractDataMem_11;
  reg  [7:0]  abstractDataMem_12;
  reg  [7:0]  abstractDataMem_13;
  reg  [7:0]  abstractDataMem_14;
  reg  [7:0]  abstractDataMem_15;
  reg  [7:0]  abstractDataMem_16;
  reg  [7:0]  abstractDataMem_17;
  reg  [7:0]  abstractDataMem_18;
  reg  [7:0]  abstractDataMem_19;
  reg  [7:0]  abstractDataMem_20;
  reg  [7:0]  abstractDataMem_21;
  reg  [7:0]  abstractDataMem_22;
  reg  [7:0]  abstractDataMem_23;
  reg  [7:0]  abstractDataMem_24;
  reg  [7:0]  abstractDataMem_25;
  reg  [7:0]  abstractDataMem_26;
  reg  [7:0]  abstractDataMem_27;
  reg  [7:0]  abstractDataMem_28;
  reg  [7:0]  abstractDataMem_29;
  reg  [7:0]  abstractDataMem_30;
  reg  [7:0]  abstractDataMem_31;
  reg  [7:0]  programBufferMem_0;
  reg  [7:0]  programBufferMem_1;
  reg  [7:0]  programBufferMem_2;
  reg  [7:0]  programBufferMem_3;
  reg  [7:0]  programBufferMem_4;
  reg  [7:0]  programBufferMem_5;
  reg  [7:0]  programBufferMem_6;
  reg  [7:0]  programBufferMem_7;
  reg  [7:0]  programBufferMem_8;
  reg  [7:0]  programBufferMem_9;
  reg  [7:0]  programBufferMem_10;
  reg  [7:0]  programBufferMem_11;
  reg  [7:0]  programBufferMem_12;
  reg  [7:0]  programBufferMem_13;
  reg  [7:0]  programBufferMem_14;
  reg  [7:0]  programBufferMem_15;
  reg  [7:0]  programBufferMem_16;
  reg  [7:0]  programBufferMem_17;
  reg  [7:0]  programBufferMem_18;
  reg  [7:0]  programBufferMem_19;
  reg  [7:0]  programBufferMem_20;
  reg  [7:0]  programBufferMem_21;
  reg  [7:0]  programBufferMem_22;
  reg  [7:0]  programBufferMem_23;
  reg  [7:0]  programBufferMem_24;
  reg  [7:0]  programBufferMem_25;
  reg  [7:0]  programBufferMem_26;
  reg  [7:0]  programBufferMem_27;
  reg  [7:0]  programBufferMem_28;
  reg  [7:0]  programBufferMem_29;
  reg  [7:0]  programBufferMem_30;
  reg  [7:0]  programBufferMem_31;
  reg  [7:0]  programBufferMem_32;
  reg  [7:0]  programBufferMem_33;
  reg  [7:0]  programBufferMem_34;
  reg  [7:0]  programBufferMem_35;
  reg  [7:0]  programBufferMem_36;
  reg  [7:0]  programBufferMem_37;
  reg  [7:0]  programBufferMem_38;
  reg  [7:0]  programBufferMem_39;
  reg  [7:0]  programBufferMem_40;
  reg  [7:0]  programBufferMem_41;
  reg  [7:0]  programBufferMem_42;
  reg  [7:0]  programBufferMem_43;
  reg  [7:0]  programBufferMem_44;
  reg  [7:0]  programBufferMem_45;
  reg  [7:0]  programBufferMem_46;
  reg  [7:0]  programBufferMem_47;
  reg  [7:0]  programBufferMem_48;
  reg  [7:0]  programBufferMem_49;
  reg  [7:0]  programBufferMem_50;
  reg  [7:0]  programBufferMem_51;
  reg  [7:0]  programBufferMem_52;
  reg  [7:0]  programBufferMem_53;
  reg  [7:0]  programBufferMem_54;
  reg  [7:0]  programBufferMem_55;
  reg  [7:0]  programBufferMem_56;
  reg  [7:0]  programBufferMem_57;
  reg  [7:0]  programBufferMem_58;
  reg  [7:0]  programBufferMem_59;
  reg  [7:0]  programBufferMem_60;
  reg  [7:0]  programBufferMem_61;
  reg  [7:0]  programBufferMem_62;
  reg  [7:0]  programBufferMem_63;
  wire        out_woready_1_535 = _out_wofireMux_T_262 & auto_tl_in_a_bits_address[10:3] == 8'h20 & ~(auto_tl_in_a_bits_address[11]);
  wire        _out_out_bits_data_T_31 = auto_dmi_in_a_bits_address[7:2] == 6'h4;
  wire        _out_out_bits_data_T_32 = auto_dmi_in_a_bits_address[7:2] == 6'h5;
  wire        _out_out_bits_data_T_33 = auto_dmi_in_a_bits_address[7:2] == 6'h6;
  wire        _out_out_bits_data_T_34 = auto_dmi_in_a_bits_address[7:2] == 6'h7;
  wire        _out_out_bits_data_T_35 = auto_dmi_in_a_bits_address[7:2] == 6'h8;
  wire        _out_out_bits_data_T_36 = auto_dmi_in_a_bits_address[7:2] == 6'h9;
  wire        _out_out_bits_data_T_37 = auto_dmi_in_a_bits_address[7:2] == 6'hA;
  wire        _out_out_bits_data_T_38 = auto_dmi_in_a_bits_address[7:2] == 6'hB;
  wire        _out_out_bits_data_T_39 = auto_dmi_in_a_bits_address[7:2] == 6'h11;
  wire        _out_out_bits_data_T_40 = auto_dmi_in_a_bits_address[7:2] == 6'h13;
  wire        _out_out_bits_data_T_41 = auto_dmi_in_a_bits_address[7:2] == 6'h16;
  wire        _out_out_bits_data_T_42 = auto_dmi_in_a_bits_address[7:2] == 6'h17;
  wire        _out_out_bits_data_T_43 = auto_dmi_in_a_bits_address[7:2] == 6'h18;
  wire        _out_out_bits_data_T_44 = auto_dmi_in_a_bits_address[7:2] == 6'h20;
  wire        _out_out_bits_data_T_45 = auto_dmi_in_a_bits_address[7:2] == 6'h21;
  wire        _out_out_bits_data_T_46 = auto_dmi_in_a_bits_address[7:2] == 6'h22;
  wire        _out_out_bits_data_T_47 = auto_dmi_in_a_bits_address[7:2] == 6'h23;
  wire        _out_out_bits_data_T_48 = auto_dmi_in_a_bits_address[7:2] == 6'h24;
  wire        _out_out_bits_data_T_49 = auto_dmi_in_a_bits_address[7:2] == 6'h25;
  wire        _out_out_bits_data_T_50 = auto_dmi_in_a_bits_address[7:2] == 6'h26;
  wire        _out_out_bits_data_T_51 = auto_dmi_in_a_bits_address[7:2] == 6'h27;
  wire        _out_out_bits_data_T_52 = auto_dmi_in_a_bits_address[7:2] == 6'h28;
  wire        _out_out_bits_data_T_53 = auto_dmi_in_a_bits_address[7:2] == 6'h29;
  wire        _out_out_bits_data_T_54 = auto_dmi_in_a_bits_address[7:2] == 6'h2A;
  wire        _out_out_bits_data_T_55 = auto_dmi_in_a_bits_address[7:2] == 6'h2B;
  wire        _out_out_bits_data_T_56 = auto_dmi_in_a_bits_address[7:2] == 6'h2C;
  wire        _out_out_bits_data_T_57 = auto_dmi_in_a_bits_address[7:2] == 6'h2D;
  wire        _out_out_bits_data_T_58 = auto_dmi_in_a_bits_address[7:2] == 6'h2E;
  wire        _out_out_bits_data_T_59 = auto_dmi_in_a_bits_address[7:2] == 6'h2F;
  wire        _out_out_bits_data_T_30 = auto_dmi_in_a_bits_address[7:2] == 6'h0;
  reg         goReg;
  wire        hartGoingWrEn = out_woready_1_535 & (&_out_romask_T_664);
  wire        goAbstract = (|ctrlStateReg) & _GEN_0 & ~commandRegIsUnsupported & ~commandRegBadHaltResume;
  reg  [31:0] abstractGeneratedMem_0;
  reg  [31:0] abstractGeneratedMem_1;
  wire        _out_out_bits_data_T_62 =
    (&(auto_tl_in_a_bits_address[10:3])) | auto_tl_in_a_bits_address[10:3] == 8'hFE | auto_tl_in_a_bits_address[10:3] == 8'hFD | auto_tl_in_a_bits_address[10:3] == 8'hFC | auto_tl_in_a_bits_address[10:3] == 8'hFB | auto_tl_in_a_bits_address[10:3] == 8'hFA | auto_tl_in_a_bits_address[10:3] == 8'hF9 | auto_tl_in_a_bits_address[10:3] == 8'hF8 | auto_tl_in_a_bits_address[10:3] == 8'hF7 | auto_tl_in_a_bits_address[10:3] == 8'hF6 | auto_tl_in_a_bits_address[10:3] == 8'hF5 | auto_tl_in_a_bits_address[10:3] == 8'hF4 | auto_tl_in_a_bits_address[10:3] == 8'hF3 | auto_tl_in_a_bits_address[10:3] == 8'hF2 | auto_tl_in_a_bits_address[10:3] == 8'hF1 | auto_tl_in_a_bits_address[10:3] == 8'hF0 | auto_tl_in_a_bits_address[10:3] == 8'hEF | auto_tl_in_a_bits_address[10:3] == 8'hEE | auto_tl_in_a_bits_address[10:3] == 8'hED | auto_tl_in_a_bits_address[10:3] == 8'hEC | auto_tl_in_a_bits_address[10:3] == 8'hEB | auto_tl_in_a_bits_address[10:3] == 8'hEA | auto_tl_in_a_bits_address[10:3] == 8'hE9 | auto_tl_in_a_bits_address[10:3] == 8'hE8 | auto_tl_in_a_bits_address[10:3] == 8'hE7 | auto_tl_in_a_bits_address[10:3] == 8'hE6 | auto_tl_in_a_bits_address[10:3] == 8'hE5 | auto_tl_in_a_bits_address[10:3] == 8'hE4 | auto_tl_in_a_bits_address[10:3] == 8'hE3 | auto_tl_in_a_bits_address[10:3] == 8'hE2 | auto_tl_in_a_bits_address[10:3] == 8'hE1 | auto_tl_in_a_bits_address[10:3] == 8'hE0 | auto_tl_in_a_bits_address[10:3] == 8'hDF | auto_tl_in_a_bits_address[10:3] == 8'hDE | auto_tl_in_a_bits_address[10:3] == 8'hDD | auto_tl_in_a_bits_address[10:3] == 8'hDC | auto_tl_in_a_bits_address[10:3] == 8'hDB | auto_tl_in_a_bits_address[10:3] == 8'hDA | auto_tl_in_a_bits_address[10:3] == 8'hD9 | auto_tl_in_a_bits_address[10:3] == 8'hD8 | auto_tl_in_a_bits_address[10:3] == 8'hD7 | auto_tl_in_a_bits_address[10:3] == 8'hD6 | auto_tl_in_a_bits_address[10:3] == 8'hD5 | auto_tl_in_a_bits_address[10:3] == 8'hD4 | auto_tl_in_a_bits_address[10:3] == 8'hD3 | auto_tl_in_a_bits_address[10:3] == 8'hD2 | auto_tl_in_a_bits_address[10:3] == 8'hD1
    | auto_tl_in_a_bits_address[10:3] == 8'hD0 | auto_tl_in_a_bits_address[10:3] == 8'hCF | auto_tl_in_a_bits_address[10:3] == 8'hCE | auto_tl_in_a_bits_address[10:3] == 8'hCD | auto_tl_in_a_bits_address[10:3] == 8'hCC | auto_tl_in_a_bits_address[10:3] == 8'hCB | auto_tl_in_a_bits_address[10:3] == 8'hCA | auto_tl_in_a_bits_address[10:3] == 8'hC9 | auto_tl_in_a_bits_address[10:3] == 8'hC8 | auto_tl_in_a_bits_address[10:3] == 8'hC7 | auto_tl_in_a_bits_address[10:3] == 8'hC6 | auto_tl_in_a_bits_address[10:3] == 8'hC5 | auto_tl_in_a_bits_address[10:3] == 8'hC4 | auto_tl_in_a_bits_address[10:3] == 8'hC3 | auto_tl_in_a_bits_address[10:3] == 8'hC2 | auto_tl_in_a_bits_address[10:3] == 8'hC1 | auto_tl_in_a_bits_address[10:3] == 8'hC0 | auto_tl_in_a_bits_address[10:3] == 8'hBF | auto_tl_in_a_bits_address[10:3] == 8'hBE | auto_tl_in_a_bits_address[10:3] == 8'hBD | auto_tl_in_a_bits_address[10:3] == 8'hBC | auto_tl_in_a_bits_address[10:3] == 8'hBB | auto_tl_in_a_bits_address[10:3] == 8'hBA | auto_tl_in_a_bits_address[10:3] == 8'hB9 | auto_tl_in_a_bits_address[10:3] == 8'hB8 | auto_tl_in_a_bits_address[10:3] == 8'hB7 | auto_tl_in_a_bits_address[10:3] == 8'hB6 | auto_tl_in_a_bits_address[10:3] == 8'hB5 | auto_tl_in_a_bits_address[10:3] == 8'hB4 | auto_tl_in_a_bits_address[10:3] == 8'hB3 | auto_tl_in_a_bits_address[10:3] == 8'hB2 | auto_tl_in_a_bits_address[10:3] == 8'hB1 | auto_tl_in_a_bits_address[10:3] == 8'hB0 | auto_tl_in_a_bits_address[10:3] == 8'hAF | auto_tl_in_a_bits_address[10:3] == 8'hAE | auto_tl_in_a_bits_address[10:3] == 8'hAD | auto_tl_in_a_bits_address[10:3] == 8'hAC | auto_tl_in_a_bits_address[10:3] == 8'hAB | auto_tl_in_a_bits_address[10:3] == 8'hAA | auto_tl_in_a_bits_address[10:3] == 8'hA9 | auto_tl_in_a_bits_address[10:3] == 8'hA8 | auto_tl_in_a_bits_address[10:3] == 8'hA7 | auto_tl_in_a_bits_address[10:3] == 8'hA6 | auto_tl_in_a_bits_address[10:3] == 8'hA5 | auto_tl_in_a_bits_address[10:3] == 8'hA4 | auto_tl_in_a_bits_address[10:3] == 8'hA3 | auto_tl_in_a_bits_address[10:3] == 8'hA2
    | auto_tl_in_a_bits_address[10:3] == 8'hA1 | auto_tl_in_a_bits_address[10:3] == 8'hA0 | auto_tl_in_a_bits_address[10:3] == 8'h9F | auto_tl_in_a_bits_address[10:3] == 8'h9E | auto_tl_in_a_bits_address[10:3] == 8'h9D | auto_tl_in_a_bits_address[10:3] == 8'h9C | auto_tl_in_a_bits_address[10:3] == 8'h9B | auto_tl_in_a_bits_address[10:3] == 8'h9A | auto_tl_in_a_bits_address[10:3] == 8'h99 | auto_tl_in_a_bits_address[10:3] == 8'h98 | auto_tl_in_a_bits_address[10:3] == 8'h97 | auto_tl_in_a_bits_address[10:3] == 8'h96 | auto_tl_in_a_bits_address[10:3] == 8'h95 | auto_tl_in_a_bits_address[10:3] == 8'h94 | auto_tl_in_a_bits_address[10:3] == 8'h93 | auto_tl_in_a_bits_address[10:3] == 8'h92 | auto_tl_in_a_bits_address[10:3] == 8'h91 | auto_tl_in_a_bits_address[10:3] == 8'h90 | auto_tl_in_a_bits_address[10:3] == 8'h8F | auto_tl_in_a_bits_address[10:3] == 8'h8E | auto_tl_in_a_bits_address[10:3] == 8'h8D | auto_tl_in_a_bits_address[10:3] == 8'h8C | auto_tl_in_a_bits_address[10:3] == 8'h8B | auto_tl_in_a_bits_address[10:3] == 8'h8A | auto_tl_in_a_bits_address[10:3] == 8'h89 | auto_tl_in_a_bits_address[10:3] == 8'h88 | auto_tl_in_a_bits_address[10:3] == 8'h87 | auto_tl_in_a_bits_address[10:3] == 8'h86 | auto_tl_in_a_bits_address[10:3] == 8'h85 | auto_tl_in_a_bits_address[10:3] == 8'h84 | auto_tl_in_a_bits_address[10:3] == 8'h83 | auto_tl_in_a_bits_address[10:3] == 8'h82 | auto_tl_in_a_bits_address[10:3] == 8'h81 | auto_tl_in_a_bits_address[10:3] == 8'h80
      ? ~(auto_tl_in_a_bits_address[11])
      : auto_tl_in_a_bits_address[10:3] == 8'h7F | auto_tl_in_a_bits_address[10:3] == 8'h7E | auto_tl_in_a_bits_address[10:3] == 8'h7D | auto_tl_in_a_bits_address[10:3] == 8'h7C | auto_tl_in_a_bits_address[10:3] == 8'h7B | auto_tl_in_a_bits_address[10:3] == 8'h7A | auto_tl_in_a_bits_address[10:3] == 8'h79 | auto_tl_in_a_bits_address[10:3] == 8'h78 | auto_tl_in_a_bits_address[10:3] == 8'h77 | auto_tl_in_a_bits_address[10:3] == 8'h76 | auto_tl_in_a_bits_address[10:3] == 8'h75 | auto_tl_in_a_bits_address[10:3] == 8'h74
        | (auto_tl_in_a_bits_address[10:3] == 8'h73 | auto_tl_in_a_bits_address[10:3] == 8'h72 | auto_tl_in_a_bits_address[10:3] == 8'h71 | auto_tl_in_a_bits_address[10:3] == 8'h70 | auto_tl_in_a_bits_address[10:3] == 8'h6F | auto_tl_in_a_bits_address[10:3] == 8'h6E | auto_tl_in_a_bits_address[10:3] == 8'h6D | auto_tl_in_a_bits_address[10:3] == 8'h6C | auto_tl_in_a_bits_address[10:3] == 8'h6B | auto_tl_in_a_bits_address[10:3] == 8'h6A | auto_tl_in_a_bits_address[10:3] == 8'h69 | auto_tl_in_a_bits_address[10:3] == 8'h68 | auto_tl_in_a_bits_address[10:3] == 8'h67
             ? ~(auto_tl_in_a_bits_address[11])
             : auto_tl_in_a_bits_address[10:3] == 8'h66 | auto_tl_in_a_bits_address[10:3] == 8'h65 | auto_tl_in_a_bits_address[10:3] == 8'h64 | auto_tl_in_a_bits_address[10:3] == 8'h63 | auto_tl_in_a_bits_address[10:3] == 8'h62 | auto_tl_in_a_bits_address[10:3] == 8'h61
               | (auto_tl_in_a_bits_address[10:3] == 8'h60
                    ? ~(auto_tl_in_a_bits_address[11])
                    : auto_tl_in_a_bits_address[10:3] == 8'h5F | auto_tl_in_a_bits_address[10:3] == 8'h5E | auto_tl_in_a_bits_address[10:3] == 8'h5D | auto_tl_in_a_bits_address[10:3] == 8'h5C | auto_tl_in_a_bits_address[10:3] == 8'h5B | auto_tl_in_a_bits_address[10:3] == 8'h5A | auto_tl_in_a_bits_address[10:3] == 8'h59 | auto_tl_in_a_bits_address[10:3] == 8'h58 | auto_tl_in_a_bits_address[10:3] == 8'h57 | auto_tl_in_a_bits_address[10:3] == 8'h56 | auto_tl_in_a_bits_address[10:3] == 8'h55 | auto_tl_in_a_bits_address[10:3] == 8'h54 | auto_tl_in_a_bits_address[10:3] == 8'h53 | auto_tl_in_a_bits_address[10:3] == 8'h52 | auto_tl_in_a_bits_address[10:3] == 8'h51 | auto_tl_in_a_bits_address[10:3] == 8'h50 | auto_tl_in_a_bits_address[10:3] == 8'h4F | auto_tl_in_a_bits_address[10:3] == 8'h4E | auto_tl_in_a_bits_address[10:3] == 8'h4D | auto_tl_in_a_bits_address[10:3] == 8'h4C | auto_tl_in_a_bits_address[10:3] == 8'h4B | auto_tl_in_a_bits_address[10:3] == 8'h4A | auto_tl_in_a_bits_address[10:3] == 8'h49 | auto_tl_in_a_bits_address[10:3] == 8'h48 | auto_tl_in_a_bits_address[10:3] == 8'h47 | auto_tl_in_a_bits_address[10:3] == 8'h46 | auto_tl_in_a_bits_address[10:3] == 8'h45 | auto_tl_in_a_bits_address[10:3] == 8'h44 | auto_tl_in_a_bits_address[10:3] == 8'h43 | auto_tl_in_a_bits_address[10:3] == 8'h42 | auto_tl_in_a_bits_address[10:3] == 8'h41 | auto_tl_in_a_bits_address[10:3] == 8'h40 | auto_tl_in_a_bits_address[10:3] == 8'h3F | auto_tl_in_a_bits_address[10:3] == 8'h3E | auto_tl_in_a_bits_address[10:3] == 8'h3D | auto_tl_in_a_bits_address[10:3] == 8'h3C | auto_tl_in_a_bits_address[10:3] == 8'h3B | auto_tl_in_a_bits_address[10:3] == 8'h3A | auto_tl_in_a_bits_address[10:3] == 8'h39 | auto_tl_in_a_bits_address[10:3] == 8'h38 | auto_tl_in_a_bits_address[10:3] == 8'h37 | auto_tl_in_a_bits_address[10:3] == 8'h36 | auto_tl_in_a_bits_address[10:3] == 8'h35 | auto_tl_in_a_bits_address[10:3] == 8'h34 | auto_tl_in_a_bits_address[10:3] == 8'h33 | auto_tl_in_a_bits_address[10:3] == 8'h32 | auto_tl_in_a_bits_address[10:3] == 8'h31
                      | auto_tl_in_a_bits_address[10:3] == 8'h30 | auto_tl_in_a_bits_address[10:3] == 8'h2F | auto_tl_in_a_bits_address[10:3] == 8'h2E | auto_tl_in_a_bits_address[10:3] == 8'h2D | auto_tl_in_a_bits_address[10:3] == 8'h2C | auto_tl_in_a_bits_address[10:3] == 8'h2B | auto_tl_in_a_bits_address[10:3] == 8'h2A | auto_tl_in_a_bits_address[10:3] == 8'h29 | auto_tl_in_a_bits_address[10:3] == 8'h28 | auto_tl_in_a_bits_address[10:3] == 8'h27 | auto_tl_in_a_bits_address[10:3] == 8'h26 | auto_tl_in_a_bits_address[10:3] == 8'h25 | auto_tl_in_a_bits_address[10:3] == 8'h24 | auto_tl_in_a_bits_address[10:3] == 8'h23 | auto_tl_in_a_bits_address[10:3] == 8'h22 | (auto_tl_in_a_bits_address[10:3] == 8'h21 | auto_tl_in_a_bits_address[10:3] == 8'h20 ? ~(auto_tl_in_a_bits_address[11]) : auto_tl_in_a_bits_address[10:3] == 8'h1F | auto_tl_in_a_bits_address[10:3] == 8'h1E | auto_tl_in_a_bits_address[10:3] == 8'h1D | auto_tl_in_a_bits_address[10:3] == 8'h1C | auto_tl_in_a_bits_address[10:3] == 8'h1B | auto_tl_in_a_bits_address[10:3] == 8'h1A | auto_tl_in_a_bits_address[10:3] == 8'h19 | auto_tl_in_a_bits_address[10:3] == 8'h18 | auto_tl_in_a_bits_address[10:3] == 8'h17 | auto_tl_in_a_bits_address[10:3] == 8'h16 | auto_tl_in_a_bits_address[10:3] == 8'h15 | auto_tl_in_a_bits_address[10:3] == 8'h14 | auto_tl_in_a_bits_address[10:3] == 8'h13 | auto_tl_in_a_bits_address[10:3] == 8'h12 | auto_tl_in_a_bits_address[10:3] == 8'h11 | auto_tl_in_a_bits_address[10:3] == 8'h10 | auto_tl_in_a_bits_address[10:3] == 8'hF | auto_tl_in_a_bits_address[10:3] == 8'hE | auto_tl_in_a_bits_address[10:3] == 8'hD | auto_tl_in_a_bits_address[10:3] == 8'hC | auto_tl_in_a_bits_address[10:3] == 8'hB | auto_tl_in_a_bits_address[11])));
  always @(*) begin
    casez (auto_tl_in_a_bits_address[10:3])
      8'b00000000:
        casez_tmp = 64'h380006F00C0006F;
      8'b00000001:
        casez_tmp = 64'hFF0000F0440006F;
      8'b00000010:
        casez_tmp = 64'hF14024737B241073;
      8'b00000011:
        casez_tmp = 64'h4004440310802023;
      8'b00000100:
        casez_tmp = 64'hFE0408E300347413;
      8'b00000101:
        casez_tmp = 64'h4086300147413;
      8'b00000110:
        casez_tmp = 64'h100022237B202473;
      8'b00000111:
        casez_tmp = 64'hF140247330000067;
      8'b00001000:
        casez_tmp = 64'h7B20247310802423;
      8'b00001001:
        casez_tmp = 64'h100026237B200073;
      8'b00001010:
        casez_tmp = 64'h100073;
      8'b00001011:
        casez_tmp = 64'h0;
      8'b00001100:
        casez_tmp = 64'h0;
      8'b00001101:
        casez_tmp = 64'h0;
      8'b00001110:
        casez_tmp = 64'h0;
      8'b00001111:
        casez_tmp = 64'h0;
      8'b00010000:
        casez_tmp = 64'h0;
      8'b00010001:
        casez_tmp = 64'h0;
      8'b00010010:
        casez_tmp = 64'h0;
      8'b00010011:
        casez_tmp = 64'h0;
      8'b00010100:
        casez_tmp = 64'h0;
      8'b00010101:
        casez_tmp = 64'h0;
      8'b00010110:
        casez_tmp = 64'h0;
      8'b00010111:
        casez_tmp = 64'h0;
      8'b00011000:
        casez_tmp = 64'h0;
      8'b00011001:
        casez_tmp = 64'h0;
      8'b00011010:
        casez_tmp = 64'h0;
      8'b00011011:
        casez_tmp = 64'h0;
      8'b00011100:
        casez_tmp = 64'h0;
      8'b00011101:
        casez_tmp = 64'h0;
      8'b00011110:
        casez_tmp = 64'h0;
      8'b00011111:
        casez_tmp = 64'h0;
      8'b00100000:
        casez_tmp = 64'h0;
      8'b00100001:
        casez_tmp = 64'h0;
      8'b00100010:
        casez_tmp = 64'h0;
      8'b00100011:
        casez_tmp = 64'h0;
      8'b00100100:
        casez_tmp = 64'h0;
      8'b00100101:
        casez_tmp = 64'h0;
      8'b00100110:
        casez_tmp = 64'h0;
      8'b00100111:
        casez_tmp = 64'h0;
      8'b00101000:
        casez_tmp = 64'h0;
      8'b00101001:
        casez_tmp = 64'h0;
      8'b00101010:
        casez_tmp = 64'h0;
      8'b00101011:
        casez_tmp = 64'h0;
      8'b00101100:
        casez_tmp = 64'h0;
      8'b00101101:
        casez_tmp = 64'h0;
      8'b00101110:
        casez_tmp = 64'h0;
      8'b00101111:
        casez_tmp = 64'h0;
      8'b00110000:
        casez_tmp = 64'h0;
      8'b00110001:
        casez_tmp = 64'h0;
      8'b00110010:
        casez_tmp = 64'h0;
      8'b00110011:
        casez_tmp = 64'h0;
      8'b00110100:
        casez_tmp = 64'h0;
      8'b00110101:
        casez_tmp = 64'h0;
      8'b00110110:
        casez_tmp = 64'h0;
      8'b00110111:
        casez_tmp = 64'h0;
      8'b00111000:
        casez_tmp = 64'h0;
      8'b00111001:
        casez_tmp = 64'h0;
      8'b00111010:
        casez_tmp = 64'h0;
      8'b00111011:
        casez_tmp = 64'h0;
      8'b00111100:
        casez_tmp = 64'h0;
      8'b00111101:
        casez_tmp = 64'h0;
      8'b00111110:
        casez_tmp = 64'h0;
      8'b00111111:
        casez_tmp = 64'h0;
      8'b01000000:
        casez_tmp = 64'h0;
      8'b01000001:
        casez_tmp = 64'h0;
      8'b01000010:
        casez_tmp = 64'h0;
      8'b01000011:
        casez_tmp = 64'h0;
      8'b01000100:
        casez_tmp = 64'h0;
      8'b01000101:
        casez_tmp = 64'h0;
      8'b01000110:
        casez_tmp = 64'h0;
      8'b01000111:
        casez_tmp = 64'h0;
      8'b01001000:
        casez_tmp = 64'h0;
      8'b01001001:
        casez_tmp = 64'h0;
      8'b01001010:
        casez_tmp = 64'h0;
      8'b01001011:
        casez_tmp = 64'h0;
      8'b01001100:
        casez_tmp = 64'h0;
      8'b01001101:
        casez_tmp = 64'h0;
      8'b01001110:
        casez_tmp = 64'h0;
      8'b01001111:
        casez_tmp = 64'h0;
      8'b01010000:
        casez_tmp = 64'h0;
      8'b01010001:
        casez_tmp = 64'h0;
      8'b01010010:
        casez_tmp = 64'h0;
      8'b01010011:
        casez_tmp = 64'h0;
      8'b01010100:
        casez_tmp = 64'h0;
      8'b01010101:
        casez_tmp = 64'h0;
      8'b01010110:
        casez_tmp = 64'h0;
      8'b01010111:
        casez_tmp = 64'h0;
      8'b01011000:
        casez_tmp = 64'h0;
      8'b01011001:
        casez_tmp = 64'h0;
      8'b01011010:
        casez_tmp = 64'h0;
      8'b01011011:
        casez_tmp = 64'h0;
      8'b01011100:
        casez_tmp = 64'h0;
      8'b01011101:
        casez_tmp = 64'h0;
      8'b01011110:
        casez_tmp = 64'h0;
      8'b01011111:
        casez_tmp = 64'h0;
      8'b01100000:
        casez_tmp = 64'h380006F;
      8'b01100001:
        casez_tmp = 64'h0;
      8'b01100010:
        casez_tmp = 64'h0;
      8'b01100011:
        casez_tmp = 64'h0;
      8'b01100100:
        casez_tmp = 64'h0;
      8'b01100101:
        casez_tmp = 64'h0;
      8'b01100110:
        casez_tmp = 64'h0;
      8'b01100111:
        casez_tmp = {abstractGeneratedMem_1, abstractGeneratedMem_0};
      8'b01101000:
        casez_tmp = {programBufferMem_7, programBufferMem_6, programBufferMem_5, programBufferMem_4, programBufferMem_3, programBufferMem_2, programBufferMem_1, programBufferMem_0};
      8'b01101001:
        casez_tmp = {programBufferMem_15, programBufferMem_14, programBufferMem_13, programBufferMem_12, programBufferMem_11, programBufferMem_10, programBufferMem_9, programBufferMem_8};
      8'b01101010:
        casez_tmp = {programBufferMem_23, programBufferMem_22, programBufferMem_21, programBufferMem_20, programBufferMem_19, programBufferMem_18, programBufferMem_17, programBufferMem_16};
      8'b01101011:
        casez_tmp = {programBufferMem_31, programBufferMem_30, programBufferMem_29, programBufferMem_28, programBufferMem_27, programBufferMem_26, programBufferMem_25, programBufferMem_24};
      8'b01101100:
        casez_tmp = {programBufferMem_39, programBufferMem_38, programBufferMem_37, programBufferMem_36, programBufferMem_35, programBufferMem_34, programBufferMem_33, programBufferMem_32};
      8'b01101101:
        casez_tmp = {programBufferMem_47, programBufferMem_46, programBufferMem_45, programBufferMem_44, programBufferMem_43, programBufferMem_42, programBufferMem_41, programBufferMem_40};
      8'b01101110:
        casez_tmp = {programBufferMem_55, programBufferMem_54, programBufferMem_53, programBufferMem_52, programBufferMem_51, programBufferMem_50, programBufferMem_49, programBufferMem_48};
      8'b01101111:
        casez_tmp = {programBufferMem_63, programBufferMem_62, programBufferMem_61, programBufferMem_60, programBufferMem_59, programBufferMem_58, programBufferMem_57, programBufferMem_56};
      8'b01110000:
        casez_tmp = {abstractDataMem_7, abstractDataMem_6, abstractDataMem_5, abstractDataMem_4, abstractDataMem_3, abstractDataMem_2, abstractDataMem_1, abstractDataMem_0};
      8'b01110001:
        casez_tmp = {abstractDataMem_15, abstractDataMem_14, abstractDataMem_13, abstractDataMem_12, abstractDataMem_11, abstractDataMem_10, abstractDataMem_9, abstractDataMem_8};
      8'b01110010:
        casez_tmp = {abstractDataMem_23, abstractDataMem_22, abstractDataMem_21, abstractDataMem_20, abstractDataMem_19, abstractDataMem_18, abstractDataMem_17, abstractDataMem_16};
      8'b01110011:
        casez_tmp = {abstractDataMem_31, abstractDataMem_30, abstractDataMem_29, abstractDataMem_28, abstractDataMem_27, abstractDataMem_26, abstractDataMem_25, abstractDataMem_24};
      8'b01110100:
        casez_tmp = 64'h0;
      8'b01110101:
        casez_tmp = 64'h0;
      8'b01110110:
        casez_tmp = 64'h0;
      8'b01110111:
        casez_tmp = 64'h0;
      8'b01111000:
        casez_tmp = 64'h0;
      8'b01111001:
        casez_tmp = 64'h0;
      8'b01111010:
        casez_tmp = 64'h0;
      8'b01111011:
        casez_tmp = 64'h0;
      8'b01111100:
        casez_tmp = 64'h0;
      8'b01111101:
        casez_tmp = 64'h0;
      8'b01111110:
        casez_tmp = 64'h0;
      8'b01111111:
        casez_tmp = 64'h0;
      8'b10000000:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10000001:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10000010:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10000011:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10000100:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10000101:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10000110:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10000111:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10001000:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10001001:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10001010:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10001011:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10001100:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10001101:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10001110:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10001111:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10010000:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10010001:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10010010:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10010011:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10010100:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10010101:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10010110:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10010111:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10011000:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10011001:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10011010:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10011011:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10011100:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10011101:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10011110:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10011111:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10100000:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10100001:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10100010:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10100011:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10100100:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10100101:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10100110:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10100111:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10101000:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10101001:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10101010:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10101011:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10101100:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10101101:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10101110:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10101111:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10110000:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10110001:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10110010:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10110011:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10110100:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10110101:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10110110:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10110111:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10111000:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10111001:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10111010:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10111011:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10111100:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10111101:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10111110:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b10111111:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11000000:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11000001:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11000010:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11000011:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11000100:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11000101:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11000110:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11000111:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11001000:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11001001:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11001010:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11001011:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11001100:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11001101:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11001110:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11001111:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11010000:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11010001:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11010010:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11010011:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11010100:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11010101:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11010110:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11010111:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11011000:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11011001:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11011010:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11011011:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11011100:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11011101:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11011110:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11011111:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11100000:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11100001:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11100010:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11100011:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11100100:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11100101:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11100110:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11100111:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11101000:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11101001:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11101010:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11101011:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11101100:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11101101:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11101110:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11101111:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11110000:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11110001:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11110010:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11110011:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11110100:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11110101:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11110110:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11110111:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11111000:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11111001:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11111010:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11111011:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11111100:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11111101:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      8'b11111110:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
      default:
        casez_tmp = {6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg, 6'h0, resumeReqRegs, goReg};
    endcase
  end // always @(*)
  wire [2:0]  _GEN_3 = {2'h0, in_bits_read};
  wire [2:0]  _GEN_4 = {2'h0, in_1_bits_read};
  wire        _out_rofireMux_T = auto_dmi_in_a_valid & auto_dmi_in_d_ready;
  wire        _out_wofireMux_T_2 = _out_rofireMux_T & ~in_bits_read;
  wire [7:0]  _out_backMask_T_11 = {8{auto_dmi_in_a_bits_mask[3]}};
  wire [7:0]  _out_backMask_T_9 = {8{auto_dmi_in_a_bits_mask[2]}};
  wire        ABSTRACTCSWrEnMaybe = _out_wofireMux_T_2 & auto_dmi_in_a_bits_address[7:2] == 6'h16 & ~(auto_dmi_in_a_bits_address[8]) & auto_dmi_in_a_bits_mask[1];
  wire        COMMANDWrEnMaybe = _out_wofireMux_T_2 & auto_dmi_in_a_bits_address[7:2] == 6'h17 & ~(auto_dmi_in_a_bits_address[8]) & (&{_out_backMask_T_11, _out_backMask_T_9, {8{auto_dmi_in_a_bits_mask[1]}}, {8{auto_dmi_in_a_bits_mask[0]}}});
  wire        COMMANDWrEn = COMMANDWrEnMaybe & ~(|ctrlStateReg);
  wire [31:0] COMMANDWrDataVal = COMMANDWrEnMaybe ? auto_dmi_in_a_bits_data : 32'h0;
  wire        _regAccessRegisterCommand_T_1 = ABSTRACTCSReg_cmderr == 3'h0;
  wire        out_backSel_4 = auto_dmi_in_a_bits_address[7:2] == 6'h4;
  wire        out_woready__32 = _out_wofireMux_T_2 & out_backSel_4 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiAbstractDataWrEnMaybe_0 = out_woready__32 & auto_dmi_in_a_bits_mask[0];
  wire        _out_rofireMux_T_1 = _out_rofireMux_T & in_bits_read;
  wire        out_roready__32 = _out_rofireMux_T_1 & out_backSel_4 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiAbstractDataAccessVec_0 = dmiAbstractDataWrEnMaybe_0 | out_roready__32 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_5 = auto_dmi_in_a_bits_address[7:2] == 6'h5;
  wire        out_woready__0 = _out_wofireMux_T_2 & out_backSel_5 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiAbstractDataWrEnMaybe_4 = out_woready__0 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__0 = _out_rofireMux_T_1 & out_backSel_5 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiAbstractDataAccessVec_4 = dmiAbstractDataWrEnMaybe_4 | out_roready__0 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_6 = auto_dmi_in_a_bits_address[7:2] == 6'h6;
  wire        out_woready__12 = _out_wofireMux_T_2 & out_backSel_6 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiAbstractDataWrEnMaybe_8 = out_woready__12 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__12 = _out_rofireMux_T_1 & out_backSel_6 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiAbstractDataAccessVec_8 = dmiAbstractDataWrEnMaybe_8 | out_roready__12 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_7 = auto_dmi_in_a_bits_address[7:2] == 6'h7;
  wire        out_woready__102 = _out_wofireMux_T_2 & out_backSel_7 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiAbstractDataWrEnMaybe_12 = out_woready__102 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__102 = _out_rofireMux_T_1 & out_backSel_7 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiAbstractDataAccessVec_12 = dmiAbstractDataWrEnMaybe_12 | out_roready__102 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_8 = auto_dmi_in_a_bits_address[7:2] == 6'h8;
  wire        out_woready__28 = _out_wofireMux_T_2 & out_backSel_8 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiAbstractDataWrEnMaybe_16 = out_woready__28 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__28 = _out_rofireMux_T_1 & out_backSel_8 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiAbstractDataAccessVec_16 = dmiAbstractDataWrEnMaybe_16 | out_roready__28 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_9 = auto_dmi_in_a_bits_address[7:2] == 6'h9;
  wire        out_woready__16 = _out_wofireMux_T_2 & out_backSel_9 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiAbstractDataWrEnMaybe_20 = out_woready__16 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__16 = _out_rofireMux_T_1 & out_backSel_9 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiAbstractDataAccessVec_20 = dmiAbstractDataWrEnMaybe_20 | out_roready__16 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_10 = auto_dmi_in_a_bits_address[7:2] == 6'hA;
  wire        out_woready__4 = _out_wofireMux_T_2 & out_backSel_10 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiAbstractDataWrEnMaybe_24 = out_woready__4 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__4 = _out_rofireMux_T_1 & out_backSel_10 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiAbstractDataAccessVec_24 = dmiAbstractDataWrEnMaybe_24 | out_roready__4 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_11 = auto_dmi_in_a_bits_address[7:2] == 6'hB;
  wire        out_woready__110 = _out_wofireMux_T_2 & out_backSel_11 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiAbstractDataWrEnMaybe_28 = out_woready__110 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__110 = _out_rofireMux_T_1 & out_backSel_11 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiAbstractDataAccessVec_28 = dmiAbstractDataWrEnMaybe_28 | out_roready__110 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_32 = auto_dmi_in_a_bits_address[7:2] == 6'h20;
  wire        out_woready__83 = _out_wofireMux_T_2 & out_backSel_32 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferWrEnMaybe_0 = out_woready__83 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__83 = _out_rofireMux_T_1 & out_backSel_32 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferAccessVec_0 = dmiProgramBufferWrEnMaybe_0 | out_roready__83 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_33 = auto_dmi_in_a_bits_address[7:2] == 6'h21;
  wire        out_woready__55 = _out_wofireMux_T_2 & out_backSel_33 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferWrEnMaybe_4 = out_woready__55 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__55 = _out_rofireMux_T_1 & out_backSel_33 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferAccessVec_4 = dmiProgramBufferWrEnMaybe_4 | out_roready__55 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_34 = auto_dmi_in_a_bits_address[7:2] == 6'h22;
  wire        out_woready__87 = _out_wofireMux_T_2 & out_backSel_34 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferWrEnMaybe_8 = out_woready__87 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__87 = _out_rofireMux_T_1 & out_backSel_34 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferAccessVec_8 = dmiProgramBufferWrEnMaybe_8 | out_roready__87 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_35 = auto_dmi_in_a_bits_address[7:2] == 6'h23;
  wire        out_woready__24 = _out_wofireMux_T_2 & out_backSel_35 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferWrEnMaybe_12 = out_woready__24 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__24 = _out_rofireMux_T_1 & out_backSel_35 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferAccessVec_12 = dmiProgramBufferWrEnMaybe_12 | out_roready__24 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_36 = auto_dmi_in_a_bits_address[7:2] == 6'h24;
  wire        out_woready__123 = _out_wofireMux_T_2 & out_backSel_36 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferWrEnMaybe_16 = out_woready__123 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__123 = _out_rofireMux_T_1 & out_backSel_36 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferAccessVec_16 = dmiProgramBufferWrEnMaybe_16 | out_roready__123 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_37 = auto_dmi_in_a_bits_address[7:2] == 6'h25;
  wire        out_woready__47 = _out_wofireMux_T_2 & out_backSel_37 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferWrEnMaybe_20 = out_woready__47 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__47 = _out_rofireMux_T_1 & out_backSel_37 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferAccessVec_20 = dmiProgramBufferWrEnMaybe_20 | out_roready__47 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_38 = auto_dmi_in_a_bits_address[7:2] == 6'h26;
  wire        out_woready__51 = _out_wofireMux_T_2 & out_backSel_38 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferWrEnMaybe_24 = out_woready__51 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__51 = _out_rofireMux_T_1 & out_backSel_38 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferAccessVec_24 = dmiProgramBufferWrEnMaybe_24 | out_roready__51 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_39 = auto_dmi_in_a_bits_address[7:2] == 6'h27;
  wire        out_woready__106 = _out_wofireMux_T_2 & out_backSel_39 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferWrEnMaybe_28 = out_woready__106 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__106 = _out_rofireMux_T_1 & out_backSel_39 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferAccessVec_28 = dmiProgramBufferWrEnMaybe_28 | out_roready__106 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_40 = auto_dmi_in_a_bits_address[7:2] == 6'h28;
  wire        out_woready__118 = _out_wofireMux_T_2 & out_backSel_40 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferWrEnMaybe_32 = out_woready__118 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__118 = _out_rofireMux_T_1 & out_backSel_40 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferAccessVec_32 = dmiProgramBufferWrEnMaybe_32 | out_roready__118 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_41 = auto_dmi_in_a_bits_address[7:2] == 6'h29;
  wire        out_woready__20 = _out_wofireMux_T_2 & out_backSel_41 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferWrEnMaybe_36 = out_woready__20 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__20 = _out_rofireMux_T_1 & out_backSel_41 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferAccessVec_36 = dmiProgramBufferWrEnMaybe_36 | out_roready__20 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_42 = auto_dmi_in_a_bits_address[7:2] == 6'h2A;
  wire        out_woready__40 = _out_wofireMux_T_2 & out_backSel_42 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferWrEnMaybe_40 = out_woready__40 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__40 = _out_rofireMux_T_1 & out_backSel_42 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferAccessVec_40 = dmiProgramBufferWrEnMaybe_40 | out_roready__40 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_43 = auto_dmi_in_a_bits_address[7:2] == 6'h2B;
  wire        out_woready__114 = _out_wofireMux_T_2 & out_backSel_43 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferWrEnMaybe_44 = out_woready__114 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__114 = _out_rofireMux_T_1 & out_backSel_43 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferAccessVec_44 = dmiProgramBufferWrEnMaybe_44 | out_roready__114 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_44 = auto_dmi_in_a_bits_address[7:2] == 6'h2C;
  wire        out_woready__98 = _out_wofireMux_T_2 & out_backSel_44 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferWrEnMaybe_48 = out_woready__98 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__98 = _out_rofireMux_T_1 & out_backSel_44 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferAccessVec_48 = dmiProgramBufferWrEnMaybe_48 | out_roready__98 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_45 = auto_dmi_in_a_bits_address[7:2] == 6'h2D;
  wire        out_woready__59 = _out_wofireMux_T_2 & out_backSel_45 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferWrEnMaybe_52 = out_woready__59 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__59 = _out_rofireMux_T_1 & out_backSel_45 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferAccessVec_52 = dmiProgramBufferWrEnMaybe_52 | out_roready__59 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_46 = auto_dmi_in_a_bits_address[7:2] == 6'h2E;
  wire        out_woready__8 = _out_wofireMux_T_2 & out_backSel_46 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferWrEnMaybe_56 = out_woready__8 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__8 = _out_rofireMux_T_1 & out_backSel_46 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferAccessVec_56 = dmiProgramBufferWrEnMaybe_56 | out_roready__8 & auto_dmi_in_a_bits_mask[0];
  wire        out_backSel_47 = auto_dmi_in_a_bits_address[7:2] == 6'h2F;
  wire        out_woready__36 = _out_wofireMux_T_2 & out_backSel_47 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferWrEnMaybe_60 = out_woready__36 & auto_dmi_in_a_bits_mask[0];
  wire        out_roready__36 = _out_rofireMux_T_1 & out_backSel_47 & ~(auto_dmi_in_a_bits_address[8]);
  wire        dmiProgramBufferAccessVec_60 = dmiProgramBufferWrEnMaybe_60 | out_roready__36 & auto_dmi_in_a_bits_mask[0];
  wire        autoexec = dmiAbstractDataAccessVec_0 & ABSTRACTAUTOReg_autoexecdata[0] | dmiAbstractDataAccessVec_4 & ABSTRACTAUTOReg_autoexecdata[1] | dmiAbstractDataAccessVec_8 & ABSTRACTAUTOReg_autoexecdata[2] | dmiAbstractDataAccessVec_12 & ABSTRACTAUTOReg_autoexecdata[3] | dmiAbstractDataAccessVec_16 & ABSTRACTAUTOReg_autoexecdata[4] | dmiAbstractDataAccessVec_20 & ABSTRACTAUTOReg_autoexecdata[5] | dmiAbstractDataAccessVec_24 & ABSTRACTAUTOReg_autoexecdata[6] | dmiAbstractDataAccessVec_28 & ABSTRACTAUTOReg_autoexecdata[7] | dmiProgramBufferAccessVec_0 & ABSTRACTAUTOReg_autoexecprogbuf[0] | dmiProgramBufferAccessVec_4 & ABSTRACTAUTOReg_autoexecprogbuf[1] | dmiProgramBufferAccessVec_8 & ABSTRACTAUTOReg_autoexecprogbuf[2] | dmiProgramBufferAccessVec_12 & ABSTRACTAUTOReg_autoexecprogbuf[3] | dmiProgramBufferAccessVec_16 & ABSTRACTAUTOReg_autoexecprogbuf[4] | dmiProgramBufferAccessVec_20 & ABSTRACTAUTOReg_autoexecprogbuf[5] | dmiProgramBufferAccessVec_24 & ABSTRACTAUTOReg_autoexecprogbuf[6] | dmiProgramBufferAccessVec_28 & ABSTRACTAUTOReg_autoexecprogbuf[7] | dmiProgramBufferAccessVec_32 & ABSTRACTAUTOReg_autoexecprogbuf[8] | dmiProgramBufferAccessVec_36 & ABSTRACTAUTOReg_autoexecprogbuf[9] | dmiProgramBufferAccessVec_40 & ABSTRACTAUTOReg_autoexecprogbuf[10] | dmiProgramBufferAccessVec_44 & ABSTRACTAUTOReg_autoexecprogbuf[11] | dmiProgramBufferAccessVec_48 & ABSTRACTAUTOReg_autoexecprogbuf[12] | dmiProgramBufferAccessVec_52 & ABSTRACTAUTOReg_autoexecprogbuf[13] | dmiProgramBufferAccessVec_56 & ABSTRACTAUTOReg_autoexecprogbuf[14] | dmiProgramBufferAccessVec_60 & ABSTRACTAUTOReg_autoexecprogbuf[15];
  wire        _GEN_5 = COMMANDWrEn & ~(|(COMMANDWrDataVal[31:24])) & _regAccessRegisterCommand_T_1 | autoexec & commandRegIsAccessRegister & _regAccessRegisterCommand_T_1;
  wire        out_woready__44 = _out_wofireMux_T_2 & auto_dmi_in_a_bits_address[7:2] == 6'h18 & ~(auto_dmi_in_a_bits_address[8]);
  wire        autoexecdataWrEnMaybe = out_woready__44 & auto_dmi_in_a_bits_mask[0];
  wire        autoexecprogbufWrEnMaybe = out_woready__44 & (&{_out_backMask_T_11, _out_backMask_T_9});
  wire        dmiAbstractDataWrEnMaybe_1 = out_woready__32 & auto_dmi_in_a_bits_mask[1];
  wire        dmiAbstractDataWrEnMaybe_2 = out_woready__32 & auto_dmi_in_a_bits_mask[2];
  wire        dmiAbstractDataWrEnMaybe_3 = out_woready__32 & auto_dmi_in_a_bits_mask[3];
  wire        dmiAbstractDataWrEnMaybe_5 = out_woready__0 & auto_dmi_in_a_bits_mask[1];
  wire        dmiAbstractDataWrEnMaybe_6 = out_woready__0 & auto_dmi_in_a_bits_mask[2];
  wire        dmiAbstractDataWrEnMaybe_7 = out_woready__0 & auto_dmi_in_a_bits_mask[3];
  wire        dmiAbstractDataWrEnMaybe_9 = out_woready__12 & auto_dmi_in_a_bits_mask[1];
  wire        dmiAbstractDataWrEnMaybe_10 = out_woready__12 & auto_dmi_in_a_bits_mask[2];
  wire        dmiAbstractDataWrEnMaybe_11 = out_woready__12 & auto_dmi_in_a_bits_mask[3];
  wire        dmiAbstractDataWrEnMaybe_13 = out_woready__102 & auto_dmi_in_a_bits_mask[1];
  wire        dmiAbstractDataWrEnMaybe_14 = out_woready__102 & auto_dmi_in_a_bits_mask[2];
  wire        dmiAbstractDataWrEnMaybe_15 = out_woready__102 & auto_dmi_in_a_bits_mask[3];
  wire        dmiAbstractDataWrEnMaybe_17 = out_woready__28 & auto_dmi_in_a_bits_mask[1];
  wire        dmiAbstractDataWrEnMaybe_18 = out_woready__28 & auto_dmi_in_a_bits_mask[2];
  wire        dmiAbstractDataWrEnMaybe_19 = out_woready__28 & auto_dmi_in_a_bits_mask[3];
  wire        dmiAbstractDataWrEnMaybe_21 = out_woready__16 & auto_dmi_in_a_bits_mask[1];
  wire        dmiAbstractDataWrEnMaybe_22 = out_woready__16 & auto_dmi_in_a_bits_mask[2];
  wire        dmiAbstractDataWrEnMaybe_23 = out_woready__16 & auto_dmi_in_a_bits_mask[3];
  wire        dmiAbstractDataWrEnMaybe_25 = out_woready__4 & auto_dmi_in_a_bits_mask[1];
  wire        dmiAbstractDataWrEnMaybe_26 = out_woready__4 & auto_dmi_in_a_bits_mask[2];
  wire        dmiAbstractDataWrEnMaybe_27 = out_woready__4 & auto_dmi_in_a_bits_mask[3];
  wire        dmiAbstractDataWrEnMaybe_29 = out_woready__110 & auto_dmi_in_a_bits_mask[1];
  wire        dmiAbstractDataWrEnMaybe_30 = out_woready__110 & auto_dmi_in_a_bits_mask[2];
  wire        dmiAbstractDataWrEnMaybe_31 = out_woready__110 & auto_dmi_in_a_bits_mask[3];
  wire        dmiProgramBufferWrEnMaybe_1 = out_woready__83 & auto_dmi_in_a_bits_mask[1];
  wire        dmiProgramBufferWrEnMaybe_2 = out_woready__83 & auto_dmi_in_a_bits_mask[2];
  wire        dmiProgramBufferWrEnMaybe_3 = out_woready__83 & auto_dmi_in_a_bits_mask[3];
  wire        dmiProgramBufferWrEnMaybe_5 = out_woready__55 & auto_dmi_in_a_bits_mask[1];
  wire        dmiProgramBufferWrEnMaybe_6 = out_woready__55 & auto_dmi_in_a_bits_mask[2];
  wire        dmiProgramBufferWrEnMaybe_7 = out_woready__55 & auto_dmi_in_a_bits_mask[3];
  wire        dmiProgramBufferWrEnMaybe_9 = out_woready__87 & auto_dmi_in_a_bits_mask[1];
  wire        dmiProgramBufferWrEnMaybe_10 = out_woready__87 & auto_dmi_in_a_bits_mask[2];
  wire        dmiProgramBufferWrEnMaybe_11 = out_woready__87 & auto_dmi_in_a_bits_mask[3];
  wire        dmiProgramBufferWrEnMaybe_13 = out_woready__24 & auto_dmi_in_a_bits_mask[1];
  wire        dmiProgramBufferWrEnMaybe_14 = out_woready__24 & auto_dmi_in_a_bits_mask[2];
  wire        dmiProgramBufferWrEnMaybe_15 = out_woready__24 & auto_dmi_in_a_bits_mask[3];
  wire        dmiProgramBufferWrEnMaybe_17 = out_woready__123 & auto_dmi_in_a_bits_mask[1];
  wire        dmiProgramBufferWrEnMaybe_18 = out_woready__123 & auto_dmi_in_a_bits_mask[2];
  wire        dmiProgramBufferWrEnMaybe_19 = out_woready__123 & auto_dmi_in_a_bits_mask[3];
  wire        dmiProgramBufferWrEnMaybe_21 = out_woready__47 & auto_dmi_in_a_bits_mask[1];
  wire        dmiProgramBufferWrEnMaybe_22 = out_woready__47 & auto_dmi_in_a_bits_mask[2];
  wire        dmiProgramBufferWrEnMaybe_23 = out_woready__47 & auto_dmi_in_a_bits_mask[3];
  wire        dmiProgramBufferWrEnMaybe_25 = out_woready__51 & auto_dmi_in_a_bits_mask[1];
  wire        dmiProgramBufferWrEnMaybe_26 = out_woready__51 & auto_dmi_in_a_bits_mask[2];
  wire        dmiProgramBufferWrEnMaybe_27 = out_woready__51 & auto_dmi_in_a_bits_mask[3];
  wire        dmiProgramBufferWrEnMaybe_29 = out_woready__106 & auto_dmi_in_a_bits_mask[1];
  wire        dmiProgramBufferWrEnMaybe_30 = out_woready__106 & auto_dmi_in_a_bits_mask[2];
  wire        dmiProgramBufferWrEnMaybe_31 = out_woready__106 & auto_dmi_in_a_bits_mask[3];
  wire        dmiProgramBufferWrEnMaybe_33 = out_woready__118 & auto_dmi_in_a_bits_mask[1];
  wire        dmiProgramBufferWrEnMaybe_34 = out_woready__118 & auto_dmi_in_a_bits_mask[2];
  wire        dmiProgramBufferWrEnMaybe_35 = out_woready__118 & auto_dmi_in_a_bits_mask[3];
  wire        dmiProgramBufferWrEnMaybe_37 = out_woready__20 & auto_dmi_in_a_bits_mask[1];
  wire        dmiProgramBufferWrEnMaybe_38 = out_woready__20 & auto_dmi_in_a_bits_mask[2];
  wire        dmiProgramBufferWrEnMaybe_39 = out_woready__20 & auto_dmi_in_a_bits_mask[3];
  wire        dmiProgramBufferWrEnMaybe_41 = out_woready__40 & auto_dmi_in_a_bits_mask[1];
  wire        dmiProgramBufferWrEnMaybe_42 = out_woready__40 & auto_dmi_in_a_bits_mask[2];
  wire        dmiProgramBufferWrEnMaybe_43 = out_woready__40 & auto_dmi_in_a_bits_mask[3];
  wire        dmiProgramBufferWrEnMaybe_45 = out_woready__114 & auto_dmi_in_a_bits_mask[1];
  wire        dmiProgramBufferWrEnMaybe_46 = out_woready__114 & auto_dmi_in_a_bits_mask[2];
  wire        dmiProgramBufferWrEnMaybe_47 = out_woready__114 & auto_dmi_in_a_bits_mask[3];
  wire        dmiProgramBufferWrEnMaybe_49 = out_woready__98 & auto_dmi_in_a_bits_mask[1];
  wire        dmiProgramBufferWrEnMaybe_50 = out_woready__98 & auto_dmi_in_a_bits_mask[2];
  wire        dmiProgramBufferWrEnMaybe_51 = out_woready__98 & auto_dmi_in_a_bits_mask[3];
  wire        dmiProgramBufferWrEnMaybe_53 = out_woready__59 & auto_dmi_in_a_bits_mask[1];
  wire        dmiProgramBufferWrEnMaybe_54 = out_woready__59 & auto_dmi_in_a_bits_mask[2];
  wire        dmiProgramBufferWrEnMaybe_55 = out_woready__59 & auto_dmi_in_a_bits_mask[3];
  wire        dmiProgramBufferWrEnMaybe_57 = out_woready__8 & auto_dmi_in_a_bits_mask[1];
  wire        dmiProgramBufferWrEnMaybe_58 = out_woready__8 & auto_dmi_in_a_bits_mask[2];
  wire        dmiProgramBufferWrEnMaybe_59 = out_woready__8 & auto_dmi_in_a_bits_mask[3];
  wire        dmiProgramBufferWrEnMaybe_61 = out_woready__36 & auto_dmi_in_a_bits_mask[1];
  wire        dmiProgramBufferWrEnMaybe_62 = out_woready__36 & auto_dmi_in_a_bits_mask[2];
  wire        dmiProgramBufferWrEnMaybe_63 = out_woready__36 & auto_dmi_in_a_bits_mask[3];
  wire        out_woready_1_32 = _out_wofireMux_T_262 & auto_tl_in_a_bits_address[10:3] == 8'h73 & ~(auto_tl_in_a_bits_address[11]);
  wire        out_woready_1_112 = _out_wofireMux_T_262 & auto_tl_in_a_bits_address[10:3] == 8'h6E & ~(auto_tl_in_a_bits_address[11]);
  wire        out_woready_1_192 = _out_wofireMux_T_262 & auto_tl_in_a_bits_address[10:3] == 8'h6A & ~(auto_tl_in_a_bits_address[11]);
  wire        out_woready_1_443 = _out_wofireMux_T_262 & auto_tl_in_a_bits_address[10:3] == 8'h6D & ~(auto_tl_in_a_bits_address[11]);
  wire        out_woready_1_511 = _out_wofireMux_T_262 & auto_tl_in_a_bits_address[10:3] == 8'h69 & ~(auto_tl_in_a_bits_address[11]);
  wire        out_woready_1_657 = _out_wofireMux_T_262 & auto_tl_in_a_bits_address[10:3] == 8'h71 & ~(auto_tl_in_a_bits_address[11]);
  wire        out_woready_1_731 = _out_wofireMux_T_262 & auto_tl_in_a_bits_address[10:3] == 8'h6C & ~(auto_tl_in_a_bits_address[11]);
  wire        out_woready_1_827 = _out_wofireMux_T_262 & auto_tl_in_a_bits_address[10:3] == 8'h70 & ~(auto_tl_in_a_bits_address[11]);
  wire        out_woready_1_931 = _out_wofireMux_T_262 & auto_tl_in_a_bits_address[10:3] == 8'h68 & ~(auto_tl_in_a_bits_address[11]);
  wire        out_woready_1_979 = _out_wofireMux_T_262 & auto_tl_in_a_bits_address[10:3] == 8'h72 & ~(auto_tl_in_a_bits_address[11]);
  wire        out_woready_1_1091 = _out_wofireMux_T_262 & auto_tl_in_a_bits_address[10:3] == 8'h6B & ~(auto_tl_in_a_bits_address[11]);
  wire        out_woready_1_1163 = _out_wofireMux_T_262 & auto_tl_in_a_bits_address[10:3] == 8'h6F & ~(auto_tl_in_a_bits_address[11]);
  wire [9:0]  _out_romask_T_663 = {{2{auto_tl_in_a_bits_mask[1]}}, {8{auto_tl_in_a_bits_mask[0]}}};
  wire        hartResumingWrEn = out_woready_1_353 & (&_out_romask_T_663);
  wire        hartHaltedWrEn = out_woready_1_535 & (&_out_romask_T_663);
  always @(posedge clock) begin
    haltedBitRegs <= io_dmactive & (hartHaltedWrEn | ~hartResumingWrEn & haltedBitRegs) & ~_hartIsInResetSync_0_debug_hartReset_0_io_q;
    resumeReqRegs <= io_dmactive & (resumereq ? (resumeReqRegs | ~(|io_innerCtrl_bits_hartsel)) & ~_hartIsInResetSync_0_debug_hartReset_0_io_q : ~hartResumingWrEn & resumeReqRegs & ~_hartIsInResetSync_0_debug_hartReset_0_io_q);
    haveResetBitRegs <= io_dmactive & (io_innerCtrl_valid & io_innerCtrl_bits_ackhavereset ? haveResetBitRegs & (|io_innerCtrl_bits_hartsel) | _hartIsInResetSync_0_debug_hartReset_0_io_q : haveResetBitRegs | _hartIsInResetSync_0_debug_hartReset_0_io_q);
    hrmaskReg_0 <= ~(reset | ~io_dmactive) & (io_innerCtrl_valid ? io_innerCtrl_bits_hrmask_0 : hrmaskReg_0);
    if (io_dmactive) begin
      if (ABSTRACTCSWrEnMaybe & (|ctrlStateReg) | autoexecdataWrEnMaybe & (|ctrlStateReg) | autoexecprogbufWrEnMaybe & (|ctrlStateReg) | COMMANDWrEnMaybe & (|ctrlStateReg)
          | (dmiAbstractDataAccessVec_0 | dmiAbstractDataWrEnMaybe_1 | out_roready__32 & auto_dmi_in_a_bits_mask[1] | dmiAbstractDataWrEnMaybe_2 | out_roready__32 & auto_dmi_in_a_bits_mask[2] | dmiAbstractDataWrEnMaybe_3 | out_roready__32 & auto_dmi_in_a_bits_mask[3] | dmiAbstractDataAccessVec_4 | dmiAbstractDataWrEnMaybe_5 | out_roready__0 & auto_dmi_in_a_bits_mask[1] | dmiAbstractDataWrEnMaybe_6 | out_roready__0 & auto_dmi_in_a_bits_mask[2] | dmiAbstractDataWrEnMaybe_7 | out_roready__0 & auto_dmi_in_a_bits_mask[3] | dmiAbstractDataAccessVec_8 | dmiAbstractDataWrEnMaybe_9 | out_roready__12 & auto_dmi_in_a_bits_mask[1] | dmiAbstractDataWrEnMaybe_10 | out_roready__12 & auto_dmi_in_a_bits_mask[2] | dmiAbstractDataWrEnMaybe_11 | out_roready__12 & auto_dmi_in_a_bits_mask[3] | dmiAbstractDataAccessVec_12 | dmiAbstractDataWrEnMaybe_13 | out_roready__102 & auto_dmi_in_a_bits_mask[1] | dmiAbstractDataWrEnMaybe_14 | out_roready__102 & auto_dmi_in_a_bits_mask[2] | dmiAbstractDataWrEnMaybe_15 | out_roready__102 & auto_dmi_in_a_bits_mask[3] | dmiAbstractDataAccessVec_16 | dmiAbstractDataWrEnMaybe_17 | out_roready__28 & auto_dmi_in_a_bits_mask[1] | dmiAbstractDataWrEnMaybe_18 | out_roready__28 & auto_dmi_in_a_bits_mask[2] | dmiAbstractDataWrEnMaybe_19 | out_roready__28 & auto_dmi_in_a_bits_mask[3] | dmiAbstractDataAccessVec_20 | dmiAbstractDataWrEnMaybe_21 | out_roready__16 & auto_dmi_in_a_bits_mask[1] | dmiAbstractDataWrEnMaybe_22 | out_roready__16 & auto_dmi_in_a_bits_mask[2] | dmiAbstractDataWrEnMaybe_23 | out_roready__16 & auto_dmi_in_a_bits_mask[3] | dmiAbstractDataAccessVec_24 | dmiAbstractDataWrEnMaybe_25 | out_roready__4 & auto_dmi_in_a_bits_mask[1] | dmiAbstractDataWrEnMaybe_26 | out_roready__4 & auto_dmi_in_a_bits_mask[2] | dmiAbstractDataWrEnMaybe_27 | out_roready__4 & auto_dmi_in_a_bits_mask[3] | dmiAbstractDataAccessVec_28 | dmiAbstractDataWrEnMaybe_29 | out_roready__110 & auto_dmi_in_a_bits_mask[1] | dmiAbstractDataWrEnMaybe_30 | out_roready__110 & auto_dmi_in_a_bits_mask[2] | dmiAbstractDataWrEnMaybe_31
             | out_roready__110 & auto_dmi_in_a_bits_mask[3]) & (|ctrlStateReg)
          | (dmiProgramBufferAccessVec_0 | dmiProgramBufferWrEnMaybe_1 | out_roready__83 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_2 | out_roready__83 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_3 | out_roready__83 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_4 | dmiProgramBufferWrEnMaybe_5 | out_roready__55 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_6 | out_roready__55 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_7 | out_roready__55 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_8 | dmiProgramBufferWrEnMaybe_9 | out_roready__87 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_10 | out_roready__87 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_11 | out_roready__87 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_12 | dmiProgramBufferWrEnMaybe_13 | out_roready__24 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_14 | out_roready__24 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_15 | out_roready__24 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_16 | dmiProgramBufferWrEnMaybe_17 | out_roready__123 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_18 | out_roready__123 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_19 | out_roready__123 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_20 | dmiProgramBufferWrEnMaybe_21 | out_roready__47 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_22 | out_roready__47 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_23 | out_roready__47 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_24 | dmiProgramBufferWrEnMaybe_25 | out_roready__51 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_26 | out_roready__51 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_27 | out_roready__51 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_28 | dmiProgramBufferWrEnMaybe_29 | out_roready__106 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_30 | out_roready__106 & auto_dmi_in_a_bits_mask[2]
             | dmiProgramBufferWrEnMaybe_31 | out_roready__106 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_32 | dmiProgramBufferWrEnMaybe_33 | out_roready__118 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_34 | out_roready__118 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_35 | out_roready__118 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_36 | dmiProgramBufferWrEnMaybe_37 | out_roready__20 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_38 | out_roready__20 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_39 | out_roready__20 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_40 | dmiProgramBufferWrEnMaybe_41 | out_roready__40 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_42 | out_roready__40 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_43 | out_roready__40 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_44 | dmiProgramBufferWrEnMaybe_45 | out_roready__114 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_46 | out_roready__114 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_47 | out_roready__114 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_48 | dmiProgramBufferWrEnMaybe_49 | out_roready__98 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_50 | out_roready__98 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_51 | out_roready__98 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_52 | dmiProgramBufferWrEnMaybe_53 | out_roready__59 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_54 | out_roready__59 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_55 | out_roready__59 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_56 | dmiProgramBufferWrEnMaybe_57 | out_roready__8 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_58 | out_roready__8 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_59 | out_roready__8 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_60 | dmiProgramBufferWrEnMaybe_61 | out_roready__36
             & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_62 | out_roready__36 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_63 | out_roready__36 & auto_dmi_in_a_bits_mask[3]) & (|ctrlStateReg))
        ABSTRACTCSReg_cmderr <= 3'h1;
      else if (~(~(|ctrlStateReg) | _GEN_0) & _GEN_2 & hartExceptionWrEn)
        ABSTRACTCSReg_cmderr <= 3'h3;
      else if ((|ctrlStateReg) ? _GEN_0 & commandRegIsUnsupported : ~_GEN_5 & (COMMANDWrEn & (|(COMMANDWrDataVal[31:24])) | autoexec & commandRegIsUnsupported))
        ABSTRACTCSReg_cmderr <= 3'h2;
      else if ((|ctrlStateReg) & _GEN_0 & ~commandRegIsUnsupported & commandRegBadHaltResume)
        ABSTRACTCSReg_cmderr <= 3'h4;
      else
        ABSTRACTCSReg_cmderr <= ({3{~(ABSTRACTCSWrEnMaybe & ~(|ctrlStateReg))}} | ~(auto_dmi_in_a_bits_data[10:8])) & ABSTRACTCSReg_cmderr;
      if (|ctrlStateReg) begin
        if (_GEN_0)
          ctrlStateReg <= {~(commandRegIsUnsupported | commandRegBadHaltResume), 1'h0};
        else if (_GEN_2 & (hartExceptionWrEn | ~goReg & hartHaltedWrEn))
          ctrlStateReg <= 2'h0;
      end
      else if (_GEN_5)
        ctrlStateReg <= 2'h1;
      if (COMMANDWrEn) begin
        COMMANDReg_cmdtype <= COMMANDWrDataVal[31:24];
        COMMANDReg_control <= COMMANDWrDataVal[23:0];
      end
      if (autoexecdataWrEnMaybe & ~(|ctrlStateReg))
        ABSTRACTAUTOReg_autoexecdata <= {4'h0, auto_dmi_in_a_bits_data[7:0]};
      if (autoexecprogbufWrEnMaybe & ~(|ctrlStateReg))
        ABSTRACTAUTOReg_autoexecprogbuf <= auto_dmi_in_a_bits_data[31:16];
      if (out_woready_1_827 & auto_tl_in_a_bits_mask[0])
        abstractDataMem_0 <= auto_tl_in_a_bits_data[7:0];
      else if (dmiAbstractDataWrEnMaybe_0 & ~(|ctrlStateReg))
        abstractDataMem_0 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_827 & auto_tl_in_a_bits_mask[1])
        abstractDataMem_1 <= auto_tl_in_a_bits_data[15:8];
      else if (dmiAbstractDataWrEnMaybe_1 & ~(|ctrlStateReg))
        abstractDataMem_1 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_827 & auto_tl_in_a_bits_mask[2])
        abstractDataMem_2 <= auto_tl_in_a_bits_data[23:16];
      else if (dmiAbstractDataWrEnMaybe_2 & ~(|ctrlStateReg))
        abstractDataMem_2 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_827 & auto_tl_in_a_bits_mask[3])
        abstractDataMem_3 <= auto_tl_in_a_bits_data[31:24];
      else if (dmiAbstractDataWrEnMaybe_3 & ~(|ctrlStateReg))
        abstractDataMem_3 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_827 & auto_tl_in_a_bits_mask[4])
        abstractDataMem_4 <= auto_tl_in_a_bits_data[39:32];
      else if (dmiAbstractDataWrEnMaybe_4 & ~(|ctrlStateReg))
        abstractDataMem_4 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_827 & auto_tl_in_a_bits_mask[5])
        abstractDataMem_5 <= auto_tl_in_a_bits_data[47:40];
      else if (dmiAbstractDataWrEnMaybe_5 & ~(|ctrlStateReg))
        abstractDataMem_5 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_827 & auto_tl_in_a_bits_mask[6])
        abstractDataMem_6 <= auto_tl_in_a_bits_data[55:48];
      else if (dmiAbstractDataWrEnMaybe_6 & ~(|ctrlStateReg))
        abstractDataMem_6 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_827 & auto_tl_in_a_bits_mask[7])
        abstractDataMem_7 <= auto_tl_in_a_bits_data[63:56];
      else if (dmiAbstractDataWrEnMaybe_7 & ~(|ctrlStateReg))
        abstractDataMem_7 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_657 & auto_tl_in_a_bits_mask[0])
        abstractDataMem_8 <= auto_tl_in_a_bits_data[7:0];
      else if (dmiAbstractDataWrEnMaybe_8 & ~(|ctrlStateReg))
        abstractDataMem_8 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_657 & auto_tl_in_a_bits_mask[1])
        abstractDataMem_9 <= auto_tl_in_a_bits_data[15:8];
      else if (dmiAbstractDataWrEnMaybe_9 & ~(|ctrlStateReg))
        abstractDataMem_9 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_657 & auto_tl_in_a_bits_mask[2])
        abstractDataMem_10 <= auto_tl_in_a_bits_data[23:16];
      else if (dmiAbstractDataWrEnMaybe_10 & ~(|ctrlStateReg))
        abstractDataMem_10 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_657 & auto_tl_in_a_bits_mask[3])
        abstractDataMem_11 <= auto_tl_in_a_bits_data[31:24];
      else if (dmiAbstractDataWrEnMaybe_11 & ~(|ctrlStateReg))
        abstractDataMem_11 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_657 & auto_tl_in_a_bits_mask[4])
        abstractDataMem_12 <= auto_tl_in_a_bits_data[39:32];
      else if (dmiAbstractDataWrEnMaybe_12 & ~(|ctrlStateReg))
        abstractDataMem_12 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_657 & auto_tl_in_a_bits_mask[5])
        abstractDataMem_13 <= auto_tl_in_a_bits_data[47:40];
      else if (dmiAbstractDataWrEnMaybe_13 & ~(|ctrlStateReg))
        abstractDataMem_13 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_657 & auto_tl_in_a_bits_mask[6])
        abstractDataMem_14 <= auto_tl_in_a_bits_data[55:48];
      else if (dmiAbstractDataWrEnMaybe_14 & ~(|ctrlStateReg))
        abstractDataMem_14 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_657 & auto_tl_in_a_bits_mask[7])
        abstractDataMem_15 <= auto_tl_in_a_bits_data[63:56];
      else if (dmiAbstractDataWrEnMaybe_15 & ~(|ctrlStateReg))
        abstractDataMem_15 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_979 & auto_tl_in_a_bits_mask[0])
        abstractDataMem_16 <= auto_tl_in_a_bits_data[7:0];
      else if (dmiAbstractDataWrEnMaybe_16 & ~(|ctrlStateReg))
        abstractDataMem_16 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_979 & auto_tl_in_a_bits_mask[1])
        abstractDataMem_17 <= auto_tl_in_a_bits_data[15:8];
      else if (dmiAbstractDataWrEnMaybe_17 & ~(|ctrlStateReg))
        abstractDataMem_17 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_979 & auto_tl_in_a_bits_mask[2])
        abstractDataMem_18 <= auto_tl_in_a_bits_data[23:16];
      else if (dmiAbstractDataWrEnMaybe_18 & ~(|ctrlStateReg))
        abstractDataMem_18 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_979 & auto_tl_in_a_bits_mask[3])
        abstractDataMem_19 <= auto_tl_in_a_bits_data[31:24];
      else if (dmiAbstractDataWrEnMaybe_19 & ~(|ctrlStateReg))
        abstractDataMem_19 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_979 & auto_tl_in_a_bits_mask[4])
        abstractDataMem_20 <= auto_tl_in_a_bits_data[39:32];
      else if (dmiAbstractDataWrEnMaybe_20 & ~(|ctrlStateReg))
        abstractDataMem_20 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_979 & auto_tl_in_a_bits_mask[5])
        abstractDataMem_21 <= auto_tl_in_a_bits_data[47:40];
      else if (dmiAbstractDataWrEnMaybe_21 & ~(|ctrlStateReg))
        abstractDataMem_21 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_979 & auto_tl_in_a_bits_mask[6])
        abstractDataMem_22 <= auto_tl_in_a_bits_data[55:48];
      else if (dmiAbstractDataWrEnMaybe_22 & ~(|ctrlStateReg))
        abstractDataMem_22 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_979 & auto_tl_in_a_bits_mask[7])
        abstractDataMem_23 <= auto_tl_in_a_bits_data[63:56];
      else if (dmiAbstractDataWrEnMaybe_23 & ~(|ctrlStateReg))
        abstractDataMem_23 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_32 & auto_tl_in_a_bits_mask[0])
        abstractDataMem_24 <= auto_tl_in_a_bits_data[7:0];
      else if (dmiAbstractDataWrEnMaybe_24 & ~(|ctrlStateReg))
        abstractDataMem_24 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_32 & auto_tl_in_a_bits_mask[1])
        abstractDataMem_25 <= auto_tl_in_a_bits_data[15:8];
      else if (dmiAbstractDataWrEnMaybe_25 & ~(|ctrlStateReg))
        abstractDataMem_25 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_32 & auto_tl_in_a_bits_mask[2])
        abstractDataMem_26 <= auto_tl_in_a_bits_data[23:16];
      else if (dmiAbstractDataWrEnMaybe_26 & ~(|ctrlStateReg))
        abstractDataMem_26 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_32 & auto_tl_in_a_bits_mask[3])
        abstractDataMem_27 <= auto_tl_in_a_bits_data[31:24];
      else if (dmiAbstractDataWrEnMaybe_27 & ~(|ctrlStateReg))
        abstractDataMem_27 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_32 & auto_tl_in_a_bits_mask[4])
        abstractDataMem_28 <= auto_tl_in_a_bits_data[39:32];
      else if (dmiAbstractDataWrEnMaybe_28 & ~(|ctrlStateReg))
        abstractDataMem_28 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_32 & auto_tl_in_a_bits_mask[5])
        abstractDataMem_29 <= auto_tl_in_a_bits_data[47:40];
      else if (dmiAbstractDataWrEnMaybe_29 & ~(|ctrlStateReg))
        abstractDataMem_29 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_32 & auto_tl_in_a_bits_mask[6])
        abstractDataMem_30 <= auto_tl_in_a_bits_data[55:48];
      else if (dmiAbstractDataWrEnMaybe_30 & ~(|ctrlStateReg))
        abstractDataMem_30 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_32 & auto_tl_in_a_bits_mask[7])
        abstractDataMem_31 <= auto_tl_in_a_bits_data[63:56];
      else if (dmiAbstractDataWrEnMaybe_31 & ~(|ctrlStateReg))
        abstractDataMem_31 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_931 & auto_tl_in_a_bits_mask[0])
        programBufferMem_0 <= auto_tl_in_a_bits_data[7:0];
      else if (dmiProgramBufferWrEnMaybe_0 & ~(|ctrlStateReg))
        programBufferMem_0 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_931 & auto_tl_in_a_bits_mask[1])
        programBufferMem_1 <= auto_tl_in_a_bits_data[15:8];
      else if (dmiProgramBufferWrEnMaybe_1 & ~(|ctrlStateReg))
        programBufferMem_1 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_931 & auto_tl_in_a_bits_mask[2])
        programBufferMem_2 <= auto_tl_in_a_bits_data[23:16];
      else if (dmiProgramBufferWrEnMaybe_2 & ~(|ctrlStateReg))
        programBufferMem_2 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_931 & auto_tl_in_a_bits_mask[3])
        programBufferMem_3 <= auto_tl_in_a_bits_data[31:24];
      else if (dmiProgramBufferWrEnMaybe_3 & ~(|ctrlStateReg))
        programBufferMem_3 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_931 & auto_tl_in_a_bits_mask[4])
        programBufferMem_4 <= auto_tl_in_a_bits_data[39:32];
      else if (dmiProgramBufferWrEnMaybe_4 & ~(|ctrlStateReg))
        programBufferMem_4 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_931 & auto_tl_in_a_bits_mask[5])
        programBufferMem_5 <= auto_tl_in_a_bits_data[47:40];
      else if (dmiProgramBufferWrEnMaybe_5 & ~(|ctrlStateReg))
        programBufferMem_5 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_931 & auto_tl_in_a_bits_mask[6])
        programBufferMem_6 <= auto_tl_in_a_bits_data[55:48];
      else if (dmiProgramBufferWrEnMaybe_6 & ~(|ctrlStateReg))
        programBufferMem_6 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_931 & auto_tl_in_a_bits_mask[7])
        programBufferMem_7 <= auto_tl_in_a_bits_data[63:56];
      else if (dmiProgramBufferWrEnMaybe_7 & ~(|ctrlStateReg))
        programBufferMem_7 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_511 & auto_tl_in_a_bits_mask[0])
        programBufferMem_8 <= auto_tl_in_a_bits_data[7:0];
      else if (dmiProgramBufferWrEnMaybe_8 & ~(|ctrlStateReg))
        programBufferMem_8 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_511 & auto_tl_in_a_bits_mask[1])
        programBufferMem_9 <= auto_tl_in_a_bits_data[15:8];
      else if (dmiProgramBufferWrEnMaybe_9 & ~(|ctrlStateReg))
        programBufferMem_9 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_511 & auto_tl_in_a_bits_mask[2])
        programBufferMem_10 <= auto_tl_in_a_bits_data[23:16];
      else if (dmiProgramBufferWrEnMaybe_10 & ~(|ctrlStateReg))
        programBufferMem_10 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_511 & auto_tl_in_a_bits_mask[3])
        programBufferMem_11 <= auto_tl_in_a_bits_data[31:24];
      else if (dmiProgramBufferWrEnMaybe_11 & ~(|ctrlStateReg))
        programBufferMem_11 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_511 & auto_tl_in_a_bits_mask[4])
        programBufferMem_12 <= auto_tl_in_a_bits_data[39:32];
      else if (dmiProgramBufferWrEnMaybe_12 & ~(|ctrlStateReg))
        programBufferMem_12 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_511 & auto_tl_in_a_bits_mask[5])
        programBufferMem_13 <= auto_tl_in_a_bits_data[47:40];
      else if (dmiProgramBufferWrEnMaybe_13 & ~(|ctrlStateReg))
        programBufferMem_13 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_511 & auto_tl_in_a_bits_mask[6])
        programBufferMem_14 <= auto_tl_in_a_bits_data[55:48];
      else if (dmiProgramBufferWrEnMaybe_14 & ~(|ctrlStateReg))
        programBufferMem_14 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_511 & auto_tl_in_a_bits_mask[7])
        programBufferMem_15 <= auto_tl_in_a_bits_data[63:56];
      else if (dmiProgramBufferWrEnMaybe_15 & ~(|ctrlStateReg))
        programBufferMem_15 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_192 & auto_tl_in_a_bits_mask[0])
        programBufferMem_16 <= auto_tl_in_a_bits_data[7:0];
      else if (dmiProgramBufferWrEnMaybe_16 & ~(|ctrlStateReg))
        programBufferMem_16 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_192 & auto_tl_in_a_bits_mask[1])
        programBufferMem_17 <= auto_tl_in_a_bits_data[15:8];
      else if (dmiProgramBufferWrEnMaybe_17 & ~(|ctrlStateReg))
        programBufferMem_17 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_192 & auto_tl_in_a_bits_mask[2])
        programBufferMem_18 <= auto_tl_in_a_bits_data[23:16];
      else if (dmiProgramBufferWrEnMaybe_18 & ~(|ctrlStateReg))
        programBufferMem_18 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_192 & auto_tl_in_a_bits_mask[3])
        programBufferMem_19 <= auto_tl_in_a_bits_data[31:24];
      else if (dmiProgramBufferWrEnMaybe_19 & ~(|ctrlStateReg))
        programBufferMem_19 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_192 & auto_tl_in_a_bits_mask[4])
        programBufferMem_20 <= auto_tl_in_a_bits_data[39:32];
      else if (dmiProgramBufferWrEnMaybe_20 & ~(|ctrlStateReg))
        programBufferMem_20 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_192 & auto_tl_in_a_bits_mask[5])
        programBufferMem_21 <= auto_tl_in_a_bits_data[47:40];
      else if (dmiProgramBufferWrEnMaybe_21 & ~(|ctrlStateReg))
        programBufferMem_21 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_192 & auto_tl_in_a_bits_mask[6])
        programBufferMem_22 <= auto_tl_in_a_bits_data[55:48];
      else if (dmiProgramBufferWrEnMaybe_22 & ~(|ctrlStateReg))
        programBufferMem_22 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_192 & auto_tl_in_a_bits_mask[7])
        programBufferMem_23 <= auto_tl_in_a_bits_data[63:56];
      else if (dmiProgramBufferWrEnMaybe_23 & ~(|ctrlStateReg))
        programBufferMem_23 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_1091 & auto_tl_in_a_bits_mask[0])
        programBufferMem_24 <= auto_tl_in_a_bits_data[7:0];
      else if (dmiProgramBufferWrEnMaybe_24 & ~(|ctrlStateReg))
        programBufferMem_24 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_1091 & auto_tl_in_a_bits_mask[1])
        programBufferMem_25 <= auto_tl_in_a_bits_data[15:8];
      else if (dmiProgramBufferWrEnMaybe_25 & ~(|ctrlStateReg))
        programBufferMem_25 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_1091 & auto_tl_in_a_bits_mask[2])
        programBufferMem_26 <= auto_tl_in_a_bits_data[23:16];
      else if (dmiProgramBufferWrEnMaybe_26 & ~(|ctrlStateReg))
        programBufferMem_26 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_1091 & auto_tl_in_a_bits_mask[3])
        programBufferMem_27 <= auto_tl_in_a_bits_data[31:24];
      else if (dmiProgramBufferWrEnMaybe_27 & ~(|ctrlStateReg))
        programBufferMem_27 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_1091 & auto_tl_in_a_bits_mask[4])
        programBufferMem_28 <= auto_tl_in_a_bits_data[39:32];
      else if (dmiProgramBufferWrEnMaybe_28 & ~(|ctrlStateReg))
        programBufferMem_28 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_1091 & auto_tl_in_a_bits_mask[5])
        programBufferMem_29 <= auto_tl_in_a_bits_data[47:40];
      else if (dmiProgramBufferWrEnMaybe_29 & ~(|ctrlStateReg))
        programBufferMem_29 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_1091 & auto_tl_in_a_bits_mask[6])
        programBufferMem_30 <= auto_tl_in_a_bits_data[55:48];
      else if (dmiProgramBufferWrEnMaybe_30 & ~(|ctrlStateReg))
        programBufferMem_30 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_1091 & auto_tl_in_a_bits_mask[7])
        programBufferMem_31 <= auto_tl_in_a_bits_data[63:56];
      else if (dmiProgramBufferWrEnMaybe_31 & ~(|ctrlStateReg))
        programBufferMem_31 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_731 & auto_tl_in_a_bits_mask[0])
        programBufferMem_32 <= auto_tl_in_a_bits_data[7:0];
      else if (dmiProgramBufferWrEnMaybe_32 & ~(|ctrlStateReg))
        programBufferMem_32 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_731 & auto_tl_in_a_bits_mask[1])
        programBufferMem_33 <= auto_tl_in_a_bits_data[15:8];
      else if (dmiProgramBufferWrEnMaybe_33 & ~(|ctrlStateReg))
        programBufferMem_33 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_731 & auto_tl_in_a_bits_mask[2])
        programBufferMem_34 <= auto_tl_in_a_bits_data[23:16];
      else if (dmiProgramBufferWrEnMaybe_34 & ~(|ctrlStateReg))
        programBufferMem_34 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_731 & auto_tl_in_a_bits_mask[3])
        programBufferMem_35 <= auto_tl_in_a_bits_data[31:24];
      else if (dmiProgramBufferWrEnMaybe_35 & ~(|ctrlStateReg))
        programBufferMem_35 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_731 & auto_tl_in_a_bits_mask[4])
        programBufferMem_36 <= auto_tl_in_a_bits_data[39:32];
      else if (dmiProgramBufferWrEnMaybe_36 & ~(|ctrlStateReg))
        programBufferMem_36 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_731 & auto_tl_in_a_bits_mask[5])
        programBufferMem_37 <= auto_tl_in_a_bits_data[47:40];
      else if (dmiProgramBufferWrEnMaybe_37 & ~(|ctrlStateReg))
        programBufferMem_37 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_731 & auto_tl_in_a_bits_mask[6])
        programBufferMem_38 <= auto_tl_in_a_bits_data[55:48];
      else if (dmiProgramBufferWrEnMaybe_38 & ~(|ctrlStateReg))
        programBufferMem_38 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_731 & auto_tl_in_a_bits_mask[7])
        programBufferMem_39 <= auto_tl_in_a_bits_data[63:56];
      else if (dmiProgramBufferWrEnMaybe_39 & ~(|ctrlStateReg))
        programBufferMem_39 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_443 & auto_tl_in_a_bits_mask[0])
        programBufferMem_40 <= auto_tl_in_a_bits_data[7:0];
      else if (dmiProgramBufferWrEnMaybe_40 & ~(|ctrlStateReg))
        programBufferMem_40 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_443 & auto_tl_in_a_bits_mask[1])
        programBufferMem_41 <= auto_tl_in_a_bits_data[15:8];
      else if (dmiProgramBufferWrEnMaybe_41 & ~(|ctrlStateReg))
        programBufferMem_41 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_443 & auto_tl_in_a_bits_mask[2])
        programBufferMem_42 <= auto_tl_in_a_bits_data[23:16];
      else if (dmiProgramBufferWrEnMaybe_42 & ~(|ctrlStateReg))
        programBufferMem_42 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_443 & auto_tl_in_a_bits_mask[3])
        programBufferMem_43 <= auto_tl_in_a_bits_data[31:24];
      else if (dmiProgramBufferWrEnMaybe_43 & ~(|ctrlStateReg))
        programBufferMem_43 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_443 & auto_tl_in_a_bits_mask[4])
        programBufferMem_44 <= auto_tl_in_a_bits_data[39:32];
      else if (dmiProgramBufferWrEnMaybe_44 & ~(|ctrlStateReg))
        programBufferMem_44 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_443 & auto_tl_in_a_bits_mask[5])
        programBufferMem_45 <= auto_tl_in_a_bits_data[47:40];
      else if (dmiProgramBufferWrEnMaybe_45 & ~(|ctrlStateReg))
        programBufferMem_45 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_443 & auto_tl_in_a_bits_mask[6])
        programBufferMem_46 <= auto_tl_in_a_bits_data[55:48];
      else if (dmiProgramBufferWrEnMaybe_46 & ~(|ctrlStateReg))
        programBufferMem_46 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_443 & auto_tl_in_a_bits_mask[7])
        programBufferMem_47 <= auto_tl_in_a_bits_data[63:56];
      else if (dmiProgramBufferWrEnMaybe_47 & ~(|ctrlStateReg))
        programBufferMem_47 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_112 & auto_tl_in_a_bits_mask[0])
        programBufferMem_48 <= auto_tl_in_a_bits_data[7:0];
      else if (dmiProgramBufferWrEnMaybe_48 & ~(|ctrlStateReg))
        programBufferMem_48 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_112 & auto_tl_in_a_bits_mask[1])
        programBufferMem_49 <= auto_tl_in_a_bits_data[15:8];
      else if (dmiProgramBufferWrEnMaybe_49 & ~(|ctrlStateReg))
        programBufferMem_49 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_112 & auto_tl_in_a_bits_mask[2])
        programBufferMem_50 <= auto_tl_in_a_bits_data[23:16];
      else if (dmiProgramBufferWrEnMaybe_50 & ~(|ctrlStateReg))
        programBufferMem_50 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_112 & auto_tl_in_a_bits_mask[3])
        programBufferMem_51 <= auto_tl_in_a_bits_data[31:24];
      else if (dmiProgramBufferWrEnMaybe_51 & ~(|ctrlStateReg))
        programBufferMem_51 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_112 & auto_tl_in_a_bits_mask[4])
        programBufferMem_52 <= auto_tl_in_a_bits_data[39:32];
      else if (dmiProgramBufferWrEnMaybe_52 & ~(|ctrlStateReg))
        programBufferMem_52 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_112 & auto_tl_in_a_bits_mask[5])
        programBufferMem_53 <= auto_tl_in_a_bits_data[47:40];
      else if (dmiProgramBufferWrEnMaybe_53 & ~(|ctrlStateReg))
        programBufferMem_53 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_112 & auto_tl_in_a_bits_mask[6])
        programBufferMem_54 <= auto_tl_in_a_bits_data[55:48];
      else if (dmiProgramBufferWrEnMaybe_54 & ~(|ctrlStateReg))
        programBufferMem_54 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_112 & auto_tl_in_a_bits_mask[7])
        programBufferMem_55 <= auto_tl_in_a_bits_data[63:56];
      else if (dmiProgramBufferWrEnMaybe_55 & ~(|ctrlStateReg))
        programBufferMem_55 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_1163 & auto_tl_in_a_bits_mask[0])
        programBufferMem_56 <= auto_tl_in_a_bits_data[7:0];
      else if (dmiProgramBufferWrEnMaybe_56 & ~(|ctrlStateReg))
        programBufferMem_56 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_1163 & auto_tl_in_a_bits_mask[1])
        programBufferMem_57 <= auto_tl_in_a_bits_data[15:8];
      else if (dmiProgramBufferWrEnMaybe_57 & ~(|ctrlStateReg))
        programBufferMem_57 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_1163 & auto_tl_in_a_bits_mask[2])
        programBufferMem_58 <= auto_tl_in_a_bits_data[23:16];
      else if (dmiProgramBufferWrEnMaybe_58 & ~(|ctrlStateReg))
        programBufferMem_58 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_1163 & auto_tl_in_a_bits_mask[3])
        programBufferMem_59 <= auto_tl_in_a_bits_data[31:24];
      else if (dmiProgramBufferWrEnMaybe_59 & ~(|ctrlStateReg))
        programBufferMem_59 <= auto_dmi_in_a_bits_data[31:24];
      if (out_woready_1_1163 & auto_tl_in_a_bits_mask[4])
        programBufferMem_60 <= auto_tl_in_a_bits_data[39:32];
      else if (dmiProgramBufferWrEnMaybe_60 & ~(|ctrlStateReg))
        programBufferMem_60 <= auto_dmi_in_a_bits_data[7:0];
      if (out_woready_1_1163 & auto_tl_in_a_bits_mask[5])
        programBufferMem_61 <= auto_tl_in_a_bits_data[47:40];
      else if (dmiProgramBufferWrEnMaybe_61 & ~(|ctrlStateReg))
        programBufferMem_61 <= auto_dmi_in_a_bits_data[15:8];
      if (out_woready_1_1163 & auto_tl_in_a_bits_mask[6])
        programBufferMem_62 <= auto_tl_in_a_bits_data[55:48];
      else if (dmiProgramBufferWrEnMaybe_62 & ~(|ctrlStateReg))
        programBufferMem_62 <= auto_dmi_in_a_bits_data[23:16];
      if (out_woready_1_1163 & auto_tl_in_a_bits_mask[7])
        programBufferMem_63 <= auto_tl_in_a_bits_data[63:56];
      else if (dmiProgramBufferWrEnMaybe_63 & ~(|ctrlStateReg))
        programBufferMem_63 <= auto_dmi_in_a_bits_data[31:24];
    end
    else begin
      ABSTRACTCSReg_progbufsize <= 5'h10;
      ABSTRACTCSReg_cmderr <= 3'h0;
      ABSTRACTCSReg_datacount <= 4'h8;
      ctrlStateReg <= 2'h0;
      COMMANDReg_cmdtype <= 8'h0;
      COMMANDReg_control <= 24'h0;
      ABSTRACTAUTOReg_autoexecdata <= 12'h0;
      ABSTRACTAUTOReg_autoexecprogbuf <= 16'h0;
      abstractDataMem_0 <= 8'h0;
      abstractDataMem_1 <= 8'h0;
      abstractDataMem_2 <= 8'h0;
      abstractDataMem_3 <= 8'h0;
      abstractDataMem_4 <= 8'h0;
      abstractDataMem_5 <= 8'h0;
      abstractDataMem_6 <= 8'h0;
      abstractDataMem_7 <= 8'h0;
      abstractDataMem_8 <= 8'h0;
      abstractDataMem_9 <= 8'h0;
      abstractDataMem_10 <= 8'h0;
      abstractDataMem_11 <= 8'h0;
      abstractDataMem_12 <= 8'h0;
      abstractDataMem_13 <= 8'h0;
      abstractDataMem_14 <= 8'h0;
      abstractDataMem_15 <= 8'h0;
      abstractDataMem_16 <= 8'h0;
      abstractDataMem_17 <= 8'h0;
      abstractDataMem_18 <= 8'h0;
      abstractDataMem_19 <= 8'h0;
      abstractDataMem_20 <= 8'h0;
      abstractDataMem_21 <= 8'h0;
      abstractDataMem_22 <= 8'h0;
      abstractDataMem_23 <= 8'h0;
      abstractDataMem_24 <= 8'h0;
      abstractDataMem_25 <= 8'h0;
      abstractDataMem_26 <= 8'h0;
      abstractDataMem_27 <= 8'h0;
      abstractDataMem_28 <= 8'h0;
      abstractDataMem_29 <= 8'h0;
      abstractDataMem_30 <= 8'h0;
      abstractDataMem_31 <= 8'h0;
      programBufferMem_0 <= 8'h0;
      programBufferMem_1 <= 8'h0;
      programBufferMem_2 <= 8'h0;
      programBufferMem_3 <= 8'h0;
      programBufferMem_4 <= 8'h0;
      programBufferMem_5 <= 8'h0;
      programBufferMem_6 <= 8'h0;
      programBufferMem_7 <= 8'h0;
      programBufferMem_8 <= 8'h0;
      programBufferMem_9 <= 8'h0;
      programBufferMem_10 <= 8'h0;
      programBufferMem_11 <= 8'h0;
      programBufferMem_12 <= 8'h0;
      programBufferMem_13 <= 8'h0;
      programBufferMem_14 <= 8'h0;
      programBufferMem_15 <= 8'h0;
      programBufferMem_16 <= 8'h0;
      programBufferMem_17 <= 8'h0;
      programBufferMem_18 <= 8'h0;
      programBufferMem_19 <= 8'h0;
      programBufferMem_20 <= 8'h0;
      programBufferMem_21 <= 8'h0;
      programBufferMem_22 <= 8'h0;
      programBufferMem_23 <= 8'h0;
      programBufferMem_24 <= 8'h0;
      programBufferMem_25 <= 8'h0;
      programBufferMem_26 <= 8'h0;
      programBufferMem_27 <= 8'h0;
      programBufferMem_28 <= 8'h0;
      programBufferMem_29 <= 8'h0;
      programBufferMem_30 <= 8'h0;
      programBufferMem_31 <= 8'h0;
      programBufferMem_32 <= 8'h0;
      programBufferMem_33 <= 8'h0;
      programBufferMem_34 <= 8'h0;
      programBufferMem_35 <= 8'h0;
      programBufferMem_36 <= 8'h0;
      programBufferMem_37 <= 8'h0;
      programBufferMem_38 <= 8'h0;
      programBufferMem_39 <= 8'h0;
      programBufferMem_40 <= 8'h0;
      programBufferMem_41 <= 8'h0;
      programBufferMem_42 <= 8'h0;
      programBufferMem_43 <= 8'h0;
      programBufferMem_44 <= 8'h0;
      programBufferMem_45 <= 8'h0;
      programBufferMem_46 <= 8'h0;
      programBufferMem_47 <= 8'h0;
      programBufferMem_48 <= 8'h0;
      programBufferMem_49 <= 8'h0;
      programBufferMem_50 <= 8'h0;
      programBufferMem_51 <= 8'h0;
      programBufferMem_52 <= 8'h0;
      programBufferMem_53 <= 8'h0;
      programBufferMem_54 <= 8'h0;
      programBufferMem_55 <= 8'h0;
      programBufferMem_56 <= 8'h0;
      programBufferMem_57 <= 8'h0;
      programBufferMem_58 <= 8'h0;
      programBufferMem_59 <= 8'h0;
      programBufferMem_60 <= 8'h0;
      programBufferMem_61 <= 8'h0;
      programBufferMem_62 <= 8'h0;
      programBufferMem_63 <= 8'h0;
    end
    goReg <= io_dmactive & (goAbstract | ~hartGoingWrEn & goReg);
    if (goAbstract) begin
      if (COMMANDReg_control[17]) begin
        if (COMMANDReg_control[16])
          abstractGeneratedMem_0 <= {17'h7000, COMMANDReg_control[22:20], COMMANDReg_control[4:0], 7'h3};
        else
          abstractGeneratedMem_0 <= {7'h1C, COMMANDReg_control[4:0], 5'h0, COMMANDReg_control[22:20], 12'h23};
      end
      else
        abstractGeneratedMem_0 <= 32'h13;
      if (COMMANDReg_control[18])
        abstractGeneratedMem_1 <= 32'h13;
      else
        abstractGeneratedMem_1 <= 32'h100073;
    end
  end // always @(posedge)
  always @(posedge clock or posedge reset) begin
    if (reset)
      hrDebugInt_0 <= 1'h0;
    else
      hrDebugInt_0 <= io_dmactive & hrmaskReg_0 & (_hartIsInResetSync_0_debug_hartReset_0_io_q | hrDebugInt_0 & ~haltedBitRegs);
  end // always @(posedge, posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      if (reset)
        hrDebugInt_0 = 1'h0;
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  AsyncResetSynchronizerShiftReg_w1_d3_i0 hartIsInResetSync_0_debug_hartReset_0 (
    .clock (clock),
    .reset (reset),
    .io_d  (io_hartIsInReset_0),
    .io_q  (_hartIsInResetSync_0_debug_hartReset_0_io_q)
  );
  assign auto_tl_in_a_ready = auto_tl_in_d_ready;
  assign auto_tl_in_d_valid = auto_tl_in_a_valid;
  assign auto_tl_in_d_bits_opcode = _GEN_4;
  assign auto_tl_in_d_bits_size = auto_tl_in_a_bits_size;
  assign auto_tl_in_d_bits_source = auto_tl_in_a_bits_source;
  assign auto_tl_in_d_bits_data = _out_out_bits_data_T_62 ? casez_tmp : 64'h0;
  assign auto_dmi_in_a_ready = auto_dmi_in_d_ready;
  assign auto_dmi_in_d_valid = auto_dmi_in_a_valid;
  assign auto_dmi_in_d_bits_opcode = _GEN_3;
  assign auto_dmi_in_d_bits_size = auto_dmi_in_a_bits_size;
  assign auto_dmi_in_d_bits_source = auto_dmi_in_a_bits_source;
  assign auto_dmi_in_d_bits_data =
    (_out_out_bits_data_T_30 ? auto_dmi_in_a_bits_address[8] : ~(_out_out_bits_data_T_31 | _out_out_bits_data_T_32 | _out_out_bits_data_T_33 | _out_out_bits_data_T_34 | _out_out_bits_data_T_35 | _out_out_bits_data_T_36 | _out_out_bits_data_T_37 | _out_out_bits_data_T_38 | _out_out_bits_data_T_39 | _out_out_bits_data_T_40 | _out_out_bits_data_T_41 | _out_out_bits_data_T_42 | _out_out_bits_data_T_43 | _out_out_bits_data_T_44 | _out_out_bits_data_T_45 | _out_out_bits_data_T_46 | _out_out_bits_data_T_47 | _out_out_bits_data_T_48 | _out_out_bits_data_T_49 | _out_out_bits_data_T_50 | _out_out_bits_data_T_51 | _out_out_bits_data_T_52 | _out_out_bits_data_T_53 | _out_out_bits_data_T_54 | _out_out_bits_data_T_55 | _out_out_bits_data_T_56 | _out_out_bits_data_T_57 | _out_out_bits_data_T_58 | _out_out_bits_data_T_59) | ~(auto_dmi_in_a_bits_address[8]))
      ? (_out_out_bits_data_T_30
           ? _GEN
           : _out_out_bits_data_T_31
               ? {abstractDataMem_3, abstractDataMem_2, abstractDataMem_1, abstractDataMem_0}
               : _out_out_bits_data_T_32
                   ? {abstractDataMem_7, abstractDataMem_6, abstractDataMem_5, abstractDataMem_4}
                   : _out_out_bits_data_T_33
                       ? {abstractDataMem_11, abstractDataMem_10, abstractDataMem_9, abstractDataMem_8}
                       : _out_out_bits_data_T_34
                           ? {abstractDataMem_15, abstractDataMem_14, abstractDataMem_13, abstractDataMem_12}
                           : _out_out_bits_data_T_35
                               ? {abstractDataMem_19, abstractDataMem_18, abstractDataMem_17, abstractDataMem_16}
                               : _out_out_bits_data_T_36
                                   ? {abstractDataMem_23, abstractDataMem_22, abstractDataMem_21, abstractDataMem_20}
                                   : _out_out_bits_data_T_37
                                       ? {abstractDataMem_27, abstractDataMem_26, abstractDataMem_25, abstractDataMem_24}
                                       : _out_out_bits_data_T_38
                                           ? {abstractDataMem_31, abstractDataMem_30, abstractDataMem_29, abstractDataMem_28}
                                           : _out_out_bits_data_T_39
                                               ? {12'h0, {2{haveResetBitRegs}}, {2{(~resumereq | (|io_innerCtrl_bits_hartsel)) & ~resumeReqRegs}}, 4'h0, ~haltedBitRegs, ~haltedBitRegs, {2{haltedBitRegs}}, 8'hA2}
                                               : _out_out_bits_data_T_40
                                                   ? _GEN
                                                   : _out_out_bits_data_T_41
                                                       ? {3'h0, ABSTRACTCSReg_progbufsize, 11'h0, |ctrlStateReg, 1'h0, ABSTRACTCSReg_cmderr, 4'h0, ABSTRACTCSReg_datacount}
                                                       : _out_out_bits_data_T_42 ? {COMMANDReg_cmdtype, COMMANDReg_control} : _out_out_bits_data_T_43 ? {ABSTRACTAUTOReg_autoexecprogbuf, 8'h0, ABSTRACTAUTOReg_autoexecdata[7:0]} : _out_out_bits_data_T_44 ? {programBufferMem_3, programBufferMem_2, programBufferMem_1, programBufferMem_0} : _out_out_bits_data_T_45 ? {programBufferMem_7, programBufferMem_6, programBufferMem_5, programBufferMem_4} : _out_out_bits_data_T_46 ? {programBufferMem_11, programBufferMem_10, programBufferMem_9, programBufferMem_8} : _out_out_bits_data_T_47 ? {programBufferMem_15, programBufferMem_14, programBufferMem_13, programBufferMem_12} : _out_out_bits_data_T_48 ? {programBufferMem_19, programBufferMem_18, programBufferMem_17, programBufferMem_16} : _out_out_bits_data_T_49 ? {programBufferMem_23, programBufferMem_22, programBufferMem_21, programBufferMem_20} : _out_out_bits_data_T_50 ? {programBufferMem_27, programBufferMem_26, programBufferMem_25, programBufferMem_24} : _out_out_bits_data_T_51 ? {programBufferMem_31, programBufferMem_30, programBufferMem_29, programBufferMem_28} : _out_out_bits_data_T_52 ? {programBufferMem_35, programBufferMem_34, programBufferMem_33, programBufferMem_32} : _out_out_bits_data_T_53 ? {programBufferMem_39, programBufferMem_38, programBufferMem_37, programBufferMem_36} : _out_out_bits_data_T_54 ? {programBufferMem_43, programBufferMem_42, programBufferMem_41, programBufferMem_40} : _out_out_bits_data_T_55 ? {programBufferMem_47, programBufferMem_46, programBufferMem_45, programBufferMem_44} : _out_out_bits_data_T_56 ? {programBufferMem_51, programBufferMem_50, programBufferMem_49, programBufferMem_48} : _out_out_bits_data_T_57 ? {programBufferMem_55, programBufferMem_54, programBufferMem_53, programBufferMem_52} : _out_out_bits_data_T_58 ? {programBufferMem_59, programBufferMem_58, programBufferMem_57, programBufferMem_56} : _out_out_bits_data_T_59 ? {programBufferMem_63, programBufferMem_62, programBufferMem_61, programBufferMem_60} : 32'h0)
      : 32'h0;
  assign io_hgDebugInt_0 = hrDebugInt_0;
endmodule

