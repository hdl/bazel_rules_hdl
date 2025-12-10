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
// QR Inverse functions
// ---------------------
// QR_INVERSE      : Entry point function
// QR_INVERSE_TOP  : Top level function that selects implementation architecture and internal types based on a traits class.

// Change Log
// ----------
// 2015.3:
//  * Updated sub-function traits class definitions to use defaults
// 
// 2015.1:
//  * Linear Algebra Library update.
//  * Function prototype changed to return A_singular flag via argument not return value.
//  * Added qr_inverse_traits configuration class containing the sub-function configuration classes to enable customization.
// 
// 2014.1:
//  * Initial release

#ifndef HLS_QR_INVERSE_H
#define HLS_QR_INVERSE_H

#include <complex>
#include "hls/linear_algebra/utils/x_hls_matrix_utils.h"
#include "hls/linear_algebra/hls_qrf.h"
#include "hls/linear_algebra/hls_back_substitute.h"
#include "hls/linear_algebra/hls_matrix_multiply.h"

namespace hls {
  
  template<
    int RowsColsA,
    typename InputType,
    typename OutputType>
  struct qr_inverse_traits {
    typedef float InternalType; 
    typedef qrf_traits<RowsColsA,RowsColsA,InputType,InternalType> QRF_CONFIG;
    typedef back_substitute_traits<RowsColsA, InternalType, InternalType> BACK_SUB_CONFIG;
    typedef matrix_multiply_traits<hls::NoTranspose,hls::NoTranspose,RowsColsA,RowsColsA,RowsColsA,RowsColsA,InternalType, OutputType> MULTIPLIER_CONFIG;
  };
  
  template<
    int RowsColsA,
    typename InputType,
    typename OutputBaseType>
  struct qr_inverse_traits
  <RowsColsA, InputType, std::complex<OutputBaseType> > {
    typedef std::complex<float> InternalType; 
    typedef qrf_traits<RowsColsA,RowsColsA,InputType,InternalType> QRF_CONFIG;
    typedef back_substitute_traits<RowsColsA, InternalType, InternalType> BACK_SUB_CONFIG;
    typedef matrix_multiply_traits<hls::NoTranspose,hls::NoTranspose,RowsColsA,RowsColsA,RowsColsA,RowsColsA,InternalType, std::complex<OutputBaseType> > MULTIPLIER_CONFIG;
  };
  
  // ===================================================================================================================
  // QR_INVERSE_TOP: Top level function that selects implementation architecture and internal types based on the 
  // traits class
  // o Call this function directly if you wish to override the default architecture choice or internal types
  template <
    int RowsColsA,
    typename QRInverseTraits,
    typename InputType,
    typename OutputType>
  void qr_inverse_top(const InputType A[RowsColsA][RowsColsA],
                            OutputType InverseA[RowsColsA][RowsColsA],
                            int& A_singular) {
    
    // Define intermediate buffers
    typename QRInverseTraits::InternalType Q[RowsColsA][RowsColsA];
    typename QRInverseTraits::InternalType R[RowsColsA][RowsColsA];
    typename QRInverseTraits::InternalType InverseR[RowsColsA][RowsColsA];
    
    // Run QR factorization, get upper-triangular result in R, orthogonal/unitary matrix Q
    const bool TRANSPOSED_Q = true; // Q is produced in transpose form such that Q*A = R
    qrf_top<TRANSPOSED_Q, RowsColsA, RowsColsA, typename QRInverseTraits::QRF_CONFIG, InputType, typename QRInverseTraits::InternalType>(A, Q, R);
    
    // Run back-substitution to compute R^-1
    // This doesn't work in-place, so use an additional array InverseR
    back_substitute_top<RowsColsA,typename QRInverseTraits::BACK_SUB_CONFIG, typename QRInverseTraits::InternalType, typename QRInverseTraits::InternalType>(R, InverseR, A_singular);
    
    // A^-1 = R^-1*Qt
    matrix_multiply_top<NoTranspose, NoTranspose, RowsColsA, RowsColsA, RowsColsA, RowsColsA, RowsColsA, RowsColsA, typename QRInverseTraits::MULTIPLIER_CONFIG, typename QRInverseTraits::InternalType, OutputType>(InverseR, Q, InverseA);
    
  } // end template qr_inverse
  
  // ===================================================================================================================
  // QR_INVERSE: Entry point function.
  // o Template parameters:
  //  - RowsColsA        : Defines the matrix dimensions
  //  - InputType        : Input data type
  //  - OutputType       : Output data type
  // o Arguments:
  //  - A                : Input matrix A
  //  - InverseA         : Inverse of input matrix
  //  - A_singular       : Failure, matrix A is singular
  template <
    int RowsColsA,
    typename InputType,
    typename OutputType>
  void qr_inverse(const InputType A[RowsColsA][RowsColsA],
                        OutputType InverseA[RowsColsA][RowsColsA],
                        int& A_singular) {
    typedef qr_inverse_traits<RowsColsA, InputType, OutputType> DEFAULT_QR_INVERSE_TRAITS;
    qr_inverse_top<RowsColsA, DEFAULT_QR_INVERSE_TRAITS, InputType, OutputType>(A, InverseA, A_singular);
  }
} // end namespace hls

#endif


