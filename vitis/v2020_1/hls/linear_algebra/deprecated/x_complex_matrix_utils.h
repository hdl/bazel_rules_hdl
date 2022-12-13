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
 *     (c) Copyright 2008-2014 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/

#ifndef X_COMPLEX_MATRIX_UTILS_H
#define X_COMPLEX_MATRIX_UTILS_H

#include "ap_fixed.h"
#include "hls/linear_algebra/utils/x_hls_complex.h"
#include "hls/linear_algebra/utils/x_hls_matrix_utils.h"
#include "hls_math.h"

#ifndef __SYNTHESIS__
#include <iostream>
#include <iomanip>
#include <string>
#include <sstream>
#include <stdio.h>
#endif

namespace hls {

#ifndef __SYNTHESIS__

  // Complex data
  // ----------------
  // This is used by complex data of any type.  A printer is called to print the real and imaginary
  // parts, so this just handles the formating of x+jy
  template <typename T> struct xil_printer<hls::x_complex <T> > {
    static std::string to_s(hls::x_complex<T> x, unsigned prec=10){

      // Use the basic type printer to print the real and imaginary parts
      typedef xil_printer<T> printer;

      std::stringstream ss;
      // Remember to deal with -0
      bool neg_imag = x.imag() <= -0 ? true : false;

      // Casting to "T" avoids "error: operands to ?: have different types." when using ap_fixed.
      T imag        = neg_imag ? (T)-x.imag() : (T)x.imag();

      ss << printer::to_s(x.real(), prec) << (neg_imag ? " - j*":" + j*") << printer::to_s(imag, prec);
      return ss.str();
    }
  };

#endif

} // end namespace hls

#endif


