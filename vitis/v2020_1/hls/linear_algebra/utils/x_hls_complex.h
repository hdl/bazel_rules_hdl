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

#ifndef X_HLS_COMPLEX_H
#define X_HLS_COMPLEX_H

#include "ap_fixed.h"
#include "utils/x_hls_defines.h"
#include "utils/std_complex_utils.h"
#include "utils/x_hls_traits.h"
#ifndef __SYNTHESIS__
#include <iostream>
#endif

#pragma message("hls::x_complex library will be replaced in 2019.2 with a new implementation that does not provide automatic bit width expansion. Please avoid relying on this feature.")
namespace hls {

/*
*******************************************************************************
* Vivado HLS complex data type
* ----------------------------
*
* x_complex
* x_traits for x_complex
* set_to_one
*
*******************************************************************************
*/


/*
*******************************************************************************
* Complex class
*
* This is used over std::<complex> for the following reasons.
* 1. <complex> auto initializes all variables which forces an auto-initialization
*    loop to be inserted for every declaration of an array of complex data
* 2. Using std::<complex> as base class leads to compilation errors.
*******************************************************************************
*/

  template<typename T> class x_complex {

  private:
    T re, im;

  public:
    // Multiply return type
    // o Only supports lhs and rhs of the same type
    typedef x_complex< typename x_traits<T,T>::MADD_T > MULT_RT;
    
    // Constructors
    x_complex()                     {};
    x_complex(const T& r, const T& i) { re = r; im = i; };
    x_complex(const T& r)            { re = r; im = 0; };

    // Data access
    inline T real() const        { return(re); };
    inline T& real()             { return(re); };
    inline void real(const T& r) { re = r; };
    inline T imag() const        { return(im); };
    inline T& imag()             { return(im); };
    inline void imag(const T& i) { im = i; };

    // Operator =
    inline x_complex<T>& operator= (const T& rhs) {
      re = rhs; im = 0; return *this; };
    template<typename T2>
    inline x_complex<T>& operator= (const x_complex<T2>& rhs) {
      re = rhs.real(); im = rhs.imag(); return *this; };

    // Operator *=, *
    template<typename T2>
    inline x_complex<T>& operator*= (const T2& rhs) {
      re *= rhs; im *= rhs; return *this; };
    template<typename T2>
    inline x_complex<T>& operator*= (const x_complex<T2>& rhs) {
      T tmp1 = re*rhs.real();
      T tmp2 = im*rhs.imag();
      T tmp3 = re*rhs.imag();
      T tmp4 = im*rhs.real();
      re = tmp1 - tmp2;
      im = tmp3 + tmp4;
      return *this; };
    inline MULT_RT operator* (const x_complex<T>& rhs) {
      x_complex_mult_complex:;
      typename x_traits<T,T>::MULT_T m1, m2, m3, m4;
      typename x_traits<T,T>::MADD_T sum_re, sum_im;
      MULT_RT res;
      m1 = re*rhs.real();
      m2 = im*rhs.imag();
      m3 = re*rhs.imag();
      m4 = im*rhs.real();
      sum_re = m1 - m2;
      sum_im = m3 + m4;
      res.real(sum_re);
      res.imag(sum_im);
      return res;
    };
    inline MULT_RT operator* (const T& rhs) {
      x_complex_mult_real:;
      typename x_traits<T,T>::MULT_T m1, m2;
      typename x_traits<T,T>::MADD_T sum_re, sum_im;
      MULT_RT res;
      m1 = re*rhs;
      m2 = im*rhs;
      sum_re = m1;
      sum_im = m2;
      res.real(sum_re);
      res.imag(sum_im);
      return res;
    };
    
    // Operator /=, /
    inline x_complex<T>& operator/= (const T& rhs) {;
      re /= rhs; im /= rhs; return *this; };
    inline x_complex<T> operator/ (const T& rhs) {
      x_complex<T> tmp(*this); tmp /= rhs; return tmp; };
    inline x_complex<T>& operator/= (const x_complex<T>& rhs) {
      // Complex division:
      //   Get conjugate of rhs
      //   a =  *this x conjugate
      //   b =   rhs  x conjugate
      //   re = a.re / b.re
      //   im = a.im / b.re
      x_complex<T> conj = x_conj(rhs);
      x_complex<T> a    = (*this)*conj;
      x_complex<T> b    = conj*rhs;
      re = a.real() / b.real();
      im = a.imag() / b.real();
      return *this;
    };
    inline x_complex<T> operator/ (const x_complex<T>& rhs) {
      x_complex<T> tmp(*this);
      tmp /= rhs;
      return tmp;
    };

    // Operator +=, +
    inline x_complex<T>& operator+= (const T& rhs) {
      re += rhs; return *this; };
    inline x_complex<T> operator+= (const x_complex<T>& rhs) {
      re += rhs.real(); im += rhs.imag(); return *this; };
    template<typename T2>
    inline x_complex<T> operator+= (const x_complex<T2>& rhs) {
      re += rhs.real(); im += rhs.imag(); return *this; };
    inline typename x_traits<x_complex<T>,x_complex<T> >::ADD_T operator+ (const T& rhs) {
      typename x_traits<x_complex<T>,x_complex<T> >::ADD_T tmp ;
      tmp = *this; 
      tmp += rhs; 
      return tmp; 
    };
    inline typename x_traits<x_complex<T>,x_complex<T> >::ADD_T operator+ (const x_complex<T>& rhs) {
       typename x_traits<x_complex<T>,x_complex<T> >::ADD_T tmp ;
       tmp = *this; 
       tmp += rhs; 
       return tmp; 
    };


    // Operator -=, -
    inline x_complex<T>& operator-= (const T& rhs) {
      re -= rhs; return *this; }
    inline x_complex<T>& operator-= (const x_complex<T>& rhs) {
      re -= rhs.real(); im -= rhs.imag(); return *this; };
    template<typename T2>
    inline x_complex<T>& operator-= (const x_complex<T2>& rhs) {
      re -= rhs.real(); im -= rhs.imag(); return *this; };
    inline typename x_traits<x_complex<T>,x_complex<T> >::ADD_T operator- (const T& rhs) {
      typename x_traits<x_complex<T>,x_complex<T> >::ADD_T tmp ;
      tmp = *this; 
      tmp -= rhs; 
      return tmp; 
    };
    inline typename x_traits<x_complex<T>,x_complex<T> >::ADD_T operator- (const x_complex<T>& rhs) {
      typename x_traits<x_complex<T>,x_complex<T> >::ADD_T tmp ;
      tmp = *this; 
      tmp -= rhs; 
      return tmp; 
    };
    inline x_complex<T> operator- () {
      x_complex<T> tmp(*this);
      tmp.real(-real());
      tmp.imag(-imag());
      return tmp;
    };

#ifndef __SYNTHESIS__
    // Operator <<
    friend std::ostream &operator<<(std::ostream &out, const x_complex<T> &c) {
      bool neg_imag = c.imag() <= -0 ? true : false;
      T imag        = neg_imag ? (T)-c.imag() : (T)c.imag();

      out << c.real() << (neg_imag ? " - j*":" + j*") << imag;
      return out;
    }
#endif

  }; // x_complex
 
  // Non-member Operator ==, != for x_complex
  template<typename T>
  inline bool operator== (const T& lhs, const x_complex<T>& rhs) {
    return (lhs == rhs.real()) && (0 == rhs.imag());
  }
  template<typename T>
  inline bool operator== (const x_complex<T>& lhs, const T& rhs) {
    return (lhs.real() == rhs) && (lhs.imag() == 0);
  }
  template<typename T>
  inline bool operator== (const x_complex<T>& lhs, const x_complex<T>& rhs) {
    return (lhs.real() == rhs.real()) && (lhs.imag() == rhs.imag());
  }

  template<typename T>
  inline bool operator!= (const T& lhs, const x_complex<T>& rhs) {
    return (lhs != rhs.real()) || (0 != rhs.imag());
  }
  template<typename T>
  inline bool operator!= (const x_complex<T>& lhs, const T& rhs) {
    return (lhs.real() != rhs) || (lhs.imag() != 0);
  }
  template<typename T>
  inline bool operator!= (const x_complex<T>& lhs, const x_complex<T>& rhs) {
    return (lhs.real() != rhs.real()) || (lhs.imag() != rhs.imag());
  }

  template<typename T1> typename x_complex<T1>::MULT_RT operator* (const T1& lhs, x_complex<T1>& rhs) {
    return (rhs*lhs); // Flip direction and re-use complex class defined operator
  }
  
  template<typename T1, typename T2>
    struct x_traits<x_complex<T1>,x_complex<T2> > {
      typedef x_complex<T1>                  ADD_T;
      typedef x_complex<T1>                  SAT_T;
      typedef x_complex<T1>                  MULT_T;
      typedef x_complex<T1>                  MADD_T;
      typedef x_complex<int>                 INT_T;
      typedef x_complex<float_struct<24,8> > FLOAT_STRUCT_T;
    };

#define X_COMPLEX_MAX(a, b) ((a) > (b) ? (a) : (b))

  template<int W1, int I1, int W2, int I2>
    struct x_traits<x_complex<ap_fixed<W1,I1> >,x_complex<ap_fixed<W2,I2> > > {
      typedef x_complex<ap_fixed<X_COMPLEX_MAX(I1,I2)+1+X_COMPLEX_MAX(W1-I1,W2-I2),X_COMPLEX_MAX(I1,I2)+1> >  ADD_T;
      typedef x_complex<ap_fixed<W1,I1,AP_RND,AP_SAT> >   SAT_T;
      typedef x_complex<ap_fixed<W1+W2+1,I1+I2+1> >       MULT_T;
      typedef x_complex<ap_fixed<W1+W2+2,I1+I2+2> >       MADD_T;
      typedef x_complex<ap_fixed<(2*W1)+1,(2*I1)+1> >     CONJ_SQ_T;
      typedef x_complex<int>                              INT_T;
      typedef x_complex<float_struct<24,8> >              FLOAT_STRUCT_T;
    };

  template<int W1, int W2>
    struct x_traits<x_complex<ap_int<W1> >,x_complex<ap_int<W2> > > {
      typedef x_complex<ap_int<X_COMPLEX_MAX(W1,W2)+1> >  ADD_T;
      typedef x_complex<ap_int<W1> >                      SAT_T;
      typedef x_complex<ap_int<W1+W2+1> >                 MULT_T;
      typedef x_complex<ap_int<W1+W2+2> >                 MADD_T;
      typedef x_complex<ap_int<(2*W1)+1> >                CONJ_SQ_T;
      typedef x_complex<int>                              INT_T;
      typedef x_complex<float_struct<24,8> >              FLOAT_STRUCT_T;
    };

#undef X_COMPLEX_MAX

  template<int DIM, typename T>
    struct x_traits_d <x_complex<T>,DIM> {
      typedef x_complex<T>               ACCUM_T;
      typedef x_complex<T>               ACCUM2_T;
      typedef x_complex<ap_int<25+DIM> > ADD_TREE_T;
    };

  template<int DIM, int W, int I>
    struct x_traits_d <x_complex<ap_fixed<W,I> >,DIM> {
      typedef x_complex<ap_fixed<W+BitWidth<DIM>::Value,I+BitWidth<DIM>::Value> >         ACCUM_T;
      typedef x_complex<ap_fixed<(2*W)+BitWidth<DIM>::Value,(2*I)+BitWidth<DIM>::Value> > ACCUM2_T;
    };



  template<typename T> x_complex<T> x_neg(x_complex<T> &din) {
    x_complex<T> tmp;
    tmp.real(-din.real());
    tmp.imag(-din.imag());
    return(tmp);
  }


  template<typename T> typename x_traits<T,T>::MADD_T x_conj_sq(x_complex<T> &din) {
  x_conj_sq_complex:;
    return ( (din.real()*din.real()) + (din.imag()*din.imag()));
  }


  template<typename T> x_complex<T> x_conj(const x_complex<T> &din) {
    x_conj_complex:;
    x_complex<T> tmp;
    tmp.real(din.real());
    tmp.imag(-din.imag());
    return(tmp);
  }

  // This function is called when a non-const x_complex is conjugated.  It calls the
  // version of x_conj() which takes a constant parameter
  template<typename T> x_complex<T> x_conj(x_complex<T> &din) {
    const x_complex<T> tmp = din;
    return(x_conj(tmp));
  }

  template<int W, int I> void set_to_one(x_complex<ap_fixed<W,I> > &a) {
    ap_int<W> tmp_sat = ((ap_int<W-I+1>)1<<(W-I)) - 1;
    ap_fixed<W,I> tmp;
    tmp.range() = tmp_sat;
    a = tmp;
  }

  template<typename T> T x_real(const x_complex<T> &din) {
    return(din.real());
  }
  template<typename T> T x_imag(const x_complex<T> &din) {
    return(din.imag());
  }

} // end namespace hls

#endif



