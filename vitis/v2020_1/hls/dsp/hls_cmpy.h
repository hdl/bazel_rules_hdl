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
 *     (c) Copyright 2014 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/

#ifndef HLS_CMPY_H
#define HLS_CMPY_H

#include "ap_fixed.h"
#include <complex>

namespace hls {

  // ===================================================================================================================
  // Complex multiplier architecture type definition
  struct CmpyThreeMult {
    const static int CmpyArchitecture = 3;
  };
  struct CmpyFourMult {
    const static int CmpyArchitecture = 4;
  };

  // ===================================================================================================================
  // CMPY: Entry point function with discrete real/imaginary components
  // Template parameters:
  //  - Architecture    : Selects either 3-multiplier or 4-multiplier architecture to implement
  //  - W1/I1/Q1/O1/N1  : Defines fixed-point properties of ar, ai, br and bi
  //  - W2/I2/Q2/O2/N2  : Defines fixed-point properties of pr and pi
  // Arguments:
  //  - ar              : Multiplicand real component
  //  - ai              : Multiplicand imaginary component
  //  - br              : Multiplier real component
  //  - bi              : Multiplier imaginary component
  //  - pr              : Product real component
  //  - pi              : Product imaginary component
  template <
    class Architecture,
    int W1, int I1, ap_q_mode Q1, ap_o_mode O1, int N1,
    int W2, int I2, ap_q_mode Q2, ap_o_mode O2, int N2>
    void cmpy (const ap_fixed<W1, I1, Q1, O1, N1> &ar,
               const ap_fixed<W1, I1, Q1, O1, N1> &ai,
               const ap_fixed<W1, I1, Q1, O1, N1> &br,
               const ap_fixed<W1, I1, Q1, O1, N1> &bi,
               ap_fixed<W2, I2, Q2, O2, N2> &pr,
               ap_fixed<W2, I2, Q2, O2, N2> &pi) {

    Function_cmpy_scalar:;

    if (Architecture::CmpyArchitecture == 4) {

      // 4-mult architecture
      ap_fixed<W1, I1, Q1, O1, N1> in[2][2];
      ap_fixed<W1+W1, I1+I1, Q1, O1, N1> m[2][2]; // multiplier bitgrowth

      in[0][0] = ar;
      in[0][1] = br;
      in[1][0] = ai;
      in[1][1] = bi;

      // TIP: Insert a PIPELINE directive here to implement with 4 DSP Slices (full throughput)
      cmpy_4mult_outer_loop : for (int i=0; i<2; i++) {
        // TIP: Insert a PIPELINE directive here to implement with 2 DSP Slices
        cmpy_4mult_inner_loop : for (int j=0; j<2; j++) {
          // TIP: With no directives, only 1 DSP Slice is used
          m[i][j] = in[i][0] * in[j][1];
        }
      }

      pr = m[0][0] - m[1][1];
      pi = m[1][0] + m[0][1];

    } else if (Architecture::CmpyArchitecture == 3) {

      // 3-mult architecture
      ap_fixed<W1+1, I1+1, Q1, O1, N1> sum0, sum1, sum2; // 1 bit of integer bitgrowth
      ap_fixed<W1+W1+1, I1+I1+1, Q1, O1, N1> prod0, prod1, prod2; // carry 1 bit of integer bitgrowth, plus multiplier bitgrowth

      sum0 = (ar + ai);
      sum1 = (br + bi);
      sum2 = (ai - ar);

      prod0 = sum0 * bi;
      prod1 = sum1 * ar;
      prod2 = sum2 * br;

      pr = prod1 - prod0;
      pi = prod1 + prod2;

    } else {
#ifndef __SYNTHESIS__
      std::cout << "ERROR: " << __FILE__ << ": Unsupported architecture" << std::endl;
#endif
    }

  }

  // ===================================================================================================================
  // CMPY: Alternative entry point function using std::complex interface
  // Template parameters:
  //  - Architecture    : Selects either 3-multiplier or 4-multiplier architecture to implement
  //  - W1/I1/Q1/O1/N1  : Defines fixed-point properties of a and b
  //  - W2/I2/Q2/O2/N2  : Defines fixed-point properties of p
  // Arguments:
  //  - a              : Multiplicand
  //  - b              : Multiplier
  //  - p              : Product
  template <
    class Architecture,
    int W1, int I1, ap_q_mode Q1, ap_o_mode O1, int N1,
    int W2, int I2, ap_q_mode Q2, ap_o_mode O2, int N2>
    void cmpy (const std::complex< ap_fixed<W1, I1, Q1, O1, N1> > &a,
               const std::complex< ap_fixed<W1, I1, Q1, O1, N1> > &b,
               std::complex< ap_fixed<W2, I2, Q2, O2, N2> > &p) {

    Function_cmpy_std_complex:;

    //    cmpy<Architecture>(&(*a).real(),&(*a).imag(),&(*b).real(),&(*b).imag(),&(*p).real(),&(*p).imag());
    //cmpy<Architecture>(a.real(),a.imag(),b.real(),b.imag(),p.real(),p.imag());
    #if (defined(__cplusplus) && __cplusplus >= 201103L)
         cmpy<Architecture>(a.real(),a.imag(),b.real(),b.imag(),reinterpret_cast<ap_fixed<W2, I2, Q2, O2, N2> *>(&p)[0],reinterpret_cast<ap_fixed<W2, I2, Q2, O2, N2> *>(&p)[1]);
    #else
         cmpy<Architecture>(a.real(),a.imag(),b.real(),b.imag(),p.real(),p.imag());
    #endif

  }

} //end namespace hls

#endif // HLS_CMPY_H


