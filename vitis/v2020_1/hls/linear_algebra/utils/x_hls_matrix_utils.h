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
 *     (c) Copyright 2008-2014 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/

#ifndef X_HLS_MATRIX_UTILS_H
#define X_HLS_MATRIX_UTILS_H

#include "ap_fixed.h"
#include "std_complex_utils.h"
#include "hls_math.h"
#include <complex>
#ifndef __SYNTHESIS__
#include <iostream>
#include <iomanip>
#include <string>
#include <sstream>
#include <stdio.h>
#endif

namespace hls {

  // ===================================================================================================================
  // Transpose Types & Operation
  struct NoTranspose {
    const static int TransposeType = 0;
    template <
      int RowsA,
      int ColsA,
      typename InputType>
    static InputType GetElement(const InputType A [RowsA][ColsA], unsigned  Row, unsigned  Col)
    {
      // No transpose, default
      return A[Row][Col];
    }
  };
  
  struct Transpose {
    const static int TransposeType = 1;
    template <
      int RowsA,
      int ColsA,
      typename InputType>
    static InputType GetElement(const InputType A [RowsA][ColsA], unsigned  Row, unsigned  Col)
    {
      // Transpose, no conjugate
      return A[Col][Row];
    }
  };
  
  struct ConjugateTranspose {
    const static int TransposeType = 2;
    template <
      int RowsA,
      int ColsA,
      typename InputType>
    static InputType GetElement(const InputType A [RowsA][ColsA], unsigned  Row, unsigned  Col)
    {
      // Complex conjugate transpose.
      // o For non std::complex types this function will return an unaltered value.
      return x_conj(A[Col][Row]);
    }
  };
  
  template <
    class TransposeForm,
    int RowsA,
    int ColsA,
    typename InputType>
  InputType GetMatrixElement(const InputType A [RowsA][ColsA], unsigned  Row, unsigned  Col)
  {
    // Need to help the compiler identify that the GetElement member function is a template
    return TransposeForm::template GetElement<RowsA, ColsA, InputType>(A,Row,Col);
  }
  
  // ===================================================================================================================
  // Common math operations and constants. Wrappers/templates to select the correct function based on type.

  // sqrt
  static half x_sqrt(half x) {
		return hls::half_sqrt(x);
	}
	static float x_sqrt(float x) {
    return sqrtf(x);
  }
  static double x_sqrt(double x) {
    return sqrt(x);
  }
  template <
    int W1, int I1, ap_q_mode Q1, ap_o_mode O1, int N1>
    ap_fixed<W1, I1, Q1, O1, N1> x_sqrt(ap_fixed<W1, I1, Q1, O1, N1> x) {
    return hls::sqrt((double)x);
  }


  // copysign
  static float x_copysign(float a, float b){
    return copysignf(a, b);
  }
  static double x_copysign(double a, double b){
    return copysign(a, b);
  }


  // sign
  static float x_sign(float x) {
    if ( x == 0.0f ) {
      return 0.0f;
    } else {
      return copysignf(1.0f,x);
    }
  }
  static double x_sign(double x) {
    if ( x == 0.0 ) {
      return 0.0;
    } else {
      return copysign(1.0,x);
    }
  }
  template <
    int W1, int I1, ap_q_mode Q1, ap_o_mode O1, int N1>
    ap_fixed<W1, I1, Q1, O1, N1> x_sign(ap_fixed<W1, I1, Q1, O1, N1> x) {
    ap_fixed<W1, I1, Q1, O1, N1> tmp = 0;
    if ( x > 0 ) {
      tmp = 1;
    } else {
      tmp = -1;
    }
    return tmp;
  }


  // reciprocal sqrt
  static half x_rsqrt(half x) {
		return hls::half_rsqrt(x);
  }
  static float x_rsqrt(float x) {
    return rsqrtf(x);
  }
  static double x_rsqrt(double x) {
    return rsqrt(x);
  }


  // isneg
  static int x_isneg(float x) {
    fp_struct<float> fs = x;
    return fs.__signbit();
  }
  static int x_isneg(double x) {
    fp_struct<double> fs = x;
    return fs.__signbit();
  }

#ifndef __SYNTHESIS__
  // Matrix Display
  // ============================================================================

  // Non-specific data
  // -----------------
  // This can be used by PoD or any class supporting "<<"
  // setprecision may fail on non floating point types
  template <typename T> struct xil_printer {
    static std::string to_s(T x, unsigned prec=10){

      std::stringstream ss;
      ss << std::setiosflags(std::ios::fixed) << std::setprecision(prec) << x;

      return ss.str();
    }
  };


  // Complex data
  // ----------------
  // This is used by complex data of any type.  A printer is called to print the real and imaginary
  // parts, so this just handles the formating of x+jy
  template <typename T> struct xil_printer<std::complex <T> > {
    static std::string to_s(std::complex<T> x, unsigned prec=10){

      // Use the basic type printer to print the real and imaginary parts
      typedef xil_printer<T> printer;

      std::stringstream ss;
      // Remember to deal with -0
      bool neg_imag = x.imag() <= -0 ? true : false;

      // Casting to "T" avoids "error: operands to ?: have different types." when using ap_fixed.
      T imag        = neg_imag ? (T)-x.imag() : (T)x.imag();

      ss << printer::to_s(x.real(), prec) << (neg_imag ? " - j*":" + j*") << printer::to_s(imag, prec);
      return ss.str();
    }
  };

  template <unsigned ROWS, unsigned COLS, typename T, class TransposeForm> void print_matrix(T a[ROWS][COLS], std::string prefix = "", unsigned prec=10, unsigned matlab_format=0){
    typedef xil_printer<T> printer;

    std::string res[ROWS][COLS];
    unsigned widest_entry = 0;

    // Get the individual fields
    for(int r = 0; r < ROWS; r++){
      for(int c = 0; c < COLS; c++){
        T tmp;

        tmp = hls::GetMatrixElement<TransposeForm,ROWS,COLS,T>(a, r, c);

        res[r][c] = printer::to_s(tmp, prec);
        if(res[r][c].length() > widest_entry){
          widest_entry = res[r][c].length();
        }
      }
    }

    // Print fields.  Each column should be "widest_entry" chars wide
    char col_gap_str[5] = "    ";
    unsigned col_width = widest_entry;

    for(int r = 0; r < ROWS; r++){
      if ( !matlab_format ) {
        printf("%s|", prefix.c_str());
      } else {
        if (r==0) {
          printf("%s[", prefix.c_str());
        } else {
          printf("%s ", prefix.c_str());
        }
      }
      for(int c = 0; c < COLS; c++){

        unsigned num_spaces_needed = col_width - res[r][c].length();
        for(int x = 0; x< num_spaces_needed; x++){
          printf(" ");
        }
        if ( !matlab_format ) {
          printf( "(%s)", res[r][c].c_str());
        } else {
          printf( "%s", res[r][c].c_str());
        }

        if(c!=COLS-1){
          printf("%s", col_gap_str);
          if ( matlab_format ) {
            printf(",");
          }
        }
      }
      if ( !matlab_format ) {
        printf(" |\n");
      } else {
        if (r==ROWS-1) {
          printf(" ];\n");
        } else {
          printf(" ;\n");
        }
      }
    }
  }
#endif

} // end namespace hls

#endif


