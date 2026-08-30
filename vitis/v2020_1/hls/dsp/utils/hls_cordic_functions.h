/*****************************************************************************
 *
 *     Author: Xilinx, Inc.
 *
 *     This text contains proprietary, confidential information of
 *     Xilinx, Inc. , is distributed by under license from Xilinx,
 *     Inc., and may be used, copied and/or disclosed only pursuant to
 *     the terms of a valid license agreement with Xilinx, Inc.
 *
 *     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
 *     AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
 *     SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
 *     OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
 *     APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
 *     THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,
 *     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
 *     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
 *     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
 *     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
 *     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
 *     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 *     FOR A PARTICULAR PURPOSE.
 *
 *     Xilinx products are not intended for use in life support appliances,
 *     devices, or systems. Use in such applications is expressly prohibited.
 *
 *     (c) Copyright 2014 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/

#ifndef HLS_CORDIC_FUNCTIONS_H
#define HLS_CORDIC_FUNCTIONS_H

#include "ap_int.h"
#include "ap_fixed.h"
#include <complex>

namespace hls {

  // ===================================================================================================================
  // Constants for all functions
  //
  static const int CORDIC_MAX_ROM_WIDTH  = 72;
  static const int CORDIC_MAX_ROM_LENGTH = 64;

  // Values for CordicFunction
  static const int CORDIC_F_ROTATE     = 0;
  static const int CORDIC_F_TRANSLATE  = 1;
  static const int CORDIC_F_SIN_COS   =  2;
  static const int CORDIC_F_ATAN      =  3;
  static const int CORDIC_F_SINH_COSH =  4;
  static const int CORDIC_F_ATANH     =  5;
  static const int CORDIC_F_SQRT      =  6;

  //Definition of presence for boolean parameters
  static const int CORDIC_FALSE = 0;
  static const int CORDIC_TRUE  = 1;

  //Values for DataFormat
  static const int CORDIC_FORMAT_SIG_FRAC  =  0;
  static const int CORDIC_FORMAT_USIG_FRAC =  1;
  static const int CORDIC_FORMAT_USIG_INT  = 2;

  //Values for PhaseFormat
  static const int CORDIC_FORMAT_RAD = 0;
  static const int CORDIC_FORMAT_SCA = 1;

  //Limits for InputWidth and OutputWidth
  static const int CORDIC_DATA_WIDTH_MIN = 8;
  static const int CORDIC_DATA_WIDTH_MAX = 48;

  //Values for RoundMode
  static const int CORDIC_ROUND_TRUNCATE   =  0;
  static const int CORDIC_ROUND_POS_INF     = 1;
  static const int CORDIC_ROUND_POS_NEG_INF = 2;
  static const int CORDIC_ROUND_NEAREST_EVEN = 3;

  //Values for Precision
  static const int CORDIC_PREC_AUTO = 0;

  //Values for Iterations
  static const int CORDIC_ITER_AUTO = 0;

  //Values for ScaleComp
  //Note: Specific implementations are currently not targeted
  static const int CORDIC_SCALE_NONE    = 0;
  static const int CORDIC_SCALE_LUT     = 1;
  static const int CORDIC_SCALE_BRAM    = 2;
  static const int CORDIC_SCALE_EMB_MULT = 3;

  static const int CORDIC_TRIG_TRANSFORM = 0;
  static const int CORDIC_HYP_TRANSFORM = 1;

  static const ap_uint<CORDIC_MAX_ROM_WIDTH> c_neg_pi_1_4_rads_const("111001101101111000000100101010111011101111010010111001111011100101101000",2);
  static const ap_uint<CORDIC_MAX_ROM_WIDTH> c_neg_pi_1_4_jrads_const("111110000000000000000000000000000000000000000000000000000000000000000000",2);

  static const ap_uint<CORDIC_MAX_ROM_WIDTH> c_neg_pi_2_4_rads_const("110011011011110000001001010101110111011110100101110011110111001011001110",2);
  static const ap_uint<CORDIC_MAX_ROM_WIDTH> c_neg_pi_2_4_jrads_const("111100000000000000000000000000000000000000000000000000000000000000000000",2);

  static const ap_uint<CORDIC_MAX_ROM_WIDTH> c_neg_pi_3_4_rads_const("101101001001101000001110000000110011001101111000101101110010110000110110",2);
  static const ap_uint<CORDIC_MAX_ROM_WIDTH> c_neg_pi_3_4_jrads_const("111010000000000000000000000000000000000000000000000000000000000000000000",2);

  static const ap_uint<CORDIC_MAX_ROM_WIDTH> c_neg_pi_rads_const("100110110111100000010010101011101110111101001011100111101110010110011110",2);
  static const ap_uint<CORDIC_MAX_ROM_WIDTH> c_neg_pi_jrads_const("111000000000000000000000000000000000000000000000000000000000000000000000",2);

  // ===================================================================================================================
  // Base input data template
  template <int InputWidth, int CordicFunction, int DataFormat> struct cordic_inputs {
    std::complex< ap_fixed<InputWidth,2,AP_TRN_ZERO,AP_WRAP,0> > cartesian;
    ap_fixed<InputWidth,3,AP_TRN_ZERO,AP_WRAP,0> phase;
  };

  // Specialization for rotate function
  template <int InputWidth, int DataFormat> struct cordic_inputs<InputWidth, CORDIC_F_ROTATE, DataFormat> {
    std::complex< ap_fixed<InputWidth,2,AP_TRN_ZERO,AP_WRAP,0> > cartesian;
    ap_fixed<InputWidth,3,AP_TRN_ZERO,AP_WRAP,0> phase;
  };

  // Specialization for translate function
  template <int InputWidth, int DataFormat> struct cordic_inputs<InputWidth, CORDIC_F_TRANSLATE, DataFormat> {
    std::complex< ap_fixed<InputWidth,2,AP_TRN_ZERO,AP_WRAP,0> > cartesian;
  };

  // Specialization for arctan function
  template <int InputWidth, int DataFormat> struct cordic_inputs<InputWidth, CORDIC_F_ATAN, DataFormat> {
    std::complex< ap_fixed<InputWidth,2,AP_TRN_ZERO,AP_WRAP,0> > cartesian;
  };

  // Specialization for hyperbolic arctan function
  template <int InputWidth, int DataFormat> struct cordic_inputs<InputWidth, CORDIC_F_ATANH, DataFormat> {
    std::complex< ap_fixed<InputWidth,2,AP_TRN_ZERO,AP_WRAP,0> > cartesian;
  };

  // Specialization for sine/cosine function
  template <int InputWidth, int DataFormat> struct cordic_inputs<InputWidth, CORDIC_F_SIN_COS, DataFormat> {
    ap_fixed<InputWidth,3,AP_TRN_ZERO,AP_WRAP,0> phase;
  };

  // Specialization for hyperbolic sine/cosine function
  template <int InputWidth, int DataFormat> struct cordic_inputs<InputWidth, CORDIC_F_SINH_COSH, DataFormat> {
    ap_fixed<InputWidth,3,AP_TRN_ZERO,AP_WRAP,0> phase;
  };

  // Specialization for square root function, unsigned integer input data
  template <int InputWidth> struct cordic_inputs<InputWidth, CORDIC_F_SQRT, CORDIC_FORMAT_USIG_FRAC> {
    ap_ufixed<InputWidth,1,AP_TRN_ZERO,AP_WRAP,0> in;
  };

  // Specialization for square root function, signed integer input data
  template <int InputWidth> struct cordic_inputs<InputWidth, CORDIC_F_SQRT, CORDIC_FORMAT_USIG_INT> {
    ap_uint<InputWidth> in;
  };

  // ===================================================================================================================
  // Base output data template
  template <int OutputWidth, int CordicFunction, int DataFormat> struct cordic_outputs {
    std::complex< ap_fixed<OutputWidth,2,AP_TRN_ZERO,AP_WRAP,0> > cartesian;
    ap_fixed<OutputWidth,3,AP_TRN_ZERO,AP_WRAP,0> phase;
  };

  // Specialization for rotate function
  template <int OutputWidth, int DataFormat> struct cordic_outputs<OutputWidth, CORDIC_F_ROTATE, DataFormat> {
    typedef ap_fixed<OutputWidth,2,AP_TRN_ZERO,AP_WRAP,0> out_type;
    std::complex< ap_fixed<OutputWidth,2,AP_TRN_ZERO,AP_WRAP,0> > cartesian;
  };

  // Specialization for translate function
  template <int OutputWidth, int DataFormat> struct cordic_outputs<OutputWidth, CORDIC_F_TRANSLATE, DataFormat> {
    ap_fixed<OutputWidth,2,AP_TRN_ZERO,AP_WRAP,0> magnitude;
    ap_fixed<OutputWidth,3,AP_TRN_ZERO,AP_WRAP,0> phase;
  };

  // Specialization for sine/cosine function
  template <int OutputWidth, int DataFormat> struct cordic_outputs<OutputWidth, CORDIC_F_SIN_COS, DataFormat> {
    typedef ap_fixed<OutputWidth,2,AP_TRN_ZERO,AP_WRAP,0> out_type;
    std::complex< ap_fixed<OutputWidth,2,AP_TRN_ZERO,AP_WRAP,0> > cartesian;
  };

  // Specialization for hyperbolic sine/cosine function
  template <int OutputWidth, int DataFormat> struct cordic_outputs<OutputWidth, CORDIC_F_SINH_COSH, DataFormat> {
    typedef ap_fixed<OutputWidth,2,AP_TRN_ZERO,AP_WRAP,0> out_type;
    std::complex< ap_fixed<OutputWidth,2,AP_TRN_ZERO,AP_WRAP,0> > cartesian;
  };

  // Specialization for arctan function
  template <int OutputWidth, int DataFormat> struct cordic_outputs<OutputWidth, CORDIC_F_ATAN, DataFormat> {
    ap_fixed<OutputWidth,3,AP_TRN_ZERO,AP_WRAP,0> phase;
  };

  // Specialization for hyperbolic arctan function
  template <int OutputWidth, int DataFormat> struct cordic_outputs<OutputWidth, CORDIC_F_ATANH, DataFormat> {
    ap_fixed<OutputWidth,3,AP_TRN_ZERO,AP_WRAP,0> phase;
  };

  // Specialization for square root function, unsigned integer output
  template <int OutputWidth> struct cordic_outputs<OutputWidth, CORDIC_F_SQRT, CORDIC_FORMAT_USIG_FRAC> {
    ap_ufixed<OutputWidth,1,AP_TRN_ZERO,AP_WRAP,0> out;
  };

  // Specialization for square root function, signed integer output
  // This is a special case - the user must set OutputWidth correctly (to the value returned by get_sqrt_output_width)
  // Mis-configuration is trapped by parameter checking in the main function.  This is cleaner than requiring InputWidth
  // to be passed to each and every struct, regardless of whether they require it or not.
  template <int OutputWidth> struct cordic_outputs<OutputWidth, CORDIC_F_SQRT, CORDIC_FORMAT_USIG_INT> {
    ap_uint<OutputWidth> out;
  };

  // ===================================================================================================================
  // Cartesian and phase access functions
  // Extract data from input structures
  template <int InputWidth,
    int CordicFunction,
    int DataFormat
    > void get_cartesian_inputs(cordic_inputs<InputWidth, CordicFunction, DataFormat> din,
                                ap_int< InputWidth > &x_in,
                                ap_int< InputWidth > &y_in) {

      Function_cordic_get_cartesian_inputs:;

      cartesian_loop : for (int bit=0; bit<InputWidth; bit++) {
        x_in[bit] = din.cartesian.real()[bit];
        y_in[bit] = din.cartesian.imag()[bit];
      }

    }

  template <int InputWidth,
    int CordicFunction,
    int DataFormat
    > void get_phase_inputs(cordic_inputs<InputWidth, CordicFunction, DataFormat> din,
                            ap_int< InputWidth > &phase_in) {

      Function_cordic_get_phase_inputs:;

      phase_loop : for (int bit=0; bit<InputWidth; bit++) {
        phase_in[bit] = din.phase[bit];
      }

    }

  // ===================================================================================================================
  // Overloaded functions for input assignment
  //
  // Rotate input assignment
  template <int InputWidth,
    int CordicFunction,
    int DataFormat
    > void get_inputs(cordic_inputs<InputWidth, CORDIC_F_ROTATE, DataFormat> din,
                      ap_int< InputWidth > &x_in,
                      ap_int< InputWidth > &y_in,
                      ap_int< InputWidth > &phase_in) {
      get_cartesian_inputs<InputWidth,CordicFunction,DataFormat>(din, x_in, y_in);
      get_phase_inputs<InputWidth,CordicFunction,DataFormat>(din, phase_in);
    };
  // Translate input assignment
  template <int InputWidth,
    int CordicFunction,
    int DataFormat
    > void get_inputs(cordic_inputs<InputWidth, CORDIC_F_TRANSLATE, DataFormat> din,
                      ap_int< InputWidth > &x_in,
                      ap_int< InputWidth > &y_in,
                      ap_int< InputWidth > &phase_in) {
      get_cartesian_inputs<InputWidth,CordicFunction,DataFormat>(din, x_in, y_in);
    };
  // Sine/cosine input assignment
  template <int InputWidth,
    int CordicFunction,
    int DataFormat
    > void get_inputs(cordic_inputs<InputWidth, CORDIC_F_SIN_COS, DataFormat> din,
                      ap_int< InputWidth > &x_in,
                      ap_int< InputWidth > &y_in,
                      ap_int< InputWidth > &phase_in) {
      get_phase_inputs<InputWidth,CordicFunction,DataFormat>(din, phase_in);
    };
  // Arctan input assignment
  template <int InputWidth,
    int CordicFunction,
    int DataFormat
    > void get_inputs(cordic_inputs<InputWidth, CORDIC_F_ATAN, DataFormat> din,
                      ap_int< InputWidth > &x_in,
                      ap_int< InputWidth > &y_in,
                      ap_int< InputWidth > &phase_in) {
      get_cartesian_inputs<InputWidth,CordicFunction,DataFormat>(din, x_in, y_in);
    };
  // Hyperbolic sine/cosine input assignment
  template <int InputWidth,
    int CordicFunction,
    int DataFormat
    > void get_inputs(cordic_inputs<InputWidth, CORDIC_F_SINH_COSH, DataFormat> din,
                      ap_int< InputWidth > &x_in,
                      ap_int< InputWidth > &y_in,
                      ap_int< InputWidth > &phase_in) {
      get_phase_inputs<InputWidth,CordicFunction,DataFormat>(din, phase_in);
    };
  // Hyperbolic arctan input assignment
  template <int InputWidth,
    int CordicFunction,
    int DataFormat
    > void get_inputs(cordic_inputs<InputWidth, CORDIC_F_ATANH, DataFormat> din,
                      ap_int< InputWidth > &x_in,
                      ap_int< InputWidth > &y_in,
                      ap_int< InputWidth > &phase_in) {
      get_cartesian_inputs<InputWidth,CordicFunction,DataFormat>(din, x_in, y_in);
    };
  // Square root input assignment
  template <int InputWidth,
    int CordicFunction,
    int DataFormat
    > void get_inputs(cordic_inputs<InputWidth, CORDIC_F_SQRT, DataFormat> din,
                      ap_int< InputWidth > &x_in,
                      ap_int< InputWidth > &y_in,
                      ap_int< InputWidth > &phase_in) {
      for (int bit=0; bit<InputWidth; bit++) {
        x_in[bit] = din.in[bit];
      }
      y_in = 0;
      phase_in = 0;
  };

  // ===================================================================================================================
  // Overloaded functions for output assignment
  //
  // Rotate output assignment
  template <
    int OutputWidth,
    int CordicFunction,
    int DataFormat
    > void set_outputs(ap_int< OutputWidth > data_x_outp,
                       ap_int< OutputWidth > data_y_outp,
                       ap_int< OutputWidth > phase_outp,
                       cordic_outputs<OutputWidth, CORDIC_F_ROTATE, DataFormat> &dout) {
      typename cordic_outputs<OutputWidth, CORDIC_F_ROTATE, DataFormat>::out_type real_val, img_val;
      real_val(OutputWidth-1,0) = data_x_outp(OutputWidth-1,0);
      img_val(OutputWidth-1,0) = data_y_outp(OutputWidth-1,0);
      dout.cartesian.real(real_val);
      dout.cartesian.imag(img_val);
    };
  // Translate output assignment
  template <
    int OutputWidth,
    int CordicFunction,
    int DataFormat
    > void set_outputs(ap_int< OutputWidth > data_x_outp,
                       ap_int< OutputWidth > data_y_outp,
                       ap_int< OutputWidth > phase_outp,
                       cordic_outputs<OutputWidth, CORDIC_F_TRANSLATE, DataFormat> &dout) {
      for (int bit=0; bit<OutputWidth; bit++) {
        dout.magnitude[bit] = data_x_outp[bit];
        dout.phase[bit] = phase_outp[bit];
      }
    };
  // Sine/cosine output assignment
  template <
    int OutputWidth,
    int CordicFunction,
    int DataFormat
    > void set_outputs(ap_int< OutputWidth > data_x_outp,
                       ap_int< OutputWidth > data_y_outp,
                       ap_int< OutputWidth > phase_outp,
                       cordic_outputs<OutputWidth, CORDIC_F_SIN_COS, DataFormat> &dout) {
      typename cordic_outputs<OutputWidth, CORDIC_F_SIN_COS, DataFormat>::out_type real_val, img_val;
      real_val(OutputWidth-1,0) = data_x_outp(OutputWidth-1,0);
      img_val(OutputWidth-1,0) = data_y_outp(OutputWidth-1,0);
      dout.cartesian.real(real_val);
      dout.cartesian.imag(img_val);
    };
  // Hyperbolic sine/cosine output assignment
  template <
    int OutputWidth,
    int CordicFunction,
    int DataFormat
    > void set_outputs(ap_int< OutputWidth > data_x_outp,
                       ap_int< OutputWidth > data_y_outp,
                       ap_int< OutputWidth > phase_outp,
                       cordic_outputs<OutputWidth, CORDIC_F_SINH_COSH, DataFormat> &dout) {
      typename cordic_outputs<OutputWidth, CORDIC_F_SINH_COSH, DataFormat>::out_type real_val, img_val;
      real_val(OutputWidth-1,0) = data_x_outp(OutputWidth-1,0);
      img_val(OutputWidth-1,0) = data_y_outp(OutputWidth-1,0);
      dout.cartesian.real(real_val);
      dout.cartesian.imag(img_val);
    };
  // Arctan output assignment
  template <
    int OutputWidth,
    int CordicFunction,
    int DataFormat
    > void set_outputs(ap_int< OutputWidth > data_x_outp,
                       ap_int< OutputWidth > data_y_outp,
                       ap_int< OutputWidth > phase_outp,
                       cordic_outputs<OutputWidth, CORDIC_F_ATAN, DataFormat> &dout) {
      for (int bit=0; bit<OutputWidth; bit++) {
        dout.phase[bit] = phase_outp[bit];
      }
    };
  // Hyperbolic arctan output assignment
  template <
    int OutputWidth,
    int CordicFunction,
    int DataFormat
    > void set_outputs(ap_int< OutputWidth > data_x_outp,
                       ap_int< OutputWidth > data_y_outp,
                       ap_int< OutputWidth > phase_outp,
                       cordic_outputs<OutputWidth, CORDIC_F_ATANH, DataFormat> &dout) {
      for (int bit=0; bit<OutputWidth; bit++) {
        dout.phase[bit] = phase_outp[bit];
      }
    };
  // Square root output assignment
  template <
    int OutputWidth,
    int CordicFunction,
    int DataFormat
    > void set_outputs(ap_int< OutputWidth > data_x_outp,
                       ap_int< OutputWidth > data_y_outp,
                       ap_int< OutputWidth > phase_outp,
                       cordic_outputs<OutputWidth, CORDIC_F_SQRT, DataFormat> &dout) {
      for (int bit=0; bit<OutputWidth; bit++) {
        dout.out[bit] = data_x_outp[bit];
      }
    };

  // ===================================================================================================================
  // Template meta-program "functions"
  //
  template<int a, unsigned p=0> struct log2roundup {
    enum { bits = log2roundup<((a+1)/2),p+1>::bits };
  };

  template<unsigned p> struct log2roundup<0, p> {
    enum { bits = p };
  };

  template<unsigned p> struct log2roundup<1, p> {
    enum { bits = p };
  };

  template <bool CoarseRotate> struct gen_ctrl_width {
    enum {width = (CoarseRotate ? 3 : 1) };
  };

  template <int InputWidth, int OutputWidth, int DataFormat> struct get_sqrt_output_width {
    enum { width = (DataFormat == CORDIC_FORMAT_USIG_INT ? (InputWidth+2)/2 : OutputWidth) };
  };

  template <bool CoarseRotate, int OutputWidth> struct iterations_int {
    enum {iterations = (CoarseRotate ? OutputWidth - 2 : OutputWidth) };
  };

  template <int CordicFunction, bool CoarseRotate, int Iterations, int OutputWidth, int RoundMode> struct c_iterations_int_not_sqrt {
    enum { prec = ( (CordicFunction == CORDIC_F_ATANH || CordicFunction == CORDIC_F_SINH_COSH) ? (iterations_int<CoarseRotate,OutputWidth>::iterations >= 13 ? iterations_int<CoarseRotate,OutputWidth>::iterations + 2 : (iterations_int<CoarseRotate,OutputWidth>::iterations >= 4 ? iterations_int<CoarseRotate,OutputWidth>::iterations + 1 : iterations_int<CoarseRotate,OutputWidth>::iterations) ) : iterations_int<CoarseRotate,OutputWidth>::iterations ) };
  };

  template <int CordicFunction, int RoundMode> struct rnd_mode_int_v {
    enum { mode = ( (CordicFunction == CORDIC_F_SQRT && (RoundMode == CORDIC_ROUND_POS_NEG_INF)) ? CORDIC_ROUND_POS_INF : RoundMode) };
  };

  template <int RoundMode> struct get_round_ext {
    enum { rnd_mode = (RoundMode == CORDIC_ROUND_TRUNCATE ? 0 : (RoundMode == CORDIC_ROUND_POS_INF ? 1 : 2) ) };
  };

  template <int CordicFunction, bool CoarseRotate, int Iterations, int OutputWidth, int RoundMode, int InputWidth, int DataFormat> struct c_iterations_int_sqrt {
    enum { prec = get_sqrt_output_width<InputWidth,OutputWidth,DataFormat>::width + get_round_ext< rnd_mode_int_v<CordicFunction,RoundMode>::mode >::rnd_mode };
  };

  template <int CordicFunction, bool CoarseRotate, int Iterations, int OutputWidth, int RoundMode, int InputWidth, int DataFormat> struct c_iterations_int {
    enum { prec = (Iterations != 0 ? Iterations : (CordicFunction != CORDIC_F_SQRT ? (int) c_iterations_int_not_sqrt<CordicFunction,CoarseRotate,Iterations,OutputWidth,RoundMode>::prec : (int) c_iterations_int_sqrt<CordicFunction,CoarseRotate,Iterations,OutputWidth,RoundMode,InputWidth,DataFormat>::prec ) ) };
  };

  template <int CordicFunction, bool CoarseRotate, int Iterations, int OutputWidth, int RoundMode, int InputWidth, int DataFormat> struct c_precision_int_not_sqrt {
    enum {prec = log2roundup< c_iterations_int<CordicFunction,CoarseRotate,Iterations,OutputWidth,RoundMode,InputWidth,DataFormat>::prec >::bits + OutputWidth};
  };

  template <int InputWidth, int OutputWidth, int DataFormat, int RoundMode> struct c_precision_int_sqrt {
    enum { prec = (RoundMode == CORDIC_ROUND_POS_NEG_INF ? get_sqrt_output_width<InputWidth,OutputWidth,DataFormat>::width+1 : get_sqrt_output_width<InputWidth,OutputWidth,DataFormat>::width+RoundMode) };
  };

  template <int CordicFunction, bool CoarseRotate, int DataFormat, int InputWidth, int Iterations, int OutputWidth, int Precision, int RoundMode> struct c_precision_int {
    enum {prec = (Precision != 0 ? Precision : (CordicFunction == CORDIC_F_SQRT ? (int) c_precision_int_sqrt<InputWidth,OutputWidth,DataFormat,RoundMode>::prec : (int) c_precision_int_not_sqrt<CordicFunction,CoarseRotate,Iterations,OutputWidth,RoundMode,InputWidth,DataFormat>::prec )) };
  };

  // ===================================================================================================================
  // Utility functions

  // Compute rounding mode
  static int CORDIC_get_rnd_mode_int(int pFunction, int pRoundMode)  {

    Function_CORDIC_get_rnd_mode_int:;

    if ((pFunction == CORDIC_F_SQRT) && (pRoundMode == CORDIC_ROUND_POS_NEG_INF)) {
      return CORDIC_ROUND_POS_INF;
    } else {
      return pRoundMode;
    }
  }

  // Compute rounding impact on iterations
  static int CORDIC_get_round_ext(int pRoundMode)  {

    Function_CORDIC_get_round_ext:;

    if (pRoundMode == CORDIC_ROUND_TRUNCATE) {
      return 0;
    } else if (pRoundMode == CORDIC_ROUND_POS_INF) {
      return 1;
    }  else {
      return 2;
    }
  }

  // Compute iterations required
  static int CORDIC_get_iterations_int(int pCoarseRotate, int pFunction, int pIterations, int pOutputWidth, int pRoundMode) {

    Function_CORDIC_get_iterations_int:;

    int iterations_int_v = 0;
    int iterations_v = 0;

    if (pIterations != 0) {
      return pIterations;
    } else {
      if (pFunction != CORDIC_F_SQRT) {
        if (pCoarseRotate == 1){
          iterations_int_v = pOutputWidth - 2;
        } else {
          iterations_int_v = pOutputWidth;
        }
        if ((pFunction == CORDIC_F_ATANH) || (pFunction == CORDIC_F_SINH_COSH)){
          if (iterations_int_v >= 13){
            iterations_v = iterations_int_v + 2;
          } else if (iterations_int_v >=4) {
            iterations_v = iterations_int_v + 1;
          } else {
            iterations_v = iterations_int_v;
          }
        } else {
          iterations_v = iterations_int_v;
        }
      } else {
        int rnd_mode_int_v = CORDIC_get_rnd_mode_int(pFunction,pRoundMode);
        iterations_v = pOutputWidth + CORDIC_get_round_ext(rnd_mode_int_v);
      }
    }
    return iterations_v;
  }

  // Compute log2
  static int CORDIC_log2roundup(int data_value)  {

    Function_CORDIC_log2roundup:;

    int width = 0;
    int cnt = 1;
    if (data_value <= 1) {
      width = 0;
    }    else {
      while (cnt < data_value) {
        width++;
        cnt = cnt*2;
      }
    }
    return width;
  }

  // Compute output width of square root function
  static int CORDIC_get_sqrt_output_width(int pInputWidth, int pOutputWidth, int pDataFormat)  {

    Function_CORDIC_get_sqrt_output_width:;

    int output_width_v;
    if (pDataFormat == CORDIC_FORMAT_USIG_INT) {
      output_width_v = (pInputWidth+2)/2;
    } else {
      output_width_v = pOutputWidth;
    }
    return output_width_v;
  }

  // Compute internal precision of CORDIC
  static int CORDIC_get_precision_int(int pFunction, int pDataFormat, int pInputWidth, int pIterations, int pOutputWidth, int pPrecision, int pRoundMode)  {

    Function_CORDIC_get_precision_int:;

    int precision_v;
    int output_width_int_v;
    if (pPrecision != 0) {
      precision_v = pPrecision;
    } else {
      if (pFunction != CORDIC_F_SQRT) {
        precision_v = CORDIC_log2roundup(pIterations) + pOutputWidth;
      } else {
        output_width_int_v = CORDIC_get_sqrt_output_width(pInputWidth, pOutputWidth, pDataFormat);
        if (pRoundMode == CORDIC_ROUND_TRUNCATE) {
          precision_v = output_width_int_v;
        } else if ((pRoundMode == CORDIC_ROUND_POS_INF) || (pRoundMode == CORDIC_ROUND_POS_NEG_INF)) {
          precision_v = output_width_int_v + 1;
        } else {
          precision_v = output_width_int_v + 2;
        }
      }
    }
    return precision_v;
  }

  // Perform rounding
  template <int InWidth, int OutWidth> ap_int<OutWidth> CORDIC_rnd_slv(ap_int<InWidth> a, int len, int mode, int precision)  {

    Function_CORDIC_rnd_slv:;

    // Bring rounder up to hls_cordic hierarchy level for synthesis
    #pragma HLS INLINE

    ap_int<OutWidth> ret_val;
    ap_int<InWidth> tmp;

    if (len == precision) {
      ret_val = a;
    } else if (len > precision) {
      ap_uint<InWidth+1> adj_val;

      switch(mode){
      case CORDIC_ROUND_TRUNCATE:
        ret_val = a(len-1,len-precision);
        break;
      case CORDIC_ROUND_POS_NEG_INF:
        adj_val = 1;
        adj_val = adj_val << (len-precision-1);
        if (a < 0) {
          adj_val = adj_val - 1;
        }
        tmp = a + adj_val;
        ret_val = tmp(len-1,len-precision);
        break;
      case CORDIC_ROUND_POS_INF:
        adj_val = 1;
        adj_val = adj_val << (len-precision-1);
        tmp = a + adj_val;
        ret_val = tmp(len-1,len-precision);
        break;
      case CORDIC_ROUND_NEAREST_EVEN:
        adj_val = 1;
        adj_val = adj_val << (len-precision-1); //adj = 0.5
        if (a>=0) {
          if (a[len-precision] == 0) { //even
            adj_val = adj_val - 1; //adj = 0.4999
          }
        } else {
          if (a[len-precision] == 1) { //even
            adj_val = adj_val - 1; //adj = 0.4999
          }
        }
        tmp = a + adj_val;
        ret_val = tmp(len-1,len-precision);
        break;
      default:
        break;
      }

    } else {
#ifndef __SYNTHESIS__
      std::cout << "ERROR: " << __FILE__ << ":  in rnd_slv. Output length of round is greater than input" << std::endl;
      exit(1);
#endif
    }
    return ret_val;
  }

  // Select CORDIC engine mode
  static ap_uint<1> CORDIC_get_eng_mode(int cordic_func)  {

    Function_CORDIC_get_eng_mode:;

    ap_uint<1> ret_val;

    switch(cordic_func){
    case CORDIC_F_TRANSLATE:
    case CORDIC_F_ATAN:
    case CORDIC_F_ATANH:
      ret_val = 1;
      break;
    default:
      ret_val = 0;
    }
    return ret_val;
  }

  // Select CORDIC transformation type
  static int CORDIC_get_transform_type(int cordic_func)  {

    Function_CORDIC_get_transform_type:;

    int ret_val;

    switch(cordic_func){
    case CORDIC_F_SINH_COSH:
    case CORDIC_F_ATANH:
      ret_val = CORDIC_HYP_TRANSFORM;
      break;
    default:
      ret_val = CORDIC_TRIG_TRANSFORM;
    }
    return ret_val;
  }

  // Determine current iteration
  static int CORDIC_get_current_iteration(int i, int transform_type)  {

  Function_CORDIC_get_current_iteration:;

    int iteration_v;
    if (transform_type == CORDIC_HYP_TRANSFORM) {
      if (i>13) {
        iteration_v = i-2;
      } else if (i>3) {
        iteration_v = i-1;
      } else {
        iteration_v = i;
      }
    } else {
      iteration_v = i;
    }
    return iteration_v;
  }

  // Perform CORDIC square root
  template <int InputWidth, int data_format, int precision_int> ap_int<precision_int> sqrt_slv(ap_int<InputWidth> data_in) {

    Function_cordic_sqrt_slv:;

    // Bring up to hls_cordic hierarchy level for synthesis
    #pragma HLS INLINE

    const int data_width_even = InputWidth + (InputWidth % 2);
    ap_int<data_width_even> data_even;
    ap_int<2*precision_int> data_int;
    ap_int<2*precision_int> rem_int = 0;
    ap_int<2*precision_int> rem_next = 0;
    ap_int<2*precision_int> sqre_diff = 1;
    ap_int<precision_int> sqrt_int = 0;

    if (data_format == CORDIC_FORMAT_USIG_INT) {
      data_int_int_loop : for (int i=0; i<2*precision_int; i++) {
        if (i <= (1-(InputWidth % 2))) {
          data_int[2*precision_int-1-i] = 0;
        } else if (i <= InputWidth+(1-(InputWidth % 2))) {
          data_int[2*precision_int-1-i] = data_in[InputWidth-1-i+2-(InputWidth % 2)];
        } else {
          data_int[2*precision_int-1-i] = 0;
        }
      }
    }

    if (data_format == CORDIC_FORMAT_USIG_FRAC) {
      data_int_frac_loop : for (int i=0; i<2*precision_int; i++) {
        if (i == 0) {
          data_int[2*precision_int-1 -i] = 0;
        } else if (i <= InputWidth) {
          data_int[2*precision_int-1 -i] = data_in[InputWidth-i];
        } else {
          data_int[2*precision_int-1 -i] = 0;
        }
      }
    }

    precision_loop : for (int i=precision_int-1; i>=0; i--) {

      rem_loop : for (int j=precision_int-2; j>=0; j--) {
        rem_int[j+2] = rem_int[j];
      }
      rem_int[1] = data_int[2*i+1];
      rem_int[0] = data_int[2*i];

      sqre_loop : for (int j=precision_int-3; j>=0; j--) {
        sqre_diff[j+2] = sqrt_int[j];
      }

      rem_next = rem_int - sqre_diff;

      sqrt_int_loop : for (int j=precision_int-2; j>=0; j--) {
        sqrt_int[j+1] = sqrt_int[j];
      }
      sqrt_int[0] = 0;

      if (rem_next[precision_int] == 0) {
        rem_int = rem_next;
        sqrt_int[0] = 1;
      }

    } // end loop
    return sqrt_int;
  }

  // Select ROM to use for arctan function
  static int fn_select_rom_for_atan(int cordic_function, int phase_format)  {

    Function_cordic_fn_select_rom_for_atan:;

    if ( ((cordic_function != CORDIC_F_SINH_COSH) &&
          (cordic_function != CORDIC_F_ATANH)) &&
         (phase_format == CORDIC_FORMAT_RAD) ) {
      return 0; //atan_rads
    }

    else if ( ((cordic_function != CORDIC_F_SINH_COSH) &&
          (cordic_function != CORDIC_F_ATANH)) &&
         (phase_format == CORDIC_FORMAT_SCA) ) {
      return 1; //atan_jrads
    }

    else if ( ((cordic_function == CORDIC_F_SINH_COSH) ||
          (cordic_function == CORDIC_F_ATANH)) &&
         (phase_format == CORDIC_FORMAT_RAD) ) {
      return 2; //atanh_rads
    }

    else if ( ((cordic_function == CORDIC_F_SINH_COSH) ||
          (cordic_function == CORDIC_F_ATANH)) &&
         (phase_format == CORDIC_FORMAT_SCA) ) {
      return 3; //atanh_jrads
    }

    else {
    #ifndef __SYNTHESIS__
      std::cout << "ERROR: " << __FILE__ << ": in fn_select_rom_for_atan.  Invalid cordic_function value." << std::endl;
      exit(1);
    #else
      return -1; //invalid rom table, will direct to default atan table in fn_rom_data_int
    #endif
    }
  }

  // ===================================================================================================================
  // ROM tables for trig functions
  //
  const ap_uint<CORDIC_MAX_ROM_WIDTH> CORDIC_inv_cordic_scale_trig_const_str[CORDIC_MAX_ROM_LENGTH] = {
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011011011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011100011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101011111110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011101101101100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011011110100100011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011100010000000010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011011101111101111110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010011100100110101101010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010100000000010100011101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000010101101110001111100111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000011100100101111100010011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110000111000000100101111000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111110010100101111111111001110110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001110111111001011101101100100101010001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001111000010100111100011111010010110011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011001111010000010110111101010001000111101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011010000000111010100100010101100001101011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011010011100011001010111000011000100011110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001011100001010010100100001111001001111101011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001100011000010000001001101010001111100000011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110001111110100000110011111010110100100110101000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110110011101100011011111110110000111101100011000010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010110111010100100001000101010001001000101110101110110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001010111010110000010111011010111100010101111010100011100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001011001000011111110000110001011011011011010000100100110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001011111111011101010110000111111011111010010111000110000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011001111011011010011101010101011000000010101011111101111101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111011011101001010101100101111000111111100110100111001110110001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111100010100001000001101100101001001100010101100110100010000101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101101111111101111111101011010000011110011111100101010100101001000100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101110001101011111000100100000101110000000001010000111101000101001111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001101111000100011000001001001011101011001100010001100001001011010010001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("001110010011111001001011100010110111111111011011101100100110101011001010",2)
  };

  const ap_int<CORDIC_MAX_ROM_WIDTH> CORDIC_inv_cordic_scale_hyp_const_str[CORDIC_MAX_ROM_LENGTH] = {
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001011000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001010110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101001001100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100101000100110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100100110001100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001100011100100010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001011110101111001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000010001001011011010100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000001111111110001000101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111011000001011001001000001000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111010111110111110100100010100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111010110101010100010101000011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110111010001110101011010111111111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110110111110100000111100011110000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110101110001001111000010010111001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001110000111100000111011001111010100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000001011101100111101000111000001000101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110010000000000010000010101101110110001000000100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110001111111011011011001110000110010100100000011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110001111101000000110101111100100100010011111110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110001110011010110100110101011101011010011000011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001110001001100101101101001101000000111000101101100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001101110110010001001110101011001110011110101110000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001101100010111100110000001001011110011111010010011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100001100010101101010110110000010011001101100011011101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110100000111100000100011001101100100111001001111000111001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110011110100001100000100101011011011100010111011001101000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011110010100110111010001010011110000001000001111101010011101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011101101110001110010100000011011000100111110001001001101101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100011011010011101010011100100111010110000010111100110111101111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010100010001101001011010011000001101011111111111100000101111000111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010011101011000000010000011011101000001000100111110111011101110110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011010001010000011001001101010110101001110000111101100001011001111101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011001110110110000101100000010111100001001110100101101101011111111110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010011000101001100001111011001001010101001111010010000110011100100001110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("010010011110011010011101000101100100000011001100011100010011010010000111",2)
  };

  const ap_int<CORDIC_MAX_ROM_WIDTH> CORDIC_atan_rads[CORDIC_MAX_ROM_LENGTH] = {
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000000100000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000001000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000010000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000100000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000001000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000010000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000100000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000001000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000010000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000100000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000001000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000010000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000100000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000001000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000010000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000100000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000001000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000010000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000100000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000001000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000010000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000100000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000001000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000010000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000100000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000001000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000010000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000100000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000001000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000010000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000100000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000001000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000010000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000100000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000001000000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000010000000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000100000000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000001000000000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000010000000000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000100000000000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000001000000000000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000010000000000000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000011111111111111111111111111111111111111111111101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000111111111111111111111111111111111111111111101011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000001111111111111111111111111111111111111111101010101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000011111111111111111111111111111111111111101010101011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000111111111111111111111111111111111111101010101010101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000001111111111111111111111111111111111101010101010101011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000011111111111111111111111111111111101010101010101010101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000111111111111111111111111111111101010101010101010101011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000001111111111111111111111111111101010101010101010101010101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000011111111111111111111111111101010101010101010101010101110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000111111111111111111111111101010101010101010101010110111100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000001111111111111111111111101010101010101010101011011101110111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000011111111111111111111101010101010101010101101110111011101111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000111111111111111111101010101010101010110111011101110111010101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000001111111111111111101010101010101011011101110111011011100101001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000011111111111111101010101010101101110111011101010010111001011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000111111111111101010101010110111011101101110010100110101011011110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000001111111111101010101011011101110101001011101100010010010101000010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000011111111101010101101110110111001011001111110111101001110001101101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000111111101010110111010100110101010110000101111011011011100011001011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000001111101011011011101011111100100101100100000001101110101100010101011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000011101101011000110011100000101011000011011101101001111100010010000110",2)
  };

  const ap_int<CORDIC_MAX_ROM_WIDTH> CORDIC_atan_jrads[CORDIC_MAX_ROM_LENGTH] = {
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000000001010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000000010100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000000101000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000001010001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000010100011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000101000110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000001010001100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000010100011000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000101000101111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000001010001011111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000010100010111110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000101000101111101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000001010001011111001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000010100010111110011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000101000101111100110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000001010001011111001100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000010100010111110011000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000101000101111100110000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000001010001011111001100001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000010100010111110011000001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000101000101111100110000011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000001010001011111001100000111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000010100010111110011000001101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000101000101111100110000011011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000001010001011111001100000110111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000010100010111110011000001101110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000101000101111100110000011011011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000001010001011111001100000110110111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000010100010111110011000001101101110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000101000101111100110000011011011100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000001010001011111001100000110110111001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000010100010111110011000001101101110010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000101000101111100110000011011011100101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000001010001011111001100000110110111001010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000010100010111110011000001101101110010011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000101000101111100110000011011011100100111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000001010001011111001100000110110111001001110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000010100010111110011000001101101110010011100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000101000101111100110000011011011100100111001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000001010001011111001100000110110111001001110010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000010100010111110011000001101101110010011100100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000101000101111100110000011011011100100111001000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000001010001011111001100000110110111001001110010000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000010100010111110011000001101101110010011100011011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000101000101111100110000011011011100100111000001101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000001010001011111001100000110110111001001101011010101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000010100010111110011000001101101110010010101101111011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000101000101111100110000011011011100100000010101111010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000001010001011111001100000110110111000010111111100001110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000010100010111110011000001101101101011101001111011101101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000101000101111100110000011011010101110100100010001010110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000001010001011111001100000110110000010111001011110010010001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000010100010111110011000001100110111111110110001100001100110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000101000101111100110000010100101010000000110010110111000010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000001010001011111001100000000000100100011011101001111011011010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000010100010111110010111010111011001100001010101100110111101110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000101000101111100101001101000110110100001100001100110110111111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000001010001011111000101010100010001110101000100001010101110101000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000010100010111101100001111001011100001010000010011000101001100001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000101000101110101111110000101011001000001000110001001111000010101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000001010001011000011010100001100001110010110001001101011101100110000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000010100010001000100011101010000011101110111011001101000011011100000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000100111111011001110000101101101011110111000111001111010001101111000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000001001011100100000001010001110110011101111100110000100001111010111100",2)
  };

  const ap_int<CORDIC_MAX_ROM_WIDTH> CORDIC_atanh_rads[CORDIC_MAX_ROM_LENGTH] = {
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000000100000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000001000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000010000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000100000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000001000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000010000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000100000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000001000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000010000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000100000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000001000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000010000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000100000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000001000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000010000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000100000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000001000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000010000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000100000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000001000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000010000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000100000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000001000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000010000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000100000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000001000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000010000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000100000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000001000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000010000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000100000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000001000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000010000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000100000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000001000000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000010000000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000100000000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000001000000000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000010000000000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000100000000000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000001000000000000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000010000000000000000000000000000000000000000000000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000100000000000000000000000000000000000000000000011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000001000000000000000000000000000000000000000000010101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000010000000000000000000000000000000000000000010101011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000100000000000000000000000000000000000000010101010101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000001000000000000000000000000000000000000010101010101011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000010000000000000000000000000000000000010101010101010101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000100000000000000000000000000000000010101010101010101011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000001000000000000000000000000000000010101010101010101010101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000010000000000000000000000000000010101010101010101010101011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000100000000000000000000000000010101010101010101010101011000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000001000000000000000000000000010101010101010101010101100010001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000010000000000000000000000010101010101010101010110001000100010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000100000000000000000000010101010101010101011000100010001000100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000001000000000000000000010101010101010101100010001000100010010010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000010000000000000000010101010101010110001000100010001010110100011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000100000000000000010101010101011000100010001001000110101101001110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000001000000000000010101010101100010001000101011010001110010011000111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000010000000000010101010110001000100100011010111011100010010010110100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000100000000010101011000100010101101001101110101101011001101110010110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000001000000010101100010010001110010011110101011101111011101101001100101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000010000010110001010111011111010100000010001010001010001101001110010100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000100011001001111101010011110101010110100000011000010100111110011111001",2)
  };

  const ap_int<CORDIC_MAX_ROM_WIDTH> CORDIC_atanh_jrads[CORDIC_MAX_ROM_LENGTH] = {
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000000001010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000000010100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000000101000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000001010001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000010100011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000000101000110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000001010001100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000010100011000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000000101000101111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000001010001011111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000010100010111110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000000101000101111101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000001010001011111001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000010100010111110011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000000101000101111100110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000001010001011111001100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000010100010111110011000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000000101000101111100110000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000001010001011111001100000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000010100010111110011000001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000000101000101111100110000011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000001010001011111001100000111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000010100010111110011000001101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000000101000101111100110000011011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000001010001011111001100000110111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000010100010111110011000001101110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000000101000101111100110000011011011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000001010001011111001100000110110111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000010100010111110011000001101101110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000000101000101111100110000011011011100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000001010001011111001100000110110111001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000010100010111110011000001101101110010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000000101000101111100110000011011011100101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000001010001011111001100000110110111001010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000010100010111110011000001101101110010011",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000000101000101111100110000011011011100100111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000001010001011111001100000110110111001001110",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000010100010111110011000001101101110010011100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000000101000101111100110000011011011100100111001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000001010001011111001100000110110111001001110010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000010100010111110011000001101101110010011100100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000000101000101111100110000011011011100100111001000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000001010001011111001100000110110111001001110010010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000010100010111110011000001101101110010011100101001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000000101000101111100110000011011011100100111001111010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000001010001011111001100000110110111001001111000111010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000010100010111110011000001101101110010100011010100101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000000101000101111100110000011011011100101101111011000111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000001010001011111001100000110110111010000100100101110100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000010100010111110011000001101101111001001111001000011000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000000101000101111100110000011011100011011001101110110110100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000001010001011111001100000110111101111100011000011110000101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000010100010111110011000001110100100101000010111000000000101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000000101000101111100110000100010001111001101011110101010111001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000001010001011111001100001101101001110000001001000011010010001",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000010100010111110011001000100000011000110110100000101110110010",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000000101000101111100110111001110000011001101010101011111010010101",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000001010001011111010010111001011110100000111000011000111110011000",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000010100010111111001110100011000001101001001111110100011101111100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000000101000110000011100011010010000110010010000101010101101000101111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000001010001100101111111101110100100111000101100100011110011011011100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000010100011110101001101111110000110110010010110011101110001001010111",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000000101001101000000011010110000100100011111110110010011001011000110100",2) ,
    ap_int<CORDIC_MAX_ROM_WIDTH>("000001011001100001011110001000110111101101011100101111010000001101101110",2)
  };

 // Extract data from ROM table
 template<int CordicFunction, bool CoarseRotate, int DataFormat, int InputWidth, int Iterations, int OutputWidth, int RoundMode, int Precision, int PhaseFormat, int iterations_int, int precision_int> void fn_rom_data_int(ap_int< c_precision_int<CordicFunction,CoarseRotate,DataFormat,InputWidth,Iterations,OutputWidth,Precision,RoundMode>::prec > eng_rom_vect[iterations_int])  {
    const int c_atan_rom_select = fn_select_rom_for_atan(CordicFunction,PhaseFormat);
    ap_int<CORDIC_MAX_ROM_WIDTH> atan_rom_slice_v;
    ap_int<precision_int> rom_val;

    Function_cordic_fn_rom_data_int:;

    iteration_loop : for (int i = 0; i< iterations_int; i++) {
      switch(c_atan_rom_select) {
      case 0: //atan_rads
        atan_rom_slice_v = CORDIC_atan_rads[CORDIC_MAX_ROM_LENGTH -1 -i];
        break;
      case 1: //atan_jrads
        atan_rom_slice_v = CORDIC_atan_jrads[CORDIC_MAX_ROM_LENGTH -1 -i];
        break;
      case 2: //atanh_rads
        atan_rom_slice_v = CORDIC_atanh_rads[CORDIC_MAX_ROM_LENGTH -1 -i];
        break;
      case 3://atanh_jrads
        atan_rom_slice_v = CORDIC_atanh_jrads[CORDIC_MAX_ROM_LENGTH -1 -i];
        break;
      default:
        atan_rom_slice_v = 0;
#ifndef __SYNTHESIS__
        std::cout << "ERROR: " << __FILE__ << ": Error in read of atan rads tables" << std::endl;
        exit(1);
#endif
      }

      rom_val = CORDIC_rnd_slv<CORDIC_MAX_ROM_WIDTH,precision_int>(atan_rom_slice_v, CORDIC_MAX_ROM_WIDTH, CORDIC_ROUND_NEAREST_EVEN, precision_int);

      eng_rom_vect[i] = rom_val;
    }

  }

 // Select and apply scaling factor
 template<int CordicFunction, int CoarseRotate, int DataFormat, int InputWidth, int Iterations, int OutputWidth, int Precision, int RoundMode> ap_int< c_precision_int<CordicFunction,CoarseRotate,DataFormat,InputWidth,Iterations,OutputWidth,Precision,RoundMode>::prec > CORDIC_inv_cordic_scale_slv()  {
   const int C_PRECISION_INT = c_precision_int<CordicFunction,CoarseRotate,DataFormat,InputWidth,Iterations,OutputWidth,Precision,RoundMode>::prec;
   const int C_ITERATIONS_INT = c_iterations_int<CordicFunction,CoarseRotate,Iterations,OutputWidth,RoundMode,InputWidth,DataFormat>::prec;
   ap_int< CORDIC_MAX_ROM_WIDTH > inv_cordic_scale_ext_v;
   ap_int< C_PRECISION_INT > inv_cordic_scale_v;

   Function_CORDIC_inv_cordic_scale_slv:;

   if ((CordicFunction != CORDIC_F_SINH_COSH) && (CordicFunction != CORDIC_F_ATANH)) {
     inv_cordic_scale_ext_v = CORDIC_inv_cordic_scale_trig_const_str[CORDIC_MAX_ROM_LENGTH-1 -(C_ITERATIONS_INT-1)];
   } else {
     inv_cordic_scale_ext_v = CORDIC_inv_cordic_scale_hyp_const_str[CORDIC_MAX_ROM_LENGTH-1-(C_ITERATIONS_INT-1)];
   }
   inv_cordic_scale_v = CORDIC_rnd_slv<CORDIC_MAX_ROM_WIDTH,C_PRECISION_INT>(inv_cordic_scale_ext_v, CORDIC_MAX_ROM_WIDTH, 3, C_PRECISION_INT);

   return inv_cordic_scale_v;
  }

} // end namespace hls

#endif // HLS_CORDIC_FUNCTIONS_H


