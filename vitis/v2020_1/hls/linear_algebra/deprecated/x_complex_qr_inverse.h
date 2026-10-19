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

#ifndef X_COMPLEX_QR_INVERSE_H
#define X_COMPLEX_QR_INVERSE_H

#include "hls/linear_algebra/utils/x_hls_complex.h"
#include "hls/linear_algebra/deprecated/x_complex_matrix_utils.h"
#include "hls/linear_algebra/deprecated/x_complex_qrf.h"
#include "hls/linear_algebra/hls_qr_inverse.h"
#include "hls/linear_algebra/deprecated/x_complex_back_substitute.h"
#include "hls/linear_algebra/deprecated/x_complex_matrix_multiply.h"

namespace hls {
  
  
  template<
    int RowsColsA,
    typename InputType,
    typename OutputBaseType>
  struct qr_inverse_traits
  <RowsColsA, InputType, x_complex<OutputBaseType> > {
    typedef x_complex<float> InternalType; 
    typedef qrf_traits<RowsColsA,RowsColsA,InputType,InternalType> QRF_CONFIG;
    typedef back_substitute_traits<RowsColsA, InternalType, InternalType> BACK_SUB_CONFIG;
    typedef matrix_multiply_traits<hls::NoTranspose,hls::NoTranspose,RowsColsA,RowsColsA,RowsColsA,RowsColsA,InternalType, x_complex<OutputBaseType> > MULTIPLIER_CONFIG;
  };
  
} // end namespace hls

#endif


