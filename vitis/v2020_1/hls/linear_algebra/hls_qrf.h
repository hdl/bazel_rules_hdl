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
// QRF functions
// ------------------
// QRF                 : Entry point function
// QRF_TOP             : Top level function that selects implementation architecture and internal types based on a traits class.
// QRF_BASIC           : Basic implementation requiring lower resource
// QRF_ALT             : Optimized for throughput requiring more resources

// Change Log
// ----------
// 2015.3:
//  * Changed default architecture to QRF_ALT
//  * Added default inner loop pipelining and unrolling factors set via configuration traits class
// 
// 2015.2:
//  * CONFIG object declaration in the QRF_ALT function changed to "static" to ensure ROM inference.
// 
// 2015.1:
//  * Linear Algebra Library update
//  * Added 2nd implementation optimized for throughput selectable through the qrf_traits configuration class.
// 
// 2014.1:
//  * Initial release.

#ifndef HLS_QRF_H
#define HLS_QRF_H

#include "hls/linear_algebra/utils/x_hls_matrix_utils.h"
#include <complex>
#include "hls_stream.h"
#ifndef __SYNTHESIS__
#include <stdio.h>
#include <cstdlib>
#endif

namespace hls {
  
  // ===================================================================================================================
  // Traits struct defining architecture selection
  template<
    int RowsA,
    int ColsA,
    typename InputType,
    typename OutputType>
  struct qrf_traits {
    static const int ARCH          = 1; // Select implementation. 0=Basic. 1=Lower latency/thoughput architecture.
    static const int CALC_ROT_II   = 1; // Specify the rotation calculation loop target II of the QRF_ALT architecture(1)
    static const int UPDATE_II     = 4; // Specify the pipelining target for the Q & R update loops
    static const int UNROLL_FACTOR = 1; // Specify the unrolling factor for Q & R update loops of the QRF_ALT architecture(1)
  };
  
  // ===================================================================================================================
  // Helper functions
  template <typename T> struct is_cmplx {
    static const bool value = 0;
  };
  
  template <typename T> struct is_cmplx <std::complex<T> > {
    static const bool value = 1;
  };
  
  template <typename T> int qrf_require_extra_pass(const int rows, const int cols, T x) {
    qrf_require_extra_pass_real:;
    return 0;
  }

  template <typename T> int qrf_require_extra_pass(const int rows, const int cols, std::complex<T> x) {
    qrf_require_extra_pass_complex:;
    if (rows == cols) {
      // Unitary transformation only required for square matrices
      return 1;
    } else {
      return 0;
    }
  }

  // Vector multiply
  template <typename T> T qrf_vm(T a, T b, T c, T d) {
    return a*c + b*d;
  }

  // Matrix-vector multiply
  template <typename T> void qrf_mm(const T G[2][2], T &a, T &b) {
    T x, y;
    x = qrf_vm(G[0][0], G[0][1], a, b);
    y = qrf_vm(G[1][0], G[1][1], a, b);
    a = x;
    b = y;
  }
  
  // 
  template <typename T> void qrf_mm_or_mag(const T G[2][2], T &a, T &b, const T mag, const int use_mag, const int extra_pass) {
    T x, y;
    x = qrf_vm(G[0][0], G[0][1], a, b);
    y = qrf_vm(G[1][0], G[1][1], a, b);
    if (use_mag == 0) {
      a = x;
      b = y;
    } else {
      if (extra_pass == 1) {
        // a = a;
        b = x_real(mag);
      } else {
        a = x_real(mag);
        b = 0;
      }
    }
  }
  
  // Magnitude computation for real Givens rotation, guarding against under-/overflow
  // - Returns real-valued magnitude
  template <typename T> T qrf_magnitude(T a, T b)  {
    Function_qrf_magnitude_real:;
    const T ONE = 1.0;
    const T ZERO = 0.0;
    T abs_a, abs_b;
    T y, mag;

    abs_a = abs(a); // declared in x_hls_utils.h
    abs_b = abs(b);
    if (abs_a > abs_b) {
      y = b/a;
      mag = a*x_sqrt(ONE+y*y);

    } else if (abs_b == ZERO) {
      mag = ZERO;
    } else {
      y = a/b;
      mag = b*x_sqrt(ONE+y*y);
    }
    return mag;
  }

  // Magnitude computation for complex Givens rotation, avoiding squaring values which have just been square-rooted
  // and guarding against under-/overflow
  // - Returns real-valued magnitude
  template <typename T> T qrf_magnitude(std::complex<T> a, std::complex<T> b) {
    Function_qrf_magnitude_complex:;
    
    const T ONE = 1.0;
    const T ZERO = 0.0;
    T ar, ai, br, bi, d1, d2, d3, d3a, d3b, x1, x2, x3;
    T a_largest, b_largest, largest;
    ar = abs(a.real());
    ai = abs(a.imag());
    br = abs(b.real());
    bi = abs(b.imag());
    
    // Lower latency, builds tree structures.
    if (ar > ai && ar > br && ar > bi) {
      largest = ar;
      d1 = ai;
      d2 = br;
      d3 = bi;
    } else if (ai > ar && ai > br && ai > bi) {
      largest = ai;
      d1 = ar;
      d2 = br;
      d3 = bi;
    } else if (br > ar && br > ai && br > bi) {
      largest = br;
      d1 = ar;
      d2 = ai;
      d3 = bi;
    } else {
      largest = bi;
      d1 = ar;
      d2 = ai;
      d3 = br;
    }
    
    if (largest == ZERO) { // Avoid divide-by-zero
      return ZERO;
    } else {
      x1 = d1/largest;
      x2 = d2/largest;
      x3 = d3/largest;
      T x1_sqd = x1*x1;
      T x2_sqd = x2*x2;
      T x3_sqd = x3*x3;

      T s1 = ONE + x1_sqd;
      T s2 = x2_sqd + x3_sqd;
      T s3 = s1 + s2;

      return largest*x_sqrt(s3);
    }
  }
  
  // ===================================================================================================================
  // Real Givens rotation guarding against under-/overflow situations.
  //
  // Returns matrix G =  | c  s  |
  //                     | ss cc |
  //
  // Note: argument 'extra_pass' is not used for the real case, but is present only to permit function overloading
  //
  template <typename T> void qrf_givens(int extra_pass, T a, T b, T &c, T &s, T &ss, T &cc, T &r){
    Function_qrf_givens_real:;
    const T ONE = 1.0;
    const T ZERO = 0.0;
    T mag;

    mag = qrf_magnitude(a, b);

    if (abs(a) == ZERO && abs(b) == ZERO) { // more efficient than  "if (mag == ZERO)"
      c = x_copysign(ONE,a);
      s = ZERO;
    } else {
      c = a / mag;
      s = b / mag;
    }
    cc = c;
    ss = -s;

    r = mag;
  }

  // ===================================================================================================================
  // Complex Givens rotation
  //
  // This implements a modified Givens rotation of the form:
  //
  // G = | c*  s* |
  //     | -s  c  |
  //
  // to produce real diagonal elements suitable for subsquent computation of the inverse of input matrix A.
  //
  // Returns matrix G =  | c  s  |
  //                     | ss cc |
  //
  // This implementation does not use the same approach as the version of qrf_givens() for real data, as that
  // would require that a divider for complex data be implemented, which is expensive.
  //
  // When argument 'extra_pass' is set to 1, the function computes a unitary transformation rather than a standard Givens matrix.
  // This is required to ensure that the bottom-rightmost element of the R matrix is real.  This transformation matrix has the form:
  //
  // G(trans) = | 1     0   |
  //            | 0  e^-j*T |
  // where T = Theta for the bottom-rightmost element
  //
  template <typename T> void qrf_givens(int extra_pass, std::complex<T> a, std::complex<T> b, std::complex<T> &c, std::complex<T> &s, std::complex<T> &ss, std::complex<T> &cc, std::complex<T> &r){
    Function_qrf_givens_complex:;
    const T ONE = 1.0;
    const T ZERO = 0.0;
    const std::complex<T> CZERO = ZERO;
    T sqrt_mag_a_mag_b;
    std::complex<T> c_tmp, s_tmp;

    if (extra_pass == 0) {
      // Standard modified Givens matrix, guarding against over-/underflow

      sqrt_mag_a_mag_b = qrf_magnitude(a, b);

      if (abs(a.real()) == ZERO && abs(a.imag()) == ZERO && abs(b.real()) == ZERO && abs(b.imag()) == ZERO) { // more efficient than "if (sqrt_mag_a_mag_b == ZERO)"
        c_tmp = x_copysign(ONE,a.real());
        s_tmp = ZERO;
      } else {
        c_tmp = a / sqrt_mag_a_mag_b;
        s_tmp = b / sqrt_mag_a_mag_b;
      }
      c = x_conj(c_tmp);
      cc = c_tmp;
      s = x_conj(s_tmp);
      ss = -s_tmp;
  
      r.real(sqrt_mag_a_mag_b);


    } else {
      // Transformation matrix to ensure real diagonal in R, guarding against over-/underflow

      sqrt_mag_a_mag_b = qrf_magnitude(CZERO, b);

      c_tmp = ONE;

      if (abs(b.real()) == ZERO && abs(b.imag()) == ZERO) { // more efficient than "if (sqrt_mag_a_mag_b == ZERO)"
        s_tmp = ONE;
      } else {
        s_tmp = b / sqrt_mag_a_mag_b;
      }

      c = c_tmp;
      cc = x_conj(s_tmp);
      s = ZERO;
      ss = ZERO;

      r.real(sqrt_mag_a_mag_b);

    }

  }
  
  // ===================================================================================================================
  // Configuration class for QRF_ALT implementation
  // o Determines the ROM content for the address sequence used to zero the array elements plus the number and size of 
  //   the batches pushed through the inner loop. The batches consist of independent address accesses.
  // o Initially calculates a static constant batch estimate which is used to size the look up tables.
  // o Then an accurate batch count is generated by calculating the actually processing sequence.
  template <int ROWS, int COLS, typename InputType> struct qrf_alt_config {
    // Catch for div by 0 and ensure we infer a ROM for the lookup arrays
    static const int ROWS_INT = (ROWS < 5 ? 5 : ROWS);
    static const int COLS_INT = (COLS < 5 ? 5 : COLS);
    
    // Intermediate values used to calculate NUM_BATCHES_EST for rectangular cases
    static const int SEQ_LEN_FULL_SQ         = (ROWS_INT*(ROWS_INT-1)/2);
    static const int NUM_BATCHES_FULL_SQ_EST = SEQ_LEN_FULL_SQ * 4 / ROWS_INT;
    static const int NUM_BATCHES_RECT_EST    = NUM_BATCHES_FULL_SQ_EST - (ROWS_INT - COLS_INT) - (ROWS_INT/COLS_INT);
    
    // Triangle + square
    static const int SEQUENCE_LENGTH = (COLS_INT*(COLS_INT-1)/2)+((ROWS-COLS)*COLS)+(is_cmplx<InputType>::value && ROWS_INT == COLS_INT?1:0);
    static const int NUM_BATCHES_EST = (ROWS_INT == COLS_INT? SEQUENCE_LENGTH * 4/ COLS_INT : NUM_BATCHES_RECT_EST);
    
    // Actual number of batches calculated in the constructor
    int NUM_BATCHES; 
    // SEQUENCE & BATCH_CNTS should implement as roms.
    int BATCH_CNTS[NUM_BATCHES_EST];
    int SEQUENCE[SEQUENCE_LENGTH][3];
    
    qrf_alt_config() {
      int available[SEQUENCE_LENGTH][COLS];
      int available_cnt[COLS];
      int available_first[COLS];
      int available_last[COLS];
      int zeroed[COLS];
      int a, b, num_avail, tmp;
      int cnt = 0; // Counts how many pairs we process in a batch
      int seq_cnt = 0;
      int actual_num_batches;
      
      // Initialize first column and counters
      init_indices: for (int row=0;row<ROWS;row++) {
        available[row][0]=row;
      }
      init_counts: for (int col=0;col<COLS;col++) {
        if (col==0) {
          available_cnt[col]=ROWS;
          available_last[col]=ROWS;
        } else {
          available_cnt[col]=0;
          available_last[col]=0;
        }
        available_first[col]=0;
        zeroed[col] = 0;
      }
      // Increment through the processing sequence
      NUM_BATCHES = 0; // Set to zero so we can test if we've completed within the estimate
      px: for (int batch_num=0;batch_num < NUM_BATCHES_EST; batch_num++) {
        cnt = 0; 
        check_col_indices: for(int col = COLS-1;col>=0;col--) {
          num_avail = available_cnt[col];
          if (num_avail > 1) {
            read_indices: for(int rows = 0; rows < num_avail/2 ;rows++) {
              if ( rows < num_avail/2 ) {
                a = available[available_first[col]][col];
                available_first[col]++;
                b = available[available_first[col]][col];
                available_first[col]++;
                available_cnt[col]=available_cnt[col]-2;
                if (b < a) {
                  tmp = a;
                  a = b;
                  b = tmp;
                }
                // a & b are the row indexes we read from the memory for this rotation
                SEQUENCE[seq_cnt][0] = a;
                SEQUENCE[seq_cnt][1] = b;
                SEQUENCE[seq_cnt][2] = col;
                seq_cnt++;
                cnt++;
                available[available_last[col]][col] = a; // Non-zeroed element so store again
                available_cnt[col]++;
                available_last[col]++;
                zeroed[col]++;
                if (col < COLS-1) {
                  available[available_last[col+1]][col+1]=b; // Zeroed, row available to the next column
                  available_cnt[col+1]++;
                  available_last[col+1]++;
                }
              }
            }
          }
        }
        BATCH_CNTS[batch_num] = cnt;
        // Check for end condition
        if ( (ROWS == COLS && zeroed[COLS-2] == 1) || (ROWS > COLS && zeroed[COLS-1] == ROWS - COLS) ) {
          NUM_BATCHES = batch_num+1;
          if ( is_cmplx<InputType>::value && ROWS == COLS ) {
            // Add an extra rotation to ensure last element on the diagonal is real
            NUM_BATCHES= batch_num+2;
            BATCH_CNTS[batch_num+1] = 1;
            SEQUENCE[seq_cnt][0] = ROWS-2;
            SEQUENCE[seq_cnt][1] = ROWS-1;
            SEQUENCE[seq_cnt][2] = ROWS-1;
          }
          break;
        }
      }
      if ( NUM_BATCHES == 0 ) {
#ifndef __SYNTHESIS__
        printf("ERROR: hls_qrf.h: qrf_alt_config: ERROR: NUM_BATCHES_EST count reached without completing the processing sequence. Increase the NUM_BATCHES_EST value.\n");
        exit(1);
#endif
      }
    };
  };
  
  // ===================================================================================================================
  // QRF_BASIC
  template <
    bool TransposedQ,
    int RowsA,
    int ColsA,
    typename QRF_TRAITS,
    typename InputType,
    typename OutputType>
    void qrf_basic(const InputType  A[RowsA][ColsA],
                         OutputType Q[RowsA][RowsA],
                         OutputType R[RowsA][ColsA]) {

      // Verify that template parameters are correct in simulation
      if (RowsA < ColsA) {
#ifndef __SYNTHESIS__
        printf("ERROR: hls_qrf.h: Template parameter error - RowsA must be greater than ColsA; currently RowsA = %d ColsA = %d\n",RowsA,ColsA);
        exit(1);
#endif
      }

      // Buffers
      OutputType Qi[RowsA][RowsA];
      OutputType Ri[RowsA][ColsA];
      OutputType G[2][2];

      // Magnitude from Givens computation
      OutputType mag = 0;

      // Flags for complex-valued case
      const int DO_UNITARY_TF = qrf_require_extra_pass(RowsA, ColsA, mag);
      int extra_pass = 0;

      // Initialize Qi and initialize/load Ri
      qrf_in_row_assign : for(int r=0; r<RowsA; r++){
        qrf_in_col_assign_Qi : for(int c=0; c<RowsA; c++) {
         #pragma HLS PIPELINE
          if (r == c) {
            Qi[r][c] = 1.0;
          } else {
            Qi[r][c] = 0.0;
          }
        }
        qrf_in_col_assign_Ri : for(int c=0; c<ColsA; c++) {
          #pragma HLS PIPELINE
          Ri[r][c] = A[r][c];
        }
      }

      qrf_col_loop : for(int j=0; j<ColsA; j++) {
        // For complex data and square matrices, we perform an additional pass to ensure that the diagonal of R is real
        // For non-square matrices, the modified Givens rotation ensures that the diagonal will be real-valued
        if (DO_UNITARY_TF == 1) {
          if (j == ColsA-1) {
            extra_pass = 1;
          } else {
            extra_pass = 0;
          }
        } else {
          extra_pass = 0;
        }
        qrf_row_loop : for(int i=RowsA-1; i>0; i--) {
          if (i<=j-extra_pass) {
            continue;
          } else {
            // Compute Givens values
            qrf_givens(extra_pass, Ri[i-1][j], Ri[i][j], G[0][0], G[0][1], G[1][0], G[1][1], mag);

            if (!extra_pass) {
              Ri[i-1][j] = x_real(mag);
            } else {
              Ri[i][j] = x_real(mag);
            }
            
            qrf_r_update : for(int k=0; k<ColsA; k++) {
              #pragma HLS PIPELINE II = QRF_TRAITS::UPDATE_II
              if (k < j+1) {
                continue;
              } else {
                qrf_mm(G, Ri[i-1][k], Ri[i][k]);
              }
            }
            qrf_q_update : for(int k=0; k<RowsA; k++) {
              #pragma HLS PIPELINE II = QRF_TRAITS::UPDATE_II
              if (k < (i-(1+j)+extra_pass)) {
                continue;
              } else {
                qrf_mm(G, Qi[i-1][k], Qi[i][k]);
              }
            }
          } // end if i<=j
        } // end qrf_row_loop
      } // end qrf_col_loop
      
      // Assign final outputs
      qrf_out_row_assign : for(int r=0; r<RowsA; r++){
        qrf_out_col_assign_Q : for(int c=0; c<RowsA; c++) {
          #pragma HLS PIPELINE
          if (TransposedQ == true) {
            Q[r][c] = Qi[r][c];
          } else {
            Q[c][r] = x_conj(Qi[r][c]);
          }
        }
        qrf_out_col_assign_R : for(int c=0; c<ColsA; c++) {
          #pragma HLS PIPELINE
          if (r <= c) {
            // Values in the lower triangle are undefined
            R[r][c] = Ri[r][c];
          }
        }
      }

    } // end template qrf_basic
    
  // ===================================================================================================================
  // QRF_ALT: Optimized for throughput.
  template <
    bool TransposedQ,
    int RowsA,
    int ColsA,
    typename QRF_TRAITS,
    typename InputType,
    typename OutputType>
  void qrf_alt(const InputType  A[RowsA][ColsA],
                     OutputType Q[RowsA][RowsA],
                     OutputType R[RowsA][ColsA] ) {
  
    // Verify that template parameters are correct in simulation
    if (RowsA < ColsA) {
#ifndef __SYNTHESIS__
		printf("ERROR: hls_qrf.h: Template parameter error - RowsA must be greater than ColsA; currently RowsA = %d ColsA = %d\n",RowsA,ColsA);
		exit(1);
#endif
    }

    // Declare the ROMs defining the processing sequence
    static const qrf_alt_config<RowsA,ColsA,InputType> CONFIG;
    
    // Internal array memories
    // IMPLEMENTATION TIP: To further increase the throughput of the function partion the q_i and r_i arrays on the column
    // dimension and unroll the update_r/q loops by the same amount.
    OutputType q_i[RowsA][RowsA];
    OutputType r_i[RowsA][ColsA];
    
    #pragma HLS ARRAY_PARTITION variable=q_i cyclic dim=2 factor=QRF_TRAITS::UNROLL_FACTOR
    #pragma HLS ARRAY_PARTITION variable=r_i cyclic dim=2 factor=QRF_TRAITS::UNROLL_FACTOR
    
    hls::stream<int> to_rot[3];
    #pragma HLS STREAM variable=to_rot depth=RowsA/2
    int seq_cnt   = 0;
    int extra_pass  = 0;
    int extra_pass2 = 0;
    int use_mag     = 0;
    int px_row1, px_row2, px_col, rot_row1, rot_row2, rot_col;
    OutputType G[2][2];
    OutputType mag = 0;
    hls::stream<OutputType> rotations[5];
    #pragma HLS STREAM variable=rotations depth=RowsA/2
    OutputType G_delay[2][2];
    OutputType mag_delay;
    
    // Copy input data to local R memory and initialize Q
    row_copy : for(int r=0; r<RowsA; r++){
      // Merge loops to parallelize the A input read and the Q matrix prime.
      #pragma HLS LOOP_MERGE force
      col_copy_q_i : for(int c=0; c<RowsA; c++) {
        #pragma HLS PIPELINE
        if (r == c) {
          q_i[r][c] = 1.0;
        } else {
          q_i[r][c] = 0.0;
        }
      }
      col_copy_r_i : for(int c=0; c<ColsA; c++) {
        #pragma HLS PIPELINE
        r_i[r][c] = A[r][c];
      }
    }
      
    // Process R in batches of non-dependent array elements
    px: for (int batch_num = 0; batch_num < CONFIG.NUM_BATCHES; batch_num++) {
      
      calc_rotations: for(int px_cnt = 0; px_cnt < CONFIG.BATCH_CNTS[batch_num]; px_cnt++) {
        #pragma HLS LOOP_TRIPCOUNT min=1 max=RowsA/2
        #pragma HLS PIPELINE II=QRF_TRAITS::CALC_ROT_II
        px_row1 = CONFIG.SEQUENCE[seq_cnt][0];
        px_row2 = CONFIG.SEQUENCE[seq_cnt][1];
        px_col  = CONFIG.SEQUENCE[seq_cnt][2];
        seq_cnt++;
        extra_pass = 0;
        if ( is_cmplx<InputType>::value && RowsA == ColsA && batch_num == CONFIG.NUM_BATCHES-1) {
          extra_pass = 1;
        }
        qrf_givens(extra_pass, r_i[px_row1][px_col], r_i[px_row2][px_col], G[0][0], G[0][1], G[1][0], G[1][1], mag);
        // Pass on rotation to next block to apply rotations
        rotations[0].write(G[0][0]);
        rotations[1].write(G[0][1]);
        rotations[2].write(G[1][0]);
        rotations[3].write(G[1][1]);
        rotations[4].write(mag);
        to_rot[0].write(px_row1);
        to_rot[1].write(px_row2);
        to_rot[2].write(px_col);
      }
      
      rotate: for(int px_cnt = 0; px_cnt < CONFIG.BATCH_CNTS[batch_num]; px_cnt++) {
        #pragma HLS LOOP_TRIPCOUNT min=1 max=RowsA/2
        G_delay[0][0] = rotations[0].read();
        G_delay[0][1] = rotations[1].read();
        G_delay[1][0] = rotations[2].read();
        G_delay[1][1] = rotations[3].read();
        mag_delay     = rotations[4].read();
        rot_row1      = to_rot[0].read();
        rot_row2      = to_rot[1].read();
        rot_col       = to_rot[2].read();
        
        extra_pass2 = 0;
        if ( is_cmplx<InputType>::value && RowsA == ColsA && batch_num == CONFIG.NUM_BATCHES-1) {
          extra_pass2 = 1;
        }
        
        // Merge the loops to maximize throughput, otherwise HLS will execute them sequentially and
        // share hardware.
        #pragma HLS LOOP_MERGE force
        update_r : for(int k=0; k<ColsA; k++) {
          #pragma HLS PIPELINE II=QRF_TRAITS::UPDATE_II
          #pragma HLS UNROLL FACTOR=QRF_TRAITS::UNROLL_FACTOR
          use_mag = 0;
          if (k==rot_col) {
            use_mag = 1;
          }
          qrf_mm_or_mag(G_delay, r_i[rot_row1][k], r_i[rot_row2][k], mag_delay, use_mag, extra_pass2);
        }
        update_q : for(int k=0; k<RowsA; k++) {
          #pragma HLS PIPELINE II=QRF_TRAITS::UPDATE_II
          #pragma HLS UNROLL FACTOR=QRF_TRAITS::UNROLL_FACTOR
          qrf_mm(G_delay, q_i[rot_row1][k], q_i[rot_row2][k]);
        }
      }
    }
    
    // Assign final outputs
    row_assign_loop : for (int r=0;r<RowsA;r++) {
      // Merge loops to parallelize the Q and R writes
      #pragma HLS LOOP_MERGE force
      col_r_assign_loop : for (int c=0;c<ColsA;c++) {
        #pragma HLS PIPELINE
        R[r][c] = r_i[r][c];
      }
      col_q_assign_loop : for (int c=0;c<RowsA;c++) {
        #pragma HLS PIPELINE
        if (TransposedQ == true) {
          Q[r][c] = q_i[r][c];
        } else {
          Q[c][r] = x_conj(q_i[r][c]);
        }
      }
    }
    
  } // end qrf_alt
  
  // ===================================================================================================================
  // QRF_TOP: Top level function that selects implementation architecture 
  // o Call this function directly if you wish to override the default architecture choice
  template <
    bool TransposedQ,
    int RowsA,
    int ColsA,
    typename QRF_TRAITS,
    typename InputType,
    typename OutputType>
  void qrf_top(const InputType  A[RowsA][ColsA],
                     OutputType Q[RowsA][RowsA],
                     OutputType R[RowsA][ColsA]) {
    switch(QRF_TRAITS::ARCH) {
    case 0:
      qrf_basic<TransposedQ, RowsA, ColsA, QRF_TRAITS, InputType, OutputType>(A,Q,R);
      break;
    case 1:
      qrf_alt<TransposedQ, RowsA, ColsA, QRF_TRAITS, InputType, OutputType>(A,Q,R);
      break;
    default:
      qrf_basic<TransposedQ, RowsA, ColsA, QRF_TRAITS, InputType, OutputType>(A,Q,R);
      break;
    }
  }
  
  // ===================================================================================================================
  // QRF: Entry point function.
  // o Template parameters:
  //  - TransposedQ      : Selects whether Q is output in transposed form
  //  - RowsA            : Number of rows in input matrix A
  //  - ColsA            : Number of columns in input matrix A
  //  - InputType        : Input data type
  //  - OutputType       : Output data type
  // o Arguments:
  //  - A                : Input matrix
  //  - Q                : Orthogonal output matrix
  //  - R                : Upper triangular output matrix
  template <
    bool TransposedQ,
    int RowsA,
    int ColsA,
    typename InputType,
    typename OutputType>
    void qrf(const InputType A[RowsA][ColsA],
                   OutputType Q[RowsA][RowsA],
                   OutputType R[RowsA][ColsA]) {
      typedef qrf_traits<RowsA,ColsA,InputType,OutputType> DEFAULT_QRF_TRAITS;
      qrf_top<TransposedQ, RowsA, ColsA, DEFAULT_QRF_TRAITS, InputType, OutputType>(A,Q,R);
    }
} // end namespace hls

#endif


