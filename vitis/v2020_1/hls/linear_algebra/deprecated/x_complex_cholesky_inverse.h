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
// Cholesky Inverse functions
// --------------------------
// CHOLESKY_INVERSE      : Entry point function
// CHOLESKY_INVERSE_TOP  : Top level function that selects implementation architecture and internal types based on a traits class.

// Change Log
// ----------
// 2015.3:
//  * Updated cholesky_traits instantiation to pass LowerTriangularL template parameter
// 
// 2015.1:
//  * Linear Algebra Library update.
//  * Function prototype changed to return success flag via argument not return value.
//  * Updated lower level functions calls to pass the corresponding configuration classes defined in the top-level 
//    cholesky_inverse_traits class.
// 
// 2014.1:
//  * Initial release

#ifndef X_COMPLEX_CHOLESKY_INVERSE_H
#define X_COMPLEX_CHOLESKY_INVERSE_H

#include "ap_fixed.h"
#include "hls/linear_algebra/utils/x_hls_complex.h"
#include "hls/linear_algebra/deprecated/x_complex_cholesky.h"
#include "hls/linear_algebra/hls_cholesky_inverse.h"
#include "hls/linear_algebra/deprecated/x_complex_back_substitute.h"
#include "hls/linear_algebra/deprecated/x_complex_matrix_multiply.h"

namespace hls {


  // Further specialization for hls::complex<ap_fixed>
  template<
    int RowsColsA,
    int W1, int I1, ap_q_mode Q1, ap_o_mode O1, int N1,
    int W2, int I2, ap_q_mode Q2, ap_o_mode O2, int N2>
  struct cholesky_inverse_traits
    <RowsColsA, x_complex<ap_fixed<W1, I1, Q1, O1, N1> >, x_complex< ap_fixed<W2, I2, Q2, O2, N2> > > {
    // Cholesky decomposition output precision
    static const int       CholeskyOutputW = W1;
    static const int       CholeskyOutputI = I1;
    static const ap_q_mode CholeskyOutputQ = Q1;
    static const ap_o_mode CholeskyOutputO = O1;
    static const int       CholeskyOutputN = N1;
    typedef x_complex< ap_fixed<CholeskyOutputW, CholeskyOutputI, CholeskyOutputQ, CholeskyOutputO, CholeskyOutputN> > CHOLESKY_OUT;
    typedef cholesky_traits< false, RowsColsA, x_complex< ap_fixed<W1, I1, Q1, O1, N1> >, CHOLESKY_OUT >               CHOLESKY_TRAITS;
    // Back substitution output precision
    static const int       BackSubstitutionOutW = W2;
    static const int       BackSubstitutionOutI = I2;
    static const ap_q_mode BackSubstitutionOutQ = Q2;
    static const ap_o_mode BackSubstitutionOutO = O2;
    static const int       BackSubstitutionOutN = N2;
    typedef x_complex< ap_fixed<BackSubstitutionOutW, BackSubstitutionOutI, BackSubstitutionOutQ, BackSubstitutionOutO, BackSubstitutionOutN> > BACK_SUBSTITUTE_OUT;
    typedef back_substitute_traits<RowsColsA, CHOLESKY_OUT, BACK_SUBSTITUTE_OUT >                                                               BACK_SUBSTITUTE_TRAITS;
    typedef matrix_multiply_traits<NoTranspose,ConjugateTranspose,RowsColsA,RowsColsA,RowsColsA,RowsColsA,BACK_SUBSTITUTE_OUT, x_complex< ap_fixed<W2, I2, Q2, O2, N2> > > MATRIX_MULTIPLY_TRAITS;
  };


} // end namespace hls

#endif


