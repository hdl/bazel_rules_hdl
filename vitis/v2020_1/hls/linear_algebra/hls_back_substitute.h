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

#ifndef HLS_BACK_SUBSTITUTE_H
#define HLS_BACK_SUBSTITUTE_H

#include "ap_fixed.h"
#include <complex> 

namespace hls {

  // ===================================================================================================================
  // Default traits struct defining the internal variable types for the Back Substitution function
  template<
    int RowsColsA,
    typename InputType,
    typename OutputType>
  struct back_substitute_traits {
    typedef InputType RECIP_T;
    typedef InputType MULT_T;
    typedef InputType ADD_T;
    typedef InputType MULTNEG_T;
    static const int ARCH     = 1; // Select implementation. 0=Basic. 1=Improved throughput.
    static const int INNER_II = 1; // Specify the pipelining target for the main inner loop
    static const int DIAG_II  = 1; // Specify the pipelining target for the diag loop in BACK_SUBSTITUTE_ALT
  };
  
  // Specialization for ap_fixed
  template<
    int RowsColsA,
    int W1, int I1, ap_q_mode Q1, ap_o_mode O1, int N1,
    int W2, int I2, ap_q_mode Q2, ap_o_mode O2, int N2>
  struct back_substitute_traits
    <RowsColsA, ap_fixed<W1, I1, Q1, O1, N1>, ap_fixed<W2, I2, Q2, O2, N2> > {
    static const int W = W1+(W1-I1)+(W1-I1); // Fractional growth is denominator fraction width + numerator full width
    static const int I = I1+(W1-I1); // Integer growth is denominator int width + numerator fraction width
    typedef  ap_fixed<W, I, AP_TRN, AP_WRAP, 0>  RECIP_T;
    typedef  ap_fixed<2*W, 2*I, AP_TRN, AP_WRAP, 0>  MULT_T;
    typedef  ap_fixed<(2*W)+1, (2*I)+1, AP_TRN, AP_WRAP, 0>  ADD_T;
    typedef  ap_fixed<2*W2, 2*I2, AP_TRN, AP_WRAP, 0>  MULTNEG_T;
    static const int ARCH     = 1;
    static const int INNER_II = 1;
    static const int DIAG_II  = 1;
  };

  // Further specialization for std::complex<ap_fixed>
  template<
    int RowsColsA,
    int W1, int I1, ap_q_mode Q1, ap_o_mode O1, int N1,
    int W2, int I2, ap_q_mode Q2, ap_o_mode O2, int N2>
  struct back_substitute_traits
    <RowsColsA, std::complex<ap_fixed<W1, I1, Q1, O1, N1> >, std::complex< ap_fixed<W2, I2, Q2, O2, N2> > > {
    static const int W = W1+(W1-I1)+(W1-I1); // Fractional growth is denominator fraction width + numerator full width
    static const int I = I1+(W1-I1); // Integer growth is denominator int width + numerator fraction width
    typedef std::complex< ap_fixed<W, I, AP_TRN, AP_WRAP, 0> > RECIP_T;
    typedef std::complex< ap_fixed<(2*W)+1, (2*I)+1, AP_TRN, AP_WRAP, 0> > MULT_T;
    typedef std::complex< ap_fixed<(2*W)+2, (2*I)+2, AP_TRN, AP_WRAP, 0> > ADD_T;
    typedef std::complex< ap_fixed<(2*W2)+1,(2*I2)+1, AP_TRN, AP_WRAP, 0> > MULTNEG_T;
    static const int ARCH     = 1;
    static const int INNER_II = 1;
    static const int DIAG_II  = 1;
  };

  // ===================================================================================================================
  // Helper functions

  // IMPLEMENTATION TIP: Force the reciprocal to be implemented using a single-precision divider with the resource directive.
  // This permits sharing of operators with the factorization function preceding the back-substitution
  template <typename T> void back_substitute_recip(T x, T &one_over_x) {
    // #pragma HLS resource variable=one_over_x core=FDiv
    const T ONE = 1.0;
    one_over_x = ONE/x;
  }

  // All diagonal elements of the factorization (Cholesky or QR) should be real.
  // We can therefore use a real-valued divider (or reciprocal operator) to compute the diagonal inverse values.
  //
  // IMPLEMENTATION TIP: Force the reciprocal to be implemented using a single-precision divider with the resource directive.
  // This permits sharing of operators with the factorization function preceding the back-substitution.
  template <typename T> void back_substitute_recip(std::complex<T> x, std::complex<T> &one_over_x) {
    // #pragma HLS resource variable=recip core=FDiv
    T recip; // intermediate variable to allow directive to be applied
    const std::complex<T> ONE = 1.0;
    recip = ONE.real()/x.real();
    one_over_x.real(recip);
    one_over_x.imag(0.0);
  }

  template<
    int W1, int I1, ap_q_mode Q1, ap_o_mode O1, int N1,
    int W2, int I2, ap_q_mode Q2, ap_o_mode O2, int N2>
    void back_substitute_recip(ap_fixed<W1, I1, Q1, O1, N1> x,
                               ap_fixed<W2, I2, Q2, O2, N2> &one_over_x) {
    ap_fixed<W2, I2, Q2, O2, N2> ONE = 1; // Size to the output precision
    one_over_x = ONE/x; // Infers a divider
  }

  template<
    int W1, int I1, ap_q_mode Q1, ap_o_mode O1, int N1,
    int W2, int I2, ap_q_mode Q2, ap_o_mode O2, int N2>
    void back_substitute_recip(std::complex< ap_fixed<W1, I1, Q1, O1, N1> > x,
                               std::complex< ap_fixed<W2, I2, Q2, O2, N2> > &one_over_x) {
    std::complex< ap_fixed<W2, I2, Q2, O2, N2> > ONE; // Size to the output precision
    ONE.real(1);
    ONE.imag(0);
    one_over_x.real( ONE.real()/x.real()); // Infers a real-valued divider
    one_over_x.imag(0);
  }

  // ===================================================================================================================
  // BACK_SUBSTITUTE_BASIC
  // o It is assumed that argument B is an internal buffer created in the calling function
  //   and not an external interface, since the back substitution process reads and writes
  //   from/to that buffer.
  template<
    int RowsColsA,
    typename BackSubstituteTraits,
    typename InputType,
    typename OutputType>
  void back_substitute_basic(const InputType  A[RowsColsA][RowsColsA],
                                   OutputType B[RowsColsA][RowsColsA],
                                   int&       is_singular) {
    
    typename BackSubstituteTraits::RECIP_T diag_recip, diag_recip_calc;
    OutputType subst_prod_m1;
    OutputType subst_prod_m2;
    typename BackSubstituteTraits::MULT_T subst_prod;
    typename BackSubstituteTraits::ADD_T subst_prod_sum;
    typename BackSubstituteTraits::ADD_T subst_sum;
    typename BackSubstituteTraits::ADD_T diag_recip_low;
    typename BackSubstituteTraits::MULTNEG_T neg_diag_prod;
    
    is_singular = 0;
    back_substitute_j : for (int j=0; j<RowsColsA; j++) {
      if (x_real(A[j][j]) == 0 && x_imag(A[j][j]) == 0 )  {
                        is_singular = 1;
      }

      back_substitute_recip(A[j][j],diag_recip);
      B[j][j] = diag_recip;
     // if (x_real(diag_recip) == 0 && x_imag(diag_recip) == 0) {
     //   is_singular = 1;
     // }
      
      back_substitute_i : for (int i=0; i<RowsColsA; i++) {
        if (i >= j) {
          if (i == j) {
            continue;
          } else {
            B[i][j] = 0; // Sets the lower triangle to zero for the final matrix mult to work
          }
        } else {
          subst_sum = 0; // Equivalent to setting zeros in the upper triangle of the identity matrix we're "inverting against"
          back_substitute_k : for (int k=0; k<RowsColsA; k++){
            #pragma HLS PIPELINE II = BackSubstituteTraits::INNER_II
            
            if (k >= j) {
              continue;
            } else {
              if (i > k) {
               continue;
              } else {
                subst_prod_m1 = A[k][j]; // For fixed-point, re-size to higher precision of B
                subst_prod_m2 = B[i][k];
                subst_prod = subst_prod_m1 * subst_prod_m2;
                subst_prod_sum = subst_prod; // Resize
                subst_sum += subst_prod_sum;
              }
            }
            diag_recip_low = diag_recip; // For fixed-point, reduce precision to match subst_sum for multiplication
            // IMPLEMENTATION TIP: Use last subst_sum value below rather than reading from B to reduce error for fixed-point implementations.
            // Implementing as "neg_diag_prod = -B[i][j] * B[j][j];" for fixed-point increases error by ~10%, but halves
            // the DSP48 usage.
            neg_diag_prod = -subst_sum * diag_recip_low;
            B[i][j] = neg_diag_prod;
          } // end i>=j
        }
      }
    }
  } // end template back_substitute_basic
  
  // ===================================================================================================================
  // BACK_SUBSTITUTE_ALT: Re-arrange loops to improve dependencies and throughput, utilizes additional internal buffers 
  // for the diagonal and row accumulations. Arguement B is only written to.
  template<
    int RowsColsA,
    typename BackSubstituteTraits,
    typename InputType,
    typename OutputType>
  void back_substitute_alt(const InputType A[RowsColsA][RowsColsA],
                                 OutputType B[RowsColsA][RowsColsA],
                                 int& is_singular) {
    
    typename BackSubstituteTraits::RECIP_T diag_recip, diag_recip_calc;
    typename BackSubstituteTraits::RECIP_T diag[RowsColsA];
    
    typename BackSubstituteTraits::MULT_T subst_prod;
    typename BackSubstituteTraits::ADD_T subst_prod_sum;
    typename BackSubstituteTraits::ADD_T final_sum;
    typename BackSubstituteTraits::ADD_T subst_sum;
    typename BackSubstituteTraits::ADD_T row_sum[RowsColsA][RowsColsA];
    
    typename BackSubstituteTraits::ADD_T diag_recip_low;
    typename BackSubstituteTraits::MULTNEG_T neg_diag_prod;
    OutputType select_column_multiplier;
    OutputType column_multiplier[RowsColsA];
    OutputType subst_prod_m1;
    
    is_singular = 0;
    diag_loop: for (int i=0;i<RowsColsA;i++) {
      #pragma HLS PIPELINE II = BackSubstituteTraits::DIAG_II 
      if (x_real(A[i][i]) == 0 && x_imag(A[i][i]) == 0 )  {
                                is_singular = 1;
      }
      back_substitute_recip(A[i][i],diag_recip_calc);
      //if (x_real(diag_recip_calc) == 0 && x_imag(diag_recip_calc) == 0) {
      //  is_singular = 1;
      //}
      diag[i] = diag_recip_calc;
    }
    a_col_b_row_loop: for (int i=0;i<RowsColsA;i++) {
      diag_recip     = diag[i];
      diag_recip_low = diag_recip; // For fixed-point, reduce precision to match subst_sum for multiplication
      a_row_loop: for (int j=0;j<RowsColsA;j++) {
        if (j>=i) {
          b_col_loop: for (int k=0;k<RowsColsA;k++) {
            #pragma HLS PIPELINE II = BackSubstituteTraits::INNER_II
            
            // Interleaving column results to relax the dependency on the column_multiplier/result calculation
            // o As a result we need an array to store the row accumulations
            if (k<=i) {
              if (i==j) {
                // Top of the column
                if (k==i) {
                  // Just the diagonal
                  select_column_multiplier = diag_recip;
                } else {
                  final_sum                = row_sum[k][j];
                  neg_diag_prod            = -final_sum * diag_recip_low;
                  select_column_multiplier = neg_diag_prod;
                }
                column_multiplier[k] = select_column_multiplier;
                B[k][i] = select_column_multiplier; // (B[i][k]) Working with a upper triangular matrix
              } else {
                subst_prod_m1 = A[i][j]; // (A[j][i]) Working with a upper triangular matrix
                subst_prod = subst_prod_m1 * column_multiplier[k];
                subst_prod_sum = subst_prod; // Resize
                if (k==i) {
                  // First accumulation in the row sum
                  subst_sum = subst_prod_sum;
                } else {
                  subst_sum = row_sum[k][j] + subst_prod_sum;
                }
                row_sum[k][j] = subst_sum;
              }
            } else {
              B[k][i] = 0; // Zero lower triangle
            }
          }
        } else {
          continue;
        }
      }
    }
  } // end template back_substitute_alt
  
  // ===================================================================================================================
  // BACK_SUBSTITUTE_TOP: Top level function taking a BackSubstituteTraits template parameter which defines internal types
  // o Call this function directly if you wish to override the default internal types
  template<
    int RowsColsA,
    typename BackSubstituteTraits,
    typename InputType,
    typename OutputType>
  void back_substitute_top(const InputType  A[RowsColsA][RowsColsA],
                                 OutputType B[RowsColsA][RowsColsA],
                                 int&       is_singular) {
    switch(BackSubstituteTraits::ARCH) {
    case 0:
      back_substitute_basic<RowsColsA, BackSubstituteTraits, InputType, OutputType>(A, B, is_singular);
      break;
    case 1:
      back_substitute_alt<RowsColsA, BackSubstituteTraits, InputType, OutputType>(A, B, is_singular);
      break;
    default:
      back_substitute_basic<RowsColsA, BackSubstituteTraits, InputType, OutputType>(A, B, is_singular);
      break;
    }
    
  }
  
  // ===================================================================================================================
  // BACK_SUBSTITUTE: Entry point function
  // o Template parameters:
  //  - RowsColsA   : Row and column dimensions
  //  - InputType   : Input data type
  //  - OutputType  : Output data type
  // o Arguments:
  //  - A           : Input matrix
  //  - B           : Output matrix.
  //  - is_singular : Indicates the diagonal of B contains zeros.
  template<
    int RowsColsA,
    typename InputType,
    typename OutputType>
  void back_substitute(const InputType  A[RowsColsA][RowsColsA],
                             OutputType B[RowsColsA][RowsColsA],
                             int& is_singular) {
    typedef back_substitute_traits<RowsColsA, InputType, OutputType> DEFAULT_BACK_SUBSTITUTE_TRAITS;
    back_substitute_top<RowsColsA, DEFAULT_BACK_SUBSTITUTE_TRAITS, InputType, OutputType>(A, B, is_singular);
  }

} // end namespace hls

#endif


