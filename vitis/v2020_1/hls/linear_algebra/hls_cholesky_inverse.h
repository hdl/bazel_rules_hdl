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

#ifndef HLS_CHOLESKY_INVERSE_H
#define HLS_CHOLESKY_INVERSE_H

#include "ap_fixed.h"
#include <complex>
#include "hls/linear_algebra/hls_cholesky.h"
#include "hls/linear_algebra/hls_back_substitute.h"
#include "hls/linear_algebra/hls_matrix_multiply.h"

namespace hls {

  // ===================================================================================================================
  // Default traits struct defining the internal variable types for the Cholesky Inverse function
  template<
    int RowsColsA,
    typename InputType,
    typename OutputType>
  struct cholesky_inverse_traits {
    typedef InputType                                             CHOLESKY_OUT;
    typedef cholesky_traits< false,RowsColsA,InputType,InputType> CHOLESKY_TRAITS;
    typedef InputType                                             BACK_SUBSTITUTE_OUT;
    typedef back_substitute_traits<RowsColsA,InputType,InputType> BACK_SUBSTITUTE_TRAITS;
    typedef matrix_multiply_traits<NoTranspose,ConjugateTranspose,RowsColsA,RowsColsA,RowsColsA,RowsColsA,InputType,OutputType> MATRIX_MULTIPLY_TRAITS;
  };

  // Specialization for ap_fixed
  template<
    int RowsColsA,
    int W1, int I1, ap_q_mode Q1, ap_o_mode O1, int N1,
    int W2, int I2, ap_q_mode Q2, ap_o_mode O2, int N2>
  struct cholesky_inverse_traits
    <RowsColsA, ap_fixed<W1, I1, Q1, O1, N1>, ap_fixed<W2, I2, Q2, O2, N2> > {
    // Cholesky decomposition output precision
    static const int       CholeskyOutputW = W1;
    static const int       CholeskyOutputI = I1;
    static const ap_q_mode CholeskyOutputQ = Q1;
    static const ap_o_mode CholeskyOutputO = O1;
    static const int       CholeskyOutputN = N1;
    typedef ap_fixed<CholeskyOutputW, CholeskyOutputI, CholeskyOutputQ, CholeskyOutputO, CholeskyOutputN> CHOLESKY_OUT;
    typedef cholesky_traits< false, RowsColsA, ap_fixed<W1, I1, Q1, O1, N1>, CHOLESKY_OUT>                CHOLESKY_TRAITS;
    // Back substitution output precision
    static const int       BackSubstitutionOutW = W2;
    static const int       BackSubstitutionOutI = I2;
    static const ap_q_mode BackSubstitutionOutQ = Q2;
    static const ap_o_mode BackSubstitutionOutO = O2;
    static const int       BackSubstitutionOutN = N2;
    typedef ap_fixed<BackSubstitutionOutW, BackSubstitutionOutI, BackSubstitutionOutQ, BackSubstitutionOutO, BackSubstitutionOutN> BACK_SUBSTITUTE_OUT;
    typedef back_substitute_traits<RowsColsA, CHOLESKY_OUT, BACK_SUBSTITUTE_OUT >                                                  BACK_SUBSTITUTE_TRAITS;
    typedef matrix_multiply_traits<NoTranspose,ConjugateTranspose,RowsColsA,RowsColsA,RowsColsA,RowsColsA,BACK_SUBSTITUTE_OUT, ap_fixed<W2, I2, Q2, O2, N2> > MATRIX_MULTIPLY_TRAITS;
  };

  // Further specialization for hls::complex<ap_fixed>
  template<
    int RowsColsA,
    int W1, int I1, ap_q_mode Q1, ap_o_mode O1, int N1,
    int W2, int I2, ap_q_mode Q2, ap_o_mode O2, int N2>
  struct cholesky_inverse_traits
    <RowsColsA, std::complex<ap_fixed<W1, I1, Q1, O1, N1> >, std::complex< ap_fixed<W2, I2, Q2, O2, N2> > > {
    // Cholesky decomposition output precision
    static const int       CholeskyOutputW = W1;
    static const int       CholeskyOutputI = I1;
    static const ap_q_mode CholeskyOutputQ = Q1;
    static const ap_o_mode CholeskyOutputO = O1;
    static const int       CholeskyOutputN = N1;
    typedef std::complex< ap_fixed<CholeskyOutputW, CholeskyOutputI, CholeskyOutputQ, CholeskyOutputO, CholeskyOutputN> > CHOLESKY_OUT;
    typedef cholesky_traits< false, RowsColsA, std::complex< ap_fixed<W1, I1, Q1, O1, N1> >, CHOLESKY_OUT >               CHOLESKY_TRAITS;
    // Back substitution output precision
    static const int       BackSubstitutionOutW = W2;
    static const int       BackSubstitutionOutI = I2;
    static const ap_q_mode BackSubstitutionOutQ = Q2;
    static const ap_o_mode BackSubstitutionOutO = O2;
    static const int       BackSubstitutionOutN = N2;
    typedef std::complex< ap_fixed<BackSubstitutionOutW, BackSubstitutionOutI, BackSubstitutionOutQ, BackSubstitutionOutO, BackSubstitutionOutN> > BACK_SUBSTITUTE_OUT;
    typedef back_substitute_traits<RowsColsA, CHOLESKY_OUT, BACK_SUBSTITUTE_OUT >                                                               BACK_SUBSTITUTE_TRAITS;
    typedef matrix_multiply_traits<NoTranspose,ConjugateTranspose,RowsColsA,RowsColsA,RowsColsA,RowsColsA,BACK_SUBSTITUTE_OUT, std::complex< ap_fixed<W2, I2, Q2, O2, N2> > > MATRIX_MULTIPLY_TRAITS;
  };

  // ===================================================================================================================
  // CHOLESKY_INVERSE_TOP: Top level function taking a CholeskyInverseTraits template parameter which defines internal types
  template <
    int RowsColsA,
    typename CholeskyInverseTraits,
    typename InputType,
    typename OutputType>
  void cholesky_inverse_top(const InputType  A[RowsColsA][RowsColsA],
                                  OutputType InverseA[RowsColsA][RowsColsA],
                                  int&       cholesky_success) {
    // Define intermediate buffers
    typename CholeskyInverseTraits::CHOLESKY_OUT U[RowsColsA][RowsColsA];
    typename CholeskyInverseTraits::BACK_SUBSTITUTE_OUT U_inv[RowsColsA][RowsColsA];
    int U_singular;
    
    // Run Cholesky, get upper-triangular result
    const bool LOWER_TRIANGULAR = false;
    cholesky_success = cholesky_top<LOWER_TRIANGULAR, RowsColsA, typename CholeskyInverseTraits::CHOLESKY_TRAITS, InputType, typename CholeskyInverseTraits::CHOLESKY_OUT>(A, U);
    
    // Run back-substitution to compute U^-1
    // This doesn't work in-place, so use an additional array U_inv
    back_substitute_top<RowsColsA, typename CholeskyInverseTraits::BACK_SUBSTITUTE_TRAITS, typename CholeskyInverseTraits::CHOLESKY_OUT, typename CholeskyInverseTraits::BACK_SUBSTITUTE_OUT>(U, U_inv,U_singular);
    
    // A^-1 = U^-1*U^-t (equivalent to L-t*L-1)
    matrix_multiply_top<NoTranspose, ConjugateTranspose, RowsColsA, RowsColsA, RowsColsA, RowsColsA, RowsColsA, RowsColsA, typename CholeskyInverseTraits::MATRIX_MULTIPLY_TRAITS, typename CholeskyInverseTraits::BACK_SUBSTITUTE_OUT, OutputType >(U_inv, U_inv, InverseA);
    
  }
  
  // ===================================================================================================================
  // CHOLESKY_INVERSE: Entry point function.
  // o Template parameters:
  //  - RowsColsA        : Defines the matrix dimensions
  //  - InputType        : Input data type
  //  - OutputType       : Output data type
  // o Arguments:
  //  - A                : Square Hermitian/symmetric positive definite input matrix
  //  - InverseA         : Inverse of input matrix
  //  - cholesky_success : Indicates if A was successfully inverted. 0 = Success 1 = Failure. The function attempted to 
  //                       find the square root of a negative number i.e. the input matrix A was not Hermitian/symmetric 
  //                       positive definite.
  template <
    int RowsColsA,
    typename InputType,
    typename OutputType>
  void cholesky_inverse(const InputType  A[RowsColsA][RowsColsA],
                              OutputType InverseA[RowsColsA][RowsColsA],
                              int&       cholesky_success) {
    typedef cholesky_inverse_traits<RowsColsA, InputType, OutputType> DEFAULT_CHOLESKY_INVERSE_TRAITS;
    cholesky_inverse_top<RowsColsA, DEFAULT_CHOLESKY_INVERSE_TRAITS, InputType, OutputType>(A, InverseA, cholesky_success);
  }

} // end namespace hls

#endif


