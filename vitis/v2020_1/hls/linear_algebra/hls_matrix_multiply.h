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

#ifndef HLS_MATRIX_MULTIPLY_H
#define HLS_MATRIX_MULTIPLY_H

#include "ap_fixed.h"
#include <complex> 
#include "hls/linear_algebra/utils/x_hls_matrix_utils.h"

#ifndef __SYNTHESIS__
#include <assert.h>
#endif

namespace hls {
  
  // ===================================================================================================================
  // Default traits struct defining variable types and architecture selection
  template<
    class TransposeFormA,
    class TransposeFormB,
    int RowsA, 
    int ColsA, 
    int RowsB,
    int ColsB,
    typename InputType, 
    typename OutputType> 
  struct matrix_multiply_traits {
    static const int RowsATrans         = ( TransposeFormA::TransposeType != 0 ? ColsA : RowsA);
    static const int ColsATrans         = ( TransposeFormA::TransposeType != 0 ? RowsA : ColsA);
    static const int RowsBTrans         = ( TransposeFormB::TransposeType != 0 ? ColsB : RowsB);
    static const int ColsBTrans         = ( TransposeFormB::TransposeType != 0 ? RowsB : ColsB);
    static const int B_UNROLL_DIM       = ( TransposeFormB::TransposeType != 0 ? 1 : 2); // Determine B input unroll dimension for MATRIX_MULTIPLY_ADD_ALT 1&2 architectures
    static const int A_FULL_UNROLL_DIM  = ( TransposeFormA::TransposeType != 0 ? 1 : 2); // Determine A input unroll dimension for MATRIX_MULTIPLY_ADD_TREE and MATRIX_MULTIPLY_FULL architectures
    static const int B_FULL_UNROLL_DIM  = ( TransposeFormB::TransposeType != 0 ? 2 : 1); // Determine B input unroll dimension for MATRIX_MULTIPLY_ADD_TREE and MATRIX_MULTIPLY_FULL architectures
    typedef          InputType                                 INPUT_T;
    typedef typename x_traits<InputType,InputType>::MULT_T     MULT_T;
    typedef typename x_traits_d<InputType,ColsATrans>::ACCUM_T ACCUM_T;
    static const int ARCH              = 2; // Select implementation:
                                            // 0: MATRIX_MULTIPLY_DEFAULT 
                                            // 1: MATRIX_MULTIPLY_ALT1    
                                            // 2: MATRIX_MULTIPLY_ALT2    
                                            // 3: MATRIX_MULTIPLY_ADD_TREE
                                            // 4: MATRIX_MULTIPLY_FULL    
    static const int INNER_II          = 1; // Specify the pipelining target for the inner loop
    static const int UNROLL_FACTOR     = 1; // Specify the inner loop unrolling factor
  };
  
  // Specialization for ap_fixed
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
  <TransposeFormA, TransposeFormB, RowsA, ColsA, RowsB, ColsB, ap_fixed<W1, I1, Q1, O1, N1>, ap_fixed<W2, I2, Q2, O2, N2> > {
    static const int RowsATrans        = ( TransposeFormA::TransposeType != 0 ? ColsA : RowsA);
    static const int ColsATrans        = ( TransposeFormA::TransposeType != 0 ? RowsA : ColsA);
    static const int RowsBTrans        = ( TransposeFormB::TransposeType != 0 ? ColsB : RowsB);
    static const int ColsBTrans        = ( TransposeFormB::TransposeType != 0 ? RowsB : ColsB);
    static const int B_UNROLL_DIM      = ( TransposeFormB::TransposeType != 0 ? 1 : 2);
    static const int A_FULL_UNROLL_DIM = ( TransposeFormA::TransposeType != 0 ? 1 : 2);
    static const int B_FULL_UNROLL_DIM = ( TransposeFormB::TransposeType != 0 ? 2 : 1);
    typedef ap_fixed<W1,                                I1,                                Q1,     O1     ,N1>  INPUT_T;
    typedef ap_fixed<W1+W1,                             I1+I1,                             AP_TRN, AP_WRAP, 0>  MULT_T;
    typedef ap_fixed<W1+W1+BitWidth<ColsATrans>::Value, I1+I1+BitWidth<ColsATrans>::Value, AP_TRN, AP_WRAP, 0>  ACCUM_T;
    static const int ARCH              = 0;
    static const int INNER_II          = 1;
    static const int UNROLL_FACTOR     = 1;
  };
  
  // Further specialization for std::complex<ap_fixed>
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
  <TransposeFormA, TransposeFormB, RowsA, ColsA, RowsB, ColsB, std::complex<ap_fixed<W1, I1, Q1, O1, N1> >, std::complex<ap_fixed<W2, I2, Q2, O2, N2> > > {
    static const int RowsATrans        = ( TransposeFormA::TransposeType != 0 ? ColsA : RowsA);
    static const int ColsATrans        = ( TransposeFormA::TransposeType != 0 ? RowsA : ColsA);
    static const int RowsBTrans        = ( TransposeFormB::TransposeType != 0 ? ColsB : RowsB);
    static const int ColsBTrans        = ( TransposeFormB::TransposeType != 0 ? RowsB : ColsB);
    static const int B_UNROLL_DIM      = ( TransposeFormB::TransposeType != 0 ? 1 : 2);
    static const int A_FULL_UNROLL_DIM = ( TransposeFormA::TransposeType != 0 ? 1 : 2);
    static const int B_FULL_UNROLL_DIM = ( TransposeFormB::TransposeType != 0 ? 2 : 1);
    typedef std::complex< ap_fixed<W1,                                I1,                                AP_TRN, AP_WRAP, 0> > INPUT_T;
    typedef std::complex< ap_fixed<W1+W1,                             I1+I1,                             AP_TRN, AP_WRAP, 0> > MULT_T;
    typedef std::complex< ap_fixed<W1+W1+BitWidth<ColsATrans>::Value, I1+I1+BitWidth<ColsATrans>::Value, AP_TRN, AP_WRAP, 0> > ACCUM_T;
    static const int ARCH              = 0;
    static const int INNER_II          = 1;
    static const int UNROLL_FACTOR     = 1;
  };
  
  // ===================================================================================================================
  // MATRIX_MULTIPLY_DEFAULT: Default architecture
  // o Fixed point implementation maps well to DSP48 cascades
  // o Floating point adders get used sequentially as an accumulator giving a long latency 
  template<
    class TransposeFormA,
    class TransposeFormB,
    int RowsA, 
    int ColsA, 
    int RowsB,
    int ColsB,
    int RowsC,
    int ColsC,
    typename MULTIPLIER_TRAITS,
    typename InputType,
    typename OutputType>
  void matrix_multiply_default(const InputType A [RowsA][ColsA],
                               const InputType B [RowsB][ColsB],
                               OutputType C [RowsC][ColsC])
  {
    // Check defined array dimensions are compatible
    // - The ROWS and COLS value of the traits considers the transpose operation request for A & B
#ifndef __SYNTHESIS__
    assert(MULTIPLIER_TRAITS::ColsATrans == MULTIPLIER_TRAITS::RowsBTrans);
    assert(RowsC == MULTIPLIER_TRAITS::RowsATrans);
    assert(ColsC == MULTIPLIER_TRAITS::ColsBTrans);
#endif
    
    // Use the traits struct to specify the correct type for the intermediate variables
    typename MULTIPLIER_TRAITS::INPUT_T cast_in_a, cast_in_b;
    typename MULTIPLIER_TRAITS::MULT_T  mult;
    typename MULTIPLIER_TRAITS::ACCUM_T recast_mult, sum_mult;
    
    a_row_loop: for (int r = 0; r < MULTIPLIER_TRAITS::RowsATrans; r++) {
      b_col_loop: for (int c = 0; c < MULTIPLIER_TRAITS::ColsBTrans; c++) {
        a_col_loop: for (int k = 0; k < MULTIPLIER_TRAITS::ColsATrans; k++) {
          #pragma HLS PIPELINE II = MULTIPLIER_TRAITS::INNER_II
          cast_in_a = GetMatrixElement<TransposeFormA,RowsA,ColsA,InputType>(A, r, k);
          cast_in_b = GetMatrixElement<TransposeFormB,RowsB,ColsB,InputType>(B, k, c);
          mult      = cast_in_a * cast_in_b;
          
          // Cast mult to the correct output size before adding.
          recast_mult = mult;
          if (k==0)
            sum_mult = recast_mult;
          else
            sum_mult += recast_mult;
          
          // Store result
          if (k==MULTIPLIER_TRAITS::ColsATrans-1) C[r][c] = sum_mult;
        }
      }
    }
  }
  
  // ===================================================================================================================
  // MATRIX_MULTIPLY_ALT1: Improved throughput for rolled floating point implementations at the expense of an additional 
  // memory.
  // o Moves the inner loop defined in matrix_multiply_default up one level of nesting and uses an internal memory to store
  //   partial results
  // o For matrix sizes where the common dimension (A rows & B cols) is greater than the latency of the accumulation adder 
  //   this implementation will achieve full throughput for the inner loop once it is pipelined.
  // o For smaller matrix sizes use matrix_multiply_alt2 to achieve full throughput in the inner loop.
  template<
    class TransposeFormA,
    class TransposeFormB,
    int RowsA, 
    int ColsA, 
    int RowsB,
    int ColsB,
    int RowsC,
    int ColsC,
    typename MULTIPLIER_TRAITS,
    typename InputType,
    typename OutputType>
  void matrix_multiply_alt1(const InputType A [RowsA][ColsA],
                            const InputType B [RowsB][ColsB],
                            OutputType C [RowsC][ColsC])
  {
    // Check defined array dimensions are compatible
    // - The ROWS and COLS value of the traits considers the transpose operation request for A & B
#ifndef __SYNTHESIS__
    assert(MULTIPLIER_TRAITS::ColsATrans == MULTIPLIER_TRAITS::RowsBTrans);
    assert(RowsC == MULTIPLIER_TRAITS::RowsATrans);
    assert(ColsC == MULTIPLIER_TRAITS::ColsBTrans);
#endif
    
    // Use the traits struct to specify the correct type for the intermediate variables
    typename MULTIPLIER_TRAITS::INPUT_T cast_in_a, cast_in_b;
    typename MULTIPLIER_TRAITS::MULT_T  mult;
    typename MULTIPLIER_TRAITS::ACCUM_T recast_mult;
    typename MULTIPLIER_TRAITS::ACCUM_T sum_mult[MULTIPLIER_TRAITS::ColsBTrans];
    
    #pragma HLS ARRAY_PARTITION variable=B        cyclic dim=MULTIPLIER_TRAITS::B_UNROLL_DIM factor=MULTIPLIER_TRAITS::UNROLL_FACTOR
    #pragma HLS ARRAY_PARTITION variable=C        cyclic dim=2 factor=MULTIPLIER_TRAITS::UNROLL_FACTOR
    #pragma HLS ARRAY_PARTITION variable=sum_mult cyclic dim=1 factor=MULTIPLIER_TRAITS::UNROLL_FACTOR
    
    a_row_loop: for (int r = 0; r < MULTIPLIER_TRAITS::RowsATrans; r++) {
      a_col_loop: for (int k = 0; k < MULTIPLIER_TRAITS::ColsATrans; k++) {
        b_col_loop: for (int c = 0; c < MULTIPLIER_TRAITS::ColsBTrans; c++) {
          #pragma HLS PIPELINE II = MULTIPLIER_TRAITS::INNER_II
          #pragma HLS UNROLL FACTOR = MULTIPLIER_TRAITS::UNROLL_FACTOR
          // Multiply
          cast_in_a = GetMatrixElement<TransposeFormA,RowsA,ColsA,InputType>(A, r, k);
          cast_in_b = GetMatrixElement<TransposeFormB,RowsB,ColsB,InputType>(B, k, c);
          mult      = cast_in_a * cast_in_b;
          // Cast mult to the correct output size before adding.
          recast_mult = mult;
          // Sum
          if (k==0) {
            // Initialise
            sum_mult[c] = recast_mult;
          } else if (k==MULTIPLIER_TRAITS::ColsATrans-1) {
            // Store result
            C[r][c]     = sum_mult[c] + recast_mult;
          } else {
            // Accumulate
            sum_mult[c] = sum_mult[c] + recast_mult;
          }
        }
      }
    }
  }
  
  // ===================================================================================================================
  // MATRIX_MULTIPLY_ALT2: Further rolled floating point throughput improvement for small matrix sizes. Requires larger 
  // internal memory.
  template<
    class TransposeFormA,
    class TransposeFormB,
    int RowsA, 
    int ColsA, 
    int RowsB,
    int ColsB,
    int RowsC,
    int ColsC,
    typename MULTIPLIER_TRAITS,
    typename InputType,
    typename OutputType>
  void matrix_multiply_alt2(const InputType A [RowsA][ColsA],
                            const InputType B [RowsB][ColsB],
                            OutputType C [RowsC][ColsC])
  {
    // Check defined array dimensions are compatible
    // - The ROWS and COLS value of the traits considers the transpose operation request for A & B
#ifndef __SYNTHESIS__
    assert(MULTIPLIER_TRAITS::ColsATrans == MULTIPLIER_TRAITS::RowsBTrans);
    assert(RowsC == MULTIPLIER_TRAITS::RowsATrans);
    assert(ColsC == MULTIPLIER_TRAITS::ColsBTrans);
#endif
    
    // Use the traits struct to specify the correct type for the intermediate variables
    typename MULTIPLIER_TRAITS::INPUT_T cast_in_a, cast_in_b;
    typename MULTIPLIER_TRAITS::MULT_T  mult;
    typename MULTIPLIER_TRAITS::ACCUM_T recast_mult;
    typename MULTIPLIER_TRAITS::ACCUM_T sum_mult[MULTIPLIER_TRAITS::RowsATrans][MULTIPLIER_TRAITS::ColsBTrans];
    
    #pragma HLS ARRAY_PARTITION variable=B        cyclic dim=MULTIPLIER_TRAITS::B_UNROLL_DIM factor=MULTIPLIER_TRAITS::UNROLL_FACTOR
    #pragma HLS ARRAY_PARTITION variable=C        cyclic dim=2 factor=MULTIPLIER_TRAITS::UNROLL_FACTOR
    #pragma HLS ARRAY_PARTITION variable=sum_mult cyclic dim=2 factor=MULTIPLIER_TRAITS::UNROLL_FACTOR
    
    a_col_loop: for (int k = 0; k < MULTIPLIER_TRAITS::ColsATrans; k++) {
      a_row_loop: for (int r = 0; r < MULTIPLIER_TRAITS::RowsATrans; r++) {
        b_col_loop: for (int c = 0; c < MULTIPLIER_TRAITS::ColsBTrans; c++) {
          #pragma HLS PIPELINE II = MULTIPLIER_TRAITS::INNER_II
          #pragma HLS UNROLL FACTOR = MULTIPLIER_TRAITS::UNROLL_FACTOR
          // Multiply
          cast_in_a = GetMatrixElement<TransposeFormA,RowsA,ColsA,InputType>(A, r, k);
          cast_in_b = GetMatrixElement<TransposeFormB,RowsB,ColsB,InputType>(B, k, c);
          mult      = cast_in_a * cast_in_b;
          // Cast mult to the correct output size before adding.
          recast_mult = mult;
          // Sum
          if (k==0) {
            // Initialise
            sum_mult[r][c] = recast_mult;
          } else if (k==MULTIPLIER_TRAITS::ColsATrans-1) {
            // Store result
            C[r][c]     = sum_mult[r][c] + recast_mult;
          } else {
            // Accumulate
            sum_mult[r][c] = sum_mult[r][c] + recast_mult;
          }
        }
      }
    }
  }
  
  // ===================================================================================================================
  // MATRIX_MULTIPLY_ADD_TREE: Architecture using an adder tree
  // o Optimized for unrolled floating-point. In fixed-point, this adds overhead.
  template<
    class TransposeFormA,
    class TransposeFormB,
    int RowsA, 
    int ColsA, 
    int RowsB,
    int ColsB,
    int RowsC,
    int ColsC,
    typename MULTIPLIER_TRAITS,
    typename InputType,
    typename OutputType>
  void matrix_multiply_add_tree(const InputType A [RowsA][ColsA],
                                const InputType B [RowsB][ColsB],
                                OutputType C [RowsC][ColsC])
  {
    
    // Check defined array dimensions are compatible
    // - The ROWS and COLS value of the traits considers the transpose operation request for A & B
#ifndef __SYNTHESIS__
    assert(MULTIPLIER_TRAITS::ColsATrans == MULTIPLIER_TRAITS::RowsBTrans);
    assert(RowsC == MULTIPLIER_TRAITS::RowsATrans);
    assert(ColsC == MULTIPLIER_TRAITS::ColsBTrans);
#endif
    
    #pragma HLS ARRAY_PARTITION variable=A complete dim=MULTIPLIER_TRAITS::A_FULL_UNROLL_DIM
    #pragma HLS ARRAY_PARTITION variable=B complete dim=MULTIPLIER_TRAITS::B_FULL_UNROLL_DIM
    
    // Use the traits struct to specify the correct type for the intermediate variables
    typename MULTIPLIER_TRAITS::INPUT_T cast_in_a, cast_in_b;
    typename MULTIPLIER_TRAITS::MULT_T  mult;
    
    // Determine the number of ranks for the adder tree and declare array
    // o The adder_tree is larger than required as each rank only needs to be half the size of the previous rank
    const unsigned a_cols_log2      = BitWidth<MULTIPLIER_TRAITS::ColsATrans>::Value;
    const unsigned a_cols_sub1_log2 = BitWidth<MULTIPLIER_TRAITS::ColsATrans-1>::Value;
    const unsigned num_ranks = (a_cols_log2 != a_cols_sub1_log2 ? a_cols_log2 : a_cols_log2 + 1);
    
    typename MULTIPLIER_TRAITS::ACCUM_T adder_tree[num_ranks][MULTIPLIER_TRAITS::ColsATrans];
    
    a_row_loop: for (int i=0; i < MULTIPLIER_TRAITS::RowsATrans; i++) {
      b_col_loop: for (int j=0; j < MULTIPLIER_TRAITS::ColsBTrans; j++) {
        // Fully unrolled inner loop
        #pragma HLS PIPELINE II = 1
        a_col_loop: for (int k=0; k < MULTIPLIER_TRAITS::ColsATrans; k++) {
          cast_in_a = GetMatrixElement<TransposeFormA,RowsA,ColsA,InputType>(A, i, k);
          cast_in_b = GetMatrixElement<TransposeFormB,RowsB,ColsB,InputType>(B, k, j);
          mult =  cast_in_a * cast_in_b;
          // Assign multiplier output to the first rank of the adder tree array
          adder_tree[num_ranks-1][k] = mult;
        }
        
        // Build adder tree
        unsigned rank_size = MULTIPLIER_TRAITS::ColsATrans;
        add_level_loop: for(int adder_tree_rank=num_ranks-2; adder_tree_rank>=0; adder_tree_rank--) {
          unsigned prev_rank_is_odd = rank_size % 2;
          rank_size = (rank_size+1) / 2; // rank size
          // Fixed loop size so it can be unrolled.
          add_col_loop: for(int jj=0; jj<((MULTIPLIER_TRAITS::ColsATrans+1)/2); jj++) {
            if (jj<rank_size) {
              if ( prev_rank_is_odd && jj == rank_size-1 ) {
                // Bypass, no adder required.
                adder_tree[adder_tree_rank][jj] = adder_tree[adder_tree_rank+1][(jj*2)];
              } else {
                adder_tree[adder_tree_rank][jj] = adder_tree[adder_tree_rank+1][jj*2] + adder_tree[adder_tree_rank+1][(jj*2)+1];
              }
            }
          }
        }
        // Store result
        C[i][j] = adder_tree[0][0];
      }
    }
  }
  
  // ===================================================================================================================
  // MATRIX_MULTIPLY_FULL: Default architecture including directives to fully unroll inner loop, fixed point implementations
  // o Fixed point implementation maps well to DSP48 cascades
  template<
    class TransposeFormA,
    class TransposeFormB,
    int RowsA, 
    int ColsA, 
    int RowsB,
    int ColsB,
    int RowsC,
    int ColsC,
    typename MULTIPLIER_TRAITS,
    typename InputType,
    typename OutputType>
  void matrix_multiply_full(const InputType A [RowsA][ColsA],
                            const InputType B [RowsB][ColsB],
                            OutputType C [RowsC][ColsC])
  {
    // Check defined array dimensions are compatible
    // - The ROWS and COLS value of the traits considers the transpose operation request for A & B
#ifndef __SYNTHESIS__
    assert(MULTIPLIER_TRAITS::ColsATrans == MULTIPLIER_TRAITS::RowsBTrans);
    assert(RowsC == MULTIPLIER_TRAITS::RowsATrans);
    assert(ColsC == MULTIPLIER_TRAITS::ColsBTrans);
#endif
    
    // Use the traits struct to specify the correct type for the intermediate variables
    typename MULTIPLIER_TRAITS::INPUT_T cast_in_a, cast_in_b;
    typename MULTIPLIER_TRAITS::MULT_T  mult;
    typename MULTIPLIER_TRAITS::ACCUM_T recast_mult, sum_mult;
    
    #pragma HLS ARRAY_PARTITION variable=A complete dim=MULTIPLIER_TRAITS::A_FULL_UNROLL_DIM
    #pragma HLS ARRAY_PARTITION variable=B complete dim=MULTIPLIER_TRAITS::B_FULL_UNROLL_DIM
    
    a_row_loop: for (int r = 0; r < MULTIPLIER_TRAITS::RowsATrans; r++) {
      b_col_loop: for (int c = 0; c < MULTIPLIER_TRAITS::ColsBTrans; c++) {
        // Fully unrolled inner loop
        #pragma HLS PIPELINE II = 1
        a_col_loop: for (int k = 0; k < MULTIPLIER_TRAITS::ColsATrans; k++) {
          
          cast_in_a = GetMatrixElement<TransposeFormA,RowsA,ColsA,InputType>(A, r, k);
          cast_in_b = GetMatrixElement<TransposeFormB,RowsB,ColsB,InputType>(B, k, c);
          mult      = cast_in_a * cast_in_b;
          
          // Cast mult to the correct output size before adding.
          recast_mult = mult;
          if (k==0)
            sum_mult = recast_mult;
          else
            sum_mult += recast_mult;
          
          // Store result
          if (k==MULTIPLIER_TRAITS::ColsATrans-1) C[r][c] = sum_mult;
        }
      }
    }
  }
  
  // ===================================================================================================================
  // MATRIX_MULTIPLY_TOP: Top level function that selects implementation architecture and internal types based on the 
  // traits class provided via the MULTIPLIER_TRAITS template parameter. 
  // o Call this function directly if you wish to override the default architecture choice or internal types
  template< 
    class TransposeFormA,
    class TransposeFormB,
    int RowsA, 
    int ColsA, 
    int RowsB,
    int ColsB,
    int RowsC,
    int ColsC,
    typename MULTIPLIER_TRAITS,
    typename InputType,
    typename OutputType>
  void matrix_multiply_top(const InputType A [RowsA][ColsA],
                           const InputType B [RowsB][ColsB],
                           OutputType C [RowsC][ColsC])
  {
    
    switch(MULTIPLIER_TRAITS::ARCH) {
    case 0:
      matrix_multiply_default<TransposeFormA, TransposeFormB, RowsA,  ColsA,  RowsB, ColsB, RowsC, ColsC, MULTIPLIER_TRAITS, InputType, OutputType> (A, B, C);
      break;
    case 1:
      matrix_multiply_alt1<TransposeFormA, TransposeFormB, RowsA,  ColsA,  RowsB, ColsB, RowsC, ColsC, MULTIPLIER_TRAITS, InputType, OutputType> (A, B, C);
      break;
    case 2:
      matrix_multiply_alt2<TransposeFormA, TransposeFormB, RowsA,  ColsA,  RowsB, ColsB, RowsC, ColsC, MULTIPLIER_TRAITS, InputType, OutputType> (A, B, C);
      break;
    case 3:
      matrix_multiply_add_tree<TransposeFormA, TransposeFormB, RowsA,  ColsA,  RowsB, ColsB, RowsC, ColsC, MULTIPLIER_TRAITS, InputType, OutputType> (A, B, C);
      break;
    case 4:
      matrix_multiply_full<TransposeFormA, TransposeFormB, RowsA,  ColsA,  RowsB, ColsB, RowsC, ColsC, MULTIPLIER_TRAITS, InputType, OutputType> (A, B, C);
      break;
    default:
      matrix_multiply_default<TransposeFormA, TransposeFormB, RowsA,  ColsA,  RowsB, ColsB, RowsC, ColsC, MULTIPLIER_TRAITS, InputType, OutputType> (A, B, C);
    }
  }
  
  // ===================================================================================================================
  // MATRIX_MULTIPLY: Entry point function.
  // o Template parameters:
  //  - TransposeFormA : Defines if the A matix is transposed before the multiplication. Valid values are: 
  //                     NoTranspose, Transpose, ConjugateTranspose
  //  - TransposeFormB : Defines if the A matix is transposed before the multiplication.
  //  - RowsA          : Defines the number of rows in the A matrix
  //  - ColsA          : Defines the number of columns in the A matrix
  //  - RowsB          : Defines the number of rows in the B matrix
  //  - ColsB          : Defines the number of columns in the B matrix
  //  - RowsC          : Defines the number of rows in the C matrix
  //  - ColsC          : Defines the number of columns in the C matrix
  //  - InputType      : Input data type
  //  - OutputType     : Output data type
  // o Arguments:
  //  - A              : First input matrix
  //  - B              : Second input matrix
  //  - C              : AB product output matrix
  template<
    class TransposeFormA,
    class TransposeFormB,
    int RowsA, 
    int ColsA, 
    int RowsB,
    int ColsB,
    int RowsC,
    int ColsC,
    typename InputType, 
    typename OutputType>
  void matrix_multiply(const InputType A [RowsA][ColsA],
                       const InputType B [RowsB][ColsB],
                       OutputType C [RowsC][ColsC])
  {
    // Define default traits struct for template type
    typedef matrix_multiply_traits<TransposeFormA, TransposeFormB, RowsA,  ColsA,  RowsB, ColsB, InputType, OutputType> DEFAULT_MULTIPLIER_TRAITS;
    // Call top level function
    matrix_multiply_top<TransposeFormA, TransposeFormB, RowsA,  ColsA,  RowsB, ColsB, RowsC, ColsC, DEFAULT_MULTIPLIER_TRAITS, InputType, OutputType> (A, B, C);
  }
}

#endif



