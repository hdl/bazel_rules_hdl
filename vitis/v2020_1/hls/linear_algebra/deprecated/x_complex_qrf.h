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
 *     (c) Copyright 2013-2015 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/
// QRF functions
// ------------------
// QRF                 : Entry point function
// QRF_TOP             : Top level function that selects implementation architecture and internal types based on a traits class.
// QRF_BASIC           : Basic implementation requiring lower resource
// QRF_ALT             : Optimized for throughput requiring more resources

// Change Log
// ----------
// 2015.3:
//  * Changed default architecture to QRF_ALT
//  * Added default inner loop pipelining and unrolling factors set via configuration traits class
// 
// 2015.2:
//  * CONFIG object declaration in the QRF_ALT function changed to "static" to ensure ROM inference.
// 
// 2015.1:
//  * Linear Algebra Library update
//  * Added 2nd implementation optimized for throughput selectable through the qrf_traits configuration class.
// 
// 2014.1:
//  * Initial release.

#ifndef X_COMPLEX_QRF_H
#define X_COMPLEX_QRF_H

#include "hls/linear_algebra/deprecated/x_complex_matrix_utils.h"
#include "hls/linear_algebra/utils/x_hls_complex.h"
#include "hls/linear_algebra/hls_qrf.h"
#include "hls_stream.h"
#ifndef __SYNTHESIS__
#include <stdio.h>
#include <cstdlib>
#endif

namespace hls {
  
  
  template <typename T> struct is_cmplx <x_complex<T> > {
    static const bool value = 1;
  };
  

  template <typename T> int qrf_require_extra_pass(const int rows, const int cols, x_complex<T> x) {
    qrf_require_extra_pass_complex:;
    if (rows == cols) {
      // Unitary transformation only required for square matrices
      return 1;
    } else {
      return 0;
    }
  }


  // Magnitude computation for complex Givens rotation, avoiding squaring values which have just been square-rooted
  // and guarding against under-/overflow
  // - Returns real-valued magnitude
  template <typename T> T qrf_magnitude(x_complex<T> a, x_complex<T> b) {
    Function_qrf_magnitude_complex:;
    
    const T ONE = 1.0;
    const T ZERO = 0.0;
    T ar, ai, br, bi, d1, d2, d3, d3a, d3b, x1, x2, x3;
    T a_largest, b_largest, largest;
    ar = abs(a.real());
    ai = abs(a.imag());
    br = abs(b.real());
    bi = abs(b.imag());
    
    // Lower latency, builds tree structures.
    if (ar > ai && ar > br && ar > bi) {
      largest = ar;
      d1 = ai;
      d2 = br;
      d3 = bi;
    } else if (ai > ar && ai > br && ai > bi) {
      largest = ai;
      d1 = ar;
      d2 = br;
      d3 = bi;
    } else if (br > ar && br > ai && br > bi) {
      largest = br;
      d1 = ar;
      d2 = ai;
      d3 = bi;
    } else {
      largest = bi;
      d1 = ar;
      d2 = ai;
      d3 = br;
    }
    
    if (largest == ZERO) { // Avoid divide-by-zero
      return ZERO;
    } else {
      x1 = d1/largest;
      x2 = d2/largest;
      x3 = d3/largest;
      T x1_sqd = x1*x1;
      T x2_sqd = x2*x2;
      T x3_sqd = x3*x3;

      T s1 = ONE + x1_sqd;
      T s2 = x2_sqd + x3_sqd;
      T s3 = s1 + s2;

      return largest*x_sqrt(s3);
    }
  }
  

  // ===================================================================================================================
  // Complex Givens rotation
  //
  // This implements a modified Givens rotation of the form:
  //
  // G = | c*  s* |
  //     | -s  c  |
  //
  // to produce real diagonal elements suitable for subsquent computation of the inverse of input matrix A.
  //
  // Returns matrix G =  | c  s  |
  //                     | ss cc |
  //
  // This implementation does not use the same approach as the version of qrf_givens() for real data, as that
  // would require that a divider for complex data be implemented, which is expensive.
  //
  // When argument 'extra_pass' is set to 1, the function computes a unitary transformation rather than a standard Givens matrix.
  // This is required to ensure that the bottom-rightmost element of the R matrix is real.  This transformation matrix has the form:
  //
  // G(trans) = | 1     0   |
  //            | 0  e^-j*T |
  // where T = Theta for the bottom-rightmost element
  //
  template <typename T> void qrf_givens(int extra_pass, x_complex<T> a, x_complex<T> b, x_complex<T> &c, x_complex<T> &s, x_complex<T> &ss, x_complex<T> &cc, x_complex<T> &r){
    Function_qrf_givens_complex:;
    const T ONE = 1.0;
    const T ZERO = 0.0;
    const x_complex<T> CZERO = ZERO;
    T sqrt_mag_a_mag_b;
    x_complex<T> c_tmp, s_tmp;

    if (extra_pass == 0) {
      // Standard modified Givens matrix, guarding against over-/underflow

      sqrt_mag_a_mag_b = qrf_magnitude(a, b);

      if (abs(a.real()) == ZERO && abs(a.imag()) == ZERO && abs(b.real()) == ZERO && abs(b.imag()) == ZERO) { // more efficient than "if (sqrt_mag_a_mag_b == ZERO)"
        c_tmp = x_copysign(ONE,a.real());
        s_tmp = ZERO;
      } else {
        c_tmp = a / sqrt_mag_a_mag_b;
        s_tmp = b / sqrt_mag_a_mag_b;
      }
      c = x_conj(c_tmp);
      cc = c_tmp;
      s = x_conj(s_tmp);
      ss = -s_tmp;

      r.real() = sqrt_mag_a_mag_b;

    } else {
      // Transformation matrix to ensure real diagonal in R, guarding against over-/underflow

      sqrt_mag_a_mag_b = qrf_magnitude(CZERO, b);

      c_tmp = ONE;

      if (abs(b.real()) == ZERO && abs(b.imag()) == ZERO) { // more efficient than "if (sqrt_mag_a_mag_b == ZERO)"
        s_tmp = ONE;
      } else {
        s_tmp = b / sqrt_mag_a_mag_b;
      }

      c = c_tmp;
      cc = x_conj(s_tmp);
      s = ZERO;
      ss = ZERO;

      r.real() = sqrt_mag_a_mag_b;

    }

  }
  
} // end namespace hls

#endif


