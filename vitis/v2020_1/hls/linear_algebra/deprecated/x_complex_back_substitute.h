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
 *     (c) Copyright 2014-2015 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/
// Back Substitution functions
// ---------------------------
// BACK_SUBSTITUTE       : Entry point function
// BACK_SUBSTITUTE_TOP   : Top level function that selects implementation architecture and internal types based on a traits class.
// BACK_SUBSTITUTE_BASIC : Implementation requiring lower resources
// BACK_SUBSTITUTE_ALT   : Re-arranged loops to improve dependencies and throughput with increased resources.

// Change Log
// ----------
// 2015.3:
//  * Change default archtecture
//  * Added default inner loop pipelining set via configuration traits class
//  * Disabled explicit RESOURCE directive in back_substitute_recip
// 
// 2015.1:
//  * Linear Algebra Library update.
//  * Added 2nd implementation with improved loop dependencies and throughput, selected through the back_substitute_traits class.
//  * Function prototype changed to return a is_singular flag.
// 
// 2014.1:
//  * Initial release

#ifndef X_COMPLEX_BACK_SUBSTITUTE_H
#define X_COMPLEX_BACK_SUBSTITUTE_H

#include "ap_fixed.h"
#include "hls/linear_algebra/utils/x_hls_complex.h"
#include "hls/linear_algebra/hls_back_substitute.h"

namespace hls {


  // Further specialization for x_complex<ap_fixed>
  template<
    int RowsColsA,
    int W1, int I1, ap_q_mode Q1, ap_o_mode O1, int N1,
    int W2, int I2, ap_q_mode Q2, ap_o_mode O2, int N2>
  struct back_substitute_traits
    <RowsColsA, x_complex<ap_fixed<W1, I1, Q1, O1, N1> >, x_complex< ap_fixed<W2, I2, Q2, O2, N2> > > {
    static const int W = W1+(W1-I1)+(W1-I1); // Fractional growth is denominator fraction width + numerator full width
    static const int I = I1+(W1-I1); // Integer growth is denominator int width + numerator fraction width
    typedef x_complex< ap_fixed<W, I, AP_TRN, AP_WRAP, 0> > RECIP_T;
    typedef x_complex< ap_fixed<(2*W)+1, (2*I)+1, AP_TRN, AP_WRAP, 0> > MULT_T;
    typedef x_complex< ap_fixed<(2*W)+2, (2*I)+2, AP_TRN, AP_WRAP, 0> > ADD_T;
    typedef x_complex< ap_fixed<(2*W2)+1,(2*I2)+1, AP_TRN, AP_WRAP, 0> > MULTNEG_T;
    static const int ARCH     = 1;
    static const int INNER_II = 1;
    static const int DIAG_II  = 1;
  };


  // All diagonal elements of the factorization (Cholesky or QR) should be real.
  // We can therefore use a real-valued divider (or reciprocal operator) to compute the diagonal inverse values.
  //
  // IMPLEMENTATION TIP: Force the reciprocal to be implemented using a single-precision divider with the resource directive.
  // This permits sharing of operators with the factorization function preceding the back-substitution.
  template <typename T> void back_substitute_recip(x_complex<T> x, x_complex<T> &one_over_x) {
    // #pragma HLS resource variable=recip core=FDiv
    T recip; // intermediate variable to allow directive to be applied
    const x_complex<T> ONE = 1.0;
    recip = ONE.real()/x.real();
    one_over_x.real() = recip;
    one_over_x.imag() = 0.0;
  }

  template<
    int W1, int I1, ap_q_mode Q1, ap_o_mode O1, int N1,
    int W2, int I2, ap_q_mode Q2, ap_o_mode O2, int N2>
    void back_substitute_recip(x_complex< ap_fixed<W1, I1, Q1, O1, N1> > x,
                               x_complex< ap_fixed<W2, I2, Q2, O2, N2> > &one_over_x) {
    x_complex< ap_fixed<W2, I2, Q2, O2, N2> > ONE; // Size to the output precision
    ONE.real() = 1;
    ONE.imag() = 0;
    one_over_x.real() = ONE.real()/x.real(); // Infers a real-valued divider
    one_over_x.imag() = 0;
  }

} // end namespace hls

#endif


