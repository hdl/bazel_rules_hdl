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

#ifndef HLS_X_COMPLE_H
#define HLS_X_COMPLE_H

#ifndef __SYNTHESIS__
#include <iostream>
#endif

#include "ap_fixed.h"

namespace std {
template<typename _Tp> class complex;
}

namespace hls {

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
    typedef x_complex<T> MULT_RT; 
    // Constructors
    x_complex()                     {};
    x_complex(const T& r, const T& i) { re = r; im = i; };
    x_complex(const T& r)            { re = r; im = 0; };
    x_complex(const std::complex<T> &z) : re(z.real()),im(z.imag()) {}
    template<typename T2>
    x_complex(const x_complex<T2> &z) : re(z.real()),im(z.imag()) {};

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
    inline x_complex<T>& operator= (const x_complex<T>& rhs) {
      re = rhs.real(); im = rhs.imag(); return *this; };
    template<typename T2>
    inline x_complex<T>& operator= (const x_complex<T2>& rhs) {
      re = rhs.real(); im = rhs.imag(); return *this; };

    // Operator *=, *
    inline x_complex<T>& operator*= (const T& rhs) {
      re *= rhs; 
      im *= rhs; 
      return *this;
    };
    inline x_complex<T>& operator*= (const x_complex<T>& rhs) {
      T tmp1 = re*rhs.real();
      T tmp2 = im*rhs.imag();
      T tmp3 = re*rhs.imag();
      T tmp4 = im*rhs.real();
      re = tmp1 - tmp2;
      im = tmp3 + tmp4;
      return *this;
    };
    template<typename T2>
    inline x_complex<T>& operator*= (const x_complex<T2>& rhs) {
      x_complex<T> tmp(rhs.real(), rhs.imag());
      *this *= tmp; 
      return *this;
    };

    inline MULT_RT operator* (const T& rhs) {
      x_complex_mult_real:;
      x_complex<T> tmp(*this);
      tmp *= rhs;
      return tmp;
    };
    inline MULT_RT operator* (const x_complex<T>& rhs) {
      x_complex_mult_complex:;
      x_complex<T> tmp(*this);
      tmp *= rhs;
      return tmp;
    }
    template<typename T2>
    inline MULT_RT operator* (const x_complex<T2>& rhs) {
      x_complex_mult_complex:;
      x_complex<T> tmp(rhs.real(), rhs.imag());
      MULT_RT res = *this * tmp; 
      return res;
    };
    
    // Operator /=, /
    inline x_complex<T>& operator/= (const T& rhs) {;
      re /= rhs;
      im /= rhs;
      return *this; 
    };
    inline x_complex<T>& operator/= (const x_complex<T>& rhs) {
      x_complex<T> conj ( rhs.real(), -rhs.imag());
      x_complex<T> a    = (*this)*conj;
      x_complex<T> b    = conj*rhs;
      re = a.real() / b.real();
      im = a.imag() / b.real();
      return *this;
    };
    template<typename T2>
    inline x_complex<T>& operator/= (const x_complex<T2>& rhs) {
      x_complex<T> tmp(rhs.real(), rhs.imag());
      *this /= tmp;
      return *this;
    };

    inline x_complex<T> operator/ (const T& rhs) {
      x_complex<T> tmp(*this); 
      tmp /= rhs; return tmp; 
    };
    inline x_complex<T> operator/ (const x_complex<T>& rhs) {
      x_complex<T> tmp(*this);
      tmp /= rhs;
      return tmp;
    };
    template<typename T2>
    inline x_complex<T> operator/ (const x_complex<T2>& rhs) {
      x_complex<T> tmp(*this);
      tmp /= rhs;
      return tmp;
    };

    // Operator +=, +
    inline x_complex<T>& operator+= (const T& rhs) {
      re += rhs; 
      return *this; 
    };
    inline x_complex<T> operator+= (const x_complex<T>& rhs) {
      re += rhs.real(); 
      im += rhs.imag();
      return *this;
    };
    template<typename T2>
    inline x_complex<T> operator+= (const x_complex<T2>& rhs) {
      re += rhs.real();
      im += rhs.imag();
      return *this; };
  
    inline x_complex<T> operator+ (const T& rhs) {
      x_complex<T> tmp ;
      tmp = *this; 
      tmp += rhs; 
      return tmp; 
    };
    inline x_complex<T> operator+ (const x_complex<T>& rhs) {
       x_complex<T>  tmp ;
       tmp = *this; 
       tmp += rhs; 
       return tmp; 
    };
    template<typename T2>
    inline x_complex<T> operator+ (const x_complex<T2>& rhs) {
       x_complex<T>  tmp ;
       tmp = *this; 
       tmp += rhs; 
       return tmp; 
    };


    // Operator -=, -
    inline x_complex<T>& operator-= (const T& rhs) {
      re -= rhs; 
      return *this;
    }
    inline x_complex<T>& operator-= (const x_complex<T>& rhs) {
      re -= rhs.real();
      im -= rhs.imag(); 
      return *this; 
    };
    template<typename T2>
    inline x_complex<T>& operator-= (const x_complex<T2>& rhs) {
      re -= rhs.real();
      im -= rhs.imag();
      return *this;
    };
    
    inline x_complex<T>  operator- (const T& rhs) {
      x_complex<T> tmp ;
      tmp = *this; 
      tmp -= rhs; 
      return tmp; 
    };
    inline x_complex<T>  operator- (const x_complex<T>& rhs) {
      x_complex<T> tmp ;
      tmp = *this; 
      tmp -= rhs; 
      return tmp; 
    };
    template<typename T2>
    inline x_complex<T>  operator- (const x_complex<T2>& rhs) {
      x_complex<T> tmp ;
      tmp = *this; 
      tmp -= rhs; 
      return tmp; 
    };
    // neg
    inline x_complex<T> operator- () {
      x_complex<T> tmp(*this);
      tmp.real(-real());
      tmp.imag(-imag());
      return tmp;
    };

  // std::x_complex --> hls::x_complex  
  x_complex<T> &operator=(const std::complex<T> &t) {
    re = t.real();
    im = t.imag();
    return *this;
  }
  // hls::x_complex --> std::x_complex  
  operator std::complex<T> () const {
    return std::complex<T>(re, im); 
  }

  std::complex<T> to_std_complex(){
     return std::complex<T>(re ,im);
  } 

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

  template<typename T>
  x_complex<T> x_neg(x_complex<T> &din) {
    x_complex<T> tmp;
    tmp.real(-din.real());
    tmp.imag(-din.imag());
    return(tmp);
  }

  template<typename T>
  x_complex<T> x_conj_sq(x_complex<T> &din) {
    x_conj_sq_complex:;
    return ( (din.real()*din.real()) + (din.imag()*din.imag()));
  }

  template<typename T>
  x_complex<T> x_conj(const x_complex<T> &din) {
    x_conj_complex:;
    x_complex<T> tmp;
    tmp.real(din.real());
    tmp.imag(-din.imag());
    return(tmp);
  }

  // This function is called when a non-const x_complex is conjugated.  It calls the
  // version of x_conj() which takes a constant parameter
  template<typename T> 
  x_complex<T> x_conj(x_complex<T> &din) {
    const x_complex<T> tmp = din;
    return(x_conj(tmp));
  }

  template<int W, int I> void set_to_one(x_complex<ap_fixed<W,I> > &a) {
    ap_int<W> tmp_sat = ((ap_int<W-I+1>)1<<(W-I)) - 1;
    ap_fixed<W,I> tmp;
    tmp.range() = tmp_sat;
    a = tmp;
  }

  template<typename T>
  T x_real(const x_complex<T> &din) {
    return(din.real());
  }

  template<typename T>
  T x_imag(const x_complex<T> &din) {
    return(din.imag());
  }
  
  template<typename T1> 
  typename x_complex<T1>::MULT_RT operator* (const T1& lhs, x_complex<T1>& rhs) {
    return (rhs*lhs); // Flip direction and re-use complex class defined operator
  }

} // end namespace hls

#endif



