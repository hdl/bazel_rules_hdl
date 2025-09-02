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
 *     (c) Copyright 2013-2014 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/

#ifndef X_HLS_MATRIX_TB_UTILS_H
#define X_HLS_MATRIX_TB_UTILS_H

#ifndef __SYNTHESIS__

#include "hls/linear_algebra/utils/std_complex_utils.h"
#include "utils/x_hls_utils.h"

template <typename T> double norm1_abs(T x)  {
  const double ONE  = 1.0;
  const double ZERO = 0.0;
  double t, re, im;

  re = abs((double)hls::x_real(x));
  im = abs((double)hls::x_imag(x));
  if (re > im) {
    t = im/re;
    return re*sqrt(ONE+t*t);
  } else {
    if (im == ZERO) {
      return ZERO;
    }
    t = re/im;
    return im*sqrt(ONE+t*t);
  }
}

// Compute 1-norm of a matrix directly
template <int ROWS, int COLS, typename T> double norm1(T in[ROWS][COLS]) {

  double norm = 0;
  double norm_cols[COLS];

  // Initialise
  for (int c = 0; c < COLS; c++) {
    norm_cols[c] = 0;
  }

  // Sum column absolute values
  for (int r=0; r < ROWS; r++) {
    for (int c=0; c < COLS; c++) {
      norm_cols[c] += norm1_abs(in[r][c]);
    }
  }

  // Find largest column sum
  for (int c=0; c < COLS; c++) {
    if (norm_cols[c] > norm) {
      norm = norm_cols[c];
    }
  }

  return norm;

}

template<int ROWS, int COLS, class T_IN, class T_OUT>
int msub(
  const T_IN A[ROWS][COLS],
  const T_IN B[ROWS][COLS],
  T_OUT C [ROWS][COLS] )
{
  T_IN tmp;
  for (int row = 0; row < ROWS; row++) {
    for (int col = 0; col < COLS; col++) {
      tmp = A[row][col];
      C[row][col] = tmp - B[row][col];
    }
  }
  return 0;
};

// Helper struct to determine base type
template <typename T> struct tb_traits {
  typedef T BASE_T;
};
template <typename T> struct tb_traits<std::complex<T> > {
  typedef T BASE_T;
};

// Generate a difference ratio between a matrix and a reference matrix
// - LAPACK error measurement method
// - Scaled by matrix size and data type precision.
template <int ROWS, int COLS, typename T> double difference_ratio(T in[ROWS][COLS], T ref[ROWS][COLS]) {
  const int MAX_DIM = (ROWS > COLS ? ROWS : COLS);
  typedef typename tb_traits<T>::BASE_T IN_BASE_T;
  const IN_BASE_T eps_base_t = hls::numeric_limits<IN_BASE_T>::epsilon();
  const double eps  = (double)eps_base_t;

  T diff[ROWS][COLS];
  double diff_norm, ref_norm;

  // Calculate difference between matrix and reference
  msub<ROWS,COLS>(in,ref,diff);
  // Calculate norm-1s of the difference and the reference
  diff_norm = norm1<ROWS,COLS>(diff);
  ref_norm  = norm1<ROWS,COLS>(ref);
  // Return difference ratio
  return (diff_norm / (ref_norm * MAX_DIM * eps));
};


//TO DO :  remove it when retire x_complex 
#include "hls/linear_algebra/deprecated/x_complex_matrix_tb_utils.h"

#endif // __SYNTHESIS__

#endif // X_HLS_MATRIX_TB_UTILS_H


