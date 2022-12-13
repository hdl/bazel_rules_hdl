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
 
// Matrix Multiply functions
// -------------------------
// MATRIX_MULTIPLY           : Entry point function.
// MATRIX_MULTIPLY_TOP       : Top level function that selects implementation architecture and internal types based on traits class.
// MATRIX_MULTIPLY_DEFAULT   : Default architecture.
// MATRIX_MULTIPLY_ALT1      : Improved throughput for rolled floating point implementations at the expense of an additional memory.
// MATRIX_MULTIPLY_ALT2      : Further rolled floating point throughput improvement for small matrix sizes. Requires larger internal memory.
// MATRIX_MULTIPLY_ADD_TREE  : Architecture using an adder tree for fully unrolled floating point implementations.
// MATRIX_MULTIPLY_FULL      : Default architecture including directives to fully unroll inner loop, fixed point implementations

// Change Log
// ----------
// 2015.3:
//  * Default architecture selected based on data type
//  * Removed default architecture choice macros
//  * Added default inner loop pipelining value set via configuration traits class
//  * Correction to internal ap_fixed types bit width
//  * Added MATRIX_MULTIPLY_FULL architecture
// 
// 2015.1:
//  * Linear Algebra Library update.
//  * No changes
// 
// 2014.1:
//  * Initial release

#ifndef X_COMPLEX_MATRIX_MULTIPLY_H
#define X_COMPLEX_MATRIX_MULTIPLY_H

#include "ap_fixed.h"
#include "hls/linear_algebra/utils/x_hls_complex.h"
#include "hls/linear_algebra/deprecated/x_complex_matrix_utils.h"
#include "hls/linear_algebra/hls_matrix_multiply.h"

#ifndef __SYNTHESIS__
#include <assert.h>
#endif

namespace hls {
  
  
  // Further specialization for x_complex<ap_fixed>
  template<
    class TransposeFormA,
    class TransposeFormB,
    int RowsA, 
    int ColsA, 
    int RowsB,
    int ColsB,
    int W1, int I1, ap_q_mode Q1, ap_o_mode O1, int N1,
    int W2, int I2, ap_q_mode Q2, ap_o_mode O2, int N2> 
  struct matrix_multiply_traits
  <TransposeFormA, TransposeFormB, RowsA, ColsA, RowsB, ColsB, x_complex<ap_fixed<W1, I1, Q1, O1, N1> >, x_complex<ap_fixed<W2, I2, Q2, O2, N2> > > {
    static const int RowsATrans        = ( TransposeFormA::TransposeType != 0 ? ColsA : RowsA);
    static const int ColsATrans        = ( TransposeFormA::TransposeType != 0 ? RowsA : ColsA);
    static const int RowsBTrans        = ( TransposeFormB::TransposeType != 0 ? ColsB : RowsB);
    static const int ColsBTrans        = ( TransposeFormB::TransposeType != 0 ? RowsB : ColsB);
    static const int B_UNROLL_DIM      = ( TransposeFormB::TransposeType != 0 ? 1 : 2);
    static const int A_FULL_UNROLL_DIM = ( TransposeFormA::TransposeType != 0 ? 1 : 2);
    static const int B_FULL_UNROLL_DIM = ( TransposeFormB::TransposeType != 0 ? 2 : 1);
    typedef x_complex< ap_fixed<W1,                                I1,                                AP_TRN, AP_WRAP, 0> > INPUT_T;
    typedef x_complex< ap_fixed<W1+W1,                             I1+I1,                             AP_TRN, AP_WRAP, 0> > MULT_T;
    typedef x_complex< ap_fixed<W1+W1+BitWidth<ColsATrans>::Value, I1+I1+BitWidth<ColsATrans>::Value, AP_TRN, AP_WRAP, 0> > ACCUM_T;
    static const int ARCH              = 0;
    static const int INNER_II          = 1;
    static const int UNROLL_FACTOR     = 1;
  };
  
}

#endif



