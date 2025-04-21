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

// Cholesky functions
// ------------------
// CHOLESKY                 : Entry point function
// CHOLESKY_TOP             : Top level function that selects implementation architecture and internal types based on a traits class.
// CHOLESKY_BASIC           : Basic implementation requiring lower resource
// CHOLESKY_ALT             : Lower latency architecture requiring more resources
// CHOLESKY_ALT2            : Further improved latency architecture requiring higher resource

// Change Log
// ----------
// 2015.3:
//  * Changed default architecture to CHOLESKY_ALT
//  * Added default inner loop pipelining and unrolling factors set via configuration traits class
//  * Added additional configuration traits class parameter, LowerTriangularL
//
// 2015.1:
//  * Linear Algebra Library update
//  * Added a third cholesky implementation with further throughput enhancements.
//
// 2014.1:
//  * Initial release.

#ifndef X_COMPLEX_CHOLESKY_H
#define X_COMPLEX_CHOLESKY_H

#include "ap_fixed.h"
#include "hls/linear_algebra/hls_cholesky.h"
#include "hls/linear_algebra/utils/x_hls_complex.h"
#include "hls/linear_algebra/deprecated/x_complex_matrix_utils.h"

namespace hls {

  
  // Specialization for complex
  template<
    bool LowerTriangularL,
    int RowsColsA,
    typename InputBaseType,
    typename OutputBaseType>
  struct cholesky_traits 
  <LowerTriangularL, RowsColsA, x_complex<InputBaseType>, x_complex<OutputBaseType> > {
    typedef x_complex<InputBaseType> PROD_T;
    typedef x_complex<InputBaseType> ACCUM_T;
    typedef x_complex<InputBaseType> ADD_T;
    typedef x_complex<InputBaseType> DIAG_T;
    typedef InputBaseType RECIP_DIAG_T;
    typedef x_complex<InputBaseType> OFF_DIAG_T;
    typedef x_complex<OutputBaseType> L_OUTPUT_T;
    static const int ARCH            = 1;
    static const int INNER_II        = 1;
    static const int UNROLL_FACTOR   = 1;
    static const int UNROLL_DIM      = (LowerTriangularL==true?1:2);
    static const int ARCH2_ZERO_LOOP = true;
  };
  
  
  // Further specialization for hls::complex<ap_fixed>
  template<
    bool LowerTriangularL,
    int RowsColsA,
    int W1, int I1, ap_q_mode Q1, ap_o_mode O1, int N1,
    int W2, int I2, ap_q_mode Q2, ap_o_mode O2, int N2>
  struct cholesky_traits
  <LowerTriangularL, RowsColsA, x_complex<ap_fixed<W1, I1, Q1, O1, N1> >, x_complex< ap_fixed<W2, I2, Q2, O2, N2> > > {
    typedef x_complex< ap_fixed<W1+W1                       , I1+I1                                  , AP_RND_CONV, AP_SAT, 0> > PROD_T;
    typedef x_complex< ap_fixed<(W1+W1)+BitWidth<RowsColsA>::Value,(I1+I1)+BitWidth<RowsColsA>::Value, AP_RND_CONV, AP_SAT, 0> > ACCUM_T;
    typedef x_complex< ap_fixed<W1+1                        , I1+1                                   , AP_RND_CONV, AP_SAT, 0> > ADD_T ;
    typedef x_complex< ap_fixed<(W1+1)*2                    , I1+1                                   , AP_RND_CONV, AP_SAT, 0> > DIAG_T;      // Takes result of sqrt
    typedef x_complex< ap_fixed<(W1+1)*2                    , I1+1                                   , AP_RND_CONV, AP_SAT, 0> > OFF_DIAG_T;  // Takes result of /
    typedef ap_fixed<2+(W2-I2)+W2                           , 2+(W2-I2)                              , AP_RND_CONV, AP_SAT, 0> RECIP_DIAG_T;
    typedef x_complex< ap_fixed<W2                          , I2                                     , AP_RND_CONV, AP_SAT, 0> > L_OUTPUT_T;  // Takes new L value.  Same as L output but saturation set
    static const int ARCH            = 1;
    static const int INNER_II        = 1;
    static const int UNROLL_FACTOR   = 1;
    static const int UNROLL_DIM      = (LowerTriangularL==true?1:2);
    static const int ARCH2_ZERO_LOOP = true;
  };

  template<typename T_IN, typename T_OUT> int cholesky_sqrt_op(x_complex<T_IN> din, x_complex<T_OUT> &dout){
    Function_cholesky_sqrt_op_complex:;
    const T_IN ZERO = 0;
    T_IN a = din.real();
    dout.imag(ZERO);

    if(a<ZERO){
      dout.real(ZERO);
      return(1);
    }

    dout.real(x_sqrt(a));
    return (0);
  }
  
  
  // Local multiplier to handle a complex case currently not supported by the x_complex class
  // - Complex multiplied by a real of a different type
  // - Required for complex fixed point implementations
  template <
      typename AType,
      typename BType,
      typename CType>
  void cholesky_prod_sum_mult(x_complex<AType> A, BType B, x_complex<CType> &C)
  {
    Function_cholesky_prod_sum_mult_complex:;
    C.real(A.real()*B);
    C.imag(A.imag()*B);
  }
  

}
#endif



