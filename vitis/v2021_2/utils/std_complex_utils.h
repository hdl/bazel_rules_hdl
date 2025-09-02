// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
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

#ifndef STD_HLS_COMPLEX_UTILS_H
#define STD_HLS_COMPLEX_UTILS_H

#include <complex>
#include "ap_fixed.h"
#include "x_hls_defines.h"
#include "x_hls_traits.h"
#ifndef __SYNTHESIS__
#include <iostream>
#endif

namespace hls {
/*
*******************************************************************************
* Vivado HLS complex data type
* ----------------------------
*
* std::complex
* x_traits for std::complex
* set_to_one
*
*******************************************************************************
*/
 

  template<typename T>
    struct x_traits<std::complex<T>,std::complex<T> > {
      typedef std::complex<T>                  ADD_T;
      typedef std::complex<T>                  SAT_T;
      typedef std::complex<T>                  MULT_T;
      typedef std::complex<T>                  MADD_T;
      typedef std::complex<int>                 INT_T;
      typedef std::complex<float_struct<24,8> > FLOAT_STRUCT_T;
    };
  
  template<int DIM, typename T>
    struct x_traits_d <std::complex<T>,DIM> {
      typedef std::complex<T>               ACCUM_T;
      typedef std::complex<T>               ACCUM2_T;
      typedef std::complex<ap_int<25+DIM> > ADD_TREE_T;
    };
  
  template<typename T> T x_neg(T &din) {
    return -din;
  }

  static float x_neg(float din) {
      float dout = 0;
      if(din > 0)
         dout = -din;
      else
         dout = din;
      return dout;
  }

  static double x_neg(double din) {
      double dout = 0;
      if(din > 0)
         dout = -din;
      else
         dout = din;
      return dout;
  }

  template<typename T> std::complex<T> x_neg(std::complex<T> &din) {
    std::complex<T> tmp;
    tmp.real(-din.real());
    tmp.imag(-din.imag());
    return(tmp);
  }


  template<typename T> typename x_traits<T,T>::MULT_T x_conj_sq(T &din) {
  x_conj_sq:;
    return (din * din);
  }

  template<typename T> typename x_traits<T,T>::MADD_T x_conj_sq(std::complex<T> &din) {
  x_conj_sq_complex:;
    return ( (din.real()*din.real()) + (din.imag()*din.imag()));
  }

  template<typename T> T x_conj(T &din) {
    x_conj_real:;
    return din;
  }

  template<typename T> std::complex<T> x_conj(const std::complex<T> &din) {
    x_conj_complex:;
    std::complex<T> tmp;
    tmp.real(din.real());
    tmp.imag(-din.imag());
    return(tmp);
  }

  // This function is called when a non-const std::complex is conjugated.  It calls the
  // version of x_conj() which takes a constant parameter
  template<typename T> std::complex<T> x_conj(std::complex<T> &din) {
    const std::complex<T> tmp = din;
    return(x_conj(tmp));
  }

  template<int W, int I> void set_to_one(std::complex<ap_fixed<W,I> > &a) {
    ap_int<W> tmp_sat = ((ap_int<W-I+1>)1<<(W-I)) - 1;
    ap_fixed<W,I> tmp;
    tmp.range() = tmp_sat;
    a = tmp;
  }

  // Functions to extract real and imaginary components
  template<typename T> T x_real(const T &din) {
    return din;
  }
  template<typename T> T x_real(const std::complex<T> &din) {
    return(din.real());
  }
  template<typename T> T x_imag(const T &din) {
    _AP_UNUSED_PARAM(din);
    T tmp = 0;
    return tmp;
  }
  template<typename T> T x_imag(const std::complex<T> &din) {
    return(din.imag());
  }

} // end namespace hls

#endif




