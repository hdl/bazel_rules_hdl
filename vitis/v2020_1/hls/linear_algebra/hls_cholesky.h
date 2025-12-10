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

#ifndef HLS_CHOLESKY_H
#define HLS_CHOLESKY_H

#include "ap_fixed.h"
#include <complex>
#include "hls/linear_algebra/utils/x_hls_matrix_utils.h"

namespace hls {

  // ===================================================================================================================
  // Default traits struct defining the internal variable types for the cholesky function
  template<
    bool LowerTriangularL,
    int RowsColsA,
    typename InputType,
    typename OutputType>
  struct cholesky_traits {
    typedef InputType PROD_T;
    typedef InputType ACCUM_T;
    typedef InputType ADD_T;
    typedef InputType DIAG_T;
    typedef InputType RECIP_DIAG_T;
    typedef InputType OFF_DIAG_T;
    typedef OutputType L_OUTPUT_T;
    static const int ARCH            = 1;     // Select implementation: 0=Basic, 1=Lower latency architecture, 2=Further improved latency architecture
    static const int INNER_II        = 1;     // Specify the pipelining target for the inner loop
    static const int UNROLL_FACTOR   = 1;     // Specify the inner loop unrolling factor for the CHOLESKY_ALT2 architecture(2) to increase throughput
    static const int UNROLL_DIM      = (LowerTriangularL==true?1:2); // Dimension to unroll matrix
    static const int ARCH2_ZERO_LOOP = true;  // Additional implementation "switch" for the CHOLESKY_ALT2 architecture (2).
  };
  
  // Specialization for complex
  template<
    bool LowerTriangularL,
    int RowsColsA,
    typename InputBaseType,
    typename OutputBaseType>
  struct cholesky_traits 
  <LowerTriangularL, RowsColsA, std::complex<InputBaseType>, std::complex<OutputBaseType> > {
    typedef std::complex<InputBaseType> PROD_T;
    typedef std::complex<InputBaseType> ACCUM_T;
    typedef std::complex<InputBaseType> ADD_T;
    typedef std::complex<InputBaseType> DIAG_T;
    typedef InputBaseType RECIP_DIAG_T;
    typedef std::complex<InputBaseType> OFF_DIAG_T;
    typedef std::complex<OutputBaseType> L_OUTPUT_T;
    static const int ARCH            = 1;
    static const int INNER_II        = 1;
    static const int UNROLL_FACTOR   = 1;
    static const int UNROLL_DIM      = (LowerTriangularL==true?1:2);
    static const int ARCH2_ZERO_LOOP = true;
  };
  
  // Specialization for ap_fixed
  template<
    bool LowerTriangularL,
    int RowsColsA,
    int W1, int I1, ap_q_mode Q1, ap_o_mode O1, int N1,
    int W2, int I2, ap_q_mode Q2, ap_o_mode O2, int N2>
  struct cholesky_traits
  <LowerTriangularL, RowsColsA, ap_fixed<W1, I1, Q1, O1, N1>, ap_fixed<W2, I2, Q2, O2, N2> > {
    typedef ap_fixed<W1+W1                       , I1+I1                                  , AP_RND_CONV, AP_SAT, 0> PROD_T;
    typedef ap_fixed<(W1+W1)+BitWidth<RowsColsA>::Value,(I1+I1)+BitWidth<RowsColsA>::Value, AP_RND_CONV, AP_SAT, 0> ACCUM_T;
    typedef ap_fixed<W1+1                        , I1+1                                   , AP_RND_CONV, AP_SAT, 0> ADD_T ;
    typedef ap_fixed<(W1+1)*2                    , I1+1                                   , AP_RND_CONV, AP_SAT, 0> DIAG_T;      // Takes result of sqrt
    typedef ap_fixed<(W1+1)*2                    , I1+1                                   , AP_RND_CONV, AP_SAT, 0> OFF_DIAG_T;  // Takes result of /
    typedef ap_fixed<2+(W2-I2)+W2                , 2+(W2-I2)                              , AP_RND_CONV, AP_SAT, 0> RECIP_DIAG_T;
    typedef ap_fixed<W2                          , I2                                     , AP_RND_CONV, AP_SAT, 0> L_OUTPUT_T;  // Takes new L value.  Same as L output but saturation set
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
  <LowerTriangularL, RowsColsA, std::complex<ap_fixed<W1, I1, Q1, O1, N1> >, std::complex< ap_fixed<W2, I2, Q2, O2, N2> > > {
    typedef std::complex< ap_fixed<W1+W1                       , I1+I1                                  , AP_RND_CONV, AP_SAT, 0> > PROD_T;
    typedef std::complex< ap_fixed<(W1+W1)+BitWidth<RowsColsA>::Value,(I1+I1)+BitWidth<RowsColsA>::Value, AP_RND_CONV, AP_SAT, 0> > ACCUM_T;
    typedef std::complex< ap_fixed<W1+1                        , I1+1                                   , AP_RND_CONV, AP_SAT, 0> > ADD_T ;
    typedef std::complex< ap_fixed<(W1+1)*2                    , I1+1                                   , AP_RND_CONV, AP_SAT, 0> > DIAG_T;      // Takes result of sqrt
    typedef std::complex< ap_fixed<(W1+1)*2                    , I1+1                                   , AP_RND_CONV, AP_SAT, 0> > OFF_DIAG_T;  // Takes result of /
    typedef ap_fixed<2+(W2-I2)+W2                           , 2+(W2-I2)                              , AP_RND_CONV, AP_SAT, 0> RECIP_DIAG_T;
    typedef std::complex< ap_fixed<W2                          , I2                                     , AP_RND_CONV, AP_SAT, 0> > L_OUTPUT_T;  // Takes new L value.  Same as L output but saturation set
    static const int ARCH            = 1;
    static const int INNER_II        = 1;
    static const int UNROLL_FACTOR   = 1;
    static const int UNROLL_DIM      = (LowerTriangularL==true?1:2);
    static const int ARCH2_ZERO_LOOP = true;
  };

  // ===================================================================================================================
  // Helper functions
  
  // Square root
  // o Overloaded versions of the sqrt function
  // o The square root of a complex number is expensive.  However, the diagonal values of a Cholesky decomposition are always
  //   real so we don't need a full complex square root.
  template<typename T_IN, typename T_OUT> int cholesky_sqrt_op(T_IN a, T_OUT &b){
    Function_cholesky_sqrt_op_real:;
    const T_IN ZERO = 0;
    if(a<ZERO){
      b = ZERO;
      return(1);
    }
    b = x_sqrt(a);
    return (0);
  }
  template<typename T_IN, typename T_OUT> int cholesky_sqrt_op(std::complex<T_IN> din, std::complex<T_OUT> &dout){
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
  
  // Reciprocal square root.
  template <
      typename InputType,
      typename OutputType>
  void cholesky_rsqrt(InputType x, OutputType &res) {
    Function_cholesky_rsqrt_default:;
    res = x_rsqrt(x);
  }
  template <
      int W1, int I1, ap_q_mode Q1, ap_o_mode O1, int N1,
      int W2, int I2, ap_q_mode Q2, ap_o_mode O2, int N2>
  void cholesky_rsqrt(ap_fixed<W1, I1, Q1, O1, N1> x, ap_fixed<W2, I2, Q2, O2, N2> &res) {
    Function_cholesky_rsqrt_fixed:;
    ap_fixed<W2, I2, Q2, O2, N2> one = 1;
    ap_fixed<W1, I1, Q1, O1, N1> sqrt_res;
    ap_fixed<W2, I2, Q2, O2, N2> sqrt_res_cast;
    sqrt_res = x_sqrt(x);
    sqrt_res_cast = sqrt_res;
    res = one / sqrt_res_cast;
  }
  
  // Local multiplier to handle a complex case currently not supported by the std::complex class
  // - Complex multiplied by a real of a different type
  // - Required for complex fixed point implementations
  template <
      typename AType,
      typename BType,
      typename CType>
  void cholesky_prod_sum_mult(AType A, BType B, CType &C)
  {
    Function_cholesky_prod_sum_mult_real:;
    C = A * B;
  }
  template <
      typename AType,
      typename BType,
      typename CType>
  void cholesky_prod_sum_mult(std::complex<AType> A, BType B, std::complex<CType> &C)
  {
    Function_cholesky_prod_sum_mult_complex:;
    C.real(A.real()*B);
    C.imag(A.imag()*B);
  }
  
  // ===================================================================================================================
  // CHOLESKY_BASIC
  template <
    bool LowerTriangularL,
    int RowsColsA,
    typename CholeskyTraits,
    class InputType,
    class OutputType>
  int cholesky_basic(const InputType A[RowsColsA][RowsColsA],
                   OutputType L[RowsColsA][RowsColsA]){

    int return_code = 0;

    // Use the traits struct to specify the correct type for the intermediate variables. This is really only needed for
    // fixed point.
    typename CholeskyTraits::PROD_T     prod;
    typename CholeskyTraits::ACCUM_T    sum[RowsColsA];
    typename CholeskyTraits::ACCUM_T    A_cast_to_sum;    // A with the same dimensions as sum.
    typename CholeskyTraits::ACCUM_T    prod_cast_to_sum; // prod with the same dimensions as sum.

    typename CholeskyTraits::ADD_T      A_minus_sum;
    typename CholeskyTraits::DIAG_T     new_L_diag;       // sqrt(A_minus_sum)
    typename CholeskyTraits::OFF_DIAG_T new_L_off_diag;   // sum/L
    typename CholeskyTraits::OFF_DIAG_T L_cast_to_new_L_off_diag;

    typename CholeskyTraits::L_OUTPUT_T new_L;
    OutputType retrieved_L;
    // Internal memory used to aviod read access from function output argument L.
    // NOTE: The internal matrix only needs to be triangular but optimization using a 1-D array it will require addition 
    // logic to generate the indexes. Refer to the cholesky_alt function.
    OutputType L_internal[RowsColsA][RowsColsA];

    col_loop: for(int j = 0; j < RowsColsA; j++) {
      sum[j] = 0;

      // Calculate the diagonal value for this column
      diag_loop: for(int k = 0; k < RowsColsA; k++) {
        if(k <= (j-1)) {
          if(LowerTriangularL == true){
            retrieved_L = L_internal[j][k];
          } else {
            retrieved_L = L_internal[k][j];
          }
          sum[j] += x_conj_sq(retrieved_L);
        }
      }
      A_cast_to_sum = A[j][j];
      
      A_minus_sum = A_cast_to_sum - sum[j];

      if(cholesky_sqrt_op(A_minus_sum, new_L_diag)){
#ifndef __SYNTHESIS__
        printf("ERROR: Trying to find the square root of a negative number\n");
#endif
        return_code = 1;
      }
      
      // Round to target format using method specifed by traits defined types.
      new_L = new_L_diag;
      
      if(LowerTriangularL == true){
        L_internal[j][j] = new_L;
        L[j][j]          = new_L;
      } else         {
        L_internal[j][j] = x_conj(new_L);
        L[j][j]          = x_conj(new_L);
      }
      
      // Calculate the off diagonal values for this column
      off_diag_loop: for(int i = 0; i < RowsColsA; i++) {
        
        if(i > j) {
          if(LowerTriangularL == true){
            sum[j] = A[i][j];
          } else {
            sum[j] = x_conj(A[j][i]);
          }
          
          sum_loop: for(int k = 0; k < RowsColsA; k++) {
            #pragma HLS PIPELINE II = CholeskyTraits::INNER_II
            if(k <= (j - 1)) {
              
              if(LowerTriangularL == true){
                prod = -L_internal[i][k] * x_conj(L_internal[j][k]);
              } else {
                prod = -x_conj(L_internal[k][i]) * (L_internal[k][j]);
              }
              
              prod_cast_to_sum = prod;
              sum[j]+= prod_cast_to_sum;
            }
          }
          
          new_L_off_diag = sum[j];
          
          L_cast_to_new_L_off_diag = L_internal[j][j];
          
          // Diagonal is always real, avoid complex division
          new_L_off_diag = new_L_off_diag / x_real(L_cast_to_new_L_off_diag);
          
          // Round to target format using method specifed by traits defined types.
          new_L = new_L_off_diag;

          if(LowerTriangularL == true){
            L[i][j]          = new_L;
            L_internal[i][j] = new_L;
          } else{
            L[j][i]          = x_conj(new_L);
            L_internal[j][i] = x_conj(new_L);
          }
        } else if(i < j){
          if(LowerTriangularL == true){
            L[i][j] = 0;
          } else{
            L[j][i] = 0;
          }
        }
      }
    }
    return(return_code);
  }
  
  // ===================================================================================================================
  // CHOLESKY_ALT: Alternative architecture with improved latency at the expense of higher resource
  template <
    bool LowerTriangularL,
    int RowsColsA,
    typename CholeskyTraits,
    class InputType,
    class OutputType>
  int cholesky_alt(const InputType A[RowsColsA][RowsColsA], OutputType L[RowsColsA][RowsColsA])
  {
    int return_code = 0;
    
    // Optimize internal memories
    // - For complex data types the diagonal will be real only, plus for fixed point it must be stored to a
    //   higher precision.
    // - Requires additional logic to generate the memory indexes
    // - For smaller matrix sizes there maybe be an increase in memory usage
    OutputType L_internal[(RowsColsA*RowsColsA-RowsColsA)/2];
    typename CholeskyTraits::RECIP_DIAG_T diag_internal[RowsColsA];
    
    typename CholeskyTraits::ACCUM_T      square_sum;
    typename CholeskyTraits::ACCUM_T      A_cast_to_sum;
    typename CholeskyTraits::ADD_T        A_minus_sum;
    typename CholeskyTraits::DIAG_T       A_minus_sum_cast_diag;
    typename CholeskyTraits::DIAG_T       new_L_diag;
    typename CholeskyTraits::RECIP_DIAG_T new_L_diag_recip;
    typename CholeskyTraits::PROD_T       prod;
    typename CholeskyTraits::ACCUM_T      prod_cast_to_sum;
    typename CholeskyTraits::ACCUM_T      product_sum;
    typename CholeskyTraits::OFF_DIAG_T   prod_cast_to_off_diag;
    typename CholeskyTraits::RECIP_DIAG_T L_diag_recip;
    typename CholeskyTraits::OFF_DIAG_T   new_L_off_diag;
    typename CholeskyTraits::L_OUTPUT_T   new_L;
    typename CholeskyTraits::L_OUTPUT_T   new_L_recip;
    
    row_loop: for(int i = 0; i < RowsColsA; i++) {
      // Index generation for optimized/packed L_internal memory
      int i_sub1 = i-1;
      int i_off = ((i_sub1*i_sub1-i_sub1)/2)+i_sub1;
      
      // Off diagonal calculation
      square_sum = 0;
      col_loop: for(int j = 0; j < i; j++) {
        #pragma HLS loop_tripcount max=1+RowsColsA/2
        // Index generation
        int j_sub1 = j-1;
        int j_off = ((j_sub1*j_sub1-j_sub1)/2)+j_sub1;
        // Prime the off-diagonal sum with target elements A value.
        if(LowerTriangularL == true){
          product_sum = A[i][j];
        } else {
          product_sum = x_conj(A[j][i]);
        }
        sum_loop: for(int k = 0; k < j; k++) {
          #pragma HLS loop_tripcount max=1+RowsColsA/2
          #pragma HLS PIPELINE II = CholeskyTraits::INNER_II
          prod = -L_internal[i_off+k] * x_conj(L_internal[j_off+k]);
          prod_cast_to_sum = prod;
          product_sum+=prod_cast_to_sum;
        }
        prod_cast_to_off_diag = product_sum;
        // Fetch diagonal value
        L_diag_recip = diag_internal[j];
        // Diagonal is stored in its reciprocal form so only need to multiply the product sum
        cholesky_prod_sum_mult(prod_cast_to_off_diag,L_diag_recip,new_L_off_diag);
        // Round to target format using method specifed by traits defined types.
        new_L = new_L_off_diag;
        // Build sum for use in diagonal calculation for this row.
        square_sum += x_conj_sq(new_L);
        // Store result
        L_internal[i_off+j] = new_L;
        if(LowerTriangularL == true){
          L[i][j]          = new_L;          // store in lower triangle
          L[j][i]          = 0;              // Zero upper
        } else{
          L[j][i]          = x_conj(new_L);  // store in upper triangle
          L[i][j]          = 0;              // Zero lower
        }
      }
      
      // Diagonal calculation
      A_cast_to_sum = A[i][i];
      A_minus_sum = A_cast_to_sum - square_sum;
      if(cholesky_sqrt_op(A_minus_sum, new_L_diag)){
#ifndef __SYNTHESIS__
        printf("ERROR: Trying to find the square root of a negative number\n");
#endif
        return_code = 1;
      }
      // Round to target format using method specifed by traits defined types.
      new_L = new_L_diag; 
      // Generate the reciprocal of the diagonal for internal use to aviod the latency of a divide in every off-diagonal calculation
      A_minus_sum_cast_diag = A_minus_sum;
      cholesky_rsqrt(x_real(A_minus_sum_cast_diag),new_L_diag_recip);
      // Store diagonal value
      diag_internal[i] = new_L_diag_recip;
      if(LowerTriangularL == true){
        L[i][i]          = new_L;
      } else {
        L[i][i]          = x_conj(new_L);
      }
    }
    return(return_code);
  }
  
  // ===================================================================================================================
  // CHOLESKY_ALT2: Further improved latency architecture requiring higher resource
  template <
    bool LowerTriangularL,
    int RowsColsA,
    typename CholeskyTraits,
    class InputType,
    class OutputType>
  int cholesky_alt2(const InputType A[RowsColsA][RowsColsA], OutputType L[RowsColsA][RowsColsA])
  {
    int return_code = 0;
    
    // To avoid array index calculations every iteration this architecture uses a simple 2D array rather than a 
    // optimized/packed triangular matrix.
    OutputType L_internal[RowsColsA][RowsColsA]; 
    OutputType prod_column_top;
    typename CholeskyTraits::ACCUM_T      square_sum_array[RowsColsA];
    typename CholeskyTraits::ACCUM_T      A_cast_to_sum;
    typename CholeskyTraits::ADD_T        A_minus_sum;
    typename CholeskyTraits::DIAG_T       A_minus_sum_cast_diag;
    typename CholeskyTraits::DIAG_T       new_L_diag;
    typename CholeskyTraits::RECIP_DIAG_T new_L_diag_recip;
    typename CholeskyTraits::PROD_T       prod;
    typename CholeskyTraits::ACCUM_T      prod_cast_to_sum;
    typename CholeskyTraits::ACCUM_T      product_sum;
    typename CholeskyTraits::ACCUM_T      product_sum_array[RowsColsA];
    typename CholeskyTraits::OFF_DIAG_T   prod_cast_to_off_diag;
    typename CholeskyTraits::OFF_DIAG_T   new_L_off_diag;
    typename CholeskyTraits::L_OUTPUT_T   new_L;
    
    #pragma HLS ARRAY_PARTITION variable=A                 cyclic dim=CholeskyTraits::UNROLL_DIM factor=CholeskyTraits::UNROLL_FACTOR
    #pragma HLS ARRAY_PARTITION variable=L                 cyclic dim=CholeskyTraits::UNROLL_DIM factor=CholeskyTraits::UNROLL_FACTOR
    #pragma HLS ARRAY_PARTITION variable=L_internal        cyclic dim=CholeskyTraits::UNROLL_DIM factor=CholeskyTraits::UNROLL_FACTOR
    #pragma HLS ARRAY_PARTITION variable=square_sum_array  cyclic dim=1                          factor=CholeskyTraits::UNROLL_FACTOR
    #pragma HLS ARRAY_PARTITION variable=product_sum_array cyclic dim=1                          factor=CholeskyTraits::UNROLL_FACTOR
    
    col_loop: for(int j = 0; j < RowsColsA; j++) {
      
      // Diagonal calculation
      A_cast_to_sum = A[j][j];
      if ( j==0 ) {
        A_minus_sum = A_cast_to_sum;
      } else {
        A_minus_sum = A_cast_to_sum - square_sum_array[j];
      }
      if(cholesky_sqrt_op(A_minus_sum, new_L_diag)){
#ifndef __SYNTHESIS__
        printf("ERROR: Trying to find the square root of a negative number\n");
#endif
        return_code = 1;
      }
      // Round to target format using method specifed by traits defined types.
      new_L = new_L_diag; 
      // Generate the reciprocal of the diagonal for internal use to aviod the latency of a divide in every off-diagonal calculation
      A_minus_sum_cast_diag = A_minus_sum;
      cholesky_rsqrt(x_real(A_minus_sum_cast_diag),new_L_diag_recip);
      // Store diagonal value
      if(LowerTriangularL == true){
        L[j][j]          = new_L;
      } else {
        L[j][j]          = x_conj(new_L);
      }
      
      sum_loop:  for(int k = 0; k <= j; k++) {
        // Define average trip count for reporting, loop reduces in length for every iteration of col_loop
        #pragma HLS loop_tripcount max=1+RowsColsA/2
        // Same value used in all calcs
        // o Implement -1* here
        prod_column_top = -x_conj(L_internal[j][k]);
        
        // NOTE: Using a fixed loop length combined with a "if" to implement reducing loop length
        // o Ensures the inner loop can achieve the maximum II (1)
        // o May introduce a small overhead resolving the "if" statement but HLS struggled to schedule when the variable
        //   loop bound expression was used.
        // o Will report inaccurate trip count as it will reduce by one with the col_loop
        // o Variable loop bound code: row_loop: for(int i = j+1; i < RowsColsA; i++) {
        row_loop: for(int i = 0; i < RowsColsA; i++) {
          // IMPORTANT: row_loop must not merge with sum_loop as the merged loop becomes variable length and HLS will struggle with scheduling
          #pragma HLS LOOP_FLATTEN off
          #pragma HLS PIPELINE II = CholeskyTraits::INNER_II
          #pragma HLS UNROLL FACTOR = CholeskyTraits::UNROLL_FACTOR
          
          if ( i > j ) {
            prod = L_internal[i][k] * prod_column_top;
            prod_cast_to_sum = prod;
            
            if (k==0) {
              // Prime first sum
              if(LowerTriangularL == true){
                A_cast_to_sum = A[i][j];
              } else {
                A_cast_to_sum = x_conj(A[j][i]);
              }
              product_sum = A_cast_to_sum;
            } else {
              product_sum = product_sum_array[i];
            }
            
            if (k < j) {
              // Accumulate row sum of columns
              product_sum_array[i]= product_sum +prod_cast_to_sum;
            } else {
              // Final calculation for off diagonal value
              prod_cast_to_off_diag = product_sum;
              // Diagonal is stored in its reciprocal form so only need to multiply the product sum
              cholesky_prod_sum_mult(prod_cast_to_off_diag,new_L_diag_recip,new_L_off_diag);
              // Round to target format using method specifed by traits defined types.
              new_L = new_L_off_diag;
              // Build sum for use in diagonal calculation for this row.
              if ( k == 0 ) {
                square_sum_array[i] = x_conj_sq(new_L);
              } else {
                square_sum_array[i] += x_conj_sq(new_L);
              }
              // Store result
              L_internal[i][j] = new_L;
              // NOTE: Use the upper/lower triangle zeroing in the subsequent loop so the double memory access does not 
              // become a bottleneck
              // o Results in a further increase of DSP resources due to the higher II of this loop.
              // o Retaining the zeroing operation here can give this a loop a max II of 2 and HLS will resource share. 
              if(LowerTriangularL == true){
                L[i][j]          = new_L;          // Store in lower triangle
                if (!CholeskyTraits::ARCH2_ZERO_LOOP)
                  L[j][i]          = 0;           // Zero upper
              } else{
                L[j][i]          = x_conj(new_L);  // Store in upper triangle
                if (!CholeskyTraits::ARCH2_ZERO_LOOP)
                  L[i][j]          = 0;           // Zero lower
              }
            }
          }
        }
      }
    }
    // Zero upper/lower triangle
    // o Use separate loop to ensure main calcuation can achieve an II of 1
    // o As noted above this may increase the DSP resources.
    // o Required when unrolling the inner loop due to array dimension access
    if (CholeskyTraits::ARCH2_ZERO_LOOP) {
      zero_rows_loop: for(int i = 0; i < RowsColsA-1; i++) {
        zero_cols_loop: for(int j = i+1; j < RowsColsA; j++) {
            // Define average trip count for reporting, loop reduces in length for every iteration of zero_rows_loop
            #pragma HLS loop_tripcount max=1+RowsColsA/2
            #pragma HLS PIPELINE
            if(LowerTriangularL == true){
              L[i][j]          = 0; // Zero upper
            } else{
              L[j][i]          = 0; // Zero lower
            }
        }
      }
    }
    return(return_code);
  }
  
  // ===================================================================================================================
  // CHOLESKY_TOP: Top level function that selects implementation architecture and internal types based on the 
  // traits class provided via the CholeskyTraits template parameter.
  // o Call this function directly if you wish to override the default architecture choice or internal types
  template <
    bool LowerTriangularL,
    int RowsColsA,
    typename CholeskyTraits,
    class InputType,
    class OutputType>
  int cholesky_top(const InputType A[RowsColsA][RowsColsA],
                   OutputType L[RowsColsA][RowsColsA]){
    switch(CholeskyTraits::ARCH) {
    case 0:
      return cholesky_basic<LowerTriangularL,RowsColsA,CholeskyTraits,InputType,OutputType>(A,L);
    case 1:
      return cholesky_alt<LowerTriangularL,RowsColsA,CholeskyTraits,InputType,OutputType>(A,L);
    case 2:
      return cholesky_alt2<LowerTriangularL,RowsColsA,CholeskyTraits,InputType,OutputType>(A,L);
    default:
      return cholesky_basic<LowerTriangularL,RowsColsA,CholeskyTraits,InputType,OutputType>(A,L);
    }
  }
  // ===================================================================================================================
  // CHOLESKY: Entry point function.
  // o Template parameters:
  //  - LowerTriangularL : When false generates the result in the upper triangle
  //  - RowsColsA        : Defines the matrix dimensions
  //  - InputType        : Input data type
  //  - OutputType       : Output data type
  // o Arguments:
  //  - A                : Hermitian/symmetric positive definite input matrix
  //  - L                : Lower or upper triangular output matrix
  // o Return values:
  //  - 0                : Success
  //  - 1                : Failure. The function attempted to find the square root of a negative number i.e. the input
  //                       matrix A was not Hermitian/symmetric positive definite.
  template <
    bool LowerTriangularL,
    int RowsColsA,
    class InputType,
    class OutputType>
  int cholesky(const InputType A[RowsColsA][RowsColsA], OutputType L[RowsColsA][RowsColsA]){
    typedef cholesky_traits<LowerTriangularL,RowsColsA,InputType,OutputType> DEFAULT_CholeskyTraits;
    return cholesky_top<LowerTriangularL,RowsColsA,DEFAULT_CholeskyTraits,InputType,OutputType>(A,L);
  }

}
#endif



